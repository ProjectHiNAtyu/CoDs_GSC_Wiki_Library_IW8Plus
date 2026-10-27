// scripts\mp\bounty_wanted.gsc  (hash_77f7bab3424bb943.gscc) (size: 23241 Bytes / 0x5ac9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71cccd70 (1909247344)
// size ...... 23241 (0x5ac9)
// includes .. 17  (offset: 0x5769)
// strings ... 45  (offset: 0x57f1)
// dev strs .. 6   (offset: 0x5a61)
// exports ... 57  (offset: 0x3c59)
// cseg ...... 0x477 + 0x37e2 (0x3c59)
// imports ... 141 (offset: 0x4541)
// animtree1 . 0   (offset: 0x5ac9)
// animtree2 . 0   (offset: 0x5ac9)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\dev;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\bounty_system;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\dmz\modified_values;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\operator;

#namespace bounty_wanted;

// Namespace bounty_wanted
// Params 0, eflags: 0x5
// Checksum 0x121eaee, Offset: 0x495
// Size: 0x20d
function private autoexec init()
{
    if ( !isenabled() )
    {
        return;
    }
    
    foreach ( index, bountylevel in level.gametypebundle.bountylevels )
    {
        if ( bountylevel.var_5dd42deb24f60880 )
        {
            level.wantedthreshold = index;
            break;
        }
    }
    
    if ( !isdefined( level.var_4952bcfdbd4a5748 ) )
    {
        level.var_4952bcfdbd4a5748 = [];
    }
    
    if ( !isdefined( level.bountytracker ) )
    {
        level.bountytracker = [];
    }
    
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"hash_89555462d4b2ee9f", &function_7c74fd56c1decee3 );
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"player_damaged", &onplayerdamaged );
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    
    if ( getdvarint( @"hash_bc723f6b024281b0", 0 ) || getdvarint( @"hash_f6fc513bac033688", 0 ) )
    {
        callback::add( #"prematch_done", &onprematchdone );
    }
    
    if ( isplayer( self ) )
    {
        skinref = operator::function_cc5d60d5178c5007();
        skinlootid = loot::getlootidfromref( skinref ) ?? 0;
        entnumber = self getentitynumber();
        function_9134eb92130b9544( "ui_bounty_", entnumber, 0, skinlootid );
    }
    
    scriptable::scriptable_addusedcallbackbypart( "bounty_pay_off_station", &function_f75d0acadc9e3015 );
    level thread function_71044e7f34def746();
    level thread setactivestations();
    
    /#
        level thread dev::devcommandwatcher( @"bounty_wanted", &function_f92b61cf0f15a321 );
    #/
}

// Namespace bounty_wanted
// Params 0
// Checksum 0xcd1526e4, Offset: 0x6aa
// Size: 0x44, Type: bool
function isenabled()
{
    return bounty_system::function_3418b51d44b96f96() && getdvarint( @"scr_wanted_enabled", istrue( level.gametypebundle.wantedenabled ) ) && level.gametypebundle.bountylevels;
}

