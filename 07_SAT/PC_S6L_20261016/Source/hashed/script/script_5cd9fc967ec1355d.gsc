// script_5cd9fc967ec1355d  (hash_5cd9fc967ec1355d.gscc) (size: 629 Bytes / 0x275 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a32c66 (161688678)
// size ...... 629 (0x275)
// includes .. 1   (offset: 0x261)
// strings ... 1   (offset: 0x269)
// dev strs .. 0   (offset: 0x275)
// exports ... 5   (offset: 0x129)
// cseg ...... 0x88 + 0xa1 (0x129)
// imports ... 4   (offset: 0x1f1)
// animtree1 . 0   (offset: 0x275)
// animtree2 . 0   (offset: 0x275)
#using scripts\common\callbacks;

#namespace specialty_enemy_proximity_awareness_immunity;

// Namespace specialty_enemy_proximity_awareness_immunity
// Params 0, eflags: 0x1
// Checksum 0xabd1f194, Offset: 0xa6
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_enemy_proximity_awareness_immunity
// Params 1
// Checksum 0xf8903ddb, Offset: 0xc6
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_enemy_proximity_awareness_immunity", &function_594cb0735525551a, &function_31aa28c7a2831dc5, [] );
    }
}

// Namespace specialty_enemy_proximity_awareness_immunity
// Params 0
// Checksum 0x94e4fde0, Offset: 0x108
// Size: 0xd
function function_594cb0735525551a()
{
    self.var_d8921f45ab85950 = 1;
}

// Namespace specialty_enemy_proximity_awareness_immunity
// Params 0
// Checksum 0xa4a8cefd, Offset: 0x11d
// Size: 0xc
function function_31aa28c7a2831dc5()
{
    self.var_d8921f45ab85950 = undefined;
}

