// scripts\asm\soldier\custom.gsc  (hash_15911d67a81b41fa.gscc) (size: 892 Bytes / 0x37c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8d3922ea (2369331946)
// size ...... 892 (0x37c)
// includes .. 2   (offset: 0x36c)
// strings ... 0   (offset: 0x37c)
// dev strs .. 0   (offset: 0x37c)
// exports ... 7   (offset: 0x1fc)
// cseg ...... 0x58 + 0x1a4 (0x1fc)
// imports ... 3   (offset: 0x314)
// animtree1 . 0   (offset: 0x37c)
// animtree2 . 0   (offset: 0x37c)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;

#namespace custom;

// Namespace custom
// Params 4
// Checksum 0xdab0821e, Offset: 0x76
// Size: 0x3d, Type: bool
function shouldstartcustomidle( asmname, statename, tostatename, params )
{
    self notify( #"cap_custom_arrival" );
    return isdefined( self.var_a8a291466167d301 );
}

// Namespace custom
// Params 4
// Checksum 0x9cd44507, Offset: 0xbc
// Size: 0x3b, Type: bool
function shouldcustomexit( asmname, statename, tostatename, params )
{
    return asm_bb::bb_moverequested() && isdefined( self.var_14a566d25ec03787 );
}

// Namespace custom
// Params 4
// Checksum 0xe5b73167, Offset: 0x100
// Size: 0x32, Type: bool
function shouldstopcustomidle( asmname, statename, tostatename, params )
{
    return !isdefined( self.var_a8a291466167d301 );
}

// Namespace custom
// Params 3
// Checksum 0x2d46db89, Offset: 0x13b
// Size: 0x41
function chooseanim_customidle( asmname, statename, params )
{
    assert( isdefined( self.var_a8a291466167d301 ) );
    return asm::asm_getrandomanim( asmname, self.var_a8a291466167d301 );
}

// Namespace custom
// Params 4
// Checksum 0xede40232, Offset: 0x185
// Size: 0x31, Type: bool
function function_b5e61199ec6db98a( asmname, statename, tostatename, params )
{
    return isdefined( self.customarrivalhandler );
}

// Namespace custom
// Params 3
// Checksum 0xe386a34a, Offset: 0x1bf
// Size: 0x3d
function function_1ea336606bece3cb( asmname, statename, params )
{
    assert( isdefined( self.customarrivalhandler ) );
    self [[ self.customarrivalhandler ]]();
}

