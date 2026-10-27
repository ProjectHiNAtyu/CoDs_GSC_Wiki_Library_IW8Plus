// scripts\mp\dmz\gametypes\dmz_bounty.gsc  (hash_214377804932b865.gscc) (size: 11629 Bytes / 0x2d6d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa4c61dee (2764447214)
// size ...... 11629 (0x2d6d)
// includes .. 13  (offset: 0x2be1)
// strings ... 17  (offset: 0x2c49)
// dev strs .. 2   (offset: 0x2d41)
// exports ... 22  (offset: 0x2119)
// cseg ...... 0x187 + 0x1f92 (0x2119)
// imports ... 54  (offset: 0x2489)
// animtree1 . 0   (offset: 0x2d6d)
// animtree2 . 0   (offset: 0x2d6d)
#using script_7439d62b3781dc9f;
#using script_75ec3104e260fc21;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\largeuppernotification;
#using scripts\mp\team_assimilation;

#namespace dmz_bounty;

// Namespace dmz_bounty
// Params 0
// Checksum 0xdd054099, Offset: 0x1a5
// Size: 0x357
function function_64fc3e290d896c79()
{
    level.var_c3ec30941cd194f7 = getdvarint( @"scr_dmz_bounty_enabled", 1 );
    
    if ( !namespace_46a68a2fbc49b599::function_b6f1d31ece94a9fe() || !level.var_c3ec30941cd194f7 )
    {
        return;
    }
    
    br_gametypes::enablefeature( #"player_bounty" );
    level.lowerkillthreshold = getdvarint( @"hash_bb981387b47d3b0a", 7 );
    level.var_1cca7d2b80808b00 = getdvarint( @"hash_b0d283949fa83cfe", 8 );
    level.var_8863fed0a9a5333c = getdvarfloat( @"hash_d3d9b12ad067b71a", 0.1 );
    level.var_9a5ec69743a400f6 = getdvarfloat( @"scr_dmz_bounty_max_score", 3 );
    level.var_a8409c38e0c6983b = getdvarint( @"hash_8b4fd26f8d0f1f27", 60 ) * 1000;
    level.var_858cb12126e25263 = getdvarint( @"hash_de0a66da13bf686d", 60 ) * 1000;
    level.var_6ef3dde91370037a = getdvarint( @"hash_7e7e58269eec0c4c", 4096 );
    level.var_3a715b66c18f733c = getdvarint( @"hash_88fbe092f035854e", 1000 );
    level.var_9347612c0edb48d1 = getdvarint( @"hash_17211ebb2d6e7fdc", 120 );
    level.var_8f7e498c1bb796c0 = getdvarfloat( @"hash_e15493bf7aa7d925", 0.25 );
    level.var_e959df18687461b5 = getdvarfloat( @"hash_71ca88ed28116f2e", 1.5 );
    level.var_73e41346dd16df26 = getdvarfloat( @"hash_a75878fca2a61a60", 0.25 );
    level.var_64da8b208ab78cb4 = getdvarfloat( @"hash_c01362bafd123e2", 1 );
    level.var_2f6b4db65e3e4a63 = getdvarint( @"hash_9006008df935add2", 4 );
    level.var_b51b70ec6b65844e = getdvarfloat( @"hash_2547f1e25cbfa8bc", 0.5 );
    level.var_51109355e8551f28 = getdvarfloat( @"hash_ffd443b9cee024f6", 1 );
    level.var_f7825d905d94874b = getdvarint( @"hash_4dc3c6509a8ba03e", 4 );
    level.var_4b9906bf54577425 = getdvarint( @"hash_ee7f29468bcf226f", 2 );
    level.var_430f344aedff1ef2 = getdvarfloat( @"hash_cebe90dac8b47fc", 0.25 );
    level.var_2345af34b35e9680 = getdvarint( @"hash_43ed1d607588204e", 3 );
    level.var_c113e49eff927a43 = getdvarfloat( @"hash_96b1854ee4098c22", 1.5 );
    level.var_89a8cb0407259809 = getdvarfloat( @"hash_1627ed73590ddd4f", 0.5 );
    level.var_294a3f92d6073ac1 = getdvarint( @"hash_7d402a6d000f55c5", 1 );
    level.var_51cb0df398140715 = getdvarint( @"hash_fc41fa9f3257837a", 1 );
    level.var_6fce904fa96e06c0 = getdvarint( @"scr_dmz_bounty_circle_radius", 1500 );
    level.var_b05149b3f38bce53 = getdvarint( @"hash_3a113f3a21a87f53", 5 );
    level.var_4abb2b915863dba5 = getdvarint( @"hash_774b8b91e4bcda07", 0 );
    level.var_411aa1b48289bacc = getdvarfloat( @"hash_ffc46b09301c5eb6", 5 );
    level.var_c0a840b562d88822 = [];
    level.var_4952bcfdbd4a5748 = [];
    callback::add( #"player_damaged", &function_117d6a3eb76a47e1 );
    callback::add( #"player_spawned", &function_17f03e4d1a9f1009 );
    
    /#
        level thread function_23e79474dd5e558f();
    #/
}

// Namespace dmz_bounty
// Params 4
// Checksum 0x48641b3, Offset: 0x504
// Size: 0x22c
function function_96d6ef9b9a428dfb( victim, attacker, meansofdeath, overridescore )
{
    if ( !br_gametypes::isfeatureenabled( #"player_bounty" ) )
    {
        return;
    }
    
    if ( !namespace_46a68a2fbc49b599::function_b6f1d31ece94a9fe() || !level.var_c3ec30941cd194f7 || !isdefined( level.var_c0a840b562d88822 ) )
    {
        return;
    }
    
    if ( !( isdefined( attacker ) && isdefined( victim ) ) || !isplayer( attacker ) || !isplayer( victim ) )
    {
        return;
    }
    
    if ( !( isdefined( attacker.pers ) && isdefined( victim.pers ) ) )
    {
        return;
    }
    
    wassuicide = meansofdeath == "MOD_SUICIDE" || meansofdeath == "MOD_FALLING" || attacker == victim;
    
    if ( wassuicide )
    {
        return;
    }
    
    if ( !function_98cca941d97a998a( victim, attacker ) )
    {
        return;
    }
    
    attackerid = attacker player::getuniqueid();
    victimid = victim player::getuniqueid();
    
    if ( !isdefined( level.var_c0a840b562d88822[ attackerid ] ) )
    {
        level.var_c0a840b562d88822[ attackerid ] = spawnstruct();
        level.var_c0a840b562d88822[ attackerid ].victims = [];
        level.var_c0a840b562d88822[ attackerid ].score = 0;
        level.var_c0a840b562d88822[ attackerid ].lastkilltime = 0;
    }
    
    if ( function_a1699ef680e757aa( attackerid, victimid ) && !isdefined( overridescore ) )
    {
        return;
    }
    
    currenttime = gettime();
    level.var_c0a840b562d88822[ attackerid ].victims[ victimid ] = currenttime + level.var_a8409c38e0c6983b;
    lastscore = function_c062af1b6a9b7cda( attackerid );
    level.var_c0a840b562d88822[ attackerid ].score = function_a1f45ff97ba9487b( attackerid, attacker, victim );
    level.var_c0a840b562d88822[ attackerid ].lastkilltime = currenttime;
    
    if ( isdefined( overridescore ) )
    {
        level.var_c0a840b562d88822[ attackerid ].score = overridescore;
    }
    
    function_abf3a7bb593ebdb1( attacker, lastscore );
}

// Namespace dmz_bounty
// Params 1
// Checksum 0xb671031b, Offset: 0x738
// Size: 0x1fd
function function_4b982830a933970e( bountysettings )
{
    killingteam = bountysettings.killingteam;
    killingplayer = bountysettings.killingplayer;
    rewardplayers = [];
    
    if ( isdefined( killingteam ) )
    {
        rewardplayers = teams::getteamdata( killingteam, "players" );
        
        foreach ( player in rewardplayers )
        {
            if ( player::isreallyalive( player ) )
            {
                largeuppernotification::function_55220e3796325cea( [ player ], "bounty_completed", level.var_411aa1b48289bacc );
            }
        }
    }
    else if ( isdefined( killingplayer ) )
    {
        rewardplayers[ rewardplayers.size ] = killingplayer;
        largeuppernotification::function_55220e3796325cea( [ killingplayer ], "bounty_completed", level.var_411aa1b48289bacc );
    }
    
    lootid = loot::function_d3e3bcaea591a6a2( "brloot_plunder_cash_common_1" );
    
    foreach ( player in rewardplayers )
    {
        player br_plunder::playerplunderpickup( level.var_3a715b66c18f733c );
        
        if ( isdefined( lootid ) )
        {
            level thread function_180482530c4f76ba( player, lootid, level.var_411aa1b48289bacc );
        }
    }
    
    if ( isdefined( bountysettings.player ) )
    {
        attackerid = bountysettings.player player::getuniqueid();
        level.var_c0a840b562d88822[ attackerid ] = undefined;
        bountysettings.player.var_61f63b24a5b2158a = undefined;
    }
}

// Namespace dmz_bounty
// Params 2
// Checksum 0x873ec1eb, Offset: 0x93d
// Size: 0x113
function function_d93d870a15b6ba35( bountysettings, player )
{
    if ( bountysettings.player.team == player.team )
    {
        return;
    }
    
    if ( !isdefined( bountysettings.watcher ) )
    {
        bountysettings.watcher = [];
    }
    
    currenttime = gettime();
    playerid = player player::getuniqueid();
    
    if ( !isdefined( bountysettings.watcher[ playerid ] ) )
    {
        bountysettings.watcher[ playerid ] = gettime() + level.var_858cb12126e25263;
        largeuppernotification::function_55220e3796325cea( [ player ], "bounty_placed_enemy", level.var_411aa1b48289bacc );
        player utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_killed_nearby_callout", [ player ] );
        return;
    }
    
    if ( bountysettings.watcher[ playerid ] < currenttime )
    {
        bountysettings.watcher[ playerid ] = undefined;
    }
}

// Namespace dmz_bounty
// Params 3, eflags: 0x4
// Checksum 0x126bfaf1, Offset: 0xa58
// Size: 0x7f
function private function_180482530c4f76ba( player, lootid, waittime )
{
    player notify( #"bounty_reward_delay" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"bounty_reward_delay" );
    wait waittime + 1;
    view_origin = player getvieworigin();
    player br_pickups::function_55de798ca5dc4080( lootid, view_origin, 1, level.var_3a715b66c18f733c );
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0xbcf57f88, Offset: 0xadf
// Size: 0x15
function private function_17f03e4d1a9f1009( params )
{
    level thread function_e46c392d7dd2654d( self );
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0x3dbc8d0e, Offset: 0xafc
// Size: 0x285
function private function_117d6a3eb76a47e1( params )
{
    eattacker = params.eattacker;
    victim = params.victim;
    smeansofdeath = params.smeansofdeath;
    
    if ( !utility::isbulletdamage( smeansofdeath ) )
    {
        return;
    }
    
    if ( !( isdefined( eattacker ) && isdefined( victim ) && isdefined( eattacker.team ) && isdefined( victim.team ) ) || eattacker.team == victim.team )
    {
        return;
    }
    
    if ( !isdefined( level.var_4952bcfdbd4a5748[ victim.team ] ) )
    {
        level.var_4952bcfdbd4a5748[ victim.team ] = [];
    }
    
    currenttime = gettime();
    
    if ( !isdefined( level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ] ) )
    {
        level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ] = spawnstruct();
        level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_a971f94b95305335 = currenttime;
        level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 = currenttime;
        return;
    }
    
    if ( isdefined( level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 ) && level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 + level.var_9347612c0edb48d1 * 1000 < currenttime )
    {
        level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_a971f94b95305335 = currenttime;
        level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 = currenttime;
        return;
    }
    
    level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 = currenttime;
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0x6417d060, Offset: 0xd89
// Size: 0x27d
function private function_e46c392d7dd2654d( player )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        player waittill( #"bulletwhizby", attacker, distance, position, forward );
        
        if ( !( isdefined( attacker ) && isdefined( attacker.team ) ) || attacker.team == player.team )
        {
            continue;
        }
        
        if ( !isdefined( level.var_4952bcfdbd4a5748[ player.team ] ) )
        {
            level.var_4952bcfdbd4a5748[ player.team ] = [];
        }
        
        currenttime = gettime();
        
        if ( !isdefined( level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ] ) )
        {
            level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ] = spawnstruct();
            level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ].var_a971f94b95305335 = currenttime;
            level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ].var_a6d845b00cfc57d9 = currenttime;
            continue;
        }
        
        if ( isdefined( level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ].var_a6d845b00cfc57d9 ) && level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ].var_a6d845b00cfc57d9 + level.var_9347612c0edb48d1 * 1000 < currenttime )
        {
            level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ].var_a971f94b95305335 = currenttime;
            level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ].var_a6d845b00cfc57d9 = currenttime;
            continue;
        }
        
        level.var_4952bcfdbd4a5748[ player.team ][ attacker.team ].var_a6d845b00cfc57d9 = currenttime;
    }
}

