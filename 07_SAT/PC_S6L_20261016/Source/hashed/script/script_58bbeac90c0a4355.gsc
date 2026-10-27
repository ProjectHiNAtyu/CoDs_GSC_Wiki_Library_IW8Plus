// script_58bbeac90c0a4355  (hash_58bbeac90c0a4355.gscc) (size: 9971 Bytes / 0x26f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5030acd5 (1345367253)
// size ...... 9971 (0x26f3)
// includes .. 13  (offset: 0x253f)
// strings ... 18  (offset: 0x25a7)
// dev strs .. 8   (offset: 0x2693)
// exports ... 27  (offset: 0x15e7)
// cseg ...... 0x20a + 0x13dd (0x15e7)
// imports ... 98  (offset: 0x1a1f)
// animtree1 . 0   (offset: 0x26f3)
// animtree2 . 0   (offset: 0x26f3)
#using script_5abeb7e19040f2da;
#using scripts\common\callbacks;
#using scripts\common\puzzles\signal_detected;
#using scripts\common\scriptable;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;
#using scripts\mp\ob\ob_interactions_util;
#using scripts\mp\ob\systems\ob_quests;

#namespace namespace_f51190b0653a819;

// Namespace namespace_f51190b0653a819
// Params 0, eflags: 0x5
// Checksum 0x760d8adb, Offset: 0x228
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_73ce66990cf238b3", #"hash_73ce65990cf23700", &function_71e5d5509ff7aed5, &function_e6f0b5c2a241d7ca );
}

