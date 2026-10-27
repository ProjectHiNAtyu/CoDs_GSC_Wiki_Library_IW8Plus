// script_1b0bae283fe575bc  (hash_1b0bae283fe575bc.gscc) (size: 4989 Bytes / 0x137d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13ea95f (20883807)
// size ...... 4989 (0x137d)
// includes .. 4   (offset: 0x11e5)
// strings ... 31  (offset: 0x1205)
// dev strs .. 0   (offset: 0x137d)
// exports ... 12  (offset: 0xcb1)
// cseg ...... 0x396 + 0x91b (0xcb1)
// imports ... 28  (offset: 0xe91)
// animtree1 . 0   (offset: 0x137d)
// animtree2 . 0   (offset: 0x137d)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_garage;
#using scripts\mp\zm\systems\zm_quest;

#namespace namespace_fb2fddc9bda96b08;

// Namespace namespace_fb2fddc9bda96b08
// Params 0, eflags: 0x5
// Checksum 0xd710b4e1, Offset: 0x3b4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_f24a2976376505e7", undefined, &function_52c0de2564222827, undefined );
}

// Namespace namespace_fb2fddc9bda96b08
// Params 0
// Checksum 0x79a6f7d5, Offset: 0x3d5
// Size: 0xa
function function_52c0de2564222827()
{
    level thread function_58a61b36ef9c5ad5();
}

