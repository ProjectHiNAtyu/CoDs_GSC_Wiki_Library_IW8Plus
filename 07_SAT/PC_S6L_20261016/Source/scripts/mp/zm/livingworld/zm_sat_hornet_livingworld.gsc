// scripts\mp\zm\livingworld\zm_sat_hornet_livingworld.gsc  (hash_313dfaad6fba18df.gscc) (size: 1706 Bytes / 0x6aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd071901d (3497103389)
// size ...... 1706 (0x6aa)
// includes .. 3   (offset: 0x60e)
// strings ... 11  (offset: 0x626)
// dev strs .. 0   (offset: 0x6aa)
// exports ... 7   (offset: 0x36e)
// cseg ...... 0x174 + 0x1fa (0x36e)
// imports ... 14  (offset: 0x486)
// animtree1 . 0   (offset: 0x6aa)
// animtree2 . 0   (offset: 0x6aa)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_livingworld;

#namespace zm_sat_hornet_livingworld;

// Namespace zm_sat_hornet_livingworld
// Params 0, eflags: 0x5
// Checksum 0xeb31769a, Offset: 0x192
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_livingworld", [ #"zm_livingworld", #"zm_sat_livingworld" ], undefined, &function_b76eafaea5b369c );
}

// Namespace zm_sat_hornet_livingworld
// Params 0
// Checksum 0xe67ca3db, Offset: 0x1cd
// Size: 0x138
function function_b76eafaea5b369c()
{
    if ( zm_livingworld::livingworld_is_disabled( "SAT", "zm_sat_hornet" ) )
    {
        return;
    }
    
    while ( !isdefined( level._livingworld_info.script_funcs ) )
    {
        waitframe();
    }
    
    anim_func_pairs = [];
    anim_func_pairs[ "sat_cin_zm_living_world_caged_03_zmb" ] = &function_cfb58139dfdbfc7a;
    anim_func_pairs[ "sat_cin_zm_living_world_caged_05_zmb" ] = &function_cfb57b39dfdbef48;
    anim_func_pairs[ "sat_cin_zm_living_world_caged_06_zmb" ] = &function_cfb57e39dfdbf5e1;
    anim_func_pairs[ "sat_cin_zm_living_world_solo_eating_zmb_01" ] = &function_1257c7fa22e647f1;
    
    foreach ( stringid, func in anim_func_pairs )
    {
        level._livingworld_info.script_funcs[ stringid ] = func;
    }
    
    level._effect[ "zmb_eye_glow" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_zai_base_eye" );
    level utility::flag_set( "init_" + level.mapname + "_anim_func_pairs" );
    setdvarifuninitialized( @"hash_ea917e1597aab9a0", 1 );
}

// Namespace zm_sat_hornet_livingworld
// Params 0
// Checksum 0x62c299b3, Offset: 0x30d
// Size: 0x2
function function_cfb58139dfdbfc7a()
{
    
}

// Namespace zm_sat_hornet_livingworld
// Params 0
// Checksum 0x8ba13c86, Offset: 0x317
// Size: 0x2
function function_cfb57b39dfdbef48()
{
    
}

// Namespace zm_sat_hornet_livingworld
// Params 0
// Checksum 0x12a86d3c, Offset: 0x321
// Size: 0x2
function function_cfb57e39dfdbf5e1()
{
    
}

// Namespace zm_sat_hornet_livingworld
// Params 0, eflags: 0x4
// Checksum 0x68218569, Offset: 0x32b
// Size: 0x43
function private function_1257c7fa22e647f1()
{
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint" );
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, 650 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
}

