// scripts\mp\br\gametypes\br_gametype_extraction.gsc  (hash_3a02cc3596fdfc40.gscc) (size: 35191 Bytes / 0x8977 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x229f4d83 (580865411)
// size ...... 35191 (0x8977)
// includes .. 34  (offset: 0x8333)
// strings ... 86  (offset: 0x8443)
// dev strs .. 1   (offset: 0x896b)
// exports ... 91  (offset: 0x5563)
// cseg ...... 0x73c + 0x4e27 (0x5563)
// imports ... 256 (offset: 0x639b)
// animtree1 . 0   (offset: 0x8977)
// animtree2 . 0   (offset: 0x8977)
#using script_16ea1b94f0f381b3;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\common\killstreaks\flares;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damagefeedback;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\teams;

#namespace br_gametype_extraction;

// Namespace br_gametype_extraction
// Params 0, eflags: 0x1
// Checksum 0x334c6da, Offset: 0x75a
// Size: 0x19
function autoexec main()
{
    if ( game_utility::getgametype() != "extract" )
    {
        return;
    }
    
    init();
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x7eeb55d1, Offset: 0x77b
// Size: 0x17e
function init()
{
    br_gametypes::disablefeature( #"plundersites" );
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"littlebirdspawns" );
    br_gametypes::disablefeature( #"onelife" );
    br_gametypes::disablefeature( #"kiosk" );
    utility::registersharedfunc( #"gametype", #"hash_734dfff09080996f", &playerpostsetplunder );
    utility::registersharedfunc( #"gametype", #"hash_c58d6a4317d0041e", &playerdropplunderondeath );
    utility::registersharedfunc( #"gametype", #"playershouldrespawn", &playershouldrespawn );
    utility::registersharedfunc( #"gametype", #"hash_a4eabcdb5f3aac07", &isvalidspectatetarget );
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &playerwelcomesplashes );
    utility::registersharedfunc( #"gametype", #"hash_251cc1c137f65b9e", &spawnhandled );
    level.brgametype.dropbagdelay = 120;
    level.brgametype.maxextractions = getdvarint( @"hash_b6a790d232323e81", 5 );
    level.brgametype.numextractions = 0;
    level.brgametype.firstteam = "tie";
    thread initpostmain();
    
    /#
        thread devthink();
    #/
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xd9045bf9, Offset: 0x901
// Size: 0x4e
function initpostmain()
{
    waittillframeend();
    flags::gameflaginit( "collect_done", 0 );
    flags::gameflaginit( "helipad_wait_done", 0 );
    level.modemayconsiderplayerdead = &brmayconsiderplayerdead;
    thread setupmission();
    thread setupextractionsites();
    thread setupteamplunderhud();
    thread setupextractnumhud();
    thread setuptimelimit();
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x9c5e9dfc, Offset: 0x957
// Size: 0x7a
function playerwelcomesplashes( data )
{
    self endon( #"disconnect" );
    self waittill( #"spawned_player" );
    wait 1;
    hud_message::showsplash( "br_prematch_welcome" );
    
    if ( !level.br_infils_disabled )
    {
        self waittill( #"br_jump" );
        
        while ( !self isonground() )
        {
            waitframe();
        }
    }
    else
    {
        level waittill( #"prematch_done" );
    }
    
    wait 1;
    hud_message::showsplash( "br_gametype_extract_welcome" );
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x2c62dbb7, Offset: 0x9d9
// Size: 0x26, Type: bool
function spawnhandled( player )
{
    return player.br_infilstarted && flags::gameflag( "prematch_done" );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x102b397f, Offset: 0xa08
// Size: 0x2
function getdropbagdelay()
{
    
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xb784e2b2, Offset: 0xa12
// Size: 0x26, Type: bool
function brmayconsiderplayerdead( player )
{
    if ( !spawnhandled( player ) )
    {
        return true;
    }
    
    player thread playerrespawn();
    return true;
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x2f42713b, Offset: 0xa41
// Size: 0x19e
function playerrespawn()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_17f3151ec6647b00 = 1;
    wait var_17f3151ec6647b00;
    spawnwait = getdvarint( @"hash_5639a8f49b94dacb", 20 );
    
    if ( spawnwait > 0 )
    {
        const_y_offset = 70;
        const_x_offset = 30;
        var_7a59a308ac3a76d0 = 4;
        var_e1d70a3f47074c0f = -4;
        playerlogic::respawn_asspectator( self.origin, self.angles );
        hudstring = hud_util::createfontstring( "hudsmall", 1 );
        hudstring hud_util::setpoint( "RIGHT", "CENTER", const_x_offset + var_e1d70a3f47074c0f, const_y_offset );
        hudstring.label = &"mp/waiting_to_spawn";
        hudtimer = hud_util::createtimer( "hudsmall", 1 );
        hudtimer hud_util::setpoint( "LEFT", "CENTER", const_x_offset + var_7a59a308ac3a76d0, const_y_offset );
        hudtimer settimer( spawnwait );
        utility::waittill_notify_or_timeout( "teamExtractedSpawnSpectate", spawnwait );
        hudtimer destroy();
        hudstring destroy();
    }
    
    if ( br_spawnrespawn::isteamextracted( self.team ) )
    {
        return;
    }
    
    pre_spawn_delay = 1;
    thread br_spawnrespawn::fadeoutin( pre_spawn_delay );
    wait pre_spawn_delay;
    
    if ( br_spawnrespawn::isteamextracted( self.team ) )
    {
        return;
    }
    
    playerlogic::spawnplayer( undefined, 0 );
    execution::_clearexecution();
    br_pickups::initplayer();
    thread br_spawnrespawn::triggerrespawnoverlay( 4 );
    br_gulag::gulagwinnerrespawn( 1 );
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xaa7bf170, Offset: 0xbe7
// Size: 0xe, Type: bool
function playershouldrespawn( data )
{
    return true;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xc19f1fde, Offset: 0xbfe
// Size: 0x1e, Type: bool
function isvalidspectatetarget( player )
{
    return !br_spawnrespawn::isteamextracted( player.team );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x40039364, Offset: 0xc25
// Size: 0x23
function setupmission()
{
    level.brgametype.extractposition = getextractionposition();
    thread makeextractionobjective();
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xcb3175c, Offset: 0xc50
// Size: 0xe9
function getextractionposition()
{
    const_height_offset = 2500;
    centerpt = level.br_level.br_mapcenter;
    randomangles = ( 0, randomfloatrange( 0, 360 ), 0 );
    pathdir = anglestoforward( randomangles );
    pathradius = level.br_level.br_circleradii[ 0 ] * 2;
    endpt = centerpt + pathdir * pathradius;
    endpt = br_c130::snappointtooutofboundstriggertrace( centerpt, endpt );
    heightent = getent( "airstrikeheight", #targetname );
    start = ( endpt[ 0 ], endpt[ 1 ], heightent.origin[ 2 ] );
    groundpt = tracegroundpoint( start );
    endpt = groundpt + ( 0, 0, const_height_offset );
    return endpt;
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x1eec7de0, Offset: 0xd42
// Size: 0x7a
function makeextractionobjective()
{
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    level.brgametype.objectiveiconid = objectiveiconid;
    assert( objectiveiconid != -1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "current", level.brgametype.extractposition, "icon_waypoint_koth" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 0 );
        objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x5e54e26f, Offset: 0xdc4
// Size: 0xb7
function setupmissionwidget()
{
    flags::gameflagwait( "prematch_done" );
    xp = getcurrentxp();
    startindex = br_contract_manager::getquesttableindex( "gt_extract_1" );
    
    foreach ( player in level.players )
    {
        player br_contract_manager::setquestindexomnvar( startindex );
        player br_contract_manager::uiobjectivesetparameter( xp );
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x3698dc0c, Offset: 0xe83
// Size: 0x7f
function getcurrentxp()
{
    xp = getdvarint( @"hash_911e056fab287a06", 5000 );
    xpmin = getdvarint( @"hash_728f3c5d729a3f2d", 2000 );
    xpdecrease = getdvarint( @"hash_802cc155c089e133", 200 );
    
    if ( xpmin > 0 )
    {
        xp = int( max( xpmin, xp - level.brgametype.numextractions * xpdecrease ) );
    }
    
    return xp;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xe418fa3c, Offset: 0xf0b
// Size: 0xad
function showextractionobjectivetoteam( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        objidpoolmanager::objective_playermask_addshowplayer( level.brgametype.objectiveiconid, player );
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xb5c1e7d6, Offset: 0xfc0
// Size: 0xad
function hideextractionobjectivefromteam( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        objidpoolmanager::objective_playermask_hidefrom( level.brgametype.objectiveiconid, player );
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x7500138e, Offset: 0x1075
// Size: 0x167
function helidrivablethink()
{
    self endon( #"death" );
    self endon( #"missioncomplete" );
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    self.objectiveiconid = objectiveiconid;
    thread helidrivabledeathall();
    assert( objectiveiconid != -1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "current", ( 0, 0, 0 ), "ui_mp_br_mapmenu_legend_littlebird" );
        objidpoolmanager::update_objective_onentity( objectiveiconid, self );
        objidpoolmanager::update_objective_setzoffset( objectiveiconid, 100 );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
    }
    
    while ( true )
    {
        while ( self.occupants.size == 0 || !isdefined( self.ownerteam ) )
        {
            waitframe();
        }
        
        team = self.ownerteam;
        showextractionobjectivetoteam( team );
        objidpoolmanager::update_objective_ownerteam( objectiveiconid, team );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 0 );
        objidpoolmanager::objective_playermask_showtoall( objectiveiconid );
        thread helidrivablemission( self.ownerteam );
        thread helidrivabledeath( self.ownerteam );
        
        while ( self.occupants.size > 0 )
        {
            waitframe();
        }
        
        hideextractionobjectivefromteam( team );
        objidpoolmanager::update_objective_ownerteam( objectiveiconid, undefined );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_playermask_hidefromall( objectiveiconid );
        self notify( #"hash_fbbcd346da2eab6a" );
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x737f4034, Offset: 0x11e4
// Size: 0x4f
function helidrivabledeathall()
{
    level endon( #"game_ended" );
    self endon( #"missioncomplete" );
    self waittill( #"death" );
    thread drophelicrate( self );
    objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
    objidpoolmanager::returnobjectiveid( self.objectiveiconid );
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xb7421b83, Offset: 0x123b
// Size: 0x100
function helidrivablemission( team )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_fbbcd346da2eab6a" );
    complete_dist_sq = 90000;
    
    while ( true )
    {
        distsq = distance2dsquared( self.origin, level.brgametype.extractposition );
        
        if ( distsq < complete_dist_sq )
        {
            if ( level.brgametype.numextractions == 0 )
            {
                level.brgametype.firstteam = team;
            }
            
            teamextractedvictory( team, self );
            
            if ( level.brgametype.maxextractions > 0 && level.brgametype.numextractions >= level.brgametype.maxextractions )
            {
                thread brendgame();
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xae0c6939, Offset: 0x1343
// Size: 0x3a
function helidrivabledeath( team )
{
    level endon( #"game_ended" );
    self endon( #"hash_fbbcd346da2eab6a" );
    self waittill( #"death" );
    hideextractionobjectivefromteam( team );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xa17d4013, Offset: 0x1385
// Size: 0x1d2
function doteamextractedupdate()
{
    level.brgametype.numextractions++;
    level.brgametype.hudextractnum setvalue( level.brgametype.numextractions );
    level.brgametype.hudextractnum thread huddopulse();
    level.brgametype.hudextractmax thread huddopulse();
    cost = getcost();
    level.brgametype.hudcost setvalue( cost * 10 );
    
    foreach ( entry, teamdata in level.teamdata )
    {
        if ( teamdata[ "teamCount" ] > 0 )
        {
            updateteamplunderhud( entry );
        }
    }
    
    xp = getcurrentxp();
    
    foreach ( player in level.players )
    {
        if ( !br_spawnrespawn::isteamextracted( player.team ) )
        {
            player thread hud_message::showsplash( "br_gametype_extract_extracted" );
            player br_contract_manager::uiobjectivesetparameter( xp );
        }
    }
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0xfa9eecef, Offset: 0x155f
// Size: 0x190
function teamextractedvictory( team, heli )
{
    level endon( #"game_ended" );
    br_spawnrespawn::setteamasextracted( team );
    outofbounds::enableoobimmunity( self );
    hideextractionobjectivefromteam( team );
    
    if ( isdefined( heli ) )
    {
        heli notify( #"missioncomplete" );
        objidpoolmanager::objective_playermask_hidefromall( heli.objectiveiconid );
        objidpoolmanager::returnobjectiveid( heli.objectiveiconid );
    }
    
    br_public::brleaderdialogteam( "team_victory", team );
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player br::calculatebrbonusxp( 1 );
        player br_contract_manager::uiobjectivehide();
        player setclientomnvar( "post_game_state", 8 );
        player setclientomnvar( "ui_br_end_game_splash_type", 1 );
        outofbounds::enableoobimmunity( player );
        player.spawnprotection = 1;
    }
    
    doteamextractedupdate();
    thread teamextractedspawnspectate( team, heli );
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0x1745a592, Offset: 0x16f7
// Size: 0x140
function teamextractedspawnspectate( team, heli )
{
    wait 2;
    data = spawnstruct();
    
    if ( isdefined( heli ) )
    {
        data.origin = heli.origin;
    }
    else
    {
        data.origin = ( 0, 0, 0 );
    }
    
    data.angles = ( 0, 0, 0 );
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        player setclientomnvar( "post_game_state", 0 );
        player setclientomnvar( "ui_br_end_game_splash_type", -1 );
        player notify( #"teamExtractedSpawnSpectate" );
        player thread br_spectate::spawnspectator( data, 1, 1 );
    }
    
    if ( isdefined( heli ) )
    {
        heli delete();
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xf387b2aa, Offset: 0x183f
// Size: 0x43
function brendgame()
{
    wait 1.5;
    handleendgamesplash();
    gamelogic_mp::endgame_regularmp( level.brgametype.firstteam, game[ "end_reason" ][ "objective_completed" ], game[ "end_reason" ][ "br_eliminated" ] );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x88b5c474, Offset: 0x188a
// Size: 0x95
function handleendgamesplash()
{
    foreach ( player in level.players )
    {
        if ( !br_spawnrespawn::isteamextracted( player.team ) )
        {
            player setclientomnvar( "post_game_state", 2 );
        }
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xe821f019, Offset: 0x1927
// Size: 0x224
function setuptimelimit()
{
    level endon( #"game_ended" );
    var_da985de47c1f142a = 120;
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.br_infils_disabled )
    {
        level waittill( #"br_ready_to_jump" );
    }
    
    waitframe();
    missionhud = createhudelem( &"mp_br_ingame/extract_collect_plunder", undefined, "CENTER", "CENTER", 0, -170 );
    missionhud.alpha = 1;
    timerhud = hud_util::createservertimer( "default", 1.5 );
    timerhud hud_util::setpoint( "CENTER", "CENTER", 0, -150 );
    collecttime = getdvarint( @"hash_a718bf7355e667a3", 180 );
    
    if ( collecttime > 0 )
    {
        setomnvar( "ui_hardpoint_timer", gettime() + int( collecttime * 1000 ) );
        timerhud settimer( collecttime );
        wait collecttime;
    }
    
    flags::gameflagset( "collect_done" );
    helipadwaittime = getdvarint( @"hash_9fd551b851144f28", 180 );
    
    if ( helipadwaittime > 0 )
    {
        missionhud.label = &"mp_br_ingame/extract_helipads_active";
        missionhud thread huddopulse();
        setomnvar( "ui_hardpoint_timer", gettime() + int( helipadwaittime * 1000 ) );
        timerhud settimer( helipadwaittime );
        wait helipadwaittime;
    }
    
    flags::gameflagset( "helipad_wait_done" );
    extracttime = getdvarint( @"hash_db683ed24a430594", 840 );
    missionhud.label = &"mp_br_ingame/extract_helipad";
    missionhud thread huddopulse();
    setomnvar( "ui_hardpoint_timer", gettime() + int( extracttime * 1000 ) );
    timerhud settimer( extracttime );
    var_cdf264f65c550524 = max( extracttime - var_da985de47c1f142a, 0 );
    wait var_cdf264f65c550524;
    timeleft = max( extracttime - var_cdf264f65c550524, 0 );
    timerhud.color = ( 1, 0, 0 );
    timerhud thread huddopulse();
    thread clocksounds( timeleft );
    wait timeleft;
    timerhud destroy();
    thread brendgame();
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x937640e8, Offset: 0x1b53
// Size: 0x10b
function clocksounds( timeleft )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( timeleft ) )
    {
        return;
    }
    
    while ( timeleft > 0 )
    {
        dosound = 0;
        clocksoundalias = gamelogic_mp::getclocksoundaliasfortimeleft( timeleft );
        
        if ( timeleft > 60 && timeleft % 10 == 0 || timeleft <= 60 && timeleft > 30 && timeleft % 2 == 0 || timeleft <= 30 )
        {
            dosound = 1;
        }
        
        if ( dosound )
        {
            foreach ( player in level.players )
            {
                player playlocalsound( clocksoundalias );
            }
        }
        
        timeleft -= 1;
        wait 1;
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x13ea124, Offset: 0x1c66
// Size: 0x12a
function setupextractnumhud()
{
    var_13587761df50378e = -120;
    var_6c648c52c67d1fdb = -170;
    var_81d6f167db0051a6 = 2;
    var_561e709ca7f19e05 = -2;
    level.brgametype.hudextractnum = createhudelem( &"mp_br_ingame/extract_num", 0, "RIGHT", "CENTER", var_13587761df50378e + var_561e709ca7f19e05, var_6c648c52c67d1fdb, ( 0, 1, 0 ) );
    level.brgametype.hudextractmax = createhudelem( &"mp_br_ingame/extract_max", level.brgametype.maxextractions, "LEFT", "CENTER", var_13587761df50378e + var_81d6f167db0051a6, var_6c648c52c67d1fdb, ( 0, 1, 0 ) );
    flags::gameflagwait( "helipad_wait_done" );
    level.brgametype.hudextractnum.alpha = 1;
    
    if ( level.brgametype.maxextractions > 0 )
    {
        level.brgametype.hudextractmax.alpha = 1;
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x49b34364, Offset: 0x1d98
// Size: 0x293
function setupteamplunderhud()
{
    var_6c648c52c67d1fdb = 145;
    var_6bb7a8e1043d2d6e = 20;
    var_81d6f167db0051a6 = -3;
    var_561e709ca7f19e05 = 3;
    cost = getcost();
    level.brgametype.hudcoststring = createhudelem( &"mp_br_ingame/extract_cost_text", undefined, "LEFT", "CENTER", var_561e709ca7f19e05, var_6c648c52c67d1fdb );
    level.brgametype.hudcost = createhudelem( &"mp_br_ingame/extract_cost", cost * 10, "LEFT", "CENTER", var_561e709ca7f19e05, var_6c648c52c67d1fdb + var_6bb7a8e1043d2d6e );
    level.brgametype.hudplunderstring = createhudelem( &"mp_br_ingame/extract_plunder_text", undefined, "RIGHT", "CENTER", var_81d6f167db0051a6, var_6c648c52c67d1fdb );
    
    foreach ( team in level.teamnamelist )
    {
        hudplunder = createhudelem( &"mp_br_ingame/extract_plunder", 0, "RIGHT", "CENTER", var_81d6f167db0051a6, var_6c648c52c67d1fdb + var_6bb7a8e1043d2d6e, ( 1, 0, 0 ), team );
        setteamplunderhud( team, hudplunder );
    }
    
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.br_infils_disabled )
    {
        level waittill( #"br_ready_to_jump" );
    }
    
    level.brgametype.hudcoststring.alpha = 1;
    level.brgametype.hudcost.alpha = 1;
    level.brgametype.hudplunderstring.alpha = 1;
    
    foreach ( team in level.teamnamelist )
    {
        hudplunder = getteamplunderhud( team );
        hudplunder.alpha = 1;
    }
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0x34c067f4, Offset: 0x2033
// Size: 0x44
function setteamplunderhud( team, hudelem )
{
    level.teamdata[ team ][ "hudPlunder" ] = hudelem;
    hudelem.plundercount = 0;
    hudelem.plundercountroll = 0;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xecbb4e43, Offset: 0x207f
// Size: 0x1e
function getteamplunderhud( team )
{
    return level.teamdata[ team ][ "hudPlunder" ];
}

// Namespace br_gametype_extraction
// Params 8
// Checksum 0x6f42aecb, Offset: 0x20a6
// Size: 0x195
function createhudelem( label, value, point, relativepoint, xoffset, yoffset, color, team )
{
    fontscale = 1.5;
    
    if ( isdefined( team ) )
    {
        fontelem = newteamhudelem( team );
    }
    else
    {
        fontelem = newhudelem();
    }
    
    fontelem.elemtype = "font";
    fontelem.font = "default";
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem.alpha = 0;
    fontelem hud_util::setpoint( point, relativepoint, xoffset, yoffset );
    
    if ( isdefined( label ) )
    {
        fontelem.label = label;
    }
    
    if ( isdefined( value ) )
    {
        fontelem setvalue( value );
    }
    
    if ( isdefined( color ) )
    {
        fontelem.color = color;
    }
    
    return fontelem;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x64aaff5c, Offset: 0x2244
// Size: 0xdc
function getteamplunder( team )
{
    plundercount = 0;
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        if ( isdefined( player.plundercount ) )
        {
            plundercount += player.plundercount;
        }
        
        if ( isdefined( player.plunderbanked ) )
        {
            plundercount += player.plunderbanked;
        }
    }
    
    return plundercount;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x7dc06345, Offset: 0x2329
// Size: 0x60
function playerpostsetplunder( data )
{
    plundercount = getteamplunder( self.team );
    hudplunder = getteamplunderhud( self.team );
    hudplunder.plundercount = plundercount;
    thread dohudplunderroll( hudplunder, self.team );
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0x81294f24, Offset: 0x2391
// Size: 0x317
function dohudplunderroll( hudplunder, team )
{
    hudplunder notify( #"hash_e56abc5072a2adda" );
    hudplunder endon( #"hash_e56abc5072a2adda" );
    const_pickup_time = 2;
    target = hudplunder.plundercount * 10;
    diff = target - hudplunder.plundercountroll;
    sign = utility::sign( diff );
    var_efbca750b1b21ec1 = diff / const_pickup_time;
    var_2a68ac03192b2c69 = int( var_efbca750b1b21ec1 * level.framedurationseconds );
    
    if ( var_2a68ac03192b2c69 == 0 )
    {
        return;
    }
    
    dohudplunderrollsound( sign, team );
    cost = getcost() * 10;
    wedidit = sign > 0 && hudplunder.plundercountroll > cost;
    teammates = level.teamdata[ team ][ "players" ];
    
    while ( hudplunder.plundercountroll != target )
    {
        if ( !wedidit && sign > 0 && hudplunder.plundercountroll + var_2a68ac03192b2c69 >= cost )
        {
            wedidit = 1;
            
            foreach ( player in teammates )
            {
                player playlocalsound( "br_plunder_atm_deposit_gtr" );
            }
            
            hudplunder.color = ( 0, 1, 0 );
            thread dohudplunderpulse( team );
        }
        
        if ( sign < 0 && hudplunder.plundercountroll < cost && hudplunder.color != ( 1, 0, 0 ) )
        {
            hudplunder.color = ( 1, 0, 0 );
        }
        
        hudplunder.plundercountroll += var_2a68ac03192b2c69;
        
        if ( sign > 0 && hudplunder.plundercountroll > target || sign < 0 && hudplunder.plundercountroll < target )
        {
            hudplunder.plundercountroll = target;
        }
        
        hudplunder setvalue( hudplunder.plundercountroll );
        wait level.framedurationseconds;
    }
    
    foreach ( player in teammates )
    {
        player.hudplunderstart = undefined;
        player stoplocalsound( "br_plunder_atm_use" );
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x5f3d1a96, Offset: 0x26b0
// Size: 0x10e
function updateteamplunderhud( team )
{
    hudplunder = getteamplunderhud( team );
    plundercount = getteamplunder( team );
    cost = getcost();
    
    if ( plundercount >= cost && hudplunder.color != ( 0, 1, 0 ) )
    {
        hudplunder.color = ( 0, 1, 0 );
        teammates = level.teamdata[ team ][ "players" ];
        
        foreach ( player in teammates )
        {
            player playlocalsound( "br_plunder_atm_deposit_gtr" );
        }
    }
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0xecabc1b6, Offset: 0x27c6
// Size: 0x115
function dohudplunderrollsound( sign, team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        if ( sign > 0 )
        {
            if ( isdefined( player.hudplunderstart ) )
            {
                duration = gettime() - player.hudplunderstart;
                
                if ( duration <= 6000 )
                {
                    break;
                }
            }
            
            player.hudplunderstart = gettime();
            
            if ( isalive( player ) )
            {
                player playlocalsound( "br_plunder_atm_use" );
            }
            
            continue;
        }
        
        player.hudplunderstart = undefined;
        player stoplocalsound( "br_plunder_atm_use" );
    }
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0x278b9247, Offset: 0x28e3
// Size: 0x75, Type: bool
function playerdropplunderondeath( dropstruct, attacker )
{
    var_a6085d27206e04f0 = int( self.plundercount * 0.5 );
    var_f8cbc86c55703cf4 = self.plundercount - var_a6085d27206e04f0;
    
    if ( var_f8cbc86c55703cf4 <= 0 )
    {
        var_f8cbc86c55703cf4 = 1;
    }
    
    self.plundercountondeath = var_a6085d27206e04f0;
    br_plunder::playersetplundercount( var_a6085d27206e04f0 );
    dropplunderbyrarity( var_f8cbc86c55703cf4, dropstruct );
    return true;
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0xf616a3f3, Offset: 0x2961
// Size: 0x232
function dropplunderbyrarity( amount, dropstruct )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    pickupents = [];
    numspawns = [];
    totalcount = 0;
    
    for ( i = level.br_plunder.quantity.size - 1; i >= 0 ; i-- )
    {
        numspawns[ i ] = int( amount / level.br_plunder.quantity[ i ] );
        totalcount += numspawns[ i ];
        
        if ( amount <= 0 )
        {
            break;
        }
        
        amount -= numspawns[ i ] * level.br_plunder.quantity[ i ];
    }
    
    for ( plunderindex = level.br_plunder.quantity.size - 1; plunderindex >= 0 ; plunderindex-- )
    {
        if ( !isdefined( numspawns[ plunderindex ] ) )
        {
            continue;
        }
        
        for ( itemindex = 0; itemindex < numspawns[ plunderindex ] ; itemindex++ )
        {
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( self.origin, self.angles );
            pickupent = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( level.br_plunder.names[ plunderindex ], level.br_plunder.quantity[ plunderindex ], spawnoptions );
            br_plunder::modify_plunder_itemsinworld( level.br_plunder.names[ plunderindex ], 1 );
            
            if ( isdefined( pickupent ) )
            {
                pickupents[ pickupents.size ] = pickupent;
                
                if ( br_plunder::inplunderlivelobby() )
                {
                    level.br_plunder_ents[ level.br_plunder_ents.size ] = pickupent;
                }
            }
        }
    }
    
    level.br_plunder.plunder_items_dropped += totalcount;
    level.br_plunder.plunder_value_dropped += amount;
    level thread br_plunder::dropplundersounds( self.origin, pickupents.size );
    return pickupents;
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x3aa132c5, Offset: 0x2b9c
// Size: 0x36f
function setupextractionsites()
{
    level.brgametype.sites = getextractionsites();
    
    foreach ( site in level.brgametype.sites )
    {
        site setscriptablepartstate( site.type, site.disabledstate );
    }
    
    flags::gameflagwait( "prematch_done" );
    level.brgametype.maxnumsites = getdvarint( @"hash_7785b8aaa2bc58f", 8 );
    level.brgametype.scalesitesbyteams = getdvarfloat( @"hash_50c01da1beb57ca3", 0.16 );
    
    if ( level.brgametype.scalesitesbyteams > 0 )
    {
        teamcount = teams::function_fc8bf4b0a548b5b4();
        level.brgametype.maxnumsites = int( ceil( level.brgametype.scalesitesbyteams * teamcount ) );
    }
    
    if ( level.brgametype.sites.size < level.brgametype.maxnumsites )
    {
        level.brgametype.maxnumsites = level.brgametype.sites.size;
    }
    else
    {
        level.brgametype.sites = sortbydistance( level.brgametype.sites, level.br_level.br_mapcenter );
    }
    
    for ( i = 0; i < level.brgametype.sites.size ; i++ )
    {
        site = level.brgametype.sites[ i ];
        
        if ( i >= level.brgametype.maxnumsites )
        {
            site setscriptablepartstate( site.type, "hidden" );
        }
    }
    
    flags::gameflagwait( "collect_done" );
    
    for ( i = 0; i < level.brgametype.sites.size ; i++ )
    {
        site = level.brgametype.sites[ i ];
        
        if ( i < level.brgametype.maxnumsites )
        {
            site setscriptablepartstate( site.type, site.visible2state );
        }
    }
    
    flags::gameflagwait( "helipad_wait_done" );
    
    for ( i = 0; i < level.brgametype.sites.size ; i++ )
    {
        site = level.brgametype.sites[ i ];
        
        if ( i < level.brgametype.maxnumsites )
        {
            site setscriptablepartstate( site.type, site.activestate );
        }
    }
    
    scriptable::scriptable_addusedcallback( &siteused );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x18448c64, Offset: 0x2f13
// Size: 0x1a7
function getextractionsites()
{
    sites01 = getentitylessscriptablearray( "plunder_extraction_01", #targetname );
    sites02 = getentitylessscriptablearray( "plunder_extraction_02", #targetname );
    
    if ( sites01.size > 0 || sites02.size > 0 )
    {
        sites = arraycombine( sites01, sites02 );
        
        foreach ( site in sites )
        {
            site.activestate = "active2";
            site.disabledstate = "visible";
            site.visible2state = "visible2";
        }
        
        return sites;
    }
    
    sites = getentitylessscriptablearray( "plunder_extraction", #targetname );
    
    foreach ( site in sites )
    {
        site.activestate = "visible";
        site.disabledstate = "hidden";
        site.visible2state = "visible";
    }
    
    return sites;
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x62ee7e07, Offset: 0x30c2
// Size: 0x7e
function getcost()
{
    cost = getdvarint( @"scr_br_extract_cost", 300 );
    mincost = getdvarint( @"hash_2c2d8ae182cf1fc", 40 );
    decrease = getdvarint( @"hash_27a4ecc9aa9f8224", 20 );
    
    if ( mincost > 0 )
    {
        cost = int( max( mincost, cost - level.brgametype.numextractions * decrease ) );
    }
    
    return cost;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xde90274f, Offset: 0x3149
// Size: 0x66
function playertakeextractionplunder( amount )
{
    if ( self.plundercount < amount )
    {
        amount = self.plundercount;
    }
    
    if ( !isdefined( self.plunderforextract ) )
    {
        self.plunderforextract = 0;
    }
    
    self.plunderforextract += amount;
    br_plunder::playersetplundercount( self.plundercount - amount );
    return amount;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xe052e64e, Offset: 0x31b8
// Size: 0x9e
function teamclearextractplunder( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        player.plunderforextract = 0;
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x366e0403, Offset: 0x325e
// Size: 0xb9
function teamrefundplunder( team )
{
    teammates = level.teamdata[ team ][ "players" ];
    
    foreach ( player in teammates )
    {
        if ( isdefined( player.plunderforextract ) )
        {
            player.plunderforextract = 0;
            player iprintlnbold( "Extraction refunded, chopper shot down." );
        }
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xd34fdcf, Offset: 0x331f
// Size: 0x169
function taketeamplunder( team )
{
    cost = getcost();
    alivecount = level.teamdata[ team ][ "aliveCount" ];
    costperplayer = int( cost / alivecount );
    teammates = level.teamdata[ team ][ "alivePlayers" ];
    
    foreach ( player in teammates )
    {
        amount = player playertakeextractionplunder( costperplayer );
        cost -= amount;
    }
    
    if ( cost > 0 )
    {
        foreach ( player in teammates )
        {
            amount = player playertakeextractionplunder( cost );
            cost -= amount;
            
            if ( cost <= 0 )
            {
                break;
            }
        }
    }
}

// Namespace br_gametype_extraction
// Params 6
// Checksum 0x5994a3c4, Offset: 0x3490
// Size: 0x1a4
function siteused( instance, part, state, player, bautouse, usestring )
{
    if ( !( isdefined( instance ) && isdefined( player ) ) )
    {
        return;
    }
    
    if ( part == "brloot_plunder_extraction_site_01" || part == "brloot_plunder_extraction_site_02" || part == "brloot_plunder_extraction_site" )
    {
        count = getteamplunder( player.team );
        cost = getcost();
        
        if ( count < cost )
        {
            thread dohudplunderpulse( player.team );
            player playlocalsound( "fly_pickup_deny" );
            
            /#
                player iprintlnbold( "<dev string:x24>" + cost * 10 );
            #/
            
            return;
        }
        
        taketeamplunder( player.team );
        teammates = level.teamdata[ player.team ][ "players" ];
        
        foreach ( player in teammates )
        {
            player playlocalsound( "br_plunder_atm_deposit_gtr" );
        }
        
        if ( part == "brloot_plunder_extraction_site_01" || part == "brloot_plunder_extraction_site_02" || part == "brloot_plunder_extraction_site" )
        {
            thread siteusedinternal( instance, part, state, player );
        }
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x6c5569c, Offset: 0x363c
// Size: 0x29
function dohudplunderpulse( team )
{
    hudplunder = getteamplunderhud( team );
    hudplunder huddopulse();
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x1c8484af, Offset: 0x366d
// Size: 0x89
function huddopulse()
{
    self endon( #"death" );
    
    if ( self.pulsing )
    {
        return;
    }
    
    var_f97916dc25067a9 = 0.5;
    var_9b2390f9f47109f2 = 4;
    self.pulsing = 1;
    originalscale = self.fontscale;
    self changefontscaleovertime( var_f97916dc25067a9 );
    self.fontscale = var_9b2390f9f47109f2;
    wait var_f97916dc25067a9;
    self changefontscaleovertime( var_f97916dc25067a9 );
    self.fontscale = originalscale;
    self.pulsing = undefined;
}

// Namespace br_gametype_extraction
// Params 4
// Checksum 0x9a4c76ca, Offset: 0x36fe
// Size: 0x74
function siteusedinternal( instance, part, state, player )
{
    instance setscriptablepartstate( instance.type, "inuse2" );
    groundorg = getgroundposition( instance.origin, 1 ) + ( 0, 0, 2 );
    thread doextractionevent( instance, player, groundorg );
}

// Namespace br_gametype_extraction
// Params 3
// Checksum 0xd5b907a7, Offset: 0x377a
// Size: 0x14b
function doextractionevent( instance, player, groundorg )
{
    heli = player playerspawnextractchopper( groundorg );
    
    if ( isdefined( heli ) )
    {
        spawndata = spawnstruct();
        spawndata.origin = groundorg;
        spawndata.angles = heli.angles;
        spawndata.spawntype = "GAME_MODE";
        faildata = spawnstruct();
        helidrivable = vehicle::spawn( "little_bird", spawndata, faildata );
        
        if ( isdefined( helidrivable ) )
        {
            heli.site = instance;
            heli.helidrivable = helidrivable;
            helidrivable hide();
            heli helicreateextractvfx( groundorg );
            thread extractplunder( heli );
            level thread br_public::brleaderdialogteam( "plunder_extract_requested", player.team, 1 );
            level thread br_public::brbroadcastplayercardsplash( "br_gametype_extract_heli_incoming" );
            return;
        }
    }
    
    player playerdenyextraction( undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
    
    if ( isdefined( instance ) )
    {
        instance setscriptablepartstate( instance.type, instance.activestate );
    }
    
    waitframe();
    
    if ( isdefined( heli ) )
    {
        heli delete();
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x18dbc497, Offset: 0x38cd
// Size: 0xb0
function heliextract_used( grenade )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    weaponobject = grenade.weapon_object;
    grenade waittill( #"explode", position );
    
    if ( !vehicle_tracking::can_spawn_vehicle() )
    {
        playerdenyextraction( weaponobject, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        return;
    }
    
    heli = playerspawnextractchopper( position );
    
    if ( isdefined( heli ) )
    {
        heli helicreateextractvfx( position );
        thread extractplunder( heli );
        return;
    }
    
    playerdenyextraction( weaponobject, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0xe337f7d5, Offset: 0x3985
// Size: 0x4e
function playerdenyextraction( weaponobject, localizedstring )
{
    self iprintlnbold( localizedstring );
    self playlocalsound( "fly_pickup_deny" );
    
    if ( isdefined( weaponobject ) )
    {
        ammo = self getweaponammoclip( weaponobject );
        self setweaponammoclip( weaponobject, ammo + 1 );
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x5c568b46, Offset: 0x39db
// Size: 0xc2
function playerspawnextractchopper( position )
{
    extractpos = position;
    heightent = getent( "airstrikeheight", #targetname );
    planeflyheight = heightent.origin[ 2 ] - 300;
    descendpoint = ( extractpos[ 0 ], extractpos[ 1 ], planeflyheight );
    angles = ( 0, randomfloat( 360 ), 0 );
    enterposition = descendpoint + -1 * anglestoforward( angles ) * 30000;
    exitposition = descendpoint + anglestoforward( angles ) * 30000;
    heli = spawnheli( self, enterposition, descendpoint, exitposition );
    return heli;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x88f187c2, Offset: 0x3aa6
// Size: 0x115
function drophelicrate( heli )
{
    crate = spawn( "script_model", heli.origin );
    crate setmodel( "military_skyhook_backpack" );
    startorg = heli.origin;
    end = ( startorg[ 0 ], startorg[ 1 ], -12000 );
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trace = trace::ray_trace( startorg, end, heli, contents );
    groundorg = trace[ "position" ];
    dist = startorg[ 2 ] - groundorg[ 2 ];
    
    if ( dist > 0 )
    {
        time = sqrt( 2 * dist / 800 );
        crate moveto( groundorg, time, time, 0 );
        wait time;
    }
    
    crate.origin = groundorg;
    playfx( utility::getfx( "airdrop_crate_impact_ground" ), groundorg );
    crate cratedropplunder();
    crate delete();
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xa2ddd23a, Offset: 0x3bc3
// Size: 0x2e
function cratedropplunder()
{
    amount = getcost();
    dropstruct = pickups::function_f71dd588dc4f6288();
    br_plunder::dropplunderbyrarity( amount, dropstruct );
}

// Namespace br_gametype_extraction
// Params 3
// Checksum 0xdc6efb89, Offset: 0x3bf9
// Size: 0x9a
function calculatehelitimetoflysec( distinches, speedmph, accelmph )
{
    distmiles = distinches * 1.57828e-05;
    a = 0.5 * accelmph;
    b = speedmph;
    c = -1 * distmiles;
    flytime = ( -1 * b + sqrt( b * b - 4 * a * c ) ) / 2 * a;
    flytime *= 3600;
    flytime += 1.5;
    return flytime;
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x919d7f4c, Offset: 0x3c9c
// Size: 0x51
function calculatehelitimetoarrive( var_f4feabcd5c9f80b8 )
{
    arrivetime = calculatehelitimetoflysec( 30000, 100, 125 );
    descendtime = calculatehelitimetoflysec( var_f4feabcd5c9f80b8, 25, 31.25 );
    totaltime = arrivetime + descendtime;
    return totaltime;
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0x8672e7f3, Offset: 0x3cf6
// Size: 0xd6
function helisetteamextractionhud( state, timesec )
{
    endtimems = gettime() + int( timesec * 1000 );
    teamplayers = level.teamdata[ self.team ][ "alivePlayers" ];
    
    foreach ( player in teamplayers )
    {
        player setclientomnvar( "ui_br_plunder_extract_state", state );
        player setclientomnvar( "ui_br_timed_feature_end_time", endtimems );
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x6fb1267b, Offset: 0x3dd4
// Size: 0x120
function extractplunder( heli )
{
    heli endon( #"death" );
    heli endon( #"leaving" );
    heli setvehgoalpos( heli.pathgoal, 1 );
    heli settargetyaw( heli.goalyaw );
    groundz = heli tracegroundheight( heli.pathgoal );
    var_f4feabcd5c9f80b8 = heli.pathgoal[ 2 ] - groundz;
    heli.flytime = calculatehelitimetoarrive( var_f4feabcd5c9f80b8 );
    heli helisetteamextractionhud( 1, heli.flytime );
    heli waittill( #"goal" );
    heli thread heliwatchgameendleave();
    heli thread helidisapateextractvfx();
    heli helidescend( heli.endpoint, groundz );
    level thread br_public::brbroadcastplayercardsplash( "br_gametype_extract_heli_arrived" );
    level thread br_public::brleaderdialogteam( "plunder_extract_chopper_arrive", heli.team, 1 );
    heli helicleanupextract( 0 );
    thread swaphelifordrivable( heli );
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x4435ce34, Offset: 0x3efc
// Size: 0xc2
function swaphelifordrivable( heli )
{
    team = heli.team;
    site = heli.site;
    teamclearextractplunder( team );
    heli notify( #"hash_2bd8cc170f6cf82b" );
    helidrivable = heli.helidrivable;
    helidrivable.origin = heli.origin;
    helidrivable.angles = heli.angles;
    helidrivable show();
    heli delete();
    
    if ( isdefined( site ) )
    {
        helidrivable thread helidrivableenablesiteonflyaway( site );
        helidrivable thread helidrivableenablesiteondeath( site );
    }
    
    helidrivable thread helidrivablethink();
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x527bb4b6, Offset: 0x3fc6
// Size: 0xa1
function helidrivableenablesiteonflyaway( site )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    site endon( #"siteenabled" );
    var_8c28d81fc2f9956 = 90000;
    
    while ( true )
    {
        distsq = distance2dsquared( self.origin, site.origin );
        
        if ( distsq > var_8c28d81fc2f9956 )
        {
            break;
        }
        
        waitframe();
    }
    
    site setscriptablepartstate( site.type, site.activestate );
    site notify( #"siteenabled" );
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x5c2e28f6, Offset: 0x406f
// Size: 0x4f
function helidrivableenablesiteondeath( site )
{
    level endon( #"game_ended" );
    site endon( #"siteenabled" );
    self waittill( #"death" );
    site setscriptablepartstate( site.type, site.activestate );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xa97d3f6e, Offset: 0x40c6
// Size: 0x135
function helimakedepotwait()
{
    self.isdepot = 1;
    self.usable = self.crate;
    usable = self.usable;
    usable makeusable();
    usable setcursorhint( "HINT_NOICON" );
    usable setuseholdduration( "duration_medium" );
    usable setuserange( 230 );
    usable sethintstring( &"mp/br_use_plunder_cache" );
    depotindex = level.br_depots.size;
    level.br_depots[ depotindex ] = usable;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
        }
    }
    
    thread helicleanupdepotonleaving();
    thread helidepotthink( usable );
    helisetteamextractionhud( 2, 30 );
    wait 30;
    self.isdepot = 0;
    heliusecleanup();
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x40d65e59, Offset: 0x4203
// Size: 0x5c
function helidepotthink( usable )
{
    self endon( #"death" );
    usable endon( #"death" );
    
    while ( true )
    {
        usable waittill( #"trigger", player );
        player playlocalsound( "br_plunder_atm_deposit_gtr" );
        helistoreplunder( player );
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xcd0e4b8b, Offset: 0x4267
// Size: 0x161
function helistoreplunder( player )
{
    if ( !isdefined( self.plunder ) )
    {
        self.plunder = [];
    }
    
    plundercount = player.plundercount;
    player br_analytics::branalytics_plunder_placed_into_extraction( player, "little_bird", self.origin, plundercount );
    appended = 0;
    
    if ( isdefined( self.plunder ) )
    {
        foreach ( plunderstruct in self.plunder )
        {
            if ( plunderstruct.player == player )
            {
                plunderstruct.plundercount += plundercount;
                appended = 1;
                break;
            }
        }
    }
    
    if ( !appended )
    {
        plunderstruct = spawnstruct();
        plunderstruct.player = player;
        plunderstruct.team = player.team;
        plunderstruct.plundercount = plundercount;
        self.plunder[ self.plunder.size ] = plunderstruct;
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xe4fe82b, Offset: 0x43d0
// Size: 0x146
function helibankplunder()
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    level thread br_public::brleaderdialogteam( "plunder_extract_success", self.team, 1 );
    plundersum = 0;
    contains_enemy_plunder = 0;
    
    foreach ( item in self.plunder )
    {
        plundersum += item.plundercount;
        
        if ( item.player.team != self.team )
        {
            contains_enemy_plunder = 1;
        }
    }
    
    br_analytics::branalytics_plunder_extraction_success( self.plunder.size, plundersum, "little_bird", contains_enemy_plunder, self.endpoint );
    level.br_plunder.extraction_helicoptor_total_plunder += plundersum;
    level.br_plunder.extraction_helicoptor_num_completed++;
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x7a676be2, Offset: 0x451e
// Size: 0x38
function heliusecleanup()
{
    if ( isdefined( self.usable ) )
    {
        level.br_depots = arrayremove( level.br_depots, self.usable );
        self.usable = undefined;
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x93e516a0, Offset: 0x455e
// Size: 0x38
function helicleanupdepotonleaving( usable )
{
    self.usable endon( #"death" );
    utility::waittill_any( "leaving", "death" );
    heliusecleanup();
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x6f55700c, Offset: 0x459e
// Size: 0x7f
function helicreateextractvfx( position )
{
    self.vfxent = spawn( "script_model", position );
    self.vfxent setmodel( "scr_smoke_grenade" );
    self.vfxent.angles = ( 0, 90, 90 );
    self.vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    self.vfxent setscriptablepartstate( "smoke", "on" );
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x1975db6e, Offset: 0x4625
// Size: 0x7c
function helicleanupextract( enablesite )
{
    if ( isdefined( self.vfxent ) )
    {
        self.vfxent stoploopsound();
        self.vfxent delete();
    }
    
    if ( enablesite && isdefined( self.site ) )
    {
        self.site setscriptablepartstate( self.site.type, self.site.activestate );
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x747ed13f, Offset: 0x46a9
// Size: 0x84
function helidisapateextractvfx()
{
    self endon( #"death" );
    
    if ( !isdefined( self.vfxent ) )
    {
        return;
    }
    
    wait 5;
    self.vfxent endon( #"death" );
    self.vfxent setscriptablepartstate( "smoke", "dissipate" );
    self.vfxent playsound( "smoke_canister_tail_dissipate" );
    wait 1;
    self.vfxent stoploopsound();
    wait 4.5;
    self.vfxent delete();
}

// Namespace br_gametype_extraction
// Params 4
// Checksum 0x3760bacd, Offset: 0x4735
// Size: 0x1f6
function spawnheli( owner, pathstart, pathgoal, pathexit )
{
    angles = vectortoangles( pathgoal - pathstart );
    const_num_flares = 1;
    heli = vehicle_tracking::spawn_helicopter( owner, pathstart, angles, "veh_apache_plunder_mp", "veh8_mil_air_lbravo_personnel_mp_flyable" );
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    endpoint = pathgoal * ( 1, 1, 0 );
    heli.damagecallback = &callback_vehicledamage;
    heli.speed = 100;
    heli.accel = 125;
    heli.health = 1000;
    heli.maxhealth = heli.health;
    heli.team = owner.team;
    heli.owner = owner;
    heli.defendloc = pathgoal;
    heli.lifeid = 0;
    heli.flaresreservecount = const_num_flares;
    heli.pathgoal = pathgoal;
    heli.pathexit = pathexit;
    heli.endpoint = endpoint;
    heli.goalyaw = angles[ 1 ];
    heli.vehiclename = "magma_plunder_chopper";
    heli setcandamage( 1 );
    heli setmaxpitchroll( 10, 25 );
    heli vehicle_setspeed( heli.speed, heli.accel );
    heli sethoverparams( 50, 100, 50 );
    heli setturningability( 0.05 );
    heli setyawspeed( 45, 25, 25, 0.5 );
    heli setotherent( owner );
    heli thread flares::flares_handleincomingstinger( undefined, undefined );
    heli thread handledestroydamage();
    heli thread helidestroyed();
    return heli;
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x526569af, Offset: 0x4934
// Size: 0xbf
function helidestroyed()
{
    self endon( #"heli_gone" );
    self endon( #"hash_2bd8cc170f6cf82b" );
    team = self.team;
    self waittill( #"death", attacker, meansofdeath, weaponobject, damagelocation );
    teamrefundplunder( team );
    helicleanup();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.largeprojectiledamage ) && !self.isdepot )
    {
        self vehicle_setspeed( 25, 5 );
        thread helicrash( 75 );
        hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    heliexplode( attacker );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x94558bbd, Offset: 0x49fb
// Size: 0x38
function helicleanup()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        self.crate delete();
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xcdfd6c32, Offset: 0x4a3b
// Size: 0xf7
function heliexplode( attacker )
{
    explosionposition = self gettagorigin( "tag_origin" ) + ( 0, 0, 40 );
    self radiusdamage( explosionposition, 256, 140, 70, attacker, "MOD_EXPLOSIVE" );
    playfx( utility::getfx( "little_bird_explode" ), explosionposition, anglestoforward( self.angles ), anglestoup( self.angles ) );
    playsoundatpos( explosionposition, "veh_chopper_support_crash" );
    earthquake( 0.4, 800, explosionposition, 0.7 );
    playrumbleonposition( "grenade_rumble", explosionposition );
    physicsexplosionsphere( explosionposition, 500, 200, 1 );
    self notify( #"explode" );
    wait 0.35;
    level thread br::teamsplashbr( "br_gametype_extract_heli_shot_down", self.owner, self.owner.team );
    helicleanupextract( 1 );
    helidelete();
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x202648ab, Offset: 0x4b3a
// Size: 0xa
function helidelete()
{
    vehicle_tracking::delete_vehicle( self );
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0xa9d99c6c, Offset: 0x4b4c
// Size: 0x74
function helicrash( speed )
{
    self endon( #"explode" );
    self notify( #"heli_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( speed, speed, speed );
    self settargetyaw( self.angles[ 1 ] + speed * 2.5 );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x69da2b, Offset: 0x4bc8
// Size: 0x13b
function handledestroydamage()
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"hash_2bd8cc170f6cf82b" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        objweapon = weapon::mapweapon( objweapon, inflictor );
        
        if ( ( objweapon.basename == "aamissile_projectile_mp" || objweapon.basename == "nuke_mp" ) && meansofdeath == "MOD_EXPLOSIVE" && damage >= self.health )
        {
            callback_vehicledamage( attacker, attacker, 9001, 0, meansofdeath, objweapon, point, direction_vec, point, 0, 0, partname );
            helicleanupextract( 1 );
        }
    }
}

// Namespace br_gametype_extraction
// Params 13
// Checksum 0x8726ee9e, Offset: 0x4d0b
// Size: 0x190
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
    
    if ( ( attacker == self || isdefined( attacker.pers ) && attacker.pers[ "team" ] == self.team && !level.friendlyfire && level.teambased ) && attacker != self.owner )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    damage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5 );
    killstreaks::killstreakhit( attacker, objweapon, self, meansofdeath, damage );
    attacker damagefeedback::updatedamagefeedback( "" );
    
    if ( self.health - damage <= 900 && !self.smoking )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, #"tag_origin", partname );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x53bb44af, Offset: 0x4ea3
// Size: 0xd2
function helileave()
{
    self endon( #"death" );
    self notify( #"leaving" );
    self.leaving = 1;
    self setvehgoalpos( self.pathgoal, 1 );
    self settargetyaw( self.goalyaw );
    helisetteamextractionhud( 3, self.flytime );
    self waittill( #"goal" );
    self vehicle_setspeed( self.speed, self.accel );
    self setvehgoalpos( self.pathexit, 1 );
    self settargetyaw( self.goalyaw );
    self waittill( #"goal" );
    self stoploopsound();
    helibankplunder();
    helisetteamextractionhud( 0, 0 );
    self notify( #"heli_gone" );
    helidelete();
}

// Namespace br_gametype_extraction
// Params 2
// Checksum 0xf503cc26, Offset: 0x4f7d
// Size: 0xaa
function helidescend( location, groundz )
{
    self endon( #"death" );
    locationx = location[ 0 ];
    locationy = location[ 1 ];
    newpos = ( locationx, locationy, groundz );
    self setvehgoalpos( newpos, 1 );
    self settargetyaw( self.goalyaw );
    self vehicle_setspeed( 25, 31.25 );
    thread helidestroyvehiclestouchnotify();
    thread helidestroyvehiclestouchtrace();
    self waittill( #"goal" );
    self sethoverparams( 1, 1 );
    wait 1;
    self sethoverparams( 25, 20, 10 );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xc512158d, Offset: 0x502f
// Size: 0x24, Type: bool
function entisalivevehicle()
{
    return isalive( self ) && ( vehicle::is_vehicle() || self.classname == "script_vehicle" );
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0x994d4f, Offset: 0x505c
// Size: 0x70
function helidestroyvehiclestouchnotify()
{
    self endon( #"leaving" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"touch", vehicle );
        
        if ( isdefined( vehicle ) && vehicle entisalivevehicle() )
        {
            vehicle dodamage( vehicle.health, self.origin, vehicle, vehicle, "MOD_CRUSH" );
        }
    }
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xf6ef8339, Offset: 0x50d4
// Size: 0x29a
function helidestroyvehiclestouchtrace()
{
    self endon( #"leaving" );
    self endon( #"death" );
    radius = 70;
    offsetdown = -80;
    forward = 150;
    middle = 25;
    back = -100;
    
    while ( true )
    {
        vehicles = getentarrayinradius( "script_vehicle", #classname, self.origin, getdvarfloat( @"test_radius", 400 ) );
        
        if ( vehicles.size <= 1 )
        {
            wait 0.5;
            continue;
        }
        
        vehiclecontents = trace::create_vehicle_contents();
        dir = anglestoforward( self.angles );
        origin = self.origin + dir * getdvarfloat( @"test_f", forward ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        origin = self.origin + dir * getdvarfloat( @"test_m", middle ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        origin = self.origin + dir * getdvarfloat( @"test_b", back ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        waitframe();
    }
}

// Namespace br_gametype_extraction
// Params 1
// Checksum 0x49dba99, Offset: 0x5376
// Size: 0x52
function tracegroundheight( start )
{
    offgroundheight = 125;
    groundpt = tracegroundpoint( start, 100, [ self ] );
    groundheight = groundpt[ 2 ];
    trueheight = groundheight + offgroundheight;
    return trueheight;
}

// Namespace br_gametype_extraction
// Params 3
// Checksum 0x75ee90bf, Offset: 0x53d1
// Size: 0x8b
function tracegroundpoint( start, radius, ignorelist )
{
    var_aa0d98a844610c90 = -99999;
    end = ( start[ 0 ], start[ 1 ], var_aa0d98a844610c90 );
    contents = trace::create_world_contents();
    trc = undefined;
    
    if ( isdefined( radius ) )
    {
        trc = trace::sphere_trace( start, end, radius, ignorelist, contents );
    }
    else
    {
        trc = trace::ray_trace( start, end, ignorelist, contents );
    }
    
    return trc[ "position" ];
}

// Namespace br_gametype_extraction
// Params 0
// Checksum 0xdeb37c7b, Offset: 0x5465
// Size: 0x2e
function heliwatchgameendleave()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level waittill( #"game_ended" );
    thread helileave();
}

/#

    // Namespace br_gametype_extraction
    // Params 0
    // Checksum 0x13da2730, Offset: 0x549b
    // Size: 0xc8, Type: dev
    function devthink()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_6980dad26c70f47b", 0 ) != 0 )
            {
                host = gamelogic_mp::gethostplayer();
                
                if ( isdefined( host ) )
                {
                    teamextractedvictory( host.team );
                }
                
                setdvar( @"hash_6980dad26c70f47b", 0 );
            }
            
            if ( getdvarint( @"extract_victory", 0 ) != 0 )
            {
                doteamextractedupdate();
                setdvar( @"extract_victory", 0 );
            }
            
            if ( getdvarint( @"extract_heli", 0 ) != 0 )
            {
                host = gamelogic_mp::gethostplayer();
                
                if ( isdefined( host ) )
                {
                    thread doextractionevent( undefined, host, host.origin );
                }
                
                setdvar( @"extract_heli", 0 );
            }
            
            waitframe();
        }
    }

#/
