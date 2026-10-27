// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds.gsc  (hash_4d53992d3c41e0f5.gscc) (size: 78751 Bytes / 0x1339f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1080d06 (17304838)
// size ...... 78751 (0x1339f)
// includes .. 44  (offset: 0x11d1f)
// strings ... 261 (offset: 0x11e7f)
// dev strs .. 99  (offset: 0x12ec7)
// exports ... 173 (offset: 0xcaf3)
// cseg ...... 0x14ad + 0xb646 (0xcaf3)
// imports ... 416 (offset: 0xe5fb)
// animtree1 . 0   (offset: 0x1339f)
// animtree2 . 0   (offset: 0x1339f)
#using script_16ea1b94f0f381b3;
#using script_59336152890f5f73;
#using script_750a10afe6d2ba0d;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\content_manager;
#using scripts\mp\crafting_table;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;
#using scripts\mp\purchasemenu;
#using scripts\mp\wallbuy;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds_create_script;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_mq_quest;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_murder_holes;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_pap_quest;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ww_quest;
#using scripts\mp\zm\spawners\agent_spawner;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\aitypes\zm_zombie_diana;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_assault_rounds;

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x5
// Checksum 0x177c75a4, Offset: 0x14cb
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"assault_rounds", #"murder_holes", &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x97a3ac32, Offset: 0x14f8
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x6279c5e3, Offset: 0x1502
// Size: 0x294
function private postmain_init()
{
    if ( level.gametype == "zm_rb_survival" || level.gametype == "zm_rb_r_mod_survival" || level.gametype == "zm_rb_startroom" || level.gametype == "zm_rb_echo" )
    {
        return;
    }
    
    zm_sat_hornet_assault_rounds_create_script::main();
    level.ar_root = spawnstruct();
    level.ar_root.var_deacad0eb099f86e = [];
    level.ar_root.var_35233896c682d3ea = [];
    level.ar_root.num_assault_rounds = 0;
    
    if ( getdvarint( @"hash_a848de4270c1778d", 0 ) )
    {
        level.ar_root.var_5176b479e65c46e8 = 1;
    }
    
    level thread function_95dcfbba231b463();
    level.var_6f89b56853b0e818 = [ "arsenal", "crafting_table", "magicbox", "pack_a_punch", "perk_machine", "wallbuy" ];
    level thread function_3a1168fa8e7489c2();
    level.ar_root.var_816db095a80ba793 = zm_quest::function_b0a5181ebe7bb905();
    level callback::add( "special_round_start", &function_756b083806b3a9f7 );
    level callback::add( "special_round_scheduled", &function_884e8eda5f24a450 );
    level callback::add( "on_round_end", &on_round_end );
    level callback::add( #"hash_fb99f4a65a74090", &function_fcef63189bf0928b );
    level callback::add( #"content_manager_feature_enabled", &on_feature_enabled );
    level callback::add( "custom_special_round_audio_start", &function_4f757e1427505942 );
    level callback::add( "custom_special_round_audio_stop", &function_ec4a67c14916b1c2 );
    level callback::add( #"player_connect", &function_e4c72104b62bc98 );
    level callback::add( #"hash_1476c6ebca52a63f", &function_288b367d399ca826 );
    level callback::add( "force_assault_round_start", &function_756b083806b3a9f7 );
    level.ar_root.var_fbbf92f9d8d3285d = throttle::throttle_initialize( "ar_glyph_toggle", 1 );
    level utility::flag_wait( "zm_quest_initialized" );
    zm_quest::register_quest_step( #"hash_5d06d71de9a9208e", #"save_step", &function_9fa5a1a53c5d7864, undefined );
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_5d06d71de9a9208e" );
    function_835abf03a06bcd20();
    utility::registersharedfunc( "hornet_assault_round", #"hash_511c2d953fa53255", &function_bb933b778292b564 );
    
    /#
        function_98a45da36d54506c();
        namespace_a3bd843d6751814b::function_6ddfd90eb0ccc9a2();
    #/
    
    function_2f1e17e9528a7582();
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x8f03d605, Offset: 0x179e
// Size: 0x107
function private function_3a1168fa8e7489c2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( level.a_s_perk_machines ) )
        {
            foreach ( var_75385495715741fb in level.a_s_perk_machines )
            {
                if ( var_75385495715741fb.is_wunderfizz && var_75385495715741fb.mdl_perk_machine )
                {
                    level.var_6f89b56853b0e818 = [ "arsenal", "crafting_table", "magicbox", "pack_a_punch", "perk_machine_choice", "perk_machine", "wallbuy" ];
                    return;
                }
            }
        }
        
        level waittill( #"on_round_start" );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x9c917369, Offset: 0x18ad
// Size: 0x15
function function_cd788a98271f8ae()
{
    return level.ar_root.zombified_zones;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x7311d299, Offset: 0x18cb
// Size: 0x41
function function_bb933b778292b564( zone_name )
{
    if ( !zone_name )
    {
        return 0;
    }
    
    gen_zone_name = zm_utility::function_fbb7d4c98261e273( zone_name );
    return arraycontains( level.ar_root.zombified_zones, gen_zone_name );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x1ea23614, Offset: 0x1915
// Size: 0x2e
function set_assault_rounds_blocked( b_is_blocked )
{
    if ( b_is_blocked )
    {
        level utility::flag_set( "block_ar" );
        return;
    }
    
    level utility::flag_clear( "block_ar" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0xbdafde86, Offset: 0x194b
// Size: 0xe
function get_assault_rounds_blocked()
{
    return level utility::flag( "block_ar" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0x3f3e322a, Offset: 0x1962
// Size: 0x110
function private function_9fa5a1a53c5d7864( b_skipped, b_save_restored )
{
    level thread function_68bac3b569f2ef3();
    var_3c9a8b1e35b443db = 4;
    var_4515e7d337ad79b5 = 7;
    
    for ( bit_idx = var_3c9a8b1e35b443db; bit_idx < var_4515e7d337ad79b5 + 1 ; bit_idx++ )
    {
        var_8eec2edd61f6e5e4 = function_605058f6bb3e620a( #"hash_9e20059a98c546b", bit_idx );
        
        if ( var_8eec2edd61f6e5e4 )
        {
            var_e917a56fdbc933d8 = level.ar_root.sector_order[ bit_idx - level.ar_root.sector_order.size ];
            function_bb5a288577c0019c( var_e917a56fdbc933d8 );
        }
    }
    
    if ( level.ar_root.var_816db095a80ba793 && !zm_save::function_1dda3554974a999e() )
    {
        var_e917a56fdbc933d8 = utility::array_random( [ "ar_sec1", "ar_sec3" ] );
        set_preferred_sector( var_e917a56fdbc933d8 );
    }
    
    level utility::flag_set( "map_features_can_be_reloaded" );
    level waittill( #"forever" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x79e1bb15, Offset: 0x1a7a
// Size: 0xa7
function private function_68bac3b569f2ef3()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait_or_timeout( "content_manager_populated", 15 );
    var_a5fcf9e2043fc70e = 0;
    var_7e4e3ab1d6c469f0 = 3;
    
    for ( bit_idx = 0; bit_idx < var_7e4e3ab1d6c469f0 + 1 ; bit_idx++ )
    {
        var_b2cdaa2cfed80bd6 = function_605058f6bb3e620a( #"hash_9e20059a98c546b", bit_idx );
        
        if ( var_b2cdaa2cfed80bd6 )
        {
            var_e917a56fdbc933d8 = level.ar_root.sector_order[ bit_idx ];
            zombify_sector( var_e917a56fdbc933d8 );
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x790a2895, Offset: 0x1b29
// Size: 0xa4c
function private function_95dcfbba231b463()
{
    level utility::flag_wait_all( "scriptables_ready", "mh_ready" );
    a_banners = utility::getstructarray( "ar_bnr", "targetname" );
    var_4273fc80b52ed75a = utility::getstructarray( "ar_recap", "targetname" );
    level.ar_root.zombified_zones = [];
    level.ar_root.a_banners = [];
    level.ar_root.var_a65da308c81e9a4 = [];
    level.ar_root.a_trees = [];
    level.ar_root.var_2747e0528b1f176 = [];
    level.ar_root.a_first_target = [];
    level.ar_root.var_7130ff0005fdba3e = [];
    level.ar_root.var_28e4ff3f60d19060 = [];
    level.ar_root.var_66cdb027aee5520e = [];
    level.ar_root.var_605f820245431396 = [];
    level.ar_root.var_b1095616d6d59608 = [];
    level.ar_root.var_91cf84d3c024431e = [];
    level.ar_root.var_8f76e4f12f2c2efc = [];
    level.ar_root.var_af34ac5bd8ff4659 = [];
    level.ar_root.var_8a1f25351dcdc573 = [];
    level.ar_root.var_2476fef49008ba4e = [ 16, 24, 32, 40 ];
    level.ar_root.var_c6a0cb99ddd965c8 = [ 0, 1, 2, 3 ];
    level.ar_root.var_97b1121b2fca28b = [ 4, 5, 6, 7 ];
    level.ar_root.var_a686c3ff0479034e = 0;
    sector_order = [ "ar_sec1", "ar_sec2", "ar_sec3", "ar_sec4" ];
    komainu_order = [ 1, 0, 2, 3 ];
    
    for ( i = 0; i < 4 ; i++ )
    {
        level.ar_root.a_first_target[ sector_order[ i ] ] = level.murder_holes_root.var_2747e0528b1f176[ komainu_order[ i ] ].a_komainu;
        level.ar_root.var_2747e0528b1f176[ sector_order[ i ] ] = level.murder_holes_root.var_2747e0528b1f176[ komainu_order[ i ] ];
    }
    
    foreach ( struct in a_banners )
    {
        banner = spawnscriptable( %"hash_51378b2eaa60d43", struct.origin, struct.angles );
        banner setscriptablepartstate( "model", "player" );
        level.ar_root.a_banners[ level.ar_root.a_banners.size ] = banner;
        banner.navobstacle = createnavobstaclebybounds( banner.origin, ( 32, 32, 12 ), banner.angles );
        idx = int( struct.script_noteworthy );
        
        if ( !isdefined( level.ar_root.var_7130ff0005fdba3e[ sector_order[ idx ] ] ) )
        {
            level.ar_root.var_7130ff0005fdba3e[ sector_order[ idx ] ] = banner;
            var_3e47ee4971750a46 = 1;
        }
        else
        {
            main_banner = level.ar_root.var_7130ff0005fdba3e[ sector_order[ idx ] ];
            main_banner.linked_banner = banner;
            banner.linked_banner = main_banner;
        }
        
        banner.s_banner = struct;
        struct.sc_banner = banner;
        struct.var_e917a56fdbc933d8 = sector_order[ idx ];
        
        if ( var_3e47ee4971750a46 )
        {
            struct thread setup_banner_spawners();
        }
    }
    
    foreach ( struct in var_4273fc80b52ed75a )
    {
        idx = int( struct.script_noteworthy );
        level.ar_root.var_a65da308c81e9a4[ sector_order[ idx ] ] = struct;
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        var_9c2dab0b43727939 = utility::getstructarray( "ar_sec" + i + 1, "targetname" );
        level.ar_root.var_28e4ff3f60d19060[ sector_order[ i ] ] = [];
        level.ar_root.var_66cdb027aee5520e[ sector_order[ i ] ] = [];
        level.ar_root.var_605f820245431396[ sector_order[ i ] ] = [];
        level.ar_root.var_b1095616d6d59608[ sector_order[ i ] ] = [];
        
        foreach ( struct in var_9c2dab0b43727939 )
        {
            if ( struct.script_noteworthy == "1" )
            {
                level.ar_root.var_28e4ff3f60d19060[ sector_order[ i ] ][ level.ar_root.var_28e4ff3f60d19060[ sector_order[ i ] ].size ] = struct;
                function_9a3514a9def3a3c0( struct, sector_order[ i ], level.ar_root.var_605f820245431396 );
            }
            else
            {
                level.ar_root.var_66cdb027aee5520e[ sector_order[ i ] ][ level.ar_root.var_66cdb027aee5520e[ sector_order[ i ] ].size ] = struct;
                function_9a3514a9def3a3c0( struct, sector_order[ i ], level.ar_root.var_b1095616d6d59608 );
            }
            
            if ( !isdefined( struct.script_animation ) )
            {
                struct.script_animation = "spawn_hop";
            }
        }
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        a_slots = utility::getstructarray( "ar_sec" + i + 1 + "_slots", "targetname" );
        level.ar_root.var_91cf84d3c024431e[ sector_order[ i ] ] = [];
        level.ar_root.var_8f76e4f12f2c2efc[ sector_order[ i ] ] = [];
        
        foreach ( struct in a_slots )
        {
            if ( struct.script_noteworthy == "1" )
            {
                level.ar_root.var_91cf84d3c024431e[ sector_order[ i ] ][ level.ar_root.var_91cf84d3c024431e[ sector_order[ i ] ].size ] = struct;
                continue;
            }
            
            level.ar_root.var_8f76e4f12f2c2efc[ sector_order[ i ] ][ level.ar_root.var_8f76e4f12f2c2efc[ sector_order[ i ] ].size ] = struct;
        }
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        var_27fb27ba3f63a3e2 = utility::getstructarray( "ar_sec" + i + 1 + "_vtg", "targetname" );
        
        foreach ( struct in var_27fb27ba3f63a3e2 )
        {
            if ( issubstr( struct.script_noteworthy, "_1" ) )
            {
                level.ar_root.var_af34ac5bd8ff4659[ sector_order[ i ] ] = struct;
                continue;
            }
            
            level.ar_root.var_8a1f25351dcdc573[ sector_order[ i ] ] = struct;
        }
    }
    
    level.ar_root.sector_order = sector_order;
    level utility::flag_wait( "skr_init" );
    level.ar_root.a_trees[ "ar_sec1" ] = level.sakura_root.all_trees[ "zone_broken_turrets_tree" ];
    level.ar_root.a_trees[ "ar_sec2" ] = level.sakura_root.all_trees[ "zone_third_bailey_tree" ];
    level.ar_root.a_trees[ "ar_sec3" ] = level.sakura_root.all_trees[ "zone_second_bailey_tree" ];
    level.ar_root.a_trees[ "ar_sec4" ] = level.sakura_root.all_trees[ "zone_main_keep_tree" ];
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xc9cca218, Offset: 0x257d
// Size: 0xe2
function private function_9a3514a9def3a3c0( struct, sector_name, array )
{
    if ( struct.script_label == "left" )
    {
        if ( !isdefined( array[ sector_name ][ "left" ] ) )
        {
            array[ sector_name ][ "left" ] = [];
        }
        
        array[ sector_name ][ "left" ][ array[ sector_name ][ "left" ].size ] = struct;
        return;
    }
    
    if ( struct.script_label == "right" )
    {
        if ( !isdefined( array[ sector_name ][ "right" ] ) )
        {
            array[ sector_name ][ "right" ] = [];
        }
        
        array[ sector_name ][ "right" ][ array[ sector_name ][ "right" ].size ] = struct;
        return;
    }
    
    if ( !isdefined( array[ sector_name ][ "mid" ] ) )
    {
        array[ sector_name ][ "mid" ] = [];
    }
    
    array[ sector_name ][ "mid" ][ array[ sector_name ][ "mid" ].size ] = struct;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xac001ff0, Offset: 0x2667
// Size: 0x93
function private function_756b083806b3a9f7( params )
{
    level endon( #"ar_failed" );
    level callback::add( "on_round_end", &function_ae879757529e15f2 );
    level utility::flag_set( "ar_active" );
    level.var_23378cc637cedbd7 = &function_40ace81bbcdcdcf6;
    zm_round_spawning::pause_round_spawning( 1, "assault_round" );
    level.ar_root.var_d80691d07a40bb81 = undefined;
    level.ar_root.var_4c86f85295111faf = undefined;
    level.ar_root.var_4a7e5599df870947 = undefined;
    function_1a633b3d7f564bbd();
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0xae2d7182, Offset: 0x2702
// Size: 0x158
function function_ae879757529e15f2( params )
{
    level notify( #"ar_ended" );
    level utility::flag_clear( "ar_active" );
    powerups::function_b3ef1ccbc3c4bbbb( 1 );
    level.var_23378cc637cedbd7 = undefined;
    level callback::remove( "on_round_end", &function_ae879757529e15f2 );
    zm_sat_hornet_weather_ash::set_ash_paused( 0 );
    level.ar_root.var_6ddc7f0933329fff = undefined;
    function_40eb772f9085ef92( 0 );
    level thread function_cdc19630f8b6f1d1();
    zm_round_spawning::pause_round_spawning( 0, "assault_round" );
    function_9305ba9593068cb9( level.ar_root.current_target );
    level scriptable::function_dc174fecebb79952( &function_44250a01ec80281e );
    level scriptable::function_dc174fecebb79952( &function_e7c571eab9b851fa );
    
    if ( isdefined( level.ar_root.current_sector ) )
    {
        s_trap_root = level.ar_root.var_2747e0528b1f176[ level.ar_root.current_sector ];
        zm_sat_hornet_murder_holes::function_1802c8377563dddf( s_trap_root );
    }
    
    level.ar_root.num_assault_rounds++;
    level thread function_949c1afbdcc4ddd7();
    level val::reset( "ar_task_bl", "task_logic_activate" );
    callback::callback( "hornet_assault_round_ended", { #b_success:params.b_success } );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x2efd7fb3, Offset: 0x2862
// Size: 0x27, Type: bool
function private function_40ace81bbcdcdcf6( bgb )
{
    if ( bgb == "round_off" || bgb == "time_out" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x15016f72, Offset: 0x2892
// Size: 0xfb
function private function_e4c72104b62bc98( sparams )
{
    callback::add( "on_hornet_boss_projectile_vo", &function_1c43db5d94c007e8 );
    callback::add( "on_hornet_boss_beam_vo", &function_c8111f442ff75bb8 );
    
    if ( !level utility::flag( "ar_active" ) )
    {
        return;
    }
    
    var_40359b99b2c7284d = 0;
    
    if ( level.ar_root.var_6ddc7f0933329fff == "prepare" )
    {
        musicbank_utility::function_5aca66c390aa347d( [ self ], #"assault_round_prepare" );
        var_40359b99b2c7284d = 1;
    }
    else if ( level.ar_root.var_6ddc7f0933329fff == "active" )
    {
        musicbank_utility::function_5aca66c390aa347d( [ self ], #"assault_round" );
        var_40359b99b2c7284d = 1;
    }
    else if ( level.ar_root.var_6ddc7f0933329fff == "phase_2" )
    {
        musicbank_utility::function_5aca66c390aa347d( [ self ], #"hash_80d254a74920ee96" );
        var_40359b99b2c7284d = 1;
    }
    
    thread function_9f7fe31792af3b0b();
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xeec25a2c, Offset: 0x2995
// Size: 0x71
function private function_9f7fe31792af3b0b()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    level waittill( #"on_round_start" );
    musicbank_utility::function_4f253fd35ec68cbc( [ self ], #"assault_round_prepare" );
    musicbank_utility::function_4f253fd35ec68cbc( [ self ], #"assault_round" );
    musicbank_utility::function_4f253fd35ec68cbc( [ self ], #"hash_80d254a74920ee96" );
    zm_quest::function_62242b3a7443794e( 0 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xf933fe78, Offset: 0x2a0e
// Size: 0x84
function private on_round_end( params )
{
    if ( level utility::flag( "ar_active" ) )
    {
        return;
    }
    
    next_round = zm_utility::get_round_number() + 1;
    
    if ( zm_round_spawning::is_special_round( next_round ) )
    {
        if ( get_assault_rounds_blocked() )
        {
            var_91bf861ca0649c67 = max( next_round + 1, 10 );
            zm_round_spawning::function_9fd9e12523021d1d( next_round, var_91bf861ca0649c67 );
            level function_52f7e142e34bc386( var_91bf861ca0649c67 );
            return;
        }
        
        level val::set( "ar_task_bl", "task_logic_activate", 0 );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x40b30a2, Offset: 0x2a9a
// Size: 0xc
function private function_4f757e1427505942( params )
{
    
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x69813357, Offset: 0x2aaf
// Size: 0xc
function private function_ec4a67c14916b1c2( params )
{
    
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xf69ed1c1, Offset: 0x2ac4
// Size: 0x124
function private function_949c1afbdcc4ddd7()
{
    level endon( #"game_ended" );
    zm_quest::function_a81dd416b9036f0e( 1, #"hash_5d06d71de9a9208e" );
    
    if ( !level.ar_root.var_816db095a80ba793 )
    {
        level thread zm_quest::clear_all_guidance();
        function_8c8447193d859054();
        return;
    }
    
    b_show_wwq = getdvarint( @"hash_a848de4270c1778d", 0 );
    b_show_mq = getdvarint( @"hash_a848de4270c1778d", 0 );
    
    if ( zm_quest::get_quest( #"hornet_pap_quest" ) && !zm_quest::is_quest_complete( #"hornet_pap_quest" ) )
    {
        zm_sat_hornet_pap_quest::function_ecc91637c2a6fbb1();
    }
    else if ( b_show_wwq && zm_quest::get_quest( #"hornet_ww_quest" ) && !zm_quest::is_quest_complete( #"hornet_ww_quest" ) )
    {
        zm_sat_hornet_ww_quest::function_ecc91637c2a6fbb1();
    }
    else if ( b_show_mq && zm_quest::get_quest( #"hornet_mq_quest" ) && !zm_quest::is_quest_complete( #"hornet_mq_quest" ) )
    {
        zm_sat_hornet_mq_quest::function_ecc91637c2a6fbb1();
    }
    else
    {
        level thread zm_quest::clear_all_guidance();
    }
    
    function_8c8447193d859054();
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x6577b950, Offset: 0x2bf0
// Size: 0x1ee
function private function_cdc19630f8b6f1d1()
{
    level endon( #"game_ended" );
    
    foreach ( commander in level.ar_root.a_commanders )
    {
        if ( isalive( commander ) && !commander.var_693295c1cf65edd0 )
        {
            if ( commander callback::exists( "on_zombie_ai_killed", &function_bcc58c62a9a011ee ) )
            {
                commander callback::remove( "on_zombie_ai_killed", &function_bcc58c62a9a011ee );
            }
            
            commander thread zm_utility::function_5bbd540197e3fd( 100, 1.5, 2 );
            commander.var_693295c1cf65edd0 = 1;
        }
        
        waitframe();
    }
    
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) && zombie.var_8d1ec8d2c55d4025 && !zombie.var_693295c1cf65edd0 )
        {
            zombie thread zm_utility::function_5bbd540197e3fd( 100, 1.5, 2 );
            zombie.var_693295c1cf65edd0 = 1;
        }
        
        waitframe();
    }
    
    if ( isalive( level.ar_root.ar_diana ) )
    {
        function_545262c6bc7bf7eb();
        level waittill( #"hash_fb561e572dacbe7b" );
        level notify( #"kill_all_remaining_zombies_diana_outro_complete" );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x6beff5a6, Offset: 0x2de6
// Size: 0xd7
function private function_26c9f0fe69b6d50()
{
    level endon( #"game_ended" );
    zombies = getaiarray( zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) && zombie.is_banner_zombie && !zombie.var_693295c1cf65edd0 )
        {
            zombie thread zm_utility::function_5bbd540197e3fd( 100, 1.5, 2 );
            zombie.var_693295c1cf65edd0 = 1;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x145fd72e, Offset: 0x2ec5
// Size: 0x456
function private function_1a633b3d7f564bbd()
{
    level endon( #"ar_ended" );
    level endon( #"ar_skipped" );
    var_dae45494211e5044 = get_assault_round_length();
    level.ar_root.var_c3964a7cd5a623f7 = function_3971dfaa0e836d99();
    level.ar_root.var_ba6220e13b0338aa = get_damage_multiplier();
    var_e917a56fdbc933d8 = function_6c401100fce6b984();
    level.ar_root.current_sector = var_e917a56fdbc933d8;
    
    if ( !isdefined( level.ar_root.a_commanders ) )
    {
        level.ar_root.a_commanders = [];
    }
    
    level.ar_root.var_eec469e42bd3390c = undefined;
    var_e50080547879e440 = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
    
    foreach ( zone_name in var_e50080547879e440 )
    {
        if ( arraycontains( level.ash_root.var_110f8886053692a9, zone_name ) )
        {
            level thread zm_sat_hornet_weather_ash::function_502a6d0994562459( zone_name );
        }
    }
    
    zm_sat_hornet_weather_ash::set_ash_paused( 1 );
    var_2ea6f6a47df28978 = level.ar_root.a_first_target[ var_e917a56fdbc933d8 ];
    second_target = level.ar_root.var_7130ff0005fdba3e[ var_e917a56fdbc933d8 ];
    a_komainu = level.ar_root.a_first_target[ level.ar_root.current_sector ];
    pos = ( a_komainu[ 0 ].origin + a_komainu[ 1 ].origin ) / 2;
    waypoint = [ { #origin:pos }, 100 ];
    zm_quest::function_b5d75b34f712db9a();
    zm_sat_hornet_mq_quest::function_d385bd2c55eb7da9();
    level thread function_a9310f61e3f94356( [ waypoint ], #"hash_5d06d71de9a9208e", #"prep_phase" );
    playsoundatpos( pos, #"hash_90c4744bd2280e0b" );
    function_5535a837de88a60b( "sat_zm_hornet_ar_start" );
    level.ar_root.var_6ddc7f0933329fff = "prepare";
    musicbank_utility::function_5aca66c390aa347d( level.players, #"assault_round_prepare" );
    level thread function_d78aeabe4ff55e73();
    function_40eb772f9085ef92( 1 );
    wait 45;
    function_40eb772f9085ef92( 0 );
    level notify( #"hash_205a22de093717f9" );
    playsoundatpos( pos, #"hash_d3c47cabcfaad773" );
    level.ar_root.var_6ddc7f0933329fff = "active";
    musicbank_utility::function_5aca66c390aa347d( level.players, #"assault_round" );
    s_trap_root = level.ar_root.var_2747e0528b1f176[ var_e917a56fdbc933d8 ];
    zm_sat_hornet_murder_holes::function_3564479f464a54bd( s_trap_root );
    var_96c503f5532398f8 = level.ar_root.var_af34ac5bd8ff4659[ var_e917a56fdbc933d8 ];
    level thread function_83747b92feac2545( var_96c503f5532398f8, var_e917a56fdbc933d8 );
    level thread function_e6fa26f7bf4f2866( var_2ea6f6a47df28978, #"obj_1", utility::function_4b74c15943231980( var_dae45494211e5044 ) );
    function_c499ab7d5df01db1( var_2ea6f6a47df28978, level.ar_root.var_91cf84d3c024431e[ var_e917a56fdbc933d8 ], ( 32, 32, 32 ) );
    function_b5171d402908bc7e( level.ar_root.var_28e4ff3f60d19060[ var_e917a56fdbc933d8 ], level.ar_root.var_605f820245431396[ var_e917a56fdbc933d8 ] );
    track_target_damage( var_2ea6f6a47df28978, getdvarint( @"hash_68b0bb857aec783b", 1300 ), "koma" );
    level thread function_11586d1a526801d0( second_target, var_e917a56fdbc933d8, var_dae45494211e5044 );
    wait max( 0.5, var_dae45494211e5044 - 1.25 );
    
    if ( level.ar_root.var_eec469e42bd3390c )
    {
        wait level.ar_root.var_eec469e42bd3390c;
    }
    
    level thread function_8c5d51e7dc3a3cea();
    level notify( #"ar_ended" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xa6ce9437, Offset: 0x3323
// Size: 0x8b
function private function_5c92fe0be85c3e3b()
{
    n_next_ar = zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_71914be6e8e965ba" ) ?? 0;
    level function_52f7e142e34bc386( 1000 );
    zm_round_spawning::function_9fd9e12523021d1d( n_next_ar, 1000 );
    level notify( #"hash_b59b49c20b78311f" );
    level.ar_root.var_fe95ca6644d31a53 = undefined;
    level.ar_root.var_92d6fab5312585c4 = undefined;
    level thread function_9087fb07ee4f7da();
    level thread function_fe790f9b80dff39d();
    level thread function_380ee744ce6b1f1a();
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x362028f6, Offset: 0x33b6
// Size: 0x18b
function private function_9087fb07ee4f7da()
{
    level endon( #"game_ended" );
    level endon( #"hash_d47f58bf451ccd6e" );
    level endon( #"diana_boss_fight_started" );
    
    if ( zm_quest::is_quest_complete( #"hornet_mq_quest" ) || level utility::flag( "hornet_boss_fight_intro_complete" ) )
    {
        return;
    }
    
    var_12ed68d3780ab886 = 0;
    
    for ( var_712128ccff092584 = zm_utility::get_round_number(); true ; var_712128ccff092584 = var_49f7091014d2c59 )
    {
        target = utility::array_random( level.players );
        zone = zone_manager::function_90e5c3e2272b0130( self.origin );
        gen_zone_name = zm_utility::function_fbb7d4c98261e273( zone.script_zone_name );
        s_vantage = function_3e57e737eadcee5e( gen_zone_name );
        level utility::waittill_notify_or_timeout( "kill_all_remaining_zombies_diana_outro_complete", 15 );
        level thread function_83747b92feac2545( s_vantage, "ar_sec4", undefined, undefined, 1 );
        level waittill( #"hash_c579d65184bf3689" );
        var_3d7488483301e6ec = level utility::waittill_any_in_array_or_timeout( [ "on_round_end" ], randomfloatrange( getdvarfloat( @"hash_b7525f6f01dbfff3", 110 ), getdvarfloat( @"hash_d25175bb5b1563ed", 120 ) ) );
        level function_545262c6bc7bf7eb();
        
        if ( var_3d7488483301e6ec == "timeout" )
        {
            level waittill( #"on_round_end" );
        }
        
        var_49f7091014d2c59 = zm_utility::get_round_number();
        var_12ed68d3780ab886 = var_49f7091014d2c59 - var_712128ccff092584;
        
        if ( var_12ed68d3780ab886 >= getdvarint( @"hash_1b66a81b3f3e9d5d", 1 ) )
        {
            var_12ed68d3780ab886 = 0;
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xf6fb5812, Offset: 0x3549
// Size: 0x59
function private function_fe790f9b80dff39d()
{
    level endon( #"game_ended" );
    level endon( #"hash_d47f58bf451ccd6e" );
    level waittill( #"diana_boss_fight_started" );
    
    if ( isalive( level.ar_root.ar_diana ) )
    {
        level.ar_root.ar_diana kill();
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x868866c9, Offset: 0x35aa
// Size: 0x8c
function private function_380ee744ce6b1f1a()
{
    level endon( #"game_ended" );
    level waittill( #"hash_d47f58bf451ccd6e" );
    
    if ( isalive( level.ar_root.ar_diana ) )
    {
        level thread function_545262c6bc7bf7eb();
    }
    
    var_49f7091014d2c59 = zm_utility::get_round_number();
    n_delay = randomintrange( 2, 4 );
    var_dfce7946a3345c16 = min( var_49f7091014d2c59 + n_delay, 999 );
    level function_52f7e142e34bc386( var_dfce7946a3345c16 );
    zm_round_spawning::function_9fd9e12523021d1d( 1000, var_dfce7946a3345c16 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xa0c3a532, Offset: 0x363e
// Size: 0x1bd
function private function_8a1ae87516c9e769()
{
    level endon( #"game_ended" );
    level endon( #"diana_boss_fight_started" );
    level endon( #"hash_2bf4a4ae4614c47f" );
    level endon( #"hash_b59b49c20b78311f" );
    
    if ( zm_quest::is_quest_complete( #"hornet_mq_quest" ) || level utility::flag( "hornet_boss_fight_intro_complete" ) )
    {
        level.ar_root.var_fe95ca6644d31a53 = undefined;
        return;
    }
    
    level.ar_root.var_928267948450485 = [];
    level.ar_root.var_655a5ecbbf730efd = 0;
    
    while ( true )
    {
        wait 1;
        
        if ( level utility::flag( "ar_active" ) )
        {
            level.ar_root.var_92d6fab5312585c4 = undefined;
            continue;
        }
        
        if ( level utility::flag( "recapture_active" ) )
        {
            continue;
        }
        
        if ( level.ar_root.var_92d6fab5312585c4 )
        {
            continue;
        }
        
        if ( ( level.var_b3d685cfbac74242 ?? zm_utility::get_round_number() ) < 20 )
        {
            continue;
        }
        
        if ( zm_quest::is_quest_complete( #"hornet_mq_quest" ) || level utility::flag( "hornet_boss_fight_intro_complete" ) )
        {
            level.ar_root.var_fe95ca6644d31a53 = undefined;
            return;
        }
        
        if ( !level.ar_root.var_35233896c682d3ea.size )
        {
            level notify( #"hash_2bf4a4ae4614c47f" );
            level.ar_root.var_fe95ca6644d31a53 = undefined;
            return;
        }
        
        if ( gettime() < level.ar_root.var_655a5ecbbf730efd )
        {
            continue;
        }
        
        harass_sector = function_f8a383a4f5047cf4();
        
        if ( harass_sector )
        {
            level thread function_c9138615a005a46();
            level thread function_4797fef2ecf58eb0( harass_sector );
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xbc62a36e, Offset: 0x3803
// Size: 0x266
function private function_f8a383a4f5047cf4()
{
    n_time = gettime();
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        foreach ( var_e917a56fdbc933d8 in level.ar_root.var_35233896c682d3ea )
        {
            banner = level.ar_root.var_7130ff0005fdba3e[ var_e917a56fdbc933d8 ];
            
            if ( banner.is_capturing )
            {
                continue;
            }
            
            b_in_sector = function_8d86f00c81ff837b( player, var_e917a56fdbc933d8 );
            player_id = player getentitynumber();
            var_a468c50cb8f7266 = player_id + "_" + var_e917a56fdbc933d8;
            
            if ( !isdefined( level.ar_root.var_928267948450485[ var_a468c50cb8f7266 ] ) )
            {
                level.ar_root.var_928267948450485[ var_a468c50cb8f7266 ] = { #n_window_start:n_time, #n_time:0 };
            }
            
            var_4b94bc46b236c6bc = level.ar_root.var_928267948450485[ var_a468c50cb8f7266 ];
            
            if ( n_time - var_4b94bc46b236c6bc.n_window_start > 60000 )
            {
                var_4b94bc46b236c6bc.n_time = 0;
                var_4b94bc46b236c6bc.n_window_start = n_time;
            }
            
            if ( b_in_sector )
            {
                var_4b94bc46b236c6bc.n_time += 1000;
                
                if ( var_4b94bc46b236c6bc.n_time >= getdvarint( @"hash_a037e71661c01ecc", 35 ) * 1000 )
                {
                    var_4b94bc46b236c6bc.n_time = 0;
                    var_4b94bc46b236c6bc.n_window_start = n_time;
                    return var_e917a56fdbc933d8;
                }
            }
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x3a325542, Offset: 0x3a72
// Size: 0x130
function private function_4797fef2ecf58eb0( var_e917a56fdbc933d8 )
{
    level endon( #"game_ended" );
    level endon( #"diana_boss_fight_started" );
    level endon( #"special_round_start" );
    level.ar_root.var_92d6fab5312585c4 = 1;
    [ zone_name ] = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
    gen_zone_name = zm_utility::function_fbb7d4c98261e273( zone_name );
    s_vantage = function_3e57e737eadcee5e( gen_zone_name );
    level thread function_83747b92feac2545( s_vantage, var_e917a56fdbc933d8, undefined, undefined, 1 );
    level waittill( #"hash_c579d65184bf3689" );
    level utility::waittill_notify_or_timeout( "on_round_end", getdvarint( @"hash_ab87ad498ac57244", 60 ) );
    
    if ( isalive( level.ar_root.ar_diana ) )
    {
        level function_545262c6bc7bf7eb();
    }
    
    level.ar_root.var_92d6fab5312585c4 = undefined;
    level.ar_root.var_655a5ecbbf730efd = gettime() + getdvarint( @"hash_f7828e03cba603d6", 180 ) * 1000;
    level notify( #"hash_b44b26aad8a2432b" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xead08055, Offset: 0x3baa
// Size: 0xac
function private function_c9138615a005a46()
{
    level endon( #"game_ended" );
    level endon( #"hash_b44b26aad8a2432b" );
    result = level utility::waittill_any( "diana_boss_fight_started", "special_round_start" );
    level.ar_root.var_fe95ca6644d31a53 = undefined;
    
    if ( result == "diana_boss_fight_started" )
    {
        if ( isalive( level.ar_root.ar_diana ) )
        {
            level.ar_root.ar_diana kill();
        }
        
        return;
    }
    
    if ( isalive( level.ar_root.ar_diana ) )
    {
        level function_545262c6bc7bf7eb();
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xca6ae449, Offset: 0x3c5e
// Size: 0x220
function private function_11586d1a526801d0( second_target, var_e917a56fdbc933d8, var_74f6a624b7e8fcc7 )
{
    level endon( #"ar_ended" );
    level endon( #"ar_skipped" );
    start_ts = gettime();
    level waittill( #"ar_wave_ended" );
    s_trap_root = level.ar_root.var_2747e0528b1f176[ var_e917a56fdbc933d8 ];
    utility::delaythread( 1.25, &zm_sat_hornet_murder_holes::function_9ceca8d29317aa92, s_trap_root );
    var_13fd2da20a7c519f = gettime();
    first_wave_len = utility::function_6f5d2e1f1ff70482( var_13fd2da20a7c519f - start_ts );
    time_remaining = utility::function_4b74c15943231980( var_74f6a624b7e8fcc7 - first_wave_len );
    n_extension = function_f296a451a8c7f204();
    level.ar_root.var_eec469e42bd3390c = n_extension;
    time_remaining += utility::function_4b74c15943231980( n_extension );
    
    if ( isdefined( second_target.linked_banner ) )
    {
        main_banner = second_target;
        second_target = [ main_banner, main_banner.linked_banner ];
    }
    
    level.ar_root.var_6ddc7f0933329fff = "phase_2";
    musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_80d254a74920ee96" );
    level thread function_e6fa26f7bf4f2866( second_target, #"obj_2", time_remaining );
    function_c499ab7d5df01db1( second_target, level.ar_root.var_8f76e4f12f2c2efc[ var_e917a56fdbc933d8 ], ( 20, 20, 32 ) );
    function_b5171d402908bc7e( level.ar_root.var_66cdb027aee5520e[ var_e917a56fdbc933d8 ], level.ar_root.var_b1095616d6d59608[ var_e917a56fdbc933d8 ] );
    track_target_damage( second_target, getdvarint( @"hash_6697efa3545a9771", 1700 ), "ban" );
    level thread function_83747b92feac2545( level.ar_root.var_8a1f25351dcdc573[ var_e917a56fdbc933d8 ], var_e917a56fdbc933d8, undefined, 2 );
    function_5535a837de88a60b( "sat_zm_hornet_ar_wave_fail" );
    level notify( #"ar_wave_changed" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xb916e073, Offset: 0x3e86
// Size: 0x171
function private function_e6fa26f7bf4f2866( target, step, time_remaining )
{
    level endon( #"game_ended" );
    waypoints = [ [ target, 165 ] ];
    
    if ( isarray( target ) )
    {
        total_pos = ( 0, 0, 0 );
        
        foreach ( individual_target in target )
        {
            total_pos += individual_target.origin;
        }
        
        pos = total_pos / target.size;
        hudelem = { #origin:pos };
        waypoints = [ [ hudelem, 100 ] ];
    }
    
    level function_a9310f61e3f94356( waypoints, #"hash_5d06d71de9a9208e", step );
    level zm_quest::function_9f49b2a045ece8ae( 100, 1, #"hash_5d06d71de9a9208e", step );
    level zm_quest::function_612a9ad0db22c29c( time_remaining, 1, #"hash_5d06d71de9a9208e", step );
    level.ar_root.current_step_ref = step;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xec68ab37, Offset: 0x3fff
// Size: 0x1a2
function private function_a9310f61e3f94356( huddata, quest_ref, step_ref )
{
    level zm_quest::function_fba942a1cfd85f5d( 1, 1, quest_ref, step_ref );
    level zm_quest::function_fb3af5600f6a9441( 2, 1, quest_ref, step_ref );
    function_8c8447193d859054();
    
    foreach ( hudobject in huddata )
    {
        if ( isdefined( hudobject[ 0 ] ) )
        {
            offset = hudobject[ 1 ] ?? 15;
            origin = isvector( hudobject[ 0 ] ) ? hudobject[ 0 ] : hudobject[ 0 ].origin;
            
            if ( origin )
            {
                var_3017d07087bdb6c1 = level.var_a74764204d9643c;
                level.var_a74764204d9643c = undefined;
                objid = zm_quest::function_b98d4144845ffc13( "ar_wayp", 0, "sat_ui_hud_zm_assault_round_icon", undefined, "current", origin, offset, undefined, undefined, 1, 0 );
                
                if ( !objid )
                {
                    waitframe();
                    objid = zm_quest::function_b98d4144845ffc13( "ar_wayp", 0, "sat_ui_hud_zm_assault_round_icon", undefined, "current", origin, offset, undefined, undefined, 1, 0 );
                }
                
                level.var_a74764204d9643c = var_3017d07087bdb6c1;
                level.ar_root.a_waypoints[ level.ar_root.a_waypoints.size ] = objid;
            }
        }
    }
    
    level notify( #"hash_7bdf5ebd10ff8691" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xd60a5d98, Offset: 0x41a9
// Size: 0xc9
function private function_8c8447193d859054()
{
    if ( !isdefined( level.ar_root.a_waypoints ) )
    {
        level.ar_root.a_waypoints = [];
    }
    
    if ( level.ar_root.a_waypoints.size > 0 )
    {
        foreach ( objid in level.ar_root.a_waypoints )
        {
            zm_quest::complete_objective_waypoints( objid );
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xd905d326, Offset: 0x427a
// Size: 0xb4
function private get_assault_round_length()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 20 )
    {
        return getdvarint( @"hash_f3988abed70950df", 60 );
    }
    else if ( n_round < 30 )
    {
        return getdvarint( @"hash_fbdeba0c66feca10", 75 );
    }
    else if ( n_round < 50 )
    {
        return getdvarint( @"hash_ad37fb6024923a4e", 90 );
    }
    else if ( n_round < 100 )
    {
        return getdvarint( @"hash_f22dedab6f86eee8", 120 );
    }
    else if ( n_round < 1000 )
    {
        return getdvarint( @"hash_e62ade278b4a12e2", 135 );
    }
    
    return getdvarint( @"hash_f3988abed70950df", 60 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x696e97a4, Offset: 0x4337
// Size: 0x48
function private function_3971dfaa0e836d99()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 20 )
    {
        return 0.55;
    }
    
    if ( n_round < 30 )
    {
        return 0.75;
    }
    
    return 1;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xb570204a, Offset: 0x4387
// Size: 0xa5
function private function_f296a451a8c7f204()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 20 )
    {
        return getdvarint( @"hash_12678bccd12ccc0f", 30 );
    }
    
    if ( n_round < 30 )
    {
        return getdvarint( @"hash_f323eb3c4f7940ac", 30 );
    }
    
    if ( n_round < 50 )
    {
        return getdvarint( @"hash_1afbe8542b49d4ce", 60 );
    }
    
    if ( n_round < 100 )
    {
        return getdvarint( @"hash_161565ce75974604", 60 );
    }
    
    if ( n_round < 1000 )
    {
        return getdvarint( @"hash_23313b3add4e115a", 60 );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x764e2bd, Offset: 0x4434
// Size: 0x6a
function private get_damage_multiplier()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 20 )
    {
        return 1;
    }
    
    if ( n_round < 30 )
    {
        return 0.85;
    }
    
    if ( n_round < 50 )
    {
        return 0.66;
    }
    
    if ( n_round < 100 )
    {
        return 0.5;
    }
    
    return 0.35;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x96096c8a, Offset: 0x44a6
// Size: 0x50
function private scale_zombie_damage( idamage )
{
    idamage = int( idamage * level.ar_root.var_ba6220e13b0338aa );
    n_max_hit_damage = getdvarint( @"hash_7c54c2923c70a243", 65 );
    
    if ( idamage > n_max_hit_damage )
    {
        idamage = n_max_hit_damage;
    }
    
    return idamage;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x15c0e49b, Offset: 0x44ff
// Size: 0x22f
function private function_6c401100fce6b984()
{
    function_26bdd6572e4c9288();
    
    if ( arraycontains( level.ar_root.var_35233896c682d3ea, "ar_sec4" ) )
    {
        return "none";
    }
    else if ( level.ar_root.var_35233896c682d3ea.size >= 2 )
    {
        return "ar_sec4";
    }
    else if ( level.ar_root.preferred_sector && !arraycontains( level.ar_root.var_35233896c682d3ea, level.ar_root.preferred_sector ) )
    {
        preferred_sector = level.ar_root.preferred_sector;
        function_21247383bf68f768();
        return preferred_sector;
    }
    else
    {
        var_b39689142541d8a8 = [];
        
        foreach ( var_e917a56fdbc933d8 in [ "ar_sec1", "ar_sec2", "ar_sec3" ] )
        {
            if ( arraycontains( level.ar_root.var_deacad0eb099f86e, var_e917a56fdbc933d8 ) && !arraycontains( level.ar_root.var_35233896c682d3ea, var_e917a56fdbc933d8 ) )
            {
                var_b39689142541d8a8[ var_b39689142541d8a8.size ] = var_e917a56fdbc933d8;
            }
        }
        
        if ( var_b39689142541d8a8.size > 1 )
        {
            if ( level.ar_root.var_4b3712c148e8f73a )
            {
                var_e917a56fdbc933d8 = utility::function_879489791c3d805( var_b39689142541d8a8, level.ar_root.var_4b3712c148e8f73a );
            }
            else
            {
                var_e917a56fdbc933d8 = utility::array_random( var_b39689142541d8a8 );
            }
            
            level.ar_root.var_4b3712c148e8f73a = [ var_e917a56fdbc933d8 ];
            return var_e917a56fdbc933d8;
        }
        else if ( var_b39689142541d8a8.size == 1 )
        {
            var_e917a56fdbc933d8 = var_b39689142541d8a8[ 0 ];
            return var_e917a56fdbc933d8;
        }
        else
        {
            assertmsg( "<dev string:x24>" );
        }
    }
    
    assertmsg( "<dev string:x46>" );
    return "none";
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0xe226c694, Offset: 0x4737
// Size: 0xad, Type: bool
function function_88712c1ecdd86a0f( sector_name )
{
    assert( arraycontains( [ "<dev string:x84>", "<dev string:x8c>", "<dev string:x94>", "<dev string:x9c>" ], sector_name ), "<dev string:xa4>" );
    
    if ( arraycontains( level.ar_root.var_35233896c682d3ea, sector_name ) )
    {
        return false;
    }
    
    if ( arraycontains( level.ar_root.var_35233896c682d3ea, "ar_sec4" ) )
    {
        return false;
    }
    
    if ( level.ar_root.var_35233896c682d3ea.size >= 2 && sector_name != "ar_sec4" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x7a901a68, Offset: 0x47ed
// Size: 0x22
function set_preferred_sector( sector_name )
{
    level.ar_root.preferred_sector = sector_name;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x7116ce46, Offset: 0x4817
// Size: 0x15
function function_21247383bf68f768()
{
    level.ar_root.preferred_sector = undefined;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xd25dacbc, Offset: 0x4834
// Size: 0x1e8
function private function_26bdd6572e4c9288()
{
    if ( level.ar_root.var_deacad0eb099f86e.size >= 4 )
    {
        return;
    }
    
    if ( !arraycontains( level.ar_root.var_deacad0eb099f86e, "ar_sec1" ) )
    {
        var_9fb083be3980f908 = function_8e6d0bb19db87d5f( [ "zone_west_bailey_a", "zone_broken_turrets_a" ] );
        
        if ( var_9fb083be3980f908 )
        {
            level.ar_root.var_deacad0eb099f86e[ level.ar_root.var_deacad0eb099f86e.size ] = "ar_sec1";
        }
    }
    
    if ( !arraycontains( level.ar_root.var_deacad0eb099f86e, "ar_sec2" ) )
    {
        var_9fb083be3980f908 = function_8e6d0bb19db87d5f( [ "zone_lava_tubes_start_a", "zone_third_bailey_east_a", "zone_third_bailey_west_a" ] );
        
        if ( var_9fb083be3980f908 )
        {
            level.ar_root.var_deacad0eb099f86e[ level.ar_root.var_deacad0eb099f86e.size ] = "ar_sec2";
        }
    }
    
    if ( !arraycontains( level.ar_root.var_deacad0eb099f86e, "ar_sec3" ) )
    {
        var_9fb083be3980f908 = function_8e6d0bb19db87d5f( [ "zone_lava_garden_a", "zone_second_bailey_a" ] );
        
        if ( var_9fb083be3980f908 )
        {
            level.ar_root.var_deacad0eb099f86e[ level.ar_root.var_deacad0eb099f86e.size ] = "ar_sec3";
        }
    }
    
    if ( !arraycontains( level.ar_root.var_deacad0eb099f86e, "ar_sec4" ) )
    {
        var_9fb083be3980f908 = function_8e6d0bb19db87d5f( [ "zone_main_bailey_a", "zone_main_keep_a" ] );
        
        if ( var_9fb083be3980f908 )
        {
            level.ar_root.var_deacad0eb099f86e[ level.ar_root.var_deacad0eb099f86e.size ] = "ar_sec4";
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xf0ce4b24, Offset: 0x4a24
// Size: 0x9a, Type: bool
function private function_8e6d0bb19db87d5f( var_87886397e909c08b )
{
    foreach ( zone_name in var_87886397e909c08b )
    {
        var_8c4fe62d01999d1e = zone_manager::get_zone_struct( zone_name );
        
        if ( !var_8c4fe62d01999d1e.is_enabled )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x85de62e3, Offset: 0x4ac7
// Size: 0x92
function function_7ef58899cffe2533( var_e917a56fdbc933d8 )
{
    if ( var_e917a56fdbc933d8 == "ar_sec1" )
    {
        return [ "zone_west_bailey", "zone_broken_turrets" ];
    }
    else if ( var_e917a56fdbc933d8 == "ar_sec2" )
    {
        return [ "zone_lava_tubes", "zone_third_bailey" ];
    }
    else if ( var_e917a56fdbc933d8 == "ar_sec3" )
    {
        return [ "zone_lava_garden", "zone_second_bailey" ];
    }
    else if ( var_e917a56fdbc933d8 == "ar_sec4" )
    {
        return [ "zone_main_bailey", "zone_main_keep" ];
    }
    
    return [];
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x1b077f70, Offset: 0x4b62
// Size: 0x1c4
function function_acaabe946d73df36( var_e917a56fdbc933d8 )
{
    if ( var_e917a56fdbc933d8 == "ar_sec1" )
    {
        return [ "zone_west_bailey_a", "zone_west_bailey_b", "zone_broken_turrets_a", "zone_broken_turrets_b", "zone_broken_turrets_c", "zone_broken_turrets_d" ];
    }
    else if ( var_e917a56fdbc933d8 == "ar_sec2" )
    {
        return [ "zone_lava_tubes_a", "zone_lava_tubes_b", "zone_lava_tubes_c", "zone_third_bailey_west_a", "zone_third_bailey_west_b", "zone_third_bailey_east_a", "zone_third_bailey_east_b" ];
    }
    else if ( var_e917a56fdbc933d8 == "ar_sec3" )
    {
        return [ "zone_lava_garden_a", "zone_lava_garden_b", "zone_lava_garden_c", "zone_second_bailey_a", "zone_second_bailey_b", "zone_second_bailey_c", "zone_second_bailey_d" ];
    }
    else if ( var_e917a56fdbc933d8 == "ar_sec4" )
    {
        return [ "zone_main_bailey_a", "zone_main_bailey_b", "zone_main_bailey_c", "zone_main_bailey_d", "zone_main_keep_a", "zone_main_keep_b", "zone_main_keep_c", "zone_main_keep_west_path_a", "zone_main_keep_west_path_b", "zone_main_keep_east_path_a", "zone_main_keep_east_path_b", "zone_main_keep_2nd_floor_a", "zone_main_keep_2nd_floor_b", "zone_main_keep_2nd_floor_c", "zone_main_keep_2nd_floor_d", "zone_main_keep_top", "zone_main_keep_roof_a", "zone_main_keep_roof_b", "zone_main_keep_wall_jump_zone_02", "zone_main_bailey_a_eave", "zone_main_bailey_b_eave", "zone_main_keep_wall_jump_zone_02_eave" ];
    }
    
    return [];
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x1801d213, Offset: 0x4d2f
// Size: 0x13e
function function_3e57e737eadcee5e( zone_name )
{
    if ( zone_name == "zone_west_bailey" )
    {
        return level.ar_root.var_af34ac5bd8ff4659[ "ar_sec1" ];
    }
    
    if ( zone_name == "zone_broken_turrets" )
    {
        return level.ar_root.var_8a1f25351dcdc573[ "ar_sec1" ];
    }
    
    if ( zone_name == "zone_lava_tubes" )
    {
        return level.ar_root.var_af34ac5bd8ff4659[ "ar_sec2" ];
    }
    
    if ( zone_name == "zone_third_bailey" )
    {
        return level.ar_root.var_8a1f25351dcdc573[ "ar_sec2" ];
    }
    
    if ( zone_name == "zone_lava_garden" )
    {
        return level.ar_root.var_af34ac5bd8ff4659[ "ar_sec3" ];
    }
    
    if ( zone_name == "zone_second_bailey" )
    {
        return level.ar_root.var_8a1f25351dcdc573[ "ar_sec3" ];
    }
    
    if ( zone_name == "zone_main_bailey" )
    {
        return level.ar_root.var_af34ac5bd8ff4659[ "ar_sec4" ];
    }
    
    return level.ar_root.var_8a1f25351dcdc573[ "ar_sec4" ];
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xd0949986, Offset: 0x4e75
// Size: 0x20
function private function_b5171d402908bc7e( var_703b33e652831823, var_afc5b51109a22460 )
{
    level thread function_adbe984e91a0afde( var_703b33e652831823, var_afc5b51109a22460 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xdf2fb73d, Offset: 0x4e9d
// Size: 0x205
function private function_adbe984e91a0afde( var_703b33e652831823, var_afc5b51109a22460 )
{
    level endon( #"ar_wave_ended" );
    level endon( #"ar_ended" );
    level endon( #"ar_skipped" );
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    n_delay = zm_round_spawning::function_5f35aa2e209190da( n_round );
    n_players = level.players.size;
    spawn_limit = level.ar_root.var_2476fef49008ba4e[ n_players - 1 ];
    curr_spawn_locs = arrayrandomize( var_703b33e652831823 );
    curr_wave_size = 10;
    var_e3cd07f11b2f02fd = 0;
    var_8da5dc3182e9bf93 = [];
    var_607c05c7bad7d7f9 = [ "left", "mid", "right" ];
    var_5252bb6622779cba = function_cbc9b38d2b409be();
    
    while ( true )
    {
        while ( level.ar_root.var_a686c3ff0479034e )
        {
            waitframe();
        }
        
        foreach ( struct in curr_spawn_locs )
        {
            if ( can_spawn_new_zombie( spawn_limit ) )
            {
                subclass = roll_zombie_subclass();
                function_b0cc74dfc70bc7a0( subclass, struct, n_round );
                wait n_delay;
                var_e3cd07f11b2f02fd++;
                
                if ( var_e3cd07f11b2f02fd >= curr_wave_size )
                {
                    break;
                }
            }
        }
        
        waitframe();
        
        if ( var_e3cd07f11b2f02fd >= curr_wave_size )
        {
            var_e3cd07f11b2f02fd = 0;
            curr_wave_size = randomintrange( 12, 15 );
            var_506bdf78d88ad4f9 = utility::function_879489791c3d805( var_607c05c7bad7d7f9, var_8da5dc3182e9bf93 );
            var_8da5dc3182e9bf93 = [ var_506bdf78d88ad4f9 ];
            curr_spawn_locs = arrayrandomize( var_afc5b51109a22460[ var_506bdf78d88ad4f9 ] );
            wait var_5252bb6622779cba;
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xf11bbd2d, Offset: 0x50aa
// Size: 0xa3
function private function_cbc9b38d2b409be()
{
    switch ( level.players.size )
    {
        case 1:
            var_13499fc5a3a2f18c = getdvarfloat( @"hash_bf6c6d232c470abd", 7 );
            break;
        case 2:
            var_13499fc5a3a2f18c = getdvarfloat( @"hash_bf7053232c4ac766", 6 );
            break;
        case 3:
            var_13499fc5a3a2f18c = getdvarfloat( @"hash_bf7559232c50fd6f", 5 );
            break;
        default:
            var_13499fc5a3a2f18c = getdvarfloat( @"hash_bf564f232c2e9590", 4.25 );
            break;
    }
    
    return var_13499fc5a3a2f18c;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xef2674d5, Offset: 0x5156
// Size: 0xce
function private roll_zombie_subclass()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round >= 50 )
    {
        subclass = utility::random_weighted( [ "zombie_base", "zombie_base_armored_light", "zombie_hellhound", "zombie_base_armored_agni", "zombie_orion" ], [ 65, 8, 10, 0, 2 ] );
    }
    else
    {
        subclass = utility::random_weighted( [ "zombie_base", "zombie_base_armored_light", "zombie_hellhound", "zombie_base_armored_agni" ], [ 65, 8, 10, 0 ] );
    }
    
    return subclass;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0x5945d0f7, Offset: 0x522d
// Size: 0x1cb
function private function_b0cc74dfc70bc7a0( zombie_type, spawner, n_round )
{
    zombie = agent_manager::spawn_agent( zombie_type, spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        round_number = n_round ?? zm_round_logic::get_rb_round_number();
        zombie zombie_utils::set_zombie_round_difficulty( round_number, 1, 1 );
        zombie val::set( "ar_wave", "ignore_cleanup", 1 );
        zombie.var_8d1ec8d2c55d4025 = 1;
        zombie.ignore_enemy_count = 1;
        var_8a220c2857bf37d5 = function_d5918b2572672db7();
        var_7e3745ec334a4826 = utility::percent_chance( var_8a220c2857bf37d5 );
        
        if ( zombie_type != "zombie_hellhound" && var_7e3745ec334a4826 )
        {
            zombie zombie_utils::function_a8ce00e0448cb6f0( "sprint", "assault_round", 6 );
        }
        
        var_b8921cd7b323b54c = function_bf8410a81f84830e();
        var_24d1849726a1c01d = utility::percent_chance( var_b8921cd7b323b54c );
        
        if ( var_24d1849726a1c01d )
        {
            zombie.kiastring = #"zombie_kia_mission_kill";
            zombie utility::function_32b24db3127bff40( "base", "base_purple_eyes" );
        }
        
        n_drop_chance = is_armored_zombie_type( zombie_type ) ? 40 : 10;
        var_2e8ec1ed2fba73e6 = utility::percent_chance( n_drop_chance );
        
        if ( !var_2e8ec1ed2fba73e6 )
        {
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie.no_powerups = 1;
        }
        
        if ( spawner.script_animation )
        {
            zombie thread agent_spawner::function_ce10e453e7f7bb8e( spawner );
        }
        
        zombie thread zone_spawner::function_f9d3af30e993a949();
        zombie thread function_27f6fe8fc27f4b12();
        zombie callback::add( "on_zombie_ai_killed", &function_d9b7e407ddbc2a69 );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xedb15e21, Offset: 0x5400
// Size: 0x27
function private function_d9b7e407ddbc2a69( sparams )
{
    if ( isdefined( self.var_341da507139e9004 ) )
    {
        self.var_341da507139e9004 delete();
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x5e1cebfa, Offset: 0x542f
// Size: 0x4d
function private function_27f6fe8fc27f4b12()
{
    self endon( #"death" );
    val::set( "ar_rt_spwn", "ignoreall", 1 );
    
    while ( true )
    {
        if ( zombie_traverse::is_traversing() )
        {
            wait 0.5;
            continue;
        }
        
        val::reset( "ar_rt_spwn", "ignoreall" );
        return;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xef7188b3, Offset: 0x5484
// Size: 0x64
function private function_d5918b2572672db7()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 20 )
    {
        return 10;
    }
    
    if ( n_round < 30 )
    {
        return 15;
    }
    
    if ( n_round < 50 )
    {
        return 20;
    }
    
    if ( n_round < 100 )
    {
        return 25;
    }
    
    if ( n_round < 1000 )
    {
        return 35;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x1623ba88, Offset: 0x54f0
// Size: 0x64
function private function_bf8410a81f84830e()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 20 )
    {
        return 83;
    }
    
    if ( n_round < 30 )
    {
        return 75;
    }
    
    if ( n_round < 50 )
    {
        return 66;
    }
    
    if ( n_round < 100 )
    {
        return 66;
    }
    
    if ( n_round < 1000 )
    {
        return 66;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xcd746ffa, Offset: 0x555c
// Size: 0x3e
function private function_1011ec95b1eb9556()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 50 )
    {
        return 1000;
    }
    else if ( n_round < 100 )
    {
        return 1500;
    }
    
    return 2000;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xc327be1d, Offset: 0x55a3
// Size: 0x55
function private get_defend_time()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 50 )
    {
        return 60;
    }
    else if ( n_round < 100 )
    {
        return getdvarint( @"hash_3a7a605da6207a56", 120 );
    }
    
    return getdvarint( @"hash_bb9c53f4596d2e52", 150 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x192f6379, Offset: 0x5601
// Size: 0x65
function private function_df5cba2392ced66e()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 50 )
    {
        return getdvarfloat( @"hash_ea88d47c5c7f8088", 8 );
    }
    else if ( n_round < 100 )
    {
        return getdvarfloat( @"hash_dee4d84ae2f38c9c", 5 );
    }
    
    return getdvarfloat( @"hash_24d458b11d9e5e44", 3.5 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x3c39d4fc, Offset: 0x566f
// Size: 0x17
function private is_armored_zombie_type( zombie_type )
{
    return issubstr( zombie_type, "armored" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xdd4b2d68, Offset: 0x568f
// Size: 0x4b, Type: bool
function private can_spawn_new_zombie( spawn_limit )
{
    max_active_zombies = spawn_limit ?? level.var_a009ab14ee0d3223.var_63a0ca44b877a390;
    active_zombies_count = zm_utility::get_active_zombies_count();
    
    if ( max_active_zombies > active_zombies_count )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 5, eflags: 0x4
// Checksum 0x86f21bb5, Offset: 0x56e3
// Size: 0x19b
function private function_83747b92feac2545( s_location, var_e917a56fdbc933d8, capturepoint, additional_pacing, var_80c704f236f3564c )
{
    if ( !level.ar_root.var_5176b479e65c46e8 )
    {
        return;
    }
    
    if ( zm_quest::is_quest_complete( #"hornet_mq_quest" ) || level utility::flag( "hornet_boss_fight_intro_complete" ) )
    {
        return;
    }
    
    if ( isalive( level.ar_root.ar_diana ) )
    {
        if ( level.ar_root.ar_diana getaiblackboarddynamic( "in_necrotic_projectile" ) )
        {
            level.ar_root.ar_diana utility::waittill_notify_or_timeout( "necrotic_projectile_end", 5 );
        }
        else if ( level.ar_root.ar_diana getaiblackboarddynamic( "in_necrotic_beam" ) )
        {
            level.ar_root.ar_diana utility::waittill_notify_or_timeout( "necrotic_beam_anim_end", 6 );
        }
        else
        {
            level.ar_root.ar_diana utility::waittill_notify_or_timeout( "idle_loop_end", 2 );
        }
        
        level thread function_545262c6bc7bf7eb( 1 );
        level waittill( #"hash_fb561e572dacbe7b" );
        
        if ( additional_pacing )
        {
            wait additional_pacing;
        }
        
        level thread function_c99eca18d740b11( s_location.origin, s_location.angles, var_e917a56fdbc933d8, capturepoint, var_80c704f236f3564c );
        return;
    }
    
    level thread function_c99eca18d740b11( s_location.origin, s_location.angles, var_e917a56fdbc933d8, capturepoint, var_80c704f236f3564c );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 5, eflags: 0x4
// Checksum 0x57b47fcc, Offset: 0x5886
// Size: 0x277
function private function_c99eca18d740b11( var_6c951a3f750463be, var_7129df545c5ee754, var_e917a56fdbc933d8, capturepoint, var_80c704f236f3564c )
{
    level.var_e9bce67d0022b869 = 99999;
    horizontaloffset = anglestoforward( var_7129df545c5ee754 ) * -1093.9;
    spawnoffset = ( horizontaloffset[ 0 ], horizontaloffset[ 1 ], 71036.9 );
    level.ar_root.ar_diana = agent_manager::spawn_agent( "zombie_diana_assault_rounds", var_6c951a3f750463be + spawnoffset, var_7129df545c5ee754 );
    level.ar_root.ar_diana.var_2fc3a5fb762afb6e = 0;
    level.ar_root.ar_diana.var_521099eccef67894 = 1;
    visibility_mode::function_3afc3bc470c80e61( level.ar_root.ar_diana, level.ar_root.ar_diana.team );
    
    if ( capturepoint )
    {
        level.ar_root.ar_diana.var_3ba5cca41a170ce1 = capturepoint;
    }
    
    level.ar_root.ar_diana thread function_ec9dd4d2ed7c991d();
    level.ar_root.ar_diana zm_zombie_diana::set_in_assault_rounds( 1 );
    level.ar_root.ar_diana namespace_a3bd843d6751814b::function_3a9122eed114c07e( var_e917a56fdbc933d8, var_80c704f236f3564c );
    function_99afd0123efb90a6( var_6c951a3f750463be, var_7129df545c5ee754 );
    playsoundatpos( var_6c951a3f750463be - ( 0, 0, 10000 ), #"hash_1e6cff3dc81fe6a1" );
    level.ar_root.ar_diana thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "assault_rounds_intro", "assault_rounds_intro", level.ar_root.ar_diana.origin, level.ar_root.ar_diana.angles, "entering_capture_point" );
    level.ar_root.ar_diana.var_982ca07527b7a9b9 = 1;
    level.ar_root.ar_diana utility::waittill_notify_or_timeout( "assault_rounds_intro_end", 12 );
    level.ar_root.ar_diana.var_982ca07527b7a9b9 = undefined;
    level notify( #"hash_c579d65184bf3689" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xd5e1b477, Offset: 0x5b05
// Size: 0x3a
function private function_ec9dd4d2ed7c991d()
{
    self waittill( #"death" );
    
    if ( level.ar_root.ar_diana == self )
    {
        level.ar_root.ar_diana = undefined;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x65a7e3e0, Offset: 0x5b47
// Size: 0x234
function private function_545262c6bc7bf7eb( var_d8b198a929cd8582 )
{
    level.var_e9bce67d0022b869 = undefined;
    
    if ( isalive( level.ar_root.ar_diana ) )
    {
        if ( !var_d8b198a929cd8582 )
        {
            level.ar_root.ar_diana utility::waittill_any_in_array_or_timeout( [ "idle_loop_end", "necrotic_projectile_end", "necrotic_beam_anim_end" ], 6 );
        }
        
        if ( isalive( level.ar_root.ar_diana ) )
        {
            if ( level.ar_root.ar_diana.animsetname == "zombie_diana" )
            {
                level.ar_root.ar_diana thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "assault_rounds_outro", "assault_rounds_outro", level.ar_root.ar_diana.origin, level.ar_root.ar_diana.angles, "exiting_capture_point" );
            }
            
            level.ar_root.ar_diana utility::waittill_any_timeout( 9, "assault_rounds_outro_end" );
            
            if ( isalive( level.ar_root.ar_diana ) )
            {
                if ( level.ar_root.ar_diana val::get( "magic_bullet_shield" ) || level.ar_root.ar_diana.magic_bullet_shield || level.ar_root.ar_diana.magic_bullet_shield || level.ar_root.ar_diana val::get( "damageshield" ) )
                {
                    level.ar_root.ar_diana ai::stop_magic_bullet_shield();
                    level.ar_root.ar_diana.magic_bullet_shield = 0;
                }
                
                level.ar_root.ar_diana kill();
            }
        }
    }
    
    level notify( #"hash_fb561e572dacbe7b" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0x66da1a95, Offset: 0x5d83
// Size: 0xd7
function private function_99afd0123efb90a6( var_6c951a3f750463be, var_7129df545c5ee754 )
{
    traversalattributes = {};
    traversalattributes.startpos = level.ar_root.ar_diana.origin;
    traversalattributes.endpos = var_6c951a3f750463be;
    traversalattributes.angles = var_7129df545c5ee754;
    
    if ( traversalattributes.startpos && traversalattributes.endpos && traversalattributes.angles )
    {
        level.ar_root.ar_diana settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0x4315f985, Offset: 0x5e62
// Size: 0x11b
function private function_c499ab7d5df01db1( target, slots, var_9a31c604833815d3 )
{
    if ( isdefined( level.ar_root.current_target ) )
    {
        function_9305ba9593068cb9( level.ar_root.current_target );
    }
    
    if ( isarray( target ) )
    {
        foreach ( individual_target in target )
        {
            individual_slots = sortbydistancecullbyradius( slots, individual_target.origin, 100 );
            make_target_attractor( individual_target, individual_slots, var_9a31c604833815d3 );
        }
    }
    else
    {
        make_target_attractor( target, slots, var_9a31c604833815d3 );
    }
    
    level callback::add( "on_ai_acquire_attractor", &set_attracted_vals );
    level callback::add( "on_ai_lose_attractor", &function_db285f1fd2fda425 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xab38255, Offset: 0x5f85
// Size: 0x1c3
function private set_attracted_vals( params )
{
    self endon( #"hash_4b5b25e0b274459c" );
    self endon( #"death" );
    
    if ( params.target_attractor.var_1d70653c6515a89a )
    {
        val::set( "ar_attr_zmb", "collide_with_ai_allies", 0 );
        val::set( "ar_attr_zmb", "script_pushable", 0 );
    }
    
    while ( isdefined( self.target_attractor_slot.origin ) && distancesquared( self.origin, self.target_attractor_slot.origin ) > 2500 )
    {
        wait 0.25;
    }
    
    if ( isdefined( self.target_attractor_slot.origin ) )
    {
        mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self.var_341da507139e9004 = mover;
        self motionwarpcancel();
        self linkto( mover );
        align_duration = 0.2;
        accel = 0.1;
        decel = 0.1;
        mover moveto( self.target_attractor_slot.origin, align_duration, accel, decel );
        mover rotateto( self.target_attractor_slot.angles, align_duration, accel, decel );
        mover waittill( #"movedone" );
        self unlink();
        mover delete();
        
        if ( isdefined( self ) && isdefined( self.target_attractor_slot ) )
        {
            self forceteleport( self.target_attractor_slot.origin, self.target_attractor_slot.angles );
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x51c9e011, Offset: 0x6150
// Size: 0x52
function private function_db285f1fd2fda425( params )
{
    self notify( #"hash_4b5b25e0b274459c" );
    
    if ( params.target_attractor.var_1d70653c6515a89a )
    {
        val::reset( "ar_attr_zmb", "collide_with_ai_allies" );
        val::reset( "ar_attr_zmb", "script_pushable" );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xa2d25e02, Offset: 0x61aa
// Size: 0x94
function private make_target_attractor( target, slots, var_9a31c604833815d3 )
{
    attractor = zombie_attractor_manager::add_attractor( target, 1, 4096, 1, undefined, &target_attractor_validator );
    zombie_attractor_manager::set_attractor_slots( attractor, slots );
    zombie_attractor_manager::function_a2aab3762aaa055f( attractor, target.origin + ( 0, 0, 30 ), var_9a31c604833815d3, target.angles );
    target.attractor = attractor;
    attractor.var_1d70653c6515a89a = 1;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xb10a88bd, Offset: 0x6246
// Size: 0x18e, Type: bool
function private target_attractor_validator( attractor, ai )
{
    if ( ai.aicategory != "normal" || ai.is_living_world_ai || issubstr( ai.subclass, "hellhound" ) )
    {
        return false;
    }
    
    if ( isdefined( ai.target_attractor_slot ) && distancesquared( ai.origin, ai.target_attractor_slot.origin ) < 2500 )
    {
        return true;
    }
    
    foreach ( slot in attractor.var_fc48cc6608c8d82c )
    {
        if ( isdefined( ai.target_attractor_slot ) )
        {
            continue;
        }
        
        if ( !isdefined( slot.var_80be1da0fa595ce1 ) )
        {
            return true;
        }
        
        if ( distancesquared( slot.origin, ai.origin ) < distancesquared( slot.origin, slot.var_80be1da0fa595ce1.origin ) )
        {
            slot.var_80be1da0fa595ce1.target_attractor_slot = undefined;
            slot.var_80be1da0fa595ce1 = undefined;
            return true;
        }
    }
    
    return true;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x54d7bed6, Offset: 0x63dd
// Size: 0xc9
function private function_9305ba9593068cb9( target )
{
    if ( isarray( target ) )
    {
        foreach ( single_target in target )
        {
            zombie_attractor_manager::remove_attractor( single_target.attractor );
        }
    }
    else
    {
        zombie_attractor_manager::remove_attractor( target.attractor );
    }
    
    level callback::remove( "on_ai_acquire_attractor", &set_attracted_vals );
    level callback::remove( "on_ai_lose_attractor", &function_db285f1fd2fda425 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xd6451f2e, Offset: 0x64ae
// Size: 0x93
function private track_target_damage( target, health, id )
{
    if ( id == "koma" )
    {
        level scriptable::scriptable_adddamagedcallback( &function_44250a01ec80281e );
    }
    else if ( id == "ban" )
    {
        level scriptable::scriptable_adddamagedcallback( &function_e7c571eab9b851fa );
    }
    
    level.ar_root.current_target = target;
    level.ar_root.current_max_health = health;
    level.ar_root.current_target_health = health;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x13c4d9f6, Offset: 0x6549
// Size: 0x89
function private update_health_progress()
{
    current_progress = int( level.ar_root.current_target_health / level.ar_root.current_max_health * 100 );
    current_progress = current_progress >= 0 ? current_progress : 0;
    level.ar_root.current_progress = current_progress;
    level zm_quest::function_9f49b2a045ece8ae( current_progress, 1, #"hash_5d06d71de9a9208e", level.ar_root.current_step_ref );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 11, eflags: 0x4
// Checksum 0x52856ddd, Offset: 0x65da
// Size: 0x449
function private function_44250a01ec80281e( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( isdefined( instance.type ) && getxhashasset( instance.type ) != %"zm_sat_hornet_komainu" )
    {
        return;
    }
    
    if ( !isscriptedai( eattacker ) || eattacker.team != zm_utility::get_zombie_team() )
    {
        return;
    }
    
    idamage = scale_zombie_damage( idamage );
    level.ar_root.current_target_health -= idamage;
    level.ar_root.var_4a7e5599df870947 = 1;
    update_health_progress();
    playsoundatpos( vpoint, #"hash_9c21d68e079c2861" );
    instance utility::function_32b24db3127bff40( "impacts", "small" );
    
    if ( level.ar_root.current_target_health <= 0 )
    {
        foreach ( target in level.ar_root.current_target )
        {
            target utility::function_32b24db3127bff40( "impacts", "large" );
            target utility::function_32b24db3127bff40( "damage", "none" );
            target utility::function_32b24db3127bff40( "audio", "lost" );
        }
        
        level scriptable::function_dc174fecebb79952( &function_44250a01ec80281e );
        level notify( #"ar_wave_ended" );
        return;
    }
    
    if ( level.ar_root.current_target_health <= level.ar_root.current_max_health * 0.25 )
    {
        foreach ( target in level.ar_root.current_target )
        {
            target utility::function_32b24db3127bff40( "damage", "persist" );
        }
        
        return;
    }
    
    if ( level.ar_root.current_target_health <= level.ar_root.current_max_health * 0.5 )
    {
        foreach ( target in level.ar_root.current_target )
        {
            target utility::function_32b24db3127bff40( "damage", "heavy" );
        }
        
        return;
    }
    
    if ( level.ar_root.current_target_health <= level.ar_root.current_max_health * 0.75 )
    {
        foreach ( target in level.ar_root.current_target )
        {
            target utility::function_32b24db3127bff40( "damage", "light" );
        }
        
        level thread function_2dee4539c035f1a7( level.ar_root.current_sector );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 11, eflags: 0x4
// Checksum 0x8f1bc4fa, Offset: 0x6a2b
// Size: 0x557
function private function_e7c571eab9b851fa( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( isdefined( instance.type ) && getxhashasset( instance.type ) != %"hash_51378b2eaa60d43" )
    {
        return;
    }
    
    if ( !isscriptedai( eattacker ) || eattacker.team != zm_utility::get_zombie_team() )
    {
        return;
    }
    
    idamage = scale_zombie_damage( idamage );
    level.ar_root.current_target_health -= idamage;
    update_health_progress();
    playsoundatpos( vpoint, #"hash_f677de5082a13eaf" );
    instance function_f27ed9845d047a7a( level.ar_root.current_progress );
    
    if ( instance.linked_banner )
    {
        instance function_f27ed9845d047a7a( level.ar_root.current_progress );
    }
    
    if ( level.ar_root.current_target_health <= 0 )
    {
        if ( isarray( level.ar_root.current_target ) )
        {
            foreach ( target in level.ar_root.current_target )
            {
                target utility::function_32b24db3127bff40( "damage", "none" );
            }
        }
        else
        {
            level.ar_root.current_target utility::function_32b24db3127bff40( "damage", "none" );
        }
        
        level scriptable::function_dc174fecebb79952( &function_e7c571eab9b851fa );
        level notify( #"ar_ended" );
        level notify( #"ar_failed" );
        function_3cb64952a26fdfc();
        return;
    }
    
    if ( level.ar_root.current_target_health <= level.ar_root.current_max_health * 0.25 )
    {
        if ( isarray( level.ar_root.current_target ) )
        {
            foreach ( target in level.ar_root.current_target )
            {
                target utility::function_32b24db3127bff40( "damage", "persist" );
            }
        }
        else
        {
            level.ar_root.current_target utility::function_32b24db3127bff40( "damage", "persist" );
        }
        
        return;
    }
    
    if ( level.ar_root.current_target_health <= level.ar_root.current_max_health * 0.5 )
    {
        if ( isarray( level.ar_root.current_target ) )
        {
            foreach ( target in level.ar_root.current_target )
            {
                target utility::function_32b24db3127bff40( "damage", "heavy" );
            }
        }
        else
        {
            level.ar_root.current_target utility::function_32b24db3127bff40( "damage", "heavy" );
        }
        
        return;
    }
    
    if ( level.ar_root.current_target_health <= level.ar_root.current_max_health * 0.75 )
    {
        if ( isarray( level.ar_root.current_target ) )
        {
            foreach ( target in level.ar_root.current_target )
            {
                target utility::function_32b24db3127bff40( "damage", "light" );
            }
        }
        else
        {
            level.ar_root.current_target utility::function_32b24db3127bff40( "damage", "light" );
        }
        
        level thread function_4b2c95a06e334219( level.ar_root.current_sector );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x56578b00, Offset: 0x6f8a
// Size: 0x19a
function private function_3cb64952a26fdfc( sector_override )
{
    var_e917a56fdbc933d8 = sector_override ?? level.ar_root.current_sector;
    function_bb5a288577c0019c( var_e917a56fdbc933d8 );
    function_986682c9e6b89ac0( var_e917a56fdbc933d8, 1 );
    zombify_sector( var_e917a56fdbc933d8 );
    level thread function_cdc19630f8b6f1d1();
    wait 1.75;
    b_ignore_end_round = level.active_relic_challenge;
    
    if ( !b_ignore_end_round )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
    else
    {
        function_ae879757529e15f2( { #b_success:0 } );
        musicbank_utility::function_4f253fd35ec68cbc( level.players, #"assault_round" );
        musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_80d254a74920ee96" );
    }
    
    level.var_23f0535ecbba9ff3 = 1;
    level thread function_5535a837de88a60b( "sat_zm_hornet_ar_end_fail", 2 );
    playsoundatpos( ( 0, 0, 0 ), #"hash_28eeb659d2a80556" );
    level.ar_root.var_6ddc7f0933329fff = undefined;
    musicbank_utility::function_5aca66c390aa347d( level.players, #"assault_round_fail" );
    level thread function_4fe47c350fbe670e();
    
    if ( var_e917a56fdbc933d8 == "ar_sec4" || getdvarint( @"hash_8188cb24b04c49c2", 0 ) )
    {
        function_5c92fe0be85c3e3b();
        return;
    }
    
    if ( !level.ar_root.var_fe95ca6644d31a53 && getdvarint( @"hash_60475263171c0038", 1 ) )
    {
        level.ar_root.var_fe95ca6644d31a53 = 1;
        level thread function_8a1ae87516c9e769();
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x3af0f198, Offset: 0x712c
// Size: 0x1d4
function private zombify_sector( var_e917a56fdbc933d8 )
{
    level.ar_root.var_35233896c682d3ea = arraycombineunique( level.ar_root.var_35233896c682d3ea, [ var_e917a56fdbc933d8 ] );
    var_cfdcb332178e0755 = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
    level.ar_root.zombified_zones = arraycombineunique( level.ar_root.zombified_zones, var_cfdcb332178e0755 );
    
    foreach ( zone in var_cfdcb332178e0755 )
    {
        gen_zone_name = zm_utility::function_fbb7d4c98261e273( zone );
        zm_utility::function_549e7bc8f78816f2( [ gen_zone_name ], level.var_6f89b56853b0e818 );
        function_1c0464c42c04b002( 1, gen_zone_name );
    }
    
    s_trap_root = level.ar_root.var_2747e0528b1f176[ var_e917a56fdbc933d8 ];
    zm_sat_hornet_murder_holes::function_9ceca8d29317aa92( s_trap_root );
    banner = level.ar_root.var_7130ff0005fdba3e[ var_e917a56fdbc933d8 ];
    banner.var_e917a56fdbc933d8 = var_e917a56fdbc933d8;
    banner thread function_e063c51cf066875d( "zombie" );
    banner utility::function_32b24db3127bff40( "model", "zombie" );
    setup_recapture_interact( banner );
    
    if ( isdefined( banner.linked_banner ) )
    {
        banner.linked_banner.var_e917a56fdbc933d8 = var_e917a56fdbc933d8;
        setup_recapture_interact( banner.linked_banner );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x2689ec3c, Offset: 0x7308
// Size: 0x1a5
function private setup_recapture_interact( banner )
{
    s_banner = banner.s_banner;
    var_afe1b0748facfa77 = vectornormalize( anglestoforward( s_banner.angles ) ) * 32 + s_banner.origin;
    s_banner.interact = interaction::register_interact( var_afe1b0748facfa77 + ( 0, 0, 80 ), 80, &function_edd6fd86cb0045ba, undefined, undefined, undefined, 1, undefined, 1 );
    s_banner.interact interaction::set_interact_hint_callback( &banner_hint );
    s_banner.interact.s_banner = s_banner;
    s_banner.interact.banner = banner;
    s_banner thread function_ba755c3ed9de2375();
    s_banner.var_5cc061d568e1fe48 = 1;
    
    if ( s_banner.script_noteworthy == "3" )
    {
        s_banner.var_c60fa5cf14135042 = "zone_main_bailey";
        s_banner.str_flag = "banner_north";
    }
    
    if ( s_banner.script_noteworthy == "2" )
    {
        s_banner.var_c60fa5cf14135042 = "zone_lava_garden";
        s_banner.str_flag = "banner_east";
    }
    
    if ( s_banner.script_noteworthy == "1" )
    {
        s_banner.var_c60fa5cf14135042 = "zone_lava_tubes";
        s_banner.str_flag = "banner_south";
        return;
    }
    
    s_banner.var_c60fa5cf14135042 = "zone_west_bailey";
    s_banner.str_flag = "banner_west";
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x714b433f, Offset: 0x74b5
// Size: 0x273
function private function_ad95c089819e6f40( var_e917a56fdbc933d8 )
{
    function_adc058729e55c4dd( var_e917a56fdbc933d8 );
    function_986682c9e6b89ac0( var_e917a56fdbc933d8, 0 );
    banner = level.ar_root.var_7130ff0005fdba3e[ var_e917a56fdbc933d8 ];
    banner notify( #"transition_complete" );
    level.ar_root.var_35233896c682d3ea = arrayremove( level.ar_root.var_35233896c682d3ea, var_e917a56fdbc933d8 );
    var_cfdcb332178e0755 = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
    level.ar_root.zombified_zones = arrayremove( level.ar_root.zombified_zones, var_cfdcb332178e0755 );
    
    foreach ( zone in var_cfdcb332178e0755 )
    {
        gen_zone_name = zm_utility::function_fbb7d4c98261e273( zone );
        zm_utility::function_81ecff068420355d( [ gen_zone_name ], level.var_6f89b56853b0e818 );
        function_1c0464c42c04b002( 0, gen_zone_name );
    }
    
    s_trap_root = level.ar_root.var_2747e0528b1f176[ var_e917a56fdbc933d8 ];
    zm_sat_hornet_murder_holes::function_a5a77f6d33ed909( s_trap_root );
    
    foreach ( player in level.players )
    {
        if ( level.var_8f0df0c14a98e9f2 )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_sector_recapture", #"bc_flavor_player_positive" );
        }
    }
    
    if ( var_e917a56fdbc933d8 == "ar_sec4" )
    {
        level notify( #"hash_d47f58bf451ccd6e" );
    }
    
    if ( !level.ar_root.var_35233896c682d3ea.size && level.ar_root.var_fe95ca6644d31a53 )
    {
        level notify( #"hash_2bf4a4ae4614c47f" );
        level.ar_root.var_fe95ca6644d31a53 = undefined;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xa7466ece, Offset: 0x7730
// Size: 0x8e
function private function_1c0464c42c04b002( var_762f5d19a53f7c0, gen_zone_name )
{
    switch ( gen_zone_name )
    {
        case #"hash_4650e8a67fbfcb73":
            str_world_event = "we_lgt_zm_arsenal_kitchens";
            break;
        case #"hash_97ed6ef0fe9821f3":
            str_world_event = "we_lgt_zm_arsenal_mainkeep";
            break;
        case #"hash_d5e7630614fde63a":
            str_world_event = "we_lgt_zm_arsenal_stables";
            break;
        default:
            return;
    }
    
    if ( var_762f5d19a53f7c0 )
    {
        activateworldevent( str_world_event );
        return;
    }
    
    deactivateworldevent( str_world_event );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0xf8d639f5, Offset: 0x77c6
// Size: 0xe5
function function_e063c51cf066875d( str_state )
{
    level endon( #"game_ended" );
    self endon( #"recapture_failed" );
    
    if ( str_state == "player" )
    {
        self setscriptablepartstate( "vfx", "transition_loop" );
        
        if ( isdefined( self.linked_banner ) )
        {
            self.linked_banner setscriptablepartstate( "vfx", "transition_loop" );
        }
        
        self waittill( #"transition_complete" );
    }
    
    oneshot_state = "transition_oneshot";
    
    if ( str_state != "player" )
    {
        oneshot_state = "transition_oneshot_ar";
    }
    
    self setscriptablepartstate( "vfx", oneshot_state );
    self setscriptablepartstate( "model", str_state );
    
    if ( isdefined( self.linked_banner ) )
    {
        self.linked_banner setscriptablepartstate( "vfx", oneshot_state );
        self.linked_banner setscriptablepartstate( "model", str_state );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x9d1904b3, Offset: 0x78b3
// Size: 0x410
function private function_fcef63189bf0928b( params )
{
    feature = params.feature;
    
    if ( !isdefined( feature ) )
    {
        return;
    }
    
    if ( !arraycontains( level.var_6f89b56853b0e818, params.type ) )
    {
        return;
    }
    
    throttle::throttle_wait_in_queue( level.ar_root.var_fbbf92f9d8d3285d, feature );
    
    if ( feature.wallbuy_scriptable && !issubstr( feature.script_noteworthy, "armor" ) )
    {
        wallbuy::function_ef135a26415497af( feature.wallbuy_scriptable, "white" );
        feature.wallbuy_scriptable.disable_upgrade = 1;
    }
    
    if ( feature.wallbuy_scriptable )
    {
        feature.wallbuy_scriptable setscriptablepartstate( "emissive", "off" );
        feature.wallbuy_scriptable function_7653c765b6c7b815();
    }
    
    if ( !isdefined( feature.disabled_glyph ) )
    {
        location = feature.origin;
        offset = ( 0, 0, 0 );
        angles = ( 0, 0, 0 );
        offset_amount = 25;
        
        if ( isdefined( feature.mdl_magicbox.interact.origin ) )
        {
            location = feature.mdl_magicbox.interact.origin;
            offset = anglestoleft( feature.angles ) * offset_amount;
            angles = feature.mdl_magicbox.angles + ( 0, 90, 0 );
            feature.b_skip_firesale = 1;
        }
        else if ( isdefined( feature.mdl_perk_machine.interact.origin ) )
        {
            location = feature.mdl_perk_machine.interact.origin;
            offset = anglestoforward( feature.angles ) * offset_amount + ( 0, 0, 16 );
            angles = feature.mdl_perk_machine.angles;
        }
        else if ( isdefined( feature.var_7fac639c5e7fd54.interact.origin ) )
        {
            location = feature.var_7fac639c5e7fd54.interact.origin;
            offset = anglestoforward( feature.angles ) * ( offset_amount + 10 ) + ( 0, 0, 12 );
            angles = feature.var_7fac639c5e7fd54.angles;
        }
        else if ( isdefined( feature.mdl_arsenal.interact.origin ) )
        {
            location = feature.mdl_arsenal.interact.origin;
            offset = ( 0, 0, -14 );
            angles = feature.mdl_arsenal.angles;
        }
        else if ( isdefined( feature.angles ) )
        {
            offset = ( 0, 0, -40 ) + anglestoright( feature.angles ) * 4;
            angles = feature.angles + ( 0, -90, 0 );
        }
        
        portal = spawnscriptable( %"hash_1b4f96c8f667046c", location + offset, angles );
        feature.disabled_glyph = portal;
    }
    
    feature.disabled_glyph setscriptablepartstate( "base", "lock" );
    feature.disabled_glyph setscriptablepartstate( "hint", "enabled" );
    feature.disabled_glyph interaction::set_interact_hint_callback( &function_18d967599670a0bc );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0x2c8509e0, Offset: 0x7ccb
// Size: 0x40
function private function_18d967599670a0bc( usable, player )
{
    return { #var_26bbd300351fde34:0, #string:&"hash_3c14bde4d45c3e8c", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xa58a464c, Offset: 0x7d14
// Size: 0xb1
function private function_288b367d399ca826( params )
{
    var_349a0723ed9ac19c = self;
    wait 5.25;
    
    if ( !isdefined( var_349a0723ed9ac19c ) || !isdefined( var_349a0723ed9ac19c.mdl_magicbox ) )
    {
        return;
    }
    
    if ( !arraycontains( level.var_6f89b56853b0e818, "magicbox" ) )
    {
        return;
    }
    
    if ( !isdefined( level.ar_root ) || !isdefined( level.ar_root.zombified_zones ) )
    {
        return;
    }
    
    zone_name = var_349a0723ed9ac19c get_feature_zone_name();
    
    if ( !function_bb933b778292b564( zone_name ) && !function_9383be1b4daa14e5( zone_name ) )
    {
        return;
    }
    
    content_manager::disable_feature( var_349a0723ed9ac19c, "magicbox" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x1d00db3e, Offset: 0x7dcd
// Size: 0x50, Type: bool
function private function_9383be1b4daa14e5( zone_name )
{
    gen_zone_name = zm_utility::function_fbb7d4c98261e273( zone_name );
    return level.hornet_pap_quest.var_60f10a48d7117b2e && arraycontains( level.hornet_pap_quest.var_60f10a48d7117b2e, gen_zone_name );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x6f143377, Offset: 0x7e26
// Size: 0x9e
function private get_feature_zone_name()
{
    if ( isdefined( self.zone_name ) )
    {
        return self.zone_name;
    }
    
    feature_zone = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( isdefined( feature_zone ) )
    {
        self.zone_name = feature_zone.zone_name;
    }
    
    if ( !isdefined( self.zone_name ) )
    {
        tacpoint = ai::function_20e2b5e7fcba9f36( self.origin, 256, 0, 128 );
        
        if ( isdefined( tacpoint ) )
        {
            self.zone_name = tacpoint.var_6f9c4e415e80942f;
        }
    }
    
    return self.zone_name;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x851311ab, Offset: 0x7ecd
// Size: 0x142
function private on_feature_enabled( params )
{
    feature = params.feature;
    
    if ( !isdefined( feature ) )
    {
        return;
    }
    
    if ( !arraycontains( level.var_6f89b56853b0e818, params.type ) )
    {
        return;
    }
    
    throttle::throttle_wait_in_queue( level.ar_root.var_fbbf92f9d8d3285d, feature );
    
    if ( feature.wallbuy_scriptable && !issubstr( feature.script_noteworthy, "armor" ) )
    {
        wallbuy::function_ef135a26415497af( feature.wallbuy_scriptable, feature.wallbuy_scriptable.rarity );
        feature.wallbuy_scriptable.disable_upgrade = undefined;
    }
    
    if ( feature.wallbuy_scriptable )
    {
        feature.wallbuy_scriptable setscriptablepartstate( "emissive", "on" );
        feature.wallbuy_scriptable function_e203bba36cfb19d0();
    }
    
    if ( isdefined( feature.disabled_glyph ) )
    {
        feature.disabled_glyph freescriptable();
        feature.disabled_glyph = undefined;
    }
    
    if ( feature.mdl_magicbox )
    {
        feature.b_skip_firesale = undefined;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xe46649ac, Offset: 0x8017
// Size: 0x2db
function private function_8c5d51e7dc3a3cea()
{
    level endon( #"game_ended" );
    level scriptable::function_dc174fecebb79952( &function_44250a01ec80281e );
    level scriptable::function_dc174fecebb79952( &function_e7c571eab9b851fa );
    
    foreach ( komainu in level.ar_root.a_first_target[ level.ar_root.current_sector ] )
    {
        komainu utility::function_32b24db3127bff40( "damage", "none" );
    }
    
    s_trap_root = level.ar_root.var_2747e0528b1f176[ level.ar_root.current_sector ];
    zm_sat_hornet_murder_holes::function_a5a77f6d33ed909( s_trap_root );
    level thread function_c01788e694411086();
    banner = level.ar_root.var_7130ff0005fdba3e[ level.ar_root.current_sector ];
    banner utility::function_32b24db3127bff40( "damage", "none" );
    banner utility::function_32b24db3127bff40( "model", "player" );
    banner utility::function_32b24db3127bff40( "reveal", "full_player" );
    level thread function_cdc19630f8b6f1d1();
    wait 1.75;
    b_ignore_end_round = level.active_relic_challenge;
    
    if ( !b_ignore_end_round )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
    else
    {
        function_ae879757529e15f2( { #b_success:1 } );
        musicbank_utility::function_4f253fd35ec68cbc( level.players, #"assault_round" );
        musicbank_utility::function_4f253fd35ec68cbc( level.players, #"hash_80d254a74920ee96" );
    }
    
    level thread function_5535a837de88a60b( "sat_zm_hornet_ar_end_success", 2 );
    playsoundatpos( ( 0, 0, 0 ), #"hash_28eeb659d2a80556" );
    level.ar_root.var_6ddc7f0933329fff = undefined;
    musicbank_utility::function_5aca66c390aa347d( level.players, #"assault_round_success" );
    level function_b0b05d69a4e0fdcb();
    
    foreach ( player in level.players )
    {
        player thread utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_87e01be9659e3568", #"zm_sat_hornet_assault_round_success" );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xd48ede1a, Offset: 0x82fa
// Size: 0x185
function private function_c01788e694411086()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.ar_root.current_sector ) )
    {
        return;
    }
    
    if ( level.ar_root.var_eec469e42bd3390c )
    {
        banner = level.ar_root.var_7130ff0005fdba3e[ level.ar_root.current_sector ];
        forward = anglestoforward( banner.angles );
        pos = banner.origin + forward * 30;
    }
    else
    {
        a_komainu = level.ar_root.a_first_target[ level.ar_root.current_sector ];
        
        if ( a_komainu.size < 2 )
        {
            return;
        }
        
        pos = ( a_komainu[ 0 ].origin + a_komainu[ 1 ].origin ) / 2;
    }
    
    pos = getgroundposition( pos, 1 ) + ( 0, 0, 20 );
    b_no_damage = !level.ar_root.var_4a7e5599df870947;
    wait 2;
    powerups::powerup_drop( "full_ammo", pos, undefined, undefined, "assault_round" );
    
    if ( b_no_damage )
    {
        armor_pos = pos + ( 30, 30, 0 );
        powerups::powerup_drop( "full_armor", armor_pos, undefined, undefined, "assault_round" );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x2d2e98c3, Offset: 0x8487
// Size: 0x91
function private function_bb5a288577c0019c( var_e917a56fdbc933d8 )
{
    var_de84a9d0da66a3cc = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
    
    foreach ( zone_name in var_de84a9d0da66a3cc )
    {
        level thread zm_sat_hornet_weather_ash::function_6f9a9c8f4f91f3a4( zone_name );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x18767dd, Offset: 0x8520
// Size: 0x91
function private function_adc058729e55c4dd( var_e917a56fdbc933d8 )
{
    var_de84a9d0da66a3cc = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
    
    foreach ( zone_name in var_de84a9d0da66a3cc )
    {
        level thread zm_sat_hornet_weather_ash::function_502a6d0994562459( zone_name );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xbc645538, Offset: 0x85b9
// Size: 0x12
function private function_835abf03a06bcd20()
{
    crafting_table::function_a2f9d132dd19ad1a( #"crafting_table_discount" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2
// Checksum 0x14a41bc1, Offset: 0x85d3
// Size: 0x3a2
function function_40eb772f9085ef92( var_f1fbc291f2430b1e, var_c9d2f01aafdb2ecc = 0 )
{
    if ( !isdefined( level.ar_root.var_518864f924edcfb6 ) )
    {
        level.ar_root.var_518864f924edcfb6 = purchasemenu::function_cc7a4eca046e03ee( #"crafting_table_discount" );
    }
    
    if ( var_f1fbc291f2430b1e )
    {
        if ( !level.ar_root.var_2cf04a4ed0540f8d )
        {
            level.ar_root.var_2cf04a4ed0540f8d = 1;
            
            foreach ( player in level.players )
            {
                player.var_d1b557dbfbe1e196 = #"crafting_table_discount";
                player.var_bd41252f91112b87 = 0;
                player callback::add( "on_crafting_item_success", &function_c076374039983e34, { #var_c9d2f01aafdb2ecc:var_c9d2f01aafdb2ecc } );
                player setclientomnvar( level.ar_root.var_518864f924edcfb6, 1 );
            }
            
            foreach ( s_crafting_table in level.a_s_crafting_tables )
            {
                effect = spawnscriptable( %"hash_1b4f96c8f667046c", s_crafting_table.var_7fac639c5e7fd54.origin, s_crafting_table.var_7fac639c5e7fd54.angles );
                effect setscriptablepartstate( "base", "craft" );
                s_crafting_table.var_8368d6a3e2161ba3 = effect;
            }
        }
        
        return;
    }
    
    level.ar_root.var_2cf04a4ed0540f8d = undefined;
    level.var_d1b557dbfbe1e196 = undefined;
    
    foreach ( player in level.players )
    {
        player.var_d1b557dbfbe1e196 = undefined;
        player.var_bd41252f91112b87 = undefined;
        player callback::remove( "on_crafting_item_success", &function_c076374039983e34 );
        player setclientomnvar( level.ar_root.var_518864f924edcfb6, 0 );
        
        if ( level.crafting_table_menu namespace_c1f157ec34641640::is_open( player ) )
        {
            level.crafting_table_menu namespace_c1f157ec34641640::close( player );
        }
    }
    
    foreach ( s_crafting_table in level.a_s_crafting_tables )
    {
        if ( s_crafting_table.var_8368d6a3e2161ba3 )
        {
            s_crafting_table.var_8368d6a3e2161ba3 freescriptable();
            s_crafting_table.var_8368d6a3e2161ba3 = undefined;
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xa85d154c, Offset: 0x897d
// Size: 0x15d
function private function_c076374039983e34( params, var_b19ce51dfc12b7f8 )
{
    item = params.item;
    
    if ( !item )
    {
        return;
    }
    
    if ( level.ar_root.var_816db095a80ba793 && level utility::flag( "mq_step_11_complete" ) && !level utility::flag( "mq_step_12_complete" ) )
    {
        if ( issubstr( item.itemref, "decoy" ) )
        {
            return;
        }
    }
    
    self.var_bd41252f91112b87 = ( self.var_bd41252f91112b87 ?? 0 ) + item.cost;
    
    if ( self.var_bd41252f91112b87 >= function_1011ec95b1eb9556() )
    {
        self.var_d1b557dbfbe1e196 = undefined;
        
        if ( level.crafting_table_menu namespace_c1f157ec34641640::is_open( self ) )
        {
            level.crafting_table_menu namespace_c1f157ec34641640::close( self );
        }
        
        self setclientomnvar( level.ar_root.var_518864f924edcfb6, 0 );
        callback::remove( "on_crafting_item_success", &function_c076374039983e34 );
        
        if ( level.ar_root.var_816db095a80ba793 && level utility::flag( "mq_step_11_complete" ) && !level utility::flag( "mq_step_12_complete" ) )
        {
            if ( var_b19ce51dfc12b7f8.var_c9d2f01aafdb2ecc )
            {
                function_40eb772f9085ef92( 0 );
            }
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x1040fe7f, Offset: 0x8ae2
// Size: 0x1c9
function function_edd6fd86cb0045ba( player )
{
    if ( player.interactions_disabled || self.s_banner.is_capturing || self.s_banner.var_18b773b3291055b8 )
    {
        return;
    }
    
    self.s_banner.is_capturing = 1;
    self.s_banner.var_87dd3688c0c064f4 = [];
    self.s_banner.var_9c4902579134d834 = [];
    
    if ( isdefined( self.banner.linked_banner ) )
    {
        self.s_banner.var_678106344b2cefd8 = self.banner.linked_banner.s_banner;
        self.banner.linked_banner.s_banner.is_capturing = 1;
    }
    
    function_5c9b2c6a0019344( player, self.s_banner );
    self.banner thread function_e063c51cf066875d( "player" );
    self.s_banner thread function_5462496b3794dac0( get_defend_time() );
    self.s_banner thread banner_spawn_zombies();
    self.s_banner thread function_6919121fac8d500b();
    self.s_banner thread function_6ed70e3e9718050();
    self.s_banner thread banner_recapture_ended();
    var_e50080547879e440 = function_acaabe946d73df36( self.s_banner.var_e917a56fdbc933d8 );
    level thread zm_music::start_zone_music_watcher( "recapture_music_" + self.s_banner.var_e917a56fdbc933d8, var_e50080547879e440, #"point_recapture" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0xd46a20a9, Offset: 0x8cb3
// Size: 0x1eb
function banner_recapture_ended()
{
    self endon( #"deleted" );
    msg = utility::waittill_any_return( "recaptured", "recapture_failed" );
    var_f28c8f4b436957e2 = "recapture_music_" + self.var_e917a56fdbc933d8;
    level thread zm_music::function_e9fd14ede793ef0d( var_f28c8f4b436957e2 );
    var_e50080547879e440 = function_7ef58899cffe2533( self.var_e917a56fdbc933d8 );
    
    if ( msg == "recaptured" )
    {
        level thread zm_music::start_zone_music_watcher( var_f28c8f4b436957e2, var_e50080547879e440, #"hash_d116ad8a903770e3" );
    }
    else
    {
        level thread zm_music::start_zone_music_watcher( var_f28c8f4b436957e2, var_e50080547879e440, #"hash_5c17b2b3e9c97104" );
    }
    
    foreach ( player in self.var_eba6f4476a550b95 )
    {
        if ( isdefined( player ) )
        {
            player val::reset( "banner_recapture", "round_spawning_ignore_player" );
        }
    }
    
    self.var_eba6f4476a550b95 = [];
    self.sc_banner setscriptablepartstate( "vfx", "none" );
    
    if ( isdefined( self.sc_banner.linked_banner ) )
    {
        self.sc_banner.linked_banner setscriptablepartstate( "vfx", "none" );
    }
    
    if ( msg == "recapture_failed" )
    {
        level thread function_26c9f0fe69b6d50();
        self.sc_banner setscriptablepartstate( "vfx", "dr_glyph" );
        
        if ( isdefined( self.sc_banner.linked_banner ) )
        {
            self.sc_banner.linked_banner setscriptablepartstate( "vfx", "dr_glyph" );
        }
    }
    
    cleanup_recapture_guidance( msg );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x21311cdc, Offset: 0x8ea6
// Size: 0x20d
function function_6ed70e3e9718050()
{
    self endon( #"deleted" );
    self endon( #"recaptured", #"recapture_failed" );
    self.var_eba6f4476a550b95 = [];
    
    while ( true )
    {
        var_2323bfac383a34fa = self.var_78e9c8539fefbf9d ?? [];
        
        foreach ( player in var_2323bfac383a34fa )
        {
            if ( !arraycontains( self.var_eba6f4476a550b95, player ) )
            {
                player val::set( "banner_recapture", "round_spawning_ignore_player", 1 );
                self.var_eba6f4476a550b95[ self.var_eba6f4476a550b95.size ] = player;
            }
        }
        
        a_to_remove = [];
        
        foreach ( player in self.var_eba6f4476a550b95 )
        {
            if ( !arraycontains( var_2323bfac383a34fa, player ) )
            {
                if ( isdefined( player ) )
                {
                    player val::reset( "banner_recapture", "round_spawning_ignore_player" );
                }
                
                a_to_remove[ a_to_remove.size ] = player;
            }
        }
        
        foreach ( player in a_to_remove )
        {
            self.var_eba6f4476a550b95 = arrayremove( self.var_eba6f4476a550b95, player );
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2
// Checksum 0x10b13b67, Offset: 0x90bb
// Size: 0xcd
function function_5c9b2c6a0019344( player, s_banner )
{
    recapture_progress = s_banner.recap_progress ?? 0;
    recapture_progress = recapture_progress >= 0 ? recapture_progress : 0;
    player zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hash_5d06d71de9a9208e", #"recap" );
    player zm_quest::function_fb3af5600f6a9441( 2, 0, #"hash_5d06d71de9a9208e", #"recap" );
    player zm_quest::function_9f49b2a045ece8ae( recapture_progress, 0, #"hash_5d06d71de9a9208e", #"recap" );
    function_1fa5bfd36bb20e8( s_banner );
    function_6419540d693e611e( s_banner, 0 );
    s_banner.var_87dd3688c0c064f4 = arraycombineunique( s_banner.var_87dd3688c0c064f4, [ player ] );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2
// Checksum 0x40edea55, Offset: 0x9190
// Size: 0x4f
function function_153531ff031a78ef( player, s_banner )
{
    player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_5d06d71de9a9208e", #"recap" );
    s_banner.var_87dd3688c0c064f4 = arrayremove( s_banner.var_87dd3688c0c064f4, player );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xf06e0c04, Offset: 0x91e7
// Size: 0x66
function private function_de731d07f9394ff9( player, s_banner )
{
    if ( !s_banner.objid )
    {
        return;
    }
    
    objidpoolmanager::objective_pin_player( s_banner.objid, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
    s_banner.var_9c4902579134d834 = arraycombineunique( s_banner.var_9c4902579134d834, [ player ] );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0x8bc139a3, Offset: 0x9255
// Size: 0x60
function private function_db13e8c293000cc6( player, s_banner )
{
    if ( !s_banner.objid )
    {
        return;
    }
    
    objidpoolmanager::objective_unpin_player( s_banner.objid, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
    s_banner.var_9c4902579134d834 = arrayremove( s_banner.var_9c4902579134d834, player );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2
// Checksum 0x58f6e89f, Offset: 0x92bd
// Size: 0xc6
function function_1fa5bfd36bb20e8( s_banner, n_offset = 140 )
{
    if ( !s_banner.objid && s_banner.var_5cc061d568e1fe48 )
    {
        var_3017d07087bdb6c1 = level.var_a74764204d9643c;
        level.var_a74764204d9643c = undefined;
        s_banner.objid = zm_quest::function_b98d4144845ffc13( "bnr_" + s_banner.var_e917a56fdbc933d8, 1, "sat_ui_hud_zm_assault_round_icon", undefined, "current", s_banner.origin, n_offset );
        level.var_a74764204d9643c = var_3017d07087bdb6c1;
        
        if ( isdefined( s_banner.objid ) )
        {
            objidpoolmanager::update_objective_setbackground( s_banner.objid, 1 );
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xefc39da2, Offset: 0x938b
// Size: 0x4d
function private function_de7a30ef28a3d91( s_banner )
{
    if ( s_banner.objid && !objidpoolmanager::function_fb05d646a96ed99e( s_banner.objid ) )
    {
        objidpoolmanager::returnobjectiveid( s_banner.objid );
        s_banner.objid = undefined;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xd2a4e683, Offset: 0x93e0
// Size: 0xd5
function private function_6419540d693e611e( s_banner, progress = 0 )
{
    if ( s_banner.objid )
    {
        if ( progress <= 0 )
        {
            progress = 0;
            objidpoolmanager::objective_set_show_progress( s_banner.objid, 0 );
            objidpoolmanager::update_objective_setneutrallabel( s_banner.objid, &"" );
        }
        else
        {
            objidpoolmanager::objective_set_show_progress( s_banner.objid, 1 );
            
            if ( s_banner.var_b528f1a3120ba1bd )
            {
                objidpoolmanager::update_objective_setneutrallabel( s_banner.objid, &"hash_17e525ee48ac3dcf" );
            }
            else
            {
                objidpoolmanager::update_objective_setneutrallabel( s_banner.objid, &"MP_INGAME_ONLY/OBJ_LOSING_CAPS" );
            }
        }
        
        objidpoolmanager::objective_set_progress( s_banner.objid, progress );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x2224c4ec, Offset: 0x94bd
// Size: 0x111
function private function_b28a9ebd2272e937()
{
    self endon( #"recaptured", #"recapture_failed" );
    n_display = ( self.recap_progress ?? 0 ) / 100;
    n_last_target = n_display;
    var_eef2435b4425e4d3 = 0;
    var_a08731824a7c9a2f = 0;
    
    while ( true )
    {
        var_e40e771c883c3094 = ( self.recap_progress ?? 0 ) / 100;
        
        if ( var_e40e771c883c3094 != n_last_target )
        {
            if ( var_a08731824a7c9a2f > 0 )
            {
                var_eef2435b4425e4d3 = ( var_e40e771c883c3094 - n_last_target ) / var_a08731824a7c9a2f;
            }
            
            n_last_target = var_e40e771c883c3094;
            var_a08731824a7c9a2f = 0;
        }
        
        n_projected = var_e40e771c883c3094 + var_eef2435b4425e4d3 * min( var_a08731824a7c9a2f, 1 );
        n_projected = max( min( n_projected, 1 ), 0 );
        n_display += ( n_projected - n_display ) * min( 0.4, 1 );
        
        if ( abs( n_projected - n_display ) < 0.001 )
        {
            n_display = n_projected;
        }
        
        function_6419540d693e611e( self, n_display );
        var_a08731824a7c9a2f += 0.05;
        wait 0.05;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x81e7474c, Offset: 0x95d6
// Size: 0x4a
function private function_57d4ca0fd032cffd()
{
    self endon( #"recaptured", #"recapture_failed" );
    
    while ( true )
    {
        if ( self.recap_progress )
        {
            self.sc_banner function_f27ed9845d047a7a( self.recap_progress );
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xe4e8f740, Offset: 0x9628
// Size: 0x119
function private function_f27ed9845d047a7a( progress )
{
    if ( progress < 10 )
    {
        utility::function_32b24db3127bff40( "reveal", "00_percent" );
        return;
    }
    
    if ( progress < 20 )
    {
        utility::function_32b24db3127bff40( "reveal", "10_percent" );
        return;
    }
    
    if ( progress < 30 )
    {
        utility::function_32b24db3127bff40( "reveal", "20_percent" );
        return;
    }
    
    if ( progress < 40 )
    {
        utility::function_32b24db3127bff40( "reveal", "30_percent" );
        return;
    }
    
    if ( progress < 50 )
    {
        utility::function_32b24db3127bff40( "reveal", "40_percent" );
        return;
    }
    
    if ( progress < 60 )
    {
        utility::function_32b24db3127bff40( "reveal", "50_percent" );
        return;
    }
    
    if ( progress < 70 )
    {
        utility::function_32b24db3127bff40( "reveal", "60_percent" );
        return;
    }
    
    if ( progress < 80 )
    {
        utility::function_32b24db3127bff40( "reveal", "70_percent" );
        return;
    }
    
    if ( progress < 90 )
    {
        utility::function_32b24db3127bff40( "reveal", "80_percent" );
        return;
    }
    
    utility::function_32b24db3127bff40( "reveal", "90_percent" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x7fed563b, Offset: 0x9749
// Size: 0x20a
function function_6919121fac8d500b()
{
    self endon( #"recaptured", #"recapture_failed" );
    
    if ( !isdefined( self.var_87dd3688c0c064f4 ) )
    {
        self.var_87dd3688c0c064f4 = [];
    }
    
    if ( !isdefined( self.var_78e9c8539fefbf9d ) )
    {
        self.var_78e9c8539fefbf9d = [];
    }
    
    if ( !isdefined( self.var_9c4902579134d834 ) )
    {
        self.var_9c4902579134d834 = [];
    }
    
    function_5535a837de88a60b( "sat_zm_hornet_ar_recapture_start" );
    thread function_b28a9ebd2272e937();
    thread function_57d4ca0fd032cffd();
    
    while ( true )
    {
        recapture_progress = self.recap_progress ?? 0;
        recapture_progress = recapture_progress >= 0 ? recapture_progress : 0;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            b_in_sector = function_8d86f00c81ff837b( player, self.var_e917a56fdbc933d8 );
            var_72e81ebcbf479562 = arraycontains( self.var_87dd3688c0c064f4, player );
            b_in_radius = arraycontains( self.var_78e9c8539fefbf9d, player );
            var_8ffa4fd9c14c02c6 = arraycontains( self.var_9c4902579134d834, player );
            
            if ( b_in_sector && !var_72e81ebcbf479562 )
            {
                function_5c9b2c6a0019344( player, self );
            }
            else if ( !b_in_sector && var_72e81ebcbf479562 )
            {
                function_153531ff031a78ef( player, self );
            }
            
            if ( b_in_radius && !var_8ffa4fd9c14c02c6 )
            {
                function_de731d07f9394ff9( player, self );
            }
            else if ( !b_in_radius && var_8ffa4fd9c14c02c6 )
            {
                function_db13e8c293000cc6( player, self );
            }
            
            if ( var_72e81ebcbf479562 )
            {
                player zm_quest::function_9f49b2a045ece8ae( recapture_progress, 0, #"hash_5d06d71de9a9208e", #"recap" );
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0xda1a8d17, Offset: 0x995b
// Size: 0x154
function cleanup_recapture_guidance( msg )
{
    foreach ( player in self.var_87dd3688c0c064f4 )
    {
        if ( isdefined( player ) )
        {
            player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hash_5d06d71de9a9208e", #"recap" );
        }
    }
    
    foreach ( player in self.var_9c4902579134d834 )
    {
        if ( isdefined( player ) )
        {
            function_db13e8c293000cc6( player, self );
        }
    }
    
    if ( msg == "recaptured" || level utility::flag( "power_on" ) )
    {
        function_de7a30ef28a3d91( self );
    }
    
    self.var_87dd3688c0c064f4 = [];
    self.var_9c4902579134d834 = [];
    level thread function_949c1afbdcc4ddd7();
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x42023ba4, Offset: 0x9ab7
// Size: 0x183
function banner_spawn_zombies()
{
    level endon( #"game_ended" );
    self endon( #"recaptured", #"recapture_failed" );
    self.var_ab4c49769a763880 = get_zombie_number();
    self.var_3fc8254e9a5f5d33 = 0;
    self.var_3e5c4d2a6667480d = 0;
    round_num = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    var_62a8e68f22a91381 = function_6c305242232ab73d();
    delay_round_num = round_num;
    
    if ( !utility::flag( "power_on" ) )
    {
        delay_round_num = 2;
    }
    
    n_delay = zm_round_spawning::function_5f35aa2e209190da( delay_round_num ) * 1.25;
    
    if ( round_num >= 50 && level utility::flag( "power_on" ) )
    {
        level thread function_fa260687a5d62ade( self.var_e917a56fdbc933d8, self );
    }
    
    while ( true )
    {
        a_nearby_zombies = getaiarrayinradius( self.s_center.origin, 750 );
        var_f18cbb864377e362 = a_nearby_zombies.size < var_62a8e68f22a91381;
        
        if ( var_f18cbb864377e362 && self.var_3fc8254e9a5f5d33 < self.var_ab4c49769a763880 )
        {
            s_spawner = utility::array_random( self.var_a65a556e144e8c0b );
            banner_zombie_spawn( s_spawner );
            self.var_3e5c4d2a6667480d++;
            
            if ( self.var_3e5c4d2a6667480d == self.var_ab4c49769a763880 )
            {
                wait function_df5cba2392ced66e();
                self.var_3e5c4d2a6667480d = 0;
            }
        }
        
        wait n_delay;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x294a32d, Offset: 0x9c42
// Size: 0x6c
function private function_6c305242232ab73d()
{
    switch ( level.players.size )
    {
        case 1:
            var_13499fc5a3a2f18c = 16;
            break;
        case 2:
            var_13499fc5a3a2f18c = 14;
            break;
        case 3:
            var_13499fc5a3a2f18c = 12;
            break;
        default:
            var_13499fc5a3a2f18c = 10;
            break;
    }
    
    return var_13499fc5a3a2f18c;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0x86e6be2d, Offset: 0x9cb7
// Size: 0x7e
function banner_zombie_spawn( s_spawner )
{
    var_ea616919227739f = agent_manager::spawn_agent( "zombie_base", s_spawner.origin, s_spawner.angles, "team_two_hundred" );
    
    if ( isdefined( var_ea616919227739f ) )
    {
        self.var_3fc8254e9a5f5d33++;
        var_ea616919227739f zm_utility::setup_quest_ai();
        var_ea616919227739f thread function_62f85a711df76fca( self );
        var_ea616919227739f thread banner_zombie_death_watcher( self );
        var_ea616919227739f thread zone_spawner::function_f9d3af30e993a949();
        var_ea616919227739f thread agent_spawner::function_ce10e453e7f7bb8e( s_spawner );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0xe6e44914, Offset: 0x9d3d
// Size: 0x51
function function_62f85a711df76fca( s_banner )
{
    s_banner endon( #"recapture_failed" );
    self endon( #"death" );
    self.is_banner_zombie = 1;
    s_banner waittill( #"recaptured" );
    thread zm_utility::function_5bbd540197e3fd( 100, 1.5, 2 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0xf8b58b61, Offset: 0x9d96
// Size: 0x33
function banner_zombie_death_watcher( s_banner )
{
    self waittill( #"death" );
    
    if ( s_banner.var_3fc8254e9a5f5d33 )
    {
        s_banner.var_3fc8254e9a5f5d33--;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 4
// Checksum 0x116cb97a, Offset: 0x9dd1
// Size: 0x401
function function_5462496b3794dac0( n_progress_goal = 60, n_tick = 0.25, var_4a60e78f1f0944c7 = 1, var_cfcb8a657dded27c = &function_ad95c089819e6f40 )
{
    level endon( #"game_ended" );
    self endon( #"recapture_failed" );
    self.n_captured_progress = n_progress_goal * 0.07;
    self.var_507ded7d3ee2ec04 = gettime();
    self.var_b528f1a3120ba1bd = 1;
    counter = 0;
    decay_increment = get_decay_rate();
    delay_decay = get_decay_delay();
    level utility::flag_set( "recapture_active" );
    
    while ( true )
    {
        var_78e9c8539fefbf9d = getplayersinradius( self.s_center.origin, 220 );
        self.var_78e9c8539fefbf9d = var_78e9c8539fefbf9d;
        var_3a02cd8a5fcbc522 = 0;
        
        foreach ( player in var_78e9c8539fefbf9d )
        {
            if ( isdefined( player ) && zm_player::function_f37cfdf04b932a03( player ) )
            {
                var_3a02cd8a5fcbc522 = 1;
            }
        }
        
        if ( var_3a02cd8a5fcbc522 )
        {
            thread function_bb978f9502c8e6f7( "player" );
            self.n_captured_progress += function_67d72d28a90ffd24( var_78e9c8539fefbf9d );
            self.var_507ded7d3ee2ec04 = gettime();
            self.var_b528f1a3120ba1bd = 1;
            
            if ( self.n_captured_progress >= n_progress_goal )
            {
                self.is_captured = 1;
                thread function_bb978f9502c8e6f7( "off" );
                
                if ( var_4a60e78f1f0944c7 )
                {
                    thread banner_recapture_blast();
                }
                
                if ( isdefined( var_cfcb8a657dded27c ) )
                {
                    [[ var_cfcb8a657dded27c ]]( self.var_e917a56fdbc933d8 );
                }
                
                function_5535a837de88a60b( "sat_zm_hornet_ar_recapture_end_success" );
                playsoundatpos( self.origin, "evt_capture_win_stinger" );
                self.var_5cc061d568e1fe48 = undefined;
                self notify( #"recaptured" );
                
                if ( self.interact )
                {
                    self.interact delete();
                }
                
                self.sc_banner utility::function_32b24db3127bff40( "reveal", "full_player" );
                
                if ( isdefined( self.var_678106344b2cefd8.interact ) )
                {
                    self.var_678106344b2cefd8.interact delete();
                    self.var_678106344b2cefd8.sc_banner utility::function_32b24db3127bff40( "reveal", "full_player" );
                }
                
                level utility::flag_clear( "recapture_active" );
                return;
            }
        }
        else if ( self.n_captured_progress > 0 )
        {
            thread function_bb978f9502c8e6f7( "zombie" );
            
            if ( utility::time_has_passed( self.var_507ded7d3ee2ec04, delay_decay ) )
            {
                self.n_captured_progress -= decay_increment;
                self.var_b528f1a3120ba1bd = undefined;
            }
        }
        else if ( self.n_captured_progress <= 0 )
        {
            if ( counter > 5 )
            {
                playsoundatpos( self.origin, "evt_caputre_lost_stinger" );
                function_5535a837de88a60b( "sat_zm_hornet_ar_recapture_end_fail" );
                thread function_bb978f9502c8e6f7( "off" );
                self.var_18b773b3291055b8 = 1;
                self.is_capturing = 0;
                
                if ( isdefined( self.var_678106344b2cefd8 ) )
                {
                    self.var_678106344b2cefd8.var_18b773b3291055b8 = 1;
                    self.var_678106344b2cefd8.is_capturing = 0;
                }
                
                thread banner_cooldown();
                level utility::flag_clear( "recapture_active" );
                self notify( #"recapture_failed" );
            }
        }
        
        self.recap_progress = int( self.n_captured_progress / n_progress_goal * 100 );
        wait n_tick;
        counter++;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xdda71c4e, Offset: 0xa1da
// Size: 0x64
function private get_decay_rate()
{
    n_round = level.var_b3d685cfbac74242 ?? zm_utility::get_round_number();
    
    if ( n_round < 30 )
    {
        return 0.1625;
    }
    
    if ( n_round < 50 )
    {
        return 0.15;
    }
    else if ( n_round < 100 )
    {
        return 0.125;
    }
    else if ( n_round < 1000 )
    {
        return 0.1;
    }
    
    return 0.1625;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x817c1062, Offset: 0xa247
// Size: 0x68
function private get_decay_delay()
{
    switch ( level.players.size )
    {
        case 1:
            var_13499fc5a3a2f18c = 0;
            break;
        case 2:
            var_13499fc5a3a2f18c = 0;
            break;
        case 3:
            var_13499fc5a3a2f18c = 0;
            break;
        default:
            var_13499fc5a3a2f18c = 0;
            break;
    }
    
    return var_13499fc5a3a2f18c;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x13fb4ec5, Offset: 0xa2b8
// Size: 0x134
function private function_67d72d28a90ffd24( var_78e9c8539fefbf9d )
{
    n_total_players = level.players.size;
    var_358fe5f70f742e0 = 0;
    var_f72c2fdf43e18498 = 0;
    
    foreach ( player in var_78e9c8539fefbf9d )
    {
        if ( zm_player::function_f37cfdf04b932a03( player ) )
        {
            var_f72c2fdf43e18498++;
        }
        
        if ( player.var_c25d0d7274ec3c7d )
        {
            var_358fe5f70f742e0 = 1;
        }
    }
    
    var_21afb743d7793fa9 = var_358fe5f70f742e0 ? level.ee_roll.var_8349343dfac96e71 : 1;
    
    if ( var_f72c2fdf43e18498 < 1 )
    {
        return 0;
    }
    
    if ( n_total_players == 1 )
    {
        return ( 0.5 * var_21afb743d7793fa9 );
    }
    
    fraction = ( var_f72c2fdf43e18498 - 1 ) / ( n_total_players - 1 );
    fraction = min( fraction, 1 );
    return ( 0.25 + fraction * 0.25 ) * var_21afb743d7793fa9;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x78400271, Offset: 0xa3f5
// Size: 0x3b
function banner_cooldown()
{
    level waittill( #"on_round_start" );
    self.var_18b773b3291055b8 = 0;
    
    if ( isdefined( self.var_678106344b2cefd8 ) )
    {
        self.var_678106344b2cefd8.var_18b773b3291055b8 = 0;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x6b7eb6f1, Offset: 0xa438
// Size: 0x232
function setup_banner_spawners()
{
    level utility::flag_wait( "subclass_to_aitype_map_initialized" );
    waitframe();
    self.var_a65a556e144e8c0b = [];
    var_a65a556e144e8c0b = [];
    zone = zone_manager::function_90e5c3e2272b0130( self.origin );
    adj_zones = zone zone_manager::get_adjacent_zones( 0 );
    banner_zones = arraycombine( adj_zones, [ zone ] );
    var_79c84a925c286118 = [ "zombie_base", "zombie_base_armored_heavy", "zombie_base_armored_light" ];
    
    foreach ( zone in banner_zones )
    {
        foreach ( zombie_type_normal in var_79c84a925c286118 )
        {
            var_a65a556e144e8c0b[ var_a65a556e144e8c0b.size ] = zone_spawner::function_20c574a6ba7cc5c6( zone.script_zone_name, zombie_type_normal );
        }
    }
    
    foreach ( a_spawns in var_a65a556e144e8c0b )
    {
        self.var_a65a556e144e8c0b = arrayrandomize( arraycombineunique( self.var_a65a556e144e8c0b, a_spawns ) );
    }
    
    if ( self.var_a65a556e144e8c0b.size < 3 )
    {
        var_889db7339d4585af = 5;
        self.var_a65a556e144e8c0b = utility::get_array_of_closest( self.origin, level.zone_spawn_locations, undefined, var_889db7339d4585af );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2
// Checksum 0xa1d4be98, Offset: 0xa672
// Size: 0xd0
function banner_hint( interact, player )
{
    if ( player.interactions_disabled || interact.s_banner.is_capturing )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    else if ( interact.s_banner.var_18b773b3291055b8 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_703a5a901ffd5af3", #type:"HINT_NOBUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_7f25bc9256f620e8", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x9c99edf7, Offset: 0xa74b
// Size: 0x56
function function_ba755c3ed9de2375()
{
    self.s_center = utility::getstruct( self.target );
    self.sc_boundary = spawnscriptable( %"hash_2b38ff5d060bc49c", self.s_center.origin, self.s_center.angles );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2
// Checksum 0xeba13507, Offset: 0xa7a9
// Size: 0x8b
function function_bb978f9502c8e6f7( var_b0e144194be51c26 = "off", b_reset_capturing = 1 )
{
    if ( var_b0e144194be51c26 == "player" )
    {
        str_state = "allies";
    }
    else if ( var_b0e144194be51c26 == "zombie" )
    {
        str_state = "axis";
    }
    else
    {
        str_state = "off";
        
        if ( b_reset_capturing )
        {
            self.is_capturing = 0;
        }
    }
    
    self.sc_boundary utility::function_32b24db3127bff40( "visual", str_state );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x69d9bf93, Offset: 0xa83c
// Size: 0x10b
function private function_78708b6b79b877e5( n_radius )
{
    var_e468c9045fe5babe = 22.5;
    
    if ( !isdefined( n_radius ) )
    {
        n_radius = self.s_center.radius;
    }
    
    self.var_2d7a19c57445582c = [];
    
    for ( i = 0; i < 16 ; i++ )
    {
        var_408e0c7d8bfc99ad = vectornormalize( anglestoforward( self.s_center.angles ) ) * n_radius + self.s_center.origin;
        v_ang = self.s_center.angles + ( 0, -180, 0 );
        self.var_2d7a19c57445582c[ i ] = spawnscriptable( %"sat_gamemode_chevron", var_408e0c7d8bfc99ad, v_ang );
        self.s_center.angles += ( 0, var_e468c9045fe5babe, 0 );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0x9256c0f9, Offset: 0xa94f
// Size: 0xaf
function private function_63d20dfe8d3f13ef( var_b0e144194be51c26 = "off", b_reset_capturing = 1 )
{
    if ( var_b0e144194be51c26 == "player" )
    {
        str_state = "allies";
    }
    else if ( var_b0e144194be51c26 == "zombie" )
    {
        str_state = "axis";
    }
    else
    {
        str_state = "off";
        
        if ( b_reset_capturing )
        {
            self.is_capturing = 0;
        }
    }
    
    for ( i = 0; i < self.var_2d7a19c57445582c.size ; i++ )
    {
        self.var_2d7a19c57445582c[ i ] utility::function_32b24db3127bff40( "chevron_0", str_state );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0xaa0ddfb7, Offset: 0xaa06
// Size: 0xf9
function banner_recapture_blast()
{
    self.sc_boundary utility::function_32b24db3127bff40( "visual", "captured" );
    a_zombies = getaiarrayinradius( self.origin, 1200, zm_utility::get_zombie_team() );
    
    foreach ( zombie in a_zombies )
    {
        if ( isalive( zombie ) && zombie.aicategory === "normal" && !zombie.is_banner_zombie && !zombie.is_living_world_ai )
        {
            zombie thread zm_utility::function_5bbd540197e3fd( 100, 1.5, 2 );
            waitframe();
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0xc7b41629, Offset: 0xab07
// Size: 0x6c
function get_zombie_number()
{
    switch ( level.players.size )
    {
        case 1:
            var_13499fc5a3a2f18c = 4;
            break;
        case 2:
            var_13499fc5a3a2f18c = 6;
            break;
        case 3:
            var_13499fc5a3a2f18c = 8;
            break;
        default:
            var_13499fc5a3a2f18c = 11;
            break;
    }
    
    return var_13499fc5a3a2f18c;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0x26744e36, Offset: 0xab7c
// Size: 0xa3
function private function_5535a837de88a60b( splash_ref, wait_len )
{
    level endon( #"game_ended" );
    
    if ( wait_len )
    {
        wait wait_len;
    }
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( splash_ref );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xc8d277fa, Offset: 0xac27
// Size: 0x1bb
function private function_fa260687a5d62ade( var_e917a56fdbc933d8, s_banner, n_round )
{
    level endon( #"game_ended" );
    
    for ( var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ); !var_d7b3a1f33b95bf77 ; var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] ) )
    {
        waitframe();
    }
    
    spawner = level.ar_root.var_a65da308c81e9a4[ var_e917a56fdbc933d8 ];
    zombie = agent_manager::spawn_agent( "zombie_orion", spawner.origin, spawner.angles, "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie.var_e917a56fdbc933d8 = var_e917a56fdbc933d8;
        zombie.s_tether = s_banner.s_center;
        round_number = n_round ?? zm_round_logic::get_rb_round_number();
        zombie zombie_utils::set_zombie_round_difficulty( round_number );
        zombie val::set( "ar_wave", "ignore_cleanup", 1 );
        zombie.tether_attractor = zombie zombie_attractor_manager::function_7eb1aaa8bc7cc15( zombie.s_tether, 10 );
        zombie callback::add( "on_zombie_ai_killed", &function_bcc58c62a9a011ee );
        
        if ( !isdefined( level.ar_root.a_commanders ) )
        {
            level.ar_root.a_commanders = [];
        }
        
        level.ar_root.a_commanders[ level.ar_root.a_commanders.size ] = zombie;
        zombie callback::add( "on_zombie_ai_damaged", &function_3d89dad2acfa219e );
        zombie thread function_c966560e32db1f4();
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xc4adc073, Offset: 0xadea
// Size: 0xc
function private function_bcc58c62a9a011ee( sparams )
{
    
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xa6045064, Offset: 0xadfe
// Size: 0x72
function private function_3d89dad2acfa219e( sparams )
{
    if ( isplayer( sparams.eattacker ) )
    {
        if ( function_8d86f00c81ff837b( sparams.eattacker, self.var_e917a56fdbc933d8 ) )
        {
            callback::remove( "on_zombie_ai_damaged", &function_3d89dad2acfa219e );
            self notify( #"tether_reset" );
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.tether_attractor );
            thread function_ce7c34898882c273();
        }
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x6858549a, Offset: 0xae78
// Size: 0x1a
function private function_c966560e32db1f4()
{
    self endon( #"tether_reset" );
    self endon( #"death" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x453ef2fb, Offset: 0xae9a
// Size: 0x13a
function private function_ce7c34898882c273()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        
        if ( self.enemy && function_8d86f00c81ff837b( self.enemy, self.var_e917a56fdbc933d8 ) )
        {
            continue;
        }
        
        valid_player_targets = [];
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && function_8d86f00c81ff837b( player, self.var_e917a56fdbc933d8 ) && distancesquared( self.origin, player.origin ) < 250000 )
            {
                valid_player_targets[ valid_player_targets.size ] = player;
            }
        }
        
        if ( valid_player_targets.size > 0 )
        {
            new_target = utility::array_random( valid_player_targets );
            zombie_utils::set_ai_target_priority( new_target, "tether_target", 0 );
            continue;
        }
        
        function_f5f86e3d21a19d89();
        return;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xb19a8c04, Offset: 0xafdc
// Size: 0x83
function private function_f5f86e3d21a19d89()
{
    if ( !isdefined( self.s_tether ) )
    {
        return;
    }
    
    self forceteleport( self.s_tether.origin, self.s_tether.angles );
    self.tether_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( self.s_tether, 10 );
    
    if ( !callback::exists( "on_zombie_ai_damaged", &function_3d89dad2acfa219e ) )
    {
        callback::add( "on_zombie_ai_damaged", &function_3d89dad2acfa219e );
    }
    
    thread function_c966560e32db1f4();
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xc15b7e44, Offset: 0xb067
// Size: 0xba, Type: bool
function private function_8d86f00c81ff837b( player, var_e917a56fdbc933d8 )
{
    var_de84a9d0da66a3cc = function_7ef58899cffe2533( var_e917a56fdbc933d8 );
    var_77898ab40e53d0ae = player zone_manager::get_current_zone();
    
    foreach ( zone_name in var_de84a9d0da66a3cc )
    {
        if ( issubstr( var_77898ab40e53d0ae.zone_name, zone_name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x46adea79, Offset: 0xb12a
// Size: 0xe1
function private function_884e8eda5f24a450( sparams )
{
    zm_save::function_1f44a48caae2acbf();
    
    if ( get_assault_rounds_blocked() )
    {
        return;
    }
    
    if ( !level utility::flag( "assault_round_min_ignore" ) && level.ar_root.num_assault_rounds == 0 && sparams.roundnumber < 10 )
    {
        zm_round_spawning::function_9fd9e12523021d1d( sparams.roundnumber, 10 );
        level function_52f7e142e34bc386( 10 );
        return;
    }
    
    var_5995f8b3a3b0df45 = level zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_71914be6e8e965ba" ) ?? 0;
    current_round_number = zm_utility::get_round_number();
    
    if ( var_5995f8b3a3b0df45 <= current_round_number )
    {
        level function_52f7e142e34bc386( sparams.roundnumber );
        return;
    }
    
    zm_round_spawning::function_9fd9e12523021d1d( sparams.roundnumber, var_5995f8b3a3b0df45 );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0x7e9c79cb, Offset: 0xb213
// Size: 0xf
function function_8c0bf06dd299f021()
{
    level utility::flag_set( "assault_round_min_ignore" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0
// Checksum 0xa51cc980, Offset: 0xb22a
// Size: 0xf
function function_4579d1156700d08e()
{
    level utility::flag_clear( "assault_round_min_ignore" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1
// Checksum 0xb67d050b, Offset: 0xb241
// Size: 0x28
function function_52f7e142e34bc386( roundnumber )
{
    level zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", #"hash_71914be6e8e965ba", roundnumber );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xd98fc91e, Offset: 0xb271
// Size: 0x9a
function private function_986682c9e6b89ac0( var_e917a56fdbc933d8, flag_value )
{
    sector_idx = function_f02c63b99c9614c9( level.ar_root.sector_order, var_e917a56fdbc933d8 );
    bit_idx = level.ar_root.var_c6a0cb99ddd965c8[ sector_idx ];
    level function_dbb893b6112d961b( #"hash_9e20059a98c546b", bit_idx, flag_value );
    bit_idx = level.ar_root.var_97b1121b2fca28b[ sector_idx ];
    level function_dbb893b6112d961b( #"hash_9e20059a98c546b", bit_idx, flag_value );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 3, eflags: 0x4
// Checksum 0xc4809644, Offset: 0xb313
// Size: 0x75
function private function_dbb893b6112d961b( save_key, save_index, flag_value )
{
    value = level zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", save_key ) ?? 0;
    
    if ( flag_value == 1 )
    {
        value = utility::set_bit_flag( value, save_index );
    }
    else
    {
        value = utility::function_911d2d3c6d773726( value, save_index );
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", save_key, value );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0xd03df19c, Offset: 0xb390
// Size: 0x50
function private function_605058f6bb3e620a( save_key, save_index )
{
    value = level zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", save_key ) ?? 0;
    var_ec695d802baddc0f = utility::get_bit_flag( value, save_index ) ?? 0;
    return var_ec695d802baddc0f;
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x43a70d72, Offset: 0xb3e9
// Size: 0x17
function private function_2f1e17e9528a7582()
{
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"change_assault_frequency", &cheat_change_assault_frequency );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xae3557, Offset: 0xb408
// Size: 0x1bc
function private cheat_change_assault_frequency( params )
{
    if ( !isdefined( params ) || params.size < 1 )
    {
        iprintlnbold( "Usage: change_assault_frequency <rounds>" );
        return;
    }
    
    n_frequency = int( params[ 0 ] );
    
    if ( n_frequency < 1 )
    {
        iprintlnbold( "Assault frequency must be >= 1" );
        return;
    }
    
    level.ar_root.var_a3c537da6ca05e00 = n_frequency;
    var_49f7091014d2c59 = zm_utility::get_round_number();
    var_10624f9425a71b79 = zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_71914be6e8e965ba" ) ?? 0;
    n_new_target = var_49f7091014d2c59 + n_frequency;
    
    if ( var_10624f9425a71b79 > var_49f7091014d2c59 )
    {
        level function_52f7e142e34bc386( n_new_target );
        zm_round_spawning::function_9fd9e12523021d1d( var_10624f9425a71b79, n_new_target );
        specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ n_new_target ];
        
        if ( isdefined( specialroundstruct ) )
        {
            specialroundstruct.var_e28b1bf3be5e30f2 = n_frequency;
            specialroundstruct.var_e26825f3be37ff38 = n_frequency;
            specialroundstruct.var_16f342b397743f5 = n_frequency;
            specialroundstruct.var_1921e2b399d5b4b = n_frequency;
        }
        
        iprintlnbold( "Assault rounds rescheduled: next AR is round " + n_new_target + " (every " + n_frequency + " rounds)" );
        return;
    }
    
    zm_round_spawning::function_9fd9e12523021d1d( var_10624f9425a71b79, n_new_target );
    specialroundstruct = level.var_a009ab14ee0d3223.specialroundspawns[ n_new_target ];
    
    if ( isdefined( specialroundstruct ) )
    {
        specialroundstruct.var_e28b1bf3be5e30f2 = n_frequency;
        specialroundstruct.var_e26825f3be37ff38 = n_frequency;
        specialroundstruct.var_16f342b397743f5 = n_frequency;
        specialroundstruct.var_1921e2b399d5b4b = n_frequency;
    }
    
    iprintlnbold( "Assault rounds rescheduled: next AR is round " + n_new_target + " (every " + n_frequency + " rounds)" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x5692daa6, Offset: 0xb5cc
// Size: 0x193
function private function_d78aeabe4ff55e73()
{
    level endon( #"ar_ended" );
    level endon( #"game_ended" );
    
    if ( level.ar_root.var_cf857e927cd91298 )
    {
        return;
    }
    
    level.ar_root.var_cf857e927cd91298 = 1;
    wait 0.5;
    n_alt = randomintrange( 1, 5 );
    
    switch ( n_alt )
    {
        case 1:
            level overlord::playevent( #"hash_a392020ab930feaa", level.players, undefined, 1, 1 );
            break;
        case 2:
            level overlord::playevent( #"hash_a392010ab930fcf7", level.players, undefined, 1, 1 );
            break;
        case 3:
            level overlord::playconversation( "hornet_assault_round_countdown_first_time_alt03", level.players );
            break;
        case 4:
            level overlord::playconversation( "hornet_assault_round_countdown_first_time_alt04", level.players );
            break;
    }
    
    wait 0.5;
    
    foreach ( player in level.players )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_assault_round_countdown_response" );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x550d90ee, Offset: 0xb767
// Size: 0x7f
function private function_1c43db5d94c007e8( var_e917a56fdbc933d8 )
{
    level endon( #"ar_ended" );
    level endon( #"game_ended" );
    
    if ( level.ar_root.var_93b1f0e262a9cb06 )
    {
        return;
    }
    
    level.ar_root.var_93b1f0e262a9cb06 = 1;
    
    if ( randomfloat( 1 ) > 0.25 )
    {
        return;
    }
    
    wait 0.5;
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_necrotic_projectile_damage_first_time", #"bc_flavor_player_negative" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0x7eac5c0c, Offset: 0xb7ee
// Size: 0x7f
function private function_c8111f442ff75bb8( var_e917a56fdbc933d8 )
{
    level endon( #"ar_ended" );
    level endon( #"game_ended" );
    
    if ( level.ar_root.var_797ac97a3f506d2a )
    {
        return;
    }
    
    level.ar_root.var_797ac97a3f506d2a = 1;
    
    if ( randomfloat( 1 ) > 0.25 )
    {
        return;
    }
    
    wait 0.5;
    thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_necrotic_beam_damage_first_time", #"bc_flavor_player_negative" );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xd9815e5a, Offset: 0xb875
// Size: 0xd2
function private function_2dee4539c035f1a7( var_e917a56fdbc933d8 )
{
    level endon( #"ar_ended" );
    level endon( #"game_ended" );
    
    if ( !level.ar_root.var_840a4bab8ab9c125 )
    {
        level.ar_root.var_840a4bab8ab9c125 = 1;
        level.ar_root.var_d80691d07a40bb81 = 1;
    }
    else if ( level.ar_root.var_d80691d07a40bb81 || randomfloat( 1 ) > 0.5 )
    {
        return;
    }
    
    wait 0.5;
    level.ar_root.var_d80691d07a40bb81 = 1;
    n_sector = get_sector_number( var_e917a56fdbc933d8 );
    function_c9f4f166a2bf22c9( "komainu_statue_damage_25", n_sector );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xf30c741c, Offset: 0xb94f
// Size: 0xd2
function private function_4b2c95a06e334219( var_e917a56fdbc933d8 )
{
    level endon( #"ar_ended" );
    level endon( #"game_ended" );
    
    if ( !level.ar_root.var_ae68868a783fe28f )
    {
        level.ar_root.var_ae68868a783fe28f = 1;
        level.ar_root.var_4c86f85295111faf = 1;
    }
    else if ( level.ar_root.var_4c86f85295111faf || randomfloat( 1 ) > 0.5 )
    {
        return;
    }
    
    wait 0.5;
    level.ar_root.var_4c86f85295111faf = 1;
    n_sector = get_sector_number( var_e917a56fdbc933d8 );
    function_c9f4f166a2bf22c9( "shogun_banner_damage_25", n_sector );
}

// Namespace zm_sat_hornet_assault_rounds
// Params 2, eflags: 0x4
// Checksum 0x1d4c1a5c, Offset: 0xba29
// Size: 0xf8
function private function_c9f4f166a2bf22c9( str_type, n_sector )
{
    n_alt = randomintrange( 1, 5 );
    str_base = "hornet_" + str_type + "_sector_" + n_sector;
    
    switch ( n_alt )
    {
        case 1:
            level overlord::playevent( str_base + "_alt01", level.players, undefined, 1, 1 );
            break;
        case 2:
            level overlord::playevent( str_base + "_alt02", level.players, undefined, 1, 1 );
            break;
        case 3:
            level overlord::playconversation( str_base + "_alt03", level.players );
            break;
        case 4:
            level overlord::playconversation( str_base + "_alt04", level.players );
            break;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 1, eflags: 0x4
// Checksum 0xa41ba214, Offset: 0xbb29
// Size: 0x61
function private get_sector_number( var_e917a56fdbc933d8 )
{
    switch ( var_e917a56fdbc933d8 )
    {
        case #"hash_4a3f2b24bb25e893":
            return 1;
        case #"hash_4a3f2c24bb25ea26":
            return 2;
        case #"hash_4a3f2d24bb25ebb9":
            return 3;
        case #"hash_4a3f2e24bb25ed4c":
            return 4;
        default:
            return 1;
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0xc404048, Offset: 0xbb92
// Size: 0xb6
function private function_b0b05d69a4e0fdcb()
{
    if ( level.ar_root.var_9c38601a2e23323c )
    {
        return;
    }
    
    level.ar_root.var_9c38601a2e23323c = 1;
    
    foreach ( player in level.players )
    {
        player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_assault_round_success_first_time", #"bc_flavor_player_positive" );
    }
}

// Namespace zm_sat_hornet_assault_rounds
// Params 0, eflags: 0x4
// Checksum 0x2383f12a, Offset: 0xbc50
// Size: 0xa1
function private function_4fe47c350fbe670e()
{
    level endon( #"game_ended" );
    
    if ( level.ar_root.var_6f783d42b80c3b4b )
    {
        return;
    }
    
    level.ar_root.var_6f783d42b80c3b4b = 1;
    wait 0.5;
    a_refs = [ #"hash_7f96c56bf18048d", #"hash_7f96956bf17ff74", #"hash_7f96a56bf180127", #"hash_7f96756bf17fc0e" ];
    level overlord::playevent( a_refs[ randomint( a_refs.size ) ], level.players, undefined, 1, 1 );
}

/#

    // Namespace zm_sat_hornet_assault_rounds
    // Params 0, eflags: 0x4
    // Checksum 0x602c75d4, Offset: 0xbcf9
    // Size: 0x360, Type: dev
    function private function_98a45da36d54506c()
    {
        devgui::function_9082edeb5db93280( "<dev string:xe3>" );
        devgui::add_devgui_func( "<dev string:x105>", "<dev string:x116>", &debug_show_portals, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x120>", "<dev string:x132>", &function_2d40239c44ea10af, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x147>", "<dev string:x159>", &function_2d40239c44ea10af, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x16e>", "<dev string:x180>", &function_2d40239c44ea10af, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x195>", "<dev string:x1a7>", &function_2d40239c44ea10af, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1bc>", "<dev string:x1cd>", &function_a6540f63dd4ce6b, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e1>", "<dev string:x1f2>", &function_a6540f63dd4ce6b, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x206>", "<dev string:x217>", &function_a6540f63dd4ce6b, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x22b>", "<dev string:x23c>", &function_a6540f63dd4ce6b, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x250>", "<dev string:x26d>", &debug_spawn_diana, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x280>", "<dev string:x29c>", &debug_spawn_diana, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2af>", "<dev string:x2cc>", &debug_spawn_diana, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2df>", "<dev string:x2fb>", &debug_spawn_diana, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x30e>", "<dev string:x32b>", &debug_spawn_diana, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x33e>", "<dev string:x35a>", &debug_spawn_diana, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x36d>", "<dev string:x38a>", &debug_spawn_diana, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x39d>", "<dev string:x3b9>", &debug_spawn_diana, 1 );
        devgui::add_devgui_func( "<dev string:x3cc>", "<dev string:x3dc>", &function_9c9070d5b099b9fa, 1 );
        devgui::add_devgui_func( "<dev string:x3e9>", "<dev string:x406>", &debug_block_ar, 1 );
        devgui::add_devgui_func( "<dev string:x40d>", "<dev string:x430>", &debug_crafting_table_discount, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x43c>", "<dev string:x45e>", &function_af7ac0bdde973473, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x471>", "<dev string:x48d>", &function_af7ac0bdde973473, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4a0>", "<dev string:x4b7>", &function_af7ac0bdde973473, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4ca>", "<dev string:x4e2>", &function_240f257979763e7a, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4f2>", "<dev string:x50b>", &function_240f257979763e7a, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x51c>", "<dev string:x536>", &function_240f257979763e7a, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x547>", "<dev string:x560>", &function_240f257979763e7a, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x573>", "<dev string:x58c>", &function_a2c2e01ee1073131, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x59d>", "<dev string:x5ba>", &function_a2c2e01ee1073131, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5cb>", "<dev string:x5e2>", &function_48614aa8266e860, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5f1>", "<dev string:x609>", &function_48614aa8266e860, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x619>", "<dev string:x632>", &function_48614aa8266e860, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x642>", "<dev string:x65a>", &function_48614aa8266e860, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x66c>", "<dev string:x693>", &function_b00f05092183dc22, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6a2>", "<dev string:x6c9>", &function_b00f05092183dc22, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 0, eflags: 0x4
    // Checksum 0xcb040f5d, Offset: 0xc061
    // Size: 0xf1, Type: dev
    function private debug_show_portals()
    {
        for ( i = 1; i < 5 ; i++ )
        {
            var_9c2dab0b43727939 = utility::getstructarray( "<dev string:x6d8>" + i, "<dev string:x6df>" );
            
            foreach ( struct in var_9c2dab0b43727939 )
            {
                portal = spawnscriptable( %"hash_1b4f96c8f667046c", struct.origin + ( 0, 0, 48 ), struct.angles );
                portal setscriptablepartstate( "<dev string:x6ea>", "<dev string:x6ef>" );
            }
        }
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0x26ae5d3f, Offset: 0xc15a
    // Size: 0xf4, Type: dev
    function private function_2d40239c44ea10af( params )
    {
        level notify( #"hash_e0ee74e86fbf0c02" );
        level endon( #"hash_e0ee74e86fbf0c02" );
        
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        var_e917a56fdbc933d8 = params[ 0 ];
        zm_round_spawning::pause_round_spawning( 1, "<dev string:x6f9>" );
        zm_utility::util_kill_all_zombies();
        
        while ( true )
        {
            function_b5171d402908bc7e( level.ar_root.var_28e4ff3f60d19060[ var_e917a56fdbc933d8 ], level.ar_root.var_605f820245431396[ var_e917a56fdbc933d8 ] );
            wait 40;
            level notify( #"ar_wave_ended" );
            zm_utility::util_kill_all_zombies();
            wait 5;
            function_b5171d402908bc7e( level.ar_root.var_66cdb027aee5520e[ var_e917a56fdbc933d8 ], level.ar_root.var_b1095616d6d59608[ var_e917a56fdbc933d8 ] );
            wait 40;
            level notify( #"ar_wave_ended" );
            zm_utility::util_kill_all_zombies();
            wait 5;
        }
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0xfbaf77a1, Offset: 0xc256
    // Size: 0x30, Type: dev
    function private function_a6540f63dd4ce6b( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        var_e917a56fdbc933d8 = params[ 0 ];
        function_3cb64952a26fdfc( var_e917a56fdbc933d8 );
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0xe7a5a4f0, Offset: 0xc28e
    // Size: 0x122, Type: dev
    function private debug_spawn_diana( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        var_e917a56fdbc933d8 = params[ 0 ];
        s_spawn = utility::getstruct( "<dev string:x707>" + var_e917a56fdbc933d8, "<dev string:x710>" );
        
        switch ( var_e917a56fdbc933d8 )
        {
            case #"hash_115bfc04dde8de39":
                var_e917a56fdbc933d8 = "<dev string:x84>";
                break;
            case #"hash_115bf904dde8d980":
                var_e917a56fdbc933d8 = "<dev string:x84>";
                var_3ba5cca41a170ce1 = 2;
                break;
            case #"hash_fa18d504d173a794":
                var_e917a56fdbc933d8 = "<dev string:x8c>";
                break;
            case #"hash_fa18d804d173ac4d":
                var_e917a56fdbc933d8 = "<dev string:x8c>";
                var_3ba5cca41a170ce1 = 2;
                break;
            case #"hash_110ae04d4fc972f":
                var_e917a56fdbc933d8 = "<dev string:x94>";
                break;
            case #"hash_110af04d4fc98c2":
                var_e917a56fdbc933d8 = "<dev string:x94>";
                var_3ba5cca41a170ce1 = 2;
                break;
            case #"hash_2642bf04e8827232":
                var_e917a56fdbc933d8 = "<dev string:x9c>";
                break;
            case #"hash_2642be04e882709f":
                var_e917a56fdbc933d8 = "<dev string:x9c>";
                var_3ba5cca41a170ce1 = 2;
                break;
        }
        
        level thread function_83747b92feac2545( s_spawn, var_e917a56fdbc933d8, var_3ba5cca41a170ce1 );
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 0, eflags: 0x4
    // Checksum 0x348d16cd, Offset: 0xc3b8
    // Size: 0xc, Type: dev
    function private function_9c9070d5b099b9fa()
    {
        function_545262c6bc7bf7eb();
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 0, eflags: 0x4
    // Checksum 0x39740204, Offset: 0xc3cc
    // Size: 0x36, Type: dev
    function private debug_block_ar()
    {
        if ( get_assault_rounds_blocked() )
        {
            set_assault_rounds_blocked( 0 );
            iprintlnbold( "<dev string:x75a>" );
            return;
        }
        
        set_assault_rounds_blocked( 1 );
        iprintlnbold( "<dev string:x774>" );
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 0, eflags: 0x4
    // Checksum 0x8db0772f, Offset: 0xc40a
    // Size: 0x6d, Type: dev
    function private debug_crafting_table_discount()
    {
        if ( !level.ar_root.var_dddaae093da0363e )
        {
            level.ar_root.var_dddaae093da0363e = 1;
            function_40eb772f9085ef92( 1 );
            iprintlnbold( "<dev string:x78e>" );
            return;
        }
        
        level.ar_root.var_dddaae093da0363e = undefined;
        function_40eb772f9085ef92( 0 );
        iprintlnbold( "<dev string:x79f>" );
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0xed0c8bb3, Offset: 0xc47f
    // Size: 0x128, Type: dev
    function private function_af7ac0bdde973473( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        state = params[ 0 ];
        
        foreach ( var_e917a56fdbc933d8 in level.ar_root.sector_order )
        {
            foreach ( komainu in level.ar_root.a_first_target[ var_e917a56fdbc933d8 ] )
            {
                komainu setscriptablepartstate( "<dev string:x7b1>", state );
            }
        }
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0x18c60ebc, Offset: 0xc5af
    // Size: 0x128, Type: dev
    function private function_240f257979763e7a( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        state = params[ 0 ];
        
        foreach ( var_e917a56fdbc933d8 in level.ar_root.sector_order )
        {
            foreach ( komainu in level.ar_root.a_first_target[ var_e917a56fdbc933d8 ] )
            {
                komainu setscriptablepartstate( "<dev string:x7b7>", state );
            }
        }
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0xcd079ad7, Offset: 0xc6df
    // Size: 0x128, Type: dev
    function private function_a2c2e01ee1073131( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        state = params[ 0 ];
        
        foreach ( var_e917a56fdbc933d8 in level.ar_root.sector_order )
        {
            foreach ( komainu in level.ar_root.a_first_target[ var_e917a56fdbc933d8 ] )
            {
                komainu setscriptablepartstate( "<dev string:x7be>", state );
            }
        }
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0x899b19e3, Offset: 0xc80f
    // Size: 0xad, Type: dev
    function private function_48614aa8266e860( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        state = params[ 0 ];
        
        foreach ( banner in level.ar_root.a_banners )
        {
            banner setscriptablepartstate( "<dev string:x7b7>", state );
        }
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 1, eflags: 0x4
    // Checksum 0x3b34c6b6, Offset: 0xc8c4
    // Size: 0x12f, Type: dev
    function private function_b00f05092183dc22( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        state = params[ 0 ];
        
        if ( state == "<dev string:x7c6>" )
        {
            foreach ( banner in level.ar_root.a_banners )
            {
                banner thread function_dd3da1c2228325ec();
            }
            
            return;
        }
        
        foreach ( banner in level.ar_root.a_banners )
        {
            banner thread function_441745cc64188d5c();
        }
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 0, eflags: 0x4
    // Checksum 0xf4ed110d, Offset: 0xc9fb
    // Size: 0x47, Type: dev
    function private function_dd3da1c2228325ec()
    {
        thread function_e063c51cf066875d( "<dev string:x7ca>" );
        
        for ( i = 0; i <= 100 ; i++ )
        {
            function_f27ed9845d047a7a( i );
            wait 0.15;
        }
        
        self notify( #"transition_complete" );
    }

    // Namespace zm_sat_hornet_assault_rounds
    // Params 0, eflags: 0x4
    // Checksum 0x9f4b83d5, Offset: 0xca4a
    // Size: 0xa9, Type: dev
    function private function_441745cc64188d5c()
    {
        for ( i = 100; i > 0 ; i-- )
        {
            function_f27ed9845d047a7a( i );
            
            if ( i < 25 )
            {
                utility::function_32b24db3127bff40( "<dev string:x7b7>", "<dev string:x7d1>" );
            }
            else if ( i < 50 )
            {
                utility::function_32b24db3127bff40( "<dev string:x7b7>", "<dev string:x7d9>" );
            }
            else if ( i < 75 )
            {
                utility::function_32b24db3127bff40( "<dev string:x7b7>", "<dev string:x7df>" );
            }
            
            wait 0.15;
        }
        
        thread function_e063c51cf066875d( "<dev string:x7e5>" );
        self notify( #"transition_complete" );
        utility::function_32b24db3127bff40( "<dev string:x7b7>", "<dev string:x7ec>" );
    }

#/
