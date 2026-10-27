// scripts\mp\ob\activities\ob_activity_crash_sites.gsc  (hash_168d68445d93440c.gscc) (size: 28180 Bytes / 0x6e14 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9daf5340 (2645513024)
// size ...... 28180 (0x6e14)
// includes .. 31  (offset: 0x6910)
// strings ... 58  (offset: 0x6a08)
// dev strs .. 17  (offset: 0x6d34)
// exports ... 62  (offset: 0x4674)
// cseg ...... 0x56c + 0x4108 (0x4674)
// imports ... 204 (offset: 0x5024)
// animtree1 . 0   (offset: 0x6e14)
// animtree2 . 0   (offset: 0x6e14)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\puzzles\signal_detected;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\ai_behavior;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\killstreaks\ground_drone_unit_mp;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_crash_sites;

// Namespace ob_activity_crash_sites
// Params 0, eflags: 0x5
// Checksum 0x6e27ccc0, Offset: 0x58a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_crash_sites", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0xf06e530d, Offset: 0x5b3
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_CRASH_SITES", &crash_sites_activity_type_init );
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x84c21180, Offset: 0x5ce
// Size: 0xba
function crash_sites_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_CRASH_SITES", 0, &crash_sites_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_CRASH_SITES", 1, &crash_sites_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_CRASH_SITES", 2, &crash_sites_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_CRASH_SITES", 3, &crash_sites_destroy );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_156b36e77af03dcf, "REV_OB_CRASH_SITES" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_a0dfbfb33c31b5a, "REV_OB_CRASH_SITES" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_51bd85635fe3e31c, "REV_OB_CRASH_SITES" );
    utility::registersharedfunc( "ob_crash_site_black_box", #"hack", &black_hat_hack_finished );
    scriptable::scriptable_addusedcallbackbypart( "crash_sites_blackbox", &function_c2e57268652c4dcc );
}

