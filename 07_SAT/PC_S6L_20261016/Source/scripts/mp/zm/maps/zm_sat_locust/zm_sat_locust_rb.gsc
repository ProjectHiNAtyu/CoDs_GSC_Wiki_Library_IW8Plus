// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rb.gsc  (hash_05ba67ca84e05c50.gscc) (size: 3519 Bytes / 0xdbf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x730cb78a (1930213258)
// size ...... 3519 (0xdbf)
// includes .. 7   (offset: 0xc5b)
// strings ... 24  (offset: 0xc93)
// dev strs .. 0   (offset: 0xdbf)
// exports ... 8   (offset: 0x823)
// cseg ...... 0x2eb + 0x538 (0x823)
// imports ... 25  (offset: 0x963)
// animtree1 . 0   (offset: 0xdbf)
// animtree2 . 0   (offset: 0xdbf)
#using script_c9364426f358755;
#using scripts\common\utility;
#using scripts\mp\doorbuy;
#using scripts\mp\zm\systems\zm_round_accelerant;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\traps\fire_trap;

#namespace zm_sat_locust_rb;

// Namespace zm_sat_locust_rb
// Params 0
// Checksum 0x556005d5, Offset: 0x309
// Size: 0x7d
function init()
{
    level thread zm_round_accelerant::init_round_accelerant();
    level thread namespace_3f111107c49ee3c::pre_init();
    level thread zm_round_spawning::function_c134fd55f45903e6( %"hash_60eeed8dde689bd0" );
    level thread init_powered_zones();
    level thread init_fishery_zone();
    level thread init_zipline_icons();
    level thread function_51253a83bfd9b5a2();
    level thread function_651503fd0befff22();
    level._effect[ "zombie_wipe" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact" );
    level._effect[ "zombie_wipe_blood" ] = loadfxasset( "vfx_t10_levels_zm_quartz_machine_amp_impact_blood" );
}

// Namespace zm_sat_locust_rb
// Params 0, eflags: 0x4
// Checksum 0xf223c8c4, Offset: 0x38e
// Size: 0x36
function private init_powered_zones()
{
    level endon( #"game_ended" );
    utility::flag_wait( "power_on" );
    zone_manager::set_zone_enabled( "zone_lighthouse", 1 );
    zone_manager::set_zone_enabled( "zone_bridge", 1 );
}

// Namespace zm_sat_locust_rb
// Params 0, eflags: 0x4
// Checksum 0x1bc32c36, Offset: 0x3cc
// Size: 0x37
function private init_fishery_zone()
{
    level endon( #"game_ended" );
    utility::flag_wait_any( "zone_shipyard_to_fishery_bought", "zone_downtown_to_fishery_bought", "zone_foundry_bought", "zone_village_bought" );
    zone_manager::set_zone_enabled( "zone_fishery", 1 );
}

// Namespace zm_sat_locust_rb
// Params 0, eflags: 0x4
// Checksum 0x15c37a3a, Offset: 0x40b
// Size: 0x1d3
function private init_zipline_icons()
{
    utility::flag_wait( "doorbuy_init_complete" );
    zipline_icons = getentitylessscriptablearray( "scriptable_sat_ascender_zipline_icon_dynamic_zm", #classname );
    
    foreach ( doorbuy in level.a_s_doorbuys )
    {
        ascenders = getentitylessscriptablearray( "scriptable_t10_ascender_zipline_01", #classname, doorbuy.origin, 128 );
        
        if ( ascenders.size > 0 )
        {
            ascender = ascenders[ 0 ];
            icon = function_b21056d585c710d( zipline_icons, ascender.origin );
            zipline_icons = arrayremove( zipline_icons, icon );
            flag = doorbuy doorbuy::function_f9df5874c38b508a() ? doorbuy.script_power : doorbuy.script_flag_set;
            
            if ( level.var_37c4ad7c326edf2b && doorbuy doorbuy::function_f9df5874c38b508a() )
            {
                icon = undefined;
            }
            
            level thread function_7a7b2235f481ade2( flag, ascender, icon );
        }
    }
    
    foreach ( icon in zipline_icons )
    {
        flag = icon.script_noteworthy;
        
        if ( !flag )
        {
            continue;
        }
        
        level thread function_7a7b2235f481ade2( flag, undefined, icon );
    }
}

// Namespace zm_sat_locust_rb
// Params 0, eflags: 0x4
// Checksum 0xf33dffcc, Offset: 0x5e6
// Size: 0x59
function private function_51253a83bfd9b5a2()
{
    namespace_ed38d631807ab6b0::function_8b6ed56c2aa29c10( [ "zone_lighthouse_int_puzzle", "zone_lighthouse_int_puzzle_3", "zone_lighthouse_int_puzzle_5" ] );
    namespace_ed38d631807ab6b0::function_8b6ed56c2aa29c10( [ "zone_random_room_1", "zone_random_room_2", "zone_random_room_3" ] );
    namespace_ed38d631807ab6b0::function_8b6ed56c2aa29c10( [ "zone_foundry_tower" ] );
}

// Namespace zm_sat_locust_rb
// Params 3, eflags: 0x4
// Checksum 0x5c2c2aa0, Offset: 0x647
// Size: 0xa7
function private function_7a7b2235f481ade2( flag, ascender, icon )
{
    if ( ascender )
    {
        ascender utility::function_32b24db3127bff40( #"top", #"off" );
    }
    
    if ( icon )
    {
        icon utility::function_32b24db3127bff40( #"icon", #"idle" );
    }
    
    utility::flag_wait( flag );
    
    if ( ascender )
    {
        ascender utility::function_32b24db3127bff40( #"top", #"use" );
    }
    
    if ( icon )
    {
        icon utility::function_32b24db3127bff40( #"icon", #"active" );
    }
}

// Namespace zm_sat_locust_rb
// Params 0, eflags: 0x4
// Checksum 0xa630453, Offset: 0x6f6
// Size: 0x12d
function private function_651503fd0befff22()
{
    utility::flag_wait( "wallbuy_ready" );
    
    if ( level.gametypebundle.disablewallbuys )
    {
        return;
    }
    
    random_zones = [ "zone_random_room_1", "zone_random_room_2", "zone_random_room_3" ];
    
    foreach ( var_a2d5c07a0ea12ae in level.var_caf65b937e9cbfaf )
    {
        zone = zone_manager::function_90e5c3e2272b0130( var_a2d5c07a0ea12ae.wallbuy_scriptable.origin );
        
        if ( arraycontains( random_zones, zone.zone_name ) )
        {
            var_a2d5c07a0ea12ae.wallbuy_scriptable utility::ent_flag_wait( "minimap_floor_setup_complete" );
            var_a2d5c07a0ea12ae.wallbuy_scriptable setscriptablepartstate( #"icon", #"idle" );
        }
    }
}

