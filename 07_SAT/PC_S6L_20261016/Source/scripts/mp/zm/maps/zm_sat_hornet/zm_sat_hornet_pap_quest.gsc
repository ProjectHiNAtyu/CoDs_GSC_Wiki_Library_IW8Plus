// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_pap_quest.gsc  (hash_0aa65e7ac54707a2.gscc) (size: 62845 Bytes / 0xf57d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdad49b5 (229460405)
// size ...... 62845 (0xf57d)
// includes .. 30  (offset: 0xe29d)
// strings ... 255 (offset: 0xe38d)
// dev strs .. 0   (offset: 0xf57d)
// exports ... 124 (offset: 0xa1bd)
// cseg ...... 0x1381 + 0x8e3c (0xa1bd)
// imports ... 315 (offset: 0xb51d)
// animtree1 . 0   (offset: 0xf57d)
// animtree2 . 0   (offset: 0xf57d)
#using script_4bf223434bdc0646;
#using scripts\anim\dialogue;
#using scripts\anim\utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\doorbuy;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\pack_a_punch;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_music;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_pap_quest;

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xc46a6fa4, Offset: 0x139f
// Size: 0x2ff
function init()
{
    level thread power_doors_manage();
    level thread function_7843016b27de3013();
    level thread setup_seed();
    
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        level thread pap_machine_setup();
        level thread pap_machine_clip( "off" );
    }
    
    if ( !zm_quest::function_b0a5181ebe7bb905() && !getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        if ( !isdefined( level.var_1d8bcf5a19244e0e ) )
        {
            level.var_1d8bcf5a19244e0e = spawnstruct();
        }
        
        level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3 = [];
        level.var_1d8bcf5a19244e0e.var_fcdcd383b4f959ed = "";
        
        if ( !isdefined( level.var_1d8bcf5a19244e0e.var_23edf8dfb11e1bf ) )
        {
            level.var_1d8bcf5a19244e0e.var_23edf8dfb11e1bf = [];
        }
        
        if ( !isdefined( level.var_1d8bcf5a19244e0e.var_8c6c59fc89ab90d1 ) )
        {
            level.var_1d8bcf5a19244e0e.var_8c6c59fc89ab90d1 = [];
        }
    }
    
    if ( getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        level.directed_mode = spawnstruct();
        level.directed_mode.var_f1879f50f4eeaca3 = [];
    }
    
    level utility::flag_wait( "zm_quest_initialized" );
    level utility::flag_set( "pause_ambient_ash" );
    level.hornet_pap_quest = zm_quest::get_quest( #"hornet_pap_quest" );
    zm_quest::register_quest_step( #"hornet_pap_quest", #"recapture_zones", &function_7cae64426832e03b, &function_d0c2a44444831980 );
    zm_quest::register_quest_step( #"hornet_pap_quest", #"enter_castle", &function_7cae65426832e26e, &function_d0c2a74444832019 );
    zm_quest::register_quest_step( #"hornet_pap_quest", #"locate_pap", &function_7cae66426832e4a1, &function_d0c2a64444831de6 );
    zm_quest::register_quest_step( #"hornet_pap_quest", #"defeat_oni", &function_7cae67426832e6d4, &function_d0c2a9444483247f );
    zm_quest::register_quest_step( #"hornet_pap_quest", #"acquire_hanko", &function_7cae68426832e907, &function_d0c2a8444483224c );
    zm_quest::register_quest_step( #"hornet_pap_quest", #"open_pap", &function_7cae69426832eb3a, &function_d0c2ab44448328e5 );
    zm_quest::register_quest_step( #"hornet_pap_quest", #"charge_seed", &function_7cae6a426832ed6d, &function_d0c2aa44448326b2 );
    level._effect[ "beam_power" ] = loadfxasset( "vfx_sat_hornet_pap_world_seed_beam" );
    utility::add_fx( "pap_move_in", "vfx_t10_levels_zm_opal_pap_move_land" );
    utility::add_fx( "pap_move_away", "vfx_t10_levels_zm_opal_pap_move_away" );
    callback::add( "doorbuy_opened", &on_door_bought );
    callback::add( "quest_item_used", &pap_quest_item_used );
    callback::add( "on_zombie_ai_spawned", &function_97be7f92252977f9 );
    callback::add( #"on_ai_killed", &on_pap_zombie_killed );
    callback::add( #"player_connect", &function_cc865ae17cc7f499 );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::update_round_cap( 3 );
    }
    
    level thread function_bfad22a0d43eb483();
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x1324579f, Offset: 0x16a6
// Size: 0x375
function function_cc865ae17cc7f499( params )
{
    zm_save::function_1f44a48caae2acbf();
    
    if ( level utility::flag( "completed_pap_step_7" ) )
    {
        if ( isdefined( level.sc_mayhem_teahouse ) )
        {
            level.sc_mayhem_teahouse setscriptablepartstate( "teahouse", "remove" );
        }
        
        if ( isdefined( level.var_c1d783648a59878a ) )
        {
            level.sc_mayhem_teahouse setscriptablepartstate( "teahouse_2", "remove" );
        }
        
        if ( isdefined( level.sc_mayhem_teahouse_door ) )
        {
            level.sc_mayhem_teahouse_door setscriptablepartstate( "teahouse_door", "remove" );
        }
        
        if ( isdefined( level.var_b30d42a5a5621ef8 ) )
        {
            level.var_b30d42a5a5621ef8 setscriptablepartstate( "mayhem_collapse_1", "remove" );
        }
        
        if ( isdefined( level.var_28482b4ab6c94a7b ) )
        {
            level.var_28482b4ab6c94a7b setscriptablepartstate( "mayhem_end_a_1", "remove" );
        }
        
        if ( isdefined( level.var_28482c4ab6c94cae ) )
        {
            level.var_28482c4ab6c94cae setscriptablepartstate( "mayhem_end_b_1", "remove" );
        }
        
        if ( isdefined( level.var_b30d45a5a5622591 ) )
        {
            level.var_b30d45a5a5622591 setscriptablepartstate( "mayhem_collapse_2", "remove" );
        }
        
        if ( isdefined( level.var_28561b4ab6d96ed0 ) )
        {
            level.var_28561b4ab6d96ed0 setscriptablepartstate( "mayhem_end_a_2", "remove" );
        }
        
        if ( isdefined( level.var_28561e4ab6d97569 ) )
        {
            level.var_28561e4ab6d97569 setscriptablepartstate( "mayhem_end_b_2", "remove" );
        }
        
        if ( isdefined( level.var_b30d44a5a562235e ) )
        {
            level.var_b30d44a5a562235e setscriptablepartstate( "mayhem_collapse_3", "remove" );
        }
        
        if ( isdefined( level.var_2851374ab6d3838d ) )
        {
            level.var_2851374ab6d3838d setscriptablepartstate( "mayhem_end_a_3", "remove" );
        }
        
        if ( isdefined( level.var_2851344ab6d37cf4 ) )
        {
            level.var_2851344ab6d37cf4 setscriptablepartstate( "mayhem_end_b_3", "remove" );
        }
        
        if ( isdefined( level.var_285e584ab6e1e0a5 ) )
        {
            level.var_285e584ab6e1e0a5 setscriptablepartstate( "mayhem_collapse_40", "remove" );
        }
        
        if ( isdefined( level.var_a95cf05032c14f0c ) )
        {
            level.var_a95cf05032c14f0c setscriptablepartstate( "mayhem_end_a_40", "remove" );
        }
        
        if ( isdefined( level.var_a95cf35032c155a5 ) )
        {
            level.var_a95cf35032c155a5 setscriptablepartstate( "mayhem_end_b_40", "remove" );
        }
        
        if ( isdefined( level.var_285e574ab6e1de72 ) )
        {
            level.var_285e574ab6e1de72 setscriptablepartstate( "mayhem_collapse_41", "remove" );
        }
        
        if ( isdefined( level.var_a9580c5032bb63c9 ) )
        {
            level.var_a9580c5032bb63c9 setscriptablepartstate( "mayhem_end_a_41", "remove" );
        }
        
        if ( isdefined( level.var_a958095032bb5d30 ) )
        {
            level.var_a958095032bb5d30 setscriptablepartstate( "mayhem_end_b_41", "remove" );
        }
        
        if ( isdefined( level.var_b30d46a5a56227c4 ) )
        {
            level.var_b30d46a5a56227c4 setscriptablepartstate( "mayhem_collapse_5", "remove" );
        }
        
        if ( isdefined( level.var_285a034ab6dd2fdf ) )
        {
            level.var_285a034ab6dd2fdf setscriptablepartstate( "mayhem_end_a_5", "remove" );
        }
        
        if ( isdefined( level.var_285a044ab6dd3212 ) )
        {
            level.var_285a044ab6dd3212 setscriptablepartstate( "mayhem_end_b_5", "remove" );
        }
        
        if ( isdefined( level.var_1516cb7495d00783 ) )
        {
            level.var_1516cb7495d00783 setscriptablepartstate( "courtyard", "remove" );
        }
        
        if ( isdefined( level.var_1516ca7495d00550 ) )
        {
            level.var_1516ca7495d00550 setscriptablepartstate( "courtyard", "remove" );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xe9f8056, Offset: 0x1a23
// Size: 0x77b
function power_doors_manage()
{
    s_teahouse = utility::getstruct( "mayhem_teahouse" );
    
    if ( isdefined( s_teahouse ) )
    {
        level.sc_mayhem_teahouse = spawnscriptable( %"zm_sat_hornet_pap_collapse", s_teahouse.origin, s_teahouse.angles );
        level.sc_mayhem_teahouse utility::function_32b24db3127bff40( "teahouse", "show" );
        level.var_c1d783648a59878a = spawnscriptable( %"zm_sat_hornet_pap_collapse", s_teahouse.origin, s_teahouse.angles );
        level.var_c1d783648a59878a utility::function_32b24db3127bff40( "teahouse_2", "show" );
    }
    
    s_teahouse_door = utility::getstruct( "mayhem_teahouse_door" );
    
    if ( isdefined( s_teahouse_door ) )
    {
        level.sc_mayhem_teahouse_door = spawnscriptable( %"zm_sat_hornet_pap_collapse", s_teahouse_door.origin, s_teahouse_door.angles );
        level.sc_mayhem_teahouse_door utility::function_32b24db3127bff40( "teahouse_door", "show" );
    }
    
    level utility::flag_wait( "zm_sat_hornet_pap_quest_cs_completed" );
    var_d948fd9ff30650c5 = utility::getstruct( "vfx_mayhem_collapse_1" );
    var_d948fa9ff3064a2c = utility::getstruct( "vfx_mayhem_collapse_2" );
    var_d948fb9ff3064c5f = utility::getstruct( "vfx_mayhem_collapse_3" );
    var_e1c0bdc376cbdc02 = utility::getstruct( "vfx_mayhem_collapse_40" );
    var_e1c0bec376cbde35 = utility::getstruct( "vfx_mayhem_collapse_41" );
    var_d948f99ff30647f9 = utility::getstruct( "vfx_mayhem_collapse_5" );
    level.var_b30d42a5a5621ef8 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fd9ff30650c5.origin, var_d948fd9ff30650c5.angles );
    level.var_28482b4ab6c94a7b = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fd9ff30650c5.origin, var_d948fd9ff30650c5.angles );
    level.var_28482c4ab6c94cae = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fd9ff30650c5.origin, var_d948fd9ff30650c5.angles );
    level.var_b30d45a5a5622591 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fa9ff3064a2c.origin, var_d948fa9ff3064a2c.angles );
    level.var_28561b4ab6d96ed0 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fa9ff3064a2c.origin, var_d948fa9ff3064a2c.angles );
    level.var_28561e4ab6d97569 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fa9ff3064a2c.origin, var_d948fa9ff3064a2c.angles );
    level.var_b30d44a5a562235e = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fb9ff3064c5f.origin, var_d948fb9ff3064c5f.angles );
    level.var_2851374ab6d3838d = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fb9ff3064c5f.origin, var_d948fb9ff3064c5f.angles );
    level.var_2851344ab6d37cf4 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948fb9ff3064c5f.origin, var_d948fb9ff3064c5f.angles );
    level.var_285e584ab6e1e0a5 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_e1c0bdc376cbdc02.origin, var_e1c0bdc376cbdc02.angles );
    level.var_a95cf05032c14f0c = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_e1c0bdc376cbdc02.origin, var_e1c0bdc376cbdc02.angles );
    level.var_a95cf35032c155a5 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_e1c0bdc376cbdc02.origin, var_e1c0bdc376cbdc02.angles );
    level.var_285e574ab6e1de72 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_e1c0bec376cbde35.origin, var_e1c0bec376cbde35.angles );
    level.var_a9580c5032bb63c9 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_e1c0bec376cbde35.origin, var_e1c0bec376cbde35.angles );
    level.var_a958095032bb5d30 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_e1c0bec376cbde35.origin, var_e1c0bec376cbde35.angles );
    level.var_b30d46a5a56227c4 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948f99ff30647f9.origin, var_d948f99ff30647f9.angles );
    level.var_285a034ab6dd2fdf = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948f99ff30647f9.origin, var_d948f99ff30647f9.angles );
    level.var_285a044ab6dd3212 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_d948f99ff30647f9.origin, var_d948f99ff30647f9.angles );
    level.var_b30d42a5a5621ef8 utility::function_32b24db3127bff40( "mayhem_collapse_1", "show" );
    level.var_b30d45a5a5622591 utility::function_32b24db3127bff40( "mayhem_collapse_2", "show" );
    level.var_b30d44a5a562235e utility::function_32b24db3127bff40( "mayhem_collapse_3", "show" );
    level.var_285e584ab6e1e0a5 utility::function_32b24db3127bff40( "mayhem_collapse_40", "show" );
    level.var_285e574ab6e1de72 utility::function_32b24db3127bff40( "mayhem_collapse_41", "show" );
    level.var_b30d46a5a56227c4 utility::function_32b24db3127bff40( "mayhem_collapse_5", "show" );
    var_9b5f97845af4393c = utility::getstruct( "mayhem_courtyard_0" );
    var_9b5f98845af43b6f = utility::getstruct( "mayhem_courtyard_1" );
    
    if ( isdefined( var_9b5f97845af4393c ) )
    {
        level.var_1516cb7495d00783 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_9b5f97845af4393c.origin, var_9b5f97845af4393c.angles );
        level.var_1516cb7495d00783 utility::function_32b24db3127bff40( "courtyard", "show" );
    }
    
    if ( isdefined( var_9b5f98845af43b6f ) )
    {
        level.var_1516ca7495d00550 = spawnscriptable( %"zm_sat_hornet_pap_collapse", var_9b5f98845af43b6f.origin, var_9b5f98845af43b6f.angles );
        level.var_1516ca7495d00550 utility::function_32b24db3127bff40( "courtyard", "show" );
    }
    
    teahouse_door_dmg = getent( "teahouse_door_dmg", "targetname" );
    teahouse_dmg = getent( "teahouse_dmg", "targetname" );
    teahouse_door = getent( "teahouse_door", "targetname" );
    
    if ( isdefined( teahouse_door_dmg ) )
    {
        teahouse_door_dmg hide();
    }
    
    if ( isdefined( teahouse_dmg ) )
    {
        teahouse_dmg hide();
    }
    
    level utility::flag_wait( "power_on" );
    
    if ( isdefined( teahouse_door ) )
    {
        teahouse_door delete();
    }
    
    bailey_walls = getentarray( "bailey_walls", "targetname" );
    
    if ( isdefined( bailey_walls ) )
    {
        foreach ( wall in bailey_walls )
        {
            wall delete();
        }
    }
    
    wait 3.25;
    
    if ( isdefined( level.var_1516cb7495d00783 ) )
    {
        level.var_1516cb7495d00783 thread courtyard_mayhem();
    }
    
    wait 0.4;
    
    if ( isdefined( level.var_1516ca7495d00550 ) )
    {
        level.var_1516ca7495d00550 thread courtyard_mayhem();
    }
    
    wait 0.3;
    level thread function_2a4c061322d696b3( teahouse_door_dmg );
    wait 0.2;
    level thread function_1f8b05a9f8456196( teahouse_dmg );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xc0caf9c6, Offset: 0x21a6
