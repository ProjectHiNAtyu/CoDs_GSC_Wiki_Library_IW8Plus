// scripts\mp\ob\activities\ob_activity_seal_summon.gsc  (hash_781f8d0354c45bf5.gscc) (size: 14230 Bytes / 0x3796 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x876a68ee (2271897838)
// size ...... 14230 (0x3796)
// includes .. 17  (offset: 0x3446)
// strings ... 38  (offset: 0x34ce)
// dev strs .. 16  (offset: 0x36d6)
// exports ... 33  (offset: 0x2266)
// cseg ...... 0x33b + 0x1f2b (0x2266)
// imports ... 105 (offset: 0x278e)
// animtree1 . 0   (offset: 0x3796)
// animtree2 . 0   (offset: 0x3796)
#using script_3455b106458253e7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\callbacks;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\interaction;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_seal_summon;

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x5
// Checksum 0xb067ef33, Offset: 0x359
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_e00b60bda9ae8e0a", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0xd1e167ef, Offset: 0x382
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_SEAL_SUMMON", &activity_type_init );
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0x1f77dbda, Offset: 0x39d
// Size: 0x8a
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_SUMMON", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_SUMMON", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_SUMMON", 2, &activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_SEAL_SUMMON", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &on_player_joined_activity, "REV_OB_SEAL_SUMMON" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &on_player_left_activity, "REV_OB_SEAL_SUMMON" );
    activity_definition_utils::function_74af1ab4059e3c06( "sat_activity_definition_seal_summon", "haunting_seal_summon" );
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0x1708dfc3, Offset: 0x42f
// Size: 0x46d
function private activity_setup()
{
    var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.min_travel_speed = var_91c91f4a631c481d.var_4f4f88f6307fb16d;
    self.med_travel_speed = var_91c91f4a631c481d.var_57f79a2ee468f463;
    self.max_travel_speed = var_91c91f4a631c481d.var_75c9d8f8d5bdc443;
    self.med_travel_speed_soul_count = var_91c91f4a631c481d.var_aa594a5fe8fda0d3;
    self.max_travel_speed_soul_count = var_91c91f4a631c481d.var_6fe1b8cca5df1c33;
    self.souls_per_kill = var_91c91f4a631c481d.var_a7a76998bb890c99;
    self.souls_per_kill_elite = var_91c91f4a631c481d.var_75641f2df02a5a60;
    self.soul_life_time = var_91c91f4a631c481d.soullifetime;
    self.zombie_spawn_threshold = var_91c91f4a631c481d.var_dc058f57d29abb02;
    self.min_travel_speed = get_override_setting( "min_travel_speed", self.min_travel_speed );
    self.med_travel_speed = get_override_setting( "med_travel_speed", self.med_travel_speed );
    self.max_travel_speed = get_override_setting( "max_travel_speed", self.max_travel_speed );
    self.souls_per_kill = get_override_setting( "souls_per_kill", self.souls_per_kill );
    self.souls_per_kill_elite = get_override_setting( "souls_per_kill_elite", self.souls_per_kill_elite );
    self.soul_life_time = get_override_setting( "soul_life_time", self.soul_life_time );
    self.med_travel_speed_soul_count = get_override_setting( "med_travel_speed_soul_count", self.med_travel_speed_soul_count );
    self.max_travel_speed_soul_count = get_override_setting( "max_travel_speed_soul_count", self.max_travel_speed_soul_count );
    self.soul_life_time_milliseconds = self.soul_life_time * 1000;
    self.zombie_spawn_threshold = get_override_setting( "zombie_spawn_threshold", self.zombie_spawn_threshold );
    self.var_eab130bb6d17bfdb = 1000;
    self.var_ee75b40b0fbda158 = [];
    spawn_data = activity_instance_common::function_a45920af4495e9f( self );
    self.master = spawn_data.master_struct;
    self.parent_activity = spawn_data.parent_activity;
    self.on_success_callback = spawn_data.on_success_callback;
    self.path_start = self.master namespace_be3150865da9d2f1::get_linked_struct_filtered( "path", "script_noteworthy" );
    self.seal_start = self.master namespace_be3150865da9d2f1::get_linked_struct_filtered( "start", "script_noteworthy" );
    self.seal_end = self.master namespace_be3150865da9d2f1::get_linked_struct_filtered( "end", "script_noteworthy" );
    self.seal_zone = self.master namespace_be3150865da9d2f1::get_linked_struct_filtered( "zone_info", "script_noteworthy" );
    self.seal_type = int( self.seal_start.seal_type );
    self.start_base = spawnscriptable( "sat_ob_seal_pedestal_base_scriptable", self.seal_start.origin, self.seal_start.angles );
    self.start_base.activity = self;
    self.start_base setscriptablepartstate( #"interact", #"off" );
    self.end_base = spawnscriptable( "sat_ob_seal_pedestal_base_scriptable", self.seal_end.origin, self.seal_end.angles );
    self.end_base setscriptablepartstate( #"interact", #"off" );
    self.obelisk = spawnscriptable( "sat_ob_seal_pedestal_top_scriptable", self.seal_end.origin + ( 0, 0, 40 ), self.seal_end.angles );
    self.obelisk setscriptablepartstate( #"fx", #"off" );
    self.var_546e4eb5269dbafa = "difficulty5";
    activity_participation::function_5e5913e13bf9cb28( self );
    self.spawned_enemies = [];
    
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:x24>", 0 ) == 1 )
        {
            thread debug_draw_path();
        }
    #/
    
    if ( !spawn_data.pause_begin )
    {
        activity_instance_common::function_46135a69bddfec2c( self );
    }
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0x7e0bef36, Offset: 0x8a4
// Size: 0x1fa
function private function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.ritual_object = spawnscriptable( "sat_ob_seal_pedestal_orb_scriptable", self.start_base.origin + ( 0, 0, 60 ), self.start_base.angles );
    
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:x34>", 0 ) )
        {
            self.ritual_object.origin = self.end_base.origin + ( 0, 0, 170 );
            activity_instance_common::endactivity( self, 1 );
            return;
        }
    #/
    
    self.start_base setscriptablepartstate( #"interact", #"on" );
    interaction::register_scriptable_interact( self.start_base, &function_bf91f842c8acde47 );
    self.ritual_object setscriptablepartstate( #"icon", #"visible" );
    self.ritual_object setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", self.seal_type ), #"state_01" );
    self.ritual_object setscriptablepartstate( #"impact", #"idle" );
    self waittill( #"hash_20a6cf173dc43a94" );
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
    spatial_zone_container::function_5252f95edcf9e32c( self, "Awareness_Zone", &awareness_zone_get_center, [ self ] );
    self.spatial_zone_struct = spatial_zone_container::function_847140d2863dfbf8( self, "Awareness_Zone", undefined, 2000, 1 );
    activity_player_broadcasting::function_cb4750c84882dd07( "seal_summon_begin" );
    game_utility::questcircle_create( "Search_Area_WorldEvent_Ob", self.ritual_object.origin, 1000 );
    thread function_3677a9563a98634f();
    activity_participation::function_a45fd1c5cc774007( self );
    thread function_e310ee3dcf9048ee();
    self waittill( #"hash_7ac35751849e2d22" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0x6e55b3ef, Offset: 0xaa6
// Size: 0x15d
function private activity_end()
{
    state_map = [ 2:#"ice", #"electric", 0:#"fire" ];
    self.obelisk setscriptablepartstate( #"fx", hashcat( state_map[ self.seal_type ], 1 ) );
    
    if ( self.parent_activity )
    {
        params = { #seal_zone:self.seal_zone, #var_b662fc91ec6aa840:self.var_b662fc91ec6aa840, #seal_type:self.seal_type, #ritual_object:self.ritual_object, #obelisk:self.obelisk, #base:self.end_base };
        self.parent_activity thread [[ self.on_success_callback ]]( params );
    }
    
    if ( self.ritual_object )
    {
        self.ritual_object setscriptablepartstate( #"icon", #"invisible" );
        self.ritual_object setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", self.seal_type ), #"state_01" );
        self.ritual_object calloutmarkerping::function_608710c894185549();
    }
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0x79b586d8, Offset: 0xc0b
// Size: 0x11c
function private function_d4acef179eb9f9b2()
{
    foreach ( enemy in self.spawned_enemies )
    {
        enemy callback::remove( #"on_ai_killed", &function_8c5e06ee1e60aeb7, self );
    }
    
    self.spawned_enemies = undefined;
    
    if ( self.ritual_object )
    {
        self.ritual_object utility::function_32b24db3127bff40( #"icon", #"invisible" );
    }
    
    if ( self.mover )
    {
        self.ritual_object utility::scriptable_clearparententity();
        
        if ( self.mover.attractor )
        {
            zombie_attractor_manager::remove_attractor( self.mover.attractor );
        }
        
        self.mover delete();
    }
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0x1c413d1d, Offset: 0xd2f
// Size: 0x9c
function private on_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in player_list )
        {
            game_utility::questcircle_showtoplayer( player );
        }
    }
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0x8a571de0, Offset: 0xdd3
// Size: 0x9c
function private on_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in player_list )
        {
            game_utility::questcircle_hidefromplayer( player );
        }
    }
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0x15104941, Offset: 0xe77
// Size: 0x65
function private function_3677a9563a98634f()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.ritual_object endon( #"death" );
    self.mapcircle endon( #"death" );
    
    while ( true )
    {
        game_utility::questcircle_move( self.ritual_object.origin );
        waitframe();
    }
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0x4b5a20e0, Offset: 0xee4
// Size: 0x46
function private function_bf91f842c8acde47( player )
{
    activity_instance = self.activity;
    self setscriptablepartstate( #"interact", #"off" );
    activity_instance notify( #"hash_20a6cf173dc43a94" );
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0x996b37a1, Offset: 0xf32
// Size: 0x46
function private awareness_zone_get_center( activityinstance )
{
    if ( activityinstance.ritual_object )
    {
        activityinstance.var_3c654fa2b568b5b3 = activityinstance.ritual_object.origin;
    }
    
    return activityinstance.var_3c654fa2b568b5b3;
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0xc998dbc9, Offset: 0xf81
// Size: 0x305
function private function_e310ee3dcf9048ee()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    mover = utility::spawn_model( "tag_origin", self.ritual_object.origin, ( 0, 0, 0 ) );
    self.mover = mover;
    self.ritual_object utility::scriptable_setparententity( self.mover );
    liftup_speed = self.min_travel_speed;
    var_4bdf6e1639b7f93e = distance( mover.origin, self.path_start.origin ) / liftup_speed;
    mover moveto( self.path_start.origin, var_4bdf6e1639b7f93e );
    mover waittill( #"movedone" );
    function_42dcfddeee093c0( self.path_start );
    current_node = self.path_start;
    next_node = utility::getstruct( current_node.target );
    thread function_80551ac2c90f9c3a();
    mover.attractor = zombie_attractor_manager::add_attractor( mover, 1, 2000, 0, undefined, &function_79339d95a8676374 );
    mover.attractor.skipteamcheck = 1;
    
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:x39>", 0 ) )
        {
            thread debug_draw_speed();
        }
    #/
    
    while ( true )
    {
        while ( true )
        {
            var_ccf9a72ba0ac0132 = self.var_7d8e518f92696b02;
            move_time = distance( mover.origin, next_node.origin ) / var_ccf9a72ba0ac0132;
            mover.speed = var_ccf9a72ba0ac0132;
            
            if ( move_time > 0 )
            {
                move_time = level.framedurationseconds * ceil( move_time / level.framedurationseconds );
                mover moveto( next_node.origin, move_time );
                result = utility::waittill_any_ents_return( mover, "movedone", self, "speed_changed" );
                
                if ( result == "movedone" )
                {
                    break;
                }
                
                continue;
            }
            
            break;
        }
        
        current_node = next_node;
        function_42dcfddeee093c0( current_node );
        
        if ( current_node.target )
        {
            next_node = utility::getstruct( current_node.target );
        }
        else
        {
            next_node = undefined;
        }
        
        if ( !next_node )
        {
            break;
        }
        
        if ( !next_node.target )
        {
            next_node.origin = self.end_base.origin + ( 0, 0, 170 );
        }
    }
    
    zombie_attractor_manager::remove_attractor( mover.attractor );
    mover.attractor = undefined;
    self.ritual_object utility::scriptable_clearparententity();
    mover delete();
    self.mover = undefined;
    self.move_done = 1;
    self notify( #"hash_7ac35751849e2d22" );
}

// Namespace ob_activity_seal_summon
// Params 2, eflags: 0x4
// Checksum 0x3e173bde, Offset: 0x128e
// Size: 0x37, Type: bool
function private function_79339d95a8676374( attractor, zombie )
{
    if ( zombie.var_bd22ba6c600a23a3 )
    {
        return false;
    }
    
    if ( zombie.enemy )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_seal_summon
// Params 4, eflags: 0x4
// Checksum 0x4e5e2e7, Offset: 0x12ce
// Size: 0xd8
function private on_agent_spawned( requestid, params, agent, data )
{
    activityinstance = params[ 0 ];
    iselite = params[ 1 ];
    
    if ( get_override_setting( "force_difficulty", 1 ) )
    {
        if ( agent.unittype == "zombie" )
        {
            agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
        }
    }
    
    agent setscriptablepartstate( #"burned_cradle", #"burned_on", 0 );
    agent callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7, activityinstance );
    agent.iselite = iselite;
    
    if ( !iselite )
    {
        activityinstance.spawned_enemies[ activityinstance.spawned_enemies.size ] = agent;
    }
}

// Namespace ob_activity_seal_summon
// Params 2, eflags: 0x4
// Checksum 0x7328e76, Offset: 0x13ae
// Size: 0x4b, Type: bool
function private function_93c37c2eaa0b7a15( requestid, activityinstance )
{
    if ( !arraycontains( activityinstance.var_9b65d1b296ebf31c, requestid ) )
    {
        return false;
    }
    
    if ( activityinstance.spawned_enemies.size >= activityinstance.zombie_spawn_threshold )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_seal_summon
// Params 2, eflags: 0x4
// Checksum 0xf747aae4, Offset: 0x1402
// Size: 0x27, Type: bool
function private function_f7a0f7f8694d0ad2( requestid, activityinstance )
{
    return !arraycontains( activityinstance.var_9b65d1b296ebf31c, requestid );
}

// Namespace ob_activity_seal_summon
// Params 4, eflags: 0x4
// Checksum 0xb194bc8c, Offset: 0x1432
// Size: 0x5f
function private spawn_ambush_encounter( encounter, origin, radius, iselite )
{
    request_id = activity_ai_encounters::function_eb8506829193f5eb( encounter, origin, radius, 1, 0, 1, 0 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &on_agent_spawned, [ self, iselite ] );
    return request_id;
}

// Namespace ob_activity_seal_summon
// Params 2, eflags: 0x4
// Checksum 0x23bb09d, Offset: 0x149a
// Size: 0x54
function private function_9e302f05c5e2fe99( origin, radius )
{
    request_id = spawn_ambush_encounter( %"hash_1e5ed9aca69b56fb", origin, radius, 0 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( request_id, &function_93c37c2eaa0b7a15, self );
    activity_ai_encounters::function_d33de057e760c97b( request_id, &function_f7a0f7f8694d0ad2, self );
    return request_id;
}

// Namespace ob_activity_seal_summon
// Params 2, eflags: 0x4
// Checksum 0xdf15a55c, Offset: 0x14f7
// Size: 0x29
function private function_2a2008f6c8d0baa9( origin, radius )
{
    return spawn_ambush_encounter( %"hash_390c9c98c9db120f", origin, radius, 1 );
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0x5e65a981, Offset: 0x1529
// Size: 0x141
function private function_42dcfddeee093c0( struct )
{
    linked_structs = struct utility::get_linked_structs();
    var_9b65d1b296ebf31c = [];
    
    foreach ( var_fc61cf2c5f42a5b1 in linked_structs )
    {
        if ( var_fc61cf2c5f42a5b1.script_noteworthy == "ambush" )
        {
            request_id = function_9e302f05c5e2fe99( var_fc61cf2c5f42a5b1.origin, var_fc61cf2c5f42a5b1.radius ?? 500 );
            function_a748fd0f51127844( request_id, 1 + 0.1 * var_9b65d1b296ebf31c.size );
            var_9b65d1b296ebf31c[ var_9b65d1b296ebf31c.size ] = request_id;
            continue;
        }
        
        if ( var_fc61cf2c5f42a5b1.script_noteworthy == "ambush_elite" )
        {
            request_id = function_2a2008f6c8d0baa9( var_fc61cf2c5f42a5b1.origin, var_fc61cf2c5f42a5b1.radius ?? 500 );
            thread function_e75227fb4b88bfa( request_id );
        }
    }
    
    if ( var_9b65d1b296ebf31c.size )
    {
        self.var_9b65d1b296ebf31c = var_9b65d1b296ebf31c;
    }
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0xeacbba2, Offset: 0x1672
// Size: 0xe5
function private function_e75227fb4b88bfa( request_id )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    lifetime = get_override_setting( "ambush_lifetime", 30 );
    wait lifetime;
    
    if ( activity_ai_encounters::function_e9bac21ccee7cf24( request_id ) )
    {
        request_data = function_9b649316adcccbaa( request_id );
        
        if ( request_data )
        {
            foreach ( ai in request_data.ai )
            {
                ai.var_970cfa87c02e26ea = 1;
                ai kill();
            }
        }
    }
}

// Namespace ob_activity_seal_summon
// Params 2, eflags: 0x4
// Checksum 0x3c3a74e2, Offset: 0x175f
// Size: 0x113
function private function_8c5e06ee1e60aeb7( params, activityinstance )
{
    if ( !self.iselite )
    {
        activityinstance.spawned_enemies = arrayremove( activityinstance.spawned_enemies, self );
    }
    
    if ( self.death_source == "despawn" || self.var_970cfa87c02e26ea )
    {
        return;
    }
    
    if ( self.unittype != "zombie" )
    {
        return;
    }
    
    if ( !activityinstance.ritual_object || distance( self.origin, activityinstance.ritual_object.origin ) > activityinstance.var_eab130bb6d17bfdb )
    {
        return;
    }
    
    soul_count = self.aicategory == "normal" ? activityinstance.souls_per_kill : activityinstance.souls_per_kill_elite;
    pos = self gettagorigin( "j_head" );
    activityinstance thread collect_soul( pos, self.angles, soul_count );
}

// Namespace ob_activity_seal_summon
// Params 3, eflags: 0x4
// Checksum 0x29001f46, Offset: 0x187a
// Size: 0x213
function private collect_soul( origin, angles, count )
{
    if ( !self.mover )
    {
        return;
    }
    
    if ( !isdefined( self.var_850cf175e3e4a8b7 ) )
    {
        self.var_850cf175e3e4a8b7 = 0;
    }
    
    soul_move_speed = 250;
    
    if ( self.var_850cf175e3e4a8b7 <= 5 )
    {
        self.var_850cf175e3e4a8b7++;
        mover = utility::spawn_model( "tag_origin", origin, ( 0, 0, 0 ) );
        scriptable = spawnscriptable( %"hash_62ad238b4c141a3d", origin );
        scriptable setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", self.seal_type ), #"visible" );
        scriptable utility::scriptable_setparententity( mover );
        mover linkto( self.mover );
        move_time_seconds = distance( mover.origin, self.mover.origin ) / soul_move_speed;
        mover movetolinked( self.mover.origin - mover.origin, move_time_seconds );
        utility::waittill_any_ents( mover, "movedone", self.mover, "death" );
        current_time = gettime();
        
        if ( !self.var_b9979a280e773f8b || current_time - self.var_b9979a280e773f8b >= 1000 )
        {
            scriptable setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", self.seal_type ), #"impact" );
            self.var_b9979a280e773f8b = current_time;
        }
        
        wait 0.2;
        scriptable freescriptable();
        mover delete();
        self.var_850cf175e3e4a8b7--;
    }
    else
    {
        wait_time = distance( self.mover.origin, origin ) / soul_move_speed;
        
        if ( wait_time > 0 )
        {
            wait wait_time;
        }
    }
    
    function_3a2e120a02f3b254( count );
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0x337f88bb, Offset: 0x1a95
// Size: 0x58
function private function_3a2e120a02f3b254( count )
{
    if ( self.move_done )
    {
        return;
    }
    
    current_time = gettime();
    
    for ( i = 0; i < count ; i++ )
    {
        self.var_ee75b40b0fbda158[ self.var_ee75b40b0fbda158.size ] = current_time;
    }
}

// Namespace ob_activity_seal_summon
// Params 1, eflags: 0x4
// Checksum 0xfe2c563a, Offset: 0x1af5
// Size: 0x56
function private function_4beacd3b78875c1a( soulcount = 0 )
{
    if ( soulcount >= self.max_travel_speed_soul_count )
    {
        return self.max_travel_speed;
    }
    
    if ( soulcount >= self.med_travel_speed_soul_count )
    {
        return self.med_travel_speed;
    }
    
    return self.min_travel_speed;
}

// Namespace ob_activity_seal_summon
// Params 0, eflags: 0x4
// Checksum 0x7235ed4c, Offset: 0x1b53
// Size: 0x1eb
function private function_80551ac2c90f9c3a()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hash_7ac35751849e2d22" );
    self.var_7d8e518f92696b02 = function_4beacd3b78875c1a();
    
    while ( true )
    {
        unique_timestamp = arrayremoveduplicates( self.var_ee75b40b0fbda158 );
        
        foreach ( value in unique_timestamp )
        {
            if ( gettime() - value >= self.soul_life_time_milliseconds )
            {
                if ( arraycontains( self.var_ee75b40b0fbda158, value ) )
                {
                    self.var_ee75b40b0fbda158 = arrayremove( self.var_ee75b40b0fbda158, value );
                }
            }
        }
        
        soul_collected = self.var_ee75b40b0fbda158.size;
        new_speed = function_4beacd3b78875c1a( soul_collected );
        
        if ( new_speed != self.var_7d8e518f92696b02 )
        {
            self.var_7d8e518f92696b02 = new_speed;
            self notify( #"speed_changed" );
            state_index = 1;
            
            if ( self.var_7d8e518f92696b02 == self.max_travel_speed )
            {
                state_index = 3;
            }
            else if ( self.var_7d8e518f92696b02 == self.med_travel_speed )
            {
                state_index = 2;
            }
            
            self.ritual_object setscriptablepartstate( hashcat( #"hash_3b52534f1bdca387", self.seal_type ), hashcat( #"state_0", state_index ) );
            self.ritual_object setscriptablepartstate( #"impact", hashcat( #"hash_81f79b330da5f578", self.seal_type ) );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_seal_summon
// Params 2, eflags: 0x4
// Checksum 0x7c5e2bde, Offset: 0x1d46
// Size: 0x2a
function private get_override_setting( name, defaultvalue )
{
    return getdvarint( hashcat( @"hash_3809b95a31591a1", name ), defaultvalue );
}

/#

    // Namespace ob_activity_seal_summon
    // Params 2, eflags: 0x4
    // Checksum 0x17da8eb6, Offset: 0x1d79
    // Size: 0x22, Type: dev
    function private function_a5cd5a36ccebe58( name, defaultvalue )
    {
        return get_override_setting( name, defaultvalue );
    }

    // Namespace ob_activity_seal_summon
    // Params 2, eflags: 0x4
    // Checksum 0x95dba47d, Offset: 0x1da3
    // Size: 0x14f, Type: dev
    function private function_cd8db75ff16c7a7e( node, duration )
    {
        structs = node utility::get_linked_structs();
        color = ( 255, 255, 0 );
        
        foreach ( struct in structs )
        {
            origin = struct.origin;
            sphere( origin, 10, color, 0, duration );
            line( node.origin, origin, color, 1, 0, duration );
            
            if ( struct.script_noteworthy )
            {
                print3d( origin, struct.script_noteworthy, ( 255, 255, 0 ), 1, 1, duration, 1 );
            }
            
            if ( struct.radius )
            {
                cylinder( origin, origin + ( 0, 0, 10 ), struct.radius, color, 0, duration );
            }
        }
    }

    // Namespace ob_activity_seal_summon
    // Params 0, eflags: 0x4
    // Checksum 0x2cf7eaf0, Offset: 0x1efa
    // Size: 0x135, Type: dev
    function private debug_draw_path()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        var_f948e10375322ae4 = 10;
        duration_seconds = level.framedurationseconds * var_f948e10375322ae4;
        
        while ( true )
        {
            current_node = self.path_start;
            function_cd8db75ff16c7a7e( current_node, var_f948e10375322ae4 );
            next_node = utility::getstruct( current_node.target );
            sphere( current_node.origin, 10, ( 0, 255, 0 ), 0, var_f948e10375322ae4 );
            
            while ( next_node )
            {
                function_cd8db75ff16c7a7e( next_node, var_f948e10375322ae4 );
                sphere( next_node.origin, 10, ( 0, 255, 0 ), 0, var_f948e10375322ae4 );
                line( current_node.origin, next_node.origin, ( 255, 0, 0 ), 1, 0, var_f948e10375322ae4 );
                current_node = next_node;
                
                if ( current_node.target )
                {
                    next_node = utility::getstruct( current_node.target );
                    continue;
                }
                
                next_node = undefined;
                break;
            }
            
            wait duration_seconds;
        }
    }

    // Namespace ob_activity_seal_summon
    // Params 0, eflags: 0x4
    // Checksum 0x81625c56, Offset: 0x2037
    // Size: 0x22f, Type: dev
    function private debug_draw_speed()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        self.mover endon( #"death" );
        var_84df3b45093cc8db = [];
        var_84df3b45093cc8db[ self.min_travel_speed ] = "<dev string:x4a>";
        var_84df3b45093cc8db[ self.med_travel_speed ] = "<dev string:x4e>";
        var_84df3b45093cc8db[ self.max_travel_speed ] = "<dev string:x55>";
        var_64076f94bd64fbdc = "<dev string:x5a>" + self.med_travel_speed_soul_count + "<dev string:x6e>" + self.max_travel_speed_soul_count + "<dev string:x75>" + self.soul_life_time + "<dev string:x80>";
        var_c8ad641be184313c = "<dev string:x82>" + self.min_travel_speed + "<dev string:x8d>" + self.med_travel_speed + "<dev string:x93>" + self.max_travel_speed;
        
        while ( true )
        {
            if ( self.mover.speed )
            {
                print3d( self.mover.origin, "<dev string:x99>" + self.mover.speed + "<dev string:xa0>" + var_84df3b45093cc8db[ self.mover.speed ], ( 0, 255, 0 ), 1, 1, 1, 1 );
            }
            
            print3d( self.mover.origin - ( 0, 0, 20 ), "<dev string:xa2>" + self.var_ee75b40b0fbda158.size, ( 0, 255, 0 ), 1, 1, 1, 1 );
            print3d( self.mover.origin - ( 0, 0, 40 ), var_64076f94bd64fbdc, ( 0, 255, 0 ), 1, 1, 1, 1 );
            print3d( self.mover.origin - ( 0, 0, 60 ), var_c8ad641be184313c, ( 0, 255, 0 ), 1, 1, 1, 1 );
            waitframe();
        }
    }

#/
