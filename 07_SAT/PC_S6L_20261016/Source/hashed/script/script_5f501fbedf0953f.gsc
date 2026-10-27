// script_5f501fbedf0953f  (hash_05f501fbedf0953f.gscc) (size: 30766 Bytes / 0x782e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x32bc8ced (851217645)
// size ...... 30766 (0x782e)
// includes .. 25  (offset: 0x6fba)
// strings ... 59  (offset: 0x7082)
// dev strs .. 61  (offset: 0x74a2)
// exports ... 62  (offset: 0x4a52)
// cseg ...... 0x4bf + 0x4593 (0x4a52)
// imports ... 222 (offset: 0x5402)
// animtree1 . 0   (offset: 0x782e)
// animtree2 . 0   (offset: 0x782e)
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\spatial_zone_container;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_spawn;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_convoy_util;
#using scripts\mp\supers;

#namespace namespace_f384a0805440e6ab;

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0x1b8bc336, Offset: 0x4dd
// Size: 0x376
function function_8d04b6e332b104af()
{
    activityvariantdefinition = namespace_9085ae059032a84f::function_9129cd8075c85c09( self );
    self.a_vh_convoy = [];
    self.a_ai_convoy = [];
    self.a_loot_caches = [];
    self.nd_spline_start = undefined;
    self.var_c4ba58fd936d79f1 = utility::getstruct( self.varianttag, "targetname" );
    
    if ( !self.var_c4ba58fd936d79f1 )
    {
        throw( "Failed to find a struct with targetname: " + self.varianttag );
        return;
    }
    
    self.nd_spline_start = function_2cde605d1452364a();
    assert( isdefined( self.nd_spline_start ), "<dev string:x24>" );
    function_18aa3d573c074e82( activityvariantdefinition );
    
    if ( !isdefined( self.var_c4ba58fd936d79f1 ) )
    {
        assertmsg( "<dev string:x4e>" + self.varianttag + "<dev string:x88>" );
        return;
    }
    
    self.str_stealth_group = "sg_" + self.varianttag;
    
    if ( !isdefined( function_ff2498f19618e5fa( self.str_stealth_group ) ) )
    {
        stealthinitgroup( self.str_stealth_group );
    }
    
    /#
        iprintln( "<dev string:x96>" + self.varianttag );
    #/
    
    var_a3ac6fb908f611b0 = undefined;
    self.var_d5ed03421f78dd64 = 0;
    self.var_f904fd9fe7b07a23 = 0;
    self.a_vh_ground = [];
    self.n_veh_speed = self.defaultspeed;
    spatial_zone_container::function_11cd1f1428a0af78( 0, &function_bea00b6807a5c751 );
    self.a_vh_ground = function_fe7ac887330b2634( var_a3ac6fb908f611b0 );
    self.a_vh_convoy = arraycombine( self.a_vh_convoy, self.a_vh_ground );
    self.var_d5ed03421f78dd64 = self.a_vh_convoy.size;
    self.spawned_vehicles = self.a_vh_convoy;
    self.a_vh_ground = utility::array_sort_by_script_index( self.a_vh_ground );
    
    foreach ( convoy_vehicle in self.a_vh_ground )
    {
        convoy_vehicle thread function_d3546d9428bf0e4c( self );
        convoy_vehicle thread ob_convoy_util::function_2159092914a60ce0();
    }
    
    thread function_55ef927f56f1bebe();
    ob_convoy_util::init_vehicle_callback();
    self.var_e814baa69305ee8a = ob_convoy_util::function_8ccf719b775fd5a0( self.a_vh_ground );
    
    foreach ( veh in self.a_vh_convoy )
    {
        foreach ( rider in veh.riders )
        {
            rider.lastvehicle = veh;
        }
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x5de58f7e, Offset: 0x85b
// Size: 0x28f
function function_18aa3d573c074e82( convoyparams )
{
    if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_a9b37ef5c1f86827" ) )
    {
        utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_a9b37ef5c1f86827", convoyparams );
    }
    
    self.ai_team = convoyparams.aiteam ?? "team_hundred_ninety";
    self.slowspeed = convoyparams.slowspeed ?? 12;
    self.highspeed = convoyparams.highspeed ?? 25;
    self.var_e90fa0d985dd486d = convoyparams.var_e90fa0d985dd486d ?? "ob_sat_items_activity_armoredconvoy_green";
    self.var_45008a5d7d3b0506 = convoyparams.var_45008a5d7d3b0506 ?? "ob_sat_items_activity_armoredconvoy_yellow";
    self.var_ef091d37dff54373 = convoyparams.var_ef091d37dff54373 ?? "sat_ob_loot_cache";
    self.var_8c0b9efa3145cbb4 = istrue( convoyparams.var_8c0b9efa3145cbb4 );
    self.disablecaralarm = convoyparams.disablecaralarm;
    self.var_85991905917e913d = 0;
    self.var_6659ca8173670617 = convoyparams.var_6659ca8173670617 ?? "EXIT_VEHICLE";
    self.defaultspeed = self.slowspeed;
    self.var_7d7a32be78c7fc98 = [];
    
    for ( i = 0; i < convoyparams.convoyvehicles.size ; i++ )
    {
        self.var_7d7a32be78c7fc98[ i ] = spawnstruct();
        self.var_7d7a32be78c7fc98[ i ].riderencounter = "ai_encounter:" + convoyparams.convoyvehicles[ i ].variant_object.riderencounter;
        self.var_7d7a32be78c7fc98[ i ].vehicleref = convoyparams.convoyvehicles[ i ].variant_object.vehicle;
    }
    
    targetindex = int( convoyparams.convoyvehicles.size / 2 );
    var_7c9e908ff3a29665 = spawnstruct();
    var_7c9e908ff3a29665.riderencounter = "ai_encounter:" + convoyparams.var_83e013bcaf310285.riderencounter;
    var_7c9e908ff3a29665.vehicleref = convoyparams.var_83e013bcaf310285.vehicle;
    var_7c9e908ff3a29665.istarget = 1;
    arrayinsert( self.var_7d7a32be78c7fc98, var_7c9e908ff3a29665, targetindex );
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0x9770b3ef, Offset: 0xaf2
// Size: 0x5c
function armored_convoy_activity_begin()
{
    thread function_590fcbda347d8e04();
    thread function_9f5fb0faf43d34d9();
    thread function_ecbc6d95a98440c5();
    thread function_d79ac4eb8455ae56();
    thread function_4df5530d6d47e64b();
    thread function_5e4990b026365792();
    self.var_83e013bcaf310285 thread function_238b24b3bfaa0d87();
    self.var_83e013bcaf310285 thread function_5d41add3b5ee8b9d();
    ob_convoy_util::function_9846981f8d3b8539( self.var_83e013bcaf310285 );
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0x37417237, Offset: 0xb56
// Size: 0xa6
function function_aa78d0adc78609ef()
{
    ob_convoy_util::function_27eb33c611286cd9( self.var_e814baa69305ee8a );
    
    if ( isdefined( self.a_vh_convoy ) )
    {
        foreach ( vehicle in self.a_vh_convoy )
        {
            vehicle notify( #"hash_39988b7639fb364e" );
            vehicle thread function_4832643e350f6a9( self );
        }
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0x7c1d47d2, Offset: 0xc04
// Size: 0x1b3
function function_65cf1a7814dc05cc()
{
    ai_encounter_requests = self.var_9c4a0b2cae577c1b ?? [];
    
    foreach ( request_id, request_data in ai_encounter_requests )
    {
        function_64ac8c4e752f4dca( request_id, 1 );
    }
    
    if ( isdefined( self.a_loot_caches ) )
    {
        foreach ( var_a0ae16ad53ad49e5 in self.a_loot_caches )
        {
            var_a0ae16ad53ad49e5 thread ob_activity_utility::function_16f13e7feb0abb24( 3000, 30 );
        }
    }
    
    thread activity_ai_encounters::function_cb88eba0bb17a5e4();
    
    if ( isdefined( self.spawned_vehicles ) )
    {
        foreach ( vehicle in self.spawned_vehicles )
        {
            if ( !vehicle.istarget )
            {
                vehicle thread ob_activity_utility::function_16f13e7feb0abb24( 3000, 30 );
            }
        }
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1, eflags: 0x4
// Checksum 0xcd8397c2, Offset: 0xdbf
// Size: 0xaa
function private function_f7dc0060fe39189e( var_2ce6b8a691499a8 )
{
    newarray = [];
    
    foreach ( var_bb002b9a21dfc5dc in var_2ce6b8a691499a8 )
    {
        if ( !isalive( var_bb002b9a21dfc5dc ) || !isalive( var_bb002b9a21dfc5dc.driver ) )
        {
            continue;
        }
        
        newarray[ newarray.size ] = var_bb002b9a21dfc5dc;
    }
    
    return newarray;
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0xda61fce, Offset: 0xe72
// Size: 0x6a
function private function_4df5530d6d47e64b()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( self.a_vh_ground.size > 1 )
    {
        self.a_vh_convoy = function_f7dc0060fe39189e( self.a_vh_convoy );
        self.a_vh_ground = function_f7dc0060fe39189e( self.a_vh_ground );
        waitframe();
    }
    
    self notify( #"all_vehicles_destroyed" );
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0x81a21378, Offset: 0xee4
// Size: 0x91
function private function_ecbc6d95a98440c5()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( self.var_6659ca8173670617 == "EXIT_VEHICLE" )
    {
        utility::waittill_any( "under_attack", "ai_combat" );
        function_38609742a95bdd48();
        return;
    }
    
    if ( issubstr( self.var_6659ca8173670617, "KEEP_DRIVING" ) )
    {
        msg = utility::waittill_any_in_array_return( [ "under_attack", "ai_combat" ] );
        function_247a8d955d90097b( self.highspeed );
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0xe2553a55, Offset: 0xf7d
// Size: 0xc9
function function_d79ac4eb8455ae56()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"ai_combat" );
    
    while ( true )
    {
        foreach ( ai in self.a_ai_convoy )
        {
            if ( isalive( ai ) && ai isincombat() )
            {
                self.var_ea5b7a595a1f4f3 = 1;
                self notify( #"ai_combat" );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0xd464e694, Offset: 0x104e
// Size: 0x4e
function function_a02484466dfd0cdb()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    centerpoint = undefined;
    
    if ( isalive( self.var_83e013bcaf310285 ) )
    {
        centerpoint = self.var_83e013bcaf310285.origin;
    }
    
    return centerpoint;
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0x63b8bc38, Offset: 0x10a5
// Size: 0x1af
function function_590fcbda347d8e04()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ai_array = self.a_ai_convoy;
    
    while ( true )
    {
        ai_array = utility::array_removedead_or_dying( ai_array );
        
        if ( ai_array.size <= 3 )
        {
            break;
        }
        
        wait 1;
    }
    
    foreach ( veh in self.a_vh_convoy )
    {
        params = spawnstruct();
        params.activity_instance = self;
        params.players = self.playerparticipants;
        veh callback::callback( "veh_on_convoy_ended", params );
    }
    
    var_a667c5742cfca282 = function_46f9072493651dc9( self.a_vh_convoy );
    
    if ( var_a667c5742cfca282.size > 0 )
    {
        if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_1c9144f0a3015dba" ) )
        {
            utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_1c9144f0a3015dba", self, 1 );
        }
    }
    else if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_1c9144f0a3015dba" ) )
    {
        utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_1c9144f0a3015dba", self );
    }
    
    waitframe();
    ob_activity_utility::function_894ac80e038636c5( "wcaconvoysuccess", undefined, undefined, undefined, undefined, &function_ed9347a0bc4b0d2b );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0xc84702b0, Offset: 0x125c
// Size: 0x79
function function_5e4990b026365792()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_83e013bcaf310285 endon( #"death" );
    self.var_83e013bcaf310285 waittill( #"hash_90c0d471c901c942", var_600ad0b82118b15f );
    activity_participation::function_bc67362dace4370c( self, var_600ad0b82118b15f );
    waitframe();
    ob_activity_utility::function_894ac80e038636c5( "wcaconvoysuccess", undefined, undefined, undefined, undefined, &function_ed9347a0bc4b0d2b );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0x9f3eaf1e, Offset: 0x12dd
// Size: 0x55
function private function_238b24b3bfaa0d87()
{
    self endon( #"death" );
    wait 0.1;
    
    for ( var_600ad0b82118b15f = vehicle_occupancy::get_driver( self, 1 ); !isplayer( var_600ad0b82118b15f ) ; var_600ad0b82118b15f = vehicle_occupancy::get_driver( self, 1 ) )
    {
        wait 0.1;
    }
    
    self notify( #"hash_90c0d471c901c942", var_600ad0b82118b15f );
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0x66a3306a, Offset: 0x133a
// Size: 0xd7
function private function_5d41add3b5ee8b9d()
{
    self endon( #"death" );
    vehicle_gunner = undefined;
    
    while ( !vehicle_gunner )
    {
        waitframe();
        
        foreach ( rider in self.riders )
        {
            if ( rider.using_vehicle_turret )
            {
                vehicle_gunner = rider;
                break;
            }
        }
    }
    
    vehicle_gunner endon( #"death" );
    self waittill( #"hash_90c0d471c901c942" );
    
    if ( vehicle_gunner.using_vehicle_turret )
    {
        vehicle_gunner kill();
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x6a5a32cd, Offset: 0x1419
// Size: 0x2e
function function_ed9347a0bc4b0d2b( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcaconvoysuccess_kagan" || var_73f4f05f29c6770a == "wcaconvoysuccess_razor" )
    {
        return [ "wcaconvoyclapback" ];
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0x7e87c9dd, Offset: 0x1450
// Size: 0x1fe
function private function_9f5fb0faf43d34d9()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"under_attack" );
    self endon( #"hash_e8f0709128e49dd2" );
    self endon( #"hash_515b5bdfddc2a3f3" );
    
    while ( !self.convoy_engaged )
    {
        array = self.a_vh_convoy;
        
        foreach ( member in array )
        {
            if ( isdefined( member ) )
            {
                players = player_utility::script_getplayersinradius( member.origin, 1500 );
                
                if ( players.size > 0 )
                {
                    foreach ( player in players )
                    {
                        if ( !player.notarget )
                        {
                            var_8eba82ead0f19157 = trace::ray_trace_passed( player geteye(), member.origin + ( 0, 0, 30 ), [ player, member ] );
                            
                            if ( var_8eba82ead0f19157 == 1 )
                            {
                                if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_7c46e0eba7b87d1f" ) )
                                {
                                    utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_7c46e0eba7b87d1f", self, 1, player );
                                }
                                
                                self notify( #"hash_e8f0709128e49dd2" );
                                break;
                            }
                        }
                    }
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0xce801787, Offset: 0x1656
// Size: 0x251
function private function_7042ad6e488f911e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"reached_path_end" );
    wait 5;
    
    while ( self.a_vh_convoy.size > 0 )
    {
        if ( self.var_e814baa69305ee8a.traffic_paused )
        {
            wait 0.1;
            continue;
        }
        
        foreach ( vehicle in self.a_vh_convoy )
        {
            if ( isdefined( vehicle ) )
            {
                if ( !isdefined( vehicle.lastposition ) )
                {
                    vehicle.lastposition = vehicle.origin;
                    vehicle.stucktime = 0;
                    continue;
                }
                
                var_4a9cacebf4290aee = vehicle.lastposition - vehicle.origin;
                difference = length2d( var_4a9cacebf4290aee );
                
                if ( difference < 15 )
                {
                    vehicle.stucktime += 0.1;
                    
                    /#
                        sphere( vehicle.origin, 50, ( 1, 0, 0 ), 0, 100 );
                    #/
                }
                else
                {
                    vehicle.stucktime = 0;
                }
                
                /#
                    drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                    
                    if ( drawdebug && vehicle.stucktime > 0 )
                    {
                        print3d( vehicle getcentroid() + ( 0, 0, 100 ), string( vehicle.stucktime ), ( 1, 1, 0 ), 1, 1, 1, 0 );
                    }
                #/
                
                if ( vehicle.stucktime > 2 )
                {
                    vehicle thread function_73e24f6541b45003( self );
                    self.a_vh_convoy = arrayremove( self.a_vh_convoy, vehicle );
                }
                
                vehicle.lastposition = vehicle.origin;
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0xf825e7a9, Offset: 0x18af
// Size: 0xca
function private function_38609742a95bdd48()
{
    var_22f2ba557caf1adf = self.a_vh_convoy;
    self.convoy_engaged = 1;
    
    foreach ( vehicle in var_22f2ba557caf1adf )
    {
        if ( !vehicle.var_a5f34fcc4fb8b328 )
        {
            vehicle notify( #"engage" );
            vehicle thread function_73e24f6541b45003( self );
        }
        
        n_wait = randomfloatrange( 0.5, 1.1 );
        wait n_wait;
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1, eflags: 0x4
// Checksum 0x3f5921e7, Offset: 0x1981
// Size: 0x174
function private function_4832643e350f6a9( activityinstance )
{
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( 0 ) );
    self vehicle_setspeedimmediate( 0, 1, 1 );
    self vehicle_cleardrivingstate();
    
    if ( self hascomponent( "p2p" ) )
    {
        self removecomponent( "p2p" );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self removecomponent( "path" );
    }
    
    if ( self hascomponent( "animator" ) )
    {
        self removecomponent( "animator" );
    }
    
    self vehphys_parkingbrake( 1 );
    
    if ( activityinstance.var_e814baa69305ee8a )
    {
        activityinstance.var_e814baa69305ee8a.vehicles = arrayremove( activityinstance.var_e814baa69305ee8a.vehicles, self );
    }
    
    waitframe();
    
    if ( self.riders.size )
    {
        if ( activityinstance.var_8c0b9efa3145cbb4 )
        {
            function_64ac8c4e752f4dca( self.var_7cb62ed461d8c370, 1 );
            activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_7cb62ed461d8c370 );
        }
        
        thread function_2980881f26c2e690();
        self endon( #"death" );
        utility::waittill_notify_or_timeout( "unloaded", 8 );
        ob_convoy_util::ob_spawn_cover_nodes();
        thread ob_convoy_util::function_8d8088d29dcb67a2();
    }
    
    self.var_1f9d76cca64c48f6 = undefined;
    self.var_a5f34fcc4fb8b328 = 1;
    vehicle_occupancy::set_team( self, "neutral" );
    function_ad7acf0db34cc62( self, 1 );
    self notify( #"vehicle_unloaded" );
    self vehicleclearanims();
    self vehphys_parkingbrake( 0 );
}

// Namespace namespace_f384a0805440e6ab
// Params 1, eflags: 0x4
// Checksum 0xeef7a514, Offset: 0x1afd
// Size: 0x162
function private function_73e24f6541b45003( activityinstance )
{
    crash_speed = self vehicle_getspeed();
    var_b363a8cdd38c8d76 = randomfloatrange( 150, 225 );
    var_8c8c13c3c3a794e1 = randomfloatrange( 15, 30 );
    var_21de78005a63c185 = utility::cointoss() ? -1 * var_8c8c13c3c3a794e1 : var_8c8c13c3c3a794e1;
    var_287dd1eda5e53859 = ( var_b363a8cdd38c8d76, 0, 0 );
    var_bfa40987498bbd16 = self.angles + ( 0, var_21de78005a63c185, 0 );
    var_84fbfb33b1b6b884 = self.origin + rotatevector( var_287dd1eda5e53859, var_bfa40987498bbd16 );
    var_84fbfb33b1b6b884 = getgroundposition( var_84fbfb33b1b6b884, 128 );
    self notify( #"path_updated" );
    self stoppath();
    self removecomponent( "path" );
    waitframe();
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( crash_speed ) );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", var_84fbfb33b1b6b884 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 50 );
    self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
    utility::waittill_any_timeout( 2, "goal", "near_goal", "path_blocked" );
    function_4832643e350f6a9( activityinstance );
}

// Namespace namespace_f384a0805440e6ab
// Params 2, eflags: 0x4
// Checksum 0x8ae483b7, Offset: 0x1c67
// Size: 0x50, Type: bool
function private function_d327ab4c0ad1af1( target, turretindex )
{
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( target.notarget )
    {
        return false;
    }
    
    if ( target.inlaststand )
    {
        return false;
    }
    
    if ( target supers_mp::function_60dbd7e2f1b02c22() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_f384a0805440e6ab
// Params 2
// Checksum 0xd746bbe9, Offset: 0x1cc0
// Size: 0x57c
function function_fe7ac887330b2634( var_1ebf041fca0a7187, vehicle_ref_override )
{
    vehiclearray = [];
    spawndata = spawnstruct();
    spawndata.angles = self.nd_spline_start.angles;
    spawndata.team = self.ai_team;
    spawndata.initai = 1;
    spawndata vehicle_spawn::prevent_respawn();
    spawndata.var_499a16b493ff31ed = 1;
    spawndata.triggerrecycle = 1;
    offsetdirection = vectornormalize( anglestoforward( self.nd_spline_start.angles ) * ( 1, 1, 0 ) );
    offsetstep = 640;
    var_ca9d60fd667eb5c1 = [ %"hash_e2d0d366f55399e" ];
    self.vehicle_ref = vehicle_ref_override ?? utility::array_random( var_ca9d60fd667eb5c1 );
    self.convoydata = [];
    
    for ( index = 0; index < self.var_7d7a32be78c7fc98.size ; index++ )
    {
        var_77c8c5497c88f2e4 = randomfloatrange( 10, 35 );
        var_1b299177a948cca7 = offsetstep + var_77c8c5497c88f2e4;
        spawndata.origin = self.nd_spline_start.origin - offsetdirection * index * var_1b299177a948cca7 + ( 0, 0, 100 );
        vehicle = undefined;
        self.convoydata[ index ] = spawnstruct();
        
        if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_a3a16920ec351b48" ) )
        {
            vehicle = utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_a3a16920ec351b48", self.var_7d7a32be78c7fc98[ index ].vehicleref, spawndata );
        }
        else
        {
            vehicle = vehicle::spawn( self.var_7d7a32be78c7fc98[ index ].vehicleref, spawndata );
        }
        
        assert( isdefined( vehicle ), "<dev string:xb7>" );
        vehicle forcenetfieldhighlod( 1 );
        vehicle.riders = [];
        vehicle.unloadque = [];
        vehicle.unload_group = "all";
        vehicle utility::ent_flag_init( "armored_convoy_spawned" );
        vehicle vehicle_aianim::handle_attached_guys();
        turrets = vehicle::get_turrets( vehicle );
        
        if ( turrets.size > 0 )
        {
            turretkey = getarraykey( turrets, 0 );
            vehicle.mgturret = [];
            vehicle.mgturret[ 0 ] = turrets[ turretkey ];
            vehicle turret::function_2e0a246d12d5e047( &function_d327ab4c0ad1af1 );
            vehicle turret::function_40a195262f7f99ab( 1, level.teamnamelist );
            vehicle.var_8d709d1797b48f07 = 1;
        }
        
        function_e0b8200dca0a89dd( self, self.convoydata[ index ], spawndata.origin, index, vehicle );
        assert( self.convoydata[ index ].var_20b91e17abb8a3a8.size > 0, "<dev string:xd6>" );
        vehicledata = vehicle::get_data( self.var_7d7a32be78c7fc98[ index ].vehicleref );
        
        if ( self.convoydata[ index ].var_20b91e17abb8a3a8.size > vehicledata.aiseats.size )
        {
            errormsg = "Error - AI encounter " + self.var_7d7a32be78c7fc98[ index ].riderencounter;
            errormsg = errormsg + " spawned " + self.convoydata[ index ].var_20b91e17abb8a3a8.size;
            errormsg = errormsg + " riders, but vehicle " + self.var_7d7a32be78c7fc98[ index ].vehicleref;
            errormsg = errormsg + " has only " + vehicledata.aiseats.size + " seats!";
            assertmsg( errormsg );
        }
        
        vehicle.script_index = index;
        vehicle.var_3a92d7abfab8b5d9 = 0;
        vehicle.var_1f9d76cca64c48f6 = 1;
        
        if ( self.disablecaralarm )
        {
            vehicle.playedcaralarm = 1;
        }
        
        vehicle.var_a5f34fcc4fb8b328 = 0;
        vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
        function_ad7acf0db34cc62( vehicle, 0 );
        vehicle setscriptablepartstate( #"single", #"vehicle_unusable_pingable" );
        
        if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_e74a4c4cb94d0ad0" ) )
        {
            vehicle.lootcache = utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_e74a4c4cb94d0ad0", vehicle );
        }
        
        vehicle function_ea01347b46439aec();
        vehicle thread function_73900cd658e021db( self );
        vehicle thread function_45d9569deceffca( self );
        vehicle thread function_374161e48b410415( self );
        thread activity_participation::function_d041ee0ec570299d( vehicle );
        
        if ( self.var_7d7a32be78c7fc98[ index ].istarget )
        {
            vehicle.istarget = 1;
            self.var_83e013bcaf310285 = vehicle;
            vehicle utility::ent_flag_set( "vehicle_paths_scripted_speed" );
        }
        
        vehiclearray[ vehiclearray.size ] = vehicle;
        waitframe();
    }
    
    if ( utility::issharedfuncdefined( #"hash_f339f0b3bf8981c5", #"hash_a47d42c814ab1e20" ) )
    {
        [[ utility::getsharedfunc( #"hash_f339f0b3bf8981c5", #"hash_a47d42c814ab1e20" ) ]]( self );
    }
    
    return vehiclearray;
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0xabd8cd35, Offset: 0x2245
// Size: 0x1a5
function function_2cde605d1452364a()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_ca257099ad30b077 = self.var_c4ba58fd936d79f1 game_utility_mp::get_linked_vehicle_nodes();
    var_ca257099ad30b077 = arrayrandomize( var_ca257099ad30b077 );
    
    foreach ( startnode in var_ca257099ad30b077 )
    {
        player = function_47c86977a18df38b( level.players, startnode.origin, 1500 );
        
        if ( isdefined( player ) )
        {
            continue;
        }
        
        players = player_utility::script_getplayersinradius( startnode.origin, 3000 );
        
        if ( players.size == 0 )
        {
            return startnode;
        }
        
        foreach ( player in players )
        {
            var_8eba82ead0f19157 = trace::ray_trace_passed( player geteye(), startnode.origin + ( 0, 0, 30 ), [ player ] );
            
            if ( var_8eba82ead0f19157 == 0 )
            {
                return startnode;
            }
        }
    }
    
    return utility::array_random( var_ca257099ad30b077 );
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0xde04be14, Offset: 0x23f3
// Size: 0xc0
function function_374161e48b410415( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"vehicle_unloaded" );
    
    while ( !isdefined( self.driver ) )
    {
        /#
            iprintln( "<dev string:xeb>" );
        #/
        
        waitframe();
    }
    
    msg = utility::waittill_any_ents_return( self.driver, "death", self, "damage_heavy" );
    self notify( #"hash_8fac0587f6284d6b" );
    thread function_a01d1e725ab15d94( activityinstance );
    activityinstance.a_vh_convoy = arrayremove( activityinstance.a_vh_convoy, self );
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x691db666, Offset: 0x24bb
// Size: 0x21d
function function_73900cd658e021db( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    self endon( #"entitydeleted" );
    self endon( #"hash_8fac0587f6284d6b" );
    self endon( #"engage" );
    var_2747cdcc610c7fd4 = [];
    n_distance = 16000000;
    
    if ( !isdefined( activityinstance.var_35f3ffa518fd410e ) )
    {
        activityinstance.var_35f3ffa518fd410e = 0;
    }
    
    while ( true )
    {
        if ( self.isdestroyed )
        {
            return;
        }
        
        self waittill( #"damage", amount, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isplayer( attacker ) && spatial_zone_container::function_c6b163965cbc2caa( attacker, activityinstance, "Awareness_Zone" ) )
        {
            activity_participation::function_bc67362dace4370c( activityinstance, attacker, "PlayerJoinedDamage" );
        }
        
        if ( isplayer( attacker ) && distancesquared( self.origin, attacker.origin ) <= n_distance && !activityinstance.var_35f3ffa518fd410e )
        {
            activityinstance notify( #"under_attack" );
            activityinstance.var_35f3ffa518fd410e = 1;
            
            if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_7c46e0eba7b87d1f" ) )
            {
                utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_7c46e0eba7b87d1f", activityinstance, 0, attacker );
            }
        }
        
        if ( self.health < self.maxhealth * 0.5 )
        {
            self notify( #"damage_heavy" );
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x6911337b, Offset: 0x26e0
// Size: 0x40
function function_45d9569deceffca( activityinstance )
{
    self endon( #"entitydeleted" );
    self waittill( #"death" );
    earthquake( 0.5, 1, self.origin, 1500 );
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0xa9d0a429, Offset: 0x2728
// Size: 0x160
function function_2980881f26c2e690()
{
    foreach ( rider in self.riders )
    {
        if ( !utility::is_dead_or_dying( rider ) )
        {
            rider thread ob_activity_utility::function_798aace978e876b();
            turret = rider getturret();
            
            if ( isdefined( turret ) )
            {
                if ( utility::flag( "stealth_enabled" ) && isdefined( rider.stealth ) && rider.stealth_enabled )
                {
                    rider setstealthstate( "combat" );
                }
            }
            else
            {
                if ( !isdefined( rider.vehicle_position ) && isdefined( rider.script_startingposition ) )
                {
                    rider.vehicle_position = rider.script_startingposition;
                }
                
                if ( isdefined( rider.vehicle_position ) )
                {
                    rider thread function_7a6d4258ae53956c( self.origin );
                    thread vehicle_aianim::guy_unload( rider, rider.vehicle_position );
                }
            }
            
            n_wait = randomfloatrange( 0.2, 0.3 );
            wait n_wait;
        }
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x2e82401e, Offset: 0x2890
// Size: 0x28f
function function_a01d1e725ab15d94( activityinstance )
{
    self endon( #"death" );
    self endon( #"entitydeleted" );
    b_last_vehicle = 0;
    
    if ( self.script_index == activityinstance.a_vh_ground.size - 1 )
    {
        b_last_vehicle = 1;
    }
    
    crash_speed = 35;
    var_b363a8cdd38c8d76 = 768;
    
    /#
        iprintln( "<dev string:x105>" );
    #/
    
    var_8c8c13c3c3a794e1 = randomfloatrange( 25, 35 );
    var_21de78005a63c185 = utility::cointoss() ? -1 * var_8c8c13c3c3a794e1 : var_8c8c13c3c3a794e1;
    var_287dd1eda5e53859 = ( var_b363a8cdd38c8d76, 0, 0 );
    var_bfa40987498bbd16 = self.angles + ( 0, var_21de78005a63c185, 0 );
    var_84fbfb33b1b6b884 = self.origin + rotatevector( var_287dd1eda5e53859, var_bfa40987498bbd16 );
    var_84fbfb33b1b6b884 = getgroundposition( var_84fbfb33b1b6b884, 128 );
    self notify( #"path_updated" );
    self stoppath();
    self removecomponent( "path" );
    activityinstance.var_e814baa69305ee8a.vehicles = arrayremove( activityinstance.var_e814baa69305ee8a.vehicles, self );
    waitframe();
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 2 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 8 );
    self function_eb88c4e66edbc855( "p2p", "automaticFast", 1 );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( crash_speed ) );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", var_84fbfb33b1b6b884 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 50 );
    self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
    utility::waittill_any_timeout( 5, "goal", "near_goal", "path_blocked" );
    self removecomponent( "p2p" );
    waitframe();
    
    if ( self.riders.size )
    {
        if ( activityinstance.var_8c0b9efa3145cbb4 )
        {
            function_64ac8c4e752f4dca( self.var_7cb62ed461d8c370, 1 );
            activityinstance activity_ai_encounters::function_1010ba035d94f9f1( self.var_7cb62ed461d8c370 );
        }
        
        thread function_2980881f26c2e690();
        self endon( #"death" );
        utility::waittill_notify_or_timeout( "unloaded", 8 );
        ob_convoy_util::ob_spawn_cover_nodes();
        thread ob_convoy_util::function_8d8088d29dcb67a2();
    }
    
    vehicle_occupancy::set_team( self, "neutral" );
    function_ad7acf0db34cc62( self, 1 );
    self.var_a5f34fcc4fb8b328 = 1;
    self notify( #"vehicle_unloaded" );
    self vehicleclearanims();
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x5bceb420, Offset: 0x2b27
// Size: 0x64
function function_7a6d4258ae53956c( var_465b20e0d8be9bfd )
{
    self endon( #"death" );
    self waittill( #"unloaded" );
    
    if ( utility::flag( "stealth_enabled" ) && isdefined( self.stealth ) && self.stealth_enabled )
    {
        self setstealthstate( "combat" );
    }
    
    self setgoalpos( var_465b20e0d8be9bfd, 750 );
}

// Namespace namespace_f384a0805440e6ab
// Params 2
// Checksum 0xad46120e, Offset: 0x2b93
// Size: 0x54
function function_ad7acf0db34cc62( vehicle, var_bed9b53b2f85501d )
{
    instancedataforvehicle = vehicle_interact::get_instance_data( vehicle, undefined, 1 );
    
    if ( !isdefined( instancedataforvehicle ) )
    {
        return;
    }
    
    if ( var_bed9b53b2f85501d )
    {
        if ( instancedataforvehicle.disabledbyallow <= 0 )
        {
            return;
        }
    }
    
    vehicle_interact::allow_use( vehicle, var_bed9b53b2f85501d );
}

// Namespace namespace_f384a0805440e6ab
// Params 3
// Checksum 0x5fa68241, Offset: 0x2bef
// Size: 0x1cf
function function_ea01347b46439aec( var_3c09ff595c6166a9 = 1, addpath = 1, var_d2b2b98d77c9c0 = 0 )
{
    if ( var_3c09ff595c6166a9 )
    {
        if ( !self hascomponent( "p2p" ) )
        {
            self addcomponent( "p2p" );
        }
    }
    
    if ( addpath )
    {
        if ( !self hascomponent( "path" ) )
        {
            self addcomponent( "path" );
        }
    }
    
    if ( var_d2b2b98d77c9c0 )
    {
        if ( !self hascomponent( "animator" ) )
        {
            self addcomponent( "animator" );
        }
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self function_eb88c4e66edbc855( "p2p", "checkStuck", 0 );
        self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", 1 );
        self function_eb88c4e66edbc855( "p2p", "automaticNormal", 1 );
        self function_eb88c4e66edbc855( "p2p", "brakeOnGoalGasbrake", 1 );
        self function_eb88c4e66edbc855( "p2p", "goalPoint", self.origin );
        self function_eb88c4e66edbc855( "p2p", "goalThreshold", 200 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 1 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedThreshold", 1 );
        self function_eb88c4e66edbc855( "p2p", "automaticFastTopspeedFraction", 1 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
        self function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 2 );
        self function_eb88c4e66edbc855( "p2p", "gasToStopMovement", 0.9 );
        self function_eb88c4e66edbc855( "p2p", "steeringMultiplier", 2 );
    }
    
    if ( self hascomponent( "path" ) )
    {
        self function_eb88c4e66edbc855( "path", "radiusToStep", 300 );
    }
    
    self.dontunloadonend = 1;
}

// Namespace namespace_f384a0805440e6ab
// Params 5
// Checksum 0x941059cf, Offset: 0x2dc6
// Size: 0x204
function function_e0b8200dca0a89dd( activityinstance, convoydata, origin, vehicleindex, vehicle )
{
    assert( vehicleindex >= 0 && vehicleindex < activityinstance.var_7d7a32be78c7fc98.size, "<dev string:x118>" );
    convoydata.var_7cb62ed461d8c370 = activityinstance activity_ai_encounters::function_eb8506829193f5eb( activityinstance.var_7d7a32be78c7fc98[ vehicleindex ].riderencounter, origin, 128, 1, 0, 1, 2 );
    vehicle.var_7cb62ed461d8c370 = convoydata.var_7cb62ed461d8c370;
    function_c505198907e0d306( convoydata.var_7cb62ed461d8c370, vehicle );
    
    /#
        if ( isdefined( self.var_8ac4adf7bae6f45a ) )
        {
            function_1a9d724a960fa19d( convoydata.var_7cb62ed461d8c370, self.var_8ac4adf7bae6f45a, 1 );
        }
    #/
    
    if ( !isdefined( convoydata.var_c7c801fd0b2bf1ee ) )
    {
        convoydata.var_20b91e17abb8a3a8 = [];
    }
    
    if ( isdefined( convoydata.var_7cb62ed461d8c370 ) )
    {
        activityinstance activity_ai_encounters::function_52d1342183200a8f( convoydata.var_7cb62ed461d8c370, &function_d312c852b407029c, convoydata );
        function_64ac8c4e752f4dca( convoydata.var_7cb62ed461d8c370, 0 );
        activityinstance activity_ai_encounters::function_48582991402cac50( convoydata.var_7cb62ed461d8c370, 1 );
        ai_spawn_director::function_3ce5298df1143d67( "FinishedSpawningBucket", convoydata.var_7cb62ed461d8c370 );
        
        foreach ( agent in convoydata.var_20b91e17abb8a3a8 )
        {
            agent thread function_3b3b4d4754d980ae( activityinstance );
            activityinstance thread activity_participation::function_d041ee0ec570299d( agent );
            activityinstance.a_ai_convoy[ activityinstance.a_ai_convoy.size ] = agent;
        }
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 4
// Checksum 0xc250ce0e, Offset: 0x2fd2
// Size: 0x74
function function_d312c852b407029c( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    
    if ( isalive( agent ) )
    {
        convoydata = userdata;
        agent.vehiclerunexit = 1;
        convoydata.var_20b91e17abb8a3a8[ convoydata.var_20b91e17abb8a3a8.size ] = agent;
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1, eflags: 0x4
// Checksum 0x16492b86, Offset: 0x304e
// Size: 0x99
function private function_b3ed9dde1885d4e4( var_5aedb7a67cad8b3d )
{
    level notify( #"hash_a57c55e50e75bce3" );
    level endon( #"hash_a57c55e50e75bce3" );
    self endon( #"death" );
    splinelength = function_a1c16b5acd0c1974( var_5aedb7a67cad8b3d );
    duration = 5000;
    
    while ( true )
    {
        wait 1;
        var_eb2931f04b29ee05 = self function_15a3903f8135db46();
        
        /#
            print3d( self.origin, "<dev string:x154>" + var_eb2931f04b29ee05 / splinelength, ( 1, 1, 1 ), 1, 1, duration, 1 );
        #/
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x5ea76dfa, Offset: 0x30ef
// Size: 0xb3
function function_d3546d9428bf0e4c( activityinstance )
{
    self endon( #"death" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    var_6faf532ba54370ae = activityinstance.nd_spline_start;
    nodeindex = getvehiclenodeindex( var_6faf532ba54370ae.targetname, #targetname );
    waitframe();
    
    if ( isdefined( self ) )
    {
        self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( activityinstance.n_veh_speed ) );
        self function_eb88c4e66edbc855( "path", "radiantId", nodeindex );
        thread function_75f96f85a856b58a( var_6faf532ba54370ae );
        self vehicle_turnengineon();
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x710f163b, Offset: 0x31aa
// Size: 0x147
function function_75f96f85a856b58a( node )
{
    assert( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x155>" );
    self notify( #"newpath" );
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    self endon( #"newpath" );
    self endon( #"death" );
    pathpoint = pathstart;
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = vehicle_paths::get_path_getfunc( pathstart );
    dist_sq = 40000;
    
    while ( isdefined( nextpoint ) )
    {
        if ( !isstruct( nextpoint ) )
        {
            vehicle_paths::node_wait( nextpoint, lastpoint, get_func );
        }
        else
        {
            vehicle_paths::struct_wait( nextpoint, lastpoint, dist_sq );
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        vehicle_paths::trigger_process_node( nextpoint );
        self.currentnode = nextpoint;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        lastpoint = nextpoint;
        nextpoint = get_nextpoint( get_func, nextpoint );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            break;
        }
    }
    
    self notify( #"reached_dynamic_path_end" );
}

// Namespace namespace_f384a0805440e6ab
// Params 2, eflags: 0x4
// Checksum 0xd74dcded, Offset: 0x32f9
// Size: 0x8a
function private get_nextpoint( get_func, point )
{
    if ( isstring( self.veh_pathdir ) && self.veh_pathdir == "reverse" )
    {
        return point.prevpoint;
    }
    else if ( !point.target )
    {
        return;
    }
    
    next_point = [[ get_func ]]( point );
    
    if ( !isdefined( next_point ) )
    {
        assertmsg( "<dev string:x17a>" + point.origin );
    }
    
    return next_point;
}

// Namespace namespace_f384a0805440e6ab
// Params 2
// Checksum 0x129b024b, Offset: 0x338c
// Size: 0x105
function function_247a8d955d90097b( speed, b_ground_only = 1 )
{
    if ( b_ground_only == 1 )
    {
        vehicles = self.a_vh_ground;
    }
    else
    {
        vehicles = self.a_vh_convoy;
    }
    
    foreach ( vehicle in vehicles )
    {
        self.n_veh_speed = speed;
        
        if ( !isdefined( vehicle ) )
        {
            continue;
        }
        
        if ( vehicle hascomponent( "p2p" ) )
        {
            vehicle function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speed ) );
            vehicle.p2p_speed = speed;
            continue;
        }
        
        vehicle vehicle_setspeed( speed );
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 0, eflags: 0x4
// Checksum 0x3fa15391, Offset: 0x3499
// Size: 0x649
function private function_55ef927f56f1bebe()
{
    self notify( #"hash_a95f0a22266b696f" );
    self endon( #"hash_a95f0a22266b696f" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"under_attack" );
    self endon( #"unloaded" );
    self endon( #"hash_515b5bdfddc2a3f3" );
    assert( isdefined( self.a_vh_convoy ) );
    assert( isdefined( self.a_vh_ground ) );
    assert( isdefined( self.n_veh_speed ) );
    thread function_7042ad6e488f911e();
    
    while ( self.a_vh_ground.size > 1 )
    {
        self.a_vh_convoy = function_46f9072493651dc9( self.a_vh_convoy );
        self.a_vh_ground = function_46f9072493651dc9( self.a_vh_ground );
        convoyvehicles = self.a_vh_ground;
        
        if ( self.var_e814baa69305ee8a.traffic_paused )
        {
            waitframe();
            continue;
        }
        
        /#
            drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
            
            if ( drawdebug )
            {
                for ( index = 0; index < convoyvehicles.size ; index++ )
                {
                    print3d( convoyvehicles[ index ].origin, "<dev string:x154>" + convoyvehicles[ index ].veh_speed + "<dev string:x1ce>" + self.n_veh_speed, ( 1, 1, 1 ), 1, 1, 1, 1 );
                }
            }
        #/
        
        var_4adbd49fa8ee3cb5 = convoyvehicles[ 0 ].var_c533293b01e34038 < 2250000;
        
        if ( self.n_veh_speed == 0 || convoyvehicles[ 0 ].veh_speed < self.n_veh_speed * 0.8 || var_4adbd49fa8ee3cb5 )
        {
            if ( var_4adbd49fa8ee3cb5 )
            {
                for ( index = 0; index < convoyvehicles.size ; index++ )
                {
                    if ( convoyvehicles[ index ].p2p_speed > self.n_veh_speed )
                    {
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( self.n_veh_speed ) );
                        convoyvehicles[ index ].p2p_speed = self.n_veh_speed;
                    }
                }
            }
            
            waitframe();
            continue;
        }
        
        offsetpositions = [];
        offsetdistance = 640;
        projectedpositions = [];
        
        for ( index = 0; index < convoyvehicles.size ; index++ )
        {
            if ( index > 0 )
            {
                leadorigin = convoyvehicles[ index - 1 ].origin;
                leadforward = vectornormalize( anglestoforward( convoyvehicles[ index - 1 ].angles * ( 0, 1, 0 ) ) );
                offsetpositions[ offsetpositions.size ] = leadorigin - leadforward * offsetdistance;
                vehicledirection = convoyvehicles[ index ].origin - leadorigin;
                var_45f4531f94229ec5 = vectordot2( vehicledirection, leadforward, 0 );
                projectedpositions[ projectedpositions.size ] = leadorigin + leadforward * var_45f4531f94229ec5;
                continue;
            }
            
            offsetpositions[ offsetpositions.size ] = convoyvehicles[ index ].origin;
            projectedpositions[ projectedpositions.size ] = convoyvehicles[ index ].origin;
        }
        
        if ( offsetpositions.size > 1 )
        {
            /#
                drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                
                if ( drawdebug )
                {
                    for ( index = 1; index < offsetpositions.size ; index++ )
                    {
                        color = ( 1, 0.5, 0.1 );
                        line( convoyvehicles[ index - 1 ].origin, offsetpositions[ index ], color, 1, 0, 1 );
                        sphere( offsetpositions[ index ], 10, color, 0, 1 );
                    }
                }
            #/
            
            for ( index = 1; index < projectedpositions.size ; index++ )
            {
                if ( convoyvehicles[ index ].var_d92971aa060653fd )
                {
                    continue;
                }
                
                leadforward = vectornormalize( anglestoforward( convoyvehicles[ index - 1 ].angles * ( 0, 1, 0 ) ) );
                var_986b7951e7bc00e1 = vectornormalize( projectedpositions[ index ] - offsetpositions[ index ] );
                var_415e27a7dd8fa602 = vectordot2( var_986b7951e7bc00e1, leadforward, 0 );
                vehicleforward = vectornormalize( anglestoforward( convoyvehicles[ index ].angles * ( 0, 1, 0 ) ) );
                var_505aba861041d728 = vectordot2( vehicleforward, leadforward, 0 );
                
                if ( var_505aba861041d728 > 0 )
                {
                    if ( var_415e27a7dd8fa602 > cos( 45 ) )
                    {
                        newspeed = self.n_veh_speed * 0.9;
                        
                        if ( index > 1 && isdefined( convoyvehicles[ index - 1 ].p2p_speed ) )
                        {
                            newspeed = convoyvehicles[ index - 1 ].p2p_speed * 0.9;
                        }
                        
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( newspeed ) );
                        convoyvehicles[ index ].p2p_speed = newspeed;
                    }
                    else if ( !var_4adbd49fa8ee3cb5 )
                    {
                        newspeed = self.n_veh_speed * 1.1;
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( newspeed ) );
                        convoyvehicles[ index ].p2p_speed = newspeed;
                    }
                }
                else if ( !var_4adbd49fa8ee3cb5 )
                {
                    var_a5c3db95671ed9af = distance2dsquared( convoyvehicles[ index - 1 ].origin, convoyvehicles[ index ].origin );
                    
                    if ( var_a5c3db95671ed9af > 1000000 )
                    {
                        newspeed = self.n_veh_speed * 1.1;
                        convoyvehicles[ index ] function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( newspeed ) );
                        convoyvehicles[ index ].p2p_speed = newspeed;
                    }
                }
                
                /#
                    drawdebug = getdvarint( @"hash_67411f60c7ab4996", 0 ) > 0;
                    
                    if ( drawdebug )
                    {
                        color = ( 1, 0.75, 0.8 );
                        
                        if ( var_415e27a7dd8fa602 > cos( 45 ) )
                        {
                            color = ( 0, 1, 0 );
                        }
                        
                        line( projectedpositions[ index ], convoyvehicles[ index ].origin, color, 1, 0, 1 );
                        
                        if ( var_505aba861041d728 > 0 )
                        {
                            sphere( projectedpositions[ index ], 8, color, 0, 1 );
                        }
                    }
                #/
            }
        }
        
        waitframe();
    }
    
    self notify( #"all_vehicles_destroyed" );
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0xa61147f7, Offset: 0x3aea
// Size: 0x38
function function_3b3b4d4754d980ae( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    childthread ai_death_watcher( activityinstance );
    childthread function_4934c05f6b2d609b( activityinstance );
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x1e2d1c63, Offset: 0x3b2a
// Size: 0x63
function ai_death_watcher( activityinstance )
{
    while ( true )
    {
        self waittill( #"death", attacker );
        
        if ( arraycontains( level.players, attacker ) && spatial_zone_container::function_c6b163965cbc2caa( attacker, activityinstance, "Awareness_Zone" ) )
        {
            activity_participation::function_bc67362dace4370c( activityinstance, attacker, "PlayerJoinedDamage" );
        }
        
        break;
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x101fab31, Offset: 0x3b95
// Size: 0x67
function function_4934c05f6b2d609b( activityinstance )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bulletwhizby", attacker );
        
        if ( arraycontains( level.players, attacker ) && spatial_zone_container::function_c6b163965cbc2caa( attacker, activityinstance, "Awareness_Zone" ) )
        {
            activity_participation::function_bc67362dace4370c( activityinstance, attacker );
        }
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0xdf2b0225, Offset: 0x3c04
// Size: 0x38
function function_4dcf44cdf76bb5ed( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0xcc2d2e1, Offset: 0x3c44
// Size: 0x5a
function function_d06081717767fc6d( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_654756dcb26260ad" ) )
    {
        utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_654756dcb26260ad", self, relevant_info_struct );
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0xf0635e19, Offset: 0x3ca6
// Size: 0xa8
function function_bea00b6807a5c751( var_54c779cf281bb58d )
{
    activity_type = activity_instance_common::getactivitytype( self );
    
    if ( activity_type == "REV_OB_ARMORED_CONVOY" )
    {
        if ( var_54c779cf281bb58d.enteredzone && var_54c779cf281bb58d.firsttimeinzone && !self.convoy_engaged )
        {
            player_list = [];
            player_list[ player_list.size ] = var_54c779cf281bb58d.player;
            
            if ( utility::issharedfuncdefined( #"hash_3d4481e54c199ae4", #"hash_1696460b6fd16672" ) )
            {
                utility::callsharedfunc( #"hash_3d4481e54c199ae4", #"hash_1696460b6fd16672", self, player_list );
            }
        }
    }
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x7a2c6e50, Offset: 0x3d56
// Size: 0x11a
function function_da8ee699f89950b4( convoyparams )
{
    if ( isdefined( convoyparams ) )
    {
        self.var_c8ee5a53f2f41b41 = spawnstruct();
        self.var_c8ee5a53f2f41b41.var_85991905917e913d = convoyparams.convoyvehicles.size ?? 0;
        self.var_c8ee5a53f2f41b41.var_c466184829df94f0 = [];
        self.var_c8ee5a53f2f41b41.vehiclerefs = [];
        
        for ( i = 0; i < convoyparams.convoyvehicles.size ; i++ )
        {
            self.var_c8ee5a53f2f41b41.var_c466184829df94f0[ i ] = "ai_encounter:" + convoyparams.convoyvehicles[ i ].variant_object.riderencounter;
            self.var_c8ee5a53f2f41b41.vehiclerefs[ i ] = convoyparams.convoyvehicles[ i ].variant_object.vehicle;
        }
        
        return;
    }
    
    assertmsg( "<dev string:x1d0>" );
}

// Namespace namespace_f384a0805440e6ab
// Params 0
// Checksum 0x1eed6ce1, Offset: 0x3e78
// Size: 0x15
function function_9dfc1f6914f4a7d5()
{
    return self.var_c8ee5a53f2f41b41.var_85991905917e913d;
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x9629af4c, Offset: 0x3e96
// Size: 0x56
function function_deb352f09e1247cf( var_fbc9b9a942a814f9 )
{
    assert( var_fbc9b9a942a814f9 >= 0 && var_fbc9b9a942a814f9 < self.var_c8ee5a53f2f41b41.var_85991905917e913d, "<dev string:x205>" + var_fbc9b9a942a814f9 + "<dev string:x227>" );
    return self.var_c8ee5a53f2f41b41.var_c466184829df94f0[ var_fbc9b9a942a814f9 ];
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0x4710c3e, Offset: 0x3ef5
// Size: 0x56
function function_7fb97e96ec4d15a3( var_fbc9b9a942a814f9 )
{
    assert( var_fbc9b9a942a814f9 >= 0 && var_fbc9b9a942a814f9 < self.var_c8ee5a53f2f41b41.var_85991905917e913d, "<dev string:x205>" + var_fbc9b9a942a814f9 + "<dev string:x227>" );
    return self.var_c8ee5a53f2f41b41.vehiclerefs[ var_fbc9b9a942a814f9 ];
}

// Namespace namespace_f384a0805440e6ab
// Params 1
// Checksum 0xb9af8e73, Offset: 0x3f54
// Size: 0xc
function function_4dddc12035678d79( vehicle )
{
    
}

/#

    // Namespace namespace_f384a0805440e6ab
    // Params 0
    // Checksum 0x1eea684a, Offset: 0x3f68
    // Size: 0xc, Type: dev
    function function_7a5db9c3add96f26()
    {
        function_b3abb33bdb57c35d();
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 1, eflags: 0x4
    // Checksum 0x19a2c5de, Offset: 0x3f7c
    // Size: 0x144, Type: dev
    function private veh_spawn_vehicle( targetname )
    {
        playerforward = anglestoforward( level.players[ 0 ].angles );
        spawndata = spawnstruct();
        spawndata.origin = level.players[ 0 ].origin + playerforward * 500 + ( 0, 0, 300 );
        spawndata.angles = level.players[ 0 ].angles;
        spawndata.team = self.ai_team;
        spawndata.initai = 1;
        spawndata.var_499a16b493ff31ed = 1;
        spawndata.triggerrecycle = 1;
        vehicledata = vehicle::get_data( targetname );
        vehicle = vehicle::spawn( targetname, spawndata );
        vehicle vehicle_code::vehicle_disable_navobstacles();
        vehicle thread utility::script_func( "<dev string:x22a>" );
        
        if ( !isdefined( level.spawnedvehicles ) )
        {
            level.spawnedvehicles = [];
        }
        
        level.spawnedvehicles[ level.spawnedvehicles.size ] = vehicle;
        return vehicle;
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 2, eflags: 0x4
    // Checksum 0x26b432f6, Offset: 0x40c8
    // Size: 0x19f, Type: dev
    function private function_33f4f8899307bc90( addpath, var_d2b2b98d77c9c0 )
    {
        if ( !isdefined( addpath ) )
        {
            addpath = 0;
        }
        
        if ( !isdefined( var_d2b2b98d77c9c0 ) )
        {
            var_d2b2b98d77c9c0 = 0;
        }
        
        if ( !self hascomponent( "<dev string:x239>" ) )
        {
            self addcomponent( "<dev string:x239>" );
        }
        
        if ( addpath )
        {
            if ( !self hascomponent( "<dev string:x23d>" ) )
            {
                self addcomponent( "<dev string:x23d>" );
            }
        }
        
        if ( var_d2b2b98d77c9c0 )
        {
            if ( !self hascomponent( "<dev string:x242>" ) )
            {
                self addcomponent( "<dev string:x242>" );
            }
        }
        
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x24b>", 0 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x256>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x262>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x272>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x286>", self.origin );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x290>", 200 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x29e>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x2b1>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x2c8>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x2e6>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x2fc>", 4 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x29e>", 2 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x312>", 0.9 );
        self function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x324>", 2 );
        self function_eb88c4e66edbc855( "<dev string:x23d>", "<dev string:x337>", 300 );
        self.stopping = 0;
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 3, eflags: 0x4
    // Checksum 0x53e95fee, Offset: 0x426f
    // Size: 0x57, Type: dev
    function private function_f58660c39afe99d1( startpos, endpos, speed )
    {
        segmentlength = distance( startpos, endpos );
        moverate = segmentlength / speed;
        
        if ( moverate < 0.05 )
        {
            moverate = 0.05;
        }
        
        return moverate;
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 2, eflags: 0x4
    // Checksum 0x87e257db, Offset: 0x42ce
    // Size: 0x98, Type: dev
    function private function_c3ee0922b548bb43( splinepoints, speedips )
    {
        durations = [];
        assert( splinepoints.size <= 48 );
        
        if ( splinepoints.size >= 2 )
        {
            for ( index = 0; index < splinepoints.size - 1 ; index++ )
            {
                currentpoint = splinepoints[ index ];
                nextpoint = splinepoints[ index + 1 ];
                durations[ durations.size ] = function_f58660c39afe99d1( currentpoint, nextpoint, speedips );
            }
            
            durations[ durations.size ] = durations[ durations.size - 1 ];
        }
        
        return durations;
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 1, eflags: 0x4
    // Checksum 0x297a1f54, Offset: 0x436e
    // Size: 0x30b, Type: dev
    function private function_8f7758a0c98b4287( params )
    {
        if ( !isdefined( level.spawnedvehicles ) )
        {
            return;
        }
        
        level.spawnedvehicles = function_46f9072493651dc9( level.spawnedvehicles );
        
        if ( level.spawnedvehicles.size == 0 )
        {
            return;
        }
        
        vehicle = level.spawnedvehicles[ 0 ];
        startlocation = vehicle.origin;
        goallocation = level.players[ 0 ].origin;
        
        if ( params[ 1 ] == "<dev string:x344>" )
        {
            playerangles = level.players[ 0 ] getplayerangles();
            playerforward = anglestoforward( playerangles );
            playereyelocation = level.players[ 0 ] geteye();
            traceendlocation = playereyelocation + playerforward * 5000;
            traceresults = trace::ray_trace( playereyelocation, traceendlocation, level.players[ 0 ] );
            
            if ( isdefined( traceresults ) )
            {
                navmeshposition = getclosestpointonnavmesh( traceresults[ "<dev string:x346>" ], level.var_9bf7404017a1db9b );
                
                /#
                    color = ( 1, 0.65, 0 );
                    duration = 200;
                    sphere( traceresults[ "<dev string:x346>" ], 5, color, 0, duration );
                    line( navmeshposition, traceresults[ "<dev string:x346>" ], color, 1, 0, duration );
                #/
                
                goallocation = navmeshposition;
            }
        }
        
        vehicleforward = anglestoforward( vehicle.angles );
        var_9ed6c85de846a97c = isnavmeshloaded( "<dev string:x34f>" );
        var_7f0e92a7d2b854b2 = isnavmeshloaded( "<dev string:x35d>" );
        navmeshlayer = var_9ed6c85de846a97c ? "<dev string:x34f>" : var_7f0e92a7d2b854b2 ? "<dev string:x35d>" : undefined;
        var_59eaf0a3c2dd30be = params[ 0 ] == "<dev string:x344>" ? 2 : 1;
        splinepoints = vehicle findsplinepath( startlocation, goallocation, 50, 200, 100, vehicleforward, ( 0, 0, 0 ), 300, 0.4, 0, 1, navmeshlayer, 0, var_59eaf0a3c2dd30be );
        speedmph = 30;
        speedips = utility::mph_to_ips( speedmph );
        vehicle function_eb88c4e66edbc855( "<dev string:x239>", "<dev string:x36a>", speedips );
        
        if ( isdefined( splinepoints ) )
        {
            if ( params[ 0 ] == "<dev string:x344>" )
            {
                if ( splinepoints.size >= 48 )
                {
                    splinepoints = utility::array_slice( splinepoints, 0, 47 );
                }
                
                var_f2031896fbadeb97 = function_c3ee0922b548bb43( splinepoints, speedips );
                splineid = function_53253e8ea222ed60( splinepoints, var_f2031896fbadeb97 );
                vehicle function_eb88c4e66edbc855( "<dev string:x23d>", "<dev string:x376>", splineid );
            }
            
            vehicle thread vehicle_roads::function_2b723e6a5a86a006( splinepoints, isdefined( navmeshlayer ) ? ( 1, 1, 1 ) : ( 1, 0, 0 ) );
        }
        
        vehicle thread vehicle_roads::watch_stuck();
        vehicle thread vehicle_roads::watch_interrupt();
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 1, eflags: 0x4
    // Checksum 0x314ffa53, Offset: 0x4681
    // Size: 0xda, Type: dev
    function private function_99191cfee639a862( vehicleref )
    {
        adddebugcommand( "<dev string:x383>" );
        vehicle = veh_spawn_vehicle( vehicleref[ 0 ] );
        playerforward = anglestoforward( level.players[ 0 ].angles );
        var_56217c131fbd83ea = level.players[ 0 ].origin + playerforward * 500 + ( 0, 0, 300 );
        var_5edf8ee733bc024d = vectorcross( playerforward, ( 0, 0, 1 ) );
        startangles = axistoangles( playerforward, var_5edf8ee733bc024d, ( 0, 0, 1 ) );
        vehicle vehicle_teleport( var_56217c131fbd83ea, startangles );
        wait 1;
        vehicle function_33f4f8899307bc90( 1 );
        return vehicle;
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 1, eflags: 0x4
    // Checksum 0x2a9d0bd7, Offset: 0x4763
    // Size: 0x11f, Type: dev
    function private function_2e5c639691c17116( var_a185f14a01d55aeb )
    {
        self notify( #"hash_a7d8c9de19dda75d" );
        self endon( #"hash_a7d8c9de19dda75d" );
        assert( var_a185f14a01d55aeb > 0 );
        self.riders = [];
        self.unloadque = [];
        self.unload_group = "<dev string:x3ab>";
        vehicleforward = anglestoforward( self.angles );
        vehicle_aianim::handle_attached_guys();
        vehicle_occupancy::set_team( self, "<dev string:x3af>" );
        
        for ( seatindex = var_a185f14a01d55aeb; seatindex >= 0 ; seatindex-- )
        {
            spawnlocation = self.origin + vehicleforward * seatindex * 100 + ( 0, 0, 200 );
            agent = mp_agent::spawnnewagentaitype( "<dev string:x3c3>", spawnlocation, self.angles, "<dev string:x3af>", "<dev string:x3e8>" );
            
            if ( isdefined( agent ) )
            {
                agent.script_startingposition = seatindex;
                thread vehicle_aianim::guy_enter( agent );
                agent.vehiclerunexit = 1;
            }
            
            wait 0.5;
        }
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 1, eflags: 0x4
    // Checksum 0xdb76112, Offset: 0x488a
    // Size: 0x3a, Type: dev
    function private function_c81febcd38bd1c89( vehicleref )
    {
        vehicle = function_99191cfee639a862( vehicleref );
        vehicle forcenetfieldhighlod( 1 );
        vehicle thread function_2e5c639691c17116( 5 );
        return vehicle;
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 1, eflags: 0x4
    // Checksum 0x9668be66, Offset: 0x48cc
    // Size: 0x7d, Type: dev
    function private function_8d908ceb1c3ec1f2( vehicleref )
    {
        vehicle = function_c81febcd38bd1c89( vehicleref );
        var_9ed6c85de846a97c = isnavmeshloaded( "<dev string:x34f>" );
        var_7f0e92a7d2b854b2 = isnavmeshloaded( "<dev string:x35d>" );
        navmeshlayer = var_9ed6c85de846a97c ? "<dev string:x34f>" : var_7f0e92a7d2b854b2 ? "<dev string:x35d>" : undefined;
        vehicle thread vehicle_roads::function_46e7fc115379abb2( 15, navmeshlayer, 1 );
    }

    // Namespace namespace_f384a0805440e6ab
    // Params 0, eflags: 0x4
    // Checksum 0x3eae35c7, Offset: 0x4951
    // Size: 0x101, Type: dev
    function private function_b3abb33bdb57c35d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x3f8>" );
        devgui::add_devgui_dvar( "<dev string:x408>", "<dev string:x408>" );
        devgui::add_devgui_dvar( "<dev string:x423>", "<dev string:x423>" );
        devgui::add_devgui_dvar( "<dev string:x445>", "<dev string:x445>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x472>", "<dev string:x47f>" + "<dev string:x49b>", &function_99191cfee639a862 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4af>", "<dev string:x4ca>" + "<dev string:x49b>", &function_c81febcd38bd1c89 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4de>", "<dev string:x4ff>" + "<dev string:x49b>", &function_8d908ceb1c3ec1f2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x521>", "<dev string:x53c>" + 0 + "<dev string:x557>" + 0, &function_8f7758a0c98b4287 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x559>", "<dev string:x53c>" + 1 + "<dev string:x557>" + 0, &function_8f7758a0c98b4287 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x578>", "<dev string:x53c>" + 0 + "<dev string:x557>" + 1, &function_8f7758a0c98b4287 );
        devgui::function_77df7fe7dd273e10();
    }

#/
