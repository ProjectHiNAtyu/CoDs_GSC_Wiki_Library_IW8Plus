// scripts\mp\common\perks\perk_staminup_mp.gsc  (hash_42b1639fa84c2576.gscc) (size: 1153 Bytes / 0x481 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5d25559f (1562727839)
// size ...... 1153 (0x481)
// includes .. 2   (offset: 0x419)
// strings ... 7   (offset: 0x429)
// dev strs .. 0   (offset: 0x481)
// exports ... 7   (offset: 0x239)
// cseg ...... 0x10c + 0x12d (0x239)
// imports ... 7   (offset: 0x351)
// animtree1 . 0   (offset: 0x481)
// animtree2 . 0   (offset: 0x481)
#using scripts\common\callbacks;
#using scripts\mp\weapons;

#namespace perk_staminup_mp;

// Namespace perk_staminup_mp
// Params 0, eflags: 0x1
// Checksum 0x46640cf9, Offset: 0x12a
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &perk_register );
}

// Namespace perk_staminup_mp
// Params 1
// Checksum 0x63bc4cb5, Offset: 0x14a
// Size: 0x93
function perk_register( params )
{
    bundle = level.perkbundles[ "specialty_staminup" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_staminup", &perk_set, &perk_unset, [ "specialty_fastsprintrecovery", "specialty_sprintfire", "specialty_sprintads", "specialty_sprintmelee", "specialty_sliding_ads", "specialty_walljump_buffed" ] );
    }
}

// Namespace perk_staminup_mp
// Params 0
// Checksum 0xae65e5c7, Offset: 0x1e5
// Size: 0x9
function perk_set()
{
    function_3a6756e887f529ee();
}

// Namespace perk_staminup_mp
// Params 0
// Checksum 0x9c0de322, Offset: 0x1f6
// Size: 0x9
function perk_unset()
{
    function_95338b0d45bd7965();
}

// Namespace perk_staminup_mp
// Params 0
// Checksum 0x1c6c9f52, Offset: 0x207
// Size: 0x17
function function_3a6756e887f529ee()
{
    self.overrideweaponspeed_speedscale = 1.07;
    weapons::updatemovespeedscale();
}

// Namespace perk_staminup_mp
// Params 0
// Checksum 0x49f646c0, Offset: 0x226
// Size: 0x13
function function_95338b0d45bd7965()
{
    self.overrideweaponspeed_speedscale = undefined;
    weapons::updatemovespeedscale();
}

