// scripts\mp\br\gametypes\br_gametype_evac.gsc  (hash_296a7a4a1b265e9e.gscc) (size: 17167 Bytes / 0x430f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a70a541 (980460865)
// size ...... 17167 (0x430f)
// includes .. 20  (offset: 0x3fd3)
// strings ... 50  (offset: 0x4073)
// dev strs .. 0   (offset: 0x430f)
// exports ... 44  (offset: 0x2847)
// cseg ...... 0x450 + 0x23f7 (0x2847)
// imports ... 141 (offset: 0x2f27)
// animtree1 . 0   (offset: 0x430f)
// animtree2 . 0   (offset: 0x430f)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\common\killstreaks\flares;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace br_gametype_evac;

// Namespace br_gametype_evac
// Params 0, eflags: 0x1
// Checksum 0xb0f23d9b, Offset: 0x46e
// Size: 0x1a
function autoexec main()
{
    if ( !game_utility::getgametype() != "evac" )
    {
        return;
    }
    
    init();
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0xdc95e768, Offset: 0x490
// Size: 0x78
function init()
{
    br_gametypes::enablefeature( #"circlesnaptonavmesh" );
    utility::registersharedfunc( #"gametype", #"circletimer", &circletimer );
    utility::registersharedfunc( #"gametype", #"playerwelcomesplashes", &playerwelcomesplashes );
    level.brgametype.firstteam = "tie";
    thread initpostmain();
    
    /#
        thread devthink();
    #/
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0xfb18fcb3, Offset: 0x510
// Size: 0xa
function initpostmain()
{
    waittillframeend();
    thread setupmission();
}

// Namespace br_gametype_evac
// Params 1
// Checksum 0xd1ed61bb, Offset: 0x522
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
    hud_message::showsplash( "br_gametype_evac_welcome" );
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0xefcfe354, Offset: 0x5a4
// Size: 0xc1
function setupmission()
{
    flags::gameflagwait( "prematch_done" );
    level.brgametype.helicircleindex = getdvarint( @"hash_9f7241c3802e23e7", 5 );
    level.brgametype.heliextractarrivewait = getdvarint( @"hash_d18fd2563ac77406", 120 );
    level.brgametype.heliextractwait = getdvarint( @"hash_25ba23925bf6103c", 120 );
    level.brgametype.timertexthud = createhudelem( &"mp_br_ingame/evac_start", level.brgametype.helicircleindex, "CENTER", "CENTER", 0, -180 );
    thread setuphelilandingposition();
}

// Namespace br_gametype_evac
// Params 1
// Checksum 0xf7efce26, Offset: 0x66d
// Size: 0x478
function setuphelilandingposition( overridept )
{
    /#
        if ( isdefined( overridept ) )
        {
            level.br_level.br_circlecenters[ level.brgametype.helicircleindex ] = overridept;
        }
    #/
    
    const_z_tolerance = 20;
    const_offset = 300;
    var_c821cba0d29c10b7 = 1;
    var_c04778a54966e9e3 = 3;
    var_e640a967d0971534 = 0;
    heightent = getent( "airstrikeheight", #targetname );
    center = level.br_level.br_circlecenters[ level.brgametype.helicircleindex ];
    radius = level.br_level.br_circleradii[ level.brgametype.helicircleindex ];
    position = center;
    const_radius_sq = radius * radius;
    var_39a9a053c993d90a = radius - 150;
    var_6f5ed48d3dfe701f = var_39a9a053c993d90a * var_39a9a053c993d90a;
    lowesttolerance = -1;
    lowestdistsq = -1;
    lowestdiff = -1;
    bestpoint = center;
    currentoffset = 0;
    currentdist = 0;
    currentx = 0;
    currenty = 0;
    offset = ( 0, 0, 0 );
    
    /#
        level.brgametype.numtraces = 0;
    #/
    
    numtraces = 0;
    
    while ( currentdist < var_39a9a053c993d90a )
    {
        position += offset;
        start = ( position[ 0 ], position[ 1 ], heightent.origin[ 2 ] );
        var_a8f283146793de87 = distance2dsquared( start, center );
        
        if ( var_a8f283146793de87 < var_6f5ed48d3dfe701f )
        {
            numtraces++;
            groundpt = tracegroundpoint( start, 150 );
            navpt = getclosestpointonnavmesh( groundpt );
            diff = abs( groundpt[ 2 ] - navpt[ 2 ] );
            dist2dsq = distance2dsquared( groundpt, navpt );
            
            /#
                level.brgametype.numtraces++;
            #/
            
            if ( dist2dsq < var_c821cba0d29c10b7 && diff <= const_z_tolerance && !var_e640a967d0971534 )
            {
                level.brgametype.helilandingorigin = groundpt;
                
                /#
                    level.brgametype.var_9927ccac1f1f3580 = 1;
                    level.brgametype.lowesttolerance = lowesttolerance;
                    level.brgametype.lowestdistsq = lowestdistsq;
                    level.brgametype.lowestdiff = lowestdiff;
                    level.brgametype.bestpoint = bestpoint;
                #/
                
                return;
            }
            else
            {
                weight = dist2dsq * diff;
                
                if ( lowesttolerance == -1 || lowesttolerance > 0 && weight < lowesttolerance || lowesttolerance == 0 && diff < lowestdiff )
                {
                    lowesttolerance = weight;
                    bestpoint = groundpt;
                    lowestdistsq = dist2dsq;
                    lowestdiff = diff;
                }
                
                /#
                    thread function_aa439f70201be98c( groundpt, navpt, center, radius, position + offset == center );
                #/
            }
        }
        
        if ( currentoffset == 0 )
        {
            currentoffset++;
            currentx++;
        }
        else if ( currenty == currentoffset )
        {
            currentoffset++;
            currentx = 1;
            currenty = 1;
            sign = currentoffset % 2 ? -1 : 1;
            offset = ( sign * const_offset, 0, 0 );
        }
        else if ( currentx == currentoffset )
        {
            currenty++;
            sign = currentoffset % 2 ? -1 : 1;
            offset = ( 0, sign * const_offset, 0 );
        }
        else
        {
            currentx++;
        }
        
        if ( currentoffset % 2 == 1 )
        {
            currentdist = ( currentoffset + 1 ) / 2 * const_offset;
        }
        
        if ( numtraces >= var_c04778a54966e9e3 )
        {
            numtraces = 0;
            waitframe();
        }
    }
    
    /#
        level.brgametype.var_9927ccac1f1f3580 = 0;
        level.brgametype.lowesttolerance = lowesttolerance;
        level.brgametype.lowestdistsq = lowestdistsq;
        level.brgametype.lowestdiff = lowestdiff;
    #/
    
    level.brgametype.helilandingorigin = bestpoint;
}

/#

    // Namespace br_gametype_evac
    // Params 5
    // Checksum 0x5d2d50e7, Offset: 0xaed
    // Size: 0x260, Type: dev
    function function_aa439f70201be98c( groundpt, navpt, center, radius, first )
    {
        if ( getdvarint( @"hash_7922ee604dec1c99", 0 ) != 0 )
        {
            level.brgametype notify( #"hash_8b8168740ace202d" );
            level.brgametype endon( #"hash_8b8168740ace202d" );
            
            if ( first )
            {
                level.brgametype.var_cc4e22d7f9b84b0b = [];
                level.brgametype.var_642f78be7e1a091d = [];
            }
            
            level.brgametype.var_cc4e22d7f9b84b0b[ level.brgametype.var_cc4e22d7f9b84b0b.size ] = groundpt;
            level.brgametype.var_642f78be7e1a091d[ level.brgametype.var_642f78be7e1a091d.size ] = navpt;
            
            while ( getdvarint( @"hash_7922ee604dec1c99", 0 ) != 0 )
            {
                utility::draw_circle( center, radius, ( 1, 1, 0 ), 1, 0, 1 );
                
                foreach ( index, pt in level.brgametype.var_cc4e22d7f9b84b0b )
                {
                    utility::draw_circle( pt, 150, ( 1, 0, 0 ), 1, 0, 1 );
                    print3d( pt, string( index ) );
                }
                
                foreach ( pt in level.brgametype.var_642f78be7e1a091d )
                {
                    utility::draw_circle( pt, 10, ( 1, 1, 0 ), 1, 0, 1 );
                }
                
                waitframe();
            }
        }
    }

#/

// Namespace br_gametype_evac
// Params 1
// Checksum 0xbbb03bef, Offset: 0xd55
// Size: 0x4b, Type: bool
function circletimer( circleindex )
{
    if ( circleindex < level.brgametype.helicircleindex )
    {
        return false;
    }
    
    if ( circleindex == level.brgametype.helicircleindex )
    {
        runheliextraction( circleindex );
    }
    
    return true;
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0x8e9953af, Offset: 0xda9
// Size: 0x91
function setupmissionwidget()
{
    startindex = br_contract_manager::getquesttableindex( "gt_evac" );
    
    foreach ( player in level.players )
    {
        player br_contract_manager::setquestindexomnvar( startindex );
    }
}

// Namespace br_gametype_evac
// Params 2
// Checksum 0x9d624e38, Offset: 0xe42
// Size: 0x168
function teamextractedvictory( team, heli )
{
    level endon( #"game_ended" );
    level.brgametype.firstteam = team;
    br_spawnrespawn::setteamasextracted( team );
    heli notify( #"missioncomplete" );
    outofbounds::enableoobimmunity( self );
    br_public::brleaderdialogteam( "team_victory", team, undefined, 1.5 );
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
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0xab86dea9, Offset: 0xfb2
// Size: 0x43
function brendgame()
{
    wait 1.5;
    handleendgamesplash();
    gamelogic_mp::endgame_regularmp( level.brgametype.firstteam, game[ "end_reason" ][ "objective_completed" ], game[ "end_reason" ][ "br_eliminated" ] );
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0xd0b4a877, Offset: 0xffd
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

// Namespace br_gametype_evac
// Params 1
// Checksum 0xea75820a, Offset: 0x109a
// Size: 0x228
function runheliextraction( circleindex )
{
    if ( isdefined( circleindex ) )
    {
        br_gulag::shutdowngulag( "circle_index", circleindex );
    }
    
    level thread br_public::brbroadcastplayercardsplash( "br_gametype_evac_incoming" );
    br_quest_util::cancelallmissions();
    br_quest_util::disablealltablets();
    thread setupmissionwidget();
    makeextractionobjective();
    vfxent = createextractvfx( level.brgametype.helilandingorigin );
    planeflyheight = getheliflyheight();
    helipathgoal = ( level.brgametype.helilandingorigin[ 0 ], level.brgametype.helilandingorigin[ 1 ], planeflyheight );
    groundz = tracegroundheight( helipathgoal );
    var_f4feabcd5c9f80b8 = helipathgoal[ 2 ] - groundz;
    flytime = calculatehelitimetoarrive( var_f4feabcd5c9f80b8 );
    arrivetime = level.brgametype.heliextractarrivewait + flytime;
    var_f25373bbb40ad9ce = arrivetime + level.brgametype.heliextractwait;
    level.br_circle.dangercircleui.origin = br_circle::getdangercircleorigin() + ( 0, 0, br_circle::getdangercircleradius() );
    br_circle::setstaticuicircles( var_f25373bbb40ad9ce, level.br_circle.safecircleui, level.br_circle.dangercircleui, 0 );
    setomnvar( "ui_hardpoint_timer", gettime() + int( var_f25373bbb40ad9ce * 1000 ) );
    thread setuphelitimer( arrivetime, level.brgametype.heliextractwait );
    wait level.brgametype.heliextractarrivewait;
    heli = spawnextractchopper( level.brgametype.helilandingorigin );
    heli.vfxent = vfxent;
    heli.flytime = flytime;
    heli.groundz = groundz;
    thread extractthink( heli );
}

// Namespace br_gametype_evac
// Params 2
// Checksum 0x6abc8df3, Offset: 0x12ca
// Size: 0xf8
function setuphelitimer( arrivetime, waittime )
{
    level endon( #"game_ended" );
    level.brgametype.timertexthud destroy();
    level.brgametype.timertexthud = createhudelem( &"mp_br_ingame/evac_arrive", undefined, "CENTER", "CENTER", 0, -180 );
    timerhud = hud_util::createservertimer( "default", 1.5 );
    timerhud hud_util::setpoint( "CENTER", "CENTER", 0, -162 );
    timerhud settimer( arrivetime );
    wait arrivetime;
    level.brgametype.timertexthud.label = &"mp_br_ingame/evac_wait";
    timerhud settimer( waittime );
    wait waittime;
    level.brgametype.timertexthud destroy();
    timerhud destroy();
}

// Namespace br_gametype_evac
// Params 8
// Checksum 0x685ac8b8, Offset: 0x13ca
// Size: 0x196
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
    fontelem.alpha = 1;
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

// Namespace br_gametype_evac
// Params 0
// Checksum 0x8b97c6c5, Offset: 0x1569
// Size: 0xf8
function makeextractionobjective()
{
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    level.brgametype.objectiveiconid = objectiveiconid;
    assert( objectiveiconid != -1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "active", level.brgametype.helilandingorigin, "ui_mp_br_mapmenu_icon_helipad" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_playermask_showtoall( objectiveiconid );
    }
    
    objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
    level.brgametype.objectiveiconid = objectiveiconid;
    assert( objectiveiconid != -1 );
    
    if ( objectiveiconid != -1 )
    {
        objidpoolmanager::objective_add_objective( objectiveiconid, "current", level.brgametype.helilandingorigin + ( 0, 0, 30 ), "ui_mp_br_mapmenu_legend_littlebird" );
        objidpoolmanager::update_objective_setbackground( objectiveiconid, 1 );
        objidpoolmanager::objective_playermask_showtoall( objectiveiconid );
    }
}

// Namespace br_gametype_evac
// Params 1
// Checksum 0xdc36633f, Offset: 0x1669
// Size: 0x107
function extractthink( heli )
{
    heli setvehgoalpos( heli.pathgoal, 1 );
    heli settargetyaw( heli.goalyaw );
    heli waittill( #"goal" );
    heli thread helidisapateextractvfx();
    heli helidescend( heli.endpoint, heli.groundz );
    objidpoolmanager::update_objective_setbackground( level.brgametype.objectiveiconid, 4 );
    level thread br_public::brbroadcastplayercardsplash( "br_gametype_evac_arrived" );
    level thread br_public::brleaderdialogteam( "plunder_extract_chopper_arrive", heli.team, 1 );
    heli helicleanupextract( 0 );
    heli heliextractwait();
    heli heliusecleanup();
    heli thread helileave();
    
    /#
        if ( level.brgametype.var_8b4da285533eeaaa > 0 )
        {
            level.brgametype.var_8b4da285533eeaaa--;
            return;
        }
    #/
    
    brendgame();
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0x35842cf2, Offset: 0x1778
// Size: 0x3e
function getheliflyheight()
{
    heightent = getent( "airstrikeheight", #targetname );
    planeflyheight = heightent.origin[ 2 ] - 300;
    return planeflyheight;
}

// Namespace br_gametype_evac
// Params 1
// Checksum 0xbffcafa0, Offset: 0x17bf
// Size: 0xbe
function spawnextractchopper( position )
{
    extractpos = position;
    planeflyheight = getheliflyheight();
    descendpoint = ( extractpos[ 0 ], extractpos[ 1 ], planeflyheight );
    angles = ( 0, randomfloat( 360 ), 0 );
    enterposition = descendpoint + -1 * anglestoforward( angles ) * 30000;
    exitposition = descendpoint + anglestoforward( angles ) * 30000;
    randomowner = level.players[ randomint( level.players.size ) ];
    heli = randomowner spawnheli( randomowner, enterposition, descendpoint, exitposition );
    return heli;
}

// Namespace br_gametype_evac
// Params 3
// Checksum 0x846f978a, Offset: 0x1886
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

// Namespace br_gametype_evac
// Params 1
// Checksum 0x9685193e, Offset: 0x1929
// Size: 0x51
function calculatehelitimetoarrive( var_f4feabcd5c9f80b8 )
{
    arrivetime = calculatehelitimetoflysec( 30000, 100, 125 );
    descendtime = calculatehelitimetoflysec( var_f4feabcd5c9f80b8, 25, 31.25 );
    totaltime = arrivetime + descendtime;
    return totaltime;
}

// Namespace br_gametype_evac
// Params 2
// Checksum 0x816a8181, Offset: 0x1983
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

// Namespace br_gametype_evac
// Params 0
// Checksum 0xa21b906a, Offset: 0x1a61
// Size: 0xa4
function heliextractwait()
{
    usable = spawn( "script_model", level.brgametype.helilandingorigin + ( 0, 0, 20 ) );
    usable setmodel( "tag_origin" );
    usable makeusable();
    usable setcursorhint( "HINT_NOICON" );
    usable setuseholdduration( "duration_short" );
    usable setuserange( 230 );
    usable sethintstring( &"mp_br_ingame/extract" );
    self.usable = usable;
    thread helithink( usable );
    wait level.brgametype.heliextractwait;
}

// Namespace br_gametype_evac
// Params 1
// Checksum 0x78d74e46, Offset: 0x1b0d
// Size: 0x75
function helithink( usable )
{
    self endon( #"death" );
    usable endon( #"death" );
    
    while ( true )
    {
        usable waittill( #"trigger", player );
        player playlocalsound( "br_plunder_atm_deposit_gtr" );
        heliusecleanup();
        teamextractedvictory( player.team, self );
        brendgame();
        return;
    }
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0xdc481f2d, Offset: 0x1b8a
// Size: 0x29
function heliusecleanup()
{
    if ( isdefined( self.usable ) )
    {
        self.usable depotmakeunsabletoall();
        self.usable = undefined;
    }
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0xf8f6d0e4, Offset: 0x1bbb
// Size: 0x53
function depotmakeunsabletoall()
{
    self makeunusable();
    
    if ( isdefined( level.brgametype.objectiveiconid ) )
    {
        objidpoolmanager::objective_playermask_hidefromall( level.brgametype.objectiveiconid );
        objidpoolmanager::returnobjectiveid( level.brgametype.objectiveiconid );
    }
}

// Namespace br_gametype_evac
// Params 1
// Checksum 0xa4ee512a, Offset: 0x1c16
// Size: 0x67
function createextractvfx( position )
{
    vfxent = spawn( "script_model", position );
    vfxent setmodel( "scr_smoke_grenade" );
    vfxent.angles = ( 0, 90, 90 );
    vfxent playloopsound( "smoke_carepackage_smoke_lp" );
    vfxent setscriptablepartstate( "smoke", "on" );
    return vfxent;
}

// Namespace br_gametype_evac
// Params 1
// Checksum 0x4174b76d, Offset: 0x1c86
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

// Namespace br_gametype_evac
// Params 0
// Checksum 0x7366b74d, Offset: 0x1d0a
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

// Namespace br_gametype_evac
// Params 4
// Checksum 0xdb25521f, Offset: 0x1d96
// Size: 0x1db
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
    heli.health = 9999;
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
    heli setmaxpitchroll( 10, 25 );
    heli vehicle_setspeed( heli.speed, heli.accel );
    heli sethoverparams( 50, 100, 50 );
    heli setturningability( 0.05 );
    heli setyawspeed( 45, 25, 25, 0.5 );
    heli setotherent( owner );
    heli thread flares::flares_handleincomingstinger( undefined, undefined );
    return heli;
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0x934dedcf, Offset: 0x1f7a
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

// Namespace br_gametype_evac
// Params 0
// Checksum 0x273e2ed9, Offset: 0x1fba
// Size: 0xa
function helidelete()
{
    vehicle_tracking::delete_vehicle( self );
}

// Namespace br_gametype_evac
// Params 13
// Checksum 0xafbc6ca0, Offset: 0x1fcc
// Size: 0x78
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, partname, eventid )
{
    
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0x9d01ae18, Offset: 0x204c
// Size: 0xcb
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
    helisetteamextractionhud( 0, 0 );
    self notify( #"heli_gone" );
    helidelete();
}

// Namespace br_gametype_evac
// Params 2
// Checksum 0xad02a025, Offset: 0x211f
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

// Namespace br_gametype_evac
// Params 0
// Checksum 0x9d13798e, Offset: 0x21d1
// Size: 0x24, Type: bool
function entisalivevehicle()
{
    return isalive( self ) && ( vehicle::is_vehicle() || self.classname == "script_vehicle" );
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0x7812b3d, Offset: 0x21fe
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

// Namespace br_gametype_evac
// Params 0
// Checksum 0xaeeeef3a, Offset: 0x2276
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

// Namespace br_gametype_evac
// Params 1
// Checksum 0x5c9cd6c5, Offset: 0x2518
// Size: 0x4c
function tracegroundheight( start )
{
    offgroundheight = 190;
    groundpt = tracegroundpoint( start, 150 );
    groundheight = groundpt[ 2 ];
    trueheight = groundheight + offgroundheight;
    return trueheight;
}

// Namespace br_gametype_evac
// Params 3
// Checksum 0x738cb877, Offset: 0x256d
// Size: 0xa5
function tracegroundpoint( start, radius, ignorelist )
{
    var_aa0d98a844610c90 = -99999;
    end = ( start[ 0 ], start[ 1 ], var_aa0d98a844610c90 );
    contents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_missileclip", "physicscontents_vehicleclip" ] );
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

// Namespace br_gametype_evac
// Params 0
// Checksum 0x86b21078, Offset: 0x261b
// Size: 0x2e
function heliwatchgameendleave()
{
    self endon( #"death" );
    self endon( #"leaving" );
    level waittill( #"game_ended" );
    thread helileave();
}

// Namespace br_gametype_evac
// Params 0
// Checksum 0x1b9ce2dd, Offset: 0x2651
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

/#

    // Namespace br_gametype_evac
    // Params 0
    // Checksum 0xf3c32d39, Offset: 0x26e2
    // Size: 0x165, Type: dev
    function devthink()
    {
        level.brgametype.var_8b4da285533eeaaa = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_7922ee604dec1c99", 0 ) != 0 && isdefined( level.brgametype.helilandingorigin ) )
            {
                setdvar( @"ai_shownavmesh", 2 );
                color = ( 0, 1, 0 );
                
                if ( !level.brgametype.var_9927ccac1f1f3580 )
                {
                    color = ( 1, 0, 1 );
                }
                
                sphere( level.brgametype.helilandingorigin, 150, color );
            }
            else if ( getdvarint( @"ai_shownavmesh", 0 ) != 0 )
            {
                setdvar( @"ai_shownavmesh", 0 );
            }
            
            if ( getdvarint( @"hash_c925e9bdac1c6672", 0 ) != 0 )
            {
                host = gamelogic_mp::gethostplayer();
                
                if ( isdefined( host ) )
                {
                    setuphelilandingposition( host.origin );
                }
                
                setdvar( @"hash_c925e9bdac1c6672", 0 );
            }
            
            if ( getdvarint( @"evac_heli", 0 ) != 0 )
            {
                level.brgametype.var_8b4da285533eeaaa++;
                thread runheliextraction();
                setdvar( @"evac_heli", 0 );
            }
            
            waitframe();
        }
    }

#/
