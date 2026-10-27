// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_boss_fight_oubliette.gsc  (hash_29f8fb7095fe1210.gscc) (size: 30487 Bytes / 0x7717 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf783db63 (4152613731)
// size ...... 30487 (0x7717)
// includes .. 25  (offset: 0x7027)
// strings ... 71  (offset: 0x70ef)
// dev strs .. 34  (offset: 0x757b)
// exports ... 83  (offset: 0x488b)
// cseg ...... 0x677 + 0x4214 (0x488b)
// imports ... 211 (offset: 0x5583)
// animtree1 . 0   (offset: 0x7717)
// animtree2 . 0   (offset: 0x7717)
#using script_16ea1b94f0f381b3;
#using script_1dcff6bbe8de311c;
#using script_38a61e43967bfd11;
#using script_3d250c1a364843aa;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\common;
#using scripts\mp\hud_message;
#using scripts\mp\playerhealth;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_boss_fight;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\killstreaks\zm_remove_ammo;
#using scripts\mp\zm\systems\zm_laststand;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_boss_fight_oubliette;

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x5
// Checksum 0x85d30408, Offset: 0x695
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"scarab_boss_fight_oubliette", #"scarab_boss_fight", &pre_main, &post_main );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x3eab5790, Offset: 0x6c2
// Size: 0x4a
function private pre_main()
{
    level.oubliette_data = spawnstruct();
    init_dvars();
    init_oubliette_positions();
    function_44abfae1dfa98d3f();
    level.var_348a1070393d7e6a = &function_1cd83c2053a3b99c;
    level.var_7014be48b4467a43 = &function_1dcc6506b2547b50;
    
    /#
        init_debug();
    #/
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x3f3385e7, Offset: 0x714
// Size: 0x1c
function private post_main()
{
    utility::flag_wait( "init_powerups_complete" );
    function_c62007140a0a8001();
    init_curses();
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1
// Checksum 0x6baae9, Offset: 0x738
// Size: 0x15
function function_1cd83c2053a3b99c( params )
{
    function_9d592bf4751a9015( params );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1
// Checksum 0x700ad39a, Offset: 0x755
// Size: 0x48
function function_1dcc6506b2547b50( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    params.player thread punish_arena_camper( params.origin, params.angles );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0
// Checksum 0xdd16854c, Offset: 0x7a5
// Size: 0x148
function function_ad845354ea06041f()
{
    if ( utility::flag( "oubliette_listener_enabled" ) )
    {
        return;
    }
    
    level utility::flag_set( "oubliette_listener_enabled" );
    level callback::add( #"hash_b22f26734fcf223c", &function_9d592bf4751a9015 );
    level callback::add( #"player_laststand_bleedout", &function_5f7514b664ba0082 );
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_damaged", &on_player_damaged );
    level.var_916aae8097d37e9e = &oubliette_laststand_alive_check;
    
    foreach ( player in level.players )
    {
        player.var_59cd809a932c6ee1 = 1;
        player.var_2ddab79ae85798d2 = 1;
    }
    
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_1", 1 );
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_2", 1 );
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_3", 1 );
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_4", 1 );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 2
// Checksum 0x36599ecc, Offset: 0x8f5
// Size: 0x161
function function_1f49bb252c140a93( blessing_duration_multiplier = 1, curse_duration_multiplier = 1 )
{
    if ( isdefined( level.oubliette_data.var_34f28bf03c7a3a44 ) )
    {
        foreach ( s_blessing in level.oubliette_data.var_34f28bf03c7a3a44 )
        {
            function_2562653bb240c83f( s_blessing, blessing_duration_multiplier );
        }
    }
    
    if ( isdefined( level.oubliette_data.a_curses ) )
    {
        foreach ( s_curse in level.oubliette_data.a_curses )
        {
            function_2562653bb240c83f( s_curse, curse_duration_multiplier );
        }
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1
// Checksum 0xe25bc6ed, Offset: 0xa5e
// Size: 0x22
function on_player_connect( params )
{
    self.var_59cd809a932c6ee1 = 1;
    self.var_2ddab79ae85798d2 = 1;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1
// Checksum 0xa704e2ce, Offset: 0xa88
// Size: 0x8e
function on_player_damaged( params )
{
    if ( is_in_oubliette( self ) && self.health - params.idamage <= 0 && !function_c24dbc26b2caf4a5( self ) )
    {
        if ( self.var_ceb069654e508d3d || utility::callsharedfunc( #"zombie", #"hash_4f9869dbac8ed658" ) > 0 )
        {
            return;
        }
        
        val::set( "oubliette", "damage", 0 );
        self.health = 1;
        self.var_e48757aaac52d7cd = 1;
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1
// Checksum 0x95af14a, Offset: 0xb1e
// Size: 0x4e
function function_5f7514b664ba0082( params )
{
    if ( !is_oubliette_enabled() )
    {
        return;
    }
    
    if ( is_in_oubliette( self ) || !function_6fc24b6296bc9af4( self ) )
    {
        self.var_b2b283c015cf3bd4 = 1;
        self.health = 1;
        oubliette_laststand_alive_check( undefined, undefined, 1 );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0
// Checksum 0x67cbb45a, Offset: 0xb74
// Size: 0x160
function function_3bf31568b43f4cd7()
{
    if ( !utility::flag( "oubliette_listener_enabled" ) )
    {
        return;
    }
    
    level utility::flag_clear( "oubliette_listener_enabled" );
    level callback::remove( #"hash_b22f26734fcf223c", &function_9d592bf4751a9015 );
    level callback::remove( #"player_laststand_bleedout", &function_5f7514b664ba0082 );
    level callback::remove( #"player_connect", &on_player_connect );
    level callback::remove( #"player_damaged", &on_player_damaged );
    level.var_916aae8097d37e9e = undefined;
    
    foreach ( player in level.players )
    {
        player.var_59cd809a932c6ee1 = undefined;
        player.var_2ddab79ae85798d2 = undefined;
        player.var_b2b283c015cf3bd4 = undefined;
        player effect_slow::function_80a4bd13b5ba303a( "scarab_arena_camper" );
    }
    
    utility::flag_clear( "scarab_pause_boss_adds" );
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_1", 0 );
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_2", 0 );
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_3", 0 );
    zone_manager::set_zone_enabled( "zone_boss_arena_oubliette_4", 0 );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x78edfe9f, Offset: 0xcdc
// Size: 0x21
function private init_dvars()
{
    setdvarifuninitialized( @"scr_oubliette_enabled", 1 );
    setdvarifuninitialized( @"scr_oubliette_debug", 0 );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x927e9267, Offset: 0xd05
// Size: 0x1bd
function private init_oubliette_positions()
{
    level.oubliette_data.var_d291d25e304704c2 = utility::getstructarray( "oubliette_pos", "targetname" );
    
    if ( level.oubliette_data.var_d291d25e304704c2.size < 4 )
    {
        level.oubliette_data.var_d291d25e304704c2 = [];
        fallback_positions = [];
        fallback_positions[ 0 ] = { #angles:( 0, 215, 0 ), #origin:( 28847.3, 29493.9, 2026.87 ) };
        fallback_positions[ 1 ] = { #angles:( 0, 246, 0 ), #origin:( 29845.2, 28522.2, 1941.82 ) };
        fallback_positions[ 2 ] = { #angles:( 0, 291, 0 ), #origin:( 31623.6, 28500.3, 2097.5 ) };
        fallback_positions[ 3 ] = { #angles:( 0, 330, 0 ), #origin:( 32783.4, 29403.1, 2030.41 ) };
        
        for ( i = 0; i < 4 ; i++ )
        {
            s = { #angles:fallback_positions[ i ].angles, #origin:fallback_positions[ i ].origin, #targetname:"oubliette_pos" };
            utility::addstruct( s );
            level.oubliette_data.var_d291d25e304704c2[ level.oubliette_data.var_d291d25e304704c2.size ] = s;
        }
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x8944b4ee, Offset: 0xeca
// Size: 0x13d
function private function_44abfae1dfa98d3f()
{
    level.oubliette_data.var_a853ab2d0e15fc18 = [];
    s_survive = spawnstruct();
    s_survive.str_name = "survive";
    s_survive.var_351e697cf49327bf = &function_26df201e9e223c61;
    s_survive.func_update = &function_83142b59ded48aa6;
    s_survive.func_terminate = &function_355e20d92206e412;
    s_survive.h_splash = #"hash_5d1ba0d371f36b0a";
    level.oubliette_data.var_a853ab2d0e15fc18[ level.oubliette_data.var_a853ab2d0e15fc18.size ] = s_survive;
    var_ad9a01cda21edf08 = spawnstruct();
    var_ad9a01cda21edf08.str_name = "kill_zombie";
    var_ad9a01cda21edf08.var_351e697cf49327bf = &function_c5e2a753d2ddd812;
    var_ad9a01cda21edf08.func_update = &function_526b5324515e1c11;
    var_ad9a01cda21edf08.func_terminate = &function_2699591f0c44868f;
    var_ad9a01cda21edf08.h_splash = #"hash_7a15bc8e4f780040";
    level.oubliette_data.var_a853ab2d0e15fc18[ level.oubliette_data.var_a853ab2d0e15fc18.size ] = var_ad9a01cda21edf08;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x3edce1c, Offset: 0x100f
// Size: 0x220
function private function_c62007140a0a8001()
{
    level.oubliette_data.var_34f28bf03c7a3a44 = [];
    s_health = spawnstruct();
    s_health.str_name = "scarab_oubliette_blessing_health";
    powerups::register_powerup( s_health.str_name );
    s_health.var_351e697cf49327bf = &function_d1ee9ee24c22c226;
    s_health.func_terminate = &function_459da5b38dc5f89b;
    s_health.h_splash = #"hash_238df6983dbbea8a";
    s_health.var_dc58879cfee40e71 = powerups::get_powerup_info( s_health.str_name ).var_3f03b937c69044df;
    level.oubliette_data.var_34f28bf03c7a3a44[ level.oubliette_data.var_34f28bf03c7a3a44.size ] = s_health;
    s_speed = spawnstruct();
    s_speed.str_name = "scarab_oubliette_blessing_speed";
    powerups::register_powerup( s_speed.str_name );
    s_speed.var_351e697cf49327bf = &function_dce32ebc56e3f5c7;
    s_speed.func_terminate = &function_f2591c174066c4e0;
    s_speed.h_splash = #"hash_7bc6b20d268595e7";
    s_speed.var_dc58879cfee40e71 = powerups::get_powerup_info( s_speed.str_name ).var_3f03b937c69044df;
    level.oubliette_data.var_34f28bf03c7a3a44[ level.oubliette_data.var_34f28bf03c7a3a44.size ] = s_speed;
    s_overheal = spawnstruct();
    s_overheal.str_name = "scarab_oubliette_blessing_overheal";
    powerups::register_powerup( s_overheal.str_name );
    s_overheal.var_351e697cf49327bf = &function_49096dfb984ca9b7;
    s_overheal.func_terminate = &function_36382a5076ddebf0;
    s_overheal.h_splash = #"hash_6cdb29d350227f30";
    level.oubliette_data.var_34f28bf03c7a3a44[ level.oubliette_data.var_34f28bf03c7a3a44.size ] = s_overheal;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xeacf09e6, Offset: 0x1237
// Size: 0x247
function private init_curses()
{
    level.oubliette_data.a_curses = [];
    s_health = spawnstruct();
    s_health.str_name = "scarab_oubliette_curse_health";
    powerups::register_powerup( s_health.str_name );
    s_health.var_351e697cf49327bf = &function_ae27637004d7e215;
    s_health.func_terminate = &function_2b1f7ed98d93d98e;
    s_health.h_splash = #"hash_9cc0efcf57c89fc7";
    s_health.var_dc58879cfee40e71 = powerups::get_powerup_info( s_health.str_name ).var_3f03b937c69044df;
    level.oubliette_data.a_curses[ level.oubliette_data.a_curses.size ] = s_health;
    s_speed = spawnstruct();
    s_speed.str_name = "scarab_oubliette_curse_speed";
    powerups::register_powerup( s_speed.str_name );
    s_speed.var_351e697cf49327bf = &function_cdc1335301296a7e;
    s_speed.func_terminate = &function_9512d459db2b6863;
    s_speed.h_splash = #"hash_a389e4276f0b8a98";
    s_speed.var_dc58879cfee40e71 = powerups::get_powerup_info( s_speed.str_name ).var_3f03b937c69044df;
    level.oubliette_data.a_curses[ level.oubliette_data.a_curses.size ] = s_speed;
    s_ammo_drain = spawnstruct();
    s_ammo_drain.str_name = "scarab_oubliette_curse_ammo_drain";
    powerups::register_powerup( s_ammo_drain.str_name );
    s_ammo_drain.var_351e697cf49327bf = &function_92e9713d091ce2b1;
    s_ammo_drain.func_terminate = &function_14443193d4a5bc02;
    s_ammo_drain.h_splash = #"hash_f01b720bea370bfa";
    s_ammo_drain.var_dc58879cfee40e71 = powerups::get_powerup_info( s_ammo_drain.str_name ).var_3f03b937c69044df;
    level.oubliette_data.a_curses[ level.oubliette_data.a_curses.size ] = s_ammo_drain;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x72ffd9da, Offset: 0x1486
// Size: 0x11
function private is_oubliette_enabled()
{
    return getdvarint( @"scr_oubliette_enabled", 1 );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x55138cd9, Offset: 0x14a0
// Size: 0x31, Type: bool
function private is_in_oubliette( player )
{
    return isdefined( player.oubliette ) && player.oubliette.var_c858d5cbff6ce7a;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x30630fe0, Offset: 0x14da
// Size: 0x82, Type: bool
function private function_47d577ce66296881()
{
    foreach ( player in level.players )
    {
        if ( !is_in_oubliette( player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x297f8a98, Offset: 0x1565
// Size: 0x31, Type: bool
function private function_6fc24b6296bc9af4( player )
{
    return isdefined( player.oubliette ) && player.oubliette.var_aa37e26da3c29ca6;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0xd737a181, Offset: 0x159f
// Size: 0x61
function private function_f9a5a612ceeadecc( player )
{
    if ( isdefined( player ) && !isdefined( player.oubliette ) )
    {
        player.oubliette = spawnstruct();
        player.oubliette.var_c858d5cbff6ce7a = 0;
        player.oubliette.var_aa37e26da3c29ca6 = 0;
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 2, eflags: 0x4
// Checksum 0xffc5dee8, Offset: 0x1608
// Size: 0x94
function private function_2562653bb240c83f( s_effect, var_5c38d637c77b7dc )
{
    if ( !isdefined( s_effect ) || !isdefined( s_effect.var_dc58879cfee40e71 ) || var_5c38d637c77b7dc == 0 )
    {
        return;
    }
    
    if ( isdefined( s_effect.n_duration_mult ) )
    {
        s_effect.var_dc58879cfee40e71 /= s_effect.n_duration_mult;
    }
    
    s_effect.var_dc58879cfee40e71 *= var_5c38d637c77b7dc;
    s_effect.n_duration_mult = var_5c38d637c77b7dc;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0xe5db52d0, Offset: 0x16a4
// Size: 0x27
function private function_ae1626e015ddeaeb( str_splash )
{
    self endon( #"disconnect" );
    thread hud_message::showsplash( str_splash );
    wait 3.6;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x21e63fd7, Offset: 0x16d3
// Size: 0x55
function private function_54cddad5c49cb22c()
{
    zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hash_dcd8be201e573f30", #"survive" );
    zm_quest::function_fb3af5600f6a9441( 2, 0, #"hash_dcd8be201e573f30", #"survive" );
    zm_quest::function_194bde735238c397( 0, 0, #"hash_dcd8be201e573f30", #"survive" );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0xc3e29f24, Offset: 0x1730
// Size: 0x2d
function private function_390718a4de9b30dc( var_92777c38b4ad0d31 )
{
    zm_quest::function_612a9ad0db22c29c( max( var_92777c38b4ad0d31, 0 ), 0, #"hash_dcd8be201e573f30", #"survive" );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xf1f19f2b, Offset: 0x1765
// Size: 0x38
function private function_1bd5409518b9a375()
{
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"hash_dcd8be201e573f30", #"survive" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_dcd8be201e573f30", #"survive" );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xb85ece64, Offset: 0x17a5
// Size: 0x55
function private function_f813035006462c22()
{
    zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hash_3452af139bb0b156", #"kill" );
    zm_quest::function_fb3af5600f6a9441( 2, 0, #"hash_3452af139bb0b156", #"kill" );
    zm_quest::function_194bde735238c397( 0, 0, #"hash_3452af139bb0b156", #"kill" );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0xd1ad41fa, Offset: 0x1802
// Size: 0x2d
function private function_a7bd34f62dcc8212( var_92777c38b4ad0d31 )
{
    zm_quest::function_612a9ad0db22c29c( max( var_92777c38b4ad0d31, 0 ), 0, #"hash_3452af139bb0b156", #"kill" );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x6c8681f2, Offset: 0x1837
// Size: 0x38
function private function_6ce2e120e0325d79()
{
    zm_quest::function_fb3af5600f6a9441( 0, 0, #"hash_3452af139bb0b156", #"kill" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_3452af139bb0b156", #"kill" );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 3
// Checksum 0xf9a5f108, Offset: 0x1877
// Size: 0xe2
function oubliette_laststand_alive_check( revived, var_5f24a9f0b0ddc048, var_99fbd1cba8ecfa0b )
{
    self notify( #"hash_72057a4bfecfac29" );
    self endon( #"hash_72057a4bfecfac29" );
    self endon( #"disconnect" );
    
    if ( zm_laststand::function_fc08a43f3c091f07() && isalive( self ) && !var_99fbd1cba8ecfa0b )
    {
        zm_laststand::function_939a1c1c651dca54( revived, var_5f24a9f0b0ddc048 );
        return;
    }
    
    if ( is_oubliette_enabled() && isdefined( self ) && ( is_in_oubliette( self ) || !function_6fc24b6296bc9af4( self ) ) )
    {
        val::set( "oubliette", "allow_last_stand", 1 );
        wait 1.5;
    }
    
    var_8fa88eeb0de47824 = function_9aa21e8c5bdb659d();
    
    if ( !var_8fa88eeb0de47824 )
    {
        if ( isdefined( self ) )
        {
            self.var_2ddab79ae85798d2 = undefined;
            self.var_b2b283c015cf3bd4 = undefined;
        }
        
        thread zm_laststand::function_939a1c1c651dca54( revived, var_5f24a9f0b0ddc048 );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x8373c96b, Offset: 0x1961
// Size: 0x50, Type: bool
function private function_9aa21e8c5bdb659d()
{
    if ( !isdefined( self ) )
    {
        return false;
    }
    
    if ( !is_oubliette_enabled() )
    {
        return false;
    }
    
    function_f9a5a612ceeadecc( self );
    
    if ( is_in_oubliette( self ) )
    {
        return true;
    }
    
    if ( function_6fc24b6296bc9af4( self ) )
    {
        return false;
    }
    
    zm_utility::force_revive_player( undefined, undefined, 1 );
    thread enter_oubliette( "bleedout" );
    return true;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0xbe4de26b, Offset: 0x19ba
// Size: 0x152
function private function_9d592bf4751a9015( params )
{
    if ( !is_oubliette_enabled() )
    {
        return;
    }
    
    if ( isalive( level.s_scarab_boss.entity ) )
    {
        level.s_scarab_boss.entity function_786bb6aa1b76c7ee( "force_disable_agressive", 1 );
        level.s_scarab_boss.entity zombie_weyward_charge::function_352aeaca3b19325a();
    }
    
    a_players = params.a_players ?? level.players;
    
    foreach ( player in a_players )
    {
        function_f9a5a612ceeadecc( player );
        
        if ( is_in_oubliette( player ) )
        {
            continue;
        }
        
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        if ( level.b_zm_game_over )
        {
            continue;
        }
        
        player zm_utility::force_revive_player( undefined, undefined, 1 );
        player thread enter_oubliette( params.source ?? "callback" );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x708ff2f1, Offset: 0x1b14
// Size: 0x2d3
function private enter_oubliette( var_cba1f4ce367d5887 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    logstring( "====Oubliette Enter Source " + ( var_cba1f4ce367d5887 ?? "unknown" ) );
    function_f9a5a612ceeadecc( self );
    val::set( "enter_oubliette", "damage", 0 );
    self.oubliette.var_c858d5cbff6ce7a = 1;
    
    if ( function_47d577ce66296881() && isalive( level.s_scarab_boss.entity ) )
    {
        level.s_scarab_boss.entity function_786bb6aa1b76c7ee( "force_disable_agressive", 1 );
        level.s_scarab_boss.entity zombie_weyward_charge::function_352aeaca3b19325a();
    }
    
    if ( var_cba1f4ce367d5887 == "bleedout" || var_cba1f4ce367d5887 == "phase_immune" )
    {
        self.oubliette.var_aa37e26da3c29ca6 = 1;
    }
    
    if ( var_cba1f4ce367d5887 == "phase_immune" || var_cba1f4ce367d5887 == "callback" )
    {
        if ( !utility::flag( "scarab_pause_boss_adds" ) )
        {
            utility::flag_set( "scarab_pause_boss_adds" );
            level thread zm_sat_scarab_boss_fight::function_4159ae70c5443240();
        }
    }
    
    function_ace294ce606de3c3( self );
    var_9cfa864c3f84043f = self getentitynumber();
    var_9cfa864c3f84043f = int( clamp( var_9cfa864c3f84043f, 0, 3 ) );
    var_ed100f9a07836d02 = level.oubliette_data.var_d291d25e304704c2[ var_9cfa864c3f84043f ];
    
    while ( !self isonground() || self.b_teleport_back )
    {
        wait 1;
    }
    
    namespace_8a6b6b859e6fcad::function_530dd8c997a5c843();
    val::set( "enter_oubliette", "ignore_afk", 1 );
    self dontinterpolate();
    self setorigin( var_ed100f9a07836d02.origin );
    self setvelocity( ( 0, 0, 0 ) );
    self setplayerangles( var_ed100f9a07836d02.angles ?? ( 0, 0, 0 ) );
    val::set( "oubliette", "allow_last_stand", 1 );
    self notify( #"afk_tracking_resume" );
    utility::delaythreadendon( level.framedurationseconds, "disconnect", &val::reset_all, "enter_oubliette" );
    self.var_9bb0769ec1a667af = self.var_7ab4c9acb317c405;
    self.var_7ab4c9acb317c405 = var_ed100f9a07836d02.origin;
    self.var_107a85bc107517bf = 1;
    self.b_disable_nowhere_but_there = 1;
    armor::setarmorhealth( self.maxarmorhealth, 1 );
    self.health = self.maxhealth;
    thread function_61fff507ea9b02bd( var_cba1f4ce367d5887 );
    namespace_8a6b6b859e6fcad::function_c8b5c790334752c6( 0 );
    callback::callback( #"oubliette_enter", { #info:self.oubliette, #source:var_cba1f4ce367d5887 } );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0xac4eaa5, Offset: 0x1def
// Size: 0x1f5
function private function_61fff507ea9b02bd( var_cba1f4ce367d5887 )
{
    self endon( #"disconnect" );
    self endon( #"oubliette_interrupt" );
    level endon( #"game_ended" );
    
    foreach ( s_test_challenge in level.oubliette_data.var_a853ab2d0e15fc18 )
    {
        if ( s_test_challenge.str_name == var_cba1f4ce367d5887 )
        {
            var_5dc3a271f3cb3d31 = s_test_challenge;
            self.oubliette.var_8cff5e93e7f5e8 = var_5dc3a271f3cb3d31;
            break;
        }
    }
    
    if ( !isdefined( var_5dc3a271f3cb3d31 ) )
    {
        var_5dc3a271f3cb3d31 = utility::array_random( level.oubliette_data.var_a853ab2d0e15fc18 );
        self.oubliette.var_8cff5e93e7f5e8 = var_5dc3a271f3cb3d31;
    }
    
    self [[ var_5dc3a271f3cb3d31.var_351e697cf49327bf ]]();
    thread oubliette_laststand_watcher();
    n_result = -1;
    
    while ( n_result == -1 )
    {
        if ( isdefined( self.oubliette.var_72ba001ece8ea7be ) )
        {
            n_result = self.oubliette.var_72ba001ece8ea7be;
            self.oubliette.var_72ba001ece8ea7be = undefined;
            break;
        }
        
        if ( !isalive( level.s_scarab_boss.entity ) )
        {
            n_result = 1;
            break;
        }
        
        n_result = self [[ var_5dc3a271f3cb3d31.func_update ]]();
        
        if ( n_result != -1 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    self [[ var_5dc3a271f3cb3d31.func_terminate ]]();
    self.oubliette.var_8cff5e93e7f5e8 = undefined;
    exit_oubliette( n_result );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x81fc1ccb, Offset: 0x1fec
// Size: 0x296
function private exit_oubliette( n_result )
{
    if ( isalive( level.s_scarab_boss.entity ) )
    {
        if ( level.s_scarab_boss.entity getaiblackboarddynamic( "force_disable_agressive" ) )
        {
            level.s_scarab_boss.entity function_786bb6aa1b76c7ee( "force_disable_agressive", 0 );
        }
        
        if ( n_result == 1 )
        {
            function_702ee78080b3ee91( self );
        }
        else
        {
            function_e534ce66966ac6ca( self );
        }
    }
    
    a_return_positions = utility::getstructarray( "boss_arena_start_pos", "script_noteworthy" );
    var_9cfa864c3f84043f = self getentitynumber();
    var_9cfa864c3f84043f = int( clamp( var_9cfa864c3f84043f, 0, a_return_positions.size - 1 ) );
    var_3bfd1ad32ac1f2be = a_return_positions[ var_9cfa864c3f84043f ];
    thread function_32b994712a390e5b();
    namespace_8a6b6b859e6fcad::function_530dd8c997a5c843();
    val::set( "exit_oubliette", "ignore_afk", 1 );
    self dontinterpolate();
    self setorigin( var_3bfd1ad32ac1f2be.origin );
    self setplayerangles( var_3bfd1ad32ac1f2be.angles ?? ( 0, 0, 0 ) );
    self notify( #"afk_tracking_resume" );
    utility::delaythreadendon( level.framedurationseconds, "disconnect", &val::reset_all, "exit_oubliette" );
    self.var_5f5d52d87735294f = gettime();
    val::set( "oubliette", "damage", 0 );
    val::set( "oubliette", "ignoreme", 1 );
    utility::delaythread( 3, &val::reset_all, "oubliette" );
    self.var_59cd809a932c6ee1 = undefined;
    self.var_7ab4c9acb317c405 = self.var_9bb0769ec1a667af;
    self.var_9bb0769ec1a667af = undefined;
    self.var_107a85bc107517bf = undefined;
    self.b_disable_nowhere_but_there = undefined;
    self.var_287f29fa987acd1c = 0;
    
    if ( isdefined( self.oubliette.var_c6321cb8cd32b6a0 ) && isdefined( self.oubliette.var_c6321cb8cd32b6a0.h_splash ) )
    {
        thread function_ae1626e015ddeaeb( self.oubliette.var_c6321cb8cd32b6a0.h_splash );
    }
    
    self.oubliette.var_c858d5cbff6ce7a = 0;
    utility::flag_clear( "scarab_pause_boss_adds" );
    namespace_8a6b6b859e6fcad::function_c8b5c790334752c6( 0 );
    utility::flag_set( "scarab_powerup_hornet_activate" );
    callback::callback( #"oubliette_exit", { #info:self.oubliette, #result:n_result } );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x50954b25, Offset: 0x228a
// Size: 0x45
function private function_32b994712a390e5b()
{
    var_8c4fe62d01999d1e = zone_manager::get_current_zone();
    str_zone_name = zone_manager::function_2bcd755aabfd3cad( var_8c4fe62d01999d1e );
    
    if ( !isdefined( str_zone_name ) )
    {
        return;
    }
    
    zm_quest::function_2850bf8c7015dc92( [ str_zone_name ] );
    function_60f7f7aad5e59f2( str_zone_name );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x78705255, Offset: 0x22d7
// Size: 0xf5
function private function_60f7f7aad5e59f2( str_zone_name )
{
    root = powerups::get_powerups_root();
    active_powerups = root.active_powerups;
    
    if ( !isarray( active_powerups ) || active_powerups.size <= 0 )
    {
        return;
    }
    
    foreach ( powerup in active_powerups )
    {
        if ( !isdefined( powerup ) )
        {
            continue;
        }
        
        current_zone = zone_manager::function_90e5c3e2272b0130( powerup.origin );
        current_zone_name = zone_manager::function_2bcd755aabfd3cad( current_zone );
        
        if ( current_zone_name == str_zone_name )
        {
            powerup powerups::powerup_delete();
        }
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 2, eflags: 0x4
// Checksum 0x3e6af64a, Offset: 0x23d4
// Size: 0x21c
function private punish_arena_camper( v_origin, v_angles )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !player::isreallyalive( self ) || is_in_oubliette( self ) || !isalive( level.s_scarab_boss.entity ) )
    {
        return;
    }
    
    function_f9a5a612ceeadecc( self );
    
    if ( !isdefined( v_origin ) )
    {
        a_return_positions = utility::getstructarray( "boss_arena_start_pos", "script_noteworthy" );
        var_9cfa864c3f84043f = int( clamp( self getentitynumber(), 0, a_return_positions.size - 1 ) );
        v_origin = a_return_positions[ var_9cfa864c3f84043f ].origin;
        v_angles = a_return_positions[ var_9cfa864c3f84043f ].angles;
    }
    
    namespace_c23a90831c0cb043::function_530dd8c997a5c843();
    val::set( "arena_camper", "ignore_afk", 1 );
    self dontinterpolate();
    self setorigin( v_origin );
    self setvelocity( ( 0, 0, 0 ) );
    self setplayerangles( v_angles ?? ( 0, 0, 0 ) );
    self notify( #"afk_tracking_resume" );
    utility::delaythreadendon( level.framedurationseconds, "disconnect", &val::reset_all, "arena_camper" );
    val::set( "arena_camper_grace", "damage", 0 );
    utility::delaythread( 0.5, &val::reset_all, "arena_camper_grace" );
    namespace_c23a90831c0cb043::function_c8b5c790334752c6( 0 );
    namespace_c23a90831c0cb043::function_4073c42f3bfa3cde();
    
    if ( !self.oubliette.var_a722c20b12b28da1 )
    {
        self.oubliette.var_a722c20b12b28da1 = 1;
        return;
    }
    
    function_ace294ce606de3c3( self );
    s_curse = function_e534ce66966ac6ca( self, 300 );
    thread function_752f138ca49b1e7f( 300 );
    
    if ( s_curse.str_name != "scarab_oubliette_curse_speed" )
    {
        effect_slow::slow( "scarab_arena_camper", 0.6, 300, self );
    }
    
    if ( isdefined( s_curse.h_splash ) )
    {
        thread function_ae1626e015ddeaeb( s_curse.h_splash );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x9153d13b, Offset: 0x25f8
// Size: 0x90
function private function_752f138ca49b1e7f( var_dc58879cfee40e71 )
{
    self endon( #"disconnect" );
    self notify( #"hash_b89a0d42587a7c1f" );
    self endon( #"hash_b89a0d42587a7c1f" );
    
    if ( level.s_scarab_boss.var_82f672a606ce635a )
    {
        self.var_3ac767a01ac0d8d9 = 1;
        pbgpostfxbundlestart( self, level.s_scarab_boss.var_82f672a606ce635a );
        wait var_dc58879cfee40e71;
        self.var_3ac767a01ac0d8d9 = undefined;
        pbgpostfxbundleend( self, level.s_scarab_boss.var_82f672a606ce635a );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x656ad350, Offset: 0x2690
// Size: 0xba
function private oubliette_laststand_watcher()
{
    self endon( #"disconnect" );
    self endon( #"hash_2879a3f83320ea08" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( player::isinlaststand( self ) || !isalive( self ) || self.var_e48757aaac52d7cd )
        {
            val::set( "oubliette", "damage", 0 );
            val::set( "oubliette", "ignoreme", 1 );
            
            if ( self.var_e48757aaac52d7cd || player::isinlaststand( self ) )
            {
                self.var_e48757aaac52d7cd = undefined;
                wait 1;
            }
            
            zm_utility::force_revive_player( undefined, undefined, 1 );
            self.oubliette.var_72ba001ece8ea7be = 0;
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 5, eflags: 0x4
// Checksum 0x4b77e130, Offset: 0x2752
// Size: 0x687
function private function_8fa98c8bf19693ce( var_ff75798b22968d50, var_e85deb27cfc36545, var_12989404acb9b706 = 0, n_spawn_interval, var_99e434932033b434 )
{
    self endon( #"disconnect" );
    self endon( #"hash_2879a3f83320ea08" );
    level endon( #"game_ended" );
    
    switch ( level.players.size )
    {
        case 1:
            if ( !isdefined( var_e85deb27cfc36545 ) )
            {
                var_e85deb27cfc36545 = 10;
            }
            
            break;
        case 2:
            if ( !isdefined( var_e85deb27cfc36545 ) )
            {
                var_e85deb27cfc36545 = 10;
            }
            
            break;
        case 3:
            if ( !isdefined( var_e85deb27cfc36545 ) )
            {
                var_e85deb27cfc36545 = 10;
            }
            
            break;
        case 4:
        default:
            if ( !isdefined( var_e85deb27cfc36545 ) )
            {
                var_e85deb27cfc36545 = 10;
            }
            
            break;
    }
    
    self.oubliette.a_spawned_zombies = [];
    
    while ( true )
    {
        self.oubliette.a_spawned_zombies = function_46f9072493651dc9( self.oubliette.a_spawned_zombies );
        
        if ( self.oubliette.a_spawned_zombies.size < var_e85deb27cfc36545 )
        {
            if ( isarray( var_ff75798b22968d50 ) )
            {
                if ( isdefined( var_99e434932033b434 ) && var_99e434932033b434.size == var_ff75798b22968d50.size )
                {
                    str_aitype_to_spawn = utility::choose_from_weighted_array( var_ff75798b22968d50, var_99e434932033b434 );
                }
                else
                {
                    str_aitype_to_spawn = utility::array_random( var_ff75798b22968d50 );
                }
            }
            else
            {
                str_aitype_to_spawn = var_ff75798b22968d50;
            }
            
            all_ai = getaiarray( zm_utility::get_zombie_team() );
            var_4f3f0b489691a6ab = [];
            var_8a56d32fd2162392 = [];
            
            foreach ( ai in all_ai )
            {
                if ( isalive( ai ) )
                {
                    if ( ai.var_a1332abcb3616a61 )
                    {
                        var_8a56d32fd2162392[ var_8a56d32fd2162392.size ] = ai;
                        ai val::reset( "boss_zombie", "ignore_cleanup" );
                        continue;
                    }
                    
                    var_4f3f0b489691a6ab[ var_4f3f0b489691a6ab.size ] = ai;
                }
            }
            
            str_aitype_to_spawn = function_b3988325430ce242( str_aitype_to_spawn ) ?? str_aitype_to_spawn;
            
            if ( all_ai.size >= getmaxaicount() - 2 )
            {
                b_recycled = zm_utility::function_71d7c0e7375ef487( 2, [ "normal" ], var_4f3f0b489691a6ab );
                
                if ( b_recycled )
                {
                    logstring( "====Oubliette AI Spawn Recycled Zombie to free up space for " + self.name );
                }
            }
            
            foreach ( boss_arena_add in var_8a56d32fd2162392 )
            {
                if ( isalive( boss_arena_add ) )
                {
                    boss_arena_add val::set( "boss_zombie", "ignore_cleanup", 1 );
                }
            }
            
            zombie = zone_spawner::function_c5801414561a5dab( str_aitype_to_spawn, self );
            
            if ( isdefined( zombie ) )
            {
                zombie thread delay_idle_eyes();
                zm_sat_scarab_boss_fight::function_556416a189f1c98d( zombie );
                zombie val::set( "oubliette", "ignore_cleanup", 1 );
                zombie zombie_utils::set_ai_target_priority( self, "oubliette", 100 );
                zombie.oubliette = self.oubliette;
                zombie.b_cleanup_no_respawn = 1;
                zombie.var_15598d8e493afe88 = 1;
                zombie.ignore_enemy_count = 1;
                zombie.var_825b17c932865df = 1;
                zombie callback::add( "on_zombie_ai_killed", &function_f56ed3e17d8ad393 );
                zombie thread function_95ce3a01fb4c216( self );
                
                if ( zombie.subclass == "zombie_base" && utility::percent_chance( var_12989404acb9b706 ) )
                {
                    zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "super_sprint" == "super_sprint" || "super_sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "super_sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "super_sprint" == "sprint" ? "run" : "super_sprint", "scarab_boss", 6 );
                }
                
                self.oubliette.a_spawned_zombies[ self.oubliette.a_spawned_zombies.size ] = zombie;
            }
            else
            {
                all_ai = getaiarray();
                var_ea097e344c98d33b = [];
                logstring( "====Oubliette AI Spawn Fail Start for " + self.name );
                logstring( "Existing AI Count: " + getaiarray().size + " out of " + getmaxaicount() );
                
                foreach ( ai in all_ai )
                {
                    logstring( "Existing AI: " + ai.subclass + " at " + ai.origin );
                    
                    if ( !isdefined( var_ea097e344c98d33b[ ai.subclass ] ) )
                    {
                        var_ea097e344c98d33b[ ai.subclass ] = [];
                    }
                    
                    var_ea097e344c98d33b[ ai.subclass ][ var_ea097e344c98d33b[ ai.subclass ].size ] = ai;
                }
                
                foreach ( subclass, var_73a56df61d877b3b in var_ea097e344c98d33b )
                {
                    logstring( "AI by subclass: " + subclass + " count: " + var_73a56df61d877b3b.size );
                }
                
                logstring( "====Oubliette AI Spawn Fail End for" + self.name );
            }
        }
        
        wait n_spawn_interval;
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x8a3b85e6, Offset: 0x2de1
// Size: 0x5c
function private function_95ce3a01fb4c216( player )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    player waittill( #"disconnect" );
    self.death_source = "oubliette_owner_disconnect";
    self.forceannihilate = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self kill();
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x2252313e, Offset: 0x2e45
// Size: 0x5c
function private function_f56ed3e17d8ad393( params )
{
    if ( isdefined( self.oubliette ) && isdefined( self.oubliette.a_spawned_zombies ) )
    {
        self.oubliette.a_spawned_zombies = arrayremove( self.oubliette.a_spawned_zombies, self );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x8591719a, Offset: 0x2ea9
// Size: 0xe8
function private function_6d396e55ed2b2ccc()
{
    if ( !isdefined( self.oubliette.a_spawned_zombies ) )
    {
        return;
    }
    
    foreach ( zombie in self.oubliette.a_spawned_zombies )
    {
        if ( isalive( zombie ) )
        {
            zombie.death_source = "oubliette_cleanup";
            zombie.forceannihilate = 1;
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie kill();
            waitframe();
        }
    }
    
    self.oubliette.a_spawned_zombies = [];
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x240382d3, Offset: 0x2f99
// Size: 0xd3
function private function_26df201e9e223c61()
{
    self.oubliette.var_5c205e7f5afb7a7f = gettime();
    function_54cddad5c49cb22c();
    n_spawn_interval = getdvarfloat( @"hash_ddb8bb68352372c1", 0.2 );
    var_afd0d0fd7ed91e78 = getdvarint( @"hash_2a650af6b78345ed", 30 ) * 1000;
    function_390718a4de9b30dc( var_afd0d0fd7ed91e78 );
    thread function_8fa98c8bf19693ce( [ "zombie_base_armored_agni", "zombie_base_luna", "zombie_loom_minion", "zombie_base" ], undefined, 20, n_spawn_interval, [ 10, 20, 60, 100 ] );
    thread function_ae1626e015ddeaeb( self.oubliette.var_8cff5e93e7f5e8.h_splash );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x7c8d90db, Offset: 0x3074
// Size: 0x6b
function private function_83142b59ded48aa6()
{
    var_afd0d0fd7ed91e78 = getdvarint( @"hash_2a650af6b78345ed", 30 ) * 1000;
    n_elapsed = gettime() - self.oubliette.var_5c205e7f5afb7a7f;
    var_77be3669189a4fe3 = max( var_afd0d0fd7ed91e78 - n_elapsed, 0 );
    function_390718a4de9b30dc( var_77be3669189a4fe3 );
    
    if ( n_elapsed >= var_afd0d0fd7ed91e78 )
    {
        return 1;
    }
    
    return -1;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xb1903946, Offset: 0x30e8
// Size: 0x1f
function private function_355e20d92206e412()
{
    self notify( #"hash_2879a3f83320ea08" );
    function_6d396e55ed2b2ccc();
    function_1bd5409518b9a375();
    wait 2;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x82684da1, Offset: 0x310f
// Size: 0x537
function private function_c5e2a753d2ddd812()
{
    self.oubliette.var_5c205e7f5afb7a7f = gettime();
    function_f813035006462c22();
    n_roll = randomfloat( 100 );
    var_366b51da2f3324c8 = 60;
    var_6dd7c0d116ae598 = var_366b51da2f3324c8 - 30;
    var_935aa52f588d8652 = var_6dd7c0d116ae598 - 30;
    
    if ( n_roll >= var_366b51da2f3324c8 )
    {
        str_ai_subclass = "zombie_loom_hvt";
    }
    else if ( n_roll >= var_6dd7c0d116ae598 )
    {
        str_ai_subclass = "zombie_orion_hvt";
        var_5804d44802852902 = #"hash_fc55da459092b7ea";
    }
    else if ( n_roll >= var_935aa52f588d8652 )
    {
        str_ai_subclass = "zombie_karkinos_hvt";
        var_5804d44802852902 = #"hash_63e5611ec6645edb";
    }
    else
    {
        str_ai_subclass = "zombie_loom_hvt";
    }
    
    str_ai_subclass = getdvar( @"hash_2a3782d2c61b1a84", str_ai_subclass );
    var_ff75798b22968d50 = function_b3988325430ce242( str_ai_subclass ) ?? str_ai_subclass;
    self.oubliette.challenge_zombie = zone_spawner::function_c5801414561a5dab( var_ff75798b22968d50, self );
    
    while ( !self.oubliette.challenge_zombie )
    {
        zombies = arrayrandomize( getaiarray( "team_two_hundred" ) );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) || issubstr( zombie.subclass, "zombie_weyward" ) || issubstr( zombie.subclass, "zombie_wither" ) )
            {
                continue;
            }
            
            zombie.nocorpse = 1;
            zombie kill();
            waitframe();
            waitframe();
            break;
        }
        
        self.oubliette.challenge_zombie = zone_spawner::function_c5801414561a5dab( var_ff75798b22968d50, self );
        
        if ( self.oubliette.challenge_zombie )
        {
            break;
        }
        
        waitframe();
    }
    
    self.oubliette.challenge_zombie thread delay_idle_eyes();
    self.oubliette.challenge_zombie zombie_utils::set_ai_target_priority( self, "oubliette", 100 );
    zm_sat_scarab_boss_fight::function_556416a189f1c98d( self.oubliette.challenge_zombie );
    self.oubliette.challenge_zombie val::set( "oubliette", "ignore_cleanup", 1 );
    self.oubliette.challenge_zombie.b_cleanup_no_respawn = 1;
    self.oubliette.challenge_zombie.var_15598d8e493afe88 = 1;
    self.oubliette.challenge_zombie.ignore_enemy_count = 1;
    self.oubliette.challenge_zombie.var_825b17c932865df = 1;
    self.oubliette.challenge_zombie.var_813b86c0b6e0d26a = 99999;
    self.oubliette.challenge_zombie.var_32bc9f9fe42b8b86 = 450;
    self.oubliette.challenge_zombie thread function_95ce3a01fb4c216( self );
    
    switch ( str_ai_subclass )
    {
        case #"hash_fb41746939185dd8":
            n_spawn_interval = getdvarfloat( @"hash_d1e75f7808e79035", 0.3 );
            var_1b1e063b9b82d31a = [ "zombie_base", "zombie_loom_minion" ];
            var_640548fc3884c342 = [ 30, 90 ];
            break;
        case #"hash_f2f31c7e7da46e68":
            n_spawn_interval = getdvarfloat( @"hash_d1e75f7808e79035", 2 );
            var_1b1e063b9b82d31a = [ "zombie_base_armored_agni", "zombie_base", "zombie_loom_minion" ];
            var_640548fc3884c342 = [ 30, 40, 70 ];
            break;
        case #"hash_2465d832b8e3dc23":
            n_spawn_interval = getdvarfloat( @"hash_d1e75f7808e79035", 1.25 );
            var_1b1e063b9b82d31a = [ "zombie_base_luna", "zombie_base", "zombie_loom_minion" ];
            var_640548fc3884c342 = [ 30, 40, 80 ];
            break;
        default:
            n_spawn_interval = getdvarfloat( @"hash_d1e75f7808e79035", undefined );
            var_1b1e063b9b82d31a = [ "zombie_base" ];
            var_640548fc3884c342 = [ 100 ];
            break;
    }
    
    assert( isdefined( n_spawn_interval ), "<dev string:x24>" );
    
    if ( !isdefined( n_spawn_interval ) )
    {
        n_spawn_interval = getdvarfloat( @"hash_d1e75f7808e79035", 1.5 );
    }
    
    function_a7bd34f62dcc8212( 60000 );
    thread function_8fa98c8bf19693ce( var_1b1e063b9b82d31a, undefined, 10, n_spawn_interval, var_640548fc3884c342 );
    thread function_ae1626e015ddeaeb( var_5804d44802852902 ?? self.oubliette.var_8cff5e93e7f5e8.h_splash );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x2366ef20, Offset: 0x364e
// Size: 0xfb
function private delay_idle_eyes()
{
    self endon( #"death" );
    self.var_a8fa61d92872fc74 = 1;
    utility::callsharedfunc( #"bgb", #"hash_f48f602e45cbde7f", 0 );
    
    while ( self.b_in_spawn_closet )
    {
        waitframe();
    }
    
    self.var_a8fa61d92872fc74 = undefined;
    
    foreach ( player in level.players )
    {
        if ( player utility::callsharedfunc( #"bgb", #"is_enabled", "idle_eyes" ) )
        {
            utility::callsharedfunc( #"bgb", #"hash_f48f602e45cbde7f", 1 );
            return;
        }
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x7abe92b7, Offset: 0x3751
// Size: 0x78
function private function_526b5324515e1c11()
{
    if ( !isalive( self.oubliette.challenge_zombie ) )
    {
        return 1;
    }
    
    n_elapsed = gettime() - self.oubliette.var_5c205e7f5afb7a7f;
    var_75dd66b572d950b4 = 60000;
    var_77be3669189a4fe3 = max( var_75dd66b572d950b4 - n_elapsed, 0 );
    function_a7bd34f62dcc8212( var_77be3669189a4fe3 );
    
    if ( n_elapsed >= var_75dd66b572d950b4 )
    {
        return 0;
    }
    
    return -1;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x7f8819b5, Offset: 0x37d2
// Size: 0x87
function private function_2699591f0c44868f()
{
    if ( isalive( self.oubliette.challenge_zombie ) )
    {
        self.oubliette.challenge_zombie.death_source = "oubliette_challenge_kill_terminate";
        self.oubliette.challenge_zombie kill();
    }
    
    self.oubliette.challenge_zombie = undefined;
    self notify( #"hash_2879a3f83320ea08" );
    function_6d396e55ed2b2ccc();
    function_6ce2e120e0325d79();
    wait 2;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0xbd948aa9, Offset: 0x3861
// Size: 0x72
function private function_702ee78080b3ee91( player )
{
    s_blessing = utility::array_random( level.oubliette_data.var_34f28bf03c7a3a44 );
    player.oubliette.var_c6321cb8cd32b6a0 = s_blessing;
    player [[ s_blessing.var_351e697cf49327bf ]]();
    
    if ( isdefined( s_blessing.var_dc58879cfee40e71 ) )
    {
        thread timed_blessing( s_blessing, player );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 2, eflags: 0x4
// Checksum 0xf8c5c7a4, Offset: 0x38db
// Size: 0x51
function private timed_blessing( s_blessing, player )
{
    player endon( #"disconnect" );
    player namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( s_blessing.str_name, s_blessing.var_dc58879cfee40e71 );
    player [[ s_blessing.func_terminate ]]();
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 2, eflags: 0x4
// Checksum 0xbbdd302f, Offset: 0x3934
// Size: 0xf1
function private function_e534ce66966ac6ca( player, n_duration_override )
{
    s_curse = utility::array_random( level.oubliette_data.a_curses );
    
    if ( isdefined( n_duration_override ) && isdefined( s_curse.var_dc58879cfee40e71 ) )
    {
        s_curse = { #var_dc58879cfee40e71:n_duration_override, #h_splash:s_curse.h_splash, #func_terminate:s_curse.func_terminate, #var_351e697cf49327bf:s_curse.var_351e697cf49327bf, #str_name:s_curse.str_name };
    }
    
    player.oubliette.var_c6321cb8cd32b6a0 = s_curse;
    player [[ s_curse.var_351e697cf49327bf ]]();
    
    if ( isdefined( s_curse.var_dc58879cfee40e71 ) )
    {
        thread timed_curse( s_curse, player );
    }
    
    return s_curse;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 2, eflags: 0x4
// Checksum 0xccb11c24, Offset: 0x3a2e
// Size: 0x51
function private timed_curse( s_curse, player )
{
    player endon( #"disconnect" );
    player namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( s_curse.str_name, s_curse.var_dc58879cfee40e71 );
    player [[ s_curse.func_terminate ]]();
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 1, eflags: 0x4
// Checksum 0x10a11416, Offset: 0x3a87
// Size: 0x148
function private function_ace294ce606de3c3( player )
{
    player effect_slow::function_80a4bd13b5ba303a( "scarab_arena_camper" );
    
    if ( player.var_3ac767a01ac0d8d9 )
    {
        player.var_3ac767a01ac0d8d9 = undefined;
        player notify( #"hash_b89a0d42587a7c1f" );
        
        if ( level.s_scarab_boss.var_82f672a606ce635a )
        {
            pbgpostfxbundleend( player, level.s_scarab_boss.var_82f672a606ce635a );
        }
    }
    
    if ( !isdefined( player.oubliette ) || !isdefined( player.oubliette.var_c6321cb8cd32b6a0 ) )
    {
        return;
    }
    
    if ( isdefined( player.oubliette.var_c6321cb8cd32b6a0.str_name ) && isdefined( player.oubliette.var_c6321cb8cd32b6a0.var_dc58879cfee40e71 ) )
    {
        player notify( "powerup_hud_hide_" + player.oubliette.var_c6321cb8cd32b6a0.str_name );
        waitframe();
    }
    else
    {
        player [[ player.oubliette.var_c6321cb8cd32b6a0.func_terminate ]]();
    }
    
    player.oubliette.var_c6321cb8cd32b6a0 = undefined;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0
// Checksum 0x3cc281a, Offset: 0x3bd7
// Size: 0x84
function function_cafca44fae4c76a1()
{
    foreach ( player in level.players )
    {
        function_f9a5a612ceeadecc( player );
        function_ace294ce606de3c3( player );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0
// Checksum 0x2d23f231, Offset: 0x3c63
// Size: 0xa9
function function_cf9450abdedd12bf()
{
    foreach ( player in level.players )
    {
        function_f9a5a612ceeadecc( player );
        player.oubliette.var_aa37e26da3c29ca6 = 0;
        player.oubliette.var_a722c20b12b28da1 = 0;
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xdbff2439, Offset: 0x3d14
// Size: 0x8b
function private function_d1ee9ee24c22c226()
{
    var_ff4cba42b2c91499 = getdvarfloat( @"hash_fbc219a9f145a05d", 0.33 );
    self.blessing_health_increase = int( self.maxhealth * var_ff4cba42b2c91499 );
    self.maxhealth += self.blessing_health_increase;
    self.health = self.maxhealth;
    self.laststandrevivehealth = self.maxhealth;
    self.var_b541f8c69a34639d = self.maxhealth;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xdc57d03d, Offset: 0x3da7
// Size: 0xbd
function private function_459da5b38dc5f89b()
{
    if ( isdefined( self.blessing_health_increase ) )
    {
        self.maxhealth -= self.blessing_health_increase;
        
        if ( self.maxhealth < level.laststandrevivehealth )
        {
            self.maxhealth = level.laststandrevivehealth;
        }
    }
    
    if ( self.maxhealth < 1 )
    {
        self.maxhealth = 1;
    }
    
    if ( self.health > self.maxhealth )
    {
        self.health = self.maxhealth;
    }
    
    self.blessing_health_increase = undefined;
    self.laststandrevivehealth = undefined;
    self.var_b541f8c69a34639d = undefined;
    playerhealth::forcehealthregen( self, 1 );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x8be69966, Offset: 0x3e6c
// Size: 0x52
function private function_dce32ebc56e3f5c7()
{
    speed_multiplier_increase = getdvarfloat( @"scr_oubliette_blessing_speed", 1.2 );
    weapons::addextramovespeed( "oubliette_blessing_speed", speed_multiplier_increase );
    
    if ( !common::function_8ff835bf23198a0( "oubliette_blessing_speed" ) )
    {
        common::function_ac4bf3256b2545e3( "oubliette_blessing_speed", speed_multiplier_increase );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x90eba139, Offset: 0x3ec6
// Size: 0x2f
function private function_f2591c174066c4e0()
{
    weapons::removeextramovespeed( "oubliette_blessing_speed" );
    
    if ( common::function_8ff835bf23198a0( "oubliette_blessing_speed" ) )
    {
        common::function_d85a92c557ea5a52( "oubliette_blessing_speed" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xf25a4084, Offset: 0x3efd
// Size: 0x42
function private function_49096dfb984ca9b7()
{
    n_overheal = getdvarint( @"hash_99c0b16635c97eaf", 100 );
    utility::callsharedfunc( #"health", #"hash_291dc25cfb86af01", self, #"scarab_oubliette", n_overheal );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x426d290, Offset: 0x3f47
// Size: 0x2
function private function_36382a5076ddebf0()
{
    
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x7b8c2f07, Offset: 0x3f51
// Size: 0x98
function private function_ae27637004d7e215()
{
    var_679667f78224332d = getdvarint( @"hash_ce362db9912b4416", 75 );
    self.maxhealth -= var_679667f78224332d;
    
    if ( self.maxhealth < 1 )
    {
        self.maxhealth = 1;
    }
    
    if ( self.health > self.maxhealth )
    {
        self.health = self.maxhealth;
    }
    
    self.laststandrevivehealth = self.maxhealth;
    self.var_b541f8c69a34639d = self.maxhealth;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x77b29878, Offset: 0x3ff1
// Size: 0x6f
function private function_2b1f7ed98d93d98e()
{
    if ( player::isinlaststand( self ) )
    {
        self.defaultmaxhealth = undefined;
    }
    else
    {
        var_679667f78224332d = getdvarint( @"hash_ce362db9912b4416", 75 );
        self.maxhealth += var_679667f78224332d;
        self.health = self.maxhealth;
    }
    
    self.laststandrevivehealth = undefined;
    self.var_b541f8c69a34639d = undefined;
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x7325dd06, Offset: 0x4068
// Size: 0x6d
function private function_cdc1335301296a7e()
{
    n_scale = getdvarfloat( @"hash_49e8ca59835e7ffb", 0.7 );
    
    if ( isdefined( self.oubliette.var_c6321cb8cd32b6a0.var_dc58879cfee40e71 ) )
    {
        effect_slow::slow( "scarab_oubliette", n_scale, self.oubliette.var_c6321cb8cd32b6a0.var_dc58879cfee40e71, self );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xe27942a6, Offset: 0x40dd
// Size: 0xe
function private function_9512d459db2b6863()
{
    effect_slow::function_80a4bd13b5ba303a( "scarab_oubliette" );
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0xddf5b3e5, Offset: 0x40f3
// Size: 0x47
function private function_92e9713d091ce2b1()
{
    if ( isdefined( self.oubliette.var_c6321cb8cd32b6a0.var_dc58879cfee40e71 ) )
    {
        thread zm_remove_ammo::drain_ammo( self.oubliette.var_c6321cb8cd32b6a0.var_dc58879cfee40e71 );
    }
}

// Namespace zm_sat_scarab_boss_fight_oubliette
// Params 0, eflags: 0x4
// Checksum 0x9060f316, Offset: 0x4142
// Size: 0x9
function private function_14443193d4a5bc02()
{
    thread zm_remove_ammo::function_f7994094f16988c2();
}

/#

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x584706d2, Offset: 0x4153
    // Size: 0x25, Type: dev
    function private init_debug()
    {
        oubliette_devgui();
        
        if ( getdvarint( @"scr_oubliette_debug", 0 ) )
        {
            level thread debug_draw_loop();
        }
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x1af85c20, Offset: 0x4180
    // Size: 0xf4, Type: dev
    function private oubliette_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x67>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8f>", "<dev string:xb3>", &function_da77fc567c178c49 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd2>", "<dev string:xfa>", &function_da77fc567c178c49 );
        devgui::add_devgui_func( "<dev string:x11d>", "<dev string:x13b>", &function_555e70d3a28c28d7 );
        devgui::add_devgui_func( "<dev string:x14f>", "<dev string:x167>", &function_c5c01f77c6ee5f5f );
        devgui::add_devgui_func( "<dev string:x17f>", "<dev string:x197>", &function_8200c9aa32c601fe );
        devgui::add_devgui_func( "<dev string:x1af>", "<dev string:x1c4>", &function_ae88b11d8a89138d );
        devgui::add_devgui_func( "<dev string:x1dc>", "<dev string:x1ee>", &function_a5c69260e397c75e );
        devgui::add_devgui_func( "<dev string:x203>", "<dev string:x216>", &debug_remove_effects );
        devgui::add_devgui_func( "<dev string:x22f>", "<dev string:x246>", &function_89147b208412a2b5 );
        devgui::add_devgui_func( "<dev string:x25f>", "<dev string:x271>", &function_aef6258bd4d2788d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 1, eflags: 0x4
    // Checksum 0x45ded8c6, Offset: 0x427c
    // Size: 0x64, Type: dev
    function private function_da77fc567c178c49( params )
    {
        player = level.players[ 0 ];
        str_challenge_type = params[ 0 ] ?? "<dev string:x288>";
        function_f9a5a612ceeadecc( player );
        
        if ( is_in_oubliette( player ) )
        {
            iprintlnbold( "<dev string:x28e>" );
            return;
        }
        
        player thread enter_oubliette( str_challenge_type );
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x1f8ce24c, Offset: 0x42e8
    // Size: 0x16, Type: dev
    function private function_555e70d3a28c28d7()
    {
        level callback::callback( #"hash_b22f26734fcf223c" );
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x4f97ce6f, Offset: 0x4306
    // Size: 0x4b, Type: dev
    function private function_c5c01f77c6ee5f5f()
    {
        player = level.players[ 0 ];
        
        if ( !is_in_oubliette( player ) )
        {
            iprintlnbold( "<dev string:x2ad>" );
            return;
        }
        
        player.oubliette.var_72ba001ece8ea7be = 1;
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x10c121d, Offset: 0x4359
    // Size: 0x4a, Type: dev
    function private function_8200c9aa32c601fe()
    {
        player = level.players[ 0 ];
        
        if ( !is_in_oubliette( player ) )
        {
            iprintlnbold( "<dev string:x2ad>" );
            return;
        }
        
        player.oubliette.var_72ba001ece8ea7be = 0;
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x15570c8, Offset: 0x43ab
    // Size: 0x78, Type: dev
    function private function_ae88b11d8a89138d()
    {
        player = level.players[ 0 ];
        function_f9a5a612ceeadecc( player );
        function_ace294ce606de3c3( player );
        function_702ee78080b3ee91( player );
        
        if ( isdefined( player.oubliette.var_c6321cb8cd32b6a0 ) )
        {
            player thread function_ae1626e015ddeaeb( player.oubliette.var_c6321cb8cd32b6a0.h_splash );
        }
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x48bb08ed, Offset: 0x442b
    // Size: 0x78, Type: dev
    function private function_a5c69260e397c75e()
    {
        player = level.players[ 0 ];
        function_f9a5a612ceeadecc( player );
        function_ace294ce606de3c3( player );
        function_e534ce66966ac6ca( player );
        
        if ( isdefined( player.oubliette.var_c6321cb8cd32b6a0 ) )
        {
            player thread function_ae1626e015ddeaeb( player.oubliette.var_c6321cb8cd32b6a0.h_splash );
        }
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x1423549f, Offset: 0x44ab
    // Size: 0x16, Type: dev
    function private debug_remove_effects()
    {
        function_cafca44fae4c76a1();
        iprintlnbold( "<dev string:x2c8>" );
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x9fcbd5d0, Offset: 0x44c9
    // Size: 0x16, Type: dev
    function private function_89147b208412a2b5()
    {
        function_cf9450abdedd12bf();
        iprintlnbold( "<dev string:x2e9>" );
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0x7f8747b2, Offset: 0x44e7
    // Size: 0x60, Type: dev
    function private function_aef6258bd4d2788d()
    {
        if ( getdvarint( @"scr_oubliette_debug", 0 ) )
        {
            setdvar( @"scr_oubliette_debug", 0 );
            level notify( #"hash_8df327e89a33efa4" );
            iprintlnbold( "<dev string:x300>" );
            return;
        }
        
        setdvar( @"scr_oubliette_debug", 1 );
        level thread debug_draw_loop();
        iprintlnbold( "<dev string:x319>" );
    }

    // Namespace zm_sat_scarab_boss_fight_oubliette
    // Params 0, eflags: 0x4
    // Checksum 0xf8dea951, Offset: 0x454f
    // Size: 0x33c, Type: dev
    function private debug_draw_loop()
    {
        level endon( #"game_ended" );
        level endon( #"hash_8df327e89a33efa4" );
        
        while ( true )
        {
            for ( i = 0; i < level.oubliette_data.var_d291d25e304704c2.size ; i++ )
            {
                var_ed100f9a07836d02 = level.oubliette_data.var_d291d25e304704c2[ i ];
                print3d( var_ed100f9a07836d02.origin + ( 0, 0, 40 ), "<dev string:x331>" + i, ( 0, 1, 1 ), 0.8, 0.6 );
                v_forward = anglestoforward( var_ed100f9a07836d02.angles ?? ( 0, 0, 0 ) );
                v_end = var_ed100f9a07836d02.origin + v_forward * 100;
                line( var_ed100f9a07836d02.origin, v_end, ( 0, 1, 1 ) );
            }
            
            foreach ( player in level.players )
            {
                if ( !isdefined( player.oubliette ) )
                {
                    continue;
                }
                
                str_state = "<dev string:x33c>";
                var_c9e35826ee79c05c = ( 1, 1, 1 );
                
                if ( is_in_oubliette( player ) )
                {
                    str_state = "<dev string:x343>";
                    var_c9e35826ee79c05c = ( 1, 1, 0 );
                }
                
                if ( function_6fc24b6296bc9af4( player ) )
                {
                    str_state += "<dev string:x350>";
                }
                
                if ( isdefined( player.oubliette.var_c6321cb8cd32b6a0 ) )
                {
                    str_state += "<dev string:x361>" + player.oubliette.var_c6321cb8cd32b6a0.str_name;
                    var_578c6765b20e9f03 = 0;
                    
                    foreach ( blessing in level.oubliette_data.var_34f28bf03c7a3a44 )
                    {
                        if ( blessing.str_name == player.oubliette.var_c6321cb8cd32b6a0.str_name )
                        {
                            var_578c6765b20e9f03 = 1;
                            break;
                        }
                    }
                    
                    if ( var_578c6765b20e9f03 )
                    {
                        var_c9e35826ee79c05c = ( 0, 1, 0 );
                    }
                    else
                    {
                        var_c9e35826ee79c05c = ( 1, 0, 0 );
                    }
                }
                
                print3d( player.origin + ( 0, 0, 80 ), str_state, var_c9e35826ee79c05c, 0.7, 0.5 );
            }
            
            waitframe();
        }
    }

#/
