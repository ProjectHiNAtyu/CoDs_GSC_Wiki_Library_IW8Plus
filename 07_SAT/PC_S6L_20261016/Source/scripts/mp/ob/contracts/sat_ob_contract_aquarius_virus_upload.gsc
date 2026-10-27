// scripts\mp\ob\contracts\sat_ob_contract_aquarius_virus_upload.gsc  (hash_4c7203d8eb2aefe5.gscc) (size: 33325 Bytes / 0x822d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x679f8677 (1738507895)
// size ...... 33325 (0x822d)
// includes .. 28  (offset: 0x7939)
// strings ... 146 (offset: 0x7a19)
// dev strs .. 4   (offset: 0x81f9)
// exports ... 83  (offset: 0x53a1)
// cseg ...... 0x148f + 0x3f12 (0x53a1)
// imports ... 198 (offset: 0x6099)
// animtree1 . 0   (offset: 0x822d)
// animtree2 . 0   (offset: 0x822d)
#using script_3edd59d0d3fc3262;
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_spawn_director_utility;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\waypoint_objective_handler;
#using scripts\mp\ai_behavior;
#using scripts\mp\armor;
#using scripts\mp\class;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\activities\ob_activity_merc_camp;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\systems\ob_activity_manager;
#using scripts\mp\ob\systems\ob_item_select;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\overlord;

