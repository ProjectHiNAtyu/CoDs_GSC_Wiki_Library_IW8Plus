// scripts\common\debug_graycard.gsc  (hash_30c42dcabd30a39b.gscc) (size: 4123 Bytes / 0x101b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ab72576 (2595693942)
// size ...... 4123 (0x101b)
// includes .. 1   (offset: 0xf13)
// strings ... 0   (offset: 0xf1b)
// dev strs .. 18  (offset: 0xf1b)
// exports ... 12  (offset: 0x983)
// cseg ...... 0x58 + 0x92b (0x983)
// imports ... 29  (offset: 0xb63)
// animtree1 . 0   (offset: 0x101b)
// animtree2 . 0   (offset: 0x101b)
#using scripts\common\utility;

#namespace debug_graycard;

/#

    // Namespace debug_graycard
    // Params 1
    // Checksum 0xb5886a42, Offset: 0x76
    // Size: 0xc3, Type: dev
    function init_graycard( handleplayerconnect )
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        precachemodel( "<dev string:x24>" );
        precachemodel( "<dev string:x34>" );
        precachemodel( "<dev string:x54>" );
        precachemodel( "<dev string:x76>" );
        precachemodel( "<dev string:x92>" );
        precachemodel( "<dev string:xac>" );
        precachemodel( "<dev string:xc0>" );
        precachemodel( "<dev string:xd6>" );
        precachemodel( "<dev string:xf0>" );
        
        if ( !isdefined( level.debug ) )
        {
            level.debug = spawnstruct();
        }
        
        level.debug.graycard = 0;
        
        if ( isdefined( handleplayerconnect ) )
        {
            thread onplayerconnect();
            return;
        }
        
        thread spplayerconnect();
    }

    // Namespace debug_graycard
    // Params 0
    // Checksum 0xe9d025ff, Offset: 0x141
    // Size: 0x2c, Type: dev
    function spplayerconnect()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        level.player utility::add_frame_event( &debug_gray_card );
    }

#/

// Namespace debug_graycard
// Params 0
// Checksum 0x57f4438a, Offset: 0x175
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
            player utility::add_frame_event( &debug_gray_card_mp );
        }
    #/
}

