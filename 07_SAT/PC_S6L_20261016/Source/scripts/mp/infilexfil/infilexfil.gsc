// scripts\mp\infilexfil\infilexfil.gsc  (hash_462bda75ffa6b33d.gscc) (size: 38198 Bytes / 0x9536 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20d92049 (551100489)
// size ...... 38198 (0x9536)
// includes .. 17  (offset: 0x88fa)
// strings ... 150 (offset: 0x8982)
// dev strs .. 40  (offset: 0x92ea)
// exports ... 77  (offset: 0x61ee)
// cseg ...... 0xfd8 + 0x5216 (0x61ee)
// imports ... 204 (offset: 0x6df6)
// animtree1 . 1   (offset: 0x952a)
// animtree2 . 0   (offset: 0x9536)
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\action_park_utility;
#using scripts\mp\class;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;

#namespace infilexfil;

// Namespace infilexfil
// Params 8
// Checksum 0xaca33935, Offset: 0xff6
// Size: 0x2c1
function infil_add( type, subtype, seat_count, required_seats, fill_order, spawn_func, get_length_func, player_func )
{
    if ( !utility::issharedfuncdefined( #"infil", #"hash_bffc37707880707b" ) )
    {
        utility::registersharedfunc( #"infil", #"hash_bffc37707880707b", &get_all_infils );
    }
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    if ( !isdefined( game[ "infil" ] ) )
    {
        foreach ( team in level.teamnamelist )
        {
            game[ "infil" ][ team ] = [];
        }
        
        game[ "infil" ][ 0 ] = [];
    }
    
    if ( !action_park_utility::is_enabled() && isdefined( game_utility::getlocaleid() ) )
    {
        infils = get_all_infils( type );
        localematched = 0;
        
        foreach ( infil in infils )
        {
            if ( infil.name == subtype )
            {
                if ( infil.script_label == level.localeid )
                {
                    localematched = 1;
                    break;
                }
            }
        }
        
        if ( !localematched )
        {
            return;
        }
    }
    
    if ( isdefined( game[ "infil" ][ 0 ][ type ][ subtype ] ) )
    {
        if ( isdefined( game[ "infil" ][ 0 ][ type ][ subtype ][ 6 ] ) )
        {
            self [[ game[ "infil" ][ 0 ][ type ][ subtype ][ 6 ] ]]( type, subtype );
        }
        
        return;
    }
    
    game[ "infil" ][ 0 ][ type ][ subtype ] = [];
    game[ "infil" ][ 0 ][ type ][ subtype ][ 0 ] = spawn_func;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 1 ] = player_func;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 2 ] = get_length_func;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 3 ] = seat_count;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 4 ] = required_seats;
    game[ "infil" ][ 0 ][ type ][ subtype ][ 5 ] = fill_order;
}

// Namespace infilexfil
// Params 0
// Checksum 0x386fbab5, Offset: 0x12bf
// Size: 0x31
function infil_is_interactive()
{
    if ( !isdefined( level.interactiveinfil ) )
    {
        level.interactiveinfil = getdvarint( @"scr_infil_interactive", 0 ) == 1;
    }
    
    return level.interactiveinfil;
}

// Namespace infilexfil
// Params 0
// Checksum 0x20764d77, Offset: 0x12f9
// Size: 0x7f3
function infil_init()
{
    /#
        level thread function_782d5aff3aa04b32();
        level thread function_3bb47e932df6679d();
        level thread function_af28d51e2307cf01();
    #/
    
    level.infilstartdelay = getmatchrulesdata( "commonOption", "infilStartDelay" );
    level.infilenddelay = getmatchrulesdata( "commonOption", "infilEndDelay" );
    level.infilskip = getmatchrulesdata( "commonOption", "infilSkip" ) == 1 || getdvarint( @"scr_skip_infils", 0 ) > 0;
    level.var_effadc1d337cc03f = &function_effadc1d337cc03f;
    
    if ( game[ "roundsPlayed" ] > 0 && !game_utility::function_bfa35a7c6234a9ad() || level.infilskip || isbrgamemode() || getmatchrulesdata( "commonOption", "matchStartTime" ) < 15 || game_utility::getgametype() == "war" && game_utility::isdonetskmap() )
    {
        game[ "infil" ] = undefined;
        level.requiredplayercount[ "allies" ] = 0;
        level.requiredplayercount[ "axis" ] = 0;
        flags::gameflagset( "infil_setup_complete" );
        return;
    }
    
    if ( !isdefined( level.prematchperiodend ) || level.prematchperiodend == 0 )
    {
        game[ "infil" ] = undefined;
        flags::gameflagset( "infil_setup_complete" );
        return;
    }
    
    while ( !isdefined( level.teamnamelist ) )
    {
        waitframe();
    }
    
    waitframe();
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    
    /#
        setdevdvarifuninitialized( @"scr_infil_allies", "<dev string:x24>" );
        setdevdvarifuninitialized( @"scr_infil_axis", "<dev string:x24>" );
        setdevdvarifuninitialized( @"scr_infil_force_seat", -1 );
        setdevdvarifuninitialized( @"hash_9d06e62e59d8f04a", 0 );
        setdevdvarifuninitialized( @"scr_infil_spectator", 0 );
        setdevdvarifuninitialized( @"scr_infil_required", 0 );
        setdevdvarifuninitialized( @"scr_infil_replay", 0 );
        setdevdvarifuninitialized( @"hash_18ea0d92e10ccd57", 0 );
        setdevdvarifuninitialized( @"hash_7bbcfbdb0042c574", 0 );
        setdevdvarifuninitialized( @"hash_8ecf037ca87f5d9d", 0 );
        setdevdvarifuninitialized( @"scr_infil_title_play", "<dev string:x2c>" );
        setdevdvarifuninitialized( @"hash_f378dd183cf7df0e", 15 );
    #/
    
    level.prematchallowfunc = &infil_player_allow;
    infilduration = undefined;
    level.infilsactive = 0;
    level.var_6d213fbcbdebb011 = 0;
    level.var_940c47c953a2475 = 0;
    
    foreach ( team in level.teamnamelist )
    {
        game[ "infil" ][ team ][ 0 ] = [];
    }
    
    var_49a34b4f7f9a423 = [];
    
    foreach ( infil_data in get_all_infils() )
    {
        if ( action_park_utility::is_enabled() )
        {
            type = infil_data.script_label;
            
            if ( getxhash( infil_data.script_noteworthy ) != action_park_utility::get_combo_label() )
            {
                continue;
            }
        }
        else
        {
            type = infil_data.script_noteworthy;
        }
        
        subtype = infil_data.name;
        
        if ( !infil_data infil_is_gamemode() )
        {
            continue;
        }
        
        if ( !action_park_utility::is_enabled() && isdefined( game_utility::getlocaleid() ) )
        {
            if ( infil_data.name == subtype )
            {
                if ( infil_data.script_label != level.localeid )
                {
                    continue;
                }
            }
        }
        
        if ( level.mapname == "mp_wartorn" && game_utility::getgametype() == "rescue" )
        {
            infil_data.script_team = team_utility::getotherteam( infil_data.script_team );
        }
        
        team = infil_data.script_team;
        
        if ( !arraycontains( var_49a34b4f7f9a423, team ) )
        {
            var_49a34b4f7f9a423[ var_49a34b4f7f9a423.size ] = team;
        }
    }
    
    if ( var_49a34b4f7f9a423.size == level.teamnamelist.size )
    {
        foreach ( infil_data in get_all_infils() )
        {
            if ( action_park_utility::is_enabled() )
            {
                type = infil_data.script_label;
                
                if ( getxhash( infil_data.script_noteworthy ) != action_park_utility::get_combo_label() )
                {
                    continue;
                }
            }
            else
            {
                type = infil_data.script_noteworthy;
            }
            
            subtype = infil_data.name;
            
            if ( !infil_data infil_is_gamemode() )
            {
                continue;
            }
            
            if ( !infil_data function_e7282d311521df52() )
            {
                continue;
            }
            
            if ( infil_data infil_has_map_config() )
            {
                infil_init_spawn_selection();
            }
            
            if ( infil_data infil_is_type( type ) && infil_data infil_is_subtype( subtype ) && team_utility::isgameplayteam( infil_data.script_team ) )
            {
                level.infilsactive++;
                infil_type = game[ "infil" ][ 0 ][ type ][ subtype ];
                originalsubtype = subtype;
                subtypebase = subtype;
                
                if ( issubstr( subtypebase, "alpha" ) )
                {
                    subtypebase = "alpha";
                }
                else if ( issubstr( subtypebase, "bravo" ) )
                {
                    subtypebase = "bravo";
                }
                
                if ( !isdefined( infil_type ) )
                {
                    infil_type = game[ "infil" ][ 0 ][ type ][ subtypebase ];
                }
                
                infil_ent = infil_data [[ infil_type[ 0 ] ]]( infil_data.script_team, infil_data.target, subtypebase, originalsubtype );
                
                if ( isdefined( infil_ent ) )
                {
                    infil_ent.players = [];
                    infil_ent.type = type;
                    infil_ent.originalsubtype = originalsubtype;
                    infil_ent.subtype = subtypebase;
                    infil_ent.infillength = infil_ent [[ infil_type[ 2 ] ]]( originalsubtype );
                }
                
                if ( !isdefined( infilduration ) || infilduration < infil_ent.infillength )
                {
                    infilduration = infil_ent.infillength;
                }
                
                team = infil_data.script_team;
                
                if ( getdvarint( @"hash_ac31997b109b6bc5", 0 ) == 1 )
                {
                    team = team_utility::getotherteam( team );
                }
                
                game[ "infil" ][ team ][ 1 ][ type ][ subtype ] = infil_ent;
                register_infil_spots( team, infil_ent, infil_type[ 3 ], infil_type[ 4 ], infil_type[ 5 ], infil_type[ 1 ] );
            }
        }
    }
    
    if ( game_utility_mp::gamehasinfil() && isdefined( infilduration ) )
    {
        level thread onplayerspawned();
        level thread function_134c194958e1a723();
        level.prematchperiod = getmatchrulesdata( "commonOption", "gracePeriod" );
        level.matchcountdowntime = level.prematchperiod + level.infilstartdelay + level.infilenddelay;
        level.prematchperiodend = infilduration + level.infilstartdelay + level.infilenddelay;
        level.var_3ccf2db75b3f8f10 = infilduration;
        level.var_7745aed442cea368 = 0;
        thread gamelogic_mp::matchstarttimer( "match_starting_in", level.prematchperiod + level.prematchperiodend );
        level thread infil_setup_ui();
        level thread infil_wait_for_players();
        level thread waitandunloadinfils();
        flags::gameflagset( "infil_will_run" );
        
        /#
            level thread function_c339b680cc2c3695();
            level thread function_703f4f135af33125();
        #/
    }
    
    flags::gameflagset( "infil_setup_complete" );
}

