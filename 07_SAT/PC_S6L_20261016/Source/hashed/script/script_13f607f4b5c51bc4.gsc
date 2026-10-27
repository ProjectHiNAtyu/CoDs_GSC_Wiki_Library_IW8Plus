// script_13f607f4b5c51bc4  (hash_13f607f4b5c51bc4.gscc) (size: 15241 Bytes / 0x3b89 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x41a6ef66 (1101459302)
// size ...... 15241 (0x3b89)
// includes .. 11  (offset: 0x31d1)
// strings ... 98  (offset: 0x3229)
// dev strs .. 0   (offset: 0x3b89)
// exports ... 18  (offset: 0x2809)
// cseg ...... 0x8f3 + 0x1f16 (0x2809)
// imports ... 52  (offset: 0x2ad9)
// animtree1 . 0   (offset: 0x3b89)
// animtree2 . 0   (offset: 0x3b89)
#using scripts\common\callbacks;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dialog_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\overlord;

#namespace namespace_cef36d7634533c06;

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x17607e54, Offset: 0x911
// Size: 0x17
function init()
{
    init_voice();
    init_dialogue();
    function_676f55eabe22905();
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x72e29530, Offset: 0x930
// Size: 0x92
function init_voice()
{
    if ( game[ "isLaunchChunk" ] )
    {
        var_f62e0fd5371a1353 = "ustl";
    }
    else
    {
        var_f62e0fd5371a1353 = "uktl";
    }
    
    if ( isdefined( level.alliessquadleader ) )
    {
        var_f62e0fd5371a1353 = level.alliessquadleader;
    }
    
    var_478caed60425275c = "rutl";
    
    if ( isdefined( level.axissquadleader ) )
    {
        var_478caed60425275c = level.axissquadleader;
    }
    
    if ( !isdefined( game[ "voice" ] ) )
    {
        game[ "voice" ][ "allies" ] = var_f62e0fd5371a1353;
        game[ "voice" ][ "axis" ] = var_478caed60425275c;
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0xcd7ad907, Offset: 0x9ca
// Size: 0x8ca
function init_dialogue()
{
    if ( !isdefined( game[ "dialogue" ] ) )
    {
        game[ "dialogue" ][ "axis_male_cough" ] = [];
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_1";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_2";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_3";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_4";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_5";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_6";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_7";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_3_enemy_8";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_1";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_2";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_3";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_4";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_5";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_6";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_7";
        game[ "dialogue" ][ "axis_male_cough" ][ game[ "dialogue" ][ "axis_male_cough" ].size ] = "generic_cough_fit_enemy_8";
        game[ "dialogue" ][ "axis_female_cough" ] = [];
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_1";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_2";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_3";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_4";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_5";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_6";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_7";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_3_friendly_8";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_1";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_2";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_3";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_4";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_5";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_6";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_7";
        game[ "dialogue" ][ "axis_female_cough" ][ game[ "dialogue" ][ "axis_female_cough" ].size ] = "woman_cough_fit_friendly_8";
        game[ "dialogue" ][ "allies_male_cough" ] = [];
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_1";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_2";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_3";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_4";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_5";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_6";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_7";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_3_friendly_8";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_1";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_2";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_3";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_4";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_5";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_6";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_7";
        game[ "dialogue" ][ "allies_male_cough" ][ game[ "dialogue" ][ "allies_male_cough" ].size ] = "generic_cough_fit_friendly_8";
        game[ "dialogue" ][ "allies_female_cough" ] = [];
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_1";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_2";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_3";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_4";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_5";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_6";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_7";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_3_friendly_8";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_1";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_2";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_3";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_4";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_5";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_6";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_7";
        game[ "dialogue" ][ "allies_female_cough" ][ game[ "dialogue" ][ "allies_female_cough" ].size ] = "woman_cough_fit_friendly_8";
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x2fc973ae, Offset: 0x129c
// Size: 0x91
function function_676f55eabe22905()
{
    callback::add( #"player_spawned", &onplayerspawned );
    level thread onplayerconnect();
    level thread onlastalive();
    level thread match_ending_soon_dialog();
    level thread onroundswitch();
    callback::add( #"round_ended", &roundwinnerdialog );
    callback::add( #"game_ended", &gamewinnerdialog );
    
    if ( game_utility::getgametype() == "gwai" )
    {
        setdvar( @"hash_58a078a367c02ab3", 1 );
        setdvar( @"hash_c5d765aefb9658bd", 1500 );
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x2ce3e018, Offset: 0x1335
// Size: 0x3e
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player thread playflyoveraudioline();
        player thread watchhostmigration();
        player.var_ea1eb7940dfe932c = 1;
    }
}

// Namespace namespace_cef36d7634533c06
// Params 1
// Checksum 0x9f1720db, Offset: 0x137b
// Size: 0x32
function onplayerspawned( params )
{
    if ( isai( self ) )
    {
        return;
    }
    
    if ( self.var_ea1eb7940dfe932c )
    {
        thread dointro();
        self.var_ea1eb7940dfe932c = undefined;
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x36fa9efb, Offset: 0x13b5
// Size: 0x40
function waitcountdown()
{
    level endon( #"host_migration_begin" );
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        if ( flags::gameflag( "prematch_done" ) )
        {
            self notify( #"luinotifyserver", "matchReady" );
            return;
        }
        
        wait 1;
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x727d5b9a, Offset: 0x13fd
// Size: 0x1d6
function playflyoveraudioline()
{
    level endon( #"host_migration_begin" );
    self endon( #"disconnect" );
    normalizedtimepassed = game_utility::gettimepassed() / 1000 + 6;
    
    if ( normalizedtimepassed >= level.prematchperiod )
    {
        return;
    }
    
    if ( !level.rankedmatch )
    {
        return;
    }
    
    if ( !game_utility_mp::rankingenabled() )
    {
        return;
    }
    
    teamid = 0;
    
    if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
    {
        if ( self.sessionteam == "allies" )
        {
            switch ( teamid )
            {
                case 0:
                    self playannouncersound( "jtfw_mtc1_un_flyover" );
                    break;
                case 1:
                    self playannouncersound( "oi_mtc3_un_flyover" );
                    break;
                case 2:
                    self playannouncersound( "st7_mtc4_prematch_flyover" );
                    break;
                case 3:
                    self playannouncersound( "wr_mtc5_un_flyover" );
                    break;
                case 4:
                    self playannouncersound( "ba_mtc2_un_flyover" );
                    break;
                default:
                    break;
            }
            
            return;
        }
        
        if ( self.sessionteam == "axis" )
        {
            switch ( teamid )
            {
                case 0:
                    self playannouncersound( "jtfw_mtc1_sdf_flyover" );
                    break;
                case 1:
                    self playannouncersound( "oi_mtc3_sdf_flyover" );
                    break;
                case 2:
                    self playannouncersound( "st7_mtc4_prematch_flyover" );
                    break;
                case 3:
                    self playannouncersound( "wr_mtc5_sdf_flyover" );
                    break;
                case 4:
                    self playannouncersound( "ba_mtc2_sdf_flyover" );
                    break;
                default:
                    break;
            }
        }
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x3c0a3902, Offset: 0x15db
// Size: 0x2eb
function dointro()
{
    level endon( #"game_ended" );
    level endon( #"host_migration_begin" );
    self endon( #"disconnect" );
    
    if ( level.var_f1f1f28ea8c0f26b )
    {
        return;
    }
    
    while ( level.ingraceperiod > 15 )
    {
        waitframe();
    }
    
    if ( !isdefined( level.infilvotiming ) && game_utility_mp::teamhasinfil( self.team ) && game[ "roundsPlayed" ] == 0 )
    {
        level.infilvotiming = 1;
    }
    
    if ( isdefined( game[ "trial" ][ "tries_remaining" ] ) && game[ "trial" ][ "tries_remaining" ] < 3 )
    {
        return;
    }
    
    waiting = !flags::gameflag( "prematch_done" ) && ( !game_utility_mp::isroundbased() || game_utility_mp::isfirstround() );
    
    if ( waiting )
    {
        thread waitcountdown();
        
        for ( ;; )
        {
            self waittill( #"luinotifyserver", result, value );
            
            if ( result == "matchReady" )
            {
                break;
            }
        }
    }
    
    if ( level.infilvotiming )
    {
        flags::gameflagwait( "prematch_done" );
        wait 1.5;
    }
    
    if ( isdefined( level.var_e4b03a4f3e97879c ) && self [[ level.var_e4b03a4f3e97879c ]]() )
    {
    }
    else if ( dialog_utility::dialogueexists( level.gametypebundle.var_65ea12d03ffef6, self.team ) )
    {
        dialog::leaderdialogonplayer( level.gametypebundle.var_65ea12d03ffef6, "gametype" );
    }
    else if ( game_utility::function_ae97372c83da7acc() && dialog_utility::dialogueexists( #"gametype_hc", self.team ) )
    {
        dialog::leaderdialogonplayer( #"gametype_hc", "gametype" );
    }
    else
    {
        dialog::leaderdialogonplayer( #"gametype", "gametype" );
    }
    
    flags::gameflagwait( "prematch_done" );
    waitframe();
    
    if ( level.var_509a9886b23b4c1e )
    {
        wait 3.5;
    }
    
    if ( getdvarint( @"hash_ae1f081d4f476460", 1 ) )
    {
        waitframe();
    }
    
    if ( isdefined( level.var_813f2ea1f9452bdb ) && self [[ level.var_813f2ea1f9452bdb ]]() )
    {
    }
    else
    {
        var_9d9ab8312a195e24 = 0;
        
        if ( level.gametypebundle.var_2ed05df4c72ab823 && dialog_utility::dialogueexists( #"generic_boost", self.team ) )
        {
            var_9d9ab8312a195e24 = randomint( 100 ) > 50;
        }
        
        if ( var_9d9ab8312a195e24 )
        {
            dialog::leaderdialogonplayer( #"generic_boost", "introboost" );
        }
        else if ( self.team == game[ "attackers" ] )
        {
            dialog::leaderdialogonplayer( #"offense_obj", "introboost" );
        }
        else
        {
            dialog::leaderdialogonplayer( #"defense_obj", "introboost" );
        }
    }
    
    flags::gameflagset( "intro_boost_vo_done" );
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0xec48c0af, Offset: 0x18ce
// Size: 0x5d
function watchhostmigration()
{
    self endon( #"disconnect" );
    level endon( #"grace_period_ending" );
    
    while ( true )
    {
        level waittill( #"host_migration_begin" );
        var_4b8f91dea101926c = level.ingraceperiod;
        level waittill( #"host_migration_end" );
        
        if ( var_4b8f91dea101926c )
        {
            thread dointro();
        }
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x62372643, Offset: 0x1933
// Size: 0x77
function onlastalive()
{
    level endon( #"game_ended" );
    level waittill( #"last_alive", player );
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "siege" )
    {
        player dialog::leaderdialogonplayer( "siege_lastalive_zones" );
        level thread onlastalive();
        return;
    }
    
    if ( !overlord::playevent( "player_last_man_standing", player ) )
    {
        player dialog::leaderdialogonplayer( "last_alive" );
    }
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0x8c3aac0a, Offset: 0x19b2
// Size: 0x207
function onroundswitch()
{
    level waittill( #"round_switch", switchtype );
    
    switch ( switchtype )
    {
        case #"hash_f7af050de10a5685":
            foreach ( player in level.players )
            {
                if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
                {
                    continue;
                }
                
                player dialog::leaderdialogonplayer( "halftime" );
            }
            
            break;
        case #"hash_4a79ea9678ed059e":
            foreach ( player in level.players )
            {
                if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
                {
                    continue;
                }
                
                player dialog::leaderdialogonplayer( "overtime" );
            }
            
            break;
        default:
            if ( level.switchedsides )
            {
                foreach ( player in level.players )
                {
                    if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
                    {
                        continue;
                    }
                    
                    player dialog::leaderdialogonplayer( "side_switch" );
                }
                
                break;
            }
            
            break;
    }
}

// Namespace namespace_cef36d7634533c06
// Params 1
// Checksum 0x459b3a95, Offset: 0x1bc1
// Size: 0x298
function roundwinnerdialog( params )
{
    if ( level.var_71e380fabc40f094 || !level.teambased || params.lastround )
    {
        return;
    }
    
    winner = params.winner;
    
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    wait 1;
    
    if ( game[ "practiceRound" ] )
    {
        dialog::leaderdialogonplayers( #"gamestate_practice_over", level.players );
        return;
    }
    
    if ( team_utility::isgameplayteam( winner ) )
    {
        var_a9c4bf72e4bfe152 = #"round_success";
        
        if ( level.var_f49b7901d4911e49 )
        {
            var_a9c4bf72e4bfe152 = #"round_win_elimination";
            level.var_f49b7901d4911e49 = undefined;
        }
        
        if ( game[ "previousWinningTeam" ] === winner )
        {
            game[ "roundWinStreak" ]++;
            
            switch ( game[ "roundWinStreak" ] )
            {
                case 2:
                    var_a9c4bf72e4bfe152 = #"round_win_streak_2";
                    break;
                case 3:
                    var_a9c4bf72e4bfe152 = #"round_win_streak_3";
                    break;
                case 4:
                    var_a9c4bf72e4bfe152 = #"round_win_streak_4";
                    break;
                case 5:
                    var_a9c4bf72e4bfe152 = #"round_win_streak_5";
                    break;
                case 6:
                    var_a9c4bf72e4bfe152 = #"round_win_streak_6";
                    break;
                case 7:
                    var_a9c4bf72e4bfe152 = #"round_win_streak_7";
                    break;
                case 8:
                    var_a9c4bf72e4bfe152 = #"round_win_streak_8";
                    break;
                default:
                    break;
            }
        }
        else
        {
            if ( game[ "roundWinStreak" ] >= 3 )
            {
                var_a9c4bf72e4bfe152 = #"hash_e2ec1473a41abbe5";
            }
            
            game[ "roundWinStreak" ] = 1;
        }
        
        foreach ( entry in level.teamnamelist )
        {
            if ( entry == winner )
            {
                dialog::leaderdialog( var_a9c4bf72e4bfe152, entry );
                continue;
            }
            
            dialog::leaderdialog( #"round_failure", entry );
        }
        
        game[ "previousWinningTeam" ] = winner;
        return;
    }
    
    dialog::leaderdialogonplayers( #"round_draw", level.players );
    game[ "roundWinStreak" ] = 0;
    game[ "previousWinningTeam" ] = winner;
}

// Namespace namespace_cef36d7634533c06
// Params 2
// Checksum 0x625cd843, Offset: 0x1e61
// Size: 0xbb
function function_a7e13500a858f714( soundevent, players )
{
    if ( !isdefined( players ) )
    {
        return;
    }
    
    waittime = getdvarfloat( @"hash_9c4c6f9cf6cd83ba", 2 );
    wait waittime;
    
    foreach ( player in players )
    {
        if ( battlechatter_mp::function_4a48202831f79c92( player, soundevent ) )
        {
            player thread battlechatter_mp::dosound( soundevent );
        }
    }
}

// Namespace namespace_cef36d7634533c06
// Params 1
// Checksum 0x2e34e2bc, Offset: 0x1f24
// Size: 0x328
function gamewinnerdialog( params )
{
    winner = params.winner;
    
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    if ( isbrgamemode() )
    {
        return;
    }
    
    if ( level.var_697ba496dd069d1b )
    {
        return;
    }
    
    wait 1;
    
    if ( !level.teambased )
    {
        if ( isplayer( winner ) )
        {
            winningplayers = [];
            losingplayers = [];
            
            for ( i = 0; i < level.placement[ "all" ].size ; i++ )
            {
                player = level.placement[ "all" ][ i ];
                
                if ( i < 3 )
                {
                    player dialog::leaderdialogonplayer( #"mission_success" );
                    winningplayers[ winningplayers.size ] = player;
                    continue;
                }
                
                player dialog::leaderdialogonplayer( #"mission_failure" );
                losingplayers[ losingplayers.size ] = player;
            }
            
            thread function_a7e13500a858f714( #"bc_gamestatus_boostwin", winningplayers );
            thread function_a7e13500a858f714( #"bc_gamestatus_boostloss", losingplayers );
        }
        else
        {
            dialog::leaderdialogonplayers( #"mission_draw", level.players );
            thread function_a7e13500a858f714( #"bc_gamestatus_boostdraw", level.players );
        }
        
        return;
    }
    
    if ( team_utility::isgameplayteam( winner ) )
    {
        var_a9c4bf72e4bfe152 = #"mission_success";
        
        if ( team_utility::isgameplayteam( game[ "previousWinningTeam" ] ) && game[ "previousWinningTeam" ] != winner && dialog_utility::dialogueexists( #"gamestate_win_comeback", winner ) )
        {
            if ( game[ "roundWinStreak" ] >= 3 )
            {
                var_a9c4bf72e4bfe152 = #"gamestate_win_comeback";
            }
        }
        
        winningplayers = [];
        losingplayers = [];
        
        foreach ( entry in level.teamnamelist )
        {
            players = teams::getteamdata( entry, "players" );
            
            if ( entry == winner )
            {
                winningplayers = players;
                dialog::leaderdialogonplayers( var_a9c4bf72e4bfe152, players );
                continue;
            }
            
            foreach ( player in players )
            {
                player dialog::leaderdialogonplayer( #"mission_failure" );
                losingplayers[ losingplayers.size ] = player;
            }
        }
        
        thread function_a7e13500a858f714( #"bc_gamestatus_boostwin", winningplayers );
        thread function_a7e13500a858f714( #"bc_gamestatus_boostloss", losingplayers );
        return;
    }
    
    dialog::leaderdialogonplayers( #"mission_draw", level.players );
    thread function_a7e13500a858f714( #"bc_gamestatus_boostdraw", level.players );
}

// Namespace namespace_cef36d7634533c06
// Params 0
// Checksum 0xa3951b5b, Offset: 0x2254
// Size: 0x403
function match_ending_soon_dialog()
{
    level endon( #"game_ended" );
    level waittill( #"match_ending_soon", reason );
    assert( isdefined( reason ) );
    
    if ( level.teambased )
    {
        winningteam = gamescore::gethighestscoringteam();
        
        if ( reason == "time" && !level.gametypebundle.var_2c9c51a20edb7cfc )
        {
            foreach ( team in level.teamnamelist )
            {
                if ( team == winningteam )
                {
                    dialog::leaderdialog( #"winning_time", team );
                    continue;
                }
                
                dialog::leaderdialog( #"losing_time", team );
            }
        }
        else if ( level.roundlimit == 1 )
        {
            foreach ( team in level.teamnamelist )
            {
                if ( team == winningteam )
                {
                    dialog::leaderdialog( #"winning_score", team );
                    continue;
                }
                
                dialog::leaderdialog( #"losing_score", team );
            }
        }
        else if ( winningteam == "tie" )
        {
            dialog::leaderdialogonplayers( #"round_end_drawing", level.players );
        }
        else if ( game[ "finalRound" ] )
        {
            foreach ( team in level.teamnamelist )
            {
                if ( team == winningteam )
                {
                    dialog::leaderdialog( #"hash_3e97b02d28240f59", team );
                    continue;
                }
                
                dialog::leaderdialog( #"hash_26b4d59a1af19c61", team );
            }
        }
        else
        {
            foreach ( team in level.teamnamelist )
            {
                if ( team == winningteam )
                {
                    dialog::leaderdialog( #"round_end_winning", team );
                    continue;
                }
                
                dialog::leaderdialog( #"round_end_losing", team );
            }
        }
        
        return;
    }
    
    winningplayer = gamescore::gethighestscoringplayer();
    losingplayers = gamescore::getlosingplayers();
    
    if ( isdefined( winningplayer ) )
    {
        if ( reason == "time" )
        {
            winningplayer dialog::leaderdialogonplayer( #"winning_time" );
            dialog::leaderdialogonplayers( #"losing_time", losingplayers );
            return;
        }
        
        if ( reason == "score" )
        {
            if ( level.roundlimit == 1 )
            {
                winningplayer dialog::leaderdialogonplayer( #"winning_score" );
                dialog::leaderdialogonplayers( #"losing_score", losingplayers );
                return;
            }
            
            if ( game[ "finalRound" ] )
            {
                winningplayer dialog::leaderdialogonplayer( #"hash_3e97b02d28240f59" );
                dialog::leaderdialogonplayers( #"hash_26b4d59a1af19c61", losingplayers );
                return;
            }
            
            winningplayer dialog::leaderdialogonplayer( #"round_end_winning" );
            dialog::leaderdialogonplayers( #"round_end_losing", losingplayers );
        }
    }
}

// Namespace namespace_cef36d7634533c06
// Params 2
// Checksum 0xcb095bef, Offset: 0x265f
// Size: 0x1a9, Type: bool
function matchendingsoonleaderdialog( dialog, timeleftint )
{
    if ( game_utility::getgametype() == "arena" )
    {
        if ( isdefined( timeleftint ) && !isdefined( level.notifiedtimesup ) && timeleftint <= 11 )
        {
            level.notifiedtimesup = 1;
            dialog = #"timesup_ten";
        }
        else if ( game[ "isLaunchChunk" ] )
        {
            if ( game[ "launchChunkRuleSet" ] == 1 || game[ "launchChunkRuleSet" ] == 2 )
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    
    if ( level.teambased )
    {
        foreach ( team in level.teamnamelist )
        {
            if ( team != "spectator" )
            {
                dialog::leaderdialog( dialog, team );
            }
        }
    }
    else
    {
        foreach ( player in level.players )
        {
            if ( player.team != "spectator" )
            {
                player dialog::leaderdialogonplayer( dialog );
            }
        }
    }
    
    return true;
}