// Namespace ob_activity_crash_sites
// Params 2
// Checksum 0xb58863d5, Offset: 0x690
// Size: 0x22d
function crash_sites_setup( intro_type = 0, end_on_success = 1 )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.plane_start_point = utility::getstruct( self.varianttag, "targetname" );
    self.var_636c6f3137e2110c = utility::getstruct( self.plane_start_point.target, "targetname" );
    self.plane_crash_point = utility::getstruct( self.var_636c6f3137e2110c.target, "targetname" );
    assert( isdefined( self.plane_start_point ) && isdefined( self.var_636c6f3137e2110c ) && isdefined( self.plane_crash_point ), "<dev string:x24>" + activity_instance.varianttag + "<dev string:x58>" );
    self.var_cdc0e4d6d9288be8 = self.plane_crash_point.radius;
    script_structs = utility::getstructarray( self.plane_crash_point.target, "targetname" );
    
    foreach ( struct in script_structs )
    {
        if ( struct.script_noteworthy == "black_box" )
        {
            self.black_box_struct = struct;
        }
    }
    
    if ( !isdefined( self.difficulty_region ) )
    {
        self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.black_box_struct.origin );
    }
    
    self.var_c61a2284c5526ca0 = 120;
    
    /#
    #/
    
    self.intro_type = intro_type;
    self.end_on_success = end_on_success;
    
    if ( self.intro_type == 0 )
    {
        activity_instance_common::function_46135a69bddfec2c( self );
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x16e20d38, Offset: 0x8c5
// Size: 0xe, Type: bool
function is_hover_intro()
{
    return self.intro_type == 1;
}

// Namespace ob_activity_crash_sites
// Params 2
// Checksum 0x479a6106, Offset: 0x8dc
// Size: 0x106
function function_245cd68471b30a68( origin, angles )
{
    var_b1b6dfe35fc16b0a = getdvarint( @"hash_e29fa96e88baf457", 0 );
    planemodel = var_b1b6dfe35fc16b0a ? %"hash_7f5154211f44751b" : %"xcomp_veh_sat_ob_activity_crash_site_mil_air_uav_gear_up";
    plane = ob_resource_manager::activity_spawn_entity( "script_model", origin );
    plane setmodel( planemodel );
    plane.angles = angles;
    self.plane = plane;
    plane setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"on" );
    
    if ( var_b1b6dfe35fc16b0a == 1 )
    {
        self.var_b1b6dfe35fc16b0a = 1;
        plane setscriptablepartstate( #"bodyfx_intro", #"on" );
        plane setscriptablepartstate( #"objective", #"active_yellow", 0 );
        plane setscriptablepartstate( #"contrails", #"on", 0 );
    }
    
    return plane;
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x6d135517, Offset: 0x9eb
// Size: 0xe4
function function_313c478a8827aa4()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_dc3be236543f1358 = self.plane_start_point.origin[ 2 ];
    var_5de21a10a873b53b = 15000;
    hover_center = ( self.plane_crash_point.origin[ 0 ], self.plane_crash_point.origin[ 1 ], var_dc3be236543f1358 );
    spawn_origin = hover_center + ( var_5de21a10a873b53b * cos( 0 ), var_5de21a10a873b53b * sin( 0 ), 0 );
    plane = function_245cd68471b30a68( spawn_origin, ( 0, 0, 0 ) );
    plane.var_5de21a10a873b53b = var_5de21a10a873b53b;
    plane.hover_center = hover_center;
    plane simulate_hover();
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x8c899ea6, Offset: 0xad7
// Size: 0x187
function function_733a5fb72fe42b61()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( self.plane_crash_point.script_noteworthy != "fixed_path" )
    {
        function_b38782647b7eaddc();
    }
    
    /#
        var_e0ae6bd438beff3d = getdvarint( @"hash_ebc816184b9b695a", 0 );
        var_c90ab5351dd6ffe7 = getdvarint( @"hash_fcdb122301842b74", 0 );
        
        if ( var_e0ae6bd438beff3d )
        {
            level.players[ 0 ] setorigin( self.plane_start_point.origin );
            level.players[ 0 ] setplayerangles( self.plane_start_point.angles );
        }
        
        if ( var_c90ab5351dd6ffe7 )
        {
            return;
        }
    #/
    
    plane = function_245cd68471b30a68( self.plane_start_point.origin, self.plane_start_point.angles );
    distance = distance( self.plane_start_point.origin, self.var_636c6f3137e2110c.origin );
    duration = distance / 3000;
    plane moveto( self.var_636c6f3137e2110c.origin, duration );
    plane rotateto( self.var_636c6f3137e2110c.angles, duration * 0.2 );
    thread function_6ec6ac8061dcdb07( duration );
    wait duration;
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x2170986b, Offset: 0xc66
// Size: 0x7d
function crash_sites_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    thread function_7bc15dd9350dfc4f();
    
    if ( self.intro_type == 1 )
    {
        function_313c478a8827aa4();
        function_79aea9a0cbc826d0();
    }
    else
    {
        function_733a5fb72fe42b61();
        function_79aea9a0cbc826d0();
    }
    
    spawn_plane_debris();
    function_5759e71418be3744();
    thread spawn_reinforcements();
    wait 2;
    spawn_black_box();
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0xa100b47a, Offset: 0xceb
// Size: 0xc
function crash_sites_end( activity_succeeded )
{
    
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0xe35d86e6, Offset: 0xcff
// Size: 0x138
function crash_sites_destroy()
{
    if ( isdefined( self.plane ) )
    {
        self.plane delete();
    }
    
    if ( isdefined( self.var_412186bac78091ce ) )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.var_412186bac78091ce );
        ob_activity_utility::ob_disable_cover_nodes();
    }
    
    if ( isdefined( self.black_box ) )
    {
        self.black_box delete();
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger = undefined;
    }
    
    foreach ( point in self.agent_rally_points )
    {
        point.activated = undefined;
    }
    
    if ( isdefined( self.var_8fa5d7b8e1641aad ) )
    {
        self.var_8fa5d7b8e1641aad delete();
    }
    
    if ( isdefined( self.var_5aef5707d9872179 ) )
    {
        self.var_5aef5707d9872179 kill();
    }
    
    radio_data_cleanup();
    namespace_d7fa4530141146a5::function_501e44ea1cb9219d( get_objid() );
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x412b8b66, Offset: 0xe3f
// Size: 0x123
function radio_data_cleanup()
{
    if ( isdefined( self.radio_data ) )
    {
        if ( isdefined( self.radio_data.volume ) )
        {
            self.radio_data.volume notify( #"exit" );
            self.radio_data.volume.radio_data = undefined;
            self.radio_data.volume = undefined;
        }
        
        foreach ( player in level.players )
        {
            if ( player.radio_signal.active_entity == self.radio_data.entitynum )
            {
                player signal_detected::radio_signal_close();
            }
        }
        
        self.radio_data = undefined;
    }
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x9d268f2f, Offset: 0xf6a
// Size: 0xb3
function function_156b36e77af03dcf( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    capturetime = self.var_c61a2284c5526ca0 ?? 120;
    startingprogress = self.progress ?? 0;
    progress = startingprogress / capturetime;
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, int( round( progress * 100 ) ), 100 );
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( additional_spawn_data.var_d9274cd4b9b9a361 )
    {
        activity_definition_utils::function_4978eb24baa84155( self );
    }
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0xda764f4c, Offset: 0x1025
// Size: 0x51
function function_a0dfbfb33c31b5a( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( !isdefined( self.progress ) )
    {
        return;
    }
    
    if ( activity_instance_common::getactivitystate( self ) == "Ended" )
    {
        return;
    }
    
    ob_activity_utility::function_894ac80e038636c5( "wcacrashsitefail", player_list );
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0xb835292f, Offset: 0x107e
// Size: 0x2c
function function_51bd85635fe3e31c( relevantinfostruct )
{
    player_list = relevantinfostruct.playerlist;
    thread function_3da9adadb5a4d418( player_list );
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x54abf830, Offset: 0x10b2
// Size: 0x4cd
function function_79aea9a0cbc826d0()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_e0ae6bd438beff3d = getdvarint( @"hash_ebc816184b9b695a", 0 );
    plane = self.plane;
    
    if ( self.var_b1b6dfe35fc16b0a == 1 )
    {
        plane setscriptablepartstate( #"engine_blowout", #"on" );
        plane setscriptablepartstate( #"body_damage_heavy", #"on" );
        plane setscriptablepartstate( #"fake_flares_2", #"on" );
        plane setscriptablepartstate( #"fake_missile_expl_2", #"on", 0 );
    }
    else
    {
        plane setscriptablepartstate( #"body_damage_heavy", #"on" );
        plane setscriptablepartstate( #"explode", #"air_explode" );
    }
    
    plane.stalled = 1;
    calloutmarkerping::function_6052d1ed5729bcfc( plane );
    var_e1a7544e4b843749 = undefined;
    
    if ( is_contract() )
    {
        var_e1a7544e4b843749 = self.playerparticipants;
    }
    else
    {
        var_e1a7544e4b843749 = spatial_zone_container::function_84f653d797112085( self, "Awareness_Zone" );
    }
    
    thread function_3da9adadb5a4d418( var_e1a7544e4b843749, 0.5 );
    
    if ( self.intro_type == 1 )
    {
        plane setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"stall_hover" );
        var_6307f3135fb43d7a = getplayersinradius( self.plane_crash_point.origin, self.var_cdc0e4d6d9288be8 ?? 5000 );
        
        foreach ( player in var_6307f3135fb43d7a )
        {
            player earthquakeforplayer( 0.25, 1, player.origin, 100 );
        }
        
        plane simulate_crash();
        var_21deb31b700c05c3 = getplayersinradius( self.plane_crash_point.origin, 1500 );
        
        foreach ( player in var_21deb31b700c05c3 )
        {
            if ( utility::within_fov( player geteye(), player getplayerangles(), self.plane_crash_point.origin, 0.34202 ) )
            {
                pbgpostfxbundlestart( player, %"sat_ob_activity_crash_site_blast_whiteout" );
            }
        }
        
        if ( is_contract() )
        {
            thread ob_activity_utility::function_894ac80e038636c5( "wcpveheistcrashsitelocation", undefined, undefined, 1 );
        }
    }
    else
    {
        plane setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"stall" );
        distance = distance( self.var_636c6f3137e2110c.origin, self.plane_crash_point.origin );
        duration = min( distance / 6000, 4 );
        thread function_b4bead755a593f4d( duration );
        plane moveto( self.plane_crash_point.origin, duration );
        plane rotateto( self.plane_crash_point.angles, duration * 0.2 );
        plane thread function_aa974090546edf9f( duration * 0.2 );
        plane waittill( #"movedone" );
    }
    
    self notify( #"plane_crashed" );
    radiusdamage( self.plane_crash_point.origin, 1000, 150, 100, plane, "MOD_TRIGGER_HURT" );
    plane setscriptablepartstate( #"explode", #"ground_crash" );
    plane setscriptablepartstate( #"hash_c62470ae8c9fe1d0", #"off" );
    earthquakeadvanced( 0.5, 0.1, 0.02, 1.6, self.plane_crash_point.origin, 2000, 4000, 20000 );
    self.var_84f2e30d5ec9e9ce = plane.var_d26c6dba74c8a179;
    self.var_90f46749b6388acb = arrayremoveduplicates( arraycombine( self.var_90f46749b6388acb, self.var_84f2e30d5ec9e9ce ) );
    plane utility::delaycall( 0.5, &delete );
    self.plane = undefined;
    
    /#
        if ( var_e0ae6bd438beff3d )
        {
            wait 1;
            activity_instance_common::endactivity( self, 1 );
        }
    #/
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0xb4ac913f, Offset: 0x1587
// Size: 0x292
function simulate_hover()
{
    plane = self;
    plane.pitch = 0;
    plane.yaw = 90;
    plane.roll = -30;
    plane.angles = ( plane.pitch, plane.yaw, plane.roll );
    delta_time = level.framedurationseconds * 2;
    step_count = 0;
    plane.var_7312079fd1262be9 = 10;
    plane.theta = 0;
    
    while ( true )
    {
        step_count++;
        time_passed = delta_time * step_count;
        plane.theta = plane.var_7312079fd1262be9 * time_passed;
        x = plane.var_5de21a10a873b53b * cos( plane.theta );
        y = plane.var_5de21a10a873b53b * sin( plane.theta );
        new_pos = plane.hover_center + ( x, y, 0 );
        angle = vectortoangles( new_pos - plane.origin );
        plane moveto( new_pos, delta_time );
        plane.pitch = angle[ 0 ];
        plane.yaw = angle[ 1 ];
        plane rotateto( ( plane.pitch, plane.yaw, plane.roll ), delta_time );
        end_time = gettime() + delta_time * 1000;
        wait delta_time;
        
        /#
            if ( getdvarint( @"hash_d254ff16db6eb758", 0 ) )
            {
                debugstar( plane.origin, ( 0, 1, 0 ), 1000, "<dev string:x5b>", 1 );
            }
        #/
        
        if ( plane utility::ent_flag( "plane_begin_crash" ) )
        {
            if ( distance( plane.origin, new_pos ) > 100 )
            {
                waitframe();
            }
            
            /#
                if ( getdvarint( @"hash_d254ff16db6eb758", 0 ) )
                {
                    debugstar( plane.origin, ( 1, 0, 0 ), 1000, "<dev string:x5c>", 1 );
                    debugstar( new_pos, ( 0, 1, 0 ), 1000, "<dev string:x66>" + distance( new_pos, plane.origin ), 1 );
                }
            #/
            
            break;
        }
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x19528854, Offset: 0x1821
// Size: 0x28f
function simulate_crash()
{
    plane = self;
    var_6742ddc637543391 = -150;
    gravity = getdvarfloat( @"bg_gravity", 800 ) + var_6742ddc637543391;
    var_b6edcb4eab2f8687 = plane.hover_center[ 2 ] - utility::groundpos( plane.hover_center )[ 2 ];
    var_2eba1be0e1d69cf5 = sqrt( 2 * var_b6edcb4eab2f8687 / gravity );
    radial_speed = plane.var_5de21a10a873b53b / var_2eba1be0e1d69cf5;
    delta_time = 0.1;
    step_count = 0;
    delta_roll = 3;
    roll_offset = 0;
    var_1716966c7c41ed6c = 23;
    accel_duration = 0.5;
    
    while ( true )
    {
        step_count++;
        time_passed = delta_time * step_count;
        
        if ( time_passed > var_2eba1be0e1d69cf5 )
        {
            break;
        }
        
        delta_omega = math::lerp( plane.var_7312079fd1262be9, var_1716966c7c41ed6c, min( 1, time_passed / accel_duration ) );
        plane.theta += delta_omega * delta_time;
        roll_offset += delta_roll;
        roll_offset %= 360;
        r1 = plane.var_5de21a10a873b53b - radial_speed * time_passed;
        x = r1 * cos( plane.theta );
        y = r1 * sin( plane.theta );
        h = -0.5 * gravity * squared( time_passed );
        new_pos = plane.hover_center + ( x, y, h );
        angle = vectortoangles( new_pos - plane.origin );
        plane.pitch = angle[ 0 ];
        plane.yaw = angle[ 1 ];
        
        /#
            if ( getdvarint( @"hash_d254ff16db6eb758", 0 ) )
            {
                debugstar( new_pos, ( 1, 0, 0 ), 1000, r1 + "<dev string:x7e>" + h + "<dev string:x82>" + delta_omega, 1 );
            }
        #/
        
        plane rotateto( ( plane.pitch, plane.yaw, plane.roll - roll_offset ), delta_time );
        plane moveto( new_pos, delta_time );
        wait delta_time;
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x6e09c35b, Offset: 0x1ab8
// Size: 0x2ef
function function_b38782647b7eaddc()
{
    anchor = spatial_zone_container::function_84f653d797112085( self, "Awareness_Zone" )[ 0 ];
    
    if ( !isdefined( anchor ) )
    {
        anchor = spawnstruct();
        anchor.origin = self.plane_crash_point.origin;
        anchor.angles = ( 0, 0, 0 );
    }
    
    assert( -1 );
    angle_random_offset = randomintrange( -30, 30 );
    start_origin_xy = self.plane_crash_point.origin + anglestoforward( ( 0, anchor.angles[ 1 ] + angle_random_offset, 0 ) ) * 25000;
    start_origin = ( start_origin_xy[ 0 ], start_origin_xy[ 1 ], 10000 );
    start_angles = ( 0, vectortoangles( self.plane_crash_point.origin - start_origin )[ 1 ], 0 );
    plane_path_distance = distance2d( self.plane_crash_point.origin, start_origin );
    var_5b2693de1d489ab = start_origin + anglestoforward( start_angles ) * plane_path_distance * 0.4;
    stall_origin = ( var_5b2693de1d489ab[ 0 ], var_5b2693de1d489ab[ 1 ], 10000 );
    stall_angles = start_angles;
    
    /#
        if ( getdvarint( @"hash_b283d8c785bb02ba", 0 ) && getdvarint( @"hash_ebc816184b9b695a", 0 ) )
        {
            debug_obstacle = function_66a6fbfd1bd854c5( start_origin, stall_origin, start_angles, stall_angles, self.plane_crash_point.origin );
        }
    #/
    
    traceresult_1 = trace::ray_trace( start_origin, stall_origin );
    traceresult_2 = trace::ray_trace( stall_origin, self.plane_crash_point.origin );
    
    /#
        if ( getdvarint( @"hash_ebc816184b9b695a", 0 ) )
        {
            thread function_65f4880edbc34f57( start_origin, stall_origin, self.plane_crash_point.origin, traceresult_1, traceresult_2, anchor );
        }
    #/
    
    if ( traceresult_1[ "hittype" ] != "hittype_none" || traceresult_2[ "hittype" ] != "hittype_none" )
    {
        iprintlnbold( "Something is stucking on the path of crash site, fall back to default route! " );
        return;
    }
    
    self.plane_start_point = spawnstruct();
    self.plane_start_point.origin = start_origin;
    self.plane_start_point.angles = start_angles;
    self.var_636c6f3137e2110c = spawnstruct();
    self.var_636c6f3137e2110c.origin = stall_origin;
    self.var_636c6f3137e2110c.angles = stall_angles;
    self.plane_crash_point.angles = vectortoangles( self.plane_crash_point.origin - self.var_636c6f3137e2110c.origin );
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x9bc8b47a, Offset: 0x1daf
// Size: 0x1a3
function function_b4bead755a593f4d( duration )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_6307f3135fb43d7a = spatial_zone_container::function_84f653d797112085( self, "Awareness_Zone" );
    
    foreach ( player in var_6307f3135fb43d7a )
    {
        player earthquakeforplayer( 0.25, 1, player.origin, 100 );
    }
    
    if ( duration > 0.3 )
    {
        wait duration - 0.3;
    }
    
    var_21deb31b700c05c3 = getplayersinradius( self.plane_crash_point.origin, 1500 );
    
    foreach ( player in var_21deb31b700c05c3 )
    {
        if ( utility::within_fov( player geteye(), player getplayerangles(), self.plane_crash_point.origin, 0.34202 ) )
        {
            pbgpostfxbundlestart( player, %"sat_ob_activity_crash_site_blast_whiteout" );
        }
    }
    
    thread ob_activity_utility::function_894ac80e038636c5( "wcacrashsitebriefcrash", var_6307f3135fb43d7a, undefined, 2 );
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x6fe3ef8e, Offset: 0x1f5a
// Size: 0xa9
function function_6ec6ac8061dcdb07( duration )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_f009247611af2ae3 = ob_activity_utility::get_conversation_cooldown_time( "wcacrashsitebrief" + "_karma" );
    var_1509ad545aacc7a9 = ob_activity_utility::get_conversation_cooldown_time( "wcacrashsitebrief" + "_marshall" );
    var_30f857742d7d5a97 = max( var_f009247611af2ae3, var_1509ad545aacc7a9 );
    wait_time = duration - var_30f857742d7d5a97;
    
    if ( wait_time > 0 )
    {
        wait wait_time;
    }
    
    var_6307f3135fb43d7a = spatial_zone_container::function_84f653d797112085( self, "Awareness_Zone" );
    ob_activity_utility::function_894ac80e038636c5( "wcacrashsitebrief", var_6307f3135fb43d7a );
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x4429406, Offset: 0x200b
// Size: 0x31
function function_aa974090546edf9f( delay )
{
    self endon( #"movedone" );
    wait delay;
    
    while ( true )
    {
        self rotateroll( 360, 5 );
        wait 5;
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x25f73471, Offset: 0x2044
// Size: 0x236
function spawn_plane_debris()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( self.var_412186bac78091ce ) )
    {
        self.var_412186bac78091ce = [];
    }
    
    var_7d61048eb831bd93 = "cover_" + self.varianttag;
    
    if ( activity_instance_common::getactivitytype( self ) == "REV_OB_HEIST" )
    {
        var_7d61048eb831bd93 = "cover_" + self.var_77dc5b8c6d44554d;
    }
    
    self.var_412186bac78091ce = ob_soldier_util::function_a315cc5d1dee425a( var_7d61048eb831bd93 );
    
    while ( true )
    {
        var_da239ba8862f0d74 = 0;
        
        foreach ( cover in self.var_412186bac78091ce )
        {
            if ( !isdefined( cover.scriptables ) )
            {
                continue;
            }
            
            var_da239ba8862f0d74++;
        }
        
        if ( var_da239ba8862f0d74 == self.var_412186bac78091ce.size )
        {
            break;
        }
        
        waitframe();
    }
    
    foreach ( cover in self.var_412186bac78091ce )
    {
        foreach ( scriptable in cover.scriptables )
        {
            if ( scriptable getscriptablehaspart( #"vfx" ) )
            {
                scriptable setscriptablepartstate( #"vfx", #"on" );
            }
        }
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x5c0174c8, Offset: 0x2282
// Size: 0x5e
function function_5759e71418be3744()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( isdefined( self.var_412186bac78091ce ) )
    {
        cover_name = undefined;
        
        if ( activity_instance_common::getactivitytype( self ) == "REV_OB_HEIST" )
        {
            cover_name = "covernode_" + self.var_77dc5b8c6d44554d;
        }
        
        ob_activity_utility::ob_enable_cover_nodes( cover_name );
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x2a9178aa, Offset: 0x22e8
// Size: 0x46e
function spawn_black_box()
{
    self.black_box = ob_resource_manager::activity_spawn_entity( "script_model", self.black_box_struct.origin );
    self.black_box setmodel( %"sat_machinery_black_box_flight_recorder_hackable" );
    self.black_box.angles = self.black_box_struct.angles;
    black_box_scriptable = self.black_box getlinkedscriptableinstance();
    black_box_scriptable interaction::set_interact_hint_callback( &function_9de9eface79d799e );
    self.black_box.activity_instance = self;
    self.black_box utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_crash_site_black_box" );
    
    if ( !is_contract() )
    {
        create_objective_marker( "ob_crash_site_marker", 0, 0 );
        hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_sat_ob_crash_site_objective_marker" );
        objidpoolmanager::function_1a27e9b999215f16( self.objidnum, hovercardid );
        objidpoolmanager::update_objective_position( get_objid(), self.plane_crash_point.origin );
        objidpoolmanager::update_objective_state( get_objid(), "active" );
    }
    
    thread function_f9158ce149316d54();
    self.agent_rally_points = [];
    self.dawg_spawn_points = [];
    black_box_structs = utility::getstructarray( self.black_box_struct.target, "targetname" );
    
    foreach ( struct in black_box_structs )
    {
        if ( struct.script_noteworthy == "agent_rally_point" )
        {
            self.agent_rally_points[ self.agent_rally_points.size ] = struct;
            continue;
        }
        
        if ( struct.script_noteworthy == "dawg_spawn" )
        {
            self.dawg_spawn_points[ self.dawg_spawn_points.size ] = struct;
        }
    }
    
    if ( self.dawg_spawn_points.size == 0 )
    {
        self.dawg_spawn_points[ self.dawg_spawn_points.size ] = self.agent_rally_points[ 0 ];
    }
    
    self.trigger = getnoentvolumearray( self.black_box_struct.target, #targetname )[ 0 ];
    assert( isdefined( self.trigger ), "<dev string:x86>" + "<dev string:xaf>" );
    self.var_f740f38664dfa9fe = self.trigger.struct.radius ?? 250;
    thread function_8d5c99c522d880d2();
    var_286e7d6a5be684cd = undefined;
    
    if ( is_contract() )
    {
        var_286e7d6a5be684cd = self.playerparticipants;
    }
    
    self.radio_data = { #totaldistance:self.trigger.struct.radius ?? 0, #var_286e7d6a5be684cd:var_286e7d6a5be684cd, #paramname:"crash_site", #pauseintro:1, #y_pos:80, #x_pos:0, #entitynum:self.black_box getentitynumber(), #registered_players:[], #volume:self.trigger };
    self.trigger.radio_data = self.radio_data;
    self.trigger thread signal_detected::function_8a1ab9c1bb59bbd3();
    waitframe();
    
    foreach ( player in self.var_84f2e30d5ec9e9ce )
    {
        player calloutmarkerping::function_5d7b7302e94b97c2( get_objid(), self.plane_crash_point.origin );
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0xb1d53911, Offset: 0x275e
// Size: 0x2f0
function function_f9158ce149316d54()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_d7c3b5a96a7ecbe0 = [];
    var_e70fca0ab3f0d97 = [];
    
    while ( true )
    {
        if ( isdefined( self.progress ) )
        {
            break;
        }
        
        if ( is_contract() )
        {
            players_array = [];
            
            foreach ( player in self.playerparticipants )
            {
                if ( distancesquared( player.origin, self.plane_crash_point.origin ) <= squared( 2000 ) && !arraycontains( var_d7c3b5a96a7ecbe0, player ) )
                {
                    players_array[ players_array.size ] = player;
                }
            }
        }
        else
        {
            players_array = getplayersinradius( self.plane_crash_point.origin, 2000, undefined, undefined, var_d7c3b5a96a7ecbe0 );
        }
        
        if ( players_array.size )
        {
            obj_marker_offset = ( 0, 0, 0 );
            
            if ( is_contract() )
            {
                objidpoolmanager::update_objective_description( get_objid(), &"sat_ob_activities/objective_black_box" );
                obj_marker_offset = ( 0, 0, 35 );
            }
            
            objidpoolmanager::update_objective_position( get_objid(), self.black_box.origin + obj_marker_offset );
        }
        
        foreach ( player in players_array )
        {
            var_d7c3b5a96a7ecbe0[ var_d7c3b5a96a7ecbe0.size ] = player;
        }
        
        foreach ( player in var_d7c3b5a96a7ecbe0 )
        {
            if ( arraycontains( var_e70fca0ab3f0d97, player ) )
            {
                continue;
            }
            
            if ( distance2dsquared( player.origin, self.black_box.origin ) <= 62500 && utility::within_fov( player.origin, player.angles, self.black_box.origin, 0.819152 ) )
            {
                ob_activity_utility::function_894ac80e038636c5( "wcacrashsitehack", [ player ] );
                var_e70fca0ab3f0d97[ var_e70fca0ab3f0d97.size ] = player;
            }
        }
        
        wait 0.2;
    }
}

// Namespace ob_activity_crash_sites
// Params 2
// Checksum 0x6ee4c11e, Offset: 0x2a56
// Size: 0x1e
function black_hat_hack_finished( hack_effect, attacker )
{
    black_box_hacked( attacker );
}

// Namespace ob_activity_crash_sites
// Params 6
// Checksum 0x322403de, Offset: 0x2a7c
// Size: 0x43
function function_c2e57268652c4dcc( instance, part, state, player, bautouse, usestring )
{
    instance thread function_813f95ba9eadc03a( player );
}

// Namespace ob_activity_crash_sites
// Params 1, eflags: 0x4
// Checksum 0x7a97f309, Offset: 0x2ac7
// Size: 0x74
function private function_813f95ba9eadc03a( player )
{
    if ( !is_valid_player( player ) )
    {
        return;
    }
    
    if ( self.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, self, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        self.entity black_box_hacked( player );
    }
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x293c489a, Offset: 0x2b43
// Size: 0x19f
function black_box_hacked( player )
{
    utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
    self setscriptablepartstate( #"crash_sites_blackbox", #"unusable_hackable" );
    
    if ( !is_contract() )
    {
        activity_participation::function_bc67362dace4370c( self.activity_instance, player, "PlayerJoinedInteract" );
    }
    
    foreach ( cover in self.activity_instance.var_412186bac78091ce )
    {
        foreach ( scriptable in cover.scriptables )
        {
            if ( scriptable getscriptablehaspart( #"vfx" ) )
            {
                scriptable setscriptablepartstate( #"vfx", #"off" );
            }
        }
    }
    
    self.activity_instance.trigger thread signal_detected::function_2a42495ec4a0ee34();
    self.activity_instance function_b6f424b8718a681a( player );
}

// Namespace ob_activity_crash_sites
// Params 2
// Checksum 0x28f65a01, Offset: 0x2cea
// Size: 0xd2
function function_9de9eface79d799e( usable, player )
{
    if ( !is_valid_player( player ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( usable.var_1674515c4a4c0655.size )
    {
        if ( arraycontains( usable.var_1674515c4a4c0655, player ) )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return { #string:&"sat_ob_activities/interaction_hacking_in_progress", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #string:&"sat_ob_activities/activity_black_box_decrypt", #type:"HINT_NOICON" };
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0xb3d595f6, Offset: 0x2dc4
// Size: 0x142
function spawn_reinforcements()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    /#
        if ( getdvarint( @"hash_ebc816184b9b695a", 0 ) )
        {
            return;
        }
    #/
    
    while ( !isdefined( self.progress ) )
    {
        wait 0.2;
    }
    
    for ( i = 0; i < self.agent_rally_points.size ; i++ )
    {
        self.agent_rally_points[ i ].index = i;
        encounterid = function_6564b9cdaa4b3891( self.agent_rally_points[ i ], i );
        thread function_5e079998ffbff4c9( encounterid );
    }
    
    while ( true )
    {
        wait 0.2;
        
        foreach ( point in self.agent_rally_points )
        {
            if ( !point.var_19e17d0d772faec9 )
            {
            }
        }
        
        wait 1;
        break;
    }
    
    thread spawn_handler();
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0xfc2a82a7, Offset: 0x2f0e
// Size: 0x12c
function spawn_handler()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_9bf264b4d485a79e = 0;
    
    while ( true )
    {
        wait 0.2;
        
        if ( self.var_806246e93a8ce20e == 1 )
        {
            continue;
        }
        
        if ( self.var_9bf264b4d485a79e == 0 )
        {
            self.var_9bf264b4d485a79e = 1;
            function_45fd3640c03678ad( 1 );
            
            /#
                iprintlnbold( "<dev string:xdc>" );
            #/
            
            continue;
        }
        
        if ( self.var_9bf264b4d485a79e == 1 && self.progress / self.var_c61a2284c5526ca0 >= 0.25 )
        {
            self.var_9bf264b4d485a79e = 2;
            function_45fd3640c03678ad( 2 );
            
            /#
                iprintlnbold( "<dev string:x112>" );
            #/
            
            continue;
        }
        
        if ( self.var_9bf264b4d485a79e == 2 && self.progress / self.var_c61a2284c5526ca0 >= 0.66 )
        {
            self.var_9bf264b4d485a79e = 3;
            function_45fd3640c03678ad( 3 );
            
            /#
                iprintlnbold( "<dev string:x149>" );
            #/
            
            if ( self.difficulty_region != "difficulty_easy" )
            {
                thread spawn_dawg();
            }
        }
    }
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0xf514afa2, Offset: 0x3042
// Size: 0x232
function function_45fd3640c03678ad( reinforcement_count )
{
    assert( reinforcement_count >= 0 );
    var_31b51be5910b3b05 = undefined;
    pool = [];
    activated_pool = [];
    
    foreach ( point in self.agent_rally_points )
    {
        if ( !point.activated )
        {
            pool[ pool.size ] = point;
            continue;
        }
        
        activated_pool[ activated_pool.size ] = point;
    }
    
    if ( pool.size < reinforcement_count )
    {
        activated_pool = arrayrandomize( activated_pool );
        
        foreach ( point in activated_pool )
        {
            if ( pool.size >= reinforcement_count )
            {
                break;
            }
            
            pool[ pool.size ] = point;
        }
    }
    else if ( pool.size > reinforcement_count )
    {
        pool = utility::array_slice_random( pool, pool.size - reinforcement_count );
    }
    
    reinforcement_vo_alias = "wcacrashsiterein";
    var_fdfa1260c5621977 = 0;
    
    foreach ( point in pool )
    {
        point.activated = 1;
        self notify( "call_reinforcements_" + point.index );
        
        if ( point.script_label == "parachute_reinforcement" )
        {
            var_fdfa1260c5621977++;
        }
    }
    
    if ( var_fdfa1260c5621977 == pool.size )
    {
        reinforcement_vo_alias = "wcacrashsitereinparachute";
    }
    
    ob_activity_utility::function_894ac80e038636c5( reinforcement_vo_alias );
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0xafac9652, Offset: 0x327c
// Size: 0x199
function function_5e079998ffbff4c9( encounter )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        level waittill( "ai_encounter_despawning_" + encounter );
        self.var_806246e93a8ce20e = 1;
        
        while ( true )
        {
            self.trigger waittill( #"trigger", ent );
            
            if ( !isplayer( ent ) && !ent vehicle::is_vehicle() )
            {
                continue;
            }
            
            if ( ent vehicle::is_vehicle() )
            {
                hasplayer = 0;
                occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
                
                foreach ( occupant in occupants )
                {
                    if ( isplayer( occupant ) )
                    {
                        hasplayer = 1;
                        break;
                    }
                }
                
                if ( !hasplayer )
                {
                    continue;
                }
            }
            
            break;
        }
        
        if ( self.progress / self.var_c61a2284c5526ca0 < 0.25 )
        {
            self.var_9bf264b4d485a79e = 0;
        }
        else if ( self.progress / self.var_c61a2284c5526ca0 < 0.66 )
        {
            self.var_9bf264b4d485a79e = 1;
        }
        else
        {
            self.var_9bf264b4d485a79e = 2;
        }
        
        self.var_806246e93a8ce20e = undefined;
    }
}

// Namespace ob_activity_crash_sites
// Params 4
// Checksum 0x3ef606eb, Offset: 0x341d
// Size: 0x19d
function function_2354393a21d9c194( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity = userdata[ 0 ];
    rally_point = userdata[ 1 ];
    
    if ( isalive( agent ) )
    {
        agent.activity_instance = activity;
        
        if ( isdefined( activity.defence_agent_array ) )
        {
            activity.defence_agent_array[ activity.defence_agent_array.size ] = agent;
        }
        
        patrol_nodes = utility::getstructarray( rally_point.target, "targetname" );
        
        if ( isdefined( patrol_nodes ) && patrol_nodes.size > 0 )
        {
            foreach ( node in patrol_nodes )
            {
                if ( !isalive( node.agent ) )
                {
                    node.agent = agent;
                    
                    if ( !isdefined( level.default_goalradius ) )
                    {
                        level.default_goalradius = 600;
                    }
                    
                    agent callback::add( #"on_ai_killed", &function_77d578397074be8b, node );
                    agent thread ai_utility::go_to_node( node );
                    break;
                }
            }
            
            return;
        }
        
        agent ob_activity_utility::function_311417deee5b4c1c();
        agent thread function_1eb9836e4ba6c634( activity );
    }
}

// Namespace ob_activity_crash_sites
// Params 2
// Checksum 0x1e768b8c, Offset: 0x35c2
// Size: 0x20
function function_77d578397074be8b( death_param, node )
{
    node.agent = undefined;
}

// Namespace ob_activity_crash_sites
// Params 4
// Checksum 0xb7108f29, Offset: 0x35ea
// Size: 0x85
function function_5a090e45975338de( requestid, userdata, vehicle, data )
{
    activity_instance = userdata[ 0 ];
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    point = userdata[ 1 ];
    point.reinforcement_heli = vehicle;
    vehicle waittill( #"death" );
    point.reinforcement_heli = undefined;
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x9e2d8b1f, Offset: 0x3677
// Size: 0x2b
function function_b6f424b8718a681a( player )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    thread function_b717c596186f1ab7();
}

// Namespace ob_activity_crash_sites
// Params 2
// Checksum 0x60483e4, Offset: 0x36aa
// Size: 0x141
function function_6564b9cdaa4b3891( point, id )
{
    if ( !isdefined( point.radius ) )
    {
        point.radius = 500;
    }
    
    if ( isdefined( point.target ) )
    {
        encounterid = activity_ai_encounters::function_92b671064b0b1ce2( point.target, 1, 1, 1, 1 );
    }
    else
    {
        encounter_name = "ai_encounter:enc_ob_crash_site_heli_guards";
        
        if ( activity_instance_common::getactivitytype( self ) == "REV_OB_HEIST" )
        {
            encounter_name = "ai_encounter:enc_ob_heist_vtol_reinforcement";
        }
        
        encounterid = activity_ai_encounters::function_eb8506829193f5eb( encounter_name, point.origin, point.radius, 1, 1, 1, 2 );
    }
    
    if ( isdefined( encounterid ) )
    {
        ai_spawn_director::add_vehicle_spawned_callback( encounterid, &function_5a090e45975338de, [ self, point ] );
        ai_spawn_director::function_baa5d26d8804d5da( encounterid, &function_2354393a21d9c194, [ self, point ] );
        ai_spawn_director::function_ee0b7976619e1cb8( encounterid, &function_2354393a21d9c194, [ self, point ] );
        ai_spawn_director::function_c99d360d62c49a9c( encounterid, &function_de2179dfa5ddab4a, [ self, point, id ] );
        ai_spawn_director::function_53289c032f506bb1( encounterid, &function_21892c3b4d060b85, [ self ] );
    }
    
    return encounterid;
}

// Namespace ob_activity_crash_sites
// Params 4
// Checksum 0x7d46ee1b, Offset: 0x37f4
// Size: 0xba, Type: bool
function function_de2179dfa5ddab4a( requestid, userdata, agent, data )
{
    activity_instance = userdata[ 0 ];
    point = userdata[ 1 ];
    id = userdata[ 2 ];
    
    if ( !point.var_19e17d0d772faec9 )
    {
        point.var_19e17d0d772faec9 = 1;
    }
    
    activity_instance waittill( "call_reinforcements_" + id );
    
    if ( isdefined( point.reinforcement_heli ) )
    {
        point.reinforcement_heli vehicle_ai::delete_riders();
        point.reinforcement_heli delete();
        point.reinforcement_heli = undefined;
    }
    
    return true;
}

// Namespace ob_activity_crash_sites
// Params 4
// Checksum 0x61fa25ca, Offset: 0x38b7
// Size: 0x3a, Type: bool
function function_21892c3b4d060b85( requestid, userdata, agent, data )
{
    return userdata[ 0 ].state != "Active";
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x645f41e9, Offset: 0x38fa
// Size: 0xa2
function function_1eb9836e4ba6c634( activity )
{
    self endon( #"death" );
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    self setstealthstate( "combat" );
    
    if ( self.nearbyplayers.size > 0 )
    {
        var_95b86e61b2c6a7 = utility::array_random( self.nearbyplayers );
        self getenemyinfo( var_95b86e61b2c6a7 );
        self.favoriteenemy = var_95b86e61b2c6a7;
        self forcethreatupdate();
    }
    
    thread ai_behavior::behavior_combatRushOrigin( self, activity.black_box_struct.origin, 128, 512 );
}

// Namespace ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0xf9fbe26d, Offset: 0x39a4
// Size: 0xcb
function private function_8d5c99c522d880d2()
{
    level endon( #"game_ended" );
    self endon( #"hash_4c4ba1370b04f55f" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.nearbyplayers = [];
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.nearbyplayers, player ) || !is_valid_player( player ) )
        {
            continue;
        }
        
        self.nearbyplayers[ self.nearbyplayers.size ] = player;
        childthread function_e91f05f198e5294e( player );
        
        if ( !is_contract() )
        {
            activity_participation::function_bc67362dace4370c( self, player, "PlayerJoinedProximity" );
        }
    }
}

// Namespace ob_activity_crash_sites
// Params 1, eflags: 0x4
// Checksum 0x4130fe9c, Offset: 0x3a77
// Size: 0x57
function private function_e91f05f198e5294e( player )
{
    while ( isdefined( self.trigger ) && isalive( player ) && player istouching( self.trigger ) )
    {
        wait 0.2;
    }
    
    self.nearbyplayers = arrayremove( self.nearbyplayers, player );
}

// Namespace ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0xd9a27baa, Offset: 0x3ad6
// Size: 0x31e
function private function_b717c596186f1ab7()
{
    level endon( #"game_ended" );
    self endon( #"hash_4c4ba1370b04f55f" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.progress = 0.01;
    capturetime = self.var_c61a2284c5526ca0;
    progress = 0.01;
    self.positiveprogress = 0;
    
    while ( true )
    {
        if ( isdefined( self.trigger ) && !self.trigger.trigger_off )
        {
            if ( self.nearbyplayers.size > 0 && !self.progress_blocked )
            {
                if ( !self.positiveprogress )
                {
                    foreach ( player in self.nearbyplayers )
                    {
                        player playlocalsound( "sat_ob_activity_zone_captured" );
                    }
                    
                    self.black_box setscriptablepartstate( #"crash_sites_blackbox_hacking_effects", #"on_updating" );
                    self.positiveprogress = 1;
                }
                
                progressdelta = level.framedurationseconds;
                
                if ( isdefined( self.progress_update_scale ) )
                {
                    progressdelta *= self.progress_update_scale;
                }
                
                self.progress = min( capturetime, self.progress + progressdelta );
            }
            else
            {
                self.progress = max( 0, self.progress - level.framedurationseconds * 0.2 );
                
                if ( self.positiveprogress )
                {
                    players = getplayersinradius( self.black_box.origin, self.var_f740f38664dfa9fe * 2 );
                    
                    foreach ( player in players )
                    {
                        player playlocalsound( "sat_ob_activity_zone_lost" );
                    }
                    
                    self.black_box setscriptablepartstate( #"crash_sites_blackbox_hacking_effects", #"on" );
                    self.positiveprogress = 0;
                }
            }
            
            progress = self.progress / capturetime;
            
            if ( is_contract() )
            {
                namespace_b451b5202140ccde::setprogress( int( progress * 100 ), 100, self.playerparticipants );
            }
            else
            {
                activity_definition_utils::updateprogress( int( round( progress * 100 ) ), self );
            }
            
            if ( self.progress >= capturetime )
            {
                thread function_28ba6c35ac9a7730();
            }
            
            self.var_dd3e0f2e7ece8073 = self.positiveprogress;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0x30ddc121, Offset: 0x3dfc
// Size: 0x6d
function private function_28ba6c35ac9a7730()
{
    self.trigger = undefined;
    self notify( #"hash_4c4ba1370b04f55f" );
    radio_data_cleanup();
    self.black_box setscriptablepartstate( #"crash_sites_blackbox_hacking_effects", #"off" );
    
    if ( self.end_on_success )
    {
        ob_activity_utility::function_894ac80e038636c5( "wcacrashsitesuccess", undefined, undefined, undefined, undefined, &function_bafbf696e2949f1c );
        wait 1;
        activity_instance_common::endactivity( self, 1 );
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0xbcbb0ba9, Offset: 0x3e71
// Size: 0xb8
function spawn_gdu()
{
    gdu_landing_pos = self.agent_rally_points[ 0 ].origin;
    
    foreach ( point in self.agent_rally_points )
    {
        if ( point.activated )
        {
            gdu_landing_pos = point.origin;
            break;
        }
    }
    
    ground_drone_unit_mp::function_212cf2d1cbe3a717( gdu_landing_pos );
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0xf9950f1e, Offset: 0x3f31
// Size: 0xd9
function spawn_dawg()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    if ( isdefined( self.var_8fa5d7b8e1641aad ) )
    {
        return;
    }
    
    wait 5;
    dawg_landing_pos = utility::array_random( self.dawg_spawn_points ).origin;
    navmesh_pos = getclosestpointonnavmesh( dawg_landing_pos );
    var_8fa5d7b8e1641aad = ob_activity_utility::ob_create_trap_owner( self.black_box.origin );
    self.var_8fa5d7b8e1641aad = var_8fa5d7b8e1641aad;
    ob_activity_utility::function_ded5fcf7673a2ae6( var_8fa5d7b8e1641aad, navmesh_pos, vectortoangles( self.black_box.origin - navmesh_pos ) );
    
    while ( !var_8fa5d7b8e1641aad.dawg )
    {
        waitframe();
    }
    
    self.var_5aef5707d9872179 = var_8fa5d7b8e1641aad.dawg;
}

// Namespace ob_activity_crash_sites
// Params 1, eflags: 0x4
// Checksum 0xa1dd38fb, Offset: 0x4012
// Size: 0x8e
function private function_fc006770ab13cbd5( player )
{
    plane = self.plane;
    index = player calloutmarkerping::function_920a63c06abdefe8( plane getscriptableindex() );
    plane.var_d26c6dba74c8a179[ player getentitynumber() ] = player;
    plane.var_58cc57d664322d1d[ player getentitynumber() ] = index;
    
    if ( !isdefined( player.recordedpings ) )
    {
        player.recordedpings = [];
    }
    
    player.recordedpings[ index ] = plane;
}

// Namespace ob_activity_crash_sites
// Params 2, eflags: 0x4
// Checksum 0x71e2fb9f, Offset: 0x40a8
// Size: 0x13d
function private function_3da9adadb5a4d418( players, delay )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( !isdefined( self.var_90f46749b6388acb ) )
    {
        self.var_90f46749b6388acb = [];
    }
    
    if ( "Active" != activity_instance_common::getactivitystate( self ) )
    {
        return;
    }
    
    if ( !self.plane.stalled && !get_objid() || self.playerparticipants.size && !is_contract() )
    {
        return;
    }
    
    foreach ( player in players )
    {
        if ( arraycontains( self.var_90f46749b6388acb, player ) )
        {
            continue;
        }
        
        if ( self.plane )
        {
            function_fc006770ab13cbd5( player );
        }
        else
        {
            player calloutmarkerping::function_5d7b7302e94b97c2( get_objid() );
        }
        
        self.var_90f46749b6388acb[ self.var_90f46749b6388acb.size ] = player;
    }
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x37167d00, Offset: 0x41ed
// Size: 0xf2
function function_7bc15dd9350dfc4f()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    black_box_structs = utility::getstructarray( self.black_box_struct.target, "targetname" );
    
    foreach ( struct in black_box_structs )
    {
        if ( struct.script_noteworthy == "preexisting_guard_point" )
        {
            requestid = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:enc_ob_crash_site_preexisting_guards", struct.origin, struct.radius, 1, 1, 1, 1 );
        }
    }
}

// Namespace ob_activity_crash_sites
// Params 1
// Checksum 0x63d634e, Offset: 0x42e7
// Size: 0x37
function function_bafbf696e2949f1c( var_73f4f05f29c6770a )
{
    if ( var_73f4f05f29c6770a == "wcacrashsitesuccess_kagan" || var_73f4f05f29c6770a == "wcacrashsitesuccess_razor" )
    {
        return [ "wcacrashsiteclapback", "wcacrashsitelastword" ];
    }
}

// Namespace ob_activity_crash_sites
// Params 0, eflags: 0x4
// Checksum 0xaa9e8738, Offset: 0x4327
// Size: 0x11, Type: bool
function private is_contract()
{
    return self.category == "Contract";
}

// Namespace ob_activity_crash_sites
// Params 1, eflags: 0x4
// Checksum 0x62a19645, Offset: 0x4341
// Size: 0x28
function private is_valid_player( player )
{
    if ( !is_contract() )
    {
        return 1;
    }
    
    return arraycontains( self.playerparticipants, player );
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x60aca9ef, Offset: 0x4372
// Size: 0x4, Type: bool
function function_4eddd6fc9f54a1cf()
{
    return true;
}

// Namespace ob_activity_crash_sites
// Params 0
// Checksum 0x263e6d06, Offset: 0x437f
// Size: 0xb
function get_objid()
{
    return self.objidnum;
}

// Namespace ob_activity_crash_sites
// Params 3
// Checksum 0x66dc1d3e, Offset: 0x4393
// Size: 0x31
function create_objective_marker( bundlename, shouldpin, var_2cbc109c4db9ad8 )
{
    self.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( bundlename, shouldpin, var_2cbc109c4db9ad8 );
}

/#

    // Namespace ob_activity_crash_sites
    // Params 0
    // Checksum 0x83d2a419, Offset: 0x43cc
    // Size: 0x83, Type: dev
    function debug_awareness_zone()
    {
        activity_instance = self;
        activity_instance endon( #"activity_ended" );
        activity_instance endon( #"instance_destroyed" );
        var_7143aade745b1d91 = spatial_zone_container::function_f7fc3e6c249a8256( self, "<dev string:x189>" )[ 0 ];
        
        while ( true )
        {
            utility::draw_circle( var_7143aade745b1d91.origin, var_7143aade745b1d91.radius, ( 1, 0, 0 ), 1, 0, level.frameduration );
            waitframe();
        }
    }

    // Namespace ob_activity_crash_sites
    // Params 6
    // Checksum 0xdfff4e6b, Offset: 0x4457
    // Size: 0x17e, Type: dev
    function function_65f4880edbc34f57( start_origin, stall_origin, var_e20d44762428c094, var_5d833db940933159, var_3f340f8931b98936, anchor )
    {
        self notify( #"hash_f71228840229e948" );
        self endon( #"hash_f71228840229e948" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            debug_color = ( 0, 1, 0 );
            
            if ( var_5d833db940933159[ "<dev string:x198>" ] != "<dev string:x1a0>" && isdefined( var_5d833db940933159[ "<dev string:x1ad>" ] ) )
            {
                debug_color = ( 1, 0, 0 );
                sphere( var_5d833db940933159[ "<dev string:x1ad>" ], 50, debug_color, 0, level.frameduration );
            }
            
            if ( var_3f340f8931b98936[ "<dev string:x198>" ] != "<dev string:x1a0>" && isdefined( var_3f340f8931b98936[ "<dev string:x1ad>" ] ) )
            {
                debug_color = ( 1, 0, 0 );
                sphere( var_3f340f8931b98936[ "<dev string:x1ad>" ], 50, debug_color, 0, level.frameduration );
            }
            
            line( start_origin, stall_origin, debug_color, 1, 0, level.frameduration );
            line( stall_origin, var_e20d44762428c094, debug_color, 1, 0, level.frameduration );
            line( anchor.origin, anchor.origin + anglestoforward( anchor.angles ) * 300, ( 0, 0, 1 ), 1, 0, level.frameduration );
            waitframe();
        }
    }

    // Namespace ob_activity_crash_sites
    // Params 5
    // Checksum 0xb0fe4ad1, Offset: 0x45dd
    // Size: 0x97, Type: dev
    function function_66a6fbfd1bd854c5( start_origin, stall_origin, start_angles, stall_angles, var_e20d44762428c094 )
    {
        point_0 = stall_origin;
        point_1 = utility::array_random( [ start_origin, var_e20d44762428c094 ] );
        obstacle_origin = ( point_0 + point_1 ) / 2;
        obstacle = ob_resource_manager::activity_spawn_entity( "<dev string:x1b6>", obstacle_origin + ( 0, 0, -50 ) );
        return obstacle;
    }

#/
