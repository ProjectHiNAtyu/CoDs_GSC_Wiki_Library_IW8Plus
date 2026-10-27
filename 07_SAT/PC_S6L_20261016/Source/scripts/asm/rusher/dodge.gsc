// scripts\asm\rusher\dodge.gsc  (hash_3c6892448681347b.gscc) (size: 651 Bytes / 0x28b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4c0d8eba (1275956922)
// size ...... 651 (0x28b)
// includes .. 1   (offset: 0x26b)
// strings ... 2   (offset: 0x273)
// dev strs .. 0   (offset: 0x28b)
// exports ... 2   (offset: 0x14b)
// cseg ...... 0x72 + 0xd9 (0x14b)
// imports ... 7   (offset: 0x19b)
// animtree1 . 0   (offset: 0x28b)
// animtree2 . 0   (offset: 0x28b)
#using scripts\asm\asm;

#namespace dodge;

// Namespace dodge
// Params 3
// Checksum 0x5ad1f8cd, Offset: 0x90
// Size: 0xbb
function function_b1033bd5cf44c91c( asmname, statename, params )
{
    self endon( statename + "_finished" );
    assert( self.var_69466b4d3880bb7b >= 0 );
    animid = asm::asm_getanim( asmname, statename );
    xanim = asm::asm_getxanim( statename, animid );
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, asm::asm_getxanim( statename, animid ) );
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    }
}

