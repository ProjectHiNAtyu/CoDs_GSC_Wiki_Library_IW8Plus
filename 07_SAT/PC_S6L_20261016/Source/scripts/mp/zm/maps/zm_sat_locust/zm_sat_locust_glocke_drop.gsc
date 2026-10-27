// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_glocke_drop.gsc  (hash_2f6671165863f84d.gscc) (size: 27347 Bytes / 0x6ad3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd985451 (228086865)
// size ...... 27347 (0x6ad3)
// includes .. 21  (offset: 0x6493)
// strings ... 73  (offset: 0x653b)
// dev strs .. 32  (offset: 0x6937)
// exports ... 44  (offset: 0x44ff)
// cseg ...... 0x5ce + 0x3f31 (0x44ff)
// imports ... 201 (offset: 0x4bdf)
// animtree1 . 0   (offset: 0x6ad3)
// animtree2 . 0   (offset: 0x6ad3)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\status_effects\status_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\shadowvortex;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\killstreaks\zm_robot_controller;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_glocke_drop;

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x1
// Checksum 0x9b42ec2d, Offset: 0x5ec
// Size: 0x449
function autoexec function_3848a33b62f47f9d()
{
    level.robot_glocke_drop = spawnstruct();
    level.robot_glocke_drop.is_active = 0;
    level.robot_glocke_drop.var_2e3da9d8f4a7838 = { #halfsize:function_decb653c5689e4ca( %"sat_locust_zm_obadiah" ) };
    level.robot_glocke_drop.objweapon = weapon_utility::function_d2c8356dc369d9ce( "sat_ks_bernard_primary_zm" );
    level.robot_glocke_drop.var_36db936b5320c625 = getdvarfloat( @"hash_16783672ae12dce6", 60 );
    delivery_loot_data = { #gravity_arc_height:60, #additional_delay:0.2, #start_delay:1 };
    var_58ac1588544e5320 = { #var_a4a892fd7a622e19:0.4, #var_9fbabc9764ecf42c:0.5, #enemy_raise_time:1, #var_90feaa9184659cec:50, #height:125 };
    var_3952bbe8d6da30ec = { #ultra_items:[ %"hash_5ccd4ffef24f2106", %"hash_613157257e008eff" ], #ultra_chance:getdvarfloat( @"hash_7d7ee0c087119fd5", 50 ), #kill_req:[ [ getdvarint( @"hash_7b6737843df4ef28", 5 ), getdvarint( @"hash_7b673a843df4f5c1", 8 ), getdvarint( @"hash_7b6739843df4f38e", 10 ) ], [ getdvarint( @"hash_b7e5c8a97ec429f2", 8 ), getdvarint( @"hash_b7e5c7a97ec427bf", 10 ), getdvarint( @"hash_b7e5c6a97ec4258c", 12 ) ], [ getdvarint( @"hash_e5bf856fae5a1820", 9 ), getdvarint( @"hash_e5bf886fae5a1eb9", 12 ), getdvarint( @"hash_e5bf876fae5a1c86", 15 ) ], [ getdvarint( @"hash_725e4334cf427c41", 10 ), getdvarint( @"hash_725e4034cf4275a8", 14 ), getdvarint( @"hash_725e4134cf4277db", 18 ) ] ], #duration:[ getdvarfloat( @"hash_f020b056259827f7", 15 ), getdvarfloat( @"hash_f020b15625982a2a", 18 ), getdvarfloat( @"hash_f020b25625982c5d", 20 ) ], #radius:[ getdvarint( @"hash_b94740f101ed30e5", 512 ), getdvarint( @"hash_b9473df101ed2a4c", 512 ), getdvarint( @"hash_b9473ef101ed2c7f", 512 ) ], #num_to_spawn:[ getdvarint( @"hash_2c6081d638e30bcc", 4 ), getdvarint( @"hash_2c6084d638e31265", 6 ), getdvarint( @"hash_2c6083d638e31032", 8 ) ], #var_c04e417f8531bdb5:3 };
    var_1234b50cd689ee = structcopy( var_58ac1588544e5320 );
    var_1234b50cd689ee.radius = 1024;
    var_1234b50cd689ee.duration = 20;
    var_1234b50cd689ee.var_a4a892fd7a622e19 = 0.8;
    function_d1504897d2095e1c( "delivery_loot", delivery_loot_data, var_58ac1588544e5320, { #var_df56e688222dbef5:level.robot_glocke_drop.var_2e3da9d8f4a7838.halfsize[ 1 ] }, var_3952bbe8d6da30ec );
    function_d1504897d2095e1c( "delivery_loot_no_minigame", delivery_loot_data, var_1234b50cd689ee, { #var_df56e688222dbef5:128 }, var_3952bbe8d6da30ec );
    function_d1504897d2095e1c( "delivery_quest", delivery_loot_data, var_1234b50cd689ee, { #var_df56e688222dbef5:128 }, var_3952bbe8d6da30ec );
    function_d1504897d2095e1c( "delivery_quest_no_float", undefined, undefined, { #var_df56e688222dbef5:128 } );
    function_d1504897d2095e1c( "attack", undefined, undefined, { #var_df56e688222dbef5:128 } );
    level thread function_3f54c9361ceca67c();
    utility::add_fx( "glocke_drop_landing_indicator", "vfx_sat_levels_zm_locust_glocke_land_indicator_loop" );
    
    /#
        function_c4d14a0f3518d92a();
    #/
}

// Namespace zm_sat_locust_glocke_drop
// Params 5
// Checksum 0xca473f26, Offset: 0xa3d
// Size: 0x174
function function_d1504897d2095e1c( type, var_57fdcc855c1a3725, float_data, misc_data, tier_data )
{
    assert( isdefined( type ) );
    assert( !isdefined( level.robot_glocke_drop.types[ type ] ) );
    
    /#
        if ( isdefined( tier_data ) )
        {
            assert( tier_data.var_c04e417f8531bdb5 == tier_data.num_to_spawn.size );
            assert( tier_data.var_c04e417f8531bdb5 == tier_data.radius.size );
            assert( tier_data.var_c04e417f8531bdb5 == tier_data.duration.size );
            assert( tier_data.var_c04e417f8531bdb5 == tier_data.kill_req[ 0 ].size && tier_data.var_c04e417f8531bdb5 == tier_data.kill_req[ 1 ].size );
        }
    #/
    
    if ( !isdefined( level.robot_glocke_drop.types ) )
    {
        level.robot_glocke_drop.types = [];
    }
    
    level.robot_glocke_drop.types[ type ] = { #tier:tier_data, #misc:misc_data, #float:float_data, #loot:var_57fdcc855c1a3725 };
}

// Namespace zm_sat_locust_glocke_drop
// Params 1
// Checksum 0xd37171ac, Offset: 0xbb9
// Size: 0x58
function function_e77f3a459c886b1c( params )
{
    request_position = params.request_position;
    from_position = params.from_position;
    type = params.type;
    request_glocke_drop( request_position, from_position, type );
}

// Namespace zm_sat_locust_glocke_drop
// Params 3
// Checksum 0x4fa78d2b, Offset: 0xc19
// Size: 0x5e
function request_glocke_drop( request_position, from_position, type )
{
    level.robot_glocke_drop.is_active = 1;
    drop = function_732644686f90e858( request_position, from_position, type );
    drop thread move_glocke_drop();
    drop thread function_f1d27027c81bf008();
    return drop;
}

// Namespace zm_sat_locust_glocke_drop
// Params 3, eflags: 0x4
// Checksum 0x74f176b9, Offset: 0xc80
// Size: 0x7e
function private function_732644686f90e858( request_position, from_position = ( 3945, 9906, 1484 ), type )
{
    params = { #var_f5ff424098b1d5f9:0, #from_position:from_position, #request_position:request_position, #type:type };
    drop = create_glocke_drop( params );
    return drop;
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0x5dc3d7e1, Offset: 0xd07
// Size: 0x1b6
function private create_glocke_drop( params )
{
    ground_vfx = utility::spawn_model( "tag_origin", params.request_position, ( 0, 0, 0 ) );
    playfxontag( utility::getfx( "glocke_drop_landing_indicator" ), ground_vfx, "tag_origin" );
    glocke = spawnscriptable( %"sat_zm_prop_obadiah", params.from_position, ( 0, 0, 0 ), undefined );
    glocke setscriptablepartstate( #"pod", #"flying" );
    glocke setscriptablepartstate( #"effects", #"aether_energy" );
    glocke.parent_ent = utility::spawn_model( "tag_origin", glocke.origin, glocke.angles );
    glocke utility::scriptable_setparententity( glocke.parent_ent );
    data = get_glocke_drop_data( params.type );
    control_point = averagepoint( [ params.from_position, params.request_position ] );
    control_point = ( params.request_position[ 0 ], params.request_position[ 1 ], 5000 );
    params.control_point = control_point;
    level callback::callback( #"glocke_drop_created", params );
    return { #owner:self, #params:params, #data:data, #glocke:glocke, #ground_vfx:ground_vfx };
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x9da98b25, Offset: 0xec6
// Size: 0x2af
function private move_glocke_drop()
{
    level endon( #"game_ended" );
    self endon( #"drop_destroyed" );
    glocke = self.glocke;
    params = self.params;
    control_point_offset = params.control_point_offset ?? 0;
    direction = vectornormalize2( params.request_position - params.from_position );
    var_6c351f76714091f6 = direction * control_point_offset;
    control_point = params.control_point;
    control_point += var_6c351f76714091f6;
    
    if ( params.height_override )
    {
        control_point = ( params.request_position[ 0 ], params.request_position[ 1 ], params.height_override );
    }
    
    min_move_time = 3;
    max_move_time = 4.5;
    move_time = mapfloat( 2000, 10000, min_move_time, max_move_time, distance2d( params.from_position, params.request_position ) );
    z_offset = -2;
    ground_pos = getgroundposition( params.request_position, 16 );
    ground_pos = ( round( ground_pos[ 0 ] ), round( ground_pos[ 1 ] ), round( ground_pos[ 2 ] + z_offset ) );
    
    /#
        if ( getdvarint( @"hash_ad2a60830d3a8d32", 0 ) == 1 )
        {
            debug::sphere( params.request_position, 64, ( 1, 0, 0 ), 10 );
            debug::sphere( params.from_position, 64, ( 0, 1, 0 ), 10 );
            debug::sphere( control_point, 64, ( 0, 0, 1 ), 10 );
            debug::sphere( ground_pos, 64, ( 1, 1, 0 ), 10 );
            iprintln( "<dev string:x24>" + move_time );
        }
    #/
    
    glocke.parent_ent rotateyaw( 1080, move_time );
    glocke.parent_ent thread utility::function_8001268940441423( params.from_position, ground_pos, control_point, move_time, 0, 1 );
    glocke.parent_ent waittill( #"off_bezier_curve" );
    glocke.parent_ent moveto( ground_pos, level.framedurationseconds );
    glocke.parent_ent waittill( #"movedone" );
    glocke notify( #"drop_landed" );
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0xba3b50ae, Offset: 0x117d
// Size: 0x11c
function private function_f1d27027c81bf008()
{
    self endon( #"drop_destroyed" );
    glocke = self.glocke;
    params = self.params;
    glocke waittill( #"drop_landed" );
    killfxontag( utility::getfx( "glocke_drop_landing_indicator" ), self.ground_vfx, "tag_origin" );
    self.ground_vfx delete();
    
    if ( isdefined( self.glocke.land_override ) )
    {
        self [[ self.glocke.land_override ]]();
    }
    
    switch ( params.type )
    {
        case #"hash_410a54b4ca2df8b2":
        case #"hash_4c4f2db3500e68b8":
            loot_glocke_drop();
            break;
        case #"hash_594dfa0e55838f8":
            function_e7d21c88b19e5785();
            break;
        case #"hash_e87de59c6b424c8b":
            quest_glocke_drop();
            break;
        case #"hash_2d1406e602f0875d":
            attack_glocke_drop();
            break;
    }
    
    destroy_glocke_drop();
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x1a3d8cd, Offset: 0x12a1
// Size: 0x29
function private attack_glocke_drop()
{
    self.glocke setscriptablepartstate( #"pod", #"landed_attack" );
    function_37e7bf93f1a2d5c9();
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x9541595e, Offset: 0x12d2
// Size: 0x190
function private loot_glocke_drop()
{
    self endon( #"drop_destroyed" );
    self endon( #"hash_195b898b4bdb4218" );
    self.glocke setscriptablepartstate( #"pod", #"landed" );
    
    if ( self.data.tier || self.data.float )
    {
        radius = self.data.float.radius ?? self.data.tier.radius[ 0 ];
        var_df56e688222dbef5 = round( self.data.misc.var_df56e688222dbef5 );
        physicsexplosionsphere( self.glocke.origin, radius, var_df56e688222dbef5 * 2, 250 );
    }
    
    thread function_2c27607340145408();
    function_459454825e28385e();
    function_37e7bf93f1a2d5c9();
    
    if ( self.params.type == "delivery_loot" )
    {
        function_a8988d16c947d546();
        return;
    }
    
    if ( self.params.type == "delivery_loot_no_minigame" )
    {
        float_data = self.data.float;
        function_3e12601a05680412( float_data.duration, 0, float_data.radius );
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x47bfef12, Offset: 0x146a
// Size: 0x110
function private function_2c27607340145408()
{
    raw_radius = round( level.robot_glocke_drop.var_2e3da9d8f4a7838.halfsize[ 1 ] );
    top_radius = round( raw_radius * 0.8 );
    search_radius = round( raw_radius * 2 );
    trigger = spawn( "noent_volume_trigger_radius", self.glocke.origin + ( 0, 0, level.robot_glocke_drop.var_2e3da9d8f4a7838.halfsize[ 2 ] + top_radius ), 0, top_radius, top_radius );
    trigger.n_push_strength = 350;
    trigger.jump_offset = ( 0, 0, 8 );
    trigger.raw_radius = raw_radius;
    trigger.search_radius = search_radius;
    thread function_95619e6920866a31( trigger );
    self waittill( #"drop_destroyed" );
    trigger delete();
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0xd1eea65f, Offset: 0x1582
// Size: 0x6a
function private function_95619e6920866a31( trigger )
{
    trigger endon( #"death" );
    self endon( #"drop_destroyed" );
    
    for ( ;; )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player.being_pushed )
        {
            continue;
        }
        
        thread glocke_push_player( player, trigger );
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 2, eflags: 0xc
// Checksum 0x69d25b29, Offset: 0x15f4
// Size: 0x29f
function private glocke_push_player( player, trigger )
{
    self notify( #"hash_8f3ecf930133b986" );
    self endon( #"hash_8f3ecf930133b986" );
    self endon( #"disconnect" );
    closest_tacpoint = ai::function_20e2b5e7fcba9f36( self.glocke.origin, trigger.search_radius, 0, 64 );
    tacpoints = ai::function_c6bf02d2d6899f3( self.glocke.origin, trigger.search_radius, trigger.raw_radius, 64, closest_tacpoint.var_6f9c4e415e80942f );
    movement_dir = vectornormalize( player getvelocity() );
    tacpoint = undefined;
    
    foreach ( potential_tacpoint in tacpoints )
    {
        tacpoint_dir = vectornormalize( potential_tacpoint.origin - player.origin );
        dot = vectordot( tacpoint_dir, movement_dir );
        
        if ( dot > 0 )
        {
            continue;
        }
        
        tacpoint = potential_tacpoint;
        break;
    }
    
    if ( !tacpoint )
    {
        tacpoint = function_47c86977a18df38b( tacpoints, self.glocke.origin );
    }
    
    if ( player isjumping() )
    {
        origin = player.origin;
    }
    else
    {
        origin = player.origin + trigger.jump_offset;
        player setorigin( origin );
    }
    
    var_2501b9aef17e35f9 = vectornormalize( tacpoint.origin - origin );
    player val::set( #"glocke_drop", "allow_jump", 0 );
    player val::set( #"glocke_drop", "prone", 0 );
    player val::set( #"glocke_drop", "allow_wall_jump", 0 );
    player.being_pushed = 1;
    player knockback( var_2501b9aef17e35f9, trigger.n_push_strength, 1 );
    
    while ( isalive( player ) && !isdefined( player getgroundentity() ) )
    {
        waitframe();
    }
    
    player val::reset_all( #"glocke_drop" );
    player.being_pushed = undefined;
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x7b83f537, Offset: 0x189b
// Size: 0xd5
function private quest_glocke_drop()
{
    self endon( #"drop_destroyed" );
    self.glocke setscriptablepartstate( #"pod", #"landed" );
    thread function_2c27607340145408();
    function_459454825e28385e();
    wait 0.5;
    state = [ #"rare", #"epic", #"legendary" ];
    f_initial_delay = 1;
    f_decay = 0.25;
    
    for ( i = 0; i < 3 ; i++ )
    {
        wait clamp( f_initial_delay - f_decay, 0.25, 1 );
        self.glocke setscriptablepartstate( #"loot_effect", state[ i ] );
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0xaaa1988b, Offset: 0x1978
// Size: 0x11c
function private function_e7d21c88b19e5785()
{
    self endon( #"drop_destroyed" );
    self endon( #"hash_195b898b4bdb4218" );
    self.glocke setscriptablepartstate( #"pod", #"landed" );
    thread function_2c27607340145408();
    function_459454825e28385e();
    float_data = self.data.float;
    function_3e12601a05680412( float_data.duration, 0, float_data.radius );
    wait 0.5;
    state = [ #"rare", #"epic", #"legendary" ];
    f_initial_delay = 1;
    f_decay = 0.25;
    
    for ( i = 0; i < 3 ; i++ )
    {
        wait clamp( f_initial_delay - f_decay, 0.25, 1 );
        self.glocke setscriptablepartstate( #"loot_effect", state[ i ] );
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0xaad2e71e, Offset: 0x1a9c
// Size: 0x34c
function private function_a8988d16c947d546()
{
    self endon( #"drop_destroyed" );
    self endon( #"hash_195b898b4bdb4218" );
    level callback::add( "on_zombie_ai_killed", &function_5c0ea11dd8f0b55b, self );
    self.var_85bcee10513e25ef = {};
    self.var_85bcee10513e25ef.kills = 0;
    function_7adee96e7aba5ca0( 0 );
    tier_data = self.data.tier;
    var_c04e417f8531bdb5 = tier_data.var_c04e417f8531bdb5;
    pulses = getdvarint( @"hash_9f3f1fca72dba4a8", 2 );
    start_time = gettime();
    
    /#
        thread function_cde8c5bd8c39fdd2();
    #/
    
    while ( true )
    {
        duration = tier_data.duration[ self.var_85bcee10513e25ef.tier ];
        pulse_duration = duration / pulses;
        start_wave_time = gettime();
        
        /#
            self.var_85bcee10513e25ef.var_1461a132e7ccc81 = gettime();
        #/
        
        for ( i = 0; i < pulses ; i++ )
        {
            timer = i == 0 ? duration : pulse_duration;
            stun = i == 0;
            function_619c72614bf54fda( timer, stun, i == 0 );
            msg = utility::waittill_notify_or_timeout_return( "continue_loot_float", pulse_duration );
            end_wave_time = gettime();
            
            if ( msg == "continue_loot_float" )
            {
                function_7adee96e7aba5ca0( self.var_85bcee10513e25ef.tier + 1 );
                logstring( "[GLOCKE DROP] Minigame - Tier " + self.var_85bcee10513e25ef.tier + " COMPLETED in " + ( end_wave_time - start_wave_time ) * 0.001 + " / " + duration + " seconds with " + self.var_85bcee10513e25ef.kills + " kills." );
                self.var_85bcee10513e25ef.kills = 0;
                self.var_85bcee10513e25ef.zombies = [];
                
                if ( self.var_85bcee10513e25ef.tier < var_c04e417f8531bdb5 )
                {
                    self notify( #"level_up_loot_float" );
                    wait 3;
                    break;
                }
                else
                {
                    self notify( #"level_complete_loot_float" );
                    completed_game = 1;
                }
            }
            else
            {
                failed = msg == "timeout" && i == pulses - 1;
            }
            
            if ( failed || completed_game )
            {
                end_time = gettime();
                delta_time = end_time - start_time;
                
                if ( failed )
                {
                    logstring( "[GLOCKE DROP] Minigame - Tier " + self.var_85bcee10513e25ef.tier + 1 + " FAILED after " + ( end_wave_time - start_wave_time ) * 0.001 + " seconds with " + self.var_85bcee10513e25ef.kills + " kills." );
                }
                else
                {
                    logstring( "[GLOCKE DROP] Minigame - Completed in " + delta_time * 0.001 + " seconds" );
                }
                
                self notify( #"hash_195b898b4bdb4218" );
                return;
            }
        }
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0xe63f506e, Offset: 0x1df0
// Size: 0xb9
function private function_7adee96e7aba5ca0( tier )
{
    self.var_85bcee10513e25ef.tier = tier;
    
    switch ( tier )
    {
        case 1:
            self.glocke setscriptablepartstate( #"loot_effect", #"rare" );
            break;
        case 2:
            self.glocke setscriptablepartstate( #"loot_effect", #"epic" );
            break;
        case 3:
            self.glocke setscriptablepartstate( #"loot_effect", #"legendary" );
            break;
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x850e35bd, Offset: 0x1eb1
// Size: 0x200, Type: bool
function private function_459454825e28385e()
{
    radius = level.robot_glocke_drop.var_2e3da9d8f4a7838.halfsize[ 1 ] * 1.1;
    height = level.robot_glocke_drop.var_2e3da9d8f4a7838.halfsize[ 2 ] * 1.1;
    players = getplayersinradius( self.glocke.origin, radius, height );
    
    if ( players.size == 0 )
    {
        return false;
    }
    
    if ( isplayer( self.owner ) )
    {
        data = self.owner getcollision( "stand" );
    }
    else
    {
        data = players[ 0 ] getcollision( "stand" );
    }
    
    results = function_a8a85a37d1f84c7f( self.glocke.origin, self.glocke.angles, 96, data, undefined );
    
    foreach ( player in players )
    {
        if ( results.size > 0 )
        {
            out_loc = function_b21056d585c710d( results, player.origin );
            player setorigin( out_loc.origin );
            continue;
        }
        
        tacpoint = ai::function_20e2b5e7fcba9f36( self.glocke.origin, radius * 2, radius );
        pos = getgroundposition( tacpoint.origin, data.capsule_radius );
        player setorigin( pos );
    }
    
    return true;
}

// Namespace zm_sat_locust_glocke_drop
// Params 5, eflags: 0x4
// Checksum 0x4a165afd, Offset: 0x20ba
// Size: 0x365
function private function_a8a85a37d1f84c7f( origin, angles = ( 0, 0, 0 ), offset, data, count )
{
    results = [];
    contents = trace::create_contents( 0, 1, 1, 0, 1, 0, 1, 1, 1 );
    origin += ( 0, 0, 8 );
    radius = data.capsule_radius;
    height = data.capsule_midpoint_height * 2;
    fwd = anglestoforward( angles );
    fwd_origin = origin + fwd * offset;
    right = anglestoright( angles );
    right_origin = origin + right * offset;
    back = fwd * -1;
    back_origin = origin + back * offset;
    left = right * -1;
    left_origin = origin + left * offset;
    fwdright = vectornormalize( fwd + right );
    var_d344bb92b2765146 = origin + fwdright * offset;
    fwdleft = vectornormalize( fwd + left );
    var_2b0f18a4bccad2d5 = origin + fwdleft * offset;
    backleft = fwdright * -1;
    backleft_origin = origin + backleft * offset;
    backright = fwdleft * -1;
    backright_origin = origin + backright * offset;
    directions = [ fwd_origin, right_origin, back_origin, left_origin, var_d344bb92b2765146, var_2b0f18a4bccad2d5, backleft_origin, backright_origin ];
    
    foreach ( dir in directions )
    {
        trace = trace::capsule_trace_passed( origin, dir, radius, height, undefined, undefined, contents );
        
        if ( trace )
        {
            results[ results.size ] = { #origin:dir };
            
            /#
                zone = zone_manager::function_90e5c3e2272b0130( dir );
                assert( zone, "<dev string:x30>" + dir + "<dev string:x38>" );
                assert( zone_manager::is_zone_enabled( zone.zone_name ), "<dev string:x30>" + dir + "<dev string:x45>" );
                
                if ( getdvarint( @"hash_ad2a60830d3a8d32" ) == 1 )
                {
                    debug::sphere( dir, 16, trace ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 10 );
                    trace = trace::capsule_trace( origin, dir, radius, height, undefined, undefined, contents );
                    trace::draw_trace( trace, ( 1, 1, 1 ), 1, int( 10 / level.framedurationseconds ) );
                }
            #/
            
            if ( count && count == results.size )
            {
                return results;
            }
        }
    }
    
    return results;
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x404773a8, Offset: 0x2428
// Size: 0x1e4
function private function_37e7bf93f1a2d5c9()
{
    assert( isdefined( self.data.misc.var_df56e688222dbef5 ) );
    knockdown_zombies = [];
    annihilate_zombies = [];
    zombies = getaiarrayinradius( self.params.request_position, self.data.misc.var_df56e688222dbef5, "team_two_hundred" );
    
    foreach ( zombie in zombies )
    {
        if ( zombie.aicategory == "special" || zombie.aicategory == "elite" || zombie.aicategory == "hvt" )
        {
            knockdown_zombies[ knockdown_zombies.size ] = zombie;
            continue;
        }
        
        if ( zombie val::get( "damageshield_allow_quest_kill" ) )
        {
            zombie utility::callsharedfunc( #"ai", #"hash_c649178f35fe47cf" );
        }
        
        if ( !zombie val::get( "damage" ) || zombie val::get( "damageshield" ) )
        {
            continue;
        }
        
        if ( zombie zombie_utils::function_bf1464d09f4e4b40() )
        {
            continue;
        }
        
        annihilate_zombies[ annihilate_zombies.size ] = zombie;
    }
    
    utility::array_thread( annihilate_zombies, &annihilate_zombie, self );
    utility::array_thread( knockdown_zombies, &function_8e57118fd8418a83, self );
    
    if ( annihilate_zombies.size >= 5 && self.owner )
    {
        zm_robot_controller::play_player_banter( #"glocke_multikill", self.owner );
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0xb3da4234, Offset: 0x2614
// Size: 0x6c
function private annihilate_zombie( glocke )
{
    self.var_e797f68de73ece4e = "_glocke_drop";
    self.var_a13bed1ac47e1b2c = 1;
    self.allowdeath = 1;
    namespace_b76ff2659823e89d::annihilate();
    self kill( glocke.origin, glocke.owner, undefined, "MOD_CRUSH", level.robot_glocke_drop.objweapon );
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0xd1856625, Offset: 0x2688
// Size: 0x41
function private function_8e57118fd8418a83( glocke )
{
    shadowvortex::function_7ebadea72ea922fb( 0, glocke.owner, undefined, undefined, self.origin, "none", undefined, 0, 0, 1, 0 );
    zombie_stun::stun_ai( 2.5 );
}

// Namespace zm_sat_locust_glocke_drop
// Params 3, eflags: 0x4
// Checksum 0x3b440c48, Offset: 0x26d1
// Size: 0x196
function private function_619c72614bf54fda( duration, skip_stun, full_float )
{
    assert( isdefined( self.data.float ) );
    assert( isdefined( self.data.tier ) );
    index = self.var_85bcee10513e25ef.tier;
    tier_data = self.data.tier;
    radius = tier_data.radius[ index ];
    
    if ( !isdefined( self.var_85bcee10513e25ef.zombies ) )
    {
        self.var_85bcee10513e25ef.zombies = [];
    }
    
    if ( level.players.size == 0 )
    {
        return;
    }
    
    kill_req = tier_data.kill_req[ level.players.size - 1 ];
    
    if ( full_float )
    {
        float_amt = kill_req[ index ];
    }
    else
    {
        float_amt = maxint( 3, kill_req[ index ] - self.var_85bcee10513e25ef.kills - self.var_85bcee10513e25ef.zombies.size );
    }
    
    float_zombies = function_3e12601a05680412( duration, skip_stun, radius, float_amt );
    self.var_85bcee10513e25ef.zombies = arraycombineunique( self.var_85bcee10513e25ef.zombies, float_zombies );
}

// Namespace zm_sat_locust_glocke_drop
// Params 4, eflags: 0x4
// Checksum 0xe298f7a7, Offset: 0x286f
// Size: 0x246
function private function_3e12601a05680412( duration, skip_stun, radius, float_amt = undefined )
{
    float_zombies = [];
    stun_zombies = [];
    zombies = getaiarrayinradius( self.params.request_position, radius, "team_two_hundred" );
    zombies = function_628bac9faa9d1e86( zombies, self.glocke.origin );
    
    foreach ( zombie in zombies )
    {
        if ( zombie.aicategory != "normal" )
        {
            stun_zombies[ stun_zombies.size ] = zombie;
            continue;
        }
        
        if ( ( !zombie val::get( "damage" ) || zombie val::get( "damageshield" ) ) && !zombie val::get( "damageshield_allow_quest_kill" ) )
        {
            continue;
        }
        
        if ( zombie zombie_utils::function_bf1464d09f4e4b40() )
        {
            continue;
        }
        
        if ( zombie.is_living_world_ai && !zombie.var_9686e1897a9ce028 )
        {
            continue;
        }
        
        if ( zombie.b_in_spawn_closet )
        {
            continue;
        }
        
        if ( utility::ent_flag( "floating" ) )
        {
            continue;
        }
        
        if ( float_amt && float_zombies.size == float_amt )
        {
            continue;
        }
        
        float_zombies[ float_zombies.size ] = zombie;
    }
    
    self.glocke.parent_ent rotateyaw( 360, 1, 0.25, 0.75 );
    self.glocke setscriptablepartstate( #"gravity_effect", #"activate" );
    self.glocke utility::function_32b24db3127bff40( #"gravity_effect_loop", #"activate" );
    utility::array_thread( float_zombies, &float_zombie, self, duration, radius );
    
    if ( !skip_stun )
    {
        utility::array_thread( stun_zombies, &zombie_stun::stun_ai, 2.5 );
    }
    
    return float_zombies;
}

// Namespace zm_sat_locust_glocke_drop
// Params 3, eflags: 0xc
// Checksum 0x334cb677, Offset: 0x2abe
// Size: 0x286
function private float_zombie( glocke, duration, radius )
{
    self notify( #"hash_e70f9c03cdf8efaf" );
    self endon( #"hash_e70f9c03cdf8efaf" );
    level endon( #"game_ended" );
    self endon( #"death", #"teleporting", #"entitydeleted" );
    float = glocke.data.float;
    
    if ( !isdefined( self.var_a619aa15cf61de8a ) )
    {
        self.var_a619aa15cf61de8a = self.no_powerups;
    }
    
    self.no_powerups = 1;
    
    if ( !isdefined( self.var_a2dfc645220488d ) )
    {
        delay = mapfloat( 0, squared( radius ), level.framedurationseconds, getdvarfloat( @"hash_e9fc182ab915a746", 0.25 ), distance2dsquared( self.origin, glocke.glocke.origin ) );
        wait delay;
        var_a2dfc645220488d = spawn( "script_origin", self.origin );
        self.var_a2dfc645220488d = var_a2dfc645220488d;
        thread utility::delete_on_death( var_a2dfc645220488d );
    }
    
    if ( !self islinked() && !utility::ent_flag( "floating" ) )
    {
        self motionwarpcancel();
        self.var_a2dfc645220488d.start_origin = self.origin;
        self.var_a2dfc645220488d.start_angles = self.angles;
        self.var_a2dfc645220488d.origin = self.origin;
        self.var_a2dfc645220488d.angles = self.angles;
        self linkto( self.var_a2dfc645220488d );
    }
    
    thread float_watcher( glocke );
    result = utility::waittill_any_ents_or_timeout_return( duration, glocke, "level_up_loot_float", glocke, "level_complete_loot_float", glocke, "drop_completed", glocke, "continue_loot_float" );
    function_b2b249742cb2e180();
    self waittill( #"float_complete" );
    self.no_powerups = self.var_a619aa15cf61de8a;
    self dodamage( self.maxhealth * float.var_a4a892fd7a622e19, self.origin, glocke.owner, glocke.glocke, "MOD_PROJECTILE_SPLASH", undefined, "torso_upper", undefined, 65536 );
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0x25f23417, Offset: 0x2d4c
// Size: 0x426
function private function_7eb2649126bc9729( skip_delay = 0 )
{
    self endon( #"drop_destroyed" );
    assert( isdefined( self.data.loot ) );
    loot = self.data.loot;
    tier = self.data.tier;
    override_level = getdvarint( @"hash_3d16489799d72337", -1 );
    override_tier = getdvarint( @"hash_a6cde30bd6524f7", -1 );
    override_ultra = getdvarint( @"hash_483b033f75e61f4f", 0 );
    level_tier = ( override_level > 0 ? override_level : self.var_85bcee10513e25ef.tier ) ?? 0;
    var_ccb45992fc1dce16 = override_tier > 0 ? override_tier : zm_sat_locust_util::function_4c1f582e9f0b6f0a();
    self.glocke.level_tier = level_tier;
    spawn_count = tier.num_to_spawn[ level_tier - 1 ];
    var_d2dea1eb5c269d79 = getdvarfloat( @"hash_9a9d53af1910bdf1", 0.25 );
    
    if ( level_tier == 3 && tier.ultra_items.size > 0 && utility::percent_chance( tier.ultra_chance ) || override_ultra )
    {
        add_loot = [ utility::array_random( tier.ultra_items ) ];
        tier.ultra_items = arrayremove( tier.ultra_items, add_loot );
    }
    
    spawn_list = getxhashasset( "itemspawnlist:" + level.mapname + "_glocke_drop_lvl" + level_tier + "_tier" + var_ccb45992fc1dce16 );
    data = { #var_d2dea1eb5c269d79:var_d2dea1eb5c269d79, #spawn_count:spawn_count, #glocke_data:self, #spawn_list:spawn_list, #var_ccb45992fc1dce16:var_ccb45992fc1dce16, #level_tier:level_tier };
    level callback::callback( #"glocke_drop_loot", data );
    bundle = getscriptbundle( data.spawn_list );
    
    if ( !bundle )
    {
        if ( data.spawn_list != spawn_list )
        {
            assertmsg( "<dev string:x67>" + data.spawn_list + "<dev string:x86>" + data.level_tier + "<dev string:x9f>" + var_ccb45992fc1dce16 );
        }
        
        return;
    }
    
    if ( !skip_delay )
    {
        wait loot.start_delay;
    }
    
    spawn_options = common_item::function_c5093ef57497e721( data.glocke_data.glocke );
    spawn_options.var_8d4f327170228364 = 0;
    spawn_options.dropradiusscale = 2;
    spawn_options.var_8934e0ace9b7d996 = 0;
    spawn_options.var_8958d2ace9e03584 = 0;
    spawn_options.var_fda2f324ea7e833b = 72;
    common_item::function_577fe3f000fcb275( data.var_d2dea1eb5c269d79, data.spawn_count, data.spawn_list, spawn_options, undefined, undefined, 1 );
    
    foreach ( item in add_loot )
    {
        itembundle = getscriptbundle( item );
        spawneditems = common_item::function_61c2c0251e742ffd( itembundle, undefined, spawn_options );
        wait data.var_d2dea1eb5c269d79;
    }
    
    level callback::callback( #"hash_93b99da57e180df4", self );
    wait data.var_d2dea1eb5c269d79;
}

// Namespace zm_sat_locust_glocke_drop
// Params 0
// Checksum 0x673f99c9, Offset: 0x317a
// Size: 0x25d
function destroy_glocke_drop()
{
    self.glocke.parent_ent rotateyaw( 3080, 5, 0.75 );
    self.glocke.parent_ent moveto( self.glocke.parent_ent.origin + ( 0, 0, 256 ), 10, 0.25 );
    self.glocke setscriptablepartstate( #"gravity_effect", #"default" );
    self.glocke setscriptablepartstate( #"gravity_effect_loop", #"default" );
    self.glocke setscriptablepartstate( #"raise_effect", #"activate" );
    wait 1.25;
    
    if ( is_loot_type() )
    {
        function_7eb2649126bc9729();
    }
    
    self notify( #"drop_completed" );
    level callback::callback( #"glocke_drop_complete", { #glocke:self.glocke, #type:self.params.type, #params:self.params } );
    
    if ( isdefined( self.glocke.parent_ent ) )
    {
        self.glocke utility::scriptable_clearparententity();
        self.glocke.parent_ent delete();
    }
    
    if ( is_loot_type() )
    {
        self.glocke setscriptablepartstate( #"pod", #"hash_1dc097b410ba3afb" );
        wait 1;
    }
    else if ( self.params.type == "delivery_quest" || self.params.type == "delivery_quest_no_float" )
    {
        self.glocke setscriptablepartstate( #"pod", #"hash_1dc097b410ba3afb" );
        wait 1;
    }
    else
    {
        wait 0.25;
    }
    
    level callback::remove( "on_zombie_ai_killed", &function_5c0ea11dd8f0b55b, self );
    self.glocke freescriptable();
    level.robot_glocke_drop.is_active = 0;
    self notify( #"drop_destroyed" );
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0x670b0680, Offset: 0x33df
// Size: 0x50
function private get_glocke_drop_data( type )
{
    assert( isdefined( type ) );
    assert( isdefined( level.robot_glocke_drop.types[ type ] ) );
    return structcopy( level.robot_glocke_drop.types[ type ] );
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0xc
// Checksum 0xd8e5be2d, Offset: 0x3438
// Size: 0x44c
function private float_watcher( glocke )
{
    self notify( #"hash_d555edb3d8547bba" );
    self endon( #"hash_d555edb3d8547bba" );
    level endon( #"game_ended" );
    self endon( #"death", #"teleporting", #"entitydeleted" );
    float = glocke.data.float;
    startposition = self.var_a2dfc645220488d.start_origin;
    
    if ( !utility::ent_flag( "floating" ) )
    {
        status_effects::function_4306f85454d862ba();
        self motionwarpcancel();
        self animmode( "nogravity" );
        self.nogravityragdoll = 1;
        self.forceragdollimmediate = 1;
        utility::ent_flag_set( "floating" );
        val::set( #"force_float", "allow_brot", 0 );
        val::set( #"force_float", "postpone_stun", 1 );
        val::set( #"force_float", "postpone_vortex_pull", 1 );
        val::set( #"force_float", "pain", 0 );
        val::set( #"force_float", "special_pain", 0 );
        val::set( #"force_float", "ignoreall", 1 );
        waitframe();
        callback::add( "pre_killed_body_cloned", &function_673c823d37ed9b22 );
        
        if ( self.subclass == "zombie_shade" )
        {
            grabbed_loop_anim = utility::cointoss() ? "disciple_injection_grabbed_loop" : "disciple_injection_grabbed_loop_alt";
            
            if ( utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", grabbed_loop_anim ) )
            {
                thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( grabbed_loop_anim, grabbed_loop_anim, self.origin, self.angles, undefined, 1 );
            }
        }
        else
        {
            var_4dd9c210b998e030 = "floatinplace_base_1";
            var_f32b2e445d0d23b6 = randomint( 2 );
            
            switch ( var_f32b2e445d0d23b6 )
            {
                case 0:
                    var_4dd9c210b998e030 = "floatinplace_base_1";
                    break;
                case 1:
                    var_4dd9c210b998e030 = "floatinplace_base_2";
                    break;
            }
            
            utility::function_32b24db3127bff40( "robot_glocke_drop_floating", "floating_on" );
            self function_695b8e1b655c2796( "floatinplacetype", var_4dd9c210b998e030 );
            
            if ( self asmhasstate( self.asmname, "float_in_place_in" ) )
            {
                asm::function_7256f5ba459c840b( "float_in_place_in" );
            }
        }
        
        if ( !isdefined( startposition ) )
        {
            startposition = self.origin;
        }
        
        floatheight = float.height + randomintrange( -1 * float.var_90feaa9184659cec, float.var_90feaa9184659cec );
        endposition = startposition + ( 0, 0, floatheight );
        
        if ( ispointindoors( self.origin ) )
        {
            animoffset = ( 0, 0, level.robot_glocke_drop.var_36db936b5320c625 );
            trace = trace::ray_trace( self.origin, endposition + animoffset, self );
            
            if ( trace[ "hittype" ] != "hittype_none" )
            {
                endposition = trace[ "position" ] - animoffset;
            }
        }
        
        self.var_a2dfc645220488d moveto( endposition, float.enemy_raise_time, float.enemy_raise_time * 0.3, float.enemy_raise_time * 0.1 );
        wait float.enemy_raise_time;
    }
    
    self waittill( #"floating" );
    
    if ( self.subclass != "zombie_shade" )
    {
        asm::asm_fireevent( self.asmname, "float_in_place_end" );
    }
    
    if ( self.subclass != "zombie_parasite" )
    {
        self.var_a2dfc645220488d moveto( startposition, float.var_9fbabc9764ecf42c, float.var_9fbabc9764ecf42c * 0.2 );
    }
    
    self.var_a2dfc645220488d waittill( #"movedone" );
    
    if ( self.subclass == "zombie_shade" )
    {
        utility::animscripted_clear();
    }
    
    self unlink();
    self.var_a2dfc645220488d delete();
    utility::function_32b24db3127bff40( "robot_glocke_drop_floating", "floating_off" );
    self notify( #"float_complete" );
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x5cd491d, Offset: 0x388c
// Size: 0x5f
function private function_b2b249742cb2e180()
{
    self animmode( "normal" );
    self motionwarpcancel();
    self orientmode( "face enemy or motion" );
    utility::ent_flag_clear( "floating" );
    callback::remove( "pre_killed_body_cloned", &function_673c823d37ed9b22 );
    val::reset_all( #"force_float" );
    self.nogravityragdoll = 0;
    self.forceragdollimmediate = 0;
}

// Namespace zm_sat_locust_glocke_drop
// Params 2, eflags: 0x4
// Checksum 0xbf3dc3b8, Offset: 0x38f3
// Size: 0x125
function private function_5c0ea11dd8f0b55b( params, glocke_params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( !utility::ent_flag( "floating" ) || !arraycontains( glocke_params.var_85bcee10513e25ef.zombies, self ) )
    {
        return;
    }
    
    glocke_params.var_85bcee10513e25ef.zombies = arrayremove( glocke_params.var_85bcee10513e25ef.zombies, self );
    glocke_params.var_85bcee10513e25ef.kills++;
    
    if ( level.players.size == 0 )
    {
        return;
    }
    
    kill_req = glocke_params.data.tier.kill_req[ level.players.size - 1 ][ glocke_params.var_85bcee10513e25ef.tier ];
    
    if ( glocke_params.var_85bcee10513e25ef.kills == kill_req )
    {
        glocke_params notify( #"continue_loot_float" );
    }
}

// Namespace zm_sat_locust_glocke_drop
// Params 1, eflags: 0x4
// Checksum 0x8b5fc005, Offset: 0x3a20
// Size: 0x24
function private function_673c823d37ed9b22( params )
{
    utility::ent_flag_set( "dissolve_purple" );
    utility::ent_flag_set( "dark_aether_bubble" );
}

// Namespace zm_sat_locust_glocke_drop
// Params 0
// Checksum 0x2c23300d, Offset: 0x3a4c
// Size: 0x17, Type: bool
function is_not_active()
{
    return level.robot_glocke_drop.is_active == 0;
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0x7493ee80, Offset: 0x3a6c
// Size: 0x80
function private function_3f54c9361ceca67c()
{
    level endon( #"game_ended" );
    utility::flag_wait( "ww_step_08" );
    level.robot_glocke_drop.types[ "delivery_loot" ].tier.ultra_items[ level.robot_glocke_drop.types[ "delivery_loot" ].tier.ultra_items.size ] = %"hash_4e5e12b8328b46fd";
}

// Namespace zm_sat_locust_glocke_drop
// Params 0, eflags: 0x4
// Checksum 0xb3b9f04f, Offset: 0x3af4
// Size: 0x38, Type: bool
function private is_loot_type()
{
    return self.params.type == "delivery_loot" || self.params.type == "delivery_loot_no_minigame";
}

/#

    // Namespace zm_sat_locust_glocke_drop
    // Params 0, eflags: 0x4
    // Checksum 0x46fe054a, Offset: 0x3b35
    // Size: 0x220, Type: dev
    function private function_cde8c5bd8c39fdd2()
    {
        self endon( #"drop_destroyed" );
        self endon( #"hash_195b898b4bdb4218" );
        
        if ( !isdefined( self.var_85bcee10513e25ef.var_1461a132e7ccc81 ) )
        {
            self.var_85bcee10513e25ef.var_1461a132e7ccc81 = gettime();
        }
        
        for ( ;; )
        {
            if ( getdvarint( @"hash_aa075f133dbe1afe" ) == 1 )
            {
                msec_duration = self.data.tier.duration[ self.var_85bcee10513e25ef.tier ] * 1000;
                print3d( self.glocke.origin + ( 0, 0, 16 ), "<dev string:xa9>" + self.var_85bcee10513e25ef.tier + "<dev string:xb1>" + self.var_85bcee10513e25ef.kills + "<dev string:xba>" + self.data.tier.kill_req[ level.players.size - 1 ][ self.var_85bcee10513e25ef.tier ], ( 1, 1, 1 ), 1, 0.5, 1, 1 );
                print3d( self.glocke.origin + ( 0, 0, 8 ), "<dev string:xbc>" + self.var_85bcee10513e25ef.zombies.size, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
                print3d( self.glocke.origin + ( 0, 0, 0 ), "<dev string:xc7>" + ( msec_duration - gettime() - self.var_85bcee10513e25ef.var_1461a132e7ccc81 ) * 0.001, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_sat_locust_glocke_drop
    // Params 0, eflags: 0x4
    // Checksum 0xc17d7113, Offset: 0x3d5d
    // Size: 0xdb, Type: dev
    function private function_c4d14a0f3518d92a()
    {
        devgui::function_9082edeb5db93280( "<dev string:xd8>" );
        devgui::add_devgui_func( "<dev string:x10a>", "<dev string:x120>", &function_b69268bccbac954c );
        devgui::add_devgui_func( "<dev string:x13d>", "<dev string:x14c>", &function_315b49924dfd49f8 );
        devgui::add_devgui_func( "<dev string:x167>", "<dev string:x174>", &function_be5f09634daef3b0 );
        
        for ( i = 1; i <= 3 ; i++ )
        {
            for ( j = 1; j <= 4 ; j++ )
            {
                devgui::function_cd4e263c1f3018ae( "<dev string:x188>" + i + "<dev string:x199>" + j, "<dev string:x1a0>" + i + "<dev string:x1ae>" + j, &devgui_spawn_loot );
            }
        }
        
        devgui::function_eaac4ba4b3caf621( "<dev string:x1b0>", @"hash_aa075f133dbe1afe" );
        devgui::function_77df7fe7dd273e10();
        level thread dvar_update_loop();
    }

    // Namespace zm_sat_locust_glocke_drop
    // Params 0, eflags: 0x4
    // Checksum 0x1305effa, Offset: 0x3e40
    // Size: 0x28a, Type: dev
    function private dvar_update_loop()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            level.robot_glocke_drop.types[ "<dev string:x1c7>" ].tier.num_to_spawn = [ getdvarint( @"hash_2c6081d638e30bcc", 4 ), getdvarint( @"hash_2c6084d638e31265", 6 ), getdvarint( @"hash_2c6083d638e31032", 8 ) ];
            level.robot_glocke_drop.types[ "<dev string:x1c7>" ].tier.radius = [ getdvarint( @"hash_b94740f101ed30e5", 512 ), getdvarint( @"hash_b9473df101ed2a4c", 512 ), getdvarint( @"hash_b9473ef101ed2c7f", 512 ) ];
            level.robot_glocke_drop.types[ "<dev string:x1c7>" ].tier.duration = [ getdvarfloat( @"hash_f020b056259827f7", 15 ), getdvarfloat( @"hash_f020b15625982a2a", 18 ), getdvarfloat( @"hash_f020b25625982c5d", 20 ) ];
            level.robot_glocke_drop.types[ "<dev string:x1c7>" ].tier.kill_req = [ [ getdvarint( @"hash_7b6737843df4ef28", 5 ), getdvarint( @"hash_7b673a843df4f5c1", 8 ), getdvarint( @"hash_7b6739843df4f38e", 10 ) ], [ getdvarint( @"hash_b7e5c8a97ec429f2", 8 ), getdvarint( @"hash_b7e5c7a97ec427bf", 10 ), getdvarint( @"hash_b7e5c6a97ec4258c", 12 ) ], [ getdvarint( @"hash_e5bf856fae5a1820", 9 ), getdvarint( @"hash_e5bf886fae5a1eb9", 12 ), getdvarint( @"hash_e5bf876fae5a1c86", 15 ) ], [ getdvarint( @"hash_725e4334cf427c41", 10 ), getdvarint( @"hash_725e4034cf4275a8", 14 ), getdvarint( @"hash_725e4134cf4277db", 18 ) ] ];
            wait 0.5;
        }
    }

    // Namespace zm_sat_locust_glocke_drop
    // Params 0, eflags: 0x4
    // Checksum 0xa88be57e, Offset: 0x40d2
    // Size: 0x34, Type: dev
    function private function_b69268bccbac954c()
    {
        player = level.player;
        player request_glocke_drop( player.origin, undefined, "<dev string:x1c7>" );
    }

    // Namespace zm_sat_locust_glocke_drop
    // Params 0, eflags: 0x4
    // Checksum 0x5983f142, Offset: 0x410e
    // Size: 0x34, Type: dev
    function private function_315b49924dfd49f8()
    {
        player = level.player;
        player request_glocke_drop( player.origin, undefined, "<dev string:x1d5>" );
    }

    // Namespace zm_sat_locust_glocke_drop
    // Params 1, eflags: 0x4
    // Checksum 0xf030c7ef, Offset: 0x414a
    // Size: 0x2f0, Type: dev
    function private devgui_spawn_loot( params )
    {
        level_tier = int( params[ 0 ] );
        var_ccb45992fc1dce16 = int( params[ 1 ] );
        spawn_list = getxhashasset( "<dev string:x1dc>" + level.mapname + "<dev string:x1eb>" + level_tier + "<dev string:x1fc>" + var_ccb45992fc1dce16 );
        
        if ( !getscriptbundle( spawn_list ) )
        {
            assertmsg( "<dev string:x202>" + spawn_list );
            return;
        }
        
        pos = player_utility::getplayerlookatpos( level.player, level.player );
        glocke = spawnscriptable( %"sat_zm_prop_obadiah", pos, ( 0, 0, 0 ) );
        glocke setscriptablepartstate( #"pod", #"landed" );
        glocke.parent_ent = utility::spawn_model( "<dev string:x236>", glocke.origin, glocke.angles );
        glocke utility::scriptable_setparententity( glocke.parent_ent );
        state = [ #"rare", #"epic", #"legendary" ];
        glocke setscriptablepartstate( #"loot_effect", state[ level_tier - 1 ] );
        glocke setscriptablepartstate( #"effects", #"aether_energy" );
        glocke.parent_ent rotateyaw( 3080, 5, 0.75 );
        glocke.parent_ent moveto( glocke.parent_ent.origin + ( 0, 0, 256 ), 10, 0.25 );
        glocke setscriptablepartstate( #"raise_effect", #"activate" );
        wait 1.25;
        tier_data = level.robot_glocke_drop.types[ "<dev string:x1c7>" ].tier;
        spawn_count = tier_data.num_to_spawn[ level_tier - 1 ];
        var_d2dea1eb5c269d79 = getdvarfloat( @"hash_9a9d53af1910bdf1", 0.25 );
        spawn_options = common_item::function_c5093ef57497e721( glocke );
        spawn_options.var_8d4f327170228364 = 0;
        spawn_options.dropradiusscale = 2;
        spawn_options.var_8934e0ace9b7d996 = 0;
        spawn_options.var_8958d2ace9e03584 = 0;
        spawn_options.var_fda2f324ea7e833b = 72;
        common_item::function_577fe3f000fcb275( var_d2dea1eb5c269d79, spawn_count, spawn_list, spawn_options, undefined, undefined, 1 );
        glocke setscriptablepartstate( #"pod", #"hash_1dc097b410ba3afb" );
        wait 1;
        glocke freescriptable();
    }

    // Namespace zm_sat_locust_glocke_drop
    // Params 1, eflags: 0x4
    // Checksum 0x77a6454, Offset: 0x4442
    // Size: 0x17, Type: dev
    function private function_be5f09634daef3b0( params )
    {
        level thread function_324dc9b5c9930e4d();
    }

    // Namespace zm_sat_locust_glocke_drop
    // Params 0, eflags: 0x4
    // Checksum 0xdcee6d61, Offset: 0x4461
    // Size: 0x9e, Type: dev
    function private function_324dc9b5c9930e4d()
    {
        zombie = level.player function_514745ba27dcac82();
        
        if ( !zombie || !isscriptedai( zombie ) )
        {
            return;
        }
        
        if ( zombie.aicategory != "<dev string:x241>" )
        {
            return;
        }
        
        drop = level.player function_732644686f90e858( ( 0, 0, 0 ), ( 0, 0, 0 ), "<dev string:x1c7>" );
        zombie thread float_zombie( drop, 10, 64 );
        wait 10;
        drop.glocke freescriptable();
    }

#/
