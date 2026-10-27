// scripts\common\vehicle_roads.gsc  (hash_403080f77c738368.gscc) (size: 43841 Bytes / 0xab41 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4099194e (1083775310)
// size ...... 43841 (0xab41)
// includes .. 8   (offset: 0xa3d1)
// strings ... 20  (offset: 0xa411)
// dev strs .. 114 (offset: 0xa539)
// exports ... 80  (offset: 0x7a19)
// cseg ...... 0x19b + 0x787e (0x7a19)
// imports ... 207 (offset: 0x8699)
// animtree1 . 0   (offset: 0xab41)
// animtree2 . 0   (offset: 0xab41)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_tracking;

#namespace vehicle_roads;

// Namespace vehicle_roads
// Params 18
// Checksum 0x4745c631, Offset: 0x1b9
// Size: 0x1a5
function function_b5bd79b51773c046( usep2p = 1, var_d2b2b98d77c9c0 = 0, checkStuck = 0, var_50e5e30289743ab3 = 31, brakeAtGoal = 1, autonormal = 1, brakeOnGoalGasbrake = 1, goalThreshold = 100, throttleSpeedClose = 0, throttleSpeedThreshold = 1, var_f04cadb28ee6016d = 1, throttleSpeedFarBelow = 0, throttleSpeedFarAbove = 0, gasToStopMovement = 0.9, steeringMultiplier = 1, stepradius, stepSpeedFactor, useManualSpeed )
{
    if ( var_d2b2b98d77c9c0 )
    {
        if ( !self hascomponent( "animator" ) )
        {
            self addcomponent( "animator" );
        }
    }
    
    if ( usep2p )
    {
        vehicle_paths::function_53e592e2d38c05ca( checkStuck, brakeAtGoal, autonormal, brakeOnGoalGasbrake, goalThreshold, throttleSpeedClose, throttleSpeedThreshold, var_f04cadb28ee6016d, throttleSpeedFarBelow, throttleSpeedFarAbove, gasToStopMovement, steeringMultiplier );
        self setconfigvalue( "p2p", "goalPoint", self.origin );
        vehicle_paths::vehicle_init_path_radiant();
    }
    else
    {
        vehicle_paths::function_6080e3e7e4316b48( 1, 1, var_50e5e30289743ab3 );
    }
    
    self.stopping = 0;
    self vehphys_parkingbrake( 0 );
}

