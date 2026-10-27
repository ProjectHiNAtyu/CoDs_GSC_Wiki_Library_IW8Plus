// script_5f6b321fec1c314d  (hash_5f6b321fec1c314d.gscc) (size: 1248 Bytes / 0x4e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab6a457f (2875868543)
// size ...... 1248 (0x4e0)
// includes .. 1   (offset: 0x494)
// strings ... 5   (offset: 0x49c)
// dev strs .. 0   (offset: 0x4e0)
// exports ... 5   (offset: 0x2bc)
// cseg ...... 0xdd + 0x1df (0x2bc)
// imports ... 9   (offset: 0x384)
// animtree1 . 0   (offset: 0x4e0)
// animtree2 . 0   (offset: 0x4e0)
#using scripts\common\utility;

#namespace t10_mp_execution_powerkick;

// Namespace t10_mp_execution_powerkick
// Params 0, eflags: 0x5
// Checksum 0x6a4e52c, Offset: 0xfb
// Size: 0x29
function private autoexec main()
{
    utility::registersharedfunc( #"execution", hashcat( #"hash_4d1bbe3897b62769", "t10_mp_execution_powerkick" ), &function_999dc84de6fe752f );
}

// Namespace t10_mp_execution_powerkick
// Params 3, eflags: 0x4
// Checksum 0xd6eecf40, Offset: 0x12c
// Size: 0xe7
function private function_999dc84de6fe752f( attacker, victim, var_d3cdbd00ed96a2dd )
{
    attacker endon( #"death_or_disconnect" );
    attacker endon( #"execution_stopped" );
    victim endon( #"disconnect" );
    
    if ( var_d3cdbd00ed96a2dd )
    {
        return;
    }
    
    victimstance = victim getstance();
    
    switch ( victimstance )
    {
        case #"hash_c6775c88e38f7803":
            wait 0;
            function_c86a3dce1a829533( attacker, victim );
            break;
        case #"hash_3fed0cbd303639eb":
            wait 0;
            function_c86a3dce1a829533( attacker, victim );
            break;
        case #"hash_d91940431ed7c605":
            if ( victim.inlaststand )
            {
                wait 0;
                function_c86a3dce1a829533( attacker, victim );
                break;
            }
            else
            {
                wait 0;
                function_c86a3dce1a829533( attacker, victim );
                break;
            }
        default:
            break;
    }
}

// Namespace t10_mp_execution_powerkick
// Params 2, eflags: 0x4
// Checksum 0xe421e116, Offset: 0x21b
// Size: 0x65
function private function_c86a3dce1a829533( attacker, victim )
{
    thread function_8849a2c0b875e141( attacker, [ "death_or_disconnect", "execution_stopped" ] );
    thread function_8849a2c0b875e141( victim, [ "disconnect", "begin_killcam" ] );
    attacker playcinematicforplayer( "t10_mp_execution_powerkick" );
    victim playcinematicforplayer( "t10_mp_execution_powerkick" );
}

// Namespace t10_mp_execution_powerkick
// Params 2, eflags: 0x4
// Checksum 0x9c6922be, Offset: 0x288
// Size: 0x34
function private function_8849a2c0b875e141( player, var_8ddf371283a9665f )
{
    level endon( #"game_ended" );
    player utility::waittill_any_in_array_or_timeout( var_8ddf371283a9665f, 5 );
    player stopcinematicforplayer();
}

