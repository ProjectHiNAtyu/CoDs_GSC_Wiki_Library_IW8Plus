// scripts\mp\ob\activities\ob_activity_strike_boss_shared.gsc  (hash_527a95758c08af24.gscc) (size: 8580 Bytes / 0x2184 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95d5462e (2513782318)
// size ...... 8580 (0x2184)
// includes .. 12  (offset: 0x1f8c)
// strings ... 21  (offset: 0x1fec)
// dev strs .. 11  (offset: 0x2100)
// exports ... 19  (offset: 0x1468)
// cseg ...... 0x1f5 + 0x1273 (0x1468)
// imports ... 71  (offset: 0x1760)
// animtree1 . 0   (offset: 0x2184)
// animtree2 . 0   (offset: 0x2184)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\spatial_zone_container;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_strike_boss_shared;

/#

    // Namespace ob_activity_strike_boss_shared
    // Params 0, eflags: 0x5
    // Checksum 0x13d9e0a1, Offset: 0x213
    // Size: 0xd, Type: dev
    function private autoexec main()
    {
        level thread init_devgui();
    }

#/

// Namespace ob_activity_strike_boss_shared
// Params 4
// Checksum 0xea3eef7b, Offset: 0x228
// Size: 0x152
function function_e67794b46217642e( name, origin, radius, height )
{
    volume = spawn( "noent_volume_trigger_radius", origin, 0, radius, height );
    region_difficulty_manager::add_difficulty_region( 5, name, volume );
    function_8726f90aa4839eb5( origin[ 0 ], origin[ 1 ], radius, 5 );
    volume game_utility::questcircle_create( "Toxin_Bomb_Region_Ob", origin, radius );
    volume game_utility::questcircle_showtoall();
    level function_e73fc853c25ca969( origin, radius );
    var_ff5e5478ff4913a2 = function_92feb781f39c229( origin, radius );
    
    foreach ( zone in var_ff5e5478ff4913a2 )
    {
        function_2a814d41ec6b9609( zone.zoneindex, "difficulty5", 1 );
        function_b57e44ce9d93be80( zone.zoneindex );
    }
    
    params = { #radius:radius, #origin:origin };
    level callback::callback( "activity_nightmare_zone_spawn", params );
}

// Namespace ob_activity_strike_boss_shared
// Params 3
// Checksum 0xc67c3b84, Offset: 0x382
// Size: 0x1a6
function function_794686ee5a2eb3b6( origin, radius, create_origin )
{
    if ( !level.ob_activity_explode_ai_throttle )
    {
        level.ob_activity_explode_ai_throttle = throttle::throttle_initialize( "ob_activity_explode_ai", 2 );
    }
    
    agents_in_radiation = getaiarrayinradius( origin, radius );
    
    foreach ( agent in agents_in_radiation )
    {
        if ( !isdefined( agent ) )
        {
            continue;
        }
        
        if ( agent._blackboard.invehicle && agent._blackboard.currentvehicle && agent._blackboard.currentvehicle vehicle::can_fly() && !agent._blackboard.currentvehicle.var_4327c6b1c1b4c2ae )
        {
            agent._blackboard.currentvehicle thread function_103ba666933b8aa7( create_origin );
        }
        
        if ( function_e0119152e76c1432( agent ) )
        {
            continue;
        }
        
        agent.var_a13bed1ac47e1b2c = 1;
        agent.dropweapon = 0;
        agent.nodrop = 1;
        agent kill();
        throttle::throttle_wait_in_queue( level.ob_activity_explode_ai_throttle, self );
    }
}

// Namespace ob_activity_strike_boss_shared
// Params 1, eflags: 0x4
// Checksum 0xa49bad52, Offset: 0x530
// Size: 0x101
function private function_103ba666933b8aa7( radiation_origin )
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    self.var_4327c6b1c1b4c2ae = 1;
    
    if ( self hascomponent( "c2p" ) )
    {
        self removecomponent( "c2p" );
        waitframe();
    }
    
    crashangle = vectornormalize( self.origin - radiation_origin );
    
    if ( !isdefined( self.var_c93e8f2f2f75907f ) )
    {
        self.var_c93e8f2f2f75907f = {};
    }
    
    self.var_c93e8f2f2f75907f.speed = 300;
    self.var_c93e8f2f2f75907f.acceleration = 60;
    self.var_c93e8f2f2f75907f.deceleration = 120;
    self.var_c93e8f2f2f75907f.angle = crashangle;
    self setmaxpitchroll( 180, 180 );
    self vehphys_impulse( crashangle, 100, 1 );
    self dodamage( self.maxhealth, radiation_origin, undefined, undefined, "MOD_EXPLOSIVE" );
}