// Namespace namespace_fb2fddc9bda96b08
// Params 0, eflags: 0x4
// Checksum 0xb0b028a1, Offset: 0x3e7
// Size: 0xca
function private function_58a61b36ef9c5ad5()
{
    level utility::flag_wait( "firefly_zone_unlocks_init" );
    function_7a5efc4b27183745();
    utility::registersharedfunc( #"relics", #"hash_fffe3af0c01c0420", &function_1d65fd6cc3f6a2f );
    utility::registersharedfunc( #"relics", #"hash_c9559b5984f63640", &function_9473bbab030e1ba3 );
    utility::registersharedfunc( #"relics", #"hash_740ebfbd9ecd064f", &function_5c25ba0c39ddfc5a );
    utility::registersharedfunc( #"relics", #"hash_92c4c6c317514acf", &function_ce1aeccb6618b14a );
    utility::registersharedfunc( #"relics", #"hash_e2ca0a7af3d23b7b", &function_2d8889b26dd1237e );
    utility::registersharedfunc( #"relics", #"hash_ef2fe1dfec487c71", &function_1e297b606b2aaa8 );
}

// Namespace namespace_fb2fddc9bda96b08
// Params 0
// Checksum 0x52d992e4, Offset: 0x4b9
// Size: 0x12
function function_2d8889b26dd1237e()
{
    level.wonder_veh thread zm_sat_firefly_script_garage::function_d696b1e2e8b90e1d();
}

// Namespace namespace_fb2fddc9bda96b08
// Params 0
// Checksum 0x44249f0e, Offset: 0x4d3
// Size: 0x1eb
function function_7a5efc4b27183745()
{
    level.var_ce413e678635fd41 = [];
    a_door_trigs = getentarray( "zombie_door", #targetname );
    
    foreach ( trig in a_door_trigs )
    {
        a_power_doors = getentarray( trig.target, "targetname" );
        
        foreach ( door in a_power_doors )
        {
            if ( door.model )
            {
                switch ( door.model )
                {
                    case #"hash_37c2ce1582a5e6d9":
                    case #"hash_da4d820d38d0bcac":
                    case #"hash_e8cc393a5c0be4cf":
                    case #"hash_e8cc3a3a5c0be662":
                        door_struct = { #targetname:door.targetname, #model:door.model, #angles:door.angles, #origin:door.origin };
                        level.var_ce413e678635fd41[ level.var_ce413e678635fd41.size ] = door_struct;
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

// Namespace namespace_fb2fddc9bda96b08
// Params 1
// Checksum 0x48ca1158, Offset: 0x6c6
// Size: 0x125
function function_1d65fd6cc3f6a2f( tier )
{
    level.var_90f55260132d151c = [];
    substr = "farm";
    
    switch ( tier )
    {
        case 1:
            substr = "farm";
            break;
        case 2:
            substr = "launchpad";
            break;
        case 3:
            substr = "lakefront";
            break;
        default:
            break;
    }
    
    if ( level.var_ce413e678635fd41.size > 0 )
    {
        foreach ( door in level.var_ce413e678635fd41 )
        {
            if ( issubstr( door.targetname, substr ) )
            {
                var_c05deaa057ac4a91 = function_c5623e9db95cc4f9( door );
            }
        }
    }
}

// Namespace namespace_fb2fddc9bda96b08
// Params 0
// Checksum 0xd065567c, Offset: 0x7f3
// Size: 0x9e
function function_9473bbab030e1ba3()
{
    if ( level.var_90f55260132d151c.size > 0 )
    {
        foreach ( var_c05deaa057ac4a91 in level.var_90f55260132d151c )
        {
            var_c05deaa057ac4a91 delete();
        }
    }
    
    level.var_90f55260132d151c = function_5713d46873b29625( level.var_90f55260132d151c );
}

// Namespace namespace_fb2fddc9bda96b08
// Params 1
// Checksum 0x10a0832f, Offset: 0x899
// Size: 0xaf
function function_c5623e9db95cc4f9( mdl )
{
    var_281f7aedc7921edd = utility::spawn_model( %"sat_zm_gate_frame_metal_02_relic", mdl.origin, mdl.angles );
    var_62ec925dbe4c59c5 = utility::spawn_model( %"sat_zm_gate_frame_metal_02_relic", mdl.origin + ( 0, 0, 150 ), mdl.angles );
    var_62ec925dbe4c59c5 hide();
    level.var_90f55260132d151c[ level.var_90f55260132d151c.size ] = var_281f7aedc7921edd;
    level.var_90f55260132d151c[ level.var_90f55260132d151c.size ] = var_62ec925dbe4c59c5;
}

// Namespace namespace_fb2fddc9bda96b08
// Params 0
// Checksum 0x65cff744, Offset: 0x950
// Size: 0xef
function function_1e297b606b2aaa8()
{
    if ( level.pap_quest.a_generators )
    {
        level utility::flag_set( "generator_failed_first_time" );
        
        foreach ( var_55a3da08bd6a9a23 in level.pap_quest.a_generators )
        {
            if ( !var_55a3da08bd6a9a23 utility::ent_flag( "infestation_cleared" ) && !var_55a3da08bd6a9a23 utility::ent_flag( "activated" ) && !var_55a3da08bd6a9a23 utility::ent_flag( "cooling_down" ) )
            {
                var_55a3da08bd6a9a23 thread utility::callsharedfunc( #"firefly_pap_quest", #"hash_dd921d8e3237e83a" );
            }
        }
    }
}

// Namespace namespace_fb2fddc9bda96b08
// Params 1
// Checksum 0x60f0f72f, Offset: 0xa47
// Size: 0x235
function function_5c25ba0c39ddfc5a( tier )
{
    level.active_relic_challenge.active_zones = [];
    
    switch ( tier )
    {
        case 1:
            level.active_relic_challenge.active_zones = [ "zone_farm_house", "zone_farm_barn", "zone_farm_garage", "zone_farm_cellar", "zone_farm_outer", "zone_farm_shed", "zone_farm_road", "zone_farm_rear", "zone_farm_gate" ];
            zm_quest::function_fe2a9a31ab8fbcab( level.active_relic_challenge.active_zones );
            utility::callsharedfunc( #"zm_blackhole_bomb", #"hash_a036ff8b4156ec99", level.active_relic_challenge.active_zones );
            break;
        case 2:
            level.active_relic_challenge.active_zones = [ "zone_launchpad_underground", "zone_launchpad_underground_02", "zone_launchpad_maintenance", "zone_launchpad_control_room", "zone_launchpad_rocket", "zone_launchpad_control_side" ];
            zm_quest::function_fe2a9a31ab8fbcab( level.active_relic_challenge.active_zones );
            utility::callsharedfunc( #"zm_blackhole_bomb", #"hash_a036ff8b4156ec99", level.active_relic_challenge.active_zones );
            break;
        case 3:
            level.active_relic_challenge.active_zones = [ "zone_lakefront_cabin", "zone_lakefront_cabin_floor2", "zone_lakefront_path_north", "zone_lakefront_cliffs_south", "zone_lakefront_cliffs_north", "zone_lakefront_toolshed" ];
            zm_quest::function_fe2a9a31ab8fbcab( level.active_relic_challenge.active_zones );
            utility::callsharedfunc( #"zm_blackhole_bomb", #"hash_a036ff8b4156ec99", level.active_relic_challenge.active_zones );
            break;
        default:
            break;
    }
}

// Namespace namespace_fb2fddc9bda96b08
// Params 1
// Checksum 0x9b94c635, Offset: 0xc84
// Size: 0x2d
function function_ce1aeccb6618b14a( tier )
{
    level zm_quest::function_765655c7699f9fb7();
    utility::callsharedfunc( #"zm_blackhole_bomb", #"hash_c75006e0ddcb3da4" );
}

