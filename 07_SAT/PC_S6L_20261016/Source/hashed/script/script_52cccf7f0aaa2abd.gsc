// script_52cccf7f0aaa2abd  (hash_52cccf7f0aaa2abd.gscc) (size: 4470 Bytes / 0x1176 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1dae957 (31123799)
// size ...... 4470 (0x1176)
// includes .. 6   (offset: 0x1076)
// strings ... 15  (offset: 0x10a6)
// dev strs .. 0   (offset: 0x1176)
// exports ... 9   (offset: 0xb1e)
// cseg ...... 0x16f + 0x9af (0xb1e)
// imports ... 34  (offset: 0xc86)
// animtree1 . 0   (offset: 0x1176)
// animtree2 . 0   (offset: 0x1176)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\mp\ai_vehicle_patrol;
#using scripts\mp\flags;
#using scripts\mp\poi;

#namespace namespace_28d8efc959959715;

// Namespace namespace_28d8efc959959715
// Params 0
// Checksum 0x8fe57119, Offset: 0x18d
// Size: 0x1f5
function function_bc2092e03aba7a07()
{
    flags::function_2f3408423ccc9b2e( "vehicle_patrol_paths_selected" );
    level.convoyattack = spawnstruct();
    level.convoyattack.enabled = getdvarint( @"hash_39c37258ca05357b", 0 );
    
    if ( !level.convoyattack.enabled )
    {
        return;
    }
    
    level.convoyattack.speed = getdvarfloat( @"scr_dmz_convoy_attack_speed", 20 );
    level.convoyattack.var_ea0091e862d0c245 = getdvarint( @"hash_1e2146029acd559", 4 );
    level.convoyattack.var_b4d4fd14771dbf43 = getdvarint( @"hash_ec74918dfb1e85e7", 6 );
    level.var_9166dae2aa6330df = [];
    
    foreach ( i, p in level.var_295138bb09cc4de )
    {
        p.origin = p.path[ 0 ].origin;
        level.var_9166dae2aa6330df[ level.var_9166dae2aa6330df.size ] = p;
    }
    
    level.var_9166dae2aa6330df = arrayrandomize( level.var_9166dae2aa6330df );
    numtospawn = randomintrange( level.convoyattack.var_ea0091e862d0c245, level.convoyattack.var_b4d4fd14771dbf43 + 1 );
    
    for ( i = 0; i < numtospawn ; i++ )
    {
        patrolstruct = spawnstruct();
        patrolstruct thread function_b5d8df1dc7fadae2( level.var_9166dae2aa6330df[ i ] );
    }
}

// Namespace namespace_28d8efc959959715
// Params 1
// Checksum 0xbc3c69c6, Offset: 0x38a
// Size: 0x1b6
function function_b5d8df1dc7fadae2( patrolpath )
{
    if ( !isdefined( patrolpath ) )
    {
        return;
    }
    
    if ( !vehicle::is_loaded( %"hash_77eba5cf011bc16c" ) )
    {
        return;
    }
    
    self.node = patrolpath;
    self.caches = [];
    self.node.initai = 1;
    self.node.spawntype = "GAME_MODE";
    self.node.team = "team_hundred_ninety_four";
    self.node.showheadicon = 1;
    self.node.direction = 1;
    self.node.index = 0;
    self.vehicle = function_d0a64dea085b883b();
    thread function_e90c2dc07d81a1be();
    self.vehicle vehicle_ai::function_c439ae025b2bf434();
    self.vehicle setconfigvalue( "p2p", "brakeAtGoal", 0 );
    self.vehicle setconfigvalue( "p2p", "goalThreshold", level.convoyattack.speed * 4 );
    self.vehicle setconfigvalue( "p2p", "steeringMultiplier", 2.5 );
    self.vehicle setconfigvalue( "p2p", "stuckTime", 4 );
    self.vehicle.pathdata = self.node;
    self.vehicle thread vehicle_ai::follow_path_struct( self.node, level.convoyattack.speed );
}

