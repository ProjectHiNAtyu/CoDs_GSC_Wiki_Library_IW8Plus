// scripts\mp\gametypes\hq.gsc  (hash_154439fdbdb10b95.gscc) (size: 37453 Bytes / 0x924d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4d8f5f8e (1301241742)
// size ...... 37453 (0x924d)
// includes .. 40  (offset: 0x8789)
// strings ... 126 (offset: 0x88c9)
// dev strs .. 13  (offset: 0x91a1)
// exports ... 70  (offset: 0x5c71)
// cseg ...... 0x931 + 0x5340 (0x5c71)
// imports ... 253 (offset: 0x6761)
// animtree1 . 0   (offset: 0x924d)
// animtree2 . 0   (offset: 0x924d)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\callouts;
#using scripts\mp\challenges;
#using scripts\mp\codcaster_utils;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\smoke_grenade;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
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
#using scripts\mp\gametypes\koth;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\matchdata;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnutils;
#using scripts\mp\spectating;

#namespace hq;

// Namespace hq
// Params 0
// Checksum 0xab98d9f7, Offset: 0x94f
// Size: 0x1f7
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = "hqloc";
    allowed[ 1 ] = "hardpoint";
    allowed[ 2 ] = "tdm";
    allowed[ 3 ] = "headquarters";
    gameobjects::main( allowed );
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
    level.modeonsuicidedeath = &onsuicidedeath;
    level.onrespawndelay = &getrespawndelay;
    level.modeonteamchangedeath = &modeonteamchangedeath;
    level.canspawnontacinsert = &canspawnontacinsert;
    level.onplayerjoinedteam = &obj_zonecapture::onplayerjoinedteam;
    level.lastcaptime = gettime();
    level.usezonecapture = 1;
    level.var_813f2ea1f9452bdb = &function_f5a5ffa50ffe2b77;
    level.var_40cd999d911308e0 = &game_utility_mp::function_24298f56712800ff;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_84968d430abf1672;
    level.var_1e1962e4a4e8622 = &onzonecapture;
    level.lastcaptureteam = undefined;
    level.previousclosespawnent = undefined;
    level.var_c18eb83275e643e7 = &function_c18eb83275e643e7;
    setomnvar( "ui_hq_num_alive", 0 );
    setomnvar( "ui_hq_ownerteam", -1 );
    thread writeplayerrotationscoretomatchdataongameend();
    level._effect[ "hq_explode" ] = loadfxasset( "vfx_iw8_mp_gamemode_hq_box_destroy" );
    level.nosuspensemusic = 1;
}

// Namespace hq
// Params 0
// Checksum 0xff4b85b4, Offset: 0xb4e
// Size: 0x13d
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"hash_b0cefb6ea6bf4662", getmatchrulesdata( "hqData", "zoneTimeout" ) );
    setdynamicdvar( @"hash_1e01551583cca6c4", getmatchrulesdata( "hqData", "zoneLifetime" ) );
    setdynamicdvar( @"hash_7d5c21c369422436", getmatchrulesdata( "hqData", "zoneCaptureTime" ) );
    setdynamicdvar( @"hash_d1bf6ba3850e475a", getmatchrulesdata( "hqData", "firstZoneActivationDelay" ) );
    setdynamicdvar( @"hash_229d8f67e5f5a8be", getmatchrulesdata( "hqData", "zoneActivationDelay" ) );
    setdynamicdvar( @"hash_aee04e24c84a0fba", getmatchrulesdata( "hqData", "zoneSelectionDelay" ) );
    setdynamicdvar( @"hash_bbd7b38d55eb3dcb", getmatchrulesdata( "hqData", "randomLocationOrder" ) );
    setdynamicdvar( @"hash_8348179aba5c8da6", getmatchrulesdata( "hqData", "additiveScoring" ) );
    setdynamicdvar( @"hash_97342c6c1740b3f4", getmatchrulesdata( "hqData", "pauseTime" ) );
    setdynamicdvar( @"hash_c3d0fcc4468f8e95", getmatchrulesdata( "hqData", "delayPlayer" ) );
    setdynamicdvar( @"hash_5f92cd26567d304d", getmatchrulesdata( "hqData", "combineZones" ) );
}

// Namespace hq
// Params 0
// Checksum 0xaa50121, Offset: 0xc93
// Size: 0x137
function onstartgametype()
{
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/hq" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/hq" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/hq_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/hq_hint" );
    }
    
    setclientnamemode( "auto_change" );
    level thread setupzones();
    initspawns();
    seticonnames();
    setwaypoints();
    
    if ( !level.zonerandomlocationorder )
    {
        remaphardpointorder();
    }
    
    level thread hqmainloop();
    
    /#
        level thread function_c44cad38144a7e70();
        level thread function_72b77b174bc3e293();
        level thread function_2a38489a87451203();
        level thread function_deb3339bd967f61e();
        level thread function_e943dce050e3f40d();
    #/
}

