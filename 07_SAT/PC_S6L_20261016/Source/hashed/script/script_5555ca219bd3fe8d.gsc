// script_5555ca219bd3fe8d  (hash_5555ca219bd3fe8d.gscc) (size: 689 Bytes / 0x2b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ab87964 (985168228)
// size ...... 689 (0x2b1)
// includes .. 1   (offset: 0x29d)
// strings ... 1   (offset: 0x2a5)
// dev strs .. 0   (offset: 0x2b1)
// exports ... 5   (offset: 0x145)
// cseg ...... 0x74 + 0xd1 (0x145)
// imports ... 5   (offset: 0x20d)
// animtree1 . 0   (offset: 0x2b1)
// animtree2 . 0   (offset: 0x2b1)
#using scripts\common\callbacks;

#namespace specialty_grenade_expert;

// Namespace specialty_grenade_expert
// Params 0, eflags: 0x1
// Checksum 0xf7a7e53e, Offset: 0x92
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_grenade_expert
// Params 1
// Checksum 0xa41dae38, Offset: 0xb2
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_grenade_expert", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_grenade_expert
// Params 0
// Checksum 0x6a789c68, Offset: 0xf4
// Size: 0x35
function setspecialty()
{
    self.var_4e965e2c106162e3 = self.var_9842326056fd7207.var_4e965e2c106162e3 ?? 1.15;
    self setgrenadethrowscale( self.var_4e965e2c106162e3 );
}

// Namespace specialty_grenade_expert
// Params 0
// Checksum 0xbf53915a, Offset: 0x131
// Size: 0x14
function unsetspecialty()
{
    self.var_4e965e2c106162e3 = undefined;
    self setgrenadethrowscale( 1 );
}