// Namespace infilexfil
// Params 0
// Checksum 0xd9f0bcb2, Offset: 0x1af4
// Size: 0x2f, Type: bool
function function_e7282d311521df52()
{
    if ( action_park_utility::is_enabled() )
    {
        return true;
    }
    
    if ( !isdefined( game_utility::getlocaleid() ) )
    {
        return true;
    }
    
    return self.script_label == level.localeid;
}

// Namespace infilexfil
// Params 0
// Checksum 0xa8069616, Offset: 0x1b2c
// Size: 0x38
function onplayerspawned()
{
    level endon( #"infil_started" );
    
    while ( true )
    {
        level waittill( #"player_spawned", player );
        player thread waitforstreamsynccomplete();
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x3f5a2d56, Offset: 0x1b6c
// Size: 0xe3
function function_f8f1a7c7ae375f58( params )
{
    if ( flags::gameflag( "loadout_will_run" ) && !flags::gameflag( "loadout_started" ) )
    {
        if ( isdefined( self.sessionteam ) && team_utility::isgameplayteam( self.sessionteam ) )
        {
            streamorigin = game[ "loadout" ][ self.sessionteam ][ 1 ][ 3 ].origin;
            streamhint::playerstreamhintlocation( streamorigin );
        }
        
        params.waitmsg = "player_active";
        return params;
    }
    
    if ( flags::gameflag( "infil_will_run" ) && !flags::gameflag( "infil_started" ) )
    {
        params.waitmsg = "infil_started";
        params.keepui = 1;
        params.messagelistener = level;
        return params;
    }
    
    return params;
}

// Namespace infilexfil
// Params 0
// Checksum 0x4ec8122c, Offset: 0x1c58
// Size: 0x341
function waitforstreamsynccomplete()
{
    self endon( #"death_or_disconnect" );
    flags::gameflagwait( "infil_setup_complete" );
    
    if ( level.var_7745aed442cea368 )
    {
        return;
    }
    
    level endon( #"infil_started" );
    
    if ( isbot( self ) )
    {
        var_256a0e1825d89c1a = isdefined( level.var_3dbe630eff5d98f0 ) ? level.var_3dbe630eff5d98f0 : 15;
        var_77674b83f8c19bb3 = gettime();
        
        while ( gettime() - var_77674b83f8c19bb3 < var_256a0e1825d89c1a * 1000 )
        {
            if ( flags::gameflag( "infil_started" ) )
            {
                break;
            }
            
            var_1334330ecb93a2a7 = 1;
            
            foreach ( p in level.players )
            {
                if ( p.team != self.team )
                {
                    continue;
                }
                
                if ( isbot( p ) || istestclient( p ) )
                {
                    continue;
                }
                
                if ( !isdefined( get_spot_from_player( p, self.team ) ) )
                {
                    var_1334330ecb93a2a7 = 0;
                    break;
                }
            }
            
            if ( var_1334330ecb93a2a7 )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    if ( isdefined( self.team ) )
    {
        if ( flags::gameflag( "infil_will_run" ) && !flags::gameflag( "prematch_done" ) )
        {
            averageposition = ( 0, 0, 0 );
            count = 0;
            
            if ( isdefined( game[ "infil" ][ self.team ][ 1 ] ) )
            {
                foreach ( array in game[ "infil" ][ self.team ][ 1 ] )
                {
                    foreach ( ent in array )
                    {
                        averageposition += ent.origin;
                        count++;
                    }
                }
            }
            
            if ( count > 0 )
            {
                averageposition /= count;
            }
            
            self function_e19ccf4da1a61ba7( averageposition );
        }
    }
    
    while ( !self.pers[ "streamSyncComplete" ] )
    {
        if ( flags::gameflag( "infil_started" ) )
        {
            break;
        }
        
        waitframe();
    }
    
    var_4d50eb7ad706d7de = get_spot_from_player( self, team_utility::getotherteam( self.team ) );
    
    if ( isdefined( var_4d50eb7ad706d7de ) )
    {
        player_free_spot( self, team_utility::getotherteam( self.team ) );
    }
    
    player_join_infil();
}

// Namespace infilexfil
// Params 1
// Checksum 0xf687300c, Offset: 0x1fa1
// Size: 0x40
function onplayerdisconnect( player )
{
    if ( !isdefined( player.infil ) )
    {
        return;
    }
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    player_free_spot( player, player.team );
}

// Namespace infilexfil
// Params 0
// Checksum 0x949df758, Offset: 0x1fe9
// Size: 0x4a
function onplayerchangeteams()
{
    level endon( #"prematch_over" );
    self endon( #"player_free_spot" );
    team = self.team;
    utility::waittill_any( "joined_team", "joined_spectators" );
    player_free_spot( self, team );
}

// Namespace infilexfil
// Params 1
// Checksum 0xa3de8e91, Offset: 0x203b
// Size: 0x139
function get_all_infils( infil_type )
{
    if ( isdefined( infil_type ) )
    {
        if ( action_park_utility::is_enabled() )
        {
            infils = utility::getstructarray( infil_type, "script_label" );
            active_infils = [];
            
            if ( infils.size > 0 )
            {
                for ( i = 0; i < infils.size ; i++ )
                {
                    struct = infils[ i ];
                    
                    if ( isdefined( struct.script_noteworthy ) && getxhash( struct.script_noteworthy ) == action_park_utility::get_combo_label() )
                    {
                        active_infils[ active_infils.size ] = struct;
                    }
                }
            }
            
            return active_infils;
        }
        else
        {
            return utility::getstructarray( infil_type, "script_noteworthy" );
        }
        
        return;
    }
    
    if ( action_park_utility::is_enabled() )
    {
        infils = utility::getstructarray( "mp_infil", "targetname" );
        active_infils = [];
        
        if ( infils.size > 0 )
        {
            for ( i = 0; i < infils.size ; i++ )
            {
                struct = infils[ i ];
                
                if ( isdefined( struct.script_noteworthy ) && getxhash( struct.script_noteworthy ) == action_park_utility::get_combo_label() )
                {
                    active_infils[ active_infils.size ] = struct;
                }
            }
        }
        
        return active_infils;
    }
    
    return utility::getstructarray( "mp_infil", "targetname" );
}

// Namespace infilexfil
// Params 1
// Checksum 0x7491cedf, Offset: 0x217c
// Size: 0x3c, Type: bool
function infil_is_type( infil_type )
{
    if ( action_park_utility::is_enabled() )
    {
        type = self.script_label;
    }
    else
    {
        type = self.script_noteworthy;
    }
    
    return type == infil_type;
}

// Namespace infilexfil
// Params 1
// Checksum 0x703be3e0, Offset: 0x21c1
// Size: 0x18, Type: bool
function infil_is_subtype( infil_subtype )
{
    return self.name == infil_subtype;
}

// Namespace infilexfil
// Params 0
// Checksum 0xa59ddd10, Offset: 0x21e2
// Size: 0x4e8, Type: bool
function infil_is_gamemode()
{
    /#
        if ( getdvarint( @"scr_infil_run_all", 0 ) == 1 )
        {
            return true;
        }
        
        if ( action_park_utility::is_enabled() )
        {
            type = self.script_label;
        }
        else
        {
            type = self.script_noteworthy;
        }
        
        team = self.script_team;
        allies = getdvar( @"scr_infil_allies", "<dev string:x24>" );
        axis = getdvar( @"scr_infil_axis", "<dev string:x24>" );
        
        if ( team == "<dev string:x2d>" && allies != "<dev string:x24>" )
        {
            return ( allies == type );
        }
        
        if ( team == "<dev string:x34>" && axis != "<dev string:x24>" )
        {
            return ( axis == type );
        }
    #/
    
    if ( !isdefined( self.spawnflags ) || self.spawnflags == 0 )
    {
        return false;
    }
    
    if ( !level.teambased )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_78fc5b05aefc64a", 1 ) == 1 && level.mapname == "mp_jup_grandprix_pm_2" )
    {
        return false;
    }
    
    if ( self.spawnflags & 1 )
    {
        switch ( level.mapname )
        {
            case #"hash_1ab428ea9c0ee9e5":
                if ( level.gametype == "sd" )
                {
                    return false;
                }
                
                break;
            case #"hash_d8bbcfc499e70e6f":
                if ( level.gametype == "sd" )
                {
                    return false;
                }
                
                break;
            case #"hash_9c2fdccb75b37f7e":
                if ( level.gametype == "dd" )
                {
                    return false;
                }
                
                break;
            case #"hash_ae56d5b65ad78351":
                if ( level.gametype == "sd" || level.gametype == "rescue" )
                {
                    return false;
                }
                
                break;
        }
        
        return true;
    }
    
    if ( self.spawnflags & 2 )
    {
        switch ( level.gametype )
        {
            case #"hash_7485fa6c474ec865":
            case #"hash_c3668076a0827ce0":
            case #"hash_d0348787796f73c6":
            case #"hash_ea061d29bbd1f237":
            case #"hash_ec24570718a340f5":
            case #"hash_f6d8634e4c1360d9":
                return true;
        }
    }
    
    if ( self.spawnflags & 4 )
    {
        switch ( level.gametype )
        {
            case #"hash_fa0ed2f6bd4f4395":
            case #"hash_fa50b0f6bd82e972":
                if ( level.mapname == "mp_petrograd" || level.mapname == "mp_piccadilly" )
                {
                    return false;
                }
                else
                {
                    return true;
                }
            case #"hash_ec086b911c1011ec":
                return true;
        }
    }
    
    if ( self.spawnflags & 8 )
    {
        switch ( level.gametype )
        {
            case #"hash_53825b446469ac4c":
            case #"hash_f4a9126c03d3385b":
                return true;
        }
    }
    
    if ( self.spawnflags & 16 )
    {
        switch ( level.gametype )
        {
            case #"hash_6efb0f59a62300fb":
            case #"hash_cf3000550ee7e8b3":
            case #"hash_dd5b900f435d3f36":
            case #"hash_ec72fd25bbbac99e":
            case #"hash_fa34c5f6bd6d4432":
                return true;
        }
    }
    
    if ( self.spawnflags & 32 )
    {
        switch ( level.gametype )
        {
            case #"hash_1a5d186c17c00d3c":
                return true;
        }
    }
    
    if ( self.spawnflags & 64 )
    {
        switch ( level.gametype )
        {
            case #"hash_eb5e5f470e0c1dc2":
                return true;
        }
    }
    
    if ( self.spawnflags & 128 )
    {
        switch ( level.gametype )
        {
            case #"hash_1e4846dca3ccf38":
            case #"hash_ca6516c10db2c95":
            case #"hash_1aac086c17fe5ccb":
            case #"hash_7f9c384a34cc392f":
            case #"hash_9a6f07d0214a87db":
            case #"hash_c065cef60f38490a":
                return true;
        }
    }
    
    if ( self.spawnflags & 256 )
    {
        switch ( level.gametype )
        {
            case #"hash_973d1db8b6644466":
                return true;
        }
    }
    
    if ( self.spawnflags & 512 )
    {
        switch ( level.gametype )
        {
            case #"hash_a1313b745c17c07e":
                return true;
        }
    }
    
    if ( self.spawnflags & 1024 )
    {
        switch ( level.gametype )
        {
            case #"hash_e6d4de8be88215fc":
                return true;
        }
    }
    
    if ( self.spawnflags & 2048 )
    {
        switch ( level.gametype )
        {
            case #"hash_4d60179017f5a28a":
                return true;
        }
    }
    
    return false;
}

// Namespace infilexfil
// Params 0
// Checksum 0x2d937f62, Offset: 0x26d3
// Size: 0x3, Type: bool
function infil_has_map_config()
{
    return false;
}

// Namespace infilexfil
// Params 0
// Checksum 0x8afd3ecb, Offset: 0x26df
// Size: 0x2
function infil_init_spawn_selection()
{
    
}

// Namespace infilexfil
// Params 2
// Checksum 0x4e2f8e58, Offset: 0x26e9
// Size: 0x1b4
function infil_player_allow( allow, bypass )
{
    if ( self ishost() && getdvarint( @"scr_infil_spectator" ) == 1 )
    {
        if ( !allow )
        {
            val::set( "infil_player", "weapon", 0 );
            return;
        }
        
        val::reset_all( "infil_player" );
        return;
    }
    
    if ( !game_utility_mp::teamhasinfil( self.team ) && !bypass )
    {
        playerlogic::playerprematchallow( allow );
        return;
    }
    
    if ( !allow )
    {
        val::set( "infil_player", "allow_movement", 0 );
        val::set( "infil_player", "prone", 0 );
        val::set( "infil_player", "crouch", 0 );
        val::set( "infil_player", "allow_jump", 0 );
        val::set( "infil_player", "fire", 0 );
        val::set( "infil_player", "ads", 0 );
        val::set( "infil_player", "sprint", 0 );
        val::set( "infil_player", "melee", 0 );
        val::set( "infil_player", "lean", 0 );
        val::set( "infil_player", "slide", 0 );
        val::set( "infil_player", "offhand_weapons", 0 );
        val::set( "infil_player", "weapon_switch", 0 );
        val::set( "infil_player", "usability", 0 );
    }
    else
    {
        val::reset_all( "infil_player" );
        val::set( "infil_player", "damage", 0 );
        thread function_e379e51c8fb875e5();
    }
    
    seqdebugprint( "^3[INFIL] player_join_infil: " + self.name + " infil_player_allow() - scriptWeaponSwitch - " + allow );
}

// Namespace infilexfil
// Params 0
// Checksum 0x5c29eb3b, Offset: 0x28a5
// Size: 0x23
function function_e379e51c8fb875e5()
{
    self endon( #"disconnect" );
    
    while ( outofbounds::istouchingoobtrigger() )
    {
        waitframe();
    }
    
    outofbounds::function_9aa3ce7806e04201( self );
}

// Namespace infilexfil
// Params 6
// Checksum 0x34a314eb, Offset: 0x28d0
// Size: 0x258
function register_infil_spots( team, infil, amount, required, fillorder, think_func )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        game[ "infil" ][ team ][ 0 ] = [];
    }
    
    startindex = game[ "infil" ][ team ][ 0 ].size;
    
    for ( i = 0; i < amount ; i++ )
    {
        index = game[ "infil" ][ team ][ 0 ].size;
        
        if ( isdefined( fillorder ) )
        {
            seatfound = 0;
            
            foreach ( priority, seats in fillorder )
            {
                foreach ( seat in seats )
                {
                    if ( seat == index - startindex )
                    {
                        game[ "infil" ][ team ][ 0 ][ index ][ 3 ] = priority;
                        seatfound = 1;
                        break;
                    }
                }
                
                if ( seatfound )
                {
                    break;
                }
            }
        }
        else
        {
            game[ "infil" ][ team ][ 0 ][ index ][ 3 ] = -1;
        }
        
        game[ "infil" ][ team ][ 0 ][ index ][ 0 ] = i;
        game[ "infil" ][ team ][ 0 ][ index ][ 1 ] = infil;
        game[ "infil" ][ team ][ 0 ][ index ][ 2 ] = think_func;
    }
    
    if ( !level.requiredplayercountoveride )
    {
        level.requiredplayercount[ team ] += required;
    }
    
    /#
        if ( getdvarint( @"scr_infil_required" ) > 0 )
        {
            level.requiredplayercount[ team ] = getdvarint( @"scr_infil_required" );
        }
    #/
}

// Namespace infilexfil
// Params 2
// Checksum 0xda1e543d, Offset: 0x2b30
// Size: 0xc8
function player_on_spot( player, spot_index )
{
    if ( !isdefined( game[ "infil" ][ player.team ][ 0 ] ) )
    {
        assertmsg( "<dev string:x39>" );
    }
    
    if ( !isdefined( game[ "infil" ][ player.team ][ 0 ][ spot_index ] ) )
    {
        assertmsg( "<dev string:x75>" );
    }
    
    if ( isdefined( game[ "infil" ][ player.team ][ 0 ][ spot_index ][ 4 ] ) )
    {
        assertmsg( "<dev string:xbf>" );
    }
    
    game[ "infil" ][ player.team ][ 0 ][ spot_index ][ 4 ] = player;
    return game[ "infil" ][ player.team ][ 0 ][ spot_index ];
}

// Namespace infilexfil
// Params 2
// Checksum 0x17d85a61, Offset: 0x2c01
// Size: 0x11a
function player_free_spot( player, team )
{
    player setclientomnvar( "ui_player_in_infil", 0 );
    
    if ( !isdefined( team ) )
    {
        team = player.team;
    }
    
    if ( !isdefined( player.infil ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        assertmsg( "<dev string:xf6>" );
    }
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( is_spot_taken( team, key ) && spot[ 4 ] == player )
        {
            game[ "infil" ][ team ][ 0 ][ key ][ 4 ] = undefined;
            player notify( #"player_free_spot" );
            return;
        }
    }
    
    assertmsg( "<dev string:x132>" );
}

// Namespace infilexfil
// Params 2
// Checksum 0xa26135c4, Offset: 0x2d23
// Size: 0x27
function get_player_at_spot( team, spot_index )
{
    return game[ "infil" ][ team ][ 0 ][ spot_index ][ 4 ];
}

// Namespace infilexfil
// Params 2
// Checksum 0xc11d5333, Offset: 0x2d53
// Size: 0xb9
function get_spot_from_player( player, team = player.team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        return;
    }
    
    foreach ( i, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( spot[ 4 ] == player )
        {
            return i;
        }
    }
}

// Namespace infilexfil
// Params 2
// Checksum 0xc567c2c0, Offset: 0x2e15
// Size: 0x67, Type: bool
function is_spot_taken( team, spot_index )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        assertmsg( "<dev string:x39>" );
    }
    
    if ( !isdefined( game[ "infil" ][ team ][ 0 ][ spot_index ] ) )
    {
        assertmsg( "<dev string:x75>" );
    }
    
    return isdefined( game[ "infil" ][ team ][ 0 ][ spot_index ][ 4 ] );
}

// Namespace infilexfil
// Params 1
// Checksum 0xaeddd8bb, Offset: 0x2e85
// Size: 0xb9
function get_spot_taken_count( team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        assertmsg( "<dev string:x179>" );
    }
    
    count = 0;
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( is_spot_taken( team, key ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace infilexfil
// Params 1
// Checksum 0x8c8b78d9, Offset: 0x2f47
// Size: 0x104
function function_65bb2d9dd9b0e62b( team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        return;
    }
    
    bestspot = undefined;
    bestpriority = 7;
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( !is_spot_taken( team, key ) )
        {
            continue;
        }
        
        player = spot[ 4 ];
        
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isbot( player ) )
        {
            continue;
        }
        
        priority = spot[ 3 ];
        
        if ( !isdefined( bestspot ) || priority < bestpriority )
        {
            bestspot = key;
            bestpriority = priority;
        }
    }
    
    return bestspot;
}

// Namespace infilexfil
// Params 1
// Checksum 0xd1959ded, Offset: 0x3054
// Size: 0x27f
function get_spot_by_priority( team )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return;
    }
    
    force_seat = getdvarint( @"scr_infil_force_seat", -1 );
    
    if ( arraycontains( available_spots, force_seat ) )
    {
        return force_seat;
    }
    
    spots = [];
    bestpriority = -1;
    
    foreach ( spot in available_spots )
    {
        priority = game[ "infil" ][ team ][ 0 ][ spot ][ 3 ];
        
        if ( spots.size == 0 || priority < bestpriority )
        {
            spots = [];
            spots[ spots.size ] = spot;
            bestpriority = priority;
            continue;
        }
        
        if ( priority == bestpriority )
        {
            spots[ spots.size ] = spot;
        }
    }
    
    if ( isbot( self ) )
    {
        foreach ( p in level.players )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            if ( p.team != self.team )
            {
                continue;
            }
            
            if ( p == self )
            {
                continue;
            }
            
            if ( isbot( p ) )
            {
                continue;
            }
            
            if ( isdefined( get_spot_from_player( p, self.team ) ) )
            {
                continue;
            }
            
            if ( spots.size > 1 )
            {
                spots[ 0 ] = undefined;
                
                if ( isint( 0 ) )
                {
                    function_cdc669dbc8ea2101( spots );
                }
            }
            
            break;
        }
    }
    
    return spots[ randomint( spots.size ) ];
}

// Namespace infilexfil
// Params 1
// Checksum 0x1215a372, Offset: 0x32dc
// Size: 0x10b
function get_random_spot( team )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return;
    }
    
    spot = utility::array_random( available_spots );
    
    /#
        force_seat = getdvarint( @"scr_infil_force_seat", -1 );
        
        if ( force_seat == -2 )
        {
            if ( arraycontains( available_spots, 0 ) )
            {
                return 0;
            }
            else if ( arraycontains( available_spots, 2 ) )
            {
                return 2;
            }
            else
            {
                return spot;
            }
        }
        else if ( arraycontains( available_spots, force_seat ) )
        {
            spot = force_seat;
        }
    #/
    
    return spot;
}

// Namespace infilexfil
// Params 1
// Checksum 0xda9df16, Offset: 0x33f0
// Size: 0xae
function get_taken_spot_count( team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        return 0;
    }
    
    count = 0;
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( is_spot_taken( team, key ) )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace infilexfil
// Params 1
// Checksum 0xca9f28bc, Offset: 0x34a7
// Size: 0xbe
function get_taken_spot_percent( team )
{
    if ( !isdefined( game[ "infil" ][ team ][ 0 ] ) )
    {
        return 0;
    }
    
    total = 0;
    count = 0;
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        total++;
        
        if ( is_spot_taken( team, key ) )
        {
            count++;
        }
    }
    
    return count / total;
}

