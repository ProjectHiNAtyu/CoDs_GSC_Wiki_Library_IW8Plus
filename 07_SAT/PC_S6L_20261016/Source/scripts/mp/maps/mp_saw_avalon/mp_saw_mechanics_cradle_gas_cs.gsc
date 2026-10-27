// scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_cradle_gas_cs.gsc  (hash_73e4e47f896b8240.gscc) (size: 2616 Bytes / 0xa38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3cf72482 (1022829698)
// size ...... 2616 (0xa38)
// includes .. 2   (offset: 0x91c)
// strings ... 14  (offset: 0x92c)
// dev strs .. 0   (offset: 0xa38)
// exports ... 6   (offset: 0x66c)
// cseg ...... 0x201 + 0x46b (0x66c)
// imports ... 16  (offset: 0x75c)
// animtree1 . 0   (offset: 0xa38)
// animtree2 . 0   (offset: 0xa38)
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_mechanics_cradle_gas_cs;

// Namespace mp_saw_mechanics_cradle_gas_cs
// Params 2
// Checksum 0x94cca410, Offset: 0x21f
// Size: 0x80
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_mechanics_cradle_gas_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_mechanics_cradle_gas_cs" ) )
    {
        return;
    }
    
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_mechanics_cradle_gas_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_mechanics_cradle_gas_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_mechanics_cradle_gas_cs
// Params 3, eflags: 0x4
// Checksum 0xa7a74696, Offset: 0x2a7
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_mechanics_cradle_gas_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_mechanics_cradle_gas_cs" );
}

// Namespace mp_saw_mechanics_cradle_gas_cs
// Params 3, eflags: 0x4
// Checksum 0xf42fd0d2, Offset: 0x321
// Size: 0x32b
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_cradle_gas_cs";
    s.activity_bundle = "saw_activity_bongo_cradle_gas_bomb";
    s.name = "CRADLE_GAS_MAGICBOX_RIGHT";
    fe [[ f ]]( s, us, cf, ( 840, -2112, -520 ), ( 0, 0, 0 ), "activity_nexus_variant", "CRADLE_GAS_MAGICBOX_RIGHT", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_cradle_gas_cs";
    s.name = "CRADLE_GAS_MAGICBOX_RIGHT_MISSILE_IMPACT";
    fe [[ f ]]( s, us, cf, ( 1160, -2112, -520 ), ( 0, -90, 0 ), "CRADLE_GAS_MAGICBOX_RIGHT", undefined, "missile_impact", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_cradle_gas_cs";
    s.activity_bundle = "saw_activity_bongo_cradle_gas_bomb";
    s.name = "CRADLE_GAS_MAGICBOX_LEFT";
    fe [[ f ]]( s, us, cf, ( 552, -2112, -520 ), ( 0, 0, 0 ), "activity_nexus_variant", "CRADLE_GAS_MAGICBOX_LEFT", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_cradle_gas_cs";
    s.name = "CRADLE_GAS_MAGICBOX_LEFT_missile_impact";
    fe [[ f ]]( s, us, cf, ( 224, -2112, -520 ), ( 0, 90, 0 ), "CRADLE_GAS_MAGICBOX_LEFT", undefined, "missile_impact", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_cradle_gas_cs";
    s.activity_bundle = "saw_activity_bongo_cradle_gas_bomb_mangler";
    s.name = "CRADLE_GAS_MANGLER_CENTER";
    fe [[ f ]]( s, us, cf, ( 712, -2792, -520 ), ( 0, 0, 0 ), "activity_nexus_variant", "CRADLE_GAS_MANGLER_CENTER", undefined, "activity_link", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_cradle_gas_cs";
    s.name = "CRADLE_GAS_MANGLER_CENTER_missile_impact";
    fe [[ f ]]( s, us, cf, ( 712, -2792, -520 ), ( 0, 0, 0 ), "CRADLE_GAS_MANGLER_CENTER", undefined, "missile_impact", undefined, undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_mechanics_cradle_gas_cs
// Params 0, eflags: 0x4
// Checksum 0xe5e0661c, Offset: 0x654
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_mechanics_cradle_gas_cs
// Params 0
// Checksum 0x65f49bdb, Offset: 0x65e
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_mechanics_cradle_gas_cs" );
}

