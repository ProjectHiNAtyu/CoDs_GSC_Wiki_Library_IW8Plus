// scripts\mp\ob\ob_infils_portal.gsc  (hash_37e87851cbfac2fa.gscc) (size: 40620 Bytes / 0x9eac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x400d5996 (1074616726)
// size ...... 40620 (0x9eac)
// includes .. 22  (offset: 0x947c)
// strings ... 138 (offset: 0x952c)
// dev strs .. 32  (offset: 0x9d10)
// exports ... 79  (offset: 0x6874)
// cseg ...... 0xc34 + 0x5c40 (0x6874)
// imports ... 248 (offset: 0x74cc)
// animtree1 . 0   (offset: 0x9eac)
// animtree2 . 0   (offset: 0x9eac)
#using script_3edd59d0d3fc3262;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\widgets_visibility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\coop;
#using scripts\mp\flags;
#using scripts\mp\ob\ob_skill_select;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\ob\systems\weapons\ob_damage;
#using scripts\mp\outofbounds;
#using scripts\mp\overlord;

#namespace ob_infils_portal;

// Namespace ob_infils_portal
// Params 0, eflags: 0x5
// Checksum 0xc2ca0b37, Offset: 0xc52
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_portal_infil", undefined, undefined, &post_main );
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x4dfc0132, Offset: 0xc73
// Size: 0x26
function private post_main()
{
    if ( level.var_bb86f77304f193c4.var_3d6368d667a0a3df )
    {
        level.var_1885dec6f8399bd0 = &init;
    }
}

