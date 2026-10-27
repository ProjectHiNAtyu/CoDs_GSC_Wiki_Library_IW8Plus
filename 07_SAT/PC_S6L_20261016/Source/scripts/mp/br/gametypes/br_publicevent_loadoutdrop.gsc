// scripts\mp\br\gametypes\br_publicevent_loadoutdrop.gsc  (hash_463fd23a9f35373b.gscc) (size: 1488 Bytes / 0x5d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf3dfdee8 (4091535080)
// size ...... 1488 (0x5d0)
// includes .. 5   (offset: 0x564)
// strings ... 2   (offset: 0x58c)
// dev strs .. 3   (offset: 0x5ac)
// exports ... 8   (offset: 0x248)
// cseg ...... 0x92 + 0x1b6 (0x248)
// imports ... 17  (offset: 0x388)
// animtree1 . 0   (offset: 0x5d0)
// animtree2 . 0   (offset: 0x5d0)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\devgui;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace br_publicevent_loadoutdrop;

// Namespace br_publicevent_loadoutdrop
// Params 0, eflags: 0x1
// Checksum 0x7ee92f64, Offset: 0xb0
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"loadoutdrop", &init );
}

// Namespace br_publicevent_loadoutdrop
// Params 1
// Checksum 0x5b77440f, Offset: 0xcf
// Size: 0x4d
function init( eventinfo )
{
    activity_definition_utils::function_74af1ab4059e3c06( %"hash_55c31f7d5d14a5a3", "wz_sat_activity_crate_drop_contested_loadout" );
    eventinfo.activatefunc = &activatefunc;
    eventinfo.deactivatefunc = &deactivatefunc;
    
    /#
        debug_init();
    #/
}

// Namespace br_publicevent_loadoutdrop
// Params 0
// Checksum 0x435fc6cd, Offset: 0x124
// Size: 0xe
function activatefunc()
{
    activity_instance_common::function_9b387cb1af0d5b4b( "wz_sat_activity_crate_drop_contested_loadout" );
}

// Namespace br_publicevent_loadoutdrop
// Params 0
// Checksum 0x9a70e30c, Offset: 0x13a
// Size: 0xad
function deactivatefunc()
{
    foreach ( activity in activity_common::function_394486cf35d84dc8() )
    {
        if ( activity.varianttag != "wz_sat_activity_crate_drop_contested_loadout" )
        {
            continue;
        }
        
        if ( activity_instance_common::getactivitystate( activity ) == "Active" )
        {
            activity_instance_common::endactivity( activity, 0 );
            continue;
        }
        
        activity_instance_common::function_9aeeabe50fc9cc3e( activity );
    }
}

/#

    // Namespace br_publicevent_loadoutdrop
    // Params 0
    // Checksum 0x2575d058, Offset: 0x1ef
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace br_publicevent_loadoutdrop
    // Params 0
    // Checksum 0xbe3a21de, Offset: 0x1fc
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x36>", "<dev string:x43>", &debug_start_event );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_publicevent_loadoutdrop
    // Params 0
    // Checksum 0xb128adef, Offset: 0x232
    // Size: 0x16, Type: dev
    function debug_start_event()
    {
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"loadoutdrop" );
    }

#/
