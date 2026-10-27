// scripts\mp\common\utility\player.gsc  (hash_4f9ce8d249a99f4a.gscc) (size: 33921 Bytes / 0x8481 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd924e3f9 (3643073529)
// size ...... 33921 (0x8481)
// includes .. 14  (offset: 0x7c11)
// strings ... 109 (offset: 0x7c81)
// dev strs .. 17  (offset: 0x83b5)
// exports ... 129 (offset: 0x50b5)
// cseg ...... 0x85c + 0x4859 (0x50b5)
// imports ... 182 (offset: 0x64dd)
// animtree1 . 0   (offset: 0x8481)
// animtree2 . 0   (offset: 0x8481)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\debuff_util;
#using scripts\mp\common\equipment\nvg;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\utility\backpack;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\gametypes\bigctf;
#using scripts\mp\mtx_weapon;
#using scripts\mp\playerlogic;

#namespace player;

// Namespace player
// Params 1
// Checksum 0x322aed13, Offset: 0x87a
// Size: 0x4a, Type: bool
function isreallyalive( player = self )
{
    return isalive( player ) && !player.fauxdead && !player.delayedspawnedplayernotify && !player.liveragdoll;
}

// Namespace player
// Params 1
// Checksum 0xf2da0e41, Offset: 0x8cd
// Size: 0x18, Type: bool
function isinlaststand( player )
{
    return istrue( player.inlaststand );
}

// Namespace player
// Params 1
// Checksum 0x9ce5ad4, Offset: 0x8ee
// Size: 0x21, Type: bool
function ishaywired( player )
{
    return isplayer( player ) && player.ishaywire;
}

// Namespace player
// Params 1
// Checksum 0x2e01d1fd, Offset: 0x918
// Size: 0x3a, Type: bool
function function_74a9f49efde97961( player )
{
    currentweapon = player getcurrentweapon();
    
    if ( !isdefined( currentweapon ) )
    {
        return false;
    }
    
    return isplayer( player ) && player getweaponammoclip( currentweapon ) <= 0;
}

// Namespace player
// Params 1
// Checksum 0xd9963b93, Offset: 0x95b
// Size: 0x21, Type: bool
function function_ac6830fc9a3124c2( player )
{
    return isplayer( player ) && player.var_ac6830fc9a3124c2;
}

// Namespace player
// Params 1
// Checksum 0x1279d369, Offset: 0x985
// Size: 0x21, Type: bool
function function_ed0f4304ef2eb551( player )
{
    return isplayer( player ) && player.var_3895bbf4213f181;
}

// Namespace player
// Params 1
// Checksum 0x707f37d6, Offset: 0x9af
// Size: 0x21, Type: bool
function function_984e56e31791b0b0( player )
{
    return isplayer( player ) && player.var_4c3cd1cf9d1bb58b;
}

// Namespace player
// Params 1
// Checksum 0x797c300a, Offset: 0x9d9
// Size: 0x21, Type: bool
function function_938e97d9c2a28b1a( player )
{
    return isplayer( player ) && player.pinged_by_portable_radar;
}

// Namespace player
// Params 1
// Checksum 0x2b2eb8eb, Offset: 0xa03
// Size: 0x34, Type: bool
function function_1e7ee0fc7e70248( player )
{
    return isdefined( player.var_cc09887c7db65ab5 ) && !player.var_cc09887c7db65ab5 && isinlaststand( player );
}

// Namespace player
// Params 0
// Checksum 0xc4ce5fb0, Offset: 0xa40
// Size: 0xc, Type: bool
function isreviving()
{
    return istrue( self.revivingteammate );
}

// Namespace player
// Params 1
// Checksum 0xce87a726, Offset: 0xa55
// Size: 0x30, Type: bool
function function_73fe5f51164eb3ca( player )
{
    return istrue( player.laststand_syringe_status.var_73fe5f51164eb3ca ) && !level.var_916645300fa04eec;
}

// Namespace player
// Params 1
// Checksum 0xf1c3e2b4, Offset: 0xa8e
// Size: 0xcb
function function_77ae038c7dbd566( damagetype )
{
    if ( isdefined( damagetype ) )
    {
        switch ( damagetype )
        {
            case #"hash_145e286717e1f4c3":
                return level.laststand_syringe_params.headshotprotection;
            case #"hash_1cb749d9b456c694":
                return level.laststand_syringe_params.explosiveprotection;
            case #"hash_e0788d0d9af05c73":
                return level.laststand_syringe_params.worldprotection;
            case #"hash_40a94c5d9e4e265b":
                return level.laststand_syringe_params.meleeprotection;
            case #"hash_ceb098150f024a39":
                return level.laststand_syringe_params.fireprotection;
            default:
                return 0;
        }
    }
    
    return 0;
}

// Namespace player
// Params 1
// Checksum 0x507430a0, Offset: 0xb62
// Size: 0x21, Type: bool
function isaliveandnotinlaststand( player )
{
    return isreallyalive( player ) && !isinlaststand( player );
}

// Namespace player
// Params 1
// Checksum 0x4a205a80, Offset: 0xb8c
// Size: 0x20, Type: bool
function function_ab853a75bb4247a9( player )
{
    return isreallyalive( player ) && isinlaststand( player );
}

// Namespace player
// Params 1
// Checksum 0xc741986d, Offset: 0xbb5
// Size: 0x18, Type: bool
function isarchetype( type )
{
    return type == self.loadoutarchetype;
}

// Namespace player
// Params 0
// Checksum 0x2ffbd5fd, Offset: 0xbd6
// Size: 0xd, Type: bool
function isplayerads()
{
    return self playerads() > 0.5;
}

// Namespace player
// Params 1
// Checksum 0x6665a1f9, Offset: 0xbec
// Size: 0x22
function setthirdpersondof( isenabled )
{
    if ( isenabled )
    {
        setdof_thirdperson();
        return;
    }
    
    setdof_default();
}

// Namespace player
// Params 2
// Checksum 0x42e2e40a, Offset: 0xc16
// Size: 0x1f
function updatesessionstate( sessionstate, statusicon )
{
    player_utility::updatesessionstate( sessionstate, statusicon );
}

// Namespace player
// Params 2
// Checksum 0x71000a5d, Offset: 0xc3d
// Size: 0x138
function getteamarray( team, includeagents )
{
    teamarray = [];
    
    if ( !isdefined( includeagents ) || includeagents )
    {
        foreach ( player in level.characters )
        {
            if ( player.team == team )
            {
                teamarray[ teamarray.size ] = player;
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player.team == team )
            {
                teamarray[ teamarray.size ] = player;
            }
        }
    }
    
    return teamarray;
}

// Namespace player
// Params 2
// Checksum 0x875b7971, Offset: 0xd7e
// Size: 0x171
function get_players_watching( just_spectators = 0, just_killcam = 0 )
{
    entity_num_self = self getentitynumber();
    players_watching = [];
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        var_3279b21a0f3223e8 = 0;
        
        if ( !just_killcam )
        {
            if ( isdefined( player.team ) && ( player.team == "spectator" || player.team == "codcaster" || player.sessionstate == "spectator" ) )
            {
                spectatingplayer = player getspectatingplayer();
                
                if ( spectatingplayer == self )
                {
                    var_3279b21a0f3223e8 = 1;
                }
            }
            
            if ( player.forcespectatorclient == entity_num_self )
            {
                var_3279b21a0f3223e8 = 1;
            }
        }
        
        if ( !just_spectators )
        {
            if ( player.killcamentity == entity_num_self )
            {
                var_3279b21a0f3223e8 = 1;
            }
        }
        
        if ( var_3279b21a0f3223e8 )
        {
            players_watching[ players_watching.size ] = player;
        }
    }
    
    return players_watching;
}

