// scripts\common\vehicle_paths.gsc  (hash_52e0904904ad8537.gscc) (size: 31939 Bytes / 0x7cc3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x18d2e675 (416474741)
// size ...... 31939 (0x7cc3)
// includes .. 11  (offset: 0x75b7)
// strings ... 67  (offset: 0x760f)
// dev strs .. 42  (offset: 0x7a8f)
// exports ... 59  (offset: 0x51b7)
// cseg ...... 0x495 + 0x4d22 (0x51b7)
// imports ... 207 (offset: 0x5aef)
// animtree1 . 0   (offset: 0x7cc3)
// animtree2 . 0   (offset: 0x7cc3)
#using scripts\common\debug;
#using scripts\common\flags;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_lights;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_tracking;

#namespace vehicle_paths;

// Namespace vehicle_paths
// Params 12
// Checksum 0xcbb62bb2, Offset: 0x4b3
// Size: 0x1cb
function function_53e592e2d38c05ca( checkStuck = 0, brakeAtGoal = 1, autonormal = 1, brakeOnGoalGasbrake = 1, goalThreshold = 100, throttleSpeedClose = 0, throttleSpeedThreshold = 1, var_f04cadb28ee6016d = 1, throttleSpeedFarBelow = 0, throttleSpeedFarAbove = 0, gasToStopMovement = 0.9, steeringMultiplier = 2 )
{
    if ( !self hascomponent( "p2p" ) )
    {
        self addcomponent( "p2p" );
    }
    
    self function_eb88c4e66edbc855( "p2p", "checkStuck", checkStuck );
    self function_eb88c4e66edbc855( "p2p", "brakeAtGoal", brakeAtGoal );
    self function_eb88c4e66edbc855( "p2p", "automaticNormal", autonormal );
    self function_eb88c4e66edbc855( "p2p", "brakeOnGoalGasbrake", brakeOnGoalGasbrake );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", goalThreshold );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", throttleSpeedClose );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedThreshold", throttleSpeedThreshold );
    self function_eb88c4e66edbc855( "p2p", "automaticFastTopspeedFraction", var_f04cadb28ee6016d );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", throttleSpeedFarBelow );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", throttleSpeedFarAbove );
    self function_eb88c4e66edbc855( "p2p", "gasToStopMovement", gasToStopMovement );
    self function_eb88c4e66edbc855( "p2p", "steeringMultiplier", steeringMultiplier );
}

