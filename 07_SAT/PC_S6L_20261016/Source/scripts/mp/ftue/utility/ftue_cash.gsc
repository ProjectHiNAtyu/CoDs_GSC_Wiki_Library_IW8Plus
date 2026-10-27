// scripts\mp\ftue\utility\ftue_cash.gsc  (hash_61565a6c1fdee6ac.gscc) (size: 961 Bytes / 0x3c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x35dd48c0 (903694528)
// size ...... 961 (0x3c1)
// includes .. 0   (offset: 0x391)
// strings ... 4   (offset: 0x391)
// dev strs .. 0   (offset: 0x3c1)
// exports ... 7   (offset: 0x205)
// cseg ...... 0xa3 + 0x162 (0x205)
// imports ... 4   (offset: 0x31d)
// animtree1 . 0   (offset: 0x3c1)
// animtree2 . 0   (offset: 0x3c1)
#namespace ftue_cash;

// Namespace ftue_cash
// Params 0
// Checksum 0xd5262d16, Offset: 0xc1
// Size: 0xb
function function_c3cf26ea2570b7a4()
{
    return self.plundercount;
}

// Namespace ftue_cash
// Params 0
// Checksum 0x2450589c, Offset: 0xd5
// Size: 0x10
function function_67b4deb4d61d4d90()
{
    return getdvarint( @"scr_br_plunder_start_amount", 0 );
}

// Namespace ftue_cash
// Params 2
// Checksum 0x9ca1636e, Offset: 0xee
// Size: 0x60
function function_e0f6f50293235438( callback, cashitem )
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( cashitem ) )
    {
        level waittill( "pickedupweapon_kill_callout_" + cashitem.type + cashitem.origin );
    }
    else
    {
        self waittill( "self_pickedupitem_" + "plunder" );
    }
    
    self [[ callback ]]();
}

// Namespace ftue_cash
// Params 1
// Checksum 0x2277f09a, Offset: 0x156
// Size: 0x45, Type: bool
function function_8fb1f467dcab16c9( cashitem )
{
    if ( !isdefined( cashitem ) )
    {
        return false;
    }
    
    itemtype = cashitem.type;
    itemstate = cashitem getscriptablepartstate( itemtype );
    return itemstate != "hidden";
}

// Namespace ftue_cash
// Params 1
// Checksum 0xf7b0e516, Offset: 0x1a4
// Size: 0x3c
function function_11d35b17ca7c28ef( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.amount ) );
    return function_70958f50260d2af8( params.amount );
}

// Namespace ftue_cash
// Params 1
// Checksum 0x751d0f2f, Offset: 0x1e9
// Size: 0x1b, Type: bool
function function_70958f50260d2af8( amount )
{
    return self.plundercount * 10 >= amount;
}

