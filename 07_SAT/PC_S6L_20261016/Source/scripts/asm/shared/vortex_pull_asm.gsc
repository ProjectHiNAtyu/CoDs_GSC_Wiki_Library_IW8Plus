// scripts\asm\shared\vortex_pull_asm.gsc  (hash_1653202b5da4c852.gscc) (size: 776 Bytes / 0x308 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7e3073c3 (2117104579)
// size ...... 776 (0x308)
// includes .. 1   (offset: 0x2c4)
// strings ... 5   (offset: 0x2cc)
// dev strs .. 0   (offset: 0x308)
// exports ... 3   (offset: 0x1bc)
// cseg ...... 0xa0 + 0x11c (0x1bc)
// imports ... 5   (offset: 0x234)
// animtree1 . 0   (offset: 0x308)
// animtree2 . 0   (offset: 0x308)
#using scripts\asm\asm;

#namespace vortex_pull_asm;

// Namespace vortex_pull_asm
// Params 3
// Checksum 0x5b0f63cb, Offset: 0xbe
// Size: 0x60
function function_ce5ce421e9851b5b( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"end_vortex_pull" );
    
    while ( true )
    {
        self waittill( #"hash_e691753f5e81b8e8" );
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

// Namespace vortex_pull_asm
// Params 3
// Checksum 0x80d95068, Offset: 0x126
// Size: 0x96
function function_6c7cf4d91a3b23af( asmname, statename, params )
{
    self endon( #"death" );
    self endon( #"end_vortex_pull" );
    
    while ( true )
    {
        if ( self.var_507d3f5433b78f74 )
        {
            self animmode( "noclip" );
            
            if ( isdefined( self.vortex_pull_angles ) )
            {
                self orientmode( "face angle 3d", self.vortex_pull_angles );
            }
        }
        else
        {
            self motionwarpcancel();
            self animmode( "normal" );
            self orientmode( "face motion" );
        }
        
        waitframe();
    }
}

