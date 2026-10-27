// scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_summon.gsc  (hash_01470d62646b2bd4.gscc) (size: 9594 Bytes / 0x257a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2af8c7b8 (720947128)
// size ...... 9594 (0x257a)
// includes .. 11  (offset: 0x22fa)
// strings ... 26  (offset: 0x2352)
// dev strs .. 9   (offset: 0x2506)
// exports ... 23  (offset: 0x1486)
// cseg ...... 0x20a + 0x127c (0x1486)
// imports ... 92  (offset: 0x181e)
// animtree1 . 0   (offset: 0x257a)
// animtree2 . 0   (offset: 0x257a)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_aetheric_energy;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_metabones;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_move;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_hermes_summon;

// Namespace zombie_hermes_summon
// Params 0
// Checksum 0x211c1aca, Offset: 0x228
// Size: 0x2
function function_cc3d5d4de2143b0a()
{
    
}

// Namespace zombie_hermes_summon
// Params 0
// Checksum 0x2b3d2234, Offset: 0x232
// Size: 0x16d
function init_zombie_hermes_summon()
{
    self.var_80fb20b86ca91310 = [ [ 0, 0, 0, 0 ], [ 20, 20, 8, 8 ], [ 12, 12, 6, 6 ] ];
    self.var_613bd8f462ce6cf4 = [ [ 0, 0, 0, 0 ], [ 8, 8, 12, 12 ], [ 10, 10, 14, 14 ] ];
    self.var_79124dbaa1f8423b = [];
    self.var_79124dbaa1f8423b[ "head_middle_le" ] = 0;
    self.var_79124dbaa1f8423b[ "head_middle_ri" ] = 0;
    self.var_b224d63d85ac0a22 = [];
    self.var_b224d63d85ac0a22[ "head_middle_le" ] = 0;
    self.var_b224d63d85ac0a22[ "head_middle_ri" ] = 0;
    set_summon_head_state( self, "head_middle_le", 0 );
    set_summon_head_state( self, "head_middle_ri", 0 );
    function_20830766f3579f29( self, "head_middle_le" );
    function_20830766f3579f29( self, "head_middle_ri" );
    thread function_ba1caf517b0ea822();
    self.hermes_spawned_zombies = [];
    thread function_24ed1c5ee56f1c21( self );
    
    /#
        thread function_9866fcd31edb51d4();
    #/
}

// Namespace zombie_hermes_summon
// Params 0, eflags: 0x4
// Checksum 0x768ff91, Offset: 0x3a7
// Size: 0x1a6
function private function_ba1caf517b0ea822()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( self.enemy ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.var_3196011060b46013 <= 1 )
        {
            waitframe();
            continue;
        }
        
        if ( getdvarint( @"hash_c18341c662683b7d", 0 ) > 0 )
        {
            waitframe();
            continue;
        }
        
        var_45e5efde83e789f8 = function_d5a27038399449c2( self );
        allies = getaiarrayinradius( self.origin, 4000, self.team );
        
        if ( allies.size > 40 - var_45e5efde83e789f8 )
        {
            waitframe();
            continue;
        }
        
        if ( zombie_hermes_aetheric_energy::is_stunned( self ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "hermes_new_phase_set_recently" ) )
        {
            waitframe();
            continue;
        }
        
        target_ent = undefined;
        
        if ( !utility::time_has_passed( self.last_dmg_struct.timehit, 1 ) && zombie_hermes_metabones::is_middle_head( self.last_dmg_struct.metabonename ) )
        {
            target_ent = self.last_dmg_struct.eattacker;
        }
        
        function_997a6b5bb65ff7bc( target_ent );
        wait_time = function_c2ab3ea979f674c4( self );
        start_time = gettime();
        
        while ( true )
        {
            calculated_wait_time = wait_time;
            
            if ( !utility::time_has_passed( self.last_dmg_struct.timehit, 1 ) && zombie_hermes_metabones::is_middle_head( self.last_dmg_struct.metabonename ) )
            {
                calculated_wait_time *= 0.5;
            }
            
            if ( utility::time_has_passed( start_time, calculated_wait_time ) )
            {
                break;
            }
            
            waitframe();
        }
    }
}