// Namespace player
// Params 6
// Checksum 0x85f264ed, Offset: 0xef8
// Size: 0x119
function set_visionset_for_watching_players( new_visionset, new_visionset_transition_time, var_4bd422067931d885, is_missile_visionset, just_spectators, just_killcam )
{
    players_watching = get_players_watching( just_spectators, just_killcam );
    
    foreach ( player in players_watching )
    {
        player notify( #"hash_60f8fbd69b83ca95" );
        
        if ( is_missile_visionset )
        {
            player visionsetmissilecamforplayer( new_visionset );
        }
        else
        {
            player visionsetnakedforplayer( new_visionset, new_visionset_transition_time );
        }
        
        if ( new_visionset != "" && isdefined( var_4bd422067931d885 ) )
        {
            player thread reset_visionset_on_team_change( self, new_visionset_transition_time + var_4bd422067931d885 );
            player thread reset_visionset_on_disconnect( self );
            
            if ( player isinkillcam() )
            {
                player thread reset_visionset_on_spawn();
            }
        }
    }
}

// Namespace player
// Params 0
// Checksum 0x36a8e72e, Offset: 0x1019
// Size: 0x2b
function reset_visionset_on_spawn()
{
    self endon( #"disconnect" );
    self waittill( #"spawned" );
    self visionsetnakedforplayer( "", 0 );
}

// Namespace player
// Params 2
// Checksum 0xbe6f39c6, Offset: 0x104c
// Size: 0x99
function reset_visionset_on_team_change( current_player_watching, var_61f485df577f537e )
{
    self endon( #"hash_60f8fbd69b83ca95" );
    time_started = gettime();
    team_started = self.team;
    
    while ( gettime() - time_started < var_61f485df577f537e * 1000 )
    {
        if ( self.team != team_started || !arraycontains( current_player_watching get_players_watching(), self ) )
        {
            self visionsetnakedforplayer( "", 0 );
            self notify( #"changing_visionset" );
            break;
        }
        
        waitframe();
    }
}

// Namespace player
// Params 1
// Checksum 0x8abd0d8e, Offset: 0x10ed
// Size: 0x36
function reset_visionset_on_disconnect( entity_watching )
{
    self endon( #"hash_60f8fbd69b83ca95" );
    entity_watching waittill( #"disconnect" );
    self visionsetnakedforplayer( "", 0 );
}

// Namespace player
// Params 1
// Checksum 0x63044a97, Offset: 0x112b
// Size: 0x4b
function restorebasevisionset( fadetime )
{
    if ( level.wpinprogress )
    {
        return;
    }
    
    basevisionset = "";
    
    if ( isdefined( level.var_cd027313d113e09b ) )
    {
        basevisionset = level.var_cd027313d113e09b;
    }
    
    self visionsetnakedforplayer( basevisionset, fadetime );
}

// Namespace player
// Params 0
// Checksum 0x443902ff, Offset: 0x117e
// Size: 0x37
function init_visionsetnight()
{
    if ( isusingmatchrulesdata() )
    {
        nvgvisionset = getmatchrulesdata( "commonOption", "nvgVisionSet" );
        visionsetnight( nvgvisionset );
        return;
    }
    
    visionsetnight( "iw9_mp_nvg_base_color" );
}

// Namespace player
// Params 1
// Checksum 0xf937a397, Offset: 0x11bd
// Size: 0x23
function overridevisionsetnightforlevel( newvisionset )
{
    assert( isdefined( newvisionset ), "<dev string:x24>" );
    visionsetnight( newvisionset );
}

// Namespace player
// Params 0
// Checksum 0x2e86dc69, Offset: 0x11e8
// Size: 0xae
function getuniqueid()
{
    if ( !isdefined( self.pers ) )
    {
        self.pers = [];
    }
    
    if ( isdefined( self.pers[ "guid" ] ) )
    {
        return self.pers[ "guid" ];
    }
    
    playerguid = self getguid();
    
    if ( playerguid == "0000000000000000" )
    {
        if ( isdefined( level.guidgen ) )
        {
            level.guidgen++;
        }
        else
        {
            level.guidgen = 1;
        }
        
        playerguid = "script" + level.guidgen;
    }
    
    self.pers[ "guid" ] = playerguid;
    return self.pers[ "guid" ];
}

// Namespace player
// Params 5
// Checksum 0x8bcb0c8d, Offset: 0x129f
// Size: 0x200
function getplayersinradiusview( origin, radius, desiredteam, excludeent, playersonly )
{
    var_91158a724ebaf546 = [];
    playersinradius = getplayersinradius( origin, radius, undefined, undefined, excludeent, desiredteam );
    
    foreach ( player in playersinradius )
    {
        structcreated = undefined;
        tracepoints = [ player gettagorigin( "j_head" ), player gettagorigin( "j_mainroot" ), player gettagorigin( "tag_origin" ) ];
        
        if ( !isdefined( ignorelist ) )
        {
            ignorelist = level.characters;
        }
        
        if ( excludeent && isarray( excludeent ) )
        {
            arraycombineunique( ignorelist, excludeent );
        }
        else if ( excludeent )
        {
            ignorelist = arraycombineunique( ignorelist, [ excludeent ] );
        }
        
        for ( i = 0; i < tracepoints.size ; i++ )
        {
            if ( !trace::ray_trace_passed( origin, tracepoints[ i ], ignorelist, trace::create_contents( 0, 1, 1, 1, 1, 1 ) ) )
            {
                continue;
            }
            
            if ( !isdefined( structcreated ) )
            {
                if ( playersonly )
                {
                    var_91158a724ebaf546[ var_91158a724ebaf546.size ] = player;
                }
                else
                {
                    var_91158a724ebaf546[ var_91158a724ebaf546.size ] = spawnstruct();
                    var_91158a724ebaf546[ var_91158a724ebaf546.size - 1 ].player = player;
                    var_91158a724ebaf546[ var_91158a724ebaf546.size - 1 ].visiblelocations = [];
                    structcreated = 1;
                }
            }
            
            if ( !playersonly )
            {
                var_91158a724ebaf546[ var_91158a724ebaf546.size - 1 ].visiblelocations[ var_91158a724ebaf546[ var_91158a724ebaf546.size - 1 ].visiblelocations.size ] = tracepoints[ i ];
            }
        }
    }
    
    return var_91158a724ebaf546;
}

// Namespace player
// Params 1
// Checksum 0xadcbadff, Offset: 0x14a8
// Size: 0x7d
function _enablecollisionnotifies( bool )
{
    if ( !isdefined( self.enabledcollisionnotifies ) )
    {
        self.enabledcollisionnotifies = 0;
    }
    
    if ( bool )
    {
        if ( self.enabledcollisionnotifies == 0 )
        {
            self enablecollisionnotifies( 1 );
        }
        
        self.enabledcollisionnotifies++;
    }
    else
    {
        if ( self.enabledcollisionnotifies == 1 )
        {
            self enablecollisionnotifies( 0 );
        }
        
        self.enabledcollisionnotifies--;
    }
    
    assert( self.enabledcollisionnotifies >= 0 );
}

// Namespace player
// Params 1
// Checksum 0x56270706, Offset: 0x152d
// Size: 0x96
function allow_dodge( bool )
{
    if ( self.loadoutarchetype != "archetype_scout" )
    {
        return;
    }
    
    if ( bool )
    {
        if ( !isdefined( self.disableddodge ) )
        {
            self.disableddodge = 0;
        }
        
        self.disableddodge--;
        assert( self.disableddodge >= 0 );
        
        if ( !self.disableddodge )
        {
            self allowdodge( 1 );
        }
        
        return;
    }
    
    if ( !isdefined( self.disableddodge ) )
    {
        self.disableddodge = 0;
    }
    
    self.disableddodge++;
    self allowdodge( 0 );
}

// Namespace player
// Params 2
// Checksum 0x5af132d3, Offset: 0x15cb
// Size: 0x48, Type: bool
function isplayerproxyagent( ent, player )
{
    if ( isagent( ent ) && ent.agent_type == "playerProxy" )
    {
        if ( ent.owner == player )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace player
// Params 2
// Checksum 0x428fd8a4, Offset: 0x161c
// Size: 0x43
function enableragdollzerog( arg, scale )
{
    if ( arg )
    {
        physics_setgravityragdollscalar( scale );
        level.ragdollzerog = 1;
        return;
    }
    
    physics_setgravityragdollscalar( 1 );
    level.ragdollzerog = undefined;
}

// Namespace player
// Params 0
// Checksum 0x6683d1a0, Offset: 0x1667
// Size: 0xc, Type: bool
function isragdollzerog()
{
    return istrue( level.ragdollzerog );
}

// Namespace player
// Params 2
// Checksum 0xf04c1fcb, Offset: 0x167c
// Size: 0xa4
function _visionsetnaked( visionset, time )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isai( player ) )
        {
            continue;
        }
        
        player visionsetnakedforplayer( visionset, time );
    }
}

// Namespace player
// Params 4, eflags: 0x4
// Checksum 0x53a5ec8f, Offset: 0x1729
// Size: 0x284
function private function_cdda5b59decded4e( victim, attacker, var_53b8cce0afd54244, contentoverride )
{
    assert( isent( victim ) );
    deathpos = undefined;
    
    if ( isdefined( victim.origin ) )
    {
        deathpos = victim.origin;
    }
    else if ( isdefined( victim.lastdeathpos ) )
    {
        deathpos = victim.lastdeathpos;
    }
    
    if ( !isdefined( deathpos ) )
    {
        logstring( "Undefined deathPos for death ragdoll 3rd person camera." );
        return;
    }
    
    var_35bbe028f00e6c82 = undefined;
    
    if ( !isdefined( attacker ) || victim == attacker )
    {
        forwardvector = anglestoforward( victim.angles );
        forwardvector = vectornormalize2( forwardvector );
        var_35bbe028f00e6c82 = [ victim ];
    }
    else
    {
        forwardvector = vectornormalize( deathpos - attacker.origin );
        var_35bbe028f00e6c82 = [ victim, attacker ];
    }
    
    baseangles = generateaxisanglesfromforwardvector( forwardvector, ( 0, 0, 1 ) );
    cameradistance = 200;
    stepangle = 30;
    maxsteps = 360 / stepangle;
    validpositions = [];
    
    for ( i = 0; i < maxsteps ; i++ )
    {
        stepvector = anglestoforward( baseangles + ( 0, stepangle * i, 0 ) );
        startposition = deathpos + ( 0, 0, 12 );
        endposition = deathpos + stepvector * cameradistance + ( 0, 0, 150 );
        trace = trace::sphere_trace( startposition, endposition, 2, var_35bbe028f00e6c82, contentoverride );
        
        if ( trace[ "fraction" ] > 0.99 )
        {
            validpositions[ validpositions.size ] = trace[ "position" ];
            
            if ( !var_53b8cce0afd54244 )
            {
                break;
            }
        }
    }
    
    cameraposition = undefined;
    
    if ( validpositions.size > 0 )
    {
        cameraposition = validpositions[ 0 ];
    }
    else
    {
        cameraposition = deathpos + anglestoforward( baseangles ) * 50 + ( 0, 0, 80 );
    }
    
    victimdirection = vectornormalize( deathpos - cameraposition );
    cameradata = spawnstruct();
    cameradata.origin = cameraposition;
    cameradata.angles = vectortoangles( victimdirection );
    cameradata.distance = cameradistance;
    cameradata.validpositions = validpositions;
    return cameradata;
}

// Namespace player
// Params 0, eflags: 0x4
// Checksum 0xcc253a13, Offset: 0x19b6
// Size: 0x9
function private function_230204b1e2875ed0()
{
    player_utility::function_230204b1e2875ed0();
}

// Namespace player
// Params 3
// Checksum 0x42ffc275, Offset: 0x19c7
// Size: 0x27
function function_232d44374eb29c6a( var_a9427f67bd9fcf83, var_53b8cce0afd54244, contentoverride )
{
    return player_utility::function_232d44374eb29c6a( var_a9427f67bd9fcf83, var_53b8cce0afd54244 );
}

// Namespace player
// Params 0
// Checksum 0x6ecfee47, Offset: 0x19f7
// Size: 0x18
function hidehudclear()
{
    self.hidehudenabled = undefined;
    self setclientomnvar( "ui_hide_hud", 0 );
}

// Namespace player
// Params 0
// Checksum 0x9f86b396, Offset: 0x1a17
// Size: 0x27
function suppressminimap()
{
    if ( self.var_e76fefd917d6caab )
    {
        assertmsg( "<dev string:x4d>" );
        return;
    }
    
    self.var_e76fefd917d6caab = 1;
}

// Namespace player
// Params 0
// Checksum 0xc89dd07, Offset: 0x1a46
// Size: 0x2e
function function_649259c611fafe79()
{
    if ( !self.var_e76fefd917d6caab )
    {
        assertmsg( "<dev string:xb4>" );
        return;
    }
    
    self.var_e76fefd917d6caab = undefined;
    refreshminimap();
}

// Namespace player
// Params 1, eflags: 0x4
// Checksum 0x44461a70, Offset: 0x1a7c
// Size: 0x35
function private refreshminimap( forcehide )
{
    if ( self.var_e76fefd917d6caab )
    {
        return;
    }
    
    self setclientomnvar( o"ui_hide_minimap", forcehide || !function_7d29f516998632d1() );
}

// Namespace player
// Params 0
// Checksum 0x4ae728d8, Offset: 0x1ab9
// Size: 0x19, Type: bool
function function_7d29f516998632d1()
{
    if ( alwaysshowminimap() )
    {
        return true;
    }
    
    return self.minimapstatetracker > 0;
}

// Namespace player
// Params 1
// Checksum 0x53636039, Offset: 0x1adb
// Size: 0x83
function hideminimap( forcehide )
{
    if ( alwaysshowminimap() && !forcehide )
    {
        return;
    }
    
    if ( !isdefined( self.minimapstatetracker ) )
    {
        self.minimapstatetracker = 0;
    }
    
    if ( forcehide )
    {
        self.minimapstatetracker = 0;
        refreshminimap( 1 );
        return;
    }
    
    self.minimapstatetracker--;
    
    if ( self.minimapstatetracker < 0 )
    {
        self.minimapstatetracker = 0;
    }
    
    if ( self.minimapstatetracker == 0 )
    {
        refreshminimap();
    }
}

// Namespace player
// Params 0
// Checksum 0x25844abb, Offset: 0x1b66
// Size: 0x38
function showminimap()
{
    if ( !isdefined( self.minimapstatetracker ) )
    {
        self.minimapstatetracker = 0;
    }
    
    self.minimapstatetracker++;
    
    if ( self.minimapstatetracker == 1 )
    {
        refreshminimap();
    }
}

// Namespace player
// Params 0
// Checksum 0xfb13710f, Offset: 0x1ba6
// Size: 0xb
function alwaysshowminimap()
{
    return level.minimaponbydefault;
}

// Namespace player
// Params 2
// Checksum 0x1ec8d9fa, Offset: 0x1bba
// Size: 0xf3
function getlowestclientnum( players, var_8cbd1333e3ec39eb )
{
    lowestclientnum = undefined;
    assert( isdefined( players ), "<dev string:xd9>" );
    
    foreach ( player in players )
    {
        if ( player.team != "spectator" && player.team != "codcaster" && ( !var_8cbd1333e3ec39eb || player isreallyalive() ) )
        {
            if ( !isdefined( lowestclientnum ) || player getentitynumber() < lowestclientnum )
            {
                lowestclientnum = player getentitynumber();
            }
        }
    }
    
    return lowestclientnum;
}

// Namespace player
// Params 4
// Checksum 0x35e7c7d, Offset: 0x1cb6
// Size: 0x11d
function setusingremote( remotename, var_a10bd8be831f302c, allowads, var_cd54d50998b40567 )
{
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 0;
    }
    
    assert( !utility::isusingremote() );
    self.usingremote = remotename;
    
    if ( nvg::function_c58b7b66805088f5() )
    {
        val::set( "usingRemote", "nvg", 0 );
    }
    
    if ( !var_a10bd8be831f302c )
    {
        val::set( "usingRemote", "vehicle_use", 0 );
    }
    
    if ( !allowads )
    {
        val::set( "usingRemote", "ads", 0 );
    }
    
    val::set( "usingRemote", "crate_use", 0 );
    val::set( "usingRemote", "offhand_weapons", 0 );
    val::set( "usingRemote", "ascender_use", 0 );
    white_phosphorus::enableloopingcoughaudiosupression();
    self setclientomnvar( "ui_using_killstreak_remote", 1 );
    self notify( #"using_remote" );
    playerlogic::playerhasmoved();
    
    if ( isstruct( var_cd54d50998b40567 ) )
    {
        thread function_455d7f4febe85ebb( var_cd54d50998b40567 );
    }
}

// Namespace player
// Params 1, eflags: 0x4
// Checksum 0x5da010e2, Offset: 0x1ddb
// Size: 0x69
function private function_455d7f4febe85ebb( var_cd54d50998b40567 )
{
    self endon( #"disconnect" );
    waittillframeend();
    var_de21f97c06719266 = var_cd54d50998b40567.var_de21f97c06719266 ?? [];
    var_de21f97c06719266[ var_de21f97c06719266.size ] = "stopped_using_remote";
    debuff_util::function_91c904a55dd47b6a( var_cd54d50998b40567.var_35a846a6bc3711bd, var_cd54d50998b40567.var_b837f83cb74d3833, var_de21f97c06719266, var_cd54d50998b40567.var_add2dd471396e6f9 );
}

// Namespace player
// Params 0
// Checksum 0x6c9eac58, Offset: 0x1e4c
// Size: 0x19
function getremotename()
{
    assert( utility::isusingremote() );
    return self.usingremote;
}

// Namespace player
// Params 1
// Checksum 0x34b0ac5a, Offset: 0x1e6e
// Size: 0x79
function clearusingremote( bypassweaponswitch )
{
    val::reset_all( "usingRemote" );
    white_phosphorus::disableloopingcoughaudiosupression();
    
    if ( isdefined( self.carryicon ) )
    {
        self.carryicon.alpha = 1;
    }
    
    self.usingremote = undefined;
    
    if ( !isdefined( bypassweaponswitch ) )
    {
        _freezecontrols( 0, undefined, "usingRemote" );
    }
    
    self setclientomnvar( "ui_using_killstreak_remote", 0 );
    self notify( #"stopped_using_remote" );
}

// Namespace player
// Params 3
// Checksum 0x210cdbaf, Offset: 0x1eef
// Size: 0x22a
function _freezecontrols( frozen, force, debug )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self.pers[ "controllerFreezeDebug" ] = [];
    }
    
    if ( frozen )
    {
        assert( !isdefined( force ) );
        self.pers[ "controllerFreezeStack" ]++;
    }
    else if ( force )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
    }
    else
    {
        self.pers[ "controllerFreezeStack" ]--;
    }
    
    if ( isdefined( debug ) )
    {
        if ( getdvarint( @"hash_fc8a67f104cc90a6", 0 ) )
        {
            logstring( "IW9-676465: Player " + self.name + " called _freezeControls( " + frozen + ", " + istrue( force ) + ", \"" + debug + "\" )" );
        }
        
        if ( frozen )
        {
            if ( !isdefined( self.pers[ "controllerFreezeDebug" ][ debug ] ) )
            {
                self.pers[ "controllerFreezeDebug" ][ debug ] = 0;
            }
            
            self.pers[ "controllerFreezeDebug" ][ debug ]++;
        }
        else if ( force )
        {
            self.pers[ "controllerFreezeDebug" ] = [];
        }
        else if ( !isdefined( self.pers[ "controllerFreezeDebug" ][ debug ] ) || self.pers[ "controllerFreezeDebug" ][ debug ] == 0 )
        {
            println( "<dev string:x109>" + debug + "<dev string:x136>" );
        }
        else
        {
            self.pers[ "controllerFreezeDebug" ][ debug ]--;
            
            if ( self.pers[ "controllerFreezeDebug" ][ debug ] == 0 )
            {
                self.pers[ "controllerFreezeDebug" ][ debug ] = undefined;
            }
        }
    }
    
    if ( self.pers[ "controllerFreezeStack" ] <= 0 )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self freezecontrols( 0 );
        self.controlsfrozen = 0;
        return;
    }
    
    self freezecontrols( 1 );
    self.controlsfrozen = 1;
}

// Namespace player
// Params 0
// Checksum 0xc76a3a5a, Offset: 0x2121
// Size: 0x16e
function _refreshfreezecontrols()
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self.pers[ "controllerFreezeDebug" ] = [];
    }
    
    if ( self.pers[ "controllerFreezeStack" ] <= 0 )
    {
        self.pers[ "controllerFreezeStack" ] = 0;
        self freezecontrols( 0 );
        self.controlsfrozen = 0;
        return;
    }
    
    self freezecontrols( 1 );
    self.controlsfrozen = 1;
    
    if ( getdvarint( @"hash_fc8a67f104cc90a6", 0 ) )
    {
        var_59da617b4e8d4c8f = "";
        
        if ( isdefined( self.pers[ "controllerFreezeDebug" ] ) )
        {
            foreach ( context, contextcount in self.pers[ "controllerFreezeDebug" ] )
            {
                var_59da617b4e8d4c8f += context + "=" + contextcount + " | ";
            }
        }
        
        logstring( "IW9-676465: Player " + self.name + " was frozen after a _refreshFreezeControls(). Freeze Debug Stack: " + var_59da617b4e8d4c8f );
    }
}

// Namespace player
// Params 0
// Checksum 0x1b640682, Offset: 0x2297
// Size: 0xff
function function_b8d64912ebafb09()
{
    stacksize = 0;
    
    if ( isdefined( self.pers[ "controllerFreezeStack" ] ) )
    {
        stacksize = self.pers[ "controllerFreezeStack" ];
    }
    
    if ( stacksize <= 0 )
    {
        return;
    }
    
    var_59da617b4e8d4c8f = "";
    
    if ( isdefined( self.pers[ "controllerFreezeDebug" ] ) )
    {
        foreach ( context, contextcount in self.pers[ "controllerFreezeDebug" ] )
        {
            var_59da617b4e8d4c8f += context + "=" + contextcount + " | ";
        }
    }
    
    println( "<dev string:x139>" + stacksize + "<dev string:x160>" + var_59da617b4e8d4c8f );
}

// Namespace player
// Params 2
// Checksum 0xe2a434e, Offset: 0x239e
// Size: 0xe0
function _freezelookcontrols( frozen, force )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerLookFreezeStack" ] ) )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
    }
    
    if ( frozen )
    {
        assert( !isdefined( force ) );
        self.pers[ "controllerLookFreezeStack" ]++;
    }
    else if ( force )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
    }
    else
    {
        self.pers[ "controllerLookFreezeStack" ]--;
    }
    
    if ( self.pers[ "controllerLookFreezeStack" ] <= 0 )
    {
        self.pers[ "controllerLookFreezeStack" ] = 0;
        self freezelookcontrols( 0 );
        self.lookcontrolsfrozen = 0;
        return;
    }
    
    self freezelookcontrols( 1 );
    self.lookcontrolsfrozen = 1;
}

