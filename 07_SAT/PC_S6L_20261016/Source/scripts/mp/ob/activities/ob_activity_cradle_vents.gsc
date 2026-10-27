// scripts\mp\ob\activities\ob_activity_cradle_vents.gsc  (hash_666b2bbf30439d42.gscc) (size: 13453 Bytes / 0x348d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3ee7adf (3287186143)
// size ...... 13453 (0x348d)
// includes .. 18  (offset: 0x30f1)
// strings ... 53  (offset: 0x3181)
// dev strs .. 0   (offset: 0x348d)
// exports ... 42  (offset: 0x1e2d)
// cseg ...... 0x40a + 0x1a23 (0x1e2d)
// imports ... 103 (offset: 0x24bd)
// animtree1 . 0   (offset: 0x348d)
// animtree2 . 0   (offset: 0x348d)
#using script_60cd1c57e94be8d7;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_protocol_utility;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_cradle_gas_circle;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_cradle_vents;

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0x5
// Checksum 0xe4929156, Offset: 0x428
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_cradle_vents", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0x87c45d85, Offset: 0x451
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_CRADLE_VENTS", &activity_type_init );
}

// Namespace ob_activity_cradle_vents
// Params 0
// Checksum 0xaf332120, Offset: 0x46c
// Size: 0x119
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_CRADLE_VENTS", 0, &activity_start );
    activity_common::function_944074f3079c1d4e( "REV_OB_CRADLE_VENTS", 1, &activity_handler );
    activity_common::function_944074f3079c1d4e( "REV_OB_CRADLE_VENTS", 2, &activity_end_handler );
    activity_common::function_944074f3079c1d4e( "REV_OB_CRADLE_VENTS", 3, &destroy_handler );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &cradle_vents_player_joined_activity, "REV_OB_CRADLE_VENTS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_3e4a8bb61094f362, "REV_OB_CRADLE_VENTS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_e7528ec0dc674858, "REV_OB_CRADLE_VENTS" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerExitedAwarenessZone", &function_3541bd4a02a62c84, "REV_OB_CRADLE_VENTS" );
    scriptable::scriptable_addusedcallbackbypart( "hack_interaction", &function_9fa6944f86d0ee46 );
    utility::add_fx( "zombie_corpse_cleanup", "vfx_sat_wc_ai_cradle_soldier_death_01" );
    utility::registersharedfunc( "ob_cradle_vent", #"hack", &function_ac3e6139a6ee0916 );
    utility::registersharedfunc( "ob_cradle_vent", #"start_hacking", &function_bbedc08d62f07525 );
    utility::registersharedfunc( #"ob_activity_cradle_vent", #"hash_a0e1817df2e33c21", &function_9fa6944f86d0ee46 );
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x53bdf31a, Offset: 0x58d
// Size: 0x52
function private cradle_vents_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    startingprogress = function_29cc3d70a6907827() ?? 0;
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, startingprogress, 100 );
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcacradleventdestroy", player_list );
}

// Namespace ob_activity_cradle_vents
// Params 0
// Checksum 0xe107268b, Offset: 0x5e7
// Size: 0x1dc
function activity_start()
{
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.cradle_vent_struct_array = [];
    self.var_8ca11f5c1e2869e3 = [];
    self.settings = self.var_91c91f4a631c481d.settings;
    self.center_point = activity_instance_common::function_776ee11e7acc64a5( self );
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.center_point );
    self.handler_list = [ "marshall", "karma" ];
    variance = self.settings.var_919a95606ef27729;
    self.var_c57f1a6a14851f6a = self.settings.var_c57f1a6a14851f6a + function_b941a040990bcfec( variance );
    self.var_677b2a56c9853d6f = self.settings.var_677b2a56c9853d6f + function_b941a040990bcfec( variance );
    self.var_c4817b30b2a54dd6 = self.settings.var_c4817b30b2a54dd6 + function_b941a040990bcfec( variance );
    self.activity_max_progress = self.var_c57f1a6a14851f6a + self.var_677b2a56c9853d6f + self.var_c4817b30b2a54dd6;
    self.var_a451a1c23c51dd63 = self.settings.var_79eb6c35126058d ?? 20;
    self.var_5db7034c46afe8d0 = 0;
    additionalspawndata = self.additionalspawndata ?? {};
    tag = additionalspawndata.linked_variant_tag ?? self.varianttag;
    ob_activity_protocol_utility::function_8618ee5905c91177( tag );
    self.core_struct.activity_instance = self;
    self.core_struct.var_8741184584656cb5 = &function_b0fd89fbec5fd811;
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_cradle_vents
// Params 0
// Checksum 0x4d2a665a, Offset: 0x7cb
// Size: 0x238
function activity_handler()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_cradle_gas_circle::function_715467b4b7feb05a( self.core_struct, 3, undefined, 1, self.settings.var_22d9341b2feec89a );
    vent_origin = ob_activity_utility::function_fd8fc0e0d2300792( self.core_struct.origin );
    vent_angles = ob_activity_utility::function_fd8fc0e0d2300792( self.core_struct.angles );
    self.vent_scriptable = spawnscriptable( %"ob_cradle_vent", vent_origin, vent_angles );
    self.vent_scriptable.activity_instance = self;
    self.vent_scriptable.objectivemarker = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "cradle_vents_marker", 0, 1 );
    objidpoolmanager::update_objective_position( self.vent_scriptable.objectivemarker, self.vent_scriptable.origin + ( 0, 0, 100 ) );
    objective_disableping( self.vent_scriptable.objectivemarker, 1 );
    function_f73b04bc0b69b125();
    thread function_67b0311c3f82173b();
    spawn_radius = self.settings.var_f25d07f873ff6002;
    self.var_7947fa3a0f87237b = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:" + self.settings.guardencounter, self.core_struct.origin, spawn_radius, 1, 1, 1, 0 );
    self.vent_scriptable utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "ob_cradle_vent" );
    function_ca624a6f4310117a( self.vent_scriptable, self );
    self.vent_scriptable waittill( #"vent_destroyed" );
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcacradleventssuccess" );
    ob_activity_utility::function_aaf7ae640bd564ff( #"activity_cradle_vent", self.core_struct.origin, self.core_struct.angles );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_cradle_vents
// Params 0
// Checksum 0x70f74a01, Offset: 0xa0b
// Size: 0x8b
function activity_end_handler()
{
    ob_cradle_gas_circle::function_ad1c37731b23fb82( self.core_struct );
    self.var_7a7e5871130af681 = 1;
    succeeded = activity_instance_common::function_6bb0be4a3940d6e3( self );
    
    if ( !succeeded && self.vent_scriptable )
    {
        self.vent_scriptable setscriptablepartstate( "hack_interaction", "unusable" );
        self.vent_scriptable setscriptablepartstate( "NexusManagedScriptablePart_Objective_Marker", "hidden" );
        self.vent_scriptable setscriptablepartstate( "vent", "off" );
    }
}

// Namespace ob_activity_cradle_vents
// Params 0
// Checksum 0xa5a3165e, Offset: 0xa9e
// Size: 0x3b
function destroy_handler()
{
    if ( isdefined( self.vent_scriptable ) )
    {
        self.vent_scriptable notify( #"hash_e640d417556308a2" );
        self.vent_scriptable freescriptable();
        self.vent_scriptable = undefined;
    }
}

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xed31c60e, Offset: 0xae1
// Size: 0x72
function private function_f73b04bc0b69b125()
{
    self.var_f5f71b2058a9b606 = 0;
    self.vent_scriptable.curprogress = 0;
    self.vent_scriptable setscriptablepartstate( "vent", "on" );
    self.vent_scriptable setscriptablepartstate( "hack_interaction", "usable" );
    self.vent_scriptable setscriptablepartstate( "body_anim", "idle" );
    activity_definition_utils::updateprogress( 0, self );
}

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0xc
// Checksum 0xf02b5d89, Offset: 0xb5b
// Size: 0xd0
function private function_ac344a909a15aca9()
{
    self notify( #"hash_93bbbd8314b954ee" );
    self endon( #"hash_93bbbd8314b954ee" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        waitframe();
        
        if ( self.playerparticipants.size <= 0 )
        {
            self notify( #"hash_cc1a314ee2de90de" );
            function_f73b04bc0b69b125();
            
            if ( self.var_4b3a12db92cd2bd3 && function_9b649316adcccbaa( self.var_4b3a12db92cd2bd3 ) )
            {
                activity_ai_encounters::function_46dadc3aca2ffac0( self.var_4b3a12db92cd2bd3, 1 );
                self.var_4b3a12db92cd2bd3 = undefined;
            }
            
            if ( self.var_734f383fb80b39f5 && function_9b649316adcccbaa( self.var_734f383fb80b39f5 ) )
            {
                activity_ai_encounters::function_46dadc3aca2ffac0( self.var_734f383fb80b39f5, 1 );
                self.var_734f383fb80b39f5 = undefined;
            }
            
            return;
        }
    }
}

/#

    // Namespace ob_activity_cradle_vents
    // Params 0
    // Checksum 0x21e082d7, Offset: 0xc33
    // Size: 0x5, Type: dev
    function function_f71a1123876daca3()
    {
        
    }

#/

// Namespace ob_activity_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x2bb2354a, Offset: 0xc40
// Size: 0x28
function private function_ca624a6f4310117a( vent, activity_instance )
{
    function_f03c1eb6f962716d( vent, activity_instance );
    thread function_27c3bff42f1af9ae( vent );
}

// Namespace ob_activity_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0x1dd377bd, Offset: 0xc70
// Size: 0x161
function private function_f03c1eb6f962716d( vent, activity_instance )
{
    vent.legs = [];
    ventorg = vent.origin;
    ventangles = vent.angles;
    forward = anglestoforward( ventangles );
    right = anglestoright( ventangles );
    usetime = activity_instance.settings.var_420a38df2fc3387d;
    leg = spawnstruct();
    leg.origin = ventorg + forward * 115 + right * 100;
    vent.legs[ "leg_fr" ] = leg;
    leg = spawnstruct();
    leg.origin = ventorg + forward * 115 - right * 100;
    vent.legs[ "leg_fl" ] = leg;
    leg = spawnstruct();
    leg.origin = ventorg - forward * 115 + right * 100;
    vent.legs[ "leg_rr" ] = leg;
    leg = spawnstruct();
    leg.origin = ventorg - forward * 115 - right * 100;
    vent.legs[ "leg_rl" ] = leg;
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x872cce45, Offset: 0xdd9
// Size: 0x13e
function private function_27c3bff42f1af9ae( vent )
{
    level endon( #"game_ended" );
    obstacles = [];
    
    foreach ( leg in vent.legs )
    {
        obstacles[ obstacles.size ] = createnavobstaclebybounds( leg.origin, ( 40, 40, 100 ), vent.angles );
    }
    
    vent waittill( #"hash_e640d417556308a2" );
    
    foreach ( obstacle in obstacles )
    {
        destroynavobstacle( obstacle );
    }
}

// Namespace ob_activity_cradle_vents
// Params 6
// Checksum 0x2004c5b8, Offset: 0xf1f
// Size: 0x64
function function_9fa6944f86d0ee46( instance, part, state, player, bautouse, usestring )
{
    activity_participation::function_fb0ec90aaf6d4c61( instance.activity_instance, [ player ], "PlayerJoinedInteract" );
    thread function_48fda6c19df920c6( instance, part, state, player );
}

// Namespace ob_activity_cradle_vents
// Params 4, eflags: 0x4
// Checksum 0x4857d0d0, Offset: 0xf8b
// Size: 0x7b
function private function_48fda6c19df920c6( instance, part, state, player )
{
    if ( instance.var_1674515c4a4c0655.size )
    {
        return;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 2, instance, 1, 1, 1, -1 );
    
    if ( !player || !self )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        vent_interact_used( instance, part, state, player );
    }
}

// Namespace ob_activity_cradle_vents
// Params 4, eflags: 0x4
// Checksum 0x5e6b65f3, Offset: 0x100e
// Size: 0x7d
function private vent_interact_used( instance, part, state, player )
{
    activity_instance = instance.activity_instance;
    activity_instance.var_f5f71b2058a9b606++;
    objidpoolmanager::objective_playermask_hidefromallplayers( activity_instance.vent_scriptable.objectivemarker );
    instance setscriptablepartstate( part, "unusable" );
    activity_instance function_159dd24127055e7a( instance );
}

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xf7b42f79, Offset: 0x1093
// Size: 0x2d
function private function_29cc3d70a6907827()
{
    return int( clamp( self.vent_scriptable.curprogress / self.activity_max_progress, 0, 1 ) * 100 );
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xaecd7123, Offset: 0x10c9
// Size: 0x145
function private function_159dd24127055e7a( vent )
{
    var_9f7837a82fe27a12 = self.var_f5f71b2058a9b606;
    
    if ( var_9f7837a82fe27a12 == 1 )
    {
        thread function_9464570ccdf080fd();
        
        if ( getdvarint( @"hash_e0bc42ecf2041057", 0 ) == 1 )
        {
            thread function_ac344a909a15aca9();
        }
        
        ob_activity_vo_utility::function_639b0047db8aec67( self, "wcacradleventsfight" );
    }
    
    if ( !self.var_4b3a12db92cd2bd3 && var_9f7837a82fe27a12 == 2 && self.vent_scriptable.var_70e5107fa80844df != 1 )
    {
        spawn_zombies_boss();
        vent setscriptablepartstate( "vent", "on" );
    }
    
    if ( !self.var_af72e39068333c78 && var_9f7837a82fe27a12 == 3 && self.vent_scriptable.var_70e5107fa80844df != 1 )
    {
        function_a748fd0f51127844( self.var_734f383fb80b39f5, self.settings.var_3cc9431ba7e1ef33 );
        function_bbd192652d1a9e18( self.var_734f383fb80b39f5, self.settings.var_fc87775fee255ca );
        self.var_af72e39068333c78 = 1;
        vent setscriptablepartstate( "vent", "on_surge" );
        ob_activity_vo_utility::function_639b0047db8aec67( self, "wcacradleventhasurge" );
    }
    
    thread function_3986c1d9879c8c92( vent, var_9f7837a82fe27a12 );
}

// Namespace ob_activity_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0xccae082b, Offset: 0x1216
// Size: 0x241
function private function_3986c1d9879c8c92( vent, var_fba59a90630d98da )
{
    level endon( #"game_ended" );
    self endon( #"hash_cc1a314ee2de90de" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_84161ab643b82df5 = 0;
    var_ffb76271b145a301 = 0;
    var_d10dfd0c2397b564 = undefined;
    progressstage = vent.curprogress;
    sparkstate = undefined;
    var_419e1fe764430ea8 = undefined;
    self.var_5db7034c46afe8d0 = 0;
    
    switch ( var_fba59a90630d98da )
    {
        case 1:
            var_ffb76271b145a301 = self.var_c57f1a6a14851f6a;
            var_d10dfd0c2397b564 = "wcacradleventhackone";
            sparkstate = "small_spark_turret_joints";
            var_419e1fe764430ea8 = "react_33";
            break;
        case 2:
            var_ffb76271b145a301 = self.var_677b2a56c9853d6f;
            var_d10dfd0c2397b564 = "wcacradleventhacktwo";
            sparkstate = "medium_spark_turret_joints";
            var_419e1fe764430ea8 = "react_66";
            break;
        case 3:
            var_ffb76271b145a301 = self.var_c4817b30b2a54dd6;
            var_419e1fe764430ea8 = "death";
            break;
        default:
            break;
    }
    
    while ( true )
    {
        if ( !self.var_5ee74880ad353f65 )
        {
            waitframe();
            continue;
        }
        
        var_84161ab643b82df5 += level.framedurationseconds;
        vent.curprogress = progressstage + int( var_84161ab643b82df5 );
        totalprogress = function_29cc3d70a6907827();
        activity_definition_utils::updateprogress( totalprogress, self );
        
        if ( var_84161ab643b82df5 >= var_ffb76271b145a301 )
        {
            if ( var_419e1fe764430ea8 )
            {
                vent setscriptablepartstate( "body_anim", var_419e1fe764430ea8 );
            }
            
            if ( sparkstate )
            {
                vent setscriptablepartstate( "sparks", sparkstate );
            }
            
            if ( var_d10dfd0c2397b564 )
            {
                function_52ac37be091e08f( self.vent_scriptable.objectivemarker );
                ob_activity_vo_utility::function_639b0047db8aec67( self, var_d10dfd0c2397b564 );
            }
            
            if ( var_fba59a90630d98da == 3 )
            {
                vent setscriptablepartstate( "hack_interaction", "unusable" );
                vent setscriptablepartstate( "NexusManagedScriptablePart_Objective_Marker", "hidden" );
                vent_destroy( vent );
            }
            else
            {
                vent setscriptablepartstate( "hack_interaction", "usable" );
                vent setscriptablepartstate( "vent", "off" );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace ob_activity_cradle_vents
// Params 2, eflags: 0x4
// Checksum 0xd5c2f534, Offset: 0x145f
// Size: 0x99
function private function_52ac37be091e08f( objective_marker, var_bf84ec8813654b15 )
{
    if ( !var_bf84ec8813654b15 )
    {
        var_bf84ec8813654b15 = self.playerparticipants;
    }
    
    foreach ( player in var_bf84ec8813654b15 )
    {
        objidpoolmanager::objective_playermask_addshowplayer( objective_marker, player );
    }
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xcdab3539, Offset: 0x1500
// Size: 0xb9
function private function_2d9aa51253277d92( var_bf84ec8813654b15 )
{
    if ( self.vent_scriptable && self.vent_scriptable getscriptablepartstate( "hack_interaction" ) != "unusable" )
    {
        foreach ( player in var_bf84ec8813654b15 )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.vent_scriptable.objectivemarker, player );
        }
    }
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xa3ab7007, Offset: 0x15c1
// Size: 0x3e
function private vent_destroy( vent_ent )
{
    vent_ent setscriptablepartstate( "vent", "destroyed" );
    wait 4;
    vent_ent setscriptablepartstate( "vent", "only_smoke" );
    vent_ent notify( #"vent_destroyed" );
}

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0xc
// Checksum 0x24a24577, Offset: 0x1607
// Size: 0x70
function private function_67b0311c3f82173b()
{
    self notify( #"hash_371567e2158c5625" );
    self endon( #"hash_371567e2158c5625" );
    level endon( #"game_ended" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    
    while ( true )
    {
        players_affected = ob_cradle_gas_circle::function_5424e6517829836a( self.core_struct );
        self.var_5ee74880ad353f65 = players_affected.size > 0;
        waitframe();
    }
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xe17a0706, Offset: 0x167f
// Size: 0x1b
function private function_b941a040990bcfec( variance )
{
    return randomint( 2 * variance + 1 ) - variance;
}

/#

    // Namespace ob_activity_cradle_vents
    // Params 0
    // Checksum 0xfaa75da2, Offset: 0x16a3
    // Size: 0x5, Type: dev
    function function_d7d8b77db42213d3()
    {
        
    }

#/

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0x35dd52ed, Offset: 0x16b0
// Size: 0x62
function private function_3e4a8bb61094f362( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( self.var_f5f71b2058a9b606 <= 0 )
    {
        return;
    }
    
    if ( activity_instance_common::getactivitystate( self ) == "Ended" )
    {
        return;
    }
    
    if ( self.playerparticipants.size > 0 )
    {
        return;
    }
    
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcacradleventsfail", player_list );
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xa94e19fb, Offset: 0x171a
// Size: 0x76
function private function_e7528ec0dc674858( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    
    if ( self.vent_scriptable && self.vent_scriptable getscriptablepartstate( "hack_interaction" ) != "unusable" )
    {
        function_52ac37be091e08f( self.vent_scriptable.objectivemarker, player_list );
    }
    
    ob_activity_vo_utility::function_639b0047db8aec67( self, "wcacradleventsbrief", player_list );
}

// Namespace ob_activity_cradle_vents
// Params 1, eflags: 0x4
// Checksum 0xdf1a5f1, Offset: 0x1798
// Size: 0x2c
function private function_3541bd4a02a62c84( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    function_2d9aa51253277d92( player_list );
}

// Namespace ob_activity_cradle_vents
// Params 1
// Checksum 0xbe815b69, Offset: 0x17cc
// Size: 0x75
function function_b0fd89fbec5fd811( player )
{
    if ( self.var_f5f71b2058a9b606 <= 0 || activity_instance_common::getactivitystate( self ) != "Active" )
    {
        return;
    }
    
    skip_vo = player.var_3bac63067b689d64 && player.var_3bac63067b689d64 + 10000 > gettime();
    
    if ( !skip_vo )
    {
        ob_activity_vo_utility::function_639b0047db8aec67( self, "wcacradleventhackfar", [ player ] );
    }
}

/#

    // Namespace ob_activity_cradle_vents
    // Params 0
    // Checksum 0xc3834fbb, Offset: 0x1849
    // Size: 0x5, Type: dev
    function function_8f9fcf54111856da()
    {
        
    }

#/

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0x197e72fb, Offset: 0x1856
// Size: 0xaa
function private spawn_zombies_boss()
{
    encounter_name = self.settings.var_d0b86aa2f1d43b9e;
    
    if ( !isdefined( encounter_name ) )
    {
        return;
    }
    
    spawn_radius = self.settings.var_f25d07f873ff6002;
    self.var_4b3a12db92cd2bd3 = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:" + encounter_name, self.core_struct.origin, spawn_radius, 1, 1, 1, 0 );
    activity_ai_encounters::function_52d1342183200a8f( self.var_4b3a12db92cd2bd3, &function_cf76c5654595b986, [ self ] );
    ai_spawn_director::function_c4cace40604d2bf9( self.var_4b3a12db92cd2bd3, &function_bd5e2c4786de280a, self );
}

// Namespace ob_activity_cradle_vents
// Params 0, eflags: 0x4
// Checksum 0xbf4c9907, Offset: 0x1908
// Size: 0x13a
function private function_9464570ccdf080fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    encounter_name = self.settings.var_5dede99369642dc2;
    
    if ( !isdefined( encounter_name ) )
    {
        return;
    }
    
    spawn_radius = self.settings.var_f25d07f873ff6002;
    self.var_734f383fb80b39f5 = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:" + encounter_name, self.core_struct.origin, spawn_radius, 1, 1, 1, 0 );
    function_a748fd0f51127844( self.var_734f383fb80b39f5, self.settings.var_871b6acea88542cb );
    function_bbd192652d1a9e18( self.var_734f383fb80b39f5, self.settings.var_fc17d611ca0b21f2 );
    activity_ai_encounters::function_dcf6bdb6ee9d1ca0( self.var_734f383fb80b39f5, &function_7626cf8ff0ad9dba, [ self ] );
    activity_ai_encounters::function_d33de057e760c97b( self.var_734f383fb80b39f5, &function_7a7e5871130af681, [ self ] );
    activity_ai_encounters::function_52d1342183200a8f( self.var_734f383fb80b39f5, &function_8528580be5023626, [ self ] );
    ai_spawn_director::function_c4cace40604d2bf9( self.var_734f383fb80b39f5, &function_bd5e2c4786de280a, self );
}

// Namespace ob_activity_cradle_vents
// Params 2
// Checksum 0xb562ee3b, Offset: 0x1a4a
// Size: 0x4a, Type: bool
function function_7626cf8ff0ad9dba( request_id, userdata )
{
    activity_instance = userdata[ 0 ];
    return activity_instance.var_5ee74880ad353f65 && activity_instance.var_5db7034c46afe8d0 < activity_instance.var_a451a1c23c51dd63;
}

// Namespace ob_activity_cradle_vents
// Params 2
// Checksum 0xed5b409c, Offset: 0x1a9d
// Size: 0x39
function function_7a7e5871130af681( request_id, userdata )
{
    activity_instance = userdata[ 0 ];
    
    if ( !isdefined( activity_instance ) )
    {
        return 1;
    }
    
    return activity_instance.var_7a7e5871130af681;
}

// Namespace ob_activity_cradle_vents
// Params 4
// Checksum 0xb3a0864f, Offset: 0x1adf
// Size: 0xb0
function function_cf76c5654595b986( requestid, userdata, agent, data )
{
    activity_instance = userdata[ 0 ];
    gas_radius = ob_cradle_gas_circle::get_gas_circle_radius( activity_instance.core_struct );
    agent.var_8b34867b04dadfb2 = 1;
    agent._blackboard.var_b213ded5043dfa2b = activity_instance.core_struct.origin;
    agent._blackboard.var_6a8c50efac75caa1 = gas_radius;
    ob_activity_vo_utility::function_639b0047db8aec67( activity_instance, "wcacradleventhackboss" );
}

// Namespace ob_activity_cradle_vents
// Params 2
// Checksum 0x29a0db1c, Offset: 0x1b97
// Size: 0x54
function function_bd5e2c4786de280a( requestid, activityinstance )
{
    if ( self.asmname == "zombie_base" )
    {
        return;
    }
    
    explosionfx = utility::getfx( "zombie_corpse_cleanup" );
    
    if ( explosionfx )
    {
        playfx( explosionfx, self.origin );
    }
}

// Namespace ob_activity_cradle_vents
// Params 4
// Checksum 0x6e44fbf2, Offset: 0x1bf3
// Size: 0x40
function function_8528580be5023626( requestid, userdata, agent, data )
{
    activity_instance = userdata[ 0 ];
    activity_instance thread function_86d2c6bc7e798555( agent );
}

// Namespace ob_activity_cradle_vents
// Params 1
// Checksum 0x68e41f92, Offset: 0x1c3b
// Size: 0x47
function function_86d2c6bc7e798555( ai )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ai waittill( #"death" );
    self.var_5db7034c46afe8d0 += 1;
}

// Namespace ob_activity_cradle_vents
// Params 2
// Checksum 0xf4de6cf, Offset: 0x1c8a
// Size: 0x103
function function_ac3e6139a6ee0916( hack_effect, attacker )
{
    utility::callsharedfunc( #"gametype", #"hash_6e7ad51030328c8e" );
    self setscriptablepartstate( "vent", "hacked" );
    activity_instance = self.activity_instance;
    boss_request_id = activity_instance.var_4b3a12db92cd2bd3;
    encounter_request_id = activity_instance.var_734f383fb80b39f5;
    activity_instance ob_activity_utility::function_894ac80e038636c5( "wcacradleventshackdone", activity_instance.playerparticipants );
    
    if ( boss_request_id && function_9b649316adcccbaa( boss_request_id ) )
    {
        activity_instance activity_ai_encounters::function_46dadc3aca2ffac0( boss_request_id, 1 );
        activity_instance.var_4b3a12db92cd2bd3 = undefined;
    }
    
    if ( encounter_request_id && function_9b649316adcccbaa( encounter_request_id ) )
    {
        function_a748fd0f51127844( encounter_request_id, activity_instance.settings.var_871b6acea88542cb );
        function_bbd192652d1a9e18( encounter_request_id, activity_instance.settings.var_fc17d611ca0b21f2 );
    }
}

// Namespace ob_activity_cradle_vents
// Params 1
// Checksum 0xf1b6b5ac, Offset: 0x1d95
// Size: 0x98
function function_bbedc08d62f07525( params )
{
    player = params.hacker;
    black_hat_data = params.black_hat_data;
    assert( player && black_hat_data );
    player endon( #"death_or_disconnect" );
    vent_scriptable = self;
    
    while ( black_hat_data.state == "hacking" )
    {
        wait 0.2;
    }
    
    if ( black_hat_data.var_aa778d21f7d75252 )
    {
        black_hat_data.var_aa778d21f7d75252 = 0;
    }
}