// Namespace namespace_f51190b0653a819
// Params 0, eflags: 0x4
// Checksum 0x66bb70dd, Offset: 0x255
// Size: 0x42
function private function_71e5d5509ff7aed5()
{
    if ( !ob_quests::quests_enabled() )
    {
        return;
    }
    
    level.var_c4d57d774e5f2d68 = 2;
    callback::add( #"ob_quest_start", &on_player_quest_start );
    callback::add( #"player_connect", &on_player_connect );
}

// Namespace namespace_f51190b0653a819
// Params 0, eflags: 0x4
// Checksum 0x4c412dd5, Offset: 0x29f
// Size: 0xa
function private function_e6f0b5c2a241d7ca()
{
    level thread setup_network_terminals();
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0xfbb317bf, Offset: 0x2b1
// Size: 0x9b
function private on_player_quest_start( sparams )
{
    assert( isplayer( self ) );
    var_aed4d8ff7c73a952 = utility::callsharedfunc( #"ob_quest", #"get_active_quest", self );
    
    if ( self.var_a1bb7e25335e7165.act_index == 2 && var_aed4d8ff7c73a952 != #"hash_726a81f83d96bc09" )
    {
        utility::ent_flag_set( "ob_quest_track_location" );
    }
    else if ( utility::ent_flag( "ob_quest_track_location" ) )
    {
        utility::ent_flag_clear( "ob_quest_track_location", 1 );
    }
    
    thread function_c17f0c63609c4c60( var_aed4d8ff7c73a952 );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x1664c4c9, Offset: 0x354
// Size: 0x91
function private on_player_connect( params )
{
    player = self;
    
    foreach ( network_terminal in level.var_ac7d56ad91e60ca0 )
    {
        network_terminal function_f37e04d7bbd733cb( player );
    }
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0xc
// Checksum 0x44ebfa41, Offset: 0x3ed
// Size: 0x14e
function private function_c17f0c63609c4c60( var_aed4d8ff7c73a952 )
{
    self notify( #"hash_b5264d2028bc97e3" );
    self endon( #"hash_b5264d2028bc97e3" );
    player = self;
    player endon( #"disconnect" );
    
    if ( player.var_a1bb7e25335e7165.act_index != 2 )
    {
        return;
    }
    
    player utility::ent_flag_wait( "active_ob_quest_progress_fetched_initial" );
    level utility::flag_wait( "network_terminals_spawned" );
    
    foreach ( terminal in level.var_ac7d56ad91e60ca0 )
    {
        if ( terminal.quest_hash == var_aed4d8ff7c73a952 )
        {
            if ( utility::callsharedfunc( #"ob_quest", #"hash_e98cb49910a093f9", player, terminal.challenge_hash ) )
            {
                if ( !terminal.completed_players[ player.guid ] )
                {
                    terminal function_904cfb9e86b3813f( player );
                }
                
                continue;
            }
            
            terminal function_7d0f0e0cade81ff4( player );
        }
    }
}

// Namespace namespace_f51190b0653a819
// Params 0, eflags: 0x4
// Checksum 0x78e5cdea, Offset: 0x543
// Size: 0xe0
function private setup_network_terminals()
{
    scriptable::scriptable_addusedcallbackbypart( "act3_network_terminal_usable", &function_a5e5a8e5e605833 );
    level.var_242c443357968e85 = getdvarint( @"hash_f6adc8f76e5c186e", 1 );
    level.var_ac7d56ad91e60ca0 = [];
    var_51042047c8172f0c = utility::getstructarray( "act3_nm_network_hub", "targetname" );
    
    /#
        level thread function_fd4a97c636119d5();
    #/
    
    foreach ( nt_struct in var_51042047c8172f0c )
    {
        wait 0.1;
        level thread function_e184437c0c58a1f0( nt_struct );
    }
    
    level utility::flag_set( "network_terminals_spawned" );
}

// Namespace namespace_f51190b0653a819
// Params 3, eflags: 0x4
// Checksum 0xa4ffbc67, Offset: 0x62b
// Size: 0xfb
function private function_d5354396ea39f4f9( terminal, pingindex, activemembers )
{
    player = self;
    player endon( #"disconnect" );
    var_e93b0f2da8ebc20a = function_1bf3a084cfe14025( 8 );
    loc_ping_index = player calloutmarkerping::function_a3f0d6526c09f579( var_e93b0f2da8ebc20a, terminal.origin + ( 0, 0, 64 ) );
    
    foreach ( var_8a958389218cbbb3 in activemembers )
    {
        player calloutmarkerping_hide( loc_ping_index, var_8a958389218cbbb3 );
    }
    
    player waittill( "predictiveCalloutClear_" + pingindex );
    player calloutmarkerping::function_7c0ee9d4b604e6d6( loc_ping_index );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x7d6aae5f, Offset: 0x72e
// Size: 0x11b
function private function_e184437c0c58a1f0( spawnstruct )
{
    level endon( #"game_ended" );
    quest_challenge_ref = spawnstruct.script_noteworthy;
    assert( quest_challenge_ref, "<dev string:x24>" );
    
    if ( !quest_challenge_ref )
    {
        return;
    }
    
    network_terminal = utility::spawn_model( %"hash_457616b4b34f54f3", spawnstruct.origin, spawnstruct.angles );
    network_terminal.active_players = [];
    network_terminal.completed_players = [];
    quest_ref = extract_quest_ref( quest_challenge_ref );
    network_terminal.quest_hash = getxhash( quest_ref );
    network_terminal.challenge_hash = getxhash( quest_challenge_ref );
    network_terminal.terminal_id = level.var_ac7d56ad91e60ca0.size;
    level.var_ac7d56ad91e60ca0[ level.var_ac7d56ad91e60ca0.size ] = network_terminal;
    network_terminal thread function_3d01220c03ddf74a();
    waitframe();
    network_terminal setscriptablepartstate( #"act3_network_terminal_usable", #"usable" );
    network_terminal function_7653c765b6c7b815();
}

// Namespace namespace_f51190b0653a819
// Params 0, eflags: 0x4
// Checksum 0x7424e1e1, Offset: 0x851
// Size: 0x12d
function private function_3d01220c03ddf74a()
{
    network_terminal = self;
    utility::flag_wait( "scriptables_ready" );
    
    while ( !level.var_326e483ae9289d99.spawnednodes )
    {
        wait 1;
    }
    
    terminal_forward = anglestoforward( network_terminal.angles ?? ( 0, 0, 0 ) );
    power_node_origin = network_terminal.origin + ( 0, 0, 18 ) + terminal_forward * -10;
    network_terminal.power_node = power_nodes::function_9b261dd8554ca232( power_node_origin );
    network_terminal.power_node.var_c7818eb50d1b7c75 = [];
    
    foreach ( player in level.players )
    {
        network_terminal function_f37e04d7bbd733cb( player );
    }
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0xcf71fcc4, Offset: 0x986
// Size: 0x79
function private function_f37e04d7bbd733cb( player )
{
    network_terminal = self;
    
    if ( !network_terminal.power_node )
    {
        return;
    }
    
    network_terminal.power_node function_d6a7b7ef13a57f38( player );
    network_terminal.power_node.playerscollected[ player getguid() ] = 1;
    network_terminal.power_node.var_c7818eb50d1b7c75[ player getguid() ] = 1;
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0xca9868e6, Offset: 0xa07
// Size: 0x9a
function private function_72d75608f364faf8( player )
{
    network_terminal = self;
    
    if ( !network_terminal.power_node )
    {
        return;
    }
    
    if ( !network_terminal.power_node.var_c7818eb50d1b7c75[ player getguid() ] )
    {
        return;
    }
    
    network_terminal.power_node function_6113853a877d5460( player );
    wait 0.5;
    network_terminal.power_node.playerscollected[ player getguid() ] = undefined;
    network_terminal.power_node.var_c7818eb50d1b7c75[ player getguid() ] = undefined;
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x810fa496, Offset: 0xaa9
// Size: 0x57
function private extract_quest_ref( var_f20385ee031aae02 )
{
    quest_str_prefix = "sat_wc_quest_act3_quest";
    
    if ( !isstartstr( var_f20385ee031aae02, quest_str_prefix ) )
    {
        return;
    }
    
    remainder_str = getsubstr( var_f20385ee031aae02, quest_str_prefix.size );
    tokens = strtok( remainder_str, "_" );
    return quest_str_prefix + tokens[ 0 ];
}

// Namespace namespace_f51190b0653a819
// Params 6, eflags: 0x4
// Checksum 0x426eebd4, Offset: 0xb09
// Size: 0x55
function private function_a5e5a8e5e605833( instance, part, state, player, bautouse, usestring )
{
    terminal_ent = instance function_f911103fc8a0b6e7();
    terminal_ent thread function_5e038b4b92b59002( player );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x5bafa4ce, Offset: 0xb66
// Size: 0xcb
function private function_5e038b4b92b59002( player )
{
    network_terminal = self;
    
    if ( network_terminal.var_1674515c4a4c0655.size || network_terminal.disabled )
    {
        return;
    }
    
    var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, network_terminal, 1, 1, 1, -1, "ClinkInteractions" );
    
    if ( !player || !network_terminal )
    {
        return;
    }
    
    if ( var_fab006cdb4f6e516 )
    {
        level callback::callback( #"hash_91f2a0e70afebfe1", { #interactionevent:#"hash_4e33b5cdebad9e7a", #player:player } );
        network_terminal function_904cfb9e86b3813f( player );
        player thread hud_message::showsplash( #"hash_1027a9fe045373e6" );
        network_terminal thread function_72d75608f364faf8( player );
    }
}

/#

    // Namespace namespace_f51190b0653a819
    // Params 0, eflags: 0x4
    // Checksum 0xafb0a95a, Offset: 0xc39
    // Size: 0x2ef, Type: dev
    function private function_fd4a97c636119d5()
    {
        level endon( #"game_ended" );
        debug_player_index = 0;
        
        while ( true )
        {
            if ( getdvarint( @"hash_bec59e380395a70c", 0 ) )
            {
                foreach ( terminal in level.var_ac7d56ad91e60ca0 )
                {
                    line( terminal.origin + ( 0, 0, 100 ), terminal.origin + ( 0, 0, 5000 ), ( 1, 1, 0 ), 1, 0, 1 );
                    quest_ref = getxhashsourcename( terminal.quest_hash );
                    print3d( terminal.origin + ( 0, 0, -10 ), "<dev string:x96>" + quest_ref, ( 1, 1, 0 ), 1, 0.25, 1, 1 );
                    var_be1a9269de0df35 = getxhashsourcename( terminal.challenge_hash );
                    print3d( terminal.origin + ( 0, 0, -16 ), "<dev string:x9e>" + var_be1a9269de0df35, ( 1, 1, 0 ), 1, 0.25, 1, 1 );
                }
            }
            
            if ( getdvarint( @"hash_9e5a15209c4d05a", 0 ) )
            {
                target_player = level.players[ debug_player_index ];
                debug_player_index = ( debug_player_index + 1 ) % level.players.size;
                target_terminal = undefined;
                shortest_dist_sq = undefined;
                
                foreach ( terminal in level.var_ac7d56ad91e60ca0 )
                {
                    if ( terminal.completed_players[ target_player.guid ] )
                    {
                        continue;
                    }
                    
                    dist_sq = distancesquared( target_player.origin, terminal.origin );
                    
                    if ( !shortest_dist_sq || dist_sq < shortest_dist_sq )
                    {
                        target_terminal = terminal;
                        shortest_dist_sq = dist_sq;
                    }
                }
                
                if ( target_terminal )
                {
                    target_terminal function_7d0f0e0cade81ff4( target_player );
                }
                else
                {
                    iprintlnbold( "<dev string:xaa>" + target_player.name + "<dev string:xdf>" );
                }
                
                setdvar( @"hash_9e5a15209c4d05a", 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x2d8dc99b, Offset: 0xf30
// Size: 0xff
function private function_7d0f0e0cade81ff4( player )
{
    network_terminal = self;
    
    if ( network_terminal.completed_players[ player.guid ] )
    {
        assertmsg( "<dev string:xe1>" + network_terminal.challenge_hash + "<dev string:x100>" + player.name + "<dev string:x10f>" );
        return;
    }
    
    if ( !isdefined( player.var_c3622c4ae75aef4c ) )
    {
        player.var_c3622c4ae75aef4c = [];
    }
    
    player.var_c3622c4ae75aef4c[ player.var_c3622c4ae75aef4c.size ] = network_terminal;
    network_terminal.active_players[ player.guid ] = player;
    network_terminal enablescriptableplayeruse( player );
    player utility::callsharedfunc( #"vision_pulse", #"hash_73baeda3c430f3b3", network_terminal, 1 );
    
    if ( level.var_242c443357968e85 )
    {
        network_terminal function_e2ddac8ecca9eb55( player );
        return;
    }
    
    network_terminal function_9493b87fbca0919( player );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x95f2b5ae, Offset: 0x1037
// Size: 0xef
function private function_904cfb9e86b3813f( player )
{
    network_terminal = self;
    network_terminal.active_players[ player.guid ] = undefined;
    network_terminal.completed_players[ player.guid ] = player;
    network_terminal disablescriptableplayeruse( player );
    
    if ( player.var_c3622c4ae75aef4c && arraycontains( player.var_c3622c4ae75aef4c, network_terminal ) )
    {
        player utility::callsharedfunc( #"vision_pulse", #"hash_38470c19fcaf5542", network_terminal );
        player utility::callsharedfunc( #"vision_pulse", #"hash_acb62b42896db66d", network_terminal );
        player.var_c3622c4ae75aef4c = arrayremove( player.var_c3622c4ae75aef4c, network_terminal );
    }
    
    if ( level.var_242c443357968e85 )
    {
        network_terminal function_a8071189a43d87e0( player );
        return;
    }
    
    network_terminal function_c7bdf859292eec36( player );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0xfd40e9f4, Offset: 0x112e
// Size: 0xcb
function private function_9493b87fbca0919( player )
{
    network_terminal = self;
    terminal_circle_radius = 1200;
    
    if ( !network_terminal game_utility::questcircle_exists() )
    {
        circle_template = "Search_Area_Activity_Ob";
        random_offset_dist = randomfloat( terminal_circle_radius * 0.8 );
        random_offset_dir = rotatevector( ( 1, 0, 0 ), ( 0, randomint( 360 ), 0 ) );
        circle_center = network_terminal.origin + random_offset_dir * random_offset_dist;
        network_terminal game_utility::questcircle_create( circle_template, circle_center, terminal_circle_radius );
        network_terminal.quest_circle_center = circle_center;
    }
    
    if ( network_terminal game_utility::questcircle_exists() )
    {
        network_terminal thread function_3c6468991215a959( player, terminal_circle_radius * 2 );
    }
}

// Namespace namespace_f51190b0653a819
// Params 2, eflags: 0x4
// Checksum 0xd75f6168, Offset: 0x1201
// Size: 0xcc
function private function_3c6468991215a959( player, visibleradius )
{
    network_terminal = self;
    var_45f7c1c63f67c613 = "deactivate_a3nt_circle" + network_terminal.terminal_id;
    visible_radius_sq = visibleradius * visibleradius;
    update_interval = 1;
    
    while ( true )
    {
        msg = player utility::waittill_any_in_array_or_timeout_no_endon_death( [ "disconnect", var_45f7c1c63f67c613 ], update_interval );
        
        if ( msg == "timeout" )
        {
            if ( distance2dsquared( player.origin, network_terminal.quest_circle_center ) < visible_radius_sq )
            {
                network_terminal game_utility::questcircle_showtoplayer( player );
            }
            else
            {
                network_terminal game_utility::questcircle_hidefromplayer( player );
            }
            
            continue;
        }
        
        return;
    }
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x198b2b4a, Offset: 0x12d5
// Size: 0x4e
function private function_c7bdf859292eec36( player )
{
    network_terminal = self;
    var_45f7c1c63f67c613 = "deactivate_a3nt_circle" + network_terminal.terminal_id;
    player notify( var_45f7c1c63f67c613 );
    
    if ( network_terminal game_utility::questcircle_exists() )
    {
        network_terminal game_utility::questcircle_hidefromplayer( player );
    }
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0xd5668c7c, Offset: 0x132b
// Size: 0x6a
function private function_e2ddac8ecca9eb55( player )
{
    network_terminal = self;
    
    if ( !network_terminal.var_b879edf90689d605 )
    {
        network_terminal.var_b879edf90689d605 = utility::function_1808878d1c511ce8( network_terminal.origin + ( 0, 0, 32 ), ( 0, 0, 0 ) );
    }
    
    network_terminal thread monitor_signal_detector_for_player( player );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x2e0cd089, Offset: 0x139d
// Size: 0x12c
function private monitor_signal_detector_for_player( player )
{
    network_terminal = self;
    player endon( #"disconnect" );
    player endon( "monitor_signal_detector_for_player_end" + network_terminal.terminal_id );
    update_interval = 0.5;
    signal_detector_radius_sq = 5760000;
    point_blank_radius_sq = 10000;
    
    while ( true )
    {
        wait update_interval;
        var_48607cfdb87ffbae = distance2dsquared( player.origin, network_terminal.var_b879edf90689d605.origin );
        
        if ( var_48607cfdb87ffbae < point_blank_radius_sq )
        {
            dir_forward = anglestoforward( player getplayerangles() );
            var_29c8375e1f05eb44 = vectornormalize( network_terminal.var_b879edf90689d605.origin - player geteye() );
            
            if ( vectordot( dir_forward, var_29c8375e1f05eb44 ) > 0.7 )
            {
                player signal_detector_off( network_terminal );
            }
            else
            {
                player signal_detector_on( network_terminal );
            }
            
            continue;
        }
        
        if ( var_48607cfdb87ffbae < signal_detector_radius_sq )
        {
            player signal_detector_on( network_terminal );
            continue;
        }
        
        player signal_detector_off( network_terminal );
    }
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x705ea8c6, Offset: 0x14d1
// Size: 0x38
function private function_a8071189a43d87e0( player )
{
    network_terminal = self;
    player notify( "monitor_signal_detector_for_player_end" + network_terminal.terminal_id );
    player signal_detector_off( network_terminal );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0x5e628496, Offset: 0x1511
// Size: 0x63
function private signal_detector_on( network_terminal )
{
    player = self;
    
    if ( !player player::isreallyalive() )
    {
        return;
    }
    
    if ( player scripted_widgets::is_active( "signal_detector" ) )
    {
        return;
    }
    
    player signal_detected::function_d4dbb5e5d8c11346( network_terminal.var_b879edf90689d605, network_terminal.var_b879edf90689d605 getentitynumber(), undefined, undefined, undefined, undefined, 0, undefined, 2400 );
}

// Namespace namespace_f51190b0653a819
// Params 1, eflags: 0x4
// Checksum 0xd224ecc1, Offset: 0x157c
// Size: 0x6b
function private signal_detector_off( network_terminal )
{
    player = self;
    
    if ( !player.radio_signal || !network_terminal.var_b879edf90689d605 )
    {
        return;
    }
    
    if ( player.radio_signal.entitynum != network_terminal.var_b879edf90689d605 getentitynumber() )
    {
        return;
    }
    
    player signal_detected::radio_signal_close();
}

