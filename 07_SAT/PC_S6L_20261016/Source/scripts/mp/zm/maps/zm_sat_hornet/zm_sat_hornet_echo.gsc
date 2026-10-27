// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_echo.gsc  (hash_3f52939883a2b0cd.gscc) (size: 5036 Bytes / 0x13ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20551d9a (542449050)
// size ...... 5036 (0x13ac)
// includes .. 6   (offset: 0x1004)
// strings ... 70  (offset: 0x1034)
// dev strs .. 0   (offset: 0x13ac)
// exports ... 9   (offset: 0xc6c)
// cseg ...... 0x683 + 0x5e9 (0xc6c)
// imports ... 19  (offset: 0xdd4)
// animtree1 . 0   (offset: 0x13ac)
// animtree2 . 0   (offset: 0x13ac)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\doorbuy;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ltm_echo_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_pap_quest;

#namespace zm_sat_hornet_echo;

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x5
// Checksum 0xb3e2d93, Offset: 0x6a1
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"hash_57d064258c711271", undefined, &pre_main, &post_main );
}

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x4
// Checksum 0x863deaa8, Offset: 0x6c6
// Size: 0x14b
function private pre_main()
{
    if ( game_utility::getgametype() != "zm_rb_echo" )
    {
        return;
    }
    
    level.var_2add2332a4635bbb = { #var_82ea5be5455d5401:[ "zombie_ghoul_hvt", "zombie_amalgam", "zombie_viper_hvt", "zombie_callisto_hvt", "zombie_abom_hvt", "zombie_mimic_hvt_emp", "zombie_karkinos_hvt", "zombie_orion_hvt" ], #var_b6f7856c65e288f9:&function_40a8cdcf73ba0de, #var_1ea74a4676fa9871:%"hash_3d45f1248a3c50b9", #var_d23b400600effd18:1, #var_f2ca359ba559c822:1, #var_fa13ef47a8925257:0, #var_8eac6e744e8c5bf1:function_1453b50f4841a1d8(), #var_ecaa27f35aef5b3c:%"hash_758c67bd26e92579", #var_4aa676077979d1dd:"boss", #var_8074703df595efae:"outerward", #var_bcf87c357a7634ec:[ "outerward", "stables", "training", "central", "garden", "kitchens", "baths", "castle" ], #create_script_func:&zm_sat_hornet_ltm_echo_cs::main };
}

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x4
// Checksum 0x76db2f76, Offset: 0x819
// Size: 0x43
function private post_main()
{
    if ( game_utility::getgametype() != "zm_rb_echo" )
    {
        return;
    }
    
    function_6ebd8786cfe99ac();
    level utility::flag_wait( "scriptables_ready" );
    level thread function_bb25aae404581b82();
    level thread function_37a4ad6da36482d4();
    level utility::flag_set( "force_traps_on" );
}

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x4
// Checksum 0x92fcbe3, Offset: 0x864
// Size: 0x1af
function private function_1453b50f4841a1d8()
{
    var_e1d246124da6bf1d = [];
    var_e1d246124da6bf1d[ "outerward" ] = [ "zone_lava_tubes_start_a", "zone_lava_tubes_start_b", "zone_lava_tubes_start_c", "zone_third_bailey_east_a", "zone_third_bailey_east_b" ];
    var_e1d246124da6bf1d[ "stables" ] = [ "zone_third_bailey_west_a", "zone_third_bailey_west_b", "zone_west_bailey_a", "zone_west_bailey_b" ];
    var_e1d246124da6bf1d[ "training" ] = [ "zone_broken_turrets_a", "zone_broken_turrets_b", "zone_broken_turrets_c", "zone_broken_turrets_d" ];
    var_e1d246124da6bf1d[ "central" ] = [ "zone_main_bailey_a", "zone_main_bailey_b", "zone_main_bailey_c", "zone_main_bailey_d" ];
    var_e1d246124da6bf1d[ "garden" ] = [ "zone_lava_garden_a", "zone_lava_garden_b", "zone_lava_garden_c" ];
    var_e1d246124da6bf1d[ "kitchens" ] = [ "zone_second_bailey_a", "zone_second_bailey_b", "zone_second_bailey_c", "zone_second_bailey_d" ];
    var_e1d246124da6bf1d[ "baths" ] = [ "zone_main_keep_east_path_a", "zone_main_keep_east_path_b", "zone_main_keep_a", "zone_main_keep_b", "zone_main_keep_c", "zone_main_keep_a_eave", "zone_main_keep_b_eave", "zone_main_keep_wall_jump_zone_02_eave" ];
    var_e1d246124da6bf1d[ "castle" ] = [ "zone_main_keep_west_path_a", "zone_main_keep_west_path_b", "zone_main_keep_2nd_floor_a", "zone_main_keep_2nd_floor_b", "zone_main_keep_2nd_floor_c", "zone_main_keep_2nd_floor_d" ];
    return var_e1d246124da6bf1d;
}

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x4
// Checksum 0x191e1482, Offset: 0xa1c
// Size: 0x2
function private function_40a8cdcf73ba0de()
{
    
}

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x4
// Checksum 0x4d63bdc0, Offset: 0xa26
// Size: 0xf7
function private function_6ebd8786cfe99ac()
{
    level utility::flag_wait( "doorbuy_init_complete" );
    var_18e8e2672d73f61e = getentarray( "zombie_door", "targetname" );
    door_flags = [];
    door_flags[ door_flags.size ] = "door_start_to_third_bailey_east";
    door_flags[ door_flags.size ] = "door_third_bailey_to_west_bailey";
    door_flags[ door_flags.size ] = "door_main_bailey_to_main_keep_east_path";
    door_flags[ door_flags.size ] = "door_main_keep_left_path_to_main_keep2";
    
    foreach ( door in var_18e8e2672d73f61e )
    {
        if ( !isdefined( door.script_flag_set ) )
        {
            continue;
        }
        
        if ( arraycontains( door_flags, door.script_flag_set ) )
        {
            door doorbuy::doorbuy_used();
        }
    }
}

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x4
// Checksum 0x7f6d6dac, Offset: 0xb25
// Size: 0x16
function private function_bb25aae404581b82()
{
    level endon( #"game_ended" );
    level thread zm_sat_hornet_pap_quest::power_doors_manage();
}

// Namespace zm_sat_hornet_echo
// Params 0, eflags: 0x4
// Checksum 0xe66e33c0, Offset: 0xb43
// Size: 0x129
function private function_37a4ad6da36482d4()
{
    level utility::flag_wait( "begin_round_logic" );
    doors = getentitylessscriptablearray( "doorbuy_door_1b", #targetname );
    
    foreach ( door in doors )
    {
        door setscriptablepartstate( "icon", "hide" );
    }
    
    doors = getentitylessscriptablearray( "doorbuy_door_15", #targetname );
    
    foreach ( door in doors )
    {
        door setscriptablepartstate( "icon", "hide" );
    }
}

