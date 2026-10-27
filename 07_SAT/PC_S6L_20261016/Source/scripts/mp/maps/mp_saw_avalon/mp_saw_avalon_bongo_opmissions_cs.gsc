// scripts\mp\maps\mp_saw_avalon\mp_saw_avalon_bongo_opmissions_cs.gsc  (hash_1498918c07119f5f.gscc) (size: 2726 Bytes / 0xaa6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xadeb8702 (2917893890)
// size ...... 2726 (0xaa6)
// includes .. 3   (offset: 0x9f6)
// strings ... 6   (offset: 0xa0e)
// dev strs .. 0   (offset: 0xaa6)
// exports ... 9   (offset: 0x65e)
// cseg ...... 0x10d + 0x551 (0x65e)
// imports ... 20  (offset: 0x7c6)
// animtree1 . 0   (offset: 0xaa6)
// animtree2 . 0   (offset: 0xaa6)
#using scripts\common\create_script_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace mp_saw_avalon_bongo_opmissions_cs;

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 0, eflags: 0x5
// Checksum 0x6d623f1b, Offset: 0x12b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mp_saw_avalon_bongo_opmissions_cs", undefined, &function_b39ecd3d51489472, undefined );
}

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 0, eflags: 0x4
// Checksum 0xe1935a9d, Offset: 0x14c
// Size: 0x9
function private function_b39ecd3d51489472()
{
    thread structs_init();
}

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 0, eflags: 0x4
// Checksum 0x64a88971, Offset: 0x15d
// Size: 0x9
function private structs_init()
{
    main();
}

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 2
// Checksum 0xd441df38, Offset: 0x16e
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_avalon_bongo_opmissions_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_avalon_bongo_opmissions_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_avalon_bongo_opmissions_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_avalon_bongo_opmissions_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 3, eflags: 0x4
// Checksum 0xe72a3dbe, Offset: 0x1f6
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_avalon_bongo_opmissions_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_avalon_bongo_opmissions_cs" );
}

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 3, eflags: 0x4
// Checksum 0x9b938b62, Offset: 0x270
// Size: 0x3ce
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( -41300.5, 11207.5, 460 ), ( 0, 270, 0 ), "brloot_mission_character_mason03_shirt", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( -36644, 9068, 456 ), ( 0, 0, 0 ), "brloot_mission_character_mason03_shirt", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( -40736, 8080, 656 ), ( 0, 180, 0 ), "brloot_mission_character_mason03_shirt", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( -41203, 14733, 458 ), ( 0, 90, 0 ), "brloot_mission_character_mason03_shirt", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( -37588, 16004, 469 ), ( 0, 270, 0 ), "brloot_mission_character_mason03_shirt", undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( 0, 0, 0 ), ( 0, 0, 0 ), undefined, undefined, undefined, undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_avalon_bongo_opmissions_cs";
    fe [[ f ]]( s, us, cf, ( 31360, -51417, 1155.38 ), ( 0, 315, 0 ), "wz_dog_tag_collectable_entityless", undefined, "OPERATOR_MISSION_8_DOG_TAG_SPAWN", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 0, eflags: 0x4
// Checksum 0xae2d24b1, Offset: 0x646
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_avalon_bongo_opmissions_cs
// Params 0
// Checksum 0x2579e0f3, Offset: 0x650
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_avalon_bongo_opmissions_cs" );
}

