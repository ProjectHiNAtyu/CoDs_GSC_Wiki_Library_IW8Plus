// scripts\mp\ob\activities\ob_activity_package_thief.gsc  (hash_27ded69583f7415f.gscc) (size: 12261 Bytes / 0x2fe5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x451f9916 (1159698710)
// size ...... 12261 (0x2fe5)
// includes .. 15  (offset: 0x2d49)
// strings ... 37  (offset: 0x2dc1)
// dev strs .. 4   (offset: 0x2fb5)
// exports ... 35  (offset: 0x1c55)
// cseg ...... 0x2ed + 0x1968 (0x1c55)
// imports ... 99  (offset: 0x21cd)
// animtree1 . 0   (offset: 0x2fe5)
// animtree2 . 0   (offset: 0x2fe5)
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\cap;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_package_thief;

// Namespace ob_activity_package_thief
// Params 0, eflags: 0x5
// Checksum 0xb4fd85d0, Offset: 0x30b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_eef44bb6850a7d0c", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_package_thief
// Params 0, eflags: 0x4
// Checksum 0xdc29aaa0, Offset: 0x334
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_PACKAGE_THIEF", &function_ef8ff597a46b825a );
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x8391bb7b, Offset: 0x34f
// Size: 0xa0
function function_ef8ff597a46b825a()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_PACKAGE_THIEF", 0, &package_thief_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_PACKAGE_THIEF", 1, &package_thief_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_PACKAGE_THIEF", 2, &package_thief_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_PACKAGE_THIEF", 3, &function_afbb21b94ef803d2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_d5732533db8bb3e4, "REV_OB_PACKAGE_THIEF" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_8d1d6c04f3945b0b, "REV_OB_PACKAGE_THIEF" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerEnteredAwarenessZone", &function_4b3d325d1d0926c7, "REV_OB_PACKAGE_THIEF" );
    scriptable::scriptable_addusedcallbackbypart( "ob_package_thief", &function_a2bfc3076879cb2b );
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x49b66670, Offset: 0x3f7
// Size: 0xfc
function package_thief_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.var_91c91f4a631c481d = activity_definition_utils::function_9129cd8075c85c09( self );
    self.s_center = utility::getstruct( self.varianttag, "script_noteworthy" );
    self.s_crates = utility::getstructarray( self.s_center.targetname, "target" );
    self.timerduration = self.var_91c91f4a631c481d.packagetimer * 1000;
    self.openedcrates = 0;
    self.playercrates = 0;
    self.difficulty_region = region_difficulty_manager::get_region_difficulty( self.s_center.origin );
    
    if ( self.difficulty_region == "difficulty_undefined" )
    {
        self.difficulty_region = "difficulty_easy";
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0xc808a777, Offset: 0x4fb
// Size: 0x7a
function package_thief_activity_begin()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    /#
        activity_instance thread debug_draw();
    #/
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x24>" );
    #/
    
    setup_crates();
    self.awarenesszone = spatial_zone_container::function_f7fc3e6c249a8256( self, "Awareness_Zone" );
    self waittill( #"crates_combat_started" );
    wait 0.1;
    thread function_236fcf19848876bd();
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x3e24f2f7, Offset: 0x57d
// Size: 0xd5
function function_236fcf19848876bd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( activity_instance.openedcrates < activity_instance.s_crates.size )
    {
        wait 0.1;
    }
    
    thread package_cleanup( activity_instance );
    
    if ( isdefined( activity_instance ) && activity_instance_common::getactivitystate( activity_instance ) == "Active" )
    {
        if ( self.playercrates > 0 )
        {
            if ( self.playercrates == self.s_crates.size )
            {
                ob_activity_vo_utility::function_3a48100939e009e9( self, "package_thief_success" );
            }
            else
            {
                ob_activity_vo_utility::function_3a48100939e009e9( self, "package_thief_success_minor" );
            }
            
            activity_instance_common::endactivity( activity_instance, 1 );
            return;
        }
        
        ob_activity_vo_utility::function_3a48100939e009e9( self, "package_thief_fail" );
        activity_instance_common::endactivity( activity_instance, 0 );
    }
}

// Namespace ob_activity_package_thief
// Params 1, eflags: 0x4
// Checksum 0xe9070f, Offset: 0x65a
// Size: 0xf5
function private package_cleanup( activity_instance )
{
    if ( !isdefined( activity_instance ) )
    {
        assert( 0 );
        return;
    }
    
    crates = activity_instance.s_crates;
    wait 10;
    
    foreach ( crate in crates )
    {
        if ( crate.scriptable isscriptableinstance() )
        {
            if ( crate.scriptable.was_spawned )
            {
                crate.scriptable freescriptable();
                continue;
            }
            
            crate.scriptable setscriptablepartstate( "ob_package_thief", "hidden" );
        }
    }
}

// Namespace ob_activity_package_thief
// Params 1
// Checksum 0x7f485260, Offset: 0x757
// Size: 0x50
function package_thief_activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_cleanup();
    
    /#
        thread function_8eeb50e8ea4082ae( "<dev string:x35>" + ( istrue( activity_succeeded ) ? "<dev string:x3f>" : "<dev string:x49>" ) );
    #/
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x3652e11d, Offset: 0x7af
// Size: 0x23
function function_afbb21b94ef803d2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_cleanup();
}