#namespace sat_ob_contract_aquarius_virus_upload;

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0, eflags: 0x5
// Checksum 0x9b0dcd99, Offset: 0x14ad
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_2264bdb5648a0821", undefined, &function_538033a540e63c70, undefined );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0, eflags: 0x4
// Checksum 0x31e758e1, Offset: 0x14ce
// Size: 0x9c
function private function_538033a540e63c70()
{
    ob_settings = ob::get_ob_settings();
    
    if ( !ob_settings.var_49178f6e5c220274 )
    {
        return;
    }
    
    activity_common::registeractivitytype( "REV_OB_AQUARIUS_VIRUS_UPLOAD", &activity_type_init );
    level callback::add( #"hash_cc06eb1d45f33a0c", &on_player_connect_squad );
    classtableentry = getscriptbundle( hashcat( %"classtableentry:", "classtableentry_sat_ob_aqua_default" ) );
    level.aqua_starting_loadout = { #loadout_key:"starting_loadout", #loadout_array:class::function_79947c7814a64d0e( classtableentry ) };
    level thread setup_respawn_points();
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x1abd5d48, Offset: 0x1572
// Size: 0x74
function function_ecb06595429c1285( vehicle )
{
    vehicle.spawndata.og_script_startinghealth = vehicle.maxhealth;
    vehicle.maxhealth = 850;
    vehicle.health = vehicle.maxhealth;
    vehicle.spawndata.script_startinghealth = vehicle.maxhealth;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xc20307dd, Offset: 0x15ee
// Size: 0x16
function function_5cff4aa048be5622( vehicle )
{
    level thread function_175d3787b3fd8ccb( vehicle );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1, eflags: 0x4
// Checksum 0x7d006e9c, Offset: 0x160c
// Size: 0x9d
function private function_175d3787b3fd8ccb( vehicle )
{
    level endon( #"game_ended" );
    vehicle endon( #"death" );
    wait 3;
    vehicle.spawndata.og_script_startinghealth = vehicle.maxhealth;
    vehicle.maxhealth = getdvarfloat( @"hash_5a444c1a84bc71fc", 1500 );
    vehicle.health = vehicle.maxhealth;
    vehicle.spawndata.script_startinghealth = vehicle.maxhealth;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xdd6d9c46, Offset: 0x16b1
// Size: 0x154
function setup_respawn_points()
{
    level endon( #"game_ended" );
    utility::flag_wait( "aqua_activity_cs_completed" );
    
    if ( level.respawn_points_aqua )
    {
        logprint( "[Aqua Respawn]", "setup_respawn_points(..) entered and returned as level.respawn_points_aqua was defined." );
        logprint( "[Aqua Respawn]", " level.respawn_points_aqua size = " + level.respawn_points_aqua.size );
        return;
    }
    
    array_t = [ "respawn_points_gas_station", "respawn_points_pre_colosseum", "respawn_points_colosseum", "respawn_points_pre_descend", "respawn_points_post_descend", "respawn_points_post_smoke", "respawn_points_bar", "respawn_points_pre_boxing", "respawn_points_post_tablet", "respawn_points_pre_wave_defend", "respawn_points_pre_wave_defend_closer", "respawn_points_outro" ];
    level.respawn_points_aqua = [];
    
    foreach ( t in array_t )
    {
        level.respawn_points_aqua[ t ] = utility::getstructarray( t, "targetname" );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 4
// Checksum 0xfafeebc6, Offset: 0x180d
// Size: 0x7f
function function_eff49af9973cb6e3( squad_struct, flag, respawn_target, endonstr )
{
    level endon( #"game_ended" );
    
    if ( endonstr )
    {
        level endon( endonstr );
    }
    
    utility::flag_wait( flag );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( respawn_target ) );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x273fd2df, Offset: 0x1894
// Size: 0x2b
function get_respawn_points( targetname )
{
    prefix = "respawn_points_";
    return level.respawn_points_aqua[ prefix + targetname ];
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x8e9e9c85, Offset: 0x18c8
// Size: 0x79
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_VIRUS_UPLOAD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_VIRUS_UPLOAD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_VIRUS_UPLOAD", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_AQUARIUS_VIRUS_UPLOAD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "REV_OB_AQUARIUS_VIRUS_UPLOAD" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "REV_OB_AQUARIUS_VIRUS_UPLOAD" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xf87ae32c, Offset: 0x1949
// Size: 0x1be
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self.active_squads = [];
    logstring( "[AquaVirus] activity_setup() Ran for - Virus Upload" );
    level.aqua_virus_upload_activity = activity_instance;
    
    if ( !isdefined( level.aqua_virus_upload_activity.sam_interaction_scriptable ) )
    {
        logstring( "[AquaVirus] level.aqua_virus_upload_activity.sam_interaction_scriptable NOT DEFINED - Virus Upload" );
        struct = utility::getstruct( "aqua_sam_site_interact_struct", "targetname" );
        level.aqua_virus_upload_activity.sam_interaction_scriptable = spawnscriptable( "sat_ob_aquarius_sam_site_keyboard", struct.origin, struct.angles );
        interact = interaction::register_scriptable_interact( level.aqua_virus_upload_activity.sam_interaction_scriptable, &function_c6b24dfa5abf657 );
        interact interaction::function_e4a4753e6eac02d7();
        level.aqua_virus_upload_activity.sam_interaction_scriptable setscriptablepartstate( "model", "visible" );
        level.aqua_virus_upload_activity.sam_interaction_scriptable setscriptablepartstate( "sam_launch_interact", "unusable" );
        level.aqua_virus_upload_activity.sam_interaction_scriptable setscriptablepartstate( "sam_hack_interact", "usable" );
        level.aqua_virus_upload_activity.sam_interaction_scriptable function_7653c765b6c7b815();
        level.aqua_virus_upload_activity.sam_interaction_scriptable.activity_instance = activity_instance;
        logstring( "[AquaVirus] level.aqua_virus_upload_activity.sam_interaction_scriptable DEFINED - Virus Upload" );
    }
    
    thread colosseum_exclusion_zone( activity_instance );
    thread defend_exclusion_zone( activity_instance );
    function_a25acb62ddab20e2( "aqua_encounter", 1 );
    aqua_setup_cover();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x5e21e3dd, Offset: 0x1b0f
// Size: 0x80
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    logstring( "[AquaVirus] activity_begin() Ran for - Virus Upload" );
    setdvarifuninitialized( @"hash_f9fb0f40bb53d30d", 8000 );
    level.aqua_virus_info = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ activity_instance.varianttag ];
    thread respawn_on_destroyed( activity_instance, activity_instance.varianttag );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2, eflags: 0x4
// Checksum 0x86c6de6, Offset: 0x1b97
// Size: 0x16f
function private function_d626cc76cae468c1( player, loadout )
{
    logstring( "[Aqua]: Entered giveStartingLoadoutToPlayer func(..) with values: player.current_loadout_key = " + player.current_loadout_key + " loadout.loadout_key: " + loadout.loadout_key );
    logstring( "[Aqua]: LOADOUT DETAILS: " );
    
    foreach ( loadout_element in loadout.loadout_array )
    {
        logstring( "[Aqua]: LOADOUT DETAILS: " + loadout_element );
    }
    
    if ( loadout && player.current_loadout_key != loadout.loadout_key )
    {
        logstring( "[Aqua]: Entered giveStartingLoadoutToPlayer func(..) " );
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, 2, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
        player armor::setarmorhealth( player.maxarmorhealth );
        platecount = player armor::function_22290101992e4874();
        platemax = 2;
        var_1fd4f9927be13502 = platemax - platecount;
        player armor::function_164c824617d7e8d7( var_1fd4f9927be13502 );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x7d3254c9, Offset: 0x1d0e
// Size: 0xc1
function function_3f8c1ad4f6f4c06c( loadout )
{
    self notify( #"hash_332bd9440fd35d0b" );
    self endon( #"hash_332bd9440fd35d0b" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    player = self;
    story_contract_util::waittill_active( player, #"aqua_virus" );
    logstring( "[Aqua]: Entered loadout func via assignAquaLoadoutWhenApplicable(..) " );
    
    if ( !isdefined( player ) )
    {
        player thread ob_story_mission_utils::function_96a2f57e9afcdff1( player, loadout.loadout_array, 2, "primary", 1 );
        player.current_loadout_key = loadout.loadout_key;
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    function_d626cc76cae468c1( player, level.aqua_starting_loadout );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xc50e7d66, Offset: 0x1dd7
// Size: 0x492
function on_player_connect_squad( params )
{
    self notify( #"hash_38f2edb419045439" );
    self endon( #"hash_38f2edb419045439" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::flag_wait( "scriptables_ready" );
    story_contract_util::waittill_active( self, #"aqua_virus" );
    self.var_1f7c1a5f16a94bfe = 1;
    thread function_c30841c325da9a4c();
    utility::flag_set( "cleanup_prop_only_merc_camps" );
    utility::flag_set( "aqua_virus_started" );
    colosseum_rhino_drops = utility::getstructarray( "colosseum_rhino_drops", "targetname" );
    
    if ( colosseum_rhino_drops.size )
    {
        level.var_e2f4b643d9aa57ae = colosseum_rhino_drops;
    }
    
    thread function_3f8c1ad4f6f4c06c( level.aqua_starting_loadout );
    thread function_a44955a679343676();
    squad_leader = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
    
    if ( self == squad_leader )
    {
        level.modifyvehicledamage = &function_90acb293460f5584;
        level thread spawn_killstreaks( is_solo_player( squad_leader ) );
        level thread spawn_ammocrates();
        level thread function_d10c2cc866a965ca();
        level thread function_7ed2850e4c42582c();
        logstring( "Aqua Mission virus_upload started for squad: " + squad_leader.sessionsquadid );
    }
    
    childthread function_4a88b972a328643d();
    
    if ( !isdefined( level.aqua_virus_upload_activity.active_squads[ self.sessionsquadid ] ) )
    {
        squad_struct = { #sessionsquadid:self.sessionsquadid, #team:self.team };
        level.aqua_virus_upload_activity.active_squads[ self.sessionsquadid ] = squad_struct;
        level.aqua_virus_upload_activity toggle_sam_keyboard_for_player( self, 1 );
        level.aqua_virus_upload_activity thread cleanup_squad_struct( self.sessionsquadid, squad_struct );
    }
    else
    {
        squad_struct = level.aqua_virus_upload_activity.active_squads[ self.sessionsquadid ];
        
        if ( !utility::flag( "interacted_with_samsite_keyboard_aqua_virus" ) )
        {
            level.aqua_virus_upload_activity toggle_sam_keyboard_for_player( self, 1 );
        }
    }
    
    activity_participation::function_bc67362dace4370c( level.aqua_virus_upload_activity, self, "PlayerJoinedOther" );
    
    foreach ( abilitycase in level.var_119fe64f857f4bc7 )
    {
        ob_item_select::function_923ddf97f6cdbee( abilitycase, [ self ] );
    }
    
    obj_struct = utility::getstruct( "sat_aqua_stadium_hack_objective" );
    org = obj_struct.origin;
    level.sam_site_hack_obj = obj_struct;
    thread function_aefe8caf1f5df55b( level.aqua_virus_upload_activity, squad_struct, org );
    thread function_8beaa8dae73d24d1( org, 1000, squad_struct );
    squad_leader = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
    squad_struct waittill( #"interacted_with_samsite_keyboard_aqua_virus" );
    utility::flag_set( "sam_site_breadcrumb_obj_done" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "pre_wave_defend_closer" ), 0.75 );
    level thread ob_story_mission_utils::objective_marker_hide( level.var_a6760aca843741a7, [ self ] );
    squad_struct waittill( #"hash_86f83d4e6503fe47" );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "outro" ), 0.95 );
    squad_leader = squad_utility::getsquadleader( self.team, self.sessionsquadid ) ?? self;
    
    if ( self == squad_leader )
    {
        squad = squad_leader squad_utility::getsquadmembers( squad_leader.team, 0 );
        level ob_story_mission_utils::mission_objective_marker_hide( level.var_a6760aca843741a7, squad );
        logstring( "[Aqua] Hide objective marker for all players in squad: " + level.var_a6760aca843741a7 + " :SID" + self.sessionsquadid );
        thread function_528cadacad738ebd( var_64bb57aa2d6e8b35 );
        story_contract_util::mark_complete( squad, #"aqua_virus" );
        level.modifyvehicledamage = undefined;
    }
    
    squad_struct notify( #"cleanup_squad" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x35128413, Offset: 0x2271
// Size: 0x67
function function_a44955a679343676()
{
    self endon( #"disconnect" );
    utility::ent_flag_wait( "squad_play_begin" );
    var_22cc9074f5c0c4f6 = #"health_upgrade";
    desiredlevel = 2;
    
    if ( !function_9c687beafaa9c227( self, var_22cc9074f5c0c4f6, desiredlevel ) )
    {
        utility::callsharedfunc( #"skills", #"giveskill", var_22cc9074f5c0c4f6, desiredlevel, undefined, 0 );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0x254c03a8, Offset: 0x22e0
// Size: 0x54, Type: bool
function function_9c687beafaa9c227( player, skillref, desiredlevel )
{
    activeskills = player.activeskills;
    
    if ( !isdefined( activeskills ) )
    {
        return false;
    }
    
    if ( activeskills[ skillref ] && activeskills[ skillref ] == desiredlevel )
    {
        return true;
    }
    
    return false;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0xffd91013, Offset: 0x233d
// Size: 0xd4
function function_aefe8caf1f5df55b( activity_instance, squad_struct, org )
{
    ob_story_mission_utils::function_b3e9457491e7af72( %"hash_3102a760e04d5591", [ self ] );
    thread function_c5ea3c0d07b92049( activity_instance, squad_struct );
    
    if ( getdvarint( @"hash_3d946ef6f19eb0c9", 0 ) <= 0 )
    {
        utility::flag_wait( "sam_site_breadcrumb_obj_done" );
    }
    
    if ( !isdefined( level.var_a6760aca843741a7 ) )
    {
        level.var_a6760aca843741a7 = level ob_story_mission_utils::function_b9cb179f9577f32a( level.aqua_virus_upload_activity.sam_interaction_scriptable.origin, 51, [ self ], "sat_ob_objectivemarker_storymissionmain" );
        activity_instance namespace_d7fa4530141146a5::function_e27cc6376feeb35c( level.var_a6760aca843741a7, 0, 1 );
        return;
    }
    
    level ob_story_mission_utils::objective_marker_show( level.var_a6760aca843741a7, [ self ] );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0x94eb8cd9, Offset: 0x2419
// Size: 0xa4
function function_c5ea3c0d07b92049( activity_instance, squad_struct )
{
    if ( utility::flag( "sam_site_breadcrumbs_setup" ) )
    {
        return;
    }
    
    utility::flag_set( "sam_site_breadcrumbs_setup" );
    done_notification = "sam_site_breadcrumb_obj_done";
    var_2ec40eb41a3473d8 = "sam_site_breadcrumb_obj_done_for_player";
    var_95744c12a9bd0d73 = "sam_site";
    activity_instance thread ob_story_mission_utils::function_56960723e6738b6c( undefined, var_95744c12a9bd0d73, "sat_ob_objectivemarker_location", done_notification, var_2ec40eb41a3473d8, function_9cdbaea6c78ac37b( squad_struct ), 0, 0, undefined, 1 );
    activity_instance thread function_7bed1ba221664947( var_95744c12a9bd0d73, activity_instance.playerparticipants );
    level waittill( done_notification );
    utility::flag_set( done_notification );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0x2d3fafb3, Offset: 0x24c5
// Size: 0x54
function function_7bed1ba221664947( var_95744c12a9bd0d73, players )
{
    level endon( #"game_ended" );
    level endon( #"sam_site_breadcrumb_obj_done" );
    utility::flag_wait_any( "interacted_with_samsite_keyboard_aqua_virus", "checkpoint_set_samsite" );
    waypoint_objective_handler::waypoint_objective_handler_cancel( var_95744c12a9bd0d73, players );
    level notify( #"sam_site_breadcrumb_obj_done" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x14e2329a, Offset: 0x2521
// Size: 0x1d6
function function_c30841c325da9a4c()
{
    level endon( #"game_ended" );
    
    if ( level.var_5b6cb530301bf0ea )
    {
        return;
    }
    
    level.var_5b6cb530301bf0ea = 1;
    merc_camps = [ "MERC_CAMP_Q2_COLOSSEUM", "MERC_CAMP_Q2_ROMAN_CANALS" ];
    var_5ff513710d2b2eee = utility::getstructarray( "activity_nexus_variant", "targetname" );
    var_dc3ca1ff0848e9f7 = [];
    
    foreach ( variant in var_5ff513710d2b2eee )
    {
        if ( variant.activity_bundle == "sat_activitydefinition_merccamp" )
        {
            if ( variant.name == merc_camps[ 0 ] || variant.name == merc_camps[ 1 ] )
            {
                var_dc3ca1ff0848e9f7[ var_dc3ca1ff0848e9f7.size ] = variant;
            }
        }
    }
    
    index = 0;
    
    foreach ( camp_center in var_dc3ca1ff0848e9f7 )
    {
        dummycamp = spawnstruct();
        dummycamp.s_center = camp_center;
        dummycamp.s_center.script_noteworthy = camp_center.name;
        dummycamp ob_activity_merc_camp::merc_camp_setup_cover();
        dummycamp ob_activity_merc_camp::function_21811bb0afce307f();
        index++;
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x27739a27, Offset: 0x26ff
// Size: 0x49
function function_c6b24dfa5abf657( player )
{
    scriptable = self;
    
    if ( !isplayer( player ) || player.inlaststand || !isalive( player ) )
    {
        return;
    }
    
    scriptable function_720b2869a86123c( player, scriptable );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0xd7028a48, Offset: 0x2750
// Size: 0x13c
function function_720b2869a86123c( player, scriptable )
{
    if ( player.ismutantinjection || player.carryinghostage || player.inlaststand || player.isjuggernaut )
    {
        player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return;
    }
    
    squad_struct = level.aqua_virus_upload_activity.active_squads[ player.sessionsquadid ];
    squadmembers = function_1cf398b684dcfd81( player );
    
    foreach ( squadmember in squadmembers )
    {
        toggle_sam_keyboard_for_player( squadmember, 0 );
    }
    
    squad_struct notify( #"interacted_with_samsite_keyboard_aqua_virus" );
    utility::flag_set( "interacted_with_samsite_keyboard_aqua_virus" );
    thread function_be702266b5df011b( squadmembers );
    thread function_e91c46daa7e53dcc( squad_struct );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xf969821a, Offset: 0x2894
// Size: 0x1b2
function spawn_killstreaks( for_solo_player )
{
    level endon( #"game_ended" );
    utility::flag_wait( "ai_spawn_director_create_script_processed" );
    artillerystructs = utility::getstructarray( "aqua_defend_artillery", "script_noteworthy" );
    briefcasestructs = utility::getstructarray( "aqua_defend_artillery_briefcase", "script_noteworthy" );
    
    if ( !utility::flag( "aqua_spawned_supply_caches_defend" ) )
    {
        utility::flag_set( "aqua_spawned_supply_caches_defend" );
        thread story_contract_util::function_e6799e9a19df2365( "aqua_supplycrate_defense_rhino", %"hash_d0d85b47adff61b" );
        thread story_contract_util::function_e6799e9a19df2365( "aqua_supplycrate_defense_sentry", %"hash_2b3246afa958bad8" );
    }
    
    if ( getdvarint( @"hash_591eecc29d24e1c0", 1 ) )
    {
        item = drop_itemselect( briefcasestructs[ 0 ].origin );
        item2 = drop_itemselect( briefcasestructs[ 1 ].origin );
        item thread function_48e3efb3ea4dbc32( level.aqua_virus_upload_activity, 1 );
        item2 thread function_48e3efb3ea4dbc32( level.aqua_virus_upload_activity, 1 );
        return;
    }
    
    foreach ( struct in artillerystructs )
    {
        ks = function_4631d0ed5d05501d( "brloot_killstreak_clusterstrike", struct.origin );
        ks thread function_48e3efb3ea4dbc32( level.aqua_virus_upload_activity, 1 );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0x994a8af7, Offset: 0x2a4e
// Size: 0x37
function function_4631d0ed5d05501d( killstreakref, origin )
{
    ksscriptable = spawnscriptable( killstreakref, origin, ( 0, 0, 0 ) );
    return ksscriptable;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0x99afa146, Offset: 0x2a8e
// Size: 0xf9
function function_8beaa8dae73d24d1( org, dist, squad_struct )
{
    player = self;
    player endon( #"disconnect" );
    squad_struct endon( #"hack_set_complete" );
    level endon( #"checkpoint_set_samsite" );
    dist_sq = squared( dist );
    var_26c9a9129fa725cd = squared( dist * 1.2 );
    
    while ( true )
    {
        curr_sq = distancesquared( self.origin, org );
        
        if ( curr_sq < dist_sq )
        {
            var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
            var_64bb57aa2d6e8b35 story_contract_util::set_squad_respawn( get_respawn_points( "pre_wave_defend" ), 0.7 );
            thread function_d788d1f736f77059( var_64bb57aa2d6e8b35 );
            utility::flag_set( "checkpoint_set_samsite" );
            break;
        }
        
        wait 1;
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0x6c40ce36, Offset: 0x2b8f
// Size: 0x4e
function cleanup_squad_struct( sessionsquadid, squad_struct )
{
    activity_instance = self;
    activity_instance endon( #"hash_1b6b9613636daa6a" );
    squad_struct waittill( #"cleanup_squad" );
    wait 1;
    activity_instance.active_squads[ sessionsquadid ] = undefined;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0x1bc4c716, Offset: 0x2be5
// Size: 0xfc
function toggle_sam_keyboard_for_player( player, toggle )
{
    if ( !player )
    {
        logstring( "[AquaVirus] toggle_sam_keyboard_for_player(..) --> player is undefined " );
    }
    
    if ( !level.aqua_virus_upload_activity.sam_interaction_scriptable )
    {
        logstring( "[AquaVirus] toggle_sam_keyboard_for_player(..) --> SAM INTERACTION SCRIPTABLE is undefined  for player:  " + player.name );
    }
    
    if ( toggle )
    {
        level.aqua_virus_upload_activity.sam_interaction_scriptable setscriptablepartstate( #"sam_hack_interact", #"usable" );
        level.aqua_virus_upload_activity.sam_interaction_scriptable enablescriptableplayeruse( player );
        level thread function_ea16a95e9e36ed66( player );
        logstring( "[AquaVirus] EnableScriptablePlayerUse(..) --> scriptable enabled for player:  " + player.name );
        return;
    }
    
    level.aqua_virus_upload_activity.sam_interaction_scriptable disablescriptableplayeruse( player );
    player playsoundtoplayer( "fly_aqua_sam_site_laptop", player );
    logstring( "[AquaVirus] DisableScriptablePlayerUse(..) --> scriptable DISABLED for player:  " + player.name );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xb9cd59d0, Offset: 0x2ce9
// Size: 0x76
function function_ea16a95e9e36ed66( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    level.aqua_virus_upload_activity endon( #"instance_destroyed" );
    wait 1;
    
    if ( isdefined( level.aqua_virus_upload_activity.sam_interaction_scriptable ) && isdefined( player ) )
    {
        level.aqua_virus_upload_activity.sam_interaction_scriptable enablescriptableplayeruse( player );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x557b178f, Offset: 0x2d67
// Size: 0x112
function function_4a88b972a328643d()
{
    self waittill( #"hash_1b6b9613636daa6a" );
    
    if ( level.var_a6760aca843741a7 )
    {
        level ob_story_mission_utils::mission_objective_marker_hide( level.var_a6760aca843741a7, [ self ] );
    }
    
    hack_set = level.aqua_virus_upload_activity.active_squads[ self.sessionsquadid ].hack_set;
    
    if ( hack_set )
    {
        foreach ( scriptable in level.aqua_virus_upload_activity.master_scriptables[ hack_set ] )
        {
            scriptable disablescriptableplayeruse( self );
        }
    }
    
    level.aqua_virus_upload_activity.active_squads[ self.sessionsquadid ] = undefined;
    thread on_player_connect_squad( {} );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x8f7bd7b, Offset: 0x2e81
// Size: 0x50
function colosseum_exclusion_zone( activity_instance )
{
    struct = utility::getstruct( "colosseum_exclusion_zone", "targetname" );
    function_1c4c7ef874191be2( "colosseum_zone", struct.origin, 2000, 1 );
    thread function_cb1874669e655110( "colosseum_zone", activity_instance );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xeca6cc3b, Offset: 0x2ed9
// Size: 0xca
function defend_exclusion_zone( activity_instance )
{
    structs = utility::getstructarray( "defend_exclusion_zones", "targetname" );
    
    foreach ( index, struct in structs )
    {
        zone_name = "defend_zone" + index;
        function_1c4c7ef874191be2( zone_name, struct.origin, struct.radius, 1 );
        thread function_cb1874669e655110( zone_name, activity_instance );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0xeda134ad, Offset: 0x2fab
// Size: 0x3b
function function_cb1874669e655110( zone_name, activity_instance )
{
    level endon( #"game_ended" );
    activity_instance utility::waittill_any( "activity_ended", "instance_destroyed" );
    function_71799ce2c69ce5a9( zone_name );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xd17e6a25, Offset: 0x2fee
// Size: 0x2a7
function function_d10c2cc866a965ca()
{
    utility::flag_wait( "ai_spawn_director_create_script_processed" );
    utility::flag_wait( "aqua_virus_started" );
    deletion_triggers = utility::getstructarray( "deletion_trigger", "targetname" );
    
    foreach ( deletion_trigger in deletion_triggers )
    {
        deletion_trigger thread function_dbed131e2babc68a();
    }
    
    var_7841ce3c7f6ddd42 = utility::getstructarray( "trigger_pre_defend_attackers_backtrack_below", "targetname" );
    ai_spawn_director::array_spawn_function_targetname( "pre_defend_attackers_backtrack_below", &function_1d2c333960197a30 );
    var_f32b85721e37300 = utility::getstructarray( "trigger_pre_defend_attackers_backtrack_below_2", "targetname" );
    var_d5cd491c1b213915 = utility::getstructarray( "trigger_pre_defend_attackers_front_below", "targetname" );
    ai_spawn_director::array_spawn_function_targetname( "pre_defend_attackers_backtrack_below_2", &function_1d2c333960197a30 );
    
    foreach ( b_trig in var_f32b85721e37300 )
    {
        b_trig thread function_ccd4fcb9798399ab();
    }
    
    foreach ( b_trig in var_7841ce3c7f6ddd42 )
    {
        b_trig thread function_ccd4fcb9798399ab();
    }
    
    foreach ( var_1534972594914a50 in var_d5cd491c1b213915 )
    {
        var_1534972594914a50 thread function_ccd4fcb9798399ab();
    }
    
    backtrack_trigger = utility::getstruct( "trigger_pre_defend_attackers_backtrack", "targetname" );
    ai_spawn_director::array_spawn_function_targetname( "pre_defend_attackers_backtrack", &function_1d2c333960197a30 );
    backtrack_trigger thread function_ccd4fcb9798399ab( undefined, undefined, [ "interacted_with_samsite_keyboard_aqua_virus", "sam_site_breadcrumb_obj_done" ] );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 4
// Checksum 0x25362514, Offset: 0x329d
// Size: 0x76
function function_785c407aec148599( requestid, userdata, agent, data )
{
    if ( !level.var_53153714629116b9 )
    {
        thread function_33e0c4bb5e08c704( userdata );
        level.var_53153714629116b9 = 1;
    }
    
    agent.script_noteworthy = data.script_noteworthy;
    agent.disabledropfromcombat = 1;
    agent thread function_8b4e5edcb924d49();
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xf29f837d, Offset: 0x331b
// Size: 0x23
function function_1d2c333960197a30()
{
    self endon( #"death" );
    thread ai_despawn_on_activity_destroyed();
    function_8b4e5edcb924d49();
    thread function_83b79367566ea3a7();
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x63eef63e, Offset: 0x3346
// Size: 0x33
function function_83b79367566ea3a7()
{
    self endon( #"death" );
    utility::flag_wait( "checkpoint_set_samsite" );
    self setgoalpos( level.sam_site_hack_obj.origin );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x61a91f5, Offset: 0x3381
// Size: 0x85
function function_8b4e5edcb924d49()
{
    agent = self;
    agent.disabledropfromcombat = 1;
    
    if ( agent.stealth_enabled )
    {
        agent setstealthstate( "combat" );
    }
    
    var_e7687cd7f6c0c0dc = utility::getstructarray( "colo_defense_ai_goal", "targetname" );
    var_4e878d7d0d490a4d = var_e7687cd7f6c0c0dc[ 0 ].origin;
    var_c586c93e1fc6087a = 4256;
    agent function_fa32376aaa88a7a2( var_4e878d7d0d490a4d, var_c586c93e1fc6087a );
    agent forcethreatupdate();
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x7922cf07, Offset: 0x340e
// Size: 0x9b
function function_dbed131e2babc68a()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( who.owner && isplayer( who.owner ) )
        {
            break;
        }
        
        if ( isplayer( who ) )
        {
            break;
        }
    }
    
    if ( self.target )
    {
        target_trigger = utility::getstruct( self.target, "targetname" );
        
        if ( target_trigger )
        {
            target_trigger notify( #"delete_me" );
        }
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0x7d6ed43b, Offset: 0x34b1
// Size: 0x1ca
function function_ccd4fcb9798399ab( delete_trigger, requestids, endonstr )
{
    self endon( #"death" );
    self endon( #"delete_me" );
    
    if ( endonstr )
    {
        if ( isarray( endonstr ) )
        {
            foreach ( str in endonstr )
            {
                level endon( str );
            }
        }
        else
        {
            level endon( endonstr );
        }
    }
    
    while ( true )
    {
        self waittill( #"trigger", who );
        
        if ( who.owner && isplayer( who.owner ) )
        {
            break;
        }
        
        if ( isplayer( who ) )
        {
            break;
        }
    }
    
    if ( self.target )
    {
        spawned = ai_spawn_director::array_spawn_targetname( self.target );
    }
    
    if ( requestids )
    {
        if ( isarray( requestids ) )
        {
            foreach ( requestid in requestids )
            {
                function_ef57f478f96b050c( requestid, 1 );
            }
        }
        else
        {
            function_ef57f478f96b050c( requestids, 1 );
        }
    }
    
    if ( delete_trigger )
    {
        delete_trigger notify( #"delete_me" );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xf6421244, Offset: 0x3683
// Size: 0xc7
function spawn_ammocrates()
{
    ammocrate_structs = utility::getstructarray( "aqua_ammocrate", "targetname" );
    
    if ( ammocrate_structs )
    {
        foreach ( ammocrate_struct in ammocrate_structs )
        {
            ammocrate = spawnscriptable( "military_ammo_restock_story", ammocrate_struct.origin, ammocrate_struct.angles );
            ammocrate thread function_48e3efb3ea4dbc32( level.aqua_virus_upload_activity, 1 );
        }
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0, eflags: 0x4
// Checksum 0xf708212f, Offset: 0x3752
// Size: 0x29
function private aqua_setup_cover()
{
    if ( !isdefined( var_2f54c2aa4c83c7c6 ) )
    {
        var_2f54c2aa4c83c7c6 = [];
    }
    
    var_2f54c2aa4c83c7c6 = ob_soldier_util::function_a315cc5d1dee425a( "e_cover_aqua" );
    waitframe();
    function_600406be1c075254();
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0, eflags: 0x4
// Checksum 0x38d8275d, Offset: 0x3783
// Size: 0xe
function private function_600406be1c075254()
{
    ob_activity_utility::ob_enable_cover_nodes( "e_covernode_aqua" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x5efa2e06, Offset: 0x3799
// Size: 0x4f
function function_7ed2850e4c42582c()
{
    level endon( #"game_ended" );
    encounter = "enc_aqua_colo_start_spawns";
    encreq = ai_spawn_director::lookup_spawn_request( encounter );
    
    if ( !isdefined( encreq ) )
    {
        assertmsg( "<dev string:x56>" );
        return;
    }
    
    function_ef57f478f96b050c( encreq, 1 );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xb1ad4b6, Offset: 0x37f0
// Size: 0x115
function function_1c8a566403d6414c( squad_leader )
{
    level endon( #"game_ended" );
    approachdist = 750;
    obj_struct = utility::getstruct( "sat_aqua_stadium_hack_objective" );
    dist_sq = approachdist * approachdist;
    
    if ( !isdefined( obj_struct ) )
    {
        return;
    }
    
    while ( true )
    {
        squadmembers = function_1cf398b684dcfd81( squad_leader );
        closestplayer = function_47c86977a18df38b( squadmembers, obj_struct.origin, 4000 );
        
        if ( !isdefined( closestplayer ) )
        {
            wait 2;
            continue;
        }
        
        curr_sq = distancesquared( closestplayer.origin, obj_struct.origin );
        
        if ( curr_sq < dist_sq )
        {
            break;
        }
        
        wait 2;
    }
    
    encounter = "enc_aqua_colo_first_vtol";
    encreq = ai_spawn_director::lookup_spawn_request( encounter );
    
    if ( !isdefined( encreq ) )
    {
        assertmsg( "<dev string:x56>" );
        return;
    }
    
    ai_spawn_director::function_baa5d26d8804d5da( encreq, &function_3179bdeeed86a40c );
    function_ef57f478f96b050c( encreq, 1 );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xccd6cf5b, Offset: 0x390d
// Size: 0x7d
function drop_itemselect( origin )
{
    level.var_97db93a6b414090d = 1;
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, ( 0, 0, 0 ) );
    spawnoptions.var_fd47e835523b473f = 1;
    itemcount = getdvarint( @"hash_34cda70a0a2dddd0", 1 );
    item = common_item::function_61c2c0251e742ffd( %"hash_4705d6700ed9daf3", itemcount, spawnoptions );
    return item;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xed930da2, Offset: 0x3993
// Size: 0x2a4
function function_e91c46daa7e53dcc( squad_struct )
{
    level endon( #"game_ended" );
    level.aqua_virus_upload_activity endon( #"instance_destroyed" );
    encounters = [ "enc_aqua_colo_wave_1", "enc_aqua_colo_wave_2", "enc_aqua_colo_wave_3" ];
    var_ec44db0a73297ca1 = [ 2, 3 ];
    issolo = is_solo_player( squad_struct ) && getdvarint( @"hash_451feabf8bff2c16", 0 ) < 1;
    var_f6533e39e2f5fc1e = 1;
    encindex = 0;
    totalwaves = 3;
    
    if ( getdvarint( @"hash_6e908105693cbbac", 0 ) )
    {
        totalwaves = 0;
    }
    
    while ( var_f6533e39e2f5fc1e < totalwaves + 1 )
    {
        if ( encindex >= encounters.size )
        {
            encindex = encounters.size - 1;
        }
        
        encounter_targetname = encounters[ encindex ];
        encindex++;
        
        if ( issolo )
        {
            encounter_targetname += "_solo";
        }
        
        var_4bd3c6b05068a0f1 = ai_spawn_director::lookup_spawn_request( encounter_targetname );
        
        if ( !isdefined( var_4bd3c6b05068a0f1 ) )
        {
            assertmsg( "<dev string:x88>" );
            return;
        }
        
        level.var_290f8ca9cefc1182 = [];
        ai_spawn_director::add_spawned_callback( var_4bd3c6b05068a0f1, &function_3a7ea95cbf10c760 );
        ai_spawn_director::function_baa5d26d8804d5da( var_4bd3c6b05068a0f1, &function_3179bdeeed86a40c );
        ai_spawn_director::add_vehicle_spawned_callback( var_4bd3c6b05068a0f1, &function_f308805dfe015bf6 );
        function_64ac8c4e752f4dca( var_4bd3c6b05068a0f1, 0 );
        ai_spawn_director::function_5a08798970350207( var_4bd3c6b05068a0f1, &function_ebaa67bb90b9d359, { #squad_struct:squad_struct } );
        waitframe();
        function_ef57f478f96b050c( var_4bd3c6b05068a0f1, 1 );
        thread function_ee5e6f920b374432( "ENEMY WAVE " + var_f6533e39e2f5fc1e + " SPAWNED", 4 );
        wait 1;
        thread function_ee301d0287703c3f( var_4bd3c6b05068a0f1, squad_struct );
        
        if ( !issolo && arraycontains( var_ec44db0a73297ca1, var_f6533e39e2f5fc1e ) )
        {
            level thread function_f017d1f1a79d6590( 5, encounter_targetname, var_4bd3c6b05068a0f1 );
        }
        
        level utility::waittill_any_timeout( 15, "colosseum_adds_unloaded" );
        
        if ( var_f6533e39e2f5fc1e > 1 )
        {
            thread function_1263b8508a5f0bb4( 0, encounter_targetname, squad_struct );
        }
        
        thread function_45d86dd0354b97ef( squad_struct, var_4bd3c6b05068a0f1, issolo );
        utility::flag_wait_or_timeout( "colosseum_defense_wave_killed" + var_4bd3c6b05068a0f1 + squad_struct.sessionsquadid, 240 );
        squad_struct notify( #"hash_9a17027044454aa5" );
        utility::flag_clear( "colosseum_defense_wave_killed" + var_4bd3c6b05068a0f1 + squad_struct.sessionsquadid );
        var_f6533e39e2f5fc1e++;
        
        if ( var_f6533e39e2f5fc1e >= totalwaves + 1 )
        {
            function_17ee483eb76a9759( var_4bd3c6b05068a0f1, 1, 0 );
        }
    }
    
    var_9fdc98661586bd8a = utility::getstruct( "aqua_defense_center", "targetname" );
    function_1c4c7ef874191be2( "colosseum_exclusion_zone", var_9fdc98661586bd8a.origin, 4400, 1 );
    level.var_e2f4b643d9aa57ae = undefined;
    waitframe();
    squad_struct notify( #"hash_86f83d4e6503fe47" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0xd9a3f5a8, Offset: 0x3c3f
// Size: 0x163
function function_f308805dfe015bf6( requestid, userdata, vehicle )
{
    if ( vehicle )
    {
        if ( vehicle.classname_mp && issubstr( vehicle.classname_mp, "vtol" ) )
        {
            vehicle.spawndata.og_script_startinghealth = vehicle.maxhealth;
            vehicle.maxhealth = getdvarfloat( @"hash_5a444c1a84bc71fc", 1500 );
            vehicle.health = vehicle.maxhealth;
            vehicle.spawndata.script_startinghealth = vehicle.maxhealth;
        }
        else if ( vehicle.classname_mp && issubstr( vehicle.classname_mp, "medium_truck_ob" ) )
        {
            vehicle.spawndata.og_script_startinghealth = vehicle.maxhealth;
            vehicle.maxhealth = 850;
            vehicle.health = vehicle.maxhealth;
            vehicle.spawndata.script_startinghealth = vehicle.maxhealth;
        }
        
        vehicle thread function_48e3efb3ea4dbc32( level.aqua_virus_upload_activity, 1 );
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0xb35e3fb3, Offset: 0x3daa
// Size: 0x1cd
function function_1263b8508a5f0bb4( delay, wave_targetname, squad_struct )
{
    level endon( #"game_ended" );
    wait delay;
    toks = strtok( wave_targetname, "_" );
    var_b57c29b446893115 = int( toks[ 4 ] );
    vos = [ "aqua_nag_defend_north_01", "aqua_nag_defend_north_02", "aqua_nag_defend_north_03" ];
    var_febe7a920d33befa = [ "dx_wc_waqu_amid_davi_letsclearthisplaceou", "aqua_samy_theyrecomingin", "aqua_harp_thatsrightcomegetyou", "aqua_harp_aherosworkisneverdon", "aqua_amid_tacb_enemyvtolinbound" ];
    
    switch ( var_b57c29b446893115 )
    {
        case 1:
        default:
            vos = [ "aqua_nag_defend_west_01", "aqua_nag_defend_west_02", "aqua_nag_defend_west_03" ];
            break;
        case 2:
            vos = [ "aqua_nag_defend_north_01", "aqua_nag_defend_north_02", "aqua_nag_defend_north_03" ];
            break;
        case 3:
            vos = [ "aqua_nag_defend_west_01", "aqua_nag_defend_west_02", "aqua_nag_defend_west_03", "aqua_nag_defend_north_01", "aqua_nag_defend_north_02", "aqua_nag_defend_north_03" ];
            break;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( squad_struct.team, squad_struct.sessionsquadid );
    overlord::playevent( utility::array_random( vos ), var_64bb57aa2d6e8b35.players, undefined, undefined, 1 );
    overlord::playevent( utility::array_random( var_febe7a920d33befa ), var_64bb57aa2d6e8b35.players, undefined, undefined, 0 );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0x508faf52, Offset: 0x3f7f
// Size: 0xdd
function function_ee301d0287703c3f( var_4bd3c6b05068a0f1, squad_struct )
{
    level endon( #"game_ended" );
    squad_struct endon( #"hash_9a17027044454aa5" );
    level.aqua_virus_upload_activity endon( #"instance_destroyed" );
    wait 5;
    
    while ( true )
    {
        requestdata = function_9b649316adcccbaa( var_4bd3c6b05068a0f1 );
        
        foreach ( agent in requestdata.ai )
        {
            agent thread behavior_followplayer( agent );
            waitframe();
        }
        
        wait 2;
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0x7bf07906, Offset: 0x4064
// Size: 0x2b8
function function_f017d1f1a79d6590( delay, wave_targetname, var_4bd3c6b05068a0f1 )
{
    level endon( #"game_ended" );
    level notify( #"single_dawg_spawn" );
    level endon( #"single_dawg_spawn" );
    northpoint = utility::getstruct( "sat_aqua_stadium_dawg_droppoint_north", "script_noteworthy" );
    westpoint = utility::getstruct( "sat_aqua_stadium_dawg_droppoint_west", "script_noteworthy" );
    toks = strtok( wave_targetname, "_" );
    var_b57c29b446893115 = toks[ 4 ];
    wait delay;
    var_c938a1fede524680 = westpoint;
    
    switch ( var_b57c29b446893115 )
    {
        case 1:
        default:
            var_c938a1fede524680 = northpoint;
            break;
        case 2:
            var_c938a1fede524680 = westpoint;
            break;
        case 3:
            var_c938a1fede524680 = utility::array_random( [ northpoint, westpoint ] );
            break;
    }
    
    requestdata = function_9b649316adcccbaa( var_4bd3c6b05068a0f1 );
    
    if ( !isdefined( requestdata ) || requestdata.ai.size <= 0 )
    {
        return;
    }
    
    owner = requestdata.ai[ 0 ];
    
    foreach ( ai in requestdata.ai )
    {
        if ( isalive( ai ) )
        {
            owner = ai;
            break;
        }
    }
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    ob_activity_utility::function_ded5fcf7673a2ae6( owner, var_c938a1fede524680.origin, var_c938a1fede524680.angles );
    
    while ( !isdefined( level.dawgs ) )
    {
        waitframe();
    }
    
    if ( isdefined( level.dawgs ) )
    {
        foreach ( dawg in level.dawgs )
        {
            if ( distance2d( dawg.origin, var_c938a1fede524680.origin ) <= 500 )
            {
                level.var_76b0ec5ef079ba1a = dawg;
                dawg thread function_114e8002f0fd023f( dawg );
                break;
            }
        }
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x456108e4, Offset: 0x4324
// Size: 0x30
function function_114e8002f0fd023f( dawg )
{
    level endon( #"game_ended" );
    dawg waittill( #"death" );
    level.var_76b0ec5ef079ba1a = undefined;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0xcc40a8b0, Offset: 0x435c
// Size: 0x17b
function function_45d86dd0354b97ef( squad_struct, var_4bd3c6b05068a0f1, issolo )
{
    level endon( #"game_ended" );
    squad_struct endon( #"hash_9a17027044454aa5" );
    wait 20;
    requestdata = function_9b649316adcccbaa( var_4bd3c6b05068a0f1 );
    
    if ( !isdefined( requestdata ) || requestdata.ai.size <= 0 )
    {
        return;
    }
    
    remainingai = requestdata.ai.size;
    var_d4ee1427da91d23e = 2;
    
    while ( remainingai > var_d4ee1427da91d23e )
    {
        requestdata = function_9b649316adcccbaa( var_4bd3c6b05068a0f1 );
        totalai = [];
        
        foreach ( ai in requestdata.ai )
        {
            if ( function_2eb3ffb07421fa40( ai ) )
            {
                totalai[ totalai.size ] = ai;
            }
        }
        
        if ( totalai.size <= 15 )
        {
            function_ee5e6f920b374432( totalai.size + " Enemies Remaining in the wave", 1 );
        }
        else
        {
            wait 1;
        }
        
        remainingai = totalai.size;
        
        if ( isdefined( level.var_76b0ec5ef079ba1a ) )
        {
            remainingai++;
        }
        
        wait 1;
    }
    
    utility::flag_set( "colosseum_defense_wave_killed" + var_4bd3c6b05068a0f1 + squad_struct.sessionsquadid );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xbaeeb798, Offset: 0x44df
// Size: 0x76, Type: bool
function function_2eb3ffb07421fa40( agent )
{
    if ( agent.var_b4b292a00215f014 )
    {
        return false;
    }
    
    if ( isdefined( agent.vehicle ) && !isdefined( agent.var_123fa86d8e7a38ab ) )
    {
        agent.var_123fa86d8e7a38ab = gettime();
    }
    
    if ( isdefined( agent.var_123fa86d8e7a38ab ) )
    {
        if ( gettime() - agent.var_123fa86d8e7a38ab > 45000 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0xd5e369cc, Offset: 0x455e
// Size: 0x5a
function function_ee5e6f920b374432( text, duration )
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"scr_debug_aqua", 0 ) < 1 )
    {
        return;
    }
    
    for ( i = 0; i < duration ; i++ )
    {
        iprintlnbold( text );
        wait 1;
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xb1649860, Offset: 0x45c0
// Size: 0x26, Type: bool
function is_solo_player( var_1e4b67c294a4ef74 )
{
    squadmembers = function_1cf398b684dcfd81( var_1e4b67c294a4ef74 );
    return squadmembers.size <= 1;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xd0ccea92, Offset: 0x45ef
// Size: 0x92
function function_1cf398b684dcfd81( var_1e4b67c294a4ef74 )
{
    if ( !( isdefined( var_1e4b67c294a4ef74.team ) && isdefined( var_1e4b67c294a4ef74.sessionsquadid ) ) )
    {
        return [];
    }
    
    team = var_1e4b67c294a4ef74.team;
    sessionsquadid = var_1e4b67c294a4ef74.sessionsquadid;
    
    if ( !isdefined( level.squaddata[ team ][ sessionsquadid ] ) )
    {
        return [];
    }
    
    squadmembers = level.squaddata[ team ][ sessionsquadid ].players;
    return squadmembers;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0xa9e7b3af, Offset: 0x468a
// Size: 0x54
function function_74fc295528fa8a34( array, timeout )
{
    array = utility::array_removedead_or_dying( array );
    var_5c1de0abd2963073 = 0;
    
    while ( !var_5c1de0abd2963073 && array.size > 0 )
    {
        array = utility::array_removedead_or_dying( array );
        var_5c1de0abd2963073 = timeout <= 0;
        timeout--;
        wait 1;
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 4
// Checksum 0xabb84ebb, Offset: 0x46e6
// Size: 0x31
function function_3a7ea95cbf10c760( requestid, instance, agent, ai_data )
{
    agent thread debug_show_ai( agent );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xbb98baf2, Offset: 0x471f
// Size: 0xa7
function debug_show_ai( agent )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    color = ( 1, 1, 1 );
    
    /#
        while ( true )
        {
            if ( agent.agent_type && issubstr( agent.agent_type, "<dev string:xb2>" ) )
            {
                color = ( 1, 0, 0 );
            }
            
            if ( getdvarint( @"scr_debug_aqua", 0 ) )
            {
                sphere( agent.origin, 30, color, 0, 1 );
            }
            
            waitframe();
        }
    #/
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 4
// Checksum 0xbc304f9f, Offset: 0x47ce
// Size: 0x3d
function function_3179bdeeed86a40c( requestid, instance, agent, ai_data )
{
    level notify( #"colosseum_adds_unloaded" );
    agent thread behavior_followplayer( agent );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x99866d7b, Offset: 0x4813
// Size: 0x58
function ai_despawn_on_activity_destroyed()
{
    self endon( #"death" );
    level.aqua_virus_upload_activity utility::waittill_any( "activity_ended", "instance_destroyed" );
    logstring( "[Aqua Ai] ai_despawn_on_activity_destroyed(..)  called for entity: " );
    self.diequietly = 1;
    self.nocorpse = 1;
    self.damageshield = 0;
    self kill();
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xfd75a4b4, Offset: 0x4873
// Size: 0x361
function behavior_followplayer( agent )
{
    self notify( #"hash_86d108c4ebf43c5e" );
    self endon( #"hash_86d108c4ebf43c5e" );
    level endon( #"game_ended" );
    agent endon( #"death" );
    wait 2;
    
    while ( isdefined( agent.vehicle ) )
    {
        wait 1;
    }
    
    agent thread ai_despawn_on_activity_destroyed();
    desiredgoalradius = 128;
    var_80779a41a0e9d0d5 = 128;
    var_8b47817530a74089 = utility::getstructarray( "colo_defense_ai_goal", "targetname" )[ 0 ];
    
    while ( true )
    {
        if ( !isdefined( agent.agent_type ) )
        {
            desiredgoalradius = 128;
            var_80779a41a0e9d0d5 = 128;
        }
        else
        {
            switch ( agent.agent_type )
            {
                case #"hash_35426323287075f7":
                    desiredgoalradius = 550;
                    var_80779a41a0e9d0d5 = 550;
                    break;
                case #"hash_f225e5a4224c2cd1":
                    desiredgoalradius = 700;
                    var_80779a41a0e9d0d5 = 700;
                    break;
                case #"hash_da4b43b677fe967c":
                    desiredgoalradius = 700;
                    var_80779a41a0e9d0d5 = 700;
                    break;
                case #"hash_5f8798444ae19b14":
                    desiredgoalradius = 700;
                    var_80779a41a0e9d0d5 = 700;
                    break;
                case #"hash_65769757416362fc":
                    desiredgoalradius = 700;
                    var_80779a41a0e9d0d5 = 700;
                    break;
                case #"hash_7f90d78c4da0571f":
                    desiredgoalradius = 700;
                    var_80779a41a0e9d0d5 = 700;
                    break;
                case #"hash_8ebf2fd951b8d532":
                default:
                    desiredgoalradius = 64;
                    var_80779a41a0e9d0d5 = 64;
                    break;
            }
        }
        
        agent.checkstop = 0;
        agent.var_d2ae771f551eb98b = 0;
        
        if ( !issubstr( agent.agent_type, "dawg" ) )
        {
            if ( agent.stealth_enabled )
            {
                agent setstealthstate( "combat" );
            }
        }
        
        if ( distance2d( self.origin, var_8b47817530a74089.origin ) <= 1000 )
        {
            desiredgoalradius *= 1.3;
            var_80779a41a0e9d0d5 = desiredgoalradius * 1.3;
        }
        
        goalradius = desiredgoalradius;
        heightradius = var_80779a41a0e9d0d5;
        player = function_c0e273138b06742c();
        agent.goalradius = int( goalradius );
        agent.script_goalradius = goalradius;
        agent.goalheight = heightradius;
        agent.script_goalheight = heightradius;
        agent function_8b4e5edcb924d49();
        var_e7687cd7f6c0c0dc = utility::getstructarray( "colo_defense_ai_goal", "targetname" );
        
        if ( player )
        {
            agent getenemyinfo( player );
            
            if ( distance2d( self.origin, player.origin ) <= 500 )
            {
                agent ai_behavior::function_4a3c03bb49dd5d76( utility::array_random( var_e7687cd7f6c0c0dc ).origin, desiredgoalradius, 0 );
            }
            else
            {
                dist = distance2d( self.origin, player.origin );
                
                if ( dist >= 4096 )
                {
                    agent ai_behavior::function_4a3c03bb49dd5d76( utility::array_random( var_e7687cd7f6c0c0dc ).origin, desiredgoalradius, 0 );
                }
                else
                {
                    agent ai_behavior::function_4a3c03bb49dd5d76( getclosestpointonnavmesh( player.origin ), desiredgoalradius, 0 );
                }
            }
        }
        else
        {
            agent ai_behavior::function_4a3c03bb49dd5d76( utility::array_random( var_e7687cd7f6c0c0dc ).origin, desiredgoalradius, 0 );
        }
        
        wait 3;
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xedd66306, Offset: 0x4bdc
// Size: 0xa8
function function_90acb293460f5584( data )
{
    vehicle = self;
    
    if ( !isdefined( vehicle.classname_mp ) || !isdefined( data.objweapon.basename ) )
    {
        return data.damage;
    }
    
    if ( vehicle.classname_mp == "veh_sat_mil_vtol_ob_infil" && data.objweapon.basename == "sat_remote_robot_arm_gun_mp" )
    {
        data.damage += 40;
    }
    
    return data.damage;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xb0bbf38f, Offset: 0x4c8d
// Size: 0x5c
function function_c0e273138b06742c()
{
    activitystruct = get_current_activity();
    var_e7687cd7f6c0c0dc = utility::getstructarray( "colo_defense_ai_goal", "targetname" );
    
    if ( isdefined( activitystruct.playerparticipants ) )
    {
        return sortbydistance( activitystruct.playerparticipants, var_e7687cd7f6c0c0dc[ 0 ].origin )[ 0 ];
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0xb97a423a, Offset: 0x4cf2
// Size: 0x3a
function function_ebaa67bb90b9d359( requestid, squaddata )
{
    utility::flag_set( "flag_colosseum_defend_enemies_spawned" + requestid + squaddata.squad_struct.sessionsquadid );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0xb6624148, Offset: 0x4d34
// Size: 0x20, Type: bool
function function_4157852ee682139c( requestid, userdata, wavenumber )
{
    return true;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 3
// Checksum 0xd9d1b35b, Offset: 0x4d5d
// Size: 0x2d
function function_6bd522d66d806f06( requestid, userdata, shutdowndata )
{
    utility::flag_set( "colosseum_defense_wave_killed" + requestid );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x4676650e, Offset: 0x4d92
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

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xb39761e, Offset: 0x4df7
// Size: 0x26
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0xc8aa7c5e, Offset: 0x4e25
// Size: 0x74
function respawn_on_destroyed( activity, variant )
{
    level endon( #"game_ended" );
    activity_instance = self;
    activity_instance waittill( #"instance_destroyed" );
    wait 1;
    
    if ( isdefined( level.aqua_virus_info ) )
    {
        logstring( "[AquaVirus] - restarting activity from level.aqua_virus_info" );
        level ob_activity_manager::ob_activity_instance_init( level.aqua_virus_info );
        return;
    }
    
    logstring( "[AquaVirus] - FAILED to find level.aqua_virus_info" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x9c8166d5, Offset: 0x4ea1
// Size: 0xa7
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    logstring( "[AquaVirus] DESTROYING ACTIVITY " );
    
    if ( activity_instance.sam_interaction_scriptable )
    {
        activity_instance.sam_interaction_scriptable freescriptable();
        activity_instance.sam_interaction_scriptable = undefined;
    }
    
    logstring( "[AquaVirus] Cleaning up Squad Structs for Activity " );
    activity_instance.active_squads = [];
    
    if ( level.var_a6760aca843741a7 )
    {
        level ob_story_mission_utils::objective_marker_clear( level.var_a6760aca843741a7 );
        level.var_a6760aca843741a7 = undefined;
    }
    
    function_a25acb62ddab20e2( "aqua_encounter", 0 );
    setdvarifuninitialized( @"hash_f9fb0f40bb53d30d", 0 );
    activity_instance endon( #"instance_destroyed" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xdccc855f, Offset: 0x4f50
// Size: 0xf
function get_activity_center_point()
{
    return ( 0, 0, 0 );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xa179b256, Offset: 0x4f68
// Size: 0x4e
function function_470b4f0cecef4cf4( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = ( 0, 0, 0 );
    var_983974fc347bb3cb.angles = ( 0, 0, 0 );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xdb3a3a3c, Offset: 0x4fbe
// Size: 0x42
function player_joined_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    logstring( "[AquaVirus] PLAYER joined ACTIVITY - Virus Upload" );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x137bd391, Offset: 0x5008
// Size: 0x125
function player_left_activity( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    logstring( "[AquaVirus] PLAYER left ACTIVITY - Virus Upload" );
    activity_instance = self;
    
    if ( !activity_instance.playerparticipants.size )
    {
        level notify( #"hash_8ea2d5813fbf0735" );
        mission_structs = activity_instance.active_squads;
        
        foreach ( var_cd7e11dc688992d4 in mission_structs )
        {
            logstring( "[AquaVirus] Cleaning up Squad Struct in player_left_activity(..) for " + var_cd7e11dc688992d4.squad_leader.name );
            var_cd7e11dc688992d4 notify( #"completed" );
        }
        
        activity_instance.active_squads = [];
        
        if ( activity_instance_common::getactivitystate( activity_instance ) == "Active" )
        {
            activity_instance_common::endactivity( activity_instance, 0 );
        }
    }
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0xc27f19c1, Offset: 0x5135
// Size: 0xb
function get_current_activity()
{
    return level.aqua_virus_upload_activity;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 0
// Checksum 0x9a994f35, Offset: 0x5149
// Size: 0xca
function get_squad_data_global()
{
    activity = get_current_activity();
    mission_structs = activity.active_squads;
    squad_datas = [];
    
    foreach ( var_cd7e11dc688992d4 in mission_structs )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        squad_datas[ squad_datas.size ] = var_64bb57aa2d6e8b35;
    }
    
    return squad_datas;
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xc1d6b43c, Offset: 0x521c
// Size: 0x49
function function_33e0c4bb5e08c704( squad_struct )
{
    level endon( #"game_ended" );
    utility::flag_wait( "post_tablet_conversation_done" );
    player_participants = squad_struct.players;
    overlord::playconversation( "aqua_intro_kagan_conversation", player_participants );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xa4db87b7, Offset: 0x526d
// Size: 0x49
function function_d788d1f736f77059( squad_struct )
{
    if ( level.var_a65fd7a07a374921 )
    {
        return;
    }
    
    player_participants = squad_struct.players;
    level.var_a65fd7a07a374921 = 1;
    overlord::playconversation( "aqua_reach_sam_site_area_convo", player_participants );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0xd2798758, Offset: 0x52be
// Size: 0x1a
function function_be702266b5df011b( player_participants )
{
    overlord::playconversation( "aqua_interact_computer_wave_defend_begin_convo", player_participants );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 1
// Checksum 0x7ba4d68a, Offset: 0x52e0
// Size: 0x31
function function_528cadacad738ebd( squad_struct )
{
    player_participants = squad_struct.players;
    overlord::playconversation( "aqua_sam_launcher_post_defend_convo", player_participants );
}

// Namespace sat_ob_contract_aquarius_virus_upload
// Params 2
// Checksum 0x6713d11e, Offset: 0x5319
// Size: 0x88
function function_48e3efb3ea4dbc32( activity_instance, var_e50d0aed2048476b )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( activity_instance ) )
    {
        activity_instance = level.aqua_virus_upload_activity;
    }
    
    activity_instance utility::waittill_any( "activity_ended", "instance_destroyed" );
    
    if ( isent( self ) && !var_e50d0aed2048476b )
    {
        activity_instance ob_resource_manager::function_360d7e0860217cf4( self );
    }
    
    if ( isent( self ) )
    {
        self delete();
        return;
    }
    
    if ( self isscriptableinstance() )
    {
        self freescriptable();
    }
}

