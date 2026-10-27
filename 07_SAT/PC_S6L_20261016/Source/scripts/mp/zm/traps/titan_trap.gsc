// scripts\mp\zm\traps\titan_trap.gsc  (hash_66ee58071596ec0b.gscc) (size: 30756 Bytes / 0x7824 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf7db32d (3749557037)
// size ...... 30756 (0x7824)
// includes .. 15  (offset: 0x6f80)
// strings ... 89  (offset: 0x6ff8)
// dev strs .. 45  (offset: 0x75cc)
// exports ... 63  (offset: 0x4ddc)
// cseg ...... 0x5d6 + 0x4806 (0x4ddc)
// imports ... 183 (offset: 0x57b4)
// animtree1 . 0   (offset: 0x7824)
// animtree2 . 0   (offset: 0x7824)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_dismemberment;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_script_traps_cs;
#using scripts\mp\zm\traps\trap_core;

#namespace titan_trap;

// Namespace titan_trap
// Params 0, eflags: 0x5
// Checksum 0x13c4edee, Offset: 0x5f4
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"titan_traps", #"zm_trap", &pre_main, &post_main );
}

// Namespace titan_trap
// Params 0
// Checksum 0x57d9cb47, Offset: 0x621
// Size: 0x9
function pre_main()
{
    zm_sat_scarab_script_traps_cs::main();
}

// Namespace titan_trap
// Params 0
// Checksum 0x296162b9, Offset: 0x632
// Size: 0x1b
function post_main()
{
    utility::add_fx( "titan_fist_smash_impact", "vfx_sat_scarab_fist_impact_dust" );
    level thread function_4de884834caa7a4c();
}

