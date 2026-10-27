// scripts\mp\common\killstreaks\cluster_spike_mp.gsc  (hash_16de173bedb21c7f.gscc) (size: 523 Bytes / 0x20b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3382ced (2738367725)
// size ...... 523 (0x20b)
// includes .. 3   (offset: 0x1e7)
// strings ... 1   (offset: 0x1ff)
// dev strs .. 0   (offset: 0x20b)
// exports ... 3   (offset: 0xe3)
// cseg ...... 0x69 + 0x7a (0xe3)
// imports ... 5   (offset: 0x15b)
// animtree1 . 0   (offset: 0x20b)
// animtree2 . 0   (offset: 0x20b)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\cluster_spike;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace cluster_spike_mp;

// Namespace cluster_spike_mp
// Params 0
// Checksum 0x6b3120, Offset: 0x87
// Size: 0x31
function init()
{
    killstreaks::registerkillstreak( "cluster_spike", &cluster_spike::function_86ac47cc74fcc4cf );
    utility::registersharedfunc( #"cluster_spike", #"attachxrays", &cluster_spike_attachxrays );
}

// Namespace cluster_spike_mp
// Params 1
// Checksum 0xbfc65688, Offset: 0xc0
// Size: 0x22
function cluster_spike_attachxrays( clusterspike )
{
    clusterspike setentityhudoutlinedata( 3, clusterspike.team );
    return clusterspike;
}