// Namespace player
// Params 1
// Checksum 0xc846ebda, Offset: 0x2486
// Size: 0x282
function freezeAllMovements( frozen )
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    if ( !isdefined( self.pers[ "controllerfreezeAllMovementsStack" ] ) )
    {
        self.pers[ "controllerfreezeAllMovementsStack" ] = 0;
    }
    
    if ( frozen )
    {
        self.pers[ "controllerfreezeAllMovementsStack" ]++;
    }
    else
    {
        self.pers[ "controllerfreezeAllMovementsStack" ]--;
        
        if ( self.pers[ "controllerfreezeAllMovementsStack" ] > 0 )
        {
            return;
        }
    }
    
    _freezelookcontrols( frozen );
    
    if ( frozen )
    {
        val::set( "freezeAllMovements", "allow_emote", 0 );
        val::set( "freezeAllMovements", "allow_jump", 0 );
        val::set( "freezeAllMovements", "crouch", 0 );
        val::set( "freezeAllMovements", "prone", 0 );
        val::set( "freezeAllMovements", "dtp", 0 );
        val::set( "freezeAllMovements", "ads", 0 );
        val::set( "freezeAllMovements", "gesture", 0 );
        val::set( "freezeAllMovements", "melee", 0 );
        val::set( "freezeAllMovements", "mantle", 0 );
        val::set( "freezeAllMovements", "offhand_weapons", 0 );
        val::set( "freezeAllMovements", "allow_movement", 0 );
        val::set( "freezeAllMovements", "sprint", 0 );
        val::set( "freezeAllMovements", "vehicle_exit", 0 );
        val::set( "freezeAllMovements", "fire", 0 );
        val::set( "freezeAllMovements", "weapon_inspect", 0 );
        val::set( "freezeAllMovements", "reload", 0 );
        val::set( "freezeAllMovements", "weapon_pickup", 0 );
        val::set( "freezeAllMovements", "weapon_switch", 0 );
        val::set( "freezeAllMovements", "offhand_weapons", 0 );
        val::set( "freezeAllMovements", "execution_attack", 0 );
        val::set( "freezeAllMovements", "execution_victim", 0 );
        val::set( "freezeAllMovements", "supers", 0 );
        val::set( "freezeAllMovements", "usability", 0 );
        val::set( "freezeAllMovements", "allow_toggle_third_person", 0 );
    }
    else
    {
        val::reset_all( "freezeAllMovements" );
    }
    
    self setclientomnvar( "ui_br_inventory_disabled", frozen );
    self function_3181733c19782bcc( !frozen );
    self function_134cd2c60d3a7edf( !frozen );
    
    if ( game_utility_mp::function_4818e8dcc8c3ec96() )
    {
        self skydive_setdeploymentstatus( !frozen );
        self skydive_setbasejumpingstatus( !frozen );
    }
}

