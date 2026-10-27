// scripts\mp\loot\common_item_vehicle_spawner.gsc  (hash_56feaae2618bbfe2.gscc) (size: 3634 Bytes / 0xe32 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96ab439e (2527806366)
// size ...... 3634 (0xe32)
// includes .. 10  (offset: 0xd3e)
// strings ... 10  (offset: 0xd8e)
// dev strs .. 2   (offset: 0xe1a)
// exports ... 9   (offset: 0x756)
// cseg ...... 0x12d + 0x629 (0x756)
// imports ... 40  (offset: 0x8be)
// animtree1 . 0   (offset: 0xe32)
// animtree2 . 0   (offset: 0xe32)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_airdrop;
#using scripts\common\vehicle_spawn;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_kiosk;

#namespace item_vehicle_spawner;

// Namespace item_vehicle_spawner
// Params 0, eflags: 0x5
// Checksum 0x41b6c8dd, Offset: 0x14b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_vehicle_spawner", #"common_item", &init_item_vehicle_spawner, undefined );
}

// Namespace item_vehicle_spawner
// Params 0
// Checksum 0x887aa2d5, Offset: 0x174
// Size: 0x95
function init_item_vehicle_spawner()
{
    if ( !common_item::items_isenabled() )
    {
        return;
    }
    
    common_item::function_4b30c091d3b04a25( "vehicle_spawner" );
    common_item::function_84174b793b5fe9a7( "vehicle_spawner", #"use", &utility::empty_init_func );
    common_item::function_84174b793b5fe9a7( "vehicle_spawner", #"hash_9e49dfaa7c147654", &utility::always_false );
    common_item::function_84174b793b5fe9a7( "vehicle_spawner", #"hash_d2edc28305c6e147", &function_9ca4807c555521ff );
    callback::add( #"hash_440e335c78393d75", &function_26f67459cca2c108 );
    level.var_31b239cd10f752c4 = utility::getstructarray( "kiosk_spawn_vehicle", "script_noteworthy" );
}

// Namespace item_vehicle_spawner
// Params 3
// Checksum 0xdb049470, Offset: 0x211
// Size: 0x58, Type: bool
function function_9ca4807c555521ff( itembundle, count, spawnoptions )
{
    purchasesuccess = _handlevehiclepurchase( itembundle );
    
    if ( purchasesuccess )
    {
        thread namespace_9d8e359c3b1041e5::showsplashsharedfunc( "vehicle_purchased" );
    }
    else
    {
        namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"MP/VEHICLE_PURCHASE_FAILED" );
    }
    
    return true;
}

// Namespace item_vehicle_spawner
// Params 1
// Checksum 0x60409413, Offset: 0x272
// Size: 0xc6, Type: bool
function function_26f67459cca2c108( params )
{
    if ( params.itemdata.type != "vehicle" )
    {
        return true;
    }
    
    assetname = getxhashasset( "itemspawnentry:" + params.itemdata.ref );
    itemref = getscriptbundlefieldvalue( assetname, #"ref" );
    
    if ( !function_5418f260b5720258( itemref, params.player, params.kiosk ) )
    {
        params.player namespace_9d8e359c3b1041e5::showerrormessagesharedfunc( %"MP/VEHICLE_PURCHASE_FAILED" );
        params.player common_kiosk::_closepurchasemenuwithresponse( 2 );
        return false;
    }
    
    return true;
}

// Namespace item_vehicle_spawner
// Params 3, eflags: 0x4
// Checksum 0xd3b966d0, Offset: 0x341
// Size: 0x19f
function private function_5418f260b5720258( itemref, player, kiosk )
{
    if ( !vehicle::has_data( itemref ) && !isxhashasset( itemref ) )
    {
        itemref = getxhashasset( itemref );
    }
    
    if ( !vehicle_spawn::can_spawn_vehicle( itemref, undefined, undefined, "KIOSK" ) )
    {
        return 0;
    }
    
    if ( player vehicle::is_in_vehicle( 1 ) )
    {
        return 0;
    }
    
    if ( kiosk.spawningvehicle )
    {
        return 0;
    }
    
    spawndata = spawnstruct();
    
    if ( !isdefined( kiosk.vehiclespawn ) )
    {
        vehiclespawnstruct = function_47c86977a18df38b( level.var_31b239cd10f752c4, player.origin, 1000 );
        kiosk.vehiclespawn = vehiclespawnstruct;
    }
    
    if ( isdefined( kiosk.vehiclespawn ) )
    {
        spawndata.origin = kiosk.vehiclespawn.origin;
        spawndata.angles = kiosk.vehiclespawn.angles;
    }
    else
    {
        assertmsg( "<dev string:x24>" );
        spawndata.origin = kiosk.origin + anglestoforward( kiosk.angles ) * 500 + ( 0, 0, 60 );
        spawndata.angles = ( 0, kiosk.angles[ 1 ] + 90, 0 );
        kiosk.vehiclespawn = spawndata;
    }
    
    return vehicle_spawn::function_c49e68f891a06e6f( spawndata.origin, itemref );
}

// Namespace item_vehicle_spawner
// Params 1
// Checksum 0x154ab1fd, Offset: 0x4e9
// Size: 0xa6, Type: bool
function _handlevehiclepurchase( itemdata )
{
    assert( isdefined( self.common_kiosk ), "<dev string:x84>" );
    
    if ( !vehicle::has_data( itemdata.ref ) && !isxhashasset( itemdata.ref ) )
    {
        itemdata.ref = getxhashasset( itemdata.ref );
    }
    
    if ( !function_5418f260b5720258( itemdata.ref, self, self.common_kiosk ) )
    {
        return false;
    }
    
    thread function_29e5da897c7fb1fa( itemdata, self.common_kiosk.vehiclespawn );
    return true;
}

// Namespace item_vehicle_spawner
// Params 2
// Checksum 0x623e1bff, Offset: 0x598
// Size: 0x155
function function_29e5da897c7fb1fa( itemdata, spawndata )
{
    level endon( #"game_ended" );
    kiosk = self.common_kiosk;
    kiosk.spawningvehicle = 1;
    spawndata.spawntype = "KIOSK";
    
    if ( vehicle_airdrop::can_airdrop( itemdata.ref ) )
    {
        vehicle = vehicle_airdrop::vehicle_airdrop( itemdata.ref, spawndata );
    }
    else
    {
        vehicle = vehicle::spawn( itemdata.ref, spawndata );
    }
    
    team = self.team;
    callback::callback( #"hash_3aad9cf39ea1d0b5", { #team:team, #vehicle:vehicle } );
    kiosk function_d035ea919d1c8f91( vehicle );
    callback::callback( #"hash_d887e9a56615924c", { #team:team, #vehicle:vehicle } );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle vehicle_spawn::prevent_respawn();
    
    if ( isdefined( self ) )
    {
        newpingindex = calloutmarkerping::function_81aa43aad6e47820( vehicle getentitynumber() );
        vehicle thread calloutmarkerping::function_3c501da3379eca0a( self, newpingindex, [ "death" ], [ "vehicle_owner_update" ] );
    }
}

// Namespace item_vehicle_spawner
// Params 1
// Checksum 0xaa800e2d, Offset: 0x6f5
// Size: 0x61
function function_d035ea919d1c8f91( vehicle )
{
    self notify( #"hash_5cf29b6d9e2b38df" );
    self endon( #"hash_5cf29b6d9e2b38df" );
    level endon( #"game_ended" );
    
    if ( !isdefined( vehicle ) )
    {
        self.spawningvehicle = 0;
        return;
    }
    
    vehicle utility::waittill_any_timeout( 30, "death", "landed" );
    self.spawningvehicle = 0;
}

