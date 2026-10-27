// scripts\mp\zm\systems\agent_manager.gsc  (hash_1eaed13c599e2b34.gscc) (size: 410 Bytes / 0x19a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc080cee0 (3229667040)
// size ...... 410 (0x19a)
// includes .. 2   (offset: 0x18a)
// strings ... 0   (offset: 0x19a)
// dev strs .. 0   (offset: 0x19a)
// exports ... 2   (offset: 0xe6)
// cseg ...... 0x58 + 0x8e (0xe6)
// imports ... 3   (offset: 0x136)
// animtree1 . 0   (offset: 0x19a)
// animtree2 . 0   (offset: 0x19a)
#using scripts\mp\mp_agent;
#using scripts\mp\zm\zm_utility;

#namespace agent_manager;

// Namespace agent_manager
// Params 4
// Checksum 0x9f3023d4, Offset: 0x76
// Size: 0x6f
function spawn_agent( var_bc661ad67960c4e3, position, angles = ( 0, 0, 0 ), team = zm_utility::get_zombie_team() )
{
    var_bc661ad67960c4e3 = function_b3988325430ce242( var_bc661ad67960c4e3 ) ?? var_bc661ad67960c4e3;
    agent = mp_agent::spawnnewagentaitype( var_bc661ad67960c4e3, position, angles, team );
    return agent;
}

