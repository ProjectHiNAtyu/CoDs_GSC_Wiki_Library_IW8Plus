// scripts\mp\common\powerups\powerup_full_armor_br.gsc  (hash_7520fed0c59c48c1.gscc) (size: 733 Bytes / 0x2dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1546850 (3511969872)
// size ...... 733 (0x2dd)
// includes .. 1   (offset: 0x2d5)
// strings ... 0   (offset: 0x2dd)
// dev strs .. 0   (offset: 0x2dd)
// exports ... 5   (offset: 0x179)
// cseg ...... 0x58 + 0x121 (0x179)
// imports ... 5   (offset: 0x241)
// animtree1 . 0   (offset: 0x2dd)
// animtree2 . 0   (offset: 0x2dd)
#using scripts\common\utility;

#namespace powerup_full_armor_br;

// Namespace powerup_full_armor_br
// Params 0, eflags: 0x1
// Checksum 0x7d030a6c, Offset: 0x76
// Size: 0x2d
function autoexec main()
{
    if ( getdvarint( @"scr_br_powerups_enabled", 0 ) && !getdvarint( @"scr_disable_powerup_full_armor", 0 ) )
    {
        init();
    }
}

// Namespace powerup_full_armor_br
// Params 0
// Checksum 0xeaa3b685, Offset: 0xab
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"powerup_full_armor", #"hash_75b10183404b5a16", &function_66646fcceb16b26f );
    utility::registersharedfunc( #"powerup_full_armor", #"modify_drop_chance", &modify_drop_chance );
}

// Namespace powerup_full_armor_br
// Params 0
// Checksum 0xb2fdaede, Offset: 0xf1
// Size: 0x4, Type: bool
function function_66646fcceb16b26f()
{
    return true;
}

// Namespace powerup_full_armor_br
// Params 2
// Checksum 0x1df93966, Offset: 0xfe
// Size: 0x7b
function modify_drop_chance( chance, context )
{
    player = context.player;
    armorpct = player.armorhealth / player.maxarmorhealth;
    
    if ( armorpct >= 1 )
    {
        return ( chance * 0.25 );
    }
    
    if ( armorpct > 0.5 )
    {
        return chance;
    }
    
    return chance * 3;
}

