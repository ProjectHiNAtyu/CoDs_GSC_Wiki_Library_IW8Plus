// scripts\mp\ob\systems\ob_pvp.gsc  (hash_1fe190e98cc377c9.gscc) (size: 20483 Bytes / 0x5003 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32a5d6eb (849729259)
// size ...... 20483 (0x5003)
// includes .. 27  (offset: 0x4d17)
// strings ... 34  (offset: 0x4def)
// dev strs .. 5   (offset: 0x4fc7)
// exports ... 52  (offset: 0x312f)
// cseg ...... 0x300 + 0x2e2f (0x312f)
// imports ... 161 (offset: 0x394f)
// animtree1 . 0   (offset: 0x5003)
// animtree2 . 0   (offset: 0x5003)
#using script_16ea1b94f0f381b3;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\br_mood_manager;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\menus;
#using scripts\mp\ob\activities\ob_activity_starter;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_exfil_door;
#using scripts\mp\serversettings;
#using scripts\mp\squads;
#using scripts\mp\supers;
#using scripts\mp\team_assimilation;

#namespace ob_pvp;

// Namespace ob_pvp
// Params 0, eflags: 0x5
// Checksum 0xb9c3d6a1, Offset: 0x31e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_pvp", undefined, undefined, &_post_main_init );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x7084118d, Offset: 0x33f
// Size: 0xf4
function private _post_main_init()
{
    if ( !level.var_bb86f77304f193c4.pvpsettings.enabled )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return 0;
        }
    #/
    
    _shared_init();
    function_adabb97922255fb2();
    time_limit = game_utility_mp::function_82e3606d184524fe();
    
    if ( time_limit != 0 )
    {
        pvp_delay = getdvarint( @"ob_pvp_delay", 0 );
        pvp_duration = getdvarint( @"ob_pvp_duration", 600 );
        assert( time_limit >= pvp_delay + pvp_duration, "<dev string:x24>" + time_limit + "<dev string:x3f>" + pvp_delay + pvp_duration + "<dev string:x83>" );
        
        if ( pvp_delay == 0 )
        {
            thread enable();
        }
        else
        {
            thread function_65ae86ebcccc4d89();
        }
    }
    
    if ( isdefined( level.var_bb131187d6741752 ) )
    {
        callback::add( "player_region_difficulty_change", &function_831e4a7b222f6872 );
    }
    
    utility::flag_set( "ob_pvp_initialized" );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0xb34c8123, Offset: 0x43b
