// scripts\mp\gametypes\rugby.gsc  (hash_35199f2a94ed1877.gscc) (size: 42064 Bytes / 0xa450 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66331b14 (1714625300)
// size ...... 42064 (0xa450)
// includes .. 27  (offset: 0x9714)
// strings ... 173 (offset: 0x97ec)
// dev strs .. 13  (offset: 0xa3a0)
// exports ... 94  (offset: 0x679c)
// cseg ...... 0xd1b + 0x5a81 (0x679c)
// imports ... 274 (offset: 0x764c)
// animtree1 . 0   (offset: 0xa450)
// animtree2 . 0   (offset: 0xa450)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\juggernaut;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawncamera;
#using scripts\mp\spawnlogic;
#using scripts\mp\spectating;
#using scripts\mp\weapons;

#namespace rugby;

// Namespace rugby
// Params 0
// Checksum 0x4d9e97f3, Offset: 0xd39
// Size: 0x2fb
function main()
{
    globals = spawnstruct();
    level.rugby = globals;
    globals.endzones = [];
    globals.endzones[ "allies" ] = [];
    globals.endzones[ "axis" ] = [];
    globals.juggcratesetups = [];
    globals.goals = [];
    globals.activejuggcrates = [];
    globals.activejuggernauts = [];
    globals.lastjuggpositions = [];
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    initrules();
    callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level.teambased = 1;
    level.objectivebased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.ontimelimit = &ontimelimit;
    level.onplayerdamaged = &onplayerdamaged;
    level.modeonteamchangedeath = &modeonteamchangedeath;
    level.onplayerconnect = &onplayerconnect;
    level.ontimelimitot = &ontimelimitot;
    level.modeusecondition = &function_3b09f98e9b44b497;
    game[ "canScoreOnTie" ] = 1;
    
    if ( game_utility::function_d3f8957534dc62af() )
    {
        game[ "dialog" ][ "gametype" ] = "iw9_rgby_mode_uktl_rgt1";
    }
    else
    {
        game[ "dialog" ][ "gametype" ] = "gametype_onslaught";
    }
    
    game[ "dialog" ][ "boost" ] = "boost_rugby";
    
    if ( !isdefined( game[ "roundsPlayed" ] ) )
    {
        boostvo = "boost_rugby";
    }
    else
    {
        boostvo = "boost_rugby_short";
    }
    
    game[ "dialog" ][ "offense_obj" ] = boostvo;
    game[ "dialog" ][ "defense_obj" ] = boostvo;
    game[ "dialog" ][ "rugby_enemy_close_goal" ] = "rugby_enemy_close_goal";
    game[ "dialog" ][ "rugby_friendly_close_goal" ] = "rugby_friendly_close_goal";
    game[ "dialog" ][ "rugby_lost_jugg" ] = "rugby_lost_jugg";
    game[ "dialog" ][ "rugby_secured_jugg" ] = "rugby_secured_jugg";
    game[ "dialog" ][ "rugby_securing_jugg" ] = "rugby_securing_jugg";
    game[ "dialog" ][ "rugby_capture_jugg" ] = "objective_new";
    game[ "dialog" ][ "rugby_new_jugg" ] = "tjugg_new_player";
    game[ "dialog" ][ "rugby_team_jugg_nag" ] = "tjugg_vip";
    game[ "dialog" ][ "rugby_order_attack" ] = "order_attack";
    game[ "dialog" ][ "rugby_order_fallback" ] = "order_fallback";
    game[ "dialog" ][ "rugby_round_lose" ] = "overrun_enemy";
    game[ "dialog" ][ "rugby_round_win" ] = "overrun_friendly";
    level._effect[ "rugby_score_explosion" ] = loadfxasset( "vfx_iw9_dmz_bombsite_explo" );
}

// Namespace rugby
// Params 0
// Checksum 0xaf95f4ed, Offset: 0x103c
// Size: 0x48
function initrules()
{
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.ontimelimitgraceperiod = function_ef7e150e75878761();
    level.currenttimelimitdelay = 0;
}

// Namespace rugby
// Params 0
// Checksum 0xde75344c, Offset: 0x108c
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace rugby
// Params 0
// Checksum 0xb8dd86cd, Offset: 0x109d
// Size: 0xfb
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    jugghealth = getmatchrulesdata( "rugbyData", "juggHealth" );
    setdynamicdvar( @"hash_916482a23f7db002", jugghealth );
    juggspeed = getmatchrulesdata( "rugbyData", "juggSpeed" );
    setdynamicdvar( @"hash_fca821906f4a663f", juggspeed );
    juggteamspeed = getmatchrulesdata( "rugbyData", "juggTeamSpeed" );
    setdynamicdvar( @"hash_64d4d28dc063bff0", juggteamspeed );
    juggtimeout = getmatchrulesdata( "rugbyData", "juggTimeout" );
    setdynamicdvar( @"hash_364db51c6de274cf", juggtimeout );
    helpermax = getmatchrulesdata( "rugbyData", "helperMax" );
    setdynamicdvar( @"hash_f3f419ef3e285de3", helpermax );
    juggcapturetime = getmatchrulesdata( "rugbyData", "juggCaptureTime" );
    setdynamicdvar( @"hash_f96f8ff371da9f0f", juggcapturetime );
}

// Namespace rugby
// Params 0
// Checksum 0x615c0937, Offset: 0x11a0
// Size: 0xf
function getjuggmaxhealth()
{
    return getdvarint( @"hash_916482a23f7db002" );
}

// Namespace rugby
// Params 1
// Checksum 0x38742979, Offset: 0x11b8
// Size: 0x6d
function getjuggspeedscalar( helperplayers )
{
    unassistedscalar = -0.3 + 0.1 * getdvarfloat( @"hash_fca821906f4a663f" );
    helperplayers = int( min( helperplayers, getdvarint( @"hash_f3f419ef3e285de3" ) ) );
    var_5bd5b6f718f6e58d = 0.08 * getdvarfloat( @"hash_64d4d28dc063bff0" );
    return unassistedscalar + helperplayers * var_5bd5b6f718f6e58d;
}

// Namespace rugby
// Params 0
// Checksum 0x51716bae, Offset: 0x122e
// Size: 0xf
function getjuggtimeout()
{
    return getdvarfloat( @"hash_364db51c6de274cf" );
}

// Namespace rugby
// Params 0
// Checksum 0x8996c7c0, Offset: 0x1246
// Size: 0xf
function function_5a3184d680092b8b()
{
    return getdvarfloat( @"hash_f96f8ff371da9f0f" );
}

// Namespace rugby
// Params 0
// Checksum 0xa50877ce, Offset: 0x125e
// Size: 0x11
function function_ef7e150e75878761()
{
    return getdvarfloat( @"hash_d2716123812605f", 45 );
}

// Namespace rugby
// Params 0
// Checksum 0xfa91632, Offset: 0x1278
// Size: 0xca
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"mp_mode_rugby/ingame_objective" );
    }
    
    setupwaypointicons();
    function_8dd4665fd7399700();
    thread initrugbyents();
    thread setupinitialstate();
    initspawns();
    initjugg();
    level thread function_3fa2b92da6b49c04();
    
    /#
        thread function_ac2fec6cd66db9c5();
    #/
}

// Namespace rugby
// Params 0
// Checksum 0xf67bc15b, Offset: 0x134a
// Size: 0x28
function function_3fa2b92da6b49c04()
{
    flags::gameflagwait( "prematch_done" );
    wait 5;
    level thread hud_message::notifyteam( "jugg_capture", "jugg_capture", "allies" );
}

// Namespace rugby
// Params 0
// Checksum 0xe2cf043b, Offset: 0x137a
// Size: 0x41
function initrugbyents()
{
    level.var_707a164c7102402f = arraycombine( level.outofboundstriggers, level.minetriggers, level.hurttriggers, level.radtriggers );
    initendzoneents();
    initjuggcratesetupents();
}

// Namespace rugby
// Params 0
// Checksum 0x3eadc122, Offset: 0x13c3
// Size: 0xd4
function initendzoneents()
{
    globals = level.rugby;
    endzones = utility::getstructarray( "rugby_endzone", "targetname" );
    
    foreach ( endzone in endzones )
    {
        initendzoneent( endzone );
        globals.endzones[ endzone.team ][ globals.endzones[ endzone.team ].size ] = endzone;
    }
}

