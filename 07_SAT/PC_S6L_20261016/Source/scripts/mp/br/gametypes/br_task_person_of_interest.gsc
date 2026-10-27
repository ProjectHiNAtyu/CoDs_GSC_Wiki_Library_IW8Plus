// scripts\mp\br\gametypes\br_task_person_of_interest.gsc  (hash_271b53ab3de88e16.gscc) (size: 11410 Bytes / 0x2c92 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8d4e28ee (2370709742)
// size ...... 11410 (0x2c92)
// includes .. 17  (offset: 0x2a22)
// strings ... 35  (offset: 0x2aaa)
// dev strs .. 1   (offset: 0x2c86)
// exports ... 21  (offset: 0x1cce)
// cseg ...... 0x3e1 + 0x18ed (0x1cce)
// imports ... 85  (offset: 0x2016)
// animtree1 . 0   (offset: 0x2c92)
// animtree2 . 0   (offset: 0x2c92)
#using script_16ea1b94f0f381b3;
#using script_6c9403ef6e857f6e;
#using scripts\common\game_utility;
#using scripts\common\script;
#using scripts\common\vehicle;
#using scripts\mp\ai_fortress;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\hud_message;

#namespace br_task_person_of_interest;

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0x1b9a6d7c, Offset: 0x3ff
// Size: 0x10e
function brtask_getspawndata( data )
{
    level.poiprops = spawnstruct();
    level.poiprops.circleradius = getdvarint( @"scr_br_poi_circle_radius", 2000 );
    level.poiprops.pointradius = getdvarint( @"scr_br_poi_point_radius", 1000 );
    level.poiprops.pointradiussq = level.poiprops.pointradius * level.poiprops.pointradius;
    level.poiprops.var_3afcdbbcf79cc9cc = getdvarfloat( @"hash_75c1cf1a1116077d", 0.65 );
    level.poiprops.headicon = "ui_map_icon_boss_juggernaut";
    level.poiprops.uavcapture = getdvarint( @"hash_b22e8fbab2a4e00a", 0 );
    data.createfunc = &function_5aee551df753930c;
}

// Namespace br_task_person_of_interest
// Params 2
// Checksum 0x89577d8a, Offset: 0x515
// Size: 0x1e9
function function_5aee551df753930c( activity, owner )
{
    task = dmz_task_utils::task_create( activity );
    task.owner = owner;
    owner.task = task;
    task.players = [];
    task.funcs[ "onInit" ] = &function_37d4b95d3e1180d7;
    task.funcs[ "onPlayerAssigned" ] = &brtask_onplayerassigned;
    task.funcs[ "onPlayerJoined" ] = &function_9a363786547c3625;
    task.funcs[ "onPlayerRemoved" ] = &function_7966b33723901f40;
    task.funcs[ "onTeamStart" ] = &function_4fbb472bfdc1b064;
    task.funcs[ "onPlayerExitVolume" ] = &function_ad6626bf13f762d6;
    task.funcs[ "onPlayerExitTimeout" ] = &brtask_onplayerexittimeout;
    task.funcs[ "onPlayerReenterVolume" ] = &function_3ad70e0121afeff7;
    task.ref = "br_poi";
    task.refindex = br_contract_manager::getquesttableindex( task.ref );
    task.spawntrap = 0;
    task.tier = task.owner br_strongholds::function_999adf66330f4aa8();
    
    if ( task.tier == "black" )
    {
        task.mission_index = 20;
        task.mission_complete = 21;
        task.mission_fail = 36;
        task.mission_fail_warning = 0;
    }
    else
    {
        task.mission_index = 20;
        task.mission_complete = 21;
        task.mission_fail = 36;
        task.mission_fail_warning = 0;
    }
    
    return task;
}

// Namespace br_task_person_of_interest
// Params 0
// Checksum 0xaeb22b84, Offset: 0x707
// Size: 0x1bc
function function_37d4b95d3e1180d7()
{
    task = self;
    task.activity.origin = task.owner.origin;
    circlelocation = task.owner.missiontrigger.origin;
    task.circlecenter = circlelocation;
    task.circleradius = level.poiprops.circleradius;
    
    if ( level.var_bd4bf3163e536461 )
    {
        task.owner.var_dc130884eab4ddf4 = 1;
        circleradius = getdvarint( @"scr_br_hold_circle_radius", 138 );
        task.owner.secondarytrigger = spawn( "trigger_radius", task.owner.loadout[ 0 ].origin, 0, circleradius, 62 );
        var_1213eb89af5eb = task.owner.secondarytrigger.origin;
        vfxscriptable = spawn( "script_model", var_1213eb89af5eb );
        vfxscriptable setmodel( "stronghold_control_point" );
        vfxscriptable.angles = task.owner.loadout[ 0 ].angles;
        vfxscriptable setscriptablepartstate( "flag", "idle" );
        task.owner.secondarytrigger.vfxnamemod = vfxscriptable;
    }
}

