// scripts\mp\common\killstreaks\airdrop_escort_mp.gsc  (hash_19e2031c0479b1b2.gscc) (size: 1064 Bytes / 0x428 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5886b495 (1485223061)
// size ...... 1064 (0x428)
// includes .. 6   (offset: 0x3e0)
// strings ... 1   (offset: 0x410)
// dev strs .. 0   (offset: 0x428)
// exports ... 4   (offset: 0x228)
// cseg ...... 0x6a + 0x1be (0x228)
// imports ... 10  (offset: 0x2c8)
// animtree1 . 0   (offset: 0x428)
// animtree2 . 0   (offset: 0x428)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\airdrop_escort;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\points;

#namespace airdrop_escort_mp;

// Namespace airdrop_escort_mp
// Params 0
// Checksum 0xc691585c, Offset: 0x88
// Size: 0x99
function airdrop_escort_init()
{
    killstreaks::registerkillstreak( "airdrop_escort", &airdrop_escort::function_fb85603965ac497a );
    utility::registersharedfunc( #"airdrop_escort", #"attachxrays", &airdrop_escort_attachxrays );
    bundle = level.streakglobals.streakbundles[ "airdrop_escort" ];
    
    if ( bundle.var_442269833ef7493a )
    {
        killstreaks::registerkillstreakdamagedealingweapon( "airdrop_escort", bundle.var_442269833ef7493a, #"large" );
    }
    
    callback::add( #"player_death", &on_player_killed );
}

// Namespace airdrop_escort_mp
// Params 1
// Checksum 0x905761a0, Offset: 0x129
// Size: 0x22
function airdrop_escort_attachxrays( escortheli )
{
    escortheli setentityhudoutlinedata( 3, escortheli.team );
    return escortheli;
}

// Namespace airdrop_escort_mp
// Params 1
// Checksum 0x69c83882, Offset: 0x154
// Size: 0xd4
function on_player_killed( deathdata )
{
    if ( !isdefined( deathdata.objweapon ) )
    {
        return;
    }
    
    killstreakweaponname = killstreak::getkillstreaknamefromweapon( deathdata.objweapon );
    is_airdrop_escort = killstreakweaponname == "airdrop_escort";
    
    if ( !is_airdrop_escort )
    {
        return;
    }
    
    if ( !isdefined( deathdata.attacker.var_2caafa207b756de9 ) )
    {
        deathdata.attacker.var_2caafa207b756de9 = 1;
    }
    else
    {
        deathdata.attacker.var_2caafa207b756de9++;
    }
    
    if ( deathdata.attacker.var_2caafa207b756de9 == 3 )
    {
        deathdata.attacker thread points::doscoreevent( #"escort_chopper_triple" );
    }
}

