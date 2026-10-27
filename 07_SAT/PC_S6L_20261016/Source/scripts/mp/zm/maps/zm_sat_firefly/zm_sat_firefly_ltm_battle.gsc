// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_ltm_battle.gsc  (hash_3b0d1df8d206fe2c.gscc) (size: 577 Bytes / 0x241 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee9648d5 (4002826453)
// size ...... 577 (0x241)
// includes .. 4   (offset: 0x221)
// strings ... 0   (offset: 0x241)
// dev strs .. 0   (offset: 0x241)
// exports ... 4   (offset: 0xd5)
// cseg ...... 0x58 + 0x7d (0xd5)
// imports ... 6   (offset: 0x175)
// animtree1 . 0   (offset: 0x241)
// animtree2 . 0   (offset: 0x241)
#using scripts\common\system;
#using scripts\mp\zm\gametypes\zm_rb_battle;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;
#using scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_ltm_startroom;

#namespace zm_sat_firefly_ltm_battle;

// Namespace zm_sat_firefly_ltm_battle
// Params 0, eflags: 0x5
// Checksum 0x713d772b, Offset: 0x76
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_f6175a175c7192fe", #"zm_rb_battle", &pre_main, &post_main );
}

// Namespace zm_sat_firefly_ltm_battle
// Params 0, eflags: 0x4
// Checksum 0x24bdb123, Offset: 0xa3
// Size: 0xd
function private pre_main()
{
    if ( !zm_rb_battle::is_mode_zm_rb_battle() )
    {
        return;
    }
}

// Namespace zm_sat_firefly_ltm_battle
// Params 0, eflags: 0x4
// Checksum 0x5d7324b8, Offset: 0xb8
// Size: 0x1d
function private post_main()
{
    if ( !zm_rb_battle::is_mode_zm_rb_battle() )
    {
        return;
    }
    
    level thread zm_sat_firefly_ltm_startroom::function_5c127c737c11cec8();
    level thread zm_rb_startroom_sat::function_7ff4cf75757ec51();
}

