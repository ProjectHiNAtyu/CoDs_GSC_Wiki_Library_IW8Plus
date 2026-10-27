// script_3becc4e343ab1c2a  (hash_3becc4e343ab1c2a.gscc) (size: 6326 Bytes / 0x18b6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf3e9138f (4092138383)
// size ...... 6326 (0x18b6)
// includes .. 9   (offset: 0x1776)
// strings ... 20  (offset: 0x17be)
// dev strs .. 0   (offset: 0x18b6)
// exports ... 18  (offset: 0xeba)
// cseg ...... 0x1ad + 0xd0d (0xeba)
// imports ... 52  (offset: 0x118a)
// animtree1 . 0   (offset: 0x18b6)
// animtree2 . 0   (offset: 0x18b6)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;

#namespace namespace_3ea8ef47cd7b240c;

// Namespace namespace_3ea8ef47cd7b240c
// Params 1
// Checksum 0x33440d70, Offset: 0x1cb
// Size: 0x11b
function dmztask_getspawndata( data )
{
    level.searchprops = spawnstruct();
    level.searchprops.circleradius = getdvarint( @"scr_dmz_search_circle_radius", 2000 );
    level.searchprops.circlepadding = getdvarint( @"hash_d411b19dd9e74816", 500 );
    level.searchprops.numpoints = getdvarint( @"scr_dmz_search_num_points", 35 );
    level.searchprops.pointradius = getdvarint( @"scr_dmz_search_point_radius", 1000 );
    level.searchprops.pointradiussq = level.searchprops.pointradius * level.searchprops.pointradius;
    level.searchprops.var_3afcdbbcf79cc9cc = getdvarfloat( @"hash_a1e11094b3a508fc", 0.65 );
    activity_manager::function_f61a1f535aab4194( data, &function_4e965421451d15a1, getunusedlootcachepoints() );
}

/#

    // Namespace namespace_3ea8ef47cd7b240c
    // Params 0
    // Checksum 0xb29c2048, Offset: 0x2ee
    // Size: 0x7, Type: dev
    function function_746bdfc760ec9b18()
    {
        return [];
    }

#/