// Namespace bounty_wanted
// Params 0, eflags: 0xc
// Checksum 0xd0af4476, Offset: 0x6f7
// Size: 0x101
function private setactivestations()
{
    self notify( #"hash_17d748b8f26ebf61" );
    self endon( #"hash_17d748b8f26ebf61" );
    level endon( #"game_ended" );
    utility::flag_wait( "poi_initialized" );
    stations = getentitylessscriptablearray( "scriptable_bounty_pay_off_station", "classname" );
    
    if ( !stations || !stations.size )
    {
        return;
    }
    
    var_d2e7c37a37a82569 = getdvarint( @"hash_4b45eb0f5f687bec", 5 );
    count = 0;
    
    foreach ( station in stations )
    {
        if ( count >= var_d2e7c37a37a82569 )
        {
            station setscriptablepartstate( "bounty_pay_off_station", "hidden" );
        }
        
        count++;
    }
}

// Namespace bounty_wanted
// Params 0, eflags: 0xc
// Checksum 0x7f6c2153, Offset: 0x800
// Size: 0x57
function private function_71044e7f34def746()
{
    self notify( #"hash_94cadfdee77ac3e5" );
    self endon( #"hash_94cadfdee77ac3e5" );
    level endon( #"game_ended" );
    
    while ( !utility::issharedfuncdefined( #"game", #"registeronluieventcallback" ) )
    {
        wait 1;
    }
    
    namespace_9d8e359c3b1041e5::registeronluieventcallbacksharedfunc( &function_11028afbe0567976 );
}

// Namespace bounty_wanted
// Params 2, eflags: 0x4
// Checksum 0x62e654b2, Offset: 0x85f
// Size: 0x24, Type: bool
function private function_98cca941d97a998a( victim, attacker )
{
    if ( victim function_3136839752daef5b() )
    {
        return false;
    }
    
    return true;
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0x640f428b, Offset: 0x88c
// Size: 0x7d
function private function_1fe136002a482625( playerid )
{
    if ( !isdefined( level.bountytracker ) )
    {
        level.bountytracker = [];
    }
    
    if ( !isdefined( playerid ) )
    {
        playerid = player::getuniqueid();
    }
    
    if ( !level.bountytracker[ playerid ] )
    {
        level.bountytracker[ playerid ] = {};
        level.bountytracker[ playerid ].victims = [];
        level.bountytracker[ playerid ].score = 0;
    }
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0x79243585, Offset: 0x911
// Size: 0x205
function private onprematchdone( params )
{
    teamschosen = [];
    
    foreach ( player in level.players )
    {
        if ( teamschosen[ player.team ] )
        {
            continue;
        }
        
        teamschosen[ player.team ] = 1;
        teamplayers = teams::getteamdata( player.team, "players" );
        var_256238f92e24058f = undefined;
        
        if ( getdvarint( @"hash_bc723f6b024281b0", 0 ) )
        {
            foreach ( teammate in teamplayers )
            {
                if ( teammate function_3136839752daef5b() )
                {
                    var_256238f92e24058f = undefined;
                    break;
                }
                
                var_256238f92e24058f = teammate;
            }
            
            if ( var_256238f92e24058f )
            {
                var_256238f92e24058f function_79183cad3c7b34e5( function_5be62851fc527894(), 1 );
            }
        }
        
        if ( getdvarint( @"hash_f6fc513bac033688", 0 ) )
        {
            foreach ( teammate in teamplayers )
            {
                if ( !teammate function_89d828b1900e604f() )
                {
                    teammate function_79183cad3c7b34e5( function_47373684d07319dc(), 1 );
                }
            }
        }
    }
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xea1ba37c, Offset: 0xb1e
// Size: 0x12a
function private function_7c74fd56c1decee3( params )
{
    if ( !isdefined( params.lootid ) || params.lootid == 0 || !isdefined( params.player ) || !isdefined( params.item.additionaldata ) || params.player.var_e011522a173ce8b9 )
    {
        return;
    }
    
    typeref = common_item::function_9deb822f286163b1( params.lootid );
    
    if ( typeref == "dogtag" && isdefined( level.gametypebundle.var_48b665310078a5a ) && params.item.additionaldata.bountyScore )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", level.gametypebundle.var_48b665310078a5a, [ params.player ] );
        params.player.var_e011522a173ce8b9 = 1;
    }
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0x33e7195, Offset: 0xc50
// Size: 0x13
function private onplayerconnect( params )
{
    common_instance_inventory::function_79183cad3c7b34e5();
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xb8a8e946, Offset: 0xc6b
// Size: 0xe5
function private onplayerdisconnect( params )
{
    if ( self.team )
    {
        metadata = { #var_9493faa76a8d91c8:function_fc000e7d3c544a81() };
        function_b2975c6a3a5ce961( self, self.team, metadata );
    }
    
    foreach ( player in level.players )
    {
        if ( player == self )
        {
            continue;
        }
        
        metadata = { #var_9493faa76a8d91c8:player function_fc000e7d3c544a81() };
        function_b2975c6a3a5ce961( player, player.team, metadata );
    }
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xdf88e6ae, Offset: 0xd58
// Size: 0x283
function private onplayerdamaged( params )
{
    eattacker = params.eattacker;
    victim = params.victim;
    smeansofdeath = params.smeansofdeath;
    
    if ( !utility::isbulletdamage( smeansofdeath ) )
    {
        return;
    }
    
    if ( !eattacker.team || !victim.team || eattacker.team == victim.team )
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
    
    if ( isdefined( level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 ) && level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 + level.gametypebundle.var_5dd8441585b5867d * 1000 < currenttime )
    {
        level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_a971f94b95305335 = currenttime;
        level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 = currenttime;
        return;
    }
    
    level.var_4952bcfdbd4a5748[ victim.team ][ eattacker.team ].var_26f7832182a5d625 = currenttime;
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0x884c47b, Offset: 0xfe3
// Size: 0x22f
function private onplayerdeath( params )
{
    if ( !bounty_system::function_3418b51d44b96f96() || !level.bountytracker )
    {
        return;
    }
    
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !attacker || !victim || !isplayer( attacker ) || !isplayer( victim ) )
    {
        return;
    }
    
    wassuicide = params.meansofdeath == "MOD_SUICIDE" || params.meansofdeath == "MOD_FALLING" || attacker == victim;
    
    if ( wassuicide )
    {
        return;
    }
    
    if ( getdvarint( @"hash_7137dc0997d8512a", 0 ) )
    {
        attacker function_1fe136002a482625();
        
        if ( !attacker function_89d828b1900e604f() )
        {
            attacker function_79183cad3c7b34e5( function_47373684d07319dc() );
            return;
        }
        
        attacker function_a1ef9a434ccc5c92( function_1f6e45bb5a3735b5() );
        return;
    }
    
    if ( !attacker.pers || !victim.pers )
    {
        return;
    }
    
    if ( !function_98cca941d97a998a( victim, attacker ) )
    {
        return;
    }
    
    attacker function_1fe136002a482625();
    attackerid = attacker player::getuniqueid();
    victimid = victim player::getuniqueid();
    var_7676e2e5dc0cd770 = attacker getplayerunoid();
    unoid = 0;
    
    if ( var_7676e2e5dc0cd770 != "" )
    {
        unoid = int( var_7676e2e5dc0cd770 );
    }
    
    if ( !isdefined( self.challengedata ) )
    {
        self.challengedata = {};
    }
    
    self.challengedata.var_d7fd9e2b8412bb3f = int( unoid );
    
    if ( !isdefined( level.bountytracker[ attackerid ].victims[ victimid ] ) )
    {
        level.bountytracker[ attackerid ].victims[ victimid ] = {};
    }
    
    if ( function_a1699ef680e757aa( attackerid, victimid ) )
    {
        return;
    }
    
    thread function_5406ba5c834c1851( attacker, victim, attackerid, victimid );
    score = function_823cdb64bd454c0( attacker, victim, attackerid, victimid );
    attacker function_a1ef9a434ccc5c92( score );
    victim notify( "clear_multiplier_" + attackerid );
}

// Namespace bounty_wanted
// Params 4, eflags: 0x4
// Checksum 0x38f43e83, Offset: 0x121a
// Size: 0xad
function private function_5406ba5c834c1851( attacker, victim, attackerid, victimid )
{
    level endon( #"game_ended" );
    attacker endon( #"disconnect" );
    level.bountytracker[ attackerid ].victims[ victimid ].cooldown = 1;
    victim utility::waittill_any_timeout_no_endon_death( level.gametypebundle.var_223367ebcbc0057c ?? 60, "disconnect" );
    level.bountytracker[ attackerid ].victims[ victimid ].cooldown = undefined;
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xa67f12d5, Offset: 0x12cf
// Size: 0x15d
function private function_acdfc050d749c999( bountysettings )
{
    if ( !bountysettings.player || bountysettings.context == 4 )
    {
        return;
    }
    
    if ( bountysettings.player.extracted )
    {
        bountysettings.player.var_9aec6b5641d085f5 = bountysettings.player function_fc000e7d3c544a81();
    }
    
    killedplayer = isdefined( bountysettings.killingplayer ) && bountysettings.success;
    
    if ( killedplayer && isplayer( bountysettings.player ) && isplayer( bountysettings.killingplayer ) )
    {
        entnumber = bountysettings.player getentitynumber();
        index = ( bountysettings.player function_d6112fe3de4a7987() ?? -1 ) + 1;
        skinref = bountysettings.player operator::function_cc5d60d5178c5007();
        skinlootid = loot::getlootidfromref( skinref ) ?? 0;
        bountysettings.killingplayer function_9134eb92130b9544( "ui_bounty_wanted_killed_", entnumber, index, skinlootid );
    }
    
    bountysettings.player function_79183cad3c7b34e5( 0, undefined, killedplayer );
}

// Namespace bounty_wanted
// Params 2, eflags: 0x4
// Checksum 0xc82a4239, Offset: 0x1434
// Size: 0x30, Type: bool
function private function_7edbf2c9a0d3d243( bountysettings, params )
{
    return !bountysettings.queued || bountysettings.bountyincreased;
}

// Namespace bounty_wanted
// Params 3, eflags: 0x4
// Checksum 0xa010cc64, Offset: 0x146d
// Size: 0x1d6
function private function_a0df4483f5217269( bountysettings, playerentering, proximitystruct )
{
    if ( !bountysettings.player )
    {
        return;
    }
    
    level endon( #"game_ended" );
    playerentering endon( #"disconnect" );
    self endon( #"death_or_disconnect" );
    var_4cddba67dd3afb73 = bountysettings.player getentitynumber();
    
    if ( !bounty_system::function_dcf52737acf7857( bountysettings, hashcat( proximitystruct.ref, "Splash" + var_4cddba67dd3afb73 ), playerentering ) )
    {
        bounty_system::function_c3c0dc0042a83a7e( bountysettings, hashcat( proximitystruct.ref, "Splash" + var_4cddba67dd3afb73 ), proximitystruct.splashcooldown ?? 120, playerentering );
        poiname = utility::callsharedfunc( #"poi", #"hash_79b3b95992c86428", bountysettings.player.origin );
        poiindex = utility::callsharedfunc( #"poi", #"hash_cd2758a499bb6be4", poiname );
        
        if ( poiindex >= 0 )
        {
            playerentering setclientomnvar( "ui_bounty_wanted_nearby_poi", poiindex );
        }
        
        waitframe();
        
        if ( playerentering )
        {
            index = ( bountysettings.player function_d6112fe3de4a7987() ?? -1 ) + 1;
            skinlootid = 0;
            
            if ( isplayer( bountysettings.player ) )
            {
                skinref = bountysettings.player operator::function_cc5d60d5178c5007();
                skinlootid = loot::getlootidfromref( skinref ) ?? 0;
            }
            
            playerentering function_9134eb92130b9544( "ui_bounty_wanted_nearby_", var_4cddba67dd3afb73, index, skinlootid );
        }
        
        waitframe();
        playerentering setclientomnvar( "ui_bounty_wanted_nearby_poi", 0 );
        playerentering function_9134eb92130b9544( "ui_bounty_wanted_nearby_", 255, 0, 0 );
    }
}

// Namespace bounty_wanted
// Params 2, eflags: 0x4
// Checksum 0x734d879e, Offset: 0x164b
// Size: 0x70
function private function_a1699ef680e757aa( attackerid, victimid )
{
    if ( !level.bountytracker[ attackerid ].victims || !level.bountytracker[ attackerid ].victims[ victimid ] )
    {
        return 0;
    }
    
    return level.bountytracker[ attackerid ].victims[ victimid ].cooldown;
}

// Namespace bounty_wanted
// Params 4, eflags: 0x4
// Checksum 0x152c6e94, Offset: 0x16c4
// Size: 0x5b1
function private function_823cdb64bd454c0( attacker, victim, attackerid, victimid )
{
    score = 1;
    printscoreinfo( "-------Start Bounty Score Calc-------" );
    var_fcebb77a43205bbe = function_5ff6db4ef53d460f( attacker, victim ) ? level.gametypebundle.var_47866f7d4fbfc6a8 : 1;
    score *= var_fcebb77a43205bbe;
    printscoreinfo( "Self Defense", score );
    timeremainingpercent = 1;
    
    if ( game_utility_mp::gettimelimit() != 0 )
    {
        timeremainingpercent = gamelogic_mp::gettimeremainingpercentage();
    }
    
    timeremainingweight = level.gametypebundle.var_dbb6194e82bd510f * ( timeremainingpercent < 0.75 ? timeremainingpercent : 1 );
    score *= timeremainingweight;
    printscoreinfo( "Time Remaining", score, "Time Remaning Percent: " + timeremainingpercent );
    victimteamplayers = teams::getteamdata( victim.team, "players" );
    attackerteamplayers = teams::getteamdata( attacker.team, "players" );
    var_5363f72a5846850d = attackerteamplayers.size - victimteamplayers.size;
    
    if ( var_5363f72a5846850d > 0 )
    {
        var_a93227379f23c338 = 1 + var_5363f72a5846850d * level.gametypebundle.var_615688b58aca7ac;
        score *= var_a93227379f23c338;
        printscoreinfo( "Team Size Differential", score, var_5363f72a5846850d - 1 );
    }
    
    var_f1ac341082d15b3f = 0;
    
    foreach ( attackerteammate in attackerteamplayers )
    {
        teammatekills = attackerteammate.pers[ "kills" ] ?? 0;
        var_f1ac341082d15b3f += teammatekills;
    }
    
    if ( var_f1ac341082d15b3f >= level.gametypebundle.var_90bfff5db33fc4d4 )
    {
        printscoreinfo( "-------------Squad Kill Amount Begin-------------" );
        score *= level.gametypebundle.var_9798da502f73e4cf;
        printscoreinfo( "-------------Squad Kill Amount End-------------" );
    }
    
    alivevictimteam = teams::getteamdata( victim.team, "aliveCount" );
    
    if ( alivevictimteam <= 0 )
    {
        score *= level.gametypebundle.var_5a74b55f6b0a0a81;
    }
    
    if ( victim.attackers )
    {
        foreach ( assister in victim.attackers )
        {
            if ( !isplayer( assister ) || assister == attacker || assister == victim || ( assister.pers[ "assists" ] ?? 0 ) + ( assister.pers[ "kills" ] ?? 0 ) <= level.gametypebundle.gracethreshold )
            {
                continue;
            }
            
            assister function_1fe136002a482625();
            assisterid = assister player::getuniqueid();
            var_83bb13ef0ab38a4 = function_5ff6db4ef53d460f( attacker, victim ) ? level.gametypebundle.var_47866f7d4fbfc6a8 : 1;
            level.bountytracker[ assisterid ].score += level.gametypebundle.assistmod * var_83bb13ef0ab38a4;
            printscoreinfo( "Assit Amount", score, assister.name );
        }
    }
    
    if ( victim function_89d828b1900e604f() )
    {
        score *= level.gametypebundle.var_4d870806eb8a0048;
        printscoreinfo( "Killed Bountied Player", score, assister.name );
    }
    
    attackerkills = attacker.pers[ "kills" ] ?? 0;
    attackerassists = attacker.pers[ "assists" ] ?? 0;
    
    if ( attackerkills + attackerassists <= level.gametypebundle.gracethreshold )
    {
        score *= level.gametypebundle.gracemod;
        printscoreinfo( "First Kills(s) Grace", score );
    }
    else if ( attackerkills >= level.gametypebundle.var_b7b3bc5f31ad2b1f )
    {
        deltakills = attackerkills - level.gametypebundle.var_b7b3bc5f31ad2b1f;
        var_7043d7d37421c08d = pow( level.gametypebundle.var_67b12dbec08d22e9, deltakills + 1 );
        score *= var_7043d7d37421c08d;
        printscoreinfo( "Player Killer", score );
    }
    
    score *= function_8c91a5c93c814b78( attackerid, victimid );
    score = clamp( score, level.gametypebundle.var_caf937cc521e1175, level.gametypebundle.var_1bdb6af6956b155b );
    printscoreinfo( "Final Score", score, undefined, 1 );
    printscoreinfo( "-------End Bounty Score Calc-------" );
    return score;
}

// Namespace bounty_wanted
// Params 1
// Checksum 0x46953917, Offset: 0x1c7e
// Size: 0x45
function function_a1ef9a434ccc5c92( amount = 1 )
{
    if ( !amount )
    {
        return;
    }
    
    if ( !isdefined( self.bountyScore ) )
    {
        self.bountyScore = 0;
    }
    
    function_79183cad3c7b34e5( self.bountyScore + amount );
}

// Namespace bounty_wanted
// Params 3
// Checksum 0xba623a, Offset: 0x1ccb
// Size: 0x29
function function_79183cad3c7b34e5( amount, initialgrant, var_4f9c03c70d72ef3d )
{
    thread function_4c9f55e81d8f9089( amount, initialgrant, var_4f9c03c70d72ef3d );
}

// Namespace bounty_wanted
// Params 3, eflags: 0xc
// Checksum 0xe5007512, Offset: 0x1cfc
// Size: 0x5ed
function private function_4c9f55e81d8f9089( amount, initialgrant, var_4f9c03c70d72ef3d )
{
    self notify( #"hash_9778ea8fe07f8dbd" );
    self endon( #"hash_9778ea8fe07f8dbd" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    var_21e0a721a347249e = function_89d828b1900e604f();
    
    if ( !isdefined( self.bountyScore ) )
    {
        self.bountyScore = 0;
    }
    
    if ( self.bountyScore == 0 && amount > 0 && !initialgrant && !self.var_64e9479f8b19e238 )
    {
        currentval = self getclientomnvar( "ui_bounty_warning" ) ?? 0;
        self setclientomnvar( "ui_bounty_warning", !currentval );
        self.var_64e9479f8b19e238 = 1;
    }
    
    self.var_c140cb3b186d3ae2 = self.bountyScore;
    self.bountyScore = int( min( amount, function_d0b1a3c96420e173() ) );
    self.bountyScore = int( max( 0, self.bountyScore ) );
    
    if ( self.bountyScore > 0 )
    {
        if ( !isdefined( self.challengedata ) )
        {
            self.challengedata = {};
        }
        
        self.challengedata.bountyScore = self.bountyScore;
    }
    
    bountyincreased = self.var_c140cb3b186d3ae2 < self.bountyScore;
    var_f96d0c8578e5928a = function_89d828b1900e604f();
    previousbounty = bounty_system::function_70fe163f776a8115( self, #"wanted" );
    bountylevel = function_d195521681c24821();
    
    if ( previousbounty.var_2a19051b41ad2364 == bountylevel.index )
    {
        return;
    }
    
    if ( initialgrant )
    {
        flags::gameflagwait( "prematch_done" );
        wait getdvarint( @"hash_14b479e78874c4b6", 10 );
    }
    
    bountysettings = undefined;
    
    if ( var_f96d0c8578e5928a && bountylevel.bountysetting )
    {
        bountysettings = getscriptbundle( bountylevel.bountysetting );
        bountysettings.var_acdfc050d749c999 = &function_acdfc050d749c999;
        bountysettings.var_907aee8d17e080fa = &function_7edbf2c9a0d3d243;
        bountysettings.bountyincreased = bountyincreased;
        bountysettings.var_af4505e4e9f04c8c = &function_a0df4483f5217269;
        
        if ( previousbounty )
        {
            bountysettings.var_caa1a976f734761 = previousbounty.ref;
            bountysettings.cooldowns = previousbounty.cooldowns;
        }
        
        bountysettings = bounty_system::function_b1bcf39be8337e41( self, bountysettings, #"wanted" );
        bountysettings.var_2a19051b41ad2364 = bountylevel.index;
    }
    
    if ( var_21e0a721a347249e && previousbounty && !var_4f9c03c70d72ef3d )
    {
        bounty_system::endbounty( previousbounty, undefined, 4 );
    }
    
    if ( !isdefined( level.var_aab704f6214a3c02 ) )
    {
        level.var_aab704f6214a3c02 = [];
    }
    
    if ( function_89d828b1900e604f() && !arraycontains( level.var_aab704f6214a3c02, self ) )
    {
        level.var_aab704f6214a3c02[ level.var_aab704f6214a3c02.size ] = self;
    }
    else if ( !function_89d828b1900e604f() && level.var_aab704f6214a3c02.size && arraycontains( level.var_aab704f6214a3c02, self ) )
    {
        level.var_aab704f6214a3c02 = arrayremove( level.var_aab704f6214a3c02, self );
    }
    
    level thread function_d04969c39cc02bf0();
    teamsupdated = [];
    function_a39d8de25297239c();
    teamsupdated[ self.team ] = 1;
    
    if ( !function_3136839752daef5b() && self.var_54c6ae1a91ff219a )
    {
        foreach ( player in self.var_54c6ae1a91ff219a )
        {
            if ( !teamsupdated[ player.team ] )
            {
                player function_a39d8de25297239c();
                teamsupdated[ player.team ] = 1;
            }
        }
        
        self.var_54c6ae1a91ff219a = undefined;
    }
    
    if ( isplayer( self ) )
    {
        index = ( function_d6112fe3de4a7987() ?? -1 ) + 1;
        skinref = operator::function_cc5d60d5178c5007();
        skinlootid = loot::getlootidfromref( skinref ) ?? 0;
        entnumber = self getentitynumber();
        function_9134eb92130b9544( "ui_bounty_", entnumber, index, skinlootid );
    }
    
    teammates = teams::getteamdata( self.team, "players" );
    
    foreach ( teammate in teammates )
    {
        teammate setclientomnvar( "ui_bounty_score_squad_" + self.sessionuimemberindex, index );
    }
    
    if ( bountysettings && bountylevel.var_2d4316c178be0a13 )
    {
        foreach ( player in level.players )
        {
            if ( player.team == self.team )
            {
                continue;
            }
            
            bounty_system::function_4866d7d3a14bf634( bountysettings, [ player ] );
        }
    }
}

// Namespace bounty_wanted
// Params 4
// Checksum 0x8786e424, Offset: 0x22f1
// Size: 0xa5
function function_9134eb92130b9544( omnvarprefix, playerentnum, score, operatorid )
{
    var_35db1776d0d6f8c4 = omnvarprefix + "operator_id";
    var_4cc9231416d702a5 = omnvarprefix + "packed_data";
    
    if ( !isplayer( self ) || !hasomnvar( var_35db1776d0d6f8c4 ) || !hasomnvar( var_4cc9231416d702a5 ) )
    {
        return;
    }
    
    if ( isdefined( operatorid ) )
    {
        self setclientomnvar( var_35db1776d0d6f8c4, operatorid );
    }
    
    if ( isdefined( playerentnum ) )
    {
        omnvar_utility::function_85d5f88af471ac4b( var_4cc9231416d702a5, 0, 8, playerentnum );
    }
    
    if ( isdefined( score ) )
    {
        omnvar_utility::function_85d5f88af471ac4b( var_4cc9231416d702a5, 8, 6, score );
    }
}

// Namespace bounty_wanted
// Params 0, eflags: 0xc
// Checksum 0x112aeb67, Offset: 0x239e
// Size: 0x172
function private function_d04969c39cc02bf0()
{
    self notify( #"hash_7bcb4d963e4bb87f" );
    self endon( #"hash_7bcb4d963e4bb87f" );
    level endon( #"game_ended" );
    
    if ( !hasomnvar( "ui_bounty_station_updated" ) )
    {
        return;
    }
    
    setomnvar( "ui_bounty_station_updated", 0 );
    
    if ( !isdefined( level.var_aab704f6214a3c02 ) )
    {
        level.var_aab704f6214a3c02 = [];
    }
    
    level.var_aab704f6214a3c02 = arraysort( level.var_aab704f6214a3c02, undefined, &function_d83c16931436aea1 );
    
    for ( i = 0; i < 5 ; i++ )
    {
        if ( !hasomnvar( "ui_bounty_player_" + i ) )
        {
            continue;
        }
        
        entnum = -1;
        bountyScore = 0;
        skinlootid = 0;
        
        if ( level.var_aab704f6214a3c02[ i ] && isplayer( level.var_aab704f6214a3c02[ i ] ) )
        {
            entnum = level.var_aab704f6214a3c02[ i ] getentitynumber();
            bountyScore = level.var_aab704f6214a3c02[ i ].bountyScore;
            skinref = level.var_aab704f6214a3c02[ i ] operator::function_cc5d60d5178c5007();
            skinlootid = loot::getlootidfromref( skinref ) ?? 0;
        }
        
        setomnvar( "ui_bounty_player_" + i, entnum );
        setomnvar( "ui_bounty_player_score_" + i, bountyScore );
        setomnvar( "ui_bounty_player_operator_id_" + i, skinlootid );
    }
    
    waitframe();
    setomnvar( "ui_bounty_station_updated", 1 );
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0x16479e96, Offset: 0x2518
// Size: 0xfa
function private function_a39d8de25297239c()
{
    for ( i = 0; i < 5 ; i++ )
    {
        teammates = teams::getteamdata( self.team, "players" );
        hasintel = 0;
        
        if ( level.var_aab704f6214a3c02[ i ].var_54c6ae1a91ff219a && arraycontains( level.var_aab704f6214a3c02[ i ].var_54c6ae1a91ff219a, self ) )
        {
            hasintel = 1;
        }
        
        foreach ( player in teammates )
        {
            player setclientomnvar( "ui_bounty_player_intel_gathered_" + i, hasintel );
        }
    }
}

// Namespace bounty_wanted
// Params 2, eflags: 0x4
// Checksum 0x35181202, Offset: 0x261a
// Size: 0x54, Type: bool
function private function_d83c16931436aea1( a, b )
{
    if ( a.bountyScore == b.bountyScore )
    {
        return ( a getentitynumber() < b getentitynumber() );
    }
    
    return a.bountyScore > b.bountyScore;
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0x10489e55, Offset: 0x2677
// Size: 0x83
function private function_d0b1a3c96420e173()
{
    bountymax = level.bountymax ?? 9999;
    
    if ( level.gametypebundle.bountylevels && !isdefined( level.bountymax ) )
    {
        level.bountymax = level.gametypebundle.bountylevels.size * function_1f6e45bb5a3735b5() + function_47373684d07319dc();
    }
    
    /#
        bountymax = getdvarint( @"hash_7b8bd7f68553e735", bountymax );
    #/
    
    return bountymax;
}

// Namespace bounty_wanted
// Params 0
// Checksum 0x5f72c7e6, Offset: 0x2703
// Size: 0x3d
function function_5be62851fc527894()
{
    wantedthreshold = level.wantedthreshold * ( function_1f6e45bb5a3735b5() ?? 1 ) + function_47373684d07319dc();
    wantedthreshold = getdvarint( @"scr_wanted_threshold", wantedthreshold );
    return wantedthreshold;
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0x76034552, Offset: 0x2749
// Size: 0x39
function private function_47373684d07319dc()
{
    bountythreshold = level.gametypebundle.bountythreshold ?? 2;
    bountythreshold = getdvarint( @"scr_bounty_threshold", bountythreshold );
    return bountythreshold;
}

// Namespace bounty_wanted
// Params 0
// Checksum 0x857d36ac, Offset: 0x278b
// Size: 0x39
function function_1f6e45bb5a3735b5()
{
    var_50137072cbdcbc36 = level.gametypebundle.var_78c64d0ae1f3148d ?? 4;
    var_50137072cbdcbc36 = getdvarint( @"scr_bounty_increase_amount", var_50137072cbdcbc36 );
    return var_50137072cbdcbc36;
}

// Namespace bounty_wanted
// Params 0
// Checksum 0xb85168bc, Offset: 0x27cd
// Size: 0xf, Type: bool
function function_fc000e7d3c544a81()
{
    return self.bountyScore ?? 0;
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xfcae2bf9, Offset: 0x27e5
// Size: 0x56
function private function_cb7f509b7ad8f64b( index )
{
    bountylevel = function_dbe25d90b28a456f( index );
    
    if ( !bountylevel )
    {
        return 0;
    }
    
    bountythreshold = function_47373684d07319dc();
    return index * ( level.gametypebundle.var_78c64d0ae1f3148d ?? 1 ) + bountythreshold;
}

// Namespace bounty_wanted
// Params 1
// Checksum 0xeb2f9702, Offset: 0x2844
// Size: 0x80
function function_90db6f6e5ee89a2e( instanceinventory )
{
    score = undefined;
    
    if ( instanceinventory )
    {
        score = self.var_9aec6b5641d085f5 ?? function_fc000e7d3c544a81();
    }
    
    bountylevel = function_d195521681c24821( score );
    
    if ( !isdefined( bountylevel.index ) )
    {
        return 0;
    }
    
    bountythreshold = function_47373684d07319dc();
    return bountylevel.index * ( function_1f6e45bb5a3735b5() ?? 1 ) + bountythreshold;
}

// Namespace bounty_wanted
// Params 1
// Checksum 0x97a0cf0b, Offset: 0x28cd
// Size: 0x79
function function_90c77fff71f390d7( score )
{
    bountylevel = function_d195521681c24821( score );
    
    if ( !bountylevel )
    {
        return 0;
    }
    
    cashmod = bountylevel.cashtax ? 1 - bountylevel.cashtax : 1;
    cashvalue = bountylevel.cashvalue * cashmod;
    cashvalue = modified_values::function_14d05d73e63e1f9e( 1, cashvalue );
    return cashvalue;
}

// Namespace bounty_wanted
// Params 0
// Checksum 0x51df2ccd, Offset: 0x294f
// Size: 0x1f, Type: bool
function function_3136839752daef5b()
{
    if ( !isdefined( level.wantedthreshold ) )
    {
        return false;
    }
    
    return function_fc000e7d3c544a81() >= function_5be62851fc527894();
}

// Namespace bounty_wanted
// Params 3
// Checksum 0x69a86386, Offset: 0x2977
// Size: 0x133
function function_ca1c5d365276da54( attacker, victim, multiplier )
{
    if ( !isenabled() )
    {
        return;
    }
    
    attackerid = attacker player::getuniqueid();
    victimid = victim player::getuniqueid();
    attacker function_1fe136002a482625( attackerid );
    
    if ( !isdefined( level.bountytracker[ attackerid ].victims[ victimid ] ) )
    {
        level.bountytracker[ attackerid ].victims[ victimid ] = {};
    }
    
    if ( isdefined( level.bountytracker[ attackerid ].victims[ victimid ].multiplier ) )
    {
        level.bountytracker[ attackerid ].victims[ victimid ].multiplier = max( multiplier, level.bountytracker[ attackerid ].victims[ victimid ].multiplier );
    }
    else
    {
        level.bountytracker[ attackerid ].victims[ victimid ].multiplier = multiplier;
    }
    
    thread function_190b823ae7c6527f( attacker, victim, attackerid, victimid );
}

// Namespace bounty_wanted
// Params 4, eflags: 0x4
// Checksum 0x146f4065, Offset: 0x2ab2
// Size: 0xbc
function private function_190b823ae7c6527f( attacker, victim, attackerid, victimid )
{
    level endon( #"game_ended" );
    attacker endon( #"disconnect" );
    victim utility::waittill_any_timeout_no_endon_death( level.gametypebundle.var_2b20d5b8f043c01e ?? 300, "disconnect", "clear_multiplier_" + attackerid );
    
    if ( level.bountytracker[ attackerid ] && level.bountytracker[ attackerid ].victims[ victimid ] )
    {
        level.bountytracker[ attackerid ].victims[ victimid ].multiplier = undefined;
    }
}

// Namespace bounty_wanted
// Params 2, eflags: 0x4
// Checksum 0x3989f8b9, Offset: 0x2b76
// Size: 0x6c, Type: bool
function private function_8c91a5c93c814b78( attackerid, victimid )
{
    if ( !level.bountytracker[ attackerid ] || !level.bountytracker[ attackerid ].victims[ victimid ] )
    {
        return true;
    }
    
    return level.bountytracker[ attackerid ].victims[ victimid ].multiplier ?? 1;
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0x2d2658fc, Offset: 0x2beb
// Size: 0xf, Type: bool
function private function_89d828b1900e604f()
{
    return function_fc000e7d3c544a81() >= function_47373684d07319dc();
}

// Namespace bounty_wanted
// Params 1
// Checksum 0x4f309cce, Offset: 0x2c03
// Size: 0x3f
function function_d6112fe3de4a7987( score = function_fc000e7d3c544a81() )
{
    bountylevel = function_d195521681c24821( score );
    
    if ( !bountylevel )
    {
        return;
    }
    
    return bountylevel.index;
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xedeb2c73, Offset: 0x2c4b
// Size: 0x10b
function private function_d195521681c24821( score )
{
    if ( !level.gametypebundle.bountylevels )
    {
        return;
    }
    
    if ( !isdefined( score ) )
    {
        score = function_fc000e7d3c544a81();
    }
    
    bountythreshold = function_47373684d07319dc();
    
    if ( score < bountythreshold )
    {
        return;
    }
    
    foreach ( index, bountylevel in level.gametypebundle.bountylevels )
    {
        if ( index + 1 == level.gametypebundle.bountylevels.size || score < ( index + 1 ) * ( function_1f6e45bb5a3735b5() ?? 1 ) + bountythreshold )
        {
            bountylevel.index = index;
            return bountylevel;
        }
    }
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xa9b1e457, Offset: 0x2d5f
// Size: 0x2a
function private function_dbe25d90b28a456f( index )
{
    if ( index < 0 )
    {
        return;
    }
    
    return level.gametypebundle.bountylevels[ index ];
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0xf250ae23, Offset: 0x2d92
// Size: 0x26
function private function_d68fede748f43c48()
{
    bountylevel = function_d195521681c24821();
    
    if ( !bountylevel )
    {
        return;
    }
    
    return bountylevel.var_8d2295fd7343b249;
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0xbb0cf703, Offset: 0x2dc1
// Size: 0xe4
function private function_fc601cafe81069f()
{
    var_8db907f3c487983a = function_d195521681c24821();
    
    if ( !var_8db907f3c487983a )
    {
        return 0;
    }
    
    total = 0;
    
    foreach ( index, bountylevel in level.gametypebundle.bountylevels )
    {
        total += ( bountylevel.cashvalue ?? 0 ) * bountylevel.var_f65b2954fd4718e2 / 100;
        
        if ( index == var_8db907f3c487983a.index )
        {
            return function_cb126e0f63c8a75b( total );
        }
    }
    
    return function_cb126e0f63c8a75b( total );
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0xcae762b4, Offset: 0x2eae
// Size: 0x57
function private function_d9f6943ff09b789b()
{
    if ( getdvarint( @"hash_640181ed61ade8d", 0 ) )
    {
        return 0;
    }
    
    bountylevel = function_d195521681c24821();
    
    if ( !bountylevel )
    {
        return 0;
    }
    
    return function_cb126e0f63c8a75b( ( bountylevel.cashvalue ?? 0 ) * ( bountylevel.var_726b1e436341f2b5 ?? 0 ) / 100 );
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xaba4c07f, Offset: 0x2f0e
// Size: 0x3f
function private function_7c022d326fe4244( bountylevel )
{
    if ( getdvarint( @"hash_640181ed61ade8d", 0 ) )
    {
        return 0;
    }
    
    return function_cb126e0f63c8a75b( bountylevel.cashvalue * bountylevel.var_f65b2954fd4718e2 / 100 );
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0x1791501d, Offset: 0x2f56
// Size: 0x2f
function private function_cb126e0f63c8a75b( cost )
{
    return int( floor( cost / ( level.gametypebundle.var_a428f72f50986a04 ?? 10 ) ) );
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0x4239f6bf, Offset: 0x2f8e
// Size: 0x13
function private onplayerspawned( params )
{
    thread whizbythink();
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0xe7dac54f, Offset: 0x2fa9
// Size: 0x25c
function private whizbythink()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"bulletwhizby", attacker, distance, position, forward );
        
        if ( !attacker.team || attacker.team == self.team )
        {
            continue;
        }
        
        if ( !isdefined( level.var_4952bcfdbd4a5748[ self.team ] ) )
        {
            level.var_4952bcfdbd4a5748[ self.team ] = [];
        }
        
        currenttime = gettime();
        
        if ( !isdefined( level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ] ) )
        {
            level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ] = spawnstruct();
            level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ].var_a971f94b95305335 = currenttime;
            level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ].var_a6d845b00cfc57d9 = currenttime;
            continue;
        }
        
        if ( isdefined( level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ].var_a6d845b00cfc57d9 ) && level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ].var_a6d845b00cfc57d9 + level.gametypebundle.var_5dd8441585b5867d * 1000 < currenttime )
        {
            level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ].var_a971f94b95305335 = currenttime;
            level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ].var_a6d845b00cfc57d9 = currenttime;
            continue;
        }
        
        level.var_4952bcfdbd4a5748[ self.team ][ attacker.team ].var_a6d845b00cfc57d9 = currenttime;
    }
}

// Namespace bounty_wanted
// Params 2, eflags: 0x4
// Checksum 0x2031e006, Offset: 0x320d
// Size: 0x115, Type: bool
function private function_5ff6db4ef53d460f( attacker, victim )
{
    if ( !attacker || !victim )
    {
        return false;
    }
    
    if ( !level.var_4952bcfdbd4a5748[ attacker.team ] || !level.var_4952bcfdbd4a5748[ attacker.team ][ victim.team ] )
    {
        return false;
    }
    
    attackertime = level.var_4952bcfdbd4a5748[ attacker.team ][ victim.team ].var_a971f94b95305335;
    victimtime = 0;
    
    if ( level.var_4952bcfdbd4a5748[ victim.team ] && level.var_4952bcfdbd4a5748[ victim.team ][ attacker.team ] )
    {
        victimtime = level.var_4952bcfdbd4a5748[ victim.team ][ attacker.team ].var_a971f94b95305335;
    }
    
    return attackertime <= victimtime;
}

// Namespace bounty_wanted
// Params 6, eflags: 0x4
// Checksum 0xd6fc0c0d, Offset: 0x332b
// Size: 0x50
function private function_f75d0acadc9e3015( instance, part, state, player, bautouse, usestring )
{
    player function_a39d8de25297239c();
    player setclientomnvar( "ui_bounty_station_open", 1 );
}

// Namespace bounty_wanted
// Params 0, eflags: 0x4
// Checksum 0x681e350e, Offset: 0x3383
// Size: 0xe
function private function_147919600101fc37()
{
    self setclientomnvar( "ui_bounty_station_open", 0 );
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0xbe458eb6, Offset: 0x3399
// Size: 0x24d
function private function_4b2a94d759af8ca3( entnum )
{
    if ( !level.var_aab704f6214a3c02 || !isdefined( entnum ) )
    {
        return 0;
    }
    
    wantedplayer = undefined;
    
    foreach ( player in level.var_aab704f6214a3c02 )
    {
        if ( player.team != self.team && player getentitynumber() == entnum )
        {
            wantedplayer = player;
            break;
        }
    }
    
    if ( !wantedplayer )
    {
        return 0;
    }
    
    if ( wantedplayer.var_54c6ae1a91ff219a && arraycontains( wantedplayer.var_54c6ae1a91ff219a, self ) )
    {
        return 0;
    }
    
    var_7ae260b14d9bedcc = common_instance_inventory::function_d9382cb4b4fd3cfe();
    intelcost = wantedplayer function_d9f6943ff09b789b();
    intelcost = max( 0, int( modified_values::function_14d05d73e63e1f9e( 14, intelcost ) ) );
    
    if ( var_7ae260b14d9bedcc < intelcost )
    {
        return 0;
    }
    
    common_instance_inventory::function_c74fbad95ae19935( self, intelcost * -1 );
    teammates = teams::getteamdata( self.team, "players" );
    
    foreach ( teammate in teammates )
    {
        if ( !isdefined( wantedplayer.var_54c6ae1a91ff219a ) )
        {
            wantedplayer.var_54c6ae1a91ff219a = [];
        }
        
        wantedplayer.var_54c6ae1a91ff219a = arraycombineunique( wantedplayer.var_54c6ae1a91ff219a, [ teammate ] );
    }
    
    bountysettings = bounty_system::function_70fe163f776a8115( wantedplayer, #"wanted" );
    bountysettings.var_8d2295fd7343b249 = wantedplayer function_d68fede748f43c48();
    bounty_system::function_4866d7d3a14bf634( bountysettings, teammates );
    function_a39d8de25297239c();
    level thread function_d04969c39cc02bf0();
}

// Namespace bounty_wanted
// Params 1, eflags: 0x4
// Checksum 0x24c7694f, Offset: 0x35ee
// Size: 0x112
function private function_c8af155691a7f5de( payall )
{
    var_7ae260b14d9bedcc = common_instance_inventory::function_d9382cb4b4fd3cfe();
    
    if ( payall )
    {
        totalvalue = function_fc601cafe81069f();
        
        if ( var_7ae260b14d9bedcc < totalvalue )
        {
            return 0;
        }
        
        common_instance_inventory::function_c74fbad95ae19935( self, totalvalue * -1 );
        function_79183cad3c7b34e5( 0 );
        return 1;
    }
    
    bountylevel = function_d195521681c24821();
    
    if ( !bountylevel.var_f65b2954fd4718e2 || !bountylevel.cashvalue )
    {
        return 0;
    }
    
    subamount = function_7c022d326fe4244( bountylevel );
    
    if ( var_7ae260b14d9bedcc < subamount )
    {
        return 0;
    }
    
    common_instance_inventory::function_c74fbad95ae19935( self, subamount * -1 );
    newscore = function_cb7f509b7ad8f64b( bountylevel.index - 1 );
    function_79183cad3c7b34e5( newscore );
    
    if ( newscore == 0 )
    {
        currentval = self getclientomnvar( "ui_bounty_cleared" ) ?? 0;
        self setclientomnvar( "ui_bounty_cleared", !currentval );
    }
    
    if ( !function_89d828b1900e604f() )
    {
        function_a39d8de25297239c();
    }
}

// Namespace bounty_wanted
// Params 2, eflags: 0x4
// Checksum 0x2597d907, Offset: 0x3708
// Size: 0x75
function private function_11028afbe0567976( notification, val )
{
    switch ( notification )
    {
        case #"hash_2fdc9657eba0b256":
            function_147919600101fc37();
            break;
        case #"hash_b0116daccda6ab1d":
            function_4b2a94d759af8ca3( val );
            break;
        case #"hash_6f39fae31fd31693":
            function_c8af155691a7f5de( istrue( val ) );
            break;
        default:
            break;
    }
}

// Namespace bounty_wanted
// Params 4, eflags: 0x4
// Checksum 0xc09a517f, Offset: 0x3785
// Size: 0xa2
function private printscoreinfo( scoretype, score, extramsg, finalscore )
{
    /#
        if ( getdvarint( @"hash_1c0b8fef4835b5f5", 0 ) )
        {
            println( ( scoretype ?? "<dev string:x24>" ) + "<dev string:x25>" + ( score ?? "<dev string:x24>" ) + "<dev string:x28>" + ( extramsg ?? "<dev string:x24>" ) );
        }
        
        if ( finalscore )
        {
            iprintlnbold( ( scoretype ?? "<dev string:x24>" ) + "<dev string:x25>" + ( score ?? "<dev string:x24>" ) + "<dev string:x28>" + ( extramsg ?? "<dev string:x24>" ) );
        }
    #/
}

/#

    // Namespace bounty_wanted
    // Params 2, eflags: 0x4
    // Checksum 0x3435227a, Offset: 0x382f
    // Size: 0x42a, Type: dev
    function private function_f92b61cf0f15a321( command, args )
    {
        bountyScore = isdefined( args[ 0 ] ) ? int( args[ 0 ] ) : 0;
        botsonly = isdefined( args[ 1 ] ) && int( args[ 1 ] ) == 1;
        hostonly = isdefined( args[ 1 ] ) && int( args[ 1 ] ) == 2;
        enemiesonly = isdefined( args[ 2 ] ) && int( args[ 1 ] ) == 1;
        players = [];
        
        foreach ( player in level.players )
        {
            if ( botsonly && !isbot( player ) || hostonly && isbot( player ) || enemiesonly && player.team == level.players[ 0 ].team )
            {
                continue;
            }
            
            players[ players.size ] = player;
        }
        
        switch ( command )
        {
            case #"hash_4aed6de02998e7c7":
                foreach ( player in players )
                {
                    player function_79183cad3c7b34e5( bountyScore );
                }
                
                iprintlnbold( "<dev string:x36>" + bountyScore );
                break;
            case #"hash_66875ce2e128f060":
                foreach ( player in players )
                {
                    player function_a1ef9a434ccc5c92( bountyScore );
                }
                
                iprintlnbold( "<dev string:x57>" + bountyScore );
                break;
            case #"hash_c4cb930aafd85f3e":
                foreach ( player in level.players )
                {
                    if ( !isbot( player ) )
                    {
                        player function_a39d8de25297239c();
                        player setclientomnvar( "<dev string:x7c>", 1 );
                    }
                }
                
                break;
            case #"hash_d22f0d3e740f8038":
                foreach ( player in level.players )
                {
                    if ( !isbot( player ) )
                    {
                        player setclientomnvar( "<dev string:x7c>", 0 );
                    }
                }
                
                break;
            case #"hash_8e2314ddd8b1b9d4":
                foreach ( player in players )
                {
                    bountyScore = randomint( function_d0b1a3c96420e173() + 1 );
                    player function_79183cad3c7b34e5( bountyScore );
                }
                
                break;
            default:
                break;
        }
    }

#/
