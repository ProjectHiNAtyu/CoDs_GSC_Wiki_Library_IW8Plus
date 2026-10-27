// scripts\mp\ob\activities\ob_activity_abom_hunt.gsc  (hash_35e476caa95bb0cd.gscc) (size: 22641 Bytes / 0x5871 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6977f186 (1769468294)
// size ...... 22641 (0x5871)
// includes .. 25  (offset: 0x5475)
// strings ... 45  (offset: 0x553d)
// dev strs .. 14  (offset: 0x57c1)
// exports ... 68  (offset: 0x3261)
// cseg ...... 0x45e + 0x2e03 (0x3261)
// imports ... 198 (offset: 0x3d01)
// animtree1 . 0   (offset: 0x5871)
// animtree2 . 0   (offset: 0x5871)
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\objidpoolmanager;

#namespace ob_activity_abom_hunt;

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x5
// Checksum 0xa8bb51d9, Offset: 0x47c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_abom_hunt", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xc4ff7c15, Offset: 0x4a5
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_ABOM_HUNT", &activity_type_init );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x949ae3c9, Offset: 0x4c0
// Size: 0xdb
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_ABOM_HUNT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_ABOM_HUNT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_ABOM_HUNT", 2, &activity_end );
    activity_common::function_944074f3079c1d4e( "REV_OB_ABOM_HUNT", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_944074f3079c1d4e( "REV_OB_ABOM_HUNT", 4, &activity_get_center_point );
    activity_common::function_2dd4f07fa5c3e911( "PlayerFocusedOnActivity", &activity_player_focus, "REV_OB_ABOM_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLoseFocusedOnActivity", &function_729b53f772f3cd08, "REV_OB_ABOM_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &on_player_joined_activity, "REV_OB_ABOM_HUNT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &on_player_left_activity, "REV_OB_ABOM_HUNT" );
    scriptable::scriptable_addusedcallbackbypart( "ob_abom_hunt_dead_body", &function_bee0cea5faea9a17 );
    level callback::add( "activity_nightmare_zone_finish", &function_cc47db24fe493401 );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x999e9c29, Offset: 0x5a3
// Size: 0x1dc
function private activity_setup()
{
    activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ self.varianttag ];
    cooldown = activity_info.var_622af9ed9146813f.instancecooldown ?? -1;
    activity_info.var_622af9ed9146813f.instancecooldown = get_override_setting( "respawn_cooldown", cooldown );
    activity_info.var_7045a7bcdef0ce48 = get_override_setting( "max_repeat", 5 );
    self.var_124d37318b71248a = get_override_setting( "min_boss_damage_ratio", 1 );
    self.master = utility::getstruct( self.varianttag, "targetname" );
    self.boss_spawn_points = self.master utility::get_linked_structs();
    self.difficulty_region = "difficulty5";
    activity_participation::function_5e5913e13bf9cb28( self );
    
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:x24>", 0 ) )
        {
            thread function_ed031e82ce4e13b3();
        }
        
        if ( !level.var_7b0986b5a92cccd8 && function_a5cd5a36ccebe58( "<dev string:x34>", 0 ) )
        {
            setup_boss_spawn_point();
            activity_instance_common::function_46135a69bddfec2c( self );
            return;
        }
    #/
    
    if ( level.var_7b0986b5a92cccd8 )
    {
        foreach ( zone in level.var_7b0986b5a92cccd8 )
        {
            if ( setup_boss_spawn_point( zone.origin, zone.radius, 0 ) )
            {
                activity_instance_common::function_46135a69bddfec2c( self );
                return;
            }
        }
    }
    
    setup_red_flood_callbacks();
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x72057b4d, Offset: 0x787
// Size: 0x312
function private function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    namespace_4a69edc3725e741::function_f23bdcfc447427ae( undefined, 0, 1 );
    cleanup_red_flood_callbacks();
    setup_activity_objective_marker();
    phase_dead_body();
    spawn_point = self.boss_spawn_point;
    spatial_zone_container::function_5252f95edcf9e32c( self, "Awareness_Zone", &awareness_zone_get_center, [ self ] );
    self.spatial_zone_struct = spatial_zone_container::function_847140d2863dfbf8( self, "Awareness_Zone", undefined, 1000, 1 );
    activity_participation::function_a45fd1c5cc774007( self );
    activity_setup_quest_circle( spawn_point.origin, 1000 );
    function_4048a7b3f9bd8a10();
    phase_boss_fight();
    
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
                logstring( "[ABOM HUNT] player " + player.name + " removed from activity rewards due to insufficient boss damage: " + ( var_3f000c9156465fcf ?? 0 ) + " / " + self.var_2c7df72824504573 );
                activity_participation::function_61aa2b2879f2c0a2( self, player );
            }
        }
    }
    
    function_f6eea0934e038d5c();
    activity_instance_common::endactivity( self, 1 );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xf82a3b18, Offset: 0xaa1