// Namespace namespace_28d8efc959959715
// Params 0
// Checksum 0x1bad70b1, Offset: 0x548
// Size: 0x147
function function_e90c2dc07d81a1be()
{
    self.vehicle waittill( #"death" );
    self.husk = self.vehicle vehicle::function_821726d09177a949();
    
    if ( isdefined( self.husk ) )
    {
        foreach ( cache in self.caches )
        {
            self.husk function_96b62da003a22ec4( cache );
        }
        
        function_5cddafafecbdae();
        self.husk waittill( #"death" );
    }
    
    foreach ( cache in self.caches )
    {
        cache freescriptable();
    }
}

// Namespace namespace_28d8efc959959715
// Params 2
// Checksum 0x2f7c604f, Offset: 0x697
// Size: 0xa1
function function_f0b097ba56b065c( offset, angles )
{
    worldpos = coordtransform( offset, self.origin, self.angles );
    cache = spawnscriptable( "br_loot_cache_convoy_attack", worldpos, angles );
    cache scriptablesetparententity( self, offset, angles );
    cache.offset = offset;
    cache.linkangles = angles;
    self.patrolstruct.caches[ self.patrolstruct.caches.size ] = cache;
}

// Namespace namespace_28d8efc959959715
// Params 1
// Checksum 0xd00592c2, Offset: 0x740
// Size: 0x31
function function_96b62da003a22ec4( cache )
{
    cache scriptableclearparententity();
    cache scriptablesetparententity( self, cache.offset, cache.linkangles );
}

// Namespace namespace_28d8efc959959715
// Params 0
// Checksum 0x72ea22a2, Offset: 0x779
// Size: 0x2a9
function function_d0a64dea085b883b()
{
    poiname = poi::poi_findpoioriginisin( self.node.origin, 0, 1 );
    agenttypes = utility::callsharedfunc( #"ground", #"hash_fcd7e9fa4cb0879c", %"hash_77eba5cf011bc16c" );
    spawners = utility::callsharedfunc( #"ground", #"hash_c96151abc06cb1c1", %"hash_77eba5cf011bc16c", 7, agenttypes, self.node.origin, poiname, "absolute" );
    riders = utility::callsharedfunc( #"ground", #"spawnriders", spawners, 7, undefined, "high", "convoy_attack", "convoy_attack", "team_hundred_ninety_four", undefined, "veh9_mil_cargo_truck_convoy_attack", poiname );
    
    if ( riders.size > 0 )
    {
        foreach ( rider in riders )
        {
            if ( isent( rider ) )
            {
                rider.var_f60cb46dafea871e = 1;
            }
        }
    }
    
    spawndata = spawnstruct();
    spawndata.origin = self.node.origin;
    spawndata.angles = ( 0, 0, 0 );
    spawndata.spawntype = "GAME_MODE";
    spawndata.team = "team_hundred_ninety_four";
    spawndata.showheadicon = 1;
    spawndata.initai = 1;
    faildata = spawnstruct();
    vehicle = vehicle::spawn( %"hash_77eba5cf011bc16c", spawndata, faildata );
    vehicle.var_1f4f9d64c04f05db = 1;
    vehicle.patrolstruct = self;
    vehicle.var_d1c265e59db4d5bf = 1;
    
    if ( riders.size > 0 )
    {
        vehicle thread function_ef65c7a611adaa18( riders[ 0 ] );
    }
    
    waitframe();
    vehicle vehicle_ai::load( riders, 1, 1 );
    vehicle function_f0b097ba56b065c( ( 33, 23, 10 ), ( 0, 90, 0 ) );
    vehicle function_f0b097ba56b065c( ( 33, -23, 10 ), ( 0, 90, 0 ) );
    return vehicle;
}

// Namespace namespace_28d8efc959959715
// Params 0
// Checksum 0xb7d420b, Offset: 0xa2b
// Size: 0x9b
function function_5cddafafecbdae()
{
    if ( self.openedcaches )
    {
        return;
    }
    
    self.openedcaches = 1;
    
    foreach ( cache in self.caches )
    {
        cache setscriptablepartstate( "body", "closed_usable" );
    }
}

// Namespace namespace_28d8efc959959715
// Params 1
// Checksum 0xcae9ff12, Offset: 0xace
// Size: 0x50
function function_ef65c7a611adaa18( driver )
{
    self endon( #"death" );
    self endon( #"unloaded" );
    driver waittill( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.patrolstruct function_5cddafafecbdae();
    ai_vehicle_patrol::unload();
}