// Namespace player
// Params 1
// Checksum 0x5d5d1ff, Offset: 0x2710
// Size: 0x90
function getplayerforguid( guid )
{
    foreach ( player in level.players )
    {
        if ( player.guid == guid )
        {
            return player;
        }
    }
}

// Namespace player
// Params 4
// Checksum 0xe9a40675, Offset: 0x27a9
// Size: 0xb4
function set_temp_energy_restore_rate( energygroup, temprate, time, untilfull )
{
    var_62296fab3207e725 = self energy_getrestorerate( energygroup );
    self.temprateset = 1;
    assert( var_62296fab3207e725 != temprate, "<dev string:x16e>" );
    self energy_setrestorerate( energygroup, temprate );
    
    if ( !untilfull )
    {
        wait time;
    }
    else
    {
        assert( temprate > 0, "<dev string:x1a9>" );
        maxenergy = self energy_getmax( energygroup );
        
        for ( ;; )
        {
            if ( self energy_getenergy( energygroup ) >= maxenergy )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    self energy_setrestorerate( energygroup, var_62296fab3207e725 );
    self.temprateset = 0;
}

// Namespace player
// Params 4
// Checksum 0xc5024775, Offset: 0x2865
// Size: 0xb4
function set_temp_energy_rest_time( energygroup, tempresttime, time, untilfull )
{
    var_71a1077b0ae6b9e8 = self energy_getresttimems( energygroup );
    self.tempresttime = 1;
    assert( var_71a1077b0ae6b9e8 != tempresttime, "<dev string:x1d9>" );
    self energy_setresttimems( energygroup, tempresttime );
    
    if ( !untilfull )
    {
        wait time;
    }
    else
    {
        assert( tempresttime > 0, "<dev string:x20b>" );
        maxenergy = self energy_getmax( energygroup );
        
        for ( ;; )
        {
            if ( self energy_getenergy( energygroup ) >= maxenergy )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    self energy_setresttimems( energygroup, var_71a1077b0ae6b9e8 );
    self.tempresttime = 0;
}

// Namespace player
// Params 0
// Checksum 0x470993b7, Offset: 0x2921
// Size: 0x3b
function _enableignoreme()
{
    if ( !isdefined( self.enabledignoreme ) )
    {
        self.enabledignoreme = 0;
    }
    
    if ( self.enabledignoreme == 0 )
    {
        self.ignoreme = 1;
    }
    
    self.enabledignoreme++;
}

// Namespace player
// Params 0
// Checksum 0xd8a91157, Offset: 0x2964
// Size: 0x3d
function _disableignoreme()
{
    assert( self.enabledignoreme > 0, "<dev string:x238>" );
    
    if ( self.enabledignoreme == 1 )
    {
        self.ignoreme = 0;
    }
    
    self.enabledignoreme--;
}

// Namespace player
// Params 0
// Checksum 0xd6865b6b, Offset: 0x29a9
// Size: 0x16
function _resetenableignoreme()
{
    self.enabledignoreme = undefined;
    self.ignoreme = 0;
}

// Namespace player
// Params 4
// Checksum 0x3887b6e0, Offset: 0x29c7
// Size: 0xe3
function watchbuttonpressed( key, commanddown, commandup, startpressed )
{
    if ( !isdefined( self.buttonspressed ) )
    {
        self.buttonspressed = [];
    }
    
    if ( !isdefined( self.buttonspressed[ key ] ) )
    {
        struct = spawnstruct();
        struct.player = self;
        struct.key = key;
        struct.commanddown = commanddown;
        struct.commandup = commandup;
        struct.notifydown = key + "_buttonDown";
        struct.notifyup = key + "_buttonUp";
        struct.pressed = istrue( startpressed );
        self.buttonspressed[ key ] = struct;
        struct thread watchbuttonpressedinternal();
    }
}

// Namespace player
// Params 1
// Checksum 0xf1b54d3, Offset: 0x2ab2
// Size: 0x45
function getbuttonpressed( key )
{
    if ( !isdefined( self.buttonspressed ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.buttonspressed[ key ] ) )
    {
        return 0;
    }
    
    return self.buttonspressed[ key ].pressed;
}

// Namespace player
// Params 1
// Checksum 0x5f05fb33, Offset: 0x2b00
// Size: 0x53
function watchbuttonpressedend( key )
{
    if ( !( isdefined( self ) && isdefined( self.buttonspressed ) ) || self.buttonspressed[ key ] )
    {
        return;
    }
    
    self.buttonspressed[ key ] notify( #"hash_6d8441ee5594618f" );
    self.buttonspressed[ key ] = undefined;
}

// Namespace player
// Params 0
// Checksum 0xabed90ec, Offset: 0x2b5b
// Size: 0xa6
function watchbuttonpressedinternal()
{
    self.player endon( #"disconnect" );
    self endon( #"hash_6d8441ee5594618f" );
    
    while ( true )
    {
        self.down = 0;
        self.up = 0;
        childthread watchbuttondown();
        childthread watchbuttonup();
        self waittill( #"start_race" );
        waittillframeend();
        self notify( #"end_race" );
        
        if ( self.down && self.up )
        {
            continue;
        }
        
        if ( self.down )
        {
            self.pressed = 1;
            continue;
        }
        
        self.pressed = 0;
    }
}

// Namespace player
// Params 0
// Checksum 0xbe3a8cf, Offset: 0x2c09
// Size: 0x5a
function watchbuttondown()
{
    self endon( #"end_race" );
    self.player notifyonplayercommand( self.notifydown, self.commanddown );
    self.player waittill( self.notifydown );
    self.down = 1;
    self notify( #"start_race" );
}

// Namespace player
// Params 0
// Checksum 0x49c34544, Offset: 0x2c6b
// Size: 0x5a
function watchbuttonup()
{
    self endon( #"end_race" );
    self.player notifyonplayercommand( self.notifyup, self.commandup );
    self.player waittill( self.notifyup );
    self.up = 1;
    self notify( #"start_race" );
}

// Namespace player
// Params 0
// Checksum 0x49ea0234, Offset: 0x2ccd
// Size: 0x2f
function watchbuttonpressendondisconnect()
{
    self endon( #"hash_6d8441ee5594618f" );
    self.player waittill( #"disconnect" );
    self notify( #"hash_6d8441ee5594618f" );
}

// Namespace player
// Params 6
// Checksum 0x10fc6ac4, Offset: 0x2d04
// Size: 0x99
function _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur )
{
    if ( true )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    nearstart = max( nearstart, 0 );
    nearend = clamp( nearend, 1, 9994 );
    farstart = clamp( farstart, 2, 9998 );
    farend = clamp( farend, 3, 9999 );
    
    if ( farstart > 9994 )
    {
        farblur = 0;
    }
}

// Namespace player
// Params 0
// Checksum 0x37ce18b3, Offset: 0x2da5
// Size: 0x5d2
function setdof_dynamic()
{
    self endon( #"death_or_disconnect" );
    setdof_default();
    
    if ( isai( self ) )
    {
        return;
    }
    
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    playercontent = [ "physicscontents_characterproxy" ];
    var_e1c801cb433b89d0 = physics_createcontents( playercontent );
    useinterest = 1;
    var_9d99969289479f18 = cos( 27 );
    var_4a6039f8b742642b = 1;
    var_ad6b20b5929e3ce0 = 0;
    dofsettings = [];
    dofsettings[ "geo" ] = spawnstruct();
    dofsettings[ "geo" ].nearstartfactor = getdvarfloat( @"dof_nearstart_geo", 0.01 );
    dofsettings[ "geo" ].nearendfactor = getdvarfloat( @"dof_nearend_geo", 0.95 );
    dofsettings[ "geo" ].farstartfactor = getdvarfloat( @"dof_farstart_geo", 1.5 );
    dofsettings[ "geo" ].farendfactor = getdvarfloat( @"dof_farend_geo", 2.5 );
    dofsettings[ "geo" ].nearblur = getdvarfloat( @"dof_nearblur_geo", 3.9 );
    dofsettings[ "geo" ].farblur = getdvarfloat( @"dof_farblur_geo", 2.25 );
    dofsettings[ "interest" ] = spawnstruct();
    dofsettings[ "interest" ].nearstartfactor = getdvarfloat( @"dof_nearstart", 0.01 );
    dofsettings[ "interest" ].nearendfactor = getdvarfloat( @"dof_nearend", 0.95 );
    dofsettings[ "interest" ].farstartfactor = getdvarfloat( @"dof_farstart", 1.5 );
    dofsettings[ "interest" ].farendfactor = getdvarfloat( @"dof_farend", 2.5 );
    dofsettings[ "interest" ].nearblur = getdvarfloat( @"dof_nearblur", 7 );
    dofsettings[ "interest" ].farblur = getdvarfloat( @"dof_farblur", 3.5 );
    
    while ( true )
    {
        waitframe();
        
        if ( self.usingcustomdof )
        {
            continue;
        }
        
        useads = self playerads() > 0.9;
        
        if ( var_4a6039f8b742642b && !useads )
        {
            if ( var_ad6b20b5929e3ce0 )
            {
                var_ad6b20b5929e3ce0 = 0;
                _setdof_internal( 0, 0, 512, 512, 4, 0 );
            }
            
            continue;
        }
        
        startpos = self geteye();
        viewangles = self getplayerangles();
        fwd = anglestoforward( viewangles );
        neardist = undefined;
        fardist = undefined;
        tracedist = undefined;
        
        if ( useinterest )
        {
            foreach ( enemy in level.players )
            {
                if ( !player_utility::playersareenemies( self, enemy ) )
                {
                    continue;
                }
                
                if ( !enemy isreallyalive() )
                {
                    continue;
                }
                
                enemypos = enemy geteye();
                headdot = vectordot( fwd, vectornormalize( enemypos - startpos ) );
                
                if ( headdot < var_9d99969289479f18 )
                {
                    continue;
                }
                
                dist = distance( startpos, enemypos );
                
                if ( !isdefined( neardist ) || dist < neardist )
                {
                    if ( enemy sightconetrace( startpos, self ) > 0 )
                    {
                        neardist = dist;
                    }
                }
                
                if ( !isdefined( fardist ) || dist > fardist )
                {
                    if ( enemy sightconetrace( startpos, self ) > 0 )
                    {
                        fardist = dist;
                    }
                }
            }
        }
        
        endpos = startpos + fwd * 10000;
        trace = trace::sphere_trace( startpos, endpos, 0.1, self, contentoverride, 0 );
        tracedist = distance( startpos, trace[ "position" ] );
        playertrace = trace::sphere_trace( startpos, endpos, 20, self, var_e1c801cb433b89d0, 0 );
        traceent = playertrace[ "entity" ];
        entisenemy = isplayer( traceent ) && player_utility::playersareenemies( self, traceent );
        var_a1357bbefbb0800f = entisenemy && traceent sightconetrace( startpos, self ) > 0;
        
        if ( !isdefined( neardist ) || tracedist < neardist )
        {
            neardist = tracedist;
        }
        
        if ( !isdefined( fardist ) || tracedist > fardist )
        {
            fardist = tracedist;
        }
        
        var_ad6b20b5929e3ce0 = 1;
        middist = max( abs( neardist - fardist ) * 0.5, 300 );
        nearstart = 0;
        nearend = max( neardist - 50, 1 );
        farstart = fardist + 50;
        farend = farstart + middist;
        nearblur = var_a1357bbefbb0800f ? 6 : 4;
        farblur = var_a1357bbefbb0800f ? 2.5 : 1.25;
        _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur );
    }
}

// Namespace player
// Params 0
// Checksum 0x16061cc6, Offset: 0x337f
// Size: 0x3e
function setdof_killer()
{
    self endon( #"disconnect" );
    
    if ( !level.gamemodebundle.var_d64395ce43bd0786 )
    {
        self.usingcustomdof = 1;
        setdof_killer_update();
        setdof_default();
    }
}

// Namespace player
// Params 1
// Checksum 0xe012f37b, Offset: 0x33c5
// Size: 0x4f, Type: bool
function function_a21ab4e7c3c4cbbc( deathdata )
{
    if ( !level.gamemodebundle.var_d64395ce43bd0786 )
    {
        return false;
    }
    
    if ( utility::isusingremote() )
    {
        return false;
    }
    
    if ( isdefined( deathdata ) && deathdata.deathtype == "deathType_switchingTeams" )
    {
        return false;
    }
    
    return true;
}

// Namespace player
// Params 2
// Checksum 0xeaf6f0a8, Offset: 0x341d
// Size: 0x221
function deathcam_effects( deathscenetimesec, smeansofdeath )
{
    self endon( #"disconnect" );
    self endon( #"hash_f51e317458715b62" );
    self setlensprofiledistort( "compact portable", 0, 0.001, 2, 0.81 );
    self.var_b2e499b4ed46b224 = 1;
    
    if ( isdefined( self.lastkilledby ) )
    {
        if ( getdvarint( @"hash_b6ed1dff52043e2e", 0 ) == 1 )
        {
            self function_2ebe5f47995c9811( 0.7, 50, 50, self.lastkilledby );
        }
        else
        {
            utility::dof_enable_autofocus( 0.7, self.lastkilledby, 50, 50 );
        }
    }
    else
    {
        utility::dof_enable_autofocus( 0.7, undefined, 50, 50, undefined, self.lastdeathpos );
    }
    
    thread function_2942868be8fbe6e0();
    self setcinematicmotionoverride( "rex_death_cam" );
    self.var_6563b277da4648aa = 1;
    var_a88943bc6bc26d7b = undefined;
    
    if ( smeansofdeath != "MOD_FIRE" )
    {
        self.var_a010f8ee83cce53d = "vfx_rex_core_player_1p_blood_killcam_01";
        
        if ( !isdefined( level._effect[ self.var_a010f8ee83cce53d ] ) )
        {
            level._effect[ self.var_a010f8ee83cce53d ] = loadfxasset( self.var_a010f8ee83cce53d );
        }
        
        playfxontagforclients( utility::getfx( self.var_a010f8ee83cce53d ), self, "tag_eye", self );
    }
    
    thread function_2082ec79c322b4e9( deathscenetimesec );
    self waittill( #"death_delay_finished" );
    self function_e5b205be6fa4e02( 1, 0 );
    
    if ( getdvarint( @"hash_b6ed1dff52043e2e", 0 ) == 1 )
    {
        self function_85cddace8bebdba5();
    }
    
    function_d5329fa0a8ab0fbd();
    function_d6b446def946fc51();
    function_f2f003dc604203b();
    function_c295ee91e704b18a();
    
    if ( self.willshowkillcam )
    {
        while ( true )
        {
            if ( self.skippedkillcam || self.killcam || self.killcamcancelled )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    canfadeup = !self.inspawnselection && !self.inspawncamera;
    
    if ( canfadeup )
    {
        function_6095a28f115e4b12();
    }
}

// Namespace player
// Params 0
// Checksum 0xe94d2388, Offset: 0x3646
// Size: 0x55
function function_28363dff0f011241()
{
    if ( !level.gamemodebundle.var_d64395ce43bd0786 )
    {
        return;
    }
    
    self notify( #"hash_f51e317458715b62" );
    self function_e5b205be6fa4e02( 0, 1 );
    function_d5329fa0a8ab0fbd();
    function_d6b446def946fc51();
    function_f2f003dc604203b();
    function_c295ee91e704b18a();
    function_6095a28f115e4b12();
}

// Namespace player
// Params 0
// Checksum 0xa7da921e, Offset: 0x36a3
// Size: 0x9
function function_d6b446def946fc51()
{
    utility::dof_disable_autofocus();
}

// Namespace player
// Params 0
// Checksum 0x2a674fae, Offset: 0x36b4
// Size: 0x23
function function_d5329fa0a8ab0fbd()
{
    if ( self.var_b2e499b4ed46b224 )
    {
        self setlensprofiledistort( "none" );
        self.var_b2e499b4ed46b224 = undefined;
    }
}

// Namespace player
// Params 0
// Checksum 0xa3fdd51c, Offset: 0x36df
// Size: 0x1e
function function_f2f003dc604203b()
{
    if ( self.var_6563b277da4648aa )
    {
        self clearcinematicmotionoverride();
        self.var_6563b277da4648aa = undefined;
    }
}

// Namespace player
// Params 0
// Checksum 0x996c65c9, Offset: 0x3705
// Size: 0x33
function function_c295ee91e704b18a()
{
    if ( isdefined( self.var_a010f8ee83cce53d ) )
    {
        killfxontag( utility::getfx( self.var_a010f8ee83cce53d ), self, "tag_eye" );
        self.var_a010f8ee83cce53d = undefined;
    }
}

// Namespace player
// Params 0
// Checksum 0x5ae06715, Offset: 0x3740
// Size: 0x4c
function function_6095a28f115e4b12()
{
    if ( self.var_5502f7944387ef95 )
    {
        if ( getdvarint( @"hash_9fd83e2640f8683e", 1 ) == 1 )
        {
            game_utility::fadetoblackforplayerkeepui( self, 0, 0 );
        }
        else
        {
            game_utility::fadetoblackforplayer( self, 0, 0 );
        }
        
        self.var_5502f7944387ef95 = undefined;
    }
}

// Namespace player
// Params 0
// Checksum 0xa8ba2197, Offset: 0x3794
// Size: 0x50
function function_2942868be8fbe6e0()
{
    self endon( #"disconnect" );
    self endon( #"death_delay_finished" );
    wait 0.1;
    
    if ( isdefined( level.projectbundle.var_cffc5a92db7e518a ) )
    {
        self function_9c6091c690ea2ca3( level.projectbundle.var_cffc5a92db7e518a );
    }
}

// Namespace player
// Params 1
// Checksum 0x2e3a4c32, Offset: 0x37ec
// Size: 0xbb
function function_2082ec79c322b4e9( deathscenetimesec )
{
    self endon( #"death_delay_finished" );
    self endon( #"disconnect" );
    self endon( #"hash_f51e317458715b62" );
    earlytime = level.disablespawncamera ? 0 : 0.1;
    waittime = deathscenetimesec - 0.1 + earlytime;
    wait waittime;
    
    if ( !level.gameended )
    {
        self.var_5502f7944387ef95 = 1;
        
        if ( getdvarint( @"hash_9fd83e2640f8683e", 1 ) == 1 )
        {
            game_utility::fadetoblackforplayerkeepui( self, 1, 0.1 );
            return;
        }
        
        game_utility::fadetoblackforplayer( self, 1, 0.1 );
    }
}

// Namespace player
// Params 0
// Checksum 0x990ca31, Offset: 0x38af
// Size: 0x1b9
function setdof_killer_update()
{
    self endon( #"disconnect" );
    self endon( #"death_delay_finished" );
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    tokiller = vectornormalize( self.origin - self.lastkilledby.origin );
    startpos = self.origin + ( 0, 0, 42 );
    endpos = startpos + tokiller * 120;
    trace = trace::sphere_trace( startpos, endpos, 2, self, contentoverride, 0 );
    camposition = trace[ "position" ];
    
    while ( self.usingcustomdof )
    {
        if ( !isdefined( self.lastkilledby ) )
        {
            break;
        }
        
        disttotarget = distance( camposition, self.lastkilledby.origin );
        nearstart = 0;
        nearend = max( disttotarget - 12, 1 );
        farstart = disttotarget + 12;
        farend = farstart + 50;
        nearblur = 8;
        farblur = 4.5;
        _setdof_internal( nearstart, nearend, farstart, farend, nearblur, farblur );
        waitframe();
    }
}

// Namespace player
// Params 0
// Checksum 0x27343ab9, Offset: 0x3a70
// Size: 0x1e
function setdof_default()
{
    self.usingcustomdof = 0;
    _setdof_internal( 0, 0, 512, 512, 4, 0 );
}

// Namespace player
// Params 0
// Checksum 0x610d23d7, Offset: 0x3a96
// Size: 0x1f
function setdof_spectator()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 0, 512, 512, 4, 0 );
}

// Namespace player
// Params 0
// Checksum 0x913132b2, Offset: 0x3abd
// Size: 0x24
function setdof_infil()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 128, 512, 4000, 6, 1.8 );
}

// Namespace player
// Params 0
// Checksum 0x7b359636, Offset: 0x3ae9
// Size: 0x25
function setdof_apache()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 7, 3.5 );
}

// Namespace player
// Params 0
// Checksum 0x665b4e25, Offset: 0x3b16
// Size: 0x25
function setdof_cruisethird()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 7, 3.5 );
}

// Namespace player
// Params 0
// Checksum 0x90789a96, Offset: 0x3b43
// Size: 0x21
function setdof_cruisefirst()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 1000, 7, 0 );
}

// Namespace player
// Params 0
// Checksum 0x24aba6ea, Offset: 0x3b6c
// Size: 0x25
function setdof_tank()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 120, 1000, 6500, 7, 3.5 );
}

// Namespace player
// Params 0
// Checksum 0x9e9acdbc, Offset: 0x3b99
// Size: 0x24
function setdof_thirdperson()
{
    self.usingcustomdof = 1;
    _setdof_internal( 0, 110, 512, 4096, 6, 1.8 );
}

// Namespace player
// Params 0
// Checksum 0xb18ef64d, Offset: 0x3bc5
// Size: 0x21
function setdof_gunship()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 1000, 7, 0 );
}

// Namespace player
// Params 0
// Checksum 0xbbc6df7, Offset: 0x3bee
// Size: 0x22
function setdof_gunship_zoom()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 6500, 10, 5 );
}

// Namespace player
// Params 0
// Checksum 0x7ed17e25, Offset: 0x3c18
// Size: 0x25
function setdof_scrambler_strength_1()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 1000, 5000, 4, 3.5 );
}

// Namespace player
// Params 0
// Checksum 0xa7483377, Offset: 0x3c45
// Size: 0x28
function setdof_scrambler_strength_2()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 800, 4000, 4.5, 3.5 );
}

// Namespace player
// Params 0
// Checksum 0x90df0688, Offset: 0x3c75
// Size: 0x25
function setdof_scrambler_strength_3()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 600, 3000, 5, 3.5 );
}

// Namespace player
// Params 0
// Checksum 0x4e0b9ce6, Offset: 0x3ca2
// Size: 0x28
function setdof_scrambler_strength_4()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 500, 2000, 5.5, 3.5 );
}

// Namespace player
// Params 0
// Checksum 0x79bca826, Offset: 0x3cd2
// Size: 0x25
function setdof_scrambler_strength_5()
{
    self.usingcustomdof = 1;
    _setdof_internal( 10, 80, 400, 1000, 6, 3.5 );
}

// Namespace player
// Params 1
// Checksum 0x42e2e457, Offset: 0x3cff
// Size: 0x15
function clearkillcamstate( var_824c9d962d9cde74 )
{
    player_utility::clearkillcamstate( var_824c9d962d9cde74 );
}

// Namespace player
// Params 0
// Checksum 0xcb2a6b29, Offset: 0x3d1c
// Size: 0x3d, Type: bool
function isinkillcam()
{
    if ( isai( self ) )
    {
        return false;
    }
    
    if ( self.spectatekillcam )
    {
        if ( self.forcespectatorclient == -1 && self.killcamentity == -1 )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace player
// Params 2
// Checksum 0x58451b54, Offset: 0x3d62
// Size: 0x90
function waittillrecoveredhealth( time, interval )
{
    self endon( #"death_or_disconnect" );
    fullhealthtime = 0;
    
    if ( !isdefined( interval ) )
    {
        interval = 0.05;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    while ( true )
    {
        if ( self.health != self.maxhealth )
        {
            fullhealthtime = 0;
        }
        else
        {
            fullhealthtime += interval;
        }
        
        wait interval;
        
        if ( self.health == self.maxhealth && fullhealthtime >= time )
        {
            break;
        }
    }
}

// Namespace player
// Params 2
// Checksum 0xc5546c9a, Offset: 0x3dfb
// Size: 0x4b
function _setsuit( suit, var_a6bd836539ca63d1 )
{
    if ( self.suit == suit )
    {
        if ( var_a6bd836539ca63d1 )
        {
            mtx_weapon::function_940bfb34e152ae96();
        }
        
        return;
    }
    
    self setsuit( suit );
    self.suit = suit;
    mtx_weapon::function_940bfb34e152ae96();
}

// Namespace player
// Params 2
// Checksum 0x8151e7d4, Offset: 0x3e4e
// Size: 0x64
function setwind( value, manualoverride )
{
    if ( !self isscriptable() || !self getscriptablehaspart( "wind" ) || !self getscriptableparthasstate( "wind", value ) || !isreallyalive( self ) )
    {
        return;
    }
    
    self.manualoverridewindmaterial = manualoverride;
    self setscriptablepartstate( "wind", value, 0 );
}

// Namespace player
// Params 1
// Checksum 0x623dc035, Offset: 0x3eba
// Size: 0x15
function printspawnmessage( message )
{
    player_utility::printspawnmessage( message );
}

// Namespace player
// Params 2
// Checksum 0xe0fe6c5e, Offset: 0x3ed7
// Size: 0x10a
function codcastersetplayerstatuseffect( category, duration )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    effecttype = undefined;
    
    switch ( category )
    {
        case #"hash_a68c414683465b09":
            effecttype = 0;
            break;
        case #"hash_23f2c68a2fc41281":
            effecttype = 2;
            break;
        case #"hash_fb36696c0708bf42":
            effecttype = 3;
            break;
        case #"hash_ceb098150f024a39":
            effecttype = 1;
            break;
        case #"hash_ff0da8f68d7b83f3":
            effecttype = 4;
            break;
        case #"hash_1f1d7b3efcb82111":
            effecttype = 5;
            break;
    }
    
    if ( isdefined( effecttype ) )
    {
        var_1eca95e79e47e5af = 0;
        
        if ( effecttype != 1 && effecttype != 4 && effecttype != 5 )
        {
            var_1eca95e79e47e5af = isdefined( self.perks[ "specialty_tac_resist" ] );
        }
        
        if ( duration != -1 )
        {
            duration = int( duration * 1000 );
        }
        
        self setcodcasterstatuseffect( effecttype, duration, gettime() + duration, var_1eca95e79e47e5af );
    }
}

// Namespace player
// Params 0
// Checksum 0x12815119, Offset: 0x3fe9
// Size: 0xb9, Type: bool
function isincombat()
{
    isshooting = 0;
    
    if ( isdefined( self.lastshotfiredtime ) )
    {
        var_ec31a5f8851ecef6 = 0;
        
        if ( !weaponisauto( self.currentprimaryweapon ) )
        {
            var_de0d6432a0d324a9 = self function_a9397ef504a37375( self.currentprimaryweapon );
            var_ec31a5f8851ecef6 = var_de0d6432a0d324a9 + max( getdvarint( @"hash_f6ed71d9c8bdb8c9", 0 ), 150 );
        }
        else
        {
            var_ec31a5f8851ecef6 = getdvarint( @"hash_f6ed71d9c8bdb8c9", 0 );
        }
        
        currenttime = gettime();
        isshooting = self.lastshotfiredtime + var_ec31a5f8851ecef6 >= currenttime;
    }
    
    return isshooting || self ismeleeing() || self isthrowinggrenade() || function_fe7c1fc2e948f334();
}

// Namespace player
// Params 0
// Checksum 0x9ba99095, Offset: 0x40ab
// Size: 0xee
function function_fe7c1fc2e948f334()
{
    var_fe7c1fc2e948f334 = 0;
    
    if ( isdefined( self.attackers ) )
    {
        currenttime = gettime();
        var_c9a12b43a06e94da = 0;
        var_e329bf42df41b58f = getdvarint( @"hash_20e694002fcd35cc", 2000 );
        
        foreach ( guid, attacker in self.attackers )
        {
            var_c9a12b43a06e94da = currenttime - self.attackerdata[ guid ].lasttimedamaged;
            var_fe7c1fc2e948f334 = isdefined( attacker ) && var_c9a12b43a06e94da < var_e329bf42df41b58f;
            
            if ( var_fe7c1fc2e948f334 )
            {
                break;
            }
        }
    }
    
    return var_fe7c1fc2e948f334;
}

// Namespace player
// Params 1
// Checksum 0x287b882f, Offset: 0x41a2
// Size: 0x1f
function setbeingrevivedinternal( isbeingrevived )
{
    self.beingrevived = isbeingrevived;
    self setbeingrevived( isbeingrevived );
}

// Namespace player
// Params 0
// Checksum 0x1dacb537, Offset: 0x41c9
// Size: 0x18, Type: bool
function getbeingrevivedinternal()
{
    return self.beingrevived || self.isselfreviving;
}

// Namespace player
// Params 7
// Checksum 0xd3165b39, Offset: 0x41ea
// Size: 0x58
function function_4ce99bea1b3968c6( notifyname, commandname, actioncallback, var_e5a754e3fa303826, endons, inputtype, botautouse )
{
    thread function_24ace658f8fda8d2( notifyname, commandname, actioncallback, var_e5a754e3fa303826, endons, 0, undefined, inputtype, 0, undefined, botautouse );
}

// Namespace player
// Params 9
// Checksum 0xba1ad608, Offset: 0x424a
// Size: 0x6a
function function_ba055eee4438741e( notifyname, commandname, actioncallback, var_e5a754e3fa303826, endons, holdduration, var_1617690e741ab65b, inputtype, botautouse )
{
    thread function_24ace658f8fda8d2( notifyname, commandname, actioncallback, var_e5a754e3fa303826, endons, holdduration, var_1617690e741ab65b, inputtype, 0, undefined, botautouse );
}

// Namespace player
// Params 8
// Checksum 0x463426f6, Offset: 0x42bc
// Size: 0x62
function function_872ddf4ab418a5d5( notifyname, commandname, actioncallback, var_e5a754e3fa303826, endons, inputtype, var_1f412e56e26e66b5, botautouse )
{
    thread function_24ace658f8fda8d2( notifyname, commandname, actioncallback, var_e5a754e3fa303826, endons, 0, undefined, inputtype, 1, var_1f412e56e26e66b5, botautouse );
}

// Namespace player
// Params 11
// Checksum 0xb59c672e, Offset: 0x4326
// Size: 0x1a9
function function_24ace658f8fda8d2( notifyname, commandname, actioncallback, var_e5a754e3fa303826, endons, holdduration, var_1617690e741ab65b, inputtype, isrepeat, var_1f412e56e26e66b5, botautouse )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    thread function_9be2b74fba1fe6ef( notifyname, endons );
    
    if ( !isdefined( var_e5a754e3fa303826 ) )
    {
        var_e5a754e3fa303826 = self;
    }
    
    if ( !isdefined( holdduration ) )
    {
        holdduration = 0;
    }
    
    if ( !isdefined( inputtype ) )
    {
        inputtype = "any";
    }
    
    if ( !isdefined( isrepeat ) )
    {
        isrepeat = 0;
    }
    
    if ( !isdefined( var_1f412e56e26e66b5 ) )
    {
        var_1f412e56e26e66b5 = 0;
    }
    
    if ( !isdefined( botautouse ) )
    {
        botautouse = 0;
    }
    
    if ( isbot( self ) && !botautouse )
    {
        return;
    }
    
    assert( isdefined( notifyname ) && isdefined( commandname ) && isdefined( actioncallback ), "<dev string:x26c>" );
    presscommand = "+" + commandname;
    releasecommand = "-" + commandname;
    pressnotify = notifyname + "_press";
    releasenotify = notifyname + "_release";
    var_5416f5c6834f512e = isrepeat || holdduration > 0;
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( pressnotify, presscommand );
        
        if ( var_5416f5c6834f512e )
        {
            self notifyonplayercommand( releasenotify, releasecommand );
        }
    }
    
    function_36d9f1f0592dd014( notifyname, actioncallback, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b, inputtype, isrepeat, var_1f412e56e26e66b5, botautouse );
    
    if ( isdefined( var_1617690e741ab65b ) )
    {
        self thread [[ var_1617690e741ab65b ]]( var_e5a754e3fa303826, 0, 0 );
    }
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( pressnotify, presscommand );
        
        if ( var_5416f5c6834f512e )
        {
            self notifyonplayercommandremove( releasenotify, releasecommand );
        }
    }
}

// Namespace player
// Params 1
// Checksum 0xb638c4ca, Offset: 0x44d7
// Size: 0x144
function function_988f8c8a0acafabf( player )
{
    if ( isdefined( level.lootleaders ) && arraycontains( level.lootleaders, player ) )
    {
        if ( isdefined( player.attached_bag ) )
        {
            stopfxontag( level._effect[ "vfx_br_cashLeaderBag" ], player, "j_bag_left" );
            modeltype = getmatchrulesdata( "brData", "plunderModelType" );
            modelname = "accessory_money_bag_large_closed_player";
            
            switch ( modeltype )
            {
                case #"hash_59b8e9d05b31ff9":
                    modelname = "accessory_money_bag_large_closed_player_plunder";
                    break;
            }
            
            player hidepart( "j_bag_left", modelname );
        }
    }
    
    if ( game_utility::getgametype() == "dmz" && isdefined( player.attached_bag ) )
    {
        player.disabledbag = player.attached_bag;
        player backpack::detachbag();
    }
    
    if ( game_utility::getgametype() == "bigctf" )
    {
        player.disabledflag = player.carryflag;
        player bigctf::detachflag();
    }
    
    player val::set( "hideAttachedModels", "hide_operator_backpack", 1 );
    player val::set( "hideAttachedModels", "show_operator_pet", 0 );
}

// Namespace player
// Params 1
// Checksum 0xc305e516, Offset: 0x4623
// Size: 0x181
function function_82e25e4a8962e68a( player )
{
    if ( isdefined( level.lootleaders ) && arraycontains( level.lootleaders, player ) )
    {
        if ( isdefined( player.attached_bag ) )
        {
            modeltype = getmatchrulesdata( "brData", "plunderModelType" );
            modelname = "accessory_money_bag_large_closed_player";
            
            switch ( modeltype )
            {
                case #"hash_59b8e9d05b31ff9":
                    modelname = "accessory_money_bag_large_closed_player_plunder";
                    break;
            }
            
            player showpart( "j_bag_left", modelname );
            playfxontag( level._effect[ "vfx_br_cashLeaderBag" ], player, "j_bag_left" );
        }
    }
    
    if ( game_utility::getgametype() == "dmz" && !isdefined( player.attached_bag ) )
    {
        player backpack::attachbag( player.disabledbag ?? "parts_backpack_inventory_small" );
    }
    
    if ( game_utility::getgametype() == "bigctf" )
    {
        if ( isdefined( player.disabledflag ) && isdefined( player.carryobject ) )
        {
            otherteam = game_utility_mp::getotherteam( player.pers[ "team" ] );
            player attach( player.disabledflag, "tag_stowed_back3", 1 );
            player.carryflag = level.carryflag[ otherteam ];
            player.disabledflag = undefined;
        }
    }
    
    player val::reset_all( "hideAttachedModels" );
}

// Namespace player
// Params 2, eflags: 0x4
// Checksum 0xc7cd83cb, Offset: 0x47ac
// Size: 0x41
function private function_9be2b74fba1fe6ef( notifyname, endons )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any_in_array_return_no_endon_death( endons );
    self notify( notifyname + "_endon" );
}

// Namespace player
// Params 9, eflags: 0x4
// Checksum 0x21b225e5, Offset: 0x47f5
// Size: 0x92
function private function_36d9f1f0592dd014( notifyname, actioncallback, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b, inputtype, isrepeat, var_1f412e56e26e66b5, botautouse )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( notifyname + "_endon" );
    
    while ( true )
    {
        function_c83ec5e4be299cf5( notifyname, actioncallback, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b, inputtype, isrepeat, var_1f412e56e26e66b5, botautouse );
    }
}

// Namespace player
// Params 9, eflags: 0x4
// Checksum 0xbfc23a3, Offset: 0x488f
// Size: 0xb5
function private function_c83ec5e4be299cf5( notifyname, actioncallback, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b, inputtype, isrepeat, var_1f412e56e26e66b5, botautouse )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( notifyname + "_endon" );
    
    if ( holdduration == 0 )
    {
        self endon( notifyname + "_release" );
    }
    
    function_ce7313058561a3e6( notifyname, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b, inputtype, botautouse );
    
    if ( isrepeat )
    {
        function_a4f523cad3b0bd4f( notifyname, actioncallback, var_e5a754e3fa303826, var_1f412e56e26e66b5 );
        return;
    }
    
    self thread [[ actioncallback ]]( var_e5a754e3fa303826 );
}

// Namespace player
// Params 6, eflags: 0x4
// Checksum 0xa22f3bee, Offset: 0x494c
// Size: 0x154
function private function_ce7313058561a3e6( notifyname, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b, inputtype, botautouse )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( notifyname + "_endon" );
    var_4ad6403840d4b217 = holdduration == 0;
    var_48dcdfb8de3c8e2e = isbot( self ) && botautouse;
    isvalidinput = 0;
    
    while ( !isvalidinput )
    {
        if ( var_4ad6403840d4b217 )
        {
            if ( !var_48dcdfb8de3c8e2e )
            {
                self waittill( notifyname + "_press" );
            }
            else
            {
                waitframe();
            }
            
            isvalidinput = 1;
        }
        else
        {
            if ( !var_48dcdfb8de3c8e2e )
            {
                self waittill( notifyname + "_press" );
            }
            else
            {
                waitframe();
            }
            
            thread function_ea504fb31c689dfc( notifyname, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b );
            msg = utility::waittill_notify_or_timeout_return( notifyname + "_release", holdduration );
            isvalidinput = msg == "timeout";
        }
        
        if ( isvalidinput && inputtype != "any" && !var_48dcdfb8de3c8e2e )
        {
            if ( inputtype == "gamepad_only" )
            {
                isvalidinput = self usinggamepad();
            }
            else if ( inputtype == "kbm_only" )
            {
                isvalidinput = !self usinggamepad();
            }
        }
        
        if ( !isvalidinput && isdefined( var_1617690e741ab65b ) )
        {
            self thread [[ var_1617690e741ab65b ]]( var_e5a754e3fa303826, 0, 0 );
        }
    }
}

// Namespace player
// Params 4, eflags: 0x4
// Checksum 0x709d5d63, Offset: 0x4aa8
// Size: 0xaf
function private function_ea504fb31c689dfc( notifyname, var_e5a754e3fa303826, holdduration, var_1617690e741ab65b )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( notifyname + "_endon" );
    self endon( notifyname + "_release" );
    
    if ( !isdefined( var_1617690e741ab65b ) )
    {
        return;
    }
    
    progress = 0;
    holddurationms = holdduration * 1000;
    
    while ( progress < holddurationms )
    {
        waitframe();
        progress += level.frameduration;
        
        if ( progress < holddurationms )
        {
            self thread [[ var_1617690e741ab65b ]]( var_e5a754e3fa303826, progress, 0 );
        }
    }
    
    self thread [[ var_1617690e741ab65b ]]( var_e5a754e3fa303826, progress, 1 );
}