// Namespace dmz_bounty
// Params 2, eflags: 0x4
// Checksum 0x5fbf1405, Offset: 0x100e
// Size: 0xe4, Type: bool
function private function_5ff6db4ef53d460f( attacker, victim )
{
    if ( !( isdefined( attacker ) && isdefined( victim ) ) )
    {
        return false;
    }
    
    if ( !isdefined( level.var_4952bcfdbd4a5748[ attacker.team ][ victim.team ] ) )
    {
        return false;
    }
    
    attackertime = level.var_4952bcfdbd4a5748[ attacker.team ][ victim.team ].var_a971f94b95305335;
    victimtime = 0;
    
    if ( isdefined( level.var_4952bcfdbd4a5748[ victim.team ][ attacker.team ] ) )
    {
        victimtime = level.var_4952bcfdbd4a5748[ victim.team ][ attacker.team ].var_a971f94b95305335;
    }
    
    return attackertime <= victimtime;
}

// Namespace dmz_bounty
// Params 2, eflags: 0x4
// Checksum 0x26e16eb4, Offset: 0x10fb
// Size: 0x117, Type: bool
function private function_98cca941d97a998a( victim, attacker )
{
    victimid = victim player::getuniqueid();
    victimsteam = teams::getteamdata( victim.team, "players" );
    
    foreach ( teammate in victimsteam )
    {
        teammateid = teammate player::getuniqueid();
        
        if ( isdefined( teammateid ) && isdefined( level.var_c0a840b562d88822[ teammateid ] ) && isdefined( level.var_c0a840b562d88822[ teammateid ].bountysettings ) )
        {
            return false;
        }
    }
    
    if ( namespace_76299fb251d3aacd::function_c089e3a05ab8b52( victim.team, attacker.team ) )
    {
        return false;
    }
    
    return true;
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0x1a439823, Offset: 0x121b
// Size: 0x8a
function private function_1fe136002a482625( player )
{
    playerid = player player::getuniqueid();
    
    if ( !isdefined( level.var_c0a840b562d88822[ playerid ] ) )
    {
        level.var_c0a840b562d88822[ playerid ] = spawnstruct();
        level.var_c0a840b562d88822[ playerid ].victims = [];
        level.var_c0a840b562d88822[ playerid ].score = 0;
        level.var_c0a840b562d88822[ playerid ].lastkilltime = 0;
    }
}

// Namespace dmz_bounty
// Params 2, eflags: 0x4
// Checksum 0xae68b46f, Offset: 0x12ad
// Size: 0x241
function private function_abf3a7bb593ebdb1( attacker, lastscore )
{
    if ( attacker.var_61f63b24a5b2158a )
    {
        return;
    }
    
    attackerid = attacker player::getuniqueid();
    currentscore = function_c062af1b6a9b7cda( attackerid );
    currentthreshold = function_c615ca1753f55142( currentscore );
    previousthreshold = function_c615ca1753f55142( lastscore );
    
    if ( currentthreshold == 3 && previousthreshold != 2 )
    {
        currentthreshold = 2;
        level.var_c0a840b562d88822[ attackerid ].score = level.var_1cca7d2b80808b00 - 0.1;
    }
    
    if ( currentthreshold < 3 )
    {
        function_e2edf6d6bdae292d( attacker, currentthreshold );
        return;
    }
    
    function_e2edf6d6bdae292d( attacker, currentthreshold );
    overridesettings = spawnstruct();
    
    if ( level.var_294a3f92d6073ac1 )
    {
        function_beb34578d3d002f( overridesettings );
    }
    else
    {
        function_8084b116675a77d8( overridesettings );
    }
    
    attacker.var_61f63b24a5b2158a = 1;
    overridesettings.headiconfriendly = "ui_map_icon_bounty_s5";
    overridesettings.var_af4505e4e9f04c8c = &function_d93d870a15b6ba35;
    overridesettings.var_acdfc050d749c999 = &function_4b982830a933970e;
    bountysettings = namespace_46a68a2fbc49b599::function_53f805be5f836a5( attacker, overridesettings );
    largeuppernotification::function_55220e3796325cea( [ attacker ], "bounty_placed_self", level.var_411aa1b48289bacc );
    attackteam = teams::getteamdata( attacker, "players" );
    
    foreach ( player in attackteam )
    {
        player setclientomnvar( "ui_dmz_bounty_squad_index", attacker.sessionuimemberindex );
        
        if ( player != attacker && player::isreallyalive( player ) )
        {
            largeuppernotification::function_55220e3796325cea( [ player ], "bounty_placed_friendly", level.var_411aa1b48289bacc );
        }
    }
    
    level.var_c0a840b562d88822[ attackerid ].bountysettings = bountysettings;
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0x9360ccdf, Offset: 0x14f6
// Size: 0x57
function private function_8084b116675a77d8( overridesettings )
{
    overridesettings.var_e73a01c81013d4fe = level.var_51cb0df398140715 ? "HEAD_ICON" : "NONE";
    overridesettings.var_bc30c84910a7bec5 = "HEAD_ICON";
    overridesettings.headiconupdatetime = level.var_4abb2b915863dba5;
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0xd11b7104, Offset: 0x1555
// Size: 0x8e
function private function_beb34578d3d002f( overridesettings )
{
    overridesettings.var_e73a01c81013d4fe = level.var_51cb0df398140715 ? "HEAD_ICON" : "NONE";
    overridesettings.var_bc30c84910a7bec5 = "QUEST_CIRCLE";
    overridesettings.circleradius = level.var_6fce904fa96e06c0;
    overridesettings.circleupdatetime = level.var_b05149b3f38bce53;
    overridesettings.var_897dae3075ed501f = "Bounty_DMZ";
    overridesettings.questcircleicon = "ui_map_icon_bounty_s5";
}

// Namespace dmz_bounty
// Params 2, eflags: 0x4
// Checksum 0xcfdae218, Offset: 0x15eb
// Size: 0x6a, Type: bool
function private function_a1699ef680e757aa( attackerid, victimid )
{
    if ( !isdefined( level.var_c0a840b562d88822[ attackerid ].victims[ victimid ] ) )
    {
        return false;
    }
    
    cooldowntime = level.var_c0a840b562d88822[ attackerid ].victims[ victimid ];
    currenttime = gettime();
    return cooldowntime <= currenttime;
}

// Namespace dmz_bounty
// Params 3, eflags: 0x4
// Checksum 0xf2e6e9c0, Offset: 0x165e
// Size: 0x4d6
function private function_a1f45ff97ba9487b( attackerid, attacker, victim )
{
    currentscore = function_c062af1b6a9b7cda( attackerid );
    algo = getdvarint( @"hash_9d43c91bd2b1870e", 1 );
    newscore = 1;
    attackerkills = attacker.pers[ "kills" ] ?? 0;
    victimkills = victim.pers[ "kills" ] ?? 0;
    
    switch ( algo )
    {
        case 1:
            newscore = function_5ff6db4ef53d460f( attacker, victim ) ? level.var_8f7e498c1bb796c0 : 1;
            timeremainingpercent = gamelogic_mp::gettimeremainingpercentage();
            timeremainingweight = level.var_e959df18687461b5 * ( timeremainingpercent < 0.75 ? timeremainingpercent : 1 );
            newscore *= timeremainingweight;
            victimteamplayers = teams::getteamdata( victim.team, "players" );
            attackerteamplayers = teams::getteamdata( attacker.team, "players" );
            var_a93227379f23c338 = 1 + ( attackerteamplayers.size - victimteamplayers.size ) / team_assimilation::getmaxassimilationteamsize();
            newscore *= var_a93227379f23c338;
            var_9793d4277adb2eac = level.var_2f6b4db65e3e4a63 / ( victimkills + 1 );
            newscore *= clamp( var_9793d4277adb2eac, level.var_73e41346dd16df26, level.var_64da8b208ab78cb4 );
            var_f1ac341082d15b3f = 1;
            
            foreach ( attackerteammate in attackerteamplayers )
            {
                teammatekills = attackerteammate.pers[ "kills" ] ?? 0;
                var_f1ac341082d15b3f += teammatekills;
            }
            
            if ( var_f1ac341082d15b3f >= level.var_2345af34b35e9680 )
            {
                foreach ( attackerteammate in attackerteamplayers )
                {
                    if ( attackerteammate != attacker )
                    {
                        function_1fe136002a482625( attackerteammate );
                        var_321ee80094fbf960 = attackerteammate player::getuniqueid();
                        var_83bb13ef0ab38a4 = function_5ff6db4ef53d460f( attacker, victim ) ? level.var_8f7e498c1bb796c0 : 1;
                        level.var_c0a840b562d88822[ var_321ee80094fbf960 ].score += var_83bb13ef0ab38a4;
                    }
                }
            }
            
            alivevictimteam = teams::getteamdata( victim.team, "aliveCount" );
            
            if ( alivevictimteam <= 0 )
            {
                newscore *= level.var_c113e49eff927a43;
            }
            
            if ( isdefined( victim.attackers ) )
            {
                foreach ( assister in victim.attackers )
                {
                    if ( isplayer( assister ) && assister != attacker && assister != victim )
                    {
                        function_1fe136002a482625( assister );
                        assisterid = assister player::getuniqueid();
                        var_83bb13ef0ab38a4 = function_5ff6db4ef53d460f( attacker, victim ) ? level.var_8f7e498c1bb796c0 : 1;
                        level.var_c0a840b562d88822[ assisterid ].score += level.var_89a8cb0407259809 * var_83bb13ef0ab38a4;
                    }
                }
            }
            
            if ( isdefined( victim.pers[ "assists" ] ) )
            {
                newscore *= clamp( var_9793d4277adb2eac, level.var_b51b70ec6b65844e, level.var_51109355e8551f28 );
            }
            
            if ( attackerkills + 1 <= level.var_4b9906bf54577425 )
            {
                newscore *= level.var_430f344aedff1ef2;
            }
            
            break;
        default:
            break;
    }
    
    newscore = clamp( newscore, level.var_8863fed0a9a5333c, level.var_9a5ec69743a400f6 );
    return currentscore + newscore;
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0xb3453b69, Offset: 0x1b3d
// Size: 0x35
function private function_c062af1b6a9b7cda( attackerid )
{
    if ( !isdefined( level.var_c0a840b562d88822[ attackerid ] ) )
    {
        return 0;
    }
    
    return level.var_c0a840b562d88822[ attackerid ].score;
}

// Namespace dmz_bounty
// Params 1
// Checksum 0xeecc4a45, Offset: 0x1b7b
// Size: 0x5f
function function_66fcbf6381df44de( player )
{
    if ( !( isdefined( level.var_c0a840b562d88822 ) && isdefined( player ) ) )
    {
        return 0;
    }
    
    playerid = player player::getuniqueid();
    
    if ( !isdefined( level.var_c0a840b562d88822[ playerid ] ) )
    {
        return 0;
    }
    
    return level.var_c0a840b562d88822[ playerid ].score;
}

// Namespace dmz_bounty
// Params 1, eflags: 0x4
// Checksum 0x609a8aa7, Offset: 0x1be3
// Size: 0x49
function private function_c615ca1753f55142( score )
{
    threshold = 0;
    
    if ( score > 0 )
    {
        threshold++;
    }
    
    if ( score >= level.lowerkillthreshold )
    {
        threshold++;
    }
    
    if ( score >= level.var_1cca7d2b80808b00 )
    {
        threshold++;
    }
    
    return threshold;
}

// Namespace dmz_bounty
// Params 2, eflags: 0x4
// Checksum 0xaa09f51c, Offset: 0x1c35
// Size: 0xdc
function private function_e2edf6d6bdae292d( attacker, threshold )
{
    switch ( threshold )
    {
        case 1:
            attacker utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_killed_marked_warning_first", [ attacker ] );
            break;
        case 2:
            attacker utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_killed_marked_second", [ attacker ] );
            break;
        case 3:
            attacker utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_killed_marked_final", [ attacker ] );
            break;
        default:
            break;
    }
}

/#

    // Namespace dmz_bounty
    // Params 0
    // Checksum 0x22c69d84, Offset: 0x1d19
    // Size: 0x400, Type: dev
    function function_23e79474dd5e558f()
    {
        level endon( #"game_ended" );
        level waittill( #"matchstarttimer_done" );
        
        while ( true )
        {
            dvarval = getdvarint( @"scr_dmz_bounty_test", 0 );
            host = gamelogic_mp::gethostplayer();
            chosenplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( isbot( player ) && player::isreallyalive( player ) && player.team != host.team )
                {
                    chosenplayer = player;
                    break;
                }
            }
            
            if ( isdefined( chosenplayer ) && isdefined( host ) )
            {
                switch ( dvarval )
                {
                    case 1:
                        function_96d6ef9b9a428dfb( host, chosenplayer, "<dev string:x24>", level.var_1cca7d2b80808b00 );
                        break;
                    case 2:
                        attackerid = chosenplayer player::getuniqueid();
                        namespace_46a68a2fbc49b599::bounty_endbounty( level.var_c0a840b562d88822[ attackerid ].bountysettings, 1, 0 );
                        level.var_c0a840b562d88822[ attackerid ] = undefined;
                        break;
                    case 3:
                        function_96d6ef9b9a428dfb( chosenplayer, host, "<dev string:x24>", 7 );
                        host.pers[ "<dev string:x2e>" ] = host.pers[ "<dev string:x2e>" ] + 7;
                        break;
                    case 4:
                        attackerid = host player::getuniqueid();
                        namespace_46a68a2fbc49b599::bounty_endbounty( level.var_c0a840b562d88822[ attackerid ].bountysettings, 1, 0 );
                        level.var_c0a840b562d88822[ attackerid ] = undefined;
                        break;
                    case 5:
                        foreach ( player in level.players )
                        {
                            if ( isbot( player ) && player::isreallyalive( player ) && player.team == host.team && !namespace_46a68a2fbc49b599::function_8f0f35e0caa21fd2( player ) )
                            {
                                function_96d6ef9b9a428dfb( chosenplayer, player, "<dev string:x24>", 7 );
                                player.pers[ "<dev string:x2e>" ] = player.pers[ "<dev string:x2e>" ] + 7;
                                break;
                            }
                        }
                        
                        break;
                    case 6:
                        foreach ( player in level.players )
                        {
                            if ( isbot( player ) && player::isreallyalive( player ) && player.team == host.team && namespace_46a68a2fbc49b599::function_8f0f35e0caa21fd2( player ) )
                            {
                                attackerid = player player::getuniqueid();
                                namespace_46a68a2fbc49b599::bounty_endbounty( level.var_c0a840b562d88822[ attackerid ].bountysettings, 1, 0 );
                                level.var_c0a840b562d88822[ attackerid ] = undefined;
                                break;
                            }
                        }
                        
                        break;
                }
            }
            
            setdvar( @"scr_dmz_bounty_test", 0 );
            wait 1;
        }
    }

#/
