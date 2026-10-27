// script_162f01e3286930e2  (hash_162f01e3286930e2.gscc) (size: 22601 Bytes / 0x5849 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c440f2d (1011093293)
// size ...... 22601 (0x5849)
// includes .. 3   (offset: 0x5561)
// strings ... 35  (offset: 0x5579)
// dev strs .. 2   (offset: 0x582d)
// exports ... 60  (offset: 0x3be5)
// cseg ...... 0x392 + 0x3853 (0x3be5)
// imports ... 117 (offset: 0x4545)
// animtree1 . 0   (offset: 0x5849)
// animtree2 . 0   (offset: 0x5849)
#using script_6f9701cc1b74444b;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace vote_system_shared;

// Namespace vote_system_shared
// Params 0, eflags: 0x4
// Checksum 0x42dee5a9, Offset: 0x3b0
// Size: 0x13, Type: bool
function private function_3d08e8637ef806cb()
{
    return getdvarint( @"hash_49ff1f612a59c5bf", 0 ) == 1;
}

// Namespace vote_system_shared
// Params 1, eflags: 0x4
// Checksum 0x6a12a61a, Offset: 0x3cc
// Size: 0x18, Type: bool
function private function_2d2e3306876c8ccb( var_4185eab05d5f797e )
{
    return var_4185eab05d5f797e && function_3d08e8637ef806cb();
}

// Namespace vote_system_shared
// Params 4, eflags: 0x4
// Checksum 0xd6915ef4, Offset: 0x3ed
// Size: 0x39e
function private function_9d410aaf26e58df6( player, s_vote, var_bb737847684e6274, b_allow_alive = 0 )
{
    if ( !function_3d08e8637ef806cb() )
    {
        return;
    }
    
    if ( !b_allow_alive && !player isspectatinganyone() )
    {
        return;
    }
    
    if ( !hasomnvar( "ui_squad_vote_text_notify" ) )
    {
        return;
    }
    
    init_message = s_vote.init_message_omnvar ?? "none";
    description = s_vote.description_omnvar ?? "none";
    header = s_vote.header_omnvar ?? "none";
    header_result_1 = s_vote.var_cf443a7c10e8da3a ?? "none";
    header_result_2 = s_vote.var_8de07faa894bf315 ?? "none";
    player setclientomnvar( "ui_squad_vote_init_message", init_message );
    player setclientomnvar( "ui_squad_vote_description", description );
    player setclientomnvar( "ui_squad_vote_header", header );
    player setclientomnvar( "ui_squad_vote_header_result_1", header_result_1 );
    player setclientomnvar( "ui_squad_vote_header_result_2", header_result_2 );
    player setclientomnvar( "ui_squad_vote_players_needed", var_bb737847684e6274 );
    var_21a260bb2e643bd0 = s_vote.var_bf284adce0359502 && s_vote.enable_cancel && s_vote.e_starter && player == s_vote.e_starter;
    
    if ( var_21a260bb2e643bd0 )
    {
        var_7727bbdfa397b825 = "none";
        var_7727b8dfa397b18c = s_vote.var_22d182fc8263c9f2 ?? "none";
        player_vote_1 = "none";
        player_vote_2 = s_vote.player_cancel_omnvar ?? "none";
        player_cancel = s_vote.player_cancel_omnvar ?? "none";
        player_vote_result = 0;
    }
    else
    {
        var_6e3fd3a489d9720c = s_vote.var_ab5184cfea519870 || ( s_vote.var_bf284adce0359502 ? player != s_vote.e_starter : player == s_vote.e_starter );
        var_7727bbdfa397b825 = var_6e3fd3a489d9720c ? s_vote.var_89cf47e6af2f880d ?? "none" : "none";
        var_7727b8dfa397b18c = var_6e3fd3a489d9720c ? s_vote.var_f13ea9060d6f3112 ?? "none" : "none";
        
        if ( arraycontains( s_vote.a_players_accepted, player ) )
        {
            player_vote_1 = s_vote.var_3b1d39af5974251e ?? "none";
            player_vote_2 = "none";
            player_vote_result = 1;
        }
        else if ( arraycontains( s_vote.a_players_declined, player ) )
        {
            player_vote_1 = "none";
            player_vote_2 = s_vote.var_5b37d6a26edc0049 ?? "none";
            player_vote_result = -1;
        }
        else
        {
            player_vote_1 = s_vote.var_3b1d39af5974251e ?? "none";
            player_vote_2 = s_vote.var_5b37d6a26edc0049 ?? "none";
            player_vote_result = 0;
        }
        
        player_cancel = "none";
    }
    
    player setclientomnvar( "ui_squad_vote_choice_1", var_7727bbdfa397b825 );
    player setclientomnvar( "ui_squad_vote_choice_2", var_7727b8dfa397b18c );
    player setclientomnvar( "ui_squad_vote_player_vote_1", player_vote_1 );
    player setclientomnvar( "ui_squad_vote_player_vote_2", player_vote_2 );
    player setclientomnvar( "ui_squad_vote_player_cancel", player_cancel );
    player setclientomnvar( "ui_squad_vote_player_vote_result", player_vote_result );
    player setclientomnvar( "ui_squad_vote_text_notify", gettime() );
}

// Namespace vote_system_shared
// Params 0
// Checksum 0x3d46d642, Offset: 0x793
// Size: 0x8
function register_vote_hud()
{
    return namespace_b6e912eaebaaa52b::register();
}

// Namespace vote_system_shared
// Params 2
// Checksum 0x3cb6317a, Offset: 0x7a4
// Size: 0x1e
function function_48e94cd3f360f966( vote_hud, player )
{
    return vote_hud namespace_b6e912eaebaaa52b::is_open( player );
}

// Namespace vote_system_shared
// Params 2
// Checksum 0xcfd3e439, Offset: 0x7cb
// Size: 0x2c
function function_78dc38ac6405a036( vote_hud, player )
{
    if ( !function_48e94cd3f360f966( vote_hud, player ) )
    {
        vote_hud namespace_b6e912eaebaaa52b::open( player );
    }
}

// Namespace vote_system_shared
// Params 2
// Checksum 0xfcbeaffb, Offset: 0x7ff
// Size: 0x1f
function function_1b99f1679929a661( vote_hud, player )
{
    vote_hud namespace_b6e912eaebaaa52b::close( player );
}

// Namespace vote_system_shared
// Params 5
// Checksum 0x54f5f23b, Offset: 0x826
// Size: 0x23d
function function_ffdd1bfcb0dbe696( s_vote, var_3faf858e79cd17bb, squad, var_ab5184cfea519870 = 0, var_bf284adce0359502 = 0 )
{
    var_2f458d09795f253a = squad.players.size;
    
    foreach ( player in squad.players )
    {
        if ( hasomnvar( "ui_start_countdown" ) )
        {
            var_dd28bc2e827210b8 = 45;
            
            if ( isdefined( s_vote.var_cb4007b1432d6751 ) )
            {
                var_dd28bc2e827210b8 = max( 0, int( ( s_vote.var_cb4007b1432d6751 - gettime() ) / 1000 ) );
            }
            
            player setclientomnvar( "ui_start_countdown", var_dd28bc2e827210b8 );
        }
        
        if ( hasomnvar( "ui_allies_alive" ) )
        {
            player setclientomnvar( "ui_allies_alive", var_2f458d09795f253a );
        }
        
        if ( var_bf284adce0359502 && s_vote.enable_cancel && s_vote.e_starter && player == s_vote.e_starter )
        {
            continue;
        }
        
        if ( var_ab5184cfea519870 )
        {
            b_show_options = 1;
        }
        else if ( var_bf284adce0359502 )
        {
            b_show_options = player != s_vote.e_starter;
        }
        else
        {
            b_show_options = player == s_vote.e_starter;
        }
        
        hiddenspectating = player isspectatinganyone() && !var_3faf858e79cd17bb.var_4185eab05d5f797e;
        
        if ( !function_48e94cd3f360f966( s_vote.vote_hud, player ) && !hiddenspectating )
        {
            var_4a4b04144cebbd2f = player == s_vote.e_starter;
            function_32760b16291896bd( player, s_vote, &"hash_3ec72a6e5753b8d9", &"zm_hud/accepted", &"hash_4abc1c392c70a774", &"hash_4933eba2a07ee11f", &"hash_34c26c26c88268b8", var_4a4b04144cebbd2f, var_bf284adce0359502, b_show_options );
        }
    }
}

