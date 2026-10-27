// script_499133a45fe46e24  (hash_499133a45fe46e24.gscc) (size: 2172 Bytes / 0x87c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xed89b75b (3985225563)
// size ...... 2172 (0x87c)
// includes .. 5   (offset: 0x81c)
// strings ... 4   (offset: 0x844)
// dev strs .. 0   (offset: 0x87c)
// exports ... 8   (offset: 0x48c)
// cseg ...... 0xb6 + 0x3d6 (0x48c)
// imports ... 21  (offset: 0x5cc)
// animtree1 . 0   (offset: 0x87c)
// animtree2 . 0   (offset: 0x87c)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace namespace_9a205f631c55686e;

// Namespace namespace_9a205f631c55686e
// Params 0, eflags: 0x5
// Checksum 0x531b45fc, Offset: 0xd4
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_63480513eeb36b55", undefined, undefined, &init );
}

// Namespace namespace_9a205f631c55686e
// Params 0, eflags: 0x4
// Checksum 0xf538a594, Offset: 0xf5
// Size: 0x18
function private init()
{
    level callback::add( #"player_weapon_change", &on_weapon_change );
}

// Namespace namespace_9a205f631c55686e
// Params 1, eflags: 0x4
// Checksum 0x15aec8c5, Offset: 0x115
// Size: 0x5a
function private on_weapon_change( params )
{
    if ( !isdefined( params.weapon ) || isbot( self ) )
    {
        return;
    }
    
    if ( params.weapon.basename == "sat_la_fangexotic_mp" )
    {
        thread function_344258784f38b9b6();
        return;
    }
    
    self notify( #"hash_be774b1daea3363" );
}

// Namespace namespace_9a205f631c55686e
// Params 0, eflags: 0xc
// Checksum 0x872be8f1, Offset: 0x177
// Size: 0xa2
function private function_344258784f38b9b6()
{
    self notify( #"hash_34daa533eb66ee39" );
    self endon( #"hash_34daa533eb66ee39" );
    self endon( #"hash_be774b1daea3363" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"missile_fire", missile, objweapon );
        
        if ( objweapon.basename == "sat_la_fangexotic_mp" )
        {
            if ( missile.angles[ 0 ] >= 45 && missile.angles[ 0 ] <= 90 )
            {
                missile thread watch_missile_explode( self );
            }
        }
    }
}

// Namespace namespace_9a205f631c55686e
// Params 1, eflags: 0xc
// Checksum 0xed910d91, Offset: 0x221
// Size: 0xb5
function private watch_missile_explode( player )
{
    self notify( #"hash_478fc19e9c675cef" );
    self endon( #"hash_478fc19e9c675cef" );
    player endon( #"death" );
    self endon( #"entity_deleted" );
    player endon( #"hash_4e14c7c4e0480753" );
    result = utility::waittill_notify_or_timeout_return( "explode", 0.5 );
    
    if ( self && result == "explode" )
    {
        distance2dsquared = distance2dsquared( self.origin, player.origin );
        
        if ( distance2dsquared <= 40000 )
        {
            player thread player_launch( self.origin, distance2dsquared );
        }
    }
}

// Namespace namespace_9a205f631c55686e
// Params 0, eflags: 0x4
// Checksum 0x7cf55476, Offset: 0x2de
// Size: 0x7e, Type: bool
function private can_launch()
{
    if ( vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    contentoverride = trace::create_contents( 0, 1, 0, 0, 0, 0, 0 );
    ignoreents = [ self ];
    trace = trace::ray_trace( self.origin, self.origin + ( 0, 0, 20 ), ignoreents, contentoverride );
    
    if ( trace[ "fraction" ] < 0.99 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_9a205f631c55686e
// Params 2, eflags: 0x4
// Checksum 0x1dfa651e, Offset: 0x365
// Size: 0x127
function private player_launch( explodeorigin, distance2dsquared )
{
    if ( !can_launch() )
    {
        iprintlnbold( "Player is not in a valid position to launch" );
        return;
    }
    
    self notify( #"hash_4e14c7c4e0480753" );
    neworigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 20 );
    self setorigin( neworigin );
    verticalvelocity = getdvarint( @"hash_72a602c5dd19bdb0", 1000 );
    launchvelocity = ( 0, 0, verticalvelocity );
    
    if ( distance2dsquared >= 2500 )
    {
        var_59e02b2b1bfbc212 = vectornormalize( neworigin - explodeorigin );
        var_59e02b2b1bfbc212 *= 450;
        var_59e02b2b1bfbc212 = ( var_59e02b2b1bfbc212[ 0 ], var_59e02b2b1bfbc212[ 1 ], 0 );
        launchvelocity += var_59e02b2b1bfbc212;
    }
    
    var_c8ace45c42548f78 = self getvelocity() * 2;
    var_6e5c0e4df4acab09 = clamp( var_c8ace45c42548f78[ 0 ], -200, 200 );
    var_6e5c0d4df4aca8d6 = clamp( var_c8ace45c42548f78[ 1 ], -200, 200 );
    launchvelocity = ( launchvelocity[ 0 ] + var_6e5c0e4df4acab09, launchvelocity[ 1 ] + var_6e5c0d4df4aca8d6, launchvelocity[ 2 ] );
    self setvelocity( launchvelocity );
}

