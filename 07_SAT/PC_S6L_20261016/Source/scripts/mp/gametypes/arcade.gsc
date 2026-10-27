// scripts\mp\gametypes\arcade.gsc  (hash_43f25c843cf0ae72.gscc) (size: 9753 Bytes / 0x2619 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6c88fe2a (1820917290)
// size ...... 9753 (0x2619)
// includes .. 13  (offset: 0x21d9)
// strings ... 62  (offset: 0x2241)
// dev strs .. 4   (offset: 0x25dd)
// exports ... 20  (offset: 0x153d)
// cseg ...... 0x52d + 0x1010 (0x153d)
// imports ... 81  (offset: 0x185d)
// animtree1 . 0   (offset: 0x2619)
// animtree2 . 0   (offset: 0x2619)
#using scripts\common\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\class;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\spawnlogic;

#namespace arcade;

// Namespace arcade
// Params 0
// Checksum 0x546656f3, Offset: 0x54b
// Size: 0x163
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.teambased = 1;
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.onnormaldeath = &onnormaldeath;
    level.modeonspawnplayer = &onspawnplayer;
    level.denyclasschoice = 1;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    function_b09d5cc18cbe7e20();
    setdvar( @"r_identifyoldmaterial", 0 );
    setdvar( @"scr_starsystem", 0 );
    ai_mp_controller::init();
    level.supportsai = 1;
    game[ "dialog" ][ "gametype" ] = "iw9_mtdm_mode_uktl_name";
    game[ "dialog" ][ "boost" ] = "iw9_mtdm_mode_uktl_bost";
    game[ "dialog" ][ "offense_obj" ] = "iw9_mtdm_mode_uktl_bost";
    game[ "dialog" ][ "defense_obj" ] = "iw9_mtdm_mode_uktl_bost";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        level.shouldgamelobbyremainintact = &shouldgamelobbyremainintact;
    }
}

// Namespace arcade
// Params 0, eflags: 0x4
// Checksum 0x440c9744, Offset: 0x6b6
// Size: 0x245
function private function_b09d5cc18cbe7e20()
{
    assert( !isdefined( level.aonloadout ), "<dev string:x24>" );
    level.aonloadout = [];
    level.aonloadout[ "loadoutArchetype" ] = "archetype_assault";
    level.aonloadout[ "loadoutPrimary" ] = "iw9_me_knife_mp";
    level.aonloadout[ "loadoutPrimaryAttachment" ] = "none";
    level.aonloadout[ "loadoutPrimaryAttachment2" ] = "none";
    level.aonloadout[ "loadoutPrimaryCamo" ] = "none";
    level.aonloadout[ "loadoutPrimaryReticle" ] = "none";
    level.aonloadout[ "loadoutPrimaryVariantID" ] = 0;
    level.aonloadout[ "loadoutSecondary" ] = "iw9_pi_golf17_mp";
    level.aonloadout[ "loadoutSecondaryAttachment" ] = "none";
    level.aonloadout[ "loadoutSecondaryAttachment2" ] = "none";
    level.aonloadout[ "loadoutSecondaryCamo" ] = "none";
    level.aonloadout[ "loadoutSecondaryReticle" ] = "none";
    level.aonloadout[ "loadoutSecondaryVariantID" ] = 0;
    level.aonloadout[ "loadoutEquipmentPrimary" ] = "equip_throwing_knife";
    level.aonloadout[ "loadoutEquipmentSecondary" ] = "none";
    level.aonloadout[ "loadoutSuper" ] = "none";
    level.aonloadout[ "loadoutStreakType" ] = "assault";
    level.aonloadout[ "loadoutKillstreak1" ] = "none";
    level.aonloadout[ "loadoutKillstreak2" ] = "none";
    level.aonloadout[ "loadoutKillstreak3" ] = "none";
    level.aonloadout[ "loadoutUsingSpecialist" ] = 1;
    level.aonloadout[ "loadoutPerks" ] = [ "specialty_null" ];
    level.aonloadout[ "loadoutExtraPerks" ] = [ "specialty_null" ];
    level.aonloadout[ "loadoutGesture" ] = "playerData";
    level.aonloadout[ "loadoutFieldUpgrade1" ] = "none";
    level.aonloadout[ "loadoutFieldUpgrade2" ] = "none";
}

