// script_2345a75c9a066520  (hash_2345a75c9a066520.gscc) (size: 6533 Bytes / 0x1985 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xac0b1c14 (2886409236)
// size ...... 6533 (0x1985)
// includes .. 5   (offset: 0x1841)
// strings ... 22  (offset: 0x1869)
// dev strs .. 0   (offset: 0x1985)
// exports ... 11  (offset: 0x1099)
// cseg ...... 0x1f9 + 0xea0 (0x1099)
// imports ... 49  (offset: 0x1251)
// animtree1 . 0   (offset: 0x1985)
// animtree2 . 0   (offset: 0x1985)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\doorbuy;
#using scripts\mp\zm\systems\zm_save;

#namespace namespace_5ce9a33f888d9be5;

// Namespace namespace_5ce9a33f888d9be5
// Params 0, eflags: 0x5
// Checksum 0xd9fc8bcb, Offset: 0x217
// Size: 0x1e
function private autoexec init()
{
    if ( !getdvarint( @"hash_fad294eacb78070c", 1 ) )
    {
        return;
    }
    
    level thread function_493e443a817ce401();
}

// Namespace namespace_5ce9a33f888d9be5
// Params 0, eflags: 0x4
// Checksum 0x9784d6f1, Offset: 0x23d
// Size: 0x4c6
function private function_493e443a817ce401()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_sat_firefly_script_zone_unlocks_cs_completed" );
    level.var_e5ccbf542c55e9dd = [];
    var_e5ccbf542c55e9dd = getnoentvolumearray( "zone_unlock_trig", #targetname );
    a_s_doors = utility::getstructarray( "zone_unlock_barrier", "targetname" );
    
    foreach ( struct in a_s_doors )
    {
        var_332e3744433bf2a = getentarray( struct.target, #targetname );
        
        foreach ( mdl in var_332e3744433bf2a )
        {
            wood_barrier_sbl = function_b599e26a924c173b( mdl );
            
            foreach ( trig in var_e5ccbf542c55e9dd )
            {
                doorbuy_hint_ent = getent( trig.target, #target );
                doorbuy_hint_ent.var_a0d364b16ee53ab6 = &"zm_sat_firefly/pluto_wood_barrier_hint";
                
                if ( trig.target == struct.target )
                {
                    trig.center_struct = struct;
                    
                    if ( !isdefined( trig.a_door_sbls ) )
                    {
                        trig.a_door_sbls = [];
                    }
                    
                    trig.a_door_sbls[ trig.a_door_sbls.size ] = wood_barrier_sbl;
                }
            }
        }
    }
    
    foreach ( trig in var_e5ccbf542c55e9dd )
    {
        /#
            trig thread debug_draw_trig();
        #/
        
        trig thread function_d850fff2db81e7e();
        level.var_e5ccbf542c55e9dd[ level.var_e5ccbf542c55e9dd.size ] = trig;
    }
    
    level utility::flag_wait( "doorbuy_init_complete" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    a_door_trigs = getentarray( "zombie_door", #targetname );
    
    foreach ( trig in a_door_trigs )
    {
        a_doors = getentarray( trig.target, "targetname" );
        
        foreach ( door in a_doors )
        {
            if ( door.model == "sat_zm_gate_frame_metal_01" || door.model == "sat_zm_gate_frame_metal_02" )
            {
                if ( !door.minimap_scriptable )
                {
                    if ( game_utility::function_21211f3255f8ea58() || game_utility::getgametype() == "zm_rb_echo" )
                    {
                        trig.var_df00f5fbf4a6d195 = 1;
                        continue;
                    }
                    
                    door.minimap_scriptable = spawnscriptable( %"zm_sat_firefly_power_gate_icon", door.origin, door.angles );
                }
                
                if ( !trig.var_be02046fb805072f )
                {
                    trig.var_be02046fb805072f = &function_29bf967b42f910c5;
                }
            }
        }
    }
    
    level utility::flag_set( "firefly_zone_unlocks_init" );
}

// Namespace namespace_5ce9a33f888d9be5
// Params 0, eflags: 0x4
// Checksum 0xa9546e39, Offset: 0x70b
// Size: 0x9b
function private function_29bf967b42f910c5()
{
    if ( getdvarint( @"hash_af9f3b894ff6a556", 0 ) && level utility::flag( "power_on3" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( game_utility::function_21211f3255f8ea58() || game_utility::getgametype() == "zm_rb_echo" )
    {
        string = &"";
    }
    else
    {
        string = &"shared_hintstrings/doorbuy_power_hint";
    }
    
    return { #string:string, #type:"HINT_NOBUTTON" };
}

// Namespace namespace_5ce9a33f888d9be5
// Params 1
// Checksum 0x402cd79f, Offset: 0x7af
// Size: 0x111
function function_b599e26a924c173b( mdl )
{
    if ( issubstr( mdl.model, "01_left" ) )
    {
        wood_barrier_sbl = spawnscriptable( %"zm_sat_firefly_pap_wood_barrier_01_left", mdl.origin, mdl.angles );
    }
    else if ( issubstr( mdl.model, "02_left" ) )
    {
        wood_barrier_sbl = spawnscriptable( %"zm_sat_firefly_pap_wood_barrier_02_left", mdl.origin, mdl.angles );
    }
    else if ( issubstr( mdl.model, "01_right" ) )
    {
        wood_barrier_sbl = spawnscriptable( %"zm_sat_firefly_pap_wood_barrier_01_right", mdl.origin, mdl.angles );
    }
    else if ( issubstr( mdl.model, "02_right" ) )
    {
        wood_barrier_sbl = spawnscriptable( %"zm_sat_firefly_pap_wood_barrier_02_right", mdl.origin, mdl.angles );
    }
    
    return wood_barrier_sbl;
}

// Namespace namespace_5ce9a33f888d9be5
// Params 0
// Checksum 0xf04dec4, Offset: 0x8c9
// Size: 0x207
function function_d850fff2db81e7e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( !isdefined( level.wonder_veh ) )
    {
        waitframe();
    }
    
    level.wonder_veh endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( level.wonder_veh ) )
        {
            waitframe();
            continue;
        }
        
        if ( distance2dsquared( self.origin, level.wonder_veh.origin ) <= squared( 300 ) )
        {
            if ( level.wonder_veh vehicle_getspeed() >= 10 )
            {
                if ( function_a2b9582b3beece5e() )
                {
                    var_ed55259e8a7b6ff3 = anglestoforward( level.wonder_veh.angles );
                    goingforward = vectordot2( var_ed55259e8a7b6ff3, level.wonder_veh vehicle_getvelocity() ) > 0;
                    nearbyents = getplayersandaiarrayinradius( level.wonder_veh.origin, 200 );
                    
                    if ( nearbyents.size > 0 )
                    {
                        foreach ( ent in nearbyents )
                        {
                            if ( ent.var_c2244a336e1c23aa )
                            {
                                if ( goingforward && ent._blackboard.var_ce36df28fb6b0481 == 0 )
                                {
                                    collisionnormal = -1 * var_ed55259e8a7b6ff3;
                                }
                                else if ( !goingforward && ent._blackboard.var_ce36df28fb6b0481 == 1 )
                                {
                                    collisionnormal = var_ed55259e8a7b6ff3;
                                }
                                
                                ent notify( #"hash_7ceb250625402d74", ent.origin, -1 * var_ed55259e8a7b6ff3 );
                            }
                        }
                    }
                    
                    break_wood_barrier();
                    return;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_5ce9a33f888d9be5
// Params 0, eflags: 0x4
// Checksum 0xde953914, Offset: 0xad8
// Size: 0x214
function private function_a2b9582b3beece5e()
{
    if ( !self.center_struct )
    {
        return;
    }
    
    barrier_fwd = vectornormalize( utility::flatten_vector( anglestoright( self.center_struct.angles ) ) );
    var_8d482f34e2ef679f = ( self.center_struct.origin[ 0 ], self.center_struct.origin[ 1 ], 0 );
    var_8a1a402fb80d764d = var_8d482f34e2ef679f + barrier_fwd * 130;
    var_8a1a3d2fb80d6fb4 = var_8d482f34e2ef679f - barrier_fwd * 130;
    var_3be82e4bf7f43357 = ( level.wonder_veh.origin[ 0 ], level.wonder_veh.origin[ 1 ], 0 );
    
    if ( level.wonder_veh function_141a0b921cd37703() )
    {
        veh_fwd = vectornormalize( utility::flatten_vector( anglestoforward( level.wonder_veh.angles ) * -1 ) );
    }
    else
    {
        veh_fwd = vectornormalize( utility::flatten_vector( anglestoforward( level.wonder_veh.angles ) ) );
    }
    
    var_22cd2228443e6ee5 = var_3be82e4bf7f43357;
    var_22cd1f28443e684c = var_3be82e4bf7f43357 + veh_fwd * 250;
    
    /#
        if ( getdvarint( @"hash_ce2e2b508ff03974", 0 ) )
        {
            thread utility::draw_line_for_time( var_8a1a402fb80d764d + ( 0, 0, self.center_struct.origin[ 2 ] ), var_8a1a3d2fb80d6fb4 + ( 0, 0, self.center_struct.origin[ 2 ] ), 1, 1, 1, 10 );
            thread utility::draw_line_for_time( var_22cd2228443e6ee5 + ( 0, 0, level.wonder_veh.origin[ 2 ] ), var_22cd1f28443e684c + ( 0, 0, level.wonder_veh.origin[ 2 ] ), 1, 1, 1, 10 );
        }
    #/
    
    var_fce8eb1003cc21d0 = utility::closestdistancebetweensegments( var_8a1a402fb80d764d, var_8a1a3d2fb80d6fb4, var_22cd2228443e6ee5, var_22cd1f28443e684c );
    
    if ( var_fce8eb1003cc21d0[ 2 ] < 1 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace namespace_5ce9a33f888d9be5
// Params 1
// Checksum 0x17b3f1ae, Offset: 0xcf5
// Size: 0x153
function break_wood_barrier( var_9682afafe2425248 = 0 )
{
    a_doorbuy = getentarray( self.target, #targetname );
    
    if ( isdefined( a_doorbuy ) )
    {
        foreach ( doorbuy in a_doorbuy )
        {
            doorbuy thread doorbuy::function_f3160e450543b4f1();
        }
    }
    
    foreach ( sbl in self.a_door_sbls )
    {
        sbl thread function_73ba2be5062379b4();
    }
    
    params = spawnstruct();
    params.var_9682afafe2425248 = var_9682afafe2425248;
    callback::callback( "wood_barrier_broken", params );
    self delete();
}

// Namespace namespace_5ce9a33f888d9be5
// Params 0, eflags: 0x4
// Checksum 0x796cdb47, Offset: 0xe50
// Size: 0x16f
function private function_73ba2be5062379b4()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.wonder_veh ) )
    {
        self freescriptable();
        return;
    }
    else
    {
        vector_to_vehicle = level.wonder_veh.origin - self.origin;
        barrier_forward = anglestoforward( self.angles );
        dot_result = vectordot( vector_to_vehicle, barrier_forward );
    }
    
    if ( dot_result > 0 )
    {
        self setscriptablepartstate( "body", "bash_xneg" );
    }
    else
    {
        self setscriptablepartstate( "body", "bash_xpos" );
    }
    
    var_d4406c0ac6fa9f28 = getplayersinradius( self.origin, 350 );
    var_d4406c0ac6fa9f28 = arraycombineunique( var_d4406c0ac6fa9f28, level.wonder_veh.occupants );
    
    foreach ( player in var_d4406c0ac6fa9f28 )
    {
        player playrumbleonentity( "heavy_1s" );
        player earthquakeforplayer( 0.5, 1, self.origin, 350 );
    }
    
    wait 0.2;
    self freescriptable();
}

// Namespace namespace_5ce9a33f888d9be5
// Params 0
// Checksum 0xe058b0f0, Offset: 0xfc7
// Size: 0x94
function function_d897dbe501977ee4()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "firefly_zone_unlocks_init" );
    
    foreach ( trig in level.var_e5ccbf542c55e9dd )
    {
        trig break_wood_barrier();
    }
}

/#

    // Namespace namespace_5ce9a33f888d9be5
    // Params 0, eflags: 0x4
    // Checksum 0xa706ee5, Offset: 0x1063
    // Size: 0x36, Type: dev
    function private debug_draw_trig()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( !getdvarint( @"hash_b2a03725aa1e2ff5", 0 ) )
            {
                waitframe();
                continue;
            }
            
            drawtrigger( self );
            waitframe();
        }
    }

#/