// Namespace br_task_person_of_interest
// Params 2
// Checksum 0x4fcaf08d, Offset: 0x8cb
// Size: 0x1cd
function brtask_onplayerassigned( teamname, player )
{
    task = self;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( level.poiprops.uavcapture )
    {
        task namespace_a69d9116df130921::brtask_onplayerassigned( teamname, player, 1 );
        task.holdpoint.var_ce60d75c005d4ea6 = 1;
        task.holdpoint.var_4107a3e26829739 = 1;
    }
    
    ai_fortress::function_6afabfde369e039c( task.owner, 1 );
    task thread activity_manager::function_e7c5a361b3642470( task.owner.missiontrigger, 9000 );
    
    if ( !task.owner.spawnedboss )
    {
        task.owner notify( #"hash_5a37e7d305f6448a" );
        task.owner waittill( #"hash_2174523118b37d83" );
    }
    
    task.target = task.owner.bossagents[ randomint( task.owner.bossagents.size ) ];
    
    if ( !task.var_33bbbf043b9b9c14 )
    {
        task.var_33bbbf043b9b9c14 = 1;
        task thread function_2c64d15428998b28();
        task function_47d2f8e5307f5100();
        players = [ player ];
        br_strongholds::function_126ff0458ad4d383( "blacksite_jugg_warn", players );
    }
    
    if ( var_7537e34d05ee8017 )
    {
        task thread function_26bcaac92e9ff923();
        task function_9a363786547c3625( player );
        return;
    }
    
    task thread function_26bcaac92e9ff923( player );
    task thread function_b9415f2f47afea88( player );
    task dmz_task_utils::function_678cd11cba7c85a9( teamname );
    task function_9a363786547c3625( player );
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0x8a5dfacb, Offset: 0xaa0
// Size: 0x18c
function function_9a363786547c3625( player )
{
    task = self;
    
    if ( !isdefined( function_f02c63b99c9614c9( task.players, player ) ) )
    {
        size = task.players.size;
        task.players[ size ] = player;
    }
    
    if ( level.poiprops.uavcapture )
    {
        namespace_a69d9116df130921::function_a7abfcfe746c1544( player, 1 );
    }
    
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( var_7537e34d05ee8017 )
    {
        return;
    }
    
    var_da759e0bfcdfca64 = player getclientomnvar( "ui_br_stronghold_mission" );
    
    if ( isdefined( task.target ) )
    {
        players = task.players;
        
        if ( isdefined( task.players ) )
        {
            if ( randomint( 100 ) > 50 )
            {
                br_strongholds::function_126ff0458ad4d383( "blacksite_jugg_defend", players );
            }
            else
            {
                br_strongholds::function_126ff0458ad4d383( "blacksite_jugg_engage", players );
            }
        }
    }
    
    player thread hud_message::showsplash( "stronghold_operation_person_of_interest" );
    wait 4;
    
    if ( !isdefined( player ) || !arraycontains( task.players, player ) )
    {
        return;
    }
    
    if ( var_da759e0bfcdfca64 == player getclientomnvar( "ui_br_stronghold_mission" ) )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_index );
        
        if ( !level.var_81d461e4adce8641 )
        {
            player setclientomnvar( "ui_br_stronghold_mission_timer", 0 );
            return;
        }
        
        player setclientomnvar( "ui_br_stronghold_mission_timer", task.endtime );
    }
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0xd9600030, Offset: 0xc34
// Size: 0x86
function function_7966b33723901f40( player )
{
    task = self;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    task.players = arrayremove( task.players, player );
    
    if ( var_7537e34d05ee8017 )
    {
        return;
    }
    
    if ( level.poiprops.uavcapture )
    {
        namespace_a69d9116df130921::function_4c802cd0e12e5637( player, 1 );
    }
    
    player setclientomnvar( "ui_br_stronghold_mission", task.mission_fail );
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0x33af6f9a, Offset: 0xcc2
// Size: 0x1b
function function_4fbb472bfdc1b064( teamname )
{
    assert( 1, "<dev string:x24>" );
}

// Namespace br_task_person_of_interest
// Params 4
// Checksum 0xe8450af5, Offset: 0xce5
// Size: 0x1ca
function function_f5aad6322cfdcddd( teamname, omnvarstate, everyonefailed, var_9ce7d5867665cad2 )
{
    task = self;
    var_42644bc26d45bf56 = arraycontains( task.teams, teamname );
    teamparticipants = player::getteamarray( teamname );
    
    if ( !level.poiprops.uavcapture || var_9ce7d5867665cad2 )
    {
        teaminfo = level.var_f9ba6d6273c5cc67.teamsinfo[ teamname ];
        
        if ( isdefined( teaminfo ) )
        {
            teaminfo.activities = arrayremove( teaminfo.activities, task.activity.id );
            teaminfo.active = 0;
        }
    }
    
    foreach ( player in teamparticipants )
    {
        if ( game_utility_common::isaigameparticipant( player ) )
        {
            continue;
        }
        
        if ( omnvarstate == task.mission_complete )
        {
            player thread hud_message::showsplash( "stronghold_operation_person_of_interest_completed" );
            player setclientomnvar( "ui_br_stronghold_mission", omnvarstate );
            continue;
        }
        
        var_82779679d64b827d = player getclientomnvar( "ui_br_stronghold_mission" );
        
        if ( var_42644bc26d45bf56 || var_82779679d64b827d == 19 )
        {
            if ( everyonefailed )
            {
                player thread hud_message::showsplash( "stronghold_operation_person_of_interest_failed" );
            }
            
            player setclientomnvar( "ui_br_stronghold_mission", 36 );
        }
    }
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0xae720965, Offset: 0xeb7
// Size: 0x7c
function function_ad6626bf13f762d6( player )
{
    task = self;
    player.var_5111d0ec51f4ab00 = 1;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_fail_warning );
    }
    
    exittimeout = gettime() + 9000;
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission_timer", exittimeout );
    }
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0x3302e82, Offset: 0xf3b
// Size: 0x87
function function_3ad70e0121afeff7( player )
{
    task = self;
    player.var_5111d0ec51f4ab00 = undefined;
    var_7537e34d05ee8017 = game_utility_common::isaigameparticipant( player );
    
    if ( !var_7537e34d05ee8017 )
    {
        player setclientomnvar( "ui_br_stronghold_mission", task.mission_index );
        
        if ( !level.var_81d461e4adce8641 )
        {
            player setclientomnvar( "ui_br_stronghold_mission_timer", 0 );
            return;
        }
        
        player setclientomnvar( "ui_br_stronghold_mission_timer", task.endtime );
    }
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0xd063a927, Offset: 0xfca
// Size: 0x76
function brtask_onplayerexittimeout( player )
{
    task = self;
    task function_7966b33723901f40( player );
    
    if ( level.poiprops.uavcapture )
    {
        namespace_a69d9116df130921::function_4c802cd0e12e5637( player, 1 );
    }
    
    player.var_5111d0ec51f4ab00 = undefined;
    player.var_4f29940bf9ecfd79 = undefined;
    
    if ( isdefined( level.var_18933116083e8076 ) )
    {
        task [[ level.var_18933116083e8076 ]]( player );
    }
}

// Namespace br_task_person_of_interest
// Params 3, eflags: 0x4
// Checksum 0x33d3093a, Offset: 0x1048
// Size: 0x2f9
function private function_3d1ab362e291fc4e( teamname, failed = 0, var_9ce7d5867665cad2 = 0 )
{
    task = self;
    task notify( #"task_ended" );
    
    if ( !level.poiprops.uavcapture || var_9ce7d5867665cad2 )
    {
        ai_fortress::function_5b84b41b9159ad3f( task.owner );
    }
    
    deletetask = 0;
    fortress = task.owner;
    teams = task.teams;
    
    if ( isdefined( fortress.var_861420630ba9b002 ) )
    {
        teams = arraycombineunique( teams, fortress.var_861420630ba9b002 );
    }
    
    foreach ( team in teams )
    {
        teamcompleted = 0;
        
        if ( isdefined( teamname ) )
        {
            teamcompleted = team == teamname;
        }
        
        omnvarstate = task.mission_fail;
        
        if ( teamcompleted )
        {
            deletetask = 1;
            omnvarstate = task.mission_complete;
        }
        
        task function_f5aad6322cfdcddd( team, omnvarstate, failed, var_9ce7d5867665cad2 );
    }
    
    if ( isdefined( task.headicon ) )
    {
        deleteheadicon( task.headicon );
    }
    
    if ( !level.poiprops.uavcapture || var_9ce7d5867665cad2 )
    {
        task.players = [];
        task.teams = [];
        task dmz_task_utils::function_e23cad864e9e2023();
        task dmz_task_utils::function_3ff46488beb193c7();
        
        if ( !isdefined( failed ) )
        {
            failed = 0;
        }
        
        task.starttime = undefined;
        
        if ( task.activity.tasks.size >= 1 && ( deletetask || failed ) )
        {
            task.owner.missiontrigger notify( #"activity_ended" );
            level.var_f9ba6d6273c5cc67.activities[ task.activity.id ] = undefined;
            task.activity.tasks = undefined;
        }
    }
    
    if ( isdefined( level.var_d07dd9893f7e474b ) )
    {
        task.owner [[ level.var_d07dd9893f7e474b ]]( teamname, !failed );
    }
    
    if ( level.var_bd4bf3163e536461 && omnvarstate == task.mission_complete )
    {
        task.owner thread activity_manager::function_93138313116d2f3e( task.owner.missiontrigger, "hold" );
    }
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0x102170b1, Offset: 0x1349
// Size: 0x111
function function_26bcaac92e9ff923( player )
{
    task = self;
    
    if ( !level.var_81d461e4adce8641 )
    {
        return;
    }
    
    if ( task.ticking )
    {
        return;
    }
    
    level endon( #"game_ended" );
    task endon( #"task_ended" );
    task.owner.missiontrigger endon( #"deleted" );
    task.owner.missiontrigger endon( #"activity_ended" );
    waittime = task.owner.var_32ef3f20015bb872[ 0 ];
    task.ticking = 1;
    task.starttime = gettime();
    task.endtime = task.starttime + waittime * 1000;
    wait waittime;
    player.var_5111d0ec51f4ab00 = undefined;
    player.var_4f29940bf9ecfd79 = undefined;
    task thread function_3d1ab362e291fc4e( undefined, 1 );
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0x10fb24a6, Offset: 0x1462
// Size: 0x109
function function_b9415f2f47afea88( player )
{
    task = self;
    level endon( #"game_ended" );
    task endon( #"task_ended" );
    
    if ( level.var_69579ddd45aa87e3 && task.owner.isblacksite )
    {
        return;
    }
    
    task.owner.missiontrigger endon( #"deleted" );
    task.owner.missiontrigger endon( #"activity_ended" );
    origin = task.activity.origin + ( 0, 0, 40 );
    
    while ( br_circle_util::ispointinmulticircledanger( origin ) || br_circle_util::function_3199bf5530fd0bc2( origin ) )
    {
        wait 0.5;
    }
    
    player.var_5111d0ec51f4ab00 = undefined;
    player.var_4f29940bf9ecfd79 = undefined;
    task thread function_3d1ab362e291fc4e( undefined, 1, 1 );
}

// Namespace br_task_person_of_interest
// Params 3
// Checksum 0x1d9d4aa7, Offset: 0x1574
// Size: 0x1ef
function function_dca6e44c20f87237( dropstruct, player, fortress )
{
    task = self;
    
    if ( !level.poiprops.uavcapture )
    {
        fortress br_strongholds::function_fb5fbbc2fcf4a080( player, undefined, "directional_uav", 0 );
    }
    
    rewardcash = task.activity.cashreward;
    
    foreach ( player in teams::getteamdata( player.team, "players" ) )
    {
        player br_plunder::playerplunderpickup( rewardcash );
        player br_plunder::function_d7efc5a9b599e020( 1, rewardcash );
    }
    
    teamindex = function_f02c63b99c9614c9( level.allteamnamelist, player.team );
    
    foreach ( player in level.players )
    {
        if ( getdvarint( @"hash_90582331a88cc477", 0 ) )
        {
            player thread hud_message::showsplash( "stronghold_complete_no_gamertags_blacksite" );
        }
        else
        {
            player thread hud_message::showsplash( "stronghold_complete_blacksite", teamindex );
        }
        
        br_public::brleaderdialogplayer( "blacksite_clear", player );
    }
    
    if ( !fortress.isblacksite )
    {
        player br_strongholds::function_e0fc600c4a7ef0ec( dropstruct, player::getteamarray( player.team, 0 ) );
    }
}

// Namespace br_task_person_of_interest
// Params 0
// Checksum 0x895223d7, Offset: 0x176b
// Size: 0x10e
function function_2c64d15428998b28()
{
    task = self;
    task endon( #"task_ended" );
    task.target waittill( #"death" );
    ent = task.target.lastattacker;
    player = ent;
    
    if ( ent vehicle::is_vehicle() && isdefined( ent.owner ) )
    {
        player = ent.owner;
    }
    
    isvalidplayer = isplayer( player ) && isalive( player );
    
    if ( isvalidplayer )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        function_5e83247c1c9df39e( dropstruct, task.target, player );
        dmz_task_utils::function_59e5c04599d5a456( task, player );
        task thread function_dca6e44c20f87237( dropstruct, player, task.owner );
        task thread function_3d1ab362e291fc4e( player.team );
        return;
    }
    
    task thread function_3d1ab362e291fc4e( undefined, 1 );
}

// Namespace br_task_person_of_interest
// Params 0
// Checksum 0xbbfea6e8, Offset: 0x1881
// Size: 0xa7
function function_47d2f8e5307f5100()
{
    task = self;
    task.headicon = createheadicon( task.target );
    setheadiconenemyimage( task.headicon, level.poiprops.headicon );
    setheadicondrawthroughgeo( task.headicon, 1 );
    setheadiconsnaptoedges( task.headicon, 0 );
    setheadiconmaxdistance( task.headicon, 2048 );
    setheadiconnaturaldistance( task.headicon, 30 );
    setheadiconzoffset( task.headicon, 10 );
}

// Namespace br_task_person_of_interest
// Params 3
// Checksum 0x5dd6f40d, Offset: 0x1930
// Size: 0xb7
function function_5e83247c1c9df39e( dropstruct, boss, player )
{
    script::demoforcesre( "GetScriptCacheContents does not work with the common item system. Create script key to spawn items if needed." );
    var_4b690f9c53d2a12b = getdvarint( @"hash_623a5fbf8a2eda3e", 1 );
    var_973cb68cab23750d = getdvarint( @"hash_763d715ff5888239", 0 );
    
    if ( var_973cb68cab23750d )
    {
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( boss.origin, boss.angles );
        spawned = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_killstreak_auav", undefined, spawnoptions );
        
        if ( isdefined( spawned ) )
        {
            spawned setscriptablepartstate( "brloot_killstreak_auav", "dropped" );
        }
    }
}

// Namespace br_task_person_of_interest
// Params 3
// Checksum 0x93166f11, Offset: 0x19ef
// Size: 0xf7
function function_e7a6f96cdb3feed2( dropstruct, boss, var_5ae955b3e041565 )
{
    count = undefined;
    
    foreach ( lootdrop in var_5ae955b3e041565 )
    {
        count = level.br_pickups.counts[ lootdrop ];
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( boss.origin, boss.angles );
        spawned = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( lootdrop, count, spawnoptions );
        
        if ( isdefined( spawned ) )
        {
            spawned setscriptablepartstate( lootdrop, "dropped" );
        }
    }
}

// Namespace br_task_person_of_interest
// Params 1
// Checksum 0xcf47a85e, Offset: 0x1aee
// Size: 0x1e0
function brtask_onplayerkilled( deathdata )
{
    if ( !isdefined( level.var_3333b48fc74218b1 ) || level.var_3333b48fc74218b1 <= 0 )
    {
        return;
    }
    
    fortress = ai_fortress::function_386da8b7d1afe346( deathdata.victim.origin );
    
    if ( !isdefined( fortress ) )
    {
        return;
    }
    
    if ( fortress.isblacksite && activity_manager::function_6ca6a856d360b94e( self.team, fortress ) )
    {
        task = fortress.task;
        
        if ( isdefined( task ) && isdefined( task.target ) )
        {
            if ( isdefined( task.players ) )
            {
                players = task.players;
                
                if ( deathdata.victim br_public::isplayerinorgoingtogulag() )
                {
                    players = arrayremove( task.players, deathdata.victim );
                }
                
                var_63af27e6f9ffaf9c = [];
                
                foreach ( player in players )
                {
                    if ( player.team == deathdata.victim.team && player != deathdata.victim )
                    {
                        var_63af27e6f9ffaf9c[ var_63af27e6f9ffaf9c.size ] = player;
                    }
                }
                
                if ( players.size > 0 )
                {
                    if ( var_63af27e6f9ffaf9c.size > 0 )
                    {
                        br_strongholds::function_126ff0458ad4d383( "blacksite_jugg_single_kill", players );
                        return;
                    }
                    
                    if ( var_63af27e6f9ffaf9c.size <= 0 )
                    {
                        br_strongholds::function_126ff0458ad4d383( "blacksite_jugg_team_kill", players );
                    }
                }
            }
        }
    }
}