// Namespace ob_activity_strike_boss_shared
// Params 1, eflags: 0x4
// Checksum 0xe40f96ee, Offset: 0x639
// Size: 0x77, Type: bool
function private function_e0119152e76c1432( agent )
{
    if ( agent.var_437f238159c83b57 )
    {
        return true;
    }
    
    if ( agent.var_6fb8224240879ded )
    {
        return true;
    }
    
    var_fd0b020f1329d81a = agent._blackboard.invehicle && agent._blackboard.currentvehicle vehicle::can_fly();
    
    if ( var_fd0b020f1329d81a )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_strike_boss_shared
// Params 2
// Checksum 0xf2cdd449, Offset: 0x6b9
// Size: 0x3d
function function_33d7c1273681ab9f( center, radius )
{
    overlapping_activities = get_overlapping_activities( center, radius );
    function_bfdb18324ce2cb8f( overlapping_activities );
    function_973c5321734c3f07( center, radius );
}

// Namespace ob_activity_strike_boss_shared
// Params 2
// Checksum 0x1d17a1bc, Offset: 0x6fe
// Size: 0x564
function get_overlapping_activities( center, radius )
{
    overlapping_activities = [];
    activity_classes = [ "Activity", "Contract", "Startup" ];
    current_region = region_difficulty_manager::function_f9fbb630598afdc7( center );
    region_index = current_region.index;
    var_e853d7d9e7ac292 = 30;
    var_4d02c5bd1fd97b8b = 0;
    activity_type_whitelist = [ "REV_OB_STRIKE_BOSS", "REV_OB_RED_FLOOD", "REV_OB_ABOM_HUNT", "REV_OB_LOCKED_IN", "REV_OB_POSSESSED_CONVOY" ];
    
    foreach ( activity_class in activity_classes )
    {
        foreach ( region_index, running_activities in level.var_e607236b193eb0c1.var_559750d3b21f479f[ activity_class ] )
        {
            foreach ( activity_type, activity_instances in running_activities )
            {
                if ( arraycontains( activity_type_whitelist, activity_type ) )
                {
                    continue;
                }
                
                foreach ( activity_instance in activity_instances )
                {
                    var_4d02c5bd1fd97b8b++;
                    var_4d02c5bd1fd97b8b %= var_e853d7d9e7ac292;
                    
                    if ( var_4d02c5bd1fd97b8b == 0 )
                    {
                        waitframe();
                    }
                    
                    var_2d4aa5f55d3c1c84 = spatial_zone_container::function_f7fc3e6c249a8256( activity_instance, "OB_Spacer_Spatial_Zone" );
                    
                    if ( var_2d4aa5f55d3c1c84.size )
                    {
                        foreach ( var_913f4c7e63bf151f in var_2d4aa5f55d3c1c84 )
                        {
                            if ( distance2d( center, var_913f4c7e63bf151f.origin ) <= radius + var_913f4c7e63bf151f.radius )
                            {
                                overlapping_activities[ overlapping_activities.size ] = activity_instance;
                                break;
                            }
                        }
                    }
                    
                    var_4fe2d491bc9efbff = ob_activity_manager::function_ed1dae3a9cce08d2( activity_instance.name );
                    
                    foreach ( var_99c2b0d0a40bdfae in var_4fe2d491bc9efbff )
                    {
                        var_6f9f67561720fbfd = spatial_zone_container::function_f7fc3e6c249a8256( var_99c2b0d0a40bdfae, "OB_Spacer_Spatial_Zone" );
                        
                        if ( var_6f9f67561720fbfd.size )
                        {
                            foreach ( var_913f4c7e63bf151f in var_6f9f67561720fbfd )
                            {
                                if ( distance2d( center, var_913f4c7e63bf151f.origin ) <= radius + var_913f4c7e63bf151f.radius )
                                {
                                    overlapping_activities[ overlapping_activities.size ] = activity_instance;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    var_7ee9a290cba8690 = getentitylessscriptablearray( undefined, undefined, center, radius, "nexus_activity_joiner_phone" );
    
    foreach ( starter in var_7ee9a290cba8690 )
    {
        if ( starter.activity_instance && starter getscriptablepartstate( "nexus_activity_joiner_phone" ) != "hidden" )
        {
            instance = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ starter.activity_instance.varianttag ];
            
            if ( instance )
            {
                overlapping_activities[ overlapping_activities.size ] = instance;
            }
            
            starter setscriptablepartstate( #"nexus_activity_joiner_phone", #"hidden" );
        }
    }
    
    overlapping_activities = arrayremoveduplicates( overlapping_activities );
    return overlapping_activities;
}

// Namespace ob_activity_strike_boss_shared
// Params 1
// Checksum 0xb760817c, Offset: 0xc6b
// Size: 0x140
function function_bfdb18324ce2cb8f( activities )
{
    var_88f86d1cfc12aa77 = 10;
    var_48ea3e609587fb4a = 0;
    
    foreach ( activity_instance_info in activities )
    {
        activity_instance = level.activities.instances[ activity_instance_info.lastid ];
        current_state = activity_instance_common::getactivitystate( activity_instance );
        
        if ( current_state == "Idle" )
        {
            activity_instance.resetcooldown = 1;
            activity_instance_common::function_9aeeabe50fc9cc3e( activity_instance );
        }
        else if ( current_state == "Active" )
        {
            activity_instance.resetcooldown = 1;
            activity_instance_common::endactivity( activity_instance, 0 );
        }
        else
        {
            continue;
        }
        
        activity_instance_info.var_7045a7bcdef0ce48 += 1;
        var_48ea3e609587fb4a++;
        var_48ea3e609587fb4a %= var_88f86d1cfc12aa77;
        
        if ( var_48ea3e609587fb4a == 0 )
        {
            waitframe();
        }
    }
}

// Namespace ob_activity_strike_boss_shared
// Params 2
// Checksum 0x870ed4bc, Offset: 0xdb3
// Size: 0x1d9
function function_973c5321734c3f07( center, radius )
{
    if ( !utility::issharedfuncdefined( #"ob_exfil_door", #"hash_7f1df46a0020a91d" ) )
    {
        return;
    }
    
    overlapping_exfils = [];
    radius_sqrd = radius * radius;
    
    foreach ( door in level.exfildoors.activedoors )
    {
        if ( door.activity_instance )
        {
            var_2d4aa5f55d3c1c84 = spatial_zone_container::function_f7fc3e6c249a8256( door.activity_instance, "OB_Spacer_Spatial_Zone" );
        }
        
        if ( var_2d4aa5f55d3c1c84.size )
        {
            foreach ( var_913f4c7e63bf151f in var_2d4aa5f55d3c1c84 )
            {
                if ( distance2dsquared( center, var_913f4c7e63bf151f.origin ) <= ( radius + var_913f4c7e63bf151f.radius ) * ( radius + var_913f4c7e63bf151f.radius ) )
                {
                    overlapping_exfils[ overlapping_exfils.size ] = door;
                    break;
                }
            }
            
            continue;
        }
        
        if ( distance2dsquared( center, var_913f4c7e63bf151f.origin ) <= radius_sqrd )
        {
            overlapping_exfils[ overlapping_exfils.size ] = door;
        }
    }
    
    level thread utility::callsharedfunc( #"ob_exfil_door", #"hash_7f1df46a0020a91d", overlapping_exfils );
}

// Namespace ob_activity_strike_boss_shared
// Params 2, eflags: 0x4
// Checksum 0xff1cd826, Offset: 0xf94
// Size: 0x89
function private function_e73fc853c25ca969( centerpoint = ( 0, 0, 0 ), radius = 4000 )
{
    spatialzonecontainer = spawnstruct();
    spatialzonecontainer.var_8339fb4f2d23dabf = spatial_zone_container::function_bf9b65032b29d653();
    spatial_zone_container::addspatialzone( spatialzonecontainer, "difficultyregion_music_zone" );
    spatial_zone_container::function_847140d2863dfbf8( spatialzonecontainer, "difficultyregion_music_zone", centerpoint, radius, 1 );
    spatial_zone_container::function_3b687b8681411c9f( spatialzonecontainer, "difficultyregion_music_zone", &function_ad20df9a1e465ec7 );
}

// Namespace ob_activity_strike_boss_shared
// Params 1, eflags: 0x4
// Checksum 0xf76c7082, Offset: 0x1025
// Size: 0x5a
function private function_ad20df9a1e465ec7( params )
{
    player = params.player;
    
    if ( params.enteredzone )
    {
        level musicbank_utility::function_5aca66c390aa347d( player, #"hash_ac58d52aba019a59" );
        return;
    }
    
    level musicbank_utility::function_4f253fd35ec68cbc( player, #"hash_ac58d52aba019a59" );
}

// Namespace ob_activity_strike_boss_shared
// Params 1
// Checksum 0xe99c1baa, Offset: 0x1087
// Size: 0xc1
function function_faeba2b042cc0dd6( activityinstance )
{
    if ( !isdefined( level.var_4bb5b39b659877ec ) )
    {
        level.var_4bb5b39b659877ec = [];
    }
    
    level.var_4bb5b39b659877ec[ level.var_4bb5b39b659877ec.size ] = activityinstance;
    
    if ( level.var_4bb5b39b659877ec.size > 0 )
    {
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::function_6d307def1435e5d5();
        }
    }
}

// Namespace ob_activity_strike_boss_shared
// Params 1
// Checksum 0x3940b3c2, Offset: 0x1150
// Size: 0xc2
function function_61aa7b6027b4191e( activityinstance )
{
    if ( !isdefined( level.var_4bb5b39b659877ec ) )
    {
        level.var_4bb5b39b659877ec = [];
    }
    
    level.var_4bb5b39b659877ec = arrayremove( level.var_4bb5b39b659877ec, activityinstance );
    
    if ( level.var_4bb5b39b659877ec.size <= 0 )
    {
        foreach ( player in level.players )
        {
            player ob_story_mission_utils::function_2e1c3a1a4f92857d();
        }
    }
}

/#

    // Namespace ob_activity_strike_boss_shared
    // Params 0, eflags: 0x4
    // Checksum 0x4afcfc64, Offset: 0x121a
    // Size: 0x5d, Type: dev
    function private init_devgui()
    {
        wait 1;
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x5d>", "<dev string:x77>", &function_2a30b826a8ddd881 );
        devgui::add_devgui_func( "<dev string:x96>", "<dev string:xb0>", &function_83e8a0a2b76aa740 );
        devgui::add_devgui_func( "<dev string:xd0>", "<dev string:xe0>", &function_9a9793cc8c575dd4 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_strike_boss_shared
    // Params 2, eflags: 0x4
    // Checksum 0xf5896b78, Offset: 0x127f
    // Size: 0x2e, Type: dev
    function private function_a5cd5a36ccebe58( name, defaultvalue )
    {
        return getdvarint( hashcat( @"hash_f63b29039428a011", name ), defaultvalue );
    }

    // Namespace ob_activity_strike_boss_shared
    // Params 0, eflags: 0x4
    // Checksum 0xd74e44d4, Offset: 0x12b5
    // Size: 0xc9, Type: dev
    function private function_2a30b826a8ddd881()
    {
        radius = function_a5cd5a36ccebe58( "<dev string:xf6>", 5000 );
        player = level.players[ 0 ];
        origin = utility::drop_to_ground( player.origin );
        overlapping_activities = get_overlapping_activities( origin, radius );
        function_bfdb18324ce2cb8f( overlapping_activities );
        function_973c5321734c3f07( origin, radius );
        origin -= ( 0, 0, 2000 );
        function_e67794b46217642e( "<dev string:x104>", origin, radius, 10000 );
        params = { #radius:radius, #origin:origin };
        level callback::callback( "<dev string:x11c>", params );
    }

    // Namespace ob_activity_strike_boss_shared
    // Params 0, eflags: 0x4
    // Checksum 0xa055a35a, Offset: 0x1386
    // Size: 0x9e, Type: dev
    function private function_83e8a0a2b76aa740()
    {
        radius = function_a5cd5a36ccebe58( "<dev string:x13b>", 5000 );
        player = level.players[ 0 ];
        origin = utility::drop_to_ground( player.origin );
        cylinder( origin, origin + ( 0, 0, 10 ), radius, ( 0, 1, 0 ), 0, 1000 );
        overlapping_activities = get_overlapping_activities( origin, radius );
        function_bfdb18324ce2cb8f( overlapping_activities );
        function_973c5321734c3f07( origin, radius );
    }

    // Namespace ob_activity_strike_boss_shared
    // Params 0, eflags: 0x4
    // Checksum 0x490aabc4, Offset: 0x142c
    // Size: 0x3c, Type: dev
    function private function_9a9793cc8c575dd4()
    {
        player = level.players[ 0 ];
        function_794686ee5a2eb3b6( player.origin, 5000, player.origin );
    }

#/
