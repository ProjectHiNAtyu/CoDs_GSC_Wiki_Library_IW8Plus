// scripts\mp\spawnselection.gsc  (hash_08f3cb4dbabae3a5.gscc) (size: 55270 Bytes / 0xd7e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4fd5a4d7 (1339401431)
// size ...... 55270 (0xd7e6)
// includes .. 33  (offset: 0xcd76)
// strings ... 118 (offset: 0xce7e)
// dev strs .. 22  (offset: 0xd6c2)
// exports ... 111 (offset: 0x982e)
// cseg ...... 0x93c + 0x8ef2 (0x982e)
// imports ... 267 (offset: 0xa986)
// animtree1 . 0   (offset: 0xd7e6)
// animtree2 . 0   (offset: 0xd7e6)
#using script_3cb3908b3094b567;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\flashpoint;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;

#namespace spawnselection;

// Namespace spawnselection
// Params 0
// Checksum 0xe5c83457, Offset: 0x95a
// Size: 0x371
function init()
{
    if ( function_fc43ecf617088f49() )
    {
        level.disablespawncamera = 0;
    }
    else
    {
        return;
    }
    
    level.usec130spawn = getdvarint( @"scr_game_c130_spawn", 0 ) == 1;
    level.usesquadspawn = getdvarint( @"scr_game_squad_spawn", 0 ) == 1;
    level.usesquadspawnselection = getdvarint( @"scr_game_spawnselection_squad", 0 ) == 1;
    level.spawnsquadleaderonly = getdvarint( @"hash_fc11053944ab5f7e", 0 ) == 1;
    level.var_ca9cd60625bc5c46 = getdvarfloat( @"scr_game_squad_spawn_delay", 0 ) * 1000;
    var_54bb65bdf7ab915b = getdvarfloat( @"hash_ac1ee8728b72ea17", 0 );
    level.var_707d78245a70bb4b = var_54bb65bdf7ab915b * var_54bb65bdf7ab915b;
    
    if ( level.usesquadspawn || level.usesquadspawnselection )
    {
        assert( level.disablebuddyspawn == 0, "<dev string:x24>" );
    }
    
    level.var_c7ee15f38250df88 = getdvarint( @"hash_ee75f0b9d9e03349", 1 ) == 1;
    level.var_b17e4d64b50fbb75 = getdvarint( @"hash_ef54007b614237da", 0 ) == 1;
    level.var_59223059bc1245ed = getdvarint( @"hash_8fe41b9ffb4e54aa", 1 ) == 1;
    level.var_3bc45e5a882b3afe = getdvarint( @"hash_537448d6935dd02b", 1 ) == 1;
    level.var_bd3402b82093cbcb = &function_341fbb6914aa9273;
    level.var_755abfee30d6b33c = &function_6fbe1a9ef2181384;
    level.checkspawnselectionafk = game_utility_mp::matchmakinggame() && getdvarint( @"scr_game_spawnselection_afk", 1 ) == 1;
    level.var_5910bcf721f1fb82 = getdvarint( @"hash_6560b9b4c5fcbab", 1 ) == 1;
    level.var_30ef0c9dad3fee3f = getdvarint( @"hash_9fe20711e5bcee42", 0 ) == 1;
    level.var_3c8ebf4a9cf1ce7 = getdvarint( @"hash_a959156dff929a38", 1 ) == 1;
    level.var_1c6cad52ab5e029f = getdvarint( @"hash_4ce0b40aac178e56", 0 ) == 1;
    level.var_3a7ca7dc68b5fd5 = getdvarfloat( @"scr_spawnselection_obj_owned_partial_pct", 0 );
    level.var_ebc62cab82a88b33 = getdvarint( @"hash_8e9e98f013db1ac4", 1 ) == 1;
    level.var_f14d7a22b282f31e = getdvarint( @"hash_78cc7f1b463b206c", 0 ) == 1;
    level.var_12b63dd9890dabcc = getdvarint( @"hash_94be38a738c141bb", 1 ) == 1;
    level.availablespawnlocations = [];
    
    foreach ( entry in level.teamnamelist )
    {
        level.availablespawnlocations[ entry ] = [];
    }
    
    if ( !isdefined( level.var_e91f2ef9c58faa7c ) )
    {
        level.var_e91f2ef9c58faa7c = &canusespawnselection;
    }
    
    if ( !isdefined( level.var_48c40996b7e17ec1 ) )
    {
        level.var_48c40996b7e17ec1 = &function_ab15caae87937031;
    }
    
    level thread initspawns();
    ui::lui_registercallback( "tac_ops_spawn_focus_changed", &endcondition_focuschanged );
    callback::add( #"player_connect_start", &callback_playerconnect_spawnselect );
    
    /#
        callback::add( #"player_spawned", &function_b32768f992d1c069 );
    #/
}

// Namespace spawnselection
// Params 1
// Checksum 0x999ebcaa, Offset: 0xcd3
// Size: 0xc6
function callback_playerconnect_spawnselect( params )
{
    if ( level.usespawnselection && isdefined( self.sessionteam ) && flags::gameflag( "prematch_done" ) )
    {
        if ( self.sessionteam == "allies" )
        {
            ref = "gw_fob_alliesHQ";
            spawncam = level.spawncameras[ ref ][ "allies" ];
            self function_eceef703be8d89c3( spawncam.origin );
            return;
        }
        
        if ( self.sessionteam == "axis" )
        {
            ref = "gw_fob_axisHQ";
            spawncam = level.spawncameras[ ref ][ "axis" ];
            self function_eceef703be8d89c3( spawncam.origin );
        }
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0x9799ca2, Offset: 0xda1
// Size: 0xde
function function_2f5f4ceceab0f826( ref )
{
    if ( !isdefined( level.var_a0ffef9899ccddba ) )
    {
        level.var_a0ffef9899ccddba = [];
    }
    
    if ( isdefined( level.var_a0ffef9899ccddba[ ref ] ) )
    {
        return level.var_a0ffef9899ccddba[ ref ];
    }
    
    if ( isdefined( level.localeid ) )
    {
        localeref = ref + "_" + level.localeid;
        index = function_43b5ed5a14a56573( #"hash_cb6f16d9beeda156", hashcat( %"hash_6285339188530bf9", localeref ) );
        
        if ( isdefined( index ) )
        {
            level.var_a0ffef9899ccddba[ ref ] = index;
            return index;
        }
    }
    
    index = function_43b5ed5a14a56573( #"hash_cb6f16d9beeda156", hashcat( %"hash_6285339188530bf9", ref ) );
    
    if ( isdefined( index ) )
    {
        level.var_a0ffef9899ccddba[ ref ] = index;
        return index;
    }
    
    return -1;
}

// Namespace spawnselection
// Params 0
// Checksum 0x6199f97, Offset: 0xe88
// Size: 0x4, Type: bool
function canusespawnselection()
{
    return true;
}

// Namespace spawnselection
// Params 1
// Checksum 0x5a44cb39, Offset: 0xe95
// Size: 0xd, Type: bool
function function_ab15caae87937031( player )
{
    return false;
}

// Namespace spawnselection
// Params 0
// Checksum 0x254e9a34, Offset: 0xeab
// Size: 0x2
function delayspawntoc130()
{
    
}

// Namespace spawnselection
// Params 0
// Checksum 0xae4fa05b, Offset: 0xeb5
// Size: 0x188
function churnareas()
{
    lanenames = [];
    lanenames[ 0 ] = "lane01_";
    lanenames[ 1 ] = "lane02_";
    lanenames[ 2 ] = "lane03_";
    alliesareas = [];
    alliesareas[ alliesareas.size ] = lanenames[ 0 ] + randomint( 3 ) + 1;
    alliesareas[ alliesareas.size ] = lanenames[ 1 ] + randomint( 3 ) + 1;
    alliesareas[ alliesareas.size ] = lanenames[ 2 ] + randomint( 3 ) + 1;
    setspawnlocations( alliesareas, "allies" );
    axisareas = [];
    axisareas[ alliesareas.size ] = lanenames[ 0 ] + randomint( 3 ) + 1;
    axisareas[ alliesareas.size ] = lanenames[ 1 ] + randomint( 3 ) + 1;
    axisareas[ alliesareas.size ] = lanenames[ 2 ] + randomint( 3 ) + 1;
    setspawnlocations( axisareas, "axis" );
    updatespawnareas();
    
    while ( true )
    {
        wait 10;
        alliesareas = [];
        alliesareas[ alliesareas.size ] = lanenames[ 0 ] + randomint( 3 ) + 1;
        alliesareas[ alliesareas.size ] = lanenames[ 1 ] + randomint( 3 ) + 1;
        alliesareas[ alliesareas.size ] = lanenames[ 2 ] + randomint( 3 ) + 1;
        setspawnlocations( alliesareas, "allies" );
        axisareas = [];
        axisareas[ axisareas.size ] = lanenames[ 0 ] + randomint( 3 ) + 1;
        axisareas[ axisareas.size ] = lanenames[ 1 ] + randomint( 3 ) + 1;
        axisareas[ axisareas.size ] = lanenames[ 2 ] + randomint( 3 ) + 1;
        setspawnlocations( axisareas, "axis" );
        updatespawnareas();
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0x1b3da2f3, Offset: 0x1045
// Size: 0x8f
function function_b1ab00964273cbbe( player )
{
    var_a9dd546210fe9a6e = level.availablespawnlocations[ player.team ];
    
    if ( level.var_945c61dea723591a && var_a9dd546210fe9a6e.size > 0 )
    {
        var_6fa03c18cb46cdee = [[ level.var_945c61dea723591a ]]( player );
        intersection = arrayintersection( var_6fa03c18cb46cdee, var_a9dd546210fe9a6e );
        assert( intersection.size > 0, "<dev string:x95>" + var_a9dd546210fe9a6e.size + "<dev string:xb1>" );
        return intersection;
    }
    
    return var_a9dd546210fe9a6e;
}

// Namespace spawnselection
// Params 2
// Checksum 0xc6690a09, Offset: 0x10dc
// Size: 0x1fc
function setspawnlocations( refarray, team )
{
    dynamiclocations = [];
    
    foreach ( loc in level.availablespawnlocations[ team ] )
    {
        if ( issubstr( loc, "dynamic" ) || issubstr( loc, "vehicle" ) || issubstr( loc, "squad" ) )
        {
            dynamiclocations[ dynamiclocations.size ] = loc;
        }
    }
    
    level.availablespawnlocations[ team ] = [];
    
    foreach ( ref in refarray )
    {
        if ( !arraycontains( level.availablespawnlocations[ team ], ref ) )
        {
            level.availablespawnlocations[ team ][ level.availablespawnlocations[ team ].size ] = ref;
        }
    }
    
    foreach ( ref in dynamiclocations )
    {
        if ( !arraycontains( level.availablespawnlocations[ team ], ref ) )
        {
            level.availablespawnlocations[ team ][ level.availablespawnlocations[ team ].size ] = ref;
        }
    }
}

// Namespace spawnselection
// Params 3
// Checksum 0xf2b42595, Offset: 0x12e0
// Size: 0x70
function allowspawnlocation( ref, team, validate = 0 )
{
    if ( validate && !level.spawnselectionlocations[ ref ][ team ] )
    {
        return;
    }
    
    if ( !arraycontains( level.availablespawnlocations[ team ], ref ) )
    {
        level.availablespawnlocations[ team ][ level.availablespawnlocations[ team ].size ] = ref;
    }
}

// Namespace spawnselection
// Params 2
// Checksum 0xae8b2a85, Offset: 0x1358
// Size: 0x33
function removespawnlocation( ref, team )
{
    level.availablespawnlocations[ team ] = arrayremove( level.availablespawnlocations[ team ], ref );
}

// Namespace spawnselection
// Params 0
// Checksum 0xa22d697a, Offset: 0x1393
// Size: 0xe
function updatespawnareas()
{
    level notify( #"tac_ops_map_changed" );
}

// Namespace spawnselection
// Params 0
// Checksum 0x929ee832, Offset: 0x13a9
// Size: 0x65
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    
    if ( !isdefined( level.var_66c9b0323a121db5 ) )
    {
        level.var_66c9b0323a121db5 = &setupspawnlocations;
    }
    
    [[ level.var_66c9b0323a121db5 ]]();
    
    if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || game_utility::getgametype() == "bigctf" )
    {
        setupspawninfluencezones();
    }
}

// Namespace spawnselection
// Params 6
// Checksum 0xdb783f7, Offset: 0x1416
// Size: 0xae
function function_a94137c3c19e4581( spawngroup, ref, objectivekey, team, origin, var_e64f7599f77bea6 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    struct = spawnstruct();
    struct.spawngroup = spawngroup;
    struct.typeref = ref;
    struct.objectivekey = objectivekey;
    struct.team = team;
    struct.origin = origin;
    struct.var_e64f7599f77bea6 = var_e64f7599f77bea6;
    initspawnarea( struct );
}

// Namespace spawnselection
// Params 0
// Checksum 0xd3108578, Offset: 0x14cc
// Size: 0x538
function setupspawnlocations()
{
    if ( level.updatedinit )
    {
        return;
    }
    
    while ( !isdefined( level.gamemodespawnpointnames ) )
    {
        waitframe();
    }
    
    foreach ( entry in level.teamnamelist )
    {
        spawns = spawnlogic::getspawnpointarray( level.gamemodespawnpointnames[ entry ] );
        spawnlogic::function_256bea3c722e022( entry, spawns );
        
        foreach ( s in spawns )
        {
            if ( !isdefined( s.target ) || s.target == "" )
            {
                continue;
            }
            
            targets = getentarray( s.target, #targetname );
            
            if ( !isdefined( targets ) || targets.size == 0 )
            {
                targets = utility::getstructarray( s.target, "targetname" );
            }
            
            if ( targets.size == 0 )
            {
                continue;
            }
            
            target = undefined;
            
            if ( targets.size == 1 )
            {
                target = targets[ 0 ];
            }
            else if ( isdefined( game_utility::getlocaleid() ) )
            {
                foreach ( ent in targets )
                {
                    if ( ent.script_noteworthy == level.localeid )
                    {
                        target = ent;
                        break;
                    }
                }
            }
            else
            {
                closestdistsq = undefined;
                
                foreach ( ent in targets )
                {
                    distsq = distancesquared( s.origin, ent.origin );
                    
                    if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
                    {
                        target = ent;
                        closestdistsq = distsq;
                    }
                }
            }
            
            if ( !isdefined( target ) )
            {
                continue;
            }
            
            ref = target.script_label;
            team = entry;
            
            if ( isdefined( target.script_team ) && team_utility::isgameplayteam( target.script_team ) )
            {
                if ( game_utility::getmapname() == "mp_quarry2" && target.targetname == "gw_fob_03_safe_axis" )
                {
                    team = "axis";
                }
                else if ( team == "team_three" || team == "team_four" )
                {
                }
                else
                {
                    team = target.script_team;
                }
            }
            
            if ( isdefined( level.spawnselectionlocations[ ref ] ) && isdefined( level.spawnselectionlocations[ ref ][ team ] ) )
            {
                loc = level.spawnselectionlocations[ ref ][ team ];
                
                if ( !arraycontains( loc.spawnpoints, s ) )
                {
                    loc.spawnpoints[ loc.spawnpoints.size ] = s;
                }
                
                continue;
            }
            
            struct = spawnstruct();
            struct.typeref = ref;
            struct.team = team;
            struct.origin = target.origin;
            struct.var_e64f7599f77bea6 = ( 0, 0, 100 );
            struct.spawnpoints = [];
            struct.spawnpoints[ 0 ] = s;
            
            if ( !issubstr( ref, "safe" ) )
            {
                initspawnarea( struct );
                continue;
            }
            
            level.spawnselectionlocations[ ref ][ team ] = struct;
        }
        
        foreach ( key, teamarray in level.spawnselectionlocations )
        {
            if ( isdefined( teamarray[ entry ] ) )
            {
                spawnlogic::registerspawnset( key + "_" + entry, teamarray[ entry ].spawnpoints );
            }
        }
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0xded3a551, Offset: 0x1a0c
// Size: 0x1e1
function initspawnarea( struct )
{
    if ( !isdefined( level.spawnselectionlocations ) )
    {
        level.spawnselectionlocations = [];
    }
    
    reflookup = struct.typeref;
    typeid = function_2f5f4ceceab0f826( reflookup );
    assert( typeid >= 0, "<dev string:x103>" + reflookup + "<dev string:x133>" );
    anchorent = spawn( "script_model", struct.origin + struct.var_e64f7599f77bea6 );
    anchorent setmodel( "tag_origin" );
    struct.anchorentity = anchorent;
    struct.typeid = typeid;
    
    if ( !issubstr( struct.typeref, "HQ" ) && !issubstr( struct.typeref, "vehicle" ) )
    {
        var_c35f0222eb6f7e23 = undefined;
        
        if ( isdefined( level.localeid ) )
        {
            var_c35f0222eb6f7e23 = getlabelid( struct.typeref + "_" + level.localeid );
        }
        
        if ( !isdefined( var_c35f0222eb6f7e23 ) || var_c35f0222eb6f7e23 == -1 )
        {
            struct.labelid = typeid;
        }
        else
        {
            struct.labelid = var_c35f0222eb6f7e23;
        }
    }
    else
    {
        struct.labelid = typeid;
    }
    
    if ( isdefined( struct.dynamicent ) )
    {
        anchorent linkto( struct.dynamicent );
    }
    
    level.spawnselectionlocations[ struct.typeref ][ struct.team ] = struct;
    level.usespawnselection = function_fc43ecf617088f49() && level.spawnselectionlocations.size > 0;
    
    if ( level.usespawnselection )
    {
        level.getspawnpoint = &getspawnpoint;
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0xf152599e, Offset: 0x1bf5
// Size: 0x2a
function getlabelid( ref )
{
    labelid = function_2f5f4ceceab0f826( ref );
    
    if ( !isdefined( labelid ) )
    {
        labelid = 0;
    }
    
    return labelid;
}

// Namespace spawnselection
// Params 3
// Checksum 0x7919057b, Offset: 0x1c28
// Size: 0x38
function setanchorent( ref, team, ent )
{
    level.spawnselectionlocations[ ref ][ team ].anchorentity = ent;
}

// Namespace spawnselection
// Params 0
// Checksum 0xfbe3f2c1, Offset: 0x1c68
// Size: 0x85
function setupspawninfluencezones()
{
    level.spawninfluencezones = [];
    
    for ( i = 1; i <= 5 ; i++ )
    {
        trigger = game_utility::getlocaleent( "gw_fob_0" + i + "_spawnInfluenceZone" );
        
        if ( !isdefined( trigger ) )
        {
            continue;
        }
        
        trigger::makeenterexittrigger( trigger, &spawninfluencezone_onusebegin, &spawninfluencezone_onuseend );
        trigger.touchlist = [];
        level.spawninfluencezones[ "gw_fob_0" + i ] = trigger;
    }
}

// Namespace spawnselection
// Params 2
// Checksum 0xf6ed6660, Offset: 0x1cf5
// Size: 0x45
function spawninfluencezone_onusebegin( ent, trigger )
{
    if ( ent.classname == "script_vehicle" )
    {
        return;
    }
    
    trigger.touchlist[ trigger.touchlist.size ] = ent;
}

// Namespace spawnselection
// Params 2
// Checksum 0x17f84977, Offset: 0x1d42
// Size: 0x47
function spawninfluencezone_onuseend( ent, trigger )
{
    if ( ent.classname == "script_vehicle" )
    {
        return;
    }
    
    trigger.touchlist = arrayremove( trigger.touchlist, ent );
}

// Namespace spawnselection
// Params 1
// Checksum 0x1532ad79, Offset: 0x1d91
// Size: 0xc5
function isteamtouching( team )
{
    found = 0;
    validtouchlist = [];
    
    foreach ( entry in self.touchlist )
    {
        if ( !isdefined( entry ) )
        {
            continue;
        }
        
        if ( entry.team == team )
        {
            found = 1;
        }
        
        validtouchlist[ validtouchlist.size ] = entry;
    }
    
    self.touchlist = validtouchlist;
    return found;
}

// Namespace spawnselection
// Params 1
// Checksum 0x83012cff, Offset: 0x1e5f
// Size: 0x84, Type: bool
function function_d3a9fc8fb733aee8( teams )
{
    foreach ( team in teams )
    {
        if ( isteamtouching( team ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace spawnselection
// Params 0
// Checksum 0x87111e95, Offset: 0x1eec
// Size: 0xd38
function getspawnpoint()
{
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( !spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::deactivateallspawnsets();
        
        if ( spawnlogic::shoulduseteamstartspawn() )
        {
            spawnpoints = spawnlogic::getspawnpointarray( level.gamemodestartspawnpointnames[ self.team ] );
            spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints );
            return spawnpoint;
        }
    }
    else if ( spawnlogic::shoulduseteamstartspawn() )
    {
        return spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    
    spawnpoint = undefined;
    self.wassquadspawned = 0;
    
    if ( isdefined( self.selectedspawnarea ) )
    {
        player::printspawnmessage( "spawnSelection::getSpawnPoint() = " + self.selectedspawnarea );
        
        if ( issubstr( self.selectedspawnarea, "squad" ) )
        {
            index = undefined;
            
            if ( self.selectedspawnarea == "squad_leader" )
            {
                index = level.squaddata[ self.team ][ self.sessionsquadid ].squadleader.sessionuimemberindex;
            }
            else
            {
                index = int( getsubstr( self.selectedspawnarea, self.selectedspawnarea.size - 1, self.selectedspawnarea.size ) );
            }
            
            teammate = level.squaddata[ self.team ][ self.sessionsquadid ].players[ index ];
            spawnpoint = spawnscoring::findteammatebuddyspawn( teammate );
            teammate thread points::doscoreevent( #"squad_spawn" );
            thread points::doscoreevent( #"squad_spawn_self" );
            self.wassquadspawned = 1;
            
            if ( isdefined( teammate.vehicle ) )
            {
                self.spawningintovehicle = 1;
                self.vehiclespawninginto = teammate.vehicle vehicle::get_ref();
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "spawnSelectSquad" ] ) )
                {
                    self.leaderboarddata[ "spawnSelectSquad" ] = self.leaderboarddata[ "spawnSelectSquad" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "spawnSelectSquad" ] ) )
                {
                    [[ level.leaderboardfunc[ "spawnSelectSquad" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x135>" );
                
                if ( isdefined( self.pers[ "spawnSelectSquad" ] ) )
                {
                    self.pers[ "spawnSelectSquad" ] = self.pers[ "spawnSelectSquad" ] + 1;
                }
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( teammate ) ) )
            {
                if ( isdefined( teammate.leaderboarddata[ "timesSelectedAsSquadLeader" ] ) )
                {
                    teammate.leaderboarddata[ "timesSelectedAsSquadLeader" ] = teammate.leaderboarddata[ "timesSelectedAsSquadLeader" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "timesSelectedAsSquadLeader" ] ) )
                {
                    [[ level.leaderboardfunc[ "timesSelectedAsSquadLeader" ] ]]( teammate, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x135>" );
                
                if ( isdefined( teammate.pers[ "timesSelectedAsSquadLeader" ] ) )
                {
                    teammate.pers[ "timesSelectedAsSquadLeader" ] = teammate.pers[ "timesSelectedAsSquadLeader" ] + 1;
                }
            }
        }
        else if ( issubstr( self.selectedspawnarea, "dynamic" ) )
        {
            if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
            {
                spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self );
            }
            else
            {
                spawnpoint = spawnlogic::getspawnpointlegacy( self, self.team, undefined, undefined, 2 );
            }
            
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_fb347c5f16116383" ][ #"hash_a1ad2f0217b6ce6f" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self thread [[ var_32dbca3143d9c4a5 ]]();
            }
        }
        else if ( issubstr( self.selectedspawnarea, "vehicle" ) )
        {
            vehicleent = level.spawnselectionlocations[ self.selectedspawnarea ][ self.team ].dynamicent;
            forwardoffset = -200;
            heightoffset = 64;
            spawnpoint = spawnstruct();
            spawnpoint.origin = vehicleent.origin + anglestoforward( vehicleent.angles ) * forwardoffset + ( 0, 0, heightoffset );
            spawnpoint.angles = ( 0, vehicleent.angles[ 1 ], 0 );
            spawnpoint.index = -1;
            spawnpoint.isdynamicspawn = 1;
            spawnpoint spawnlogic::spawnpointinit();
            seat = vehicle_occupancy::function_495d488c998ad412( vehicleent );
            
            if ( isdefined( seat ) && vehicle_interact::vehicle_can_be_used( vehicleent ) && ( vehicle_spawn::get_data( vehicleent vehicle::get_ref() ).var_2a99601c04eec8f0 || seat == "driver" ) )
            {
                data = spawnstruct();
                data.useonspawn = 1;
                data.enterstartwaitmsg = "spawned_player";
                thread vehicle_occupancy::enter( vehicleent, seat, self, data );
            }
            else
            {
                exitboundinginfo = vehicle_occupancy::get_exit_info( vehicleent );
                occupancydata = vehicle_occupancy::get_data( vehicleent vehicle::get_ref() );
                var_9989cf5ea2dc4b23 = 0;
                
                foreach ( ref, direction in occupancydata.exitdirections )
                {
                    if ( direction == "top" || direction == "inside" )
                    {
                        position = vehicle_occupancy::get_exit_position( vehicleent, self, ref, exitboundinginfo, 1 );
                        exitoffset = occupancydata.exitoffsets[ ref ];
                        
                        if ( isdefined( position.origin ) )
                        {
                            spawnpoint.origin = position.origin;
                            self.var_52451a3506366553 = vehicleent;
                            self.platformoffset = exitoffset;
                            thread vehicle_collision::function_e3bc60c772acd609( vehicleent, self );
                            break;
                        }
                        
                        if ( !var_9989cf5ea2dc4b23 )
                        {
                            var_9989cf5ea2dc4b23 = 1;
                            leveldataforvehicle = vehicle_occupancy::get_data( vehicleent vehicle::get_ref() );
                            exitoffset = leveldataforvehicle.exitoffsets[ ref ];
                            spawnpoint.origin = vehicleent.origin + rotatevector( exitoffset, vehicleent.angles );
                            self.var_52451a3506366553 = vehicleent;
                            self.platformoffset = exitoffset;
                            thread vehicle_collision::function_e3bc60c772acd609( vehicleent, self );
                        }
                    }
                }
            }
            
            driver = vehicle_occupancy::get_driver( vehicleent );
            vehicleref = vehicleent vehicle::get_ref();
            var_56f62125618a0d22 = vehicle_spawn::get_data( vehicleref ).var_aedbe1cdb3788a8f;
            
            if ( isdefined( driver ) && isdefined( var_56f62125618a0d22 ) && var_56f62125618a0d22 != "" )
            {
                driver thread points::doscoreevent( getxhash( var_56f62125618a0d22 ) );
            }
            
            self.spawningintovehicle = 1;
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "spawnSelectVehicle" ] ) )
                {
                    self.leaderboarddata[ "spawnSelectVehicle" ] = self.leaderboarddata[ "spawnSelectVehicle" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "spawnSelectVehicle" ] ) )
                {
                    [[ level.leaderboardfunc[ "spawnSelectVehicle" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x135>" );
                
                if ( isdefined( self.pers[ "spawnSelectVehicle" ] ) )
                {
                    self.pers[ "spawnSelectVehicle" ] = self.pers[ "spawnSelectVehicle" ] + 1;
                }
            }
        }
        else if ( self.selectedspawnarea == "tac_insert" )
        {
            if ( isdefined( self.setspawnpoint ) )
            {
                self.ti_spawn = 1;
                spawnpoint = self.setspawnpoint;
            }
        }
        else if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
        {
            if ( isdefined( level.spawnselectionlocations[ self.selectedspawnarea ][ self.team ].spawngroup ) )
            {
                spawngroup = level.spawnselectionlocations[ self.selectedspawnarea ][ self.team ].spawngroup;
            }
            
            spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self, undefined, spawngroup );
        }
        else
        {
            if ( isdefined( level.spawninfluencezones ) )
            {
                trigger = undefined;
                keys = getarraykeys( level.spawninfluencezones );
                
                foreach ( key in keys )
                {
                    if ( key == self.selectedspawnarea )
                    {
                        trigger = level.spawninfluencezones[ key ];
                    }
                }
                
                if ( isdefined( trigger ) && trigger function_d3a9fc8fb733aee8( team_utility::getenemyteams( self.team ) ) )
                {
                    ref = self.selectedspawnarea + "_safe_" + self.team;
                    spawnset = level.spawnglobals.spawnsets[ ref ];
                    
                    if ( !isdefined( spawnset ) )
                    {
                        spawnset = self.selectedspawnarea + "_" + self.team;
                    }
                }
                else
                {
                    spawnset = self.selectedspawnarea + "_" + self.team;
                }
            }
            else
            {
                spawnset = self.selectedspawnarea + "_" + self.team;
            }
            
            spawnlogic::activatespawnset( spawnset, 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, self.team, undefined, undefined, 2 );
            
            if ( issubstr( self.selectedspawnarea, "alliesHQ" ) || issubstr( self.selectedspawnarea, "axisHQ" ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
                {
                    if ( isdefined( self.leaderboarddata[ "spawnSelectBase" ] ) )
                    {
                        self.leaderboarddata[ "spawnSelectBase" ] = self.leaderboarddata[ "spawnSelectBase" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "spawnSelectBase" ] ) )
                    {
                        [[ level.leaderboardfunc[ "spawnSelectBase" ] ]]( self, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x135>" );
                    
                    if ( isdefined( self.pers[ "spawnSelectBase" ] ) )
                    {
                        self.pers[ "spawnSelectBase" ] = self.pers[ "spawnSelectBase" ] + 1;
                    }
                }
            }
            else if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "spawnSelectFlag" ] ) )
                {
                    self.leaderboarddata[ "spawnSelectFlag" ] = self.leaderboarddata[ "spawnSelectFlag" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "spawnSelectFlag" ] ) )
                {
                    [[ level.leaderboardfunc[ "spawnSelectFlag" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x135>" );
                
                if ( isdefined( self.pers[ "spawnSelectFlag" ] ) )
                {
                    self.pers[ "spawnSelectFlag" ] = self.pers[ "spawnSelectFlag" ] + 1;
                }
            }
        }
    }
    else if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self );
    }
    else
    {
        spawnpoint = spawnlogic::getspawnpointlegacy( self, self.team, undefined, undefined, 2 );
    }
    
    if ( level.usesquadspawn && self.squadspawnconfirmed )
    {
        spectatingteammate = self getspectatingplayer();
        
        if ( isdefined( spectatingteammate ) && self.team == spectatingteammate.team && self.sessionsquadid == spectatingteammate.sessionsquadid )
        {
            spawnpoint = spawnscoring::findteammatebuddyspawn( spectatingteammate );
            spectatingteammate thread points::givexpwithtext( #"squad_spawn" );
            thread points::givexpwithtext( #"squad_spawn_self" );
            self.wassquadspawned = 1;
        }
    }
    
    return spawnpoint;
}

// Namespace spawnselection
// Params 0
// Checksum 0xbf1e4d3d, Offset: 0x2c2d
// Size: 0x6a
function refreshplayerspawnareaomnvars()
{
    for ( var_be4def0ffcb9d1e8 = 0; var_be4def0ffcb9d1e8 < 16 ; var_be4def0ffcb9d1e8++ )
    {
        self setclientomnvar( "ui_tom_spawn_entity_" + var_be4def0ffcb9d1e8, undefined );
        self setclientomnvar( "ui_tom_spawn_id_" + var_be4def0ffcb9d1e8, -1 );
    }
    
    thread evaluatefobspawns();
    
    if ( level.usesquadspawnselection )
    {
        thread evaluatesquadspawn();
    }
    
    if ( isdefined( self.setspawnpoint ) )
    {
        thread function_e5dc4be25d30f851();
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x88d80310, Offset: 0x2c9f
// Size: 0x425
function evaluatefobspawns()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self notify( #"hash_35075eb7856601b5" );
    self endon( #"hash_35075eb7856601b5" );
    var_1d21c16618fdae1f = [];
    
    while ( true )
    {
        var_6fa03c18cb46cdee = function_b1ab00964273cbbe( self );
        
        if ( var_1d21c16618fdae1f.size > var_6fa03c18cb46cdee.size )
        {
            thread refreshplayerspawnareaomnvars();
            return;
        }
        
        index = 0;
        
        foreach ( entry in var_6fa03c18cb46cdee )
        {
            if ( !isdefined( var_1d21c16618fdae1f[ index ] ) )
            {
                break;
            }
            
            if ( var_1d21c16618fdae1f[ index ].location != entry )
            {
                thread refreshplayerspawnareaomnvars();
                return;
            }
            
            index++;
        }
        
        index = 0;
        
        foreach ( entry in var_6fa03c18cb46cdee )
        {
            selected = level.spawnselectionlocations[ entry ][ self.team ];
            
            if ( index == var_1d21c16618fdae1f.size )
            {
                data = spawnstruct();
                data.location = undefined;
                data.entity = undefined;
                data.id = undefined;
                var_1d21c16618fdae1f[ var_1d21c16618fdae1f.size ] = data;
            }
            
            if ( !isdefined( var_1d21c16618fdae1f[ index ].location ) )
            {
                var_1d21c16618fdae1f[ index ].location = entry;
            }
            
            if ( !isdefined( var_1d21c16618fdae1f[ index ].entity ) )
            {
                var_1d21c16618fdae1f[ index ].entity = selected.anchorentity;
                self setclientomnvar( "ui_tom_spawn_entity_" + index, selected.anchorentity );
            }
            
            indanger = 0;
            isowned = 0;
            containssquadmates = 0;
            vehicleisfull = 0;
            
            if ( isdefined( selected.objectivekey ) )
            {
                indanger = istrue( selected.indanger );
                isowned = level.objectives[ selected.objectivekey ].ownerteam == self.team;
            }
            else if ( issubstr( entry, "vehicle" ) )
            {
                vehent = selected.dynamicent;
                
                if ( isdefined( vehent ) && !vehent.isdestroyed )
                {
                    indanger = istrue( vehent.indanger );
                    containssquadmates = hassquadmatepassengers( vehent, self );
                    
                    if ( vehicle_occupancy::function_41d81defa67de264( vehent ).size == 0 || !vehicle_interact::vehicle_can_be_used( vehent ) )
                    {
                        vehicleisfull = 1;
                    }
                }
            }
            
            id = selected.labelid;
            assert( id < 128, "<dev string:x15b>" + entry + "<dev string:x171>" + id + "<dev string:x180>" + 128 + "<dev string:x19f>" );
            
            if ( indanger )
            {
                id += 128;
            }
            
            if ( isowned )
            {
                id += 256;
            }
            
            if ( vehicleisfull )
            {
                id += 1024;
            }
            
            if ( containssquadmates )
            {
                id += 2048;
            }
            
            if ( isdefined( selected.objectivekey ) && !issubstr( selected.objectivekey, "HQ" ) )
            {
                id += 32768;
                objectiveindex = level.objectives[ selected.objectivekey ].objidnum;
                id += objectiveindex << 16;
            }
            
            if ( var_1d21c16618fdae1f[ index ].id != id )
            {
                var_1d21c16618fdae1f[ index ].id = id;
                self setclientomnvar( "ui_tom_spawn_id_" + index, id );
            }
            
            index++;
        }
        
        waitframe();
    }
}

// Namespace spawnselection
// Params 2
// Checksum 0xbebbdb73, Offset: 0x30cc
// Size: 0x222, Type: bool
function isobjectiveindanger( objectivekey, team )
{
    obj = level.objectives[ objectivekey ];
    
    if ( obj.id == "bomb_zone" )
    {
        if ( level.var_3416583522672ad3 )
        {
            return ( team != obj.ownerteam );
        }
        else
        {
            return false;
        }
    }
    else if ( obj.id == "defuse_object" )
    {
        if ( !level.var_4ef3f193ae5be5d2 )
        {
            return true;
        }
        
        if ( level.var_ebc62cab82a88b33 )
        {
            return ( team != obj.ownerteam );
        }
        
        checkpct = level.var_3a7ca7dc68b5fd5 > 0;
        allowpercent = obj.var_76c0308f4e309c6 <= level.var_3a7ca7dc68b5fd5;
        
        if ( checkpct )
        {
            return !allowpercent;
        }
        else
        {
            return false;
        }
    }
    else if ( obj.id == "destroyed_site" )
    {
        return false;
    }
    else
    {
        if ( level.var_f14d7a22b282f31e )
        {
            return false;
        }
        
        claimteam = gameobjects_shared::function_d071a38f7d43555a( obj );
        var_edcf452f0e266383 = gameobjects_shared::function_623b07f4735aecb2( obj ) != team;
        iscontested = !level.var_5910bcf721f1fb82 && gameobjects_shared::function_3d275bfdb7872815( obj );
        isbeingcaptured = !level.var_3c8ebf4a9cf1ce7 && claimteam != "none" && claimteam != team;
        var_f6cfc1a07020747b = !level.var_1c6cad52ab5e029f && obj.spawnpointdanger;
        var_8b2dcd1728fedba1 = level.var_3a7ca7dc68b5fd5 > 0 && gameobjects_shared::get_use_progress( obj ) <= level.var_3a7ca7dc68b5fd5;
        ingraceperiod = level.ingraceperiod;
        
        if ( var_8b2dcd1728fedba1 )
        {
            iscontested = 0;
            isblocked = 0;
            isbeingcaptured = 0;
            isbeingcaptured = 0;
        }
        
        return ( var_edcf452f0e266383 || iscontested || isblocked || isbeingcaptured || var_f6cfc1a07020747b || ingraceperiod );
    }
    
    return false;
}

// Namespace spawnselection
// Params 1
// Checksum 0xdd13114c, Offset: 0x32f7
// Size: 0x172, Type: bool
function isvehicleindanger( vehent )
{
    currenttime = gettime();
    tookdamage = isdefined( vehent ) && isdefined( vehent.lasttimedamaged ) && vehent.lasttimedamaged + 5000 > currenttime;
    oob = istrue( vehent outofbounds::istouchingoobtrigger() );
    enemyinproximity = 0;
    
    if ( isdefined( vehent.team ) )
    {
        var_5e15774086898552 = utility::playersnear( vehent.origin, 384 );
        
        foreach ( player in var_5e15774086898552 )
        {
            if ( player.team != vehent.team && isalive( player ) && !isdefined( player.fauxdead ) )
            {
                if ( abs( vehent.origin[ 2 ] - player.origin[ 2 ] ) < 100 )
                {
                    enemyinproximity = 1;
                    break;
                }
            }
        }
    }
    
    return tookdamage || oob || enemyinproximity;
}

// Namespace spawnselection
// Params 0
// Checksum 0x33cb4286, Offset: 0x3472
// Size: 0x30
function function_fc43ecf617088f49()
{
    if ( !isdefined( level.usespawnselection ) )
    {
        level.usespawnselection = getdvarint( @"scr_game_usespawnselection", 0 ) != 0;
    }
    
    return level.usespawnselection;
}

// Namespace spawnselection
// Params 1
// Checksum 0x76988276, Offset: 0x34ab
// Size: 0x302
function vehicleindangertracking( vehent )
{
    vehent endon( #"death" );
    vehent.indanger = 0;
    ignoredamagethreshold = getdvarfloat( @"hash_b5bc6252b2764d8c", 0.15 );
    
    while ( true )
    {
        currenttime = gettime();
        burningdown = istrue( vehent.burningdown );
        missilelocked = weapon_utility::islockedonto( vehent );
        var_413cec19245deb41 = vehicle_occupancy::can_spawn_into( vehent );
        tookdamage = isdefined( vehent ) && isdefined( vehent.lasttimedamaged ) && vehent.lasttimedamaged + 5000 > currenttime;
        oob = istrue( vehent outofbounds::istouchingoobtrigger() );
        isbeached = 0;
        enemyinproximity = 0;
        
        if ( isdefined( vehent.team ) && vehent vehicle::get_ref() != %"hash_5d0aabf994c1e2ac" && vehent vehicle::get_ref() != %"hash_79d97f9d1822b8fc" && vehent vehicle::get_ref() != %"hash_57d0b185054b4bd4" )
        {
            var_5e15774086898552 = utility::playersnear( vehent.origin, 384 );
            
            foreach ( player in var_5e15774086898552 )
            {
                if ( player.team != vehent.team && isalive( player ) && !isdefined( player.fauxdead ) )
                {
                    if ( abs( vehent.origin[ 2 ] - player.origin[ 2 ] ) < 100 )
                    {
                        enemyinproximity = 1;
                        break;
                    }
                }
            }
        }
        
        if ( vehent vehicle::get_ref() == %"hash_5d0aabf994c1e2ac" || vehent vehicle::get_ref() == %"hash_79d97f9d1822b8fc" || vehent vehicle::get_ref() == %"hash_1dd941f8f4026e3" || vehent vehicle::get_ref() == %"hash_57d0b185054b4bd4" )
        {
            currenthealthpct = vehent.health / vehent.maxhealth;
            
            if ( currenthealthpct > ignoredamagethreshold )
            {
                tookdamage = 0;
            }
            
            missilelocked = 0;
        }
        else if ( vehent vehicle::get_ref() == %"hash_4c7e54cca5ad7fd8" )
        {
            isbeached = vehent vehicle_isonground();
        }
        
        vehent.indanger = tookdamage || oob || enemyinproximity || burningdown || missilelocked || !var_413cec19245deb41 || isbeached;
        waitframe();
    }
}

// Namespace spawnselection
// Params 2
// Checksum 0x3f8e8cb1, Offset: 0x37b5
// Size: 0x13a, Type: bool
function hassquadmatepassengers( vehicle, player )
{
    if ( !isdefined( level.squaddata ) )
    {
        return false;
    }
    
    squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    
    foreach ( occupant in vehicle.occupants )
    {
        foreach ( mate in squadmates )
        {
            if ( mate == occupant )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace spawnselection
// Params 2
// Checksum 0xd757b01f, Offset: 0x38f8
// Size: 0x1d6
function waitforspawnselection( timeuntilspawn, forcepick )
{
    if ( level.gameended || level.nukeinfo.detonated )
    {
        if ( level.var_a8116f75bf63f6f4 )
        {
            pickrandomspawn();
            return;
        }
        
        pickrandomnonvehiclespawn();
        return;
    }
    
    self endon( #"disconnect" );
    self.selectedspawnarea = undefined;
    refreshplayerspawnareaomnvars();
    getclosestavailablespawnlocation();
    
    if ( level.forcetopickafob )
    {
        timeuntilspawnmessaging( 1, level.var_791076e7de107dc2 );
        pickrandomnonvehiclespawn();
        return;
    }
    
    if ( level.var_4a5acde527614160 )
    {
        if ( [[ level.var_4a5acde527614160 ]]( self ) )
        {
            forcepick = 1;
        }
    }
    
    if ( isai( self ) || istestclient( self ) || self isplayerheadless() || isautopilot( self ) || self.pers[ #"hash_1d057e7863454d0e" ] )
    {
        forcepick = 1;
    }
    
    if ( forcepick )
    {
        if ( timeuntilspawn > 0 )
        {
            thread playerlogic::respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
        }
        
        timeuntilspawnmessaging( timeuntilspawn, level.var_791076e7de107dc2 );
        
        if ( spawnlogic::shoulduseteamstartspawn() )
        {
            return;
        }
        
        if ( level.var_48c40996b7e17ec1 && [[ level.var_48c40996b7e17ec1 ]]( self ) )
        {
            function_466fdbe72c636ea9();
        }
        
        if ( !self.selectedspawnarea )
        {
            if ( level.var_a8116f75bf63f6f4 )
            {
                pickrandomspawn();
                return;
            }
            
            pickrandomnonvehiclespawn();
        }
        
        return;
    }
    
    while ( !flags::gameflag( "prematch_done" ) )
    {
        waitframe();
    }
    
    self lerpfovscalefactor( 0, 0.2 );
    spawnselectionthink( timeuntilspawn );
    self lerpfovscalefactor( 1, 0.2 );
}

// Namespace spawnselection
// Params 0
// Checksum 0xbe7bf868, Offset: 0x3ad6
// Size: 0xc0
function pickrandomnonvehiclespawn()
{
    availablespawnlocations = function_b1ab00964273cbbe( self );
    var_6a592eedf11e13f9 = arrayrandomize( availablespawnlocations );
    
    foreach ( area in var_6a592eedf11e13f9 )
    {
        if ( issubstr( area, "fob" ) || issubstr( area, "HQ" ) )
        {
            if ( function_1a7699345629c241( area ) )
            {
                self.selectedspawnarea = area;
                return;
            }
        }
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0xd170c864, Offset: 0x3b9e
// Size: 0xc7
function pickrandomvehiclespawn( var_70c4f3ba479d9ee3 = "vehicle" )
{
    availablespawnlocations = function_b1ab00964273cbbe( self );
    var_6a592eedf11e13f9 = arrayrandomize( availablespawnlocations );
    
    foreach ( area in var_6a592eedf11e13f9 )
    {
        if ( issubstr( area, "vehicle" ) )
        {
            if ( function_1a7699345629c241( area ) )
            {
                self.selectedspawnarea = area;
                return;
            }
        }
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0xa11d628f, Offset: 0x3c6d
// Size: 0xa3
function pickrandomspawn()
{
    availablespawnlocations = function_b1ab00964273cbbe( self );
    var_6a592eedf11e13f9 = arrayrandomize( availablespawnlocations );
    
    foreach ( area in var_6a592eedf11e13f9 )
    {
        if ( function_1a7699345629c241( area ) )
        {
            self.selectedspawnarea = area;
            return;
        }
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x7c50508b, Offset: 0x3d18
// Size: 0x113
function function_466fdbe72c636ea9()
{
    var_1ff88300b89824ff = !isai( self );
    var_ec4ad3ebee3041a9 = getsquadspawnlocations( self.team, self.sessionsquadid );
    var_9ca1359308aa00e9 = arrayrandomize( var_ec4ad3ebee3041a9 );
    
    foreach ( loc in var_9ca1359308aa00e9 )
    {
        if ( !isdefined( loc.dynamicent ) )
        {
            continue;
        }
        
        if ( loc.dynamicent == self )
        {
            continue;
        }
        
        if ( !var_1ff88300b89824ff && isai( loc.dynamicent ) )
        {
            continue;
        }
        
        if ( !function_e921803cdda9ac1a( loc ) )
        {
            continue;
        }
        
        self.selectedspawnarea = loc.typeref;
        return;
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x7f0a8bf1, Offset: 0x3e33
// Size: 0xa4
function function_f85e21b80c9d3532()
{
    timeoutms = getdvarint( @"hash_b7cddbc61e64ed", 2000 );
    
    if ( !self.var_1715b56cfb17fa3e && flags::gameflag( "prematch_done" ) )
    {
        timeoutms = getdvarint( @"hash_a06dc2c4de808757", 9000 );
        self.var_1715b56cfb17fa3e = 1;
    }
    
    spawncamera = spawncamera::getspawncamera();
    streamorigin = streamhint::playerstreamhintlocation( spawncamera.origin, timeoutms );
    game_utility::fadetoblackforplayer( self, 1, 0 );
    streamhint::playerwaittillstreamhintcomplete();
    game_utility::fadetoblackforplayer( self, 0, 0.5 );
}

// Namespace spawnselection
// Params 1
// Checksum 0xfe82a9a4, Offset: 0x3edf
// Size: 0x2d7
function spawnselectionthink( timeuntilspawn )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    thread checkformatchend();
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        return;
    }
    
    if ( level.nukeinfo.detonated )
    {
        return;
    }
    
    if ( !self [[ level.var_e91f2ef9c58faa7c ]]() )
    {
        return;
    }
    
    class::loadout_clearperks();
    spawncamera::startspawncamera( 0, 0, 0, 1 );
    thread function_f85e21b80c9d3532();
    self.selectedspawnarea = undefined;
    self.inspawnselection = 1;
    self setclientomnvar( "ui_hide_objectives", 1 );
    thread selectiondelaymessaging( timeuntilspawn );
    
    if ( level.spawnselectionshowfriendly || level.spawnselectionshowenemy )
    {
        thread flashpoint::flashpoint_spawnselectionvfx();
    }
    
    if ( level.showteamtanks )
    {
        thread function_d39843733e6b342c();
    }
    
    wait 0.5;
    
    if ( isdefined( level.var_bd3402b82093cbcb ) )
    {
        self [[ level.var_bd3402b82093cbcb ]]();
    }
    
    self setclientomnvar( "ui_hide_objectives", 0 );
    self setclientomnvar( "ui_tac_ops_map_open", 1 );
    self.var_6adf2cb1ba606b3c = gettime();
    self cameralinkto( self.spawncameraent, "tag_origin", 1 );
    player::printspawnmessage( "spawnselection::spawnSelectionThink() CameraLinkTo()" );
    thread timeuntilspawnmessaging( timeuntilspawn, level.var_791076e7de107dc2 );
    thread selectionmade();
    self.abortspawncamera = 0;
    
    while ( true )
    {
        endcondition = watchendconditions();
        var_b152562d05857f12 = 1;
        
        switch ( endcondition )
        {
            case #"hash_2400cb6252980d91":
                var_b152562d05857f12 = 1;
                break;
            case #"hash_eccbb0b46937db3a":
                var_b152562d05857f12 = 0;
                refreshplayerspawnareaomnvars();
                break;
            case #"hash_d79f98d6ba6dd9de":
                var_b152562d05857f12 = 1;
                spawncamera::deletespawncamera();
                break;
            case #"hash_315ca762a236ee4b":
                var_b152562d05857f12 = 1;
                spawncamera::deletespawncamera();
                break;
            case #"hash_e73d5cfa4614c287":
                var_b152562d05857f12 = 1;
                spawncamera::deletespawncamera();
                break;
            case #"hash_8bfb9f6e1ffad7f4":
                var_b152562d05857f12 = 0;
                break;
            case #"hash_af2638e19142720b":
                var_b152562d05857f12 = 0;
                self setclientomnvar( "ui_hide_objectives", 1 );
                self setclientomnvar( "ui_tac_ops_map_open", 0 );
                thread spawnselectionshutdown_nuke();
                break;
            case #"hash_e3e8e9e8b2bb7b82":
                var_b152562d05857f12 = 1;
                self.abortspawncamera = 1;
                break;
            default:
                assertmsg( "<dev string:x1b9>" );
                break;
        }
        
        if ( var_b152562d05857f12 )
        {
            self notify( #"hash_bb960033f2d5e966" );
            self setclientomnvar( "ui_tac_ops_map_open", 0 );
            self.inspawnselection = 0;
            
            if ( isdefined( level.var_755abfee30d6b33c ) )
            {
                self [[ level.var_755abfee30d6b33c ]]();
            }
            
            return;
        }
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x56fb69e5, Offset: 0x41be
// Size: 0x37
function checkformatchend()
{
    self endon( #"hash_bb960033f2d5e966" );
    self endon( #"disconnect" );
    
    while ( !level.gameended )
    {
        waitframe();
    }
    
    self setclientomnvar( "ui_tac_ops_map_open", 0 );
}

// Namespace spawnselection
// Params 0, eflags: 0xc
// Checksum 0x1d180e1a, Offset: 0x41fd
// Size: 0x81
function private watchforafk()
{
    self notify( #"hash_b0634ddaebbe268c" );
    self endon( #"hash_b0634ddaebbe268c" );
    self endon( #"disconnect" );
    self endon( #"hash_bb960033f2d5e966" );
    
    if ( isdefined( level.spawnselectionafktime ) )
    {
        wait level.spawnselectionafktime;
    }
    else
    {
        wait 60;
    }
    
    kick_reason = "spawnselection::watchForAFK() - " + self.name + ", Player detected as AFK during spawn selection";
    mp_afk::function_a710eba86b2e3782( self, kick_reason, 2, 1 );
}

// Namespace spawnselection
// Params 1
// Checksum 0x195b22c4, Offset: 0x4286
// Size: 0xe2
function selectiondelaymessaging( timeuntilspawn )
{
    self endon( #"disconnect" );
    self.canprocessselection = 0;
    
    if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || game_utility::getgametype() == "gwbomb" || game_utility::getgametype() == "bigctf" )
    {
        self setclientomnvar( "ui_tom_respawnTimerActive", 1 );
    }
    
    if ( timeuntilspawn > 0 )
    {
        wait timeuntilspawn;
    }
    
    if ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || game_utility::getgametype() == "gwbomb" || game_utility::getgametype() == "bigctf" )
    {
        self setclientomnvar( "ui_tom_respawnTimerActive", 0 );
    }
    
    self.canprocessselection = 1;
    
    if ( isdefined( self.selectedspawnarea ) )
    {
        validateselectedspawnarea();
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x91ac7810, Offset: 0x4370
// Size: 0xa2
function validateselectedspawnarea()
{
    availablespawnlocations = function_b1ab00964273cbbe( self );
    
    foreach ( loc in availablespawnlocations )
    {
        if ( loc == self.selectedspawnarea )
        {
            self notify( #"tac_ops_map_selection_made" );
            return;
        }
    }
    
    self.selectedspawnarea = undefined;
}

// Namespace spawnselection
// Params 1
// Checksum 0xc12d0d6a, Offset: 0x441a
// Size: 0xcf, Type: bool
function function_1a7699345629c241( typeref )
{
    updatespecificfobindanger( typeref, self, self.team );
    objectivekey = function_ac7adb731194066d( typeref );
    
    if ( isdefined( objectivekey ) && isobjectiveindanger( objectivekey, self.team ) )
    {
        return false;
    }
    
    if ( isdefined( typeref ) && issubstr( typeref, "vehicle" ) )
    {
        if ( level.spawnselectionlocations[ typeref ][ self.team ].dynamicent.indanger )
        {
            return false;
        }
        
        if ( isbot( self ) && !level.spawnselectionlocations[ typeref ][ self.team ].dynamicent.var_3b6157742a9906a6 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace spawnselection
// Params 1
// Checksum 0xcd42282b, Offset: 0x44f2
// Size: 0x1e0, Type: bool
function function_e921803cdda9ac1a( var_9641c0b91aff73c6 )
{
    if ( var_9641c0b91aff73c6.dynamicent.team != self.team || var_9641c0b91aff73c6.dynamicent.sessionsquadid != self.sessionsquadid )
    {
        thread refreshplayerspawnareaomnvars();
        assertmsg( "<dev string:x1ed>" + "<dev string:x223>" + self.team + "<dev string:x245>" + self.sessionsquadid + "<dev string:x267>" + var_9641c0b91aff73c6.dynamicent.team + "<dev string:x289>" + var_9641c0b91aff73c6.dynamicent.sessionsquadid );
        return false;
    }
    
    if ( !issquadspawnable( var_9641c0b91aff73c6.dynamicent ) )
    {
        return false;
    }
    
    if ( issquadmateindanger( var_9641c0b91aff73c6.dynamicent ) )
    {
        return false;
    }
    
    vehicle = var_9641c0b91aff73c6.dynamicent.vehicle;
    
    if ( isdefined( vehicle ) )
    {
        if ( vehicle_occupancy::function_41d81defa67de264( vehicle ).size == 0 || !vehicle_interact::vehicle_can_be_used( vehicle ) )
        {
            return false;
        }
        
        if ( isbot( self ) && !vehicle.var_3b6157742a9906a6 )
        {
            return false;
        }
    }
    
    spawninfo = spawnstruct();
    spawninfo = spawnscoring::capsulepass( spawninfo, var_9641c0b91aff73c6.dynamicent );
    
    if ( !isdefined( spawninfo.spawnposition ) )
    {
        var_9641c0b91aff73c6.dynamicent.nogroundfoundtime = gettime();
        return false;
    }
    
    if ( level.var_ca9cd60625bc5c46 > 0 )
    {
        currenttime = gettime();
        timeuntilspawn = self.var_6adf2cb1ba606b3c + level.var_ca9cd60625bc5c46 - currenttime;
        
        if ( timeuntilspawn > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace spawnselection
// Params 0
// Checksum 0x5995a3e7, Offset: 0x46db
// Size: 0x2cb
function selectionmade()
{
    self endon( #"disconnect" );
    self endon( #"tac_ops_map_selection_valid" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, var_17d511bf2c56473f );
        
        if ( message == "tac_ops_spawn_area_selected" )
        {
            var_17d511bf2c56473f = updateplayerspawninputtype( var_17d511bf2c56473f );
            player::printspawnmessage( "spawnSelection::selectionMade() START" );
            selectedspawnarea = undefined;
            
            foreach ( loc in level.spawnselectionlocations )
            {
                if ( isdefined( loc[ self.team ] ) && isdefined( loc[ self.team ].anchorentity ) && loc[ self.team ].anchorentity getentitynumber() == var_17d511bf2c56473f )
                {
                    if ( function_1a7699345629c241( loc[ self.team ].typeref ) )
                    {
                        selectedspawnarea = loc[ self.team ].typeref;
                        break;
                    }
                }
            }
            
            if ( !isdefined( selectedspawnarea ) )
            {
                squadlocations = getsquadspawnlocations( self.team, self.sessionsquadid );
                
                foreach ( loc in squadlocations )
                {
                    if ( isdefined( loc.dynamicent ) && loc.dynamicent getentitynumber() == var_17d511bf2c56473f )
                    {
                        if ( function_e921803cdda9ac1a( loc ) )
                        {
                            selectedspawnarea = loc.typeref;
                        }
                        
                        break;
                    }
                }
            }
            
            if ( !isdefined( selectedspawnarea ) )
            {
                if ( isdefined( self.setspawnpoint ) && self.setspawnpoint getentitynumber() == var_17d511bf2c56473f )
                {
                    selectedspawnarea = "tac_insert";
                }
                else
                {
                    continue;
                }
            }
            
            issquadmate = issubstr( selectedspawnarea, "squad" );
            var_c62c8ef6a3919835 = getdvarint( @"hash_517d1754377878d8", 0 ) == 1;
            
            if ( self.canprocessselection || issquadmate && var_c62c8ef6a3919835 )
            {
                player::printspawnmessage( "spawnSelection::selectionMade() = " + selectedspawnarea );
                self.selectedspawnarea = selectedspawnarea;
                self notify( #"tac_ops_map_selection_made" );
                return;
            }
        }
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0x5faf565, Offset: 0x49ae
// Size: 0x111
function updateplayerspawninputtype( var_17d511bf2c56473f )
{
    if ( !isdefined( self.gwinputtypesused ) )
    {
        self.gwinputtypesused = [];
    }
    
    mask_rightmouseup = 65536;
    mask_leftmouseup = 131072;
    mask_activate = 262144;
    mask_gostand = 524288;
    self.gwinputtypesused[ "rightmouseup" ] = self.gwinputtypesused[ "rightmouseup" ] || ( var_17d511bf2c56473f & mask_rightmouseup ) > 0;
    self.gwinputtypesused[ "leftmouseup" ] = self.gwinputtypesused[ "leftmouseup" ] || ( var_17d511bf2c56473f & mask_leftmouseup ) > 0;
    self.gwinputtypesused[ "activate" ] = self.gwinputtypesused[ "activate" ] || ( var_17d511bf2c56473f & mask_activate ) > 0;
    self.gwinputtypesused[ "gostand" ] = self.gwinputtypesused[ "gostand" ] || ( var_17d511bf2c56473f & mask_gostand ) > 0;
    return var_17d511bf2c56473f & ~( mask_rightmouseup | mask_leftmouseup | mask_activate | mask_gostand );
}

// Namespace spawnselection
// Params 0, eflags: 0x4
// Checksum 0x59f5655b, Offset: 0x4ac8
// Size: 0x8e
function private watchendconditions()
{
    self endon( #"disconnect" );
    
    if ( level.checkspawnselectionafk )
    {
        thread watchforafk();
    }
    
    thread endconditionwatcher_gameended();
    thread endconditionwatcher_selectionmade();
    thread endconditionwatcher_mapcleared();
    thread endconditionwatcher_mapchanged();
    thread endconditionwatcher_nuke();
    thread function_17706791544761eb();
    result = utility::waittill_any_return_no_endon_death( "tac_ops_map_selection_valid", "tac_ops_map_changed", "tac_ops_map_cleared", "spawned_player", "tac_ops_map_game_ended", "tac_ops_map_nuke", "tac_ops_map_no_valid_selections" );
    self notify( #"hash_cd5d52713de758c5" );
    return result;
}

// Namespace spawnselection
// Params 0, eflags: 0xc
// Checksum 0x6efdc5b0, Offset: 0x4b5f
// Size: 0x4b
function private endconditionwatcher_selectionmade()
{
    self notify( #"hash_c9c17e4c3f687753" );
    self endon( #"hash_c9c17e4c3f687753" );
    self endon( #"disconnect" );
    self endon( #"hash_cd5d52713de758c5" );
    self waittill( #"tac_ops_map_selection_made" );
    self notify( #"tac_ops_map_selection_valid" );
}

// Namespace spawnselection
// Params 1, eflags: 0xc
// Checksum 0x36253fa5, Offset: 0x4bb2
// Size: 0x40f
function private endcondition_focuschanged( var_17d511bf2c56473f )
{
    self notify( #"hash_22b55bcf0893f6c8" );
    self endon( #"hash_22b55bcf0893f6c8" );
    
    if ( isdefined( self.selectedspawnarea ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    player::printspawnmessage( "endCondition_FocusChanged() START" );
    selectedspawnarea = undefined;
    
    foreach ( loc in level.spawnselectionlocations )
    {
        if ( isdefined( loc[ self.team ] ) && isdefined( loc[ self.team ].anchorentity ) && loc[ self.team ].anchorentity getentitynumber() == var_17d511bf2c56473f )
        {
            thread keepstreamposfresh( loc[ self.team ].anchorentity.origin );
            selectedspawnarea = loc[ self.team ].typeref;
            break;
        }
    }
    
    dynamicent = undefined;
    
    if ( !isdefined( selectedspawnarea ) )
    {
        squadlocations = getsquadspawnlocations( self.team, self.sessionsquadid );
        
        foreach ( loc in squadlocations )
        {
            if ( isdefined( loc.dynamicent ) && loc.dynamicent getentitynumber() == var_17d511bf2c56473f )
            {
                thread keepstreamposfresh( loc.dynamicent.origin );
                dynamicent = loc.dynamicent;
                selectedspawnarea = loc.typeref;
                break;
            }
        }
    }
    
    if ( !isdefined( selectedspawnarea ) )
    {
        return;
    }
    
    if ( selectedspawnarea == self.forcedspawncameraref )
    {
        return;
    }
    
    player::printspawnmessage( "endCondition_FocusChanged() = " + selectedspawnarea );
    self setclientomnvar( "ui_tom_veh_health_percent", 0 );
    
    if ( issubstr( selectedspawnarea, "squad" ) )
    {
        self.forcedspawncameraref = selectedspawnarea;
        id = function_2f5f4ceceab0f826( selectedspawnarea );
        self setclientomnvar( "ui_tom_previous_selection", id );
        
        if ( level.var_ca9cd60625bc5c46 > 0 )
        {
            currenttime = gettime();
            var_636b1c2f822c8000 = self.var_6adf2cb1ba606b3c + level.var_ca9cd60625bc5c46 - currenttime;
            
            if ( var_636b1c2f822c8000 > 0 )
            {
                displaytime = int( gettime() + var_636b1c2f822c8000 );
                cleartime = var_636b1c2f822c8000 / 1000;
                lower_message::setlowermessageomnvar( "squad_spawn_delay", displaytime, cleartime );
                self setclientomnvar( "ui_tom_respawnTimerActive", 1 );
                self.var_dec7d15704538b14 = 1;
            }
        }
        
        thread function_420cf845661ed8d3();
        thread function_7d83478f3b710467( dynamicent );
    }
    else if ( issubstr( selectedspawnarea, "vehicle" ) )
    {
        self.forcedspawncameraref = selectedspawnarea;
        thread managevehiclehealthui( selectedspawnarea );
        id = function_2f5f4ceceab0f826( selectedspawnarea );
        self setclientomnvar( "ui_tom_previous_selection", id );
        thread function_420cf845661ed8d3();
    }
    else
    {
        id = function_2f5f4ceceab0f826( selectedspawnarea );
        self setclientomnvar( "ui_tom_previous_selection", id );
        
        if ( isdefined( level.spawncameras[ selectedspawnarea ][ self.team ] ) )
        {
            self.forcedspawncameraref = selectedspawnarea;
            thread function_420cf845661ed8d3();
        }
    }
    
    if ( self.var_dec7d15704538b14 && !issubstr( selectedspawnarea, "squad" ) )
    {
        self setclientomnvar( "ui_lower_message", 0 );
        self setclientomnvar( "ui_tom_respawnTimerActive", 0 );
        self.var_dec7d15704538b14 = 0;
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x7e63e9a4, Offset: 0x4fc9
// Size: 0xd8
function function_420cf845661ed8d3()
{
    self notify( #"hash_87d54c8ad34d6dd8" );
    self endon( #"hash_87d54c8ad34d6dd8" );
    self endon( #"disconnect" );
    self notify( #"hash_f540c8a93cb75761" );
    
    if ( issubstr( self.forcedspawncameraref, "squad" ) )
    {
        if ( !level.var_3e7bd8426fc8f6e2 )
        {
            thread managesquadcameraposition( self.forcedspawncameraref );
        }
        
        return;
    }
    
    if ( issubstr( self.forcedspawncameraref, "vehicle" ) )
    {
        if ( !level.var_e89897bcec981524 )
        {
            thread managevehiclecameraposition( self.forcedspawncameraref );
        }
        
        return;
    }
    
    if ( isdefined( level.spawncameras[ self.forcedspawncameraref ][ self.team ] ) )
    {
        while ( !flags::gameflag( "prematch_done" ) )
        {
            waitframe();
        }
        
        thread spawncamera::movetospawncamera( 0 );
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0xcccb6f0b, Offset: 0x50a9
// Size: 0x64
function function_7d83478f3b710467( squadent )
{
    self notify( #"hash_17844cec6f77b8c0" );
    self endon( #"hash_17844cec6f77b8c0" );
    self endon( #"disconnect" );
    self endon( #"hash_cd5d52713de758c5" );
    self endon( #"hash_f540c8a93cb75761" );
    squadent waittill( #"death_or_disconnect" );
    refreshplayerspawnareaomnvars();
    getclosestavailablespawnlocation();
}

// Namespace spawnselection
// Params 1
// Checksum 0x27ecc1c6, Offset: 0x5115
// Size: 0x60
function keepstreamposfresh( origin )
{
    self endon( #"disconnect" );
    self endon( #"tac_ops_map_selection_valid" );
    self endon( #"spawned_player" );
    self notify( #"hash_1b82338eaf9b4546" );
    self endon( #"hash_1b82338eaf9b4546" );
    
    while ( true )
    {
        self predictstreamposuntilcleared( origin, 1 );
        wait 1;
    }
}

// Namespace spawnselection
// Params 0, eflags: 0xc
// Checksum 0xcd149384, Offset: 0x517d
// Size: 0x4b
function private endconditionwatcher_gameended()
{
    self notify( #"hash_863caa2a36215459" );
    self endon( #"hash_863caa2a36215459" );
    self endon( #"disconnect" );
    self endon( #"hash_cd5d52713de758c5" );
    level waittill( #"game_ended" );
    self notify( #"tac_ops_map_game_ended" );
}

// Namespace spawnselection
// Params 0, eflags: 0xc
// Checksum 0x81a7c5d8, Offset: 0x51d0
// Size: 0x4b
function private endconditionwatcher_mapcleared()
{
    self notify( #"hash_544dfa5d00943bc" );
    self endon( #"hash_544dfa5d00943bc" );
    self endon( #"disconnect" );
    self endon( #"hash_cd5d52713de758c5" );
    level waittill( #"tac_ops_map_cleared" );
    self notify( #"tac_ops_map_cleared" );
}

// Namespace spawnselection
// Params 0, eflags: 0xc
// Checksum 0xad3850c3, Offset: 0x5223
// Size: 0x4b
function private endconditionwatcher_mapchanged()
{
    self notify( #"hash_9302f96de3b4d71a" );
    self endon( #"hash_9302f96de3b4d71a" );
    self endon( #"disconnect" );
    self endon( #"hash_cd5d52713de758c5" );
    level waittill( #"tac_ops_map_changed" );
    self notify( #"tac_ops_map_changed" );
}

// Namespace spawnselection
// Params 0, eflags: 0xc
// Checksum 0x8618b00, Offset: 0x5276
// Size: 0x4b
function private endconditionwatcher_nuke()
{
    self notify( #"hash_711295d9aec5dc28" );
    self endon( #"hash_711295d9aec5dc28" );
    self endon( #"disconnect" );
    self endon( #"hash_cd5d52713de758c5" );
    level waittill( #"hash_ea4d6125c3743b67" );
    self notify( #"tac_ops_map_nuke" );
}

// Namespace spawnselection
// Params 0, eflags: 0xc
// Checksum 0x1d1d566a, Offset: 0x52c9
// Size: 0x51
function private function_17706791544761eb()
{
    self notify( #"hash_b0e7babf36f0e6aa" );
    self endon( #"hash_b0e7babf36f0e6aa" );
    self endon( #"disconnect" );
    self endon( #"tac_ops_map_selection_valid" );
    
    while ( self [[ level.var_e91f2ef9c58faa7c ]]() )
    {
        waitframe();
    }
    
    self notify( #"tac_ops_map_no_valid_selections" );
}

// Namespace spawnselection
// Params 0
// Checksum 0xe9dd453e, Offset: 0x5322
// Size: 0x44
function spawnselectionshutdown_nuke()
{
    if ( !self.inspawnselection )
    {
        return;
    }
    
    self visionsetnakedforplayer( "nuke_global_aftermath", 0.05 );
    wait 2;
    
    if ( !self.inspawnselection )
    {
        return;
    }
    
    self visionsetnakedforplayer( "flir_0_black_to_white_heavy_damage", 0.05 );
}

// Namespace spawnselection
// Params 4
// Checksum 0x9fc66109, Offset: 0x536e
// Size: 0x11a
function adddynamicspawnarea( team, ent, ref, offset )
{
    if ( isdefined( level.spawnselectionlocations[ ref ][ team ] ) )
    {
        areastruct = level.spawnselectionlocations[ ref ][ team ];
        areastruct.origin = ent.origin + ( offset ?? ( 0, 0, 0 ) );
        areastruct.angles = ent.angles;
        return;
    }
    
    areastruct = spawnstruct();
    areastruct.team = team;
    areastruct.typeref = ref;
    areastruct.origin = ent.origin;
    areastruct.var_e64f7599f77bea6 = offset ?? ( 0, 0, 100 );
    areastruct.dynamicent = ent;
    areastruct.script_noteworthy = ref;
    initspawnarea( areastruct );
    updatespawnareas();
}

// Namespace spawnselection
// Params 2
// Checksum 0xa0e9a948, Offset: 0x5490
// Size: 0x5a
function removedynamicspawnarea( team, ref )
{
    if ( isdefined( level.spawnselectionlocations[ ref ][ team ] ) )
    {
        level.spawnselectionlocations[ ref ][ team ] = undefined;
        
        if ( level.spawnselectionlocations[ ref ].size == 0 )
        {
            level.spawnselectionlocations[ ref ] = undefined;
        }
    }
    
    updatespawnareas();
}

// Namespace spawnselection
// Params 2
// Checksum 0x90f9983f, Offset: 0x54f2
// Size: 0x46
function getsquadspawnlocations( team, squadindex )
{
    locations = [];
    
    if ( isdefined( level.squadspawnselectionlocations[ team ][ squadindex ] ) )
    {
        locations = level.squadspawnselectionlocations[ team ][ squadindex ];
    }
    
    return locations;
}

// Namespace spawnselection
// Params 5
// Checksum 0x74ee47fe, Offset: 0x5541
// Size: 0x1a8
function updatesquadspawn( team, squad, ref, ent, issquadleader )
{
    if ( !isdefined( level.squadspawnselectionlocations ) )
    {
        level.squadspawnselectionlocations = [];
    }
    
    if ( !isdefined( level.squadspawnselectionlocations[ team ] ) )
    {
        level.squadspawnselectionlocations[ team ] = [];
    }
    
    if ( !isdefined( level.squadspawnselectionlocations[ team ][ squad ] ) )
    {
        level.squadspawnselectionlocations[ team ][ squad ] = [];
    }
    
    var_311f91da363c7559 = issquadspawnable( ent ) && ( !level.spawnsquadleaderonly || issquadleader );
    
    if ( isdefined( level.squadspawnselectionlocations[ team ][ squad ][ ref ] ) )
    {
        if ( !var_311f91da363c7559 )
        {
            level.squadspawnselectionlocations[ team ][ squad ][ ref ] = undefined;
            return;
        }
        
        areastruct = level.squadspawnselectionlocations[ team ][ squad ][ ref ];
        areastruct.typeref = ref;
        areastruct.origin = ent.origin;
        areastruct.angles = ent.angles;
        areastruct.dynamicent = ent;
        return;
    }
    
    if ( !var_311f91da363c7559 )
    {
        return;
    }
    
    areastruct = spawnstruct();
    areastruct.typeref = ref;
    areastruct.origin = ent.origin;
    areastruct.angles = ent.angles;
    areastruct.dynamicent = ent;
    level.squadspawnselectionlocations[ team ][ squad ][ ref ] = areastruct;
}

// Namespace spawnselection
// Params 2
// Checksum 0x250588e9, Offset: 0x56f1
// Size: 0x44
function removespawnareaondeathdisconnect( team, ref )
{
    self endon( #"hash_cd5d52713de758c5" );
    adddynamicspawnarea( team, self, ref );
    self waittill( #"death_or_disconnect" );
    thread addspawnareaonspawn( team, ref );
}

// Namespace spawnselection
// Params 2
// Checksum 0x33659f92, Offset: 0x573d
// Size: 0x4e
function addspawnareaonspawn( team, ref )
{
    self endon( #"hash_cd5d52713de758c5" );
    removedynamicspawnarea( team, ref );
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    thread removespawnareaondeathdisconnect( team, ref );
}

// Namespace spawnselection
// Params 0
// Checksum 0x5c268cfa, Offset: 0x5793
// Size: 0xaa
function function_53406cd7eebf8436()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"hash_9342d42a8a06e612" );
    self.var_ae9100af7ee2e95b = 1;
    var_b403eff47ee117a7 = int( level.tispawndelay );
    self setclientomnvar( "ui_tom_ti_respawnTimer", gettime() + var_b403eff47ee117a7 * 1000 );
    
    while ( true )
    {
        var_b403eff47ee117a7 = clamp( var_b403eff47ee117a7, 0, level.tispawndelay );
        
        if ( var_b403eff47ee117a7 == 0 )
        {
            self setclientomnvar( "ui_tom_ti_respawnTimer", 0 );
            self.var_ae9100af7ee2e95b = 0;
            return;
        }
        else
        {
            var_b403eff47ee117a7 -= level.framedurationseconds;
        }
        
        waitframe();
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0xcd98a404, Offset: 0x5845
// Size: 0x122
function function_e5dc4be25d30f851()
{
    if ( !isdefined( self.setspawnpoint ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self notify( #"hash_5e675b57105d83c4" );
    self endon( #"hash_5e675b57105d83c4" );
    startindex = function_b1ab00964273cbbe( self ).size;
    tiindex = startindex + 4;
    tidata = spawnstruct();
    tidata.entity = self.setspawnpoint;
    tidata.id = function_2f5f4ceceab0f826( "tac_insert" );
    
    if ( !self.var_ae9100af7ee2e95b )
    {
        thread function_53406cd7eebf8436();
    }
    
    while ( true )
    {
        if ( !isdefined( self.setspawnpoint ) )
        {
            self setclientomnvar( "ui_tom_spawn_id_" + tiindex, -1 );
            self setclientomnvar( "ui_tom_spawn_entity_" + tiindex, undefined );
            refreshplayerspawnareaomnvars();
            return;
        }
        
        self setclientomnvar( "ui_tom_spawn_id_" + tiindex, tidata.id );
        self setclientomnvar( "ui_tom_spawn_entity_" + tiindex, tidata.entity );
        waitframe();
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x3c7c9b0f, Offset: 0x596f
// Size: 0x512
function evaluatesquadspawn()
{
    if ( !isdefined( level.squaddata ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self notify( #"hash_80caa55b44750bd3" );
    self endon( #"hash_80caa55b44750bd3" );
    startindex = function_b1ab00964273cbbe( self ).size;
    typeid = [];
    typeid[ 0 ] = function_2f5f4ceceab0f826( "squad_0" );
    typeid[ 1 ] = function_2f5f4ceceab0f826( "squad_1" );
    typeid[ 2 ] = function_2f5f4ceceab0f826( "squad_2" );
    typeid[ 3 ] = function_2f5f4ceceab0f826( "squad_3" );
    var_6aaa4a288ed05fba = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        data = spawnstruct();
        data.guid = undefined;
        data.entity = undefined;
        data.idmask = undefined;
        var_6aaa4a288ed05fba[ i ] = data;
    }
    
    squadrefs = [];
    
    for ( i = 0; i < 4 ; i++ )
    {
        squadrefs[ i ] = "squad_" + i;
    }
    
    while ( true )
    {
        squadleader = squad_utility::getsquadleader( self.team, self.sessionsquadid );
        players = level.squaddata[ self.team ][ self.sessionsquadid ].players;
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( !isdefined( var_6aaa4a288ed05fba[ i ].guid ) )
            {
                continue;
            }
            
            if ( !isdefined( players[ i ] ) || players[ i ].guid != var_6aaa4a288ed05fba[ i ].guid )
            {
                thread refreshplayerspawnareaomnvars();
                return;
            }
        }
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( i < players.size )
            {
                player = players[ i ];
            }
            else
            {
                player = undefined;
            }
            
            if ( player == self )
            {
                continue;
            }
            
            ref = squadrefs[ i ];
            issquadleader = player == squadleader;
            updatesquadspawn( self.team, self.sessionsquadid, ref, player, issquadleader );
        }
        
        locations = getsquadspawnlocations( self.team, self.sessionsquadid );
        
        for ( i = 0; i < 4 ; i++ )
        {
            if ( i < players.size )
            {
                player = players[ i ];
            }
            else
            {
                player = undefined;
            }
            
            ref = squadrefs[ i ];
            selected = locations[ ref ];
            inrallypointvehicle = isdefined( player ) && isdefined( player.vehicle ) && player.vehicle.israllypointvehicle;
            
            if ( selected && self != player && !inrallypointvehicle )
            {
                indanger = function_842dc99860cc6c8f( player );
                idmask = typeid[ i ];
                assert( idmask < 128, "<dev string:x15b>" + ref + "<dev string:x2ab>" + idmask + "<dev string:x180>" + 128 + "<dev string:x19f>" );
                
                if ( indanger )
                {
                    idmask += 128;
                }
                
                if ( issquadleader )
                {
                    idmask += 256;
                }
                
                if ( isdefined( player.vehicle ) )
                {
                    idmask += 512;
                    
                    if ( vehicle_occupancy::function_41d81defa67de264( player.vehicle ).size == 0 || !vehicle_interact::vehicle_can_be_used( player.vehicle ) )
                    {
                        idmask += 1024;
                    }
                    
                    if ( player.vehicle vehicle::get_ref() == %"hash_49602cb7beee6fba" )
                    {
                        idmask += 4096;
                    }
                }
                
                idmask += player.sessionuimemberindex << 13;
                
                if ( !isdefined( var_6aaa4a288ed05fba[ i ].guid ) )
                {
                    var_6aaa4a288ed05fba[ i ].guid = player.guid;
                }
                
                if ( !isdefined( var_6aaa4a288ed05fba[ i ].entity ) && isdefined( selected ) && isdefined( selected.dynamicent ) )
                {
                    var_6aaa4a288ed05fba[ i ].entity = selected.dynamicent;
                    self setclientomnvar( "ui_tom_spawn_entity_" + startindex + i, selected.dynamicent );
                }
                
                if ( var_6aaa4a288ed05fba[ i ].idmask != idmask )
                {
                    var_6aaa4a288ed05fba[ i ].idmask = idmask;
                    self setclientomnvar( "ui_tom_spawn_id_" + startindex + i, idmask );
                }
                
                continue;
            }
            
            if ( isdefined( var_6aaa4a288ed05fba[ i ].entity ) )
            {
                var_6aaa4a288ed05fba[ i ].entity = undefined;
                self setclientomnvar( "ui_tom_spawn_entity_" + startindex + i, undefined );
            }
            
            if ( isdefined( var_6aaa4a288ed05fba[ i ].idmask ) && var_6aaa4a288ed05fba[ i ].idmask != -1 )
            {
                var_6aaa4a288ed05fba[ i ].idmask = -1;
                self setclientomnvar( "ui_tom_spawn_id_" + startindex + i, -1 );
            }
        }
        
        waitframe();
    }
}

// Namespace spawnselection
// Params 2
// Checksum 0x6a7d0478, Offset: 0x5e89
// Size: 0x4e8
function handlerespawnselection( spawnedasspectator, timeuntilspawn )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    respawntype = undefined;
    
    if ( !isdefined( respawntype ) )
    {
        if ( level.usec130spawnfirstonly && level.usec130spawn && !self.spawnedusingc130 && isdefined( level.spawnc130[ self.team ] ) )
        {
            respawntype = 1;
        }
        else if ( level.usesquadspawn )
        {
            respawntype = 0;
        }
        else if ( level.usespawnselection )
        {
            respawntype = 2;
        }
        else if ( level.usec130spawn )
        {
            respawntype = 1;
        }
        else
        {
            respawntype = 3;
        }
    }
    
    initialtime = gettime();
    selectionmade = 0;
    
    while ( !selectionmade )
    {
        currenttime = gettime();
        spawndelay = ( initialtime + timeuntilspawn * 1000 - currenttime ) / 1000;
        
        switch ( respawntype )
        {
            case 0:
                self.squadspawnconfirmed = 0;
                self.squadspawnaborted = 0;
                
                if ( !isai( self ) )
                {
                    thread handlesquadspawnabort();
                }
                
                if ( !spawnedasspectator )
                {
                    thread playerlogic::respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
                }
                
                spawnedasspectator = 1;
                startindex = self.spawnselectedsquadmate ?? 0;
                
                if ( thread cyclevalidsquadspectate( startindex, 1 ) )
                {
                    if ( !isai( self ) )
                    {
                        result = handlesquadspawnconfirm( spawndelay );
                        
                        if ( !result )
                        {
                            self.squadspawnaborted = 1;
                        }
                        else
                        {
                            self.squadspawnconfirmed = 1;
                        }
                    }
                    else
                    {
                        timeuntilspawnmessaging( timeuntilspawn, "spawn_revive_wait" );
                        
                        if ( utility::cointoss() )
                        {
                            self.squadspawnconfirmed = 1;
                        }
                        else
                        {
                            self.squadspawnaborted = 1;
                        }
                    }
                }
                else
                {
                    self.squadspawnaborted = 1;
                }
                
                if ( self.squadspawnaborted )
                {
                    self.forcespectatorclient = -1;
                    
                    if ( level.usec130spawn )
                    {
                        respawntype = 1;
                    }
                    else if ( level.usespawnselection )
                    {
                        respawntype = 2;
                    }
                    else
                    {
                        respawntype = 3;
                    }
                }
                else
                {
                    selectionmade = 1;
                }
                
                break;
            case 1:
                thread spawncamera::startspawncamera();
                cameradelay = spawncamera::getspawncamerawaittime();
                
                if ( !isdefined( cameradelay ) )
                {
                    cameradelay = 0;
                }
                
                if ( level.usec130spawnfirstonly )
                {
                    self.spawnedusingc130 = 1;
                }
                
                spawntoc130();
                selectionmade = 1;
                break;
            case 2:
                caninfil = flags::gameflag( "infil_will_run" ) && !istrue( flags::gameflag( "infil_started" ) );
                
                if ( ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || game_utility::getgametype() == "bigctf" ) && !caninfil && !flags::gameflag( "prematch_done" ) )
                {
                    camerapositions = [[ level.var_5fb58f5bb9552416 ]]( self.team );
                    cament = spawn( "script_model", camerapositions.startorigin );
                    cament setmodel( "tag_origin" );
                    cament.angles = camerapositions.startangles;
                    self cameralinkto( cament, "tag_origin" );
                    cament moveto( camerapositions.endorigin, 18 );
                    cament rotateto( camerapositions.endangles, 18 );
                    flags::gameflagwait( "prematch_done" );
                    self cameraunlink();
                    self.spawncameratime = 0.5;
                    thread spawncamera::startspawncamera( 0, 0.5, 0.5 );
                }
                else
                {
                    self.spawncameratime = 0.5;
                    thread spawncamera::startspawncamera( 0, 0.5, 0.5 );
                }
                
                cameradelay = spawncamera::getspawncamerawaittime();
                
                if ( !isdefined( cameradelay ) )
                {
                    cameradelay = 0;
                }
                
                waitforspawnselection( spawndelay + cameradelay );
                
                if ( isdefined( self.selectedspawnarea ) )
                {
                    selectionmade = 1;
                }
                
                break;
            case 3:
                thread spawncamera::startspawncamera();
                cameradelay = spawncamera::getspawncamerawaittime();
                
                if ( !isdefined( cameradelay ) )
                {
                    cameradelay = 0;
                }
                
                timeuntilspawnmessaging( spawndelay + cameradelay, level.var_791076e7de107dc2 );
                selectionmade = 1;
                break;
        }
    }
    
    if ( needsbuttontorespawn() )
    {
        if ( !self.waitingtoselectclass )
        {
            lower_message::setlowermessageomnvar( "press_to_spawn" );
        }
        
        if ( !spawnedasspectator )
        {
            thread playerlogic::respawn_asspectator( self.origin + ( 0, 0, 60 ), self.angles );
        }
        
        spawnedasspectator = 1;
        waitrespawnbutton();
    }
    
    thread spawncamera::endspawncamera();
}

// Namespace spawnselection
// Params 0
// Checksum 0xa867bba1, Offset: 0x6379
// Size: 0x65
function handlesquadspawnabort()
{
    self endon( #"disconnect" );
    self notify( #"hash_6cbb7f09be21fc74" );
    self endon( #"hash_6cbb7f09be21fc74" );
    self notifyonplayercommand( "switchSpawnMethod", "+stance" );
    self waittill( #"switchSpawnMethod" );
    self.forcespectatorclient = -1;
    self.squadspawnaborted = 1;
    self notify( #"squad_spawn_abort" );
}

// Namespace spawnselection
// Params 0
// Checksum 0x65b340c3, Offset: 0x63e6
// Size: 0xc7
function handlesquadspawncycle()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"squad_spawn_abort" );
    self notify( #"hash_d3b44b420522b35c" );
    self endon( #"hash_d3b44b420522b35c" );
    self notifyonplayercommand( "cyclePos", "+gostand" );
    
    while ( true )
    {
        result = utility::waittill_any_return( "cyclePos", "cycleNeg" );
        
        if ( isdefined( result ) )
        {
            current = self getspectatingplayer();
            
            if ( result == "cyclePos" )
            {
                thread cyclevalidsquadspectate( current.sessionuimemberindex, 1 );
                continue;
            }
            
            if ( result == "cycleNeg" )
            {
                thread cyclevalidsquadspectate( current.sessionuimemberindex, 0 );
            }
        }
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0x8b52dee7, Offset: 0x64b5
// Size: 0x6d, Type: bool
function handlesquadspawnconfirm( timeuntilspawn )
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"squad_spawn_abort" );
    timeuntilspawnmessaging( timeuntilspawn, level.var_791076e7de107dc2 );
    lower_message::setlowermessageomnvar( "squad_spawn" );
    self notifyonplayercommand( "respawn_confirm", "+usereload" );
    self waittill( #"respawn_confirm" );
    return true;
}

// Namespace spawnselection
// Params 2
// Checksum 0x7a8f17b4, Offset: 0x652b
// Size: 0x10e, Type: bool
function cyclevalidsquadspectate( startindex, positive )
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"squad_spawn_abort" );
    self notify( #"hash_c306feae2ef5bdce" );
    self endon( #"hash_c306feae2ef5bdce" );
    players = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    checkindex = startindex;
    step = positive ? 1 : -1;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( iscurrentspectatetarget( players[ checkindex ] ) || !issquadspawnable( players[ checkindex ] ) )
        {
            checkindex += step;
            
            if ( checkindex == players.size )
            {
                checkindex = 0;
            }
            
            if ( checkindex == -1 )
            {
                checkindex = players.size - 1;
            }
            
            continue;
        }
        
        thread monitorsquadspectator( players[ checkindex ] );
        return true;
    }
    
    return false;
}

// Namespace spawnselection
// Params 1
// Checksum 0x87b0fea3, Offset: 0x6642
// Size: 0x3a, Type: bool
function iscurrentspectatetarget( player )
{
    if ( !isdefined( self.forcespectatorclient ) )
    {
        return false;
    }
    
    spectatingteammate = self getspectatingplayer();
    
    if ( !isdefined( spectatingteammate ) )
    {
        return false;
    }
    
    return player == spectatingteammate;
}

// Namespace spawnselection
// Params 1
// Checksum 0x521551a7, Offset: 0x6685
// Size: 0x4d, Type: bool
function issquadspawnable( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( player.inspawncamera )
    {
        return false;
    }
    
    if ( player isskydiving() )
    {
        return false;
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace spawnselection
    // Params 1
    // Checksum 0x66f398d3, Offset: 0x66db
    // Size: 0x2a, Type: dev
    function function_b32768f992d1c069( params )
    {
        if ( getdvarint( @"scr_squad_spawn_debug", 0 ) == 1 )
        {
            thread spawnscoring::squadspawndebug();
        }
    }

#/

// Namespace spawnselection
// Params 1
// Checksum 0xb0c5eca1, Offset: 0x670d
// Size: 0x72
function function_842dc99860cc6c8f( player )
{
    currenttime = gettime();
    
    if ( player.var_f8405ef19479a67d == currenttime )
    {
        return player.indanger;
    }
    
    player.var_f8405ef19479a67d = currenttime;
    player.indanger = issquadspawnable( player ) && issquadmateindanger( player );
    return player.indanger;
}

// Namespace spawnselection
// Params 1
// Checksum 0xc9b55ee, Offset: 0x6788
// Size: 0x2af, Type: bool
function issquadmateindanger( player )
{
    currenttime = gettime();
    
    if ( isdefined( player ) && isdefined( player.pers[ "lastDamageTime" ] ) && player.pers[ "lastDamageTime" ] + 5000 > currenttime || isdefined( player.lasttimedamaged ) && player.lasttimedamaged + 5000 > currenttime )
    {
        return true;
    }
    
    if ( player isonladder() )
    {
        return true;
    }
    
    player battlechatter_mp::validaterecentattackers();
    
    if ( isdefined( player.recentattackers ) && player.recentattackers.size > 0 )
    {
        return true;
    }
    
    if ( isdefined( player.lastweaponfiretimestart ) && player.lastweaponfiretimestart + 3000 > currenttime )
    {
        return true;
    }
    
    if ( player.lastweaponfiretimestart > player.lastweaponfiretimeend || isdefined( player.lastweaponfiretimestart ) && !isdefined( player.lastweaponfiretimeend ) )
    {
        return true;
    }
    
    enemy_in_range = player getclosestenemy( 384, 100, 1 );
    
    if ( isdefined( enemy_in_range ) )
    {
        return true;
    }
    
    if ( isdefined( player.vehicle ) )
    {
        if ( player.vehicle.burningdown )
        {
            return true;
        }
        
        if ( weapon_utility::islockedonto( player.vehicle ) )
        {
            return true;
        }
    }
    
    if ( outofbounds::isoob( player ) )
    {
        return true;
    }
    
    if ( getdvarint( @"scr_squad_spawn_bucket", 0 ) == 1 )
    {
        bucket = player getspawnbucketforplayer( 1, player.origin );
        bucket = spawnlogic::getspawnbucketfromstring( bucket );
        
        if ( bucket >= 2 )
        {
            return true;
        }
    }
    
    if ( isdefined( player ) && isdefined( player.nogroundfoundtime ) && player.nogroundfoundtime + 1000 > currenttime )
    {
        return true;
    }
    
    if ( level.var_707d78245a70bb4b > 0 )
    {
        foreach ( objective in level.objectives )
        {
            distsq = distancesquared( player.origin, gameobjects_common::get_origin( objective ) );
            
            if ( distsq < level.var_707d78245a70bb4b )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace spawnselection
// Params 1
// Checksum 0x672b1957, Offset: 0x6a40
// Size: 0x11e
function monitorsquadspectator( target )
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"squad_spawn_abort" );
    self notify( #"hash_6fdb97d8983a7d32" );
    self endon( #"hash_6fdb97d8983a7d32" );
    index = target.sessionuimemberindex;
    self.forcespectatorclient = target getentitynumber();
    self forcethirdpersonwhenspectating();
    thread handlesquadspawncycle();
    
    while ( issquadspawnable( target ) )
    {
        if ( issquadmateindanger( target ) )
        {
            self setclientomnvar( "ui_squad_spawn_combat", 1 );
        }
        else
        {
            self setclientomnvar( "ui_squad_spawn_combat", 0 );
        }
        
        self.squadspectatepos = target.origin + anglestoforward( target.angles ) * -80 + ( 0, 0, 64 );
        self.squadspectateang = target.angles;
        waitframe();
    }
    
    if ( !thread cyclevalidsquadspectate( index, 1 ) )
    {
        self.squadspawnaborted = 0;
        self notify( #"squad_spawn_abort" );
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0xd3d3c2, Offset: 0x6b66
// Size: 0x134
function spawntoc130()
{
    self endon( #"disconnect" );
    
    while ( level.usec130spawn && !isdefined( level.spawnc130 ) )
    {
        waitframe();
    }
    
    if ( !level.usec130spawn || !isdefined( level.spawnc130[ self.team ] ) )
    {
        wait 1.5;
        return;
    }
    
    if ( !level.usec130spawnfirstonly && isdefined( level.timeuntilnextc130 ) && level.timeuntilnextc130[ self.team ] - gettime() <= ( level.flighttime + level.timebetweenc130passes ) * 1000 )
    {
        lower_message::setlowermessageomnvar( "waiting_for_c130", int( level.timeuntilnextc130[ self.team ] ) );
    }
    else
    {
        lower_message::setlowermessageomnvar( "clear_lower_msg" );
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"hash_fb347c5f16116383" ][ #"hash_a1ad2f0217b6ce6f" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self thread [[ var_32dbca3143d9c4a5 ]]();
    }
    
    if ( isdefined( level.spawnc130[ self.team ] ) )
    {
        self waittill( #"hash_a3d0ae213d1bbc7e" );
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x2bf7c1cc, Offset: 0x6ca2
// Size: 0x59, Type: bool
function needsbuttontorespawn()
{
    if ( getmatchrulesdata( "commonOption", "forceRespawn" ) != 0 )
    {
        return false;
    }
    
    if ( !self.hasspawned )
    {
        return false;
    }
    
    wavebased = getmatchrulesdata( "commonOption", "waveRespawnDelay" ) > 0;
    
    if ( wavebased )
    {
        return false;
    }
    
    if ( self.wantsafespawn )
    {
        return false;
    }
    
    return true;
}

// Namespace spawnselection
// Params 0
// Checksum 0x72eab3bb, Offset: 0x6d04
// Size: 0x33
function waitrespawnbutton()
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    
    while ( true )
    {
        if ( self usebuttonpressed() )
        {
            break;
        }
        
        wait 0.05;
    }
}

// Namespace spawnselection
// Params 2
// Checksum 0xc8dd2df6, Offset: 0x6d3f
// Size: 0x5e
function timeuntilspawnmessaging( timeuntilspawn, reason )
{
    self endon( #"disconnect" );
    
    if ( timeuntilspawn > 0 )
    {
        if ( !isdefined( reason ) )
        {
            reason = level.var_791076e7de107dc2;
        }
        
        lower_message::setlowermessageomnvar( reason, int( gettime() + timeuntilspawn * 1000 ) );
        utility::waittill_any_timeout_no_endon_death( timeuntilspawn, "force_spawn" );
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0xd2921fcf, Offset: 0x6da5
// Size: 0x2af
function managesquadcameraposition( ref )
{
    self notify( #"hash_66b66b05c88c5d44" );
    self endon( #"hash_66b66b05c88c5d44" );
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"hash_f540c8a93cb75761" );
    self endon( #"hash_cd5d52713de758c5" );
    index = undefined;
    
    if ( ref == "squad_leader" )
    {
        index = level.squaddata[ self.team ][ self.sessionsquadid ].squadleader.sessionuimemberindex;
    }
    else
    {
        index = int( getsubstr( ref, ref.size - 1, ref.size ) );
    }
    
    goalplayer = undefined;
    
    if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) && isdefined( level.squaddata[ self.team ][ self.sessionsquadid ].players[ index ] ) )
    {
        goalplayer = level.squaddata[ self.team ][ self.sessionsquadid ].players[ index ];
    }
    
    forward = level.spawnselectionteamforward[ self.team ];
    
    while ( isdefined( self.spawncameraent ) && isdefined( goalplayer ) )
    {
        goalposition = [];
        goalangles = [];
        
        if ( level.usestaticspawnselectioncamera )
        {
            temp = getstaticcameraposition( self.team );
            goalposition = temp.origin;
            goalangles = temp.angles;
        }
        else
        {
            heightoffset = 7000;
            
            if ( level.useunifiedspawnselectioncameraheight )
            {
                heightoffset = function_ceff7e3b58ecd747();
            }
            
            goalposition = goalplayer.origin + forward * -8500 + ( 0, 0, heightoffset );
            goalvector = vectornormalize( goalplayer.origin - goalposition );
            goalangles = script::vectortoanglessafe( goalvector, ( 0, 0, 1 ) );
            goalposition += [[ level.var_81d027302ddd38f4 ]]( self.team, goalplayer.origin );
        }
        
        self.spawncameratargetpos = goalposition;
        self.spawncameratargetang = goalangles;
        self.spawncameraent moveto( goalposition, 0.25, 0.05, 0.2 );
        self.spawncameraent rotateto( goalangles, 0.25, 0.05, 0.2 );
        waitframe();
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0x442e53fa, Offset: 0x705c
// Size: 0x2e1
function managevehiclecameraposition( ref )
{
    self notify( #"hash_53d964444a0b3b7f" );
    self endon( #"hash_53d964444a0b3b7f" );
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"hash_f540c8a93cb75761" );
    self endon( #"hash_cd5d52713de758c5" );
    vehicleent = level.spawnselectionlocations[ ref ][ self.team ].dynamicent;
    forward = level.spawnselectionteamforward[ self.team ];
    var_8fa90df34effad92 = 0;
    
    while ( isdefined( self.spawncameraent ) && isdefined( vehicleent ) && !vehicleent.isdestroyed )
    {
        goalposition = [];
        goalangles = [];
        
        if ( level.usestaticspawnselectioncamera )
        {
            temp = getstaticcameraposition( self.team );
            goalposition = temp.origin;
            goalangles = temp.angles;
        }
        else
        {
            heightoffset = 7000;
            
            if ( level.useunifiedspawnselectioncameraheight )
            {
                heightoffset = function_ceff7e3b58ecd747();
            }
            
            goalposition = vehicleent.origin + forward * -8500 + ( 0, 0, heightoffset );
            groundpos = level.spawnselectionlocations[ ref ][ self.team ].anchorentity.origin;
            camerapos = groundpos + forward * -8500 + ( 0, 0, heightoffset );
            toground = vectornormalize( groundpos - camerapos );
            goalangles = script::vectortoanglessafe( toground, ( 0, 0, 1 ) );
            goalposition += [[ level.var_81d027302ddd38f4 ]]( self.team, groundpos );
        }
        
        self.spawncameratargetpos = goalposition;
        self.spawncameratargetang = goalangles;
        
        if ( !isdefined( self.spawncameraendtime ) || gettime() > self.spawncameraendtime )
        {
            self.spawncameraent moveto( goalposition, 0.25, 0.05, 0.2 );
            self.spawncameraent rotateto( goalangles, 0.25, 0.05, 0.2 );
        }
        else if ( !var_8fa90df34effad92 )
        {
            var_8fa90df34effad92 = 1;
            self.spawncameraent moveto( goalposition, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4 );
            self.spawncameraent rotateto( goalangles, self.spawncameratime, self.spawncameratime * 0.3, self.spawncameratime * 0.4 );
        }
        
        waitframe();
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0xcd50d8f2, Offset: 0x7345
// Size: 0xf5
function managevehiclehealthui( ref )
{
    self endon( #"disconnect" );
    self endon( #"end_respawn" );
    self endon( #"tac_ops_spawn_focus_changed" );
    self notify( #"hash_10d8ec26bd579ea2" );
    self endon( #"hash_10d8ec26bd579ea2" );
    vehicleent = level.spawnselectionlocations[ ref ][ self.team ].dynamicent;
    self setclientomnvar( "ui_tom_veh_health_percent", 0 );
    waitframe();
    var_2842c01eaabe998a = undefined;
    
    while ( isdefined( vehicleent ) )
    {
        healthpercent = int( clamp( vehicleent.health / vehicleent.maxhealth * 100, 0, 100 ) );
        
        /#
            if ( healthpercent < 0 )
            {
                println( "<dev string:x2b9>" );
            }
        #/
        
        if ( var_2842c01eaabe998a != healthpercent )
        {
            self setclientomnvar( "ui_tom_veh_health_percent", int( healthpercent ) );
            var_2842c01eaabe998a = healthpercent;
        }
        
        waitframe();
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x9d22e5d9, Offset: 0x7442
// Size: 0x3d4
function getclosestavailablespawnlocation()
{
    closestdistsq = undefined;
    closestref = undefined;
    
    if ( !flags::gameflag( "prematch_done" ) && ( game_utility::getgametype() == "arm" || game_utility::getgametype() == "conflict" || game_utility::getgametype() == "bigctf" ) || !isdefined( self.hasvisitedgwspawnselection ) )
    {
        if ( self.team == "axis" || self.team == "team_three" || self.team == "team_four" )
        {
            closestref = "gw_fob_axisHQ";
        }
        else
        {
            closestref = "gw_fob_alliesHQ";
        }
        
        self.hasvisitedgwspawnselection = 1;
    }
    else
    {
        availablespawnlocations = function_b1ab00964273cbbe( self );
        
        foreach ( ref in availablespawnlocations )
        {
            obj = level.spawnselectionlocations[ ref ][ self.team ];
            distsq = distancesquared( self.origin, obj.anchorentity.origin );
            
            if ( !isdefined( distsq ) )
            {
                continue;
            }
            
            if ( level.var_12b63dd9890dabcc && isdefined( level.objectives[ obj.objectivekey ] ) && isobjectiveindanger( obj.objectivekey, self.team ) )
            {
                continue;
            }
            
            if ( issubstr( ref, "alliesHQ" ) || issubstr( ref, "axisHQ" ) )
            {
                if ( distsq < 4194304 )
                {
                    closestdistsq = distsq;
                    closestref = ref;
                    break;
                }
            }
            
            if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
            {
                closestdistsq = distsq;
                closestref = ref;
            }
        }
        
        if ( isdefined( level.squadspawnselectionlocations[ self.team ][ self.sessionsquadid ] ) )
        {
            locations = getsquadspawnlocations( self.team, self.sessionsquadid );
            
            foreach ( loc in locations )
            {
                if ( !isdefined( loc.dynamicent.origin ) || loc.dynamicent == self )
                {
                    continue;
                }
                
                distsq = distancesquared( self.origin, loc.dynamicent.origin );
                
                if ( distsq < closestdistsq )
                {
                    closestdistsq = distsq;
                    closestref = loc.typeref;
                    dynamicent = loc.dynamicent;
                }
            }
        }
    }
    
    /#
        if ( issubstr( closestref, "<dev string:x2be>" ) )
        {
            println( "<dev string:x2c6>" );
        }
    #/
    
    id = -1;
    
    if ( isdefined( closestref ) )
    {
        id = function_2f5f4ceceab0f826( closestref );
        self setclientomnvar( "ui_tom_previous_selection", id );
        self.forcedspawncameraref = closestref;
        thread function_420cf845661ed8d3();
        
        if ( issubstr( closestref, "squad" ) && dynamicent )
        {
            thread function_7d83478f3b710467( dynamicent );
        }
        
        return;
    }
    
    self setclientomnvar( "ui_tom_previous_selection", -1 );
    self.forcedspawncameraref = undefined;
}

// Namespace spawnselection
// Params 1
// Checksum 0xc51e6a77, Offset: 0x781e
// Size: 0x4dd
function getstaticcameraposition( team )
{
    staticspawncamera = spawnstruct();
    
    if ( isdefined( level.var_df44da1a31f642fe ) && isdefined( level.var_c5481112b07bd294 ) )
    {
        staticspawncamera.origin = level.var_df44da1a31f642fe;
        staticspawncamera.angles = level.var_c5481112b07bd294;
        return staticspawncamera;
    }
    
    assert( isdefined( game_utility::getlocaleid() ), "<dev string:x2fa>" );
    
    if ( level.mapname == "mp_locale_test" )
    {
        switch ( level.localeid )
        {
            case #"hash_369d96655b32d0ca":
                if ( team == "axis" )
                {
                    staticspawncamera.origin = ( 2094, -1804, 2763 );
                    staticspawncamera.angles = ( 54, 40, 0 );
                }
                else
                {
                    staticspawncamera.origin = ( 2315, 1956, 2763 );
                    staticspawncamera.angles = ( 54, 296, 0 );
                }
                
                break;
            case #"hash_369d97655b32d25d":
                if ( team == "axis" )
                {
                    staticspawncamera.origin = ( 5556, -1368, 2464 );
                    staticspawncamera.angles = ( 56, 42, 0 );
                }
                else
                {
                    staticspawncamera.origin = ( 5636, 1630, 2446 );
                    staticspawncamera.angles = ( 56, 307, 0 );
                }
                
                break;
            default:
                if ( team == "axis" )
                {
                    staticspawncamera.origin = ( 0, 0, 0 );
                    staticspawncamera.angles = ( 0, 0, 0 );
                }
                else
                {
                    staticspawncamera.origin = ( 0, 0, 0 );
                    staticspawncamera.angles = ( 0, 0, 0 );
                }
                
                break;
        }
    }
    else
    {
        switch ( level.localeid )
        {
            case #"hash_369d95655b32cf37":
                if ( team == "axis" )
                {
                    staticspawncamera.origin = ( 30965, 28984, 12785 );
                    staticspawncamera.angles = ( 53, 82, 0 );
                }
                else
                {
                    staticspawncamera.origin = ( 35294, 53430, 12785 );
                    staticspawncamera.angles = ( 50, 260, 0 );
                }
                
                break;
            case #"hash_369d96655b32d0ca":
                if ( team == "axis" )
                {
                    staticspawncamera.origin = ( 35294, 53430, 12785 );
                    staticspawncamera.angles = ( 50, 260, 0 );
                }
                else
                {
                    staticspawncamera.origin = ( 30965, 28984, 12785 );
                    staticspawncamera.angles = ( 53, 82, 0 );
                }
                
                break;
            case #"hash_369d97655b32d25d":
                if ( team == "axis" )
                {
                    staticspawncamera.origin = ( 0, 0, 0 );
                    staticspawncamera.angles = ( 0, 0, 0 );
                }
                else
                {
                    staticspawncamera.origin = ( 0, 0, 0 );
                    staticspawncamera.angles = ( 0, 0, 0 );
                }
                
                break;
            case #"hash_2cd7bb8e90f46c32":
            case #"hash_2cdb2a8e90f75986":
            case #"hash_2cdb2d8e90f75e3f":
                staticspawncamera.origin = ( 6000, -46000, 19500 );
                staticspawncamera.angles = ( 73, 130, 0 );
                break;
            case #"hash_2ce1348e90fbe672":
            case #"hash_2ce1358e90fbe805":
                staticspawncamera.origin = ( -33000, -23775, 12650 );
                staticspawncamera.angles = ( 82, 111, 0 );
                break;
            default:
                if ( team == "axis" )
                {
                    staticspawncamera.origin = ( 0, 0, 0 );
                    staticspawncamera.angles = ( 0, 0, 0 );
                }
                else
                {
                    staticspawncamera.origin = ( 0, 0, 0 );
                    staticspawncamera.angles = ( 0, 0, 0 );
                }
                
                break;
        }
    }
    
    return staticspawncamera;
}

// Namespace spawnselection
// Params 0
// Checksum 0xa7ed2974, Offset: 0x7d04
// Size: 0x15d
function function_ceff7e3b58ecd747()
{
    if ( getdvarint( @"hash_9d53a38d10c6bbc5", 0 ) > 0 )
    {
        return getdvarint( @"hash_9d53a38d10c6bbc5", 0 );
    }
    
    if ( !isdefined( level.localeid ) )
    {
        return 7000;
    }
    
    if ( level.mapname == "mp_locale_test" )
    {
        switch ( level.localeid )
        {
            case #"hash_369d96655b32d0ca":
                return 7000;
            case #"hash_369d97655b32d25d":
                return 7000;
            case #"hash_369d88655b32bac0":
                return 7000;
            case #"hash_369d89655b32bc53":
                return 7000;
            case #"hash_2cd7bf8e90f4727e":
                return 12000;
            default:
                return 7000;
        }
        
        return;
    }
    
    switch ( level.localeid )
    {
        case #"hash_369d95655b32cf37":
            return 7000;
        case #"hash_369d96655b32d0ca":
            return 8000;
        case #"hash_369d97655b32d25d":
            return 8000;
        case #"hash_369d88655b32bac0":
            return 8000;
        case #"hash_369d89655b32bc53":
            return 8000;
        case #"hash_2cd4bf8e90f233e7":
            return 7000;
        case #"hash_2cd4be8e90f23254":
            return 5000;
        case #"hash_2cd7bf8e90f4727e":
            return 12000;
        default:
            return 7000;
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x2c9004ba, Offset: 0x7e69
// Size: 0x14e
function updatefobindanger()
{
    if ( !level.usespawnselection )
    {
        return;
    }
    
    level thread updatefobspawnsindanger();
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            foreach ( entry in level.availablespawnlocations[ team ] )
            {
                selected = level.spawnselectionlocations[ entry ][ team ];
                
                if ( isdefined( selected ) && isdefined( selected.objectivekey ) )
                {
                    selected.indanger = isobjectiveindanger( selected.objectivekey, team );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0x4ee681e5, Offset: 0x7fbf
// Size: 0x421
function updatefobspawnsindanger()
{
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    while ( !isdefined( level.spawnselectionlocations ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        foreach ( team in level.teamnamelist )
        {
            testplayer = teams::getteamdata( team, "players" )[ 0 ];
            
            foreach ( location in level.availablespawnlocations[ team ] )
            {
                if ( !issubstr( location, "HQ" ) && issubstr( location, "fob" ) )
                {
                    canuseprimary = 1;
                    canusefallback = isdefined( level.spawnglobals.spawnsets[ location + "_safe_" + team ] );
                    primaryset = location + "_" + team;
                    fallbackset = undefined;
                    
                    if ( canusefallback )
                    {
                        fallbackset = location + "_safe_" + team;
                    }
                    
                    if ( isdefined( level.spawninfluencezones ) )
                    {
                        trigger = undefined;
                        keys = getarraykeys( level.spawninfluencezones );
                        
                        foreach ( key in keys )
                        {
                            if ( key == location )
                            {
                                trigger = level.spawninfluencezones[ key ];
                                break;
                            }
                        }
                        
                        if ( isdefined( trigger ) && trigger function_d3a9fc8fb733aee8( team_utility::getenemyteams( team ) ) )
                        {
                            canuseprimary = 0;
                        }
                    }
                    
                    indanger = 0;
                    
                    if ( isdefined( testplayer ) )
                    {
                        primarybucket = undefined;
                        fallbackbucket = undefined;
                        
                        if ( canuseprimary )
                        {
                            if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
                            {
                                if ( isdefined( level.spawnselectionlocations[ location ][ team ].spawngroup ) )
                                {
                                    var_b2a4d126ec8dec3 = level.spawnselectionlocations[ location ][ team ].spawngroup;
                                }
                                
                                primarybucket = function_605cd231d4da14a7( testplayer, var_b2a4d126ec8dec3 ) ?? 1;
                            }
                            else
                            {
                                spawnlogic::activatespawnset( primaryset, 1 );
                                primarybucket = testplayer getspawnbucketforplayer();
                                primarybucket = spawnlogic::getspawnbucketfromstring( primarybucket );
                            }
                        }
                        
                        if ( canusefallback )
                        {
                            if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
                            {
                                if ( isdefined( level.spawnselectionlocations[ location ][ team ].spawngroup ) )
                                {
                                    var_b2a4d126ec8dec3 = level.spawnselectionlocations[ location ][ team ].spawngroup;
                                }
                                
                                fallbackbucket = 1;
                            }
                            else
                            {
                                spawnlogic::activatespawnset( fallbackset, 1 );
                                fallbackbucket = testplayer getspawnbucketforplayer();
                                fallbackbucket = spawnlogic::getspawnbucketfromstring( fallbackbucket );
                            }
                        }
                        
                        if ( canuseprimary && canusefallback )
                        {
                            indanger = primarybucket >= 2 && fallbackbucket >= 2;
                        }
                        else if ( canuseprimary && !canusefallback )
                        {
                            indanger = primarybucket >= 2;
                        }
                        else if ( canusefallback )
                        {
                            indanger = fallbackbucket >= 2;
                        }
                    }
                    
                    objectivekey = level.spawnselectionlocations[ location ][ team ].objectivekey;
                    level.objectives[ objectivekey ].spawnpointdanger = indanger;
                    level.objectives[ objectivekey ].spawnpointdangertime = gettime();
                }
            }
        }
        
        wait 1;
    }
}

// Namespace spawnselection
// Params 3
// Checksum 0xbafe3ef4, Offset: 0x83e8
// Size: 0x35e
function updatespecificfobindanger( location, player, team )
{
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    objectivekey = level.spawnselectionlocations[ location ][ team ].objectivekey;
    
    if ( !( isdefined( objectivekey ) && isdefined( level.objectives[ objectivekey ] ) && isdefined( level.objectives[ objectivekey ].spawnpointdangertime ) ) || level.objectives[ objectivekey ].spawnpointdangertime == gettime() )
    {
        return;
    }
    
    canuseprimary = 1;
    canusefallback = isdefined( level.spawnglobals.spawnsets[ location + "_safe_" + team ] );
    primaryset = location + "_" + team;
    fallbackset = undefined;
    
    if ( canusefallback )
    {
        fallbackset = location + "_safe_" + team;
    }
    
    if ( isdefined( level.spawninfluencezones ) )
    {
        trigger = undefined;
        keys = getarraykeys( level.spawninfluencezones );
        
        foreach ( key in keys )
        {
            if ( key == location )
            {
                trigger = level.spawninfluencezones[ key ];
                break;
            }
        }
        
        if ( isdefined( trigger ) && trigger.numplayers[ team_utility::getotherteam( team ) ] > 0 )
        {
            canuseprimary = 0;
        }
    }
    
    indanger = 0;
    
    if ( isdefined( player ) )
    {
        primarybucket = undefined;
        fallbackbucket = undefined;
        
        if ( canuseprimary )
        {
            if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
            {
                if ( isdefined( level.spawnselectionlocations[ location ][ team ].spawngroup ) )
                {
                    var_b2a4d126ec8dec3 = level.spawnselectionlocations[ location ][ team ].spawngroup;
                }
                
                primarybucket = function_605cd231d4da14a7( player, var_b2a4d126ec8dec3 ) ?? 1;
            }
            else
            {
                spawnlogic::activatespawnset( primaryset, 1 );
                primarybucket = player getspawnbucketforplayer();
                primarybucket = spawnlogic::getspawnbucketfromstring( primarybucket );
            }
        }
        
        if ( canusefallback )
        {
            if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
            {
                if ( isdefined( level.spawnselectionlocations[ location ][ team ].spawngroup ) )
                {
                    var_b2a4d126ec8dec3 = level.spawnselectionlocations[ location ][ team ].spawngroup;
                }
                
                fallbackbucket = 1;
            }
            else
            {
                spawnlogic::activatespawnset( fallbackset, 1 );
                fallbackbucket = player getspawnbucketforplayer();
                fallbackbucket = spawnlogic::getspawnbucketfromstring( fallbackbucket );
            }
        }
        
        if ( canuseprimary && canusefallback )
        {
            indanger = primarybucket >= 2 && fallbackbucket >= 2;
        }
        else if ( canuseprimary && !canusefallback )
        {
            indanger = primarybucket >= 2;
        }
        else if ( canusefallback )
        {
            indanger = fallbackbucket >= 2;
        }
    }
    
    level.objectives[ objectivekey ].spawnpointdanger = indanger;
    level.objectives[ objectivekey ].spawnpointdangertime = gettime();
}

// Namespace spawnselection
// Params 0
// Checksum 0x688df23e, Offset: 0x874e
// Size: 0x128
function function_d39843733e6b342c()
{
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    
    if ( isdefined( level.var_1313d7a16469ab73[ self.team ].marker.objidnum ) )
    {
        objidpoolmanager::objective_playermask_addshowplayer( level.var_1313d7a16469ab73[ self.team ].marker.objidnum, self );
    }
    
    while ( self.inspawnselection )
    {
        waitframe();
    }
    
    if ( isdefined( level.var_1313d7a16469ab73[ "axis" ].marker.objidnum ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.var_1313d7a16469ab73[ "axis" ].marker.objidnum, self );
    }
    
    if ( isdefined( level.var_1313d7a16469ab73[ "allies" ].marker.objidnum ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.var_1313d7a16469ab73[ "allies" ].marker.objidnum, self );
    }
}

// Namespace spawnselection
// Params 0
// Checksum 0xcd8c87a1, Offset: 0x887e
// Size: 0x138
function function_341fbb6914aa9273()
{
    if ( !( isdefined( level.gw_objstruct ) && isdefined( level.gw_objstruct.allieshqloc ) && isdefined( level.gw_objstruct.allieshqloc.marker ) ) )
    {
        return;
    }
    
    if ( self.team == "allies" )
    {
        if ( level.var_b17e4d64b50fbb75 )
        {
            objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.allieshqloc.marker.objidnum, self );
        }
        else
        {
            objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.allieshqloc.marker.objidnum, self );
        }
        
        return;
    }
    
    if ( level.var_b17e4d64b50fbb75 )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.axishqloc.marker.objidnum, self );
        return;
    }
    
    objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.axishqloc.marker.objidnum, self );
}

// Namespace spawnselection
// Params 0
// Checksum 0xd7f2baeb, Offset: 0x89be
// Size: 0x138
function function_6fbe1a9ef2181384()
{
    if ( !( isdefined( level.gw_objstruct ) && isdefined( level.gw_objstruct.allieshqloc ) && isdefined( level.gw_objstruct.allieshqloc.marker ) ) )
    {
        return;
    }
    
    if ( self.team == "allies" )
    {
        if ( level.var_3bc45e5a882b3afe )
        {
            objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.allieshqloc.marker.objidnum, self );
        }
        else
        {
            objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.allieshqloc.marker.objidnum, self );
        }
        
        return;
    }
    
    if ( level.var_3bc45e5a882b3afe )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.gw_objstruct.axishqloc.marker.objidnum, self );
        return;
    }
    
    objidpoolmanager::objective_playermask_addshowplayer( level.gw_objstruct.axishqloc.marker.objidnum, self );
}

// Namespace spawnselection
// Params 5
// Checksum 0x4f0de1c3, Offset: 0x8afe
// Size: 0xa9
function function_c85cca8934015666( spawnkey, spawnvalue, team, areaoffset = ( 0, 0, 0 ), selectionorigin = undefined )
{
    spawnset = team == game[ "attackers" ] ? #"hash_f2877540300e3914" : #"hash_ed1af1d4ab683fc0";
    typeref = function_b23d8dc33da1012d( team );
    addspawnselection( #"hq", spawnset, spawnkey, spawnvalue, team, typeref, undefined, areaoffset, selectionorigin );
    return typeref;
}

// Namespace spawnselection
// Params 6
// Checksum 0xb4161a23, Offset: 0x8bb0
// Size: 0x122
function function_7b975293307a51ea( spawnkey, var_a5d26aa00d7e25b5, var_84f507eff4cc97a1, objectivekey = undefined, areaoffset = ( 0, 0, 0 ), selectionorigin = undefined )
{
    typeref = function_cd2a2ce648fb8544();
    spawnsetgroup = function_2a3fc78ad3e5e3b3( typeref );
    
    if ( var_a5d26aa00d7e25b5 )
    {
        attackerspawnset = function_1d22a5b6bd75ceac( typeref, 1 );
        addspawnselection( spawnsetgroup, attackerspawnset, spawnkey, var_a5d26aa00d7e25b5, game[ "attackers" ], typeref, objectivekey, areaoffset, selectionorigin );
    }
    
    if ( var_84f507eff4cc97a1 )
    {
        defenderspawnset = function_1d22a5b6bd75ceac( typeref, 0 );
        addspawnselection( spawnsetgroup, defenderspawnset, spawnkey, var_84f507eff4cc97a1, game[ "defenders" ], typeref, objectivekey, areaoffset, selectionorigin );
    }
    
    if ( isdefined( objectivekey ) && !isdefined( level.objectives[ objectivekey ].objidnum ) )
    {
        level.objectives[ objectivekey ].objidnum = objectivekey;
    }
    
    return typeref;
}

// Namespace spawnselection
// Params 3
// Checksum 0x82c04985, Offset: 0x8cdb
// Size: 0x1db
function function_41267189197b18e5( var_c7f618e57f2b527 = 1.2, var_718e6b9e8471987c = 1000, var_374e1ba52c0ef743 = 90 )
{
    attackerhq = function_b23d8dc33da1012d( game[ "attackers" ] );
    defenderhq = function_b23d8dc33da1012d( game[ "defenders" ] );
    attackerstart = level.spawnselectionlocations[ attackerhq ][ game[ "attackers" ] ].origin;
    defenderstart = level.spawnselectionlocations[ defenderhq ][ game[ "defenders" ] ].origin;
    attackerdirection = vectornormalize( defenderstart - attackerstart );
    defenderdirection = attackerdirection * -1;
    midpoint = averagepoint( [ attackerstart, defenderstart ] );
    height = length( attackerstart - defenderstart ) / 2 / tan( var_374e1ba52c0ef743 / 2 ) * var_c7f618e57f2b527 + var_718e6b9e8471987c;
    attackerangles = axistoangles( ( 0, 0, 1 ) * -1, attackerdirection, vectorcross( attackerdirection, ( 0, 0, 1 ) ) );
    defenderangles = axistoangles( ( 0, 0, 1 ) * -1, defenderdirection, vectorcross( defenderdirection, ( 0, 0, 1 ) ) );
    spawncamera::function_44b2ee31180f4f3e( "override" );
    spawncamera::addspawncamera( "override", game[ "attackers" ], midpoint + ( 0, 0, height ), attackerangles );
    spawncamera::addspawncamera( "override", game[ "defenders" ], midpoint + ( 0, 0, height ), defenderangles );
}

// Namespace spawnselection
// Params 1
// Checksum 0xe1926086, Offset: 0x8ebe
// Size: 0x17
function function_ce472062a1df5d9a( disabled )
{
    level.var_3e7bd8426fc8f6e2 = disabled;
}

// Namespace spawnselection
// Params 1
// Checksum 0xf1d46c17, Offset: 0x8edd
// Size: 0x27
function function_448f0b8a570b10cb( var_399cc8b56e538131 = 0 )
{
    level.var_725fae12857bd120 = var_399cc8b56e538131;
    level thread updatefobindanger();
}

// Namespace spawnselection
// Params 1
// Checksum 0x958fd49c, Offset: 0x8f0c
// Size: 0x100
function function_d275ae53fcb5bb77( objectivekey )
{
    foreach ( value in level.spawnselectionlocations )
    {
        foreach ( entry in value )
        {
            if ( entry.objectivekey == objectivekey )
            {
                return entry.typeref;
            }
        }
    }
}

// Namespace spawnselection
// Params 1
// Checksum 0x6753d4e0, Offset: 0x9014
// Size: 0x100
function function_ac7adb731194066d( typeref )
{
    foreach ( value in level.spawnselectionlocations )
    {
        foreach ( entry in value )
        {
            if ( entry.typeref == typeref )
            {
                return entry.objectivekey;
            }
        }
    }
}

// Namespace spawnselection
// Params 2, eflags: 0x4
// Checksum 0x43ce1c46, Offset: 0x911c
// Size: 0x6e
function private function_605cd231d4da14a7( player, var_b2a4d126ec8dec3 )
{
    if ( !level.var_725fae12857bd120 || !var_b2a4d126ec8dec3 )
    {
        return;
    }
    
    spawnpoint = player spawnlogic::getspawnpoint( player, player.pers[ "team" ], var_b2a4d126ec8dec3, var_b2a4d126ec8dec3 );
    return spawnpoint ? spawnlogic::getspawnbucketfromstring( spawnpoint.score ) : 5;
}

// Namespace spawnselection
// Params 9, eflags: 0x4
// Checksum 0xc17ad3dd, Offset: 0x9193
// Size: 0xb1
function private addspawnselection( spawnsetgroup, spawnset, spawnkey, spawnvalue, team, typeref, objectivekey, areaoffset, originoverride )
{
    if ( !typeref )
    {
        return;
    }
    
    spawnlogic::function_3a25709674572ad6( spawnsetgroup, spawnset, spawnkey, spawnvalue, team, 1 );
    spawns = spawnlogic::function_491fcfcdc1232e11( spawnkey, spawnvalue );
    
    if ( spawns.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( originoverride ) )
    {
        originoverride = function_cdb3e3c4e137d83f( spawns );
    }
    
    function_a94137c3c19e4581( spawnsetgroup, typeref, objectivekey, team, originoverride, areaoffset );
    allowspawnlocation( typeref, team );
}

// Namespace spawnselection
// Params 1, eflags: 0x4
// Checksum 0xaf7ad63a, Offset: 0x924c
// Size: 0x97
function private function_cdb3e3c4e137d83f( spawnpoints )
{
    origins = [];
    
    foreach ( spawnpoint in spawnpoints )
    {
        origins[ origins.size ] = spawnpoint.origin;
    }
    
    return averagepoint( origins );
}

// Namespace spawnselection
// Params 1, eflags: 0x4
// Checksum 0x33ddda67, Offset: 0x92ec
// Size: 0x24
function private function_b23d8dc33da1012d( team )
{
    return team == "allies" ? "gw_fob_alliesHQ" : "gw_fob_axisHQ";
}

// Namespace spawnselection
// Params 1, eflags: 0x4
// Checksum 0xb4119329, Offset: 0x9319
// Size: 0x93
function private function_2a3fc78ad3e5e3b3( typeref )
{
    data = function_31c64eb0381d7e19();
    
    foreach ( entry in data )
    {
        if ( entry[ 0 ] == typeref )
        {
            return entry[ 1 ];
        }
    }
}

// Namespace spawnselection
// Params 2, eflags: 0x4
// Checksum 0x660f1a21, Offset: 0x93b4
// Size: 0xa6
function private function_1d22a5b6bd75ceac( typeref, isattacker )
{
    data = function_31c64eb0381d7e19();
    
    foreach ( entry in data )
    {
        if ( entry[ 0 ] == typeref )
        {
            return entry[ isattacker ? 2 : 3 ];
        }
    }
}

// Namespace spawnselection
// Params 0, eflags: 0x4
// Checksum 0xd769658f, Offset: 0x9462
// Size: 0x14f
function private function_31c64eb0381d7e19()
{
    data = [ [ "gw_fob_01", #"fob_1", #"hash_b1d5379091af3984", #"hash_fe0cd6af57f63c70" ], [ "gw_fob_02", #"fob_2", #"hash_e2ddeb514ddbf2db", #"hash_78fabe9d744550e3" ], [ "gw_fob_03", #"fob_3", #"hash_e5ec9291a3dbcf7a", #"hash_8452261841db8836" ], [ "gw_fob_04", #"fob_4", #"hash_f3848d8a25812f19", #"hash_941e4f7dfd79dcd9" ], [ "gw_fob_05", #"fob_5", #"hash_79c5b45e6623d8b0", #"hash_7d9ddaff715e44c" ], [ "gw_fob_06", #"fob_6", #"hash_4a45f96a51efeff7", #"hash_3cbba9083f93ae4f" ] ];
    return data;
}

// Namespace spawnselection
// Params 0, eflags: 0x4
// Checksum 0x8606e6ff, Offset: 0x95ba
// Size: 0xd0
function private function_cd2a2ce648fb8544()
{
    fobdata = function_31c64eb0381d7e19();
    var_7194143c0a3a697 = [];
    
    for ( i = 0; i < fobdata.size ; i++ )
    {
        var_7194143c0a3a697[ var_7194143c0a3a697.size ] = fobdata[ i ][ 0 ];
    }
    
    var_aec32871b3c74325 = getarraykeys( level.spawnselectionlocations );
    
    foreach ( typeref in var_7194143c0a3a697 )
    {
        if ( !arraycontains( var_aec32871b3c74325, typeref ) )
        {
            return typeref;
        }
    }
}

/#

    // Namespace spawnselection
    // Params 0, eflags: 0x4
    // Checksum 0x1227b5df, Offset: 0x9692
    // Size: 0x19c, Type: dev
    function private function_ae91d2c57b3cff03()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( level.players.size > 0 )
            {
                player = level.players[ 0 ];
                teamhash = player.team == game[ "<dev string:x340>" ] ? #"hash_7118f9343873352b" : #"hash_ce911e3bbe99421f";
                
                foreach ( objective in level.objectives )
                {
                    if ( objective.var_7f4958ce4e4277c3 != teamhash )
                    {
                        continue;
                    }
                    
                    typeref = function_d275ae53fcb5bb77( objective.objectiveid );
                    selectionlocation = level.spawnselectionlocations[ typeref ][ player.team ];
                    
                    if ( selectionlocation )
                    {
                        color = isobjectiveindanger( objective.objectiveid, player.team ) ? ( 1, 0, 0 ) : ( 0, 1, 0 );
                        print3d( selectionlocation.origin, selectionlocation.typeref, color );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
