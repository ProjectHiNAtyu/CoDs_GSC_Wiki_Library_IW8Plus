// scripts\mp\music_mp.gsc  (hash_2d8ad2720f7c12db.gscc) (size: 13645 Bytes / 0x354d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33b8f986 (867760518)
// size ...... 13645 (0x354d)
// includes .. 9   (offset: 0x329d)
// strings ... 36  (offset: 0x32e5)
// dev strs .. 2   (offset: 0x3535)
// exports ... 40  (offset: 0x216d)
// cseg ...... 0x1fc + 0x1f71 (0x216d)
// imports ... 82  (offset: 0x27ad)
// animtree1 . 0   (offset: 0x354d)
// animtree2 . 0   (offset: 0x354d)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\flags;
#using scripts\mp\gamescore;

#namespace music_mp;

// Namespace music_mp
// Params 0
// Checksum 0xe4a3695e, Offset: 0x21a
// Size: 0x1c1
function init()
{
    level musicbank_utility::init_musicbanks();
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_death", &on_player_death );
    level callback::add( #"player_spawned", &on_player_spawn );
    level callback::add( #"prematch_done", &on_prematch_done );
    level callback::add( #"infil_start", &on_infil_start );
    level callback::add( #"hash_46734d7f98d5f72a", &function_3777beb83196e76d );
    level callback::add( #"music_potg_killcam", &on_potg_killcam );
    level callback::add( #"round_end_music", &on_round_end );
    level callback::add( #"music_player_spectating", &on_player_spectating );
    level callback::add( #"hash_b233ef33659b25b5", &function_3007cc30887204ef );
    level callback::add( #"hash_1beecfc58b54378c", &function_805ed62c33e4dc1a );
    level callback::add( #"music_event", &function_e104290e18765e07 );
    
    if ( level.gamemodebundle.var_fb977546ef42feb7 || level.gametypebundle.var_fb977546ef42feb7 )
    {
        level.nosuspensemusic = 1;
    }
    
    if ( level.gametypebundle.var_9dc53e03d927322e || level.gamemodebundle.var_9dc53e03d927322e )
    {
        level callback::add( #"killstreak_begin_use", &on_player_killstreak_use );
        level callback::add( #"killstreak_finish_use", &function_e8522f92d63f0c2d );
        level callback::add( #"hash_7312312df44f3dc7", &function_e8522f92d63f0c2d );
    }
    
    level thread musiccontroller();
}

// Namespace music_mp
// Params 1
// Checksum 0x3d3ab74b, Offset: 0x3e3
// Size: 0x78
function on_player_connect( params )
{
    musicpack = self getplayerdata( "common", "commonCustomization", "musicbox" );
    self.musicpack = musicpack;
    musicbank_utility::function_c5abc550e9f75f30();
    thread watchhostmigration();
    self.needtoplayintro = 1;
    
    if ( game_utility::getgametype() != "dmz" )
    {
        thread function_32a861359b97e8dd();
        return;
    }
    
    self setsoundsubmix( %"hash_732b171259e1e7a4" );
}

// Namespace music_mp
// Params 1
// Checksum 0xd6263c03, Offset: 0x463
// Size: 0x23
function on_player_death( params )
{
    level musicbank_utility::function_5aca66c390aa347d( [ self ], #"mp_death" );
}

// Namespace music_mp
// Params 1
// Checksum 0xf4432582, Offset: 0x48e
// Size: 0xc4
function on_player_killstreak_use( params )
{
    if ( params.streakinfo.bundle.var_81cefa96eb9d718f )
    {
        if ( params.streakinfo.bundle.var_4d4e69bbfa70ec51 )
        {
            level musicbank_utility::function_5aca66c390aa347d( level.players, params.streakinfo.bundle.var_81cefa96eb9d718f );
            return;
        }
        
        level musicbank_utility::function_5aca66c390aa347d( [ params.streakinfo.owner ], params.streakinfo.bundle.var_81cefa96eb9d718f );
    }
}

// Namespace music_mp
// Params 1
// Checksum 0xfdea83fc, Offset: 0x55a
// Size: 0xc4
function function_e8522f92d63f0c2d( params )
{
    if ( params.streakinfo.bundle.var_81cefa96eb9d718f )
    {
        if ( params.streakinfo.bundle.var_4d4e69bbfa70ec51 )
        {
            level musicbank_utility::function_4f253fd35ec68cbc( level.players, params.streakinfo.bundle.var_81cefa96eb9d718f );
            return;
        }
        
        level musicbank_utility::function_4f253fd35ec68cbc( [ params.streakinfo.owner ], params.streakinfo.bundle.var_81cefa96eb9d718f );
    }
}

// Namespace music_mp
// Params 1
// Checksum 0xad1c02f1, Offset: 0x626
// Size: 0x41
function on_player_spawn( params )
{
    setdvarifuninitialized( @"hash_61e9133b2e499a6c", 0 );
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( self.needtoplayintro )
    {
        thread dointro();
        self.needtoplayintro = undefined;
    }
}

// Namespace music_mp
// Params 1
// Checksum 0x9ea13e80, Offset: 0x66f
// Size: 0x31
function on_player_spectating( params )
{
    if ( flags::gameflag( "prematch_done" ) )
    {
        level musicbank_utility::function_5aca66c390aa347d( [ self ], #"mp_spectate" );
    }
}

// Namespace music_mp
// Params 1
// Checksum 0x3d84f3c7, Offset: 0x6a8
// Size: 0xb3
function on_prematch_done( params )
{
    foreach ( player in level.players )
    {
        player clearsoundsubmix( %"mp_cer_prematch", 2 );
        
        if ( player.var_ea015fc665a74df3 )
        {
            player setplayermusicstate( "" );
            player.var_ea015fc665a74df3 = undefined;
        }
    }
}

// Namespace music_mp
// Params 1
// Checksum 0x5646e4d7, Offset: 0x763
// Size: 0x52
function on_round_end( params )
{
    soundsettimescalefactor( "music_lr", 0 );
    soundsettimescalefactor( "music_lsrs", 0 );
    soundsettimescalefactor( "menu_unres_2d", 0 );
    
    if ( params.lastround )
    {
        level thread function_11c279e60f657384( params );
        return;
    }
    
    level thread function_83cb45cb1c8e20f4( params );
}

// Namespace music_mp
// Params 1
// Checksum 0x83fb91c7, Offset: 0x7bd
// Size: 0x23
function on_potg_killcam( params )
{
    level musicbank_utility::function_5aca66c390aa347d( [ self ], #"mp_potg" );
}

// Namespace music_mp
// Params 1
// Checksum 0x2322ae28, Offset: 0x7e8
// Size: 0x23
function function_3777beb83196e76d( params )
{
    level musicbank_utility::function_5aca66c390aa347d( [ self ], #"hash_19375b96e664b086" );
}

// Namespace music_mp
// Params 1
// Checksum 0x1f8a01ba, Offset: 0x813
// Size: 0x15a
function function_e104290e18765e07( params )
{
    if ( !isdefined( params ) )
    {
        return;
    }
    
    eventtype = params.event_type ?? #"";
    team = params.team ?? "";
    
    switch ( eventtype )
    {
        case #"midpoint":
            level thread midpoint_music( team );
            break;
        case #"hash_25d3360569c20580":
            level thread function_20d4f7ceac130a5e( team );
            break;
        case #"hq_deact":
            level thread headquarters_deactivate_music( team );
            break;
        case #"hq_cap":
            level thread headquarters_captured_music();
            break;
        case #"hq_new":
            level thread headquarters_newhq_music();
            break;
        case #"timelimit":
            level thread timelimitmusic( team );
        case #"bomb_planted":
            level thread bombplanted_music();
            break;
        case #"overtime":
            level thread function_37fbef08acd408ba();
            break;
        case #"dominating":
            level thread dominating_music( team );
            break;
        case #"control_point_captured":
            level thread control_point_captured();
            break;
        default:
            break;
    }
}

// Namespace music_mp
// Params 1
// Checksum 0x4bc56a7a, Offset: 0x975
// Size: 0x85
function on_infil_start( params )
{
    foreach ( player in level.players )
    {
        player thread function_3afb6eaa3b8e17d6();
    }
}

// Namespace music_mp
// Params 1
// Checksum 0x40bd422a, Offset: 0xa02
// Size: 0x26
function function_3007cc30887204ef( params )
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_9f70a562ef634b2c" );
}

// Namespace music_mp
// Params 1
// Checksum 0x6fd09d15, Offset: 0xa30
// Size: 0x11
function function_805ed62c33e4dc1a( params )
{
    clearmusicstate();
}

// Namespace music_mp
// Params 0
// Checksum 0xf02c781b, Offset: 0xa49
// Size: 0xd4
function function_32a861359b97e8dd()
{
    if ( level.ingraceperiod <= 5 || flags::gameflag( "prematch_done" ) )
    {
        if ( musicbank_utility::function_cf0583320b8b0d2( #"hash_2ff12c47390a6538" ) )
        {
            level musicbank_utility::function_5aca66c390aa347d( [ self ], #"hash_2ff12c47390a6538" );
        }
        else
        {
            self setplayermusicstate( "" );
        }
        
        return;
    }
    
    if ( game_utility_mp::isroundbased() && !game_utility_mp::isfirstround() || game_utility::function_36ce69a7be195555() )
    {
        if ( musicbank_utility::function_cf0583320b8b0d2( #"hash_2ff12c47390a6538" ) )
        {
            level musicbank_utility::function_5aca66c390aa347d( [ self ], #"hash_2ff12c47390a6538" );
        }
        else
        {
            self setplayermusicstate( "" );
        }
        
        return;
    }
    
    self.var_ea015fc665a74df3 = 1;
    level musicbank_utility::function_5aca66c390aa347d( [ self ], #"mp_prematch_loop" );
}

// Namespace music_mp
// Params 0
// Checksum 0xa8234a74, Offset: 0xb25
// Size: 0xab
function dointro()
{
    level endon( #"game_ended" );
    level endon( #"host_migration_begin" );
    self endon( #"disconnect" );
    
    while ( level.ingraceperiod > 15 )
    {
        waitframe();
    }
    
    if ( isdefined( game[ "trial" ][ "tries_remaining" ] ) && game[ "trial" ][ "tries_remaining" ] < 3 )
    {
        return;
    }
    
    waiting = !flags::gameflag( "prematch_done" ) && ( !game_utility_mp::isroundbased() || game_utility_mp::isfirstround() );
    
    if ( waiting )
    {
        thread prematch_music();
        return;
    }
    
    if ( game_utility_mp::isroundbased() )
    {
        thread function_a391b2bab38a455f();
    }
}

// Namespace music_mp
// Params 1
// Checksum 0xf5c8468e, Offset: 0xbd8
// Size: 0xed
function function_3afb6eaa3b8e17d6( submix_override )
{
    self endon( #"disconnect" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( submix_override ) )
    {
        self.submix = submix_override;
    }
    else
    {
        var_1de29f483a185a21 = [];
        var_1de29f483a185a21[ var_1de29f483a185a21.size ] = #"mp_infil_mix_musicheavy";
        var_1de29f483a185a21[ var_1de29f483a185a21.size ] = #"mp_infil_mix_normal";
        var_18c9fa8ddd4daeee = var_1de29f483a185a21.size;
        var_8417a1e7c9a34056 = randomint( var_18c9fa8ddd4daeee );
        self.submix = var_1de29f483a185a21[ var_8417a1e7c9a34056 ];
    }
    
    if ( isdefined( self.team ) && self.team != "spectator" )
    {
        level musicbank_utility::function_5aca66c390aa347d( [ self ], #"mp_infil" );
        self.playedinfilmusic = 1;
        wait 15;
        
        if ( isent( self ) && isplayer( self ) )
        {
            self clearclienttriggeraudiozone( 3 );
            return;
        }
        
        return;
    }
}

// Namespace music_mp
// Params 0
// Checksum 0x4ba03ee3, Offset: 0xccd
// Size: 0x16a
function prematch_music()
{
    self endon( #"disconnect" );
    
    if ( flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    level waittill( #"prematch_music" );
    thread function_2ad783366e5d034c();
    spawnevent = #"mp_spawn";
    
    if ( level.gametypebundle.var_880df132bb53af05 )
    {
        spawnevent = #"spawn_short";
    }
    
    if ( game_utility::function_36ce69a7be195555() )
    {
        spawnevent = #"mp_dominated";
        return;
    }
    
    if ( !level.splitscreen && !isdefined( self.playedinfilmusic ) || level.splitscreen && !isdefined( level.playedstartingmusic ) )
    {
        if ( !self issplitscreenplayer() || self issplitscreenplayerprimary() )
        {
            if ( isdefined( self.team ) && self.team != "spectator" )
            {
                if ( isdefined( game[ "roundsPlayed" ] ) )
                {
                    if ( game[ "roundsPlayed" ] == 0 )
                    {
                        self.var_ea015fc665a74df3 = 0;
                        level musicbank_utility::function_5aca66c390aa347d( [ self ], spawnevent );
                    }
                }
                else
                {
                    self.var_ea015fc665a74df3 = 0;
                    level musicbank_utility::function_5aca66c390aa347d( [ self ], spawnevent );
                }
                
                self.nosuspensemusic = 1;
            }
            
            self.nosuspensemusic = 1;
            
            if ( level.splitscreen )
            {
                level.playedstartingmusic = 1;
            }
        }
        
        thread suspensemusic_reset( 20 );
    }
}

// Namespace music_mp
// Params 0
// Checksum 0xa896c443, Offset: 0xe3f
// Size: 0x4e
function function_a391b2bab38a455f()
{
    if ( game[ "finalRound" ] == 1 || game[ "matchPoint" ] == 1 )
    {
        level musicbank_utility::function_5aca66c390aa347d( [ self ], #"hash_7aebc6f3970b01a7" );
        return;
    }
    
    level musicbank_utility::function_5aca66c390aa347d( [ self ], #"hash_ad051d32e3eb8528" );
}

// Namespace music_mp
// Params 0
// Checksum 0x7a308914, Offset: 0xe95
// Size: 0x49
function function_2ad783366e5d034c()
{
    if ( level.gamemodebundle.var_47cea81786439249 == 1 )
    {
        if ( function_4042d2fbe6237835( #"hash_6f8a4c5f8017df10" ) )
        {
            return;
        }
        
        if ( self.var_ea015fc665a74df3 == 1 )
        {
            self setplayermusicstate( "" );
        }
    }
}

// Namespace music_mp
// Params 0
// Checksum 0xdaeeea17, Offset: 0xee6
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

// Namespace music_mp
// Params 1
// Checksum 0xdaae4a6f, Offset: 0xf4b
// Size: 0x358
function function_11c279e60f657384( params )
{
    var_7253048b0052f177 = params.winner;
    participantplayers = params.participantplayers;
    
    if ( !isdefined( var_7253048b0052f177 ) || isdefined( level.endmusicplayed ) )
    {
        return;
    }
    
    if ( isbrgamemode() && game_utility::getgametype() != "plunder" )
    {
        return;
    }
    
    if ( musicbank_utility::is_music_disabled_globally() )
    {
        return;
    }
    else if ( level.teambased )
    {
        foreach ( player in participantplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
            {
                continue;
            }
            
            player damage_effects::function_e8cba6f10a4635e9();
            player setsoundsubmix( "mp_matchend_music", 2 );
            
            if ( isstring( var_7253048b0052f177 ) && var_7253048b0052f177 == "tie" )
            {
                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_draw" );
                continue;
            }
            
            if ( var_7253048b0052f177 == player.team )
            {
                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_victory" );
                continue;
            }
            
            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_defeat" );
        }
    }
    else
    {
        if ( !isdefined( level.var_29c1e82ec1325523 ) && participantplayers.size > 3 )
        {
            assert( isdefined( level.placement[ "<dev string:x24>" ] ), "<dev string:x28>" );
            var_f03c2cbd32b9f2b6 = utility::array_slice( level.placement[ "all" ], 0, 3 );
        }
        
        foreach ( player in participantplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            iswinner = isdefined( level.var_29c1e82ec1325523 ) && [[ level.var_29c1e82ec1325523 ]]( player );
            player damage_effects::function_e8cba6f10a4635e9();
            player setsoundsubmix( "mp_matchend_music", 2 );
            player setplayermusicstate( "" );
            
            if ( player issplitscreenplayer() && !player issplitscreenplayerprimary() )
            {
                continue;
            }
            
            if ( isstring( var_7253048b0052f177 ) && ( var_7253048b0052f177 == "tie" || var_7253048b0052f177 == "none" ) )
            {
                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_draw" );
                continue;
            }
            
            if ( iswinner || !isstring( var_7253048b0052f177 ) && var_7253048b0052f177 == player || isdefined( var_f03c2cbd32b9f2b6 ) && arraycontains( var_f03c2cbd32b9f2b6, player ) )
            {
                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_victory" );
                continue;
            }
            
            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_defeat" );
        }
    }
    
    level.endmusicplayed = 1;
}

// Namespace music_mp
// Params 1
// Checksum 0xe2a9d4c8, Offset: 0x12ab
// Size: 0xd1
function midpoint_music( winning_team )
{
    thread stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        if ( winning_team == player.team )
        {
            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_midpoint_winning" );
            continue;
        }
        
        level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_midpoint_losing" );
    }
    
    wait 25;
    thread suspensemusic();
}

// Namespace music_mp
// Params 1
// Checksum 0xb00f8186, Offset: 0x1384
// Size: 0xf6
function dominating_music( dominating_team )
{
    if ( level.dominating_music == 1 )
    {
        return;
    }
    
    thread stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        if ( dominating_team == player.team )
        {
            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_dominating" );
            continue;
        }
        
        level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_dominated" );
    }
    
    level.dominating_music = 1;
    wait 25;
    level.dominating_music = 0;
    thread suspensemusic();
}

// Namespace music_mp
// Params 0
// Checksum 0x9518d493, Offset: 0x1482
// Size: 0x1c
function control_point_captured()
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_cc890a2b957868cc" );
}

// Namespace music_mp
// Params 0
// Checksum 0x6cfde3f7, Offset: 0x14a6
// Size: 0x96
function bombplanted_music()
{
    if ( level.bombtimer > 44 )
    {
        waittime = level.bombtimer - 45;
        wait waittime;
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_bombplant" );
    }
    else if ( isdefined( level.bombtimer ) )
    {
        waittime = level.bombtimer - 30;
        
        if ( waittime < 0 )
        {
            waittime = 0;
        }
        
        wait waittime;
        level musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_bombplant30" );
    }
    
    level.bombplanted_music = 1;
}

// Namespace music_mp
// Params 0
// Checksum 0xe0e18939, Offset: 0x1544
// Size: 0x407
function musiccontroller()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.musicenabled ) )
    {
        level.musicenabled = 1;
    }
    
    thread suspensemusic();
    level waittill( #"match_ending_soon", reason );
    assert( isdefined( reason ) );
    
    if ( level.roundlimit == 1 || game[ "roundsPlayed" ] == level.roundlimit - 1 || level.gametypebundle.scoringstrategy == #"teamscores" )
    {
        if ( !level.splitscreen )
        {
            if ( reason == "time" )
            {
                if ( level.teambased )
                {
                    if ( game[ "teamScores" ][ "allies" ] > game[ "teamScores" ][ "axis" ] )
                    {
                        thread timelimitmusic( "allies" );
                    }
                    else if ( game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] )
                    {
                        thread timelimitmusic( "axis" );
                    }
                    else
                    {
                        thread timelimitmusic( "draw" );
                    }
                }
                else
                {
                    level musicbank_utility::function_5aca66c390aa347d( level.players, "mp_timesup_winning" );
                }
            }
            else if ( reason == "score" )
            {
                if ( level.teambased && game_utility::getgametype() != "arena" )
                {
                    if ( game[ "teamScores" ][ "allies" ] > game[ "teamScores" ][ "axis" ] )
                    {
                        foreach ( player in level.players )
                        {
                            if ( player.team == "allies" )
                            {
                                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_round_winning" );
                                continue;
                            }
                            
                            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_round_losing" );
                        }
                    }
                    else if ( game[ "teamScores" ][ "axis" ] > game[ "teamScores" ][ "allies" ] )
                    {
                        foreach ( player in level.players )
                        {
                            if ( player.team == "allies" )
                            {
                                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_round_losing" );
                                continue;
                            }
                            
                            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_round_winning" );
                        }
                    }
                }
                else
                {
                    winningplayer = gamescore::gethighestscoringplayer();
                    losingplayers = gamescore::getlosingplayers();
                    excludelist[ 0 ] = winningplayer;
                    
                    foreach ( player in level.players )
                    {
                        if ( winningplayer.pers[ "team" ] == player.team )
                        {
                            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_round_winning" );
                            continue;
                        }
                        
                        level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_round_losing" );
                    }
                }
            }
        }
        
        return;
    }
    
    if ( game_utility::getgametype() != "arena" )
    {
        clearmusicstate();
    }
}

// Namespace music_mp
// Params 1
// Checksum 0x1750584d, Offset: 0x1953
// Size: 0xe7
function timelimitmusic( team )
{
    self endon( #"game_ended" );
    level notify( #"hash_94e235a6ed948fda" );
    
    if ( game_utility::getgametype() != "arena" )
    {
        foreach ( player in level.players )
        {
            if ( team == player.team )
            {
                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_timesup_winning" );
                continue;
            }
            
            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_timesup_losing" );
        }
    }
}

// Namespace music_mp
// Params 0
// Checksum 0x5c2a36f7, Offset: 0x1a42
// Size: 0x23
function headquarters_newhq_music()
{
    stopsuspensemusic();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_hq_new" );
}

// Namespace music_mp
// Params 0
// Checksum 0x5f1fe959, Offset: 0x1a6d
// Size: 0x47
function headquarters_captured_music()
{
    level endon( #"hash_b6ab8f06828835fb" );
    stopsuspensemusic();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_captured" );
    level.hq_captured_music = 1;
    wait 60;
    level.hq_captured_music = 0;
}

// Namespace music_mp
// Params 1
// Checksum 0xa0eec69e, Offset: 0x1abc
// Size: 0xe9
function headquarters_deactivate_music( claimteam )
{
    stopsuspensemusic();
    
    if ( level.hq_captured_music )
    {
        level notify( #"hash_b6ab8f06828835fb" );
        level.hq_captured_music = 0;
        
        foreach ( player in level.players )
        {
            if ( claimteam == player.team )
            {
                level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_destroyed_pos" );
                continue;
            }
            
            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_destroyed_neg" );
        }
    }
}

// Namespace music_mp
// Params 1
// Checksum 0x2e938c3b, Offset: 0x1bad
// Size: 0xc7
function function_20d4f7ceac130a5e( claimteam )
{
    stopsuspensemusic();
    
    foreach ( player in level.players )
    {
        if ( claimteam == player.team )
        {
            level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_destroyed_pos" );
            continue;
        }
        
        level musicbank_utility::function_5aca66c390aa347d( [ player ], #"mp_destroyed_neg" );
    }
}

// Namespace music_mp
// Params 1
// Checksum 0xfa51ded9, Offset: 0x1c7c
// Size: 0x8d
function suspensemusic( var_6bd46b1c763f6812 )
{
    if ( musicbank_utility::is_music_disabled_globally() )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level endon( #"match_ending_soon" );
    level endon( #"hash_94e235a6ed948fda" );
    
    if ( level.nosuspensemusic )
    {
        return;
    }
    
    if ( var_6bd46b1c763f6812 )
    {
        wait 120;
    }
    
    for ( ;; )
    {
        wait randomfloatrange( 75, 120 );
        
        if ( level.nosuspensemusic )
        {
            return;
        }
        
        if ( !game[ "inLiveLobby" ] )
        {
            level musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_suspense" );
        }
    }
}

// Namespace music_mp
// Params 1
// Checksum 0xef47a163, Offset: 0x1d11
// Size: 0x19
function suspensemusic_reset( waittime )
{
    wait waittime;
    self.nosuspensemusic = undefined;
}

// Namespace music_mp
// Params 0
// Checksum 0xcd25a431, Offset: 0x1d32
// Size: 0x23
function stopsuspensemusic()
{
    level notify( #"hash_94e235a6ed948fda" );
    
    if ( level.cursuspsensetrack.size == 2 )
    {
        clearmusicstate();
    }
}

// Namespace music_mp
// Params 1
// Checksum 0xd2f24ccc, Offset: 0x1d5d
// Size: 0x2cb
function function_83cb45cb1c8e20f4( params )
{
    var_7253048b0052f177 = params.winner;
    participantplayers = params.participantplayers;
    
    if ( isdefined( level.endmusicplayed ) )
    {
        return;
    }
    
    musicroundwin = #"mp_round_win";
    var_7b9001fea81bcdd2 = #"mp_round_loss";
    var_9861cdb6ab27a9ed = #"mp_round_draw";
    
    if ( level.gametypebundle.var_ad61a5174639fafa )
    {
        roundtype = level function_b520991b5ae2d81();
        musicroundwin = hashcat( musicroundwin, "_", roundtype );
        var_7b9001fea81bcdd2 = hashcat( var_7b9001fea81bcdd2, "_", roundtype );
        var_9861cdb6ab27a9ed = hashcat( var_9861cdb6ab27a9ed, "_", roundtype );
        
        if ( game[ "roundsPlayed" ] % 2 == 0 )
        {
            var_c60aa78d161ac4d3 = level.gametypebundle.var_503ab72b4a37f6e8;
            
            if ( isdefined( var_c60aa78d161ac4d3 ) )
            {
                if ( function_4042d2fbe6237835( #"hash_956235e48e74805" ) )
                {
                    var_c60aa78d161ac4d3 = undefined;
                }
                
                if ( isdefined( var_c60aa78d161ac4d3 ) )
                {
                    musicroundwin = hashcat( musicroundwin, var_c60aa78d161ac4d3 );
                    var_7b9001fea81bcdd2 = hashcat( var_7b9001fea81bcdd2, var_c60aa78d161ac4d3 );
                }
            }
        }
    }
    
    if ( level.halftimetype == "halftime" && level.roundlimit && game[ "roundsPlayed" ] * 2 == level.roundlimit )
    {
        level musicbank_utility::function_5aca66c390aa347d( participantplayers, #"mp_halftime" );
        return;
    }
    
    if ( level.playovertime )
    {
        level musicbank_utility::function_5aca66c390aa347d( participantplayers, #"mp_halftime" );
        return;
    }
    
    if ( level.halftimetype == "halftime" && !level.roundlimit )
    {
        foreach ( player in participantplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isstring( var_7253048b0052f177 ) )
            {
                if ( team_utility::isgameplayteam( var_7253048b0052f177 ) )
                {
                    if ( player.team == var_7253048b0052f177 )
                    {
                        level musicbank_utility::function_5aca66c390aa347d( [ player ], musicroundwin );
                    }
                    else
                    {
                        level musicbank_utility::function_5aca66c390aa347d( [ player ], var_7b9001fea81bcdd2 );
                    }
                }
                else
                {
                    level musicbank_utility::function_5aca66c390aa347d( [ player ], var_9861cdb6ab27a9ed );
                }
                
                continue;
            }
            
            if ( player == var_7253048b0052f177 )
            {
                level musicbank_utility::function_5aca66c390aa347d( [ player ], musicroundwin );
                continue;
            }
            
            level musicbank_utility::function_5aca66c390aa347d( [ player ], var_7b9001fea81bcdd2 );
        }
        
        return;
    }
    
    level musicbank_utility::function_5aca66c390aa347d( participantplayers, var_9861cdb6ab27a9ed );
}

// Namespace music_mp
// Params 1
// Checksum 0xe1777463, Offset: 0x2030
// Size: 0x2d
function function_37fbef08acd408ba( generic )
{
    thread stopsuspensemusic();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"mp_overtime" );
}

// Namespace music_mp
// Params 0
// Checksum 0xaa7d4ec6, Offset: 0x2065
// Size: 0x107
function function_b520991b5ae2d81()
{
    musictype = "early";
    mostroundswon = 0;
    
    foreach ( entry in level.teamnamelist )
    {
        roundswon = game[ "roundsWon" ][ entry ];
        
        if ( roundswon > mostroundswon )
        {
            mostroundswon = roundswon;
        }
    }
    
    if ( mostroundswon > 0 )
    {
        perc = mostroundswon / level.winlimit;
        
        if ( perc <= 0.34 )
        {
            musictype = "early";
        }
        else if ( perc >= 0.34 && perc <= 0.67 )
        {
            musictype = "mid";
        }
        else
        {
            musictype = "late";
        }
    }
    
    return musictype;
}

