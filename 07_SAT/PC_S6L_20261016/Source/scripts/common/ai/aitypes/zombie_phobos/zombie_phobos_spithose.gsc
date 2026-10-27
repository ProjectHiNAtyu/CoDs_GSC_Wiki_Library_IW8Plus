// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_spithose.gsc  (hash_40855c3e2afd73f4.gscc) (size: 9869 Bytes / 0x268d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef3683e8 (4013327336)
// size ...... 9869 (0x268d)
// includes .. 14  (offset: 0x2489)
// strings ... 22  (offset: 0x24f9)
// dev strs .. 8   (offset: 0x262d)
// exports ... 28  (offset: 0x1601)
// cseg ...... 0x1a2 + 0x145f (0x1601)
// imports ... 85  (offset: 0x1a61)
// animtree1 . 0   (offset: 0x268d)
// animtree2 . 0   (offset: 0x268d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_enraged;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_jumpout;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_metabones;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_puke;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_roar;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_phobos_spithose;

// Namespace zombie_phobos_spithose
// Params 1
// Checksum 0x84a73f31, Offset: 0x1c0
// Size: 0xc
function function_ce7e38db4fa0fa36( var_4b4d72d84afd1ebd )
{
    
}

/#

    // Namespace zombie_phobos_spithose
    // Params 0
    // Checksum 0xbfc93cea, Offset: 0x1d4
    // Size: 0xc, Type: dev
    function function_115f39adad17c83b()
    {
        setup_spithose_devgui();
    }

#/

// Namespace zombie_phobos_spithose
// Params 0
// Checksum 0x4f2feeb2, Offset: 0x1e8
// Size: 0x9
function init_zombie_phobos_spithose()
{
    thread spithose_listener();
}

// Namespace zombie_phobos_spithose
// Params 0
// Checksum 0x333983a6, Offset: 0x1f9
// Size: 0xf
function request_spithose()
{
    self function_786bb6aa1b76c7ee( "spithose_requested", 1 );
}

// Namespace zombie_phobos_spithose
// Params 1
// Checksum 0xc4725c3d, Offset: 0x210
// Size: 0x17
function set_toxic_gas_arena_structs( structs )
{
    self.phobos_toxic_gas_arena_structs = structs;
}

// Namespace zombie_phobos_spithose
// Params 0, eflags: 0x4
// Checksum 0xa9f1994d, Offset: 0x22f
// Size: 0x25
function private get_look_pos()
{
    if ( self pathdisttogoal() > 500 )
    {
        var_ce4c30c67311cb7b = self getposonpath( 500 );
        return var_ce4c30c67311cb7b;
    }
}