// Namespace vote_system_shared
// Params 3
// Checksum 0xc20374ef, Offset: 0xa6b
// Size: 0x309
function function_118a73b52a56751d( s_vote, var_3faf858e79cd17bb, player )
{
    hiddenspectating = player isspectatinganyone() && !var_3faf858e79cd17bb.var_4185eab05d5f797e;
    
    if ( !hiddenspectating )
    {
        vote_initiator = isdefined( s_vote.e_starter ) ? s_vote.e_starter getentitynumber() : 0;
        cancel_choice = s_vote.choice_cancel ?? &"lua_menu/cancel";
        cancel_result = s_vote.player_cancel ?? &"sat_ob/cancelled";
        update_players_count( s_vote );
        
        if ( function_2d2e3306876c8ccb( var_3faf858e79cd17bb.var_4185eab05d5f797e ) )
        {
            function_9d410aaf26e58df6( player, s_vote, s_vote.players_count, 1 );
            function_78dc38ac6405a036( s_vote.vote_hud, player );
            return;
        }
        
        function_78dc38ac6405a036( s_vote.vote_hud, player );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_87fd87c10d3b04e( player, s_vote.init_message ?? &"script/empty_string" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::set_description( player, s_vote.description ?? &"script/empty_string" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::set_header( player, s_vote.header ?? &"hash_3ec72a6e5753b8d9" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_9860ff088a9c5e61( player, &"script/empty_string" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_9860fc088a9c57c8( player, cancel_result );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_7407975770042e8c( player, &"script/empty_string" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_74079a5770043525( player, cancel_choice );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_557768b681cc68b( player, &"script/empty_string" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_557778b681cc8be( player, cancel_result );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_e5d1cb4112ef9661( player, s_vote.var_bf284adce0359502 ? &"hash_42f39860a4799fad" : &"hash_6fcacfb14a85efd9" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::function_a671d9bffaf75eda( player, s_vote.var_bf284adce0359502 ? &"hash_5491d0b0af0aa945" : &"hash_184eb59a5058bcc1" );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::set_initiator( player, vote_initiator );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::set_is_player_initiator( player, 0 );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::set_players_count( player, s_vote.players_count );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::set_player_vote( player, 0 );
        s_vote.vote_hud namespace_b6e912eaebaaa52b::set_vote_result( player, 0 );
    }
}

// Namespace vote_system_shared
// Params 3
// Checksum 0x8f065f35, Offset: 0xd7c
// Size: 0x145
function function_d65c80eaf108da5d( s_vote, n_delay, squad )
{
    if ( n_delay > 0 )
    {
        foreach ( player in squad.players )
        {
            if ( function_48e94cd3f360f966( s_vote.vote_hud, player ) )
            {
                wait n_delay;
                break;
            }
        }
    }
    
    foreach ( player in squad.players )
    {
        if ( function_48e94cd3f360f966( s_vote.vote_hud, player ) )
        {
            function_1b99f1679929a661( s_vote.vote_hud, player );
        }
    }
}

// Namespace vote_system_shared
// Params 1, eflags: 0x4
// Checksum 0xa4264243, Offset: 0xec9
// Size: 0x4d
function private update_players_count( s_vote )
{
    s_vote.players_count = s_vote.var_bf284adce0359502 ? s_vote.a_players_accepted.size : s_vote.var_adaf055e5d71bfbc - s_vote.a_players_accepted.size;
}

// Namespace vote_system_shared
// Params 10, eflags: 0x4
// Checksum 0x4c18252, Offset: 0xf1e
// Size: 0x4bf
function private function_32760b16291896bd( player, s_vote, default_header, var_362dabf82c5e259a, var_362daaf82c5e2367, var_8b8a80caa9b12eee, var_8b8a7fcaa9b12cbb, is_player_initiator, var_bf284adce0359502, var_6e3fd3a489d9720c = is_player_initiator )
{
    var_b872c925951700e1 = function_2d2e3306876c8ccb( s_vote.var_4185eab05d5f797e );
    vote_initiator = isdefined( s_vote.e_starter ) ? s_vote.e_starter getentitynumber() : 0;
    s_vote.init_message = s_vote.init_message ?? &"script/empty_string";
    s_vote.description = s_vote.description ?? &"script/empty_string";
    s_vote.header = s_vote.header ?? default_header;
    s_vote.var_5c854591406ed04 = s_vote.var_5c854591406ed04 ?? var_362dabf82c5e259a;
    s_vote.var_5c857591406f39d = s_vote.var_5c857591406f39d ?? var_362daaf82c5e2367;
    s_vote.player_vote_1 = s_vote.player_vote_1 ?? var_8b8a80caa9b12eee;
    s_vote.player_vote_2 = s_vote.player_vote_2 ?? var_8b8a7fcaa9b12cbb;
    
    if ( var_6e3fd3a489d9720c )
    {
        var_2cd7c3bd27d453f = s_vote.var_7727bbdfa397b825 ?? &"lua_menu/accept";
        var_2cd7d3bd27d4772 = s_vote.var_7727b8dfa397b18c ?? &"lua_menu/decline";
        var_7bb11bb3dc942097 = s_vote.var_89cf47e6af2f880d ?? "none";
        var_3450c309c71f2248 = s_vote.var_f13ea9060d6f3112 ?? "none";
    }
    else
    {
        var_2cd7c3bd27d453f = &"script/empty_string";
        var_2cd7d3bd27d4772 = &"script/empty_string";
        var_7bb11bb3dc942097 = "none";
        var_3450c309c71f2248 = "none";
    }
    
    if ( !isdefined( s_vote.var_bf284adce0359502 ) )
    {
        s_vote.var_bf284adce0359502 = istrue( var_bf284adce0359502 );
    }
    
    update_players_count( s_vote );
    
    if ( var_b872c925951700e1 )
    {
        function_9d410aaf26e58df6( player, s_vote, s_vote.players_count, 1 );
    }
    
    if ( hasomnvar( "ui_start_countdown" ) )
    {
        var_dd28bc2e827210b8 = 45;
        
        if ( isdefined( s_vote.var_cb4007b1432d6751 ) )
        {
            var_dd28bc2e827210b8 = max( 0, int( ( s_vote.var_cb4007b1432d6751 - gettime() ) / 1000 ) );
        }
        
        player setclientomnvar( "ui_start_countdown", var_dd28bc2e827210b8 );
    }
    
    function_78dc38ac6405a036( s_vote.vote_hud, player );
    
    if ( var_b872c925951700e1 )
    {
        return;
    }
    
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_87fd87c10d3b04e( player, s_vote.init_message );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_description( player, s_vote.description );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_header( player, s_vote.header );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_9860ff088a9c5e61( player, s_vote.var_5c854591406ed04 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_9860fc088a9c57c8( player, s_vote.var_5c857591406f39d );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_7407975770042e8c( player, var_2cd7c3bd27d453f );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_74079a5770043525( player, var_2cd7d3bd27d4772 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_557768b681cc68b( player, s_vote.player_vote_1 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_557778b681cc8be( player, s_vote.player_vote_2 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_e5d1cb4112ef9661( player, s_vote.var_bf284adce0359502 ? &"hash_42f39860a4799fad" : &"hash_6fcacfb14a85efd9" );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_a671d9bffaf75eda( player, s_vote.var_bf284adce0359502 ? &"hash_5491d0b0af0aa945" : &"hash_184eb59a5058bcc1" );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_initiator( player, vote_initiator );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_is_player_initiator( player, is_player_initiator );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_players_count( player, s_vote.players_count );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_player_vote( player, 0 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_vote_result( player, 0 );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x3fee7f05, Offset: 0x13e5
// Size: 0x7c, Type: bool
function function_932a27e677b1ce60( var_601a9be5417aec8c )
{
    voteprevented = utility::flag( "zm_vote_active" ) || utility::flag( "exfil_active" );
    
    if ( self != level && isarray( self.players ) )
    {
        voteprevented = utility::ent_flag( "zm_vote_active" ) || utility::ent_flag( "exfil_active" );
    }
    
    if ( voteprevented )
    {
        if ( isdefined( var_601a9be5417aec8c ) )
        {
            level thread [[ var_601a9be5417aec8c ]]( undefined, 0 );
        }
        
        return true;
    }
    
    return false;
}

// Namespace vote_system_shared
// Params 0
// Checksum 0x17a9b2bf, Offset: 0x146a
// Size: 0x29
function function_5b06e345046c1f58()
{
    s_squad = spawnstruct();
    s_squad.players = level.players;
    return s_squad;
}

// Namespace vote_system_shared
// Params 4
// Checksum 0xcaf82728, Offset: 0x149c
// Size: 0x47
function function_5f3e7ae15b92c1a6( s_vote, var_3faf858e79cd17bb, var_ab5184cfea519870, var_bf284adce0359502 )
{
    s_squad = function_5b06e345046c1f58();
    function_ffdd1bfcb0dbe696( s_vote, var_3faf858e79cd17bb, s_squad, var_ab5184cfea519870, var_bf284adce0359502 );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0xadcf5cb2, Offset: 0x14eb
// Size: 0x28
function function_752a0cdea978e60e( s_vote )
{
    s_squad = function_5b06e345046c1f58();
    function_5957b1eb0fdb5b1e( s_vote, s_squad );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x469be0ce, Offset: 0x151b
// Size: 0x28
function function_ef294a79ae99e889( s_vote )
{
    s_squad = function_5b06e345046c1f58();
    function_8062c2aca29e1481( s_vote, s_squad );
}

// Namespace vote_system_shared
// Params 2
// Checksum 0xa7aee9d3, Offset: 0x154b
// Size: 0x32
function function_559077787377cc42( s_vote, b_vote_accepted )
{
    s_squad = function_5b06e345046c1f58();
    function_2740338293f3a3ea( s_vote, b_vote_accepted, s_squad );
}

// Namespace vote_system_shared
// Params 2
// Checksum 0x7520c4f2, Offset: 0x1585
// Size: 0x32
function function_fd6d54427847bcfd( s_vote, n_delay )
{
    s_squad = function_5b06e345046c1f58();
    function_d65c80eaf108da5d( s_vote, n_delay, s_squad );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x86c7ae01, Offset: 0x15bf
// Size: 0x99
function function_8d3121fa204f0320( vote_hud )
{
    foreach ( player in level.players )
    {
        if ( isdefined( vote_hud ) && function_48e94cd3f360f966( vote_hud, player ) )
        {
            function_1b99f1679929a661( vote_hud, player );
        }
    }
}

// Namespace vote_system_shared
// Params 2, eflags: 0x4
// Checksum 0x9873a820, Offset: 0x1660
// Size: 0x248
function private function_b6be1101451002dd( s_vote, var_3faf858e79cd17bb = spawnstruct() )
{
    s_vote.init_message = var_3faf858e79cd17bb.init_message;
    s_vote.description = var_3faf858e79cd17bb.description;
    s_vote.header = var_3faf858e79cd17bb.header;
    s_vote.var_5c854591406ed04 = var_3faf858e79cd17bb.var_5c854591406ed04;
    s_vote.var_5c857591406f39d = var_3faf858e79cd17bb.var_5c857591406f39d;
    s_vote.var_7727bbdfa397b825 = var_3faf858e79cd17bb.var_7727bbdfa397b825;
    s_vote.var_7727b8dfa397b18c = var_3faf858e79cd17bb.var_7727b8dfa397b18c;
    s_vote.choice_cancel = var_3faf858e79cd17bb.choice_cancel;
    s_vote.player_vote_1 = var_3faf858e79cd17bb.player_vote_1;
    s_vote.player_vote_2 = var_3faf858e79cd17bb.player_vote_2;
    s_vote.player_cancel = var_3faf858e79cd17bb.player_cancel;
    s_vote.init_message_omnvar = var_3faf858e79cd17bb.init_message_omnvar;
    s_vote.description_omnvar = var_3faf858e79cd17bb.description_omnvar;
    s_vote.header_omnvar = var_3faf858e79cd17bb.header_omnvar;
    s_vote.var_cf443a7c10e8da3a = var_3faf858e79cd17bb.var_cf443a7c10e8da3a;
    s_vote.var_8de07faa894bf315 = var_3faf858e79cd17bb.var_8de07faa894bf315;
    s_vote.var_89cf47e6af2f880d = var_3faf858e79cd17bb.var_89cf47e6af2f880d;
    s_vote.var_f13ea9060d6f3112 = var_3faf858e79cd17bb.var_f13ea9060d6f3112;
    s_vote.var_22d182fc8263c9f2 = var_3faf858e79cd17bb.var_22d182fc8263c9f2;
    s_vote.var_3b1d39af5974251e = var_3faf858e79cd17bb.var_3b1d39af5974251e;
    s_vote.var_5b37d6a26edc0049 = var_3faf858e79cd17bb.var_5b37d6a26edc0049;
    s_vote.player_cancel_omnvar = var_3faf858e79cd17bb.player_cancel_omnvar;
    s_vote.var_4185eab05d5f797e = var_3faf858e79cd17bb.var_4185eab05d5f797e;
    s_vote.var_6c8c12c741515514 = var_3faf858e79cd17bb.var_6c8c12c741515514;
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x68d791b1, Offset: 0x18b0
// Size: 0x41
function function_47e42a6b3e1c8e82( a_players )
{
    assert( a_players.size <= 4, "<dev string:x24>" + a_players.size );
    return int( ceil( a_players.size * getdvarfloat( @"hash_dd9310e204f05a1f", 0.75 ) ) );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x8c8e7594, Offset: 0x18fa
// Size: 0x2c
function function_958e8663104a59ed( a_players )
{
    s_squad = spawnstruct();
    s_squad.players = a_players;
    return s_squad;
}

// Namespace vote_system_shared
// Params 6
// Checksum 0x311fd06b, Offset: 0x192f
// Size: 0xad
function function_2ffcb16b23fc1761( vote_hud, a_players_accepted, a_players_declined, var_adaf055e5d71bfbc, e_starter, var_bf284adce0359502 = 0 )
{
    s_vote = spawnstruct();
    s_vote.vote_hud = vote_hud;
    s_vote.a_players_accepted = a_players_accepted;
    s_vote.a_players_declined = a_players_declined;
    s_vote.var_adaf055e5d71bfbc = var_adaf055e5d71bfbc;
    s_vote.var_bf284adce0359502 = var_bf284adce0359502;
    
    if ( isdefined( e_starter ) )
    {
        s_vote.e_starter = e_starter;
    }
    
    return s_vote;
}

// Namespace vote_system_shared
// Params 6
// Checksum 0xf516d418, Offset: 0x19e5
// Size: 0xb0
function function_d2da42a6b09b2c9( e_starter, var_3faf858e79cd17bb, vote_hud, a_players_accepted, var_adaf055e5d71bfbc, var_bf284adce0359502 = 0 )
{
    s_vote = spawnstruct();
    s_vote.e_starter = e_starter;
    s_vote.vote_hud = vote_hud;
    s_vote.a_players_accepted = a_players_accepted;
    s_vote.a_players_declined = [];
    s_vote.var_adaf055e5d71bfbc = var_adaf055e5d71bfbc;
    s_vote.var_bf284adce0359502 = var_bf284adce0359502;
    function_b6be1101451002dd( s_vote, var_3faf858e79cd17bb );
    return s_vote;
}

// Namespace vote_system_shared
// Params 1, eflags: 0x4
// Checksum 0x27b8ebac, Offset: 0x1a9e
// Size: 0x5b
function private function_f85c8e1949782247( b_passed = 0 )
{
    s_vote = spawnstruct();
    s_vote.a_players_accepted = [];
    s_vote.a_players_declined = [];
    s_vote.cancelled = 0;
    s_vote.b_passed = b_passed;
    return s_vote;
}

// Namespace vote_system_shared
// Params 4
// Checksum 0x392fe805, Offset: 0x1b02
// Size: 0xb6
function init_vote_struct( e_starter, var_3faf858e79cd17bb, votehud, a_players )
{
    s_vote = spawnstruct();
    s_vote.e_starter = e_starter;
    s_vote.a_players_accepted = [];
    s_vote.a_players_declined = [];
    function_b6be1101451002dd( s_vote, var_3faf858e79cd17bb );
    s_vote.vote_hud = votehud;
    s_vote.var_be908c4fc7caf076 = a_players;
    s_vote.active = 1;
    s_vote.cancelled = 0;
    s_vote.var_adaf055e5d71bfbc = function_47e42a6b3e1c8e82( a_players );
    return s_vote;
}

// Namespace vote_system_shared
// Params 1
// Checksum 0xda9287f8, Offset: 0x1bc1
// Size: 0xd6
function register_vote_callbacks( b_skip_hotjoin = 0 )
{
    if ( !b_skip_hotjoin )
    {
        if ( !level callback::exists( #"player_spawned", &function_64a91d98e55921bb ) )
        {
            level callback::add( #"player_spawned", &function_64a91d98e55921bb );
        }
        
        if ( !level callback::exists( #"player_connect", &auto_accept_vote ) )
        {
            level callback::add( #"player_connect", &auto_accept_vote );
        }
    }
    
    if ( !level callback::exists( #"player_disconnect", &player_disconnect ) )
    {
        level callback::add( #"player_disconnect", &player_disconnect );
    }
    
    if ( !level callback::exists( #"player_death", &auto_accept_vote ) )
    {
        level callback::add( #"player_death", &auto_accept_vote );
    }
}

// Namespace vote_system_shared
// Params 4
// Checksum 0xf749d06, Offset: 0x1c9f
// Size: 0xf2
function function_bddbed1ff9a6c189( s_vote, var_3faf858e79cd17bb, a_players, var_eaefaf4a9fe6c76f )
{
    foreach ( player in a_players )
    {
        var_b16c2f6426d3b6d = 0;
        
        if ( isdefined( var_eaefaf4a9fe6c76f ) )
        {
            var_b16c2f6426d3b6d = !player [[ var_eaefaf4a9fe6c76f ]]();
        }
        else
        {
            var_b16c2f6426d3b6d = !isalive( player );
        }
        
        if ( var_3faf858e79cd17bb.var_4185eab05d5f797e || !var_b16c2f6426d3b6d )
        {
            player utility::ent_flag_set( "waiting_for_vote" );
            player thread accept_vote_think( s_vote, 0 );
            continue;
        }
        
        player thread accept_vote_think( s_vote, 1 );
    }
}

// Namespace vote_system_shared
// Params 2
// Checksum 0x3d44d682, Offset: 0x1d99
// Size: 0x32d
function function_5957b1eb0fdb5b1e( s_vote, squad )
{
    update_players_count( s_vote );
    
    foreach ( player in squad.players )
    {
        var_707a7b7f62a2a5cf = function_48e94cd3f360f966( s_vote.vote_hud, player );
        hiddenspectating = player isspectatinganyone() && !s_vote.var_4185eab05d5f797e;
        var_21a260bb2e643bd0 = s_vote.var_bf284adce0359502 && s_vote.enable_cancel && s_vote.e_starter && player == s_vote.e_starter;
        
        if ( !var_707a7b7f62a2a5cf && !hiddenspectating )
        {
            if ( var_21a260bb2e643bd0 )
            {
                var_3faf858e79cd17bb = spawnstruct();
                var_3faf858e79cd17bb.var_4185eab05d5f797e = s_vote.var_4185eab05d5f797e;
                function_118a73b52a56751d( s_vote, var_3faf858e79cd17bb, player );
            }
            else
            {
                var_6e3fd3a489d9720c = s_vote.var_ab5184cfea519870 || ( s_vote.var_bf284adce0359502 ? player != s_vote.e_starter : player == s_vote.e_starter );
                var_4a4b04144cebbd2f = player == s_vote.e_starter;
                function_32760b16291896bd( player, s_vote, &"hash_3ec72a6e5753b8d9", &"zm_hud/accepted", &"hash_4abc1c392c70a774", &"hash_4933eba2a07ee11f", &"hash_34c26c26c88268b8", var_4a4b04144cebbd2f, s_vote.var_bf284adce0359502, var_6e3fd3a489d9720c );
            }
            
            var_707a7b7f62a2a5cf = function_48e94cd3f360f966( s_vote.vote_hud, player );
        }
        
        if ( var_707a7b7f62a2a5cf )
        {
            if ( function_2d2e3306876c8ccb( s_vote.var_4185eab05d5f797e ) )
            {
                function_9d410aaf26e58df6( player, s_vote, s_vote.players_count, 1 );
                continue;
            }
            
            s_vote.vote_hud namespace_b6e912eaebaaa52b::function_e5d1cb4112ef9661( player, s_vote.var_bf284adce0359502 ? &"hash_42f39860a4799fad" : &"hash_6fcacfb14a85efd9" );
            s_vote.vote_hud namespace_b6e912eaebaaa52b::function_a671d9bffaf75eda( player, s_vote.var_bf284adce0359502 ? &"hash_5491d0b0af0aa945" : &"hash_184eb59a5058bcc1" );
            s_vote.vote_hud namespace_b6e912eaebaaa52b::set_players_count( player, s_vote.players_count );
            
            if ( !var_21a260bb2e643bd0 )
            {
                if ( arraycontains( s_vote.a_players_accepted, player ) )
                {
                    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_player_vote( player, 1 );
                    continue;
                }
                
                if ( arraycontains( s_vote.a_players_declined, player ) )
                {
                    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_player_vote( player, -1 );
                }
            }
        }
    }
}

// Namespace vote_system_shared
// Params 2
// Checksum 0x17f277c, Offset: 0x20ce
// Size: 0x46
function function_8062c2aca29e1481( s_vote, squad )
{
    level endon( #"game_ended" );
    s_vote endon( #"vote_done" );
    
    while ( true )
    {
        function_5957b1eb0fdb5b1e( s_vote, squad );
        wait 0.5;
    }
}

// Namespace vote_system_shared
// Params 3
// Checksum 0x87f44e02, Offset: 0x211c
// Size: 0x195
function function_2740338293f3a3ea( s_vote, b_vote_accepted, squad )
{
    update_players_count( s_vote );
    var_47f423505424e8d2 = b_vote_accepted ? 1 : -1;
    vote_result_sound = b_vote_accepted ? #"uin_cer_zm_squadvote_success" : #"uin_cer_zm_squadvote_fail";
    
    foreach ( player in squad.players )
    {
        if ( function_48e94cd3f360f966( s_vote.vote_hud, player ) )
        {
            if ( function_2d2e3306876c8ccb( s_vote.var_4185eab05d5f797e ) )
            {
                function_9d410aaf26e58df6( player, s_vote, s_vote.players_count, 1 );
                player playlocalsound( vote_result_sound );
                continue;
            }
            
            s_vote.vote_hud namespace_b6e912eaebaaa52b::set_players_count( player, s_vote.players_count );
            var_b0a477c4740322bc = arraycontains( s_vote.a_players_accepted, player ) ? 1 : -1;
            s_vote.vote_hud namespace_b6e912eaebaaa52b::set_player_vote( player, var_b0a477c4740322bc );
            s_vote.vote_hud namespace_b6e912eaebaaa52b::set_vote_result( player, var_47f423505424e8d2 );
            player playlocalsound( vote_result_sound );
        }
    }
}

// Namespace vote_system_shared
// Params 0
// Checksum 0x7b812f1, Offset: 0x22b9
// Size: 0x2e
function function_64400cb8ec45efe6()
{
    self endon( #"disconnect" );
    wait 0.5;
    
    if ( utility::ent_flag_exist( "waiting_for_vote" ) )
    {
        utility::ent_flag_clear( "waiting_for_vote" );
    }
}

// Namespace vote_system_shared
// Params 3, eflags: 0x4
// Checksum 0xd26fd027, Offset: 0x22ef
// Size: 0x4c
function private setup_vote_notifications( notify_string, actionslot_command, kbm_command )
{
    self notifyonplayercommand( notify_string, actionslot_command );
    
    if ( !self usinggamepad() )
    {
        kbm_cmd = kbm_command ?? actionslot_command;
        self notifyonplayercommand( notify_string, kbm_cmd );
    }
}

// Namespace vote_system_shared
// Params 3, eflags: 0x4
// Checksum 0x198411d9, Offset: 0x2343
// Size: 0x43
function private cleanup_vote_notifications( notify_string, actionslot_command, kbm_command )
{
    self notifyonplayercommandremove( notify_string, actionslot_command );
    kbm_cmd = kbm_command ?? actionslot_command;
    self notifyonplayercommandremove( notify_string, kbm_cmd );
}

// Namespace vote_system_shared
// Params 9
// Checksum 0x90745a28, Offset: 0x238e
// Size: 0x3f3
function function_117e4ac2949c6f42( player, s_vote, default_header, var_362dabf82c5e259a, var_362daaf82c5e2367, var_8b8a80caa9b12eee, var_8b8a7fcaa9b12cbb, is_player_initiator = 1, var_bf284adce0359502 = 1 )
{
    vote_initiator = isdefined( s_vote.e_starter ) ? s_vote.e_starter getentitynumber() : 0;
    s_vote.init_message = s_vote.init_message ?? &"script/empty_string";
    s_vote.description = s_vote.description ?? &"script/empty_string";
    s_vote.header = s_vote.header ?? default_header;
    s_vote.var_5c854591406ed04 = s_vote.var_5c854591406ed04 ?? &"zm_hud/accepted";
    s_vote.var_5c857591406f39d = s_vote.var_5c857591406f39d ?? &"hash_34c26c26c88268b8";
    s_vote.var_7727bbdfa397b825 = &"hash_265dd733b5b18437";
    s_vote.var_7727b8dfa397b18c = &"hash_320f23d595acaf53";
    s_vote.player_vote_1 = s_vote.player_vote_1 ?? &"hash_4933eba2a07ee11f";
    s_vote.player_vote_2 = s_vote.player_vote_2 ?? &"hash_34c26c26c88268b8";
    s_vote.var_bf284adce0359502 = istrue( var_bf284adce0359502 );
    update_players_count( s_vote );
    
    if ( s_vote.vote_hud namespace_b6e912eaebaaa52b::is_open( player ) )
    {
        s_vote.vote_hud namespace_b6e912eaebaaa52b::close( player );
    }
    
    function_78dc38ac6405a036( s_vote.vote_hud, player );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_87fd87c10d3b04e( player, s_vote.init_message );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_description( player, s_vote.description );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_header( player, s_vote.header );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_9860ff088a9c5e61( player, s_vote.var_5c854591406ed04 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_9860fc088a9c57c8( player, s_vote.var_5c857591406f39d );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_7407975770042e8c( player, s_vote.var_7727bbdfa397b825 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_74079a5770043525( player, s_vote.var_7727b8dfa397b18c );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_557768b681cc68b( player, s_vote.player_vote_1 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_557778b681cc8be( player, s_vote.player_vote_2 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_e5d1cb4112ef9661( player, s_vote.var_bf284adce0359502 ? &"hash_42f39860a4799fad" : &"hash_6fcacfb14a85efd9" );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::function_a671d9bffaf75eda( player, s_vote.var_bf284adce0359502 ? &"hash_5491d0b0af0aa945" : &"hash_184eb59a5058bcc1" );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_initiator( player, vote_initiator );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_is_player_initiator( player, is_player_initiator );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_players_count( player, 4 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_player_vote( player, 0 );
    s_vote.vote_hud namespace_b6e912eaebaaa52b::set_vote_result( player, 0 );
    return s_vote;
}

// Namespace vote_system_shared
// Params 7
// Checksum 0x8b48a4bd, Offset: 0x278a
// Size: 0x2c5
function vote_think( e_starter, var_3faf858e79cd17bb, var_7b75a33dfbdeb81c, votehud, var_601a9be5417aec8c, var_6ed4c2d63a2ca333, enable_cancel )
{
    if ( var_7b75a33dfbdeb81c && var_7b75a33dfbdeb81c function_932a27e677b1ce60( var_601a9be5417aec8c ) )
    {
        return function_f85c8e1949782247( 0 );
    }
    
    utility::flag_set( "zm_vote_active" );
    
    if ( var_7b75a33dfbdeb81c )
    {
        var_7b75a33dfbdeb81c utility::ent_flag_set( "zm_vote_active" );
    }
    
    var_c4e46b091a4f31b9 = getdvarint( @"hash_6bfc8f70c4585e00", 0 );
    a_players = var_7b75a33dfbdeb81c.players;
    
    if ( a_players.size > 0 || var_c4e46b091a4f31b9 )
    {
        s_vote = init_vote_struct( e_starter, var_3faf858e79cd17bb, votehud, a_players );
        
        if ( enable_cancel )
        {
            s_vote.var_bf284adce0359502 = 1;
            s_vote.enable_cancel = 1;
        }
        
        if ( isdefined( e_starter ) )
        {
            a_players = arrayremove( a_players, e_starter );
        }
        
        register_vote_callbacks();
        
        if ( a_players.size != 0 || var_c4e46b091a4f31b9 )
        {
            function_ffdd1bfcb0dbe696( s_vote, var_3faf858e79cd17bb, var_7b75a33dfbdeb81c, 0, 1 );
        }
        
        if ( a_players.size != 0 || var_c4e46b091a4f31b9 || enable_cancel )
        {
            level thread function_8062c2aca29e1481( s_vote, var_7b75a33dfbdeb81c );
        }
        
        if ( isdefined( e_starter ) )
        {
            e_starter thread accept_vote_think( s_vote, 1 );
            
            if ( enable_cancel )
            {
                waitframe();
                function_118a73b52a56751d( s_vote, var_3faf858e79cd17bb, e_starter );
                e_starter thread function_c148461ca23d6f2b( e_starter, s_vote, var_7b75a33dfbdeb81c );
            }
        }
        else
        {
            a_players = var_7b75a33dfbdeb81c.players;
        }
        
        function_5583671f5bb3d772( s_vote, 0 );
        function_bddbed1ff9a6c189( s_vote, var_3faf858e79cd17bb, a_players );
        level utility::flag_set( "final_step_voting" );
        s_vote thread vote_time_out();
        b_passed = s_vote function_c9e2e5793e3f179c( var_7b75a33dfbdeb81c );
        level utility::flag_clear( "final_step_voting" );
        s_vote notify( #"vote_done" );
        
        if ( enable_cancel && e_starter )
        {
            e_starter cleanup_vote_notifications( "cancel_vote", "-actionslot 2", "decline_vote" );
        }
        
        if ( s_vote.cancelled )
        {
            b_passed = 0;
        }
        
        if ( !enable_cancel )
        {
            function_2740338293f3a3ea( s_vote, b_passed, var_7b75a33dfbdeb81c );
        }
        
        function_d65c80eaf108da5d( s_vote, 4, var_7b75a33dfbdeb81c );
        
        if ( b_passed )
        {
            if ( isdefined( var_6ed4c2d63a2ca333 ) )
            {
                wait var_6ed4c2d63a2ca333;
            }
        }
        else
        {
            b_passed = 0;
        }
        
        if ( isdefined( var_601a9be5417aec8c ) )
        {
            level thread [[ var_601a9be5417aec8c ]]( s_vote, b_passed );
        }
        
        s_vote.b_passed = b_passed;
        utility::flag_clear( "zm_vote_active" );
        
        if ( var_7b75a33dfbdeb81c )
        {
            var_7b75a33dfbdeb81c utility::ent_flag_clear( "zm_vote_active" );
        }
        
        return s_vote;
    }
    
    s_vote = function_f85c8e1949782247( 1 );
    
    if ( isdefined( var_601a9be5417aec8c ) )
    {
        level thread [[ var_601a9be5417aec8c ]]( s_vote, s_vote.b_passed );
    }
    
    utility::flag_clear( "zm_vote_active" );
    
    if ( var_7b75a33dfbdeb81c )
    {
        var_7b75a33dfbdeb81c utility::ent_flag_clear( "zm_vote_active" );
    }
    
    return s_vote;
}

// Namespace vote_system_shared
// Params 2, eflags: 0x4
// Checksum 0x92a7613d, Offset: 0x2a57
// Size: 0x68
function private function_aba93ca60d5b50a3( s_vote, player )
{
    if ( !player || !s_vote.var_6c8c12c741515514 || !player issplitscreenplayer() )
    {
        return;
    }
    
    var_1f0d6d55fe7c62ec = player getothersplitscreenplayer();
    
    if ( !var_1f0d6d55fe7c62ec || !arraycontains( s_vote.var_be908c4fc7caf076, var_1f0d6d55fe7c62ec ) )
    {
        return;
    }
    
    return var_1f0d6d55fe7c62ec;
}

// Namespace vote_system_shared
// Params 3, eflags: 0x4
// Checksum 0xd95d9728, Offset: 0x2ac8
// Size: 0xa4
function private set_vote_result_for_player( s_vote, player, b_vote_accepted )
{
    s_vote.a_players_accepted = arrayremove( s_vote.a_players_accepted, player );
    s_vote.a_players_declined = arrayremove( s_vote.a_players_declined, player );
    
    if ( b_vote_accepted )
    {
        s_vote.a_players_accepted = arraycombineunique( s_vote.a_players_accepted, [ player ] );
        return;
    }
    
    s_vote.a_players_declined = arraycombineunique( s_vote.a_players_declined, [ player ] );
}

// Namespace vote_system_shared
// Params 2, eflags: 0x4
// Checksum 0x41ad674, Offset: 0x2b74
// Size: 0x40, Type: bool
function private function_5ade4859c771a40d( s_vote, player )
{
    return isdefined( player ) && ( isalive( player ) || player.inlaststand || s_vote.var_4185eab05d5f797e );
}

// Namespace vote_system_shared
// Params 1, eflags: 0x4
// Checksum 0x4ae75624, Offset: 0x2bbd
// Size: 0x22
function private function_e3dcda6bc63f7f9e( var_87e37f4965e851d0 )
{
    if ( isdefined( var_87e37f4965e851d0 ) )
    {
        self [[ var_87e37f4965e851d0 ]]();
        return;
    }
    
    function_64400cb8ec45efe6();
}

// Namespace vote_system_shared
// Params 3
// Checksum 0x3a1a0013, Offset: 0x2be7
// Size: 0x1fe
function accept_vote_think( s_vote, var_9f4429dcad1102a1 = 0, var_87e37f4965e851d0 )
{
    if ( !isdefined( s_vote ) )
    {
        return;
    }
    
    b_force_accept = istrue( self.var_6668cc2adaf417ca );
    
    if ( arraycontains( s_vote.a_players_accepted, self ) || arraycontains( s_vote.a_players_declined, self ) )
    {
        function_e3dcda6bc63f7f9e( var_87e37f4965e851d0 );
        return;
    }
    
    if ( var_9f4429dcad1102a1 || b_force_accept )
    {
        b_vote_result = 1;
    }
    else
    {
        b_vote_result = function_852b00ec27c782d1( s_vote );
        function_e3dcda6bc63f7f9e( var_87e37f4965e851d0 );
        
        if ( arraycontains( s_vote.a_players_accepted, self ) || arraycontains( s_vote.a_players_declined, self ) )
        {
            return;
        }
    }
    
    var_1f0d6d55fe7c62ec = function_aba93ca60d5b50a3( s_vote, self );
    var_e928f810251c0de7 = 0;
    var_b8d5ee74a4bf55d2 = var_1f0d6d55fe7c62ec && ( arraycontains( s_vote.a_players_accepted, var_1f0d6d55fe7c62ec ) || arraycontains( s_vote.a_players_declined, var_1f0d6d55fe7c62ec ) );
    var_30a3ea7c307cb977 = var_b8d5ee74a4bf55d2 && function_5ade4859c771a40d( s_vote, var_1f0d6d55fe7c62ec );
    profilestart();
    
    if ( !arraycontains( s_vote.a_players_accepted, self ) && !arraycontains( s_vote.a_players_declined, self ) )
    {
        if ( var_30a3ea7c307cb977 && arraycontains( s_vote.a_players_accepted, var_1f0d6d55fe7c62ec ) )
        {
            set_vote_result_for_player( s_vote, self, 1 );
        }
        else if ( var_30a3ea7c307cb977 && arraycontains( s_vote.a_players_declined, var_1f0d6d55fe7c62ec ) )
        {
            set_vote_result_for_player( s_vote, self, 0 );
        }
        else
        {
            set_vote_result_for_player( s_vote, self, b_vote_result );
            
            if ( var_1f0d6d55fe7c62ec )
            {
                set_vote_result_for_player( s_vote, var_1f0d6d55fe7c62ec, b_vote_result );
                var_e928f810251c0de7 = !var_b8d5ee74a4bf55d2;
            }
        }
    }
    
    profilestop();
    
    if ( var_e928f810251c0de7 )
    {
        var_1f0d6d55fe7c62ec notify( #"local_splitscreen_vote_synced" );
        
        if ( isdefined( var_87e37f4965e851d0 ) )
        {
            var_1f0d6d55fe7c62ec thread [[ var_87e37f4965e851d0 ]]();
            return;
        }
        
        var_1f0d6d55fe7c62ec thread function_64400cb8ec45efe6();
    }
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x9db38a59, Offset: 0x2ded
// Size: 0xab
function vote_time_out( var_b72894a2aece4207 )
{
    self endon( #"game_ended" );
    self endon( #"vote_done" );
    timetowait = 45;
    
    if ( isdefined( var_b72894a2aece4207 ) )
    {
        timetowait = var_b72894a2aece4207;
    }
    
    self.var_cb4007b1432d6751 = gettime() + int( timetowait * 1000 );
    
    if ( timetowait > 1 )
    {
        wait timetowait - 1;
        timetowait = 1;
        level callback::callback( #"hash_18ed4a357bbe06eb", { #secondsremaining:1, #s_vote:self } );
    }
    
    wait timetowait;
    
    /#
        iprintlnbold( "<dev string:x65>" );
    #/
    
    self notify( #"vote_time_out" );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x76f25919, Offset: 0x2ea0
// Size: 0xf0
function function_c9e2e5793e3f179c( squad )
{
    level endon( #"game_ended" );
    self endon( #"vote_time_out" );
    self endon( #"vote_cancelled" );
    
    while ( true )
    {
        self.n_players_needed = self.var_adaf055e5d71bfbc - self.a_players_accepted.size;
        
        if ( self.n_players_needed <= 0 )
        {
            level callback::callback( #"hash_18ed4a357bbe06eb", { #secondsremaining:0.5, #s_vote:self } );
            wait 0.5;
            return 1;
        }
        else if ( squad.players.size - self.var_adaf055e5d71bfbc < self.a_players_declined.size )
        {
            level callback::callback( #"hash_18ed4a357bbe06eb", { #secondsremaining:0.5, #s_vote:self } );
            wait 0.5;
            return 0;
        }
        
        waitframe();
    }
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x13e4e3b9, Offset: 0x2f98
// Size: 0x122
function function_852b00ec27c782d1( s_vote )
{
    if ( isbot( self ) )
    {
        wait 4;
        return getdvarint( @"hash_6e8b31590c83b6", 0 );
    }
    
    self endon( #"disconnect" );
    setup_vote_notifications( "quest_vote_accept", "-actionslot 1", "accept_vote" );
    setup_vote_notifications( "quest_vote_decline", "-actionslot 2", "decline_vote" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "quest_vote_accept", "quest_vote_decline", "vote_time_out", "quest_vote_cancelled", "death", "local_splitscreen_vote_synced" );
        
        if ( msg == "death" )
        {
            if ( s_vote.var_4185eab05d5f797e )
            {
                continue;
            }
            
            msg = undefined;
        }
        
        break;
    }
    
    cleanup_vote_notifications( "quest_vote_accept", "-actionslot 1", "accept_vote" );
    cleanup_vote_notifications( "quest_vote_decline", "-actionslot 2", "decline_vote" );
    
    if ( !isdefined( msg ) )
    {
        return 0;
    }
    
    if ( msg == "quest_vote_accept" )
    {
        self playlocalsound( "uin_cer_zm_squadvote_accept" );
        return 1;
    }
    else if ( msg == "quest_vote_decline" )
    {
        self playlocalsound( "uin_cer_zm_squadvote_decline" );
        return 0;
    }
    
    return 0;
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x2aa7c207, Offset: 0x30c3
// Size: 0x19
function function_64a91d98e55921bb( params )
{
    level notify( #"hash_a1cf77eb6beb46d9", self );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0x703e9c, Offset: 0x30e4
// Size: 0x19
function player_disconnect( params )
{
    level notify( #"hash_a2f83d2ea6b7ab1c", self );
}

// Namespace vote_system_shared
// Params 1
// Checksum 0xe80af793, Offset: 0x3105
// Size: 0x19
function auto_accept_vote( params )
{
    level notify( #"hash_8fb0c88720171038", self );
}

// Namespace vote_system_shared
// Params 0
// Checksum 0xf0292e99, Offset: 0x3126
// Size: 0x89
function function_f6e9ca5a86f5f159()
{
    self endon( #"vote_done" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_a1cf77eb6beb46d9", player );
        
        if ( !arraycontains( self.var_be908c4fc7caf076, player ) )
        {
            self.var_be908c4fc7caf076[ self.var_be908c4fc7caf076.size ] = player;
            self.var_adaf055e5d71bfbc = function_47e42a6b3e1c8e82( self.var_be908c4fc7caf076 );
            player thread accept_vote_think( self, 1 );
        }
    }
}

// Namespace vote_system_shared
// Params 0
// Checksum 0xc15e230, Offset: 0x31b7
// Size: 0x9d
function function_a30fe8c8c9851154()
{
    self endon( #"vote_done" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_a2f83d2ea6b7ab1c", player );
        
        if ( isdefined( player ) && arraycontains( self.var_be908c4fc7caf076, player ) )
        {
            self.var_be908c4fc7caf076 = arrayremove( self.var_be908c4fc7caf076, player );
        }
        else
        {
            self.var_be908c4fc7caf076 = function_5713d46873b29625( self.var_be908c4fc7caf076 );
        }
        
        self.var_adaf055e5d71bfbc = function_47e42a6b3e1c8e82( self.var_be908c4fc7caf076 );
    }
}

// Namespace vote_system_shared
// Params 0
// Checksum 0x9cab7ca4, Offset: 0x325c
// Size: 0x80
function function_131f5ad047e016d8()
{
    self endon( #"vote_done" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_8fb0c88720171038", player );
        
        if ( !self.var_4185eab05d5f797e && isdefined( player ) && !arraycontains( self.a_players_accepted, player ) )
        {
            self.a_players_accepted = arraycombineunique( self.a_players_accepted, [ player ] );
        }
    }
}

// Namespace vote_system_shared
// Params 2, eflags: 0x4
// Checksum 0xf56f2b04, Offset: 0x32e4
// Size: 0x3e
function private function_5583671f5bb3d772( s_vote, skip_hotjoin = 0 )
{
    if ( !skip_hotjoin )
    {
        s_vote thread function_f6e9ca5a86f5f159();
    }
    
    s_vote thread function_a30fe8c8c9851154();
    s_vote thread function_131f5ad047e016d8();
}

// Namespace vote_system_shared
// Params 3, eflags: 0x4
// Checksum 0xd9e1ca5b, Offset: 0x332a
// Size: 0x41
function private function_c148461ca23d6f2b( player, var_f88a9b7f8a05e486, squad )
{
    player setup_vote_notifications( "cancel_vote", "-actionslot 2", "decline_vote" );
    player thread function_8813b94ff32694a6( var_f88a9b7f8a05e486, squad );
}

// Namespace vote_system_shared
// Params 2, eflags: 0x4
// Checksum 0x71387488, Offset: 0x3373
// Size: 0x7e
function private function_8813b94ff32694a6( var_f88a9b7f8a05e486, squad )
{
    self endon( #"disconnect" );
    var_f88a9b7f8a05e486 endon( #"vote_done" );
    var_f88a9b7f8a05e486 endon( #"vote_time_out" );
    level endon( #"game_ended" );
    self waittill( #"cancel_vote" );
    
    if ( isdefined( var_f88a9b7f8a05e486 ) && var_f88a9b7f8a05e486.active )
    {
        self playlocalsound( "uin_cer_zm_squadvote_decline" );
        cancelvote( var_f88a9b7f8a05e486, squad );
    }
}

// Namespace vote_system_shared
// Params 2, eflags: 0x4
// Checksum 0x8d505967, Offset: 0x33f9
// Size: 0x180
function private cancelvote( var_f88a9b7f8a05e486, squad )
{
    if ( !isdefined( var_f88a9b7f8a05e486 ) || !var_f88a9b7f8a05e486.active )
    {
        return;
    }
    
    var_f88a9b7f8a05e486.active = 0;
    var_f88a9b7f8a05e486.cancelled = 1;
    var_f88a9b7f8a05e486.a_players_accepted = [];
    var_f88a9b7f8a05e486.a_players_declined = [];
    var_f88a9b7f8a05e486 notify( #"vote_cancelled" );
    
    foreach ( player in squad.players )
    {
        if ( isdefined( player ) )
        {
            if ( player utility::ent_flag_exist( "waiting_for_vote" ) )
            {
                player utility::ent_flag_clear( "waiting_for_vote" );
            }
            
            if ( function_48e94cd3f360f966( var_f88a9b7f8a05e486.vote_hud, player ) )
            {
                cancel_text = var_f88a9b7f8a05e486.player_cancel ?? &"sat_ob/cancelled";
                var_f88a9b7f8a05e486.vote_hud namespace_b6e912eaebaaa52b::function_9860fc088a9c57c8( player, cancel_text );
                var_f88a9b7f8a05e486.vote_hud namespace_b6e912eaebaaa52b::set_vote_result( player, -1 );
                player playlocalsound( "uin_cer_zm_squadvote_fail" );
            }
            
            player notify( #"quest_vote_cancelled" );
        }
    }
}

// Namespace vote_system_shared
// Params 0
// Checksum 0x6fa9f12d, Offset: 0x3581
// Size: 0x83
function function_9f526c098ff882eb()
{
    self endon( #"game_ended" );
    self endon( #"vote_done" );
    n_time = 45;
    
    while ( n_time > 0 )
    {
        if ( self.a_players_accepted.size + self.a_players_declined.size == level.players.size )
        {
            wait 2;
            break;
        }
        
        waitframe();
        n_time -= level.framedurationseconds;
    }
    
    /#
        iprintlnbold( "<dev string:x65>" );
    #/
    
    self notify( #"vote_time_out" );
}

// Namespace vote_system_shared
// Params 0
// Checksum 0xbf0aae34, Offset: 0x360c
// Size: 0x7e
function function_23f710cedad14248()
{
    level endon( #"game_ended" );
    self endon( #"vote_time_out" );
    
    while ( true )
    {
        if ( self.var_be908c4fc7caf076.size == self.a_players_accepted.size || self.var_be908c4fc7caf076.size == self.a_players_declined.size || self.var_be908c4fc7caf076.size == self.a_players_accepted.size + self.a_players_declined.size )
        {
            return;
        }
        
        wait 0.1;
    }
}

// Namespace vote_system_shared
// Params 1
// Checksum 0xf70a7702, Offset: 0x3692
// Size: 0x84
function function_97e754dfb1ca7ee2( required_votes )
{
    level endon( #"game_ended" );
    self endon( #"vote_done" );
    self endon( #"vote_time_out" );
    n_time = 45;
    
    while ( n_time > 0 )
    {
        if ( self.a_players_accepted.size + self.a_players_declined.size == required_votes )
        {
            wait 2;
            break;
        }
        
        waitframe();
        n_time -= level.framedurationseconds;
    }
    
    self notify( #"vote_time_out" );
}

// Namespace vote_system_shared
// Params 5
// Checksum 0x54eb76f, Offset: 0x371e
// Size: 0x4c7
function function_5877646ce75d19f5( e_starter, var_3faf858e79cd17bb, votehud, var_2ca1f5b2b79323fb, var_7b75a33dfbdeb81c )
{
    if ( var_7b75a33dfbdeb81c && var_7b75a33dfbdeb81c function_932a27e677b1ce60( var_2ca1f5b2b79323fb.var_601a9be5417aec8c ) )
    {
        return 0;
    }
    
    utility::flag_set( "zm_vote_active" );
    
    if ( var_7b75a33dfbdeb81c )
    {
        var_7b75a33dfbdeb81c utility::ent_flag_set( "zm_vote_active" );
    }
    
    var_c4e46b091a4f31b9 = getdvarint( @"hash_6bfc8f70c4585e00", 0 );
    
    if ( var_2ca1f5b2b79323fb.var_eb81a73511f3a2d1 )
    {
        a_players = utility::get_alive_players();
    }
    else
    {
        a_players = level.players;
    }
    
    if ( a_players.size > 0 || var_c4e46b091a4f31b9 )
    {
        s_vote = init_vote_struct( e_starter, var_3faf858e79cd17bb, votehud, a_players );
        
        if ( isdefined( e_starter ) && !var_2ca1f5b2b79323fb.var_5b2ea08e3eb36908 )
        {
            a_players = arrayremove( a_players, e_starter );
        }
        
        register_vote_callbacks( istrue( var_2ca1f5b2b79323fb.skip_hotjoin ) );
        
        if ( a_players.size != 0 || var_c4e46b091a4f31b9 )
        {
            if ( !var_2ca1f5b2b79323fb.var_166907ebb0de0d4f )
            {
                s_squad = function_5b06e345046c1f58();
                function_ffdd1bfcb0dbe696( s_vote, var_3faf858e79cd17bb, s_squad, !var_2ca1f5b2b79323fb.var_5b2ea08e3eb36908, var_2ca1f5b2b79323fb.ask_everyone );
                level thread function_8062c2aca29e1481( s_vote, s_squad );
            }
        }
        
        if ( var_c4e46b091a4f31b9 || isdefined( e_starter ) && !var_2ca1f5b2b79323fb.var_5b2ea08e3eb36908 )
        {
            e_starter thread accept_vote_think( s_vote, 1, var_2ca1f5b2b79323fb.var_87e37f4965e851d0 );
        }
        
        function_5583671f5bb3d772( s_vote, istrue( var_2ca1f5b2b79323fb.skip_hotjoin ) );
        
        if ( isdefined( var_2ca1f5b2b79323fb.var_eaefaf4a9fe6c76f ) )
        {
            function_bddbed1ff9a6c189( s_vote, var_3faf858e79cd17bb, a_players, var_3faf858e79cd17bb.var_eaefaf4a9fe6c76f );
        }
        else
        {
            foreach ( player in a_players )
            {
                b_auto_accept = 0;
                
                if ( var_2ca1f5b2b79323fb.var_eb81a73511f3a2d1 )
                {
                    b_auto_accept = 0;
                }
                else if ( var_2ca1f5b2b79323fb.is_independent )
                {
                    b_auto_accept = !isalive( player );
                }
                else if ( var_2ca1f5b2b79323fb.is_quest_vote )
                {
                    b_auto_accept = !isalive( player ) || player.sessionstate == "spectator";
                }
                else
                {
                    b_auto_accept = !isalive( player );
                }
                
                if ( var_3faf858e79cd17bb.var_4185eab05d5f797e || !b_auto_accept )
                {
                    player utility::ent_flag_set( "waiting_for_vote" );
                    player thread accept_vote_think( s_vote, 0, var_2ca1f5b2b79323fb.var_87e37f4965e851d0 );
                    continue;
                }
                
                player thread accept_vote_think( s_vote, 1, var_2ca1f5b2b79323fb.var_87e37f4965e851d0 );
                
                if ( var_2ca1f5b2b79323fb.is_final_exfil_vote )
                {
                    player.var_ed9be6e0aa7daf4d = 1;
                }
            }
        }
        
        level utility::flag_set( "final_step_voting" );
        
        if ( isdefined( var_2ca1f5b2b79323fb.var_7efa53aaacca60f4 ) )
        {
            s_vote thread [[ var_2ca1f5b2b79323fb.var_7efa53aaacca60f4 ]]( var_2ca1f5b2b79323fb.var_b72894a2aece4207, a_players.size );
        }
        else if ( var_2ca1f5b2b79323fb.is_choice )
        {
            s_vote thread function_97e754dfb1ca7ee2( a_players.size );
        }
        else if ( var_2ca1f5b2b79323fb.is_quest_vote )
        {
            s_vote thread function_9f526c098ff882eb();
        }
        else
        {
            s_vote thread vote_time_out( var_2ca1f5b2b79323fb.var_b72894a2aece4207 );
        }
        
        if ( isdefined( var_2ca1f5b2b79323fb.custom_wait_func ) )
        {
            [[ var_2ca1f5b2b79323fb.custom_wait_func ]]( s_vote );
        }
        else if ( var_2ca1f5b2b79323fb.is_independent )
        {
            s_vote function_23f710cedad14248();
        }
        
        level utility::flag_clear( "final_step_voting" );
        s_vote notify( #"vote_done" );
        
        if ( !var_2ca1f5b2b79323fb.var_166907ebb0de0d4f )
        {
            s_squad = function_5b06e345046c1f58();
            n_delay = var_2ca1f5b2b79323fb.is_independent ? 1 : 4;
            function_d65c80eaf108da5d( s_vote, n_delay, s_squad );
        }
        
        if ( isdefined( var_2ca1f5b2b79323fb.var_6ed4c2d63a2ca333 ) )
        {
            wait var_2ca1f5b2b79323fb.var_6ed4c2d63a2ca333;
        }
        
        if ( isdefined( var_2ca1f5b2b79323fb.var_601a9be5417aec8c ) && var_2ca1f5b2b79323fb.is_independent )
        {
            level thread [[ var_2ca1f5b2b79323fb.var_601a9be5417aec8c ]]( s_vote, 1 );
        }
        
        utility::flag_clear( "zm_vote_active" );
        
        if ( var_7b75a33dfbdeb81c )
        {
            var_7b75a33dfbdeb81c utility::ent_flag_clear( "zm_vote_active" );
        }
        
        return s_vote;
    }
    
    utility::flag_clear( "zm_vote_active" );
    
    if ( var_7b75a33dfbdeb81c )
    {
        var_7b75a33dfbdeb81c utility::ent_flag_clear( "zm_vote_active" );
    }
    
    return;
}

