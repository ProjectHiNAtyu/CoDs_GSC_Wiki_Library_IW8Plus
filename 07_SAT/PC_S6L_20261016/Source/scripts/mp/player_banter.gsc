// scripts\mp\player_banter.gsc  (hash_18efd858026d70d2.gscc) (size: 11613 Bytes / 0x2d5d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6113d4ad (1628689581)
// size ...... 11613 (0x2d5d)
// includes .. 8   (offset: 0x29c1)
// strings ... 9   (offset: 0x2a01)
// dev strs .. 56  (offset: 0x2ab5)
// exports ... 21  (offset: 0x1d75)
// cseg ...... 0x10c + 0x1c69 (0x1d75)
// imports ... 69  (offset: 0x20bd)
// animtree1 . 0   (offset: 0x2d5d)
// animtree2 . 0   (offset: 0x2d5d)
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\operator;
#using scripts\mp\overlord;

#namespace player_banter;

// Namespace player_banter
// Params 0, eflags: 0x5
// Checksum 0x69790800, Offset: 0x12a
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"player_banter", undefined, &preinit, &function_8e6f42288af40642 );
}

// Namespace player_banter
// Params 0
// Checksum 0x76441f3e, Offset: 0x14f
// Size: 0x25
function preinit()
{
    level callback::add( #"player_connect", &on_player_connect );
    level.s_player_banter = spawnstruct();
}

// Namespace player_banter
// Params 0
// Checksum 0x99f166ca, Offset: 0x17c
// Size: 0x21
function function_8e6f42288af40642()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    function_2f79e43115bee810();
    
    /#
        level thread debug_player_banter();
    #/
}

