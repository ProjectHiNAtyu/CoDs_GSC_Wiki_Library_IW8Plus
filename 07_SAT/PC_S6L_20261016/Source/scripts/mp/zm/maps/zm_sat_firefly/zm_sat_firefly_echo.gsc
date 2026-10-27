// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_echo.gsc  (hash_0d8feba937f84bbb.gscc) (size: 5820 Bytes / 0x16bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x72b632f0 (1924543216)
// size ...... 5820 (0x16bc)
// includes .. 3   (offset: 0x1250)
// strings ... 78  (offset: 0x1268)
// dev strs .. 0   (offset: 0x16bc)
// exports ... 6   (offset: 0xfa0)
// cseg ...... 0x70a + 0x896 (0xfa0)
// imports ... 15  (offset: 0x1090)
// animtree1 . 0   (offset: 0x16bc)
// animtree2 . 0   (offset: 0x16bc)
#using scripts\common\system;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_ltm_echo_cs;

#namespace zm_sat_firefly_echo;

// Namespace zm_sat_firefly_echo
// Params 0, eflags: 0x5
// Checksum 0x3a842696, Offset: 0x728
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_57d064258c711271", undefined, &pre_main, undefined );
}

// Namespace zm_sat_firefly_echo
// Params 0, eflags: 0x4
// Checksum 0xa51e3d5d, Offset: 0x749
// Size: 0x19d
function private pre_main()
{
    if ( game_utility::getgametype() != "zm_rb_echo" )
    {
        return;
    }
    
    n_boss_variant = getdvarint( @"zm_echo_boss_variant", 0 );
    level.var_2add2332a4635bbb = { #var_82ea5be5455d5401:function_4434943dbdc40ae0( n_boss_variant ), #var_1ea74a4676fa9871:%"hash_3d45f1248a3c50b9", #var_d23b400600effd18:1, #var_f2ca359ba559c822:1, #var_fa13ef47a8925257:1, #var_b6f7856c65e288f9:&function_eb7329668fe591e5, #var_83677ce04289f250:"firefly_zone_unlocks_init", #str_boss_zone:"zone_boss_arena", #var_7a3684a13718a7:[ "disable_firefly_plant_ee", "disable_firefly_bullseye_ee" ], #var_8eac6e744e8c5bf1:function_1453b50f4841a1d8(), #var_ecaa27f35aef5b3c:%"hash_758c67bd26e92579", #var_faa951df3f188328:[ "boss2", "janus2", "farm2", "ashwood2", "zarya2", "diner2", "lake2" ], #var_4aa676077979d1dd:"boss", #var_8074703df595efae:"janus", #var_bcf87c357a7634ec:[ "boss", "janus", "farm", "ashwood", "zarya", "diner", "lake" ], #create_script_func:&namespace_65df58d93fd17d95::main };
}

// Namespace zm_sat_firefly_echo
// Params 1, eflags: 0x4
// Checksum 0xffb6b252, Offset: 0x8ee
// Size: 0x122
function private function_4434943dbdc40ae0( var_23d56965a546c812 )
{
    switch ( var_23d56965a546c812 )
    {
        case 1:
            return [ "zombie_amalgam", "zombie_viper", "zombie_callisto_hvt", "zombie_abom" ];
        case 2:
            return [ "zombie_ghoul_hvt", "zombie_viper", "zombie_callisto_hvt", "zombie_abom" ];
        case 3:
            return [ "zombie_ghoul_hvt", "zombie_amalgam", "zombie_viper", "zombie_callisto_hvt" ];
        case 4:
            return [ "zombie_ghoul_hvt", "zombie_amalgam", "zombie_viper", "zombie_callisto_hvt", "zombie_abom" ];
        default:
            return [ "zombie_ghoul_hvt", "zombie_amalgam", "zombie_viper", "zombie_callisto_hvt", "zombie_abom" ];
    }
}

// Namespace zm_sat_firefly_echo
// Params 0, eflags: 0x4
// Checksum 0xa9819fe2, Offset: 0xa18
// Size: 0x284
function private function_1453b50f4841a1d8()
{
    var_e1d246124da6bf1d = [];
    var_e1d246124da6bf1d[ "janus" ] = [ "zone_jplaza", "zone_jplaza_close_to_monolith", "zone_jplaza_close_to_ts_tower", "zone_jplaza_ramp", "zone_jplaza_roundabout", "zone_janus_warehouse" ];
    var_e1d246124da6bf1d[ "farm" ] = [ "zone_farm", "zone_farm_barn", "zone_farm_close_to_sunken", "zone_farm_close_to_tower", "zone_farm_garage", "zone_farm_gate", "zone_farm_house", "zone_farm_road" ];
    var_e1d246124da6bf1d[ "lake" ] = [ "zone_lakefront", "zone_lakefront_cabin", "zone_lakefront_cabin_floor2", "zone_lakefront_cliffs_north", "zone_lakefront_cliffs_south", "zone_lakefront_path_north", "zone_lakefront_path_south" ];
    var_e1d246124da6bf1d[ "ashwood" ] = [ "zone_sunken", "zone_sunken_brothel", "zone_sunken_brothel_exterior", "zone_sunken_brothel_shops", "zone_sunken_north", "zone_sunken_platform_close_to_brothel", "zone_sunken_sheriff_exterior", "zone_sunken_shops_exterior", "zone_sunken_shops_interior", "zone_sunken_shops_mercantile", "zone_sunken_shops_zipline", "zone_sunken_south" ];
    var_e1d246124da6bf1d[ "diner" ] = [ "zone_exit115", "zone_exit115_close_to_launchpad", "zone_exit115_close_to_sunken", "zone_exit115_diner", "zone_exit115_diner_roof", "zone_exit115_gas", "zone_exit115_gas_roof", "zone_exit115_pump_roof" ];
    var_e1d246124da6bf1d[ "zarya" ] = [ "zone_launchpad", "zone_launchpad_close_to_exit115", "zone_launchpad_close_to_sunken", "zone_launchpad_control_side", "zone_launchpad_maintenance", "zone_launchpad_maintenance_side", "zone_launchpad_rocket", "zone_launchpad_underground", "zone_launchpad_underground_02" ];
    var_e1d246124da6bf1d[ "boss" ] = [ "zone_boss_arena" ];
    var_e1d246124da6bf1d[ "janus2" ] = var_e1d246124da6bf1d[ "janus" ];
    var_e1d246124da6bf1d[ "farm2" ] = var_e1d246124da6bf1d[ "farm" ];
    var_e1d246124da6bf1d[ "lake2" ] = var_e1d246124da6bf1d[ "lake" ];
    var_e1d246124da6bf1d[ "ashwood2" ] = var_e1d246124da6bf1d[ "ashwood" ];
    var_e1d246124da6bf1d[ "zarya2" ] = var_e1d246124da6bf1d[ "zarya" ];
    var_e1d246124da6bf1d[ "diner2" ] = var_e1d246124da6bf1d[ "diner" ];
    var_e1d246124da6bf1d[ "boss2" ] = var_e1d246124da6bf1d[ "boss" ];
    return var_e1d246124da6bf1d;
}

// Namespace zm_sat_firefly_echo
// Params 0, eflags: 0x4
// Checksum 0x3dbae5c4, Offset: 0xca5
// Size: 0x2fb
function private function_eb7329668fe591e5()
{
    wait 0.5;
    a_door_triggers = getnoentvolumearray( "pap_wood_barrier_trig", #targetname );
    
    foreach ( trig in a_door_triggers )
    {
        foreach ( scriptable in trig.a_door_sbls )
        {
            scriptable setscriptablepartstate( "icon", "off" );
        }
        
        e_hint = getent( trig.target, #target );
        
        if ( e_hint )
        {
            e_hint delete();
        }
    }
    
    if ( !isdefined( level.var_e5ccbf542c55e9dd ) )
    {
        return;
    }
    
    foreach ( trig in level.var_e5ccbf542c55e9dd )
    {
        foreach ( sbl in trig.a_door_sbls )
        {
            sbl setscriptablepartstate( "icon", "off" );
        }
        
        e_hint = getent( trig.target, #target );
        
        if ( e_hint )
        {
            e_hint delete();
        }
        
        a_doors = getentarray( trig.target, "targetname" );
        
        foreach ( door in a_doors )
        {
            if ( door.minimap_scriptable )
            {
                door.minimap_scriptable freescriptable();
            }
        }
    }
}

