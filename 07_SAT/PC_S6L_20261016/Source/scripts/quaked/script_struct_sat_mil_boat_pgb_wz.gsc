// scripts\quaked\script_struct_sat_mil_boat_pgb_wz.gsc  (hash_0fec0f24c7bd6096.gscc) (size: 2838 Bytes / 0xb16 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5178a3f (3843525183)
// size ...... 2838 (0xb16)
// includes .. 5   (offset: 0xaa6)
// strings ... 6   (offset: 0xace)
// dev strs .. 0   (offset: 0xb16)
// exports ... 11  (offset: 0x592)
// cseg ...... 0xa7 + 0x4eb (0x592)
// imports ... 29  (offset: 0x74a)
// animtree1 . 0   (offset: 0xb16)
// animtree2 . 0   (offset: 0xb16)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\interaction;

#namespace namespace_115539d4c037cec6;

// Namespace namespace_115539d4c037cec6
// Params 0, eflags: 0x5
// Checksum 0x696c7dd8, Offset: 0xc5
// Size: 0x17
function private autoexec main()
{
    vehicle::register_vehicle_init( %"hash_55e26733232504a1", &pgb_init );
}

// Namespace namespace_115539d4c037cec6
// Params 0
// Checksum 0xf2c2fa27, Offset: 0xe4
// Size: 0x61
function pgb_init()
{
    if ( !vehicle::should_init( %"hash_55e26733232504a1" ) )
    {
        return;
    }
    
    callbacks[ #"enterEnd" ] = &enter_pgb_callback;
    vehicle::generic_init( %"hash_55e26733232504a1", callbacks );
    utility::registersharedfunc( %"hash_55e26733232504a1", #"spawn", &pgb_spawn );
}

// Namespace namespace_115539d4c037cec6
// Params 2
// Checksum 0xf1832fec, Offset: 0x14d
// Size: 0x4f
function pgb_spawn( spawndata, faildata )
{
    vehicle = vehicle::default_spawn( %"hash_55e26733232504a1", spawndata, faildata );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    function_2fd54018abbc8c34( vehicle );
    vehicle thread function_efd01b753d4f65b7();
    return vehicle;
}

// Namespace namespace_115539d4c037cec6
// Params 5
// Checksum 0x9c880c9c, Offset: 0x1a5
// Size: 0xa3
function enter_pgb_callback( vehicle, seatid, oldseatid, player, data )
{
    if ( isdefined( oldseatid ) )
    {
        switch ( oldseatid )
        {
            case #"hash_93b2a7bb58e45e50":
                vehicle.enterinteract[ 1 ] setusableenabled( 1 );
                break;
            case #"hash_d3214a911a48d323":
                vehicle.enterinteract[ 0 ] setusableenabled( 1 );
                break;
            default:
                break;
        }
    }
    
    vehicle_omnvar::function_e0aa0be8e3297e0d( vehicle, oldseatid, seatid, player );
}

// Namespace namespace_115539d4c037cec6
// Params 5
// Checksum 0x180ec488, Offset: 0x250
// Size: 0x90
function function_18a0386b090d27d2( vehicle, seatid, newseatid, player, data )
{
    switch ( seatid )
    {
        case #"hash_93b2a7bb58e45e50":
            vehicle.enterinteract[ 1 ] setusableenabled( 1 );
            break;
        case #"hash_d3214a911a48d323":
            vehicle.enterinteract[ 0 ] setusableenabled( 1 );
            break;
        default:
            break;
    }
}

// Namespace namespace_115539d4c037cec6
// Params 1
// Checksum 0x1f633da5, Offset: 0x2e8
// Size: 0xb7
function function_2fd54018abbc8c34( vehicle )
{
    var_8b86b59b345b5309 = vehicle gettagorigin( "tag_gunner1" );
    var_9b9383a71e181360 = vehicle gettagorigin( "tag_gunner2" );
    vehicle.enterinteract = [];
    vehicle.enterinteract[ 0 ] = interaction::register_interact( var_8b86b59b345b5309 + ( 0, 0, 75 ), 65, &function_fc1d3325e8f1e8d0, &"vehicles_hints/enter_pgb" );
    vehicle.enterinteract[ 1 ] = interaction::register_interact( var_9b9383a71e181360 + ( 0, 0, 75 ), 65, &function_c04d45c48d80cebd, &"vehicles_hints/enter_pgb" );
    vehicle function_c4e1073e22dcaf09();
}

// Namespace namespace_115539d4c037cec6
// Params 0
// Checksum 0xa0d73966, Offset: 0x3a7
// Size: 0xb5
function function_c4e1073e22dcaf09()
{
    vehicle = self;
    
    foreach ( pgbseat in vehicle.enterinteract )
    {
        pgbseat sethintonobstruction( "show" );
        pgbseat linkto( vehicle );
        pgbseat enableplayeruseforallplayers();
        pgbseat setusableenabled( 1 );
        pgbseat setusefov( 180 );
        pgbseat setuserange( 65 );
    }
}

// Namespace namespace_115539d4c037cec6
// Params 1
// Checksum 0x603aff9c, Offset: 0x464
// Size: 0x2d
function function_c04d45c48d80cebd( player )
{
    vehicle = self getlinkedparent();
    thread vehicle_occupancy::enter( vehicle, "front_left", player );
}

// Namespace namespace_115539d4c037cec6
// Params 1
// Checksum 0x308f0b7, Offset: 0x499
// Size: 0x2d
function function_fc1d3325e8f1e8d0( player )
{
    vehicle = self getlinkedparent();
    thread vehicle_occupancy::enter( vehicle, "back_right", player );
}

// Namespace namespace_115539d4c037cec6
// Params 0
// Checksum 0x771208dd, Offset: 0x4ce
// Size: 0xc4
function function_efd01b753d4f65b7()
{
    self endon( #"game_ended" );
    self endon( #"death" );
    self.beachtimer = gettime();
    self.var_e7a2f42084492834 = self.maxhealth / 100 * getdvarint( @"hash_963f2d65b4b256a1", 2 );
    
    while ( true )
    {
        if ( self vehicle_isonground() && getdvarint( @"hash_368f06081590f201", 2000 ) > 0 )
        {
            if ( self.beachtimer + getdvarint( @"hash_368f06081590f201", 2000 ) < gettime() )
            {
                self dodamage( self.var_e7a2f42084492834, self.origin, undefined, undefined, "MOD_CRUSH" );
            }
        }
        else
        {
            self.beachtimer = gettime();
        }
        
        waitframe();
    }
}

