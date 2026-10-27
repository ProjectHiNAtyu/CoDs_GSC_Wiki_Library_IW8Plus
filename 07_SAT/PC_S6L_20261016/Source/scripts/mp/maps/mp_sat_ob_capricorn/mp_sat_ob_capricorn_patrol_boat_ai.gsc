// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_patrol_boat_ai.gsc  (hash_1ff8a8bddb7df618.gscc) (size: 13075 Bytes / 0x3313 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x48ae2f73 (1219374963)
// size ...... 13075 (0x3313)
// includes .. 9   (offset: 0x2fd7)
// strings ... 36  (offset: 0x301f)
// dev strs .. 8   (offset: 0x32af)
// exports ... 31  (offset: 0x1eef)
// cseg ...... 0x30a + 0x1be5 (0x1eef)
// imports ... 98  (offset: 0x23c7)
// animtree1 . 0   (offset: 0x3313)
// animtree2 . 0   (offset: 0x3313)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_spawn;
#using scripts\mp\mp_agent;

#namespace mp_sat_ob_capricorn_patrol_boat_ai;

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 2, eflags: 0x4
// Checksum 0x2ae6e5e2, Offset: 0x328
// Size: 0x6c
function private function_ed6b07a1b0e31dc1( givenorigin, givenangle = ( 0, 0, 0 ) )
{
    spawndata = { #initai:1, #showheadicon:0, #angles:givenangle, #origin:givenorigin };
    spawndata vehicle_spawn::prevent_respawn();
    return spawndata;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1, eflags: 0x4
// Checksum 0x72cc3cdb, Offset: 0x39d
// Size: 0x280
function private function_7c940924ed154432( patrolpath )
{
    self vehicleshowonminimap( 0 );
    self setvehicleteam( "team_hundred_ninety" );
    thread function_f0fc3a66151150e9();
    
    if ( !patrolpath )
    {
        return;
    }
    
    if ( !self hascomponent( "p2p" ) )
    {
        self addcomponent( "p2p" );
    }
    
    self function_c21d39b1929f7cb1( 0 );
    function_fe6d5c7fec35a9b2();
    self.state = "patrol";
    self.destinationnode = patrolpath[ 0 ];
    self.var_8cadc5e84608a154 = 0;
    self.patrolpath = patrolpath;
    self.chasetarget = undefined;
    self.var_ee9de9d71096ace4 = 0;
    self.avoidanceengaged = 0;
    self.var_452a18d640ad9b18 = 0;
    self.detectioncontents = physics_createcontents( [ "physicscontents_clipshot", "physicscontents_trigger", "physicscontents_vehicleclip" ] );
    self.var_be9e450693caf0f5 = [ self ];
    
    foreach ( trigger in level.outofboundstriggers )
    {
        self.var_be9e450693caf0f5[ self.var_be9e450693caf0f5.size ] = trigger;
    }
    
    foreach ( rider in self.riders )
    {
        self.var_be9e450693caf0f5[ self.var_be9e450693caf0f5.size ] = rider;
    }
    
    triggers = getnoentvolumearray( "force_boat_on", #targetname );
    
    foreach ( trigger in triggers )
    {
        self.var_be9e450693caf0f5[ self.var_be9e450693caf0f5.size ] = trigger;
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0
// Checksum 0x881a8b41, Offset: 0x625
// Size: 0x1a4
function function_797b8e8ba7a13e3e()
{
    level.patrol_boat_ai = [];
    
    for ( idx = 1; idx <= 6 ; idx++ )
    {
        patrolpathname = function_99e6a1b1aaf9a40d( idx );
        
        if ( !patrolpathname )
        {
            continue;
        }
        
        var_a34344673aea891b = utility::getstruct( patrolpathname, "targetname" ).angles;
        patrolpaths = get_patrol_path_array( patrolpathname );
        vehicle = vehicle::spawn( %"hash_322db96456afe350", function_ed6b07a1b0e31dc1( patrolpaths[ 0 ], var_a34344673aea891b ) );
        vehicle.patrolpathid = idx;
        vehicle function_8a79a376b311eee7( undefined, "sat_ob_enemy_basic_soldier_long", undefined, "sat_ob_enemy_basic_soldier_long", "sat_ob_enemy_basic_soldier_lmg" );
        vehicle function_7c940924ed154432( patrolpaths );
        vehicle function_d9a5af880bb17076();
        vehicle thread function_7c56aea1554c34a9();
        
        /#
            vehicle thread function_e3dc36de2e5c703e();
        #/
        
        level.patrol_boat_ai[ level.patrol_boat_ai.size ] = vehicle;
    }
    
    var_ba0b6e1c1249ca44 = utility::getstruct( "infil_bay_path_non_patrolling_boat" );
    var_861e043b22aa6203 = vehicle::spawn( %"hash_322db96456afe350", function_ed6b07a1b0e31dc1( var_ba0b6e1c1249ca44.origin, var_ba0b6e1c1249ca44.angles ) );
    var_861e043b22aa6203 function_c21d39b1929f7cb1( -1 );
    var_861e043b22aa6203 function_8a79a376b311eee7( "undefined", undefined, undefined, "sat_ob_enemy_basic_soldier_long", "sat_ob_enemy_basic_soldier_lmg" );
    var_861e043b22aa6203 function_7c940924ed154432( undefined );
    level.patrol_boat_ai[ level.patrol_boat_ai.size ] = var_861e043b22aa6203;
    utility::array_thread( level.patrol_boat_ai, &addspotlight );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0x12a9e3ba, Offset: 0x7d1
// Size: 0x68
function private addspotlight()
{
    spotlight = utility::spawn_tag_origin( self gettagorigin( "tag_body" ), self gettagangles( "tag_body" ) );
    spotlight linkto( self, "tag_body" );
    spotlight forcenetfieldhighlod( 1 );
    spotlight show();
    self.spotlight = spotlight;
    waitframe();
    playfxontag( utility::getfx( "capricorn_boat_lights" ), spotlight, "tag_origin" );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1, eflags: 0x4
// Checksum 0xc2652505, Offset: 0x841
// Size: 0xb1
function private get_patrol_path_array( startstruct )
{
    patharray = [];
    var_6796e216a881305e = utility::getstruct( startstruct, "targetname" );
    
    if ( !isdefined( var_6796e216a881305e ) )
    {
        return;
    }
    
    patharray[ patharray.size ] = var_6796e216a881305e.origin;
    
    for ( currentstruct = var_6796e216a881305e; true ; currentstruct = nextstruct )
    {
        if ( !isdefined( currentstruct.target ) )
        {
            break;
        }
        
        nextstruct = utility::getstruct( currentstruct.target, "targetname" );
        
        if ( !isdefined( nextstruct ) )
        {
            break;
        }
        
        patharray[ patharray.size ] = nextstruct.origin;
    }
    
    return patharray;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1, eflags: 0x4
// Checksum 0xd786787b, Offset: 0x8fb
// Size: 0xc8
function private function_99e6a1b1aaf9a40d( index )
{
    var_cbaecc029b219c7d = [ 4, 6 ];
    
    foreach ( bannedroute in var_cbaecc029b219c7d )
    {
        if ( index == bannedroute )
        {
            return;
        }
    }
    
    patrolpathname = "infil_bay_path_";
    
    if ( index < 10 )
    {
        patrolpathname += "0";
    }
    
    patrolpathname = patrolpathname + string( index ) + "_start";
    return patrolpathname;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 2, eflags: 0x44 variadic
// Checksum 0x96995369, Offset: 0x9cc
// Size: 0xd2
function private function_8a79a376b311eee7( ... )
{
    if ( !isdefined( vararg[ 0 ] ) )
    {
        vararg[ 0 ] = "sat_ob_enemy_basic_grunt_long";
    }
    
    var_a843626593a3aa99 = vehicle_occupancy::function_8a8e1601e7e6610( self );
    
    for ( var_b1c29acb1d3cfb22 = 0; var_b1c29acb1d3cfb22 < var_a843626593a3aa99.size ; var_b1c29acb1d3cfb22++ )
    {
        if ( !vararg[ var_b1c29acb1d3cfb22 ] || !isaitypenamevalid( vararg[ var_b1c29acb1d3cfb22 ] ) )
        {
            continue;
        }
        
        rider = mp_agent::spawnnewagentaitype( vararg[ var_b1c29acb1d3cfb22 ], ( 0, 0, 0 ), ( 0, 0, 0 ), "team_hundred_ninety" );
        rider.var_a13bed1ac47e1b2c = 1;
        rider.script_startingposition = var_b1c29acb1d3cfb22;
        vehicle_aianim::guy_enter( rider );
        rider thread function_749c49dfb716a56a();
        rider thread function_2515635471dbadcf();
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0x51ee1751, Offset: 0xaa6
// Size: 0x5e
function private function_7c56aea1554c34a9()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isalive( self.driver ) )
        {
            self removecomponent( "p2p" );
            return;
        }
        
        function_b45fb67f156ef73e();
        
        if ( self.state == "patrol" )
        {
            function_3ccb9a085ab96241();
        }
        else
        {
            function_f3f8690e05a19bfb();
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0x87e7dc76, Offset: 0xb0c
// Size: 0x7f
function private function_d9a5af880bb17076()
{
    if ( self.state != "patrol" )
    {
        self.destinationnode = function_d775104b16415bc6();
        self.state = "patrol";
    }
    
    maxspeed = self vehicle_gettopspeedforward();
    var_c885ed4a66169c09 = utility::mph_to_ips( 14 );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", var_c885ed4a66169c09 );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", self.destinationnode );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0xdc4f0be3, Offset: 0xb93
// Size: 0xec
function private function_3ccb9a085ab96241()
{
    if ( self.avoidanceengaged )
    {
        self.destinationnode = self.patrolpath[ self.var_8cadc5e84608a154 ];
        self function_eb88c4e66edbc855( "p2p", "goalPoint", self.destinationnode );
    }
    
    var_c5b65aef08be008e = is_player_visible( 1100 );
    
    if ( var_c5b65aef08be008e )
    {
        function_d5b2f444279a3dde( var_c5b65aef08be008e );
    }
    
    if ( distance( self.origin, self.destinationnode ) < 500 )
    {
        self.var_ee9de9d71096ace4 = 0;
        self.var_8cadc5e84608a154 = ( self.var_8cadc5e84608a154 + 1 ) % self.patrolpath.size;
        self.destinationnode = self.patrolpath[ self.var_8cadc5e84608a154 ];
        self function_eb88c4e66edbc855( "p2p", "goalPoint", self.destinationnode );
    }
    
    /#
        function_b2ba1c5fe7765953();
    #/
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0x4aafeb8f, Offset: 0xc87
// Size: 0x110
function private function_d775104b16415bc6()
{
    closestnode = undefined;
    var_48becb931bf04e21 = 0;
    
    for ( index = 0; index < self.patrolpath.size ; index++ )
    {
        patrolnode = self.patrolpath[ index ];
        
        if ( !closestnode )
        {
            closestnode = patrolnode;
            self.var_8cadc5e84608a154 = index;
            continue;
        }
        
        var_7bf2fd8240cc058f = distance( self.origin, patrolnode );
        var_f544ab7403897006 = distance( closestnode, patrolnode );
        iscloser = var_7bf2fd8240cc058f < var_f544ab7403897006;
        var_73acc0d78ffcbdd0 = vectordot( anglestoforward( self.angles ), vectornormalize( patrolnode - self.origin ) ) > 0.5;
        
        if ( var_73acc0d78ffcbdd0 && iscloser )
        {
            var_48becb931bf04e21 = 1;
            closestnode = patrolnode;
            self.var_8cadc5e84608a154 = index;
            continue;
        }
        
        if ( !var_48becb931bf04e21 && iscloser )
        {
            closestnode = patrolnode;
            self.var_8cadc5e84608a154 = index;
        }
    }
    
    return closestnode;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1, eflags: 0x4
// Checksum 0xbf810414, Offset: 0xda0
// Size: 0x119
function private is_player_visible( detection_range = 1100 )
{
    foreach ( player in level.players )
    {
        if ( player.notarget )
        {
            continue;
        }
        
        if ( withinfov2d( self.origin, self.angles, player.origin, cos( 60 ) ) && distance( self.origin, player.origin ) < detection_range )
        {
            player_found = trace::ray_trace_passed( player geteye(), self.origin, self.var_be9e450693caf0f5, self.detectioncontents );
            
            if ( player_found )
            {
                return player;
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1, eflags: 0x4
// Checksum 0x947ed96a, Offset: 0xec2
// Size: 0x7b
function private function_d5b2f444279a3dde( player )
{
    self.state = "chase";
    self.chasetarget = player.vehicle ? player.vehicle : player;
    self.destinationnode = player.origin;
    self.var_ee9de9d71096ace4 = 1;
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( self vehicle_gettopspeedforward() ) );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0xb21133e3, Offset: 0xf45
// Size: 0x189
function private function_f3f8690e05a19bfb()
{
    var_fba7c4576ce9b815 = self.var_452a18d640ad9b18 < gettime() && distance( self.origin, self.destinationnode ) > 3000;
    var_c82578fbdab54945 = boat_has_target();
    
    if ( var_fba7c4576ce9b815 || !var_c82578fbdab54945 )
    {
        self.var_37f1486860157037 = undefined;
        self.destinationoffset = undefined;
        function_d9a5af880bb17076();
        return;
    }
    
    function_3a701cd14bdc7e18();
    
    if ( !self.var_37f1486860157037 )
    {
        self.destinationoffset = ( 0, 0, 0 );
        self.var_37f1486860157037 = gettime() + 1000;
    }
    else if ( self.var_37f1486860157037 < gettime() )
    {
        self.destinationoffset = function_67970a7a573974f4();
        self.var_37f1486860157037 = gettime();
    }
    
    self.destinationnode = self.chasetarget.origin + self.destinationoffset;
    
    /#
        if ( getdvarint( @"hash_ea04b56bf0ddb214" ) == 1 )
        {
            sphere( self.destinationnode, 25, ( 1, 0, 0 ) );
            line( self.destinationnode, self.chasetarget.origin );
        }
    #/
    
    self function_eb88c4e66edbc855( "p2p", "goalPoint", self.destinationnode );
    self function_eb88c4e66edbc855( "p2p", "goalAngles", self.angles );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0xc3f9a8d1, Offset: 0x10d6
// Size: 0x59
function private function_67970a7a573974f4()
{
    var_a8f353d2ccca9d18 = vectornormalize2( self.origin - self.chasetarget.origin );
    endpoint = self.chasetarget.origin + var_a8f353d2ccca9d18 * 300;
    return var_a8f353d2ccca9d18 * 300;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0x98f40273, Offset: 0x1138
// Size: 0xe3
function private boat_has_target()
{
    if ( !isdefined( self.chasetarget ) )
    {
        return 0;
    }
    
    if ( self.chasetarget vehicle::is_vehicle() )
    {
        seatids = vehicle_occupancy::function_8a8e1601e7e6610( self.chasetarget );
        
        if ( !isdefined( seatids ) )
        {
            return 0;
        }
        
        foreach ( seatid in seatids )
        {
            player = vehicle_occupancy::get_seat_occupant( self.chasetarget, seatid, 0 );
            
            if ( isdefined( player ) )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    return isalive( self.chasetarget );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0
// Checksum 0xe8ae940e, Offset: 0x1224
// Size: 0x1c2
function function_b45fb67f156ef73e()
{
    self.avoidanceengaged = 0;
    
    if ( !self.var_ee9de9d71096ace4 )
    {
        return;
    }
    
    var_3aeade417a4fba2f = self gettagorigin( "tag_tire_right_01" );
    var_f4a5662829a594f2 = self gettagorigin( "tag_tire_left_01" );
    var_d1732ee29fa08731 = var_3aeade417a4fba2f + vectornormalize2( anglestoforward( self.angles ) ) * 1000;
    var_d17338e29fa09d2f = var_f4a5662829a594f2 + vectornormalize2( anglestoforward( self.angles ) ) * 1000;
    var_839ee9241de8e9f3 = trace::sphere_trace( var_3aeade417a4fba2f, var_d1732ee29fa08731, 75, self.var_be9e450693caf0f5, self.detectioncontents );
    tracel = trace::sphere_trace( var_f4a5662829a594f2, var_d17338e29fa09d2f, 75, self.var_be9e450693caf0f5, self.detectioncontents );
    traceresult = spawnstruct();
    traceresult.tracerfraction = 1;
    traceresult.var_d2f33b387948471b = 1;
    traceresult.vehicle = undefined;
    
    if ( var_839ee9241de8e9f3 && var_839ee9241de8e9f3[ "hittype" ] != "hittype_none" )
    {
        traceresult.tracerfraction = var_839ee9241de8e9f3[ "fraction" ];
        
        if ( var_839ee9241de8e9f3[ "entity" ] && var_839ee9241de8e9f3[ "entity" ] vehicle::is_vehicle() )
        {
            traceresult.vehicle = var_839ee9241de8e9f3[ "entity" ];
        }
    }
    
    if ( tracel && tracel[ "hittype" ] != "hittype_none" )
    {
        traceresult.var_d2f33b387948471b = tracel[ "fraction" ];
        
        if ( tracel[ "entity" ] && tracel[ "entity" ] vehicle::is_vehicle() )
        {
            traceresult.vehicle = tracel[ "entity" ];
        }
    }
    
    function_e354f1c4c3a9ffdc( traceresult );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1
// Checksum 0x1ad66650, Offset: 0x13ee
// Size: 0xf0
function function_e354f1c4c3a9ffdc( tracedata )
{
    if ( tracedata.var_d2f33b387948471b == 1 && tracedata.tracerfraction == 1 )
    {
        return;
    }
    
    self.avoidanceengaged = 1;
    
    if ( tracedata.vehicle )
    {
        function_614886bb7a43ad38( tracedata );
    }
    else
    {
        var_17f67da927f056d9 = tracedata.var_d2f33b387948471b <= tracedata.tracerfraction;
        var_1b0ee4308a61a961 = var_17f67da927f056d9 ? tracedata.var_d2f33b387948471b : tracedata.tracerfraction;
        var_d2f3eeab40166793 = math::remap( var_1b0ee4308a61a961, 0, 1, 75, 15 );
        var_73f7120e062f73fe = var_17f67da927f056d9 ? var_d2f3eeab40166793 * -1 : var_d2f3eeab40166793;
        self function_eb88c4e66edbc855( "p2p", "goalPoint", function_f6076023ccdb8714( var_73f7120e062f73fe ) );
    }
    
    wait 0.5;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1
// Checksum 0xae765fc5, Offset: 0x14e6
// Size: 0x23f
function function_614886bb7a43ad38( tracedata )
{
    var_85cc80849bcb5388 = tracedata.vehicle;
    
    if ( var_85cc80849bcb5388 && var_85cc80849bcb5388 vehicle_getspeed() < 5 )
    {
        tracerangle = self.angles + ( 0, 45, 0 );
        var_7cd013fd7e1fa950 = self.angles - ( 0, 45, 0 );
        var_d1732ee29fa08731 = self.origin + vectornormalize2( anglestoforward( tracerangle ) ) * 1000;
        var_d17338e29fa09d2f = self.origin + vectornormalize2( anglestoforward( var_7cd013fd7e1fa950 ) ) * 1000;
        var_839ee9241de8e9f3 = trace::sphere_trace( self.origin, var_d1732ee29fa08731, 75, self.var_be9e450693caf0f5, self.detectioncontents );
        tracel = trace::sphere_trace( self.origin, var_d17338e29fa09d2f, 75, self.var_be9e450693caf0f5, self.detectioncontents );
        
        if ( var_839ee9241de8e9f3 && var_839ee9241de8e9f3[ "fraction" ] == 1 )
        {
            self function_eb88c4e66edbc855( "p2p", "goalPoint", var_d1732ee29fa08731 );
        }
        else
        {
            self function_eb88c4e66edbc855( "p2p", "goalPoint", var_d17338e29fa09d2f );
        }
        
        wait 0.5;
        return;
    }
    
    if ( tracedata.var_d2f33b387948471b < 0.2 || tracedata.tracerfraction < 0.2 )
    {
        self function_eb88c4e66edbc855( "p2p", "manualSpeed", 0 );
        wait 0.5;
        self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( self vehicle_gettopspeedforward() ) );
        return;
    }
    
    to = vectornormalize( var_85cc80849bcb5388.origin + anglestoforward( var_85cc80849bcb5388.angles ) * 100 );
    dotproduct = vectordot( to, anglestoforward( self.angles ) );
    var_73f7120e062f73fe = math::remap( abs( dotproduct ), -1, 1, 45, -45 );
    self function_eb88c4e66edbc855( "p2p", "goalPoint", function_f6076023ccdb8714( var_73f7120e062f73fe ) );
    wait 0.5;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0xec782606, Offset: 0x172d
// Size: 0x73
function private function_fe6d5c7fec35a9b2()
{
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( 14 ) );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 50 );
    self function_eb88c4e66edbc855( "p2p", "reverseForBehindGoal", 0 );
    self function_eb88c4e66edbc855( "p2p", "stuckTime", 1 );
    self function_eb88c4e66edbc855( "p2p", "stuckForcedReverseTime", 2 );
    self function_eb88c4e66edbc855( "p2p", "reverseGasWhileStuck", 1 );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0xf98a9130, Offset: 0x17a8
// Size: 0x139
function private function_f0fc3a66151150e9()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, direction_vec, damagelocation, smeansofdeath, modelname, tagname, partname, dflags, objweapon );
        
        if ( eattacker.classname == "worldspawn" )
        {
            continue;
        }
        
        foreach ( player in level.players )
        {
            if ( eattacker == player )
            {
                self.var_452a18d640ad9b18 = gettime() + 7000;
                function_d5b2f444279a3dde( player );
                thread function_baac36a11de343e();
                break;
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0xe0b95947, Offset: 0x18e9
// Size: 0x8c
function private function_3a701cd14bdc7e18()
{
    current_distance_apart = distance2d( self.origin, self.chasetarget.origin );
    
    if ( current_distance_apart < 1500 )
    {
        top_speed = self vehicle_gettopspeedforward();
        frac = mapfloat( 500, 1500, 0, 1, current_distance_apart );
        adjust_speed = frac * top_speed;
        self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( adjust_speed ) );
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1, eflags: 0x4
// Checksum 0xa4ad6c0, Offset: 0x197d
// Size: 0x75
function private function_f6076023ccdb8714( var_73f7120e062f73fe )
{
    var_34280a7c75a10f3a = math::wrap( 0, 359, self.angles[ 1 ] + var_73f7120e062f73fe );
    avoidanceangle = ( self.angles[ 0 ], var_34280a7c75a10f3a, self.angles[ 2 ] );
    resultpoint = self.origin + anglestoforward( avoidanceangle ) * 1000;
    return resultpoint;
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0xc0ef909a, Offset: 0x19fb
// Size: 0x90
function private function_749c49dfb716a56a()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        
        if ( self.enemy )
        {
            if ( self.ridingvehicle.state == "patrol" )
            {
                self.ridingvehicle.var_452a18d640ad9b18 = gettime() + 7000;
                self.ridingvehicle function_d5b2f444279a3dde( self.enemy );
            }
            
            self.ridingvehicle thread function_baac36a11de343e();
        }
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0x4765a223, Offset: 0x1a93
// Size: 0xa8
function private function_2515635471dbadcf()
{
    self endon( #"death" );
    thread ai_monitor_death( self.ridingvehicle );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( attacker )
        {
            if ( self.ridingvehicle.state == "patrol" )
            {
                self.ridingvehicle.var_452a18d640ad9b18 = gettime() + 7000;
                self.ridingvehicle function_d5b2f444279a3dde( attacker );
            }
            
            self.ridingvehicle thread function_baac36a11de343e();
        }
    }
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 1, eflags: 0x4
// Checksum 0xbeb865a0, Offset: 0x1b43
// Size: 0x22
function private ai_monitor_death( vehicle )
{
    self waittill( #"death" );
    vehicle function_baac36a11de343e();
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0x4
// Checksum 0x87432d4, Offset: 0x1b6d
// Size: 0x3c
function private function_7e4dcdea360587a7()
{
    self endon( #"death" );
    self function_2ef9eb3349906d00( 100000 );
    self function_630eac6fd6900a61( "sat_ob_combat_capricorn_high_vis", 1 );
    self.baseaccuracy = 1000;
    waitframe();
    self function_2ef9eb3349906d00( 3000 );
}

// Namespace mp_sat_ob_capricorn_patrol_boat_ai
// Params 0, eflags: 0xc
// Checksum 0x83272a08, Offset: 0x1bb1
// Size: 0xcd
function private function_baac36a11de343e()
{
    self notify( #"hash_9223d9e6d1aff03e" );
    self endon( #"hash_9223d9e6d1aff03e" );
    self endon( #"death" );
    seatids = vehicle_occupancy::function_8a8e1601e7e6610( self );
    
    if ( !isdefined( seatids ) )
    {
        return;
    }
    
    foreach ( seatid in seatids )
    {
        agent = vehicle_ai::function_b74a31eb8af242a0( self, seatid );
        
        if ( isagent( agent ) )
        {
            agent thread function_7e4dcdea360587a7();
        }
    }
}

/#

    // Namespace mp_sat_ob_capricorn_patrol_boat_ai
    // Params 0, eflags: 0x4
    // Checksum 0x7b124fbd, Offset: 0x1c86
    // Size: 0xfb, Type: dev
    function private function_e3dc36de2e5c703e()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"hash_5260f7bebee25f57" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_ea04b56bf0ddb214" ) == 1 )
            {
                if ( self.avoidanceengaged )
                {
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:x24>" );
                }
                else if ( self.state == "<dev string:x47>" )
                {
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:x4e>" );
                }
                else
                {
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:x61>" );
                }
                
                currentspeed = self vehicle_getspeed();
                print3d( self.origin + ( 0, 0, 75 ), "<dev string:x74>" + currentspeed + "<dev string:x7c>" );
            }
            
            waitframe();
        }
    }

    // Namespace mp_sat_ob_capricorn_patrol_boat_ai
    // Params 0, eflags: 0x4
    // Checksum 0xd61c2f17, Offset: 0x1d89
    // Size: 0x166, Type: dev
    function private function_b2ba1c5fe7765953()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"hash_5260f7bebee25f57" );
        
        if ( getdvarint( @"hash_ea04b56bf0ddb214" ) == 1 && self.state == "<dev string:x47>" )
        {
            for ( patrolidx = 0; patrolidx < self.patrolpath.size ; patrolidx++ )
            {
                previousindex = int( mod( patrolidx - 1 + self.patrolpath.size, self.patrolpath.size ) );
                
                if ( patrolidx == self.var_8cadc5e84608a154 )
                {
                    sphere( self.patrolpath[ patrolidx ], 25, ( 0, 1, 0 ) );
                    line( self.patrolpath[ previousindex ], self.patrolpath[ patrolidx ], ( 0, 1, 0 ) );
                }
                else
                {
                    sphere( self.patrolpath[ patrolidx ], 25 );
                    line( self.patrolpath[ previousindex ], self.patrolpath[ patrolidx ] );
                }
                
                print3d( self.patrolpath[ patrolidx ] + ( 0, 0, 30 ), "<dev string:x81>" + self.patrolpathid + "<dev string:x88>" + patrolidx, ( 1, 1, 1 ), 1, 3 );
            }
        }
    }

#/
