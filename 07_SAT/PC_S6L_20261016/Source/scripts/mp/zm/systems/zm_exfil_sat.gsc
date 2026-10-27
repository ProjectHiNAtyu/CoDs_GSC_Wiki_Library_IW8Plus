// scripts\mp\zm\systems\zm_exfil_sat.gsc  (hash_789c50e394f0bf40.gscc) (size: 54591 Bytes / 0xd53f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7455f3a9 (1951789993)
// size ...... 54591 (0xd53f)
// includes .. 41  (offset: 0xc8df)
// strings ... 131 (offset: 0xca27)
// dev strs .. 32  (offset: 0xd39b)
// exports ... 100 (offset: 0x8d4f)
// cseg ...... 0xa53 + 0x82fc (0x8d4f)
// imports ... 333 (offset: 0x9cef)
// animtree1 . 0   (offset: 0xd53f)
// animtree2 . 0   (offset: 0xd53f)
#using script_16ea1b94f0f381b3;
#using script_4bf223434bdc0646;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\content_manager;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\matchdata;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_laststand;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_exfil_sat;

// Namespace zm_exfil_sat
// Params 0, eflags: 0x5
// Checksum 0x502f72b2, Offset: 0xa71
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_exfil", undefined, &pre_init, &post_init );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xc20b51fb, Offset: 0xa96
// Size: 0x2
function pre_init()
{
    
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xa2fad95e, Offset: 0xaa0
// Size: 0x1ce
function post_init()
{
    if ( !isdefined( level.s_zm_exfil ) )
    {
        level.s_zm_exfil = utility::getstruct( "zm_exfil", "targetname" );
    }
    
    if ( !isdefined( level.s_zm_exfil ) )
    {
        return;
    }
    
    level._effect[ "exfil_hvt_spawn_portal_vfx" ] = loadfxasset( "vfx_sat_levels_zm_firefly_phone_booth_spawn" );
    level._effect[ "dark_energy_beam" ] = loadfxasset( "vfx_sat_levels_zm_firefly_phone_booth_active_beam" );
    level._effect[ "dark_energy_explosion" ] = loadfxasset( "vfx_t10_levels_zm_quartz_transmit_armory_clearing_explode" );
    level._effect[ "dark_energy_fly_vfx" ] = loadfxasset( "vfx_sat_levels_zm_firefly_phone_booth_trail" );
    level._effect[ "energy_charged_cam_vfx" ] = loadfxasset( "vfx_sat_zm_exfil_camera" );
    level._effect[ "exfil_area_vfx" ] = loadfxasset( "vfx_sat_mark_evacuation_area" );
    level._effect[ "hvt_energy_beam" ] = loadfxasset( "vfx_sat_levels_zm_firefly_phone_booth_active_beam" );
    level utility::flag_wait( "scriptables_ready" );
    function_374b5d81a47f2090();
    level.s_zm_exfil function_53179dc52eae87c0();
    function_e6d25909c7962ebf( "disable" );
    level.zm_exfil_throttle = throttle::throttle_initialize( "zm_exfil_throttle", 3, level.framedurationseconds );
    level utility::flag_set( "rbz_allow_exfil" );
    utility::registersharedfunc( #"zm_exfil", #"override_exfil_end", &override_exfil_end );
    zm_quest::function_3c363613c60958f5( "exfil_start" );
    content_manager::register_disable_toggle( "exfil", &content_manager::function_5d04e50a29a2142c, &on_exfil_disabled, &on_exfil_enabled );
    callback::add( "on_round_start", &on_round_start );
    callback::add( "on_round_end", &on_round_end );
    
    /#
        init_sat_exfil_devgui();
    #/
    
    if ( getdvarint( @"hash_af9f3b894ff6a556", 0 ) )
    {
        level thread function_5f8dd7f4c8fd2bd9( 1800 );
    }
}

// Namespace zm_exfil_sat
// Params 2, eflags: 0x4
// Checksum 0xbb0827fd, Offset: 0xc76
// Size: 0x57
function private function_6cfdc47bfec6eef4( str_fx_name, v_origin )
{
    if ( level utility::flag( "use_custom_exfil_vfx" ) && isdefined( level._effect[ str_fx_name + "_custom" ] ) )
    {
        str_fx_name += "_custom";
    }
    
    playfx( level._effect[ str_fx_name ], v_origin );
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0xe63f23ee, Offset: 0xcd5
// Size: 0x26
function private get_exfil_vfx_name( str_fx_name )
{
    if ( level utility::flag( "use_custom_exfil_vfx" ) )
    {
        return ( str_fx_name + "_custom" );
    }
    
    return str_fx_name;
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xbd400b47, Offset: 0xd04
// Size: 0x2e
function function_5f8dd7f4c8fd2bd9( var_2e9555c142dc3d74 )
{
    level utility::flag_clear( "rbz_allow_exfil" );
    level.var_ae6ec3d5ec830a1 = 1;
    level thread function_308d6096485c73dd( var_2e9555c142dc3d74 );
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0xc
// Checksum 0x6dbcc29b, Offset: 0xd3a
// Size: 0x271
function private function_308d6096485c73dd( var_2e9555c142dc3d74 )
{
    self notify( #"hash_4306d5e697b89cab" );
    self endon( #"hash_4306d5e697b89cab" );
    level endon( #"game_ended" );
    
    if ( !isdefined( var_2e9555c142dc3d74 ) )
    {
        var_2e9555c142dc3d74 = 21600;
    }
    
    utility::flag_wait( "begin_round_logic" );
    var_989a85c171fa19b7 = gettime();
    
    while ( true )
    {
        var_4aecf4a42bd3345b = gettime() - var_989a85c171fa19b7;
        var_e178ed096c704725 = getdvarint( @"hash_1b68e1153add8a89", var_2e9555c142dc3d74 ) * 1000;
        
        if ( var_4aecf4a42bd3345b >= var_e178ed096c704725 )
        {
            msg = level utility::waittill_any_return( "bgb_time_out_on_round_end", "on_round_end" );
            
            if ( msg == "bgb_time_out_on_round_end" )
            {
                level utility::waittill_any_timeout( 15, "on_round_end" );
                continue;
            }
            
            foreach ( player in level.players )
            {
                player.var_6668cc2adaf417ca = 1;
            }
            
            function_e6d25909c7962ebf( "available" );
            a_alive_players = utility::get_alive_players();
            var_688192361f9f8f3d = utility::get_array_of_closest( a_alive_players[ 0 ].origin, level.s_zm_exfil.var_c7cfc464905e7bcd );
            
            foreach ( s_exfil in var_688192361f9f8f3d )
            {
                if ( !isdefined( s_exfil.interact ) )
                {
                    continue;
                }
                
                level.var_d1c505330bef7d45 = undefined;
                a_alive_players = utility::get_alive_players();
                utility::flag_clear( "zm_vote_active" );
                b_success = s_exfil.interact on_exfil_interact_used( a_alive_players[ 0 ] );
                
                if ( b_success )
                {
                    game[ "telemetry" ].exfil_forced_ending = 1;
                    level.var_fe9e4f6f7a5b0965 = 1;
                    return;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xe78ff7c3, Offset: 0xfb3
// Size: 0x1e
function override_exfil_end()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "sat_exfil_game_over_scene_played" );
    wait 10;
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x3c06cb90, Offset: 0xfd9
// Size: 0x911
function function_374b5d81a47f2090()
{
    if ( !isdefined( level.s_zm_exfil ) )
    {
        level.s_zm_exfil = utility::getstruct( "zm_exfil", "targetname" );
    }
    
    if ( isdefined( level.s_zm_exfil.exfilscriptable ) )
    {
        return;
    }
    
    var_5f6b32dd7bd76afc = getscriptbundlenames( "zmsatexfilsettings" );
    var_67616c3b20fb7f53 = function_22bd469b7d3ee894( var_5f6b32dd7bd76afc );
    var_b0a50984b82946f1 = getscriptbundle( var_67616c3b20fb7f53 );
    
    if ( !isdefined( var_b0a50984b82946f1 ) )
    {
        return;
    }
    
    level.s_zm_exfil.var_60451de0b132b4cd = var_b0a50984b82946f1.var_60451de0b132b4cd;
    level.s_zm_exfil.var_9443086510150b8e = var_b0a50984b82946f1.var_9443086510150b8e;
    level.s_zm_exfil.var_9d0258e8e88f9640 = var_b0a50984b82946f1.var_9d0258e8e88f9640;
    level.s_zm_exfil.var_368ab947748c1692 = var_b0a50984b82946f1.var_368ab947748c1692;
    level.s_zm_exfil.var_9fc2271010a97eb = var_b0a50984b82946f1.var_9fc2271010a97eb;
    level.s_zm_exfil.kill_hvt_time_limit = var_b0a50984b82946f1.var_dc790c8b4c8b7abc;
    level.s_zm_exfil.exfil_time_limit = var_b0a50984b82946f1.exfiltimelimit;
    level.s_zm_exfil.var_c7361e742d32caab = var_b0a50984b82946f1.var_c7361e742d32caab;
    level.s_zm_exfil.var_3c8ba041e5770316 = var_b0a50984b82946f1.var_3c8ba041e5770316;
    level.s_zm_exfil.var_648d02accc079541 = var_b0a50984b82946f1.var_648d02accc079541;
    level.s_zm_exfil.var_f5327ec3103427b5 = var_b0a50984b82946f1.var_f5327ec3103427b5;
    level.s_zm_exfil.var_1d5da24652eeb2a4 = var_b0a50984b82946f1.var_1d5da24652eeb2a4;
    level.s_zm_exfil.var_1d5da24652eeb2a4 = var_b0a50984b82946f1.var_1d5da24652eeb2a4;
    level.s_zm_exfil.var_69dff7c1809931cc = [];
    level.s_zm_exfil.var_10c0281725395dde = [];
    level.s_zm_exfil.var_2620ba4bfbc1a7fe = var_b0a50984b82946f1.var_2620ba4bfbc1a7fe ?? 5;
    level.s_zm_exfil.var_55bdde1b903c0550 = var_b0a50984b82946f1.var_55bdde1b903c0550;
    
    foreach ( element in var_b0a50984b82946f1.var_96396cc381ddc3c7 )
    {
        level.s_zm_exfil.var_69dff7c1809931cc[ level.s_zm_exfil.var_69dff7c1809931cc.size ] = element.subclass;
    }
    
    if ( isdefined( var_b0a50984b82946f1.var_fad87452aea72056 ) )
    {
        level.s_zm_exfil.var_5d36042a94f277fa = [];
        
        foreach ( element in var_b0a50984b82946f1.var_fad87452aea72056 )
        {
            level.s_zm_exfil.var_5d36042a94f277fa[ level.s_zm_exfil.var_5d36042a94f277fa.size ] = element.subclass;
        }
    }
    
    foreach ( element in var_b0a50984b82946f1.var_10c0281725395dde )
    {
        if ( !isdefined( level.s_zm_exfil.var_10c0281725395dde[ element.sublocationname ] ) )
        {
            level.s_zm_exfil.var_10c0281725395dde[ element.sublocationname ] = spawnstruct();
        }
        
        level.s_zm_exfil.var_10c0281725395dde[ element.sublocationname ].sublocationsize = int( element.sublocationsize );
    }
    
    level.s_zm_exfil.var_dbfc57b46719ecfd = var_b0a50984b82946f1.var_dbfc57b46719ecfd;
    level.s_zm_exfil.var_c3d74588ec89ed6c = var_b0a50984b82946f1.var_c3d74588ec89ed6c;
    level.s_zm_exfil.var_528f7bd73acf7734 = var_b0a50984b82946f1.var_528f7bd73acf7734;
    level.s_zm_exfil.var_475baef5c7628029 = var_b0a50984b82946f1.var_475baef5c7628029;
    level.s_zm_exfil.var_bdae60804c3326c8 = var_b0a50984b82946f1.var_bdae60804c3326c8;
    level.s_zm_exfil.var_e1695707c19c3d9d = var_b0a50984b82946f1.var_e1695707c19c3d9d;
    level.s_zm_exfil.var_de2b84d676c3afec = var_b0a50984b82946f1.var_de2b84d676c3afec;
    level.s_zm_exfil.var_d3d0e039b1d275b4 = var_b0a50984b82946f1.var_d3d0e039b1d275b4;
    level.s_zm_exfil.var_dbe53c05a8f45aa9 = var_b0a50984b82946f1.var_dbe53c05a8f45aa9;
    level.s_zm_exfil.var_6ccc7e5ec20a4d48 = var_b0a50984b82946f1.var_6ccc7e5ec20a4d48;
    level.s_zm_exfil.var_bc2f90154f6bdb47 = var_b0a50984b82946f1.var_bc2f90154f6bdb47;
    level.s_zm_exfil.votetitle = var_b0a50984b82946f1.var_6af459865458555c;
    level.s_zm_exfil.votedescription = var_b0a50984b82946f1.var_5dcb3efec6ce0d4c;
    level.s_zm_exfil.interactionicon = var_b0a50984b82946f1.var_76851fd112fea27b;
    level.s_zm_exfil.objectiveicon = var_b0a50984b82946f1.exfilobjectiveicon;
    level.s_zm_exfil.interaction_settings = [];
    level.s_zm_exfil.interaction_settings[ "available" ] = spawnstruct();
    level.s_zm_exfil.interaction_settings[ "available" ].title = var_b0a50984b82946f1.var_b50fd22a2e6eb146.title;
    level.s_zm_exfil.interaction_settings[ "available" ].description = var_b0a50984b82946f1.var_b50fd22a2e6eb146.description;
    level.s_zm_exfil.interaction_settings[ "available" ].button = var_b0a50984b82946f1.var_b50fd22a2e6eb146.button;
    level.s_zm_exfil.interaction_settings[ "fasttravel" ] = spawnstruct();
    level.s_zm_exfil.interaction_settings[ "fasttravel" ].title = var_b0a50984b82946f1.var_f857ff6d71b6884d.title;
    level.s_zm_exfil.interaction_settings[ "fasttravel" ].description = var_b0a50984b82946f1.var_f857ff6d71b6884d.description;
    level.s_zm_exfil.interaction_settings[ "fasttravel" ].button = var_b0a50984b82946f1.var_f857ff6d71b6884d.button;
    level.s_zm_exfil.interaction_settings[ "exit" ] = spawnstruct();
    level.s_zm_exfil.interaction_settings[ "exit" ].title = var_b0a50984b82946f1.var_3023be873d56c457.title;
    level.s_zm_exfil.interaction_settings[ "exit" ].description = var_b0a50984b82946f1.var_3023be873d56c457.description;
    level.s_zm_exfil.interaction_settings[ "exit" ].button = var_b0a50984b82946f1.var_3023be873d56c457.button;
    function_24b07fa711a26fa9();
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x74dd9294, Offset: 0x18f2
// Size: 0xf8
function function_22bd469b7d3ee894( var_c2c4feee856ed83e )
{
    if ( var_c2c4feee856ed83e.size <= 1 )
    {
        return %"hash_c0839ba8e63b548";
    }
    
    var_fdffff8320fbecc0 = [];
    
    foreach ( var_694c439bafe1dda1 in var_c2c4feee856ed83e )
    {
        exfil_scriptbundle = getscriptbundle( var_694c439bafe1dda1 );
        
        if ( isdefined( exfil_scriptbundle.var_d5a9f257ee10e89 ) )
        {
            if ( exfil_scriptbundle.var_d5a9f257ee10e89 == game_utility::getgametype() )
            {
                return var_694c439bafe1dda1;
            }
            
            continue;
        }
        
        if ( var_694c439bafe1dda1 != %"hash_c0839ba8e63b548" )
        {
            var_fdffff8320fbecc0[ var_fdffff8320fbecc0.size ] = var_694c439bafe1dda1;
        }
    }
    
    if ( var_fdffff8320fbecc0.size == 0 )
    {
        return %"hash_c0839ba8e63b548";
    }
    
    return var_fdffff8320fbecc0[ 0 ];
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xcce2b89c, Offset: 0x19f3
// Size: 0x32
function on_round_start( params )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_8b52dcc4e869e5e5" ) )
    {
        on_round_end( params, 1 );
    }
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0xf0c4b28a, Offset: 0x1a2d
// Size: 0xdc
function on_round_end( params, var_e388a39e979aa425 )
{
    if ( level.disable_zm_exfil )
    {
        return;
    }
    
    if ( !isarray( level.s_zm_exfil.var_c7cfc464905e7bcd ) || level.s_zm_exfil.var_c7cfc464905e7bcd.size == 0 || isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        return;
    }
    
    if ( level.var_ae6ec3d5ec830a1 )
    {
        return;
    }
    
    if ( utility::flag( "exfil_start" ) )
    {
        return;
    }
    
    n_round_ended = zm_utility::get_round_number();
    
    if ( var_e388a39e979aa425 )
    {
        n_round_ended--;
    }
    
    if ( n_round_ended >= 10 && int( n_round_ended ) % 5 == 0 || level.var_f78688c167b4bb9d )
    {
        level thread zm_exfil::function_3b2df1e6755a8537( n_round_ended );
        level thread function_21a86762c018a414();
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xaefc6695, Offset: 0x1b11
// Size: 0x15d
function function_21a86762c018a414()
{
    self notify( #"hash_8d9d59c64cfc6002" );
    self endon( #"hash_8d9d59c64cfc6002" );
    level endon( #"game_ended" );
    level endon( #"exfil_start" );
    level utility::flag_wait( "rbz_allow_exfil" );
    function_e6d25909c7962ebf( "available" );
    zm_exfil_objective_icon( 1 );
    level val::set( "task_exfil", "task_logic_activate", 0 );
    level utility::flag_set( "exfil_window_active" );
    var_f9073b9a68fe2fe = level.s_zm_exfil.var_3c8ba041e5770316;
    var_e8faf713c5403d27 = utility::flag( "rbz_allow_exfil" );
    
    while ( var_f9073b9a68fe2fe > 0 || level.var_4d146d09c3834279 )
    {
        if ( var_e8faf713c5403d27 && !utility::flag( "rbz_allow_exfil" ) )
        {
            level utility::flag_clear( "exfil_window_active" );
            zm_exfil_objective_icon( 0, 0 );
            var_e8faf713c5403d27 = 0;
        }
        else if ( !var_e8faf713c5403d27 && utility::flag( "rbz_allow_exfil" ) )
        {
            zm_exfil_objective_icon( 1, 0 );
            level utility::flag_set( "exfil_window_active" );
            var_e8faf713c5403d27 = 1;
        }
        
        wait 1;
        var_f9073b9a68fe2fe -= 1;
    }
    
    level utility::flag_clear( "exfil_window_active" );
    level val::reset( "task_exfil", "task_logic_activate" );
    function_e6d25909c7962ebf( "disable" );
    zm_exfil_objective_icon( 0 );
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0xd1dc553b, Offset: 0x1c76
// Size: 0x343
function zm_exfil_objective_icon( b_show, b_show_splash = 1 )
{
    foreach ( s_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
    {
        if ( !isdefined( s_exfil.var_c6883f07ae9a466 ) )
        {
            var_c6883f07ae9a466 = objidpoolmanager::requestobjectiveid( 1 );
            s_exfil.var_c6883f07ae9a466 = var_c6883f07ae9a466;
            
            if ( s_exfil.scriptable )
            {
                calloutmarkerping::function_9bd4bf4f8fe74b16( s_exfil.scriptable, s_exfil.var_c6883f07ae9a466, 6 );
            }
            
            objidpoolmanager::objective_add_objective( s_exfil.var_c6883f07ae9a466, "current", self.origin, level.s_zm_exfil.objectiveicon, "icon_regular" );
            objidpoolmanager::update_objective_setbackground( s_exfil.var_c6883f07ae9a466, 1 );
            objidpoolmanager::update_objective_position( s_exfil.var_c6883f07ae9a466, s_exfil.origin + ( 0, 0, 50 ) );
            objidpoolmanager::function_de3fb937d4f45f38( s_exfil.var_c6883f07ae9a466, 100, 70 );
            objective_setlabel( s_exfil.var_c6883f07ae9a466, &"shared_hintstrings/exfil" );
            objective_setplayintro( s_exfil.var_c6883f07ae9a466, 0 );
            
            foreach ( player in level.players )
            {
                objective_addclienttomask( s_exfil.var_c6883f07ae9a466, player );
                objective_showtoplayersinmask( s_exfil.var_c6883f07ae9a466 );
            }
        }
        
        if ( b_show )
        {
            s_exfil utility::ent_flag_set( "exfil_phone_booth_active" );
            
            foreach ( player in level.players )
            {
                player thread function_2c9de8bd6c87cea7();
            }
            
            continue;
        }
        
        level notify( #"hash_ec6654c49ad9e02b" );
        s_exfil utility::ent_flag_clear( "exfil_phone_booth_active" );
        
        if ( !objidpoolmanager::function_fb05d646a96ed99e( s_exfil.var_c6883f07ae9a466 ) )
        {
            objidpoolmanager::returnobjectiveid( s_exfil.var_c6883f07ae9a466 );
        }
        
        s_exfil.var_c6883f07ae9a466 = undefined;
    }
    
    if ( b_show )
    {
        if ( b_show_splash )
        {
            wait 0.5;
            utility::array_thread( level.players, &hud_message::showsplash, "cp_mp_exfil_ready" );
        }
    }
    
    setomnvar( "ui_is_exfil_available", b_show );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x43ee3a9f, Offset: 0x1fc1
// Size: 0x90, Type: bool
function is_exfil_available()
{
    foreach ( s_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
    {
        if ( s_exfil utility::ent_flag( "exfil_phone_booth_active" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x51566ecc, Offset: 0x205a
// Size: 0x2a, Type: bool
function function_38f731e2eb1871b0( player )
{
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( player.var_3edb080f749fcb9c )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xb20a97b1, Offset: 0x208d
// Size: 0x238
function function_2c9de8bd6c87cea7()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    level endon( #"hash_ec6654c49ad9e02b" );
    
    while ( true )
    {
        if ( !function_38f731e2eb1871b0( self ) )
        {
            foreach ( s_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
            {
                if ( isdefined( s_exfil.var_c6883f07ae9a466 ) )
                {
                    objidpoolmanager::objective_playermask_hidefrom( s_exfil.var_c6883f07ae9a466, self );
                }
            }
            
            wait 0.1;
            continue;
        }
        
        a_s_exfil = sortbydistance( level.s_zm_exfil.var_c7cfc464905e7bcd, self.origin );
        
        if ( !isdefined( a_s_exfil ) )
        {
            wait 0.1;
            continue;
        }
        
        var_b6e77594861d3773 = 0;
        
        for ( i = 0; i < a_s_exfil.size ; i++ )
        {
            var_c04568f659618389 = a_s_exfil[ i ];
            
            if ( !isdefined( var_c04568f659618389.var_c6883f07ae9a466 ) )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, var_c04568f659618389.origin ) <= squared( var_c04568f659618389.script_radius ) && i == 0 )
            {
                objidpoolmanager::objective_playermask_addshowplayer( var_c04568f659618389.var_c6883f07ae9a466, self );
                var_b6e77594861d3773 = 1;
                continue;
            }
            
            objidpoolmanager::objective_playermask_hidefrom( var_c04568f659618389.var_c6883f07ae9a466, self );
        }
        
        if ( !var_b6e77594861d3773 )
        {
            for ( i = 0; i < a_s_exfil.size ; i++ )
            {
                if ( !isdefined( a_s_exfil[ i ].var_c6883f07ae9a466 ) )
                {
                    continue;
                }
                
                var_c04568f659618389 = a_s_exfil[ i ];
                
                if ( i < level.s_zm_exfil.var_c7361e742d32caab )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( var_c04568f659618389.var_c6883f07ae9a466, self );
                    continue;
                }
                
                objidpoolmanager::objective_playermask_hidefrom( var_c04568f659618389.var_c6883f07ae9a466, self );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0x6f0a76af, Offset: 0x22cd
// Size: 0x1fd
function function_e6d25909c7962ebf( str_state, var_1a26599ccad01b93 )
{
    foreach ( s_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
    {
        if ( s_exfil == var_1a26599ccad01b93 )
        {
            continue;
        }
        
        s_exfil.states = str_state;
        
        switch ( str_state )
        {
            case #"hash_c1c88ef798270243":
                s_exfil function_bb6c83c5d8558eb1( 0, 0, 0 );
                
                if ( s_exfil.scriptable )
                {
                    s_exfil.scriptable utility::function_32b24db3127bff40( "anim", "close" );
                    s_exfil.scriptable utility::function_32b24db3127bff40( "objective", "on" );
                    calloutmarkerping::function_ab4e5514677fba94( s_exfil.scriptable );
                }
                
                break;
            case #"hash_a88617e0414db78":
                s_exfil function_bb6c83c5d8558eb1( 1, 0, 1 );
                break;
            case #"hash_bee8aefcdf5a9a8f":
                s_exfil function_bb6c83c5d8558eb1( 0, 1, 0 );
                
                if ( s_exfil.scriptable )
                {
                    s_exfil.scriptable utility::function_32b24db3127bff40( "objective", "on" );
                }
                
                break;
            case #"hash_fdfc392e8f7ce863":
                s_exfil function_bb6c83c5d8558eb1( 1, 1, 0 );
                
                if ( s_exfil.scriptable )
                {
                    s_exfil.scriptable utility::function_32b24db3127bff40( "anim", "open" );
                    calloutmarkerping::function_ab4e5514677fba94( s_exfil.scriptable );
                }
                
                break;
            case #"hash_7c31479cf04292f":
                s_exfil function_bb6c83c5d8558eb1( 1, 1, 0 );
                break;
        }
    }
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0x156d0ad8, Offset: 0x24d2
// Size: 0x250
function function_67ea1c632232000e( str_state, original_position )
{
    [ s_exfil ] = sortbydistance( level.s_zm_exfil.var_c7cfc464905e7bcd, original_position );
    s_exfil.states = str_state;
    
    switch ( str_state )
    {
        case #"hash_c1c88ef798270243":
            s_exfil function_bb6c83c5d8558eb1( 0, 0, 0 );
            break;
        case #"hash_a88617e0414db78":
            s_exfil function_bb6c83c5d8558eb1( 1, 0, 1 );
            break;
        case #"hash_bee8aefcdf5a9a8f":
            s_exfil function_bb6c83c5d8558eb1( 0, 1, 0 );
            break;
        case #"hash_fdfc392e8f7ce863":
            s_exfil function_bb6c83c5d8558eb1( 1, 1, 0 );
            break;
        case #"hash_7c31479cf04292f":
            s_exfil function_bb6c83c5d8558eb1( 1, 1, 0 );
            break;
    }
    
    if ( !isdefined( s_exfil.var_c6883f07ae9a466 ) )
    {
        var_c6883f07ae9a466 = objidpoolmanager::requestobjectiveid( 1 );
        s_exfil.var_c6883f07ae9a466 = var_c6883f07ae9a466;
        objidpoolmanager::objective_add_objective( s_exfil.var_c6883f07ae9a466, "current", self.origin, level.s_zm_exfil.objectiveicon, "icon_regular" );
        objidpoolmanager::update_objective_setbackground( s_exfil.var_c6883f07ae9a466, 1 );
        objidpoolmanager::update_objective_position( s_exfil.var_c6883f07ae9a466, s_exfil.origin + ( 0, 0, 50 ) );
        objective_setlabel( s_exfil.var_c6883f07ae9a466, &"shared_hintstrings/exfil" );
        objective_setplayintro( s_exfil.var_c6883f07ae9a466, 0 );
        
        foreach ( player in level.players )
        {
            objective_addclienttomask( s_exfil.var_c6883f07ae9a466, player );
            objective_showtoplayersinmask( s_exfil.var_c6883f07ae9a466 );
        }
    }
    
    return s_exfil;
}

// Namespace zm_exfil_sat
// Params 3
// Checksum 0xaee788f8, Offset: 0x272b
// Size: 0x173
function function_bb6c83c5d8558eb1( b_interact_part = 1, b_vfx_part = 1, var_414c8a7d6e5c4900 = 1 )
{
    if ( isdefined( self.interact ) )
    {
        if ( b_interact_part )
        {
            self.interact utility::function_32b24db3127bff40( "base", "small" );
        }
        else
        {
            self.interact utility::function_32b24db3127bff40( "base", "off" );
        }
    }
    
    if ( isdefined( self.scriptable ) )
    {
        if ( b_vfx_part )
        {
            if ( level utility::flag( "use_custom_exfil_vfx" ) && self.scriptable getscriptableparthasstate( "fx", self.states + "_custom" ) )
            {
                self.scriptable utility::function_32b24db3127bff40( "fx", self.states + "_custom" );
            }
            else
            {
                self.scriptable utility::function_32b24db3127bff40( "fx", self.states );
            }
        }
        else
        {
            self.scriptable utility::function_32b24db3127bff40( "fx", "off" );
        }
    }
    
    if ( isdefined( self.scriptable ) )
    {
        if ( var_414c8a7d6e5c4900 )
        {
            self.scriptable utility::function_32b24db3127bff40( "sfx", "on" );
            return;
        }
        
        self.scriptable utility::function_32b24db3127bff40( "sfx", "off" );
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xbe0a541e, Offset: 0x28a6
// Size: 0x29c
function function_53179dc52eae87c0()
{
    var_c7cfc464905e7bcd = utility::getstructarray( self.target, "targetname" );
    var_a5051245410eb180 = [];
    
    foreach ( s_exfil in var_c7cfc464905e7bcd )
    {
        if ( s_exfil content_manager::function_e0f0562adcd2c071() )
        {
            var_a5051245410eb180[ var_a5051245410eb180.size ] = s_exfil;
        }
    }
    
    assert( isarray( var_a5051245410eb180 ) && var_a5051245410eb180.size != 0, "<dev string:x24>" );
    level.s_zm_exfil.var_c7cfc464905e7bcd = var_a5051245410eb180;
    
    foreach ( sub_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
    {
        sub_exfil.states = "disable";
        sub_exfil function_50e4131b11f82b59();
        sub_exfil.scriptable = spawnscriptable( level.s_zm_exfil.var_60451de0b132b4cd, sub_exfil.origin, sub_exfil.angles );
        sub_exfil.interact = spawnscriptable( "zm_sat_exfil_scriptable_interact", sub_exfil.var_b03fab8f4be015ad.origin );
        
        if ( !isdefined( sub_exfil.script_radius ) )
        {
            sub_exfil.script_radius = 10000;
        }
        
        sub_exfil.exfil_radius = level.s_zm_exfil.var_10c0281725395dde[ sub_exfil.script_noteworthy ].sublocationsize ?? 1250;
        
        if ( isdefined( sub_exfil.interact ) )
        {
            sub_exfil.interact.s_exfil = sub_exfil;
            interaction::register_scriptable_interact( sub_exfil.interact, &on_exfil_interact_used, undefined, undefined, &exfil_interact_hint_callback );
            sub_exfil.interact interaction::function_e4a4753e6eac02d7();
        }
        
        sub_exfil utility::callsharedfunc( #"zombie", #"hash_896b88a46f6a4c15", "exfil" );
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xdf5500b8, Offset: 0x2b4a
// Size: 0x12a
function function_50e4131b11f82b59()
{
    var_3010f232fa3880d9 = utility::getstructarray( self.target, "targetname" );
    assert( isarray( var_3010f232fa3880d9 ) && var_3010f232fa3880d9.size != 0, "<dev string:x60>" );
    
    foreach ( pos in var_3010f232fa3880d9 )
    {
        if ( pos.script_noteworthy == "hvt_spawn_pos" )
        {
            self.hvt_spawn_pos = pos;
            continue;
        }
        
        if ( pos.script_noteworthy == "teleport_pos" )
        {
            self.teleport_pos = pos;
            continue;
        }
        
        if ( pos.script_noteworthy == "interact" )
        {
            self.var_b03fab8f4be015ad = pos;
            continue;
        }
        
        if ( pos.script_noteworthy == "override_exfil_center" )
        {
            self.override_exfil_center = pos;
        }
    }
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0x16e21d3f, Offset: 0x2c7c
// Size: 0x1ec
function exfil_interact_hint_callback( usable, player )
{
    if ( utility::flag( "zm_vote_active" ) || !zm_quest::function_f98968f17772726c( 1, [ "exfil_start" ] ) || player.var_1a98782093ca2c08 || player.interactions_disabled && !usable.var_69c82d94dce882a5 || !level val::get( "allow_exfil" ) || usable.b_cool_down )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( !isdefined( usable.s_exfil ) || usable.s_exfil.states == "active" )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    return { #icon:level.s_zm_exfil.interactionicon, #buttoncallout:level.s_zm_exfil.interaction_settings[ usable.s_exfil.states ].button, #description:level.s_zm_exfil.interaction_settings[ usable.s_exfil.states ].description, #title:level.s_zm_exfil.interaction_settings[ usable.s_exfil.states ].title, #string:&"shared_hintstrings/exfil_start_use_sat", #type:"HINT_BUTTON" };
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xd1799807, Offset: 0x2e71
// Size: 0x2d5
function on_exfil_interact_used( player )
{
    if ( utility::flag( "zm_vote_active" ) || !zm_quest::function_f98968f17772726c( 1, [ "exfil_start" ] ) || player.var_1a98782093ca2c08 || !level val::get( "allow_exfil" ) || self.b_cool_down )
    {
        return;
    }
    
    if ( !isdefined( self.s_exfil ) )
    {
        return;
    }
    
    if ( self.s_exfil.states == "active" )
    {
        return;
    }
    
    switch ( self.s_exfil.states )
    {
        case #"hash_a88617e0414db78":
            level callback::callback( "zm_sat_exfil_vote_initiated" );
            level.s_zm_exfil.var_d867cc41c15a2fd1 = self.s_exfil;
            level.s_zm_exfil.activator = player;
            level.s_zm_exfil.var_d867cc41c15a2fd1.scriptable utility::function_32b24db3127bff40( "anim", "open" );
            var_3faf858e79cd17bb = spawnstruct();
            var_3faf858e79cd17bb.header = &"hash_510efaac2b9620ac";
            var_3faf858e79cd17bb.init_message = level.s_zm_exfil.votetitle;
            var_3faf858e79cd17bb.description = level.s_zm_exfil.votedescription;
            var_3faf858e79cd17bb.var_6c8c12c741515514 = 1;
            
            if ( level.players.size == 1 )
            {
                var_3faf858e79cd17bb.a_players_accepted = [ player ];
                level thread start_exfil( var_3faf858e79cd17bb, 1 );
                return 1;
            }
            else
            {
                foreach ( e_player in level.players )
                {
                    if ( isalive( player ) )
                    {
                        if ( isplayer( e_player ) && soundexists( "uin_ob_splash_exfil_available" ) )
                        {
                            e_player playlocalsound( "uin_ob_splash_exfil_available" );
                        }
                        
                        e_player thread hud_message::showsplash( "zm_exfil_initiated", undefined, player );
                    }
                }
            }
            
            level thread zm_quest::function_c18b4d9b23790934( player, var_3faf858e79cd17bb, &start_exfil, 0.5, level.s_zm_exfil.var_9fc2271010a97eb ?? 15, 0, 1 );
            return 1;
        case #"hash_fdfc392e8f7ce863":
            level thread function_a3e72946f92db23f( player );
            break;
        case #"hash_cf84b0041cf92be5":
            level thread function_29042ff5bd626104( player );
            break;
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x7ba4af2e, Offset: 0x314e
// Size: 0x40
function keep_player_alive( params )
{
    newhealth = self.health - params.idamage;
    
    if ( newhealth <= 150 )
    {
        self.health = 150;
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xbaf9328c, Offset: 0x3196
// Size: 0x5c
function function_952ebe590ae54bac()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.interact ) )
    {
        return;
    }
    
    self.interact.b_cool_down = 1;
    wait level.s_zm_exfil.var_368ab947748c1692;
    self.interact.b_cool_down = 0;
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0xe9f40fe, Offset: 0x31fa
// Size: 0x32e
function start_exfil( s_vote, b_passed )
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player )
        {
            player.var_472e2d036e427d3b = undefined;
        }
    }
    
    if ( s_vote.a_players_accepted.size == 0 )
    {
        level.s_zm_exfil.var_d867cc41c15a2fd1 thread function_952ebe590ae54bac();
        callback::callback( "zm_sat_exfil_declined" );
        return;
    }
    else
    {
        level.s_zm_exfil.a_players_accepted = function_b5a8500a6a96fbd4( s_vote.a_players_accepted );
    }
    
    level thread function_4d8cfb99e941e86c();
    setomnvar( "ui_is_exfil_active", 1 );
    level callback::callback( "zm_exfil_started", { #a_exfil_players:level.s_zm_exfil.a_players_accepted, #s_exfil:level.s_zm_exfil, #var_5a5626a7d4b2feb:level.s_zm_exfil.activator } );
    level.var_916aae8097d37e9e = &function_32996f57d7652cac;
    
    if ( level.s_zm_exfil.a_players_accepted.size == level.players.size )
    {
        level.s_zm_exfil.b_all_players_accepted = 1;
    }
    
    callback::add( #"player_death", &function_16ec67c3f3ee8f87 );
    callback::add( #"player_disconnect", &function_16ec67c3f3ee8f87 );
    callback::add( "on_zombie_viper_eject", &track_zombie_viper_mini );
    level thread function_91abdecf0075c42a();
    level.s_zm_exfil.var_d867cc41c15a2fd1.states = "active";
    level utility::flag_set( "exfil_start" );
    wait 1;
    level utility::flag_set( "exfil_active" );
    level utility::flag_set( "exfil_kill_hvt_start" );
    zm_exfil_objective_icon( 0 );
    zm_quest::function_61f7df5fddf96cd1();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"exfil" );
    level.s_zm_exfil.var_d867cc41c15a2fd1 function_bb6c83c5d8558eb1( 0, 1, 0 );
    level.s_zm_exfil.var_d867cc41c15a2fd1 set_exfil_dome( string( level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ) );
    function_e6d25909c7962ebf( "fasttravel", level.s_zm_exfil.var_d867cc41c15a2fd1 );
    level thread function_a8dd03453ad3f0d5();
    var_dd280264802c2ca0 = get_exfil_center();
    function_feae7068c6b1cb67();
    level thread function_f9c1fbf2b01845ea( var_dd280264802c2ca0 );
    level thread function_22712be10b3582e3( var_dd280264802c2ca0 );
    level waittill( #"sat_exfil_hvt_spawned" );
    level thread function_e39777516c0241e4( var_dd280264802c2ca0 );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x56ff1bf8, Offset: 0x3530
// Size: 0x135
function track_zombie_viper_mini( params )
{
    if ( params.eject_label == "exfil_spawned" )
    {
        var_3017d07087bdb6c1 = level.var_a74764204d9643c;
        level.var_a74764204d9643c = undefined;
        
        if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) )
        {
            objidpoolmanager::returnobjectiveid( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd );
        }
        
        level.s_zm_exfil.alive_hvt = params.eject_ai;
        level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd = zm_quest::function_dc297429579c6e7f( "zm_sat_exfil_hvt", 1, "ui_icon_zm_objective", "icon_small_medium", "current", params.eject_ai, 100, undefined, undefined, 1, 1 );
        params.eject_ai thread function_10415e2a28b3e7d0();
        level.var_a74764204d9643c = var_3017d07087bdb6c1;
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x35f19f99, Offset: 0x366d
// Size: 0x14
function function_16ec67c3f3ee8f87( params )
{
    level thread function_6633fb63c580c1d6();
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x6388363e, Offset: 0x3689
// Size: 0x102
function function_6633fb63c580c1d6()
{
    if ( isdefined( level.s_zm_exfil.a_players_accepted ) && level.s_zm_exfil.a_players_accepted.size != 0 )
    {
        b_any_player_in_laststand = 0;
        
        foreach ( player in level.s_zm_exfil.a_players_accepted )
        {
            if ( player::isinlaststand( player ) )
            {
                b_any_player_in_laststand = 1;
                break;
            }
        }
        
        if ( b_any_player_in_laststand )
        {
            return;
        }
    }
    
    var_741060df695c7f61 = zm_laststand::function_d96558297a3c2b2b( undefined, level.s_zm_exfil.a_players_accepted );
    
    if ( !var_741060df695c7f61 )
    {
        level thread exfil_failed();
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x257a362a, Offset: 0x3793
// Size: 0x15f
function function_91abdecf0075c42a()
{
    level endon( #"game_ended" );
    var_dd280264802c2ca0 = get_exfil_center();
    var_958eb3d7915dabd5 = utility::function_b7f3d374aa10aa51( "zone_def", "script_noteworthy", var_dd280264802c2ca0, 3000 );
    level.s_zm_exfil.var_2c35e1f3da109a5e = [];
    
    foreach ( struct in var_958eb3d7915dabd5 )
    {
        if ( isdefined( struct.script_zone_name ) )
        {
            level.s_zm_exfil.var_2c35e1f3da109a5e[ level.s_zm_exfil.var_2c35e1f3da109a5e.size ] = struct.script_zone_name;
            zone_spawner::function_2ce7db1d59b307d8( struct.script_zone_name );
        }
    }
    
    level.s_zm_exfil.var_2c35e1f3da109a5e = arrayremoveduplicates( level.s_zm_exfil.var_2c35e1f3da109a5e );
    zm_quest::cleanup_zombies_manually( 0, level.s_zm_exfil.var_2c35e1f3da109a5e, undefined, undefined, 1, 0, 1, 1 );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xc53a54f5, Offset: 0x38fa
// Size: 0x155
function function_feae7068c6b1cb67()
{
    var_3017d07087bdb6c1 = level.var_a74764204d9643c;
    level.var_a74764204d9643c = undefined;
    level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 = zm_quest::function_b98d4144845ffc13( "zm_sat_exfil", 1, "ui_icon_zm_objective", "icon_small_medium", "current", level.s_zm_exfil.var_d867cc41c15a2fd1.origin, ( 0, 0, 50 )[ 2 ], &"shared_hintstrings/exfil", undefined, 1, 0 );
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
    {
        foreach ( player in level.players )
        {
            objidpoolmanager::objective_playermask_hidefrom( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
        }
    }
    
    level.var_a74764204d9643c = var_3017d07087bdb6c1;
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x4f3440a9, Offset: 0x3a57
// Size: 0x148
function function_f9c1fbf2b01845ea( var_dd280264802c2ca0 )
{
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
    {
        radius_exist = level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius > 0;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && function_38f731e2eb1871b0( player ) && radius_exist && distancesquared( player.origin, var_dd280264802c2ca0 ) < squared( level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
            }
        }
    }
    
    level thread function_9f3ab2c455a846ef( var_dd280264802c2ca0 );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xfc4ed02c, Offset: 0x3ba7
// Size: 0x3db
function function_9f3ab2c455a846ef( var_dd280264802c2ca0 )
{
    level endon( #"game_ended" );
    level endon( #"exfil_escape_step_start" );
    level endon( #"exfil_failed" );
    
    while ( true )
    {
        radius_exist = level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius > 0;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( !function_38f731e2eb1871b0( player ) )
                {
                    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
                    {
                        objidpoolmanager::objective_playermask_hidefrom( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
                    }
                    
                    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) )
                    {
                        objidpoolmanager::objective_playermask_hidefrom( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd, player );
                    }
                    
                    continue;
                }
                
                if ( radius_exist && distancesquared( player.origin, var_dd280264802c2ca0 ) < squared( level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ) )
                {
                    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
                    {
                        objidpoolmanager::objective_playermask_hidefrom( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
                    }
                    
                    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) )
                    {
                        objidpoolmanager::objective_playermask_addshowplayer( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd, player );
                    }
                    
                    continue;
                }
                
                if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
                }
                
                if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd, player );
                }
            }
        }
        
        throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x4e1a9539, Offset: 0x3f8a
// Size: 0x276
function function_22712be10b3582e3( var_dd280264802c2ca0 )
{
    level endon( #"game_ended" );
    level endon( #"exfil_escape_step_start" );
    level endon( #"exfil_failed" );
    
    while ( true )
    {
        if ( !isdefined( level.s_zm_exfil.a_players_accepted ) || level.s_zm_exfil.a_players_accepted.size == 0 )
        {
            wait 1;
            continue;
        }
        
        radius_exist = level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius > 0;
        
        foreach ( player in level.s_zm_exfil.a_players_accepted )
        {
            if ( isalive( player ) && radius_exist && distancesquared( player.origin, var_dd280264802c2ca0 ) > squared( level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ) )
            {
                if ( !player utility::ent_flag( "has_entered_exfil_area" ) )
                {
                    continue;
                }
                
                if ( !player utility::ent_flag( "exfil_camera_vfx_played" ) )
                {
                    player utility::ent_flag_set( "exfil_camera_vfx_played" );
                    playfxontagforclients( level._effect[ "energy_charged_cam_vfx" ], player, "j_head", player );
                }
                
                if ( !isdefined( level.s_zm_exfil.attack_entity ) )
                {
                    level.s_zm_exfil.attack_entity = utility::spawn_model( "tag_origin" );
                }
                
                player dodamage( level.s_zm_exfil.var_9d0258e8e88f9640, player.origin, level.s_zm_exfil.attack_entity );
                continue;
            }
            
            if ( !player utility::ent_flag( "has_entered_exfil_area" ) )
            {
                player utility::ent_flag_set( "has_entered_exfil_area" );
            }
            
            if ( player utility::ent_flag( "exfil_camera_vfx_played" ) )
            {
                player utility::ent_flag_clear( "exfil_camera_vfx_played" );
                stopfxontagforclients( level._effect[ "energy_charged_cam_vfx" ], player, "j_head", player );
            }
        }
        
        wait 1;
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x4f6fe2d6, Offset: 0x4208
// Size: 0x1ee
function function_fd31b5e2c3ae17fe()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.s_zm_exfil.beam_tag ) )
    {
        level.s_zm_exfil.beam_tag = utility::spawn_model( "tag_origin", level.s_zm_exfil.var_d867cc41c15a2fd1.origin + ( 0, 0, 50 ) );
    }
    
    foreach ( player in level.s_zm_exfil.a_players_accepted )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( isdefined( player.var_32e8baf4eacfb2cd ) )
        {
            return;
        }
        
        if ( isdefined( player ) )
        {
            str_fx = get_exfil_vfx_name( "dark_energy_beam" );
            player.var_32e8baf4eacfb2cd = playfxontagsbetweenclients( level._effect[ str_fx ], player, "j_spine4", level.s_zm_exfil.beam_tag, "tag_origin" );
        }
    }
    
    wait 3;
    
    foreach ( player in level.s_zm_exfil.a_players_accepted )
    {
        if ( isdefined( player ) && isdefined( player.var_32e8baf4eacfb2cd ) )
        {
            player.var_32e8baf4eacfb2cd delete();
        }
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xe5a2805e, Offset: 0x43fe
// Size: 0x52
function function_e39777516c0241e4( var_dd280264802c2ca0 )
{
    level thread function_4aed135545a15d00( var_dd280264802c2ca0 );
    
    if ( isdefined( level.var_7e97ab6e80e19ffa ) )
    {
        level thread function_e3f4c8aa85b987c1( level.var_7e97ab6e80e19ffa );
        return;
    }
    
    level thread function_e3f4c8aa85b987c1( level.s_zm_exfil.kill_hvt_time_limit );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xc655063c, Offset: 0x4458
// Size: 0x148
function function_4aed135545a15d00( var_dd280264802c2ca0 )
{
    level endon( #"game_ended" );
    level endon( #"exfil_reset" );
    level endon( #"exfil_escape_step_start" );
    
    while ( true )
    {
        radius_exist = level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius > 0;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && radius_exist && distancesquared( player.origin, var_dd280264802c2ca0 ) < squared( level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ) )
            {
                player thread function_af50db2abe5ef508( 1 );
                continue;
            }
            
            player thread function_af50db2abe5ef508( 0 );
        }
        
        throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xde044d4f, Offset: 0x45a8
// Size: 0x32b
function function_e3f4c8aa85b987c1( n_time )
{
    level endon( #"game_ended" );
    level endon( #"exfil_escape_step_start" );
    level endon( #"exfil_failed" );
    n_time_start_ms = gettime();
    var_3867b250a8978e46 = n_time * 1000;
    
    while ( true )
    {
        var_3718e9a05221fcc1 = gettime() - n_time_start_ms;
        n_time_left_ms = var_3867b250a8978e46 - var_3718e9a05221fcc1;
        n_time_left_ms = max( n_time_left_ms, 0 );
        n_time_left = n_time_left_ms / 1000;
        level.s_zm_exfil.var_77be3669189a4fe3 = int( n_time_left );
        
        if ( isdefined( level.s_zm_exfil.alive_hvt ) && isdefined( level.s_zm_exfil.alive_hvt.maxhealth ) )
        {
            progress_frac = level.s_zm_exfil.alive_hvt.health / level.s_zm_exfil.alive_hvt.maxhealth;
            progress_frac = clamp( progress_frac, 0, 1 );
            progress_frac *= 999;
        }
        
        level notify( #"exfil_time_remaining", level.s_zm_exfil.var_77be3669189a4fe3, level.s_zm_exfil );
        
        foreach ( player in level.players )
        {
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"sat_exfil", #"kill_hvt" );
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"sat_exfil", level.s_zm_exfil.var_cbdf7bc34db9bbcb );
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"sat_exfil", #"escape" );
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"sat_exfil", #"hash_7cb81f038a004833" );
            player zm_quest::function_612a9ad0db22c29c( n_time_left_ms, 0, #"sat_exfil", #"reach_site" );
            
            if ( isdefined( level.s_zm_exfil.alive_hvt ) && isdefined( level.s_zm_exfil.alive_hvt.maxhealth ) && isdefined( progress_frac ) )
            {
                player zm_quest::function_9f49b2a045ece8ae( progress_frac, 0, #"sat_exfil", #"kill_hvt" );
                player zm_quest::function_9f49b2a045ece8ae( progress_frac, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
            }
        }
        
        if ( n_time_left_ms <= 0 )
        {
            level thread function_d88f211bfba4937e();
            return;
        }
        
        throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xba57fd72, Offset: 0x48db
// Size: 0xba
function function_9515b3c2d065c86b()
{
    utility::ent_flag_clear( "show_exfil_hud" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"sat_exfil", #"kill_hvt" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"sat_exfil", #"escape" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"sat_exfil", level.s_zm_exfil.var_cbdf7bc34db9bbcb );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"sat_exfil", #"reach_site" );
    zm_quest::function_fba942a1cfd85f5d( 0, 0, #"sat_exfil", #"hash_7cb81f038a004833" );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xf436f679, Offset: 0x499d
// Size: 0x319
function function_af50db2abe5ef508( var_e1d6724ac712dc52 )
{
    b_show_splash = !utility::ent_flag( "showed_exfil_hud_splash" );
    var_4516da9459df6b2b = !level utility::flag( "exfil_escape_step_start" );
    utility::ent_flag_set( "show_exfil_hud" );
    
    if ( var_4516da9459df6b2b )
    {
        if ( b_show_splash )
        {
            utility::ent_flag_set( "showed_exfil_hud_splash" );
            
            if ( !var_e1d6724ac712dc52 )
            {
                if ( !utility::ent_flag( "showed_reach_exfil_hud" ) )
                {
                    utility::ent_flag_set( "showed_reach_exfil_hud" );
                    utility::ent_flag_clear( "showed_kill_hvt_hud" );
                    zm_quest::function_cd1f2fee4749fb0a( 0, #"sat_exfil", #"hash_7cb81f038a004833" );
                    zm_quest::function_612a9ad0db22c29c( level.s_zm_exfil.kill_hvt_time_limit, 0, #"sat_exfil", #"hash_7cb81f038a004833" );
                    zm_quest::function_194bde735238c397( 0, 0, #"sat_exfil", #"hash_7cb81f038a004833" );
                }
            }
            else if ( !utility::ent_flag( "showed_kill_hvt_hud" ) )
            {
                utility::ent_flag_set( "showed_kill_hvt_hud" );
                utility::ent_flag_clear( "showed_reach_exfil_hud" );
                zm_quest::function_cd1f2fee4749fb0a( 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
                zm_quest::function_612a9ad0db22c29c( level.s_zm_exfil.kill_hvt_time_limit, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
                zm_quest::function_194bde735238c397( 0, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
            }
        }
        else if ( !var_e1d6724ac712dc52 )
        {
            if ( !utility::ent_flag( "showed_reach_exfil_hud" ) )
            {
                utility::ent_flag_set( "showed_reach_exfil_hud" );
                utility::ent_flag_clear( "showed_kill_hvt_hud" );
                zm_quest::function_cd1f2fee4749fb0a( 0, #"sat_exfil", #"reach_site" );
                zm_quest::function_612a9ad0db22c29c( level.s_zm_exfil.kill_hvt_time_limit, 0, #"sat_exfil", #"reach_site" );
                zm_quest::function_194bde735238c397( 0, 0, #"sat_exfil", #"reach_site" );
            }
        }
        else if ( !utility::ent_flag( "showed_kill_hvt_hud" ) )
        {
            utility::ent_flag_set( "showed_kill_hvt_hud" );
            utility::ent_flag_clear( "showed_reach_exfil_hud" );
            zm_quest::function_cd1f2fee4749fb0a( 0, #"sat_exfil", #"kill_hvt" );
            zm_quest::function_612a9ad0db22c29c( level.s_zm_exfil.kill_hvt_time_limit, 0, #"sat_exfil", #"kill_hvt" );
            zm_quest::function_194bde735238c397( 0, 0, #"sat_exfil", #"kill_hvt" );
        }
        
        return;
    }
    
    zm_quest::function_cd1f2fee4749fb0a( 0, #"sat_exfil", level.s_zm_exfil.var_cbdf7bc34db9bbcb );
    zm_quest::function_612a9ad0db22c29c( level.s_zm_exfil.kill_hvt_time_limit, 0, #"sat_exfil", level.s_zm_exfil.var_cbdf7bc34db9bbcb );
    zm_quest::function_194bde735238c397( 0, 0, #"sat_exfil", level.s_zm_exfil.var_cbdf7bc34db9bbcb );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xccf6eaa3, Offset: 0x4cbe
// Size: 0x2e
function function_24b07fa711a26fa9( var_cbdf7bc34db9bbcb )
{
    level.s_zm_exfil.var_cbdf7bc34db9bbcb = var_cbdf7bc34db9bbcb ?? #"hash_d245b687007c4bcb";
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x28baeb1f, Offset: 0x4cf4
// Size: 0x4b
function function_a3e72946f92db23f( player )
{
    if ( !isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        return;
    }
    
    zm_fasttravel::function_cbb08198e7c84adf( level.s_zm_exfil.var_d867cc41c15a2fd1.teleport_pos, player );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x5788bfe2, Offset: 0x4d47
// Size: 0x12
function function_a8dd03453ad3f0d5()
{
    level thread spawn_hvt_zombie();
    level thread function_42e7aa7b635e7cd();
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xbc36cd23, Offset: 0x4d61
// Size: 0x22e
function spawn_hvt_zombie()
{
    level endon( #"game_ended" );
    assert( isdefined( level.s_zm_exfil.var_69dff7c1809931cc ), "<dev string:xa3>" );
    var_e8be34fa0506ebf5 = get_valid_hvt_spawn_pos();
    assert( isdefined( var_e8be34fa0506ebf5 ), "<dev string:xbf>" );
    var_b76d493ca09b8dfa = get_exfil_vfx_name( "dark_energy_fly_vfx" );
    var_a1e8dfaaff769f1d = [ #"hash_a21b1287df31f23c", #"hash_2d0306a34d329805" ];
    var_9a0f3bebde6c9aed = utility::spawn_model( "tag_origin", level.s_zm_exfil.var_d867cc41c15a2fd1.origin + ( 0, 0, 50 ) );
    var_9a0f3bebde6c9aed zm_quest::function_b8743f5a9219cf9b( undefined, var_e8be34fa0506ebf5 + ( 0, 0, 50 ), var_b76d493ca09b8dfa, undefined, undefined, undefined, undefined, var_a1e8dfaaff769f1d );
    level.s_zm_exfil.current_hvt_type = utility::array_random( level.s_zm_exfil.var_69dff7c1809931cc );
    function_6cfdc47bfec6eef4( "exfil_hvt_spawn_portal_vfx", var_e8be34fa0506ebf5 );
    playsoundatpos( var_e8be34fa0506ebf5, #"hash_cc140a598e5d2f19" );
    var_8eac3ec23584335d = function_b3988325430ce242( level.s_zm_exfil.current_hvt_type );
    sparams = spawnstruct();
    sparams.ai_subclass = level.s_zm_exfil.current_hvt_type;
    sparams.position = var_e8be34fa0506ebf5;
    sparams.round_number = zm_round_logic::get_rb_round_number();
    wait 1;
    
    if ( isdefined( level.s_zm_exfil.current_hvt_type ) && isdefined( var_e8be34fa0506ebf5 ) )
    {
        zombies = getaiarray( "team_two_hundred" );
        
        if ( zombies.size >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
        {
            hvt_agent = zm_utility::function_9f6754719bfeaeb1( [ "normal" ], &function_f9aab6699c5fdd42, sparams );
        }
        else
        {
            hvt_agent = function_f9aab6699c5fdd42( sparams );
        }
        
        hvt_agent.var_e29cf96ffe5ad58e = 3;
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xe992a72f, Offset: 0x4f97
// Size: 0xda
function scale_zombie_health()
{
    if ( !isdefined( self.var_d6894f01a36b4ff3.healthscriptbundle ) )
    {
        return;
    }
    
    var_abae9347abb107f1 = getscriptbundle( "healthscalinground:" + self.var_d6894f01a36b4ff3.healthscriptbundle );
    
    if ( !isdefined( var_abae9347abb107f1 ) )
    {
        return;
    }
    
    base = self.health ?? 100;
    per_player_increase = var_abae9347abb107f1.var_674ca87a808f9ea1;
    
    if ( isdefined( per_player_increase ) && level.s_zm_exfil.a_players_accepted.size > 1 )
    {
        base += base * ( level.s_zm_exfil.a_players_accepted.size - 1 ) * per_player_increase;
    }
    
    ai::set_ai_max_health( int( base ) );
    self.health = self.maxhealth;
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xc6246c16, Offset: 0x5079
// Size: 0xee
function function_8bfa48ae01c0951b( target_position )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        var_47ab389d1547a444 = utility::spawn_model( "tag_origin", level.s_zm_exfil.var_d867cc41c15a2fd1.origin + ( 0, 0, 160 ) );
        var_e531f675cc8ead4f = utility::spawn_model( "tag_origin", target_position );
        str_fx = get_exfil_vfx_name( "hvt_energy_beam" );
        beam_vfx = playfxontagsbetweenclients( level._effect[ str_fx ], var_47ab389d1547a444, "tag_origin", var_e531f675cc8ead4f, "tag_origin" );
        wait 2;
        
        if ( isdefined( beam_vfx ) )
        {
            beam_vfx delete();
        }
        
        if ( isdefined( var_47ab389d1547a444 ) )
        {
            var_47ab389d1547a444 delete();
        }
        
        if ( isdefined( var_e531f675cc8ead4f ) )
        {
            var_e531f675cc8ead4f delete();
        }
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x4ef464b0, Offset: 0x516f
// Size: 0x1ea
function function_f9aab6699c5fdd42( sparams )
{
    hvt_agent = agent_manager::spawn_agent( sparams.ai_subclass, sparams.position, ( 0, 0, 0 ), "team_two_hundred" );
    
    if ( isdefined( hvt_agent ) )
    {
        hvt_agent val::set( "sat_exfil", "ignore_cleanup", 1 );
        hvt_agent.disable_brain_rot = 1;
        hvt_agent.ignore_enemy_count = 1;
        hvt_agent.var_a13bed1ac47e1b2c = 1;
        hvt_agent.b_ignore_fasttravel_jumppad = 1;
        hvt_agent zombie_utils::set_zombie_round_difficulty( sparams.round_number );
        hvt_agent namespace_9d8e359c3b1041e5::function_b2ccfa9f49ce6938( 1 );
        level.s_zm_exfil.alive_hvt = hvt_agent;
        hvt_agent thread function_10415e2a28b3e7d0();
        hvt_agent thread function_4ccebf660408c7c9();
        var_3017d07087bdb6c1 = level.var_a74764204d9643c;
        level.var_a74764204d9643c = undefined;
        
        if ( isdefined( level.s_zm_exfil ) && isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
        {
            level.s_zm_exfil.var_d867cc41c15a2fd1 thread function_8bfa48ae01c0951b( hvt_agent gettagorigin( "j_spine4" ) ?? hvt_agent.origin );
            level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd = zm_quest::function_dc297429579c6e7f( "zm_sat_exfil_hvt", 1, "ui_icon_zm_objective", "icon_small_medium", "current", level.s_zm_exfil.alive_hvt, 100, undefined, undefined, 1, 1 );
        }
        
        level.var_a74764204d9643c = var_3017d07087bdb6c1;
        
        if ( issubstr( sparams.ai_subclass, "zombie_viper" ) )
        {
            hvt_agent.var_d3b87382618c1f10 = "exfil_spawned";
        }
        
        level notify( #"sat_exfil_hvt_spawned" );
    }
    
    return hvt_agent;
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xf507344a, Offset: 0x5362
// Size: 0xc6
function get_valid_hvt_spawn_pos()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.s_zm_exfil.var_d867cc41c15a2fd1.hvt_spawn_pos )
        {
            radius = randomintrange( 150, 250 );
            random_pos = utility::function_8ae0ea62537eafc5( level.s_zm_exfil.var_d867cc41c15a2fd1.hvt_spawn_pos.origin, radius );
            zone = zone_manager::function_90e5c3e2272b0130( random_pos );
            
            if ( isdefined( zone ) && zone.is_active )
            {
                return random_pos;
            }
        }
        
        throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xea257305, Offset: 0x5430
// Size: 0x2bd
function function_4ccebf660408c7c9()
{
    level endon( #"game_ended" );
    level endon( #"exfil_failed" );
    self endon( #"death" );
    var_dd280264802c2ca0 = get_exfil_center();
    var_f007eff7d8f8c628 = 0;
    
    while ( true )
    {
        if ( !isvector( var_dd280264802c2ca0 ) )
        {
            wait 1;
            continue;
        }
        
        if ( !isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( self.origin ) && !ispointonnavmesh( self.origin, self, 1, 0, 0, 1 ) && !self.var_2259f0a89be4759f )
        {
            if ( !isdefined( self.var_e608508467efd935 ) )
            {
                self.var_e608508467efd935 = gettime();
            }
            
            if ( gettime() - self.var_e608508467efd935 >= level.s_zm_exfil.var_55bdde1b903c0550 * 1000 )
            {
                var_f007eff7d8f8c628 = 1;
            }
        }
        else
        {
            self.var_e608508467efd935 = undefined;
            var_f007eff7d8f8c628 = 0;
        }
        
        if ( !( isdefined( var_dd280264802c2ca0 ) && isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.hvt_spawn_pos ) ) )
        {
            wait 1;
            continue;
        }
        
        radius_exist = level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius > 0;
        
        if ( var_f007eff7d8f8c628 || radius_exist && distancesquared( self.origin, var_dd280264802c2ca0 ) > squared( level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ) )
        {
            val::set( "zm_sat_exfil", "ignoreall", 1 );
            var_d722011cf54d3d5b = self.origin;
            function_6cfdc47bfec6eef4( "exfil_hvt_spawn_portal_vfx", var_d722011cf54d3d5b );
            playsoundatpos( var_d722011cf54d3d5b, #"hash_cc140a598e5d2f19" );
            self forceteleport( level.s_zm_exfil.var_d867cc41c15a2fd1.hvt_spawn_pos.origin, self.angles );
            function_6cfdc47bfec6eef4( "exfil_hvt_spawn_portal_vfx", level.s_zm_exfil.var_d867cc41c15a2fd1.hvt_spawn_pos.origin );
            playsoundatpos( level.s_zm_exfil.var_d867cc41c15a2fd1.hvt_spawn_pos.origin, #"hash_cc140a598e5d2f19" );
            thread function_54552c8dec18df8e();
            
            if ( !callback::exists( "on_zombie_ai_damaged", &function_4f66184920328a46 ) )
            {
                callback::add( "on_zombie_ai_damaged", &function_4f66184920328a46 );
            }
            
            if ( var_f007eff7d8f8c628 )
            {
                self.var_e608508467efd935 = undefined;
                var_f007eff7d8f8c628 = 0;
            }
        }
        
        wait 1;
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x4e599e8d, Offset: 0x56f5
// Size: 0x3a
function function_4f66184920328a46( params )
{
    val::reset( "zm_sat_exfil", "ignoreall" );
    self notify( #"hash_9e180b1a8a3e8efa" );
    callback::remove( "on_zombie_ai_damaged", &function_4f66184920328a46 );
}

// Namespace zm_exfil_sat
// Params 0, eflags: 0xc
// Checksum 0xd6958728, Offset: 0x5737
// Size: 0x14a
function private function_54552c8dec18df8e()
{
    self notify( #"hash_442fe48599497eef" );
    self endon( #"hash_442fe48599497eef" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_9e180b1a8a3e8efa" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) && isalive( player ) && distancesquared( player.origin, get_exfil_center() ) < squared( level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius * 1.5 ) )
            {
                val::reset( "zm_sat_exfil", "ignoreall" );
                callback::remove( "on_zombie_ai_damaged", &function_4f66184920328a46 );
                self notify( #"hash_9e180b1a8a3e8efa" );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x2b49fa4f, Offset: 0x5889
// Size: 0x6b6
function function_42e7aa7b635e7cd()
{
    level endon( #"game_ended" );
    level endon( #"exfil_escape_step_start" );
    level endon( #"exfil_failed" );
    level.s_zm_exfil.var_65fa64827d570601 = level.var_a009ab14ee0d3223.var_63a0ca44b877a390 ?? 40;
    round_number = zm_round_logic::get_rb_round_number();
    level.s_zm_exfil.spawned_zombies = [];
    var_633925332b78b69b = 0;
    var_c4367792a95ab0dc = 0;
    var_648d02accc079541 = level.s_zm_exfil.var_648d02accc079541 + level.s_zm_exfil.var_f5327ec3103427b5 * ( ( level.s_zm_exfil.a_players_accepted.size ?? 1 ) - 1 );
    zm_round_spawning::function_7dc7e5157b1cdad1( level.s_zm_exfil.var_65fa64827d570601 - var_648d02accc079541 );
    
    if ( round_number > level.s_zm_exfil.var_de2b84d676c3afec )
    {
        var_633925332b78b69b += level.s_zm_exfil.var_d3d0e039b1d275b4 * ( level.s_zm_exfil.a_players_accepted.size ?? 1 );
        var_633925332b78b69b += int( ( round_number - level.s_zm_exfil.var_de2b84d676c3afec ) / level.s_zm_exfil.var_dbe53c05a8f45aa9 ) * level.s_zm_exfil.var_6ccc7e5ec20a4d48;
        var_9dfe8005290ce017 = level.s_zm_exfil.var_bc2f90154f6bdb47 + ( level.s_zm_exfil.a_players_accepted.size ?? 1 );
        var_633925332b78b69b = clamp( var_633925332b78b69b, 1, var_9dfe8005290ce017 );
    }
    
    if ( round_number > level.s_zm_exfil.var_c3d74588ec89ed6c )
    {
        var_c4367792a95ab0dc += level.s_zm_exfil.var_528f7bd73acf7734 * ( level.s_zm_exfil.a_players_accepted.size ?? 1 );
        var_c4367792a95ab0dc += int( ( round_number - level.s_zm_exfil.var_c3d74588ec89ed6c ) / level.s_zm_exfil.var_475baef5c7628029 ) * level.s_zm_exfil.var_bdae60804c3326c8;
        var_c4367792a95ab0dc = clamp( var_c4367792a95ab0dc, 1, var_648d02accc079541 - var_633925332b78b69b );
    }
    
    local_spawned_zombies = [];
    local_spawned_zombies[ "normal" ] = [];
    local_spawned_zombies[ "armored" ] = [];
    local_spawned_zombies[ "special" ] = [];
    var_ca7f167025374d23 = gettime();
    var_7d7457c9bb67b801 = gettime();
    var_c412d18b74fd50e9 = namespace_c7157c2cd884c5d5::function_e05919b47b9a0cda( "special" );
    
    if ( isdefined( level.s_zm_exfil.var_5d36042a94f277fa ) && level.s_zm_exfil.var_5d36042a94f277fa.size != 0 )
    {
        var_c412d18b74fd50e9 = level.s_zm_exfil.var_5d36042a94f277fa;
    }
    
    while ( true )
    {
        zombies = getaiarray( "team_two_hundred" );
        level.s_zm_exfil.spawned_zombies = function_46f9072493651dc9( level.s_zm_exfil.spawned_zombies );
        
        if ( !isdefined( level.s_zm_exfil.alive_hvt ) || level.s_zm_exfil.spawned_zombies.size >= var_648d02accc079541 )
        {
            throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
            continue;
        }
        
        local_spawned_zombies[ "special" ] = function_46f9072493651dc9( local_spawned_zombies[ "special" ] );
        
        if ( local_spawned_zombies[ "special" ].size < var_633925332b78b69b && gettime() - var_ca7f167025374d23 > level.s_zm_exfil.var_e1695707c19c3d9d * 1000 )
        {
            ai_subclass = utility::array_random( var_c412d18b74fd50e9 );
            zombie = function_56add4ac2531e36b( ai_subclass );
            
            if ( isdefined( zombie ) )
            {
                /#
                    iprintlnbold( "<dev string:xe1>" );
                #/
                
                zombie zombie_utils::set_zombie_round_difficulty( round_number );
                zombie namespace_9d8e359c3b1041e5::function_b2ccfa9f49ce6938( 1 );
                local_spawned_zombies[ "special" ][ local_spawned_zombies[ "special" ].size ] = zombie;
                level.s_zm_exfil.spawned_zombies[ level.s_zm_exfil.spawned_zombies.size ] = zombie;
            }
            
            throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
            var_ca7f167025374d23 = gettime();
        }
        
        local_spawned_zombies[ "armored" ] = function_46f9072493651dc9( local_spawned_zombies[ "armored" ] );
        
        if ( local_spawned_zombies[ "armored" ].size < var_c4367792a95ab0dc && gettime() - var_7d7457c9bb67b801 > level.s_zm_exfil.var_dbfc57b46719ecfd * 1000 )
        {
            var_6c6540a282ea53da = 0;
            ai_subclass = utility::array_random( [ "zombie_base_armored_heavy", "zombie_base_armored_light" ] );
            n_spawn_count = var_c4367792a95ab0dc - local_spawned_zombies[ "armored" ].size;
            zombie = function_56add4ac2531e36b( ai_subclass );
            
            if ( isdefined( zombie ) )
            {
                /#
                    iprintlnbold( "<dev string:xfe>" );
                #/
                
                zombie zombie_utils::set_zombie_round_difficulty( round_number );
                zombie namespace_9d8e359c3b1041e5::function_b2ccfa9f49ce6938( 1 );
                zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
                local_spawned_zombies[ "armored" ][ local_spawned_zombies[ "armored" ].size ] = zombie;
                level.s_zm_exfil.spawned_zombies[ level.s_zm_exfil.spawned_zombies.size ] = zombie;
            }
            
            throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
            var_7d7457c9bb67b801 = gettime();
        }
        
        local_spawned_zombies[ "normal" ] = function_46f9072493651dc9( local_spawned_zombies[ "normal" ] );
        
        if ( local_spawned_zombies[ "normal" ].size < var_648d02accc079541 - var_c4367792a95ab0dc - var_633925332b78b69b && gettime() - var_7d7457c9bb67b801 > level.s_zm_exfil.var_dbfc57b46719ecfd * 1000 )
        {
            zombie = function_56add4ac2531e36b( "zombie_base" );
            
            if ( isdefined( zombie ) )
            {
                /#
                    iprintlnbold( "<dev string:x11b>" );
                #/
                
                zombie zombie_utils::set_zombie_round_difficulty( round_number );
                zombie namespace_9d8e359c3b1041e5::function_b2ccfa9f49ce6938( 1 );
                zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
                local_spawned_zombies[ "normal" ][ local_spawned_zombies[ "normal" ].size ] = zombie;
                level.s_zm_exfil.spawned_zombies[ level.s_zm_exfil.spawned_zombies.size ] = zombie;
            }
            
            throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
            var_7d7457c9bb67b801 = gettime();
        }
        
        throttle::throttle_wait_in_queue( level.zm_exfil_throttle, level.s_zm_exfil );
    }
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xbce6cda4, Offset: 0x5f47
// Size: 0x94
function function_56add4ac2531e36b( ai_subclass )
{
    round_number = zm_round_logic::get_rb_round_number();
    sparams = spawnstruct();
    sparams.ai_subclass = ai_subclass;
    zombies = zm_round_spawning::get_round_enemies();
    
    if ( zombies.size >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
    {
        zombie = zm_utility::function_9f6754719bfeaeb1( [ "normal" ], &function_6f926a2c91be4215, sparams );
    }
    else
    {
        zombie = function_6f926a2c91be4215( sparams );
    }
    
    return zombie;
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x4038f58d, Offset: 0x5fe4
// Size: 0xd8
function function_6f926a2c91be4215( sparams )
{
    if ( !isdefined( level.s_zm_exfil.alive_hvt ) )
    {
        return;
    }
    
    zone = zone_manager::function_90e5c3e2272b0130( level.s_zm_exfil.alive_hvt.origin );
    aitype = function_b3988325430ce242( sparams.ai_subclass );
    zombie = zone_spawner::spawn_agent( aitype, { #zones:[ zone ] } );
    
    if ( isdefined( zombie ) )
    {
        zombie val::set( "sat_exfil", "ignore_cleanup", 1 );
        zombie.ignore_enemy_count = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.b_ignore_fasttravel_jumppad = 1;
        return zombie;
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xa20c808c, Offset: 0x60c5
// Size: 0x7e
function function_10415e2a28b3e7d0()
{
    level endon( #"game_ended" );
    level endon( #"exfil_failed" );
    
    if ( issubstr( self.subclass, "zombie_viper" ) && !issubstr( self.subclass, "zombie_viper_mini" ) )
    {
        return;
    }
    
    self waittill( #"death" );
    level thread cleanup_zombie_in_radius( self.origin, 3000, 0.5 );
    level thread function_6f5d57806f5be4f0( self.origin );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xec0981a0, Offset: 0x614b
// Size: 0x638
function function_6f5d57806f5be4f0( var_30f3e8e94c1936bb )
{
    level endon( #"game_ended" );
    level utility::flag_set( "exfil_escape_step_start" );
    nearby_players = getplayersinradius( get_exfil_center() ?? ( 0, 0, 0 ), level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ?? 3000 );
    
    foreach ( nearby_player in nearby_players )
    {
        nearby_player thread zm_utility::white_screen_flash( undefined, 0.1 );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
        {
            objidpoolmanager::objective_playermask_hidefrom( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
        }
    }
    
    wait 0.1;
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        level.s_zm_exfil.var_d867cc41c15a2fd1 thread function_2291f39050adb26c();
    }
    
    if ( isdefined( var_30f3e8e94c1936bb ) )
    {
        function_6cfdc47bfec6eef4( "exfil_hvt_spawn_portal_vfx", var_30f3e8e94c1936bb );
        wait 1;
        
        if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
        {
            level.s_zm_exfil.var_d867cc41c15a2fd1 thread function_8bfa48ae01c0951b( var_30f3e8e94c1936bb + ( 0, 0, 62 ) );
            var_b76d493ca09b8dfa = get_exfil_vfx_name( "dark_energy_fly_vfx" );
            var_a1e8dfaaff769f1d = [ #"hash_a21b1287df31f23c", #"hash_2d0306a34d329805" ];
            var_9a0f3bebde6c9aed = utility::spawn_model( "tag_origin", var_30f3e8e94c1936bb + ( 0, 0, 50 ) );
            var_9a0f3bebde6c9aed thread zm_quest::function_b8743f5a9219cf9b( undefined, level.s_zm_exfil.var_d867cc41c15a2fd1.origin + ( 0, 0, 50 ), var_b76d493ca09b8dfa, undefined, undefined, undefined, undefined, var_a1e8dfaaff769f1d );
        }
    }
    
    level notify( #"exfil_escape_step_start" );
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        level.s_zm_exfil.var_d867cc41c15a2fd1.states = "exit";
        level.s_zm_exfil.var_d867cc41c15a2fd1 function_bb6c83c5d8558eb1( 1, 1, 0 );
    }
    
    foreach ( player in level.players )
    {
        player function_af50db2abe5ef508();
        
        if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
        {
            if ( function_38f731e2eb1871b0( player ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
                continue;
            }
            
            objidpoolmanager::objective_playermask_hidefrom( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, player );
        }
    }
    
    waitframe();
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
    {
        objidpoolmanager::function_de3fb937d4f45f38( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466, 100, 70 );
    }
    
    foreach ( zone_name in level.s_zm_exfil.var_2c35e1f3da109a5e )
    {
        zone_spawner::function_8a020f24a3b73c79( zone_name );
    }
    
    level thread pause_round_spawning();
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) )
    {
        objidpoolmanager::returnobjectiveid( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd );
    }
    
    if ( isdefined( level.s_zm_exfil.beam_tag ) )
    {
        level.s_zm_exfil.beam_tag delete();
    }
    
    foreach ( player in level.s_zm_exfil.a_players_accepted )
    {
        if ( zm_player::function_f37cfdf04b932a03( player, 0, 1 ) )
        {
            stopfxontagforclients( level._effect[ "energy_charged_cam_vfx" ], player, "j_head", player );
        }
    }
    
    level thread function_e3f4c8aa85b987c1( level.s_zm_exfil.exfil_time_limit );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x9f8b924c, Offset: 0x678b
// Size: 0x3f
function pause_round_spawning()
{
    level endon( #"game_ended" );
    level thread zm_round_spawning::pause_round_spawning( 1, "sat_exfil_pause_spawning" );
    wait level.s_zm_exfil.var_1d5da24652eeb2a4;
    level thread zm_round_spawning::pause_round_spawning( 0, "sat_exfil_pause_spawning" );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xf1d1056a, Offset: 0x67d2
// Size: 0x23
function function_d88f211bfba4937e()
{
    if ( utility::flag( "exfil_escape_step_start" ) )
    {
        level thread function_8a74bf56c9817af9();
        return;
    }
    
    level thread exfil_failed();
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xfc7e37f3, Offset: 0x67fd
// Size: 0x28d
function function_8a74bf56c9817af9()
{
    if ( !isdefined( level.s_zm_exfil.a_players_accepted ) || level.s_zm_exfil.a_players_accepted.size == 0 )
    {
        return;
    }
    
    var_3b04edb8419534bb = [];
    
    foreach ( player in level.s_zm_exfil.a_players_accepted )
    {
        if ( !isdefined( player ) || arraycontains( var_3b04edb8419534bb, player ) )
        {
            continue;
        }
        
        a_group_players = function_c7acd4587cb59372( player );
        
        foreach ( group_player in a_group_players )
        {
            var_3b04edb8419534bb = arraycombineunique( var_3b04edb8419534bb, [ group_player ] );
        }
        
        if ( function_f358d595dc82fb87( player ) )
        {
            var_bea62b7b989861ff = 0;
            
            foreach ( group_player in a_group_players )
            {
                if ( group_player utility::ent_flag( "sat_exfil_completed" ) || zm_player::function_f37cfdf04b932a03( group_player, 0, 0 ) )
                {
                    var_bea62b7b989861ff = 1;
                    break;
                }
            }
            
            if ( var_bea62b7b989861ff )
            {
                level thread function_29042ff5bd626104( player );
            }
            else
            {
                level thread function_7192ca3c2c335db3( player, 0 );
            }
            
            continue;
        }
        
        if ( isdefined( level.var_519fe94beba8d651 ) )
        {
            level thread [[ level.var_519fe94beba8d651 ]]( player );
            continue;
        }
        
        if ( zm_player::function_f37cfdf04b932a03( player, 0, 1 ) && !player utility::ent_flag( "sat_exfil_completed" ) )
        {
            player.var_1a98782093ca2c08 = 1;
            player utility::ent_flag_set( "sat_exfil_completed" );
            level thread function_2c9edb782b5f848d( player, 1 );
            continue;
        }
        
        level thread function_2c9edb782b5f848d( player, 0 );
    }
    
    reset_exfil();
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x67dc1f25, Offset: 0x6a92
// Size: 0x4f
function private function_c7acd4587cb59372( player )
{
    a_group_players = [ player ];
    
    if ( player issplitscreenplayer() )
    {
        var_1f0d6d55fe7c62ec = player getothersplitscreenplayer();
        
        if ( isdefined( var_1f0d6d55fe7c62ec ) )
        {
            a_group_players = arraycombineunique( a_group_players, [ var_1f0d6d55fe7c62ec ] );
        }
    }
    
    return a_group_players;
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x4a8af33, Offset: 0x6aea
// Size: 0xb0, Type: bool
function private function_e92b59d8239c5e75( player )
{
    a_group_players = function_c7acd4587cb59372( player );
    
    if ( a_group_players.size != level.players.size )
    {
        return false;
    }
    
    foreach ( level_player in level.players )
    {
        if ( !arraycontains( a_group_players, level_player ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0xea9ad3a5, Offset: 0x6ba3
// Size: 0xca
function private function_96ab27962efdc07b( player )
{
    if ( !function_f358d595dc82fb87( player ) )
    {
        return [ player ];
    }
    
    if ( !isdefined( level.s_zm_exfil.a_players_accepted ) )
    {
        var_8e8c0a4770bd595c = [ player ];
        var_1f0d6d55fe7c62ec = player getothersplitscreenplayer();
        
        if ( var_1f0d6d55fe7c62ec && function_7ec0cb7ae7a3ff70( var_1f0d6d55fe7c62ec ) )
        {
            var_8e8c0a4770bd595c = arraycombineunique( var_8e8c0a4770bd595c, [ var_1f0d6d55fe7c62ec ] );
        }
        
        return var_8e8c0a4770bd595c;
    }
    
    a_group_players = [ player ];
    var_1f0d6d55fe7c62ec = player getothersplitscreenplayer();
    
    if ( var_1f0d6d55fe7c62ec && arraycontains( level.s_zm_exfil.a_players_accepted, var_1f0d6d55fe7c62ec ) )
    {
        a_group_players = arraycombineunique( a_group_players, [ var_1f0d6d55fe7c62ec ] );
    }
    
    return a_group_players;
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x179b76ea, Offset: 0x6c76
// Size: 0x12
function private function_f358d595dc82fb87( player )
{
    return player issplitscreenplayer();
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x95747053, Offset: 0x6c91
// Size: 0x21, Type: bool
function private function_7ec0cb7ae7a3ff70( player )
{
    return isalive( player ) || player.inlaststand;
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x8412c28c, Offset: 0x6cbb
// Size: 0x3b, Type: bool
function private function_e9d898b8eaf79749( player )
{
    return !function_f358d595dc82fb87( player ) || player == level.s_zm_exfil.activator || function_7ec0cb7ae7a3ff70( player );
}

// Namespace zm_exfil_sat
// Params 0, eflags: 0x4
// Checksum 0xbd85eb08, Offset: 0x6cff
// Size: 0x6e
function private function_4d8cfb99e941e86c()
{
    activator = level.s_zm_exfil.activator;
    
    if ( !activator || !function_f358d595dc82fb87( activator ) )
    {
        return;
    }
    
    partner = activator getothersplitscreenplayer();
    
    if ( !partner )
    {
        return;
    }
    
    if ( isalive( partner ) || partner.inlaststand )
    {
        level thread function_a3e72946f92db23f( partner );
    }
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x37f127b9, Offset: 0x6d75
// Size: 0x139
function private function_b5a8500a6a96fbd4( a_players_accepted )
{
    var_356fd2b0f8805642 = [];
    
    foreach ( player in a_players_accepted )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !function_e9d898b8eaf79749( player ) )
        {
            continue;
        }
        
        var_356fd2b0f8805642 = arraycombineunique( var_356fd2b0f8805642, [ player ] );
        
        foreach ( group_player in function_c7acd4587cb59372( player ) )
        {
            if ( group_player == player || function_7ec0cb7ae7a3ff70( group_player ) )
            {
                var_356fd2b0f8805642 = arraycombineunique( var_356fd2b0f8805642, [ group_player ] );
            }
        }
    }
    
    return var_356fd2b0f8805642;
}

// Namespace zm_exfil_sat
// Params 3, eflags: 0x4
// Checksum 0xf3f66a3d, Offset: 0x6eb7
// Size: 0xc4
function private function_7192ca3c2c335db3( player, var_6b7ddb30cb82d43, b_leave_party )
{
    foreach ( group_player in function_c7acd4587cb59372( player ) )
    {
        if ( !isdefined( group_player ) )
        {
            continue;
        }
        
        if ( var_6b7ddb30cb82d43 )
        {
            group_player.var_1a98782093ca2c08 = 1;
            group_player utility::ent_flag_set( "sat_exfil_completed" );
        }
        
        level thread function_2c9edb782b5f848d( group_player, var_6b7ddb30cb82d43, b_leave_party );
    }
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0x6d56352e, Offset: 0x6f83
// Size: 0x141
function function_29042ff5bd626104( player, b_leave_party )
{
    if ( !level.s_zm_exfil.b_all_players_accepted && function_e92b59d8239c5e75( player ) )
    {
        level.s_zm_exfil.b_all_players_accepted = 1;
    }
    
    if ( function_f358d595dc82fb87( player ) )
    {
        if ( isdefined( level.var_519fe94beba8d651 ) )
        {
            foreach ( group_player in function_96ab27962efdc07b( player ) )
            {
                if ( isdefined( group_player ) )
                {
                    level thread [[ level.var_519fe94beba8d651 ]]( group_player );
                }
            }
            
            return;
        }
        
        level thread function_7192ca3c2c335db3( player, 1, b_leave_party );
        return;
    }
    
    if ( isdefined( level.var_519fe94beba8d651 ) )
    {
        level thread [[ level.var_519fe94beba8d651 ]]( player );
        return;
    }
    
    player.var_1a98782093ca2c08 = 1;
    player utility::ent_flag_set( "sat_exfil_completed" );
    level thread function_2c9edb782b5f848d( player, 1, b_leave_party );
}

// Namespace zm_exfil_sat
// Params 2
// Checksum 0x864c4da, Offset: 0x70cc
// Size: 0x23c
function function_cc99e9d2d4cb0837( var_9d6a772a7881a455, b_leave_party )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    val::reset_all( "quest_final_exfil" );
    
    if ( isdefined( self ) && self ishost() )
    {
        return;
    }
    
    self setclientomnvar( "post_game_state", 20 );
    winner = var_9d6a772a7881a455 ? "allies" : "axis";
    level thread gamelogic_zm::updatematchbonusscores( winner, self );
    self notify( #"give_match_bonus" );
    wait 1;
    spawnpoint = spawnstruct();
    spawnpoint.origin = self.origin;
    spawnpoint.angles = self.angles;
    
    if ( isalive( self ) && arraycontains( level.teamdata[ self.team ][ "alivePlayers" ], self ) )
    {
        playerlogic::removefromalivecount();
        teams::validatealivecount( "extract", self.team, self );
        thread playerlogic::spawnspectator( spawnpoint.origin, spawnpoint.angles, 1 );
    }
    
    self freezecontrols( 1 );
    self playerhide();
    gamescore::updateplacement( [ self ] );
    gamelogic_zm::function_442747bb1b929abf( self );
    gamelogic_zm::function_390d913e65520bec( self );
    gamelogic_zm::updateplayerleaderboardstats();
    matchdata::function_5a1951caa8fc2b02( self );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setclientdvar( @"ui_opensummary", 1 );
    self setclientomnvar( "post_game_state", 5 );
    
    if ( var_9d6a772a7881a455 )
    {
        thread hud_message::teamoutcomenotify( self.team, 0, game[ "end_reason" ][ "objective_completed" ] );
    }
    else
    {
        thread hud_message::teamoutcomenotify( self.team, 0, game[ "end_reason" ][ "objective_failed" ] );
    }
    
    wait 5;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( var_9d6a772a7881a455 )
    {
        if ( b_leave_party )
        {
            kick( self getentitynumber(), &"hash_5090362a3211b839" );
        }
        else
        {
            kick( self getentitynumber(), &"hash_24f839b6ced13e47" );
        }
        
        return;
    }
    
    if ( b_leave_party )
    {
        kick( self getentitynumber(), &"hash_6300447b45ca0c45" );
        return;
    }
    
    kick( self getentitynumber(), &"hash_15041e9cf312eeb" );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0x48eab6f3, Offset: 0x7310
// Size: 0xd0
function function_8f261015e4f861ae( var_9d6a772a7881a455 )
{
    self endon( #"disconnect" );
    
    if ( var_9d6a772a7881a455 )
    {
        callback::add( #"player_damaged", &keep_player_alive );
    }
    
    self playlocalsound( #"hash_5e8a994a614cdfa9" );
    level musicbank_utility::function_4f253fd35ec68cbc( self, #"exfil" );
    self setsoundsubmix( "cer_zm_rbz_endgame" );
    zm_quest::function_9983e3b5a8247550( 0.5, 1 );
    thread zm_quest::function_6d1da30199c231db( 0.5 );
    self setclientomnvar( "post_game_state", 1 );
    
    if ( var_9d6a772a7881a455 )
    {
        self setclientomnvar( "ui_dmz_extract_successful", 1 );
    }
    
    self setclientomnvar( "ui_br_squad_eliminated_active", 1 );
    
    if ( var_9d6a772a7881a455 )
    {
        self playlocalsound( #"hash_6b0841301cd2bd0d" );
    }
    else
    {
        self playlocalsound( #"hash_38bb00fcb53eb873" );
    }
    
    wait 1.75;
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xd4b9e5a0, Offset: 0x73e8
// Size: 0x7d4
function exfil_failed()
{
    level endon( #"game_ended" );
    level notify( #"exfil_failed" );
    
    if ( level.b_zm_game_over )
    {
        return;
    }
    
    if ( !level.s_zm_exfil.b_all_players_accepted )
    {
        nearby_players = getplayersinradius( get_exfil_center() ?? ( 0, 0, 0 ), level.s_zm_exfil.var_d867cc41c15a2fd1.exfil_radius ?? 3000 );
        
        foreach ( nearby_player in nearby_players )
        {
            nearby_player thread zm_utility::white_screen_flash( undefined, 0.5 );
        }
    }
    
    if ( isdefined( level.s_zm_exfil.beam_tag ) )
    {
        level.s_zm_exfil.beam_tag delete();
    }
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd ) )
    {
        objidpoolmanager::returnobjectiveid( level.s_zm_exfil.var_d867cc41c15a2fd1.var_252e8e6c9dc02edd );
    }
    
    if ( !level.s_zm_exfil.b_all_players_accepted )
    {
        level thread cleanup_zombie_in_radius( level.s_zm_exfil.var_d867cc41c15a2fd1.origin, 5000 );
    }
    
    wait 0.5;
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1 ) )
    {
        level.s_zm_exfil.var_d867cc41c15a2fd1 thread function_2291f39050adb26c();
    }
    
    foreach ( zone_name in level.s_zm_exfil.var_2c35e1f3da109a5e )
    {
        zone_spawner::function_8a020f24a3b73c79( zone_name );
    }
    
    if ( !level.s_zm_exfil.b_all_players_accepted )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( level.s_zm_exfil.a_players_accepted ) && isdefined( player ) && arraycontains( level.s_zm_exfil.a_players_accepted, player ) )
            {
                if ( zm_player::function_f37cfdf04b932a03( player, 0, 1 ) )
                {
                    stopfxontagforclients( level._effect[ "energy_charged_cam_vfx" ], player, "j_head", player );
                    wait 0.1;
                    
                    if ( isdefined( player ) )
                    {
                        player suicide();
                    }
                }
            }
        }
        
        wait 1;
        var_3b04edb8419534bb = [];
        
        foreach ( player in level.s_zm_exfil.a_players_accepted )
        {
            if ( !isdefined( player ) || arraycontains( var_3b04edb8419534bb, player ) )
            {
                continue;
            }
            
            foreach ( group_player in function_c7acd4587cb59372( player ) )
            {
                if ( isdefined( group_player ) )
                {
                    var_3b04edb8419534bb = arraycombineunique( var_3b04edb8419534bb, [ group_player ] );
                    
                    if ( isdefined( group_player.white_screen_overlay ) )
                    {
                        group_player notify( #"cutscene_cleanup" );
                        group_player notify( #"hash_a71f322fc70ec58c" );
                        group_player.white_screen_overlay destroy();
                    }
                }
            }
            
            level thread function_7192ca3c2c335db3( player, 0 );
        }
        
        level thread reset_exfil();
        return;
    }
    
    var_cadcf850a34a7e32 = level.s_zm_exfil.activator;
    
    if ( !isdefined( var_cadcf850a34a7e32 ) )
    {
        var_cadcf850a34a7e32 = level.players[ 0 ];
    }
    
    foreach ( player in level.players )
    {
        player notify( #"cutscene_cleanup" );
        player val::set( "zm_death", "ignoreme", 1 );
        player val::set( "zm_death", "allow_battlechatter_vo", 0 );
        player val::set( "zm_death", "freezecontrols", 1 );
        player lower_message::clearlowermessages();
        player killstreaks::clearkillstreaks();
        
        if ( isdefined( player ) && player != var_cadcf850a34a7e32 )
        {
            player childthread zm_laststand::zm_laststand_fade_before_game_over_scene( player != var_cadcf850a34a7e32, "game_over_scene_fade_in" );
        }
    }
    
    level notify( #"end_round_logic" );
    zm_exfil::function_e6ec4f11056ffdc7();
    level.b_zm_game_over = 1;
    level utility::flag_set( "zm_game_over" );
    level thread end_game();
    overlord::function_2fb527a541b257( 0 );
    level thread zm_laststand::cleanup_zombie_intel_sound();
    level utility::flag_clear( "exfil_active" );
    setomnvarforallclients( "post_game_state", 20 );
    
    if ( utility::flag( "begin_round_logic" ) && isdefined( var_cadcf850a34a7e32 ) )
    {
        level.var_1b2bc7c44eeecd0b = level.s_zm_exfil.alive_hvt;
        override_game_over_scene = zm_laststand::function_5189df1acc69397e( level.s_zm_exfil.current_hvt_type );
        var_cc0ee74b868e5b05 = var_cadcf850a34a7e32 zm_laststand::function_400be99570de9f41( override_game_over_scene );
        var_cadcf850a34a7e32 zm_laststand::play_game_over_scene( var_cc0ee74b868e5b05, override_game_over_scene.scenebundle );
    }
    
    level utility::flag_set( "sat_exfil_game_over_scene_played" );
    level thread zm_vo::vo_say_announcer( zm_vo::function_157326aa0e824343( #"game_over" ) );
    wait 0.25;
    
    foreach ( player in level.players )
    {
        player.br_iseliminated = 1;
        player br_public::function_7813786b92d850ff( 1 );
        player br_utility::updateplayereliminatedomnvar();
        player playlocalsound( #"hash_58071393496dd03e" );
        player thread playerlogic::spawnintermission( undefined, undefined, 0 );
        player notify( #"game_over_scene_fade_in" );
    }
    
    setomnvarforallclients( "ui_br_squad_eliminated_active", 1 );
    level notify( #"zm_end_game_notify" );
    level thread reset_exfil();
}

// Namespace zm_exfil_sat
// Params 0, eflags: 0x4
// Checksum 0x691d3be7, Offset: 0x7bc4
// Size: 0x35
function private end_game()
{
    level endon( #"game_ended" );
    utility::waittill_notify_or_timeout( "zm_end_game_notify", 20 );
    thread gamelogic_zm::endgame( "none", game[ "end_reason" ][ "mp_faction_eliminated" ] );
}

// Namespace zm_exfil_sat
// Params 3
// Checksum 0x4f9155f8, Offset: 0x7c01
// Size: 0x16e
function function_2c9edb782b5f848d( player, var_6b7ddb30cb82d43, b_leave_party )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( player.var_472e2d036e427d3b )
    {
        return;
    }
    
    player.var_472e2d036e427d3b = 1;
    
    if ( var_6b7ddb30cb82d43 )
    {
        if ( getdvarint( @"hash_9e65802ccf655e9b", 0 ) <= 0 )
        {
            zm_player::save_player_loadout( player );
        }
        
        level callback::callback( "zm_exfil_success", { #a_exfil_players:[ player ] } );
    }
    else
    {
        level callback::callback( "zm_exfil_failure", { #a_exfil_players:[ player ] } );
    }
    
    if ( utility::issharedfuncdefined( #"zm_sat_exfil", #"hash_47c6e605071f9f2a" ) )
    {
        utility::callsharedfunc( #"zm_sat_exfil", #"hash_47c6e605071f9f2a" );
    }
    
    if ( !isalive( player ) )
    {
        player.br_iseliminated = 1;
        player br_public::function_7813786b92d850ff( 1 );
        player br_utility::updateplayereliminatedomnvar();
        player playlocalsound( #"hash_58071393496dd03e" );
        player thread playerlogic::spawnintermission( undefined, undefined, 0 );
    }
    
    player val::set( "zm_exfil", "ignoreme", 1 );
    player val::set( "zm_death", "allow_battlechatter_vo", 0 );
    player function_8f261015e4f861ae( var_6b7ddb30cb82d43 );
    player thread function_cc99e9d2d4cb0837( var_6b7ddb30cb82d43, b_leave_party );
}

// Namespace zm_exfil_sat
// Params 3
// Checksum 0x6312cd5a, Offset: 0x7d77
// Size: 0x2f9
function cleanup_zombie_in_radius( position, radius, start_delay )
{
    level endon( #"game_ended" );
    
    if ( isdefined( start_delay ) )
    {
        wait start_delay;
    }
    
    if ( !isdefined( position ) )
    {
        return;
    }
    
    function_6cfdc47bfec6eef4( "dark_energy_explosion", position );
    
    if ( level.s_zm_exfil.spawned_zombies.size )
    {
        level.s_zm_exfil.spawned_zombies = function_46f9072493651dc9( level.s_zm_exfil.spawned_zombies );
        
        foreach ( zombie in level.s_zm_exfil.spawned_zombies )
        {
            if ( isalive( zombie ) )
            {
                if ( zombie.magic_bullet_shield )
                {
                    zombie ai::stop_magic_bullet_shield();
                }
                
                if ( distancesquared( zombie.origin, position ) < squared( radius ) )
                {
                    delay_time = distance( zombie.origin, position ) / 1000;
                    zombie thread utility::delaythread( delay_time, &kill_zombie );
                    continue;
                }
                
                zombie kill();
            }
        }
    }
    
    if ( isalive( level.s_zm_exfil.alive_hvt ) )
    {
        if ( isdefined( level.s_zm_exfil.alive_hvt ) && issubstr( level.s_zm_exfil.alive_hvt.subclass, "zombie_viper" ) && !issubstr( level.s_zm_exfil.alive_hvt.subclass, "zombie_viper_mini" ) )
        {
            level.s_zm_exfil.alive_hvt.var_c3746c711044489d = 1;
        }
        
        level.s_zm_exfil.alive_hvt kill();
    }
    
    zombies = getaiarrayinradius( position, radius, "team_two_hundred" );
    zombies = function_46f9072493651dc9( zombies );
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) )
        {
            if ( zombie.magic_bullet_shield )
            {
                zombie ai::stop_magic_bullet_shield();
            }
            
            delay_time = distance( zombie.origin, position ) / 1000;
            zombie thread utility::delaythread( delay_time, &function_44f5bec4abb163f1 );
        }
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x80a49842, Offset: 0x8078
// Size: 0x121
function function_44f5bec4abb163f1()
{
    zom = self;
    
    if ( zom.var_698cf8d8d4a8cbb9 )
    {
        if ( !zom val::get( "damageshield" ) )
        {
            zom.nuked = 1;
            zom.full_gib = 1;
            zom.forceannihilate = 1;
            zom.no_powerups = 1;
            zom.var_a13bed1ac47e1b2c = 1;
            zom kill();
        }
        
        return;
    }
    
    if ( zom.aicategory != "normal" )
    {
        if ( zom.aicategory == "hvt" || zom.aicategory == "boss" )
        {
            return;
        }
        
        zom zm_cleanup_manager::function_44f5bec4abb163f1( undefined, 1 );
        return;
    }
    
    zom.nuked = 1;
    zom.full_gib = 1;
    zom.forceannihilate = 1;
    zom.no_powerups = 1;
    zom.var_a13bed1ac47e1b2c = 1;
    zom zm_cleanup_manager::function_dd62e2042418b7e5();
    zom kill();
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xcd2d1b2b, Offset: 0x81a1
// Size: 0x10
function kill_zombie()
{
    if ( isalive( self ) )
    {
        self kill();
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xca28008, Offset: 0x81b9
// Size: 0x2c2
function reset_exfil()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.scriptable ) )
    {
        level.s_zm_exfil.var_d867cc41c15a2fd1.scriptable utility::function_32b24db3127bff40( "anim", "close" );
    }
    
    level notify( #"exfil_reset" );
    level musicbank_utility::function_4f253fd35ec68cbc( level.players, #"exfil" );
    callback::remove( #"player_death", &function_16ec67c3f3ee8f87 );
    callback::remove( #"player_disconnect", &function_16ec67c3f3ee8f87 );
    callback::remove( "on_zombie_viper_eject", &track_zombie_viper_mini );
    
    if ( isdefined( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) && !objidpoolmanager::function_fb05d646a96ed99e( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 ) )
    {
        objidpoolmanager::returnobjectiveid( level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 );
        level.s_zm_exfil.var_d867cc41c15a2fd1.var_c6883f07ae9a466 = undefined;
    }
    
    function_e6d25909c7962ebf( "disable" );
    zm_quest::function_a62dc5b7c911530();
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player function_9515b3c2d065c86b();
            player utility::ent_flag_clear( "showed_exfil_hud_splash" );
            player utility::ent_flag_clear( "show_exfil_hud" );
            player utility::ent_flag_clear( "showed_reach_exfil_hud" );
            player utility::ent_flag_clear( "showed_kill_hvt_hud" );
        }
    }
    
    level utility::flag_clear( "exfil_start" );
    level utility::flag_clear( "exfil_active" );
    level utility::flag_clear( "exfil_kill_hvt_start" );
    level utility::flag_clear( "exfil_escape_step_start" );
    
    if ( utility::flag( "sat_exfil_completed" ) )
    {
        utility::flag_clear( "sat_exfil_completed" );
    }
    
    level.var_916aae8097d37e9e = undefined;
    zm_round_spawning::function_2f0d03da6725e4b9();
    level.s_zm_exfil.a_players_accepted = undefined;
    level.s_zm_exfil.var_d867cc41c15a2fd1 = undefined;
    level.s_zm_exfil.b_all_players_accepted = 0;
    setomnvar( "ui_is_exfil_available", 0 );
    setomnvar( "ui_is_exfil_active", 0 );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xa3301ab4, Offset: 0x8483
// Size: 0x158
function function_32996f57d7652cac()
{
    self notify( #"hash_9caa96948a3851d2" );
    self endon( #"hash_9caa96948a3851d2" );
    level endon( #"game_ended" );
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    wait 1;
    
    if ( isdefined( level.players ) && level.players.size > 0 )
    {
        var_213f9bfe19ad2d4d = 0;
        
        foreach ( player in level.players )
        {
            if ( zm_player::function_f37cfdf04b932a03( player, 0, 1 ) )
            {
                var_213f9bfe19ad2d4d = 1;
                break;
            }
        }
        
        if ( var_213f9bfe19ad2d4d )
        {
            return;
        }
    }
    
    if ( level.b_zm_game_over || level.gameended )
    {
        return;
    }
    
    if ( !level utility::flag( "sat_exfil_game_over_scene_played" ) )
    {
        exfil_failed();
    }
    
    level.b_zm_game_over = 1;
    level utility::flag_set( "zm_game_over" );
    thread gamelogic_zm::endgame( "none", game[ "end_reason" ][ "mp_faction_eliminated" ] );
}

// Namespace zm_exfil_sat
// Params 1
// Checksum 0xa5fcd109, Offset: 0x85e3
// Size: 0xbf
function set_exfil_dome( radius )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    spawn_pos = self.override_exfil_center.origin ?? self.origin;
    self.scriptable_dome = spawnscriptable( level.s_zm_exfil.var_9443086510150b8e, spawn_pos );
    waitframe();
    str_state = string( radius );
    
    if ( level utility::flag( "use_custom_exfil_vfx" ) && self.scriptable_dome getscriptableparthasstate( "area_fx", str_state + "_custom" ) )
    {
        str_state += "_custom";
    }
    
    self.scriptable_dome utility::function_32b24db3127bff40( "area_fx", str_state );
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x5d9d6ecf, Offset: 0x86aa
// Size: 0x1d
function function_2291f39050adb26c()
{
    if ( isdefined( self.scriptable_dome ) )
    {
        self.scriptable_dome freescriptable();
    }
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0xf750ca65, Offset: 0x86cf
// Size: 0x49, Type: bool
function get_exfil_center()
{
    return level.s_zm_exfil.var_d867cc41c15a2fd1.override_exfil_center.origin ?? level.s_zm_exfil.var_d867cc41c15a2fd1.origin;
}

// Namespace zm_exfil_sat
// Params 0
// Checksum 0x74467f14, Offset: 0x8721
// Size: 0x1c, Type: bool
function is_exfil_starting()
{
    return utility::flag( "zm_vote_active" ) || utility::flag( "exfil_start" );
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x8b18abf, Offset: 0x8746
// Size: 0x46
function private on_exfil_disabled( feature )
{
    s_exfil = feature;
    s_exfil.last_state = s_exfil.states;
    function_e6d25909c7962ebf( "disable" );
    s_exfil thread function_52d6f3b3ec113558();
}

// Namespace zm_exfil_sat
// Params 1, eflags: 0x4
// Checksum 0x5da5c13, Offset: 0x8794
// Size: 0x5f
function private on_exfil_enabled( feature )
{
    s_exfil = feature;
    
    if ( !utility::flag( "exfil_escape_step_start" ) )
    {
        assert( s_exfil.last_state, "<dev string:x137>" + s_exfil.states );
        function_e6d25909c7962ebf( s_exfil.last_state );
    }
}

// Namespace zm_exfil_sat
// Params 0, eflags: 0x4
// Checksum 0x499380f7, Offset: 0x87fb
// Size: 0x3d
function private function_52d6f3b3ec113558()
{
    self endon( #"content_manager_feature_enabled" );
    utility::flag_wait( "exfil_escape_step_start" );
    
    while ( self.states != "exit" )
    {
        waitframe();
    }
    
    content_manager::enable_feature( self, "exfil" );
}

/#

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x97a3fae3, Offset: 0x8840
    // Size: 0x14c, Type: dev
    function init_sat_exfil_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x16c>" );
        devgui::add_devgui_func( "<dev string:x17a>", "<dev string:x17a>", &function_4143812c60f4d351 );
        devgui::add_devgui_func( "<dev string:x195>", "<dev string:x195>", &function_f4b9e583ff03e0b8 );
        devgui::add_devgui_func( "<dev string:x1b1>", "<dev string:x1c6>", &function_71fa564f4dc3f49b );
        devgui::add_devgui_func( "<dev string:x1db>", "<dev string:x1db>", &test_phone_ring );
        devgui::add_devgui_func( "<dev string:x1eb>", "<dev string:x1eb>", &function_4909f0012d3ddaf );
        devgui::add_devgui_func( "<dev string:x1fd>", "<dev string:x1fd>", &test_end_game );
        devgui::add_devgui_func( "<dev string:x206>", "<dev string:x206>", &function_d7cafb3dfb885bbe );
        devgui::add_devgui_func( "<dev string:x21e>", "<dev string:x21e>", &function_bbc1a0349fa56aa );
        devgui::function_cd4e263c1f3018ae( "<dev string:x239>", "<dev string:x256>", &function_d2b47ba829ea2be8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x273>", "<dev string:x291>", &function_d2b47ba829ea2be8 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2af>", "<dev string:x2c3>", &function_5e7a82b5ff72dc0a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2d7>", "<dev string:x2ec>", &function_5e7a82b5ff72dc0a );
        devgui::function_cd4e263c1f3018ae( "<dev string:x301>", "<dev string:x316>", &function_5e7a82b5ff72dc0a );
        devgui::add_devgui_func( "<dev string:x32b>", "<dev string:x32b>", &function_58aadf1b05709fe0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x7c692e16, Offset: 0x8994
    // Size: 0x97, Type: dev
    function function_58aadf1b05709fe0()
    {
        foreach ( sub_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
        {
            sub_exfil set_exfil_dome( string( sub_exfil.exfil_radius ) );
        }
    }

    // Namespace zm_exfil_sat
    // Params 1
    // Checksum 0xd809c279, Offset: 0x8a33
    // Size: 0x95, Type: dev
    function function_5e7a82b5ff72dc0a( params )
    {
        foreach ( sub_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
        {
            sub_exfil set_exfil_dome( params[ 0 ] );
        }
    }

    // Namespace zm_exfil_sat
    // Params 1
    // Checksum 0xd0f16b17, Offset: 0x8ad0
    // Size: 0xaf, Type: dev
    function function_d2b47ba829ea2be8( params )
    {
        state = params[ 0 ];
        
        foreach ( s_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
        {
            s_exfil.scriptable utility::function_32b24db3127bff40( "<dev string:x342>", state );
        }
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0xb46f2edf, Offset: 0x8b87
    // Size: 0x10, Type: dev
    function function_bbc1a0349fa56aa()
    {
        level.var_7e97ab6e80e19ffa = 15;
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x89efbe3a, Offset: 0x8b9f
    // Size: 0x34, Type: dev
    function function_d7cafb3dfb885bbe()
    {
        if ( isdefined( level.s_zm_exfil.alive_hvt ) )
        {
            level.s_zm_exfil.alive_hvt kill();
        }
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0xf0d92d0f, Offset: 0x8bdb
    // Size: 0x2d, Type: dev
    function test_end_game()
    {
        level.players[ 0 ] thread function_8f261015e4f861ae( 1 );
        level.players[ 0 ] thread function_cc99e9d2d4cb0837( 1 );
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x8c45adfc, Offset: 0x8c10
    // Size: 0xaf, Type: dev
    function function_71fa564f4dc3f49b()
    {
        level.players[ 0 ] zm_quest::function_fba942a1cfd85f5d( 1, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
        level.players[ 0 ] zm_quest::function_cd1f2fee4749fb0a( 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
        level.players[ 0 ] zm_quest::function_612a9ad0db22c29c( level.s_zm_exfil.kill_hvt_time_limit, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
        level.players[ 0 ] zm_quest::function_194bde735238c397( 0, 0, #"sat_exfil", #"hash_9ea04767c4b7c4dd" );
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x6381dc00, Offset: 0x8cc7
    // Size: 0x19, Type: dev
    function function_4909f0012d3ddaf()
    {
        level.players[ 0 ] function_8f261015e4f861ae( 1 );
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x74447da4, Offset: 0x8ce8
    // Size: 0x24, Type: dev
    function test_phone_ring()
    {
        playsoundatpos( level.players[ 0 ].origin, "<dev string:x1db>" );
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x952a0caf, Offset: 0x8d14
    // Size: 0x1a, Type: dev
    function function_4143812c60f4d351()
    {
        function_e6d25909c7962ebf( "<dev string:x347>" );
        zm_exfil_objective_icon( 1 );
    }

    // Namespace zm_exfil_sat
    // Params 0
    // Checksum 0x9c4f30ee, Offset: 0x8d36
    // Size: 0x19, Type: dev
    function function_f4b9e583ff03e0b8()
    {
        function_e6d25909c7962ebf( "<dev string:x351>" );
        zm_exfil_objective_icon( 0 );
    }

#/