// Namespace ob_infils_portal
// Params 0
// Checksum 0xbb4c298, Offset: 0xca1
// Size: 0x5a8
function init()
{
    namespace_f2445a4de17ee25::function_316cb76449f3acf7( "skydive_protection", &function_875afa1ed9526daf );
    utility::registersharedfunc( #"ob_infil", #"hash_516c884e13c5892d", &function_37b81b745b4903ee );
    level.var_99540244ff335aea = getdvarint( @"hash_2fe0283b419ff08a", 0 );
    function_a59564178de1b75a();
    callback::add( #"player_leave_squad", &on_player_leave_squad );
    
    if ( level.var_99540244ff335aea )
    {
        /#
            function_87c7e25bfa2eabc3( "<dev string:x24>" );
        #/
        
        level.prematchperiodend = 0;
        function_f9e8a3609dfb0d34();
        level notify( #"matchstarttimer_done" );
        return;
    }
    
    /#
        function_5a5b625aaa92f33a();
    #/
    
    audio_utility::snd_transient_load( "mp_sat_ob_infil" );
    setomnvar( "ui_mp_extended_load_screen", 1 );
    level.var_8afd2d97bc4003e4 = 1;
    level.var_c57ff57d8b66d391 = 1;
    level.var_6e16ed2f1c707b6b = undefined;
    introcinematic = undefined;
    level.var_c25edcdc503d44d4 = 0;
    introtime = 0;
    level.var_5fa98923ab3e7005 = ( 56000, -120000, -28000 );
    level.var_7b88dfbdb5d8d5c0 = getent( "infil_cargo_interior", #targetname );
    
    if ( level.var_7b88dfbdb5d8d5c0 )
    {
        level.var_5fa98923ab3e7005 = level.var_7b88dfbdb5d8d5c0.origin;
        level.var_7b88dfbdb5d8d5c0.animname = "Plane Interior";
    }
    
    if ( validatescenescriptbundle( level.gametypebundle.infilscene ) )
    {
        var_2284df034cd69342 = { #angles:( 0, 0, 0 ), #origin:level.var_5fa98923ab3e7005 };
        var_2284df034cd69342 scene::set_scriptbundle( level.gametypebundle.infilscene );
        var_a14e24fc894d696d = function_bfc7f0203dd8156b( var_2284df034cd69342 );
        var_cf544f3201022156 = { #duration:var_a14e24fc894d696d, #root:var_2284df034cd69342 };
        level.var_c25edcdc503d44d4 = var_a14e24fc894d696d;
        var_2c0d6ddc00a463a3 = undefined;
        
        if ( validatescenescriptbundle( level.gametypebundle.var_f73f75bc18095713 ) )
        {
            var_811965ac224fd0ff = { #angles:( 0, 0, 0 ), #origin:level.var_5fa98923ab3e7005 };
            var_811965ac224fd0ff scene::set_scriptbundle( level.gametypebundle.var_f73f75bc18095713 );
            var_11a0df937060c8f6 = function_bfc7f0203dd8156b( var_811965ac224fd0ff );
            var_2c0d6ddc00a463a3 = { #duration:var_11a0df937060c8f6, #root:var_811965ac224fd0ff };
            
            if ( var_11a0df937060c8f6 < level.var_c25edcdc503d44d4 )
            {
                level.var_c25edcdc503d44d4 = var_11a0df937060c8f6;
            }
        }
        
        level.var_6e16ed2f1c707b6b = { #solo:var_2c0d6ddc00a463a3, #squad:var_cf544f3201022156 };
        introtime = level.var_c25edcdc503d44d4 + 1;
    }
    
    level.var_700dd5df08919387 = undefined;
    level.var_51624f48ee0fe809 = 0;
    
    if ( level.gametypebundle.infilcinematic )
    {
        level.var_700dd5df08919387 = level.gametypebundle.infilcinematic;
        level.var_51624f48ee0fe809 = 7.2;
    }
    
    var_6dc0e7c0c75875b2 = !isdefined( level.var_6e16ed2f1c707b6b ) && !level.var_bb86f77304f193c4.var_173f965a054b098a;
    
    if ( var_6dc0e7c0c75875b2 )
    {
        level.var_99540244ff335aea = 1;
        
        /#
            function_87c7e25bfa2eabc3( "<dev string:x33>" );
        #/
    }
    
    if ( !level.var_99540244ff335aea )
    {
        function_6b45b717e316b78a();
        callback::add( #"player_connect", &on_player_connect );
    }
    
    level.prematchperiod = getdvarint( @"scr_game_graceperiod", 60 );
    level.prematchperiodend = getdvarint( @"hash_7061556e5a6fcbc7", 15 );
    level.matchcountdowntime = level.prematchperiodend;
    obinfil_grace_period = getdvarint( @"hash_569988245b912ed1", level.prematchperiod );
    level.var_6734264e64ccfc94 = gettime() + obinfil_grace_period * 1000;
    level.var_c2271683e2743ad5 = getdvarint( @"hash_d6c6f27e2890ab87", 3 );
    level.var_d41f84f9409d4b15 = getdvarfloat( @"hash_39ea6191970eb227", 45 );
    level.var_65957518390e3d2a = &function_1850a9749b8a371a;
    flags::gameflagset( "infil_setup_complete" );
    flags::gameflagwait( "prematch_started" );
    level notify( #"matchstarttimer_done" );
    flags::gameflagset( "infil_started" );
    
    /#
        function_87c7e25bfa2eabc3( "<dev string:x50>" );
    #/
    
    if ( level.var_99540244ff335aea )
    {
        setomnvar( "ui_mp_extended_load_screen", 0 );
        
        foreach ( player in level.players )
        {
            function_7b86a57d161f7a4e( player );
            player utility::ent_flag_set( "ob_infil_boots_on_ground" );
            thread game_utility::fadetoblackforplayerkeepui( player, 0, 0.1 );
        }
        
        level.prematchperiodend = 0;
        function_f9e8a3609dfb0d34();
        return;
    }
    
    setomnvar( "ui_mp_extended_load_screen", 0 );
    callback::callback( "on_ob_infil_start_music" );
    level thread function_c1a3ec8341ceb045( level.var_6e16ed2f1c707b6b );
}

// Namespace ob_infils_portal
// Params 0
// Checksum 0x4fef350b, Offset: 0x1251
// Size: 0x204
function function_1850a9749b8a371a()
{
    if ( !isdefined( level.var_c588fd68c410d1bb ) )
    {
        level.var_c588fd68c410d1bb = gettime();
    }
    
    lobbysize = function_e2939bfa2e5a9527();
    
    if ( level.players.size < lobbysize )
    {
        level.var_c588fd68c410d1bb = gettime();
        return 0;
    }
    
    streamcomplete = 0;
    var_7b38f4d9571e2c83 = level.var_c588fd68c410d1bb + utility::function_4b74c15943231980( level.var_d41f84f9409d4b15 );
    
    if ( gettime() > var_7b38f4d9571e2c83 )
    {
        return 1;
    }
    
    var_33b79c2de07ec7e9 = level.var_c588fd68c410d1bb + utility::function_4b74c15943231980( level.var_c2271683e2743ad5 );
    
    if ( gettime() < var_33b79c2de07ec7e9 )
    {
        return 0;
    }
    
    if ( level.players.size > 0 )
    {
        streamcomplete = 1;
        
        foreach ( team in level.teamnamelist )
        {
            players = teams::getteamdata( team, "players" );
            
            foreach ( player in players )
            {
                if ( !player.pers[ "streamSyncComplete" ] || player.model == "" || !player ispredictedstreamposready() || !player isadditionalstreamposready() )
                {
                    streamcomplete = 0;
                    break;
                }
            }
            
            if ( !streamcomplete )
            {
                break;
            }
        }
    }
    
    return streamcomplete;
}

// Namespace ob_infils_portal
// Params 5, eflags: 0x4
// Checksum 0x303879c7, Offset: 0x145e
// Size: 0x32d
function private doinfilwithscene_clientsquadavatars( players, var_3f2c1303dc415cc7, var_54a5f2e566ae5e83, var_58bb242dbcd8b7e1, var_b483ba80eff709a7 )
{
    extendeddebug = getdvarint( @"hash_3dda3394b75e1428", 1 );
    
    if ( extendeddebug )
    {
        function_9c5605d761757fd1( "doInfilWithScene_clientSquadAvatars players", players );
    }
    
    squadplayers = [];
    soloplayers = [];
    level thread function_25c8d45c0442064b( level.var_5fa98923ab3e7005, var_54a5f2e566ae5e83 + ( var_b483ba80eff709a7 ?? 0 ) + 5 );
    callback::callback( "on_ob_infil_start_music" );
    
    foreach ( idx, player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        function_3214823f1c456b68( "Sky infil for player[" + player.name + "]." );
        squadmembers = player squad_utility::getsquadmembers();
        squadsize = max( 1, squadmembers.size ?? 0 );
        teamname = player.team ?? "fallback";
        squadid = player.sessionsquadid ?? idx;
        var_c356c00922324d17 = function_a85b42d0fa11d5f9( teamname, squadid );
        player.ob_playerspawn = function_7d6d4303a13c5843( var_c356c00922324d17, player );
        player thread function_f89c6bf83e2c5a0d();
        
        if ( squadsize == 1 && isdefined( var_3f2c1303dc415cc7.solo ) )
        {
            soloplayers[ soloplayers.size ] = player;
        }
        else
        {
            squadplayers[ squadplayers.size ] = player;
        }
        
        player utility::player_prestream_assets( "infils_portal", "entity", squadmembers, undefined, var_b483ba80eff709a7 ?? 5 );
        player utility::player_prestream_camera( level.var_5fa98923ab3e7005, var_b483ba80eff709a7 ?? 5 );
    }
    
    if ( isdefined( var_58bb242dbcd8b7e1 ) && var_b483ba80eff709a7 > 0 )
    {
        thread function_22c21c6206c6cef5( players, var_58bb242dbcd8b7e1, var_b483ba80eff709a7 );
        wait max( var_b483ba80eff709a7 - 2, 0 );
    }
    
    audio_utility::function_63bf1584c79c055( players, "scn_sat_ob_infil" );
    
    if ( squadplayers.size > 0 )
    {
        thread function_b16a3ae64f363de8( squadplayers, var_3f2c1303dc415cc7.squad );
    }
    
    if ( soloplayers.size > 0 )
    {
        thread function_b16a3ae64f363de8( soloplayers, var_3f2c1303dc415cc7.solo );
    }
    
    wait var_54a5f2e566ae5e83;
    players = function_5713d46873b29625( players );
    
    foreach ( player in players )
    {
        function_4506b2420317e728( player, player.ob_playerspawn.position, player.ob_playerspawn.angles );
        player.ob_playerspawn = undefined;
    }
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x7f5e5e2c, Offset: 0x1793
// Size: 0x145
function private function_ef48fd015d3132e( players )
{
    extendeddebug = getdvarint( @"hash_3dda3394b75e1428", 1 );
    
    if ( extendeddebug )
    {
        function_9c5605d761757fd1( "doGroundInfilWithNoIGC players", players );
    }
    
    foreach ( idx, player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        function_3214823f1c456b68( "Ground infil for player[" + player.name + "]." );
        teamname = player.team ?? "fallback";
        squadid = player.sessionsquadid ?? idx;
        var_c356c00922324d17 = function_a85b42d0fa11d5f9( teamname, squadid );
        playerspawn = function_7d6d4303a13c5843( var_c356c00922324d17, player );
        function_18d5de1bbad61183( player, playerspawn.position, playerspawn.angles );
    }
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x74495468, Offset: 0x18e0
// Size: 0x16
function private function_6b45b717e316b78a()
{
    level.var_24dbb734902c37c2 = [];
    level.var_e2c7cb31dd509c86 = [];
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x926609db, Offset: 0x18fe
// Size: 0xbb
function private function_a614fe3f01f8258b( player )
{
    if ( level.var_bb86f77304f193c4.var_46535b1d85e8cbad )
    {
        coop::function_367a5824a0d5edd4( player );
    }
    
    if ( function_e04b9b9876d8d7af( player ) )
    {
        function_3214823f1c456b68( "Player[" + player.name + "] queued for ground infil." );
        level.var_e2c7cb31dd509c86[ level.var_e2c7cb31dd509c86.size ] = player;
        level notify( #"hash_806ef1002c4612e2" );
        return;
    }
    
    function_3214823f1c456b68( "Player[" + player.name + "] queued for sky infil." );
    level.var_24dbb734902c37c2[ level.var_24dbb734902c37c2.size ] = player;
    level notify( #"hash_b410ecc0684e25a8" );
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x7a8a2a7d, Offset: 0x19c1
// Size: 0x7f
function private function_238c8d697915235a()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    function_3214823f1c456b68( "Begin load watcher for Player[" + self.name + "]." );
    
    if ( !isbot( self ) )
    {
        utility::ent_flag_wait( "squad_play_begin" );
    }
    
    function_3214823f1c456b68( "Player[" + self.name + "] finished loading." );
    self.var_e7aa9a9a4adfd15b = 1;
    self.var_3cd24ac08444fb5a = gettime();
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xdb803126, Offset: 0x1a48
// Size: 0x1a, Type: bool
function private function_8e9060f9cb6c5c35( player )
{
    return player.var_e7aa9a9a4adfd15b == 1;
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x7fe7ccde, Offset: 0x1a6b
// Size: 0xed, Type: bool
function private function_b6dfa011b9620a1a( player )
{
    if ( !function_8e9060f9cb6c5c35( player ) )
    {
        return false;
    }
    
    if ( !isbot( player ) )
    {
        maxwaittime = player.var_3cd24ac08444fb5a + 10000;
        
        if ( gettime() > maxwaittime )
        {
            return true;
        }
    }
    
    var_1305154d75d10c36 = 1;
    squadmates = player squad_utility::getsquadmembers();
    
    foreach ( squadmate in squadmates )
    {
        if ( !function_8e9060f9cb6c5c35( squadmate ) )
        {
            var_1305154d75d10c36 = 0;
            break;
        }
    }
    
    if ( !var_1305154d75d10c36 )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x3ea8bb1b, Offset: 0x1b61
// Size: 0x51
function private function_c1a3ec8341ceb045( var_3f2c1303dc415cc7 )
{
    level endon( #"game_ended" );
    
    if ( isdefined( var_3f2c1303dc415cc7 ) )
    {
        thread function_686a5257e8aa2988( var_3f2c1303dc415cc7 );
    }
    else
    {
        assert( level.var_bb86f77304f193c4.var_173f965a054b098a, "<dev string:x62>" );
    }
    
    thread function_83fa4ab483f7fbb0();
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x59b479f9, Offset: 0x1bba
// Size: 0x41c
function private function_686a5257e8aa2988( var_3f2c1303dc415cc7 )
{
    level endon( #"game_ended" );
    function_3214823f1c456b68( "Sky infil thread begin." );
    assert( isdefined( var_3f2c1303dc415cc7.squad ), "<dev string:x9f>" );
    
    if ( isdefined( var_3f2c1303dc415cc7.solo.duration ) )
    {
        var_2984f96335003694 = max( var_3f2c1303dc415cc7.squad.duration, var_3f2c1303dc415cc7.solo.duration );
        var_1fa029215b9c5f24 = min( var_3f2c1303dc415cc7.squad.duration, var_3f2c1303dc415cc7.solo.duration );
    }
    else
    {
        var_2984f96335003694 = var_3f2c1303dc415cc7.squad.duration;
        var_1fa029215b9c5f24 = var_3f2c1303dc415cc7.squad.duration;
    }
    
    var_3580162c6292e94b = var_2984f96335003694 + level.var_51624f48ee0fe809 + 1;
    var_5ea5de8e13e3508e = 1;
    
    while ( true )
    {
        if ( level.var_24dbb734902c37c2.size == 0 )
        {
            function_3214823f1c456b68( "No players for sky ifil. Waiting for players." );
            level waittill( #"hash_b410ecc0684e25a8" );
            function_3214823f1c456b68( "Players queued for sky infil." );
        }
        
        readyplayers = [];
        
        foreach ( player in level.var_24dbb734902c37c2 )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !function_b6dfa011b9620a1a( player ) )
            {
                /#
                    function_87c7e25bfa2eabc3( "<dev string:xba>" + player.name + "<dev string:xc2>" );
                #/
                
                continue;
            }
            
            function_3214823f1c456b68( "Player[" + player.name + "] ready for sky infil." );
            readyplayers[ readyplayers.size ] = player;
        }
        
        foreach ( var_b1c4a8fbb5b20426 in readyplayers )
        {
            level.var_24dbb734902c37c2 = arrayremove( level.var_24dbb734902c37c2, var_b1c4a8fbb5b20426 );
        }
        
        level.var_226b527667b07458 = 1;
        
        foreach ( player in readyplayers )
        {
            thread game_utility::fadetoblackforplayerkeepui( player, 1, 0.5 );
        }
        
        if ( readyplayers.size > 0 )
        {
            wait 0.5;
        }
        
        extendeddebug = getdvarint( @"hash_3dda3394b75e1428", 1 ) && readyplayers.size > 0;
        
        if ( extendeddebug )
        {
            function_9c5605d761757fd1( "Sky infil ready players pre-JIP", readyplayers );
        }
        
        function_b226066162b642bc( readyplayers );
        waitframe();
        readyplayers = function_68b638709b384e6b( readyplayers );
        
        if ( extendeddebug )
        {
            function_9c5605d761757fd1( "Sky infil ready players post-JIP", readyplayers );
        }
        
        var_e342953a499c7986 = readyplayers.size > 0;
        
        if ( var_e342953a499c7986 )
        {
            if ( level.var_2af5eff9670c77a5 )
            {
                level thread function_20297fff807fedbb( readyplayers );
                wait var_5ea5de8e13e3508e;
            }
            else
            {
                level thread doinfilwithscene_clientsquadavatars( readyplayers, var_3f2c1303dc415cc7, var_1fa029215b9c5f24, level.var_700dd5df08919387, level.var_51624f48ee0fe809 );
                wait var_3580162c6292e94b;
            }
        }
        else
        {
            wait var_5ea5de8e13e3508e;
        }
        
        if ( !level.infilcompleted && var_e342953a499c7986 )
        {
            function_f9e8a3609dfb0d34();
        }
        
        level.var_226b527667b07458 = undefined;
        level notify( #"hash_f9776a108e4c938e" );
    }
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x96d6cfe7, Offset: 0x1fde
// Size: 0x23b
function private function_83fa4ab483f7fbb0( var_3f2c1303dc415cc7 )
{
    level endon( #"game_ended" );
    function_3214823f1c456b68( "Ground infil thread begin." );
    
    while ( true )
    {
        if ( level.var_e2c7cb31dd509c86.size == 0 )
        {
            function_3214823f1c456b68( "No players for ground ifil. Waiting for players." );
            level waittill( #"hash_806ef1002c4612e2" );
            function_3214823f1c456b68( "Players queued for ground infil." );
        }
        
        readyplayers = [];
        
        foreach ( player in level.var_e2c7cb31dd509c86 )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !function_b6dfa011b9620a1a( player ) )
            {
                /#
                    function_87c7e25bfa2eabc3( "<dev string:xba>" + player.name + "<dev string:xdd>" );
                #/
                
                continue;
            }
            
            function_3214823f1c456b68( "Player[" + player.name + "] ready for ground infil." );
            readyplayers[ readyplayers.size ] = player;
        }
        
        foreach ( var_b1c4a8fbb5b20426 in readyplayers )
        {
            level.var_e2c7cb31dd509c86 = arrayremove( level.var_e2c7cb31dd509c86, var_b1c4a8fbb5b20426 );
        }
        
        extendeddebug = getdvarint( @"hash_3dda3394b75e1428", 1 ) && readyplayers.size > 0;
        
        if ( extendeddebug )
        {
            function_9c5605d761757fd1( "Ground infil ready players pre-JIP", readyplayers );
        }
        
        function_b226066162b642bc( readyplayers );
        readyplayers = function_68b638709b384e6b( readyplayers );
        
        if ( extendeddebug )
        {
            function_9c5605d761757fd1( "Ground infil ready players post-JIP", readyplayers );
        }
        
        if ( readyplayers.size > 0 )
        {
            level thread function_ef48fd015d3132e( readyplayers );
            
            if ( !level.infilcompleted )
            {
                function_f9e8a3609dfb0d34();
            }
        }
        
        waitframe();
    }
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xe02965a, Offset: 0x2221
// Size: 0x250
function private function_68b638709b384e6b( readyplayers )
{
    if ( readyplayers.size == 0 )
    {
        return readyplayers;
    }
    
    if ( gettime() < level.var_6734264e64ccfc94 || getdvarint( @"hash_a961217fdcc1b273", 1 ) == 0 )
    {
        return readyplayers;
    }
    
    jipplayers = [];
    
    foreach ( player in readyplayers )
    {
        if ( !player.is_jip_player )
        {
            continue;
        }
        
        squadmates = player squad_utility::getsquadmembers( undefined, 1 );
        
        foreach ( squadmate in squadmates )
        {
            if ( squadmate == player || !isalive( squadmate ) || !squadmate.var_4a59d674db96c66a || squadmate.sessionstate != "playing" || squadmate.disconnecting || squadmate.oob )
            {
                continue;
            }
            
            var_262e9fd903da565d = { #squadmate:squadmate, #player:player };
            jipplayers[ jipplayers.size ] = var_262e9fd903da565d;
            break;
        }
    }
    
    foreach ( var_262e9fd903da565d in jipplayers )
    {
        player = var_262e9fd903da565d.player;
        readyplayers = arrayremove( readyplayers, player );
        thread function_58fd859ecf6db684( player, var_262e9fd903da565d.squadmate );
    }
    
    return readyplayers;
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x9e504040, Offset: 0x247a
// Size: 0x18a
function private function_58fd859ecf6db684( joiningplayer, squadmate )
{
    level endon( #"game_ended" );
    joiningplayer endon( #"disconnect" );
    
    if ( function_e04b9b9876d8d7af( joiningplayer ) )
    {
        function_3214823f1c456b68( "Player[" + joiningplayer.name + "] started join-in-progress ground infil on squadmate[" + squadmate.name + "]." );
        var_34a64143880e4f30 = joiningplayer [[ level.var_9a7facf0cbad27fd ]]( squadmate );
        
        if ( var_34a64143880e4f30.success )
        {
            spawnorigin = var_34a64143880e4f30.origin;
            
            if ( isplayer( squadmate ) )
            {
                spawnangles = squadmate getplayerangles( 1 );
            }
        }
        else
        {
            var_c356c00922324d17 = function_a85b42d0fa11d5f9( joiningplayer.team, joiningplayer.sessionsquadid );
            playerspawn = function_7d6d4303a13c5843( var_c356c00922324d17, joiningplayer );
            spawnorigin = playerspawn.position;
            spawnangles = playerspawn.angles;
        }
        
        function_18d5de1bbad61183( joiningplayer, spawnorigin, spawnangles );
        return;
    }
    
    function_3214823f1c456b68( "Player[" + joiningplayer.name + "] started join-in-progress sky infil on squadmate[" + squadmate.name + "]." );
    joiningplayer setplayerangles( squadmate getplayerangles( 1 ) );
    thread game_utility::fadetoblackforplayerkeepui( joiningplayer, 0, 1 );
    function_7b86a57d161f7a4e( joiningplayer );
    function_37b81b745b4903ee( joiningplayer, squadmate getorigin(), 1 );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x15a4dd5b, Offset: 0x260c
// Size: 0x117
function private function_20297fff807fedbb( players )
{
    extendeddebug = getdvarint( @"hash_3dda3394b75e1428", 1 );
    
    if ( extendeddebug )
    {
        function_9c5605d761757fd1( "DoSkyInfilOutsideOfInfilPeriod players", players );
    }
    
    foreach ( player in players )
    {
        function_3214823f1c456b68( "Player[" + player.name + "] started sky infil after infil period ended." );
        var_c356c00922324d17 = function_a85b42d0fa11d5f9( player.team, player.sessionsquadid );
        playerspawn = function_7d6d4303a13c5843( var_c356c00922324d17, player );
        thread function_4506b2420317e728( player, playerspawn.position, playerspawn.angles );
    }
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x25d925de, Offset: 0x272b
// Size: 0x7b
function private function_c4f84aa6be2cb910()
{
    level endon( #"game_ended" );
    
    if ( level.var_2af5eff9670c77a5 )
    {
        return;
    }
    
    if ( level.var_226b527667b07458 )
    {
        level waittill( #"hash_f9776a108e4c938e" );
    }
    
    audio_utility::snd_transient_unload( "mp_sat_ob_infil" );
    
    if ( !level.var_5bfcb984d60bccb6 && function_cb3f113c9a5d56f7( "mp_infil_ob_sat_avalon_endgame_tr" ) )
    {
        unloadinfiltransient( "mp_infil_ob_sat_avalon_endgame_tr" );
    }
    
    level.var_2af5eff9670c77a5 = 1;
    function_3214823f1c456b68( "Infil period ended. Infil transient unloaded." );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x23073e69, Offset: 0x27ae
// Size: 0xa1
function private function_b226066162b642bc( players )
{
    foreach ( player in players )
    {
        if ( level.var_bb86f77304f193c4.var_46535b1d85e8cbad )
        {
            coop::function_c3c78f0c69cbacc5( player );
        }
        
        player notify( #"pre_infil_complete" );
    }
}

// Namespace ob_infils_portal
// Params 4, eflags: 0x4
// Checksum 0xf7e2197b, Offset: 0x2857
// Size: 0xcf
function private function_b00b1f8d068ea963( propent, squadidx, players, operatortype )
{
    propent function_3ce65e6c3056261f( squadidx, %"fullbody_usmc_ar_br_infil", "body_usmc_ar_br_infil", operatortype );
    
    foreach ( player in players )
    {
        squadsize = max( 1, squad_utility::getsquadsize( player ) );
        
        if ( squadsize <= squadidx )
        {
            propent hidefromplayer( player );
        }
    }
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0xa64af233, Offset: 0x292e
// Size: 0x530
function private function_b16a3ae64f363de8( players, scene )
{
    level endon( #"game_ended" );
    
    foreach ( player in players )
    {
        thread game_utility::fadetoblackforplayerkeepui( player, 0, 0 );
        player thread function_364629d11638608d( max( scene.duration - 0.6, 0 ), 0.5, 0.2, 0.5 );
        player function_a565dafac620d68e( %"hw_sat_lm_avalon_ob_cine" );
        player skydive_interrupt();
        player notify( #"skydive_end" );
    }
    
    existingentities = arraycopy( players );
    sceneroot = { #angles:scene.root.angles, #origin:scene.root.origin };
    sceneroot scene::init( existingentities, undefined, scene.root.script_scenescriptbundle );
    sceneroot scene::function_b95eab90f9ebc981( players );
    sceneentities = sceneroot scene::get_entities();
    
    foreach ( entity in sceneentities )
    {
        entity hide();
        
        foreach ( player in players )
        {
            entity showtoplayer( player );
        }
    }
    
    for ( squadidx = 0; squadidx < 4 ; squadidx++ )
    {
        squadent = sceneroot scene::get_entity( "Player " + squadidx + 1 );
        
        if ( isdefined( squadent ) )
        {
            function_b00b1f8d068ea963( squadent, squadidx, players, 0 );
        }
        
        var_40d82d1fdbbbcba8 = sceneroot scene::get_entity( "Player Male " + squadidx + 1 );
        
        if ( isdefined( var_40d82d1fdbbbcba8 ) )
        {
            function_b00b1f8d068ea963( var_40d82d1fdbbbcba8, squadidx, players, 1 );
        }
        
        var_acfcf5bfe3bb3cd1 = sceneroot scene::get_entity( "Player Female " + squadidx + 1 );
        
        if ( isdefined( var_acfcf5bfe3bb3cd1 ) )
        {
            function_b00b1f8d068ea963( var_acfcf5bfe3bb3cd1, squadidx, players, 2 );
        }
        
        podent = sceneroot scene::get_entity( "Pod " + squadidx + 1 );
        
        if ( isdefined( podent ) )
        {
            foreach ( player in players )
            {
                squadsize = max( 1, squad_utility::getsquadsize( player ) );
                
                if ( squadsize <= squadidx )
                {
                    podent hidefromplayer( player );
                }
            }
        }
        
        var_10da192d3692dc2c = sceneroot scene::get_entity( "Static Pod " + squadidx + 1 );
        
        if ( isdefined( var_10da192d3692dc2c ) )
        {
            tagname = "tag_tube_0" + squadidx + 1;
            
            if ( isdefined( level.var_7b88dfbdb5d8d5c0 ) && level.var_7b88dfbdb5d8d5c0 tagexists( tagname ) )
            {
                var_10da192d3692dc2c linkto( level.var_7b88dfbdb5d8d5c0, tagname, ( 0, 0, 0 ), ( 0, 0, 0 ) );
            }
            
            foreach ( player in players )
            {
                squadsize = max( 1, squad_utility::getsquadsize( player ) );
                
                if ( squadsize > squadidx )
                {
                    var_10da192d3692dc2c hidefromplayer( player );
                }
            }
        }
    }
    
    sceneroot scene::play();
    sceneroot scene::cleanup();
    
    foreach ( player in players )
    {
        if ( player )
        {
            player function_72cf2eee8e035013( %"hw_sat_lm_avalon_ob_cine" );
        }
    }
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0xc22c36c9, Offset: 0x2e66
// Size: 0x45
function private function_f9e8a3609dfb0d34()
{
    if ( level.infilcompleted )
    {
        return;
    }
    
    function_3214823f1c456b68( "First infil completed." );
    thread function_a8d6961930d4237b();
    level.infilcompleted = 1;
    utility::flag_set( "ob_infil_completed" );
    callback::callback( "on_ob_infil_complete" );
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x85e5b0, Offset: 0x2eb3
// Size: 0x155
function private function_a8d6961930d4237b()
{
    level endon( #"hash_10f3622b7bacb81e" );
    
    if ( level.var_99540244ff335aea || level.var_bb86f77304f193c4.var_173f965a054b098a )
    {
        return;
    }
    
    if ( !level.gametypebundle.jipdisabled )
    {
        waittimesec = getdvarint( @"hash_67e537056ee477e0", -1 );
        
        if ( waittimesec < 0 )
        {
            return;
        }
        
        wait waittimesec;
    }
    
    if ( isarray( level.var_24dbb734902c37c2 ) )
    {
        var_3af660ebc1721a69 = arraycopy( level.var_24dbb734902c37c2 );
    }
    else
    {
        var_3af660ebc1721a69 = [];
    }
    
    while ( true )
    {
        var_8d1f606531959b2d = 1;
        
        foreach ( player in var_3af660ebc1721a69 )
        {
            playerdone = !isdefined( player ) || player.var_4a59d674db96c66a;
            
            if ( !playerdone )
            {
                var_8d1f606531959b2d = 0;
                break;
            }
        }
        
        if ( var_8d1f606531959b2d )
        {
            break;
        }
        
        wait 5;
    }
    
    function_c4f84aa6be2cb910();
}

// Namespace ob_infils_portal
// Params 1
// Checksum 0x500b204d, Offset: 0x3010
// Size: 0x10b
function on_player_connect( params )
{
    self endon( #"disconnect" );
    self.is_jip_player = gettime() > level.var_6734264e64ccfc94;
    self setclientdvar( @"hash_eaef35f1868b3ac2", 0 );
    function_3214823f1c456b68( "Setting pre infil Vals for Player[" + self.name + "] on connect." );
    function_3fbcc065eab9775f();
    self setsoundsubmix( "mp_sat_ob_infil", 1, 1 );
    thread game_utility::fadetoblackforplayerkeepui( self, 1, 0 );
    function_a614fe3f01f8258b( self );
    thread function_238c8d697915235a();
    thread function_ec775ba23c6f26e2();
    thread function_89939968ea3d3ac();
    ret = utility::waittill_any_ents_return( self, "infil_val_reset", self, "giveLoadout" );
    
    if ( ret == "giveLoadout" )
    {
        function_3214823f1c456b68( "Setting pre infil Vals for Player[" + self.name + "] due to giveLoadout nukeAll vals." );
        val::reset_all( "ob_infil" );
        function_3fbcc065eab9775f();
    }
    
    if ( !function_80a6da3b3dedc271( self ) )
    {
        thread function_598d417325d643bb( 10 );
    }
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x56860448, Offset: 0x3123
// Size: 0x16d
function private function_3fbcc065eab9775f()
{
    val::set( "ob_infil", "hide", 2 );
    val::set( "ob_infil", "freezecontrols", 1 );
    val::set( "ob_infil", "allow_movement", 0 );
    val::set( "ob_infil", "crouch", 0 );
    val::set( "ob_infil", "prone", 0 );
    val::set( "ob_infil", "melee", 0 );
    val::set( "ob_infil", "offhand_primary_weapons", 0 );
    val::set( "ob_infil", "offhand_secondary_weapons", 0 );
    val::set( "ob_infil", "weapon", 0 );
    val::set( "ob_infil", "damage", 0 );
    val::set( "ob_infil", "killstreaks", 0 );
    val::set( "ob_infil", "ignoreme", 1 );
    val::set( "ob_infil", "ads", 0 );
    val::set( "ob_infil", "weapon_switch", 0 );
    val::set( "ob_infil", "action_slot_weapon", 0 );
    val::set( "ob_infil", "armor", 0 );
    val::set( "ob_infil", "supers", 0 );
    val::set( "ob_infil", "show_hud", 0 );
    val::set( "ob_infil", "allow_skill_select", 0 );
    val::set( "ob_infil", "interacts_with_oob_triggers", 0 );
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x2ee8dfa8, Offset: 0x3298
// Size: 0xb4
function private function_ec775ba23c6f26e2()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( flags::gameflagexists( "prematch_values_reset" ) && flags::gameflag( "prematch_values_reset" ) )
    {
        return;
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_values_reset" );
    
    if ( !self.var_4a59d674db96c66a )
    {
        function_3214823f1c456b68( "Refreezing controls for Player[" + self.name + "] after prematch end unfroze them." );
        val::reset( "ob_infil", "freezecontrols" );
        val::reset( "ob_infil", "fire" );
        val::set( "ob_infil", "freezecontrols", 1 );
        val::set( "ob_infil", "fire", 0 );
    }
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x49526454, Offset: 0x3354
// Size: 0x49
function private function_89939968ea3d3ac()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( self.var_4a59d674db96c66a )
    {
        return;
    }
    
    self.b_hide_ui_match_start_countdown = 1;
    self waittill( #"infil_val_reset" );
    self.b_hide_ui_match_start_countdown = undefined;
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x8cc6da79, Offset: 0x33a5
// Size: 0x8c
function private function_7b86a57d161f7a4e( player )
{
    player val::reset_all( "ob_infil" );
    player.var_4a59d674db96c66a = 1;
    player notify( #"infil_val_reset" );
    player notify( #"infil_igc_finished" );
    player clearsoundsubmix( "mp_sat_ob_infil", 1 );
    player setclientdvar( @"hash_eaef35f1868b3ac2", 1 );
    function_3214823f1c456b68( "Player[" + player.name + "] completed infil." );
    thread function_3e2b0e3e2833ec37( player );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xc0464589, Offset: 0x3439
// Size: 0x20, Type: bool
function private function_e04b9b9876d8d7af( player )
{
    return istrue( level.var_bb86f77304f193c4.var_173f965a054b098a );
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x6910899b, Offset: 0x3462
// Size: 0x4d, Type: bool
function private function_51b111d3e35b0a( lhs, rhs )
{
    return lhs.script_priority < rhs.script_priority || isdefined( lhs.script_priority ) && !isdefined( rhs.script_priority );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x5295c57b, Offset: 0x34b8
// Size: 0x1ba
function private function_c65e0a9e96844dbc( storysuffix )
{
    var_f612bc4cb157ce95 = 1;
    objecttype = level.var_bb86f77304f193c4.var_419e50f583382ba0 ?? "ob_infil_point";
    
    if ( isstring( storysuffix ) )
    {
        objecttype = objecttype + "_" + storysuffix;
        var_f612bc4cb157ce95 = 0;
    }
    
    infilpoints = utility::getstructarray( objecttype, "targetname" );
    
    for ( i = 0; i < infilpoints.size ; i++ )
    {
        if ( isstring( infilpoints[ i ].script_priority ) )
        {
            infilpoints[ i ].script_priority = int( infilpoints[ i ].script_priority );
        }
    }
    
    if ( !isdefined( infilpoints ) || infilpoints.size == 0 )
    {
        if ( var_f612bc4cb157ce95 )
        {
            return function_fdcdaa3e603108a();
        }
        else
        {
            return [];
        }
    }
    
    filteredarray = [];
    
    foreach ( infilpoint in infilpoints )
    {
        if ( outofbounds::ispointinoutofbounds( infilpoint.origin, "team_players" ) )
        {
            /#
                function_87c7e25bfa2eabc3( "<dev string:xfb>" + infilpoint.origin + "<dev string:x128>" );
            #/
            
            continue;
        }
        
        filteredarray[ filteredarray.size ] = infilpoint;
    }
    
    infilpoints = filteredarray;
    infilpoints = arrayrandomize( infilpoints );
    
    if ( isstring( storysuffix ) )
    {
        infilpoints = arraysort( infilpoints, undefined, &function_51b111d3e35b0a );
    }
    
    return infilpoints;
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xbff6f9a3, Offset: 0x367b
// Size: 0xbf
function private function_64809ae134b50587( targetname )
{
    playerpoints = utility::getstructarray( targetname, "targetname" );
    
    foreach ( point in playerpoints )
    {
        point.script_priority = int( point.script_priority );
    }
    
    playerpoints = arrayrandomize( playerpoints );
    playerpoints = arraysort( playerpoints, undefined, &function_51b111d3e35b0a );
    return playerpoints;
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0xd713078a, Offset: 0x3743
// Size: 0xe2
function private function_fdcdaa3e603108a()
{
    spawnpoints = [];
    var_edfd661da95b09af = 8;
    infilheight = getdvarint( @"scr_ob_infil_height", 10000 );
    center = ( 0, 0, infilheight );
    separationangle = 360 / var_edfd661da95b09af;
    
    for ( i = 0; i < 32 ; i++ )
    {
        point = function_34f24d36df92858c( center, 20000, separationangle * i );
        var_edb277e2dd71b47c = { #origin:point };
        spawnpoints[ spawnpoints.size ] = var_edb277e2dd71b47c;
    }
    
    /#
        println( "<dev string:x13c>" );
        debug::cylinder( center, center + ( 0, 0, 1 ), 20000, ( 1, 1, 1 ), 60 );
    #/
    
    return spawnpoints;
}

// Namespace ob_infils_portal
// Params 3, eflags: 0x4
// Checksum 0x782fee02, Offset: 0x382e
// Size: 0xce
function private function_4506b2420317e728( player, spawnpoint, spawnangles )
{
    infilheight = getdvarint( @"scr_ob_infil_height", 10000 );
    spawnpoint = ( spawnpoint[ 0 ], spawnpoint[ 1 ], infilheight );
    function_7b86a57d161f7a4e( player );
    
    if ( !getdvarint( @"hash_ea4a45a654d42107", 0 ) )
    {
        player thread freefallsequence( spawnpoint, spawnangles );
    }
    
    if ( player ob_skill_select::ob_skill_select_is_active() )
    {
        player.var_65a7e747451e94 = 1;
        player val::set( "infil", "allow_skill_select", 0 );
        player notify( #"allow_skill_select" );
    }
    
    thread game_utility::fadetoblackforplayerkeepui( player, 0, 0.2 );
    player.var_8b4dd1978732538 = 1;
    player thread function_7980024f06e348f9( 1 );
}

// Namespace ob_infils_portal
// Params 3, eflags: 0x4
// Checksum 0x78c85ec4, Offset: 0x3904
// Size: 0x1c4
function private function_37b81b745b4903ee( player, spawnpoint, var_fd59b98aa7119681 )
{
    player.var_ae2f31b5ab5d5db1 = 1;
    
    if ( var_fd59b98aa7119681 || getdvarint( @"hash_45ebffbbc5b1ee8", 0 ) || utility::callsharedfunc( #"pvp_contract", #"hash_24ed85b21a923519", player ) )
    {
        infilheight = getdvarint( @"scr_ob_infil_height", 10000 );
        angles = player getplayerangles();
        deploypitch = 35;
        backdist = 10000;
        defaultregion = region_difficulty_manager::get_default_region();
        pointoob = outofbounds::ispointinoutofbounds( spawnpoint, player.team );
        
        if ( pointoob || region_difficulty_manager::function_f9fbb630598afdc7( spawnpoint ) == defaultregion )
        {
            if ( isdefined( player.var_27fd0d2a449557bf ) )
            {
                spawnpoint = player.var_27fd0d2a449557bf;
                backdist = 0;
                deploypitch = 89;
            }
            else
            {
                infilspawnpoint = function_dffa38b3d22956d6( player );
                
                if ( isdefined( infilspawnpoint ) )
                {
                    spawnpoint = infilspawnpoint;
                    backdist = 0;
                    deploypitch = 89;
                }
            }
        }
        
        var_6c701364c147136c = ( spawnpoint[ 0 ] - cos( angles[ 1 ] ) * backdist, spawnpoint[ 1 ] - sin( angles[ 1 ] ) * backdist, infilheight );
        pointoob = outofbounds::ispointinoutofbounds( var_6c701364c147136c, player.team );
        
        if ( pointoob || region_difficulty_manager::function_f9fbb630598afdc7( var_6c701364c147136c ) == defaultregion )
        {
            var_6c701364c147136c = ( spawnpoint[ 0 ], spawnpoint[ 1 ], infilheight );
            deploypitch = 89;
        }
        
        player thread function_a493719143214bb6( var_6c701364c147136c, deploypitch );
        player.var_8b4dd1978732538 = 1;
        player thread function_7980024f06e348f9( 0 );
        return;
    }
    
    function_a57a464164c6affa( player );
}

// Namespace ob_infils_portal
// Params 1
// Checksum 0x584b2cba, Offset: 0x3ad0
// Size: 0x19
function function_d7465d10fe54d67( point )
{
    return getgroundposition( point, 32, 7000, 72 );
}

// Namespace ob_infils_portal
// Params 2
// Checksum 0x506c73db, Offset: 0x3af2
// Size: 0x12a
function function_b2a877843ebea2a5( point, spawningplayer )
{
    nearplayers = getplayersinradius( point, 32, 80 );
    pushedpoint = point;
    point2d = ( point[ 0 ], point[ 1 ], 0 );
    
    foreach ( otherplayer in nearplayers )
    {
        if ( spawningplayer && otherplayer == spawningplayer )
        {
            continue;
        }
        
        var_3dc4ba3a1c17501 = ( otherplayer.origin[ 0 ], otherplayer.origin[ 1 ], 0 );
        
        if ( distancesquared( point2d, var_3dc4ba3a1c17501 ) < 400 )
        {
            respawnlocation = ob_laststand::function_92c887ce7a7f2c71( spawningplayer, otherplayer, pushedpoint );
            
            if ( respawnlocation.success )
            {
                pushedpoint = respawnlocation.origin;
                break;
            }
        }
    }
    
    return pushedpoint;
}

// Namespace ob_infils_portal
// Params 3, eflags: 0x4
// Checksum 0x77e7c7a9, Offset: 0x3c25
// Size: 0x1e3
function private function_18d5de1bbad61183( player, spawnpoint, spawnangles )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player val::set( "beginInfilGrnd", "world_fade", 1 );
    player val::set( "beginInfilGrnd", "show_hud", 0 );
    player val::set( "beginInfilGrnd", "ignoreme", 1 );
    player val::set( "beginInfilGrnd", "damage", 0 );
    player val::set( "beginInfilGrnd", "freezecontrols", 1 );
    player val::set( "beginInfilGrnd", "allow_movement", 0 );
    squad = teams::function_72b89edf6b47c40a( player );
    
    while ( squad.var_2c44544a01cc415e || player.sessionstate != "playing" )
    {
        waitframe();
    }
    
    function_7b86a57d161f7a4e( player );
    pointonground = function_d7465d10fe54d67( spawnpoint );
    player setorigin( pointonground );
    
    if ( isvector( spawnangles ) )
    {
        player setplayerangles( spawnangles );
    }
    else
    {
        lookatposition = ( 0, 0, 0 );
        
        if ( isdefined( level.contractquest[ self.sessionsquadid ].contract ) )
        {
            lookatposition = level.contractquest[ self.sessionsquadid ].contract.origin;
        }
        
        var_ad035bb53bb32b3f = lookatposition - pointonground;
        var_ad035bb53bb32b3f = vectornormalize2( var_ad035bb53bb32b3f );
        player setplayerangles( vectortoangles( var_ad035bb53bb32b3f ) );
    }
    
    player utility::players_stream_wait( [ player ] );
    player val::reset_all( "beginInfilGrnd" );
    player utility::ent_flag_set( "ob_infil_boots_on_ground" );
    game_utility::fadetoblackforplayerkeepui( player, 0, 1 );
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x1560ecdc, Offset: 0x3e10
// Size: 0x295
function private freefallsequence( spawnposition, spawnangles )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self setclientomnvar( "ui_br_altimeter_state", 2 );
    utility::callsharedfunc( #"chyron", #"hash_147f02c28c4c2b04", "end_game_intro" );
    freefalldistance = getdvarint( @"hash_5db0a07ca1709ca", 3000 );
    
    if ( !isdefined( spawnangles ) )
    {
        lookatposition = ( 0, 0, 0 );
        
        if ( isdefined( level.contractquest[ self.sessionsquadid ].contract ) )
        {
            lookatposition = level.contractquest[ self.sessionsquadid ].contract.origin;
        }
        
        var_ad035bb53bb32b3f = lookatposition - spawnposition;
        var_ad035bb53bb32b3f = utility::flatten_vector( var_ad035bb53bb32b3f );
        yaw = vectortoyaw( var_ad035bb53bb32b3f );
        spawnangles = ( 65, yaw, 0 );
    }
    
    thread function_2d3e0f7e2cb1b9fc( self, spawnposition + ( 0, 0, freefalldistance ), ( 0, spawnangles[ 1 ], 0 ), 20 );
    val::set( "ob_infil_skydive", "show_hud", 0 );
    val::set( "ob_infil_skydive", "allow_movement", 0 );
    val::set( "ob_infil_skydive", "freezecontrols_allowlook", 1 );
    
    if ( freefalldistance > 0 )
    {
        freefallstart = spawnposition + ( 0, 0, freefalldistance );
        self setorigin( freefallstart );
        self setplayerangles( ( 65, spawnangles[ 1 ], 0 ) );
        function_adfe6a8b09fe9345( self );
        self lerpfovbypreset( "65_instant_noscale" );
        self skydive_beginfreefall();
        self skydive_setdeploymentstatus( 0 );
        freefallvel = self getvelocity();
        freefallvel = ( freefallvel[ 0 ], freefallvel[ 1 ], -1200 );
        waitframe();
        self setvelocity( freefallvel );
        
        while ( self getorigin()[ 2 ] > spawnposition[ 2 ] )
        {
            wait 0.25;
        }
        
        self lerpfovbypreset( "default" );
    }
    else
    {
        self setorigin( spawnposition );
        self setplayerangles( ( 65, spawnangles[ 1 ], 0 ) );
        function_adfe6a8b09fe9345( self );
    }
    
    self skydive_setdeploymentstatus( 1 );
    self skydive_deployparachute();
    var_3345c1d37f86cce0 = self getvelocity();
    var_b276b0c578a86b0c = ( cos( spawnangles[ 1 ] ), sin( spawnangles[ 1 ] ), 0 ) * 5;
    self setvelocity( var_3345c1d37f86cce0 + var_b276b0c578a86b0c );
    wait 1;
    self function_fb7478f54c834704( 0 );
    self lerpfovbypreset( "hellstorm_missile_zoom_out" );
    wait 2.4;
    self lerpfovbypreset( "default_2seconds" );
    self function_fa215e46adf60c7d();
    val::reset_all( "ob_infil_skydive" );
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x52f5b810, Offset: 0x40ad
// Size: 0xd4
function private function_a493719143214bb6( spawnposition, deploypitch )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    self setclientomnvar( "ui_br_altimeter_state", 2 );
    playerangles = self getplayerangles( 1 );
    angles = ( deploypitch, playerangles[ 1 ], 0 );
    forward = anglestoforward( angles );
    var_db00252655788ca2 = self isswimming();
    self setorigin( spawnposition - forward * 1500 );
    self setplayerangles( angles );
    freefallvel = forward * 800;
    self skydive_beginfreefall();
    self skydive_setdeploymentstatus( 1 );
    self skydive_deployparachute();
    waitframe();
    self setvelocity( freefallvel );
    
    if ( var_db00252655788ca2 )
    {
        self enableweaponswitch();
    }
    
    function_adfe6a8b09fe9345( self );
}

// Namespace ob_infils_portal
// Params 3, eflags: 0x4
// Checksum 0x16fca6b0, Offset: 0x4189
// Size: 0x35
function private function_34f24d36df92858c( center, radius, deg )
{
    return center + ( radius * cos( deg ), radius * sin( deg ), 0 );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xafd26478, Offset: 0x41c7
// Size: 0xa5
function private function_7980024f06e348f9( var_d1d0bcdb696b1e5a )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"skydive_end" );
    
    while ( !self isonground() && !self isswimming() )
    {
        waitframe();
    }
    
    self setclientomnvar( "ui_br_altimeter_state", 0 );
    
    if ( self.var_65a7e747451e94 )
    {
        self.var_65a7e747451e94 = undefined;
        val::reset( "infil", "allow_skill_select" );
        self notify( #"allow_skill_select" );
    }
    
    self.var_8b4dd1978732538 = undefined;
    utility::ent_flag_set( "ob_infil_boots_on_ground" );
    function_a57a464164c6affa( self );
}

// Namespace ob_infils_portal
// Params 1
// Checksum 0x8cfe4c67, Offset: 0x4274
// Size: 0x75
function function_a57a464164c6affa( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( level.var_bb86f77304f193c4.var_8cc60970dae0196e > 0 )
    {
        utility::waittill_notify_or_timeout( "death", level.var_bb86f77304f193c4.var_8cc60970dae0196e );
    }
    
    player utility::ent_flag_set( "ob_infil_boots_on_ground" );
    player.var_ae2f31b5ab5d5db1 = undefined;
}

// Namespace ob_infils_portal
// Params 11, eflags: 0x4
// Checksum 0x5f8cd9ae, Offset: 0x42f1
// Size: 0xba
function private function_875afa1ed9526daf( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( victim.var_ae2f31b5ab5d5db1 )
    {
        factor = level.var_bb86f77304f193c4.var_4ce23f158e880bda ?? 1;
        
        if ( smeansofdeath != "MOD_SUICIDE" && smeansofdeath != "MOD_FALLING" )
        {
            idamage *= factor;
        }
    }
    
    return idamage;
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x68c0a8b4, Offset: 0x43b4
// Size: 0x98
function private function_f89c6bf83e2c5a0d()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( level.var_bb86f77304f193c4.var_173f965a054b098a )
    {
        return;
    }
    
    self waittill( #"infil_igc_finished" );
    
    if ( self.operatorcustomization.dialogset != #"" )
    {
        wait 5;
        event = hashcat( self.operatorcustomization.dialogset, "_avalon_general_infil" );
        overlord::playevent( event, [ self ] );
    }
}

// Namespace ob_infils_portal
// Params 4, eflags: 0x4
// Checksum 0x6982fd8d, Offset: 0x4454
// Size: 0x1f7
function private function_364629d11638608d( delaysec, var_42bf9810d46b422c, holdsec, fadeoutsec )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_88ecd18010f31c3e = newclienthudelem( self );
    self.var_88ecd18010f31c3e.x = 0;
    self.var_88ecd18010f31c3e.y = 0;
    self.var_88ecd18010f31c3e setshader( "white", 640, 480 );
    self.var_88ecd18010f31c3e.alignx = "left";
    self.var_88ecd18010f31c3e.aligny = "top";
    self.var_88ecd18010f31c3e.horzalign = "fullscreen";
    self.var_88ecd18010f31c3e.vertalign = "fullscreen";
    self.var_88ecd18010f31c3e.sort = -1;
    self.var_88ecd18010f31c3e.color = ( 1, 1, 1 );
    self.var_88ecd18010f31c3e.alpha = 0;
    self.var_88ecd18010f31c3e.foreground = 1;
    self.var_88ecd18010f31c3e setshowinrealism( 1 );
    wait delaysec;
    
    if ( !isdefined( self.var_88ecd18010f31c3e ) )
    {
        return;
    }
    
    self.var_88ecd18010f31c3e fadeovertime( var_42bf9810d46b422c );
    self.var_88ecd18010f31c3e.alpha = 1;
    wait var_42bf9810d46b422c + holdsec;
    
    if ( !isdefined( self.var_88ecd18010f31c3e ) )
    {
        return;
    }
    
    self.var_88ecd18010f31c3e fadeovertime( fadeoutsec );
    self.var_88ecd18010f31c3e.alpha = 0;
    wait fadeoutsec;
    
    if ( !isdefined( self.var_88ecd18010f31c3e ) )
    {
        return;
    }
    
    self.var_88ecd18010f31c3e destroy();
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xde3c0019, Offset: 0x4653
// Size: 0xa6
function private function_bfc7f0203dd8156b( sceneroot )
{
    duration = 0;
    shots = sceneroot scene::get_shot_names();
    
    foreach ( shotname in shots )
    {
        duration += sceneroot scene::function_b3c7b792a7a154fa( shotname );
    }
    
    return duration;
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x8e08846, Offset: 0x4702
// Size: 0x4f
function private function_25c8d45c0442064b( sceneorigin, durationsec )
{
    level endon( #"game_ended" );
    cloudfx = spawnscriptable( "ob_sat_infil_clouds_big", sceneorigin, ( 0, 0, 0 ) );
    wait durationsec;
    cloudfx freescriptable();
}

// Namespace ob_infils_portal
// Params 4, eflags: 0x4
// Checksum 0x15f1b17e, Offset: 0x4759
// Size: 0x7a
function private function_2d3e0f7e2cb1b9fc( player, spawnpoint, angles, lifetime )
{
    level endon( #"game_ended" );
    payload = [ #"teamselect", player getentitynumber() ];
    cloudfx = spawnscriptable( "ob_sat_infil_clouds_small", spawnpoint, angles, undefined, payload );
    wait lifetime;
    cloudfx freescriptable();
}

// Namespace ob_infils_portal
// Params 3, eflags: 0x4
// Checksum 0x5b8ab8b8, Offset: 0x47db
// Size: 0x9e
function private function_22c21c6206c6cef5( players, var_58bb242dbcd8b7e1, var_b483ba80eff709a7 )
{
    level endon( #"game_ended" );
    
    foreach ( player in players )
    {
        thread function_dbd82f3e03a65244( player, var_58bb242dbcd8b7e1, var_b483ba80eff709a7 );
    }
}

// Namespace ob_infils_portal
// Params 3, eflags: 0x4
// Checksum 0xba81f7b5, Offset: 0x4881
// Size: 0xad
function private function_dbd82f3e03a65244( player, var_58bb242dbcd8b7e1, var_b483ba80eff709a7 )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"squad_movie_wait_start" );
    squad = teams::function_72b89edf6b47c40a( player );
    
    if ( isdefined( squad ) )
    {
        squad endon( #"squad_movie_all" );
    }
    
    player setclientomnvar( "ui_coop_bink_overlay_state", 1 );
    player setclientomnvar( "ui_is_bink_skippable", 0 );
    player playcinematicforplayer( var_58bb242dbcd8b7e1, 1 );
    wait var_b483ba80eff709a7;
    
    if ( isdefined( player ) )
    {
        player stopcinematicforplayer();
        player setclientomnvar( "ui_coop_bink_overlay_state", 0 );
    }
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x6fe4de8a, Offset: 0x4936
// Size: 0x65, Type: bool
function private validatescenescriptbundle( scenescriptbundlename )
{
    if ( !isdefined( scenescriptbundlename ) )
    {
        return false;
    }
    
    scriptbundle = getscriptbundle( isxhashasset( scenescriptbundlename ) ? scenescriptbundlename : hashcat( %"scenescriptbundle:", scenescriptbundlename ) );
    
    if ( !isdefined( scriptbundle ) )
    {
        /#
            function_3214823f1c456b68( "<dev string:x193>" + scenescriptbundlename + "<dev string:x1be>" );
        #/
        
        return false;
    }
    
    return true;
}

// Namespace ob_infils_portal
// Params 0, eflags: 0x4
// Checksum 0x20ce24a7, Offset: 0x49a4
// Size: 0x7e1
function private function_a59564178de1b75a()
{
    assert( !isdefined( level.var_545ef9ab9c6543e5 ), "<dev string:x1e7>" );
    level.var_545ef9ab9c6543e5 = { #cache:[], #spawngroups:[] };
    level.var_545ef9ab9c6543e5.var_b9bde4b5a01582ff = [ "difficulty_undefined":#"tier_1", "difficulty6":#"tier_4", "difficulty5":#"tier_4", "difficulty_darkaether":#"tier_4", "difficulty_hard":#"tier_3", "difficulty_normal":#"tier_2", "difficulty_easy":#"tier_1" ];
    level.var_545ef9ab9c6543e5.var_bd324f950de0475 = [ 4:#"tier_4", 3:#"tier_3", #"tier_2", 1:#"tier_1" ];
    mapspawnpoints = function_c65e0a9e96844dbc();
    assert( mapspawnpoints.size > 0, "<dev string:x205>" );
    var_a436f5a8fba8622b = [ #"tier_4":{ #next:0, #spawns:[], #var_3d86edfba8f431af:1 }, #"tier_3":{ #next:0, #spawns:[], #var_3d86edfba8f431af:1 }, #"tier_2":{ #next:0, #spawns:[], #var_3d86edfba8f431af:1 }, #"tier_1":{ #next:0, #spawns:[], #var_3d86edfba8f431af:1 } ];
    
    foreach ( mapspawnpoint in mapspawnpoints )
    {
        if ( isstring( mapspawnpoint.script_tier ) )
        {
            mapspawnpoint.script_tier = int( mapspawnpoint.script_tier );
        }
        
        if ( mapspawnpoint.script_tier >= 1 && mapspawnpoint.script_tier <= 4 )
        {
            tierkey = level.var_545ef9ab9c6543e5.var_bd324f950de0475[ mapspawnpoint.script_tier ];
        }
        else
        {
            difficulty = region_difficulty_manager::get_region_difficulty( mapspawnpoint.origin );
            tierkey = level.var_545ef9ab9c6543e5.var_b9bde4b5a01582ff[ difficulty ];
        }
        
        spawn = { #next:0, #infilpoint:mapspawnpoint };
        spawn.infilpoint.startkey = tierkey;
        group = var_a436f5a8fba8622b[ tierkey ];
        group.spawns[ group.spawns.size ] = spawn;
    }
    
    foreach ( key, group in var_a436f5a8fba8622b )
    {
        if ( group.spawns.size == 0 )
        {
            continue;
        }
        
        group.var_3d86edfba8f431af = ceil( 32 / group.spawns.size );
        level.var_545ef9ab9c6543e5.spawngroups[ key ] = group;
    }
    
    if ( !isdefined( level.var_545ef9ab9c6543e5.spawngroups[ #"tier_1" ] ) )
    {
        group = { #next:0, #spawns:[ { #startkey:#"tier_1", #origin:( 50000, -50000, 5000 ) } ], #var_3d86edfba8f431af:32 };
        level.var_545ef9ab9c6543e5.spawngroups[ #"tier_1" ] = group;
    }
    
    foreach ( entry in level.var_bb86f77304f193c4.var_d1429610f1e41c45 )
    {
        if ( entry.key && entry.suffix )
        {
            mapspawnpoints = function_c65e0a9e96844dbc( entry.suffix );
            
            if ( mapspawnpoints.size > 0 )
            {
                newgroup = { #next:0, #spawns:[], #var_3d86edfba8f431af:1 };
                
                foreach ( mapspawnpoint in mapspawnpoints )
                {
                    spawn = { #next:0, #infilpoint:mapspawnpoint };
                    perplayerpoints = function_64809ae134b50587( mapspawnpoint.target );
                    
                    if ( perplayerpoints.size > 0 )
                    {
                        spawn.infilpoint.playerpoints = perplayerpoints;
                    }
                    
                    spawn.infilpoint.startkey = entry.key;
                    newgroup.spawns[ newgroup.spawns.size ] = spawn;
                }
                
                newgroup.var_3d86edfba8f431af = ceil( 32 / mapspawnpoints.size );
                level.var_545ef9ab9c6543e5.spawngroups[ entry.key ] = newgroup;
            }
        }
    }
    
    lookatpoints = utility::getstructarray( "ob_infil_lookat", "targetname" );
    level.var_545ef9ab9c6543e5.lookatpoints = [];
    
    foreach ( point in lookatpoints )
    {
        if ( isstring( point.script_tier ) )
        {
            point.script_tier = int( point.script_tier );
        }
        
        tier = level.var_545ef9ab9c6543e5.var_bd324f950de0475[ point.script_tier ];
        
        if ( isdefined( tier ) )
        {
            if ( !isdefined( level.var_545ef9ab9c6543e5.lookatpoints[ tier ] ) )
            {
                level.var_545ef9ab9c6543e5.lookatpoints[ tier ] = [];
            }
            
            level.var_545ef9ab9c6543e5.lookatpoints[ tier ][ level.var_545ef9ab9c6543e5.lookatpoints[ tier ].size ] = point.origin;
        }
    }
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x685e89be, Offset: 0x518d
// Size: 0x1f5
function private function_de851fb1f50d2aaa( teamname, squadid )
{
    assert( isdefined( level.var_545ef9ab9c6543e5 ), "<dev string:x227>" );
    startkey = function_4fd9d1183b250426( teamname, squadid );
    spawngroup = level.var_545ef9ab9c6543e5.spawngroups[ startkey ] ?? level.var_545ef9ab9c6543e5.spawngroups[ #"tier_1" ];
    spawn = spawngroup.spawns[ spawngroup.next ];
    spawngroup.next = int( mod( spawngroup.next + 1, spawngroup.spawns.size ) );
    spawnposition = spawn.infilpoint.origin;
    
    if ( level.var_bb86f77304f193c4.var_173f965a054b098a )
    {
        radius = spawn.infilpoint.radius ?? 300;
    }
    else
    {
        radius = 1000;
    }
    
    squadradius = level.var_bb86f77304f193c4.var_173f965a054b098a ? 100 : 200;
    radius = clamp( radius - squadradius, 0, radius );
    
    if ( spawngroup.var_3d86edfba8f431af > 1 )
    {
        angle = 360 / spawngroup.var_3d86edfba8f431af * spawn.next;
        spawnposition = function_34f24d36df92858c( spawnposition, radius, angle );
        spawn.next = int( mod( spawn.next + 1, spawngroup.var_3d86edfba8f431af ) );
    }
    
    return { #infilpoint:spawn.infilpoint, #position:spawnposition };
}

// Namespace ob_infils_portal
// Params 1
// Checksum 0x431f380e, Offset: 0x538b
// Size: 0x6d
function function_d90cc6bf931664bd( player )
{
    assert( isplayer( player ) );
    playerspawn = undefined;
    
    if ( isdefined( level.var_545ef9ab9c6543e5 ) )
    {
        var_c356c00922324d17 = function_a85b42d0fa11d5f9( player.team, player.sessionsquadid );
        
        if ( isdefined( var_c356c00922324d17 ) )
        {
            playerspawn = function_7d6d4303a13c5843( var_c356c00922324d17, player );
        }
    }
    
    return playerspawn;
}

// Namespace ob_infils_portal
// Params 1
// Checksum 0x1c069e08, Offset: 0x5401
// Size: 0x4d
function function_dffa38b3d22956d6( player )
{
    assert( isplayer( player ) );
    playerpos = undefined;
    playerspawn = function_d90cc6bf931664bd( player );
    
    if ( playerspawn )
    {
        playerpos = playerspawn.position;
    }
    
    return playerpos;
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x2d71a9d2, Offset: 0x5457
// Size: 0x6b
function private function_a85b42d0fa11d5f9( teamname, squadid )
{
    assert( isdefined( level.var_545ef9ab9c6543e5 ), "<dev string:x227>" );
    
    if ( !isdefined( level.var_545ef9ab9c6543e5.cache[ teamname ][ squadid ] ) )
    {
        function_b8e5bf0d65411f9c( teamname, squadid );
    }
    
    return level.var_545ef9ab9c6543e5.cache[ teamname ][ squadid ];
}

// Namespace ob_infils_portal
// Params 1
// Checksum 0x2dc1d1f9, Offset: 0x54cb
// Size: 0x88
function function_923eca4cafbaf80( player )
{
    assert( isdefined( level.var_545ef9ab9c6543e5 ), "<dev string:x227>" );
    
    if ( isdefined( level.var_545ef9ab9c6543e5.cache[ player.team ][ player.sessionsquadid ] ) )
    {
        return level.var_545ef9ab9c6543e5.cache[ player.team ][ player.sessionsquadid ].position;
    }
}

// Namespace ob_infils_portal
// Params 0
// Checksum 0x4d1aa938, Offset: 0x555c
// Size: 0xbb
function function_e2631975ae393a9d()
{
    var_280857d60d1293d4 = [];
    
    foreach ( player in level.players )
    {
        if ( !var_280857d60d1293d4[ player.sessionsquadid ] )
        {
            function_b8e5bf0d65411f9c( player.team, player.sessionsquadid );
            var_280857d60d1293d4[ player.sessionsquadid ] = 1;
        }
    }
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x24c920a3, Offset: 0x561f
// Size: 0xec
function private function_b8e5bf0d65411f9c( teamname, squadid )
{
    assert( isdefined( level.var_545ef9ab9c6543e5 ), "<dev string:x227>" );
    
    if ( !isdefined( level.var_545ef9ab9c6543e5.cache[ teamname ] ) )
    {
        level.var_545ef9ab9c6543e5.cache[ teamname ] = [];
    }
    
    spawnposition = function_de851fb1f50d2aaa( teamname, squadid );
    level.var_545ef9ab9c6543e5.cache[ teamname ][ squadid ] = { #squadid:squadid, #teamname:teamname, #next:0, #infilpoint:spawnposition.infilpoint, #position:spawnposition.position };
    return level.var_545ef9ab9c6543e5.cache[ teamname ][ squadid ];
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0xf557d22c, Offset: 0x5714
// Size: 0x28e
function private function_7d6d4303a13c5843( var_c356c00922324d17, player )
{
    squad = teams::getsquaddata( var_c356c00922324d17.teamname, var_c356c00922324d17.squadid );
    
    if ( isarray( squad.respawnlocations ) && squad.respawnlocations.size > 0 )
    {
        assert( isdefined( player.sessionuimemberindex ) );
        var_b0cf1b4901d4b5fb = int( clamp( player.sessionuimemberindex, 0, max( 0, squad.respawnlocations.size - 1 ) ) );
        spawnloc = squad.respawnlocations[ var_b0cf1b4901d4b5fb ];
        return { #angles:isvector( spawnloc ) ? undefined : spawnloc.angles, #position:isvector( spawnloc ) ? spawnloc : spawnloc.origin };
    }
    
    if ( var_c356c00922324d17.infilpoint.playerpoints.size > 0 )
    {
        playerpoint = var_c356c00922324d17.infilpoint.playerpoints[ var_c356c00922324d17.next ];
        var_c356c00922324d17.next = int( mod( var_c356c00922324d17.next + 1, var_c356c00922324d17.infilpoint.playerpoints.size ) );
        return { #angles:playerpoint.angles, #position:playerpoint.origin };
    }
    
    radius = level.var_bb86f77304f193c4.var_173f965a054b098a ? 100 : 200;
    angle = 90 * var_c356c00922324d17.next;
    spawnposition = function_34f24d36df92858c( var_c356c00922324d17.position, radius, angle );
    var_c356c00922324d17.next = int( mod( var_c356c00922324d17.next + 1, 4 ) );
    playerspawnangles = level.var_bb86f77304f193c4.var_173f965a054b098a ? var_c356c00922324d17.infilpoint.angles : function_446d2a015a111e6f( var_c356c00922324d17 );
    return { #angles:playerspawnangles, #position:spawnposition };
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xfa157f84, Offset: 0x59aa
// Size: 0x136
function private function_446d2a015a111e6f( var_c356c00922324d17 )
{
    lookatpoints = level.var_545ef9ab9c6543e5.lookatpoints[ var_c356c00922324d17.infilpoint.startkey ] ?? [ ( 0, 0, 0 ) ];
    var_b1c011ea249a79ce = undefined;
    bestdistsqr = undefined;
    
    foreach ( point in lookatpoints )
    {
        vec = point - var_c356c00922324d17.infilpoint.origin;
        distsqr = length2dsquared( vec );
        
        if ( !isdefined( bestdistsqr ) || distsqr < bestdistsqr )
        {
            bestdistsqr = distsqr;
            var_b1c011ea249a79ce = vec;
        }
    }
    
    var_b1c011ea249a79ce = vectornormalize2( var_b1c011ea249a79ce );
    angles = vectortoangles( var_b1c011ea249a79ce );
    return angles;
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x730e4573, Offset: 0x5ae9
// Size: 0x286
function private function_4fd9d1183b250426( teamname, squadid )
{
    key = #"tier_1";
    
    if ( level.squaddata[ teamname ][ squadid ].players.size == 0 )
    {
        return key;
    }
    
    lowestindex = undefined;
    
    foreach ( player in level.squaddata[ teamname ][ squadid ].players )
    {
        currentmission = story_contract_util::function_35a4b91d1599df3e( player );
        
        if ( !isdefined( currentmission.startpoint ) )
        {
            continue;
        }
        
        index = level.var_28c4907db51eb251[ currentmission.key ];
        
        if ( !isdefined( lowestindex ) || index < lowestindex )
        {
            key = currentmission.startpoint;
            lowestindex = index;
        }
    }
    
    if ( key != #"tier_1" )
    {
        return key;
    }
    
    lowestpowertier = undefined;
    
    foreach ( player in level.squaddata[ teamname ][ squadid ].players )
    {
        if ( !isdefined( lowestpowertier ) || player.powertier < lowestpowertier )
        {
            lowestpowertier = player.powertier;
        }
    }
    
    if ( isdefined( lowestpowertier ) )
    {
        if ( lowestpowertier < ( level.var_bb86f77304f193c4.var_5e8546e76bd93ca2 ?? 10 ) )
        {
            key = #"tier_1";
        }
        else if ( lowestpowertier < ( level.var_bb86f77304f193c4.var_d84a7144f4d58f97 ?? 30 ) )
        {
            key = #"tier_2";
        }
        else if ( lowestpowertier < ( level.var_bb86f77304f193c4.var_81b44f54cb4cf3e4 ?? 45 ) )
        {
            key = #"tier_3";
        }
        else
        {
            key = #"tier_4";
        }
    }
    
    return key;
}

// Namespace ob_infils_portal
// Params 1
// Checksum 0x49af5a6f, Offset: 0x5d78
// Size: 0x45, Type: bool
function function_cf564904f7af50b3( player )
{
    /#
        if ( getdvarint( @"hash_2fe0283b419ff08a", 0 ) )
        {
            return false;
        }
    #/
    
    return level.var_bb86f77304f193c4.var_3d6368d667a0a3df && !player.var_4a59d674db96c66a;
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xd5ecaefa, Offset: 0x5dc6
// Size: 0x9b
function private on_player_leave_squad( params )
{
    if ( !isdefined( level.var_545ef9ab9c6543e5 ) )
    {
        return;
    }
    
    if ( !isdefined( level.squaddata[ params.team ][ params.index ] ) )
    {
        if ( isdefined( level.var_545ef9ab9c6543e5.cache[ params.team ][ params.index ] ) )
        {
            level.var_545ef9ab9c6543e5.cache[ params.team ][ params.index ] = undefined;
        }
    }
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xcf2dfefb, Offset: 0x5e69
// Size: 0x68
function private function_adfe6a8b09fe9345( player )
{
    if ( player.sessionstate == "playing" && !isdefined( player getlinkedparent() ) )
    {
        position = player getorigin();
        position = function_d7465d10fe54d67( position );
        player.var_27fd0d2a449557bf = position;
        player.var_755ed09478df002 = player getvelocity();
    }
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x6fdc35a1, Offset: 0x5ed9
// Size: 0xda
function private function_598d417325d643bb( timeoutsec )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"end_game_screen_dismissed" );
    endonmessages = [ "scripted_widget_destroyed_" + "EndGameScreen", "end_game_screen_dismissed", "death_or_disconnect" ];
    thread utility::thread_on_notify( "hint_close_anim_complete", &function_f741f4806456d756, undefined, self, endonmessages, "EndGameScreen" );
    thread utility::thread_on_notify( "pre_infil_complete", &function_f741f4806456d756, undefined, self, endonmessages, "EndGameScreen" );
    thread utility::thread_on_notify( "infil_igc_finished", &function_f741f4806456d756, undefined, self, endonmessages, "EndGameScreen" );
    scripted_widgets::create( "EndGameScreen", "scripted_widget_three_panel_screen", { #over_everything:1 }, 1 );
    wait timeoutsec;
    function_f741f4806456d756( "EndGameScreen" );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xbb4673fd, Offset: 0x5fbb
// Size: 0x30
function private function_f741f4806456d756( ref )
{
    scripted_widgets::destroy( "EndGameScreen" );
    widgets_visibility::reset( "EndGameScreen" );
    self notify( #"end_game_screen_dismissed" );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0xbd01b807, Offset: 0x5ff3
// Size: 0x31, Type: bool
function private function_80a6da3b3dedc271( player )
{
    hasStartedAvalonFreeroam = player getplayerdata( level.var_6f9b00680ed002d8, "hasStartedAvalonFreeroam" );
    return hasStartedAvalonFreeroam == 1;
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x46d9cac1, Offset: 0x602d
// Size: 0x46
function private function_3e2b0e3e2833ec37( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player setplayerdata( level.var_6f9b00680ed002d8, "hasStartedAvalonFreeroam", 1 );
    waitframe();
    player function_432458e83a394206( 4 );
}

// Namespace ob_infils_portal
// Params 1, eflags: 0x4
// Checksum 0x15f0efd7, Offset: 0x607b
// Size: 0x1f
function private function_3214823f1c456b68( str )
{
    logstring( "PORTAL INFIL" + ": " + str );
}

// Namespace ob_infils_portal
// Params 2, eflags: 0x4
// Checksum 0x5e3c57f2, Offset: 0x60a2
// Size: 0xe4
function private function_9c5605d761757fd1( label, players )
{
    string = label;
    
    if ( players.size > 0 )
    {
        foreach ( idx, player in players )
        {
            if ( !isdefined( player ) )
            {
                string += "\n-----------[" + idx + "] <undefined>";
                continue;
            }
            
            string += "\n-----------[" + idx + "] " + player.name;
        }
    }
    else
    {
        string += " empty";
    }
    
    function_3214823f1c456b68( string );
}

/#

    // Namespace ob_infils_portal
    // Params 1, eflags: 0x4
    // Checksum 0xf09e9483, Offset: 0x618e
    // Size: 0x22, Type: dev
    function private function_87c7e25bfa2eabc3( str )
    {
        println( "<dev string:x246>" + "<dev string:x253>" + str );
    }

    // Namespace ob_infils_portal
    // Params 0
    // Checksum 0xc150049d, Offset: 0x61b8
    // Size: 0x44, Type: dev
    function function_5a5b625aaa92f33a()
    {
        devgui::function_9082edeb5db93280( "<dev string:x256>" );
        devgui::add_devgui_func( "<dev string:x260>", "<dev string:x277>", &function_ba8140dfc8cf2f5 );
        devgui::add_devgui_func( "<dev string:x28e>", "<dev string:x2a0>", &function_333f11626510d05e );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_infils_portal
    // Params 0
    // Checksum 0xa870a6, Offset: 0x6204
    // Size: 0xc9, Type: dev
    function function_ba8140dfc8cf2f5()
    {
        if ( level.var_6e16ed2f1c707b6b )
        {
            foreach ( player in level.players )
            {
                player val::set( "<dev string:x2b2>", "<dev string:x2bb>", 0 );
            }
            
            thread doinfilwithscene_clientsquadavatars( level.players, level.var_6e16ed2f1c707b6b, level.var_c25edcdc503d44d4, level.var_700dd5df08919387, level.var_51624f48ee0fe809 );
        }
    }

    // Namespace ob_infils_portal
    // Params 0, eflags: 0x4
    // Checksum 0xeee60cd1, Offset: 0x62d5
    // Size: 0x3d, Type: dev
    function private function_333f11626510d05e()
    {
        currentval = getdvarint( @"debug_draw_infil", 0 );
        setdvar( @"debug_draw_infil", !currentval );
        
        if ( !currentval )
        {
            thread function_4c2f55a75cec90dd();
        }
    }

    // Namespace ob_infils_portal
    // Params 1, eflags: 0x4
    // Checksum 0xff81bbf8, Offset: 0x631a
    // Size: 0x53, Type: dev
    function private function_c25613fab980f680( key )
    {
        if ( key == #"tier_1" || key == #"tier_2" || key == #"tier_3" || key == #"tier_4" )
        {
            return 0;
        }
        
        return 1;
    }

    // Namespace ob_infils_portal
    // Params 0, eflags: 0xc
    // Checksum 0xb29f9283, Offset: 0x6375
    // Size: 0x4ff, Type: dev
    function private function_4c2f55a75cec90dd()
    {
        self notify( #"hash_28c6dbba3b5919dd" );
        self endon( #"hash_28c6dbba3b5919dd" );
        level endon( #"game_ended" );
        
        if ( !isdefined( level.var_545ef9ab9c6543e5 ) )
        {
            return;
        }
        
        while ( getdvarint( @"debug_draw_infil", 0 ) == 1 )
        {
            foreach ( spawnkey, spawngroup in level.var_545ef9ab9c6543e5.spawngroups )
            {
                keystring = getxhashsourcename( spawnkey );
                
                foreach ( spawn in spawngroup.spawns )
                {
                    if ( function_c25613fab980f680( spawnkey ) )
                    {
                        radius = spawn.infilpoint.radius ?? 300;
                    }
                    else
                    {
                        radius = 1000;
                    }
                    
                    debug::cylinder( spawn.infilpoint.origin, spawn.infilpoint.origin + ( 0, 0, 1 ), radius, ( 1, 1, 1 ), level.framedurationseconds );
                    text = "<dev string:x2c4>" + keystring + "<dev string:x2cb>" + ( spawn.infilpoint.script_priority ?? "<dev string:x2d8>" ) + "<dev string:x2dd>";
                    debug::print3d( spawn.infilpoint.origin, text, ( 1, 1, 1 ), level.framedurationseconds );
                    
                    if ( spawn.infilpoint.playerpoints.size > 0 )
                    {
                        foreach ( point in spawn.infilpoint.playerpoints )
                        {
                            text = "<dev string:x2df>" + ( spawn.infilpoint.script_priority ?? "<dev string:x2d8>" ) + "<dev string:x2dd>";
                            debug::print3d( point.position, text, ( 0, 1, 0 ), level.framedurationseconds );
                            debug::sphere( point.position, 5, ( 1, 1, 1 ), level.framedurationseconds );
                            debug::line( spawn.infilpoint.origin, point.position, ( 0, 1, 0 ), level.framedurationseconds );
                        }
                    }
                }
            }
            
            foreach ( var_12c16f23e2119dbe, team in level.var_545ef9ab9c6543e5.cache )
            {
                foreach ( squadkey, var_c356c00922324d17 in team )
                {
                    debug::cylinder( var_c356c00922324d17.position, var_c356c00922324d17.position + ( 0, 0, 1 ), 100, ( 1, 0, 0 ), level.framedurationseconds );
                    text = "<dev string:x2eb>" + var_12c16f23e2119dbe + "<dev string:x2f3>" + squadkey + "<dev string:x2dd>";
                    debug::print3d( var_c356c00922324d17.position, text, ( 1, 0, 0 ), level.framedurationseconds );
                }
            }
            
            waitframe();
        }
    }

#/