// Namespace ob_activity_package_thief
// Params 0, eflags: 0x4
// Checksum 0x4877c312, Offset: 0x7da
// Size: 0x24
function private activity_cleanup()
{
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    
    if ( isdefined( self.encounter_id ) )
    {
        function_b43716082f77e5e5( self.encounter_id );
    }
}

// Namespace ob_activity_package_thief
// Params 1
// Checksum 0xdb606f3, Offset: 0x806
// Size: 0x73
function function_d5732533db8bb3e4( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    startingprogress = self.openedcrates ?? 0;
    maxprogress = self.s_crates.size ?? 1;
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, startingprogress, maxprogress );
}

// Namespace ob_activity_package_thief
// Params 1
// Checksum 0x8a70e8fa, Offset: 0x881
// Size: 0x23
function function_8d1d6c04f3945b0b( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
}

// Namespace ob_activity_package_thief
// Params 1
// Checksum 0x4c39d4, Offset: 0x8ac
// Size: 0x32
function function_4b3d325d1d0926c7( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    ob_activity_vo_utility::function_3a48100939e009e9( self, "package_thief_brief", player_list );
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x4cb9edfc, Offset: 0x8e6
// Size: 0x1d7
function setup_crates()
{
    num_crates = 0;
    
    foreach ( crate in self.s_crates )
    {
        a_info_act = utility::function_b7f3d374aa10aa51( "info_act", "script_noteworthy", crate.origin, 200 );
        crate.s_info_act = utility::array_random( a_info_act );
        crate.scriptable = find_crate( self.varianttag + "_crate" + num_crates + 1 );
        
        if ( !crate.scriptable )
        {
            crate.scriptable = spawnscriptable( "sat_ob_package_thief_crate", crate.origin, crate.angles );
            crate.scriptable.was_spawned = 1;
        }
        
        num_crates += 1;
        crate.scriptable setscriptablepartstate( "ob_package_thief", "usable" );
        crate.scriptable.owner = crate;
        crate.activity_instance = self;
        crate.ai = [];
        crate.timer = spawnstruct();
        crate.scriptable function_7653c765b6c7b815();
        crate.ai_opening = 0;
        crate setup_crate_encounters();
        crate thread function_4e866ad0928b3da3( crate.s_info_act );
        crate thread function_30cdafb18be22e3c();
    }
}

// Namespace ob_activity_package_thief
// Params 1, eflags: 0x4
// Checksum 0x22ceed34, Offset: 0xac5
// Size: 0x34
function private find_crate( name )
{
    crate_scriptables = getentitylessscriptablearray( name, #targetname );
    
    if ( crate_scriptables.size == 1 )
    {
        return crate_scriptables[ 0 ];
    }
}

// Namespace ob_activity_package_thief
// Params 1
// Checksum 0x3f5e94ce, Offset: 0xb02
// Size: 0x271
function function_4e866ad0928b3da3( info_act )
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self endon( #"destroyed" );
    self endon( #"hash_355ca991f3e29d6b" );
    self waittill( #"agent_spawned" );
    self.ai[ 0 ] thread function_5598863e8b94707d( self, 1 );
    self waittill( #"crate_engaged" );
    self.timer.count = 0;
    self.timer.var_2611f58d4c6de5e6 = gettime();
    
    while ( self.timer.count <= self.activity_instance.timerduration )
    {
        currtime = gettime();
        
        if ( self.ai_opening )
        {
            self.timer.count += currtime - self.timer.var_2611f58d4c6de5e6;
        }
        
        self.timer.var_2611f58d4c6de5e6 = currtime;
        wait 0.1;
    }
    
    if ( isalive( self.opening_ai ) )
    {
        self.opening_ai thread function_42fedb70c9894357();
    }
    
    wait 0.1;
    
    if ( self.timer.count >= self.activity_instance.timerduration )
    {
        thread function_2f7bbbc5012b340f();
        self.activity_instance.openedcrates++;
        activity_definition_utils::updateprogress( self.activity_instance.openedcrates, self.activity_instance );
        wait 0.5;
        
        if ( self.activity_instance.openedcrates < self.activity_instance.s_crates.size - 1 )
        {
            ob_activity_vo_utility::function_3a48100939e009e9( self.activity_instance, "package_thief_crates" );
        }
        
        if ( self.activity_instance.openedcrates == self.activity_instance.s_crates.size - 1 )
        {
            ob_activity_vo_utility::function_3a48100939e009e9( self.activity_instance, "package_thief_crates1" );
        }
        
        self notify( #"hash_355ca991f3e29d6b" );
    }
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x85ae54e6, Offset: 0xd7b
// Size: 0xf4
function function_30cdafb18be22e3c()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self endon( #"destroyed" );
    self endon( #"hash_355ca991f3e29d6b" );
    
    while ( !isdefined( self.timer.count ) )
    {
        wait 0.1;
    }
    
    duration = self.activity_instance.timerduration;
    scriptable = self.scriptable;
    scriptable setscriptablepartstate( "icon", "idle" );
    
    while ( self.timer.count < duration * 0.66 )
    {
        wait 0.1;
    }
    
    ob_activity_vo_utility::function_3a48100939e009e9( self.activity_instance, "package_thief_soldiers" );
    scriptable setscriptablepartstate( "icon", "caution" );
}

// Namespace ob_activity_package_thief
// Params 6, eflags: 0x4
// Checksum 0x5af0b59b, Offset: 0xe77
// Size: 0xb2
function private function_a2bfc3076879cb2b( instance, part, state, player, bautouse, usestring )
{
    activity_instance = instance.owner.activity_instance;
    var_a8839a94f36d1f2e = isplayer( player ) && isalive( player ) && !player.inlaststand && !player isreloading() && !player isgestureplaying();
    
    if ( !activity_instance || !var_a8839a94f36d1f2e )
    {
        return;
    }
    
    instance thread function_769875f2a183f4d( player );
}

// Namespace ob_activity_package_thief
// Params 1
// Checksum 0x4cf16da1, Offset: 0xf31
// Size: 0x113
function function_769875f2a183f4d( player )
{
    player endon( #"disconnect" );
    self disablescriptableplayeruse( player );
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, undefined, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !self )
    {
        return;
    }
    
    self enablescriptableplayeruse( player );
    
    if ( var_fab006cdb4f6e516 )
    {
        self setscriptablepartstate( #"ob_package_thief", #"hidden" );
        self.owner.activity_instance.openedcrates++;
        self.owner.activity_instance.playercrates++;
        activity_definition_utils::updateprogress( self.owner.activity_instance.openedcrates, self.owner.activity_instance );
        thread function_96c8d984a8135ed7( self.owner.activity_instance.openedcrates );
    }
}

// Namespace ob_activity_package_thief
// Params 1, eflags: 0x4
// Checksum 0x5dec5ed6, Offset: 0x104c
// Size: 0xda
function private function_96c8d984a8135ed7( openedcrates )
{
    switch ( openedcrates )
    {
        case 1:
            ob_activity_utility::function_aaf7ae640bd564ff( #"hash_f844c1b950d586c4", self.origin, self.angles );
            break;
        case 2:
            ob_activity_utility::function_aaf7ae640bd564ff( #"hash_f84ec3b950dddeaf", self.origin, self.angles );
            break;
        case 3:
            ob_activity_utility::function_aaf7ae640bd564ff( #"hash_f84bbdb950db9ea6", self.origin, self.angles );
            break;
        default:
            ob_activity_utility::function_aaf7ae640bd564ff( #"hash_f844c1b950d586c4", self.origin, self.angles );
            break;
    }
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x6be9de8c, Offset: 0x112e
// Size: 0xd5
function setup_crate_encounters()
{
    var_9573911a6f37ae5d = utility::array_random( self.activity_instance.var_91c91f4a631c481d.packageencounters );
    encounter_name = "ai_encounter:" + var_9573911a6f37ae5d.encounter;
    n_spawn_radius = 300;
    v_ground = self.origin;
    self.request_id = self.activity_instance activity_ai_encounters::function_eb8506829193f5eb( encounter_name, v_ground, n_spawn_radius, 1, 1, 1, 2 );
    self.activity_instance activity_ai_encounters::function_52d1342183200a8f( self.request_id, &function_8b88ea127d8976f5, self );
    
    /#
        function_1a9d724a960fa19d( self.request_id, self.activity_instance.difficulty_region, 1 );
    #/
}

// Namespace ob_activity_package_thief
// Params 4
// Checksum 0x52511632, Offset: 0x120b
// Size: 0xf4
function function_8b88ea127d8976f5( requestid, userdata, agent, data )
{
    userdata.activity_instance endon( #"activity_ended" );
    userdata.activity_instance endon( #"instance_destroyed" );
    agent endon( #"death" );
    userdata.ai = arraycombineunique( userdata.ai, [ agent ] );
    agent.crate = userdata;
    agent.crate notify( #"agent_spawned" );
    agent.alreadydroppedweapon = 1;
    agent thread function_9746bf8960b16e3f( userdata.activity_instance, userdata );
    agent thread guard_death_watcher( userdata.activity_instance, userdata );
    agent thread guard_damage_watcher( userdata.activity_instance );
}

// Namespace ob_activity_package_thief
// Params 2, eflags: 0x4
// Checksum 0x3ec314d5, Offset: 0x1307
// Size: 0x1d9
function private function_9746bf8960b16e3f( activity_instance, crate )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"crates_combat_started" );
    crate endon( #"hash_355ca991f3e29d6b" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"stealth_combat", attacker );
        
        if ( isplayer( attacker ) )
        {
            activity_participation::function_bc67362dace4370c( activity_instance, attacker );
            
            foreach ( crate in activity_instance.s_crates )
            {
                crate notify( #"crate_engaged" );
                
                foreach ( agent in crate.ai )
                {
                    agent function_fa32376aaa88a7a2( crate.activity_instance.awarenesszone[ 0 ].origin, crate.activity_instance.awarenesszone[ 0 ].radius );
                }
            }
            
            activity_instance notify( #"crates_combat_started" );
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_package_thief
// Params 1, eflags: 0x4
// Checksum 0x5debfd3b, Offset: 0x14e8
// Size: 0x9d
function private guard_damage_watcher( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( isplayer( attacker ) && !activity_participation::function_e7fc1202ac164928( activity_instance, attacker ) )
        {
            activity_participation::function_bc67362dace4370c( activity_instance, attacker );
        }
        
        activity_instance notify( #"crates_combat_started" );
        wait 0.1;
    }
}

// Namespace ob_activity_package_thief
// Params 2, eflags: 0x4
// Checksum 0x48609fa8, Offset: 0x158d
// Size: 0xd7
function private guard_death_watcher( activity_instance, crate )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    crate endon( #"hash_355ca991f3e29d6b" );
    self waittill( #"death" );
    crate.ai = arrayremove( crate.ai, self );
    
    if ( crate.ai.size == 0 )
    {
        crate.scriptable function_e203bba36cfb19d0();
    }
    
    if ( crate.opening_ai == self && crate.timer.count <= activity_instance.timerduration )
    {
        crate.ai_opening = 0;
        wait 1.5;
        crate thread attract_new_ai();
    }
}

// Namespace ob_activity_package_thief
// Params 0, eflags: 0x4
// Checksum 0xfdb43445, Offset: 0x166c
// Size: 0x156
function private attract_new_ai()
{
    self.activity_instance endon( #"activity_ended" );
    self.activity_instance endon( #"instance_destroyed" );
    self endon( #"hash_355ca991f3e29d6b" );
    
    while ( true )
    {
        playersnear = 0;
        
        foreach ( player in self.activity_instance.playerparticipants )
        {
            if ( distance2dsquared( self.origin, player.origin ) < squared( 256 ) )
            {
                playersnear++;
            }
        }
        
        if ( playersnear <= 0 )
        {
            break;
        }
        
        wait 0.1;
    }
    
    if ( self.ai.size > 0 )
    {
        sortedagents = function_628bac9faa9d1e86( self.ai, self.origin );
        sortedagents[ 0 ] function_5598863e8b94707d( self );
        return;
    }
    
    self.scriptable setscriptablepartstate( #"ob_package_thief", #"usable" );
}

// Namespace ob_activity_package_thief
// Params 2, eflags: 0x4
// Checksum 0x83febe6b, Offset: 0x17ca
// Size: 0x15a
function private function_5598863e8b94707d( crate, forceteleport )
{
    self.scripted_mode = 1;
    self.playing_skit = 1;
    self.var_6c6e9be73032cafd = self.script_stealthgroup;
    self.script_stealthgroup = undefined;
    crate.opening_ai = self;
    utility::demeanor_override( "sprint" );
    goal = crate.s_info_act;
    self.goalradius = 8;
    self.script_radius = 8;
    self setgoalpos( self getclosestreachablepointonnavmesh( goal.origin ), 8 );
    
    if ( forceteleport )
    {
        self forceteleport( goal.origin, goal.angles );
    }
    
    msg = utility::waittill_any_timeout( 10, "goal" );
    
    if ( msg == "timeout" )
    {
        self forceteleport( goal.origin, goal.angles );
    }
    
    self.allowpain = 0;
    self.ignoreall = 1;
    
    if ( !isdefined( goal.angles ) )
    {
        goal.angles = ( 0, 0, 0 );
    }
    
    self setplayerangles( goal.angles );
    thread open_crate_ai_anim( crate );
}

// Namespace ob_activity_package_thief
// Params 1, eflags: 0x4
// Checksum 0x85b930a6, Offset: 0x192c
// Size: 0x7e
function private open_crate_ai_anim( crate )
{
    self endon( #"death" );
    crate.activity_instance endon( #"activity_ended" );
    crate.activity_instance endon( #"instance_destroyed" );
    function_dc26f2539c561d30();
    crate.ai_opening = 1;
    crate.scriptable.var_2611f58d4c6de5e6 = gettime();
    self.is_opening_crate = 1;
}

// Namespace ob_activity_package_thief
// Params 0, eflags: 0x4
// Checksum 0xdfe0bf81, Offset: 0x19b2
// Size: 0x1b
function private function_dc26f2539c561d30()
{
    if ( isalive( self ) )
    {
        cap::cap_start( "cap_solo_interaction", "cap_idle_wreck_crouch_investigate" );
    }
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x9b2da73f, Offset: 0x19d5
// Size: 0x73
function function_42fedb70c9894357()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    self allowedstances( "stand", "prone", "crouch" );
    
    if ( isdefined( self._blackboard ) )
    {
        cap::cap_exit();
    }
    
    self.allowpain = 1;
    self.ignoreall = 0;
    self.playing_skit = undefined;
    self cleargoalentity();
    self.script_stealthgroup = self.old_stealth;
    utility::clear_demeanor_override();
}

// Namespace ob_activity_package_thief
// Params 0
// Checksum 0x27fb1d2c, Offset: 0x1a50
// Size: 0xc6
function function_2f7bbbc5012b340f()
{
    var_9573911a6f37ae5d = utility::array_random( self.activity_instance.var_91c91f4a631c481d.botencounter );
    encounter_name = "ai_encounter:" + var_9573911a6f37ae5d.encounter;
    n_spawn_radius = 64;
    v_ground = self.origin;
    self.request_id = self.activity_instance activity_ai_encounters::function_eb8506829193f5eb( encounter_name, v_ground, n_spawn_radius, 1, 1, 1, 2 );
    self.activity_instance activity_ai_encounters::function_52d1342183200a8f( self.request_id, &_bot_spawned_callback, self );
    self.scriptable setscriptablepartstate( "ob_package_thief", "hidden" );
}

// Namespace ob_activity_package_thief
// Params 4
// Checksum 0xfa1ed22c, Offset: 0x1b1e
// Size: 0xa9
function _bot_spawned_callback( requestid, userdata, agent, data )
{
    userdata.activity_instance endon( #"activity_ended" );
    userdata.activity_instance endon( #"instance_destroyed" );
    agent endon( #"death" );
    agent function_fa32376aaa88a7a2( userdata.activity_instance.awarenesszone[ 0 ].origin, userdata.activity_instance.awarenesszone[ 0 ].radius );
}

/#

    // Namespace ob_activity_package_thief
    // Params 0, eflags: 0x4
    // Checksum 0x4bae36f5, Offset: 0x1bcf
    // Size: 0x2b, Type: dev
    function private debug_draw()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_package_thief", 0 ) )
            {
            }
            
            waitframe();
        }
    }

    // Namespace ob_activity_package_thief
    // Params 1, eflags: 0x4
    // Checksum 0x4965a12f, Offset: 0x1c02
    // Size: 0x53, Type: dev
    function private function_8eeb50e8ea4082ae( text )
    {
        if ( !getdvarint( @"scr_debug_package_thief", 0 ) )
        {
            return;
        }
        
        print3d( activity_instance_common::function_776ee11e7acc64a5( self ) + ( 0, 0, 150 ), text, ( 1, 0, 0 ), 1, 1, 100, 1 );
    }

#/
