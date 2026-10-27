// script_700702110a5608aa  (hash_700702110a5608aa.gscc) (size: 1753 Bytes / 0x6d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd9120c5b (3641838683)
// size ...... 1753 (0x6d9)
// includes .. 4   (offset: 0x671)
// strings ... 0   (offset: 0x691)
// dev strs .. 6   (offset: 0x691)
// exports ... 7   (offset: 0x2f1)
// cseg ...... 0x58 + 0x299 (0x2f1)
// imports ... 21  (offset: 0x409)
// animtree1 . 0   (offset: 0x6d9)
// animtree2 . 0   (offset: 0x6d9)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\armor;

#namespace namespace_e20a68fcadba93ef;

// Namespace namespace_e20a68fcadba93ef
// Params 0, eflags: 0x1
// Checksum 0xb2cd4294, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"reinforced_armor", &init );
}

// Namespace namespace_e20a68fcadba93ef
// Params 0
// Checksum 0x148691c7, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"reinforced_armor", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"reinforced_armor", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace namespace_e20a68fcadba93ef
// Params 1, eflags: 0x4
// Checksum 0xcf796e05, Offset: 0xdb
// Size: 0x75, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_887fc1593f08bb, "<dev string:x24>" );
    assert( skill_bundle.var_6dc1f2154bb5c8a6, "<dev string:x4b>" );
    assert( !callback::exists( #"hash_652eb614ba902b3d", &on_player_damaged, undefined, 1 ) );
    callback::add( #"hash_652eb614ba902b3d", &on_player_damaged, skill_bundle );
    return true;
}

// Namespace namespace_e20a68fcadba93ef
// Params 1, eflags: 0x4
// Checksum 0x1fd2dae3, Offset: 0x159
// Size: 0x40
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"hash_652eb614ba902b3d", &on_player_damaged, undefined, 1 ) );
    callback::remove( #"hash_652eb614ba902b3d", &on_player_damaged );
}

// Namespace namespace_e20a68fcadba93ef
// Params 2, eflags: 0x4
// Checksum 0x1285e2b4, Offset: 0x1a1
// Size: 0x11c
function private on_player_damaged( params, bundle )
{
    var_792d7c603f887540 = armor::getarmorhealth();
    worn_plates = armor::function_88bd3cd8729867e4( var_792d7c603f887540 );
    
    if ( !worn_plates )
    {
        return;
    }
    
    reduction = worn_plates * bundle.var_887fc1593f08bb;
    
    if ( bundle.var_af3a0cf3e960f2c0 && function_550fe0b7b2306af6( worn_plates ) )
    {
        reduction += bundle.var_af3a0cf3e960f2c0;
    }
    
    reduction = min( reduction, bundle.var_6dc1f2154bb5c8a6 );
    var_7d64e9294f8b0a98 = int( ceil( params.idamage * reduction ) );
    
    /#
        if ( getdvarint( @"hash_1829bb9e41aaa11c", 0 ) )
        {
            self iprintlnbold( "<dev string:x6d>" + worn_plates + "<dev string:x87>" + int( reduction * 100 ) + "<dev string:x93>" + params.idamage + "<dev string:x9a>" + var_7d64e9294f8b0a98 );
        }
    #/
    
    params.idamage -= var_7d64e9294f8b0a98;
}

// Namespace namespace_e20a68fcadba93ef
// Params 1, eflags: 0x4
// Checksum 0x8af154de, Offset: 0x2c5
// Size: 0x2b, Type: bool
function private function_550fe0b7b2306af6( worn_plates )
{
    var_d1c4ef00b4493359 = armor::function_88bd3cd8729867e4( self.maxarmorhealth );
    return worn_plates == var_d1c4ef00b4493359;
}

