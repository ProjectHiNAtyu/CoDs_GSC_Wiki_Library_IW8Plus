// scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_passive_spawn.gsc  (hash_5a066818bbd675a6.gscc) (size: 7228 Bytes / 0x1c3c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf71e9d78 (4145978744)
// size ...... 7228 (0x1c3c)
// includes .. 6   (offset: 0x1a9c)
// strings ... 24  (offset: 0x1acc)
// dev strs .. 1   (offset: 0x1c30)
// exports ... 20  (offset: 0xf44)
// cseg ...... 0x1f7 + 0xd4d (0xf44)
// imports ... 70  (offset: 0x1264)
// animtree1 . 0   (offset: 0x1c3c)
// animtree2 . 0   (offset: 0x1c3c)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_disciple_passive_spawn;

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0x6bc6dda0, Offset: 0x215
// Size: 0x6b
function function_8beffe11995644ce( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "portal_ground_spawn", settings.var_61440a02c4b0723d );
        utility::add_fx( "portal_ground_spawn_light", settings.var_9006cf1bf62049fb );
        utility::add_fx( "mq_trail_kill_trail", settings.var_9edaacd6298460ca );
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0xef21d798, Offset: 0x288
// Size: 0x165
function function_5012296bfc157445()
{
    if ( self getaiblackboarddynamic( "can_passive_spawn" ) )
    {
        self.var_7b40098f6851862a = [];
        self.passive_spawn_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_9088e567c4951a6c;
        self.passive_spawn_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_dc8c7bf74af573c9 ) );
        self.var_810566bec15e9a21 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3618302912931fbc;
        self.var_787aa5c9a0417a86 = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3011c9ac5302bfaa ) );
        self function_786bb6aa1b76c7ee( "in_passive_spawn", 0 );
        ai::set_blackboard_cooldown( "passive_spawn_cooldown", int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2caeeb59c003972d ) ) );
        thread init_passive_spawn_cooldown_listener();
        
        if ( !getdvarint( @"hash_dca6c5032ce96fa0", 0 ) )
        {
            thread function_558303ba3a7cacfe();
        }
        
        self.var_b1717d2a69306843 = function_b3988325430ce242( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_136584d2dbe389b4 );
        assert( isdefined( self.var_b1717d2a69306843 ), "<dev string:x24>" );
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0x7e06d77a, Offset: 0x3f5
// Size: 0x51
function function_e5b935ab2d04526c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "in_passive_spawn", 1 );
    function_dd1b94b9eed682c7( 1 );
    ai::set_blackboard_cooldown( "passive_spawn_cooldown", self.passive_spawn_cooldown );
    self function_786bb6aa1b76c7ee( "in_passive_spawn", 0 );
}

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0x1d1c3823, Offset: 0x44e
// Size: 0x60
function function_ee0d10cbd1ffeb7b( params )
{
    if ( isdefined( self.disciple_parent ) && isarray( self.disciple_parent.var_7b40098f6851862a ) )
    {
        self.disciple_parent.var_7b40098f6851862a = arrayremove( self.disciple_parent.var_7b40098f6851862a, self );
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0x84f475b2, Offset: 0x4b6
// Size: 0x87
function function_dd1b94b9eed682c7( spawn_count )
{
    self endon( #"death" );
    self.var_fadea7cb564eab83 = gettime() + self.var_787aa5c9a0417a86;
    spawn_points = get_passive_spawn_locations( spawn_count );
    
    if ( !isdefined( spawn_points ) || spawn_points.size <= 0 )
    {
        return;
    }
    
    assert( spawn_points.size <= spawn_count );
    
    for ( passive_count = 0; passive_count < spawn_points.size ; passive_count++ )
    {
        thread function_c802d7bc15794851( spawn_points[ passive_count ] );
        waitframe();
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0x355d4d3a, Offset: 0x545
// Size: 0x164
function function_c802d7bc15794851( spawn_point )
{
    self endon( #"death" );
    function_9e515ec7c02f6568( spawn_point );
    new_passive = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( self.var_b1717d2a69306843, spawn_point, self.angles, self.team );
    
    if ( isdefined( new_passive ) )
    {
        new_passive thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn_end", undefined, undefined, "spawn_animating" );
        new_passive utility::function_32b24db3127bff40( "injected", "injected_on" );
        
        if ( issubstr( new_passive.subclass, "zombie_vermin" ) )
        {
            new_passive utility::function_32b24db3127bff40( "eyes", "injected_on" );
        }
        
        new_passive callback::add( "on_zombie_ai_killed", &function_ee0d10cbd1ffeb7b );
        new_passive.disciple_parent = self;
        host_data_params = spawnstruct();
        host_data_params.disciple_parent = self;
        host_data_params.var_9ad7cc5d07653ebc = 1;
        host_data_params.var_b3e176999aae46d7 = &function_6251d09755416b0a;
        new_passive zombie_emergence_spawning::register_emergence_spawning_host_data( "disciple_parent", host_data_params );
        self.var_7b40098f6851862a[ self.var_7b40098f6851862a.size ] = new_passive;
        new_passive.var_5d3022108c155ed4 = #"hash_b5393e6bcc451e49";
        
        if ( zombie_utils::function_bf1464d09f4e4b40() )
        {
            new_passive zombie_utils::function_c2cee1190760989c( self );
            new_passive.forceannihilate = 1;
        }
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0xe903e9b1, Offset: 0x6b1
// Size: 0x21
function unlink_passive()
{
    self endon( #"death" );
    self waittill( #"unlink_spawned_ai" );
    self unlink();
}

// Namespace zombie_disciple_passive_spawn
// Params 2
// Checksum 0x46803839, Offset: 0x6da
// Size: 0xcc
function function_6251d09755416b0a( disciple_parent, var_9ad7cc5d07653ebc )
{
    assert( isdefined( disciple_parent ) );
    
    if ( isalive( disciple_parent ) )
    {
        self.disciple_parent = disciple_parent;
        
        if ( var_9ad7cc5d07653ebc && isarray( disciple_parent.var_7b40098f6851862a ) )
        {
            disciple_parent.var_7b40098f6851862a[ disciple_parent.var_7b40098f6851862a.size ] = self;
            self.var_9ad7cc5d07653ebc = 1;
            callback::add( "on_zombie_ai_killed", &function_ee0d10cbd1ffeb7b );
        }
    }
    
    if ( self.aicategory != "special" && self.aicategory != "elite" && self.aicategory != "hvt" )
    {
        self.var_5d3022108c155ed4 = #"hash_b5393e6bcc451e49";
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0x5a01a6e8, Offset: 0x7ae
// Size: 0x4b
function init_passive_spawn_cooldown_listener()
{
    self endon( #"death" );
    self waittill( #"hash_bbc17a460056247c" );
    self.passive_spawn_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e28d81cb44d24253 ) );
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0x1b7ef85a, Offset: 0x801
// Size: 0xdc
function function_558303ba3a7cacfe()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( getdvarint( @"hash_dca6c5032ce96fa0", 0 ) > 0 )
        {
            waitframe();
            continue;
        }
        
        self waittill( #"hash_929016c302152e7f" );
        limit_override = getdvarint( @"hash_4b493d00882d3469", -1 );
        
        if ( limit_override > -1 )
        {
            num_to_spawn = limit_override;
        }
        else
        {
            num_to_spawn = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5c33d1ac4b18a9f2 ?? 0;
        }
        
        num_to_spawn -= self.var_7b40098f6851862a.size;
        self function_786bb6aa1b76c7ee( "in_passive_spawn", 1 );
        
        if ( num_to_spawn > 0 )
        {
            function_dd1b94b9eed682c7( num_to_spawn );
        }
        
        ai::set_blackboard_cooldown( "passive_spawn_cooldown", self.passive_spawn_cooldown );
        self function_786bb6aa1b76c7ee( "in_passive_spawn", 0 );
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0x225f19fa, Offset: 0x8e5
// Size: 0x66
function function_1a7fe5db9a045d2b( delay_time )
{
    var_81780e0ae227b9cf = playfxontag( utility::getfx( "portal_ground_spawn" ), self, "tag_origin" );
    wait delay_time;
    portal_fx_light = playfxontag( utility::getfx( "portal_ground_spawn_light" ), self, "tag_origin" );
    
    if ( isdefined( self ) )
    {
        self notify( #"vfx_deleted" );
        self delete();
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0x956debe7, Offset: 0x953
// Size: 0x158
function get_passive_spawn_locations( spawn_count )
{
    self endon( #"death" );
    successful_spawns = [];
    var_4d020ff6a53caedb = spawn_count * 3;
    bounds = self getboundshalfsize();
    var_9cdf9e102abb7292 = squared( length( bounds ) + 15 );
    
    for ( attempts = 0; attempts < var_4d020ff6a53caedb && successful_spawns.size < spawn_count ; attempts++ )
    {
        random_point = utility::function_724309a65022770f( self.origin, self.passive_spawn_radius, 180, self.angles[ 1 ], self );
        
        if ( !isdefined( random_point ) )
        {
            continue;
        }
        
        if ( distancesquared( random_point, self.origin ) <= var_9cdf9e102abb7292 )
        {
            continue;
        }
        
        on_nav_mesh = getclosestpointonnavmesh( random_point, self, 0, 0, 0 );
        
        if ( !isdefined( on_nav_mesh ) )
        {
            continue;
        }
        
        blocked = navtrace( self.origin, on_nav_mesh, self );
        
        if ( blocked )
        {
            continue;
        }
        
        on_ground = utility::drop_to_ground( on_nav_mesh, 32, -100 );
        
        if ( !isdefined( on_ground ) )
        {
            continue;
        }
        
        if ( !callback::response( 2, "disciple_check_passive_spawn_location", { #location:on_ground } ) )
        {
            continue;
        }
        
        successful_spawns[ successful_spawns.size ] = on_ground;
    }
    
    return successful_spawns;
}

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0xb1914bfd, Offset: 0xab4
// Size: 0x114
function function_9e515ec7c02f6568( random_spawn )
{
    self endon( #"death" );
    vfx_start = utility::spawn_model( "tag_origin", self.origin, self.angles );
    utility::thread_on_notify_no_endon_death( "death", &cleanup_vfx, vfx_start );
    var_fc7ae3b912e4e9a8 = utility::spawn_model( "tag_origin", random_spawn );
    utility::thread_on_notify_no_endon_death( "death", &cleanup_vfx, var_fc7ae3b912e4e9a8 );
    vfx_start thread function_b8743f5a9219cf9b( random_spawn, "mq_trail_kill_trail", 30, undefined, undefined, 10, 200 );
    var_6aa2b88774afbb40 = spawnscriptable( %"scriptable_zombie_disciple_skoll_portal_energy_orb", random_spawn );
    utility::thread_on_notify_no_endon_death( "death", &cleanup_scriptable, var_6aa2b88774afbb40 );
    var_6aa2b88774afbb40 set_audio_orb_scriptable( "sfx_activate", vfx_start );
    vfx_start waittill( #"curve_done" );
    self notify( #"curve_done" );
    var_6aa2b88774afbb40 set_audio_orb_scriptable( "sfx_deactivate" );
    var_6aa2b88774afbb40 thread function_523032ca6541bcd0();
    var_fc7ae3b912e4e9a8 thread function_1a7fe5db9a045d2b( self.var_810566bec15e9a21 );
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0x12cfa78c, Offset: 0xbd0
// Size: 0x26
function function_523032ca6541bcd0()
{
    wait 2;
    
    if ( isdefined( self ) && utility::function_de1f80d93273abf5() )
    {
        self notify( #"scriptable_freed" );
        self freescriptable();
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 1
// Checksum 0x4ea924e5, Offset: 0xbfe
// Size: 0xd6
function function_7065f910e4bdaea6( spawn_point_array )
{
    var_ddbbfa8a9fdc4e5 = [];
    
    foreach ( idx, point in spawn_point_array )
    {
        disciple_forward_vector = anglestoforward( self.angles );
        var_93f84863b98a404c = vectornormalize( point - self.origin );
        dot_product = vectordot( var_93f84863b98a404c, disciple_forward_vector );
        
        if ( dot_product > 0.5 )
        {
            var_ddbbfa8a9fdc4e5[ var_ddbbfa8a9fdc4e5.size ] = idx;
        }
    }
    
    return var_ddbbfa8a9fdc4e5;
}

// Namespace zombie_disciple_passive_spawn
// Params 2
// Checksum 0x8c865b96, Offset: 0xcdd
// Size: 0x31
function set_audio_orb_scriptable( str_state, parententity )
{
    if ( isdefined( parententity ) )
    {
        utility::scriptable_setparententity( parententity );
    }
    
    self setscriptablepartstate( "orb_audio", str_state );
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0x7761bf81, Offset: 0xd16
// Size: 0x23
function cleanup_vfx()
{
    self endon( #"vfx_deleted" );
    
    if ( isdefined( self ) && !isagent( self ) )
    {
        self delete();
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 0
// Checksum 0xeef37ff5, Offset: 0xd41
// Size: 0x23
function cleanup_scriptable()
{
    self endon( #"scriptable_freed" );
    
    if ( isdefined( self ) && utility::function_de1f80d93273abf5() )
    {
        self freescriptable();
    }
}

// Namespace zombie_disciple_passive_spawn
// Params 7
// Checksum 0xb6cb3495, Offset: 0xd6c
// Size: 0x1d8
function function_b8743f5a9219cf9b( targetpos, var_521d025b303e59da, fly_z_offset, angles_blend_speed, var_99dfa1bd6d86270a, var_bb08488146c540f, override_distance )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"delete" );
    self.angles = vectortoangles( ( 0, 0, 1 ) );
    waitframe();
    
    if ( isdefined( var_521d025b303e59da ) && utility::getfx( var_521d025b303e59da ) )
    {
        playfxontag( utility::getfx( var_521d025b303e59da ), self, "tag_origin" );
    }
    
    if ( !isdefined( fly_z_offset ) )
    {
        fly_z_offset = 100;
    }
    
    if ( fly_z_offset > 0 )
    {
        self movez( fly_z_offset, 0.1 );
        self waittill( #"movedone" );
    }
    
    if ( !isdefined( angles_blend_speed ) )
    {
        angles_blend_speed = 0.02;
    }
    
    fly_speed = var_bb08488146c540f ?? 10;
    angles_blend = 0;
    
    while ( true )
    {
        face_angles = vectortoangles( targetpos - self.origin );
        new_angles = anglelerpquatfrac( self.angles, face_angles, angles_blend );
        self.angles = new_angles;
        self.origin = anglestoforward( self.angles ) * fly_speed + self.origin;
        
        if ( angles_blend <= 1 )
        {
            angles_blend += angles_blend_speed;
            angles_blend = clamp( angles_blend, 0, 1 );
        }
        
        dis = distancesquared( targetpos, self.origin );
        
        if ( isdefined( override_distance ) )
        {
            if ( dis <= override_distance )
            {
                break;
            }
        }
        else if ( dis <= 100 )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"curve_done" );
    
    if ( isdefined( self ) )
    {
        self notify( #"vfx_deleted" );
        self delete();
    }
}