// Namespace player
// Params 4, eflags: 0x4
// Checksum 0xc6a6ada0, Offset: 0x4b5f
// Size: 0x73
function private function_a4f523cad3b0bd4f( notifyname, actioncallback, var_e5a754e3fa303826, var_1f412e56e26e66b5 )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( notifyname + "_release" );
    self endon( notifyname + "_endon" );
    
    while ( true )
    {
        self thread [[ actioncallback ]]( var_e5a754e3fa303826 );
        
        if ( var_1f412e56e26e66b5 > 0 )
        {
            wait var_1f412e56e26e66b5;
            continue;
        }
        
        waitframe();
    }
}

// Namespace player
// Params 1
// Checksum 0x60e16153, Offset: 0x4bda
// Size: 0x22, Type: bool
function function_4ec00e606da98a80( player )
{
    threatcount = function_7df877bb51b9e18b( player );
    return threatcount == 0;
}

// Namespace player
// Params 0
// Checksum 0xde031ccd, Offset: 0x4c05
// Size: 0xe2
function function_bb5faf1c22bd8139()
{
    weaponlist = self getweaponslistprimaries();
    
    foreach ( weaponobject in weaponlist )
    {
        weaponname = weaponobject.basename;
        
        if ( weaponclass( weaponobject ) == "pistol" && !weapon::isfistweapon( weaponname ) && weaponname != "iw8_me_riotshield_mp" && weaponobject != level.defaultknifestab && weaponname != "iw8_throwingknife_fire_melee_mp" && weaponname != "iw8_throwingknife_electric_melee_mp" )
        {
            return weaponobject;
        }
    }
}

