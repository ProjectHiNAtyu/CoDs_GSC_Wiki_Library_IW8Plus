// scripts\mp\gametypes\freeze.gsc  (hash_6d5ed2f75337b699.gscc) (size: 26308 Bytes / 0x66c4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47ea2b8d (1206528909)
// size ...... 26308 (0x66c4)
// includes .. 38  (offset: 0x5f1c)
// strings ... 100 (offset: 0x604c)
// dev strs .. 11  (offset: 0x663c)
// exports ... 64  (offset: 0x3c0c)
// cseg ...... 0x729 + 0x34e3 (0x3c0c)
// imports ... 208 (offset: 0x460c)
// animtree1 . 0   (offset: 0x66c4)
// animtree2 . 0   (offset: 0x66c4)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\scene;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\laststand;
#using scripts\mp\matchdata;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;

#namespace freeze;

// Namespace freeze
// Params 0
// Checksum 0x5533269b, Offset: 0x747
// Size: 0x289
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
    function_886a8155bd8b21ff();
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"player_death", &onplayerkilled );
    callback::add( #"player_laststand", &function_56d032002a8c9cd5 );
    callback::add( #"player_laststand_exit", &function_42124fad3bc1e3ed );
    callback::add( #"player_laststand_set_revive_progress", &function_459ac2ccb8704bd4 );
    callback::add( #"hash_5e4c0033a7bbd7f", &function_239a5e71567f97c8 );
    callback::add( #"game_ended", &ongameended );
    callback::add( #"hash_57a74c8771bf7e7", &function_4fa517f73b52c1e );
    level.var_c1ccd70f708422ff = level.gametypebundle.var_c1ccd70f708422ff ?? #"hash_118ea642a587cbe0";
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.objectivebased = 1;
    level.var_1006ea76c66f444 = 1;
    level.var_5195f9fa56bdff5 = 1;
    level.var_2acb9af1663be697 = 0;
    level.var_5026f1e2b78e3e22 = 1;
    level.var_916645300fa04eec = 1;
    level.var_3df1794b22c65c8a = &function_a85c2256f4732ae2;
    level.onstartgametype = &onstartgametype;
    level.updatealiveomnvars = &function_56714580aa4702f7;
    level.getspawnpoint = &getspawnpoint;
    level.onmaprestart = &freeze_onmaprestart;
    level.onnormaldeath = &onnormaldeath;
    level.ononeleftevent = &freeze_ononeleftevent;
    level.disablespawningforplayerfunc = &function_51617fd884afe12f;
    level.modelaststandallowed = &modelaststandallowed;
    level.var_a396a2687c46a7e8 = &onfriendlyfire;
    level.var_d4edfe6f6b2f654b = &function_125800b6fe5855db;
    level.var_43618bb5c38bef6e = &function_1fd96ce646ded7ea;
    
    if ( level.numteamlives != 0 )
    {
        level.ontimelimit = &freeze_ontimelimit;
        level.var_7b18d7f69313853a = 1;
        game[ "canScoreOnTie" ] = 1;
    }
}

// Namespace freeze
// Params 0
// Checksum 0xa0dc20d1, Offset: 0x9d8
// Size: 0x37
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    level.numteamlives = getmatchrulesdata( "controlData", "numTeamLives" );
    level.suicideteamkilllowerslives = getmatchrulesdata( "controlData", "suicideTeamKillLowersLives" );
}

// Namespace freeze
// Params 0
// Checksum 0xea71c9c5, Offset: 0xa17
// Size: 0x38b
function function_886a8155bd8b21ff()
{
    if ( isdefined( game[ #"freeze" ] ) )
    {
        return;
    }
    
    game[ #"freeze" ] = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_freeze" );
    
    if ( !isdefined( game[ #"freeze" ].var_9659ae043f0b7f14 ) )
    {
        game[ #"freeze" ].var_9659ae043f0b7f14 = 300;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_c3a38f859c9e98e3 ) )
    {
        game[ #"freeze" ].var_c3a38f859c9e98e3 = 200;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_68f7dbc5de2e232f ) )
    {
        game[ #"freeze" ].var_68f7dbc5de2e232f = 100;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_a82a4706453d6963 ) )
    {
        game[ #"freeze" ].var_a82a4706453d6963 = 15;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_7ac608b18a1ce6ef ) )
    {
        game[ #"freeze" ].var_7ac608b18a1ce6ef = 200;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_7f27bb37e0af89a9 ) )
    {
        game[ #"freeze" ].var_7f27bb37e0af89a9 = 200;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_cd6b535db9c8c3b ) )
    {
        game[ #"freeze" ].var_cd6b535db9c8c3b = 200;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_1496d1531a29a012 ) )
    {
        game[ #"freeze" ].var_1496d1531a29a012 = 200;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_4f8f858f2fa005f9 ) )
    {
        game[ #"freeze" ].var_4f8f858f2fa005f9 = 1;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_6c9186872477220d ) )
    {
        game[ #"freeze" ].var_6c9186872477220d = 1;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_ff5ecc7ceac7a579 ) )
    {
        game[ #"freeze" ].var_ff5ecc7ceac7a579 = 1;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_8e2851103b39827e ) )
    {
        game[ #"freeze" ].var_8e2851103b39827e = 0;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_2094b4ae447ef7c0 ) )
    {
        game[ #"freeze" ].var_2094b4ae447ef7c0 = 0;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_77f1c8a2aa5fa2dd ) )
    {
        game[ #"freeze" ].var_77f1c8a2aa5fa2dd = 0;
    }
    
    if ( !isdefined( game[ #"freeze" ].var_4b2be02c26b9a273 ) )
    {
        game[ #"freeze" ].var_4b2be02c26b9a273 = getdvarint( @"hash_33725b36d41a7400", 0 );
    }
    
    if ( !isdefined( game[ #"freeze" ].var_97068378621014fe ) )
    {
        game[ #"freeze" ].var_97068378621014fe = 1;
    }
    
    level.var_55e4db63d87c12c1 = 0;
    level.var_92b9a0cbf749d8c6 = game[ #"freeze" ].var_7ac608b18a1ce6ef;
    level.laststandrevivedecayscale = 0;
    level.defaultmaxhealth = int( getmatchrulesdata( "commonOption", "maxHealth" ) );
    level.var_efa66bf4df7d06c3 = 1;
}

// Namespace freeze
// Params 0
// Checksum 0x8bd5ff6c, Offset: 0xdaa
// Size: 0x306
function onstartgametype()
{
    setdvar( @"scr_game_objonnavbar", 1 );
    attacking_team = game[ "attackers" ];
    defending_team = game[ "defenders" ];
    level.teamdata[ attacking_team ][ "livesCount" ] = level.numteamlives;
    level.teamdata[ defending_team ][ "livesCount" ] = level.numteamlives;
    level.teamdata[ attacking_team ][ "elimUILivesCount" ] = level.teamdata[ attacking_team ][ "livesCount" ];
    level.teamdata[ defending_team ][ "elimUILivesCount" ] = level.teamdata[ defending_team ][ "livesCount" ];
    level.teamdata[ attacking_team ][ "hasPortableRadar" ] = 0;
    level.teamdata[ defending_team ][ "hasPortableRadar" ] = 0;
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "match_kills" ] ) )
    {
        game[ "match_kills" ][ defending_team ] = 0;
        game[ "match_kills" ][ attacking_team ] = 0;
    }
    
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
        game_utility_mp::setobjectivetext( entry, &"objectives/conf" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/conf" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/conf_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"objectives/conf_hint" );
    }
    
    initspawns();
    
    /#
        init_freeze_devgui();
    #/
    
    level.laststandhealth = game[ #"freeze" ].var_9659ae043f0b7f14;
    level.laststandrevivetimer = game[ #"freeze" ].var_a82a4706453d6963;
    level.var_764eb1e7a422f321 = 0;
    level.var_764eb4e7a422f9ba = 0;
    level.teamdata[ attacking_team ][ "uncountedDeaths" ] = 0;
    level.teamdata[ defending_team ][ "uncountedDeaths" ] = 0;
    level.teamdata[ attacking_team ][ "dbno" ] = 0;
    level.teamdata[ defending_team ][ "dbno" ] = 0;
    level.teamdata[ attacking_team ][ "frozenCount" ] = 0;
    level.teamdata[ defending_team ][ "frozenCount" ] = 0;
    thread function_5ced1b53990218d1();
}

// Namespace freeze
// Params 0
// Checksum 0x83c16963, Offset: 0x10b8
// Size: 0x25
function function_5ced1b53990218d1()
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    function_18b90a2be8797f0d();
}

// Namespace freeze
// Params 0
// Checksum 0x79459ec1, Offset: 0x10e5
// Size: 0xe1
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_ctf_spawn_allies_start", game[ "defenders" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_ctf_spawn_axis_start", game[ "attackers" ], 1 );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_attackers", "mp_ctf_spawn_allies", game[ "defenders" ] );
        spawnlogic::function_9bd2654564d3372d( #"primary", #"primary_defenders", "mp_ctf_spawn_axis", game[ "attackers" ] );
    }
    
    spawnlogic::finalizemap();
}

// Namespace freeze
// Params 0
// Checksum 0x6fe85e28, Offset: 0x11ce
// Size: 0x9
function updategametypedvars()
{
    common::updatecommongametypedvars();
}

// Namespace freeze
// Params 0
// Checksum 0x46b0b4e2, Offset: 0x11df
// Size: 0x17
function getspawnpoint()
{
    spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self );
    return spawnpoint;
}

// Namespace freeze
// Params 2
// Checksum 0xca05d21c, Offset: 0x11ff
// Size: 0x67
function function_a91e88a9e5286096( player, currentteam )
{
    level.teamdata[ currentteam ][ "uncountedDeaths" ]++;
    player.uncounteddeath = 1;
    player utility::waittill_any( "spawned", "disconnect" );
    level.teamdata[ currentteam ][ "uncountedDeaths" ]--;
    player.uncounteddeath = undefined;
}

// Namespace freeze
// Params 0
// Checksum 0x18731b00, Offset: 0x126e
// Size: 0x154
function function_18b90a2be8797f0d()
{
    setomnvar( "ui_allies_team_size", teams::getteamcount( "allies" ) );
    setomnvar( "ui_axis_team_size", teams::getteamcount( "axis" ) );
    var_857594feefda82c8 = function_6cfa8e4880b778d5( "allies" );
    var_ed1dec608fca2171 = function_6cfa8e4880b778d5( "axis" );
    setomnvar( "ui_allies_alive", var_857594feefda82c8 );
    setomnvar( "ui_axis_alive", var_ed1dec608fca2171 );
    setomnvar( "ui_allies_lives_remaining", var_857594feefda82c8 );
    setomnvar( "ui_axis_lives_remaining", var_ed1dec608fca2171 );
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_friendly_team_size", teams::getteamcount( player.team ) );
        enemyteam = team_utility::getotherteam( player.team );
        
        if ( isdefined( enemyteam ) )
        {
            enemycount = teams::getteamcount( enemyteam );
            player setclientomnvar( "ui_enemy_team_size", enemycount );
        }
    }
}

// Namespace freeze
// Params 0
// Checksum 0xf5e81125, Offset: 0x13ca
// Size: 0x9
function function_56714580aa4702f7()
{
    function_18b90a2be8797f0d();
}

// Namespace freeze
// Params 1
// Checksum 0x78ccf603, Offset: 0x13db
// Size: 0x32
function function_239a5e71567f97c8( params )
{
    if ( params.victim.var_1f6489d3304f10f )
    {
        params.var_eacecf0a1e48bf74 = 1;
    }
}

// Namespace freeze
// Params 1
// Checksum 0xc061dd19, Offset: 0x1415
// Size: 0x2f
function onplayerdisconnect( params )
{
    function_43159abfe2ed3b56( self, self );
    function_18b90a2be8797f0d();
    
    if ( self.var_251f6aea07f7d6c )
    {
        function_8c0040ce3fe09893();
    }
}

// Namespace freeze
// Params 1
// Checksum 0x32e2ba49, Offset: 0x144c
// Size: 0x227
function onplayerkilled( deathdata )
{
    victim = deathdata.victim;
    einflictor = deathdata.inflictor;
    attacker = deathdata.attacker;
    smeansofdeath = deathdata.meansofdeath;
    objweapon = deathdata.objweapon;
    
    if ( victim callback::exists( #"hash_652eb614ba902b3d", &function_5ffa23d234d1af42 ) )
    {
        victim callback::remove( #"hash_652eb614ba902b3d", &function_5ffa23d234d1af42 );
    }
    
    function_43159abfe2ed3b56( victim, attacker );
    
    if ( isplayer( attacker ) && attacker != victim && attacker.team != victim.team )
    {
        if ( victim.var_251f6aea07f7d6c )
        {
            victim function_69ca0d0479d2b4d8( victim, attacker );
        }
        
        isattacker = attacker.team == game[ "attackers" ];
        
        if ( isattacker )
        {
            attacker codcasterclientmatchdata::function_d1f0591eda60c559( 10, 1 );
        }
        else
        {
            attacker codcasterclientmatchdata::function_d1f0591eda60c559( 9, 1 );
        }
    }
    
    if ( level.numteamlives != 0 )
    {
        currentteam = victim.team;
        issuicide = victim damage::issuicide( einflictor, attacker, smeansofdeath, objweapon );
        isteamkill = victim damage::isteamkill( einflictor, attacker );
        
        if ( isdefined( victim.joining_team ) && victim.joining_team != "spectator" )
        {
            currentteam = team_utility::getotherteam( victim.joining_team );
        }
        
        if ( ( issuicide || isteamkill ) && !level.suicideteamkilllowerslives && !victim.switching_teams )
        {
            if ( teams::getteamdata( currentteam, "noRespawns" ) )
            {
                victim thread playerlogic::spawnclient();
            }
            
            level thread function_a91e88a9e5286096( victim, currentteam );
            return;
        }
        
        game[ "match_kills" ][ team_utility::getotherteam( currentteam ) ]++;
    }
    
    function_18b90a2be8797f0d();
    function_f6bb759d8e0201c6();
}

// Namespace freeze
// Params 16
// Checksum 0x12cbbf4a, Offset: 0x167b
// Size: 0x2f5, Type: bool
function onfriendlyfire( einflictor, eattacker, victim, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, iskillstreakweapon, willknockdown )
{
    if ( !player_utility::function_51a0c300008ab56b( eattacker, victim ) )
    {
        return false;
    }
    
    if ( !victim.var_251f6aea07f7d6c )
    {
        return false;
    }
    
    idamage = int( idamage );
    idamage = max( 1, idamage );
    
    if ( !isdefined( victim.revivers ) )
    {
        victim.revivers = [];
    }
    
    victim.revivers = arraycombineunique( victim.revivers, [ eattacker ] );
    
    if ( idamage >= victim.health )
    {
        victim thread laststand::exit( "last_stand_revived", eattacker );
        obituary( victim, eattacker, objweapon, "MOD_SPECIAL_KILL" );
        victim function_69ca0d0479d2b4d8( victim, eattacker );
        
        foreach ( reviver in victim.revivers )
        {
            reviver.pers[ "unfreezes" ] = ( reviver.pers[ "unfreezes" ] ?? 0 ) + 1;
            reviver stats::setextrascore1( reviver.pers[ "unfreezes" ] );
            reviver thread points::doscoreevent( #"reviver" );
        }
        
        function_fdcf91a21de5c61d( victim );
    }
    else
    {
        var_795e8a31194a39ac = {};
        var_795e8a31194a39ac.var_f561a4dd442b0d91 = 1;
        var_795e8a31194a39ac.victimentity = victim;
        
        if ( victim.health > game[ #"freeze" ].var_c3a38f859c9e98e3 )
        {
            eattacker damagefeedback::updatedamagefeedback( "hitfrozen_1", undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_795e8a31194a39ac );
        }
        else if ( victim.health > game[ #"freeze" ].var_68f7dbc5de2e232f )
        {
            eattacker damagefeedback::updatedamagefeedback( "hitfrozen_2", undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_795e8a31194a39ac );
        }
        else if ( victim.health > 0 )
        {
            eattacker damagefeedback::updatedamagefeedback( "hitfrozen_3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_795e8a31194a39ac );
        }
        
        victim damage::finishplayerdamagewrapper( einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname );
    }
    
    return false;
}

// Namespace freeze
// Params 1
// Checksum 0x9ee4789d, Offset: 0x1979
// Size: 0x71
function function_5ffa23d234d1af42( params )
{
    victim = params.victim;
    attacker = params.eattacker;
    
    if ( !victim.inlaststand )
    {
        return;
    }
    
    if ( isdefined( attacker ) && attacker.classname == "trigger_hurt" )
    {
        return;
    }
    
    params.idamage = 0;
}

// Namespace freeze
// Params 1
// Checksum 0x214dbf73, Offset: 0x19f2
// Size: 0x7b
function function_125800b6fe5855db( hitparams )
{
    victim = hitparams.victim;
    
    if ( victim.var_7d539e173b28ebf0 )
    {
        victim.var_7d539e173b28ebf0 = undefined;
        return "hitfreezewipe";
    }
    
    if ( victim.inlaststand )
    {
        if ( isdefined( victim.perks[ "specialty_pistoldeath" ] ) && !victim.hasshownlaststandicon )
        {
            return "hitfreeze";
        }
    }
}

// Namespace freeze
// Params 3
// Checksum 0x5eadc678, Offset: 0x1a76
// Size: 0xa2
function function_69ca0d0479d2b4d8( victim, attacker, skiphitmarker = 0 )
{
    if ( victim.team == attacker.team && !skiphitmarker )
    {
        attacker damagefeedback::updatedamagefeedback( "hitfrozenbreak" );
    }
    
    victim gameplay_sound_fx::playlocalsoundfx( #"hash_e4f1afab85a289ac" );
    victim gameplay_sound_fx::function_28103d3430792dce( victim.origin, #"hash_823af3fcf602326e" );
    victim setscriptablepartstate( "freeze_tag_fx", #"hash_13208174a03e1e0f" );
    victim function_8efad8712463ef33();
}

// Namespace freeze
// Params 1
// Checksum 0x84c5ae0e, Offset: 0x1b20
// Size: 0x19
function function_fdcf91a21de5c61d( player )
{
    player.revivers = [];
}

// Namespace freeze
// Params 0
// Checksum 0x4c7e9a6, Offset: 0x1b41
// Size: 0x81
function function_680f120587aa92dd()
{
    foreach ( weapon in self.primaryweapons )
    {
        self givemaxammo( weapon );
    }
    
    equipment_mp::function_45c3c3f7df352e9f();
}

// Namespace freeze
// Params 1
// Checksum 0x73917d0a, Offset: 0x1bca
// Size: 0x1df
function function_56d032002a8c9cd5( params )
{
    self.var_b541f8c69a34639d = level.defaultmaxhealth;
    self.laststandrevivehealth = level.defaultmaxhealth;
    self.var_2a0bcfaae7400f6f = gameplay_sound_fx::getgameplaysfx( #"hitfrozen" );
    self.var_959d9bf0d800e404 = gameplay_sound_fx::getgameplaysfx( #"killfrozen" );
    self.var_aab5beb67c1704ec = 1;
    
    if ( self && !isbot( self ) )
    {
        self setcamerathirdperson( 1 );
    }
    
    if ( !callback::exists( #"hash_652eb614ba902b3d", &function_5ffa23d234d1af42 ) )
    {
        callback::add( #"hash_652eb614ba902b3d", &function_5ffa23d234d1af42 );
    }
    
    freezeplayer( params );
    
    if ( self.attacker != self )
    {
        self.freezer = self.attacker;
        self.attacker thread points::doscoreevent( #"elimination_kill" );
        self.attacker thread damage::function_483c8cb5f7e4a41a( params );
    }
    
    foreach ( attacker in self.attackers )
    {
        if ( attacker == self.attacker )
        {
            continue;
        }
        
        attacker thread points::doscoreevent( #"elimination_kill" );
        attacker thread damage::function_483c8cb5f7e4a41a( params );
    }
    
    if ( getdvarint( @"hash_882df2e879a8a9a8", game[ #"freeze" ].var_77f1c8a2aa5fa2dd ) )
    {
        killstreaks::resetstreakpoints();
    }
    
    if ( level.var_2acb9af1663be697 )
    {
        thread function_590f90550a1ce005();
    }
}

// Namespace freeze
// Params 1
// Checksum 0xc998de4f, Offset: 0x1db1
// Size: 0x1f
function function_42124fad3bc1e3ed( params )
{
    if ( self.var_251f6aea07f7d6c )
    {
        function_8c0040ce3fe09893();
    }
}

// Namespace freeze
// Params 1
// Checksum 0xdf2f7fd1, Offset: 0x1dd8
// Size: 0x458
function freezeplayer( params )
{
    victim = params.victim;
    attacker = params.attacker ?? params.eattacker;
    
    if ( victim == attacker )
    {
        victim kill( victim.origin, attacker, params.einflictor, "MOD_SUICIDE" );
        return;
    }
    
    victim.var_251f6aea07f7d6c = 1;
    function_18b90a2be8797f0d();
    
    if ( !isbot( self ) )
    {
        utility::callsharedfunc( #"damage_effects", #"hash_7ff5e70e05a98fb0" );
    }
    
    victim function_9f73fa7e41b52ef0();
    val::set( "freeze_tag", "allow_haywire", 0 );
    
    if ( !victim isonground() || victim isswimming() )
    {
        newPoint = getclosestpointonnavmesh( victim.origin );
        
        if ( newPoint )
        {
            victim setorigin( newPoint );
        }
    }
    
    attacker.pers[ "freezes" ] = ( attacker.pers[ "freezes" ] ?? 0 ) + 1;
    attacker stats::setextrascore0( attacker.pers[ "freezes" ] );
    obituary( victim, attacker, params.objweapon, "MOD_DOWN" );
    gamescore::giveteamscoreforobjective( attacker.team, 1 );
    gameplay_sound_fx::playlocalsoundfx( #"hash_f8c969e5cbe6646f" );
    gameplay_sound_fx::function_28103d3430792dce( victim.origin, #"hash_ab072955057b2ca3" );
    victim setscriptablepartstate( "freeze_tag_fx", #"pristine" );
    victim val::set( "freeze_tag", "allow_movement", game[ #"freeze" ].var_8e2851103b39827e );
    victim player::_freezecontrols( 0 );
    victim disableexecutionvictim();
    victim perk::giveperk( "specialty_no_target" );
    
    if ( !isdefined( victim.var_d464004d077bab65 ) )
    {
        victim.var_d464004d077bab65 = objidpoolmanager::requestobjectiveid( 1 );
    }
    
    victim function_8a7bca36accdcc1e( victim.var_d464004d077bab65, game[ #"freeze" ].var_1496e1b798802e94, game[ #"freeze" ].var_107a65afee77ad1b, victim.team, "current", game[ #"freeze" ].var_2094b4ae447ef7c0 );
    
    if ( !isdefined( victim.var_d495b0d353bf8cc4 ) )
    {
        victim.var_d495b0d353bf8cc4 = objidpoolmanager::requestobjectiveid( 1 );
    }
    
    victim function_8a7bca36accdcc1e( victim.var_d495b0d353bf8cc4, game[ #"freeze" ].var_1496e1b798802e94, game[ #"freeze" ].var_107a65afee77ad1b, victim.team, "active", 0 );
    
    if ( game[ #"freeze" ].var_4b2be02c26b9a273 )
    {
        waitframe();
        
        if ( victim )
        {
            victim.animname = "Player 1";
            victim.freeze_tag_scene_struct = utility::spawn_model( "tag_origin", victim.origin, victim.angles );
            
            if ( victim.freeze_tag_scene_struct )
            {
                victim.freeze_tag_scene_struct scene::set_scriptbundle( "sat_freeze_tag_player" );
                victim showlegs();
                victim.freeze_tag_scene_struct thread scene::play( [ victim ], "shot_010", "sat_freeze_tag_player" );
            }
        }
    }
    
    if ( !function_43159abfe2ed3b56( victim, attacker ) )
    {
        dialog::leaderdialog( #"ally_frozen", victim.team, undefined, [ victim ] );
    }
    
    if ( function_692c0ee90fcdf4f7( victim.team ) && !function_99a060c22aedbd81( victim.team ) )
    {
        function_ef2e62997a144fbc( attacker.team );
    }
    
    if ( getdvarint( @"hash_c332e041caa6bae9", game[ #"freeze" ].var_8e2851103b39827e ) )
    {
        victim thread function_2bceb95feee18b3( victim.var_d464004d077bab65 );
        victim thread function_2bceb95feee18b3( victim.var_d495b0d353bf8cc4 );
    }
    
    victim function_a56e42465fbb441c();
}

// Namespace freeze
// Params 2
// Checksum 0x381f03a4, Offset: 0x2238
// Size: 0x12c, Type: bool
function function_43159abfe2ed3b56( victim, attacker )
{
    var_bd70120e55c5baa = function_6cfa8e4880b778d5( victim.team, 1 );
    
    if ( var_bd70120e55c5baa <= 0 )
    {
        victim.var_7d539e173b28ebf0 = 1;
        
        if ( !game[ #"freeze" ].var_6d06e71fdcafdd4b )
        {
            level thread totalfreeze( victim.team, attacker );
        }
        
        return true;
    }
    else if ( var_bd70120e55c5baa == 1 )
    {
        foreach ( player in level.teamdata[ victim.team ][ "alivePlayers" ] )
        {
            if ( player.var_251f6aea07f7d6c )
            {
                continue;
            }
            
            player dialog::leaderdialogonplayer( #"last_frozen" );
        }
        
        return true;
    }
    
    return false;
}

// Namespace freeze
// Params 2, eflags: 0xc
// Checksum 0xa4298272, Offset: 0x236d
// Size: 0x2e8
function private totalfreeze( victimteam, attacker )
{
    self notify( #"hash_94bdf98d3a8e7c64" );
    self endon( #"hash_94bdf98d3a8e7c64" );
    
    if ( !isdefined( victimteam ) )
    {
        return;
    }
    
    if ( game[ #"freeze" ].var_6d06e71fdcafdd4b )
    {
        return;
    }
    
    game[ #"freeze" ].var_6d06e71fdcafdd4b = 1;
    attackerteam = attacker.team;
    
    if ( attackerteam == victimteam )
    {
        attackerteam = team_utility::getotherteam( victimteam );
    }
    
    victimplayers = level.teamdata[ victimteam ][ "players" ];
    freezescore = victimplayers.size;
    gamescore::giveteamscoreforobjective( attackerteam, freezescore * game[ #"freeze" ].var_4f8f858f2fa005f9 );
    dialog::leaderdialogonplayers( #"hash_6fd0fa8d816048c9", level.teamdata[ attacker.team ][ "players" ] );
    dialog::leaderdialogonplayers( #"hash_73f757ef251804aa", level.teamdata[ victimteam ][ "players" ] );
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) )
        {
            if ( player.team == victimteam )
            {
                player setscriptablepartstate( "freeze_tag_fx", #"hash_13208174a03e1e0f" );
                player.var_1f6489d3304f10f = 1;
                
                if ( !player utility::isusingremote() )
                {
                    player kill( player.origin, player.freezer ?? attacker, undefined, "MOD_TEAM_WIPED" );
                }
                
                if ( player.var_251f6aea07f7d6c )
                {
                    objidpoolmanager::objective_playermask_hidefromallplayers( player.var_d464004d077bab65 );
                    objidpoolmanager::objective_playermask_hidefromallplayers( player.var_d495b0d353bf8cc4 );
                }
            }
            else
            {
                player thread points::doscoreevent( #"hash_318915103e42030b" );
                player gameplay_sound_fx::playlocalsoundfx( #"hash_318915103e42030b" );
                player thread hud_message::showsplash( "all_enemies_frozen" );
                
                if ( player.var_251f6aea07f7d6c && game[ #"freeze" ].var_6c9186872477220d )
                {
                    player thread laststand::exit( "last_stand_revived", attacker );
                    player function_69ca0d0479d2b4d8( player, attacker, 1 );
                }
                
                if ( game[ #"freeze" ].var_97068378621014fe )
                {
                    player function_680f120587aa92dd();
                }
            }
        }
        
        waitframe();
    }
    
    game[ #"freeze" ].var_6d06e71fdcafdd4b = 0;
}

// Namespace freeze
// Params 6
// Checksum 0x29d1fe27, Offset: 0x265d
// Size: 0x165
function function_8a7bca36accdcc1e( objid, objlabel, objicon, team, state, var_2094b4ae447ef7c0 )
{
    objective_setbackground( objid, 1 );
    objective_setzoffset( objid, 30 );
    objective_position( objid, self geteye() + ( 0, 0, -15 ) );
    objective_state( objid, state );
    objective_setplayintro( objid, 0 );
    objective_setownerteam( objid, team );
    
    if ( isdefined( objicon ) )
    {
        objective_icon( objid, objicon );
    }
    
    if ( isdefined( objlabel ) )
    {
        objective_setlabel( objid, objlabel );
    }
    
    objidpoolmanager::objective_playermask_showtoallplayers( objid );
    objidpoolmanager::objective_playermask_hidefrom( objid, self );
    objidpoolmanager::function_80210e6c15f41880( objid, 1 );
    self function_24bcc144edf26e3a( 1 );
    
    if ( var_2094b4ae447ef7c0 )
    {
        otherteam = team_utility::getotherteam( team );
        var_d8507b9f3e5dadd1 = level.teamdata[ otherteam ][ "players" ];
        
        foreach ( player in var_d8507b9f3e5dadd1 )
        {
            objidpoolmanager::objective_playermask_hidefrom( objid, player );
        }
    }
}

// Namespace freeze
// Params 1
// Checksum 0xdae704f4, Offset: 0x27ca
// Size: 0x64
function function_459ac2ccb8704bd4( params )
{
    self notify( #"hash_c792bc5a141b5428" );
    self endon( #"hash_c792bc5a141b5428" );
    
    if ( !self.var_251f6aea07f7d6c || !isalive( self ) || !isdefined( self.var_d464004d077bab65 ) )
    {
        return;
    }
    
    objective_setprogress( self.var_d464004d077bab65, params.progress );
}

// Namespace freeze
// Params 0
// Checksum 0x1b2c878, Offset: 0x2836
// Size: 0x1c
function function_590f90550a1ce005()
{
    self endon( #"death_or_disconnect" );
    wait 2;
    self.var_26d9e22abfa6be43 = 1;
}

// Namespace freeze
// Params 0
// Checksum 0xaf46c92, Offset: 0x285a
// Size: 0xdc
function function_8c0040ce3fe09893()
{
    victimpos = self.origin;
    victimteam = self.team;
    var_6a3a2685949ba981 = self.var_d464004d077bab65;
    var_fd91d1322391cab0 = self.var_d495b0d353bf8cc4;
    
    if ( game[ #"freeze" ].var_4b2be02c26b9a273 )
    {
        self.freeze_tag_scene_struct thread scene::stop();
    }
    
    gameplay_sound_fx::function_28103d3430792dce( victimpos, #"hash_e4d9e0b99f6b3343" );
    objidpoolmanager::objective_playermask_hidefromallplayers( var_6a3a2685949ba981 );
    objidpoolmanager::objective_playermask_hidefromallplayers( var_fd91d1322391cab0 );
    
    if ( self )
    {
        self setscriptablepartstate( "freeze_tag_fx", #"hash_e6ac38366a5d56ac" );
        function_db4f5006fc45e0f5();
    }
    
    if ( !function_692c0ee90fcdf4f7( victimteam ) && function_99a060c22aedbd81( victimteam ) )
    {
        function_c50cb5fea306b7ce( victimteam );
    }
}

// Namespace freeze
// Params 0
// Checksum 0x5487d151, Offset: 0x293e
// Size: 0xb9
function function_db4f5006fc45e0f5()
{
    self.var_251f6aea07f7d6c = 0;
    self.var_26d9e22abfa6be43 = 0;
    self.var_2a0bcfaae7400f6f = undefined;
    self.var_959d9bf0d800e404 = undefined;
    self.var_aab5beb67c1704ec = 0;
    
    if ( !isbot( self ) )
    {
        self setcamerathirdperson( 0 );
    }
    
    self.reduceddamageeffects = 0;
    damage_effects::onexitdeathsdoor( 1 );
    self setscriptablepartstate( "freeze_tag_fx", #"off" );
    self function_24bcc144edf26e3a( 0 );
    val::set( "freeze_tag", "allow_movement", 1 );
    val::set( "freeze_tag", "allow_haywire", 1 );
    player::_freezecontrols( 0 );
    self enableexecutionvictim();
    perk::removeperk( "specialty_no_target" );
    function_18b90a2be8797f0d();
}

// Namespace freeze
// Params 0
// Checksum 0x6bbcde92, Offset: 0x29ff
// Size: 0x5b
function function_9f73fa7e41b52ef0()
{
    self.reduceddamageeffects = 1;
    damage_effects::onexitdeathsdoor( 1 );
    hadeffects = self.burnfxplaying || self.burninginfo || self.status_effects.size > 0;
    
    if ( hadeffects )
    {
        damage_effects::clearburning();
        status_effects::function_4306f85454d862ba();
    }
}

// Namespace freeze
// Params 1
// Checksum 0x8990769e, Offset: 0x2a62
// Size: 0x32
function function_99a060c22aedbd81( team )
{
    otherteam = team_utility::getotherteam( team );
    return level.teamdata[ otherteam ][ "hasPortableRadar" ];
}

// Namespace freeze
// Params 1
// Checksum 0x50768bb, Offset: 0x2a9d
// Size: 0x3e, Type: bool
function function_692c0ee90fcdf4f7( enemyteam )
{
    var_9a865bf7c16d4bfa = function_6cfa8e4880b778d5( enemyteam );
    return var_9a865bf7c16d4bfa == 1 && game[ #"freeze" ].var_ff5ecc7ceac7a579;
}

// Namespace freeze
// Params 1
// Checksum 0x5acc7e7f, Offset: 0x2ae4
// Size: 0x129
function function_ef2e62997a144fbc( team )
{
    players = level.teamdata[ team ][ "players" ];
    bundle = level.streakglobals.streakbundles[ "radar_ping" ];
    
    foreach ( player in players )
    {
        player setclientomnvar( "radar_ping", function_43b5ed5a14a56573( #"scriptbundle_killstreak", bundle.var_d80db24c90d421fb ) );
        player function_744ec8023439271f( int( bundle.radarpingsweepradius ), int( bundle.radarpingsweeptime * 1000 ), int( bundle.var_2962c1bc94835e40 * 1000 ) );
    }
    
    level.teamdata[ team ][ "hasPortableRadar" ] = 1;
}

// Namespace freeze
// Params 1
// Checksum 0x8362bde9, Offset: 0x2c15
// Size: 0xbe
function function_c50cb5fea306b7ce( team )
{
    otherteam = team_utility::getotherteam( team );
    players = level.teamdata[ otherteam ][ "players" ];
    
    foreach ( player in players )
    {
        player function_c67c92094ae6ccf7();
    }
    
    level.teamdata[ otherteam ][ "hasPortableRadar" ] = 0;
}

// Namespace freeze
// Params 2
// Checksum 0xa9535bbb, Offset: 0x2cdb
// Size: 0xd1
function function_6cfa8e4880b778d5( team, onlyalive = 0 )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    teamcount = teams::getteamcount( team, onlyalive );
    frozenCount = 0;
    
    foreach ( player in level.teamdata[ team ][ "players" ] )
    {
        if ( player.var_251f6aea07f7d6c )
        {
            frozenCount++;
        }
    }
    
    return teamcount - frozenCount;
}

// Namespace freeze
// Params 1
// Checksum 0x8ed05e1a, Offset: 0x2db5
// Size: 0x5b
function function_2bceb95feee18b3( objid )
{
    level endon( #"game_ended" );
    var_c2f4ba62da8e04de = 1;
    
    while ( self.var_251f6aea07f7d6c && isalive( self ) )
    {
        objective_position( objid, self geteye() + ( 0, 0, -15 ) );
        wait var_c2f4ba62da8e04de;
    }
}

// Namespace freeze
// Params 5
// Checksum 0x58b6a3de, Offset: 0x2e18
// Size: 0x51
function freeze_endround( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 )
{
    gamescore::giveteamscoreforobjective( winningteam, 1 );
    level thread gamelogic_mp::endgame( winningteam, endreasontext, endreasontextloss, nukedetonated, var_de9b655923cddf60 );
    codcasterclientmatchdata::function_d6aea11d2e9ba521();
}

// Namespace freeze
// Params 1
// Checksum 0x2eed979c, Offset: 0x2e71
// Size: 0x29
function freeze_ononeleftevent( team )
{
    lastplayer = game_utility_mp::getlastlivingplayer( team );
    lastplayer thread freeze_givelastonteamwarning();
}

// Namespace freeze
// Params 0
// Checksum 0x17bbbd77, Offset: 0x2ea2
// Size: 0x98
function freeze_givelastonteamwarning()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player::waittillrecoveredhealth( 3 );
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_inform_last_one" );
    otherteam = team_utility::getotherteam( self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_teammate_alive_callout", self, self.pers[ "team" ] );
    level thread hud_util::teamplayercardsplash( #"last_enemy_alive_callout", self, otherteam );
    level notify( #"last_alive", self );
}

// Namespace freeze
// Params 1
// Checksum 0x50e32fb0, Offset: 0x2f42
// Size: 0x16b
function function_cae49d4fbe5ead63( team )
{
    if ( game_utility::gettimepassed() < 5000 )
    {
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    function_3dbd2b5d0e0b249d( team );
    
    foreach ( player in players )
    {
        player thread function_6efcfd1b2d747246();
    }
    
    dialog::statusdialog( #"team_no_lives", team, "lives" );
    dialog::statusdialog( #"enemy_no_lives", team_utility::getotherteam( team ), "lives" );
    
    foreach ( player in level.players )
    {
        if ( player.team == team_utility::getotherteam( team ) )
        {
            player perk::giveperk( "specialty_kill_report" );
        }
    }
}

// Namespace freeze
// Params 2
// Checksum 0xe8a6a462, Offset: 0x30b5
// Size: 0xa4, Type: bool
function function_51617fd884afe12f( player, revivespawn )
{
    if ( !isdefined( level.var_c6b02af9c0f45ca2[ player.team ] ) || player.lastdeathtime < level.var_c6b02af9c0f45ca2[ player.team ] )
    {
        return false;
    }
    
    if ( !revivespawn && teams::getteamdata( player.team, "noRespawns" ) && player.team != "none" && player.team != "spectator" )
    {
        return true;
    }
    
    return false;
}

// Namespace freeze
// Params 6
// Checksum 0xe0ccfb6c, Offset: 0x3162
// Size: 0x5f
function onnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon )
{
    common::oncommonnormaldeath( victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon );
    victim.lastdeathtime = gettime();
    function_18b90a2be8797f0d();
}

// Namespace freeze
// Params 1
// Checksum 0x83499b2, Offset: 0x31c9
// Size: 0x8a
function onspawnplayer( spawndata )
{
    if ( self.var_251f6aea07f7d6c )
    {
        function_db4f5006fc45e0f5();
    }
    
    function_18b90a2be8797f0d();
    function_fdcf91a21de5c61d( self );
    
    if ( !function_692c0ee90fcdf4f7( self.team ) && function_99a060c22aedbd81( self.team ) )
    {
        function_c50cb5fea306b7ce( self.team );
    }
    
    if ( self.var_1f6489d3304f10f )
    {
        dialog::leaderdialogonplayer( #"hash_323483c9c2418b85" );
        self.var_1f6489d3304f10f = 0;
    }
}

// Namespace freeze
// Params 1
// Checksum 0x6961168d, Offset: 0x325b
// Size: 0x71
function function_b9afcb7bce13dc8( team )
{
    teams::setteamdata( team, "dbno", 1 );
    teams::setteamdata( team, "noRespawns", 1 );
    
    if ( !isdefined( level.var_c6b02af9c0f45ca2 ) )
    {
        level.var_c6b02af9c0f45ca2 = [];
    }
    
    level.var_c6b02af9c0f45ca2[ team ] = gettime();
    setomnvar( "ui_" + team + "_no_respawn", 1 );
    function_cae49d4fbe5ead63( team );
}

// Namespace freeze
// Params 0
// Checksum 0x5f076a3e, Offset: 0x32d4
// Size: 0xd9
function freeze_ontimelimit()
{
    if ( !isdefined( level.var_d95b674c4a3e8f05 ) )
    {
        var_6444554a33efb111 = level.teamdata[ game[ "attackers" ] ][ "elimUILivesCount" ];
        var_232b2b8d602fe64d = level.teamdata[ game[ "defenders" ] ][ "elimUILivesCount" ];
        
        if ( var_6444554a33efb111 > var_232b2b8d602fe64d )
        {
            freeze_endround( game[ "attackers" ], game[ "end_reason" ][ "freeze_lives_win" ], game[ "end_reason" ][ "freeze_lives_loss" ] );
        }
        else if ( var_232b2b8d602fe64d > var_6444554a33efb111 )
        {
            freeze_endround( game[ "defenders" ], game[ "end_reason" ][ "freeze_lives_win" ], game[ "end_reason" ][ "freeze_lives_loss" ] );
        }
        
        freeze_endround( "tie", game[ "end_reason" ][ "freeze_tie" ] );
        level.var_d95b674c4a3e8f05 = 1;
    }
}

// Namespace freeze
// Params 1
// Checksum 0x312d768d, Offset: 0x33b5
// Size: 0x64
function function_a85c2256f4732ae2( reviver )
{
    rescues = reviver.pers[ "rescues" ] + 1;
    reviver.pers[ "rescues" ] = rescues;
    reviver persistence::statsetchild( "round", "rescues", rescues );
    reviver stats::setextrascore1( rescues, "rescues" );
}

// Namespace freeze
// Params 0
// Checksum 0x5accd428, Offset: 0x3421
// Size: 0x9
function freeze_onmaprestart()
{
    codcasterclientmatchdata::function_1340113cb5a43c2c();
}

// Namespace freeze
// Params 9
// Checksum 0x431d7e82, Offset: 0x3432
// Size: 0x56, Type: bool
function modelaststandallowed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    return true;
}

// Namespace freeze
// Params 8
// Checksum 0x8faedad7, Offset: 0x3491
// Size: 0xbb, Type: bool
function function_1fd96ce646ded7ea( victim, einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc )
{
    if ( victim.inlaststand || victim.playergoingintols )
    {
        return false;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.classname ) && ( attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" ) )
    {
        if ( !level.var_e24f88c6a48b65 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace freeze
// Params 1
// Checksum 0xb1217e83, Offset: 0x3555
// Size: 0x23, Type: bool
function function_4fa517f73b52c1e( params )
{
    if ( self.var_251f6aea07f7d6c )
    {
        playerlogic::playerhasmoved();
        return true;
    }
    
    return false;
}

// Namespace freeze
// Params 1
// Checksum 0xa4057e, Offset: 0x3581
// Size: 0xd2
function function_3dbd2b5d0e0b249d( teamname )
{
    foreach ( player in level.players )
    {
        if ( player.team == teamname )
        {
            player hud_message::function_78fedf6f526825f4( "freeze_friendly_norespawn", level.gametypebundle.var_e662dd7f27d462eb );
            continue;
        }
        
        player hud_message::function_78fedf6f526825f4( "freeze_enemy_norespawn", level.gametypebundle.var_e662dd7f27d462eb );
    }
}

// Namespace freeze
// Params 1
// Checksum 0xeccaae03, Offset: 0x365b
// Size: 0x2d
function function_79f7a3e4aac6b11b( player )
{
    player hud_message::function_78fedf6f526825f4( "freeze_last_alive", level.gametypebundle.var_e662dd7f27d462eb );
}

// Namespace freeze
// Params 0
// Checksum 0x26404b04, Offset: 0x3690
// Size: 0x35
function function_6efcfd1b2d747246()
{
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_hq_norespawn", 1 );
    self playlocalsound( "mp_hq_respawn_disabled" );
    wait 5;
    self setclientomnvar( "ui_hq_norespawn", 0 );
}

// Namespace freeze
// Params 1
// Checksum 0x3c52afe0, Offset: 0x36cd
// Size: 0x13
function ongameended( params )
{
    function_7e4bfb09bdbc0c90();
}

// Namespace freeze
// Params 0
// Checksum 0xb3c8b145, Offset: 0x36e8
// Size: 0xac
function function_a56e42465fbb441c()
{
    time = gettime();
    self.pers[ "freeze_time" ] = time;
    matchtime = matchdata::gettimefrommatchstart( time );
    matchtime = int( clamp( matchtime, 0, 2147483647 ) );
    dlog_recordevent( "dlog_event_freeze_frozen", [ "matchtime_ms", matchtime, "freeze_pos_x", self.origin[ 0 ], "freeze_pos_y", self.origin[ 1 ], "freeze_pos_z", self.origin[ 2 ] ] );
}

// Namespace freeze
// Params 0
// Checksum 0x68cd9097, Offset: 0x379c
// Size: 0xca
function function_8efad8712463ef33()
{
    time = gettime();
    freezedurationms = time - ( self.pers[ "freeze_time" ] ?? time );
    matchtime = matchdata::gettimefrommatchstart( time );
    matchtime = int( clamp( matchtime, 0, 2147483647 ) );
    dlog_recordevent( "dlog_event_freeze_duration", [ "matchtime_ms", matchtime, "freeze_duration_ms", freezedurationms, "unfrozen_pos_x", self.origin[ 0 ], "unfrozen_pos_y", self.origin[ 1 ], "unfrozen_pos_z", self.origin[ 2 ] ] );
}

// Namespace freeze
// Params 0
// Checksum 0xa564b09, Offset: 0x386e
// Size: 0x76
function function_f6bb759d8e0201c6()
{
    time = gettime();
    matchtime = matchdata::gettimefrommatchstart( time );
    matchtime = int( clamp( matchtime, 0, 2147483647 ) );
    scorestreak_score = self.var_31609d0a6fb2f687 ?? 0;
    dlog_recordevent( "dlog_event_freeze_scorestreak_check", [ "matchtime_ms", matchtime, "scorestreak_score", scorestreak_score ] );
}

// Namespace freeze
// Params 0
// Checksum 0xd664c6ac, Offset: 0x38ec
// Size: 0xa5
function function_7e4bfb09bdbc0c90()
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.var_251f6aea07f7d6c )
        {
            player thread function_8efad8712463ef33();
        }
        
        if ( isalive( player ) )
        {
            player thread function_f6bb759d8e0201c6();
        }
    }
}

/#

    // Namespace freeze
    // Params 0
    // Checksum 0xdd84cc3c, Offset: 0x3999
    // Size: 0x6d, Type: dev
    function init_freeze_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x4b>", "<dev string:x61>", &function_91c8273814eea433 );
        devgui::add_devgui_func( "<dev string:x7e>", "<dev string:x97>", &function_d2d467785ffb8d64 );
        devgui::add_devgui_func( "<dev string:xb7>", "<dev string:xca>", &function_f7a0c2b1d751e777 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xdc>" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace freeze
    // Params 0
    // Checksum 0xbe479b34, Offset: 0x3a0e
    // Size: 0xb8, Type: dev
    function function_91c8273814eea433()
    {
        foreach ( player in level.players )
        {
            player hud_message::function_78fedf6f526825f4( "<dev string:xee>", level.gametypebundle.var_e662dd7f27d462eb );
            waitframe();
            player hud_message::function_78fedf6f526825f4( "<dev string:x105>", level.gametypebundle.var_e662dd7f27d462eb );
        }
    }

    // Namespace freeze
    // Params 0
    // Checksum 0xb18a9fb0, Offset: 0x3ace
    // Size: 0xb8, Type: dev
    function function_d2d467785ffb8d64()
    {
        foreach ( player in level.players )
        {
            player hud_message::function_78fedf6f526825f4( "<dev string:x11b>", level.gametypebundle.var_e662dd7f27d462eb );
            waitframe();
            player hud_message::function_78fedf6f526825f4( "<dev string:x105>", level.gametypebundle.var_e662dd7f27d462eb );
        }
    }

    // Namespace freeze
    // Params 0
    // Checksum 0xf0b89bec, Offset: 0x3b8e
    // Size: 0x7e, Type: dev
    function function_f7a0c2b1d751e777()
    {
        foreach ( player in level.players )
        {
            function_79f7a3e4aac6b11b( player );
        }
    }

#/