// Namespace zombie_phobos_spithose
// Params 0, eflags: 0x4
// Checksum 0x3ed1613f, Offset: 0x25d
// Size: 0x3e1
function private on_spithose()
{
    self endon( #"death" );
    self.spithose_start_time = gettime();
    self.var_dd39ee1db08a2253 = get_look_pos();
    utility::ent_flag_set( "in_spithose" );
    thread utility::thread_on_notify( "spithose_end", &spithose_cleanup );
    spithose_time = getdvarfloat( @"spithose_time", 1000 );
    
    if ( zombie_phobos_jumpout::is_outside_arena() )
    {
        spithose_time = getdvarfloat( @"hash_37bb1125144d88bb", 6200 );
    }
    else if ( zombie_phobos_enraged::is_enraged() )
    {
        spithose_time = getdvarfloat( @"hash_6aff0cf6330839d6", 600 );
    }
    
    self function_786bb6aa1b76c7ee( "spithose_end_time", spithose_time );
    self waittill( #"mouth_open" );
    waittill_return = utility::waittill_any_in_array_or_timeout( [ "hose_release", "spithose_loop_start" ], 5 );
    spithose_dist = function_43a194b46b4f166d();
    scriptable_state = "" + spithose_dist;
    
    if ( zombie_phobos_jumpout::is_outside_arena() )
    {
        scriptable_state = "flood_arena";
    }
    
    utility::function_7c10ea82c1e305b8( "vomit", scriptable_state );
    
    if ( !zombie_phobos_jumpout::is_outside_arena() )
    {
        level callback::callback( "phobos_puke_vo" );
        thread function_9464570ccdf080fd( spithose_dist );
    }
    
    if ( waittill_return != "spithose_loop_start" )
    {
        self waittill( #"spithose_loop_start" );
    }
    
    spithose_spawn_time = getdvarfloat( @"hash_da53aa1e161736b5", 0.5 );
    
    if ( zombie_phobos_jumpout::is_outside_arena() && isdefined( level.phobos_arena_center ) )
    {
        scriptable = self.var_d6894f01a36b4ff3.var_fda156cf6c87580d;
        flood_arena_scriptable = spawnscriptable( scriptable, level.phobos_arena_center, ( 0, 0, 0 ) );
        
        if ( isdefined( flood_arena_scriptable ) )
        {
            flood_arena_scriptable utility::function_7c10ea82c1e305b8( "base", "flood_fill" );
            flood_arena_scriptable utility::delaycall( 10, &freescriptable );
        }
    }
    
    wait spithose_spawn_time;
    
    if ( !zombie_phobos_jumpout::is_outside_arena() )
    {
        var_b7c54bda884290b8 = 5;
        spithose_structs = function_1e4a5e192fe3096d();
        
        foreach ( struct in spithose_structs )
        {
            toxic_gas_angles = function_57b58f3d5c50f271( struct.origin );
            zombie_toxic_gas::spawn_toxic_gas( self, struct.origin, toxic_gas_angles ?? ( 0, 0, 0 ), "from_spithose", var_b7c54bda884290b8, 128, 64, "outside_arena_roar_end" );
        }
    }
    
    self waittill( #"spithose_loop_end" );
    
    if ( zombie_phobos_jumpout::is_outside_arena() )
    {
        var_b7c54bda884290b8 = undefined;
        spithose_structs = function_1e4a5e192fe3096d();
        
        foreach ( struct in spithose_structs )
        {
            toxic_gas_angles = function_57b58f3d5c50f271( struct.origin );
            toxic_gas = zombie_toxic_gas::spawn_toxic_gas( self, struct.origin, toxic_gas_angles ?? ( 0, 0, 0 ), "from_spithose_outside_arena", var_b7c54bda884290b8, 128, 64 );
            toxic_gas utility::function_7c10ea82c1e305b8( "base", "on_128" );
        }
    }
    
    utility::function_7c10ea82c1e305b8( "mouth", "base" );
    utility::function_7c10ea82c1e305b8( "vomit", "off" );
    
    if ( zombie_phobos_jumpout::is_outside_arena() )
    {
        zombie_phobos_roar::roar_spawn_ai();
    }
}

// Namespace zombie_phobos_spithose
// Params 1, eflags: 0x4
// Checksum 0x9523cb44, Offset: 0x646
// Size: 0xf6
function private function_57b58f3d5c50f271( var_87728ba4b4ee3210 )
{
    var_a1070fb6169644b7 = 25;
    var_28dc1e2b877264a3 = 500;
    var_7e7092c99f8aa9ba = -12000;
    var_aab4f023f549dee7 = 0.9;
    var_cbe1afdfad47f465 = 0.6;
    var_70a87f7d2445d611 = getaiarrayinradius( var_87728ba4b4ee3210, var_a1070fb6169644b7 );
    var_b219978b5e657f6d = utility::get_average_ground_normal( var_87728ba4b4ee3210, var_a1070fb6169644b7, var_28dc1e2b877264a3, var_7e7092c99f8aa9ba, undefined, var_70a87f7d2445d611 );
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    
    if ( vectordot( var_b219978b5e657f6d, var_3d21eec29b566ffb ) < var_aab4f023f549dee7 && vectordot( var_b219978b5e657f6d, var_3d21eec29b566ffb ) >= var_cbe1afdfad47f465 )
    {
        var_1086be057f657492 = vectorcross( var_b219978b5e657f6d, var_3d21eec29b566ffb );
        var_a13a53d62333e15 = vectorcross( var_b219978b5e657f6d, var_1086be057f657492 );
        aoe_spawn_angles = axistoangles( var_a13a53d62333e15, var_1086be057f657492, var_b219978b5e657f6d );
    }
    else
    {
        aoe_spawn_angles = ( 0, 0, 0 );
    }
    
    return aoe_spawn_angles;
}

// Namespace zombie_phobos_spithose
// Params 0, eflags: 0x4
// Checksum 0xb73f3e44, Offset: 0x745
// Size: 0x44
function private spithose_cleanup()
{
    utility::function_7c10ea82c1e305b8( "mouth", "base" );
    utility::function_7c10ea82c1e305b8( "vomit", "off" );
    self.spithose_dist = undefined;
    self.var_dd39ee1db08a2253 = undefined;
    utility::ent_flag_clear( "in_spithose" );
}

// Namespace zombie_phobos_spithose
// Params 1, eflags: 0x4
// Checksum 0x79672f10, Offset: 0x791
// Size: 0x19a
function private function_9464570ccdf080fd( spithose_dist )
{
    self endon( #"death" );
    var_55e08fcde7d2fbc7 = getdvarfloat( @"hash_e7826634bbb774cf", 1.1 );
    var_4ecbecea68f9f02a = zombie_phobos_puke::function_280534335219c0e5();
    zombie_aitype = zombie_phobos_puke::function_1429567d6a7418fd();
    spawn_point = zombie_phobos_puke::get_puke_spawn_position();
    
    if ( !isdefined( spawn_point ) )
    {
        return;
    }
    
    zombie_phobos_metabones::function_2b7c1d11b4ee6412( self );
    zombie_i = 0;
    
    while ( zombie_i < var_4ecbecea68f9f02a )
    {
        spawn_point = zombie_phobos_puke::get_puke_spawn_position();
        
        if ( !isdefined( spawn_point ) )
        {
            return;
        }
        
        spawn_point = ( spawn_point[ 0 ], spawn_point[ 1 ], spawn_point[ 2 ] );
        var_e2a329852bf32f81 = ( 0, self.angles[ 1 ] - self.head_yaw, 0 );
        zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( zombie_aitype, spawn_point, var_e2a329852bf32f81, self.team );
        
        if ( isdefined( zombie ) )
        {
            zombie_phobos_puke::set_zombie_empowered( zombie, self );
            order = ( zombie_i + 1 ) / 2;
            
            if ( zombie_i % 2 == 1 )
            {
                order *= -1;
            }
            
            shoot_offset = anglestoright( var_e2a329852bf32f81 ) * order * getdvarfloat( @"hash_bc17544cde0c57f8", 0.2 );
            zombie.var_7a679e69584d580c = &function_de99d28d05984f96;
            zombie zombie_cannonball::cannonball_ai( anglestoforward( var_e2a329852bf32f81 ) + shoot_offset, spithose_dist * var_55e08fcde7d2fbc7, zombie_cannonball::adv_settings( 0.7, 10, 0, getdvarfloat( @"hash_4f96395bf34e53d4", 400 ) ), "roll_forward" );
            wait 0.25;
        }
        
        zombie_i += 1;
    }
}

// Namespace zombie_phobos_spithose
// Params 3
// Checksum 0x9afc2da6, Offset: 0x933
// Size: 0xd2, Type: bool
function function_de99d28d05984f96( origin, radius, phobos )
{
    foreach ( toxic_gas in phobos.var_f744e8be8b657e6e )
    {
        var_a3a78d39eeacb0c0 = distance( origin, toxic_gas.origin );
        is_touching = var_a3a78d39eeacb0c0 < toxic_gas.radius + radius + 10;
        
        if ( is_touching )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zombie_phobos_spithose
// Params 0, eflags: 0x4
// Checksum 0x474c888, Offset: 0xa0e
// Size: 0x2b4
function private function_1e4a5e192fe3096d()
{
    if ( !zombie_phobos_jumpout::is_outside_arena() )
    {
        assert( isdefined( self.spithose_dist ) );
        var_e2a329852bf32f81 = ( 0, self.angles[ 1 ] - self.head_yaw, 0 );
        origin = self gettagorigin( "j_jaw" ) + anglestoforward( var_e2a329852bf32f81 ) * ( self.spithose_dist ?? 256 );
        potential_origins = [ get_spithose_ground_position( origin ) ];
        potential_origins[ 1 ] = get_spithose_ground_position( origin - anglestoforward( var_e2a329852bf32f81 ) * 100 );
        valid_origins = [];
        
        foreach ( potential_origin in potential_origins )
        {
            if ( isdefined( potential_origin ) )
            {
                valid_origins[ valid_origins.size ] = potential_origin;
            }
        }
        
        if ( valid_origins.size == 0 )
        {
            return [];
        }
        
        if ( valid_origins.size == 1 )
        {
            origin = valid_origins[ 0 ];
        }
        else if ( abs( valid_origins[ 0 ][ 2 ] - valid_origins[ 1 ][ 2 ] ) > 128 )
        {
            origin = valid_origins[ 0 ][ 2 ] > valid_origins[ 1 ][ 2 ] ? valid_origins[ 0 ] : valid_origins[ 1 ];
        }
        else
        {
            origin = valid_origins[ 0 ][ 2 ] < valid_origins[ 1 ][ 2 ] ? valid_origins[ 0 ] : valid_origins[ 1 ];
        }
        
        return [ { #origin:origin } ];
    }
    
    var_d10ac0ee5678bd83 = self.phobos_toxic_gas_arena_structs ?? level.var_5f5141a928962c86;
    num_to_spawn = getdvarfloat( @"hash_c46ce3085adb8814", -1 );
    
    if ( num_to_spawn <= 0 )
    {
        num_to_spawn_array = [ 4, 6, 9 ];
        
        if ( self._blackboard.var_606bf8ea1f70975d == 0 )
        {
            num_to_spawn_array = [ 3, 5, 7 ];
        }
        
        var_bfd9a1b518cc6aa6 = self.health / self.maxhealth;
        
        if ( var_bfd9a1b518cc6aa6 > 0.55 )
        {
            num_to_spawn = num_to_spawn_array[ 0 ];
        }
        else if ( var_bfd9a1b518cc6aa6 > 0.3 )
        {
            num_to_spawn = num_to_spawn_array[ 1 ];
        }
        else
        {
            num_to_spawn = num_to_spawn_array[ 2 ];
        }
    }
    
    spithose_structs = [];
    
    if ( isdefined( var_d10ac0ee5678bd83 ) )
    {
        var_d10ac0ee5678bd83 = arrayrandomize( var_d10ac0ee5678bd83 );
        struct_i = 0;
        
        while ( struct_i < num_to_spawn )
        {
            spithose_structs[ spithose_structs.size ] = var_d10ac0ee5678bd83[ struct_i ];
            struct_i += 1;
        }
    }
    
    return spithose_structs;
}

// Namespace zombie_phobos_spithose
// Params 1, eflags: 0x4
// Checksum 0x5fbe1fc9, Offset: 0xccb
// Size: 0x9f
function private get_spithose_ground_position( origin )
{
    trace_contents = trace::create_solid_ai_contents( 1 );
    trace_contents += trace::create_world_contents();
    trace_start = origin + ( 0, 0, 600 );
    trace_end = origin + ( 0, 0, -2000 );
    var_c563b215b9d1ddb7 = trace::ray_trace( trace_start, trace_end, self, trace_contents );
    
    if ( !isdefined( var_c563b215b9d1ddb7 ) || !isdefined( var_c563b215b9d1ddb7[ "position" ] ) || var_c563b215b9d1ddb7[ "fraction" ] >= 1 )
    {
        return;
    }
    
    return var_c563b215b9d1ddb7[ "position" ];
}

// Namespace zombie_phobos_spithose
// Params 2, eflags: 0x4
// Checksum 0x506694fe, Offset: 0xd73
// Size: 0x5f, Type: bool
function private function_8823fbe4007b72bc( entitya, entityb )
{
    dista = distancesquared( entitya.origin, self.origin );
    distb = distancesquared( entityb.origin, self.origin );
    return dista > distb;
}

// Namespace zombie_phobos_spithose
// Params 0, eflags: 0x4
// Checksum 0x8e9c5aae, Offset: 0xddb
// Size: 0x1a5
function private function_43a194b46b4f166d()
{
    spithose_dist = getdvarfloat( @"hash_8e5888375715bc6a", -1 );
    
    if ( spithose_dist > 0 )
    {
        self.spithose_dist = spithose_dist;
        return spithose_dist;
    }
    
    if ( zombie_phobos_jumpout::is_outside_arena() )
    {
        spithose_dist = getdvarfloat( @"hash_a6d5a5619834560a", 512 );
        self.spithose_dist = spithose_dist;
        return spithose_dist;
    }
    
    potential_dists = [ 256, 512, 700, 1000 ];
    
    if ( isdefined( self.var_dd39ee1db08a2253 ) )
    {
        to_look_pos = utility::flatten_vector( self.var_dd39ee1db08a2253 - self.origin );
        forward_angles = vectortoangles( to_look_pos );
    }
    else
    {
        forward_angles = self.angles;
    }
    
    max_target_point = self.origin + anglestoforward( forward_angles ) * potential_dists[ potential_dists.size - 1 ];
    target = function_71e16365ee19f593( self.origin, max_target_point );
    
    if ( !isdefined( target ) )
    {
        self.spithose_dist = potential_dists[ 1 ];
        return self.spithose_dist;
    }
    
    closest_dist_index = function_267ed3ba8df180f8( target.origin, potential_dists, self.origin );
    dist_index = closest_dist_index;
    
    while ( closest_dist_index >= 1 )
    {
        if ( spithose_ray_trace_passed( potential_dists[ dist_index ] ) )
        {
            self.spithose_dist = potential_dists[ dist_index ];
            return self.spithose_dist;
        }
        
        closest_dist_index--;
    }
    
    self.spithose_dist = potential_dists[ 0 ];
    return self.spithose_dist;
}

// Namespace zombie_phobos_spithose
// Params 2, eflags: 0x4
// Checksum 0x91e4481a, Offset: 0xf89
// Size: 0x123
function private function_71e16365ee19f593( start, end )
{
    radius = 500;
    targets = self function_f017e352a29a57a1( averagepoint( [ start, end ] ), distance( start, end ) + radius * 2, 1 );
    best_target = undefined;
    best_dist = 999999;
    
    foreach ( target in targets )
    {
        var_aae9e5f102accb15 = function_714341c51423832d( start, end, target.origin );
        
        if ( var_aae9e5f102accb15 <= radius )
        {
            dist_to_end = distance( target.origin, end );
            
            if ( dist_to_end < best_dist )
            {
                best_dist = dist_to_end;
                best_target = target;
            }
        }
    }
    
    return best_target;
}

// Namespace zombie_phobos_spithose
// Params 3, eflags: 0x4
// Checksum 0x29fba83c, Offset: 0x10b5
// Size: 0xc1
function private function_267ed3ba8df180f8( point, distances, reference_point )
{
    point_dist = distance( ( 0, 0, 0 ), point );
    var_275d609c68e26c32 = distances[ 0 ];
    best_diff = abs( point_dist - var_275d609c68e26c32 );
    var_2bfd1e98bd556afb = 0;
    
    for ( i = 1; i < distances.size ; i++ )
    {
        current_diff = abs( point_dist - distances[ i ] );
        
        if ( current_diff < best_diff )
        {
            best_diff = current_diff;
            var_275d609c68e26c32 = distances[ i ];
            var_2bfd1e98bd556afb = i;
        }
    }
    
    var_2bfd1e98bd556afb = int( min( distances.size - 1, var_2bfd1e98bd556afb + 1 ) );
    return var_2bfd1e98bd556afb;
}

// Namespace zombie_phobos_spithose
// Params 0, eflags: 0x4
// Checksum 0xee226a53, Offset: 0x117f
// Size: 0x2b
function private spithose_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"spithose_start" );
        thread on_spithose();
        waitframe();
    }
}

// Namespace zombie_phobos_spithose
// Params 1, eflags: 0x4
// Checksum 0xdcc150d1, Offset: 0x11b2
// Size: 0xc8
function private spithose_ray_trace_passed( dist = 256 )
{
    dist += 300;
    check_pos = self getcentroid() + anglestoforward( self.angles ) * dist;
    trace_passed = trace::ray_trace_passed( self getcentroid(), check_pos, self, trace::create_solid_ai_contents( 1 ) );
    
    /#
        if ( debug_spithose() )
        {
            col = trace_passed ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            print3d( check_pos, "<dev string:x24>" + ( trace_passed ? "<dev string:x33>" : "<dev string:x3c>" ), col );
            line( self getcentroid(), check_pos, col );
        }
    #/
    
    return trace_passed;
}

// Namespace zombie_phobos_spithose
// Params 2
// Checksum 0xfc186187, Offset: 0x1283
// Size: 0x40
function function_47f30018dedc0497( taskid, params )
{
    trace_passed = spithose_ray_trace_passed();
    
    if ( !trace_passed )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace zombie_phobos_spithose
// Params 2
// Checksum 0x6057eafe, Offset: 0x12cc
// Size: 0x5a
function function_22a2948ce125a411( taskid, params )
{
    var_17361ac63801f3c0 = gettime() - ( self.spithose_start_time ?? 0 );
    cooldown_score = clamp( math::remap( var_17361ac63801f3c0, 0, utility::function_4b74c15943231980( 30 ), 0, 1 ), 0, 1 );
    return cooldown_score;
}

// Namespace zombie_phobos_spithose
// Params 2
// Checksum 0xf92394fe, Offset: 0x132f
// Size: 0xef
function function_6a8499e42eda8b00( taskid, params )
{
    if ( !isdefined( self.var_f744e8be8b657e6e ) )
    {
        return 1;
    }
    
    var_7fe1fb55bb2d6630 = 0;
    
    foreach ( Gas in self.var_f744e8be8b657e6e )
    {
        if ( isdefined( Gas ) && Gas.id == "from_spithose" )
        {
            var_7fe1fb55bb2d6630 += 1;
        }
    }
    
    var_24cb63031538dab = math::remap( max( 1 - var_7fe1fb55bb2d6630 / 3, 0 ), 0, 1, 0.25, 0.75 );
    return var_24cb63031538dab;
}

// Namespace zombie_phobos_spithose
// Params 2
// Checksum 0x3c9e273b, Offset: 0x1427
// Size: 0xcf
function function_d49e18e024448267( taskid, params )
{
    look_pos = get_look_pos();
    
    if ( !isdefined( look_pos ) )
    {
        if ( isdefined( self.enemy ) )
        {
            look_pos = self.enemy.origin;
        }
        else
        {
            return 0.5;
        }
    }
    
    to_look = vectornormalize2( look_pos - self.origin );
    forward = anglestoforward( self.angles );
    var_c5bd4c08173f1057 = vectordot( to_look, forward );
    score = max( math::remap( var_c5bd4c08173f1057, 0, 0.8, 0, 0.5 ), 0 );
    
    if ( var_c5bd4c08173f1057 > 0.8 )
    {
        score = 1;
    }
    
    return score;
}

/#

    // Namespace zombie_phobos_spithose
    // Params 0
    // Checksum 0x35362474, Offset: 0x14ff
    // Size: 0x2e, Type: dev
    function setup_spithose_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x44>" );
        devgui::add_devgui_func( "<dev string:x61>", "<dev string:x70>", &force_spithose );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_spithose
    // Params 1, eflags: 0x4
    // Checksum 0x369f45e1, Offset: 0x1535
    // Size: 0x4b, Type: dev
    function private force_spithose( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x86>" );
        
        if ( isdefined( phobos ) )
        {
            phobos request_spithose();
        }
    }

    // Namespace zombie_phobos_spithose
    // Params 0, eflags: 0x4
    // Checksum 0xce5d8bbb, Offset: 0x1588
    // Size: 0x16, Type: dev
    function private debug_spithose()
    {
        return getdvarint( @"phobos_spit_debug", 0 ) > 0;
    }

    // Namespace zombie_phobos_spithose
    // Params 2, eflags: 0x4
    // Checksum 0x74923c7, Offset: 0x15a6
    // Size: 0x5b, Type: dev
    function private spithose_print( text, pos )
    {
        if ( debug_spithose() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x94>" + text, ( 1, 0, 0 ) );
        }
    }

#/
