// script_450251d7faaeb638  (hash_450251d7faaeb638.gscc) (size: 882 Bytes / 0x372 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d5c5752 (1297897298)
// size ...... 882 (0x372)
// includes .. 2   (offset: 0x356)
// strings ... 1   (offset: 0x366)
// dev strs .. 0   (offset: 0x372)
// exports ... 6   (offset: 0x182)
// cseg ...... 0x75 + 0x10d (0x182)
// imports ... 8   (offset: 0x272)
// animtree1 . 0   (offset: 0x372)
// animtree2 . 0   (offset: 0x372)
#using scripts\common\callbacks;
#using scripts\mp\armor;

#namespace specialty_tempered_effect;

// Namespace specialty_tempered_effect
// Params 0, eflags: 0x1
// Checksum 0x6716f9ca, Offset: 0x93
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_tempered_effect
// Params 1
// Checksum 0xaf5ec825, Offset: 0xb3
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_tempered_effect", &function_af198edb12d5951f, &function_d91f441ad23fe37e, [] );
    }
}

// Namespace specialty_tempered_effect
// Params 0
// Checksum 0xb1bb7708, Offset: 0xf5
// Size: 0x24
function function_af198edb12d5951f()
{
    self.var_84193fdcc9a49702 = &function_1b488e48e206eb59;
    self.var_cb082b28bfcfde57 = 1;
    armor::setarmoromnvars( 1 );
}

// Namespace specialty_tempered_effect
// Params 0
// Checksum 0xff01b7c3, Offset: 0x121
// Size: 0x1f
function function_d91f441ad23fe37e()
{
    self.var_84193fdcc9a49702 = undefined;
    self.var_cb082b28bfcfde57 = undefined;
    armor::setarmoromnvars( 1 );
}

// Namespace specialty_tempered_effect
// Params 0
// Checksum 0x8d163a83, Offset: 0x148
// Size: 0x39
function function_1b488e48e206eb59()
{
    var_7f13e861765071dd = armor::function_3988e68b87d5acc0();
    
    if ( var_7f13e861765071dd > 1 )
    {
        return ceil( self.maxarmorhealth / ( var_7f13e861765071dd - 1 ) );
    }
    
    return self.maxarmorhealth;
}

