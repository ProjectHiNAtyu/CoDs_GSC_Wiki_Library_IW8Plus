// scripts\mp\common\utility\game.gsc  (hash_353e34c229ca1589.gscc) (size: 38624 Bytes / 0x96e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x27f8d4d9 (670618841)
// size ...... 38624 (0x96e0)
// includes .. 20  (offset: 0x8d10)
// strings ... 129 (offset: 0x8db0)
// dev strs .. 5   (offset: 0x96a4)
// exports ... 182 (offset: 0x5b60)
// cseg ...... 0xb15 + 0x504b (0x5b60)
// imports ... 159 (offset: 0x77d0)
// animtree1 . 0   (offset: 0x96e0)
// animtree2 . 0   (offset: 0x96e0)
#using scripts\common\utility;
#using scripts\mp\ammorestock;
#using scripts\mp\class;
#using scripts\mp\codcaster_utils;
#using scripts\mp\common\gameobjects\gameobjects_common;
#using scripts\mp\common\gameobjects\gameobjects_shared;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emp_debuff;
#using scripts\mp\flags;
#using scripts\mp\gameinstance;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\matchdata;
#using scripts\mp\playerlogic;
#using scripts\mp\serversettings;

#namespace game_utility_mp;

// Namespace game_utility_mp
// Params 0
// Checksum 0x5c6f4f2d, Offset: 0xb33
// Size: 0x20
function getroundlength()
{
    if ( !isdefined( level.starttime ) )
    {
        return 0;
    }
    
    return gettime() - level.starttime;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x846a3281, Offset: 0xb5c
// Size: 0x1e
function getgamelength()
{
    if ( !isdefined( game[ "gameLength" ] ) )
    {
        return 0;
    }
    
    return getroundlength() + game[ "gameLength" ];
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xa4e66bd1, Offset: 0xb83
// Size: 0x31
function gettimepassedpercentage()
{
    timelimit = gettimelimit();
    
    if ( timelimit == 0 )
    {
        return 0;
    }
    
    return game_utility::gettimepassed() / gettimelimit() * 1000 * 100;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x6b2139fa, Offset: 0xbbd
// Size: 0xc
function getsecondspassed()
{
    return game_utility::gettimepassed() / 1000;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xdf7692e0, Offset: 0xbd2
// Size: 0xb
function getminutespassed()
{
    return getsecondspassed() / 60;
}

// Namespace game_utility_mp
// Params 3
// Checksum 0xbc86e5ab, Offset: 0xbe6
// Size: 0xcc
function setuipostgamefade( fadetoblack, delay, fademovie )
{
    self endon( #"disconnect" );
    
    if ( level.nukeinfo.detonated )
    {
        return;
    }
    
    if ( level.var_9ea2f011b00a0134 )
    {
        return;
    }
    
    if ( !fadetoblack && !self.var_cebaea3f53226bfc )
    {
        return;
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( isdefined( fademovie ) && fadetoblack )
    {
        self function_73788e9f76af4fad( fademovie );
        setdvar( @"bg_cinematicfullscreen", "0" );
    }
    
    self.var_cebaea3f53226bfc = fadetoblack;
    game_utility::fadetoblackforplayer( self, fadetoblack, 0.5 );
    
    if ( !fadetoblack )
    {
        self stopcinematicforplayer();
        setdvar( @"bg_cinematicfullscreen", "1" );
    }
}

// Namespace game_utility_mp
// Params 4
// Checksum 0xdf4feb65, Offset: 0xcba
// Size: 0xb3
function registerroundswitchdvar( dvarstring, defaultvalue, minvalue, maxvalue )
{
    dvars::registerwatchdvarint( "roundswitch", defaultvalue );
    dvarstring = hashcat( @"scr_", dvarstring, "_roundswitch" );
    level.roundswitchdvar = dvarstring;
    level.roundswitchmin = minvalue;
    level.roundswitchmax = maxvalue;
    level.roundswitch = getdvarint( dvarstring, defaultvalue );
    
    if ( level.roundswitch < minvalue )
    {
        level.roundswitch = minvalue;
        return;
    }
    
    if ( level.roundswitch > maxvalue )
    {
        level.roundswitch = maxvalue;
    }
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x41b2471a, Offset: 0xd75
// Size: 0x23
function registerroundlimitdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "roundlimit", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x6aacc7a3, Offset: 0xda0
// Size: 0x23
function registernumteamsdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "numTeams", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x77ebb7bd, Offset: 0xdcb
// Size: 0x23
function registerwinlimitdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "winlimit", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xcb3cc159, Offset: 0xdf6
// Size: 0x23
function registerwinbytwoenableddvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "winbytwoenabled", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xbe17be7f, Offset: 0xe21
// Size: 0x23
function registerwinbytwomaxroundsdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "winbytwomaxrounds", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x890e49af, Offset: 0xe4c
// Size: 0x23
function registerdogtagsenableddvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "dogtags", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x64a9b7ee, Offset: 0xe77
// Size: 0x23
function registerscorelimitdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "scorelimit", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xdaeda805, Offset: 0xea2
// Size: 0x37
function registertimelimitdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarfloat( "timelimit", defaultvalue );
    setdvar( @"ui_timelimit", gettimelimit() );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xc0d29786, Offset: 0xee1
// Size: 0x37
function registerhalftimedvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "halftime", defaultvalue );
    setdvar( @"ui_halftime", gethalftime() );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x6e0661aa, Offset: 0xf20
// Size: 0x23
function registernumlivesdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "numlives", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x97dd2246, Offset: 0xf4b
// Size: 0x23
function registernumrevivesdvar( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "numrevives", defaultvalue );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x198e115e, Offset: 0xf76
// Size: 0x23
function function_d582c4f1d2f80ada( dvarstring, defaultvalue )
{
    dvars::registerwatchdvarint( "pointsPerKill", defaultvalue );
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xdab5ae9a, Offset: 0xfa1
// Size: 0x1c
function setovertimelimitdvar( value )
{
    setdvar( @"overtimetimelimit", value );
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x3b03a5f5, Offset: 0xfc5
// Size: 0x1a
function registerlaststandtimerdvar( defaultvalue )
{
    dvars::registerwatchdvarfloat( "lastStandTimer", defaultvalue );
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xd7772d1e, Offset: 0xfe7
// Size: 0x1a
function registerlaststandweapondelaydvar( defaultvalue )
{
    dvars::registerwatchdvarfloat( "lastStandWeaponDelay", defaultvalue );
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x71e0883, Offset: 0x1009
// Size: 0x1a
function registerlaststandsuicidetimerdvar( defaultvalue )
{
    dvars::registerwatchdvarfloat( "lastStandSuicideTimer", defaultvalue );
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x9a85b4a8, Offset: 0x102b
// Size: 0x14
function getotherteam( team )
{
    return team_utility::getenemyteams( team );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x64aad4c1, Offset: 0x1048
// Size: 0x38, Type: bool
function isroundbased()
{
    if ( level.winlimit != 1 && level.roundlimit != 1 )
    {
        return true;
    }
    
    return istrue( level.gametypebundle.roundbased );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc3fade24, Offset: 0x1089
// Size: 0x12, Type: bool
function isfirstround()
{
    if ( game[ "roundsPlayed" ] == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x9a026b09, Offset: 0x10a4
// Size: 0x1b7
function nextroundisfinalround()
{
    if ( level.nextroundisfinalround )
    {
        return [[ level.nextroundisfinalround ]]();
    }
    
    if ( level.forcedend )
    {
        return 1;
    }
    
    if ( level.roundlimit > 1 && game[ "roundsPlayed" ] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype() )
    {
        return 1;
    }
    
    if ( isovertimesupportedgametype() && ( hitroundlimit() || hitwinlimit() ) )
    {
        if ( shouldplaywinbytwo() && islastwinbytwo() )
        {
            return 1;
        }
        else if ( istimetobeatrulegametype() || isscoretobeatrulegametype() )
        {
            if ( game[ "overtimeRoundsPlayed" ] == 1 )
            {
                return 1;
            }
        }
        else if ( !level.playovertime )
        {
            return 1;
        }
    }
    
    var_d667f438fb7c43b7 = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        roundswon = getroundswon( entry );
        
        if ( roundswon == level.winlimit - 1 )
        {
            var_d667f438fb7c43b7 = 1;
            break;
        }
    }
    
    var_5568886b89ac2d3c = level.winlimit > 0 && var_d667f438fb7c43b7;
    
    if ( var_5568886b89ac2d3c && allteamstied() )
    {
        if ( isovertimesupportedgametype() )
        {
            return 0;
        }
        else
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xd1f0d345, Offset: 0x1264
// Size: 0x18a
function nextroundismatchpoint()
{
    if ( level.nextroundismatchpoint )
    {
        return [[ level.nextroundismatchpoint ]]();
    }
    
    if ( level.forcedend )
    {
        return 1;
    }
    
    if ( level.roundlimit > 1 && game[ "roundsPlayed" ] >= level.roundlimit - 1 && !istimetobeatrulegametype() && !isscoretobeatrulegametype() )
    {
        return 1;
    }
    
    if ( isovertimesupportedgametype() && ( hitroundlimit() || hitwinlimit() ) )
    {
        if ( shouldplaywinbytwo() && islastwinbytwo() )
        {
            return 1;
        }
        else if ( istimetobeatrulegametype() || isscoretobeatrulegametype() )
        {
            if ( game[ "overtimeRoundsPlayed" ] == 1 )
            {
                return 1;
            }
        }
        else if ( !level.playovertime )
        {
            return 1;
        }
    }
    
    foreach ( entry in level.teamnamelist )
    {
        roundswon = getroundswon( entry );
        
        if ( roundswon == level.winlimit - 1 )
        {
            if ( shouldplaywinbytwo() && game[ "displayedMatchPoint" ] )
            {
                game[ "displayedMatchPoint" ] = 0;
            }
            
            return 1;
        }
    }
    
    return 0;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x7899be68, Offset: 0x13f7
// Size: 0x4e, Type: bool
function wasonlyround()
{
    if ( level.playovertime )
    {
        return false;
    }
    
    if ( isdefined( level.onlyroundoverride ) )
    {
        return false;
    }
    
    if ( level.roundlimit == 1 )
    {
        return true;
    }
    
    if ( level.winlimit == 1 && hitwinlimit() )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc2db218, Offset: 0x144e
// Size: 0x175, Type: bool
function waslastround()
{
    if ( level.forcedend || level.forfeitend )
    {
        return true;
    }
    
    if ( isdefined( level.nukeinfo ) && level.nukeinfo.gameover )
    {
        return true;
    }
    
    if ( level.ctfnukeended )
    {
        return true;
    }
    
    if ( wasonlyround() )
    {
        return true;
    }
    
    if ( hitroundlimit() || hitwinlimit() )
    {
        return !level.playovertime;
    }
    
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return gameinstance::function_ff882ffea0747336();
    }
    
    if ( level.gametypebundle.scoringstrategy == #"teamhealth" )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( game[ "teamScores" ][ entry ] <= 0 )
            {
                return true;
            }
        }
    }
    
    if ( game_utility::getgametype() == "wm" )
    {
        if ( game[ "roundsPlayed" ] == 2 )
        {
            return true;
        }
    }
    
    if ( level.useScoreLimitAsTotal && hitscorelimit() )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x9cf67de4, Offset: 0x15cc
// Size: 0x10
function iswinbytworulegametype()
{
    return getmatchrulesdata( "commonOption", "winByTwoEnabled" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xb1bc5a68, Offset: 0x15e5
// Size: 0x10
function getmaxwinbytworounds()
{
    return getmatchrulesdata( "commonOption", "winByTwoMaxRounds" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xb4ec16a9, Offset: 0x15fe
// Size: 0x59, Type: bool
function shouldplaywinbytwo()
{
    alliesscore = game[ "roundsWon" ][ "allies" ];
    axisscore = game[ "roundsWon" ][ "axis" ];
    return iswinbytworulegametype() && abs( alliesscore - axisscore ) < 2 && game[ "overtimeRoundsPlayed" ] < getmaxwinbytworounds();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x80b185ce, Offset: 0x1660
// Size: 0x1d, Type: bool
function islastwinbytwo()
{
    return shouldplaywinbytwo() && game[ "overtimeRoundsPlayed" ] == getmaxwinbytworounds() - 1;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x85ddc696, Offset: 0x1686
// Size: 0x3d, Type: bool
function function_1c242e9b72b23687()
{
    alliesscore = game[ "roundsWon" ][ "allies" ];
    axisscore = game[ "roundsWon" ][ "axis" ];
    return abs( alliesscore - axisscore ) < 2;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x4b9e6aeb, Offset: 0x16cc
// Size: 0x47, Type: bool
function istimetobeatrulegametype()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_6ba8ca4fdff59c99":
            if ( level.var_28c129113dbf6ccf )
            {
                return true;
            }
        case #"hash_1a5d186c17c00d3c":
        case #"hash_c749446269c21985":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x8b9cbfd9, Offset: 0x171c
// Size: 0xf, Type: bool
function intimetobeat()
{
    return game[ "status" ] == "recordTTB";
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x9f840805, Offset: 0x1734
// Size: 0xb1, Type: bool
function settimetobeat( team )
{
    if ( !istimetobeatrulegametype() )
    {
        return false;
    }
    
    captime = getsecondspassed();
    score = gamescore::getteamscore( team );
    
    if ( !istimetobeatvalid() || captime < game[ "timeToBeat" ] && score >= game[ "timeToBeatScore" ] )
    {
        if ( game[ "timeToBeatTeam" ] != "none" && game[ "timeToBeatTeam" ] != team )
        {
            game[ "timeToBeatOld" ] = game[ "timeToBeat" ];
        }
        
        game[ "timeToBeat" ] = captime;
        game[ "timeToBeatTeam" ] = team;
        game[ "timeToBeatScore" ] = score;
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x2daa2f95, Offset: 0x17ee
// Size: 0xb, Type: bool
function istimetobeatvalid()
{
    return game[ "timeToBeat" ] != 0;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x9da1c604, Offset: 0x1802
// Size: 0x16, Type: bool
function shouldplaytimetobeatot()
{
    return istimetobeatvalid() && game[ "overtimeRoundsPlayed" ] == 1;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x54bd1851, Offset: 0x1821
// Size: 0x20, Type: bool
function isscoretobeatrulegametype()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_8eb3658fb4985833":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xe066fda2, Offset: 0x184a
// Size: 0x1a8
function setscoretobeat( team, score )
{
    if ( !isscoretobeatrulegametype() )
    {
        return 0;
    }
    
    istied = game[ "timeToBeatTeam" ] != "none" && score == game[ "timeToBeatScore" ];
    
    if ( score >= game[ "timeToBeatScore" ] )
    {
        if ( game[ "timeToBeatTeam" ] != "none" && game[ "timeToBeatTeam" ] != team )
        {
            game[ "timeToBeatScoreOld" ] = game[ "timeToBeatScore" ];
        }
        
        game[ "timeToBeatTeam" ] = team;
        game[ "timeToBeatScore" ] = score;
    }
    
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_friendly_time_to_beat", player.team == game[ "timeToBeatTeam" ] ? game[ "timeToBeatScore" ] : game[ "timeToBeatScoreOld" ] );
        player setclientomnvar( "ui_enemy_time_to_beat", player.team != game[ "timeToBeatTeam" ] ? game[ "timeToBeatScore" ] : game[ "timeToBeatScoreOld" ] );
    }
    
    if ( level.codcasterenabled )
    {
        codcaster_utils::function_c2c643e0ac6e6a6( game[ "timeToBeatTeam" ], game[ "timeToBeat" ], game[ "timeToBeatOld" ] );
    }
    
    if ( istied )
    {
        return "tie";
    }
    
    return game[ "timeToBeatTeam" ];
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x6746c320, Offset: 0x19fa
// Size: 0x16, Type: bool
function shouldplayscoretobeatot()
{
    return isscoretobeatrulegametype() && game[ "overtimeRoundsPlayed" ] == 1;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x73a7ec1a, Offset: 0x1a19
// Size: 0xbb
function isovertimesupportedgametype()
{
    if ( level.gametypebundle.var_564b329400d9c3e9 )
    {
        return 1;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_6ba8ca4fdff59c99":
            if ( level.var_28c129113dbf6ccf )
            {
                return 1;
            }
        case #"hash_1a5d186c17c00d3c":
        case #"hash_1aac086c17fe5ccb":
        case #"hash_68e111ac56792b24":
        case #"hash_8eb3658fb4985833":
        case #"hash_c749446269c21985":
            return 1;
        case #"hash_53825b446469ac4c":
        case #"hash_5ff8e011d5b9d1c8":
        case #"hash_fa0ed2f6bd4f4395":
        case #"hash_fa50b0f6bd82e972":
            return iswinbytworulegametype();
    }
    
    return 0;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x375f3159, Offset: 0x1add
// Size: 0xde
function getmaxovertimeroundsbygametype()
{
    var_77adc7133af48b1a = 0;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_6ba8ca4fdff59c99":
            if ( level.var_28c129113dbf6ccf )
            {
                return level.var_16f41764c4fab65c;
            }
        case #"hash_1a5d186c17c00d3c":
        case #"hash_53825b446469ac4c":
        case #"hash_68e111ac56792b24":
        case #"hash_c749446269c21985":
        case #"hash_fa50b0f6bd82e972":
            var_77adc7133af48b1a = 2;
            break;
        case #"hash_1e4846dca3ccf38":
        case #"hash_1aac086c17fe5ccb":
        case #"hash_b9aaf1c4459d9a15":
        case #"hash_df78ea63c3b5eb8c":
        case #"hash_fa0ed2f6bd4f4395":
            var_77adc7133af48b1a = 1;
            break;
    }
    
    if ( isanymlgmatch() && !istimetobeatrulegametype() )
    {
        return -1;
    }
    
    return var_77adc7133af48b1a;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xddc9c2e8, Offset: 0x1bc4
// Size: 0x79
function getwingamebytype()
{
    if ( !isdefined( level.wingamebytype ) )
    {
        if ( level.gametypebundle.scoringstrategy == #"teamscores" || level.gametypebundle.scoringstrategy == #"teamhealth" )
        {
            level.wingamebytype = "teamScores";
        }
        else
        {
            level.wingamebytype = "roundsWon";
        }
    }
    
    return level.wingamebytype;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x491c5241, Offset: 0x1c46
// Size: 0x30
function issimultaneouskillenabled()
{
    if ( !isdefined( level.simultaneouskillenabled ) )
    {
        level.simultaneouskillenabled = getdvarint( @"killswitch_simultaneous_deaths", 0 ) == 0;
    }
    
    return level.simultaneouskillenabled;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x71d69682, Offset: 0x1c7f
// Size: 0x83
function cantiebysimultaneouskill()
{
    if ( !issimultaneouskillenabled() )
    {
        return 0;
    }
    
    cantie = 0;
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_4b8799075d3a89b8":
        case #"hash_7485fa6c474ec865":
        case #"hash_7f9c384a34cc392f":
        case #"hash_8f01ce022684fbc8":
        case #"hash_fa0ed9f6bd4f4e9a":
        case #"hash_fb5b5e6c07253005":
            cantie = 1;
            break;
    }
    
    return cantie;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x29188f68, Offset: 0x1d0b
// Size: 0xd9
function shouldplayovertime()
{
    if ( level.shouldplayovertime )
    {
        return [[ level.shouldplayovertime ]]();
    }
    
    tied = allteamstied();
    
    if ( !hitroundlimit() && !hitwinlimit() )
    {
        return 0;
    }
    
    if ( !isovertimesupportedgametype() )
    {
        return 0;
    }
    
    if ( tied && inovertime() )
    {
        var_bf943926299735ae = getmaxovertimeroundsbygametype();
        tied = var_bf943926299735ae == -1 ? 1 : game[ "overtimeRoundsPlayed" ] < var_bf943926299735ae;
    }
    
    var_59ff2b33862e49f6 = shouldplaywinbytwo();
    var_96820e6fc4ba021 = shouldplaytimetobeatot();
    var_4d4da8d716aff03c = shouldplayscoretobeatot();
    return !level.forcedend && ( tied || var_59ff2b33862e49f6 || var_96820e6fc4ba021 || var_4d4da8d716aff03c );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x61397361, Offset: 0x1ded
// Size: 0x20, Type: bool
function resetscoreonroundstart()
{
    return level.gametypebundle.resetscoreonroundstart && !inovertime();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x88ea217b, Offset: 0x1e16
// Size: 0x39
function canplayhalfwayvo()
{
    if ( !isdefined( level.didhalfscorevoboost ) )
    {
        level.didhalfscorevoboost = 0;
    }
    
    if ( level.didhalfscorevoboost )
    {
        return 0;
    }
    
    return level.gametypebundle.var_638603c9f126398e;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x5c3e2ab9, Offset: 0x1e58
// Size: 0x2f, Type: bool
function hittimelimit()
{
    if ( level.timelimit <= 0 )
    {
        return false;
    }
    
    timeleft = gamelogic_mp::gettimeremaining();
    
    if ( timeleft > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x22adeed9, Offset: 0x1e90
// Size: 0x23, Type: bool
function hitroundlimit()
{
    if ( level.roundlimit <= 0 )
    {
        return false;
    }
    
    return game[ "roundsPlayed" ] >= level.roundlimit;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x525a7c49, Offset: 0x1ebc
// Size: 0x109, Type: bool
function hitscorelimit()
{
    if ( isobjectivebased() )
    {
        return false;
    }
    
    if ( level.roundscorelimit <= 0 )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        foreach ( entry in level.teamnamelist )
        {
            if ( game[ "teamScores" ][ entry ] >= level.roundscorelimit )
            {
                return true;
            }
        }
    }
    else
    {
        for ( i = 0; i < level.players.size ; i++ )
        {
            player = level.players[ i ];
            
            if ( player.score >= level.roundscorelimit )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xf9cdb17, Offset: 0x1fce
// Size: 0x9b, Type: bool
function hitwinlimit()
{
    if ( level.winlimit <= 0 )
    {
        return false;
    }
    
    foreach ( entry in level.teamnamelist )
    {
        if ( getroundswon( entry ) >= level.winlimit )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x4109d863, Offset: 0x2072
// Size: 0x3b
function getscorelimit()
{
    if ( isroundbased() )
    {
        if ( level.roundlimit )
        {
            return level.roundlimit;
        }
        else
        {
            return level.winlimit;
        }
        
        return;
    }
    
    return level.roundscorelimit;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x5236719e, Offset: 0x20b5
// Size: 0x16
function getroundswon( team )
{
    return game[ "roundsWon" ][ team ];
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x5598a2e9, Offset: 0x20d4
// Size: 0xae, Type: bool
function allteamstied()
{
    wingamebytype = getwingamebytype();
    winvalue = undefined;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( !isdefined( winvalue ) )
        {
            winvalue = game[ wingamebytype ][ entry ];
            continue;
        }
        
        if ( winvalue != game[ wingamebytype ][ entry ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xd4eed72, Offset: 0x218b
// Size: 0xb
function isobjectivebased()
{
    return level.objectivebased;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x3c579208, Offset: 0x219f
// Size: 0xed
function gettimelimit()
{
    if ( inovertime() && !game[ "inNukeOvertime" ] )
    {
        if ( game[ "timeToBeat" ] )
        {
            return game[ "timeToBeat" ];
        }
        else
        {
            overtimelimit = getdvarfloat( @"overtimetimelimit" );
            var_f8621b59f44b769c = level.var_f8621b59f44b769c && isdefined( level.extratime ) && level.extratime > 0;
            
            if ( overtimelimit > 0 )
            {
                return ( var_f8621b59f44b769c ? overtimelimit + level.extratime : overtimelimit );
            }
            else
            {
                return ( var_f8621b59f44b769c ? level.timelimit + level.extratime : level.timelimit );
            }
        }
        
        return;
    }
    
    if ( level.extratime > 0 )
    {
        return ( level.timelimit + level.extratime );
    }
    
    return level.timelimit;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x923d7149, Offset: 0x2294
// Size: 0x2b
function gethalftime()
{
    if ( inovertime() )
    {
        return 0;
    }
    
    if ( game[ "inNukeOvertime" ] )
    {
        return 0;
    }
    
    return dvars::getwatcheddvar( "halftime" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x727d7e5c, Offset: 0x22c7
// Size: 0xf, Type: bool
function inovertime()
{
    return game[ "status" ] == "overtime";
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x77048d0c, Offset: 0x22df
// Size: 0xbb
function gamehasstarted()
{
    var_7237854e3be197ca = level.gamehasstarted;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( level.teambased )
    {
        foreach ( team in level.teamnamelist )
        {
            if ( teams::getteamdata( team, "hasSpawned" ) )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    return level.maxplayercount > 1;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x8ce346f6, Offset: 0x23a3
// Size: 0xd1
function getlivingplayers( team )
{
    player_array = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( level.teambased && isdefined( team ) )
        {
            if ( team == player.pers[ "team" ] )
            {
                player_array[ player_array.size ] = player;
            }
            
            continue;
        }
        
        player_array[ player_array.size ] = player;
    }
    
    return player_array;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x2422eec3, Offset: 0x247d
// Size: 0x24, Type: bool
function rankingenabled()
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    return level.rankedmatch && !self.usingonlinedataoffline;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x7722cd5e, Offset: 0x24aa
// Size: 0x51, Type: bool
function onlinestatsenabled( gamemode )
{
    if ( !isplayer( self ) )
    {
        return false;
    }
    
    if ( gamemode == "zm" )
    {
        return ( level.var_cc0c7bf608489ed8 && !self.usingonlinedataoffline );
    }
    
    return level.onlinestatsenabled && !self.usingonlinedataoffline;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x2810a47e, Offset: 0x2504
// Size: 0x1c, Type: bool
function privatematch()
{
    return level.onlinegame && getdvarint( @"xblive_privatematch" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc391f5ea, Offset: 0x2529
// Size: 0x2f, Type: bool
function lobbyteamselectenabled()
{
    return level.systemlink || privatematch() && getdvarint( @"lobby_team_select", 0 ) || function_697873d10bd047e4();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x32b3f950, Offset: 0x2561
// Size: 0x3f
function matchmakinggame()
{
    if ( !isdefined( level.matchmakingmatch ) )
    {
        level.matchmakingmatch = getdvarint( @"onlinegame" ) && !getdvarint( @"xblive_privatematch" );
    }
    
    return level.matchmakingmatch;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc25a74ae, Offset: 0x25a9
// Size: 0x2e
function getgametypenumlives()
{
    if ( !isdefined( level.numlives ) )
    {
        level.numlives = getmatchrulesdata( "commonOption", "numLives" );
    }
    
    return level.numlives;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xd91482d3, Offset: 0x25e0
// Size: 0x26
function islifelimited()
{
    if ( !isdefined( level.numlifelimited ) )
    {
        level.numlifelimited = getgametypenumlives();
    }
    
    return level.numlifelimited;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc8dcede7, Offset: 0x260f
// Size: 0x17, Type: bool
function function_57a25addb5327c1a()
{
    return getgametypenumlives() != 0 || level.var_57a25addb5327c1a;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x64518727, Offset: 0x262f
// Size: 0xf1
function getlastlivingplayer( team )
{
    liveplayer = undefined;
    participantplayers = function_4b15b7eb1dc364e7( team );
    
    foreach ( player in participantplayers )
    {
        if ( isdefined( team ) && player.team != team )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() && !player playerlogic::mayspawn() )
        {
            continue;
        }
        
        if ( player.switching_teams )
        {
            continue;
        }
        
        assert( !isdefined( liveplayer ), "<dev string:x24>" );
        liveplayer = player;
    }
    
    return liveplayer;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xb19df08b, Offset: 0x2729
// Size: 0xcc
function trygetlastpotentiallivingplayer()
{
    liveplayer = undefined;
    
    foreach ( player in level.players )
    {
        if ( !player player::isreallyalive() && !player playerlogic::mayspawn() )
        {
            continue;
        }
        
        if ( level.codcasterenabled )
        {
            if ( player iscodcaster() )
            {
                continue;
            }
        }
        
        if ( isdefined( liveplayer ) )
        {
            return;
        }
        
        liveplayer = player;
    }
    
    if ( isdefined( liveplayer ) )
    {
        return liveplayer;
    }
    
    return;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x1c77fa06, Offset: 0x27fd
// Size: 0xba
function getpotentiallivingplayers()
{
    liveplayers = [];
    
    foreach ( player in level.players )
    {
        if ( !player player::isreallyalive() && !player playerlogic::mayspawn() )
        {
            continue;
        }
        
        if ( level.codcasterenabled )
        {
            if ( player iscodcaster() )
            {
                continue;
            }
        }
        
        liveplayers[ liveplayers.size ] = player;
    }
    
    return liveplayers;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x61e5d9ab, Offset: 0x28c0
// Size: 0x44, Type: bool
function denysystemicteamchoice()
{
    if ( !isbot( self ) && !istestclient( self ) )
    {
        if ( isintournament() )
        {
            return true;
        }
        
        if ( level.codcasterenabled )
        {
            return false;
        }
    }
    
    if ( getdvarint( @"hash_c11db9baa9e5bc9b", 0 ) > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x4b99bc55, Offset: 0x290d
// Size: 0x27
function allowteamassignment()
{
    if ( isbrgamemode() )
    {
        return level.teambased;
    }
    
    allowed = doesmodesupportplayerteamchoice();
    return allowed;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x804d8f9, Offset: 0x293d
// Size: 0x16, Type: bool
function doesmodesupportplayerteamchoice()
{
    return istrue( level.gametypebundle.var_1d36ef71b9839cc5 );
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xd0ede96, Offset: 0x295c
// Size: 0x96
function allowclasschoice( var_849c121253d3e9c5 )
{
    if ( getdvarint( @"hash_c11db9baa9e5bc9b", 0 ) > 0 )
    {
        return 0;
    }
    
    if ( isdefined( level.allowclasschoicefunc ) && !var_849c121253d3e9c5 )
    {
        callbackresult = self [[ level.allowclasschoicefunc ]]();
        
        if ( isdefined( callbackresult ) )
        {
            return callbackresult;
        }
    }
    
    if ( flags::gameflag( "infil_will_run" ) && isdefined( level.bypassclasschoicefunc ) )
    {
        return 0;
    }
    
    if ( level.denyclasschoice )
    {
        return 0;
    }
    
    return istrue( level.gametypebundle.allowclasschoice );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xa386db5e, Offset: 0x29fb
// Size: 0x3, Type: bool
function showfakeloadout()
{
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x52fb6c21, Offset: 0x2a07
// Size: 0x167
function setcommonrulesfrommatchrulesdata( skipfriendlyfire )
{
    level.matchrules_allowcustomclasses = getmatchrulesdata( "commonOption", "allowCustomClasses" );
    level.supportintel = getmatchrulesdata( "commonOption", "allowIntel" );
    level.forcethirdperson = getmatchrulesdata( "commonOption", "thirdPerson" );
    
    if ( getdvarint( @"scr_force_thirdperson", 0 ) == 1 )
    {
        level.forcethirdperson = 1;
    }
    
    var_4c9675e73cfaae98 = 0;
    
    /#
        if ( !level.onlinegame && getdvarint( @"scr_skip_infils", 0 ) )
        {
            var_4c9675e73cfaae98 = 1;
        }
        
        if ( getdvarint( @"hash_74cacae425805743", 0 ) > 0 )
        {
            var_4c9675e73cfaae98 = 1;
        }
    #/
    
    if ( var_4c9675e73cfaae98 )
    {
        level.infilskip = 1;
    }
    else
    {
        level.infilskip = getmatchrulesdata( "commonOption", "infilSkip" );
    }
    
    level.headshotsonly = getmatchrulesdata( "commonOption", "headshotsOnly" );
    
    if ( !isdefined( skipfriendlyfire ) )
    {
        serversettings::setfriendlyfire( getmatchrulesdata( "commonOption", "friendlyFire" ) );
    }
    
    setdynamicdvar( @"hash_6ce167f2cdc8ef7c", "" );
    setdynamicdvar( @"hash_29d45d6822a1cf6d", "" );
    
    if ( getdvarint( @"hash_f06ae50014e12fe5" ) == 1 )
    {
        level.var_f566aa14d3f1ee32 = getmatchrulesdata( "commonOption", "dynamicMapElementsDisabled" );
    }
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x4c52d163, Offset: 0x2b76
// Size: 0x70
function function_82e3606d184524fe()
{
    if ( getdvarint( @"hash_7dfc9d99d9c1ff2f", 0 ) == 1 )
    {
        println( "<dev string:x63>" );
        
        if ( isdefined( game[ "gameStateRestore" ] ) && game[ "gameStateRestore" ].enabled )
        {
            println( "<dev string:x81>" );
            return game[ "gameStateRestore" ].gametime;
        }
    }
    
    return getmatchrulesdata( "commonOption", "timeLimit" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xd44f9d25, Offset: 0x2bef
// Size: 0x5a
function reinitializematchrulesonmigration()
{
    assert( isusingmatchrulesdata() );
    assert( isdefined( level.initializematchrules ) );
    
    while ( true )
    {
        level waittill( #"host_migration_begin" );
        [[ level.initializematchrules ]]();
        
        if ( isdefined( level.var_9958ff2d716c4885 ) )
        {
            [[ level.var_9958ff2d716c4885 ]]();
        }
    }
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xb219786d, Offset: 0x2c51
// Size: 0x5c
function reinitializethermal( ent )
{
    self endon( #"disconnect" );
    
    if ( isdefined( ent ) )
    {
        ent endon( #"death" );
    }
    
    while ( true )
    {
        level waittill( #"host_migration_begin" );
        
        if ( isdefined( self.lastvisionsetthermal ) )
        {
            self visionsetthermalforplayer( self.lastvisionsetthermal );
        }
    }
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xa41165f1, Offset: 0x2cb5
// Size: 0x228
function getmatchrulesspecialclass( team, index )
{
    class = [];
    class[ "loadoutPrimaryAttachment2" ] = "none";
    class[ "loadoutSecondaryAttachment2" ] = "none";
    loadoutabilities = [];
    assert( isdefined( team ) && team != "<dev string:x9a>", "<dev string:x9f>" );
    class[ "loadoutPrimary" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 0, "weapon" );
    class[ "loadoutPrimaryAttachment" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 0, "attachmentSetup" );
    class[ "loadoutPrimaryAttachment2" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 0, "attachmentSetup" );
    class[ "loadoutPrimaryCamo" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 0, "camo" );
    class[ "loadoutPrimaryReticle" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 0, "reticle" );
    class[ "loadoutSecondary" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 1, "weapon" );
    class[ "loadoutSecondaryAttachment" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 1, "attachmentSetup" );
    class[ "loadoutSecondaryAttachment2" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 1, "attachmentSetup" );
    class[ "loadoutSecondaryCamo" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 1, "camo" );
    class[ "loadoutSecondaryReticle" ] = getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "weaponSetups", 1, "reticle" );
    class[ "loadoutPerks" ] = loadoutabilities;
    class[ "loadoutKillstreak1" ] = class::recipe_getkillstreak( team, index, 0 );
    class[ "loadoutKillstreak2" ] = class::recipe_getkillstreak( team, index, 1 );
    class[ "loadoutKillstreak3" ] = class::recipe_getkillstreak( team, index, 2 );
    return class;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x13326c4, Offset: 0x2ee6
// Size: 0xd2, Type: bool
function isplayeroutsideofanybombsite( objweapon )
{
    if ( isdefined( level.objectives ) )
    {
        foreach ( bombzone in level.objectives )
        {
            if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
            {
                if ( gameobjects_common::function_8a27a916a385b65c( bombzone, self ) )
                {
                    return false;
                }
                
                continue;
            }
            
            if ( self istouching( bombzone.noweapondropallowedtrigger ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x7b1965df, Offset: 0x2fc1
// Size: 0x3f
function gamehasneutralcrateowner( gametype )
{
    switch ( gametype )
    {
        case #"hash_415b79b2ee6a14d9":
        case #"hash_def61d8a0b05bf0d":
            return 1;
        default:
            return 0;
    }
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x93672dd9, Offset: 0x3008
// Size: 0x26
function isanymlgmatch()
{
    if ( !isdefined( level.isanymlgmatch ) )
    {
        level.isanymlgmatch = function_c0dd867e6bca022d();
    }
    
    return level.isanymlgmatch;
}

// Namespace game_utility_mp
// Params 0, eflags: 0x4
// Checksum 0xec6fb5bb, Offset: 0x3037
// Size: 0x3b
function private function_c0dd867e6bca022d()
{
    if ( isusingmatchrulesdata() )
    {
        if ( getdvarint( @"hash_65c2395ef96fc773" ) == 0 && getmatchrulesdata( "cwlRulesEnabled" ) == 1 )
        {
            return 1;
        }
    }
    
    return getdvarint( @"xblive_competitionmatch" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x8c9589e1, Offset: 0x307b
// Size: 0x23, Type: bool
function ismlgsystemlink()
{
    if ( level.systemlink && getdvarint( @"xblive_competitionmatch" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x36c9766c, Offset: 0x30a7
// Size: 0x20, Type: bool
function ismlgprivatematch()
{
    if ( privatematch() && getdvarint( @"xblive_competitionmatch" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x219fa621, Offset: 0x30d0
// Size: 0x19, Type: bool
function ismlgmatch()
{
    if ( ismlgsystemlink() || ismlgprivatematch() )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xd86ddebe, Offset: 0x30f2
// Size: 0x8f
function isusingdefaultclass( team, index )
{
    usingdefaultclass = 0;
    
    if ( isdefined( index ) )
    {
        if ( isusingmatchrulesdata() && getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "inUse" ) )
        {
            usingdefaultclass = 1;
        }
    }
    else
    {
        for ( index = 0; index < 6 ; index++ )
        {
            if ( isusingmatchrulesdata() && getmatchrulesdatawithteamandindex( "defaultClasses", team, index, "class", "inUse" ) )
            {
                usingdefaultclass = 1;
                break;
            }
        }
    }
    
    return usingdefaultclass;
}

// Namespace game_utility_mp
// Params 7
// Checksum 0xdd036c2d, Offset: 0x318a
// Size: 0x8a
function getmatchrulesdatawithteamandindex( category, team, index, field, arg1, arg2, arg3 )
{
    if ( team == "axis" )
    {
        index += 6;
    }
    
    if ( isdefined( arg3 ) )
    {
        return getmatchrulesdata( category, index, field, arg1, arg2, arg3 );
    }
    
    if ( isdefined( arg2 ) )
    {
        return getmatchrulesdata( category, index, field, arg1, arg2 );
    }
    
    return getmatchrulesdata( category, index, field, arg1 );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xb1f91bca, Offset: 0x321c
// Size: 0x18
function function_153de18b888f365d()
{
    self.var_b4300d21ff2d6a8e = undefined;
    self notify( #"hash_bfad9621a40b949" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x28990e9c, Offset: 0x323c
// Size: 0x18
function function_18eeb0e3becb75c2()
{
    self.var_c19506b543ae5021 = undefined;
    self notify( #"hash_d9461c8b3a52ccb0" );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x7a244632, Offset: 0x325c
// Size: 0x28, Type: bool
function ismatchstartprotected()
{
    return isdefined( level.starttime ) && gettime() < level.starttime + level.equipmentmatchstartshieldms;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x2fecf5e5, Offset: 0x328d
// Size: 0xd4
function getbasegametype()
{
    var_7237854e3be197ca = level.var_9e4587c28c553fa9;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    gametype = game_utility::getgametype();
    tokens = strtok( gametype, "_" );
    
    if ( tokens[ 0 ] == "hc" || tokens[ 0 ] == "cdl" || tokens[ 0 ] == "lp" )
    {
        gametype = tokens[ tokens.size - 1 ];
    }
    
    if ( tokens[ 1 ] == "snipers" || tokens[ 1 ] == "horde" || tokens[ 1 ] == "jugg" )
    {
        gametype = tokens[ 0 ];
    }
    
    if ( tokens[ 0 ] == "ob" )
    {
        gametype = tokens[ 0 ];
    }
    
    if ( !isdefined( level.var_9e4587c28c553fa9 ) )
    {
        level.var_9e4587c28c553fa9 = gametype;
    }
    
    return level.var_9e4587c28c553fa9;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x705dc991, Offset: 0x336a
// Size: 0x19
function function_299e53027853be11()
{
    if ( level.leagueplaymatch )
    {
        return "mp_ranked";
    }
    
    return "mp";
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xefbaec19, Offset: 0x338c
// Size: 0x38, Type: bool
function isteamplacementsbmmmode()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_3c1c1566d7b3b870":
        case #"hash_9196025f8ae8e51e":
        case #"hash_fa21c4f6bd5e3815":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x7f2a946c, Offset: 0x33cd
// Size: 0x38, Type: bool
function isjuggermoshgamemode()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_2f5af599c5c220d3":
        case #"hash_b024b6bb2d9e8547":
        case #"hash_cf3000550ee7e8b3":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x99292fc9, Offset: 0x340e
// Size: 0x20, Type: bool
function ismutationgamemode()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_df78ea63c3b5eb8c":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xe46f84c7, Offset: 0x3437
// Size: 0x27, Type: bool
function ismutationgamemodezombie()
{
    return ismutationgamemode() && self [[ utility::getsharedfunc( #"escort", #"hash_c5891d765038b60f" ) ]]();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x25579c04, Offset: 0x3467
// Size: 0x2c, Type: bool
function function_57f7c589ea92d695()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_4cb5825e78aaa8c":
        case #"hash_a00cd1371d281532":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x505fc734, Offset: 0x349c
// Size: 0x20, Type: bool
function function_389f6e205b205e99()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_6699385db26a3083":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xf96fe8f, Offset: 0x34c5
// Size: 0x68, Type: bool
function lpcfeaturegated()
{
    if ( runleanthreadmode() )
    {
        return true;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_ca6516c10db2c95":
        case #"hash_7f9c384a34cc392f":
        case #"hash_8f01ce022684fbc8":
        case #"hash_9a6f07d0214a87db":
        case #"hash_c065cef60f38490a":
        case #"hash_c7f4420f385eeb3d":
            return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x87fee52b, Offset: 0x3536
// Size: 0x33, Type: bool
function runleanthreadmode()
{
    if ( getdvarint( @"hash_63b929c96913e1d" ) == 1 )
    {
        return true;
    }
    
    if ( isbrgamemode() || level.leanthread == 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xb4cfef95, Offset: 0x3572
// Size: 0xa3
function function_209185f1d1e9327c()
{
    if ( !isdefined( game[ "infil" ] ) )
    {
        return 0;
    }
    
    var_5e08416c4ff940e4 = 1;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( !isdefined( game[ "loadout" ][ entry ] ) )
        {
            var_5e08416c4ff940e4 = 0;
            break;
        }
    }
    
    return var_5e08416c4ff940e4;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x83d7feae, Offset: 0x361e
// Size: 0xb4
function gamehasinfil()
{
    if ( !isdefined( game[ "infil" ] ) )
    {
        return 0;
    }
    
    var_1a244ca659432df0 = 1;
    
    foreach ( entry in level.teamnamelist )
    {
        if ( !( isdefined( game[ "infil" ][ entry ] ) && isdefined( game[ "infil" ][ entry ][ 1 ] ) ) )
        {
            var_1a244ca659432df0 = 0;
            break;
        }
    }
    
    return var_1a244ca659432df0;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xc486ead2, Offset: 0x36db
// Size: 0x30, Type: bool
function function_470832bd123bba03( team )
{
    return function_209185f1d1e9327c() && team_utility::isgameplayteam( team ) && isdefined( game[ "loadout" ][ team ][ 1 ] );
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x3834aa6d, Offset: 0x3714
// Size: 0x30, Type: bool
function teamhasinfil( team )
{
    return gamehasinfil() && team_utility::isgameplayteam( team ) && isdefined( game[ "infil" ][ team ][ 1 ] );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc9960918, Offset: 0x374d
// Size: 0x12, Type: bool
function iskillstreakdenied()
{
    return emp_debuff::is_empd() || isairdenied();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x74bcb8c7, Offset: 0x3768
// Size: 0x17, Type: bool
function isairdenied()
{
    if ( self.team == "spectator" )
    {
        return false;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xee7d3bb7, Offset: 0x3788
// Size: 0x67
function getmaxoutofboundstime()
{
    /#
        return max( 0, getdvarfloat( @"scr_outofboundstime", 3 ) );
    #/
    
    outofboundstime = level.outofboundstime;
    
    if ( !isdefined( outofboundstime ) )
    {
        outofboundstime = max( 0, matchmakinggame() ? getdvarfloat( @"scr_outofboundstime", 3 ) : 3 );
        level.outofboundstime = outofboundstime;
    }
    
    return outofboundstime;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x25d52a06, Offset: 0x37f8
// Size: 0x14
function function_31ae7ef740af6ecd()
{
    return getdvarfloat( @"hash_dd59793cdeddb43f", 15 );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xf8c6ff6, Offset: 0x3815
// Size: 0x14
function function_8586b28631affd97()
{
    return getdvarfloat( @"hash_42b6042574c6086d", 5 );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x424d8db4, Offset: 0x3832
// Size: 0x14
function function_c4391c75ac50e8c4()
{
    return getdvarfloat( @"hash_7ad0f1164d8e9214", 6 );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xbfa67a0c, Offset: 0x384f
// Size: 0x59
function getmaxoutofboundscooldown()
{
    /#
        return max( 0, getdvarfloat( @"scr_outofboundscooldown", 3 ) );
    #/
    
    outofboundscooldown = level.outofboundscooldown;
    
    if ( !isdefined( outofboundscooldown ) )
    {
        outofboundscooldown = max( 0, getdvarfloat( @"scr_outofboundscooldown", 3 ) );
        level.outofboundscooldown = outofboundscooldown;
    }
    
    return outofboundscooldown;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x20128b8a, Offset: 0x38b1
// Size: 0x59
function getmaxoutofboundsminefieldtime()
{
    /#
        return max( 0, getdvarfloat( @"scr_outofboundstimeminefield", 3 ) );
    #/
    
    outofboundstimeminefield = level.outofboundstimeminefield;
    
    if ( !isdefined( outofboundstimeminefield ) )
    {
        outofboundstimeminefield = max( 0, getdvarfloat( @"scr_outofboundstimeminefield", 3 ) );
        level.outofboundstimeminefield = outofboundstimeminefield;
    }
    
    return outofboundstimeminefield;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x97c50729, Offset: 0x3913
// Size: 0x22
function getmaxoutofboundsrestrictedtime()
{
    if ( !isdefined( level.outofboundstimerestricted ) )
    {
        level.outofboundstimerestricted = 10;
    }
    
    return level.outofboundstimerestricted;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x74933e5b, Offset: 0x393e
// Size: 0x46
function getmaxoutofboundsbrtime()
{
    var_a33d01da66757aa5 = getdvarfloat( @"scr_outofboundstime", 10 );
    
    if ( var_a33d01da66757aa5 > 0 )
    {
        level.outofboundstimebr = var_a33d01da66757aa5;
    }
    else
    {
        level.outofboundstimebr = 10;
    }
    
    return level.outofboundstimebr;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xf5dd31ec, Offset: 0x398d
// Size: 0xc5
function updateobjectivetext()
{
    if ( self.pers[ "team" ] == "spectator" )
    {
        self setclientdvar( @"cg_objectivetext", "" );
        return;
    }
    
    if ( level.roundscorelimit > 0 && !isobjectivebased() )
    {
        if ( isdefined( getobjectivescoretext( self.pers[ "team" ] ) ) )
        {
            self setclientdvar( @"cg_objectivetext", getobjectivescoretext( self.pers[ "team" ] ) );
        }
        
        return;
    }
    
    if ( isdefined( getobjectivetext( self.pers[ "team" ] ) ) )
    {
        self setclientdvar( @"cg_objectivetext", getobjectivetext( self.pers[ "team" ] ) );
    }
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x3c2028f, Offset: 0x3a5a
// Size: 0x28
function setobjectivetext( team, text )
{
    game[ "strings" ][ "objective_" + team ] = text;
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xfa18c9d7, Offset: 0x3a8a
// Size: 0x28
function setobjectivescoretext( team, text )
{
    game[ "strings" ][ "objective_score_" + team ] = text;
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x424cd59, Offset: 0x3aba
// Size: 0x28
function setobjectivehinttext( team, text )
{
    game[ "strings" ][ "objective_hint_" + team ] = text;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x31d47083, Offset: 0x3aea
// Size: 0x1c
function getobjectivetext( team )
{
    return game[ "strings" ][ "objective_" + team ];
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xa305df95, Offset: 0x3b0f
// Size: 0x1c
function getobjectivescoretext( team )
{
    return game[ "strings" ][ "objective_score_" + team ];
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xaa0f8d30, Offset: 0x3b34
// Size: 0x1c
function getobjectivehinttext( team )
{
    return game[ "strings" ][ "objective_hint_" + team ];
}

// Namespace game_utility_mp
// Params 2
// Checksum 0x3f1892cd, Offset: 0x3b59
// Size: 0x45
function testgamemodestringlist( stringlist, gamemode )
{
    if ( !isdefined( stringlist ) || stringlist == "" || !isdefined( gamemode ) || gamemode == "" )
    {
        return 0;
    }
    
    return issubstr( stringlist, gamemode );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xa56c0b5c, Offset: 0x3ba7
// Size: 0x2b, Type: bool
function islaststandenabled()
{
    return level.laststand == 1 || level.laststand == 3 || level.var_dce68d4837fb7c51;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xc2e4b15d, Offset: 0x3bdb
// Size: 0x1e, Type: bool
function isteamreviveenabled()
{
    return level.laststand == 2 || level.laststand == 3;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x690bf33a, Offset: 0x3c02
// Size: 0x1f5, Type: bool
function function_78d7264eab1f870( enemy )
{
    if ( isdefined( level.cyberemp.carrier ) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier )
    {
        var_82cfaaa93fed653 = distancesquared( level.cyberemp.carrier.origin, self.origin );
        var_aad363fd61214f7e = distancesquared( level.cyberemp.carrier.origin, enemy.origin );
        
        if ( var_82cfaaa93fed653 < 90000 || var_aad363fd61214f7e < 90000 )
        {
            return true;
        }
    }
    
    foreach ( bombzone in level.objectives )
    {
        if ( bombzone.trigger.trigger_off )
        {
            continue;
        }
        
        ownerteam = bombzone.ownerteam;
        
        if ( ownerteam == self.team )
        {
            var_82cfaaa93fed653 = distancesquared( bombzone.trigger.origin, self.origin );
            var_aad363fd61214f7e = distancesquared( bombzone.trigger.origin, enemy.origin );
            
            if ( var_82cfaaa93fed653 < 90000 || var_aad363fd61214f7e < 90000 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x9a8d3448, Offset: 0x3e00
// Size: 0xcf, Type: bool
function function_587ce2553bfdb756( enemy )
{
    if ( self.team != game[ "defenders" ] )
    {
        return false;
    }
    
    foreach ( objective in level.objectives )
    {
        var_a156514c533bef07 = distancesquared( objective.trigger.origin, enemy.origin );
        
        if ( var_a156514c533bef07 < 90000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x2723791a, Offset: 0x3ed8
// Size: 0xce, Type: bool
function function_abefb3841cda328e( enemy )
{
    assert( isdefined( enemy ) );
    
    foreach ( gameobject in level.objectives )
    {
        owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
        
        if ( self.team != owningteam )
        {
            continue;
        }
        
        if ( function_f59c5fc8806cad16( gameobject, self.origin, enemy.origin ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x399d3b2f, Offset: 0x3faf
// Size: 0x10b
function function_daab43ec23b14d5c( enemy )
{
    assert( isdefined( enemy ) );
    
    foreach ( gameobject in level.objectives )
    {
        owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
        
        if ( self.team != owningteam )
        {
            continue;
        }
        
        objectiveorigin = gameobjects_shared::get_origin( gameobject );
        var_fd402f43451fe324 = distancesquared( objectiveorigin, self.origin );
        var_d6a6f5b8d132b222 = distancesquared( objectiveorigin, enemy.origin );
        
        if ( var_fd402f43451fe324 <= 90000 || var_d6a6f5b8d132b222 <= 90000 )
        {
            return gameobject;
        }
    }
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xaf3c8c08, Offset: 0x40c3
// Size: 0x61, Type: bool
function function_24298f56712800ff( enemy )
{
    if ( isdefined( level.zone ) )
    {
        return ( ispointinvolume( self.origin, level.zone.trigger ) || ispointinvolume( enemy.origin, level.zone.trigger ) );
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xc4526ce2, Offset: 0x412d
// Size: 0x28
function isdefending( enemy )
{
    if ( isdefined( level.var_40cd999d911308e0 ) )
    {
        return [[ level.var_40cd999d911308e0 ]]( enemy );
    }
    
    return 0;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x543a4e9e, Offset: 0x415e
// Size: 0x27
function function_f32f6f305882730( enemy )
{
    if ( isdefined( level.var_40ab710579539b1 ) )
    {
        return [[ level.var_40ab710579539b1 ]]( enemy );
    }
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xaf3731dc, Offset: 0x418e
// Size: 0x216, Type: bool
function function_1eb2797be76408e9( enemy )
{
    if ( enemy.isbombcarrier )
    {
        return true;
    }
    
    if ( isdefined( level.cyberemp.carrier ) && self.team == level.cyberemp.ownerteam && self != level.cyberemp.carrier )
    {
        var_82cfaaa93fed653 = distancesquared( level.cyberemp.carrier.origin, self.origin );
        var_aad363fd61214f7e = distancesquared( level.cyberemp.carrier.origin, enemy.origin );
        
        if ( var_82cfaaa93fed653 < 90000 || var_aad363fd61214f7e < 90000 )
        {
            return true;
        }
    }
    
    foreach ( bombzone in level.objectives )
    {
        if ( bombzone.trigger.trigger_off )
        {
            continue;
        }
        
        ownerteam = bombzone.ownerteam;
        
        if ( ownerteam != self.team )
        {
            var_15732834a0ec0207 = distancesquared( bombzone.trigger.origin, self.origin );
            var_ecbe3f4c53ca9c32 = distancesquared( bombzone.trigger.origin, enemy.origin );
            
            if ( var_15732834a0ec0207 < 90000 || var_ecbe3f4c53ca9c32 < 90000 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xb7e98a1d, Offset: 0x43ad
// Size: 0xcf, Type: bool
function function_50204bc2d6eb5ee9( enemy )
{
    if ( self.team == game[ "defenders" ] )
    {
        return false;
    }
    
    foreach ( objective in level.objectives )
    {
        var_a156514c533bef07 = distancesquared( objective.trigger.origin, enemy.origin );
        
        if ( var_a156514c533bef07 < 90000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xe45a1245, Offset: 0x4485
// Size: 0xce, Type: bool
function function_90ed3e9fed444ef5( enemy )
{
    assert( isdefined( enemy ) );
    
    foreach ( gameobject in level.objectives )
    {
        owningteam = gameobjects_shared::function_623b07f4735aecb2( gameobject );
        
        if ( self.team == owningteam )
        {
            continue;
        }
        
        if ( function_f59c5fc8806cad16( gameobject, self.origin, enemy.origin ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xc47ab942, Offset: 0x455c
// Size: 0x61, Type: bool
function function_84968d430abf1672( enemy )
{
    if ( isdefined( level.zone ) )
    {
        return ( ispointinvolume( self.origin, level.zone.trigger ) || ispointinvolume( enemy.origin, level.zone.trigger ) );
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x5d882ec5, Offset: 0x45c6
// Size: 0x29, Type: bool
function isassaulting( enemy )
{
    if ( isdefined( level.var_e16ef107a3dd572b ) )
    {
        return istrue( [[ level.var_e16ef107a3dd572b ]]( enemy ) );
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x830ec1c9, Offset: 0x45f8
// Size: 0xd8
function gametypesupportsbasejumping()
{
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_520237eb9ad2c19e )
    {
        return 1;
    }
    
    switch ( game_utility::getgametype() )
    {
        case #"hash_1e4846dca3ccf38":
        case #"hash_ca6516c10db2c95":
        case #"hash_53825b446469ac4c":
        case #"hash_63fb0ba698c46db3":
        case #"hash_7485fa6c474ec865":
        case #"hash_7f9c384a34cc392f":
        case #"hash_8f01ce022684fbc8":
        case #"hash_9a6f07d0214a87db":
        case #"hash_b9458959b10637f8":
        case #"hash_c065cef60f38490a":
        case #"hash_c7f4420f385eeb3d":
        case #"hash_f4a9126c03d3385b":
            return 1;
        default:
            return 0;
    }
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x9a7b5dc1, Offset: 0x46d8
// Size: 0xeb
function mapsupportsbasejumping()
{
    if ( game_utility::isdonetskmap() || game_utility::islargemap() )
    {
        return 1;
    }
    
    switch ( level.mapname )
    {
        case #"hash_1b3ccf154e387057":
            return 1;
        case #"hash_7b08e6b8f46bd733":
            return 1;
        case #"hash_7ff81f1cd6143d9d":
            return 1;
        case #"hash_1dda853d40d6f75e":
            return 1;
        case #"hash_5cfcc13994df1513":
            return 1;
        case #"hash_ab7026ed3aa8e85e":
            return 1;
        case #"hash_e0f4521889150186":
            return 1;
        case #"hash_2d70196d81f685bc":
            return 1;
        case #"hash_2d701c6d81f68a75":
            return 1;
        case #"hash_2d701b6d81f688e2":
            return 1;
        case #"hash_2d70166d81f68103":
            return 1;
        case #"hash_29da5cf015f908ce":
            return 1;
        default:
            return 0;
    }
}

// Namespace game_utility_mp
// Params 5
// Checksum 0x10b09f90, Offset: 0x47cb
// Size: 0x3a5
function logannouncement( player, contester, message, zoneorigin, extrainfo )
{
    time_from_match_start = matchdata::gettimefrommatchstart( gettime() );
    
    if ( !isdefined( message ) )
    {
        return;
    }
    
    info = "";
    
    if ( isdefined( extrainfo ) )
    {
        info = extrainfo;
    }
    else
    {
        info = "none";
    }
    
    if ( !isdefined( player ) )
    {
        if ( isdefined( zoneorigin ) )
        {
            dlog_recordevent( "dlog_event_announcement", [ "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", "none", "contester_team", "none", "zone_x", zoneorigin[ 0 ], "zone_y", zoneorigin[ 1 ], "zone_z", zoneorigin[ 2 ] ] );
        }
        else
        {
            dlog_recordevent( "dlog_event_announcement", [ "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info ] );
        }
        
        return;
    }
    
    if ( isdefined( contester ) )
    {
        if ( isdefined( zoneorigin ) )
        {
            dlog_recordevent( "dlog_event_announcement", [ "player", player, "contester", contester, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", contester.team, "zone_x", zoneorigin[ 0 ], "zone_y", zoneorigin[ 1 ], "zone_z", zoneorigin[ 2 ] ] );
        }
        else
        {
            dlog_recordevent( "dlog_event_announcement", [ "player", player, "contester", contester, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", contester.team ] );
        }
        
        return;
    }
    
    if ( isdefined( zoneorigin ) )
    {
        dlog_recordevent( "dlog_event_announcement", [ "player", player, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team, "contester_team", "none", "zone_x", zoneorigin[ 0 ], "zone_y", zoneorigin[ 1 ], "zone_z", zoneorigin[ 2 ] ] );
        return;
    }
    
    dlog_recordevent( "dlog_event_announcement", [ "player", player, "time_from_match_start", time_from_match_start, "announcement", message, "extra_info", info, "player_team", player.team ] );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xcbcc9f13, Offset: 0x4b78
// Size: 0xc, Type: bool
function isprophuntgametype()
{
    return istrue( level.isprophunt );
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x2260fb2f, Offset: 0x4b8d
// Size: 0x32, Type: bool
function isgroundwarcoremode()
{
    return level.isgroundwarinfected || level.isgroundwarsiege || level.isgroundwardom || level.var_bbafbc222fd80343;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x550cb23f, Offset: 0x4bc8
// Size: 0xa5
function function_e9b3932d0481c856()
{
    switch ( game_utility::getgametype() )
    {
        case #"hash_1e4846dca3ccf38":
        case #"hash_ca6516c10db2c95":
        case #"hash_7f9c384a34cc392f":
        case #"hash_9a6f07d0214a87db":
        case #"hash_aac44b0b52bacb8e":
        case #"hash_c065cef60f38490a":
        case #"hash_c7f4420f385eeb3d":
        case #"hash_dd217fc2f74cbcdd":
        case #"hash_eb5e5f470e0c1dc2":
        case #"hash_ec086b911c1011ec":
        case #"hash_fa50b0f6bd82e972":
            return 1;
        default:
            return 0;
    }
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x96b9e4dd, Offset: 0x4c75
// Size: 0x81
function isverdansksubmap()
{
    switch ( game_utility::getmapname() )
    {
        case #"hash_12f3765ef24b4037":
        case #"hash_1bc93b88575e82eb":
        case #"hash_32eaa112f8caa7e4":
        case #"hash_3a8b050ff58578ad":
        case #"hash_50de71be6e7469ff":
        case #"hash_7a28db3c5928c489":
        case #"hash_924a3fbe9fbe15c6":
        case #"hash_e4ca6b73b5022b26":
            return 1;
        default:
            return 0;
    }
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xa67facb5, Offset: 0x4cfe
// Size: 0x78, Type: bool
function function_166654fc96d0736a()
{
    if ( game_utility::islargemap() )
    {
        return true;
    }
    else if ( game_utility::isdonetskmap() )
    {
        return true;
    }
    else if ( isverdansksubmap() )
    {
        return true;
    }
    else if ( ( level.gametypebundle.var_7e815436a1664a1e ?? #"bigmapfalldamage" ) != #"bigmapfalldamage" )
    {
        return false;
    }
    else if ( getdvarint( @"hash_e35a761bc944e0f8", 0 ) != 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x8b437aed, Offset: 0x4d7f
// Size: 0x10f
function canparachutebecut( player )
{
    var_d9444cd2b8568101 = 0;
    cancut = 0;
    gametype = game_utility::getgametype();
    
    if ( isusingmatchrulesdata() && getmatchrulesdata( "commonOption", "allowParachute" ) || ( gametype == "arm" || gametype == "bigctf" || gametype == "conflict" || gametype == "gwbomb" || isgroundwarcoremode() ) && game_utility::islargemap() || getdvarint( @"hash_9365c7a237edaa2f", 0 ) == 1 || level.var_d9d68aeaf1fa45a7 )
    {
        if ( level.parachutecancutautodeploy )
        {
            var_d9444cd2b8568101 = 1;
        }
        
        if ( level.parachutecancutparachute && !player.var_48fe61030a581373 )
        {
            cancut = 1;
        }
    }
    
    if ( var_d9444cd2b8568101 )
    {
        player skydive_cutautodeployon();
    }
    else
    {
        player skydive_cutautodeployoff();
    }
    
    if ( cancut )
    {
        player skydive_cutparachuteon();
        return;
    }
    
    player skydive_cutparachuteoff();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x58c76731, Offset: 0x4e96
// Size: 0x60, Type: bool
function function_4818e8dcc8c3ec96()
{
    /#
        if ( getdvarint( @"hash_174506584f9d388e", 0 ) == 1 )
        {
            return true;
        }
    #/
    
    return level.var_ac451a7698545a53 || level.var_129ae32cb395a9b2 || isusingmatchrulesdata() && getmatchrulesdata( "commonOption", "allowParachute" ) || gametypesupportsbasejumping() && mapsupportsbasejumping();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x4c557db3, Offset: 0x4eff
// Size: 0x1c, Type: bool
function function_f24635ef11e449d1()
{
    return matchmakinggame() && getmatchrulesdata( "commonOption", "classTableOverride" ) != 0;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x67f1e690, Offset: 0x4f24
// Size: 0x1d, Type: bool
function function_4e472149e39356a3()
{
    return matchmakinggame() && getmatchrulesdata( "commonOption", "classTableOverride" ) == 1;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x83e9f21b, Offset: 0x4f4a
// Size: 0x1b, Type: bool
function function_7f1dcc0fc932f72a()
{
    if ( function_f24635ef11e449d1() )
    {
        return true;
    }
    
    if ( function_57f7c589ea92d695() )
    {
        return true;
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x1a663777, Offset: 0x4f6e
// Size: 0x8
function canextract()
{
    return common_instance_inventory::isenabled();
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x238941e9, Offset: 0x4f7f
// Size: 0x26, Type: bool
function function_de2aaa741c2234e7()
{
    return getdvarint( @"online_allowteamchange" ) || level.gametypebundle.var_f5242bb1aa8222f8;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x430d5ff1, Offset: 0x4fae
// Size: 0x64
function get_linked_vehicle_nodes()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = utility::get_links();
        
        if ( linknames.size == 1 )
        {
            return getvehiclenodearray( linknames[ 0 ], #script_linkname );
        }
        else if ( linknames.size > 1 )
        {
            return function_7013fcae2370dd95( linknames, #script_linkname );
        }
    }
    
    return array;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x9b4a9d94, Offset: 0x501b
// Size: 0x53
function function_4b7180ed8c2e9742( assettype )
{
    if ( !( isdefined( assettype ) && isdefined( level.gametypebundle.var_ae100eea97c7fcc7 ) ) )
    {
        return;
    }
    
    if ( !isxhash( assettype ) )
    {
        assettype = getxhash( assettype );
    }
    
    return level.gametypebundle.var_ae100eea97c7fcc7[ assettype ];
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xcea06bec, Offset: 0x5077
// Size: 0x53
function function_cb7ed8e67866f9d0( assettype )
{
    if ( !( isdefined( assettype ) && isdefined( level.mapinfobundle.var_ae100eea97c7fcc7 ) ) )
    {
        return;
    }
    
    if ( !isxhash( assettype ) )
    {
        assettype = getxhash( assettype );
    }
    
    return level.mapinfobundle.var_ae100eea97c7fcc7[ assettype ];
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x65bbc1fc, Offset: 0x50d3
// Size: 0x32
function function_3e2a0e4a5bf03624()
{
    if ( isdefined( level.gametypebundle.var_60925f26791ed354 ) )
    {
        return level.gametypebundle.var_60925f26791ed354;
    }
    
    return "";
}

// Namespace game_utility_mp
// Params 0
// Checksum 0xd8dfd546, Offset: 0x510e
// Size: 0xd3
function function_7da4393c3da44f51()
{
    var_7237854e3be197ca = level.var_31b8799fdffdd4a5;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    primaryflags = getentarray( "flag_primary", "targetname" );
    
    foreach ( flag in primaryflags )
    {
        if ( flag.script_label == "_b" )
        {
            level.var_31b8799fdffdd4a5 = flag.origin;
            break;
        }
    }
    
    return level.var_31b8799fdffdd4a5;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xc5c24090, Offset: 0x51ea
// Size: 0x36
function function_271df163aca17bc1( movieassetname )
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 1 )
    {
        return;
    }
    
    assert( isdefined( movieassetname ) );
    level.mapbink = movieassetname;
}

// Namespace game_utility_mp
// Params 0
// Checksum 0x8ac0e341, Offset: 0x5228
// Size: 0x7d
function function_72eee44b5c341138()
{
    self endon( #"disconnect" );
    
    if ( !isdefined( level.mapbink ) )
    {
        return;
    }
    
    while ( !self.pers[ "streamSyncComplete" ] )
    {
        waitframe();
    }
    
    wait 3;
    
    while ( true )
    {
        if ( utility::flag( "nuke_bink_done" ) )
        {
            break;
        }
        
        setdvar( @"bg_cinematicfullscreen", "0" );
        self function_73788e9f76af4fad( level.mapbink, 1 );
        wait 1;
    }
}

// Namespace game_utility_mp
// Params 3, eflags: 0x4
// Checksum 0xddf110fe, Offset: 0x52ad
// Size: 0xa0, Type: bool
function private function_f59c5fc8806cad16( gameobject, attackerorigin, victimorigin )
{
    assert( isdefined( gameobject ) && isdefined( attackerorigin ) && isdefined( victimorigin ) );
    origin = gameobjects_shared::get_origin( gameobject );
    var_bf527c1dac7b6503 = distancesquared( origin, attackerorigin );
    var_46d2631e2ffc1956 = distancesquared( origin, victimorigin );
    
    if ( var_bf527c1dac7b6503 <= 90000 || var_46d2631e2ffc1956 <= 90000 )
    {
        return ( attackerorigin[ 2 ] - origin[ 2 ] < 100 || victimorigin[ 2 ] - origin[ 2 ] < 100 );
    }
    
    return false;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x79124298, Offset: 0x5356
// Size: 0x52
function getgamestate( instanceid )
{
    if ( ( level.multimatch ?? gameinstance::is_enabled() ) && isdefined( instanceid ) )
    {
        if ( isplayer( instanceid ) )
        {
            instanceid = instanceid.instanceid;
        }
        
        return gameinstance::get_instance_game_state( instanceid );
    }
    
    return game[ "state" ];
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x75015072, Offset: 0x53b0
// Size: 0x3a
function function_2d6eda4bd30f6b52( player )
{
    if ( isdefined( player.instanceid ) )
    {
        return gameinstance::function_65b79de0e13026ab( player.instanceid );
    }
    
    return level.teamswithplayers;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xa183b487, Offset: 0x53f2
// Size: 0x91
function function_4b15b7eb1dc364e7( instance )
{
    if ( ( level.multimatch ?? gameinstance::is_enabled() ) && isdefined( instance ) )
    {
        if ( isstruct( instance ) )
        {
            return gameinstance::get_instance_players( instance.id );
        }
        else if ( isstring( instance ) && team_utility::isgameplayteam( instance ) )
        {
            instanceid = gameinstance::get_instance_id( instance );
            return gameinstance::get_instance_players( instanceid );
        }
        else
        {
            return gameinstance::get_instance_players( instance );
        }
        
        return;
    }
    
    return level.players;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x26db0dd6, Offset: 0x548b
// Size: 0x91
function function_cd6aa714027fb767( instance )
{
    if ( ( level.multimatch ?? gameinstance::is_enabled() ) && isdefined( instance ) )
    {
        if ( isstruct( instance ) )
        {
            return gameinstance::get_instance_teams( instance.id );
        }
        else if ( isstring( instance ) && team_utility::isgameplayteam( instance ) )
        {
            instanceid = gameinstance::get_instance_id( instance );
            return gameinstance::get_instance_teams( instanceid );
        }
        else
        {
            return gameinstance::get_instance_teams( instance );
        }
        
        return;
    }
    
    return level.teamnamelist;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xef9f8a52, Offset: 0x5524
// Size: 0x31
function get_attacker_team( instance_id )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return gameinstance::get_instance_attackers( instance_id );
    }
    
    return game[ "attackers" ];
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xb213b059, Offset: 0x555e
// Size: 0x31
function get_defender_team( instance_id )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return gameinstance::get_instance_defenders( instance_id );
    }
    
    return game[ "defenders" ];
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xc65e523c, Offset: 0x5598
// Size: 0x4b, Type: bool
function is_attacker_team( team_name )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        instance_id = gameinstance::get_instance_id( team_name );
        return ( get_attacker_team( instance_id ) == team_name );
    }
    
    return game[ "attackers" ] == team_name;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xf7fb3dd0, Offset: 0x55ec
// Size: 0x4b, Type: bool
function is_defender_team( team_name )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        instance_id = gameinstance::get_instance_id( team_name );
        return ( get_defender_team( instance_id ) == team_name );
    }
    
    return game[ "defenders" ] == team_name;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x867b73a4, Offset: 0x5640
// Size: 0x35
function get_team_role( team_name )
{
    if ( is_attacker_team( team_name ) )
    {
        return "attackers";
    }
    
    if ( is_defender_team( team_name ) )
    {
        return "defenders";
    }
    
    return;
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xe856bef6, Offset: 0x567d
// Size: 0xcc
function add_gametype_objective( game_object, var_5cfe216327d3e91b )
{
    objective_key = gameobjects_common::get_objective_key( game_object );
    instance_id = gameobjects_common::get_instance_id( game_object );
    game_object.objectivekey = objective_key;
    
    if ( isdefined( instance_id ) && gameinstance::is_enabled() )
    {
        if ( !isdefined( level.instance_objectives ) )
        {
            level.instance_objectives = [];
        }
        
        if ( !isdefined( level.instance_objectives[ instance_id ] ) )
        {
            level.instance_objectives[ instance_id ] = [];
        }
        
        level.instance_objectives[ instance_id ][ var_5cfe216327d3e91b ?? objective_key ] = game_object;
        return;
    }
    
    if ( !isdefined( level.objectives ) )
    {
        level.objectives = [];
    }
    
    level.objectives[ var_5cfe216327d3e91b ?? objective_key ] = game_object;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0xe2f7252b, Offset: 0x5751
// Size: 0x71
function function_4edce42eca6d1c95( game_object )
{
    objective_key = gameobjects_common::get_objective_key( game_object );
    instance_id = gameobjects_common::get_instance_id( game_object );
    
    if ( isdefined( instance_id ) )
    {
        level.instance_objectives[ instance_id ] = arrayremove( level.instance_objectives[ instance_id ], game_object );
        return;
    }
    
    level.objectives = arrayremove( level.objectives, game_object );
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xc4f737c7, Offset: 0x57ca
// Size: 0x36
function function_d32d987fe2a4d027( objective_key, instance_id )
{
    if ( isdefined( instance_id ) )
    {
        level.instance_objectives[ objective_key ] = undefined;
        return;
    }
    
    level.objectives[ objective_key ] = undefined;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x75e5aee5, Offset: 0x5808
// Size: 0x37
function get_gametype_objectives( instance_id )
{
    if ( level.multimatch ?? gameinstance::is_enabled() )
    {
        return level.instance_objectives[ instance_id ];
    }
    
    return level.objectives;
}

// Namespace game_utility_mp
// Params 1
// Checksum 0x40af756b, Offset: 0x5848
// Size: 0x2cf
function clean_up_entities( var_958812bec5c7f6ab = [] )
{
    var_958812bec5c7f6ab[ var_958812bec5c7f6ab.size ] = "airdrop_pallet";
    
    foreach ( entity in getentarray() )
    {
        if ( entity.targetname == "ammo_restock_location" || ammorestock::function_66c12ebdbc81570( entity ) || entity.donotdelete )
        {
            if ( isdefined( entity.target ) )
            {
                foreach ( target_entity in getentarray( entity.target, #targetname ) )
                {
                    target_entity.donotdelete = 1;
                }
            }
            
            entity.donotdelete = 1;
            continue;
        }
        
        var_9cee31b7406c28bd = entity.script_gameobjectname;
        
        if ( isdefined( var_9cee31b7406c28bd ) )
        {
            invert_logic = 0;
            matches = 0;
            
            if ( getsubstr( var_9cee31b7406c28bd, 0, 1 ) == "!" )
            {
                var_9cee31b7406c28bd = getsubstr( var_9cee31b7406c28bd, 1 );
                invert_logic = 1;
            }
            
            var_5268ac3cffe823eb = strtok( var_9cee31b7406c28bd, " " );
            
            foreach ( var_b0b3a627e5fa71da in var_958812bec5c7f6ab )
            {
                foreach ( entity_name in var_5268ac3cffe823eb )
                {
                    if ( var_b0b3a627e5fa71da == entity_name )
                    {
                        matches = 1;
                        break;
                    }
                }
                
                if ( matches )
                {
                    break;
                }
            }
            
            if ( invert_logic )
            {
                if ( matches )
                {
                    entity delete();
                }
                
                continue;
            }
            
            if ( !matches )
            {
                entity delete();
            }
        }
    }
}

// Namespace game_utility_mp
// Params 2
// Checksum 0xcf268f0c, Offset: 0x5b1f
// Size: 0x41
function function_cd87fbce63057ef5( gametype_prefix, allows )
{
    dvar = hashcat( gametype_prefix, "custom_script_gameobject_name_allow" );
    
    if ( isdvardefined( dvar ) )
    {
        allows[ allows.size ] = getdvar( dvar );
    }
}