/#

    // Namespace debug_graycard
    // Params 0
    // Checksum 0x86b66aab, Offset: 0x1c9
    // Size: 0xe, Type: dev
    function debug_gray_card_mp()
    {
        debug_gray_card( 1 );
    }

    // Namespace debug_graycard
    // Params 1
    // Checksum 0x93297318, Offset: 0x1df
    // Size: 0x1b6, Type: dev
    function debug_gray_card( ismp )
    {
        if ( !isdefined( ismp ) )
        {
            ismp = 0;
        }
        
        if ( getdvarint( @"scr_debug_graycard" ) == 1 )
        {
            if ( level.debug.graycard != 1 )
            {
                remove_graycard_objects();
                create_graycard_object();
                level.debug.graycard = 1;
            }
            
            debug_graycard_buttons( ismp );
        }
        else if ( getdvarint( @"scr_debug_graycard" ) == 0 && level.debug.graycard != 0 )
        {
            remove_graycard_objects();
            level.debug.graycard = 0;
        }
        
        switch ( getdvar( @"debug_graycard_model" ) )
        {
            case #"hash_311010bc01bd3a0f":
                set_debug_models( "<dev string:x34>" );
                break;
            case #"hash_31100fbc01bd387c":
                set_debug_models( "<dev string:x54>" );
                break;
            case #"hash_311012bc01bd3d35":
                set_debug_models( "<dev string:x76>" );
                break;
            case #"hash_311011bc01bd3ba2":
                set_debug_models( "<dev string:xac>" );
                break;
            case #"hash_31100cbc01bd33c3":
                set_debug_models( "<dev string:x92>" );
                break;
            case #"hash_31100bbc01bd3230":
                set_debug_models( "<dev string:xf0>" );
                break;
            case #"hash_31100ebc01bd36e9":
                set_debug_models( "<dev string:xd6>" );
                break;
            case #"hash_31100dbc01bd3556":
                set_debug_models( "<dev string:x24>" );
                break;
            default:
                break;
        }
    }

    // Namespace debug_graycard
    // Params 1
    // Checksum 0x9a6cabf5, Offset: 0x39d
    // Size: 0xc5, Type: dev
    function set_debug_models( model )
    {
        if ( isdefined( level.debug.graycard_objects ) )
        {
            foreach ( ent in level.debug.graycard_objects )
            {
                ent setmodel( model );
            }
        }
        
        if ( isdefined( self.var_f79ff3fb4906718e ) )
        {
            self.var_f79ff3fb4906718e setmodel( model );
        }
    }

    // Namespace debug_graycard
    // Params 0
    // Checksum 0x26c2aa87, Offset: 0x46a
    // Size: 0xcb, Type: dev
    function remove_graycard_objects()
    {
        if ( isdefined( level.debug.graycard_objects ) )
        {
            foreach ( ent in level.debug.graycard_objects )
            {
                ent delete();
            }
            
            level.debug.graycard_objects = undefined;
        }
        
        if ( isdefined( self.var_f79ff3fb4906718e ) )
        {
            self.var_f79ff3fb4906718e delete();
        }
    }

    // Namespace debug_graycard
    // Params 0
    // Checksum 0x6dd9c8ad, Offset: 0x53d
    // Size: 0x75, Type: dev
    function create_graycard_object()
    {
        self.var_f79ff3fb4906718e = spawn_graycard();
        object = self.var_f79ff3fb4906718e;
        object.offset = 100;
        object.lastoffset = object.offset;
        object.copy_released = 1;
        object.offsetangles = ( 0, 0, 0 );
    }

    // Namespace debug_graycard
    // Params 0
    // Checksum 0x2a98783d, Offset: 0x5ba
    // Size: 0x32, Type: dev
    function spawn_graycard()
    {
        model = spawn( "<dev string:x118>", self.origin );
        model setmodel( "<dev string:xac>" );
        return model;
    }

    // Namespace debug_graycard
    // Params 1
    // Checksum 0x8a301d24, Offset: 0x5f4
    // Size: 0x278, Type: dev
    function debug_graycard_buttons( ismp )
    {
        if ( !isdefined( self.var_f79ff3fb4906718e ) )
        {
            return;
        }
        
        object = self.var_f79ff3fb4906718e;
        
        if ( self buttonpressed( "<dev string:x125>" ) )
        {
            object.offset += 5;
        }
        
        if ( self buttonpressed( "<dev string:x12e>" ) )
        {
            object.offset -= 5;
        }
        
        if ( self buttonpressed( "<dev string:x137>" ) )
        {
            object.offsetangles += ( 0, 6, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x140>" ) )
        {
            object.offsetangles += ( 0, -6, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x149>" ) )
        {
            object.offsetangles += ( 6, 0, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x157>" ) )
        {
            object.offsetangles += ( -6, 0, 0 );
        }
        
        if ( self buttonpressed( "<dev string:x165>" ) )
        {
            object.offsetangles = ( 0, 0, 0 );
        }
        
        if ( object.copy_released )
        {
            if ( self buttonpressed( "<dev string:x173>" ) )
            {
                create_copy( object );
                object.copy_released = 0;
            }
        }
        else if ( !self buttonpressed( "<dev string:x173>" ) )
        {
            object.copy_released = 1;
        }
        
        if ( object.offset > 1000 )
        {
            object.offset = 1000;
        }
        
        if ( object.offset < 16 )
        {
            object.offset = 16;
        }
        
        if ( !ismp )
        {
            object unlink();
        }
        
        object.origin = self geteye() + anglestoforward( self getplayerangles() ) * object.offset;
        object.angles = combineangles( self getplayerangles(), object.offsetangles );
        object.lastoffset = object.offset;
        
        if ( !ismp )
        {
            object linkto( self );
        }
    }

    // Namespace debug_graycard
    // Params 1
    // Checksum 0xb84870d6, Offset: 0x874
    // Size: 0x10f, Type: dev
    function create_copy( object )
    {
        copyobject = spawn_graycard();
        copyobject.origin = object.origin;
        copyobject.angles = object.angles;
        
        if ( !isdefined( level.debug.graycard_objects ) )
        {
            level.debug.graycard_objects = [ copyobject ];
            return;
        }
        
        if ( level.debug.graycard_objects.size > 50 )
        {
            level.debug.graycard_objects[ 0 ] delete();
            level.debug.graycard_objects = function_5713d46873b29625( level.debug.graycard_objects );
        }
        
        level.debug.graycard_objects[ level.debug.graycard_objects.size ] = copyobject;
    }

#/