// Namespace rugby
// Params 1
// Checksum 0x114cc8db, Offset: 0x149f
// Size: 0x28e
function initendzoneent( endzone )
{
    endzonechildren = getentarray( endzone.target, #targetname );
    assert( isdefined( endzonechildren ) && endzonechildren.size > 0, "<dev string:x24>" + endzone.origin + "<dev string:x36>" );
    
    foreach ( ent in endzonechildren )
    {
        if ( ent.classname == "trigger_multiple_mp_rugby_endzone" )
        {
            endzone.trigger = ent;
        }
        
        if ( isdefined( ent.script_noteworthy ) && getsubstr( ent.script_noteworthy, 0, 3 ) == "fx_" )
        {
            ent delete();
        }
    }
    
    assert( isdefined( endzone.trigger ), "<dev string:x24>" + endzone.origin + "<dev string:x78>" );
    function_ae56b96e5499c6b6( endzone );
    
    if ( endzone.spawnflags & 1 )
    {
        endzone.team = "allies";
        endzone.trigger.objectivekey = "allies";
    }
    else if ( endzone.spawnflags & 2 )
    {
        endzone.team = "axis";
        endzone.trigger.objectivekey = "axis";
    }
    else
    {
        endzone.team = "allies";
        endzone.trigger.objectivekey = "allies";
        assertmsg( "<dev string:x24>" + endzone.origin + "<dev string:xae>" );
    }
    
    foreach ( ent in endzonechildren )
    {
        if ( !isdefined( endzone.chevrons ) )
        {
            level thread setupchevrons( endzone );
        }
    }
}

// Namespace rugby
// Params 1
// Checksum 0xffe7a4c2, Offset: 0x1735
// Size: 0xc6
function function_ae56b96e5499c6b6( endzone )
{
    if ( level.mapname == "mp_crash2" )
    {
        if ( distance2d( endzone.origin, ( 312, -1552, 216 ) ) < 10 )
        {
            endzone.spawnflags = 1;
        }
        
        return;
    }
    
    if ( level.mapname == "mp_scrapyard" )
    {
        if ( distance2d( endzone.origin, ( -25223.3, -12439.2, 36.5 ) ) < 10 )
        {
            endzone.spawnflags = 2;
            return;
        }
        
        if ( distance2d( endzone.origin, ( -26150.7, -8967.81, 144 ) ) < 10 )
        {
            endzone.spawnflags = 1;
        }
    }
}

// Namespace rugby
// Params 0
// Checksum 0x4cfbc4fb, Offset: 0x1803
// Size: 0xc8
function initjuggcratesetupents()
{
    globals = level.rugby;
    juggcratesetups = utility::getstructarray( "rugby_jugg_crate", "targetname" );
    
    foreach ( juggcratesetup in juggcratesetups )
    {
        juggcratesetup = function_55129b5fad93fbd4( juggcratesetup );
        globals.juggcratesetups[ globals.juggcratesetups.size ] = juggcratesetup;
    }
    
    level.rugby = globals;
}

// Namespace rugby
// Params 1
// Checksum 0xe024918f, Offset: 0x18d3
// Size: 0x78
function function_55129b5fad93fbd4( juggcratesetup )
{
    switch ( level.mapname )
    {
        case #"hash_d39c51733bbe5712":
            if ( distance( juggcratesetup.origin, ( 3113.65, -1118.5, 378.5 ) ) < 10 )
            {
                juggcratesetup.origin = ( 2751, -1028, 376.5 );
            }
            
            break;
        default:
            break;
    }
    
    return juggcratesetup;
}

// Namespace rugby
// Params 0
// Checksum 0xbdaed413, Offset: 0x1954
// Size: 0xa6
function initoverheadcameras()
{
    level.spectatorcameras = [];
    level.spectatorcameras[ 0 ][ "allies" ] = spawnstruct();
    level.spectatorcameras[ 0 ][ "axis" ] = spawnstruct();
    spawncamera::setgamemodecamera( "allies", level.spectatorcameras[ 0 ][ "allies" ] );
    spawncamera::setgamemodecamera( "axis", level.spectatorcameras[ 0 ][ "axis" ] );
    updateoverheadcamerapos( "allies" );
    updateoverheadcamerapos( "axis" );
    level.updategamemodecamera = &updateoverheadcamerapos;
    level.spectatorcameratime = 1.25;
}

// Namespace rugby
// Params 0
// Checksum 0xea5fa397, Offset: 0x1a02
// Size: 0xf9
function initjugg()
{
    juggconfig = juggernaut::jugg_createconfig( level.streakglobals.streakbundles[ "juggernaut" ].juggernautconfig );
    level.rugby.juggconfig = juggconfig;
    maxhealth = getjuggmaxhealth();
    juggconfig.maxhealth = maxhealth;
    juggconfig.startinghealth = maxhealth;
    juggconfig.suit = "iw9_juggernaut_mp";
    juggconfig.clothtype = "vestheavy";
    juggconfig.geartype = "milhvygr";
    juggconfig.forcetostand = 0;
    juggconfig.restrictions[ "sprint" ] = 1;
    juggconfig.restrictions[ "weapon_switch" ] = undefined;
    juggconfig.classstruct.loadoutprimary = "iw9_lm_dblmg";
}

// Namespace rugby
// Params 0
// Checksum 0xe0dac0ef, Offset: 0x1b03
// Size: 0x3c0
function initspawns()
{
    globals = level.rugby;
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    globals.startspawnclassname = "mp_rugby_spawn";
    spawnlogic::addstartspawnpoints( globals.startspawnclassname + "_allies_start", 1, "allies" );
    spawnlogic::addstartspawnpoints( globals.startspawnclassname + "_axis_start", 1, "axis" );
    
    if ( !isdefined( level.teamstartspawnpoints ) )
    {
        globals.startspawnclassname = "mp_tdm_spawn";
        spawnlogic::addstartspawnpoints( globals.startspawnclassname + "_allies_start", 1, "allies" );
        spawnlogic::addstartspawnpoints( globals.startspawnclassname + "_axis_start", 1, "axis" );
    }
    
    assert( isdefined( level.teamstartspawnpoints ), "<dev string:xd4>" + globals.startspawnclassname + "<dev string:xd8>" );
    assert( isdefined( level.teamstartspawnpoints[ "<dev string:xec>" ] ) && level.teamstartspawnpoints[ "<dev string:xec>" ].size != 0, "<dev string:xf3>" );
    assert( isdefined( level.teamstartspawnpoints[ "<dev string:x116>" ] ) && level.teamstartspawnpoints[ "<dev string:x116>" ].size != 0, "<dev string:x11b>" );
    alliesspawnpoints = spawnlogic::getspawnpointarray( "mp_rugby_spawn_allies" );
    axisspawnpoints = spawnlogic::getspawnpointarray( "mp_rugby_spawn_axis" );
    
    if ( alliesspawnpoints.size <= 0 || axisspawnpoints.size <= 0 )
    {
        genericspawnpoints = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
        
        foreach ( spawnpoint in genericspawnpoints )
        {
            if ( distancesquared( spawnpoint.origin, globals.goals[ "allies" ].origin ) < distancesquared( spawnpoint.origin, globals.goals[ "axis" ].origin ) )
            {
                alliesspawnpoints[ alliesspawnpoints.size ] = spawnpoint;
                continue;
            }
            
            axisspawnpoints[ axisspawnpoints.size ] = spawnpoint;
        }
    }
    
    var_1b3470b499217aba = spawnlogic::getspawnpointarray( "mp_rugby_spawn_allies_secondary" );
    var_b261170910461f2f = spawnlogic::getspawnpointarray( "mp_rugby_spawn_axis_secondary" );
    spawnlogic::function_256bea3c722e022( "allies", alliesspawnpoints );
    spawnlogic::function_256bea3c722e022( "axis", axisspawnpoints );
    spawnlogic::function_256bea3c722e022( "allies", var_1b3470b499217aba );
    spawnlogic::function_256bea3c722e022( "axis", var_b261170910461f2f );
    spawnlogic::registerspawnset( #"primary_attackers", alliesspawnpoints );
    spawnlogic::registerspawnset( #"primary_defenders", axisspawnpoints );
    spawnlogic::registerspawnset( #"fallback_attackers", var_1b3470b499217aba );
    spawnlogic::registerspawnset( #"fallback_defenders", var_b261170910461f2f );
    globals.spawnsets = [];
    globals.spawnsets[ "allies" ] = #"primary_attackers";
    globals.spawnsets[ "axis" ] = #"primary_defenders";
    globals.fallbackspawnsets = [];
    globals.fallbackspawnsets[ "allies" ] = #"fallback_attackers";
    globals.fallbackspawnsets[ "axis" ] = #"fallback_defenders";
    spawnlogic::finalizemap();
}

// Namespace rugby
// Params 0
// Checksum 0x82befe7b, Offset: 0x1ecb
// Size: 0x180
function getspawnpoint()
{
    globals = level.rugby;
    spawnpointteam = self.pers[ "team" ];
    
    if ( game[ "switchedsides" ] )
    {
        spawnpointteam = spawnpointteam == "allies" ? "axis" : "allies";
    }
    
    var_c5bda512ac854058 = spawnpointteam == "allies" ? "axis" : "allies";
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        spawnpoints = spawnlogic::getspawnpointarray( globals.startspawnclassname + "_" + spawnpointteam + "_start" );
        spawnpoint = spawnlogic::getspawnpoint_startspawn( spawnpoints );
    }
    else
    {
        juggpos = getjuggorcratepos();
        spawnparams = [];
        spawnparams[ "singlePointPos" ] = juggpos;
        spawnparams[ "minDistToSinglePointSq" ] = 562500;
        spawnparams[ "maxDistToSinglePointSq" ] = 36000000;
        spawnparams[ "distRangeToSinglePointSq" ] = 35437500;
        spawnparams[ "juggPos" ] = juggpos;
        spawnparams[ "rugbyFieldDir2D" ] = globals.goals[ var_c5bda512ac854058 ].origin - globals.goals[ spawnpointteam ].origin;
        spawnpoint = spawnlogic::getspawnpointlegacy( self, self.team, globals.spawnsets[ spawnpointteam ], globals.fallbackspawnsets[ spawnpointteam ], undefined, spawnparams );
    }
    
    return spawnpoint;
}

// Namespace rugby
// Params 1
// Checksum 0x30e57a30, Offset: 0x2054
// Size: 0x4d
function modeonteamchangedeath( player )
{
    if ( isdefined( level.rugbyjugg ) )
    {
        player setclientomnvar( "ui_rugby_jugg_friendly", player.team == level.rugbyjugg.team ? 0 : 1 );
    }
}

// Namespace rugby
// Params 1
// Checksum 0xa5d2a633, Offset: 0x20a9
// Size: 0x5b
function onplayerconnect( player )
{
    player stats::setextrascore0( player.pers[ "damage" ] ?? 0, "damage" );
    player stats::setextrascore1( player.pers[ "defends" ] ?? 0, "defends" );
    thread onplayerspawned( player );
}

// Namespace rugby
// Params 1
// Checksum 0x7aa2674c, Offset: 0x210c
// Size: 0x81
function onplayerspawned( player )
{
    player waittill( #"spawned" );
    
    if ( isdefined( level.rugbyjugg ) && isdefined( level.rugbyjugg.team ) && isdefined( player.team ) )
    {
        player setclientomnvar( "ui_rugby_jugg_friendly", player.team == level.rugbyjugg.team ? 0 : 1 );
    }
}

// Namespace rugby
// Params 14
// Checksum 0x2c01d1c1, Offset: 0x2195
// Size: 0xdb
function onplayerdamaged( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_ca02bfdd611a56f4, vpoint, vdir, shitloc, psoffsettime, modelindex, partname )
{
    if ( eattacker != victim && isplayer( eattacker ) )
    {
        if ( idamage >= var_ca02bfdd611a56f4 )
        {
            idamage = var_ca02bfdd611a56f4;
        }
        
        eattacker persistence::statsetchild( "round", "damage", eattacker.pers[ "damage" ] );
        eattacker stats::setextrascore0( eattacker.pers[ "damage" ] );
    }
}

// Namespace rugby
// Params 6
// Checksum 0x4a11b130, Offset: 0x2278
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

// Namespace rugby
// Params 1
// Checksum 0x18a83fc2, Offset: 0x22c8
// Size: 0x13c
function function_8314535b81f548e( deathdata )
{
    einflictor = deathdata.inflictor;
    victim = deathdata.victim;
    attacker = deathdata.attacker;
    idamage = deathdata.damage;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    vdir = deathdata.direction_vec;
    shitloc = deathdata.hitloc;
    psoffsettime = deathdata.psoffsettime;
    deathanimduration = deathdata.deathanimduration;
    killid = deathdata.lifeid;
    victim.overrideweaponspeed_speedscale = undefined;
    
    if ( !isplayer( attacker ) || attacker.team == victim.team )
    {
        return;
    }
    
    victim awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid );
}

// Namespace rugby
// Params 10
// Checksum 0x2c3d7d3c, Offset: 0x240c
// Size: 0x370
function awardgenericmedals( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    victim = self;
    victimpos = victim.origin;
    attackerpos = attacker.origin;
    
    if ( isdefined( einflictor ) )
    {
        attackerpos = einflictor.origin;
    }
    
    if ( isdefined( level.rugbyjugg ) )
    {
        if ( isplayer( attacker ) && attacker.team != victim.team )
        {
            if ( attacker == level.rugbyjugg )
            {
                attacker thread points::function_aa3f27bc29d005fc( #"hash_670456684d1ac92f" );
                return;
            }
            
            if ( victim == level.rugbyjugg )
            {
                attacker thread points::function_aa3f27bc29d005fc( #"kill_juggernaut" );
                return;
            }
            
            if ( attacker.team == level.rugbyjugg.team && attacker != level.rugbyjugg )
            {
                var_6aa46a88b729df84 = distancesquared( level.rugbyjugg.origin, attackerpos );
                
                if ( var_6aa46a88b729df84 < 105625 )
                {
                    attacker thread rank::function_d2aa8986c506e985( #"defend" );
                    attacker events::function_20a5f572df6afd43();
                    
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
                        
                        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x13c>" );
                        
                        if ( isdefined( attacker.pers[ "defends" ] ) )
                        {
                            attacker.pers[ "defends" ] = attacker.pers[ "defends" ] + 1;
                        }
                    }
                    
                    attacker persistence::statsetchild( "round", "defends", attacker.pers[ "defends" ] );
                    attacker stats::setextrascore1( attacker.pers[ "defends" ] );
                    thread utility::trycall( level.matchdata_logvictimkillevent, killid, "defending" );
                }
                
                return;
            }
            
            if ( attacker.team != level.rugbyjugg.team && victim.team == level.rugbyjugg.team )
            {
                var_6aa46a88b729df84 = distancesquared( level.rugbyjugg.origin, victimpos );
                
                if ( var_6aa46a88b729df84 < 105625 )
                {
                    attacker thread rank::function_d2aa8986c506e985( #"assault" );
                    attacker events::function_58da673c1c3fc9f2();
                    thread utility::trycall( level.matchdata_logattackerkillevent, killid, "assaulting" );
                }
            }
        }
    }
}

// Namespace rugby
// Params 0
// Checksum 0xaab93f78, Offset: 0x2784
// Size: 0x28
function ontimelimit()
{
    if ( level.gameended )
    {
        return;
    }
    
    thread gamelogic_mp::endgame( "tie", game[ "end_reason" ][ "cyber_tie" ] );
}

// Namespace rugby
// Params 0
// Checksum 0xc86c92a1, Offset: 0x27b4
// Size: 0x9b
function ontimelimitot()
{
    if ( level.rugby.activejuggernauts.size > 0 )
    {
        if ( !level.rugby.inot )
        {
            setomnvar( "ui_overtime_time", gettime() + function_ef7e150e75878761() * 1000 );
            level.rugby.inot = 1;
            level.canprocessot = 1;
            function_bc16a61b2a4a91cd();
            level thread function_d430268549b346df();
        }
        
        return;
    }
    
    level.canprocessot = 1;
    level.currenttimelimitdelay = level.ontimelimitgraceperiod;
}

// Namespace rugby
// Params 0
// Checksum 0x823a3ccc, Offset: 0x2857
// Size: 0x4d
function function_d430268549b346df()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.rugby.activejuggernauts.size > 0 )
        {
            wait 0.05;
            continue;
        }
        
        level.currenttimelimitdelay = level.ontimelimitgraceperiod;
        break;
    }
}

// Namespace rugby
// Params 0
// Checksum 0xc72499ea, Offset: 0x28ac
// Size: 0x46
function function_ddfe62c1f15de99c()
{
    time = getdvarfloat( @"hash_364db51c6de274cf" );
    time = int( time * 1000 + gettime() );
    setomnvar( "ui_obj_timer", time );
    setomnvar( "ui_obj_progress", 1 );
    return time;
}

// Namespace rugby
// Params 0
// Checksum 0xb3eee56, Offset: 0x28fb
// Size: 0x24
function function_bc16a61b2a4a91cd()
{
    level notify( #"hash_8ac25d40e4434da5" );
    setomnvar( "ui_obj_timer", 0 );
    setomnvar( "ui_obj_progress", 0 );
}

// Namespace rugby
// Params 0
// Checksum 0x54a591e5, Offset: 0x2927
// Size: 0x15b
function getjuggorcratepos()
{
    globals = level.rugby;
    
    if ( isdefined( level.rugbyjugg ) )
    {
        return level.rugbyjugg.origin;
    }
    
    if ( globals.activejuggernauts.size > 0 )
    {
        foreach ( jugg in globals.activejuggernauts )
        {
            return jugg.origin;
        }
        
        return;
    }
    
    assert( globals.activejuggcrates.size );
    
    foreach ( crate in globals.activejuggcrates )
    {
        return crate.origin;
    }
}

// Namespace rugby
// Params 1
// Checksum 0xb6a6d380, Offset: 0x2a8b
// Size: 0xb7, Type: bool
function doesteamhaveactivejugg( team )
{
    globals = level.rugby;
    
    if ( globals.activejuggernauts.size > 0 )
    {
        foreach ( jugg in globals.activejuggernauts )
        {
            if ( jugg.team == team )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace rugby
// Params 1
// Checksum 0xa291ed1a, Offset: 0x2b4b
// Size: 0x12b
function onjuggproximityscore( juggplayer )
{
    level endon( #"game_ended" );
    playsoundatpos( juggplayer.origin, "exp_bombsite_lr" );
    playfx( utility::getfx( "rugby_score_explosion" ), juggplayer.origin );
    players = getplayersinradius( juggplayer.origin, 800 );
    
    foreach ( player in players )
    {
        if ( player != juggplayer && player.team != juggplayer.team )
        {
            player dodamage( 5000, juggplayer.origin, player, undefined, "MOD_EXPLOSIVE" );
        }
    }
    
    thread gamelogic_mp::endgame( juggplayer.team, game[ "end_reason" ][ "target_destroyed" ] );
}

// Namespace rugby
// Params 0
// Checksum 0xd0a7251, Offset: 0x2c7e
// Size: 0x68
function setupinitialstate()
{
    globals = level.rugby;
    
    if ( !activateendzone( globals.endzones[ "allies" ][ 0 ], "allies" ) )
    {
        return;
    }
    
    if ( !activateendzone( globals.endzones[ "axis" ][ 0 ], "axis" ) )
    {
        return;
    }
    
    if ( !activatenewjuggcrate() )
    {
        return;
    }
}

// Namespace rugby
// Params 0
// Checksum 0xf655418f, Offset: 0x2cee
// Size: 0x8a
function activatenewjuggcrate()
{
    setupindex = randomint( level.rugby.juggcratesetups.size );
    var_748b0358acd20bba = level.rugby.juggcratesetups[ setupindex ];
    
    if ( !isdefined( var_748b0358acd20bba ) )
    {
        assertmsg( "<dev string:x162>" );
        return 0;
    }
    
    return activatejuggcrate( var_748b0358acd20bba.origin, var_748b0358acd20bba.angles ?? ( 0, 0, 0 ), 1 );
}

// Namespace rugby
// Params 2
// Checksum 0xda1046b5, Offset: 0x2d81
// Size: 0xb0, Type: bool
function activateendzone( endzoneent, team )
{
    globals = level.rugby;
    
    if ( game[ "switchedsides" ] )
    {
        team = team == "allies" ? "axis" : "allies";
    }
    
    if ( !isdefined( endzoneent ) )
    {
        assertmsg( "<dev string:xd4>" + team + "<dev string:x17d>" );
        return false;
    }
    
    if ( isdefined( globals.goals[ team ] ) )
    {
        deactivateendzone( globals.goals[ team ] );
    }
    
    globals.goals[ team ] = endzoneent;
    endzoneent thread watchforjuggproximityscore( team );
    return true;
}

// Namespace rugby
// Params 1
// Checksum 0xded880ca, Offset: 0x2e3a
// Size: 0x19
function deactivateendzone( endzone )
{
    endzone notify( #"endzone_deactivate" );
}

// Namespace rugby
// Params 1
// Checksum 0x41e45d36, Offset: 0x2e5b
// Size: 0x146
function setupchevrons( endzone )
{
    if ( level.mapname == "mp_shipment" || level.mapname == "mp_euphrates" || level.mapname == "mp_rust" || level.mapname == "mp_crash2" || level.mapname == "mp_malyshev" )
    {
        if ( endzone.trigger.objectivekey == "allies" )
        {
            target = "allies_endzone_vis";
        }
        else
        {
            target = "axis_endzone_vis";
        }
    }
    else if ( level.mapname == "mp_backlot2" )
    {
        if ( endzone.trigger.targetname == "allies_endzone" )
        {
            target = "axis_endzone_vis";
        }
        else
        {
            target = "allies_endzone_vis";
        }
    }
    else if ( endzone.trigger.targetname == "allies_endzone" )
    {
        target = "allies_endzone_vis";
    }
    else
    {
        target = "axis_endzone_vis";
    }
    
    endzone thread function_a71322eb321079e9( target, endzone.trigger.targetname );
    endzone thread updatechevrons( "idle" );
}

// Namespace rugby
// Params 2
// Checksum 0x9a3bc871, Offset: 0x2fa9
// Size: 0x166
function function_a71322eb321079e9( target, label )
{
    wait 1;
    othervisuals = getentitylessscriptablearray( target, #targetname );
    othervisuals = function_d06ffea136b9ac48( othervisuals, label );
    chevrons = [];
    
    foreach ( visual in othervisuals )
    {
        index = chevrons.size;
        chevrons[ index ] = visual;
        chevrons[ index ].numchevrons = 1;
        
        if ( isdefined( visual.script_noteworthy ) )
        {
            if ( visual.script_noteworthy == "2" )
            {
                chevrons[ index ].numchevrons = 2;
                continue;
            }
            
            if ( visual.script_noteworthy == "3" )
            {
                chevrons[ index ].numchevrons = 3;
                continue;
            }
            
            if ( visual.script_noteworthy == "4" )
            {
                chevrons[ index ].numchevrons = 4;
            }
        }
    }
    
    self.chevrons = chevrons;
}

// Namespace rugby
// Params 1
// Checksum 0xb4ddfc5a, Offset: 0x3117
// Size: 0xf5
function updatechevrons( state )
{
    self notify( #"hash_4b8378ba629fc7e4" );
    self endon( #"hash_4b8378ba629fc7e4" );
    
    while ( !isdefined( self.chevrons ) )
    {
        waitframe();
    }
    
    foreach ( chevron in self.chevrons )
    {
        for ( i = 0; i < chevron.numchevrons ; i++ )
        {
            chevron setscriptablepartstate( "chevron_" + i + ( level.gametypebundle.var_45b9f58d54501ba6 ?? "" ), state );
        }
    }
}

// Namespace rugby
// Params 2
// Checksum 0x34cf2c02, Offset: 0x3214
// Size: 0x22e
function function_b95fdc8856f611e( othervisuals, label )
{
    modifiedvisuals = [];
    var_98c9d5bd477d820b = [];
    
    switch ( level.mapname )
    {
        case #"hash_9de262a7132ec180":
            var_98c9d5bd477d820b[ "1" ] = [ ( -564, 1848, 24 ) ];
            var_98c9d5bd477d820b[ "2" ] = [ ( -1314, 440, 24 ), ( -1362, 816, 24 ) ];
            break;
        case #"hash_66ce5cdcd3b547f3":
        case #"hash_ff009e5fab42b778":
            var_98c9d5bd477d820b[ "3" ] = [ ( -692, 1828, 42 ), ( -300, 1548, 76 ) ];
            break;
        case #"hash_f09747c9feb47eb1":
            var_98c9d5bd477d820b[ "8" ] = [ ( 688, 256, 280 ) ];
            var_98c9d5bd477d820b[ "20" ] = [ ( 212, 1436, 338 ) ];
            break;
        default:
            break;
    }
    
    if ( isdefined( var_98c9d5bd477d820b[ label ] ) )
    {
        foreach ( visual in othervisuals )
        {
            foreach ( entry in var_98c9d5bd477d820b[ label ] )
            {
                if ( distance( visual.origin, entry ) < 10 )
                {
                    modifiedvisuals[ modifiedvisuals.size ] = visual;
                    break;
                }
            }
        }
    }
    
    othervisuals = arrayremove( othervisuals, modifiedvisuals );
    return othervisuals;
}

// Namespace rugby
// Params 2
// Checksum 0x9c130b9c, Offset: 0x344b
// Size: 0x8eb
function function_d06ffea136b9ac48( othervisuals, label )
{
    newchevrons = [];
    modifiedvisuals = [];
    
    switch ( level.mapname )
    {
        case #"hash_d8bbcfc499e70e6f":
            newchevrons[ "allies_endzone" ] = [];
            newchevrons[ "allies_endzone" ][ 0 ] = [ ( -2376, -3322, 39 ), ( 0, -90, 0 ) ];
            newchevrons[ "allies_endzone" ][ 1 ] = [ ( -2071, -3537, 0 ), ( 0, 180, 0 ) ];
            newchevrons[ "allies_endzone" ][ 2 ] = [ ( -2071, -3653, 0 ), ( 0, 180, 0 ) ];
            newchevrons[ "allies_endzone" ][ 3 ] = [ ( -2071, -3754, 3 ), ( 0, 180, 0 ) ];
            newchevrons[ "axis_endzone" ] = [];
            newchevrons[ "axis_endzone" ][ 0 ] = [ ( 2137, 493, 124 ), ( 0, -85, 0 ) ];
            newchevrons[ "axis_endzone" ][ 1 ] = [ ( 2302, 495, 128 ), ( 0, -90, 0 ) ];
            newchevrons[ "axis_endzone" ][ 2 ] = [ ( 2390, 495, 134 ), ( 0, -90, 0 ) ];
            newchevrons[ "axis_endzone" ][ 3 ] = [ ( 2457, 494, 134 ), ( 0, -90, 0 ) ];
            break;
        case #"hash_cce4bca393df84eb":
            newchevrons[ "axis_endzone" ] = [];
            newchevrons[ "axis_endzone" ][ 0 ] = [ ( -722, -1428, 201 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 1 ] = [ ( -722, -1567, 200 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 2 ] = [ ( -721, -1496, 200 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 3 ] = [ ( -721, -1639, 200 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 4 ] = [ ( -720, -1711, 200 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 5 ] = [ ( -720, -1806, 200 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 6 ] = [ ( -719, -1896, 200 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 7 ] = [ ( -719, -1999, 200 ), ( 0, 0, 0 ) ];
            newchevrons[ "axis_endzone" ][ 8 ] = [ ( -483, -2074, 200 ), ( 0, -270, 0 ) ];
            break;
        case #"hash_143ad8976cca3ba":
            newchevrons[ "allies_endzone" ] = [];
            newchevrons[ "allies_endzone" ][ 0 ] = [ ( 4948, 1284, 9 ), ( 0, 45, 0 ) ];
            break;
        case #"hash_9de262a7132ec180":
            newchevrons[ "axis_endzone" ] = [];
            newchevrons[ "axis_endzone" ][ 0 ] = [ ( -603, 3101, 33 ), ( 0, 155, 0 ) ];
            newchevrons[ "allies_endzone" ] = [];
            newchevrons[ "allies_endzone" ][ 0 ] = [ ( -1070, 600, 32 ), ( 0, -20, 0 ) ];
            break;
        case #"hash_7246ed8ceb925ba9":
            newchevrons[ "axis_endzone" ] = [];
            newchevrons[ "axis_endzone" ][ 0 ] = [ ( 1773, -1148, 302 ), ( 0, -90, 0 ) ];
            newchevrons[ "axis_endzone" ][ 1 ] = [ ( 2098, -1153, 292 ), ( 0, -90, 0 ) ];
            break;
        case #"hash_688334408379d4fb":
        case #"hash_d32ec8c7ac2ec13b":
            newchevrons[ "allies_endzone" ] = [];
            newchevrons[ "allies_endzone" ][ 0 ] = [ ( 1648, 367, 291 ), ( 0, 0, 0 ) ];
            newchevrons[ "allies_endzone" ][ 1 ] = [ ( 1947, 859, 255 ), ( 0, 270, 0 ) ];
            newchevrons[ "allies_endzone" ][ 2 ] = [ ( 1691, 854, 291 ), ( 0, 270, 0 ) ];
            break;
        case #"hash_f09747c9feb47eb1":
            newchevrons[ "allies_endzone" ] = [];
            newchevrons[ "allies_endzone" ][ 0 ] = [ ( -2404.94, -1457.67, 280 ), ( 0, 0, 0 ) ];
            newchevrons[ "allies_endzone" ][ 1 ] = [ ( -849.814, -1158.33, 280 ), ( 0, 180, 0 ) ];
            newchevrons[ "allies_endzone" ][ 2 ] = [ ( -1978.45, -341.57, 280 ), ( 0, 270, 0 ) ];
            newchevrons[ "allies_endzone" ][ 3 ] = [ ( -1143, -975, 280 ), ( 0, 270, 0 ) ];
            newchevrons[ "axis_endzone" ] = [];
            newchevrons[ "axis_endzone" ][ 0 ] = [ ( -1300.9, 4861.72, 269 ), ( 0, 180, 0 ) ];
            newchevrons[ "axis_endzone" ][ 1 ] = [ ( -1300.9, 4947, 269 ), ( 0, 180, 0 ) ];
            newchevrons[ "axis_endzone" ][ 2 ] = [ ( -1300.9, 4759, 269 ), ( 0, 180, 0 ) ];
            newchevrons[ "axis_endzone" ][ 3 ] = [ ( -1293.48, 4459.81, 273 ), ( 0, 180, 0 ) ];
            newchevrons[ "axis_endzone" ][ 4 ] = [ ( -1293.48, 4392, 274 ), ( 0, 180, 0 ) ];
            newchevrons[ "axis_endzone" ][ 5 ] = [ ( -2300.19, 3725.48, 288 ), ( 0, 90, 0 ) ];
            newchevrons[ "axis_endzone" ][ 6 ] = [ ( -1700.19, 3725.48, 286 ), ( 0, 90, 0 ) ];
            newchevrons[ "axis_endzone" ][ 7 ] = [ ( -1598.19, 4348.83, 279 ), ( 0, 90, 0 ) ];
            break;
        case #"hash_a3aa6afd955c54d":
        case #"hash_8cd7282b2d63b917":
            newchevrons[ "allies_endzone" ] = [];
            newchevrons[ "allies_endzone" ][ 0 ] = [ ( 765, -1883, 23 ), ( 0, 180, 0 ) ];
            newchevrons[ "allies_endzone" ][ 1 ] = [ ( 762, -2006, 187 ), ( 0, 180, 0 ) ];
            break;
        default:
            break;
    }
    
    if ( isdefined( newchevrons[ label ] ) )
    {
        foreach ( entry in newchevrons[ label ] )
        {
            origin = entry[ 0 ];
            angles = entry[ 1 ];
            scriptable = spawnscriptable( "hardpoint_chevron", origin, angles );
            modifiedvisuals[ modifiedvisuals.size ] = scriptable;
        }
    }
    
    othervisuals = arraycombine( othervisuals, modifiedvisuals );
    return othervisuals;
}

// Namespace rugby
// Params 3
// Checksum 0x68554e43, Offset: 0x3d3f
// Size: 0x3c
function createvisualsinfo( scriptable, origin, angles )
{
    scriptable.origin = origin;
    scriptable.angles = angles;
    return scriptable;
}

// Namespace rugby
// Params 1
// Checksum 0x2ecbef26, Offset: 0x3d84
// Size: 0x8d
function setupgoalvisualsforjugg( juggplayer )
{
    juggteam = juggplayer.team;
    defendingteam = team_utility::getotherteam( juggteam );
    endzone = level.rugby.goals[ defendingteam ];
    endzone thread updatechevrons( defendingteam );
    otherendzone = level.rugby.goals[ juggteam ];
    otherendzone thread updatechevrons( "off" );
}

// Namespace rugby
// Params 1
// Checksum 0x8637b663, Offset: 0x3e19
// Size: 0x78
function watchforjuggproximityscore( team )
{
    level endon( #"game_ended" );
    self endon( #"endzone_deactivate" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", var_b075bf5fecbc413 );
        
        if ( isdefined( var_b075bf5fecbc413.rugbyjugginfo ) && var_b075bf5fecbc413.team != team )
        {
            onjuggproximityscore( var_b075bf5fecbc413 );
            return;
        }
    }
}

// Namespace rugby
// Params 1
// Checksum 0xe2257da7, Offset: 0x3e99
// Size: 0x235, Type: bool
function activatenewjuggernaut( juggplayer )
{
    globals = level.rugby;
    setupresult = setupplayerasjugg( juggplayer );
    
    if ( !setupresult )
    {
        return false;
    }
    
    jugginfo = spawnstruct();
    jugginfo.player = juggplayer;
    juggid = juggplayer getentitynumber();
    jugginfo.id = juggid;
    globals.activejuggernauts[ juggid ] = juggplayer;
    level.rugbyjugg = juggplayer;
    juggplayer.rugbyjugginfo = jugginfo;
    createobjectiveiconsforactivejugg( juggplayer, jugginfo );
    startjugghud( juggplayer );
    setupgoalvisualsforjugg( juggplayer );
    juggplayer thread watchjugghealth();
    juggplayer thread watchforjuggdeathdisconnect();
    juggplayer thread watchjuggprogress();
    juggplayer thread watchteammatesnearjugg();
    
    if ( getjuggtimeout() > 0 )
    {
        juggplayer thread watchjuggtimeout();
    }
    
    juggplayer dialog::leaderdialogonplayer( "rugby_new_jugg", "obj" );
    juggplayer thread hud_message::showsplash( "jugg_player" );
    excludelist = [ juggplayer ];
    otherteam = team_utility::getotherteam( juggplayer.team );
    dialog::statusdialog( "rugby_secured_jugg", juggplayer.team, "obj", excludelist );
    dialog::statusdialog( "rugby_lost_jugg", otherteam, "obj" );
    level thread function_d2c816f6acf3f1bc( juggplayer.team, otherteam );
    
    foreach ( player in level.players )
    {
        if ( player.team == juggplayer.team )
        {
            if ( player != juggplayer )
            {
                player thread hud_message::showsplash( "jugg_captured" );
            }
            
            continue;
        }
        
        player thread hud_message::showsplash( "jugg_lost" );
    }
    
    return true;
}

// Namespace rugby
// Params 2
// Checksum 0x6ce7f54e, Offset: 0x40d7
// Size: 0x34
function function_d2c816f6acf3f1bc( juggteam, otherteam )
{
    wait 3;
    dialog::statusdialog( "rugby_order_attack", juggteam );
    dialog::statusdialog( "rugby_order_fallback", otherteam );
}

// Namespace rugby
// Params 1
// Checksum 0x7d87ace7, Offset: 0x4113
// Size: 0x1c9
function deactivatejuggernaut( player )
{
    globals = level.rugby;
    jugginfo = player.rugbyjugginfo;
    assert( jugginfo.player == player );
    
    if ( isdefined( player ) )
    {
        player.rugbyjugginfo = undefined;
    }
    
    globals.activejuggernauts[ jugginfo.id ] = undefined;
    level.rugbyjugg = undefined;
    cleanupobjectiveiconsforjugg( player, jugginfo );
    clearjugghud();
    
    foreach ( endzone in globals.endzones )
    {
        endzone[ 0 ] thread updatechevrons( "idle" );
    }
    
    level.rugby.var_d60390bb7c77bfc3 = undefined;
    level.rugby.var_8b0a2a1508f9a07 = undefined;
    level.rugby.juggprogress = undefined;
    level.rugby.var_4b7a7c78f5f96e0b = undefined;
    
    if ( isdefined( player ) && isdefined( player.team ) )
    {
        level thread hud_message::notifyteam( "jugg_down_fr", "jugg_down_en", player.team );
    }
    else
    {
        level thread hud_message::notifyteam( "jugg_capture", "jugg_capture", "allies" );
    }
    
    setomnvar( "ui_obj_timer", 0 );
    setomnvar( "ui_obj_progress", 0 );
    player notify( #"rugby_jugg_end" );
}

// Namespace rugby
// Params 1
// Checksum 0x10c87b9b, Offset: 0x42e4
// Size: 0xc3
function startjugghud( juggplayer )
{
    setomnvar( "ui_rugby_jugg_client", juggplayer );
    setomnvar( "ui_rugby_jugg_health", 1 );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_rugby_jugg_friendly", player.team == juggplayer.team ? 0 : 1 );
    }
}

// Namespace rugby
// Params 0
// Checksum 0x7f4535e0, Offset: 0x43af
// Size: 0x8b
function clearjugghud()
{
    setomnvar( "ui_rugby_jugg_client", undefined );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_rugby_jugg_friendly", -1 );
    }
}

// Namespace rugby
// Params 0
// Checksum 0x65046520, Offset: 0x4442
// Size: 0x4c
function watchjugghealth()
{
    level endon( #"game_ended" );
    self endon( #"rugby_jugg_end" );
    
    while ( true )
    {
        self waittill( #"damage" );
        setomnvar( "ui_rugby_jugg_health", self.health / self.maxhealth );
    }
}

// Namespace rugby
// Params 0
// Checksum 0x30801512, Offset: 0x4496
// Size: 0xb8
function watchforjuggdeathdisconnect()
{
    level endon( #"game_ended" );
    self endon( #"rugby_jugg_end" );
    self waittill( #"death_or_disconnect" );
    playerpos = undefined;
    
    if ( !isdefined( self ) )
    {
        playerpos = level.lastjuggpositions[ self.rugbyjugginfo.id ];
    }
    else
    {
        playerpos = self.origin;
    }
    
    droppos = getclosestpointonnavmesh( playerpos );
    
    if ( distance( playerpos, droppos ) > 50 )
    {
        droppos = playerpos;
    }
    
    droppos = playerpos;
    activatejuggcrate( droppos + ( 0, 0, 0 ), ( 0, 0, 0 ) );
    deactivatejuggernaut( self );
}

// Namespace rugby
// Params 0
// Checksum 0x999adff9, Offset: 0x4556
// Size: 0x273
function watchjuggprogress()
{
    level endon( #"game_ended" );
    self endon( #"rugby_jugg_end" );
    juggteam = self.team;
    defendingteam = team_utility::getotherteam( juggteam );
    homegoal = level.rugby.goals[ juggteam ];
    targetgoal = level.rugby.goals[ defendingteam ];
    var_b86d84cf6ebca6b9 = targetgoal.origin - homegoal.origin;
    goaldistsq = vectordot( var_b86d84cf6ebca6b9, var_b86d84cf6ebca6b9 );
    progresscheck = undefined;
    
    while ( true )
    {
        var_abb654360a78c84f = self.origin * ( 1, 1, 0 ) - homegoal.origin * ( 1, 1, 0 );
        progress = vectordot( var_b86d84cf6ebca6b9, var_abb654360a78c84f ) / goaldistsq;
        progress = clamp( progress, 0, 1 );
        progressarray = [];
        progressarray[ juggteam ] = progress;
        progressarray[ defendingteam ] = 1 - progress;
        
        foreach ( player in level.players )
        {
            if ( player.team == juggteam || player.team == defendingteam )
            {
                player setclientomnvar( "ui_rugby_jugg_progress", progressarray[ player.team ] );
            }
        }
        
        if ( progress > 0.8 )
        {
            level thread function_a4fcca7146aa92fe( progress, juggteam, defendingteam );
        }
        
        if ( isdefined( level.rugbyjugg ) )
        {
            if ( !isdefined( progresscheck ) )
            {
                progresscheck = progress;
            }
            
            if ( progress > progresscheck + 0.1 )
            {
                progresscheck = progress;
                level.rugbyjugg thread points::doscoreevent( #"hash_9fdad7cba5ab8ddf" );
            }
        }
        
        level.lastjuggpositions[ self.rugbyjugginfo.id ] = self.origin;
        wait 0.05;
    }
}

// Namespace rugby
// Params 3
// Checksum 0xc71e711e, Offset: 0x47d1
// Size: 0x1a4
function function_a4fcca7146aa92fe( progress, juggteam, defendingteam )
{
    if ( !isdefined( level.rugby.var_d60390bb7c77bfc3 ) )
    {
        level.rugby.var_d60390bb7c77bfc3 = 1;
        level.rugby.var_8b0a2a1508f9a07 = gettime();
        level.rugby.juggprogress = progress;
        level.rugby.var_4b7a7c78f5f96e0b = progress;
    }
    else if ( isdefined( level.rugby.var_8b0a2a1508f9a07 ) && level.rugby.var_8b0a2a1508f9a07 + 30000 < gettime() )
    {
        level.rugby.var_d60390bb7c77bfc3 = 1;
        level.rugby.var_8b0a2a1508f9a07 = gettime();
        level.rugby.juggprogress = progress;
        level.rugby.var_4b7a7c78f5f96e0b = progress;
    }
    
    if ( level.rugby.var_d60390bb7c77bfc3 )
    {
        dialog::statusdialog( "rugby_friendly_close_goal", juggteam, "obj" );
        dialog::statusdialog( "rugby_enemy_close_goal", defendingteam, "obj" );
        level callback::callback( #"music_event", { #team:juggteam, #event_type:#"timelimit" } );
    }
    
    level.rugby.var_d60390bb7c77bfc3 = 0;
}

// Namespace rugby
// Params 1
// Checksum 0x76efd3a7, Offset: 0x497d
// Size: 0xcc, Type: bool
function setupplayerasjugg( player )
{
    juggconfig = level.rugby.juggconfig;
    result = player juggernaut::jugg_makejuggernaut( juggconfig );
    
    if ( !result )
    {
        return false;
    }
    
    player.droppeddeathweapon = 1;
    player givemaxammo( player.classstruct.loadoutprimaryobject );
    player.playerstreakspeedscale = getjuggspeedscalar( 0 );
    
    if ( !player common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        player common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", player.playerstreakspeedscale );
        player common::function_a6a0ecdb12c8e351( 2 );
    }
    
    player weapons::updatemovespeedscale();
    player thread handlejuggjumpspam();
    return true;
}

// Namespace rugby
// Params 0
// Checksum 0x238a79a7, Offset: 0x4a52
// Size: 0x120
function watchteammatesnearjugg()
{
    level endon( #"game_ended" );
    self endon( #"rugby_jugg_end" );
    
    while ( true )
    {
        nearbyteammates = 0;
        
        foreach ( player in level.players )
        {
            if ( player.team != self.team || player == self )
            {
                continue;
            }
            
            if ( distancesquared( player.origin, self.origin ) < 122500 )
            {
                nearbyteammates++;
            }
        }
        
        self.playerstreakspeedscale = getjuggspeedscalar( nearbyteammates );
        common::function_a0f5c85d465c5f0a( "playerStreakSpeedScale", self.playerstreakspeedscale );
        common::function_a6a0ecdb12c8e351( 2 );
        weapons::updatemovespeedscale();
        wait 0.1;
    }
}

// Namespace rugby
// Params 0
// Checksum 0x7ec9736b, Offset: 0x4b7a
// Size: 0x59
function watchjuggtimeout()
{
    level endon( #"game_ended" );
    level endon( #"hash_8ac25d40e4434da5" );
    self endon( #"rugby_jugg_end" );
    function_ddfe62c1f15de99c();
    level thread function_2cd5fa3efb6089fb( self );
    wait getjuggtimeout();
    setomnvar( "ui_obj_timer", 0 );
    setomnvar( "ui_obj_progress", 0 );
    self suicide();
}

// Namespace rugby
// Params 1
// Checksum 0x61cc2976, Offset: 0x4bdb
// Size: 0x80
function function_2cd5fa3efb6089fb( jugg )
{
    level endon( #"hash_8ac25d40e4434da5" );
    jugg endon( #"rugby_jugg_end" );
    timeoutduration = getdvarfloat( @"hash_364db51c6de274cf" );
    currentprogress = timeoutduration;
    
    while ( !level.canprocessot )
    {
        setomnvar( "ui_obj_progress", currentprogress / timeoutduration );
        currentprogress -= level.framedurationseconds;
        wait level.framedurationseconds;
    }
}

// Namespace rugby
// Params 0
// Checksum 0x26defc8b, Offset: 0x4c63
// Size: 0x10c
function handlejuggjumpspam()
{
    level endon( #"game_ended" );
    self endon( #"rugby_jugg_end" );
    self notifyonplayercommand( "jugg_jumped", "+goStand" );
    
    while ( true )
    {
        self waittill( #"jugg_jumped" );
        
        while ( !self isonground() )
        {
            waitframe();
        }
        
        oldvel = self getvelocity();
        newvel = ( oldvel[ 0 ] * 0.25, oldvel[ 1 ] * 0.25, oldvel[ 2 ] );
        self setvelocity( newvel );
        self.overrideweaponspeed_speedscale = 0.2;
        weapons::updatemovespeedscale();
        
        while ( true )
        {
            result = utility::waittill_any_timeout( 1, "jugg_jumped" );
            
            if ( result == "jugg_jumped" )
            {
                while ( !self isonground() )
                {
                    waitframe();
                }
                
                oldvel = self getvelocity();
                newvel = ( oldvel[ 0 ] * 0.25, oldvel[ 1 ] * 0.25, oldvel[ 2 ] );
                self setvelocity( newvel );
                continue;
            }
            
            break;
        }
        
        self.overrideweaponspeed_speedscale = undefined;
    }
}

// Namespace rugby
// Params 0
// Checksum 0x6cd51e44, Offset: 0x4d77
// Size: 0x38
function function_8dd4665fd7399700()
{
    reservedobjid = 0;
    level.var_aa7b0b9e5fe80a79 = spawnstruct();
    level.var_aa7b0b9e5fe80a79.objidnum = objidpoolmanager::requestreservedid( reservedobjid );
}

// Namespace rugby
// Params 2
// Checksum 0x722c22d9, Offset: 0x4db7
// Size: 0x67
function createobjectiveiconsforactivejugg( juggplayer, jugginfo )
{
    createjuggobjective( juggplayer, jugginfo );
    defendingteam = team_utility::getotherteam( juggplayer.team );
    endzone = level.rugby.goals[ defendingteam ];
    createendzoneobjective( endzone, defendingteam, jugginfo );
}

// Namespace rugby
// Params 2
// Checksum 0xdfa294a, Offset: 0x4e26
// Size: 0x34
function cleanupobjectiveiconsforjugg( juggplayer, jugginfo )
{
    objidpoolmanager::update_objective_state( 0, "done" );
    objidpoolmanager::returnobjectiveid( jugginfo.endzoneobjid );
}

// Namespace rugby
// Params 2
// Checksum 0x25eb4298, Offset: 0x4e62
// Size: 0xaa
function createjuggobjective( juggplayer, jugginfo )
{
    objid = 0;
    jugginfo.juggobjid = objid;
    objidpoolmanager::objective_add_objective( objid, "current", juggplayer.origin, "icon_waypoint_jugg" );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::objective_playermask_showtoall( objid );
    objidpoolmanager::update_objective_onentity( objid, juggplayer );
    objidpoolmanager::update_objective_setzoffset( objid, 90 );
    objective_setownerteam( objid, juggplayer.team );
    objective_setfriendlylabel( objid, "MP_MODE_RUGBY/JUGG_ESCORT" );
    objective_setenemylabel( objid, "MP_MODE_RUGBY/JUGG_KILL" );
}

// Namespace rugby
// Params 3
// Checksum 0x238c4bf5, Offset: 0x4f14
// Size: 0x9b
function createendzoneobjective( endzone, defendingteam, jugginfo )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    jugginfo.endzoneobjid = objid;
    objidpoolmanager::objective_add_objective( objid, "current", endzone.origin, "icon_waypoint_hq" );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::objective_playermask_showtoall( objid );
    objective_setownerteam( objid, defendingteam );
    objective_setfriendlylabel( objid, "MP_MODE_RUGBY/ENDZONE_DEFEND" );
    objective_setenemylabel( objid, "MP_MODE_RUGBY/ENDZONE_ASSAULT" );
}

// Namespace rugby
// Params 3
// Checksum 0x9043a02a, Offset: 0x4fb7
// Size: 0x95, Type: bool
function activatejuggcrate( droppos, angles, firstspawn )
{
    globals = level.rugby;
    
    if ( !isvaliddroppoint( droppos ) )
    {
        droppos = level.var_4e8801624be15e3b;
        angles = level.var_11d9256ea155e7c8;
    }
    
    newcrate = createjuggcrate( droppos, angles, firstspawn );
    globals.activejuggcrates[ 0 ] = newcrate;
    globals.activejuggcrates[ 0 ].crateid = newcrate;
    return true;
}

// Namespace rugby
// Params 1
// Checksum 0x77b53cc8, Offset: 0x5055
// Size: 0x9a
function isvaliddroppoint( droppos )
{
    validdroppoint = 1;
    
    foreach ( trigger in level.var_707a164c7102402f )
    {
        if ( ispointinvolume( droppos, trigger ) )
        {
            validdroppoint = 0;
            break;
        }
    }
    
    return validdroppoint;
}

// Namespace rugby
// Params 3
// Checksum 0x35776729, Offset: 0x50f8
// Size: 0x1ce
function createjuggcrate( droppos, angles, firstspawn )
{
    groundpos = getgroundposition( droppos, 8, 2000, 32 );
    groundpos += ( 0, 0, 5 );
    crate = spawn( "script_model", groundpos );
    crate.angles = angles;
    crate.visuals = [ crate ];
    crate.trigger = crate;
    crate.trigger.origin = crate.origin;
    crate.curorigin = crate.trigger.origin;
    crate.safeorigin = crate.trigger.origin;
    crate.visuals[ 0 ] setmodel( "military_crate_large_stackable_01_jugg" );
    crate thread juggcratemanageuse( crate );
    crate thread gameobjects::setdropped( undefined, undefined, 1 );
    crate.crateid = crate getentitynumber();
    
    if ( firstspawn )
    {
        level.var_4e8801624be15e3b = droppos;
        level.var_11d9256ea155e7c8 = angles;
        
        foreach ( team in level.teamnamelist )
        {
            dialog::statusdialog( "rugby_capture_jugg", team, "obj" );
        }
    }
    
    return crate;
}

// Namespace rugby
// Params 0
// Checksum 0x32458c64, Offset: 0x52cf
// Size: 0xc5
function gunkillerhackthread()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        dropped_weapons = getweaponarray();
        
        foreach ( droppeditem in dropped_weapons )
        {
            if ( distance2dsquared( droppeditem.origin, self.origin ) < 40000 )
            {
                droppeditem delete();
            }
        }
        
        wait 0.25;
    }
}

// Namespace rugby
// Params 1
// Checksum 0x12cc5122, Offset: 0x539c
// Size: 0x590
function juggcratemanageuse( crate )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    useent = spawn( "script_model", self.origin + ( 0, 0, 30 ) );
    useent.usetype = 1;
    useent.destination = self.origin + ( 0, 0, 30 );
    useent.isuseobject = 1;
    self.useent = gameobjects::createholduseobject( "neutral", useent, self.visuals, ( 0, 0, 64 ) );
    
    foreach ( team in level.teamnamelist )
    {
        self.useent.teamprogress = undefined;
    }
    
    self.useent.trigger.var_6cb27191eb565540 = 16900;
    self.useent.trigger makeusable();
    self.useent.trigger setuserange( 130 );
    self.useent.trigger sethintstring( &"mp_mode_rugby/crate_use" );
    self.useent.trigger setcursorhint( "HINT_BUTTON" );
    self.useent.trigger setuseholdduration( "duration_none" );
    self.useent.trigger setusehideprogressbar( 1 );
    self.useent.trigger setusepriority( -4 );
    self.useent.trigger sethintonobstruction( "hide" );
    self.useent gameobjects::setusetime( function_5a3184d680092b8b() );
    self.useent.interactteam = "any";
    self.useent.curprogress = 0;
    self.useent.defaultusetime = self.useent.usetim;
    self.useent.userate = 1;
    self.useent.id = "rugby_jugg";
    self.useent.exclusiveuse = 0;
    self.useent.exclusiveclaim = 0;
    self.useent.skiptouching = 1;
    self.useent.onbeginuse = &function_6ea08fec5cab8c70;
    self.useent.onuse = &function_f0fef36eaec3a16f;
    self.useent.onenduse = &function_20e231b637a22e3c;
    self.useent.oncantuse = &function_8a42f81954de557a;
    self.useent.inuse = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        self.useent.numtouching[ entry ] = 0;
        self.useent.touchlist[ entry ] = [];
    }
    
    self.useent.cancontestclaim = 0;
    self.useent.stalemate = 0;
    self.useent.wasstalemate = 0;
    self.useent.cancontestclaim = 0;
    self.useent.majoritycapprogress = 1;
    self.useent.wasmajoritycapprogress = 0;
    self.useent.resetprogress = 1;
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level utility::waittill_any( "prematch_done", "start_mode_setup" );
    }
    
    self.useent.type = "useObject";
    self.useent.offset3d = ( 0, 0, 32 );
    self.useent gameobjects::requestid( 1, 1 );
    self.useent gameobjects::setobjectivestatusicons( "icon_waypoint_jugg_crate" );
    self.useent gameobjects::setvisibleteam( "any" );
    objidpoolmanager::objective_set_play_intro( self.useent.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( self.useent.objidnum, 0 );
}

// Namespace rugby
// Params 1
// Checksum 0x906c074c, Offset: 0x5934
// Size: 0x4e
function function_6ea08fec5cab8c70( player )
{
    gameobjects::setobjectivestatusicons( "icon_waypoint_taking", "icon_waypoint_losing" );
    dialog::statusdialog( "rugby_securing_jugg", player.team, "obj" );
    self.visuals[ 0 ] playloopsound( "mp_care_package_non_owner_cap" );
}

// Namespace rugby
// Params 1
// Checksum 0x4323e4ff, Offset: 0x598a
// Size: 0x11a
function function_f0fef36eaec3a16f( player )
{
    var_758a4e477eb02691 = activatenewjuggernaut( player );
    
    if ( !var_758a4e477eb02691 )
    {
        return;
    }
    
    juggcratecleanup();
    level.rugby.activejuggcrates[ 0 ].crateid = undefined;
    level.rugby.activejuggcrates[ 0 ] = undefined;
    
    if ( isdefined( self.useent ) )
    {
        self.useent delete();
    }
    
    if ( isdefined( self.visuals ) )
    {
        foreach ( visual in self.visuals )
        {
            visual delete();
        }
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
}

// Namespace rugby
// Params 3
// Checksum 0xbdda79fd, Offset: 0x5aac
// Size: 0xc0
function function_20e231b637a22e3c( team, player, result )
{
    self.visuals[ 0 ] stoploopsound( "mp_care_package_non_owner_cap" );
    
    if ( !result )
    {
        gameobjects::setobjectivestatusicons( "icon_waypoint_jugg_crate" );
    }
    
    objidpoolmanager::objective_set_progress_team( self.objidnum, player.team );
    objidpoolmanager::objective_set_progress( self.objidnum, self.curprogress / self.usetime );
    
    if ( self.curprogress > 0 )
    {
        objidpoolmanager::objective_show_team_progress( self.objidnum, player.team );
        return;
    }
    
    objidpoolmanager::objective_show_progress( self.objidnum, 0 );
}

// Namespace rugby
// Params 1
// Checksum 0x8d75b849, Offset: 0x5b74
// Size: 0xc
function function_8a42f81954de557a( player )
{
    
}

// Namespace rugby
// Params 0
// Checksum 0xeb471bc6, Offset: 0x5b88
// Size: 0x12
function juggcratecleanup()
{
    objidpoolmanager::returnobjectiveid( self.objidnum );
}

// Namespace rugby
// Params 1
// Checksum 0x83b08a14, Offset: 0x5ba2
// Size: 0xb0
function createjuggcrateobjective( crate )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    crate.objid = objid;
    pos = crate.origin + ( 0, 0, 32 );
    objidpoolmanager::objective_add_objective( objid, "current", pos, "icon_waypoint_jugg" );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objidpoolmanager::objective_playermask_showtoall( objid );
    objective_setneutrallabel( objid, "MP_MODE_RUGBY/CRATE_CAPTURE" );
    objective_setfriendlylabel( objid, "MP_MODE_RUGBY/CRATE_CAPTURING" );
    objective_setenemylabel( objid, "MP_MODE_RUGBY/CRATE_LOSING" );
    updatejuggcrateobjectivestate( crate );
}

// Namespace rugby
// Params 1
// Checksum 0x59899f1a, Offset: 0x5c5a
// Size: 0x76
function updatejuggcrateobjectivestate( crate )
{
    objid = crate.objid;
    beingcaptured = istrue( crate.inuse );
    
    if ( beingcaptured )
    {
        objective_setownerteam( objid, crate.usingplayer.team );
        objective_sethot( objid, 1 );
        return;
    }
    
    objective_setownerteam( objid, undefined );
    objective_sethot( objid, 0 );
}

// Namespace rugby
// Params 1
// Checksum 0x9099fcc2, Offset: 0x5cd8
// Size: 0x7d, Type: bool
function function_3b09f98e9b44b497( player )
{
    juggconfig = level.rugby.juggconfig;
    
    if ( player.isjuggernaut )
    {
        player hud_message::showerrormessage( %"killstreaks/jugg_cannot_be_picked_up" );
        return false;
    }
    
    result = player juggernaut::function_185c3871d7f3946c( juggconfig );
    
    if ( !isdefined( result ) )
    {
        player hud_message::showerrormessage( %"killstreaks/jugg_cannot_become" );
        return false;
    }
    
    return true;
}

// Namespace rugby
// Params 1
// Checksum 0x67fe19df, Offset: 0x5d5e
// Size: 0x229
function updateoverheadcamerapos( initialsetupteam )
{
    if ( isdefined( initialsetupteam ) )
    {
        team = initialsetupteam;
        camstruct = level.spectatorcameras[ 0 ][ team ];
    }
    else
    {
        team = self.team;
        camstruct = level.spectatorcameras[ 0 ][ self.team ];
    }
    
    globals = level.rugby;
    side = undefined;
    
    if ( !game[ "switchedsides" ] )
    {
        side = team;
    }
    else
    {
        side = team == "allies" ? "axis" : "allies";
    }
    
    otherside = side == "allies" ? "axis" : "allies";
    var_7b12b0c9198481d6 = globals.endzones[ side ][ 0 ].origin;
    var_a57914d6fae11685 = globals.endzones[ otherside ][ 0 ].origin;
    var_fcfd42c7cb27f582 = ( var_a57914d6fae11685 - var_7b12b0c9198481d6 ) * ( 1, 1, 0 );
    var_eb688f55b1cec708 = length2d( var_fcfd42c7cb27f582 );
    heightent = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( heightent ) )
    {
        camheight = heightent.origin[ 2 ];
    }
    else
    {
        camheight = 5000;
    }
    
    campos = undefined;
    looktargetpos = undefined;
    
    if ( doesteamhaveactivejugg( team ) )
    {
        juggpos = getjuggorcratepos();
        campos = juggpos + var_fcfd42c7cb27f582 * -3000 / var_eb688f55b1cec708;
        campos = ( campos[ 0 ], campos[ 1 ], camheight );
        looktargetpos = juggpos + ( var_a57914d6fae11685 - juggpos ) * 0.5;
    }
    else
    {
        campos = var_7b12b0c9198481d6 + var_fcfd42c7cb27f582 * -2000 / var_eb688f55b1cec708;
        campos = ( campos[ 0 ], campos[ 1 ], camheight );
        looktargetpos = getjuggorcratepos();
    }
    
    lookdir = looktargetpos - campos;
    camangles = vectortoangles( lookdir );
    camstruct.origin = campos;
    camstruct.angles = camangles;
}

// Namespace rugby
// Params 0
// Checksum 0xf7bd331f, Offset: 0x5f8f
// Size: 0x11a
function startspectatorview()
{
    lower_message::setlowermessageomnvar( 0 );
    waitframe();
    player::updatesessionstate( "spectator" );
    spectating::setdisabled();
    
    if ( isdefined( self.lastdeathangles ) )
    {
        self setplayerangles( self.lastdeathangles );
    }
    
    wait 0.1;
    player::setdof_default();
    updateoverheadcamerapos();
    var_d373db18173300a2 = level.spectatorcameras[ 0 ][ self.team ];
    var_b371bf092c77fda3 = var_d373db18173300a2.origin;
    var_9149918291092f13 = var_d373db18173300a2.angles;
    self.deathspectatepos = var_b371bf092c77fda3;
    self.deathspectateangles = var_9149918291092f13;
    cameraent = spawn( "script_model", self getvieworigin() );
    cameraent setmodel( "tag_origin" );
    cameraent.angles = var_9149918291092f13;
    self.spectatorcament = cameraent;
    self.isusingtacopsmapcamera = 1;
    self cameralinkto( cameraent, "tag_origin", 1 );
    thread dohalfwayflash();
    cameraent movecameratomappos( self, var_b371bf092c77fda3, var_9149918291092f13 );
}

// Namespace rugby
// Params 0
// Checksum 0xe4fb041f, Offset: 0x60b1
// Size: 0x16
function dohalfwayflash()
{
    wait 0.4;
    thread playslamzoomflash();
    applythermal();
}

// Namespace rugby
// Params 0
// Checksum 0x90e38894, Offset: 0x60cf
// Size: 0x26
function endspectatorview()
{
    if ( !isdefined( self.spectatorcament ) )
    {
        return;
    }
    
    removethermal();
    removeplayeroutlinesforoverheadcam();
    thread runslamzoomonspawn();
}

// Namespace rugby
// Params 0
// Checksum 0x18f85749, Offset: 0x60fd
// Size: 0x13
function applythermal()
{
    self visionsetthermalforplayer( "proto_apache_flir_mp" );
    self thermalvisionon();
}

// Namespace rugby
// Params 0
// Checksum 0x3347407a, Offset: 0x6118
// Size: 0x8
function removethermal()
{
    self thermalvisionoff();
}

// Namespace rugby
// Params 3
// Checksum 0xb4a7c61e, Offset: 0x6128
// Size: 0xef
function movecameratomappos( player, var_9956298e86821c5a, finalangles )
{
    player endon( #"spawned_player" );
    self moveto( var_9956298e86821c5a, 1, 0.5, 0.5 );
    player playlocalsound( "mp_cmd_camera_zoom_out" );
    player setclienttriggeraudiozonepartialwithfade( "spawn_cam", 0.5, "mix" );
    self rotateto( finalangles, 1, 0.5, 0.5 );
    wait 1.1;
    driftoffset = anglestoforward( finalangles ) * 300;
    driftoffset *= ( 1, 1, 0 );
    
    if ( isdefined( player ) && isdefined( player.spectatorcament ) )
    {
        self moveto( var_9956298e86821c5a + driftoffset, 15, 1, 1 );
        player earthquakeforplayer( 0.03, 15, var_9956298e86821c5a + driftoffset, 1000 );
    }
}

// Namespace rugby
// Params 0
// Checksum 0x62a0a2ce, Offset: 0x621f
// Size: 0xe9
function runslamzoomonspawn()
{
    self waittill( #"spawned_player" );
    targetpos = self geteye();
    targetangles = self.angles;
    player::updatesessionstate( "spectator" );
    self cameralinkto( self.spectatorcament, "tag_origin", 1 );
    self visionsetnakedforplayer( "tac_ops_slamzoom", 0.2 );
    self.spectatorcament moveto( targetpos, 0.5 );
    self playlocalsound( "mp_cmd_camera_zoom_in" );
    self clearclienttriggeraudiozone( 0.5 );
    self.spectatorcament rotateto( targetangles, 0.5, 0.5 );
    wait 0.5;
    self visionsetnakedforplayer( "", 0 );
    thread playslamzoomflash();
    player::updatesessionstate( "playing" );
    self cameraunlink();
    self.spectatorcament delete();
    wait 1;
}

// Namespace rugby
// Params 0
// Checksum 0x423f6e66, Offset: 0x6310
// Size: 0xd7
function playslamzoomflash()
{
    overlay = newclienthudelem( self );
    overlay.x = 0;
    overlay.y = 0;
    overlay.alignx = "left";
    overlay.aligny = "top";
    overlay.sort = 1;
    overlay.horzalign = "fullscreen";
    overlay.vertalign = "fullscreen";
    overlay.alpha = 1;
    overlay.foreground = 1;
    overlay setshader( "white", 640, 480 );
    overlay fadeovertime( 0.4 );
    overlay.alpha = 0;
    wait 0.4;
    overlay destroy();
}

// Namespace rugby
// Params 0
// Checksum 0x387fee03, Offset: 0x63ef
// Size: 0xdd
function enableplayeroutlinesforoverheadcam()
{
    self.rugbyoverheadoutlines = [];
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        hudoutlineasset = player.team == self.team ? "outlinefill_nodepth_cyan" : "outlinefill_nodepth_orange";
        outlineid = outline::outlineenableforplayer( player, self, hudoutlineasset, "level_script" );
        self.rugbyoverheadoutlines[ outlineid ] = player;
    }
}

// Namespace rugby
// Params 0
// Checksum 0xd75952fd, Offset: 0x64d4
// Size: 0x93
function removeplayeroutlinesforoverheadcam()
{
    if ( isdefined( self.rugbyoverheadoutlines ) )
    {
        foreach ( id, player in self.rugbyoverheadoutlines )
        {
            outline::outlinedisable( id, player );
        }
        
        self.rugbyoverheadoutlines = undefined;
    }
}

// Namespace rugby
// Params 0
// Checksum 0x9b2a9542, Offset: 0x656f
// Size: 0xcf
function setupwaypointicons()
{
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_jugg_crate", 0, "neutral", "MP_MODE_RUGBY/CRATE_CAPTURE", "icon_waypoint_jugg", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_jugg", 1, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_jugg", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_jugg", 1, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_jugg", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_hq_defend", 0, "friendly", "MP_MODE_RUGBY/ENDZONE_DEFEND", "icon_waypoint_hq", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_hq_attack", 0, "enemy", "MP_MODE_RUGBY/ENDZONE_ASSAULT", "icon_waypoint_hq", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_jugg", 0 );
    gamelogic_mp::setwaypointiconinfo( "icon_waypoint_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_jugg", 0 );
}

/#

    // Namespace rugby
    // Params 0
    // Checksum 0xa1d1024c, Offset: 0x6646
    // Size: 0x156, Type: dev
    function function_ac2fec6cd66db9c5()
    {
        while ( true )
        {
            globals = level.rugby;
            
            if ( getdvarint( @"hash_ccb2ab4c50c032d2", 0 ) == 1 )
            {
                setdvar( @"hash_ccb2ab4c50c032d2", 0 );
                
                foreach ( crate in globals.activejuggcrates )
                {
                    crateused = 0;
                    
                    foreach ( player in level.players )
                    {
                        if ( isai( player ) )
                        {
                            crate function_f0fef36eaec3a16f( player );
                            crateused = 1;
                            break;
                        }
                    }
                    
                    if ( crateused )
                    {
                        break;
                    }
                }
            }
            
            wait 0.2;
        }
    }

#/
