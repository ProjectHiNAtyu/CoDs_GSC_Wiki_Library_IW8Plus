// scripts\mp\ai_vehicle_patrol.gsc  (hash_2b736eb3fdd9b328.gscc) (size: 22072 Bytes / 0x5638 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8067d62a (2154288682)
// size ...... 22072 (0x5638)
// includes .. 12  (offset: 0x52f0)
// strings ... 32  (offset: 0x5350)
// dev strs .. 19  (offset: 0x5548)
// exports ... 30  (offset: 0x3c28)
// cseg ...... 0x2d8 + 0x3950 (0x3c28)
// imports ... 140 (offset: 0x40d8)
// animtree1 . 0   (offset: 0x5638)
// animtree2 . 0   (offset: 0x5638)
#using scripts\common\ai\stealth\enemy;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_spawn;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\common\utility\debug_utility;

#namespace ai_vehicle_patrol;

// Namespace ai_vehicle_patrol
// Params 0, eflags: 0x5
// Checksum 0xfd284219, Offset: 0x2f6
// Size: 0xe4
function private autoexec init()
{
    if ( !getmatchrulesdata( "commonOption", "spawnVehiclePatrols" ) || getdvarint( @"hash_48d451af806ed83b", 0 ) )
    {
        return;
    }
    
    level.var_d444ccbc31b10404 = 0;
    ai_mp_controller::function_7f833bacb64445a6();
    utility::flag_wait( "create_script_initialized" );
    level.var_a5ea289ea9ded60c = false ? -1 : getmatchrulesdata( "commonOption", "vehiclePatrolSpeed" );
    gatherpaths();
    utility::registersharedfunc( #"ai_vehicle_patrol", #"hash_5b711cc54847d209", &function_e4745fcb65df2ff2 );
    
    /#
        utility::registersharedfunc( #"ai_vehicle_patrol", #"hash_c5d89b49f446b1db", &function_c9f230bf8fb77ac8 );
        level thread function_655bc52b25fdc81c();
    #/
    
    if ( isdefined( level.var_c4303b727f0cc395 ) )
    {
        [[ level.var_c4303b727f0cc395 ]]();
    }
    
    level thread function_ec3e0bbec2c49b50();
    level.var_a3233307a29234c2 = [];
    function_1e61f19f79b19981();
}

// Namespace ai_vehicle_patrol
// Params 0, eflags: 0x4
// Checksum 0x10e71f02, Offset: 0x3e2
// Size: 0x296
function private gatherpaths()
{
    pathnodes = utility::getstructarray( "vehicle_patrol_node", "script_noteworthy" );
    var_9c51715ac8fd765d = getdvarint( @"hash_9314fc4383c54041", 1 ) == 1;
    level.var_597ee951f620c8 = [];
    level.var_ad62714a6a03c370 = [];
    
    foreach ( node in pathnodes )
    {
        if ( node.processed )
        {
            continue;
        }
        
        pathstruct = ai_mp_controller::function_ad7994ce0f8a6d54( node, undefined, "vehicle_patrol_node" );
        function_f31f29a4f8db7341( pathstruct.path );
        
        foreach ( node in pathstruct.path )
        {
            if ( var_9c51715ac8fd765d && !isdefined( node.node_behavior ) )
            {
                goalorigin = node.origin;
                
                if ( !isdefined( level.vehiclenodes ) )
                {
                    level.vehiclenodes = utility::create_partition( getallvehiclenodes(), 3500, 1 );
                }
                
                var_ae98ea54b5bb34da = level.vehiclenodes utility::function_822c5feaca90abc1( goalorigin, 1000 );
                var_ae98ea54b5bb34da = sortbydistance( var_ae98ea54b5bb34da, goalorigin );
                
                for ( nodeindex = 0; nodeindex < var_ae98ea54b5bb34da.size ; nodeindex++ )
                {
                    if ( level.roads[ var_ae98ea54b5bb34da[ nodeindex ].targetname ] )
                    {
                        continue;
                    }
                    
                    node.goalvehiclenode = var_ae98ea54b5bb34da[ nodeindex ];
                    break;
                }
            }
            
            node.processed = 1;
        }
        
        if ( pathstruct.path[ 0 ].script_parameters == "tank" )
        {
            level.var_ad62714a6a03c370[ level.var_ad62714a6a03c370.size ] = pathstruct;
            continue;
        }
        
        level.var_597ee951f620c8[ level.var_597ee951f620c8.size ] = pathstruct;
    }
    
    /#
        if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
        {
            level thread debugshowpaths();
        }
    #/
}

// Namespace ai_vehicle_patrol
// Params 0, eflags: 0x4
// Checksum 0xb240d70e, Offset: 0x680
// Size: 0x411
function private function_ec3e0bbec2c49b50()
{
    utility::flag_wait( "road_network_built" );
    
    if ( getdvarint( @"hash_8afbce1868ddb1ab", 1 ) == 1 && -1 )
    {
        /#
            foreach ( patrolindex, patrolpath in level.var_597ee951f620c8 )
            {
                patrolpath.patrolindex = patrolindex;
            }
        #/
        
        level.var_597ee951f620c8 = arrayrandomize( level.var_597ee951f620c8 );
    }
    
    foreach ( index, pathstruct in level.var_597ee951f620c8 )
    {
        if ( !pathstruct || index >= getdvarint( @"scr_vehicle_patrol_count", 8 ) && -1 )
        {
            break;
        }
        
        /#
            if ( 0 && -1 < level.var_597ee951f620c8.size && index != -1 )
            {
                continue;
            }
        #/
        
        function_92b7d5474bc1628e( pathstruct, utility::array_random( [ %"hash_589e54b7d4954c7", %"hash_59c4340860e0302a", %"hash_66be4f4ee63df510" ] ), level.var_a5ea289ea9ded60c );
    }
    
    var_7c03b101fe77ce59 = getdvarint( @"hash_1b6959c2a405de02", 3 );
    
    if ( var_7c03b101fe77ce59 > 0 )
    {
        var_97058bc77aaef54b = randomint( var_7c03b101fe77ce59 ) + 1;
        
        foreach ( index, pathstruct in level.var_ad62714a6a03c370 )
        {
            if ( !pathstruct || index >= var_97058bc77aaef54b )
            {
                break;
            }
            
            function_92b7d5474bc1628e( pathstruct, %"hash_69b25f1253af2c6b", 10 );
        }
    }
    
    var_b3a007c448f9a9c3 = true ? getdvarint( @"hash_a16103b825a3cb35", 10 ) : 0;
    
    if ( var_b3a007c448f9a9c3 <= 0 )
    {
        return;
    }
    
    var_ddfcdb502301411 = 0;
    vehicle_roads::init_vehicle_node_partition();
    var_fdbe7ea2d566668f = arrayrandomize( level.vehiclenodes utility::function_67292ed50d12c006() );
    i = 0;
    
    while ( var_ddfcdb502301411 < var_b3a007c448f9a9c3 && i < var_fdbe7ea2d566668f.size )
    {
        vehiclenodearray = arrayrandomize( var_fdbe7ea2d566668f[ i ] );
        i += 1;
        
        foreach ( vehiclenode in vehiclenodearray )
        {
            if ( vehiclenode.script_parameters == "infil_area" )
            {
                continue;
            }
            
            roadstartvehiclenode = function_b38997095da36802( vehiclenode );
            
            if ( !roadstartvehiclenode || !function_37a7168921a87467( roadstartvehiclenode ) )
            {
                continue;
            }
            
            vehicle = utility::array_random( [ %"hash_589e54b7d4954c7", %"hash_59c4340860e0302a", %"hash_66be4f4ee63df510" ] );
            
            if ( !vehicle_spawn::function_c49e68f891a06e6f( vehiclenode.origin, vehicle ) )
            {
                continue;
            }
            
            function_5b3313bc8b2069e( vehiclenode, roadstartvehiclenode.targetname, vehicle );
            var_ddfcdb502301411 += 1;
            break;
        }
    }
}

// Namespace ai_vehicle_patrol
// Params 3, eflags: 0x4
// Checksum 0x908de551, Offset: 0xa99
// Size: 0x144
function private function_5b3313bc8b2069e( vehiclenode, var_4e929e6a688742de, vehiclebundle )
{
    if ( !vehicle::is_loaded( vehiclebundle ) )
    {
        return;
    }
    
    vehicle = spawnpatrol( vehiclenode.origin, vehiclenode.angles, 1, vehiclebundle );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle.dontunloadonend = 1;
    var_5021df98f73d2050 = getdvarint( @"hash_24cfee9a4aea8368", 1 ) == 1;
    vehicle vehicle_roads::function_b5bd79b51773c046( !var_5021df98f73d2050, 0, 1, vehicle vehicle::is_tank() ? 0 : 31 );
    
    if ( !var_5021df98f73d2050 )
    {
        vehicle setconfigvalue( "p2p", "stuckTime", 2 );
        vehicle setconfigvalue( "p2p", "reverseForBehindGoal", 0 );
        vehicle setconfigvalue( "p2p", "stuckForcedReverseTime", 1 );
        vehicle setconfigvalue( "p2p", "reverseGasWhileStuck", 0.3 );
    }
    
    vehicle thread function_e4745fcb65df2ff2( level.var_a5ea289ea9ded60c, undefined, undefined, var_4e929e6a688742de, vehiclenode.targetname );
    
    /#
        if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 && 1 )
        {
            vehicle thread function_c69a55f721c0fb13();
        }
    #/
}

// Namespace ai_vehicle_patrol
// Params 3, eflags: 0x4
// Checksum 0xfa871e85, Offset: 0xbe5
// Size: 0x36a
function private function_92b7d5474bc1628e( pathdata, vehiclebundle, speed )
{
    if ( !vehicle::is_loaded( vehiclebundle ) )
    {
        return;
    }
    
    pathdata.direction = 1;
    pathdata.index = 0;
    
    if ( 0 && -1 < pathdata.path.size )
    {
        pathdata.index = -1;
    }
    else if ( true )
    {
        pathdata.index = randomint( pathdata.path.size - 1 );
    }
    
    for ( i = 0; i < pathdata.path.size ; i++ )
    {
        spawnnode = pathdata.path[ ( pathdata.index + i ) % ( pathdata.path.size - 1 ) ];
        
        if ( spawnnode.goalvehiclenode.script_parameters != "infil_area" )
        {
            break;
        }
    }
    
    if ( false )
    {
        wait -1;
    }
    
    spawnangles = spawnnode.angles;
    
    if ( spawnnode.goalvehiclenode )
    {
        nextnode = vehicle_roads::function_d5de32e196353afe( spawnnode.goalvehiclenode.target );
        
        if ( nextnode )
        {
            forwardaxis = vectornormalize2( nextnode.origin - spawnnode.goalvehiclenode.origin );
            rightaxis = vectorcross( forwardaxis, ( 0, 0, 1 ) );
            spawnangles = axistoangles( forwardaxis, rightaxis, ( 0, 0, 1 ) );
        }
    }
    
    vehicle = spawnpatrol( spawnnode.origin, spawnangles, pathdata.direction, vehiclebundle );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle endon( #"death" );
    vehicle.pathdata = pathdata;
    
    if ( br_dmz_radiation::function_23a851159c5fcbb2( pathdata.path ) )
    {
        foreach ( rider in vehicle.riders )
        {
            br_dmz_radiation::function_8976f4d93db5c4a9( rider );
        }
    }
    
    vehicle.dontunloadonend = 1;
    var_5021df98f73d2050 = getdvarint( @"hash_24cfee9a4aea8368", 1 ) == 1;
    vehicle vehicle_roads::function_b5bd79b51773c046( !var_5021df98f73d2050, 0, 1, vehicle vehicle::is_tank() ? 0 : 31 );
    
    if ( !var_5021df98f73d2050 )
    {
        vehicle setconfigvalue( "p2p", "stuckTime", 2 );
        vehicle setconfigvalue( "p2p", "reverseForBehindGoal", 0 );
        vehicle setconfigvalue( "p2p", "stuckForcedReverseTime", 1 );
        vehicle setconfigvalue( "p2p", "reverseGasWhileStuck", 0.3 );
    }
    
    vehicle thread function_e4745fcb65df2ff2( speed );
    
    /#
        if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 && 1 )
        {
            vehicle thread function_c69a55f721c0fb13();
        }
    #/
}

// Namespace ai_vehicle_patrol
// Params 6
// Checksum 0x5ea86b1, Offset: 0xf57
// Size: 0x5f7
function function_e4745fcb65df2ff2( speed, disablelooping = 0, var_8eb970d786fff9f7, var_c677a1872ed9e343, var_a013e99fabd91cd5, resumingpath = 0 )
{
    self notify( #"hash_8124ee0a85f538a2" );
    self endon( #"hash_8124ee0a85f538a2" );
    self endon( #"death" );
    self endon( #"stop_patrol" );
    self.var_91114e9fbe47928 = 1;
    self.lastlocation = self.origin;
    self.var_b4a4d42e75cbc98e = gettime();
    istank = vehicle::is_tank();
    healthdamagetime = gettime();
    lasthealth = self.health;
    self.snapshotriders = function_46f9072493651dc9( self.riders ?? [] );
    unloadtime = undefined;
    wasloading = undefined;
    pathfollowing = undefined;
    
    while ( true )
    {
        if ( vehicle_ai::is_finished_loading( wasloading ) )
        {
            healthdamagetime = gettime();
            self.var_b4a4d42e75cbc98e = gettime();
            lasthealth = self.health;
            self.lastlocation = self.origin;
            self.snapshotriders = function_46f9072493651dc9( self.riders ?? [] );
        }
        
        isloaded = vehicle_ai::is_veh_loaded();
        
        if ( vehicle_ai::function_7fb2807eb0dcc527( wasloading, 1, getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 ) )
        {
            if ( self.pathcomplete && var_8eb970d786fff9f7 )
            {
                self thread [[ var_8eb970d786fff9f7 ]]();
            }
            
            if ( isloaded )
            {
                thread unload();
            }
            
            vehicle_roads::stop_follow_roads();
            self notify( #"stop_patrol_follow_path" );
            
            if ( !istank )
            {
                level thread vehicle_spawn::function_d4bf495411e41abd( self );
            }
            
            return;
        }
        
        wasloading = self.loading;
        canunload = isloaded || istank && pathfollowing;
        damageunload = canunload && lasthealth - self.health > 100;
        deathunload = !istank && vehicle_ai::function_d87f5ae34394bf32();
        stuckunload = canunload && !damageunload && 1 && self.lastlocation && distancesquared( self.origin, self.lastlocation ) < 22500 && gettime() - self.var_b4a4d42e75cbc98e > 8000;
        radiationunload = canunload && !stuckunload && self.goalpoint && br_dmz_radiation::radiation_isinradiation( self.goalpoint );
        var_9227091f360a6a96 = !unloadtime || utility::time_has_passed( unloadtime, 10 );
        
        if ( var_9227091f360a6a96 && ( damageunload || deathunload || stuckunload || radiationunload ) )
        {
            /#
                if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
                {
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:x24>" + ( damageunload ? "<dev string:x44>" : deathunload ? "<dev string:x59>" : stuckunload ? "<dev string:x71>" : "<dev string:x7b>" ), ( 1, 1, 1 ), 1, 4, 100000 );
                }
            #/
            
            self.snapshotriders = function_46f9072493651dc9( self.riders ?? [] );
            unloadtime = gettime();
            pathfollowing = undefined;
            vehicle_roads::stop_follow_roads();
            self notify( #"stop_patrol_follow_path" );
            thread unload( "combat_run" );
            
            if ( istank )
            {
                return;
            }
        }
        else if ( canunload )
        {
            if ( gettime() - healthdamagetime > 3000 )
            {
                healthdamagetime = gettime();
                lasthealth = self.health;
            }
            
            if ( !self.lastlocation || distancesquared( self.origin, self.lastlocation ) > 22500 )
            {
                self.var_b4a4d42e75cbc98e = gettime();
                self.lastlocation = self.origin;
            }
        }
        
        if ( ( isloaded || istank ) && !self.unloading && !pathfollowing )
        {
            pathfollowing = 1;
            
            if ( self.pathdata )
            {
                childthread function_f42c557b3feef4c8( self.pathdata, resumingpath, disablelooping, speed );
            }
            else
            {
                if ( resumingpath )
                {
                    [ closestnode, var_c677a1872ed9e343 ] = vehicle_roads::get_closest_vehicle_node( self.origin, 4000, self.angles );
                    var_a013e99fabd91cd5 = closestnode.targetname;
                }
                
                if ( var_c677a1872ed9e343 && var_a013e99fabd91cd5 )
                {
                    vehicle_roads::function_b5bd79b51773c046( !getdvarint( @"hash_24cfee9a4aea8368", 1 ) == 1, undefined, 1, vehicle::is_tank() ? 0 : 31 );
                    childthread vehicle_roads::follow_roads( var_c677a1872ed9e343, var_a013e99fabd91cd5, 0 );
                }
                else
                {
                    self.forcecancel = 1;
                }
            }
            
            resumingpath = 1;
        }
        
        if ( unloadtime && utility::time_has_passed( unloadtime, 10 ) )
        {
            var_b0f2ab4e25b5440 = 0;
            self.snapshotriders = function_46f9072493651dc9( self.snapshotriders );
            
            foreach ( rider in self.snapshotriders )
            {
                if ( rider.enemy )
                {
                    var_b0f2ab4e25b5440 = 1;
                    break;
                }
            }
            
            if ( var_b0f2ab4e25b5440 )
            {
                unloadtime = gettime();
            }
            else
            {
                unloadtime = undefined;
                thread loadAndReset( self, self.snapshotriders );
            }
        }
        
        waitframe();
    }
}

// Namespace ai_vehicle_patrol
// Params 5, eflags: 0xc
// Checksum 0x89100560, Offset: 0x1556
// Size: 0x40a
function private function_f42c557b3feef4c8( pathdata, resumingpath, disablelooping = 0, speed = "medium", var_8eb970d786fff9f7 )
{
    self notify( #"hash_6aa8c4b2ba0986c7" );
    self endon( #"hash_6aa8c4b2ba0986c7" );
    
    if ( !isdefined( self.var_7e483aef312d0d6b ) )
    {
        self.var_7e483aef312d0d6b = pathdata.index;
    }
    
    self endon( #"stop_patrol" );
    self endon( #"stop_patrol_follow_path" );
    
    if ( !resumingpath )
    {
        if ( pathdata.direction == -1 )
        {
            self.var_7e483aef312d0d6b--;
            
            if ( !pathdata.path[ self.var_7e483aef312d0d6b ] )
            {
                if ( disablelooping )
                {
                    self.pathcomplete = 1;
                    return;
                }
                
                self.var_7e483aef312d0d6b = pathdata.path.size - 1;
            }
        }
        else
        {
            self.var_7e483aef312d0d6b++;
            
            if ( !pathdata.path[ self.var_7e483aef312d0d6b ] )
            {
                if ( disablelooping )
                {
                    self.pathcomplete = 1;
                    return;
                }
                
                self.var_7e483aef312d0d6b = 0;
            }
        }
    }
    
    for ( node = pathdata.path[ self.var_7e483aef312d0d6b ]; true ; node = pathdata.path[ self.var_7e483aef312d0d6b ] )
    {
        if ( !node.origin )
        {
            assertmsg( "<dev string:x93>" + ( node.targetname ?? "<dev string:xcc>" ) + "<dev string:xd6>" + ( self.origin ?? "<dev string:xcc>" ) );
            self.pathcomplete = 1;
            return;
        }
        
        vehicle_roads::function_b5bd79b51773c046( !getdvarint( @"hash_24cfee9a4aea8368", 1 ) == 1, undefined, 1, vehicle::is_tank() ? 0 : 31 );
        
        if ( node.goalvehiclenode )
        {
            vehicle_roads::function_c64bd96044937781( node.goalvehiclenode, speed, 1, 1, 0, undefined, 1, undefined, undefined, getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 );
        }
        else
        {
            vehicle_roads::function_c64bd96044937781( node.origin, speed, 1, 1, 0, undefined, 1, undefined, undefined, getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 );
        }
        
        /#
            if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
            {
                thread debug_utility::drawsphere( node.origin, 512, 30, ( 0, 1, 1 ) );
            }
        #/
        
        starttime = gettime();
        vehicle::vehicle_paths();
        
        if ( starttime == gettime() )
        {
            assertmsg( "<dev string:xe9>" + self.origin + "<dev string:x12b>" );
            self.pathcomplete = 1;
            return;
        }
        
        if ( !function_42a13b2cff692e39( self, node ) )
        {
            continue;
        }
        
        if ( 1 && node.node_behavior )
        {
            switch ( node.node_behavior )
            {
                case #"hash_112771b601a19f38":
                    getOutExplore( self, node );
                    break;
                case #"hash_5ac1eba9538bbd70":
                    getoutassault( self, node );
                    break;
                case #"hash_e33a99e7969767a7":
                    getOutInteraction( self, node );
                    break;
            }
        }
        
        if ( pathdata.direction == -1 )
        {
            self.var_7e483aef312d0d6b--;
            
            if ( !pathdata.path[ self.var_7e483aef312d0d6b ] )
            {
                if ( disablelooping )
                {
                    self.pathcomplete = 1;
                    return;
                }
                
                self.var_7e483aef312d0d6b = pathdata.path.size - 1;
            }
            
            continue;
        }
        
        self.var_7e483aef312d0d6b++;
        
        if ( !pathdata.path[ self.var_7e483aef312d0d6b ] )
        {
            if ( disablelooping )
            {
                self.pathcomplete = 1;
                return;
            }
            
            self.var_7e483aef312d0d6b = 0;
        }
    }
}

// Namespace ai_vehicle_patrol
// Params 3
// Checksum 0x2e809bcd, Offset: 0x1968
// Size: 0xea, Type: bool
function function_42a13b2cff692e39( vehicle, node, tolerance = 512 )
{
    dist = distance2d( vehicle.origin, node.origin );
    
    /#
        if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 && 1 )
        {
            thread debug_utility::drawsphere( vehicle.origin, 256, 30, ( 1, 0, 0 ) );
            thread debug_utility::drawsphere( node.origin, 256, 30, ( 1, 0, 0 ) );
            thread debug_utility::drawline( vehicle.origin, node.origin, 30, ( 1, 0, 0 ) );
        }
    #/
    
    if ( dist > tolerance )
    {
        return false;
    }
    
    return true;
}

// Namespace ai_vehicle_patrol
// Params 7
// Checksum 0x6d6494d6, Offset: 0x1a5b
// Size: 0x409
function spawnpatrol( origin, angles = ( 0, 0, 0 ), direction, vehiclebundle, priority = "medium", category = "vehiclePatrol", riders )
{
    subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", origin );
    isareaactive = utility::callsharedfunc( #"poi", #"area_isareaactive", subarea.areaname );
    
    if ( !isareaactive )
    {
        /#
            if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
            {
                thread debug_utility::drawsphere( origin, 512, 30, ( 1, 0, 0 ) );
            }
        #/
        
        return;
    }
    
    if ( isdefined( subarea.poiname ) )
    {
        ispoiactive = utility::callsharedfunc( #"poi", #"poi_ispoiactive", subarea.poiname );
        
        if ( !ispoiactive )
        {
            /#
                if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
                {
                    thread debug_utility::drawsphere( origin, 512, 30, ( 1, 0, 0 ) );
                }
            #/
            
            return;
        }
    }
    
    var_7c056407894a2fd5 = utility::drop_to_ground( origin );
    
    if ( distance( origin, var_7c056407894a2fd5 ) > 10000 )
    {
        return;
    }
    
    if ( !vehicle::is_tank( vehiclebundle ) && !riders.size )
    {
        agenttypes = utility::callsharedfunc( #"ground", #"hash_fcd7e9fa4cb0879c", vehiclebundle );
        spawners = utility::callsharedfunc( #"ground", #"hash_c96151abc06cb1c1", vehiclebundle, 4, agenttypes, origin, subarea, priority, category );
        riders = utility::callsharedfunc( #"ground", #"spawnriders", spawners, 4, undefined, priority, category, "patrol", "team_hundred_ninety_four", undefined, vehiclebundle, subarea );
        
        if ( !isdefined( riders ) || riders.size == 0 )
        {
            return;
        }
        
        foreach ( rider in riders )
        {
            if ( isent( rider ) )
            {
                rider.var_4f8a92ebabf37ee = getdvarint( @"hash_4deba55716c47c46", 0 );
                rider.var_f60cb46dafea871e = 1;
                rider.var_cef5d8d02e0c6afd = 1;
            }
        }
    }
    
    spawndata = { #spawnmethod:"place_at_position_unsafe", #initai:1, #showheadicon:1, #team:"team_hundred_ninety_four", #spawntype:"GAME_MODE", #angles:direction > 0 ? angles : angles + ( 0, 180, 0 ), #origin:origin };
    vehicle = vehicle::spawn( vehiclebundle, spawndata );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    /#
        if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
        {
            debugaxis( origin, angles, 500, 1, 0, 1000 );
        }
    #/
    
    vehicle callback::add( #"hash_a66f22b6e512afda", &function_7c8e379d04917ede );
    vehicle.var_d1c265e59db4d5bf = getdvarint( @"hash_9e4fff9024bd3a06", 1 );
    
    if ( vehicle vehicle::is_tank() )
    {
        vehicle utility::callsharedfunc( #"tank_boss", #"hash_e46f3cee0f643c3a" );
    }
    
    waitframe();
    
    if ( riders.size )
    {
        vehicle vehicle_ai::load( riders, 1, 1 );
    }
    
    return vehicle;
}

// Namespace ai_vehicle_patrol
// Params 2, eflags: 0x4
// Checksum 0xa549ffd7, Offset: 0x1e6d
// Size: 0x85
function private function_77dbcaa6aa5cde1e( rider, isdriver )
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle endon( #"unloaded" );
    rider waittill( #"death" );
    
    if ( !( isdefined( vehicle ) && isdefined( vehicle.var_7a4124d351fc5184 ) ) )
    {
        return;
    }
    
    vehicle.var_7a4124d351fc5184 -= isdriver ? 2 : 1;
}

// Namespace ai_vehicle_patrol
// Params 1, eflags: 0x4
// Checksum 0x376893ba, Offset: 0x1efa
// Size: 0x17
function private function_7c8e379d04917ede( params )
{
    self.forcecancel = 1;
}

// Namespace ai_vehicle_patrol
// Params 0, eflags: 0x4
// Checksum 0x49013e3c, Offset: 0x1f19
// Size: 0xff
function private onblocked()
{
    if ( isdefined( self.var_c30f993528bf44af ) && gettime() - self.var_c30f993528bf44af > 10000 )
    {
        /#
            if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
            {
                print3d( self.origin + ( 0, 0, 100 ), "<dev string:x171>", ( 1, 1, 1 ), 1, 4, 100000 );
            }
        #/
        
        thread unload();
        return;
    }
    
    self.var_c30f993528bf44af = gettime();
    self.var_b4a4d42e75cbc98e = gettime();
    self.lastlocation = self.origin;
    self.pathdata.direction *= -1;
    vehicle_ai::increment_path_index( self.pathdata );
    thread vehicle_ai::follow_path_struct( self.pathdata, level.var_a5ea289ea9ded60c, &onblocked );
}

// Namespace ai_vehicle_patrol
// Params 0, eflags: 0x4
// Checksum 0x25f2a550, Offset: 0x2020
// Size: 0x20, Type: bool
function private canunload()
{
    return distancesquared( self.origin, getclosestpointonnavmesh( self.origin ) ) < 10000;
}

// Namespace ai_vehicle_patrol
// Params 1
// Checksum 0x1d25e5f3, Offset: 0x2049
// Size: 0x7e
function unload( unloadtype )
{
    self notify( #"hash_ff603c86bbe07fdb" );
    
    if ( vehicle::is_tank() )
    {
        vehicle_ai::stop_moving();
        thread utility::callsharedfunc( #"tank_boss", #"hash_bd6dfdbe0a6cefc1" );
        return;
    }
    
    if ( !canunload() )
    {
        self.burndowntime = 4;
        vehicle_spawn::stuck_timeout();
        return;
    }
    
    vehicle_ai::unload( 1, unloadtype, unloadtype == "combat_run" ? "moving" : undefined );
}

// Namespace ai_vehicle_patrol
// Params 1, eflags: 0x4
// Checksum 0x50e45f8c, Offset: 0x20cf
// Size: 0x11e
function private function_f31f29a4f8db7341( path )
{
    foreach ( node in path )
    {
        targetnodes = utility::getstructarray( node.target, "targetname" );
        
        foreach ( targetnode in targetnodes )
        {
            if ( targetnode.script_noteworthy == "vehicle_get_out_destination" )
            {
                node.destinationnode = targetnode;
            }
        }
    }
}

// Namespace ai_vehicle_patrol
// Params 2, eflags: 0x4
// Checksum 0x4754e6f5, Offset: 0x21f5
// Size: 0x17e
function private getOutExplore( vehicle, node )
{
    infinitewait = !node.var_cddf5c258009bf57;
    riders = vehicle.riders;
    vehicle vehicle_ai::unload( infinitewait );
    var_206bc0cf67753281 = riders;
    
    foreach ( rider in var_206bc0cf67753281 )
    {
        if ( !rider || !isalive( rider ) )
        {
            riders = arrayremove( riders, rider );
            continue;
        }
        
        behaviororigin = node.destinationnode.origin ?? rider.origin;
        rider ai_behavior::function_4a3c03bb49dd5d76( behaviororigin, 512, undefined, "getOutExplore" );
        
        /#
            if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
            {
                thread debug_utility::drawsphere( behaviororigin, 32, 30, ( 0, 1, 0 ) );
            }
        #/
        
        rider thread ai_behavior::behavior_GuardWander( rider, 256, 32, behaviororigin );
    }
    
    if ( infinitewait )
    {
        return;
    }
    
    wait int( node.var_cddf5c258009bf57 );
    loadAndReset( vehicle, riders );
}

// Namespace ai_vehicle_patrol
// Params 2, eflags: 0x4
// Checksum 0xc39bee25, Offset: 0x237b
// Size: 0x1b3
function private getoutassault( vehicle, node )
{
    if ( !node.var_afd6492a80b77435 )
    {
        getOutExplore( vehicle, node );
        return;
    }
    
    riders = vehicle.riders;
    vehicle vehicle_ai::unload( 0 );
    waitframe();
    var_206bc0cf67753281 = riders;
    
    foreach ( rider in var_206bc0cf67753281 )
    {
        if ( !rider || !isalive( rider ) )
        {
            riders = arrayremove( riders, rider );
            continue;
        }
        
        if ( node.destinationnode.origin )
        {
            /#
                if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
                {
                    thread debug_utility::drawsphere( node.destinationnode.origin, 32, 30, ( 0, 1, 0 ) );
                }
            #/
            
            rider thread ai_behavior::behavior_combatRushOrigin( rider, node.destinationnode.origin, 32, 32, undefined, undefined, undefined, undefined, &function_907a76462588fc20 );
        }
        
        rider enemy::bt_set_stealth_state( "combat", undefined );
        rider.var_34675b8a999ae793 = 10000;
        rider function_82940ab77128faa1( node.var_afd6492a80b77435 );
    }
    
    wait int( node.var_cddf5c258009bf57 );
    loadAndReset( vehicle, riders );
}

// Namespace ai_vehicle_patrol
// Params 2
// Checksum 0x70c9e580, Offset: 0x2536
// Size: 0x15
function function_907a76462588fc20( agent, targetent )
{
    
}

// Namespace ai_vehicle_patrol
// Params 2
// Checksum 0xefcd2938, Offset: 0x2553
// Size: 0x1a5
function getOutInteraction( vehicle, node )
{
    if ( !node.var_36d2f6af6369511a )
    {
        getOutExplore( vehicle, node );
        return;
    }
    
    riders = vehicle.riders;
    vehicle vehicle_ai::unload( 0 );
    var_206bc0cf67753281 = riders;
    
    foreach ( rider in var_206bc0cf67753281 )
    {
        if ( !rider || !isalive( rider ) )
        {
            riders = arrayremove( riders, rider );
            continue;
        }
        
        behaviororigin = node.destinationnode.origin ?? rider.origin;
        rider ai_behavior::function_4a3c03bb49dd5d76( behaviororigin, undefined, undefined, "getOutInteraction" );
        
        /#
            if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 )
            {
                thread debug_utility::drawsphere( behaviororigin, 32, 30, ( 0, 1, 0 ) );
            }
        #/
        
        rider thread ai_behavior::function_5c6cec6f0ce57f4( rider, behaviororigin, node.var_36d2f6af6369511a, undefined, undefined, int( node.var_cddf5c258009bf57 ), int( node.var_cddf5c258009bf57 ) + 5, 1024 );
    }
    
    wait int( node.var_cddf5c258009bf57 );
    loadAndReset( vehicle, riders );
}

// Namespace ai_vehicle_patrol
// Params 2
// Checksum 0x34ed50f6, Offset: 0x2700
// Size: 0x2b1
function loadAndReset( vehicle, riders )
{
    var_206bc0cf67753281 = riders;
    
    foreach ( rider in var_206bc0cf67753281 )
    {
        if ( !rider || !isalive( rider ) )
        {
            riders = arrayremove( riders, rider );
            continue;
        }
        
        rider leaveinteraction();
        rider notify( #"hash_b82de4299d909fce" );
        rider function_8dea53a2dfc74f94( 0 );
        rider ai_behavior::function_4a3c03bb49dd5d76( vehicle.origin, 128, undefined, "loadAndReset" );
        rider enemy::bt_set_stealth_state( "idle", undefined );
        rider.stealth_idledemeanor = "patrol";
        rider.var_b52fca22f7f1e144 = "alert";
        rider.var_7a84781005a5b751 = 0;
        rider function_82940ab77128faa1();
        
        if ( rider.interactionnode )
        {
            rider ai_behavior::function_c60e67787847eadd( rider.interactionnode );
        }
    }
    
    wait 1;
    
    if ( !vehicle vehicle_ai::can_load( riders ) )
    {
        return;
    }
    
    var_206bc0cf67753281 = riders;
    
    foreach ( rider in var_206bc0cf67753281 )
    {
        if ( !rider || !isalive( rider ) )
        {
            riders = arrayremove( riders, rider );
        }
    }
    
    if ( riders.size > 0 )
    {
        vehicle vehicle_ai::load( riders );
    }
    
    wait 1;
    var_206bc0cf67753281 = riders;
    
    foreach ( rider in var_206bc0cf67753281 )
    {
        if ( !rider || !isalive( rider ) )
        {
            riders = arrayremove( riders, rider );
            continue;
        }
        
        rider enemy::bt_set_stealth_state( "idle", undefined );
        rider.stealth_idledemeanor = "patrol";
        rider.var_b52fca22f7f1e144 = "alert";
        rider.var_7a84781005a5b751 = 0;
        rider function_82940ab77128faa1();
    }
}

// Namespace ai_vehicle_patrol
// Params 0, eflags: 0x4
// Checksum 0xa01219ba, Offset: 0x29b9
// Size: 0x15c
function private function_1e61f19f79b19981()
{
    pathnodes = utility::getstructarray( "vehicle_one_shot_start", "script_noteworthy" );
    
    foreach ( node in pathnodes )
    {
        if ( node.processed )
        {
            continue;
        }
        
        pathstruct = ai_mp_controller::function_ad7994ce0f8a6d54( node, undefined, "vehicle_one_shot_node" );
        function_f31f29a4f8db7341( pathstruct.path );
        
        foreach ( node in pathstruct.path )
        {
            node.processed = 1;
        }
        
        level.var_a3233307a29234c2[ level.var_a3233307a29234c2.size ] = pathstruct;
    }
    
    /#
        if ( false )
        {
            level thread function_421a39e0220fb225();
        }
    #/
}

// Namespace ai_vehicle_patrol
// Params 4
// Checksum 0x74ea7ab8, Offset: 0x2b1d
// Size: 0x2e7
function function_b4a05b1d54751f47( pathdata, vehiclebundle, speed, var_8eb970d786fff9f7 )
{
    if ( !vehicle::is_loaded( vehiclebundle ) )
    {
        return;
    }
    
    if ( isstring( pathdata ) )
    {
        foreach ( var_d7501760565ae5b5 in level.var_a3233307a29234c2 )
        {
            if ( var_d7501760565ae5b5.path[ 0 ].pathname == pathdata )
            {
                pathdata = var_d7501760565ae5b5;
                break;
            }
        }
    }
    
    if ( !pathdata || isstring( pathdata ) )
    {
        return;
    }
    
    pathdata.direction = 1;
    pathdata.index = 0;
    reinforcenode = pathdata.path[ pathdata.index ];
    reinforcenode.origin = getgroundposition( reinforcenode.origin, 1, 128 );
    vehicle = spawnpatrol( reinforcenode.origin, reinforcenode.angles, pathdata.direction, vehiclebundle );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    if ( br_dmz_radiation::function_23a851159c5fcbb2( pathdata.path ) )
    {
        foreach ( rider in vehicle.riders )
        {
            br_dmz_radiation::function_8976f4d93db5c4a9( rider );
        }
    }
    
    vehicle.pathdata = pathdata;
    vehicle.dontunloadonend = 1;
    var_5021df98f73d2050 = getdvarint( @"hash_24cfee9a4aea8368", 1 ) == 1;
    vehicle vehicle_roads::function_b5bd79b51773c046( !var_5021df98f73d2050, undefined, 1, vehicle vehicle::is_tank() ? 0 : 31 );
    
    if ( !var_5021df98f73d2050 )
    {
        vehicle setconfigvalue( "p2p", "stuckTime", 2 );
        vehicle setconfigvalue( "p2p", "reverseForBehindGoal", 0 );
        vehicle setconfigvalue( "p2p", "stuckForcedReverseTime", 1 );
        vehicle setconfigvalue( "p2p", "reverseGasWhileStuck", 0.3 );
    }
    
    vehicle thread function_e4745fcb65df2ff2( speed, 1, var_8eb970d786fff9f7 );
    
    /#
        if ( getdvarint( @"scr_vehicle_patrol_debug", 0 ) == 1 && 1 )
        {
            vehicle thread function_c69a55f721c0fb13();
        }
    #/
    
    return vehicle;
}

// Namespace ai_vehicle_patrol
// Params 0
// Checksum 0xd7cfa8cd, Offset: 0x2e0d
// Size: 0x26
function function_57acfbfbd0f9c0a4()
{
    vehicle = self;
    vehicle.dontspawnhusk = 1;
    vehicle::death( vehicle );
}

/#

    // Namespace ai_vehicle_patrol
    // Params 0, eflags: 0x4
    // Checksum 0x7f260717, Offset: 0x2e3b
    // Size: 0x2ec, Type: dev
    function private function_421a39e0220fb225()
    {
        wait 1;
        
        if ( !isdefined( level.var_a3233307a29234c2 ) )
        {
            return;
        }
        
        foreach ( pathnum, pathdata in level.var_a3233307a29234c2 )
        {
            if ( 0 && -1 < level.var_a3233307a29234c2.size && pathnum != -1 )
            {
                continue;
            }
            
            for ( i = 0; i < pathdata.path.size - 1 ; i++ )
            {
                startnode = pathdata.path[ i ];
                endnode = pathdata.path[ ( i + 1 ) % pathdata.path.size ];
                level thread debug_utility::drawline( startnode.origin, endnode.origin, 10000, istrue( pathdata.spawned ) ? ( 0, 1, 0 ) : ( 0, 0, 1 ) );
            }
        }
        
        while ( isdefined( level.var_a3233307a29234c2 ) )
        {
            foreach ( pathnum, pathdata in level.var_a3233307a29234c2 )
            {
                if ( 0 && -1 < level.var_a3233307a29234c2.size && pathnum != -1 )
                {
                    continue;
                }
                
                foreach ( var_3eaf222647f67228, node in pathdata.path )
                {
                    if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].origin ) && distancesquared( node.origin, level.players[ 0 ].origin ) < 9000000 )
                    {
                        print3d( node.origin + ( 0, 0, 10 * pathnum ), "<dev string:x198>" + pathnum + "<dev string:x19e>" + var_3eaf222647f67228, ( 1, 1, 1 ), 1, 3 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_vehicle_patrol
    // Params 0, eflags: 0x4
    // Checksum 0x9312489b, Offset: 0x312f
    // Size: 0xb0, Type: dev
    function private function_655bc52b25fdc81c()
    {
        setdvar( @"hash_708c27714785445c", 0 );
        
        while ( true )
        {
            wait 1;
            
            if ( getdvarint( @"hash_708c27714785445c", 0 ) == 1 )
            {
                setdvar( @"hash_708c27714785445c", 0 );
                vehiclenode = vehicle_roads::get_closest_vehicle_node( level.players[ 0 ].origin, 3000 );
                
                if ( !vehiclenode[ 0 ] )
                {
                    continue;
                }
                
                if ( !vehicle_spawn::function_c49e68f891a06e6f( vehiclenode[ 0 ].origin, %"hash_59c4340860e0302a" ) )
                {
                    continue;
                }
                
                function_5b3313bc8b2069e( vehiclenode[ 0 ], vehiclenode[ 1 ], %"hash_59c4340860e0302a" );
            }
        }
    }

    // Namespace ai_vehicle_patrol
    // Params 0, eflags: 0x4
    // Checksum 0xde404065, Offset: 0x31e7
    // Size: 0x43c, Type: dev
    function private debugshowpaths()
    {
        wait 1;
        var_c79ddb1779aee56 = 1;
        debugduration = var_c79ddb1779aee56 * 20 + 1;
        
        while ( isdefined( level.var_597ee951f620c8 ) )
        {
            foreach ( pathnum, pathdata in level.var_597ee951f620c8 )
            {
                if ( pathdata.patrolindex )
                {
                    pathnum = pathdata.patrolindex;
                }
                
                if ( 0 && -1 < level.var_597ee951f620c8.size && pathnum != -1 )
                {
                    continue;
                }
                
                for ( nodeindex = 0; nodeindex < pathdata.path.size ; nodeindex++ )
                {
                    startnode = pathdata.path[ nodeindex ];
                    endnode = pathdata.path[ ( nodeindex + 1 ) % pathdata.path.size ];
                    line( startnode.origin, endnode.origin, pathdata.spawned ? ( 0, 1, 0 ) : ( 0, 0, 1 ), 1, 0, debugduration );
                    
                    if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].origin ) && distancesquared( startnode.origin, level.players[ 0 ].origin ) < 9000000 )
                    {
                        if ( getdvarint( @"hash_8afbce1868ddb1ab", 1 ) == 1 && -1 )
                        {
                            print3d( startnode.origin + ( 0, 0, 10 * pathnum ), "<dev string:x1a5>" + nodeindex, ( 1, 1, 1 ), 1, 3, debugduration );
                        }
                        else
                        {
                            print3d( startnode.origin + ( 0, 0, 10 * pathnum ), "<dev string:x198>" + pathnum + "<dev string:x19e>" + nodeindex, ( 1, 1, 1 ), 1, 3, debugduration );
                        }
                    }
                    
                    if ( startnode.node_behavior )
                    {
                        debugcolor = ( 0.45, 0.99, 0 );
                        offset = ( 0, 0, 10 );
                        line( startnode.origin + offset, startnode.origin + offset + ( 0, 0, 2000 ), debugcolor, 1, 0, debugduration );
                        sphere( startnode.origin, 30, debugcolor, 0, debugduration );
                        continue;
                    }
                    
                    if ( startnode.goalvehiclenode )
                    {
                        debugcolor = ( 0.3, 0.73, 0.09 );
                        offset = ( 0, 0, 10 );
                        line( startnode.origin + offset, startnode.goalvehiclenode.origin + offset, debugcolor, 1, 0, debugduration );
                        line( startnode.goalvehiclenode.origin + offset, startnode.goalvehiclenode.origin + offset + ( 0, 0, 700 ), debugcolor, 1, 0, debugduration );
                        sphere( startnode.goalvehiclenode.origin, 30, debugcolor, 0, debugduration );
                        
                        if ( startnode.goalvehiclenode.target )
                        {
                            nextnode = vehicle_roads::function_d5de32e196353afe( startnode.goalvehiclenode.target );
                            line( startnode.goalvehiclenode.origin + offset, nextnode.origin + offset, debugcolor, 1, 0, debugduration );
                        }
                    }
                }
            }
            
            wait var_c79ddb1779aee56;
        }
    }

    // Namespace ai_vehicle_patrol
    // Params 0, eflags: 0x4
    // Checksum 0x2cf88829, Offset: 0x362b
    // Size: 0x162, Type: dev
    function private function_c69a55f721c0fb13()
    {
        self endon( #"death" );
        start = self.origin + ( 0, 0, 50 );
        end = self.origin + anglestoforward( self.angles ) * 400 + ( 0, 0, 50 );
        
        for ( prevpos = self.origin; true ; prevpos = self.origin )
        {
            wait 1;
            level thread debug_utility::drawline( start, end, 10, ( 1, 1, 1 ) );
            level thread debug_utility::drawsphere( start, 100, 10, ( 1, 1, 1 ) );
            level thread debug_utility::drawline( self.origin + ( 0, 0, 200 ), self.origin + ( 0, 0, 2048 ), 1, ( 1, 0, 0 ) );
            level thread debug_utility::drawline( self.origin, prevpos, 60, ( 1, 0, 1 ) );
            
            if ( isdefined( self.goalpoint ) )
            {
                level thread debug_utility::drawline( self.origin, self.goalpoint, 1, ( 0, 1, 0 ) );
            }
        }
    }

    // Namespace ai_vehicle_patrol
    // Params 0
    // Checksum 0xb4e92ddc, Offset: 0x3795
    // Size: 0x95, Type: dev
    function function_c9f230bf8fb77ac8()
    {
        assert( isdefined( level.var_597ee951f620c8 ), "<dev string:x1b2>" );
        
        foreach ( pathdata in level.var_597ee951f620c8 )
        {
            function_ca9b5f189d88c36e( pathdata );
        }
    }

    // Namespace ai_vehicle_patrol
    // Params 1, eflags: 0x4
    // Checksum 0x94d4abe7, Offset: 0x3832
    // Size: 0x3f6, Type: dev
    function private function_ca9b5f189d88c36e( patroldata )
    {
        assert( patroldata && patroldata.path && patroldata.path.size > 0 );
        result = 1;
        points = [];
        targets = [];
        ignore = [];
        
        foreach ( patrolnode in patroldata.path )
        {
            if ( patrolnode.goalvehiclenode && patrolnode.goalvehiclenode.target )
            {
                nextnode = vehicle_roads::function_d5de32e196353afe( patrolnode.goalvehiclenode.target );
                assert( nextnode );
                points[ points.size ] = patrolnode.origin;
                targets[ targets.size ] = nextnode.origin;
                ignore[ ignore.size ] = 0;
                continue;
            }
            
            points[ points.size ] = patrolnode.origin;
            targets[ targets.size ] = ( 0, 0, 0 );
            ignore[ ignore.size ] = 1;
        }
        
        debugcolor = ( 0.3, 0.73, 0.09 );
        debugduration = 6000;
        offset = ( 0, 0, 10 );
        
        for ( nodeindex = 0; nodeindex < points.size ; nodeindex++ )
        {
            var_3ca505999737f7a9 = points[ ( nodeindex + points.size - 1 ) % points.size ];
            var_91dacb42cf8084e5 = points[ nodeindex ];
            var_dfaed70d6af5e3fd = points[ ( nodeindex + 1 ) % points.size ];
            
            if ( !ignore[ nodeindex ] )
            {
                nodedirection = vectornormalize2( targets[ nodeindex ] - var_91dacb42cf8084e5 );
                var_1a2e74477f454c96 = vectornormalize2( ( var_dfaed70d6af5e3fd - var_91dacb42cf8084e5 ) * ( 1, 1, 0 ) );
                var_9550f18660f53ff2 = vectornormalize2( ( var_3ca505999737f7a9 - var_91dacb42cf8084e5 ) * ( 1, 1, 0 ) );
                var_4599a4329c42672 = math::anglebetweenvectors( nodedirection, var_9550f18660f53ff2 );
                nextnodeangle = math::anglebetweenvectors( nodedirection, var_1a2e74477f454c96 );
                resultcolor = debugcolor;
                
                if ( var_4599a4329c42672 < nextnodeangle )
                {
                    resultcolor = ( 1, 0, 0 );
                    sphere( var_91dacb42cf8084e5 + offset, 100, resultcolor, 0, debugduration );
                    print3d( var_91dacb42cf8084e5 + offset, "<dev string:x1e6>" + patroldata.path[ nodeindex ].targetname, ( 1, 1, 1 ), 1, 3, debugduration );
                    print3d( var_91dacb42cf8084e5 + offset + ( 0, 0, 150 ), "<dev string:x1fc>" + patroldata.path[ nodeindex ].goalvehiclenode.targetname, ( 1, 1, 1 ), 1, 3, debugduration );
                    println( "<dev string:x21e>" + patroldata.path[ nodeindex ].targetname + "<dev string:x25b>" + patroldata.path[ nodeindex ].goalvehiclenode.targetname );
                    result = 0;
                }
                
                line( var_91dacb42cf8084e5 + offset, var_91dacb42cf8084e5 + nodedirection * 800 + offset, resultcolor, 1, 0, debugduration );
            }
            else
            {
                resultcolor = ( 0.02, 0.25, 0.17 );
            }
            
            line( var_91dacb42cf8084e5 + offset, var_dfaed70d6af5e3fd + offset + ( 5, 5, 15 ), resultcolor, 1, 0, debugduration );
        }
        
        return result;
    }

#/
