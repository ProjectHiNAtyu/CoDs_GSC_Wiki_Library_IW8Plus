// script_e9bca00ec07d3c6  (hash_0e9bca00ec07d3c6.gscc) (size: 10884 Bytes / 0x2a84 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87cf7d4a (2278522186)
// size ...... 10884 (0x2a84)
// includes .. 8   (offset: 0x2978)
// strings ... 12  (offset: 0x29b8)
// dev strs .. 2   (offset: 0x2a6c)
// exports ... 27  (offset: 0x1b14)
// cseg ...... 0x106 + 0x1a0e (0x1b14)
// imports ... 86  (offset: 0x1f4c)
// animtree1 . 0   (offset: 0x2a84)
// animtree2 . 0   (offset: 0x2a84)
#using scripts\common\ai;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_tracking;

#namespace namespace_37f5741ccbccb7a;

// Namespace namespace_37f5741ccbccb7a
// Params 0
// Checksum 0xd90c76ac, Offset: 0x124
// Size: 0x64
function function_c2d182d5a2dfe516()
{
    level.var_c821aa8c43e82f34 = &ai_spawn_director_heli_spawn;
    level.var_72afad3b18c5afeb = &ai_spawn_director_heli_follow_path;
    level.var_c93b79fe56d4bc24 = &ai_spawn_director_heli_finddroplocation;
    level.var_9493b2d912494ad4 = &function_d3c71c9947aada0b;
    level.var_9cb9fae12c50f1da = &function_c2902224b0903337;
    level.var_1f934f93ea828060 = &ai_spawn_director_heli_land;
    level.var_a31dffeac0119947 = &ai_spawn_director_heli_cleanup;
}

// Namespace namespace_37f5741ccbccb7a
// Params 8
// Checksum 0x531feb5f, Offset: 0x190
// Size: 0x19b
function ai_spawn_director_heli_spawn( spawnnode, is_landed, heli_ref, var_b3d18d4778197ab5, heli_team, model_name, skinoverride, requestid )
{
    assert( isdefined( heli_ref ) );
    heli = undefined;
    
    if ( !isdefined( is_landed ) )
    {
        is_landed = 0;
    }
    
    if ( !isdefined( var_b3d18d4778197ab5 ) )
    {
        var_b3d18d4778197ab5 = 1;
    }
    
    spawndata = spawnstruct();
    spawndata.origin = spawnnode.origin + ( 0, 0, 128 );
    spawndata.angles = ( 0, 0, 0 );
    spawndata.initai = 1;
    
    if ( isdefined( skinoverride ) )
    {
        spawndata.var_305ce2bb6ec0993d = skinoverride;
    }
    
    if ( isdefined( spawnnode.angles ) )
    {
        spawndata.angles = ( 0, spawnnode.angles[ 1 ], 0 );
    }
    
    spawndata.team = heli_team;
    
    if ( isdefined( level.var_bda580f876415726 ) )
    {
        [[ level.var_bda580f876415726 ]]( requestid, heli_ref, spawndata );
    }
    
    heli = vehicle::spawn( heli_ref, spawndata );
    assert( isdefined( heli ), "<dev string:x24>" );
    
    if ( isdefined( heli ) )
    {
        heli.directorrequestid = requestid;
        heli.is_landed = is_landed;
        heli.vehiclename = heli_ref;
        function_3b2957f0d5f9eb4a( requestid, heli );
        level.var_ad5e0ea91bb718a4 = gettime();
    }
    
    return heli;
}

