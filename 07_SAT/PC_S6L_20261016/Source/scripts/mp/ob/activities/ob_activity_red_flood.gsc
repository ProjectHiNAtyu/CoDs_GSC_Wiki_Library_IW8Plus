// scripts\mp\ob\activities\ob_activity_red_flood.gsc  (hash_553f5e248f629368.gscc) (size: 42773 Bytes / 0xa715 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeda1e143 (3986809155)
// size ...... 42773 (0xa715)
// includes .. 45  (offset: 0x9db9)
// strings ... 113 (offset: 0x9f21)
// dev strs .. 35  (offset: 0xa555)
// exports ... 104 (offset: 0x6265)
// cseg ...... 0x91a + 0x594b (0x6265)
// imports ... 358 (offset: 0x72a5)
// animtree1 . 0   (offset: 0xa715)
// animtree2 . 0   (offset: 0xa715)
#using script_16ea1b94f0f381b3;
#using script_3455b106458253e7;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\asm\asm;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_galileo\zombie_galileo;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_util;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_strike_boss_shared;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\jailbreak_machine;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_activity_instance_common;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\ob_nightmare_portal;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_red_flood;

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x5
// Checksum 0x84675d5b, Offset: 0x938
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_red_flood", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x5248950, Offset: 0x961
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_RED_FLOOD", &toxin_bomb_activity_type_init );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xe06b218c, Offset: 0x97c
// Size: 0xe8
function private toxin_bomb_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_RED_FLOOD", 0, &toxin_bomb_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_RED_FLOOD", 1, &toxin_bomb_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_RED_FLOOD", 2, &toxin_bomb_activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_RED_FLOOD", 3, &toxin_bomb_activity_destroy );
    activity_common::function_944074f3079c1d4e( "REV_OB_RED_FLOOD", 4, &function_adc869635c61b6d8 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &on_player_joined_activity, "REV_OB_RED_FLOOD" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &on_player_left_activity, "REV_OB_RED_FLOOD" );
    scriptable::scriptable_addusedcallbackbypart( "red_flood_cradle_crate", &cradle_crate_used );
    setdvar( @"hash_3f0d3a2d3b10d7ef", 1 );
    level callback::add( "on_zombie_viper_eject", &function_df419e0e03604139 );
    utility::registersharedfunc( #"zombie_neptune", #"hash_fbd76818aa0a93", &function_8edede1864597301 );
    
    /#
        level thread init_devgui();
    #/
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x7c6e6a89, Offset: 0xa6c
// Size: 0x19a
function private toxin_bomb_activity_setup()
{
    var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.bomb_explode_countdown = var_91c91f4a631c481d.explodecountdown;
    self.var_124d37318b71248a = var_91c91f4a631c481d.var_b0e7811b12bc18cd;
    self.var_546e4eb5269dbafa = "difficulty5";
    min_start_time = var_91c91f4a631c481d.minstarttime;
    max_start_time = var_91c91f4a631c481d.maxstarttime;
    start_time = min_start_time;
    
    if ( max_start_time > min_start_time )
    {
        start_time = randomintrange( min_start_time, max_start_time );
    }
    
    self.boss_circle_radius = get_override_setting( "boss_circle_radius", 2000 );
    start_time = get_override_setting( "start_wait", start_time );
    self.var_2c7df72824504573 = 0;
    self.var_124d37318b71248a = get_override_setting( "min_boss_damage_ratio", self.var_124d37318b71248a );
    
    /#
        self.bomb_explode_countdown = function_a5cd5a36ccebe58( "<dev string:x24>", self.bomb_explode_countdown );
    #/
    
    setgameprops( %"sat_ob_toxin_bomb" );
    self.s_master = utility::getstruct( self.varianttag, "targetname" );
    phase_structs = [];
    phase_structs = self.s_master utility::get_linked_structs();
    
    /#
        if ( function_12b3b66b7683566b() )
        {
            self.phase_structs = phase_structs;
            function_bc7f37b9e2f7927b();
            return;
        }
    #/
    
    phase_struct = utility::array_random( phase_structs );
    setup_phase_struct( phase_struct );
    self.phase_struct = phase_struct;
    
    if ( start_time )
    {
        wait start_time;
    }
    
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xd24ba200, Offset: 0xc0e
// Size: 0x2be
function private toxin_bomb_activity_begin()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, 0, 1 );
    thread function_66c17bd942de7a99( self.phase_struct );
    self waittill( #"phase_end" );
    
    if ( self.var_124d37318b71248a > 0 )
    {
        var_77013cab2cfe49a5 = [];
        var_ce8e547981b990fb = [];
        var_bfd2870910858fe = self.var_124d37318b71248a * self.var_2c7df72824504573 / 100;
        
        foreach ( player in self.playerparticipants )
        {
            var_3f000c9156465fcf = self.var_d37b5fa0bcc48a74[ player getxuid() ];
            
            if ( !var_3f000c9156465fcf || var_3f000c9156465fcf < var_bfd2870910858fe )
            {
                var_77013cab2cfe49a5[ player getxuid() ] = player;
                continue;
            }
            
            var_ce8e547981b990fb[ player getxuid() ] = player;
        }
        
        foreach ( player in var_77013cab2cfe49a5 )
        {
            squadcredit = 0;
            squad = teams::function_72b89edf6b47c40a( player );
            
            foreach ( squadmate in squad.players )
            {
                if ( squadmate == player )
                {
                    continue;
                }
                
                if ( isplayer( var_ce8e547981b990fb[ squadmate getxuid() ] ) )
                {
                    squadcredit = 1;
                    break;
                }
            }
            
            if ( !squadcredit )
            {
                var_3f000c9156465fcf = self.var_d37b5fa0bcc48a74[ player getxuid() ];
                logstring( "[RED_FLOOD] player " + player.name + " removed from activity rewards due to insufficient boss damage: " + ( var_3f000c9156465fcf ?? 0 ) + " / " + self.var_2c7df72824504573 );
                activity_participation::function_61aa2b2879f2c0a2( self, player );
            }
        }
    }
    
    function_125852f491cf7e5d();
    ob_nightmare_portal::enable_nightmare_portal( self.playerparticipants, "leo" );
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x60329d88, Offset: 0xed4
// Size: 0x69
function private toxin_bomb_activity_end()
{
    self endon( #"instance_destroyed" );
    toxin_bomb_activity_cleanup();
    params = { #radius:self.phase_struct.radius, #origin:self.phase_struct.origin };
    level callback::callback( "activity_nightmare_zone_finish", params );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xfb5a232, Offset: 0xf45
// Size: 0x9
function private toxin_bomb_activity_destroy()
{
    toxin_bomb_activity_cleanup();
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xd7c75d8d, Offset: 0xf56
// Size: 0xa8
function private toxin_bomb_activity_cleanup()
{
    phase_struct = self.phase_struct;
    phase_struct function_8a7d76b89ec2cf8();
    phase_struct cleanup_br_circle();
    phase_struct function_54efd1cd90aee6f0( self );
    phase_struct cleanup_boss_objective_marker();
    phase_struct function_2bb49caeb1c9a07f();
    phase_struct clear_flash();
    
    if ( phase_struct.cradle_crate_ambient_objective_name )
    {
        function_71799ce2c69ce5a9( phase_struct.cradle_crate_ambient_objective_name );
        phase_struct.cradle_crate_ambient_objective_name = undefined;
    }
    
    if ( phase_struct.boss_ambient_objective_name )
    {
        function_71799ce2c69ce5a9( phase_struct.boss_ambient_objective_name );
        phase_struct.boss_ambient_objective_name = undefined;
    }
    
    ob_activity_strike_boss_shared::function_61aa7b6027b4191e( self );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x8605460f, Offset: 0x1006
// Size: 0x1f
function private function_adc869635c61b6d8()
{
    return self.phase_struct.cradle_crate.origin;
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xc6f56944, Offset: 0x102e
// Size: 0x35
function private on_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    self.phase_struct function_7156bba523537dac( player_list );
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xb98a0579, Offset: 0x106b
// Size: 0x35
function private on_player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    self.phase_struct function_530d5e82cd6fa756( player_list );
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x6cfbac56, Offset: 0x10a8
// Size: 0x1dd
function private setup_phase_struct( phasestruct )
{
    var_74f05ac6a577955c = get_spawn_boss_type();
    boss_structs = phasestruct namespace_be3150865da9d2f1::get_linked_structs_filtered( "boss_spawn", "script_noteworthy" );
    var_8db985351ff268f1 = [];
    
    if ( var_74f05ac6a577955c == "neptune" )
    {
        foreach ( var_e04c0425c57a325 in boss_structs )
        {
            if ( var_e04c0425c57a325.script_parameters == "boss_all" )
            {
                var_8db985351ff268f1[ var_8db985351ff268f1.size ] = var_e04c0425c57a325;
            }
        }
    }
    else
    {
        var_8db985351ff268f1 = boss_structs;
    }
    
    phasestruct.boss_structs = var_8db985351ff268f1;
    phasestruct.var_e6addf73de340819 = utility::array_random( var_8db985351ff268f1 );
    phasestruct.var_e6addf73de340819.type = var_74f05ac6a577955c;
    phasestruct.activity_instance = self;
    phasestruct setup_cradle_crate();
    return_points = phasestruct namespace_be3150865da9d2f1::get_linked_structs_filtered( "return_point", "script_noteworthy" );
    phasestruct.return_points = [];
    
    foreach ( return_point in return_points )
    {
        phasestruct.return_points[ phasestruct.return_points.size ] = return_point.origin;
    }
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0xe7d95ead, Offset: 0x128d
// Size: 0xa4
function private function_a062b5f3ed53f11a( usable, player )
{
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
    
    return { #string:&"sat_ob_activities/contract_taurus_destroy_supplies_interact", #type:"HINT_NOICON" };
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x36df2d3e, Offset: 0x1339
// Size: 0x52a
function private function_66c17bd942de7a99( phasestruct )
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    activity_participation::function_5e5913e13bf9cb28( self );
    phasestruct.started = 1;
    activity_definition_utils::function_a0a94881bc380bbf( 0, self );
    activity_definition_utils::updateprogress( 0, self, 100 );
    phasestruct.cradle_crate setscriptablepartstate( #"red_flood_cradle_crate", #"usable" );
    phasestruct.cradle_crate interaction::set_interact_hint_callback( &function_a062b5f3ed53f11a );
    phasestruct.cradle_crate setscriptablepartstate( #"icon", #"show" );
    phasestruct.cradle_crate_ambient_objective_name = self.varianttag + "_cradle_crate_ambient_objective";
    function_1c4c7ef874191be2( phasestruct.cradle_crate_ambient_objective_name, phasestruct.cradle_crate.origin, 2000 );
    phasestruct waittill( #"cradle_crate_used", player );
    wait 5;
    spatial_zone_struct = spatial_zone_container::function_847140d2863dfbf8( self, "Awareness_Zone", phasestruct.cradle_crate.origin, 2000, 1 );
    activity_participation::function_a45fd1c5cc774007( self );
    
    if ( player )
    {
        activity_participation::function_bc67362dace4370c( self, player );
    }
    
    phasestruct function_d7abcacdd4b382f5();
    phasestruct function_a76d3530c19ddf03();
    phasestruct function_7156bba523537dac( self.playerparticipants );
    phasestruct waittill( #"hash_745f9dfb87f9cbea" );
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    function_71799ce2c69ce5a9( phasestruct.cradle_crate_ambient_objective_name );
    phasestruct.cradle_crate_ambient_objective_name = undefined;
    wait 1;
    phasestruct function_2bb49caeb1c9a07f();
    phasestruct.cradle_crate setscriptablepartstate( #"icon", #"hidden" );
    phasestruct.cradle_crate calloutmarkerping::function_608710c894185549();
    activity_definition_utils::function_a0a94881bc380bbf( 1, self );
    activity_definition_utils::updateprogress( 0, self, 1 );
    disabled_area = ob_activity_manager::function_2359b9c5c7e92432( phasestruct.origin, phasestruct.radius );
    phasestruct thread function_368a5c717b3f267d();
    phasestruct setup_explode_objective_marker( self );
    phasestruct function_2dd4ea1adec3dd04();
    phasestruct.cradle_crate utility::function_32b24db3127bff40( #"complete_fx", #"on" );
    earthquake( 0.68, 4, phasestruct.cradle_crate.origin, 1200 );
    
    foreach ( player in self.playerparticipants )
    {
        if ( distancesquared( player.origin, phasestruct.cradle_crate.origin ) < 1440000 )
        {
            player playrumbleonentity( "heavy_2s" );
        }
    }
    
    phasestruct thread function_f8161530e839a585();
    bomb_explode_countdown( self.bomb_explode_countdown, phasestruct );
    phasestruct function_8a7d76b89ec2cf8();
    spatial_zone_container::function_ddcd5f35f0032b25( self, "Awareness_Zone", spatial_zone_struct );
    spatial_zone_struct = spatial_zone_container::function_847140d2863dfbf8( self, "Awareness_Zone", phasestruct.origin, phasestruct.radius, 1 );
    ob_activity_strike_boss_shared::function_33d7c1273681ab9f( phasestruct.origin, phasestruct.radius );
    ob_activity_strike_boss_shared::function_faeba2b042cc0dd6( self );
    phasestruct toxin_bomb_explode();
    waitframe();
    activity_definition_utils::function_a0a94881bc380bbf( 2, self );
    ob_activity_strike_boss_shared::function_e67794b46217642e( self.varianttag + "phase" + phasestruct.var_1e562e6847201882, phasestruct.origin, phasestruct.radius, phasestruct.height );
    ob_activity_strike_boss_shared::function_794686ee5a2eb3b6( phasestruct.origin, phasestruct.radius, phasestruct.cradle_crate.origin );
    phasestruct setup_br_circle( 5 );
    phasestruct spawn_ai( self, phasestruct.var_e6addf73de340819 );
    phasestruct.boss_ambient_objective_name = self.varianttag + "_boss_ambient_objective";
    function_1c4c7ef874191be2( phasestruct.boss_ambient_objective_name, phasestruct.var_e6addf73de340819.origin, 4000 );
    phasestruct waittill( #"boss_killed" );
    function_71799ce2c69ce5a9( phasestruct.boss_ambient_objective_name );
    phasestruct.boss_ambient_objective_name = undefined;
    ob_activity_manager::function_2db7d17b1053ea5b( disabled_area );
    phasestruct function_9402936a7a7a40be();
    phasestruct function_54efd1cd90aee6f0( self );
    phasestruct cleanup_br_circle( 3 );
    phasestruct.ended = 1;
    self notify( "phase_" + phasestruct.var_1e562e6847201882 + "_end" );
    self notify( #"phase_end" );
    wait 1;
    activity_participation::function_5e5913e13bf9cb28( self );
    spatial_zone_container::function_ddcd5f35f0032b25( self, "Awareness_Zone", spatial_zone_struct );
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0x7f455994, Offset: 0x186b
// Size: 0x96
function private bomb_explode_countdown( seconds, phasestruct )
{
    if ( seconds )
    {
        hud_util::showsplashtoall( #"hash_df74149365c69860" );
        setomnvar( o"ui_world_event_timer", gettime() + seconds * 1000 );
        activity_definition_utils::updatetimer( seconds, self );
        waittime = seconds - 7;
        
        if ( waittime > 0 )
        {
            wait waittime;
            phasestruct.var_eeda90565541f8c3 = 1;
            wait 7;
        }
        else
        {
            phasestruct.var_eeda90565541f8c3 = 1;
            wait seconds;
        }
    }
    
    activity_definition_utils::updatetimer( 0, self );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x375f1e1d, Offset: 0x1909
// Size: 0x5e
function private toxin_bomb_explode()
{
    self.cradle_crate setscriptablepartstate( #"red_flood_cradle_crate", #"unusable_destroyed" );
    self.cradle_crate thread clip_remove();
    wait 2;
    hud_util::showsplashtoall( #"hash_99cb3058cb919a6" );
    player_effective( self.origin, self.radius );
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0xec3e95a9, Offset: 0x196f
// Size: 0xea
function private player_effective( var_ed8bab9657750de2, radius )
{
    var_f9b7e60e3ab4dd1b = 10000;
    players_near_explosion = getplayersinradius( var_ed8bab9657750de2, radius + var_f9b7e60e3ab4dd1b, undefined, 1 );
    
    foreach ( player in players_near_explosion )
    {
        dist = distance( player.origin, var_ed8bab9657750de2 );
        
        if ( dist <= radius || utility::within_fov( player geteye(), player getplayerangles(), var_ed8bab9657750de2, 0.34202 ) )
        {
            player thread function_20dd5f051647ac66();
        }
    }
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x519f70c6, Offset: 0x1a61
// Size: 0xcd
function private function_20dd5f051647ac66()
{
    player = self;
    player endon( #"disconnect" );
    player.var_753b31fc1dd0e162 = 1;
    player.var_33cc5b033ddc1c9d = 1;
    player hud_util::function_a7b5c7ac6074b623( "red_tint", "white", ( 0.2, 0, 0.02 ) );
    player playlocalsound( "amb_cradled_start_heavy" );
    player giveandfireoffhand( "sat_ob_activity_crash_site_blast_start" );
    player thread hud_util::fade_out( 1, "red_tint" );
    msg = player utility::waittill_notify_or_timeout_return( "death", 1.5 );
    
    if ( msg != "death" )
    {
        player thread hud_util::fade_in( 1, "red_tint" );
    }
    
    player.var_753b31fc1dd0e162 = undefined;
    player.var_33cc5b033ddc1c9d = undefined;
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xfd66da9a, Offset: 0x1b36
// Size: 0x61
function private setup_br_circle( duration )
{
    self.br_circle = spawnbrcircle( self.origin[ 0 ], self.origin[ 1 ], 0 );
    self.br_circle brcirclemoveto( self.origin[ 0 ], self.origin[ 1 ], self.radius, duration );
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xb3091bf1, Offset: 0x1b9f
// Size: 0x79
function private cleanup_br_circle( duration )
{
    level endon( #"game_ended" );
    
    if ( !self.br_circle )
    {
        return;
    }
    
    br_circle = self.br_circle;
    self.br_circle = undefined;
    
    if ( duration )
    {
        br_circle brcirclemoveto( br_circle.origin[ 0 ], br_circle.origin[ 1 ], 0, duration );
        wait duration;
    }
    
    br_circle delete();
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xf4c5f61a, Offset: 0x1c20
// Size: 0x2e
function private function_d178d3a6203f9dda()
{
    speed_value = "run";
    
    if ( self.subclass == "zombie_neptune" )
    {
        speed_value = "sprint";
    }
    
    return speed_value;
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xfc441930, Offset: 0x1c57
// Size: 0x1f8
function private function_86e8446c583cf643( position )
{
    agent = self;
    agent endon( #"death" );
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent clearbtgoal( 3 );
    
    if ( self.subclass == "zombie_galileo" )
    {
        zombie_galileo::function_84919f8f8db67077( position + ( 0, 0, 50 ) );
        agent clearenemy();
        return 1;
    }
    
    wait randomfloatrange( 1, 2 );
    agent setbtgoalpos( 0, position );
    agent setbtgoalpos( 1, position );
    agent setbtgoalradius( 0, 256 );
    agent setbtgoalradius( 1, 256 );
    speed_value = agent function_d178d3a6203f9dda();
    agent zombie_utils::function_a8ce00e0448cb6f0( speed_value, "oob", 1000 );
    
    while ( true )
    {
        msg = agent utility::waittill_any_timeout( 1, "goal", "bad_path", "goal_reached", "bt_goal" );
        
        if ( msg != "timeout" )
        {
            if ( msg == "bad_path" )
            {
                /#
                    script::demoforcesre( "<dev string:x3b>" + agent.origin + "<dev string:x75>" + position );
                    debugstar( agent.origin, ( 1, 0, 0 ), 10000, "<dev string:x7c>", 1 );
                    debugstar( position, ( 1, 0, 0 ), 10000, "<dev string:x8a>", 1 );
                #/
                
                bad_path = 1;
            }
            else
            {
                goalreached = 1;
            }
        }
        
        if ( bad_path || goalreached || distance( agent.origin, position ) <= 256 )
        {
            break;
        }
    }
    
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent clearbtgoal( 3 );
    agent clearenemy();
    agent zombie_utils::function_a8ce00e0448cb6f0( undefined, "oob", 1000 );
    return goalreached;
}

// Namespace ob_activity_red_flood
// Params 4, eflags: 0x4
// Checksum 0xfa7aedb4, Offset: 0x1e58
// Size: 0x231
function private function_fd5d1c4d005b2eba( phase_struct, return_points, origin, radius )
{
    activity_instance = phase_struct.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"death" );
    
    if ( !isdefined( return_points ) )
    {
        return_points = phase_struct.return_points;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = phase_struct.origin;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = phase_struct.radius;
    }
    
    while ( true )
    {
        max_path_distance = get_override_setting( "path_distance", 5000 );
        distance = distance2d( self.origin, origin );
        is_oob = distance > radius;
        
        if ( is_oob )
        {
            target_point = self.spawn_point;
            
            if ( !target_point || distance2d( target_point, self.origin ) > 5000 )
            {
                if ( return_points )
                {
                    target_point = utility::function_4325398d215ecda5( self.origin, return_points, max_path_distance );
                    
                    /#
                        if ( function_12b3b66b7683566b() )
                        {
                            foreach ( point in return_points )
                            {
                                sphere( point, 50, ( 1, 0, 0 ), 0, 10000 );
                            }
                        }
                    #/
                }
                
                if ( !target_point )
                {
                    target_point = origin;
                    
                    if ( distance > max_path_distance )
                    {
                        target_point = self.origin + ( origin - self.origin ) * max_path_distance / distance;
                    }
                }
            }
            
            rally_point = getclosestpointonnavmesh( target_point, self );
            
            /#
                if ( function_12b3b66b7683566b() )
                {
                    sphere( rally_point, 100, ( 0, 1, 0 ), 0, 10000 );
                }
            #/
            
            if ( !function_86e8446c583cf643( rally_point ) )
            {
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0xb565b5ef, Offset: 0x2091
// Size: 0x425
function private function_49aec247af5e6f8e( agent, var_ae9703559d262883 )
{
    phase_struct = self;
    activity_instance = phase_struct.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    agent endon( #"death" );
    phase_struct.objective_visible_players = [];
    circle_visible_players = [];
    var_878871edf0427e10 = [];
    function_38b84cb3d4357dd7( phase_struct.objidnum );
    
    while ( true )
    {
        if ( phase_struct.var_9b25ffe2ea627147 )
        {
            waitframe();
        }
        
        origin = agent.origin;
        
        if ( distance2d( origin, phase_struct game_utility::questcircle_getorigin() ) > activity_instance.boss_circle_radius )
        {
            var_8ab3796720882ae2 = function_58a48b475151b2ca( origin );
            phase_struct game_utility::questcircle_move( var_8ab3796720882ae2 );
            objidpoolmanager::update_objective_position( phase_struct.var_f5c810a9fb1c44a7, var_8ab3796720882ae2 + ( 0, 0, 500 ) );
        }
        
        var_dd31ae14e0da26a7 = getplayersinradius( phase_struct.origin, phase_struct.radius );
        players_in_circle = getplayersinradius( origin, var_ae9703559d262883 );
        var_47e5dc4547b7bf15 = arrayintersection( players_in_circle, var_dd31ae14e0da26a7 );
        var_7ed1757c5990cc75 = arrayremove( phase_struct.objective_visible_players, var_47e5dc4547b7bf15 );
        namespace_d7fa4530141146a5::function_831cf83f2b250537( var_7ed1757c5990cc75, phase_struct.var_a1e462ff5f205346 );
        phase_struct hide_boss_healthbar( var_7ed1757c5990cc75 );
        var_7f018ac8429ecb8c = arrayremove( var_47e5dc4547b7bf15, phase_struct.objective_visible_players );
        namespace_d7fa4530141146a5::function_7c5730b9151d91( var_7f018ac8429ecb8c, phase_struct.var_a1e462ff5f205346 );
        phase_struct update_boss_healthbar( var_7f018ac8429ecb8c );
        phase_struct.objective_visible_players = var_47e5dc4547b7bf15;
        var_10ed0875aab33010 = arrayremove( var_dd31ae14e0da26a7, var_47e5dc4547b7bf15 );
        new_circle_visible_players = arrayremove( var_10ed0875aab33010, circle_visible_players );
        
        foreach ( player in new_circle_visible_players )
        {
            phase_struct game_utility::questcircle_showtoplayer( player );
        }
        
        namespace_d7fa4530141146a5::function_7c5730b9151d91( new_circle_visible_players, phase_struct.var_f5c810a9fb1c44a7 );
        var_aff02970e376eb6c = arrayremove( circle_visible_players, var_10ed0875aab33010 );
        
        foreach ( player in var_aff02970e376eb6c )
        {
            phase_struct game_utility::questcircle_hidefromplayer( player );
        }
        
        namespace_d7fa4530141146a5::function_831cf83f2b250537( var_aff02970e376eb6c, phase_struct.var_f5c810a9fb1c44a7 );
        circle_visible_players = var_10ed0875aab33010;
        var_bfc125e3408d6e2f = arrayremove( var_dd31ae14e0da26a7, var_878871edf0427e10 );
        
        foreach ( player in var_bfc125e3408d6e2f )
        {
            objective_addclienttomask( phase_struct.objidnum, player );
        }
        
        var_c51626b8a9bf7a = arrayremove( var_878871edf0427e10, var_dd31ae14e0da26a7 );
        
        foreach ( player in var_c51626b8a9bf7a )
        {
            objective_removeclientfrommask( phase_struct.objidnum, player );
        }
        
        var_878871edf0427e10 = var_dd31ae14e0da26a7;
        wait 0.1;
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xb6367772, Offset: 0x24be
// Size: 0x19
function private function_58a48b475151b2ca( bossorigin )
{
    return utility::function_9e0df7b136ab833c() * 500 + bossorigin;
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x61ff0470, Offset: 0x24e0
// Size: 0x147
function private setup_boss_objective_marker( agent )
{
    phasestruct = self;
    activityinstance = self.activity_instance;
    circle_origin = function_58a48b475151b2ca( agent.origin );
    phasestruct game_utility::questcircle_create( "Toxin_Bomb_Boss_Ob", circle_origin, 2000 );
    phasestruct game_utility::questcircle_hidefromall();
    phasestruct.var_f5c810a9fb1c44a7 = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_red_flood_boss_marker", 0, 0 );
    objective_showtoplayersinmask( phasestruct.var_f5c810a9fb1c44a7 );
    objective_removeallfrommask( phasestruct.var_f5c810a9fb1c44a7 );
    objidpoolmanager::update_objective_position( phasestruct.var_f5c810a9fb1c44a7, circle_origin + ( 0, 0, 500 ) );
    setup_hovercard( phasestruct.var_f5c810a9fb1c44a7 );
    phasestruct.var_a1e462ff5f205346 = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_red_flood_boss_marker", 0, 0 );
    objidpoolmanager::update_objective_onentity( phasestruct.var_a1e462ff5f205346, agent );
    objective_showtoplayersinmask( phasestruct.var_a1e462ff5f205346 );
    objective_removeallfrommask( phasestruct.var_a1e462ff5f205346 );
    setup_hovercard( phasestruct.var_a1e462ff5f205346 );
    function_92750efba138579a();
    phasestruct thread function_49aec247af5e6f8e( agent, 2000 );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xfe69a2ba, Offset: 0x262f
// Size: 0x7e
function private function_7871d7bfff217343()
{
    boss = self.current_boss;
    
    if ( boss.subclass == "zombie_neptune" )
    {
        switch ( boss.n_fight_phase )
        {
            case 1:
                return 200;
            case 2:
                return 280;
            case 3:
                return 380;
            default:
                return 200;
        }
    }
    
    return 140;
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x8cd4bebe, Offset: 0x26b6
// Size: 0x7b
function private function_92750efba138579a()
{
    if ( self.var_a1e462ff5f205346 )
    {
        height = function_7871d7bfff217343();
        objidpoolmanager::update_objective_setzoffset( self.var_a1e462ff5f205346, height );
        self.var_9b25ffe2ea627147 = 1;
        namespace_d7fa4530141146a5::function_831cf83f2b250537( self.objective_visible_players, self.var_a1e462ff5f205346 );
        waitframe();
        namespace_d7fa4530141146a5::function_7c5730b9151d91( self.objective_visible_players, self.var_a1e462ff5f205346 );
        waitframe();
        self.var_9b25ffe2ea627147 = undefined;
    }
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x9f017c77, Offset: 0x2739
// Size: 0x81
function private cleanup_boss_objective_marker()
{
    if ( self.var_f5c810a9fb1c44a7 )
    {
        self.activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_f5c810a9fb1c44a7 );
        self.var_f5c810a9fb1c44a7 = undefined;
    }
    
    if ( self.var_a1e462ff5f205346 )
    {
        self.activity_instance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_a1e462ff5f205346 );
        self.var_a1e462ff5f205346 = undefined;
    }
    
    game_utility::questcircle_delete();
    hide_boss_healthbar( self.objective_visible_players );
    self.objective_visible_players = undefined;
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0xc
// Checksum 0x34e085b1, Offset: 0x27c2
// Size: 0x9f
function private boss_killed_process( boss )
{
    self notify( #"hash_2f144bd017d0521d" );
    self endon( #"hash_2f144bd017d0521d" );
    activity_instance = self.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.reward_pos = boss.origin;
    
    if ( boss.subclass == "zombie_neptune" )
    {
        wait 5;
    }
    
    self.var_46a7c940287a3795 = 1;
    self notify( #"boss_killed" );
    cleanup_boss_objective_marker();
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x56069131, Offset: 0x2869
// Size: 0x32
function private on_boss_killed( params )
{
    phase_struct = self.phase_struct;
    
    if ( !phase_struct )
    {
        return;
    }
    
    phase_struct thread boss_killed_process( self );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x172a1659, Offset: 0x28a3
// Size: 0x153
function private function_125852f491cf7e5d()
{
    spawn_pos = self.reward_pos;
    
    if ( getdvarint( @"hash_2999ce8f234c7c74", 0 ) == 1 )
    {
        timersec = getdvarint( @"hash_800b48e5eb79f7e8", 120 );
        level thread jailbreak_machine::function_455ec409a27f78d9( spawn_pos, self.playerparticipants, timersec );
        return;
    }
    
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( spawn_pos );
    exotic_weapon = common_item::function_61c2c0251e742ffd( %"hash_6746660b468e32bb", undefined, spawn_options );
    exotic_weapon.scriptable_index = exotic_weapon getscriptableindex();
    ob_item_select::function_1dfd8b3bc8e33dd8( exotic_weapon );
    ob_item_select::function_923ddf97f6cdbee( exotic_weapon, self.playerparticipants );
    
    foreach ( player in self.playerparticipants )
    {
        ping_id = player calloutmarkerping::function_920a63c06abdefe8( exotic_weapon.scriptable_index );
        player calloutmarkerping_hide( ping_id );
        player calloutmarkerping_show( ping_id, player );
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x701f1690, Offset: 0x29fe
// Size: 0x63
function private create_boss_healthbar( boss )
{
    self.boss_healthbar_asset = boss get_boss_healthbar_asset();
    boss.ob_boss_healthbar_priority = 1;
    
    if ( boss.subclass == "zombie_neptune" )
    {
        neptune_func = &zombie_neptune::function_aa647407d5c4af0;
        boss zombie_boss_healthbar::function_d16104a6c7125d2d( neptune_func );
    }
    
    boss thread function_b9d89bb349dd89c9();
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x6ac101eb, Offset: 0x2a69
// Size: 0x54
function private function_b9d89bb349dd89c9()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        visible_players = self.phase_struct.objective_visible_players;
        self.phase_struct update_boss_healthbar( visible_players );
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x42b77fc6, Offset: 0x2ac5
// Size: 0xbd
function private function_4277594377debb5b( params )
{
    visible_players = self.phase_struct.objective_visible_players;
    
    foreach ( player in visible_players )
    {
        if ( player.var_71c37977095602df == self.phase_struct.boss_healthbar_asset )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x1c3e8fed, Offset: 0x2b8a
// Size: 0xbd
function private function_eee51fa9c4016f7( params )
{
    visible_players = self.phase_struct.objective_visible_players;
    
    foreach ( player in visible_players )
    {
        if ( player.var_71c37977095602df == self.phase_struct.boss_healthbar_asset )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
    }
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xf4438a7c, Offset: 0x2c4f
// Size: 0x10a
function private function_568aa46f55672ff9()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !self.phase_struct )
    {
        return;
    }
    
    activity_instance = self.phase_struct.activity_instance;
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        
        if ( isplayer( attackerplayer ) )
        {
            activity_instance = self.phase_struct.activity_instance;
            
            if ( !isdefined( activity_instance.var_d37b5fa0bcc48a74 ) )
            {
                activity_instance.var_d37b5fa0bcc48a74 = [];
            }
            
            var_d37b5fa0bcc48a74 = activity_instance.var_d37b5fa0bcc48a74;
            
            if ( !isdefined( var_d37b5fa0bcc48a74[ attackerplayer getxuid() ] ) )
            {
                var_d37b5fa0bcc48a74[ attackerplayer getxuid() ] = 0;
            }
            
            var_d37b5fa0bcc48a74[ attackerplayer getxuid() ] += damage;
        }
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x6f9cb89c, Offset: 0x2d61
// Size: 0xdc
function private function_ee796d3f0bfba9ed( params )
{
    if ( !self.phase_struct )
    {
        return;
    }
    
    eattacker = params.eattacker;
    attackerplayer = isplayer( eattacker ) ? eattacker : eattacker.owner;
    
    if ( isplayer( attackerplayer ) )
    {
        activity_instance = self.phase_struct.activity_instance;
        
        if ( !isdefined( activity_instance.var_d37b5fa0bcc48a74 ) )
        {
            activity_instance.var_d37b5fa0bcc48a74 = [];
        }
        
        var_d37b5fa0bcc48a74 = activity_instance.var_d37b5fa0bcc48a74;
        
        if ( !isdefined( var_d37b5fa0bcc48a74[ attackerplayer getxuid() ] ) )
        {
            var_d37b5fa0bcc48a74[ attackerplayer getxuid() ] = 0;
        }
        
        var_d37b5fa0bcc48a74[ attackerplayer getxuid() ] += params.idamage;
    }
}

// Namespace ob_activity_red_flood
// Params 4, eflags: 0x4
// Checksum 0xdf96caef, Offset: 0x2e45
// Size: 0x360
function private boss_spawned_callback( requestid, userdata, agent, data )
{
    phase_struct = userdata[ 0 ];
    var_e04c0425c57a325 = userdata[ 1 ];
    activity_instance = phase_struct.activity_instance;
    phase_struct.current_boss = agent;
    agent.var_e94a0381e288005e = #"hash_99917007a6eaa6b4";
    agent.suppress_minimap_icon = 1;
    agent.disable_brain_rot = 1;
    agent._blackboard.var_b213ded5043dfa2b = var_e04c0425c57a325.origin;
    agent._blackboard.var_8d11b98561e1eb81 = 100;
    agent._blackboard.var_8d34ab856208146f = 200;
    agent.phase_struct = phase_struct;
    agent.spawn_point = agent.origin;
    agent allowvehiclepredictiveragdoll( 0 );
    
    if ( agent.subclass == "zombie_galileo" )
    {
        agent zombie_galileo::deploy();
        agent callback::add( "on_galileo_immune", &function_4277594377debb5b );
        agent callback::add( "on_galileo_non_immune", &function_eee51fa9c4016f7 );
    }
    else if ( agent.subclass == "zombie_neptune" )
    {
        agent callback::add( #"hash_b5e0b8a43edf3a0a", &function_587dbbd84b2564b5 );
        agent zombie_utils::function_dfae6a5bd222c586( &function_d22e024c904e080c );
        agent callback::add( #"hash_696b6f168d1d9c5c", &function_4575ac53c34c4acc );
    }
    
    var_2c1fe57a11983137 = 0;
    
    if ( agent.subclass == "zombie_viper_hvt" )
    {
        var_98c94d1c3650d11b = function_b3988325430ce242( agent.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ejectedsubclass );
        
        if ( !agent.var_c3746c711044489d && var_98c94d1c3650d11b )
        {
            var_2c1fe57a11983137 = 1;
            
            if ( !isdefined( agent.var_e128f7e1227e3b81 ) )
            {
                agent.var_e128f7e1227e3b81 = {};
            }
            
            agent.var_e128f7e1227e3b81.phase_struct = phase_struct;
            agent.var_e128f7e1227e3b81.spawn_point = agent.spawn_point;
            agent.var_e94a0381e288005e = undefined;
        }
    }
    
    if ( !var_2c1fe57a11983137 )
    {
        agent callback::add( #"on_ai_killed", &on_boss_killed );
    }
    
    phase_struct create_boss_healthbar( agent );
    phase_struct setup_boss_objective_marker( agent );
    
    if ( agent.subclass == "zombie_neptune" )
    {
        agent thread function_fd5d1c4d005b2eba( phase_struct, [], var_e04c0425c57a325.origin, var_e04c0425c57a325.radius );
    }
    else
    {
        agent thread function_fd5d1c4d005b2eba( phase_struct );
    }
    
    /#
        var_f791e93cc48c0c97 = function_a5cd5a36ccebe58( "<dev string:x9d>", 0 );
        
        if ( var_f791e93cc48c0c97 )
        {
            agent.maxhealth = var_f791e93cc48c0c97;
            agent.health = var_f791e93cc48c0c97;
        }
    #/
    
    activity_instance.var_2c7df72824504573 += agent.health;
    agent callback::add( #"on_ai_killed", &function_ee796d3f0bfba9ed );
    agent thread function_568aa46f55672ff9();
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x41b511f0, Offset: 0x31ad
// Size: 0xa3
function private function_d22e024c904e080c( params )
{
    if ( self getaiblackboarddynamic( "immune" ) )
    {
        return 0;
    }
    
    damage = params.idamage;
    
    if ( self.n_fight_phase < 3 && self.health - damage < self.maxhealth - self.maxhealth / 3 * self.n_fight_phase )
    {
        damage = self.health - self.maxhealth - self.maxhealth / 3 * self.n_fight_phase + 1;
    }
    
    return damage;
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xebc3c56b, Offset: 0x3259
// Size: 0x81
function private get_boss_healthbar_asset()
{
    switch ( self.subclass )
    {
        case #"hash_37f10bbc40bd509d":
            return "ob_boss_viper";
        case #"hash_736757d9a4744e":
        case #"hash_113b5b5dbf0d98af":
            return "ob_boss_viper_mini";
        case #"hash_cbf6d6666fca2f7d":
            return "ob_boss_galileo";
        case #"hash_da25b9d8214181":
            return "ob_boss_neptune";
        default:
            assertmsg( "<dev string:xa9>" );
            return;
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xaef3509b, Offset: 0x32e2
// Size: 0x14f
function private function_8878a4153f4ddcbd( player )
{
    if ( !self.current_boss )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        if ( !player.var_71c37977095602df )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( self.boss_healthbar_asset, self.current_boss );
        }
        else if ( player.var_71c37977095602df == self.boss_healthbar_asset )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
        else if ( player ob_story_mission_utils::function_6ec505041dcea08e( self.current_boss ) )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
            player ob_story_mission_utils::function_16e0adef86e5d052( self.boss_healthbar_asset, self.current_boss );
        }
    }
    else if ( player ob_story_mission_utils::function_6ec505041dcea08e( self.current_boss ) )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
        player ob_story_mission_utils::function_16e0adef86e5d052( self.boss_healthbar_asset, self.current_boss );
    }
    
    if ( player.var_71c37977095602df == self.boss_healthbar_asset )
    {
        if ( self.current_boss.immune || self.current_boss getaiblackboarddynamic( "immune" ) )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
        }
        
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xc80c41af, Offset: 0x3439
// Size: 0x7e
function private update_boss_healthbar( players )
{
    foreach ( player in players )
    {
        thread function_8878a4153f4ddcbd( player );
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x7d9e2638, Offset: 0x34bf
// Size: 0x96
function private hide_boss_healthbar( players )
{
    foreach ( player in players )
    {
        if ( player.var_71c37977095602df == self.boss_healthbar_asset )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
        }
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0xc
// Checksum 0xe2836222, Offset: 0x355d
// Size: 0x1ba
function private function_587dbbd84b2564b5( params )
{
    self notify( #"hash_376a3e92b520eaea" );
    self endon( #"hash_376a3e92b520eaea" );
    level endon( #"game_ended" );
    self endon( #"death" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( self.n_fight_phase >= 2 )
    {
        self.melee_knockback_enabled = 1;
        self.var_5a9c952260ab1cf = 1;
        self.var_6c41e8e873b7594e = settings.meleedamage;
        self.var_c8cf90daee0f67a3 = settings.var_e5070b52534334ac;
        self.knockback_angle = settings.knockbackangle;
        self.var_8eed320b7873f7d6 = settings.var_6707cfb0acb9e092;
        self.var_2966c3d9ec29d388 = settings.var_402bd8e634cdb1bc;
    }
    
    self function_786bb6aa1b76c7ee( "immune", 1 );
    function_4277594377debb5b();
    thread utility::callsharedfunc( #"zombie_neptune", #"hash_5bde7c89509f5672" );
    utility::waittill_any_in_array( [ "transition_explode_end", "special_pain_end" ] );
    increase_fight_phase();
    hide_neptune();
    wait settings.transitionwait;
    thread utility::callsharedfunc( #"zombie_neptune", #"hash_de07abc80a636fba" );
    utility::waittill_notify_or_timeout( "transition_trails_done", 9 );
    show_neptune();
    zombie_neptune_metabones::reset_metabones();
    zombie_neptune_metabones::function_4f4390eb16a079e7();
    self function_786bb6aa1b76c7ee( "immune", 0 );
    function_eee51fa9c4016f7();
    utility::callsharedfunc( #"zombie_neptune", #"hash_ac8eb8136345157e" );
    self.in_phase_transition = 0;
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x50033dcf, Offset: 0x371f
// Size: 0x3b
function private increase_fight_phase()
{
    assert( self.n_fight_phase < 3 );
    self.n_fight_phase += 1;
    callback::callback( #"hash_696b6f168d1d9c5c" );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x71bc4e68, Offset: 0x3762
// Size: 0x5a
function private hide_neptune()
{
    asm::function_7256f5ba459c840b( "idle_in" );
    self invisiblenotsolid();
    self hide();
    self hideallparts();
    zombie_neptune_metabones::function_c35ccbc3b1fbcab9();
    utility::function_32b24db3127bff40( "eye", "off" );
    utility::function_32b24db3127bff40( "movement", "off" );
    utility::function_32b24db3127bff40( "speed_boost", "off" );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x8e7cdb5b, Offset: 0x37c4
// Size: 0xb3
function private show_neptune()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    models = [ self.model, settings.var_8dd4e71c890f6f29, settings.var_8dd4e61c890f6cf6 ];
    self setmodel( models[ self.n_fight_phase - 1 ] );
    self visiblesolid();
    self show();
    self function_aa8ac009edde3f04();
    utility::function_32b24db3127bff40( "eye", "on_" + self.n_fight_phase );
    utility::function_32b24db3127bff40( "movement", "on_" + self.n_fight_phase );
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x66ea20cb, Offset: 0x387f
// Size: 0x66
function private function_4575ac53c34c4acc( params )
{
    if ( self.n_fight_phase == 2 )
    {
        self aisetbounds( 60, 200, 0, 0, 0 );
    }
    else if ( self.n_fight_phase == 3 )
    {
        self aisetbounds( 80, 300, 0, 0, 0 );
    }
    
    phase_struct = self.phase_struct;
    phase_struct function_92750efba138579a();
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x141fc6c0, Offset: 0x38ed
// Size: 0x1b3
function private function_df419e0e03604139( params )
{
    eject_agent = params.eject_ai;
    phase_struct = params.var_e128f7e1227e3b81.phase_struct;
    activity_instance = phase_struct.activity_instance;
    
    if ( phase_struct.activity_instance.type != "REV_OB_RED_FLOOD" )
    {
        return;
    }
    
    phase_struct cleanup_boss_objective_marker();
    phase_struct.current_boss = eject_agent;
    eject_agent.suppress_minimap_icon = 1;
    eject_agent.disable_brain_rot = 1;
    eject_agent.spawn_point = params.var_e128f7e1227e3b81.spawn_point;
    eject_agent.phase_struct = phase_struct;
    eject_agent.var_e94a0381e288005e = #"hash_99917007a6eaa6b4";
    eject_agent callback::add( #"on_ai_killed", &on_boss_killed );
    phase_struct create_boss_healthbar( eject_agent );
    phase_struct setup_boss_objective_marker( eject_agent );
    eject_agent thread function_fd5d1c4d005b2eba( phase_struct );
    phase_struct.activity_instance activity_participation::function_d041ee0ec570299d( eject_agent );
    
    /#
        var_f791e93cc48c0c97 = function_a5cd5a36ccebe58( "<dev string:x9d>", 0 );
        
        if ( var_f791e93cc48c0c97 )
        {
            eject_agent.maxhealth = var_f791e93cc48c0c97;
            eject_agent.health = var_f791e93cc48c0c97;
        }
    #/
    
    activity_instance.var_2c7df72824504573 += eject_agent.health;
    eject_agent callback::add( #"on_ai_killed", &function_ee796d3f0bfba9ed );
    eject_agent thread function_568aa46f55672ff9();
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0x5aabf986, Offset: 0x3aa8
// Size: 0x36, Type: bool
function private should_shutdown_flood( requestid, userdata )
{
    phase_struct = userdata[ 0 ];
    
    if ( phase_struct.var_46a7c940287a3795 )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xf02e9b49, Offset: 0x3ae7
// Size: 0xac
function private get_spawn_boss_type()
{
    var_74f05ac6a577955c = getdvar( @"hash_c751b7b782b3b154", "random" );
    disabled_bosses = strtok( getdvar( @"hash_27a65534b5d8d0f", "" ), "," );
    var_537d79342cfb3192 = [ "klaus", "galileo", "neptune" ];
    var_537d79342cfb3192 = arrayremove( var_537d79342cfb3192, disabled_bosses );
    
    if ( !arraycontains( var_537d79342cfb3192, var_74f05ac6a577955c ) )
    {
        if ( var_74f05ac6a577955c != "random" )
        {
            assertmsg( "<dev string:xbf>" + var_74f05ac6a577955c + "<dev string:xd4>" );
        }
        
        var_74f05ac6a577955c = utility::array_random( var_537d79342cfb3192 );
    }
    
    return var_74f05ac6a577955c;
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0xd093bc97, Offset: 0x3b9c
// Size: 0xe7
function private spawn_ai( activityinstance, var_e04c0425c57a325 )
{
    var_e04c0425c57a325.spawned = 1;
    tag = var_e04c0425c57a325.type ?? get_spawn_boss_type();
    request_id = activityinstance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_red_flood_boss", var_e04c0425c57a325.origin, 500, 1, 1, 1, 0 );
    function_1a9d724a960fa19d( request_id, tag, 1 );
    activityinstance activity_ai_encounters::function_48582991402cac50( request_id, 1 );
    activityinstance activity_ai_encounters::function_52d1342183200a8f( request_id, &boss_spawned_callback, [ self, var_e04c0425c57a325 ] );
    function_64ac8c4e752f4dca( request_id, 0 );
    flood_request_id = activityinstance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_toxin_bomb_flood", var_e04c0425c57a325.origin, 1000, 1, 0, 1, 0 );
    activity_ai_encounters::function_d33de057e760c97b( flood_request_id, &should_shutdown_flood, [ self ] );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x5c7472c7, Offset: 0x3c8b
// Size: 0x2d
function private function_a76d3530c19ddf03()
{
    self.cradle_crate game_utility::questcircle_create( "Toxin_Bomb_Boss_Ob", self.cradle_crate.origin, 2000 );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xc4415bef, Offset: 0x3cc0
// Size: 0x12
function private function_2bb49caeb1c9a07f()
{
    self.cradle_crate game_utility::questcircle_delete();
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xb53129b1, Offset: 0x3cda
// Size: 0x99
function private function_7156bba523537dac( players )
{
    if ( self.cradle_crate game_utility::questcircle_exists() )
    {
        foreach ( player in players )
        {
            self.cradle_crate game_utility::questcircle_showtoplayer( player );
        }
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xd76edb4c, Offset: 0x3d7b
// Size: 0x99
function private function_530d5e82cd6fa756( players )
{
    if ( self.cradle_crate game_utility::questcircle_exists() )
    {
        foreach ( player in players )
        {
            self.cradle_crate game_utility::questcircle_hidefromplayer( player );
        }
    }
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xdc0f1c87, Offset: 0x3e1c
// Size: 0x27
function private function_2dd4ea1adec3dd04()
{
    game_utility::questcircle_create( "Toxin_Bomb_Warn_Ob", self.origin, self.radius );
    game_utility::questcircle_showtoall();
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xfa16973b, Offset: 0x3e4b
// Size: 0x9
function private function_8a7d76b89ec2cf8()
{
    game_utility::questcircle_delete();
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xd7b2d85d, Offset: 0x3e5c
// Size: 0x36
function private setup_hovercard( objidnum )
{
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_sat_ob_we_red_flood" );
    function_3f1a6a0ae5901866( objidnum, hovercardid );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x4c9cb39b, Offset: 0x3e9a
// Size: 0x40
function private function_2cdcd7e181d42766()
{
    level endon( #"game_ended" );
    phase_struct = self;
    phase_struct endon( #"objective_removed" );
    wait 120;
    objidpoolmanager::update_objective_state( self.objidnum, "active" );
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x9b691986, Offset: 0x3ee2
// Size: 0x8c
function private setup_explode_objective_marker( activityinstance )
{
    self.objidnum = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_red_flood", 0, 0 );
    objidpoolmanager::update_objective_position( self.objidnum, self.cradle_crate.origin + ( 0, 0, 1000 ) );
    objidpoolmanager::objective_set_play_intro( self.objidnum, 1 );
    objective_hidefromplayersinmask( self.objidnum );
    setup_hovercard( self.objidnum );
    thread function_2cdcd7e181d42766();
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xab718aa0, Offset: 0x3f76
// Size: 0x41
function private function_54efd1cd90aee6f0( activityinstance )
{
    if ( isdefined( self.objidnum ) )
    {
        self notify( #"objective_removed" );
        activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.objidnum );
        self.objidnum = undefined;
    }
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x611ecea2, Offset: 0x3fbf
// Size: 0x2bf
function private function_368a5c717b3f267d()
{
    if ( !ob_resource_manager::function_516cca136bef547f() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    activity_instance = self.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"boss_killed" );
    resources = [ { #amount:get_override_setting( "reserved_entity", 30 ), #type:"entities" }, { #amount:get_override_setting( "reserved_scriptable", 70 ), #type:"scriptables" }, { #amount:get_override_setting( "reserved_vehicle", 10 ), #type:"vehicles" } ];
    end_time = gettime() + utility::function_4b74c15943231980( get_override_setting( "reserve_duration", 40 ) );
    
    while ( true )
    {
        success = 1;
        
        foreach ( resource in resources )
        {
            resource_type = resource.type;
            resource_amount = resource.amount;
            
            if ( !isdefined( self.reserved_resources[ resource_type ] ) )
            {
                self.reserved_resources[ resource_type ] = 0;
            }
            
            if ( self.reserved_resources[ resource_type ] < resource_amount )
            {
                reserved_amount = activity_instance ob_resource_manager::function_7e6ceb9ece0c87e7( resource_type, resource_amount - self.reserved_resources[ resource_type ] );
                self.reserved_resources[ resource_type ] += reserved_amount;
                
                if ( self.reserved_resources[ resource_type ] < resource_amount )
                {
                    success = 0;
                }
            }
        }
        
        if ( success )
        {
            break;
        }
        
        if ( gettime() >= end_time )
        {
            break;
        }
        
        waitframe();
    }
    
    /#
        foreach ( type, amount in self.reserved_resources )
        {
            println( "<dev string:xec>" + type + "<dev string:x10b>" + amount );
        }
    #/
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xeae1b0c6, Offset: 0x4286
// Size: 0x84
function private function_9402936a7a7a40be()
{
    if ( !ob_resource_manager::function_516cca136bef547f() )
    {
        return;
    }
    
    activity_instance = self.activity_instance;
    reserved_vehicles = self.reserved_resources[ "vehicles" ];
    reserved_entities = self.reserved_resources[ "entities" ];
    reserved_scriptables = self.reserved_resources[ "scriptables" ];
    self.reserved_resources = undefined;
    activity_instance ob_resource_manager::function_2948ca4364d60860( reserved_vehicles, reserved_entities, reserved_scriptables );
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0xb7f65c48, Offset: 0x4312
// Size: 0x2a
function private get_override_setting( name, defaultvalue )
{
    return getdvarint( hashcat( @"hash_59b6274a8b78dc32", name ), defaultvalue );
}

// Namespace ob_activity_red_flood
// Params 6, eflags: 0x4
// Checksum 0xa64345b1, Offset: 0x4345
// Size: 0x43
function private cradle_crate_used( instance, part, state, player, bautouse, usestring )
{
    instance thread function_a339ced7169179a1( player );
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0xc3eafa57, Offset: 0x4390
// Size: 0xbf
function private function_a339ced7169179a1( player )
{
    if ( !self.phase_struct || self.phase_struct.activity_instance.type != "REV_OB_RED_FLOOD" )
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
        self.phase_struct notify( #"cradle_crate_used", player );
        self setscriptablepartstate( #"red_flood_cradle_crate", #"unusable_planting" );
        thread clip_management();
    }
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xdb24b78, Offset: 0x4457
// Size: 0x6c
function private clip_management()
{
    self endon( #"death" );
    toxin_site_clip = spawn( "script_model", self.origin );
    toxin_site_clip setmodel( "sat_ob_toxin_bomb_site_clip" );
    self.toxin_site_clip = toxin_site_clip;
    wait 3.6;
    toxin_site_clip moveto( self.origin + ( 0, 0, 30 ), 2.5 );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x85804a8c, Offset: 0x44cb
// Size: 0x22
function private clip_remove()
{
    wait 0.5;
    
    if ( self.toxin_site_clip )
    {
        self.toxin_site_clip delete();
    }
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x1c731ded, Offset: 0x44f5
// Size: 0xe8
function private setup_cradle_crate()
{
    activity_instance = self.activity_instance;
    crate_struct = namespace_be3150865da9d2f1::get_linked_struct_filtered( "cradle_crate", "script_noteworthy" );
    
    if ( crate_struct )
    {
        origin = crate_struct.origin;
        angles = crate_struct.angles;
    }
    else
    {
        origin = utility::drop_to_ground( self.origin, 10000 );
        angles = self.angles;
    }
    
    origin = ob_activity_utility::function_fd8fc0e0d2300792( origin );
    angles = ob_activity_utility::function_fd8fc0e0d2300792( angles );
    crate = spawnscriptable( "sat_ob_red_flood_cradle_crate", origin, angles );
    crate.phase_struct = self;
    crate setscriptablepartstate( #"red_flood_cradle_crate", #"visible" );
    activity_instance ob_activity_instance_common::function_9c6b2d04234d7b5e( activity_instance, crate );
    self.cradle_crate = crate;
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0x2c890e11, Offset: 0x45e5
// Size: 0x60
function private function_402009bcdf3c11de( startpos, endpos )
{
    path_info = function_fdee9f19da89757d( startpos, endpos );
    function_2bcff8b80bc30d8( startpos, endpos, path_info.bezier_end_pos, path_info.bezier_control_pos, path_info.random_radius, path_info.spiral_height );
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0x9ebc1543, Offset: 0x464d
// Size: 0x114
function private function_fdee9f19da89757d( startpos, endpos )
{
    random_radius = randomintrange( 50, 151 );
    var_be45aa444243dd60 = randomintrange( -50, 51 );
    var_724163bd4b3d2439 = randomintrange( 30, 91 );
    var_473a4a2e7060cbdd = vectortoangles( endpos - startpos );
    var_c7f1904230e9da61 = int( var_473a4a2e7060cbdd[ 1 ] - var_724163bd4b3d2439 );
    bezier_end_pos = endpos + ( random_radius * cos( var_c7f1904230e9da61 ), random_radius * sin( var_c7f1904230e9da61 ), 0 ) + ( 0, 0, var_be45aa444243dd60 );
    var_16b36c997f81e1e = var_c7f1904230e9da61 + 90;
    bezier_control_pos = bezier_end_pos + anglestoforward( ( 0, var_16b36c997f81e1e, 0 ) ) * -0.5 * distance( startpos, endpos ) + ( 0, 0, var_be45aa444243dd60 );
    spiral_height = bezier_end_pos[ 2 ] - endpos[ 2 ];
    return { #spiral_height:spiral_height, #random_radius:random_radius, #bezier_control_pos:bezier_control_pos, #bezier_end_pos:bezier_end_pos };
}

// Namespace ob_activity_red_flood
// Params 6, eflags: 0x4
// Checksum 0xceaf5cff, Offset: 0x476a
// Size: 0x1d3
function private function_2bcff8b80bc30d8( startpos, endpos, bezier_end, bezier_control_point, radius, spiral_height )
{
    var_b304159877816eb9 = distancesquared( startpos, bezier_end );
    var_58c89811f3b06a50 = mapfloat( 0, 360000, 0.35, 0.65, var_b304159877816eb9 );
    var_324fd5ce37eb5bfa = max( 1, 3.14159 * radius / 500 );
    
    if ( !isdefined( self.var_8b45b0401d2cc8a3 ) )
    {
        self.var_8b45b0401d2cc8a3 = 0;
    }
    
    if ( self.var_8b45b0401d2cc8a3 >= 15 || distance2d( startpos, endpos ) >= 2000 )
    {
        wait var_58c89811f3b06a50 + 2 + 0.2;
        return;
    }
    
    self.var_8b45b0401d2cc8a3++;
    mover = utility::spawn_model( "tag_origin", startpos, ( 0, 0, 0 ) );
    var_40b6ca8a4b46d231 = 0;
    
    /#
        if ( getdvarint( @"hash_b1ab1359416a2026", 0 ) )
        {
            var_40b6ca8a4b46d231 = 1;
            thread function_4e1052cf54a5a800( startpos, endpos, bezier_end, bezier_control_point, radius, spiral_height, mover, var_324fd5ce37eb5bfa );
        }
    #/
    
    scriptable = spawnscriptable( %"sat_ob_red_flood_cradle_collect_fx", startpos );
    scriptable utility::scriptable_setparententity( mover );
    mover utility::function_8001268940441423( startpos, bezier_end, bezier_control_point, var_58c89811f3b06a50, var_40b6ca8a4b46d231, 1 );
    mover utility::follow_spiral( radius, 0, ( 0, 0, 1 ), spiral_height * -1, var_324fd5ce37eb5bfa, endpos, 1, 0 );
    
    /#
        if ( var_40b6ca8a4b46d231 )
        {
            mover.var_e2fd305459d7c640 = 1;
        }
    #/
    
    scriptable setscriptablepartstate( #"body", #"impact" );
    wait 0.2;
    scriptable freescriptable();
    mover delete();
    self.var_8b45b0401d2cc8a3--;
}

/#

    // Namespace ob_activity_red_flood
    // Params 8, eflags: 0x4
    // Checksum 0x5ec17439, Offset: 0x4945
    // Size: 0x191, Type: dev
    function private function_4e1052cf54a5a800( startpos, endpos, bezier_end, bezier_control_point, radius, spiral_height, mover, var_324fd5ce37eb5bfa )
    {
        level endon( #"game_ended" );
        mover endon( #"death" );
        sphere( startpos, 5, ( 0, 1, 0 ), 0, int( 10 / level.framedurationseconds ) );
        sphere( endpos, 5, ( 0, 1, 0 ), 0, int( 10 / level.framedurationseconds ) );
        sphere( bezier_end, 5, ( 1, 0, 0 ), 0, int( 10 / level.framedurationseconds ) );
        sphere( bezier_control_point, 5, ( 0, 0, 1 ), 0, int( 10 / level.framedurationseconds ) );
        line( bezier_end, bezier_control_point, ( 1, 1, 1 ), 1, 0, int( 10 / level.framedurationseconds ) );
        mover waittill( #"hash_63c37028d5d0eecc" );
        
        for ( oldpos = mover.origin; !mover.var_e2fd305459d7c640 ; oldpos = mover.origin )
        {
            waitframe();
            mover thread utility::draw_line_for_time( mover.origin, oldpos, 1, 1, 1, var_324fd5ce37eb5bfa * 10 );
        }
    }

#/

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0x489a4beb, Offset: 0x4ade
// Size: 0x20
function private function_3f996c8bc9980cf8( requestid, phasestruct )
{
    return phasestruct.var_c63209be75d96ba;
}

// Namespace ob_activity_red_flood
// Params 3, eflags: 0x4
// Checksum 0xf2592db1, Offset: 0x4b07
// Size: 0x12a
function private function_eb72b9ebf4b92bf2( pos, progress, ischampion )
{
    vfx_end_pos = self.cradle_crate.origin + ( 0, 0, 60 );
    
    if ( ischampion )
    {
        for ( i = 0; i < 5 ; i++ )
        {
            if ( i < 4 )
            {
                thread function_402009bcdf3c11de( pos, vfx_end_pos );
                wait 0.2;
                continue;
            }
            
            function_402009bcdf3c11de( pos, vfx_end_pos );
        }
    }
    else
    {
        function_402009bcdf3c11de( pos, vfx_end_pos );
    }
    
    if ( self.var_ac3f65cae6d3b9fe < 100 )
    {
        self.var_ac3f65cae6d3b9fe = clamp( self.var_ac3f65cae6d3b9fe + progress, 0, 100 );
        activity_definition_utils::updateprogress( self.var_ac3f65cae6d3b9fe, self.activity_instance );
        self.cradle_crate function_92da89aece774300( self.var_ac3f65cae6d3b9fe );
        self notify( #"cradle_collect_progress_incremented" );
        
        if ( self.var_ac3f65cae6d3b9fe >= 100 )
        {
            self.var_c63209be75d96ba = 1;
            self notify( #"hash_745f9dfb87f9cbea" );
        }
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x36db4e5, Offset: 0x4c39
// Size: 0xb4
function private function_92da89aece774300( progress )
{
    if ( progress >= 100 )
    {
        utility::function_32b24db3127bff40( #"charge_fx", #"full" );
    }
    else if ( progress >= 60 )
    {
        utility::function_32b24db3127bff40( #"charge_fx", #"high" );
    }
    else if ( progress >= 30 )
    {
        utility::function_32b24db3127bff40( #"charge_fx", #"low" );
    }
    
    if ( progress > 0 )
    {
        state_progress = floor( progress / 5 ) * 5;
        state_progress = getxhash( state_progress + "_pcr" );
        utility::function_32b24db3127bff40( #"miscellaneous", state_progress );
    }
}

// Namespace ob_activity_red_flood
// Params 2, eflags: 0x4
// Checksum 0x9a2d09ef, Offset: 0x4cf5
// Size: 0x86
function private function_f739bad011c913bd( params, phase_struct )
{
    if ( self.death_source != "despawn" )
    {
        pos = self gettagorigin( "j_head" );
        
        if ( self.ischampion )
        {
            progress = get_override_setting( "cradle_per_kill_champion", 10 );
        }
        else
        {
            progress = get_override_setting( "cradle_per_kill", 1 );
        }
        
        phase_struct thread function_eb72b9ebf4b92bf2( pos, progress, self.ischampion );
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0xc
// Checksum 0xc0b5119e, Offset: 0x4d83
// Size: 0x70
function private function_76a060200a66f6ad( phasestruct )
{
    self notify( #"hash_ba193fd8a9c24b14" );
    self endon( #"hash_ba193fd8a9c24b14" );
    level endon( #"game_ended" );
    self endon( #"death" );
    phasestruct waittill( #"hash_745f9dfb87f9cbea" );
    self.var_a13bed1ac47e1b2c = 1;
    self.dropweapon = 0;
    self.nodrop = 1;
    self kill();
}

// Namespace ob_activity_red_flood
// Params 4, eflags: 0x4
// Checksum 0x7ff621e4, Offset: 0x4dfb
// Size: 0x144
function private function_2d319a1918e6fe32( requestid, userdata, agent, data )
{
    phasestruct = userdata[ 0 ];
    var_6cebdaa9bd9d1316 = userdata[ 1 ];
    agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
    agent setgoalpos( phasestruct.cradle_crate.origin, 1000 );
    agent function_fa32376aaa88a7a2( agent.origin, phasestruct.radius );
    agent._blackboard.var_b213ded5043dfa2b = agent.origin;
    agent._blackboard.var_8d11b98561e1eb81 = 100;
    agent._blackboard.var_8d34ab856208146f = 400;
    agent._blackboard.var_6a8c50efac75caa1 = 3000;
    agent.ischampion = var_6cebdaa9bd9d1316;
    agent thread function_76a060200a66f6ad( phasestruct );
    agent setscriptablepartstate( #"burned_cradle", #"burned_on", 0 );
    agent callback::add( #"on_ai_killed", &function_f739bad011c913bd, phasestruct );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x92724a9d, Offset: 0x4f47
// Size: 0x253
function private function_9fad8ee06c74b659()
{
    activity_instance = self.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"hash_745f9dfb87f9cbea" );
    stages = [ { #progress:10 }, { #var_1ed33963730d913f:20, #tag:"champion" }, { #var_1ed33963730d913f:45, #tag:"champion_2" }, { #var_1ed33963730d913f:85, #tag:"champion_3" } ];
    
    foreach ( stage in stages )
    {
        if ( stage.progress )
        {
            while ( true )
            {
                self waittill( #"cradle_collect_progress_incremented" );
                
                if ( self.var_ac3f65cae6d3b9fe >= stage.progress )
                {
                    break;
                }
            }
            
            continue;
        }
        
        tag = stage.tag;
        request_id = activity_instance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_enc_red_flood_champion", self.cradle_crate.origin, 1000, 1, 1, 1, 2 );
        function_1a9d724a960fa19d( request_id, tag, 1 );
        activity_instance activity_ai_encounters::function_52d1342183200a8f( request_id, &function_2d319a1918e6fe32, [ self, 1 ] );
        self.pause_flood_fill = self.var_ac3f65cae6d3b9fe >= stage.var_1ed33963730d913f;
        var_d8f9cc3d992b5e00 = "ai_encounter_shutdown_" + request_id;
        
        while ( true )
        {
            msg = utility::waittill_any_ents_return( self, "cradle_collect_progress_incremented", level, var_d8f9cc3d992b5e00 );
            
            if ( msg == "cradle_collect_progress_incremented" )
            {
                self.pause_flood_fill = self.var_ac3f65cae6d3b9fe >= stage.var_1ed33963730d913f;
                continue;
            }
            
            break;
        }
    }
    
    self.pause_flood_fill = 0;
}

// Namespace ob_activity_red_flood
// Params 4, eflags: 0x4
// Checksum 0x12233b4e, Offset: 0x51a2
// Size: 0x41, Type: bool
function private function_62212b736bfb1729( requestid, userdata, agent, data )
{
    phase_struct = userdata;
    return !phase_struct.pause_flood_fill;
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xf7f58313, Offset: 0x51ec
// Size: 0x95
function private function_d7abcacdd4b382f5()
{
    self.var_ac3f65cae6d3b9fe = 0;
    activity_instance = self.activity_instance;
    flood_request_id = activity_instance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_enc_red_flood_flood_fill", self.cradle_crate.origin, 1000, 1, 1, 1, 2 );
    activity_ai_encounters::function_d33de057e760c97b( flood_request_id, &function_3f996c8bc9980cf8, self );
    ai_spawn_director::function_c99d360d62c49a9c( flood_request_id, &function_62212b736bfb1729, self );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( flood_request_id, &function_2d319a1918e6fe32, [ self, 0 ] );
    thread function_9fad8ee06c74b659();
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0xb7fd675d, Offset: 0x5289
// Size: 0x21b
function private function_f8161530e839a585()
{
    phasestruct = self;
    activity_instance = self.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    scriptable::scriptable_addnotifycallback( "red_flood_lightning_strike_damage", &function_98bf3b7895098526 );
    scriptable::scriptable_addnotifycallback( "red_flood_lightning_strike_finished", &function_16853d19338bb241 );
    var_5c90bbc9c717ca30 = phasestruct.cradle_crate.origin;
    lightning_strike_range = arrayrandomize( [ 100, 200, 300, 400, 500, 600, 700, 800 ] );
    lightning_strike_angle = arrayrandomize( [ [ 0, 45 ], [ 45, 90 ], [ 90, 135 ], [ 135, 180 ], [ 180, 225 ], [ 225, 270 ], [ 270, 315 ], [ 315, 360 ] ] );
    lightning_strike_count = 0;
    
    while ( true )
    {
        if ( phasestruct.var_eeda90565541f8c3 )
        {
            break;
        }
        
        lightning_strike_count++;
        
        if ( lightning_strike_count == 8 )
        {
            lightning_strike_count = 0;
        }
        
        var_31ebc537d891bb1f = var_5c90bbc9c717ca30 + ( lightning_strike_range[ lightning_strike_count ] * cos( randomfloatrange( lightning_strike_angle[ lightning_strike_count ][ 0 ], lightning_strike_angle[ lightning_strike_count ][ 1 ] ) ), lightning_strike_range[ lightning_strike_count ] * sin( randomfloatrange( lightning_strike_angle[ lightning_strike_count ][ 0 ], lightning_strike_angle[ lightning_strike_count ][ 1 ] ) ), 0 );
        var_eef1979f1f2fe873 = getclosestpointonnavmesh( var_31ebc537d891bb1f );
        lightning_strikes_scriptable = spawnscriptable( %"sat_ob_red_flood_lightning_strike", var_eef1979f1f2fe873 );
        lightning_strikes_scriptable.phasestruct = phasestruct;
        lightning_strikes_scriptable thread function_fd5dfc3c569e05e0();
        wait randomfloatrange( 1, 2 );
    }
}

// Namespace ob_activity_red_flood
// Params 3, eflags: 0x4
// Checksum 0xb4288cca, Offset: 0x54ac
// Size: 0x172
function private lightning_strike_on_player( victim, shock_duration, damage )
{
    victim endon( #"death" );
    victim endon( #"disconnect" );
    victim shock_stick::function_904e61c3aefb61c2( 1 );
    
    if ( victim.revivingteammate )
    {
        victim.var_45ab03788f1a0a4d = 1;
    }
    
    victim utility::function_32b24db3127bff40( "shockStickVfx", "vfx_start_red" );
    victim dodamage( damage, victim.origin, victim, victim, "MOD_UNKNOWN", undefined, "none", undefined, 65536 );
    
    if ( isplayer( victim ) )
    {
        playsoundatpos( victim.origin, "evt_lightning_strike_impact" );
        gestureref = "vm_ges_shockstick_react";
        curweapon = victim getcurrentweapon();
        
        if ( weapon::isfistweapon( curweapon ) )
        {
            gestureref = "vm_ges_shockstick_react_fists";
        }
        
        while ( !victim isgestureplaying( gestureref ) )
        {
            victim forceplaygestureviewmodel( gestureref );
            waitframe();
        }
    }
    
    victim startforcedfire();
    victim shock_stick::function_ef03efbecb279b8a( 1 );
    victim setmovespeedscale( 0.8 );
    victim setempjammed( 1 );
    wait shock_duration;
    victim shock_stick::function_904e61c3aefb61c2( 0 );
    victim stopgestureviewmodel( gestureref );
    victim stopforcedfire();
    victim utility::function_32b24db3127bff40( "shockStickVfx", "off" );
    victim shock_stick::function_ef03efbecb279b8a( 0 );
    victim setmovespeedscale( 1 );
    victim setempjammed( 0 );
}

// Namespace ob_activity_red_flood
// Params 3, eflags: 0x4
// Checksum 0x6abf4763, Offset: 0x5626
// Size: 0x81
function private function_7d456c43692283e4( victim, shock_duration, damage )
{
    victim zombie_stun::stun_ai( shock_duration );
    victim utility::function_32b24db3127bff40( "shockStickVfx", "vfx_start_red" );
    victim dodamage( damage, victim.origin, victim, victim, "MOD_UNKNOWN", undefined, "none", undefined, 65536 );
    wait shock_duration;
    
    if ( isalive( victim ) )
    {
        victim utility::function_32b24db3127bff40( "shockStickVfx", "off" );
    }
}

// Namespace ob_activity_red_flood
// Params 3, eflags: 0x4
// Checksum 0x72cd0c9c, Offset: 0x56af
// Size: 0xe6
function private function_3e388fde8403d9e0( victim, shock_duration, damage )
{
    firstshock = gettime() > victim._blackboard.var_ba9517cfc0287af8 + 1;
    victim._blackboard.var_ba9517cfc0287af8 = gettime();
    
    if ( victim asmhaspainstate( victim.asmname ) && firstshock )
    {
        victim asmevalpaintransition( victim.asmname );
    }
    
    victim utility::function_32b24db3127bff40( "shockStickVfx", "vfx_start_red" );
    victim dodamage( damage, victim.origin, victim, victim, "MOD_UNKNOWN", undefined, "none", undefined, 65536 );
    wait shock_duration;
    
    if ( isalive( victim ) )
    {
        victim utility::function_32b24db3127bff40( "shockStickVfx", "off" );
    }
}

// Namespace ob_activity_red_flood
// Params 4, eflags: 0x4
// Checksum 0x2d3730f7, Offset: 0x579d
// Size: 0x247
function private function_98bf3b7895098526( instance, note, param, var_64ffacba090c91be )
{
    phasestruct = instance.phasestruct;
    random = randomintrange( 0, 10 );
    
    if ( phasestruct && random < 3 )
    {
        phasestruct thread function_aaa2c8d2463ebe4d( instance.origin );
    }
    
    radiusdamage( instance.origin, 105, 50, 50, undefined, undefined, undefined, 1, 1 );
    players = namespace_9d8e359c3b1041e5::getplayersinradiussharedfunc( instance.origin, 105 );
    
    foreach ( player in players )
    {
        thread lightning_strike_on_player( player, 1, 50 );
    }
    
    zombies = getaiarrayinradius( instance.origin, 105, "team_two_hundred" );
    
    foreach ( zombie in zombies )
    {
        thread function_7d456c43692283e4( zombie, 1, 50 );
    }
    
    soldiers = getaiarrayinradius( instance.origin, 105, "team_hundred_ninety" );
    
    foreach ( soldier in soldiers )
    {
        thread function_3e388fde8403d9e0( soldier, 1, 50 );
    }
}

// Namespace ob_activity_red_flood
// Params 4, eflags: 0x4
// Checksum 0x56aa7047, Offset: 0x59ec
// Size: 0x34
function private function_16853d19338bb241( instance, note, param, var_64ffacba090c91be )
{
    instance notify( #"red_flood_lightning_strike_finished" );
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x28f24ca1, Offset: 0x5a28
// Size: 0x63
function private function_fd5dfc3c569e05e0()
{
    random = randomintrange( 0, 2 );
    
    if ( random == 1 )
    {
        self setscriptablepartstate( #"strike", #"on" );
    }
    else
    {
        self setscriptablepartstate( #"strike", #"no_damage" );
    }
    
    self waittill( #"red_flood_lightning_strike_finished" );
    self freescriptable();
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x23eef92b, Offset: 0x5a93
// Size: 0x84
function private function_aaa2c8d2463ebe4d( var_31ebc537d891bb1f )
{
    phasestruct = self;
    activity_instance = self.activity_instance;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    flood_request_id = activity_instance activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_enc_red_flood_flash", var_31ebc537d891bb1f, 100, 1, 1, 1, 0 );
    activity_instance activity_ai_encounters::function_52d1342183200a8f( flood_request_id, &function_32176b963a974548, [ phasestruct, var_31ebc537d891bb1f ] );
}

// Namespace ob_activity_red_flood
// Params 4, eflags: 0x4
// Checksum 0x414267d2, Offset: 0x5b1f
// Size: 0xe4
function private function_32176b963a974548( requestid, userdata, agent, data )
{
    phasestruct = userdata[ 0 ];
    var_eef1979f1f2fe873 = userdata[ 1 ];
    agent region_difficulty_manager::function_410b4f83b0a5b98( "difficulty5" );
    agent setgoalpos( var_eef1979f1f2fe873, 100 );
    agent function_fa32376aaa88a7a2( agent.origin, phasestruct.radius );
    agent._blackboard.var_b213ded5043dfa2b = agent.origin;
    agent._blackboard.var_8d11b98561e1eb81 = 100;
    agent._blackboard.var_8d34ab856208146f = 400;
    agent._blackboard.var_6a8c50efac75caa1 = 650;
}

// Namespace ob_activity_red_flood
// Params 0, eflags: 0x4
// Checksum 0x83178ab1, Offset: 0x5c0b
// Size: 0x2d
function private clear_flash()
{
    phasestruct = self;
    
    if ( phasestruct.lightning_strikes_scriptable )
    {
        phasestruct.lightning_strikes_scriptable freescriptable();
    }
}

// Namespace ob_activity_red_flood
// Params 1, eflags: 0x4
// Checksum 0x71407dfb, Offset: 0x5c40
// Size: 0x34, Type: bool
function private function_8edede1864597301( victim )
{
    if ( !victim.aicategory || victim.aicategory == "normal" )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace ob_activity_red_flood
    // Params 2, eflags: 0x4
    // Checksum 0x8e5bb253, Offset: 0x5c7d
    // Size: 0x22, Type: dev
    function private function_a5cd5a36ccebe58( name, defaultvalue )
    {
        return get_override_setting( name, defaultvalue );
    }

    // Namespace ob_activity_red_flood
    // Params 0, eflags: 0x4
    // Checksum 0xe9c7a263, Offset: 0x5ca7
    // Size: 0x70, Type: dev
    function private init_devgui()
    {
        wait 1;
        devgui::function_9082edeb5db93280( "<dev string:x115>" );
        devgui::add_devgui_command( "<dev string:x14c>", "<dev string:x15c>" );
        devgui::add_devgui_command( "<dev string:x17c>", "<dev string:x188>" );
        devgui::add_devgui_command( "<dev string:x1ae>", "<dev string:x1b9>" );
        devgui::add_devgui_command( "<dev string:x1de>", "<dev string:x1eb>" );
        devgui::add_devgui_command( "<dev string:x212>", "<dev string:x21f>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_red_flood
    // Params 0, eflags: 0x4
    // Checksum 0x51f1453, Offset: 0x5d1f
    // Size: 0x16, Type: dev
    function private function_12b3b66b7683566b()
    {
        return getdvarint( @"hash_d3e0d65dc89e1a49", 0 ) != 0;
    }

    // Namespace ob_activity_red_flood
    // Params 1, eflags: 0x4
    // Checksum 0x6f540048, Offset: 0x5d3d
    // Size: 0x96, Type: dev
    function private function_9548a1569f16e32b( params )
    {
        variant_tag = params[ 0 ];
        var_1e562e6847201882 = int( params[ 1 ] );
        boss_index = int( params[ 2 ] );
        activity_instance = level.var_78e2a4c5cb8c721e[ variant_tag ];
        phase_struct = activity_instance.phase_structs[ var_1e562e6847201882 ];
        var_e04c0425c57a325 = phase_struct.boss_structs[ boss_index ];
        phase_struct.var_e6addf73de340819 = var_e04c0425c57a325;
    }

    // Namespace ob_activity_red_flood
    // Params 1, eflags: 0x4
    // Checksum 0x179c2e94, Offset: 0x5ddb
    // Size: 0x103, Type: dev
    function private debug_draw_boss_struct( index )
    {
        var_f948e10375322ae4 = 10;
        duration_seconds = level.framedurationseconds * var_f948e10375322ae4;
        
        while ( true )
        {
            origin = self.origin;
            radius = self.radius;
            color = ( 1, 0, 0 );
            
            if ( self.spawned )
            {
                color = ( 0, 1, 0 );
            }
            
            cylinder( origin, origin + ( 0, 0, 10 ), radius, color, 0, var_f948e10375322ae4 );
            print3d( origin + ( 0, 0, 0 ), "<dev string:x246>" + index, color, 1, 1, var_f948e10375322ae4 );
            print3d( origin + ( 0, 0, -20 ), "<dev string:x24c>" + self.radius, color, 1, 1, var_f948e10375322ae4 );
            wait duration_seconds;
        }
    }

    // Namespace ob_activity_red_flood
    // Params 1, eflags: 0x4
    // Checksum 0x6ed6f137, Offset: 0x5ee6
    // Size: 0x138, Type: dev
    function private debug_start_phase( params )
    {
        variant_tag = params[ 0 ];
        var_1e562e6847201882 = int( params[ 1 ] );
        activity_instance = level.var_78e2a4c5cb8c721e[ variant_tag ];
        phase_struct = activity_instance.phase_structs[ var_1e562e6847201882 ];
        
        if ( phase_struct.started )
        {
            return;
        }
        
        activity_instance.phase_struct = phase_struct;
        phase_struct.var_1e562e6847201882 = var_1e562e6847201882;
        activity_instance setup_phase_struct( phase_struct );
        activity_instance thread function_66c17bd942de7a99( phase_struct );
        devgui::function_9082edeb5db93280( "<dev string:x115>" + variant_tag + "<dev string:x254>" );
        
        for ( i = 0; i < phase_struct.boss_structs.size ; i++ )
        {
            devgui::function_cd4e263c1f3018ae( phase_struct.phase_struct_name + "<dev string:x256>" + i, "<dev string:x263>" + variant_tag + "<dev string:x27b>" + var_1e562e6847201882 + "<dev string:x27b>" + i, &function_9548a1569f16e32b );
            var_e04c0425c57a325 = phase_struct.boss_structs[ i ];
            var_e04c0425c57a325 thread debug_draw_boss_struct( i );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_activity_red_flood
    // Params 0, eflags: 0x4
    // Checksum 0xf1defc4c, Offset: 0x6026
    // Size: 0x12b, Type: dev
    function private debug_draw_phase_struct()
    {
        var_f948e10375322ae4 = 10;
        duration_seconds = level.framedurationseconds * var_f948e10375322ae4;
        
        while ( true )
        {
            origin = self.origin;
            radius = self.radius;
            height = self.height;
            color = ( 1, 0, 0 );
            
            if ( self.started )
            {
                color = ( 0, 1, 0 );
            }
            
            cylinder( origin, origin + ( 0, 0, height ), radius, color, 0, var_f948e10375322ae4 );
            print3d( origin + ( 0, 0, height / 2 ), "<dev string:x27d>" + self.phase_struct_name, color, 1, 1, var_f948e10375322ae4 );
            print3d( origin + ( 0, 0, height / 2 - 20 ), "<dev string:x24c>" + self.radius, color, 1, 1, var_f948e10375322ae4 );
            print3d( origin + ( 0, 0, height / 2 - 40 ), "<dev string:x284>" + self.height, color, 1, 1, var_f948e10375322ae4 );
            wait duration_seconds;
        }
    }

    // Namespace ob_activity_red_flood
    // Params 0, eflags: 0x4
    // Checksum 0x9d405418, Offset: 0x6159
    // Size: 0x10c, Type: dev
    function private function_bc7f37b9e2f7927b()
    {
        iprintlnbold( "<dev string:x28c>" );
        level.var_78e2a4c5cb8c721e[ self.varianttag ] = self;
        devgui::function_9082edeb5db93280( "<dev string:x115>" + self.varianttag + "<dev string:x254>" );
        phase_names = [];
        
        for ( i = 0; i < self.phase_structs.size ; i++ )
        {
            phase_struct = self.phase_structs[ i ];
            phase_struct_name = phase_struct.script_noteworthy ?? "<dev string:x2a7>" + i;
            
            if ( arraycontains( phase_names, phase_struct_name ) )
            {
                phase_struct_name = phase_struct_name + "<dev string:x2b1>" + i;
            }
            
            phase_names[ phase_names.size ] = phase_struct_name;
            phase_struct.phase_struct_name = phase_struct_name;
            devgui::function_cd4e263c1f3018ae( phase_struct_name + "<dev string:x2b3>", "<dev string:x2c0>" + self.varianttag + "<dev string:x27b>" + i, &debug_start_phase );
            phase_struct thread debug_draw_phase_struct();
        }
        
        devgui::function_77df7fe7dd273e10();
    }

#/