// Namespace titan_trap
// Params 0, eflags: 0x4
// Checksum 0x49867e72, Offset: 0x655
// Size: 0x47e
function private function_4de884834caa7a4c()
{
    level utility::flag_wait( "scriptables_ready" );
    trap_core::function_63a557f0f22161af( "stone_titan_trap", &activate_stone_titan_trap, &deactivate_stone_titan_trap );
    level utility::flag_wait( "stone_titan_trap_trap_init_finished" );
    
    /#
        init_debug();
    #/
    
    visibility_mode::function_ceeb7b4ab2524022( "c_sat_zmb_scarab_trap" );
    visibility_mode::function_ceeb7b4ab2524022( "c_sat_zmb_scarab_trap_2" );
    level.var_59b1ed9225af06d = [];
    var_7176d49c383f24ed = utility::getstructarray( "stone_titan_trap" );
    
    foreach ( var_6469c1e4d3ac4060 in var_7176d49c383f24ed )
    {
        str_id = var_6469c1e4d3ac4060.script_label ?? "";
        var_6469c1e4d3ac4060.scene_node = utility::getstruct( "titan_trap_scene" + str_id );
        var_6469c1e4d3ac4060.scene_node thread scene::init( undefined, "shot_010" );
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 = var_6469c1e4d3ac4060.scene_node scene::get_entity( "Prop 1" );
        var_6469c1e4d3ac4060 thread function_5844c66f8e9687f6();
        var_6469c1e4d3ac4060.scene_node thread init_titan_clips();
        var_6469c1e4d3ac4060.damage_throttle = throttle::throttle_initialize( "titan_trap_damage_throttle" + str_id, 2 );
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "head_vfx", "ready" );
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "ambient_breathing_audio", "active" );
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72.var_6469c1e4d3ac4060 = var_6469c1e4d3ac4060;
        
        if ( var_6469c1e4d3ac4060.trap_positions[ 0 ] )
        {
            var_27d1e1a53111a46e = utility::getstructarray( var_6469c1e4d3ac4060.trap_positions[ 0 ].target );
            var_d928d2f7d2ab477b = getentarray( var_6469c1e4d3ac4060.trap_positions[ 0 ].target, #targetname );
            
            foreach ( impact_point in var_27d1e1a53111a46e )
            {
                if ( isstruct( impact_point ) )
                {
                    if ( !isdefined( var_6469c1e4d3ac4060.trap_positions[ 0 ].var_27d1e1a53111a46e ) )
                    {
                        var_6469c1e4d3ac4060.trap_positions[ 0 ].var_27d1e1a53111a46e = [];
                    }
                    
                    var_6469c1e4d3ac4060.trap_positions[ 0 ].var_27d1e1a53111a46e[ impact_point.script_noteworthy ] = impact_point;
                    
                    if ( !isdefined( var_6469c1e4d3ac4060.var_a59ed3bfa687be42 ) )
                    {
                        var_6469c1e4d3ac4060.var_a59ed3bfa687be42 = [];
                    }
                    
                    var_6469c1e4d3ac4060.var_a59ed3bfa687be42[ var_6469c1e4d3ac4060.var_a59ed3bfa687be42.size ] = impact_point;
                }
            }
            
            foreach ( trigger in var_d928d2f7d2ab477b )
            {
                if ( !isdefined( var_6469c1e4d3ac4060.var_d928d2f7d2ab477b ) )
                {
                    var_6469c1e4d3ac4060.var_d928d2f7d2ab477b = [];
                }
                
                var_6469c1e4d3ac4060.var_d928d2f7d2ab477b[ trigger.script_noteworthy ] = trigger;
            }
        }
        
        function_8c3a1ab09853a618( var_6469c1e4d3ac4060 );
        t_hazard = getent( "titan_hazard" + var_6469c1e4d3ac4060.script_label, #targetname );
        
        if ( t_hazard )
        {
            var_6469c1e4d3ac4060.t_hazard = t_hazard;
            t_hazard thread titan_hazard_monitor( var_6469c1e4d3ac4060 );
        }
        
        t_radius_vol = getnoentvolumearray( "check_zombie_in_radius" + str_id, #script_noteworthy )[ 0 ];
        
        if ( isdefined( t_radius_vol ) )
        {
            var_6469c1e4d3ac4060.t_radius_vol = t_radius_vol;
        }
        
        level thread function_d8feaae9d69b6016( var_6469c1e4d3ac4060 );
    }
    
    level.var_c9baedcff921facc = var_7176d49c383f24ed;
    level callback::add( "on_trap_ready", &function_ee3ca67e30cde32c );
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x6128e839, Offset: 0xadb
// Size: 0x7b
function private function_8c3a1ab09853a618( var_6469c1e4d3ac4060 )
{
    var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2 = [];
    var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2[ "left" ] = [];
    var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2[ "right" ] = [];
    var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0 = [];
    var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0[ "left" ] = [];
    var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0[ "right" ] = [];
    function_ab0cf9357a45bf07( var_6469c1e4d3ac4060 );
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x2d25e78d, Offset: 0xb5e
// Size: 0xdc
function private function_ab0cf9357a45bf07( var_6469c1e4d3ac4060 )
{
    var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2[ "left" ] = [];
    var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2[ "right" ] = [];
    var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0[ "left" ] = [];
    var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0[ "right" ] = [];
    function_d90793039bfb4d92( var_6469c1e4d3ac4060, "left", var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2[ "left" ], 250 );
    function_d90793039bfb4d92( var_6469c1e4d3ac4060, "right", var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2[ "right" ], 250 );
    function_d90793039bfb4d92( var_6469c1e4d3ac4060, "left", var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0[ "left" ], 200 );
    function_d90793039bfb4d92( var_6469c1e4d3ac4060, "right", var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0[ "right" ], 200 );
}

// Namespace titan_trap
// Params 0, eflags: 0x4
// Checksum 0xce05a3fa, Offset: 0xc42
// Size: 0x28
function private function_9b5a24b16f199179()
{
    level endon( #"game_ended" );
    
    while ( utility::ent_flag( "stone_titan_active" ) )
    {
        function_ab0cf9357a45bf07( self );
        waitframe();
    }
}

// Namespace titan_trap
// Params 0
// Checksum 0x113261d, Offset: 0xc72
// Size: 0x73
function init_titan_clips()
{
    var_8b17ee2294ae2a72 = scene::get_entity( "Prop 1" );
    
    if ( !isdefined( var_8b17ee2294ae2a72 ) )
    {
        return;
    }
    
    if ( !var_8b17ee2294ae2a72.b_set_clips )
    {
        var_8b17ee2294ae2a72.b_set_clips = 1;
    }
    
    titan_index = var_8b17ee2294ae2a72.model == "c_sat_zmb_scarab_trap" ? "a" : "b";
    var_8b17ee2294ae2a72 function_62f89113e6316c26( titan_index );
}

// Namespace titan_trap
// Params 1
// Checksum 0xc6eacf8, Offset: 0xced
// Size: 0x10b
function function_62f89113e6316c26( titan_index )
{
    var_a16811a742ca0143 = [ "j_head", "j_SpineUpper", "j_elbow_le", "j_elbow_ri", "j_shoulder_le", "j_shoulder_ri" ];
    clips = getentarray( "titan_clip_" + titan_index, #targetname );
    self.clips = clips;
    
    foreach ( clip in clips )
    {
        level.var_59b1ed9225af06d[ level.var_59b1ed9225af06d.size ] = clip;
        function_5f3cc3c607b1d8df( clip, clip.script_noteworthy );
    }
}

// Namespace titan_trap
// Params 2
// Checksum 0xd9ac53af, Offset: 0xe00
// Size: 0x100
function function_5f3cc3c607b1d8df( clip, part_name )
{
    tag_origin = self gettagorigin( part_name );
    tag_angles = self gettagangles( part_name );
    local_origin = coordtransformtranspose( clip.origin, tag_origin, tag_angles );
    local_angles = combineanglesinverted( tag_angles, clip.angles );
    clip utility::ent_flag_set( "no_grapple" );
    clip function_dc61b81ec6b63cc4( 1 );
    
    if ( part_name == "j_elbow_le" || part_name == "j_elbow_ri" || part_name == "j_shoulder_le" || part_name == "j_shoulder_ri" )
    {
        clip.var_5c23259cfc0c81c6 = part_name;
        clip.moverdoesnotkill = 1;
        clip.unresolved_collision_notify_min = 1;
        clip.unresolved_collision_func = &titan_clip_unresolved_collision;
    }
    
    clip linkto( self, part_name, local_origin, local_angles );
    
    /#
    #/
}

// Namespace titan_trap
// Params 2
// Checksum 0xd44c0a00, Offset: 0xf08
// Size: 0x1a9
function titan_clip_unresolved_collision( hitent, penetration )
{
    hitent endon( #"death_or_disconnect" );
    
    if ( !isplayer( hitent ) || !isalive( hitent ) )
    {
        return;
    }
    
    var_46b767ace215f1f9 = undefined;
    var_ae53b95e9027ad7c = utility::flatten_vector( penetration );
    
    if ( lengthsquared( var_ae53b95e9027ad7c ) > 0.001 )
    {
        var_46b767ace215f1f9 = vectornormalize( var_ae53b95e9027ad7c );
    }
    
    if ( !isdefined( var_46b767ace215f1f9 ) )
    {
        v_right = utility::flatten_vector( anglestoright( self.angles ) );
        v_right = vectornormalize( v_right );
        
        if ( !isdefined( v_right ) )
        {
            return;
        }
        
        var_c2914619b3afef50 = utility::flatten_vector( hitent.origin - self.origin );
        side = vectordot( var_c2914619b3afef50, v_right );
        var_46b767ace215f1f9 = side < 0 ? v_right * -1 : v_right;
    }
    
    if ( !isdefined( var_46b767ace215f1f9 ) )
    {
        return;
    }
    
    loc = getclosestpointonnavmesh( hitent.origin + var_46b767ace215f1f9 * 20 + ( 0, 0, 8 ) );
    hitent setorigin( loc );
    var_8b17ee2294ae2a72 = self getlinkedparent();
    var_6469c1e4d3ac4060 = var_8b17ee2294ae2a72.var_6469c1e4d3ac4060;
    left_or_right = function_6c9827f027982b63( self.var_5c23259cfc0c81c6 );
    loc = function_e3f9b112e68231cd( hitent.origin, var_8b17ee2294ae2a72.var_6469c1e4d3ac4060.var_bd2b6fba4aaeab0[ left_or_right ] );
    
    if ( !isdefined( loc ) )
    {
        return;
    }
    
    hitent setorigin( loc );
    hitent thread function_180f8c87b8d0821b();
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x594b0f97, Offset: 0x10b9
// Size: 0x5e
function private function_6c9827f027982b63( part_name )
{
    if ( part_name == "j_elbow_le" || part_name == "j_shoulder_le" || part_name == "left" )
    {
        return "left";
    }
    
    if ( part_name == "j_elbow_ri" || part_name == "j_shoulder_ri" || part_name == "right" )
    {
        return "right";
    }
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0x4c3dccf3, Offset: 0x1120
// Size: 0xcf
function private function_e3f9b112e68231cd( player_origin, point_array )
{
    if ( !isdefined( point_array ) || point_array.size <= 0 )
    {
        return;
    }
    
    var_3562ca516ee40579 = point_array[ 0 ];
    best_dist_sqr = distancesquared( player_origin, var_3562ca516ee40579 );
    
    foreach ( point in point_array )
    {
        dist_sqr = distancesquared( player_origin, point );
        
        if ( dist_sqr < best_dist_sqr )
        {
            var_3562ca516ee40579 = point;
            best_dist_sqr = dist_sqr;
        }
    }
    
    return var_3562ca516ee40579;
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0x42acf199, Offset: 0x11f8
// Size: 0x85
function private function_de649edec2562a9e( var_6469c1e4d3ac4060, left_or_right )
{
    if ( !isdefined( var_6469c1e4d3ac4060 ) || !isdefined( left_or_right ) || !isdefined( var_6469c1e4d3ac4060.trap_positions ) || !isdefined( var_6469c1e4d3ac4060.trap_positions[ 0 ] ) )
    {
        return;
    }
    
    impact_point = var_6469c1e4d3ac4060.trap_positions[ 0 ].var_27d1e1a53111a46e[ left_or_right ];
    
    if ( !isstruct( impact_point ) )
    {
        return;
    }
    
    return impact_point.origin;
}

// Namespace titan_trap
// Params 4, eflags: 0x4
// Checksum 0x6f1ccbb7, Offset: 0x1286
// Size: 0x296
function private function_d90793039bfb4d92( var_6469c1e4d3ac4060, left_or_right, point_array, push_scale )
{
    var_1b09367d2088bed7 = function_de649edec2562a9e( var_6469c1e4d3ac4060, left_or_right );
    
    if ( !isdefined( var_1b09367d2088bed7 ) || !isdefined( var_6469c1e4d3ac4060 ) || !isdefined( var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 ) )
    {
        return;
    }
    
    if ( left_or_right == "left" )
    {
        shoulder_tag = "j_elbow_le";
    }
    else if ( left_or_right == "right" )
    {
        shoulder_tag = "j_elbow_ri";
    }
    else
    {
        return;
    }
    
    shoulder_origin = var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 gettagorigin( shoulder_tag );
    var_dbc41ebf2610eb76 = utility::flatten_vector( shoulder_origin - var_1b09367d2088bed7 );
    var_dbc41ebf2610eb76 = vectornormalize( var_dbc41ebf2610eb76 );
    
    if ( !isdefined( var_dbc41ebf2610eb76 ) )
    {
        return;
    }
    
    v_forward = utility::flatten_vector( var_1b09367d2088bed7 - shoulder_origin );
    v_forward = vectornormalize( v_forward );
    
    if ( v_forward == ( 0, 0, 0 ) )
    {
        return;
    }
    
    var_399b4f313aa40e72 = utility::flatten_vector( anglestoright( vectortoangles( v_forward ) ) );
    var_399b4f313aa40e72 = vectornormalize( var_399b4f313aa40e72 );
    
    if ( var_399b4f313aa40e72 == ( 0, 0, 0 ) )
    {
        return;
    }
    
    a_distances = [ 70, 140, 210, 280 ];
    a_side_scale = [ -1, 1 ];
    
    foreach ( distance in a_distances )
    {
        back_point = var_1b09367d2088bed7 + var_dbc41ebf2610eb76 * distance;
        
        foreach ( side_scale in a_side_scale )
        {
            target = back_point + var_399b4f313aa40e72 * push_scale * side_scale + ( 0, 0, 8 );
            var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( target );
            
            if ( isdefined( var_4d7d4fdebb3384d2 ) && ispointonnavmesh( var_4d7d4fdebb3384d2 ) )
            {
                point_array[ point_array.size ] = var_4d7d4fdebb3384d2;
            }
        }
    }
}

// Namespace titan_trap
// Params 0, eflags: 0xc
// Checksum 0x1f92a2de, Offset: 0x1524
// Size: 0x258
function private function_acdb44aa1bc5d992()
{
    self notify( #"hash_34b2d3083b277cbb" );
    self endon( #"hash_34b2d3083b277cbb" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        /#
            foreach ( part_name in [ "<dev string:x24>", "<dev string:x29>" ] )
            {
                var_1b09367d2088bed7 = function_de649edec2562a9e( self, part_name );
                
                if ( part_name == "<dev string:x24>" )
                {
                    shoulder_origin = self.var_8b17ee2294ae2a72 gettagorigin( "<dev string:x2f>" );
                    line_color = ( 0, 0, 1 );
                }
                else
                {
                    shoulder_origin = self.var_8b17ee2294ae2a72 gettagorigin( "<dev string:x3a>" );
                    line_color = ( 1, 1, 0 );
                }
                
                if ( isdefined( var_1b09367d2088bed7 ) && isdefined( shoulder_origin ) )
                {
                    line( var_1b09367d2088bed7, shoulder_origin, line_color, 1, 0, 1 );
                }
                
                foreach ( origin in self.var_2f09d8aa2025c4a2[ part_name ] )
                {
                    color = ( 0, 0, 1 );
                    sphere( origin, 20, color, 0, 0 );
                }
                
                foreach ( origin in self.var_bd2b6fba4aaeab0[ part_name ] )
                {
                    color = ( 1, 0, 0 );
                    sphere( origin, 20, color, 0, 0 );
                }
            }
        #/
        
        waitframe();
    }
}

// Namespace titan_trap
// Params 0
// Checksum 0xec714481, Offset: 0x1784
// Size: 0x1f0
function function_180f8c87b8d0821b()
{
    self endon( #"death_or_disconnect" );
    
    if ( self.var_62a124d283a0929c )
    {
        return;
    }
    
    self.var_62a124d283a0929c = 1;
    var_467c345fcf636212 = 0;
    
    while ( level.trap_active && var_467c345fcf636212 < 2 )
    {
        var_467c345fcf636212++;
        
        if ( !isdefined( self ) || !isalive( self ) )
        {
            return;
        }
        
        wait 1;
        
        foreach ( var_5a285b6cfaff7b87 in level.var_59b1ed9225af06d )
        {
            if ( self istouching( var_5a285b6cfaff7b87 ) )
            {
                var_7176d49c383f24ed = utility::getstructarray( "stone_titan_trap" );
                a_switch_pos = [];
                
                foreach ( var_6469c1e4d3ac4060 in var_7176d49c383f24ed )
                {
                    a_switch_pos = arraycombineunique( a_switch_pos, var_6469c1e4d3ac4060.a_switch_pos );
                }
                
                closest_switch = sortbydistance( a_switch_pos, self.origin )[ 0 ];
                
                if ( isdefined( closest_switch ) )
                {
                    utility::fadetoblackforplayer( self, 1, 0.5 );
                    teleport_pos = getclosestpointonnavmesh( closest_switch.origin + anglestoforward( closest_switch.angles ) * 50 );
                    self setorigin( teleport_pos );
                    utility::fadetoblackforplayer( self, 0, 0.5 );
                }
            }
        }
    }
    
    self.var_62a124d283a0929c = undefined;
}

/#

    // Namespace titan_trap
    // Params 1
    // Checksum 0x3ded5963, Offset: 0x197c
    // Size: 0xa2, Type: dev
    function draw_sphere( tag )
    {
        if ( !isdefined( tag ) )
        {
            tag = undefined;
        }
        
        self notify( #"hash_72e1309c240281b5" );
        self endon( #"hash_72e1309c240281b5" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( isdefined( tag ) )
            {
                origin = self gettagorigin( tag );
                color = ( 1, 0, 0 );
            }
            else
            {
                origin = self.origin;
                color = ( 0, 1, 0 );
            }
            
            /#
                sphere( origin, 30, color, 0, 1 );
            #/
            
            waitframe();
        }
    }

#/

// Namespace titan_trap
// Params 0
// Checksum 0x3fdd8464, Offset: 0x1a26
// Size: 0x90
function create_clips()
{
    var_a16811a742ca0143 = [ "head", "clavicle_le", "clavicle_ri", "elbow_le", "elbow_ri", "hip_le", "hip_ri", "mainroot", "shoulder_le", "shoulder_ri", "spine4", "wrist_le", "wrist_ri" ];
    utility::ent_flag_set( "no_grapple" );
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x4440488b, Offset: 0x1abe
// Size: 0x4e
function private function_ee3ca67e30cde32c( params )
{
    if ( params.trap.var_8b17ee2294ae2a72 )
    {
        params.trap.var_8b17ee2294ae2a72 thread utility::playsoundontag( #"hash_bede03aa95a0070d", "j_neck" );
    }
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x99fa308d, Offset: 0x1b14
// Size: 0xf2
function private function_119136a31fa79d5d( str_id )
{
    rune_right = getent( "titan_linkto_right" + str_id, #script_noteworthy );
    rune_left = getent( "titan_linkto_left" + str_id, #script_noteworthy );
    rune_right.origin = self gettagorigin( "tag_rune_fx_ri" );
    rune_right.angles = self gettagangles( "tag_rune_fx_ri" );
    rune_left.origin = self gettagorigin( "tag_rune_fx_le" );
    rune_left.angles = self gettagangles( "tag_rune_fx_le" );
    rune_right linkto( self, "tag_rune_fx_ri", ( 0, 0, 0 ), ( 180, 180, 0 ) );
    rune_left linkto( self, "tag_rune_fx_le", ( 0, 0, 0 ), ( 0, 180, -90 ) );
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x11a1b57f, Offset: 0x1c0e
// Size: 0x6d, Type: bool
function private is_titan_cursed( str_id )
{
    if ( str_id == "_a" && ( !level utility::flag( "sst_brch_check1" ) || !level utility::flag( "sst_brch_check2" ) ) )
    {
        return true;
    }
    
    if ( str_id == "_b" && ( !level utility::flag( "sst_brch_check3" ) || !level utility::flag( "sst_brch_check4" ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x4adee851, Offset: 0x1c84
// Size: 0x12c
function private function_d8feaae9d69b6016( var_6469c1e4d3ac4060 )
{
    str_id = var_6469c1e4d3ac4060.script_label;
    
    if ( str_id == "_a" )
    {
        level utility::flag_wait( "sst_brch_check1" );
        level utility::flag_wait( "sst_brch_check2" );
    }
    else if ( str_id == "_b" )
    {
        level utility::flag_wait( "sst_brch_check3" );
        level utility::flag_wait( "sst_brch_check4" );
    }
    else
    {
        return;
    }
    
    var_6469c1e4d3ac4060.script_cost = 1500;
    
    foreach ( switch_pos in var_6469c1e4d3ac4060.a_switch_pos )
    {
        switch_pos.script_cost = 1500;
    }
    
    if ( isdefined( var_6469c1e4d3ac4060.t_hazard ) )
    {
        var_6469c1e4d3ac4060.t_hazard delete();
        var_6469c1e4d3ac4060.t_hazard = undefined;
    }
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0xc5a4292f, Offset: 0x1db8
// Size: 0x269
function private titan_hazard_monitor( var_6469c1e4d3ac4060 )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( !is_titan_cursed( var_6469c1e4d3ac4060.script_label ) )
        {
            self delete();
            return;
        }
        
        if ( var_6469c1e4d3ac4060.a_switch_pos[ 0 ].interact.state != "buyable" )
        {
            wait 1;
            var_6469c1e4d3ac4060 utility::ent_flag_waitopen_any( "stone_titan_active" );
            continue;
        }
        
        if ( isalive( ent ) && ( isai( ent ) || isplayer( ent ) ) )
        {
            b_reset = 1;
            
            if ( !isdefined( n_start_time ) )
            {
                n_start_time = gettime();
            }
            
            while ( true )
            {
                if ( !isdefined( ent ) || !ent istouching( self ) )
                {
                    break;
                }
                
                wait 1;
                
                if ( var_6469c1e4d3ac4060.a_switch_pos[ 0 ].interact.state != "buyable" )
                {
                    n_start_time = undefined;
                    break;
                }
                
                if ( n_start_time + utility::function_4b74c15943231980( 20 ) < gettime() )
                {
                    level thread activate_titan_hazard( var_6469c1e4d3ac4060 );
                    var_6469c1e4d3ac4060 waittill( #"titan_hazard_ended" );
                    wait 120;
                    n_start_time = undefined;
                    break;
                }
            }
            
            if ( n_start_time )
            {
                foreach ( ai in getaiarrayinradius( self.origin, 1000 ) )
                {
                    if ( ai istouching( self ) )
                    {
                        b_reset = 0;
                        break;
                    }
                }
                
                if ( b_reset )
                {
                    foreach ( player in level.players )
                    {
                        if ( player istouching( self ) )
                        {
                            b_reset = 0;
                            break;
                        }
                    }
                }
                
                if ( b_reset )
                {
                    n_start_time = undefined;
                }
            }
        }
    }
}

// Namespace titan_trap
// Params 1, eflags: 0x4
// Checksum 0x4485b9bf, Offset: 0x2029
// Size: 0x161
function private activate_titan_hazard( var_6469c1e4d3ac4060 )
{
    level endon( #"game_ended" );
    s_switch = var_6469c1e4d3ac4060.a_switch_pos[ 0 ];
    s_switch.interact.state = "activate";
    s_switch.interact.b_cool_down = 0;
    s_switch trap_core::set_switch_scriptable_state( "base", s_switch.interact.state );
    var_6469c1e4d3ac4060.b_hazard = 1;
    var_6469c1e4d3ac4060.trap_positions[ 0 ] activate_stone_titan_trap( undefined, 0 );
    s_switch.interact utility::waittill_any_timeout( var_6469c1e4d3ac4060.script_duration, "run_out_of_duration" );
    var_6469c1e4d3ac4060.trap_positions[ 0 ] deactivate_stone_titan_trap( undefined, 0 );
    var_6469c1e4d3ac4060 utility::ent_flag_wait( "finish_ending_animation" );
    var_6469c1e4d3ac4060.b_hazard = undefined;
    wait 3;
    s_switch.interact.state = "buyable";
    s_switch trap_core::set_switch_scriptable_state( "base", s_switch.interact.state );
    s_switch.interact.b_cool_down = 1;
    var_6469c1e4d3ac4060 notify( #"titan_hazard_ended" );
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0x1cfcb439, Offset: 0x2192
// Size: 0x157
function private deactivate_stone_titan_trap( activator, var_7d83f520111c08a5 = 1 )
{
    var_6469c1e4d3ac4060 = self.var_32f1e7774266024b;
    var_6469c1e4d3ac4060 utility::ent_flag_clear( "stone_titan_active" );
    level.trap_active = undefined;
    var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( var_6469c1e4d3ac4060.script_timeout, &utility::function_7c10ea82c1e305b8, "head_vfx", "ready" );
    var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( var_6469c1e4d3ac4060.script_timeout, &utility::function_7c10ea82c1e305b8, "ambient_breathing_audio", "active" );
    
    if ( var_7d83f520111c08a5 )
    {
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "ambient_throat_singing", "off" );
        
        if ( isdefined( var_6469c1e4d3ac4060.var_1d33ad0241879a2c ) )
        {
            foreach ( mdl_fist in var_6469c1e4d3ac4060.var_1d33ad0241879a2c )
            {
                mdl_fist function_bf5f1501ffe99c02();
            }
            
            var_6469c1e4d3ac4060.var_1d33ad0241879a2c = undefined;
        }
    }
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0x609a688c, Offset: 0x22f1
// Size: 0x35f
function private activate_stone_titan_trap( activator, var_7d83f520111c08a5 = 1 )
{
    var_6469c1e4d3ac4060 = self.var_32f1e7774266024b;
    var_6469c1e4d3ac4060.attack_entity = self.attack_entity;
    var_6469c1e4d3ac4060.attack_entity.var_e7c57daaf2fdcd74 = var_6469c1e4d3ac4060.script_label;
    var_6469c1e4d3ac4060 utility::ent_flag_clear( "finish_ending_animation" );
    
    if ( !is_titan_cursed( var_6469c1e4d3ac4060.script_label ) )
    {
        var_6469c1e4d3ac4060.script_cost = 1500;
        
        foreach ( switch_pos in var_6469c1e4d3ac4060.a_switch_pos )
        {
            switch_pos.script_cost = 1500;
        }
    }
    
    if ( var_6469c1e4d3ac4060 utility::ent_flag( "stone_titan_active" ) )
    {
        return;
    }
    
    function_ab0cf9357a45bf07( var_6469c1e4d3ac4060 );
    var_6469c1e4d3ac4060 utility::ent_flag_set( "stone_titan_active" );
    level.trap_active = 1;
    var_6469c1e4d3ac4060 thread function_9b5a24b16f199179();
    
    foreach ( player in level.players )
    {
        player thread function_180f8c87b8d0821b();
    }
    
    level thread function_2efd7306b09ec060( var_6469c1e4d3ac4060 );
    thread function_9cd63058c374fb9a( activator, var_6469c1e4d3ac4060, var_6469c1e4d3ac4060.attack_entity );
    wait 1;
    
    if ( var_7d83f520111c08a5 )
    {
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::function_7c10ea82c1e305b8( "ambient_throat_singing", "on" );
        var_1fb8e5f567fc21f4 = [];
        
        foreach ( s_fist in var_6469c1e4d3ac4060.var_a59ed3bfa687be42 )
        {
            mdl_fist = s_fist;
            mdl_fist.s_trap_root = var_6469c1e4d3ac4060;
            mdl_fist function_8b6dbebde4057b63( s_fist.script_noteworthy + var_6469c1e4d3ac4060.script_label );
            
            if ( !isdefined( mdl_fist.str_arm_id ) )
            {
                mdl_fist.str_arm_id = s_fist.script_noteworthy + var_6469c1e4d3ac4060.script_label;
            }
            
            var_1fb8e5f567fc21f4[ var_1fb8e5f567fc21f4.size ] = mdl_fist;
        }
        
        if ( var_1fb8e5f567fc21f4.size == 2 )
        {
            var_1fb8e5f567fc21f4[ 0 ].var_fb9c03c454996603 = var_1fb8e5f567fc21f4[ 1 ].origin;
            var_1fb8e5f567fc21f4[ 1 ].var_fb9c03c454996603 = var_1fb8e5f567fc21f4[ 0 ].origin;
        }
        
        var_6469c1e4d3ac4060.var_1d33ad0241879a2c = var_1fb8e5f567fc21f4;
    }
    
    if ( isplayer( activator ) )
    {
        level thread function_35715644b96f73b2( activator );
    }
}

// Namespace titan_trap
// Params 1
// Checksum 0x88bed395, Offset: 0x2658
// Size: 0x24f
function function_2efd7306b09ec060( var_6469c1e4d3ac4060 )
{
    level endon( #"game_ended" );
    var_6469c1e4d3ac4060 notify( #"hash_2a99d011225ca49" );
    var_6469c1e4d3ac4060.scene_node scene::stop();
    var_6469c1e4d3ac4060.scene_node thread scene::play( var_6469c1e4d3ac4060.var_8b17ee2294ae2a72, "shot_010" );
    
    if ( !var_6469c1e4d3ac4060.b_hazard )
    {
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( 0.2, &utility::function_32b24db3127bff40, "head_vfx", "active" );
        var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( 0.2, &utility::function_32b24db3127bff40, "helmet_emissive", "on" );
    }
    
    var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( 0.2, &utility::function_32b24db3127bff40, "shackle_symbol", "pulse_start" );
    var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( 0.2, &utility::function_32b24db3127bff40, "ambient_breathing_audio", "off" );
    var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 thread function_3253378224523fa2();
    wait_length = var_6469c1e4d3ac4060.scene_node scene::function_b3c7b792a7a154fa( "shot_010" );
    wait wait_length;
    
    while ( true )
    {
        var_6469c1e4d3ac4060.scene_node scene::play( var_6469c1e4d3ac4060.var_8b17ee2294ae2a72, "shot_020" );
        
        if ( !var_6469c1e4d3ac4060 utility::ent_flag( "stone_titan_active" ) )
        {
            var_6469c1e4d3ac4060.scene_node scene::play( var_6469c1e4d3ac4060.var_8b17ee2294ae2a72, "shot_030" );
            var_6469c1e4d3ac4060 utility::ent_flag_set( "finish_ending_animation" );
            var_6469c1e4d3ac4060 notify( #"hash_dbca6ae73373278a" );
            
            if ( !var_6469c1e4d3ac4060.b_hazard )
            {
                var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::function_32b24db3127bff40( "head_vfx", "cooldown" );
                var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( 0.2, &utility::function_32b24db3127bff40, "helmet_emissive", "off" );
            }
            
            var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::delaythread( 0.2, &utility::function_32b24db3127bff40, "shackle_symbol", "off" );
            var_6469c1e4d3ac4060.var_8b17ee2294ae2a72 utility::function_32b24db3127bff40( "ambient_breathing_audio", "active" );
            var_6469c1e4d3ac4060 thread function_5844c66f8e9687f6();
            break;
        }
        
        waitframe();
    }
}

// Namespace titan_trap
// Params 0
// Checksum 0x88e03286, Offset: 0x28af
// Size: 0x41
function function_5844c66f8e9687f6()
{
    level endon( #"game_ended" );
    self endon( #"hash_2a99d011225ca49" );
    
    while ( true )
    {
        self.scene_node scene::play( self.var_8b17ee2294ae2a72, "shot_040" );
        waitframe();
    }
}

// Namespace titan_trap
// Params 0
// Checksum 0x8db5936d, Offset: 0x28f8
// Size: 0xeb
function function_3253378224523fa2()
{
    if ( !self.clips )
    {
        return;
    }
    
    foreach ( clip in self.clips )
    {
        if ( clip.script_noteworthy == "j_elbow_le" || clip.script_noteworthy == "j_elbow_ri" || clip.script_noteworthy == "j_shoulder_le" || clip.script_noteworthy == "j_shoulder_ri" )
        {
            clip notsolid();
            clip utility::delaycall( 1.5, &solid );
        }
    }
}

// Namespace titan_trap
// Params 3
// Checksum 0x3d9c07b8, Offset: 0x29eb
// Size: 0x18e
function function_9cd63058c374fb9a( activator, var_6469c1e4d3ac4060, attack_entity )
{
    level endon( #"game_ended" );
    var_6469c1e4d3ac4060 endon( #"hash_dbca6ae73373278a" );
    
    while ( true )
    {
        level waittill( "pre_titan_hit" + var_6469c1e4d3ac4060.script_label, left_or_right );
        
        if ( !isdefined( left_or_right ) )
        {
            continue;
        }
        
        current_impact_point = self.var_27d1e1a53111a46e[ left_or_right ];
        
        if ( !isdefined( self.sbl_impact ) )
        {
            self.sbl_impact = [];
        }
        
        if ( !isdefined( self.sbl_impact[ left_or_right ] ) )
        {
            self.sbl_impact[ left_or_right ] = spawnscriptable( "sat_zm_stone_titan_trap", current_impact_point.origin );
        }
        
        hit_zombies = var_6469c1e4d3ac4060 function_5c754b7596915b7a( left_or_right );
        hit_players = var_6469c1e4d3ac4060 function_da782b98784fc25( left_or_right );
        hit_extra = var_6469c1e4d3ac4060 function_71234631a7e99bf9( left_or_right );
        level waittill( "titan_hit" + var_6469c1e4d3ac4060.script_label, left_or_right );
        self.sbl_impact[ left_or_right ] utility::function_32b24db3127bff40( "fx", "on_smash" );
        thread function_b1d33f581a9a6bef( activator, var_6469c1e4d3ac4060, current_impact_point, self.attack_entity, left_or_right, hit_zombies, hit_players, hit_extra );
        earthquakeadvanced( 0.8, 0.15, 0.02, 1.1, current_impact_point.origin, 150, 300, 1500 );
        playrumbleonposition( "artillery_rumble_heavy", current_impact_point.origin );
    }
}

// Namespace titan_trap
// Params 1
// Checksum 0xcdbbd7db, Offset: 0x2b81
// Size: 0x10a
function function_2c424c0f92d99f09( left_or_right )
{
    foreach ( player in level.players )
    {
        if ( left_or_right == "left" )
        {
            origin = self.var_32f1e7774266024b.var_8b17ee2294ae2a72 gettagorigin( "j_elbow_le" );
            self.var_32f1e7774266024b.var_8b17ee2294ae2a72 thread function_4a6a2af9254b5f4( origin, player, left_or_right );
            continue;
        }
        
        origin = self.var_32f1e7774266024b.var_8b17ee2294ae2a72 gettagorigin( "j_elbow_ri" );
        self.var_32f1e7774266024b.var_8b17ee2294ae2a72 thread function_4a6a2af9254b5f4( origin, player, left_or_right );
    }
}

// Namespace titan_trap
// Params 3
// Checksum 0x4de327b9, Offset: 0x2c93
// Size: 0xc7
function function_4a6a2af9254b5f4( origin, player, left_or_right )
{
    player endon( #"death_or_disconnect" );
    
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    dist = distancesquared( player.origin, origin );
    
    if ( dist > 2250000 )
    {
        return;
    }
    
    var_6469c1e4d3ac4060 = self.var_32f1e7774266024b;
    loc = function_e3f9b112e68231cd( player.origin, self.var_32f1e7774266024b.var_2f09d8aa2025c4a2[ left_or_right ] );
    
    if ( !isdefined( loc ) )
    {
        return;
    }
    
    player setorigin( loc );
    player function_180f8c87b8d0821b();
}

// Namespace titan_trap
// Params 1
// Checksum 0xb3ba20bc, Offset: 0x2d62
// Size: 0xc5
function function_5c754b7596915b7a( left_or_right )
{
    fist_trigger = self.var_d928d2f7d2ab477b[ left_or_right ];
    near_zombies = getaiarrayinradius( fist_trigger.origin, 800 );
    hit_zombies = [];
    
    foreach ( zombie in near_zombies )
    {
        if ( zombie istouching( fist_trigger ) )
        {
            hit_zombies[ hit_zombies.size ] = zombie;
        }
    }
    
    return hit_zombies;
}

// Namespace titan_trap
// Params 1
// Checksum 0x69baec30, Offset: 0x2e30
// Size: 0xc5
function function_da782b98784fc25( left_or_right )
{
    fist_trigger = self.var_d928d2f7d2ab477b[ left_or_right ];
    near_players = getplayersinradius( fist_trigger.origin, 1500 );
    hit_players = [];
    
    foreach ( player in near_players )
    {
        if ( player istouching( fist_trigger ) )
        {
            hit_players[ hit_players.size ] = player;
        }
    }
    
    return hit_players;
}

// Namespace titan_trap
// Params 1
// Checksum 0x1c2ab4e9, Offset: 0x2efe
// Size: 0xde
function function_71234631a7e99bf9( left_or_right )
{
    fist_trigger = self.var_d928d2f7d2ab477b[ left_or_right ];
    near_ents = getentarrayinradius( undefined, undefined, fist_trigger.origin, 1500 );
    hit_extra = [];
    
    foreach ( ent in near_ents )
    {
        if ( ent.rcxdtype && ent istouching( fist_trigger ) )
        {
            if ( !isdefined( hit_extra ) )
            {
                hit_extra = [];
            }
            
            hit_extra[ hit_extra.size ] = ent;
        }
    }
    
    return hit_extra;
}

// Namespace titan_trap
// Params 8, eflags: 0x4
// Checksum 0x581ea053, Offset: 0x2fe5
// Size: 0x2c0
function private function_b1d33f581a9a6bef( activator, var_6469c1e4d3ac4060, impact_point, attack_entity, left_or_right, hit_zombies, hit_players, hit_extra )
{
    self endon( #"hash_dbca6ae73373278a" );
    
    /#
        if ( getdvarint( @"hash_8947d65f71a14ec7", 0 ) )
        {
            circle( impact_point.origin, 260, undefined, ( 1, 0, 0 ) );
        }
    #/
    
    var_a2de5269e463ad7f = left_or_right + var_6469c1e4d3ac4060.script_label;
    
    foreach ( ai in hit_zombies )
    {
        if ( ai istouching( var_6469c1e4d3ac4060.var_d928d2f7d2ab477b[ left_or_right ] ) )
        {
            ai thread function_532b77474516b0ea( activator, impact_point, attack_entity, var_6469c1e4d3ac4060.b_hazard, var_a2de5269e463ad7f );
        }
        
        throttle::throttle_wait_in_queue( var_6469c1e4d3ac4060.damage_throttle, var_6469c1e4d3ac4060 );
    }
    
    foreach ( player in hit_players )
    {
        player thread function_532b77474516b0ea( activator, impact_point, attack_entity, var_6469c1e4d3ac4060.b_hazard, var_a2de5269e463ad7f );
        loc = function_e3f9b112e68231cd( player.origin, var_6469c1e4d3ac4060.var_2f09d8aa2025c4a2[ left_or_right ] );
        
        if ( isdefined( loc ) )
        {
            player setorigin( loc );
            player thread function_180f8c87b8d0821b();
        }
    }
    
    foreach ( extra in hit_extra )
    {
        if ( extra.rcxdtype && extra istouching( var_6469c1e4d3ac4060.var_d928d2f7d2ab477b[ left_or_right ] ) )
        {
            extra thread function_f906ee6cb6e6be30();
        }
    }
    
    waitframe();
    var_6469c1e4d3ac4060 thread function_f35b977778b9de1d( impact_point.origin, left_or_right );
}

// Namespace titan_trap
// Params 0, eflags: 0x4
// Checksum 0x35612bf9, Offset: 0x32ad
// Size: 0x65
function private function_f906ee6cb6e6be30()
{
    if ( self.var_749b7e341dfdf7a9 || !utility::issharedfuncdefined( #"killstreak_rcxd", #"explode" ) )
    {
        return;
    }
    
    if ( self.owner )
    {
        self.owner notify( #"killstreak_cancel" );
    }
    
    childthread utility::callsharedfunc( #"killstreak_rcxd", #"explode" );
}

// Namespace titan_trap
// Params 5
// Checksum 0x9c6153af, Offset: 0x331a
// Size: 0x2c8
function function_532b77474516b0ea( activator, impact_point, attack_entity, b_hazard, str_arm_targetname )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        utility::function_32b24db3127bff40( "saw_blade_trap_hit", "on" );
        n_damage = self.maxhealth * 0.2;
        
        if ( b_hazard )
        {
            n_damage *= 1.15;
        }
        
        self dodamage( int( n_damage ), self.origin, attack_entity, attack_entity, undefined );
        self shellshock( %"hash_666c1a9dcfb71c98", 2 );
        thread effect_slow::slow( "stone_titan_smash", 0.75, 2, attack_entity );
        return;
    }
    
    if ( isai( self ) )
    {
        if ( function_3c330761fc151f42() )
        {
            return;
        }
        
        self.var_9387a792d7b6e180 = str_arm_targetname;
        is_base_zombie = isstartstr( self.subclass, "zombie_base" );
        
        if ( is_base_zombie )
        {
            if ( b_hazard && utility::issharedfuncdefined( #"zombie", #"hash_6c2d9080e508d382" ) )
            {
                utility::callsharedfunc( #"zombie", #"hash_6c2d9080e508d382" );
            }
            
            self.nocorpse = 1;
            self.no_powerups = 1;
            self.var_a13bed1ac47e1b2c = 1;
            self.var_66504c8a8a5ed6dd = 1;
            self.var_afddff341d1f2fc7 = 1;
            namespace_b76ff2659823e89d::annihilate( 1 );
            self kill( undefined, attack_entity, attack_entity );
            return;
        }
        
        if ( self.aicategory == "normal" )
        {
            if ( b_hazard && utility::issharedfuncdefined( #"zombie", #"hash_6c2d9080e508d382" ) )
            {
                utility::callsharedfunc( #"zombie", #"hash_6c2d9080e508d382" );
            }
            
            self.nocorpse = 1;
            self.no_powerups = 1;
            self.var_a13bed1ac47e1b2c = 1;
            self.var_66504c8a8a5ed6dd = 1;
            self.var_afddff341d1f2fc7 = 1;
            namespace_b76ff2659823e89d::annihilate( 1 );
            self kill( undefined, attack_entity, attack_entity );
            return;
        }
        
        if ( issubstr( self.subclass, "hvt" ) || self.aicategory == "hvt" )
        {
            damage_ratio = 0.08;
        }
        else if ( self.aicategory == "special" )
        {
            damage_ratio = 0.33;
        }
        else if ( self.aicategory == "elite" )
        {
            damage_ratio = 0.12;
        }
        
        if ( damage_ratio )
        {
            self dodamage( self.maxhealth * damage_ratio, self.origin, undefined, attack_entity, undefined );
        }
    }
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0x4ac6dfd1, Offset: 0x35ea
// Size: 0x252
function private function_f35b977778b9de1d( var_175e0109a63f0a9b, left_or_right )
{
    /#
        if ( getdvarint( @"hash_8947d65f71a14ec7", 0 ) )
        {
            circle( var_175e0109a63f0a9b, 360, undefined, undefined, undefined, 9 );
        }
    #/
    
    a_ai = getaiarrayinradius( var_175e0109a63f0a9b, 360 );
    a_ai = utility::get_array_of_closest( var_175e0109a63f0a9b, a_ai );
    
    foreach ( ai in a_ai )
    {
        if ( !isalive( ai ) || ai utility::ent_flag( "has_been_knocked_by_titan" ) )
        {
            continue;
        }
        
        ai utility::ent_flag_set( "has_been_knocked_by_titan" );
        
        if ( ai.aicategory == "normal" )
        {
            knockdown_source = function_d132f28896625ccc( ai, var_175e0109a63f0a9b );
            ai thread zombie_knockdown::function_6fc167d4a3590991( knockdown_source, 150, 10 );
            
            if ( !ai.var_26c0e7ecbfd56e77 )
            {
                ai dodamage( int( ai.maxhealth * 0.25 ), ai.origin, undefined, self.attack_entity, undefined );
            }
        }
        else
        {
            loc = function_e3f9b112e68231cd( ai.origin, self.var_2f09d8aa2025c4a2[ left_or_right ] );
            
            if ( isdefined( loc ) )
            {
                ai setorigin( loc );
                knockdown_source = function_d132f28896625ccc( ai, var_175e0109a63f0a9b );
                ai thread zombie_knockdown::function_6fc167d4a3590991( knockdown_source, 150, 10 );
            }
            else
            {
                knockdown_source = function_d132f28896625ccc( ai, var_175e0109a63f0a9b );
                b_knocked = ai thread zombie_knockdown::function_6fc167d4a3590991( knockdown_source, 150, 10 );
                
                if ( !b_knocked )
                {
                    v_dir = vectornormalize( ai.origin - var_175e0109a63f0a9b );
                    var_bcd8bb6e69015479 = 360 - distance2d( ai.origin, var_175e0109a63f0a9b );
                    ai forceteleport( ai.origin + v_dir * ( var_bcd8bb6e69015479 + 10 ), ai.angles );
                }
            }
        }
        
        ai utility::delaythread( 3, &utility::ent_flag_clear, "has_been_knocked_by_titan" );
    }
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0x28f53354, Offset: 0x3844
// Size: 0xaf
function private function_d132f28896625ccc( ai, var_175e0109a63f0a9b )
{
    var_dea31404d72e5bad = ( var_175e0109a63f0a9b[ 0 ], var_175e0109a63f0a9b[ 1 ], ai.origin[ 2 ] );
    var_b777a21fa7a249c0 = vectornormalize2( ai.origin - var_dea31404d72e5bad );
    
    if ( var_b777a21fa7a249c0 != ( 0, 0, 0 ) )
    {
        return var_dea31404d72e5bad;
    }
    
    var_552ce7097f1f660f = vectornormalize2( anglestoforward( ai.angles ) );
    
    if ( var_552ce7097f1f660f == ( 0, 0, 0 ) )
    {
        var_552ce7097f1f660f = ( 1, 0, 0 );
    }
    
    return var_dea31404d72e5bad - var_552ce7097f1f660f * 1;
}

// Namespace titan_trap
// Params 4, eflags: 0x4
// Checksum 0x75faa972, Offset: 0x38fc
// Size: 0x204
function private function_dfdaed5d5e399e79( activator, scr_impact, mdl_arm, attack_entity )
{
    self endon( #"hash_dbca6ae73373278a" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_8947d65f71a14ec7", 0 ) )
            {
                circle( scr_impact.origin, 260, undefined, ( 1, 0, 0 ) );
            }
        #/
        
        a_ai = getaiarrayinradius( scr_impact.origin, 260 );
        a_ai = utility::get_array_of_closest( scr_impact.origin, a_ai );
        
        foreach ( ai in a_ai )
        {
            if ( ai.var_b3c5d5e6bd860996 != scr_impact && ai istouching( mdl_arm ) )
            {
                ai.var_b3c5d5e6bd860996 = scr_impact;
                ai thread function_aea74c857101b1c8( activator, scr_impact, attack_entity, self.b_hazard, mdl_arm.targetname );
            }
        }
        
        foreach ( player in level.players )
        {
            if ( player.var_b3c5d5e6bd860996 != scr_impact && player istouching( mdl_arm ) )
            {
                player.var_b3c5d5e6bd860996 = scr_impact;
                player thread function_aea74c857101b1c8( activator, scr_impact, attack_entity, self.b_hazard );
            }
        }
        
        waitframe();
    }
}

// Namespace titan_trap
// Params 5
// Checksum 0xd0a75623, Offset: 0x3b08
// Size: 0x251
function function_aea74c857101b1c8( activator, scr_impact, attack_entity, b_hazard, str_arm_targetname )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !self.var_b3c5d5e6bd860996 )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        utility::function_32b24db3127bff40( "saw_blade_trap_hit", "on" );
        n_damage = self.maxhealth * 0.2;
        
        if ( b_hazard )
        {
            n_damage *= 1.15;
        }
        
        self dodamage( int( n_damage ), self.origin, undefined, attack_entity, undefined );
        v_knock_dir = ( self.origin[ 0 ], self.origin[ 1 ], 0 ) - ( scr_impact.origin[ 0 ], scr_impact.origin[ 1 ], 0 );
        self knockback( v_knock_dir, 300 );
        self shellshock( %"hash_666c1a9dcfb71c98", 2 );
        thread effect_slow::slow( "stone_titan_smash", 0.75, 2, attack_entity );
    }
    else if ( isai( self ) )
    {
        if ( function_3c330761fc151f42() )
        {
            return;
        }
        
        self.var_9387a792d7b6e180 = str_arm_targetname;
        is_base_zombie = isstartstr( self.subclass, "zombie_base" );
        
        if ( is_base_zombie )
        {
            impact_base_zombie();
            self kill( undefined, undefined, attack_entity );
        }
        else if ( self.aicategory == "normal" )
        {
            self kill( undefined, undefined, attack_entity );
        }
        else
        {
            if ( issubstr( self.subclass, "hvt" ) || self.aicategory == "hvt" )
            {
                damage_ratio = 0.08;
            }
            else if ( self.aicategory == "special" )
            {
                damage_ratio = 0.33;
            }
            else if ( self.aicategory == "elite" )
            {
                damage_ratio = 0.12;
            }
            
            if ( damage_ratio )
            {
                self dodamage( self.maxhealth * damage_ratio, self.origin, undefined, attack_entity, undefined );
            }
        }
    }
    
    wait 2;
    
    if ( self.var_b3c5d5e6bd860996 == scr_impact )
    {
        self.var_b3c5d5e6bd860996 = undefined;
    }
}

// Namespace titan_trap
// Params 0, eflags: 0x4
// Checksum 0x8ad8f5bc, Offset: 0x3d61
// Size: 0x4e, Type: bool
function private function_3c330761fc151f42()
{
    if ( self.magic_bullet_shield || self.damageshield || val::get( "damageshield" ) || !val::get( "death" ) || !val::get( "damage" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace titan_trap
// Params 0
// Checksum 0x82c41e61, Offset: 0x3db8
// Size: 0x5b
function impact_base_zombie()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( randomint( 100 ) > 50 )
    {
        namespace_b76ff2659823e89d::annihilate();
        return;
    }
    
    self.ragdollhitloc = "head";
    self.do_immediate_ragdoll = 1;
    
    if ( zombie_dismemberment::is_dismemberment_allowed() )
    {
        zombie_dismemberment::dismember_limb( 1, 15 );
    }
}

// Namespace titan_trap
// Params 0
// Checksum 0x70a57e87, Offset: 0x3e1b
// Size: 0x4d
function add_attractor()
{
    attractor = zombie_attractor_manager::add_attractor( self, 1, 900, 1, undefined, &function_cc6605aa869c9c71 );
    zombie_attractor_manager::function_1497469a46932be2( attractor, self.origin, self.angles, 30, 5 );
    zombie_attractor_manager::function_4c34b0f066a9d9fe( attractor, 360 );
}

// Namespace titan_trap
// Params 0
// Checksum 0x689b6ab2, Offset: 0x3e70
// Size: 0xa
function remove_attractor()
{
    zombie_attractor_manager::remove_attractor( self );
}

// Namespace titan_trap
// Params 1
// Checksum 0xb27d1d2f, Offset: 0x3e82
// Size: 0x66
function function_8b6dbebde4057b63( str_arm_id )
{
    attractor = zombie_attractor_manager::add_attractor( self, 2, 1800, 0, undefined, &function_5aafe1f9e26869cc );
    
    if ( !isdefined( attractor.str_arm_id ) )
    {
        attractor.str_arm_id = str_arm_id;
    }
    
    zombie_attractor_manager::function_1497469a46932be2( attractor, self.origin, self.angles, 30, 20 );
}

// Namespace titan_trap
// Params 0
// Checksum 0x2b403291, Offset: 0x3ef0
// Size: 0xa
function function_bf5f1501ffe99c02()
{
    zombie_attractor_manager::remove_attractor( self );
}

// Namespace titan_trap
// Params 2
// Checksum 0xbcdc919c, Offset: 0x3f02
// Size: 0xce, Type: bool
function function_cc6605aa869c9c71( attractor, zombie )
{
    if ( zombie.aicategory == "hvt" || zombie.aicategory == "elite" || zombie.aicategory == "special" || issubstr( zombie.subclass, "hvt" ) )
    {
        return false;
    }
    
    if ( isdefined( zombie.var_26c0e7ecbfd56e77 ) )
    {
        return false;
    }
    
    var_6469c1e4d3ac4060 = attractor.source.s_trap_root;
    
    if ( isdefined( var_6469c1e4d3ac4060 ) && isdefined( var_6469c1e4d3ac4060.t_radius_vol ) && !zombie istouching( var_6469c1e4d3ac4060.t_radius_vol ) )
    {
        return false;
    }
    
    return true;
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0xd9f69d2e, Offset: 0x3fd9
// Size: 0x1b5
function private function_5aafe1f9e26869cc( attractor, zombie )
{
    if ( zombie.aicategory == "hvt" || zombie.aicategory == "elite" || zombie.aicategory == "special" || issubstr( zombie.subclass, "hvt" ) )
    {
        return 0;
    }
    
    var_6469c1e4d3ac4060 = attractor.source.s_trap_root;
    
    if ( isdefined( var_6469c1e4d3ac4060 ) && isdefined( var_6469c1e4d3ac4060.t_radius_vol ) && !zombie istouching( var_6469c1e4d3ac4060.t_radius_vol ) )
    {
        return 0;
    }
    
    if ( isdefined( zombie.var_26c0e7ecbfd56e77 ) )
    {
        var_e02b6a52be7e96ca = 0;
        
        foreach ( fist_attractor in var_6469c1e4d3ac4060.var_1d33ad0241879a2c )
        {
            if ( level utility::callsharedfunc( #"quest", #"hash_4c11e178cb3a3c7f", fist_attractor.str_arm_id, zombie.var_26c0e7ecbfd56e77 ) )
            {
                var_e02b6a52be7e96ca = 1;
                break;
            }
        }
        
        if ( var_e02b6a52be7e96ca )
        {
            return level utility::callsharedfunc( #"quest", #"hash_4c11e178cb3a3c7f", attractor.str_arm_id, zombie.var_26c0e7ecbfd56e77 );
        }
    }
    
    return 1;
}

// Namespace titan_trap
// Params 2, eflags: 0x4
// Checksum 0xf9ef9fe4, Offset: 0x4197
// Size: 0xfe, Type: bool
function private function_7438374394674c17( v_origin, var_6469c1e4d3ac4060 )
{
    if ( !isdefined( level.var_c9baedcff921facc ) )
    {
        return true;
    }
    
    var_41bc5a05f0137682 = distance( v_origin, var_6469c1e4d3ac4060.var_8b17ee2294ae2a72.origin );
    
    foreach ( var_b8665949129c193 in level.var_c9baedcff921facc )
    {
        if ( var_b8665949129c193 == var_6469c1e4d3ac4060 )
        {
            continue;
        }
        
        if ( !var_b8665949129c193 utility::ent_flag( "stone_titan_active" ) )
        {
            continue;
        }
        
        if ( distance( v_origin, var_b8665949129c193.var_8b17ee2294ae2a72.origin ) < var_41bc5a05f0137682 )
        {
            return false;
        }
    }
    
    return true;
}

/#

    // Namespace titan_trap
    // Params 0, eflags: 0x4
    // Checksum 0xdb902e49, Offset: 0x429e
    // Size: 0x55, Type: dev
    function private function_9d4cadcf189cfc6c()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( getdvarint( @"hash_8947d65f71a14ec7", 0 ) )
        {
            /#
                sphere( self.origin, 100, ( 1, 0, 0 ), 0, 1 );
            #/
            
            waitframe();
        }
    }

#/

// Namespace titan_trap
// Params 1, eflags: 0xc
// Checksum 0x79bd783, Offset: 0x42fb
// Size: 0x5c
function private function_35715644b96f73b2( player )
{
    self notify( #"hash_e9ba902d71c3d94" );
    self endon( #"hash_e9ba902d71c3d94" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( player utility::ent_flag( "titan_trap_activated_first_time_vo" ) )
    {
        return;
    }
    
    player utility::ent_flag_set( "titan_trap_activated_first_time_vo" );
}

/#

    // Namespace titan_trap
    // Params 0
    // Checksum 0xa0b0a439, Offset: 0x435f
    // Size: 0x18c, Type: dev
    function init_debug()
    {
        level.var_f5034eb09b895ca0 = 0;
        level.var_2fac0da144cc977b = 0;
        devgui::function_9082edeb5db93280( "<dev string:x45>" );
        devgui::add_devgui_func( "<dev string:x61>", "<dev string:x77>", &function_5d2e38211b1c6403 );
        devgui::add_devgui_func( "<dev string:x8e>", "<dev string:xa2>", &function_fb6a90fad47373a3 );
        devgui::add_devgui_func( "<dev string:xb7>", "<dev string:xca>", &function_926fcdd21d7acd2e );
        devgui::add_devgui_func( "<dev string:xd8>", "<dev string:xeb>", &function_926fccd21d7acafb );
        devgui::function_cd4e263c1f3018ae( "<dev string:xf9>", "<dev string:x10f>", &adjust_rotation );
        devgui::function_cd4e263c1f3018ae( "<dev string:x125>", "<dev string:x13c>", &adjust_rotation );
        devgui::function_cd4e263c1f3018ae( "<dev string:x153>", "<dev string:x169>", &adjust_rotation );
        devgui::function_cd4e263c1f3018ae( "<dev string:x17f>", "<dev string:x196>", &adjust_rotation );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ad>", "<dev string:x1c3>", &adjust_rotation );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1d9>", "<dev string:x1f0>", &adjust_rotation );
        devgui::function_cd4e263c1f3018ae( "<dev string:x207>", "<dev string:x21f>", &adjust_position );
        devgui::function_cd4e263c1f3018ae( "<dev string:x237>", "<dev string:x250>", &adjust_position );
        devgui::function_cd4e263c1f3018ae( "<dev string:x269>", "<dev string:x281>", &adjust_position );
        devgui::function_cd4e263c1f3018ae( "<dev string:x299>", "<dev string:x2b2>", &adjust_position );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2cb>", "<dev string:x2e3>", &adjust_position );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2fb>", "<dev string:x314>", &adjust_position );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace titan_trap
    // Params 1
    // Checksum 0x5a66e1bc, Offset: 0x44f3
    // Size: 0x2c0, Type: dev
    function adjust_position( params )
    {
        rune_right = getent( "<dev string:x32d>", #script_noteworthy );
        parent = rune_right getlinkedparent();
        rune_right unlink();
        
        if ( !isdefined( level.var_5333df9d8a637a19 ) )
        {
            level.var_5333df9d8a637a19 = ( 0, 0, 0 );
        }
        
        switch ( params[ 0 ] )
        {
            case #"hash_311058bc01bdab67":
                level.var_5333df9d8a637a19 += ( 1, 0, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ) + level.var_5333df9d8a637a19, ( 180, 180, 0 ) );
                break;
            case #"hash_f95bc0f6bcc29fa0":
                level.var_5333df9d8a637a19 += ( -1, 0, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ) + level.var_5333df9d8a637a19, ( 180, 180, 0 ) );
                break;
            case #"hash_311057bc01bda9d4":
                level.var_5333df9d8a637a19 += ( 0, 1, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ) + level.var_5333df9d8a637a19, ( 180, 180, 0 ) );
                break;
            case #"hash_f95bc1f6bcc2a133":
                level.var_5333df9d8a637a19 += ( 0, -1, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ) + level.var_5333df9d8a637a19, ( 180, 180, 0 ) );
                break;
            case #"hash_31105abc01bdae8d":
                level.var_5333df9d8a637a19 += ( 0, 0, 1 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ) + level.var_5333df9d8a637a19, ( 180, 180, 0 ) );
                break;
            case #"hash_f95bc2f6bcc2a2c6":
                level.var_5333df9d8a637a19 += ( 0, 0, -1 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ) + level.var_5333df9d8a637a19, ( 180, 180, 0 ) );
                break;
            default:
                break;
        }
    }

    // Namespace titan_trap
    // Params 1
    // Checksum 0x1a0351df, Offset: 0x47bb
    // Size: 0x2c0, Type: dev
    function adjust_rotation( params )
    {
        rune_right = getent( "<dev string:x32d>", #script_noteworthy );
        parent = rune_right getlinkedparent();
        rune_right unlink();
        
        if ( !isdefined( level.var_3e9fd252c3ee88ec ) )
        {
            level.var_3e9fd252c3ee88ec = ( 0, 0, 0 );
        }
        
        switch ( params[ 0 ] )
        {
            case #"hash_311058bc01bdab67":
                level.var_3e9fd252c3ee88ec += ( 1, 0, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ), ( 180, 180, 0 ) + level.var_3e9fd252c3ee88ec );
                break;
            case #"hash_f95bc0f6bcc29fa0":
                level.var_3e9fd252c3ee88ec += ( -1, 0, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ), ( 180, 180, 0 ) + level.var_3e9fd252c3ee88ec );
                break;
            case #"hash_311057bc01bda9d4":
                level.var_3e9fd252c3ee88ec += ( 0, 1, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ), ( 180, 180, 0 ) + level.var_3e9fd252c3ee88ec );
                break;
            case #"hash_f95bc1f6bcc2a133":
                level.var_3e9fd252c3ee88ec += ( 0, -1, 0 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ), ( 180, 180, 0 ) + level.var_3e9fd252c3ee88ec );
                break;
            case #"hash_31105abc01bdae8d":
                level.var_3e9fd252c3ee88ec += ( 0, 0, 1 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ), ( 180, 180, 0 ) + level.var_3e9fd252c3ee88ec );
                break;
            case #"hash_f95bc2f6bcc2a2c6":
                level.var_3e9fd252c3ee88ec += ( 0, 0, -1 );
                rune_right linkto( parent, "<dev string:x343>", ( 0, 0, 0 ), ( 180, 180, 0 ) + level.var_3e9fd252c3ee88ec );
                break;
            default:
                break;
        }
    }

    // Namespace titan_trap
    // Params 0, eflags: 0x4
    // Checksum 0x8ec27ade, Offset: 0x4a83
    // Size: 0x137, Type: dev
    function private function_5d2e38211b1c6403()
    {
        level endon( #"game_ended" );
        var_fdfff5a9d07bea0b = utility::getstructarray( "<dev string:x35f>" );
        var_fdfff6a9d07bec3e = utility::getstructarray( "<dev string:x378>" );
        
        foreach ( loc_a in var_fdfff5a9d07bea0b )
        {
            loc_a thread drawsphere( ( 0, 1, 1 ) );
        }
        
        foreach ( loc_b in var_fdfff6a9d07bec3e )
        {
            loc_b thread drawsphere( ( 0, 1, 1 ) );
        }
    }

    // Namespace titan_trap
    // Params 0
    // Checksum 0xd011fec4, Offset: 0x4bc2
    // Size: 0x13f, Type: dev
    function function_fb6a90fad47373a3()
    {
        var_fdfff5a9d07bea0b = utility::getstructarray( "<dev string:x35f>" );
        var_fdfff6a9d07bec3e = utility::getstructarray( "<dev string:x378>" );
        
        foreach ( loc_a in var_fdfff5a9d07bea0b )
        {
            loc_a.mdl_attractor = loc_a;
            loc_a.mdl_attractor add_attractor();
        }
        
        foreach ( loc_b in var_fdfff6a9d07bec3e )
        {
            loc_b.mdl_attractor = loc_b;
            loc_b.mdl_attractor add_attractor();
        }
    }

    // Namespace titan_trap
    // Params 0, eflags: 0x4
    // Checksum 0x879a7788, Offset: 0x4d09
    // Size: 0x1f, Type: dev
    function private function_926fcdd21d7acd2e()
    {
        level utility::flag_set( "<dev string:x391>" );
        level utility::flag_set( "<dev string:x3a1>" );
    }

    // Namespace titan_trap
    // Params 0, eflags: 0x4
    // Checksum 0x1e932632, Offset: 0x4d30
    // Size: 0x1f, Type: dev
    function private function_926fccd21d7acafb()
    {
        level utility::flag_set( "<dev string:x3b1>" );
        level utility::flag_set( "<dev string:x3c1>" );
    }

    // Namespace titan_trap
    // Params 1
    // Checksum 0x8fae1392, Offset: 0x4d57
    // Size: 0x85, Type: dev
    function drawsphere( color )
    {
        self notify( #"hash_5319197b8414266f" );
        self endon( #"hash_5319197b8414266f" );
        level endon( #"game_ended" );
        self endon( #"hash_c71cda35fbb1a41e" );
        self endon( #"hash_6f9a1617bc016272" );
        var_8ffb5fae1c3df313 = color ?? ( 0, 1, 0 );
        
        while ( true )
        {
            sphere( self.origin, 5, var_8ffb5fae1c3df313, 0 );
            waitframe();
        }
    }

#/
