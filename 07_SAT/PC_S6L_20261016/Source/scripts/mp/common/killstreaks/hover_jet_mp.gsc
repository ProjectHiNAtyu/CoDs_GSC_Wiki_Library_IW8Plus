// scripts\mp\common\killstreaks\hover_jet_mp.gsc  (hash_390e412343e6f124.gscc) (size: 700 Bytes / 0x2bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd3b7d49 (3711663433)
// size ...... 700 (0x2bc)
// includes .. 5   (offset: 0x280)
// strings ... 1   (offset: 0x2a8)
// dev strs .. 0   (offset: 0x2bc)
// exports ... 4   (offset: 0x118)
// cseg ...... 0x65 + 0xb3 (0x118)
// imports ... 7   (offset: 0x1b8)
// animtree1 . 0   (offset: 0x2bc)
// animtree2 . 0   (offset: 0x2bc)
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\mp\common\killstreaks\hover_jet;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\sentientpoolmanager;

#namespace hover_jet_mp;

// Namespace hover_jet_mp
// Params 0
// Checksum 0xb038185a, Offset: 0x83
// Size: 0x47
function init()
{
    killstreaks::registerkillstreak( "hover_jet", &hover_jet::tryusehoverjetfromstruct );
    utility::registersharedfunc( "hover_jet", #"set_vehicle_hit_damage_data", &function_6391e1672631fc73 );
    utility::registersharedfunc( "hover_jet", #"registersentient", &hover_jet_registersentient );
}

// Namespace hover_jet_mp
// Params 2
// Checksum 0x17a630bd, Offset: 0xd2
// Size: 0x1f
function function_6391e1672631fc73( ref, hitstokill )
{
    vehicle_damage::set_vehicle_hit_damage_data( ref, hitstokill );
}

// Namespace hover_jet_mp
// Params 2
// Checksum 0xd3099116, Offset: 0xf9
// Size: 0x1f
function hover_jet_registersentient( threatbiasgroup, var_7abeff39c291fc41 )
{
    sentientpoolmanager::registersentient( threatbiasgroup, var_7abeff39c291fc41 );
}