// Size: 0x1cc
function private _shared_init()
{
    level.pvpsettings = {};
    level.pvpsettings.var_b74ab42741d34a50 = getdvarint( @"hash_da34cf82bd36a5b7", level.var_bb86f77304f193c4.pvpsettings.var_b74ab42741d34a50 ?? 7 );
    level.pvpsettings.var_f514c382ed48faea = level.var_bb86f77304f193c4.pvpsettings.var_f514c382ed48faea ?? 600;
    level.pvpsettings.var_2cdf753f5842f378 = level.var_bb86f77304f193c4.pvpsettings.var_2cdf753f5842f378 ?? 100;
    level.pvpsettings.var_da0d4096ee758f5d = level.var_bb86f77304f193c4.pvpsettings.var_da0d4096ee758f5d ?? 20;
    level.pvpsettings.transitionmovie = level.var_bb86f77304f193c4.pvpsettings.transitionmovie ?? "sat_ob_pve_to_pvp";
    utility::registersharedfunc( #"ob_pvp", #"is_enabled", &is_enabled );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_1ff26bdae51f3432", &_disband_squads );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_dc3834e091124170", &_reform_squads );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_4c1a8ea3adb8e9e8", &_toggle );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"ob_pvp_redeploy", &_redeploy_players );
    level._effect[ "vfx_skycrack_falling_embers" ] = loadfxasset( "vfx_sat_wc_cradle_skycrack_debris_falling_a" );
    level callback::add( #"player_connect", &function_2211db4a758fb20b );
}

// Namespace ob_pvp
// Params 0
// Checksum 0x708a156f, Offset: 0x60f
// Size: 0xff
function function_a70f110bb0ab3c80()
{
    if ( utility::flag( "ob_pvp_initialized" ) )
    {
        return;
    }
    
    _shared_init();
    level.laststand_always_disable_damage = 0;
    
    if ( !level.var_bb86f77304f193c4.pvpsettings.var_898a321c5d608958 )
    {
        laststand_damage_disabled = getdvarint( @"hash_d9aac3c340a73886", 1 );
        
        foreach ( player in level.players )
        {
            player.pvpdisabled = 1;
            player.var_5eaebe6e973bbb7b = laststand_damage_disabled;
        }
    }
    
    level.maxallowedteamkills = -1;
    utility::flag_set( "ob_pvp_initialized" );
}

// Namespace ob_pvp
// Params 0
// Checksum 0xf48cd5c4, Offset: 0x716
// Size: 0xc, Type: bool
function is_enabled()
{
    return istrue( level.ob_pvp_enabled );
}

// Namespace ob_pvp
// Params 0
// Checksum 0xda6d3d98, Offset: 0x72b
// Size: 0x1c1
function enable()
{
    if ( !getdvarint( @"ob_pvp_redeploy", 0 ) )
    {
        _fade_to_white();
        utility::delaythread( 1.1, &function_6e06fc7b9997aca9 );
        setnojiptime( 1 );
        _abandon_contracts();
        function_bbbf9c445793e981();
    }
    else
    {
        _redeploy_players();
    }
    
    br_mood_manager::setmood( level.moods[ 1 ] );
    function_f78593fcda7df108();
    
    foreach ( player in level.players )
    {
        player.pvpdisabled = undefined;
        player.var_5eaebe6e973bbb7b = undefined;
    }
    
    if ( getdvarint( @"ob_pvp_friendly_fire", 0 ) )
    {
        function_e5757ecfc7517c3f();
        level notify( #"hash_6edeef7a54182f2" );
        serversettings::setfriendlyfire( 1 );
    }
    
    if ( getdvarint( @"hash_6b32db03d8fe4ad4", 0 ) )
    {
        level.radarhideshots = 0;
        setomnvar( "ui_compass_hide_weapon_pings_minimap", level.radarhideshots );
    }
    
    if ( getdvarint( @"hash_a0b193ef504d2233", 0 ) )
    {
        level.navbarhideshots = 0;
        setomnvar( "ui_compass_hide_weapon_pings_navbar", level.navbarhideshots );
    }
    
    utility::callsharedfunc( #"pleaforhelp", #"hash_4c2d49f7b099c110" );
    level.ob_pvp_enabled = 1;
    setomnvar( "ui_ob_pvp_active", 1 );
    level callback::callback( #"ob_pvp_enabled" );
    level notify( #"ob_pvp_enabled" );
}

// Namespace ob_pvp
// Params 0
// Checksum 0xd3ee8e2e, Offset: 0x8f4
// Size: 0xb9
function disable()
{
    setnojiptime( 0 );
    
    foreach ( player in level.players )
    {
        function_a4d46c6c70cc6f43( player );
    }
    
    function_47313b19a81674e7();
    level.ob_pvp_enabled = 0;
    setomnvar( "ui_ob_pvp_active", 0 );
    level notify( #"ob_pvp_disabled" );
    callback::callback( #"ob_pvp_disabled" );
}

// Namespace ob_pvp
// Params 1
// Checksum 0xc48edb50, Offset: 0x9b5
// Size: 0xdf
function function_3a18dbaeb00ed33( contractplayers )
{
    foreach ( player in contractplayers )
    {
        function_4e9784a0b774c62c( player );
    }
    
    if ( getdvarint( @"ob_pvp_friendly_fire", 0 ) )
    {
        function_e5757ecfc7517c3f();
        level notify( #"hash_6edeef7a54182f2" );
        serversettings::setfriendlyfire( 1 );
    }
    
    level.ob_pvp_enabled = 1;
    setomnvar( "ui_ob_pvp_active", 1 );
    level callback::callback( #"ob_pvp_enabled" );
    level notify( #"ob_pvp_enabled" );
}

// Namespace ob_pvp
// Params 1
// Checksum 0xa4540c8, Offset: 0xa9c
// Size: 0x3d
function function_8c532b8885325275( enabled )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    player = self;
    
    if ( enabled )
    {
        function_228998b183571c22( player );
        return;
    }
    
    function_a4d46c6c70cc6f43( player );
}

// Namespace ob_pvp
// Params 1
// Checksum 0xd9c84072, Offset: 0xae1
// Size: 0x17
function function_4e9784a0b774c62c( player )
{
    player function_8c532b8885325275( 1 );
}

// Namespace ob_pvp
// Params 1
// Checksum 0xfaa88cd3, Offset: 0xb00
// Size: 0xc1
function function_48c6019782d49a8a( contractplayers )
{
    foreach ( player in contractplayers )
    {
        function_6762181e138f15c5( player );
    }
    
    serversettings::setfriendlyfire( 0 );
    level.var_d15d8e645776c167 = 0;
    level.ob_pvp_enabled = 0;
    setomnvar( "ui_ob_pvp_active", 0 );
    level notify( #"ob_pvp_disabled" );
    callback::callback( #"ob_pvp_disabled" );
}

// Namespace ob_pvp
// Params 1
// Checksum 0xe27d4db3, Offset: 0xbc9
// Size: 0x16
function function_6762181e138f15c5( player )
{
    player function_8c532b8885325275( 0 );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x9a112e0d, Offset: 0xbe7
// Size: 0x145
function private function_65ae86ebcccc4d89()
{
    level endon( #"game_ended", #"ob_pvp_enabled" );
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
    
    if ( getdvarint( @"hash_1c5c83d473b41fbc", 1 ) )
    {
        utility::delaythread( getdvarint( @"hash_dbcd459dfd199b42", 1170 ), &_disband_squads );
    }
    
    pvp_delay = getdvarint( @"ob_pvp_delay", 0 );
    level.ob_pvp_start_time = gettime() + int( pvp_delay * 1000 );
    var_262e6abce12537d0 = getdvarint( @"hash_f47037f23dccd24c", 600 );
    var_ac8f8aaea43aedfa = pvp_delay - 600;
    
    if ( var_ac8f8aaea43aedfa > 0 )
    {
        utility::delaythread( var_ac8f8aaea43aedfa, &function_bc94f2723a2174e5, 600 );
    }
    
    var_b8bdca7374254b7e = pvp_delay - 300;
    
    if ( var_b8bdca7374254b7e > 0 )
    {
        utility::delaythread( var_b8bdca7374254b7e, &function_bc94f2723a2174e5, 300 );
    }
    
    var_23e2da35eb46089a = pvp_delay - 120;
    
    if ( var_23e2da35eb46089a > 0 )
    {
        utility::delaythread( var_23e2da35eb46089a, &function_bc94f2723a2174e5, 120 );
    }
    
    thread function_e5b190a14d65fc37();
    
    if ( pvp_delay > 0 )
    {
        wait pvp_delay;
    }
    
    thread function_bd6d5e1dfe08504e();
    enable();
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0xd07f445, Offset: 0xd34
// Size: 0x1a3
function private function_e5b190a14d65fc37()
{
    level endon( #"game_ended", #"ob_pvp_enabled" );
    thread function_df6865acfb30798d();
    pvpdelay = getdvarint( @"ob_pvp_delay", 0 );
    
    if ( pvpdelay <= 0 )
    {
        return;
    }
    
    wait pvpdelay - 3;
    
    foreach ( player in level.players )
    {
        player freezecontrols( 1 );
        var_4e696c1264ef4e4a = player getcamerathirdperson();
        
        if ( var_4e696c1264ef4e4a )
        {
            player.pvpsettings = {};
            player.pvpsettings.var_5828aa3111d7fa78 = 1;
            player setcamerathirdperson( 0 );
        }
        
        player setdemeanorviewmodel( "relaxed", "iw9_ges_demeanor_safe_van_gundown" );
        player set_transition_postfx( %"cer_sp_rdt_hallucination_gas_heavy" );
    }
    
    wait 1;
    
    foreach ( player in level.players )
    {
        player thread screenshake( 2 );
        thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 2 );
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x1f8fccae, Offset: 0xedf
// Size: 0x4c
function private function_4920a1b2ba588abb()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.var_95743ffe445cc52b ) )
    {
        pbgpostfxbundleend( self, self.var_95743ffe445cc52b, 2 );
    }
    
    if ( isdefined( self.var_3851d40224a996b4 ) )
    {
        self.var_3851d40224a996b4 destroy();
        self.var_3851d40224a996b4 = undefined;
    }
}

// Namespace ob_pvp
// Params 3, eflags: 0x4
// Checksum 0xca2fb5f5, Offset: 0xf33
// Size: 0x178
function private set_transition_postfx( var_d008bd0818afbc4f, custom_blood_overlay, var_133bdd8257b93802 = 1 )
{
    function_4920a1b2ba588abb();
    
    if ( !getdvarint( @"hash_28bb1afb575e099e", 0 ) )
    {
        pbgpostfxbundlestart( self, var_d008bd0818afbc4f, 0.01 );
        self.var_95743ffe445cc52b = var_d008bd0818afbc4f;
    }
    
    if ( isdefined( custom_blood_overlay ) )
    {
        var_974632801714d3bd = newclienthudelem( self );
        self.var_3851d40224a996b4 = var_974632801714d3bd;
        var_974632801714d3bd.sort = 10;
        var_974632801714d3bd.x = 0;
        var_974632801714d3bd.y = 0;
        var_974632801714d3bd.alignx = "left";
        var_974632801714d3bd.aligny = "top";
        var_974632801714d3bd.foreground = 0;
        var_974632801714d3bd.lowresbackground = 1;
        var_974632801714d3bd.horzalign = "fullscreen";
        var_974632801714d3bd.vertalign = "fullscreen";
        var_974632801714d3bd.alpha = 0;
        var_974632801714d3bd.enablehudlighting = 1;
        var_974632801714d3bd setshader( custom_blood_overlay, 640, 480 );
        var_974632801714d3bd fadeovertime( var_133bdd8257b93802 );
        var_974632801714d3bd.alpha = 1;
        wait 2.5;
        var_974632801714d3bd fadeovertime( var_133bdd8257b93802 );
        var_974632801714d3bd.alpha = 0;
        wait 0.4;
        function_4920a1b2ba588abb();
        return;
    }
    
    wait 2.5;
    function_4920a1b2ba588abb();
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0x5bd6e3df, Offset: 0x10b3
// Size: 0xbd
function private screenshake( time )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( earthquake_scale ) )
    {
        earthquake_scale = 0.3;
    }
    
    if ( !isdefined( earthquake_radius ) )
    {
        earthquake_radius = 1000;
    }
    
    if ( !isdefined( override_rumble ) )
    {
        override_rumble = "damage_light";
    }
    
    start_time = gettime();
    
    while ( true )
    {
        lasttime = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        self earthquakeforplayer( earthquake_scale, 0.1, self.origin, earthquake_radius );
        self playrumbleonentity( override_rumble );
        
        if ( lasttime > time )
        {
            break;
        }
        
        wait 0.1;
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x49f94e77, Offset: 0x1178
// Size: 0xdc
function private function_df6865acfb30798d()
{
    level endon( #"game_ended", #"ob_pvp_enabled" );
    pvpdelay = getdvarint( @"ob_pvp_delay", 0 );
    
    if ( pvpdelay <= 0 )
    {
        return;
    }
    
    var_23693ccbdb567f66 = pvpdelay - level.pvpsettings.var_da0d4096ee758f5d;
    
    if ( var_23693ccbdb567f66 > 0 )
    {
        wait var_23693ccbdb567f66;
    }
    
    foreach ( player in level.players )
    {
        player ai::set_ignoreme( 1 );
    }
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0x48c6342, Offset: 0x125c
// Size: 0x75
function private function_bc94f2723a2174e5( int_delay )
{
    splash = #"hash_5335f2b07103275b";
    var_24a4cbf2da959a27 = int_delay == 300;
    show_final_warning = int_delay == 120;
    
    if ( var_24a4cbf2da959a27 )
    {
        splash = #"hash_902646d57a0e1248";
    }
    else if ( show_final_warning )
    {
        splash = #"hash_b910f51cb575b935";
    }
    
    hud_util::showsplashtoall( splash, int( int_delay / 60 ) );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0xa7463de4, Offset: 0x12d9
// Size: 0x12
function private function_e5757ecfc7517c3f()
{
    hud_util::showsplashtoall( #"hash_6832346078dd4a95" );
}

// Namespace ob_pvp
// Params 2, eflags: 0x4
// Checksum 0xf7b1d38f, Offset: 0x12f3
// Size: 0x4c
function private function_6e0f9d7cc2a94ff( splashdelay = 0, splashreference = #"ob_pvp_enabled" )
{
    level endon( #"game_ended" );
    
    if ( splashdelay > 0 )
    {
        wait splashdelay;
    }
    
    hud_message::showsplash( splashreference );
}

// Namespace ob_pvp
// Params 2, eflags: 0x4
// Checksum 0x7eaf9583, Offset: 0x1347
// Size: 0x4c
function private function_19e7bea9710ae633( splashdelay = 0, splashreference = #"ob_pvp_enabled" )
{
    level endon( #"game_ended" );
    
    if ( splashdelay > 0 )
    {
        wait splashdelay;
    }
    
    hud_util::showsplashtoall( splashreference );
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0xf53b696c, Offset: 0x139b
// Size: 0x227
function private _disband_squads( params )
{
    setnojiptime( 1 );
    _abandon_contracts();
    function_bbbf9c445793e981();
    var_6787895101874fb4 = 0;
    
    foreach ( team_name, var_3075f96a37ec0e36 in level.squaddata )
    {
        foreach ( squad in var_3075f96a37ec0e36 )
        {
            if ( squad.players.size == 0 )
            {
                continue;
            }
            
            foreach ( player in squad.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !isdefined( player.var_8b283c2d4686a9fe ) )
                {
                    player.var_8b283c2d4686a9fe = team_name;
                }
                
                if ( !isdefined( player.var_a344edf037fbd9e2 ) )
                {
                    player.var_a344edf037fbd9e2 = player.sessionsquadid;
                }
                
                player squads::leavesquad( player.team, player.sessionsquadid );
                player squads::joinsquad( player.team, var_6787895101874fb4 );
                var_6787895101874fb4 += 1;
            }
        }
    }
    
    if ( !getdvarint( @"ob_pvp_redeploy", 0 ) )
    {
        function_f78593fcda7df108();
    }
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0x645ddc1a, Offset: 0x15ca
// Size: 0x22a
function private _redeploy_players( params )
{
    setnojiptime( 1 );
    _abandon_contracts();
    function_bbbf9c445793e981();
    function_f78593fcda7df108();
    redeploy_laststand = getdvarint( @"hash_d780485112e3e1da", 1 );
    var_2add9261d3eb02e2 = [];
    
    foreach ( var_3075f96a37ec0e36 in level.squaddata )
    {
        foreach ( squad in var_3075f96a37ec0e36 )
        {
            if ( squad.players.size > 0 )
            {
                var_a82b7b63ab894cdd = 0;
                
                foreach ( player in squad.players )
                {
                    if ( isalive( player ) && player.sessionstate == "playing" )
                    {
                        if ( redeploy_laststand || !player::isinlaststand( player ) )
                        {
                            var_a82b7b63ab894cdd = 1;
                            break;
                        }
                    }
                }
                
                if ( var_a82b7b63ab894cdd )
                {
                    var_2add9261d3eb02e2[ var_2add9261d3eb02e2.size ] = squad;
                }
            }
        }
    }
    
    if ( var_2add9261d3eb02e2.size > 0 )
    {
        teleportpvp = getdvarint( @"hash_ba68ae8d5ded109d", 0 );
        
        if ( teleportpvp )
        {
            function_791ced5be2d57471( var_2add9261d3eb02e2 );
            return;
        }
        
        function_88b164634f632810( var_2add9261d3eb02e2 );
    }
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0x26592ee9, Offset: 0x17fc
// Size: 0x43
function private function_2211db4a758fb20b( params )
{
    if ( !level.var_bb86f77304f193c4.pvpsettings.var_898a321c5d608958 )
    {
        self.pvpdisabled = 1;
        self.var_5eaebe6e973bbb7b = 1;
    }
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0xbb9fecae, Offset: 0x1847
// Size: 0x76
function private function_831e4a7b222f6872( params )
{
    if ( params.var_705eae6dbfaf5fad == params.new_difficulty )
    {
        return;
    }
    
    if ( params.var_705eae6dbfaf5fad == "difficulty_darkaether" )
    {
        function_a4d46c6c70cc6f43( params.player );
        return;
    }
    
    if ( params.new_difficulty == "difficulty_darkaether" )
    {
        function_228998b183571c22( params.player );
    }
}

// Namespace ob_pvp
// Params 1
// Checksum 0xb90842f3, Offset: 0x18c5
// Size: 0x1ba
function function_c71af5a27522fe85( squad )
{
    if ( squad )
    {
        foreach ( member in squad )
        {
            if ( !team_assimilation::isplayersassimdisabled( member ) )
            {
                member.var_8b283c2d4686a9fe = member.team;
                member.var_a344edf037fbd9e2 = member.sessionsquadid;
                member.var_9ca0869f8bd9f9e5 = member.sessionuimemberindex;
                mainsuper = member supers_mp::getcurrentsuper( #"default" );
                var_5e0955cfeaa760d7 = mainsuper ? mainsuper.staticdata.ref : undefined;
                secondarysuper = member supers_mp::getcurrentsuper( #"tactical" );
                var_ba7902395b870a74 = secondarysuper ? secondarysuper.staticdata.ref : undefined;
                var_a229f55b7f2358f = level.teamnamelist[ 2 + member.sessionsquadid ];
                member menus::addtoteam( var_a229f55b7f2358f, 0, 1, 1 );
                member squads::joinsquad( var_a229f55b7f2358f, 0, member.var_9ca0869f8bd9f9e5 );
                member function_309526e2239facf5( var_5e0955cfeaa760d7, var_ba7902395b870a74 );
                team_assimilation::function_aa6d43748d8cc8f4( member, "ob_pvp" );
                member thread function_16bb85a8fee56418();
            }
        }
    }
}

// Namespace ob_pvp
// Params 0
// Checksum 0x7c51c159, Offset: 0x1a87
// Size: 0x52
function function_16bb85a8fee56418()
{
    level endon( #"game_ended" );
    self endon( #"hash_77db6084fbfb2771" );
    squad = squad_utility::getsquadmembers( undefined, 0 );
    self waittill( #"disconnect" );
    
    if ( !self.pvpdisabled )
    {
        waitframe();
        function_6da7fb7c7035706b( squad );
    }
}

// Namespace ob_pvp
// Params 1
// Checksum 0x3d13f48e, Offset: 0x1ae1
// Size: 0x232
function function_6da7fb7c7035706b( squad )
{
    if ( squad )
    {
        foreach ( member in squad )
        {
            if ( member && !member.pvpdisabled )
            {
                return;
            }
        }
        
        foreach ( member in squad )
        {
            if ( member && member.team && member.team != "axis" && member.team != "allies" )
            {
                mainsuper = member supers_mp::getcurrentsuper( #"default" );
                var_5e0955cfeaa760d7 = mainsuper ? mainsuper.staticdata.ref : undefined;
                secondarysuper = member supers_mp::getcurrentsuper( #"tactical" );
                var_ba7902395b870a74 = secondarysuper ? secondarysuper.staticdata.ref : undefined;
                team_assimilation::function_5e1bb01356d21d7( member, "ob_pvp" );
                member menus::addtoteam( member.var_8b283c2d4686a9fe, 0, 1, 1 );
                member squads::joinsquad( member.var_8b283c2d4686a9fe, member.var_a344edf037fbd9e2 );
                member.var_8b283c2d4686a9fe = undefined;
                member.var_a344edf037fbd9e2 = undefined;
                member.var_9ca0869f8bd9f9e5 = undefined;
                member function_309526e2239facf5( var_5e0955cfeaa760d7, var_ba7902395b870a74 );
                member notify( #"hash_77db6084fbfb2771" );
            }
        }
    }
}

// Namespace ob_pvp
// Params 2, eflags: 0x4
// Checksum 0x4d2518d6, Offset: 0x1d1b
// Size: 0x41
function private function_309526e2239facf5( var_5e0955cfeaa760d7, var_ba7902395b870a74 )
{
    if ( var_5e0955cfeaa760d7 )
    {
        supers_mp::givesuper( var_5e0955cfeaa760d7, 1 );
    }
    
    if ( var_ba7902395b870a74 )
    {
        supers_mp::givesuper( var_ba7902395b870a74, 1, undefined, undefined, undefined, #"tactical" );
    }
}

// Namespace ob_pvp
// Params 1
// Checksum 0xdc1559dd, Offset: 0x1d64
// Size: 0x41
function function_228998b183571c22( player )
{
    player.pvpdisabled = undefined;
    player.var_5eaebe6e973bbb7b = undefined;
    squad = player squad_utility::getsquadmembers( undefined, 0 );
    function_c71af5a27522fe85( squad );
}

// Namespace ob_pvp
// Params 1
// Checksum 0x7b3178fe, Offset: 0x1dad
// Size: 0x47
function function_a4d46c6c70cc6f43( player )
{
    player.pvpdisabled = 1;
    player.var_5eaebe6e973bbb7b = 1;
    squad = player squad_utility::getsquadmembers( undefined, 0 );
    function_6da7fb7c7035706b( squad );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0xb51d19a5, Offset: 0x1dfc
// Size: 0x10d
function private function_adabb97922255fb2()
{
    if ( !isdefined( level.pvpsettings.teleportpoints ) )
    {
        level.pvpsettings.teleportpoints = [];
    }
    
    var_1eb048ce41430987 = utility::getstructarray( "content_struct", "variantname" );
    
    foreach ( s_content in var_1eb048ce41430987 )
    {
        if ( s_content.targetname == "pvp_spawn" && !arraycontains( level.pvpsettings.teleportpoints, s_content ) )
        {
            level.pvpsettings.teleportpoints[ level.pvpsettings.teleportpoints.size ] = s_content;
        }
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x1f7f567, Offset: 0x1f11
// Size: 0x70
function private function_5588f9d931fdcf4d()
{
    if ( level.pvpsettings.teleportpoints.size <= 0 )
    {
        return;
    }
    
    spawnpoint = utility::array_random( level.pvpsettings.teleportpoints );
    level.pvpsettings.teleportpoints = arrayremove( level.pvpsettings.teleportpoints, spawnpoint );
    return spawnpoint;
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0xbd65de12, Offset: 0x1f8a
// Size: 0x1e8
function private function_791ced5be2d57471( var_9e10a2c5e401eb02 )
{
    _empty_vehicles();
    var_1ef510cd826b8266 = [];
    squadindex = 0;
    
    while ( squadindex < var_9e10a2c5e401eb02.size )
    {
        squad = var_9e10a2c5e401eb02[ squadindex ];
        point = function_5588f9d931fdcf4d();
        
        if ( !isdefined( point ) )
        {
            assertmsg( "<dev string:x8d>" );
            point = { #origin:( 0, 0, 500 ) };
        }
        
        playerindex = 0;
        
        while ( playerindex < squad.players.size )
        {
            player = squad.players[ playerindex ];
            
            if ( player::isinlaststand( player ) )
            {
                player thread laststand::function_75e6bc3d39e1f2bb( player, "last_stand_redeploy" );
            }
            
            point.origin += ( randomfloatrange( level.pvpsettings.var_2cdf753f5842f378, level.pvpsettings.var_f514c382ed48faea ), randomfloatrange( level.pvpsettings.var_2cdf753f5842f378, level.pvpsettings.var_f514c382ed48faea ), 500 );
            spawnpos = getclosestpointonnavmesh( point.origin );
            newspawnorigin = playerphysicstrace( spawnpos + ( 0, 0, 128 ), spawnpos - ( 0, 0, 128 ), player );
            
            if ( isdefined( newspawnorigin ) )
            {
                spawnpos = newspawnorigin;
            }
            
            player setvelocity( ( 0, 0, 0 ) );
            player setorigin( spawnpos );
            player function_b59608aca94efe53();
            pbgpostfxbundlestart( #"all", %"sat_cradle_pvp_chroma_persist_base" );
            player thread function_9e727c2d7feb6c7c();
            playerindex += 1;
        }
        
        squadindex += 1;
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x610cf3af, Offset: 0x217a
// Size: 0x68
function private function_583a963151c13628()
{
    exfilpoint = ob_exfil_door::function_fbf793c284a15f01();
    function_4920a1b2ba588abb();
    assert( isdefined( exfilpoint ), "<dev string:xc7>" );
    self setplayerangles( vectortoangles( exfilpoint.origin - self.origin ) );
    
    if ( self.pvpsettings.var_5828aa3111d7fa78 )
    {
        self setcamerathirdperson( 1 );
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0xf93b0a72, Offset: 0x21ea
// Size: 0x9c
function private function_9f2d822d8320d727()
{
    overlay_state_off = 0;
    var_a0559c761d5a74bb = 10;
    isencrypted = 0;
    self setclientomnvar( "ui_br_bink_overlay_state", var_a0559c761d5a74bb );
    utility::hidehudenable();
    self playcinematicforplayer( level.pvpsettings.transitionmovie );
    wait level.pvpsettings.var_b74ab42741d34a50 - 0.1;
    level thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( self, 1, 0.1 );
    wait 0.1;
    self stopcinematicforplayer();
    utility::hidehuddisable();
    self setclientomnvar( "ui_br_bink_overlay_state", 0 );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x1c60c8fe, Offset: 0x228e
// Size: 0x81
function private function_9e727c2d7feb6c7c()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    function_9f2d822d8320d727();
    function_583a963151c13628();
    thread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( self, 0, 0.5 );
    thread function_6e0f9d7cc2a94ff( 0.5 );
    thread function_514199b26ad7fb3e();
    wait 1;
    self setdemeanorviewmodel( "normal" );
    self freezecontrols( 0 );
    playfxontagforclients( utility::getfx( "vfx_skycrack_falling_embers" ), self, "tag_eye", self );
    utility::exploder( "cradle_loc_fx_quad_03" );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x4940606a, Offset: 0x2317
// Size: 0x36
function private function_514199b26ad7fb3e()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait level.pvpsettings.var_da0d4096ee758f5d;
    ai::set_ignoreme( 0 );
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0xa2b4b041, Offset: 0x2355
// Size: 0x2d3
function private function_88b164634f632810( var_2add9261d3eb02e2 )
{
    redeploy_laststand = getdvarint( @"hash_d780485112e3e1da", 1 );
    _empty_vehicles();
    _fade_to_white();
    wait 1.1;
    var_f97e30ed6cb08db8 = 360 / float( var_2add9261d3eb02e2.size );
    squad_circle_radius = getdvarint( @"hash_c499b0b00c8b9010", 6000 );
    squad_circle_elevation = getdvarint( @"hash_eea884b77e47c461", 25000 );
    squad_circle_center = getdvarvector( @"hash_441b2020338cb727", ( -22000, -14700, 0 ) );
    squad_circle_center = ( squad_circle_center[ 0 ], squad_circle_center[ 1 ], squad_circle_elevation );
    player_circle_radius = getdvarint( @"hash_4563a7d72c598452", 200 );
    
    /#
        debug::sphere( squad_circle_center, 10, ( 1, 0, 1 ), 60 );
        debug::cylinder( squad_circle_center, squad_circle_center + ( 0, 0, 1 ), squad_circle_radius, ( 1, 0, 1 ), 60 );
    #/
    
    squad_index = 0;
    
    while ( squad_index < var_2add9261d3eb02e2.size )
    {
        squad = var_2add9261d3eb02e2[ squad_index ];
        var_9768e2b2d470938f = squad_index * var_f97e30ed6cb08db8;
        var_76fdaecfdba85e9e = squad_circle_center + ( squad_circle_radius * cos( var_9768e2b2d470938f ), squad_circle_radius * sin( var_9768e2b2d470938f ), 0 );
        var_379c57ad8b8205c7 = 360 / float( squad.players.size );
        
        /#
            debug::sphere( var_76fdaecfdba85e9e, 10, ( 0, 1, 0 ), 60 );
            debug::cylinder( var_76fdaecfdba85e9e, var_76fdaecfdba85e9e + ( 0, 0, 1 ), player_circle_radius, ( 0, 1, 0 ), 60 );
        #/
        
        var_6787895101874fb4 = 0;
        
        while ( var_6787895101874fb4 < squad.players.size )
        {
            player = squad.players[ var_6787895101874fb4 ];
            
            if ( redeploy_laststand && player::isinlaststand( player ) )
            {
                player thread laststand::function_75e6bc3d39e1f2bb( player, "last_stand_redeploy" );
            }
            
            var_5f36382ef6771806 = var_6787895101874fb4 * var_379c57ad8b8205c7;
            var_c41ed86428a74741 = var_76fdaecfdba85e9e + ( player_circle_radius * cos( var_5f36382ef6771806 ), player_circle_radius * sin( var_5f36382ef6771806 ), 0 );
            player setvelocity( ( 0, 0, 0 ) );
            player setorigin( var_c41ed86428a74741 );
            player setplayerangles( vectortoangles( ( 0, 0, 0 ) - var_c41ed86428a74741 ) );
            player function_b59608aca94efe53();
            
            /#
                debug::sphere( var_c41ed86428a74741, 5, ( 1, 1, 1 ), 60 );
            #/
            
            var_6787895101874fb4 += 1;
        }
        
        squad_index += 1;
    }
    
    function_6e06fc7b9997aca9();
    thread function_19e7bea9710ae633( 0.5 );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x334012c8, Offset: 0x2630
// Size: 0x21
function private _fade_to_white()
{
    function_bd83052e023bf9bc();
    function_d21cd9ec01b2df47( 1000, "WorldAndHud", ( 1, 1, 1 ) );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x48b3fe4e, Offset: 0x2659
// Size: 0xf
function private function_6e06fc7b9997aca9()
{
    function_aa3cd643ac2c86cc( 1000, "WorldAndHud" );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x1699dfcd, Offset: 0x2670
// Size: 0x1dc
function private _abandon_contracts()
{
    if ( !getdvarint( @"hash_ecf78db81a378398", 1 ) )
    {
        return;
    }
    
    if ( level.var_b02bc52f1fbe82f5 || !getdvarint( @"hash_ecf78db81a378398", 1 ) )
    {
        return;
    }
    
    level.var_b02bc52f1fbe82f5 = 1;
    
    foreach ( player in level.players )
    {
        var_8a83b4c7e46b8743 = [];
        var_52d4da429e976345 = activity_participation::function_e8eabd79cc49540e( player );
        
        foreach ( instance_id, instance_info_struct in var_52d4da429e976345 )
        {
            activity_instance = level.activities.instances[ instance_id ];
            
            if ( activity_instance.category == "Contract" )
            {
                var_8a83b4c7e46b8743[ var_8a83b4c7e46b8743.size ] = activity_instance;
            }
        }
        
        foreach ( activity_instance in var_8a83b4c7e46b8743 )
        {
            thread activity_participation::function_61aa2b2879f2c0a2( activity_instance, player, 1 );
        }
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x7b069b3a, Offset: 0x2854
// Size: 0x172
function private function_bbbf9c445793e981()
{
    if ( level.var_ecc19c853fe0bc3f || !isdefined( level.var_e607236b193eb0c1.var_9433e6119f67c877 ) )
    {
        return;
    }
    
    level.var_ecc19c853fe0bc3f = 1;
    
    if ( getdvarint( @"hash_319ca30d7bd89027", 0 ) )
    {
        level.var_e607236b193eb0c1.var_ca2624de39435df5 = 0;
        
        foreach ( starter in level.var_e607236b193eb0c1.var_9433e6119f67c877 )
        {
            starter ob_activity_starter::show_activity_starter();
        }
    }
    else if ( getdvarint( @"hash_6b91e393a8b07125", 1 ) )
    {
        foreach ( starter in level.var_e607236b193eb0c1.var_9433e6119f67c877 )
        {
            starter ob_activity_starter::hide_activity_starter();
        }
    }
    
    ob_activity_manager::ob_activity_manager_toggle( 0 );
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x9d33700a, Offset: 0x29ce
// Size: 0x1a6
function private function_f78593fcda7df108()
{
    if ( level.var_b1a4be9f4e75b1a1 )
    {
        return;
    }
    
    level.var_b1a4be9f4e75b1a1 = 1;
    
    foreach ( var_3075f96a37ec0e36 in level.squaddata )
    {
        foreach ( squad in var_3075f96a37ec0e36 )
        {
            if ( squad.players.size == 0 )
            {
                continue;
            }
            
            foreach ( player in squad.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( player ) )
                {
                    level thread [[ level.var_ec8e0db9b18cc122 ]]( player );
                    continue;
                }
                
                function_228998b183571c22( player );
            }
        }
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x5431e403, Offset: 0x2b7c
// Size: 0x19f
function private function_47313b19a81674e7()
{
    foreach ( var_3075f96a37ec0e36 in level.squaddata )
    {
        foreach ( squad in var_3075f96a37ec0e36 )
        {
            if ( squad.players.size == 0 )
            {
                continue;
            }
            
            foreach ( player in squad.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player menus::addtoteam( player.var_8b283c2d4686a9fe, 0, 1, 1 );
                player squads::joinsquad( player.var_8b283c2d4686a9fe, player.var_a344edf037fbd9e2 );
            }
        }
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0xe5e5887b, Offset: 0x2d23
// Size: 0x1bf
function private function_bd6d5e1dfe08504e()
{
    level endon( #"game_ended", #"ob_pvp_disabled" );
    pvp_duration = getdvarint( @"ob_pvp_duration", 600 );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player utility::delaythread( pvp_duration - 5, &set_transition_postfx, %"cer_sp_rdt_hallucination_gas_heavy", "ui_player_pain_cradlefury_overlay" );
        }
    }
    
    if ( pvp_duration > 0 )
    {
        wait pvp_duration;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && !player.b_completed_exfil )
        {
            player thread ob::function_daeaf0f2a453b0fb();
            
            if ( isalive( player ) && player.sessionstate == "playing" )
            {
                player kill();
            }
        }
    }
    
    if ( !level.gameended )
    {
        wait 25;
        level notify( #"game_ended_aether_storm" );
        level thread gamelogic_mp::endgame( "none", game[ "end_reason" ][ "time_limit_reached" ], game[ "end_reason" ][ "time_limit_reached" ] );
    }
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0x92c2a731, Offset: 0x2eea
// Size: 0xcd
function private _reform_squads( params )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.var_8b283c2d4686a9fe ) )
        {
            player menus::addtoteam( player.var_8b283c2d4686a9fe, 0, 1, 1 );
            player squads::joinsquad( player.var_8b283c2d4686a9fe, player.var_a344edf037fbd9e2 );
        }
    }
}

// Namespace ob_pvp
// Params 1, eflags: 0x4
// Checksum 0xc1b7f8cd, Offset: 0x2fbf
// Size: 0x34
function private _toggle( params )
{
    if ( is_enabled() )
    {
        disable();
        thread function_65ae86ebcccc4d89();
        return;
    }
    
    enable();
    thread function_bd6d5e1dfe08504e();
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x9bdc5a69, Offset: 0x2ffb
// Size: 0x10e
function private _empty_vehicles()
{
    if ( isdefined( level.vehicle.instances ) )
    {
        foreach ( var_b62aa59a8dd1456a in level.vehicle.instances )
        {
            foreach ( vehicle in var_b62aa59a8dd1456a )
            {
                if ( vehicle_occupancy::instance_is_registered( vehicle ) )
                {
                    vehicle_occupancy::eject_all_occupants( vehicle );
                }
            }
        }
    }
}

// Namespace ob_pvp
// Params 0, eflags: 0x4
// Checksum 0x34c4b06d, Offset: 0x3111
// Size: 0x1e
function private function_b59608aca94efe53()
{
    if ( self.var_a6e870d8e686a116 )
    {
        perkpackage::perkpackage_giveimmediate( self.var_a6e870d8e686a116 );
    }
}

