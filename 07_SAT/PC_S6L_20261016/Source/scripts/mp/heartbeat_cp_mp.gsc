// scripts\mp\heartbeat_cp_mp.gsc  (hash_084977d9cd3a7282.gscc) (size: 566 Bytes / 0x236 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4eee1b8d (1324227469)
// size ...... 566 (0x236)
// includes .. 2   (offset: 0x226)
// strings ... 0   (offset: 0x236)
// dev strs .. 0   (offset: 0x236)
// exports ... 4   (offset: 0xde)
// cseg ...... 0x58 + 0x86 (0xde)
// imports ... 6   (offset: 0x17e)
// animtree1 . 0   (offset: 0x236)
// animtree2 . 0   (offset: 0x236)
#using scripts\common\callbacks;
#using scripts\common\heartbeat;

#namespace heartbeat_cp_mp;

// Namespace heartbeat_cp_mp
// Params 0
// Checksum 0x2c5a953b, Offset: 0x76
// Size: 0x23
function main()
{
    heartbeat::initcommonheartbeat( &playsoundfunc );
    callback::add( #"player_spawned", &function_c28a3bdcde55eed9 );
}

// Namespace heartbeat_cp_mp
// Params 1
// Checksum 0x20ca91f8, Offset: 0xa1
// Size: 0x13
function function_c28a3bdcde55eed9( params )
{
    thread heartbeat::function_a9498ed6ab4895f0();
}

// Namespace heartbeat_cp_mp
// Params 1
// Checksum 0x8375358e, Offset: 0xbc
// Size: 0x22
function playsoundfunc( firstpersonalias )
{
    self playlocalsound( firstpersonalias, undefined, 1 );
    self.heartbeatalias = firstpersonalias;
}

