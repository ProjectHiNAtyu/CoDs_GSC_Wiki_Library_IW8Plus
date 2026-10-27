// scripts\mp\br\gametypes\br_movingtrain_mtx.gsc  (hash_6acefadae9cbe0ba.gscc) (size: 2530 Bytes / 0x9e2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x84844a1 (138953889)
// size ...... 2530 (0x9e2)
// includes .. 7   (offset: 0x97a)
// strings ... 4   (offset: 0x9b2)
// dev strs .. 0   (offset: 0x9e2)
// exports ... 7   (offset: 0x596)
// cseg ...... 0xcf + 0x4c7 (0x596)
// imports ... 25  (offset: 0x6ae)
// animtree1 . 0   (offset: 0x9e2)
// animtree2 . 0   (offset: 0x9e2)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\flags;

#namespace br_movingtrain_mtx;

// Namespace br_movingtrain_mtx
// Params 0, eflags: 0x1
// Checksum 0x33e00c14, Offset: 0xed
// Size: 0xe6
function autoexec main()
{
    /#
        br_dev::registerhandlecommand( &handledevcommand_br );
    #/
    
    if ( !vehicle::is_loaded( %"hash_2fd7afeba1d72e06" ) )
    {
        utility::flag_wait( "wztrain_array_set" );
    }
    
    if ( getdvarint( @"hash_c15b52558ebc810a", 1 ) )
    {
        foreach ( train in level.wztrain_info.trains )
        {
            locomotive = train[ 0 ];
            
            if ( locomotive.linked_model vehicle::is_vehicle() )
            {
                locomotive thread function_cad67fda182369f9();
            }
        }
    }
}

// Namespace br_movingtrain_mtx
// Params 2
// Checksum 0xf9f243f5, Offset: 0x1db
// Size: 0x9a
function function_aeb82fde0985ce6b( vehicle_ref, spawndata )
{
    var_76bf14485561f4ad = "v000";
    var_59d9ad1d80e4577f = getdvar( @"hash_fbbc1781e1b34506", var_76bf14485561f4ad );
    
    if ( var_59d9ad1d80e4577f != var_76bf14485561f4ad )
    {
        spawndata.var_4ae4f42e05dc7b41 = getdvar( @"hash_fbbc1781e1b34506", var_59d9ad1d80e4577f );
    }
    
    vehicle = vehicle::spawn( vehicle_ref, spawndata );
    vehicle_compass::vehicle_hide( vehicle );
    vehicle vehicleshowonminimap( 0 );
    vehicle vehicle_damage::set_can_damage( 0 );
    vehicle_tracking::deregister_instance( vehicle );
    return vehicle;
}

// Namespace br_movingtrain_mtx
// Params 0, eflags: 0x4
// Checksum 0xb6d067ca, Offset: 0x27e
// Size: 0x69
function private function_cad67fda182369f9()
{
    traincar = self;
    traincar endon( #"hash_40c163cd35408b8b" );
    
    while ( true )
    {
        traincar waittill( #"hash_2d2b2ea86eccd5fd", part, user_player, success );
        
        if ( success )
        {
            function_cae1d9701bcd4a18( user_player, traincar.linked_model );
        }
    }
}

// Namespace br_movingtrain_mtx
// Params 1, eflags: 0x4
// Checksum 0x97045ab1, Offset: 0x2ef
// Size: 0x28, Type: bool
function private function_8b8eeaec5e1f380b( vehicle )
{
    return flags::gameflag( "prematch_fade_done" ) && !isdefined( vehicle.mtx );
}

// Namespace br_movingtrain_mtx
// Params 2, eflags: 0x4
// Checksum 0xe0b09ddf, Offset: 0x320
// Size: 0xa7
function private function_cae1d9701bcd4a18( player, vehicle )
{
    if ( !function_8b8eeaec5e1f380b( vehicle ) )
    {
        return;
    }
    
    if ( isdefined( player.vehiclecustomization ) )
    {
        vehicleref = vehicle vehicle::get_ref();
        
        if ( !isdefined( vehicle.mtx ) && !vehicle.var_1f4f9d64c04f05db )
        {
            mtx = vehicle::function_a634e7859d837381( player, vehicleref );
            vehicle::set_mtx( vehicle, mtx );
            
            if ( isdefined( vehicle.mtx ) )
            {
                vehicle.linked_brush notify( #"hash_40c163cd35408b8b" );
            }
        }
    }
}

// Namespace br_movingtrain_mtx
// Params 2, eflags: 0x4
// Checksum 0xf25285d4, Offset: 0x3cf
// Size: 0x1c7
function private handledevcommand_br( command, args )
{
    cargotrain_vehicle_ref = "cargo_train";
    firstplayer = level.players[ 0 ];
    
    if ( !isdefined( firstplayer ) )
    {
        return;
    }
    
    switch ( command )
    {
        case #"hash_2899e5a679a1e049":
            if ( !isdefined( args[ 0 ] ) )
            {
                break;
            }
            
            switch ( args[ 0 ] )
            {
                case #"hash_2871e46c1eee9774":
                    if ( !isdefined( args[ 1 ] ) )
                    {
                        break;
                    }
                    
                    switch ( args[ 1 ] )
                    {
                        case #"hash_b9c0ff6cd406fe0f":
                            announcement( string( vehicle::is_loaded( %"hash_2fd7afeba1d72e06" ) ) );
                            break;
                        case #"hash_334c896e25dc8345":
                            mtx_data = vehicle::get_mtx_data( %"hash_2fd7afeba1d72e06" );
                            dummy = 0;
                            break;
                        case #"hash_6ad13f0635bc091b":
                            vehicle = level.wztrain_info.trains[ cargotrain_vehicle_ref ][ 0 ].linked_model;
                            function_cae1d9701bcd4a18( firstplayer, vehicle );
                            break;
                        case #"hash_819aac6f5ae2fb78":
                            vehicle_ref = args[ 2 ];
                            
                            if ( !isdefined( vehicle_ref ) )
                            {
                                break;
                            }
                            
                            traincar = level.wztrain_info.trains[ cargotrain_vehicle_ref ][ 0 ];
                            spawndata = spawnstruct();
                            spawndata.origin = traincar.origin + ( 0, 200, 0 );
                            vehicle = vehicle::spawn( vehicle_ref, spawndata );
                            vehicle linkto( traincar );
                            break;
                    }
                    
                    break;
            }
            
            break;
    }
}

