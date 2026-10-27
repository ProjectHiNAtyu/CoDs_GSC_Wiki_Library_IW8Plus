// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_sq_echoes.gsc  (hash_30f6bcc4528ad312.gscc) (size: 33036 Bytes / 0x810c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x826f463 (136770659)
// size ...... 33036 (0x810c)
// includes .. 20  (offset: 0x7808)
// strings ... 120 (offset: 0x78a8)
// dev strs .. 5   (offset: 0x80d0)
// exports ... 62  (offset: 0x4d64)
// cseg ...... 0x9b1 + 0x43b3 (0x4d64)
// imports ... 245 (offset: 0x5714)
// animtree1 . 0   (offset: 0x810c)
// animtree2 . 0   (offset: 0x810c)
#using scripts\anim\utility;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\operator;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_sq_echoes_cs;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_sq_echoes;

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x5
// Checksum 0x971c43ec, Offset: 0x9cf
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ruby_sq_echoes", #"zm_quest", &function_16506755340ed4ef, &function_a749dd42b24cf80c );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x82b0c3be, Offset: 0x9fc
// Size: 0x12f
function private function_16506755340ed4ef()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.ruby_sq_echoes = zm_quest::get_quest( #"ruby_sq_echoes" );
    level callback::add( #"player_spawned", &function_d885e083919d43eb );
    zm_quest::register_quest_step( #"ruby_sq_echoes", #"find_footprints", &setup_footprints, &footprints_complete );
    zm_quest::register_quest_step( #"ruby_sq_echoes", #"hash_3e9707c967798d0d", &function_bd705982ffec051b, &function_d1c07be5ee80d280 );
    zm_quest::register_quest_step( #"ruby_sq_echoes", #"hash_3e9704c9677987f4", &function_6d813ef3aa3521e2, &function_4e103be56175b763 );
    zm_quest::register_quest_step( #"ruby_sq_echoes", #"hash_3e9705c9677989a7", &function_9d0f7074dfabd515, &function_b3609d3819be3652 );
    zm_quest::register_quest_step( #"ruby_sq_echoes", #"toy_interact", &setup_toy_scene, &function_ba3bdf7e81327343 );
    zm_quest::register_quest_step( #"ruby_sq_echoes", #"enter_cave", &function_c821ff5a1e4d8182, &cave_complete );
    zm_sat_ruby_sq_echoes_cs::main();
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x7034264e, Offset: 0xb33
// Size: 0x40
function private function_a749dd42b24cf80c()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"ruby_sq_echoes" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x3be89bf9, Offset: 0xb7b
// Size: 0x71
function private setup_footprints( b_skipped, b_save_restored )
{
    level utility::flag_wait( "begin_round_logic" );
    
    /#
        dvar = getdvarint( @"hash_d1782feba257ea89", 0 );
        
        if ( dvar >= 2 )
        {
            wait 2;
            var_9c1da103b1704592 = dvar == 5;
            level thread zm_quest::function_11b75e2232ce3d4( [ "<dev string:x24>", var_9c1da103b1704592 ] );
        }
    #/
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xf9345878, Offset: 0xbf4
// Size: 0x114
function private function_2fea282e0f59dcaf( str_id )
{
    trigger = getent( "echoes_fp_trigger_" + str_id, #targetname );
    
    while ( trigger )
    {
        trigger waittill( #"damage", iamount, eattacker, vdirection, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon );
        
        if ( issubstr( objweapon.basename, "molotov" ) && is_nikolai_operator( eattacker ) )
        {
            if ( str_id == 1 )
            {
                eattacker thread utility::delaycall( 2, &playsoundtoplayer, #"hash_51d917dd53049915", eattacker, eattacker );
            }
            else if ( str_id == 3 )
            {
                eattacker thread utility::delaycall( 2, &playsoundtoplayer, #"hash_633a65dd5ce1694f", eattacker, eattacker );
            }
            
            break;
        }
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xcd039e47, Offset: 0xd10
// Size: 0x1e
function private function_bd705982ffec051b( b_skipped, b_save_restored )
{
    function_2fea282e0f59dcaf( 1 );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xdae2161, Offset: 0xd36
// Size: 0x26
function private function_d1c07be5ee80d280( b_skipped, b_save_restored )
{
    activateworldevent( "we_ruby_sq_echoes_fp_1", 0, function_25c270ba1815b151() );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xf48ea281, Offset: 0xd64
// Size: 0x1e
function private function_6d813ef3aa3521e2( b_skipped, b_save_restored )
{
    function_2fea282e0f59dcaf( 2 );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x7f90cbd8, Offset: 0xd8a
// Size: 0x26
function private function_4e103be56175b763( b_skipped, b_save_restored )
{
    activateworldevent( "we_ruby_sq_echoes_fp_2", 0, function_25c270ba1815b151() );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xe3f5b6c3, Offset: 0xdb8
// Size: 0x1e
function private function_9d0f7074dfabd515( b_skipped, b_save_restored )
{
    function_2fea282e0f59dcaf( 3 );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xe7559070, Offset: 0xdde
// Size: 0x26
function private function_b3609d3819be3652( b_skipped, b_save_restored )
{
    activateworldevent( "we_ruby_sq_echoes_fp_3", 0, function_25c270ba1815b151() );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xcae1a2d5, Offset: 0xe0c
// Size: 0x15
function private footprints_complete( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x56a0dc35, Offset: 0xe29
// Size: 0x30
function private setup_toy_scene( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    level thread setup_toy_interact();
    level utility::flag_wait( "sq_echoes_activated" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x9c751717, Offset: 0xe61
// Size: 0x15c
function private setup_toy_interact()
{
    var_1e89bea37961a811 = utility::getstruct( "sq_echoes_toy" );
    level.ruby_sq_echoes.var_8d42655160ed67c3 = utility::spawn_model( "sat_zm_goat_toy_fxanim", var_1e89bea37961a811.origin, var_1e89bea37961a811.angles );
    level.ruby_sq_echoes.var_8d42655160ed67c3 hide();
    
    foreach ( player in level.players )
    {
        player function_d885e083919d43eb();
    }
    
    level thread function_76e6e5a949313b36( var_1e89bea37961a811.origin - ( 0, 0, 48 ) );
    level.ruby_sq_echoes.interact_doll = spawnscriptable( %"zm_sat_ruby_sq_echoes_toy_interact", var_1e89bea37961a811.origin );
    level.ruby_sq_echoes.interact_doll = interaction::register_scriptable_interact( level.ruby_sq_echoes.interact_doll, &toy_interact_used );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xc0c52794, Offset: 0xfc5
// Size: 0x108
function private function_d885e083919d43eb( params )
{
    if ( is_nikolai_operator( self ) && level.ruby_sq_echoes.var_8d42655160ed67c3 && ( !level.ruby_sq_echoes.var_58e9b8de8d7aede2 || !arraycontains( level.ruby_sq_echoes.var_58e9b8de8d7aede2, self ) ) )
    {
        level.ruby_sq_echoes.var_8d42655160ed67c3 showtoplayer( self );
        thread function_465b156e482605c0();
        
        if ( params )
        {
            wait 10;
            
            if ( !self )
            {
                return;
            }
            
            if ( zm_quest::is_quest_step_complete( #"ruby_sq_echoes", #"hash_3e9707c967798d0d" ) )
            {
                activateworldevent( "we_ruby_sq_echoes_fp_1", 1, self );
            }
            
            if ( zm_quest::is_quest_step_complete( #"ruby_sq_echoes", #"hash_3e9704c9677987f4" ) )
            {
                activateworldevent( "we_ruby_sq_echoes_fp_2", 1, self );
            }
            
            if ( zm_quest::is_quest_step_complete( #"ruby_sq_echoes", #"hash_3e9705c9677989a7" ) )
            {
                activateworldevent( "we_ruby_sq_echoes_fp_3", 1, self );
            }
        }
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x70b42282, Offset: 0x10d5
// Size: 0x77
function private function_76e6e5a949313b36( v_spawn )
{
    wait 8;
    trigger = spawn( "noent_volume_trigger_radius", v_spawn, 0, 512, 64 );
    
    while ( !level utility::flag( "sq_echoes_activated" ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && isalive( ent ) )
        {
            ent notify( #"hash_72a90f293ddf39c3" );
        }
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0xc
// Checksum 0x9cfff076, Offset: 0x1154
// Size: 0xa8
function private function_465b156e482605c0()
{
    self notify( #"hash_abf9d4def1844d9b" );
    self endon( #"hash_abf9d4def1844d9b" );
    self endon( #"death_or_disconnect" );
    level endon( #"sq_echoes_activated" );
    n_wait = lookupsoundlength( #"hash_2684badc04cb5daf", 1 ) * 0.001;
    
    while ( level.ruby_sq_echoes.var_8d42655160ed67c3 )
    {
        self waittill( #"hash_72a90f293ddf39c3" );
        self playsoundtoplayer( #"hash_2684badc04cb5daf", self, level.ruby_sq_echoes.var_8d42655160ed67c3 );
        wait n_wait;
        wait randomintrange( 7, 15 );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xf60b7ce8, Offset: 0x1204
// Size: 0x9c
function private toy_interact_used( player )
{
    if ( level utility::flag( "sq_echoes_activated" ) )
    {
        return;
    }
    
    if ( level.ruby_sq_echoes.var_58e9b8de8d7aede2 && arraycontains( level.ruby_sq_echoes.var_58e9b8de8d7aede2, player ) )
    {
        return;
    }
    
    if ( !is_nikolai_operator( player ) )
    {
        return;
    }
    
    level utility::flag_set( "sq_echoes_activated" );
    self setscriptablepartstate( "usable", "off" );
    level.ruby_sq_echoes.active_player = player;
    player playrumbleonentity( "damage_light" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x89d1b1b, Offset: 0x12a8
// Size: 0x2e
function private function_ba3bdf7e81327343( b_skipped, b_save_restored )
{
    level utility::flag_set( "sq_echoes_activated" );
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x58329d3c, Offset: 0x12de
// Size: 0x195
function private function_c821ff5a1e4d8182( b_skipped, b_save_restored )
{
    level utility::flag_wait( "begin_round_logic" );
    
    if ( !isdefined( level.ruby_sq_echoes.active_player ) )
    {
        level.ruby_sq_echoes.active_player = level.players[ 0 ];
    }
    
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level.ruby_sq_echoes.active_player zm_quest::disable_specific_player_bgb( 1 );
    level.ruby_sq_echoes.active_player.var_c966b63c8a2e3877 = 1;
    level.ruby_sq_echoes.active_player.bcdisabled = 1;
    level.ruby_sq_echoes.active_player.var_107a85bc107517bf = 1;
    level.ruby_sq_echoes.active_player.b_ignore_powerups = 1;
    
    if ( !level callback::exists( "end_echoes_sq", &cleanup_echoes_sq ) )
    {
        level callback::add( "end_echoes_sq", &cleanup_echoes_sq );
    }
    
    if ( !level callback::exists( "zm_exfil_started", &function_69d18e825270af2f ) )
    {
        level callback::add( "zm_exfil_started", &function_69d18e825270af2f );
    }
    
    level thread function_3fb67f8fde88c5fc();
    
    /#
        if ( getdvarint( @"hash_d1782feba257ea89", 0 ) == 4 )
        {
            level thread function_c564328baeaf49ba( level.players[ 0 ] );
            return;
        }
    #/
    
    level thread function_4cb1a2ebc9e32eaa();
    level utility::flag_wait( "sq_echoes_cave_complete" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0xcc86ad55, Offset: 0x147b
// Size: 0x27c
function private function_3fb67f8fde88c5fc()
{
    level endon( #"hash_b321384b80cbcc2d" );
    function_b866fb24354a94da( "start" );
    s_cave = utility::getstruct( "sq_echoes_cave" );
    player = level.ruby_sq_echoes.active_player;
    player val::set( "sq_echoes_vals_in_cave", "sprint", 0 );
    player val::set( "sq_echoes_vals_in_cave", "killstreaks", 0 );
    player val::set( "sq_echoes_vals_in_cave", "ignore_playable_area_check", 1 );
    player val::set( "sq_echoes_vals_in_cave", "round_spawning_ignore_player", 1 );
    
    if ( !player isspectatinganyone() )
    {
        player val::set( "sq_echoes_vals_in_cave", "show_hud", 0 );
    }
    
    player set_hallucination_values();
    level thread function_ec0a96b7fbe0197c( player );
    pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave_intro" );
    s_scene = utility::getstruct( "tag_align_hallucination" );
    s_scene.script_scenescriptbundle = "sat_zm_ruby_hallucination_enter_cave";
    s_scene thread scene::play( [ level.ruby_sq_echoes.var_8d42655160ed67c3, player ] );
    player playsound( #"hash_fda787dc38dc4964" );
    wait 4.5;
    player setscriptablepartstate( "ruby_echo_sfx", "transition_in", 0 );
    level musicbank_utility::function_5aca66c390aa347d( player, #"echoes" );
    game_utility::fadetoblackforplayerkeepui( player, 1, 2.5 );
    player player::hideminimap( 1 );
    wait 0.5;
    level utility::flag_wait( "sq_echoes_begin" );
    
    if ( player )
    {
        playfx( level._effect[ "teleport_splash_3p" ], player.origin );
    }
    
    wait 0.2;
    
    if ( !isalive( player ) || player isspectatinganyone() )
    {
        cleanup_echoes_sq();
        return;
    }
    
    player dontinterpolate();
    player setorigin( s_cave.origin );
    player setplayerangles( s_cave.angles );
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave_intro" );
    pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave" );
    wait 1;
    
    if ( player )
    {
        player unlink();
        level thread game_utility::fadetoblackforplayerkeepui( player, 0, 3 );
    }
    
    wait 1;
    
    if ( isalive( player ) && !player isspectatinganyone() )
    {
        level utility::flag_set( "sq_echoes_in_cave" );
        player function_f8e75eb2ce204b74();
        return;
    }
    
    cleanup_echoes_sq();
    return;
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xd0ab5e2d, Offset: 0x16ff
// Size: 0x123
function private function_ec0a96b7fbe0197c( player )
{
    level endon( #"hash_b321384b80cbcc2d" );
    player endon( #"death_or_disconnect" );
    
    if ( getdvarint( @"hash_d1782feba257ea89", 0 ) >= 2 )
    {
        level utility::flag_set( "sq_echoes_begin" );
        return;
    }
    
    player playsoundtoplayer( #"hash_2684c2dc04cb6b47", player );
    wait 7;
    
    if ( level.ruby_sq_echoes.var_8d42655160ed67c3 )
    {
        level.ruby_sq_echoes.var_8d42655160ed67c3 delete();
    }
    
    if ( level.ruby_sq_echoes.interact_doll )
    {
        level.ruby_sq_echoes.interact_doll freescriptable();
    }
    
    player playsoundtoplayer( #"hash_22d06cd0ccbbdc7d", player );
    n_wait = lookupsoundlength( #"hash_22d06cd0ccbbdc7d" ) * 0.001;
    wait n_wait;
    player playsoundtoplayer( #"hash_bad079f76d897bd", player );
    n_wait = lookupsoundlength( #"hash_bad079f76d897bd" ) * 0.001;
    wait n_wait;
    level utility::flag_set( "sq_echoes_begin" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x1a9308a3, Offset: 0x182a
// Size: 0x3b6
function private function_4cb1a2ebc9e32eaa()
{
    level endon( #"hash_b321384b80cbcc2d", #"game_ended" );
    level.ruby_sq_echoes.active_player endon( #"death_or_disconnect" );
    function_a608e1c5405a43e6( "a1" );
    function_a608e1c5405a43e6( "a2" );
    function_a608e1c5405a43e6( "a3" );
    function_a608e1c5405a43e6( "b1" );
    function_a608e1c5405a43e6( "b2" );
    function_a608e1c5405a43e6( "b3" );
    function_a608e1c5405a43e6( "c3" );
    function_a608e1c5405a43e6( "d3" );
    triggera = getnoentvolumearray( "sq_echoes_trigger_objects_a", #targetname )[ 0 ];
    triggerb = getnoentvolumearray( "sq_echoes_trigger_objects_b", #targetname )[ 0 ];
    triggerc = getnoentvolumearray( "sq_echoes_trigger_objects_c", #targetname )[ 0 ];
    triggerd = getnoentvolumearray( "sq_echoes_trigger_objects_d", #targetname )[ 0 ];
    
    if ( getdvarint( @"hash_d1782feba257ea89", 0 ) != 3 )
    {
        level.ruby_sq_echoes.var_d6e9d29777fe9078 = #"hash_5767badba31d79dc";
        function_b866fb24354a94da( "a1" );
        triggerb waittill( #"trigger" );
        function_a608e1c5405a43e6( "start" );
        function_b866fb24354a94da( "b1" );
        level thread function_b8acbde3ccb300bb();
        triggera waittill( #"trigger" );
        function_a608e1c5405a43e6( "a1" );
        function_b866fb24354a94da( "a2" );
        triggerb waittill( #"trigger" );
        function_a608e1c5405a43e6( "b1" );
        function_b866fb24354a94da( "b2" );
        triggerc waittill( #"trigger" );
        function_b866fb24354a94da( "c3" );
        triggera waittill( #"trigger" );
        function_a608e1c5405a43e6( "a2" );
        triggerb waittill( #"trigger" );
        function_a608e1c5405a43e6( "b2" );
        triggerd waittill( #"trigger" );
    }
    else
    {
        level thread function_b8acbde3ccb300bb();
        function_a608e1c5405a43e6( "start" );
        function_b866fb24354a94da( "c3" );
    }
    
    function_b866fb24354a94da( "a3" );
    function_b866fb24354a94da( "b3" );
    var_1be5586316eb3191 = utility::getstruct( "sq_echoes_cave_skull" );
    level.ruby_sq_echoes.var_e08fb3ecef124223 = utility::spawn_model( "sat_zm_death_altar_goat_skull", var_1be5586316eb3191.origin, var_1be5586316eb3191.angles, undefined, 0.8 );
    level.ruby_sq_echoes.var_e08fb3ecef124223.targetname = "sq_echoes_objects_b3";
    level.ruby_sq_echoes.var_e08fb3ecef124223 playloopsound( #"hash_3fa404e950070705" );
    var_cc9dbb3fbaaec44e = utility::getstruct( "sq_echoes_cave_interact" );
    interact = zm_quest::function_91f9590e98d57ff6( var_cc9dbb3fbaaec44e.origin, &altar_interact_used );
    interact setscriptablepartstate( "base", "hidden" );
    level thread function_a90e00bae5cb1a37( interact );
    level utility::flag_wait( "sq_echoes_toor_interact" );
    level notify( #"hash_19b46f384c44345d" );
    level notify( #"hash_19be5f384c4c6db2" );
    
    while ( true )
    {
        triggerb waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            function_a608e1c5405a43e6( "b3" );
            function_a608e1c5405a43e6( "a3" );
            function_b866fb24354a94da( "d3" );
            break;
        }
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x3e0d6c69, Offset: 0x1be8
// Size: 0x3b
function private function_a90e00bae5cb1a37( interact )
{
    interact endon( #"death" );
    wait 90;
    interact interaction::set_interact_hint_callback( &altar_hint_callback );
    interact setscriptablepartstate( "base", "small" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xb43621c0, Offset: 0x1c2b
// Size: 0x84
function private altar_hint_callback( usable, player )
{
    if ( player::isreallyalive( player ) && !player::isinlaststand( player ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"shared_hintstrings/hint_interact", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xb3b222, Offset: 0x1cb8
// Size: 0x18c
function private function_b866fb24354a94da( var_dbed2f4bd5ce85ad )
{
    level thread setup_vision_triggers( var_dbed2f4bd5ce85ad );
    str_targetname = "sq_echoes_objects_" + var_dbed2f4bd5ce85ad;
    var_2a345ab3ef50328c = getentarray( str_targetname, #targetname );
    
    foreach ( model in var_2a345ab3ef50328c )
    {
        model show();
        model solid();
        
        if ( model.classname == "script_brushmodel" )
        {
            model disconnectpaths();
        }
    }
    
    a_scriptables = getentitylessscriptablearray( str_targetname, #targetname );
    
    foreach ( scriptable in a_scriptables )
    {
        scriptable setscriptablepartstate( "model", scriptable.script_noteworthy );
    }
    
    activateworldevent( "we_lgt_nikolai_sq_" + var_dbed2f4bd5ce85ad );
    
    if ( var_dbed2f4bd5ce85ad == "b2" )
    {
        activateworldevent( "we_lgt_nikolai_sq_toor_drawing" );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x9c2ed8cd, Offset: 0x1e4c
// Size: 0x1c7
function private function_a608e1c5405a43e6( var_dbed2f4bd5ce85ad )
{
    level notify( "clear_vision_trigger_" + var_dbed2f4bd5ce85ad );
    str_targetname = "sq_echoes_objects_" + var_dbed2f4bd5ce85ad;
    
    if ( level.ruby_sq_echoes.active_player.str_vision_group == var_dbed2f4bd5ce85ad )
    {
        level thread function_6facddde2f4fd0f( level.ruby_sq_echoes.active_player );
    }
    
    var_2a345ab3ef50328c = getentarray( str_targetname, #targetname );
    
    foreach ( model in var_2a345ab3ef50328c )
    {
        if ( model.classname == "script_brushmodel" )
        {
            model connectpaths();
        }
        
        model hide();
        model notsolid();
    }
    
    a_scriptables = getentitylessscriptablearray( str_targetname, #targetname );
    
    foreach ( scriptable in a_scriptables )
    {
        scriptable setscriptablepartstate( "model", "off" );
    }
    
    if ( var_dbed2f4bd5ce85ad != "a3" && var_dbed2f4bd5ce85ad != "c3" )
    {
        deactivateworldevent( "we_lgt_nikolai_sq_" + var_dbed2f4bd5ce85ad );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0xf5413b20, Offset: 0x201b
// Size: 0xd9
function private function_f0280f4bb63ca7f5()
{
    self endon( #"death_or_disconnect" );
    level endon( #"hash_b321384b80cbcc2d", #"game_ended" );
    level.ruby_sq_echoes.var_d6e9d29777fe9078 = undefined;
    self playsoundtoplayer( #"hash_8ca0b7c3152e678a", self );
    n_wait = lookupsoundlength( #"hash_8ca0b7c3152e678a" ) * 0.001;
    wait n_wait;
    self playsoundtoplayer( #"hash_25eff9aef6e59974", self, self );
    n_wait = lookupsoundlength( #"hash_25eff9aef6e59974" ) * 0.001;
    wait n_wait;
    self playsoundtoplayer( #"hash_73f7395b778006bd", self );
    n_wait = lookupsoundlength( #"hash_73f7395b778006bd" ) * 0.001;
    wait n_wait + 1;
    level.ruby_sq_echoes.var_d6e9d29777fe9078 = #"hash_5767bddba31d7ef5";
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x2faf105d, Offset: 0x20fc
// Size: 0x126
function private function_b8acbde3ccb300bb()
{
    level endon( #"hash_b321384b80cbcc2d", #"game_ended" );
    level.ruby_sq_echoes.active_player endon( #"death_or_disconnect" );
    wait randomfloatrange( 3, 5 );
    n_count = 0;
    
    while ( !level utility::flag( "sq_echoes_cave_ending" ) )
    {
        if ( level.ruby_sq_echoes.var_d6e9d29777fe9078 )
        {
            v_forward = anglestoforward( level.ruby_sq_echoes.active_player getplayerangles( 1 ) ) * 500;
            v_loc = math::function_78a5b128a3e32460( level.ruby_sq_echoes.active_player.origin + v_forward, randomintrange( 600, 1200 ) ) + ( 0, 0, randomint( 100 ) );
            level.ruby_sq_echoes.active_player thread play_ambient_vo( v_loc );
            
            /#
                debugstar( v_loc );
            #/
            
            n_count++;
            
            if ( n_count > 5 )
            {
                wait randomfloatrange( 4, 7 );
            }
        }
        
        wait randomfloatrange( 2, 6 );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x47311a1e, Offset: 0x222a
// Size: 0xac
function private setup_vision_triggers( var_dbed2f4bd5ce85ad )
{
    a_triggers = getnoentvolumearray( "sq_echoes_trigger_vision", #targetname );
    
    foreach ( trigger in a_triggers )
    {
        if ( trigger.script_noteworthy == var_dbed2f4bd5ce85ad )
        {
            level thread function_42e3c579e95435dd( trigger );
        }
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x85d33676, Offset: 0x22de
// Size: 0x44a
function private function_42e3c579e95435dd( trigger )
{
    level endon( #"hash_b321384b80cbcc2d", #"game_ended" );
    level endon( "clear_vision_trigger_" + trigger.script_noteworthy );
    level endon( #"sq_echoes_toor_interact" );
    level.ruby_sq_echoes.active_player endon( #"death_or_disconnect" );
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            break;
        }
    }
    
    if ( trigger.script_noteworthy == "b2" )
    {
        level.ruby_sq_echoes.active_player thread function_f0280f4bb63ca7f5();
    }
    else if ( trigger.script_noteworthy == "b3" )
    {
        level.ruby_sq_echoes.var_d6e9d29777fe9078 = undefined;
    }
    
    a_targets = arrayrandomize( utility::getstructarray( trigger.target ) );
    b_first_trick = 1;
    
    if ( !isdefined( player.defaultbasefov ) )
    {
        player.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    do
    {
        v_camera = player utility::get_player_camera_origin();
        var_85c1642ce2d404e2 = v_camera + anglestoforward( player getplayerangles() ) * 100;
        
        foreach ( var_5990ce3727e634d1 in a_targets )
        {
            var_e2621754b4d5328c = math::anglebetweenvectors( var_5990ce3727e634d1.origin - v_camera, var_85c1642ce2d404e2 - v_camera );
            n_target_angle = var_5990ce3727e634d1.script_noteworthy ?? 10;
            
            if ( var_e2621754b4d5328c < int( n_target_angle ) )
            {
                if ( !player.str_vision_group )
                {
                    player.str_vision_group = trigger.script_noteworthy;
                    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave" );
                    pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave_intense" );
                    player setscriptablepartstate( "ruby_echo_sfx", "memory_ambience", 0 );
                    player set_no_weapon();
                    player thread play_ambient_vo( var_5990ce3727e634d1.origin );
                }
                
                player thread focus_view( vectortoangles( var_5990ce3727e634d1.origin - v_camera ) );
                
                if ( var_5990ce3727e634d1.script_label == "move" )
                {
                    a_movers = getentitylessscriptablearray( "hand", #script_noteworthy, var_5990ce3727e634d1.origin, 64 );
                    
                    foreach ( scriptable in a_movers )
                    {
                        if ( scriptable getscriptablepartstate( "model" ) == "hand" )
                        {
                            scriptable setscriptablepartstate( "model", "move" );
                        }
                    }
                }
                
                function_60c1cfc5c448f9aa( player, b_first_trick );
                a_targets = arrayremove( a_targets, var_5990ce3727e634d1 );
                b_first_trick = undefined;
                wait 1;
                break;
            }
        }
        
        wait 0.1;
    }
    while ( ( a_targets.size || trigger.script_noteworthy == "b3" ) && distance2d( player.origin, trigger.origin ) < trigger.radius + 10 );
    
    function_6facddde2f4fd0f( player );
    
    if ( trigger.script_noteworthy == "b2" )
    {
        deactivateworldevent( "we_lgt_nikolai_sq_toor_drawing" );
    }
    
    if ( trigger.script_noteworthy == "b3" && !level utility::flag( "sq_echoes_toor_interact" ) )
    {
        level.ruby_sq_echoes.var_d6e9d29777fe9078 = #"hash_5767bddba31d7ef5";
        level thread function_42e3c579e95435dd( trigger );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x4e638583, Offset: 0x2730
// Size: 0xa0
function private function_6facddde2f4fd0f( player, n_fov_time = 1 )
{
    player playrumbleonentity( "damage_heavy" );
    player.str_vision_group = undefined;
    player val::reset_all( "sq_echoes_vis" );
    player set_no_weapon( 0 );
    player modifybasefov( player.defaultbasefov, n_fov_time );
    player capturnrate( 999, 999 );
    player setscriptablepartstate( "ruby_echo_sfx", "main_ambience", 0 );
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave_intense" );
    pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xc04f46c2, Offset: 0x27d8
// Size: 0x16c
function private function_60c1cfc5c448f9aa( player, b_first_trick )
{
    level endon( #"hash_b321384b80cbcc2d", #"game_ended" );
    player val::set( "sq_echoes_vis", "move_speed_scale", 0.01 );
    player capturnrate( 0.01, 0.01 );
    defaultbasefov = player.defaultbasefov;
    player playrumbleonentity( "damage_light" );
    player modifybasefov( int( defaultbasefov * 0.6 ), 0.45 );
    wait 0.45;
    player playrumbleonentity( "damage_heavy" );
    player modifybasefov( int( defaultbasefov * 0.35 ), 1.25 );
    wait 1.25;
    
    if ( b_first_trick || utility::cointoss() )
    {
        player capturnrate( 11, 11 );
        player playrumbleonentity( "damage_light" );
        player modifybasefov( int( defaultbasefov * 0.5 ), 1 );
        wait 1;
    }
    
    player capturnrate( 66, 66 );
    player val::set( "sq_echoes_vis", "move_speed_scale", 0.2 );
    player playrumbleonentity( "damage_heavy" );
    player modifybasefov( int( defaultbasefov * 1.2 ), 0.7 );
    wait 0.7;
    player capturnrate( 222, 222 );
    player val::set( "sq_echoes_vis", "move_speed_scale", 0.65 );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 3, eflags: 0x4
// Checksum 0x4be1e980, Offset: 0x294c
// Size: 0xdc
function private focus_view( v_goal_angles, n_time = 1, var_899b9bbe505cba96 )
{
    level endon( #"hash_b321384b80cbcc2d", #"game_ended" );
    self endon( #"death_or_disconnect" );
    lerpfraction = 0;
    starttime = gettime();
    lerpduration = n_time * 1000;
    
    if ( !var_899b9bbe505cba96 )
    {
        v_goal_angles += ( 0, 0, randomintrange( -33, 33 ) );
    }
    
    while ( true )
    {
        timepassed = gettime() - starttime;
        lerpfraction = timepassed / lerpduration;
        
        if ( lerpfraction < 1 )
        {
            v_angles = anglelerpquatfrac( self getplayerangles(), v_goal_angles, lerpfraction );
            self setplayerangles( v_angles );
        }
        else
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xb2b578a6, Offset: 0x2a30
// Size: 0x5c
function private altar_interact_used( player )
{
    if ( level.ruby_sq_echoes.active_player != player )
    {
        return;
    }
    
    level utility::flag_set( "sq_echoes_toor_interact" );
    self setscriptablepartstate( "base", "off" );
    level thread function_a41e18946c1a5e0e( player, self.angles );
    self freescriptable();
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x463187fa, Offset: 0x2a94
// Size: 0x3e5
function private function_a41e18946c1a5e0e( player, var_d967c9a61ccbb884 )
{
    level endon( #"hash_b321384b80cbcc2d", #"game_ended" );
    player endon( #"death_or_disconnect" );
    player callback::add( #"player_death", &cleanup_echoes_sq );
    player callback::add( #"player_disconnect", &cleanup_echoes_sq );
    function_6facddde2f4fd0f( player, 0.1 );
    player set_hallucination_values();
    player set_no_weapon();
    pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave" );
    pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave_intense" );
    s_spawn = utility::getstruct( "sq_echoes_cave_monster" );
    e_smokey = utility::spawn_model( "tag_origin", s_spawn.origin, s_spawn.angles );
    level.ruby_sq_echoes.e_smokey = e_smokey;
    var_e08fb3ecef124223 = level.ruby_sq_echoes.var_e08fb3ecef124223;
    e_smokey linkto( var_e08fb3ecef124223 );
    level thread function_63ba54e679b0111d( player );
    wait 7;
    player thread function_d299a527e56f2132( "sat_vm_gesture_hallucination_touch_drawings", "sat_zm_vm_ges_ruby_hallucination_touch", 0.75 );
    wait 3.7;
    var_e08fb3ecef124223 stoploopsound();
    var_e08fb3ecef124223 playsound( #"hash_3d4923607eca48f9" );
    var_e08fb3ecef124223 rotateto( var_e08fb3ecef124223.angles - ( 35, 0, 0 ), 5 );
    wait 5;
    v_camera = player utility::get_player_camera_origin();
    var_247d22c685c1b9db = vectortoangles( v_camera - var_e08fb3ecef124223.origin );
    v_move = var_e08fb3ecef124223.origin + anglestoforward( var_247d22c685c1b9db ) * 10;
    var_247d22c685c1b9db = vectortoangles( v_camera - v_move );
    var_e08fb3ecef124223 rotateto( ( var_247d22c685c1b9db[ 0 ], var_247d22c685c1b9db[ 1 ], var_e08fb3ecef124223.angles[ 2 ] ), 0.1 );
    var_e08fb3ecef124223 moveto( v_move, 0.1 );
    wait 0.1;
    var_e08fb3ecef124223 playsound( #"hash_3d4920607eca43e0" );
    var_e08fb3ecef124223 vibrate( ( 0, 1, 0 ), 1, 0.1, 15 );
    player playrumblelooponentity( "low_highfreq" );
    level utility::flag_wait( "sq_echoes_spawn_toor" );
    var_e08fb3ecef124223 playsound( #"hash_3d4921607eca4593" );
    e_smokey unlink();
    e_smokey.scr_smokey = spawnscriptable( %"zm_sat_ruby_sq_echoes_monster", ( 0, 0, 0 ), ( 0, 0, 0 ), e_smokey );
    var_e08fb3ecef124223 vibrate( ( 1, 0, 1 ), 8, 0.08, 3.5 );
    wait 3.5;
    e_smokey.scr_smokey setscriptablepartstate( "vfx", "aura" );
    player function_f8e75eb2ce204b74();
    v_dir = vectornormalize( player.origin - s_spawn.origin );
    player knockback( utility::flatten_vector( v_dir ), 333, 1 );
    player dodamage( 5, e_smokey.origin, e_smokey );
    player stoprumble( "low_highfreq" );
    player playrumbleonentity( "damage_heavy" );
    player thread focus_view( vectortoangles( e_smokey.origin - player utility::get_player_camera_origin() ), 1, 1 );
    level utility::flag_clear( "sq_echoes_cave_ending" );
    level thread function_8e767d0167de42c5( e_smokey, player );
    level thread function_4dcaf984b93f41e3( e_smokey, player );
    wait 1;
    var_e08fb3ecef124223 delete();
    wait 4;
    player callback::remove( #"player_death", &cleanup_echoes_sq );
    player callback::remove( #"player_disconnect", &cleanup_echoes_sq );
    level thread function_c564328baeaf49ba( player, e_smokey );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x43ff7838, Offset: 0x2e81
// Size: 0x211
function private function_63ba54e679b0111d( player )
{
    level endon( #"hash_b321384b80cbcc2d" );
    player modifybasefov( int( player.defaultbasefov * 1.2 ), 2 );
    player thread utility::delaycall( 2, &modifybasefov, int( player.defaultbasefov * 0.8 ), 25 );
    var_e08fb3ecef124223 = level.ruby_sq_echoes.var_e08fb3ecef124223;
    var_d11d43c41aba7be7 = lookupsoundlength( #"hash_863e5c2539ff63f2" ) * 0.001 + 1;
    var_d11d44c41aba7e1a = lookupsoundlength( #"hash_863e5b2539ff623f" ) * 0.001 + 1;
    player thread focus_view( vectortoangles( var_e08fb3ecef124223.origin + ( 0, 0, -1 ) - player utility::get_player_camera_origin() ), var_d11d43c41aba7be7 + var_d11d44c41aba7e1a, 1 );
    player playsoundtoplayer( #"hash_863e5c2539ff63f2", player );
    wait var_d11d43c41aba7be7;
    
    if ( !player )
    {
        level utility::flag_set( "sq_echoes_spawn_toor" );
        return;
    }
    
    player playsoundtoplayer( #"hash_863e5b2539ff623f", player );
    wait var_d11d44c41aba7e1a;
    
    if ( !player )
    {
        level utility::flag_set( "sq_echoes_spawn_toor" );
        return;
    }
    
    player playsoundtoplayer( #"hash_863e5a2539ff608c", player );
    n_wait = lookupsoundlength( #"hash_863e5a2539ff608c" ) * 0.001 - 2.5;
    wait n_wait;
    level utility::flag_set( "sq_echoes_spawn_toor" );
    
    if ( player )
    {
        player playsoundtoplayer( #"hash_a777057376c9ae7a", player );
        player modifybasefov( int( player.defaultbasefov * 0.85 ), 0.15 );
    }
    
    wait 0.15;
    
    if ( player )
    {
        player modifybasefov( player.defaultbasefov, 6 );
    }
    
    wait lookupsoundlength( #"hash_a777057376c9ae7a" ) * 0.001 + 2;
    level.ruby_sq_echoes.var_d6e9d29777fe9078 = #"hash_5767bcdba31d7d42";
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x2a5a1f81, Offset: 0x309a
// Size: 0xc7
function private function_4dcaf984b93f41e3( e_smokey, player )
{
    level endon( #"hash_b321384b80cbcc2d" );
    
    while ( e_smokey && !level utility::flag( "sq_echoes_cave_ending" ) && isalive( player ) && !player isspectatinganyone() )
    {
        a_players = getplayersinradius( e_smokey.origin, 64 );
        
        if ( a_players[ 0 ] == player )
        {
            player dodamage( 2, e_smokey.origin, e_smokey );
            v_dir = vectornormalize( player.origin - e_smokey.origin );
            player knockback( utility::flatten_vector( v_dir ), 100 );
        }
        
        wait 0.2;
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0x41fcf544, Offset: 0x3169
// Size: 0xe5
function private function_8e767d0167de42c5( e_smokey, player )
{
    level endon( #"hash_b321384b80cbcc2d" );
    
    while ( !level utility::flag( "sq_echoes_cave_ending" ) && isalive( player ) && !player isspectatinganyone() && e_smokey )
    {
        var_b6081b1b6ba5e8b5 = distance2d( player.origin, e_smokey.origin );
        v_dir = vectornormalize( player.origin + ( 0, 0, 48 ) - e_smokey.origin );
        v_move = e_smokey.origin + v_dir * var_b6081b1b6ba5e8b5 * 0.85;
        e_smokey moveto( v_move, 2.5, 0.1, 2.4 );
        wait 2.5;
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xcb8b20e9, Offset: 0x3256
// Size: 0x33b
function private function_c564328baeaf49ba( player, e_smokey )
{
    a_ai = [];
    var_333ed03c6ac52ca6 = [];
    a_spawns = utility::getstructarray( "echoes_shade_spawn" );
    player val::set( "sq_echoes_vals_in_cave", "sprint", 1 );
    player val::set( "sq_echoes_vals_in_cave", "show_compass", 0 );
    player val::set( "sq_echoes_vals_in_cave", "show_hud", 1 );
    player thread function_91da363c4fc13c5a();
    
    while ( isalive( player ) && !player isspectatinganyone() && !level utility::flag( "ruby_boss_fight_start" ) && !level utility::flag( "sq_echoes_cave_ending" ) && level utility::flag( "sq_echoes_begin" ) )
    {
        var_f1136104cf02594e = utility::get_array_of_farthest( player.origin, a_spawns, var_333ed03c6ac52ca6 );
        var_34371a3f77041b8f = utility::array_slice( var_f1136104cf02594e, 0, 4 );
        
        foreach ( s_spawn in var_34371a3f77041b8f )
        {
            ai_shade = agent_manager::spawn_agent( "zombie_shade", s_spawn.origin, s_spawn.angles );
            ai_shade zm_utility::setup_quest_ai();
            ai_shade setscriptablepartstate( "eyes", "red_eyes" );
            ai_shade val::set( "cave_shade", "allow_brot", 0 );
            ai_shade zombie_shade_loot_consume::function_20b7d83929d84799( 1 );
            ai_shade callback::add( "on_zombie_ai_killed", &shade_death_drop );
            a_ai[ a_ai.size ] = ai_shade;
            waitframe();
        }
        
        var_333ed03c6ac52ca6 = arraycombine( var_333ed03c6ac52ca6, var_34371a3f77041b8f );
        
        if ( var_333ed03c6ac52ca6.size > 9 )
        {
            var_333ed03c6ac52ca6 = [];
        }
        
        do
        {
            if ( level utility::flag( "sq_echoes_shade_attack_time_up" ) )
            {
                n_min_shades = 8;
                wait 0.5;
            }
            else
            {
                n_min_shades = 4;
                wait 6;
            }
            
            a_ai = function_46f9072493651dc9( a_ai );
            
            if ( level utility::flag( "ruby_boss_fight_start" ) || level utility::flag( "sq_echoes_cave_ending" ) || !level utility::flag( "sq_echoes_begin" ) )
            {
                break;
            }
        }
        while ( a_ai.size > n_min_shades );
    }
    
    if ( level utility::flag( "ruby_boss_fight_start" ) || !level utility::flag( "sq_echoes_cave_ending" ) || !level utility::flag( "sq_echoes_begin" ) || !isalive( player ) || player isspectatinganyone() )
    {
        wait 5;
        level thread cleanup_echoes_sq();
        
        foreach ( ai in a_ai )
        {
            ai kill();
        }
        
        return;
    }
    
    level thread function_da6fa576363c5b4a( player, e_smokey, a_ai );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0xa2c487d5, Offset: 0x3599
// Size: 0xd9
function private function_91da363c4fc13c5a()
{
    self endon( #"death_or_disconnect" );
    level endon( #"sq_echoes_cave_ending" );
    level endon( #"hash_b321384b80cbcc2d" );
    wait 40;
    
    /#
        iprintlnbold( "<dev string:x2f>" );
    #/
    
    level utility::flag_set( "sq_echoes_shade_attack_time_up" );
    level thread utility::flag_set_delayed( "sq_echoes_cave_ending", 20 );
    val::set( "sq_echoes_hallucination", "death", 0 );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker );
        
        if ( self.health < 51 )
        {
            break;
        }
        
        a_ai = getaiarrayinradius( self.origin, 128, zm_utility::get_zombie_team() );
        
        if ( a_ai.size > 1 )
        {
            break;
        }
    }
    
    level utility::flag_set( "sq_echoes_cave_ending" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x1b48b99f, Offset: 0x367a
// Size: 0x3f
function private shade_death_drop( params )
{
    if ( randomint( 100 ) >= 75 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_sat_item_ammo", 1, spawnoptions );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0xcb6db149, Offset: 0x36c1
// Size: 0x33
function private shade_debug_draw()
{
    self endon( #"death" );
    
    /#
        while ( true )
        {
            utility::draw_tag_axis( "<dev string:x44>", ( 1, 0, 0 ) );
            waitframe();
        }
    #/
}

// Namespace zm_sat_ruby_sq_echoes
// Params 3, eflags: 0x4
// Checksum 0x7881733f, Offset: 0x36fc
// Size: 0x2ea
function private function_da6fa576363c5b4a( player, e_smokey, a_ai )
{
    level endon( #"hash_b321384b80cbcc2d" );
    player callback::add( #"player_death", &cleanup_echoes_sq );
    player callback::add( #"player_disconnect", &cleanup_echoes_sq );
    s_scene = utility::getstruct( "sat_cin_zm_vig_plr_dth_shade_01", "targetname" );
    level.ruby_sq_echoes.s_death_scene = s_scene;
    scene::add_scene_func( s_scene, &function_255a72e41c2a4018, "callback_play" );
    s_scene thread scene::pre_stream_play( 2, [ player ], "shot_010", "sat_cin_zm_vig_plr_dth_shade_01" );
    player val::set( "sq_echoes_hallucination", "death", 0 );
    player val::set( "sq_echoes_hallucination", "damage", 0 );
    game_utility::fadetoblackforplayerkeepui( player, 1, 1 );
    
    foreach ( ai in a_ai )
    {
        ai hide();
    }
    
    if ( isalive( player ) && !player isspectatinganyone() )
    {
        if ( player::isinlaststand( player ) )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
        
        player val::set( "sq_echoes_hallucination", "ignoreme", 1 );
        pbgpostfxbundleend( player, %"cer_zm_ruby_echoes_cave_intense" );
        pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave_outro" );
    }
    
    s_smokey = utility::getstruct( "sq_echoes_cave_monster_scene" );
    e_smokey moveto( s_smokey.origin, 1 );
    level utility::flag_wait( "sq_echoes_cave_complete" );
    
    if ( player )
    {
        if ( player::isinlaststand( player ) )
        {
            player thread laststand::exit( "last_stand_self_revive" );
        }
        
        player callback::remove( #"player_death", &cleanup_echoes_sq );
        player callback::remove( #"player_disconnect", &cleanup_echoes_sq );
    }
    
    e_smokey.scr_smokey freescriptable();
    e_smokey delete();
    wait 2;
    
    foreach ( ai in a_ai )
    {
        ai.ignore_enemy_count = 1;
        ai kill();
        corpse = ai getcorpseentity();
        
        if ( corpse )
        {
            corpse delete();
        }
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x7b645def, Offset: 0x39ee
// Size: 0x305
function private function_255a72e41c2a4018()
{
    level endon( #"hash_b321384b80cbcc2d" );
    
    if ( level.ruby_sq_echoes.s_death_scene )
    {
        level thread scene::remove_scene_func( level.ruby_sq_echoes.s_death_scene, &function_255a72e41c2a4018, "callback_play" );
    }
    
    if ( level.ruby_sq_echoes.active_player && !level.ruby_sq_echoes.active_player isspectatinganyone() )
    {
        level.ruby_sq_echoes.active_player val::set( "sq_echoes_death_scene", "show_hud", 0 );
    }
    
    var_9ac3bb793f88c30d = scene::get_entities();
    
    foreach ( ai in var_9ac3bb793f88c30d )
    {
        if ( isai( ai ) )
        {
            ai.ignore_enemy_count = 1;
            ai setscriptablepartstate( "eyes", "red_eyes" );
        }
    }
    
    if ( level.ruby_sq_echoes.active_player )
    {
        level.ruby_sq_echoes.active_player playlocalsound( #"hash_f32f93cea4f6ec0e" );
    }
    
    game_utility::fadetoblackforplayerkeepui( level.ruby_sq_echoes.active_player, 0, 0.5 );
    wait 6.2;
    
    if ( level.ruby_sq_echoes.active_player )
    {
        level.ruby_sq_echoes.active_player setscriptablepartstate( "ruby_echo_sfx", "transition_out", 0 );
        level.ruby_sq_echoes.active_player setsoundsubmix( "sat_zm_echoes_transition_out" );
        game_utility::fadetoblackforplayerkeepui( level.ruby_sq_echoes.active_player, 1, 1 );
    }
    
    thread scene::stop();
    
    if ( level.ruby_sq_echoes.active_player )
    {
        level.ruby_sq_echoes.active_player thread function_4a4e23c551b618ed();
    }
    
    level utility::flag_wait( "sq_echoes_cave_complete" );
    
    if ( level.ruby_sq_echoes.active_player )
    {
        level.ruby_sq_echoes.active_player clearsoundsubmix( "sat_zm_echoes_transition_out" );
    }
    
    wait 2;
    
    foreach ( ai in var_9ac3bb793f88c30d )
    {
        if ( isai( ai ) && isalive( ai ) )
        {
            ai kill();
        }
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x1b479c7a, Offset: 0x3cfb
// Size: 0x134
function private function_4a4e23c551b618ed()
{
    self endon( #"death_or_disconnect" );
    level endon( #"hash_b321384b80cbcc2d" );
    level utility::delaythread( 30, &utility::flag_set, "sq_echoes_cave_complete" );
    wait 1;
    set_hallucination_values();
    self playsoundtoplayer( #"hash_52ba15b74610c6f6", self );
    n_wait = lookupsoundlength( #"hash_52ba15b74610c6f6" ) * 0.001;
    wait n_wait - 1;
    self playsoundtoplayer( #"hash_d46598b47aebe715", self );
    n_wait = lookupsoundlength( #"hash_d46598b47aebe715" ) * 0.001;
    wait n_wait;
    level utility::flag_set( "sq_echoes_cave_complete" );
    level utility::flag_wait( "sq_echoes_exit_complete" );
    self playlocalsound( #"hash_48ac2191b2f2cec9" );
    thread function_26f883533a881a10();
    self playsoundtoplayer( #"hash_a407242090cc62fa", self );
    n_wait = lookupsoundlength( #"hash_a407242090cc62fa" ) * 0.001;
    wait n_wait;
    self playsoundtoplayer( #"hash_a407232090cc6147", self );
    n_wait = lookupsoundlength( #"hash_a407232090cc6147" ) * 0.001;
    wait n_wait;
    pbgpostfxbundleend( self, %"cer_zm_ruby_echoes_cave_outro" );
    self playsoundtoplayer( #"hash_c64cc6cf8726ec8d", self );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x4259fd3a, Offset: 0x3e37
// Size: 0x2e
function private function_26f883533a881a10()
{
    self endon( #"death_or_disconnect" );
    level endon( #"hash_b321384b80cbcc2d" );
    wait 4;
    function_d299a527e56f2132( "sat_vm_gesture_hallucination_ending", "sat_zm_vm_ges_ruby_hallucination_ending" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 2, eflags: 0x4
// Checksum 0xf7548d30, Offset: 0x3e6d
// Size: 0x2c3
function private cave_complete( b_skipped, b_save_restored )
{
    level endon( #"hash_b321384b80cbcc2d" );
    player = level.ruby_sq_echoes.active_player;
    
    /#
        if ( b_skipped || getdvarint( @"hash_d1782feba257ea89", 0 ) == 5 )
        {
            level utility::flag_wait( "<dev string:x4f>" );
            player = level.players[ 0 ];
            pbgpostfxbundlestart( player, %"cer_zm_ruby_echoes_cave_outro" );
            player thread function_4a4e23c551b618ed();
            level utility::flag_wait( "<dev string:x66>" );
            game_utility::fadetoblackforplayerkeepui( player, 1, 1 );
        }
    #/
    
    wait 1;
    
    if ( player && !b_save_restored && level utility::flag( "sq_echoes_cave_complete" ) )
    {
        var_30f37fb796562d78 = utility::getstruct( "sq_echoes_cave_exit" );
        player unlink( 1 );
        player dontinterpolate();
        player setorigin( var_30f37fb796562d78.origin );
        player setplayerangles( var_30f37fb796562d78.angles );
        playfx( level._effect[ "teleport_splash_3p" ], var_30f37fb796562d78.origin );
        player player::showminimap();
        deactivateworldevent( "we_ruby_sq_echoes_fp_1", 1, player );
        deactivateworldevent( "we_ruby_sq_echoes_fp_2", 1, player );
        deactivateworldevent( "we_ruby_sq_echoes_fp_3", 1, player );
        level thread game_utility::fadetoblackforplayerkeepui( player, 0, 2 );
        player function_37e122b643059d9();
        level musicbank_utility::function_4f253fd35ec68cbc( player, #"echoes" );
        player set_hallucination_values();
        player set_no_weapon();
        
        if ( !isdefined( level.ruby_sq_echoes.var_58e9b8de8d7aede2 ) )
        {
            level.ruby_sq_echoes.var_58e9b8de8d7aede2 = [];
        }
        
        level.ruby_sq_echoes.var_58e9b8de8d7aede2[ level.ruby_sq_echoes.var_58e9b8de8d7aede2.size ] = player;
    }
    
    level utility::flag_set( "sq_echoes_exit_complete" );
    wait 6;
    
    while ( player && player isgestureplaying( "sat_vm_gesture_hallucination_ending" ) )
    {
        waitframe();
    }
    
    if ( player && !b_save_restored )
    {
        level thread function_4b2658b5c40b54c( player );
        player.var_c966b63c8a2e3877 = undefined;
        player.bcdisabled = undefined;
        player.var_107a85bc107517bf = undefined;
        player.b_ignore_powerups = undefined;
        player val::set( "sq_echoes_death_scene", "show_hud", 1 );
        player zm_quest::disable_specific_player_bgb( 0 );
        player function_f8e75eb2ce204b74( 1 );
    }
    
    if ( level.players.size > 1 )
    {
        function_5ac44e521ff444f8( player );
        return;
    }
    
    function_23eb4faff5aa5e38();
    level utility::flag_clear( "sq_echoes_activated" );
    level.ruby_sq_echoes = undefined;
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x43a868fa, Offset: 0x4138
// Size: 0x5f
function private function_4b2658b5c40b54c( player )
{
    v_landing = player.origin + anglestoforward( player getplayerangles( 1 ) ) * 64;
    spawnoptions = common_item::function_b94327aa4c1b718b( v_landing, player );
    common_item::function_577fe3f000fcb275( 0.2, 6, %"hash_75a00c69c69ac021", spawnoptions );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x58f72721, Offset: 0x419f
// Size: 0x8a
function private function_37e122b643059d9()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    params = spawnstruct();
    params.timestamp = gettime();
    params.questname = #"zm_sat_ruby_sq_echoes";
    params.var_be82617e5e8087bd = [ self ];
    params.event = #"zm_sq_quest_complete";
    level callback::callback( #"hash_6c71d319dc089c27", params );
    level callback::callback( "zm_sq_quest_complete", params );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x76b50b9e, Offset: 0x4231
// Size: 0x26
function private function_23eb4faff5aa5e38()
{
    level callback::remove( "end_echoes_sq", &cleanup_echoes_sq );
    level callback::remove( "zm_exfil_started", &function_69d18e825270af2f );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x5a0c8421, Offset: 0x425f
// Size: 0x5c9
function private cleanup_echoes_sq( params )
{
    level notify( #"hash_b321384b80cbcc2d" );
    
    if ( !level.ruby_sq_echoes )
    {
        function_23eb4faff5aa5e38();
        level utility::flag_clear( "sq_echoes_activated" );
        return;
    }
    
    if ( level.ruby_sq_echoes.active_player )
    {
        level.ruby_sq_echoes.active_player function_f8e75eb2ce204b74();
        level.ruby_sq_echoes.active_player.var_c966b63c8a2e3877 = undefined;
        level.ruby_sq_echoes.active_player.bcdisabled = undefined;
        level.ruby_sq_echoes.active_player.var_107a85bc107517bf = undefined;
        level.ruby_sq_echoes.active_player.b_ignore_powerups = undefined;
        level.ruby_sq_echoes.active_player zm_quest::disable_specific_player_bgb( 0 );
        level.ruby_sq_echoes.active_player val::reset_all( "sq_echoes_vals_in_cave" );
        level.ruby_sq_echoes.active_player val::reset_all( "sq_echoes_weapons" );
        level.ruby_sq_echoes.active_player val::reset_all( "sq_echoes_death_scene" );
        level.ruby_sq_echoes.active_player val::reset_all( "sq_echoes_vis" );
        s_scene = utility::getstruct( "tag_align_hallucination" );
        
        if ( s_scene scene::get_state() == "Playing" )
        {
            s_scene thread scene::stop();
        }
        
        if ( level.ruby_sq_echoes.s_death_scene )
        {
            level thread scene::remove_scene_func( level.ruby_sq_echoes.s_death_scene, &function_255a72e41c2a4018, "callback_play" );
            level.ruby_sq_echoes.s_death_scene thread scene::stop();
        }
        
        level.ruby_sq_echoes.active_player unlink( 1 );
        level thread game_utility::fadetoblackforplayerkeepui( level.ruby_sq_echoes.active_player, 0, 0.1 );
        level.ruby_sq_echoes.active_player player::showminimap();
        level.ruby_sq_echoes.active_player callback::remove( #"player_death", &cleanup_echoes_sq );
        level.ruby_sq_echoes.active_player callback::remove( #"player_disconnect", &cleanup_echoes_sq );
        pbgpostfxbundleend( level.ruby_sq_echoes.active_player, %"cer_zm_ruby_echoes_cave" );
        pbgpostfxbundleend( level.ruby_sq_echoes.active_player, %"cer_zm_ruby_echoes_cave_intense" );
        pbgpostfxbundleend( level.ruby_sq_echoes.active_player, %"cer_zm_ruby_echoes_cave_intro" );
        pbgpostfxbundleend( level.ruby_sq_echoes.active_player, %"cer_zm_ruby_echoes_cave_outro" );
        
        if ( level.ruby_sq_echoes.active_player.defaultbasefov )
        {
            level.ruby_sq_echoes.active_player modifybasefov( level.ruby_sq_echoes.active_player.defaultbasefov );
        }
        
        level.ruby_sq_echoes.active_player capturnrate( 999, 999 );
        
        if ( params.b_teleport_out )
        {
            var_30f37fb796562d78 = utility::getstruct( "sq_echoes_cave_exit" );
            level.ruby_sq_echoes.active_player dontinterpolate();
            level.ruby_sq_echoes.active_player setorigin( var_30f37fb796562d78.origin );
            level.ruby_sq_echoes.active_player setplayerangles( var_30f37fb796562d78.angles );
            playfx( level._effect[ "teleport_splash_3p" ], var_30f37fb796562d78.origin );
        }
    }
    
    if ( level.ruby_sq_echoes.var_8d42655160ed67c3 )
    {
        level.ruby_sq_echoes.var_8d42655160ed67c3 delete();
    }
    
    if ( level.ruby_sq_echoes.interact_doll )
    {
        level.ruby_sq_echoes.interact_doll freescriptable();
    }
    
    if ( level.ruby_sq_echoes.e_smokey.scr_smokey )
    {
        level.ruby_sq_echoes.e_smokey.scr_smokey freescriptable();
    }
    
    if ( level.ruby_sq_echoes.e_smokey )
    {
        level.ruby_sq_echoes.e_smokey delete();
    }
    
    if ( level.ruby_sq_echoes.var_e08fb3ecef124223 )
    {
        level.ruby_sq_echoes.var_e08fb3ecef124223 delete();
    }
    
    if ( level.ruby_sq_echoes.var_4b1bd9a1fe2cf074 )
    {
        level.ruby_sq_echoes.var_4b1bd9a1fe2cf074 delete();
    }
    
    level.ruby_sq_echoes.var_d6e9d29777fe9078 = undefined;
    deactivateworldevent( "we_lgt_nikolai_sq_a1" );
    deactivateworldevent( "we_lgt_nikolai_sq_b1" );
    deactivateworldevent( "we_lgt_nikolai_sq_a2" );
    deactivateworldevent( "we_lgt_nikolai_sq_b2" );
    deactivateworldevent( "we_lgt_nikolai_sq_a3" );
    deactivateworldevent( "we_lgt_nikolai_sq_b3" );
    deactivateworldevent( "we_lgt_nikolai_sq_c3" );
    deactivateworldevent( "we_lgt_nikolai_sq_d3" );
    function_5ac44e521ff444f8();
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x510f535d, Offset: 0x4830
// Size: 0x11f
function private function_5ac44e521ff444f8( player )
{
    level utility::flag_clear( "sq_echoes_activated" );
    level utility::flag_clear( "sq_echoes_begin" );
    level utility::flag_clear( "sq_echoes_in_cave" );
    level utility::flag_clear( "sq_echoes_toor_interact" );
    level utility::flag_clear( "sq_echoes_spawn_toor" );
    level utility::flag_clear( "sq_echoes_shade_attack_time_up" );
    level utility::flag_clear( "sq_echoes_cave_ending" );
    level utility::flag_clear( "sq_echoes_cave_complete" );
    level utility::flag_clear( "sq_echoes_exit_complete" );
    
    if ( player )
    {
        if ( !isdefined( level.ruby_sq_echoes.var_58e9b8de8d7aede2 ) )
        {
            level.ruby_sq_echoes.var_58e9b8de8d7aede2 = [];
        }
        
        level.ruby_sq_echoes.var_58e9b8de8d7aede2[ level.ruby_sq_echoes.var_58e9b8de8d7aede2.size ] = player;
        player.var_c966b63c8a2e3877 = undefined;
        player.b_ignore_powerups = undefined;
    }
    
    level.ruby_sq_echoes.active_player = undefined;
    level thread zm_quest::function_80abdea0cd4c89a7( #"ruby_sq_echoes", #"toy_interact" );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xa77497a5, Offset: 0x4957
// Size: 0x6c
function private function_69d18e825270af2f( params )
{
    if ( level utility::flag( "sq_echoes_activated" ) && level.ruby_sq_echoes.active_player && arraycontains( params.a_exfil_players, level.ruby_sq_echoes.active_player ) )
    {
        level thread cleanup_echoes_sq( { #b_teleport_out:1 } );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x1db3dfd5, Offset: 0x49cb
// Size: 0x3c, Type: bool
function private is_nikolai_operator( player )
{
    if ( player operator::getoperatorref() == %"sat_rus_pl_magenta" )
    {
        return true;
    }
    
    /#
        if ( getdvarint( @"hash_d1782feba257ea89", 0 ) )
        {
            return true;
        }
    #/
    
    return false;
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x1efa9578, Offset: 0x4a10
// Size: 0x91
function private function_25c270ba1815b151()
{
    var_932a1e1237cef33e = [];
    
    foreach ( player in level.players )
    {
        if ( is_nikolai_operator( player ) )
        {
            var_932a1e1237cef33e[ var_932a1e1237cef33e.size ] = player;
        }
    }
    
    return var_932a1e1237cef33e;
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xfb6fc2f4, Offset: 0x4aaa
// Size: 0xca
function private play_ambient_vo( v_loc )
{
    if ( !level.ruby_sq_echoes.var_d6e9d29777fe9078 )
    {
        return;
    }
    
    if ( !level.ruby_sq_echoes.var_4b1bd9a1fe2cf074 )
    {
        level.ruby_sq_echoes.var_4b1bd9a1fe2cf074 = utility::spawn_model( "tag_origin", v_loc );
    }
    else
    {
        level.ruby_sq_echoes.var_4b1bd9a1fe2cf074 dontinterpolate();
        level.ruby_sq_echoes.var_4b1bd9a1fe2cf074.origin = v_loc;
    }
    
    if ( !self )
    {
        return;
    }
    
    self playsoundtoplayer( level.ruby_sq_echoes.var_d6e9d29777fe9078, self, level.ruby_sq_echoes.var_4b1bd9a1fe2cf074 );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 0, eflags: 0x4
// Checksum 0x3c58ab35, Offset: 0x4b7c
// Size: 0x4c
function private set_hallucination_values()
{
    val::set( "sq_echoes_hallucination", "ignoreme", 1 );
    val::set( "sq_echoes_hallucination", "freezecontrols", 1 );
    val::set( "sq_echoes_hallucination", "death", 0 );
    val::set( "sq_echoes_hallucination", "reload", 0 );
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0xd27d805c, Offset: 0x4bd0
// Size: 0x5f
function private function_f8e75eb2ce204b74( b_ending )
{
    val::reset_all( "sq_echoes_hallucination" );
    set_no_weapon( 0 );
    
    if ( b_ending )
    {
        self endon( #"death" );
        val::set( "sq_echoes_hallucination", "ignoreme", 1 );
        wait 5;
        val::reset_all( "sq_echoes_hallucination" );
        val::reset_all( "sq_echoes_vals_in_cave" );
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 3, eflags: 0x4
// Checksum 0xaa672250, Offset: 0x4c37
// Size: 0xbe
function private function_d299a527e56f2132( str_gesture, var_4450ba6666aac19a, var_337a903dfd3158a8 = 0 )
{
    self endon( #"death_or_disconnect" );
    level endon( #"hash_b321384b80cbcc2d" );
    set_no_weapon( 0 );
    
    while ( self getcurrentweapon().type == "none" )
    {
        waitframe();
    }
    
    val::set( "sq_echoes_weapons", "reload", 0 );
    var_961463cd2ff4ea9c = self getgestureanimlength( str_gesture );
    
    if ( var_4450ba6666aac19a )
    {
        utility::function_72b6372d2d8c997( var_4450ba6666aac19a, 1 );
    }
    else
    {
        self forceplaygestureviewmodel( str_gesture );
    }
    
    wait var_961463cd2ff4ea9c - var_337a903dfd3158a8;
    
    if ( !level utility::flag( "sq_echoes_exit_complete" ) )
    {
        set_no_weapon();
    }
}

// Namespace zm_sat_ruby_sq_echoes
// Params 1, eflags: 0x4
// Checksum 0x172d52e, Offset: 0x4cfd
// Size: 0x67
function private set_no_weapon( b_no_weapon = 1 )
{
    if ( b_no_weapon )
    {
        val::set( "sq_echoes_weapons", "weapon", 0 );
        val::set( "sq_echoes_weapons", "reload", 0 );
        return;
    }
    
    val::set( "sq_echoes_weapons", "weapon", 1 );
    val::set( "sq_echoes_weapons", "reload", 1 );
}

