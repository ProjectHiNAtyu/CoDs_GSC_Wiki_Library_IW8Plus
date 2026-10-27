// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack.gsc  (hash_2327814f79a82228.gscc) (size: 18515 Bytes / 0x4853 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb29e4f82 (2996719490)
// size ...... 18515 (0x4853)
// includes .. 21  (offset: 0x4387)
// strings ... 69  (offset: 0x442f)
// dev strs .. 3   (offset: 0x482f)
// exports ... 46  (offset: 0x2a63)
// cseg ...... 0x7db + 0x2288 (0x2a63)
// imports ... 150 (offset: 0x3193)
// animtree1 . 0   (offset: 0x4853)
// animtree2 . 0   (offset: 0x4853)
#using script_636bd827a012af12;
#using scripts\anim\utility_common;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\stealth\manager;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_intro;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo;
#using scripts\mp\operator;

#namespace mp_sat_ob_capricorn_hijack;

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x5
// Checksum 0x91393123, Offset: 0x7f9
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_hijack", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x4fa00e95, Offset: 0x822
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_CAPRICORN_HIJACK";
    activity_common::registeractivitytype( "OB_CAPRICORN_HIJACK", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_CAPRICORN_HIJACK" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0xfbde94fa, Offset: 0x899
// Size: 0x11d
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    mp_sat_ob_capricorn::set_minimap( "hijacked" );
    thread ob_story_mission_utils::item_spawn_weapon( "p1_activity_hijacked_weapons", "hijack_staged_gear_clean_up", 1 );
    thread ob_story_mission_utils::item_spawn_equipment( "p1_activity_hijacked_equipment", "hijack_staged_gear_clean_up", 1 );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    var_43196519179db1b4 = getnoentvolumearray( "capricorn_hijacked_collision_oob_trigger", #targetname );
    
    if ( isdefined( var_43196519179db1b4 ) )
    {
        activity_instance.var_9d944daedbacb3fd = getent( "capricorn_hijacked_collision_oob", #targetname );
        
        if ( isdefined( activity_instance.var_9d944daedbacb3fd ) )
        {
            activity_instance thread function_420aebb7dddb9d97( var_43196519179db1b4[ 0 ], activity_instance.var_9d944daedbacb3fd );
        }
    }
    
    level.stealth.head_shot_dist = 64;
    level.default_goalradius = 20;
    setup_hatch();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0x4180e56a, Offset: 0x9be
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0x1c38278, Offset: 0xa03
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1
// Checksum 0x501b2bdf, Offset: 0xa27
// Size: 0xb4
function player_joined_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    
    foreach ( player in player_list )
    {
        activity_instance thread player_setup( player );
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0x258e42b4, Offset: 0xae3
// Size: 0xf
function start()
{
    activity_instance = self;
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0xadaa6981, Offset: 0xafa
// Size: 0x101
function main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    mp_sat_ob_capricorn_intro::function_6000b34e76e11764();
    utility::flag_wait( "squad_play_begin" );
    
    foreach ( player in level.players )
    {
        player utility::player_prestream_clear( "capricorn_hijack" );
    }
    
    chyron::function_d41002779543c80e();
    thread function_d8ade03e7166f728();
    level.var_3d9fc7aa7b25b565.stealthy_hijack = 1;
    thread function_1854b09f9fdae7f0( level.var_6e3f69e7a9cbc97 );
    stealth_manager::set_stealth_bundle( "sat_stealth_ob_sm_capricorn" );
    activity_instance function_d4c388ea68a033ed();
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x1caf38aa, Offset: 0xc03
// Size: 0x86
function private function_d4c388ea68a033ed()
{
    thread function_6af3deacfe587eb1();
    hijacktargetname = level.is_squad_size_small ? "ai_hijack_above_deck" : "ai_hijack_above_deck_3p";
    level.var_6e3f69e7a9cbc97 = ai_spawn_director::array_spawn_targetname( hijacktargetname );
    thread hijack_stealth_setup( level.var_6e3f69e7a9cbc97, "encounter_hijack_deck_sp_style_whole" );
    thread function_ecea4a0e2838ca7b( level.var_6e3f69e7a9cbc97 );
    thread capricorn_audio::function_b259141b5aa7eeee();
    thread function_a2e17af9e656441e();
    thread phase_stealth();
    level utility::flag_wait( "flag_hijack_hatch_opened" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x2aea99ec, Offset: 0xc91
// Size: 0x23
function private phase_stealth()
{
    level endon( #"hijack_stealth_lost" );
    phase_search_for_fukasawa();
    phase_access_lower_deck();
    phase_open_the_hatch();
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x7c482361, Offset: 0xcbc
// Size: 0x60
function private phase_search_for_fukasawa()
{
    level endon( #"hijack_stealth_lost" );
    thread mp_sat_ob_capricorn_vo::function_54aedada81a53a9e();
    activity_ai_encounters::function_79c1b913ce172ac5( self, "hijack_encounter_trigger_combat", undefined, &activity_ai_encounters::function_952687d67d74fdef );
    activity_ai_encounters::function_79c1b913ce172ac5( self, "hijack_encounter_trigger_non_combat", undefined, undefined, undefined, 1 );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_HIJACK_SEARCH" );
    level utility::flag_wait( "office_lower_level_vo_done" );
    level utility::flag_set( "phase_search_for_fukasawa_done" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x602c1901, Offset: 0xd24
// Size: 0x113
function private phase_access_lower_deck()
{
    level endon( #"hijack_stealth_lost" );
    level utility::flag_wait( "phase_search_for_fukasawa_done" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_HIJACK_HATCH" );
    
    foreach ( player in level.players )
    {
        player childthread monitor_hatch_waypoint_reached();
    }
    
    childthread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_hijack_hatch_room", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "hatch_waypoint_reached", "player_hatch_waypoint_reached", undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    thread function_64596a03afb0354b();
    thread mp_sat_ob_capricorn_vo::function_1c1517482ac28436();
    level waittill( #"hatch_reached" );
    level utility::flag_set( "phase_access_lower_deck_done" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x36ae2cbb, Offset: 0xe3f
// Size: 0x34
function private monitor_hatch_waypoint_reached()
{
    level endon( #"hatch_waypoint_reached" );
    self waittill( #"player_hatch_waypoint_reached" );
    level thread mp_sat_ob_capricorn::cancel_waypoint_objective_handler( "capricorn_hijack_hatch_room" );
    level notify( #"hatch_reached" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0x51d50d6f, Offset: 0xe7b
// Size: 0x28
function function_64596a03afb0354b()
{
    level endon( #"phase_access_lower_deck_done" );
    level waittill( #"hijack_stealth_lost" );
    level thread mp_sat_ob_capricorn::cancel_waypoint_objective_handler( "capricorn_hijack_hatch_room" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x442df78d, Offset: 0xeab
// Size: 0x110
function private phase_open_the_hatch()
{
    level endon( #"hijack_stealth_lost" );
    level utility::flag_wait( "phase_access_lower_deck_done" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_HIJACK_HATCH" );
    hatch_interact = utility::getstruct( "OB_CAPRICORN_HIJACK_VIP_HATCH_INTERACT" );
    childthread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_hijack_hatch", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "hatch_interact_reached", undefined, undefined, 1, 1, 0, undefined, undefined, undefined, undefined, ( 0, -1.2, 16 ) );
    hatch_interact = interaction::register_interact( hatch_interact.origin, 64, &hatch_interact_setup_func, &"sat_ob_story_missions_capricorn/ob_capricorn_hijack_vip_hatch_interact_title" );
    hatch_interact setcursorhint( "HINT_BUTTON" );
    thread function_8c36dd6a83decb44( hatch_interact );
    hatch_interact waittill( #"hatch_interact_triggered" );
    level utility::flag_set( "flag_hijack_hatch_used" );
    capricorn_audio::function_fd50fb5f7c965eb( hatch_interact.origin );
    level thread mp_sat_ob_capricorn::cancel_waypoint_objective_handler( "capricorn_hijack_hatch" );
    
    if ( hatch_interact )
    {
        hatch_interact delete();
    }
    
    level utility::flag_set( "flag_hijack_hatch_opened" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1
// Checksum 0x3e7367e5, Offset: 0xfc3
// Size: 0x3e
function function_8c36dd6a83decb44( hatch_interact )
{
    level endon( #"flag_hijack_hatch_opened" );
    level waittill( #"hijack_stealth_lost" );
    level thread mp_sat_ob_capricorn::cancel_waypoint_objective_handler( "capricorn_hijack_hatch" );
    
    if ( hatch_interact )
    {
        hatch_interact delete();
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0xc
// Checksum 0xb5995af, Offset: 0x1009
// Size: 0x6f
function private function_a2e17af9e656441e()
{
    self notify( #"hash_22ffe378f7473a69" );
    self endon( #"hash_22ffe378f7473a69" );
    level endon( #"flag_hijack_hatch_opened" );
    level waittill( #"hijack_stealth_lost" );
    function_bcd1605a69874d35();
    
    if ( !level utility::flag( "phase_search_for_fukasawa_done" ) )
    {
        phase_search_for_fukasawa();
    }
    
    if ( !level utility::flag( "phase_access_lower_deck_done" ) )
    {
        phase_access_lower_deck();
    }
    
    phase_open_the_hatch();
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0x6c8067fe, Offset: 0x1080
// Size: 0x171
function function_bcd1605a69874d35()
{
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_HIJACK_CLEAR_DECK" );
    var_3167942be6b7f3ac = function_87d6a87907cb5f7( "sight" );
    function_7926d25768d660e3( "sight", 1 );
    ais = getaiunittypearray( "bad_guys", "all" );
    arraysort( ais, undefined, &function_8055e3616007a57d, 1 );
    
    /#
        iprintlnbold( "<dev string:x4c>" );
    #/
    
    boat_whole = getent( "encounter_hijack_deck_sp_style_whole", #targetname );
    
    foreach ( agent in ais )
    {
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        if ( !agent getgoalentity() )
        {
            agent setgoalvolumeauto( boat_whole );
        }
        
        agent function_630eac6fd6900a61( "sat_ob_sm_capricorn_hijack", 1 );
        agent thread function_372b5e6894ad8b83( 1 );
        wait 2;
    }
    
    level thread function_55485011a42b0048();
    level thread function_8e16af215cf33dcb();
    level utility::flag_wait( "flag_hijack_no_agents_remain" );
    function_7926d25768d660e3( "sight", var_3167942be6b7f3ac );
    level utility::flag_set( "flag_hijack_deck_cleared" );
    level utility::flag_wait( "hijack_vo_stealth_regained_done" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0xc
// Checksum 0x3f01ea41, Offset: 0x11f9
// Size: 0x4a
function private function_55485011a42b0048()
{
    self notify( #"hash_19ab79686f9e584e" );
    self endon( #"hash_19ab79686f9e584e" );
    level endon( #"game_ended" );
    
    while ( getaicount( "bad_guys", "all" ) > 0 )
    {
        waitframe();
    }
    
    level utility::flag_set( "flag_hijack_no_agents_remain" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0xc
// Checksum 0x676c0324, Offset: 0x124b
// Size: 0x185
function private function_8e16af215cf33dcb()
{
    self notify( #"hash_202aa0ecd9c75a29" );
    self endon( #"hash_202aa0ecd9c75a29" );
    level endon( #"game_ended" );
    
    if ( level utility::flag( "flag_hijack_no_agents_remain" ) )
    {
        return;
    }
    
    level endon( #"flag_hijack_no_agents_remain" );
    nudge_threshold = getdvarint( @"hash_b9397f88ababeb07", 2 );
    
    for ( remaining_ais = getaiunittypearray( "bad_guys", "all" ); remaining_ais.size > 0 ; remaining_ais = function_46f9072493651dc9( remaining_ais ) )
    {
        /#
            iprintlnbold( "<dev string:x83>" );
        #/
        
        foreach ( agent in remaining_ais )
        {
            if ( isalive( agent ) )
            {
                in_combat = agent.enemy && agent isincombat();
                
                if ( remaining_ais.size < nudge_threshold )
                {
                    agent function_372b5e6894ad8b83( 1, 200 );
                }
                else if ( agent.goalradius > 1200 )
                {
                    agent function_372b5e6894ad8b83( !in_combat, 1200 );
                }
                else
                {
                    agent function_372b5e6894ad8b83( !in_combat, max( agent.goalradius - 20, 600 ) );
                }
                
                wait 2;
            }
        }
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0xaa0b120a, Offset: 0x13d8
// Size: 0xe6
function private pick_closest_player()
{
    closest_player = undefined;
    closest_distance = -1;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.sessionstate != "playing" )
        {
            continue;
        }
        
        player_distance = distancesquared( self.origin, player.origin );
        
        if ( !isdefined( closest_player ) || player_distance < closest_distance )
        {
            closest_player = player;
            closest_distance = player_distance;
        }
    }
    
    return closest_player;
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 2, eflags: 0x4
// Checksum 0x9bd353d7, Offset: 0x14c7
// Size: 0xbe
function private function_372b5e6894ad8b83( aggressive, goalradius )
{
    self endon( #"death" );
    closest_player = pick_closest_player();
    
    if ( closest_player )
    {
        self.goalradius = goalradius ?? distance( self.origin, closest_player.origin );
        
        if ( aggressive )
        {
            self getenemyinfo( closest_player );
            
            if ( self.stealth )
            {
                self setstealthstate( "combat" );
            }
        }
        
        if ( self.subclass == "ob_shielded" )
        {
            self setgoalpos( closest_player.origin );
            return;
        }
        
        if ( self getgoalentity() != closest_player )
        {
            self setgoalentity( closest_player, 1000 );
        }
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 2, eflags: 0x4
// Checksum 0xbd855c50, Offset: 0x158d
// Size: 0x7f, Type: bool
function private function_8055e3616007a57d( agent_a, agent_b )
{
    player_a = agent_a pick_closest_player();
    player_b = agent_b pick_closest_player();
    
    if ( !player_a || !player_b )
    {
        return false;
    }
    
    return distancesquared( agent_a.origin, player_a.origin ) < distancesquared( agent_b.origin, player_b.origin );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x3b967a29, Offset: 0x1615
// Size: 0xd7
function private function_6af3deacfe587eb1()
{
    self endon( #"instance_destroyed" );
    level utility::flag_wait( "active_camo_vo_done" );
    
    foreach ( player in level.players )
    {
        hint_string = player usinggamepad() ? &"sat_ob_story_missions_capricorn/ob_capricorn_active_camo_hint" : &"sat_ob_story_missions_capricorn/ob_capricorn_active_camo_hint_kbm";
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_active_camo", hint_string, 10 );
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1
// Checksum 0x5e180cb3, Offset: 0x16f4
// Size: 0x5f
function function_ecea4a0e2838ca7b( agents )
{
    level endon( #"game_ended" );
    level endon( #"flag_hijack_hatch_opened" );
    
    for ( cleaned_up_agents = function_46f9072493651dc9( agents ); true ; cleaned_up_agents = function_46f9072493651dc9( agents ) )
    {
        if ( cleaned_up_agents.size == 0 )
        {
            level utility::flag_set( "vo_stealth_agents_eliminated" );
            return;
        }
        
        wait 2;
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1, eflags: 0x4
// Checksum 0xd1df10f0, Offset: 0x175b
// Size: 0x5e
function private player_setup( player )
{
    activity_instance = self;
    
    if ( isdefined( activity_instance.var_9d944daedbacb3fd ) )
    {
        activity_instance.var_9d944daedbacb3fd hidefromplayer( player, 1 );
    }
    
    utility::callsharedfunc( #"gametype", #"hash_b64530c1428fda8", player );
    prestream_operator_skins();
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0xa25b2f95, Offset: 0x17c1
// Size: 0x12e
function private prestream_operator_skins()
{
    var_a2684dedbb3accf6 = [];
    
    foreach ( player in level.players )
    {
        var_c94fe7a52bb293af = player function_66df206dec9fe1ae();
        models = operator::function_fb2ad6ca3c6b708d( var_c94fe7a52bb293af );
        var_a2684dedbb3accf6 = arraycombine( var_a2684dedbb3accf6, models );
    }
    
    if ( var_a2684dedbb3accf6.size > 0 )
    {
        foreach ( player in level.players )
        {
            player thread utility::player_prestream_assets( "capricorn_hijack", "model", var_a2684dedbb3accf6, undefined, -1 );
        }
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 2, eflags: 0x4
// Checksum 0x7659c46f, Offset: 0x18f7
// Size: 0x82
function private function_420aebb7dddb9d97( trigger, var_710013f653649f8a )
{
    self endon( #"instance_destroyed" );
    trigger endon( #"delete" );
    players_triggered = [];
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        player_number = player getentitynumber();
        
        if ( !players_triggered[ player_number ] )
        {
            players_triggered[ player_number ] = 1;
            var_710013f653649f8a showtoplayer( player );
        }
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 2
// Checksum 0xfe470c8f, Offset: 0x1981
// Size: 0x154
function hijack_stealth_setup( agentarray, volume_targetname )
{
    if ( !level callback::exists( #"on_ai_killed", &mp_sat_ob_capricorn_vo::function_7a1349e4446a1b89 ) )
    {
        level callback::add( #"on_ai_killed", &mp_sat_ob_capricorn_vo::function_7a1349e4446a1b89 );
    }
    
    foreach ( agent in agentarray )
    {
        agent function_630eac6fd6900a61( "sat_ob_sm_capricorn_hijack_stealth", 1 );
        agent.goalradius = 20;
        agent aisettargetspeed( 56 );
        agent_volume = volume_targetname;
        
        if ( volume_targetname == "encounter_hijack_deck_sp_style_whole" && agent.script_noteworthy )
        {
            agent_volume = agent.script_noteworthy == "front" ? "encounter_hijack_deck_sp_style_front" : "encounter_hijack_deck_sp_style_back";
        }
        
        goal = getent( agent_volume, #targetname );
        
        if ( goal )
        {
            agent setgoalvolumeauto( goal );
        }
        
        thread function_1ef9cc6c10a833eb( agent );
        thread function_21270bb60f9b92a2( agent, agentarray );
    }
}

/#

    // Namespace mp_sat_ob_capricorn_hijack
    // Params 1, eflags: 0x4
    // Checksum 0x96a7d5e, Offset: 0x1add
    // Size: 0x6c, Type: dev
    function private function_efe6625a71431c35( wait_message )
    {
        self endon( wait_message );
        self endon( #"stealth_combat" );
        self endon( #"startCombatRush" );
        
        while ( true )
        {
            print3d( self.origin + ( 0, 0, 100 ), wait_message, ( 1, 1, 0 ), 1, 2, 1 );
            waitframe();
        }
    }

#/

// Namespace mp_sat_ob_capricorn_hijack
// Params 1, eflags: 0x4
// Checksum 0x884ff556, Offset: 0x1b51
// Size: 0x233
function private function_1ef9cc6c10a833eb( agent )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    level endon( #"hijack_cover_blown" );
    
    while ( true )
    {
        while ( !isdefined( agent.currentnode ) || !isdefined( agent.currentnode.script_ent_flag_wait ) )
        {
            agent waittill( #"goal" );
        }
        
        /#
            if ( getdvarint( @"hash_70271e44ed1f3b15", 0 ) )
            {
                agent childthread function_efe6625a71431c35( agent.currentnode.script_ent_flag_wait );
            }
        #/
        
        flag_wait_param = strtok( agent.currentnode.script_ent_flag_wait, "_" );
        distance = undefined;
        
        if ( flag_wait_param[ 1 ] )
        {
            distance = int( flag_wait_param[ 1 ] );
        }
        
        var_16e92ffd85c4d22e = flag_wait_param[ 0 ] == "sight";
        notify_string = agent.currentnode.script_ent_flag_wait;
        target_validated = 0;
        
        while ( !target_validated )
        {
            foreach ( player in level.players )
            {
                if ( distance )
                {
                    if ( distance * distance < distance2dsquared( agent.origin, player.origin ) )
                    {
                        continue;
                    }
                }
                
                if ( var_16e92ffd85c4d22e && !utility_common::player_can_see_ai( player, agent, 0.4 ) )
                {
                    continue;
                }
                
                interactionid = agent getinteractionid();
                
                if ( interactionid )
                {
                    abortinteraction( interactionid );
                }
                
                agent utility::ent_flag_set( notify_string );
                target_validated = 1;
                break;
            }
            
            wait 0.4;
        }
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0x7dc54385, Offset: 0x1d8c
// Size: 0x6e
function function_d8ade03e7166f728()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level utility::flag_wait( "hijack_stealth_check_01" );
    level utility::flag_wait( "hijack_stealth_check_02" );
    
    if ( !level.var_3d9fc7aa7b25b565.stealthy_hijack )
    {
        function_4c72e80a83674020();
    }
    
    level utility::flag_wait( "hijack_stealth_check_03" );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0xc6624693, Offset: 0x1e02
// Size: 0xf6
function function_4c72e80a83674020()
{
    if ( level utility::flag( "flag_hijack_hatch_opened" ) || level utility::flag( "flag_hijack_deck_cleared" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "hijack_stealth_check_01" ) && !level utility::flag( "hijack_spawned_reinforce_1" ) )
    {
        function_f5cb195acd34de42( "ai_encounter_capricorn_hijacked_reinforcement_01", "encounter_hijack_deck_sp_style_whole" );
        level utility::flag_set( "hijack_spawned_reinforce_1" );
        return;
    }
    
    if ( !level utility::flag( "hijack_stealth_check_03" ) && !level utility::flag( "hijack_spawned_reinforce_2" ) )
    {
        function_f5cb195acd34de42( "ai_encounter_capricorn_hijacked_reinforcement_02", "encounter_hijack_deck_sp_style_whole" );
        level utility::flag_set( "hijack_spawned_reinforce_2" );
        return;
    }
    
    if ( !level utility::flag( "hijack_stealth_check_04" ) && !level utility::flag( "hijack_spawned_reinforce_3" ) && !level utility::flag( "hijack_spawned_reinforce_2" ) )
    {
        function_f5cb195acd34de42( "ai_encounter_capricorn_hijacked_reinforcement_03", "encounter_hijack_deck_sp_style_whole" );
        level utility::flag_set( "hijack_spawned_reinforce_3" );
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 2
// Checksum 0x621cf207, Offset: 0x1f00
// Size: 0x86
function function_f5cb195acd34de42( targetname, goalvolume )
{
    activity_instance = self;
    encounter_id = activity_ai_encounters::function_dd54dae45031dade( targetname, 1, 1, 2, 1 );
    datastruct = spawnstruct();
    datastruct.goalvolume = getent( goalvolume, #targetname );
    
    if ( encounter_id.size > 0 )
    {
        ai_spawn_director::add_spawned_callback( encounter_id[ 0 ], &function_b7652d44f72fb16, datastruct );
        function_fbe9bb47edbe2d7c( encounter_id[ 0 ] );
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 4
// Checksum 0x3b8712d1, Offset: 0x1f8e
// Size: 0x5f
function function_b7652d44f72fb16( requestid, userdata, agent, data )
{
    if ( userdata.goalvolume )
    {
        if ( !agent getgoalentity() )
        {
            agent setgoalvolumeauto( userdata.goalvolume );
        }
        
        agent thread function_372b5e6894ad8b83( 1, 600 );
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1
// Checksum 0x2a6eb46a, Offset: 0x1ff5
// Size: 0x192
function function_1854b09f9fdae7f0( agentarray )
{
    self notify( #"hash_672cebf389e59459" );
    self endon( #"hash_672cebf389e59459" );
    level endon( #"end_hijack_stealth" );
    level.var_3d9fc7aa7b25b565.currently_stealthy = 1;
    
    while ( true )
    {
        if ( anyone_in_combat() || stealth_manager::anyone_in_hunt() )
        {
            wait 2;
            
            if ( anyone_in_combat() )
            {
                level notify( #"hijack_stealth_lost", level.var_3d9fc7aa7b25b565.stealthy_hijack );
                
                if ( level.var_3d9fc7aa7b25b565.stealthy_hijack )
                {
                    function_4c72e80a83674020();
                    function_146e8f1295cb1928( agentarray );
                    threat_sight::threat_sight_set_enabled( 0 );
                }
                
                level.var_3d9fc7aa7b25b565.stealthy_hijack = 0;
                level.var_3d9fc7aa7b25b565.currently_stealthy = 0;
                level callback::remove( #"on_ai_killed", &mp_sat_ob_capricorn_vo::function_7a1349e4446a1b89 );
                return;
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( player getclientomnvar( "ui_stealth_system_enabled" ) == 0 )
                {
                    player setclientomnvar( "ui_stealth_system_enabled", 1 );
                }
            }
        }
        
        wait 0.2;
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x3eed7254, Offset: 0x218f
// Size: 0x15a, Type: bool
function private anyone_in_combat()
{
    if ( !level.stealth )
    {
        return false;
    }
    
    if ( stealthgetanyaiincombat() )
    {
        return true;
    }
    
    now = gettime();
    
    if ( now > ( level.stealth.var_2d8aaec46dd267d5 ?? 0 ) )
    {
        level.stealth.var_2d8aaec46dd267d5 = now + 50;
        level.stealth.var_9be35a0934f7debc = undefined;
        ais = getaiunittypearray( "bad_guys", "all" );
        
        foreach ( guy in ais )
        {
            if ( !guy.stealth && guy.enemy && arraycontains( level.players, guy.enemy ) )
            {
                level.stealth.var_9be35a0934f7debc = 1;
                break;
            }
        }
    }
    
    return istrue( level.stealth.var_9be35a0934f7debc );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 2
// Checksum 0x45018b66, Offset: 0x22f2
// Size: 0xac
function function_21270bb60f9b92a2( agent, agentarray )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    level endon( #"hijack_stealth_lost" );
    level endon( #"hijack_cover_blown" );
    
    while ( true )
    {
        agent waittill( #"stealth_state_change", var_dfdae8bfef5472d4, ai );
        
        if ( var_dfdae8bfef5472d4 == 0 && agent.var_7a84781005a5b751 )
        {
            thread function_7f6981af60d54ade( agentarray );
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1
// Checksum 0xdf7728c3, Offset: 0x23a6
// Size: 0x1a8
function function_7f6981af60d54ade( agentarray )
{
    level utility::flag_set( "hijack_cover_blown" );
    thread mp_sat_ob_capricorn_vo::function_77e90a7ddc10cee5();
    
    foreach ( agent in agentarray )
    {
        if ( agent isininvestigate() )
        {
            continue;
        }
        
        agent.var_7a84781005a5b751 = 1;
        
        if ( agent.currentnode && agent.currentnode.script_ent_flag_wait )
        {
            agent utility::ent_flag_set( agent.currentnode.script_ent_flag_wait );
        }
        
        interactionid = agent getinteractionid();
        
        if ( interactionid && agent.currentnode.script_onlyidle )
        {
            despawninteraction( interactionid );
        }
        
        if ( agent.currentnode && agent.currentnode.script_label )
        {
            agent.currentnode.interaction = agent.currentnode.script_label;
            agent.currentnode.script_onlyidle = 0;
            agent thread ai_utility::go_to_node( agent.currentnode );
        }
        
        agent.goalradius = 32;
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1
// Checksum 0x5a062820, Offset: 0x2556
// Size: 0x81
function function_146e8f1295cb1928( agentarray )
{
    foreach ( agent in agentarray )
    {
        agent setstealthstate( "combat" );
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0
// Checksum 0x13ea8678, Offset: 0x25df
// Size: 0xa5
function delete_hatch()
{
    level.var_3d9fc7aa7b25b565.hijack_hatch = getentarray( "OB_CAPRICORN_HIJACK_VIP_HATCH_MODEL", "targetname" );
    
    foreach ( hatch_model in level.var_3d9fc7aa7b25b565.hijack_hatch )
    {
        hatch_model delete();
    }
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1
// Checksum 0xa61077f0, Offset: 0x268c
// Size: 0xfe
function function_cae930a2ff198ee( is_open )
{
    setup_hatch();
    offset = is_open == 1 ? ( -105, 0, 0 ) : ( 105, 0, 0 );
    
    foreach ( hatch_model in level.var_3d9fc7aa7b25b565.hijack_hatch )
    {
        hatch_model.angles += offset;
        hatch_model.col show();
    }
    
    level.var_3d9fc7aa7b25b565.hijack_hatch_blocker freescriptable();
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 1, eflags: 0x4
// Checksum 0x96b34c1f, Offset: 0x2792
// Size: 0x9d
function private hatch_interact_setup_func( player )
{
    foreach ( hatch_model in level.var_3d9fc7aa7b25b565.hijack_hatch )
    {
        thread toggle_hatch( hatch_model );
    }
    
    self notify( #"hatch_interact_triggered", player );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 0, eflags: 0x4
// Checksum 0x243b010a, Offset: 0x2837
// Size: 0x12d
function private setup_hatch()
{
    level.var_3d9fc7aa7b25b565.hijack_hatch = getentarray( "OB_CAPRICORN_HIJACK_VIP_HATCH_MODEL", "targetname" );
    
    foreach ( hatch_model in level.var_3d9fc7aa7b25b565.hijack_hatch )
    {
        col = getent( hatch_model.target, "targetname" );
        col linkto( hatch_model );
        hatch_model.col = col;
    }
    
    level.var_3d9fc7aa7b25b565.hijack_hatch_blocker = spawnscriptable( "t10_door_boat_hatch_02", level.var_3d9fc7aa7b25b565.hijack_hatch[ 0 ].origin, level.var_3d9fc7aa7b25b565.hijack_hatch[ 0 ].angles );
}

// Namespace mp_sat_ob_capricorn_hijack
// Params 2, eflags: 0x4
// Checksum 0xab902aab, Offset: 0x296c
// Size: 0xf7
function private toggle_hatch( hatch_model, open = 1 )
{
    offset = open == 1 ? ( -105, 0, 0 ) : ( 105, 0, 0 );
    
    if ( open )
    {
        level utility::flag_set( "flag_hijack_hatch_moving" );
        hatch_model rotateby( offset, 5, 2, 1 );
        playrumblelooponposition( "capricorn_world_light", hatch_model.origin );
        wait 2.5;
        hatch_model.col hide();
        level.var_3d9fc7aa7b25b565.hijack_hatch_blocker freescriptable();
        wait 2.5;
        stopallrumbles();
        level utility::flag_clear( "flag_hijack_hatch_moving" );
        return;
    }
    
    hatch_model.angles += offset;
    hatch_model.col show();
}

