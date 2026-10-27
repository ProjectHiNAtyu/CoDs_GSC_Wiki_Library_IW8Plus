// script_24f5e2e7c0f3c3b8  (hash_24f5e2e7c0f3c3b8.gscc) (size: 798 Bytes / 0x31e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5ba61d4d (1537613133)
// size ...... 798 (0x31e)
// includes .. 4   (offset: 0x2e2)
// strings ... 2   (offset: 0x302)
// dev strs .. 0   (offset: 0x31e)
// exports ... 5   (offset: 0x172)
// cseg ...... 0x92 + 0xe0 (0x172)
// imports ... 6   (offset: 0x23a)
// animtree1 . 0   (offset: 0x31e)
// animtree2 . 0   (offset: 0x31e)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\playerhealth;

#namespace specialty_regen_on_kill;

// Namespace specialty_regen_on_kill
// Params 0, eflags: 0x1
// Checksum 0xaa49e3c9, Offset: 0xb0
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_20d94ce7f5983b2d );
}

// Namespace specialty_regen_on_kill
// Params 1
// Checksum 0x6ab7bbdd, Offset: 0xd0
// Size: 0x32
function function_20d94ce7f5983b2d( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_regen_on_kill", undefined, undefined, [] );
    }
}

// Namespace specialty_regen_on_kill
// Params 0
// Checksum 0x1a0eb226, Offset: 0x10a
// Size: 0x20
function function_ebc0f517472c9f87()
{
    utility::registersharedfunc( #"specialty_regen_on_kill", #"hash_cb25570acaf94493", &regenonkill );
}

// Namespace specialty_regen_on_kill
// Params 0
// Checksum 0x8733edd2, Offset: 0x132
// Size: 0x40
function regenonkill()
{
    if ( self.health < self.maxhealth && isdefined( self.perks[ "specialty_compression_plate" ] ) )
    {
        namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_compression_plate" );
    }
    
    playerhealth::forcehealthregen( self );
}