// Namespace player
// Params 1
// Checksum 0x79920313, Offset: 0x4cef
// Size: 0x8e
function function_e4f77222086e66b( enable )
{
    assert( isdefined( enable ), "<dev string:x2a8>" );
    
    if ( !isdefined( self.var_8377b8615c82bef7 ) )
    {
        self.var_8377b8615c82bef7 = 0;
    }
    
    if ( enable )
    {
        self.var_8377b8615c82bef7 += 1;
        self function_e8653d9a87fea503( 1 );
        return;
    }
    
    if ( self.var_8377b8615c82bef7 > 0 )
    {
        self.var_8377b8615c82bef7 -= 1;
    }
    
    if ( !self.var_8377b8615c82bef7 )
    {
        self function_e8653d9a87fea503( 0 );
    }
}

// Namespace player
// Params 2
// Checksum 0x925e88ef, Offset: 0x4d85
// Size: 0xa0
function function_509b2945fa3a9b48( enable, var_24f991b3d20dd530 )
{
    assert( isdefined( enable ), "<dev string:x2f7>" );
    
    if ( !isdefined( self.var_b0ba2077de866a7c ) )
    {
        self.var_b0ba2077de866a7c = 0;
    }
    
    if ( enable )
    {
        self.var_b0ba2077de866a7c += 1;
        self function_5b3d07ad769e8d62( 1 );
        thread function_5bf059f1fecef26a( var_24f991b3d20dd530 );
        return;
    }
    
    if ( self.var_b0ba2077de866a7c > 0 )
    {
        self.var_b0ba2077de866a7c -= 1;
    }
    
    if ( !self.var_b0ba2077de866a7c )
    {
        self function_5b3d07ad769e8d62( 0 );
    }
}