// Namespace arcade
// Params 1
// Checksum 0xe9b0e4c9, Offset: 0x903
// Size: 0x11a
function spawn_aliens( player )
{
    player endon( #"death" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        wait 2;
        team = player.pers[ "team" ];
        
        if ( !isdefined( team ) )
        {
            continue;
        }
        
        ai_team = team_utility::getotherteam( team );
        
        if ( !isdefined( ai_team ) )
        {
            continue;
        }
        
        safeorigin = function_1205d294fa348341();
        
        if ( abs( safeorigin[ 2 ] - level.player.origin[ 2 ] ) > 90 )
        {
            wait 1;
            continue;
        }
        
        angles = utility::flat_angle( vectortoangles( safeorigin - level.player.origin ) );
        ai = ai_mp_controller::ai_mp_requestspawnagent( "jup_enemy_mp_arcade_alien_01", safeorigin, ( 0, randomint( 360 ), 0 ), "high", "everybody", undefined, undefined, ai_team );
        
        if ( isagent( ai ) )
        {
            ai thread find_player();
        }
    }
}

// Namespace arcade
// Params 0
// Checksum 0x9918d4d7, Offset: 0xa25
// Size: 0xd7
function find_player()
{
    ai = self;
    ai endon( #"death" );
    
    while ( true )
    {
        ai setgoalpos( getclosestpointonnavmesh( level.player.origin ), 16 );
        ai.var_bfaca72bb0e74c38 = 0;
        ai.goalradius = 16;
        ai.stealth_enabled = 0;
        ai.pathenemyfightdist = 0;
        ai.noragdoll = 1;
        ai.script_noragdoll = 1;
        ai.liveragdoll = 0;
        
        if ( distance( ai.origin, level.player.origin ) < 140 )
        {
            ai kill();
        }
        
        wait 0.2;
    }
}

// Namespace arcade
// Params 0
// Checksum 0xcd32d6da, Offset: 0xb04
// Size: 0x74
function function_1205d294fa348341()
{
    dist = 1600;
    x = randomint( dist ) * pow( -1, randomint( 2 ) );
    y = randomint( dist ) * pow( -1, randomint( 2 ) );
    safeorigin = getclosestpointonnavmesh( level.player.origin + ( x, y, 0 ) );
    return safeorigin;
}

// Namespace arcade
// Params 0
// Checksum 0x8e9fded6, Offset: 0xb81
// Size: 0x18
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_war_promode", 0 );
}

// Namespace arcade
// Params 0
// Checksum 0xa434275, Offset: 0xba1
// Size: 0x15e
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/war" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/war_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/war_hint" );
    }
    
    if ( isdefined( level.initspawnsoverridefunc ) )
    {
        [[ level.initspawnsoverridefunc ]]();
    }
    else
    {
        initspawns();
    }
    
    bradley_spawner::inittankspawns();
    
    /#
        if ( false )
        {
            function_3d2f6adc4704da26();
        }
    #/
}

