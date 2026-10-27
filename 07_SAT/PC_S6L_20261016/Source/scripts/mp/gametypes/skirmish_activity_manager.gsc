// scripts\mp\gametypes\skirmish_activity_manager.gsc  (hash_02231df0146ba39c.gscc) (size: 10574 Bytes / 0x294e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf6788a6f (4135094895)
// size ...... 10574 (0x294e)
// includes .. 13  (offset: 0x266e)
// strings ... 38  (offset: 0x26d6)
// dev strs .. 11  (offset: 0x28c2)
// exports ... 16  (offset: 0x1d56)
// cseg ...... 0x487 + 0x18cf (0x1d56)
// imports ... 53  (offset: 0x1fd6)
// animtree1 . 0   (offset: 0x294e)
// animtree2 . 0   (offset: 0x294e)
#using script_2f94849b5aff8f5a;
#using script_33cd8a7250381109;
#using scripts\common\utility;
#using scripts\mp\common\equipment\grappling_hook;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gametypes\skirmish_activities;
#using scripts\mp\gametypes\skirmish_objective_director;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\matchdata;

#namespace skirmish_activity_manager;

// Namespace skirmish_activity_manager
// Params 0
// Checksum 0x40b2fef1, Offset: 0x4a5
// Size: 0x25c
function init()
{
    if ( isdefined( level.var_85b177faa9935b2a ) )
    {
        return;
    }
    
    level.var_85b177faa9935b2a = spawnstruct();
    level.var_85b177faa9935b2a.activities = [];
    level.var_85b177faa9935b2a.running = [];
    level.var_85b177faa9935b2a.skrzone = [];
    level.var_85b177faa9935b2a.var_6e5a676bf1a0208f = [];
    function_4c996ce225c8d2c5();
    level.var_85b177faa9935b2a.maxActivitiesStarting = getmatchrulesdata( "skirmishData", "maxActivitiesStarting" );
    level.var_85b177faa9935b2a.activityCooldown = getmatchrulesdata( "skirmishData", "activityCooldown" );
    level.var_85b177faa9935b2a.initialLockedTime = getmatchrulesdata( "skirmishData", "initialLockedTime" );
    level.var_85b177faa9935b2a.maxLockDelay = getmatchrulesdata( "skirmishData", "maxLockDelay" );
    level.var_85b177faa9935b2a.spawndelay = getmatchrulesdata( "skirmishData", "spawnDelay" );
    level.var_85b177faa9935b2a.matchStartObjectiveActivationDelay = getmatchrulesdata( "skirmishData", "matchStartObjectiveActivationDelay" );
    level.var_85b177faa9935b2a.countdownObjectiveActivationThreshold = getmatchrulesdata( "skirmishData", "countdownObjectiveActivationThreshold" );
    level.var_85b177faa9935b2a.var_d49149722a9853be = getdvarint( @"hash_bb252fb243bb74a", level.gametypebundle.var_d49149722a9853be );
    level.var_85b177faa9935b2a.var_6ec374ebf84161f8 = getdvarint( @"hash_995f5da8e1d70331", level.var_fd5a14340d3320e9 ) * 2;
    level.var_85b177faa9935b2a.var_e1115b401ccb733a = getdvarint( @"hash_59ac1637c0bf4ee7", level.gametypebundle.var_8241d7ce83de2a97 );
    level.var_85b177faa9935b2a.var_6773e9cddfdd65a1 = getdvarfloat( @"hash_5d10b4d5d3520171", level.gametypebundle.var_bf32daa8333fce26 );
    level.var_353d7636318ba593 = getdvarint( @"hash_36f314e9f8eea6dd", 0 );
    
    /#
        if ( level.var_353d7636318ba593 )
        {
            thread function_353d7636318ba593();
        }
    #/
}

// Namespace skirmish_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x71f0411e, Offset: 0x709
// Size: 0x21
function private function_4c996ce225c8d2c5()
{
    level.var_85b177faa9935b2a.mapsettings = game_utility_mp::function_cb7ed8e67866f9d0( "skirmishmapsettings" );
}

