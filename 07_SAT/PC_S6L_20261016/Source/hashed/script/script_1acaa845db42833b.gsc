// script_1acaa845db42833b  (hash_1acaa845db42833b.gscc) (size: 1526 Bytes / 0x5f6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x57c7e03f (1472716863)
// size ...... 1526 (0x5f6)
// includes .. 2   (offset: 0x59e)
// strings ... 5   (offset: 0x5ae)
// dev strs .. 0   (offset: 0x5f6)
// exports ... 5   (offset: 0x2f6)
// cseg ...... 0xa4 + 0x252 (0x2f6)
// imports ... 16  (offset: 0x3be)
// animtree1 . 0   (offset: 0x5f6)
// animtree2 . 0   (offset: 0x5f6)
#using scripts\asm\asm;
#using scripts\common\utility;

#namespace zombie_liveragdoll_asm;

// Namespace zombie_liveragdoll_asm
// Params 3
// Checksum 0x120d7504, Offset: 0xc2
// Size: 0xc5
function function_d83419c0d1ae541( asmname, statename, params )
{
    animaliasparam = undefined;
    
    if ( isstring( params ) )
    {
        animaliasparam = params;
    }
    
    self endon( statename + "_finished" );
    self orientmode( "face current" );
    self animmode( "live_ragdoll" );
    
    if ( isdefined( animaliasparam ) )
    {
        animid = asm::asm_getanim( asmname, statename, animaliasparam );
    }
    else
    {
        animid = asm::asm_getanim( asmname, statename );
    }
    
    self aisetanim( statename, animid );
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace zombie_liveragdoll_asm
// Params 4
// Checksum 0x37152eae, Offset: 0x18f
// Size: 0xb1
function function_3c18ca2cedef736c( asmname, statename, blendtime, params )
{
    self endon( statename + "_finished" );
    animid = asm::asm_getanim( asmname, statename );
    animname = asm::asm_getxanim( statename, animid );
    self aisetanim( statename, animid );
    asm::asm_playfacialanim( asmname, statename, animname );
    self setliveragdollrecoveryanim( animname );
    endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    
    if ( endnote == "code_move" )
    {
        endnote = asm::asm_donotetracks( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    }
}

// Namespace zombie_liveragdoll_asm
// Params 3
// Checksum 0xe05fcd31, Offset: 0x248
// Size: 0x40
function function_7047abb22e6d0c08( asmname, statename, params )
{
    utility::ent_flag_set( "in_liveragdoll" );
    self._blackboard.var_1739d55cfbcc7550 = 1;
}

// Namespace zombie_liveragdoll_asm
// Params 3
// Checksum 0x37e7648b, Offset: 0x290
// Size: 0x66
function function_eab2e7d62c57e317( asmname, statename, params )
{
    utility::ent_flag_clear( "in_liveragdoll" );
    self._blackboard.var_1739d55cfbcc7550 = 0;
    
    if ( !isdefined( utility::function_5918594658d3ffba( self.origin, 36, 36 ) ) )
    {
        self kill();
        return;
    }
    
    self stopliveragdoll();
}