// Namespace namespace_37f5741ccbccb7a
// Params 0
// Checksum 0x9b4ce56c, Offset: 0x334
// Size: 0x14c
function ai_spawn_director_heli_init()
{
    self.speed = 100;
    self.usedpositions = [];
    self.originalspeed = self.speed;
    self.accel = 50;
    self.heightoffset = ( 0, 0, 1280 );
    self setmaxpitchroll( 15, 15 );
    self vehicle_setspeed( self.speed, self.accel );
    
    if ( self.is_landed )
    {
        self sethoverparams( 0, 0, 0 );
    }
    else
    {
        self sethoverparams( 50, 5, 2.5 );
    }
    
    self setturningability( 0.5 );
    self setyawspeed( 100, 25, 25, 0.1 );
    self setcandamage( 1 );
    self setneargoalnotifydist( 512 );
    
    if ( isdefined( self.team ) )
    {
        self setvehicleteam( self.team );
    }
    
    self.ignorelist = [ self ];
    self.crashoffset = 1030;
    self.currenthealth = 1250;
    self.health = 1250;
    self.maxhealth = 1250;
    self.damagestate = 0;
    self.attackers = [];
    thread ai_spawn_director_heli_watchdestroyed();
    
    if ( !isdefined( level.averagealliesz ) )
    {
        level.averagealliesz = 0;
    }
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0x2638da97, Offset: 0x488
// Size: 0xa4
function ai_spawn_director_heli_takeoff( target_location )
{
    self notify( #"new_orders" );
    self endon( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    if ( !isdefined( target_location ) )
    {
        target_location = self.origin;
    }
    
    self sethoverparams( 50, 5, 2.5 );
    self vehicle_setspeed( 40, 15 );
    wait 2;
    function_b9ae49c583ce9344( target_location, 1 );
    self.is_landed = 0;
    self vehicle_setspeed( self.originalspeed, self.accel );
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0xd79e9b21, Offset: 0x534
// Size: 0xd0
function ai_spawn_director_heli_land( target_location )
{
    self notify( #"new_orders" );
    self endon( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    
    if ( !isdefined( target_location ) )
    {
        target_location = self.origin;
    }
    
    if ( !isvector( target_location ) )
    {
        target_location = target_location.origin;
    }
    
    function_b9ae49c583ce9344( target_location, 1, 2000 );
    
    while ( distance2dsquared( self.origin, target_location ) > 65536 )
    {
        waitframe();
    }
    
    self vehicle_setspeed( 40, 15 );
    function_b9ae49c583ce9344( target_location, 1, 128 );
    self.is_landed = 1;
    self notify( #"ai_spawn_director_heli_landed" );
    self sethoverparams( 0, 0, 0 );
}

// Namespace namespace_37f5741ccbccb7a
// Params 2
// Checksum 0xfecd27c, Offset: 0x60c
// Size: 0xdf
function ai_spawn_director_heli_follow_path( start_node, activityinstance )
{
    self notify( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"new_orders" );
    self.next_target = start_node;
    path_end = 0;
    
    while ( !path_end )
    {
        if ( !isdefined( self.next_target.target ) )
        {
            path_end = 1;
            self notify( #"hash_f9c98fc69d6a7e14" );
        }
        
        function_b9ae49c583ce9344( self.next_target, path_end, 2000 );
        
        if ( !path_end )
        {
            self.next_target = getvehiclenode( self.next_target.target, #targetname );
        }
        
        waitframe();
    }
}

// Namespace namespace_37f5741ccbccb7a
// Params 5
// Checksum 0xbac76f03, Offset: 0x6f3
// Size: 0x22c
function function_b9ae49c583ce9344( target, forcestopatgoal, forceheight, ignoreblocks, goalyaw )
{
    self notify( #"state_change" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    newpos = undefined;
    testtarget = target;
    
    if ( !isvector( target ) )
    {
        testtarget = target.origin;
    }
    
    while ( !isdefined( self.ignorelist ) )
    {
        waitframe();
    }
    
    heli_ref = vehicle_code::get_vehicle_classname();
    
    while ( true )
    {
        currentpos = self.origin;
        initialgoalpos = testtarget * ( 1, 1, 0 ) + ( 0, 0, self.origin[ 2 ] );
        obstructed = 0;
        xpos = testtarget[ 0 ];
        ypos = testtarget[ 1 ];
        
        if ( ignoreblocks )
        {
            obstructiontrace = trace::sphere_trace( currentpos, initialgoalpos, 256, self.ignorelist );
            
            if ( isdefined( obstructiontrace ) )
            {
                if ( obstructiontrace[ "hittype" ] != "hittype_none" )
                {
                    xpos = obstructiontrace[ "position" ][ 0 ];
                    ypos = obstructiontrace[ "position" ][ 1 ];
                    obstructed = 1;
                }
            }
        }
        
        if ( isdefined( forceheight ) )
        {
            newpos = testtarget + ( 0, 0, forceheight );
        }
        else
        {
            properz = function_4fc127c587aea192( xpos, ypos, 20 );
            newpos = ( xpos, ypos, properz );
        }
        
        stopatgoal = 0;
        
        if ( forcestopatgoal && !obstructed )
        {
            stopatgoal = forcestopatgoal;
        }
        
        if ( utility::issharedfuncdefined( heli_ref, #"movetoposition" ) )
        {
            self [[ utility::getsharedfunc( heli_ref, #"movetoposition" ) ]]( newpos, stopatgoal );
        }
        else
        {
            self setvehgoalpos( newpos, stopatgoal );
        }
        
        if ( isdefined( goalyaw ) )
        {
            self setgoalyaw( goalyaw );
        }
        
        utility::waittill_any( "goal", "near_goal", "begin_evasive_maneuvers" );
        
        if ( !obstructed )
        {
            break;
        }
    }
}

// Namespace namespace_37f5741ccbccb7a
// Params 3
// Checksum 0xefee027e, Offset: 0x927
// Size: 0x5b
function function_4fc127c587aea192( x, y, rand )
{
    offgroundheight = 1280;
    groundheight = function_9c086ba1d4acc93f( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace namespace_37f5741ccbccb7a
// Params 2
// Checksum 0xc826797f, Offset: 0x98b
// Size: 0x158
function function_9c086ba1d4acc93f( x, y )
{
    self endon( #"death" );
    self endon( #"acquiringtarget" );
    self endon( #"leaving" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = level.averagealliesz;
    ignorelist = [ self ];
    
    if ( isdefined( self.dropcrates ) )
    {
        foreach ( crate in self.dropcrates )
        {
            ignorelist[ ignorelist.size ] = crate;
        }
    }
    
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 800, ignorelist, undefined, 1 );
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace namespace_37f5741ccbccb7a
// Params 0
// Checksum 0x60ac3bf5, Offset: 0xaec
// Size: 0x8b
function ai_spawn_director_heli_watchdestroyed()
{
    level endon( #"game_ended" );
    self endon( #"ai_spawn_director_heli_landed" );
    
    while ( isdefined( self ) && self.health > 0 )
    {
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"iskillstreakweapon" ) )
    {
        if ( ![[ utility::getsharedfunc( #"killstreak", #"iskillstreakweapon" ) ]]( self.killedbyweapon ) )
        {
            ai_spawn_director_heli_crash( 100 );
        }
    }
    
    ai_spawn_director_heli_explode();
}

// Namespace namespace_37f5741ccbccb7a
// Params 0
// Checksum 0x59ae0a3d, Offset: 0xb7f
// Size: 0x9d
function ai_spawn_director_heli_explode()
{
    self notify( #"explode" );
    self notify( #"state_change" );
    self radiusdamage( self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp" );
    self setscriptablepartstate( "explode", "on", 0 );
    wait 0.35;
    
    if ( isdefined( self ) )
    {
        self dodamage( self.maxhealth + 100000, self.origin, undefined, undefined, "MOD_SUICIDE" );
        self radiusdamage( self.origin, 1000, 200, 200, undefined, "MOD_EXPLOSIVE", "chopper_support_turret_mp" );
    }
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0xc4df6307, Offset: 0xc24
// Size: 0x15f
function ai_spawn_director_heli_crash( speed )
{
    self endon( #"explode" );
    self setscriptablepartstate( "crash", "on", 0 );
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament unlink();
        self.killcament.origin = self.origin + ( 0, 0, 100 );
    }
    
    self clearlookatent();
    self notify( #"crashing" );
    self.iscrashing = 1;
    self vehicle_setspeed( speed, 20, 20 );
    self setneargoalnotifydist( 100 );
    
    foreach ( rider in self.riders )
    {
        rider ai::function_dd7b3233e5b07718();
    }
    
    var_61f902b2dd6fc262 = ai_spawn_director_heli_findcrashposition( 2000, 500, 1000 );
    
    if ( !isdefined( var_61f902b2dd6fc262 ) )
    {
        return;
    }
    
    self setvehgoalpos( var_61f902b2dd6fc262, 0 );
    thread ai_spawn_director_heli_spinout( speed );
    self vehicle_turnengineoff();
    self waittill( #"near_goal" );
}

// Namespace namespace_37f5741ccbccb7a
// Params 3
// Checksum 0xdc9cd456, Offset: 0xd8b
// Size: 0x1c5
function ai_spawn_director_heli_findcrashposition( crashdist, var_21829f1a765d61f3, var_21a5b51a7683da0d )
{
    crashstart = self.origin;
    crashoffset = self.crashoffset;
    crashpos = undefined;
    jetforward = anglestoforward( self.angles );
    jetright = anglestoright( self.angles );
    crashend = crashstart + jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetforward * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart - jetright * crashdist - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward + jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( jetright - jetforward ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    crashend = crashstart + 0.707 * crashdist * ( -1 * jetforward - jetright ) - ( 0, 0, crashoffset );
    
    if ( trace::ray_trace_passed( crashstart, crashend, self ) )
    {
        crashpos = crashend;
        return crashpos;
    }
    
    return crashpos;
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0xcc9f7b08, Offset: 0xf59
// Size: 0x52
function ai_spawn_director_heli_spinout( speed )
{
    self endon( #"death" );
    self setyawspeed( speed, 50, 50, 0.5 );
    
    while ( isdefined( self ) )
    {
        self settargetyaw( self.angles[ 1 ] + speed * 0.4 );
        wait 0.5;
    }
}

// Namespace namespace_37f5741ccbccb7a
// Params 0
// Checksum 0x4f607e07, Offset: 0xfb3
// Size: 0xb2
function ai_spawn_director_heli_cleanup()
{
    foreach ( rider in self.riders )
    {
        if ( !utility::issp() )
        {
            rider [[ level.var_322ef03826a64697 ]]( 0 );
            continue;
        }
        
        rider delete();
    }
    
    if ( isdefined( level.vehicles ) )
    {
        vehicle_tracking::deregister_instance( self );
    }
    
    vehicle_tracking::delete_vehicle( self );
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0x9db8a000, Offset: 0x106d
// Size: 0x87
function ai_spawn_director_heli_finddroplocation( droplocation )
{
    endtrace = droplocation - ( 0, 0, 20000 );
    starttrace = droplocation + ( 0, 0, 200 );
    ignorelist = [ self ];
    trace = trace::ray_trace( starttrace, endtrace, ignorelist );
    
    if ( isdefined( trace ) && trace[ "hittype" ] != "hittype_none" )
    {
        return trace[ "position" ];
    }
    
    return droplocation;
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0x4a68e0c8, Offset: 0x10fd
// Size: 0x2ba
function ai_spawn_director_heli_load_ai( ai_group )
{
    var_b085ee3bd7384ecf = 0;
    var_c79c5565febb87cd = [];
    usedpositions = [];
    
    foreach ( rider in ai_group )
    {
        if ( isdefined( rider.var_e7dd375985ff5ff2 ) && rider.var_e7dd375985ff5ff2 != -1 )
        {
            if ( !isdefined( usedpositions[ rider.var_e7dd375985ff5ff2 ] ) )
            {
                if ( rider.var_e7dd375985ff5ff2 == 5 )
                {
                    var_b085ee3bd7384ecf = 1;
                }
                
                usedpositions[ rider.var_e7dd375985ff5ff2 ] = 1;
                rider.script_startingposition = rider.var_e7dd375985ff5ff2;
                rider.vehicle_position = rider.script_startingposition;
                rider thread function_aca6e5ab85c2cffa( int( rider.var_e7dd375985ff5ff2 ) );
            }
            else
            {
                assertmsg( "<dev string:x40>" + rider.var_e7dd375985ff5ff2 );
            }
            
            continue;
        }
        
        var_c79c5565febb87cd[ var_c79c5565febb87cd.size ] = rider;
    }
    
    seatindex = 2;
    vehicleclassname = vehicle_code::get_vehicle_classname();
    var_f37ac0ff85289907 = level.vehicle.templates.aianims[ vehicleclassname ].size;
    maxpos = var_f37ac0ff85289907 ?? 10;
    
    foreach ( rider in var_c79c5565febb87cd )
    {
        if ( !var_b085ee3bd7384ecf )
        {
            usedpositions[ 5 ] = 1;
            var_b085ee3bd7384ecf = 1;
            rider.script_startingposition = 5;
            rider.vehicle_position = rider.script_startingposition;
            rider thread function_aca6e5ab85c2cffa( int( 5 ) );
            continue;
        }
        
        while ( seatindex < maxpos )
        {
            if ( !isdefined( usedpositions[ seatindex ] ) )
            {
                usedpositions[ seatindex ] = 1;
                rider.script_startingposition = seatindex;
                rider.vehicle_position = rider.script_startingposition;
                rider thread function_aca6e5ab85c2cffa( int( seatindex ) );
                break;
            }
            
            seatindex++;
        }
    }
    
    vehicle_ai::load( ai_group, 1, 1 );
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0xfe7493a6, Offset: 0x13bf
// Size: 0xd7
function function_d3c71c9947aada0b( unload_location )
{
    dropoff_height = self.unload_hover_offset ?? 650;
    function_b9ae49c583ce9344( unload_location, 1, dropoff_height );
    thread function_7ac76e1b9d949c1e( unload_location, self.directorrequestid );
    var_9a90df07a9fe1a03 = vehicle_code::_vehicle_unload();
    self waittill( #"unloaded" );
    
    foreach ( guy in var_9a90df07a9fe1a03 )
    {
        guy.var_a6ecefe6814132d4 = undefined;
    }
    
    return var_9a90df07a9fe1a03;
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0x31fa83af, Offset: 0x149f
// Size: 0x31
function function_aca6e5ab85c2cffa( pos )
{
    self endon( #"death" );
    wait 2;
    self.vehicle_position = pos;
    self.script_startingposition = pos;
}

// Namespace namespace_37f5741ccbccb7a
// Params 2
// Checksum 0x5d3be04d, Offset: 0x14d8
// Size: 0xd2
function function_7ac76e1b9d949c1e( var_21730a634bc1aede, requestid )
{
    self endon( #"death" );
    
    if ( isdefined( var_21730a634bc1aede ) )
    {
        if ( !isvector( var_21730a634bc1aede ) )
        {
            unloadorigin = var_21730a634bc1aede.origin;
        }
        else
        {
            unloadorigin = var_21730a634bc1aede;
        }
    }
    
    if ( level.var_fe60ebaf5e21a892 )
    {
        return;
    }
    
    dist = 500;
    dist_sq = dist * dist;
    pos = getgroundposition( unloadorigin, 1, 1000, 0 );
    
    while ( distance2dsquared( unloadorigin, self.origin ) > dist_sq )
    {
        wait 0.1;
    }
    
    if ( vehicle_ai::has_anim_intro() )
    {
        wait 2;
    }
    else
    {
        wait 10;
    }
    
    [[ level.var_3db6b836941d6d4d ]]( pos, requestid );
}

// Namespace namespace_37f5741ccbccb7a
// Params 2
// Checksum 0x8a92ef43, Offset: 0x15b2
// Size: 0x2dd
function function_c2902224b0903337( start_node, return_to_pos )
{
    self notify( #"new_orders" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"new_orders" );
    
    for ( unloadnode = start_node; isdefined( unloadnode.target ) ; unloadnode = getvehiclenode( unloadnode.target, #targetname ) )
    {
    }
    
    self.currentnode = unloadnode;
    ground_pos = utility::drop_to_ground( unloadnode.origin, 100, -1000 );
    scenenode = spawnstruct();
    scenenode.origin = ground_pos;
    scenenode.angles = unloadnode.angles;
    self.scenenode = scenenode;
    animation = level.vehicle.templates.aianims[ vehicle_code::get_vehicle_classname() ][ 0 ].vehicle_getoutanim;
    neworg = getstartorigin( scenenode.origin, scenenode.angles, animation );
    newangles = getstartangles( scenenode.origin, scenenode.angles, animation );
    
    for ( currentnode = start_node; isdefined( currentnode.target ) ; currentnode = nextnode )
    {
        nextnode = getvehiclenode( currentnode.target, #targetname );
        
        if ( !isdefined( nextnode ) )
        {
            break;
        }
        
        unloadorg = ( neworg[ 0 ], neworg[ 1 ], 0 );
        currentnodeorg = ( currentnode.origin[ 0 ], currentnode.origin[ 1 ], 0 );
        nextnodeorg = ( nextnode.origin[ 0 ], nextnode.origin[ 1 ], 0 );
        var_77b2e25bf873456d = unloadorg - currentnodeorg;
        var_b2dbfd09c0c8c8a5 = unloadorg - nextnodeorg;
        
        if ( vectordot( var_77b2e25bf873456d, var_b2dbfd09c0c8c8a5 ) < 0 )
        {
            break;
        }
        
        function_b9ae49c583ce9344( nextnode, 0 );
    }
    
    function_b9ae49c583ce9344( neworg, 1, 0, undefined, newangles[ 1 ] );
    wait randomfloatrange( 3, 5 );
    self vehicle_cleardrivingstate();
    self function_d2b8ee2e1275daaf( 1 );
    self vehphys_forcekeyframedmotion();
    thread function_7ac76e1b9d949c1e( unloadnode, self.directorrequestid );
    var_9a90df07a9fe1a03 = vehicle_paths::unload_node( unloadnode );
    
    if ( !isdefined( var_9a90df07a9fe1a03 ) )
    {
        var_9a90df07a9fe1a03 = [];
    }
    
    self function_d2b8ee2e1275daaf( 0 );
    self vehphys_setdefaultmotion();
    self cleargoalyaw();
    return var_9a90df07a9fe1a03;
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0x24a90003, Offset: 0x1898
// Size: 0x5b
function function_2ca63bc8e2eee252( requestid )
{
    self endon( #"death" );
    thread function_e2e7f02e75808fa2( requestid );
    
    while ( self.riders.size > 0 )
    {
        wait 1;
    }
    
    self notify( #"hash_c4d2e1673d610884" );
    function_2479114e5ee014dc( requestid );
    self function_d2b8ee2e1275daaf( 0 );
    self.var_937263baf40c151 = 1;
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0x4e251456, Offset: 0x18fb
// Size: 0x2c
function function_e2e7f02e75808fa2( requestid )
{
    self endon( #"hash_c4d2e1673d610884" );
    self waittill( #"death" );
    function_2479114e5ee014dc( requestid );
}

// Namespace namespace_37f5741ccbccb7a
// Params 1
// Checksum 0xdf5fd728, Offset: 0x192f
// Size: 0x5e
function function_224b7b468e4613ec( start )
{
    node = start;
    node.timeused = gettime();
    
    while ( isdefined( node ) && !isdefined( node.script_unload ) )
    {
        node = vehicle_paths::function_f535f086527bcb5c( node );
        node.timeused = gettime();
    }
}

// Namespace namespace_37f5741ccbccb7a
// Params 0
// Checksum 0x40082d25, Offset: 0x1995
// Size: 0x89
function function_64a3eecc00994003()
{
    node = self;
    
    for ( mostrecent = node.timeused ?? -600; isdefined( node ) && !isdefined( node.script_unload ) ; mostrecent = min( mostrecent, node.timeused ) )
    {
        node = vehicle_paths::function_f535f086527bcb5c( node );
        
        if ( isdefined( node.timeused ) )
        {
            if ( !isdefined( mostrecent ) )
            {
                mostrecent = node.timeused;
                continue;
            }
        }
    }
    
    return mostrecent;
}

// Namespace namespace_37f5741ccbccb7a
// Params 0
// Checksum 0xb5ac884b, Offset: 0x1a27
// Size: 0xec
function function_b13c15ac4de13156()
{
    if ( !isdefined( self.rootnodes ) )
    {
        if ( !vehicle_paths::function_f497e27675f2993a() )
        {
            return;
        }
    }
    
    if ( self.rootnodes.size == 1 )
    {
        start = self.rootnodes[ 0 ];
    }
    else
    {
        start = undefined;
        starttime = undefined;
        
        foreach ( potentialstart in self.rootnodes )
        {
            potentialstarttime = potentialstart function_64a3eecc00994003();
            
            if ( !isdefined( start ) || potentialstarttime < starttime )
            {
                start = potentialstart;
                starttime = potentialstarttime;
            }
        }
    }
    
    return start;
}

