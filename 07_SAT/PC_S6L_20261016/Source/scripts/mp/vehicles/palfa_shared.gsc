// scripts\mp\vehicles\palfa_shared.gsc  (hash_4e547d9fe57999c6.gscc) (size: 2035 Bytes / 0x7f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x304c3cf9 (810302713)
// size ...... 2035 (0x7f3)
// includes .. 4   (offset: 0x7a3)
// strings ... 4   (offset: 0x7c3)
// dev strs .. 0   (offset: 0x7f3)
// exports ... 8   (offset: 0x447)
// cseg ...... 0x98 + 0x3af (0x447)
// imports ... 19  (offset: 0x587)
// animtree1 . 0   (offset: 0x7f3)
// animtree2 . 0   (offset: 0x7f3)
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_spawn;

#namespace palfa_shared;

// Namespace palfa_shared
// Params 0, eflags: 0x4
// Checksum 0xa1cc5452, Offset: 0xb6
// Size: 0x11, Type: bool
function private palfa_onground()
{
    return !self vehicle_isphysveh() || self vehicle_isonground();
}

// Namespace palfa_shared
// Params 1
// Checksum 0x76c1acf5, Offset: 0xd0
// Size: 0x136
function palfa_onstartriding( player )
{
    if ( !palfa_onground() )
    {
        player vehicle_occupancy::function_19e78a15b22e4a8c();
    }
    
    if ( isdefined( self.onStartRiding ) )
    {
        self [[ self.onStartRiding ]]( player );
    }
    
    if ( !self.var_ce834c472e64bb2 )
    {
        vehicle_omnvar::function_fc8e70f33a941b3d( self, player );
    }
    
    if ( !isdefined( level.var_4b263c373306ff4a ) )
    {
        level.var_4b263c373306ff4a = getdvarint( @"hash_dee18061c0d4dfe", isbrgamemode() ? 0 : 1 ) == 1;
    }
    
    if ( !level.var_4b263c373306ff4a )
    {
        return;
    }
    
    vehicleteam = vehicle_occupancy::function_88fc32afbd317644( self );
    
    if ( isdefined( vehicleteam ) && isdefined( player.team ) && vehicleteam != "neutral" && vehicleteam != player.team && utility::issharedfuncdefined( #"game", #"onenteroobtrigger" ) )
    {
        player.palfaoob = 1;
        self [[ utility::getsharedfunc( #"game", #"onenteroobtrigger" ) ]]( self, player );
    }
    else
    {
        player.palfaoob = undefined;
    }
    
    vehicle_spawn::stop_watching_abandoned();
}

// Namespace palfa_shared
// Params 1
// Checksum 0x1c4b258e, Offset: 0x20e
// Size: 0xc2
function palfa_onendriding( player )
{
    if ( isdefined( player ) )
    {
        player vehicle_occupancy::function_998629932390cbc4();
        
        if ( !isdefined( player.vehicle ) )
        {
            vehicle_omnvar::function_a9e60d4916911fc6( self, player );
        }
        
        if ( isdefined( self.onEndRiding ) )
        {
            self [[ self.onEndRiding ]]( player );
        }
        
        if ( player.palfaoob && isdefined( player.oob ) && player.oob > 0 && utility::issharedfuncdefined( #"game", #"hash_70d9123f78c53ce0" ) )
        {
            self [[ utility::getsharedfunc( #"game", #"hash_70d9123f78c53ce0" ) ]]( self, player );
        }
    }
    
    thread vehicle_spawn::watch_abandoned();
}

// Namespace palfa_shared
// Params 1
// Checksum 0x562eb1ea, Offset: 0x2d8
// Size: 0x2f
function function_2849f767e6e3ccf0( player )
{
    player setclienttriggeraudiozonepartial( "iw9_palfa_interior", "reverb", "weapon_reflection" );
    player notify( #"entered_vehicle_interior" );
}

// Namespace palfa_shared
// Params 1
// Checksum 0xc20082df, Offset: 0x30f
// Size: 0x2b
function function_3a9e6e9a1f6f10ce( player )
{
    if ( isdefined( player ) )
    {
        player clearclienttriggeraudiozone( 0.5 );
        player notify( #"exited_vehicle_interior" );
    }
}

// Namespace palfa_shared
// Params 1
// Checksum 0x54488ae5, Offset: 0x342
// Size: 0x4c
function function_60cb083f9ca6b804( player )
{
    if ( !isalive( self ) || !( isdefined( self.origin ) && isdefined( player ) && isdefined( player.origin ) ) )
    {
        return 0;
    }
    
    return function_2f4a28086a3dcef2( player.origin );
}

// Namespace palfa_shared
// Params 1
// Checksum 0x185eb0ed, Offset: 0x397
// Size: 0xaf, Type: bool
function function_2f4a28086a3dcef2( origin )
{
    transform = coordtransformtranspose( origin, self.origin, self.angles );
    forwarddist = transform[ 0 ];
    sidedist = transform[ 1 ];
    verticaldist = transform[ 2 ];
    withinforward = forwarddist > -225 && forwarddist < 225;
    withinside = sidedist > -60 && sidedist < 60;
    withinvertical = verticaldist > -235 && verticaldist < -115;
    return withinforward && withinside && withinvertical;
}

