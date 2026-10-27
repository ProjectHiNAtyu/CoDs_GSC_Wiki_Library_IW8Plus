// scripts\mp\ob\systems\ob_match_timer.gsc  (hash_60ffcd3f8e03f804.gscc) (size: 8267 Bytes / 0x204b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c351ac9 (1010113225)
// size ...... 8267 (0x204b)
// includes .. 11  (offset: 0x1e37)
// strings ... 26  (offset: 0x1e8f)
// dev strs .. 6   (offset: 0x2003)
// exports ... 18  (offset: 0x1593)
// cseg ...... 0x45f + 0x1134 (0x1593)
// imports ... 46  (offset: 0x1863)
// animtree1 . 0   (offset: 0x204b)
// animtree2 . 0   (offset: 0x204b)
#using script_3edd59d0d3fc3262;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_util;
#using scripts\mp\overlord;

#namespace ob_match_timer;

// Namespace ob_match_timer
// Params 0, eflags: 0x1
// Checksum 0xc732721d, Offset: 0x47d
// Size: 0x57
function autoexec main()
{
    function_8955ade0ed962b65();
    
    if ( level.var_c97d7b5c47d22f8f.size == 0 )
    {
        return;
    }
    
    level callback::add( #"hash_cc06eb1d45f33a0c", &onplayerjoinsquad );
    level callback::add( #"player_leave_squad", &function_3efb30390246d5d1 );
    level thread function_9cefc8f2b498c515();
    
    /#
        initdebug();
    #/
}

/#

    // Namespace ob_match_timer
    // Params 0, eflags: 0x4
    // Checksum 0xb7203116, Offset: 0x4dc
    // Size: 0x2e, Type: dev
    function private initdebug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x43>", "<dev string:x75>", &function_c94bfbe5097e3544 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_match_timer
    // Params 1, eflags: 0x4
    // Checksum 0x5abf8532, Offset: 0x512
    // Size: 0x69, Type: dev
    function private function_c94bfbe5097e3544( params )
    {
        var_be9fd80999426c00 = int( params[ 0 ] );
        var_c07be881b1539e2 = int( params[ 1 ] );
        level notify( #"hash_27ad9291350c916a" );
        level.var_57a2d6a73b18877a = var_be9fd80999426c00;
        level.var_9e9f55e3ab2603c = var_c07be881b1539e2;
        level.var_b937b9d8b597102e = var_c07be881b1539e2;
        level thread function_9cefc8f2b498c515();
    }

#/

// Namespace ob_match_timer
// Params 0, eflags: 0x4
// Checksum 0xa2c9a7bd, Offset: 0x583
// Size: 0x1dc
function private function_8955ade0ed962b65()
{
    obsettings = ob::get_ob_settings();
    
    if ( !obsettings )
    {
        return;
    }
    
    level.var_c97d7b5c47d22f8f = [];
    
    foreach ( var_ce3d9b0b597c0927 in obsettings.var_d854df5cbc883bc )
    {
        key = var_ce3d9b0b597c0927.missionkey;
        var_c97d7b5c47d22f8f = {};
        var_c97d7b5c47d22f8f.var_b8182888e7d0f57e = getdvarint( @"hash_c985c26a8e4c930e", var_ce3d9b0b597c0927.var_b8182888e7d0f57e ?? 0 );
        var_c97d7b5c47d22f8f.var_57a2d6a73b18877a = getdvarint( @"hash_a2b6b7a1b50bf42c", var_ce3d9b0b597c0927.var_57a2d6a73b18877a ?? 5400 );
        var_c97d7b5c47d22f8f.var_9e9f55e3ab2603c = getdvarint( @"hash_3930e1d02e9dff62", var_ce3d9b0b597c0927.var_9e9f55e3ab2603c ?? 60 );
        var_c97d7b5c47d22f8f.var_b937b9d8b597102e = getdvarint( @"hash_8b4af8af4928fc20", var_ce3d9b0b597c0927.var_b937b9d8b597102e ?? 60 );
        var_c97d7b5c47d22f8f.var_94ca596c0537673f = getdvarint( @"hash_3d40caa9ffd1ea3c", var_ce3d9b0b597c0927.var_94ca596c0537673f ?? 60 );
        var_c97d7b5c47d22f8f.var_2e47e0586ee576f5 = var_ce3d9b0b597c0927.var_2e47e0586ee576f5;
        logstring( "[Squad Match Timer] Initializing Squad Timers. Squad Mission Timer: ", var_c97d7b5c47d22f8f.var_57a2d6a73b18877a, " Squad Mission Timer Enabled: ", var_c97d7b5c47d22f8f.var_9e9f55e3ab2603c, " Squad Mission Timer Countdown Enabled: ", var_c97d7b5c47d22f8f.var_b937b9d8b597102e );
        level.var_c97d7b5c47d22f8f[ key ] = var_c97d7b5c47d22f8f;
    }
}

// Namespace ob_match_timer
// Params 0
// Checksum 0xeb06a2d4, Offset: 0x767
// Size: 0x58
function function_77e7abcf06d7183b()
{
    if ( !isdefined( level.var_b8182888e7d0f57e ) )
    {
        level.var_b8182888e7d0f57e = 0;
        obsettings = ob::get_ob_settings();
        
        if ( !obsettings )
        {
            return;
        }
        
        if ( obsettings.var_d854df5cbc883bc.size > 0 )
        {
            level.var_b8182888e7d0f57e = 1;
        }
    }
    
    return level.var_b8182888e7d0f57e;
}

// Namespace ob_match_timer
// Params 1
// Checksum 0x3c2768cc, Offset: 0x7c8
// Size: 0x4a
function function_911122e50c8bdf4d( newtime )
{
    if ( function_77e7abcf06d7183b() )
    {
        return;
    }
    
    omnvar_utility::setcachedgameomnvar( "ui_ob_match_timer", newtime );
    
    if ( newtime == 0 )
    {
        omnvar_utility::setcachedgameomnvar( "ui_br_circle_state", 4 );
        return;
    }
    
    omnvar_utility::setcachedgameomnvar( "ui_br_circle_state", 5 );
}

// Namespace ob_match_timer
// Params 1, eflags: 0x4
// Checksum 0x4be7d67, Offset: 0x81a
// Size: 0x2f
function private function_bafce36f0cac730f( player )
{
    player endon( #"disconnect" );
    player utility::ent_flag_wait( "ob_story_progression_initialized" );
    return story_contract_util::function_d4e03884b38da3d8( player );
}

// Namespace ob_match_timer
// Params 1, eflags: 0x4
// Checksum 0x13e40b87, Offset: 0x852
// Size: 0x32b
function private onplayerjoinsquad( params )
{
    player = self;
    player endon( #"disconnect" );
    index = params.index ?? player.sessionsquadid;
    team = params.team ?? player.team;
    waittillframeend();
    
    if ( !level.var_c97d7b5c47d22f8f )
    {
        function_8955ade0ed962b65();
    }
    
    squad = teams::getsquaddata( team, index );
    
    if ( !squad )
    {
        assertmsg( "<dev string:x93>" + team + "<dev string:xbb>" + index );
    }
    
    var_ce3d9b0b597c0927 = squad.var_ce3d9b0b597c0927;
    
    if ( !var_ce3d9b0b597c0927 )
    {
        var_ce3d9b0b597c0927 = {};
        var_ce3d9b0b597c0927.starttimems = function_d212203a4fe9cc3d();
        var_ce3d9b0b597c0927.team = team;
        squad_leader = squad_utility::getsquadleader( team, index );
        mission = function_bafce36f0cac730f( squad_leader );
        
        if ( !mission )
        {
            mission = function_bafce36f0cac730f( player );
        }
        
        var_c97d7b5c47d22f8f = level.var_c97d7b5c47d22f8f[ mission ];
        
        if ( !var_c97d7b5c47d22f8f )
        {
            assertmsg( "<dev string:xc8>" + getxhashsourcename( mission ) );
            return;
        }
        
        if ( !var_c97d7b5c47d22f8f.var_b8182888e7d0f57e )
        {
            logstring( "[Squad Match Timer] No timer active for the specified mission." );
            return;
        }
        
        foreach ( notification in var_c97d7b5c47d22f8f.var_2e47e0586ee576f5 )
        {
            var_ce3d9b0b597c0927.var_2d04f2f3bdd8ca51[ int( notification.var_bc152547c76d56df ) ] = notification;
        }
        
        logstring( "[Squad Match Timer] Activating timer for squad set at ", var_c97d7b5c47d22f8f.var_57a2d6a73b18877a, " seconds." );
        var_ce3d9b0b597c0927.var_da9c2f3f7b456151 = var_c97d7b5c47d22f8f.var_9e9f55e3ab2603c;
        var_52961081e553c79d = int( var_c97d7b5c47d22f8f.var_57a2d6a73b18877a ) * 1000;
        var_ce3d9b0b597c0927.endtimems = var_ce3d9b0b597c0927.starttimems + var_52961081e553c79d;
        var_ce3d9b0b597c0927.var_94ca596c0537673f = var_c97d7b5c47d22f8f.var_94ca596c0537673f;
        squad.var_ce3d9b0b597c0927 = var_ce3d9b0b597c0927;
        logstring( "[Squad Match Timer] Adding new squad ", index, "with a start time of ", var_ce3d9b0b597c0927.starttimems, " and an end time of ", var_ce3d9b0b597c0927.endtimems );
        function_188cb24334f055c7( squad, "ui_ob_match_timer", 0 );
        function_188cb24334f055c7( squad, "ui_br_circle_state", 4 );
        return;
    }
    
    player omnvar_utility::setcachedclientomnvar( "ui_ob_match_timer", 0 );
    player omnvar_utility::setcachedclientomnvar( "ui_br_circle_state", 4 );
    logstring( "[Squad Match Timer] Adding new squad member to ", index, " with a start time of ", var_ce3d9b0b597c0927.starttimems, " and an end time of ", var_ce3d9b0b597c0927.endtimems );
}

// Namespace ob_match_timer
// Params 1, eflags: 0x4
// Checksum 0x16d0c9cb, Offset: 0xb85
// Size: 0xe5
function private function_3efb30390246d5d1( params )
{
    player = self;
    team = params.team ?? player.team;
    index = params.index ?? player.sessionsquadid;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( team, index );
    
    if ( !isdefined( var_64bb57aa2d6e8b35 ) || var_64bb57aa2d6e8b35.players.size == 0 )
    {
        logstring( "[Squad Match Timer] Resetting for squad ", index, " since all players left the match." );
        return;
    }
    
    var_ce3d9b0b597c0927 = var_64bb57aa2d6e8b35.var_ce3d9b0b597c0927;
    
    if ( var_ce3d9b0b597c0927 )
    {
        logstring( "[Squad Match Timer] player leaving squad ", index, " with a start time of ", var_ce3d9b0b597c0927.starttimems, " and an end time of ", var_ce3d9b0b597c0927.endtimems );
    }
}

// Namespace ob_match_timer
// Params 0, eflags: 0x4
// Checksum 0x17e96f92, Offset: 0xc72
// Size: 0x1a
function private function_9cefc8f2b498c515()
{
    level thread function_1059ba4a26869ddc();
    level thread function_6f5bee67727b2679();
    level thread function_f2daeaeb110364bc();
}

// Namespace ob_match_timer
// Params 0, eflags: 0xc
// Checksum 0x55c7e5b9, Offset: 0xc94
// Size: 0x1df
function private function_1059ba4a26869ddc()
{
    self notify( #"hash_a2324c57c10f5d85" );
    self endon( #"hash_a2324c57c10f5d85" );
    level endon( #"game_ended" );
    level endon( #"hash_27ad9291350c916a" );
    function_9f52983c201240d9( "ui_ob_match_timer", 0 );
    function_9f52983c201240d9( "ui_br_circle_state", 4 );
    
    while ( true )
    {
        foreach ( squadarray in level.squaddata )
        {
            foreach ( squad in squadarray )
            {
                var_ce3d9b0b597c0927 = squad.var_ce3d9b0b597c0927;
                
                if ( !var_ce3d9b0b597c0927 )
                {
                    continue;
                }
                
                var_c32fa2ad2ea378be = var_ce3d9b0b597c0927.endtimems;
                var_49c1e3695c21d337 = int( max( 0, var_c32fa2ad2ea378be - gettime() ) );
                var_9b8d306aef30ff9a = int( var_ce3d9b0b597c0927.var_da9c2f3f7b456151 * 1000 );
                
                if ( var_49c1e3695c21d337 <= var_9b8d306aef30ff9a )
                {
                    function_188cb24334f055c7( squad, "ui_ob_match_timer", var_c32fa2ad2ea378be );
                    
                    if ( var_49c1e3695c21d337 >= var_9b8d306aef30ff9a )
                    {
                        function_188cb24334f055c7( squad, "ui_br_circle_state", 5 );
                        continue;
                    }
                    
                    if ( var_49c1e3695c21d337 < var_9b8d306aef30ff9a )
                    {
                        function_188cb24334f055c7( squad, "ui_br_circle_state", 9 );
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ob_match_timer
// Params 0, eflags: 0xc
// Checksum 0x785f706c, Offset: 0xe7b
// Size: 0x238
function private function_6f5bee67727b2679()
{
    self notify( #"hash_f8f48bfa82512ba5" );
    self endon( #"hash_f8f48bfa82512ba5" );
    level endon( #"game_ended" );
    level endon( #"hash_27ad9291350c916a" );
    
    while ( true )
    {
        foreach ( squadarray in level.squaddata )
        {
            foreach ( squad in squadarray )
            {
                var_ce3d9b0b597c0927 = squad.var_ce3d9b0b597c0927;
                
                if ( !var_ce3d9b0b597c0927 )
                {
                    continue;
                }
                
                var_c32fa2ad2ea378be = var_ce3d9b0b597c0927.endtimems;
                var_49c1e3695c21d337 = max( 0, var_c32fa2ad2ea378be - gettime() );
                var_e89116b60905de68 = int( var_49c1e3695c21d337 * 0.001 );
                notification = var_ce3d9b0b597c0927.var_2d04f2f3bdd8ca51[ var_e89116b60905de68 ];
                
                if ( !notification || notification.var_d1e1db238cd8639e )
                {
                    continue;
                }
                
                if ( notification.splashref )
                {
                    logstring( "[Squad Match Timer] showing splash at ", var_e89116b60905de68, " seconds" );
                    hud_util::showsplashtoteam( var_ce3d9b0b597c0927.team, notification.splashref );
                }
                
                if ( notification.var_2f2cce0aee532740 )
                {
                    logstring( "[Squad Match Timer] playing dialogue at ", var_e89116b60905de68, " seconds" );
                    overlord::playevent( notification.var_2f2cce0aee532740, squad.players, undefined, undefined, 1 );
                }
                
                var_ce3d9b0b597c0927.var_2d04f2f3bdd8ca51[ var_e89116b60905de68 ].var_d1e1db238cd8639e = 1;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_match_timer
// Params 0, eflags: 0xc
// Checksum 0x3db151c, Offset: 0x10bb
// Size: 0x1d8
function private function_f2daeaeb110364bc()
{
    self notify( #"hash_bfa57af2d1a5a987" );
    self endon( #"hash_bfa57af2d1a5a987" );
    level endon( #"game_ended" );
    level endon( #"hash_27ad9291350c916a" );
    
    while ( true )
    {
        foreach ( squadarray in level.squaddata )
        {
            foreach ( squad in squadarray )
            {
                var_ce3d9b0b597c0927 = squad.var_ce3d9b0b597c0927;
                
                if ( !var_ce3d9b0b597c0927 )
                {
                    continue;
                }
                
                var_c32fa2ad2ea378be = var_ce3d9b0b597c0927.endtimems;
                var_49c1e3695c21d337 = max( 0, var_c32fa2ad2ea378be - gettime() );
                
                if ( var_49c1e3695c21d337 <= 0 )
                {
                    var_ce3d9b0b597c0927.var_24ecc90a66d9fd2a = 1;
                    thread function_9dad565687737dc5( squad.players, var_ce3d9b0b597c0927.var_94ca596c0537673f );
                    level callback::callback( #"hash_fd05279c5637ddd8", { #players:squad.players } );
                    logstring( "[Squad Match Timer] Squad timed out", squad.index, " since the match time limit has been exceeded." );
                    squad.var_ce3d9b0b597c0927 = undefined;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ob_match_timer
// Params 2, eflags: 0x4
// Checksum 0x6959fadd, Offset: 0x129b
// Size: 0xd9
function private function_9dad565687737dc5( players, failuretimeout )
{
    level endon( #"game_ended" );
    
    if ( players.size == 0 )
    {
        return;
    }
    
    logstring( "[Squad Match Timer] begin waiting for failure screen timeout for ", failuretimeout, " seconds" );
    wait failuretimeout;
    logstring( "[Squad Match Timer] Starting to kick inactive players at timeout screen." );
    
    foreach ( player in players )
    {
        if ( !player || !isplayer( player ) )
        {
            continue;
        }
        
        kick( player getentitynumber(), &"EXE/PLAYERKICKED_INACTIVE" );
    }
}

// Namespace ob_match_timer
// Params 0, eflags: 0x4
// Checksum 0xac2bc621, Offset: 0x137c
// Size: 0x74
function private function_d212203a4fe9cc3d()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( level.var_bb86f77304f193c4.var_3d6368d667a0a3df )
    {
        utility::flag_wait( "ob_infil_completed" );
        var_4ad262d95bf84e44 = gettime();
    }
    
    if ( level.var_bb86f77304f193c4.var_e5ecfe4bb09ccc28 > 0 )
    {
        wait level.var_bb86f77304f193c4.var_e5ecfe4bb09ccc28;
        var_4ad262d95bf84e44 = gettime();
    }
    
    return var_4ad262d95bf84e44;
}

// Namespace ob_match_timer
// Params 2, eflags: 0x4
// Checksum 0x55390535, Offset: 0x13f9
// Size: 0xf7
function private function_9f52983c201240d9( omnvar, value )
{
    foreach ( squadarray in level.squaddata )
    {
        foreach ( squad in squadarray )
        {
            function_188cb24334f055c7( squad, omnvar, value );
        }
    }
}

// Namespace ob_match_timer
// Params 3, eflags: 0x4
// Checksum 0xc5e2fd3b, Offset: 0x14f8
// Size: 0x9b
function private function_188cb24334f055c7( var_64bb57aa2d6e8b35, omnvar, value )
{
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player omnvar_utility::setcachedclientomnvar( omnvar, value );
    }
}

