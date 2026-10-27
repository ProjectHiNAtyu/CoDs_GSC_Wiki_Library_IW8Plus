// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack_vip.gsc  (hash_7017690291f0d39c.gscc) (size: 8503 Bytes / 0x2137 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe504051b (3842245915)
// size ...... 8503 (0x2137)
// includes .. 19  (offset: 0x1f17)
// strings ... 29  (offset: 0x1faf)
// dev strs .. 0   (offset: 0x2137)
// exports ... 23  (offset: 0x125b)
// cseg ...... 0x360 + 0xefb (0x125b)
// imports ... 79  (offset: 0x15f3)
// animtree1 . 0   (offset: 0x2137)
// animtree2 . 0   (offset: 0x2137)
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\interaction;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_audio;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_hijack;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_intro;
#using scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vo;

#namespace mp_sat_ob_capricorn_hijack_vip;

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0, eflags: 0x5
// Checksum 0x69381a3a, Offset: 0x37e
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mp_sat_ob_capricorn_hijack_vip", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0, eflags: 0x4
// Checksum 0x21aa1551, Offset: 0x3a7
// Size: 0x6f
function private function_538033a540e63c70()
{
    level.current_activity_name = "OB_CAPRICORN_HIJACK_VIP";
    activity_common::registeractivitytype( "OB_CAPRICORN_HIJACK_VIP", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK_VIP", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK_VIP", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "OB_CAPRICORN_HIJACK_VIP", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "OB_CAPRICORN_HIJACK_VIP" );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x1d05fec3, Offset: 0x41e
// Size: 0xb8
function activity_setup()
{
    level.request_ids = undefined;
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    mp_sat_ob_capricorn::set_minimap( "hijacked" );
    
    if ( activity_instance.additionalspawndata.is_startpoint_start )
    {
        activity_instance start();
    }
    
    level.stealth.head_shot_dist = 64;
    level.default_goalradius = 20;
    
    if ( !utility::flag( "flag_hijack_hatch_moving" ) )
    {
        mp_sat_ob_capricorn_hijack::function_cae930a2ff198ee( 1 );
    }
    
    if ( !isdefined( level.var_6e3f69e7a9cbc97 ) )
    {
        level.var_6e3f69e7a9cbc97 = [];
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0xcd3ea36b, Offset: 0x4de
// Size: 0x3d
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance main();
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x6fc999bc, Offset: 0x523
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 1
// Checksum 0xdca56dde, Offset: 0x547
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

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x5f08ee30, Offset: 0x603
// Size: 0x16
function start()
{
    activity_instance = self;
    mp_sat_ob_capricorn_intro::function_6000b34e76e11764();
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0xc369bf84, Offset: 0x621
// Size: 0x40f
function main()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    thread function_6af3deacfe587eb1();
    thread mp_sat_ob_capricorn_vo::function_ed3ccaf93d404bfd();
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_HIJACK_HATCH" );
    vip_scene_struct = utility::getstruct( "sat_scene_cin_hijacked_vip" );
    vip_scene_struct scene::pre_stream( undefined, undefined, -1 );
    vip_scene_struct scene::init();
    hijacktargetname = level.players.size < 3 ? "ai_hijack_below_deck" : "ai_hijack_below_deck_3p";
    level.var_fbe9f417a730b6f7 = ai_spawn_director::array_spawn_targetname( hijacktargetname );
    thread function_de1d0803493d6854( level.var_fbe9f417a730b6f7 );
    level.var_297a341fa6645a98 = function_46f9072493651dc9( level.var_6e3f69e7a9cbc97 );
    level.var_297a341fa6645a98 = arraycombine( level.var_297a341fa6645a98, level.var_fbe9f417a730b6f7 );
    thread mp_sat_ob_capricorn_hijack::function_1854b09f9fdae7f0( level.var_297a341fa6645a98 );
    thread mp_sat_ob_capricorn_hijack::hijack_stealth_setup( level.var_297a341fa6645a98, "encounter_hijack_below_sp_style" );
    var_cc9dbb3fbaaec44e = utility::getstruct( "OB_CAPRICORN_HIJACK_VIP_INTERACT" );
    thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "capricorn_hijack_vip_door", { #objective:"sat_ob_objectivemarker_storymissionmain", #waypoint:"sat_ob_objectivemarker_location" }, "vip_door_reached", undefined, undefined, 0, 1, 0, 0, 1, undefined, undefined, ( 0, -1.2, 16 ) );
    level thread mp_sat_ob_capricorn::function_776ea74dd9e92d46( "flag_vip_door_opened", "capricorn_hijack_vip_door" );
    interact = interaction::register_interact( var_cc9dbb3fbaaec44e.origin, 64, &function_947b2457aa19a3c1, &"sat_ob_story_missions_capricorn/ob_capricorn_hijack_vip_interact_title" );
    interact setcursorhint( "HINT_BUTTON" );
    thread function_f366cb5d2387d574();
    thread function_475d1e241307627();
    level utility::flag_wait( "flag_vo_hijacked_below_deck_callout" );
    thread ob_story_mission_utils::objective_text_show( "OB_CAPRICORN_HIJACK_VIP" );
    interact waittill( #"hash_7ca9643045420a95", player );
    interact delete();
    level utility::flag_set( "flag_vip_door_opened" );
    
    if ( level.var_3d9fc7aa7b25b565.stealthy_hijack )
    {
        coop::achievement_simple( "sat_wc_capricorn_stealth" );
    }
    
    var_ba7c3b8fa9d3823 = spawnstruct();
    var_ba7c3b8fa9d3823.origin = ( 2931.2, -6363.1, 697 );
    options = spawnstruct();
    options.flag_countdown = "player_regroup_vip_complete";
    options.var_ba7c3b8fa9d3823 = var_ba7c3b8fa9d3823;
    options.fadestartnone = 1;
    options.var_227ead15d2892709 = 1;
    options.triggerradius = 500;
    thread coop::function_164d95b45992525( options );
    level utility::flag_wait( "player_regroup_vip_complete" );
    function_a9e0ea346dfd7720();
    thread mp_sat_ob_capricorn_hijack::function_cae930a2ff198ee( 0 );
    level.stealth.head_shot_dist = 8;
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
    
    foreach ( player in level.players )
    {
        player thread coop::player_fade_with_shader( 1, 0.3 );
    }
    
    wait 0.3;
    thread function_b92bd8544cbfa311();
    activity_ai_encounters::function_ef590f5a067bcaf5();
    function_6918b9ff1f3634dc( var_cc9dbb3fbaaec44e.origin );
    level thread function_89e0f08352209dd7();
    function_3016c03d17f0e3ea();
    thread capricorn_audio::function_959c14409cd93823( "cin_op_cap_vip" );
    childthread function_99a8deac2d77bbad();
    vip_scene_struct scene::play();
    level notify( #"vip_scene_done" );
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 0 );
    
    if ( level.var_e19cd2015fc229d1 && level.players[ 0 ] )
    {
        level.players[ 0 ] function_277146ff1489921c();
        mp_sat_ob_capricorn::function_4fb7fff71f7b9c03();
    }
    
    ob_story_mission_utils::function_2686bb512b355040( "OB_CAPRICORN_HIJACK_BOSS" );
    thread function_63983dcb7f0cee33();
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0, eflags: 0x4
// Checksum 0x41052d5, Offset: 0xa38
// Size: 0x1c
function private function_277146ff1489921c()
{
    self endon( #"death_or_disconnect" );
    utility::ent_flag_wait_or_timeout( "player_additional_stream_pos_waiting", 3 );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0xa367b568, Offset: 0xa5c
// Size: 0x30
function function_99a8deac2d77bbad()
{
    level endon( #"vip_scene_done" );
    level.var_e19cd2015fc229d1 = 0;
    level waittill( #"scene_skip_fade_start" );
    level.var_e19cd2015fc229d1 = 1;
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 1
// Checksum 0xb0ee926c, Offset: 0xa94
// Size: 0x5f
function function_de1d0803493d6854( agents )
{
    level endon( #"game_ended" );
    level endon( #"flag_vip_door_opened" );
    
    for ( cleaned_up_agents = function_46f9072493651dc9( agents ); true ; cleaned_up_agents = function_46f9072493651dc9( agents ) )
    {
        if ( cleaned_up_agents.size == 0 )
        {
            level utility::flag_set( "vo_lower_deck_agents_eliminated" );
            return;
        }
        
        wait 2;
    }
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0, eflags: 0x4
// Checksum 0x2856f702, Offset: 0xafb
// Size: 0xd7
function private function_6af3deacfe587eb1()
{
    self endon( #"instance_destroyed" );
    level utility::flag_wait( "flag_vo_hijacked_below_deck_callout_done" );
    
    foreach ( player in level.players )
    {
        hint_string = player usinggamepad() ? &"sat_ob_story_missions_capricorn/ob_capricorn_active_camo_hint" : &"sat_ob_story_missions_capricorn/ob_capricorn_active_camo_hint_kbm";
        player utility::callsharedfunc( #"hint", #"add_simple", "hint_active_camo", hint_string, 10 );
    }
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0xde551a78, Offset: 0xbda
// Size: 0x182
function function_89e0f08352209dd7()
{
    level endon( #"hash_8f06a3938d8d7959" );
    
    foreach ( player in level.players )
    {
        player thread coop::player_fade_with_shader( 1, 0 );
    }
    
    foreach ( player in level.players )
    {
        player thread coop::player_fade_with_shader( 0, 0.3 );
    }
    
    level waittill( #"sat_scene_cin_hijacked_vip_fade_to_black" );
    
    foreach ( player in level.players )
    {
        player thread coop::player_fade_with_shader( 1, 0.5 );
    }
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x6d4f59a7, Offset: 0xd64
// Size: 0x8a
function function_63983dcb7f0cee33()
{
    level notify( #"hash_8f06a3938d8d7959" );
    
    foreach ( player in level.players )
    {
        player thread coop::player_fade_with_shader( 0, 1 );
    }
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x33fe0a3d, Offset: 0xdf6
// Size: 0x8a
function function_3016c03d17f0e3ea()
{
    doors = getentarray( "OB_CAPRICORN_VIP_ROOM_DOOR", "targetname" );
    
    foreach ( door in doors )
    {
        door delete();
    }
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 1
// Checksum 0xfd067c5a, Offset: 0xe88
// Size: 0xe9
function function_6918b9ff1f3634dc( origin )
{
    scriptables = getscriptablearrayinradius( undefined, undefined, origin, 2500 );
    entityless_scriptable = getentitylessscriptablearray( undefined, undefined, origin, 1000 );
    scriptables = arraycombine( scriptables, entityless_scriptable );
    
    foreach ( loot in scriptables )
    {
        if ( loot getscriptableisloot() )
        {
            utility::callsharedfunc( #"game", #"hash_46d169cc2f231f1b", loot );
            continue;
        }
        
        if ( loot.isequipment )
        {
            loot delete();
        }
    }
    
    removeallcorpses();
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 1, eflags: 0x4
// Checksum 0x17c1cf90, Offset: 0xf79
// Size: 0x1a
function private function_947b2457aa19a3c1( player )
{
    self notify( #"hash_7ca9643045420a95", player );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 1, eflags: 0x4
// Checksum 0x6aef8530, Offset: 0xf9b
// Size: 0x34
function private player_setup( player )
{
    activity_instance = self;
    utility::callsharedfunc( #"gametype", #"hash_b64530c1428fda8", player );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x64c31d91, Offset: 0xfd7
// Size: 0xe
function function_a9e0ea346dfd7720()
{
    utility::kill_exploder( "firework" );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x375f4ed3, Offset: 0xfed
// Size: 0x124
function function_b92bd8544cbfa311()
{
    level callback::remove( #"on_ai_killed", &mp_sat_ob_capricorn_vo::function_7a1349e4446a1b89 );
    
    if ( level.var_6e3f69e7a9cbc97 )
    {
        foreach ( agent in level.var_6e3f69e7a9cbc97 )
        {
            agent agent_utils::despawnagent();
        }
    }
    
    if ( level.var_fbe9f417a730b6f7 )
    {
        foreach ( agent in level.var_fbe9f417a730b6f7 )
        {
            agent agent_utils::despawnagent();
        }
    }
    
    level notify( #"end_hijack_stealth" );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0xb30be2c8, Offset: 0x1119
// Size: 0xcd
function function_475d1e241307627()
{
    sight_set = 0;
    
    while ( !sight_set )
    {
        var_a050c4d9af5cd131 = 1;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) || !isdefined( player.stealth ) )
            {
                continue;
            }
            
            if ( getstealthmaxthreat( player ) >= 1 )
            {
                break;
            }
            
            sight_set = 1;
        }
        
        waitframe();
    }
    
    threat_sight::threat_sight_set_enabled( 1 );
}

// Namespace mp_sat_ob_capricorn_hijack_vip
// Params 0
// Checksum 0x26ba037d, Offset: 0x11ee
// Size: 0x6d
function function_f366cb5d2387d574()
{
    self notify( #"hash_eb1b32e9f59d452d" );
    self endon( #"hash_eb1b32e9f59d452d" );
    level endon( #"end_hijack_stealth" );
    level waittill( #"hijack_stealth_lost" );
    var_3167942be6b7f3ac = function_87d6a87907cb5f7( "sight" );
    function_7926d25768d660e3( "sight", 1 );
    level waittill( #"flag_vip_door_opened" );
    function_7926d25768d660e3( "sight", var_3167942be6b7f3ac );
}