// Namespace namespace_3ea8ef47cd7b240c
// Params 2
// Checksum 0xa4d0b02a, Offset: 0x2fd
// Size: 0xe7
function function_4e965421451d15a1( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_20c9e68e029c7c06;
    task.funcs[ "onTeamAssigned" ] = &function_418606b8826437dd;
    task.funcs[ "onPlayerJoined" ] = &function_46953f6ead45d924;
    task.funcs[ "onPlayerRemoved" ] = &function_e29b68d071839d97;
    task.funcs[ "onTeamStart" ] = &function_9d5989d1a6ee4e1f;
    task.node = node;
    task.ref = "dmz_search";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.spawntrap = 0;
    return task;
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 0
// Checksum 0xbe7a287a, Offset: 0x3ed
// Size: 0xcf
function function_20c9e68e029c7c06()
{
    self.activity.origin = self.node.origin;
    circlelocation = function_e8e262b952e0a825( self.node );
    dmz_task_utils::function_13fe84cb824c72a8( "Explore_Dmz", [ circlelocation ], level.searchprops.circleradius );
    dmz_task_utils::function_b3476f99a8e21fa2( circlelocation );
    self.circlecenter = circlelocation;
    self.circleradius = level.searchprops.circleradius;
    thread function_9890ba7f809d180d();
    function_66a3bf6d5ef41988( self.node.origin, self.node.angles, self );
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 1
// Checksum 0x799103d9, Offset: 0x4c4
// Size: 0x64
function function_418606b8826437dd( teamname )
{
    dialog::leaderdialog( "dmz_mission_search_assigned", teamname );
    dmz_task_utils::function_18b83232055b1325( teamname );
    thread function_c01220e3266a3b33( teamname );
    dmz_task_utils::function_b98b5c402af55e81( teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    dmz_task_utils::function_e059e95407f1f191( self.cache, [ teamname ] );
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 1
// Checksum 0x1259a0fd, Offset: 0x530
// Size: 0x25
function function_46953f6ead45d924( player )
{
    dmz_task_utils::function_6277bd2a0d5a28b9( player );
    self.cache enablescriptableplayeruse( player );
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 1
// Checksum 0xf85d6db8, Offset: 0x55d
// Size: 0x25
function function_e29b68d071839d97( player )
{
    dmz_task_utils::function_1f01bb1108ba0241( player );
    self.cache disablescriptableplayeruse( player );
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 1
// Checksum 0x1190884c, Offset: 0x58a
// Size: 0xc
function function_9d5989d1a6ee4e1f( teamname )
{
    
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 1, eflags: 0x4
// Checksum 0xd7f77e81, Offset: 0x59e
// Size: 0xbc
function private function_5298a5fac441d299( teamname )
{
    self notify( #"task_ended" );
    dmz_task_utils::function_e23cad864e9e2023();
    dmz_task_utils::function_3ff46488beb193c7();
    
    foreach ( team in self.teams )
    {
        dmz_task_utils::task_showsplashtoteam( "dmz_search_complete", team );
        dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    }
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 2, eflags: 0x4
// Checksum 0xa5ec22d1, Offset: 0x662
// Size: 0x3d
function private function_fc72d4c3d19c6f35( instance, player )
{
    instance.task function_5298a5fac441d299( player.team );
    waitframe();
    dmz_task_utils::function_59e5c04599d5a456( instance, player );
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 3
// Checksum 0x82d00223, Offset: 0x6a7
// Size: 0xe5
function function_66a3bf6d5ef41988( inorigin, inangles, task )
{
    cache = spawnscriptable( "br_loot_cache", inorigin, inangles );
    cache setscriptablepartstate( "body", "open" );
    cache.task = task;
    task.cache = cache;
    cache.contents = [];
    cache.contents[ 0 ][ "quantity" ] = 1;
    cache.contents[ 0 ][ "lootID" ] = 8608;
    cache.contents[ 0 ][ "callback" ] = &function_fc72d4c3d19c6f35;
    cache.contents[ 1 ][ "quantity" ] = 50;
    cache.contents[ 1 ][ "lootID" ] = 8395;
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 2, eflags: 0x4
// Checksum 0x28f400b6, Offset: 0x794
// Size: 0x28
function private function_d298d9478e408a20( opener, container )
{
    return dmz_task_utils::function_be01e8d1cf19ccbc( container.task, opener );
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 1, eflags: 0x4
// Checksum 0x46d7db10, Offset: 0x7c5
// Size: 0x32
function private function_e8e262b952e0a825( location )
{
    return location.origin + utility::function_9e0df7b136ab833c() * level.searchprops.circleradius;
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 1, eflags: 0x4
// Checksum 0x8246f137, Offset: 0x800
// Size: 0x226
function private function_c01220e3266a3b33( team )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    
    if ( getdvarint( @"hash_2a539568e55a221", 0 ) )
    {
        return;
    }
    
    wait 2;
    
    if ( isdefined( self.objidnum ) )
    {
        objective_setplayintro( self.objidnum, 0 );
    }
    
    players = teams::getteamdata( team, "players" );
    
    while ( true )
    {
        foreach ( player in players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            var_21086fe9aa7e3c07 = distance2dsquared( player.origin, self.circlecenter );
            
            if ( var_21086fe9aa7e3c07 <= self.circleradius * self.circleradius )
            {
                pointsremaining = [];
                
                foreach ( point in self.points )
                {
                    playertopoint = distance2dsquared( player.origin, point );
                    
                    if ( playertopoint < self.circleradius * self.circleradius * level.searchprops.var_3afcdbbcf79cc9cc )
                    {
                        var_e112e63869fb0928 = distance2dsquared( point, self.circlecenter );
                        
                        if ( var_21086fe9aa7e3c07 < var_e112e63869fb0928 )
                        {
                            continue;
                        }
                    }
                    
                    pointsremaining[ pointsremaining.size ] = point;
                }
                
                self.points = pointsremaining;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 0, eflags: 0x4
// Checksum 0x16d50ebb, Offset: 0xa2e
// Size: 0x1d6
function private function_9890ba7f809d180d()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    
    if ( getdvarint( @"hash_2a539568e55a221", 0 ) )
    {
        return;
    }
    
    self.points = [];
    phisq = 2.61792;
    numpointssqrt = sqrt( level.searchprops.numpoints );
    pointindex = 0;
    
    while ( pointindex < level.searchprops.numpoints )
    {
        radius = sqrt( pointindex ) / numpointssqrt * level.searchprops.circleradius;
        angle = 360 * pointindex / phisq;
        offset = ( radius * cos( angle ), radius * sin( angle ), 0 );
        point = self.circlecenter + offset;
        self.points[ self.points.size ] = point;
        pointindex += 1;
    }
    
    while ( true )
    {
        var_334f0147e0ebfab3 = self.points;
        var_334f0147e0ebfab3[ var_334f0147e0ebfab3.size ] = self.node.origin;
        circle = function_2ef2718d10599b6c( var_334f0147e0ebfab3, self.node.origin[ 2 ] );
        
        if ( circle[ 1 ] + level.searchprops.circlepadding < self.circleradius )
        {
            thread function_9c63baf4e8a34b9( circle[ 0 ], circle[ 1 ] + level.searchprops.circlepadding, 0.8 );
        }
        
        wait 1;
    }
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 3
// Checksum 0x69713396, Offset: 0xc0c
// Size: 0xfc
function function_9c63baf4e8a34b9( newcenter, newradius, duration )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    time = 0;
    
    while ( time < duration )
    {
        time += level.framedurationseconds;
        frac = time / duration;
        pos = vectorlerp( self.circlecenter, newcenter, frac );
        rad = ( newradius - self.circleradius ) * frac + self.circleradius;
        self.questcircles[ 0 ] game_utility::questcircle_move( pos );
        self.questcircles[ 0 ] game_utility::function_d46d8731ed9d281( rad );
        dmz_task_utils::function_c74c010e593f5ea5( pos + ( 0, 0, 750 ) );
        waitframe();
    }
    
    self.circlecenter = newcenter;
    self.circleradius = newradius;
}

// Namespace namespace_3ea8ef47cd7b240c
// Params 2, eflags: 0x4
// Checksum 0x1f6d8a27, Offset: 0xd10
// Size: 0x1a9
function private function_2ef2718d10599b6c( points, height )
{
    minx = points[ 0 ][ 0 ];
    maxx = points[ 0 ][ 0 ];
    miny = points[ 0 ][ 1 ];
    maxy = points[ 0 ][ 1 ];
    
    foreach ( point in points )
    {
        if ( minx > point[ 0 ] )
        {
            minx = point[ 0 ];
        }
        
        if ( maxx < point[ 0 ] )
        {
            maxx = point[ 0 ];
        }
        
        if ( miny > point[ 1 ] )
        {
            miny = point[ 1 ];
        }
        
        if ( maxy < point[ 1 ] )
        {
            maxy = point[ 1 ];
        }
    }
    
    center = ( ( maxx + minx ) / 2, ( maxy + miny ) / 2, height );
    radiussq = 0;
    
    foreach ( point in points )
    {
        distsq = distance2dsquared( center, point );
        
        if ( radiussq <= distsq )
        {
            radiussq = distsq;
        }
    }
    
    return [ center, sqrt( radiussq ) ];
}

