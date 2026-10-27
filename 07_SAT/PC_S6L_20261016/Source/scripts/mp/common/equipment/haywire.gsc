// scripts\mp\common\equipment\haywire.gsc  (hash_5a8c477067090fe4.gscc) (size: 684 Bytes / 0x2ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab11ae49 (2870062665)
// size ...... 684 (0x2ac)
// includes .. 2   (offset: 0x29c)
// strings ... 0   (offset: 0x2ac)
// dev strs .. 0   (offset: 0x2ac)
// exports ... 5   (offset: 0x15c)
// cseg ...... 0x58 + 0x104 (0x15c)
// imports ... 4   (offset: 0x224)
// animtree1 . 0   (offset: 0x2ac)
// animtree2 . 0   (offset: 0x2ac)
#using scripts\common\vehicle;
#using scripts\mp\vehicles\vehicle_hack;

#namespace haywire;

// Namespace haywire
// Params 1
// Checksum 0x591a5520, Offset: 0x76
// Size: 0x17
function function_7f69a1eb3d590f76( applycallback )
{
    self.var_3166aa89082d16f4 = applycallback;
}

// Namespace haywire
// Params 1
// Checksum 0x78004e28, Offset: 0x95
// Size: 0x50
function function_8238cd34bd133b52( entity )
{
    var_7237854e3be197ca = entity.var_3166aa89082d16f4;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( entity && entity vehicle::is_vehicle() && !entity vehicle::is_husk() )
    {
        return &vehicle_hack::haywire_applied;
    }
}

// Namespace haywire
// Params 1
// Checksum 0x421e2154, Offset: 0xed
// Size: 0x17
function function_d7496c23fe4085d4( var_daaf54b453aef55c )
{
    self.var_daaf54b453aef55c = var_daaf54b453aef55c;
}

// Namespace haywire
// Params 1
// Checksum 0x68122f61, Offset: 0x10c
// Size: 0x50
function function_57b88bc7394677d8( entity )
{
    var_7237854e3be197ca = entity.var_daaf54b453aef55c;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( entity && entity vehicle::is_vehicle() && !entity vehicle::is_husk() )
    {
        return &vehicle_hack::haywire_cleared;
    }
}