// Namespace skirmish_activity_manager
// Params 1
// Checksum 0x16bdde3c, Offset: 0x732
// Size: 0x454
function function_387d8b4109af4dc9( selectedactivity )
{
    activitytype = selectedactivity.activitytype;
    activityname = selectedactivity.activityname;
    activityzone = selectedactivity.skrzone;
    activity = level.var_85b177faa9935b2a.skrzone[ activityzone ].activities[ activitytype ][ activityname ];
    
    if ( !isdefined( activity ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    var_5b110820daa2b673 = function_25bc283988806076();
    isdebugmode = level.var_b5887d2493fadea5.debugmode ?? 0;
    
    if ( var_5b110820daa2b673 >= level.var_85b177faa9935b2a.maxActivitiesStarting && !isdebugmode )
    {
        wait level.var_85b177faa9935b2a.spawndelay;
    }
    
    var_b9a330e98138b6df = level.var_85b177faa9935b2a.initialLockedTime;
    var_1541da567f3dc9f3 = level.var_85b177faa9935b2a.maxLockDelay;
    var_5b110820daa2b673 = function_25bc283988806076();
    level.var_8f31e0730d6d5aec = var_5b110820daa2b673 < level.var_85b177faa9935b2a.maxActivitiesStarting ? var_b9a330e98138b6df : var_1541da567f3dc9f3;
    activity.activityparams.var_51f5a92414c2f4f8 = 0;
    activityobject = [[ activity.activityinit ]]( activity.activityparams );
    
    if ( activityobject )
    {
        skirmish_objective_director::function_2114675f9ffa581c( activityzone );
        forcehvs = selectedactivity.ishvs ?? 0;
        
        if ( forcehvs && activitytype != #"dom" )
        {
            function_13f994cda06be4bb( activityobject.objidnum, 1 );
            activity.activityparams.var_51f5a92414c2f4f8 = 1;
            level.var_85b177faa9935b2a.var_5dedeaf91756ad1c = activitytype;
            skirmish_util::function_113800972c457040( #"hvs_available" );
            namespace_ccc9a50b2d185e5::function_d3531db6093ed727();
            logstring( "[SKIRMISH_OD] Heat Zone activated on " + activityzone );
        }
        else
        {
            logstring( "[SKIRMISH_OD] Regular objective activated on " + activityzone + " - Type: " + getxhash( activitytype ) );
        }
        
        if ( level.var_85b177faa9935b2a.var_c5a093ef905d1289 && activitytype == #"dom" && !activity.activityparams.var_51f5a92414c2f4f8 )
        {
            level.var_8f31e0730d6d5aec = 0;
        }
        
        if ( activity.activityparams.var_51f5a92414c2f4f8 )
        {
            level.var_8f31e0730d6d5aec = var_1541da567f3dc9f3;
        }
        
        activityobject thread function_82d00483a3a881c6( activitytype, activity, self );
        activitystart = spawnstruct();
        activitystart.starttime = gettime();
        activitystart.skrzone = activityzone;
        activitystart.var_51f5a92414c2f4f8 = activity.activityparams.var_51f5a92414c2f4f8;
        activitystart.activityobject = activityobject;
        level.var_85b177faa9935b2a.skrzone[ activityzone ].active = 1;
        
        if ( !isdefined( level.var_85b177faa9935b2a.var_6e5a676bf1a0208f ) )
        {
            level.var_85b177faa9935b2a.var_6e5a676bf1a0208f = [];
        }
        
        level.var_85b177faa9935b2a.var_6e5a676bf1a0208f[ level.var_85b177faa9935b2a.var_6e5a676bf1a0208f.size ] = level.var_85b177faa9935b2a.skrzone[ activityzone ];
        level.var_85b177faa9935b2a.running[ activitytype ][ activityname ] = activitystart;
        activityobject.zone = activityzone;
        function_b3f751b4b02a279e( activity.activityparams.location, activitytype, activity.activityparams.var_51f5a92414c2f4f8 );
        thread namespace_a0bf8ee672af8086::function_cda6f4dac114bdbd( activitytype, activityname, activity.activityparams.location, activity.activityshow, activity.activityhide, activity.activityfocus, activityobject );
    }
}

// Namespace skirmish_activity_manager
// Params 3, eflags: 0x4
// Checksum 0x2b0a5ecf, Offset: 0xb8e
// Size: 0x8a
function private function_b3f751b4b02a279e( location, activitytype, var_51f5a92414c2f4f8 )
{
    dlog_recordevent( "dlog_event_mp_skr_objective_spawn", [ "skr_objective_spawn_location_x", location[ 0 ], "skr_objective_spawn_location_y", location[ 1 ], "skr_objective_spawn_location_z", location[ 2 ], "skr_objective_spawn_time_s", getsystemtime(), "skr_objective_spawn_type", activitytype, "skr_objective_spawn_is_heat", var_51f5a92414c2f4f8 ] );
}

// Namespace skirmish_activity_manager
// Params 8
// Checksum 0xc878b79a, Offset: 0xc20
// Size: 0x467, Type: bool
function registeractivity( activity, activityinit, activitystart, activitycomplete, activityhide, activityshow, activityfocus, params )
{
    activitytype = activity.activitytype;
    activityname = activity.activityname;
    assert( isxhash( activitytype ) );
    assert( isxhash( activityname ) );
    init();
    
    if ( !isdefined( level.var_85b177faa9935b2a.activities[ activity.activitytype ] ) )
    {
        level.var_85b177faa9935b2a.activities[ activitytype ] = [];
        level.var_85b177faa9935b2a.running[ activitytype ] = [];
    }
    
    if ( isdefined( level.var_85b177faa9935b2a.activities[ activitytype ][ activityname ] ) )
    {
        assertmsg( "<dev string:x54>" + activitytype + "<dev string:x64>" + activityname + "<dev string:x6d>" );
        return false;
    }
    
    activitystruct = spawnstruct();
    activitystruct.activitytype = activitytype;
    activitystruct.activityname = activityname;
    activitystruct.activityinit = activityinit;
    activitystruct.activitystart = activitystart;
    activitystruct.activitycomplete = activitycomplete;
    activitystruct.activityhide = activityhide;
    activitystruct.activityshow = activityshow;
    activitystruct.activityfocus = activityfocus;
    activitystruct.activityparams = params;
    activitystruct.cooldowntime = activity.var_14de5c0af315cc23;
    level.var_85b177faa9935b2a.activities[ activitytype ][ activityname ] = activitystruct;
    skrzone = activity.activityzone;
    
    if ( !isdefined( level.var_85b177faa9935b2a.skrzone[ skrzone ] ) )
    {
        level.var_85b177faa9935b2a.skrzone[ skrzone ] = spawnstruct();
        level.var_85b177faa9935b2a.skrzone[ skrzone ].active = 0;
        level.var_85b177faa9935b2a.skrzone[ skrzone ].zonename = skrzone;
        level.var_85b177faa9935b2a.skrzone[ skrzone ].activities = [];
    }
    
    if ( !isdefined( level.var_85b177faa9935b2a.skrzone[ skrzone ].activities[ activitytype ] ) )
    {
        level.var_85b177faa9935b2a.skrzone[ skrzone ].activities[ activitytype ] = [];
    }
    
    activitystruct.skrzone = skrzone;
    level.var_85b177faa9935b2a.skrzone[ skrzone ].activities[ activitytype ][ activityname ] = activitystruct;
    avglocation = ( 0, 0, 0 );
    var_8076e13d36c9df7e = 0;
    
    foreach ( activity in level.var_85b177faa9935b2a.skrzone[ skrzone ].activities )
    {
        activityname = getfirstarraykey( activity );
        
        if ( activity[ activityname ] && activity[ activityname ].activityparams.location )
        {
            if ( activity[ activityname ].activitytype == #"secure" && !level.var_85b177faa9935b2a.var_61c006b49d4bc07d )
            {
                continue;
            }
            
            avglocation += activity[ activityname ].activityparams.location;
            var_8076e13d36c9df7e++;
        }
    }
    
    if ( var_8076e13d36c9df7e > 0 )
    {
        avglocation /= var_8076e13d36c9df7e;
    }
    
    level.var_85b177faa9935b2a.skrzone[ skrzone ].location = avglocation;
    return true;
}

// Namespace skirmish_activity_manager
// Params 3, eflags: 0x4
// Checksum 0xa1c922eb, Offset: 0x1090
// Size: 0x1b2
function private function_dd865870e50bb79c( runningactivity, activity, completingplayers )
{
    var_580f6130186c0aa = activity.activityparams.location;
    var_43e3951330d73efa = activity.activityparams.var_51f5a92414c2f4f8;
    var_d05ae32d0c9bd66 = function_25bc283988806076() - 1;
    playerunoids = [];
    
    foreach ( player in completingplayers )
    {
        if ( !isdefined( playerunoids ) )
        {
            playerunoids = [];
        }
        
        playerunoids[ playerunoids.size ] = player getplayerunoid();
    }
    
    dlog_recordevent( "dlog_event_mp_skr_objective_complete", [ "skr_completing_player_uno_ids", playerunoids, "utc_skr_objective_start_time_s", runningactivity.var_42c03680eb636de, "utc_skr_objective_end_time_s", getsystemtime(), "skr_objective_type", activity.activitytype, "skr_objective_location_x", var_580f6130186c0aa[ 0 ], "skr_objective_location_y", var_580f6130186c0aa[ 1 ], "skr_objective_location_z", var_580f6130186c0aa[ 2 ], "skr_objective_is_high_value", var_43e3951330d73efa, "skr_objective_active_count", var_d05ae32d0c9bd66, "skr_objective_player_count", completingplayers.size ] );
}

// Namespace skirmish_activity_manager
// Params 4
// Checksum 0xd5e5a870, Offset: 0x124a
// Size: 0x350
function finishactivity( activitytype, activityname, winningteam, completingplayers )
{
    assert( isxhash( activitytype ) );
    assert( isxhash( activityname ) );
    init();
    runningactivity = level.var_85b177faa9935b2a.running[ activitytype ][ activityname ];
    
    if ( !runningactivity )
    {
        return;
    }
    
    skrzone = runningactivity.skrzone;
    activity = level.var_85b177faa9935b2a.skrzone[ skrzone ].activities[ activitytype ][ activityname ];
    activity.activityparams.winningteam = winningteam;
    function_dd865870e50bb79c( runningactivity, activity, completingplayers );
    var_5b110820daa2b673 = function_25bc283988806076() - 1;
    
    if ( runningactivity.var_51f5a92414c2f4f8 )
    {
        function_13f994cda06be4bb( runningactivity.activityobject.objidnum, 0 );
        logstring( "[SKIRMISH_OD] Heat Zone completed on " + skrzone + " by team " + winningteam + " (Active: " + var_5b110820daa2b673 + ")" );
    }
    else
    {
        logstring( "[SKIRMISH_OD] Regular objective completed on " + skrzone + " by team " + winningteam + " (Active: " + var_5b110820daa2b673 + ")" );
    }
    
    namespace_a0bf8ee672af8086::function_b119ccd8bdd22fa5( activitytype, activityname, winningteam );
    
    if ( isfunction( activity.activitycomplete ) )
    {
        [[ activity.activitycomplete ]]( activity.activityparams );
    }
    
    level.var_85b177faa9935b2a.skrzone[ skrzone ].lastendtime = gettime();
    level.var_85b177faa9935b2a.skrzone[ skrzone ].activities[ activitytype ][ activityname ].lastendtime = gettime();
    level.var_85b177faa9935b2a.running[ activitytype ][ activityname ] = undefined;
    level.var_85b177faa9935b2a.skrzone[ skrzone ].active = 0;
    
    for ( index = 0; index < level.var_85b177faa9935b2a.var_6e5a676bf1a0208f.size ; index++ )
    {
        if ( level.var_85b177faa9935b2a.var_6e5a676bf1a0208f[ index ].zonename == skrzone )
        {
            level.var_85b177faa9935b2a.var_6e5a676bf1a0208f[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( level.var_85b177faa9935b2a.var_6e5a676bf1a0208f );
            }
            
            break;
        }
    }
    
    skirmish_objective_director::function_57c69d94c84eb0cb( skrzone, runningactivity.var_51f5a92414c2f4f8 );
    setomnvar( "ui_objective_" + skrzone, -1 );
    
    if ( level.var_85b177faa9935b2a.var_d49149722a9853be )
    {
        function_1792432f12846ae2( level.var_85b177faa9935b2a.skrzone[ skrzone ].location, winningteam );
    }
    
    if ( level.var_85b177faa9935b2a.var_e1115b401ccb733a && activity.activityparams.var_51f5a92414c2f4f8 )
    {
        thread awarduav( winningteam );
    }
}

// Namespace skirmish_activity_manager
// Params 0
// Checksum 0x8b576792, Offset: 0x15a2
// Size: 0xf8
function function_25bc283988806076()
{
    var_d05ae32d0c9bd66 = 0;
    
    foreach ( var_318a88ee3a0b5e10 in level.var_85b177faa9935b2a.running )
    {
        foreach ( runningactivity in var_318a88ee3a0b5e10 )
        {
            if ( runningactivity )
            {
                var_d05ae32d0c9bd66++;
            }
        }
    }
    
    return var_d05ae32d0c9bd66;
}

// Namespace skirmish_activity_manager
// Params 2, eflags: 0x4
// Checksum 0xbb493d60, Offset: 0x16a3
// Size: 0xd2
function private function_1792432f12846ae2( var_5bcbf311c74687db, winningteam )
{
    players = teams::getteamdata( winningteam, "players" );
    
    foreach ( player in players )
    {
        if ( distance2d( player.origin, var_5bcbf311c74687db ) < level.var_85b177faa9935b2a.var_6ec374ebf84161f8 && player::isreallyalive( player ) )
        {
            namespace_1d6fb5bfc117a398::function_51f847aef825ec26( player );
        }
    }
}

// Namespace skirmish_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x9038c47c, Offset: 0x177d
// Size: 0x58
function private awarduav( winningteam )
{
    level endon( #"game_ended" );
    level.activeuavs[ winningteam ]++;
    uav::uav_setteamradarstrength( winningteam );
    wait level.var_85b177faa9935b2a.var_6773e9cddfdd65a1;
    level.activeuavs[ winningteam ]--;
    uav::uav_setteamradarstrength( winningteam );
}

// Namespace skirmish_activity_manager
// Params 0
// Checksum 0xce0f55be, Offset: 0x17dd
// Size: 0x6a, Type: bool
function function_4401e8c9415a6961()
{
    if ( level.matchcountdowntime )
    {
        return ( level.matchcountdowntime <= level.var_85b177faa9935b2a.countdownObjectiveActivationThreshold );
    }
    
    var_ac6aea371d29dc4b = level.var_85b177faa9935b2a.matchStartObjectiveActivationDelay;
    var_a4df43321dde0b12 = utility::function_4b74c15943231980( var_ac6aea371d29dc4b );
    return matchdata::gettimefrommatchstart( gettime() ) > var_a4df43321dde0b12;
}

// Namespace skirmish_activity_manager
// Params 1
// Checksum 0xeddfdd8d, Offset: 0x1850
// Size: 0x71, Type: bool
function function_9c74a5326de344db( skrzone )
{
    if ( skrzone.active )
    {
        return false;
    }
    
    if ( !skrzone.lastendtime )
    {
        return true;
    }
    
    var_c67b0d1efae62556 = utility::function_4b74c15943231980( level.var_85b177faa9935b2a.activityCooldown );
    elapsedtime = gettime() - skrzone.lastendtime;
    return elapsedtime > var_c67b0d1efae62556;
}

// Namespace skirmish_activity_manager
// Params 3, eflags: 0x4
// Checksum 0x84076c92, Offset: 0x18ca
// Size: 0x157
function private function_82d00483a3a881c6( activitytype, activity, startedactivity )
{
    level endon( #"game_ended" );
    var_5b110820daa2b673 = function_25bc283988806076();
    var_f2e443941f2496ff = var_5b110820daa2b673 < level.var_85b177faa9935b2a.maxActivitiesStarting;
    var_76696ccf5753d333 = activity.activityparams.var_51f5a92414c2f4f8 && level.var_b2ca1f64a6378832 || var_f2e443941f2496ff;
    skirmish_activities::function_ab382591cebc98b5( level.var_8f31e0730d6d5aec, activity.skrzone, activity.activityparams.var_51f5a92414c2f4f8, var_76696ccf5753d333 );
    level.var_85b177faa9935b2a.running[ activitytype ][ activity.activityname ].var_42c03680eb636de = getsystemtime();
    [[ activity.activitystart ]]( self, activity.activityparams );
    startedactivity notify( #"activity_unlocked" );
    
    if ( !level.var_1a86d9ee865de215 )
    {
        audio_utility::function_63bf1584c79c055( level.players, "uin_t10_skirmish_objective_available" );
        level.var_1a86d9ee865de215 = 1;
        level utility::delaythread( 0.5, &function_5a5f56b1212c93a5 );
    }
}

// Namespace skirmish_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x467492f1, Offset: 0x1a29
// Size: 0x18
function private function_5a5f56b1212c93a5()
{
    level endon( #"game_ended" );
    level.var_1a86d9ee865de215 = 0;
}

/#

    // Namespace skirmish_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0x69181dd7, Offset: 0x1a49
    // Size: 0x30d, Type: dev
    function private function_353d7636318ba593()
    {
        level endon( #"game_ended" );
        wait 10;
        level.var_44935d4fd7e875f9 = 1;
        
        if ( level.var_b5887d2493fadea5 )
        {
            level.var_b5887d2493fadea5.debugmode = 1;
        }
        
        logstring( "<dev string:x8c>" );
        
        foreach ( zone in level.var_85b177faa9935b2a.skrzone )
        {
            randomcolor = ( randomfloat( 1 ), randomfloat( 1 ), randomfloat( 1 ) );
            
            foreach ( activitytype in zone.activities )
            {
                foreach ( objective in activitytype )
                {
                    if ( objective.activitytype == #"secure" && !level.var_85b177faa9935b2a.var_61c006b49d4bc07d )
                    {
                        continue;
                    }
                    
                    objective.ishvs = 0;
                    function_387d8b4109af4dc9( objective );
                    
                    if ( objective.activityparams.location )
                    {
                        print3d( objective.activityparams.location + ( 0, 0, 200 ), objective.skrzone, randomcolor, 1, 30, 60000, 1 );
                        logstring( "<dev string:xdf>" + objective.skrzone + "<dev string:xff>" + getxhash( objective.activitytype ) + "<dev string:x106>" + getxhash( objective.activityname ) );
                        continue;
                    }
                    
                    logstring( "<dev string:x10d>" + objective.skrzone + "<dev string:xff>" + getxhash( objective.activitytype ) + "<dev string:x106>" + getxhash( objective.activityname ) + "<dev string:x135>" );
                }
            }
        }
        
        logstring( "<dev string:x14a>" + level.var_85b177faa9935b2a.skrzone.size );
    }

#/
