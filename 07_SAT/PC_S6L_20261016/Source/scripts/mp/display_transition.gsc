// scripts\mp\display_transition.gsc  (hash_6bcc05a06a270ad2.gscc) (size: 12807 Bytes / 0x3207 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd765a3e1 (3613762529)
// size ...... 12807 (0x3207)
// includes .. 8   (offset: 0x303b)
// strings ... 28  (offset: 0x307b)
// dev strs .. 0   (offset: 0x3207)
// exports ... 49  (offset: 0x1da7)
// cseg ...... 0x48a + 0x191d (0x1da7)
// imports ... 89  (offset: 0x254f)
// animtree1 . 0   (offset: 0x3207)
// animtree2 . 0   (offset: 0x3207)
#using scripts\common\utility;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\supers;

#namespace display_transition;

// Namespace display_transition
// Params 0, eflags: 0x1
// Checksum 0x2d82366a, Offset: 0x4a8
// Size: 0x88
function autoexec init()
{
    utility::registersharedfunc( #"display_transition", #"using_new_transitions", &using_new_transitions );
    utility::registersharedfunc( #"display_transition", #"hash_52e073a8a81a3b48", &display_round_end );
    utility::registersharedfunc( #"display_transition", #"display_match_end", &display_match_end );
    utility::registersharedfunc( #"hash_bb64c53aee1652d8", #"hash_bb64c53aee1652d8", &function_2dcc1238eeb3963 );
    display_transition_init_callbacks();
    function_eb3e12e88a73f12();
}

// Namespace display_transition
// Params 4, eflags: 0x40 variadic
// Checksum 0xe7eaee5a, Offset: 0x538
// Size: 0x9a
function function_1f300d12c354598e( players, player_func, ... )
{
    foreach ( player in players )
    {
        player [[ player_func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace display_transition
// Params 3, eflags: 0x40 variadic
// Checksum 0x8f52ed44, Offset: 0x5da
// Size: 0x98
function function_34038e3731892d22( player_func, ... )
{
    foreach ( player in level.players )
    {
        player [[ player_func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace display_transition
// Params 3, eflags: 0x40 variadic
// Checksum 0xc2df6997, Offset: 0x67a
// Size: 0x98
function function_6dd0714d57b0007( player_func, ... )
{
    foreach ( player in level.players )
    {
        player thread [[ player_func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace display_transition
// Params 4, eflags: 0x40 variadic
// Checksum 0x966289f2, Offset: 0x71a
// Size: 0xba
function function_3cded2bed4db5f8( team, player_func, ... )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.team === team )
        {
            player [[ player_func ]]( flat_args( vararg, varargcount ) );
        }
    }
}

// Namespace display_transition
// Params 3, eflags: 0x40 variadic
// Checksum 0x4ec31994, Offset: 0x7dc
// Size: 0xb1
function function_e9ddf457006bf4d( player_func, ... )
{
    foreach ( player in level.players )
    {
        if ( !isdefined( player.pers[ "team" ] ) )
        {
            continue;
        }
        
        player [[ player_func ]]( flat_args( vararg, varargcount ) );
    }
}

// Namespace display_transition
// Params 0
// Checksum 0x853c9062, Offset: 0x895
// Size: 0x72, Type: bool
function using_new_transitions()
{
    if ( getdvarint( @"hash_e980c30d148394e", 0 ) == 0 )
    {
        return false;
    }
    
    if ( isdefined( level.gametypebundle ) )
    {
        if ( !isdefined( level.gametypebundle.var_11f3a9480b9be992 ) || level.gametypebundle.var_11f3a9480b9be992.size == 0 )
        {
            return false;
        }
        else
        {
            return istrue( level.gametypebundle.var_bbf26e077339d517 );
        }
    }
    
    return true;
}

// Namespace display_transition
// Params 5, eflags: 0x4
// Checksum 0x2faf4301, Offset: 0x910
// Size: 0x72
function private execute_transition_feature( transition, outcome, feature_enabled, feature_time, func )
{
    if ( feature_enabled )
    {
        if ( transition.slowdown )
        {
            level.var_a24986eef7cbb20f = transition.var_79b2e33fb7a10288;
        }
        
        if ( ( feature_time ?? 0 ) != 0 )
        {
            wait feature_time * 0.001;
        }
        
        [[ func ]]( transition, outcome );
    }
}

// Namespace display_transition
// Params 2
// Checksum 0xbd7aa341, Offset: 0x98a
// Size: 0x81
function function_2dcc1238eeb3963( var_7e0d24a9bb7c209a, duration )
{
    transition = spawnstruct();
    transition.transitiontype = #"cinematic";
    transition.transitiontime = duration;
    transition.transitionmovie = var_7e0d24a9bb7c209a;
    level.gametypebundle.var_11f3a9480b9be992[ level.gametypebundle.var_11f3a9480b9be992.size ] = transition;
}

// Namespace display_transition
// Params 1
// Checksum 0xa03d40f3, Offset: 0xa13
// Size: 0x31
function display_match_end( outcome )
{
    if ( level.players.size == 0 )
    {
        return;
    }
    
    function_34038e3731892d22( &function_173e950d5bd89579 );
    function_624bc6735ca19661( outcome );
}

// Namespace display_transition
// Params 1
// Checksum 0x8fc4dc92, Offset: 0xa4c
// Size: 0x34
function display_round_end( outcome )
{
    function_34038e3731892d22( &function_173e950d5bd89579 );
    level thread set_round_end_music( outcome.winner );
    function_9f08ae5eed7a3fc8( outcome );
}

// Namespace display_transition
// Params 1
// Checksum 0x165c657b, Offset: 0xa88
// Size: 0x50
function set_round_end_music( winner )
{
    if ( !game_utility_mp::waslastround() )
    {
        level notify( #"round_end_music", winner );
        
        if ( isdefined( level.var_f11b83f3f5087dce ) )
        {
            level thread [[ level.var_f11b83f3f5087dce ]]();
            return;
        }
        
        return;
    }
    
    level notify( #"hash_fd59437961aec2ea", winner );
}

// Namespace display_transition
// Params 0
// Checksum 0xdc413f7f, Offset: 0xae0
// Size: 0x1a, Type: bool
function function_173e950d5bd89579()
{
    if ( !isdefined( self.pers[ "team" ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace display_transition
// Params 0, eflags: 0x4
// Checksum 0x8c026560, Offset: 0xb03
// Size: 0x24
function private function_3d4b2b479f8d6c5c()
{
    level.var_a24986eef7cbb20f = 1;
    setslowmotion( 1, 1, 0 );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x542249ac, Offset: 0xb2f
// Size: 0x3e
function private round_end_wait( time, isslowdown )
{
    if ( isslowdown )
    {
        time *= level.var_a24986eef7cbb20f;
    }
    
    logstring( "^5 END MATCH FLOW -- Round end wait... waiting " + time + "seconds" );
    wait time;
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x8ba83379, Offset: 0xb75
// Size: 0x3b
function private function_e4c9304f4217f362( transition, outcome )
{
    setslowmotion( transition.var_ca0236079128c799, transition.var_79b2e33fb7a10288, transition.var_75975ad0ae94d3c );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x7a85344e, Offset: 0xbb8
// Size: 0x43
function private function_ea8d6703f0b3669e( transition, outcome )
{
    gamelogic_mp::freezeallplayers( transition.freezetimedelay * 0.001, @"cg_fovscale", 1, transition.var_c800e8e1119a85f3 );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x3d1dc777, Offset: 0xc03
// Size: 0x15
function private function_3c8353c118a35adb( transition, outcome )
{
    
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x8a683265, Offset: 0xc20
// Size: 0x15
function private function_2a237a02ffb75f61( transition, outcome )
{
    
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0xd6ec8c61, Offset: 0xc3d
// Size: 0x15
function private function_c7a8c404d528f1a8( transition, outcome )
{
    
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x51058eaf, Offset: 0xc5a
// Size: 0x15
function private function_e55f2ca85914cd39( transition, outcome )
{
    
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x4ac2cea0, Offset: 0xc77
// Size: 0x15
function private function_30c45984ac398ee3( transition, outcome )
{
    
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x5ce9e1ac, Offset: 0xc94
// Size: 0x15
function private function_e2cd526f57bc66aa( transition, outcome )
{
    
}

// Namespace display_transition
// Params 0, eflags: 0x4
// Checksum 0x78ccc8c1, Offset: 0xcb1
// Size: 0xf
function private function_a3558f3cc5e272c5()
{
    thread [[ level.spawnintermission ]]( 0 );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0xbe648454, Offset: 0xcc8
// Size: 0xbb
function private function_3f594f90c4451179( transition, outcome )
{
    var_48de8f325b00065c = 0;
    
    foreach ( player in level.players )
    {
        if ( player islinked() )
        {
            player unlink();
            var_48de8f325b00065c = 1;
        }
    }
    
    if ( var_48de8f325b00065c )
    {
        waitframe();
    }
    
    removeallcorpses();
    function_34038e3731892d22( &function_a3558f3cc5e272c5 );
}

// Namespace display_transition
// Params 3, eflags: 0x4
// Checksum 0x9b8858c8, Offset: 0xd8b
// Size: 0x176
function private function_b8e29f183a29e1c7( transition, outcome, var_7bebdddf75ac7162 )
{
    thread execute_transition_feature( transition, outcome, transition.slowdown, transition.var_3ab508a4ae366e42, &function_e4c9304f4217f362 );
    thread execute_transition_feature( transition, outcome, transition.freezeplayers, 0, &function_ea8d6703f0b3669e );
    thread execute_transition_feature( transition, outcome, transition.announcehalftime, transition.var_f25350c8c6383228, &function_3c8353c118a35adb );
    thread execute_transition_feature( transition, outcome, transition.announcestreak, transition.var_4140cae640d649e6, &function_2a237a02ffb75f61 );
    thread execute_transition_feature( transition, outcome, transition.announceencouragement, transition.var_d3d81ab340d449df, &function_c7a8c404d528f1a8 );
    thread execute_transition_feature( transition, outcome, transition.var_bb91ae57921695dd, transition.var_d4db6d152a029d96, &function_e55f2ca85914cd39 );
    thread execute_transition_feature( transition, outcome, transition.announceendgame, transition.var_8341d5441ce63d25, &function_30c45984ac398ee3 );
    thread execute_transition_feature( transition, outcome, transition.var_7d1e86b357800f5, transition.var_da554382f2819c34, &function_e2cd526f57bc66aa );
    
    if ( !isdefined( var_7bebdddf75ac7162 ) || isdefined( var_7bebdddf75ac7162 ) && !var_7bebdddf75ac7162 )
    {
        thread execute_transition_feature( transition, outcome, transition.var_341acd8f37f80252, transition.var_dc931d94a7285dbe, &function_3f594f90c4451179 );
    }
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x4ee453a1, Offset: 0xf09
// Size: 0x57
function private function_cbcba0bf5b1aa5ce( transition, outcome )
{
    function_b8e29f183a29e1c7( transition, outcome );
    function_6dd0714d57b0007( &game_utility_mp::setuipostgamefade, 1, transition.transitiontime * 0.001, transition.transitionmovie );
    function_e9ddf457006bf4d( &function_7aec9871bba2902, outcome );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0xf6f5df80, Offset: 0xf68
// Size: 0x2ca
function private function_2b2c4923aefe809d( transition, outcome )
{
    function_6dd0714d57b0007( &game_utility_mp::setuipostgamefade, 1, transition.transitiontime * 0.001, transition.transitionmovie );
    
    if ( game[ "practiceRound" ] && !level.forcedend )
    {
        game[ "practiceRound" ] = 0;
        
        if ( level.allowsupers && !game_utility_mp::runleanthreadmode() )
        {
            foreach ( player in level.players )
            {
                player supers_mp::clearsuper();
                player perkpackage::perkpackage_reset();
            }
        }
        
        flags::levelflagclear( "block_notifies" );
    }
    else
    {
        if ( level.teambased )
        {
            foreach ( entry in level.teamnamelist )
            {
                gamescore::updatetotalteamscore( entry );
            }
        }
        
        if ( level.playovertime )
        {
            winner = "overtime";
            game[ "status" ] = "overtime";
        }
        
        flags::levelflagclear( "block_notifies" );
        shouldswitchsides = gamelogic_mp::checkroundswitch( level.playovertime );
        
        if ( shouldswitchsides )
        {
            gamelogic_mp::onroundswitch( level.playovertime );
            
            if ( shouldswitchsides || game[ "finalRound" ] == 1 || game[ "matchPoint" ] == 1 )
            {
                shoulddisplayroundswitch = 1;
                
                if ( game_utility::getgametype() == "arena" )
                {
                    if ( game[ "matchPoint" ] == 1 && !game[ "displayedMatchPoint" ] )
                    {
                        game[ "displayedMatchPoint" ] = 1;
                    }
                    else if ( game[ "finalRound" ] != 1 )
                    {
                        shoulddisplayroundswitch = 0;
                    }
                }
                else if ( game_utility::getgametype() == "ballmode" )
                {
                    shoulddisplayroundswitch = 0;
                }
                
                if ( shoulddisplayroundswitch )
                {
                    gamelogic_mp::displayroundswitch();
                    setomnvarforallclients( "post_game_state", 2 );
                    function_6dd0714d57b0007( &game_utility_mp::setuipostgamefade, 0 );
                }
            }
        }
        
        gamelogic_mp::function_23b981423fbd4d94();
        
        if ( !level.forcedend )
        {
            endreasontext = gamelogic_mp::updateroundendreasontext( winner );
        }
    }
    
    function_b8e29f183a29e1c7( transition, outcome, shoulddisplayroundswitch );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x12c55381, Offset: 0x123a
// Size: 0x63
function private function_e5df289c960b3a60( transition, outcome )
{
    function_6dd0714d57b0007( &game_utility_mp::setuipostgamefade, 1, transition.transitiontime * 0.001, transition.transitionmovie );
    flags::levelflagclear( "block_notifies" );
    gamelogic_mp::function_ccf999439b21d96b();
    gamelogic_mp::function_23b981423fbd4d94();
    function_b8e29f183a29e1c7( transition, outcome );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x8cad3d97, Offset: 0x12a5
// Size: 0x1c
function private function_d564e39e98e1bd93( transition, outcome )
{
    gamelogic_mp::endgame_showkillcam();
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0xaab7cbe4, Offset: 0x12c9
// Size: 0xe7
function private function_9ee68c56d8a4b113( transition, outcome )
{
    if ( isdefined( level.winners_circle ) )
    {
        level.doing_winners_circle = [[ level.winners_circle.init ]]( outcome.winner );
    }
    else
    {
        level.doing_winners_circle = 0;
    }
    
    if ( level.doing_winners_circle )
    {
        logstring( "^5 END MATCH FLOW -- Doing winner's circle -- TIMESTAMP: " + gettime() );
        setomnvarforallclients( "post_game_state", 6 );
        wait 0.1;
        [[ level.winners_circle.start ]]( outcome.winner );
        level waittill( #"winners_circle_end" );
        logstring( "^5 END MATCH FLOW -- Ending winner's circle -- TIMESTAMP: " + gettime() );
        [[ level.winners_circle.end ]]();
        return;
    }
    
    level notify( #"winners_circle_skipped" );
}

// Namespace display_transition
// Params 0, eflags: 0x4
// Checksum 0x9b68fdff, Offset: 0x13b8
// Size: 0x8f
function private function_33328428535ade85()
{
    wait 0.1;
    
    foreach ( player in level.players )
    {
        game_utility::fadetoblackforplayer( player, 0, 0 );
    }
    
    level notify( #"hash_7ec75468988803c2" );
}

// Namespace display_transition
// Params 2, eflags: 0x4
// Checksum 0x36be2090, Offset: 0x144f
// Size: 0x31
function private function_f1c282a40ea1a79f( transition, outcome )
{
    setomnvarforallclients( "post_game_state", 18 );
    playcinematicforall( transition.transitionmovie );
}

// Namespace display_transition
// Params 0
// Checksum 0x34385f0a, Offset: 0x1488
// Size: 0xb1
function display_transition_init_callbacks()
{
    level.display_transition_callbacks[ #"blank" ] = &function_b8e29f183a29e1c7;
    level.display_transition_callbacks[ #"outcome" ] = &function_cbcba0bf5b1aa5ce;
    level.display_transition_callbacks[ #"switch_sides" ] = &function_2b2c4923aefe809d;
    level.display_transition_callbacks[ #"next_round" ] = &function_e5df289c960b3a60;
    level.display_transition_callbacks[ #"best_play" ] = &function_d564e39e98e1bd93;
    level.display_transition_callbacks[ #"winners_circle" ] = &function_9ee68c56d8a4b113;
    level.display_transition_callbacks[ #"cinematic" ] = &function_f1c282a40ea1a79f;
}

// Namespace display_transition
// Params 3, eflags: 0x4
// Checksum 0x8b89cfed, Offset: 0x1541
// Size: 0x7c
function private function_c861f898ed384b44( transition, outcome, next_transition )
{
    if ( !level.var_5ce3242c82209034 )
    {
        setomnvarforallclients( "post_game_state", 1 );
    }
    
    if ( transition.transitiontype == #"winners_circle" && next_transition.transitiontype == #"cinematic" )
    {
        thread function_33328428535ade85();
        level waittill( #"hash_7ec75468988803c2" );
    }
}

// Namespace display_transition
// Params 3, eflags: 0x4
// Checksum 0x82f1d5bd, Offset: 0x15c5
// Size: 0x66
function private function_ca2a9fd298e74024( transition, outcome, next_transition )
{
    level notify( #"round_end_finished" );
    level notify( #"hash_d31863ea978adee" );
    wait 0.5;
    
    if ( game_utility_mp::waslastround() || game_utility_mp::wasonlyround() )
    {
        logstring( "^5 END MATCH FLOW -- SKIPPING MAP RESTART TRANSITION, LAST ROUND OR ONLY ROUND... TIMESTAMP: " + gettime() );
        return;
    }
    
    gamelogic_mp::restart();
}

// Namespace display_transition
// Params 3, eflags: 0x4
// Checksum 0xe7c0a537, Offset: 0x1633
// Size: 0x32
function private function_7d4f02a77c901adc( transition, outcome, next_transition )
{
    stopcinematicforall( 0, 1 );
    setomnvarforallclients( "post_game_state", 1 );
}

// Namespace display_transition
// Params 0
// Checksum 0xe940231d, Offset: 0x166d
// Size: 0x7f
function function_eb3e12e88a73f12()
{
    level.var_eb3e12e88a73f12[ #"switch_sides" ] = &function_ca2a9fd298e74024;
    level.var_eb3e12e88a73f12[ #"best_play" ] = &function_c861f898ed384b44;
    level.var_eb3e12e88a73f12[ #"winners_circle" ] = &function_c861f898ed384b44;
    level.var_eb3e12e88a73f12[ #"cinematic" ] = &function_7d4f02a77c901adc;
    level.var_eb3e12e88a73f12[ #"next_round" ] = &function_ca2a9fd298e74024;
}

// Namespace display_transition
// Params 2
// Checksum 0x174e1197, Offset: 0x16f4
// Size: 0x22
function function_189c8be45ebb35c7( transition_type, transition_index )
{
    self setclientomnvar( "ui_game_transition_index", transition_index );
}

// Namespace display_transition
// Params 4
// Checksum 0x3004019b, Offset: 0x171e
// Size: 0xb8
function display_transition( transition, transition_index, outcome, lui_event )
{
    [[ level.display_transition_callbacks[ transition.transitiontype ] ]]( transition, outcome );
    
    if ( transition.transitiontype == #"blank" || transition.transitiontype == #"outcome" || transition.transitiontype == #"switch_sides" || transition.transitiontype == #"next_round" )
    {
        function_e9ddf457006bf4d( &function_189c8be45ebb35c7, lui_event, transition_index + 1 );
    }
}

// Namespace display_transition
// Params 3
// Checksum 0xa869b32a, Offset: 0x17de
// Size: 0x52
function init_transition( transition, transition_index, outcome )
{
    if ( isdefined( level.display_transition_init_callbacks[ transition.transitiontype ] ) )
    {
        [[ level.display_transition_init_callbacks[ transition.transitiontype ] ]]( transition, outcome );
    }
}

// Namespace display_transition
// Params 3
// Checksum 0x181ce1ad, Offset: 0x1838
// Size: 0x77
function shutdown_transition( transition, outcome, next_transition )
{
    logstring( "^5 END MATCH FLOW -- Shutting down transition -- TIMESTAMP: " + gettime() );
    
    if ( isdefined( level.var_eb3e12e88a73f12[ transition.transitiontype ] ) )
    {
        [[ level.var_eb3e12e88a73f12[ transition.transitiontype ] ]]( transition, outcome, next_transition );
    }
    
    if ( transition.slowdown )
    {
        function_3d4b2b479f8d6c5c();
    }
}

// Namespace display_transition
// Params 2
// Checksum 0x84860868, Offset: 0x18b7
// Size: 0x143, Type: bool
function display_transition_should_skip( transition, outcome )
{
    if ( transition.disabletransition )
    {
        return true;
    }
    
    if ( outcome.forfeit && transition.transitiontype != #"outcome" && transition.transitiontype != #"winners_circle" )
    {
        return true;
    }
    
    if ( transition.var_c67ce0425fd1eac5 )
    {
        if ( game_utility_mp::waslastround() || game_utility_mp::wasonlyround() )
        {
            return true;
        }
    }
    
    if ( game_utility_mp::shouldplayovertime() )
    {
        if ( transition.var_4e53b6c0caa8dc98 )
        {
            return true;
        }
    }
    else if ( transition.var_f034837eb72f1fa9 )
    {
        return true;
    }
    
    if ( game_utility_mp::inovertime() )
    {
        if ( transition.var_4abfe9cb4c1592d3 )
        {
            return true;
        }
    }
    else if ( transition.var_bdd246696b690c3c )
    {
        return true;
    }
    
    if ( transition.transitiontype == #"switch_sides" )
    {
        if ( !level.roundswitch )
        {
            shutdown_transition( transition, outcome );
            return true;
        }
    }
    
    if ( transition.transitiontype == #"outcome" )
    {
        if ( level.skip_outcome )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace display_transition
// Params 3
// Checksum 0xfa849f7, Offset: 0x1a03
// Size: 0x13b
function function_cd7dc0d35a6a5f39( transitions, outcome, lui_event )
{
    foreach ( index, transition in transitions )
    {
        if ( display_transition_should_skip( transition, outcome ) )
        {
            continue;
        }
        
        init_transition( transition, index, outcome );
        display_transition( transition, index, outcome, lui_event );
        logstring( "^5 END MATCH FLOW -- Displaying match transition. Transition time = " + ( transition.transitiontime ?? 0 ) + " -- TIMESTAMP: " + gettime() );
        
        if ( ( transition.transitiontime ?? 0 ) != 0 )
        {
            round_end_wait( transition.transitiontime * 0.001, transition.slowdown );
        }
        
        shutdown_transition( transition, outcome, transitions[ index + 1 ] );
        
        if ( transition.transitiontype == #"outcome" )
        {
            level thread function_e8a48ab411520ffa();
        }
    }
}

// Namespace display_transition
// Params 0
// Checksum 0xb62db6dd, Offset: 0x1b46
// Size: 0x11
function function_e8a48ab411520ffa()
{
    wait 1;
    level notify( #"hash_fa0cfbee663b705f" );
}

// Namespace display_transition
// Params 1
// Checksum 0x2feffa03, Offset: 0x1b5f
// Size: 0x103
function function_624bc6735ca19661( outcome )
{
    logstring( "^5 END MATCH FLOW -- Displaying match transitions... TIMESTAMP: " + gettime() );
    function_cd7dc0d35a6a5f39( level.gametypebundle.var_11f3a9480b9be992, outcome, #"match_transition" );
    var_ae9b4934d0138a61 = gamelogic_mp::function_66c4e07170b20b12();
    waittime = var_ae9b4934d0138a61 ? level.postroundtime : 0;
    
    if ( var_ae9b4934d0138a61 )
    {
        function_34038e3731892d22( &function_a3558f3cc5e272c5 );
        logstring( "^5 END MATCH FLOW -- Player intermission for round end... TIMESTAMP: " + gettime() );
        setomnvarforallclients( "post_game_state", 5 );
    }
    
    if ( !isbrgamemode() )
    {
        logstring( "^5 END MATCH FLOW -- Setting UI postgame fade... TIMESTAMP: " + gettime() );
        function_6dd0714d57b0007( &game_utility_mp::setuipostgamefade, 0 );
        logstring( "^5 END MATCH FLOW -- Waiting " + waittime + "seconds to set post game state... TIMESTAMP: " + gettime() );
        
        if ( var_ae9b4934d0138a61 )
        {
            wait waittime;
        }
        
        if ( !level.var_5ce3242c82209034 )
        {
            setomnvarforallclients( "post_game_state", 1 );
        }
        
        level notify( #"round_end_finished" );
    }
}

// Namespace display_transition
// Params 1
// Checksum 0x476507b2, Offset: 0x1c6a
// Size: 0x8e
function function_9f08ae5eed7a3fc8( outcome )
{
    logstring( "^5 END MATCH FLOW -- Displaying round transitions... TIMESTAMP: " + gettime() );
    
    if ( level.gametypebundle.var_d88194005124990f )
    {
        if ( game_utility_mp::waslastround() || game_utility_mp::wasonlyround() )
        {
            logstring( "^5 END MATCH FLOW -- SKIPPING ROUND TRANSITIONS, LAST ROUND OR ONLY ROUND... TIMESTAMP: " + gettime() );
            return;
        }
    }
    
    transitions = level.gametypebundle.var_c0d28f648df70abe;
    
    if ( !isdefined( transitions ) )
    {
        return;
    }
    
    function_cd7dc0d35a6a5f39( transitions, outcome, #"round_transition" );
}

// Namespace display_transition
// Params 1
// Checksum 0x11f1a10f, Offset: 0x1d00
// Size: 0xa7
function function_7aec9871bba2902( outcome )
{
    wait level.postgamehitmarkerwaittime;
    level notify( #"hash_bd6935872ca1b8ee" );
    
    if ( !isbrgamemode() && game_utility::getgametype() != "ob" )
    {
        setomnvarforallclients( "post_game_state", 2 );
    }
    
    if ( outcome.isround )
    {
        gamelogic_mp::displayroundend( outcome.winner, outcome.end_reason, outcome.end_reason_loss );
        return;
    }
    
    gamelogic_mp::displaygameend( outcome.winner, outcome.end_reason, outcome.end_reason_loss );
}

