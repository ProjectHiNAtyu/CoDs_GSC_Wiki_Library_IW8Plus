// scripts\mp\ob\systems\ob_splashes.gsc  (hash_5a667976c580ca8c.gscc) (size: 1134 Bytes / 0x46e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6015b84d (1612036173)
// size ...... 1134 (0x46e)
// includes .. 2   (offset: 0x43a)
// strings ... 0   (offset: 0x44a)
// dev strs .. 3   (offset: 0x44a)
// exports ... 4   (offset: 0x27a)
// cseg ...... 0x58 + 0x222 (0x27a)
// imports ... 10  (offset: 0x31a)
// animtree1 . 0   (offset: 0x46e)
// animtree2 . 0   (offset: 0x46e)
#using scripts\common\devgui;
#using scripts\mp\hud_message;

#namespace ob_splashes;

/#

    // Namespace ob_splashes
    // Params 0
    // Checksum 0x763ab018, Offset: 0x76
    // Size: 0x10c, Type: dev
    function init()
    {
        splashlist = function_359ed87eadfb6858( level.gamemodebundle.splashlist );
        
        if ( isdefined( splashlist ) )
        {
            devgui::function_9082edeb5db93280( "<dev string:x24>" );
            var_3e40408104a8e270 = getxhashsourcename( level.gamemodebundle.splashlist );
            
            foreach ( splash in splashlist.splash_list )
            {
                splashname = getxhashsourcename( splash.ref );
                devgui::function_cd4e263c1f3018ae( splashname, "<dev string:x31>" + splashname + "<dev string:x39>" + var_3e40408104a8e270, &devgui_show_splash );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace ob_splashes
    // Params 1, eflags: 0x4
    // Checksum 0x26cc8ff1, Offset: 0x18a
    // Size: 0x2f, Type: dev
    function private function_359ed87eadfb6858( var_80756932878fc697 )
    {
        if ( !isxhashasset( var_80756932878fc697 ) )
        {
            return;
        }
        
        splashlist = getscriptbundle( var_80756932878fc697 );
        return splashlist;
    }

    // Namespace ob_splashes
    // Params 1, eflags: 0x4
    // Checksum 0x8b511e4c, Offset: 0x1c1
    // Size: 0xb9, Type: dev
    function private devgui_show_splash( params )
    {
        splashref = params[ 0 ];
        splashlist = params[ 1 ];
        
        if ( !( isdefined( splashref ) && isdefined( splashlist ) ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player hud_message::function_78fedf6f526825f4( splashref, splashlist );
            }
        }
    }

#/
