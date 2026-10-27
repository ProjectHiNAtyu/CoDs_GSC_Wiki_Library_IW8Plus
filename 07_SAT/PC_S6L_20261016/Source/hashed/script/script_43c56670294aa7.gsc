// script_43c56670294aa7  (hash_0043c56670294aa7.gscc) (size: 824 Bytes / 0x338 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xddbe6e83 (3720244867)
// size ...... 824 (0x338)
// includes .. 1   (offset: 0x314)
// strings ... 2   (offset: 0x31c)
// dev strs .. 0   (offset: 0x338)
// exports ... 6   (offset: 0x198)
// cseg ...... 0x9f + 0xf9 (0x198)
// imports ... 5   (offset: 0x288)
// animtree1 . 0   (offset: 0x338)
// animtree2 . 0   (offset: 0x338)
#using scripts\common\callbacks;

#namespace specialty_combat_medic;

// Namespace specialty_combat_medic
// Params 0, eflags: 0x1
// Checksum 0x67ffe8c9, Offset: 0xbd
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_combat_medic
// Params 1
// Checksum 0xc500eb64, Offset: 0xdd
// Size: 0x6b
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_combat_medic" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_combat_medic", &setcombatmedic, &unsetcombatmedic, [ "specialty_reduce_regen_delay_on_objective" ], &initcombatmedic );
    }
}

// Namespace specialty_combat_medic
// Params 0
// Checksum 0x25f7b8b0, Offset: 0x150
// Size: 0x2
function initcombatmedic()
{
    
}

// Namespace specialty_combat_medic
// Params 0
// Checksum 0x6e5571cb, Offset: 0x15a
// Size: 0x26
function setcombatmedic()
{
    self.var_769791b1979771c8 = self.var_9842326056fd7207.var_6189f9d557ce572e ?? 1;
}

// Namespace specialty_combat_medic
// Params 0
// Checksum 0x606e284, Offset: 0x188
// Size: 0x10
function unsetcombatmedic()
{
    self.var_769791b1979771c8 = 1;
}

