// script_3b427596a0a3f036  (hash_3b427596a0a3f036.gscc) (size: 1311 Bytes / 0x51f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8868c021 (2288566305)
// size ...... 1311 (0x51f)
// includes .. 2   (offset: 0x503)
// strings ... 1   (offset: 0x513)
// dev strs .. 0   (offset: 0x51f)
// exports ... 6   (offset: 0x2f7)
// cseg ...... 0xa7 + 0x250 (0x2f7)
// imports ... 10  (offset: 0x3e7)
// animtree1 . 0   (offset: 0x51f)
// animtree2 . 0   (offset: 0x51f)
#using scripts\common\callbacks;
#using scripts\mp\armor;

#namespace specialty_armor_on_kill;

// Namespace specialty_armor_on_kill
// Params 0, eflags: 0x1
// Checksum 0x8cf2a8f9, Offset: 0xc5
// Size: 0x2e
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
    level callback::add( #"player_death", &onplayerkilled );
}

// Namespace specialty_armor_on_kill
// Params 1
// Checksum 0x5668543e, Offset: 0xfb
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_armor_on_kill", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_armor_on_kill
// Params 0
// Checksum 0xbdef29cd, Offset: 0x13d
// Size: 0x49
function setspecialty()
{
    bundle = self.var_9842326056fd7207;
    self.var_3fb76470a46d1a74 = { #type:bundle.var_4a6d552e9c12a7d7, #amount:bundle.var_446e490576d3f5c0 };
}

// Namespace specialty_armor_on_kill
// Params 0
// Checksum 0xf0f06c78, Offset: 0x18e
// Size: 0xc
function unsetspecialty()
{
    self.var_3fb76470a46d1a74 = undefined;
}

// Namespace specialty_armor_on_kill
// Params 1
// Checksum 0xf4722052, Offset: 0x1a2
// Size: 0x155
function onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    armorchange = 0;
    
    if ( attacker.var_3fb76470a46d1a74 && attacker != victim && attacker.team != victim.team )
    {
        amount = attacker.var_3fb76470a46d1a74.amount;
        
        if ( !isdefined( amount ) )
        {
            return;
        }
        
        switch ( attacker.var_3fb76470a46d1a74.type )
        {
            case #"hash_f764e81c86d1a274":
                armorchange = amount;
                break;
            case #"hash_7c7c0cdffe207815":
                armorchange = amount / 100 * attacker.maxarmorhealth;
                break;
            case #"hash_9662a5dbe1fadf4":
                armorchange = attacker armor::function_cb22658f54166b6b() * amount;
                break;
            case #"hash_db653a4972b3c13b":
            default:
                return;
        }
        
        armoramount = int( clamp( attacker armor::getarmorhealth() + armorchange, 0, attacker.maxarmorhealth ) );
        attacker armor::setarmorhealth( armoramount );
    }
}

