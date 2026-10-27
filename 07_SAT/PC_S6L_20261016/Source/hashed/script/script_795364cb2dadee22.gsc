// script_795364cb2dadee22  (hash_795364cb2dadee22.gscc) (size: 783 Bytes / 0x30f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38fe0658 (956171864)
// size ...... 783 (0x30f)
// includes .. 2   (offset: 0x2e3)
// strings ... 2   (offset: 0x2f3)
// dev strs .. 0   (offset: 0x30f)
// exports ... 5   (offset: 0x173)
// cseg ...... 0x8b + 0xe8 (0x173)
// imports ... 6   (offset: 0x23b)
// animtree1 . 0   (offset: 0x30f)
// animtree2 . 0   (offset: 0x30f)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;

#namespace specialty_supersprintreload;

// Namespace specialty_supersprintreload
// Params 0, eflags: 0x1
// Checksum 0x62d97f96, Offset: 0xa9
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_supersprintreload
// Params 1
// Checksum 0x1d480fe, Offset: 0xc9
// Size: 0x32
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_supersprintreload", undefined, undefined, [] );
    }
}

// Namespace specialty_supersprintreload
// Params 0
// Checksum 0xb6f6094b, Offset: 0x103
// Size: 0x9
function function_8c90221c6542cfae()
{
    thread function_d5d2681ccc0dee46();
}

// Namespace specialty_supersprintreload
// Params 0
// Checksum 0xe31ba89, Offset: 0x114
// Size: 0x5f
function function_d5d2681ccc0dee46()
{
    self notify( #"hash_2e76f1a2e9ec4a7d" );
    self endon( #"hash_2e76f1a2e9ec4a7d" );
    self endon( #"death_or_disconnect" );
    
    while ( self issupersprinting() && self isreloading() )
    {
        if ( isdefined( self.perks[ "specialty_gungho" ] ) )
        {
            namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_gungho" );
        }
        
        wait 0.5;
    }
}

