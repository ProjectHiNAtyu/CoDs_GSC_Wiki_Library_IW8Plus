// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_quest_ee_scarf_cs.gsc  (hash_793dedb5e0e1643c.gscc) (size: 9510 Bytes / 0x2526 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x23d33566 (601044326)
// size ...... 9510 (0x2526)
// includes .. 3   (offset: 0x1f92)
// strings ... 56  (offset: 0x1faa)
// dev strs .. 0   (offset: 0x2526)
// exports ... 9   (offset: 0x1bfa)
// cseg ...... 0x60d + 0x15ed (0x1bfa)
// imports ... 20  (offset: 0x1d62)
// animtree1 . 0   (offset: 0x2526)
// animtree2 . 0   (offset: 0x2526)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_sat_mantis_quest_ee_scarf_cs;

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 0, eflags: 0x5
// Checksum 0x8c3f84, Offset: 0x62b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_mantis_quest_ee_scarf_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 0, eflags: 0x4
// Checksum 0xf1a97979, Offset: 0x64c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 0, eflags: 0x4
// Checksum 0x7492aa95, Offset: 0x65d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 2
// Checksum 0xc47bfcdc, Offset: 0x66e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "zm_sat_mantis_quest_ee_scarf_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "zm_sat_mantis_quest_ee_scarf_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "zm_sat_mantis_quest_ee_scarf_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "zm_sat_mantis_quest_ee_scarf_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 3, eflags: 0x4
// Checksum 0xf7101e5a, Offset: 0x6f6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "zm_sat_mantis_quest_ee_scarf_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "zm_sat_mantis_quest_ee_scarf_cs" );
}

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 3, eflags: 0x4
// Checksum 0xfac40d5, Offset: 0x770
// Size: 0x146a
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "sprite_path";
    fe [[ f ]]( s, us, cf, ( 76552, -31784, 368 ), ( 0, 30, 0 ), "cspf_0_auto10951368599261182218", "cspf_0_auto15883301496953383126" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.name = "Interact";
    fe [[ f ]]( s, us, cf, ( 77667, -30309, 26 ), ( 0, 30, 0 ), undefined, undefined, "scarf_ee_interact" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "sprite_path";
    fe [[ f ]]( s, us, cf, ( 76272, -33016, 368 ), ( 0, 45, 0 ), undefined, "cspf_0_auto10951368599261182218", "scarf_ee_sprite_start" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "sprite_path";
    fe [[ f ]]( s, us, cf, ( 77248, -30824, 368 ), ( 0, 30, 0 ), "cspf_0_auto15883301496953383126", "cspf_0_auto16955789887636357486" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "sprite_path";
    fe [[ f ]]( s, us, cf, ( 77664, -30312, 15 ), ( 0, 30, 0 ), "cspf_0_auto16955789887636357486" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 77744, -30072, 72 ), ( 0, 105, 0 ), "cspf_0_auto1297338328619463591", "cspf_0_auto9931265552526129415" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "start";
    fe [[ f ]]( s, us, cf, ( 77670, -30307, 72 ), ( 0, 90, 0 ), "cspf_0_auto18212518454477297777", "cspf_0_auto1297338328619463591" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 77440, -29960, 72 ), ( 0, 210, 0 ), "cspf_0_auto9931265552526129415", "cspf_0_auto14318300344895587775" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_label = "scarf_1st_beat_node";
    fe [[ f ]]( s, us, cf, ( 77187, -30123, -69.83 ), ( 0, 195, 0 ), "cspf_0_auto14318300344895587775", "cspf_0_auto1853601156740084392" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 77232, -30496, -72 ), ( 0, 300, 0 ), "cspf_0_auto1853601156740084392", "cspf_0_auto2032318278503696254" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 77400, -30840, -72 ), ( 0, 0, 0 ), "cspf_0_auto2032318278503696254", "cspf_0_auto6365868659312902528" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 77722, -30836, -72 ), ( 0, 0, 0 ), "cspf_0_auto6365868659312902528", "cspf_0_auto15081057686928638578" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_label = "scarf_2nd_beat_node";
    fe [[ f ]]( s, us, cf, ( 78910, -31208, -72 ), ( 0, 330, 0 ), "cspf_0_auto5641403414069460960", "cspf_0_auto10348806575076971936" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 78496, -30760, -72 ), ( 0, 0, 0 ), "cspf_0_auto15081057686928638578", "cspf_0_auto5641403414069460960" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 79032, -31000, -72 ), ( 0, 330, 0 ), "cspf_0_auto10348806575076971936", "cspf_0_auto17890135606107728640" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 79392, -31280, -72 ), ( 0, 270, 0 ), "cspf_0_auto17890135606107728640", "cspf_0_auto13859003745580547613" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 79312, -31704, -72 ), ( 0, 240, 0 ), "cspf_0_auto13859003745580547613", "cspf_0_auto16209773021038424062" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 79168, -31960, 72 ), ( 0, 135, 0 ), "cspf_0_auto16209773021038424062", "cspf_0_auto11093961931050431334" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 78960, -31728, 72 ), ( 0, 45, 0 ), "cspf_0_auto11093961931050431334", "cspf_0_auto11082335106772461866" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 79040, -31600, 98 ), ( 0, 250, 0 ), "cspf_0_auto12447045488045918850", "cspf_0_auto11449023550096535882" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 77176, -30184, -125 ), ( 0, 0, 0 ), "cspf_0_auto47328139781407770" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 76968, -29832, -130.85 ), ( 0, 0, 0 ), "cspf_0_auto47328139781407770" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    fe [[ f ]]( s, us, cf, ( 77264, -30016, 68.17 ), ( 0, 0, 0 ), "scarf_1st_beat_node_spawner", "cspf_0_auto47328139781407770" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 77368, -29928, -121 ), ( 0, 0, 0 ), "cspf_0_auto47328139781407770" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 77184, -29808, -126.37 ), ( 0, 0, 0 ), "cspf_0_auto47328139781407770" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 77200, -29976, -121 ), ( 0, 0, 0 ), "cspf_0_auto47328139781407770" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78648, -31240, -125 ), ( 0, 0, 0 ), "cspf_0_auto5129221884317453236" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.name = "scarf";
    fe [[ f ]]( s, us, cf, ( 77672, -30304, 16 ), ( 331, 340, 64 ), undefined, "cspf_0_auto18212518454477297777", "scarf_ee_item" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78552, -31096, -130.85 ), ( 0, 0, 0 ), "cspf_0_auto5129221884317453236" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    fe [[ f ]]( s, us, cf, ( 78736, -31072, 68.17 ), ( 0, 0, 0 ), "scarf_2nd_beat_node_spawner", "cspf_0_auto5129221884317453236" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78824, -30888, -121 ), ( 0, 0, 0 ), "cspf_0_auto5129221884317453236" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78720, -30984, -126.37 ), ( 0, 0, 0 ), "cspf_0_auto5129221884317453236" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78792, -31128, -121 ), ( 0, 0, 0 ), "cspf_0_auto5129221884317453236" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 79312, -31712, -120.74 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78408, -31480, -125.5 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    fe [[ f ]]( s, us, cf, ( 78824, -31664, 108.17 ), ( 0, 0, 0 ), "scarf_3rd_beat_node_spawner", "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78616, -31568, -121 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78624, -31696, -121 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78752, -31544, -121 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_label = "phase_3";
    fe [[ f ]]( s, us, cf, ( 79038.9, -31603.7, 16 ), ( 0, 240.5, 0 ), undefined, "cspf_0_auto11345818389389048921", "scarf_mannequin_body" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_label = "scarf_final_beat_node";
    fe [[ f ]]( s, us, cf, ( 79040.4, -31600.9, 78 ), ( 0, 245.5, 0 ), "cspf_0_auto11449023550096535882" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_label = "phase_2";
    fe [[ f ]]( s, us, cf, ( 78932.5, -31224.3, -121 ), ( 0, 340, 0 ), undefined, "cspf_0_auto18015717077983671257", "scarf_mannequin_body" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_parameters = "right";
    fe [[ f ]]( s, us, cf, ( 77164, -30129, -66 ), ( 0, 180, 0 ), "cspf_0_auto2863640452036416198" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_parameters = "left";
    fe [[ f ]]( s, us, cf, ( 77164, -30140, -66 ), ( 0, 180, 0 ), "cspf_0_auto2863640452036416198" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_label = "phase_1";
    fe [[ f ]]( s, us, cf, ( 77161, -30135, -125 ), ( 0, 180, 0 ), undefined, "cspf_0_auto2863640452036416198", "scarf_mannequin_body" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_parameters = "right";
    fe [[ f ]]( s, us, cf, ( 78927.9, -31227.7, -65 ), ( 0, 340, 0 ), "cspf_0_auto18015717077983671257" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_parameters = "left";
    fe [[ f ]]( s, us, cf, ( 78931.4, -31218.1, -65 ), ( 0, 340, 0 ), "cspf_0_auto18015717077983671257" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_parameters = "right";
    fe [[ f ]]( s, us, cf, ( 79035, -31597, 73 ), ( 0, 240.5, 0 ), "cspf_0_auto11345818389389048921" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.script_parameters = "left";
    fe [[ f ]]( s, us, cf, ( 79046, -31603.9, 73 ), ( 0, 240.5, 0 ), "cspf_0_auto11345818389389048921" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    s.script_label = "scarf_3rd_beat_node";
    s.script_parameters = "1";
    fe [[ f ]]( s, us, cf, ( 79024, -31624, 72 ), ( 0, 45, 0 ), "cspf_0_auto11082335106772461866", "cspf_0_auto12447045488045918850" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78648, -31560, 16 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78912, -31880, 16 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 79120, -31880, 24.06 ), ( 0, 0, 0 ), "cspf_0_auto8666237841787004753" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "spawner";
    s.script_animation = "spawn_portal";
    fe [[ f ]]( s, us, cf, ( 78632, -30928, -124.66 ), ( 0, 0, 0 ), "cspf_0_auto5129221884317453236" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 77195, -30120, -120.31 ), ( 360, 285, 91.5 ), undefined, undefined, "scarf_1st_beat_node_drop" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 78904, -31208, -118 ), ( 360, 60, 90 ), undefined, undefined, "scarf_2nd_beat_node_drop" );
    s = {};
    s.script_cs_flag = "zm_sat_mantis_quest_ee_scarf_cs";
    s.groupid = "scarf_path";
    fe [[ f ]]( s, us, cf, ( 79020, -31628, 18 ), ( 360, 150, 90 ), undefined, undefined, "scarf_3rd_beat_node_drop" );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 0, eflags: 0x4
// Checksum 0x7a48d152, Offset: 0x1be2
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace zm_sat_mantis_quest_ee_scarf_cs
// Params 0
// Checksum 0x3543c317, Offset: 0x1bec
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "zm_sat_mantis_quest_ee_scarf_cs" );
}