// Namespace player_banter
// Params 0
// Checksum 0xdb284e56, Offset: 0x1a5
// Size: 0x3d9
function function_2f79e43115bee810()
{
    if ( overlord::function_c883d9cdcde00d28() )
    {
        utility::flag_wait( "overlord_ready" );
    }
    
    level.s_player_banter.var_2b7610a66e79ac05 = [];
    var_15c0388c9beaa362 = getscriptbundlenames( #"hash_1489568391154342" );
    
    foreach ( var_44f8e3d9973defe9 in var_15c0388c9beaa362 )
    {
        s_banter = getscriptbundle( var_44f8e3d9973defe9 );
        
        foreach ( var_27366b9be5cfe6c7 in s_banter.banterarray )
        {
            level.s_player_banter.var_2b7610a66e79ac05[ var_27366b9be5cfe6c7.bantername ] = var_27366b9be5cfe6c7.conversations;
            
            foreach ( s_conversation in var_27366b9be5cfe6c7.conversations )
            {
                s_conversation.var_1908d52fd4146b7 = [];
                
                if ( isarray( s_conversation.soundevents ) )
                {
                    foreach ( s_sound_event in s_conversation.soundevents )
                    {
                        if ( isdefined( s_sound_event.overlordconversationname ) )
                        {
                            var_957e6ec297551351 = level.overlord.conversations[ s_sound_event.overlordconversationname ];
                            
                            if ( isstring( s_sound_event.overlordconversationname ) && !isdefined( var_957e6ec297551351 ) )
                            {
                                var_957e6ec297551351 = level.overlord.conversations[ getxhash( s_sound_event.overlordconversationname ) ];
                            }
                            
                            assert( isdefined( var_957e6ec297551351 ), "<dev string:x24>" + getxhashsourcename( s_sound_event.overlordconversationname ) + "<dev string:x3b>" );
                            s_conversation.var_1908d52fd4146b7[ s_conversation.var_1908d52fd4146b7.size ] = #"overlord";
                            continue;
                        }
                        
                        s_conversation.var_1908d52fd4146b7[ s_conversation.var_1908d52fd4146b7.size ] = s_sound_event.operatorref;
                        assert( isdefined( s_sound_event.alias ) || isdefined( s_sound_event.var_8091abf05e31fb11 ), "<dev string:x4b>" + getxhashsourcename( var_27366b9be5cfe6c7.bantername ) + "<dev string:x6c>" + getxhashsourcename( s_sound_event.operatorref ) );
                    }
                }
                
                if ( var_27366b9be5cfe6c7.condition === "playersNearby" )
                {
                    s_conversation.condition = "playersNearby";
                    s_conversation.var_1118158318c00e48 = var_27366b9be5cfe6c7.var_1118158318c00e48;
                }
            }
        }
    }
    
    utility::flag_set( "player_banter_ready" );
}

// Namespace player_banter
// Params 1, eflags: 0x4
// Checksum 0x900e7be7, Offset: 0x586
// Size: 0x1f
function private on_player_connect( params )
{
    if ( isbot( self ) )
    {
        self.skip_face = 1;
    }
}

// Namespace player_banter
// Params 1
// Checksum 0x2a7829b2, Offset: 0x5ad
// Size: 0x40, Type: bool
function function_4e52fa5ab3baa17( var_8984c1f1eeea88ec )
{
    return level.s_player_banter.var_96a4d62a1a3cb7dd[ var_8984c1f1eeea88ec ] || level.s_player_banter.var_96a4d62a1a3cb7dd[ getxhash( var_8984c1f1eeea88ec ) ];
}

// Namespace player_banter
// Params 1
// Checksum 0x619769e, Offset: 0x5f6
// Size: 0x35
function function_575495aebfd95d01( b_paused = 1 )
{
    if ( b_paused )
    {
        utility::flag_set( "player_banter_paused" );
        return;
    }
    
    utility::flag_clear( "player_banter_paused" );
}

// Namespace player_banter
// Params 0
// Checksum 0xaaa6c738, Offset: 0x633
// Size: 0xd
function is_player_banter_vo_active()
{
    return utility::flag( "player_banter_playing" );
}

// Namespace player_banter
// Params 0
// Checksum 0xe8f46e7e, Offset: 0x649
// Size: 0x1a, Type: bool
function function_4e1aff6241ebea8()
{
    return isdefined( self.var_8984c1f1eeea88ec ) || isdefined( self.var_1b36ece8f91ad5f2 );
}

// Namespace player_banter
// Params 0
// Checksum 0xcc1a034d, Offset: 0x66c
// Size: 0xe
function function_850de641659a4090()
{
    utility::flag_waitopen( "player_banter_playing" );
}

// Namespace player_banter
// Params 1
// Checksum 0x9bf996d4, Offset: 0x682
// Size: 0x69, Type: bool
function function_59ab3c2fe1424d34( var_8984c1f1eeea88ec )
{
    var_6a1412db62ddfc7f = level.s_player_banter.var_2b7610a66e79ac05[ var_8984c1f1eeea88ec ];
    
    if ( isstring( var_8984c1f1eeea88ec ) && !isdefined( var_6a1412db62ddfc7f ) )
    {
        var_8984c1f1eeea88ec = getxhash( var_8984c1f1eeea88ec );
        var_6a1412db62ddfc7f = level.s_player_banter.var_2b7610a66e79ac05[ var_8984c1f1eeea88ec ];
    }
    
    if ( isdefined( var_6a1412db62ddfc7f ) )
    {
        return true;
    }
    
    return false;
}

// Namespace player_banter
// Params 4
// Checksum 0xd7b66b1a, Offset: 0x6f4
// Size: 0xe60, Type: bool
function play_banter_vo( var_8984c1f1eeea88ec, a_players, var_2c398f88238528ff, var_966642d7acc91994 = 0 )
{
    level endon( #"hash_44bf5ac7736d9879" );
    
    if ( is_player_banter_vo_active() && !var_966642d7acc91994 )
    {
        return false;
    }
    
    overlord::function_29d8b7aaf2aa133a( a_players );
    utility::flag_waitopen( "player_banter_paused" );
    
    if ( !isdefined( a_players ) )
    {
        a_players = level.players;
    }
    
    a_alive_players = [];
    
    foreach ( player in a_players )
    {
        if ( isalive( player ) && player.sessionstate == "playing" )
        {
            a_alive_players[ a_alive_players.size ] = player;
        }
    }
    
    a_players = arrayrandomize( a_alive_players );
    var_6a1412db62ddfc7f = level.s_player_banter.var_2b7610a66e79ac05[ var_8984c1f1eeea88ec ];
    
    if ( isstring( var_8984c1f1eeea88ec ) && !isdefined( var_6a1412db62ddfc7f ) )
    {
        var_8984c1f1eeea88ec = getxhash( var_8984c1f1eeea88ec );
        var_6a1412db62ddfc7f = level.s_player_banter.var_2b7610a66e79ac05[ var_8984c1f1eeea88ec ];
    }
    
    if ( !isdefined( var_6a1412db62ddfc7f ) )
    {
        assertmsg( "<dev string:x7b>" + getxhashsourcename( var_8984c1f1eeea88ec ) + "<dev string:x94>" );
        return false;
    }
    
    if ( isdefined( var_2c398f88238528ff ) )
    {
        s_current_conversation = var_6a1412db62ddfc7f[ var_2c398f88238528ff ];
        s_current_conversation.var_de7a8ed23afe8712 = undefined;
    }
    else
    {
        var_6a1412db62ddfc7f = arrayrandomize( var_6a1412db62ddfc7f );
    }
    
    var_6b186f1eee2114c = [];
    
    if ( isdefined( s_current_conversation ) )
    {
        foreach ( index, var_94f173f7903cda80 in s_current_conversation.var_1908d52fd4146b7 )
        {
            if ( var_94f173f7903cda80 === #"overlord" )
            {
                continue;
            }
            
            foreach ( player in a_players )
            {
                str_operator_ref = player.operatorcustomization.operatorref;
                
                if ( str_operator_ref === var_94f173f7903cda80 )
                {
                    var_6b186f1eee2114c[ index ] = player;
                    break;
                }
            }
        }
        
        s_current_conversation.var_de7a8ed23afe8712 = var_6b186f1eee2114c;
    }
    else
    {
        var_644f19da32417e03 = [];
        
        foreach ( s_conversation in var_6a1412db62ddfc7f )
        {
            foreach ( index, var_94f173f7903cda80 in s_conversation.var_1908d52fd4146b7 )
            {
                if ( var_94f173f7903cda80 === #"overlord" )
                {
                    continue;
                }
                
                foreach ( player in a_players )
                {
                    str_operator_ref = player.operatorcustomization.operatorref;
                    
                    if ( getxhashasset( str_operator_ref ) == getxhashasset( var_94f173f7903cda80 ) )
                    {
                        var_6b186f1eee2114c[ index ] = player;
                        player.var_9f5d6a311256fd00 = [];
                        
                        foreach ( dupe_player in a_players )
                        {
                            if ( dupe_player != player && dupe_player.operatorcustomization.operatorref === var_94f173f7903cda80 )
                            {
                                player.var_9f5d6a311256fd00[ player.var_9f5d6a311256fd00.size ] = dupe_player;
                            }
                        }
                        
                        break;
                    }
                }
            }
            
            var_252223e577df671d = 0;
            
            foreach ( var_27bd606a90aa107c in s_conversation.var_1908d52fd4146b7 )
            {
                if ( var_27bd606a90aa107c === #"overlord" )
                {
                    continue;
                }
                
                var_252223e577df671d++;
            }
            
            if ( var_6b186f1eee2114c.size > 0 && var_6b186f1eee2114c.size == var_252223e577df671d )
            {
                if ( s_conversation.condition === "playersNearby" )
                {
                    b_players_within_distance = 1;
                    n_total_distance = 0;
                    n_segments = 0;
                    
                    for ( current_player_index = 0; current_player_index < var_6b186f1eee2114c.size ; current_player_index++ )
                    {
                        player1 = var_6b186f1eee2114c[ current_player_index ];
                        
                        for ( other_player_index = current_player_index + 1; other_player_index < var_6b186f1eee2114c.size ; other_player_index++ )
                        {
                            player2 = var_6b186f1eee2114c[ other_player_index ];
                            
                            if ( !( isdefined( player1 ) && isdefined( player2 ) && isdefined( s_conversation.var_1118158318c00e48 ) ) )
                            {
                                continue;
                            }
                            
                            if ( player1 === player2 )
                            {
                                continue;
                            }
                            
                            n_distance = distance( player1.origin, player2.origin );
                            
                            if ( isarray( player1.var_9f5d6a311256fd00 ) && player1.var_9f5d6a311256fd00.size > 0 )
                            {
                                player1.var_9f5d6a311256fd00 = utility::get_array_of_closest( player2.origin, player1.var_9f5d6a311256fd00 );
                                dupe_player = player1.var_9f5d6a311256fd00[ 0 ];
                                var_491c9b1cb446006d = distance( dupe_player.origin, player2.origin );
                                
                                if ( var_491c9b1cb446006d < n_distance )
                                {
                                    n_distance = var_491c9b1cb446006d;
                                    var_6b186f1eee2114c[ current_player_index ] = dupe_player;
                                    player1 = var_6b186f1eee2114c[ current_player_index ];
                                }
                            }
                            
                            if ( isarray( player2.var_9f5d6a311256fd00 ) && player2.var_9f5d6a311256fd00.size > 0 )
                            {
                                player2.var_9f5d6a311256fd00 = utility::get_array_of_closest( player1.origin, player2.var_9f5d6a311256fd00 );
                                dupe_player = player2.var_9f5d6a311256fd00[ 0 ];
                                var_491c9b1cb446006d = distance( dupe_player.origin, player1.origin );
                                
                                if ( var_491c9b1cb446006d < n_distance )
                                {
                                    n_distance = var_491c9b1cb446006d;
                                    var_6b186f1eee2114c[ other_player_index ] = dupe_player;
                                    player2 = var_6b186f1eee2114c[ other_player_index ];
                                }
                            }
                            
                            if ( n_distance > s_conversation.var_1118158318c00e48 )
                            {
                                b_players_within_distance = 0;
                                break;
                            }
                            
                            n_total_distance += n_distance;
                            n_segments++;
                        }
                        
                        if ( !b_players_within_distance )
                        {
                            break;
                        }
                    }
                    
                    if ( b_players_within_distance )
                    {
                        var_644f19da32417e03[ var_644f19da32417e03.size ] = s_conversation;
                        s_conversation.var_de7a8ed23afe8712 = var_6b186f1eee2114c;
                        
                        if ( n_segments > 0 )
                        {
                            s_conversation.n_distance_average = n_total_distance / n_segments;
                        }
                    }
                }
                else
                {
                    var_644f19da32417e03[ var_644f19da32417e03.size ] = s_conversation;
                    s_conversation.var_de7a8ed23afe8712 = var_6b186f1eee2114c;
                }
            }
            
            var_6b186f1eee2114c = [];
        }
        
        foreach ( player in a_players )
        {
            player.var_9f5d6a311256fd00 = undefined;
        }
        
        var_644f19da32417e03 = arrayrandomize( var_644f19da32417e03 );
        s_current_conversation = var_644f19da32417e03[ 0 ];
        
        if ( isdefined( s_current_conversation.n_distance_average ) )
        {
            foreach ( s_conversation_distance in var_644f19da32417e03 )
            {
                if ( s_conversation_distance.n_distance_average < s_current_conversation.n_distance_average )
                {
                    s_current_conversation = s_conversation_distance;
                }
            }
        }
    }
    
    if ( isdefined( s_current_conversation ) )
    {
        level.s_player_banter.var_96a4d62a1a3cb7dd[ var_8984c1f1eeea88ec ] = 1;
        level.s_player_banter.var_d3b97339fa760067 = var_8984c1f1eeea88ec;
        utility::flag_set( "player_banter_playing" );
        
        if ( isdefined( s_current_conversation.var_de7a8ed23afe8712 ) )
        {
            foreach ( operator_entity in s_current_conversation.var_de7a8ed23afe8712 )
            {
                if ( isplayer( operator_entity ) )
                {
                    operator_entity.var_1b36ece8f91ad5f2 = var_8984c1f1eeea88ec;
                }
            }
        }
        
        if ( isdefined( s_current_conversation.conversationasset ) && !isdefined( var_2c398f88238528ff ) )
        {
            var_125e6d2b1bf5fcc2 = conversationstart( s_current_conversation.conversationasset, s_current_conversation.var_de7a8ed23afe8712 );
            
            foreach ( s_sound_event in s_current_conversation.soundevents )
            {
                if ( isdefined( s_sound_event.overlordconversationname ) )
                {
                    level utility::flag_set( "player_banter_playing" );
                    var_b09a27514d46423 = overlord::function_e4b6b75b01ea6bc9( s_sound_event.overlordconversationname );
                    level utility::delaythreadendon( var_b09a27514d46423 + level.framedurationseconds, "player_banter_playing", &function_3e9f31e2a0177f77, a_players );
                    overlord::playconversation( s_sound_event.overlordconversationname, a_players );
                    continue;
                }
                
                if ( isdefined( s_sound_event.alias ) )
                {
                    n_time = lookupsoundlength( s_sound_event.alias, 1 ) / 1000;
                    level utility::flag_set( "player_banter_playing" );
                    level utility::delaythreadendon( n_time + level.framedurationseconds, "player_banter_playing", &function_3e9f31e2a0177f77, a_players );
                    wait n_time;
                }
            }
        }
        else
        {
            for ( index = 0; index < s_current_conversation.soundevents.size ; index++ )
            {
                utility::flag_waitopen( "player_banter_paused" );
                s_sound_event = s_current_conversation.soundevents[ index ];
                
                if ( isdefined( s_sound_event.overlordconversationname ) )
                {
                    if ( utility::flag( "overlord_paused" ) )
                    {
                        var_b1bcafdad53bc5a5 = 1;
                        overlord::function_724ca7b94bf1fb66( 0 );
                    }
                    
                    level utility::flag_set( "player_banter_playing" );
                    var_b09a27514d46423 = overlord::function_e4b6b75b01ea6bc9( s_sound_event.overlordconversationname );
                    level utility::delaythreadendon( var_b09a27514d46423 + level.framedurationseconds, "player_banter_playing", &function_3e9f31e2a0177f77, a_players );
                    overlord::playconversation( s_sound_event.overlordconversationname, a_players, s_sound_event.delaybefore );
                    
                    if ( var_b1bcafdad53bc5a5 )
                    {
                        overlord::function_724ca7b94bf1fb66( 1 );
                        var_b1bcafdad53bc5a5 = undefined;
                    }
                    
                    if ( isdefined( s_sound_event.delayafter ) )
                    {
                        wait s_sound_event.delayafter;
                    }
                    
                    continue;
                }
                
                player = s_current_conversation.var_de7a8ed23afe8712[ index ] ?? level.players[ 0 ];
                n_delay_after = s_sound_event.delayafter ?? 0;
                n_wait = lookupsoundlength( s_sound_event.alias, 1 ) / 1000;
                level utility::flag_set( "player_banter_playing" );
                level utility::delaythreadendon( n_wait + n_delay_after + level.framedurationseconds, "player_banter_playing", &function_3e9f31e2a0177f77, a_players );
                
                if ( isalive( player ) )
                {
                    player.var_cb00b5dec3739246 = s_sound_event.alias;
                    player.var_8984c1f1eeea88ec = var_8984c1f1eeea88ec;
                    player val::set( "player_banter", "allow_battlechatter_vo", 0 );
                    
                    if ( isdefined( s_sound_event.var_8091abf05e31fb11 ) )
                    {
                        if ( isdefined( s_sound_event.delaybefore ) )
                        {
                            wait s_sound_event.delaybefore;
                        }
                        
                        player playsoundevent( s_sound_event.var_8091abf05e31fb11 );
                        wait max( n_wait + n_delay_after, 0 );
                    }
                    else
                    {
                        player dialogue::say( s_sound_event.alias, undefined, undefined, undefined, s_sound_event.delaybefore );
                        
                        if ( n_delay_after > 0 )
                        {
                            wait n_delay_after;
                        }
                    }
                    
                    player function_921dc8e5b2b9dfe2();
                }
            }
        }
        
        if ( isdefined( s_current_conversation.var_de7a8ed23afe8712 ) )
        {
            foreach ( operator_entity in s_current_conversation.var_de7a8ed23afe8712 )
            {
                if ( isplayer( operator_entity ) )
                {
                    operator_entity.var_1b36ece8f91ad5f2 = undefined;
                }
            }
        }
        
        function_3e9f31e2a0177f77( a_players );
        level.s_player_banter.var_d3b97339fa760067 = undefined;
        return true;
    }
    
    return false;
}

// Namespace player_banter
// Params 1, eflags: 0x4
// Checksum 0x1d9f2842, Offset: 0x155d
// Size: 0x9b
function private function_3e9f31e2a0177f77( a_players = level.players )
{
    level utility::flag_clear( "player_banter_playing" );
    
    foreach ( player in a_players )
    {
        player function_921dc8e5b2b9dfe2();
    }
}

// Namespace player_banter
// Params 0, eflags: 0x4
// Checksum 0x9235a997, Offset: 0x1600
// Size: 0x36
function private function_921dc8e5b2b9dfe2()
{
    if ( isdefined( self ) )
    {
        self.var_cb00b5dec3739246 = undefined;
        self.var_8984c1f1eeea88ec = undefined;
        self.var_1b36ece8f91ad5f2 = undefined;
        val::reset( "player_banter", "allow_battlechatter_vo" );
    }
}

// Namespace player_banter
// Params 2, eflags: 0x4
// Checksum 0x31219cf5, Offset: 0x163e
// Size: 0x68
function private function_ccb18d48b2bc049f( str_vo_speaker, b_force_ui_show = 0 )
{
    if ( !b_force_ui_show )
    {
        if ( isdefined( level.var_649ee89b28667c15 ) )
        {
            self [[ level.var_649ee89b28667c15 ]]();
        }
        
        return;
    }
    
    if ( b_force_ui_show && isdefined( str_vo_speaker ) )
    {
        if ( isdefined( level.var_1c8477e400cdc8c4 ) )
        {
            self [[ level.var_1c8477e400cdc8c4 ]]( str_vo_speaker );
        }
    }
}

// Namespace player_banter
// Params 1
// Checksum 0x38254498, Offset: 0x16ae
// Size: 0x3a
function function_4682263196c4e001( a_players = level.players )
{
    if ( is_player_banter_vo_active() )
    {
        level notify( #"hash_44bf5ac7736d9879" );
        function_3e9f31e2a0177f77( a_players );
    }
}

/#

    // Namespace player_banter
    // Params 0
    // Checksum 0xa6209b1f, Offset: 0x16f0
    // Size: 0x45e, Type: dev
    function debug_player_banter()
    {
        devgui::function_9082edeb5db93280( "<dev string:xcc>" );
        devgui::add_devgui_func( "<dev string:xde>", "<dev string:xf9>", &toggle_debug_info, 1 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x112>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x133>", "<dev string:x13e>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x161>", "<dev string:x16c>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x18f>", "<dev string:x198>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1b9>", "<dev string:x1c2>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e3>", "<dev string:x1f1>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x214>", "<dev string:x220>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x242>", "<dev string:x24c>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x270>", "<dev string:x27c>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a0>", "<dev string:x2ab>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2ce>", "<dev string:x2d9>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2fc>", "<dev string:x305>", &function_12476521fe6a1efc );
        devgui::function_cd4e263c1f3018ae( "<dev string:x326>", "<dev string:x32f>", &function_12476521fe6a1efc );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x350>" );
        
        foreach ( var_8984c1f1eeea88ec, var_7afd31beaf1245fd in level.s_player_banter.var_2b7610a66e79ac05 )
        {
            devgui::function_cd4e263c1f3018ae( getxhashsourcename( var_8984c1f1eeea88ec ) + "<dev string:x365>", "<dev string:x385>" + getxhashsourcename( var_8984c1f1eeea88ec ) + "<dev string:x39a>", &debug_play_banter );
            
            foreach ( index, s_conversation in var_7afd31beaf1245fd )
            {
                var_4c3d78fc4693f38c = "<dev string:x3ba>";
                str_conversation_name = "<dev string:x3ba>";
                
                foreach ( var_a5a55bce88b9fa89, var_94f173f7903cda80 in s_conversation.var_1908d52fd4146b7 )
                {
                    if ( var_94f173f7903cda80 === #"overlord" )
                    {
                        var_4c3d78fc4693f38c = "<dev string:x3bb>";
                    }
                    else
                    {
                        switch ( var_94f173f7903cda80 )
                        {
                            case %"t10_rus_pl_weaver":
                            case %"sat_rus_pl_weaver":
                                var_4c3d78fc4693f38c = "<dev string:x3c4>";
                                break;
                            case %"t10_usa_pl_carver":
                            case %"sat_usa_pl_carver":
                                var_4c3d78fc4693f38c = "<dev string:x3cb>";
                                break;
                            case %"t10_gbr_pl_grey":
                            case %"sat_gbr_pl_grey":
                                var_4c3d78fc4693f38c = "<dev string:x3d2>";
                                break;
                            case %"sat_phl_pl_maya":
                            case %"t10_phl_pl_maya":
                                var_4c3d78fc4693f38c = "<dev string:x3d7>";
                                break;
                            case %"sat_ger_pl_purple":
                                var_4c3d78fc4693f38c = "<dev string:x3dc>";
                                break;
                            case %"sat_usa_pl_amber":
                                var_4c3d78fc4693f38c = "<dev string:x3e6>";
                                break;
                            case %"sat_jpn_pl_scarlet":
                                var_4c3d78fc4693f38c = "<dev string:x3ee>";
                                break;
                            case %"sat_rus_pl_magenta":
                                var_4c3d78fc4693f38c = "<dev string:x3f4>";
                                break;
                        }
                    }
                    
                    str_conversation_name += var_4c3d78fc4693f38c;
                    
                    if ( var_a5a55bce88b9fa89 != s_conversation.var_1908d52fd4146b7.size - 1 )
                    {
                        str_conversation_name += "<dev string:x3fc>";
                    }
                }
                
                devgui::function_cd4e263c1f3018ae( getxhashsourcename( var_8984c1f1eeea88ec ) + "<dev string:x3fe>" + index + "<dev string:x400>" + str_conversation_name + "<dev string:x403>", "<dev string:x385>" + getxhashsourcename( var_8984c1f1eeea88ec ) + "<dev string:x405>" + index, &debug_play_banter );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace player_banter
    // Params 0
    // Checksum 0x9dcf4aaf, Offset: 0x1b56
    // Size: 0x11a, Type: dev
    function toggle_debug_info()
    {
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( isdefined( player.var_cb00b5dec3739246 ) && isdefined( player.var_8984c1f1eeea88ec ) )
                {
                    color = utility::array_random( [ ( 0.5, 0.5, 1 ), ( 1, 0, 0 ) ] );
                    print3d( player.origin, getxhashsourcename( player.var_8984c1f1eeea88ec ) + "<dev string:x407>" + getxhashsourcename( player.var_cb00b5dec3739246 ), ( 0.5, 0.5, 1 ), undefined, 0.35, undefined, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace player_banter
    // Params 1
    // Checksum 0x16ccfe0e, Offset: 0x1c78
    // Size: 0xb7, Type: dev
    function function_12476521fe6a1efc( params )
    {
        str_operator_ref = getxhashasset( params[ 0 ] );
        s_spawn_info = spawnstruct();
        s_spawn_info.origin = devgui::function_97024c0a6d1256a6();
        s_spawn_info.angles = level.players[ 0 ] getplayerangles();
        level thread [[ level.bot_funcs[ "<dev string:x410>" ] ]]( 1, level.players[ 0 ].team, undefined, undefined, undefined, undefined, s_spawn_info );
        level waittill( #"player_spawned", player );
        player operator::createoperatorcustomization( str_operator_ref, player operator::function_447fce2531e40d0e( str_operator_ref ) );
    }

    // Namespace player_banter
    // Params 1
    // Checksum 0xe764669d, Offset: 0x1d37
    // Size: 0x3e, Type: dev
    function debug_play_banter( params )
    {
        if ( params[ 1 ] == "<dev string:x41b>" )
        {
            level thread play_banter_vo( params[ 0 ] );
            return;
        }
        
        level thread play_banter_vo( params[ 0 ], undefined, int( params[ 1 ] ) );
    }

#/
