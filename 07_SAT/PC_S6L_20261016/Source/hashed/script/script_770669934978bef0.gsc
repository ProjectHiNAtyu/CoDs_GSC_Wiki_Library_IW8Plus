// script_770669934978bef0  (hash_770669934978bef0.gscc) (size: 23610 Bytes / 0x5c3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6063c58f (1617151375)
// size ...... 23610 (0x5c3a)
// includes .. 26  (offset: 0x557a)
// strings ... 78  (offset: 0x564a)
// dev strs .. 8   (offset: 0x5b4a)
// exports ... 45  (offset: 0x3966)
// cseg ...... 0x691 + 0x32d5 (0x3966)
// imports ... 176 (offset: 0x406e)
// animtree1 . 1   (offset: 0x5baa)
// animtree2 . 8   (offset: 0x5bba)
#using script_599653855a4317f1;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\anim;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_intel_quest;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\infilexfil;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_safes;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;

#namespace namespace_521b355ce75f6eac;

// Namespace namespace_521b355ce75f6eac
// Params 0, eflags: 0x5
// Checksum 0x6f6fbccc, Offset: 0x6af
// Size: 0x169
function private autoexec function_48e1bdf35318cfdc()
{
    if ( !isdefined( level.searchprops ) )
    {
        level.var_2c6fc82f5f1631c6 = 1;
        level.searchprops = spawnstruct();
        level.searchprops.domradius = getdvarint( @"hash_71edffc21985cf3c", 128 );
        level.searchprops.capturetime = getdvarfloat( @"hash_44a66b39ccca38b1", 20 );
        level.searchprops.var_ae2f698d62069ad0 = getdvarfloat( @"hash_a10f5fb90206dbc", 6 );
        level.searchprops.circleradius = getdvarint( @"scr_dmz_search_circle_radius", 1000 );
        level.searchprops.circlepadding = getdvarint( @"hash_d411b19dd9e74816", 250 );
        level.searchprops.domflagmaxdist = getdvarint( @"hash_2aa1ea2e4cb8c3d2", 15000 );
        level.searchprops.rewardsintel = getdvarint( @"hash_9291026d90b23401", 0 );
        level.searchprops.var_33c2a1ad9d327e0a = getdvarint( @"hash_6e810109e7c6b4f2", 128 );
        level.searchprops.reinforcetower = getdvarint( @"hash_6e6ad32f4df0a3cd", 0 );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x7be4937d, Offset: 0x820
// Size: 0x32f
function dmztask_getspawndata( data )
{
    var_67071df2c09bcf25 = getentitylessscriptablearray( undefined, undefined, undefined, undefined, "dmz_intel_laptop" );
    level.missionitemcallbacks[ "dmz_intel_laptop" ] = &function_d124700288c2e93f;
    scriptable::scriptable_addusedcallbackbypart( "dmz_upload_station", &function_73f0d09f3b03381d );
    var_140fa937a2babda9 = utility::getstructarray( "dmz_dom_tower", "script_noteworthy" );
    
    if ( getdvarint( @"hash_698d4fdc619d5572", 1 ) )
    {
        level.domnodes = var_140fa937a2babda9;
    }
    else
    {
        level.domnodes = [];
        
        foreach ( node in var_140fa937a2babda9 )
        {
            nodepoi = node.script_poi;
            
            if ( !isdefined( nodepoi ) )
            {
                nodepoi = poi::poi_findpoioriginisin( node.origin );
            }
            
            if ( !poi::poi_issystemactive() || isdefined( nodepoi ) && poi::poi_ispoiactive( nodepoi ) && !br_dmz_radiation::function_704454416dce7454( node.origin ) && !ai_fortress::function_5428359c3c1916ac( node.origin ) )
            {
                level.domnodes[ level.domnodes.size ] = node;
            }
        }
    }
    
    if ( getdvarint( @"hash_9d58313058bb5cfd", 1 ) )
    {
        foreach ( domnode in level.domnodes )
        {
            spawnstruct() thread function_729e2914c9bab96e( domnode, level.searchprops.var_ae2f698d62069ad0 );
        }
    }
    
    level.secureintelnodes = [];
    
    foreach ( node in var_67071df2c09bcf25 )
    {
        node setscriptablepartstate( "dmz_intel_laptop", "actually_hidden" );
        var_6aebb408c22f1917 = utility::get_array_of_closest( node.origin, level.domnodes, undefined, undefined, level.searchprops.domflagmaxdist );
        
        if ( !( isdefined( var_6aebb408c22f1917 ) && isdefined( var_6aebb408c22f1917[ 0 ] ) ) )
        {
            continue;
        }
        
        node.domnode = var_6aebb408c22f1917[ 0 ];
        level.secureintelnodes[ level.secureintelnodes.size ] = node;
    }
    
    /#
        level thread function_ae2cd924812a4e81();
    #/
    
    activity_manager::function_f61a1f535aab4194( data, &function_1fb3945fc10821b3, level.secureintelnodes );
}

/#

    // Namespace namespace_521b355ce75f6eac
    // Params 0
    // Checksum 0x81637a5, Offset: 0xb57
    // Size: 0x16, Type: dev
    function function_746bdfc760ec9b18()
    {
        return utility::getstructarray( "<dev string:x24>", "<dev string:x32>" );
    }

#/

#using_animtree( "script_model" );

// Namespace namespace_521b355ce75f6eac
// Params 0, eflags: 0x5
// Checksum 0x57aed017, Offset: 0xb75
// Size: 0x2dc
function private autoexec function_67c4a3dfafbe5b73()
{
    level.scr_animtree[ "upload_station_player" ] = #animtree;
    level.scr_anim[ "upload_station_player" ][ "upload_station_enter" ] = %rex_dmz_uploadstation_enter_sdr;
    level.scr_eventanim[ "upload_station_player" ][ "upload_station_enter" ] = %"upload_station_enter";
    level.scr_viewmodelanim[ "upload_station_player" ][ "upload_station_enter" ] = "rex_dmz_uploadstation_enter_sdr";
    level.scr_anim[ "upload_station_player" ][ "upload_station_type" ] = %rex_dmz_uploadstation_type_sdr;
    level.scr_eventanim[ "upload_station_player" ][ "upload_station_type" ] = %"upload_station_type";
    level.scr_viewmodelanim[ "upload_station_player" ][ "upload_station_type" ] = "rex_dmz_uploadstation_type_sdr";
    level.scr_anim[ "upload_station_player" ][ "upload_station_exit" ] = %rex_dmz_uploadstation_exit_sdr;
    level.scr_eventanim[ "upload_station_player" ][ "upload_station_exit" ] = %"upload_station_exit";
    level.scr_viewmodelanim[ "upload_station_player" ][ "upload_station_exit" ] = "rex_dmz_uploadstation_exit_sdr";
    level.scr_anim[ "upload_station_player" ][ "upload_station_exit_cancel" ] = %rex_dmz_uploadstation_exit_cancel_sdr;
    level.scr_eventanim[ "upload_station_player" ][ "upload_station_exit_cancel" ] = %"upload_station_exit_cancel";
    level.scr_viewmodelanim[ "upload_station_player" ][ "upload_station_exit_cancel" ] = "rex_dmz_uploadstation_exit_cancel_sdr";
    level.scr_anim[ "upload_station_harddrive" ][ "upload_station_enter" ] = %rex_dmz_uploadstation_enter_hdd;
    level.scr_eventanim[ "upload_station_harddrive" ][ "upload_station_enter" ] = %"upload_station_enter";
    level.scr_viewmodelanim[ "upload_station_harddrive" ][ "upload_station_enter" ] = "rex_dmz_uploadstation_enter_hdd";
    level.scr_anim[ "upload_station_harddrive" ][ "upload_station_type" ] = %rex_dmz_uploadstation_type_hdd;
    level.scr_eventanim[ "upload_station_harddrive" ][ "upload_station_type" ] = %"upload_station_type";
    level.scr_viewmodelanim[ "upload_station_harddrive" ][ "upload_station_type" ] = "rex_dmz_uploadstation_type_hdd";
    level.scr_anim[ "upload_station_harddrive" ][ "upload_station_exit" ] = %rex_dmz_uploadstation_exit_hdd;
    level.scr_eventanim[ "upload_station_harddrive" ][ "upload_station_exit" ] = %"upload_station_exit";
    level.scr_viewmodelanim[ "upload_station_harddrive" ][ "upload_station_exit" ] = "rex_dmz_uploadstation_exit_hdd";
    level.scr_anim[ "upload_station_harddrive" ][ "upload_station_exit_cancel" ] = %rex_dmz_uploadstation_exit_cancel_hdd;
    level.scr_eventanim[ "upload_station_harddrive" ][ "upload_station_exit_cancel" ] = %"upload_station_exit_cancel";
    level.scr_viewmodelanim[ "upload_station_harddrive" ][ "upload_station_exit_cancel" ] = "rex_dmz_uploadstation_exit_cancel_hdd";
}

// Namespace namespace_521b355ce75f6eac
// Params 2
// Checksum 0x70d6a34f, Offset: 0xe59
// Size: 0x12c
function function_1fb3945fc10821b3( activity, node )
{
    task = dmz_task_utils::task_create( activity );
    task.funcs[ "onInit" ] = &function_839ac63123da60dc;
    task.funcs[ "onTeamAssigned" ] = &function_d459023bf2250b87;
    task.funcs[ "onPlayerJoined" ] = &function_eb3dd9a84b1ec9ee;
    task.funcs[ "onPlayerRemoved" ] = &function_3f632826b1f550b5;
    task.funcs[ "onTeamStart" ] = &function_7bb400ebffb83065;
    task.funcs[ "onCancel" ] = &function_4044f003607241bc;
    task.ref = "dmz_domination_explore";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.node = node;
    
    if ( !isdefined( level.var_d1235b1b94e9dae1 ) )
    {
        level.var_d1235b1b94e9dae1 = 0;
    }
    
    task.assignmentname = "domMission" + level.var_d1235b1b94e9dae1;
    level.var_d1235b1b94e9dae1++;
    return task;
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0x275306ca, Offset: 0xf8e
// Size: 0x2c0
function function_839ac63123da60dc()
{
    self.item = self.node;
    self.item.task = self;
    self.item setscriptablepartstate( "dmz_intel_laptop", "unusable" );
    self.item.harddrive = spawnscriptable( "dmz_intel_harddrive", self.item.origin, self.item.angles );
    self.numagents = 0;
    self.domnode = self.node.domnode;
    self.questcircles = [];
    
    if ( !isdefined( self.domnode ) || ai_fortress::function_5428359c3c1916ac( self.item.origin ) )
    {
        dmz_task_utils::task_ended();
        return;
    }
    
    self.activity.origin = self.item.origin;
    
    if ( self.domnode.setup )
    {
        self.domflag = self.domnode.flag;
        self.domflag.tasks[ self.domflag.tasks.size ] = self;
    }
    else
    {
        thread function_729e2914c9bab96e( self.domnode, level.searchprops.var_ae2f698d62069ad0 );
    }
    
    self.unlocked = 0;
    circlelocation = dmz_task_utils::function_c7ccd46fc59f189d( self.item.origin, level.searchprops.circleradius );
    self.circlecenter = circlelocation;
    self.circleradius = level.searchprops.circleradius;
    dmz_task_utils::function_13fe84cb824c72a8( "Explore_Dmz", [ circlelocation ], level.searchprops.circleradius + level.searchprops.circlepadding );
    self.curorigin = circlelocation;
    self.offset3d = ( 0, 0, 50 );
    dmz_task_utils::function_b3476f99a8e21fa2( circlelocation + ( 0, 0, 750 ), "intel" );
    
    /#
        dmz_logging::addlogevent( "<dev string:x44>", self.activity.name, undefined, "<dev string:x56>", undefined, undefined, self.activity.script_poi, self.node.origin );
    #/
}

// Namespace namespace_521b355ce75f6eac
// Params 2
// Checksum 0x349d909d, Offset: 0x1256
// Size: 0x227
function function_729e2914c9bab96e( node, var_ae2f698d62069ad0 )
{
    if ( !isdefined( self.domflag ) )
    {
        self.domflag = spawnscriptable( "dmz_upload_station", node.origin, node.angles );
    }
    
    self.domflag.script_poi = poi::poi_findpoioriginisin( node.origin, 1 );
    
    if ( isdefined( self.activity ) )
    {
        /#
            dmz_logging::addlogevent( "<dev string:x6c>", self.activity.name, undefined, "<dev string:x7d>", undefined, undefined, self.activity.script_poi, node.origin );
        #/
    }
    
    domradius = function_a69bda1b50243281();
    self.domflag.trigger = spawn( "trigger_radius", node.origin, 0, int( domradius ), int( domradius ) );
    
    if ( isdefined( self.activity ) )
    {
        /#
            dmz_logging::addlogevent( "<dev string:x90>", self.activity.name, undefined, "<dev string:x9d>", undefined, undefined, self.activity.script_poi, node.origin );
        #/
    }
    
    self.domflag.trigger utility::trigger_on();
    self.domflag.playersintrigger = [];
    self.domflag thread domflag_watchtrigger();
    self.domflag.var_ae2f698d62069ad0 = var_ae2f698d62069ad0;
    self.domflag.teamsusing = [];
    self.domflag.tasks = [ self ];
    node.setup = 1;
    node.flag = self.domflag;
    node.trigger = self.domflag.trigger;
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0xeccbc18b, Offset: 0x1485
// Size: 0xc
function function_7bb400ebffb83065( teamname )
{
    
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x5053f568, Offset: 0x1499
// Size: 0x44
function function_eb3dd9a84b1ec9ee( player )
{
    objidpoolmanager::objective_playermask_addshowplayer( self.icon, player );
    
    if ( !self.unlocked )
    {
        dmz_task_utils::function_6277bd2a0d5a28b9( player );
        self.item enablescriptableplayeruse( player );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0xbdddec83, Offset: 0x14e5
// Size: 0x44
function function_3f632826b1f550b5( player )
{
    objidpoolmanager::objective_playermask_hidefrom( self.icon, player );
    
    if ( !self.unlocked )
    {
        dmz_task_utils::function_1f01bb1108ba0241( player );
        self.item disablescriptableplayeruse( player );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0xbd6c23a6, Offset: 0x1531
// Size: 0x1cd
function function_d459023bf2250b87( teamname )
{
    dmz_task_utils::function_18b83232055b1325( teamname );
    thread function_c01220e3266a3b33( teamname );
    
    if ( br_gametype_dmz::function_e6d940bc5935f1ba() )
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"secure_intel_assigned_generic", teamname );
    }
    else
    {
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"secure_intel_assigned", teamname );
    }
    
    dmz_task_utils::task_showsplashtoteam( "dmz_dom_assigned", teamname );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_start", 1.5, "dmz_activity_start_classic" );
    self.item setscriptablepartstate( "dmz_intel_laptop", "usable" );
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in level.players )
    {
        self.item disablescriptableplayeruse( player );
    }
    
    foreach ( player in players )
    {
        self.item enablescriptableplayeruse( player );
    }
    
    if ( !isdefined( self.canreinforce ) )
    {
        self.canreinforce = 1;
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0xbca24bc5, Offset: 0x1706
// Size: 0xb9
function function_4044f003607241bc( teamname )
{
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        if ( isdefined( self.item ) )
        {
            self.item disablescriptableplayeruse( player );
        }
    }
    
    function_d1b64cc585b2c96d( players );
    dmz_task_utils::task_ended();
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0xc9adcfcb, Offset: 0x17c7
// Size: 0x109
function function_d1b64cc585b2c96d( playersonteam )
{
    if ( isdefined( playersonteam ) )
    {
        foreach ( player in playersonteam )
        {
            objidpoolmanager::function_6ac40386d1cd0d9a( self.icon, player );
        }
    }
    
    dmz_task_utils::function_e23cad864e9e2023();
    dmz_task_utils::function_3ff46488beb193c7();
    self.domflag setscriptablepartstate( "upload_screen", "screen_off" );
    
    if ( game_utility::getgametype() != "dmz" )
    {
        br_intel_quest::intel_resetusability( self.domflag, self.teams[ 0 ] );
    }
    
    self.domflag.tasks = arrayremove( self.domflag.tasks, self );
}

// Namespace namespace_521b355ce75f6eac
// Params 1, eflags: 0x4
// Checksum 0x4a59bd2d, Offset: 0x18d8
// Size: 0xc6
function private function_f38edbbd54ec483( teamname )
{
    playersonteam = teams::getteamdata( teamname, "players" );
    function_d1b64cc585b2c96d( playersonteam );
    thread function_69102611d209d1d2( teamname, self.domflag.origin );
    dmz_task_utils::function_e533421ccebd7d79( teamname );
    dmz_task_utils::function_c64a66646904bc1( "dmz_upload_complete", "dom", self.activity.cashreward, teamname );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"secure_intel_win", teamname, 1 );
    dmz_audio::function_32ff837bc21a4833( teamname, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    waitframe();
    dmz_task_utils::task_ended( teamname, 1 );
}

// Namespace namespace_521b355ce75f6eac
// Params 2, eflags: 0x4
// Checksum 0x8a975a6b, Offset: 0x19a6
// Size: 0xe2
function private function_d124700288c2e93f( struct, player )
{
    instance = struct.instance;
    
    if ( function_2c0b95598e6e9806( instance, player ) )
    {
        task = instance.task;
        team = task.teams[ 0 ];
        task dmz_task_utils::function_844c661c74b52ce3( "dmz_domination" );
        task dmz_task_utils::task_showsplashtoteam( "dmz_located_intel", team );
        dmz_audio::function_32ff837bc21a4833( team, "dmz_activity_action", 1.5, "dmz_activity_action_classic" );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"secure_intel_found", team );
        
        if ( level.searchprops.reinforcetower )
        {
            task thread function_8e89d2c05d749ea2();
        }
        
        return 1;
    }
    
    return 2;
}

// Namespace namespace_521b355ce75f6eac
// Params 2
// Checksum 0x366ffde8, Offset: 0x1a91
// Size: 0x246, Type: bool
function function_2c0b95598e6e9806( instance, player )
{
    task = instance.task;
    
    if ( isdefined( task ) && task.teams[ 0 ] == player.team )
    {
        instance setscriptablepartstate( "dmz_intel_laptop", "hidden" );
        instance.harddrive setscriptablepartstate( "dmz_intel_harddrive", "closing" );
        players = teams::getteamdata( player.team, "players" );
        
        foreach ( player in players )
        {
            player setclientomnvar( "ui_hard_drive_taken", 1 );
        }
        
        instance.harddrive thread function_5fe7633a1bab4cc7();
        level thread function_5be716c624c7430( players );
        team = task.teams[ 0 ];
        task notify( #"item_found" );
        task.unlocked = 1;
        task dmz_task_utils::function_e23cad864e9e2023();
        objective_position( task.icon, task.domflag.origin + ( 0, 0, 50 ) );
        task dmz_task_utils::function_c74c010e593f5ea5( task.domflag.origin + ( 0, 0, 75 ) );
        
        foreach ( player in teams::getteamdata( team, "players" ) )
        {
            task.domflag enablescriptableplayeruse( player );
        }
        
        task thread function_156d6b9387c037ac();
        return true;
    }
    
    return false;
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0x4d84e3de, Offset: 0x1ce0
// Size: 0x1a
function function_5fe7633a1bab4cc7()
{
    level endon( #"game_ended" );
    wait 1;
    self freescriptable();
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0xe5e62a09, Offset: 0x1d02
// Size: 0x9a
function function_5be716c624c7430( players )
{
    level endon( #"game_ended" );
    wait 1.25;
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( "ui_hard_drive_taken", 0 );
        }
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0xa22130a4, Offset: 0x1da4
// Size: 0xfb
function function_8e89d2c05d749ea2()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    var_1801a281e7c1576c = 10;
    var_7736c99632c61ac2 = utility::function_f754506ecfae9afb( self.domflag.origin + ( 0, 0, -1000 ), 2500, undefined, 3000, 0 ).size;
    nearbyagents = [];
    
    while ( var_7736c99632c61ac2 < var_1801a281e7c1576c )
    {
        nearbyagents = ai_reinforcements::function_d0a9530035c6dc35( self.domflag.origin, 4000, undefined, var_1801a281e7c1576c - var_7736c99632c61ac2 );
        var_7736c99632c61ac2 += nearbyagents.size;
        
        if ( var_7736c99632c61ac2 >= var_1801a281e7c1576c )
        {
            return;
        }
        
        ai_reinforcements::reinforce_requestreinforcements( 5, self.domflag.origin, "high", "mission", "domReinforcements", undefined, undefined, 1, self.node.script_poi );
        var_7736c99632c61ac2 += 5;
        wait randomfloatrange( 22, 28 );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 2
// Checksum 0x53e495ed, Offset: 0x1ea7
// Size: 0x35c
function function_c01220e3266a3b33( team, ignoreheight )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self endon( #"item_found" );
    var_33c2a1ad9d327e0a = function_40d1bd53ff1c803f();
    var_9c5200005cb4151e = var_33c2a1ad9d327e0a * var_33c2a1ad9d327e0a;
    intel = function_e512e2beedc00557();
    wait 5;
    
    if ( isdefined( self.icon ) )
    {
        objective_setplayintro( self.icon, 0 );
    }
    
    var_84d186a5002a15b3 = 0;
    
    while ( true )
    {
        wait 1;
        players = teams::getteamdata( team, "players" );
        objective_showtoplayersinmask( self.icon );
        var_84d186a5002a15b3 = 0;
        var_880608bcacd722e2 = 0;
        
        foreach ( player in players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( ignoreheight )
            {
                var_880608bcacd722e2 = distance2dsquared( player.origin, intel.origin );
            }
            else
            {
                var_880608bcacd722e2 = distancesquared( player.origin, intel.origin );
            }
            
            if ( var_880608bcacd722e2 < var_9c5200005cb4151e )
            {
                var_84d186a5002a15b3 = 1;
                break;
            }
        }
        
        if ( var_84d186a5002a15b3 )
        {
            objective_setplayintro( self.icon, 1 );
            objective_position( self.icon, intel.origin + ( 0, 0, 10 ) );
            
            foreach ( player in players )
            {
                if ( !player player::isreallyalive() )
                {
                    continue;
                }
                
                objective_addclienttomask( self.icon, player );
            }
            
            continue;
        }
        
        objective_setplayintro( self.icon, 0 );
        objective_position( self.icon, self.circlecenter + ( 0, 0, 750 ) );
        
        foreach ( player in players )
        {
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            var_21086fe9aa7e3c07 = distance2dsquared( player.origin, self.circlecenter );
            
            if ( var_21086fe9aa7e3c07 <= self.circleradius * self.circleradius )
            {
                objective_removeclientfrommask( self.icon, player );
                continue;
            }
            
            objective_addclienttomask( self.icon, player );
        }
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0xa245f2cc, Offset: 0x220b
// Size: 0x172
function function_156d6b9387c037ac()
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    approachdistsq = 1000000;
    
    if ( isdefined( level.s_intel_quest ) && isdefined( level.s_intel_quest.var_8c379cbd8b081e4e ) )
    {
        approachdistsq = level.s_intel_quest.var_8c379cbd8b081e4e;
    }
    
    while ( true )
    {
        players = teams::getteamdata( self.teams[ 0 ], "players" );
        
        foreach ( player in players )
        {
            distsq = distance2dsquared( player.origin, self.domflag.origin );
            
            if ( distsq < approachdistsq )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"secure_intel_near_uav", players );
                dmz_audio::function_32ff837bc21a4833( self.teams[ 0 ], "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 6
// Checksum 0x1a49dd44, Offset: 0x2385
// Size: 0x170
function function_73f0d09f3b03381d( instance, part, state, useplayer, bautouse, usestring )
{
    if ( isdefined( instance.animatingplayer ) || !isdefined( useplayer.team ) || isdefined( instance.teamsusing[ useplayer.team ] ) )
    {
        useplayer hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return;
    }
    
    if ( useplayer isthrowinggrenade() || useplayer isswitchingweapon() || isdefined( useplayer getheldoffhand() ) && !isnullweapon( useplayer getheldoffhand() ) )
    {
        if ( isdefined( level.showerrormessagefunc ) && isdefined( level.br_pickups.var_e42dab6eb0ce5dec ) )
        {
            useplayer [[ level.showerrormessagefunc ]]( level.br_pickups.var_e42dab6eb0ce5dec );
        }
        
        return;
    }
    
    playertask = activity_manager::function_a7c6aab0d0a8ba71( useplayer );
    
    if ( isdefined( playertask ) && isdefined( instance.tasks ) && playertask.unlocked && arraycontains( instance.tasks, playertask ) )
    {
        thread function_4e8dc6340f8b0f35( instance, part, state, useplayer, bautouse, usestring );
        return;
    }
    
    callback::callback( "use_upload_station", { #player:useplayer } );
}

// Namespace namespace_521b355ce75f6eac
// Params 6
// Checksum 0xd7ef74d, Offset: 0x24fd
// Size: 0x23d
function function_4e8dc6340f8b0f35( instance, part, state, useplayer, bautouse, usestring )
{
    function_b1e769b9f6511f3( instance, useplayer );
    
    if ( instance.successfuluse )
    {
        playertask = undefined;
        
        foreach ( task in instance.tasks )
        {
            if ( dmz_task_utils::function_be01e8d1cf19ccbc( task, useplayer ) )
            {
                playertask = task;
                break;
            }
        }
        
        if ( isdefined( playertask ) )
        {
            if ( game_utility::getgametype() != "dmz" )
            {
                level thread br_public::brleaderdialogteamexcludeplayer( "mission_intel_upload", useplayer.team, useplayer, 1, undefined, 2, undefined, "dx_br_jpbm_" );
                level thread br_public::brleaderdialogplayer( "mission_intel_upload_first_person", useplayer, 1, undefined, 2, undefined, "dx_br_jpbm_" );
                
                if ( getdvarint( @"hash_91fb20e61355309f", 1 ) == 1 )
                {
                    level thread br_contract_manager::utilflare_shootflare( instance.origin, "dom" );
                }
                
                playertask thread br_intel_quest::function_de65d168129f33b1( useplayer.team, playertask.domflag, playertask.objidnum, playertask.icon );
                objidpoolmanager::objective_teammask_addtomask( playertask.icon, useplayer.team );
                playertask thread domflag_update( playertask.team, playertask.domflag, playertask.icon );
            }
            else
            {
                playertask thread domflag_update( playertask.teams[ 0 ], playertask.domflag, playertask.icon );
            }
        }
        else
        {
            useplayer hud_message::showerrormessage( %"dmz/upload_station_use_err" );
        }
        
        return;
    }
    
    if ( game_utility::getgametype() != "dmz" )
    {
        br_intel_quest::intel_resetusability( instance );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 4
// Checksum 0xc7b6927a, Offset: 0x2742
// Size: 0xea
function function_b1e769b9f6511f3( instance, useplayer, partname = "dmz_upload_station", usablestate = "usable" )
{
    instance setscriptablepartstate( partname, "unusable" );
    instance.successfuluse = 0;
    instance.animatedplayer = useplayer;
    instance function_f5283ce77421dc8b( useplayer );
    
    if ( isdefined( instance.animstruct ) && isdefined( instance.animstruct.harddrive ) )
    {
        instance.animstruct.harddrive delete();
    }
    
    instance.animatedplayer = undefined;
    instance setscriptablepartstate( partname, usablestate );
    
    if ( game_utility::getgametype() != "dmz" )
    {
        br_intel_quest::intel_resetusability( instance, useplayer.team );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x1cea82f3, Offset: 0x2834
// Size: 0x103
function function_f5283ce77421dc8b( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_interrupt" );
    thread dmztask_watchplayerdeathordisconnect( player );
    function_a56f80fd3d95356( player );
    thread function_b6ce750c9e1c8a9f( player );
    function_5c965283d6112f4e( player );
    
    if ( self.successfuluse )
    {
        function_90e08d6f571ac935( player );
    }
    else
    {
        function_423abdc50db1bf83( player );
    }
    
    if ( player::isreallyalive( player ) )
    {
        player notify( #"interact_finished" );
    }
    
    if ( isdefined( self.animstruct ) && isdefined( self.animstruct.harddrive ) )
    {
        self.animstruct.harddrive delete();
    }
    
    waitframe();
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( isdefined( player ) )
    {
        player notify( #"remove_rig" );
        
        if ( player::isreallyalive( player ) )
        {
            player dmz_safes::function_c0786622eaa1eac1( 1 );
        }
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x4189baf2, Offset: 0x293f
// Size: 0x2f7
function function_a56f80fd3d95356( player )
{
    player dmz_safes::function_c0786622eaa1eac1( 0 );
    playerviewangles = player getplayerangles();
    player.linktoent = player utility::spawn_tag_origin( player.origin, player.playerviewangles );
    player playerlinktodelta( player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 0, 1 );
    anglesrotated = self.angles + ( 0, 180, 0 );
    goalpos = self.origin + rotatevector( ( -37, 0.9, 3.5 ), anglesrotated );
    forward = anglestoforward( anglesrotated );
    up = ( 0, 0, 1 );
    right = vectorcross( forward, up );
    goalangles = axistoangles( forward, right, up );
    movetotime = 0.5;
    player.linktoent moveto( goalpos, movetotime, 0.1, 0.1 );
    player.linktoent rotateto( goalangles, movetotime, 0.1, 0.1 );
    player setstance( "stand" );
    var_a0892d74cbac4dc7 = gettime();
    player inventory_utility::givegunlessweapon();
    var_1cf22deb50656964 = gettime();
    var_ed2a546b70aa8095 = movetotime - ( var_1cf22deb50656964 - var_a0892d74cbac4dc7 ) / 1000;
    waittime = max( 0, var_ed2a546b70aa8095 );
    wait waittime;
    dmz_audio::function_32ff837bc21a4833( player.team, undefined, 0.5 );
    player setorigin( goalpos );
    player setplayerangles( goalangles );
    player thread infilexfil::infil_player_rig_updated( "upload_station_player", player.origin, player.angles );
    player.player_rig showonlytoplayer( player );
    animstruct = spawnstruct();
    animstruct.origin = goalpos;
    animstruct.angles = anglesrotated;
    animstruct.harddrive = spawn( "script_model", self.origin );
    animstruct.harddrive setmodel( "misc_hard_drive_v0_rig" );
    animstruct.harddrive show();
    animstruct.harddrive useanimtree( #animtree );
    animstruct.harddrive.animname = "upload_station_harddrive";
    self.animstruct = animstruct;
    self.animstruct thread anim_mp::anim_player_solo( player, player.player_rig, "upload_station_enter" );
    self.animstruct animation::anim_single_solo( self.animstruct.harddrive, "upload_station_enter" );
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x79104bcf, Offset: 0x2c3e
// Size: 0xd0
function function_b6ce750c9e1c8a9f( player )
{
    player endon( #"disconnect" );
    player endon( #"interact_interrupt" );
    waitframe();
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommand( "interact_cancelled", "+weapnext" );
    }
    
    self.cancel = 0;
    msg = player utility::waittill_any_timeout( self.var_ae2f698d62069ad0, "interact_cancelled" );
    self.cancel = 1;
    
    if ( !isbot( player ) )
    {
        player notifyonplayercommandremove( "interact_cancelled", "+weapnext" );
    }
    
    if ( msg == "interact_cancelled" )
    {
        self.successfuluse = 0;
    }
    else
    {
        self.successfuluse = 1;
        player notify( #"hash_84e77c8027679f26" );
    }
    
    self notify( #"stop_loop" );
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x4800af4d, Offset: 0x2d16
// Size: 0xba
function dmztask_watchplayerdeathordisconnect( player )
{
    player endon( #"interact_finished" );
    linktoent = player.linktoent;
    player utility::waittill_any( "death_or_disconnect", "enter_live_ragdoll", "last_stand_enter" );
    
    if ( !isdefined( player ) )
    {
        if ( isdefined( linktoent ) )
        {
            linktoent delete();
        }
        
        return;
    }
    
    player notify( #"interact_interrupt" );
    player stopanimscriptsceneevent();
    
    if ( isdefined( player.linktoent ) )
    {
        player unlink();
        player.linktoent delete();
        player.linktoent = undefined;
    }
    
    player notify( #"remove_rig" );
    player dmz_safes::function_c0786622eaa1eac1( 1 );
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0xfa9e4a39, Offset: 0x2dd8
// Size: 0x95
function function_5c965283d6112f4e( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"hash_84e77c8027679f26" );
    player endon( #"interact_cancelled" );
    
    if ( player::isreallyalive( player ) )
    {
        self.animstruct thread anim_mp::anim_player_solo( player, player.player_rig, "upload_station_type" );
        self.animstruct animation::anim_single_solo( self.animstruct.harddrive, "upload_station_type" );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x6cc74192, Offset: 0x2e75
// Size: 0x95
function function_90e08d6f571ac935( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_interrupt" );
    player endon( #"interact_cancelled" );
    
    if ( player::isreallyalive( player ) )
    {
        self.animstruct thread anim_mp::anim_player_solo( player, player.player_rig, "upload_station_exit" );
        self.animstruct animation::anim_single_solo( self.animstruct.harddrive, "upload_station_exit" );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x679ad7bf, Offset: 0x2f12
// Size: 0x88
function function_423abdc50db1bf83( player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"enter_live_ragdoll" );
    player endon( #"interact_interrupt" );
    
    if ( player::isreallyalive( player ) )
    {
        self.animstruct thread anim_mp::anim_player_solo( player, player.player_rig, "upload_station_exit_cancel" );
        self.animstruct animation::anim_single_solo( self.animstruct.harddrive, "upload_station_exit_cancel" );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 4
// Checksum 0xc5e57c49, Offset: 0x2fa2
// Size: 0x52
function domflag_update( team, domflag, objidnum, durationoverride )
{
    domflag.teamsusing[ team ] = objidnum;
    domflag_updateinternal( team, domflag, objidnum, durationoverride );
    domflag.teamsusing[ team ] = undefined;
}

// Namespace namespace_521b355ce75f6eac
// Params 4, eflags: 0x4
// Checksum 0x4ab8d3ad, Offset: 0x2ffc
// Size: 0x301
function private domflag_updateinternal( team, domflag, objidnum, durationoverride )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    self.uploading = 1;
    objective_setpinned( objidnum, 1 );
    domflag setscriptablepartstate( "upload_screen", "screen_on" );
    playersonteam = teams::getteamdata( team, "players" );
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"secure_intel_uploading", playersonteam );
    dmz_audio::function_32ff837bc21a4833( team, undefined, 0 );
    timer = 0;
    duration = function_cca63f76babcf1a2() * 1000;
    
    if ( isdefined( durationoverride ) )
    {
        duration = durationoverride;
    }
    
    while ( true )
    {
        count = 0;
        
        foreach ( player in domflag.playersintrigger )
        {
            if ( team == player.team )
            {
                objidpoolmanager::function_72efeaceb614613a( objidnum, player, 2, 2, &"dmz/upload_station_progress" );
                
                if ( self.category == "intel" )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( objidnum, player );
                }
                
                count++;
            }
        }
        
        if ( count > 0 )
        {
            if ( self.category == "intel" && !self.var_6472f484147d1cab )
            {
                self.var_6472f484147d1cab = 1;
                br_contract_manager::function_9fe564137142e8ee( 1 );
            }
            
            var_5d1f53051ff9c230 = getdvarfloat( @"hash_93243ddce42d0f81", 1 );
            var_2c0804422a8e5842 = 0;
            
            if ( level.maxteamsize > 1 )
            {
                var_2c0804422a8e5842 = var_5d1f53051ff9c230 / ( level.maxteamsize - 1 );
            }
            
            capturerate = 1 + ( count - 1 ) * var_2c0804422a8e5842;
            timer += level.frameduration * capturerate;
            progress = timer / duration;
            progress = clamp( progress, 0, 1 );
            
            if ( timer < duration )
            {
                objective_setprogress( objidnum, progress );
                domflag play_spotrep_capture_sfx( progress, team );
            }
            else
            {
                self.capturingplayer = domflag.playersintrigger[ 0 ];
                
                if ( isdefined( self.var_d547d33bbddbbf47 ) )
                {
                    [[ self.var_d547d33bbddbbf47 ]]( team );
                }
                else
                {
                    function_f38edbbd54ec483( team );
                }
                
                self.uploading = 0;
                break;
            }
        }
        else if ( self.category == "intel" && self.var_6472f484147d1cab )
        {
            self.var_6472f484147d1cab = 0;
            br_contract_manager::function_9fe564137142e8ee( 0 );
        }
        
        waitframe();
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0x233461e5, Offset: 0x3305
// Size: 0x8a
function domflag_watchtrigger()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) || arraycontains( self.playersintrigger, player ) )
        {
            continue;
        }
        
        if ( !arraycontains( self.playersintrigger, player ) )
        {
            self.playersintrigger[ self.playersintrigger.size ] = player;
            thread function_fcdaddadd71126f8( player );
        }
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 1
// Checksum 0x545a7633, Offset: 0x3397
// Size: 0x219
function function_fcdaddadd71126f8( player )
{
    level endon( #"game_ended" );
    domradius = function_a69bda1b50243281();
    domradiussq = domradius * domradius;
    
    while ( isalive( player ) && isdefined( self.trigger ) && distancesquared( self.trigger.origin, player.origin ) < domradiussq )
    {
        waitframe();
    }
    
    if ( isdefined( player ) )
    {
        foreach ( team, objicon in self.teamsusing )
        {
            if ( isdefined( objicon ) && team == player.team )
            {
                if ( self.tasks.size > 0 )
                {
                    foreach ( task in self.tasks )
                    {
                        if ( task.category == "intel" )
                        {
                            if ( isdefined( task.team ) )
                            {
                                if ( task.team == player.team )
                                {
                                    objidpoolmanager::objective_playermask_hidefrom( objicon, player );
                                    objidpoolmanager::function_beebd729a49b6cc3( player );
                                    break;
                                }
                            }
                        }
                    }
                    
                    continue;
                }
                
                objidpoolmanager::function_6ac40386d1cd0d9a( objicon, player );
                break;
            }
        }
        
        self.playersintrigger = arrayremove( self.playersintrigger, player );
        return;
    }
    
    self.playersintrigger = function_5713d46873b29625( self.playersintrigger );
}

// Namespace namespace_521b355ce75f6eac
// Params 2
// Checksum 0x58045a3d, Offset: 0x35b8
// Size: 0xb3
function play_spotrep_capture_sfx( progress, team )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
    {
        self.lastsfxplayedtime = gettime();
    }
    
    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        var_8eb35fb703d61a67 = "";
        progress = int( floor( progress * 10 ) );
        
        if ( getprojectname() == "T10" || getprojectname() == "WZ2" )
        {
            var_8eb35fb703d61a67 = "uin_cer_cappoint_tick_0" + progress;
        }
        else
        {
            var_8eb35fb703d61a67 = "mp_dom_capturing_tick_0" + progress;
        }
        
        self.trigger playsoundtoteam( var_8eb35fb703d61a67, team );
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 3
// Checksum 0x572f6a1a, Offset: 0x3673
// Size: 0xa1
function domflag_setdomscriptablepartstate( part, state, statemod )
{
    switch ( state )
    {
        case #"hash_1c39674e5b0de0f3":
        case #"hash_3699ac6c262c25ea":
        case #"hash_86bf1a776a7c4cbe":
            return 0;
        default:
            state = "using";
            
            if ( isdefined( statemod ) )
            {
                state += statemod;
            }
            
            self.scriptable setscriptablepartstate( part, state );
            
            if ( part == "pulse" )
            {
                self.scriptable setscriptablepartstate( "flag", state );
            }
            
            return 1;
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 2
// Checksum 0x51219419, Offset: 0x371c
// Size: 0xbe
function function_69102611d209d1d2( team, origin )
{
    wait 4;
    players = teams::getteamdata( team, "players" );
    
    if ( players.size > 0 && utility::issharedfuncdefined( #"hash_4dec7d3fa4499fe0", #"revealbosslocation" ) )
    {
        closestplayer = function_47c86977a18df38b( players, origin );
        var_c74ff0429b804166 = br_instance_inventory::function_f27d28bab3135f68( team, 20 );
        
        for ( i = 0; i < 1 + var_c74ff0429b804166 ; i++ )
        {
            level thread [[ utility::getsharedfunc( #"hash_4dec7d3fa4499fe0", #"revealbosslocation" ) ]]( closestplayer, 1, origin );
            wait 5;
        }
    }
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0x2afbccad, Offset: 0x37e2
// Size: 0x36
function function_a69bda1b50243281()
{
    if ( isdefined( level.s_intel_quest ) )
    {
        return level.s_intel_quest.var_95b43750f7c61cde;
    }
    
    return level.searchprops.domradius;
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0x2dcaa6c2, Offset: 0x3821
// Size: 0x36
function function_cca63f76babcf1a2()
{
    if ( isdefined( level.s_intel_quest ) )
    {
        return level.s_intel_quest.domcapturetime;
    }
    
    return level.searchprops.capturetime;
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0x47932ee0, Offset: 0x3860
// Size: 0x36
function function_40d1bd53ff1c803f()
{
    if ( isdefined( level.s_intel_quest ) )
    {
        return level.s_intel_quest.var_33c2a1ad9d327e0a;
    }
    
    return level.searchprops.var_33c2a1ad9d327e0a;
}

// Namespace namespace_521b355ce75f6eac
// Params 0
// Checksum 0x936b6f5b, Offset: 0x389f
// Size: 0x29
function function_e512e2beedc00557()
{
    var_7237854e3be197ca = self.reservedintel;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return self.item;
}

/#

    // Namespace namespace_521b355ce75f6eac
    // Params 0
    // Checksum 0xba0c940c, Offset: 0x38d1
    // Size: 0x5f, Type: dev
    function function_ae2cd924812a4e81()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_16723be93d108e5e", 0 ) )
            {
                setdvar( @"hash_16723be93d108e5e", 0 );
                thread function_69102611d209d1d2( level.players[ 0 ].team, level.players[ 0 ].origin );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_521b355ce75f6eac
    // Params 0
    // Checksum 0xb2505587, Offset: 0x3938
    // Size: 0x2e, Type: dev
    function debuglaptop()
    {
        while ( true )
        {
            sphere( self.origin, 50, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

#/
