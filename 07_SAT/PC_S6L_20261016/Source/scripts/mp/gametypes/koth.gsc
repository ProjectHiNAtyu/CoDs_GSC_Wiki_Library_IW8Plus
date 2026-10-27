// scripts\mp\gametypes\koth.gsc  (hash_734ea6311b19a424.gscc) (size: 54452 Bytes / 0xd4b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcef7ac5b (3472338011)
// size ...... 54452 (0xd4b4)
// includes .. 46  (offset: 0xc8dc)
// strings ... 130 (offset: 0xca4c)
// dev strs .. 17  (offset: 0xd3bc)
// exports ... 97  (offset: 0x8a60)
// cseg ...... 0x83b + 0x8225 (0x8a60)
// imports ... 366 (offset: 0x9988)
// animtree1 . 0   (offset: 0xd4b4)
// animtree2 . 0   (offset: 0xd4b4)
#using script_382bf8d77c4fd348;
#using script_39ecc21922ab862e;
#using scripts\common\callback_sequence;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\action_park_utility;
#using scripts\mp\callouts;
#using scripts\mp\challenges;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\grnd;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\matchdata;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;

#namespace koth;

// Namespace koth
// Params 0, eflags: 0x5
// Checksum 0x74a836da, Offset: 0x859
// Size: 0x23
function private autoexec __autoexec__()
{
    system::register( #"koth", #"action_park", &function_a53b566f98941da2, undefined, 1 );
}

// Namespace koth
// Params 0, eflags: 0x4
// Checksum 0xb5933755, Offset: 0x884
// Size: 0x176
function private function_a53b566f98941da2()
{
    if ( action_park_utility::is_enabled() && level.gametype == "koth" )
    {
        script_label = 1;
        
        foreach ( game_object_struct in utility::getstructarray( "gameobject" ) )
        {
            var_f7f9c74e4638fb4 = string( script_label );
            
            foreach ( chevron_struct in utility::function_b7f3d374aa10aa51( "mp_chevron", "targetname", game_object_struct.origin, 700 ) )
            {
                if ( game_object_struct.chevrons == chevron_struct.script_label )
                {
                    chevron_struct.script_label = var_f7f9c74e4638fb4;
                }
            }
            
            game_object_struct.script_label = var_f7f9c74e4638fb4;
            game_object_struct.chevrons = var_f7f9c74e4638fb4;
            script_label++;
        }
    }
}

// Namespace koth
// Params 0
// Checksum 0xb90bd67, Offset: 0xa02
// Size: 0x38a
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        gameobjects_common::function_22117b1fd559026f( "hardpoint", { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) }, &function_51483b09a1807cd7 );
    }
    else
    {
        allowed[ 0 ] = game_utility::getgametype();
        allowed[ 1 ] = "hardpoint";
        allowed[ 2 ] = "tdm";
        
        if ( game_utility::function_ae97372c83da7acc() || level.leagueplaymatch )
        {
            allowed[ 0 ] = game_utility_mp::getbasegametype();
        }
        
        gameobjects::main( allowed );
    }
    
    if ( getgametypenamekey() == "koth_sg" )
    {
        level thread function_5b9514e060bb4725();
    }
    
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.hpstarttime = 0;
    level.scoreperplayer = undefined;
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.onplayerconnect = &onplayerconnect;
    level.getspawnpoint = &getspawnpoint;
    level.onrespawndelay = &getrespawndelay;
    level.lastcaptime = gettime();
    level.usezonecapture = 1;
    level.getkothzonedeadzonedist = &getkothzonedeadzonedist;
    level.onplayerjoinedteam = &obj_zonecapture::onplayerjoinedteam;
    level.disablebuddyspawn = 1;
    level.var_40cd999d911308e0 = &game_utility_mp::function_24298f56712800ff;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_84968d430abf1672;
    level.ontimelimit = &ontimelimit;
    level.var_813f2ea1f9452bdb = &function_54cc863ef55e7de4;
    level.lastcaptureteam = undefined;
    level.previousclosespawnent = undefined;
    level.var_cf6229770b047f38 = [];
    setomnvar( "ui_hq_num_alive", 0 );
    setomnvar( "ui_hq_ownerteam", -1 );
    level.nosuspensemusic = 1;
    thread writeplayerrotationscoretomatchdataongameend();
    utility::registersharedfunc( #"koth_shared", #"hash_cda4308a680a661b", &function_aa8f15d9f14b98cc );
    utility::registersharedfunc( #"koth_shared", #"hash_fe4eaea2df7a50a0", &function_537d9824316d5d99 );
    utility::registersharedfunc( #"koth_shared", #"hash_78baf065cea30b57", &function_8e962c96d8c8c798 );
    utility::registersharedfunc( #"koth_shared", #"on_player_score_interval", &function_b290f77c226a8e24 );
    utility::registersharedfunc( #"koth_shared", #"hash_4356b4516dc478f2", &function_25234f064d30984b );
    koth_shared::initialize();
    
    /#
        if ( getdvarint( @"hash_3288df25c3558e8d", 0 ) )
        {
            level thread function_37f2fbfcbc315f3a();
        }
    #/
}

// Namespace koth
// Params 0
// Checksum 0x1879505e, Offset: 0xd94
// Size: 0x1b
function function_5b9514e060bb4725()
{
    level endon( #"game_ended" );
    waittillframeend();
    audio_utility::snd_transient_load( "mp_gametype_stopgo_t10" );
}

// Namespace koth
// Params 0
// Checksum 0x65f7a680, Offset: 0xdb7
// Size: 0x199
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.zoneduration = getmatchrulesdata( "kothData", "zoneLifetime" ) ?? 60;
    level.zonecapturetime = getmatchrulesdata( "kothData", "zoneCaptureTime" ) ?? 0;
    level.firstzoneactivationdelay = getmatchrulesdata( "kothData", "firstZoneActivationDelay" ) ?? 30;
    level.zoneactivationdelay = getmatchrulesdata( "kothData", "zoneActivationDelay" ) ?? 0;
    level.nextzonerevealtime = getmatchrulesdata( "kothData", "nextZoneRevealTime" ) ?? 12;
    level.zonemajoritycapture = getmatchrulesdata( "kothData", "zoneMajorityCapture" ) ?? 0;
    level.zonerandomlocationorder = getmatchrulesdata( "kothData", "randomLocationOrder" ) ?? 0;
    level.zoneadditivescoring = getmatchrulesdata( "kothData", "additiveScoring" ) ?? 0;
    level.pausemodetimer = getmatchrulesdata( "kothData", "pauseTime" ) ?? 1;
    level.spawndelay = getmatchrulesdata( "kothData", "spawnDelay" ) ?? 0;
    level.disableOverTime = getmatchrulesdata( "kothData", "disableOverTime" ) ?? 0;
    level.useFrontlineSpawns = getmatchrulesdata( "kothData", "useFrontlineSpawns" ) ?? 0;
    assert( level.zoneduration >= level.nextzonerevealtime, "<dev string:x24>" );
    
    if ( level.zoneduration < level.nextzonerevealtime )
    {
        level.nextzonerevealtime = level.zoneduration;
    }
}

// Namespace koth
// Params 0
// Checksum 0x1b7f9ddd, Offset: 0xf58
// Size: 0x3a7
function onstartgametype()
{
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, level.gametypebundle.uiobjective ?? &"objectives/koth" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, level.gametypebundle.var_b960727c135905a5 ?? &"objectives/koth" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, level.gametypebundle.var_2e18572f0c5ef5ab ?? &"objectives/koth_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, level.gametypebundle.var_2e18572f0c5ef5ab ?? &"objectives/koth_hint" );
    }
    
    setclientnamemode( "auto_change" );
    
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        game[ #"hardpoint" ] = {};
        game[ #"hardpoint" ].zoneorder = [];
        callback::function_dc654a4d4126a928( #"hash_92c01688276809dc", #"hash_6947ec89a1af6d69", &function_2b3b81181607daf4 );
        callback::function_dc654a4d4126a928( #"hash_89cf712b23a4d7b5", #"hash_6947ec89a1af6d69", &function_83c3ac8632599103 );
        callback::function_dc654a4d4126a928( #"hash_3c955b1e6fcd76eb", #"hash_6947ec89a1af6d69", &function_94a6de4e2d6c3b57 );
        callback::function_dc654a4d4126a928( #"hash_45277be78cb54c51", #"hash_6947ec89a1af6d69", &function_80569e83bd3abfbf );
        callback::function_dc654a4d4126a928( #"hash_3aba7df6443df11d", #"hash_6947ec89a1af6d69", &function_aaa1ceb9e48346dc );
        callback::function_dc654a4d4126a928( #"hash_2e3e0663aecb6f19", #"hash_6947ec89a1af6d69", &function_ceadb54c29c1a81a );
        callback::function_dc654a4d4126a928( #"hash_29eede2365f9349a", #"hash_6947ec89a1af6d69", &function_5a35159676e6e80d );
        callback::function_dc654a4d4126a928( #"hash_a836ce9ab43d9e2", #"hash_6947ec89a1af6d69", &on_zone_captured_cb );
        callback::function_dc654a4d4126a928( #"hash_e3206e8d5d3df1e3", #"hash_6947ec89a1af6d69", &function_af7aa9229b9eb5e8 );
        callback::function_dc654a4d4126a928( #"hash_300ad54dcc9beab1", #"hash_6947ec89a1af6d69", &function_d3f276c6e626d80 );
        callback::function_dc654a4d4126a928( #"hash_629949853fbabab8", #"hash_6947ec89a1af6d69", &function_7deb426f5232fa5f );
        
        if ( istrue( level.game_objects.var_5f329cd264226f08 ) )
        {
            utility::flag_wait( "cs_gameobjects_constructed" );
        }
        else
        {
            utility::flag_wait( "gameobject_system_post_init" );
            function_bf70e8e73e6ea0dc();
            waitframe();
        }
    }
    else
    {
        level thread setupzones();
        setkothwaypoints();
        seticonnames();
    }
    
    initspawns();
    
    if ( !koth_shared::is_enabled() )
    {
        if ( !level.zonerandomlocationorder )
        {
            remaphardpointorder();
        }
        
        level thread function_c9f2bf077a1911b2();
        level thread hardpointmainloop();
        
        if ( level.useFrontlineSpawns )
        {
            if ( !function_9340dd398350d3d0( #"hash_a46e50dfb2accb0d" ) )
            {
                level thread frontlinethink();
            }
        }
        
        /#
            level thread function_c44cad38144a7e70();
            level thread function_72b77b174bc3e293();
            level thread function_2a38489a87451203();
            level thread function_deb3339bd967f61e();
            level thread function_e943dce050e3f40d();
        #/
        
        return;
    }
    
    /#
        level thread function_e943dce050e3f40d();
    #/
    
    thread init_game_timer_thread();
}

// Namespace koth
// Params 0
// Checksum 0x833792ba, Offset: 0x1307
// Size: 0x139
function frontlinethink()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( isdefined( level.zone ) )
        {
            zone = level.zone;
            info = zone.trigger.script_noteworthy;
            
            /#
                if ( getdvarint( @"hash_71e755c6249ab661", 0 ) )
                {
                    select = getdvarint( @"hash_71e755c6249ab661", 0 );
                    
                    if ( select == 1 )
                    {
                        info = "<dev string:x71>";
                    }
                    
                    if ( select == 2 )
                    {
                        info = "<dev string:x72>";
                    }
                    
                    if ( select == 3 )
                    {
                        info = "<dev string:x7e>";
                    }
                }
            #/
            
            if ( info )
            {
                origin = zone.curorigin;
                
                /#
                    sphere( origin, 16, ( 1, 1, 1 ), 0, 10 );
                #/
                
                if ( info == "free_rotate" )
                {
                    function_3a3922697553fbc2();
                    enablefrontlinecriticalfactor( origin );
                }
                else
                {
                    angles = int( info );
                    dir = anglestoforward( ( 0, angles, 0 ) );
                    enablefrontlinecriticalfactor( origin, dir );
                }
            }
            else
            {
                function_3a3922697553fbc2();
            }
        }
        
        wait 0.5;
    }
}

// Namespace koth
// Params 0
// Checksum 0x9158e87f, Offset: 0x1448
// Size: 0x41
function updategametypedvars()
{
    common::updatecommongametypedvars();
    
    if ( game_utility_mp::matchmakinggame() && !game_utility_mp::isanymlgmatch() && getdvarint( @"hash_56937a1bd450393d", 15 ) != 0 )
    {
        level.zoneactivationdelay = adjustzoneactivationdelayforlargemaps();
    }
}

// Namespace koth
// Params 0
// Checksum 0x3f2d89f4, Offset: 0x1491
// Size: 0x4b, Type: bool
function function_54cc863ef55e7de4()
{
    if ( level.scoremod[ "kill" ] > 0 && dialog_utility::dialogueexists( #"boost_groundwar", self.team ) )
    {
        dialog::leaderdialogonplayer( #"boost_groundwar", "introboost" );
        return true;
    }
    
    return false;
}

// Namespace koth
// Params 0
// Checksum 0xcf8908bb, Offset: 0x14e5
// Size: 0x87
function adjustzoneactivationdelayforlargemaps()
{
    mapname = game_utility::getmapname();
    
    switch ( mapname )
    {
        case #"hash_62c07791a2eda185":
        case #"hash_f09747c9feb47eb1":
        case #"hash_fcab5810ee4c6dc2":
            return getdvarint( @"hash_56937a1bd450393d", 15 );
        case #"hash_a8b272dba33a4aed":
            return ( getdvarint( @"hash_56937a1bd450393d", 15 ) + 15 );
        default:
            return level.zoneactivationdelay;
    }
}

// Namespace koth
// Params 0
// Checksum 0x1bf8ef86, Offset: 0x1574
// Size: 0x80
function seticonnames()
{
    level.icontarget = "koth_target";
    level.iconneutral = "koth_neutral";
    level.iconcapture = "koth_destroy";
    level.icondefend = "koth_defend";
    level.iconcontested = "koth_contested";
    level.icontaking = "koth_taking";
    level.iconlosing = "koth_losing";
    level.icondefending = "koth_defending";
    level.iconnext = "koth_next";
}

// Namespace koth
// Params 0
// Checksum 0xad42a020, Offset: 0x15fc
// Size: 0x595
function hardpointmainloop()
{
    level endon( #"game_ended" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    setomnvar( "ui_hardpoint_timer", 0 );
    level.zone = getfirstzone();
    firstzone = 1;
    level.var_be2c827a0dff398b = 1;
    level.kothhillrotation = 0;
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    level.favorclosespawnent = level.zone;
    telemetry_data = spawnstruct();
    telemetry_data.player = level.zone;
    telemetry_data.eventname = "hill_moved";
    telemetry_data.position = level.zone.trigger.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    gameplay_sound_fx::function_28103d3430792dce( level.zone.trigger.origin, #"hash_a042f821efa3155c" );
    flags::gameflagwait( "prematch_done" );
    
    if ( level.pausemodetimer )
    {
        level gamelogic_mp::pausetimer();
    }
    
    setomnvar( "ui_objective_timer_stopped", 0 );
    level.zone obj_zonecapture::activatezone();
    level.zone gameobjects::setvisibleteam( "any" );
    level.zone gameobjects::setobjectivestatusicons( level.icontarget );
    level.zone.active = 1;
    var_3cfcfd857dedb22b = 0;
    
    if ( level.firstzoneactivationdelay )
    {
        var_3cfcfd857dedb22b = 1;
        level.zoneendtime = int( gettime() + level.firstzoneactivationdelay * 1000 );
        level.var_bb021b9622bb5bba = int( gettime() + ( level.firstzoneactivationdelay + level.zoneduration ) * 1000 );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 12 );
        level.zoneislocked = 1;
        
        if ( isdefined( level.zone.objidnum ) )
        {
            objective_lock( level.zone.objidnum, 1 );
        }
        
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"hash_3a0601d819e75e10", #"hash_3a0601d819e75e10" );
        gameplay_sound_fx::function_28103d3430792dce( level.zone.curorigin, #"hash_44446e4b71cd388b" );
        level thread waitthenplaynewobj();
        
        if ( level.gametypebundle.var_cfbfe6e7f54445d4 )
        {
            level.zone thread gameobjects::function_d7321ef757ecefd7( level.firstzoneactivationdelay );
        }
        
        wait level.firstzoneactivationdelay;
        level.zoneislocked = 0;
        
        if ( isdefined( level.zone.objidnum ) )
        {
            objective_lock( level.zone.objidnum, 0 );
        }
        
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"koth_zone_capture", #"koth_zone_capture" );
        gameplay_sound_fx::function_28103d3430792dce( level.zone.curorigin, #"hash_a042f821efa3155c" );
        codcaster_utils::function_3038b6eafc46c037( 5, "free" );
    }
    
    level.zone notify( #"hash_63d009bc3c724a01" );
    
    while ( true )
    {
        if ( !isdefined( level.mapcalloutsready ) )
        {
            level thread setupzonecallouts( firstzone );
        }
        
        level.objectivesetorder = 1;
        
        if ( level.pausemodetimer )
        {
            level gamelogic_mp::resumetimer();
        }
        
        waittillframeend();
        level.zone gameobjects::enableobject();
        level.zone.capturecount = 0;
        
        if ( level.codcasterenabled )
        {
            level.zone thread obj_zonecapture::trackgametypevips();
        }
        
        spawnlogic::clearlastteamspawns();
        function_bfc094fab36905d8( var_3cfcfd857dedb22b, firstzone );
        firstzone = 0;
        var_3cfcfd857dedb22b = 0;
        level.var_be2c827a0dff398b = 0;
        setomnvar( "ui_hq_status", 10 );
        spawnlogic::clearlastteamspawns();
        hpcaptureloop();
        ownerteam = level.zone gameobjects::getownerteam();
        
        if ( level.pausemodetimer )
        {
            level gamelogic_mp::resumetimer();
        }
        
        level.lastcaptureteam = undefined;
        level.zone killhardpointvfx();
        level.zone.active = 0;
        
        if ( level.usehpzonebrushes )
        {
            foreach ( player in level.players )
            {
                level.zone obj_zonecapture::hideplayerspecificbrushes( player );
            }
        }
        
        if ( level.objectives.size > 1 )
        {
            level.zone gameobjects::disableobject();
            level.zone gameobjects::allowuse( "none" );
            level.zone gameobjects::setownerteam( "neutral" );
            updateservericons( "zone_shift", 0 );
            level notify( #"zone_reset" );
            setomnvar( "ui_hq_status", -1 );
            spawn_next_zone();
        }
        
        wait 1;
    }
}

// Namespace koth
// Params 0
// Checksum 0xa34ca2c1, Offset: 0x1b99
// Size: 0x9f
function waitthenplaynewobj()
{
    if ( level.infilvotiming )
    {
        wait 9.5;
    }
    else
    {
        wait 7;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        dialog::statusdialog( #"hp_first", entry );
    }
}

// Namespace koth
// Params 0
// Checksum 0x84a01414, Offset: 0x1c40
// Size: 0x1a0
function killhardpointvfx()
{
    foreach ( player in level.players )
    {
        foreach ( hpvfx in player._hardpointeffect )
        {
            player._hardpointeffect = arrayremove( player._hardpointeffect, hpvfx );
            
            if ( isdefined( hpvfx ) )
            {
                hpvfx delete();
            }
        }
    }
    
    if ( isdefined( self.neutralhardpointfx ) && self.neutralhardpointfx.size > 0 )
    {
        foreach ( hpvfx in self.neutralhardpointfx )
        {
            hpvfx delete();
        }
    }
    
    self.neutralhardpointfx = [];
}

// Namespace koth
// Params 0
// Checksum 0x9bf5ecbb, Offset: 0x1de8
// Size: 0x2
function remaphardpointorder()
{
    
}

// Namespace koth
// Params 0
// Checksum 0x1cf003c1, Offset: 0x1df2
// Size: 0xee
function getfirstzone()
{
    if ( isdefined( level.remappedhpzoneorder ) )
    {
        zone = level.objectives[ level.remappedhpzoneorder[ 0 ] ];
        level.prevzoneindex = 0;
        level.futurezone = level.objectives[ level.remappedhpzoneorder[ 1 ] ];
    }
    else
    {
        zone = level.objectives[ "1" ];
        level.prevzoneindex = 1;
        level.activezone = zone;
        
        if ( level.objectives.size == 1 )
        {
            level.nextzone = zone;
        }
        else
        {
            level.nextzone = level.objectives[ "2" ];
        }
        
        level.futurezone = level.nextzone;
    }
    
    if ( isdefined( zone.trigger ) )
    {
        zone.trigger utility::trigger_on();
    }
    
    return zone;
}

// Namespace koth
// Params 0
// Checksum 0x49693ecb, Offset: 0x1ee9
// Size: 0x5dc
function getnextzone()
{
    level notify( #"hash_1b5bbffaef456a28" );
    
    if ( level.zonerandomlocationorder )
    {
        var_8493e175a66447ea = [];
        
        foreach ( entry in level.teamnamelist )
        {
            var_8493e175a66447ea[ entry ] = ( 0, 0, 0 );
        }
        
        livingplayers = game_utility_mp::getpotentiallivingplayers();
        
        foreach ( player in livingplayers )
        {
            if ( player.team == "spectator" )
            {
                continue;
            }
            
            var_8493e175a66447ea[ player.team ] += player.origin;
        }
        
        avgpos = [];
        
        foreach ( entry in level.teamnamelist )
        {
            players = teams::getteamdata( entry, "players" );
            teamsize = max( players.size, 1 );
            avgpos[ entry ] = var_8493e175a66447ea[ entry ] / teamsize;
        }
        
        if ( !isdefined( level.prevzonelist ) || isdefined( level.prevzonelist ) && level.prevzonelist.size == level.objectives.size - 1 )
        {
            level.prevzonelist = [];
        }
        
        level.prevzonelist[ level.prevzonelist.size ] = level.prevzoneindex;
        playerweight = 0.7;
        zoneweight = 0.3;
        bestzoneindex = undefined;
        bestcost = undefined;
        
        foreach ( objective in level.objectives )
        {
            skip = 0;
            
            foreach ( zoneindex in level.prevzonelist )
            {
                if ( objective.objectivekey == string( zoneindex ) )
                {
                    skip = 1;
                    break;
                }
            }
            
            if ( skip )
            {
                continue;
            }
            
            zone = objective;
            playercost = 0;
            
            foreach ( entry in level.teamnamelist )
            {
                playercost += distance2dsquared( zone.curorigin, avgpos[ entry ] );
            }
            
            zonecost = distance2dsquared( zone.curorigin, level.zone.curorigin );
            totalcost = playercost * playerweight + zonecost * zoneweight;
            
            if ( !isdefined( bestcost ) || totalcost > bestcost )
            {
                bestcost = totalcost;
                bestzoneindex = objective.objectivekey;
            }
        }
        
        zone = level.objectives[ bestzoneindex ];
        level.prevzoneindex = bestzoneindex;
    }
    else if ( isdefined( level.remappedhpzoneorder ) )
    {
        level.prevzoneindex++;
        
        if ( level.prevzoneindex > level.remappedhpzoneorder.size - 1 )
        {
            level.prevzoneindex = 0;
        }
        
        zone = level.objectives[ level.remappedhpzoneorder[ level.prevzoneindex ] ];
        futurezone = level.prevzoneindex + 1;
        
        if ( futurezone > level.remappedhpzoneorder.size - 1 )
        {
            futurezone = 0;
        }
        
        level.futurezone = level.objectives[ level.remappedhpzoneorder[ futurezone ] ];
    }
    else
    {
        level.prevzoneindex++;
        
        if ( level.prevzoneindex > level.objectives.size )
        {
            level.prevzoneindex = 1;
        }
        
        zone = level.objectives[ string( level.prevzoneindex ) ];
        futurezone = level.prevzoneindex + 1;
        
        if ( futurezone > level.objectives.size )
        {
            futurezone = 1;
        }
        
        level.futurezone = level.objectives[ string( futurezone ) ];
    }
    
    return zone;
}

// Namespace koth
// Params 1
// Checksum 0x2ec458f9, Offset: 0x24ce
// Size: 0x19f
function activatezone( firstactivation )
{
    zone = self;
    zone callback::add( "zone_unoccupied", &onunoccupied );
    zone callback::add( "zone_captured", &oncaptured );
    
    if ( !isdefined( zone.onplayerenter ) )
    {
        zone.onplayerenter = &onplayerenter;
    }
    
    if ( !isdefined( zone.onplayerexit ) )
    {
        zone.onplayerexit = &onplayerexit;
    }
    
    zone obj_zonecapture::activatezone();
    zone function_895b8e3d587396fa();
    zone function_d49fd1c2d04de373();
    function_89b712a46e53a1cf();
    matchtimems = matchdata::function_47550968a937b67e( gettime() );
    dlog_recordevent( "dlog_event_mp_objective_status", [ "key", zone.objectivekey, "match_time_ms", matchtimems, "is_active", 1 ] );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", zone.objectivekey, "team", "neutral", "match_time_ms", matchtimems ] );
    dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", zone.curorigin[ 0 ], "pos_y", zone.curorigin[ 1 ], "key", zone.objectivekey, "match_time_ms", matchtimems ] );
}

// Namespace koth
// Params 0
// Checksum 0x7aebfe8b, Offset: 0x2675
// Size: 0x78
function deactivatezone()
{
    dlog_recordevent( "dlog_event_mp_objective_status", [ "key", self.objectivekey, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "is_active", 0 ] );
    callback::remove( "zone_unoccupied", &onunoccupied );
    callback::remove( "zone_captured", &oncaptured );
    function_895b8e3d587396fa();
    obj_zonecapture::deactivatezone();
}

// Namespace koth
// Params 0
// Checksum 0xb4999fb9, Offset: 0x26f5
// Size: 0x17b
function spawn_next_zone()
{
    writecurrentrotationteamscore();
    level.var_dc73e2973c494042 = level.zone.lastclaimteam;
    level.zone deactivatezone();
    level.zone = getnextzone();
    level.kothhillrotation++;
    level.zone obj_zonecapture::activatezone();
    level.favorclosespawnent = level.zone;
    level.zone.active = 1;
    level.zone.lastactivatetime = gettime();
    
    if ( level.zoneactivationdelay > 0 )
    {
        level.zone gameobjects::setobjectivestatusicons( level.icontarget );
    }
    else
    {
        level.zone gameobjects::setobjectivestatusicons( level.iconneutral );
    }
    
    telemetry_data = spawnstruct();
    telemetry_data.player = level.zone;
    telemetry_data.eventname = "hill_moved";
    telemetry_data.position = level.zone.trigger.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    gameplay_sound_fx::function_28103d3430792dce( level.zone.trigger.origin, #"koth_zone_activated" );
}

// Namespace koth
// Params 0
// Checksum 0xde3710dd, Offset: 0x2878
// Size: 0x130
function function_d49fd1c2d04de373()
{
    self.spawninfluencers = [];
    origin = level.zone.trigger.origin;
    
    if ( spawnlogic::useablespawnset( self.spawnsetother ) )
    {
        self.spawninfluencers[ #"hash_7cebf9e340111eb7" ] = spawnlogic::addspawninfluencer( #"hash_7cebf9e340111eb7", origin );
        spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_7cebf9e340111eb7" ], self.spawnsetother );
    }
    
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        self.spawninfluencers[ #"gametype_hardpoint_zone" ] = spawnlogic::addspawninfluencer( #"gametype_hardpoint_zone", origin );
        
        if ( spawnlogic::useablespawnset( self.spawnset ) )
        {
            self.spawninfluencers[ #"hash_78d68ca5b33f3f12" ] = spawnlogic::addspawninfluencer( #"hash_78d68ca5b33f3f12", origin );
            spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_78d68ca5b33f3f12" ], self.spawnset );
        }
        
        function_6231e013f2407802();
    }
}

// Namespace koth
// Params 1
// Checksum 0x4b17832f, Offset: 0x29b0
// Size: 0x1bd
function function_6231e013f2407802( team = undefined )
{
    if ( isdefined( self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] ) )
    {
        spawnlogic::removespawninfluencer( self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] );
        self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] = undefined;
    }
    
    if ( isdefined( self.spawninfluencers[ #"hash_1c79f4698d55c968" ] ) )
    {
        spawnlogic::removespawninfluencer( self.spawninfluencers[ #"hash_1c79f4698d55c968" ] );
        self.spawninfluencers[ #"hash_1c79f4698d55c968" ] = undefined;
    }
    
    if ( !spawnlogic::useablespawnset( self.spawnsetanchor ) )
    {
        return;
    }
    
    origin = level.zone.trigger.origin;
    
    if ( !isdefined( team ) )
    {
        self.spawninfluencers[ #"hash_1c79f4698d55c968" ] = spawnlogic::addspawninfluencer( #"hash_1c79f4698d55c968", origin );
        spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_1c79f4698d55c968" ], self.spawnsetanchor );
        return;
    }
    
    self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] = spawnlogic::addspawninfluencer( #"hash_2592d46fa8cdaed3", origin, team );
    spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_2592d46fa8cdaed3" ], self.spawnsetanchor );
    self.spawninfluencers[ #"hash_1c79f4698d55c968" ] = spawnlogic::addspawninfluencer( #"hash_1c79f4698d55c968", origin, team );
    spawnlogic::influencersetspawnpointlist( self.spawninfluencers[ #"hash_1c79f4698d55c968" ], self.spawnsetanchor );
}

// Namespace koth
// Params 0
// Checksum 0xaa0ed5b6, Offset: 0x2b75
// Size: 0x92
function function_895b8e3d587396fa()
{
    if ( isdefined( self.spawninfluencers ) )
    {
        foreach ( influencer in self.spawninfluencers )
        {
            spawnlogic::removespawninfluencer( influencer );
        }
        
        self.spawninfluencers = undefined;
    }
}

// Namespace koth
// Params 1
// Checksum 0xaacd42ad, Offset: 0x2c0f
// Size: 0x185
function function_89b712a46e53a1cf( zones = 1 )
{
    /#
        activesets = [];
        colors = [];
        
        if ( zones )
        {
            if ( spawnlogic::useablespawnset( level.zone.spawnset ) )
            {
                activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( level.zone.spawnset );
                colors[ colors.size ] = ( 0, 0.75, 0 );
            }
            
            if ( spawnlogic::useablespawnset( level.zone.spawnsetanchor ) )
            {
                activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( level.zone.spawnsetanchor );
                colors[ colors.size ] = ( 1, 1, 0 );
            }
            
            if ( level.zone.spawnsetother != level.zone.spawnset && spawnlogic::useablespawnset( level.zone.spawnsetother ) )
            {
                activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( level.zone.spawnsetother );
                colors[ colors.size ] = ( 0.5, 0.5, 1 );
            }
        }
        else
        {
            activesets[ activesets.size ] = spawnlogic::function_d60214213fe813d( #"primary" );
            colors[ colors.size ] = ( 0, 0.75, 0 );
        }
        
        if ( activesets.size > 0 )
        {
            function_b5d53613b3891230( activesets, colors );
        }
    #/
}

// Namespace koth
// Params 2
// Checksum 0xe9826e36, Offset: 0x2d9c
// Size: 0x508
function function_bfc094fab36905d8( var_3cfcfd857dedb22b, firstzone )
{
    if ( firstzone )
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( #"obj_generic_capture", entry );
        }
    }
    else
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( #"hp_new_location", entry );
        }
    }
    
    /#
        if ( !isdefined( level.zone ) )
        {
            assertmsg( "<dev string:x81>" );
            level waittill( #"forever" );
        }
    #/
    
    if ( isdefined( level.zone.curorigin ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( level.zone.curorigin, #"hash_98349fc495d7c67e" );
    }
    
    level callback::callback( #"music_event", { #event_type:#"hq_new" } );
    level.zone thread obj_zonecapture::hardpoint_setneutral();
    level.zone gameobjects::allowuse( "none" );
    level.zone activatezone();
    
    if ( level.scoreeventglobals.var_a63e82103d31ac67 )
    {
        foreach ( player in level.players )
        {
            player.var_1f0eae9ac93b88db = 0;
        }
    }
    
    if ( var_3cfcfd857dedb22b )
    {
    }
    else if ( level.zoneactivationdelay )
    {
        level.zone gameobjects::setobjectivestatusicons( level.icontarget );
        updateservericons( "zone_activation_delay", 0 );
        level.zoneendtime = int( gettime() + 1000 * level.zoneactivationdelay );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 12 );
        objidpoolmanager::objective_showtimer( level.zone.objectiveid, 1 );
        
        if ( level.pausemodetimer )
        {
            level gamelogic_mp::pausetimer();
        }
        
        level.zoneislocked = 1;
        
        if ( isdefined( level.zone.objidnum ) )
        {
            objective_lock( level.zone.objidnum, 1 );
        }
        
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"hash_3a0601d819e75e10", #"hash_3a0601d819e75e10" );
        
        if ( level.gametypebundle.var_cfbfe6e7f54445d4 )
        {
            level.zone thread gameobjects::function_d7321ef757ecefd7( level.zoneactivationdelay );
        }
        
        wait level.zoneactivationdelay;
        level.zoneislocked = 0;
        
        if ( isdefined( level.zone.objidnum ) )
        {
            objective_lock( level.zone.objidnum, 0 );
        }
        
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"koth_zone_capture", #"koth_zone_capture" );
        gameplay_sound_fx::function_28103d3430792dce( level.zone.trigger.origin, #"hash_98349fc495d7c67e" );
        codcaster_utils::function_3038b6eafc46c037( 5, "free" );
    }
    
    objid = 1;
    level.futurezone gameobjects::setvisibleteam( "none", objid );
    level.zone gameobjects::setobjectivestatusicons( level.iconneutral );
    updateservericons( "neutral", 0 );
    
    if ( level.zoneduration )
    {
        updateservericons( "neutral", 0 );
        thread movezoneaftertime( level.zoneduration );
        level.zoneendtime = int( gettime() + 1000 * level.zoneduration );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        level.var_bb021b9622bb5bba = int( gettime() + ( level.zoneactivationdelay + level.zoneduration ) * 1000 );
        return;
    }
    
    level.zonedestroyedbytimer = 0;
}

// Namespace koth
// Params 0
// Checksum 0x6878adaa, Offset: 0x32ac
// Size: 0x21e
function hpcaptureloop()
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level.hpstarttime = gettime();
    
    while ( true )
    {
        level.zone gameobjects::allowuse( "enemy" );
        level.zone gameobjects::setvisibleteam( "any" );
        level.zone gameobjects::setusetext( &"mp/securing_position" );
        level.zone thread obj_zonecapture::hardpoint_setneutral();
        level.zone gameobjects::cancontestclaim( 1 );
        
        if ( isdefined( level.matchrules_droptime ) && level.matchrules_droptime )
        {
            level thread grnd::randomdrops();
        }
        
        msg = level utility::waittill_any_return( "zone_captured", "zone_destroyed" );
        
        if ( msg == "zone_destroyed" )
        {
            continue;
        }
        
        ownerteam = level.zone gameobjects::getownerteam();
        level childthread function_354e40f7cdc6b5c4( ownerteam );
        otherteam = team_utility::getotherteam( ownerteam );
        
        if ( getprojectname() == "ZUL" )
        {
            level.zone.trigger thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_d60bbf59cbc390b9", ownerteam );
            level.zone.trigger thread gameplay_sound_fx::function_6dac8db778849e61( #"hash_3f815ce3540d8525", otherteam );
        }
        else
        {
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_d60bbf59cbc390b9", teams::getteamdata( ownerteam, "players" ) );
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_3f815ce3540d8525", teams::getteamdata( otherteam, "players" ) );
        }
        
        level waittill( #"zone_destroyed", destroy_team );
        
        if ( isdefined( destroy_team ) )
        {
            level.zone gameobjects::setownerteam( destroy_team );
            continue;
        }
        
        level.zone gameobjects::setownerteam( "none" );
        gameplay_sound_fx::function_28103d3430792dce( level.zone.trigger.origin, #"koth_neutral_ping" );
    }
}

// Namespace koth
// Params 2
// Checksum 0xc53b4b1b, Offset: 0x34d2
// Size: 0x33
function addzonespawns( zone, spawnkey )
{
    spawnpoints = spawnlogic::getspawnpointarray( "mp_spawn_point", spawnkey, "spawn" );
}

// Namespace koth
// Params 0
// Checksum 0x96647342, Offset: 0x350d
// Size: 0x106
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey, 1 );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_koth_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_koth_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_koth_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_koth_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
    obj_zonecapture::function_c563aafed90e555e( level.objectives, spawnkey, "zone1" );
    mapinfo = getmapscriptbundle();
    level.var_9395f2a91234ced8 = mapinfo.playerspawn.var_b1b86dda63b48ce2;
}

// Namespace koth
// Params 2
// Checksum 0x124d7ca7, Offset: 0x361b
// Size: 0xe3, Type: bool
function comparezoneindexes( zone_a, zone_b )
{
    script_index_a = int( zone_a.objectivekey );
    script_index_b = int( zone_b.objectivekey );
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:xe8>" + zone_a.origin + "<dev string:x115>" + zone_b.origin );
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:xe8>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:xe8>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace koth
// Params 1
// Checksum 0x2b753080, Offset: 0x3707
// Size: 0xc2
function getzonearray( targetname )
{
    zones = getentarray( targetname, #targetname );
    
    foreach ( z in zones )
    {
        z.objectivekey = z.script_label;
    }
    
    if ( !isdefined( zones ) || zones.size == 0 )
    {
        return;
    }
    
    return arraysort( zones, undefined, &comparezoneindexes );
}

// Namespace koth
// Params 0
// Checksum 0xe779bffa, Offset: 0x37d2
// Size: 0x1af, Type: bool
function setupzones()
{
    primaryzones = getzonearray( "hardpoint_zone" );
    
    if ( primaryzones.size >= 3 && getprojectname() == "ZUL" )
    {
        secondaryzones = getzonearray( "hardpoint" );
        primaryzones = arraycombine( primaryzones, secondaryzones );
    }
    
    assert( isdefined( primaryzones ) && primaryzones.size >= 3, "<dev string:x117>" );
    triggers = [];
    
    for ( index = 0; index < primaryzones.size ; index++ )
    {
        triggers[ triggers.size ] = primaryzones[ index ];
    }
    
    level.objectives = [];
    
    foreach ( trigger in triggers )
    {
        zone = obj_zonecapture::setupobjective( trigger, undefined, undefined, 1 );
        
        if ( isdefined( trigger.iconname ) )
        {
            zone.iconname = trigger.iconname;
        }
        else
        {
            zone.iconname = zone gameobjects::getlabel();
        }
        
        level.objectives[ zone.objectivekey ] = zone;
    }
    
    objid = objidpoolmanager::requestreservedid( 1 );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::objective_playermask_showtoall( objid );
    setomnvar( "ui_hardpoint_active_zone_count", 2 );
    return true;
}

// Namespace koth
// Params 1
// Checksum 0x3c256d6b, Offset: 0x398a
// Size: 0x137
function setupzonecallouts( firstzone )
{
    areaid = undefined;
    zonetrigger = level.zone.visuals[ 0 ];
    
    if ( !isdefined( zonetrigger ) )
    {
        return;
    }
    
    if ( isdefined( zonetrigger.script_noteworthy ) )
    {
        areaid = level.calloutglobals.areaidmap[ zonetrigger.script_noteworthy ];
    }
    
    if ( !isdefined( areaid ) )
    {
        areaid = callouts::function_69298682a76ef6c5( zonetrigger );
    }
    
    if ( isdefined( areaid ) )
    {
        foreach ( player in level.players )
        {
            player setclientomnvar( "ui_hp_callout_id", areaid );
        }
    }
    
    if ( !firstzone )
    {
        codcaster_utils::function_3038b6eafc46c037( 4, "free" );
    }
    
    assert( isdefined( areaid ), "<dev string:x145>" + zonetrigger.script_label + "<dev string:x150>" );
}

// Namespace koth
// Params 1
// Checksum 0x385c2fb6, Offset: 0x3ac9
// Size: 0x5d
function onunoccupied( params )
{
    function_6231e013f2407802();
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", self.objectivekey, "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
}

// Namespace koth
// Params 1
// Checksum 0x855bbbf0, Offset: 0x3b2e
// Size: 0x6e
function oncaptured( params )
{
    function_6231e013f2407802( params.team );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", self.objectivekey, "team", params.team, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
}

// Namespace koth
// Params 1
// Checksum 0x98e3d9cc, Offset: 0x3ba4
// Size: 0x7c
function onplayerenter( player )
{
    player.var_c36e159445e2a48b = 0;
    player.var_b87cafbca06df20f = 1;
    
    if ( isdefined( self.callbacks[ #"hash_af5376dd4fc03b8f" ] ) || isdefined( level.callbacks[ #"hash_af5376dd4fc03b8f" ] ) )
    {
        callback::callback( #"hash_af5376dd4fc03b8f", { #zone:self, #enterplayer:player } );
    }
}

// Namespace koth
// Params 1
// Checksum 0xe9a7c349, Offset: 0x3c28
// Size: 0x82
function onplayerexit( player )
{
    player.var_c36e159445e2a48b = undefined;
    level.var_cf6229770b047f38[ player.guid ] = undefined;
    player.var_b87cafbca06df20f = undefined;
    
    if ( isdefined( self.callbacks[ #"hash_dcaaf3c8d874eeab" ] ) || isdefined( level.callbacks[ #"hash_dcaaf3c8d874eeab" ] ) )
    {
        callback::callback( #"hash_dcaaf3c8d874eeab", { #exitplayer:player } );
    }
}

// Namespace koth
// Params 0
// Checksum 0xa723ea47, Offset: 0x3cb2
// Size: 0x148
function getspawnpoint()
{
    var_ebfc366885697c15 = getkothzonedeadzonedist();
    var_1db36f52276b333e = gameobjects_shared::get_objective_key( level.zone );
    spawnparams = spawnfactor::function_daea503b73d07eed( var_1db36f52276b333e, level.zone.furthestspawndistsq, var_ebfc366885697c15 * var_ebfc366885697c15, 12250000 );
    spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self, spawnparams, level.zone.spawngroup, #"fallback", #"default", 2 );
    
    if ( isnavmeshloaded() && !spawnlogic::shoulduseteamstartspawn() && ( level.spawnglobals.gametypeplayerspawn.var_b1b86dda63b48ce2 || level.var_9395f2a91234ced8 ) )
    {
        path = self findpath( spawnpoint.origin, level.zone.trigger.origin, 1 );
        
        if ( isdefined( path ) && path.size > 2 )
        {
            fwd = vectornormalize( path[ 1 ] - path[ 0 ] );
            spawnpoint.angles = vectortoangles( fwd );
        }
    }
    
    return spawnpoint;
}

// Namespace koth
// Params 0
// Checksum 0x59f381f1, Offset: 0x3e03
// Size: 0x5
function getkothzonedeadzonedist()
{
    return 1000;
}

// Namespace koth
// Params 1
// Checksum 0xa1c1b479, Offset: 0x3e11
// Size: 0x29
function onspawnplayer( spawndata )
{
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self.forcespawnnearteammates = undefined;
    thread updatematchstatushintonspawn();
}

// Namespace koth
// Params 1
// Checksum 0xde8a863f, Offset: 0x3e42
// Size: 0x1f
function onplayerdisconnect( params )
{
    level.var_cf6229770b047f38[ self.guid ] = undefined;
}

// Namespace koth
// Params 1
// Checksum 0xc8966674, Offset: 0x3e69
// Size: 0x167
function movezoneaftertime( time )
{
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level endon( #"hash_a5281c9480b32767" );
    level.zonemovetime = time;
    level.zonedestroyedbytimer = 0;
    obj_zonecapture::zonetimerwait();
    objid = 1;
    level objidpoolmanager::returnreservedobjectiveid( objid, 0 );
    level objidpoolmanager::update_objective_state( objid, "done" );
    level objidpoolmanager::update_objective_position( objid, level.futurezone.visuals[ 0 ].origin + level.futurezone.offset3d );
    
    foreach ( var_bdac79500cb4bb60 in level.var_cf6229770b047f38 )
    {
        var_bdac79500cb4bb60.player points::doscoreevent( #"koth_60" );
    }
    
    level.var_cf6229770b047f38 = [];
    level.zonedestroyedbytimer = 1;
    level notify( #"zone_moved" );
    level notify( #"zone_destroyed" );
}

// Namespace koth
// Params 1
// Checksum 0x2cae2ebf, Offset: 0x3fd8
// Size: 0x712
function function_8314535b81f548e( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    objweapon = deathdata.objweapon;
    killid = deathdata.lifeid;
    
    if ( !isplayer( victim ) )
    {
        return;
    }
    
    if ( level.scoreeventglobals.var_78e819588dff740b )
    {
        victim.var_1f0eae9ac93b88db = 0;
    }
    
    if ( !isplayer( attacker ) || attacker.team == victim.team )
    {
        return;
    }
    
    if ( !attacker istouching( level.zone.trigger ) && !victim istouching( level.zone.trigger ) )
    {
        return;
    }
    
    var_2d8ceea01f49ef75 = ( level.zone.ownerteam == "all" || level.zone.ownerteam == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( level.zone.ownerteam ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( level.zone.ownerteam ) ? #"hash_ce911e3bbe99421f" : level.zone.ownerteam == "none" || level.zone.ownerteam == "neutral" ? #"hash_bb332da19f9944df" : undefined ) ?? namespace_277c922f0d0dc523::function_9b71aa2788e21706( level.zone );
    attackerteam = attacker.team == "all" || attacker.team == "tie" ? #"hash_a1360b18943e920" : game_utility_mp::is_attacker_team( attacker.team ) ? #"hash_7118f9343873352b" : game_utility_mp::is_defender_team( attacker.team ) ? #"hash_ce911e3bbe99421f" : attacker.team == "none" || attacker.team == "neutral" ? #"hash_bb332da19f9944df" : undefined;
    
    if ( isdefined( objweapon ) && weapon::iskillstreakweapon( objweapon.basename ) )
    {
        return;
    }
    
    if ( !isdefined( var_2d8ceea01f49ef75 ) )
    {
        return;
    }
    
    if ( var_2d8ceea01f49ef75 != attackerteam )
    {
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && level.zonecapturetime > 0 && attacker istouching( level.zone.trigger ) )
        {
            if ( isdefined( attacker.perks[ "specialty_interceptor" ] ) )
            {
                if ( !isdefined( attacker.perks[ "specialty_killstreak_to_scorestreak" ] ) )
                {
                    attacker thread points::givestreakpointswithtext( #"interceptor_intercepted", attacker.objweapon, attacker.var_76edfa1de0ff242e );
                    attacker thread points::doscoreevent( #"interceptor_intercepted", attacker.objweapon );
                }
            }
            
            attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
            attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
        }
        else if ( victim istouching( level.zone.trigger ) )
        {
            attacker thread rank::function_d2aa8986c506e985( #"assault" );
            attacker events::function_58da673c1c3fc9f2();
            attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
            attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
            victim thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
            attacker thread events::function_f3b6ddfecdb144fa( level.zone.objectivekey );
        }
        
        return;
    }
    
    if ( attacker istouching( level.zone.trigger ) )
    {
        value = level.zone.objectivekey;
        var_6e96ef3a633c62f3 = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i" ];
        
        if ( !arraycontains( var_6e96ef3a633c62f3, value ) )
        {
            value = var_6e96ef3a633c62f3[ int( value ) ];
        }
        
        attacker thread rank::function_d2aa8986c506e985( #"defend", value );
        attacker events::function_20a5f572df6afd43( { #extraparam:level.zone.objectivekey } );
        attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( attacker ) ) )
        {
            if ( isdefined( attacker.leaderboarddata[ "defends" ] ) )
            {
                attacker.leaderboarddata[ "defends" ] = attacker.leaderboarddata[ "defends" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "defends" ] ) )
            {
                [[ level.leaderboardfunc[ "defends" ] ]]( attacker, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c2>" );
            
            if ( isdefined( attacker.pers[ "defends" ] ) )
            {
                attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
            }
        }
        
        attacker codcasterclientmatchdata::function_8ecc753b54a5740f( 11, 1 );
        attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
        attacker stats::setextrascore1( attacker.pers[ "defends" ] );
        
        if ( isdefined( attacker.perks[ "specialty_interceptor" ] ) )
        {
            if ( !isdefined( attacker.perks[ "specialty_killstreak_to_scorestreak" ] ) )
            {
                attacker killstreaks::givestreakpoints( #"interceptor_intercepted", 1 );
                attacker thread points::doscoreevent( #"interceptor_intercepted" );
            }
        }
        
        if ( !isdefined( attacker.var_c36e159445e2a48b ) )
        {
            attacker.var_c36e159445e2a48b = 0;
        }
        
        attacker.var_c36e159445e2a48b++;
        
        if ( attacker.var_c36e159445e2a48b == 5 )
        {
            attacker thread events::function_d4fd7d540188e407();
        }
    }
}

// Namespace koth
// Params 1, eflags: 0xc
// Checksum 0x12293e25, Offset: 0x46f2
// Size: 0x94
function private function_354e40f7cdc6b5c4( ownerteam )
{
    self notify( #"hash_1f22d49bf189667b" );
    self endon( #"hash_1f22d49bf189667b" );
    graceperiod = gettime() - level.hpstarttime;
    
    if ( graceperiod > 2100 )
    {
        return;
    }
    
    if ( !isdefined( level.zone.touchlist ) )
    {
        return;
    }
    
    if ( graceperiod > 0 )
    {
        wait graceperiod * 0.001;
    }
    
    level.var_cf6229770b047f38 = arraycopy( level.zone.touchlist[ ownerteam ] );
}

// Namespace koth
// Params 6
// Checksum 0xd9b64281, Offset: 0x478e
// Size: 0x7bc
function give_capture_credit( touchlist, capturetime, capture_team, lastcaptureteam, credit_player, gameobject )
{
    level endon( #"game_ended" );
    
    if ( koth_shared::is_enabled() )
    {
        return;
    }
    
    level.lastcaptime = gettime();
    
    if ( isdefined( lastcaptureteam ) && lastcaptureteam != capture_team )
    {
        if ( level.scoreeventglobals.var_4a79312b90f5d2d4 )
        {
            foreach ( player in teams::getteamdata( lastcaptureteam, "players" ) )
            {
                player.var_1f0eae9ac93b88db = 0;
            }
        }
    }
    
    first_player = credit_player;
    var_cca651fd3375b9c2 = credit_player;
    
    if ( !isdefined( first_player.lastcaptime ) )
    {
        timesincelastcap = 10000;
    }
    else
    {
        timesincelastcap = gettime() - first_player.lastcaptime;
    }
    
    first_player.lastcaptime = gettime();
    
    if ( gameobjects::function_e17a356e69f57699( first_player ) && first_player.owner && !arraycontains( touchlist, first_player.owner ) )
    {
        first_player callback::callback( #"hash_a4b2d4dcbb4cda95", { #capturebot:first_player } );
    }
    
    first_player = gameobjects::function_96e1d4c0c873649( first_player );
    
    if ( isplayer( first_player ) )
    {
        first_player stats::setextrascore2( first_player.pers[ "extrascore2" ] + 1 );
        telemetry_data = {};
        telemetry_data.player = first_player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = first_player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        var_ba2253fbfbdf9ee5 = level.var_65de76cd5bea6b26 == level.zone.objectivekey;
        
        if ( !var_ba2253fbfbdf9ee5 )
        {
            first_player thread points::doscoreevent( #"koth_first_cap" );
            level.var_65de76cd5bea6b26 = level.zone.objectivekey;
        }
        
        first_player notify( #"player_zone_captured", level.zone.objectivekey );
        
        if ( isexcessivescoreboosting( first_player ) && !game_utility_mp::isanymlgmatch() )
        {
        }
        else if ( timesincelastcap < 2100 && gettime() - first_player.lastkilltime > 2100 )
        {
            if ( var_cca651fd3375b9c2 != first_player )
            {
                first_player thread points::doscoreevent( #"hp_secure_capture_bot_reduced" );
            }
            else
            {
                first_player thread rank::scoreeventpopup( #"hp_secure" );
                first_player thread points::doscoreevent( #"mode_hp_secure_tiny" );
            }
        }
        else if ( !isscoreboosting( first_player ) )
        {
            if ( var_cca651fd3375b9c2 != first_player )
            {
                first_player thread points::doscoreevent( #"hp_secure_capture_bot" );
            }
            else
            {
                first_player thread rank::function_d2aa8986c506e985( #"hp_secure" );
                first_player thread smoke_grenade::function_99543ad5d551cdb5();
                
                if ( var_ba2253fbfbdf9ee5 )
                {
                    first_player thread points::doscoreevent( #"mode_hp_secure_reduced" );
                }
                else
                {
                    first_player thread points::doscoreevent( #"mode_hp_secure" );
                }
            }
        }
        else if ( var_cca651fd3375b9c2 != first_player )
        {
            first_player thread points::doscoreevent( #"hp_secure_capture_bot_reduced" );
        }
        else
        {
            first_player thread rank::function_d2aa8986c506e985( #"hp_secure" );
            first_player thread points::doscoreevent( #"mode_hp_secure_reduced" );
        }
        
        if ( isdefined( level.zone.lastactivatetime ) && gettime() - level.zone.lastactivatetime <= 2100 )
        {
            if ( var_cca651fd3375b9c2 != first_player )
            {
                first_player thread points::doscoreevent( #"hp_quick_cap_capture_bot" );
            }
            else
            {
                if ( level.var_dc73e2973c494042 === first_player.team )
                {
                    first_player thread points::doscoreevent( #"koth_quick_cap" );
                    first_player challenges::function_24c3c132db024c21();
                }
                
                first_player thread rank::scoreeventpopup( #"hp_quick_cap" );
                first_player thread points::doscoreevent( #"mode_hp_quick_cap" );
            }
        }
        
        if ( first_player.lastkilltime + 500 <= gettime() )
        {
            if ( isdefined( level.var_f0e13be5ddad6cd1 ) )
            {
                first_player [[ level.var_f0e13be5ddad6cd1 ]]( first_player );
            }
        }
    }
    
    players = [];
    playerskeys = getarraykeys( touchlist );
    
    for ( i = 0; i < playerskeys.size ; i++ )
    {
        players[ i ] = touchlist[ playerskeys[ i ] ].player;
    }
    
    foreach ( player in players )
    {
        var_a1e1f51d44e98f43 = player;
        player = gameobjects::function_96e1d4c0c873649( player );
        player updatecapsperminute( lastcaptureteam );
        
        if ( !isscoreboosting( player ) )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "captures" ] ) )
                {
                    player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
                {
                    [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c2>" );
                
                if ( isdefined( player.pers[ "captures" ] ) )
                {
                    player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
                }
            }
            
            player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
        }
        else
        {
            /#
                player iprintlnbold( "<dev string:x1e8>" );
            #/
        }
        
        if ( first_player != player )
        {
            if ( var_a1e1f51d44e98f43 != player )
            {
                player thread points::doscoreevent( #"capture_assist_capture_bot" );
            }
            else
            {
                player thread rank::function_d2aa8986c506e985( #"capture_assist" );
                player thread points::doscoreevent( #"mode_dom_secure_assist" );
            }
            
            if ( isdefined( level.var_f0e13be5ddad6cd1 ) )
            {
                player [[ level.var_f0e13be5ddad6cd1 ]]( player );
            }
        }
        
        wait 0.05;
    }
    
    if ( isdefined( gameobject.assisttouchlist ) )
    {
        if ( gameobject.assisttouchlist[ capture_team ].size > 0 )
        {
            foreach ( player in players )
            {
                gameobject.assisttouchlist[ capture_team ][ player.guid ] = undefined;
            }
        }
        
        if ( gameobject.assisttouchlist[ capture_team ].size > 0 )
        {
            gameobject thread function_c44fa6c6495cc10c( capture_team );
        }
    }
}

// Namespace koth
// Params 1
// Checksum 0xc873bc9, Offset: 0x4f52
// Size: 0x251
function function_c44fa6c6495cc10c( team )
{
    level endon( #"game_ended" );
    var_e1fea56171575e06 = getarraykeys( self.assisttouchlist[ team ] );
    
    if ( var_e1fea56171575e06.size > 0 )
    {
        for ( index = 0; index < var_e1fea56171575e06.size ; index++ )
        {
            player = self.assisttouchlist[ team ][ var_e1fea56171575e06[ index ] ].player;
            var_a1e1f51d44e98f43 = player;
            
            if ( !isplayer( player ) )
            {
                if ( isdefined( player.owner ) )
                {
                    if ( gameobjects::function_e17a356e69f57699( player ) && isplayer( player.owner ) )
                    {
                        var_a1e1f51d44e98f43 = player;
                        player = player.owner;
                    }
                    else
                    {
                        continue;
                    }
                }
                else
                {
                    continue;
                }
            }
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "captures" ] ) )
                {
                    player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
                {
                    [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c2>" );
                
                if ( isdefined( player.pers[ "captures" ] ) )
                {
                    player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
                }
            }
            
            player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
            
            if ( var_a1e1f51d44e98f43 != player )
            {
                player thread points::doscoreevent( #"capture_assist_capture_bot" );
            }
            else
            {
                player thread rank::function_d2aa8986c506e985( #"capture_assist" );
                player thread points::doscoreevent( #"mode_dom_secure_assist" );
            }
            
            if ( isdefined( level.var_f0e13be5ddad6cd1 ) )
            {
                player [[ level.var_f0e13be5ddad6cd1 ]]( player );
            }
            
            self.assisttouchlist[ team ][ var_e1fea56171575e06[ index ] ] = undefined;
            wait 0.05;
        }
    }
}

// Namespace koth
// Params 0
// Checksum 0xb425916f, Offset: 0x51ab
// Size: 0x5d2
function awardcapturepoints()
{
    self notify( #"hash_c1937d1f0315584e" );
    self endon( #"hash_c1937d1f0315584e" );
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level endon( #"zone_moved" );
    level endon( #"zone_unoccupied" );
    level endon( #"zone_contested" );
    
    if ( koth_shared::is_enabled() )
    {
        return;
    }
    
    seconds = 1;
    score = 1;
    
    while ( !level.gameended )
    {
        for ( waittime = 0; waittime < seconds && !level.gameended ; waittime = 0 )
        {
            wait level.framedurationseconds;
            hostmigration::waittillhostmigrationdone();
            waittime += level.framedurationseconds;
            
            if ( level.zone.stalemate )
            {
            }
        }
        
        team = gameobjects_shared::function_623b07f4735aecb2( level.zone );
        
        if ( team == "neutral" || team == "none" )
        {
            continue;
        }
        
        if ( level.gameended )
        {
            break;
        }
        
        if ( !level.zone.stalemate && !level.gameended )
        {
            if ( level.zoneadditivescoring )
            {
                score = level.zone.touchlist[ team ].size;
            }
            
            gamescore::giveteamscoreforobjective( team, score, 0 );
            players = gameobjects_shared::function_de2f4638a165d21c( level.zone, team );
            
            foreach ( player in players )
            {
                currplayer = player;
                var_a1e1f51d44e98f43 = player;
                currplayer = gameobjects::function_96e1d4c0c873649( currplayer );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( currplayer ) ) )
                {
                    if ( isdefined( currplayer.leaderboarddata[ "objTime" ] ) )
                    {
                        currplayer.leaderboarddata[ "objTime" ] = currplayer.leaderboarddata[ "objTime" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
                    {
                        [[ level.leaderboardfunc[ "objTime" ] ]]( currplayer, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c2>" );
                    
                    if ( isdefined( currplayer.pers[ "objTime" ] ) )
                    {
                        currplayer.pers[ "objTime" ] = currplayer.pers[ "objTime" ] + 1;
                    }
                }
                
                currplayer codcasterclientmatchdata::function_8ecc753b54a5740f( 0, 1 );
                var_52effe84a620f8dc = "obj" + level.zone.trigger.script_label + "Time";
                
                if ( isdefined( currplayer.pers[ var_52effe84a620f8dc ] ) )
                {
                    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( currplayer ) ) )
                    {
                        if ( isdefined( currplayer.leaderboarddata[ var_52effe84a620f8dc ] ) )
                        {
                            currplayer.leaderboarddata[ var_52effe84a620f8dc ] += 1;
                        }
                        
                        if ( isdefined( level.leaderboardfunc[ var_52effe84a620f8dc ] ) )
                        {
                            [[ level.leaderboardfunc[ var_52effe84a620f8dc ] ]]( currplayer, 1 );
                        }
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c2>" );
                        
                        if ( isdefined( currplayer.pers[ var_52effe84a620f8dc ] ) )
                        {
                            currplayer.pers[ var_52effe84a620f8dc ] += 1;
                        }
                    }
                }
                
                if ( isdefined( currplayer.timebyrotation[ level.kothhillrotation ] ) )
                {
                    currplayer.timebyrotation[ level.kothhillrotation ]++;
                }
                else
                {
                    currplayer.timebyrotation[ level.kothhillrotation ] = 1;
                }
                
                currplayer persistence::statsetchild( "round", "objTime", currplayer.pers[ "objTime" ] );
                currplayer stats::setextrascore0( currplayer.pers[ "objTime" ] );
                scoreeventinterval = level.scoreeventglobals.var_f244d41a6bc4a67d ?? 4;
                
                if ( currplayer.var_1f0eae9ac93b88db >= scoreeventinterval )
                {
                    currplayer.var_1f0eae9ac93b88db = 0;
                    
                    if ( game_utility_mp::getbasegametype() == "koth" )
                    {
                        if ( var_a1e1f51d44e98f43 != currplayer )
                        {
                            currplayer thread points::doscoreevent( #"koth_in_obj_capture_bot" );
                        }
                        else
                        {
                            currplayer thread points::doscoreevent( #"koth_in_obj" );
                        }
                    }
                    else if ( game_utility::getgametype() == "grnd" )
                    {
                        currplayer thread points::doscoreevent( #"grnd_in_obj", undefined, 15 );
                    }
                    
                    continue;
                }
                
                if ( !isdefined( currplayer.var_1f0eae9ac93b88db ) )
                {
                    currplayer.var_1f0eae9ac93b88db = 0;
                }
                
                currplayer.var_1f0eae9ac93b88db++;
                
                if ( !level.scoreeventglobals.var_c21da95c189c7f73 )
                {
                    if ( var_a1e1f51d44e98f43 != currplayer )
                    {
                        currplayer gamescore::giveplayerscore( #"koth_in_obj_capture_bot", 3 );
                        continue;
                    }
                    
                    currplayer gamescore::giveplayerscore( #"koth_in_obj", 10 );
                }
            }
        }
        
        if ( level.var_17e49e99dd8e9feb )
        {
            gamelogic_mp::default_ontimelimit();
        }
    }
}

// Namespace koth
// Params 1
// Checksum 0xb4ac7882, Offset: 0x5785
// Size: 0xd6
function updatecapsperminute( lastownerteam )
{
    if ( !isdefined( self.capsperminute ) )
    {
        self.numcaps = 0;
        self.capsperminute = 0;
    }
    
    if ( !isdefined( lastownerteam ) || lastownerteam == "neutral" )
    {
        return;
    }
    
    self.numcaps++;
    minutespassed = game_utility::gettimepassed() / 60000;
    
    if ( isplayer( self ) && isdefined( self.timeplayed[ "total" ] ) )
    {
        minutespassed = self.timeplayed[ "total" ] / 60;
    }
    
    if ( minutespassed > 0 )
    {
        self.capsperminute = self.numcaps / minutespassed;
    }
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace koth
// Params 1
// Checksum 0x77032ac7, Offset: 0x5863
// Size: 0x1a, Type: bool
function isscoreboosting( player )
{
    return player.capsperminute > 3;
}

// Namespace koth
// Params 1
// Checksum 0xdfb86de0, Offset: 0x5886
// Size: 0x1a, Type: bool
function isexcessivescoreboosting( player )
{
    return player.capsperminute > 5;
}

// Namespace koth
// Params 1
// Checksum 0xdd1e6fe6, Offset: 0x58a9
// Size: 0x135
function onplayerconnect( player )
{
    player._hardpointeffect = [];
    player.numcaps = 0;
    player.capsperminute = 0;
    player.timebyrotation = [];
    player stats::setextrascore0( player.pers[ "objTime" ] ?? 0, "objTime" );
    player stats::setextrascore1( player.pers[ "defends" ] ?? 0, "defends" );
    thread onplayerspawned( player );
    
    foreach ( zone in level.objectives )
    {
        if ( level.usehpzonebrushes )
        {
            zone obj_zonecapture::hideplayerspecificbrushes( player );
        }
    }
    
    player thread refreshfreecamhardpointfx();
    player callback::add( #"player_disconnect", &onplayerdisconnect );
}

// Namespace koth
// Params 1
// Checksum 0xd889bdf2, Offset: 0x59e6
// Size: 0xd4
function onplayerspawned( params )
{
    while ( true )
    {
        self waittill( #"spawned" );
        
        foreach ( zone in level.objectives )
        {
            if ( zone.active )
            {
                if ( zone.ownerteam == "neutral" )
                {
                    zone obj_zonecapture::playhardpointneutralfx();
                    continue;
                }
                
                zone obj_zonecapture::showcapturedhardpointeffecttoplayer( zone.ownerteam, self );
            }
        }
    }
}

// Namespace koth
// Params 2
// Checksum 0x8f3440b4, Offset: 0x5ac2
// Size: 0xa1
function updateservericons( state, contested )
{
    omnvarval = -1;
    
    if ( contested )
    {
        omnvarval = -2;
    }
    else if ( team_utility::isgameplayteam( state ) )
    {
        player = getownerteamplayer( state );
        
        if ( isdefined( player ) )
        {
            omnvarval = player getentitynumber();
        }
    }
    else
    {
        switch ( state )
        {
            case #"hash_3bf8ec5fe1d42da8":
                omnvarval = -3;
                break;
            case #"hash_c312107e6bce703c":
            default:
                break;
        }
    }
    
    setomnvar( "ui_hardpoint", omnvarval );
}

// Namespace koth
// Params 1
// Checksum 0x61c9c430, Offset: 0x5b6b
// Size: 0xa1
function getownerteamplayer( ownerteam )
{
    ownerplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( player.team == ownerteam )
        {
            ownerplayer = player;
            break;
        }
    }
    
    return ownerplayer;
}

// Namespace koth
// Params 0
// Checksum 0x1eceddbf, Offset: 0x5c15
// Size: 0xe7
function refreshfreecamhardpointfx()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, view );
        
        if ( channel == "mlg_view_change" )
        {
            foreach ( zone in level.objectives )
            {
                if ( zone.ownerteam != "neutral" )
                {
                    zone obj_zonecapture::showcapturedhardpointeffecttoplayer( zone.ownerteam, self );
                }
            }
        }
    }
}

// Namespace koth
// Params 0
// Checksum 0x3e3e022e, Offset: 0x5d04
// Size: 0x4e
function getrespawndelay()
{
    if ( !level.delayplayer )
    {
        return;
    }
    
    if ( level.spawndelay > 0 )
    {
        if ( self.pers[ "team" ] == level.zone.ownerteam )
        {
            return level.spawndelay;
        }
    }
}

// Namespace koth
// Params 0
// Checksum 0xa0c99e54, Offset: 0x5d5b
// Size: 0x16
function writeplayerrotationscoretomatchdataongameend()
{
    level waittill( #"game_ended" );
    writecurrentrotationteamscore();
}

// Namespace koth
// Params 0
// Checksum 0x7767edb, Offset: 0x5d79
// Size: 0x49
function writecurrentrotationteamscore()
{
    if ( level.kothhillrotation < 24 )
    {
        setmatchdata( "alliesRoundScore", level.kothhillrotation, getteamscore( "allies" ) );
        setmatchdata( "axisRoundScore", level.kothhillrotation, getteamscore( "axis" ) );
    }
}

// Namespace koth
// Params 0
// Checksum 0x3218fe3b, Offset: 0x5dca
// Size: 0x2dc
function setkothwaypoints()
{
    foreach ( obj in level.objectives )
    {
        iconimage = "icon_waypoint_koth";
        
        if ( isdefined( level.gametypebundle ) && isdefined( level.gametypebundle.var_f4393a5b1d902a05 ) && isdefined( level.gametypebundle.var_f4393a5b1d902a05[ int( obj.objectivekey ) - 1 ].objectiveicon ) && level.gametypebundle.var_f4393a5b1d902a05[ int( obj.objectivekey ) - 1 ].objectiveicon != %"" )
        {
            iconimage = level.gametypebundle.var_f4393a5b1d902a05[ int( obj.objectivekey ) - 1 ].objectiveicon;
        }
        
        gamelogic_mp::setwaypointiconinfo( "koth_neutral" + obj.objectivekey, 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_target" + obj.objectivekey, 0, "neutral", &"MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2 );
        gamelogic_mp::setwaypointiconinfo( "koth_next" + obj.objectivekey, 0, "neutral", &"MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_locked", 0, 2 );
        gamelogic_mp::setwaypointiconinfo( "koth_taking" + obj.objectivekey, 0, "friendly", &"mp_ingame_only/obj_destroying_caps", iconimage, 1, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_defend" + obj.objectivekey, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_defending" + obj.objectivekey, 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_destroy" + obj.objectivekey, 0, "enemy", &"mp_ingame_only/obj_reclaim", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_losing" + obj.objectivekey, 0, "enemy", &"mp_ingame_only/obj_reclaim", iconimage, 0, 1 );
        gamelogic_mp::setwaypointiconinfo( "koth_contested" + obj.objectivekey, 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", iconimage, 0, 1 );
    }
}

// Namespace koth
// Params 0
// Checksum 0x36d73155, Offset: 0x60ae
// Size: 0x3d
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    
    if ( level.zoneislocked )
    {
        hud_message::function_ef4318a0090caa0f( #"hash_3a0601d819e75e10" );
        return;
    }
    
    hud_message::function_ef4318a0090caa0f( #"koth_zone_capture" );
}

// Namespace koth
// Params 0
// Checksum 0x651afa43, Offset: 0x60f3
// Size: 0x2a
function function_c9f2bf077a1911b2()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"zone_moved" );
        function_4fe9d676b66d3330();
    }
}

// Namespace koth
// Params 0
// Checksum 0xbffdb94e, Offset: 0x6125
// Size: 0x89
function function_4fe9d676b66d3330()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player codcasterclientmatchdata::function_35da766061f19c58( 3, 1 );
    }
}

// Namespace koth
// Params 0
// Checksum 0xb6ce4f82, Offset: 0x61b6
// Size: 0x184
function function_7c13860f63af063f()
{
    level endon( #"game_ended" );
    level endon( #"hash_cbc7e4fe8790aa90" );
    level endon( #"zone_moved" );
    level endon( #"zone_destroyed" );
    timeincrement = level.framedurationseconds;
    zone = self;
    
    while ( true )
    {
        waitframe();
        
        foreach ( team in level.teamnamelist )
        {
            foreach ( object in zone.touchlist[ team ] )
            {
                player = object.player;
                
                if ( isdefined( player.owner ) )
                {
                    player = player.owner;
                }
                
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                player codcasterclientmatchdata::function_35da766061f19c58( 5, timeincrement );
            }
        }
    }
}

// Namespace koth
// Params 0
// Checksum 0x61e7d7e6, Offset: 0x6342
// Size: 0x5e
function ontimelimit()
{
    winner = gamescore::gethighestscoringteam();
    
    if ( winner != "tie" || level.disableOverTime )
    {
        gamelogic_mp::default_ontimelimit();
        return;
    }
    
    if ( !level.var_17e49e99dd8e9feb )
    {
        hud_message::showerrormessagetoallplayers( %"mp_ingame_only/koth_overtime_warning" );
        level.var_17e49e99dd8e9feb = 1;
    }
}

/#

    // Namespace koth
    // Params 3
    // Checksum 0x1b8372c7, Offset: 0x63a8
    // Size: 0xaa, Type: dev
    function drawpoint( org, size, color )
    {
        for ( i = 0; i < 10 ; i++ )
        {
            a1 = i / 10 * 360;
            a2 = ( i + 1 ) / 10 * 360;
            pt1 = org + ( cos( a1 ), sin( a1 ), 0 ) * size;
            pt2 = org + ( cos( a2 ), sin( a2 ), 0 ) * size;
            line( pt1, pt2, color );
        }
    }

    // Namespace koth
    // Params 0
    // Checksum 0xa984a50f, Offset: 0x645a
    // Size: 0x37b, Type: dev
    function kothdebug()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_kothdebug" ) != 1 )
            {
                wait 2;
                continue;
            }
            
            while ( true )
            {
                if ( getdvarint( @"scr_kothdebug" ) != 1 )
                {
                    break;
                }
                
                if ( !isdefined( level.players ) || level.players.size <= 0 )
                {
                    wait 0.05;
                    continue;
                }
                
                bestdistsq = 999999999;
                bestradio = level.radios[ 0 ];
                
                foreach ( radio in level.radios )
                {
                    distsq = distancesquared( radio.origin, level.players[ 0 ].origin );
                    
                    if ( distsq < bestdistsq )
                    {
                        bestdistsq = distsq;
                        bestradio = radio;
                    }
                }
                
                foreach ( radio in level.radios )
                {
                    if ( radio != bestradio )
                    {
                        drawpoint( radio.origin, 50, ( 0.5, 0.5, 0.5 ) );
                    }
                }
                
                radio = bestradio;
                drawpoint( radio.origin, 100, ( 1, 1, 1 ) );
                
                foreach ( spawnpoint in radio.outerspawns )
                {
                    line( radio.origin, spawnpoint.origin, ( 1, 0.5, 0.5 ) );
                    drawpoint( spawnpoint.origin, 20, ( 1, 0.5, 0.5 ) );
                }
                
                foreach ( spawnpoint in radio.nearspawns )
                {
                    line( radio.origin + ( 0, 0, 10 ), spawnpoint.origin + ( 0, 0, 10 ), ( 0.5, 1, 0.5 ) );
                    drawpoint( spawnpoint.origin, 30, ( 0.5, 1, 0.5 ) );
                }
                
                wait 0.05;
            }
        }
    }

    // Namespace koth
    // Params 0
    // Checksum 0xdcc2b494, Offset: 0x67dd
    // Size: 0x7a, Type: dev
    function function_c44cad38144a7e70()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_4806172df45de691" ) != 0 )
            {
                level notify( #"hash_a5281c9480b32767" );
                level.zoneduration = 10000;
                break;
            }
            
            wait 1;
        }
        
        thread movezoneaftertime( level.zoneduration );
        level.var_9e6909b34421b063 = 1;
        setdevdvar( @"hash_4806172df45de691", 0 );
        thread function_c44cad38144a7e70();
    }

    // Namespace koth
    // Params 0
    // Checksum 0x6b22862d, Offset: 0x685f
    // Size: 0xc4, Type: dev
    function function_72b77b174bc3e293()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_796deaab0da995a1" ) != 0 )
            {
                level notify( #"hash_a5281c9480b32767" );
                level.zoneduration = 1;
                level.nextzonerevealtime = 1;
                break;
            }
            
            wait 1;
        }
        
        thread movezoneaftertime( level.zoneduration );
        setdevdvar( @"hash_796deaab0da995a1", 0 );
        
        if ( isdefined( level.var_9e6909b34421b063 ) && level.var_9e6909b34421b063 )
        {
            level.zoneduration = 10000;
        }
        else
        {
            level.zoneduration = getdvarint( @"scr_koth_zonelifetime" );
        }
        
        thread function_72b77b174bc3e293();
        self notify( #"hash_6e4a7f22a3ba828e" );
    }

    // Namespace koth
    // Params 0
    // Checksum 0x9911775d, Offset: 0x692b
    // Size: 0x83, Type: dev
    function function_2a38489a87451203()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_4c260c16d548430f" ) != 0 )
            {
                level notify( #"hash_a5281c9480b32767" );
                level.zoneduration = getdvarint( @"scr_koth_zonelifetime" );
                break;
            }
            
            wait 1;
        }
        
        thread movezoneaftertime( level.zoneduration );
        level.var_9e6909b34421b063 = 0;
        setdevdvar( @"hash_4c260c16d548430f", 0 );
        thread function_2a38489a87451203();
    }

    // Namespace koth
    // Params 0
    // Checksum 0x32db9a7d, Offset: 0x69b6
    // Size: 0x2a7, Type: dev
    function function_deb3339bd967f61e()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_c000ec9a5a2f4b6c" ) != 0 )
            {
                setdevdvar( @"hash_4806172df45de691", 1 );
                level.zoneduration = 10000;
                level.var_9e6909b34421b063 = 1;
                thread movezoneaftertime( level.zoneduration );
                level notify( #"hash_2a5edfd5a8eef3d3" );
                
                foreach ( zone in level.objectives )
                {
                    if ( isdefined( zone.neutralhardpointfx ) && zone.neutralhardpointfx.size > 0 )
                    {
                        foreach ( hpvfx in zone.neutralhardpointfx )
                        {
                            zone.neutralhardpointfx = arrayremove( zone.neutralhardpointfx, hpvfx );
                            
                            if ( isdefined( hpvfx ) )
                            {
                                hpvfx delete();
                            }
                        }
                    }
                    
                    zone.neutralhardpointfx = [];
                    
                    for ( i = 1; i < zone.visuals.size ; i++ )
                    {
                        fxfwd = anglestoforward( zone.visuals[ i ].angles );
                        zone.neutralhardpointfx[ zone.neutralhardpointfx.size ] = spawnfx( level.hardpointfxid[ "<dev string:x22d>" ], zone.visuals[ i ].baseorigin, fxfwd );
                        zone.neutralhardpointfx[ zone.neutralhardpointfx.size - 1 ] setfxkilldefondelete();
                        triggerfx( zone.neutralhardpointfx[ zone.neutralhardpointfx.size - 1 ] );
                    }
                    
                    zone gameobjects::setobjectivestatusicons( level.iconneutral );
                    zone gameobjects::setvisibleteam( "<dev string:x235>" );
                }
            }
            
            setdevdvar( @"hash_c000ec9a5a2f4b6c", 0 );
            wait 1;
        }
    }

    // Namespace koth
    // Params 0
    // Checksum 0x377bb11e, Offset: 0x6c65
    // Size: 0xa2, Type: dev
    function function_e943dce050e3f40d()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x239>", getdvarint( @"scr_give_score_allies" ), 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x240>", getdvarint( @"scr_give_score_axis" ), 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_e943dce050e3f40d();
    }

    // Namespace koth
    // Params 0
    // Checksum 0xb3d747fe, Offset: 0x6d0f
    // Size: 0x21c, Type: dev
    function function_37f2fbfcbc315f3a()
    {
        while ( true )
        {
            if ( !isdefined( level.players ) )
            {
                waitframe();
                continue;
            }
            
            if ( isdefined( level.players ) && level.players.size == 0 )
            {
                waitframe();
                continue;
            }
            
            if ( !isdefined( level.var_ec12535604a5e547 ) )
            {
                foreach ( player in level.players )
                {
                    if ( !player isplayerheadless() )
                    {
                        level.var_ec12535604a5e547 = player;
                        break;
                    }
                }
            }
            
            if ( !isdefined( level.var_d59000ae3c128f79 ) && isdefined( level.var_ec12535604a5e547 ) )
            {
                foreach ( player in level.players )
                {
                    if ( player isplayerheadless() && isalive( player ) && player.hasspawned && player.pers[ "<dev string:x245>" ] != level.var_ec12535604a5e547.pers[ "<dev string:x245>" ] )
                    {
                        wait 1;
                        level.var_d59000ae3c128f79 = player;
                        break;
                    }
                }
            }
            
            if ( isalive( level.var_d59000ae3c128f79 ) )
            {
                level.var_d59000ae3c128f79 setorigin( ( 2556.19, 5259.61, 192 ) );
            }
            
            wait 0.25;
            
            if ( isalive( level.var_d59000ae3c128f79 ) )
            {
                level.var_d59000ae3c128f79 setorigin( ( 2581.96, 5046.65, 192 ) );
            }
            
            wait 0.25;
        }
    }

#/

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x90b713a5, Offset: 0x6f33
// Size: 0x13c
function private function_fbc1c7f8eef77b55( game_object )
{
    game_object.spawninfluencers = [];
    zone_origin = gameobjects_common::get_origin( game_object );
    
    if ( spawnlogic::useablespawnset( game_object.spawnsetother ) )
    {
        game_object.spawninfluencers[ #"hash_7cebf9e340111eb7" ] = spawnlogic::addspawninfluencer( #"hash_7cebf9e340111eb7", zone_origin );
        spawnlogic::influencersetspawnpointlist( game_object.spawninfluencers[ #"hash_7cebf9e340111eb7" ], game_object.spawnsetother );
    }
    
    spawn_key = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawn_key ) )
    {
        game_object.spawninfluencers[ #"gametype_hardpoint_zone" ] = spawnlogic::addspawninfluencer( #"gametype_hardpoint_zone", zone_origin );
        
        if ( spawnlogic::useablespawnset( game_object.spawnset ) )
        {
            game_object.spawninfluencers[ #"hash_78d68ca5b33f3f12" ] = spawnlogic::addspawninfluencer( #"hash_78d68ca5b33f3f12", zone_origin );
            spawnlogic::influencersetspawnpointlist( game_object.spawninfluencers[ #"hash_78d68ca5b33f3f12" ], game_object.spawnset );
        }
        
        function_13a9c1011e9f54e1( game_object );
    }
}

// Namespace koth
// Params 2, eflags: 0x4
// Checksum 0x72b4f937, Offset: 0x7077
// Size: 0x1c7
function private function_13a9c1011e9f54e1( game_object, team_name )
{
    if ( isdefined( game_object.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] ) )
    {
        spawnlogic::removespawninfluencer( game_object.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] );
        game_object.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] = undefined;
    }
    
    if ( isdefined( game_object.spawninfluencers[ #"hash_1c79f4698d55c968" ] ) )
    {
        spawnlogic::removespawninfluencer( game_object.spawninfluencers[ #"hash_1c79f4698d55c968" ] );
        game_object.spawninfluencers[ #"hash_1c79f4698d55c968" ] = undefined;
    }
    
    if ( spawnlogic::useablespawnset( game_object.spawnsetanchor ) )
    {
        zone_origin = gameobjects_common::get_origin( game_object );
        
        if ( !isdefined( team_name ) )
        {
            game_object.spawninfluencers[ #"hash_1c79f4698d55c968" ] = spawnlogic::addspawninfluencer( #"hash_1c79f4698d55c968", zone_origin );
            spawnlogic::influencersetspawnpointlist( game_object.spawninfluencers[ #"hash_1c79f4698d55c968" ], game_object.spawnsetanchor );
            return;
        }
        
        game_object.spawninfluencers[ #"hash_2592d46fa8cdaed3" ] = spawnlogic::addspawninfluencer( #"hash_2592d46fa8cdaed3", zone_origin, team_name );
        game_object.spawninfluencers[ #"hash_1c79f4698d55c968" ] = spawnlogic::addspawninfluencer( #"hash_1c79f4698d55c968", zone_origin, team_name );
        spawnlogic::influencersetspawnpointlist( game_object.spawninfluencers[ #"hash_2592d46fa8cdaed3" ], game_object.spawnsetanchor );
        spawnlogic::influencersetspawnpointlist( game_object.spawninfluencers[ #"hash_1c79f4698d55c968" ], game_object.spawnsetanchor );
    }
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0xeceeeebe, Offset: 0x7246
// Size: 0xa1
function private function_fd022c4bb6ed6f48( game_object )
{
    if ( isdefined( game_object.spawninfluencers ) )
    {
        foreach ( influencer in game_object.spawninfluencers )
        {
            spawnlogic::removespawninfluencer( influencer );
        }
        
        game_object.spawninfluencers = undefined;
    }
}

// Namespace koth
// Params 0, eflags: 0xc
// Checksum 0x2875af7c, Offset: 0x72ef
// Size: 0x46
function private init_game_timer_thread()
{
    self notify( #"hash_1035a2124f087970" );
    self endon( #"hash_1035a2124f087970" );
    level endon( #"game_ended" );
    
    if ( level.pausemodetimer )
    {
        flags::function_2f3408423ccc9b2e( "prematch_done" );
        level gamelogic_mp::pausetimer();
    }
}

// Namespace koth
// Params 2, eflags: 0x4
// Checksum 0x171776a8, Offset: 0x733d
// Size: 0x141
function private update_objective_icon_state( game_object, is_locked )
{
    if ( is_locked )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"hash_897dfa48433d9619" );
        return;
    }
    
    var_536395db3d80fedb = namespace_277c922f0d0dc523::get_claim_team_hash( game_object );
    var_7f4958ce4e4277c3 = namespace_277c922f0d0dc523::function_9b71aa2788e21706( game_object );
    var_d07b2b95cdf20f0c = namespace_277c922f0d0dc523::function_a33241bbed7a745d( game_object );
    
    if ( namespace_277c922f0d0dc523::is_contested( game_object ) )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"koth_zone_contested" );
        return;
    }
    
    if ( var_7f4958ce4e4277c3 == #"hash_bb332da19f9944df" || var_536395db3d80fedb == #"hash_bb332da19f9944df" )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"hash_3f855b38f6fcfccd" );
        return;
    }
    
    if ( var_7f4958ce4e4277c3 != var_536395db3d80fedb )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"hash_ed1768c55b513e05" );
        return;
    }
    
    if ( var_d07b2b95cdf20f0c == #"hash_bb332da19f9944df" )
    {
        objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"hash_2eddd14fc4fa6d3d" );
        return;
    }
    
    objectiveiconstates::set_objective_icon_state( game_object.objective_id, #"hash_3c1f0d997659b798" );
}

// Namespace koth
// Params 2, eflags: 0x4
// Checksum 0xbb918007, Offset: 0x7486
// Size: 0xe7
function private set_chevron_state( game_object, state )
{
    if ( !isdefined( game_object.var_189d2e7eed3cb956 ) )
    {
        return;
    }
    
    foreach ( chevron in game_object.var_189d2e7eed3cb956 )
    {
        for ( i = 0; i < chevron.chevron_count ; i++ )
        {
            chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
        }
    }
}

// Namespace koth
// Params 2, eflags: 0xc
// Checksum 0x3b389218, Offset: 0x7575
// Size: 0xab
function private function_5ca98c75d64756c5( objective_id, time_ms )
{
    self notify( #"hash_d8318f1f5921f638" );
    self endon( #"hash_d8318f1f5921f638" );
    level endon( #"game_ended" );
    current_time_ms = 0;
    var_5cfdc51756a8db0 = 1 / time_ms;
    objidpoolmanager::objective_show_progress( objective_id, 1 );
    
    while ( current_time_ms < time_ms )
    {
        current_time_ms += level.frameduration;
        progress_fraction = current_time_ms * var_5cfdc51756a8db0;
        objidpoolmanager::objective_set_progress( objective_id, 1 - min( progress_fraction, 1 ) );
        waitframe();
    }
    
    objidpoolmanager::objective_show_progress( objective_id, 0 );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x888c4727, Offset: 0x7628
// Size: 0x257
function private function_25234f064d30984b( params )
{
    player = params.player;
    is_assist = params.is_assist;
    is_first_capture = params.is_first_capture;
    var_76e9eb89ea7138e3 = params.var_76e9eb89ea7138e3;
    is_quick_capture = params.is_quick_capture;
    
    if ( var_76e9eb89ea7138e3 )
    {
        /#
            player iprintlnbold( "<dev string:x1e8>" );
        #/
        
        return;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "captures" ] ) )
        {
            player.leaderboarddata[ "captures" ] = player.leaderboarddata[ "captures" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "captures" ] ) )
        {
            [[ level.leaderboardfunc[ "captures" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c2>" );
        
        if ( isdefined( player.pers[ "captures" ] ) )
        {
            player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
        }
    }
    
    player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
    
    if ( !is_assist )
    {
        player stats::setextrascore2( player.pers[ "extrascore2" ] + 1 );
        telemetry_data = {};
        telemetry_data.player = player;
        telemetry_data.eventname = "capture";
        telemetry_data.position = player.origin;
        telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
        
        if ( is_first_capture )
        {
            player thread points::doscoreevent( #"koth_first_cap" );
        }
        
        if ( is_quick_capture )
        {
            player thread points::doscoreevent( #"hp_quick_cap" );
        }
        
        player thread points::doscoreevent( #"hp_secure" );
        return;
    }
    
    player thread points::doscoreevent( #"capture_assist" );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x58080a42, Offset: 0x7887
// Size: 0x88
function private function_8e962c96d8c8c798( params )
{
    game_object = params.game_object;
    owning_team_name = params.owning_team_name;
    var_7f4958ce4e4277c3 = params.var_7f4958ce4e4277c3;
    
    if ( level.zoneadditivescoring )
    {
        players_using = gameobjects_common::function_de2f4638a165d21c( game_object, var_7f4958ce4e4277c3 );
        gamescore::giveteamscoreforobjective( owning_team_name, players_using.size, 0 );
        return;
    }
    
    gamescore::giveteamscoreforobjective( owning_team_name, 1, 0 );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0xf4bdc93f, Offset: 0x7917
// Size: 0x22d
function private function_b290f77c226a8e24( params )
{
    player = params.player;
    var_db2b1dde1497a248 = params.var_db2b1dde1497a248;
    is_first_interval = var_db2b1dde1497a248 == 1;
    var_5737c1c33e675415 = var_db2b1dde1497a248 % ( level.scoreeventglobals.var_f244d41a6bc4a67d ?? 4 ) == 0;
    should_notify_lua = is_first_interval || var_5737c1c33e675415;
    
    if ( var_5737c1c33e675415 )
    {
        player points::doscoreevent( #"koth_in_obj" );
    }
    else if ( !level.scoreeventglobals.var_c21da95c189c7f73 )
    {
        points = rank::getscoreinfovalue( #"koth_in_obj" );
        player gamescore::giveplayerscore( #"koth_in_obj", points );
    }
    
    if ( should_notify_lua )
    {
        player setclientomnvar( "ui_score_chunking_notify", 1 );
        player thread utility::function_c2dfd06e2639cc7e( &setclientomnvar, "ui_score_chunking_notify", 0 );
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "objTime" ] ) )
        {
            player.leaderboarddata[ "objTime" ] = player.leaderboarddata[ "objTime" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "objTime" ] ) )
        {
            [[ level.leaderboardfunc[ "objTime" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c2>" );
        
        if ( isdefined( player.pers[ "objTime" ] ) )
        {
            player.pers[ "objTime" ] = player.pers[ "objTime" ] + 1;
        }
    }
    
    player persistence::statsetchild( "round", "objTime", player.pers[ "objTime" ] );
    player stats::setextrascore0( player.pers[ "objTime" ] );
    player codcasterclientmatchdata::function_8ecc753b54a5740f( 0, 1 );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x8dd7d5f0, Offset: 0x7b4c
// Size: 0x1e8
function private function_aa8f15d9f14b98cc( params )
{
    game_object = params.game_object;
    lock_time_ms = params.lock_time_ms;
    instance_id = params.instance_id;
    zone_origin = gameobjects_common::get_origin( game_object );
    objective_icon_position = zone_origin + gameobjects_common::get_objective_icon_offset( game_object );
    game_object.objective_id = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_set_play_intro( game_object.objective_id, 1 );
    objidpoolmanager::objective_set_play_outro( game_object.objective_id, 0 );
    objidpoolmanager::objective_playermask_showtoall( game_object.objective_id );
    objidpoolmanager::update_objective_position( game_object.objective_id, objective_icon_position );
    objidpoolmanager::update_objective_state( game_object.objective_id, "current" );
    is_locked = lock_time_ms > 0;
    update_objective_icon_state( game_object, is_locked );
    hud_message::updatematchstatushintforallplayers( undefined, #"hash_3a0601d819e75e10", #"hash_3a0601d819e75e10" );
    gameplay_sound_fx::function_28103d3430792dce( zone_origin, #"hash_44446e4b71cd388b" );
    is_first_zone = koth_shared::is_first_zone( game_object );
    
    if ( is_locked )
    {
        if ( !is_first_zone )
        {
            dialog::statusdialog( #"hash_c17090a9aef4a510", game_utility_mp::get_attacker_team( instance_id ) );
            dialog::statusdialog( #"hash_c17090a9aef4a510", game_utility_mp::get_defender_team( instance_id ) );
            callback::callback( #"music_event", { #event_type:#"hq_new" } );
        }
        
        game_object thread function_5ca98c75d64756c5( game_object.objective_id, lock_time_ms );
        setomnvar( "ui_hardpoint_timer", int( gettime() + lock_time_ms ) );
        setomnvar( "ui_hq_status", 12 );
    }
    
    if ( is_first_zone )
    {
        codcaster_utils::function_3038b6eafc46c037( 4, "free" );
    }
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x3c84fb1d, Offset: 0x7d3c
// Size: 0x47
function private function_537d9824316d5d99( params )
{
    game_object = params.game_object;
    objidpoolmanager::objective_playermask_hidefromall( game_object.objective_id );
    objidpoolmanager::returnobjectiveid( game_object.objective_id );
}

// Namespace koth
// Params 0, eflags: 0x4
// Checksum 0x1577066f, Offset: 0x7d8b
// Size: 0x28e
function private function_bf70e8e73e6ea0dc()
{
    game_utility_mp::clean_up_entities( [ #"hardpoint" ] );
    primaryzones = getzonearray( "hardpoint" );
    
    foreach ( zone in primaryzones )
    {
        temp = strtok( zone.script_label, "_" )[ 0 ];
        zone.objectivekey = temp;
        zone.script_label = zone.objectivekey;
    }
    
    assert( isdefined( primaryzones ) && primaryzones.size >= 3, "<dev string:x117>" );
    triggers = [];
    
    for ( index = 0; index < primaryzones.size ; index++ )
    {
        triggers[ triggers.size ] = primaryzones[ index ];
    }
    
    foreach ( trigger in triggers )
    {
        var_24290c36e2cab388 = { #manual_drop:1, #var_7f4958ce4e4277c3:#"hash_bb332da19f9944df", #capture_segment_count:1, #var_333d3689d793bcc7:0, #use_time_seconds:0, #var_c68e9f43ed9cc918:#"hash_a1360b18943e920", #var_d7c90dc73c1dcba8:( 0, 0, 0 ), #objective_icon_offset:( 0, 0, 0 ), #angles:( 0, 0, 0 ), #origin:( 0, 0, 0 ) };
        var_24290c36e2cab388.origin = trigger.origin;
        var_24290c36e2cab388.angles = trigger.angles;
        gameobjects_common::initialize_game_object( trigger.targetname, var_24290c36e2cab388, trigger, &function_51483b09a1807cd7 );
    }
    
    setomnvar( "ui_hardpoint_active_zone_count", 2 );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x95fbe851, Offset: 0x8021
// Size: 0x16c
function private function_51483b09a1807cd7( game_object )
{
    game_utility_mp::add_gametype_objective( game_object );
    trigger = gameobjects_common::get_trigger( game_object );
    
    if ( isdefined( trigger ) && isdefined( trigger.target ) )
    {
        var_189d2e7eed3cb956 = getentitylessscriptablearray( trigger.target, #targetname );
        game_object.var_189d2e7eed3cb956 = [];
        
        foreach ( scriptable in var_189d2e7eed3cb956 )
        {
            if ( !isdefined( scriptable.script_noteworthy ) )
            {
                continue;
            }
            
            if ( scriptable.script_noteworthy == "2" || scriptable.script_noteworthy == "3" || scriptable.script_noteworthy == "4" )
            {
                scriptable.chevron_count = int( scriptable.script_noteworthy );
            }
            else
            {
                scriptable.chevron_count = 1;
            }
            
            game_object.var_189d2e7eed3cb956[ game_object.var_189d2e7eed3cb956.size ] = scriptable;
        }
    }
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x6a89535b, Offset: 0x8195
// Size: 0x223
function private function_2b3b81181607daf4( params )
{
    game_object = params.game_object;
    instance_id = params.instance_id;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::resumetimer();
    }
    
    game_object.didstatusnotify = 0;
    function_fd022c4bb6ed6f48( game_object );
    function_fbc1c7f8eef77b55( game_object );
    update_objective_icon_state( game_object );
    set_chevron_state( game_object, "idle" );
    match_time_ms = matchdata::function_47550968a937b67e( gettime() );
    zone_origin = gameobjects_common::get_origin( game_object );
    zone_objective_key = gameobjects_common::get_objective_key( game_object );
    dialogue_hash = koth_shared::is_first_zone( game_object ) ? #"hash_144c522c990ae2a5" : #"koth_new_zone";
    dialog::statusdialog( dialogue_hash, game_utility_mp::get_attacker_team( instance_id ) );
    dialog::statusdialog( dialogue_hash, game_utility_mp::get_defender_team( instance_id ) );
    hud_message::updatematchstatushintforallplayers( undefined, #"koth_zone_capture", #"koth_zone_capture" );
    gameplay_sound_fx::function_28103d3430792dce( zone_origin, #"koth_zone_activated" );
    codcaster_utils::function_3038b6eafc46c037( 5 );
    setomnvar( "ui_hardpoint_timer", int( gettime() + 1000 * level.zoneduration ) );
    setomnvar( "ui_hq_status", 10 );
    dlog_recordevent( "dlog_event_mp_objective_status", [ "key", zone_objective_key, "match_time_ms", match_time_ms, "is_active", 1 ] );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", zone_objective_key, "team", "neutral", "match_time_ms", match_time_ms ] );
    dlog_recordevent( "dlog_event_mp_objective_move", [ "pos_x", zone_origin[ 0 ], "pos_y", zone_origin[ 1 ], "key", zone_objective_key, "match_time_ms", match_time_ms ] );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0xb036d202, Offset: 0x83c0
// Size: 0x92
function private function_83c3ac8632599103( params )
{
    game_object = params.game_object;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::pausetimer();
    }
    
    function_fd022c4bb6ed6f48( game_object );
    set_chevron_state( game_object, "off" );
    dlog_recordevent( "dlog_event_mp_objective_status", [ "key", gameobjects_common::get_objective_key( game_object ), "match_time_ms", matchdata::function_47550968a937b67e( gettime() ), "is_active", 0 ] );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x75e9b5a0, Offset: 0x845a
// Size: 0x6a
function private function_94a6de4e2d6c3b57( params )
{
    game_object = params.game_object;
    player = params.player;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::pausetimer();
    }
    
    objidpoolmanager::objective_pin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 2, player );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x99f87fa7, Offset: 0x84cc
// Size: 0x56
function private function_80569e83bd3abfbf( params )
{
    game_object = params.game_object;
    player = params.player;
    objidpoolmanager::objective_unpin_player( game_object.objective_id, player );
    objidpoolmanager::function_b3b969f2930890eb( 0, player );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x353ac479, Offset: 0x852a
// Size: 0x1d8
function private on_zone_captured_cb( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    other_team_name = team_utility::getotherteam( team_name );
    dialog::statusdialog( #"hash_a1115bee74e2b24d", team_name );
    dialog::statusdialog( #"hash_caead70546a31d0e", other_team_name );
    zone_trigger = gameobjects_common::get_trigger( game_object );
    
    if ( gameobjects_common::has_trigger_group( game_object ) || !isent( zone_trigger ) )
    {
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_d60bbf59cbc390b9", teams::getteamdata( team_name, "players" ) );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_3f815ce3540d8525", teams::getteamdata( other_team_name, "players" ) );
    }
    else
    {
        zone_trigger gameplay_sound_fx::function_6dac8db778849e61( #"hash_d60bbf59cbc390b9", team_name, undefined, zone_trigger );
        zone_trigger gameplay_sound_fx::function_6dac8db778849e61( #"hash_3f815ce3540d8525", other_team_name, undefined, zone_trigger );
    }
    
    if ( gameobjects_common::get_use_time_seconds( game_object ) == 0 )
    {
        if ( !isdefined( params.var_d5d1baab32eedb10 ) )
        {
            params.var_d5d1baab32eedb10 = {};
        }
        
        params.var_d5d1baab32eedb10.instant_capture = 1;
        
        if ( level.var_d5d1baab32eedb10.var_f6ff35f521b62b1b == team_name && level.var_d5d1baab32eedb10.var_76cc85bad806c828 - 2100 <= gettime() )
        {
            params.var_d5d1baab32eedb10.var_2858ab6b89f74fb6 = 1;
        }
    }
    
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", gameobjects_common::get_objective_key( game_object ), "team", team_name, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x127b479c, Offset: 0x870a
// Size: 0x9f
function private function_aaa1ceb9e48346dc( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    
    if ( game_utility_mp::is_attacker_team( team_name ) || game_utility_mp::is_defender_team( team_name ) )
    {
        objidpoolmanager::function_84651f3f2873ee19( game_object.objective_id, team_name );
    }
    else
    {
        objidpoolmanager::function_84651f3f2873ee19( game_object.objective_id, undefined );
        team_name = "idle";
    }
    
    if ( !namespace_277c922f0d0dc523::is_contested( game_object ) )
    {
        set_chevron_state( game_object, team_name );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0xc6ed2b64, Offset: 0x87b1
// Size: 0x82
function private function_ceadb54c29c1a81a( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    
    if ( game_utility_mp::is_attacker_team( team_name ) || game_utility_mp::is_defender_team( team_name ) )
    {
        objidpoolmanager::update_objective_ownerteam( game_object.objective_id, team_name );
    }
    else
    {
        objidpoolmanager::update_objective_ownerteam( game_object.objective_id, undefined );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0xe26faf63, Offset: 0x883b
// Size: 0x82
function private function_5a35159676e6e80d( params )
{
    game_object = params.game_object;
    team_name = params.team_name;
    
    if ( game_utility_mp::is_attacker_team( team_name ) || game_utility_mp::is_defender_team( team_name ) )
    {
        objidpoolmanager::objective_set_progress_team( game_object.objective_id, team_name );
    }
    else
    {
        objidpoolmanager::objective_set_progress_team( game_object.objective_id, undefined );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x6c105f05, Offset: 0x88c5
// Size: 0x6d
function private function_d3f276c6e626d80( params )
{
    game_object = params.game_object;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::resumetimer();
    }
    
    objidpoolmanager::update_objective_sethot( game_object.objective_id, 1 );
    set_chevron_state( game_object, "contested" );
    update_objective_icon_state( game_object );
    level notify( #"zone_contested" );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0xb8a0506b, Offset: 0x893a
// Size: 0x8a
function private function_7deb426f5232fa5f( params )
{
    game_object = params.game_object;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::pausetimer();
    }
    
    objidpoolmanager::update_objective_sethot( game_object.objective_id, 0 );
    
    if ( namespace_277c922f0d0dc523::function_79ed8dd2c414e8ed( game_object ) )
    {
        owning_team_name = namespace_277c922f0d0dc523::get_owning_team_name( game_object );
        set_chevron_state( game_object, owning_team_name );
    }
    else
    {
        set_chevron_state( game_object, "idle" );
    }
    
    update_objective_icon_state( game_object );
}

// Namespace koth
// Params 1, eflags: 0x4
// Checksum 0x6e244bf4, Offset: 0x89cc
// Size: 0x94
function private function_af7aa9229b9eb5e8( params )
{
    game_object = params.game_object;
    
    if ( level.pausemodetimer )
    {
        gamelogic_mp::resumetimer();
    }
    
    function_13a9c1011e9f54e1( game_object );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", gameobjects_common::get_objective_key( game_object ), "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
    level notify( #"zone_unoccupied" );
}