// Size: 0x2a
function courtyard_mayhem()
{
    utility::function_32b24db3127bff40( "courtyard", "collapse" );
    wait 4;
    utility::function_32b24db3127bff40( "courtyard", "remove" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xc2404bb8, Offset: 0x21d8
// Size: 0xd6
function function_2a4c061322d696b3( teahouse_door_dmg )
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.sc_mayhem_teahouse_door ) )
    {
        s_door_vfx = utility::getstruct( "vfx_mayhem_teahouse_door" );
        sc_door_fx = spawnscriptable( %"zm_sat_hornet_door_fx", s_door_vfx.origin, s_door_vfx.angles );
        level.sc_mayhem_teahouse_door utility::function_32b24db3127bff40( "teahouse_door", "collapse" );
        
        if ( isdefined( teahouse_door_dmg ) )
        {
            teahouse_door_dmg show();
        }
        
        wait 0.5;
        sc_door_fx utility::function_32b24db3127bff40( "visual", "collapse_teahouse_door" );
        wait 0.5;
        level.sc_mayhem_teahouse_door utility::function_32b24db3127bff40( "teahouse_door", "remove" );
        wait 3;
        sc_door_fx freescriptable();
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x84dbd4cb, Offset: 0x22b6
// Size: 0xee
function function_1f8b05a9f8456196( teahouse_dmg )
{
    if ( isdefined( level.sc_mayhem_teahouse ) )
    {
        s_teahouse = utility::getstruct( "vfx_mayhem_teahouse" );
        sc_fx = spawnscriptable( %"zm_sat_hornet_door_fx", s_teahouse.origin, s_teahouse.angles );
        sc_fx utility::function_32b24db3127bff40( "visual", "collapse_teahouse" );
        level.sc_mayhem_teahouse utility::function_32b24db3127bff40( "teahouse", "collapse" );
        level.var_c1d783648a59878a utility::function_32b24db3127bff40( "teahouse_2", "collapse" );
        wait 4;
        
        if ( isdefined( teahouse_dmg ) )
        {
            teahouse_dmg show();
        }
        
        wait 0.25;
        level.sc_mayhem_teahouse utility::function_32b24db3127bff40( "teahouse", "remove" );
        level.var_c1d783648a59878a utility::function_32b24db3127bff40( "teahouse_2", "remove" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xc19939ed, Offset: 0x23ac
// Size: 0x57
function function_bfad22a0d43eb483()
{
    level utility::flag_wait( "zm_sat_hornet_pap_quest_cs_completed" );
    level thread function_6306dbeede39d1d7();
    level thread function_bdf602b91c95b683();
    level thread function_277e591e97d5d692();
    level utility::flag_wait( "begin_round_logic" );
    zm_save::function_1f44a48caae2acbf();
    wait 1;
    level thread hide_mayhem();
    level thread zm_quest::start_quest( #"hornet_pap_quest" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x6b2bd1a4, Offset: 0x240b
// Size: 0x40
function function_7cae64426832e03b( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread waypoint_manager();
        level thread setup_banners();
        level thread function_389ddc8b4bf8b55f();
    }
    
    level utility::flag_wait( "completed_pap_step_1" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x2e6ca8ba, Offset: 0x2453
// Size: 0x153
function function_d0c2a44444831980( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "path_chosen" );
        level utility::flag_set( "door_third_bailey_to_west_bailey" );
        level utility::flag_set( "door_third_bailey_to_lava_garden" );
        level utility::flag_set( "door_lava_garden_to_second_bailey" );
        level utility::flag_set( "door_west_bailey_to_broken_turrets" );
        level utility::flag_set( "recaptured" );
        level utility::flag_set( "banner_west" );
        level utility::flag_set( "banner_east" );
        level.hornet_pap_quest.var_4dccbd0938637832 = 2;
        function_c18bdbf334f8dca0();
        function_dbba969b8138dd8f();
        a_s_banners = utility::getstructarray( "ar_bnr" );
        
        foreach ( s_banner in a_s_banners )
        {
            s_banner.var_a8603eb5b0931afd = 1;
        }
        
        if ( !b_save_restored )
        {
            function_543179c3a70a24ee();
        }
        
        function_ecc91637c2a6fbb1();
    }
    
    level utility::flag_set( "completed_pap_step_1" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x7a4820a6, Offset: 0x25ae
// Size: 0x30
function function_7cae65426832e26e( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread castle_reinforce();
    }
    
    level utility::flag_wait( "completed_pap_step_2" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x54755efd, Offset: 0x25e6
// Size: 0x51
function function_d0c2a74444832019( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "open_gate" );
        level thread function_d84af0d2d9f5ad30();
        
        if ( !b_save_restored )
        {
            level thread function_116362c59412bd67();
        }
        
        function_ecc91637c2a6fbb1();
    }
    
    level utility::flag_set( "completed_pap_step_2" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x2a40f95e, Offset: 0x263f
// Size: 0x38
function function_7cae66426832e4a1( b_skipped, b_save_restored )
{
    if ( !b_skipped )
    {
        level thread pap_room_locate();
        level thread setup_pap_door();
    }
    
    level utility::flag_wait( "completed_pap_step_3" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0xae83ce3a, Offset: 0x267f
// Size: 0x47
function function_d0c2a64444831de6( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        if ( !b_save_restored )
        {
            function_78e3df30184e468a();
        }
        else
        {
            level thread oni_spawn();
        }
        
        level thread setup_pap_door();
    }
    
    level utility::flag_set( "completed_pap_step_3" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0xb6fec878, Offset: 0x26ce
// Size: 0x41
function function_7cae67426832e6d4( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "pap_door_found" );
        level utility::flag_set( "pap_special_dead" );
    }
    
    level utility::flag_wait( "completed_pap_step_4" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0xc7c812b6, Offset: 0x2717
// Size: 0x41
function function_d0c2a9444483247f( b_skipped, b_save_restored )
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::update_round_cap( 8 );
    }
    
    if ( b_skipped )
    {
        level thread oni_skipto();
    }
    
    level utility::flag_set( "completed_pap_step_4" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x956791aa, Offset: 0x2760
// Size: 0x22
function function_7cae68426832e907( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_pap_step_5" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x1f09a39e, Offset: 0x278a
// Size: 0x2e
function function_d0c2a8444483224c( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        function_11e7549c11b7a2c();
    }
    
    level utility::flag_set( "completed_pap_step_5" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x956791aa, Offset: 0x27c0
// Size: 0x22
function function_7cae69426832eb3a( b_skipped, b_save_restored )
{
    level utility::flag_wait( "completed_pap_step_6" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0xe777265b, Offset: 0x27ea
// Size: 0x7b
function function_d0c2ab44448328e5( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level utility::flag_set( "pap_open" );
        
        if ( !b_save_restored )
        {
            level thread open_pap_door();
        }
        else if ( isdefined( level.hornet_pap_quest.sc_pap_door ) )
        {
            level.hornet_pap_quest.sc_pap_door freescriptable();
        }
        
        function_ecc91637c2a6fbb1();
    }
    
    level utility::flag_set( "completed_pap_step_6" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x5de9af47, Offset: 0x286d
// Size: 0x3f
function function_7cae6a426832ed6d( b_skipped, b_save_restored )
{
    if ( !b_skipped && !b_save_restored )
    {
        level thread function_883b24fb102f2d60();
        level thread function_f6953edf42d8c16d();
    }
    
    level utility::flag_wait( "completed_pap_step_7" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x561d1b3b, Offset: 0x28b4
// Size: 0x1be
function function_d0c2aa44448326b2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "seed_charged" );
        level utility::flag_set( "power_on" );
        level thread onryo_spawn_katana();
        level thread function_821fc42d473d0b40();
        level thread pap_machine_show();
        level thread open_power_doors();
        level thread activate_ash();
    }
    
    level val::set( "power_on", "task_logic_activate", 1 );
    
    if ( b_save_restored )
    {
        level utility::flag_clear( "pause_ambient_ash" );
    }
    
    callback::remove( "on_zombie_ai_spawned", &function_97be7f92252977f9 );
    callback::remove( #"on_ai_killed", &on_pap_zombie_killed );
    clear_guidance();
    
    if ( !b_save_restored && !b_skipped )
    {
        level thread function_668b3128737b8247();
        level thread function_564b22a62efd6c4f();
    }
    
    if ( isdefined( level.hornet_pap_quest.sc_seed.interact ) )
    {
        level.hornet_pap_quest.sc_seed.interact delete();
    }
    
    if ( isdefined( level.var_1d8bcf5a19244e0e ) && !zm_quest::function_b0a5181ebe7bb905() && !getdvarint( @"hash_446bdaab1c4cbb2b", 0 ) )
    {
        level.var_1d8bcf5a19244e0e.var_fcdcd383b4f959ed = undefined;
        level.var_1d8bcf5a19244e0e.var_23edf8dfb11e1bf = undefined;
        level.var_1d8bcf5a19244e0e.var_8c6c59fc89ab90d1 = undefined;
        level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3 = undefined;
        level.var_1d8bcf5a19244e0e = undefined;
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"hornet_pap_quest", #"hash_f65352c5c3ebcf80", 1 );
    level utility::flag_set( "completed_pap_step_7" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x9b10bcb6, Offset: 0x2a7a
// Size: 0x1e6
function pap_machine_setup()
{
    level utility::flag_wait( "begin_round_logic" );
    level.hornet_pap_ghost = spawnscriptable( %"zm_sat_hornet_pap_ghost", level.var_db52bcfd04d45a7a[ 0 ].origin, level.var_db52bcfd04d45a7a[ 0 ].angles );
    
    foreach ( loc in level.var_db52bcfd04d45a7a )
    {
        loc.var_72ee3a4eceafc252 = utility::spawn_model( "tag_origin", loc.var_370acb837a3a86c3.origin, loc.var_370acb837a3a86c3.angles );
        
        if ( isdefined( loc.var_72ee3a4eceafc252 ) )
        {
            loc.var_370acb837a3a86c3 pack_a_punch::function_d38459448f4fef64( loc.var_72ee3a4eceafc252 );
            
            if ( loc.var_370acb837a3a86c3 )
            {
                loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "collision", "off" );
            }
        }
        
        if ( loc.var_72ee3a4eceafc252 && loc.var_370acb837a3a86c3 )
        {
            loc.var_72ee3a4eceafc252 moveto( loc.origin + ( 0, 0, -9999 ), 0.1 );
            loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "idle" );
            loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "warp", "warp_out" );
        }
    }
    
    level utility::flag_set( "pap_setup" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xf3a8d68e, Offset: 0x2c68
// Size: 0x487
function pap_machine_show( bvisible = 1 )
{
    level utility::flag_wait( "pap_setup" );
    
    if ( isarray( level.var_db52bcfd04d45a7a ) )
    {
        if ( bvisible )
        {
            foreach ( loc in level.var_db52bcfd04d45a7a )
            {
                if ( loc && loc.var_72ee3a4eceafc252 && loc.var_370acb837a3a86c3 )
                {
                    s_pap_knockback = utility::getstruct( "pap_receptor" );
                    var_91cffc440e2463e = utility::getstructarray( s_pap_knockback.target );
                    a_players = getplayersinradius( s_pap_knockback.origin, 100 );
                    
                    foreach ( player in a_players )
                    {
                        if ( isdefined( player ) )
                        {
                            player setorigin( var_91cffc440e2463e[ player getentitynumber() ].origin );
                        }
                    }
                    
                    loc.var_72ee3a4eceafc252 moveto( loc.origin, 0.1 );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "active" );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "warp", "warp_in" );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "collision", "on" );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "base", "pap_idle" );
                    playfx( level._effect[ "pap_move_in" ], loc.origin, anglestoforward( loc.var_370acb837a3a86c3.angles ) );
                    wait 0.1;
                    
                    if ( level.pap_quest.clip_pap )
                    {
                        level.pap_quest.clip_pap solid();
                        level.pap_quest.clip_pap moveto( level.pap_quest.clip_pap.origin + ( 0, 0, 9999 ), 0.1 );
                        wait 0.2;
                        level.pap_quest.clip_pap disconnectpaths();
                    }
                }
            }
        }
        else
        {
            foreach ( loc in level.var_db52bcfd04d45a7a )
            {
                if ( loc && loc.var_72ee3a4eceafc252 && loc.var_370acb837a3a86c3 )
                {
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "collision", "off" );
                    loc.var_72ee3a4eceafc252 moveto( loc.origin + ( 0, 0, -9999 ), 0.1 );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "minimap_icon", "idle" );
                    loc.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "warp", "warp_out" );
                    playfx( level._effect[ "pap_move_away" ], loc.var_370acb837a3a86c3.origin, anglestoforward( loc.var_370acb837a3a86c3.angles ) );
                }
            }
        }
    }
    
    level.hornet_pap_ghost utility::function_7c10ea82c1e305b8( "fx", "off" );
    wait 0.5;
    pap_machine_clip( "on" );
    level.hornet_pap_ghost freescriptable();
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xb8192cef, Offset: 0x30f7
// Size: 0x5a
function pap_machine_clip( str_state )
{
    pap_clip = getent( "clip_pap", "targetname" );
    
    if ( !isdefined( pap_clip ) )
    {
        return;
    }
    
    if ( str_state == "off" )
    {
        pap_clip connectpaths();
        waitframe();
        pap_clip notsolid();
        return;
    }
    
    pap_clip solid();
    waitframe();
    pap_clip disconnectpaths();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xc0c7015c, Offset: 0x3159
// Size: 0x10b
function function_7843016b27de3013()
{
    var_b0f5ca579d03b5c = getentarray( "zombie_door", "targetname" );
    
    foreach ( door in var_b0f5ca579d03b5c )
    {
        if ( door.script_flag_set === "door_main_bailey_to_main_keep" )
        {
            door triggerdisable();
            door thread function_7bdacb69d9e3c87f();
            continue;
        }
        
        if ( door.target2 === "doorbuy_powered_door_7" )
        {
            door triggerdisable();
            continue;
        }
        
        if ( door.script_flag_set === "door_main_keep_to_top" )
        {
            if ( !game_utility::function_21211f3255f8ea58() )
            {
                door triggerdisable();
            }
            
            continue;
        }
        
        if ( door.script_flag_set === "door_power_on" )
        {
            door triggerdisable();
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x4b13b288, Offset: 0x326c
// Size: 0x372
function setup_banners()
{
    level.hornet_pap_quest.var_4dccbd0938637832 = 0;
    level.hornet_pap_quest.var_60f10a48d7117b2e = [];
    a_s_banners = utility::getstructarray( "ar_bnr" );
    level utility::flag_wait_or_timeout( "content_manager_populated", 15 );
    level utility::flag_wait_or_timeout( "arsenal_ready", 60 );
    
    foreach ( s_banner in a_s_banners )
    {
        s_banner.sc_banner = function_47c86977a18df38b( level.ar_root.a_banners, s_banner.origin );
        s_banner.is_capturing = 0;
        s_banner.var_a8603eb5b0931afd = 0;
        s_banner.var_18b773b3291055b8 = 0;
        
        if ( s_banner.script_noteworthy == "0" || s_banner.script_noteworthy == "2" )
        {
            s_banner.sc_banner utility::function_32b24db3127bff40( "model", "zombie" );
            var_afe1b0748facfa77 = vectornormalize( anglestoforward( s_banner.angles ) ) * 32 + s_banner.origin;
            s_banner.interact = interaction::register_interact( var_afe1b0748facfa77 + ( 0, 0, 64 ), 64, &function_edd6fd86cb0045ba, undefined, undefined, undefined, 1, undefined, 1 );
            s_banner.interact interaction::set_interact_hint_callback( &zm_sat_hornet_assault_rounds::banner_hint );
            s_banner.interact.s_banner = s_banner;
            s_banner.var_5cc061d568e1fe48 = 1;
            s_banner thread zm_sat_hornet_assault_rounds::function_ba755c3ed9de2375();
            
            if ( s_banner.script_noteworthy == "2" )
            {
                s_banner.var_c60fa5cf14135042 = "zone_lava_garden_b";
                s_banner.str_flag = "banner_east";
            }
            else
            {
                s_banner.var_c60fa5cf14135042 = "zone_west_bailey_b";
                s_banner.str_flag = "banner_west";
            }
            
            s_banner.zone = zone_manager::function_90e5c3e2272b0130( s_banner.origin );
            s_banner.zone_name = function_fbb7d4c98261e273( s_banner.zone.script_zone_name );
            s_banner.zone_name_adj = function_fbb7d4c98261e273( s_banner.var_c60fa5cf14135042 );
            zm_utility::function_549e7bc8f78816f2( [ s_banner.zone_name ], level.var_6f89b56853b0e818 );
            zm_utility::function_549e7bc8f78816f2( [ s_banner.zone_name_adj ], level.var_6f89b56853b0e818 );
            level.hornet_pap_quest.var_60f10a48d7117b2e[ level.hornet_pap_quest.var_60f10a48d7117b2e.size ] = s_banner.zone_name;
            level.hornet_pap_quest.var_60f10a48d7117b2e[ level.hornet_pap_quest.var_60f10a48d7117b2e.size ] = s_banner.zone_name_adj;
            s_banner thread function_5fc0a5718bf2f262();
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xdd593c1, Offset: 0x35e6
// Size: 0x108
function function_389ddc8b4bf8b55f()
{
    level.hornet_pap_quest.a_s_banners = [];
    a_s_banners = utility::getstructarray( "ar_bnr" );
    
    foreach ( s_banner in a_s_banners )
    {
        if ( s_banner.script_noteworthy == "0" || s_banner.script_noteworthy == "2" )
        {
            level.hornet_pap_quest.a_s_banners[ level.hornet_pap_quest.a_s_banners.size ] = s_banner;
            s_banner thread zm_sat_hornet_assault_rounds::setup_banner_spawners();
            s_banner thread function_e082e39f81428e54();
        }
    }
    
    level utility::flag_set( "pap_banners_setup" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x491375c, Offset: 0x36f6
// Size: 0x145
function function_e082e39f81428e54()
{
    level endon( #"completed_pap_step_1", #"game_ended" );
    self waittill( #"recaptured" );
    level utility::flag_set( self.str_flag );
    level.hornet_pap_quest.var_60f10a48d7117b2e = arrayremove( level.hornet_pap_quest.var_60f10a48d7117b2e, self.zone_name );
    level.hornet_pap_quest.var_60f10a48d7117b2e = arrayremove( level.hornet_pap_quest.var_60f10a48d7117b2e, self.zone_name_adj );
    level.hornet_pap_quest.a_s_banners = arrayremove( level.hornet_pap_quest.a_s_banners, self );
    level.hornet_pap_quest.var_4dccbd0938637832++;
    
    if ( level.hornet_pap_quest.var_4dccbd0938637832 > 1 )
    {
        level utility::flag_set( "recaptured" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            zm_quest::update_round_cap( 6 );
        }
        
        function_ecc91637c2a6fbb1();
        level utility::flag_set( "completed_pap_step_1" );
        return;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::update_round_cap( 5 );
    }
    
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x5f989d56, Offset: 0x3843
// Size: 0x14a
function function_edd6fd86cb0045ba( player )
{
    if ( player.interactions_disabled || self.s_banner.is_capturing || self.s_banner.var_a8603eb5b0931afd || self.s_banner.var_18b773b3291055b8 )
    {
        return;
    }
    
    self.s_banner.is_capturing = 1;
    self.s_banner.var_87dd3688c0c064f4 = [];
    zm_sat_hornet_assault_rounds::function_5c9b2c6a0019344( player, self.s_banner );
    self.s_banner.sc_banner thread zm_sat_hornet_assault_rounds::function_e063c51cf066875d( "player" );
    self.s_banner thread zm_sat_hornet_assault_rounds::function_5462496b3794dac0( 60, undefined, 1, undefined );
    self.s_banner thread zm_sat_hornet_assault_rounds::banner_spawn_zombies();
    self.s_banner thread zm_sat_hornet_assault_rounds::function_6919121fac8d500b();
    self.s_banner thread zm_sat_hornet_assault_rounds::function_6ed70e3e9718050();
    self.s_banner thread zm_sat_hornet_assault_rounds::banner_recapture_ended();
    self.s_banner thread music_banner();
    
    if ( !isdefined( level.var_8952dce7e74c4efb ) )
    {
        level.var_8952dce7e74c4efb = 1;
        level thread vo_banner_recapture( player, "start" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x659115dd, Offset: 0x3995
// Size: 0xfe
function music_banner()
{
    var_a77bb00f025e9731 = [];
    var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( self.origin );
    zone_name = var_8c4fe62d01999d1e.script_zone_name;
    var_a77bb00f025e9731[ var_a77bb00f025e9731.size ] = zone_name;
    adj_zones = var_8c4fe62d01999d1e zone_manager::get_adjacent_zones( 1, 1 );
    
    foreach ( zone in adj_zones )
    {
        var_a77bb00f025e9731[ var_a77bb00f025e9731.size ] = zone.script_zone_name;
    }
    
    level thread zm_music::start_zone_music_watcher( self.str_flag, var_a77bb00f025e9731, #"hash_637574d900fb0e8a" );
    thread function_cd181b056fcad50( self.str_flag );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x18a84abe, Offset: 0x3a9b
// Size: 0xc7
function function_cd181b056fcad50( var_b6ddd8c5c34be1b3 )
{
    var_5a1c0f3d18fe810f = utility::waittill_any_return( "recaptured", "recapture_failed" );
    player = function_47c86977a18df38b( level.players, self.origin );
    level thread zm_music::function_e9fd14ede793ef0d( var_b6ddd8c5c34be1b3 );
    
    if ( var_5a1c0f3d18fe810f == "recapture_failed" && !isdefined( level.vo_recapture_failed ) )
    {
        level.vo_recapture_failed = 1;
        
        if ( isdefined( player ) )
        {
            level thread vo_banner_recapture( player, "fail" );
        }
        
        return;
    }
    
    if ( !isdefined( level.var_8f0df0c14a98e9f2 ) )
    {
        level.var_8f0df0c14a98e9f2 = 1;
        
        if ( isdefined( player ) )
        {
            level thread function_7d21ff99616b2601( "banner_recaptured", 2, "positive", player );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x1d2c482f, Offset: 0x3b6a
// Size: 0x9c
function function_6306dbeede39d1d7()
{
    level.hornet_pap_quest.var_da0a79ef903d0ac0 = [];
    level.hornet_pap_quest.n_seals = 2;
    level.hornet_pap_quest.var_7fa71543e1948601 = 0;
    s_seal_west = utility::getstruct( "seal_west" );
    s_seal_east = utility::getstruct( "seal_east" );
    s_seal_west thread function_1cd37208f7b3525( "sat_jap_sign_banner_01_flag", "banner_west" );
    s_seal_east thread function_1cd37208f7b3525( "sat_jap_sign_banner_03_flag", "banner_east" );
    level thread function_15dd98ee9d1636b5();
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x52f0dc43, Offset: 0x3c0e
// Size: 0x142
function function_1cd37208f7b3525( var_1479f07b528e4ff7, str_flag )
{
    level endon( #"completed_pap_step_2" );
    level utility::flag_wait( "begin_round_logic" );
    sc_seal = spawnscriptable( %"zm_sat_hornet_pap_fx", self.origin, self.angles );
    sc_seal utility::function_32b24db3127bff40( "gate_glyph", "glyph_on" );
    sc_seal thread gate_glyph_watcher( str_flag );
    level.hornet_pap_quest.var_da0a79ef903d0ac0[ level.hornet_pap_quest.var_da0a79ef903d0ac0.size ] = sc_seal;
    level utility::flag_wait( str_flag );
    
    if ( !isdefined( sc_seal ) )
    {
        return;
    }
    
    self.interact = interaction::register_interact( self.origin, 80, &function_f8678256a852a07b, undefined, undefined, undefined, 1 );
    self.interact interaction::set_interact_hint_callback( &seal_hint );
    self.interact.sc_seal = sc_seal;
    self.interact.str_flag = str_flag;
    self.interact.b_interacted = 0;
    sc_seal.interact = self.interact;
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x67c6bf07, Offset: 0x3d58
// Size: 0x1bd
function function_f8678256a852a07b( player )
{
    if ( player.interactions_disabled || self.b_interacted || !level utility::flag( self.str_flag ) || level utility::flag( "open_gate" ) || level utility::flag( "banner_west" ) && level utility::flag( "banner_east" ) && !level.hornet_pap_quest.var_7fa71543e1948601 )
    {
        return;
    }
    
    if ( level utility::flag( self.str_flag ) )
    {
        level.hornet_pap_quest.var_7fa71543e1948601++;
        self.b_interacted = 1;
        self.sc_seal utility::function_32b24db3127bff40( "gate_glyph", "glyph_remove" );
        
        if ( !isdefined( level.vo_glyph_removed ) )
        {
            level.vo_glyph_removed = 1;
            level thread vo_glyph_removed( player );
        }
        
        level.hornet_pap_quest.n_seals--;
        
        if ( !level.hornet_pap_quest.n_seals )
        {
            wait 3;
            level utility::flag_set( "open_gate" );
            function_ecc91637c2a6fbb1();
            
            foreach ( sc_seal in level.hornet_pap_quest.var_da0a79ef903d0ac0 )
            {
                sc_seal freescriptable();
            }
        }
        
        self delete();
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0xdf5168c2, Offset: 0x3f1d
// Size: 0x156
function seal_hint( interact, player )
{
    if ( player.interactions_disabled || !level utility::flag( interact.str_flag ) || level utility::flag( "open_sesame" ) || interact.b_interacted || level utility::flag( "banner_west" ) && level utility::flag( "banner_east" ) && !level.hornet_pap_quest.var_7fa71543e1948601 || level utility::flag( "open_gate" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( level.hornet_pap_quest.var_7fa71543e1948601 == 0 && level.hornet_pap_quest.var_4dccbd0938637832 == 2 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_3427f62b50e3f10b", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_4aa26471ae62373a", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x314d0077, Offset: 0x407c
// Size: 0x33
function gate_glyph_watcher( str_flag )
{
    level endon( #"completed_pap_step_2" );
    level utility::flag_wait( str_flag );
    utility::function_32b24db3127bff40( "gate_glyph", "glyph_off" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xed7c7b54, Offset: 0x40b7
// Size: 0x59
function function_15dd98ee9d1636b5()
{
    var_4ed46be95235b8ff = utility::getstruct( "gate_entrance" );
    var_4ed46be95235b8ff.interact = interaction::register_interact( var_4ed46be95235b8ff.origin, 80, &function_fbc685cf103f703, undefined, undefined, undefined, 1 );
    var_4ed46be95235b8ff.interact interaction::set_interact_hint_callback( &function_cb4768dc7d042521 );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x6140ccfa, Offset: 0x4118
// Size: 0x1ce
function function_fbc685cf103f703( player )
{
    if ( player.interactions_disabled || self.b_interacted || !level utility::flag( "banner_west" ) || !level utility::flag( "banner_east" ) || level.hornet_pap_quest.n_seals < 2 || level utility::flag( "open_gate" ) )
    {
        return;
    }
    
    self.b_interacted = 1;
    
    foreach ( mdl_seal in level.hornet_pap_quest.var_da0a79ef903d0ac0 )
    {
        mdl_seal utility::function_32b24db3127bff40( "gate_glyph", "glyph_remove" );
        level.hornet_pap_quest.n_seals--;
        
        if ( !level.hornet_pap_quest.n_seals )
        {
            wait 3.5;
            level utility::flag_set( "open_gate" );
            
            foreach ( mdl_seal in level.hornet_pap_quest.var_da0a79ef903d0ac0 )
            {
                mdl_seal freescriptable();
            }
            
            function_ecc91637c2a6fbb1();
        }
    }
    
    self delete();
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0xbd5a52fa, Offset: 0x42ee
// Size: 0x143
function function_cb4768dc7d042521( interact, player )
{
    if ( player.interactions_disabled || level utility::flag( "open_sesame" ) || interact.b_interacted || !level utility::flag( "banner_west" ) || !level utility::flag( "banner_east" ) || level.hornet_pap_quest.n_seals < 2 || level utility::flag( "open_gate" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( level.hornet_pap_quest.var_7fa71543e1948601 == 0 && level.hornet_pap_quest.var_4dccbd0938637832 == 2 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_3427f62b50e3f10b", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_4aa26471ae62373a", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x968b726, Offset: 0x443a
// Size: 0xf3
function function_7bdacb69d9e3c87f()
{
    level endon( #"completed_pap_step_2" );
    level utility::flag_wait( "open_gate" );
    
    foreach ( door in self.doors )
    {
        door thread doorbuy::function_f3160e450543b4f1();
    }
    
    player = function_47c86977a18df38b( level.players, self.doors[ 0 ].origin );
    
    if ( isdefined( player ) )
    {
        level thread function_7d21ff99616b2601( "gate_opened", 2.5, "negative", player );
    }
    
    function_ecc91637c2a6fbb1();
    level utility::flag_set( "completed_pap_step_2" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x2254d87f, Offset: 0x4535
// Size: 0x14a
function function_bdf602b91c95b683()
{
    level endon( #"open_sesame" );
    level.hornet_pap_quest.a_s_objs = [];
    path_west = utility::getstruct( "pap_waypoint_west", "targetname" );
    path_east = utility::getstruct( "pap_waypoint_east", "targetname" );
    level.hornet_pap_quest.a_s_objs[ level.hornet_pap_quest.a_s_objs.size ] = path_west;
    level.hornet_pap_quest.a_s_objs[ level.hornet_pap_quest.a_s_objs.size ] = path_east;
    level utility::flag_wait( "open_gate" );
    level utility::flag_wait_any( "door_main_bailey_to_main_keep_west_path", "door_main_bailey_to_main_keep_east_path" );
    
    if ( level utility::flag( "door_main_bailey_to_main_keep_west_path" ) )
    {
        level.hornet_pap_quest.path_next = utility::getstruct( path_west.target );
    }
    else
    {
        level.hornet_pap_quest.path_next = utility::getstruct( path_east.target );
    }
    
    function_ecc91637c2a6fbb1();
    level utility::flag_wait_any( "door_main_keep_left_path_to_main_keep2", "door_main_keep_right_path_to_main_keep2" );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xe7418838, Offset: 0x4687
// Size: 0x10d
function castle_reinforce()
{
    level endon( #"completed_pap_step_3" );
    level utility::flag_wait( "open_gate" );
    var_8fdba9824de3ec3 = utility::getstruct( "castle_spawn" );
    var_6761390ea63cd7c0 = get_zombie_number();
    zombie_type = function_b3988325430ce242( "zombie_base_armored_light" );
    wait 0.5;
    musicbank_utility::function_5aca66c390aa347d( level.players, #"pap_castle_entrance" );
    
    for ( i = 0; i < var_6761390ea63cd7c0 ; i++ )
    {
        var_408e0c7d8bfc99ad = utility::function_7afe366c29a77c34( var_8fdba9824de3ec3.origin, var_8fdba9824de3ec3.radius );
        
        if ( ispointonnavmesh( var_408e0c7d8bfc99ad ) )
        {
            var_ea616919227739f = agent_manager::spawn_agent( zombie_type, var_408e0c7d8bfc99ad, var_8fdba9824de3ec3.angles, "team_two_hundred" );
            
            if ( isdefined( var_ea616919227739f ) )
            {
                var_ea616919227739f zombie_utils::function_a8ce00e0448cb6f0( "sprint", "pap_quest", 99 );
                var_ea616919227739f.ignore_enemy_count = 1;
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xf106afdd, Offset: 0x479c
// Size: 0xbb
function zombie_spawn_animation( s_spawn )
{
    s_spawn.var_28fcd668037aa633 = 1;
    
    if ( !isdefined( s_spawn.script_animation ) )
    {
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            s_spawn.script_animation = "spawn_hop";
        }
        else
        {
            s_spawn.script_animation = "spawn";
        }
    }
    
    scr_spawn = spawnscriptable( "zm_sat_hornet_pap_fx", s_spawn.origin, s_spawn.angles );
    scr_spawn setscriptablepartstate( "visual", "zombie_guard" );
    zone_spawner::function_ce10e453e7f7bb8e( s_spawn );
    scr_spawn freescriptable();
    s_spawn.var_28fcd668037aa633 = undefined;
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x7a457e1b, Offset: 0x485f
// Size: 0x76
function pap_room_locate()
{
    level endon( #"completed_pap_step_3" );
    t_oni = getent( "trigger_oni", "targetname" );
    
    while ( true )
    {
        t_oni waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && !isdefined( level.pap_locator ) )
        {
            level.pap_locator = ent;
            level thread oni_spawn();
            break;
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xfe3a463, Offset: 0x48dd
// Size: 0x153
function setup_pap_door()
{
    var_eb315dd4406db9f6 = utility::getstruct( "pap_entrance" );
    s_hanko = utility::getstruct( var_eb315dd4406db9f6.target );
    
    if ( !game_utility::function_21211f3255f8ea58() )
    {
        interact = interaction::register_interact( var_eb315dd4406db9f6.origin + ( 0, 0, -8 ), 40, &function_af7a9ed54b5aefea, undefined, undefined, undefined, 1 );
        interact interaction::set_interact_hint_callback( &pap_door_hint );
    }
    
    level.hornet_pap_quest.mdl_hanko = utility::spawn_model( %"hash_7c342f3ff488787c", s_hanko.origin, s_hanko.angles );
    level.hornet_pap_quest.mdl_hanko hide();
    v_pos = s_hanko.origin + ( 0, 0, -0.1 );
    level.hornet_pap_quest.sc_pap_door = spawnscriptable( %"zm_sat_hornet_pap_door", v_pos, s_hanko.angles + ( -90, -70, -70 ) );
    level.hornet_pap_quest.sc_pap_door setscriptablepartstate( "pap_door", "visible" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x98ebb995, Offset: 0x4a38
// Size: 0x243
function function_af7a9ed54b5aefea( player )
{
    if ( player.interactions_disabled || self.b_interacted || !level utility::flag( "hanko_acquired" ) )
    {
        return;
    }
    
    self.b_interacted = 1;
    var_eb315dd4406db9f6 = utility::getstruct( "pap_entrance" );
    
    if ( isdefined( level.hornet_pap_quest.mdl_hanko ) )
    {
        level.hornet_pap_quest.mdl_hanko show();
        playsoundatpos( level.hornet_pap_quest.mdl_hanko.origin, #"hash_9f8a9e7f37396e60" );
        wait 1;
        level.hornet_pap_quest.var_46c9e08b3794e3fb = spawnscriptable( %"zm_sat_hornet_pap_door", var_eb315dd4406db9f6.origin, var_eb315dd4406db9f6.angles );
        level.hornet_pap_quest.var_46c9e08b3794e3fb setscriptablepartstate( "pap_door", "light" );
    }
    
    if ( isdefined( level.hornet_pap_quest.sc_pap_door ) )
    {
        level.hornet_pap_quest.sc_pap_door setscriptablepartstate( "pap_door", "hidden" );
    }
    
    wait 1.5;
    
    if ( isdefined( level.hornet_pap_quest.mdl_hanko ) )
    {
        level.hornet_pap_quest.mdl_hanko hide();
        sc_hanko = spawnscriptable( %"zm_sat_hornet_pap_hanko", level.hornet_pap_quest.mdl_hanko.origin, level.hornet_pap_quest.mdl_hanko.angles + ( -90, -70, -70 ) );
        sc_hanko setscriptablepartstate( "visual", "despawn" );
        wait 1.5;
    }
    
    if ( isdefined( level.hornet_pap_quest.sc_pap_door ) )
    {
        level.hornet_pap_quest.sc_pap_door setscriptablepartstate( "pap_door", "open" );
    }
    
    wait 0.5;
    level thread function_2e9e080237fd2e86();
    open_pap_door();
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x3b7dfe58, Offset: 0x4c83
// Size: 0xd7
function pap_door_hint( interact, player )
{
    if ( player.interactions_disabled || interact.b_interacted || level utility::flag( "completed_pap_step_6" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    else if ( level utility::flag( "hanko_acquired" ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_56551262e0b49467", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_4a03016a21abfb94", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xebc35f3f, Offset: 0x4d63
// Size: 0x206
function open_pap_door()
{
    if ( isdefined( level.hornet_pap_quest.mdl_hanko ) )
    {
        level.hornet_pap_quest.mdl_hanko hide();
    }
    
    var_b0f5ca579d03b5c = getentarray( "zombie_door", "targetname" );
    
    foreach ( door in var_b0f5ca579d03b5c )
    {
        if ( door.script_flag_set === "door_main_keep_to_top" )
        {
            foreach ( door in door.doors )
            {
                door thread doorbuy::function_f3160e450543b4f1();
            }
            
            level utility::flag_set( "pap_open" );
            level utility::flag_set( "completed_pap_step_6" );
            function_ecc91637c2a6fbb1();
        }
    }
    
    if ( !isdefined( level.vo_pap_room ) )
    {
        level.vo_pap_room = 1;
        level thread vo_pap_room();
    }
    
    if ( isdefined( level.hornet_pap_quest.var_46c9e08b3794e3fb ) )
    {
        level.hornet_pap_quest.var_46c9e08b3794e3fb freescriptable();
    }
    
    if ( isdefined( level.hornet_pap_quest.var_46c9e08b3794e3fb ) )
    {
        level.hornet_pap_quest.var_46c9e08b3794e3fb freescriptable();
    }
    
    if ( isdefined( level.hornet_pap_quest.sc_pap_door ) )
    {
        level.hornet_pap_quest.sc_pap_door freescriptable();
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xcb2c9998, Offset: 0x4f71
// Size: 0x6c
function get_zombie_number()
{
    switch ( level.players.size )
    {
        case 1:
            var_13499fc5a3a2f18c = 5;
            break;
        case 2:
            var_13499fc5a3a2f18c = 7;
            break;
        case 3:
            var_13499fc5a3a2f18c = 10;
            break;
        default:
            var_13499fc5a3a2f18c = 13;
            break;
    }
    
    return var_13499fc5a3a2f18c;
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x13f8bd5a, Offset: 0x4fe6
// Size: 0x6c
function get_seed_total()
{
    switch ( level.players.size )
    {
        case 1:
            var_13499fc5a3a2f18c = 10;
            break;
        case 2:
            var_13499fc5a3a2f18c = 12;
            break;
        case 3:
            var_13499fc5a3a2f18c = 14;
            break;
        default:
            var_13499fc5a3a2f18c = 16;
            break;
    }
    
    return var_13499fc5a3a2f18c;
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x53c394b6, Offset: 0x505b
// Size: 0x49
function function_5471a0765d81e71f()
{
    self waittill( #"death" );
    
    if ( level.var_fd95cdf8682b52bc )
    {
        level.var_fd95cdf8682b52bc--;
    }
    
    if ( isdefined( self.is_banner_attacker ) && level.var_dd3790fa6c31accc )
    {
        level.var_dd3790fa6c31accc--;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x217202a9, Offset: 0x50ac
// Size: 0x3b7
function oni_spawn()
{
    if ( zm_quest::function_73720cdf21c3cfd7( #"hornet_pap_quest", #"hanko_acquired" ) )
    {
        return;
    }
    
    s_trail = utility::getstruct( "oni_trail_w" );
    var_ed100f9a07836d02 = utility::getstruct( "pap_special" );
    
    if ( isdefined( level.pap_locator ) )
    {
        if ( level.pap_locator.origin[ 0 ] >= var_ed100f9a07836d02.origin[ 0 ] )
        {
            s_trail = utility::getstruct( "oni_trail_s" );
        }
    }
    
    e_mover = utility::spawn_model( "tag_origin", s_trail.origin, s_trail.angles );
    e_mover.sc_oni = spawnscriptable( %"zm_sat_hornet_pap_fx", e_mover.origin, e_mover.angles );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"pap_oni_fight" );
    waitframe();
    
    if ( isdefined( e_mover ) && isdefined( e_mover.sc_oni ) )
    {
        e_mover.sc_oni utility::scriptable_setparententity( e_mover );
        e_mover.sc_oni utility::function_32b24db3127bff40( "visual", "oni_spawn" );
        waitframe();
        e_mover.sc_oni utility::function_32b24db3127bff40( "visual", "oni_trail" );
        path = [ s_trail.origin ];
        
        for ( node = s_trail; isdefined( node.target ) ; node = var_c27efcf4d873bd51 )
        {
            var_c27efcf4d873bd51 = utility::getstruct( node.target );
            path[ path.size ] = var_c27efcf4d873bd51.origin;
        }
        
        e_mover thread utility::function_2159dd4196ff4b81( path, 4, 1, 0, 0, 0.8, 0.5, 0 );
        e_mover waittill( #"stop_curve" );
        e_mover.sc_oni setscriptablepartstate( "impact", "collect" );
    }
    
    a_players = getplayersinradius( var_ed100f9a07836d02.origin, 1000 );
    
    if ( a_players.size )
    {
        for ( i = 0; i < a_players.size ; i++ )
        {
            if ( isdefined( a_players[ i ] ) )
            {
                player = a_players[ i ];
                break;
            }
        }
    }
    
    if ( isdefined( player ) )
    {
        v_face = vectortoangles( player.origin - var_ed100f9a07836d02.origin );
    }
    else
    {
        v_face = var_ed100f9a07836d02.angles;
    }
    
    level.ai_oni = agent_manager::spawn_agent( "zombie_orion", var_ed100f9a07836d02.origin, v_face, "team_two_hundred" );
    
    if ( isdefined( level.ai_oni ) )
    {
        n_round = zm_utility::get_round_number();
        
        if ( n_round < 12 )
        {
            n_round = 12;
        }
        
        level.ai_oni zombie_utils::set_zombie_round_difficulty( n_round );
        level.ai_oni thread oni_death_watcher();
        level.ai_oni thread oni_values();
        
        if ( isdefined( player ) )
        {
            level thread function_7d21ff99616b2601( "oni_spawn", 3.5, undefined, player );
        }
    }
    else
    {
        level utility::flag_set( "pap_special_dead" );
        level utility::flag_set( "completed_pap_step_4" );
        spawn_item_hanko( var_ed100f9a07836d02.origin );
    }
    
    wait 1;
    level utility::flag_set( "pap_door_found" );
    level utility::flag_set( "completed_pap_step_3" );
    function_ecc91637c2a6fbb1();
    
    if ( isdefined( e_mover.sc_oni ) )
    {
        e_mover.sc_oni freescriptable();
    }
    
    e_mover delete();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x440daf81, Offset: 0x546b
// Size: 0x58
function oni_skipto()
{
    wait 5;
    
    if ( isdefined( level.ai_oni ) )
    {
        level.ai_oni kill();
    }
    
    if ( !zm_quest::function_73720cdf21c3cfd7( #"hornet_pap_quest", #"hanko_acquired" ) )
    {
        spawn_item_hanko( utility::getstruct( "pap_special" ).origin );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x420dd6e, Offset: 0x54cb
// Size: 0x7a
function oni_values()
{
    self endon( #"death" );
    val::set( "pap_oni", "ignore_cleanup", 1 );
    val::set( "pap_oni", "ammomod_immune", 0 );
    val::set( "pap_oni", "ignore_blackhole_bomb", 1 );
    val::set( "pap_oni", "shadow_rift_lethal_tele_immune", 1 );
    self.var_190f8e8daa83f8c = 1;
    self.var_7ee152b43c7188e1 = 1;
    self.ignore_enemy_count = 1;
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x420d98e6, Offset: 0x554d
// Size: 0xd7
function oni_death_watcher()
{
    if ( level utility::flag( "pap_special_dead" ) || level utility::flag( "hanko_acquired" ) )
    {
        return;
    }
    
    self waittill( #"death" );
    level utility::flag_set( "pap_special_dead" );
    level utility::flag_set( "completed_pap_step_4" );
    musicbank_utility::function_4f253fd35ec68cbc( level.players, #"pap_oni_fight" );
    function_ecc91637c2a6fbb1();
    v_pos = self.origin;
    hanko_zone = zone_manager::function_90e5c3e2272b0130( utility::getstruct( "pap_name" ).origin );
    
    if ( hanko_zone.zone_name == "zone_main_keep_top" )
    {
        v_pos = utility::getstruct( "pap_special" ).origin;
    }
    
    spawn_item_hanko( v_pos );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xb908ce72, Offset: 0x562c
// Size: 0xf0
function spawn_item_hanko( v_pos )
{
    itembundle = getscriptbundle( %"hash_4a63a65301074e30" );
    spawnoptions = common_item::function_bc5ff2958b71a708( v_pos );
    spawnoptions.critical = 1;
    spawnoptions.var_fd47e835523b473f = 1;
    positioningdata = common_item::function_b4bee4333994e45a( v_pos, ( 0, 0, 0 ) );
    level.hornet_pap_quest.hanko = common_item::function_2352d25db9e97696( itembundle, 1, positioningdata, spawnoptions );
    level.hornet_pap_quest.hanko setscriptablepartstate( "zmloot_quest_hornet_pap_hanko", "visible" );
    playsoundatpos( level.hornet_pap_quest.hanko.origin, "uin_zm_common_drop_item_key" );
    level utility::flag_set( "hanko_dropped" );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x8c22913b, Offset: 0x5724
// Size: 0x61
function pap_quest_item_used( params )
{
    itembundle = params.bundle;
    player = params.player;
    
    switch ( itembundle.ref )
    {
        case #"hash_2031afad21bebf07":
            function_3b953d79b7c0128e( player );
            return;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x6831ee92, Offset: 0x578d
// Size: 0xd0
function function_3b953d79b7c0128e( player )
{
    level.has_hanko = 1;
    zm_quest::function_4eefe6de31f5ddab( #"hornet_pap_quest", #"hanko_acquired", 1 );
    player playsoundtoplayer( "uin_zm_common_pickup_item_important", player );
    level thread function_7d21ff99616b2601( "hanko_acquired", 0.25, "positive", player );
    curr_phase_index = zm_quest::function_23669314446ef229( #"mq" );
    level zm_quest::function_b57dfe9625966b0b( #"mq", curr_phase_index, #"ev_mot", 3 );
    zm_quest::show_splash_item_picked_up( #"mq", #"ev_mot", 3, player );
    level utility::flag_set( "hanko_acquired" );
    level utility::flag_set( "completed_pap_step_5" );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x382ea66e, Offset: 0x5865
// Size: 0xfe
function setup_seed()
{
    level utility::flag_wait( "begin_round_logic" );
    s_seed = utility::getstruct( "seed" );
    var_7c06ccff26c8744e = utility::getstruct( "pedestal" );
    level.hornet_pap_quest.sc_seed = utility::spawn_model( %"hash_6c35cf67bff31b67", s_seed.origin, s_seed.angles );
    level.hornet_pap_quest.sc_pedestal = spawnscriptable( %"zm_sat_hornet_pap_pedestal", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
    level.hornet_pap_quest.sc_pedestal utility::function_7c10ea82c1e305b8( "visual", "pedestal" );
    level.hornet_pap_quest.var_b6e35db4ba0d7614 = 0;
    level.hornet_pap_quest.var_deb0d2ca018bfed8 = get_seed_total();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x5d03f28f, Offset: 0x596b
// Size: 0x1c1
function function_f6953edf42d8c16d()
{
    var_a65a556e144e8c0b = [];
    s_pap_room = utility::getstruct( "pap_room" );
    level.hornet_pap_quest.zone = zone_manager::function_90e5c3e2272b0130( s_pap_room.origin );
    adj_zones = level.hornet_pap_quest.zone zone_manager::get_adjacent_zones( 1, 1 );
    pap_zones = arraycombine( adj_zones, [ level.hornet_pap_quest.zone ] );
    var_79c84a925c286118 = namespace_c7157c2cd884c5d5::function_e05919b47b9a0cda( "normal" );
    
    foreach ( zone in pap_zones )
    {
        foreach ( zombie_type_normal in var_79c84a925c286118 )
        {
            if ( zombie_type_normal == "zombie_base" || zombie_type_normal == "zombie_base_armored_heavy" || zombie_type_normal == "zombie_base_armored_light" )
            {
                var_a65a556e144e8c0b[ var_a65a556e144e8c0b.size ] = zone_spawner::function_20c574a6ba7cc5c6( zone.script_zone_name, zombie_type_normal );
            }
        }
    }
    
    level thread spawn_zone_zombies( var_a65a556e144e8c0b );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x307d0407, Offset: 0x5b34
// Size: 0xa6
function spawn_zone_zombies( var_a65a556e144e8c0b )
{
    level endon( #"completed_pap_step_7" );
    level.var_fd95cdf8682b52bc = 0;
    var_ab4c49769a763880 = get_zombie_number();
    
    while ( true )
    {
        if ( level.var_fd95cdf8682b52bc < var_ab4c49769a763880 && zone_manager::get_zone_occupants( level.hornet_pap_quest.zone.zone_name ).size )
        {
            var_703b33e652831823 = utility::array_random( var_a65a556e144e8c0b );
            s_spawn_loc = utility::array_random( var_703b33e652831823 );
            zombie_spawn( s_spawn_loc );
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x96846074, Offset: 0x5be2
// Size: 0xd8
function zombie_spawn( s_spawner )
{
    zombie_base_types = [ "zombie_base", "zombie_base_armored_light", "zombie_base_armored_heavy" ];
    zombie_type = function_b3988325430ce242( utility::array_random( zombie_base_types ) );
    var_ea616919227739f = agent_manager::spawn_agent( zombie_type, s_spawner.origin, s_spawner.angles, "team_two_hundred" );
    
    if ( isdefined( var_ea616919227739f ) )
    {
        var_ea616919227739f thread zone_spawner::function_ce10e453e7f7bb8e( s_spawner );
        var_ea616919227739f thread function_5471a0765d81e71f();
        var_ea616919227739f zm_utility::setup_quest_ai();
        var_ea616919227739f.is_quest_zombie = 1;
        
        if ( level.var_dd3790fa6c31accc < 5 && utility::cointoss() )
        {
            var_ea616919227739f.is_banner_attacker = 1;
        }
        
        level.var_fd95cdf8682b52bc++;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xce32e3a3, Offset: 0x5cc2
// Size: 0x1a2
function function_6580683b94f4667e()
{
    level endon( #"completed_pap_step_7" );
    s_pap_room = utility::getstruct( "pap_room" );
    zone = zone_manager::function_90e5c3e2272b0130( s_pap_room.origin );
    zone_name = zone.script_zone_name;
    level thread pap_room_restore( zone_name );
    
    while ( true )
    {
        var_974630840c9f7dd1 = zone_manager::get_zone_occupants( zone_name );
        
        if ( var_974630840c9f7dd1.size )
        {
            level utility::flag_set( "pap_active" );
            zone_spawner::function_2ce7db1d59b307d8( zone_name );
            
            foreach ( player in var_974630840c9f7dd1 )
            {
                player val::set( "pap_charge", "round_spawning_ignore_player", 1 );
            }
        }
        else
        {
            level utility::flag_clear( "pap_active" );
            zone_spawner::function_8a020f24a3b73c79( zone_name );
            
            foreach ( player in var_974630840c9f7dd1 )
            {
                player val::reset( "pap_charge", "round_spawning_ignore_player" );
            }
        }
        
        wait 0.5;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x97451353, Offset: 0x5e6c
// Size: 0xa9
function pap_room_restore( zone_name )
{
    level utility::flag_wait( "power_on" );
    wait 1;
    zone_spawner::function_8a020f24a3b73c79( zone_name );
    
    foreach ( player in level.players )
    {
        player val::set( "pap_charge", "round_spawning_ignore_player", 0 );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xcdf22e20, Offset: 0x5f1d
// Size: 0x11b
function on_pap_zombie_killed( sparams )
{
    if ( !level utility::flag( "completed_pap_step_6" ) )
    {
        return;
    }
    
    zone = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( zone != level.hornet_pap_quest.zone )
    {
        return;
    }
    
    if ( isplayer( sparams.eattacker ) && !level utility::flag( "completed_pap_step_7" ) )
    {
        var_92b21ca8efb6aef2 = distance2dsquared( level.hornet_pap_quest.sc_seed.origin, self.origin );
        
        if ( var_92b21ca8efb6aef2 <= 62500 && !isdefined( level.hornet_pap_quest.b_completed ) && isdefined( self.var_9f170546e7280cf8 ) )
        {
            level.hornet_pap_quest thread function_d6acf515bc79fadf( var_92b21ca8efb6aef2, self getcentroid(), level.hornet_pap_quest.sc_seed.origin + ( 0, 0, 10 ) );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xd784e684, Offset: 0x6040
// Size: 0x11b
function function_2e9e080237fd2e86()
{
    s_pap_room = utility::getstruct( "pap_room" );
    var_a77bb00f025e9731 = [];
    var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( s_pap_room.origin );
    zone_name = var_8c4fe62d01999d1e.script_zone_name;
    var_a77bb00f025e9731[ var_a77bb00f025e9731.size ] = zone_name;
    adj_zones = var_8c4fe62d01999d1e zone_manager::get_adjacent_zones( 1, 1 );
    
    foreach ( zone in adj_zones )
    {
        var_a77bb00f025e9731[ var_a77bb00f025e9731.size ] = zone.script_zone_name;
    }
    
    level thread zm_music::start_zone_music_watcher( "seed_charge", var_a77bb00f025e9731, #"pap_seed_charge" );
    level utility::flag_wait( "seed_charged" );
    level thread zm_music::function_e9fd14ede793ef0d( "seed_charge" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 3
// Checksum 0xb87f76ff, Offset: 0x6163
// Size: 0x330
function function_d6acf515bc79fadf( var_92b21ca8efb6aef2, v_org, v_dest )
{
    n_time = var_92b21ca8efb6aef2 / 90000;
    var_7eeca3426600cbba = utility::spawn_model( "tag_origin", v_org );
    var_7eeca3426600cbba.sc_fx = spawnscriptable( %"zm_sat_hornet_pap_fx", var_7eeca3426600cbba.origin );
    waitframe();
    var_7eeca3426600cbba.sc_fx utility::scriptable_setparententity( var_7eeca3426600cbba );
    var_7eeca3426600cbba.sc_fx setscriptablepartstate( "visual", "energy_trail" );
    var_7eeca3426600cbba moveto( v_dest, n_time );
    var_7eeca3426600cbba waittill( #"movedone" );
    var_7eeca3426600cbba.sc_fx setscriptablepartstate( "impact", "collect" );
    
    if ( self.var_b6e35db4ba0d7614 < level.hornet_pap_quest.var_deb0d2ca018bfed8 )
    {
        self.var_b6e35db4ba0d7614++;
        
        if ( self.var_b6e35db4ba0d7614 > 2 && !isdefined( level.vo_seed_charge ) )
        {
            level.vo_seed_charge = 1;
            level thread vo_seed_charge();
        }
        
        if ( !isdefined( level.hornet_pap_quest.sc_seed.var_214bc6cea3285fe4 ) )
        {
            level.hornet_pap_quest.sc_seed.var_214bc6cea3285fe4 = 1;
            level.hornet_pap_quest.sc_seed_ambient = spawnscriptable( %"zm_sat_hornet_pap_fx", level.hornet_pap_quest.sc_seed.origin + ( 0, 0, 10 ) );
            level.hornet_pap_quest.sc_seed_ambient utility::function_32b24db3127bff40( "visual", "seed_ambient" );
        }
        
        if ( self.var_b6e35db4ba0d7614 >= level.hornet_pap_quest.var_deb0d2ca018bfed8 )
        {
            self notify( #"collected" );
            
            if ( !isdefined( self.b_completed ) )
            {
                self.b_completed = 1;
                level utility::flag_set( "seed_charged" );
                sc_beam = spawnscriptable( %"zm_sat_hornet_pap_fx", level.hornet_pap_quest.sc_seed.origin + ( 0, 0, 10 ) );
                sc_beam utility::function_32b24db3127bff40( "visual", "attuned" );
                earthquakeadvanced( 0.4, 0.3, 0.2, 1.5, level.hornet_pap_quest.sc_seed.origin, 400, 600, 800 );
                level thread impact_rumble( level.hornet_pap_quest.sc_seed.origin, 400, "ground_pound_land" );
                sc_beam clear_zombies( 800 );
                sc_beam freescriptable();
                wait 1;
                level thread pap_power_transfer();
            }
        }
    }
    
    wait 0.5;
    var_7eeca3426600cbba.sc_fx freescriptable();
    var_7eeca3426600cbba delete();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xd419f0bd, Offset: 0x649b
// Size: 0x35a
function pap_power_transfer()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "pap_setup" );
    s_receptor = utility::getstruct( "pap_receptor" );
    
    if ( isdefined( level.hornet_pap_quest.sc_seed ) )
    {
        var_7cb33e012c8dcdaf = utility::spawn_model( "tag_origin", level.hornet_pap_quest.sc_seed.origin + ( 0, 0, 10 ) );
        var_7cb33e012c8dcdaf.sc_beam = spawnscriptable( %"zm_sat_hornet_pap_fx", level.hornet_pap_quest.sc_seed.origin + ( 0, 0, 10 ) );
        var_7cb33e012c8dcdaf.sc_beam utility::function_32b24db3127bff40( "visual", "attuned" );
        wait 2;
        var_7cb33e012c8dcdaf.e_receptor = utility::spawn_model( "tag_origin", var_7cb33e012c8dcdaf.origin );
        var_7cb33e012c8dcdaf.sc_beam utility::scriptable_setparententity( var_7cb33e012c8dcdaf.e_receptor );
        var_7cb33e012c8dcdaf.e_beam = playfxontagsbetweenclients( level._effect[ "beam_power" ], var_7cb33e012c8dcdaf, "tag_origin", var_7cb33e012c8dcdaf.e_receptor, "tag_origin" );
        var_7cb33e012c8dcdaf.e_receptor moveto( s_receptor.origin, 0.25 );
        wait 0.15;
        level.hornet_pap_ghost utility::function_7c10ea82c1e305b8( "fx", "start" );
        var_7cb33e012c8dcdaf.e_receptor waittill( #"movedone" );
        var_7cb33e012c8dcdaf.sc_beam setscriptablepartstate( "impact", "beam_end" );
        level thread power_beam_damage_watcher();
    }
    
    level utility::flag_set( "completed_pap_step_7" );
    zm_round_spawning::pause_round_spawning( 1, "pap_power" );
    wait 4;
    wait 1;
    level val::set( "power_on", "task_logic_activate", 1 );
    
    if ( isdefined( level.hornet_pap_quest.sc_seed ) )
    {
        if ( isdefined( var_7cb33e012c8dcdaf.sc_beam ) )
        {
            var_7cb33e012c8dcdaf.sc_beam setscriptablepartstate( "visual", "power" );
        }
        
        earthquakeadvanced( 0.6, 0.3, 0.1, 1.5, level.hornet_pap_quest.sc_seed.origin, 800, 1000, 2000 );
        level thread impact_rumble( level.hornet_pap_quest.sc_seed.origin, 4000, "ground_pound_land" );
    }
    
    level thread pap_machine_show();
    level thread function_5dce91c80cb35a89();
    wait 0.5;
    level thread pap_power_blast();
    level thread pap_shockwave();
    level thread player_power_blast();
    function_a0565bbc8222f23f( var_7cb33e012c8dcdaf.sc_beam );
    function_a0565bbc8222f23f( var_7cb33e012c8dcdaf.e_beam );
    function_a0565bbc8222f23f( var_7cb33e012c8dcdaf );
    level utility::flag_set( "power_on" );
    open_power_doors();
    level thread activate_ash();
    level utility::flag_set( "completed_pap_step_8" );
    wait 1;
    level thread vo_power_destruction();
    wait 7;
    zm_round_spawning::pause_round_spawning( 0, "pap_power" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x2d924397, Offset: 0x67fd
// Size: 0xb0
function pap_power_blast()
{
    s_seed = utility::getstruct( "seed" );
    sc_blast = spawnscriptable( %"zm_sat_hornet_pap_fx", s_seed.origin + ( 0, 0, 10 ) );
    sc_blast setscriptablepartstate( "visual", "power_blast" );
    earthquakeadvanced( 0.4, 0.3, 0.2, 8.5, s_seed.origin, 2000, 8000, 9000 );
    playsoundatpos( s_seed.origin, #"hash_1b08210f2a7324db" );
    wait 5;
    
    if ( isdefined( sc_blast ) )
    {
        sc_blast freescriptable();
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x9939dc14, Offset: 0x68b5
// Size: 0x2f
function function_ba1efa50482a165a()
{
    self endon( #"death" );
    self playrumblelooponentity( "ground_pound_land" );
    wait 8.5;
    
    if ( isdefined( self ) )
    {
        self stoprumble( "ground_pound_land" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x90b57708, Offset: 0x68ec
// Size: 0x19
function pap_shockwave()
{
    wait 2;
    activateworldevent( "we_vfx_world_seed_shockwave_ground_01" );
    activateworldevent( "we_vfx_world_seed_shockwave_ground_02" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x23c9dd9e, Offset: 0x690d
// Size: 0x16e
function player_power_blast()
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isdefined( level.hornet_pap_quest.sc_seed ) )
        {
            player thread function_ba1efa50482a165a();
            player utility::function_32b24db3127bff40( "hornet_pap_shockwave", "on" );
            
            if ( player function_5bf510005480ab04( level.hornet_pap_quest.sc_seed.origin, 0.7 ) )
            {
                player thread function_6943561c0d8f3b73( "t10_ges_streak_nuke_death", 3 );
            }
        }
    }
    
    wait 3;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player utility::function_32b24db3127bff40( "hornet_pap_shockwave", "off" );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xd731a865, Offset: 0x6a83
// Size: 0xcd
function power_beam_damage_watcher()
{
    level endon( #"power_on" );
    var_d0f190960d9971b4 = getent( "t_power_beam", "targetname" );
    var_d0f190960d9971b4 thread power_beam_kill_zombie();
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player istouching( var_d0f190960d9971b4 ) )
            {
                player dodamage( 5, var_d0f190960d9971b4.origin, var_d0f190960d9971b4 );
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xf14bfced, Offset: 0x6b58
// Size: 0x99
function power_beam_kill_zombie()
{
    level endon( #"power_on" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !isdefined( ent.b_beamed ) && isai( ent ) )
        {
            ent.b_beamed = 1;
            
            if ( issubstr( ent.subclass, "zombie_base" ) )
            {
                ent.forceannihilate = 1;
                ent kill( self.origin, self );
                continue;
            }
            
            thread function_8ab7e4b315d2faa8( ent );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xa38f9079, Offset: 0x6bf9
// Size: 0x68
function function_8ab7e4b315d2faa8( ent )
{
    level endon( #"power_on" );
    ent endon( #"death" );
    
    while ( true )
    {
        n_damage = int( ent.health * 0.5 );
        
        if ( n_damage )
        {
            ent dodamage( n_damage, self.origin, self );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x462ff32f, Offset: 0x6c69
// Size: 0xe6
function function_5dce91c80cb35a89()
{
    level.hornet_pap_quest.pap_throttle = throttle::throttle_initialize( "pap_kill" );
    var_d0bf10f61a87b364 = getaiarray( "team_two_hundred" );
    
    if ( isdefined( level.hornet_pap_quest.sc_seed ) )
    {
        var_d0bf10f61a87b364 = utility::get_array_of_closest( level.hornet_pap_quest.sc_seed.origin, var_d0bf10f61a87b364 );
        
        for ( i = 0; i < var_d0bf10f61a87b364.size ; i++ )
        {
            if ( isalive( var_d0bf10f61a87b364[ i ] ) && var_d0bf10f61a87b364[ i ].aicategory === "normal" )
            {
                throttle::throttle_wait_in_queue( level.hornet_pap_quest.pap_throttle, var_d0bf10f61a87b364[ i ] );
                var_d0bf10f61a87b364[ i ] thread zm_utility::function_5bbd540197e3fd( 100, 1.5, 2 );
            }
            
            waitframe();
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xccdd2048, Offset: 0x6d57
// Size: 0x77
function clear_zombies( n_radius )
{
    var_d0bf10f61a87b364 = getaiarrayinradius( self.origin, n_radius, "team_two_hundred" );
    
    for ( i = 0; i < var_d0bf10f61a87b364.size ; i++ )
    {
        if ( var_d0bf10f61a87b364[ i ].aicategory === "normal" )
        {
            var_d0bf10f61a87b364[ i ].forceannihilate = 1;
            var_d0bf10f61a87b364[ i ] kill();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x84635ea0, Offset: 0x6dd6
// Size: 0x18f
function open_power_doors()
{
    var_b0f5ca579d03b5c = getentarray( "zombie_door", "targetname" );
    
    foreach ( var_53a8fe4eba7753a3 in var_b0f5ca579d03b5c )
    {
        if ( var_53a8fe4eba7753a3.script_power === "power_on1" || var_53a8fe4eba7753a3.script_flag_set === "door_power_on" )
        {
            foreach ( door in var_53a8fe4eba7753a3.doors )
            {
                door doorbuy::function_f3160e450543b4f1();
            }
        }
    }
    
    level thread doorbuy::function_f036c23977df35fc( 1 );
    wait 0.9;
    level thread function_ded5f3db73098d7d( 40 );
    wait 0.3;
    level thread function_ded5f3db73098d7d( 2 );
    wait 0.1;
    level thread function_ded5f3db73098d7d( 41 );
    wait 0.5;
    level thread function_ded5f3db73098d7d( 3 );
    wait 0.1;
    level thread function_ded5f3db73098d7d( 1 );
    wait 0.3;
    level thread function_ded5f3db73098d7d( 5 );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x2f8459d6, Offset: 0x6f6d
// Size: 0x372
function function_ded5f3db73098d7d( n_index )
{
    var_ed100f9a07836d02 = utility::getstruct( "vfx_mayhem_collapse_" + n_index );
    
    switch ( n_index )
    {
        case 1:
            sc_mayhem = level.var_b30d42a5a5621ef8;
            sc_mayhem_end_a = level.var_28482b4ab6c94a7b;
            sc_mayhem_end_b = level.var_28482c4ab6c94cae;
            break;
        case 2:
            sc_mayhem = level.var_b30d45a5a5622591;
            sc_mayhem_end_a = level.var_28561b4ab6d96ed0;
            sc_mayhem_end_b = level.var_28561e4ab6d97569;
            break;
        case 3:
            sc_mayhem = level.var_b30d44a5a562235e;
            sc_mayhem_end_a = level.var_2851374ab6d3838d;
            sc_mayhem_end_b = level.var_2851344ab6d37cf4;
            break;
        case 40:
            sc_mayhem = level.var_285e584ab6e1e0a5;
            sc_mayhem_end_a = level.var_a95cf05032c14f0c;
            sc_mayhem_end_b = level.var_a95cf35032c155a5;
            break;
        case 41:
            sc_mayhem = level.var_285e574ab6e1de72;
            sc_mayhem_end_a = level.var_a9580c5032bb63c9;
            sc_mayhem_end_b = level.var_a958095032bb5d30;
            break;
        case 5:
            sc_mayhem = level.var_b30d46a5a56227c4;
            sc_mayhem_end_a = level.var_285a034ab6dd2fdf;
            sc_mayhem_end_b = level.var_285a044ab6dd3212;
            break;
    }
    
    if ( n_index == 40 )
    {
        str_mayhem = "mayhem_collapse_40";
        str_mayhem_end_a = "mayhem_end_a_40";
        str_mayhem_end_b = "mayhem_end_b_40";
    }
    else if ( n_index == 41 )
    {
        str_mayhem = "mayhem_collapse_41";
        str_mayhem_end_a = "mayhem_end_a_41";
        str_mayhem_end_b = "mayhem_end_b_41";
    }
    else
    {
        str_mayhem = "mayhem_collapse_" + n_index;
        str_mayhem_end_a = "mayhem_end_a_" + n_index;
        str_mayhem_end_b = "mayhem_end_b_" + n_index;
    }
    
    if ( isdefined( var_ed100f9a07836d02 ) )
    {
        sc_fx = spawnscriptable( %"zm_sat_hornet_door_fx", var_ed100f9a07836d02.origin, var_ed100f9a07836d02.angles );
        sc_fx utility::function_32b24db3127bff40( "visual", "collapse_" + n_index );
        sc_mayhem utility::function_32b24db3127bff40( str_mayhem, "collapse" );
        wait 0.6;
        sc_mayhem utility::function_32b24db3127bff40( str_mayhem, "remove" );
        var_c04b677b65b9cfc3 = 1;
        
        while ( var_c04b677b65b9cfc3 )
        {
            foreach ( player in level.players )
            {
                if ( distance2dsquared( var_ed100f9a07836d02.origin, player.origin ) > 1000000 )
                {
                    var_c04b677b65b9cfc3 = 0;
                }
            }
            
            wait 1;
        }
        
        waitframe();
        sc_mayhem_end_a utility::function_32b24db3127bff40( str_mayhem_end_a, "show" );
        sc_mayhem_end_b utility::function_32b24db3127bff40( str_mayhem_end_b, "show" );
        waitframe();
        sc_mayhem_end_a utility::function_32b24db3127bff40( str_mayhem_end_a, "collapse" );
        sc_mayhem_end_b utility::function_32b24db3127bff40( str_mayhem_end_b, "collapse" );
        waitframe();
        sc_mayhem_end_a utility::function_32b24db3127bff40( str_mayhem_end_a, "hide" );
        sc_mayhem_end_b utility::function_32b24db3127bff40( str_mayhem_end_b, "hide" );
        waitframe();
        sc_mayhem_end_a utility::function_32b24db3127bff40( str_mayhem_end_a, "remove" );
        sc_mayhem_end_b utility::function_32b24db3127bff40( str_mayhem_end_b, "remove" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xd1d4e2eb, Offset: 0x72e7
// Size: 0x9c
function hide_mayhem()
{
    str_mayhem_end_a = "mayhem_end_a_4a";
    str_mayhem_end_b = "mayhem_end_b_4a";
    hidemayhem( str_mayhem_end_a );
    hidemayhem( str_mayhem_end_b );
    str_mayhem_end_a = "mayhem_end_a_4b";
    str_mayhem_end_b = "mayhem_end_b_4b";
    hidemayhem( str_mayhem_end_a );
    hidemayhem( str_mayhem_end_b );
    
    for ( i = 1; i < 4 ; i++ )
    {
        str_mayhem_end_a = "mayhem_end_a_" + i;
        str_mayhem_end_b = "mayhem_end_b_" + i;
        hidemayhem( str_mayhem_end_a );
        hidemayhem( str_mayhem_end_b );
    }
    
    hidemayhem( "mayhem_end_a_5" );
    hidemayhem( "mayhem_end_b_5" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x6f292814, Offset: 0x738b
// Size: 0x40
function function_97be7f92252977f9( sparams )
{
    self endon( #"death" );
    
    if ( !level utility::flag( "completed_pap_step_6" ) || level utility::flag( "completed_pap_step_7" ) )
    {
        return;
    }
    
    thread function_6ec6da0ce67c0ed9();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x66ae6b32, Offset: 0x73d3
// Size: 0xee
function function_6ec6da0ce67c0ed9()
{
    self endon( #"death" );
    s_seed = utility::getstruct( "seed" );
    
    while ( true )
    {
        self.var_9f170546e7280cf8 = 0;
        var_92b21ca8efb6aef2 = distance2dsquared( s_seed.origin, self.origin );
        
        if ( var_92b21ca8efb6aef2 <= 62500 && !isdefined( level.hornet_pap_quest.b_completed ) && zone_manager::function_90e5c3e2272b0130( self.origin ) == level.hornet_pap_quest.zone )
        {
            self.var_9f170546e7280cf8 = 1;
        }
        
        if ( self.var_9f170546e7280cf8 && !level utility::flag( "completed_pap_step_7" ) )
        {
            zombie_in_range( 1 );
        }
        else
        {
            self.var_9f170546e7280cf8 = undefined;
            zombie_in_range( 0 );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x9ebf279e, Offset: 0x74c9
// Size: 0x6b
function katana_attach()
{
    v_org = self gettagorigin( "j_mid_ri_1" );
    v_ang = self gettagangles( "j_mid_ri_1" );
    knife = utility::spawn_model( "execution_p47_me_sword01_v0", v_org, v_ang );
    knife linkto( self, "j_mid_ri_1", ( 0, 1, 0 ), ( 180, 180, 180 ) );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x398091b3, Offset: 0x753c
// Size: 0x9e
function function_883b24fb102f2d60()
{
    var_d0bf10f61a87b364 = getaiarray( "team_two_hundred" );
    
    foreach ( var_ea616919227739f in var_d0bf10f61a87b364 )
    {
        if ( issubstr( var_ea616919227739f.subclass, "zombie_base" ) )
        {
            var_ea616919227739f thread function_6ec6da0ce67c0ed9();
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xc9c16de0, Offset: 0x75e2
// Size: 0xb0
function private zombie_in_range( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        if ( issubstr( self.subclass, "zombie_base" ) )
        {
            if ( !namespace_b76ff2659823e89d::is_head_dismembered() && self.is_quest_zombie )
            {
                utility::function_32b24db3127bff40( "base", "base_purple_eyes" );
            }
            
            utility::function_32b24db3127bff40( "hornet_pap_charge", "vfx_on" );
        }
        
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_base" ) )
    {
        if ( !namespace_b76ff2659823e89d::is_head_dismembered() && self.is_quest_zombie )
        {
            utility::function_32b24db3127bff40( "base", "base_on" );
        }
        
        utility::function_32b24db3127bff40( "hornet_pap_charge", "vfx_off" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x46cde719, Offset: 0x769a
// Size: 0x50
function activate_ash()
{
    level endon( #"game_ended" );
    n_round = zm_utility::get_round_number();
    
    while ( true )
    {
        wait randomfloatrange( 10, 15 );
        
        if ( zm_utility::get_round_number() > n_round + 2 )
        {
            break;
        }
    }
    
    level utility::flag_clear( "pause_ambient_ash" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xcd25d87a, Offset: 0x76f2
// Size: 0x28c
function function_668b3128737b8247()
{
    level utility::flag_wait( "power_on" );
    s_start = utility::getstruct( "k_start" );
    sc_onryo = spawnscriptable( %"zm_sat_hornet_pap_fx", s_start.origin, s_start.angles );
    sc_onryo utility::function_32b24db3127bff40( "visual", "katana_spawn" );
    wait 1;
    sc_onryo utility::function_32b24db3127bff40( "visual", "katana_trail_kill" );
    sc_onryo.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", sc_onryo.origin, sc_onryo.angles );
    sc_onryo utility::scriptable_setparententity( sc_onryo.var_2b0c20cebe23ba0b );
    path = [ s_start.origin ];
    
    for ( node = s_start; isdefined( node.target ) ; node = var_c27efcf4d873bd51 )
    {
        var_c27efcf4d873bd51 = utility::getstruct( node.target );
        path[ path.size ] = var_c27efcf4d873bd51.origin;
    }
    
    sc_onryo.var_2b0c20cebe23ba0b thread utility::function_2159dd4196ff4b81( path, 10, 1 );
    sc_onryo.var_2b0c20cebe23ba0b thread function_e6a06431eb7d8dea();
    sc_onryo.var_2b0c20cebe23ba0b waittill( #"stop_curve" );
    sc_onryo utility::function_32b24db3127bff40( "visual", "hidden" );
    var_7c06ccff26c8744e = utility::getstruct( "pedestal" );
    level thread onryo_spawn_katana();
    sc_impact = spawnscriptable( %"zm_sat_hornet_pap_fx", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
    sc_impact setscriptablepartstate( "visual", "katana_despawn" );
    activateworldevent( "we_vfx_hornet_sword_impact_pedestal" );
    earthquakeadvanced( 0.4, 0.3, 0.2, 1.5, var_7c06ccff26c8744e.origin, 400, 600, 800 );
    level thread impact_rumble( var_7c06ccff26c8744e.origin, 800, "ground_pound_land" );
    
    if ( isdefined( level.hornet_pap_quest.sc_seed_ambient ) )
    {
        level.hornet_pap_quest.sc_seed_ambient freescriptable();
    }
    
    wait 0.5;
    level thread function_821fc42d473d0b40();
    wait 2;
    sc_onryo.var_2b0c20cebe23ba0b delete();
    sc_onryo freescriptable();
    sc_impact freescriptable();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xe40dbcbb, Offset: 0x7986
// Size: 0xd4
function function_821fc42d473d0b40()
{
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait( "power_on" );
    waitframe();
    
    if ( isdefined( level.hornet_pap_quest.sc_pedestal ) )
    {
        level.hornet_pap_quest.sc_pedestal utility::function_7c10ea82c1e305b8( "visual", "pedestal_seal" );
        level.hornet_pap_quest.sc_seed_hair = spawnscriptable( %"zm_sat_hornet_pap_fx", level.hornet_pap_quest.sc_pedestal.origin );
        wait 2;
    }
    
    if ( isdefined( level.hornet_pap_quest.sc_seed_hair ) )
    {
        level.hornet_pap_quest.sc_seed_hair utility::function_32b24db3127bff40( "visual", "seed_hair" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xa904e65c, Offset: 0x7a62
// Size: 0x64
function onryo_spawn_katana()
{
    level utility::flag_wait( "power_on" );
    var_be17fae8e83d6e7b = utility::getstruct( "embed", "script_noteworthy" );
    level.hornet_pap_quest.onryo_katana = utility::spawn_model( %"hash_1692b508fa7db63f", var_be17fae8e83d6e7b.origin, var_be17fae8e83d6e7b.angles );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xda6b4c1f, Offset: 0x7ace
// Size: 0xa9
function function_564b22a62efd6c4f()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "completed_pap_step_7" );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player namespace_c0b4f2882c9d100f::is_takeo() )
        {
            player thread function_c4f3a51a7aeb05ba();
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xd4db5336, Offset: 0x7b7f
// Size: 0x2bd
function function_c4f3a51a7aeb05ba()
{
    self endon( #"death" );
    earthquakeadvanced( 0.3, 0.2, 0.1, 1.5, self.origin, 60, 70, 80 );
    level thread impact_rumble( self.origin, 40, "ground_pound_land" );
    thread function_6943561c0d8f3b73( undefined, 2.5 );
    self.sc_onryo = spawnscriptable( %"zm_sat_hornet_pap_fx", self.origin, self.angles );
    self.sc_onryo utility::function_32b24db3127bff40( "visual", "katana_spawn" );
    self.sc_onryo.var_2b0c20cebe23ba0b = utility::spawn_model( "tag_origin", self.sc_onryo.origin, self.sc_onryo.angles );
    self.sc_onryo utility::scriptable_setparententity( self.sc_onryo.var_2b0c20cebe23ba0b );
    self.sc_onryo.var_2b0c20cebe23ba0b linkto( self, "tag_origin", ( 16, 0, 48 ), ( 0, 0, 0 ) );
    wait 0.5;
    self.sc_onryo utility::function_32b24db3127bff40( "visual", "katana_trail" );
    wait 1.5;
    self hidepart( "TAG_STOWED_BACKPACK_HIDE" );
    v_forward = vectornormalize( anglestoforward( self.angles ) ) * 200 + self.origin;
    self.sc_onryo.var_2b0c20cebe23ba0b unlink();
    self.sc_onryo.var_2b0c20cebe23ba0b moveto( v_forward, 0.5 );
    self.sc_onryo.var_2b0c20cebe23ba0b waittill( #"movedone" );
    thread function_a4c454ed237a6c5f();
    var_be17fae8e83d6e7b = utility::getstruct( "k_start" );
    n_speed = 1500;
    var_b6081b1b6ba5e8b5 = distance( var_be17fae8e83d6e7b.origin, self.origin );
    n_time = var_b6081b1b6ba5e8b5 / n_speed;
    
    if ( n_time > 5 )
    {
        n_time = 5;
    }
    
    self.sc_onryo.var_2b0c20cebe23ba0b moveto( var_be17fae8e83d6e7b.origin, n_time );
    self.sc_onryo.var_2b0c20cebe23ba0b waittill( #"movedone" );
    self.sc_onryo.var_2b0c20cebe23ba0b delete();
    self.sc_onryo freescriptable();
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0xae76384b, Offset: 0x7e44
// Size: 0x94
function function_6943561c0d8f3b73( gestureref, duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( gestureref ) )
    {
        gestureref = "vm_ges_shockstick_react";
    }
    
    curweapon = self getcurrentweapon();
    
    if ( !isdefined( curweapon ) || curweapon.basename === "none" )
    {
        return;
    }
    
    if ( weapon::isfistweapon( curweapon ) )
    {
        gestureref = "vm_ges_shockstick_react_fists_t10";
    }
    
    while ( !self isgestureplaying( gestureref ) )
    {
        self forceplaygestureviewmodel( gestureref );
        waitframe();
    }
    
    wait duration;
    self stopgestureviewmodel( gestureref, 0.5 );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x68a27fc, Offset: 0x7ee0
// Size: 0x121
function waypoint_manager()
{
    level endon( #"open_sesame" );
    level.hornet_pap_quest.a_s_waypoints = [];
    path_west_start = utility::getstruct( "path_west_0", "script_noteworthy" );
    path_east_start = utility::getstruct( "path_east_0", "script_noteworthy" );
    level.hornet_pap_quest.a_s_waypoints[ level.hornet_pap_quest.a_s_waypoints.size ] = path_west_start;
    level.hornet_pap_quest.a_s_waypoints[ level.hornet_pap_quest.a_s_waypoints.size ] = path_east_start;
    level.hornet_pap_quest.path_west = path_west_start;
    level.hornet_pap_quest.path_east = path_east_start;
    function_ecc91637c2a6fbb1();
    level utility::flag_wait( "path_chosen" );
    path_west_start thread function_9768ead11e8a9c43();
    path_east_start thread function_a7d5501b1dd83b41();
    function_ecc91637c2a6fbb1();
    level utility::flag_wait_any( "door_lava_garden_to_second_bailey", "door_west_bailey_to_broken_turrets" );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x9bc4b6ee, Offset: 0x8009
// Size: 0x99
function function_9768ead11e8a9c43()
{
    level endon( #"door_lava_garden_to_second_bailey", #"door_west_bailey_to_broken_turrets" );
    level utility::flag_wait( "door_start_to_third_bailey_west" );
    level.hornet_pap_quest.path_west = utility::getstruct( self.target );
    function_ecc91637c2a6fbb1();
    level utility::flag_wait( "door_third_bailey_to_west_bailey" );
    level.hornet_pap_quest.path_west = utility::getstruct( level.hornet_pap_quest.path_west.target );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xc6388d81, Offset: 0x80aa
// Size: 0x99
function function_a7d5501b1dd83b41()
{
    level endon( #"door_lava_garden_to_second_bailey", #"door_west_bailey_to_broken_turrets" );
    level utility::flag_wait( "door_start_to_third_bailey_east" );
    level.hornet_pap_quest.path_east = utility::getstruct( self.target );
    function_ecc91637c2a6fbb1();
    level utility::flag_wait( "door_third_bailey_to_lava_garden" );
    level.hornet_pap_quest.path_east = utility::getstruct( level.hornet_pap_quest.path_east.target );
    function_ecc91637c2a6fbb1();
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0xea519e82, Offset: 0x814b
// Size: 0x29
function on_door_bought( params )
{
    if ( !level utility::flag( "path_chosen" ) )
    {
        level utility::flag_set( "path_chosen" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x429804dd, Offset: 0x817c
// Size: 0x248
function function_277e591e97d5d692()
{
    level endon( #"power_on" );
    level utility::flag_wait( "open_sesame" );
    
    foreach ( step in level.hornet_pap_quest.steps )
    {
        zm_quest::function_e65609834444650c( step );
    }
    
    foreach ( s_banner in utility::getstructarray( "ar_bnr" ) )
    {
        if ( s_banner.interact )
        {
            s_banner.interact delete();
        }
    }
    
    wait 1;
    callback::remove( "on_zombie_ai_spawned", &function_97be7f92252977f9 );
    callback::remove( #"on_ai_killed", &on_pap_zombie_killed );
    level utility::flag_clear( "pause_ambient_ash" );
    level utility::flag_set( "hornet_pap_quest_open_sesame_complete" );
    zm_quest::function_4eefe6de31f5ddab( #"hornet_pap_quest", #"hanko_acquired", 1 );
    
    if ( !isdefined( level.hornet_mq.gathered_evidence ) )
    {
        level.hornet_mq.gathered_evidence = 0;
    }
    
    level.hornet_mq.gathered_evidence = utility::set_bit_flag( level.hornet_mq.gathered_evidence, 13 );
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_mq_quest", #"hash_5674ab884e5e790a", level.hornet_mq.gathered_evidence );
    curr_phase_index = zm_quest::function_23669314446ef229( #"mq" );
    level zm_quest::function_b57dfe9625966b0b( #"mq", curr_phase_index, #"ev_mot", 3 );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xf6d26186, Offset: 0x83cc
// Size: 0x2b
function gesture_test()
{
    wait 5;
    level.player thread utility::function_72b6372d2d8c997( "cer_zm_vm_ges_author_organism" );
    wait 5;
    level.player stopgestureviewmodel();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x14b43109, Offset: 0x83ff
// Size: 0x9f
function function_dbba969b8138dd8f()
{
    foreach ( s_banner in utility::getstructarray( "ar_bnr" ) )
    {
        if ( isdefined( s_banner.sc_banner ) )
        {
            s_banner.sc_banner utility::function_32b24db3127bff40( "model", "player" );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x36b0723b, Offset: 0x84a6
// Size: 0x93
function function_c18bdbf334f8dca0()
{
    foreach ( zone in level.hornet_pap_quest.var_60f10a48d7117b2e )
    {
        zm_utility::function_81ecff068420355d( [ zone ], level.var_6f89b56853b0e818 );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x88549139, Offset: 0x8541
// Size: 0xa8
function function_d84af0d2d9f5ad30()
{
    foreach ( sc_seal in level.hornet_pap_quest.var_da0a79ef903d0ac0 )
    {
        if ( isdefined( sc_seal ) )
        {
            sc_seal freescriptable();
            
            if ( isdefined( sc_seal.interact ) )
            {
                sc_seal.interact delete();
            }
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1, eflags: 0x4
// Checksum 0xdde1f292, Offset: 0x85f1
// Size: 0x54
function private function_fbb7d4c98261e273( zone_name )
{
    var_93d84a67723d6fe6 = strtok( zone_name, "_" );
    
    if ( var_93d84a67723d6fe6.size > 3 )
    {
        generalized_zone_name = var_93d84a67723d6fe6[ 0 ] + "_" + var_93d84a67723d6fe6[ 1 ] + "_" + var_93d84a67723d6fe6[ 2 ];
        return generalized_zone_name;
    }
    
    return zone_name;
}

// Namespace zm_sat_hornet_pap_quest
// Params 3
// Checksum 0x9dc921f8, Offset: 0x864e
// Size: 0xa9
function impact_rumble( v_pos, n_radius, var_2c9997925f5b83e7 )
{
    a_players = getplayersinradius( v_pos, n_radius );
    
    foreach ( player in a_players )
    {
        if ( isalive( player ) )
        {
            player playrumbleonentity( var_2c9997925f5b83e7 );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xb1e8d370, Offset: 0x86ff
// Size: 0x15b
function function_543179c3a70a24ee()
{
    var_57c7ea84a67ec326 = [ "door_start_to_third_bailey_west", "door_start_to_third_bailey_east", "door_third_bailey_to_lava_garden", "door_lava_garden_to_second_bailey", "door_second_bailey_to_main_bailey", "door_third_bailey_to_west_bailey", "door_west_bailey_to_broken_turrets", "door_broken_turrets_to_main_bailey" ];
    var_b0f5ca579d03b5c = getentarray( "zombie_door", "targetname" );
    
    foreach ( door in var_b0f5ca579d03b5c )
    {
        if ( arraycontains( var_57c7ea84a67ec326, door.script_flag_set ) )
        {
            foreach ( door in door.doors )
            {
                door doorbuy::function_f3160e450543b4f1();
            }
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x328d5c9b, Offset: 0x8862
// Size: 0x115
function function_116362c59412bd67()
{
    var_b0f5ca579d03b5c = getentarray( "zombie_door", "targetname" );
    
    foreach ( door in var_b0f5ca579d03b5c )
    {
        if ( door.script_flag_set === "door_main_bailey_to_main_keep" )
        {
            foreach ( door in door.doors )
            {
                door doorbuy::function_f3160e450543b4f1();
            }
            
            level utility::flag_set( "completed_pap_step_2" );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x4efcebb4, Offset: 0x897f
// Size: 0x2e
function function_a0565bbc8222f23f( ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    if ( isent( ent ) )
    {
        ent delete();
        return;
    }
    
    ent freescriptable();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x7ef1e0d2, Offset: 0x89b5
// Size: 0x140
function function_78e3df30184e468a()
{
    var_57c7ea84a67ec326 = [ "door_main_bailey_to_main_keep_east_path", "door_main_bailey_to_main_keep_west_path", "door_main_keep_left_path_to_main_keep2", "door_main_bailey_to_main_keep_east_path", "door_main_keep_right_path_to_main_keep2" ];
    var_b0f5ca579d03b5c = getentarray( "zombie_door", "targetname" );
    
    foreach ( door in var_b0f5ca579d03b5c )
    {
        if ( arraycontains( var_57c7ea84a67ec326, door.script_flag_set ) )
        {
            foreach ( door in door.doors )
            {
                door doorbuy::function_f3160e450543b4f1();
            }
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xad7b68c3, Offset: 0x8afd
// Size: 0x36
function function_c6a892557d67a731()
{
    level endon( #"game_ended" );
    
    while ( !isdefined( level.ai_oni ) )
    {
        wait 0.1;
    }
    
    wait 1;
    level.ai_oni kill();
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x9506200e, Offset: 0x8b3b
// Size: 0x49
function function_11e7549c11b7a2c()
{
    if ( isdefined( level.hornet_pap_quest.hanko ) )
    {
        level.hornet_pap_quest.hanko freescriptable();
    }
    
    level.has_hanko = 1;
    level utility::flag_set( "hanko_acquired" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x76260eef, Offset: 0x8b8c
// Size: 0x8e2
function function_ecc91637c2a6fbb1()
{
    if ( level utility::flag( "open_sesame" ) || level utility::flag( "power_on" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "path_chosen" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.path_west ], [ level.hornet_pap_quest.path_east ] ], #"hornet_pap_quest", #"recapture_zones" );
        }
        else
        {
            level thread update_guidance( [ [ level.hornet_pap_quest.path_west ], [ level.hornet_pap_quest.path_east ] ], #"hornet_pap_quest", #"recapture_zones" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "door_third_bailey_to_west_bailey" ) && !level utility::flag( "door_third_bailey_to_lava_garden" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.path_west ], [ level.hornet_pap_quest.path_east ] ], #"hornet_pap_quest", #"recapture_zones" );
        }
        else
        {
            level thread update_guidance( [ [ level.hornet_pap_quest.path_west ], [ level.hornet_pap_quest.path_east ] ], #"hornet_pap_quest", #"recapture_zones" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "door_lava_garden_to_second_bailey" ) && !level utility::flag( "door_west_bailey_to_broken_turrets" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.path_west ], [ level.hornet_pap_quest.path_east ] ], #"hornet_pap_quest", #"recapture_zones" );
        }
        else
        {
            level thread update_guidance( [ [ level.hornet_pap_quest.path_west ], [ level.hornet_pap_quest.path_east ] ], #"hornet_pap_quest", #"recapture_zones" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "recaptured" ) )
    {
        level zm_quest::function_9f49b2a045ece8ae( level.hornet_pap_quest.var_4dccbd0938637832, 1, #"hornet_pap_quest", #"recapture_zones" );
        level utility::flag_wait( "pap_banners_setup" );
        
        if ( level.hornet_pap_quest.a_s_banners.size == 2 )
        {
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                level thread zm_quest::update_guidance( undefined, #"hornet_pap_quest", #"recapture_zones" );
            }
            else
            {
                level thread update_guidance( undefined, #"hornet_pap_quest", #"recapture_zones" );
            }
            
            zm_sat_hornet_assault_rounds::function_1fa5bfd36bb20e8( level.hornet_pap_quest.a_s_banners[ 0 ] );
            zm_sat_hornet_assault_rounds::function_1fa5bfd36bb20e8( level.hornet_pap_quest.a_s_banners[ 1 ] );
        }
        else if ( level.hornet_pap_quest.a_s_banners.size == 1 )
        {
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                level thread zm_quest::update_guidance( undefined, #"hornet_pap_quest", #"recapture_zones" );
            }
            else
            {
                level thread update_guidance( undefined, #"hornet_pap_quest", #"recapture_zones" );
            }
            
            zm_sat_hornet_assault_rounds::function_1fa5bfd36bb20e8( level.hornet_pap_quest.a_s_banners[ 0 ] );
        }
        
        return;
    }
    
    if ( !level utility::flag( "open_gate" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ utility::getstruct( "gate_entrance" ) ] ], #"hornet_pap_quest", #"enter_castle" );
        }
        else
        {
            level thread update_guidance( [ [ utility::getstruct( "gate_entrance" ) ] ], #"hornet_pap_quest", #"enter_castle" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "door_main_bailey_to_main_keep_west_path" ) && !level utility::flag( "door_main_bailey_to_main_keep_east_path" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.a_s_objs[ 0 ] ], [ level.hornet_pap_quest.a_s_objs[ 1 ] ] ], #"hornet_pap_quest", #"locate_pap" );
        }
        else
        {
            level thread update_guidance( [ [ level.hornet_pap_quest.a_s_objs[ 0 ] ], [ level.hornet_pap_quest.a_s_objs[ 1 ] ] ], #"hornet_pap_quest", #"locate_pap" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "door_main_keep_left_path_to_main_keep2" ) && !level utility::flag( "door_main_keep_right_path_to_main_keep2" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.path_next ] ], #"hornet_pap_quest", #"locate_pap" );
        }
        else
        {
            level thread update_guidance( [ [ level.hornet_pap_quest.path_next ] ], #"hornet_pap_quest", #"locate_pap" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "pap_door_found" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ utility::getstruct( "pap_entrance" ) ] ], #"hornet_pap_quest", #"locate_pap" );
        }
        else
        {
            level thread update_guidance( [ [ utility::getstruct( "pap_entrance" ) ] ], #"hornet_pap_quest", #"locate_pap" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "pap_special_dead" ) )
    {
        zm_quest::complete_objective_waypoints( level.var_73fb6215ee18ec22.objindex );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ level.ai_oni, 90 ] ], #"hornet_pap_quest", #"defeat_oni" );
        }
        else
        {
            level thread update_guidance( [ [ level.ai_oni, 90 ] ], #"hornet_pap_quest", #"defeat_oni" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "hanko_acquired" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ level.hornet_pap_quest.hanko, 16 ] ], #"hornet_pap_quest", #"acquire_hanko" );
        }
        else
        {
            level thread update_guidance( [ [ level.hornet_pap_quest.hanko, 16 ] ], #"hornet_pap_quest", #"acquire_hanko" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "pap_open" ) )
    {
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ utility::getstruct( "pap_entrance" ), 16 ] ], #"hornet_pap_quest", #"open_pap" );
        }
        else
        {
            level thread update_guidance( [ [ utility::getstruct( "pap_entrance" ), 16 ] ], #"hornet_pap_quest", #"open_pap" );
        }
        
        return;
    }
    
    if ( !level utility::flag( "seed_charged" ) )
    {
        s_seed = utility::getstruct( "seed" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_guidance( [ [ s_seed, 28 ], [ s_seed, 0, 250 ] ], #"hornet_pap_quest", #"charge_seed" );
            return;
        }
        
        level thread update_guidance( [ [ s_seed, 28 ], [ s_seed, 0, 250 ] ], #"hornet_pap_quest", #"charge_seed" );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 4
// Checksum 0x52dc99a0, Offset: 0x9476
// Size: 0x5fc
function update_guidance( huddata, quest_ref, step_ref, var_ea6cb90f36a2e7bf = 0 )
{
    level endon( #"game_ended" );
    clear_guidance();
    
    if ( !var_ea6cb90f36a2e7bf )
    {
        if ( isdefined( level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1 ) )
        {
            if ( level.zm_quests_steps[ level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1 ][ level.var_1d8bcf5a19244e0e.var_fcdcd383b4f959ed ] === utility::function_f1933af772476229( level.zm_quests_steps[ level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1 ] ) && !level.var_1d8bcf5a19244e0e.var_b75d36ea70a4ebc9 )
            {
                zm_quest::function_fb3af5600f6a9441( 4, 1, level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1, level.var_1d8bcf5a19244e0e.var_fcdcd383b4f959ed );
                waitframe();
                zm_quest::function_a81dd416b9036f0e( 1, level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1 );
                level.var_1d8bcf5a19244e0e.var_b75d36ea70a4ebc9 = 1;
                wait 10;
                
                if ( !level.var_1d8bcf5a19244e0e.var_b75d36ea70a4ebc9 || level.zm_quests_steps[ level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1 ][ level.var_1d8bcf5a19244e0e.var_fcdcd383b4f959ed ] != utility::function_f1933af772476229( level.zm_quests_steps[ level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1 ] ) )
                {
                    level.var_1d8bcf5a19244e0e.var_b75d36ea70a4ebc9 = 0;
                    return;
                }
                
                level.var_1d8bcf5a19244e0e.var_b75d36ea70a4ebc9 = 0;
            }
        }
    }
    
    if ( isdefined( huddata ) )
    {
        foreach ( hudobject in huddata )
        {
            if ( isdefined( hudobject[ 0 ] ) )
            {
                var_73fb6215ee18ec22 = spawnstruct();
                var_73fb6215ee18ec22.index = level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3.size;
                var_73fb6215ee18ec22.offset = hudobject[ 1 ];
                var_73fb6215ee18ec22.radius = hudobject[ 2 ];
                var_73fb6215ee18ec22.var_7658622ac37ea4e5 = hudobject[ 4 ];
                var_73fb6215ee18ec22.var_895bdd0db4c4515 = ( isdefined( hudobject[ 5 ] ) && !isarray( hudobject[ 5 ] ) ? [ hudobject[ 5 ] ] : hudobject[ 5 ] ) ?? [];
                var_73fb6215ee18ec22.origin = isvector( hudobject[ 0 ] ) ? hudobject[ 0 ] : hudobject[ 0 ].origin;
                level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3[ level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3.size ] = var_73fb6215ee18ec22;
                
                if ( isdefined( hudobject[ 0 ] ) && !isdefined( var_73fb6215ee18ec22.radius ) )
                {
                    if ( !isdefined( var_73fb6215ee18ec22.offset ) )
                    {
                        var_73fb6215ee18ec22.offset = 20;
                    }
                    
                    if ( isent( hudobject[ 0 ] ) )
                    {
                        var_73fb6215ee18ec22.objindex = zm_quest::function_dc297429579c6e7f( string( var_73fb6215ee18ec22.index ), 0, "ui_icon_zm_objective", undefined, "current", hudobject[ 0 ], var_73fb6215ee18ec22.offset, hudobject[ 3 ], undefined, 1, 0, undefined, var_73fb6215ee18ec22.var_895bdd0db4c4515 );
                    }
                    else
                    {
                        var_73fb6215ee18ec22.objindex = zm_quest::function_b98d4144845ffc13( string( var_73fb6215ee18ec22.index ), 0, "ui_icon_zm_objective", undefined, "current", var_73fb6215ee18ec22.origin, var_73fb6215ee18ec22.offset, hudobject[ 3 ], undefined, 1, 0, var_73fb6215ee18ec22.var_895bdd0db4c4515 );
                    }
                    
                    continue;
                }
                
                if ( isdefined( var_73fb6215ee18ec22.radius ) )
                {
                    if ( var_73fb6215ee18ec22.offset > 0 )
                    {
                        level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3[ level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3.size - 1 ] game_utility::questcircle_create( "testCircle_Orange", utility::getrandompointincircle( var_73fb6215ee18ec22.origin, var_73fb6215ee18ec22.offset ), var_73fb6215ee18ec22.radius );
                    }
                    else
                    {
                        level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3[ level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3.size - 1 ] game_utility::questcircle_create( "testCircle_Orange", var_73fb6215ee18ec22.origin, var_73fb6215ee18ec22.radius );
                    }
                    
                    if ( var_73fb6215ee18ec22.var_7658622ac37ea4e5 )
                    {
                        level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3[ level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3.size - 1 ] thread game_utility::function_de7fe184eb0e834c();
                        continue;
                    }
                    
                    level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3[ level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3.size - 1 ] game_utility::questcircle_showtoall();
                }
            }
        }
    }
    
    if ( isdefined( quest_ref ) && isdefined( step_ref ) )
    {
        quest_step = zm_quest::get_quest_step( quest_ref, step_ref );
        
        if ( level.var_1d8bcf5a19244e0e.var_fcdcd383b4f959ed != step_ref || level.var_1d8bcf5a19244e0e.var_ec54378cf831e7c1 != quest_ref )
        {
            zm_quest::function_fba942a1cfd85f5d( 1, 1, quest_ref, step_ref );
            
            if ( level.zm_quests_steps[ quest_ref ][ step_ref ] == utility::array_get_first_item( level.zm_quests_steps[ quest_ref ] ) )
            {
                zm_quest::function_fb3af5600f6a9441( 1, 1, quest_ref, step_ref );
                return;
            }
            
            zm_quest::function_fb3af5600f6a9441( 2, 1, quest_ref, step_ref );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x28f8bbd6, Offset: 0x9a7a
// Size: 0xff
function clear_guidance()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::clear_all_guidance();
        return;
    }
    
    if ( !isdefined( level.var_1d8bcf5a19244e0e ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3 ) )
    {
        return;
    }
    
    foreach ( hudobject in level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3 )
    {
        if ( isdefined( hudobject.radius ) == 0 )
        {
            zm_quest::complete_objective_waypoints( string( hudobject.index ) );
            continue;
        }
        
        hudobject game_utility::questcircle_delete();
    }
    
    level.var_1d8bcf5a19244e0e.var_f1879f50f4eeaca3 = [];
}

// Namespace zm_sat_hornet_pap_quest
// Params 3
// Checksum 0x9f881333, Offset: 0x9b81
// Size: 0xa8
function function_5bf510005480ab04( start, dot = 0.8, ignore_ent )
{
    end = self geteye();
    angles = vectortoangles( start - end );
    forward = anglestoforward( angles );
    player_angles = self getplayerangles();
    player_forward = anglestoforward( player_angles );
    new_dot = vectordot( forward, player_forward );
    
    if ( new_dot < dot )
    {
        return 0;
    }
    
    return trace::ray_trace_detail_passed( start, end, ignore_ent, trace::create_default_contents( 1 ) );
}

// Namespace zm_sat_hornet_pap_quest
// Params 4
// Checksum 0x9dcc38b5, Offset: 0x9c32
// Size: 0xba
function function_7d21ff99616b2601( var_80ce893c79d1d533, n_delay, b_generic, player )
{
    if ( isdefined( n_delay ) )
    {
        wait n_delay;
    }
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        namespace_f1b889ff795b541c::play_banter_vo( var_80ce893c79d1d533, [ player ] );
        return;
    }
    
    if ( !isdefined( b_generic ) )
    {
        return;
    }
    
    if ( b_generic == "notsure" )
    {
        str_vo = #"hash_5212ed7ec42f115a";
    }
    else if ( b_generic == "positive" )
    {
        str_vo = #"bc_flavor_player_positive";
    }
    else if ( b_generic == "negative" )
    {
        str_vo = #"bc_flavor_player_negative";
    }
    
    battlechatter_mp::trysaylocalsound( player, str_vo );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x87d32176, Offset: 0x9cf4
// Size: 0x98
function get_hero_players()
{
    a_hero_players = [];
    
    foreach ( player in level.players )
    {
        if ( player namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            a_hero_players[ a_hero_players.size ] = player;
        }
    }
    
    if ( a_hero_players.size )
    {
        return a_hero_players;
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xaedba3f0, Offset: 0x9d94
// Size: 0xb4
function function_5fc0a5718bf2f262()
{
    level endon( #"game_ended", #"open_sesame", self.str_flag );
    
    while ( true )
    {
        occupants = zone_manager::get_zone_occupants( self.zone.script_zone_name );
        
        if ( occupants.size )
        {
            break;
        }
        
        wait 1;
    }
    
    if ( !isdefined( level.var_5fc0a5718bf2f262 ) )
    {
        if ( isalive( occupants[ 0 ] ) && occupants[ 0 ] namespace_c0b4f2882c9d100f::is_hero_operator() )
        {
            player = occupants[ 0 ];
        }
        
        level.var_5fc0a5718bf2f262 = 1;
        
        if ( isdefined( player ) )
        {
            function_7d21ff99616b2601( "banner_zone_arrival", 0.1, "notsure", player );
        }
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 2
// Checksum 0x8be56cfd, Offset: 0x9e50
// Size: 0x84
function vo_banner_recapture( player, str_state )
{
    n_index = randomint( 2 );
    
    if ( str_state == "start" )
    {
        var_80ce893c79d1d533 = "start_banner_recapture_" + n_index;
    }
    else
    {
        var_80ce893c79d1d533 = "banner_recapture_fail_" + n_index;
    }
    
    level utility::flag_set( "twins_dialogue_playing" );
    overlord::playconversation( var_80ce893c79d1d533, level.players, 1, 1 );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 1
// Checksum 0x7efc4e, Offset: 0x9edc
// Size: 0x63
function vo_glyph_removed( player )
{
    n_index = randomint( 2 );
    var_80ce893c79d1d533 = "glyph_removed_" + n_index;
    level utility::flag_set( "twins_dialogue_playing" );
    overlord::playconversation( var_80ce893c79d1d533, level.players, 0.5, 1 );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xd6edc337, Offset: 0x9f47
// Size: 0xa2
function vo_pap_room()
{
    level endon( #"game_ended", #"open_sesame" );
    n_index = 0;
    var_80ce893c79d1d533 = "pap_room_" + n_index;
    
    while ( true )
    {
        occupants = zone_manager::get_zone_occupants( level.hornet_pap_quest.zone.script_zone_name );
        
        if ( occupants.size )
        {
            break;
        }
        
        wait 1;
    }
    
    level utility::flag_set( "twins_dialogue_playing" );
    overlord::playconversation( var_80ce893c79d1d533, occupants, 0.25, 1 );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x3c19d21a, Offset: 0x9ff1
// Size: 0x6e
function vo_seed_charge()
{
    n_index = randomint( 2 );
    var_80ce893c79d1d533 = "seed_charge_" + n_index;
    s_seed = utility::getstruct( "seed" );
    level utility::flag_set( "twins_dialogue_playing" );
    overlord::playconversation( var_80ce893c79d1d533, level.players, 0.5, 1 );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0x2a568b2, Offset: 0xa067
// Size: 0x5e
function function_a4c454ed237a6c5f()
{
    occupants = zone_manager::get_zone_occupants( level.hornet_pap_quest.zone.script_zone_name );
    
    if ( isdefined( self ) && namespace_c0b4f2882c9d100f::is_takeo() && !arraycontains( occupants, self ) )
    {
        namespace_f1b889ff795b541c::play_banter_vo( "seed_charge", [ self ] );
    }
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xe8e60052, Offset: 0xa0cd
// Size: 0x2d
function function_e6a06431eb7d8dea()
{
    wait 4;
    level utility::flag_set( "twins_dialogue_playing" );
    dialogue::say( "dx_zm_hpwp_hpp2_psor_hpp2oroulsh", 1 );
    level utility::flag_clear( "twins_dialogue_playing" );
}

// Namespace zm_sat_hornet_pap_quest
// Params 0
// Checksum 0xd045406b, Offset: 0xa102
// Size: 0xbb
function vo_power_destruction()
{
    wait 6.5;
    n_index = randomint( 2 );
    var_80ce893c79d1d533 = "power_destruction_" + n_index;
    s_seed = utility::getstruct( "seed" );
    level utility::flag_set( "twins_dialogue_playing" );
    overlord::playconversation( var_80ce893c79d1d533, level.players, 0.1, 1 );
    wait 4;
    occupants = zone_manager::get_zone_occupants( level.hornet_pap_quest.zone.script_zone_name );
    
    if ( occupants.size )
    {
        namespace_f1b889ff795b541c::play_banter_vo( "power_destruction", occupants );
    }
    
    level utility::flag_clear( "twins_dialogue_playing" );
}