// Namespace vehicle_paths
// Params 3
// Checksum 0xa7058c9d, Offset: 0x686
// Size: 0xf0
function function_6080e3e7e4316b48( var_c8528f7454f54db7 = 0, var_621da8f10021ac1a = 0, avoidanceFlag = 0 )
{
    if ( !self hascomponent( "c2p" ) )
    {
        self addcomponent( "c2p" );
    }
    
    if ( var_c8528f7454f54db7 <= 0 && var_621da8f10021ac1a <= 0 && avoidanceFlag <= 0 )
    {
        return;
    }
    
    if ( !self hascomponent( "path" ) )
    {
        vehicle_init_path_radiant();
    }
    
    if ( var_c8528f7454f54db7 > 0 || var_621da8f10021ac1a > 0 )
    {
        self function_eb88c4e66edbc855( "path", "softConstrained", 1 );
        self function_eb88c4e66edbc855( "path", "softConstPosSoftness", var_c8528f7454f54db7 );
        self function_eb88c4e66edbc855( "path", "softConstRotSoftness", var_621da8f10021ac1a );
    }
    
    if ( avoidanceFlag > 0 && getdvarint( @"hash_c4efbdcb516b1e63", 1 ) == 1 )
    {
        self function_eb88c4e66edbc855( "path", "avoidanceFlag", avoidanceFlag );
    }
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x7dfdac85, Offset: 0x77e
// Size: 0xaf
function vehicle_init_path_radiant( stepradius = 300, stepSpeedFactor = 2, useManualSpeed )
{
    if ( !self hascomponent( "path" ) )
    {
        self addcomponent( "path" );
    }
    
    var_9d84d0368e2af60d = self hascomponent( "c2p" );
    self.pathtype = "path_radiant";
    self function_eb88c4e66edbc855( "path", "radiusToStep", stepradius );
    self function_eb88c4e66edbc855( "path", "stepSpeedFactor", stepSpeedFactor );
    self function_eb88c4e66edbc855( "path", "useManualSpeed", !var_9d84d0368e2af60d );
    self.stopping = 0;
}

// Namespace vehicle_paths
// Params 6
// Checksum 0x18a2810f, Offset: 0x835
// Size: 0x1f8
function function_dc471bcc9cda9df( node, looped, tau = 0.23, usemanualspeeds = 1, yawHelper = 0, brakeatgoalonendnode = 1 )
{
    if ( !self hascomponent( "path" ) )
    {
        self addcomponent( "path" );
    }
    
    self.pathtype = "path_catmullrom";
    spline_id = 0;
    
    if ( isarray( level.vehicle.var_235af58a8cf6d697 ) && isstruct( level.vehicle.var_235af58a8cf6d697[ node.targetname ] ) )
    {
        spline_id = level.vehicle.var_235af58a8cf6d697[ node.targetname ];
    }
    else
    {
        var_d4b32d94b070889b = [];
        notetimes = [];
        curnode = node;
        
        while ( isdefined( curnode ) )
        {
            var_d4b32d94b070889b[ var_d4b32d94b070889b.size ] = curnode.origin;
            notetimes[ notetimes.size ] = 10;
            
            if ( curnode.target )
            {
                curnode = getvehiclenode( curnode.target, #targetname );
                continue;
            }
            
            break;
        }
        
        spline_id = function_53253e8ea222ed60( var_d4b32d94b070889b, notetimes, istrue( looped ), tau );
        
        if ( isarray( level.vehicle.var_235af58a8cf6d697 ) )
        {
            level.vehicle.var_235af58a8cf6d697[ node.targetname ] = spline_id;
        }
    }
    
    self.catmullrom_spline_id = spline_id;
    self function_eb88c4e66edbc855( "path", "useManualSpeed", usemanualspeeds );
    self function_eb88c4e66edbc855( "path", "yawHelper", yawHelper );
    self function_eb88c4e66edbc855( "path", "setBrakeAtGoalOnEndNode", brakeatgoalonendnode );
}

// Namespace vehicle_paths
// Params 0
// Checksum 0x6d00a359, Offset: 0xa35
// Size: 0xd
function function_1a7431b860bb801c()
{
    self.var_32d09b453f167b8a = 1;
}

// Namespace vehicle_paths
// Params 0
// Checksum 0xf5ee7cf4, Offset: 0xa4a
// Size: 0xa2
function function_ae6e16cd074e8f59()
{
    if ( self.var_32d09b453f167b8a )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"removed_components" );
    assert( vehicle::is_vehicle() );
    assert( self hascomponent( "<dev string:x24>" ) );
    self removecomponent( "c2p" );
    function_53e592e2d38c05ca( 1 );
    
    while ( true )
    {
        wait 1;
        
        if ( utility::time_has_passed( self.var_9d5c37753aed59c7, 4 ) )
        {
            break;
        }
    }
    
    if ( !self hascomponent( "p2p" ) )
    {
        return;
    }
    
    self removecomponent( "p2p" );
    self addcomponent( "c2p" );
}

// Namespace vehicle_paths
// Params 1
// Checksum 0xb7b0ec99, Offset: 0xaf4
// Size: 0x109
function vehicle_start_path( var_9f701152d59c1d85 )
{
    if ( !isdefined( self.pathtype ) )
    {
        /#
            iprintlnbold( "<dev string:x28>" );
        #/
        
        return;
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self function_eb88c4e66edbc855( "p2p", "resume", 1 );
    }
    
    if ( self.pathtype == "path_radiant" )
    {
        index = isstring( var_9f701152d59c1d85 ) || isxhash( var_9f701152d59c1d85 ) ? getvehiclenodeindex( var_9f701152d59c1d85, #targetname ) : var_9f701152d59c1d85.index;
        assert( isdefined( index ), "<dev string:x74>" );
        self function_eb88c4e66edbc855( "path", "radiantId", index );
        
        if ( self function_24e10bf6894fa869( "path", "pause" ) )
        {
            self function_eb88c4e66edbc855( "path", "resume", 1 );
        }
        
        return;
    }
    
    if ( self.pathtype == "path_catmullrom" )
    {
        self function_eb88c4e66edbc855( "path", "catmullRomId", self.catmullrom_spline_id );
    }
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x55d7411b, Offset: 0xc05
// Size: 0xa5
function gopath( vehicle )
{
    if ( !isdefined( vehicle ) )
    {
        vehicle = self;
        assert( self.code_classname == "<dev string:x9c>", "<dev string:xab>" );
    }
    
    vehicle endon( #"death" );
    
    if ( isdefined( vehicle.hasstarted ) )
    {
        println( "<dev string:xcf>" );
        return;
    }
    else
    {
        vehicle.hasstarted = 1;
    }
    
    vehicle utility::script_delay();
    vehicle notify( #"start_vehiclepath" );
    
    if ( vehicle vehicle::ishelicopter() )
    {
        vehicle notify( #"start_dynamicpath" );
        return;
    }
    
    vehicle startpath();
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x8429a731, Offset: 0xcb2
// Size: 0x3e
function _vehicle_paths( node, var_ad6ef44930971fe1, elevated_heli_path )
{
    if ( vehicle::ishelicopter() )
    {
        vehicle_paths_helicopter( node, var_ad6ef44930971fe1, elevated_heli_path );
        return;
    }
    
    vehicle_paths_non_heli( node );
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x59b31024, Offset: 0xcf8
// Size: 0x2b8
function trigger_process_node( node )
{
    if ( node.script_flag_set )
    {
        utility::flag_set( node.script_flag_set );
    }
    
    if ( node.script_flag_clear )
    {
        utility::flag_clear( node.script_flag_clear );
    }
    
    if ( node.script_prefab_exploder )
    {
        node.script_exploder = node.script_prefab_exploder;
        node.script_prefab_exploder = undefined;
    }
    
    if ( node.script_exploder )
    {
        delay = node.script_exploder_delay;
        
        if ( isdefined( delay ) )
        {
            level utility::delaythread( delay, &utility::exploder, node.script_exploder );
        }
        else
        {
            level utility::exploder( node.script_exploder );
        }
    }
    
    if ( node.script_flag_set )
    {
        utility::flag_set( node.script_flag_set );
    }
    
    if ( node.script_ent_flag_set )
    {
        utility::ent_flag_set( node.script_ent_flag_set );
    }
    
    if ( node.script_ent_flag_clear )
    {
        utility::ent_flag_clear( node.script_ent_flag_clear );
    }
    
    if ( node.script_flag_clear )
    {
        utility::flag_clear( node.script_flag_clear );
    }
    
    if ( node.script_noteworthy )
    {
        if ( node.script_noteworthy == "deleteme" )
        {
            if ( vehicle::is_common_vehicle() )
            {
                self.dontspawnhusk = 1;
                thread vehicle::death( self );
                return;
            }
            else if ( isdefined( self.deathfunc ) )
            {
                vehicle_ai::delete_riders();
                level thread [[ self.deathfunc ]]( self );
                return;
            }
            else
            {
                vehicle_ai::delete_riders();
                vehicle_tracking::delete_vehicle( self );
                return;
            }
        }
        else if ( node.script_noteworthy == "engineoff" )
        {
            self vehicle_turnengineoff();
            self notify( #"engineoff" );
        }
        else
        {
            self notify( node.script_noteworthy );
            self notify( #"noteworthy", node.script_noteworthy );
        }
    }
    
    if ( node.arrivedcallback )
    {
        [[ node.arrivedcallback ]]();
    }
    
    if ( node.script_badplace )
    {
        self.script_badplace = node.script_badplace;
    }
    
    if ( node.script_turretmg )
    {
        if ( node.script_turretmg )
        {
            vehicle_code::_mgon();
        }
        else
        {
            vehicle_code::_mgoff();
        }
    }
    
    if ( node.script_turretmain )
    {
        if ( node.script_turretmain )
        {
            vehicle_code::_mainturreton();
            return;
        }
        
        vehicle_code::_mainturretoff();
    }
}

// Namespace vehicle_paths
// Params 0
// Checksum 0x22f3c9eb, Offset: 0xfb8
// Size: 0x19
function delete_riders()
{
    assertmsg( "<dev string:x106>" );
    vehicle_ai::delete_riders();
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x4acdf76a, Offset: 0xfd9
// Size: 0x57, Type: bool
function islastnode( node )
{
    if ( !isdefined( node.target ) )
    {
        return true;
    }
    
    if ( !isdefined( getvehiclenode( node.target, #targetname ) ) && !isdefined( vehicle_code::get_vehiclenode_any_dynamic( node.target ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace vehicle_paths
// Params 2
// Checksum 0xd095de7, Offset: 0x1039
// Size: 0xa3, Type: bool
function vehicle_should_unload( wait_func, nextpoint )
{
    if ( !self.riders.size || !function_46f9072493651dc9( self.riders ).size )
    {
        return false;
    }
    
    if ( isdefined( nextpoint.script_unload ) )
    {
        return true;
    }
    
    if ( wait_func != &node_wait )
    {
        return false;
    }
    
    if ( self.dontunloadonend )
    {
        return false;
    }
    
    if ( self.vehicletype == "empty" || self.vehicletype == "empty_heli" )
    {
        return false;
    }
    
    if ( islastnode( nextpoint ) )
    {
        return !self.script_vehicle_selfremove;
    }
    
    return false;
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x925aa957, Offset: 0x10e5
// Size: 0x82
function overshoot_next_node( vnode )
{
    /#
        if ( !isdefined( vnode ) )
        {
            return;
        }
        
        self endon( #"delay_passed" );
        vnode waittillmatch( #"trigger", self );
        println( "<dev string:x15c>" );
        println( "<dev string:x1b5>" );
        println( "<dev string:x15c>" );
        println( "<dev string:x20e>" + vnode.origin + "<dev string:x23b>" );
        println( "<dev string:x25c>" );
        println( "<dev string:x15c>" );
    #/
}

// Namespace vehicle_paths
// Params 0
// Checksum 0x3e426ba9, Offset: 0x116f
// Size: 0xe8
function vehicle_resumepathvehicle()
{
    if ( !vehicle::ishelicopter() )
    {
        self resumespeed( 35 );
        return;
    }
    
    node = undefined;
    
    if ( isdefined( self.currentnode.target ) && !isdefined( self.currentnode.exit_node ) )
    {
        if ( isstruct( self.currentnode.target ) )
        {
            node = self.currentnode.target;
        }
        else if ( isarray( self.currentnode.target ) )
        {
            node = utility::array_random( self.currentnode.target );
        }
        else
        {
            node = vehicle_code::get_vehiclenode_any_dynamic( self.currentnode.target );
        }
    }
    
    if ( !isdefined( node ) )
    {
        return;
    }
    
    _vehicle_paths( node );
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x2146105e, Offset: 0x125f
// Size: 0xf9
function get_path_getfunc( pathpoint )
{
    get_func = &vehicle_code::get_from_vehicle_node;
    
    if ( self.usenavmesh )
    {
        get_func = &vehicle_roads::get_from_navmesh;
    }
    else if ( isstruct( pathpoint.target ) )
    {
        get_func = &vehicle_code::get_from_linkedlist;
    }
    else if ( isarray( pathpoint.target ) )
    {
        get_func = &function_f535f086527bcb5c;
    }
    else if ( vehicle::ishelicopter() && pathpoint.target )
    {
        if ( isdefined( vehicle_code::get_from_entity( pathpoint ) ) )
        {
            get_func = &vehicle_code::get_from_entity;
        }
        
        if ( isdefined( vehicle_code::get_from_spawnstruct( pathpoint ) ) )
        {
            get_func = &vehicle_code::get_from_spawnstruct;
        }
    }
    else if ( !utility::issp() && isstruct( pathpoint.target ) )
    {
        if ( isdefined( vehicle_code::get_from_spawnstruct( pathpoint ) ) )
        {
            get_func = &vehicle_code::get_from_spawnstruct;
        }
    }
    else if ( isdefined( self.custom_get_func ) )
    {
        get_func = self.custom_get_func;
    }
    
    return get_func;
}

// Namespace vehicle_paths
// Params 2, eflags: 0x4
// Checksum 0xf04dc455, Offset: 0x1361
// Size: 0x96
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
    
    if ( !isdefined( next_point ) && get_func != &vehicle_roads::get_from_navmesh )
    {
        assertmsg( "<dev string:x2b4>" + point.origin );
    }
    
    return next_point;
}

// Namespace vehicle_paths
// Params 3
// Checksum 0xd51f00fa, Offset: 0x1400
// Size: 0xa2
function struct_wait( nextpoint, lastpoint = nextpoint, dist_sq )
{
    wait 0.05;
    
    if ( lastpoint.speed >= 0 )
    {
        self vehicledriveto( nextpoint.origin, int( lastpoint.speed ) );
        
        while ( distancesquared( self.origin, nextpoint.origin ) > dist_sq )
        {
            wait 0.1;
        }
        
        return;
    }
    
    if ( lastpoint.speed < 0 )
    {
        self vehicle_setspeedimmediate( 0, 15, 15 );
    }
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x3dc88d71, Offset: 0x14aa
// Size: 0x9a
function node_wait( nextpoint, lastpoint, get_func )
{
    if ( isdefined( self.unique_id ) )
    {
        nodeflag = "node_flag_triggered" + self.unique_id;
    }
    else
    {
        nodeflag = "node_flag_triggered";
    }
    
    nodes_flag_triggered( nodeflag, nextpoint, get_func );
    
    if ( self.attachedpath == nextpoint )
    {
        self notify( #"node_wait_terminated" );
        waittillframeend();
        return;
    }
    
    nextpoint utility::ent_flag_wait_vehicle_node( nodeflag );
    nextpoint utility::ent_flag_clear( nodeflag, 1 );
    nextpoint notify( "processed_node" + nodeflag );
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x1364de66, Offset: 0x154c
// Size: 0x66
function nodes_flag_triggered( nodeflag, nextpoint, get_func )
{
    count = 0;
    
    while ( isdefined( nextpoint ) && count < 3 )
    {
        count++;
        thread node_flag_triggered( nodeflag, nextpoint );
        
        if ( !isdefined( nextpoint.target ) )
        {
            return;
        }
        
        nextpoint = get_nextpoint( get_func, nextpoint );
    }
}

// Namespace vehicle_paths
// Params 2
// Checksum 0x76f201f9, Offset: 0x15ba
// Size: 0x81
function node_flag_triggered( nodeflag, node )
{
    if ( node utility::ent_flag_exist( nodeflag ) )
    {
        return;
    }
    
    node utility::ent_flag_init( nodeflag );
    thread node_flag_triggered_cleanup( node, nodeflag );
    node endon( "processed_node" + nodeflag );
    self endon( #"death" );
    self endon( #"newpath" );
    self endon( #"node_wait_terminated" );
    node waittillmatch( #"trigger", self );
    node utility::ent_flag_set( nodeflag );
}

// Namespace vehicle_paths
// Params 2
// Checksum 0x1d36728e, Offset: 0x1643
// Size: 0x43
function node_flag_triggered_cleanup( node, nodeflag )
{
    node endon( "processed_node" + nodeflag );
    utility::waittill_any( "death", "newpath", "node_wait_terminated" );
    node utility::ent_flag_clear( nodeflag, 1 );
}

/#

    // Namespace vehicle_paths
    // Params 1
    // Checksum 0x1a9b796d, Offset: 0x168e
    // Size: 0x169, Type: dev
    function function_dabd1c63cc673a43( current_node )
    {
        if ( !isdefined( current_node ) )
        {
            return;
        }
        
        if ( !isdefined( current_node.target ) )
        {
            return;
        }
        
        duration = 3;
        total_distance = current_node.lookahead * current_node.speed;
        
        if ( total_distance < 1 )
        {
            return;
        }
        
        next_node = getvehiclenode( current_node.target, #targetname );
        nodes_passed = 0;
        
        while ( isdefined( next_node ) )
        {
            distance = distance( current_node.origin, next_node.origin );
            total_distance -= distance;
            
            if ( total_distance < 0 )
            {
                break;
            }
            
            nodes_passed++;
            
            if ( nodes_passed > 1 )
            {
                debug::sphere( next_node.origin, 16, ( 1, 1, 1 ), duration );
            }
            
            if ( isdefined( current_node.target ) )
            {
                next_node = getvehiclenode( current_node.target, #targetname );
                continue;
            }
            
            next_node = undefined;
        }
        
        if ( !isdefined( next_node ) )
        {
            return;
        }
        
        if ( nodes_passed > 1 )
        {
            debug::debug_draw_arrow( current_node.origin, next_node.origin, ( 0, 1, 0 ), 1, 0, duration );
        }
    }

#/

// Namespace vehicle_paths
// Params 1
// Checksum 0x7dab0415, Offset: 0x17ff
// Size: 0x7db
function vehicle_paths_non_heli( node )
{
    assert( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x308>" );
    self notify( #"newpath" );
    setdvarifuninitialized( @"hash_6461895a8df1c412", 0 );
    
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
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    dist_sq = 40000;
    
    if ( self.usenavmesh && self.navobstacleid )
    {
        vehicle_code::vehicle_disable_navobstacles();
        waitframe();
    }
    
    if ( self vehicle_isphysveh() && vehicle::is_boat() && self function_465bc075f810c70c() )
    {
        self function_c21d39b1929f7cb1( 0 );
    }
    
    while ( isdefined( nextpoint ) )
    {
        if ( self.usenavmesh )
        {
            vehicle_roads::navmesh_wait( nextpoint );
        }
        else if ( isfunction( self.var_38fe0b7ab5332b22 ) )
        {
            [[ self.var_38fe0b7ab5332b22 ]]( nextpoint, lastpoint, get_func, dist_sq );
        }
        else if ( !isstruct( nextpoint ) )
        {
            node_wait( nextpoint, lastpoint, get_func );
        }
        else
        {
            struct_wait( nextpoint, lastpoint, dist_sq );
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        trigger_process_node( nextpoint );
        self.currentnode = nextpoint;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"hash_6461895a8df1c412", 0 ) )
            {
                function_dabd1c63cc673a43( self.currentnode );
            }
        #/
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( vehicle_should_unload( &node_wait, nextpoint ) )
        {
            if ( islastnode( nextpoint ) )
            {
                thread unload_node( nextpoint );
            }
            else
            {
                unload_node( nextpoint );
            }
        }
        
        if ( isdefined( nextpoint.script_pathdir ) )
        {
            self.veh_pathdir = nextpoint.script_pathdir;
            vehicle::function_51906bc4fc51948( nextpoint.script_pathdir );
        }
        
        if ( isdefined( nextpoint.script_brake ) )
        {
            self.veh_brake = nextpoint.script_brake;
            
            if ( self vehicle_isphysveh() )
            {
                self vehphys_parkingbrake( 1 );
            }
        }
        
        if ( isdefined( nextpoint.script_pathtype ) )
        {
            if ( nextpoint.script_pathtype == "0" || nextpoint.script_pathtype == "1" )
            {
                nextpoint.script_pathtype = "follow";
            }
            
            self.veh_pathtype = nextpoint.script_pathtype;
        }
        
        if ( isdefined( nextpoint.script_speed ) || isdefined( nextpoint.speed ) )
        {
            accel = undefined;
            
            if ( isdefined( nextpoint.script_accel ) )
            {
                accel = nextpoint.script_accel;
            }
            
            decel = undefined;
            
            if ( isdefined( nextpoint.script_decel ) )
            {
                decel = nextpoint.script_decel;
            }
            
            if ( self vehicle_isphysveh() && !utility::ent_flag( "vehicle_paths_scripted_speed" ) )
            {
                vehicle::vehicle_set_speed( nextpoint.script_speed ?? nextpoint.speed * 0.056818, accel, decel );
            }
        }
        
        if ( isdefined( nextpoint.script_ent_flag_wait ) && !utility::ent_flag( nextpoint.script_ent_flag_wait ) )
        {
            stopped_msg = "script_ent_flag_wait_" + nextpoint.script_ent_flag_wait;
            vehicle_stop( nextpoint, stopped_msg, get_func );
            utility::ent_flag_wait( nextpoint.script_ent_flag_wait );
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            self notify( #"resumed_path" );
            _vehicle_resume_named( stopped_msg );
        }
        
        if ( isdefined( nextpoint.script_delay ) || isdefined( nextpoint.script_delay_min ) && isdefined( nextpoint.script_delay_max ) )
        {
            stopped_msg = "script_delay_" + ( nextpoint.script_delay ?? nextpoint.script_delay_min );
            vehicle_stop( nextpoint, stopped_msg, get_func );
            nextpoint utility::script_delay();
            self notify( #"delay_passed" );
            self notify( #"resumed_path" );
            _vehicle_resume_named( stopped_msg );
        }
        
        if ( isdefined( nextpoint.script_flag_wait ) || isdefined( nextpoint.script_flag_waitopen ) )
        {
            was_stopped = 0;
            var_52ea4d23844bb252 = isdefined( nextpoint.script_flag_wait ) && !utility::flag( nextpoint.script_flag_wait );
            var_e47e24cbe714049a = isdefined( nextpoint.script_flag_waitopen ) && utility::flag( nextpoint.script_flag_waitopen );
            stopped_msg = undefined;
            
            if ( var_52ea4d23844bb252 || var_e47e24cbe714049a || isdefined( nextpoint.script_delay_post ) )
            {
                was_stopped = 1;
                
                if ( var_52ea4d23844bb252 )
                {
                    stopped_msg = "script_flag_wait_" + nextpoint.script_flag_wait;
                }
                else if ( var_e47e24cbe714049a )
                {
                    stopped_msg = "script_flag_waitopen_" + nextpoint.script_flag_waitopen;
                }
                else if ( isdefined( nextpoint.script_flag_wait ) )
                {
                    stopped_msg = "script_delay_post_" + nextpoint.script_flag_wait;
                }
                else
                {
                    stopped_msg = "script_delay_post_" + nextpoint.script_flag_waitopen;
                }
                
                vehicle_stop( nextpoint, stopped_msg, get_func );
            }
            
            if ( var_52ea4d23844bb252 )
            {
                utility::flag_wait( nextpoint.script_flag_wait );
            }
            
            if ( var_e47e24cbe714049a )
            {
                utility::flag_waitopen( nextpoint.script_flag_waitopen );
            }
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
                
                if ( !isdefined( self ) )
                {
                    return;
                }
            }
            
            if ( was_stopped )
            {
                self notify( #"resumed_path" );
                _vehicle_resume_named( stopped_msg );
            }
            
            self notify( #"delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_off ) )
        {
            thread vehicle_lights::lights_off( nextpoint.script_vehicle_lights_off );
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_on ) )
        {
            thread vehicle_lights::lights_on( nextpoint.script_vehicle_lights_on );
        }
        
        if ( isdefined( nextpoint.script_forcecolor ) )
        {
            thread utility::script_func( "forcecolor_riders", nextpoint.script_forcecolor );
        }
        
        lastpoint = nextpoint;
        nextpoint = get_nextpoint( get_func, nextpoint );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            break;
        }
        
        if ( !isstring( self.veh_pathdir ) || self.veh_pathdir == "forward" )
        {
            nextpoint.prevpoint = lastpoint;
        }
    }
    
    if ( self vehicle_isphysveh() && self.var_75ea1b9acbb56f2a )
    {
        starttime = gettime();
        
        while ( true )
        {
            if ( distance2dsquared( lastpoint.origin, self.origin ) < 10000 )
            {
                break;
            }
            else if ( gettime() - starttime > 5000 )
            {
                break;
            }
            
            waitframe();
        }
        
        vehicle::vehicle_set_speed( 0 );
        
        if ( self.usenavmesh && self hascomponent( "path" ) )
        {
            self setconfigvalue( "path", "pause", 1 );
        }
    }
    
    self notify( #"reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        if ( isdefined( self.deathfunc ) )
        {
            vehicle_ai::delete_riders();
            level thread [[ self.deathfunc ]]( self );
            return;
        }
        
        vehicle_ai::delete_riders();
        vehicle_tracking::delete_vehicle( self );
    }
}

// Namespace vehicle_paths
// Params 3
// Checksum 0xe52c739e, Offset: 0x1fe2
// Size: 0x8d
function vehicle_stop( nextpoint, stopped_msg, get_func )
{
    accel = nextpoint.script_accel ?? 5;
    decel = nextpoint.script_decel ?? 20;
    _vehicle_stop_named( stopped_msg, accel, decel );
    childthread vehicle_notifyonstop();
    
    if ( get_func )
    {
        next_nextpoint = get_nextpoint( get_func, nextpoint );
        
        if ( isdefined( next_nextpoint ) )
        {
            childthread overshoot_next_node( next_nextpoint );
        }
    }
}

// Namespace vehicle_paths
// Params 0
// Checksum 0xfe134dfd, Offset: 0x2077
// Size: 0x28
function vehicle_notifyonstop()
{
    self endon( #"resumed_path" );
    
    while ( !vehicle_code::vehicle_is_stopped() )
    {
        waitframe();
    }
    
    self notify( #"stopped_path" );
}

// Namespace vehicle_paths
// Params 0
// Checksum 0x26e5f50d, Offset: 0x20a7
// Size: 0x10
function vehicle_waittill_stopped()
{
    while ( !vehicle_code::vehicle_is_stopped() )
    {
        waitframe();
    }
}

// Namespace vehicle_paths
// Params 2
// Checksum 0xc7371c29, Offset: 0x20bf
// Size: 0x24
function add_z( vec, zplus )
{
    return ( vec[ 0 ], vec[ 1 ], vec[ 2 ] + zplus );
}

// Namespace vehicle_paths
// Params 3
// Checksum 0xcde59811, Offset: 0x20ec
// Size: 0x4e8
function vehicle_paths_helicopter( node, var_ad6ef44930971fe1, elevated_heli_path )
{
    if ( self vehicle_isphysveh() )
    {
        if ( self hascomponent( "p2p" ) )
        {
            function_4e87486ece806fb1( node );
            return;
        }
        else if ( getdvarint( @"vehlegacyhelipathingforphysicshelicopters" ) == 0 )
        {
            println( "<dev string:x32d>" );
            return;
        }
    }
    
    assert( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x308>" );
    self notify( #"newpath" );
    self endon( #"newpath" );
    self endon( #"death" );
    
    if ( !isdefined( var_ad6ef44930971fe1 ) )
    {
        var_ad6ef44930971fe1 = 0;
    }
    
    if ( isdefined( node ) )
    {
        self.attachedpath = node;
    }
    
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    self.scenenode = undefined;
    self.var_cb77d7510de9ffc9 = undefined;
    
    if ( !isdefined( pathstart ) )
    {
        return;
    }
    
    if ( var_ad6ef44930971fe1 )
    {
        self waittill( #"start_dynamicpath" );
    }
    
    if ( isdefined( elevated_heli_path ) )
    {
        elevated_node = spawnstruct();
        elevated_node.origin = add_z( self.origin, elevated_heli_path );
        heli_wait_node( elevated_node, undefined );
    }
    
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    
    while ( isdefined( nextpoint ) )
    {
        if ( isdefined( nextpoint.script_linkto ) )
        {
            vehicle_code::set_lookat_from_dest( nextpoint );
        }
        
        if ( isdefined( nextpoint.script_land ) )
        {
            hasnextpoint = 0;
            
            if ( isdefined( nextpoint.target ) )
            {
                hasnextpoint = isdefined( [[ get_func ]]( nextpoint ) );
            }
            
            if ( !vehicle::is_common_vehicle() )
            {
                thread vehicle_code::vehicle_landanims( nextpoint.script_unload, hasnextpoint );
            }
        }
        
        if ( !isdefined( lastpoint ) )
        {
            if ( isdefined( self.path_start_info ) )
            {
                lastpoint = self.path_start_info;
            }
        }
        
        if ( isdefined( nextpoint.script_land ) && utility::issharedfuncdefined( #"helicopter", #"hash_a3ce13418d47712d" ) )
        {
            thread utility::callsharedfunc( #"helicopter", #"hash_a3ce13418d47712d", nextpoint.origin );
        }
        
        heli_wait_node( nextpoint, lastpoint, elevated_heli_path );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.currentnode = nextpoint;
        nextpoint notify( #"trigger", self );
        
        if ( isdefined( nextpoint.script_helimove ) )
        {
            self setyawspeedbyname( nextpoint.script_helimove );
            
            if ( nextpoint.script_helimove == "faster" )
            {
                self setmaxpitchroll( 25, 50 );
            }
        }
        
        trigger_process_node( nextpoint );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( vehicle_should_unload( &heli_wait_node, nextpoint ) )
        {
            unload_node( nextpoint );
        }
        
        if ( self vehicle_isphysveh() )
        {
            if ( isdefined( nextpoint.script_pathtype ) )
            {
                self.veh_pathtype = nextpoint.script_pathtype;
            }
        }
        
        var_4bc864ba4959433f = 0;
        
        if ( isdefined( nextpoint.script_flag_wait ) )
        {
            var_4bc864ba4959433f = 1;
            utility::flag_wait( nextpoint.script_flag_wait );
        }
        
        if ( isdefined( nextpoint.script_flag_waitopen ) )
        {
            var_4bc864ba4959433f = 1;
            utility::flag_waitopen( nextpoint.script_flag_waitopen );
        }
        
        if ( isdefined( nextpoint.script_ent_flag_wait ) )
        {
            var_4bc864ba4959433f = 1;
            utility::ent_flag_wait( nextpoint.script_ent_flag_wait );
        }
        
        if ( var_4bc864ba4959433f )
        {
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
            }
            
            self notify( #"delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_off ) )
        {
            thread vehicle_lights::lights_off( nextpoint.script_vehicle_lights_off );
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_on ) )
        {
            thread vehicle_lights::lights_on( nextpoint.script_vehicle_lights_on );
        }
        
        if ( isdefined( nextpoint.script_forcecolor ) )
        {
            thread utility::script_func( "forcecolor_riders", nextpoint.script_forcecolor );
        }
        
        lastpoint = nextpoint;
        
        if ( !isdefined( nextpoint.target ) )
        {
            break;
        }
        
        nextpoint = [[ get_func ]]( nextpoint );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            assertmsg( "<dev string:x2b4>" + lastpoint.origin );
            break;
        }
    }
    
    self notify( #"reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        vehicle_ai::delete_riders();
        
        if ( isdefined( self.deathfunc ) )
        {
            level thread [[ self.deathfunc ]]( self );
            return;
        }
        
        vehicle_tracking::delete_vehicle( self );
    }
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x895da070, Offset: 0x25dc
// Size: 0x79e
function heli_wait_node( nextpoint, lastpoint, elevated_heli_path )
{
    self endon( #"newpath" );
    self endon( #"cancel_heli_wait_node" );
    origin = nextpoint.origin;
    angles = nextpoint.angles;
    
    if ( isdefined( nextpoint.script_unload ) || isdefined( nextpoint.script_land ) )
    {
        unloadoffset = 0;
        
        if ( isdefined( nextpoint.script_land ) )
        {
            utility::ent_flag_set( "landed" );
            
            if ( isdefined( self.unload_land_offset ) )
            {
                unloadoffset = self.unload_land_offset;
            }
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset ) )
        {
            unloadoffset = self.unload_hover_offset;
        }
        else if ( isdefined( nextpoint.script_unload ) && isdefined( self.unload_hover_offset_max ) )
        {
            groundorg = utility::drop_to_ground( origin, undefined, undefined, undefined, trace::create_world_contents() );
            unloadoffset = origin[ 2 ] - groundorg[ 2 ];
            
            if ( unloadoffset >= self.unload_hover_offset_max )
            {
                unloadoffset = self.unload_hover_offset_max;
            }
            else if ( unloadoffset < self.unload_hover_land_height )
            {
                unloadoffset = self.unload_hover_land_height;
            }
        }
        
        nextpoint.radius = 2;
        
        if ( isdefined( nextpoint.ground_pos ) )
        {
            origin = nextpoint.ground_pos + ( 0, 0, unloadoffset );
        }
        else
        {
            neworg = utility::groundpos( origin ) + ( 0, 0, unloadoffset );
            
            if ( neworg[ 2 ] > origin[ 2 ] - 2000 )
            {
                origin = utility::groundpos( origin ) + ( 0, 0, unloadoffset );
            }
        }
        
        self sethoverparams( 0, 0, 0 );
    }
    
    if ( isdefined( lastpoint ) )
    {
        airresistance = lastpoint.script_airresistance;
        
        if ( isdefined( airresistance ) )
        {
            airresistance = float( airresistance );
        }
        
        speed = lastpoint.speed;
        accel = lastpoint.script_accel;
        decel = lastpoint.script_decel;
    }
    else
    {
        airresistance = undefined;
        speed = undefined;
        accel = undefined;
        decel = undefined;
    }
    
    stopnode = istrue( nextpoint.script_stopnode );
    unload = isdefined( nextpoint.script_unload );
    flag_wait = isdefined( nextpoint.script_flag_wait ) && !utility::flag( nextpoint.script_flag_wait );
    flag_wait = flag_wait || isdefined( nextpoint.script_flag_waitopen ) && utility::flag( nextpoint.script_flag_waitopen );
    flag_wait = flag_wait || isdefined( nextpoint.script_ent_flag_wait ) && utility::ent_flag( nextpoint.script_ent_flag_wait );
    var_5bdcdba698716361 = !isdefined( nextpoint.target ) && !nextpoint.var_f023f38b2d58402d;
    hasdelay = isdefined( nextpoint.script_delay ) || isdefined( nextpoint.script_delay_min ) && isdefined( nextpoint.script_delay_max );
    
    if ( isdefined( angles ) )
    {
        yaw = angles[ 1 ];
    }
    else
    {
        yaw = 0;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    if ( isdefined( elevated_heli_path ) )
    {
        origin = add_z( origin, elevated_heli_path );
    }
    
    if ( isdefined( self.heliheightoverride ) )
    {
        origin = ( origin[ 0 ], origin[ 1 ], self.heliheightoverride );
    }
    
    if ( unload && vehicle_ai::has_anim_intro() )
    {
        animation = vehicle_ai::get_intro_anim();
        
        if ( !isdefined( self.scenenode ) )
        {
            self.scenenode = { #angles:angles, #origin:utility::drop_to_ground( origin, 100, -10000, undefined, trace::create_world_contents() ) };
        }
        
        if ( !isdefined( self.scenenode.angles ) )
        {
            self.scenenode.angles = ( 0, 0, 0 );
        }
        
        origin = getstartorigin( self.scenenode.origin, self.scenenode.angles, animation );
        angles = getstartangles( self.scenenode.origin, self.scenenode.angles, animation );
        nextpoint.radius = vehicle_ai::function_3f791d10e984b5fc();
    }
    
    heli_ref = vehicle_code::get_vehicle_classname();
    
    if ( unload && utility::issharedfuncdefined( heli_ref, #"movetounload" ) )
    {
        self thread [[ utility::getsharedfunc( heli_ref, #"movetounload" ) ]]( origin, nextpoint.script_goalyaw ?? angles[ 1 ], speed, accel, decel, airresistance );
    }
    else
    {
        self vehicle_helisetai( origin, speed, accel, decel, nextpoint.script_goalyaw, nextpoint.script_anglevehicle, yaw, airresistance, hasdelay, stopnode, unload, flag_wait, var_5bdcdba698716361 );
    }
    
    if ( utility::issp() )
    {
        radius = nextpoint.radius;
    }
    else
    {
        radius = ( nextpoint.radius ?? ( nextpoint.speed ?? 60 ) * 6 ) + 200;
    }
    
    /#
        if ( getdvarint( @"hash_3c165272d6d3919", 0 ) )
        {
            start_pos = lastpoint.origin ?? self.origin;
            end_pos = origin;
            debug::line( start_pos, end_pos, undefined, 20, "<dev string:x37b>" );
            last_radius = lastpoint.radius ?? 10;
            debug::sphere( start_pos, last_radius, ( 0, 1, 0 ), 20, "<dev string:x37b>" );
            goal_color = stopnode || var_5bdcdba698716361 || unload || hasdelay || flag_wait ? ( 1, 0, 0 ) : ( 0, 1, 0 );
            debug::sphere( origin, radius, goal_color, 20, "<dev string:x37b>" );
            
            if ( nextpoint.origin != origin )
            {
                debug::sphere( nextpoint.origin, radius, goal_color, 20, "<dev string:x37b>" );
            }
        }
    #/
    
    if ( isdefined( radius ) )
    {
        self setneargoalnotifydist( radius );
        assert( radius > 0, "<dev string:x398>" + radius );
        utility::waittill_any( "near_goal", "goal" );
    }
    else
    {
        self waittill( #"goal" );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    trigger_process_node( nextpoint );
    
    /#
        if ( isdefined( nextpoint.script_flag_set ) )
        {
            self notify( #"reached_current_node", nextpoint, nextpoint.script_flag_set );
        }
        else
        {
            self notify( #"reached_current_node", nextpoint );
        }
        
        if ( getdvarint( @"hash_3c165272d6d3919", 0 ) )
        {
            level notify( #"hash_8abaecbf2548b5d7" );
        }
    #/
    
    if ( isdefined( nextpoint.script_firelink ) )
    {
        if ( !isdefined( level.helicopter_firelinkfunk ) )
        {
            assertmsg( "<dev string:x3a1>" );
        }
        
        thread [[ level.helicopter_firelinkfunk ]]( nextpoint );
    }
    
    nextpoint utility::script_delay();
    
    if ( isdefined( self.path_gobbler ) )
    {
        utility::deletestruct_ref( nextpoint );
    }
    
    self notify( #"continuepath" );
}

// Namespace vehicle_paths
// Params 2
// Checksum 0x8db0ffcf, Offset: 0x2d82
// Size: 0x340
function function_4e87486ece806fb1( node, z_axis_offset )
{
    assert( isdefined( node ) || isdefined( self.attachedpath ), "<dev string:x3e1>" );
    self notify( #"newpath" );
    self endon( #"newpath" );
    self endon( #"death" );
    
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
    
    lastpoint = undefined;
    nextpoint = pathstart;
    get_func = get_path_getfunc( pathstart );
    
    while ( isdefined( nextpoint ) )
    {
        if ( !isdefined( lastpoint ) )
        {
            if ( isdefined( self.path_start_info ) )
            {
                lastpoint = self.path_start_info;
            }
        }
        
        heli_wait_node_p2p( nextpoint, lastpoint, z_axis_offset );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        self.currentnode = nextpoint;
        nextpoint notify( #"trigger", self );
        
        if ( isdefined( nextpoint.script_helimove ) )
        {
            self setyawspeedbyname( nextpoint.script_helimove );
            
            if ( nextpoint.script_helimove == "faster" )
            {
                self setmaxpitchroll( 25, 50 );
            }
        }
        
        trigger_process_node( nextpoint );
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( isdefined( nextpoint.script_team ) )
        {
            self.script_team = nextpoint.script_team;
        }
        
        if ( self vehicle_isphysveh() )
        {
            if ( isdefined( nextpoint.script_pathtype ) )
            {
                self.veh_pathtype = nextpoint.script_pathtype;
            }
        }
        
        var_4bc864ba4959433f = 0;
        
        if ( isdefined( nextpoint.script_flag_wait ) )
        {
            var_4bc864ba4959433f = 1;
            utility::flag_wait( nextpoint.script_flag_wait );
        }
        
        if ( isdefined( nextpoint.script_flag_waitopen ) )
        {
            var_4bc864ba4959433f = 1;
            utility::flag_waitopen( nextpoint.script_flag_waitopen );
        }
        
        if ( var_4bc864ba4959433f )
        {
            if ( isdefined( nextpoint.script_delay_post ) )
            {
                wait nextpoint.script_delay_post;
            }
            
            self notify( #"delay_passed" );
        }
        
        if ( isdefined( self.set_lookat_point ) )
        {
            self.set_lookat_point = undefined;
            self clearlookatent();
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_off ) )
        {
            thread vehicle_lights::lights_off( nextpoint.script_vehicle_lights_off );
        }
        
        if ( isdefined( nextpoint.script_vehicle_lights_on ) )
        {
            thread vehicle_lights::lights_on( nextpoint.script_vehicle_lights_on );
        }
        
        if ( isdefined( nextpoint.script_forcecolor ) )
        {
            thread utility::script_func( "forcecolor_riders", nextpoint.script_forcecolor );
        }
        
        lastpoint = nextpoint;
        
        if ( !isdefined( nextpoint.target ) )
        {
            break;
        }
        
        nextpoint = [[ get_func ]]( nextpoint );
        
        if ( !isdefined( nextpoint ) )
        {
            nextpoint = lastpoint;
            assertmsg( "<dev string:x2b4>" + lastpoint.origin );
            break;
        }
    }
    
    self notify( #"reached_dynamic_path_end" );
    
    if ( isdefined( self.script_vehicle_selfremove ) )
    {
        vehicle_ai::delete_riders();
        
        if ( isdefined( self.deathfunc ) )
        {
            level thread [[ self.deathfunc ]]( self );
            return;
        }
        
        vehicle_tracking::delete_vehicle( self );
    }
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x3d68cfa6, Offset: 0x30ca
// Size: 0x1ea
function heli_wait_node_p2p( nextpoint, lastpoint, z_axis_offset )
{
    self endon( #"newpath" );
    
    if ( isdefined( nextpoint.script_unload ) || isdefined( nextpoint.script_land ) )
    {
        assertmsg( "<dev string:x41a>" );
    }
    
    yaw = 0;
    
    if ( isdefined( nextpoint.angles ) )
    {
        yaw = nextpoint.angles[ 1 ];
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    origin = nextpoint.origin;
    
    if ( isdefined( nextpoint.radius ) )
    {
        assert( nextpoint.radius > 0, "<dev string:x398>" + nextpoint.radius );
        self setconfigvalue( "p2p", "goalThreshold", nextpoint.radius );
    }
    
    if ( isdefined( z_axis_offset ) )
    {
        origin = add_z( origin, z_axis_offset );
    }
    
    self setconfigvalue( "p2p", "goalPoint", origin );
    self setconfigvalue( "p2p", "goalAngles", ( 0, yaw, 0 ) );
    self waittill( #"near_goal" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    trigger_process_node( nextpoint );
    
    /#
        if ( isdefined( nextpoint.script_flag_set ) )
        {
            self notify( #"reached_current_node", nextpoint, nextpoint.script_flag_set );
        }
        else
        {
            self notify( #"reached_current_node", nextpoint );
        }
    #/
    
    if ( isdefined( nextpoint.script_firelink ) )
    {
        if ( !isdefined( level.helicopter_firelinkfunk ) )
        {
            assertmsg( "<dev string:x3a1>" );
        }
        
        thread [[ level.helicopter_firelinkfunk ]]( nextpoint );
    }
    
    nextpoint utility::script_delay();
    
    if ( isdefined( self.path_gobbler ) )
    {
        utility::deletestruct_ref( nextpoint );
    }
    
    self notify( #"continuepath" );
}

// Namespace vehicle_paths
// Params 0
// Checksum 0x4626d0c2, Offset: 0x32bc
// Size: 0x100
function get_pathstruct()
{
    structs = utility::getstructarray( self.target, "targetname" );
    assert( structs.size != 0, "<dev string:x44f>" + self.origin + "<dev string:x45b>" );
    
    if ( structs.size == 1 )
    {
        return structs[ 0 ];
    }
    
    filtered = [];
    
    foreach ( struct in structs )
    {
        if ( !isdefined( struct.script_demeanor ) )
        {
            filtered[ filtered.size ] = struct;
        }
    }
    
    assert( filtered.size == 1, "<dev string:x44f>" + self.origin + "<dev string:x476>" );
    return filtered[ 0 ];
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x37e96d85, Offset: 0x33c5
// Size: 0x227
function getonpath( skip_attach )
{
    path_start = undefined;
    type = self.vehicletype;
    
    if ( isdefined( self.vehicle_spawner ) && self.vehicle_spawner.dontgetonpath )
    {
        return;
    }
    
    if ( isdefined( self.spawndata ) && self.spawndata.dontgetonpath )
    {
        return;
    }
    
    if ( isdefined( self.target ) )
    {
        path_start = getvehiclenode( self.target, #targetname );
        
        /#
            if ( vehicle::ishelicopter() && isdefined( path_start ) )
            {
                println( "<dev string:x4af>" + path_start.targetname );
                println( "<dev string:x4cc>" + getxhashsourcename( self.vehicletype ) );
                assertmsg( "<dev string:x4da>" );
            }
        #/
        
        if ( !isdefined( path_start ) )
        {
            path_start = utility::getstruct( self.target, "targetname" );
        }
    }
    
    if ( !isdefined( path_start ) )
    {
        if ( vehicle::ishelicopter() )
        {
            self vehicle_setspeed( 60, 20, 10 );
        }
        
        return;
    }
    
    self.attachedpath = path_start;
    
    if ( !vehicle::ishelicopter() && !isstruct( path_start ) )
    {
        self.origin = path_start.origin;
        
        if ( !isdefined( skip_attach ) )
        {
            self attachpath( path_start );
        }
    }
    else if ( isdefined( self.speed ) )
    {
        self vehicle_setspeedimmediate( self.speed, 20 );
    }
    else if ( isdefined( path_start.speed ) )
    {
        accel = 20;
        decel = 10;
        
        if ( isdefined( path_start.script_accel ) )
        {
            accel = path_start.script_accel;
        }
        
        if ( isdefined( path_start.script_decel ) )
        {
            accel = path_start.script_decel;
        }
        
        speedfloat = float( path_start.speed );
        self vehicle_setspeedimmediate( speedfloat, accel, decel );
    }
    else
    {
        self vehicle_setspeed( 60, 20, 10 );
    }
    
    thread _vehicle_paths( undefined, vehicle::ishelicopter() );
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x97874947, Offset: 0x35f4
// Size: 0xc5
function _vehicle_resume_named( stop_name )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"vehicle_resume" ) )
    {
        utility::callsharedfunc( #"vehicle", #"vehicle_resume", stop_name );
        return;
    }
    
    resume_speed = self.vehicle_stop_named[ stop_name ];
    self.vehicle_stop_named[ stop_name ] = undefined;
    
    if ( self.vehicle_stop_named.size )
    {
        return;
    }
    
    if ( self hascomponent( "path" ) )
    {
        self setconfigvalue( "path", "resume", 1 );
    }
    
    if ( self hascomponent( "p2p" ) )
    {
        self setconfigvalue( "p2p", "manualSpeed", resume_speed * 17.6 );
        return;
    }
    
    vehicle::vehicle_resume_speed( resume_speed );
}

// Namespace vehicle_paths
// Params 3
// Checksum 0xde903ccb, Offset: 0x36c1
// Size: 0x119
function _vehicle_stop_named( stop_name, acceleration, deceleration )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"vehicle_stop" ) )
    {
        utility::callsharedfunc( #"vehicle", #"vehicle_stop", stop_name, acceleration, deceleration );
        return;
    }
    
    if ( !isdefined( self.vehicle_stop_named ) )
    {
        self.vehicle_stop_named = [];
    }
    
    assert( !isdefined( self.vehicle_stop_named[ stop_name ] ), "<dev string:x50d>" );
    
    if ( self hascomponent( "p2p" ) )
    {
        self.vehicle_stop_named[ stop_name ] = self function_24e10bf6894fa869( "p2p", "manualSpeed" ) * 0.056818;
    }
    else if ( self hascomponent( "c2p" ) )
    {
        self.vehicle_stop_named[ stop_name ] = self function_24e10bf6894fa869( "path", "targetSpeed" ) * 0.056818;
    }
    else
    {
        self.vehicle_stop_named[ stop_name ] = acceleration;
    }
    
    vehicle::vehicle_set_speed( 0, acceleration, deceleration );
    
    if ( self hascomponent( "c2p" ) )
    {
        thread function_c817bde167e99ca6();
    }
}

// Namespace vehicle_paths
// Params 0, eflags: 0xc
// Checksum 0xcdde9af1, Offset: 0x37e2
// Size: 0x53
function private function_c817bde167e99ca6()
{
    self notify( #"hash_56cedeeefe5784f3" );
    self endon( #"hash_56cedeeefe5784f3" );
    self endon( #"resumed_path" );
    
    while ( !vehicle_code::vehicle_is_stopped() )
    {
        waitframe();
    }
    
    if ( self hascomponent( "path" ) )
    {
        self setconfigvalue( "path", "pause", 1 );
    }
}

// Namespace vehicle_paths
// Params 1
// Checksum 0x9dd44de3, Offset: 0x383d
// Size: 0x308
function unload_node( node )
{
    self endon( #"death" );
    ishelicopter = vehicle::ishelicopter();
    var_45ed96868035eded = !ishelicopter && !islastnode( node );
    utility::ent_flag_set( "unload_node" );
    
    if ( isdefined( node.targetname ) )
    {
        pathnode = getnode( node.targetname, #target );
        
        if ( isdefined( pathnode ) && self.riders.size )
        {
            foreach ( rider in self.riders )
            {
                if ( isai( rider ) )
                {
                    rider thread utility::script_func( "go_to_node", pathnode );
                }
            }
        }
    }
    
    if ( ishelicopter )
    {
        if ( vehicle_ai::has_anim_intro() )
        {
            self function_d2b8ee2e1275daaf( 1 );
            vehicle::blend_into_animation( vehicle_ai::get_intro_anim(), self.scenenode.origin, self.scenenode.angles );
        }
        else
        {
            self sethoverparams( 0, 0, 0 );
            vehicle_code::waittill_stable( node );
        }
    }
    else if ( var_45ed96868035eded )
    {
        accel = 5;
        decel = 20;
        stop_msg = "unloading_" + gettime();
        _vehicle_stop_named( stop_msg, accel, decel );
        childthread vehicle_notifyonstop();
    }
    
    if ( node.script_noteworthy == "wait_for_flag" )
    {
        utility::flag_wait( node.script_flag );
    }
    
    if ( isdefined( node.script_unload ) )
    {
        if ( node.script_unload == "1" )
        {
            node.script_unload = "default";
        }
    }
    
    var_9a90df07a9fe1a03 = vehicle_aianim::function_b7200b981d41e212( node.script_unload );
    script_unload = vehicle_ai::get_unload_group( node.script_unload );
    
    if ( ( script_unload == "moving" || node.script_exittype ) && vehicle::is_common_vehicle() )
    {
        vehicle_ai::unload( 0, node.script_exittype, script_unload );
    }
    else
    {
        var_9a90df07a9fe1a03 = vehicle_code::_vehicle_unload( script_unload );
        
        if ( vehicle_aianim::riders_unloadable( script_unload ) )
        {
            self waittill( #"unloaded" );
        }
    }
    
    if ( isdefined( node.script_flag_wait ) || isdefined( node.script_flag_waitopen ) || isdefined( node.script_delay ) )
    {
        return var_9a90df07a9fe1a03;
    }
    
    if ( var_45ed96868035eded )
    {
        self notify( #"resumed_path" );
        _vehicle_resume_named( stop_msg );
    }
    
    utility::ent_flag_clear( "unload_node" );
    return var_9a90df07a9fe1a03;
}

// Namespace vehicle_paths
// Params 1
// Checksum 0xd63e9ce5, Offset: 0x3b4e
// Size: 0x88
function function_f535f086527bcb5c( node )
{
    if ( node.target.size == 1 )
    {
        return node.target[ 0 ];
    }
    
    if ( isdefined( node.target[ self.choices[ node.unique_id ] ] ) )
    {
        return node.target[ self.choices[ node.unique_id ] ];
    }
    
    return utility::array_random( node.target );
}

// Namespace vehicle_paths
// Params 0
// Checksum 0x544900a9, Offset: 0x3bde
// Size: 0x16, Type: bool
function function_6e0299322df95add()
{
    function_e8bcb2225f1b8f0e( [] );
    return self.target.size > 0;
}

// Namespace vehicle_paths
// Params 0
// Checksum 0xba8811e2, Offset: 0x3bfd
// Size: 0xcd, Type: bool
function function_f497e27675f2993a()
{
    if ( !isdefined( self.script_unload ) )
    {
        self.script_unload = "default";
    }
    
    foreach ( root_node in function_49a1aee62245084() )
    {
        root_node function_e8bcb2225f1b8f0e( [] );
    }
    
    return isdefined( self.target ) && !arraycompare( self.target, [ self ] ) && !arraycompare( self.rootnodes, [ self ] );
}

// Namespace vehicle_paths
// Params 0, eflags: 0x4
// Checksum 0x49ea784b, Offset: 0x3cd3
// Size: 0x136
function private function_49a1aee62245084()
{
    var_7237854e3be197ca = self.rootnodes;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( isdefined( self.targetname ) )
    {
        prev = utility::getstructarray( self.targetname, "target" );
        
        if ( prev.size == 0 )
        {
            assertmsg( "<dev string:x52d>" + self.origin );
            self.rootnodes = [ self ];
            return self.rootnodes;
        }
        
        roots = [];
        
        foreach ( struct in prev )
        {
            roots = arraycombineunique( roots, struct function_49a1aee62245084() );
        }
        
        self.rootnodes = roots;
        return self.rootnodes;
    }
    
    self.rootnodes = [ self ];
    return self.rootnodes;
}

// Namespace vehicle_paths
// Params 1, eflags: 0x4
// Checksum 0x6851a5f6, Offset: 0x3e11
// Size: 0x17e
function private function_e8bcb2225f1b8f0e( choices )
{
    isunload = isdefined( self.script_unload );
    
    if ( isunload )
    {
        if ( !isdefined( self.choices ) )
        {
            self.choices = [];
        }
        
        if ( !isdefined( self.ground_pos ) )
        {
            self.ground_pos = utility::groundpos( self.origin );
        }
        
        choices = function_c6c06162c8e6ae75( self.choices, choices );
        self.choices = choices;
    }
    
    var_978a6ddd4227c5d6 = 0;
    
    if ( isstring( self.target ) )
    {
        self.target = utility::getstructarray( self.target, "targetname" );
        var_978a6ddd4227c5d6 = self.target.size > 1 && !isunload;
        
        if ( var_978a6ddd4227c5d6 && !isdefined( self.unique_id ) )
        {
            flags::assign_unique_id();
        }
    }
    
    if ( isdefined( self.target ) )
    {
        foreach ( index, next in self.target )
        {
            if ( var_978a6ddd4227c5d6 )
            {
                choices[ self.unique_id ] = index;
            }
            
            next function_e8bcb2225f1b8f0e( choices );
        }
    }
}

// Namespace vehicle_paths
// Params 0
// Checksum 0xd7ded0fc, Offset: 0x3f97
// Size: 0x88
function function_ce159681d679b75e()
{
    if ( isdefined( self.rootnodes ) )
    {
        foreach ( node in self.rootnodes )
        {
            node function_668194c122139323();
        }
    }
}

// Namespace vehicle_paths
// Params 0, eflags: 0x4
// Checksum 0x8d24ccc5, Offset: 0x4027
// Size: 0xd1
function private function_668194c122139323()
{
    self.targetname = undefined;
    self.script_cs_flag = undefined;
    rootnodes = self.rootnodes;
    
    if ( !isdefined( self.script_unload ) )
    {
        self.rootnodes = undefined;
        self.script_poi = undefined;
    }
    
    if ( isdefined( self.target ) )
    {
        foreach ( node in self.target )
        {
            node function_668194c122139323();
        }
    }
}

/#

    // Namespace vehicle_paths
    // Params 1
    // Checksum 0x1cd5bd71, Offset: 0x4100
    // Size: 0x1aa, Type: dev
    function function_596216f58c3ed542( duration )
    {
        if ( !isdefined( duration ) )
        {
            duration = 100000;
        }
        
        foreach ( node in self.rootnodes ?? [ self ] )
        {
            sphere( node.origin, 300, ( 0, 1, 0 ), 1, duration );
            print3d( node.origin + ( 0, 0, 150 ), "<dev string:x5a8>", ( 1, 1, 1 ), 1, 2, duration, 1 );
            print3d( node.origin + ( 0, 0, 100 ), "<dev string:x5b3>" + node.origin, ( 1, 1, 1 ), 1, 2, duration, 1 );
            
            if ( node.vehicletype )
            {
                print3d( node.origin + ( 0, 0, 50 ), "<dev string:x4cc>" + getxhashsourcename( node.vehicletype ), ( 1, 1, 1 ), 1, 2, duration, 1 );
            }
            
            node function_584f61b8bbf3b638( isdefined( node.script_unload ), duration );
        }
    }

    // Namespace vehicle_paths
    // Params 2, eflags: 0x4
    // Checksum 0x3d3d19ea, Offset: 0x42b2
    // Size: 0x4f2, Type: dev
    function private function_584f61b8bbf3b638( is_exit, duration )
    {
        utility::draw_angles( self.angles, self.origin, undefined, duration, 100 );
        
        if ( isdefined( self.target ) )
        {
            foreach ( node in self.target )
            {
                line( self.origin, node.origin, is_exit ? ( 1, 0, 0 ) : ( 0, 1, 0 ), 1, 1, duration );
                
                if ( isdefined( node.script_unload ) )
                {
                    sphere( node.origin, 300, ( 0, 0, 1 ), 1, duration );
                    unload = node.script_unload == "<dev string:x5bc>" || node.script_unload == "<dev string:x5be>" ? "<dev string:x5c6>" : node.script_unload;
                    print3d( node.origin, "<dev string:x5ca>" + unload, ( 1, 1, 1 ), 1, 2, duration, 1 );
                    
                    if ( node.script_vehiclerefs )
                    {
                        print3d( node.origin + ( 0, 0, 50 ), "<dev string:x5da>" + node.script_vehiclerefs, ( 1, 1, 1 ), 1, 2, duration, 1 );
                    }
                    else if ( node.script_vehiclebundle )
                    {
                        print3d( node.origin + ( 0, 0, 50 ), "<dev string:x5ef>" + getxhashsourcename( node.script_vehiclebundle ), ( 1, 1, 1 ), 1, 2, duration, 1 );
                    }
                    else
                    {
                        print3d( node.origin + ( 0, 0, 50 ), "<dev string:x606>" + ( node.script_vehicleref ?? "<dev string:x61a>" ), ( 1, 1, 1 ), 1, 2, duration, 1 );
                    }
                    
                    print3d( node.origin + ( 0, 0, 100 ), "<dev string:x5b3>" + node.origin, ( 1, 1, 1 ), 1, 2, duration, 1 );
                    print3d( node.origin + ( 0, 0, 150 ), "<dev string:x624>", ( 1, 1, 1 ), 1, 2, duration, 1 );
                }
                
                if ( isdefined( node.radius ) )
                {
                    print3d( node.origin - ( 0, 0, 50 ), "<dev string:x398>" + node.radius, ( 1, 1, 1 ), 1, 2, duration, 1 );
                }
                
                if ( isdefined( node.speed ) )
                {
                    print3d( node.origin - ( 0, 0, 100 ), "<dev string:x630>" + node.speed, ( 1, 1, 1 ), 1, 2, duration, 1 );
                }
                
                if ( isdefined( node.script_accel ) )
                {
                    print3d( node.origin - ( 0, 0, 150 ), "<dev string:x638>" + node.script_accel, ( 1, 1, 1 ), 1, 2, duration, 1 );
                }
                
                if ( isdefined( node.script_decel ) )
                {
                    print3d( node.origin - ( 0, 0, 200 ), "<dev string:x647>" + node.script_decel, ( 1, 1, 1 ), 1, 2, duration, 1 );
                }
                
                if ( node.vehicletype )
                {
                    print3d( node.origin + ( 0, 0, 100 ), "<dev string:x4cc>" + getxhashsourcename( node.vehicletype ), ( 1, 1, 1 ), 1, 2, duration, 1 );
                }
                
                node function_584f61b8bbf3b638( is_exit || isdefined( node.script_unload ), duration );
            }
        }
    }

#/

// Namespace vehicle_paths
// Params 4
// Checksum 0x5bd2a74a, Offset: 0x47ac
// Size: 0x51
function function_90c1230ca7860463( value, key, origin, radiuscheck = 2000 )
{
    nodes = getvehiclenodearray( value, key );
    nodes = sortbydistancecullbyradius( nodes, origin, radiuscheck );
    return nodes[ 0 ];
}

// Namespace vehicle_paths
// Params 4
// Checksum 0xa0545f19, Offset: 0x4806
// Size: 0x53
function function_7425a3e7418fac8( value, key, origin, radiuscheck = 2000 )
{
    nodes = utility::getstructarray( value, key );
    nodes = sortbydistancecullbyradius( nodes, origin, radiuscheck );
    return nodes[ 0 ];
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x5b82e14f, Offset: 0x4862
// Size: 0x127
function function_4977c502edc6c430( value, key, radiuscheck = 2000 )
{
    forwardnode = undefined;
    nodes = getvehiclenodearray( value, key );
    nodes = sortbydistancecullbyradius( nodes, self.origin, radiuscheck );
    forwardflat = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
    
    foreach ( node in nodes )
    {
        normal = vectornormalize( utility::flat_origin( node.origin ) - utility::flat_origin( self.origin ) );
        dot = vectordot( forwardflat, normal );
        
        if ( dot > 0 )
        {
            return node;
        }
    }
}

// Namespace vehicle_paths
// Params 2
// Checksum 0xbfeae840, Offset: 0x4991
// Size: 0x75
function function_5d0f296ef68c3d46( node, pos )
{
    assert( isdefined( node.target ) );
    nextnode = getvehiclenode( node.target, #targetname );
    point = pointonsegmentnearesttopoint( node.origin, nextnode.origin, pos );
    return point;
}

// Namespace vehicle_paths
// Params 2
// Checksum 0x2b6dc0e2, Offset: 0x4a0f
// Size: 0x125
function function_c5323f2b6fbd2ecf( node, dist )
{
    if ( !node.target )
    {
        return;
    }
    
    startnode = node;
    prevnode = node;
    remainingdist = dist;
    targetlength = 0;
    
    do
    {
        remainingdist = dist - targetlength;
        nextnode = getvehiclenode( startnode.target, #targetname );
        targetdir = nextnode.origin - startnode.origin;
        targetlength = length( targetdir );
        var_6a55bb6c90005b33 = vectornormalize( targetdir );
        prevnode = startnode;
        startnode = nextnode;
    }
    while ( targetlength < remainingdist && startnode.target );
    
    if ( targetlength > remainingdist )
    {
        targetdir = startnode.origin - prevnode.origin;
        var_6a55bb6c90005b33 = vectornormalize( targetdir );
        point = prevnode.origin + remainingdist * var_6a55bb6c90005b33;
        return point;
    }
    
    return startnode.origin;
}

// Namespace vehicle_paths
// Params 2
// Checksum 0xe25554af, Offset: 0x4b3d
// Size: 0x14d
function function_3af3e800ea34763f( node, origin )
{
    startnode = node;
    prevnode = node;
    is_struct = isstruct( node );
    nextnode = function_47eb09e1fb494ee5( node.target, "targetname", is_struct );
    lastpoint = pointonsegmentnearesttopoint( prevnode.origin, nextnode.origin, origin );
    lastdistsqrd = distancesquared( lastpoint, origin );
    data = spawnstruct();
    
    while ( nextnode != startnode )
    {
        prevnode = nextnode;
        nextnode = function_47eb09e1fb494ee5( nextnode.target, "targetname", is_struct );
        point = pointonsegmentnearesttopoint( prevnode.origin, nextnode.origin, origin );
        distsqrd = distancesquared( point, origin );
        
        if ( distsqrd > lastdistsqrd )
        {
            data.pos = lastpoint;
            data.nextnode = nextnode;
            data.prevnode = prevnode;
            break;
        }
        
        lastdistsqrd = distsqrd;
        lastpoint = point;
        
        if ( nextnode == startnode )
        {
            break;
        }
    }
    
    return data;
}

// Namespace vehicle_paths
// Params 3
// Checksum 0xdf2279fb, Offset: 0x4c93
// Size: 0x38
function function_47eb09e1fb494ee5( value, key, is_struct )
{
    if ( is_struct )
    {
        return utility::getstruct( value, key );
    }
    
    return getvehiclenode( value, key );
}

// Namespace vehicle_paths
// Params 3
// Checksum 0x2525e2e5, Offset: 0x4cd3
// Size: 0x38
function function_30d7403e1f422766( value, key, is_struct )
{
    if ( is_struct )
    {
        return utility::getstructarray( value, key );
    }
    
    return getvehiclenodearray( value, key );
}

// Namespace vehicle_paths
// Params 2
// Checksum 0x2711e9f7, Offset: 0x4d13
// Size: 0x9b
function function_130e9b7e55701b39( node, nodearray )
{
    foreach ( n in nodearray )
    {
        if ( node.script_noteworthy == n.script_noteworthy )
        {
            return n;
        }
    }
}

// Namespace vehicle_paths
// Params 0
// Checksum 0x5590803f, Offset: 0x4db6
// Size: 0x101
function function_a2e57b598f36d85c()
{
    if ( !isdefined( self.segmentdist ) )
    {
        nodes = function_30d7403e1f422766( self.targetname, "target", isstruct( self ) );
        prevnode = undefined;
        
        if ( nodes.size > 1 )
        {
            foreach ( node in nodes )
            {
                if ( node.script_noteworthy == self.script_noteworthy )
                {
                    prevnode = node;
                    break;
                }
            }
        }
        else
        {
            prevnode = nodes[ 0 ];
        }
        
        self.segmentdist = distance( prevnode.origin, self.origin );
    }
    
    return self.segmentdist;
}

// Namespace vehicle_paths
// Params 4
// Checksum 0x2db645e7, Offset: 0x4ec0
// Size: 0x2f6
function function_92bf30cce4141ecb( origin, node, dist, var_a7b05ea697da616a )
{
    data = spawnstruct();
    
    if ( var_a7b05ea697da616a )
    {
        var_4b440261c7222eb9 = function_3af3e800ea34763f( node, origin );
        data.pos = var_4b440261c7222eb9.pos;
        node = var_4b440261c7222eb9.prevnode;
    }
    else
    {
        data.pos = origin;
    }
    
    is_struct = isstruct( node );
    isnegative = dist < 0;
    
    if ( isnegative )
    {
        dist *= -1;
    }
    
    if ( isnegative )
    {
        if ( is_struct )
        {
            nextnodes = utility::getstructarray( node.targetname, "target" );
            nextnode = function_130e9b7e55701b39( node, nextnodes );
            nextnodes = utility::getstructarray( nextnode.targetname, "target" );
        }
        else
        {
            nextnode = getvehiclenode( node.targetname, #target );
            nextnodes = getvehiclenodearray( nextnode.targetname, #target );
        }
        
        nextnodes = function_30d7403e1f422766( node.targetname, "target", is_struct );
        nextnode = function_130e9b7e55701b39( node, nextnodes );
    }
    else
    {
        nextnode = function_47eb09e1fb494ee5( node.target, "targetname", is_struct );
    }
    
    data.node = nextnode;
    currpos = data.pos;
    var_604b2d02a0780914 = 0;
    points = [];
    points[ 0 ] = currpos;
    
    while ( true )
    {
        if ( !isdefined( nextnode ) )
        {
            break;
        }
        
        if ( !var_604b2d02a0780914 )
        {
            temp = distance( currpos, nextnode.origin );
        }
        else if ( dist < nextnode function_a2e57b598f36d85c() )
        {
            temp = dist;
        }
        else
        {
            temp = nextnode function_a2e57b598f36d85c();
        }
        
        dist -= temp;
        
        if ( dist <= 0 )
        {
            dist += temp;
            dir = vectornormalize( nextnode.origin - currpos );
            data.pos = currpos + dir * dist;
            points[ points.size ] = data.pos;
            
            if ( isnegative )
            {
                nextnode = function_47eb09e1fb494ee5( nextnode.target, "targetname", is_struct );
            }
            
            data.node = nextnode;
            break;
        }
        
        currpos = nextnode.origin;
        var_604b2d02a0780914 = 1;
        points[ points.size ] = currpos;
        
        if ( isnegative )
        {
            nextnodes = function_30d7403e1f422766( nextnode.targetname, "target", is_struct );
        }
        else
        {
            nextnodes = function_30d7403e1f422766( nextnode.target, "targetname", is_struct );
        }
        
        nextnode = function_130e9b7e55701b39( nextnode, nextnodes );
    }
    
    return data;
}

