// scripts\mp\zm\livingworld\zm_sat_firefly_livingworld.gsc  (hash_2a051489fd247792.gscc) (size: 2996 Bytes / 0xbb4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77ad1745 (2007832389)
// size ...... 2996 (0xbb4)
// includes .. 5   (offset: 0xa68)
// strings ... 23  (offset: 0xa90)
// dev strs .. 0   (offset: 0xbb4)
// exports ... 5   (offset: 0x784)
// cseg ...... 0x389 + 0x3fb (0x784)
// imports ... 17  (offset: 0x84c)
// animtree1 . 0   (offset: 0xbb4)
// animtree2 . 0   (offset: 0xbb4)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\livingworld\zm_sat_livingworld;
#using scripts\mp\zm\systems\zm_livingworld;

#namespace zm_sat_firefly_livingworld;

// Namespace zm_sat_firefly_livingworld
// Params 0, eflags: 0x5
// Checksum 0xc426201, Offset: 0x3a7
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"zm_sat_firefly_livingworld", [ #"zm_livingworld", #"zm_sat_livingworld" ], undefined, &function_db93089546ceb75d );
}

// Namespace zm_sat_firefly_livingworld
// Params 0
// Checksum 0x9c48436d, Offset: 0x3e2
// Size: 0x19d
function function_db93089546ceb75d()
{
    if ( zm_livingworld::livingworld_is_disabled( "SAT", "zm_sat_firefly" ) )
    {
        return;
    }
    
    while ( !isdefined( level._livingworld_info.script_funcs ) )
    {
        waitframe();
    }
    
    anim_func_pairs = [];
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_long_zmb" ] = &zm_sat_livingworld::function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_short_zmb" ] = &zm_sat_livingworld::function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_long_zmb" ] = &zm_sat_livingworld::function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_short_zmb" ] = &zm_sat_livingworld::function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_sign_zmb" ] = &zm_sat_livingworld::function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_sign_zmb" ] = &zm_sat_livingworld::function_fdfab27bdcab98f;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_long_zmb_ai" ] = &zm_sat_livingworld::function_d4e1a10c23c9b8fe;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_arms_short_zmb_ai" ] = &zm_sat_livingworld::function_d4e1a10c23c9b8fe;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_long_zmb_ai" ] = &zm_sat_livingworld::function_d4e1a10c23c9b8fe;
    anim_func_pairs[ "sat_cin_zm_living_world_hung_neck_short_zmb_ai" ] = &zm_sat_livingworld::function_d4e1a10c23c9b8fe;
    anim_func_pairs[ "sat_cin_zm_living_world_slumped_over_firefly_waitress" ] = &function_91716bd0091068f8;
    anim_func_pairs[ "sat_cin_zm_living_world_slumped_over_firefly_mechanic" ] = &function_91716bd0091068f8;
    anim_func_pairs[ "sat_cin_zm_living_world_slumped_over_firefly_trucker" ] = &function_91716bd0091068f8;
    
    foreach ( stringid, func in anim_func_pairs )
    {
        level._livingworld_info.script_funcs[ stringid ] = func;
    }
    
    level._effect[ "zmb_eye_glow" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_zai_base_eye" );
    level utility::flag_set( "init_" + level.mapname + "_anim_func_pairs" );
}

// Namespace zm_sat_firefly_livingworld
// Params 0
// Checksum 0xacc73cd1, Offset: 0x587
// Size: 0xf5
function sat_cin_zm_living_world_slumped_over_zmb()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint" );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( !self.isplaying )
    {
        foreach ( ent in self.scene_ents[ "actors" ] )
        {
            if ( !isalive( ent ) || !isai( ent ) )
            {
                continue;
            }
            
            ent val::set( "living_world", "collide_with_ai_allies" );
        }
    }
}

// Namespace zm_sat_firefly_livingworld
// Params 0
// Checksum 0xede7cca0, Offset: 0x684
// Size: 0x100
function function_91716bd0091068f8()
{
    self.idle_func_vars = zm_livingworld::init_idle_func_vars( 1, undefined, undefined, undefined, 1, 1, 1 );
    self.action_func_vars = zm_livingworld::init_action_func_vars( "sprint", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1 );
    zm_livingworld::function_2976dc572653be5e( self.idle_func_vars, self.action_func_vars );
    
    if ( !self.isplaying )
    {
        foreach ( ent in self.scene_ents[ "actors" ] )
        {
            if ( !isalive( ent ) || !isai( ent ) )
            {
                continue;
            }
            
            ent val::set( "living_world", "collide_with_ai_allies" );
        }
    }
}