// Namespace zombie_hermes_summon
// Params 2, eflags: 0x4
// Checksum 0x9291dfc4, Offset: 0x555
// Size: 0x188
function private function_997a6b5bb65ff7bc( target_ent, head )
{
    self endon( #"death" );
    
    if ( !isdefined( target_ent ) )
    {
        enemies = self function_f017e352a29a57a1( self.origin, 4000, 1 );
        target_ent = utility::array_random( enemies );
    }
    
    if ( !head )
    {
        if ( target_ent )
        {
            head = function_13a2661e90b30364( self, target_ent );
        }
        else
        {
            head = utility::array_random( [ "head_middle_le", "head_middle_ri" ] );
        }
    }
    
    anim_index = head == "head_middle_le" ? 0 : 2;
    set_summon_head_state( self, head, 1 );
    utility::ent_flag_set( "hermes_summon_zombies" );
    utility::function_32b24db3127bff40( head + "_spawner", "on" );
    wait 0.1;
    thread zombie_hermes_move::function_b7220f627ff98dd5( self, head, target_ent );
    thread utility::thread_on_notify( "nade_swallowed", &function_c926e9dfbe1d25d4, self, self, "hermes_summon_zombies", head );
    self endon( #"nade_swallowed" );
    utility::waittill_notify_or_timeout( "hermes_can_summon", 2 );
    var_1927e31dc21dbf1e = function_d5a27038399449c2( self );
    spawn_i = 0;
    
    while ( spawn_i < var_1927e31dc21dbf1e )
    {
        spawn_summon( target_ent, head );
        wait randomfloatrange( 0.05, 0.2 );
        spawn_i += 1;
    }
    
    wait 1.5;
    utility::ent_flag_clear( "hermes_summon_zombies" );
    set_summon_head_state( self, head, 0 );
    utility::function_32b24db3127bff40( head + "_spawner", "off" );
}

// Namespace zombie_hermes_summon
// Params 1, eflags: 0x4
// Checksum 0x18ffbbd7, Offset: 0x6e5
// Size: 0x37
function private function_c926e9dfbe1d25d4( head )
{
    utility::ent_flag_clear( "hermes_summon_zombies" );
    set_summon_head_state( self, head, 0 );
    utility::function_32b24db3127bff40( head + "_spawner", "off" );
}

// Namespace zombie_hermes_summon
// Params 3
// Checksum 0x4fb03006, Offset: 0x724
// Size: 0x38
function set_summon_head_state( hermes, head, is_open )
{
    hermes.var_b224d63d85ac0a22[ head ] = is_open;
    function_20830766f3579f29( hermes, head );
}

// Namespace zombie_hermes_summon
// Params 2
// Checksum 0x7ad6cec8, Offset: 0x764
// Size: 0x27, Type: bool
function is_head_open( hermes, head )
{
    return hermes.var_b224d63d85ac0a22[ head ] ?? 0;
}

// Namespace zombie_hermes_summon
// Params 3
// Checksum 0x709283e4, Offset: 0x794
// Size: 0x38
function function_4862cc542f273305( hermes, head, is_no_anim )
{
    hermes.var_79124dbaa1f8423b[ head ] = is_no_anim;
    function_20830766f3579f29( hermes, head );
}

// Namespace zombie_hermes_summon
// Params 2
// Checksum 0xd802289c, Offset: 0x7d4
// Size: 0x9e
function function_20830766f3579f29( hermes, head )
{
    is_no_anim = hermes.var_79124dbaa1f8423b[ head ];
    head_open = hermes.var_b224d63d85ac0a22[ head ];
    
    if ( !( isdefined( is_no_anim ) && isdefined( head_open ) ) )
    {
        return;
    }
    
    anim_index = head == "head_middle_le" ? 0 : 2;
    
    if ( is_no_anim )
    {
        self function_68f2f6fd8a4ffcae( anim_index, 3 );
        return;
    }
    
    if ( head_open )
    {
        self function_68f2f6fd8a4ffcae( anim_index, 2 );
        return;
    }
    
    self function_68f2f6fd8a4ffcae( anim_index, 1 );
}

// Namespace zombie_hermes_summon
// Params 2, eflags: 0x4
// Checksum 0x7da62444, Offset: 0x87a
// Size: 0x38d
function private spawn_summon( target_ent, head )
{
    spawn_center = self.origin;
    spawn_angles = ( 0, 0, 0 );
    spawn_origin = spawn_center;
    
    if ( !head )
    {
        if ( target_ent )
        {
            head = function_13a2661e90b30364( self, target_ent );
        }
        else
        {
            head = utility::array_random( [ "head_middle_le", "head_middle_ri" ] );
        }
    }
    
    if ( head )
    {
        head_tag = zombie_hermes_metabones::get_head_tag( head );
        spawn_angles = self gettagangles( head_tag );
        spawn_origin = self gettagorigin( head_tag ) + anglestoup( spawn_angles ) * getdvarfloat( @"hash_3a34f808ea0b17b7", -50 );
    }
    
    if ( !head )
    {
        if ( isdefined( target_ent ) )
        {
            spawn_angles = vectortoangles( utility::flatten_vector( target_ent.origin - self.origin ) );
        }
        else
        {
            spawn_angles = self.angles + ( 0, utility::array_random( [ -90, 90 ] ), 0 );
        }
    }
    
    spawn_angles = ( getdvarfloat( @"hash_e1be253b167a12b7", 0 ), spawn_angles[ 1 ], spawn_angles[ 2 ] );
    spawn_angles += ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 0 );
    spawn_dir = anglestoforward( spawn_angles );
    
    if ( !isdefined( spawn_origin ) )
    {
        spawn_origin = spawn_center + spawn_dir * 400;
    }
    
    subclass = utility::array_random( [ "zombie_base", "zombie_base_armored_heavy", "zombie_shade" ] );
    aitype = function_b3988325430ce242( subclass );
    zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, spawn_origin, spawn_angles, self.team );
    
    if ( isdefined( zombie ) )
    {
        cannonball_force = getdvarfloat( @"hash_3fbe84d876276ac5", 700 );
        cannonball_force += randomfloatrange( -100, 100 );
        var_9497266774268ded = vectordot( self.hermes_velocity, spawn_dir ) * getdvarfloat( @"hash_5a014b6d0b333491", 1 );
        cannonball_force += var_9497266774268ded;
        cannonball_force = max( cannonball_force, 100 );
        zombie zombie_cannonball::cannonball_ai( spawn_dir, cannonball_force, zombie_cannonball::adv_settings( 0.8, 10, 0, 400 ), "roll_forward" );
        zombie utility::function_32b24db3127bff40( "hermes_spawn_fx", "in_air" );
        zombie thread function_ca4809403c03a9ee();
        zombie thread utility::thread_on_notify( "cannonball_end", &utility::function_32b24db3127bff40, zombie, undefined, undefined, "hermes_spawn_fx", "off" );
        zombie thread utility::thread_on_notify( "cannonball_hit_wall", &function_308121f6f1228086, zombie, zombie, "cannonball_end" );
        zombie zombie_utils::set_zombie_round_difficulty( zombie_utils::get_zombie_round_difficulty(), 1, 1 );
        zombie utility::ent_flag_set( "hermes_spawn" );
        
        if ( isdefined( self.var_7b6457a80abc9e9c ) )
        {
            zombie.var_50c96a5c56dab386 = self.var_7b6457a80abc9e9c;
        }
        
        zombie.no_powerups = 1;
        speed = utility::cointoss() ? "sprint" : "run";
        
        if ( isdefined( self.adds_get_speed ) )
        {
            speed = zombie [[ self.adds_get_speed ]]();
        }
        
        zombie zombie_utils::function_a8ce00e0448cb6f0( speed, "hermes_base", 6 );
        
        if ( !isdefined( self.hermes_spawned_zombies ) )
        {
            self.hermes_spawned_zombies = [];
        }
        
        self.hermes_spawned_zombies[ self.hermes_spawned_zombies.size ] = zombie;
        
        /#
            if ( debug_summon() )
            {
                line( spawn_center, spawn_center + spawn_dir * 400, ( 1, 0, 0 ) );
            }
        #/
    }
}

