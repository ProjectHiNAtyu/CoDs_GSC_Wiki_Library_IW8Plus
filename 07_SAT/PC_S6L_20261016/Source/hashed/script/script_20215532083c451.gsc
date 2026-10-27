// script_20215532083c451  (hash_020215532083c451.gscc) (size: 914 Bytes / 0x392 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7905a8d3 (2030414035)
// size ...... 914 (0x392)
// includes .. 4   (offset: 0x356)
// strings ... 2   (offset: 0x376)
// dev strs .. 0   (offset: 0x392)
// exports ... 5   (offset: 0x1ae)
// cseg ...... 0x86 + 0x128 (0x1ae)
// imports ... 8   (offset: 0x276)
// animtree1 . 0   (offset: 0x392)
// animtree2 . 0   (offset: 0x392)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace namespace_1ce62f5a9ae191bc;

// Namespace namespace_1ce62f5a9ae191bc
// Params 0, eflags: 0x5
// Checksum 0xc277771b, Offset: 0xa4
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_7f42ac11bbe7719b", #"ztron_item", undefined, &init );
}

// Namespace namespace_1ce62f5a9ae191bc
// Params 0
// Checksum 0x3cf5605a, Offset: 0xcd
// Size: 0x31
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"armor_vest2", #"use", &use );
    ztron_sound::function_4ac735395b173fe( "armor_vestL2_OS", "evt_ztron_armorvest_get" );
}

// Namespace namespace_1ce62f5a9ae191bc
// Params 0
// Checksum 0xe6f0f42e, Offset: 0x106
// Size: 0x5d
function function_2929e770a5529f55()
{
    profilestart();
    self.ztron.var_4095e0b1332ea87 = 2;
    self.ztron.var_6fe8ea86c8758aec = self.ztron.var_4095e0b1332ea87;
    ztron_ui::function_38a72e402dc87ace();
    ztron_sound::ztron_playsound( "armor_vestL2_OS", self.origin );
    profilestop();
}

// Namespace namespace_1ce62f5a9ae191bc
// Params 1
// Checksum 0x9436a820, Offset: 0x16b
// Size: 0x43
function use( params )
{
    if ( level.ztron.var_95d8c7a469393957 )
    {
        return;
    }
    
    player = params.player;
    player function_2929e770a5529f55();
}

