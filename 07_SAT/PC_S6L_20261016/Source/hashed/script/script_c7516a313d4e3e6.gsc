// script_c7516a313d4e3e6  (hash_0c7516a313d4e3e6.gscc) (size: 689 Bytes / 0x2b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x502a1dcf (1344937423)
// size ...... 689 (0x2b1)
// includes .. 1   (offset: 0x29d)
// strings ... 1   (offset: 0x2a5)
// dev strs .. 0   (offset: 0x2b1)
// exports ... 5   (offset: 0x165)
// cseg ...... 0x76 + 0xef (0x165)
// imports ... 4   (offset: 0x22d)
// animtree1 . 0   (offset: 0x2b1)
// animtree2 . 0   (offset: 0x2b1)
#using scripts\common\callbacks;

#namespace specialty_reviver_time_mod;

// Namespace specialty_reviver_time_mod
// Params 0, eflags: 0x1
// Checksum 0x6d2cffe9, Offset: 0x94
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_reviver_time_mod
// Params 1
// Checksum 0x3e96b4f7, Offset: 0xb4
// Size: 0x38
function registerspecialty( params )
{
    if ( params.var_bf34439fc0ca3cec )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_reviver_time_mod", &setspecialty, &unsetspecialty );
    }
}

// Namespace specialty_reviver_time_mod
// Params 0
// Checksum 0x903b7230, Offset: 0xf4
// Size: 0x5d
function setspecialty()
{
    if ( !isdefined( self.var_9842326056fd7207.var_e00586a2cf682662 ) )
    {
        return;
    }
    
    self.var_ee80ad773b7fac32 = { #var_81cdaf2a2b747524:self.var_9842326056fd7207.var_81cdaf2a2b747524, #var_996add39bd6ff1a5:self.var_9842326056fd7207.var_e00586a2cf682662 };
}

// Namespace specialty_reviver_time_mod
// Params 0
// Checksum 0x4c33b572, Offset: 0x159
// Size: 0xc
function unsetspecialty()
{
    self.var_ee80ad773b7fac32 = undefined;
}

