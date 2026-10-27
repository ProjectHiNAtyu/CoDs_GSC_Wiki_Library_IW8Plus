// scripts\asm\soldier\interactable.gsc  (hash_7c21424b9baf1d83.gscc) (size: 1872 Bytes / 0x750 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb068b9d (4211510173)
// size ...... 1872 (0x750)
// includes .. 2   (offset: 0x6f4)
// strings ... 4   (offset: 0x704)
// dev strs .. 2   (offset: 0x738)
// exports ... 10  (offset: 0x3d8)
// cseg ...... 0xad + 0x32b (0x3d8)
// imports ... 13  (offset: 0x568)
// animtree1 . 0   (offset: 0x750)
// animtree2 . 0   (offset: 0x750)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;

#namespace interactable;

// Namespace interactable
// Params 0
// Checksum 0x150723ad, Offset: 0xcb
// Size: 0x13
function onlevelload()
{
    registerinteractable( "example", &run_example_interactable );
}

// Namespace interactable
// Params 3
// Checksum 0x6a1c6bbb, Offset: 0xe6
// Size: 0x66
function run_example_interactable( asmname, statename, animationdata )
{
    iprintlnbold( "Example Interactable is Running." );
    covernode = asm_bb::bb_getcovernode();
    assert( covernode );
    self setflaggedanimknobrestart( statename, animationdata, 1, 0.2, 1 );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace interactable
// Params 2
// Checksum 0xece15cad, Offset: 0x154
// Size: 0x39
function registerinteractable( interactable, func )
{
    if ( !isdefined( level.interactables ) )
    {
        level.interactables = [];
    }
    
    level.interactables[ interactable ] = func;
}

// Namespace interactable
// Params 0
// Checksum 0x894dbd5, Offset: 0x195
// Size: 0x27
function disableinteractable()
{
    assert( isnode( self ) );
    
    if ( isdefined( self.interaction ) )
    {
        self.disableinteraction = 1;
    }
}

// Namespace interactable
// Params 4
// Checksum 0xeeb705d9, Offset: 0x1c4
// Size: 0x63, Type: bool
function shouldplayinteractable( asmname, statename, tostatename, params )
{
    covernode = asm_bb::bb_getcovernode();
    
    if ( isdefined( covernode ) && isdefined( covernode.interactable ) && !isdefined( covernode.disableinteraction ) )
    {
        return true;
    }
    
    return false;
}

// Namespace interactable
// Params 4
// Checksum 0x4b5f4aa5, Offset: 0x230
// Size: 0x34
function interactablefinished( asmname, statename, tostatename, params )
{
    return asm::asm_eventfired( asmname, "interactable_finished" );
}

// Namespace interactable
// Params 3
// Checksum 0x1739d1e9, Offset: 0x26d
// Size: 0x62
function chooseaniminteractable( asmname, statename, params )
{
    covernode = asm_bb::bb_getcovernode();
    assert( isdefined( covernode ) );
    assert( isdefined( covernode.interactable ) );
    return asm::asm_lookupanimfromalias( statename, covernode.interactable );
}

// Namespace interactable
// Params 3
// Checksum 0xeb177f0, Offset: 0x2d8
// Size: 0xda
function playinteractable( asmname, statename, params )
{
    self endon( statename + "_finished" );
    animations = asm::asm_getanim( asmname, statename );
    covernode = asm_bb::bb_getcovernode();
    assert( isdefined( covernode ) );
    assert( isdefined( covernode.interactable ) );
    assert( isdefined( level.interactables[ covernode.interactable ] ), "<dev string:x24>" + covernode.interactable + "<dev string:x32>" );
    covernode.disableinteraction = 1;
    [[ level.interactables[ covernode.interactable ] ]]( asmname, statename, animations );
    asm::asm_fireevent( asmname, "interactable_finished" );
}

// Namespace interactable
// Params 3
// Checksum 0x48c15e4a, Offset: 0x3ba
// Size: 0x1e
function interactableterminate( asmname, statename, params )
{
    
}