// Namespace player
// Params 1, eflags: 0xc
// Checksum 0x6730e420, Offset: 0x4e2d
// Size: 0x7a
function private function_5bf059f1fecef26a( var_24f991b3d20dd530 )
{
    self notify( #"hash_3f33d6d22629cb0c" );
    self endon( #"hash_3f33d6d22629cb0c" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"spawned_player" );
        
        if ( !self.var_b0ba2077de866a7c )
        {
            return;
        }
        
        if ( var_24f991b3d20dd530 )
        {
            self function_5b3d07ad769e8d62( 1 );
            continue;
        }
        
        self.var_b0ba2077de866a7c = 0;
        return;
    }
}

// Namespace player
// Params 2
// Checksum 0x28a67e93, Offset: 0x4eaf
// Size: 0x4a
function function_99816a37e4f0c00a( enable, source )
{
    if ( enable )
    {
        self.var_8004a0813ab720f1[ source ] = 1;
    }
    else
    {
        self.var_8004a0813ab720f1[ source ] = undefined;
    }
    
    self function_e6b6b477a9f04b4c( self.var_8004a0813ab720f1.size > 0 );
}

// Namespace player
// Params 0
// Checksum 0x9444ac8d, Offset: 0x4f01
// Size: 0x1b3
function function_bfca2961435a6a3d()
{
    assert( isplayer( self ) );
    
    if ( !level.clantaglist )
    {
        level.clantaglist = [];
        clantaglist = getscriptbundle( level.projectbundle.clantaglist ).clantaglist;
        
        if ( !clantaglist.size )
        {
            assertmsg( "<dev string:x343>" );
            return 0;
        }
        
        foreach ( clantag in clantaglist )
        {
            clantagasset = getscriptbundle( clantag.clantag_asset );
            level.clantaglist[ level.clantaglist.size ] = clantagasset.ingametag;
            
            foreach ( var_c9fddb25b085c3c3 in clantagasset.var_fdb8f2339b8c1953 ?? [] )
            {
                level.clantaglist[ level.clantaglist.size ] = var_c9fddb25b085c3c3.value;
            }
        }
    }
    
    return arraycontains( level.clantaglist, tolower( self getclantag() ) );
}

