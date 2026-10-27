// scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ltm_battle.gsc  (hash_58e057e9ca1a5ed6.gscc) (size: 613 Bytes / 0x265 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d268e4f (2636549711)
// size ...... 613 (0x265)
// includes .. 4   (offset: 0x245)
// strings ... 0   (offset: 0x265)
// dev strs .. 0   (offset: 0x265)
// exports ... 4   (offset: 0xdd)
// cseg ...... 0x58 + 0x85 (0xdd)
// imports ... 7   (offset: 0x17d)
// animtree1 . 0   (offset: 0x265)
// animtree2 . 0   (offset: 0x265)
#using scripts\common\system;
#using scripts\mp\zm\gametypes\zm_rb_battle;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_ltm_startroom;

#namespace zm_sat_mantis_ltm_battle;

// Namespace zm_sat_mantis_ltm_battle
// Params 0, eflags: 0x5
// Checksum 0x7092b14d, Offset: 0x76
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_b7cbaecaf6ff801", #"zm_rb_battle", &pre_main, &post_main );
}

// Namespace zm_sat_mantis_ltm_battle
// Params 0, eflags: 0x4
// Checksum 0xb6df0fb3, Offset: 0xa3
// Size: 0x15
function private pre_main()
{
    if ( !zm_rb_battle::is_mode_zm_rb_battle() )
    {
        return;
    }
    
    level thread zm_sat_mantis_ltm_startroom::function_19eea64bfb0db8cf();
}

// Namespace zm_sat_mantis_ltm_battle
// Params 0, eflags: 0x4
// Checksum 0xb931ec7, Offset: 0xc0
// Size: 0x1d
function private post_main()
{
    if ( !zm_rb_battle::is_mode_zm_rb_battle() )
    {
        return;
    }
    
    level thread zm_rb_startroom_sat::function_7ff4cf75757ec51();
    level thread zm_sat_mantis_ltm_startroom::function_14c0b60fa27632f3();
}

