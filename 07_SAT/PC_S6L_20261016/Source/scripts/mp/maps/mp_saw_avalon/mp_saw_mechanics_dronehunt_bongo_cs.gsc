// scripts\mp\maps\mp_saw_avalon\mp_saw_mechanics_dronehunt_bongo_cs.gsc  (hash_7205ecdd81d5e6ae.gscc) (size: 2305 Bytes / 0x901 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ac4265c (2328110684)
// size ...... 2305 (0x901)
// includes .. 3   (offset: 0x879)
// strings ... 5   (offset: 0x891)
// dev strs .. 0   (offset: 0x901)
// exports ... 10  (offset: 0x47d)
// cseg ...... 0xca + 0x3b3 (0x47d)
// imports ... 22  (offset: 0x60d)
// animtree1 . 0   (offset: 0x901)
// animtree2 . 0   (offset: 0x901)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\create_script_utility;
#using scripts\common\utility;

#namespace mp_saw_mechanics_dronehunt_bongo_cs;

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 2
// Checksum 0xac669235, Offset: 0xe8
// Size: 0x8c
function main( unused, unused2 )
{
    if ( utility::flag_exist( "mp_saw_mechanics_dronehunt_bongo_cs" ) )
    {
        return;
    }
    
    if ( !create_script_utility::filter( "mp_saw_mechanics_dronehunt_bongo_cs" ) )
    {
        return;
    }
    
    activity_common::function_e1df676808c1d1e3( &function_4cd78e661617f3 );
    us = create_script_utility::function_4579dd5df27ceeca();
    utility::flag_init( "mp_saw_mechanics_dronehunt_bongo_cs" );
    s = {};
    level thread cs_return_and_wait_for_flag( us, s, "mp_saw_mechanics_dronehunt_bongo_cs" );
    
    if ( !create_script_utility::cs_is_starttime() )
    {
        create_script_utility::endcreatescript( s );
    }
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 3, eflags: 0x4
// Checksum 0xabe171ba, Offset: 0x17c
// Size: 0x72
function private cs_return_and_wait_for_flag( us, s, cf )
{
    level endon( #"game_ended" );
    create_script_utility::wait_for_cs_flag( cf );
    
    if ( !isdefined( us ) )
    {
        us = "pfx";
    }
    
    s create_script_utility::cs_setup_arrays( us, "mp_saw_mechanics_dronehunt_bongo_cs" );
    create_script_utility::cs_flags_init( s );
    level thread createstructs( s, us, cf );
    level thread create_script_utility::wait_for_flags( s, "mp_saw_mechanics_dronehunt_bongo_cs" );
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 3, eflags: 0x4
// Checksum 0x2697dad3, Offset: 0x1f6
// Size: 0xcd
function private createstructs( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
    s = {};
    s.script_cs_flag = "mp_saw_mechanics_dronehunt_bongo_cs";
    s.activity_bundle = "saw_activity_bongo_drone_hunt";
    s.name = "BONGO_DEV";
    fe [[ f ]]( s, "BONGO_DEV", cf, ( -104, -336, -144 ), ( 0, 0, 0 ), undefined, undefined, undefined, "BONGO_DEV", undefined, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    fe utility::ent_flag_set( "cs_objects_created" );
    function_75f4a755dfd427b6();
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 0, eflags: 0x4
// Checksum 0xbbe22678, Offset: 0x2cb
// Size: 0x2
function private function_75f4a755dfd427b6()
{
    
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 0
// Checksum 0x69b2acf7, Offset: 0x2d5
// Size: 0xe
function cleanup()
{
    create_script_utility::cleanup_cs_file_structs( "mp_saw_mechanics_dronehunt_bongo_cs" );
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 0
// Checksum 0xbd97a656, Offset: 0x2eb
// Size: 0x44
function function_4cd78e661617f3()
{
    activityinfostruct = {};
    activityinfostruct.mainfunction = &main;
    activityinfostruct.var_934f068483ae4ddb = &function_d4323822d7042e5a;
    activityinfostruct.metadatafunction = &function_d9dd7965c51c95d1;
    return activityinfostruct;
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 4
// Checksum 0x2a16ba5f, Offset: 0x338
// Size: 0x57
function function_d4323822d7042e5a( var_4312b79c960726b6, fe, us, cf = "mp_saw_mechanics_dronehunt_bongo_cs" )
{
    switch ( var_4312b79c960726b6 )
    {
        case #"hash_ee77f8230ec2bcc2":
            function_3e1007cd30dde0ea( fe, us, cf );
            break;
    }
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 3
// Checksum 0x700588b7, Offset: 0x397
// Size: 0x2f
function function_3e1007cd30dde0ea( fe, us, cf )
{
    f = &create_script_utility::strike_additem;
}

// Namespace mp_saw_mechanics_dronehunt_bongo_cs
// Params 0
// Checksum 0x33a0e169, Offset: 0x3ce
// Size: 0xae
function function_d9dd7965c51c95d1()
{
    activityinstances = [];
    var_881289d7987bc770 = {};
    var_881289d7987bc770.scriptbundle = "saw_activity_bongo_drone_hunt";
    var_881289d7987bc770.cf = "mp_saw_mechanics_dronehunt_bongo_cs";
    var_881289d7987bc770.scriptstructorigin = ( -104, -336, -144 );
    var_881289d7987bc770.scriptstructoriginoffset = ( 0, 0, 0 );
    var_881289d7987bc770.locationorigin = [];
    var_881289d7987bc770.var_31ce4477e3543d24 = [];
    var_881289d7987bc770.var_ccd7cc494eeab31b = [];
    var_881289d7987bc770.locationradius = [];
    activityinstances[ "BONGO_DEV" ] = var_881289d7987bc770;
    return activityinstances;
}

