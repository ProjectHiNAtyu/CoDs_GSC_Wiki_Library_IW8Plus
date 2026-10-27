// script_39fb6a2afbc9132c  (hash_39fb6a2afbc9132c.gscc) (size: 829 Bytes / 0x33d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xccceeb0d (3436112653)
// size ...... 829 (0x33d)
// includes .. 2   (offset: 0x321)
// strings ... 1   (offset: 0x331)
// dev strs .. 0   (offset: 0x33d)
// exports ... 5   (offset: 0x1c9)
// cseg ...... 0x77 + 0x152 (0x1c9)
// imports ... 5   (offset: 0x291)
// animtree1 . 0   (offset: 0x33d)
// animtree2 . 0   (offset: 0x33d)
#using scripts\common\callbacks;
#using scripts\mp\weapons;

#namespace specialty_viewkick_override;

// Namespace specialty_viewkick_override
// Params 0, eflags: 0x1
// Checksum 0x40041209, Offset: 0x95
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_viewkick_override
// Params 1
// Checksum 0x317d7492, Offset: 0xb5
// Size: 0x3a
function registerperk( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_viewkick_override", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_viewkick_override
// Params 0
// Checksum 0x49e05f51, Offset: 0xf7
// Size: 0x99
function setspecialty()
{
    self.overrideviewkickscale = self.var_9842326056fd7207.overrideviewkickscale ?? 0.7;
    self.overrideviewkickscaledmr = self.var_9842326056fd7207.overrideviewkickscaledmr ?? 0.7;
    self.overrideviewkickscalesniper = self.var_9842326056fd7207.overrideviewkickscalesniper ?? 0.7;
    self.overrideviewkickscalepistol = self.var_9842326056fd7207.overrideviewkickscalepistol ?? 0.7;
    weapons::updateviewkickscale();
}

// Namespace specialty_viewkick_override
// Params 0
// Checksum 0x82bfb212, Offset: 0x198
// Size: 0x31
function unsetspecialty()
{
    self.overrideviewkickscale = undefined;
    self.overrideviewkickscaledmr = undefined;
    self.overrideviewkickscalesniper = undefined;
    self.overrideviewkickscalepistol = undefined;
    weapons::updateviewkickscale();
}