// Namespace arcade
// Params 0
// Checksum 0xf19820fb, Offset: 0xd07
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace arcade
// Params 0
// Checksum 0x41d1e3d4, Offset: 0xd18
// Size: 0x159
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_allies_start" );
    spawnlogic::addstartspawnpoints( "mp_tdm_spawn_axis_start" );
    spawnlogic::addspawnpointslegacy( game[ "attackers" ], "mp_tdm_spawn_allies_start" );
    spawnlogic::addspawnpointslegacy( game[ "defenders" ], "mp_tdm_spawn_axis_start" );
    attackers = spawnlogic::getspawnpointarray( "mp_tdm_spawn_allies_start" );
    defenders = spawnlogic::getspawnpointarray( "mp_tdm_spawn_axis_start" );
    spawnlogic::registerspawnset( #"start_attackers", attackers );
    spawnlogic::registerspawnset( #"start_defenders", defenders );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn" );
    spawnlogic::addspawnpointslegacy( "allies", "mp_tdm_spawn_secondary", 1, 1 );
    spawnlogic::addspawnpointslegacy( "axis", "mp_tdm_spawn_secondary", 1, 1 );
    spawns = spawnlogic::getspawnpointarray( "mp_tdm_spawn" );
    spawnssecondary = spawnlogic::getspawnpointarray( "mp_tdm_spawn_secondary" );
    spawnlogic::registerspawnset( #"primary", spawns );
    spawnlogic::registerspawnset( #"fallback", spawnssecondary );
    spawnlogic::finalizemap();
}

// Namespace arcade
// Params 0
// Checksum 0xe866af8f, Offset: 0xe79
// Size: 0xd4
function getspawnpoint()
{
    spawnteam = self.pers[ "team" ];
    spawnpoint = undefined;
    
    if ( spawnlogic::shoulduseteamstartspawn() )
    {
        if ( spawnteam == game[ "attackers" ] )
        {
            spawnlogic::activatespawnset( #"start_attackers", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_attackers" );
        }
        else
        {
            spawnlogic::activatespawnset( #"start_defenders", 1 );
            spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"start_defenders" );
        }
    }
    else
    {
        spawnlogic::activatespawnset( #"primary", 1 );
        spawnpoint = spawnlogic::getspawnpointlegacy( self, spawnteam, undefined, #"fallback" );
    }
    
    spawnpoint.angles = ( 0, 0, 0 );
    return spawnpoint;
}

// Namespace arcade
// Params 1
// Checksum 0x97e92086, Offset: 0xf56
// Size: 0x2c
function onspawnplayer( revivespawn )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    thread function_88391f7a651fff17();
    level thread spawn_aliens( self );
}

// Namespace arcade
// Params 0
// Checksum 0xe5959bca, Offset: 0xf8a
// Size: 0x99
function function_88391f7a651fff17()
{
    upposition = self.origin + ( 0, 0, 500 );
    cament = spawn( "script_model", upposition );
    cament setmodel( "tag_origin" );
    cament.angles = vectortoangles( self.origin - upposition );
    self cameralinkto( cament, "tag_origin" );
    cament linkto( self );
    self freezelookcontrols( 1 );
    self.plotarmor = 1;
    self setmovespeedscale( 3 );
    thread run_barrels();
}

// Namespace arcade
// Params 0
// Checksum 0xbb1fd69e, Offset: 0x102b
// Size: 0x101
function run_barrels()
{
    dist = 64;
    num = 3;
    baseangle = 360 / num;
    
    if ( self.arcade_barrels )
    {
        return;
    }
    
    self.arcade_barrels = 1;
    ent = spawn( "script_model", self.origin );
    ent setmodel( "tag_origin" );
    ent thread alwaysrotate();
    ent thread followplayer( self );
    
    for ( i = 0; i < num ; i++ )
    {
        angle = i * baseangle;
        offsetx = dist * cos( angle );
        offsety = dist * sin( angle );
        model = spawn( "script_model", self.origin + ( offsetx, offsety, 0 ) );
        model setmodel( "me_decor_barrels_01_yellow_black_01" );
        model linkto( ent );
    }
}

// Namespace arcade
// Params 0
// Checksum 0xd26bcb6, Offset: 0x1134
// Size: 0x3d
function alwaysrotate()
{
    while ( true )
    {
        self rotateyaw( 360, 3 );
        wait 3;
        level.player setclientomnvar( "ui_hide_hud", 1 );
        level.player thread dropgrenade();
    }
}

// Namespace arcade
// Params 0
// Checksum 0x96787012, Offset: 0x1179
// Size: 0x63
function dropgrenade()
{
    gren = magicgrenademanual( "frag_grenade_mp", level.player.origin + ( 0, 0, 9 ), ( randomint( 30 ) - 30, randomint( 30 ) - 30, 45 ) );
    wait 0.75;
    gren detonate( level.player );
}

// Namespace arcade
// Params 1
// Checksum 0xd66e7bd7, Offset: 0x11e4
// Size: 0x29
function followplayer( player )
{
    while ( true )
    {
        self.origin = player.origin;
        waitframe();
    }
}

// Namespace arcade
// Params 6
// Checksum 0x65fca587, Offset: 0x1215
// Size: 0x48
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
}

/#

    // Namespace arcade
    // Params 0
    // Checksum 0x1f51232b, Offset: 0x1265
    // Size: 0x282, Type: dev
    function function_3d2f6adc4704da26()
    {
        wait 5;
        ents = getentarray( "<dev string:x4e>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        ents = getentarray( "<dev string:x59>", #script_noteworthy );
        
        foreach ( ent in ents )
        {
            thread debug::drawsphere( ent.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x4e>", "<dev string:x6c>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
        
        structs = utility::getstructarray( "<dev string:x59>", "<dev string:x6c>" );
        
        foreach ( struct in structs )
        {
            thread debug::drawsphere( struct.origin, 64, 1000, ( 0, 1, 0 ) );
        }
    }

#/

// Namespace arcade
// Params 0
// Checksum 0xafa034c6, Offset: 0x14ef
// Size: 0x4d, Type: bool
function shouldgamelobbyremainintact()
{
    axisscore = int( game[ "teamScores" ][ "axis" ] );
    alliesscore = int( game[ "teamScores" ][ "allies" ] );
    differential = axisscore - alliesscore;
    return differential < 10;
}

