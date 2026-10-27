// scripts\mp\br\gametypes\br_dev_tests.gsc  (hash_71a43e0bf9f01f1f.gscc) (size: 56896 Bytes / 0xde40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x173b08c2 (389744834)
// size ...... 56896 (0xde40)
// includes .. 51  (offset: 0xd14c)
// strings ... 206 (offset: 0xd2e4)
// dev strs .. 2   (offset: 0xde28)
// exports ... 56  (offset: 0x9e78)
// cseg ...... 0xea7 + 0x8fd1 (0x9e78)
// imports ... 238 (offset: 0xa738)
// animtree1 . 0   (offset: 0xde40)
// animtree2 . 0   (offset: 0xde40)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\gasmask;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_functional_poi;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_infils_legacy;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_rewards;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\javelin;
#using scripts\mp\juggernaut;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace br_dev_tests;

// Namespace br_dev_tests
// Params 0
// Checksum 0x37acb8c9, Offset: 0xec5
// Size: 0x47
function init()
{
    /#
        setdvarifuninitialized( @"hash_87e38fca685cec1d", 1 );
    #/
    
    if ( getdvarint( @"hash_87e38fca685cec1d", 0 ) )
    {
        br_dev::registerhandlecommand( &function_ff5993a5400894bf );
        thread br_dev::commandwatcher( @"hash_97cda940cb7bd182", &br_dev::handlecommand );
    }
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x2dc85ee5, Offset: 0xf14
// Size: 0x46
function function_ff5993a5400894bf( command, args )
{
    switch ( command )
    {
        case #"hash_fa50c0f6bd8302a2":
            thread devscriptedtests( args );
            break;
        default:
            break;
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x50c7958, Offset: 0xf62
// Size: 0xbb
function devscriptedtests( args )
{
    level notify( #"hash_61ff6691d501ec27" );
    level endon( #"hash_61ff6691d501ec27" );
    host = gethost( args );
    
    if ( !isdefined( host ) )
    {
        return;
    }
    
    resetgulag();
    function_8a31807bf0b43364();
    resetplayers();
    resetcircles();
    [ hostteammates, enemyteammates ] = spawnteams( args );
    function_7237c3fd646bce26();
    host iprintlnbold( "Test ready" );
    host setclientomnvar( "ui_br_infiled", 1 );
    wait 2;
    runtests( args, host, hostteammates, enemyteammates );
}

// Namespace br_dev_tests
// Params 0
// Checksum 0xba15911c, Offset: 0x1025
// Size: 0x18f
function getspawnlocations()
{
    if ( game_utility::isdonetskmap() )
    {
        spawnlocations = [ br::createspawnlocation( ( -21500, 46200, -300 ), 0, 6000 ), br::createspawnlocation( ( 51000, -39000, 1401 ), 0, 4000 ), br::createspawnlocation( ( 32000, 40000, 767 ), 0, 5500 ), br::createspawnlocation( ( 23000, -15000, -158 ), 0, 6000 ) ];
        return spawnlocations;
    }
    
    if ( game_utility::function_d2460960855e0301() )
    {
        spawnlocations = [ br::createspawnlocation( ( 26889.1, -30035.3, 3497.65 ), 0, 6000 ), br::createspawnlocation( ( 37200, 30506.6, 1760.46 ), 0, 4000 ), br::createspawnlocation( ( -29611.7, 35197, 1376.12 ), 0, 5500 ), br::createspawnlocation( ( -24496.6, -27294.2, 1700.23 ), 0, 6000 ) ];
        return spawnlocations;
    }
    
    if ( issubstr( level.mapname, "avalon" ) )
    {
        spawnlocations = [ br::createspawnlocation( ( 165, -250, 538 ), 0, 6000 ), br::createspawnlocation( ( 51248, -35152, 2171 ), 0, 4000 ), br::createspawnlocation( ( 14164, 45349, 710 ), 0, 5500 ), br::createspawnlocation( ( -37282, -39099, 943 ), 0, 6000 ) ];
        return spawnlocations;
    }
}

// Namespace br_dev_tests
// Params 0
// Checksum 0x3af87a28, Offset: 0x11bc
// Size: 0x204
function resetgulag()
{
    if ( level.usegulag )
    {
        foreach ( arena in level.gulag.arenas )
        {
            arena.matches = [];
        }
        
        level.gulag.arenas = sortbydistance( level.gulag.arenas, level.mapcorners[ 0 ].origin );
        level.gulag.maxuses = -1;
        level.gulag.timelimit = 15;
        setdvar( @"scr_br_fc_overtime", 15 );
        setdvar( @"hash_e5f703a38f6e8043", 95 );
        setdvar( @"hash_8bdee07fa09e810a", -1 );
        setdvar( @"scr_br_gulag_win_hold", 0 );
        setdvar( @"scr_br_hold_in_gulag", 0 );
        
        if ( isdefined( level.gulag ) && level.gulag.shutdown )
        {
            foreach ( arena in level.gulag.arenas )
            {
                arena.shutdown = undefined;
            }
            
            level.gulag.shutdown = undefined;
        }
    }
}

// Namespace br_dev_tests
// Params 0
// Checksum 0x863c321c, Offset: 0x13c8
// Size: 0x1d5
function function_8a31807bf0b43364()
{
    flags::gameflagset( "prematch_done" );
    flags::gameflagset( "prematch_fade_done" );
    level notify( #"prematch_over" );
    level notify( #"cancel_public_event" );
    level notify( #"cancel_respawn" );
    setomnvar( "ui_prematch_period", 0 );
    setomnvar( "scriptable_loot_hide", 0 );
    setomnvarforallclients( "ui_round_end_reason", 0 );
    setomnvarforallclients( "ui_round_end_title", 0 );
    setomnvarforallclients( "post_game_state", 0 );
    setomnvarforallclients( "ui_br_squad_eliminated_active", 0 );
    setomnvarforallclients( "ui_br_bink_overlay_state", 0 );
    level.maxteamsize = getmatchrulesdata( "commonOption", "teamSize" );
    level.br_prematchstarted = 1;
    level.teammaxfill = 1;
    level.disablespawning = 0;
    level.ignorescoring = 0;
    level.allowprematchdamage = 1;
    level.ingraceperiod = 0;
    level.var_342e7eb825a2d111 = undefined;
    level.prematchendtime = gettime();
    level.recordfinalkillcam = 1;
    level.disableweaponstats = 0;
    level.disablestattracking = 0;
    level.prematchaddkillfunc = undefined;
    level.var_9b3243830eeafdbd = 0;
    level.skipprematchdropspawn = 1;
    level.skydive_spawnprotectionactive = 0;
    setdvar( @"bot_disableallai", 1 );
    setdvar( @"br_minplayers", 150 );
    setdvar( @"live_lobby_minplayers_start", 150 );
    setdvar( @"hash_2c879521333c4987", 0 );
    setdvar( @"live_lobby_max_time", 0 );
    setdvar( @"hash_4ce07ca6680c1333", 0 );
    level.var_457bd5d6ab350c1b = level.maxteamsize;
    level.br_debugsolotest = 0;
    level.var_52ec0ab267f26a6e = 1;
    function_81b07c1b6f550d9a();
    flags::gameflagset( "prematch_fade_done" );
}

// Namespace br_dev_tests
// Params 0
// Checksum 0x2e2a2e6, Offset: 0x15a5
// Size: 0x29c
function resetplayers()
{
    foreach ( player in level.players )
    {
        if ( player isplayerheadless() )
        {
            player allowmovement( 0 );
            player allowfire( 0 );
            player allowmelee( 0 );
        }
        
        player function_b1cdc0bf7635456c( undefined );
        player br_gulag::setplayervargulag( 0 );
        player.jailed = undefined;
        player.gulagarena = undefined;
        player.wasingulag = undefined;
        player.playertospectate = undefined;
        player.nextplayertospectate = undefined;
        player.gulagloser = undefined;
        player.gulaguses = undefined;
        player.longgulagstream = undefined;
        player.gulagholding = undefined;
        player.var_7c3c15d7e28575d = undefined;
        player.spawnprotection = 0;
        player.var_b4300d21ff2d6a8e = 0;
        player.var_c19506b543ae5021 = 0;
        player.spectators = [];
        player notify( #"gulag_end" );
        player notify( #"gulag_auto_win" );
        player notify( #"last_stand_enter" );
        player laststand::exit( "last_stand_self_revive" );
        
        if ( player getstance() != "stand" )
        {
            player setstance( "stand" );
        }
        
        player.health = player.maxhealth;
        player armor::setarmorhealth( 150, 1, 1 );
        player setallstreamloaddist( 0 );
        player.setspawnpoint = undefined;
        optparams = spawnstruct();
        optparams.gulagskipped = 0;
        player br_gulag::playerrespawngulagcleanup( optparams );
        
        if ( isdefined( level.gulag ) )
        {
            player br_gulag::playergulagarenaready();
        }
        
        player br_spectate::playerclearspectatekillchainsystem();
        player.var_ad882e8f12cd3d2a = 0;
        
        if ( hasomnvar( "ui_resurgenceRespawnTimer" ) )
        {
            player br_gametype_resurgence::function_e9f3e6b5a7d226b0();
            player br_gametype_resurgence::function_6f6222b4837d3c31( 0 );
            player br_gametype_resurgence::function_dd217918caad1c89( undefined );
        }
        
        player.pers[ "controllerFreezeStack" ] = 0;
        player.pers[ "controllerFreezeDebug" ] = [];
        player freezecontrols( 0 );
        player.controlsfrozen = 0;
        player setclientdvar( @"ui_opensummary", 0 );
    }
}

// Namespace br_dev_tests
// Params 0
// Checksum 0x415d437c, Offset: 0x1849
// Size: 0x7f
function function_7237c3fd646bce26()
{
    foreach ( player in level.players )
    {
        player.respawningfromtoken = 0;
    }
}

// Namespace br_dev_tests
// Params 0
// Checksum 0xdf9cfcbf, Offset: 0x18d0
// Size: 0xa5
function resetcircles()
{
    if ( isdefined( level.br_circle.safecircleent ) )
    {
        level.br_circle.dangercircleui.hidden = 1;
        level.br_circle.dangercircleent.hidden = 1;
        level.br_circle.safecircleui.hidden = 1;
        level.br_circle.safecircleent.hidden = 1;
        level notify( #"hash_7f6b2a7b2d05df3e" );
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x86946b58, Offset: 0x197d
// Size: 0x24a
function spawnteams( args )
{
    host = gethost( args );
    spawnlocations = getspawnlocations();
    
    if ( !isdefined( level.devspectateloc ) )
    {
        level.devspectateloc = [];
    }
    
    var_fcb790562cbb9d64 = level.var_457bd5d6ab350c1b - 1;
    count = 0;
    level.var_222d71e5d7a99338 = [];
    
    for ( i = 0; i < level.teamnamelist.size ; i++ )
    {
        team = level.teamnamelist[ i ];
        
        if ( team != host.team )
        {
            level.var_222d71e5d7a99338[ count ] = team;
            count++;
            
            if ( count >= var_fcb790562cbb9d64 )
            {
                break;
            }
        }
    }
    
    reviveteam( host, host.team );
    
    for ( i = 0; i < var_fcb790562cbb9d64 ; i++ )
    {
        reviveteam( host, level.var_222d71e5d7a99338[ i ] );
    }
    
    level.var_66e7caf51a5ae03e = getteamspawnbots( host, host.team );
    level.var_d4f9f81e7fea9b3 = [];
    
    for ( i = 0; i < var_fcb790562cbb9d64 ; i++ )
    {
        level.var_d4f9f81e7fea9b3[ i ] = getteamspawnbots( host, level.var_222d71e5d7a99338[ i ] );
    }
    
    for ( i = 0; i < level.var_66e7caf51a5ae03e.size ; i++ )
    {
        player1 = level.var_66e7caf51a5ae03e[ i ];
        spawnorigin = player1.origin;
        
        if ( isdefined( spawnlocations ) )
        {
            spawnorigin = spawnlocations[ i ].origin;
        }
        
        player1 playerteleporttoloc( spawnorigin, 0 );
        
        for ( slotindex = 0; slotindex < var_fcb790562cbb9d64 ; slotindex++ )
        {
            nextplayer = level.var_d4f9f81e7fea9b3[ slotindex ][ i ];
            nextplayer playerteleporttoloc( spawnorigin, slotindex + 1 );
        }
    }
    
    level.disablespawning = 1;
    totalplayers = game_utility_mp::getlivingplayers();
    level.totalplayers = totalplayers.size;
    return [ level.var_66e7caf51a5ae03e, level.var_d4f9f81e7fea9b3 ];
}

// Namespace br_dev_tests
// Params 2
// Checksum 0xaa234592, Offset: 0x1bd0
// Size: 0xe1
function playerteleporttoloc( spawnorigin, posindex )
{
    if ( self isplayerheadless() )
    {
        self allowmovement( 0 );
        self allowfire( 0 );
        self allowmelee( 0 );
    }
    
    entnum = self getentitynumber();
    
    if ( isdefined( level.devspectateloc[ entnum ] ) )
    {
        spawnorigin = level.devspectateloc[ entnum ];
    }
    else
    {
        dir = anglestoforward( ( 0, 0, 0 ) );
        spawnorigin += dir * posindex * 50;
        spawnorigin = getgroundposition( spawnorigin, 15, 100 );
    }
    
    self setorigin( spawnorigin );
    self setplayerangles( ( 0, 0, 0 ) );
    self setvelocity( ( 0, 0, 0 ) );
    
    if ( !isdefined( level.devspectateloc[ entnum ] ) )
    {
        level.devspectateloc[ entnum ] = spawnorigin;
    }
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x47c7ec7f, Offset: 0x1cb9
// Size: 0x185
function reviveteam( host, team )
{
    teammates = level.teamdata[ team ][ "players" ];
    revivedplayers = 0;
    
    foreach ( player in teammates )
    {
        if ( !isalive( player ) || player.sessionstate != "playing" )
        {
            entnum = player getentitynumber();
            
            if ( isdefined( level.devspectateloc[ entnum ] ) )
            {
                player.forcespawnangles = ( 0, 0, 0 );
                player.forcespawnorigin = level.devspectateloc[ entnum ];
            }
            else
            {
                player.forcespawnangles = player.angles;
                player.forcespawnorigin = player.origin;
            }
            
            player spawnclientdevtest( 0 );
            revivedplayers = 1;
        }
        
        if ( player.br_iseliminated )
        {
            br_utility::unmarkplayeraseliminated( player );
        }
    }
    
    if ( revivedplayers )
    {
        host iprintlnbold( "Reviving Team: " + team );
        wait 1;
    }
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x81efae7e, Offset: 0x1e46
// Size: 0x112
function getteamspawnbots( host, team )
{
    numtospawn = 0;
    
    if ( level.teamdata[ team ][ "teamCount" ] < level.maxteamsize )
    {
        numtospawn = level.maxteamsize - level.teamdata[ team ][ "teamCount" ];
    }
    
    if ( numtospawn > 0 )
    {
        level.modespawnclient = &spawnclientdevtest;
        addbots( numtospawn, team );
        host iprintlnbold( "Spawning Team: " + team );
        timeout = gettime() + 10000;
        
        while ( gettime() < timeout && level.teamdata[ team ][ "aliveCount" ] < level.maxteamsize )
        {
            waitframe();
        }
        
        level.modespawnclient = &br::spawnclientbr;
    }
    
    assert( level.teamdata[ team ][ "<dev string:x24>" ].size == level.maxteamsize );
    return level.teamdata[ team ][ "alivePlayers" ];
}

// Namespace br_dev_tests
// Params 0
// Checksum 0xb22aa331, Offset: 0x1f61
// Size: 0xfa
function botcallback()
{
    team = self.bot_team;
    players = level.teamdata[ team ][ "players" ];
    
    for ( i = 0; i < level.maxteamsize ; i++ )
    {
        validindex = 1;
        
        foreach ( player in players )
        {
            if ( self == player )
            {
                continue;
            }
            
            if ( player.sessionuimemberindex == i )
            {
                validindex = 0;
                break;
            }
        }
        
        if ( validindex )
        {
            self.sessionuimemberindex = i;
            break;
        }
    }
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x73aaf066, Offset: 0x2063
// Size: 0x54
function addbots( numbots, team = "autoassign" )
{
    level thread [[ level.bot_funcs[ "bots_spawn" ] ]]( numbots, team, &botcallback );
    
    if ( level.matchmakingmatch )
    {
        setmatchdata( "hasBots", 1 );
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x7f387c68, Offset: 0x20bf
// Size: 0xb5
function spawnclientdevtest( revivespawn )
{
    self.class = br::pickprematchrandomloadout();
    self.pers[ "class" ] = self.class;
    playerlogic::spawnplayer( undefined, 0 );
    self freezecontrols( 1 );
    waitframe();
    self skydive_setdeploymentstatus( 0 );
    self skydive_setbasejumpingstatus( 0 );
    waitforstreaming = !self isplayerheadless();
    
    if ( waitforstreaming )
    {
        while ( isalive( self ) && isdefined( self.weaponlist ) && !self hasloadedviewweapons( self.weaponlist ) )
        {
            waitframe();
        }
    }
    
    self notify( #"hash_36e455a1fbf78b10" );
    self.waitingtospawn = 0;
    self freezecontrols( 0 );
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x5bf88d91, Offset: 0x217c
// Size: 0x3b
function function_fadeda522c33fd89( player, damage )
{
    while ( true )
    {
        if ( gasmask::function_a062bf98847b605a( player ) )
        {
            player gasmask::processdamage( damage );
            wait 1;
            continue;
        }
        
        break;
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x36fb7a6e, Offset: 0x21bf
// Size: 0xa0
function function_272854c4fbdc76fa( weapfull )
{
    weapnew = weapon::getweaponrootname( weapfull );
    
    if ( !weapon::weapondefinedinstatstable( weapnew ) )
    {
        level.weaponmapdata[ weapnew ] = spawnstruct();
        level.weaponmapdata[ weapnew ].assetname = weapfull;
        level.weaponmapdata[ weapnew ].group = "weapon_assault";
    }
    
    var_dd2db255da3902ac = weapon::buildweapon( weapnew );
    
    if ( self hasweapon( var_dd2db255da3902ac ) )
    {
        inventory_utility::_takeweapon( var_dd2db255da3902ac );
    }
    
    self giveweapon( var_dd2db255da3902ac );
    return var_dd2db255da3902ac;
}

// Namespace br_dev_tests
// Params 0
// Checksum 0x933af71c, Offset: 0x2268
// Size: 0x17
function function_e29ff97063325857()
{
    level.br_debugsolotest = 1;
    level.var_52ec0ab267f26a6e = 0;
}

// Namespace br_dev_tests
// Params 1
// Checksum 0xe2c2e456, Offset: 0x2287
// Size: 0x17
function function_b1cdc0bf7635456c( value )
{
    self.br_infilstarted = value;
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x20ea2cba, Offset: 0x22a6
// Size: 0x35
function disconnectbot( botplayer )
{
    if ( !botplayer )
    {
        return;
    }
    
    assert( isbot( botplayer ) );
    kick( botplayer getentitynumber(), &"exe/playerkicked_bot_balance" );
}

// Namespace br_dev_tests
// Params 3
// Checksum 0x5d4261de, Offset: 0x22e3
// Size: 0x76
function damageplayer( victim, var_111a328d1682630a, amount = 50 )
{
    enemy = var_111a328d1682630a;
    
    if ( isarray( var_111a328d1682630a ) )
    {
        enemy = getnearbyaliveplayer( victim.origin, var_111a328d1682630a );
    }
    
    victim dodamage( amount, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon() );
    return enemy;
}

// Namespace br_dev_tests
// Params 3
// Checksum 0xe66e7ac7, Offset: 0x2362
// Size: 0xd9
function function_c422639df6615578( victim, var_111a328d1682630a, timedelay )
{
    if ( !victim )
    {
        return;
    }
    
    if ( !isdefined( timedelay ) )
    {
        timedelay = 1;
    }
    
    if ( !isdefined( victim.perks[ "specialty_pistoldeath" ] ) )
    {
        victim perk::giveperk( "specialty_pistoldeath" );
    }
    
    enemy = var_111a328d1682630a;
    
    if ( isarray( var_111a328d1682630a ) )
    {
        enemy = getnearbyaliveplayer( victim.origin, var_111a328d1682630a );
    }
    
    victim dodamage( 500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon() );
    wait timedelay;
    
    while ( isalive( victim ) )
    {
        victim dodamage( 500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon() );
        waitframe();
    }
    
    return enemy;
}

// Namespace br_dev_tests
// Params 2
// Checksum 0xd4c2b55d, Offset: 0x2444
// Size: 0x99
function killplayer( victim, var_111a328d1682630a )
{
    enemy = var_111a328d1682630a;
    
    if ( isarray( var_111a328d1682630a ) )
    {
        enemy = getnearbyaliveplayer( victim.origin, var_111a328d1682630a );
    }
    
    victim dodamage( 500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon() );
    wait 1;
    
    while ( isalive( victim ) )
    {
        victim dodamage( 500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon() );
        waitframe();
    }
    
    return enemy;
}

// Namespace br_dev_tests
// Params 3
// Checksum 0xc616a5fe, Offset: 0x24e6
// Size: 0xbc
function killplayerinstant( victim, var_111a328d1682630a, keeplaststand )
{
    enemy = var_111a328d1682630a;
    
    if ( isarray( var_111a328d1682630a ) )
    {
        enemy = getnearbyaliveplayer( victim.origin, var_111a328d1682630a );
    }
    
    if ( !isdefined( enemy ) )
    {
        enemy = victim;
    }
    
    if ( !keeplaststand && isdefined( victim.perks[ "specialty_pistoldeath" ] ) )
    {
        victim perk::removeperk( "specialty_pistoldeath" );
    }
    
    while ( isalive( victim ) )
    {
        victim dodamage( 500, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon() );
        
        if ( !isalive( victim ) )
        {
            break;
        }
        
        waitframe();
    }
    
    return enemy;
}

// Namespace br_dev_tests
// Params 2
// Checksum 0xb716f0b5, Offset: 0x25ab
// Size: 0xaa
function putinlaststand( player, var_111a328d1682630a )
{
    enemy = var_111a328d1682630a;
    
    if ( isarray( var_111a328d1682630a ) )
    {
        enemy = getnearbyaliveplayer( player.origin, var_111a328d1682630a );
    }
    
    if ( !isdefined( enemy ) )
    {
        enemy = player;
    }
    
    if ( !isdefined( player.perks[ "specialty_pistoldeath" ] ) )
    {
        player perk::giveperk( "specialty_pistoldeath" );
    }
    
    while ( !player.inlaststand )
    {
        player dodamage( 30, enemy.origin, enemy, undefined, "MOD_EXPLOSIVE", enemy getcurrentprimaryweapon() );
        wait 0.1;
    }
    
    return enemy;
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x71d11453, Offset: 0x265e
// Size: 0xb9
function function_990e587147e3db02( player )
{
    inflictor = undefined;
    
    if ( isdefined( player.laststandattacker ) )
    {
        inflictor = player.laststandattacker;
    }
    else if ( isdefined( player.laststanddowneddata ) && isdefined( player.laststanddowneddata.attacker ) )
    {
        inflictor = player.laststanddowneddata.attacker;
    }
    else
    {
        inflictor = player;
    }
    
    player dodamage( player.health + 1000, player.origin, player, inflictor, "MOD_TRIGGER_HURT", makeweapon( level.laststandweapon ), "none" );
}

// Namespace br_dev_tests
// Params 4
// Checksum 0x1443d91a, Offset: 0x271f
// Size: 0x2a3
function scriptcircleat( safeorigin, saferadius, dangerorigin, dangerradius )
{
    if ( !isdefined( level.br_circle.safecircleent ) )
    {
        thread br_circle::runcircles( 1 );
        level.br_circle thread br_circle::circledamagetick();
    }
    
    waitframe();
    level notify( #"hash_161c3d8f1cc2d1ea" );
    circleindex = 0;
    level.br_circle.starttime = gettime();
    level.br_circle.circleindex = circleindex;
    var_b2827c0c6de965f2 = circleindex == level.br_level.br_circleclosetimes.size - 1;
    setomnvar( "ui_br_circle_num", circleindex + 1 );
    level.br_level.br_circleradii = [ dangerradius, saferadius ];
    var_bc0fc2a438ccdb67 = ( safeorigin[ 0 ], safeorigin[ 1 ], saferadius );
    level.br_circle.centertarget = var_bc0fc2a438ccdb67;
    level.br_circle.safecircleent.origin = var_bc0fc2a438ccdb67;
    level.br_circle.dangercircleui.hidden = 0;
    level.br_circle.dangercircleent.hidden = 0;
    level.br_circle.safecircleui.hidden = 0;
    level.br_circle.safecircleent.hidden = 0;
    level notify( #"hash_7f6b2a7b2d05df3e" );
    level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
    level.br_circle.dangercircleui.origin = ( dangerorigin[ 0 ], dangerorigin[ 1 ], dangerradius );
    br_circle::setstaticuicircles( 999, level.br_circle.safecircleui, level.br_circle.dangercircleui, var_b2827c0c6de965f2 );
    level notify( #"br_circle_set" );
    waitframe();
    level notify( #"br_circle_started" );
    level.br_circle.dangercircleent brcirclemoveto( dangerorigin[ 0 ], dangerorigin[ 1 ], dangerradius, 1 );
    level notify( #"infils_ready" );
}

// Namespace br_dev_tests
// Params 2
// Checksum 0xddf8c23f, Offset: 0x29ca
// Size: 0x30
function setnumteams( args, numteams )
{
    if ( numteams <= 0 )
    {
        return;
    }
    
    level.var_457bd5d6ab350c1b = numteams;
    return spawnteams( args );
}

// Namespace br_dev_tests
// Params 1
// Checksum 0xe782fcb9, Offset: 0x2a03
// Size: 0x26
function function_2610bdbc76709973( player )
{
    while ( !player isspectatingplayer() || player player::isinkillcam() )
    {
        waitframe();
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0xbdae926b, Offset: 0x2a31
// Size: 0x36
function function_5aabcb7460bfd4b5( player )
{
    while ( player.sessionstate != "spectator" && player.killcam != 1 )
    {
        waitframe();
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x11baa6b2, Offset: 0x2a6f
// Size: 0x4b
function function_3c936eb573b412c0( player )
{
    while ( player.sessionstate == "dead" || player.sessionstate != "spectator" || player.killcam == 1 )
    {
        waitframe();
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x7ed68b21, Offset: 0x2ac2
// Size: 0x26
function function_4a2850a247fe47c9( player )
{
    player endon( #"hash_ed25060c573844a0" );
    level waittill( #"forever" );
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x83f30768, Offset: 0x2af0
// Size: 0x2f
function waittillplayeractive( player )
{
    while ( !isalive( player ) && player.sessionstate != "playing" )
    {
        waitframe();
    }
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x201f280a, Offset: 0x2b27
// Size: 0x38
function function_40f98be3db373c08( player )
{
    player setorigin( br_public::droptogroundmultitrace( player.origin ) );
    player setvelocity( ( 0, 0, 0 ) );
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x6164d687, Offset: 0x2b67
// Size: 0xa1
function getnearbyaliveplayer( org, players )
{
    players = function_5713d46873b29625( players );
    players = sortbydistance( players, org );
    
    if ( isalive( players[ 0 ] ) )
    {
        dist = distance2dsquared( org, players[ 0 ].origin );
        
        if ( dist < 40000 )
        {
            return players[ 0 ];
        }
    }
    
    aliveplayer = undefined;
    
    for ( i = 1; i < players.size ; i++ )
    {
        player = players[ i ];
        
        if ( isalive( player ) )
        {
            aliveplayer = player;
            break;
        }
    }
    
    return aliveplayer;
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x34703f88, Offset: 0x2c11
// Size: 0x89, Type: bool
function argshave( args, token )
{
    foreach ( arg in args )
    {
        if ( arg == token )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_dev_tests
// Params 1
// Checksum 0x7a8dbfd2, Offset: 0x2ca3
// Size: 0x1a2
function gethost( args )
{
    var_7237854e3be197ca = level.devspectatetesthost;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    host = gamelogic_mp::gethostplayer();
    
    if ( argshave( args, "clientHost" ) )
    {
        foreach ( player in level.players )
        {
            if ( !isai( player ) && !player isplayerheadless() && ( !isdefined( host ) || player != host ) )
            {
                host = player;
                break;
            }
        }
    }
    else if ( !isdefined( host ) )
    {
        foreach ( player in level.players )
        {
            if ( !isai( player ) && !player isplayerheadless() )
            {
                level.devspectatetesthost = player;
                host = player;
                break;
            }
        }
    }
    else
    {
        level.maxteamsize = 3;
    }
    
    if ( !isdefined( level.devspectatetesthost ) )
    {
        level.devspectatetesthost = host;
    }
    
    return host;
}

// Namespace br_dev_tests
// Params 3
// Checksum 0x81f7813d, Offset: 0x2e4e
// Size: 0x23f
function getallplayers( host, hostteammates, enemyteammates )
{
    if ( !level.enemy1 || !level.enemy2 || !level.enemy3 || !level.var_e9cc371400fe5a1e || !level.enemya || !level.enemyb || !level.enemyc || !level.enemyd || !level.friendly1 || !level.friendly2 || !level.var_18989cc3650ea6da )
    {
        level.enemy1 = enemyteammates[ 0 ][ 0 ];
        level.enemy2 = enemyteammates[ 0 ][ 1 ];
        level.enemy3 = enemyteammates[ 0 ][ 2 ];
        level.var_e9cc371400fe5a1e = enemyteammates[ 0 ][ 3 ];
        level.enemya = enemyteammates[ 1 ][ 0 ];
        level.enemyb = enemyteammates[ 1 ][ 1 ];
        level.enemyc = enemyteammates[ 1 ][ 2 ];
        level.enemyd = enemyteammates[ 1 ][ 3 ];
        level.friendly1 = hostteammates[ 1 ];
        level.friendly2 = hostteammates[ 2 ];
        level.var_18989cc3650ea6da = hostteammates[ 3 ];
        
        if ( level.friendly1 == host )
        {
            level.friendly1 = hostteammates[ 0 ];
        }
        else if ( level.friendly2 == host )
        {
            level.friendly2 = hostteammates[ 0 ];
        }
        else if ( level.var_18989cc3650ea6da == host )
        {
            level.var_18989cc3650ea6da = hostteammates[ 0 ];
        }
    }
    
    return [ level.enemy1, level.enemy2, level.enemy3, level.var_e9cc371400fe5a1e, level.enemya, level.enemyb, level.enemyc, level.enemyd, level.friendly1, level.friendly2, level.var_18989cc3650ea6da ];
}

// Namespace br_dev_tests
// Params 0
// Checksum 0xed13ca63, Offset: 0x3096
// Size: 0x79
function playerstartrecondronewait()
{
    pickupent = spawnstruct();
    pickupent.scriptablename = "brloot_killstreak_recondrone";
    pickupent.count = 1;
    br_pickups::takesuperpickup( pickupent );
    wait 1;
    superweapon = makeweapon( %"super_default_mp" );
    supers_mp::trysuperusebegin( superweapon );
    
    while ( self getcurrentprimaryweapon().basename != "ks_remote_drone_mp" )
    {
        waitframe();
    }
}

// Namespace br_dev_tests
// Params 0
// Checksum 0x2bc19626, Offset: 0x3117
// Size: 0x4b
function function_5e6fc806ffc84fac()
{
    item = function_a78f474632a75e4c( self, %"brloot_super_jammer" );
    common_item::items_scriptable_used( item, "brloot_super_jammer", "visible", self, 0, "brloot_super_reinforcement_flare" );
    
    if ( isbot( self ) )
    {
        self botpressbutton( "special" );
    }
}

// Namespace br_dev_tests
// Params 2
// Checksum 0x3fc3644d, Offset: 0x316a
// Size: 0x1f
function waitandsuicide( delaytime, player )
{
    wait delaytime;
    player suicide();
}

// Namespace br_dev_tests
// Params 0
// Checksum 0xd9dddfa1, Offset: 0x3191
// Size: 0x6f
function onprematchstarted2()
{
    level notify( #"onprematchfadedoneclear" );
    level thread onprematchfadedone2();
    c130pathstruct = undefined;
    
    if ( !level.br_infils_disabled )
    {
        c130pathstruct = br_c130::createtestc130path();
    }
    
    waitframe();
    level.br_c130spawndone = 0;
    level.br_latejoininfilready = 0;
    br_infils_legacy::beginbrc130playeraniminfilsequence( c130pathstruct, "player" );
    level thread br_c130::waittoplayinfildialog();
    level notify( #"infils_ready" );
}

// Namespace br_dev_tests
// Params 0
// Checksum 0x55025a1d, Offset: 0x3208
// Size: 0x1e9
function onprematchfadedone2()
{
    var_2b28773d42df7c0c = 1.4;
    level endon( #"onprematchfadedoneclear" );
    
    if ( !isdefined( level.spectatetestonprematchfadedone ) )
    {
        level.spectatetestonprematchfadedone = 1;
        return;
    }
    
    flags::gameflagwait( "prematch_fade_done" );
    level thread br::resetalldoors( var_2b28773d42df7c0c * 1.5 );
    level thread calloutmarkerping::function_e2222b6148ff1148( 1 );
    level thread br_vehicles::brvehicleonprematchstarted();
    level thread br_functional_poi::onprematchdone();
    br::cleanupmolotovs();
    br_vehicles::emptyallvehicles();
    
    foreach ( player in level.players )
    {
        player br::setplayerprematchallows();
        player thread br_pickups::resetplayerinventory();
        
        if ( player.hasspawned )
        {
            player thread weapons::deleteplacedequipment();
        }
    }
    
    level.freefallstartcb = &br::freefallstartfunc;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.burninginfo ) )
        {
            player molotov::molotov_clear_burning();
        }
        
        player javelin::javelin_forceclear();
    }
    
    level notify( #"prematch_cleanup" );
    callback::callback( #"prematch_cleanup", {} );
    flags::gameflagset( "prematch_cleanup_done" );
    
    if ( !level.br_circle_disabled )
    {
        level thread br_circle::runcircles( 1 );
    }
}

// Namespace br_dev_tests
// Params 3
// Checksum 0x647d70cb, Offset: 0x33f9
// Size: 0x1e9
function function_a78f474632a75e4c( player, scriptablename, spawnpos = player.origin + anglestoforward( player.angles ) * 100 + ( 0, 0, 12 ) )
{
    initialcount = 0;
    
    if ( isdefined( level.br_pickups.counts[ scriptablename ] ) )
    {
        initialcount = level.br_pickups.counts[ scriptablename ];
    }
    
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( spawnpos );
    item = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( scriptablename, initialcount, spawnoptions );
    
    if ( br_pickups::isquesttablet( scriptablename ) )
    {
        br_contract_manager::function_a0e70de0d9b56fb0( item, scriptablename );
    }
    
    if ( isdefined( item ) )
    {
        contents = trace::create_contents( 0, 1, 0, 0, 0, 1, 1, 0, 0 );
        ignorelist = [];
        caststart = item.origin + ( 0, 0, 50 );
        castend = caststart + ( 0, 0, -200 );
        traceresult = trace::ray_trace( caststart, castend, ignorelist, contents );
        
        if ( isdefined( traceresult[ "entity" ] ) && traceresult[ "entity" ].targetname == "train_wz" )
        {
            trainent = traceresult[ "entity" ];
            localorigin = rotatevectorinverted( item.origin - trainent.origin, trainent.angles );
            localangles = combineangles( invertangles( trainent.angles ), item.angles );
            item utility::scriptable_setparententity( trainent, localorigin, localangles );
        }
    }
    
    return item;
}

// Namespace br_dev_tests
// Params 4
// Checksum 0xc5db74e1, Offset: 0x35eb
// Size: 0x197
function testskillchain( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "killchain" ) )
    {
        for ( playertospectate = host br_spectate::playergetspectatingplayer(); !isdefined( playertospectate ) ; playertospectate = host br_spectate::playergetspectatingplayer() )
        {
            waitframe();
        }
        
        killplayer( playertospectate, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        wait 3;
    }
    
    if ( argshave( args, "killchain" ) )
    {
        for ( playertospectate = host br_spectate::playergetspectatingplayer(); !isdefined( playertospectate ) ; playertospectate = host br_spectate::playergetspectatingplayer() )
        {
            waitframe();
        }
        
        killplayer( playertospectate, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        wait 3;
    }
    
    if ( argshave( args, "killchain" ) )
    {
        for ( playertospectate = host br_spectate::playergetspectatingplayer(); !isdefined( playertospectate ) ; playertospectate = host br_spectate::playergetspectatingplayer() )
        {
            waitframe();
        }
        
        killplayer( playertospectate, enemyteammates[ 1 ] );
        br_spectate::waittillspectating( host );
        wait 3;
    }
    
    if ( argshave( args, "killchain" ) )
    {
        for ( playertospectate = host br_spectate::playergetspectatingplayer(); !isdefined( playertospectate ) ; playertospectate = host br_spectate::playergetspectatingplayer() )
        {
            waitframe();
        }
        
        killplayer( playertospectate, enemyteammates[ 1 ] );
        br_spectate::waittillspectating( host );
        wait 3;
    }
    
    if ( argshave( args, "killchain" ) )
    {
        for ( playertospectate = host br_spectate::playergetspectatingplayer(); !isdefined( playertospectate ) ; playertospectate = host br_spectate::playergetspectatingplayer() )
        {
            waitframe();
        }
        
        killplayer( playertospectate, enemyteammates[ 1 ] );
        br_spectate::waittillspectating( host );
        wait 3;
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0x371bc7a8, Offset: 0x378a
// Size: 0x134a
function testsgulag( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "gulag1" ) )
    {
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                player function_b1cdc0bf7635456c( 1 );
                killplayer( player, enemyteammates[ 0 ] );
            }
        }
        
        wait 10;
        killplayer( host, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "gulag2" ) || argshave( args, "gulag3" ) )
    {
        killplayer( host, enemyteammates[ 0 ] );
        host waittill( #"killcam_ended" );
        wait 2;
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                player function_b1cdc0bf7635456c( 1 );
                killplayer( player, enemyteammates[ 0 ] );
            }
        }
        
        while ( !isdefined( host getspectatingplayer() ) )
        {
            waitframe();
        }
        
        friendly = host getspectatingplayer();
        friendly function_b1cdc0bf7635456c( 1 );
        wait 1;
        
        foreach ( player in enemyteammates[ 0 ] )
        {
            player function_b1cdc0bf7635456c( 1 );
            killplayer( player, enemyteammates[ 1 ] );
        }
        
        while ( !friendly.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        
        if ( argshave( args, "gulag2" ) )
        {
            setspawnpoint = spawnstruct();
            setspawnpoint.playerspawnpos = ( 26474, -16709, -162 );
            setspawnpoint.playerspawnangles = ( 85, 135, 0 );
            friendly.setspawnpoint = setspawnpoint;
            
            foreach ( player in enemyteammates[ 0 ] )
            {
                if ( player.gulagarena )
                {
                    player function_b1cdc0bf7635456c( 1 );
                    killplayer( player, enemyteammates[ 1 ] );
                    break;
                }
            }
            
            while ( !friendly islinked() )
            {
                waitframe();
            }
            
            while ( friendly islinked() )
            {
                waitframe();
            }
            
            waitframe();
            playerangles = friendly getplayerangles();
            friendly setplayerangles( ( 85, playerangles[ 1 ], 0 ) );
        }
        else
        {
            killplayer( friendly, enemyteammates[ 1 ] );
        }
    }
    
    if ( argshave( args, "gulag4" ) )
    {
        host function_b1cdc0bf7635456c( 1 );
        enemy = killplayer( host, enemyteammates[ 0 ] );
        enemy function_b1cdc0bf7635456c( 1 );
        killplayer( enemy, hostteammates );
    }
    
    if ( argshave( args, "gulaggulag" ) )
    {
        first = getdvarint( @"hash_ad0ddaf795b2ef1a", 0 );
        second = getdvarint( @"hash_ad0dd9f795b2ece7", 5 );
        setdvar( @"hash_e5f703a38f6e8043", 9999 );
        setdvar( @"hash_8bdee07fa09e810a", first );
        host function_b1cdc0bf7635456c( 1 );
        enemy = killplayer( host, enemyteammates[ 0 ] );
        setdvar( @"hash_8bdee07fa09e810a", second );
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                player function_b1cdc0bf7635456c( 1 );
                killplayer( player, enemyteammates[ 0 ] );
            }
        }
        
        setdvar( @"hash_8bdee07fa09e810a", first );
        enemy function_b1cdc0bf7635456c( 1 );
        killplayer( enemy, enemyteammates[ 1 ] );
        
        while ( !host.gulagarena && !enemy.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        killplayer( host, enemy );
        setdvar( @"hash_e5f703a38f6e8043", 90 );
    }
    
    if ( argshave( args, "gulag5" ) || argshave( args, "gulag6" ) )
    {
        nothost = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( !isdefined( nothost ) && player != host )
            {
                nothost = player;
                continue;
            }
            
            killplayer( player, enemyteammates[ 0 ] );
            br_spectate::waittillspectating( player );
        }
        
        nothost function_b1cdc0bf7635456c( 1 );
        
        if ( argshave( args, "gulag6" ) )
        {
            setdvar( @"hash_e5f703a38f6e8043", 9999 );
            first = getdvarint( @"hash_ad0ddaf795b2ef1a", 5 );
            setdvar( @"hash_8bdee07fa09e810a", first );
            nothost.longgulagstream = 1;
        }
        
        killplayer( nothost, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "gulag7" ) )
    {
        killplayer( host, enemyteammates[ 0 ] );
        host waittill( #"killcam_ended" );
        wait 2;
        gulagplayer = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                player function_b1cdc0bf7635456c( 1 );
                gulagplayer = player;
                gulagplayer br_gulag::initplayerjail();
                break;
            }
        }
        
        while ( !isdefined( host getspectatingplayer() ) )
        {
            waitframe();
        }
        
        wait 1;
        gulagenemy = undefined;
        
        foreach ( player in enemyteammates[ 0 ] )
        {
            player function_b1cdc0bf7635456c( 1 );
            gulagenemy = player;
            killplayer( player, enemyteammates[ 1 ] );
            break;
        }
        
        while ( !gulagplayer.gulagarena && !gulagenemy.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        setdvar( @"scr_br_gulag_win_hold", 1 );
        killplayer( gulagenemy, gulagplayer );
        
        while ( host getspectatingplayer() != gulagplayer )
        {
            println( "<dev string:x31>" );
            wait 1;
        }
        
        wait 10;
        setdvar( @"scr_br_gulag_win_hold", 0 );
    }
    
    if ( argshave( args, "gulag8" ) )
    {
        level.gulag.timelimit = 3;
        setdvar( @"scr_br_fc_overtime", 3 );
        setdvar( @"hash_e5f703a38f6e8043", -1 );
        killplayer( host, enemyteammates[ 0 ] );
        host waittill( #"killcam_ended" );
        wait 2;
        gulagplayer = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                player function_b1cdc0bf7635456c( 1 );
                gulagplayer = player;
                gulagplayer br_gulag::initplayerjail();
                break;
            }
        }
        
        while ( !isdefined( host getspectatingplayer() ) )
        {
            waitframe();
        }
        
        while ( host getspectatingplayer() != gulagplayer )
        {
            iprintlnbold( "Switch to spectating gulag player" );
            waitframe();
        }
        
        wait 1;
        gulagenemy = undefined;
        
        foreach ( player in enemyteammates[ 0 ] )
        {
            player function_b1cdc0bf7635456c( 1 );
            gulagenemy = player;
            killplayer( player, enemyteammates[ 1 ] );
            break;
        }
    }
    
    if ( argshave( args, "gulag9" ) )
    {
        host function_b1cdc0bf7635456c( 1 );
        enemy = killplayer( host, enemyteammates[ 0 ] );
        enemy function_b1cdc0bf7635456c( 1 );
        killplayer( enemy, hostteammates );
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                killplayer( player, enemyteammates[ 0 ] );
            }
        }
        
        foreach ( player in enemyteammates[ 0 ] )
        {
            if ( player != enemy )
            {
                killplayer( player, enemyteammates[ 1 ] );
            }
        }
        
        while ( !host.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        setdvar( @"scr_br_gulag_win_hold", 1 );
        setdvar( @"hash_2c879521333c4987", 3 );
        killplayer( host, enemy );
        wait 9;
        setdvar( @"scr_br_gulag_win_hold", 0 );
        setdvar( @"hash_2c879521333c4987", 0 );
    }
    
    if ( argshave( args, "gulag10" ) )
    {
        var_30d66a3a0ddc4e9 = enemyteammates[ 0 ][ 0 ];
        var_30d66a3a0ddc4e9 function_b1cdc0bf7635456c( 1 );
        killplayer( var_30d66a3a0ddc4e9, enemyteammates[ 1 ] );
        var_30d63a3a0ddbe50 = enemyteammates[ 1 ][ 0 ];
        var_30d63a3a0ddbe50 function_b1cdc0bf7635456c( 1 );
        killplayer( var_30d63a3a0ddbe50, enemyteammates[ 0 ] );
        wait 1;
        var_308fea3a0d8ea5a = host;
        var_308fea3a0d8ea5a function_b1cdc0bf7635456c( 1 );
        killplayer( var_308fea3a0d8ea5a, enemyteammates[ 0 ] );
        var_308fda3a0d8e827 = enemyteammates[ 0 ][ 1 ];
        var_308fda3a0d8e827 function_b1cdc0bf7635456c( 1 );
        killplayer( var_308fda3a0d8e827, enemyteammates[ 1 ] );
        
        while ( !var_30d66a3a0ddc4e9.gulagarena || !var_30d63a3a0ddbe50.gulagarena || !var_308fea3a0d8ea5a.jailed || !var_308fda3a0d8e827.jailed )
        {
            waitframe();
        }
        
        setdvar( @"scr_br_hold_in_gulag", 1 );
        playerc = enemyteammates[ 1 ][ 1 ];
        playerc function_b1cdc0bf7635456c( 1 );
        killplayer( playerc, enemyteammates[ 0 ] );
        wait 1;
        
        while ( playerc.gulagloading )
        {
            waitframe();
        }
        
        br_gulag::shutdowngulag( "circle_index", 0 );
        wait 1;
        disconnectbot( playerc );
        wait 3;
        setdvar( @"scr_br_hold_in_gulag", 0 );
    }
    
    if ( argshave( args, "gulag11" ) )
    {
        host function_b1cdc0bf7635456c( 1 );
        putinlaststand( host, enemyteammates[ 1 ] );
        wait 1;
        br_gulag::shutdowngulag( "circle_index", 0 );
        wait 1;
        host laststand::exit( "last_stand_self_revive" );
        wait 10;
        killplayer( host, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "reconGulag1" ) )
    {
        setdvar( @"br_minplayers", 9 );
        wait 5;
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 1 ][ 0 ];
        disconnectbot( enemyteammates[ 0 ][ 2 ] );
        disconnectbot( enemyteammates[ 0 ][ 1 ] );
        disconnectbot( enemyteammates[ 1 ][ 2 ] );
        disconnectbot( enemyteammates[ 1 ][ 1 ] );
        disconnectbot( hostteammates[ 2 ] );
        disconnectbot( hostteammates[ 1 ] );
        wait 1;
        host playerstartrecondronewait();
        enemy1 function_b1cdc0bf7635456c( 1 );
        killplayerinstant( enemy1, enemy2 );
        wait 7;
        host function_b1cdc0bf7635456c( 1 );
        
        if ( !isdefined( host.perks[ "specialty_pistoldeath" ] ) )
        {
            host perk::giveperk( "specialty_pistoldeath" );
        }
        
        killplayerinstant( host, enemy2, 1 );
        
        while ( !host.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        killplayerinstant( enemy1, host );
    }
    
    if ( argshave( args, "reconGulag2" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( enemyteammates[ 0 ][ 2 ] );
        disconnectbot( enemyteammates[ 1 ][ 2 ] );
        disconnectbot( enemyteammates[ 1 ][ 1 ] );
        disconnectbot( enemyteammates[ 1 ][ 0 ] );
        killplayerinstant( friendly2, enemy1 );
        wait 1;
        friendly1 playerstartrecondronewait();
        wait 2;
        killplayerinstant( host, enemy1 );
        host waittill( #"killcam_ended" );
        wait 3;
        enemy2 function_b1cdc0bf7635456c( 1 );
        killplayerinstant( enemy2, friendly1 );
        friendly1 function_b1cdc0bf7635456c( 1 );
        
        if ( !isdefined( friendly1.perks[ "specialty_pistoldeath" ] ) )
        {
            friendly1 perk::giveperk( "specialty_pistoldeath" );
        }
        
        killplayerinstant( friendly1, enemy1, 1 );
        
        while ( !friendly1.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        killplayerinstant( friendly1, enemy2 );
    }
    
    if ( argshave( args, "gulagqueue" ) )
    {
        arena = getdvarint( @"hash_ad0ddaf795b2ef1a", 0 );
        setdvar( @"hash_8bdee07fa09e810a", arena );
        setdvar( @"hash_8be34599dfa102b8", 30 );
        setdvar( @"scr_br_fc_overtime", 9999 );
        setdvar( @"hash_e5f703a38f6e8043", 9999 );
        setdvar( @"scr_br_fc_flag_capture_time", 300 );
        enemyteammates[ 0 ][ 0 ] function_b1cdc0bf7635456c( 1 );
        killplayer( enemyteammates[ 0 ][ 0 ], enemyteammates[ 1 ] );
        enemyteammates[ 1 ][ 0 ] function_b1cdc0bf7635456c( 1 );
        killplayer( enemyteammates[ 1 ][ 0 ], enemyteammates[ 0 ] );
        wait 1;
        enemyteammates[ 0 ][ 1 ] function_b1cdc0bf7635456c( 1 );
        killplayer( enemyteammates[ 0 ][ 1 ], enemyteammates[ 1 ] );
        enemyteammates[ 1 ][ 1 ] function_b1cdc0bf7635456c( 1 );
        killplayer( enemyteammates[ 1 ][ 1 ], enemyteammates[ 0 ] );
        wait 1;
        hostteammates[ 1 ] function_b1cdc0bf7635456c( 1 );
        killplayer( hostteammates[ 1 ], enemyteammates[ 1 ] );
        enemyteammates[ 0 ][ 2 ] function_b1cdc0bf7635456c( 1 );
        killplayer( enemyteammates[ 0 ][ 2 ], enemyteammates[ 1 ] );
        wait 1;
        host function_b1cdc0bf7635456c( 1 );
        killplayer( host, enemyteammates[ 1 ] );
        enemyteammates[ 1 ][ 2 ] function_b1cdc0bf7635456c( 1 );
        killplayer( enemyteammates[ 1 ][ 2 ], host );
    }
    
    if ( argshave( args, "gulag_die_same_frame" ) )
    {
        host function_b1cdc0bf7635456c( 1 );
        enemy = killplayer( host, enemyteammates[ 0 ] );
        enemy function_b1cdc0bf7635456c( 1 );
        killplayer( enemy, hostteammates );
        
        while ( !enemy.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        host dodamage( 500, enemy.origin, enemy, undefined, "MOD_RIFLE_BULLET", enemy getcurrentprimaryweapon() );
        enemy dodamage( 500, host.origin, host, undefined, "MOD_RIFLE_BULLET", host getcurrentprimaryweapon() );
        host dodamage( 500, enemy.origin, enemy, undefined, "MOD_RIFLE_BULLET", enemy getcurrentprimaryweapon() );
        enemy dodamage( 500, host.origin, host, undefined, "MOD_RIFLE_BULLET", host getcurrentprimaryweapon() );
    }
    
    if ( argshave( args, "gulag_spectated_player" ) )
    {
        function_e29ff97063325857();
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 1 ][ 0 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( enemyteammates[ 0 ][ 2 ] );
        disconnectbot( enemyteammates[ 0 ][ 1 ] );
        disconnectbot( enemyteammates[ 1 ][ 2 ] );
        disconnectbot( enemyteammates[ 1 ][ 1 ] );
        disconnectbot( hostteammates[ 2 ] );
        disconnectbot( hostteammates[ 1 ] );
        killplayer( host, enemy1 );
        br_spectate::waittillspectating( host );
        wait 2;
        enemy = host br_spectate::playergetspectatingplayer();
        assert( enemy == enemy1 );
        enemy1 function_b1cdc0bf7635456c( 1 );
        killplayer( enemy1, enemy2 );
        br_spectate::waittillspectating( host );
        wait 2;
        enemy = host br_spectate::playergetspectatingplayer();
        assert( enemy == enemy2 );
    }
    
    if ( argshave( args, "gulag_buyback" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 1 ][ 0 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly2 );
        enemy1 function_b1cdc0bf7635456c( 1 );
        killplayer( enemy1, friendly1 );
        friendly1 function_b1cdc0bf7635456c( 1 );
        killplayer( friendly1, enemy2 );
        
        while ( !friendly1.gulagarena )
        {
            waitframe();
        }
        
        wait 12;
        killplayer( friendly1, enemy1 );
        host iprintlnbold( "Gulag Done" );
        wait getdvarint( @"scr_wait", 3 );
        host currency::add_currency_amount( "cash", 300 );
        host thread [[ level.var_952b959a42f49b29 ]]( 0 );
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0x18076587, Offset: 0x4adc
// Size: 0x338d
function function_c751dff3bd2d2dfe( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "killcam1" ) || argshave( args, "killchain" ) || argshave( args, "disconnect1" ) || argshave( args, "disconnect2" ) || argshave( args, "disconnect3" ) )
    {
        killplayer( host, enemyteammates[ 0 ] );
        
        if ( argshave( args, "disconnect2" ) )
        {
            while ( host.sessionstate != "intermission" )
            {
                waitframe();
            }
            
            while ( host.sessionstate == "intermission" )
            {
                waitframe();
            }
        }
        else if ( argshave( args, "disconnect3" ) )
        {
            while ( host.sessionstate != "intermission" )
            {
                waitframe();
            }
            
            wait 0.5;
        }
        else
        {
            br_spectate::waittillspectating( host );
            wait 3;
            
            if ( argshave( args, "disconnect1" ) )
            {
                host iprintlnbold( "Waiting" );
                wait 10;
            }
        }
    }
    
    if ( argshave( args, "disconnect1" ) || argshave( args, "disconnect2" ) || argshave( args, "disconnect3" ) )
    {
        playertospectate = host br_spectate::playergetspectatingplayer();
        disconnectbot( playertospectate );
    }
    
    if ( argshave( args, "killkill" ) )
    {
        enemy = enemyteammates[ 0 ][ 0 ];
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                killplayer( player, enemy );
            }
        }
        
        killplayer( enemy, host );
        wait 10;
        killplayer( host, enemy );
    }
    
    if ( argshave( args, "killcam2" ) )
    {
        enemy = killplayer( host, enemyteammates[ 0 ] );
        wait 3;
        killplayer( host.nextplayertospectate, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "killcam3" ) )
    {
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 1 ][ 0 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        host function_b1cdc0bf7635456c( 1 );
        killplayer( host, enemy1 );
        wait 4;
        killplayer( enemy1, friendly1 );
    }
    
    if ( argshave( args, "twooneframe" ) )
    {
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                killplayer( player, enemyteammates[ 0 ] );
                break;
            }
        }
        
        wait 5;
        
        foreach ( player in hostteammates )
        {
            if ( isalive( player ) )
            {
                killplayerinstant( player, enemyteammates[ 0 ] );
            }
        }
    }
    
    if ( argshave( args, "suicide" ) )
    {
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                killplayer( player, enemyteammates[ 0 ] );
            }
        }
        
        wait 5;
        
        if ( isdefined( host.perks[ "specialty_pistoldeath" ] ) )
        {
            host perk::removeperk( "specialty_pistoldeath" );
        }
        
        host suicide();
    }
    
    if ( argshave( args, "team" ) )
    {
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                killplayerinstant( player, enemyteammates[ 0 ] );
            }
        }
    }
    
    if ( argshave( args, "team_kill1" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        function_c422639df6615578( host, enemyteammates[ 0 ] );
        function_2610bdbc76709973( host );
        player1 = host getspectatingplayer();
        player2 = undefined;
        player3 = undefined;
        
        foreach ( teammate in hostteammates )
        {
            if ( teammate == host )
            {
                continue;
            }
            
            if ( !player2 && teammate != player1 )
            {
                player2 = teammate;
                continue;
            }
            
            if ( !player3 && teammate != player2 && teammate != player1 )
            {
                player3 = teammate;
            }
        }
        
        if ( player2 br_public::hasrespawntoken() )
        {
            player2 item_redeploy_token::function_16ab0a48337237ef( 1 );
        }
        
        wait 5;
        function_c422639df6615578( player1, enemyteammates[ 0 ] );
        wait getdvarint( @"scr_time", 2 );
        function_c422639df6615578( player2, enemyteammates[ 0 ] );
        wait getdvarint( @"scr_time", 2 );
        function_c422639df6615578( player3, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "team_kill2" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        wait getdvarint( @"scr_timer", 1 );
        function_c422639df6615578( host, enemyteammates[ 0 ] );
        wait getdvarint( @"scr_timer", 1 );
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        wait getdvarint( @"scr_timer", 1 );
        function_c422639df6615578( var_18989cc3650ea6da, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "team_kill3" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        function_2610bdbc76709973( friendly1 );
        wait 1;
        function_c422639df6615578( host, enemyteammates[ 0 ] );
        function_2610bdbc76709973( host );
        wait 1;
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        function_2610bdbc76709973( friendly2 );
        wait 1;
        function_c422639df6615578( var_18989cc3650ea6da, enemyteammates[ 0 ] );
        function_2610bdbc76709973( var_18989cc3650ea6da );
        wait 1;
        
        while ( !isalive( friendly1 ) )
        {
            waitframe();
        }
        
        while ( !friendly1 isonground() )
        {
            waitframe();
        }
        
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "team_kill4" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_16ab0a48337237ef( 1 );
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_4027b1d1dd124bf4", 1 );
        function_c422639df6615578( var_18989cc3650ea6da, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_4027b1d1dd124bf4", 1 );
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_4027b1d1dd124bf4", 1 );
        function_c422639df6615578( host, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "team_kill5" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        delay = level.respawndelay;
        level.respawndelay = 5;
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        playerspectating = host;
        playerplaying = var_18989cc3650ea6da;
        
        if ( getdvarint( @"scr_switch", 0 ) )
        {
            playerspectating = var_18989cc3650ea6da;
            playerplaying = host;
        }
        
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        function_c422639df6615578( playerspectating, enemyteammates[ 0 ] );
        waittillplayeractive( playerspectating );
        wait 1;
        function_40f98be3db373c08( playerspectating );
        wait 1;
        waittillplayeractive( friendly1 );
        wait 1;
        function_40f98be3db373c08( friendly1 );
        wait 1;
        waittillplayeractive( friendly2 );
        wait 1;
        function_40f98be3db373c08( friendly2 );
        wait 1;
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        function_c422639df6615578( playerspectating, enemyteammates[ 0 ] );
        function_2610bdbc76709973( playerspectating );
        function_2610bdbc76709973( friendly1 );
        function_2610bdbc76709973( friendly2 );
        wait 4;
        function_c422639df6615578( playerplaying, enemyteammates[ 0 ] );
        waittillplayeractive( playerplaying );
        function_40f98be3db373c08( playerplaying );
        wait 4;
        function_c422639df6615578( playerplaying, enemyteammates[ 0 ] );
        level.respawndelay = delay;
    }
    
    if ( argshave( args, "team_kill6" ) )
    {
        if ( hasomnvar( "ui_resurgenceRespawnTimer" ) )
        {
            foreach ( player in hostteammates )
            {
                player function_b1cdc0bf7635456c( 1 );
                
                if ( player br_public::hasrespawntoken() )
                {
                    player item_redeploy_token::function_16ab0a48337237ef( 1 );
                }
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        disconnectbot( friendly2 );
        disconnectbot( var_18989cc3650ea6da );
        playerspectating = host;
        playerplaying = friendly1;
        
        if ( getdvarint( @"scr_switch", 0 ) )
        {
            playerspectating = friendly1;
            playerplaying = host;
        }
        
        function_c422639df6615578( playerspectating, enemyteammates[ 0 ] );
        function_2610bdbc76709973( playerspectating );
        wait 5;
        function_c422639df6615578( playerplaying, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "team_kill7" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_16ab0a48337237ef( 1 );
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        function_c422639df6615578( host, enemyteammates[ 0 ] );
        function_2610bdbc76709973( host );
        wait getdvarint( @"hash_4027b1d1dd124bf4", 5 );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_4027b1d1dd124bf4", 5 );
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_4027b1d1dd124bf4", 5 );
        function_c422639df6615578( var_18989cc3650ea6da, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_4027b1d1dd124bf4", 5 );
        function_2610bdbc76709973( host );
        player1 = host getspectatingplayer();
        putinlaststand( player1, host );
        wait 3;
        function_990e587147e3db02( player1 );
    }
    
    if ( argshave( args, "team_kill8" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        thread function_c422639df6615578( var_18989cc3650ea6da, enemyteammates[ 0 ] );
        wait 1;
        function_c422639df6615578( host, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "team_kill9" ) )
    {
        logstring( "SPECTATE DEBUG: ------------------------------------------------------------------------------" );
        logstring( "SPECTATE DEBUG: Scripted Test Start" );
        
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        friendly1 item_redeploy_token::function_16ab0a48337237ef( 1 );
        var_18989cc3650ea6da item_redeploy_token::function_16ab0a48337237ef( 1 );
        friendly1.testname = "JKozmaryRVN";
        friendly2.testname = "JWohlerRVN";
        var_18989cc3650ea6da.testname = "JFisch2RVN";
        host.testname = "FrancescoRVN";
        setdvar( @"hash_9465918bde5118eb", 1 );
        function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( friendly1 );
        wait 2;
        setdvar( @"hash_9465918bde5118eb", 0 );
        function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        function_5aabcb7460bfd4b5( friendly2 );
        wait 1;
        setdvar( @"hash_9465918bde5118eb", 0 );
        function_c422639df6615578( var_18989cc3650ea6da, enemyteammates[ 0 ] );
        wait getdvarfloat( @"scr_timer", 1 );
        setdvar( @"hash_9465918bde5118eb", 0 );
        function_c422639df6615578( host, enemyteammates[ 0 ] );
        wait getdvarfloat( @"hash_4027afd1dd12478e", 1 );
        var_18989cc3650ea6da notify( #"abort_killcam" );
        function_4a2850a247fe47c9( friendly2 );
        friendly2 notify( #"abort_killcam" );
        deregisterdvar( @"hash_9465918bde5118eb" );
    }
    
    if ( argshave( args, "team_kill_10" ) )
    {
        logstring( "SPECTATE DEBUG: ------------------------------------------------------------------------------" );
        logstring( "SPECTATE DEBUG: Scripted Test Start" );
        
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        jordan = friendly1;
        jacob = friendly2;
        var_14ee11e2601d51a5 = var_18989cc3650ea6da;
        francesco = host;
        jordan item_redeploy_token::function_16ab0a48337237ef( 1 );
        var_14ee11e2601d51a5 item_redeploy_token::function_16ab0a48337237ef( 1 );
        jordan.testname = "JKozmaryRVN";
        jacob.testname = "JWohlerRVN";
        var_14ee11e2601d51a5.testname = "JFisch2RVN";
        francesco.testname = "FrancescoRVN";
        setdvar( @"hash_9465918bde5118eb", 1 );
        function_c422639df6615578( jordan, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( jordan );
        wait 2;
        setdvar( @"hash_9465918bde5118eb", 0 );
        function_c422639df6615578( jacob, enemyteammates[ 0 ], 0.1 );
        wait getdvarfloat( @"hash_4027ded1dd12aeeb", 5 );
        setdvar( @"hash_9465918bde5118eb", 0 );
        thread function_c422639df6615578( var_14ee11e2601d51a5, enemyteammates[ 0 ], 0.1 );
        wait getdvarfloat( @"scr_timer", 2.1 );
        setdvar( @"hash_9465918bde5118eb", 0 );
        thread function_c422639df6615578( francesco, enemyteammates[ 0 ], 0.1 );
        wait getdvarfloat( @"hash_4027afd1dd12478e", 1.5 );
        var_14ee11e2601d51a5 notify( #"abort_killcam" );
        function_4a2850a247fe47c9( jacob );
        jacob notify( #"abort_killcam" );
        deregisterdvar( @"hash_9465918bde5118eb" );
    }
    
    if ( argshave( args, "team_kill_11" ) )
    {
        logstring( "SPECTATE DEBUG: ------------------------------------------------------------------------------" );
        logstring( "SPECTATE DEBUG: Scripted Test Start" );
        
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        friendly1 item_redeploy_token::function_16ab0a48337237ef( 1 );
        friendly2 item_redeploy_token::function_16ab0a48337237ef( 1 );
        friendly1.testname = "Dead1";
        friendly2.testname = "Dead2";
        var_18989cc3650ea6da.testname = "Respawner";
        host.testname = "Host";
        setdvar( @"hash_9465918bde5118eb", 1 );
        thread function_c422639df6615578( friendly1, enemyteammates[ 0 ] );
        thread function_c422639df6615578( friendly2, enemyteammates[ 0 ] );
        function_3c936eb573b412c0( friendly1 );
        function_3c936eb573b412c0( friendly2 );
        wait 1;
        setdvar( @"scr_br_gulag_win_hold", 1 );
        setdvar( @"hash_9465918bde5118eb", 0 );
        thread function_c422639df6615578( var_18989cc3650ea6da, enemyteammates[ 0 ], 0.1 );
        wait getdvarfloat( @"scr_timer", 1.5 );
        function_c422639df6615578( host, enemyteammates[ 0 ], 0.1 );
        function_5aabcb7460bfd4b5( host );
        host notify( #"abort_killcam" );
        wait getdvarfloat( @"hash_4027afd1dd12478e", 4 );
        setdvar( @"scr_br_gulag_win_hold", 0 );
        deregisterdvar( @"hash_9465918bde5118eb" );
    }
    
    if ( argshave( args, "team_kill_disconnect1" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        disconnectbot( friendly1 );
        wait getdvarint( @"hash_4027ded1dd12aeeb", 1 );
        killplayerinstant( host, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_4027ded1dd12aeeb", 1 );
        disconnectbot( friendly2 );
        wait getdvarint( @"hash_4027ded1dd12aeeb", 1 );
        disconnectbot( var_18989cc3650ea6da );
    }
    
    if ( argshave( args, "team_kill_disconnect2" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( !player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_190ce3e2e0f50a8a();
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        function_c422639df6615578( host, enemyteammates[ 0 ] );
        function_2610bdbc76709973( host );
        player1 = host getspectatingplayer();
        player2 = undefined;
        player3 = undefined;
        
        foreach ( teammate in hostteammates )
        {
            if ( teammate == host )
            {
                continue;
            }
            
            if ( !player2 && teammate != player1 )
            {
                player2 = teammate;
                continue;
            }
            
            if ( !player3 && teammate != player2 && teammate != player1 )
            {
                player3 = teammate;
            }
        }
        
        disconnectbot( player1 );
        wait getdvarint( @"hash_4027dfd1dd12b11e", 4 );
        disconnectbot( player2 );
        wait getdvarint( @"hash_4027dfd1dd12b11e", 4 );
        disconnectbot( player3 );
    }
    
    if ( argshave( args, "team_disconnect1" ) )
    {
        foreach ( player in hostteammates )
        {
            player function_b1cdc0bf7635456c( 1 );
            
            if ( player br_public::hasrespawntoken() )
            {
                player item_redeploy_token::function_16ab0a48337237ef( 1 );
            }
        }
        
        [ enemy1, enemy2, enemy3, var_e9cc371400fe5a1e, enemya, enemyb, enemyc, enemyd, friendly1, friendly2, var_18989cc3650ea6da ] = getallplayers( host, hostteammates, enemyteammates );
        killplayerinstant( host, enemyteammates[ 0 ] );
        function_2610bdbc76709973( host );
        count = 7;
        
        while ( count > 0 )
        {
            while ( !host getspectatingplayer() )
            {
                waitframe();
            }
            
            bot = host getspectatingplayer();
            wait getdvarint( @"hash_4027e0d1dd12b351", 3 );
            disconnectbot( bot );
            count--;
            setomnvarforallclients( "ui_round_end_reason", 0 );
            setomnvarforallclients( "ui_round_end_title", 0 );
            setomnvarforallclients( "post_game_state", 0 );
            setomnvarforallclients( "ui_br_squad_eliminated_active", 0 );
        }
    }
    
    if ( argshave( args, "moving" ) )
    {
        killplayerinstant( host, enemyteammates[ 0 ] );
        
        while ( !isdefined( host.playertospectate ) )
        {
            waitframe();
        }
        
        player = host.playertospectate;
        dir = anglestoforward( player.angles );
        amount = getdvarint( @"testforward", 5 );
        
        for ( spectatingplayer = host getspectatingplayer(); !isdefined( spectatingplayer ) ; spectatingplayer = host getspectatingplayer() )
        {
            nextorg = player.origin + dir * amount;
            player setorigin( nextorg );
            waitframe();
        }
    }
    
    if ( argshave( args, "deathWater" ) )
    {
        host setorigin( ( 28252, -32627, -415 ) );
    }
    
    if ( argshave( args, "disconnectswitch1" ) )
    {
        killplayerinstant( host, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        friendly = host br_spectate::playergetspectatingplayer();
        
        while ( !host buttonpressed( "BUTTON_RSHLDR" ) )
        {
            waitframe();
        }
        
        friendly2 = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( player != host && player != friendly )
            {
                friendly2 = player;
                break;
            }
        }
        
        wait 0.5;
        disconnectbot( friendly2 );
    }
    
    if ( argshave( args, "disconnectswitch2" ) )
    {
        killplayerinstant( host, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        friendly = host br_spectate::playergetspectatingplayer();
        
        while ( !host buttonpressed( "BUTTON_RSHLDR" ) )
        {
            waitframe();
        }
        
        wait 0.5;
        disconnectbot( friendly );
    }
    
    if ( argshave( args, "endspectate" ) )
    {
        level.br_infils_disabled = 1;
        
        /#
            setdevdvar( @"scr_match_timer", 1 );
        #/
        
        setdvar( @"br_minplayers", 2 );
        level.gulag.maxuses = 0;
        wait 1;
        killplayerinstant( host, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        wait 2;
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                killplayerinstant( player, enemyteammates[ 0 ] );
            }
        }
        
        br_spectate::waittillspectating( host );
        wait 2;
        enemy = host br_spectate::playergetspectatingplayer();
        killplayerinstant( enemy, enemyteammates[ 1 ] );
        br_spectate::waittillspectating( host );
        wait 2;
        enemy = host br_spectate::playergetspectatingplayer();
        killplayerinstant( enemy, enemyteammates[ 1 ] );
        br_spectate::waittillspectating( host );
        wait 2;
        enemy = host br_spectate::playergetspectatingplayer();
        killplayerinstant( enemy, enemyteammates[ 1 ] );
        br_spectate::waittillspectating( host );
        wait 2;
    }
    
    if ( argshave( args, "teamwipe1" ) )
    {
        setdvar( @"hash_2c879521333c4987", 5 );
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                killplayerinstant( player, enemyteammates[ 0 ] );
            }
        }
        
        wait getdvarfloat( @"test_teamwipe", 5 );
        enemy = killplayerinstant( host, enemyteammates[ 0 ] );
        wait getdvarfloat( @"hash_1f5ea86d19b61851", 13 );
        killplayerinstant( enemy, enemyteammates[ 1 ] );
    }
    
    if ( argshave( args, "deathswitch1" ) )
    {
        setdvar( @"hash_2c879521333c4987", 5 );
        killplayerinstant( host, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        friendly = host br_spectate::playergetspectatingplayer();
        
        while ( !host buttonpressed( "BUTTON_RSHLDR" ) )
        {
            waitframe();
        }
        
        friendly2 = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( player != host && player != friendly )
            {
                friendly2 = player;
                break;
            }
        }
        
        wait 0.5;
        killplayerinstant( friendly2, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "killall" ) )
    {
        level.overrideingraceperiod = 1;
        lastplayer = hostteammates[ 1 ];
        
        foreach ( player in hostteammates )
        {
            if ( player != lastplayer )
            {
                killplayerinstant( player, enemyteammates[ 0 ] );
            }
        }
        
        foreach ( player in enemyteammates[ 0 ] )
        {
            killplayerinstant( player, enemyteammates[ 1 ] );
        }
        
        foreach ( player in enemyteammates[ 1 ] )
        {
            killplayerinstant( player, enemyteammates[ 0 ] );
        }
        
        wait 10;
        disconnectbot( lastplayer );
        level.overrideingraceperiod = undefined;
    }
    
    if ( argshave( args, "moneykill" ) )
    {
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                player br_plunder::playersetplundercount( 45 );
                player function_b1cdc0bf7635456c( 1 );
                killplayerinstant( player, enemyteammates[ 0 ] );
            }
        }
        
        wait 5;
        killplayerinstant( host, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "teamwipe2" ) )
    {
        killplayerinstant( host, enemyteammates[ 0 ] );
        host waittill( #"killcam_ended" );
        wait 2;
        count = 0;
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                if ( count > 0 )
                {
                    player br_plunder::playersetplundercount( 45 );
                    player function_b1cdc0bf7635456c( 1 );
                }
                
                killplayerinstant( player, enemyteammates[ 1 ] );
                count++;
                wait 5;
            }
        }
    }
    
    if ( argshave( args, "infilDeath" ) )
    {
        thread waitandsuicide( getdvarint( @"test_suicide", 1 ), hostteammates[ 1 ] );
        onprematchstarted2();
        level waittill( #"br_c130_left_bounds" );
        wait 2;
        hostteammates[ 2 ] function_b1cdc0bf7635456c( 0 );
        killplayerinstant( hostteammates[ 2 ], enemyteammates[ 0 ] );
        wait 10;
        host function_b1cdc0bf7635456c( 0 );
        killplayerinstant( host, enemyteammates[ 0 ] );
    }
    
    if ( argshave( args, "endGameTwoDie" ) )
    {
        setdvar( @"br_minplayers", 8 );
        wait 5;
        br_gulag::shutdowngulag( "circle_index", 0 );
        enemy1 = enemyteammates[ 0 ][ 0 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        killplayerinstant( enemyteammates[ 0 ][ 2 ], host );
        killplayerinstant( enemyteammates[ 0 ][ 1 ], host );
        killplayerinstant( enemyteammates[ 1 ][ 2 ], host );
        killplayerinstant( enemyteammates[ 1 ][ 1 ], host );
        killplayerinstant( enemyteammates[ 1 ][ 0 ], host );
        killplayerinstant( friendly1, enemy1 );
        killplayerinstant( friendly2, enemy1 );
        wait 3;
        host juggernaut::jugg_makejuggernaut( juggernaut::function_7a7d89de25fa010c( level.streakglobals.streakbundles[ "juggernaut" ] ) );
        wait 3;
        enemy1 dodamage( 999, enemy1.origin, enemy1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
        
        while ( isalive( host ) )
        {
            host dodamage( 999, host.origin, host, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            waitframe();
        }
    }
    
    if ( argshave( args, "interrogateKill" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        putinlaststand( enemy1, host );
        
        while ( !host.var_a4b2552b9d71144f )
        {
            waitframe();
        }
        
        wait getdvarfloat( @"test_wait", 3.5 );
        killplayerinstant( enemy1, friendly1 );
    }
    
    if ( argshave( args, "final_killcam_self_revive" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy3 = enemyteammates[ 0 ][ 2 ];
        enemya = enemyteammates[ 1 ][ 0 ];
        enemyb = enemyteammates[ 1 ][ 1 ];
        enemyc = enemyteammates[ 1 ][ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( enemya );
        disconnectbot( enemyb );
        disconnectbot( enemyc );
        disconnectbot( enemy3 );
        enemy1 laststand::function_a2e03a85015b1897();
        enemy2 laststand::function_a2e03a85015b1897();
        host function_b1cdc0bf7635456c( 1 );
        
        /#
            br_dev::function_2f082157f2412a77();
        #/
    }
    
    if ( argshave( args, "spectate_death_respawn2" ) )
    {
        function_e29ff97063325857();
        
        foreach ( player in level.players )
        {
            player.br_infilstarted = 1;
        }
        
        var_29ba4bfe2e909e74 = enemyteammates[ 0 ][ 0 ];
        var_29ba4efe2e90a50d = enemyteammates[ 0 ][ 1 ];
        var_29ba4dfe2e90a2da = enemyteammates[ 0 ][ 2 ];
        var_29acbbfe2e814d3f = enemyteammates[ 1 ][ 0 ];
        var_29acbcfe2e814f72 = enemyteammates[ 1 ][ 1 ];
        var_29acbdfe2e8151a5 = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly1 );
        disconnectbot( friendly2 );
        disconnectbot( var_29ba4bfe2e909e74 );
        disconnectbot( var_29ba4efe2e90a50d );
        disconnectbot( var_29acbbfe2e814d3f );
        disconnectbot( var_29acbcfe2e814f72 );
        killplayer( host, var_29ba4dfe2e90a2da );
        br_spectate::waittillspectating( host );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player br_plunder::playerplunderpickup( 500 );
            }
        }
        
        wait 10;
        playerspectating = host br_spectate::playergetspectatingplayer();
        killer = var_29ba4dfe2e90a2da;
        
        if ( playerspectating == killer )
        {
            killer = var_29acbdfe2e8151a5;
        }
        
        killplayer( playerspectating, killer );
        wait getdvarfloat( @"scr_test_wait", 5 );
        disconnectbot( playerspectating );
    }
    
    if ( argshave( args, "spectate_death_respawn3" ) )
    {
        function_e29ff97063325857();
        
        foreach ( player in level.players )
        {
            player.br_infilstarted = 1;
        }
        
        var_29ba4bfe2e909e74 = enemyteammates[ 0 ][ 0 ];
        var_29ba4efe2e90a50d = enemyteammates[ 0 ][ 1 ];
        var_29ba4dfe2e90a2da = enemyteammates[ 0 ][ 2 ];
        var_29acbbfe2e814d3f = enemyteammates[ 1 ][ 0 ];
        var_29acbcfe2e814f72 = enemyteammates[ 1 ][ 1 ];
        var_29acbdfe2e8151a5 = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly1 );
        disconnectbot( friendly2 );
        disconnectbot( var_29ba4bfe2e909e74 );
        disconnectbot( var_29ba4efe2e90a50d );
        disconnectbot( var_29acbbfe2e814d3f );
        disconnectbot( var_29acbcfe2e814f72 );
        host.br_infilstarted = 0;
        host.respawndelay = 1000000;
        killplayer( host, var_29ba4dfe2e90a2da );
        br_spectate::waittillspectating( host );
        wait 10;
        playerspectating = host br_spectate::playergetspectatingplayer();
        killer = var_29ba4dfe2e90a2da;
        
        if ( playerspectating == killer )
        {
            killer = var_29acbdfe2e8151a5;
        }
        
        killplayer( playerspectating, killer );
        wait getdvarfloat( @"scr_test_wait", 10 );
        disconnectbot( playerspectating );
    }
    
    if ( argshave( args, "spectate_death_matchend" ) )
    {
        foreach ( player in level.players )
        {
            player.br_infilstarted = 1;
        }
        
        var_29ba4bfe2e909e74 = enemyteammates[ 0 ][ 0 ];
        var_29ba4efe2e90a50d = enemyteammates[ 0 ][ 1 ];
        var_29ba4dfe2e90a2da = enemyteammates[ 0 ][ 2 ];
        var_29acbbfe2e814d3f = enemyteammates[ 1 ][ 0 ];
        var_29acbcfe2e814f72 = enemyteammates[ 1 ][ 1 ];
        var_29acbdfe2e8151a5 = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly1 );
        disconnectbot( friendly2 );
        disconnectbot( var_29ba4bfe2e909e74 );
        disconnectbot( var_29ba4efe2e90a50d );
        disconnectbot( var_29acbbfe2e814d3f );
        disconnectbot( var_29acbcfe2e814f72 );
        killplayer( host, var_29ba4dfe2e90a2da );
        br_spectate::waittillspectating( host );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player br_plunder::playerplunderpickup( 500 );
            }
        }
        
        wait getdvarfloat( @"scr_test_wait", 10 );
        playerspectating = host br_spectate::playergetspectatingplayer();
        playerspectating.br_infilstarted = 0;
        killer = var_29ba4dfe2e90a2da;
        
        if ( playerspectating == killer )
        {
            killer = var_29acbdfe2e8151a5;
        }
        
        killplayer( playerspectating, killer );
    }
    
    if ( argshave( args, "killcam_downed" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy3 = enemyteammates[ 0 ][ 2 ];
        enemya = enemyteammates[ 1 ][ 0 ];
        enemyb = enemyteammates[ 1 ][ 1 ];
        enemyc = enemyteammates[ 1 ][ 2 ];
        host laststand::function_a2e03a85015b1897();
        wait 2;
        host_dir = anglestoforward( host.angles );
        enemy_org = host.origin + host_dir * 100;
        enemy1 setorigin( enemy_org );
        enemy1 setplayerangles( ( 0, host.angles[ 1 ] + 180, 0 ) );
        wait 2;
        putinlaststand( host, enemy1 );
        wait getdvarint( @"scr_test_wait", 8 );
        killplayer( host, enemy1 );
    }
    
    if ( argshave( args, "damage_host" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        wait getdvarint( @"scr_test_wait", 3 );
        damageplayer( host, enemy1 );
    }
    
    if ( argshave( args, "death_disconnect" ) )
    {
        killplayer( host, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        wait 3;
        playertospectate = host br_spectate::playergetspectatingplayer();
        killplayer( playertospectate, enemyteammates[ 0 ] );
        
        while ( !isdefined( host.playertospectate ) )
        {
            waitframe();
        }
        
        waitframe();
        playertospectate = host.playertospectate;
        disconnectbot( playertospectate );
    }
    
    if ( argshave( args, "afk_disconnect" ) )
    {
        foreach ( player in level.players )
        {
            player.br_infilstarted = 1;
        }
        
        var_29ba4bfe2e909e74 = enemyteammates[ 0 ][ 0 ];
        var_29ba4efe2e90a50d = enemyteammates[ 0 ][ 1 ];
        var_29ba4dfe2e90a2da = enemyteammates[ 0 ][ 2 ];
        var_29acbbfe2e814d3f = enemyteammates[ 1 ][ 0 ];
        var_29acbcfe2e814f72 = enemyteammates[ 1 ][ 1 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly1 );
        disconnectbot( friendly2 );
        disconnectbot( var_29ba4bfe2e909e74 );
        disconnectbot( var_29ba4efe2e90a50d );
        disconnectbot( var_29acbbfe2e814d3f );
        disconnectbot( var_29acbcfe2e814f72 );
        killplayer( host, var_29ba4dfe2e90a2da );
        br_spectate::waittillspectating( host );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player br_plunder::playerplunderpickup( 500 );
            }
        }
        
        wait 10;
        playerspectating = host br_spectate::playergetspectatingplayer();
        kick( playerspectating getentitynumber(), &"EXE/PLAYERKICKED_INACTIVE", 1 );
    }
    
    if ( argshave( args, "spectate_death_respawn" ) )
    {
        foreach ( player in level.players )
        {
            player.br_infilstarted = 1;
        }
        
        var_29ba4bfe2e909e74 = enemyteammates[ 0 ][ 0 ];
        var_29ba4efe2e90a50d = enemyteammates[ 0 ][ 1 ];
        var_29ba4dfe2e90a2da = enemyteammates[ 0 ][ 2 ];
        var_29acbbfe2e814d3f = enemyteammates[ 1 ][ 0 ];
        var_29acbcfe2e814f72 = enemyteammates[ 1 ][ 1 ];
        var_29acbdfe2e8151a5 = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly1 );
        disconnectbot( friendly2 );
        disconnectbot( var_29ba4bfe2e909e74 );
        disconnectbot( var_29ba4efe2e90a50d );
        disconnectbot( var_29acbbfe2e814d3f );
        disconnectbot( var_29acbcfe2e814f72 );
        killplayer( host, var_29ba4dfe2e90a2da );
        br_spectate::waittillspectating( host );
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player br_plunder::playerplunderpickup( 500 );
            }
        }
        
        wait 10;
        playerspectating = host br_spectate::playergetspectatingplayer();
        killer = var_29ba4dfe2e90a2da;
        
        if ( playerspectating == killer )
        {
            killer = var_29acbdfe2e8151a5;
        }
        
        killplayer( playerspectating, killer );
        
        /#
            br_dev::function_2f082157f2412a77();
        #/
    }
    
    if ( argshave( args, "death_no_laststand" ) )
    {
        var_29ba4bfe2e909e74 = enemyteammates[ 0 ][ 0 ];
        var_29ba4efe2e90a50d = enemyteammates[ 0 ][ 1 ];
        var_29ba4dfe2e90a2da = enemyteammates[ 0 ][ 2 ];
        var_29acbbfe2e814d3f = enemyteammates[ 1 ][ 0 ];
        var_29acbcfe2e814f72 = enemyteammates[ 1 ][ 1 ];
        var_29acbdfe2e8151a5 = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly1 );
        disconnectbot( friendly2 );
        disconnectbot( var_29ba4efe2e90a50d );
        disconnectbot( var_29ba4dfe2e90a2da );
        disconnectbot( var_29acbcfe2e814f72 );
        disconnectbot( var_29acbdfe2e8151a5 );
        
        if ( isdefined( var_29ba4bfe2e909e74.perks[ "specialty_pistoldeath" ] ) )
        {
            var_29ba4bfe2e909e74 perk::removeperk( "specialty_pistoldeath" );
        }
        
        if ( isdefined( var_29acbbfe2e814d3f.perks[ "specialty_pistoldeath" ] ) )
        {
            var_29acbbfe2e814d3f perk::removeperk( "specialty_pistoldeath" );
        }
    }
    
    if ( argshave( args, "disconnect_all" ) )
    {
        function_e29ff97063325857();
        var_29ba4bfe2e909e74 = enemyteammates[ 0 ][ 0 ];
        var_29ba4efe2e90a50d = enemyteammates[ 0 ][ 1 ];
        var_29ba4dfe2e90a2da = enemyteammates[ 0 ][ 2 ];
        var_29acbbfe2e814d3f = enemyteammates[ 1 ][ 0 ];
        var_29acbcfe2e814f72 = enemyteammates[ 1 ][ 1 ];
        var_29acbdfe2e8151a5 = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( friendly1 );
        disconnectbot( friendly2 );
        disconnectbot( var_29ba4bfe2e909e74 );
        disconnectbot( var_29ba4efe2e90a50d );
        disconnectbot( var_29ba4dfe2e90a2da );
        disconnectbot( var_29acbbfe2e814d3f );
        disconnectbot( var_29acbcfe2e814f72 );
        disconnectbot( var_29acbdfe2e8151a5 );
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0xe0a90248, Offset: 0x7e71
// Size: 0x384
function testsrespawn( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "buybackAll" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        friendly1 = hostteammates[ 0 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 1 ];
        }
        
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 1 ];
        }
        
        killplayerinstant( friendly1, enemy1 );
        killplayerinstant( friendly2, enemy1 );
        host thread [[ level.var_952b959a42f49b29 ]]( 0 );
    }
    
    if ( argshave( args, "buyback1" ) )
    {
        scriptcircleat( host.origin, 500 );
        setdvar( @"hash_e5f703a38f6e8043", -1 );
        playera = host;
        playera function_b1cdc0bf7635456c( 1 );
        killplayer( playera, enemyteammates[ 1 ] );
        enemya = enemyteammates[ 1 ][ 0 ];
        enemya function_b1cdc0bf7635456c( 1 );
        killplayer( enemya, enemyteammates[ 1 ] );
        
        while ( !playera.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        killplayerinstant( playera, [] );
        
        while ( !isdefined( playera getspectatingplayer() ) )
        {
            waitframe();
        }
        
        playerb = playera getspectatingplayer();
        playerb function_b1cdc0bf7635456c( 1 );
        playerc = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( player != playera && player != playerb )
            {
                playerc = player;
                break;
            }
        }
        
        playerc br_plunder::playersetplundercount( 45 );
        killplayer( playerb, enemyteammates[ 1 ] );
        
        while ( !playerb.jailed )
        {
            waitframe();
        }
        
        while ( !isdefined( playera getspectatingplayer() ) || playera getspectatingplayer() != playerb )
        {
            waitframe();
        }
        
        enemyb = enemyteammates[ 1 ][ 1 ];
        enemyb function_b1cdc0bf7635456c( 1 );
        killplayer( enemyb, enemyteammates[ 1 ] );
        
        while ( !playerb.gulagarena )
        {
            waitframe();
        }
        
        wait 10;
        setdvar( @"hash_2c879521333c4987", 3 );
        killplayerinstant( playerb, [] );
        playerc br_pickups::addrespawntoken( 1 );
        playera thread br_gulag::playergulagautowin( "devtest", playerc, 0 );
    }
    
    if ( argshave( args, "jailbreakRespawn" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        friendly1 = hostteammates[ 0 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 1 ];
        }
        
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 1 ];
        }
        
        friendly2 function_b1cdc0bf7635456c( 1 );
        killplayer( host, enemyteammates[ 1 ] );
        killplayer( friendly1, enemyteammates[ 1 ] );
        killplayer( friendly2, enemyteammates[ 0 ] );
        wait getdvarint( @"hash_3a9d33277e079f99", 10 );
        setdvar( @"scr_br_pe_jailbreak_duration", 0.1 );
        eventdata = level.br_pe_data[ 3 ];
        eventdata.active = 1;
        br_publicevents::activateevent( eventdata );
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0x67dae446, Offset: 0x81fd
// Size: 0x97b
function testsvehicle( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "heli1" ) || argshave( args, "heli2" ) )
    {
        friendly = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                if ( !isdefined( friendly ) )
                {
                    friendly = player;
                    continue;
                }
                
                killplayerinstant( player, enemyteammates[ 0 ] );
            }
        }
        
        wait 1;
        killplayerinstant( host, enemyteammates[ 0 ] );
        br_spectate::waittillspectating( host );
        wait 1;
        keys = getarraykeys( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] );
        heli = level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ][ keys[ 0 ] ];
        instance = heli getlinkedscriptableinstance();
        friendly setorigin( heli.origin );
        wait 1;
        vehicle_interact::scriptable_used( instance, "single", "vehicle_use", friendly, 0 );
        
        if ( argshave( args, "heli2" ) )
        {
            wait 3;
            disconnectbot( friendly );
        }
    }
    
    if ( argshave( args, "heli3" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy3 = enemyteammates[ 0 ][ 2 ];
        
        if ( !level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] || level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ].size == 0 )
        {
            data = vehicle_occupancy::get_data( "veh_sat_mil_light_heli_wz" );
            data.origin = ( 1500, 0, -400 );
            level.dev_vehicle = vehicle::spawn( "veh_sat_mil_light_heli_wz", data );
            
            if ( isdefined( level.dev_vehicle ) && level.dev_vehicle vehicle::ishelicopter() )
            {
                level.dev_vehicle vehicle_occupancy::function_474d87fe62493d22();
            }
        }
        
        if ( !level.dev_vehicle )
        {
            keys = getarraykeys( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] );
            level.dev_vehicle = level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ][ keys[ 0 ] ];
        }
        
        instance = level.dev_vehicle getlinkedscriptableinstance();
        enemy = enemy1;
        
        while ( true )
        {
            enemy setorigin( level.dev_vehicle.origin );
            vehicle_interact::scriptable_used( instance, "single", "vehicle_use", enemy, 0 );
            wait getdvarfloat( @"hash_f2c67a67203193a3", 3 );
            vehicle_occupancy::exit( level.dev_vehicle, "driver", enemy );
            
            if ( enemy == enemy1 )
            {
                enemy = enemy2;
            }
            else if ( enemy == enemy2 )
            {
                enemy = enemy3;
            }
            else
            {
                enemy = enemy1;
                
                while ( getdvarint( @"hash_c5827ed2a93031b0", 1 ) )
                {
                    waitframe();
                }
                
                setdvar( @"hash_c5827ed2a93031b0", 1 );
            }
            
            wait getdvarfloat( @"hash_f2c67b67203195d6", 0.1 );
        }
    }
    
    if ( argshave( args, "heli4" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        function_b1cdc0bf7635456c( enemy1 );
        
        if ( level.dev_vehicle )
        {
            level.dev_vehicle delete();
            level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] = [];
        }
        
        wait 1;
        
        if ( !level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] || level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ].size == 0 )
        {
            data = vehicle_occupancy::get_data( "veh_sat_mil_light_heli_wz" );
            
            if ( level.mapname == "mp_saw_avalon" )
            {
                data.origin = ( 425.981, 109.709, 480 );
            }
            else
            {
                data.origin = ( 1500, 0, -470 );
            }
            
            level.dev_vehicle = vehicle::spawn( "veh_sat_mil_light_heli_wz", data );
            
            if ( isdefined( level.dev_vehicle ) && level.dev_vehicle vehicle::ishelicopter() )
            {
                level.dev_vehicle vehicle_occupancy::function_474d87fe62493d22();
            }
        }
        
        if ( !level.dev_vehicle )
        {
            keys = getarraykeys( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] );
            level.dev_vehicle = level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ][ keys[ 0 ] ];
        }
        
        if ( level.mapname == "mp_saw_avalon" )
        {
            level.dev_vehicle vehicle_teleport( ( 425.981, 109.709, 520 ), ( 0, 0, 0 ) );
        }
        
        instance = level.dev_vehicle getlinkedscriptableinstance();
        enemy1 setorigin( level.dev_vehicle.origin );
        vehicle_interact::scriptable_used( instance, "single", "vehicle_use", enemy1, 0 );
        wait getdvarfloat( @"hash_1c2026cbcd167a87", 4 );
        vehicle_occupancy::exit( level.dev_vehicle, "driver", enemy1 );
        wait getdvarfloat( @"hash_1c2027cbcd167cba", 1 );
        putinlaststand( enemy1, host );
        wait getdvarfloat( @"hash_1c2028cbcd167eed", 2 );
        function_990e587147e3db02( enemy1 );
    }
    
    if ( argshave( args, "heli5" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        function_b1cdc0bf7635456c( enemy1 );
        
        if ( level.dev_vehicle )
        {
            level.dev_vehicle delete();
            level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] = [];
        }
        
        wait 1;
        
        if ( !level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] || level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ].size == 0 )
        {
            data = vehicle_occupancy::get_data( "veh_sat_mil_light_heli_wz" );
            
            if ( level.mapname == "mp_saw_avalon" )
            {
                data.origin = ( 425.981, 109.709, 480 );
            }
            else
            {
                data.origin = ( 1500, 0, -470 );
            }
            
            level.dev_vehicle = vehicle::spawn( "veh_sat_mil_light_heli_wz", data );
            
            if ( isdefined( level.dev_vehicle ) && level.dev_vehicle vehicle::ishelicopter() )
            {
                level.dev_vehicle vehicle_occupancy::function_474d87fe62493d22();
            }
        }
        
        if ( !level.dev_vehicle )
        {
            keys = getarraykeys( level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ] );
            level.dev_vehicle = level.vehicle.instances[ %"hash_6ecc4b72654c75a5" ][ keys[ 0 ] ];
        }
        
        if ( level.mapname == "mp_saw_avalon" )
        {
            level.dev_vehicle vehicle_teleport( ( 425.981, 109.709, 520 ), ( 0, 0, 0 ) );
        }
        
        instance = level.dev_vehicle getlinkedscriptableinstance();
        enemy1 setorigin( level.dev_vehicle.origin );
        vehicle_interact::scriptable_used( instance, "single", "vehicle_use", enemy1, 0 );
    }
    
    if ( argshave( args, "riotBackSeat" ) )
    {
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        if ( !isdefined( level.devjltv ) )
        {
            seatid = undefined;
            spawndata = spawnstruct();
            spawndata.origin = ( 250, -1900, 130 );
            spawndata.angles = ( 0, 0, 0 );
            spawndata.spawntype = "DEVGUI";
            level.devjltv = vehicle::spawn( "veh9_jltv", spawndata );
            wait 1;
            thread vehicle_occupancy::enter( level.devjltv, "driver", friendly1, undefined, 1 );
            thread vehicle_occupancy::enter( level.devjltv, "front_right", friendly2, undefined, 1 );
        }
        
        setomnvar( "scriptable_loot_hide", 0 );
        host takeallweapons();
        host function_272854c4fbdc76fa( "iw9_me_riotshield_mp" );
        host function_272854c4fbdc76fa( "iw9_me_tonfa_mp" );
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0xadc54239, Offset: 0x8b80
// Size: 0x7ec
function testsui( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "squadwidget" ) )
    {
        setdvar( @"hash_e5f703a38f6e8043", 9999 );
        setdvar( @"hash_2c879521333c4987", 3 );
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                disconnectbot( player );
            }
        }
        
        wait 5;
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy1 function_b1cdc0bf7635456c( 1 );
        killplayerinstant( enemy1, host );
        wait getdvarfloat( @"test_squadwidget", 4 );
        killplayerinstant( host, enemy2 );
    }
    
    if ( argshave( args, "ui_squad_widget_test" ) )
    {
        wait 2;
        enemy1 = enemyteammates[ 0 ][ 0 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        enemy1 function_b1cdc0bf7635456c( 1 );
        friendly1 function_b1cdc0bf7635456c( 1 );
        friendly2 function_b1cdc0bf7635456c( 1 );
        armorbundlename = common_item_database::function_a4f0a21951180013( level.armorref ?? "equip_armorplate" );
        armorbundle = getscriptbundle( armorbundlename );
        var_cf6ff5e826b066d9 = armorbundle.scriptable;
        
        for ( i = 0; i < 7 ; i++ )
        {
            var_c986cdca8d88b689 = spawnstruct();
            var_c986cdca8d88b689.type = var_cf6ff5e826b066d9;
            var_c986cdca8d88b689.count = common_item::function_ea3b3088d82fd357( armorbundle );
            var_c986cdca8d88b689.fromcache = 0;
            friendly1 common_item::function_96119bed8ab4c5d9( var_c986cdca8d88b689, 0 );
            var_c986caca8d88aff0 = spawnstruct();
            var_c986caca8d88aff0.type = var_cf6ff5e826b066d9;
            var_c986caca8d88aff0.count = common_item::function_ea3b3088d82fd357( armorbundle );
            var_c986caca8d88aff0.fromcache = 0;
            friendly2 common_item::function_96119bed8ab4c5d9( var_c986caca8d88aff0, 0 );
            var_c986cbca8d88b223 = spawnstruct();
            var_c986cbca8d88b223.type = var_cf6ff5e826b066d9;
            var_c986cbca8d88b223.count = common_item::function_ea3b3088d82fd357( armorbundle );
            var_c986cbca8d88b223.fromcache = 0;
            host common_item::function_96119bed8ab4c5d9( var_c986cbca8d88b223, 0 );
            wait 0.5;
        }
        
        var_881c921f8d19e928 = common_item_database::function_a4f0a21951180013( "wz_consumable_gas_mask" );
        gasmaskbundle = getscriptbundle( var_881c921f8d19e928 );
        var_b0e9bbff56ef4bf7 = gasmaskbundle.scriptable;
        fakegasmask = spawnstruct();
        fakegasmask.type = var_b0e9bbff56ef4bf7;
        fakegasmask.count = common_item::function_ea3b3088d82fd357( gasmaskbundle );
        fakegasmask.fromcache = 0;
        var_e0cf6f42bf89c969 = common_item_database::function_a4f0a21951180013( "wz_consumable_gas_mask_durable" );
        var_e9a4e4a3a8d489e2 = getscriptbundle( var_e0cf6f42bf89c969 );
        var_bf840e36872efada = var_e9a4e4a3a8d489e2.scriptable;
        var_606ad5dfc147d93b = spawnstruct();
        var_606ad5dfc147d93b.type = var_bf840e36872efada;
        var_606ad5dfc147d93b.count = common_item::function_ea3b3088d82fd357( var_e9a4e4a3a8d489e2 );
        var_606ad5dfc147d93b.fromcache = 0;
        friendly1 common_item::function_96119bed8ab4c5d9( fakegasmask, 0 );
        friendly2 common_item::function_96119bed8ab4c5d9( var_606ad5dfc147d93b, 0 );
        wait 1;
        friendly1 killstreaks::awardkillstreak( "uav", "other" );
        friendly2 killstreaks::awardkillstreak( "precision_airstrike", "other" );
        wait 1;
        friendly1 br_pickups::addrespawntoken( 1 );
        friendly2 br_pickups::addrespawntoken( 1 );
        host br_pickups::addrespawntoken( 1 );
        wait 1;
        friendly1 br_pickups::function_bddc9eed420437d8( 1 );
        friendly2 br_pickups::function_bddc9eed420437d8( 1 );
        host br_pickups::function_bddc9eed420437d8( 1 );
    }
    
    if ( argshave( args, "ui_gas_mask_test" ) )
    {
        wait 1;
        var_881c921f8d19e928 = common_item_database::function_a4f0a21951180013( "wz_consumable_gas_mask" );
        gasmaskbundle = getscriptbundle( var_881c921f8d19e928 );
        var_b0e9bbff56ef4bf7 = gasmaskbundle.scriptable;
        fakegasmask = spawnstruct();
        fakegasmask.type = var_b0e9bbff56ef4bf7;
        fakegasmask.count = common_item::function_ea3b3088d82fd357( gasmaskbundle );
        fakegasmask.fromcache = 0;
        host common_item::function_96119bed8ab4c5d9( fakegasmask, 0 );
        wait 1;
        thread function_fadeda522c33fd89( host, 15 );
    }
    
    if ( argshave( args, "ui_killstreak_test" ) )
    {
        wait 1;
        killstreaksarr = [ "uav", "scrambler_drone_guard", "directional_uav", "precision_airstrike", "toma_strike", "airdrop", "supply_sweep", "napalm_strike", "sentry_gun" ];
        
        for ( i = 0; i < killstreaksarr.size ; i++ )
        {
            host br_pickups::forcegivekillstreak( killstreaksarr[ i ], 1, 0, 0, 0 );
            host killstreaks::updatekillstreakuislots();
            wait 1;
            host killstreaks::dokillstreakaction( undefined, 1 );
            wait 2;
        }
    }
    
    if ( argshave( args, "ui_perks_killcam_test" ) )
    {
        perksarr = [ "specialty_awareness", "specialty_brawler", "specialty_engineer_bongo", "specialty_iron_lungs", "specialty_looter", "specialty_medic_bongo", "specialty_mobility", "specialty_outlander_bongo", "specialty_paranoia", "specialty_reinforced", "specialty_skulker", "specialty_squad_link" ];
        
        for ( i = 0; i < perksarr.size ; i++ )
        {
            perkbundlename = common_item_database::function_a4f0a21951180013( perksarr[ i ] );
            perkbundle = getscriptbundle( perkbundlename );
            var_29e50fb1762fee62 = perkbundle.scriptable;
            perkstruct = spawnstruct();
            perkstruct.type = var_29e50fb1762fee62;
            perkstruct.count = common_item::function_ea3b3088d82fd357( perkbundle );
            perkstruct.fromcache = 0;
            enemyteammates[ 0 ][ 0 ] common_item::function_96119bed8ab4c5d9( perkstruct, 0 );
        }
        
        wait 5;
        killplayerinstant( host, enemyteammates[ 0 ][ 0 ] );
    }
    
    if ( argshave( args, "ui_spectate_squadmate_in_gulag" ) )
    {
        killplayer( host, enemyteammates[ 0 ] );
        host waittill( #"killcam_ended" );
        wait 2;
        gulagplayer = undefined;
        
        foreach ( player in hostteammates )
        {
            if ( player != host )
            {
                player function_b1cdc0bf7635456c( 1 );
                gulagplayer = player;
                gulagplayer br_gulag::initplayerjail();
                break;
            }
        }
        
        while ( !isdefined( host getspectatingplayer() ) )
        {
            waitframe();
        }
        
        while ( host getspectatingplayer() != gulagplayer )
        {
            iprintlnbold( "Switch to spectating gulag player" );
            waitframe();
        }
        
        wait 1;
        
        foreach ( player in enemyteammates[ 0 ] )
        {
            player function_b1cdc0bf7635456c( 1 );
            killplayer( player, enemyteammates[ 1 ] );
            break;
        }
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0x1ec1c137, Offset: 0x9374
// Size: 0xf4
function loottests( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "infiniteLoot" ) )
    {
        setomnvar( "scriptable_loot_hide", 0 );
        startorigin = host.origin;
        startangles = host.angles;
        curxoffset = 0;
        curyoffset = 0;
        
        for ( var_93bebb5a429957b5 = 0; true ; var_93bebb5a429957b5 = 0 )
        {
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( startorigin + ( curxoffset, curyoffset, 0 ), startangles );
            namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_self_revive", 1, spawnoptions );
            var_93bebb5a429957b5++;
            curxoffset += 10;
            
            if ( curxoffset > 5000 )
            {
                curxoffset = 0;
                curyoffset += 10;
                
                if ( curyoffset > 100 )
                {
                    curyoffset = 0;
                }
            }
            
            if ( var_93bebb5a429957b5 > 8 )
            {
                waitframe();
            }
        }
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0xd4ee865f, Offset: 0x9470
// Size: 0xeb
function testsendgame( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "endGameTeam" ) )
    {
        level.br_infils_disabled = 1;
        setdvar( @"br_minplayers", 8 );
        wait 5;
        br_gulag::shutdowngulag( "circle_index", 0 );
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        killplayerinstant( enemy2, host );
        wait 1;
        killplayerinstant( friendly1, enemy1 );
        wait 1;
        killplayerinstant( friendly2, enemy1 );
        wait 1;
        killplayerinstant( host, enemy1 );
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0x69861914, Offset: 0x9563
// Size: 0x87e
function testsequipment( args, host, hostteammates, enemyteammates )
{
    if ( argshave( args, "bot_uav_test" ) )
    {
        setdvar( @"bot_disableallai", 0 );
        setdvar( @"bot_disableattack", 1 );
        setdvar( @"hash_12d23346fbacee91", 1 );
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy3 = enemyteammates[ 0 ][ 2 ];
        enemya = enemyteammates[ 1 ][ 0 ];
        enemyb = enemyteammates[ 1 ][ 1 ];
        enemyc = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        foreach ( team in level.teamnamelist )
        {
            setteamradar( team, 0 );
            setteamradarstrength( team, 0 );
        }
        
        wait 2;
        uavbot = enemy1;
        uavbot killstreaks::awardkillstreak( "uav", "other", undefined, undefined, undefined, 1 );
        uavbot killstreaks::updatekillstreakuislots();
        wait 1;
        uavbot killstreaks::dokillstreakaction( undefined, 1 );
        wait 2;
        killplayer( enemya, friendly1 );
    }
    
    if ( argshave( args, "supply_drop" ) )
    {
        dir = anglestoforward( host.angles );
        origin = host.origin + dir * 1000;
        br_supply_drops_common::function_fe46eb5b8c73096a( origin, "br_loadout_drop" );
    }
    
    if ( argshave( args, "loadout_in_gas" ) )
    {
        saferadius = getdvarint( @"testforward", 1000 );
        dangerradius = saferadius + 1000;
        dir = anglestoforward( host.angles );
        amount = dangerradius + level.var_ea96217a33eb6457 + 500;
        origin = host.origin + dir * amount;
        thread airdrop_loadout_crate::spawnloadoutcrate( host, origin, 4 );
        level thread br_rewards::managedropbags();
        wait 10;
        scriptcircleat( host.origin, saferadius, host.origin, dangerradius );
    }
    
    if ( argshave( args, "supply_drop_in_gas" ) )
    {
        saferadius = getdvarint( @"testforward", 1000 );
        dangerradius = saferadius + 1000;
        dir = anglestoforward( host.angles );
        amount = dangerradius + level.var_ea96217a33eb6457 + 500;
        origin = host.origin + dir * amount;
        br_supply_drops_common::function_fe46eb5b8c73096a( origin, "br_loadout_drop" );
        wait 10;
        scriptcircleat( host.origin, saferadius, host.origin, dangerradius );
    }
    
    if ( argshave( args, "cold_blooded" ) )
    {
        foreach ( team in level.teamnamelist )
        {
            setteamradar( team, 0 );
            setteamradarstrength( team, 0 );
        }
        
        if ( getdvarint( @"scr_test_perk", 1 ) == 1 )
        {
            host perk::giveperk( "specialty_coldblooded" );
        }
        
        setdvar( @"bot_disableallai", 0 );
        setdvar( @"bot_disableattack", 1 );
        setdvar( @"hash_12d23346fbacee91", 1 );
        enemiessorted = function_628bac9faa9d1e86( enemyteammates[ 0 ], host.origin );
        enemyscrambler = enemiessorted[ 0 ];
        disconnectbot( enemiessorted[ 2 ] );
        disconnectbot( enemiessorted[ 1 ] );
        disconnectbot( enemyteammates[ 1 ][ 0 ] );
        disconnectbot( enemyteammates[ 1 ][ 1 ] );
        disconnectbot( enemyteammates[ 1 ][ 2 ] );
        wait 2;
        enemyscrambler function_5e6fc806ffc84fac();
    }
    
    if ( argshave( args, "bounty_disconnect" ) )
    {
        function_e29ff97063325857();
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy3 = enemyteammates[ 0 ][ 2 ];
        enemya = enemyteammates[ 1 ][ 0 ];
        enemyb = enemyteammates[ 1 ][ 1 ];
        enemyc = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( enemya );
        disconnectbot( enemyb );
        disconnectbot( enemyc );
        item = function_a78f474632a75e4c( enemy1, %"brloot_master_assassination_tablet" );
        wait 1;
        scriptable::scriptable_engineused( item, "brloot_master_assassination_tablet", "visible", enemy1, 0 );
        wait 5;
        disconnectbot( enemy1 );
        wait 1;
        disconnectbot( enemy2 );
        wait 1;
        disconnectbot( enemy3 );
    }
    
    if ( argshave( args, "vip_disconnect" ) )
    {
        function_e29ff97063325857();
        enemy1 = enemyteammates[ 0 ][ 0 ];
        item = function_a78f474632a75e4c( enemy1, %"brloot_vip_tablet" );
        wait 1;
        scriptable::scriptable_engineused( item, "brloot_vip_tablet", "visible", enemy1, 0 );
        wait 5;
        disconnectbot( enemy1 );
    }
    
    if ( argshave( args, "point_turret_spawn" ) )
    {
        function_e29ff97063325857();
        numtospawn = 300;
        origin = host.origin + ( 500, 0, 0 );
        
        for ( i = 0; i < 300 ; i++ )
        {
            angles = host getplayerangles();
            velocity = anglestoforward( angles ) * getdvarint( @"scr_test_speed", 300 );
            var_6f52b311a125f260 = host launchgrenade( "sat_mini_sentry_wz", origin, velocity, 0 );
            origin += anglestoforward( angles ) * 15;
            wait 0.2;
        }
    }
    
    if ( argshave( args, "point_turret_enemy" ) )
    {
        function_e29ff97063325857();
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy3 = enemyteammates[ 0 ][ 2 ];
        enemya = enemyteammates[ 1 ][ 0 ];
        enemyb = enemyteammates[ 1 ][ 1 ];
        enemyc = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        origin = enemy1.origin + ( 500, 0, 50 );
        angles = host getplayerangles();
        velocity = anglestoforward( angles ) * getdvarint( @"scr_test_speed", 300 );
        var_6f52b311a125f260 = enemy1 launchgrenade( "sat_mini_sentry_wz", origin, velocity, 0 );
    }
    
    if ( argshave( args, "enemy_hkd" ) )
    {
        function_e29ff97063325857();
        enemy1 = enemyteammates[ 0 ][ 0 ];
        enemy2 = enemyteammates[ 0 ][ 1 ];
        enemy3 = enemyteammates[ 0 ][ 2 ];
        enemya = enemyteammates[ 1 ][ 0 ];
        enemyb = enemyteammates[ 1 ][ 1 ];
        enemyc = enemyteammates[ 1 ][ 2 ];
        friendly1 = hostteammates[ 1 ];
        friendly2 = hostteammates[ 2 ];
        
        if ( friendly1 == host )
        {
            friendly1 = hostteammates[ 0 ];
        }
        else if ( friendly2 == host )
        {
            friendly2 = hostteammates[ 0 ];
        }
        
        disconnectbot( enemya );
        disconnectbot( enemyb );
        disconnectbot( enemyc );
        friendly1 setorigin( ( 9000, 9000, -400 ) );
        friendly2 setorigin( ( 9000, 9000, -400 ) );
        enemy1 killstreaks::awardkillstreak( "ground_drone_unit", "other", undefined, undefined, undefined, 1 );
        enemy1 killstreaks::updatekillstreakuislots();
        enemy2 killstreaks::awardkillstreak( "ground_drone_unit", "other", undefined, undefined, undefined, 1 );
        enemy2 killstreaks::updatekillstreakuislots();
        wait 1;
        enemy1 killstreaks::dokillstreakaction( undefined, 1 );
        enemy2 killstreaks::dokillstreakaction( undefined, 1 );
        host waittill( #"last_stand_enter" );
        wait 2;
        killplayerinstant( host, enemy3 );
    }
}

// Namespace br_dev_tests
// Params 4
// Checksum 0xe33aa7ce, Offset: 0x9de9
// Size: 0x8f
function runtests( args, host, hostteammates, enemyteammates )
{
    thread function_c751dff3bd2d2dfe( args, host, hostteammates, enemyteammates );
    thread testskillchain( args, host, hostteammates, enemyteammates );
    thread testsgulag( args, host, hostteammates, enemyteammates );
    thread testsrespawn( args, host, hostteammates, enemyteammates );
    thread testsvehicle( args, host, hostteammates, enemyteammates );
    thread testsui( args, host, hostteammates, enemyteammates );
    thread testsendgame( args, host, hostteammates, enemyteammates );
    thread testsequipment( args, host, hostteammates, enemyteammates );
}

