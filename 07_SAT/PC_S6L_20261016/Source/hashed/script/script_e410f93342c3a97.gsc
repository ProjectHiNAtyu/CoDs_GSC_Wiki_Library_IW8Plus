// script_e410f93342c3a97  (hash_0e410f93342c3a97.gscc) (size: 1865 Bytes / 0x749 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ab56e60 (1253404256)
// size ...... 1865 (0x749)
// includes .. 5   (offset: 0x6d5)
// strings ... 1   (offset: 0x6fd)
// dev strs .. 5   (offset: 0x709)
// exports ... 10  (offset: 0x371)
// cseg ...... 0x6e + 0x303 (0x371)
// imports ... 16  (offset: 0x501)
// animtree1 . 0   (offset: 0x749)
// animtree2 . 0   (offset: 0x749)
#using script_496824bf1de5dd83;
#using script_4a7080e904a6380e;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\system;

#namespace bt_bot_br_zonecontrol;

// Namespace bt_bot_br_zonecontrol
// Params 0, eflags: 0x5
// Checksum 0x7fcb6465, Offset: 0x8c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"bt_bot_br_zonecontrol", undefined, undefined, &postmain );
}

// Namespace bt_bot_br_zonecontrol
// Params 0, eflags: 0x5
// Checksum 0x1ac4e8cf, Offset: 0xad
// Size: 0x2d
function private autoexec main()
{
    var_8cd1c14d997fbe7f = bots_util::function_37a3a6193a454294();
    
    if ( var_8cd1c14d997fbe7f == "bot_br_zonecontrol" )
    {
        thread bt_bot_br::function_2353ac3de7b0f1cb();
        function_fa83ea398d1275d0();
    }
}

// Namespace bt_bot_br_zonecontrol
// Params 0
// Checksum 0x6e4d7f93, Offset: 0xe2
// Size: 0x24
function postmain()
{
    if ( !level.var_eed87bbca312c1a0 )
    {
        return;
    }
    
    if ( level.var_935a32375dac97bf )
    {
        return;
    }
    
    super_bot::function_71585fa0eb269a5f();
}

// Namespace bt_bot_br_zonecontrol
// Params 0
// Checksum 0x64ea3168, Offset: 0x10e
// Size: 0x15
function function_fa83ea398d1275d0()
{
    level.var_d87075686581c9fb = &function_aee0631d08a43e21;
    function_485408eb16f36216();
}

// Namespace bt_bot_br_zonecontrol
// Params 0, eflags: 0x4
// Checksum 0x5d9838bc, Offset: 0x12b
// Size: 0x4f
function private function_485408eb16f36216()
{
    level.var_5c73e5b5f5a75461 = 1;
    level callback::add( #"hash_2eb0a1e942877ead", &function_58b37a1c49189ee4 );
    level callback::add( #"hash_d280a4114456eaae", &function_4fedfe9a80a08f3b );
    level callback::add( #"hash_c7a132c7acf7744d", &function_e9f5296329518a45 );
}

// Namespace bt_bot_br_zonecontrol
// Params 0, eflags: 0x4
// Checksum 0xcfd287a0, Offset: 0x182
// Size: 0x23
function private function_c34fa37ba69ffe13()
{
    id = level.var_5c73e5b5f5a75461;
    level.var_5c73e5b5f5a75461++;
    return id;
}

// Namespace bt_bot_br_zonecontrol
// Params 1, eflags: 0x4
// Checksum 0x6944bbb9, Offset: 0x1ae
// Size: 0x96
function private function_58b37a1c49189ee4( params )
{
    zone = params.zone;
    
    if ( !zone.origin )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x57>" );
        return;
    }
    
    zone.var_d19819ea631b9b6e = function_c34fa37ba69ffe13();
    zone.var_b19c804d817b1475 = 0;
    function_9cbc5c93a9133106( zone.var_d19819ea631b9b6e, zone.origin, zone.letter, zone.var_b19c804d817b1475 );
}

// Namespace bt_bot_br_zonecontrol
// Params 1, eflags: 0x4
// Checksum 0x97246c8f, Offset: 0x24c
// Size: 0x6d
function private function_4fedfe9a80a08f3b( params )
{
    zone = params.zone;
    
    if ( !isdefined( zone.var_d19819ea631b9b6e ) )
    {
        assertmsg( "<dev string:x75>" + "<dev string:xae>" );
        return;
    }
    
    function_991d5f5af449f6ff( zone.var_d19819ea631b9b6e );
    zone.var_d19819ea631b9b6e = undefined;
    zone.var_b19c804d817b1475 = undefined;
}

// Namespace bt_bot_br_zonecontrol
// Params 1, eflags: 0x4
// Checksum 0x3587af8, Offset: 0x2c1
// Size: 0xb0
function private function_e9f5296329518a45( params )
{
    zone = params.zone;
    
    if ( !isdefined( zone.var_d19819ea631b9b6e ) )
    {
        assertmsg( "<dev string:xd7>" + "<dev string:xae>" );
        return;
    }
    
    hasplayers = zone.players.size > 0;
    
    if ( hasplayers == zone.var_b19c804d817b1475 )
    {
        return;
    }
    
    zone.var_b19c804d817b1475 = hasplayers;
    function_9cbc5c93a9133106( zone.var_d19819ea631b9b6e, zone.origin, zone.letter, zone.var_b19c804d817b1475 );
}

