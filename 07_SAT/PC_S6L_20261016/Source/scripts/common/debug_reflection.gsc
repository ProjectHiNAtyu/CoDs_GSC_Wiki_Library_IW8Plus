// scripts\common\debug_reflection.gsc  (hash_7babf1485cae49ab.gscc) (size: 1955 Bytes / 0x7a3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb67f401f (3061792799)
// size ...... 1955 (0x7a3)
// includes .. 1   (offset: 0x767)
// strings ... 0   (offset: 0x76f)
// dev strs .. 4   (offset: 0x76f)
// exports ... 8   (offset: 0x447)
// cseg ...... 0x58 + 0x3ef (0x447)
// imports ... 15  (offset: 0x587)
// animtree1 . 0   (offset: 0x7a3)
// animtree2 . 0   (offset: 0x7a3)
#using scripts\common\utility;

#namespace debug_reflection;

/#

    // Namespace debug_reflection
    // Params 1
    // Checksum 0xa37abda6, Offset: 0x76
    // Size: 0x19, Type: dev
    function init_reflection_probe( handleplayerconnect )
    {
        precachemodel( "<dev string:x24>" );
    }

    // Namespace debug_reflection
    // Params 0
    // Checksum 0x71ed968d, Offset: 0x97
    // Size: 0x2c, Type: dev
    function spplayerconnect()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        level.player utility::add_frame_event( &debug_reflection_probes );
    }

#/

// Namespace debug_reflection
// Params 0
// Checksum 0x9c4a2a96, Offset: 0xcb
// Size: 0x4c
function onplayerconnect()
{
    if ( isdefined( level.func_run_lean_threads ) && [[ level.func_run_lean_threads ]]() )
    {
        return;
    }
    
    /#
        for ( ;; )
        {
            level waittill( #"connected", player );
            player utility::add_frame_event( &debug_reflection_probes );
        }
    #/
}

/#

    // Namespace debug_reflection
    // Params 0
    // Checksum 0x1e4549e9, Offset: 0x11f
    // Size: 0x155, Type: dev
    function debug_reflection_probes()
    {
        if ( getdvarint( @"scr_debug_reflection" ) == 2 && level.debug.reflection != 2 || getdvarint( @"scr_debug_reflection" ) == 3 && level.debug.reflection != 3 )
        {
            function_a5c055be78525c30();
            
            if ( getdvarint( @"scr_debug_reflection" ) == 2 )
            {
                level.debug.reflection = 2;
            }
            else
            {
                create_reflection_object();
                level.debug.reflection = 3;
            }
        }
        else if ( getdvarint( @"scr_debug_reflection" ) == 1 && level.debug.reflection != 1 )
        {
            function_a5c055be78525c30();
            create_reflection_object();
            level.debug.reflection = 1;
        }
        else if ( getdvarint( @"scr_debug_reflection" ) == 0 && level.debug.reflection != 0 )
        {
            function_a5c055be78525c30();
            level.debug.reflection = 0;
        }
        
        debug_reflection_buttons();
    }

    // Namespace debug_reflection
    // Params 0
    // Checksum 0x8ea705ec, Offset: 0x27c
    // Size: 0xa0, Type: dev
    function create_reflection_object()
    {
        self.debug_reflectionobject = spawn( "<dev string:x37>", self geteye() + anglestoforward( self.angles ) * 100 );
        self.debug_reflectionobject setmodel( "<dev string:x24>" );
        self.debug_reflectionobject.origin = self geteye() + anglestoforward( self getplayerangles() ) * 100;
        object = self.debug_reflectionobject;
        object.offset = 100;
        object.lastoffset = object.offset;
    }

    // Namespace debug_reflection
    // Params 0
    // Checksum 0x4acfc0f8, Offset: 0x324
    // Size: 0x46, Type: dev
    function function_a5c055be78525c30()
    {
        if ( level.debug.reflection == 1 || level.debug.reflection == 3 )
        {
            self.debug_reflectionobject delete();
        }
    }

    // Namespace debug_reflection
    // Params 0
    // Checksum 0x62bf3b5, Offset: 0x372
    // Size: 0xd5, Type: dev
    function debug_reflection_buttons()
    {
        if ( !isdefined( self.debug_reflectionobject ) )
        {
            return;
        }
        
        object = self.debug_reflectionobject;
        
        if ( self buttonpressed( "<dev string:x44>" ) )
        {
            object.offset += 50;
        }
        
        if ( self buttonpressed( "<dev string:x4d>" ) )
        {
            object.offset -= 50;
        }
        
        object.offset = clamp( object.offset, 64, 1000 );
        object.origin = self geteye() + anglestoforward( self getplayerangles() ) * object.offset;
        object.lastoffset = object.offset;
    }

#/
