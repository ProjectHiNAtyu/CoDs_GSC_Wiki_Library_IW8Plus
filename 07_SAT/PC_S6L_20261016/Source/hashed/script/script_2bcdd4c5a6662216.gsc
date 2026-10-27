// script_2bcdd4c5a6662216  (hash_2bcdd4c5a6662216.gscc) (size: 593 Bytes / 0x251 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x444ec29a (1146012314)
// size ...... 593 (0x251)
// includes .. 4   (offset: 0x225)
// strings ... 1   (offset: 0x245)
// dev strs .. 0   (offset: 0x251)
// exports ... 4   (offset: 0xf9)
// cseg ...... 0x68 + 0x91 (0xf9)
// imports ... 5   (offset: 0x199)
// animtree1 . 0   (offset: 0x251)
// animtree2 . 0   (offset: 0x251)
#using script_496824bf1de5dd83;
#using script_4a7080e904a6380e;
#using scripts\common\bots\bots_util;
#using scripts\common\system;

#namespace br_clash_bots;

// Namespace br_clash_bots
// Params 0, eflags: 0x5
// Checksum 0x6d9b8b08, Offset: 0x86
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"bt_bot_br_clash", undefined, undefined, &post_main );
}

// Namespace br_clash_bots
// Params 0
// Checksum 0x9b033b0d, Offset: 0xa7
// Size: 0x26
function init()
{
    var_8cd1c14d997fbe7f = bots_util::function_37a3a6193a454294();
    
    if ( var_8cd1c14d997fbe7f == "bot_br_clash" )
    {
        thread bt_bot_br::function_2353ac3de7b0f1cb();
    }
}

// Namespace br_clash_bots
// Params 0
// Checksum 0x793c33c9, Offset: 0xd5
// Size: 0x24
function post_main()
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

