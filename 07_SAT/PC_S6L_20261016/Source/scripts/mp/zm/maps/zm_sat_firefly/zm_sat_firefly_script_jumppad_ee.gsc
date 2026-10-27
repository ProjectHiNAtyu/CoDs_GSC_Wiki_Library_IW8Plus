// scripts\mp\zm\maps\zm_sat_firefly\zm_sat_firefly_script_jumppad_ee.gsc  (hash_56b2a816e88029e4.gscc) (size: 13067 Bytes / 0x330b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf8379694 (4164392596)
// size ...... 13067 (0x330b)
// includes .. 17  (offset: 0x2e63)
// strings ... 42  (offset: 0x2eeb)
// dev strs .. 23  (offset: 0x31d3)
// exports ... 18  (offset: 0x1f8b)
// cseg ...... 0x2e1 + 0x1caa (0x1f8b)
// imports ... 95  (offset: 0x225b)
// animtree1 . 0   (offset: 0x330b)
// animtree2 . 0   (offset: 0x330b)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\fasttravel\zm_fasttravel_jumppad;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_firefly_script_jumppad_ee;

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 0, eflags: 0x5
// Checksum 0xc9f00125, Offset: 0x2ff
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"firefly_jumppad_ee", undefined, undefined, &init_jumppad_ee );
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 0
// Checksum 0xe7728151, Offset: 0x320
// Size: 0x193
function init_jumppad_ee()
{
    var_1b5f750124116b6c = utility::function_30dbabe3200518b( "zm_jumppad_light_fixture", #targetname );
    
    if ( var_1b5f750124116b6c )
    {
        level.var_1b5f750124116b6c = spawnstruct();
        level.var_1b5f750124116b6c.sbl = var_1b5f750124116b6c;
    }
    else
    {
        level.var_1b5f750124116b6c = utility::getstruct( "zm_jumppad_light_fixture", "targetname" );
        level.var_1b5f750124116b6c.sbl = spawnscriptable( "sat_zm_firefly_jumppad_ee_light", level.var_1b5f750124116b6c.origin, level.var_1b5f750124116b6c.angles );
    }
    
    if ( !getdvarint( @"hash_dfe5227c40e9c4e0", 0 ) )
    {
        return;
    }
    
    if ( !level.gametypebundle.var_809dd58f8a112f22 )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"firefly_jumppad_ee", #"hash_afa63e0d8eee8c39", &function_67327e76fe76d33b, &function_84429ca4cb68d836 );
    zm_quest::register_quest_step( #"firefly_jumppad_ee", #"hash_d57e6de7e571b86", &function_531e9bb76ad3ed28, &function_5b9b683b10a5931b );
    zm_quest::register_quest_step( #"firefly_jumppad_ee", #"enter_rift", &function_5c00fc6400dd301b, &function_3536e3e790a4b3ec );
    level.jumppad_ee_quest = zm_quest::get_quest( #"firefly_jumppad_ee" );
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait_all( "zm_quest_initialized", "jps_inited" );
    level init_jumppad_ee_objects();
    level thread zm_quest::start_quest( #"firefly_jumppad_ee" );
    
    /#
        level thread init_jumppad_ee_debug();
    #/
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 0, eflags: 0x4
// Checksum 0x31db4234, Offset: 0x4bb
// Size: 0x2d6
function private init_jumppad_ee_objects()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "begin_round_logic" );
    var_b70b56ba7a8cb29a = arrayrandomize( level.a_jumppads );
    level.jumppad_ee_quest.var_68a84458df606370 = utility::array_slice( var_b70b56ba7a8cb29a, 0, 3 );
    
    for ( i = 0; i < level.jumppad_ee_quest.var_68a84458df606370.size ; i++ )
    {
        jumppad = level.jumppad_ee_quest.var_68a84458df606370[ i ];
        jumppad.s_rift = utility::spawn_tag_origin( jumppad.origin, jumppad.angles );
        jumppad.event_banter[ #"ft_jp_ee" ][ "banterName" ] = #"ft_jp_ee";
        jumppad.s_rift.var_3bd0ce298a91260d = randomintrange( 0, jumppad.paths.size );
        var_f78511be97bccc3f = jumppad.paths[ jumppad.s_rift.var_3bd0ce298a91260d ];
        curve_link = utility::spawn_tag_origin( jumppad.s_rift.origin, jumppad.s_rift.angles );
        jumppad.s_rift linkto( curve_link );
        curve_link utility::function_8001268940441423( var_f78511be97bccc3f[ "start" ], var_f78511be97bccc3f[ "end" ], var_f78511be97bccc3f[ "handle" ], 0.5, 1, 0, 0.5 );
        jumppad.s_rift unlink();
        jumppad.s_rift.origin = curve_link.origin;
        curve_link delete();
        jumppad.s_rift.sbl = spawnscriptable( %"sat_zm_firefly_aethertear", jumppad.s_rift.origin, jumppad.s_rift.angles );
    }
    
    level.jumppad_ee_quest.str_reward_zone_name = "zone_sunken";
    player_respawns = zone_manager::function_9dd25e9fb0ecd45b( level.jumppad_ee_quest.str_reward_zone_name );
    var_c60f339200573c2 = utility::function_54fdde0a73217354( player_respawns, 1, 1 );
    level.jumppad_ee_quest.var_19d5ca1c740198dd = spawnscriptable( %"sat_zm_firefly_aethertear", var_c60f339200573c2 + ( -100, -100, 150 ), ( 0, 0, 0 ) );
    level utility::flag_set( "ft_jp_ee_init_finished" );
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 1, eflags: 0x4
// Checksum 0xb8fa0d82, Offset: 0x799
// Size: 0x270
function private function_34072089d7d4fb78( sparams )
{
    jumppad = sparams.jumppad;
    var_650afee77554228c = level.jumppad_ee_quest.var_606830d3c20ceb36;
    var_cdb665c03b873a33 = var_650afee77554228c.var_cdb665c03b873a33;
    
    /#
        logstring( "<dev string:x24>" + jumppad.jumppad_index + "<dev string:x40>" );
        iprintlnbold( "<dev string:x24>" + jumppad.jumppad_index + "<dev string:x40>" );
    #/
    
    var_8c68a39e6fe6eaee = var_650afee77554228c.var_bf42fdcaf3995260[ jumppad.jumppad_index ];
    
    if ( var_8c68a39e6fe6eaee )
    {
        if ( var_650afee77554228c.var_e527c81aad587786 && var_650afee77554228c.var_d644d9553c126cca[ jumppad.jumppad_index ] != jumppad.time_activated )
        {
            level utility::flag_set( "t_jp_i_i_o" );
        }
        
        return;
    }
    
    if ( var_650afee77554228c.var_e527c81aad587786 )
    {
        if ( !level utility::flag( "f_t_jp_i_o_a" ) )
        {
            level utility::flag_set( "f_t_jp_i_o_a" );
            
            /#
                logstring( "<dev string:x47>" + jumppad.jumppad_index );
                iprintlnbold( "<dev string:x47>" + jumppad.jumppad_index );
            #/
        }
        
        var_5fbfb8436341f7bf = var_650afee77554228c.var_e527c81aad587786[ var_650afee77554228c.var_bf42fdcaf3995260.size ];
        jumppad_index = jumppad.jumppad_index;
        
        if ( jumppad_index != var_5fbfb8436341f7bf )
        {
            level utility::flag_set( "t_jp_i_i_o" );
            return;
        }
        
        var_650afee77554228c.var_d644d9553c126cca[ jumppad.jumppad_index ] = jumppad.time_activated;
    }
    
    var_650afee77554228c.var_bf42fdcaf3995260[ jumppad.jumppad_index ] = 1;
    
    if ( var_650afee77554228c.var_bdba46c83b4c0d1 )
    {
        save_key = hashcat( #"hash_c1f3dd4c18762ca8", var_cdb665c03b873a33 );
        storage_int = level zm_quest::function_73720cdf21c3cfd7( #"firefly_jumppad_ee", save_key ) ?? 0;
        storage_int = utility::set_bit_flag( storage_int, jumppad.jumppad_index );
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_jumppad_ee", save_key, storage_int );
    }
    
    if ( var_650afee77554228c.var_bf42fdcaf3995260.size >= level.a_jumppads.size )
    {
        level utility::flag_set( var_cdb665c03b873a33 );
    }
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 2, eflags: 0x4
// Checksum 0x6af4b6e4, Offset: 0xa11
// Size: 0x147
function private function_67327e76fe76d33b( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ft_jp_ee_init_finished" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    save_key = hashcat( #"hash_c1f3dd4c18762ca8", "t_a_jp" );
    storage_int = zm_quest::function_73720cdf21c3cfd7( #"firefly_jumppad_ee", save_key ) ?? 0;
    
    if ( storage_int != 0 )
    {
        for ( i = 1; i < level.a_jumppads.size + 1 ; i++ )
        {
            var_66ca81bdeb7158a2 = utility::get_bit_flag( storage_int, i );
            level.jumppad_ee_quest.var_bf42fdcaf3995260[ i ] = var_66ca81bdeb7158a2 ? 1 : undefined;
        }
    }
    
    level.jumppad_ee_quest.var_606830d3c20ceb36 = { #var_bdba46c83b4c0d1:1, #var_bf42fdcaf3995260:level.jumppad_ee_quest.var_bf42fdcaf3995260, #var_cdb665c03b873a33:"t_a_jp" };
    level callback::remove( "on_player_ft_jp_entered", &function_34072089d7d4fb78 );
    level callback::add( "on_player_ft_jp_entered", &function_34072089d7d4fb78 );
    level utility::flag_wait( "t_a_jp" );
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 2, eflags: 0x4
// Checksum 0xb8002e95, Offset: 0xb60
// Size: 0xa7
function private function_84429ca4cb68d836( b_skipped, b_save_restored )
{
    if ( !level.jumppad_ee_quest.var_a541351e94e554d9 )
    {
        level.jumppad_ee_quest.var_a541351e94e554d9 = 1;
        n_order_start_round = level zm_quest::function_73720cdf21c3cfd7( #"firefly_jumppad_ee", #"n_order_start_round" );
        
        if ( b_skipped && !n_order_start_round )
        {
            level.jumppad_ee_quest.var_a541351e94e554d9 = 0;
        }
    }
    
    if ( b_skipped )
    {
        level utility::flag_set( "t_a_jp" );
        level utility::flag_set( "jp_ee_start" );
    }
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 2, eflags: 0x4
// Checksum 0x206560a0, Offset: 0xc0f
// Size: 0x50b
function private function_531e9bb76ad3ed28( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ft_jp_ee_init_finished" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( level.jumppad_ee_quest.var_a541351e94e554d9 )
    {
        var_49f7091014d2c59 = zm_round_logic::get_rb_round_number();
        var_3c9ece8e74710d65 = var_49f7091014d2c59 + randomintrange( 4, 6 );
        n_order_start_round = level zm_quest::function_73720cdf21c3cfd7( #"firefly_jumppad_ee", #"n_order_start_round" ) ?? var_3c9ece8e74710d65;
        level zm_quest::function_4eefe6de31f5ddab( #"firefly_jumppad_ee", #"n_order_start_round", n_order_start_round );
        
        do
        {
            level waittill( #"on_round_start" );
            var_49f7091014d2c59 = zm_round_logic::get_rb_round_number();
        }
        while ( var_49f7091014d2c59 < n_order_start_round );
        
        level zm_quest::function_6265be8d0549e1b1( #"firefly_jumppad_ee", #"n_order_start_round" );
    }
    
    level.jumppad_ee_quest.var_a541351e94e554d9 = 0;
    level.jumppad_ee_quest.var_9c05ef8ba3c3429d = [];
    level.jumppad_ee_quest.var_d1582e8bfcf16d26 = utility::array_random( [ [ 7, 4, 1, 2, 3, 5, 6 ], [ 7, 2, 1, 4, 3, 6, 5 ], [ 7, 4, 1, 2, 3, 5, 6 ], [ 7, 4, 1, 2, 3, 6, 5 ], [ 3, 5, 6, 7, 4, 1, 2 ], [ 3, 5, 6, 7, 2, 1, 4 ], [ 3, 6, 5, 7, 4, 1, 2 ], [ 3, 6, 5, 7, 2, 1, 4 ] ] );
    level.jumppad_ee_quest.var_4b7a283ccd4fd109 = [];
    level thread jumppad_blink();
    var_c64fc6ff1bd93e19 = "";
    
    foreach ( jumppad_index in level.jumppad_ee_quest.var_d1582e8bfcf16d26 )
    {
        var_c64fc6ff1bd93e19 += " " + jumppad_index + " ";
    }
    
    /#
        logstring( "<dev string:x8c>" + var_c64fc6ff1bd93e19 );
        iprintlnbold( "<dev string:x8c>" + var_c64fc6ff1bd93e19 );
    #/
    
    level.jumppad_ee_quest.var_606830d3c20ceb36 = { #var_bf42fdcaf3995260:level.jumppad_ee_quest.var_9c05ef8ba3c3429d, #var_e527c81aad587786:level.jumppad_ee_quest.var_d1582e8bfcf16d26, #var_d644d9553c126cca:level.jumppad_ee_quest.var_4b7a283ccd4fd109, #var_cdb665c03b873a33:"t_jp_i_o" };
    level utility::flag_clear( "t_jp_i_o" );
    level utility::flag_clear( "t_jp_i_i_o" );
    level utility::flag_clear( "f_t_jp_i_o_a" );
    level utility::flag_wait( "f_t_jp_i_o_a" );
    level utility::flag_wait_any_timeout( 240, "t_jp_i_o", "t_jp_i_i_o", "t_jp_i_o_f_to" );
    level notify( #"hash_91e7258bb7f88b36" );
    level.var_1b5f750124116b6c.sbl utility::function_7c10ea82c1e305b8( "fx", "off" );
    
    if ( !level utility::flag( "t_jp_i_o" ) )
    {
        if ( level utility::flag( "t_jp_i_i_o" ) )
        {
            /#
                logstring( "<dev string:xbe>" );
                iprintlnbold( "<dev string:xbe>" );
            #/
        }
        else if ( !level utility::flag( "t_jp_i_o_f_to" ) )
        {
            /#
                logstring( "<dev string:xfb>" );
                iprintlnbold( "<dev string:xfb>" );
            #/
        }
        
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_jumppad_ee", #"hash_d57e6de7e571b86" );
        level waittill( #"never" );
    }
    
    /#
        logstring( "<dev string:x138>" );
        iprintlnbold( "<dev string:x138>" );
    #/
    
    wait 8;
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 2, eflags: 0x4
// Checksum 0x954b1d1d, Offset: 0x1122
// Size: 0x5f
function private function_5b9b683b10a5931b( b_skipped, b_save_restored )
{
    level utility::flag_set( "t_jp_i_o" );
    level utility::flag_set( "f_t_jp_i_o_a" );
    level notify( #"hash_91e7258bb7f88b36" );
    level.var_1b5f750124116b6c.sbl utility::function_7c10ea82c1e305b8( "fx", "off" );
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 0, eflags: 0xc
// Checksum 0x24de0d52, Offset: 0x1189
// Size: 0x155
function private jumppad_blink()
{
    self notify( #"hash_c7cdafeae129d815" );
    self endon( #"hash_c7cdafeae129d815" );
    level endon( #"game_ended" );
    level endon( #"hash_91e7258bb7f88b36" );
    wait 3;
    
    while ( !level utility::flag( "t_jp_i_o" ) )
    {
        for ( i = 0; i < level.jumppad_ee_quest.var_d1582e8bfcf16d26.size ; i++ )
        {
            var_23ef870c8f42e6f0 = level.jumppad_ee_quest.var_d1582e8bfcf16d26[ i ];
            
            for ( var_d5611fc5f0414087 = 0; var_d5611fc5f0414087 < var_23ef870c8f42e6f0 ; var_d5611fc5f0414087++ )
            {
                level.var_1b5f750124116b6c.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
                wait 0.25;
                level.var_1b5f750124116b6c.sbl utility::function_7c10ea82c1e305b8( "fx", "off" );
                wait 0.25;
            }
            
            wait 0.75;
        }
        
        level.var_1b5f750124116b6c.sbl utility::function_7c10ea82c1e305b8( "fx", "on" );
        wait 3;
        level.var_1b5f750124116b6c.sbl utility::function_7c10ea82c1e305b8( "fx", "off" );
        wait 3;
    }
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 2, eflags: 0x4
// Checksum 0x50fd2111, Offset: 0x12e6
// Size: 0x136
function private function_5c00fc6400dd301b( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ft_jp_ee_init_finished" );
    var_abebc87adc0e386b = level zm_quest::function_73720cdf21c3cfd7( #"firefly_jumppad_ee", #"hash_dcf65999cbf1e9a" );
    
    if ( b_skipped || b_save_restored || var_abebc87adc0e386b )
    {
        return;
    }
    
    jumppad = utility::array_random( level.jumppad_ee_quest.var_68a84458df606370 );
    level.jumppad_ee_quest.rift_jumppad = jumppad;
    level.jumppad_ee_quest.rift_jumppad.var_94327e40bc639663 = 1;
    jumppad.s_rift.sbl utility::function_32b24db3127bff40( "entrance_vfx", "on" );
    jumppad.paths[ jumppad.s_rift.var_3bd0ce298a91260d ][ "path_percent_override" ] = 0.45;
    level callback::remove( "on_player_ft_jp_exited", &function_edd35865250b5844 );
    level callback::add( "on_player_ft_jp_exited", &function_edd35865250b5844 );
    level utility::flag_wait( "t_r_jp" );
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 1, eflags: 0x4
// Checksum 0x1d78687, Offset: 0x1424
// Size: 0x1e9
function private function_edd35865250b5844( sparams )
{
    self endon( #"death_or_disconnect" );
    jumppad = sparams.jumppad;
    b_reset = !level utility::flag( "t_r_jp" ) && ( level.jumppad_ee_quest.rift_jumppad != jumppad || level.jumppad_ee_quest.rift_jumppad.s_rift.var_3bd0ce298a91260d != jumppad.current_path_index );
    level.jumppad_ee_quest.rift_jumppad.paths[ level.jumppad_ee_quest.rift_jumppad.s_rift.var_3bd0ce298a91260d ][ "path_percent_override" ] = undefined;
    level.jumppad_ee_quest.rift_jumppad.s_rift.sbl utility::delaythread( 2.5, &utility::function_32b24db3127bff40, "entrance_vfx", "closing" );
    level utility::delaythread( 2.5, &callback::remove, "on_player_ft_jp_exited", &function_edd35865250b5844 );
    level.jumppad_ee_quest.rift_jumppad.var_94327e40bc639663 = 0;
    
    if ( b_reset )
    {
        level.jumppad_ee_quest.var_19d5ca1c740198dd utility::delaythread( 2.5, &utility::function_32b24db3127bff40, "entrance_vfx", "closing" );
        level.jumppad_ee_quest.var_a541351e94e554d9 = 1;
        level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_jumppad_ee", #"hash_d57e6de7e571b86" );
        return;
    }
    
    if ( !level utility::flag( "jp_r_g" ) )
    {
        level spawn_reward( self );
    }
    
    level utility::flag_set( "jp_r_g" );
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 2, eflags: 0x4
// Checksum 0xc47a929, Offset: 0x1615
// Size: 0x9e
function private function_3536e3e790a4b3ec( b_skipped, b_save_restored )
{
    level callback::remove( "on_player_ft_jp_entered", &function_34072089d7d4fb78 );
    level utility::flag_set( "t_r_jp" );
    var_abebc87adc0e386b = level zm_quest::function_73720cdf21c3cfd7( #"firefly_jumppad_ee", #"hash_dcf65999cbf1e9a" );
    
    if ( b_skipped && !level utility::flag( "jp_r_g" ) && !var_abebc87adc0e386b )
    {
        level spawn_reward( level.players[ 0 ] );
        level utility::flag_set( "jp_r_g" );
    }
    
    level retry_jumppad_ee();
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 1, eflags: 0x4
// Checksum 0x8d4c252d, Offset: 0x16bb
// Size: 0x50c
function private spawn_reward( specific_player )
{
    level.jumppad_ee_quest.var_19d5ca1c740198dd utility::function_32b24db3127bff40( "entrance_vfx", "on" );
    level utility::flag_set( "t_r_jp" );
    player_respawns = zone_manager::function_9dd25e9fb0ecd45b( level.jumppad_ee_quest.str_reward_zone_name );
    teleportpos = utility::array_random( player_respawns );
    specific_player thread zm_fasttravel::function_cbb08198e7c84adf( teleportpos, specific_player, undefined, 1, 0 );
    specific_player waittill( #"fasttravel_done" );
    wait 5;
    
    for ( i = 0; i < 10 ; i++ )
    {
        var_5da531956c557870 = round( level.var_a009ab14ee0d3223.var_5c8829ccd69f3862 / 8 ) + 1;
        var_d7b3a1f33b95bf77 = zm_utility::function_922d522db5f1ceda( int( var_5da531956c557870 ), [ "normal" ] );
        
        if ( !var_d7b3a1f33b95bf77 )
        {
            continue;
        }
        
        var_5239473c3fae77e8 = utility::spawn_tag_origin( level.jumppad_ee_quest.var_19d5ca1c740198dd.origin, ( 0, 0, 0 ) );
        var_d2dea1eb5c269d79 = randomfloatrange( 0.1, 0.5 );
        wait var_d2dea1eb5c269d79;
        spawner_zombie_type = function_b3988325430ce242( "zombie_shade" );
        zombie = agent_manager::spawn_agent( spawner_zombie_type, level.jumppad_ee_quest.var_19d5ca1c740198dd.origin, ( 0, 0, 0 ), "team_two_hundred" );
        
        if ( isdefined( zombie ) )
        {
            zombie linkto( var_5239473c3fae77e8 );
            var_5239473c3fae77e8 hide();
            zombie val::set( "jumppad_ee", "ignore_cleanup", 1 );
            zombie val::set( "jumppad_ee", "damage", 0 );
            zombie.b_cleanup_no_respawn = 1;
            zombie.ignore_enemy_count = 1;
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie.no_powerups = 1;
            zombie.var_15598d8e493afe88 = 1;
            zombie.var_2fc3a5fb762afb6e = 1;
            zombie.ignore_nuke_fx = 1;
            zombie.var_5927d2279779cec0 = 0;
            zombie.var_eb92c31552620100 = 1;
            zombie.do_immediate_ragdoll = 1;
            zombie.disable_spawn_vfx = 1;
            zombie.disable_spawn_sfx = 1;
            zombie utility::delaycall( 0.05, &unlink );
            zombie utility::delaycall( 0.05, &kill );
            playsoundatpos( zombie.origin, #"hash_15ab255a37fff7fd" );
        }
        
        var_5239473c3fae77e8 utility::delaycall( 0.1, &show );
        var_5239473c3fae77e8 utility::delaycall( 0.3, &delete );
    }
    
    wait 3;
    ground_pos = getgroundposition( level.jumppad_ee_quest.var_19d5ca1c740198dd.origin, 1 );
    vdir = vectornormalize( level.jumppad_ee_quest.var_19d5ca1c740198dd.origin - ground_pos );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( level.jumppad_ee_quest.var_19d5ca1c740198dd.origin, vdir );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.dropradiusscale = 2;
    var_998f9040e608619a = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_firefly_ft_jp_ee", "Default" );
    playsoundatpos( level.jumppad_ee_quest.var_19d5ca1c740198dd.origin, #"hash_c79e51b8fd6204f3" );
    
    if ( level.jumppad_ee_quest.rift_jumppad && specific_player )
    {
        level.jumppad_ee_quest.rift_jumppad utility::delaythread( 1.75, &zm_fasttravel_jumppad::play_vo_banter, #"ft_jp_ee", undefined, specific_player );
    }
    
    for ( i = 0; i < var_998f9040e608619a.size ; i++ )
    {
        itemspawnentryname = var_998f9040e608619a[ i ];
        itembundle = getscriptbundle( itemspawnentryname );
        common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
        wait 0.2;
    }
    
    random_points = getrandomnavpoints( ground_pos, 150, 3 );
    
    for ( i = 0; i < random_points.size ; i++ )
    {
        if ( game_utility::getgametype() == "zm_rb_daisy" )
        {
            level powerups::powerup_drop( "nuke", random_points[ i ] + ( 0, 0, 32 ), undefined, undefined, "quest" );
            continue;
        }
        
        level powerups::powerup_drop( "bonus_points_team", random_points[ i ] + ( 0, 0, 32 ), undefined, undefined, "quest" );
    }
    
    wait 2;
    level.jumppad_ee_quest.var_19d5ca1c740198dd utility::function_32b24db3127bff40( "entrance_vfx", "closing" );
}

// Namespace zm_sat_firefly_script_jumppad_ee
// Params 0, eflags: 0x4
// Checksum 0xdf270c43, Offset: 0x1bcf
// Size: 0x16c
function private retry_jumppad_ee()
{
    level endon( #"game_ended" );
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_jumppad_ee", #"hash_dcf65999cbf1e9a", 1 );
    var_49f7091014d2c59 = zm_round_logic::get_rb_round_number();
    var_d573ae91a5032f2e = level zm_quest::function_73720cdf21c3cfd7( #"firefly_jumppad_ee", #"hash_ffd66704e480f2fb" ) ?? var_49f7091014d2c59 + 6;
    level zm_quest::function_4eefe6de31f5ddab( #"firefly_jumppad_ee", #"hash_ffd66704e480f2fb", var_d573ae91a5032f2e );
    
    do
    {
        level waittill( #"on_round_start" );
        var_49f7091014d2c59 = zm_round_logic::get_rb_round_number();
    }
    while ( var_49f7091014d2c59 < var_d573ae91a5032f2e );
    
    level callback::remove( "on_player_ft_jp_entered", &function_34072089d7d4fb78 );
    level callback::add( "on_player_ft_jp_entered", &function_34072089d7d4fb78 );
    level utility::flag_clear( "t_a_jp" );
    level utility::flag_clear( "f_t_jp_i_o_a" );
    level utility::flag_clear( "t_jp_i_o" );
    level utility::flag_clear( "jp_ee_start" );
    level utility::flag_clear( "t_r_jp" );
    level utility::flag_clear( "jp_r_g" );
    level zm_quest::function_6265be8d0549e1b1( #"firefly_jumppad_ee", #"hash_ffd66704e480f2fb" );
    level zm_quest::function_6265be8d0549e1b1( #"firefly_jumppad_ee", #"hash_dcf65999cbf1e9a" );
    level thread zm_quest::function_80abdea0cd4c89a7( #"firefly_jumppad_ee", #"hash_d57e6de7e571b86" );
    level waittill( #"never" );
}

/#

    // Namespace zm_sat_firefly_script_jumppad_ee
    // Params 0, eflags: 0x4
    // Checksum 0x18da6189, Offset: 0x1d43
    // Size: 0x87, Type: dev
    function private init_jumppad_ee_debug()
    {
        zm_quest::function_1b5b11caffa04d9a( #"firefly_jumppad_ee", #"hash_d57e6de7e571b86" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x170>", "<dev string:x187>", &function_39c4d564aef44367 );
        devgui::add_devgui_func( "<dev string:x193>", "<dev string:x1a9>", &function_8c2b1fcf33952d70 );
        zm_quest::function_394bdba74beda0aa();
        zm_quest::function_1b5b11caffa04d9a( #"firefly_jumppad_ee", #"enter_rift" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1bc>", "<dev string:x1cf>", &function_39c4d564aef44367 );
        zm_quest::function_394bdba74beda0aa();
    }

    // Namespace zm_sat_firefly_script_jumppad_ee
    // Params 1, eflags: 0x4
    // Checksum 0x7f329c1f, Offset: 0x1dd2
    // Size: 0x17d, Type: dev
    function private function_39c4d564aef44367( params )
    {
        info_to_show = params[ 0 ];
        
        if ( info_to_show == "<dev string:x1db>" )
        {
            var_c64fc6ff1bd93e19 = "<dev string:x1dd>";
            
            foreach ( jumppad_index in level.jumppad_ee_quest.var_d1582e8bfcf16d26 )
            {
                var_c64fc6ff1bd93e19 += "<dev string:x1de>" + jumppad_index + "<dev string:x1de>";
            }
            
            iprintlnbold( "<dev string:x1e0>" + var_c64fc6ff1bd93e19 );
            return;
        }
        
        if ( info_to_show == "<dev string:x1f4>" )
        {
            if ( level.jumppad_ee_quest.var_7be076c9078045aa != 2 )
            {
                return;
            }
            
            path = level.jumppad_ee_quest.rift_jumppad.paths[ level.jumppad_ee_quest.rift_jumppad.s_rift.var_3bd0ce298a91260d ];
            iprintlnbold( "<dev string:x1f6>" + level.jumppad_ee_quest.rift_jumppad.script_noteworthy + "<dev string:x206>" + path[ "<dev string:x20b>" ] );
        }
    }

    // Namespace zm_sat_firefly_script_jumppad_ee
    // Params 1, eflags: 0x4
    // Checksum 0x87d1ac13, Offset: 0x1f57
    // Size: 0x34, Type: dev
    function private function_8c2b1fcf33952d70( parameters )
    {
        iprintlnbold( "<dev string:x210>" );
        level utility::flag_set( "<dev string:x262>" );
        waitframe();
        level utility::flag_clear( "<dev string:x262>" );
    }

#/
