// scripts\mp\ob\contracts\sat_ob_contract_taurus_intro.gsc  (hash_77f249c47bed871b.gscc) (size: 32674 Bytes / 0x7fa2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xea2f3e57 (3928964695)
// size ...... 32674 (0x7fa2)
// includes .. 37  (offset: 0x7732)
// strings ... 122 (offset: 0x785a)
// dev strs .. 1   (offset: 0x7f96)
// exports ... 66  (offset: 0x53ba)
// cseg ...... 0xee4 + 0x44d6 (0x53ba)
// imports ... 204 (offset: 0x5e0a)
// animtree1 . 0   (offset: 0x7fa2)
// animtree2 . 0   (offset: 0x7fa2)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using script_6e05fdc2c6f5fa06;
#using scripts\anim\dialogue;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\chyron;
#using scripts\common\snd\snd_utility;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_paths;
#using scripts\common\vehicle_spawn;
#using scripts\mp\armor;
#using scripts\mp\class;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\overlord;
#using scripts\mp\snd\snd_ob;

#namespace sat_ob_contract_taurus_intro;

// Namespace sat_ob_contract_taurus_intro
// Params 0, eflags: 0x5
// Checksum 0x64a47bb2, Offset: 0xf02
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"sat_ob_contract_taurus_intro", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0, eflags: 0x4
// Checksum 0x27a0f134, Offset: 0xf2b
// Size: 0x5c
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    activity_common::registeractivitytype( "REV_OB_TAURUS_INTRO", &activity_type_init );
    level callback::add( #"hash_cc06eb1d45f33a0c", &on_player_connect_squad );
    utility::add_fx( "taurus_intro_safehouse_smoke", "vfx_sat_wc_avalon_ob_safe_house_smk" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xb578879b, Offset: 0xf8f
// Size: 0x26e
function on_player_connect_squad( params )
{
    self notify( #"hash_e96a17e5426e87df" );
    self endon( #"hash_e96a17e5426e87df" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::flag_wait( "scriptables_ready" );
    utility::ent_flag_wait( "squad_play_begin" );
    story_contract_util::waittill_active( self, #"taurus_intro" );
    
    while ( !isdefined( level.taurus_intro_activity ) )
    {
        waitframe();
    }
    
    if ( !isdefined( level.var_519484a5bdaa7c24 ) )
    {
        classtableentry = getscriptbundle( hashcat( %"classtableentry:", "classtableentry_sat_ob_taurus_intro_loadout" ) );
        level.var_519484a5bdaa7c24 = { #loadout_key:"starting_loadout", #loadout_array:class::function_79947c7814a64d0e( classtableentry ) };
    }
    
    function_d626cc76cae468c1( self, level.var_519484a5bdaa7c24, 3 );
    
    if ( !isdefined( level.taurus_intro_activity.active_squads[ self.sessionsquadid ] ) )
    {
        squad_struct = { #sessionsquadid:self.sessionsquadid, #team:self.team };
        level.taurus_intro_activity.active_squads[ self.sessionsquadid ] = squad_struct;
        level.taurus_intro_activity thread function_5fef97ffe1e5b438( squad_struct );
    }
    else
    {
        squad_struct = level.taurus_intro_activity.active_squads[ self.sessionsquadid ];
        
        if ( squad_struct.objective_active )
        {
            ob_story_mission_utils::objective_marker_show( level.taurus_intro_activity.objective_id, [ self ] );
            logstring( "[Taurus] Showing objective marker to player : " + level.taurus_intro_activity.objective_id );
        }
    }
    
    foreach ( abilitycase in level.taurus_ability_cases )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, [ self ] );
    }
    
    activity_participation::function_bc67362dace4370c( level.taurus_intro_activity, self, "PlayerJoinedInteract" );
    thread function_4a88b972a328643d();
}

// Namespace sat_ob_contract_taurus_intro
// Params 3, eflags: 0x4
// Checksum 0xa2cc74dd, Offset: 0x1205
// Size: 0x148
function private function_d626cc76cae468c1( player, loadout, var_7c0d29caa7b948c6 )
{
    if ( loadout && player.current_loadout_key != loadout.loadout_key )
    {
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, var_7c0d29caa7b948c6, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
        offhands = player getweaponslistoffhands();
        
        foreach ( offhand in offhands )
        {
            if ( issubstr( offhand.basename, "cluster" ) )
            {
                player setweaponammoclip( offhand, 1 );
            }
        }
    }
    
    player armor::function_b359444c252374fc( 3 );
    
    if ( !isdefined( player.maxarmorhealth ) )
    {
        player.maxarmorhealth = 150;
    }
    
    player armor::setarmorhealth( player.maxarmorhealth );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xc6b7476e, Offset: 0x1355
// Size: 0x3cd
function function_5fef97ffe1e5b438( squad_struct )
{
    activity_instance = self;
    squad_struct endon( #"squad_empty" );
    var_64bb57aa2d6e8b35 = function_8aa672a8312c4734( squad_struct );
    var_64bb57aa2d6e8b35 utility::ent_flag_wait( "squad_play_begin" );
    var_64bb57aa2d6e8b35 childthread taurus_intro_music( activity_instance );
    level utility::flag_wait( "ob_infil_completed" );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_cin_taurus_intro_flythrough", { #timeout:16, #fadestartnone:1, #countdown:0, #players:function_9cdbaea6c78ac37b( squad_struct ) } );
    var_64bb57aa2d6e8b35 coop::play_cinematic( "sat_taurus_load", { #timeout:42, #fadestartnone:1, #countdown:0, #players:function_9cdbaea6c78ac37b( squad_struct ) } );
    activity_instance notify( #"taurus_intro_bink_complete" );
    function_9cdbaea6c78ac37b( squad_struct )[ 0 ] chyron::function_a6d314bf326b0e52( "taurus_intro" );
    level thread function_cddb50034003950e( squad_struct );
    activity_instance thread taurus_intro_safehouse_smoke_vfx( squad_struct );
    activity_instance thread function_ef661edfa2107845( squad_struct );
    activity_instance thread taurus_intro_ground_vehicle( squad_struct );
    activity_instance thread function_1f09b37bfa28845e( squad_struct );
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_503954115911e84", function_9cdbaea6c78ac37b( squad_struct ) );
    activity_instance thread function_16217dcad41bf832( squad_struct );
    activity_instance thread function_52892ca1b01f9412();
    activity_instance thread function_50a0859725993579( squad_struct );
    squad_struct.squad = squad_struct.sessionsquadid;
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, "taurus_intro_obj_marker", "sat_ob_objectivemarker_location", "taurus_intro_obj_done", "taurus_intro_obj_done_player", squad_struct, 0, 0, 0, 1 );
    squad_struct.objective_active = 1;
    trigger = getnoentvolumearray( "taurus_intro_saferoom_trigger", #targetname )[ 0 ];
    
    if ( isdefined( trigger ) )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
        player_arrived = 0;
        
        while ( !player_arrived && var_64bb57aa2d6e8b35.players.size > 0 )
        {
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                trigger waittill( #"trigger", ent );
                
                if ( isplayer( ent ) )
                {
                    foreach ( player in var_64bb57aa2d6e8b35.players )
                    {
                        if ( player == ent )
                        {
                            player_arrived = 1;
                            break;
                        }
                    }
                }
            }
            
            waitframe();
        }
    }
    else
    {
        squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_obj_marker", undefined, 100 );
    }
    
    squad_struct.objective_active = 0;
    activity_instance notify( #"hash_9c2a25028d5b10f6" );
    wait 1;
    level overlord::playevent( "taurus_intro_regroup_supplies_marshall", function_9cdbaea6c78ac37b( squad_struct ) );
    activity_instance thread function_23323337bf1c77fa( squad_struct );
    result = utility::waittill_any_ents_or_timeout_return( 12, activity_instance, "player_has_left_saferoom" );
    activity_instance.var_a8a87c41dc1db24e = 1;
    story_contract_util::mark_complete( function_9cdbaea6c78ac37b( squad_struct ), #"taurus_intro" );
    activity_instance_common::endactivity( activity_instance, 1 );
    activity_participation::function_dd782fbeb3b07e39( activity_instance, function_9cdbaea6c78ac37b( squad_struct ) );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x9d6ffc7f, Offset: 0x172a
// Size: 0x196
function taurus_intro_music( activity_instance )
{
    level endon( #"game_ended" );
    self notify( #"hash_8d8de38ca72546ee" );
    self endon( #"hash_8d8de38ca72546ee" );
    activity_instance endon( #"reset" );
    squad = self;
    assert( snd::issquad( squad ) );
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    
    if ( !arraycontains( [ "taurus_intro", "taurus_destroy_supplies", "taurus_cradle_vents" ], var_950c5eed6692bff6.ddl_bit ) )
    {
        return;
    }
    
    story_contract_util::function_800aae15896dfec6( squad.players, #"taurus_intro" );
    waittillframeend();
    assert( isplayer( squad.players[ 0 ] ) );
    var_950c5eed6692bff6 = story_contract_util::function_35a4b91d1599df3e( squad.players[ 0 ] );
    assert( isstruct( var_950c5eed6692bff6 ) && isstring( var_950c5eed6692bff6.ddl_bit ) );
    utility::flag_wait( "ob_infil_completed" );
    activity_instance waittill( #"taurus_intro_bink_complete" );
    snd_ob::squad_music_with_boost( squad, "mx_avalon_restricted_area_d_lp", 6, 115, 8, 32, 32 );
    activity_instance waittill( #"hash_44d41cc6c4d55bb4" );
    wait 2;
    snd::function_c401f0837df862eb( squad );
    snd_ob::squad_music( squad, "mx_avalon_combat_c_lp" );
    activity_instance waittill( #"hash_9c2a25028d5b10f6" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x8cd581, Offset: 0x18c8
// Size: 0x1c4
function function_23323337bf1c77fa( squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    var_137a224e63fac9f9 = squared( 400 );
    struct = utility::getstruct( "taurus_intro_obj_marker", "targetname" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    player_left = 0;
    var_66565a6231a1994a = [];
    
    while ( !player_left && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) )
            {
                f_dist_squared = distance2dsquared( struct.origin, player.origin );
                
                if ( f_dist_squared < var_137a224e63fac9f9 )
                {
                    height_dif = abs( struct.origin[ 2 ] - player.origin[ 2 ] );
                    
                    if ( height_dif < 90 )
                    {
                        if ( !arraycontains( var_66565a6231a1994a, player ) )
                        {
                            var_66565a6231a1994a[ var_66565a6231a1994a.size ] = player;
                        }
                    }
                    
                    continue;
                }
                
                if ( f_dist_squared > var_137a224e63fac9f9 )
                {
                    if ( arraycontains( var_66565a6231a1994a, player ) )
                    {
                        player_left = 1;
                        break;
                    }
                }
            }
        }
        
        waitframe();
    }
    
    activity_instance notify( #"player_has_left_saferoom" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0xeca34494, Offset: 0x1a94
// Size: 0x4e
function function_4a88b972a328643d()
{
    self waittill( #"hash_1b6b9613636daa6a" );
    
    if ( isdefined( level.taurus_intro_activity.objective_id ) )
    {
        ob_story_mission_utils::mission_objective_marker_hide( level.taurus_intro_activity.objective_id, [ self ] );
    }
    
    thread on_player_connect_squad( {} );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x6914459, Offset: 0x1aea
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_INTRO", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_INTRO", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_INTRO", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_TAURUS_INTRO", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_TAURUS_INTRO" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_TAURUS_INTRO" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x9f9502af, Offset: 0x1b6b
// Size: 0x9d
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.taurus_intro_activity = activity_instance;
    level.taurus_intro_activity.active_squads = [];
    
    if ( !isdefined( level.taurus_intro_ability_case_1 ) )
    {
        thread function_afd9dc1f136e3304();
        taurus_setup_cover();
        level thread function_73f4a7a7bb23c69a();
        story_contract_util::function_e6799e9a19df2365( "s_taurus_caches" );
        story_contract_util::function_e6799e9a19df2365( "s_taurus_boss_caches" );
        level thread taurus_ability_case_setup();
        thread taurus_intro_saferoom_window_blocker();
    }
    
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x4dce14e, Offset: 0x1c10
// Size: 0xaa
function taurus_intro_saferoom_window_blocker()
{
    utility::flag_wait( "scriptables_ready" );
    scriptables = getentitylessscriptablearray( "taurus_intro_saferoom_window_blocker", #script_noteworthy );
    
    foreach ( scriptable in scriptables )
    {
        if ( isdefined( scriptable ) )
        {
            scriptable setscriptablepartstate( "model", "visible" );
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x64814542, Offset: 0x1cc2
// Size: 0x29
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xc579fb7e, Offset: 0x1cf3
// Size: 0x3f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    activity_instance thread respawn_on_destroyed( "REV_OB_TAURUS_INTRO", activity_instance.varianttag );
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0x219b9b36, Offset: 0x1d3a
// Size: 0x85
function respawn_on_destroyed( activity, variant )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ activity_instance.varianttag ];
    activity_instance waittill( #"instance_destroyed" );
    level.taurus_intro_activity.active_squads = [];
    level ob_activity_manager::ob_activity_instance_init( activity_info, undefined );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x67df120f, Offset: 0x1dc7
// Size: 0x27
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance.var_a8a87c41dc1db24e = undefined;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x54c35d83, Offset: 0x1df6
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x4f6ecfc5, Offset: 0x1e0e
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x22ed766b, Offset: 0x1e64
// Size: 0x38
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xf15ba0ce, Offset: 0x1ea4
// Size: 0x7e
function player_left_activity( relevant_info_struct )
{
    activity_instance = self;
    player_list = relevant_info_struct.playerlist;
    
    if ( !activity_instance.playerparticipants.size )
    {
        level.taurus_intro_activity.active_squads = [];
        
        if ( !activity_instance.var_a8a87c41dc1db24e && activity_instance_common::getactivitystate( activity_instance ) == "Active" )
        {
            activity_instance_common::endactivity( activity_instance, 0 );
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xfe653045, Offset: 0x1f2a
// Size: 0x107
function taurus_intro_safehouse_smoke_vfx( squad_struct )
{
    activity_instance = self;
    squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_obj_marker", undefined, 2000 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    
    if ( var_64bb57aa2d6e8b35.players.size == 0 )
    {
        return;
    }
    
    struct = utility::getstruct( "taurus_intro_safehouse_smoke_vfx", "targetname" );
    
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    tag_origin = utility::function_1808878d1c511ce8( struct.origin, struct.angles );
    playfxontag( utility::getfx( "taurus_intro_safehouse_smoke" ), tag_origin, "tag_origin" );
    result = squad_struct utility::waittill_any_return( "players_teleported_to_void_docks", "squad_empty" );
    killfxontag( utility::getfx( "taurus_intro_safehouse_smoke" ), tag_origin, "tag_origin" );
    wait 1;
    utility::array_delete( [ tag_origin ] );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xaff4d73, Offset: 0x2039
// Size: 0x5b
function function_ef661edfa2107845( squad_struct )
{
    activity_instance = self;
    activity_instance.vtoldata = namespace_cf9a4f547edbca10::function_879241d6eca278b();
    activity_instance thread function_4dd4275155c5d3d4( "taurus_intro_regroup_vehicle_air_start", squad_struct );
    activity_instance thread function_4dd4275155c5d3d4( "taurus_intro_regroup_vehicle_air_2_start", squad_struct );
    activity_instance thread function_4dd4275155c5d3d4( "taurus_intro_regroup_vehicle_air_3_start", squad_struct );
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0x8d3b7310, Offset: 0x209c
// Size: 0x2c0
function function_4dd4275155c5d3d4( targetname_str, squad_struct )
{
    activity_instance = self;
    level.var_a197f2776723bff4 = namespace_cf9a4f547edbca10::function_879241d6eca278b();
    vtol_spawn_node = utility::getstruct( targetname_str, "targetname" );
    
    if ( !isdefined( vtol_spawn_node ) )
    {
        return;
    }
    
    vtol_spawn_node vehicle_spawn::set_flag( 10 );
    vtol_unload_node = utility::getstruct( vtol_spawn_node.target, "targetname" );
    vtol_exit_node = utility::getstruct( vtol_unload_node.target, "targetname" );
    var_45c98d2eb68a6e0c = removesubstr( targetname_str, "_start" );
    var_e4199ca140e107b4 = utility::getstruct( var_45c98d2eb68a6e0c + "_delete", "targetname" );
    var_1d847054e3aef4b0 = { #isattacking:0, #var_24954f14e27b448d:1, #spawnnode:vtol_spawn_node };
    var_4dd4275155c5d3d4 = activity_instance [[ level.var_a197f2776723bff4.spawn ]]( var_1d847054e3aef4b0 );
    
    if ( !isdefined( var_4dd4275155c5d3d4 ) )
    {
        return;
    }
    
    var_4dd4275155c5d3d4 endon( #"death" );
    var_4dd4275155c5d3d4 vehicle_allowplayerstandon( 0 );
    var_4dd4275155c5d3d4 thread function_e74bd22f88173f3( activity_instance );
    var_4dd4275155c5d3d4.exitnode = vtol_exit_node;
    tag_origin = utility::function_1808878d1c511ce8( vtol_unload_node.origin, vtol_unload_node.angles );
    var_4dd4275155c5d3d4 thread utility::delete_on_death( tag_origin );
    var_4dd4275155c5d3d4 thread [[ level.var_a197f2776723bff4.switchtarget ]]( tag_origin );
    var_4dd4275155c5d3d4 vehicle_setspeed( 80, 25, 25 );
    var_4dd4275155c5d3d4 move_to_position( var_4dd4275155c5d3d4.exitnode.origin, 1, 50, 1 );
    result = var_4dd4275155c5d3d4 utility::waittill_any_return( "near_goal", "participating_player_attacked_taurus_intro_vtol" );
    
    if ( result == "near_goal" )
    {
        if ( !issubstr( vtol_exit_node.targetname, "land" ) )
        {
            wait 5;
        }
        
        var_4dd4275155c5d3d4 thread [[ level.var_a197f2776723bff4.flyaway ]]();
        return;
    }
    
    if ( isdefined( var_4dd4275155c5d3d4.attacker ) )
    {
        player = var_4dd4275155c5d3d4.attacker;
    }
    else
    {
        player = level.var_a197f2776723bff4.playerparticipants[ 0 ];
    }
    
    var_4dd4275155c5d3d4.vtoltarget = player;
    var_4dd4275155c5d3d4 thread [[ level.var_a197f2776723bff4.switchtarget ]]( player );
    var_4dd4275155c5d3d4.exitnode = var_e4199ca140e107b4;
    var_4dd4275155c5d3d4 thread function_41a1421496eb59eb();
    var_4dd4275155c5d3d4 thread function_35f3dd5468f91472( squad_struct );
    var_4dd4275155c5d3d4 thread function_5cbb75887a45e42c( squad_struct );
    var_4dd4275155c5d3d4 thread function_4cd49bbdefa25f55( squad_struct );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xd5571950, Offset: 0x2364
// Size: 0x19c
function function_e74bd22f88173f3( activity_instance )
{
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance endon( #"participating_player_attacked_taurus_intro_vtol" );
    self endon( #"death" );
    self waittill( #"damage", damage, attacker, direction_vec, point, damagetype, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
    
    if ( isplayer( attacker ) )
    {
        foreach ( player in activity_instance.playerparticipants )
        {
            if ( attacker == player )
            {
                if ( !isdefined( activity_instance.var_7b17be6c04f645e2 ) )
                {
                    activity_instance.var_7b17be6c04f645e2 = 1;
                    self notify( #"participating_player_attacked_taurus_intro_vtol" );
                    activity_instance notify( #"participating_player_attacked_taurus_intro_vtol" );
                    self.attacker = attacker;
                }
            }
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 0, eflags: 0x4
// Checksum 0x85db3a22, Offset: 0x2508
// Size: 0x6f
function private function_41a1421496eb59eb()
{
    self endon( #"death" );
    self endon( #"flyaway" );
    
    while ( true )
    {
        if ( !self.isattacking )
        {
            self [[ level.var_a197f2776723bff4.startattacking ]]();
        }
        
        wait 5;
        
        if ( self.isattacking )
        {
            self [[ level.var_a197f2776723bff4.stopattacking ]]();
        }
        
        wait 3;
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1, eflags: 0x4
// Checksum 0xa8008733, Offset: 0x257f
// Size: 0x36
function private function_35f3dd5468f91472( squad_struct )
{
    self endon( #"death" );
    self endon( #"flyaway" );
    
    while ( true )
    {
        function_cd3756da4e5470f7( squad_struct );
        waitframe();
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1, eflags: 0x4
// Checksum 0xe763910b, Offset: 0x25bd
// Size: 0x102
function private function_cd3756da4e5470f7( squad_struct )
{
    var_f0a13c26c5bbfbf7 = self.vtoltarget;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    
    if ( !var_f0a13c26c5bbfbf7 || !function_65f4adfe6b7a9508( var_f0a13c26c5bbfbf7 ) )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) )
            {
                if ( function_65f4adfe6b7a9508( player ) )
                {
                    self [[ level.var_a197f2776723bff4.switchtarget ]]( player );
                    self.vtoltarget = player;
                    break;
                }
            }
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 2, eflags: 0x4
// Checksum 0x22e647b6, Offset: 0x26c7
// Size: 0x60, Type: bool
function private function_65f4adfe6b7a9508( player, agent = undefined )
{
    if ( isdefined( agent ) )
    {
        if ( distancesquared( player.origin, agent.origin ) > squared( 5000 ) )
        {
            return false;
        }
    }
    
    return !player::isinlaststand( player ) && !player ob_laststand::is_eliminated();
}

// Namespace sat_ob_contract_taurus_intro
// Params 1, eflags: 0xc
// Checksum 0x647990c7, Offset: 0x2730
// Size: 0x11f
function private function_5cbb75887a45e42c( squad_struct )
{
    self notify( #"hash_881e633fd3adfcb6" );
    self endon( #"hash_881e633fd3adfcb6" );
    self endon( #"death" );
    self endon( #"flyaway" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    
    while ( true )
    {
        var_5f5c5a0192d0043e = 0;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) )
            {
                if ( !is_eliminated( player ) )
                {
                    var_5f5c5a0192d0043e = 1;
                    break;
                }
            }
        }
        
        if ( !var_5f5c5a0192d0043e )
        {
            self thread [[ level.var_a197f2776723bff4.flyaway ]]();
            return;
        }
        
        waitframe();
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1, eflags: 0x4
// Checksum 0x99ba8b20, Offset: 0x2857
// Size: 0x14, Type: bool
function private is_eliminated( player )
{
    return player ob_laststand::is_eliminated();
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x863d9cef, Offset: 0x2874
// Size: 0x59
function function_4cd49bbdefa25f55( squad_struct )
{
    self endon( #"death" );
    self endon( #"flyaway" );
    result = squad_struct utility::waittill_any_return( "players_teleported_to_void_docks", "squad_empty" );
    self thread [[ level.var_a197f2776723bff4.flyaway ]]();
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x5e449257, Offset: 0x28d5
// Size: 0x2d9
function taurus_intro_ground_vehicle( squad_struct )
{
    activity_instance = self;
    startnode = getvehiclenode( "taurus_intro_regroup_vehicle_ground_start", "targetname" );
    
    if ( !isdefined( startnode ) )
    {
        return;
    }
    
    cleanup_taurus_intro_ground_vehicle();
    
    if ( isdefined( level.taurus_intro_ground_vehicle ) )
    {
        return;
    }
    
    spawndata = spawnstruct();
    spawndata.origin = startnode.origin;
    spawndata.angles = startnode.angles;
    spawndata.initai = 1;
    spawndata vehicle_spawn::prevent_respawn();
    vehicle = vehicle::spawn( %"hash_3de7997ce7ce8832", spawndata );
    waitframe();
    
    if ( !isent( vehicle ) )
    {
        return;
    }
    
    vehicle endon( #"entitydeleted" );
    level.taurus_intro_ground_vehicle = vehicle;
    vehicle_occupancy::set_team( vehicle, "team_hundred_ninety" );
    vehicle_interact::allow_use( vehicle, 0 );
    vehicle vehicle_paths::function_53e592e2d38c05ca();
    endnode = getvehiclenode( "taurus_intro_regroup_vehicle_ground_end", "targetname" );
    
    if ( isdefined( endnode ) )
    {
        vehicle function_eb88c4e66edbc855( "p2p", "goalPoint", endnode.origin );
    }
    
    squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_house_center_struct", "taurus_intro_vehicle_moving", 12600 );
    vehicle vehicle_paths::vehicle_init_path_radiant();
    vehicle thread vehicle::attach_vehicle_and_gopath( startnode );
    vehicle vehicle_turnengineon();
    activity_instance.ground_vehicle_ai = [];
    
    if ( !isdefined( level.default_goalradius ) )
    {
        level.default_goalradius = 2048;
    }
    
    activity_instance.var_b8f975e6571ac391 = ai_spawn_director::spawn_request( "ai_encounter:sat_ob_taurus_intro_rider_enc", vehicle.origin, 128, 1, 1, 0 );
    ai_spawn_director::add_spawned_callback( activity_instance.var_b8f975e6571ac391, &function_de7564060c1d1036, activity_instance );
    function_64ac8c4e752f4dca( activity_instance.var_b8f975e6571ac391, 0 );
    function_c505198907e0d306( activity_instance.var_b8f975e6571ac391, vehicle );
    vehicle endon( #"death" );
    vehicle utility::waittill_any_timeout( 30, "goal", "near_goal", "path_blocked" );
    
    if ( vehicle hascomponent( "p2p" ) )
    {
        vehicle removecomponent( "p2p" );
    }
    
    if ( vehicle hascomponent( "path" ) )
    {
        vehicle removecomponent( "path" );
    }
    
    if ( vehicle hascomponent( "animator" ) )
    {
        vehicle removecomponent( "animator" );
    }
    
    result = utility::waittill_any_ents_return( vehicle, "unloaded", squad_struct, "players_teleported_to_void_docks", squad_struct, "squad_empty" );
    
    if ( result == "unloaded" )
    {
        vehicle vehicleclearanims();
        vehicle_occupancy::set_team( vehicle, "neutral" );
        vehicle_interact::allow_use( vehicle, 1 );
        result = squad_struct utility::waittill_any_return( "players_teleported_to_void_docks", "squad_empty" );
    }
    
    cleanup_taurus_intro_ground_vehicle();
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x26b16569, Offset: 0x2bb6
// Size: 0xf2
function cleanup_taurus_intro_ground_vehicle()
{
    if ( isdefined( level.taurus_intro_ground_vehicle ) )
    {
        var_1ef51be87699e67e = 0;
        min_distance_squared = squared( 500 );
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                dist = distancesquared( player.origin, level.taurus_intro_ground_vehicle.origin );
                
                if ( dist < min_distance_squared )
                {
                    var_1ef51be87699e67e = 1;
                    break;
                }
            }
        }
        
        if ( var_1ef51be87699e67e )
        {
            return;
        }
        
        level.taurus_intro_ground_vehicle delete();
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 4
// Checksum 0x92042521, Offset: 0x2cb0
// Size: 0x1a3
function function_de7564060c1d1036( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = userdata;
    
    if ( activity_instance.ground_vehicle_ai.size == 0 )
    {
        agent.combat_goal_struct = utility::getstruct( "taurus_intro_regroup_goal_03", "targetname" );
        agent.goal_struct = utility::getstruct( "taurus_intro_vehicle_rider_path_1", "targetname" );
        agent.script_noteworthy = "taurus_intro_regroup_ground_vehicle_rider_1";
    }
    else
    {
        agent.combat_goal_struct = utility::getstruct( "taurus_intro_regroup_goal_04", "targetname" );
        agent.goal_struct = utility::getstruct( "taurus_intro_vehicle_rider_path_2", "targetname" );
        agent.script_noteworthy = "taurus_intro_regroup_ground_vehicle_rider_2";
    }
    
    activity_instance.ground_vehicle_ai[ activity_instance.ground_vehicle_ai.size ] = agent;
    agent thread function_dc4edacc0a2bdd85( activity_instance );
    agent waittill( #"unloaded" );
    wait 2;
    
    if ( !isdefined( agent.var_7a4b72fab99e9f7f ) )
    {
        agent.goalradius = 32;
        agent thread ai_utility::go_to_node( agent.goal_struct );
        agent waittill( #"stealth_combat" );
        agent notify( #"stop_going_to_node" );
        agent clearpath();
    }
    
    agent setgoalpos( agent.combat_goal_struct.origin, agent.combat_goal_struct.radius );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xc3ce7f09, Offset: 0x2e5b
// Size: 0x101
function function_1f09b37bfa28845e( squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    squad_struct endon( #"squad_empty" );
    level endon( #"game_ended" );
    wait 1;
    level overlord::playevent( "taurus_intro_briefing_marshall", function_9cdbaea6c78ac37b( squad_struct ) );
    wait 5;
    thread function_7c7ffc0b5760622( squad_struct );
    activity_instance thread taurus_intro_nags( squad_struct );
    squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_obj_marker", undefined, 2000 );
    activity_instance notify( #"hash_44d41cc6c4d55bb4" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    taurus_intro_respawn_structs = utility::getstructarray( "taurus_intro_respawn_structs", "targetname" );
    var_64bb57aa2d6e8b35 thread story_contract_util::set_squad_respawn( taurus_intro_respawn_structs, 0.15 );
    level overlord::playconversation( "taurus_intro_safehouse_located", function_9cdbaea6c78ac37b( squad_struct ), undefined, 1 );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x57fea4b, Offset: 0x2f64
// Size: 0x2d
function function_7c7ffc0b5760622( squad_struct )
{
    level overlord::playconversation( "taurus_intro_start_karma", function_9cdbaea6c78ac37b( squad_struct ) );
    self notify( #"hash_c78deaae63f48c5e" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x22b37476, Offset: 0x2f99
// Size: 0x4c
function taurus_intro_nags( squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"hash_44d41cc6c4d55bb4" );
    activity_instance waittill( #"hash_c78deaae63f48c5e" );
    wait 60;
    level overlord::playevent( "taurus_intro_supply_drop_nag_1_marshall", function_9cdbaea6c78ac37b( squad_struct ) );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0, eflags: 0x4
// Checksum 0xdef6dd41, Offset: 0x2fed
// Size: 0x4af
function private taurus_ability_case_setup()
{
    ability_case_structs = utility::getstructarray( "taurus_ability_case", "targetname" );
    level.taurus_ability_cases = [];
    
    foreach ( ability_case_struct in ability_case_structs )
    {
        if ( isdefined( ability_case_struct ) && isdefined( ability_case_struct.script_noteworthy ) )
        {
            switch ( ability_case_struct.script_noteworthy )
            {
                case #"hash_2c9d82b3cfcbe8f6":
                    level.taurus_intro_ability_case_1 = ob_item_select::function_95f9ecc2af4693f6( ability_case_struct.origin, "super_shadow_break", "super_war_machine", #"default", ability_case_struct.angles );
                    
                    if ( !arraycontains( level.taurus_ability_cases, level.taurus_intro_ability_case_1 ) )
                    {
                        level.taurus_ability_cases[ level.taurus_ability_cases.size ] = level.taurus_intro_ability_case_1;
                    }
                    
                    break;
                case #"hash_2c9d81b3cfcbe763":
                    level.taurus_intro_ability_case_2 = ob_item_select::function_95f9ecc2af4693f6( ability_case_struct.origin, "super_grappling_hook_sm", "super_mega_jump", #"tactical", ability_case_struct.angles );
                    
                    if ( !arraycontains( level.taurus_ability_cases, level.taurus_intro_ability_case_2 ) )
                    {
                        level.taurus_ability_cases[ level.taurus_ability_cases.size ] = level.taurus_intro_ability_case_2;
                    }
                    
                    break;
                case #"hash_8d22f5f3a672da30":
                    level.taurus_destroy_supplies_ability_case_1 = ob_item_select::function_95f9ecc2af4693f6( ability_case_struct.origin, "super_vision_pulse", "super_active_camo", #"default", ability_case_struct.angles );
                    
                    if ( !arraycontains( level.taurus_ability_cases, level.taurus_destroy_supplies_ability_case_1 ) )
                    {
                        level.taurus_ability_cases[ level.taurus_ability_cases.size ] = level.taurus_destroy_supplies_ability_case_1;
                    }
                    
                    break;
                case #"hash_8d22f8f3a672dee9":
                    level.taurus_destroy_supplies_ability_case_2 = ob_item_select::function_95f9ecc2af4693f6( ability_case_struct.origin, "super_portal_summon", "super_black_hat", #"tactical", ability_case_struct.angles );
                    
                    if ( !arraycontains( level.taurus_ability_cases, level.taurus_destroy_supplies_ability_case_2 ) )
                    {
                        level.taurus_ability_cases[ level.taurus_ability_cases.size ] = level.taurus_destroy_supplies_ability_case_2;
                    }
                    
                    break;
                case #"hash_7a13b672c5d99486":
                    level.taurus_cradle_vents_ability_case_1_loc01 = ob_item_select::function_95f9ecc2af4693f6( ability_case_struct.origin, "super_bubble_shield", "super_survival_life_drain", #"default", ability_case_struct.angles );
                    
                    if ( !arraycontains( level.taurus_ability_cases, level.taurus_cradle_vents_ability_case_1_loc01 ) )
                    {
                        level.taurus_ability_cases[ level.taurus_ability_cases.size ] = level.taurus_cradle_vents_ability_case_1_loc01;
                    }
                    
                    break;
                case #"hash_3407f1a5c6c56e13":
                    level.taurus_cradle_vents_ability_case_2_loc01 = ob_item_select::function_95f9ecc2af4693f6( ability_case_struct.origin, "super_grappling_hook_sm", "super_mega_jump", #"tactical", ability_case_struct.angles );
                    
                    if ( !arraycontains( level.taurus_ability_cases, level.taurus_cradle_vents_ability_case_2_loc01 ) )
                    {
                        level.taurus_ability_cases[ level.taurus_ability_cases.size ] = level.taurus_cradle_vents_ability_case_2_loc01;
                    }
                    
                    break;
                default:
                    break;
            }
        }
    }
    
    void_case_struct = utility::getstruct( "void_ability_case", "targetname" );
    
    if ( isdefined( void_case_struct ) )
    {
        level.var_2002c70f2215ca2f = ob_item_select::function_95f9ecc2af4693f6( void_case_struct.origin, "super_shadow_break", "super_survival_life_drain", #"default" );
        
        if ( isdefined( level.var_2002c70f2215ca2f ) )
        {
            level.taurus_ability_cases[ level.taurus_ability_cases.size ] = level.var_2002c70f2215ca2f;
        }
    }
    
    foreach ( ability_case in level.taurus_ability_cases )
    {
        ob_item_select::function_1dfd8b3bc8e33dd8( ability_case );
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 0, eflags: 0x4
// Checksum 0x15e605, Offset: 0x34a4
// Size: 0x29
function private taurus_setup_cover()
{
    if ( !isdefined( var_7f82eb5ea8811a76 ) )
    {
        var_7f82eb5ea8811a76 = [];
    }
    
    var_7f82eb5ea8811a76 = ob_soldier_util::function_a315cc5d1dee425a( "e_cover_taurus" );
    waitframe();
    function_4338c932bba76740();
}

// Namespace sat_ob_contract_taurus_intro
// Params 0, eflags: 0x4
// Checksum 0x75d18e0d, Offset: 0x34d5
// Size: 0xe
function private function_4338c932bba76740()
{
    ob_activity_utility::ob_enable_cover_nodes( "e_covernode_taurus" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x812569af, Offset: 0x34eb
// Size: 0x16e
function function_16217dcad41bf832( squad_struct )
{
    squad_struct endon( #"squad_empty" );
    level endon( #"game_ended" );
    activity_instance = self;
    encounter_targetname = "enc_taurus_intro_regroup_vol";
    self.regroup_encounterid = activity_ai_encounters::function_92b671064b0b1ce2( encounter_targetname, 1, 0, 1, 2 );
    ai_spawn_director::add_spawned_callback( self.regroup_encounterid, &function_48e976321b761e73, self );
    taurus_intro_house_center_struct = utility::getstruct( "taurus_intro_house_center_struct", "targetname" );
    squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_house_center_struct", undefined, 2200 );
    activity_instance thread function_9f540d83cbd748dc( squad_struct );
    activity_instance waittill( #"hash_d1253585f75ec92" );
    result = utility::waittill_any_ents_or_timeout_return( 5, activity_instance, "taurus_intro_stealth_broke_enemy_vo" );
    wait 1;
    
    if ( isdefined( activity_instance.taurus_intro_attacker ) )
    {
        player = activity_instance.taurus_intro_attacker;
    }
    else
    {
        player = activity_instance.playerparticipants[ 0 ];
    }
    
    if ( isdefined( player ) )
    {
        closest_enemy = player getclosestenemy( 1500, 120, 1 );
    }
    
    if ( !isdefined( closest_enemy ) )
    {
        activity_instance.var_f4d56b10378f679e utility::array_removedead_or_dying( activity_instance.var_f4d56b10378f679e );
        closest_enemy = utility::array_random( activity_instance.var_f4d56b10378f679e );
    }
    
    if ( isdefined( closest_enemy ) )
    {
        closest_enemy dialogue::say( "dx_wc_wtau_tmis_guia_needsomereinforcemen" );
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x296306c4, Offset: 0x3661
// Size: 0x310
function function_9f540d83cbd748dc( squad_struct )
{
    squad_struct endon( #"squad_empty" );
    level endon( #"game_ended" );
    activity_instance = self;
    
    if ( !isdefined( activity_instance.var_fa962ba5d3830b04 ) )
    {
        activity_instance.var_fa962ba5d3830b04 = [];
    }
    
    activity_instance.var_f4d56b10378f679e = arraycombine( activity_instance.taurus_intro_regroup_ai, activity_instance.ground_vehicle_ai );
    activity_instance.var_f4d56b10378f679e utility::array_removedead_or_dying( activity_instance.var_f4d56b10378f679e );
    activity_instance thread cleanup_taurus_intro_ai_encounters( squad_struct );
    
    foreach ( ai in activity_instance.var_f4d56b10378f679e )
    {
        if ( isdefined( ai.script_noteworthy ) )
        {
            if ( ai.script_noteworthy == "taurus_intro_regroup_regular" || ai.script_noteworthy == "taurus_intro_regroup_special" || ai.script_noteworthy == "taurus_intro_regroup_ground_vehicle_rider_1" || ai.script_noteworthy == "taurus_intro_regroup_ground_vehicle_rider_2" )
            {
                activity_instance.var_fa962ba5d3830b04[ activity_instance.var_fa962ba5d3830b04.size ] = ai;
            }
        }
    }
    
    while ( activity_instance.var_fa962ba5d3830b04.size > 3 && !isdefined( activity_instance.var_f40e8825d58a8363 ) )
    {
        activity_instance.var_fa962ba5d3830b04 = utility::array_removedead_or_dying( activity_instance.var_fa962ba5d3830b04 );
        waitframe();
    }
    
    if ( isdefined( activity_instance.var_f40e8825d58a8363 ) )
    {
        activity_instance.taurus_intro_regroup_interior = utility::array_removedead_or_dying( activity_instance.taurus_intro_regroup_interior );
        activity_instance.var_fa962ba5d3830b04 = arraycombine( activity_instance.taurus_intro_regroup_interior, activity_instance.var_fa962ba5d3830b04 );
        
        while ( activity_instance.var_fa962ba5d3830b04.size > 3 )
        {
            activity_instance.var_fa962ba5d3830b04 = utility::array_removedead_or_dying( activity_instance.var_fa962ba5d3830b04 );
            waitframe();
        }
    }
    
    activity_instance notify( #"hash_b80f7784705b2d2d" );
    activity_instance.var_c5c33a07de230c92 = 1;
    taurus_intro_regroup_interior_first_floor_goal = utility::getstruct( "taurus_intro_regroup_interior_first_floor_goal", "targetname" );
    
    foreach ( ai in activity_instance.var_fa962ba5d3830b04 )
    {
        if ( isdefined( ai ) )
        {
            ai setgoalpos( taurus_intro_regroup_interior_first_floor_goal.origin, taurus_intro_regroup_interior_first_floor_goal.radius );
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x31f0e464, Offset: 0x3979
// Size: 0x7f
function cleanup_taurus_intro_ai_encounters( squad_struct )
{
    activity_instance = self;
    level endon( #"game_ended" );
    result = squad_struct utility::waittill_any_return( "players_teleported_to_void_docks", "squad_empty" );
    
    if ( isdefined( self.regroup_encounterid ) )
    {
        ai_spawn_director::cancel_spawn_request( self.regroup_encounterid, 1 );
    }
    
    if ( isdefined( self.var_b8f975e6571ac391 ) )
    {
        ai_spawn_director::cancel_spawn_request( self.var_b8f975e6571ac391, 1 );
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 4
// Checksum 0xc6d6462a, Offset: 0x3a00
// Size: 0x263
function function_48e976321b761e73( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activity_instance = userdata;
    agent.activity_instance = activity_instance;
    
    if ( !isdefined( activity_instance.taurus_intro_regroup_ai ) )
    {
        activity_instance.taurus_intro_regroup_ai = [];
    }
    
    activity_instance.taurus_intro_regroup_ai[ activity_instance.taurus_intro_regroup_ai.size ] = agent;
    agent thread function_dc4edacc0a2bdd85( activity_instance );
    
    if ( !isdefined( activity_instance.taurus_intro_regroup_mob ) )
    {
        activity_instance.taurus_intro_regroup_mob = [];
    }
    
    if ( !isdefined( activity_instance.taurus_intro_regroup_interior ) )
    {
        activity_instance.taurus_intro_regroup_interior = [];
    }
    
    if ( isdefined( data.script_noteworthy ) )
    {
        switch ( data.script_noteworthy )
        {
            case #"hash_e87b9970b646a8ce":
                activity_instance.juggernaut = agent;
                activity_instance.taurus_intro_regroup_interior[ activity_instance.taurus_intro_regroup_interior.size ] = agent;
                agent thread taurus_intro_regroup_interior( activity_instance, data );
                break;
            case #"hash_175919968831aa87":
                activity_instance.taurus_intro_regroup_interior[ activity_instance.taurus_intro_regroup_interior.size ] = agent;
                agent thread taurus_intro_regroup_interior( activity_instance, data );
                break;
            case #"hash_95379043343c4cc0":
                activity_instance.taurus_intro_regroup_mob[ activity_instance.taurus_intro_regroup_mob.size ] = agent;
                break;
            case #"hash_825051e341a2b80f":
                activity_instance.taurus_intro_regroup_mob[ activity_instance.taurus_intro_regroup_mob.size ] = agent;
                break;
            case #"hash_251ed1e89cbad317":
                activity_instance.sniper = agent;
                agent thread taurus_intro_regroup_sniper( activity_instance, data );
                break;
            case #"hash_d6c1ca4de0becd36":
                activity_instance.regular_upstairs_runner = agent;
                agent thread function_6ab1ad462a577acd( activity_instance, data );
                break;
            case #"hash_32725ba3a93e69fc":
                activity_instance.special_upstairs_postup = agent;
                agent thread function_6ab1ad462a577acd( activity_instance, data );
                break;
            case #"hash_6c56f22ab1b3a538":
                activity_instance.saferoom_guard = agent;
                agent thread taurus_intro_regroup_saferoom_guard( activity_instance, data );
                break;
            default:
                break;
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xeddf97b1, Offset: 0x3c6b
// Size: 0xc1
function function_dc4edacc0a2bdd85( activity_instance )
{
    self endon( #"death" );
    self waittill( #"stealth_combat", attacker );
    
    if ( !isdefined( activity_instance.var_2d64245bfcba354b ) )
    {
        activity_instance.var_2d64245bfcba354b = self;
    }
    
    if ( isplayer( attacker ) && !isdefined( activity_instance.taurus_intro_attacker ) )
    {
        activity_instance.taurus_intro_attacker = attacker;
    }
    
    activity_instance notify( #"hash_d1253585f75ec92" );
    self setstealthstate( "combat" );
    self.var_7a4b72fab99e9f7f = 1;
    
    if ( !activity_instance.taurus_intro_stealth_broke_enemy_vo )
    {
        activity_instance.taurus_intro_stealth_broke_enemy_vo = 1;
        activity_instance notify( #"taurus_intro_stealth_broke_enemy_vo" );
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0xaf0b30f5, Offset: 0x3d34
// Size: 0x329
function taurus_intro_regroup_interior( activity_instance, data )
{
    agent = self;
    agent endon( #"death" );
    agent val::set( "taurus_intro_regroup_interior", "ignoreall", 1 );
    goal = utility::getstruct( data.var_d229a71fb9fbe4d1, "targetname" );
    agent.fixednode = 1;
    agent setgoalpos( goal.origin, 32 );
    
    if ( isdefined( activity_instance ) )
    {
        squad_struct = level.taurus_intro_activity.active_squads[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
        
        if ( isdefined( squad_struct ) )
        {
            agent thread function_88feaca9ce5866d( squad_struct, "taurus_intro_house_center_struct", "taurus_intro_regroup_players_near_house", 1200 );
        }
    }
    
    result = agent utility::waittill_any( "damage", "taurus_intro_regroup_players_near_house" );
    
    foreach ( ai in agent.activity_instance.taurus_intro_regroup_interior )
    {
        ai notify( #"taurus_intro_regroup_players_near_house" );
    }
    
    agent val::set( "taurus_intro_regroup_interior", "ignoreall", 0 );
    agent setstealthstate( "combat" );
    
    if ( issubstr( agent.script_noteworthy, "mob" ) )
    {
        if ( isdefined( agent.activity_instance.juggernaut ) )
        {
            result = agent.activity_instance utility::waittill_any_timeout( 5, "juggernaut_mob_assemble" );
            agent.fixednode = 0;
            agent.goalradius = 250;
            agent setgoalentity( agent.activity_instance.juggernaut );
            agent.activity_instance.juggernaut waittill( #"death" );
            agent.activity_instance notify( #"hash_f7a35fea721dbb8c" );
            agent.activity_instance.var_f40e8825d58a8363 = 1;
            agent cleargoalentity();
        }
    }
    else
    {
        exit_goal = utility::getstruct( data.script_noteworthy, "targetname" );
        
        if ( isdefined( exit_goal ) )
        {
            agent.fixednode = 1;
            agent setgoalpos( exit_goal.origin, 32 );
            result = utility::waittill_any_timeout( 5, "goal", "reached_path_end" );
            agent.fixednode = 0;
            agent.activity_instance notify( #"juggernaut_mob_assemble" );
        }
    }
    
    exit_goal = utility::getstruct( "taurus_intro_regroup_goal", "targetname" );
    agent setgoalpos( exit_goal.origin, exit_goal.radius );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0, eflags: 0x4
// Checksum 0x6039ee0a, Offset: 0x4065
// Size: 0x3f
function private taurus_intro_regroup_interior_damage()
{
    agent = self;
    agent endon( #"death" );
    agent waittill( #"damage" );
    agent val::set( "taurus_intro_regroup_interior", "ignoreall", 1 );
}

// Namespace sat_ob_contract_taurus_intro
// Params 4, eflags: 0x4
// Checksum 0xca96af83, Offset: 0x40ac
// Size: 0x1e0
function private function_88feaca9ce5866d( squad_struct, var_e1ae3a7d876c13ca, mission_notify, min_dist )
{
    if ( isent( self ) )
    {
        self endon( #"death" );
    }
    
    squad_struct endon( #"squad_empty" );
    level endon( #"game_ended" );
    struct = utility::getstruct( var_e1ae3a7d876c13ca, "targetname" );
    
    if ( !struct || !struct.radius )
    {
        assertmsg( "<dev string:x24>" + var_e1ae3a7d876c13ca );
        return;
    }
    
    if ( !isdefined( min_dist ) )
    {
        min_dist = struct.radius;
    }
    
    min_dist_squared = squared( min_dist );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    player_arrived = 0;
    
    while ( !player_arrived && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) )
            {
                f_dist_squared = distance2dsquared( struct.origin, player.origin );
                
                if ( f_dist_squared < min_dist_squared )
                {
                    player_arrived = 1;
                    closest_playerparticipant = player;
                    break;
                }
            }
        }
        
        waitframe();
    }
    
    if ( isent( self ) )
    {
        self.favoriteenemy = closest_playerparticipant;
        
        if ( isdefined( mission_notify ) )
        {
            self notify( mission_notify );
        }
    }
    
    if ( isdefined( mission_notify ) )
    {
        squad_struct notify( mission_notify );
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0x41f2210c, Offset: 0x4294
// Size: 0x21e
function taurus_intro_regroup_sniper( activity_instance, data )
{
    agent = self;
    agent endon( #"death" );
    squad_struct = level.taurus_intro_activity.active_squads[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_regroup_sniper_goal", undefined, 600 );
    
    if ( !isdefined( min_dist ) )
    {
        min_dist = 600;
    }
    
    min_dist_squared = squared( min_dist );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    player_arrived = 0;
    
    while ( !player_arrived && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( isdefined( player ) )
            {
                f_dist_squared = distance2dsquared( self.origin, player.origin );
                
                if ( f_dist_squared < min_dist_squared )
                {
                    height_dif = abs( self.origin[ 2 ] - player.origin[ 2 ] );
                    
                    if ( height_dif < 90 )
                    {
                        player_arrived = 1;
                        closest_playerparticipant = player;
                        break;
                    }
                }
            }
        }
        
        waitframe();
    }
    
    upstairs_goal = utility::getstruct( "taurus_intro_regroup_interior_upstairs_goal", "targetname" );
    agent setgoalpos( upstairs_goal.origin, upstairs_goal.radius );
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0x405468be, Offset: 0x44ba
// Size: 0x348
function function_6ab1ad462a577acd( activity_instance, data )
{
    agent = self;
    agent endon( #"death" );
    squad_struct = level.taurus_intro_activity.active_squads[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    distance_structs = utility::getstructarray( "taurus_intro_house_interior_struct", "targetname" );
    center_struct = utility::getstruct( "taurus_intro_house_center_struct", "targetname" );
    distance_structs[ distance_structs.size ] = center_struct;
    goal = utility::getstruct( data.var_d229a71fb9fbe4d1, "targetname" );
    agent.fixednode = 1;
    agent setgoalpos( goal.origin, 32 );
    player_arrived = 0;
    
    while ( !player_arrived && var_64bb57aa2d6e8b35.players.size > 0 )
    {
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            foreach ( struct in distance_structs )
            {
                min_dist = squared( struct.radius );
                
                if ( isdefined( player ) )
                {
                    dist = distancesquared( struct.origin, player.origin );
                    
                    if ( dist < min_dist )
                    {
                        player_arrived = 1;
                        triggered_struct = struct;
                        closest_playerparticipant = player;
                        break;
                    }
                }
            }
        }
        
        waitframe();
    }
    
    if ( agent.script_noteworthy == "taurus_intro_regroup_interior_regular_upstairs_runner" )
    {
        agent.fixednode = 0;
        
        if ( isdefined( triggered_struct ) )
        {
            if ( triggered_struct != center_struct )
            {
                first_floor_struct = utility::getstruct( "taurus_intro_house_interior_first_floor_goal", "targetname" );
                agent setgoalpos( first_floor_struct.origin, first_floor_struct.radius );
                result = utility::waittill_any_timeout( 5, "goal", "reached_path_end" );
            }
        }
    }
    else
    {
        squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_house_center_struct", undefined, 250 );
        agent.fixednode = 0;
    }
    
    exit_goal = utility::getstruct( "taurus_intro_regroup_goal", "targetname" );
    agent setgoalpos( exit_goal.origin, exit_goal.radius );
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0x15003418, Offset: 0x480a
// Size: 0x11a
function taurus_intro_regroup_saferoom_guard( activity_instance, data )
{
    agent = self;
    agent endon( #"death" );
    agent val::set( "taurus_intro_regroup_saferoom_guard", "ignoreall", 1 );
    goal = utility::getstruct( data.var_d229a71fb9fbe4d1, "targetname" );
    agent.fixednode = 1;
    agent setgoalpos( goal.origin, 32 );
    
    if ( isdefined( activity_instance ) )
    {
        squad_struct = level.taurus_intro_activity.active_squads[ activity_instance.playerparticipants[ 0 ].sessionsquadid ];
        
        if ( isdefined( squad_struct ) )
        {
            agent thread function_88feaca9ce5866d( squad_struct, "taurus_intro_house_center_struct", "taurus_intro_regroup_players_near_saferoom_guard", 300 );
        }
    }
    
    result = agent utility::waittill_any( "damage", "taurus_intro_regroup_players_near_saferoom_guard" );
    agent val::set( "taurus_intro_regroup_saferoom_guard", "ignoreall", 0 );
    agent setstealthstate( "combat" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0xf7f1aabe, Offset: 0x492c
// Size: 0xd0
function function_afd9dc1f136e3304()
{
    exclusion_zones = self.var_8339fb4f2d23dabf.zones[ "Exclusion_Zone" ].spheres;
    objective_name = self.varianttag;
    
    foreach ( Exclusion_Zone in exclusion_zones )
    {
        if ( isdefined( Exclusion_Zone ) )
        {
            function_1c4c7ef874191be2( objective_name, Exclusion_Zone.origin, Exclusion_Zone.radius, 1 );
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x58e9c43d, Offset: 0x4a04
// Size: 0x28
function function_8aa672a8312c4734( squad_struct )
{
    return teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xce79bdd2, Offset: 0x4a35
// Size: 0x5c
function function_9cdbaea6c78ac37b( squad_struct )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    
    if ( !var_64bb57aa2d6e8b35.players.size )
    {
        squad_struct notify( #"squad_empty" );
    }
    
    return var_64bb57aa2d6e8b35.players;
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0x37556ccf, Offset: 0x4a9a
// Size: 0x73
function function_73f4a7a7bb23c69a()
{
    suprise_shipments = [ "SURPRISE_SHIPMENT_OVERLOOK", "SURPRISE_SHIPMENT_CITY" ];
    function_9c2eaf26fa80672a( "REV_OB_SURPRISE_SHIPMENT", suprise_shipments );
    safes = [ "STADIUM_EAST_SAFECRACK" ];
    function_9c2eaf26fa80672a( "REV_OB_SAFECRACK", safes );
    supply_drops = [ "SUPPLY_DROP_Q1_POLICE_STATION" ];
    function_9c2eaf26fa80672a( "REV_OB_SUPPLY_DROP", supply_drops );
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0xfb442fff, Offset: 0x4b15
// Size: 0xa4
function function_9c2eaf26fa80672a( activity_type, activities )
{
    foreach ( activity_variant in activities )
    {
        if ( isdefined( level.activities.definitions[ activity_variant ] ) )
        {
            activity_instance_common::createactivityinstance( activity_type, activity_variant, undefined, undefined );
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 0
// Checksum 0xcf0769f, Offset: 0x4bc1
// Size: 0x16b
function function_52892ca1b01f9412()
{
    if ( !isdefined( level.scripted_vehicle_spawns ) )
    {
        level.scripted_vehicle_spawns = [];
    }
    
    if ( !isdefined( level.scripted_vehicles ) )
    {
        level.scripted_vehicles = [];
    }
    
    activity_instance = undefined;
    taurus_intros = activity_participation::function_e8eabd79cc49540e( self, [ "REV_OB_TAURUS_INTRO" ] );
    
    if ( taurus_intros.size > 0 )
    {
        activity_instance = activity_common::getactivityinstance( taurus_intros[ 0 ].instanceid );
    }
    else
    {
        return;
    }
    
    vehicle_spawns = utility::getstructarray( "taurus_intro_scripted_vehicle", "targetname" );
    
    foreach ( vehicle_spawn in vehicle_spawns )
    {
        if ( !arraycontains( level.scripted_vehicle_spawns, vehicle_spawn ) )
        {
            level.scripted_vehicle_spawns = arraycombineunique( level.scripted_vehicle_spawns, [ vehicle_spawn ] );
        }
        
        if ( function_17003ef10fd73048( vehicle_spawn ) )
        {
            spawned_vehicle = activity_instance function_64ab52bf12c6a75b( vehicle_spawn );
            spawned_vehicle.scripted_spawn_struct = vehicle_spawn;
            level.scripted_vehicles[ level.scripted_vehicles.size ] = spawned_vehicle;
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1, eflags: 0x4
// Checksum 0x939062f1, Offset: 0x4d34
// Size: 0xc4, Type: bool
function private function_17003ef10fd73048( spawn_struct )
{
    foreach ( vehicle in level.var_adfa16996091fb19 )
    {
        if ( vehicle.scripted_spawn_struct && vehicle.scripted_spawn_struct == spawn_struct && distancesquared( vehicle.origin, spawn_struct.origin ) < 16000000 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace sat_ob_contract_taurus_intro
// Params 1, eflags: 0x4
// Checksum 0xb3cd6eb1, Offset: 0x4e01
// Size: 0xb9
function private function_64ab52bf12c6a75b( spawn_struct )
{
    spawn_data = { #triggerrecycle:1, #var_499a16b493ff31ed:1, #initai:0, #team:"neutral", #angles:spawn_struct.angles, #origin:spawn_struct.origin };
    spawn_data vehicle_spawn::prevent_respawn();
    spawn_fail = {};
    vehicle = ob_resource_manager::activity_spawn_vehicle( "veh_sat_medium_truck_ob", spawn_data, spawn_fail );
    vehicle.playedcaralarm = 1;
    vehicle.var_a5f34fcc4fb8b328 = 1;
    return vehicle;
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0xe116ed89, Offset: 0x4ec3
// Size: 0xf6
function function_50a0859725993579( squad_struct )
{
    activity_instance = self;
    squad_struct endon( #"squad_empty" );
    level endon( #"game_ended" );
    taurus_intro_obj_marker = utility::getstruct( "taurus_intro_obj_marker", "targetname" );
    squad_struct function_88feaca9ce5866d( squad_struct, "taurus_intro_obj_marker", undefined, 400 );
    ob_story_mission_utils::item_spawn_weapon( "s_taurus_intro_weapon", undefined, 1, undefined, undefined, 0, undefined, 1 );
    activity_instance thread function_61fe16cebdfc3488( squad_struct, taurus_intro_obj_marker );
    
    foreach ( playerparticipant in function_9cdbaea6c78ac37b( squad_struct ) )
    {
        playerparticipant thread function_c3b703de2bdb18c3( squad_struct );
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 2
// Checksum 0xfa647351, Offset: 0x4fc1
// Size: 0xdc
function function_61fe16cebdfc3488( squad_struct, struct )
{
    result = squad_struct utility::waittill_any_return( "players_teleported_to_void_docks", "squad_empty" );
    var_f0110ccab3f4a8a6 = getentitylessscriptablearray( %"obloot_custom_weapon" );
    
    foreach ( item in var_f0110ccab3f4a8a6 )
    {
        if ( isdefined( item ) )
        {
            item.cleanupdisabled = 0;
            item.var_fd47e835523b473f = 0;
            item thread common_item::items_scriptable_waitandcleanup( 1 );
        }
    }
}

// Namespace sat_ob_contract_taurus_intro
// Params 1
// Checksum 0x8c8e1ca9, Offset: 0x50a5
// Size: 0x31
function function_c3b703de2bdb18c3( squad_struct )
{
    self endon( #"disconnect" );
    utility::ent_flag_wait( "player_teleported_to_void_docks" );
    squad_struct notify( #"players_teleported_to_void_docks" );
}

// Namespace sat_ob_contract_taurus_intro
// Params 5, eflags: 0x4
// Checksum 0xc8d9f6c, Offset: 0x50de
// Size: 0xee
function private move_to_position( goalpos = self.origin, stopatgoal = 1, var_5197ba25f206c925 = 50, var_8c4b378b85ff60f6 = 1, goalyaw = undefined )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self setneargoalnotifydist( var_5197ba25f206c925 );
    desiredheight = goalpos[ 2 ];
    
    if ( var_8c4b378b85ff60f6 )
    {
        desiredheight = get_desired_height( goalpos[ 0 ], goalpos[ 1 ], 50 );
    }
    
    finalgoalpos = ( goalpos[ 0 ], goalpos[ 1 ], desiredheight );
    
    if ( !goalyaw )
    {
        goalyaw = vectortoyaw( finalgoalpos - self.origin );
    }
    
    self vehicle_helisetai( finalgoalpos, undefined, undefined, undefined, 1, 1, goalyaw, 0, 0, stopatgoal, 0, 0, stopatgoal );
}

// Namespace sat_ob_contract_taurus_intro
// Params 3
// Checksum 0x11d12bba, Offset: 0x51d4
// Size: 0x68
function get_desired_height( x, y, rand )
{
    offgroundheight = ( 0, 0, 750 )[ 2 ];
    groundheight = trace_ground_point( x, y );
    trueheight = groundheight + offgroundheight;
    trueheight += randomint( rand );
    return trueheight;
}

// Namespace sat_ob_contract_taurus_intro
// Params 2, eflags: 0x4
// Checksum 0x1df968b7, Offset: 0x5245
// Size: 0xce
function private trace_ground_point( x, y )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"flyaway" );
    z = -99999;
    currz = self.origin[ 2 ] + 2000;
    minz = 0;
    ignorelist = [ self ];
    trc = trace::sphere_trace( ( x, y, currz ), ( x, y, z ), 800, ignorelist, undefined, 1 );
    
    if ( trc[ "position" ][ 2 ] < minz )
    {
        hightrace = minz;
    }
    else
    {
        hightrace = trc[ "position" ][ 2 ];
    }
    
    return hightrace;
}

// Namespace sat_ob_contract_taurus_intro
// Params 1, eflags: 0x4
// Checksum 0xc08410dd, Offset: 0x531c
// Size: 0x9e
function private function_cddb50034003950e( squad_struct )
{
    squad_struct endon( #"squad_empty" );
    
    if ( getdvarint( @"hash_c09fac51a5c40165", 0 ) )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_f111d119840ba859", 0 ) )
    {
        if ( !isdefined( level.taurus_oob_volumes ) )
        {
            level.taurus_oob_volumes = getnoentvolumearray( "taurus_oob_volume", #targetname );
        }
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    childthread story_contract_util::function_cddb50034003950e( var_64bb57aa2d6e8b35, level.taurus_oob_volumes );
}