// Namespace infilexfil
// Params 2
// Checksum 0x5f43c844, Offset: 0x356e
// Size: 0xc9
function get_random_spot_in_infil( team, infil )
{
    available_spots = [];
    
    foreach ( key, spot in game[ "infil" ][ team ][ 0 ] )
    {
        if ( spot[ 1 ] != infil )
        {
            continue;
        }
        
        if ( !is_spot_taken( team, key ) )
        {
            available_spots[ available_spots.size ] = key;
        }
    }
    
    if ( available_spots.size == 0 )
    {
        return;
    }
    
    spot = utility::array_random( available_spots );
    return spot;
}

// Namespace infilexfil
// Params 1
// Checksum 0x684a4600, Offset: 0x3640
// Size: 0x55
function infil_player_array_handler( player )
{
    self endon( #"death" );
    self.players[ self.players.size ] = player;
    player waittill( #"death_or_disconnect" );
    self.players = arrayremove( self.players, player );
}

// Namespace infilexfil
// Params 0
// Checksum 0x5ecb73e4, Offset: 0x369d
// Size: 0x29f
function player_join_infil()
{
    seqdebugprint( "^2[INFIL] player_join_infil: CALLED for " + self.name + " | infil_started=" + flags::gameflag( "infil_started" ) );
    
    if ( flags::gameflag( "infil_started" ) )
    {
        seqdebugprint( "^3[INFIL] player_join_infil: infil already started for " + self.name + " \xe2\x80\x94 routing to hide path." );
        outofbounds::enableoobimmunity( self );
        setomnvar( "ui_in_loadout_sequence", 0 );
        self setclientomnvar( "ui_open_menu_from_script", -1 );
        thread infil_hide_latejoins();
        return;
    }
    
    if ( game[ "infil" ][ self.team ].size == 0 )
    {
        return;
    }
    
    if ( self ishost() && getdvarint( @"scr_infil_spectator" ) == 1 )
    {
        player_ai_fill();
        return;
    }
    
    var_430b445196793a58 = 0;
    var_eb67b0c0bca828ba = game[ "infil" ][ self.team ][ 0 ][ 0 ][ 3 ] != -1;
    
    if ( var_430b445196793a58 )
    {
        spot_index = get_spot_taken_count( self.team );
    }
    else if ( var_eb67b0c0bca828ba )
    {
        spot_index = get_spot_by_priority( self.team );
    }
    else
    {
        spot_index = get_random_spot( self.team );
    }
    
    if ( !isdefined( spot_index ) && !isbot( self ) )
    {
        var_19d9164ae966a86a = function_65bb2d9dd9b0e62b( self.team );
        
        if ( isdefined( var_19d9164ae966a86a ) )
        {
            var_e51046c2ec0c3d1f = game[ "infil" ][ self.team ][ 0 ][ var_19d9164ae966a86a ][ 4 ];
            seqdebugprint( "^3[INFIL] player_join_infil: human " + self.name + " evicting bot " + var_e51046c2ec0c3d1f.name + " from seat " + var_19d9164ae966a86a );
            player_free_spot( var_e51046c2ec0c3d1f, self.team );
            var_e51046c2ec0c3d1f.infil = undefined;
            var_e51046c2ec0c3d1f thread infil_hide_latejoins();
            spot_index = var_19d9164ae966a86a;
        }
    }
    
    if ( !isdefined( spot_index ) )
    {
        seqdebugprint( "^3[INFIL] player_join_infil: no seat available for " + self.name + " \xe2\x80\x94 threading hide." );
        outofbounds::enableoobimmunity( self );
        setomnvar( "ui_in_loadout_sequence", 0 );
        self setclientomnvar( "ui_open_menu_from_script", -1 );
        thread infil_hide_latejoins();
        return;
    }
    
    spot = player_on_spot( self, spot_index );
    spot[ 1 ] thread infil_player_array_handler( self );
    self notify( #"hash_a31d992c085a3caa" );
    self.infil = spot[ 1 ];
    self thread [[ spot[ 2 ] ]]( spot[ 1 ], spot[ 0 ] );
    self setclientomnvar( "ui_player_in_infil", 1 );
    outofbounds::enableoobimmunity( self );
    thread onplayerchangeteams();
    thread clearinfilstateatinfilend();
    player_ai_fill();
}

// Namespace infilexfil
// Params 0
// Checksum 0x781327a0, Offset: 0x3944
// Size: 0x49
function clearinfilstateatinfilend()
{
    self endon( #"death_or_disconnect" );
    level waittill( #"prematch_done" );
    self setcinematicmotionoverride( "iw9_playermotion" );
    result = 0;
    
    while ( !result )
    {
        result = self setdemeanorviewmodel( "normal" );
        waitframe();
    }
}

// Namespace infilexfil
// Params 0
// Checksum 0x2247500b, Offset: 0x3995
// Size: 0x30
function blockswaploadouts()
{
    self endon( #"disconnect" );
    self.delayswaploadout = 1;
    level waittill( #"prematch_over" );
    self.delayswaploadout = 0;
}

// Namespace infilexfil
// Params 0
// Checksum 0xd57a30d5, Offset: 0x39cd
// Size: 0xda
function player_ai_fill()
{
    /#
        if ( self ishost() && getdvarint( @"hash_9d06e62e59d8f04a" ) == 1 )
        {
            my_team_count = level.requiredplayercount[ self.team ] - 1;
            
            if ( getdvarint( @"scr_infil_spectator" ) == 1 )
            {
                my_team_count = level.requiredplayercount[ self.team ];
            }
            
            if ( my_team_count > 0 )
            {
                level thread [[ level.bot_funcs[ "<dev string:x1b5>" ] ]]( my_team_count, self.team );
            }
            
            other_team = team_utility::getotherteam( self.team );
            
            if ( level.requiredplayercount[ other_team ] > 0 )
            {
                level thread [[ level.bot_funcs[ "<dev string:x1b5>" ] ]]( level.requiredplayercount[ other_team ], other_team );
            }
        }
    #/
}

// Namespace infilexfil
// Params 0
// Checksum 0x97b055b2, Offset: 0x3aaf
// Size: 0x1da
function infil_setup_ui()
{
    setomnvar( "ui_in_infil", 3 );
    level waittill( #"infil_started" );
    ui_always_show_nameplates = getomnvar( "ui_always_show_nameplates" );
    setomnvar( "ui_always_show_nameplates", 1 );
    
    /#
        setdevdvar( @"forcearchetype", 0 );
    #/
    
    if ( !isdefined( level.bypassclasschoicefunc ) )
    {
        setomnvarforallclients( "ui_skip_loadout", 0 );
        level.bypassclasschoicefunc = undefined;
    }
    
    level thread infil_show_countdown();
    cg_drawcrosshair = getdvarint( @"cg_drawcrosshair" );
    cg_drawcrosshairnames = getdvarint( @"cg_drawcrosshairnames" );
    var_b485f091b524b27d = getdvarint( @"cg_drawfriendlynamesalways" );
    setdvar( @"cg_drawcrosshair", 0 );
    setdvar( @"cg_drawcrosshairnames", 1 );
    setdvar( @"cg_drawfriendlynamesalways", 1 );
    level waittill( #"prematch_done" );
    var_19608eba22f659ee = player::alwaysshowminimap();
    
    foreach ( player in level.players )
    {
        if ( var_19608eba22f659ee )
        {
            player player::showminimap();
            continue;
        }
        
        player player::hideminimap();
    }
    
    setomnvar( "ui_in_infil", -1 );
    setomnvar( "ui_always_show_nameplates", ui_always_show_nameplates );
    setdvar( @"cg_drawcrosshair", cg_drawcrosshair );
    setdvar( @"cg_drawcrosshairnames", cg_drawcrosshairnames );
    setdvar( @"cg_drawfriendlynamesalways", var_b485f091b524b27d );
}

// Namespace infilexfil
// Params 0
// Checksum 0xa5839cd4, Offset: 0x3c91
// Size: 0xa2
function infil_show_countdown()
{
    level endon( #"prematch_done" );
    seqdebugprint( "^3[INFIL] infil_show_countdown: prematchPeriodEnd=" + level.prematchperiodend + " infilEndDelay=" + level.infilenddelay );
    waittime = level.var_3ccf2db75b3f8f10 - level.infilenddelay - 5;
    seqdebugprint( "^3[INFIL] infil_show_countdown: waitTime=" + waittime );
    
    if ( waittime > 0 )
    {
        wait waittime;
        setomnvar( "ui_in_infil", 2 );
        level notify( #"hash_d0924ccc28738943" );
        seqdebugprint( "^3[INFIL] infil_show_countdown: countdown shown." );
        return;
    }
    
    seqdebugprint( "^1[INFIL] infil_show_countdown: waitTime <= 0 \xe2\x80\x94 countdown skipped." );
}

// Namespace infilexfil
// Params 0
// Checksum 0x6f93ebb, Offset: 0x3d3b
// Size: 0xe5
function alwaysgamemodeclass()
{
    clantag = self getclantag();
    
    if ( clantag == "AR" )
    {
        class = "default1";
    }
    else if ( clantag == "SMG" )
    {
        class = "default2";
    }
    else if ( clantag == "LMG" )
    {
        class = "default3";
    }
    else
    {
        randomloadout = [];
        randomloadout[ 0 ] = "default1";
        randomloadout[ 1 ] = "default2";
        randomloadout[ 2 ] = "default3";
        class = utility::array_random( randomloadout );
    }
    
    self.pers[ "class" ] = class;
    self.pers[ "lastClass" ] = "";
    self.class = self.pers[ "class" ];
    self.lastclass = self.pers[ "lastClass" ];
    return class;
}

#using_animtree( "script_model" );

// Namespace infilexfil
// Params 3
// Checksum 0xec90ac3d, Offset: 0x3e29
// Size: 0x1c6
function infil_player_rig( animname, rig_model, set_ground_ref )
{
    self.animname = animname;
    player_rig = spawn( "script_model", ( 0, 0, 0 ) );
    player_rig.player = self;
    self.player_rig = player_rig;
    self.player_rig setmodel( rig_model );
    self.player_rig hide();
    self.player_rig.animname = animname;
    self.player_rig useanimtree( #animtree );
    self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
    self.player_rig.cinematic_motion_override = &handlecinematicmotionnotetrack;
    self.player_rig.dof_func = &handledofnotetrack;
    self playerlinktodelta( self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
    seqdebugprint( "^3[INFIL] infil_player_rig - CREATED RIG - Client: " + self.name + ", animname: " + animname + ", rig: " + isdefined( self.player_rig ) );
    
    if ( set_ground_ref )
    {
        self playersetgroundreferenceent( self.player_rig );
    }
    
    self notify( #"rig_created" );
    utility::waittill_any( "remove_rig", "player_free_spot" );
    
    if ( isdefined( self ) )
    {
        seqdebugprint( "^3[INFIL] infil_player_rig - REMOVING RIG - Client: " + self.name + ", animname: " + animname + ", rig: " + isdefined( self.player_rig ) );
        
        if ( set_ground_ref )
        {
            self playersetgroundreferenceent( undefined );
        }
        
        self unlink();
    }
    
    if ( isdefined( player_rig ) )
    {
        player_rig delete();
    }
}

// Namespace infilexfil
// Params 3
// Checksum 0x6540bd0e, Offset: 0x3ff7
// Size: 0x97
function infil_play_sound_func( alias, notification, stoppable )
{
    foreach ( player in self.players )
    {
        player playsoundtoplayer( alias, player );
    }
}

// Namespace infilexfil
// Params 0
// Checksum 0x7e36d6ca, Offset: 0x4096
// Size: 0x180
function infil_wait_for_players()
{
    level endon( #"game_ended" );
    level endon( #"force_end" );
    level waittill( #"match_start_real_countdown" );
    seqdebugprint( "^3[INFIL] infil_wait_for_players: match_start_real_countdown received." );
    setomnvar( "ui_in_infil", 1 );
    level.var_7745aed442cea368 = 1;
    
    if ( isdefined( level.var_2164f0d68deb0c48 ) )
    {
        seqdebugprint( "^3[INFIL] infil_wait_for_players: WALL PATH \xe2\x80\x94 waiting for loadout_all_players_complete. loadoutSequenceCompleted=" + level.var_a3ee3da214cb8114 );
        
        if ( !level.var_a3ee3da214cb8114 )
        {
            level waittill( #"loadout_all_players_complete" );
            seqdebugprint( "^3[INFIL] infil_wait_for_players: loadout_all_players_complete received \xe2\x80\x94 firing infil_started." );
        }
        else
        {
            seqdebugprint( "^3[INFIL] infil_wait_for_players: loadoutSequenceCompleted already true \xe2\x80\x94 firing infil_started immediately." );
        }
    }
    else
    {
        seqdebugprint( "^3[INFIL] infil_wait_for_players: NO-WALL PATH \xe2\x80\x94 waiting infilStartDelay=" + level.infilstartdelay + "s." );
        wait level.infilstartdelay;
    }
    
    level.var_7cf61b05427fccc2 = randomintrange( 1, 3 );
    
    /#
        takeoverride = getdvarint( @"hash_7bbcfbdb0042c574", 0 );
        
        if ( takeoverride > 0 )
        {
            level.var_7cf61b05427fccc2 = clamp( takeoverride, 1, 3 );
        }
    #/
    
    seqdebugprint( "^3[INFIL] infil_wait_for_players: shared take rolled = " + level.var_7cf61b05427fccc2 + " (both teams will use this take)." );
    seqdebugprint( "^3[INFIL] infil_wait_for_players: FIRING infil_started." );
    flags::gameflagset( "infil_started" );
    level callback::callback( #"infil_start" );
    
    if ( getdvarint( @"scr_infil_interactive_slowmo", 0 ) == 1 )
    {
        level thread manageinteractiveslowmo();
    }
    
    seqdebugprint( "^2[INFIL] infil_wait_for_players: INFIL BEGIN." );
}

// Namespace infilexfil
// Params 1
// Checksum 0x673b004e, Offset: 0x421e
// Size: 0x8f
function heli_path( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        vehicle = self;
        assert( self.code_classname == "<dev string:x1c0>", "<dev string:x1cf>" );
    }
    
    vehicle endon( #"death" );
    
    if ( isdefined( vehicle.hasstarted ) )
    {
        seqdebugprint( "vehicle already moving when triggered with a startmove" );
        return;
    }
    else
    {
        vehicle.hasstarted = 1;
    }
    
    vehicle utility::script_delay();
    vehicle notify( #"start_vehiclepath" );
    vehicle notify( #"start_dynamicpath" );
}

// Namespace infilexfil
// Params 3
// Checksum 0x787e20f9, Offset: 0x42b5
// Size: 0x32e
function vehicle_paths_helicopter( node, var_ad6ef44930971fe1, elevated_heli_path )
{
    assert( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x1f3>" );
    self notify( #"newpath" );
    self endon( #"newpath" );
    self endon( #"death" );
    
    if ( !isdefined( var_ad6ef44930971fe1 ) )
    {
        var_ad6ef44930971fe1 = 0;
    }
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    if ( var_ad6ef44930971fe1 )
    {
        self waittill( #"start_dynamicpath" );
    }
    
    if ( isdefined( elevated_heli_path ) )
    {
        elevated_node = spawnstruct();
        elevated_node.origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + elevated_heli_path );
        heli_wait_node( elevated_node, undefined );
    }
    
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    
    while ( isdefined( nextpoint ) )
    {
        if ( isdefined( nextpoint.script_parameters ) )
        {
            readnodeevents( nextpoint );
        }
        
        if ( isdefined( nextpoint.script_linkto ) )
        {
            set_lookat_from_dest( nextpoint );
        }
        
        heli_wait_node( nextpoint, lastpoint, elevated_heli_path );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.currentnode = nextpoint;
        nextpoint notify( #"trigger", self );
        
        if ( isdefined( nextpoint.script_helimove ) )
        {
            self setyawspeedbyname( nextpoint.script_helimove );
            
            if ( nextpoint.script_helimove == "faster" )
            {
                self setmaxpitchroll( 25, 50 );
            }
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( isdefined( nextpoint.script_unload ) )
        {
            self notify( #"unload" );
            utility::waittill_notify_or_timeout( "unloaded", self.unload_time );
        }
        
        if ( self vehicle_isphysveh() )
        {
            if ( isdefined( nextpoint.script_pathtype ) )
            {
                self.veh_pathtype = nextpoint.script_pathtype;
            }
        }
        
        if ( isdefined( nextpoint.script_flag_wait ) )
        {
            utility::flag_wait( nextpoint.script_flag_wait );
            
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
            }
            
            self notify( #"delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        lastpoint = nextpoint;
        
        if ( !isdefined( nextpoint.target ) )
        {
            break;
        }
        
        nextpoint = [[ get_func ]]( nextpoint.target );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            assertmsg( "<dev string:x218>" + lastpoint.origin );
            break;
        }
    }
    
    self notify( #"reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        self delete();
    }
}

// Namespace infilexfil
// Params 3
// Checksum 0xd734bfeb, Offset: 0x45eb
// Size: 0x485
function heli_wait_node( nextpoint, lastpoint, elevated_heli_path )
{
    self endon( #"newpath" );
    
    if ( isdefined( nextpoint.script_unload ) || isdefined( nextpoint.script_land ) )
    {
        unloadoffset = 0;
        
        if ( isdefined( nextpoint.script_land ) )
        {
            utility::ent_flag_set( "landed" );
            
            if ( isdefined( self.unload_land_offset ) )
            {
                unloadoffset = self.unload_land_offset;
            }
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset ) )
        {
            unloadoffset = self.unload_hover_offset;
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset_max ) )
        {
            groundorg = utility::groundpos( nextpoint.origin );
            unloadoffset = nextpoint.origin[ 2 ] - groundorg[ 2 ];
            
            if ( unloadoffset >= self.unload_hover_offset_max )
            {
                unloadoffset = self.unload_hover_offset_max;
            }
            else if ( unloadoffset < self.unload_hover_land_height )
            {
                unloadoffset = self.unload_hover_land_height;
            }
        }
        
        nextpoint.radius = 2;
        
        if ( isdefined( nextpoint.ground_pos ) )
        {
            nextpoint.origin = nextpoint.ground_pos + ( 0, 0, unloadoffset );
        }
        else
        {
            neworg = utility::groundpos( nextpoint.origin ) + ( 0, 0, unloadoffset );
            
            if ( neworg[ 2 ] > nextpoint.origin[ 2 ] - 2000 )
            {
                nextpoint.origin = utility::groundpos( nextpoint.origin ) + ( 0, 0, unloadoffset );
            }
        }
        
        self sethoverparams( 0, 0, 0 );
    }
    
    if ( isdefined( lastpoint ) )
    {
        airresistance = lastpoint.script_airresistance;
        speed = lastpoint.speed;
        accel = lastpoint.script_accel;
        decel = lastpoint.script_decel;
    }
    else
    {
        airresistance = undefined;
        speed = undefined;
        accel = undefined;
        decel = undefined;
    }
    
    stopnode = istrue( nextpoint.script_stopnode );
    unload = isdefined( nextpoint.script_unload );
    flag_wait = isdefined( nextpoint.script_flag_wait ) && !utility::flag( nextpoint.script_flag_wait );
    var_5bdcdba698716361 = !isdefined( nextpoint.target );
    hasdelay = isdefined( nextpoint.script_delay );
    
    if ( isdefined( nextpoint.angles ) )
    {
        yaw = nextpoint.angles[ 1 ];
    }
    else
    {
        yaw = 0;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    origin = nextpoint.origin;
    
    if ( isdefined( elevated_heli_path ) )
    {
        origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + elevated_heli_path );
    }
    
    if ( isdefined( self.heliheightoverride ) )
    {
        origin = ( origin[ 0 ], origin[ 1 ], self.heliheightoverride );
    }
    
    self vehicle_helisetai( origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, airresistance, hasdelay, stopnode, unload, flag_wait, var_5bdcdba698716361 );
    
    if ( isdefined( nextpoint.radius ) )
    {
        self setneargoalnotifydist( nextpoint.radius );
        assert( nextpoint.radius > 0, "<dev string:x26c>" + nextpoint.radius );
        utility::waittill_any( "near_goal", "goal" );
    }
    else
    {
        self waittill( #"goal" );
    }
    
    /#
        if ( isdefined( nextpoint.script_flag_set ) )
        {
            self notify( #"reached_current_node", nextpoint, nextpoint.script_flag_set );
        }
        else
        {
            self notify( #"reached_current_node", nextpoint );
        }
    #/
    
    if ( isdefined( nextpoint.script_firelink ) )
    {
        if ( !isdefined( level.helicopter_firelinkfunk ) )
        {
            assertmsg( "<dev string:x275>" );
        }
        
        thread [[ level.helicopter_firelinkfunk ]]( nextpoint );
    }
    
    nextpoint utility::script_delay();
    
    if ( isdefined( self.path_gobbler ) )
    {
        utility::deletestruct_ref( nextpoint );
    }
    
    self notify( #"continuepath" );
}

// Namespace infilexfil
// Params 1
// Checksum 0x59c08daa, Offset: 0x4a78
// Size: 0x66
function get_path_getfunc( pathpoint )
{
    get_func = &get_from_vehicle_node;
    
    if ( isdefined( pathpoint.target ) )
    {
        if ( isdefined( get_from_entity( pathpoint.target ) ) )
        {
            get_func = &get_from_entity;
        }
        
        if ( isdefined( get_from_spawnstruct( pathpoint.target ) ) )
        {
            get_func = &get_from_spawnstruct;
        }
    }
    
    return get_func;
}

// Namespace infilexfil
// Params 1
// Checksum 0x621326ba, Offset: 0x4ae7
// Size: 0x1b
function get_from_vehicle_node( target )
{
    return getvehiclenode( target, #targetname );
}

// Namespace infilexfil
// Params 1
// Checksum 0x3519b739, Offset: 0x4b0b
// Size: 0xe8
function get_from_spawnstruct( target )
{
    array = utility::getstructarray( target, "targetname" );
    
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    foreach ( element in array )
    {
        poi_definition = element.script_poi ?? element.poi;
        comp_poi_definition = self.script_poi ?? self.poi;
        
        if ( poi_definition == comp_poi_definition )
        {
            return element;
        }
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x35fd1b1a, Offset: 0x4bfb
// Size: 0x39
function get_from_entity( target )
{
    ent = getentarray( target, #targetname );
    
    if ( ent.size > 0 )
    {
        return ent[ randomint( ent.size ) ];
    }
}

// Namespace infilexfil
// Params 1
// Checksum 0x5a895d24, Offset: 0x4c3d
// Size: 0x4b
function set_lookat_from_dest( dest )
{
    viewtarget = getent( dest.script_linkto, #script_linkname );
    
    if ( !isdefined( viewtarget ) )
    {
        return;
    }
    
    self setlookatent( viewtarget );
    self.set_lookat_point = 1;
}

// Namespace infilexfil
// Params 0
// Checksum 0xd3711ad7, Offset: 0x4c90
// Size: 0x143
function parsehelipathlength()
{
    if ( !isdefined( self.path ) )
    {
        return 0;
    }
    
    if ( isdefined( self.pathduration ) )
    {
        return self.pathduration;
    }
    
    self.pathduration = 0;
    node = self.path;
    speed = node.speed;
    
    while ( true )
    {
        if ( isdefined( node.script_unload ) )
        {
            break;
        }
        
        if ( !isdefined( node.target ) )
        {
            break;
        }
        
        next = utility::getstruct( node.target, "targetname" );
        
        if ( !isdefined( next ) )
        {
            break;
        }
        
        var_a7152c8769488566 = distance( node.origin, next.origin );
        
        if ( isdefined( node.speed ) )
        {
            speed = node.speed;
        }
        
        conversion = 17.6;
        var_8dde742e3dd2cf13 = 1.1;
        self.pathduration += var_a7152c8769488566 * var_8dde742e3dd2cf13 / speed * conversion;
        node = next;
    }
    
    return self.pathduration;
}

// Namespace infilexfil
// Params 1
// Checksum 0x7b1c66ee, Offset: 0x4ddc
// Size: 0xcc
function readnodeevents( node )
{
    events = strtok( node.script_parameters, "," );
    
    foreach ( event in events )
    {
        pair = strtok( event, ":" );
        
        if ( !isdefined( pair ) )
        {
            return;
        }
        
        if ( pair.size != 2 )
        {
            return;
        }
        
        thread processtimelineevent( pair[ 0 ], float( pair[ 1 ] ) );
    }
}

// Namespace infilexfil
// Params 2
// Checksum 0x1bdf3569, Offset: 0x4eb0
// Size: 0x1ec
function processtimelineevent( event, delay )
{
    if ( !isdefined( self.timelineevents ) )
    {
        self.timelineevents = [];
    }
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    switch ( event )
    {
        case #"hash_87e3c1c2828708e4":
            self.timelineevents[ "shake" ] = "low";
            
            foreach ( player in self.infil.players )
            {
                cam_shake_low( player );
            }
            
            break;
        case #"hash_807169c27e9de95b":
            self.timelineevents[ "shake" ] = "off";
            
            foreach ( player in self.infil.players )
            {
                cam_shake_off( player );
            }
            
            break;
        case #"hash_6530846d1804e962":
            self.infil notify( #"event_intro" );
            break;
        case #"hash_75fef6e5f328c5ba":
            self.infil notify( #"hash_a11b6f795181395a" );
            break;
        case #"hash_a92b19adca4b2fbe":
            self.infil notify( #"hash_80ce3e559230877e" );
            break;
    }
}

// Namespace infilexfil
// Params 0
// Checksum 0x8fa6240b, Offset: 0x50a4
// Size: 0x51
function manageinteractiveslowmo()
{
    if ( !( isdefined( level.interactiveinfilstart ) && isdefined( level.interactiveinfilwindow ) ) )
    {
        return;
    }
    
    wait level.interactiveinfilstart;
    setslowmotion( 1, 0.5, 1 );
    wait level.interactiveinfilwindow;
    setslowmotion( 0.5, 1, 0.5 );
}

// Namespace infilexfil
// Params 0
// Checksum 0x54777a5f, Offset: 0x50fd
// Size: 0x31
function waitandunloadinfils()
{
    flags::gameflagwait( "prematch_done" );
    
    while ( level.infilsactive != 0 )
    {
        waitframe();
    }
    
    unloadallinfilintrotransients();
    level notify( #"hash_1ac1a1ca23eff2a1" );
}

// Namespace infilexfil
// Params 0
// Checksum 0x4fdd6500, Offset: 0x5136
// Size: 0xf
function function_134c194958e1a723()
{
    level waittill( #"hash_1ac1a1ca23eff2a1" );
}

/#

    // Namespace infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x34407c72, Offset: 0x514d
    // Size: 0x243, Type: dev
    function private function_c339b680cc2c3695()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_infil_replay", 0 ) == 1 )
            {
                setdvar( @"scr_infil_replay", 0 );
                
                if ( !flags::gameflag( "<dev string:x2b5>" ) )
                {
                    iprintlnbold( "<dev string:x2c3>" );
                    wait 1;
                    continue;
                }
                
                replaycount = getdvarint( @"hash_18ea0d92e10ccd57", 0 ) + 1;
                setdvar( @"hash_18ea0d92e10ccd57", replaycount );
                iprintlnbold( "<dev string:x2f9>" + replaycount );
                flags::gameflagclear( "<dev string:x2b5>" );
                flags::gameflagclear( "<dev string:x31a>" );
                level.var_7745aed442cea368 = 0;
                
                foreach ( team in level.teamnamelist )
                {
                    foreach ( player in level.players )
                    {
                        if ( isdefined( player.infil ) && player.team == team )
                        {
                            player_free_spot( player, team );
                            player.infil = undefined;
                        }
                    }
                }
                
                level thread infil_wait_for_players();
                
                foreach ( player in level.players )
                {
                    player thread waitforstreamsynccomplete();
                }
            }
            
            wait 1;
        }
    }

    // Namespace infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x6edc0039, Offset: 0x5398
    // Size: 0x78, Type: dev
    function private function_782d5aff3aa04b32()
    {
        while ( true )
        {
            if ( getdvar( @"hash_c022d48104ba5fe6", "<dev string:x2c>" ) != "<dev string:x2c>" )
            {
                infilname = getdvar( @"hash_c022d48104ba5fe6", "<dev string:x2c>" );
                setdvar( @"hash_c022d48104ba5fe6", "<dev string:x2c>" );
                setdvar( @"scr_infil_axis", infilname );
                function_9ee7555eff9735de( "<dev string:x34>" );
            }
            
            wait 2;
        }
    }

    // Namespace infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x553d89b2, Offset: 0x5418
    // Size: 0x78, Type: dev
    function private function_3bb47e932df6679d()
    {
        while ( true )
        {
            if ( getdvar( @"hash_f6c08131f5dddab9", "<dev string:x2c>" ) != "<dev string:x2c>" )
            {
                infilname = getdvar( @"hash_f6c08131f5dddab9", "<dev string:x2c>" );
                setdvar( @"hash_f6c08131f5dddab9", "<dev string:x2c>" );
                setdvar( @"scr_infil_allies", infilname );
                function_9ee7555eff9735de( "<dev string:x2d>" );
            }
            
            wait 2;
        }
    }

    // Namespace infilexfil
    // Params 1, eflags: 0x4
    // Checksum 0xa420bc6f, Offset: 0x5498
    // Size: 0x58, Type: dev
    function private function_9ee7555eff9735de( team )
    {
        setdvar( @"scr_force_team", team );
        setdvar( @"scr_skip_infils", 0 );
        setdvar( @"scr_game_graceperiod", 15 );
        setdvar( @"hash_9d06e62e59d8f04a", 1 );
        wait 1;
        map_restart( 1 );
    }

    // Namespace infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x657e8a3d, Offset: 0x54f8
    // Size: 0x85, Type: dev
    function private function_af28d51e2307cf01()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        level endon( #"hash_13e4ea8bc35a7322" );
        level endon( #"game_ended" );
        level.var_2c636cd87b38a25 = 0;
        
        while ( level.var_2c636cd87b38a25 == 0 )
        {
            if ( getdvarint( @"hash_d8f31feda870cbf8", 0 ) == 1 && level.var_2c636cd87b38a25 == 0 )
            {
                level.var_2c636cd87b38a25 = 1;
                level thread infildebugmode();
                return;
            }
            
            waitframe();
        }
    }

    // Namespace infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x246bc988, Offset: 0x5585
    // Size: 0x19c, Type: dev
    function private infildebugmode()
    {
        level notify( #"hash_13e4ea8bc35a7322" );
        level endon( #"hash_45c09276d8e0a791" );
        iprintlnbold( "<dev string:x328>" );
        level.var_e418452b23513498 = 0;
        level.var_ed2f89df2cb7bda0 = 0;
        setdvar( @"scr_skip_infils", 0 );
        setdvar( @"scr_game_graceperiod", 15 );
        hostplayer = gamelogic_mp::gethostplayer( 1 );
        
        if ( !isdefined( hostplayer ) )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_8f57a5a96fe91b32", 1 ) == 0 )
            {
                function_26b3c3ebd441c92d();
            }
            else if ( hostplayer buttonpressed( "<dev string:x33f>" ) )
            {
                setdvar( @"scr_skip_infils", 0 );
                setdvar( @"scr_game_graceperiod", 15 );
                iprintlnbold( "<dev string:x349>" );
                wait 1;
                map_restart();
            }
            else if ( hostplayer buttonpressed( "<dev string:x35f>" ) )
            {
                level.var_e418452b23513498 = !level.var_e418452b23513498;
                
                if ( level.var_e418452b23513498 == 1 )
                {
                    iprintlnbold( "<dev string:x36a>" );
                }
                else
                {
                    iprintlnbold( "<dev string:x381>" );
                }
                
                wait 1;
            }
            else if ( hostplayer buttonpressed( "<dev string:x399>" ) )
            {
                level.var_ed2f89df2cb7bda0 = !level.var_ed2f89df2cb7bda0;
                
                if ( level.var_ed2f89df2cb7bda0 == 1 )
                {
                    setdvar( @"scr_infil_spectator", 1 );
                    iprintlnbold( "<dev string:x3a1>" );
                }
                else
                {
                    setdvar( @"scr_infil_spectator", 0 );
                    iprintlnbold( "<dev string:x3ba>" );
                }
                
                hostplayer noclip();
                wait 1;
            }
            
            waitframe();
        }
    }

    // Namespace infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0x924769e7, Offset: 0x5729
    // Size: 0x1b, Type: dev
    function private function_26b3c3ebd441c92d()
    {
        level notify( #"hash_45c09276d8e0a791" );
        iprintlnbold( "<dev string:x3d4>" );
    }

#/

// Namespace infilexfil
// Params 1
// Checksum 0x534808f5, Offset: 0x574c
// Size: 0x22
function function_4a3fe32760a110f5( waittime )
{
    self endon( #"death_or_disconnect" );
    wait waittime;
    class::blockclasschange();
}

// Namespace infilexfil
// Params 5
// Checksum 0xbdad6d94, Offset: 0x5776
// Size: 0xce
function function_a846ce2a1b306b71( scene_node, vehicle, waittime, animname, infil_type )
{
    if ( !( isdefined( scene_node ) && isdefined( scene_node.target ) ) )
    {
        /#
            iprintlnbold( "<dev string:x3e6>" );
        #/
        
        return;
    }
    
    destructibleversion = getentarray( scene_node.target, #targetname );
    
    if ( !isdefined( destructibleversion[ 0 ] ) )
    {
        /#
            iprintlnbold( "<dev string:x3f6>" );
        #/
        
        return;
    }
    
    destructibleversion[ 0 ].canmove = 1;
    destructibleversion[ 0 ] setscriptablepartstate( "visibility", "hide", 1 );
    wait waittime;
    vehicle delete();
    destructibleversion[ 0 ] setscriptablepartstate( "visibility", "show" );
}

// Namespace infilexfil
// Params 6
// Checksum 0x1a3657c, Offset: 0x584c
// Size: 0xca
function function_a8d031f6c104ce39( scene_node, vehicle_one, vehicle_two, waittime, animname, infil_type )
{
    if ( !( isdefined( scene_node ) && isdefined( scene_node.target ) ) )
    {
        /#
            iprintlnbold( "<dev string:x3e6>" );
        #/
        
        return;
    }
    
    staticversion = getentarray( scene_node.target, #targetname );
    
    if ( !isdefined( staticversion[ 0 ] ) )
    {
        /#
            iprintlnbold( "<dev string:x3f6>" );
        #/
        
        return;
    }
    
    staticversion[ 0 ] hide();
    staticversion[ 1 ] hide();
    wait waittime;
    vehicle_one delete();
    vehicle_two delete();
    staticversion[ 0 ] show();
    staticversion[ 1 ] show();
}

// Namespace infilexfil
// Params 3
// Checksum 0x71a2acc2, Offset: 0x591e
// Size: 0x38
function function_ed011e6b84f7e384( waittime, fadeintime, fadeouttime )
{
    thread utility::letterbox_enable( 1, fadeintime );
    wait waittime - fadeouttime;
    thread utility::letterbox_enable( 0, fadeouttime );
}

// Namespace infilexfil
// Params 1
// Checksum 0xe976cf4d, Offset: 0x595e
// Size: 0xd7
function function_4422d0f51155ea1e( team )
{
    var_420eb6dac9db50e2 = 7;
    infilstate = "outro";
    
    if ( team == "allies" )
    {
        team_name = "_attackers";
        var_420eb6dac9db50e2 = level.var_c1806e47805042c4 ?? var_420eb6dac9db50e2;
        infilstate = level.var_c8e83338a449ac74 ?? infilstate;
    }
    else
    {
        team_name = "_defenders";
        var_420eb6dac9db50e2 = level.var_3ef3ce979094d4a5 ?? var_420eb6dac9db50e2;
        infilstate = level.var_888001864c0dc58b ?? infilstate;
    }
    
    level waittill( #"hash_b1e2f5600e4e8b88" );
    wait var_420eb6dac9db50e2;
    vfxscriptable = function_f0416400ec1024a3( team_name, infilstate );
    level waittill( #"prematch_over" );
    
    if ( action_park_utility::is_enabled() )
    {
        thread function_ffa2c76667b2cb0b();
    }
    
    wait 10;
    vfxscriptable delete();
}

// Namespace infilexfil
// Params 2, eflags: 0x4
// Checksum 0x5a50b6ee, Offset: 0x5a3d
// Size: 0x2de
function private function_f0416400ec1024a3( team_name, infilstate )
{
    mapname = game_utility::getmapname();
    var_a80e97dbe68588ae = ( 0, 0, 0 );
    titleori = ( 0, 0, 0 );
    
    if ( action_park_utility::is_enabled() )
    {
        infil_title = [];
        infil_title_temp = utility::getstructarray( "infil_title" + team_name, "script_label" );
        combo_label = action_park_utility::get_combo_label();
        combo_params = action_park_utility::function_c576bfbce27d7270();
        
        foreach ( element in infil_title_temp )
        {
            if ( getxhash( element.script_noteworthy ) == combo_label || element.script_parameters == combo_params )
            {
                infil_title[ infil_title.size ] = element;
            }
        }
        
        foreach ( element in infil_title )
        {
            if ( getxhash( element.script_noteworthy ) == combo_label || element.script_parameters == combo_params )
            {
                titleori = element.angles;
                var_a80e97dbe68588ae = element.origin;
            }
        }
    }
    else
    {
        infil_title = utility::getstructarray( "override_infil_title" + team_name, "script_noteworthy" );
        
        if ( infil_title.size == 0 )
        {
            infil_title = utility::getstructarray( "infil_title" + team_name, "script_noteworthy" );
        }
        
        if ( isdefined( infil_title ) && infil_title.size != 0 )
        {
            titleori = infil_title[ 0 ].angles;
            var_a80e97dbe68588ae = infil_title[ 0 ].origin;
        }
    }
    
    vfxscriptable = spawn( "script_model", var_a80e97dbe68588ae );
    vfxscriptable.angles = titleori;
    
    if ( mapname == "mp_rex_actionpark_grid_bm" || mapname == "mp_rex_actionpark_grid_ld" || mapname == "mp_rex_actionpark_grid_cip" )
    {
        vfxscriptable setmodel( "vfx_mp_rex_cachette_infil_title" );
        hintscriptable( "vfx_mp_rex_cachette_infil_title", var_a80e97dbe68588ae, 20000 );
    }
    else
    {
        vfxscriptable setmodel( "vfx_" + mapname + "_infil_title" );
        hintscriptable( "vfx_" + mapname + "_infil_title", var_a80e97dbe68588ae, 20000 );
    }
    
    vfxscriptable setscriptablepartstate( "main", infilstate );
    return vfxscriptable;
}

// Namespace infilexfil
// Params 0
// Checksum 0xff1c9e9a, Offset: 0x5d24
// Size: 0x27
function function_970b6d28232de3f2()
{
    seqdebugprint( "^3[AP] waitForFadeUpThenOpenDoor: waiting for pregame_fadeup_begin or loadout_all_assembled" );
    level utility::waittill_any( "pregame_fadeup_begin", "loadout_all_assembled" );
    function_7ddc5a4ddf35157();
}

// Namespace infilexfil
// Params 0
// Checksum 0x931d0522, Offset: 0x5d53
// Size: 0x76
function function_7ddc5a4ddf35157()
{
    seqdebugprint( "^3[AP] openPreMatchScriptableDoor: waitForFadeUpThenOpenDoor - opening door" );
    level.var_b2020b5d75cecf3 utility::function_7c10ea82c1e305b8( "automatic_door", "opening" );
    level.var_aa46efdfdf62ca7c utility::function_7c10ea82c1e305b8( "automatic_door", "opening" );
    level.var_ca417da178d7c093 utility::function_7c10ea82c1e305b8( "automatic_door", "opening" );
    level.var_eea1c1831412959c utility::function_7c10ea82c1e305b8( "automatic_door", "opening" );
}

// Namespace infilexfil
// Params 0
// Checksum 0xba11c928, Offset: 0x5dd1
// Size: 0x76
function function_ffa2c76667b2cb0b()
{
    seqdebugprint( "^3[AP] closePreMatchScriptableDoor: play_title_vfx called \xe2\x80\x94 closing door" );
    level.var_b2020b5d75cecf3 utility::function_7c10ea82c1e305b8( "automatic_door", "closing" );
    level.var_aa46efdfdf62ca7c utility::function_7c10ea82c1e305b8( "automatic_door", "closing" );
    level.var_ca417da178d7c093 utility::function_7c10ea82c1e305b8( "automatic_door", "closing" );
    level.var_eea1c1831412959c utility::function_7c10ea82c1e305b8( "automatic_door", "closing" );
}

// Namespace infilexfil
// Params 2
// Checksum 0xc8cc0554, Offset: 0x5e4f
// Size: 0x176
function function_7fe2bd5aa2b040b2( team, infiltype )
{
    var_97eede01523e6040 = spawn( "script_model", ( 0, 0, 0 ) );
    var_97eede01523e6040 setmodel( "vfx_mp_rex_infil_game" );
    var_97eede01523e6040.animname = "infil_rtt_a";
    var_97eede01523e6040 animation::setanimtree();
    var_5ca3037dea0d3313 = spawn( "script_model", ( 0, 0, 0 ) );
    var_5ca3037dea0d3313 setmodel( "vfx_mp_rex_infil_game" );
    var_5ca3037dea0d3313.animname = "infil_rtt_b";
    var_5ca3037dea0d3313 animation::setanimtree();
    level waittill( #"hash_b1e2f5600e4e8b88" );
    
    if ( var_97eede01523e6040 getscriptableparthasstate( "main", game_utility::getmapname() ) )
    {
        var_97eede01523e6040 setscriptablepartstate( "main", game_utility::getmapname() );
    }
    else
    {
        var_97eede01523e6040 setscriptablepartstate( "main", "base" );
    }
    
    if ( var_5ca3037dea0d3313 getscriptableparthasstate( "main", game_utility::getmapname() ) )
    {
        var_5ca3037dea0d3313 setscriptablepartstate( "main", game_utility::getmapname() );
    }
    else
    {
        var_5ca3037dea0d3313 setscriptablepartstate( "main", "base" );
    }
    
    setomnvar( "ui_infil_gamemode_rtt_enabled", 1 );
    
    if ( isdefined( var_97eede01523e6040 ) )
    {
        thread animation::anim_single_solo( var_97eede01523e6040, infiltype );
    }
    
    if ( isdefined( var_5ca3037dea0d3313 ) )
    {
        thread animation::anim_single_solo( var_5ca3037dea0d3313, infiltype );
    }
    
    level waittill( #"prematch_over" );
    setomnvar( "ui_infil_gamemode_rtt_enabled", 0 );
    var_97eede01523e6040 delete();
    var_5ca3037dea0d3313 delete();
}

// Namespace infilexfil
// Params 0
// Checksum 0x2259c14d, Offset: 0x5fcd
// Size: 0xab
function infil_hide_latejoins()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        seqdebugprint( "^6[INFIL] infil_hide_latejoins: prematch_done already fired for " + self.name + " \xe2\x80\x94 returning immediately." );
        return;
    }
    
    seqdebugprint( "^2[INFIL] infil_hide_latejoins: hiding " + self.name + " immediately." );
    self playerhide( 1 );
    self showtoplayer( self );
    level utility::waittill_any( "prematch_done", "game_ended", "disconnect" );
    seqdebugprint( "^2[INFIL] infil_hide_latejoins: showing " + self.name + " \xe2\x80\x94 match beginning." );
    self playershow( 1 );
}

// Namespace infilexfil
// Params 1
// Checksum 0x9dfd44e6, Offset: 0x6080
// Size: 0x30
function seqdebugprint( msg )
{
    /#
        println( msg );
        return;
    #/
    
    if ( getdvarint( @"loadout_debug", 1 ) )
    {
        logstring( msg );
    }
}

/#

    // Namespace infilexfil
    // Params 0, eflags: 0x4
    // Checksum 0xe5172662, Offset: 0x60b8
    // Size: 0x7b, Type: dev
    function private function_703f4f135af33125()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            team = getdvar( @"scr_infil_title_play", "<dev string:x2c>" );
            
            if ( team == "<dev string:x40e>" || team == "<dev string:x418>" )
            {
                setdvar( @"scr_infil_title_play", "<dev string:x2c>" );
                iprintlnbold( "<dev string:x422>" + team );
                level thread function_34c0fa74903c4c1a( team );
            }
            
            wait 1;
        }
    }

    // Namespace infilexfil
    // Params 1, eflags: 0x4
    // Checksum 0x41d42f6d, Offset: 0x613b
    // Size: 0xb3, Type: dev
    function private function_34c0fa74903c4c1a( team )
    {
        level endon( #"game_ended" );
        infilstate = "<dev string:x44d>";
        
        if ( team == "<dev string:x40e>" )
        {
            team_name = "<dev string:x453>";
            infilstate = level.var_c8e83338a449ac74 ?? infilstate;
        }
        else
        {
            team_name = "<dev string:x45e>";
            infilstate = level.var_888001864c0dc58b ?? infilstate;
        }
        
        vfxscriptable = function_f0416400ec1024a3( team_name, infilstate );
        displaytime = getdvarfloat( @"hash_f378dd183cf7df0e", 15 );
        wait displaytime;
        vfxscriptable delete();
        iprintlnbold( "<dev string:x469>" );
    }

#/
