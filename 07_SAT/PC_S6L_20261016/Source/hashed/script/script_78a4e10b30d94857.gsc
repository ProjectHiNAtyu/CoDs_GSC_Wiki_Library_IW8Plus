// script_78a4e10b30d94857  (hash_78a4e10b30d94857.gscc) (size: 1264 Bytes / 0x4f0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x99e26ff4 (2581753844)
// size ...... 1264 (0x4f0)
// includes .. 3   (offset: 0x4c0)
// strings ... 2   (offset: 0x4d8)
// dev strs .. 0   (offset: 0x4f0)
// exports ... 6   (offset: 0x2d4)
// cseg ...... 0x9b + 0x239 (0x2d4)
// imports ... 9   (offset: 0x3c4)
// animtree1 . 0   (offset: 0x4f0)
// animtree2 . 0   (offset: 0x4f0)
#using scripts\common\callbacks;
#using scripts\common\weapon;
#using scripts\mp\damage;

#namespace specialty_killstreak_damage_resist;

// Namespace specialty_killstreak_damage_resist
// Params 0, eflags: 0x1
// Checksum 0xa32a4271, Offset: 0xb9
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_killstreak_damage_resist
// Params 1
// Checksum 0x23bc2ea0, Offset: 0xd9
// Size: 0x44
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_killstreak_damage_resist", &setspecialty, &unsetspecialty );
        damage::function_3232791951a34daf( &function_70690763f4549171 );
    }
}

// Namespace specialty_killstreak_damage_resist
// Params 0
// Checksum 0x83b691ba, Offset: 0x125
// Size: 0xb8
function setspecialty()
{
    bundle = self.var_9842326056fd7207;
    self.var_10a34e2a1775fd9d = [];
    
    foreach ( struct in bundle.var_10a34e2a1775fd9d )
    {
        self.var_10a34e2a1775fd9d[ struct.killstreakref ] = 1 - struct.resistpercent / 100;
    }
}

// Namespace specialty_killstreak_damage_resist
// Params 0
// Checksum 0x705ac90d, Offset: 0x1e5
// Size: 0xc
function unsetspecialty()
{
    self.var_10a34e2a1775fd9d = undefined;
}

// Namespace specialty_killstreak_damage_resist
// Params 11
// Checksum 0xfdccbc7f, Offset: 0x1f9
// Size: 0xda
function function_70690763f4549171( eattacker, einflictor, victim, idamage, objweapon, smeansofdeath, shitloc, idflags, var_cdd29ad5d1362c2, partname, unmodifieddamage )
{
    if ( victim.var_10a34e2a1775fd9d && weapon::iskillstreakweapon( objweapon ) )
    {
        killstreakref = level.killstreakweaponmap[ weapon::getweaponname( objweapon ) ];
        
        if ( killstreakref && isdefined( victim.var_10a34e2a1775fd9d[ killstreakref ] ) )
        {
            eattacker.var_82381c5b677c4f5f = "hitkillstreakdamageresist";
            return ( idamage * victim.var_10a34e2a1775fd9d[ killstreakref ] );
        }
    }
    
    return idamage;
}

