// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_vehicle_attack.gsc  (hash_1908d1145a408ace.gscc) (size: 807 Bytes / 0x327 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaabaa405 (2864358405)
// size ...... 807 (0x327)
// includes .. 2   (offset: 0x2c7)
// strings ... 5   (offset: 0x2d7)
// dev strs .. 0   (offset: 0x327)
// exports ... 4   (offset: 0x1bb)
// cseg ...... 0xce + 0xed (0x1bb)
// imports ... 3   (offset: 0x25b)
// animtree1 . 0   (offset: 0x327)
// animtree2 . 0   (offset: 0x327)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;

#namespace zombie_callisto_vehicle_attack;

// Namespace zombie_callisto_vehicle_attack
// Params 0
// Checksum 0x48773042, Offset: 0xec
// Size: 0xe
function init_zombie_callisto_vehicle_attack()
{
    self function_786bb6aa1b76c7ee( "in_vehicle_attack_mode", 0 );
}

// Namespace zombie_callisto_vehicle_attack
// Params 2
// Checksum 0x8a505c69, Offset: 0x102
// Size: 0x5d, Type: bool
function function_c18aad3ce469374( taskid, params )
{
    self function_786bb6aa1b76c7ee( "in_vehicle_attack_mode", 1 );
    zombie_utils::function_a8ce00e0448cb6f0( "super_sprint", "callisto_vehicle_attack", 4 );
    callback::callback( "on_in_vehicle_mode_changed" );
    self function_786bb6aa1b76c7ee( "charge_cooldown", self.charge_cooldown / 2 );
    return true;
}

// Namespace zombie_callisto_vehicle_attack
// Params 2
// Checksum 0x73f93ce5, Offset: 0x168
// Size: 0x52, Type: bool
function function_91fb4b1f21381574( taskid, params )
{
    self function_786bb6aa1b76c7ee( "in_vehicle_attack_mode", 0 );
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "callisto_vehicle_attack", 4 );
    callback::callback( "on_in_vehicle_mode_changed" );
    self function_786bb6aa1b76c7ee( "charge_cooldown", self.charge_cooldown );
    return true;
}

