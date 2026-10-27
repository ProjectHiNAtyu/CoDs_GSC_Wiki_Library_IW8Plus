// scripts\mp\zm\ztron\ztron_world_event.gsc  (hash_4270f9a42eb76d6f.gscc) (size: 4219 Bytes / 0x107b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae0795db (2919732699)
// size ...... 4219 (0x107b)
// includes .. 3   (offset: 0xd73)
// strings ... 18  (offset: 0xd8b)
// dev strs .. 31  (offset: 0xe87)
// exports ... 11  (offset: 0x8c7)
// cseg ...... 0x22b + 0x69c (0x8c7)
// imports ... 20  (offset: 0xa7f)
// animtree1 . 0   (offset: 0x107b)
// animtree2 . 0   (offset: 0x107b)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_debug;

#namespace ztron_world_event;

// Namespace ztron_world_event
// Params 0
// Checksum 0x9b621772, Offset: 0x249
// Size: 0x43
function init()
{
    level.ztron.worldevent = spawnstruct();
    
    /#
        function_4a6f2460bb0eb9e5();
        level.ztron.worldevent.debuglist = [];
    #/
}

// Namespace ztron_world_event
// Params 1, eflags: 0x4
// Checksum 0x41365a01, Offset: 0x294
// Size: 0x54
function private function_e3433eb53bf06bd7( eventname )
{
    activateworldevent( eventname );
    ztron_debug::debugmsg( "Ztron World Event Activate " + eventname );
    level utility::waittill_any( "ztron_game_is_over", "arena_deactivated", "arena_completed", "arena_round_leaving" );
    deactivateworldevent( eventname );
    ztron_debug::debugmsg( "Ztron World Event Deactivate " + eventname );
}

// Namespace ztron_world_event
// Params 1
// Checksum 0x29117ccd, Offset: 0x2f0
// Size: 0x5d
function function_b0d378779942dd03( round_num )
{
    switch ( round_num )
    {
        case 2:
            level function_e3433eb53bf06bd7( "we_ztron_mid_light" );
            break;
        case 3:
            level function_e3433eb53bf06bd7( "we_ztron_night_light" );
            break;
        default:
            break;
    }
}

// Namespace ztron_world_event
// Params 1
// Checksum 0x99ac6531, Offset: 0x355
// Size: 0x8f
function function_8137d21072086004( player_num )
{
    activateworldevent( "player_spotlight_papa" );
    
    for ( i = 1; i <= player_num && i <= 4 ; i++ )
    {
        activateworldevent( "player_spotlight_0" + i );
    }
    
    level utility::waittill_any( "ztron_game_is_over", "ztron_cutscene_world_event_deactive", "arena_deactivated" );
    deactivateworldevent( "player_spotlight_papa" );
    
    for ( i = 1; i <= player_num && i <= 4 ; i++ )
    {
        deactivateworldevent( "player_spotlight_0" + i );
    }
}

// Namespace ztron_world_event
// Params 0
// Checksum 0x6e37f8c2, Offset: 0x3ec
// Size: 0x40
function function_e0e05f88577eca1f()
{
    self notify( #"hash_842c904c6762f316" );
    self endon( #"hash_842c904c6762f316" );
    activateworldevent( "player_spotlight_camera_shot0" );
    level utility::waittill_any( "ztron_game_reset", "podiumAllDone" );
    deactivateworldevent( "player_spotlight_camera_shot0" );
}

// Namespace ztron_world_event
// Params 0
// Checksum 0x4f0525a3, Offset: 0x434
// Size: 0x40
function function_ad84e488fb9e61d4()
{
    self notify( #"hash_e76ecd621aabd872" );
    self endon( #"hash_e76ecd621aabd872" );
    activateworldevent( "player_spotlight_papa_infil" );
    level utility::waittill_any( "ztron_game_is_over", "silverback_intro_done" );
    deactivateworldevent( "player_spotlight_papa_infil" );
}

// Namespace ztron_world_event
// Params 0
// Checksum 0x51df7ec7, Offset: 0x47c
// Size: 0x40
function function_c172adbbf64d3c04()
{
    self notify( #"hash_34e0271c4bac7f0c" );
    self endon( #"hash_34e0271c4bac7f0c" );
    activateworldevent( "player_spotlight_gspawn_papa" );
    level utility::waittill_any( "ztron_game_is_over", "silverback_cutscene_done" );
    deactivateworldevent( "player_spotlight_gspawn_papa" );
}

/#

    // Namespace ztron_world_event
    // Params 0
    // Checksum 0x1cf0518, Offset: 0x4c4
    // Size: 0x27e, Type: dev
    function function_4a6f2460bb0eb9e5()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x39>", "<dev string:x5f>", &function_8ed36e1d5b440b88 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x82>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9d>", "<dev string:xb2>" + "<dev string:xc9>" + "<dev string:xdc>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdf>", "<dev string:xb2>" + "<dev string:xc9>" + "<dev string:xf2>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf5>", "<dev string:xb2>" + "<dev string:x10c>" + "<dev string:xdc>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:x121>", "<dev string:xb2>" + "<dev string:x10c>" + "<dev string:xf2>", &function_cef412cfe513d2ea );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x136>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x155>", "<dev string:xb2>" + "<dev string:x16b>" + "<dev string:xdc>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:x181>", "<dev string:xb2>" + "<dev string:x16b>" + "<dev string:xf2>", &function_cef412cfe513d2ea );
        
        for ( i = 1; i <= 4 ; i++ )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:x195>" + i, "<dev string:xb2>" + "<dev string:x1ad>" + i + "<dev string:xdc>", &function_cef412cfe513d2ea );
            devgui::function_cd4e263c1f3018ae( "<dev string:x1c0>" + i, "<dev string:xb2>" + "<dev string:x1ad>" + i + "<dev string:xf2>", &function_cef412cfe513d2ea );
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x1d6>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1f1>", "<dev string:xb2>" + "<dev string:x208>" + "<dev string:xdc>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:x226>", "<dev string:xb2>" + "<dev string:x208>" + "<dev string:xf2>", &function_cef412cfe513d2ea );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x23b>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x259>", "<dev string:xb2>" + "<dev string:x273>" + "<dev string:xdc>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:x28f>", "<dev string:xb2>" + "<dev string:x273>" + "<dev string:xf2>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a7>", "<dev string:xb2>" + "<dev string:x2bf>" + "<dev string:xdc>", &function_cef412cfe513d2ea );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2dc>", "<dev string:xb2>" + "<dev string:x2bf>" + "<dev string:xf2>", &function_cef412cfe513d2ea );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_world_event
    // Params 1
    // Checksum 0x936e790f, Offset: 0x74a
    // Size: 0xc6, Type: dev
    function function_cef412cfe513d2ea( params )
    {
        event = params[ 0 ];
        needactive = int( params[ 1 ] );
        
        if ( needactive )
        {
            activateworldevent( event );
            level.ztron.worldevent.debuglist[ level.ztron.worldevent.debuglist.size ] = event;
            return;
        }
        
        deactivateworldevent( event );
        level.ztron.worldevent.debuglist = arrayremove( level.ztron.worldevent.debuglist, event );
    }

    // Namespace ztron_world_event
    // Params 0
    // Checksum 0x447cfa9a, Offset: 0x818
    // Size: 0xaf, Type: dev
    function function_8ed36e1d5b440b88()
    {
        foreach ( event in level.ztron.worldevent.debuglist )
        {
            deactivateworldevent( event );
        }
        
        level.ztron.worldevent.debuglist = [];
    }

#/
