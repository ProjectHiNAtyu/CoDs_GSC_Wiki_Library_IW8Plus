// script_1243911b5893214a  (hash_1243911b5893214a.gscc) (size: 659 Bytes / 0x293 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe8adcbb (243981499)
// size ...... 659 (0x293)
// includes .. 1   (offset: 0x273)
// strings ... 2   (offset: 0x27b)
// dev strs .. 0   (offset: 0x293)
// exports ... 4   (offset: 0x177)
// cseg ...... 0x72 + 0x105 (0x177)
// imports ... 3   (offset: 0x217)
// animtree1 . 0   (offset: 0x293)
// animtree2 . 0   (offset: 0x293)
#using scripts\asm\asm;

#namespace zombie_melee_asm;

// Namespace zombie_melee_asm
// Params 1
// Checksum 0x26d7a5c1, Offset: 0x90
// Size: 0x25
function register_melee_state( state_name )
{
    assert( isstring( state_name ) );
    self.var_878a729dd9083870 = state_name;
}

// Namespace zombie_melee_asm
// Params 2
// Checksum 0x4ab7596e, Offset: 0xbd
// Size: 0x2b
function function_d5c5dea62200a953( var_f5892c3814093795, var_3b9e4a3352ba8b8b )
{
    self.var_f5892c3814093795 = var_f5892c3814093795;
    self.var_3b9e4a3352ba8b8b = var_3b9e4a3352ba8b8b;
}

// Namespace zombie_melee_asm
// Params 0
// Checksum 0xa377ecd, Offset: 0xf0
// Size: 0x87
function request_melee_asm_state()
{
    if ( isdefined( self.var_f5892c3814093795 ) )
    {
        var_63980231c864f4c2 = [[ self.var_f5892c3814093795 ]]();
        
        if ( var_63980231c864f4c2 )
        {
            assert( isdefined( self.var_3b9e4a3352ba8b8b ) );
            [[ self.var_3b9e4a3352ba8b8b ]]();
            return;
        }
    }
    
    if ( self.var_d6894f01a36b4ff3.var_8485529ab74d2d37 )
    {
        asm::function_7256f5ba459c840b( "explode_in" );
        return;
    }
    
    asm::function_7256f5ba459c840b( self.var_878a729dd9083870 ?? "melee_in" );
}

