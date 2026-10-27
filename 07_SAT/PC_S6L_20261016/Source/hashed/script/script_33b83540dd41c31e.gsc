// script_33b83540dd41c31e  (hash_33b83540dd41c31e.gscc) (size: 1239 Bytes / 0x4d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a8b89d7 (982223319)
// size ...... 1239 (0x4d7)
// includes .. 3   (offset: 0x463)
// strings ... 7   (offset: 0x47b)
// dev strs .. 0   (offset: 0x4d7)
// exports ... 5   (offset: 0x263)
// cseg ...... 0xcb + 0x198 (0x263)
// imports ... 11  (offset: 0x32b)
// animtree1 . 0   (offset: 0x4d7)
// animtree2 . 0   (offset: 0x4d7)
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\escort_horde_abilities;

#namespace namespace_af34561ae58dc984;

// Namespace namespace_af34561ae58dc984
// Params 0
// Checksum 0xb05b4bd3, Offset: 0xe9
// Size: 0x51
function function_2c1cc592752509c9()
{
    escort_horde_abilities::addpowerbutton( level.mutationgametype.zombie, "gas", "+smoke", &function_18d8012feb7d3ed0, 0, &function_3b6933a9f5769171, &function_a8c714564dd2b1cc, &function_3b6933a9f5769171, &"hash_10c38a160e3187ce", undefined, 15, "gasGrenadeStatus", "gasGrenadeProgress" );
}

// Namespace namespace_af34561ae58dc984
// Params 2
// Checksum 0x7be5889, Offset: 0x142
// Size: 0x34
function function_3b6933a9f5769171( powerstruct, powerref )
{
    equipment_mp::giveequipment( "equip_gas_grenade", "secondary" );
    equipment_mp::setequipmentslotammo( "secondary", 1 );
}

// Namespace namespace_af34561ae58dc984
// Params 2
// Checksum 0xd83bdcf8, Offset: 0x17e
// Size: 0xbc
function function_18d8012feb7d3ed0( powerstruct, powerref )
{
    level endon( #"game_ended" );
    self endon( #"offhand_end" );
    self endon( #"zombie_unset" );
    self endon( #"death_or_disconnect" );
    self waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
    
    if ( !weapon::grenadethrown( grenade ) )
    {
        return;
    }
    
    self playsound( "zxp_grenade_vo_npc", self, self );
    thread escort_horde_abilities::function_307e8b021dbec2b9( powerstruct, powerref );
    wait 0.25;
    function_a8c714564dd2b1cc( powerstruct, powerref );
    self notify( #"gas_grenade_finished" );
}

// Namespace namespace_af34561ae58dc984
// Params 2
// Checksum 0x5dbabd8b, Offset: 0x242
// Size: 0x21
function function_a8c714564dd2b1cc( powerstruct, powerref )
{
    equipment_mp::takeequipment( "secondary" );
}