// Size: 0x15
function private activity_end()
{
    self endon( #"instance_destroyed" );
    function_331069d6186bf9a0();
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xd3e102a6, Offset: 0xabe
// Size: 0x9
function private function_d4acef179eb9f9b2()
{
    function_331069d6186bf9a0();
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xcfe76822, Offset: 0xacf
// Size: 0x15
function private activity_get_center_point()
{
    return self.dead_body.origin;
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xdc0d92d5, Offset: 0xaed
// Size: 0x90
function private activity_player_focus( relevantinfostruct )
{
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in relevantinfostruct.playerlist )
        {
            game_utility::questcircle_showtoplayer( player );
        }
    }
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xffb06d3, Offset: 0xb85
// Size: 0x90
function private function_729b53f772f3cd08( relevantinfostruct )
{
    if ( game_utility::questcircle_exists() )
    {
        foreach ( player in relevantinfostruct.playerlist )
        {
            game_utility::questcircle_hidefromplayer( player );
        }
    }
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xa8958c43, Offset: 0xc1d
// Size: 0x2c
function private on_player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    update_boss_healthbar( player_list );
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xbdd62dd3, Offset: 0xc51
// Size: 0xa5
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
    
    hide_boss_healthbar( player_list );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xdde23b57, Offset: 0xcfe
// Size: 0x5d
function private function_331069d6186bf9a0()
{
    cleanup_red_flood_callbacks();
    activity_cleanup_quest_circle();
    
    if ( self.dead_body )
    {
        self.dead_body.activity_instance = undefined;
        self.dead_body utility::function_32b24db3127bff40( "ob_abom_hunt_dead_body", #"unusable" );
    }
    
    hide_boss_healthbar( self.playerparticipants );
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xaf9954d8, Offset: 0xd63
// Size: 0x6e
function private awareness_zone_get_center( activityinstance )
{
    if ( activityinstance.boss )
    {
        activityinstance.var_38c8b46ed2c3cd67 = activityinstance.boss.origin;
    }
    
    if ( activityinstance.var_38c8b46ed2c3cd67 )
    {
        return activityinstance.var_38c8b46ed2c3cd67;
    }
    
    return activityinstance.boss_spawn_point.origin;
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0x34aff116, Offset: 0xdd9
// Size: 0x86
function private function_cc47db24fe493401( params )
{
    if ( !isdefined( level.var_7b0986b5a92cccd8 ) )
    {
        level.var_7b0986b5a92cccd8 = [];
    }
    
    origin = params.origin;
    radius = params.radius;
    zone = { #radius:radius, #origin:origin };
    level.var_7b0986b5a92cccd8[ level.var_7b0986b5a92cccd8.size ] = zone;
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0x3328b937, Offset: 0xe67
// Size: 0xad
function private activity_setup_quest_circle( origin, radius )
{
    game_utility::questcircle_create( "Toxin_Bomb_Warn_Ob", origin, radius );
    game_utility::questcircle_hidefromall();
    focused_players = activity_definition_utils::function_9a67de09579cf0a2();
    
    foreach ( player in focused_players )
    {
        game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x326681c, Offset: 0xf1c
// Size: 0x12
function private activity_cleanup_quest_circle()
{
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x5f8de0c4, Offset: 0xf36
// Size: 0x10e
function private function_f6eea0934e038d5c()
{
    spawn_pos = self.reward_pos;
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

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0x64490bab, Offset: 0x104c
// Size: 0x29
function private function_e4a11037166b0e4c( player )
{
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:x3e>", 0 ) )
        {
            return 1;
        }
    #/
    
    return player function_67447652d443d53d();
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xa425eebf, Offset: 0x107e
// Size: 0xea
function private function_18f75aa896ef56f8( usable, player )
{
    activity_instance = usable.activity_instance;
    
    if ( !activity_instance function_e4a11037166b0e4c( player ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( usable.var_1674515c4a4c0655.size )
    {
        if ( arraycontains( usable.var_1674515c4a4c0655, player ) )
        {
            return { #string:&"", #type:"HINT_NOICON" };
        }
        else
        {
            return { #string:&"sat_ob_activities/activity_abom_hunt_analyze_in_progress", #type:"HINT_NOBUTTON" };
        }
        
        return;
    }
    
    return { #string:&"sat_ob_activities/activity_abom_hunt_analyze", #type:"HINT_NOICON" };
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xb01a916e, Offset: 0x1170
// Size: 0x9c
function private function_9004deb37dd31bf1( player )
{
    if ( self.activity_instance.type != "REV_OB_ABOM_HUNT" )
    {
        return;
    }
    
    if ( !self.activity_instance function_e4a11037166b0e4c( player ) )
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
        self.activity_instance notify( #"dead_body_used" );
    }
}

// Namespace ob_activity_abom_hunt
// Params 6, eflags: 0x4
// Checksum 0x3843b8dc, Offset: 0x1214
// Size: 0x43
function private function_bee0cea5faea9a17( instance, part, state, player, bautouse, usestring )
{
    instance thread function_9004deb37dd31bf1( player );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0xc
// Checksum 0x5e2e4861, Offset: 0x125f
// Size: 0xff
function private function_317d719db43bf226()
{
    self notify( #"hash_6dc44eed775e7c02" );
    self endon( #"hash_6dc44eed775e7c02" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    function_38b84cb3d4357dd7( self.objidnum );
    visible_players = [];
    
    while ( true )
    {
        should_visible_players = get_activity_visible_players();
        
        if ( self.var_7d304847f0e46705 )
        {
            should_visible_players = arrayremove( should_visible_players, self.playerparticipants );
        }
        else
        {
            should_visible_players = arraycombineunique( should_visible_players, self.playerparticipants );
        }
        
        new_visible_players = arrayremove( should_visible_players, visible_players );
        var_19f24f6baa654a85 = arrayremove( visible_players, should_visible_players );
        
        if ( new_visible_players.size )
        {
            namespace_d7fa4530141146a5::function_7c5730b9151d91( new_visible_players, self.objidnum );
        }
        
        if ( var_19f24f6baa654a85.size )
        {
            namespace_d7fa4530141146a5::function_831cf83f2b250537( var_19f24f6baa654a85, self.objidnum );
        }
        
        if ( new_visible_players.size || var_19f24f6baa654a85.size )
        {
            visible_players = should_visible_players;
        }
        
        wait 0.1;
    }
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x91d13816, Offset: 0x1366
// Size: 0x7e
function private setup_activity_objective_marker()
{
    self.objidnum = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_abom_hunt", 0, 0 );
    objidpoolmanager::update_objective_position( self.objidnum, self.dead_body.origin + ( 0, 0, 30 ) );
    setup_hovercard( self.objidnum );
    objective_showtoplayersinmask( self.objidnum );
    thread function_317d719db43bf226();
    notify_players_activity_begin( self.objidnum );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x42680afd, Offset: 0x13ec
// Size: 0x5c
function private phase_dead_body()
{
    self.dead_body setscriptablepartstate( "ob_abom_hunt_dead_body", #"usable" );
    self.dead_body interaction::set_interact_hint_callback( &function_18f75aa896ef56f8 );
    self waittill( #"dead_body_used" );
    self.dead_body setscriptablepartstate( "ob_abom_hunt_dead_body", #"unusable" );
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xae02dfb0, Offset: 0x1450
// Size: 0x60
function private function_402009bcdf3c11de( startpos, endpos )
{
    path_info = function_fdee9f19da89757d( startpos, endpos );
    function_2bcff8b80bc30d8( startpos, endpos, path_info.bezier_end_pos, path_info.bezier_control_pos, path_info.random_radius, path_info.spiral_height );
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xfe440b30, Offset: 0x14b8
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

// Namespace ob_activity_abom_hunt
// Params 6, eflags: 0x4
// Checksum 0x8d15977c, Offset: 0x15d5
// Size: 0x188
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
    scriptable = spawnscriptable( %"sat_ob_red_flood_cradle_collect_fx", startpos );
    scriptable utility::scriptable_setparententity( mover );
    mover utility::function_8001268940441423( startpos, bezier_end, bezier_control_point, var_58c89811f3b06a50, 0, 1 );
    mover utility::follow_spiral( radius, 0, ( 0, 0, 1 ), spiral_height * -1, var_324fd5ce37eb5bfa, endpos, 1, 0 );
    scriptable setscriptablepartstate( #"body", #"impact" );
    wait 0.2;
    scriptable freescriptable();
    mover delete();
    self.var_8b45b0401d2cc8a3--;
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xaa4ed5e9, Offset: 0x1765
// Size: 0xbe
function private function_eb72b9ebf4b92bf2( pos, progress )
{
    if ( self.var_ac3f65cae6d3b9fe >= 100 )
    {
        return;
    }
    
    vfx_end_pos = self.dead_body.origin + ( 0, 0, 60 );
    function_402009bcdf3c11de( pos, vfx_end_pos );
    
    if ( self.var_ac3f65cae6d3b9fe < 100 )
    {
        self.var_ac3f65cae6d3b9fe = clamp( self.var_ac3f65cae6d3b9fe + progress, 0, 100 );
        activity_definition_utils::updateprogress( self.var_ac3f65cae6d3b9fe, self );
        
        if ( self.var_ac3f65cae6d3b9fe >= 100 )
        {
            self.var_c63209be75d96ba = 1;
            self notify( #"hash_745f9dfb87f9cbea" );
        }
    }
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0x2ec6e23b, Offset: 0x182b
// Size: 0x23, Type: bool
function private function_3f996c8bc9980cf8( requestid, activityinstance )
{
    return activityinstance.var_ac3f65cae6d3b9fe >= 100;
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xc7c38e0b, Offset: 0x1857
// Size: 0x5f
function private function_f739bad011c913bd( params, activityinstance )
{
    if ( self.death_source != "despawn" )
    {
        pos = self gettagorigin( "j_head" );
        progress = get_override_setting( "cradle_per_kill", 2 );
        activityinstance thread function_eb72b9ebf4b92bf2( pos, progress );
    }
}

// Namespace ob_activity_abom_hunt
// Params 4, eflags: 0x4
// Checksum 0x1f3060b2, Offset: 0x18be
// Size: 0xff
function private function_2d319a1918e6fe32( requestid, activityinstance, agent, data )
{
    var_4ad4cb6bcd99d6dc = activityinstance.dead_body;
    agent setgoalpos( var_4ad4cb6bcd99d6dc.origin, 1000 );
    agent function_fa32376aaa88a7a2( var_4ad4cb6bcd99d6dc.origin, activityinstance.boss_spawn_point.radius );
    agent._blackboard.var_b213ded5043dfa2b = agent.origin;
    agent._blackboard.var_8d11b98561e1eb81 = 100;
    agent._blackboard.var_8d34ab856208146f = 400;
    agent setscriptablepartstate( #"burned_cradle", #"burned_on", 0 );
    agent callback::add( #"on_ai_killed", &function_f739bad011c913bd, activityinstance );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x2d372b38, Offset: 0x19c5
// Size: 0x5e
function private spawn_cradle_flood_fill()
{
    self.var_ac3f65cae6d3b9fe = 0;
    flood_request_id = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_enc_abom_hunt_cradle_flood_fill", self.dead_body.origin, 1000, 1, 0, 1, 2 );
    activity_ai_encounters::function_d33de057e760c97b( flood_request_id, &function_3f996c8bc9980cf8, self );
    activity_ai_encounters::function_52d1342183200a8f( flood_request_id, &function_2d319a1918e6fe32, self );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xb3e30413, Offset: 0x1a2b
// Size: 0x2b
function private function_4048a7b3f9bd8a10()
{
    activity_definition_utils::function_a0a94881bc380bbf( 0, self );
    activity_definition_utils::updateprogress( 0, self, 100 );
    spawn_cradle_flood_fill();
    self waittill( #"hash_745f9dfb87f9cbea" );
    waitframe();
}

// Namespace ob_activity_abom_hunt
// Params 3, eflags: 0x4
// Checksum 0x72f3c548, Offset: 0x1a5e
// Size: 0x31a, Type: bool
function private setup_boss_spawn_point( origin, radius, var_3450fea5b90b2ca8 )
{
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    valid_spawn_points = [];
    
    if ( origin )
    {
        foreach ( spawn_point in self.boss_spawn_points )
        {
            if ( distance2d( spawn_point.origin, origin ) <= radius )
            {
                valid_spawn_points[ valid_spawn_points.size ] = spawn_point;
            }
        }
    }
    else
    {
        valid_spawn_points = self.boss_spawn_points;
    }
    
    self.boss_spawn_point = utility::array_random( valid_spawn_points );
    
    /#
        if ( !origin )
        {
            origin = self.boss_spawn_point.origin;
            radius = self.boss_spawn_point.radius;
        }
    #/
    
    if ( !self.boss_spawn_point )
    {
        logstring( "[ABOM HUNT] " + self.varianttag + " No valid spawn points found for Abomination Boss origin: " + origin + " radius: " + radius );
        return false;
    }
    
    logstring( "[ABOM HUNT] " + self.varianttag + " spawn at " + self.boss_spawn_point.origin );
    self.var_e45112c70c3b2a70 = { #radius:radius, #origin:origin };
    return_point_structs = self.boss_spawn_point utility::get_linked_structs();
    self.var_2e18d2ace34ed3c = [];
    
    foreach ( struct in return_point_structs )
    {
        self.var_2e18d2ace34ed3c[ self.var_2e18d2ace34ed3c.size ] = struct.origin;
    }
    
    body_spawn_origin = ob_activity_utility::function_fd8fc0e0d2300792( self.boss_spawn_point.origin );
    body_spawn_angles = ob_activity_utility::function_fd8fc0e0d2300792( self.boss_spawn_point.angles );
    self.dead_body = getentitylessscriptablearray( undefined, undefined, body_spawn_origin, 100, "ob_abom_hunt_dead_body" )[ 0 ];
    
    if ( !self.dead_body )
    {
        if ( var_3450fea5b90b2ca8 )
        {
            while ( true )
            {
                nearby_players = getplayersinradius( body_spawn_origin, 1000 );
                
                if ( !nearby_players.size )
                {
                    break;
                }
            }
        }
        
        self.dead_body = spawnscriptable( %"ob_abom_hunt_dead_body", body_spawn_origin, body_spawn_angles );
    }
    
    self.dead_body.activity_instance = self;
    return true;
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xf65beb39, Offset: 0x1d81
// Size: 0x74
function private function_137ecc3aa80a8dc7( player, damage )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_d37b5fa0bcc48a74 ) )
    {
        self.var_d37b5fa0bcc48a74 = [];
    }
    
    var_d37b5fa0bcc48a74 = self.var_d37b5fa0bcc48a74;
    
    if ( !isdefined( var_d37b5fa0bcc48a74[ player getxuid() ] ) )
    {
        var_d37b5fa0bcc48a74[ player getxuid() ] = 0;
    }
    
    var_d37b5fa0bcc48a74[ player getxuid() ] += damage;
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xecc8177b, Offset: 0x1dfd
// Size: 0x97
function private boss_damage_watcher( activityinstance )
{
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker );
        attackerplayer = isplayer( attacker ) ? attacker : attacker.owner;
        activityinstance function_137ecc3aa80a8dc7( attackerplayer, damage );
    }
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0x4eebac15, Offset: 0x1e9c
// Size: 0xbc
function private on_boss_killed( params, activityinstance )
{
    eattacker = params.eattacker;
    attackerplayer = isplayer( eattacker ) ? eattacker : eattacker.owner;
    activityinstance function_137ecc3aa80a8dc7( attackerplayer, params.idamage );
    activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( activityinstance.var_f5c7f59b645e1f2c );
    activityinstance.reward_pos = activityinstance.boss.origin;
    activityinstance.var_f5c7f59b645e1f2c = undefined;
    activityinstance.boss = undefined;
    activityinstance notify( #"boss_killed" );
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0x38f6907a, Offset: 0x1f60
// Size: 0x45
function private setup_boss_objective_marker( agent )
{
    self.var_f5c7f59b645e1f2c = namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_objectivemarker_abom_hunt_boss", 0, 1 );
    setup_hovercard( self.var_f5c7f59b645e1f2c );
    objidpoolmanager::update_objective_onentity( self.var_f5c7f59b645e1f2c, agent );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x80d2a2b8, Offset: 0x1fad
// Size: 0x7c
function private function_60f1bf665f6d65ed()
{
    boss = self.boss;
    return_point = boss.spawn_point;
    
    if ( self.var_2e18d2ace34ed3c.size && distance2d( boss.origin, boss.spawn_point ) > 7000 )
    {
        return_point = utility::function_4325398d215ecda5( boss.origin, self.var_2e18d2ace34ed3c, 7000 );
    }
    
    return return_point;
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0x68da18a4, Offset: 0x2032
// Size: 0x196
function private function_86e8446c583cf643( position )
{
    agent = self;
    agent endon( #"death" );
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent clearbtgoal( 3 );
    wait randomfloatrange( 1, 2 );
    agent setbtgoalpos( 0, position );
    agent setbtgoalpos( 1, position );
    agent setbtgoalradius( 0, 256 );
    agent setbtgoalradius( 1, 256 );
    agent zombie_utils::function_a8ce00e0448cb6f0( "sprint", "oob", 1000 );
    
    while ( true )
    {
        msg = agent utility::waittill_any_timeout( 1, "goal", "bad_path", "goal_reached", "bt_goal" );
        
        if ( msg != "timeout" )
        {
            if ( msg == "bad_path" )
            {
                /#
                    debugstar( agent.origin, ( 1, 0, 0 ), 10000, "<dev string:x4d>", 1 );
                    debugstar( position, ( 1, 0, 0 ), 10000, "<dev string:x5b>", 1 );
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

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xee7489d9, Offset: 0x21d1
// Size: 0x2c5
function private function_12fa995bfbb5301f()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.boss endon( #"death" );
    boss = self.boss;
    combat_area = self.var_e45112c70c3b2a70;
    
    while ( true )
    {
        is_oob = distance2d( boss.origin, combat_area.origin ) > combat_area.radius;
        
        /#
            if ( function_a5cd5a36ccebe58( "<dev string:x6e>", 0 ) )
            {
                reference_point = level.players[ 0 ].origin;
                
                foreach ( boss_return_point in self.var_2e18d2ace34ed3c )
                {
                    color = ( 1, 0, 0 );
                    var_f1f184a578eeda8a = "<dev string:x77>";
                    
                    if ( reference_point )
                    {
                        var_f1f184a578eeda8a = distance2d( reference_point, boss_return_point );
                        
                        if ( var_f1f184a578eeda8a <= 7000 )
                        {
                            color = ( 0, 0, 1 );
                        }
                    }
                    
                    sphere( boss_return_point, 50, color, 0, 1 );
                    cylinder( boss_return_point, boss_return_point + ( 0, 0, 10 ), 7000, color, 0, 1 );
                    print3d( boss_return_point, "<dev string:x78>" + var_f1f184a578eeda8a, color, 1, 1, 1 );
                }
                
                cylinder( combat_area.origin, combat_area.origin + ( 0, 0, 10 ), combat_area.radius, ( 1, 1, 0 ), 0, 1 );
                print3d( combat_area.origin, "<dev string:x8b>" + combat_area.radius, ( 1, 1, 0 ), 1, 1, 1 );
            }
        #/
        
        if ( is_oob )
        {
            return_point = function_60f1bf665f6d65ed();
            
            if ( return_point )
            {
                return_point = getclosestpointonnavmesh( return_point, boss );
                
                /#
                    if ( function_a5cd5a36ccebe58( "<dev string:x6e>", 0 ) )
                    {
                        debug_draw_frames = 600;
                        
                        if ( return_point )
                        {
                            sphere( return_point, 50, ( 1, 0, 0 ), 0, debug_draw_frames );
                            print3d( return_point, "<dev string:xa4>", ( 0, 1, 0 ), 1, 1, debug_draw_frames );
                        }
                    }
                #/
                
                if ( !boss function_86e8446c583cf643( return_point ) )
                {
                    wait 10;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_abom_hunt
// Params 4, eflags: 0x4
// Checksum 0xfbf6523b, Offset: 0x249e
// Size: 0x174
function private boss_spawned_callback( requestid, userdata, agent, data )
{
    activity_instance = userdata;
    agent._blackboard.var_b213ded5043dfa2b = agent.origin;
    agent._blackboard.var_8d11b98561e1eb81 = 100;
    agent._blackboard.var_8d34ab856208146f = 400;
    agent.suppress_minimap_icon = 1;
    agent.spawn_point = agent.origin;
    agent.var_a13bed1ac47e1b2c = 1;
    agent.var_e2fce82443c7cf79 = 1;
    agent callback::add( #"on_ai_killed", &on_boss_killed, activity_instance );
    agent thread boss_damage_watcher( activity_instance );
    activity_instance.boss = agent;
    activity_instance notify( #"boss_spawned" );
    activity_instance setup_boss_objective_marker( agent );
    activity_instance create_boss_healthbar( agent );
    
    /#
        var_f791e93cc48c0c97 = function_a5cd5a36ccebe58( "<dev string:xba>", 0 );
        
        if ( var_f791e93cc48c0c97 )
        {
            agent.maxhealth = var_f791e93cc48c0c97;
            agent.health = var_f791e93cc48c0c97;
        }
    #/
    
    activity_instance.var_2c7df72824504573 = agent.health;
    activity_instance thread function_12fa995bfbb5301f();
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xfebaf700, Offset: 0x261a
// Size: 0x16, Type: bool
function private should_shutdown_flood( requestid, activityinstance )
{
    return false;
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x590c840f, Offset: 0x2639
// Size: 0x9b
function private spawn_ai()
{
    spawn_point = self.boss_spawn_point;
    request_id = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_enc_ob_abom_hunt_boss", spawn_point.origin, 1000, 1, 1, 1, 0 );
    activity_ai_encounters::function_48582991402cac50( request_id, 1 );
    function_64ac8c4e752f4dca( request_id, 0 );
    activity_ai_encounters::function_52d1342183200a8f( request_id, &boss_spawned_callback, self );
    flood_request_id = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:sat_ob_enc_abom_hunt_flood_fill", spawn_point.origin, 1000, 1, 0, 1, 0 );
    activity_ai_encounters::function_d33de057e760c97b( flood_request_id, &should_shutdown_flood, self );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xc5c2165c, Offset: 0x26dc
// Size: 0x8e
function private function_bdd726d8cd503150()
{
    self.boss endon( #"death" );
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"boss_killed" );
    
    while ( true )
    {
        game_utility::questcircle_move( self.boss.origin );
        objidpoolmanager::update_objective_position( self.objidnum, self.boss.origin + ( 0, 0, 200 ) );
        waitframe();
    }
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xa47ebb34, Offset: 0x2772
// Size: 0x94
function private phase_boss_fight()
{
    activity_participation::function_5e5913e13bf9cb28( self );
    activity_definition_utils::function_a0a94881bc380bbf( 1, self );
    activity_definition_utils::updateprogress( 0, self, 1 );
    spawn_ai();
    self waittill( #"boss_spawned" );
    spatial_zone_container::function_ddcd5f35f0032b25( self, "Awareness_Zone", self.spatial_zone_struct );
    self.spatial_zone_struct = spatial_zone_container::function_847140d2863dfbf8( self, "Awareness_Zone", undefined, 2000, 1 );
    game_utility::function_d46d8731ed9d281( 2000 );
    thread function_bdd726d8cd503150();
    self.var_7d304847f0e46705 = 1;
    thread function_317d719db43bf226();
    self waittill( #"boss_killed" );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xb20038aa, Offset: 0x280e
// Size: 0x33
function private setup_red_flood_callbacks()
{
    level callback::add( "activity_nightmare_zone_spawn", &on_activity_nightmare_zone_spawn, self );
    level callback::add( "activity_nightmare_zone_finish", &on_activity_nightmare_zone_finish, self );
    self.var_3b86bad85fc60692 = 1;
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x7212aa66, Offset: 0x2849
// Size: 0x3e
function private cleanup_red_flood_callbacks()
{
    if ( self.var_3b86bad85fc60692 )
    {
        level callback::remove( "activity_nightmare_zone_spawn", &on_activity_nightmare_zone_spawn, self );
        level callback::remove( "activity_nightmare_zone_finish", &on_activity_nightmare_zone_finish, self );
        self.var_3b86bad85fc60692 = undefined;
    }
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0x96405292, Offset: 0x288f
// Size: 0x5b
function private on_activity_nightmare_zone_spawn( params, activityinstance )
{
    origin = params.origin;
    radius = params.radius;
    
    if ( !activityinstance.boss_spawn_point )
    {
        activityinstance setup_boss_spawn_point( origin, radius );
    }
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xc27df75a, Offset: 0x28f2
// Size: 0xa3
function private on_activity_nightmare_zone_finish( params, activityinstance )
{
    level endon( #"game_ended" );
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    
    if ( activityinstance.boss_spawn_point )
    {
        origin = params.origin;
        radius = params.radius;
        
        if ( distance2d( activityinstance.boss_spawn_point.origin, origin ) > radius )
        {
            return;
        }
        
        wait 5;
        activity_instance_common::function_46135a69bddfec2c( activityinstance );
    }
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xab25d4e7, Offset: 0x299d
// Size: 0xda
function private notify_players_activity_begin( objidnum )
{
    if ( !get_override_setting( "step10_only", 1 ) )
    {
        players = level.players;
    }
    else
    {
        players = get_quest_active_players();
    }
    
    foreach ( player in players )
    {
        ping_id = player calloutmarkerping::function_5d7b7302e94b97c2( objidnum );
        player calloutmarkerping_hide( ping_id );
        player calloutmarkerping_show( ping_id, player );
        player thread hud_message::showsplash( #"hash_a5163c6da00dcc8b" );
    }
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x1693affb, Offset: 0x2a7f
// Size: 0x65, Type: bool
function private function_e3822c24efb138e8()
{
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:xc6>", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    if ( utility::callsharedfunc( #"ob_quest", #"get_active_quest", self ) == #"hash_ce158a6f1971f5ae" )
    {
        return !utility::callsharedfunc( #"ob_quest", #"hash_e98cb49910a093f9", self, #"hash_196f267f7647645b" );
    }
    
    return false;
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x599f3176, Offset: 0x2aed
// Size: 0x8c
function private function_16f6a3ecf9e30fa3()
{
    /#
        if ( function_a5cd5a36ccebe58( "<dev string:xc6>", 0 ) == 2 )
        {
            return 1;
        }
    #/
    
    if ( utility::callsharedfunc( #"ob_quest", #"is_quest_completed", self, #"hash_ce158a6f1971f5ae" ) )
    {
        return 1;
    }
    
    if ( utility::callsharedfunc( #"ob_quest", #"get_active_quest", self ) == #"hash_ce158a6f1971f5ae" )
    {
        return utility::callsharedfunc( #"ob_quest", #"hash_e98cb49910a093f9", self, #"hash_196f267f7647645b" );
    }
    
    return 0;
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xf7678337, Offset: 0x2b82
// Size: 0x2f, Type: bool
function private function_67447652d443d53d()
{
    if ( !get_override_setting( "step10_only", 1 ) )
    {
        return true;
    }
    
    if ( function_16f6a3ecf9e30fa3() )
    {
        return true;
    }
    
    if ( function_e3822c24efb138e8() )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xb9cc5a85, Offset: 0x2bba
// Size: 0x91
function private get_activity_visible_players()
{
    players = [];
    
    foreach ( player in level.players )
    {
        if ( player function_67447652d443d53d() )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xc0892cef, Offset: 0x2c54
// Size: 0x91
function private get_quest_active_players()
{
    players = [];
    
    foreach ( player in level.players )
    {
        if ( player function_e3822c24efb138e8() )
        {
            players[ players.size ] = player;
        }
    }
    
    return players;
}

// Namespace ob_activity_abom_hunt
// Params 2, eflags: 0x4
// Checksum 0xb0975b2, Offset: 0x2cee
// Size: 0x2a
function private get_override_setting( name, defaultvalue )
{
    return getdvarint( hashcat( @"hash_358ff93cb50c2469", name ), defaultvalue );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0x851de792, Offset: 0x2d21
// Size: 0x3f
function private get_boss_healthbar_asset()
{
    switch ( self.subclass )
    {
        case #"hash_a18ec1c48b974dc7":
            return "ob_boss_abom_hunt";
        default:
            assertmsg( "<dev string:xd2>" );
            return;
    }
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0x3a961eaf, Offset: 0x2d68
// Size: 0x5c
function private create_boss_healthbar( boss )
{
    self.boss_healthbar_asset = boss get_boss_healthbar_asset();
    self.current_boss = boss;
    boss.ob_boss_healthbar_priority = 1;
    boss.activityinstance = self;
    boss thread function_b9d89bb349dd89c9();
    update_boss_healthbar( self.playerparticipants );
}

// Namespace ob_activity_abom_hunt
// Params 0, eflags: 0x4
// Checksum 0xe344a056, Offset: 0x2dcc
// Size: 0x54
function private function_b9d89bb349dd89c9()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        visible_players = self.activityinstance.playerparticipants;
        self.activityinstance update_boss_healthbar( visible_players );
    }
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xa8f45fdc, Offset: 0x2e28
// Size: 0x7e
function private update_boss_healthbar( players )
{
    foreach ( player in players )
    {
        thread function_8878a4153f4ddcbd( player );
    }
}

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xce0b4ee8, Offset: 0x2eae
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

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xff15f799, Offset: 0x3005
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

// Namespace ob_activity_abom_hunt
// Params 1, eflags: 0x4
// Checksum 0xb70bff80, Offset: 0x30a3
// Size: 0x36
function private setup_hovercard( objidnum )
{
    hovercardid = function_43b5ed5a14a56573( #"scriptbundle_hovercard", %"hovercard:hovercard_sat_ob_activity_abom_hunt" );
    function_3f1a6a0ae5901866( objidnum, hovercardid );
}

/#

    // Namespace ob_activity_abom_hunt
    // Params 2, eflags: 0x4
    // Checksum 0xeea3ac20, Offset: 0x30e1
    // Size: 0x22, Type: dev
    function private function_a5cd5a36ccebe58( name, defaultvalue )
    {
        return get_override_setting( name, defaultvalue );
    }

    // Namespace ob_activity_abom_hunt
    // Params 0, eflags: 0x4
    // Checksum 0x390c2b80, Offset: 0x310b
    // Size: 0x156, Type: dev
    function private function_ed031e82ce4e13b3()
    {
        self endon( #"instance_destroyed" );
        self endon( #"activity_ended" );
        var_f948e10375322ae4 = 10;
        duration_seconds = level.framedurationseconds * var_f948e10375322ae4;
        
        while ( true )
        {
            foreach ( spawn_point in self.boss_spawn_points )
            {
                origin = spawn_point.origin;
                radius = spawn_point.radius;
                color = ( 1, 0, 0 );
                
                if ( spawn_point == self.boss_spawn_point )
                {
                    color = ( 0, 1, 0 );
                }
                
                cylinder( origin, origin + ( 0, 0, 10 ), radius, color, 0, var_f948e10375322ae4 );
                print3d( origin, self.varianttag + "<dev string:xe8>" + radius, color, 1, 1, var_f948e10375322ae4 );
            }
            
            wait duration_seconds;
        }
    }

#/