// Namespace hq
// Params 0
// Checksum 0x7436a587, Offset: 0xdd2
// Size: 0x4b, Type: bool
function function_f5a5ffa50ffe2b77()
{
    if ( level.scoremod[ "kill" ] > 0 && dialog_utility::dialogueexists( #"boost_groundwar", self.team ) )
    {
        dialog::leaderdialogonplayer( #"boost_groundwar", "introboost" );
        return true;
    }
    
    return false;
}

// Namespace hq
// Params 0
// Checksum 0xaab7e9c8, Offset: 0xe26
// Size: 0x131
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.zonetimeout = dvars::dvarfloatvalue( "zoneTimeout", 60, 0, 300 );
    level.zoneduration = dvars::dvarfloatvalue( "zoneLifetime", 60, 0, 300 );
    level.zonecapturetime = dvars::dvarfloatvalue( "zoneCaptureTime", 0, 0, 30 );
    level.firstzoneactivationdelay = dvars::dvarfloatvalue( "firstZoneActivationDelay", 30, 0, 120 );
    level.zoneactivationdelay = dvars::dvarfloatvalue( "zoneActivationDelay", 30, 0, 120 );
    level.zoneselectiondelay = dvars::dvarfloatvalue( "zoneSelectionDelay", 15, 0, 120 );
    level.zonerandomlocationorder = dvars::dvarintvalue( "randomLocationOrder", 1, 0, 1 );
    level.zoneadditivescoring = dvars::dvarintvalue( "additiveScoring", 0, 0, 1 );
    level.pausemodetimer = dvars::dvarintvalue( "pauseTime", 1, 0, 1 );
    level.delayplayer = dvars::dvarintvalue( "delayPlayer", 0, 0, 1 );
    level.combinezones = dvars::dvarintvalue( "combineZones", 0, 0, 1 );
    level.disablemajoritycapprogress = getmatchrulesdata( "controlData", "disableMajorityCapProgress" );
}

// Namespace hq
// Params 0
// Checksum 0xd5dc5a05, Offset: 0xf5f
// Size: 0x1f4
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    obj_zonecapture::function_c563aafed90e555e( level.objectives, spawnkey, "zone1" );
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3a25709674572ad6( #"start", #"start_attackers", spawnkey, spawnlogic::function_61ba521db28762a7(), game[ "attackers" ], 1 );
        spawnlogic::function_3a25709674572ad6( #"start", #"start_defenders", spawnkey, spawnlogic::function_3a5e3efa19e5df47(), game[ "defenders" ], 1 );
        all_spawns = spawnlogic::getspawnpointarray( "mp_spawn_point", spawnkey, "spawn" );
        
        foreach ( zone in level.objectives )
        {
            var_f58fa002466a0ba8 = spawnlogic::getspawnset( zone.spawnset );
            all_spawns = spawnutils::function_268776511d6464f2( all_spawns, var_f58fa002466a0ba8 );
        }
        
        spawnlogic::addspawnpoints( #"primary", #"primary", undefined, all_spawns, "all_spawns" );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_koth_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_koth_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_koth_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_koth_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace hq
// Params 0
// Checksum 0x90d37695, Offset: 0x115b
// Size: 0x10
function activatezone()
{
    obj_zonecapture::activatezone();
    koth::function_89b712a46e53a1cf();
}

// Namespace hq
// Params 0
// Checksum 0x55ee147b, Offset: 0x1173
// Size: 0x756
function hqmainloop()
{
    level endon( #"game_ended" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    setomnvar( "ui_hardpoint_timer", 0 );
    setomnvar( "ui_hq_status", -1 );
    level.zone = getfirstzone();
    firstzone = 1;
    level.kothhillrotation = 0;
    
    if ( level.zone.visuals[ 0 ] isscriptable() )
    {
        level.zone.visuals[ 0 ] setscriptablepartstate( "main", "off" );
    }
    else
    {
        closeanim = level.gametypebundle.var_2ee9e1585f1e8889.id ?? "iw8_mp_military_hq_crate_close";
        level.zone.visuals[ 0 ] scriptmodelplayanim( closeanim );
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    level.zone activatezone();
    level.favorclosespawnent = level.zone;
    level.zone.active = 1;
    level.zone gameobjects::setvisibleteam( "any" );
    level.zone gameobjects::setobjectivestatusicons( level.icontarget );
    telemetry_data = spawnstruct();
    telemetry_data.player = level.zone;
    telemetry_data.eventname = "hill_moved";
    telemetry_data.position = level.zone.trigger.origin;
    telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
    flags::gameflagwait( "prematch_done" );
    
    if ( level.pausemodetimer )
    {
        level gamelogic_mp::pausetimer();
    }
    
    setomnvar( "ui_objective_timer_stopped", 0 );
    var_3cfcfd857dedb22b = 0;
    
    if ( level.firstzoneactivationdelay )
    {
        level thread waitthenshowfirsthqsplash();
        var_3cfcfd857dedb22b = 1;
        level.zoneendtime = int( gettime() + level.firstzoneactivationdelay * 1000 );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 1 );
        objective_lock( level.zone.objidnum, 1 );
        level thread waitthenplaynewobj();
        level.zone thread gameobjects::function_d7321ef757ecefd7( level.firstzoneactivationdelay );
        wait level.firstzoneactivationdelay;
        objective_lock( level.zone.objidnum, 0 );
        codcaster_utils::function_3038b6eafc46c037( 7, "free" );
    }
    
    setomnvar( "ui_objective_timer_stopped", 0 );
    
    while ( true )
    {
        if ( !isdefined( level.mapcalloutsready ) )
        {
            level thread setupzonecallouts();
        }
        
        level.objectivesetorder = 1;
        waittillframeend();
        
        if ( !var_3cfcfd857dedb22b )
        {
            foreach ( player in level.players )
            {
                objidpoolmanager::objective_unpin_player( level.zone.objidnum, player );
            }
        }
        
        level.zone gameobjects::enableobject();
        level.zone.capturecount = 0;
        
        if ( level.codcasterenabled )
        {
            level.zone thread obj_zonecapture::trackgametypevips();
        }
        
        spawnlogic::clearlastteamspawns();
        hqactivatenextzone( var_3cfcfd857dedb22b, firstzone );
        firstzone = 0;
        var_3cfcfd857dedb22b = 0;
        setomnvar( "ui_hq_status", 2 );
        spawnlogic::clearlastteamspawns();
        
        if ( level.zone.visuals[ 0 ] isscriptable() )
        {
            level.zone.visuals[ 0 ] setscriptablepartstate( "main", "on" );
        }
        else
        {
            openanim = level.gametypebundle.var_1014aea47d89466c.id ?? "iw8_mp_military_hq_crate_open";
            level.zone.visuals[ 0 ] scriptmodelplayanim( openanim );
        }
        
        level.zone.visuals[ 0 ] gameplay_sound_fx::function_8219c402fc8c37a3( #"hash_8785f7d26897e318" );
        hpcaptureloop();
        ownerteam = level.zone gameobjects::getownerteam();
        setomnvar( "ui_hq_ownerteam", 0 );
        level.spectateoverride[ game[ "attackers" ] ].allowenemyspectate = 0;
        level.spectateoverride[ game[ "defenders" ] ].allowenemyspectate = 0;
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
        
        level.zone gameobjects::disableobject();
        level.zone gameobjects::allowuse( "none" );
        level.zone gameobjects::setownerteam( "neutral" );
        obj_zonecapture::updateservericons( "zone_shift", 0 );
        level notify( #"zone_reset" );
        level callback::callback( #"music_event", { #team:level.zone.lastclaimteam, #event_type:#"hq_deact" } );
        level.zone obj_zonecapture::deactivatezone();
        level.scoreleadchanged = 0;
        level.zone.visuals[ 0 ] gameplay_sound_fx::function_760dbc73d1362ab9( #"hq_zone_deactivated" );
        level.zone.visuals[ 0 ] stoploopsound();
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"hq_capture", #"hq_capture" );
        setomnvar( "ui_hq_status", 5 );
        zoneselectiondelay = int( gettime() + level.zoneselectiondelay * 1000 + 500 );
        setomnvar( "ui_hardpoint_timer", zoneselectiondelay );
        
        if ( level.zoneselectiondelay > 0 )
        {
            if ( level.pausemodetimer )
            {
                level gamelogic_mp::pausetimer();
            }
            
            koth::function_89b712a46e53a1cf( 0 );
        }
        
        thread forcespawnplayers();
        wait level.zoneselectiondelay;
        spawn_next_zone();
        wait 0.5;
    }
}

// Namespace hq
// Params 0
// Checksum 0xf80d7d19, Offset: 0x18d1
// Size: 0x9b
function waitthenplaynewobj()
{
    if ( level.infilvotiming )
    {
        wait 8.5;
    }
    else
    {
        wait 6;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        dialog::statusdialog( "hp_first", entry );
    }
}

// Namespace hq
// Params 0
// Checksum 0x4812735d, Offset: 0x1974
// Size: 0x34
function waitthenshowfirsthqsplash()
{
    if ( level.infilvotiming )
    {
        wait 6.5;
    }
    else
    {
        wait 5.5;
    }
    
    level thread hud_message::notifyteam( "hq_located", "hq_located", "allies" );
}

// Namespace hq
// Params 0
// Checksum 0x49ec6610, Offset: 0x19b0
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

// Namespace hq
// Params 0
// Checksum 0x821e5666, Offset: 0x1b58
// Size: 0x230
function remaphardpointorder()
{
    switch ( level.mapname )
    {
        case #"hash_a3aa6afd955c54d":
        case #"hash_8cd7282b2d63b917":
            level.remappedhpzoneorder = [ "1", "4", "3", "9", "8" ];
            break;
        case #"hash_be52fbd3b8746bc":
        case #"hash_d83171ba75f8b8fe":
            level.remappedhpzoneorder = [ "5", "4", "3", "2", "6" ];
            break;
        case #"hash_66ce5cdcd3b547f3":
        case #"hash_ff009e5fab42b778":
            level.remappedhpzoneorder = [ "1", "5", "2", "3", "4" ];
            break;
        case #"hash_1ab428ea9c0ee9e5":
            level.remappedhpzoneorder = [ "1", "9", "4", "5", "2" ];
            break;
        case #"hash_62c07791a2eda185":
            level.remappedhpzoneorder = [ "12", "11", "3", "1", "2" ];
            break;
        case #"hash_f09747c9feb47eb1":
            level.remappedhpzoneorder = [ "20", "2", "8", "9", "5" ];
            break;
        case #"hash_d8bbcfc499e70e6f":
            level.remappedhpzoneorder = [ "1", "5", "7", "3", "8" ];
            break;
        default:
            break;
    }
}

// Namespace hq
// Params 0
// Checksum 0xeb81ec71, Offset: 0x1d90
// Size: 0x5b
function getfirstzone()
{
    if ( isdefined( level.remappedhpzoneorder ) )
    {
        zone = level.objectives[ level.remappedhpzoneorder[ 0 ] ];
        level.prevzoneindex = 0;
    }
    else
    {
        zone = level.objectives[ "1" ];
        level.prevzoneindex = 1;
    }
    
    return zone;
}

// Namespace hq
// Params 0
// Checksum 0x451543ab, Offset: 0x1df4
// Size: 0x566
function getnextzone()
{
    if ( level.zonerandomlocationorder )
    {
        bestzoneindex = string( level.prevzoneindex );
        
        if ( level.objectives.size > 1 )
        {
            if ( !isdefined( level.prevzonelist ) || isdefined( level.prevzonelist ) && level.prevzonelist.size == level.objectives.size - 1 )
            {
                level.prevzonelist = [];
            }
            
            level.prevzonelist[ level.prevzonelist.size ] = level.prevzoneindex;
            playerweight = 0.7;
            zoneweight = 0.3;
            bestcost = undefined;
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
    }
    else
    {
        level.prevzoneindex++;
        
        if ( level.prevzoneindex > level.objectives.size )
        {
            level.prevzoneindex = 1;
        }
        
        zone = level.objectives[ string( level.prevzoneindex ) ];
    }
    
    return zone;
}

// Namespace hq
// Params 0
// Checksum 0xa31c3f68, Offset: 0x2363
// Size: 0x132
function spawn_next_zone()
{
    writecurrentrotationteamscore();
    level.zone = getnextzone();
    level.kothhillrotation++;
    level.zone resetzone();
    level.zone activatezone();
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
}

// Namespace hq
// Params 0
// Checksum 0x8e681693, Offset: 0x249d
// Size: 0x105
function resetzone()
{
    self.lastclaimteam = "none";
    self.lastprogressteam = "none";
    self.ownerteam = "neutral";
    self.prevownerteam = "neutral";
    self.curprogress = 0;
    teams = getarraykeys( self.teamprogress );
    
    foreach ( team in teams )
    {
        self.teamprogress[ team ] = 0;
    }
    
    objidpoolmanager::update_objective_ownerteam( self.objidnum, undefined );
    objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
}

// Namespace hq
// Params 2
// Checksum 0x4e2b4298, Offset: 0x25aa
// Size: 0x36a
function hqactivatenextzone( var_3cfcfd857dedb22b, firstzone )
{
    if ( !firstzone && level.zoneselectiondelay > 5 && level.zoneactivationdelay > 5 )
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( "hp_new_location", entry );
        }
    }
    
    if ( isdefined( level.zone.curorigin ) )
    {
        gameplay_sound_fx::function_28103d3430792dce( level.zone.curorigin, #"hq_zone_activated" );
    }
    
    level.zone thread obj_zonecapture::hardpoint_setneutral();
    level.zone gameobjects::allowuse( "none" );
    
    if ( var_3cfcfd857dedb22b )
    {
    }
    else if ( level.zoneactivationdelay )
    {
        level thread hud_message::notifyteam( "hq_located", "hq_located", "allies" );
        level.zone gameobjects::setobjectivestatusicons( level.icontarget );
        obj_zonecapture::updateservericons( "zone_activation_delay", 0 );
        waitframe();
        level.zoneendtime = int( gettime() + 1000 * level.zoneactivationdelay );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        setomnvar( "ui_hq_status", 1 );
        objective_lock( level.zone.objidnum, 1 );
        
        if ( level.pausemodetimer )
        {
            level gamelogic_mp::pausetimer();
        }
        
        level.zone thread gameobjects::function_d7321ef757ecefd7( level.zoneactivationdelay );
        wait level.zoneactivationdelay;
        objective_lock( level.zone.objidnum, 0 );
        codcaster_utils::function_3038b6eafc46c037( 7, "free" );
    }
    
    foreach ( entry in level.teamnamelist )
    {
        dialog::statusdialog( "hp_active", entry );
    }
    
    level thread hud_message::notifyteam( "hq_capture", "hq_capture", "allies" );
    
    if ( level.pausemodetimer )
    {
        level gamelogic_mp::resumetimer();
    }
    
    level.zone gameobjects::setobjectivestatusicons( level.iconneutral );
    obj_zonecapture::updateservericons( "neutral", 0 );
    
    if ( level.zoneduration )
    {
        obj_zonecapture::updateservericons( "neutral", 0 );
        
        if ( level.zonetimeout == 0 )
        {
            thread locktimeruntilcap();
        }
        else
        {
            timeout = level.zonetimeout;
            thread movezoneaftertime( timeout );
            level.zoneendtime = int( gettime() + 1000 * timeout );
            setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        }
        
        return;
    }
    
    level.zonedestroyedbytimer = 0;
}

// Namespace hq
// Params 0
// Checksum 0xdf13b105, Offset: 0x291c
// Size: 0x49
function locktimeruntilcap()
{
    level endon( #"zone_captured" );
    
    while ( true )
    {
        level.zoneendtime = int( gettime() + 1000 * level.zoneduration );
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
        waitframe();
    }
}

// Namespace hq
// Params 0
// Checksum 0x2ea48f61, Offset: 0x296d
// Size: 0x292
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
        
        if ( isdefined( level.matchrules_droptime ) && level.matchrules_droptime )
        {
            level thread grnd::randomdrops();
        }
        
        msg = level utility::waittill_any_return( "zone_captured", "zone_destroyed" );
        
        if ( msg == "zone_destroyed" )
        {
            continue;
        }
        else
        {
            level.zoneendtime = int( gettime() + 1000 * level.zoneduration );
            setomnvar( "ui_hardpoint_timer", level.zoneendtime );
            setomnvar( "ui_hq_status", 3 );
        }
        
        ownerteam = level.zone gameobjects::getownerteam();
        thread updaterespawntimer();
        
        if ( level.zoneduration > 0 )
        {
            thread movezoneaftertime( level.zoneduration );
        }
        
        if ( level.zonecapturetime > 0 )
        {
            skipplayers = teams::getteamdata( ownerteam, "players" );
            player = teams::getfriendlyplayers( ownerteam, 0 )[ 0 ];
            level thread hud_message::notifyteam( "hq_captured", "hq_destroy", ownerteam, skipplayers, undefined, undefined, player );
        }
        
        level thread hud_message::updatematchstatushintforallplayers( ownerteam, #"hq_defend", #"hash_f66dc1118126fb76" );
        codcaster_utils::function_3038b6eafc46c037( 8, ownerteam );
        level waittill( #"zone_destroyed", destroy_team );
        codcaster_utils::function_3038b6eafc46c037( 9, "free" );
        
        if ( level.zonecapturetime > 0 )
        {
            enemyteam = team_utility::getotherteam( ownerteam );
            player = teams::getfriendlyplayers( enemyteam, 0 )[ 0 ];
            level thread hud_message::notifyteam( "hq_destroyed", "hq_destroyed", enemyteam, undefined, undefined, undefined, player );
        }
        
        level thread hud_message::updatematchstatushintforallplayers( undefined, #"hq_capture", #"hq_capture" );
        level.spawndelay = undefined;
        
        if ( isdefined( destroy_team ) )
        {
            level.zone gameobjects::setownerteam( destroy_team );
        }
        else
        {
            level.zone gameobjects::setownerteam( "none" );
        }
        
        setomnvar( "ui_hardpoint_timer", 0 );
        setomnvar( "ui_hq_status", -1 );
        break;
    }
}

// Namespace hq
// Params 4
// Checksum 0xdda43454, Offset: 0x2c07
// Size: 0x276
function onzonecapture( zone, credit_player, touchlist, capturetime )
{
    capture_team = credit_player.team;
    otherteam = team_utility::getotherteam( capture_team );
    capture_players = teams::getteamdata( capture_team, "players" );
    
    foreach ( player in capture_players )
    {
        challenges::function_a3678ff124a05f01( player );
        player.skipspawncamera = 1;
    }
    
    setomnvar( "ui_hq_ownerteam", gethqownerteamvalue( zone.ownerteam ) );
    setomnvar( "ui_hq_num_alive", teams::getteamdata( zone.ownerteam, "aliveCount" ) );
    level thread awardcapturepoints();
    ownerteamscore = gamescore::getteamscore( capture_team );
    otherteamscore = gamescore::getteamscore( otherteam );
    
    if ( ownerteamscore > otherteamscore )
    {
        level.scoreleadchanged = 1;
    }
    
    obj_zonecapture::adjustmatchtimerpausedstatefromscore( capture_team );
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hq_flag_captured", teams::getteamdata( capture_team, "players" ) );
    level callback::callback( #"music_event", { #event_type:#"hq_cap" } );
    
    if ( !isdefined( level.lastcaptureteam ) || level.lastcaptureteam != capture_team )
    {
        if ( isdefined( level.kothhillrotation && level.kothhillrotation == 0 ) )
        {
            level.delayleadtakendialog = 4;
        }
        else
        {
            level.delayleadtakendialog = undefined;
        }
        
        level thread delaydialogstatustoavoidcaptureoverlap( capture_team, otherteam );
        assert( capture_team != "<dev string:x24>" );
        level thread give_capture_credit( touchlist, capturetime, capture_team, level.lastcaptureteam, credit_player, zone );
    }
    
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", zone.objectivekey, "team", capture_team, "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
}

// Namespace hq
// Params 1
// Checksum 0xbed0c7f2, Offset: 0x2e85
// Size: 0x178
function function_e72ab3c1abf1a83c( params )
{
    level.zone.visuals[ 0 ] stoploopsound();
    
    if ( level.zone.visuals[ 0 ] isscriptable() )
    {
        level.zone.visuals[ 0 ] setscriptablepartstate( "main", "default" );
    }
    else if ( isdefined( level.gametypebundle.var_caadf7ca3a46c931.id ) )
    {
        level.zone.visuals[ 0 ] scriptmodelplayanim( level.gametypebundle.var_caadf7ca3a46c931.id );
    }
    
    level.zone.visuals[ 0 ] gameplay_sound_fx::function_760dbc73d1362ab9( #"hq_zone_idle" );
    players = teams::getteamdata( params.team, "players" );
    
    foreach ( player in players )
    {
        player thread showrespawnwarningmessage();
    }
}

// Namespace hq
// Params 2
// Checksum 0x10906124, Offset: 0x3005
// Size: 0x41
function delaydialogstatustoavoidcaptureoverlap( capture_team, otherteam )
{
    wait 0.5;
    level dialog::statusdialog( #"hp_captured_friendly", capture_team );
    level dialog::statusdialog( #"hp_captured_enemy", otherteam );
}

// Namespace hq
// Params 0
// Checksum 0x6a19d12c, Offset: 0x304e
// Size: 0xab
function updaterespawntimer()
{
    level endon( #"game_ended" );
    level endon( #"zone_moved" );
    level endon( #"zone_destroyed" );
    starttime = gettime();
    
    if ( level.zoneduration > 0 )
    {
        endtime = starttime + level.zoneduration * 1000;
    }
    else
    {
        endtime = starttime + game_utility_mp::gettimelimit() * 1000 - game_utility::gettimepassed();
    }
    
    currenttime = starttime;
    
    while ( currenttime < endtime )
    {
        currenttime = gettime();
        level.spawndelay = ( endtime - currenttime ) / 1000 + 0.1;
        waitframe();
    }
}

// Namespace hq
// Params 0
// Checksum 0xb8b79615, Offset: 0x3101
// Size: 0x79
function function_c18eb83275e643e7()
{
    zone = self;
    luaindex = zone.objidnum + 1;
    
    if ( level.zone.active )
    {
        setomnvar( "ui_axis_player_count_zone_" + luaindex, zone.numtouching[ "axis" ] );
        setomnvar( "ui_allies_player_count_zone_" + luaindex, zone.numtouching[ "allies" ] );
    }
}

// Namespace hq
// Params 2
// Checksum 0xe3ece413, Offset: 0x3182
// Size: 0xe3, Type: bool
function comparezoneindexes( zone_a, zone_b )
{
    script_index_a = int( zone_a.objectivekey );
    script_index_b = int( zone_b.objectivekey );
    
    if ( !isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:x2c>" + zone_a.origin + "<dev string:x59>" + zone_b.origin );
        return false;
    }
    
    if ( !isdefined( script_index_a ) && isdefined( script_index_b ) )
    {
        println( "<dev string:x2c>" + zone_a.origin );
        return true;
    }
    
    if ( isdefined( script_index_a ) && !isdefined( script_index_b ) )
    {
        println( "<dev string:x2c>" + zone_b.origin );
        return false;
    }
    
    if ( script_index_a > script_index_b )
    {
        return true;
    }
    
    return false;
}

// Namespace hq
// Params 1
// Checksum 0x7caad76c, Offset: 0x326e
// Size: 0x135
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
    
    swapped = 1;
    
    for ( n = zones.size; swapped ; n-- )
    {
        swapped = 0;
        
        for ( i = 0; i < n - 1 ; i++ )
        {
            if ( comparezoneindexes( zones[ i ], zones[ i + 1 ] ) )
            {
                temp = zones[ i ];
                zones[ i ] = zones[ i + 1 ];
                zones[ i + 1 ] = temp;
                swapped = 1;
            }
        }
    }
    
    return zones;
}

// Namespace hq
// Params 0, eflags: 0x4
// Checksum 0xc70799e, Offset: 0x33ac
// Size: 0x1dd
function private setupzones()
{
    triggers = getentarray( "hq_zone", #targetname );
    
    if ( triggers.size == 0 )
    {
        return setupzones_deprecated();
    }
    
    radios = getentarray( "hqloc", #targetname );
    
    if ( radios.size > 0 )
    {
        foreach ( radio in radios )
        {
            radio delete();
        }
    }
    
    foreach ( trigger in triggers )
    {
        visualposition = utility::drop_to_ground( trigger.origin, 100, -2000 );
        visuals = [];
        visuals[ 0 ] = spawn( "script_model", visualposition );
        visuals[ 0 ] setmodel( "military_hq_crate_01_proxy_mp" );
        zone = obj_zonecapture::setupobjective( trigger, visuals );
        zone.onplayerenter = &onplayerenter;
        zone.onplayerexit = &onplayerexit;
        zone callback::add( "zone_captured", &function_e72ab3c1abf1a83c );
        level.objectives[ zone.objectivekey ] = zone;
    }
    
    setomnvar( "ui_hardpoint_active_zone_count", 1 );
    return 1;
}

// Namespace hq
// Params 0
// Checksum 0x2c03e9a6, Offset: 0x3592
// Size: 0x423
function setupzones_deprecated()
{
    if ( level.combinezones )
    {
        hqtrigs = getzonearray( "hq_zone" );
        kothtrigs = getzonearray( "hardpoint_zone" );
        trigs = arraycombine( hqtrigs, kothtrigs );
    }
    else
    {
        trigs = getzonearray( "hardpoint_zone" );
    }
    
    assert( isdefined( trigs ) && trigs.size > 3 );
    maperrors = [];
    errored = 0;
    radios = getscriptablearray( "hqloc", #targetname );
    
    if ( !isdefined( radios ) || radios.size == 0 )
    {
        radios = getentarray( "hqloc", #targetname );
    }
    
    visuals = [];
    
    if ( trigs.size != radios.size )
    {
        maperrors[ maperrors.size ] = "Number of hqloc Radios and hardpoint_zone triggers are not equal";
        errored = 1;
        
        foreach ( trig in trigs )
        {
            var_dbd77be6695974eb = 0;
            
            foreach ( radio in radios )
            {
                if ( radio istouching( trig ) )
                {
                    var_dbd77be6695974eb = 1;
                    break;
                }
            }
            
            if ( !var_dbd77be6695974eb )
            {
                maperrors[ maperrors.size ] = "hardpoint_zone: " + trig.script_label + " has no hqloc radio inside it";
            }
        }
    }
    
    level.objectives = [];
    
    for ( i = 0; i < radios.size ; i++ )
    {
        radio = radios[ i ];
        trig = undefined;
        
        for ( j = 0; j < trigs.size ; j++ )
        {
            if ( radio istouching( trigs[ j ] ) )
            {
                if ( isdefined( trig ) )
                {
                    maperrors[ maperrors.size ] = "Radio at " + radio.origin + " is touching more than one \"hardpoint_zone\" trigger";
                    errored = 1;
                    break;
                }
                
                trig = trigs[ j ];
                break;
            }
        }
        
        if ( !isdefined( trig ) && getdvarint( @"hash_b6e38e5a0db26c74", 0 ) )
        {
            trig = function_47c86977a18df38b( trigs, radio.origin );
            
            /#
                level thread function_7d0c28fd76adedc1( trig.origin, radio.origin );
            #/
        }
        
        if ( !isdefined( trig ) )
        {
            if ( !errored )
            {
                maperrors[ maperrors.size ] = "Radio at " + radio.origin + " is not inside any \"hardpoint_zone\" trigger";
                errored = 1;
                continue;
            }
        }
        
        assert( !errored );
        visuals = [];
        visuals[ 0 ] = radio;
        
        if ( isdefined( radio.target ) )
        {
            othervisuals = getentarray( radio.target, #targetname );
            
            if ( isdefined( othervisuals ) )
            {
                for ( k = 0; k < othervisuals.size ; k++ )
                {
                    visuals[ visuals.size ] = othervisuals[ k ];
                }
            }
        }
        
        if ( isdefined( trig ) )
        {
            zone = obj_zonecapture::setupobjective( trig, visuals );
            level.objectives[ zone.objectivekey ] = zone;
            zone.onplayerenter = &onplayerenter;
            zone.onplayerexit = &onplayerexit;
            zone callback::add( "zone_captured", &function_e72ab3c1abf1a83c );
        }
    }
    
    setomnvar( "ui_hardpoint_active_zone_count", 1 );
    
    if ( maperrors.size > 0 )
    {
        /#
            println( "<dev string:x5b>" );
            
            for ( i = 0; i < maperrors.size ; i++ )
            {
                println( maperrors[ i ] );
            }
            
            println( "<dev string:x82>" );
        #/
        
        assertmsg( "<dev string:xa9>" );
        return;
    }
    
    return 1;
}

/#

    // Namespace hq
    // Params 2
    // Checksum 0xdf4d02ae, Offset: 0x39be
    // Size: 0x53, Type: dev
    function function_7d0c28fd76adedc1( origin1, origin2 )
    {
        while ( true )
        {
            line( origin1, origin2, ( 1, 0, 0 ), 1, 0, 1 );
            box( origin1, 0, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

#/

// Namespace hq
// Params 0
// Checksum 0xf624878a, Offset: 0x3a19
// Size: 0xaf
function setupzonecallouts()
{
    areaid = undefined;
    zonetrigger = level.zone.visuals[ 0 ];
    
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
        setomnvar( "ui_hp_callout_id", areaid );
    }
    
    codcaster_utils::function_3038b6eafc46c037( 6, "free" );
    assert( isdefined( areaid ), "<dev string:xbf>" + zonetrigger.targetname + "<dev string:xcd>" );
}

// Namespace hq
// Params 0
// Checksum 0x6deb534d, Offset: 0x3ad0
// Size: 0xae
function forcespawnplayers()
{
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( !isdefined( player ) || player.fauxdead && player utility::isusingremote() || isalive( player ) && !player.fauxdead )
        {
            continue;
        }
        
        objidpoolmanager::objective_unpin_player( level.zone.objidnum, player );
        player notify( #"force_spawn" );
        waitframe();
    }
    
    thread function_5172313810f750de();
}

// Namespace hq
// Params 0
// Checksum 0x34f16f5c, Offset: 0x3b86
// Size: 0xc4
function function_5172313810f750de()
{
    wait 3;
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( player player::isinkillcam() )
        {
            player thread function_65b5f10f5f273d27();
            continue;
        }
        else if ( !isdefined( player ) || player.fauxdead && player utility::isusingremote() || isalive( player ) && !player.fauxdead )
        {
            continue;
        }
        
        objidpoolmanager::objective_unpin_player( level.zone.objidnum, player );
        player notify( #"force_spawn" );
        waitframe();
    }
}

// Namespace hq
// Params 0
// Checksum 0xc160427f, Offset: 0x3c52
// Size: 0x3b
function function_65b5f10f5f273d27()
{
    level endon( #"game_ended" );
    self endon( #"spawned" );
    
    while ( player::isinkillcam() )
    {
        wait 0.1;
    }
    
    wait 1;
    self notify( #"force_spawn" );
}

// Namespace hq
// Params 0
// Checksum 0x65fe06f8, Offset: 0x3c95
// Size: 0xca
function getspawnpoint()
{
    var_ebfc366885697c15 = getkothzonedeadzonedist();
    spawnparams = spawnfactor::function_daea503b73d07eed( level.zone.trigger getentitynumber(), level.zone.furthestspawndistsq, var_ebfc366885697c15 * var_ebfc366885697c15, 12250000 );
    factorset = #"default";
    spawngroup = #"primary";
    
    if ( level.zone.active )
    {
        factorset = #"objective";
        spawngroup = level.zone.spawngroup;
    }
    
    return spawnlogic::function_3f9d5fcfb93d4190( self, spawnparams, spawngroup, #"fallback", factorset, 2 );
}

// Namespace hq
// Params 0
// Checksum 0xe8ae697, Offset: 0x3d68
// Size: 0x24
function getkothzonedeadzonedist()
{
    if ( !level.zone.active )
    {
        return 2000;
    }
    
    return 1000;
}

// Namespace hq
// Params 1
// Checksum 0x7424eae9, Offset: 0x3d94
// Size: 0x9c
function onspawnplayer( revivespawn )
{
    self setclientomnvar( "ui_hq_norespawn", 0 );
    
    if ( isdefined( level.zone ) && isdefined( level.zone.ownerteam ) && level.zone.ownerteam != "neutral" )
    {
        setomnvar( "ui_hq_num_alive", teams::getteamdata( level.zone.ownerteam, "aliveCount" ) );
    }
    
    self.forcespawnnearteammates = undefined;
    self.skipspawncamera = undefined;
    thread updatematchstatushintonspawn();
}

// Namespace hq
// Params 1
// Checksum 0xbe6e36ad, Offset: 0x3e38
// Size: 0x12c
function movezoneaftertime( time )
{
    level notify( #"hash_3cfe4c8aad7733c7" );
    level endon( #"hash_3cfe4c8aad7733c7" );
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level endon( #"hash_a5281c9480b32767" );
    level.zonemovetime = time;
    level.zonedestroyedbytimer = 0;
    obj_zonecapture::zonetimerwait();
    level.zonedestroyedbytimer = 1;
    
    if ( level.zoneselectiondelay + level.zoneactivationdelay > 5 )
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( "hp_timeout", entry );
        }
    }
    
    codcaster_utils::function_3038b6eafc46c037( 9, "free" );
    level notify( #"zone_moved" );
    level notify( #"zone_destroyed" );
}

// Namespace hq
// Params 1
// Checksum 0xb83dc8b1, Offset: 0x3f6c
// Size: 0x2c
function onsuicidedeath( victim )
{
    setomnvar( "ui_hq_num_alive", teams::getteamdata( victim.team, "aliveCount" ) );
}

// Namespace hq
// Params 1
// Checksum 0xd5068718, Offset: 0x3fa0
// Size: 0x2c
function modeonteamchangedeath( player )
{
    setomnvar( "ui_hq_num_alive", teams::getteamdata( player.leaving_team, "aliveCount" ) );
}

// Namespace hq
// Params 1
// Checksum 0x628ddda8, Offset: 0x3fd4
// Size: 0x3a, Type: bool
function canspawnontacinsert( player )
{
    var_e1f56f993330b617 = level.zone.ownerteam == player.team;
    return !var_e1f56f993330b617;
}

// Namespace hq
// Params 1
// Checksum 0x2c487fcb, Offset: 0x4017
// Size: 0x3f1
function function_8314535b81f548e( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    ownerteam = level.zone.ownerteam;
    
    if ( !isplayer( attacker ) || !isplayer( victim ) || attacker.team == victim.team )
    {
        if ( ownerteam != "neutral" )
        {
            victim.skipspawncamera = 1;
        }
        
        return;
    }
    
    if ( !isdefined( ownerteam ) )
    {
        return;
    }
    
    if ( isdefined( deathdata.objweapon ) && weapon::iskillstreakweapon( deathdata.objweapon.basename ) )
    {
        return;
    }
    
    if ( ownerteam != "neutral" )
    {
        level updatehqaliveomnvars( ownerteam );
    }
    
    if ( ownerteam == victim.team )
    {
        victim.skipspawncamera = 1;
    }
    
    var_a844077fc818e557 = 0;
    
    if ( level.zone.active )
    {
        if ( !level.scoreeventglobals.var_d25fb6c0265395c5 && level.zonecapturetime > 0 && attacker istouching( level.zone.trigger ) )
        {
            if ( ownerteam != attacker.team )
            {
                var_a844077fc818e557 = 1;
            }
        }
        
        if ( attacker.team != ownerteam )
        {
            if ( var_a844077fc818e557 )
            {
                attacker thread points::function_aa3f27bc29d005fc( #"capture_kill" );
            }
            else if ( victim istouching( level.zone.trigger ) )
            {
                attacker thread rank::function_d2aa8986c506e985( #"assault" );
                attacker events::function_58da673c1c3fc9f2();
                attacker thread events::function_f3b6ddfecdb144fa( level.zone.objectivekey );
                attacker stats::setextrascore1( attacker.pers[ "extrascore1" ] + 1 );
                victim thread utility::trycall( level.matchdata_logvictimkillevent, deathdata.lifeid, "defending" );
            }
        }
        else if ( attacker istouching( level.zone.trigger ) )
        {
            attacker thread rank::function_d2aa8986c506e985( #"defend" );
            attacker events::function_20a5f572df6afd43();
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
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x13f>" );
                
                if ( isdefined( attacker.pers[ "defends" ] ) )
                {
                    attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                }
            }
            
            attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
            attacker stats::setextrascore1( attacker.pers[ "defends" ] );
            
            if ( isdefined( attacker.var_c36e159445e2a48b ) )
            {
                attacker.var_c36e159445e2a48b++;
                
                if ( attacker.var_c36e159445e2a48b == 5 )
                {
                    attacker thread events::function_d4fd7d540188e407();
                }
            }
        }
    }
    
    thread checkallowspectating();
}

// Namespace hq
// Params 0
// Checksum 0xfee0094e, Offset: 0x4410
// Size: 0x72
function checkallowspectating()
{
    if ( level.zone.ownerteam == "neutral" )
    {
        return;
    }
    
    if ( !teams::getteamdata( level.zone.ownerteam, "aliveCount" ) )
    {
        level.spectateoverride[ level.zone.ownerteam ].allowenemyspectate = 1;
        spectating::updatespectatesettings();
    }
}

// Namespace hq
// Params 1
// Checksum 0x64301eda, Offset: 0x448a
// Size: 0x23
function updatehqaliveomnvars( ownerteam )
{
    setomnvar( "ui_hq_num_alive", teams::getteamdata( ownerteam, "aliveCount" ) );
}

// Namespace hq
// Params 6
// Checksum 0x2ed70571, Offset: 0x44b5
// Size: 0x387
function give_capture_credit( touchlist, capturetime, capture_team, lastcaptureteam, credit_player, hqgameobject )
{
    level endon( #"game_ended" );
    level.lastcaptime = gettime();
    
    if ( isdefined( credit_player.owner ) )
    {
        if ( gameobjects::function_e17a356e69f57699( credit_player ) && !arraycontains( touchlist, credit_player.owner ) )
        {
            credit_player callback::callback( #"hash_a4b2d4dcbb4cda95", { #capturebot:credit_player } );
        }
        
        credit_player = credit_player.owner;
    }
    
    if ( isplayer( credit_player ) )
    {
        if ( !isscoreboosting( credit_player ) )
        {
            telemetry_data = spawnstruct();
            telemetry_data.player = credit_player;
            telemetry_data.eventname = "capture";
            telemetry_data.position = credit_player.origin;
            telemetry_utils::function_af2d366f9522f76f( "callback_on_game_event", telemetry_data );
            credit_player thread rank::function_d2aa8986c506e985( #"hq_secure" );
            credit_player thread points::doscoreevent( #"mode_hp_secure" );
            credit_player thread smoke_grenade::function_99543ad5d551cdb5();
            
            if ( isdefined( level.zone.lastactivatetime ) && gettime() - level.zone.lastactivatetime <= 2100 )
            {
                credit_player thread points::doscoreevent( #"mode_hp_quick_cap" );
            }
            
            if ( credit_player.lastkilltime + 500 > gettime() )
            {
            }
            else if ( isdefined( level.var_f0e13be5ddad6cd1 ) )
            {
                credit_player [[ level.var_f0e13be5ddad6cd1 ]]( credit_player );
            }
        }
    }
    
    players = getarraykeys( touchlist );
    
    for ( i = 0; i < players.size ; i++ )
    {
        player = touchlist[ players[ i ] ].player;
        player updatecapsperminute( lastcaptureteam );
        
        if ( !isscoreboosting( player ) )
        {
            player codcasterclientmatchdata::function_8ecc753b54a5740f( 15, 1 );
            
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
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x13f>" );
                
                if ( isdefined( player.pers[ "captures" ] ) )
                {
                    player.pers[ "captures" ] = player.pers[ "captures" ] + 1;
                }
            }
            
            player persistence::statsetchild( "round", "captures", player.pers[ "captures" ] );
            player stats::setextrascore0( player.pers[ "captures" ] );
        }
        else
        {
            /#
                player iprintlnbold( "<dev string:x165>" );
            #/
        }
        
        waitframe();
    }
    
    if ( isdefined( hqgameobject.assisttouchlist ) )
    {
        if ( hqgameobject.assisttouchlist[ capture_team ].size > 0 )
        {
            hqgameobject thread function_41a08d13bbf49b31( capture_team, credit_player );
        }
    }
}

// Namespace hq
// Params 2
// Checksum 0xcbb484a2, Offset: 0x4844
// Size: 0x13a
function function_41a08d13bbf49b31( team, credit_player )
{
    level endon( #"game_ended" );
    var_e1fea56171575e06 = getarraykeys( self.assisttouchlist[ team ] );
    
    if ( var_e1fea56171575e06.size > 0 )
    {
        for ( index = 0; index < var_e1fea56171575e06.size ; index++ )
        {
            player = self.assisttouchlist[ team ][ var_e1fea56171575e06[ index ] ].player;
            
            if ( isdefined( player.owner ) )
            {
                player = player.owner;
            }
            
            if ( !isplayer( player ) || player == credit_player )
            {
                continue;
            }
            
            if ( level.gamemodebundle.var_9a091b8fbf3b4e70 )
            {
                player thread points::doscoreevent( #"mode_hp_secure" );
                player thread smoke_grenade::function_99543ad5d551cdb5();
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
            waitframe();
        }
    }
}

// Namespace hq
// Params 0
// Checksum 0xd0c12d35, Offset: 0x4986
// Size: 0x10d
function awardcapturepoints()
{
    level endon( #"game_ended" );
    level endon( #"zone_reset" );
    level endon( #"zone_moved" );
    level notify( #"awardcapturepointsrunning" );
    level endon( #"awardcapturepointsrunning" );
    seconds = 1;
    score = 1;
    
    while ( !level.gameended )
    {
        waittime = 0;
        
        while ( waittime < seconds )
        {
            wait level.framedurationseconds;
            hostmigration::waittillhostmigrationdone();
            waittime += level.framedurationseconds;
        }
        
        team = level.zone gameobjects::getownerteam();
        
        if ( team == "neutral" )
        {
            continue;
        }
        
        if ( level.zoneadditivescoring )
        {
            score = level.zone.touchlist[ team ].size;
        }
        
        gamescore::giveteamscoreforobjective( team, score, 0 );
        
        if ( !level.scoreleadchanged )
        {
            adjustmatchtimerpausedstatefromleadchange( team );
        }
    }
}

// Namespace hq
// Params 1
// Checksum 0x313f22b6, Offset: 0x4a9b
// Size: 0x6b
function adjustmatchtimerpausedstatefromleadchange( team )
{
    if ( !level.pausemodetimer )
    {
        return;
    }
    
    ownerteamscore = gamescore::getteamscore( team );
    otherteamscore = gamescore::getteamscore( team_utility::getotherteam( team ) );
    
    if ( ownerteamscore > otherteamscore )
    {
        level.scoreleadchanged = 1;
        level gamelogic_mp::resumetimer();
        return;
    }
    
    level gamelogic_mp::pausetimer();
}

// Namespace hq
// Params 1
// Checksum 0x99effabc, Offset: 0x4b0e
// Size: 0xcf
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
    
    self.capsperminute = self.numcaps / minutespassed;
    
    if ( self.capsperminute > self.numcaps )
    {
        self.capsperminute = self.numcaps;
    }
}

// Namespace hq
// Params 1
// Checksum 0xcb8f7612, Offset: 0x4be5
// Size: 0x1a, Type: bool
function isscoreboosting( player )
{
    return player.capsperminute > 3;
}

// Namespace hq
// Params 1
// Checksum 0xfd435b5e, Offset: 0x4c08
// Size: 0x19
function onplayerenter( player )
{
    player.var_c36e159445e2a48b = 0;
}

// Namespace hq
// Params 1
// Checksum 0xfb55cc84, Offset: 0x4c29
// Size: 0x17
function onplayerexit( player )
{
    player.var_c36e159445e2a48b = undefined;
}

// Namespace hq
// Params 1
// Checksum 0xdfbdddd9, Offset: 0x4c48
// Size: 0x12b
function onplayerconnect( player )
{
    player setclientomnvar( "ui_hq_norespawn", 0 );
    player._hardpointeffect = [];
    player.numcaps = 0;
    player.capsperminute = 0;
    player.timebyrotation = [];
    player stats::setextrascore0( player.pers[ "captures" ] ?? 0, "captures" );
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
}

// Namespace hq
// Params 1
// Checksum 0x5eb061a6, Offset: 0x4d7b
// Size: 0xd4
function onplayerspawned( spawndata )
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

// Namespace hq
// Params 1
// Checksum 0x31cb3cfd, Offset: 0x4e57
// Size: 0x3f
function gethqownerteamvalue( ownerteam )
{
    if ( ownerteam == "allies" )
    {
        omnvarval = 2;
    }
    else if ( ownerteam == "axis" )
    {
        omnvarval = 1;
    }
    else
    {
        omnvarval = 0;
    }
    
    return omnvarval;
}

// Namespace hq
// Params 0
// Checksum 0x523a151e, Offset: 0x4e9f
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

// Namespace hq
// Params 0
// Checksum 0x4c05078, Offset: 0x4f8e
// Size: 0x62
function getrespawndelay()
{
    if ( !level.delayplayer )
    {
        return;
    }
    
    ownerteam = level.zone.ownerteam;
    
    if ( isdefined( ownerteam ) )
    {
        if ( self.pers[ "team" ] == ownerteam )
        {
            if ( !level.spawndelay )
            {
                return;
            }
            
            return level.spawndelay;
        }
    }
}

// Namespace hq
// Params 0
// Checksum 0x14e798c2, Offset: 0x4ff8
// Size: 0xa4
function updatematchstatushintonspawn()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.zone ) )
    {
        if ( isdefined( level.zone.ownerteam ) )
        {
            if ( level.zone.ownerteam == "neutral" )
            {
                hud_message::function_ef4318a0090caa0f( #"hq_capture" );
                return;
            }
            
            if ( level.zone.ownerteam == self.team )
            {
                hud_message::function_ef4318a0090caa0f( #"hq_defend" );
                return;
            }
            
            hud_message::function_ef4318a0090caa0f( #"hash_f66dc1118126fb76" );
        }
    }
}

// Namespace hq
// Params 0
// Checksum 0x7a778d3a, Offset: 0x50a4
// Size: 0x35
function showrespawnwarningmessage()
{
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_hq_norespawn", 1 );
    self playlocalsound( "mp_hq_respawn_disabled" );
    wait 5;
    self setclientomnvar( "ui_hq_norespawn", 0 );
}

// Namespace hq
// Params 0
// Checksum 0xe8df9f3a, Offset: 0x50e1
// Size: 0x80
function seticonnames()
{
    level.icontarget = "hq_target";
    level.iconneutral = "hq_neutral";
    level.iconcapture = "hq_destroy";
    level.icondefend = "hq_defend";
    level.iconcontested = "hq_contested";
    level.icontaking = "hq_taking";
    level.iconlosing = "hq_losing";
    level.icondefending = "hq_defending";
    level.icondisabling = "hq_disabling";
}

// Namespace hq
// Params 0
// Checksum 0x1083ba37, Offset: 0x5169
// Size: 0x13d
function setwaypoints()
{
    gamelogic_mp::setwaypointiconinfo( "hq_destroy", 0, "enemy", &"mp_ingame_only/obj_destroy_caps", "ui_icon_waypoint_headquarters", 0, 1 );
    gamelogic_mp::setwaypointiconinfo( "hq_defend", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "ui_icon_waypoint_headquarters", 0, 1 );
    gamelogic_mp::setwaypointiconinfo( "hq_defending", 0, "friendly", &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "ui_icon_waypoint_headquarters", 0, 1 );
    gamelogic_mp::setwaypointiconinfo( "hq_neutral", 0, "neutral", &"MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "ui_icon_waypoint_headquarters", 0, 1 );
    gamelogic_mp::setwaypointiconinfo( "hq_contested", 0, "contest", &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "ui_icon_waypoint_headquarters", 0, 1 );
    gamelogic_mp::setwaypointiconinfo( "hq_losing", 0, "enemy", &"MP_INGAME_ONLY/OBJ_LOSING_CAPS", "ui_icon_waypoint_headquarters", 0, 1 );
    gamelogic_mp::setwaypointiconinfo( "hq_target", 0, "neutral", &"MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "ui_icon_waypoint_headquarters", 0, 2 );
    gamelogic_mp::setwaypointiconinfo( "hq_taking", 0, "friendly", &"MP_INGAME_ONLY/OBJ_CAPTURING_CAPS", "ui_icon_waypoint_headquarters", 0, 1 );
    gamelogic_mp::setwaypointiconinfo( "hq_disabling", 0, "friendly", &"mp_ingame_only/obj_destroying_caps", "ui_icon_waypoint_headquarters", 0, 1 );
}

// Namespace hq
// Params 0
// Checksum 0x516806e0, Offset: 0x52ae
// Size: 0x16
function writeplayerrotationscoretomatchdataongameend()
{
    level waittill( #"game_ended" );
    writecurrentrotationteamscore();
}

// Namespace hq
// Params 0
// Checksum 0xbbfa220e, Offset: 0x52cc
// Size: 0x49
function writecurrentrotationteamscore()
{
    if ( level.kothhillrotation < 24 )
    {
        setmatchdata( "alliesRoundScore", level.kothhillrotation, getteamscore( "allies" ) );
        setmatchdata( "axisRoundScore", level.kothhillrotation, getteamscore( "axis" ) );
    }
}

/#

    // Namespace hq
    // Params 3
    // Checksum 0xea22ea73, Offset: 0x531d
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

    // Namespace hq
    // Params 0
    // Checksum 0x9a6bcb4d, Offset: 0x53cf
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

    // Namespace hq
    // Params 0
    // Checksum 0x604ee841, Offset: 0x5752
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

    // Namespace hq
    // Params 0
    // Checksum 0xd318ab24, Offset: 0x57d4
    // Size: 0xb9, Type: dev
    function function_72b77b174bc3e293()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_796deaab0da995a1" ) != 0 )
            {
                level notify( #"hash_a5281c9480b32767" );
                level.zoneduration = 1;
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

    // Namespace hq
    // Params 0
    // Checksum 0x68b0efe9, Offset: 0x5895
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

    // Namespace hq
    // Params 0
    // Checksum 0x794296c5, Offset: 0x5920
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
                        zone.neutralhardpointfx[ zone.neutralhardpointfx.size ] = spawnfx( level.hardpointfxid[ "<dev string:x24>" ], zone.visuals[ i ].baseorigin, fxfwd );
                        zone.neutralhardpointfx[ zone.neutralhardpointfx.size - 1 ] setfxkilldefondelete();
                        triggerfx( zone.neutralhardpointfx[ zone.neutralhardpointfx.size - 1 ] );
                    }
                    
                    zone gameobjects::setobjectivestatusicons( level.iconneutral );
                    zone gameobjects::setvisibleteam( "<dev string:x1aa>" );
                }
            }
            
            setdevdvar( @"hash_c000ec9a5a2f4b6c", 0 );
            wait 1;
        }
    }

    // Namespace hq
    // Params 0
    // Checksum 0xc6da29aa, Offset: 0x5bcf
    // Size: 0xa2, Type: dev
    function function_e943dce050e3f40d()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x1ae>", getdvarint( @"scr_give_score_allies" ), 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x1b5>", getdvarint( @"scr_give_score_axis" ), 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_e943dce050e3f40d();
    }

#/
