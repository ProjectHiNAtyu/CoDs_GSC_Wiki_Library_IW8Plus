// script_13cab9bb838249e4  (hash_13cab9bb838249e4.gscc) (size: 422 Bytes / 0x1a6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3c4cb4b (3016018763)
// size ...... 422 (0x1a6)
// includes .. 1   (offset: 0x19e)
// strings ... 0   (offset: 0x1a6)
// dev strs .. 0   (offset: 0x1a6)
// exports ... 2   (offset: 0xfa)
// cseg ...... 0x58 + 0xa2 (0xfa)
// imports ... 3   (offset: 0x14a)
// animtree1 . 0   (offset: 0x1a6)
// animtree2 . 0   (offset: 0x1a6)
#using scripts\asm\asm;

#namespace namespace_e37d5618fa22d025;

// Namespace namespace_e37d5618fa22d025
// Params 3
// Checksum 0x4e036512, Offset: 0x76
// Size: 0x84
function playdeathanim_melee_ragdolldelayed( asmname, statename, params )
{
    var_39474a4f2b767d61 = isagent( self );
    
    if ( !var_39474a4f2b767d61 )
    {
        if ( isdefined( self.meleestatename ) )
        {
            time = params;
            
            if ( !isdefined( time ) )
            {
                time = 10;
            }
            
            asm::asm_donotetrackswithtimeout( asmname, self.meleestatename, time );
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !var_39474a4f2b767d61 )
    {
        self startragdoll();
        wait 0.1;
    }
}