// Namespace vehicle_roads
// Params 12
// Checksum 0xac437b01, Offset: 0x366
// Size: 0x5e3
function function_c64bd96044937781( var_faaa47fc6aa1f40a, speed = "medium", useroads = 1, var_c3e9f4759ee0b1fe = 1, var_de2ce60209cec7b0 = 1, var_12e420084a68860e, amortize = 1, vehiclenavmeshlayer = undefined, var_128160ef87ef26fd = 200, debugdraw = 0, var_16e78e48ea504d19, var_4489784c479cc318 = 0 )
{
    result = 0;
    
    if ( !debugdraw )
    {
        debugdraw = getdvarint( @"hash_a2ae160010b585e6", 0 ) == 1;
    }
    
    if ( !self || !vehicle::is_vehicle() )
    {
        assertmsg( "<dev string:x24>" );
        return result;
    }
    
    if ( !isdefined( vehiclenavmeshlayer ) )
    {
        vehiclenavmeshlayer = level.vehiclenavmeshlayer ?? "vehicle_large";
    }
    
    goalorigin = undefined;
    goalvehiclenode = undefined;
    
    if ( !isvector( var_faaa47fc6aa1f40a ) )
    {
        if ( !isdefined( var_faaa47fc6aa1f40a.origin ) )
        {
            assertmsg( "<dev string:x50>" );
            return result;
        }
        
        goalvehiclenode = var_faaa47fc6aa1f40a;
        goalorigin = var_faaa47fc6aa1f40a.origin;
    }
    else
    {
        navgoalorigin = getclosestpointonnavmesh( var_faaa47fc6aa1f40a, vehiclenavmeshlayer );
        
        if ( !navgoalorigin )
        {
            assertmsg( "<dev string:x86>" + goalorigin );
            return result;
        }
        
        goalorigin = navgoalorigin;
    }
    
    result = 1;
    function_1a4d9a27919256f4( vehiclenavmeshlayer );
    function_e224f7f55a520c5a( speed );
    self.var_75ea1b9acbb56f2a = var_de2ce60209cec7b0;
    var_8c7acf989e28e271 = { #isoffroad:1, #origin:goalorigin };
    
    if ( !useroads || !function_98191bf615bc9f9d() )
    {
        self.attachedpath = var_8c7acf989e28e271;
        self.var_26b28c4d11c39de = undefined;
        self.var_aa9420e9c34ecebd = undefined;
        return result;
    }
    
    if ( distance( self.origin, goalorigin ) < 800 )
    {
        roadnetworkpath = [];
        self.var_26b28c4d11c39de = undefined;
        self.var_aa9420e9c34ecebd = undefined;
    }
    else
    {
        [ roadnetworkpath, beststartnode, bestgoalnode ] = function_3fd54488ab0c7c72( self.origin, var_faaa47fc6aa1f40a, self.var_94e9dec930dce0a8, anglestoforward( self.angles ), amortize, undefined, var_128160ef87ef26fd, undefined, debugdraw, var_16e78e48ea504d19 );
        
        if ( !roadnetworkpath )
        {
            print( "<dev string:xd6>" + self.origin + "<dev string:x10e>" + goalorigin );
            roadnetworkpath = [];
            self.var_26b28c4d11c39de = undefined;
            self.var_aa9420e9c34ecebd = undefined;
        }
        else
        {
            self.var_26b28c4d11c39de = beststartnode;
            self.var_aa9420e9c34ecebd = bestgoalnode;
        }
    }
    
    var_57de6de536cd690d = undefined;
    
    if ( self.var_26b28c4d11c39de )
    {
        var_f7fc8e68cde5d150 = distance2d( self.origin, self.var_26b28c4d11c39de.origin );
        
        /#
            if ( debugdraw )
            {
                print3d( self.var_26b28c4d11c39de.origin, "<dev string:x114>" + var_f7fc8e68cde5d150, ( 1, 1, 1 ), 1, 1, 600 );
            }
        #/
        
        var_20f18a5cb8d966b0 = undefined;
        
        if ( self.var_26b28c4d11c39de.target )
        {
            var_20f18a5cb8d966b0 = vectornormalize2( function_d5de32e196353afe( self.var_26b28c4d11c39de.target ).origin - self.var_26b28c4d11c39de.origin );
            self.isonroad = var_f7fc8e68cde5d150 < 500 && math::anglebetweenvectors( var_20f18a5cb8d966b0, anglestoforward( self.angles ) ) < 20;
        }
        
        if ( !self.isonroad )
        {
            var_1964fd20107b2bc9 = self.var_26b28c4d11c39de.origin;
            
            if ( getdvarint( @"hash_a8c49df509f1d108", 1 ) == 1 )
            {
                [ var_1964fd20107b2bc9, roadnetworkpath ] = function_2e00fd22e410ab01( self.var_26b28c4d11c39de, roadnetworkpath, var_4489784c479cc318 );
            }
            
            var_57de6de536cd690d = { #target:1, #isoffroad:1, #forward:var_20f18a5cb8d966b0, #origin:var_1964fd20107b2bc9 };
            
            /#
                if ( debugdraw )
                {
                    print3d( self.origin, "<dev string:x140>", ( 1, 1, 1 ), 1, 600 );
                }
            #/
        }
        
        /#
            if ( debugdraw && self.var_aa9420e9c34ecebd )
            {
                goalcolor = ( 0, 1, 0 );
                sphere( goalorigin, 100, goalcolor, 0, 600 );
                line( goalorigin, self.var_aa9420e9c34ecebd.origin, goalcolor, 1, 0, 600 );
            }
        #/
    }
    
    if ( var_57de6de536cd690d )
    {
        arrayinsert( roadnetworkpath, var_57de6de536cd690d, 0 );
    }
    
    if ( !isdefined( goalvehiclenode ) && var_c3e9f4759ee0b1fe || roadnetworkpath.size == 0 )
    {
        roadnetworkpath[ roadnetworkpath.size ] = var_8c7acf989e28e271;
    }
    
    function_60e8cec67a1f4910( roadnetworkpath );
    
    /#
        if ( debugdraw )
        {
            print3d( self.origin, "<dev string:x16f>", ( 1, 1, 1 ), 1, 600 );
            print3d( roadnetworkpath[ roadnetworkpath.size - 1 ].origin, "<dev string:x19c>", ( 1, 1, 1 ), 1, 600 );
            thread function_ccc37c74c8357da7( roadnetworkpath, self.var_26b28c4d11c39de.targetname, self.var_aa9420e9c34ecebd.targetname );
        }
    #/
    
    return result;
}

// Namespace vehicle_roads
// Params 1
// Checksum 0xbbb8de8e, Offset: 0x952
// Size: 0x48
function function_60e8cec67a1f4910( roadpath )
{
    assert( function_98191bf615bc9f9d() > 0, "<dev string:x1ba>" );
    self setconfigvalue( "path", "resume", 1 );
    self.roadpath = roadpath;
    self.attachedpath = roadpath[ 0 ];
}

// Namespace vehicle_roads
// Params 1, eflags: 0x4
// Checksum 0x51800578, Offset: 0x9a2
// Size: 0x94
function private function_e224f7f55a520c5a( speed )
{
    if ( isstring( speed ) )
    {
        switch ( speed )
        {
            case #"hash_e8f0758a10ec7618":
                speed = 10;
                break;
            case #"hash_c71b112fe04823d6":
                speed = 20;
                break;
            case #"hash_9c8ed152deb360f":
                speed = 35;
                break;
            case #"hash_289ae26c1f0ee7f9":
                speed = 45;
                break;
            default:
                speed = 20;
                break;
        }
    }
    
    vehicle::vehicle_set_speed( speed, 12, 6 );
    utility::ent_flag_set( "vehicle_paths_scripted_speed" );
}

// Namespace vehicle_roads
// Params 1
// Checksum 0xeb7d4c7, Offset: 0xa3e
// Size: 0x3a
function function_1a4d9a27919256f4( navmeshlayer = level.vehiclenavmeshlayer ?? "vehicle_large" )
{
    self.usenavmesh = 1;
    self.navmeshlayer = navmeshlayer;
}

// Namespace vehicle_roads
// Params 4, eflags: 0x4
// Checksum 0x403e2321, Offset: 0xa80
// Size: 0x712
function private function_2e00fd22e410ab01( var_26b28c4d11c39de, roadnetworkpath, var_4489784c479cc318 = 0, debugdraw = 0 )
{
    if ( !debugdraw )
    {
        debugdraw = getdvarint( @"hash_e4e144639755d428", 0 ) == 1;
    }
    
    var_1964fd20107b2bc9 = var_26b28c4d11c39de.origin;
    var_9b4a3fbbb093b8c9 = function_b38997095da36802( var_26b28c4d11c39de );
    var_547ccc1fc3f69de4 = var_26b28c4d11c39de;
    
    if ( var_4489784c479cc318 && self.var_aa9420e9c34ecebd )
    {
        var_e32fc61cf193ced5 = function_b38997095da36802( self.var_aa9420e9c34ecebd );
        
        if ( var_e32fc61cf193ced5 == var_9b4a3fbbb093b8c9 )
        {
            var_547ccc1fc3f69de4 = self.var_aa9420e9c34ecebd;
        }
        else
        {
            var_547ccc1fc3f69de4 = function_57751e07f57fd60b( var_9b4a3fbbb093b8c9.targetname );
        }
    }
    
    if ( !var_4489784c479cc318 )
    {
        if ( var_9b4a3fbbb093b8c9 == var_26b28c4d11c39de )
        {
            return [ var_1964fd20107b2bc9, roadnetworkpath ];
        }
        
        assert( !( var_26b28c4d11c39de.spawnflags & 1 ) );
    }
    
    roaddirection = ( 0, 0, 0 );
    
    if ( var_9b4a3fbbb093b8c9 != var_26b28c4d11c39de )
    {
        while ( var_9b4a3fbbb093b8c9.target != var_26b28c4d11c39de.targetname )
        {
            var_9b4a3fbbb093b8c9 = function_d5de32e196353afe( var_9b4a3fbbb093b8c9.target );
        }
        
        roaddirection = vectornormalize2( var_26b28c4d11c39de.origin - var_9b4a3fbbb093b8c9.origin );
    }
    else if ( var_9b4a3fbbb093b8c9.target )
    {
        roaddirection = vectornormalize2( function_d5de32e196353afe( var_9b4a3fbbb093b8c9.target ).origin - var_9b4a3fbbb093b8c9.origin );
    }
    
    splinelength = 0;
    
    for ( splineendnode = var_9b4a3fbbb093b8c9; splineendnode.targetname != var_547ccc1fc3f69de4.targetname && splinelength < getdvarint( @"hash_a33e1809857824fc", 2000 ) ; splineendnode = nextnode )
    {
        nextnode = function_d5de32e196353afe( splineendnode.target );
        splinelength += distance( splineendnode.origin, nextnode.origin );
    }
    
    splinepoints = function_6e66ddd10a3001b8( 0.5, var_9b4a3fbbb093b8c9.index, splineendnode.index, 1 );
    
    if ( var_4489784c479cc318 )
    {
        splinepoints = utility::array_slice( splinepoints, 0, getdvarint( @"hash_64b3e631713432eb", 50 ) );
    }
    
    var_f7fc8e68cde5d150 = distance2d( self.origin, var_26b28c4d11c39de.origin );
    assert( var_f7fc8e68cde5d150 > 0 );
    vehicleheading = anglestoforward( self.angles * ( 0, 1, 0 ) );
    
    if ( var_4489784c479cc318 )
    {
        vehiclespeed = vehicle::function_602b37e1ee43b6b3();
        var_ae649a34db9abe7f = clamp( ( vehiclespeed - getdvarint( @"hash_cf8d41f77f453fb", 15 ) ) / ( getdvarint( @"hash_cd5ca1f77cdf645", 55 ) - getdvarint( @"hash_cf8d41f77f453fb", 15 ) ), 0, 1 ) * getdvarfloat( @"hash_a899bc1623c757fa", 3 );
        vehicleheading = vectornormalize2( vehicleheading + var_ae649a34db9abe7f * roaddirection );
    }
    
    if ( length( roaddirection ) == 0 || length( vehicleheading ) == 0 )
    {
        return [ var_1964fd20107b2bc9, roadnetworkpath ];
    }
    
    var_7adf3b99c5984d4c = vectornormalize2( var_26b28c4d11c39de.origin - self.origin );
    var_b211e3b81fcf0a40 = math::anglebetweenvectors( var_7adf3b99c5984d4c, vehicleheading );
    bestscore = function_c5c645ac1ea9649e( roaddirection, vehicleheading, var_b211e3b81fcf0a40, debugdraw && splinepoints.size >= 2, var_26b28c4d11c39de.origin );
    bestindex = undefined;
    
    if ( splinepoints.size >= 2 )
    {
        /#
            if ( debugdraw )
            {
                sphere( var_26b28c4d11c39de.origin, 50, ( 1, 1, 0 ), 0, 600 );
            }
        #/
        
        lookaheaddistance = 0;
        var_54534f04f8d3a18c = undefined;
        
        for ( index = 0; index < splinepoints.size - 1 ; index++ )
        {
            var_7adf3b99c5984d4c = vectornormalize2( splinepoints[ index ].origin - self.origin );
            var_b211e3b81fcf0a40 = math::anglebetweenvectors( var_7adf3b99c5984d4c, vehicleheading );
            
            if ( var_b211e3b81fcf0a40 >= 90 )
            {
                /#
                    if ( debugdraw )
                    {
                        line( splinepoints[ index ].origin, splinepoints[ index ].origin + ( 0, 0, 150 ), ( 1, 0, 0 ), 1, 0, 600 );
                    }
                #/
                
                continue;
            }
            
            var_571f83edfb9b6f0 = vectornormalize2( splinepoints[ index + 1 ].origin - splinepoints[ index ].origin );
            totalscore = function_c5c645ac1ea9649e( var_571f83edfb9b6f0, vehicleheading, var_b211e3b81fcf0a40, debugdraw, splinepoints[ index ].origin );
            
            /#
                if ( debugdraw )
                {
                    line( splinepoints[ index ].origin, splinepoints[ index ].origin + ( 0, 0, 300 ), ( 1, 1, 0 ), 1, 0, 600 );
                }
            #/
            
            if ( totalscore > bestscore )
            {
                bestscore = totalscore;
                bestindex = index;
            }
            
            if ( var_4489784c479cc318 && var_54534f04f8d3a18c )
            {
                lookaheaddistance += distance( splinepoints[ index ].origin, var_54534f04f8d3a18c.origin );
                
                if ( lookaheaddistance > getdvarint( @"hash_86816feb286d5bf8", 1500 ) )
                {
                    break;
                }
            }
            
            var_54534f04f8d3a18c = splinepoints[ index ];
        }
    }
    
    if ( bestindex )
    {
        /#
            if ( debugdraw )
            {
                line( splinepoints[ bestindex ].origin, splinepoints[ bestindex ].origin + ( 15, 15, 1000 ), ( 0, 1, 0 ), 1, 0, 600 );
            }
        #/
        
        var_1964fd20107b2bc9 = splinepoints[ bestindex ].origin;
        
        if ( var_4489784c479cc318 )
        {
            targetnode = function_d5de32e196353afe( getvehiclenode( splinepoints[ bestindex ].nodeindex ).target );
            
            if ( targetnode == function_57751e07f57fd60b( roadnetworkpath[ 0 ] ) || roadnetworkpath.size > 1 && targetnode == roadnetworkpath[ 1 ] )
            {
                if ( roadnetworkpath.size > 1 )
                {
                    self.var_26b28c4d11c39de = roadnetworkpath[ 1 ];
                    roadnetworkpath = utility::array_slice( roadnetworkpath, 1 );
                }
            }
            else if ( targetnode == self.var_aa9420e9c34ecebd )
            {
                self.var_26b28c4d11c39de = undefined;
                self.var_aa9420e9c34ecebd = undefined;
                roadnetworkpath = [];
            }
            else
            {
                self.var_26b28c4d11c39de = targetnode;
            }
        }
    }
    else if ( debugdraw )
    {
        /#
            line( var_26b28c4d11c39de.origin, var_26b28c4d11c39de.origin + ( -15, -15, 1000 ), ( 0, 1, 0 ), 1, 0, 600 );
        #/
    }
    
    return [ var_1964fd20107b2bc9, roadnetworkpath ];
}

// Namespace vehicle_roads
// Params 5, eflags: 0x4
// Checksum 0xe7a6e39f, Offset: 0x119b
// Size: 0xbd
function private function_c5c645ac1ea9649e( roaddirection, vehicleheading, var_b211e3b81fcf0a40, debugdraw, debugorigin )
{
    var_47c1f9f70243dd9e = math::anglebetweenvectors( roaddirection, vehicleheading );
    var_bec6fe5473f6f2a4 = 1 - clamp( var_b211e3b81fcf0a40 / 90, 0, 1 );
    var_59763da2e4dd8d17 = 1 - clamp( var_47c1f9f70243dd9e / 90, 0, 1 );
    
    /#
        if ( debugdraw )
        {
            print3d( debugorigin + ( 0, 0, 300 ), "<dev string:x1ec>" + var_bec6fe5473f6f2a4 + "<dev string:x1ed>" + var_59763da2e4dd8d17, ( 1, 1, 1 ), 1, 1, 600 );
        }
    #/
    
    return var_bec6fe5473f6f2a4 + var_59763da2e4dd8d17;
}

// Namespace vehicle_roads
// Params 12
// Checksum 0x9aec2e7e, Offset: 0x1261
// Size: 0x63a
function function_aa57f55330533b75( goalent, speed = "medium", useroads = 1, var_c3e9f4759ee0b1fe = 1, var_de2ce60209cec7b0 = 1, var_12e420084a68860e = undefined, amortize = 1, vehiclenavmeshlayer = undefined, var_128160ef87ef26fd = 200, debugdraw = 0, var_16e78e48ea504d19, var_4489784c479cc318 = 0 )
{
    if ( !self || !vehicle::is_vehicle() )
    {
        assertmsg( "<dev string:x24>" );
        return 0;
    }
    
    if ( !isent( goalent ) )
    {
        assertmsg( "<dev string:x1ef>" );
        return 0;
    }
    
    function_1a4d9a27919256f4( vehiclenavmeshlayer );
    function_e224f7f55a520c5a( speed );
    self.var_75ea1b9acbb56f2a = var_de2ce60209cec7b0;
    result = undefined;
    var_faaa47fc6aa1f40a = goalent.origin;
    navgoalorigin = getclosestpointonnavmesh( var_faaa47fc6aa1f40a, vehiclenavmeshlayer );
    var_3fedb43997e11aee = distance( self.origin, goalent.origin );
    vehiclespeed = self vehicle_getspeed();
    
    if ( var_3fedb43997e11aee >= getdvarfloat( @"hash_b520e564e2c885dd", 600 ) && useroads && amortize && vehiclespeed != 0 && abs( vehicle::function_602b37e1ee43b6b3() - vehiclespeed ) < getdvarfloat( @"hash_96c521da7b76b715", 10 ) )
    {
        var_b292656ead795c0e = [];
        
        if ( !isdefined( level.var_2d03ea9572c3657c ) )
        {
            level.var_2d03ea9572c3657c = getdvarfloat( @"hash_671d6ceef38a2d6d", 1000 );
        }
        
        goalentroads = goalent function_55d429d26d18e744( 200 );
        var_faaa47fc6aa1f40a = goalent.origin;
        navgoalorigin = getclosestpointonnavmesh( var_faaa47fc6aa1f40a, vehiclenavmeshlayer );
        var_3fedb43997e11aee = distance( self.origin, goalent.origin );
        
        if ( isarray( self.roadpath ) && isnumber( self.var_1c398372e45eff2a ) && isstruct( self.roadpath[ self.var_1c398372e45eff2a ] ) && self.roadpath.size > 0 )
        {
            self.roadpath = utility::array_slice( self.roadpath, self.var_1c398372e45eff2a, self.roadpath.size );
            self.var_1c398372e45eff2a = 0;
            
            foreach ( node in self.roadpath )
            {
                if ( !isstruct( node ) )
                {
                    var_b292656ead795c0e[ var_b292656ead795c0e.size ] = node;
                }
            }
        }
        
        if ( goalentroads.size > 0 )
        {
            foreach ( node in var_b292656ead795c0e )
            {
                roadstart = function_b38997095da36802( node.targetname );
                
                if ( function_389a4f515c2668d4( goalentroads, #startnode, roadstart ) )
                {
                    var_acf4fa672480d2e5 = function_f02c63b99c9614c9( self.roadpath, roadstart );
                    self.roadpath = utility::array_slice( self.roadpath, 0, var_acf4fa672480d2e5 + 1 );
                    result = 1;
                }
            }
            
            if ( !result && var_b292656ead795c0e.size > 0 )
            {
                var_fde46ccce3859750 = undefined;
                var_dd445f4abaced499 = undefined;
                
                foreach ( road in goalentroads )
                {
                    for ( pathnodeindex = 0; pathnodeindex < var_b292656ead795c0e.size ; pathnodeindex++ )
                    {
                        pathresult = function_3f6b381a81e300( var_b292656ead795c0e[ pathnodeindex ].targetname, road.currentnode.targetname );
                        
                        if ( pathresult )
                        {
                            path = arrayreverse( pathresult[ 0 ] );
                            pathcost = pathresult[ 1 ];
                            
                            if ( pathcost - var_3fedb43997e11aee > level.var_2d03ea9572c3657c )
                            {
                                continue;
                            }
                            
                            if ( !var_fde46ccce3859750 || pathcost < var_fde46ccce3859750 )
                            {
                                var_fde46ccce3859750 = pathcost;
                                var_acf4fa672480d2e5 = function_f02c63b99c9614c9( self.roadpath, var_b292656ead795c0e[ pathnodeindex ] );
                                var_dd445f4abaced499 = utility::array_insert_array( path, utility::array_slice( self.roadpath, 0, var_acf4fa672480d2e5 ), 0 );
                            }
                        }
                    }
                }
                
                if ( var_fde46ccce3859750 )
                {
                    self.roadpath = var_dd445f4abaced499;
                    result = 1;
                }
            }
        }
    }
    
    if ( result == 1 )
    {
        if ( isstruct( self.roadpath[ self.roadpath.size - 1 ] ) && self.roadpath[ self.roadpath.size - 1 ].isoffroad )
        {
            self.roadpath[ self.roadpath.size - 1 ].origin = navgoalorigin;
        }
        else
        {
            arrayinsert( self.roadpath, { #isoffroad:1, #origin:navgoalorigin }, self.roadpath.size );
        }
        
        return result;
    }
    
    result = function_c64bd96044937781( var_faaa47fc6aa1f40a, speed, useroads, var_c3e9f4759ee0b1fe, var_de2ce60209cec7b0, var_12e420084a68860e, amortize, vehiclenavmeshlayer, var_128160ef87ef26fd, debugdraw, var_16e78e48ea504d19, var_4489784c479cc318 );
    return result ? 2 : 0;
}

// Namespace vehicle_roads
// Params 0
// Checksum 0x8cefcb2b, Offset: 0x18a4
// Size: 0x14e
function function_acdc03a9caf15b5c()
{
    if ( self hascomponent( "c2p" ) )
    {
        return;
    }
    
    if ( self.var_26b28c4d11c39de )
    {
        nodepos = vehicle::drop_to_ground( vehicle::get_ref(), self.var_26b28c4d11c39de.origin );
        nodeangles = self.var_26b28c4d11c39de.angles;
        
        if ( self.var_26b28c4d11c39de.target )
        {
            nodetarget = getvehiclenode( self.var_26b28c4d11c39de.target, #targetname );
            nextnodedirection = ( nodetarget.origin - self.var_26b28c4d11c39de.origin ) * ( 1, 1, 0 );
            nodeangles = script::vectortoanglessafe( nextnodedirection, ( 0, 0, 1 ) );
        }
        
        self vehicle_teleport( nodepos, nodeangles, 0 );
    }
    
    self.isonroad = 1;
    
    if ( isstruct( self.roadpath[ 0 ] ) )
    {
        self.roadpath[ 0 ] = undefined;
        
        if ( isint( 0 ) )
        {
            function_cdc669dbc8ea2101( self.roadpath );
        }
        
        self.attachedpath = self.roadpath[ 0 ];
    }
}

// Namespace vehicle_roads
// Params 1
// Checksum 0x720cc61, Offset: 0x19fa
// Size: 0x43
function function_e9925980866c2c9a( var_56524e214b5e7d81 )
{
    assert( var_56524e214b5e7d81 );
    nodeindex = getvehiclenodeindex( var_56524e214b5e7d81, #targetname );
    self setconfigvalue( "path", "radiantId", nodeindex );
}

// Namespace vehicle_roads
// Params 4
// Checksum 0x25eb222a, Offset: 0x1a45
// Size: 0x13d
function function_a5252349d3eb14f2( var_c677a1872ed9e343, var_a013e99fabd91cd5, goalvehiclenode, roadnetworkpath )
{
    self notify( #"follow_road_path" );
    self endon( #"follow_road_path" );
    assert( roadnetworkpath );
    currentsplinename = var_c677a1872ed9e343;
    function_e9925980866c2c9a( var_a013e99fabd91cd5 );
    roadendnode = undefined;
    
    if ( roadnetworkpath.size == 1 )
    {
        roadendnode = goalvehiclenode;
    }
    else
    {
    }
    
    for ( roadendnode = function_57751e07f57fd60b( var_c677a1872ed9e343 ); true ; roadendnode = function_57751e07f57fd60b( var_9f31af136fe72cdd ) )
    {
        function_256de0610be6fee1( roadendnode, 1 );
        
        if ( roadendnode == goalvehiclenode )
        {
            self notify( #"reached_end_of_route" );
            break;
        }
        
        var_9f31af136fe72cdd = undefined;
        var_583c512cc2da2a02 = 0;
        
        for ( var_583c512cc2da2a02 = 0; var_583c512cc2da2a02 < roadnetworkpath.size ; var_583c512cc2da2a02++ )
        {
            if ( roadnetworkpath[ var_583c512cc2da2a02 ].targetname == currentsplinename )
            {
                var_9f31af136fe72cdd = roadnetworkpath[ var_583c512cc2da2a02 + 1 ].targetname;
                break;
            }
        }
        
        function_e9925980866c2c9a( var_9f31af136fe72cdd );
        currentsplinename = var_9f31af136fe72cdd;
        
        if ( var_583c512cc2da2a02 == roadnetworkpath.size - 1 )
        {
            roadendnode = goalvehiclenode;
            continue;
        }
    }
    
    self vehicle_setspeedimmediate( 0 );
    self setconfigvalue( "path", "pause", 1 );
}

// Namespace vehicle_roads
// Params 1
// Checksum 0x3ba88bc4, Offset: 0x1b8a
// Size: 0x8d
function get_from_navmesh( node )
{
    if ( !self.roadpath )
    {
        return;
    }
    
    index = function_f02c63b99c9614c9( self.roadpath, node );
    
    if ( isdefined( index ) )
    {
        return self.roadpath[ index + 1 ];
    }
    
    currentsplinename = node.targetname;
    var_9f31af136fe72cdd = [[ self.var_7bad066f66519780 ?? &function_40be5cbb0e8c2ad2 ]]( currentsplinename );
    
    if ( var_9f31af136fe72cdd )
    {
        return function_d5de32e196353afe( var_9f31af136fe72cdd );
    }
}

// Namespace vehicle_roads
// Params 2
// Checksum 0xdcf2957c, Offset: 0x1c1f
// Size: 0x476
function navmesh_wait( nextpoint, debugdraw = 0 )
{
    if ( !debugdraw )
    {
        debugdraw = getdvarint( @"hash_507617f8bb25261", 0 ) == 1;
    }
    
    if ( isarray( self.roadpath ) )
    {
        self.var_1c398372e45eff2a = function_f02c63b99c9614c9( self.roadpath, nextpoint );
    }
    
    if ( isstruct( nextpoint ) )
    {
        function_123852fba4d3e231( nextpoint.origin, undefined, self.navmeshlayer ?? level.vehiclenavmeshlayer ?? "vehicle_large", nextpoint.forward, debugdraw );
        self.isonroad = !nextpoint.isoffroad;
        return;
    }
    
    var_ca05ad09063fdd87 = 0;
    
    foreach ( node in self.roadpath )
    {
        if ( !node.isoffroad )
        {
            if ( nextpoint == node )
            {
                var_ca05ad09063fdd87 = 1;
            }
            
            break;
        }
    }
    
    var_fab41d095500ff51 = 0;
    
    if ( nextpoint == self.roadpath[ self.roadpath.size - 1 ] )
    {
        var_fab41d095500ff51 = 1;
    }
    else if ( isstruct( self.roadpath[ self.roadpath.size - 1 ] ) && self.roadpath.size > 2 )
    {
        assert( !isstruct( self.roadpath[ self.roadpath.size - 2 ] ) );
        
        if ( nextpoint == self.roadpath[ self.roadpath.size - 2 ] )
        {
            var_fab41d095500ff51 = 1;
        }
    }
    
    if ( var_ca05ad09063fdd87 )
    {
        vehicle_paths::vehicle_start_path( self.var_26b28c4d11c39de );
    }
    else if ( var_fab41d095500ff51 && nextpoint == self.var_aa9420e9c34ecebd )
    {
        return;
    }
    else
    {
        vehicle_paths::vehicle_start_path( nextpoint );
    }
    
    entnum = self getentitynumber();
    
    if ( self.var_1c398372e45eff2a && self.roadpath.size > self.var_1c398372e45eff2a + 1 && !isstruct( self.roadpath[ self.var_1c398372e45eff2a + 1 ] ) )
    {
        assert( isdefined( self.roadpath[ self.var_1c398372e45eff2a + 1 ].index ) && self.roadpath[ self.var_1c398372e45eff2a + 1 ].index >= 0 );
        self function_eb88c4e66edbc855( "path", "nextRadiantId", self.roadpath[ self.var_1c398372e45eff2a + 1 ].index );
    }
    else if ( self function_24e10bf6894fa869( "path", "nextRadiantId" ) >= 0 )
    {
        self function_eb88c4e66edbc855( "path", "nextRadiantId", -1 );
    }
    
    assert( function_78e803985b6122ae( nextpoint.targetname ) );
    var_a1c5c8fc030b7b6 = undefined;
    var_f067363418633ffb = function_b38997095da36802( self.var_aa9420e9c34ecebd.targetname );
    
    if ( nextpoint.targetname == var_f067363418633ffb.targetname )
    {
        var_a1c5c8fc030b7b6 = self.var_aa9420e9c34ecebd;
    }
    else
    {
        if ( var_fab41d095500ff51 && function_78e803985b6122ae( nextpoint.targetname ) )
        {
            nextnode = function_d5de32e196353afe( nextpoint.target );
            
            if ( isdefined( nextnode ) )
            {
                assert( self.var_aa9420e9c34ecebd );
                var_f4e92f22a4d2b8cd = function_b38997095da36802( nextnode.targetname );
                var_f067363418633ffb = function_b38997095da36802( self.var_aa9420e9c34ecebd.targetname );
                
                if ( var_f4e92f22a4d2b8cd && var_f067363418633ffb && var_f4e92f22a4d2b8cd == var_f067363418633ffb )
                {
                    var_a1c5c8fc030b7b6 = self.var_aa9420e9c34ecebd;
                }
            }
        }
        
        if ( !isdefined( var_a1c5c8fc030b7b6 ) )
        {
            var_cecf37e3ecc94c97 = function_57751e07f57fd60b( nextpoint.targetname );
            assert( isdefined( var_cecf37e3ecc94c97 ) );
            var_a1c5c8fc030b7b6 = var_cecf37e3ecc94c97;
        }
    }
    
    assert( var_a1c5c8fc030b7b6 );
    function_256de0610be6fee1( var_a1c5c8fc030b7b6, debugdraw );
}

// Namespace vehicle_roads
// Params 2, eflags: 0x4
// Checksum 0xeb664fdf, Offset: 0x209d
// Size: 0x9a
function private function_65b879deddf25051( vehiclenodea, vehiclenodeb )
{
    result = 1;
    var_1abac2ed1c6a2bb1 = function_b38997095da36802( vehiclenodea.targetname );
    var_e0d6186010a1cf9a = function_b38997095da36802( vehiclenodeb.targetname );
    
    if ( var_1abac2ed1c6a2bb1 == var_e0d6186010a1cf9a )
    {
        var_5e51d6d722fe4705 = function_f33d9a149f4059e8( vehiclenodea.targetname );
        var_7cdd35e967117828 = function_f33d9a149f4059e8( vehiclenodeb.targetname );
        
        if ( var_5e51d6d722fe4705 > var_7cdd35e967117828 )
        {
            result = 0;
        }
    }
    
    return result;
}

// Namespace vehicle_roads
// Params 3, eflags: 0x4
// Checksum 0xa5a2a03, Offset: 0x2140
// Size: 0x53, Type: bool
function private function_3e06664c3063733d( nodea, nodeb, ent )
{
    return distance( nodea.origin, ent.origin ) < distance( nodeb.origin, ent.origin );
}

// Namespace vehicle_roads
// Params 2, eflags: 0x4
// Checksum 0xa95d2f99, Offset: 0x219c
// Size: 0x34, Type: bool
function private function_383d40d499567368( roada, roadb )
{
    return abs( roada.offsetx ) < abs( roadb.offsetx );
}

// Namespace vehicle_roads
// Params 3
// Checksum 0x2f570f1, Offset: 0x21d9
// Size: 0xd8
function function_55d429d26d18e744( extendedwidth, extendedlength, extendedheight )
{
    init_vehicle_node_partition();
    var_13e220ca4895959f = function_592c4e9a2941ded4();
    var_ae98ea54b5bb34da = level.vehiclenodes utility::function_822c5feaca90abc1( self.origin, var_13e220ca4895959f );
    var_ae98ea54b5bb34da = arraysort( var_ae98ea54b5bb34da, self, &function_3e06664c3063733d );
    index = 0;
    roads = [];
    
    while ( index < var_ae98ea54b5bb34da.size )
    {
        endindex = min( index + 200, var_ae98ea54b5bb34da.size );
        result = self function_f6905b3461762907( utility::array_slice( var_ae98ea54b5bb34da, index, endindex ), extendedwidth, extendedlength, extendedheight );
        roads = arraycombineunique( roads, result );
        waitframe();
        index += 200;
    }
    
    return arraysort( roads, undefined, &function_383d40d499567368 );
}

// Namespace vehicle_roads
// Params 10
// Checksum 0x8c83a3c5, Offset: 0x22ba
// Size: 0x53c
function function_3fd54488ab0c7c72( startorigin, var_faaa47fc6aa1f40a, var_94e9dec930dce0a8, vehicleheading, amortize = 1, var_c0790d419ef64889 = 1500, var_128160ef87ef26fd = 200, var_ce44cb2bc998e1a0 = 800, debug = 0, var_16e78e48ea504d19 = 5 )
{
    assert( var_c0790d419ef64889 && ( !isdefined( var_128160ef87ef26fd ) || var_c0790d419ef64889 > var_128160ef87ef26fd ) );
    result = [ undefined, undefined, undefined ];
    
    if ( !isvector( startorigin ) )
    {
        assertmsg( "<dev string:x219>" );
        return result;
    }
    
    goalorigin = undefined;
    goalvehiclenode = undefined;
    
    if ( !isvector( var_faaa47fc6aa1f40a ) )
    {
        if ( !isdefined( var_faaa47fc6aa1f40a.origin ) )
        {
            assertmsg( "<dev string:x23d>" );
            return result;
        }
        
        goalvehiclenode = var_faaa47fc6aa1f40a;
        goalorigin = var_faaa47fc6aa1f40a.origin;
    }
    else
    {
        goalorigin = var_faaa47fc6aa1f40a;
    }
    
    var_ee45b4a96a1031 = distance( startorigin, goalorigin );
    
    if ( var_ee45b4a96a1031 < var_ce44cb2bc998e1a0 )
    {
        return result;
    }
    
    minlength = undefined;
    bestpath = undefined;
    var_7c3e88b4efbf7806 = undefined;
    beststartnode = undefined;
    bestgoalnode = undefined;
    var_274850134e12f7b5 = function_3127fbf4fc495e2c( var_94e9dec930dce0a8, startorigin, var_128160ef87ef26fd, vehicleheading );
    
    if ( !getdvarint( @"hash_60cade1a1ecd4f45", 0 ) == 1 && var_128160ef87ef26fd )
    {
        var_128160ef87ef26fd = undefined;
    }
    
    var_6471f4e0e6b6314b = function_d3465c4295cd717c( startorigin, goalorigin, var_c0790d419ef64889, var_128160ef87ef26fd, vehicleheading, var_274850134e12f7b5, 1, 1, 0, 1, debug, ( 0, 1, 1 ), "Start" );
    var_a2edd42814eec542 = [];
    
    if ( !isdefined( goalvehiclenode ) )
    {
        var_a2edd42814eec542 = function_d3465c4295cd717c( goalorigin, startorigin, var_c0790d419ef64889, undefined, undefined, undefined, 1, 0, 1, 0, debug, ( 1, 0.06, 0.94 ), "Goal" );
    }
    else
    {
        var_a2edd42814eec542[ 0 ] = goalvehiclenode;
    }
    
    if ( var_6471f4e0e6b6314b.size && var_a2edd42814eec542.size )
    {
        var_b5024f695ca630fe = distance( startorigin, sortbydistance( var_6471f4e0e6b6314b, startorigin )[ 0 ].origin );
        var_322e69c20f1a22e1 = distance( goalorigin, sortbydistance( var_a2edd42814eec542, goalorigin )[ 0 ].origin );
        
        if ( var_ee45b4a96a1031 < var_b5024f695ca630fe || var_ee45b4a96a1031 < var_322e69c20f1a22e1 )
        {
            return result;
        }
    }
    
    foreach ( roadnearstart in var_6471f4e0e6b6314b )
    {
        if ( arraycontains( var_a2edd42814eec542, roadnearstart ) )
        {
            /#
                if ( debug )
                {
                    sphere( roadnearstart.origin, 35, ( 0, 1, 1 ), 0, 600 );
                }
            #/
            
            return result;
        }
    }
    
    for ( goalindex = 0; goalindex < var_a2edd42814eec542.size && goalindex < 10 ; goalindex++ )
    {
        var_4c5cce9f9be1e278 = function_b38997095da36802( var_a2edd42814eec542[ goalindex ] );
        
        for ( startindex = 0; startindex < var_6471f4e0e6b6314b.size && startindex < 10 ; startindex++ )
        {
            if ( !function_65b879deddf25051( var_6471f4e0e6b6314b[ startindex ], var_a2edd42814eec542[ goalindex ] ) )
            {
                continue;
            }
            
            var_92946b89cea7cc7 = undefined;
            path = undefined;
            pathcost = undefined;
            
            if ( var_7c3e88b4efbf7806 )
            {
                var_92946b89cea7cc7 = function_3f6b381a81e300( var_6471f4e0e6b6314b[ startindex ], var_a2edd42814eec542[ goalindex ].targetname, var_7c3e88b4efbf7806 );
            }
            else
            {
                var_92946b89cea7cc7 = function_3f6b381a81e300( var_6471f4e0e6b6314b[ startindex ], var_a2edd42814eec542[ goalindex ].targetname );
            }
            
            if ( var_92946b89cea7cc7 )
            {
                path = arrayreverse( var_92946b89cea7cc7[ 0 ] );
                pathcost = var_92946b89cea7cc7[ 1 ];
            }
            
            if ( amortize )
            {
                waitframe();
            }
            
            if ( !path )
            {
                continue;
            }
            
            pathlength = function_c5f4027066f63f00( path, startorigin, goalorigin, var_6471f4e0e6b6314b[ startindex ], var_a2edd42814eec542[ goalindex ], 0, ( goalindex + startindex ) * ( 0, 0, 40 ) );
            assert( isdefined( pathlength ) );
            
            if ( !minlength || pathlength < minlength )
            {
                var_92aa4c65d3bedc39 = 0;
                
                if ( var_a2edd42814eec542[ goalindex ] != var_4c5cce9f9be1e278 )
                {
                    var_5773b348272c8679 = function_b179fb168c342d2b( var_4c5cce9f9be1e278 );
                    var_c2705222901d6182 = function_f33d9a149f4059e8( var_a2edd42814eec542[ goalindex ] );
                    var_92aa4c65d3bedc39 = var_5773b348272c8679 * var_c2705222901d6182;
                }
                
                bestpath = path;
                var_7c3e88b4efbf7806 = pathcost + var_92aa4c65d3bedc39;
                minlength = pathlength;
                beststartnode = var_6471f4e0e6b6314b[ startindex ];
                bestgoalnode = var_a2edd42814eec542[ goalindex ];
            }
        }
    }
    
    if ( !bestpath || minlength > var_ee45b4a96a1031 * var_16e78e48ea504d19 )
    {
        return result;
    }
    
    /#
        if ( debug )
        {
            sphere( beststartnode.origin, 35, ( 0, 1, 1 ), 0, 600 );
            sphere( bestgoalnode.origin, 35, ( 1, 0.06, 0.94 ), 0, 600 );
        }
    #/
    
    result = [ bestpath, beststartnode, bestgoalnode ];
    return result;
}

// Namespace vehicle_roads
// Params 7, eflags: 0x4
// Checksum 0x7564ad1e, Offset: 0x27ff
// Size: 0x313
function private function_c5f4027066f63f00( path, startorigin, goalorigin, var_806bffecf61dbf3a, var_933647e3b2d21121, debug = 0, debugoffset = ( 0, 0, 0 ) )
{
    result = distance( var_806bffecf61dbf3a.origin, startorigin ) + distance( var_933647e3b2d21121.origin, goalorigin );
    
    /#
        if ( debug )
        {
            debugcolor = ( randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ) );
            print3d( var_806bffecf61dbf3a.origin, "<dev string:x26d>", debugcolor, 1, 3, 600 );
            print3d( var_933647e3b2d21121.origin, "<dev string:x278>", debugcolor, 1, 3, 600 );
            print3d( goalorigin, "<dev string:x282>", debugcolor, 1, 3, 600 );
            line( var_806bffecf61dbf3a.origin + debugoffset, startorigin + debugoffset, debugcolor, 1, 0, 600 );
            line( var_933647e3b2d21121.origin + debugoffset, goalorigin + debugoffset, debugcolor, 1, 0, 600 );
        }
    #/
    
    var_9d186768e96caef8 = function_b38997095da36802( var_806bffecf61dbf3a );
    var_8d6963affbb9b9c7 = function_b38997095da36802( var_933647e3b2d21121 );
    
    for ( nodeindex = 0; nodeindex < path.size ; nodeindex++ )
    {
        roadnode = path[ nodeindex ];
        
        if ( roadnode == var_9d186768e96caef8 && roadnode != var_806bffecf61dbf3a && roadnode != var_933647e3b2d21121 && var_9d186768e96caef8 == var_8d6963affbb9b9c7 )
        {
            var_5773b348272c8679 = function_b179fb168c342d2b( roadnode );
            var_52d59a195a4ccc78 = function_f33d9a149f4059e8( var_806bffecf61dbf3a );
            var_7474b70812293bf7 = function_f33d9a149f4059e8( var_933647e3b2d21121 );
            assert( isdefined( var_52d59a195a4ccc78 ) && isdefined( var_7474b70812293bf7 ) && var_5773b348272c8679 );
            result += var_5773b348272c8679 * abs( var_52d59a195a4ccc78 - var_7474b70812293bf7 );
        }
        else if ( roadnode == var_9d186768e96caef8 && roadnode != var_806bffecf61dbf3a )
        {
            var_3e81d1763f7a6eb5 = function_b179fb168c342d2b( var_9d186768e96caef8 );
            var_52d59a195a4ccc78 = function_f33d9a149f4059e8( var_806bffecf61dbf3a );
            assert( var_3e81d1763f7a6eb5 && isdefined( var_52d59a195a4ccc78 ) );
            result += var_3e81d1763f7a6eb5 * ( 1 - var_52d59a195a4ccc78 );
        }
        else if ( roadnode == var_8d6963affbb9b9c7 )
        {
            var_6899c7ddbaeb3f98 = function_b179fb168c342d2b( var_8d6963affbb9b9c7 );
            var_7474b70812293bf7 = function_f33d9a149f4059e8( var_933647e3b2d21121 );
            assert( var_6899c7ddbaeb3f98 && isdefined( var_7474b70812293bf7 ) );
            result += var_6899c7ddbaeb3f98 * var_7474b70812293bf7;
        }
        else
        {
            var_5773b348272c8679 = function_b179fb168c342d2b( roadnode );
            assert( var_5773b348272c8679 );
            result += var_5773b348272c8679;
        }
        
        if ( nodeindex > 0 )
        {
            prevendnode = function_57751e07f57fd60b( path[ nodeindex - 1 ].targetname );
            result += distance( prevendnode.origin, roadnode.origin );
        }
    }
    
    /#
        if ( debug )
        {
            print3d( startorigin + debugoffset, "<dev string:x1ec>" + result, debugcolor, 1, 3, 600 );
        }
    #/
    
    return result;
}

// Namespace vehicle_roads
// Params 1
// Checksum 0xa115cd50, Offset: 0x2b1b
// Size: 0x83
function function_40be5cbb0e8c2ad2( currentsplinename )
{
    resulttargetname = undefined;
    
    if ( isdefined( self.roadpath ) )
    {
        for ( index = 0; index < self.roadpath.size ; index++ )
        {
            if ( self.roadpath[ index ].targetname == currentsplinename )
            {
                resulttargetname = self.roadpath[ index + 1 ].targetname;
                break;
            }
        }
    }
    
    return resulttargetname;
}

// Namespace vehicle_roads
// Params 3
// Checksum 0xc49e5e58, Offset: 0x2ba7
// Size: 0x42a
function follow_roads( var_c677a1872ed9e343, var_a013e99fabd91cd5, debugdraw )
{
    self endon( #"death" );
    self notify( #"follow_roads" );
    self endon( #"follow_roads" );
    self notify( #"hash_30810a5916abaede" );
    currentsplinename = var_c677a1872ed9e343;
    var_a013e99fabd91cd5 = var_a013e99fabd91cd5 ?? var_c677a1872ed9e343;
    vehicle_paths::vehicle_start_path( var_a013e99fabd91cd5 );
    
    /#
        if ( debugdraw )
        {
            debugduration = 500;
            debugcolor = ( 1, 0.75, 0.8 );
            additionalradius = randomint( 15 );
            attachnode = getvehiclenode( var_a013e99fabd91cd5, #targetname );
            line( self.origin, attachnode.origin, debugcolor, 1, 0, debugduration );
            sphere( attachnode.origin, 150 + additionalradius, debugcolor, 0, debugduration );
        }
    #/
    
    while ( true )
    {
        var_a1c5c8fc030b7b6 = undefined;
        
        if ( self.closestvehiclenode && currentsplinename == function_b38997095da36802( self.closestvehiclenode ).targetname )
        {
            var_a1c5c8fc030b7b6 = self.var_aa9420e9c34ecebd;
        }
        else
        {
            var_a1c5c8fc030b7b6 = function_57751e07f57fd60b( currentsplinename );
            assert( var_a1c5c8fc030b7b6 );
        }
        
        function_256de0610be6fee1( var_a1c5c8fc030b7b6, debugdraw );
        assert( currentsplinename );
        var_2ccb4d6242932233 = function_49a267d2538b5a6b( currentsplinename );
        connections = [];
        
        foreach ( connectionnode in var_2ccb4d6242932233 )
        {
            connections[ connections.size ] = connectionnode.targetname;
        }
        
        if ( connections.size == 0 )
        {
            self notify( #"reached_end_of_route" );
            break;
        }
        
        var_9f31af136fe72cdd = [[ self.var_7bad066f66519780 ?? &function_40be5cbb0e8c2ad2 ]]( currentsplinename );
        
        if ( !isdefined( var_9f31af136fe72cdd ) && connections.size > 0 )
        {
            if ( level.convoys[ self.convoyindex ].var_c7209d94145d9827[ currentsplinename ] )
            {
                var_9f31af136fe72cdd = level.convoys[ self.convoyindex ].var_c7209d94145d9827[ currentsplinename ];
            }
            else
            {
                closestdistance = undefined;
                
                foreach ( connection in arrayrandomize( connections ) )
                {
                    if ( !function_37a7168921a87467( connection ) )
                    {
                        continue;
                    }
                    
                    if ( !is_dead_end( connection ) )
                    {
                        if ( self.var_1728ea741af23333 )
                        {
                            connectiondistance = distance2d( function_57751e07f57fd60b( connection ).origin, self.var_1728ea741af23333 );
                            
                            if ( !closestdistance || connectiondistance < closestdistance )
                            {
                                closestdistance = connectiondistance;
                                var_9f31af136fe72cdd = connection;
                            }
                            
                            continue;
                        }
                        
                        var_9f31af136fe72cdd = connection;
                        break;
                    }
                }
                
                if ( !isdefined( var_9f31af136fe72cdd ) )
                {
                    var_9f31af136fe72cdd = utility::array_random( connections );
                }
                
                if ( level.convoys[ self.convoyindex ] )
                {
                    if ( !isdefined( level.convoys[ self.convoyindex ].var_c7209d94145d9827 ) )
                    {
                        level.convoys[ self.convoyindex ].var_c7209d94145d9827 = [];
                    }
                    
                    level.convoys[ self.convoyindex ].var_c7209d94145d9827[ currentsplinename ] = var_9f31af136fe72cdd;
                }
            }
            
            self.veh_pathdir = "forward";
        }
        
        if ( isdefined( var_9f31af136fe72cdd ) )
        {
            vehicle_paths::vehicle_start_path( var_9f31af136fe72cdd );
            currentsplinename = var_9f31af136fe72cdd;
            continue;
        }
        
        self notify( #"reached_end_of_route" );
        break;
    }
}

// Namespace vehicle_roads
// Params 1
// Checksum 0x6afd7416, Offset: 0x2fd9
// Size: 0x17
function function_f5461f94d0c19719( origin )
{
    self.var_1728ea741af23333 = origin;
}

// Namespace vehicle_roads
// Params 1
// Checksum 0xaccbc48b, Offset: 0x2ff8
// Size: 0x15, Type: bool
function is_dead_end( road )
{
    return function_49a267d2538b5a6b( road ).size == 0;
}

// Namespace vehicle_roads
// Params 0
// Checksum 0xd7dd8259, Offset: 0x3016
// Size: 0xe
function stop_follow_roads()
{
    self notify( #"follow_roads" );
}

// Namespace vehicle_roads
// Params 0
// Checksum 0xbe15dc54, Offset: 0x302c
// Size: 0xe
function function_95a3bf8ea721adce()
{
    self notify( #"move_to_done" );
}

// Namespace vehicle_roads
// Params 5
// Checksum 0xf124eb87, Offset: 0x3042
// Size: 0x244
function function_123852fba4d3e231( goallocation, speedmph, vehiclenavmeshlayer, goaldirection = ( 0, 0, 0 ), debugdraw = 0 )
{
    self notify( #"hash_dea9fcceebf6204c" );
    self endon( #"hash_dea9fcceebf6204c" );
    
    if ( !debugdraw )
    {
        debugdraw = getdvarint( @"hash_7b0ae34c8c0cc254", 0 ) == 1;
    }
    
    if ( !isdefined( vehiclenavmeshlayer ) )
    {
        vehiclenavmeshlayer = level.vehiclenavmeshlayer ?? "vehicle_large";
    }
    
    startlocation = self.origin;
    vehicleforward = anglestoforward( self.angles );
    splinepoints = self findsplinepath( startlocation, goallocation, 50, 200, 100, vehicleforward, goaldirection, 300, 0.4, 0, 1, vehiclenavmeshlayer, 0, 1 );
    
    if ( speedmph )
    {
        vehicle::vehicle_set_speed( speedmph, 12, 6 );
    }
    
    if ( !isdefined( splinepoints ) )
    {
        /#
            println( "<dev string:x28e>" + self getentitynumber() + "<dev string:x2bd>" + startlocation + "<dev string:x2df>" + goallocation );
            
            if ( debugdraw )
            {
                debugduration = 200;
                debugcolor = ( 1, 0.5, 0.5 );
                line( startlocation, goallocation, debugcolor, 1, 0, debugduration );
                line( goallocation, goallocation + ( 0, 0, 1024 ), debugcolor, 1, 0, debugduration );
            }
        #/
        
        callback::callback( #"hash_a66f22b6e512afda", { #goaldirection:goaldirection, #vehiclenavmeshlayer:vehiclenavmeshlayer, #speedmph:speedmph, #goallocation:goallocation } );
        return "vehicleFailedToFindNavSpline";
    }
    
    /#
        if ( splinepoints.size && debugdraw )
        {
            thread function_2b723e6a5a86a006( splinepoints, isdefined( vehiclenavmeshlayer ) ? ( 1, 1, 1 ) : ( 1, 0, 0 ) );
            thread function_8437fc8203abb755( vehiclenavmeshlayer );
        }
    #/
    
    thread watch_stuck();
    thread watch_interrupt();
    result = utility::waittill_any_return( "reached_end_node", "vehicleStuckNavSpline", "vehicleNavSplineInterrupted", "death" );
    self notify( #"move_to_done" );
    return result;
}

// Namespace vehicle_roads
// Params 1
// Checksum 0x2036e2bc, Offset: 0x328f
// Size: 0x14b
function watch_stuck( debugdraw )
{
    self notify( #"hash_8c3b4b242aa58d45" );
    self endon( #"hash_8c3b4b242aa58d45" );
    self endon( #"death" );
    self endon( #"move_to_done" );
    self endon( #"newpath" );
    laststucktime = undefined;
    laststuckposition = undefined;
    stuckdistancethreshold = 100;
    var_d847e2f7986ada00 = 5;
    
    while ( true )
    {
        self waittill( #"path_blocked" );
        
        if ( !( isdefined( laststucktime ) && isdefined( laststuckposition ) ) )
        {
            laststucktime = gettime();
            laststuckposition = self.origin;
            continue;
        }
        
        stuckdistance = length2d( self.origin - laststuckposition );
        
        if ( stuckdistance > stuckdistancethreshold )
        {
            laststucktime = gettime();
            laststuckposition = self.origin;
            continue;
        }
        
        timeelapsed = gettime() - laststucktime;
        timeelapsedseconds = timeelapsed / 1000;
        
        if ( timeelapsedseconds > var_d847e2f7986ada00 )
        {
            /#
                if ( debugdraw )
                {
                    print3d( self getcentroid(), "<dev string:x2e4>", ( 1, 1, 1 ), 1, 1, 4000 );
                }
            #/
            
            self notify( #"vehiclestucknavspline" );
            self stoppath();
            break;
        }
    }
}

// Namespace vehicle_roads
// Params 1
// Checksum 0xc8b3e548, Offset: 0x33e2
// Size: 0x9a
function watch_interrupt( debugdraw )
{
    self notify( #"hash_d08ee6920cb4c5cf" );
    self endon( #"hash_d08ee6920cb4c5cf" );
    self endon( #"death" );
    self endon( #"move_to_done" );
    self endon( #"newpath" );
    
    while ( true )
    {
        self waittill( #"navspline_interrupted" );
        
        /#
            if ( debugdraw )
            {
                print3d( self getcentroid(), "<dev string:x2fc>", ( 1, 1, 1 ), 1, 1, 4000 );
            }
        #/
        
        self notify( #"vehiclenavsplineinterrupted" );
        self stoppath();
    }
}

// Namespace vehicle_roads
// Params 2
// Checksum 0xbe8687f8, Offset: 0x3484
// Size: 0x86
function enable_roads( enablespline, splinetargetnames )
{
    foreach ( splinetargetname in splinetargetnames )
    {
        function_7d179b66f4277e61( splinetargetname, enablespline );
    }
}

// Namespace vehicle_roads
// Params 0
// Checksum 0x7fbb7051, Offset: 0x3512
// Size: 0xd1
function function_ead8c1253a45bd10()
{
    if ( !isdefined( level.vehiclestartnodes ) )
    {
        allvehiclenodes = getallvehiclenodes();
        level.vehiclestartnodes = [];
        
        foreach ( vehiclenode in allvehiclenodes )
        {
            if ( vehiclenode.spawnflags > 0 && isdefined( vehiclenode.target ) )
            {
                level.vehiclestartnodes[ level.vehiclestartnodes.size ] = vehiclenode;
            }
        }
    }
    
    return level.vehiclestartnodes;
}

// Namespace vehicle_roads
// Params 1, eflags: 0x4
// Checksum 0xca21edff, Offset: 0x35ec
// Size: 0x133
function private function_cd5f416b97d4464( checkvehiclenode )
{
    result = [];
    
    if ( !level.allvehiclenodes )
    {
        level.allvehiclenodes = getallvehiclenodes();
    }
    
    foreach ( vehiclenode in level.allvehiclenodes )
    {
        if ( vehiclenode.target && vehiclenode.target == checkvehiclenode.targetname )
        {
            result[ result.size ] = vehiclenode;
        }
        
        if ( vehiclenode.target2 && vehiclenode.target2 == checkvehiclenode.targetname )
        {
            result[ result.size ] = vehiclenode;
        }
        
        if ( vehiclenode.target3 && vehiclenode.target3 == checkvehiclenode.targetname )
        {
            result[ result.size ] = vehiclenode;
        }
    }
    
    return result;
}

// Namespace vehicle_roads
// Params 1
// Checksum 0x1c9778a6, Offset: 0x3728
// Size: 0x43c
function function_e6974b6c2f2c11cd( debugdraw = 0 )
{
    if ( !isdefined( level.var_666f4d8169dc4fbf ) )
    {
        allvehiclenodes = getallvehiclenodes();
        level.var_666f4d8169dc4fbf = [];
        level.var_c9ac523ccb3f4305 = [];
        level.var_42b5a3f97906fc3 = [];
        level.var_57587d488f0edd2f = [];
        level.var_67119a9659b67e6d = [];
        
        foreach ( vehiclenodeindex, vehiclenode in allvehiclenodes )
        {
            if ( mod( vehiclenodeindex, 20 ) == 0 )
            {
                waitframe();
            }
            
            if ( vehiclenode.target2 || vehiclenode.target3 )
            {
                assert( vehiclenode.target, "<dev string:x31a>" + vehiclenode.targetname + "<dev string:x351>" );
                
                if ( vehiclenode.target )
                {
                    level.var_666f4d8169dc4fbf = arraycombineunique( level.var_666f4d8169dc4fbf, [ vehiclenode ] );
                    level.var_67119a9659b67e6d = arraycombineunique( level.var_67119a9659b67e6d, [ vehiclenode ] );
                    targetvehiclenode = function_d5de32e196353afe( vehiclenode.target );
                    assert( targetvehiclenode );
                    
                    if ( targetvehiclenode )
                    {
                        level.var_42b5a3f97906fc3 = arraycombineunique( level.var_42b5a3f97906fc3, [ vehiclenode ] );
                    }
                    
                    if ( vehiclenode.target2 )
                    {
                        target2vehiclenode = function_d5de32e196353afe( vehiclenode.target2 );
                        
                        if ( target2vehiclenode )
                        {
                            level.var_42b5a3f97906fc3 = arraycombineunique( level.var_42b5a3f97906fc3, [ target2vehiclenode ] );
                        }
                    }
                    
                    if ( vehiclenode.target3 )
                    {
                        target3vehiclenode = function_d5de32e196353afe( vehiclenode.target3 );
                        
                        if ( target3vehiclenode )
                        {
                            level.var_42b5a3f97906fc3 = arraycombineunique( level.var_42b5a3f97906fc3, [ target3vehiclenode ] );
                        }
                    }
                }
                
                continue;
            }
            
            incomingconnections = function_cd5f416b97d4464( vehiclenode );
            
            if ( incomingconnections.size >= 2 )
            {
                level.var_57587d488f0edd2f = arraycombineunique( level.var_57587d488f0edd2f, [ vehiclenode ] );
                level.var_666f4d8169dc4fbf = arraycombineunique( level.var_666f4d8169dc4fbf, [ vehiclenode ] );
                targetvehiclenode = function_d5de32e196353afe( vehiclenode.target );
                assert( targetvehiclenode, "<dev string:x379>" + vehiclenode.targetname + "<dev string:x386>" );
                
                if ( targetvehiclenode )
                {
                    level.var_42b5a3f97906fc3 = arraycombineunique( level.var_42b5a3f97906fc3, [ vehiclenode ] );
                }
                
                continue;
            }
            
            if ( vehiclenode.spawnflags > 0 && vehiclenode.target && incomingconnections.size == 0 )
            {
                level.var_42b5a3f97906fc3 = arraycombineunique( level.var_42b5a3f97906fc3, [ vehiclenode ] );
                level.var_c9ac523ccb3f4305 = arraycombineunique( level.var_c9ac523ccb3f4305, [ vehiclenode ] );
            }
        }
    }
    
    /#
        if ( debugdraw )
        {
            foreach ( node in level.var_666f4d8169dc4fbf )
            {
                line( node.origin, node.origin + ( 0, 0, 2048 ), ( 1, 0.77, 0.82 ), 1, 0, 18000 );
                sphere( node.origin, 75, ( 1, 0.77, 0.82 ), 0, 18000 );
            }
        }
    #/
    
    return level.var_42b5a3f97906fc3;
}

// Namespace vehicle_roads
// Params 2
// Checksum 0xd6c05e7c, Offset: 0x3b6d
// Size: 0x79
function get_closest_road( searchorigin, maxdistance = 3500 )
{
    assert( isdefined( level.roads ) );
    init_vehicle_node_partition();
    result = undefined;
    var_ae98ea54b5bb34da = level.vehiclenodes utility::function_822c5feaca90abc1( searchorigin, maxdistance );
    var_ae98ea54b5bb34da = sortbydistance( var_ae98ea54b5bb34da, searchorigin );
    
    if ( var_ae98ea54b5bb34da.size > 0 )
    {
        result = var_ae98ea54b5bb34da[ 0 ];
    }
    
    return result;
}

// Namespace vehicle_roads
// Params 0
// Checksum 0x9c993d7f, Offset: 0x3bef
// Size: 0x26
function init_vehicle_node_partition()
{
    if ( !isdefined( level.vehiclenodes ) )
    {
        level.vehiclenodes = utility::create_partition( getallvehiclenodes(), 3500, 1 );
    }
}

// Namespace vehicle_roads
// Params 2, eflags: 0x4
// Checksum 0xa5cad9cf, Offset: 0x3c1d
// Size: 0x5d
function private function_5b999b3f4e8b90c8( node, origin )
{
    roadnodes = [];
    roadnodes[ roadnodes.size ] = node;
    
    while ( node.target )
    {
        node = function_d5de32e196353afe( node.target );
        roadnodes[ roadnodes.size ] = node;
    }
    
    return sortbydistance( roadnodes, origin )[ 0 ];
}

// Namespace vehicle_roads
// Params 7
// Checksum 0x9cc2f67a, Offset: 0x3c83
// Size: 0x29a
function get_closest_vehicle_node( goalorigin, maxdistance = 3500, goaldirection = undefined, var_8a4f78052b5273fa = 90, var_debd3da3c83a10e9 = 90, skipend = 1, debugdraw = 0 )
{
    init_vehicle_node_partition();
    var_ae98ea54b5bb34da = level.vehiclenodes utility::function_822c5feaca90abc1( goalorigin, maxdistance );
    var_ae98ea54b5bb34da = sortbydistance( var_ae98ea54b5bb34da, goalorigin );
    result = [ undefined, undefined ];
    
    if ( var_ae98ea54b5bb34da.size > 0 )
    {
        foreach ( vehiclenode in var_ae98ea54b5bb34da )
        {
            if ( !isdefined( function_b38997095da36802( vehiclenode.targetname ) ) )
            {
                continue;
            }
            
            if ( skipend && !isdefined( vehiclenode.target ) )
            {
                continue;
            }
            
            if ( isdefined( goaldirection ) && isdefined( vehiclenode.target ) )
            {
                nextnode = function_d5de32e196353afe( vehiclenode.target );
                nodeheading = vectornormalize2( nextnode.origin - vehiclenode.origin );
                var_16ed23c977a1370a = vectornormalize2( vehiclenode.origin - goalorigin );
                
                if ( vectordot2( nodeheading, goaldirection ) < cos( var_8a4f78052b5273fa ) )
                {
                    continue;
                }
                
                if ( vectordot2( var_16ed23c977a1370a, goaldirection ) < cos( var_debd3da3c83a10e9 ) )
                {
                    continue;
                }
            }
            
            roadstartvehiclenode = function_b38997095da36802( vehiclenode.targetname );
            
            if ( !function_37a7168921a87467( roadstartvehiclenode.targetname ) )
            {
                continue;
            }
            
            result = [ vehiclenode, roadstartvehiclenode.targetname ];
            
            /#
                if ( debugdraw )
                {
                    duration = 600;
                    line( goalorigin, vehiclenode.origin, ( 1, 1, 0 ), 1, 0, duration );
                    sphere( vehiclenode.origin, 15, ( 1, 1, 0 ), 0, duration );
                }
            #/
            
            break;
        }
    }
    
    return result;
}

// Namespace vehicle_roads
// Params 4, eflags: 0x4
// Checksum 0xdd7c9fc4, Offset: 0x3f26
// Size: 0x119
function private function_3127fbf4fc495e2c( var_94e9dec930dce0a8, searchorigin, var_cfaff5e2d53d4413, vehicleheading )
{
    result = undefined;
    currentnode = var_94e9dec930dce0a8;
    
    while ( !isdefined( result ) )
    {
        if ( !isdefined( currentnode ) || !isdefined( currentnode.target ) )
        {
            break;
        }
        
        nextnode = function_d5de32e196353afe( currentnode.target );
        
        if ( distance2dsquared( searchorigin, nextnode.origin ) < squared( var_cfaff5e2d53d4413 ) )
        {
            currentnode = nextnode;
            continue;
        }
        
        vehiclenodeheading = nextnode.origin - currentnode.origin;
        var_69e497f2f3ca4d34 = nextnode.origin - searchorigin;
        var_43c59b0b0ee771e3 = vectordot2( vehicleheading, vehiclenodeheading );
        var_7804fabc892a1361 = vectordot2( vehicleheading, var_69e497f2f3ca4d34 );
        
        if ( var_43c59b0b0ee771e3 > 0 && var_7804fabc892a1361 < 0 )
        {
            currentnode = nextnode;
            continue;
        }
        
        result = nextnode;
    }
    
    return result;
}

// Namespace vehicle_roads
// Params 2, eflags: 0x4
// Checksum 0x833863fc, Offset: 0x4048
// Size: 0x14c
function private function_1a2a323483b5dc15( var_8977d39d6839964e, visitedroads )
{
    result = 0;
    
    foreach ( closestvehiclenode in visitedroads )
    {
        var_608350c413b0063a = function_b38997095da36802( closestvehiclenode.targetname );
        var_dd9dff6e95cccfeb = function_49a267d2538b5a6b( var_608350c413b0063a.targetname );
        
        if ( var_dd9dff6e95cccfeb.size > 0 )
        {
            foreach ( var_18f76fab9ef5731a in var_dd9dff6e95cccfeb )
            {
                if ( var_18f76fab9ef5731a.targetname == var_8977d39d6839964e )
                {
                    result = 1;
                    break;
                }
            }
            
            if ( result )
            {
                break;
            }
        }
    }
    
    return result;
}

/#

    // Namespace vehicle_roads
    // Params 4, eflags: 0x4
    // Checksum 0x81660973, Offset: 0x419d
    // Size: 0x158, Type: dev
    function private function_95b21505afdddd54( searchorigin, visitedroads, debugcolor, debugmessage )
    {
        notifyname = "<dev string:x3a2>" + debugmessage;
        self notify( notifyname );
        self endon( notifyname );
        offset = ( 0, 0, 100 );
        
        while ( true )
        {
            waitframe();
            print3d( searchorigin + offset, "<dev string:x3c4>" + debugmessage, debugcolor, 1, 1, 1 );
            roadindex = 0;
            
            foreach ( vehiclenode in visitedroads )
            {
                nodedistance = distance( vehiclenode.origin, searchorigin );
                line( searchorigin + offset, vehiclenode.origin, debugcolor, 1, 0, 1 );
                print3d( vehiclenode.origin + offset, "<dev string:x1ec>" + roadindex + "<dev string:x3e0>" + nodedistance, debugcolor, 1, 1, 1 );
                roadindex++;
            }
        }
    }

#/

// Namespace vehicle_roads
// Params 13, eflags: 0x4
// Checksum 0x24e9af4c, Offset: 0x42fd
// Size: 0x142
function private function_d3465c4295cd717c( searchorigin, goalorigin, maxdistance, var_cfaff5e2d53d4413, vehicleheading, var_274850134e12f7b5, var_c8588ac7478dc8c3, var_4843e3b4a818e61d, skipstartnodes, var_2324545dc6510f0f, debugdraw, debugcolor, debugmessage )
{
    assert( searchorigin && isvector( searchorigin ), "<dev string:x3e7>" );
    assert( goalorigin && isvector( goalorigin ), "<dev string:x421>" );
    assert( maxdistance && ( !isdefined( var_cfaff5e2d53d4413 ) || maxdistance > var_cfaff5e2d53d4413 ) );
    var_21e370a618019339 = searchorigin;
    goaldirection = vectornormalize2( goalorigin - searchorigin );
    maxdistancesq = squared( maxdistance );
    result = [];
    
    while ( true )
    {
        result = function_3e6f292cbbccd99c( var_21e370a618019339, maxdistance, var_cfaff5e2d53d4413, vehicleheading, var_274850134e12f7b5, var_c8588ac7478dc8c3, var_4843e3b4a818e61d, skipstartnodes, var_2324545dc6510f0f, debugdraw, debugcolor, debugmessage );
        
        if ( result.size > 0 || distance2dsquared( var_21e370a618019339, goalorigin ) <= maxdistancesq )
        {
            break;
        }
        
        var_21e370a618019339 += goaldirection * maxdistance;
    }
    
    return result;
}

// Namespace vehicle_roads
// Params 12, eflags: 0x4
// Checksum 0xddfe85cb, Offset: 0x4448
// Size: 0x414
function private function_3e6f292cbbccd99c( searchorigin, maxdistance, var_cfaff5e2d53d4413, vehicleheading, var_274850134e12f7b5, var_c8588ac7478dc8c3, var_4843e3b4a818e61d, skipstartnodes, var_2324545dc6510f0f, debugdraw, debugcolor, debugmessage )
{
    assert( searchorigin && isvector( searchorigin ), "<dev string:x3e7>" );
    assert( maxdistance && ( !isdefined( var_cfaff5e2d53d4413 ) || maxdistance > var_cfaff5e2d53d4413 ) );
    assert( function_98191bf615bc9f9d() > 0, "<dev string:x459>" );
    init_vehicle_node_partition();
    var_ae98ea54b5bb34da = level.vehiclenodes utility::function_822c5feaca90abc1( searchorigin, maxdistance );
    var_ae98ea54b5bb34da = sortbydistance( var_ae98ea54b5bb34da, searchorigin );
    var_ad03c58a6f789f23 = var_cfaff5e2d53d4413 ? squared( var_cfaff5e2d53d4413 ) : undefined;
    visitedroads = [];
    result = [];
    
    if ( var_ae98ea54b5bb34da.size > 0 )
    {
        foreach ( vehiclenode in var_ae98ea54b5bb34da )
        {
            if ( !isdefined( function_b38997095da36802( vehiclenode.targetname ) ) )
            {
                continue;
            }
            
            if ( skipstartnodes && function_78e803985b6122ae( vehiclenode.targetname ) )
            {
                incomingroad = function_d3015c4a51db0aa2( vehiclenode );
                
                if ( !( isdefined( incomingroad ) && incomingroad.target == vehiclenode.targetname ) )
                {
                    continue;
                }
            }
            
            if ( var_2324545dc6510f0f && !isdefined( vehiclenode.target ) )
            {
                continue;
            }
            
            roadstartvehiclenode = function_b38997095da36802( vehiclenode.targetname );
            assert( isdefined( roadstartvehiclenode ) );
            var_5262adea3d5fcba3 = roadstartvehiclenode.index;
            
            if ( !function_37a7168921a87467( roadstartvehiclenode.targetname ) )
            {
                continue;
            }
            
            if ( var_2324545dc6510f0f )
            {
                var_cecf37e3ecc94c97 = function_57751e07f57fd60b( roadstartvehiclenode.targetname );
                assert( isdefined( var_cecf37e3ecc94c97 ) );
                
                if ( vehiclenode.targetname == var_cecf37e3ecc94c97.targetname )
                {
                    continue;
                }
            }
            
            if ( !isdefined( visitedroads[ var_5262adea3d5fcba3 ] ) )
            {
                if ( var_ad03c58a6f789f23 && distance2dsquared( searchorigin, vehiclenode.origin ) < var_ad03c58a6f789f23 )
                {
                    continue;
                }
                
                if ( function_1a2a323483b5dc15( roadstartvehiclenode.targetname, visitedroads ) )
                {
                    continue;
                }
                
                if ( vehicleheading && vehiclenode.target )
                {
                    nextnode = function_d5de32e196353afe( vehiclenode.target );
                    vehiclenodeheading = nextnode.origin - vehiclenode.origin;
                    var_69e497f2f3ca4d34 = vehiclenode.origin - searchorigin;
                    var_43c59b0b0ee771e3 = vectordot2( vehicleheading, vehiclenodeheading );
                    var_7804fabc892a1361 = vectordot2( vehicleheading, var_69e497f2f3ca4d34 );
                    
                    if ( var_43c59b0b0ee771e3 > 0 && var_7804fabc892a1361 < 0 )
                    {
                        continue;
                    }
                }
                
                visitedroads[ var_5262adea3d5fcba3 ] = vehiclenode;
                result[ result.size ] = vehiclenode;
            }
        }
    }
    
    if ( var_274850134e12f7b5 && !arraycontains( result, var_274850134e12f7b5 ) )
    {
        result = arraycombine( [ var_274850134e12f7b5 ], result );
        
        if ( getdvarint( @"hash_489c47f3b9ba3325", 1 ) == 1 && var_4843e3b4a818e61d )
        {
            var_75b5928a2283c4d3 = function_b38997095da36802( var_274850134e12f7b5.targetname );
            
            if ( !isdefined( visitedroads[ var_75b5928a2283c4d3.index ] ) )
            {
                visitedroads[ var_75b5928a2283c4d3.index ] = var_274850134e12f7b5;
            }
            
            result = function_2f836bbfd6f79cb9( visitedroads, result );
        }
    }
    
    /#
        if ( debugdraw )
        {
            thread function_95b21505afdddd54( searchorigin, visitedroads, debugcolor, debugmessage );
        }
    #/
    
    return result;
}

// Namespace vehicle_roads
// Params 2, eflags: 0x4
// Checksum 0x84822e17, Offset: 0x4865
// Size: 0x15c
function private function_2f836bbfd6f79cb9( var_4a1b86abd6966df, visitedroads )
{
    result = visitedroads;
    
    foreach ( visitedroad in var_4a1b86abd6966df )
    {
        roadstartvehiclenode = function_b38997095da36802( visitedroad );
        
        if ( roadstartvehiclenode != visitedroad )
        {
            continue;
        }
        
        incomingroad = function_d3015c4a51db0aa2( visitedroad );
        
        if ( isdefined( incomingroad ) )
        {
            roadconnections = function_49a267d2538b5a6b( incomingroad );
            
            foreach ( roadconnection in roadconnections )
            {
                if ( !isdefined( var_4a1b86abd6966df[ roadconnection.index ] ) )
                {
                    var_4a1b86abd6966df[ roadconnection.index ] = roadconnection;
                    result[ result.size ] = roadconnection;
                }
            }
        }
    }
    
    return result;
}

/#

    // Namespace vehicle_roads
    // Params 1, eflags: 0x4
    // Checksum 0x22d3d353, Offset: 0x49ca
    // Size: 0xd7, Type: dev
    function private function_717e5a3dace1786d( vehiclenode )
    {
        self notify( #"hash_b37edf4eea38bba4" );
        self endon( #"hash_b37edf4eea38bba4" );
        self endon( #"death" );
        
        while ( true )
        {
            waitframe();
            debugcolor = ( 0, 0.6, 1 );
            offset = ( 0, 0, 15 );
            line( self.origin + offset, vehiclenode.origin + offset, debugcolor, 0, 0, 1 );
            sphere( vehiclenode.origin + offset, 75, debugcolor, 0, 1 );
            print3d( vehiclenode.origin + offset, "<dev string:x49e>" + vehiclenode.targetname, debugcolor, 1, 2, 1 );
        }
    }

#/

// Namespace vehicle_roads
// Params 2
// Checksum 0x4d73e7ba, Offset: 0x4aa9
// Size: 0x84
function function_256de0610be6fee1( vehiclenode, debugdraw )
{
    self notify( #"hash_de2492a6c0dc5127" );
    self endon( #"hash_de2492a6c0dc5127" );
    self endon( #"death" );
    assert( vehiclenode );
    
    /#
        if ( debugdraw )
        {
            thread function_717e5a3dace1786d( vehiclenode );
        }
    #/
    
    vehiclenode waittillmatch( #"trigger", self );
    
    /#
        if ( debugdraw )
        {
            self notify( #"hash_b37edf4eea38bba4" );
        }
    #/
    
    self.var_94e9dec930dce0a8 = vehiclenode;
}

// Namespace vehicle_roads
// Params 1
// Checksum 0x7ab034d, Offset: 0x4b35
// Size: 0x3f
function function_1d5d124423620d81( vehiclenode )
{
    self notify( #"hash_828cf1b1d9a5a72a" );
    self endon( #"hash_828cf1b1d9a5a72a" );
    function_256de0610be6fee1( vehiclenode );
    self setconfigvalue( "path", "pause", 1 );
}

// Namespace vehicle_roads
// Params 1
// Checksum 0xee3e23a8, Offset: 0x4b7c
// Size: 0x1b
function function_d5de32e196353afe( targetname )
{
    return getvehiclenode( targetname, #targetname );
}

/#

    // Namespace vehicle_roads
    // Params 4
    // Checksum 0xec612568, Offset: 0x4ba0
    // Size: 0x201, Type: dev
    function function_79aaa1cb03c55265( startnodetargetnames, var_624e3db72c1e28b, debugdraw, var_26f80580d6c058c5 )
    {
        if ( !isdefined( level.roads ) )
        {
            level.roads = [];
        }
        
        if ( !isdefined( level.var_cbffedb9ee41c670 ) )
        {
            level.var_cbffedb9ee41c670 = [];
        }
        
        if ( !isdefined( level.var_c04a3381e31d618b ) || var_624e3db72c1e28b )
        {
            level.var_c04a3381e31d618b = [];
        }
        
        if ( !isdefined( level.var_590fc06b263f99dc ) )
        {
            level.var_590fc06b263f99dc = [];
        }
        
        if ( !isdefined( level.var_2d49d8a06d62313c ) )
        {
            level.var_2d49d8a06d62313c = [];
            function_efcfd353d4a53d5b();
        }
        
        level.var_85cb7e571f2fa9ab = [];
        level.var_40c7a94c6037d9b4 = [];
        level.roadsoutput = [];
        level.connectionsoutput = [];
        uniquenamestring = getmatchstarttimeutc();
        
        if ( !uniquenamestring )
        {
            uniquenamestring = randomintrange( 1, 10000 );
        }
        
        level.floodfillfile = openfile( "<dev string:x4b1>" + level.mapname + "<dev string:x4c2>" + uniquenamestring + "<dev string:x4ca>", "<dev string:x4cf>" );
        fprintln( level.floodfillfile, "<dev string:x4d6>" );
        
        foreach ( startnodetargetname in startnodetargetnames )
        {
            function_398eef1e3adddd4f( startnodetargetname, var_624e3db72c1e28b, 0, debugdraw, var_26f80580d6c058c5 );
            waitframe();
        }
        
        function_2bdcf2c1a54ec800();
        function_a98823b5193d96e4();
        fprintln( level.floodfillfile, "<dev string:x513>" + level.var_cbffedb9ee41c670.size );
        fprintln( level.floodfillfile, "<dev string:x537>" );
        function_9425451336d717f();
        closefile( level.floodfillfile );
    }

    // Namespace vehicle_roads
    // Params 5, eflags: 0x4
    // Checksum 0x48547077, Offset: 0x4da9
    // Size: 0x10f, Type: dev
    function private function_398eef1e3adddd4f( startnodetargetname, var_624e3db72c1e28b, outputtargetname, debugdraw, var_26f80580d6c058c5 )
    {
        level notify( #"hash_73a55093b254477f" );
        
        if ( outputtargetname )
        {
            fprintln( level.floodfillfile, "<dev string:x572>" );
            fprintln( level.floodfillfile, "<dev string:x5b9>" + startnodetargetname );
        }
        
        level.recursioncount = 0;
        level.var_7a2c2c84a106e2c3 = 0;
        level.var_6779a56d21feef71 = 0;
        level.var_6287a1f1e9ba75c6 = [];
        function_f1d028a88164b0a( startnodetargetname, 0, debugdraw, var_26f80580d6c058c5 );
        
        if ( outputtargetname )
        {
            fprintln( level.floodfillfile, "<dev string:x5db>" + level.var_6779a56d21feef71 + "<dev string:x5e9>" + level.var_7a2c2c84a106e2c3 );
            fprintln( level.floodfillfile, "<dev string:x5f1>" );
        }
        
        level.recursioncount = undefined;
        level.var_7a2c2c84a106e2c3 = 0;
        level.var_6779a56d21feef71 = 0;
        level.var_6287a1f1e9ba75c6 = [];
    }

    // Namespace vehicle_roads
    // Params 0, eflags: 0x4
    // Checksum 0x53c1340b, Offset: 0x4ec0
    // Size: 0x44, Type: dev
    function private getmatchstarttimeutc()
    {
        if ( getdvarint( @"online_matchdata_enabled" ) == 0 )
        {
            return level.starttimeutcseconds;
        }
        
        return utility::callsharedfunc( #"game", #"getmatchdata", "<dev string:x636>", "<dev string:x646>" );
    }

    // Namespace vehicle_roads
    // Params 2
    // Checksum 0x8eaf2b0b, Offset: 0x4f0c
    // Size: 0x42, Type: dev
    function function_9425451336d717f( startnodetargetname, debugdraw )
    {
        level notify( #"hash_73a55093b254477f" );
        level.var_cbffedb9ee41c670 = undefined;
        level.var_c04a3381e31d618b = undefined;
        level.var_590fc06b263f99dc = undefined;
    }

    // Namespace vehicle_roads
    // Params 4, eflags: 0x4
    // Checksum 0xe2315b0e, Offset: 0x4f56
    // Size: 0x48e, Type: dev
    function private function_f1d028a88164b0a( startnodetargetname, var_9d8204c4caf4d047, debugdraw, var_26f80580d6c058c5 )
    {
        if ( isdefined( level.var_2d49d8a06d62313c ) && isdefined( function_f02c63b99c9614c9( level.var_2d49d8a06d62313c, startnodetargetname ) ) )
        {
            return;
        }
        
        splinestartnode = function_d5de32e196353afe( startnodetargetname );
        
        if ( !isdefined( splinestartnode ) )
        {
            fprintln( level.floodfillfile, "<dev string:x657>" + startnodetargetname );
            return;
        }
        
        level.var_c04a3381e31d618b[ startnodetargetname ] = level.var_c04a3381e31d618b[ startnodetargetname ] ? level.var_c04a3381e31d618b[ startnodetargetname ] + 1 : 1;
        var_ee5c3878b106067a = spawnstruct();
        function_2683d87a28296d03( startnodetargetname, var_ee5c3878b106067a );
        var_755df835f76897b0 = 0;
        
        if ( var_ee5c3878b106067a.connections.size )
        {
            assert( var_ee5c3878b106067a.connections.size <= 3 );
            connectionsstring = "<dev string:x67f>";
            
            for ( connectionindex = 0; connectionindex < var_ee5c3878b106067a.connections.size ; connectionindex++ )
            {
                if ( !var_ee5c3878b106067a.connections[ connectionindex ] )
                {
                    continue;
                }
                
                if ( connectionindex > 0 )
                {
                    connectionsstring += "<dev string:x683>";
                }
                
                connectionsstring += var_ee5c3878b106067a.connections[ connectionindex ];
            }
            
            connectionsstring += "<dev string:x688>";
            
            if ( !isdefined( level.var_cbffedb9ee41c670[ startnodetargetname ] ) )
            {
                var_755df835f76897b0++;
                level.var_cbffedb9ee41c670[ startnodetargetname ] = 1;
                fprintln( level.floodfillfile, "<dev string:x68c>" + startnodetargetname + "<dev string:x6b2>" + var_ee5c3878b106067a.var_ab3915e451d72b25 + "<dev string:x6b6>" + var_ee5c3878b106067a.endkey + "<dev string:x6b2>" + connectionsstring + "<dev string:x6ba>" );
                level.roadsoutput[ startnodetargetname ] = 1;
                
                foreach ( connectiontargetname in var_ee5c3878b106067a.connections )
                {
                    if ( connectiontargetname )
                    {
                        level.connectionsoutput = arraycombineunique( level.connectionsoutput, [ connectiontargetname ] );
                    }
                }
            }
            
            if ( debugdraw )
            {
                if ( var_26f80580d6c058c5 > 0 )
                {
                    wait var_26f80580d6c058c5;
                }
                
                level thread function_1ceeee887e2dc5e8( splinestartnode );
            }
            
            foreach ( connectionindex, connectiontargetname in var_ee5c3878b106067a.connections )
            {
                if ( !isdefined( level.var_c04a3381e31d618b[ connectiontargetname ] ) )
                {
                    var_9d8204c4caf4d047++;
                    level.recursioncount++;
                    
                    if ( var_9d8204c4caf4d047 > 50 || level.recursioncount > 50 )
                    {
                        level.var_6287a1f1e9ba75c6[ level.var_6287a1f1e9ba75c6.size ] = connectiontargetname;
                        continue;
                    }
                    
                    if ( level.recursioncount > level.var_7a2c2c84a106e2c3 )
                    {
                        level.var_7a2c2c84a106e2c3 = level.recursioncount;
                    }
                    
                    if ( var_9d8204c4caf4d047 > level.var_6779a56d21feef71 )
                    {
                        level.var_6779a56d21feef71 = var_9d8204c4caf4d047;
                    }
                    
                    if ( debugdraw )
                    {
                        if ( var_26f80580d6c058c5 > 0 )
                        {
                            wait var_26f80580d6c058c5;
                        }
                        
                        level thread function_789eebef8abc2637( splinestartnode, connectiontargetname );
                    }
                    
                    function_f1d028a88164b0a( var_ee5c3878b106067a.endkey, var_9d8204c4caf4d047, debugdraw, var_26f80580d6c058c5 );
                }
            }
        }
        else
        {
            if ( debugdraw )
            {
                if ( var_26f80580d6c058c5 > 0 )
                {
                    wait var_26f80580d6c058c5;
                }
                
                level thread function_1ceeee887e2dc5e8( splinestartnode );
            }
            
            if ( !isdefined( level.var_cbffedb9ee41c670[ startnodetargetname ] ) )
            {
                var_755df835f76897b0++;
                level.var_cbffedb9ee41c670[ startnodetargetname ] = 1;
                assert( var_ee5c3878b106067a.endkey, "<dev string:x6be>" );
                fprintln( level.floodfillfile, "<dev string:x68c>" + startnodetargetname + "<dev string:x6b2>" + var_ee5c3878b106067a.var_ab3915e451d72b25 + "<dev string:x6b6>" + var_ee5c3878b106067a.endkey + "<dev string:x6e5>" );
                level.roadsoutput[ startnodetargetname ] = 1;
            }
        }
        
        if ( var_9d8204c4caf4d047 == 0 && var_755df835f76897b0 == 0 )
        {
            level.var_590fc06b263f99dc = arraycombineunique( level.var_590fc06b263f99dc, [ startnodetargetname ] );
        }
        
        level.recursioncount--;
    }

    // Namespace vehicle_roads
    // Params 5, eflags: 0x4
    // Checksum 0x52532eae, Offset: 0x53ec
    // Size: 0x124, Type: dev
    function private function_3daa50fd657bd243( splineendnode, var_5d94e00d5687d985, var_a46673569c1678ca, var_a01c77d01d9721b5, var_99f43506d94fcbad )
    {
        result = 0;
        connectiondistancesq = length2dsquared( var_99f43506d94fcbad.origin - splineendnode.origin );
        
        if ( connectiondistancesq < 810000 )
        {
            var_c2df213a82cc675a = function_d5de32e196353afe( var_99f43506d94fcbad.target );
            connectionheading = vectornormalize2( var_c2df213a82cc675a.origin - var_99f43506d94fcbad.origin );
            var_459c03987163b47b = vectordot2( var_5d94e00d5687d985, connectionheading );
            
            if ( var_459c03987163b47b > var_a46673569c1678ca )
            {
                connectiondirection = vectornormalize2( var_99f43506d94fcbad.origin - splineendnode.origin );
                var_b56ec0f432c9e38 = vectordot2( var_5d94e00d5687d985, connectiondirection );
                
                if ( var_b56ec0f432c9e38 > var_a01c77d01d9721b5 )
                {
                    var_f13786ee5dc9bca0 = vectordot2( connectiondirection, connectionheading );
                    
                    if ( var_f13786ee5dc9bca0 > var_a01c77d01d9721b5 )
                    {
                        result = 1;
                    }
                }
            }
        }
        
        return result;
    }

    // Namespace vehicle_roads
    // Params 2, eflags: 0x4
    // Checksum 0x18c9726d, Offset: 0x5518
    // Size: 0x338, Type: dev
    function private function_2683d87a28296d03( nodetargetname, var_ee5c3878b106067a )
    {
        assert( isdefined( level.var_67119a9659b67e6d ), "<dev string:x6ea>" );
        assert( isdefined( level.var_57587d488f0edd2f ), "<dev string:x749>" );
        assert( isdefined( nodetargetname ) );
        var_ee5c3878b106067a.endkey = undefined;
        var_ee5c3878b106067a.connections = [];
        var_4ca26a6b565d1f87 = function_d5de32e196353afe( nodetargetname );
        
        if ( !isdefined( var_4ca26a6b565d1f87 ) )
        {
            assert( var_4ca26a6b565d1f87, "<dev string:x7a8>" + nodetargetname + "<dev string:x7d4>" );
            return;
        }
        
        currentvehiclenode = var_4ca26a6b565d1f87;
        prevvehiclenode = undefined;
        var_71cbdedca6019172 = 0;
        
        while ( isdefined( currentvehiclenode.target ) )
        {
            prevvehiclenode = currentvehiclenode;
            currentvehiclenode = function_d5de32e196353afe( currentvehiclenode.target );
            
            if ( prevvehiclenode )
            {
                var_71cbdedca6019172 += distance( prevvehiclenode.origin, currentvehiclenode.origin );
            }
            
            if ( currentvehiclenode.target2 || currentvehiclenode.target3 )
            {
                assert( currentvehiclenode.target, "<dev string:x7e0>" + currentvehiclenode.targetname + "<dev string:x351>" );
                connectionstartnode = function_d5de32e196353afe( currentvehiclenode.target );
                assert( connectionstartnode );
                var_ee5c3878b106067a.connections[ 0 ] = currentvehiclenode.targetname;
                
                if ( currentvehiclenode.target2 )
                {
                    assert( currentvehiclenode.target, "<dev string:x7e0>" + currentvehiclenode.targetname + "<dev string:x804>" );
                    connectionstartnode = function_d5de32e196353afe( currentvehiclenode.target2 );
                    
                    if ( connectionstartnode )
                    {
                        var_ee5c3878b106067a.connections[ 1 ] = connectionstartnode.targetname;
                    }
                    else
                    {
                        level.var_85cb7e571f2fa9ab[ level.var_85cb7e571f2fa9ab.size ] = currentvehiclenode.target2;
                    }
                }
                
                if ( currentvehiclenode.target3 )
                {
                    if ( !var_ee5c3878b106067a.connections[ 1 ] )
                    {
                        var_ee5c3878b106067a.connections[ 1 ] = undefined;
                    }
                    
                    connectionstartnode = function_d5de32e196353afe( currentvehiclenode.target3 );
                    
                    if ( connectionstartnode )
                    {
                        var_ee5c3878b106067a.connections[ 2 ] = connectionstartnode.targetname;
                    }
                    else
                    {
                        level.var_40c7a94c6037d9b4[ level.var_40c7a94c6037d9b4.size ] = currentvehiclenode.target3;
                    }
                }
                
                assert( arraycontains( level.var_67119a9659b67e6d, currentvehiclenode ) );
                break;
            }
            
            if ( arraycontains( level.var_57587d488f0edd2f, currentvehiclenode ) )
            {
                assert( currentvehiclenode.target, "<dev string:x7e0>" + currentvehiclenode.targetname + "<dev string:x804>" );
                var_ee5c3878b106067a.connections[ 0 ] = currentvehiclenode.targetname;
                break;
            }
        }
        
        var_ee5c3878b106067a.var_ab3915e451d72b25 = var_71cbdedca6019172;
        var_ee5c3878b106067a.endkey = currentvehiclenode.targetname;
    }

    // Namespace vehicle_roads
    // Params 0
    // Checksum 0x26efd87c, Offset: 0x5858
    // Size: 0xf8, Type: dev
    function function_f19bb03dc3a51efe()
    {
        allvehiclenodes = getallvehiclenodes();
        result = [];
        
        foreach ( vehiclenode in allvehiclenodes )
        {
            if ( vehiclenode.target2 && !vehiclenode.target )
            {
                result[ result.size ] = vehiclenode.targetname;
            }
            
            if ( vehiclenode.target3 && ( !vehiclenode.target2 || !vehiclenode.target ) )
            {
                result[ result.size ] = vehiclenode.targetname;
            }
        }
        
        return result;
    }

    // Namespace vehicle_roads
    // Params 0, eflags: 0x4
    // Checksum 0xb8ea3842, Offset: 0x5958
    // Size: 0x181, Type: dev
    function private function_efcfd353d4a53d5b()
    {
        allvehiclenodes = getallvehiclenodes();
        vehiclestartnodes = [];
        
        foreach ( vehiclenode in allvehiclenodes )
        {
            if ( !isdefined( vehiclenode.targetname ) || vehiclenode.spawnflags == 0 )
            {
                continue;
            }
            
            if ( isdefined( vehiclestartnodes[ vehiclenode.targetname ] ) )
            {
                vehiclestartnodes[ vehiclenode.targetname ] += 1;
                continue;
            }
            
            vehiclestartnodes[ vehiclenode.targetname ] = 1;
        }
        
        duplicatetargetnames = [];
        
        foreach ( vehiclenodetargetname, targetnamecount in vehiclestartnodes )
        {
            if ( targetnamecount > 1 )
            {
                duplicatetargetnames[ duplicatetargetnames.size ] = vehiclenodetargetname;
            }
        }
        
        if ( duplicatetargetnames.size > 0 )
        {
            level.var_2d49d8a06d62313c = duplicatetargetnames;
        }
    }

    // Namespace vehicle_roads
    // Params 0, eflags: 0x4
    // Checksum 0xe3783064, Offset: 0x5ae1
    // Size: 0xc6, Type: dev
    function private function_724071863068c117()
    {
        if ( level.var_2d49d8a06d62313c.size > 0 )
        {
            var_f954e692cd8aa19f = "<dev string:x1ec>";
            
            foreach ( index, vehiclenodetargetname in level.var_2d49d8a06d62313c )
            {
                if ( index == 0 )
                {
                    var_f954e692cd8aa19f += vehiclenodetargetname;
                    continue;
                }
                
                var_f954e692cd8aa19f += "<dev string:x821>" + vehiclenodetargetname;
            }
            
            fprintln( level.floodfillfile, "<dev string:x824>" + var_f954e692cd8aa19f );
        }
    }

    // Namespace vehicle_roads
    // Params 0, eflags: 0x4
    // Checksum 0xf5016782, Offset: 0x5baf
    // Size: 0xc6, Type: dev
    function private function_756daa27d2758d7e()
    {
        if ( level.var_6287a1f1e9ba75c6.size > 0 )
        {
            var_3862ccadd1c38270 = "<dev string:x1ec>";
            
            foreach ( index, vehiclenodetargetname in level.var_6287a1f1e9ba75c6 )
            {
                if ( index == 0 )
                {
                    var_3862ccadd1c38270 += vehiclenodetargetname;
                    continue;
                }
                
                var_3862ccadd1c38270 += "<dev string:x821>" + vehiclenodetargetname;
            }
            
            fprintln( level.floodfillfile, "<dev string:x847>" + var_3862ccadd1c38270 );
        }
    }

    // Namespace vehicle_roads
    // Params 1, eflags: 0x4
    // Checksum 0xc41c2958, Offset: 0x5c7d
    // Size: 0x111, Type: dev
    function private function_97b65653c95d883d( startnodetargetnames )
    {
        if ( startnodetargetnames && startnodetargetnames.size > 0 && level.var_590fc06b263f99dc && level.var_590fc06b263f99dc.size > 0 )
        {
            var_96c43fae8bdee0b2 = arrayremove( startnodetargetnames, level.var_590fc06b263f99dc );
            var_a5ee6d03bec1bb17 = "<dev string:x1ec>";
            
            foreach ( index, vehiclenodetargetname in var_96c43fae8bdee0b2 )
            {
                if ( index == 0 )
                {
                    var_a5ee6d03bec1bb17 += "<dev string:x873>" + vehiclenodetargetname + "<dev string:x873>";
                    continue;
                }
                
                var_a5ee6d03bec1bb17 += "<dev string:x6b6>" + vehiclenodetargetname + "<dev string:x873>";
            }
            
            fprintln( level.floodfillfile, "<dev string:x875>" + var_a5ee6d03bec1bb17 );
        }
    }

    // Namespace vehicle_roads
    // Params 0, eflags: 0x4
    // Checksum 0x26ad38bd, Offset: 0x5d96
    // Size: 0x167, Type: dev
    function private function_2bdcf2c1a54ec800()
    {
        if ( level.var_85cb7e571f2fa9ab )
        {
            invalidtargetstring = "<dev string:x1ec>";
            
            foreach ( index, invalidtarget in level.var_85cb7e571f2fa9ab )
            {
                if ( index == 0 )
                {
                    invalidtargetstring += invalidtarget;
                    continue;
                }
                
                invalidtargetstring += "<dev string:x821>" + invalidtarget;
            }
            
            fprintln( level.floodfillfile, "<dev string:x8a3>" + invalidtargetstring );
        }
        
        if ( level.var_40c7a94c6037d9b4 )
        {
            invalidtargetstring = "<dev string:x1ec>";
            
            foreach ( index, invalidtarget in level.var_40c7a94c6037d9b4 )
            {
                if ( index == 0 )
                {
                    invalidtargetstring += invalidtarget;
                    continue;
                }
                
                invalidtargetstring += "<dev string:x821>" + invalidtarget;
            }
            
            fprintln( level.floodfillfile, "<dev string:x8c4>" + invalidtargetstring );
        }
    }

    // Namespace vehicle_roads
    // Params 0, eflags: 0x4
    // Checksum 0x1b881cd8, Offset: 0x5f05
    // Size: 0x98, Type: dev
    function private function_a98823b5193d96e4()
    {
        foreach ( connectiontargetname in level.connectionsoutput )
        {
            assert( isdefined( level.roadsoutput[ connectiontargetname ] ), "<dev string:x8e5>" + connectiontargetname + "<dev string:x907>" );
        }
    }

#/

// Namespace vehicle_roads
// Params 2
// Checksum 0xf43bf067, Offset: 0x5fa5
// Size: 0x15
function function_674c4d46af7f9ea9( nodetargetname, nodeconnections )
{
    
}

/#

    // Namespace vehicle_roads
    // Params 1
    // Checksum 0x3c9e3a66, Offset: 0x5fc2
    // Size: 0x7b, Type: dev
    function function_a8f9dfdffa161ebd( nodetargetname )
    {
        convoy = "<dev string:x937>" + nodetargetname;
        single = "<dev string:x93f>" + nodetargetname;
        
        while ( !adddebugcommand( "<dev string:x947>" + nodetargetname + "<dev string:x97e>" + single + "<dev string:x997>" ) )
        {
            waitframe();
        }
        
        while ( !adddebugcommand( "<dev string:x99a>" + nodetargetname + "<dev string:x97e>" + convoy + "<dev string:x997>" ) )
        {
            waitframe();
        }
    }

    // Namespace vehicle_roads
    // Params 1
    // Checksum 0xd89fc993, Offset: 0x6045
    // Size: 0x16d, Type: dev
    function function_8437fc8203abb755( vehiclenavmeshlayer )
    {
        self endon( #"move_to_done" );
        duration = 400;
        textverticaloffset = 15;
        
        if ( utility::issp() )
        {
            var_af2b0500d15056d9 = getdvarint( @"hash_4e06d4ff70605269", 0 );
            print3d( self.origin, "<dev string:x9d1>" + var_af2b0500d15056d9, ( 1, 1, 1 ), 1, 1, duration );
        }
        
        navmeshlayer = vehiclenavmeshlayer ?? "<dev string:x9ed>";
        speedmph = undefined;
        
        if ( self hascomponent( "<dev string:x9f5>" ) )
        {
            speedmph = self function_24e10bf6894fa869( "<dev string:x9f5>", "<dev string:x9f9>" ) * 0.056818;
        }
        else if ( self hascomponent( "<dev string:xa05>" ) )
        {
            speedmph = self function_24e10bf6894fa869( "<dev string:xa09>", "<dev string:xa0e>" ) * 0.056818;
        }
        
        bg_vehcheckp2pgoalinturningcircle = getdvarint( @"bg_vehcheckp2pgoalinturningcircle", 1 );
        print3d( self.origin + ( 0, 0, textverticaloffset * 3 ), "<dev string:xa1a>" + navmeshlayer + "<dev string:xa28>" + speedmph, ( 1, 1, 1 ), 1, 1, duration );
        print3d( self.origin + ( 0, 0, textverticaloffset ), "<dev string:xa30>" + bg_vehcheckp2pgoalinturningcircle, ( 1, 1, 1 ), 1, 1, duration );
    }

    // Namespace vehicle_roads
    // Params 2
    // Checksum 0x323c9c91, Offset: 0x61ba
    // Size: 0xa6, Type: dev
    function function_2b723e6a5a86a006( splinepoints, pathcolor )
    {
        self notify( #"hash_1933fd9241aff0d4" );
        self endon( #"hash_1933fd9241aff0d4" );
        self endon( #"death" );
        self endon( #"move_to_done" );
        
        while ( true )
        {
            waitframe();
            sphere( splinepoints[ 0 ], 5, pathcolor, 0, 1 );
            
            if ( !isdefined( pathcolor ) )
            {
                pathcolor = ( 1, 1, 1 );
            }
            
            for ( index = 1; index < splinepoints.size ; index++ )
            {
                line( splinepoints[ index - 1 ], splinepoints[ index ], pathcolor, 1, 0, 1 );
            }
        }
    }

    // Namespace vehicle_roads
    // Params 0
    // Checksum 0x18ef0ddb, Offset: 0x6268
    // Size: 0x83, Type: dev
    function function_38bcfc0e39bb2fda()
    {
        self notify( #"hash_7b6c4843152ed407" );
        self endon( #"hash_7b6c4843152ed407" );
        self endon( #"hash_d7056bc06e2742c0" );
        self endon( #"death" );
        
        while ( true )
        {
            waitframe();
            line( self.origin + ( 0, 0, 200 ), self.origin + ( 0, 0, 2048 ), ( 1, 0, 0 ), 1, 0, 1 );
        }
    }

    // Namespace vehicle_roads
    // Params 3
    // Checksum 0x4217cc4a, Offset: 0x62f3
    // Size: 0x23d, Type: dev
    function function_ccc37c74c8357da7( roadnetworkpath, startnodetargetname, goalnodetargetname )
    {
        if ( !isdefined( startnodetargetname ) )
        {
            startnodetargetname = undefined;
        }
        
        if ( !isdefined( goalnodetargetname ) )
        {
            goalnodetargetname = undefined;
        }
        
        self notify( #"hash_d7056bc06e2742c0" );
        self endon( #"hash_d7056bc06e2742c0" );
        self endon( #"death" );
        var_ffa77065c35c927f = 10;
        waitduration = max( var_ffa77065c35c927f - 1, 1 ) * 0.05;
        var_553d47d9b2d39dda = 1;
        pathoffset = ( 0, 0, 100 );
        pathcolor = ( 1, 1, 0 );
        var_157569322bb6e6e3 = ( 1, 0.6, 0 );
        var_ff68e9c956b2641a = 0;
        
        if ( isstruct( roadnetworkpath[ 0 ] ) )
        {
            var_ff68e9c956b2641a = 1;
        }
        
        var_8f1dec650367794c = roadnetworkpath.size - 1;
        
        if ( roadnetworkpath.size > 1 && isstruct( roadnetworkpath[ var_8f1dec650367794c ] ) )
        {
            var_8f1dec650367794c = roadnetworkpath.size - 2;
        }
        
        if ( vehicle::is_vehicle() )
        {
            thread function_38bcfc0e39bb2fda();
        }
        
        while ( true )
        {
            wait waitduration;
            
            for ( roadindex = 0; roadindex < roadnetworkpath.size ; roadindex++ )
            {
                roadstartvehiclenode = roadnetworkpath[ roadindex ];
                
                if ( isstruct( roadstartvehiclenode ) )
                {
                    continue;
                }
                
                if ( roadstartvehiclenode.target )
                {
                    print3d( roadstartvehiclenode.origin + pathoffset, "<dev string:x1ec>" + roadindex, ( 1, 1, 1 ), 1, 2, var_ffa77065c35c927f );
                    var_cecf37e3ecc94c97 = function_57751e07f57fd60b( roadstartvehiclenode );
                    
                    if ( startnodetargetname && roadindex == var_ff68e9c956b2641a && roadstartvehiclenode.targetname != startnodetargetname )
                    {
                        function_e8fff5ff35e19e5e( roadstartvehiclenode, var_cecf37e3ecc94c97.targetname, [], 0, pathoffset, pathcolor, var_ffa77065c35c927f, var_553d47d9b2d39dda, startnodetargetname, goalnodetargetname, var_157569322bb6e6e3 );
                        continue;
                    }
                    
                    if ( goalnodetargetname && roadindex == var_8f1dec650367794c )
                    {
                        function_e8fff5ff35e19e5e( roadstartvehiclenode, var_cecf37e3ecc94c97.targetname, [], 0, pathoffset, pathcolor, var_ffa77065c35c927f, var_553d47d9b2d39dda, undefined, goalnodetargetname, var_157569322bb6e6e3 );
                        continue;
                    }
                    
                    function_e8fff5ff35e19e5e( roadstartvehiclenode, var_cecf37e3ecc94c97.targetname, [], 0, pathoffset, pathcolor, var_ffa77065c35c927f, var_553d47d9b2d39dda );
                }
            }
        }
    }

    // Namespace vehicle_roads
    // Params 3
    // Checksum 0x39842a7e, Offset: 0x6538
    // Size: 0x2b6, Type: dev
    function function_46e7fc115379abb2( speedmph, vehiclenavmeshlayer, debugdraw )
    {
        self notify( #"hash_3f6ceb78febfb388" );
        self endon( #"hash_3f6ceb78febfb388" );
        self endon( #"death" );
        minradius = 500;
        maxradius = 1200;
        var_1d748eca4605b943 = 150;
        var_9e106aa74effb825 = 1500;
        var_30459f336f7c69d = 4000;
        
        while ( true )
        {
            enemy = level.players[ 0 ];
            
            if ( !isdefined( enemy ) )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( self.attackpoint ) )
            {
                tacpoint = function_5a577f4e6e89a130( enemy.origin, enemy.origin, minradius, maxradius, var_1d748eca4605b943 );
                
                if ( !isdefined( tacpoint ) )
                {
                    wait 1;
                    continue;
                }
                else
                {
                    self.attackpoint = tacpoint.origin;
                }
            }
            
            if ( debugdraw )
            {
                line( self.attackpoint, self.origin, ( 0, 1, 0 ), 1, 0, 100 );
                sphere( self.attackpoint, 15, ( 0, 1, 0 ), 1, 100 );
            }
            
            function_123852fba4d3e231( self.attackpoint, speedmph, vehiclenavmeshlayer, undefined, debugdraw );
            self.enemyvisibletime = gettime();
            
            while ( true )
            {
                waitframe();
                attackpointdistance = distance2d( enemy.origin, self.attackpoint );
                
                if ( attackpointdistance > var_9e106aa74effb825 )
                {
                    self.attackpoint = undefined;
                    break;
                }
                
                trace = trace::ray_trace( self.origin, enemy getcentroid(), self );
                
                if ( debugdraw )
                {
                    visible = trace[ "<dev string:xa53>" ] == "<dev string:xa5b>" && trace[ "<dev string:xa6a>" ] == enemy;
                    color = visible ? ( 1, 1, 0 ) : ( 1, 0, 0 );
                    line( enemy getcentroid(), self.origin, color, 1, 0, 1 );
                    print3d( self.origin, string( attackpointdistance ), color, 1, 1, 1 );
                }
                
                if ( trace[ "<dev string:xa53>" ] == "<dev string:xa5b>" && trace[ "<dev string:xa6a>" ] == enemy )
                {
                    self.enemyvisibletime = gettime();
                    continue;
                }
                
                if ( gettime() - self.enemyvisibletime > var_30459f336f7c69d )
                {
                    self.attackpoint = undefined;
                    break;
                }
            }
        }
    }

    // Namespace vehicle_roads
    // Params 1, eflags: 0x4
    // Checksum 0x1f6826f9, Offset: 0x67f6
    // Size: 0x24, Type: dev
    function private function_1ceeee887e2dc5e8( vehiclenode )
    {
        level endon( #"hash_73a55093b254477f" );
        
        while ( true )
        {
            waitframe();
        }
    }

    // Namespace vehicle_roads
    // Params 2, eflags: 0x4
    // Checksum 0x2be9c761, Offset: 0x6822
    // Size: 0xd1, Type: dev
    function private function_789eebef8abc2637( splinestartnode, connectiontargetname )
    {
        level endon( #"hash_73a55093b254477f" );
        
        for ( nextnode = function_d5de32e196353afe( splinestartnode.target ); splinestartnode != nextnode ; nextnode = function_d5de32e196353afe( nextnode.target ) )
        {
            if ( !isdefined( nextnode.target ) )
            {
                break;
            }
        }
        
        connectionnode = function_d5de32e196353afe( connectiontargetname );
        offset = ( 0, 0, 100 );
        
        while ( true )
        {
            waitframe();
            line( nextnode.origin + offset, connectionnode.origin + offset, ( 1, 1, 0 ) );
        }
    }

    // Namespace vehicle_roads
    // Params 2, eflags: 0x4
    // Checksum 0xe6592434, Offset: 0x68fb
    // Size: 0xf4, Type: dev
    function private function_616bf91eeeb73a1a( var_99c5468695fe38ac, endroads )
    {
        assert( level.roads[ var_99c5468695fe38ac ] );
        result = [];
        result[ result.size ] = var_99c5468695fe38ac;
        
        foreach ( connection in level.roads[ var_99c5468695fe38ac ].connections ?? [] )
        {
            if ( arraycontains( endroads, connection ) )
            {
                continue;
            }
            
            assert( level.roads[ connection ] );
            result = arraycombine( result, function_616bf91eeeb73a1a( connection, endroads ) );
        }
        
        return result;
    }

    // Namespace vehicle_roads
    // Params 2
    // Checksum 0x7d998fd2, Offset: 0x69f7
    // Size: 0x215, Type: dev
    function walk_roads( var_9cac7d3f0b728b81, endroads )
    {
        assert( isdefined( level.roads ) );
        result = [];
        
        foreach ( var_99c5468695fe38ac in var_9cac7d3f0b728b81 )
        {
            result = arraycombine( result, function_616bf91eeeb73a1a( var_99c5468695fe38ac, endroads ) );
        }
        
        result = arrayremoveduplicates( result );
        uniquenamestring = getmatchstarttimeutc();
        
        if ( !uniquenamestring )
        {
            uniquenamestring = randomintrange( 1, 10000 );
        }
        
        level.floodfillfile = openfile( "<dev string:x4b1>" + level.mapname + "<dev string:xa71>" + uniquenamestring + "<dev string:x4ca>", "<dev string:x4cf>" );
        fprintln( level.floodfillfile, "<dev string:xa80>" );
        
        if ( result.size > 0 )
        {
            roads = "<dev string:x1ec>";
            
            foreach ( roadindex, roadtargetname in result )
            {
                if ( roadindex == result.size - 1 )
                {
                    roads = roads + "<dev string:x873>" + roadtargetname + "<dev string:x997>";
                    continue;
                }
                
                roads = roads + "<dev string:x873>" + roadtargetname + "<dev string:xaaf>";
            }
            
            fprintln( level.floodfillfile, roads );
        }
        
        fprintln( level.floodfillfile, "<dev string:x513>" + result.size );
        fprintln( level.floodfillfile, "<dev string:xab3>" );
        closefile( level.floodfillfile );
    }

    // Namespace vehicle_roads
    // Params 1, eflags: 0x4
    // Checksum 0x1ba1f9c, Offset: 0x6c14
    // Size: 0x16b, Type: dev
    function private function_c0237c77838fe9cc( selectedvehiclenode )
    {
        level notify( #"hash_5215b09704e0f4b7" );
        level endon( #"hash_5215b09704e0f4b7" );
        assert( selectedvehiclenode );
        debugcolor = ( 1, 0.65, 0 );
        debugoffset = ( 0, 0, 15 );
        nextvehiclenode = undefined;
        nodeheading = undefined;
        roadstartnode = function_b38997095da36802( selectedvehiclenode );
        waitdurationframes = 10;
        waitdurationseconds = waitdurationframes / 20;
        
        if ( selectedvehiclenode.target )
        {
            nextvehiclenode = getvehiclenode( selectedvehiclenode.target, #targetname );
            nodeheading = vectornormalize( nextvehiclenode.origin - selectedvehiclenode.origin );
        }
        
        while ( true )
        {
            wait waitdurationseconds;
            print3d( selectedvehiclenode.origin + debugoffset, "<dev string:x1ec>" + roadstartnode.targetname, debugcolor, 1, 3, waitdurationframes );
            sphere( selectedvehiclenode.origin, 175, debugcolor, 0, waitdurationframes );
            
            if ( nodeheading )
            {
                utility::draw_arrow( selectedvehiclenode.origin + debugoffset, selectedvehiclenode.origin + debugoffset + nodeheading * 500, debugcolor, 100, 0, waitdurationframes );
            }
        }
    }

    // Namespace vehicle_roads
    // Params 0
    // Checksum 0x4caa34c4, Offset: 0x6d87
    // Size: 0xc9, Type: dev
    function function_57a84daa7ba90219()
    {
        player = level.players[ 0 ];
        playerangles = player getplayerangles();
        playerforward = anglestoforward( playerangles );
        playereyelocation = player geteye();
        traceendlocation = playereyelocation + playerforward * 5000;
        traceresults = trace::ray_trace( playereyelocation, traceendlocation, player );
        
        if ( isdefined( traceresults ) )
        {
            traceendlocation = traceresults[ "<dev string:xae0>" ];
        }
        
        [ closestvehiclenode, _ ] = get_closest_vehicle_node( traceendlocation );
        
        if ( closestvehiclenode )
        {
            level.selectedvehiclenode = closestvehiclenode;
            level thread function_c0237c77838fe9cc( closestvehiclenode );
        }
    }

#/

// Namespace vehicle_roads
// Params 2
// Checksum 0x8acb557b, Offset: 0x6e58
// Size: 0x55
function function_2f9545121ae770f2( var_4ca26a6b565d1f87, loopnode )
{
    slow = var_4ca26a6b565d1f87;
    
    while ( slow != loopnode )
    {
        slow = function_d5de32e196353afe( slow.target );
        loopnode = function_d5de32e196353afe( loopnode.target );
    }
    
    return slow;
}

// Namespace vehicle_roads
// Params 4
// Checksum 0x49eea1b9, Offset: 0x6eb6
// Size: 0xc3
function function_9149142c3ccf24ac( nodetargetname, var_ab3915e451d72b25, endnodetargetname, nodeconnections )
{
    result = function_b0aef4b7eb39711d( nodetargetname, var_ab3915e451d72b25, endnodetargetname, nodeconnections );
    
    if ( !result )
    {
        if ( !level.var_8e5c044493d1c528 )
        {
            level.var_8e5c044493d1c528 = 0;
        }
        
        level.var_8e5c044493d1c528++;
        println( "<dev string:xae9>" + nodetargetname + "<dev string:xb2b>" + var_ab3915e451d72b25 + "<dev string:xb3f>" + endnodetargetname + "<dev string:xb53>" + nodeconnections + "<dev string:xb65>" + level.var_8e5c044493d1c528 );
        return;
    }
    
    if ( !level.var_a8f48cdbb80c3131 )
    {
        level.var_a8f48cdbb80c3131 = 0;
    }
    
    level.var_a8f48cdbb80c3131++;
}

/#

    // Namespace vehicle_roads
    // Params 11
    // Checksum 0x667bffc6, Offset: 0x6f81
    // Size: 0x484, Type: dev
    function function_e8fff5ff35e19e5e( startnode, endkey, connections, var_e1b83da6b2b72321, nodeoffset, roadcolor, var_ffa77065c35c927f, var_553d47d9b2d39dda, var_4fd2ba081528d08e, var_4fd2b9081528ce5b, var_dfbdb69003a1b65d )
    {
        assert( isdefined( startnode ) );
        assert( isdefined( endkey ) );
        
        if ( !isdefined( var_ffa77065c35c927f ) )
        {
            var_ffa77065c35c927f = 1;
        }
        
        if ( !isdefined( var_553d47d9b2d39dda ) )
        {
            var_553d47d9b2d39dda = 1;
        }
        
        var_553d47d9b2d39dda = min( 1, var_553d47d9b2d39dda );
        previousnode = startnode;
        nextnode = undefined;
        nodeindex = 0;
        var_792739c70ea7c028 = isdefined( var_4fd2ba081528d08e ) ? var_dfbdb69003a1b65d : roadcolor;
        
        if ( !isdefined( startnode.target ) )
        {
            return;
        }
        
        if ( var_e1b83da6b2b72321 && isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].origin ) && distancesquared( startnode.origin, level.players[ 0 ].origin ) < 9000000 )
        {
            print3d( startnode.origin + ( 0, 0, 10 ), startnode.targetname, ( 1, 1, 1 ), 1, 3, var_ffa77065c35c927f );
        }
        
        nextnode = function_d5de32e196353afe( startnode.target );
        
        while ( true )
        {
            if ( !isdefined( nextnode ) )
            {
                break;
            }
            
            if ( nextnode.targetname == endkey )
            {
                additionaloffset = ( 0, 0, 15 );
                line( previousnode.origin + nodeoffset, nextnode.origin + nodeoffset + additionaloffset, var_792739c70ea7c028, 1, 0, var_ffa77065c35c927f );
                break;
            }
            else
            {
                line( previousnode.origin + nodeoffset, nextnode.origin + nodeoffset, var_792739c70ea7c028, 1, 0, var_ffa77065c35c927f );
            }
            
            previousnode = nextnode;
            
            for ( numsteps = 0; numsteps < var_553d47d9b2d39dda ; numsteps++ )
            {
                if ( !isdefined( nextnode.target ) )
                {
                    break;
                }
                
                nextnode = function_d5de32e196353afe( nextnode.target );
            }
            
            if ( var_4fd2ba081528d08e && previousnode.targetname == var_4fd2ba081528d08e )
            {
                var_792739c70ea7c028 = roadcolor;
            }
            else if ( var_4fd2b9081528ce5b && previousnode.targetname == var_4fd2b9081528ce5b )
            {
                var_792739c70ea7c028 = var_dfbdb69003a1b65d;
            }
            
            nodeindex++;
        }
        
        foreach ( connectionindex, connection in connections )
        {
            var_4ec531501ff3f3a9 = 45;
            var_6499ad7e486f9e81 = 512;
            
            if ( !isdefined( connection ) )
            {
                continue;
            }
            
            switch ( connectionindex )
            {
                case 0:
                    segmentcolor = ( 0.74, 0.46, 0.96 );
                    line( nextnode.origin + nodeoffset, nextnode.origin + nodeoffset + ( var_4ec531501ff3f3a9, var_4ec531501ff3f3a9, var_6499ad7e486f9e81 ), segmentcolor, 1, 0, var_ffa77065c35c927f );
                    break;
                case 1:
                    segmentcolor = ( 1, 0.65, 0 );
                    line( nextnode.origin + nodeoffset, nextnode.origin + nodeoffset + ( 0, var_4ec531501ff3f3a9, var_6499ad7e486f9e81 ), segmentcolor, 1, 0, var_ffa77065c35c927f );
                    break;
                case 2:
                    segmentcolor = ( 0, 0, 1 );
                    line( nextnode.origin + nodeoffset, nextnode.origin + nodeoffset + ( var_4ec531501ff3f3a9, 0, var_6499ad7e486f9e81 ), segmentcolor, 1, 0, var_ffa77065c35c927f );
                    break;
                default:
                    break;
            }
            
            connectionnode = function_d5de32e196353afe( connection );
            assert( connectionnode );
            
            if ( connectionnode != nextnode )
            {
                line( nextnode.origin + nodeoffset, connectionnode.origin + nodeoffset + additionaloffset, segmentcolor, 1, 0, var_ffa77065c35c927f );
            }
        }
        
        return nextnode;
    }

    // Namespace vehicle_roads
    // Params 0
    // Checksum 0xb95eeed7, Offset: 0x740d
    // Size: 0x109, Type: dev
    function get_visible_roads()
    {
        result = [];
        
        if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].origin ) )
        {
            var_24c6fc67f7ee43f2 = function_98191bf615bc9f9d();
            
            for ( var_cd632c3763d509 = 0; var_cd632c3763d509 < var_24c6fc67f7ee43f2 ; var_cd632c3763d509++ )
            {
                roadstartvehiclenode = function_48cdf1302e1ec131( var_cd632c3763d509 );
                
                if ( distancesquared( roadstartvehiclenode.origin, level.players[ 0 ].origin ) < 9000000 )
                {
                    playerforward = anglestoforward( level.players[ 0 ].angles );
                    var_8da607933109e696 = roadstartvehiclenode.origin - level.players[ 0 ].origin;
                    
                    if ( vectordot( playerforward, var_8da607933109e696 ) > 0 )
                    {
                        if ( !isdefined( result ) )
                        {
                            result = [];
                        }
                        
                        result[ result.size ] = roadstartvehiclenode;
                    }
                }
            }
        }
        
        return result;
    }

    // Namespace vehicle_roads
    // Params 0
    // Checksum 0x2758a450, Offset: 0x751e
    // Size: 0x15b, Type: dev
    function function_a47621f2c35dda6()
    {
        result = [];
        
        if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].origin ) )
        {
            if ( !level.allvehiclenodes )
            {
                level.allvehiclenodes = getallvehiclenodes();
            }
            
            foreach ( vehiclenode in level.allvehiclenodes )
            {
                if ( distancesquared( vehiclenode.origin, level.players[ 0 ].origin ) < 9000000 )
                {
                    playerforward = anglestoforward( level.players[ 0 ].angles );
                    var_acdca994d5c4ff0a = vehiclenode.origin - level.players[ 0 ].origin;
                    
                    if ( vectordot( playerforward, var_acdca994d5c4ff0a ) > 0 )
                    {
                        if ( !isdefined( result ) )
                        {
                            result = [];
                        }
                        
                        result[ result.size ] = vehiclenode;
                    }
                }
            }
        }
        
        return result;
    }

    // Namespace vehicle_roads
    // Params 1
    // Checksum 0x28937cc5, Offset: 0x7681
    // Size: 0x398, Type: dev
    function function_c126d9b5dec4bc58( debugdraw )
    {
        if ( level.var_7a244f0b785880cc )
        {
            return;
        }
        
        level.var_7a244f0b785880cc = 1;
        contents = physics_createcontents( [ "<dev string:xb77>", "<dev string:xb8c>", "<dev string:xba2>", "<dev string:xbbe>" ] );
        ignore = vehicle_tracking::function_5820a38c9873992e();
        var_9fded531b6b153d2 = 0.5;
        caststhisframe = 0;
        roadschecked = 0;
        var_51511756ad2e586c = 0;
        var_24c6fc67f7ee43f2 = function_98191bf615bc9f9d();
        
        for ( var_cd632c3763d509 = 0; var_cd632c3763d509 < var_24c6fc67f7ee43f2 ; var_cd632c3763d509++ )
        {
            waitframe();
            roadstartvehiclenode = function_48cdf1302e1ec131( var_cd632c3763d509 );
            var_cecf37e3ecc94c97 = function_57751e07f57fd60b( roadstartvehiclenode );
            splinepoints = [];
            println( "<dev string:xbd9>" + roadstartvehiclenode.targetname + "<dev string:x1ed>" + roadstartvehiclenode.index + "<dev string:xc0c>" + var_cecf37e3ecc94c97.targetname + "<dev string:x1ed>" + var_cecf37e3ecc94c97.index + "<dev string:xc16>" + roadschecked );
            splinepoints = function_6e66ddd10a3001b8( var_9fded531b6b153d2, roadstartvehiclenode.index, var_cecf37e3ecc94c97.index );
            roadschecked++;
            
            if ( splinepoints.size >= 2 )
            {
                if ( debugdraw )
                {
                    debugduration = 60;
                    line( level.players[ 0 ] getcentroid(), splinepoints[ 0 ], ( 1, 1, 0 ), 1, 0, debugduration );
                    
                    for ( pointindex = 1; pointindex < splinepoints.size ; pointindex++ )
                    {
                        line( splinepoints[ pointindex ], splinepoints[ pointindex ] + ( 0, 0, 100 ), ( 1, 1, 0 ), 1, 0, debugduration );
                        line( splinepoints[ pointindex - 1 ], splinepoints[ pointindex ], ( 1, 1, 0 ), 1, 0, debugduration );
                    }
                    
                    wait debugduration / 20;
                }
                
                if ( splinepoints.size >= 1000 )
                {
                    var_51511756ad2e586c++;
                    continue;
                }
                
                for ( pointindex = 1; pointindex < splinepoints.size ; pointindex++ )
                {
                    var_95bc5806ec9e7bd4 = utility::drop_to_ground( splinepoints[ pointindex - 1 ], 200 ) + ( 0, 0, 125 );
                    var_95bc5b06ec9e826d = utility::drop_to_ground( splinepoints[ pointindex ], 200 ) + ( 0, 0, 125 );
                    
                    if ( distance( splinepoints[ pointindex - 1 ], var_95bc5806ec9e7bd4 ) > 5000 || distance( splinepoints[ pointindex ], var_95bc5b06ec9e826d ) > 5000 )
                    {
                        continue;
                    }
                    
                    cast = physics_spherecast( var_95bc5806ec9e7bd4, var_95bc5b06ec9e826d, 50, contents, ignore, "<dev string:xc25>", "<dev string:xc3a>", 1 );
                    
                    if ( cast.size > 0 && isdefined( cast[ 0 ][ 0 ][ "<dev string:xae0>" ] ) )
                    {
                        println( "<dev string:xc4b>" + cast[ 0 ][ 0 ][ "<dev string:xae0>" ] );
                        line( var_95bc5806ec9e7bd4, var_95bc5b06ec9e826d, ( 1, 0, 0 ), 1, 0, 100000 );
                        sphere( cast[ 0 ][ 0 ][ "<dev string:xae0>" ], 20, ( 1, 0, 0 ), 0, 100000 );
                    }
                    else
                    {
                        line( var_95bc5806ec9e7bd4, var_95bc5b06ec9e826d, ( 0, 1, 0 ), 1, 0, 100000 );
                    }
                    
                    caststhisframe += 1;
                    
                    if ( caststhisframe >= 50 )
                    {
                        waitframe();
                        caststhisframe = 0;
                    }
                }
            }
        }
        
        println( "<dev string:xc74>" + roadschecked + "<dev string:xcaa>" + var_51511756ad2e586c );
        level.var_7a244f0b785880cc = undefined;
    }

#/