// Namespace zombie_hermes_summon
// Params 0, eflags: 0x4
// Checksum 0x14658cb0, Offset: 0xc0f
// Size: 0x12d
function private function_308121f6f1228086()
{
    velocity = self getvelocity();
    veh = undefined;
    ray_start = self getcentroid();
    trace = trace::ray_trace( ray_start, ray_start + velocity, self, physics_createcontents( [ "physicscontents_vehicle" ] ) );
    
    if ( trace && trace[ "entity" ] && trace[ "entity" ].vehicletype )
    {
        veh = trace[ "entity" ];
        force_pos = coordtransformtranspose( trace[ "position" ], veh.origin, veh.angles );
        var_668e72dc9108eff5 = getdvarfloat( @"hash_c612accf0050bd66", 500 );
        var_3af8104146c25e5 = utility::flat_origin( velocity );
        veh vehphys_force( var_3af8104146c25e5 * var_668e72dc9108eff5, force_pos, 0 );
    }
    
    if ( self._blackboard.var_3939ee2f53498a2e && !veh )
    {
        return;
    }
    
    self kill();
    corpse = self getcorpseentity();
    
    if ( corpse )
    {
        corpse startragdollfromimpact( "torso_upper", velocity * 10 );
    }
}

// Namespace zombie_hermes_summon
// Params 0, eflags: 0x4
// Checksum 0x6533917d, Offset: 0xd44
// Size: 0x106
function private function_ca4809403c03a9ee()
{
    self endon( #"cannonball_end" );
    self endon( #"death" );
    
    while ( true )
    {
        velocity = self getvelocity();
        var_d3d10fbd56987b9c = vectornormalize( velocity );
        veh = undefined;
        ray_start = self getcentroid();
        trace = trace::ray_trace( ray_start, ray_start + var_d3d10fbd56987b9c * 20, self, physics_createcontents( [ "physicscontents_vehicle" ] ) );
        
        if ( trace && trace[ "entity" ] && trace[ "entity" ].vehicletype )
        {
            veh = trace[ "entity" ];
            force_pos = coordtransformtranspose( trace[ "position" ], veh.origin, veh.angles );
            var_668e72dc9108eff5 = getdvarfloat( @"hash_d408cff899bd84a9", 500 );
            veh vehphys_force( velocity * var_668e72dc9108eff5, force_pos, 0 );
        }
        
        waitframe();
    }
}

// Namespace zombie_hermes_summon
// Params 2, eflags: 0x4
// Checksum 0xb534f55e, Offset: 0xe52
// Size: 0xec
function private function_13a2661e90b30364( hermes, target_ent )
{
    to_target_ent = utility::flatten_vector( target_ent.origin - self.origin );
    var_6a1cfc5c28a478f4 = vectortoangles( to_target_ent );
    var_e03a976980256ff1 = [ "head_middle_le", "head_middle_ri" ];
    closest_head_index = undefined;
    var_4840952ce0bd8d9 = undefined;
    var_e8b483d049d7276b = 0;
    
    while ( var_e8b483d049d7276b < var_e03a976980256ff1.size )
    {
        head_tag = zombie_hermes_metabones::get_head_tag( var_e03a976980256ff1[ var_e8b483d049d7276b ] );
        var_cbae022e329d2a51 = hermes gettagangles( head_tag );
        angle_delta = anglesdelta( var_cbae022e329d2a51, var_6a1cfc5c28a478f4 );
        
        if ( !var_4840952ce0bd8d9 || angle_delta < var_4840952ce0bd8d9 )
        {
            var_4840952ce0bd8d9 = angle_delta;
            closest_head_index = var_e8b483d049d7276b;
        }
        
        var_e8b483d049d7276b += 1;
    }
    
    return var_e03a976980256ff1[ closest_head_index ];
}

// Namespace zombie_hermes_summon
// Params 1, eflags: 0xc
// Checksum 0xc4dedf49, Offset: 0xf47
// Size: 0x23e
function private function_24ed1c5ee56f1c21( hermes )
{
    self notify( #"hash_a699c727e796f4f9" );
    self endon( #"hash_a699c727e796f4f9" );
    hermes endon( #"death" );
    
    while ( true )
    {
        var_daae332bb407e542 = 10;
        var_d37cd04e79413d2e = 10000;
        player_fov_check = cos( 65 );
        hermes.hermes_spawned_zombies = function_46f9072493651dc9( hermes.hermes_spawned_zombies );
        
        if ( hermes.hermes_spawned_zombies.size <= var_daae332bb407e542 )
        {
            waitframe();
            continue;
        }
        
        var_4b007e44d88cce6a = undefined;
        lowest_influence = undefined;
        
        foreach ( zombie in hermes.hermes_spawned_zombies )
        {
            if ( !zombie utility::ent_flag( "hermes_spawn" ) )
            {
                continue;
            }
            
            if ( gettime() - zombie.birthtime < var_d37cd04e79413d2e )
            {
                continue;
            }
            
            is_visible = 0;
            
            foreach ( player in level.players )
            {
                if ( player math::point_in_fov( zombie.origin, player_fov_check, 0 ) )
                {
                    is_visible = 1;
                    break;
                }
            }
            
            if ( is_visible )
            {
                continue;
            }
            
            zombie_influence = getinfluencedistanceatposition( zombie.origin );
            
            if ( !isdefined( lowest_influence ) || lowest_influence > zombie_influence )
            {
                zombie_influence = lowest_influence;
                var_4b007e44d88cce6a = zombie;
            }
        }
        
        if ( isdefined( var_4b007e44d88cce6a ) )
        {
            var_4b007e44d88cce6a.death_source = "hermes_cleanup";
            var_4b007e44d88cce6a ai::function_dd7b3233e5b07718( 1 );
        }
        
        wait 1;
    }
}

// Namespace zombie_hermes_summon
// Params 1, eflags: 0x4
// Checksum 0xbf23ea9d, Offset: 0x118d
// Size: 0x6e
function private function_d5a27038399449c2( hermes )
{
    phase = zombie_hermes_aetheric_energy::get_hermes_phase( hermes );
    player_num = int( clamp( getplayersinradius( hermes.origin, 4000 ).size - 1, 0, 4 ) );
    num = hermes.var_613bd8f462ce6cf4[ phase - 1 ][ player_num ];
    return int( num );
}

// Namespace zombie_hermes_summon
// Params 1, eflags: 0x4
// Checksum 0x13bd4784, Offset: 0x1204
// Size: 0xaa
function private function_c2ab3ea979f674c4( hermes )
{
    phase = zombie_hermes_aetheric_energy::get_hermes_phase( hermes );
    player_num = int( clamp( getplayersinradius( hermes.origin, 4000 ).size - 1, 0, 4 ) );
    time_s = hermes.var_80fb20b86ca91310[ phase - 1 ][ player_num ];
    
    if ( hermes.var_2ce10a01582b08b0 > 0 )
    {
        cooldown_increase = hermes.var_2ce10a01582b08b0 * 20;
        time_s += cooldown_increase;
    }
    
    if ( time_s == 0 )
    {
        time_s = level.framedurationseconds;
    }
    
    return time_s;
}

// Namespace zombie_hermes_summon
// Params 0, eflags: 0x4
// Checksum 0xa319015e, Offset: 0x12b7
// Size: 0x12, Type: bool
function private debug_summon()
{
    return getdvarint( @"hash_776b21c6f6ed6b82", 0 ) > 0;
}

/#

    // Namespace zombie_hermes_summon
    // Params 0, eflags: 0x4
    // Checksum 0x1fd61738, Offset: 0x12d2
    // Size: 0x6d, Type: dev
    function private function_9866fcd31edb51d4()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x4a>", &function_dd7d98d21941999c, 1 );
        devgui::add_devgui_func( "<dev string:x5e>", "<dev string:x71>", &force_summon_spawn );
        devgui::add_devgui_func( "<dev string:x85>", "<dev string:xa8>", &function_bebe3253046866c7 );
        devgui::function_77df7fe7dd273e10();
        
        if ( debug_summon() )
        {
            level thread function_ed39acc685eef4bb();
        }
    }

    // Namespace zombie_hermes_summon
    // Params 0, eflags: 0x4
    // Checksum 0xf23eb1cc, Offset: 0x1347
    // Size: 0x43, Type: dev
    function private force_summon_spawn()
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xcc>" );
        
        if ( !isdefined( hermes ) )
        {
            return;
        }
        
        hermes spawn_summon();
    }

    // Namespace zombie_hermes_summon
    // Params 0, eflags: 0x4
    // Checksum 0xd2c9dcb, Offset: 0x1392
    // Size: 0x4e, Type: dev
    function private function_bebe3253046866c7()
    {
        hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xcc>" );
        
        if ( !isdefined( hermes ) )
        {
            return;
        }
        
        hermes function_997a6b5bb65ff7bc( level.players[ 0 ] );
    }

    // Namespace zombie_hermes_summon
    // Params 1, eflags: 0x4
    // Checksum 0xf8d7281e, Offset: 0x13e8
    // Size: 0x44, Type: dev
    function private function_dd7d98d21941999c( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xda>", @"hash_776b21c6f6ed6b82" );
        
        if ( debug_summon() )
        {
            level thread function_ed39acc685eef4bb();
            return;
        }
        
        level notify( #"hash_932c3ca3171c1f62" );
    }

    // Namespace zombie_hermes_summon
    // Params 0, eflags: 0x4
    // Checksum 0xc1d16204, Offset: 0x1434
    // Size: 0x52, Type: dev
    function private function_ed39acc685eef4bb()
    {
        level endon( #"hash_932c3ca3171c1f62" );
        
        while ( true )
        {
            hermes = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xcc>" );
            
            if ( !isdefined( hermes ) )
            {
                waitframe();
                continue;
            }
            
            waitframe();
        }
    }

#/
