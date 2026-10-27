// scripts\mp\maps\mp_wz2_escape\mp_wz2_escape_ee.gsc  (hash_151b1cce100b540a.gscc) (size: 1799 Bytes / 0x707 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfd87c925 (4253534501)
// size ...... 1799 (0x707)
// includes .. 2   (offset: 0x64f)
// strings ... 7   (offset: 0x65f)
// dev strs .. 7   (offset: 0x6b3)
// exports ... 7   (offset: 0x343)
// cseg ...... 0xb4 + 0x28f (0x343)
// imports ... 17  (offset: 0x45b)
// animtree1 . 0   (offset: 0x707)
// animtree2 . 0   (offset: 0x707)
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace mp_wz2_escape_ee;

// Namespace mp_wz2_escape_ee
// Params 0
// Checksum 0x20f132e5, Offset: 0xd2
// Size: 0x21
function init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    thread bunker_doors();
}

/#

    // Namespace mp_wz2_escape_ee
    // Params 0
    // Checksum 0x8e26aa3e, Offset: 0xfb
    // Size: 0x5, Type: dev
    function function_65215b92e146c261()
    {
        
    }

#/

// Namespace mp_wz2_escape_ee
// Params 0
// Checksum 0x2a6aeed9, Offset: 0x108
// Size: 0xd3
function bunker_doors()
{
    level endon( #"game_ended" );
    
    /#
        level thread function_9ad5bf94fe95d505();
    #/
    
    doortoopen = strtok( getdvar( @"scr_escape_bunker_doors", "" ), " " );
    level.bunker_doors = getentitylessscriptablearray( "door_bunker_yellow", "script_noteworthy" );
    
    if ( doortoopen.size > 0 )
    {
        foreach ( bunkerdoor in doortoopen )
        {
            thread function_753057951582e330( int( bunkerdoor ) );
        }
    }
}

// Namespace mp_wz2_escape_ee
// Params 1
// Checksum 0xae9f80b8, Offset: 0x1e3
// Size: 0xcb
function function_753057951582e330( doorindex )
{
    foreach ( door in level.bunker_doors )
    {
        if ( int( door.script_parameters ) == doorindex )
        {
            door setscriptablepartstate( "base", "opening" );
            
            if ( door.script_linkto )
            {
                utility::trigger_off( door.script_linkto, #script_linkname );
            }
        }
    }
}

/#

    // Namespace mp_wz2_escape_ee
    // Params 0
    // Checksum 0x8a8dd3d7, Offset: 0x2b6
    // Size: 0x5a, Type: dev
    function function_9ad5bf94fe95d505()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37>", "<dev string:x49>", &function_b275d37ef94d0f4f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x59>", "<dev string:x65>", &function_b275d37ef94d0f4f );
        devgui::function_cd4e263c1f3018ae( "<dev string:x75>", "<dev string:x89>", &function_b275d37ef94d0f4f );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace mp_wz2_escape_ee
    // Params 1
    // Checksum 0xa7701af7, Offset: 0x318
    // Size: 0x2b, Type: dev
    function function_b275d37ef94d0f4f( params )
    {
        index = int( params[ 0 ] );
        function_753057951582e330( index );
    }

#/
