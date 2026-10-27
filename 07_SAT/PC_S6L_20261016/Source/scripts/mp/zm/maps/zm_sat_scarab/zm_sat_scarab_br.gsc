// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_br.gsc  (hash_6c1f17f235760ccc.gscc) (size: 89284 Bytes / 0x15cc4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x838a1b73 (2206866291)
// size ...... 89284 (0x15cc4)
// includes .. 66  (offset: 0x1435c)
// strings ... 318 (offset: 0x1456c)
// dev strs .. 30  (offset: 0x15b38)
// exports ... 94  (offset: 0xf340)
// cseg ...... 0x172c + 0xdc14 (0xf340)
// imports ... 433 (offset: 0x101f0)
// animtree1 . 1   (offset: 0x15ca4)
// animtree2 . 1   (offset: 0x15cb4)
#using script_12c13822ade2c7b7;
#using script_16ea1b94f0f381b3;
#using script_290c63919fb4afde;
#using script_359c9cda9983c8fc;
#using script_54d7585f0a1791e6;
#using script_69e82e1f2f6d8101;
#using script_fd54ba823d404ad;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune;
#using scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_metabones;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_roar;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\metabone;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\anim_scene;
#using scripts\mp\arsenal;
#using scripts\mp\common\equipment\blackhole_bomb;
#using scripts\mp\common\field_upgrades\field_upgrades_aether_shroud;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\crafting_table;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\perk_machines;
#using scripts\mp\playerlogic;
#using scripts\mp\zm\gamelogic;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_boss_fight;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_boss_fight_oubliette;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_quest_fork_ee;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rh_coffin;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ww_quest;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\relics\zm_relics;
#using scripts\mp\zm\systems\zm_barnacle;
#using scripts\mp\zm\systems\zm_exfil;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_rabbithole;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_urchin;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_br;

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x5
// Checksum 0x33b88b91, Offset: 0x174a
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"scarab_br", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x5905ecf9, Offset: 0x1777
// Size: 0x21
function private pre_main()
{
    level.scarab_br = spawnstruct();
    level callback::add( "doorbuy_opened", &on_safehouse_opened );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xac315bfe, Offset: 0x17a0
// Size: 0x2a9
function private post_main()
{
    if ( !getdvarint( @"enable_rh", 0 ) )
    {
        return;
    }
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        level utility::flag_wait_or_timeout( "rh_validation_set", 120 );
    }
    
    if ( !level.rh_enabled && !getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        return;
    }
    
    scene::add_scene_func( "t10_cin_zm_vig_plr_dth_phobos_01", &function_8ffd4d1801274cd3, "callback_play" );
    scene::add_scene_func( "cin_t10_zm_vig_player_dth_keep_boss", &function_8ffd4d1801274cd3, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_vig_player_dth_neptune", &function_8ffd4d1801274cd3, "callback_play" );
    scene::add_scene_func( "sat_cin_zm_vig_player_dth_neptune", &function_8854f7023073f1db, "callback_play" );
    level utility::flag_wait( "zm_sat_scarab_br_cs_completed" );
    level.scarab_br.s_pap = utility::getstruct( "br_pap" );
    level.scarab_br.boss_spawn = utility::getstruct( "br_boss_spawn" );
    level.scarab_br.settings = getscriptbundle( "zombiebraisettings:settings_zombie_br" );
    level.scarab_br.zombie_kill_throttle = throttle::throttle_initialize( "br_zombies", 1, level.framedurationseconds ?? 0.1 );
    level.scarab_br.bosses = [];
    level.scarab_br.var_be82617e5e8087bd = [];
    level.scarab_br.vfx_spawn = utility::spawn_model( "tag_origin", level.scarab_br.boss_spawn.origin );
    level._effect[ "firefly_vehicle_teleport_in" ] = loadfxasset( "vfx_sat_levels_zm_firefly_vehicle_show" );
    level._effect[ "firefly_vehicle_teleport_out" ] = loadfxasset( "vfx_sat_levels_zm_firefly_vehicle_teleport_out" );
    level._effect[ "spawn_smoke" ] = loadfxasset( "vfx_iw9_equip_smoke_bomb_explo" );
    level._effect[ "red_smoke" ] = loadfxasset( "vfx_sat_zm_firefly_mq_chem_smoke_red_loop" );
    level._effect[ "black_hole" ] = loadfxasset( "vfx_t10_gameplay_zm_zmb_blackhole_looping" );
    level._effect[ "toy_trail" ] = loadfxasset( "vfx_sat_levels_zm_scarab_super_ee_phobos_tiny_glow" );
    level.scarab_br.fog = spawnscriptable( "sat_zm_scarab_rh_fog", level.scarab_br.boss_spawn.origin + ( 0, 0, -100 ) );
    init_path_to_portal_anims();
    
    /#
        function_5725ba6fcdad11e9();
    #/
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x84b5429e, Offset: 0x1a51
// Size: 0x44
function private on_safehouse_opened( params )
{
    if ( params.door.targetname == "doorbuy_safehouse_bedroom_1" )
    {
        level callback::remove( "doorbuy_opened", &on_safehouse_opened );
        level thread function_63f59beeff9da1f3();
    }
}

// Namespace zm_sat_scarab_br
// Params 0
// Checksum 0xe9729f4f, Offset: 0x1a9d
// Size: 0x9b
function function_63f59beeff9da1f3()
{
    var_209ed49971299121 = utility::getstruct( "scarab_br_box", "targetname" );
    level.scarab_br.var_73c2de41283f9f09 = interaction::register_interact( var_209ed49971299121.origin, 70, &br_start_interact );
    level.scarab_br.var_73c2de41283f9f09 setusepriority( -5 );
    level.scarab_br.var_73c2de41283f9f09 setusefov( 100 );
    level.scarab_br.var_73c2de41283f9f09 sethintonobstruction( "show" );
}

// Namespace zm_sat_scarab_br
// Params 2, eflags: 0x4
// Checksum 0xba9ffef1, Offset: 0x1b40
// Size: 0x9e
function private br_start_interact_hint( interact, player )
{
    if ( !player.interactions_disabled && !utility::flag( "start_br_vote" ) && player.var_a10da01c9aea8bf2 )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_64618f430151b2f0", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x39e44d01, Offset: 0x1be6
// Size: 0x6dc
function private br_start_interact( player )
{
    if ( !player.var_3815d538690d2f23 && !level utility::flag( "rh_to_pic" ) && ( player.var_fcb89b0f4082ab.size < 6 || !isdefined( player.var_fcb89b0f4082ab ) ) )
    {
        if ( player.var_fcb89b0f4082ab.size == 0 || !isdefined( player.var_fcb89b0f4082ab ) && !player utility::ent_flag( "vo_0_toys" ) )
        {
            player utility::ent_flag_set( "vo_0_toys" );
            level thread overlord::playconversation( #"0_toys", [ player ] );
            return;
        }
        
        if ( player.var_fcb89b0f4082ab.size > 0 && player.var_fcb89b0f4082ab.size <= 2 && !player utility::ent_flag( "vo_12_toys" ) )
        {
            player utility::ent_flag_set( "vo_12_toys" );
            level thread overlord::playconversation( #"12_toys", [ player ] );
            return;
        }
        
        if ( player.var_fcb89b0f4082ab.size > 2 && player.var_fcb89b0f4082ab.size <= 4 && !player utility::ent_flag( "vo_34_toys" ) )
        {
            player utility::ent_flag_set( "vo_34_toys" );
            level thread overlord::playconversation( #"34_toys", [ player ] );
            return;
        }
        
        if ( player.var_fcb89b0f4082ab.size == 5 && !player utility::ent_flag( "vo_5_toys" ) )
        {
            player utility::ent_flag_set( "vo_5_toys" );
            level thread overlord::playconversation( #"5_toys", [ player ] );
        }
        
        return;
    }
    else if ( level utility::flag( "rh_to_pic" ) && !player utility::ent_flag( "rh_toy_placed" ) && !player.var_3815d538690d2f23 && !level utility::flag( "rh_toy_placed_all_players" ) )
    {
        level utility::flag_set( "rh_toy_placed_all_players" );
        
        foreach ( player in level.players )
        {
            if ( level utility::flag( "rh_to_pic" ) && !player utility::ent_flag( "rh_toy_placed" ) && !player.var_3815d538690d2f23 )
            {
                s_loc = zm_sat_scarab_rh_coffin::get_cabinet_struct( "6" );
                var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
                scr_toy = spawnscriptable( %"hash_477b41eb17a3aa26", s_loc.origin, s_loc.angles, undefined, var_7c170ceae0649b57 );
                
                if ( player.var_fcb89b0f4082ab )
                {
                    player.var_fcb89b0f4082ab[ player.var_fcb89b0f4082ab.size ] = scr_toy;
                }
                
                player utility::ent_flag_set( "rh_toy_placed" );
                event_str = zm_rabbithole::function_85eaee7552aadd2e();
                level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", event_str, [ player ] );
                
                if ( isdefined( player.var_fcb89b0f4082ab ) && player.var_fcb89b0f4082ab.size >= 6 )
                {
                    level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_8f4de46115e0d713", [ player ] );
                    player.var_a10da01c9aea8bf2 = 1;
                    level thread overlord::playconversation( #"all_toys", [ player ] );
                    
                    foreach ( toy in player.var_fcb89b0f4082ab )
                    {
                        toy utility::function_7c10ea82c1e305b8( "glow", "on" );
                    }
                    
                    player.var_3815d538690d2f23 = 1;
                }
            }
        }
        
        return;
    }
    
    if ( level utility::flag( "rh_trial_active" ) || level utility::flag( "black_room_in_use" ) )
    {
        return;
    }
    
    if ( level utility::flag( "start_br_vote" ) )
    {
        return;
    }
    
    if ( !player.var_a10da01c9aea8bf2 )
    {
        iprintlnbold( "see achievement failed" );
        return;
    }
    
    iprintlnbold( "br initiated. Boss loading" );
    level utility::flag_set( "start_br_vote" );
    playworldsound( self.origin, #"hash_554587d46f1d7446" );
    
    if ( !istrue( level.scarab_br.start_vo_played ) )
    {
        level.scarab_br.start_vo_played = 1;
        level overlord::playconversation( #"br_start" );
    }
    
    var_3faf858e79cd17bb = spawnstruct();
    var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
    var_3faf858e79cd17bb.description = &"zm_hud/start_final_encounter";
    b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
    
    if ( !b_passed )
    {
        level utility::flag_clear( "start_br_vote" );
        return;
    }
    
    level utility::flag_clear( "start_br_vote" );
    
    if ( b_passed )
    {
        level val::set( "boss_fight", "task_logic_activate", 0 );
        assert( !isdefined( level.var_23378cc637cedbd7 ) );
        level.var_23378cc637cedbd7 = &br_bgb_banned;
        level.var_865fa84b8f7cc220 = 1;
        level notify( #"perk_purchased" );
        level thread zm_quest::cleanup_zombies_manually( undefined, undefined, undefined, undefined, 1, 1, 1, undefined, 1, undefined, 1 );
        level overlord::function_e155a19c69aed191();
        
        if ( game_utility::function_d68874417f3eea5c() )
        {
            foreach ( player in level.players )
            {
                if ( player.var_3c6c5d22d924de00 )
                {
                    player zm_sat_scarab_quest_fork_ee::function_72a8e3b2588248bb();
                }
            }
            
            level thread relics_turned_off();
        }
        
        function_e5abdd9a2b17158b();
        function_32938106712e2b72( 1 );
        function_7609962a351a5650( get_boss_spawn_location( 0 ), 1 );
        zm_vo::function_c0b0828d1107c141();
        level callback::add( #"player_spawned", &on_player_spawned_br );
        function_73d177a0b42c3418();
    }
}

// Namespace zm_sat_scarab_br
// Params 1
// Checksum 0x2a295c0f, Offset: 0x22ca
// Size: 0x1b, Type: bool
function br_bgb_banned( bgb )
{
    if ( bgb == "round_off" )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_br
// Params 0
// Checksum 0xc9e47f60, Offset: 0x22ee
// Size: 0x19
function relics_turned_off()
{
    level zm_relics::function_8603fa8bc8d11175();
    level utility::waittill_any_timeout( 3, "relics_deactivated" );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x317b8940, Offset: 0x230f
// Size: 0x14c
function private on_player_spawned_br( params )
{
    arr_spawn_pos = utility::getstructarray( "br_warp_loc" );
    start_struct = arr_spawn_pos[ self getentitynumber() ];
    
    if ( isalive( self ) && self.sessionstate != "spectator" )
    {
        self dontinterpolate();
        self setorigin( start_struct.origin );
        self setplayerangles( start_struct.angles );
    }
    
    if ( isalive( level.scarab_br.bosses[ "phobos" ] ) )
    {
        zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_phobos_healthbar", level.scarab_br.bosses[ "phobos" ] );
        return;
    }
    
    if ( isalive( level.scarab_br.bosses[ "triton" ] ) )
    {
        zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_triton_healthbar", level.scarab_br.bosses[ "triton" ] );
        return;
    }
    
    if ( isalive( level.scarab_br.bosses[ "neptune" ] ) )
    {
        zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_neptune_healthbar_3", level.scarab_br.bosses[ "neptune" ] );
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x57e4a724, Offset: 0x2463
// Size: 0x312
function private function_e5abdd9a2b17158b( param )
{
    level utility::flag_set( "scarab_br_started" );
    
    if ( level.scarab_br.var_73c2de41283f9f09 )
    {
        level.scarab_br.var_73c2de41283f9f09 delete();
    }
    
    zm_utility::open_sesame();
    zm_quest::quit_quest( #"scarab_pap_quest" );
    zone_manager::set_zone_enabled( "zone_boss_arena_ff", 1 );
    
    if ( level.var_a009ab14ee0d3223.isspecialround )
    {
        zm_round_logic::function_895fdc21ab019efe();
    }
    
    zm_round_spawning::pause_round_spawning( 1, "scarab_br_pause_spawning" );
    
    if ( isdefined( level.scarab_br.s_pap.var_370acb837a3a86c3 ) )
    {
        level.scarab_br.s_pap.var_370acb837a3a86c3 utility::function_7c10ea82c1e305b8( "collision", "on" );
    }
    
    level.var_654073823a58b613 = &function_cde1a241e03f804c;
    level.var_9075568a1189c7c9 = 1;
    var_7ca6202a92bb2679 = utility::getstructarray( "br_warp_loc" );
    
    if ( isdefined( param[ 0 ] ) )
    {
        foreach ( i, player in level.players )
        {
            if ( isalive( player ) && player.sessionstate != "spectator" )
            {
                player dontinterpolate();
                player setorigin( var_7ca6202a92bb2679[ i ].origin );
                player setplayerangles( var_7ca6202a92bb2679[ i ].angles );
            }
        }
        
        wait 1;
        
        switch ( param[ 0 ] )
        {
            case #"hash_e98f347639715156":
                start_phobos();
                break;
            case #"hash_8a217742296d8fd7":
                start_triton();
                break;
            case #"hash_498e81a4e20295dd":
                start_derby();
                break;
            case #"hash_18f5abac5fab9592":
                start_neptune();
                break;
            case #"hash_e3be83eb7c4af0da":
                start_weyward();
                break;
        }
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        var_7ca6202a92bb2679[ i ].target = "br_warp_loc";
        
        if ( level.players[ i ] utility::ent_flag( "consume_fruit_scene_in_prog" ) || level.players[ i ] utility::ent_flag( "WW_PLAYER_IN_A_P_SPACE" ) )
        {
            level.players[ i ] utility::ent_flag_waitopen_any( "consume_fruit_scene_in_prog" );
            level zm_sat_scarab_ww_quest::function_d5ddbca43097a0ff( utility::getstructarray( "sh_tp_spec" )[ i ] );
        }
        
        level thread zm_fasttravel::function_cbb08198e7c84adf( var_7ca6202a92bb2679[ i ], level.players[ i ] );
        level.players[ i ] thread revive_player();
    }
}

// Namespace zm_sat_scarab_br
// Params 4, eflags: 0x4
// Checksum 0x4bcac301, Offset: 0x277d
// Size: 0xc1
function private function_cde1a241e03f804c( var_be866219ba036c6, var_77fc4ed806f5cac9, var_51c533560222849c, var_9e41dd30435985b7 )
{
    if ( self.oubliette.var_c858d5cbff6ce7a )
    {
        return { #angles:self.angles, #origin:self.var_7ab4c9acb317c405 };
    }
    
    zone_name = isalive( level.scarab_br.bosses[ "weyward" ] ) ? "zone_boss_arena" : "zone_boss_arena_ff";
    s_respawn_group = zone_manager::function_9dd25e9fb0ecd45b( zone_name );
    return s_respawn_group[ 0 ].var_f448a26cf56f4a2a[ self getentitynumber() ];
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xe29648de, Offset: 0x2847
// Size: 0x8b
function private function_73d177a0b42c3418()
{
    function_5a405106c413a407();
    start_phobos();
    utility::flag_wait( "phobos_killed" );
    function_b55900a1d64fdc0e();
    start_triton();
    utility::flag_wait( "triton_killed" );
    function_25b97b4fb017d49();
    start_derby();
    utility::flag_wait( "derby_complete" );
    function_d28a0c86c187a0a0();
    start_neptune();
    utility::flag_wait( "neptune_killed" );
    function_382e2512b36f219b();
    start_weyward();
    utility::flag_wait( "weyward_killed" );
    function_7d318be4d3c5922f();
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x69ce1f58, Offset: 0x28da
// Size: 0x89
function private function_32938106712e2b72( b_jam )
{
    foreach ( player in level.players )
    {
        if ( player )
        {
            player function_d88e8eab88c50c13( b_jam );
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xbd82ccee, Offset: 0x296b
// Size: 0x14f
function private function_5a405106c413a407()
{
    foreach ( player in level.players )
    {
        player setsoundsubmix( "sat_zm_scarab_boss" );
        level.scarab_br.var_be82617e5e8087bd = arraycombineunique( level.scarab_br.var_be82617e5e8087bd, [ player ] );
    }
    
    level musicbank_utility::function_683e33ddcb824d18( #"round_start" );
    level musicbank_utility::function_683e33ddcb824d18( #"round_end" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_intro" );
    wait 7;
    level overlord::playconversation( #"br_intro" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_80c3cd2db6e7cf63" );
    wait 5;
    level thread overlord::playconversation( #"phobos_intro" );
    toy_spawn( "sat_zm_phobos_tiny", utility::getfx( "spawn_smoke" ), 3 );
    set_stations_active( 0 );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x5ba83d4b, Offset: 0x2ac2
// Size: 0x48
function private get_boss_spawn_location( is_weyward )
{
    if ( is_weyward )
    {
        return utility::getstruct( "scarab_boss_spawn_pos" ).origin;
    }
    
    return level.scarab_br.boss_spawn.origin;
}

// Namespace zm_sat_scarab_br
// Params 2, eflags: 0x4
// Checksum 0x1cb30055, Offset: 0x2b12
// Size: 0xd9
function private function_7609962a351a5650( origin, draw )
{
    entityless_scriptables = getentitylessscriptablearray( undefined, undefined, origin, 3000 );
    state = draw ? "active_force_top" : "idle";
    
    foreach ( scriptable in entityless_scriptables )
    {
        if ( scriptable && scriptable.type == "sat_zm_ammo_cache" )
        {
            scriptable utility::function_32b24db3127bff40( "icon", state );
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xaefe44c6, Offset: 0x2bf3
// Size: 0x4e6
function private start_phobos()
{
    if ( isalive( level.scarab_br.bosses[ "phobos" ] ) )
    {
        return;
    }
    
    setdvar( @"hash_24afcfc731250b7c", 0 );
    level.var_9c0d12c8f8edeb3d = "t10_cin_zm_vig_plr_dth_phobos_01";
    level.s_game_over_scene_override = utility::getstruct( "phobos_game_over_scene" );
    level.var_18f5b73acb7c11b8 = level.scarab_br.boss_spawn.origin;
    level.scarab_br.bosses[ "phobos" ] = agent_manager::spawn_agent( "sat_spawner_zombie_phobos_zm", level.scarab_br.boss_spawn.origin, level.scarab_br.boss_spawn.angles, zm_utility::get_zombie_team() );
    level.scarab_br.bosses[ "phobos" ] namespace_2823e49aa0908abb::function_9f1707d1a108b8e4( ( 27840, -27411, 2162 ), 900 );
    level.scarab_br.bosses[ "phobos" ] callback::add( "on_zombie_ai_killed", &on_phobos_killed );
    level.scarab_br.bosses[ "phobos" ] zombie_phobos_roar::function_4e28392984a29ec();
    level.scarab_br.bosses[ "phobos" ].var_6cd3687f6622091c = "j_spine2";
    level.scarab_br.bosses[ "phobos" ].puke_zombies_no_powerups = 1;
    level.scarab_br.bosses[ "phobos" ].cleanup_corpse_delay = 76.5;
    level.scarab_br.bosses[ "phobos" ].targetname = "topaz_boss";
    level.scarab_br.bosses[ "phobos" ].var_1f6335e27ced5dca = 1;
    level.var_405b4ed476bec54e = 1;
    level callback::add( "phobos_enraged_start_vo", &function_dc6b3310eff3140d );
    level callback::add( #"hash_3f722221fa539420", &function_70b60360aa6b07e1 );
    level callback::add( "phobos_puke_vo", &function_983cfedb6e16ea6b );
    level.scarab_br.bosses[ "phobos" ].maxhealth = level.scarab_br.bosses[ "phobos" ].maxhealth * 0.7;
    thread function_d61a90397b033244( level.scarab_br.settings.var_572dd901748bc6e3, level.scarab_br.bosses[ "phobos" ] );
    level.scarab_br.bosses[ "phobos" ] thread start_damage_circle( level.scarab_br.boss_spawn.origin + ( 0, 0, -80 ), 1500, 0.5 );
    level.scarab_br.bosses[ "phobos" ] thread function_25ab54d73644285a();
    level.scarab_br.bosses[ "phobos" ] zombie_utils::function_dfae6a5bd222c586( &function_bba281ef7db07f20 );
    level.scarab_br.bosses[ "phobos" ]._blackboard.var_a0ac2be830791eca = 0;
    level.scarab_br.bosses[ "phobos" ].var_2700f357dda9c693 = [ &function_86dd5087d65fac3a ];
    level.scarab_br.bosses[ "phobos" ] thread function_d796cd735f489bc6();
    level.scarab_br.bosses[ "phobos" ] thread function_ebed624ed16f1dbe();
    level.scarab_br.bosses[ "phobos" ] thread function_9fe0a4916e2055af();
    level.scarab_br.bosses[ "phobos" ] thread function_4b88f1b817e7413b();
    
    foreach ( player in level.players )
    {
        player thread function_2c304a70062bd0d6();
        player thread function_a2245f58e9c33324();
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xd39a11d6, Offset: 0x30e1
// Size: 0x61
function private function_2c304a70062bd0d6()
{
    self endon( #"disconnect" );
    level endon( #"phobos_killed" );
    
    while ( true )
    {
        self waittill( #"missile_fire", missile, objweapon );
        
        if ( !objweapon hasattachment( "sat_ammo_crossbow_bolt_explode" ) )
        {
            continue;
        }
        
        missile childthread function_7dca0036c388f1a1( objweapon );
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xa2605384, Offset: 0x314a
// Size: 0x157
function private function_7dca0036c388f1a1( objweapon )
{
    self waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( stuckto != level.scarab_br.bosses[ "phobos" ] )
    {
        return;
    }
    
    var_1022800c259a6dca = "sat_sl_crossbow_explosive_bolt_mp";
    
    if ( objweapon hasattachment( "sat_zm_sl_crossbow_pack" ) )
    {
        var_1022800c259a6dca = "sat_sl_crossbow_explosive_bolt_pap";
    }
    else if ( objweapon hasattachment( "sat_zm_sl_crossbow_pack4" ) )
    {
        var_1022800c259a6dca = "sat_sl_crossbow_explosive_bolt_pap4";
    }
    
    explosionradius = getgrenadedamageradius( var_1022800c259a6dca );
    explosionposition = position + normal;
    attacker = getmissileowner( self );
    wait getgrenadefusetime( var_1022800c259a6dca ) / 1000;
    phobos = level.scarab_br.bosses[ "phobos" ];
    
    if ( isalive( phobos ) && distancesquared( explosionposition, phobos.origin ) > squared( explosionradius ) )
    {
        phobos dodamage( weapongetdamagemax( objweapon, 0 ), explosionposition, attacker, attacker, "MOD_EXPLOSIVE", objweapon.basename );
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x54cabf4, Offset: 0x32a9
// Size: 0x69
function private function_a2245f58e9c33324()
{
    self endon( #"disconnect" );
    level endon( #"phobos_killed" );
    
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, objweapon );
        
        if ( !issubstr( weapon::getweaponrootname( objweapon ), "semtex" ) )
        {
            continue;
        }
        
        grenade childthread function_90d19309f62704b3( self, objweapon );
    }
}

// Namespace zm_sat_scarab_br
// Params 2, eflags: 0x4
// Checksum 0x808c707d, Offset: 0x331a
// Size: 0x12c
function private function_90d19309f62704b3( player, objweapon )
{
    level endon( #"phobos_killed" );
    self waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( stuckto != level.scarab_br.bosses[ "phobos" ] )
    {
        return;
    }
    
    explosionradius = getgrenadedamageradius( objweapon );
    attacker = getmissileowner( self );
    self waittill( #"explode", explosionposition );
    phobos = level.scarab_br.bosses[ "phobos" ];
    
    if ( isalive( phobos ) && distancesquared( explosionposition, phobos.origin ) > squared( explosionradius ) )
    {
        phobos dodamage( weapongetdamagemax( objweapon, 0 ), explosionposition, attacker, self, "MOD_EXPLOSIVE", objweapon.basename );
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x16a82661, Offset: 0x344e
// Size: 0x2e
function private function_4b88f1b817e7413b()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"phobos_step" );
        self playsoundonmovingent( "fly_ai_phobos_step_walk_default" );
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x99e592c7, Offset: 0x3484
// Size: 0xed, Type: bool
function private function_86dd5087d65fac3a( params )
{
    var_28dc1e2b877264a3 = 800;
    var_7e7092c99f8aa9ba = -12000;
    var_aab4f023f549dee7 = 0.95;
    var_3e64cf06c401fc45 = utility::drop_to_ground( self.origin, var_28dc1e2b877264a3, var_7e7092c99f8aa9ba, undefined, trace::create_solid_ai_contents( 1 ), [ self ], 1 );
    var_84dd7b9785298b67 = var_3e64cf06c401fc45[ 1 ];
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    
    if ( var_84dd7b9785298b67 && vectordot( var_84dd7b9785298b67, var_3d21eec29b566ffb ) < var_aab4f023f549dee7 )
    {
        return false;
    }
    else
    {
        var_3e64cf06c401fc45 = utility::drop_to_ground( params.ground_center, var_28dc1e2b877264a3, var_7e7092c99f8aa9ba, undefined, trace::create_solid_ai_contents( 1 ), [ self ], 1 );
        var_11920dd640b95ea8 = var_3e64cf06c401fc45[ 1 ];
        
        if ( var_11920dd640b95ea8 && vectordot( var_11920dd640b95ea8, var_3d21eec29b566ffb ) < var_aab4f023f549dee7 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xf5770a08, Offset: 0x357a
// Size: 0xd6
function private function_d796cd735f489bc6()
{
    self endon( #"death" );
    var_d43f99bb0a1adaa0 = 90;
    var_d78183d185e367ae = 0.1;
    var_e832a954070d6d6d = 1;
    
    while ( true )
    {
        self waittill( #"leap_attack_end" );
        wait var_d78183d185e367ae;
        var_bca699d7edd0aa69 = gettime();
        
        while ( !utility::time_has_passed( var_bca699d7edd0aa69, var_e832a954070d6d6d ) )
        {
            nav_pos = getclosestpointonnavmesh( self.origin );
            
            if ( nav_pos && ( abs( nav_pos[ 2 ] - self.origin[ 2 ] ) > var_d43f99bb0a1adaa0 || !ispointonnavmesh( self.origin ) ) )
            {
                ground_pos = utility::drop_to_ground( nav_pos, 500 );
                self forceteleport( ground_pos );
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xa4c47613, Offset: 0x3658
// Size: 0x114
function private function_ebed624ed16f1dbe()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_25b9324b5d419aee = 1;
    var_20c318139ace7244 = 1024;
    var_d341fcd6f0b1d556 = 150;
    
    while ( true )
    {
        utility::waittill_any( "bmeleeended", "leap_attack_end" );
        idle_origin = self.origin;
        idle_start_time = gettime();
        
        while ( !utility::time_has_passed( idle_start_time, var_25b9324b5d419aee ) )
        {
            if ( !function_a7dd84791ae7a451( idle_origin, var_20c318139ace7244 ) )
            {
                break;
            }
            
            waitframe();
        }
        
        if ( !function_a7dd84791ae7a451( idle_origin, var_20c318139ace7244 ) )
        {
            continue;
        }
        
        var_b718a4324486dcc = self.origin - anglestoforward( self.angles ) * var_d341fcd6f0b1d556;
        var_acefecea26e4c38d = getclosestpointonnavmesh( var_b718a4324486dcc, self, 0, 1, 1 );
        
        if ( var_acefecea26e4c38d && distancesquared( var_acefecea26e4c38d, self.origin ) > 0 )
        {
            self forceteleport( var_acefecea26e4c38d, self.angles, 3000 );
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x8fad6194, Offset: 0x3774
// Size: 0x1b9
function private function_9fe0a4916e2055af()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_11206bbc4de6b70b = 1;
    var_17b1fabfe503b562 = 2;
    var_2fc546e680b1fba7 = squared( 50 );
    var_f2dbce8992a82b43 = squared( 128 );
    var_343e63feb587740b = 12;
    
    while ( true )
    {
        if ( self.var_698903750734c086 && ( distancesquared( self.origin, level.var_18f5b73acb7c11b8 ) <= var_f2dbce8992a82b43 || utility::time_has_passed( self.var_850bc9951dcb1792, var_343e63feb587740b ) ) )
        {
            self clearpath();
            self clearbtgoal( 2 );
            self.var_698903750734c086 = 0;
            self.var_850bc9951dcb1792 = undefined;
            continue;
        }
        
        while ( !self.var_698903750734c086 && ( asm::asm_getcurrentstatename( self.asmname ) != "idle" || distancesquared( self.origin, level.var_18f5b73acb7c11b8 ) <= var_f2dbce8992a82b43 ) )
        {
            wait var_11206bbc4de6b70b;
        }
        
        idle_origin = self.origin;
        idle_start_time = gettime();
        
        while ( asm::asm_getcurrentstatename( self.asmname ) == "idle" && distancesquared( self.origin, idle_origin ) <= var_2fc546e680b1fba7 )
        {
            if ( utility::time_has_passed( idle_start_time, var_17b1fabfe503b562 ) )
            {
                self clearpath();
                self clearbtgoal( 2 );
                waitframe();
                self setbtgoalpos( 2, level.var_18f5b73acb7c11b8 );
                self.var_2888d9b4e47619e8 = 0;
                self.var_698903750734c086 = 1;
                self.var_850bc9951dcb1792 = gettime();
                break;
            }
            
            waitframe();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_br
// Params 2, eflags: 0x4
// Checksum 0x53891e81, Offset: 0x3935
// Size: 0x58, Type: bool
function private function_a7dd84791ae7a451( idle_origin, stationary_distance_sq )
{
    return self.var_c78b2c94679211a5 && self pathdisttogoal() <= 0 && asm::asm_getcurrentstatename( self.asmname ) == "idle" && distancesquared( self.origin, idle_origin ) <= stationary_distance_sq;
}

// Namespace zm_sat_scarab_br
// Params 3, eflags: 0x4
// Checksum 0x362c2011, Offset: 0x3996
// Size: 0x120
function private start_damage_circle( center_point, radius, var_803ea8d304e3f41e )
{
    level endon( #"game_ended" );
    wait 10;
    level.scarab_br.fog setscriptablepartstate( "vfx", "phobos_fade_in" );
    wait 5;
    
    while ( isalive( self ) )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, center_point ) > radius * radius )
            {
                player dodamage( 10, player.origin, self );
            }
        }
        
        wait var_803ea8d304e3f41e;
    }
    
    level.scarab_br.fog setscriptablepartstate( "vfx", "phobos_fade_out" );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x86aba8b1, Offset: 0x3abe
// Size: 0x3b
function private function_dc6b3310eff3140d( params )
{
    level callback::remove( "phobos_enraged_start_vo", &function_dc6b3310eff3140d );
    level overlord::playconversation( hashcat( #"hash_88be9c813f21efa5", randomintrange( 1, 4 ) ) );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xd7af08ee, Offset: 0x3b01
// Size: 0x4b
function private function_70b60360aa6b07e1( params )
{
    if ( params.interactionevent == #"hash_d34e1eadd49e5a21" )
    {
        level callback::remove( #"hash_3f722221fa539420", &function_70b60360aa6b07e1 );
        level overlord::playconversation( #"phobos_ride" );
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x3090872d, Offset: 0x3b54
// Size: 0x6c
function private function_983cfedb6e16ea6b( params )
{
    if ( !level callback::exists( #"player_damaged", &play_phobos_puke_vo ) )
    {
        level callback::add( #"player_damaged", &play_phobos_puke_vo );
    }
    
    wait 2;
    
    if ( level callback::exists( #"player_damaged", &play_phobos_puke_vo ) )
    {
        level callback::remove( #"player_damaged", &play_phobos_puke_vo );
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x8518a9b5, Offset: 0x3bc8
// Size: 0x7e
function private play_phobos_puke_vo( params )
{
    if ( params.objweapon.basename == "sat_zombie_phobos_spit_mp" && !level zm_vo::is_vo_on_cooldown( "phobos_puke_vo_cooldown" ) )
    {
        level callback::remove( #"player_damaged", &play_phobos_puke_vo );
        level overlord::playconversation( hashcat( #"phobos_vomit_alt", randomintrange( 1, 4 ) ) );
        level zm_vo::set_vo_on_cooldown( "phobos_puke_vo_cooldown", 45000 );
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xc1b2913e, Offset: 0x3c4e
// Size: 0x142
function private on_phobos_killed( params )
{
    level.scarab_br.bosses[ "phobos" ] callback::remove( "on_zombie_ai_killed", &on_phobos_killed );
    level callback::remove( "phobos_enraged_start_vo", &function_dc6b3310eff3140d );
    level callback::remove( #"hash_3f722221fa539420", &function_70b60360aa6b07e1 );
    level callback::remove( "phobos_puke_vo", &function_983cfedb6e16ea6b );
    self.var_f744e8be8b657e6e = function_5713d46873b29625( self.var_f744e8be8b657e6e );
    
    foreach ( Gas in self.var_f744e8be8b657e6e )
    {
        Gas freescriptable();
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    function_b9322c9b70c37b0c();
    wait 5;
    level overlord::playconversation( #"phobos_kill", undefined, undefined, 1 );
    utility::flag_set( "phobos_killed" );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x186e84d0, Offset: 0x3d98
// Size: 0x137
function private function_b55900a1d64fdc0e()
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    
    foreach ( player in level.players )
    {
        player thread revive_player();
    }
    
    spawn_powerups();
    set_stations_active( 1 );
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 1 );
    setomnvarforallclients( "ui_zm_echo_portal_time", gettime() + 61000 );
    setomnvarforallclients( "ui_zm_echo_portal_timer_string_index", getlocstringindex( &"hash_3991bf1327b7a158" ) );
    wait 51;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_80c3ce2db6e7d116" );
    wait 10;
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 0 );
    level thread overlord::playconversation( #"triton_intro" );
    toy_spawn( "sat_zm_triton_gtoy", utility::getfx( "spawn_smoke" ), 4 );
    set_stations_active( 0 );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x114765ee, Offset: 0x3ed7
// Size: 0x501
function private start_triton()
{
    if ( isalive( level.scarab_br.bosses[ "triton" ] ) )
    {
        return;
    }
    
    level.var_9c0d12c8f8edeb3d = "cin_t10_zm_vig_player_dth_keep_boss";
    level.s_game_over_scene_override = utility::getstruct( "triton_game_over_scene" );
    level.scarab_br.bosses[ "triton" ] = agent_manager::spawn_agent( "t10_spawner_zombie_triton", level.scarab_br.boss_spawn.origin, level.scarab_br.boss_spawn.angles, zm_utility::get_zombie_team() );
    level.scarab_br.bosses[ "triton" ].targetname = "triton_boss";
    level.scarab_br.bosses[ "triton" ].var_1f6335e27ced5dca = 1;
    level.scarab_br.bosses[ "triton" ].var_13518fb33ec73cc = 30;
    level.scarab_br.bosses[ "triton" ]._blackboard.var_6a8c50efac75caa1 = 550;
    level.scarab_br.bosses[ "triton" ] function_786bb6aa1b76c7ee( "minDistToLeapSlam", 200 );
    level.scarab_br.bosses[ "triton" ] function_786bb6aa1b76c7ee( "triton_do_patrol", 1 );
    level.scarab_br.bosses[ "triton" ] zombie_leap_attack::set_leap_attack_min_distance( 200 );
    level.scarab_br.bosses[ "triton" ] zombie_leap_attack::set_leap_attack_max_distance( 500 );
    level.scarab_br.bosses[ "triton" ] zombie_leap_attack::set_leap_attack_max_height( 300 );
    level.scarab_br.bosses[ "triton" ] zombie_leap_attack::enable_leap_attack();
    level.scarab_br.bosses[ "triton" ] setnavlayer( "zombie_xlarge_wide" );
    level.scarab_br.bosses[ "triton" ] callback::add( "on_zombie_ai_killed", &on_triton_killed );
    metabone::function_cd947f1a3391c065( "zombie_triton", &function_c6b5edfa664d8da0 );
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_triton_healthbar", level.scarab_br.bosses[ "triton" ] );
    }
    
    level.scarab_br.var_614b799eefbe7c74 = [];
    
    for ( i = 0; i < 10 ; i++ )
    {
        level.scarab_br.triton_events[ i ] = i;
    }
    
    arrayrandomize( level.scarab_br.triton_events );
    thread function_d61a90397b033244( level.scarab_br.settings.var_71b7c2a0006848a, level.scarab_br.bosses[ "triton" ] );
    
    if ( getdvarint( @"hash_c85f27db6ee0d95e", 0 ) )
    {
        level.scarab_br.bosses[ "triton" ] thread start_damage_circle( level.scarab_br.boss_spawn.origin + ( 0, 0, -80 ), 1500, 0.5 );
    }
    
    level.scarab_br.bosses[ "triton" ] val::set( "zombie_triton_br", "death", 0 );
    level.scarab_br.bosses[ "triton" ] zombie_utils::function_dfae6a5bd222c586( &function_398ddf52ff57ea23 );
    level.scarab_br.bosses[ "triton" ].var_e30ba852102cf5a0 = 1;
    level.scarab_br.bosses[ "triton" ].var_ff2326171cc4c2d = &function_12f4b45f101b4bda;
    level.scarab_br.bosses[ "triton" ] function_956e68058316fde2();
    level.scarab_br.bosses[ "triton" ] callback::add( "on_zombie_ai_killed", &on_br_triton_killed );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xb39bc48b, Offset: 0x43e0
// Size: 0xb6
function private on_br_triton_killed( params )
{
    var_f5b36fc50a58a5bf = getarraykeys( self.armorents );
    
    foreach ( var_1b23e8e2cb45ba36 in var_f5b36fc50a58a5bf )
    {
        if ( self.armorents[ var_1b23e8e2cb45ba36 ] )
        {
            self.armorents[ var_1b23e8e2cb45ba36 ] delete();
        }
    }
    
    self.armorents = undefined;
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xb30f7ee6, Offset: 0x449e
// Size: 0x28
function private function_956e68058316fde2()
{
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "triton_movement_speed", 1000 );
    zombie_triton_leap_slam::function_3ece4fadd14643a9( 9 );
    zombie_triton_lava_toss::function_c27e62fd83d783a0( 7 );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xb685956, Offset: 0x44ce
// Size: 0x352
function private function_12f4b45f101b4bda( lavabomb )
{
    lavabomb endon( #"delay_death" );
    lavabomb childthread delay_endon( "death" );
    wait 0.5;
    aoeradius = getdvarfloat( @"hash_be163b21db15ac7f", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a4b9402108e1bf0b ?? 160 );
    var_cc682460b6c05565 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c95d2bb263e931f5;
    var_c3c9f29969d5d817 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f8f70a51a69e2cf4;
    
    if ( isdefined( lavabomb ) )
    {
        var_4eff8aa729ab67c0 = anglestoright( lavabomb.angles );
        
        while ( true )
        {
            var_cc776669e934c5c1 = lavabomb getcentroid();
            trace_result = trace::capsule_get_closest_point( var_cc776669e934c5c1, 30, 60, undefined, 0, [ self, lavabomb ], trace::create_solid_ai_contents() );
            
            if ( trace_result[ "hittype" ] == "hittype_world" )
            {
                var_cdd779c976c1cffb = lavabomb.origin;
                lavabomb function_9478b01de03f42c5();
                lavabomb delete();
                var_1a919f72f736d773 = utility::drop_to_ground( var_cc776669e934c5c1, 100 );
                
                if ( distancesquared( var_cc776669e934c5c1, var_1a919f72f736d773 ) < squared( 60 ) )
                {
                    impactorigin = var_1a919f72f736d773;
                    impactangles = ( 0, 0, 1 );
                }
                else
                {
                    impactorigin = var_cdd779c976c1cffb;
                    var_70e80b53e1b1f756 = vectorcross( ( 0, 0, 1 ), trace_result[ "normal" ] * -1 );
                    var_b4dbbe29267fdf4d = vectorcross( trace_result[ "normal" ] * -1, var_70e80b53e1b1f756 );
                    impactangles = axistoangles( var_b4dbbe29267fdf4d, var_70e80b53e1b1f756, trace_result[ "normal" ] * -1 );
                }
                
                break;
            }
            else if ( isplayer( trace_result[ "entity" ] ) || isai( trace_result[ "entity" ] ) )
            {
                var_cdd779c976c1cffb = lavabomb.origin;
                lavabomb function_9478b01de03f42c5();
                lavabomb delete();
                var_1a919f72f736d773 = utility::drop_to_ground( var_cc776669e934c5c1, 0 );
                hitent = trace_result[ "entity" ];
                
                if ( hitent isonground() || distancesquared( hitent.origin, var_1a919f72f736d773 ) <= squared( 60 ) )
                {
                    impactorigin = var_1a919f72f736d773;
                    impactangles = ( 0, 0, 1 );
                }
                else
                {
                    impactorigin = trace_result[ "position" ];
                }
                
                break;
            }
            
            waitframe();
        }
        
        normal = ( 0, 0, 1 );
        var_2ca52b9507adc6a5 = undefined;
        impactangles = undefined;
        var_2ca52b9507adc6a5 = vectorcross( normal, var_4eff8aa729ab67c0 );
        impactangles = axistoangles( var_2ca52b9507adc6a5, var_4eff8aa729ab67c0, normal );
        
        if ( !hitent )
        {
            thread zombie_triton_lava_bomb::lava_bomb_aoe( impactorigin, impactangles, aoeradius, var_cc682460b6c05565, var_c3c9f29969d5d817 );
            self.var_cee5b607fe94f869 = undefined;
            self.var_2ddadacccfbca872 = undefined;
            return;
        }
        
        if ( hitent && isdefined( self.var_cee5b607fe94f869 ) )
        {
            thread zombie_triton_lava_bomb::lava_bomb_aoe( self.var_cee5b607fe94f869, impactangles, aoeradius, var_cc682460b6c05565, var_c3c9f29969d5d817 );
            self.var_cee5b607fe94f869 = undefined;
            self.var_2ddadacccfbca872 = undefined;
            return;
        }
        
        playsoundatpos( var_cdd779c976c1cffb + ( 0, 0, 50 ), #"exp_ai_triton_fireball_main" );
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x5ae62217, Offset: 0x4828
// Size: 0x21a
function private function_9478b01de03f42c5()
{
    lava_bomb = self;
    triton = getmissileowner( lava_bomb );
    nearbyenemies = getplayersandaiarrayinradius( lava_bomb.origin, 70, triton.enemy.team );
    
    if ( nearbyenemies.size > 0 && isalive( nearbyenemies[ 0 ] ) )
    {
        hitent = nearbyenemies[ 0 ];
        
        if ( isplayer( hitent ) )
        {
            hitent thread damage_effects::enableburnfxfortime( 1.5 );
        }
        
        var_19f299b8d961af85 = 100;
        groundtrace = trace::ray_trace( hitent.origin + ( 0, 0, var_19f299b8d961af85 * 2 ), hitent.origin + ( 0, 0, var_19f299b8d961af85 * -2 ), [ triton ], trace::create_solid_ai_contents( 1 ) );
        
        if ( groundtrace[ "hittype" ] != "hittype_none" )
        {
            groundpos = groundtrace[ "position" ];
            groundnormal = groundtrace[ "normal" ];
        }
        
        if ( triton && ( hitent isonground() || isdefined( groundpos ) && distancesquared( hitent.origin, groundpos ) <= squared( var_19f299b8d961af85 ) ) )
        {
            triton.var_cee5b607fe94f869 = groundpos;
            triton.var_2ddadacccfbca872 = groundnormal;
        }
        
        var_33d5d0fc10470612 = 0.6;
        var_35ec7ff62640ead = triton.var_4f2a7d74389f9eec ?? var_33d5d0fc10470612;
        var_fc3e8295da03323c = hitent.maxhealth * getdvarfloat( @"hash_37c06828ee562344", var_35ec7ff62640ead );
        var_55bc4979ee147531 = hitent.origin ?? lava_bomb.origin;
        
        if ( isdefined( hitent ) && isdefined( var_fc3e8295da03323c ) && isdefined( var_55bc4979ee147531 ) && isdefined( triton.grenadeweapon ) )
        {
            hitent dodamage( var_fc3e8295da03323c, var_55bc4979ee147531, self, self, "MOD_PROJECTILE", triton.grenadeweapon, "none", undefined, 65536 );
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xfd72f815, Offset: 0x4a4a
// Size: 0x23
function private delay_endon( string )
{
    self waittill( string );
    wait 4;
    self notify( "delay_" + string );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x8af65a58, Offset: 0x4a75
// Size: 0x695
function private function_c6b5edfa664d8da0( params )
{
    self endon( #"death" );
    
    if ( arraycontains( level.scarab_br.var_614b799eefbe7c74, params.metabone_name ) )
    {
        return;
    }
    
    level.scarab_br.var_614b799eefbe7c74[ level.scarab_br.var_614b799eefbe7c74.size ] = params.metabone_name;
    var_d87915476c50d139 = utility::array_random( level.scarab_br.triton_events );
    level.scarab_br.triton_events = arrayremove( level.scarab_br.triton_events, var_d87915476c50d139 );
    metabone_tag_name = get_metabone_tag_name( params.metabone_name );
    metabone_origin = self gettagorigin( metabone_tag_name );
    
    switch ( var_d87915476c50d139 )
    {
        case 0:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                level thread overlord::playconversation( #"triton_spiders" );
            }
            
            for ( i = 0; i < 4 + level.players.size ; i++ )
            {
                var_904ee913f7d90487 = agent_manager::spawn_agent( "sat_spawner_zombie_loom_minion_zm", getrandomnavpoint( metabone_origin, 150 ) );
                var_904ee913f7d90487 zombie_utils::set_zombie_round_difficulty( 30 );
            }
            
            break;
        case 1:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                level thread overlord::playconversation( hashcat( #"hash_9e3f7440aeb3c436", randomintrange( 1, 4 ) ) );
            }
            
            thread zombie_triton_lava_bomb::lava_bomb_aoe( self.origin, undefined, 160, 7, 9 );
            thread zombie_triton_lava_bomb::lava_bomb_aoe( getclosestpointonnavmesh( self.origin + ( 100, 100, 0 ) ), undefined, 160, 7, 9 );
            thread zombie_triton_lava_bomb::lava_bomb_aoe( getclosestpointonnavmesh( self.origin + ( -100, 100, 0 ) ), undefined, 160, 7, 9 );
            thread zombie_triton_lava_bomb::lava_bomb_aoe( getclosestpointonnavmesh( self.origin + ( 100, -100, 0 ) ), undefined, 160, 7, 9 );
            thread zombie_triton_lava_bomb::lava_bomb_aoe( getclosestpointonnavmesh( self.origin + ( -100, -100, 0 ) ), undefined, 160, 7, 9 );
            break;
        case 2:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                level thread overlord::playconversation( #"triton_grenades" );
            }
            
            for ( i = 0; i < level.players.size * 3 ; i++ )
            {
                target = level.players[ int( i / 3 ) ].origin + ( randomfloatrange( -200, 200 ), randomfloatrange( -200, 200 ), 0 );
                namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( level.equipment.table[ "equip_frag" ].weaponname, metabone_origin, target - metabone_origin, 3, 0 );
            }
            
            break;
        case 3:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                function_5ecc975a80c661b8();
            }
            
            common_item::function_47324f290423b2d1( %"hash_4218a12fc404cad4", metabone_origin, getrandomnavpoint( metabone_origin, 100 ) ?? self.origin, undefined, 1 );
            break;
        case 4:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                function_5ecc975a80c661b8();
            }
            
            powerup = powerups::powerup_drop( "full_power", metabone_origin );
            powerup moveto( getclosestpointonnavmesh( metabone_origin ) + ( 0, 0, 50 ), 0.5 );
            break;
        case 5:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                function_5ecc975a80c661b8();
            }
            
            for ( i = 0; i < 3 * level.players.size ; i++ )
            {
                common_item::function_47324f290423b2d1( %"hash_7211ee48fe72c9e9", metabone_origin, getrandomnavpoint( metabone_origin, 100 ) ?? self.origin, undefined, 1 );
                common_item::function_47324f290423b2d1( %"itemspawnentry:zm_t10_item_salvage_green", metabone_origin, getrandomnavpoint( metabone_origin, 100 ) ?? self.origin, undefined, 1 );
            }
            
            break;
        case 6:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                level thread overlord::playconversation( hashcat( #"hash_7e8b1b91d18cc4cc", randomintrange( 1, 4 ) ) );
            }
            
            foreach ( player in level.players )
            {
                if ( !isdefined( player.shockname ) )
                {
                    player thread shellshock_utility_cpmp::_shellshock( %"concussion_grenade_mp", #"stun", 5, 1 );
                }
            }
            
            break;
        case 7:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                level thread overlord::playconversation( #"triton_smoke" );
                level zm_vo::set_vo_on_cooldown( "triton_vo_cooldown", 8000 );
            }
            
            attractor = zombie_attractor_manager::add_attractor( self, 1, 2000, 1, undefined, &function_cc6605aa869c9c71 );
            attractor.skipteamcheck = 1;
            playfxontag( utility::getfx( "red_smoke" ), self, metabone_tag_name );
            wait 15;
            zombie_attractor_manager::remove_attractor( attractor );
            stopfxontag( utility::getfx( "red_smoke" ), self, metabone_tag_name );
            break;
        case 8:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                level thread overlord::playconversation( #"triton_black_hole" );
            }
            
            vortex = utility::spawn_tag_origin();
            vortex.origin = metabone_origin + ( 0, 0, -100 );
            vortex blackhole_bomb::function_259eadb8cbb1422f( metabone_origin, 0, 1000, 275, 10, 32, 0 );
            break;
        default:
            if ( !level zm_vo::is_vo_on_cooldown( "triton_vo_cooldown" ) )
            {
                wait 1.5;
                level thread overlord::playconversation( #"triton_nothing" );
            }
            
            break;
    }
    
    level zm_vo::set_vo_on_cooldown( "triton_vo_cooldown", 8000 );
}

// Namespace zm_sat_scarab_br
// Params 2, eflags: 0x4
// Checksum 0xe3f7f907, Offset: 0x5112
// Size: 0x23, Type: bool
function private function_cc6605aa869c9c71( attractor, zombie )
{
    return zombie != attractor.source;
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xf15d154c, Offset: 0x513e
// Size: 0xa1
function private get_metabone_tag_name( metabone_name )
{
    switch ( metabone_name )
    {
        case #"hash_923596e6d1867e5f":
            return "j_spine4";
        case #"hash_72814e58eb274a6":
            return "j_shoulder_armor_le";
        case #"hash_7620dfd1871963a4":
            return "j_elbow_le";
        case #"hash_b0bda7853e3d4f76":
            return "j_knee_le";
        case #"hash_1aa53d4d43e15db":
            return "j_shoulder_armor_ri";
        case #"hash_b9c30dbd52677711":
            return "j_elbow_ri";
        case #"hash_8ed83fd9e6dcb5ab":
            return "j_knee_ri";
        default:
            return;
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xd4c9c6bc, Offset: 0x51e7
// Size: 0x2c
function private function_5ecc975a80c661b8()
{
    if ( !istrue( self.var_9315dec8e6cf80a1 ) )
    {
        self.var_9315dec8e6cf80a1 = 1;
        level thread overlord::playconversation( #"triton_powerup" );
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x8ff7b930, Offset: 0x521b
// Size: 0x88
function private on_triton_killed( params )
{
    level.scarab_br.bosses[ "triton" ] callback::remove( "on_zombie_ai_killed", &on_triton_killed );
    metabone::function_1024597ed2932aba( "zombie_triton", &function_c6b5edfa664d8da0 );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    function_b9322c9b70c37b0c();
    wait 10;
    level overlord::playconversation( #"triton_kill" );
    utility::flag_set( "triton_killed" );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x7ff40e5a, Offset: 0x52ab
// Size: 0x41d
function private function_25b97b4fb017d49()
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    
    foreach ( player in level.players )
    {
        player thread revive_player();
    }
    
    spawn_powerups();
    set_stations_active( 1 );
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 1 );
    setomnvarforallclients( "ui_zm_echo_portal_time", gettime() + 61000 );
    wait 51;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_80c3cf2db6e7d2c9" );
    wait 10;
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 0 );
    level thread overlord::playconversation( #"derby_intro" );
    var_57de497f9a0b6c1d = utility::spawn_model( "veh_sat_wc_truck_pluto_turret_small", level.scarab_br.boss_spawn.origin + ( 150, 0, 1000 ), level.scarab_br.boss_spawn.angles );
    var_57de467f9a0b6584 = utility::spawn_model( "sat_zm_npc_sister_full", level.scarab_br.boss_spawn.origin + ( -150, 0, 1000 ), level.scarab_br.boss_spawn.angles );
    playfxontag( utility::getfx( "toy_trail" ), var_57de497f9a0b6c1d, "tag_origin" );
    playfxontag( utility::getfx( "toy_trail" ), var_57de467f9a0b6584, "tag_origin" );
    var_57de497f9a0b6c1d playsoundonmovingent( #"hash_e09d7ba217076d26" );
    var_57de497f9a0b6c1d playloopsound( #"hash_2ff0cf9678d66ed7" );
    var_57de497f9a0b6c1d moveto( level.scarab_br.boss_spawn.origin + ( 150, 0, 100 ), 2, 1, 1 );
    var_57de467f9a0b6584 moveto( level.scarab_br.boss_spawn.origin + ( -150, 0, 100 ), 2, 1, 1 );
    var_57de497f9a0b6c1d rotateyaw( 360, 12 );
    var_57de467f9a0b6584 rotateyaw( -360, 12 );
    wait 2;
    var_57de497f9a0b6c1d bobbing( ( 0, 0, -1 ), 5, 2 );
    var_57de467f9a0b6584 bobbing( ( 0, 0, -1 ), 5, 2 );
    wait 4;
    var_57de497f9a0b6c1d playsoundonmovingent( #"hash_1a6c6e424b397db0" );
    var_57de497f9a0b6c1d moveto( level.scarab_br.boss_spawn.origin + ( 150, 0, 150 ), 0.5, 0.2, 0.2 );
    var_57de467f9a0b6584 moveto( level.scarab_br.boss_spawn.origin + ( -150, 0, 150 ), 0.5, 0.2, 0.2 );
    wait 0.5;
    var_57de497f9a0b6c1d moveto( level.scarab_br.boss_spawn.origin + ( 300 * minint( level.players.size - 1, 1 ), 0, -50 ), 0.3, 0.1 );
    var_57de467f9a0b6584 moveto( level.scarab_br.boss_spawn.origin + ( -300 * minint( level.players.size - 1, 1 ), 0, -50 ), 0.3, 0.1 );
    wait 0.2;
    var_57de497f9a0b6c1d playsoundonmovingent( #"hash_4b52d6ce6d6bd419" );
    var_57de497f9a0b6c1d delete();
    var_57de467f9a0b6584 delete();
    set_stations_active( 0 );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xb0ebbca, Offset: 0x56d0
// Size: 0x426
function private start_derby()
{
    level.var_9c0d12c8f8edeb3d = undefined;
    level.s_game_over_scene_override = undefined;
    level utility::flag_set( "disable_pluto_beam" );
    setdvar( @"hash_2b4c8822dd1d39d8", 0.33 );
    setdvar( @"hash_7782e26f82a4502b", 15 );
    setdvarifuninitialized( @"hash_6a2220e497e2e651", 1 );
    level.scarab_br.derby_kills = 0;
    level.scarab_br.var_9f3bddc1ec56f4a = 0;
    
    if ( level.players.size > 1 )
    {
        level.scarab_br.tessies[ 0 ] = vehicle::spawn( %"hash_62a07b56f29782f5", utility::getstruct( "center_east" ) );
        level.scarab_br.tessies[ 1 ] = vehicle::spawn( %"hash_62a07b56f29782f5", utility::getstruct( "center_west" ) );
    }
    else
    {
        level.scarab_br.tessies[ 0 ] = vehicle::spawn( %"hash_62a07b56f29782f5", level.scarab_br.boss_spawn );
    }
    
    waitframe();
    
    foreach ( tessie in level.scarab_br.tessies )
    {
        playworldsound( tessie.origin + ( 0, 0, 75 ), #"hash_2d98570ff81153e6" );
        tessie.stagerequested = 5;
    }
    
    level.scarab_br.derby_phase = 1;
    level.scarab_br.var_96abe85e1ab9284 = 1;
    level.scarab_br.var_6d453312db09b27b = [];
    level.scarab_br.var_6d453312db09b27b[ 1 ] = [ 100, 200, 300 ];
    level.scarab_br.var_6d453312db09b27b[ 2 ] = [ 170, 350, 530 ];
    level.scarab_br.var_6d453312db09b27b[ 3 ] = [ 210, 415, 620 ];
    level.scarab_br.var_6d453312db09b27b[ 4 ] = [ 240, 470, 700 ];
    numplayers = clampint( level.players.size, 1, 4 );
    level.scarab_br.var_54d559a90871e9c5 = level.scarab_br.var_6d453312db09b27b[ numplayers ][ 0 ] + randomintrange( -10, 10 );
    level.scarab_br.var_f0faf2b18b5603a0 = level.scarab_br.var_6d453312db09b27b[ numplayers ][ 1 ] + randomintrange( -10, 10 );
    level.scarab_br.var_1e81ea293f08567f = level.scarab_br.var_6d453312db09b27b[ numplayers ][ 2 ] + randomintrange( -10, 10 );
    zm_quest::function_cd1f2fee4749fb0a( 1, #"scarab_br", #"hash_4a3e1c6215db2d7e" );
    zm_quest::function_c2af37f835cd840b( round( level.scarab_br.var_54d559a90871e9c5 * 2, 100 ), 1, #"scarab_br", #"hash_4a3e1c6215db2d7e" );
    level callback::add( "on_zombie_ai_killed", &function_68a1d1c1368b569f );
    thread function_d61a90397b033244( level.scarab_br.settings.var_631170b87a9aa16 );
    zm_barnacle::init_boss_fight_barnacles();
    zm_barnacle::function_9e12daed54bc6f53();
    thread function_24fb63a350a723a7();
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0xc
// Checksum 0x314a3c2, Offset: 0x5afe
// Size: 0x82
function private function_c76f83ce313c6d20()
{
    self notify( #"hash_bc23c5c8d5cd5e4b" );
    self endon( #"hash_bc23c5c8d5cd5e4b" );
    level endon( #"game_ended" );
    level endon( #"derby_ended" );
    
    while ( level.scarab_br.derby_kills < level.scarab_br.var_1e81ea293f08567f )
    {
        zm_urchin::function_9dcc3820f6db0b( 2 + level.scarab_br.derby_phase * 2 );
        wait 30;
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0xc
// Checksum 0xbb2a4c45, Offset: 0x5b88
// Size: 0x83
function private function_24fb63a350a723a7()
{
    self notify( #"hash_60cd3a8d2a9d8df3" );
    self endon( #"hash_60cd3a8d2a9d8df3" );
    level endon( #"game_ended" );
    level endon( #"derby_ended" );
    wait 25;
    
    while ( level.scarab_br.derby_kills < level.scarab_br.var_1e81ea293f08567f )
    {
        zm_barnacle::function_b2c54b98dc238f9( 2 * level.scarab_br.tessies.size );
        wait 25;
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xe611aa2e, Offset: 0x5c13
// Size: 0x451
function private function_68a1d1c1368b569f( params )
{
    level.scarab_br.derby_kills++;
    level zm_quest::function_9f49b2a045ece8ae( level.scarab_br.derby_kills, 1, #"scarab_br", hashcat( #"hash_1d166461eadd31bb", level.scarab_br.derby_phase ) );
    
    if ( level.scarab_br.derby_kills >= level.scarab_br.var_54d559a90871e9c5 && level.scarab_br.var_96abe85e1ab9284 < 2 )
    {
        level.scarab_br.var_96abe85e1ab9284 = 2;
        level overlord::playconversation( #"hash_46f103656f750c6d" );
        level.scarab_br.derby_phase = 2;
        zm_quest::function_cd1f2fee4749fb0a( 1, #"scarab_br", #"hash_4a3e1b6215db2bcb" );
        zm_quest::function_c2af37f835cd840b( round( level.scarab_br.var_f0faf2b18b5603a0 * 1.5, 100 ), 1, #"scarab_br", #"hash_4a3e1b6215db2bcb" );
        zm_quest::function_9f49b2a045ece8ae( level.scarab_br.derby_kills, 1, #"scarab_br", hashcat( #"hash_1d166461eadd31bb", level.scarab_br.derby_phase ) );
        function_b9322c9b70c37b0c( 0 );
        thread function_d61a90397b033244( level.scarab_br.settings.var_631170b87a9aa16, undefined, 1 );
        thread function_c76f83ce313c6d20();
        return;
    }
    
    if ( level.scarab_br.derby_kills >= level.scarab_br.var_f0faf2b18b5603a0 && level.scarab_br.var_96abe85e1ab9284 < 3 )
    {
        level.scarab_br.var_96abe85e1ab9284 = 3;
        level overlord::playconversation( #"hash_46f102656f750aba" );
        level.scarab_br.derby_phase = 3;
        zm_quest::function_cd1f2fee4749fb0a( 1, #"scarab_br", #"hash_4a3e1a6215db2a18" );
        zm_quest::function_c2af37f835cd840b( round( level.scarab_br.var_1e81ea293f08567f * 1.3, 100 ), 1, #"scarab_br", #"hash_4a3e1a6215db2a18" );
        zm_quest::function_9f49b2a045ece8ae( level.scarab_br.derby_kills, 1, #"scarab_br", hashcat( #"hash_1d166461eadd31bb", level.scarab_br.derby_phase ) );
        function_b9322c9b70c37b0c( 0 );
        thread function_d61a90397b033244( level.scarab_br.settings.var_631170b87a9aa16, undefined, 2 );
        return;
    }
    
    if ( level.scarab_br.derby_kills >= level.scarab_br.var_1e81ea293f08567f && level.scarab_br.var_96abe85e1ab9284 < 4 )
    {
        level.scarab_br.var_96abe85e1ab9284 = 4;
        function_b9322c9b70c37b0c( 0 );
        thread function_d61a90397b033244( level.scarab_br.settings.var_631170b87a9aa16, undefined, 3 );
        level overlord::playconversation( #"hash_46f0fd656f75023b" );
        level.scarab_br.derby_phase = 4;
        zm_quest::function_cd1f2fee4749fb0a( 1, #"scarab_br", #"hash_4a3e216215db35fd" );
        zm_quest::function_c2af37f835cd840b( randomintrange( 2001, 9999 ), 1, #"scarab_br", #"hash_4a3e216215db35fd" );
        zm_quest::function_9f49b2a045ece8ae( level.scarab_br.derby_kills, 1, #"scarab_br", hashcat( #"hash_1d166461eadd31bb", level.scarab_br.derby_phase ) );
        thread finish_derby( 15 );
        return;
    }
    
    thread function_fb5114d5b283d885( params );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xeab7f77c, Offset: 0x606c
// Size: 0x18f
function private function_fb5114d5b283d885( params )
{
    if ( params.smeansofdeath == "MOD_CRUSH" && params.eattacker.vehiclename == "veh_sat_firefly_pluto" )
    {
        if ( level.scarab_br.derby_phase > level.scarab_br.var_9f3bddc1ec56f4a )
        {
            if ( level.scarab_br.derby_phase == 1 && level.scarab_br.derby_kills > level.scarab_br.var_54d559a90871e9c5 * 0.5 || level.scarab_br.derby_phase == 2 && level.scarab_br.derby_kills > level.scarab_br.var_f0faf2b18b5603a0 * 0.75 || level.scarab_br.derby_phase == 3 && level.scarab_br.derby_kills > level.scarab_br.var_1e81ea293f08567f * 0.83 )
            {
                level.scarab_br.var_9f3bddc1ec56f4a++;
                level thread overlord::playconversation( hashcat( #"hash_22e554e6a3d48c3b", level.scarab_br.derby_phase * 4 - randomint( 4 ) ) );
            }
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x75c2f872, Offset: 0x6203
// Size: 0x234
function private finish_derby( derby_end_delay = 0 )
{
    level endon( #"game_ended" );
    wait derby_end_delay;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    level thread overlord::playconversation( #"derby_complete" );
    level notify( #"derby_ended" );
    level callback::remove( "on_zombie_ai_killed", &function_68a1d1c1368b569f );
    level zm_quest::function_fb3af5600f6a9441( 4, 1, #"scarab_br", #"hash_4a3e216215db35fd" );
    wait 1;
    function_b9322c9b70c37b0c();
    zm_urchin::function_f5d3679bd21a64b();
    zm_barnacle::despawn_boss_barnacles();
    
    foreach ( tessie in level.scarab_br.tessies )
    {
        if ( utility::issharedfuncdefined( #"veh_pluto", #"hash_ee3a6dc51896d3d8" ) )
        {
            tessie utility::callsharedfunc( #"veh_pluto", #"hash_ee3a6dc51896d3d8" );
        }
        
        level pluto_veh::set_vehicle_usable_state( tessie, 0 );
    }
    
    wait 1;
    
    foreach ( tessie in level.scarab_br.tessies )
    {
        playsoundatpos( tessie.origin, #"hash_2d98570ff81153e6" );
        wait 0.5;
        playfx( level._effect[ "firefly_vehicle_teleport_out" ], tessie.origin );
        tessie.tedd delete();
        tessie delete();
    }
    
    wait 5;
    utility::flag_set( "derby_complete" );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x56c75d82, Offset: 0x643f
// Size: 0x120
function private function_d28a0c86c187a0a0()
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    
    foreach ( player in level.players )
    {
        player thread revive_player();
    }
    
    spawn_powerups();
    set_stations_active( 1 );
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 1 );
    setomnvarforallclients( "ui_zm_echo_portal_time", gettime() + 61000 );
    wait 51;
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_80c3d02db6e7d47c" );
    wait 10;
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 0 );
    level thread overlord::playconversation( #"neptune_intro" );
    toy_spawn( "sat_zm_neptune_1_tiny", utility::getfx( "spawn_smoke" ), 4 );
    set_stations_active( 0 );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xd147a20, Offset: 0x6567
// Size: 0x281
function private start_neptune()
{
    if ( isalive( level.scarab_br.bosses[ "neptune" ] ) )
    {
        return;
    }
    
    neptune = agent_manager::spawn_agent( "sat_spawner_zombie_neptune_zm", level.scarab_br.boss_spawn.origin, level.scarab_br.boss_spawn.angles, zm_utility::get_zombie_team() );
    level.scarab_br.bosses[ "neptune" ] = neptune;
    neptune.n_fight_phase = 3;
    neptune function_48ac8bc5919df917();
    neptune zombie_neptune::function_2f461442ab5ed82a( 3 );
    level.var_9c0d12c8f8edeb3d = "sat_cin_zm_vig_player_dth_neptune";
    level.s_game_over_scene_override = utility::getstruct( "neptune_game_over_scene" );
    neptune.maxhealth /= 3;
    var_6833040cba056ca6 = neptune.maxhealth;
    neptune.var_474e63113b850e5d = 1;
    neptune.health = int( var_6833040cba056ca6 );
    neptune.var_e0207904c8bca4eb = undefined;
    
    if ( getdvarint( @"hash_c736754792ee5c0f", 0 ) )
    {
        neptune thread start_damage_circle( level.scarab_br.boss_spawn.origin + ( 0, 0, -80 ), 1500, 0.5 );
    }
    
    neptune thread function_8546b5aec00e8cc();
    neptune callback::add( "on_zombie_ai_killed", &on_neptune_killed );
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_neptune_healthbar_3", neptune );
        player zombie_boss_healthbar::healthbar_set_health( var_6833040cba056ca6, var_6833040cba056ca6 );
    }
    
    thread function_88050c8bb750a496();
    thread function_d61a90397b033244( level.scarab_br.settings.var_8393376376645d8d, level.scarab_br.bosses[ "neptune" ] );
    neptune zombie_utils::function_dfae6a5bd222c586( &function_3ed3221152f54b0a );
    neptune zombie_neptune_asm::function_1ec96503c85b8721();
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xbc0d05f5, Offset: 0x67f0
// Size: 0x7a
function private function_48ac8bc5919df917()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self setmodel( settings.var_8dd4e61c890f6cf6 );
    utility::function_32b24db3127bff40( "eye", "on_" + self.n_fight_phase );
    utility::function_32b24db3127bff40( "movement", "on_" + self.n_fight_phase );
    zombie_neptune_metabones::reset_metabones();
    self setnavlayer( "zombie_large_wide" );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x9650163c, Offset: 0x6872
// Size: 0x4bd
function private function_88050c8bb750a496()
{
    level endon( #"game_ended" );
    level endon( #"hash_514ad791dbbba24f" );
    level.scarab_br.grav_volume = function_bddc4b01d91e703e( level.scarab_br.boss_spawn.origin + ( 0, 0, -400 ), 3000, 2000 );
    level.scarab_br.grav_volume function_76a9233685c24f79( 1 );
    level.scarab_br.fog setscriptablepartstate( "vfx", "neptune_fade_in" );
    wait 20;
    level overlord::playconversation( #"hash_5de3204bcfafb92f" );
    thread zm_utility::function_1d82e63812f9640a( level.scarab_br.boss_spawn.origin, 3000 );
    
    foreach ( player in level.players )
    {
        player thread white_screen_flash();
        player playlocalsound( #"hash_6361fb4c486389e8" );
    }
    
    wait 0.3;
    level.scarab_br.grav_volume function_9e6dce8f55a09ff0( 1, 0.037 );
    
    foreach ( player in level.players )
    {
        player knockback( ( 0, 0, 1 ), 170, 1 );
    }
    
    wait 10;
    level thread overlord::playconversation( hashcat( #"hash_ad6f4cb27e3886bc", randomintrange( 1, 5 ) ) );
    
    while ( isalive( level.scarab_br.bosses[ "neptune" ] ) )
    {
        level.scarab_br.grav_volume function_9e6dce8f55a09ff0( 1, 1 );
        
        foreach ( player in level.players )
        {
            player thread white_screen_flash();
            player playlocalsound( #"hash_42eca09f010c0fc2" );
        }
        
        wait 0.3;
        thread zm_utility::function_1d82e63812f9640a( level.scarab_br.boss_spawn.origin, 3000 );
        wait 0.3;
        level.scarab_br.grav_volume function_9e6dce8f55a09ff0( 1, 0.25 );
        wait 45 + randomintrange( -5, 5 );
        
        if ( level.scarab_br.bosses[ "neptune" ].health < level.scarab_br.bosses[ "neptune" ].maxhealth * 0.7 )
        {
            function_3d160f0e095e6d04();
        }
        
        level thread overlord::playconversation( hashcat( #"hash_2171cf047fa6c8e6", randomintrange( 1, 5 ) ) );
        level.scarab_br.grav_volume function_9e6dce8f55a09ff0( 1, 1 );
        thread zm_utility::function_1d82e63812f9640a( level.scarab_br.boss_spawn.origin, 3000 );
        
        foreach ( player in level.players )
        {
            player thread white_screen_flash();
            player playlocalsound( #"hash_6361fb4c486389e8" );
        }
        
        wait 0.3;
        level.scarab_br.grav_volume function_9e6dce8f55a09ff0( 1, 0.037 );
        wait 10;
        level thread overlord::playconversation( hashcat( #"hash_ad6f4cb27e3886bc", randomintrange( 1, 5 ) ) );
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x70c66863, Offset: 0x6d37
// Size: 0x1e5
function private function_3d160f0e095e6d04()
{
    powerup_index = randomint( 3 );
    
    switch ( powerup_index )
    {
        case 0:
            powerup_type = "full_armor";
            break;
        case 1:
            powerup_type = "full_power";
            break;
        default:
            powerup_type = "full_ammo";
            break;
    }
    
    if ( !level.scarab_br.var_df348f04cae0b452 )
    {
        function_787a7f08c8e2c465();
        level overlord::playconversation( #"neptune_powerup" );
        level.scarab_br.var_16dbce6fb9d2bd1f = powerups::powerup_drop( "full_armor", level.scarab_br.boss_spawn.origin + ( 0, 0, 80 ), -1 );
        level.scarab_br.var_df348f04cae0b452 = 1;
        level.scarab_br.var_16dbce6fb9d2bd1f zm_quest::player_distance_and_look_at_looping_check( 250, 1, 0.25 );
        waitframe();
        
        if ( isdefined( level.scarab_br.var_16dbce6fb9d2bd1f ) )
        {
            level thread overlord::playconversation( #"hash_1d4d820215911817" );
            level.scarab_br.var_16dbce6fb9d2bd1f moveto( level.scarab_br.boss_spawn.origin + ( 0, 0, 1000 ), 2 );
        }
        
        wait 2;
        return;
    }
    
    if ( !isdefined( level.scarab_br.var_16dbce6fb9d2bd1f ) )
    {
        powerups::powerup_drop( powerup_type, utility::getrandompointincircle( level.scarab_br.boss_spawn.origin, 1800 ) + ( 0, 0, 1100 ) );
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x94dbd3d3, Offset: 0x6f24
// Size: 0x5b
function private function_8546b5aec00e8cc()
{
    level endon( #"game_ended" );
    self waittill( #"death_transition", var_43ff4e66eade0a81 );
    waitframe();
    self function_786bb6aa1b76c7ee( "immune", 0 );
    utility::ent_flag_set( "kill_neptune" );
    self dodamage( self.health + 1, self.origin );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xcf390594, Offset: 0x6f87
// Size: 0x1b9
function private on_neptune_killed( params )
{
    level.scarab_br.bosses[ "neptune" ] callback::remove( "on_zombie_ai_killed", &on_neptune_killed );
    function_b9322c9b70c37b0c();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    
    if ( isdefined( level.scarab_br.var_16dbce6fb9d2bd1f ) )
    {
        level.scarab_br.var_16dbce6fb9d2bd1f notify( #"cancel_player_distance_and_look_at_looping_check" );
        level.scarab_br.var_16dbce6fb9d2bd1f powerups::powerup_delete();
    }
    
    level notify( #"hash_514ad791dbbba24f" );
    level.scarab_br.grav_volume function_9e6dce8f55a09ff0( 1, 0.25 );
    wait 7.5;
    
    foreach ( player in level.players )
    {
        player thread white_screen_flash( 0.2, 0.4, 0 );
    }
    
    level.scarab_br.grav_volume function_76a9233685c24f79( 0 );
    level.scarab_br.fog setscriptablepartstate( "vfx", "neptune_fade_out" );
    wait 1.3;
    level overlord::playconversation( #"neptune_kill" );
    utility::flag_set( "neptune_killed" );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x374dce9f, Offset: 0x7148
// Size: 0x1c7
function private function_382e2512b36f219b()
{
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"br_transition" );
    
    foreach ( player in level.players )
    {
        player thread revive_player();
    }
    
    spawn_powerups();
    set_stations_active( 1 );
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 1 );
    setomnvarforallclients( "ui_zm_echo_portal_time", gettime() + 61000 );
    wait 61;
    setomnvarforallclients( "ui_zm_echo_portal_timer_vis", 0 );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_80c3d12db6e7d62f" );
    
    foreach ( player in level.players )
    {
        player val::set( "weyward_warp", "killstreaks", 0 );
        player notify( #"cancel_all_killstreak_deployments" );
        player notify( #"equip_deploy_cancel" );
    }
    
    toy_spawn( "sat_zm_npc_obsidian_tiny", utility::getfx( "black_hole" ), 4, 0 );
    level thread overlord::playconversation( #"weyward_intro" );
    function_e0fb713d80fae962( level.scarab_br.boss_spawn );
    wait 3;
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x2dfa1191, Offset: 0x7317
// Size: 0xca
function private function_e0fb713d80fae962( portal_energy )
{
    level endon( #"game_ended" );
    zm_quest::function_d7216beb89a22329();
    utility::callsharedfunc( #"mutant_injection", #"force_exit_mutant_injection", 1 );
    zm_fasttravel::function_8649f9a98d2d9ce3();
    
    foreach ( player in level.players )
    {
        if ( player && isalive( player ) )
        {
            player childthread function_3a7076f5c015e04b( portal_energy );
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x438f92d4, Offset: 0x73e9
// Size: 0x165
function private function_3a7076f5c015e04b( portal_energy )
{
    self endon( #"death_or_disconnect" );
    
    if ( utility::ent_flag( "field_upgrade_in_use" ) )
    {
        field_upgrades_aether_shroud::function_63c791098b816b7();
    }
    
    utility::ent_flag_set( "interrupt_dark_flare" );
    val::group_set( "SCARAB_BR_PORTAL", 0 );
    self canceloffhands();
    self releaseoffhand();
    self stopanimscriptsceneevent();
    self stopgestureviewmodel();
    
    if ( self isviewmodelanimplaying() )
    {
        self stopviewmodelanim();
    }
    
    waitframe();
    utility::ent_flag_set( "SCARAB_BR_PORTAL" );
    self.var_a0a7c59ebb4a786 = utility::spawn_tag_origin( self.origin, self getplayerangles() );
    childthread inventory_utility::givegunlessweapon();
    
    while ( inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        waitframe();
    }
    
    actor = anim_scene::anim_scene_create_actor( self, "player", 1, 0 );
    actor.angles = self.angles;
    create_player_rig( actor );
    childthread function_bb989d2829a59d38( actor );
    self playrumblelooponentity( "low_highfreq" );
    childthread path_to_portal( portal_energy, 3 );
    utility::ent_flag_waitopen_any( "SCARAB_BR_PORTAL" );
    val::group_reset( "SCARAB_BR_PORTAL" );
    thread inventory_utility::takegunlessweapon();
    self stoprumble( "low_highfreq" );
    utility::ent_flag_clear( "interrupt_dark_flare" );
    waitframe();
    self unlink( 1 );
    
    if ( self.var_a0a7c59ebb4a786 )
    {
        self.var_a0a7c59ebb4a786 delete();
        self.var_a0a7c59ebb4a786 = undefined;
    }
}

// Namespace zm_sat_scarab_br
// Params 2, eflags: 0x4
// Checksum 0xb83bc0c5, Offset: 0x7556
// Size: 0x233
function private path_to_portal( portal_energy, pull_time )
{
    level endon( #"game_ended" );
    self endon( #"teleporting" );
    
    if ( !isvector( portal_energy.origin ) )
    {
        return;
    }
    
    var_bd05d7d9e27b5654 = gettime();
    t = 0;
    start_pos = self.origin;
    pull_loc = portal_energy.origin;
    var_932d61b99cf3af2e = pull_time * 0.55;
    
    do
    {
        if ( !self.var_a0a7c59ebb4a786 )
        {
            break;
        }
        
        var_a7a07fd68c40069f = utility::function_6f5d2e1f1ff70482( gettime() - var_bd05d7d9e27b5654 );
        
        if ( t <= var_932d61b99cf3af2e )
        {
            t = var_a7a07fd68c40069f / pull_time;
            op1 = pow( 1 - t, 2 );
            op2 = 2 * ( 1 - t ) * t;
            op3 = pow( t, 2 );
            var_2fb471fdf223d6f2 = vectornormalize( pull_loc - start_pos );
            halfway_pos = ( start_pos + pull_loc ) / 2;
            control_point = halfway_pos - var_2fb471fdf223d6f2 * 100;
            xdest = op1 * start_pos[ 0 ] + op2 * control_point[ 0 ] + op3 * pull_loc[ 0 ];
            ydest = op1 * start_pos[ 1 ] + op2 * control_point[ 1 ] + op3 * pull_loc[ 1 ];
            zdest = op1 * start_pos[ 2 ] + op2 * control_point[ 2 ] + op3 * pull_loc[ 2 ];
            var_3ae8592280b43fb6 = ( xdest, ydest, zdest );
            self.var_a0a7c59ebb4a786 moveto( var_3ae8592280b43fb6, t + 0.01 );
            self.var_a0a7c59ebb4a786 rotateto( vectortoangles( vectornormalize( pull_loc - self.var_a0a7c59ebb4a786.origin ) ), pull_time );
        }
        
        waitframe();
    }
    while ( self.var_a0a7c59ebb4a786 && var_a7a07fd68c40069f < var_932d61b99cf3af2e );
    
    var_349629e35e235ebc = pull_time - var_932d61b99cf3af2e;
    
    if ( isdefined( self.var_a0a7c59ebb4a786 ) )
    {
        self.var_a0a7c59ebb4a786 moveto( pull_loc, var_349629e35e235ebc );
    }
    
    wait var_349629e35e235ebc;
}

#using_animtree( "zm_sat_scarab_scriptables" );

// Namespace zm_sat_scarab_br
// Params 1
// Checksum 0x570ed99e, Offset: 0x7791
// Size: 0x1e0
function create_player_rig( actorplayer )
{
    if ( !utility::ent_flag_exist( "animating" ) )
    {
        utility::ent_flag_init( "animating" );
    }
    
    utility::ent_flag_set( "animating" );
    dir = vectornormalize( anglestoforward( self.angles ) );
    arm_spawn_loc = dir * -5 + self.origin;
    actorplayer.player_rig = spawn( "script_arms", arm_spawn_loc + ( 0, 0, -5 ), 0, 0, self );
    actorplayer.player_rig.animname = actorplayer.animname;
    actorplayer.player_rig useanimtree( #animtree );
    actorplayer.player_rig.entity = self;
    actorplayer.player_rig.updatedversion = 1;
    player_ang = self getplayerangles();
    self setplayerangles( ( 0, player_ang[ 1 ], player_ang[ 2 ] ) );
    actorplayer.player_rig.angles = self getplayerangles();
    self.var_a0a7c59ebb4a786.angles = self getplayerangles();
    self setstance( isdefined( actorplayer.entity.anim_scene_stance_override ) ? actorplayer.entity.anim_scene_stance_override : "stand" );
    self playerlinktodelta( actorplayer.player_rig, "tag_player", 1, 35, 35, 20, 20, 1, 1 );
    actorplayer.player_rig linkto( self.var_a0a7c59ebb4a786 );
    actorplayer.player_rig hide();
    actorplayer.player_rig showonlytoplayer( self );
}

// Namespace zm_sat_scarab_br
// Params 1
// Checksum 0x6263b188, Offset: 0x7979
// Size: 0x91
function function_bb989d2829a59d38( actorplayer )
{
    self endon( #"death_or_disconnect" );
    self.var_a0a7c59ebb4a786 thread anim_scene::anim_scene_loop( [ actorplayer ], "player_sucked_in", 0, 0, undefined, 0.2 );
    utility::ent_flag_waitopen_any( "SCARAB_BR_PORTAL" );
    self.var_a0a7c59ebb4a786 anim_scene::anim_scene_stop();
    self stopanimscriptsceneevent();
    utility::ent_flag_clear( "animating" );
    val::reset_all( "anim_scene" );
    actorplayer.player_rig delete();
    actorplayer.player_rig = undefined;
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x3faeabd1, Offset: 0x7a12
// Size: 0xeb
function private init_path_to_portal_anims()
{
    level.scr_animtree[ "player" ] = #animtree;
    level.scr_anim[ "player" ][ "player_sucked_in" ][ 0 ] = %sat_mp_strafe_fast_jump_air_8;
    level.scr_eventanim[ "player" ][ "player_sucked_in" ][ 0 ] = %"sat_mp_strafe_fast_jump_air_8";
    level val::group_register( "SCARAB_BR_PORTAL", [ "usability", "weapon_switch", "supers", "gesture", "offhand_weapons", "offhand_primary_weapons", "offhand_secondary_weapons", "allow_movement", "allow_jump", "crouch", "prone", "damage", "fire", "show_hud", "melee" ] );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xd11409d4, Offset: 0x7b05
// Size: 0x21e
function private start_weyward()
{
    zone_manager::set_zone_enabled( "zone_boss_arena", 1 );
    level callback::remove( #"player_spawned", &on_player_spawned_br );
    
    if ( isalive( level.scarab_br.bosses[ "weyward" ] ) )
    {
        return;
    }
    
    var_296736e7b84fb018 = utility::getstructarray( "weyward_warp_pos" );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        var_296736e7b84fb018[ i ].target = "weyward_warp_pos";
        level thread zm_fasttravel::function_cbb08198e7c84adf( var_296736e7b84fb018[ i ], level.players[ i ] );
        level.players[ i ] thread utility::ent_flag_clear_delayed( "SCARAB_BR_PORTAL", 0.5 );
        level.players[ i ] val::set( "weyward_warp", "killstreaks", 1 );
    }
    
    wait 4.5;
    killfxontag( utility::getfx( "black_hole" ), level.scarab_br.vfx_spawn, "tag_origin" );
    level.scarab_br.vfx_spawn stoploopsound();
    utility::flag_clear( "scarab_boss_intro_done" );
    zm_quest::function_d04a18ed4295a8cd();
    level thread zm_sat_scarab_boss_fight::start_boss_fight( 1, 1 );
    utility::flag_wait( "scarab_boss_callbacks_added" );
    level.scarab_br.bosses[ "weyward" ] = level.s_scarab_boss.entity;
    level.scarab_br.bosses[ "weyward" ] callback::add( "on_zombie_ai_killed", &on_weyward_killed );
    level.scarab_br.bosses[ "weyward" ] thread function_3ff25bd7822d5c2e();
    level.scarab_br.bosses[ "weyward" ] function_786bb6aa1b76c7ee( "is_in_br", 1 );
    level.scarab_br.bosses[ "weyward" ] callback::add( "weyward_real_death_start", &function_83572cfafd70a37a );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x15b04ab6, Offset: 0x7d2b
// Size: 0x1ed3
function private function_bba281ef7db07f20( params )
{
    var_bbb7a6d50d6904d1 = getdvarfloat( @"hash_b01cb49fe8995bd", 1 );
    var_28ed9c2f9f6aeb71 = getdvarfloat( @"hash_72124b712c2afb07", 0.2 );
    var_52eec01ca61dbf15 = getdvarint( @"hash_53bbc8372af1add3", 6000 );
    var_3f2e80330371bcc1 = getdvarint( @"hash_65471026cfbd484a", 7500 );
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_f947e9e81633b5e2", 2 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_e8bb3782659e8989", 0.09 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_fc1928e535f98d2a", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_a8dfa12d1e1f7461", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_2a4013c08877cc27", 1 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_7a757b0315c1635b", 0.5 );
    var_ed407dcb475395c = getdvarfloat( @"hash_cf177b4a67adf7ba", 0.4 );
    var_e6b3918506ea5e30 = getdvarfloat( @"hash_41153fa28e69174", 0.6 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_bc38f8dec38e638", 1 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_64187a3adf56d82f", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_2a15d5efd35e8638", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_ac2c9782d7bcb654", 1 );
    var_31ff27f24504c5c6 = getdvarfloat( @"hash_6c3fd49255c86723", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_e9f0f2570bbfd913", 1 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_590c5bcf73db4083", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_ed2d30f2b81f5707", 1 );
    var_4f79672e8ec957ce = getdvarfloat( @"hash_f8f0ff4f1cb3b4cf", 1 );
    var_cef89d00885df997 = getdvarfloat( @"hash_3f421b468980c3ad", 1 );
    var_d48cf9ae0101f824 = getdvarfloat( @"hash_c974ee55897ff576", 1 );
    var_d38e60852f9d06ed = getdvarfloat( @"hash_b8181c36d0175e85", 13 );
    var_2735afaab8d7322e = getdvarfloat( @"hash_8b05a722e1e6b45c", 1 );
    var_30e23d6f68aeab2f = getdvarfloat( @"hash_f8ac92d67d5de3ab", 1 );
    var_cbe1b29ad713515f = getdvarfloat( @"hash_e4652f38826deffb", 1 );
    var_11ffd83c4978f00a = getdvarfloat( @"hash_c7df3d4e77b1e3a4", 1 );
    var_27290881d032efef = getdvarfloat( @"hash_6c5f655a7c6c6b39", 1 );
    var_20ad41a7190f3038 = getdvarfloat( @"hash_f3aaca7f4ed21ab2", 1 );
    var_44534fdcf7bf3e3e = getdvarfloat( @"hash_d80550b95f7ff24", 1 );
    var_908e47d7962b0ec7 = getdvarfloat( @"hash_6444d87cc1ddd79b", 1 );
    var_87adbecba0c9b50b = getdvarfloat( @"hash_d549ca620c8e9bb3", 1 );
    var_e53b66a0bc564ac7 = getdvarfloat( @"hash_3a6dcb47124768d7", 1 );
    var_1ee624ee6ce0fe17 = getdvarfloat( @"hash_953508bf1635b3b", 1 );
    var_9a63c8107d8fe6bc = getdvarfloat( @"hash_a6640d85b1255e0e", 1 );
    var_f68435a7c71028a9 = getdvarfloat( @"hash_a1a9875f9488de21", 1 );
    var_db0d136f8ce8451e = getdvarfloat( @"hash_5fc9bb1136022584", 1 );
    var_fa6ae129f40e640d = getdvarfloat( @"hash_4d45ad00a2afb523", 0.75 );
    var_3a0dd038443396ba = getdvarfloat( @"hash_8f76029547af8626", 0.75 );
    var_83d37edf201b2cfd = getdvarfloat( @"hash_9acb0f7ee665cf5d", 1 );
    var_95511d95a93958e7 = getdvarfloat( @"hash_f004fc78d2554e7b", 1 );
    var_e5ee15bc1309375a = getdvarfloat( @"hash_f6b4ed173f42359e", 1 );
    var_77b8b7d739653ade = getdvarfloat( @"hash_532659e405f3f862", 0.6 );
    var_66b304267f9502e = getdvarfloat( @"hash_696a731f4a0a4aea", 0.75 );
    var_741aaacb780e3fcb = getdvarfloat( @"hash_89ebebf15fe727d", 0.65 );
    var_d425946c0ecce92b = getdvarfloat( @"hash_1c0f3c65c4e0f853", 1 );
    var_7de7ff1e14998598 = getdvarfloat( @"hash_a4e8aa281e8802ae", 1 );
    var_e8ac91a5ef2b0fd1 = getdvarfloat( @"hash_d00c21bc693e7dc9", 1 );
    var_f835858b1b1cbcca = getdvarfloat( @"hash_ea75797ac6991a3c", 0.8 );
    var_ca16f864fec9a903 = getdvarfloat( @"hash_6bb2f290d886056b", 1 );
    var_18e2266ff0e121f5 = getdvarfloat( @"hash_bb8229a170c1b40f", 1 );
    var_64021406c1e284a4 = getdvarfloat( @"hash_c34a0c05a077e57a", 1 );
    var_dcb0e656c9c82522 = getdvarfloat( @"hash_12f5504fe49a1698", 1 );
    var_822e9de3dfba30c0 = getdvarfloat( @"hash_fcd2ef2d2e37a278", 1 );
    var_d60770d185f48ebf = getdvarfloat( @"hash_3ecd6a7b8135632d", 1 );
    var_5ad4058fe42539a = getdvarfloat( @"hash_c9e3a22638fd1c86", 1 );
    var_41d6ed60e93466cc = getdvarfloat( @"hash_354e1da0e27ef884", 1 );
    var_4902ecca444e0a0a = getdvarfloat( @"hash_365af667cff486ce", 1 );
    var_954e3c92eeaffe8a = getdvarfloat( @"hash_1785a96219a0d3e8", 1 );
    var_1db18fb14b819f46 = getdvarfloat( @"hash_b1547df6ba884c1a", 1 );
    var_bbeff31a90e06ee5 = getdvarfloat( @"hash_bf11d776497067ef", 1 );
    var_a3ca9f131d6300f9 = getdvarfloat( @"hash_6370b86d94f485ad", 1 );
    var_8519d2664696609c = getdvarfloat( @"hash_88706086ec4859d6", 1 );
    var_b3b83a5ab245b7ec = getdvarfloat( @"hash_b8e0ceabf479d37a", 1 );
    var_171f46ae7095831b = getdvarfloat( @"hash_7510e979c61f557b", 1 );
    var_f5cdb22b4777022d = getdvarfloat( @"hash_f18cf1bdf683cb31", 1 );
    var_4b7fa7312581b7d3 = getdvarfloat( @"hash_bcbfc82a6401049f", 0.7 );
    var_16ae1125a6a7d307 = getdvarfloat( @"hash_5e9c9d097a85986d", 0.6 );
    var_bcf3b1b24a202f81 = getdvarfloat( @"hash_e1c824c66817ff75", 0.55 );
    var_9a4640a410338ccc = getdvarfloat( @"hash_c633bf86f59c45fa", 1 );
    var_db3bf1b6cee753a3 = getdvarfloat( @"hash_db060fb28d726b2f", 0.8 );
    var_40dcccd28b9da5b3 = getdvarfloat( @"hash_8b531308c78f4231", 0.25 );
    var_77ef519a48ec9faf = getdvarfloat( @"hash_a45abd60592586a7", 1 );
    var_5224d35948c59281 = getdvarfloat( @"hash_9d2217d2eca22901", 1 );
    var_f53f8a2bd0180b20 = getdvarfloat( @"hash_61193e42d62adaa", 0.8 );
    var_c33aa7ef17cfe845 = getdvarfloat( @"hash_2ee14d47f4fe1945", 0.8 );
    var_4c06ef375c13ea1e = getdvarfloat( @"hash_8e83ce37c82e6e00", 1 );
    var_b32d5c9566b620f9 = getdvarfloat( @"hash_b547fc415dffc371", 1 );
    var_a78294aeffce90c4 = getdvarfloat( @"hash_c68ea964e3e54610", 1 );
    var_59faf3eff2f9ce2c = getdvarfloat( @"hash_9d4c7a8c3f74578e", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_e306589d25dcba76", 1 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_184beb347dcdf4e7", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_7bdf885ca30c72cf", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_36b59da5c94a1787", 0.6 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_56c0628bde43d7f", 0.125 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_d8b8adc8c6967cb0", 0.1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_dece6adc287d9887", 0.4 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_cd29fdb5255f9af3", 0.8 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_80f82b27a5c0fdd0", 0.7 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_cbac31adfd3689fc", 0.32 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_f7a2ad12b0e7852c", 0.25 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_d12467cde2e10e70", 0.2 );
    var_7156e77b2b8e5cd4 = getdvarfloat( @"hash_bc612cc65e4e8f0e", 0.4 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_20ad83538a8d6c7b", 1 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_e0c40870109c0460", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_5c68d98455e7186b", 1 );
    var_54d187cadce293b3 = getdvarfloat( @"hash_b41d1f68fd8b7409", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_3617a00d0bd7aa8f", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_d22b5cf27e13b0", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_e3816bde1cb27fd2", 1 );
    damage = params.idamage;
    params.var_d3006097a8584457 = 1;
    
    if ( params.shitloc == "head" )
    {
        damage *= var_28ed9c2f9f6aeb71;
    }
    
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    var_2428aee138922248 = arraycontains( [ "sniper" ], params.sweapon.classname );
    
    if ( weakspotdata )
    {
        damage *= var_bbb7a6d50d6904d1;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= 4 )
        {
            damage *= var_66f4771e76a64f91;
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"GetPlayerWeaponRarity" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( rarity == 5 && !is_wonder )
        {
            damage *= var_c5e0225cba147a92;
        }
    }
    
    if ( is_wonder )
    {
        damage *= var_d572e4d281047f87;
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
            
            if ( weakspotdata )
            {
                damage *= var_ed407dcb475395c;
            }
        }
        
        is_firefly_ww = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "sat_ww_firefly" );
        
        if ( is_firefly_ww )
        {
            damage *= var_e6b3918506ea5e30;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
        var_97497870082defe6 = issubstr( params.sweapon.basename, "lm_hades" );
        
        if ( var_97497870082defe6 )
        {
            damage *= var_e8ac91a5ef2b0fd1;
        }
        
        var_a95df4abd89a0a73 = issubstr( params.sweapon.basename, "lm_typhon" );
        
        if ( var_a95df4abd89a0a73 )
        {
            damage *= var_f835858b1b1cbcca;
        }
        
        var_928626a121064218 = issubstr( params.sweapon.basename, "lm_zeus" );
        
        if ( var_928626a121064218 )
        {
            damage *= var_18e2266ff0e121f5;
        }
        
        var_a9a126b53752ab54 = issubstr( params.sweapon.basename, "lm_hildr" );
        
        if ( var_a9a126b53752ab54 )
        {
            damage *= var_ca16f864fec9a903;
        }
    }
    else if ( arraycontains( [ "pistol" ], params.sweapon.classname ) )
    {
        damage *= 1;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
        isakita = issubstr( params.sweapon.basename, "akita" );
        isvulture = issubstr( params.sweapon.basename, "vulture" );
        iscorso = issubstr( params.sweapon.basename, "sh_corso" );
        isshepherd = issubstr( params.sweapon.basename, "sh_shepherd" );
        isterrier = issubstr( params.sweapon.basename, "sh_terrier" );
        
        if ( isvulture )
        {
            damage *= var_5224d35948c59281;
        }
        else if ( isakita )
        {
            damage *= var_20ad41a7190f3038;
        }
        else if ( iscorso )
        {
            damage *= var_44534fdcf7bf3e3e;
        }
        else if ( isshepherd )
        {
            damage *= var_908e47d7962b0ec7;
        }
        else if ( isterrier )
        {
            damage *= var_c33aa7ef17cfe845;
        }
        
        var_60aa7bde8e31bcd0 = issubstr( params.sweapon.attachments, "akimbo_pi" );
        
        if ( var_60aa7bde8e31bcd0 )
        {
            damage *= var_4f79672e8ec957ce;
        }
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) && !is_wonder )
    {
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
        else
        {
            damage *= var_5ed48d2a95f6cd41;
        }
        
        var_b564b55a357ad0a = issubstr( params.sweapon.basename, "ar_albatross" );
        
        if ( var_b564b55a357ad0a )
        {
            damage *= var_83d37edf201b2cfd;
        }
        
        var_e21b89a1a48eda24 = issubstr( params.sweapon.basename, "ar_egret" );
        
        if ( var_e21b89a1a48eda24 )
        {
            damage *= var_95511d95a93958e7;
        }
        
        var_9b71ed22ad8b7a11 = issubstr( params.sweapon.basename, "ar_finch" );
        
        if ( var_9b71ed22ad8b7a11 )
        {
            damage *= var_e5ee15bc1309375a;
        }
        
        var_2a51c3aa6c24cbdd = issubstr( params.sweapon.basename, "ar_heron" );
        
        if ( var_2a51c3aa6c24cbdd )
        {
            damage *= var_66b304267f9502e;
            
            if ( weakspotdata )
            {
                damage *= var_741aaacb780e3fcb;
            }
        }
        
        var_d2f5e7854e17e59c = issubstr( params.sweapon.basename, "ar_macaw" );
        
        if ( var_d2f5e7854e17e59c )
        {
            damage *= var_d425946c0ecce92b;
        }
        
        var_c6591c705a2d6871 = issubstr( params.sweapon.basename, "ar_kiwi" );
        
        if ( var_c6591c705a2d6871 )
        {
            damage *= var_7de7ff1e14998598;
        }
        
        var_bcac5e82fe0848e = issubstr( params.sweapon.basename, "ar_emu" );
        
        if ( var_bcac5e82fe0848e )
        {
            damage *= var_b32d5c9566b620f9;
        }
        
        var_22804e07a2a1c56c = issubstr( params.sweapon.basename, "dm_kara" );
        
        if ( var_22804e07a2a1c56c )
        {
            damage *= var_fa6ae129f40e640d;
            
            if ( weakspotdata )
            {
                damage *= var_3a0dd038443396ba;
            }
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
        var_8a43871038dc6168 = issubstr( params.sweapon.basename, "sn_drake" );
        var_69693f78dd52645d = issubstr( params.sweapon.basename, "sn_aden" );
        var_53b88c53bcb5a948 = issubstr( params.sweapon.basename, "sn_caspian" );
        var_f8ce92563efe07d0 = issubstr( params.sweapon.basename, "sn_coral" );
        
        if ( var_8a43871038dc6168 )
        {
            damage *= var_4b7fa7312581b7d3;
        }
        else if ( var_69693f78dd52645d )
        {
            damage *= var_9a4640a410338ccc;
        }
        else if ( var_53b88c53bcb5a948 )
        {
            damage *= var_db3bf1b6cee753a3;
        }
        else if ( var_f8ce92563efe07d0 )
        {
            damage *= var_77ef519a48ec9faf;
        }
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
        
        var_8ac364248fe9da03 = issubstr( params.sweapon.basename, "sm_orca" );
        var_2c4d0ef07c7b125f = issubstr( params.sweapon.basename, "sm_cobra" );
        var_6be2efa37f2d3915 = issubstr( params.sweapon.basename, "sm_hyena" );
        var_4ed004c75b6bb987 = issubstr( params.sweapon.basename, "sm_stoat" );
        var_6f864e32448705a1 = issubstr( params.sweapon.basename, "sm_komodo" );
        var_a460b22a1a51592f = issubstr( params.sweapon.basename, "sm_mammoth" );
        var_99614ccf137caca2 = issubstr( params.sweapon.basename, "sm_marmot" );
        var_781e96facb01fe60 = issubstr( params.sweapon.basename, "sm_otter" );
        var_892ec3c5e970e683 = issubstr( params.sweapon.basename, "sm_puma" );
        var_39f282945ecff933 = issubstr( params.sweapon.basename, "sm_serval" );
        var_958786a6a63535e0 = issubstr( params.sweapon.basename, "sm_zebraexotic" );
        var_22b6f1891552563e = issubstr( params.sweapon.basename, "sm_zebra" ) && !var_958786a6a63535e0;
        var_ea535479834326a5 = issubstr( params.sweapon.basename, "sm_civet" );
        var_bef4a086c89f2d8d = issubstr( params.sweapon.basename, "sm_bengal" );
        var_85cc380f1fded69d = issubstr( params.sweapon.basename, "sm_gecko" );
        var_28bdf7213142e18c = issubstr( params.sweapon.basename, "sm_bear" );
        
        if ( var_8ac364248fe9da03 )
        {
            damage *= var_64021406c1e284a4;
        }
        else if ( var_2c4d0ef07c7b125f )
        {
            damage *= var_5ad4058fe42539a;
        }
        else if ( var_6be2efa37f2d3915 )
        {
            damage *= var_41d6ed60e93466cc;
        }
        else if ( var_4ed004c75b6bb987 )
        {
            damage *= var_4902ecca444e0a0a;
        }
        else if ( var_6f864e32448705a1 )
        {
            damage *= var_954e3c92eeaffe8a;
        }
        else if ( var_a460b22a1a51592f )
        {
            damage *= var_1db18fb14b819f46;
        }
        else if ( var_99614ccf137caca2 )
        {
            damage *= var_bbeff31a90e06ee5;
        }
        else if ( var_781e96facb01fe60 )
        {
            damage *= var_a3ca9f131d6300f9;
        }
        else if ( var_892ec3c5e970e683 )
        {
            damage *= var_8519d2664696609c;
        }
        else if ( var_39f282945ecff933 )
        {
            damage *= var_b3b83a5ab245b7ec;
        }
        else if ( var_958786a6a63535e0 )
        {
            damage *= var_f5cdb22b4777022d;
        }
        else if ( var_22b6f1891552563e )
        {
            damage *= var_171f46ae7095831b;
        }
        else if ( var_ea535479834326a5 )
        {
            damage *= var_a78294aeffce90c4;
        }
        else if ( var_bef4a086c89f2d8d )
        {
            damage *= var_dcb0e656c9c82522;
        }
        else if ( var_85cc380f1fded69d )
        {
            damage *= var_822e9de3dfba30c0;
        }
        else if ( var_28bdf7213142e18c )
        {
            damage *= var_d60770d185f48ebf;
        }
    }
    else if ( arraycontains( [ "dm" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_31ff27f24504c5c6;
        istasman = issubstr( params.sweapon.basename, "tasman" );
        
        if ( istasman )
        {
            damage *= var_f53f8a2bd0180b20;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        iscrossbow = issubstr( params.sweapon.basename, "sl_crossbow" );
        var_ba45de6833daade9 = issubstr( params.sweapon.basename, "ks_compound" );
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( iscrossbow )
        {
            damage *= var_d48cf9ae0101f824;
            
            if ( weakspotdata )
            {
                damage *= var_d38e60852f9d06ed;
            }
        }
        else if ( var_ba45de6833daade9 )
        {
            damage *= var_2735afaab8d7322e;
            
            if ( weakspotdata )
            {
                damage *= var_30e23d6f68aeab2f;
            }
        }
        else if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
        else if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        else if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        else
        {
            damage *= var_4a0cd941a5b615d1;
        }
        
        ispolis = issubstr( params.sweapon.basename, "polis" );
        
        if ( ispolis )
        {
            damage *= var_cef89d00885df997;
        }
        
        isfang = issubstr( params.sweapon.basename, "la_fang" );
        
        if ( isfang )
        {
            damage *= var_4c06ef375c13ea1e;
        }
        
        isatria = issubstr( params.sweapon.basename, "sl_atria" );
        
        if ( isatria )
        {
            damage *= var_cbe1b29ad713515f;
        }
        
        iscarina = issubstr( params.sweapon.basename, "sl_carina" );
        
        if ( iscarina )
        {
            damage *= var_59faf3eff2f9ce2c;
        }
        
        issargas = issubstr( params.sweapon.basename, "sl_sargas" );
        
        if ( issargas )
        {
            damage *= var_27290881d032efef;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        var_d9e7bcfde8e48be5 = issubstr( params.sweapon.basename, "ground_drone_unit" );
        
        if ( var_d9e7bcfde8e48be5 )
        {
            damage *= var_7156e77b2b8e5cd4;
        }
        else
        {
            damage *= var_2067935b2ea13ba;
        }
        
        isnembus = issubstr( params.sweapon.basename, "sl_nembus" );
        
        if ( isnembus )
        {
            damage *= var_11ffd83c4978f00a;
        }
        
        if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
        {
            damage *= var_3b1f952caa88011e;
        }
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
        
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= getdvarfloat( @"hash_a1cf6dbe0fdca896", 1 );
        }
    }
    else if ( arraycontains( [ "throwingknife" ], params.sweapon.classname ) )
    {
        damage *= 0.1;
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_3ebada185eff20f5", 1 );
    }
    
    if ( arraycontains( params.sweapon.attachments, "sat_ammo_50cal_ar_hawk" ) && weakspotdata )
    {
        damage *= var_77b8b7d739653ade;
    }
    
    if ( arraycontains( params.sweapon.attachments, "sat_underbarrel_shotgun_sn_caspian" ) )
    {
        damage *= var_40dcccd28b9da5b3;
    }
    
    if ( issubstr( params.sweapon.basename, "oman" ) )
    {
        damage *= var_87adbecba0c9b50b;
    }
    
    if ( issubstr( params.sweapon.basename, "sn_baltic" ) )
    {
        damage *= var_16ae1125a6a7d307;
        
        if ( arraycontains( params.sweapon.attachments, "sat_ub_crossbar_sn_baltic" ) )
        {
            damage *= var_bcf3b1b24a202f81;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_atlas" ) )
    {
        damage *= var_e53b66a0bc564ac7;
    }
    
    if ( issubstr( params.sweapon.basename, "pi_alcor" ) )
    {
        damage *= var_1ee624ee6ce0fe17;
        
        if ( weakspotdata )
        {
            damage *= var_9a63c8107d8fe6bc;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_orion" ) )
    {
        damage *= var_f68435a7c71028a9;
        
        if ( weakspotdata )
        {
            damage *= var_db0d136f8ce8451e;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    
    if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    
    if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "frost_blast" ) )
    {
        damage *= var_54d187cadce293b3;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= var_b614da05a3be6674;
    }
    
    if ( weakspotdata && params.biscritical )
    {
        damage = min( damage, var_3f2e80330371bcc1 );
    }
    
    if ( !weakspotdata && !armordata && !var_2428aee138922248 && !is_wonder )
    {
        damage = min( damage, var_52eec01ca61dbf15 );
    }
    
    return int( damage );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x2af94c41, Offset: 0x9c07
// Size: 0x1f7c
function private function_398ddf52ff57ea23( params )
{
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    var_bbb7a6d50d6904d1 = getdvarfloat( @"hash_1ab5310a539fcea8", 1 );
    var_28ed9c2f9f6aeb71 = getdvarfloat( @"hash_2e6b735218c39c12", 0.2 );
    var_52eec01ca61dbf15 = getdvarint( @"hash_6f8b4871bc824e98", 6000 );
    var_3f2e80330371bcc1 = getdvarint( @"hash_895cee9ff490055d", 7500 );
    var_66f4771e76a64f91 = 0.6;
    var_c5e0225cba147a92 = 0.8;
    var_d572e4d281047f87 = getdvarfloat( @"hash_91b4e1cf870a034f", 2 );
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_ec69c4b450fd744", 0.09 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_f0e088ddc667978b", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_d28a405e2e4ad52e", 1 );
    var_a49aaaef48e2de2b = getdvarfloat( @"hash_55663d428213efde", 1 );
    var_f0edd71928ca1b53 = getdvarfloat( @"hash_de0a743350c79bee", 0.5 );
    var_ed407dcb475395c = getdvarfloat( @"hash_baccbde4c018f2fd", 0.4 );
    var_e6b3918506ea5e30 = getdvarfloat( @"hash_3a45c4f26d9d3831", 0.6 );
    var_aab51b6f81857f99 = getdvarfloat( @"hash_24a037eab1116df0", 1.5 );
    var_4a0cd941a5b615d1 = getdvarfloat( @"hash_d2cbfe1effb88bd9", 1 );
    var_23861e4bdfd87d52 = getdvarfloat( @"hash_8f498fa9bb73f016", 1 );
    var_5ed48d2a95f6cd41 = getdvarfloat( @"hash_42b986a24518c733", 1 );
    var_a3793f5fff89354d = getdvarfloat( @"hash_b295df5863557b31", 1 );
    var_31ff27f24504c5c6 = getdvarfloat( @"hash_b47421d8c940c4da", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_b081b6c9798ff636", 1 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_9cff6f3b7ff76710", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_d7087b298e6a7fa", 1 );
    var_4f79672e8ec957ce = getdvarfloat( @"hash_9ef7ffbead04d8d8", 1 );
    var_cef89d00885df997 = getdvarfloat( @"hash_37e00999983d3e52", 1 );
    var_d48cf9ae0101f824 = getdvarfloat( @"hash_9e16de243654871d", 1 );
    var_2735afaab8d7322e = getdvarfloat( @"hash_1d5c6e278d5c5203", 1 );
    var_30e23d6f68aeab2f = getdvarfloat( @"hash_c8b5d4daf718a942", 1 );
    var_cbe1b29ad713515f = getdvarfloat( @"hash_6b868917d898bf5a", 1 );
    var_11ffd83c4978f00a = getdvarfloat( @"hash_799eceef44465987", 1 );
    var_27290881d032efef = getdvarfloat( @"hash_3da914434c413f62", 1 );
    var_20ad41a7190f3038 = getdvarfloat( @"hash_3e8b7cfd7d58f671", 1 );
    var_44534fdcf7bf3e3e = getdvarfloat( @"hash_4e99d5ca9d097f1b", 1 );
    var_908e47d7962b0ec7 = getdvarfloat( @"hash_aba52f1f4cb6f602", 1 );
    var_87adbecba0c9b50b = getdvarfloat( @"hash_62c2116a0d46e026", 1 );
    var_e53b66a0bc564ac7 = getdvarfloat( @"hash_61fb69459cf6a632", 1 );
    var_1ee624ee6ce0fe17 = getdvarfloat( @"hash_c4b3706943221742", 1 );
    var_9a63c8107d8fe6bc = getdvarfloat( @"hash_f91e63bae010d8a5", 1 );
    var_f68435a7c71028a9 = getdvarfloat( @"hash_63d5d56aac4b8428", 1 );
    var_db0d136f8ce8451e = getdvarfloat( @"hash_90f8dfc284fabe5b", 1 );
    var_fa6ae129f40e640d = getdvarfloat( @"hash_acb4ceb7bd8cc37c", 0.75 );
    var_3a0dd038443396ba = getdvarfloat( @"hash_15e8b9383529ba07", 0.75 );
    var_83d37edf201b2cfd = getdvarfloat( @"hash_7bdba9bf34bc423c", 1 );
    var_95511d95a93958e7 = getdvarfloat( @"hash_970c2eeb1455a292", 1 );
    var_e5ee15bc1309375a = getdvarfloat( @"hash_aa07746b753bb7", 1 );
    var_77b8b7d739653ade = getdvarfloat( @"hash_4af3de52ee9f0b6b", 0.6 );
    var_66b304267f9502e = getdvarfloat( @"hash_b422fbf02fb63f03", 0.75 );
    var_741aaacb780e3fcb = getdvarfloat( @"hash_4d9a0d2bbde80d46", 0.65 );
    var_d425946c0ecce92b = getdvarfloat( @"hash_baf8495dedca6166", 1 );
    var_7de7ff1e14998598 = getdvarfloat( @"hash_34cefd9dc7ce7e69", 1 );
    var_e8ac91a5ef2b0fd1 = getdvarfloat( @"hash_6a2994a6361329a8", 1 );
    var_f835858b1b1cbcca = getdvarfloat( @"hash_a5d85ae6e405dc17", 0.8 );
    var_ca16f864fec9a903 = getdvarfloat( @"hash_b59a9c94a2fe1a3e", 1 );
    var_18e2266ff0e121f5 = getdvarfloat( @"hash_5e65af570b058a44", 1 );
    var_64021406c1e284a4 = getdvarfloat( @"hash_5cc57c8658b237dd", 1 );
    var_dcb0e656c9c82522 = getdvarfloat( @"hash_83bfd42da9241e1f", 1 );
    var_822e9de3dfba30c0 = getdvarfloat( @"hash_b4e2c18342a806b1", 1 );
    var_d60770d185f48ebf = getdvarfloat( @"hash_6fc9a6502c57f5e2", 1 );
    var_5ad4058fe42539a = getdvarfloat( @"hash_d18d4eeb287581c7", 1 );
    var_41d6ed60e93466cc = getdvarfloat( @"hash_32983dd2669ba455", 1 );
    var_4902ecca444e0a0a = getdvarfloat( @"hash_aef56c13a4b65f27", 1 );
    var_954e3c92eeaffe8a = getdvarfloat( @"hash_a9e19c15046d76ef", 1 );
    var_1db18fb14b819f46 = getdvarfloat( @"hash_40aab45df8ec3853", 1 );
    var_bbeff31a90e06ee5 = getdvarfloat( @"hash_704098c7b1367b4c", 1 );
    var_a3ca9f131d6300f9 = getdvarfloat( @"hash_23791e9a6f5d0ae8", 1 );
    var_8519d2664696609c = getdvarfloat( @"hash_4c48389a5f77ddcd", 1 );
    var_b3b83a5ab245b7ec = getdvarfloat( @"hash_1d2d63d74a85af35", 1 );
    var_171f46ae7095831b = getdvarfloat( @"hash_47361e7efdd6f1a6", 1 );
    var_f5cdb22b4777022d = getdvarfloat( @"hash_f78701f61ee5e00c", 1 );
    var_4b7fa7312581b7d3 = getdvarfloat( @"hash_933928a40d8cd396", 0.7 );
    var_16ae1125a6a7d307 = getdvarfloat( @"hash_60d4a941ab0f4e32", 0.6 );
    var_bcf3b1b24a202f81 = getdvarfloat( @"hash_76bebbc8f98b0f30", 0.55 );
    var_9a4640a410338ccc = getdvarfloat( @"hash_9e1027efd1365965", 1 );
    var_db3bf1b6cee753a3 = getdvarfloat( @"hash_8cc0e6da8dd5d2be", 0.8 );
    var_40dcccd28b9da5b3 = getdvarfloat( @"hash_c00c8eb8d832debe", 0.25 );
    var_77ef519a48ec9faf = getdvarfloat( @"hash_3861108ff66f8292", 1 );
    var_5224d35948c59281 = getdvarfloat( @"hash_7e0214a5adc9dc18", 1 );
    var_f53f8a2bd0180b20 = getdvarfloat( @"hash_e23c7039b29e3371", 0.8 );
    var_c33aa7ef17cfe845 = getdvarfloat( @"hash_cfed6aac55a9904", 0.8 );
    var_4c06ef375c13ea1e = getdvarfloat( @"hash_83513fb79a558733", 1 );
    var_b32d5c9566b620f9 = getdvarfloat( @"hash_76ca71baf64a7d08", 1 );
    var_a78294aeffce90c4 = getdvarfloat( @"hash_c37c900faf874215", 1 );
    var_59faf3eff2f9ce2c = getdvarfloat( @"hash_f398bfbb8ebf5955", 1 );
    var_b614da05a3be6674 = getdvarfloat( @"hash_dfd5d83745c5788d", 1 );
    var_34c2c73f8deec447 = getdvarfloat( @"hash_a9615c749144fde2", 1 );
    var_3eb6b6a42968b839 = getdvarfloat( @"hash_61206ecef798b130", 1 );
    var_807588323e023bd7 = getdvarfloat( @"hash_bfcbc3c41d5bc9ba", 0.6 );
    var_522a1d4abc62ce0f = getdvarfloat( @"hash_aca7ba221ab79c12", 0.125 );
    var_eea9c218978c30f4 = getdvarfloat( @"hash_4343328d5af6cadd", 0.1 );
    var_b82b77be4fcfee13 = getdvarfloat( @"hash_e181451faf427e76", 0.4 );
    var_9e7bf7adf451bc2d = getdvarfloat( @"hash_69a5e54e4f49e074", 0.8 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_36f1dce731c124a1", 0.7 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_176a4b88ba3c513f", 0.32 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_1f83966c66c99a4f", 0.25 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_b51a9293a8ce2e97", 0.2 );
    var_7156e77b2b8e5cd4 = getdvarfloat( @"hash_40374038241c7d8d", 0.4 );
    var_a431e097af9691a3 = getdvarfloat( @"hash_25d743414471c1be", 1 );
    var_c17444b1160dee5e = getdvarfloat( @"hash_3e1c9aca20fd076b", 1 );
    var_ca89c2ac79d513bd = getdvarfloat( @"hash_16521cadbf31812c", 1 );
    var_54d187cadce293b3 = getdvarfloat( @"hash_902eddee801b6dde", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_208f6591c5057222", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_dac13dae406e738f", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_8fd9bd6cbe73d0bb", 1 );
    damage = params.idamage;
    params.var_d3006097a8584457 = 1;
    
    if ( params.shitloc == "head" )
    {
        damage *= var_28ed9c2f9f6aeb71;
    }
    
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    var_2428aee138922248 = arraycontains( [ "sniper" ], params.sweapon.classname );
    
    if ( weakspotdata )
    {
        damage *= var_bbb7a6d50d6904d1;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= var_cee395575559ddb9 )
        {
            damage *= var_fa73e4e06a81b041;
        }
        
        if ( paplevel >= 4 )
        {
            damage *= var_66f4771e76a64f91;
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"GetPlayerWeaponRarity" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( rarity == 5 && !is_wonder )
        {
            damage *= var_c5e0225cba147a92;
        }
    }
    
    if ( is_wonder )
    {
        damage *= var_d572e4d281047f87;
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_base_raygun = issubstr( params.sweapon.basename, "raygun" ) && !issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( is_base_raygun )
        {
            damage *= var_a49aaaef48e2de2b;
        }
        
        var_6afa0b0478dd143c = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "raygunmark2" );
        
        if ( var_6afa0b0478dd143c )
        {
            damage *= var_f0edd71928ca1b53;
            
            if ( weakspotdata )
            {
                damage *= var_ed407dcb475395c;
            }
        }
        
        is_firefly_ww = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "sat_ww_firefly" );
        
        if ( is_firefly_ww )
        {
            damage *= var_e6b3918506ea5e30;
            
            if ( weakspotdata )
            {
                damage *= var_aab51b6f81857f99;
            }
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        damage *= var_a3793f5fff89354d;
        var_97497870082defe6 = issubstr( params.sweapon.basename, "lm_hades" );
        
        if ( var_97497870082defe6 )
        {
            damage *= var_e8ac91a5ef2b0fd1;
        }
        
        var_a95df4abd89a0a73 = issubstr( params.sweapon.basename, "lm_typhon" );
        
        if ( var_a95df4abd89a0a73 )
        {
            damage *= var_f835858b1b1cbcca;
        }
        
        var_928626a121064218 = issubstr( params.sweapon.basename, "lm_zeus" );
        
        if ( var_928626a121064218 )
        {
            damage *= var_18e2266ff0e121f5;
        }
        
        var_a9a126b53752ab54 = issubstr( params.sweapon.basename, "lm_hildr" );
        
        if ( var_a9a126b53752ab54 )
        {
            damage *= var_ca16f864fec9a903;
        }
    }
    else if ( arraycontains( [ "pistol" ], params.sweapon.classname ) )
    {
        damage *= 1;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= var_23861e4bdfd87d52;
        isakita = issubstr( params.sweapon.basename, "akita" );
        isvulture = issubstr( params.sweapon.basename, "vulture" );
        iscorso = issubstr( params.sweapon.basename, "sh_corso" );
        isshepherd = issubstr( params.sweapon.basename, "sh_shepherd" );
        isterrier = issubstr( params.sweapon.basename, "sh_terrier" );
        
        if ( isvulture )
        {
            damage *= var_5224d35948c59281;
        }
        else if ( isakita )
        {
            damage *= var_20ad41a7190f3038;
        }
        else if ( iscorso )
        {
            damage *= var_44534fdcf7bf3e3e;
        }
        else if ( isshepherd )
        {
            damage *= var_908e47d7962b0ec7;
        }
        else if ( isterrier )
        {
            damage *= var_c33aa7ef17cfe845;
        }
        
        var_60aa7bde8e31bcd0 = issubstr( params.sweapon.attachments, "akimbo_pi" );
        
        if ( var_60aa7bde8e31bcd0 )
        {
            damage *= var_4f79672e8ec957ce;
        }
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) && !is_wonder )
    {
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
        else
        {
            damage *= var_5ed48d2a95f6cd41;
        }
        
        var_b564b55a357ad0a = issubstr( params.sweapon.basename, "ar_albatross" );
        
        if ( var_b564b55a357ad0a )
        {
            damage *= var_83d37edf201b2cfd;
        }
        
        var_e21b89a1a48eda24 = issubstr( params.sweapon.basename, "ar_egret" );
        
        if ( var_e21b89a1a48eda24 )
        {
            damage *= var_95511d95a93958e7;
        }
        
        var_9b71ed22ad8b7a11 = issubstr( params.sweapon.basename, "ar_finch" );
        
        if ( var_9b71ed22ad8b7a11 )
        {
            damage *= var_e5ee15bc1309375a;
        }
        
        var_2a51c3aa6c24cbdd = issubstr( params.sweapon.basename, "ar_heron" );
        
        if ( var_2a51c3aa6c24cbdd )
        {
            damage *= var_66b304267f9502e;
            
            if ( weakspotdata )
            {
                damage *= var_741aaacb780e3fcb;
            }
        }
        
        var_d2f5e7854e17e59c = issubstr( params.sweapon.basename, "ar_macaw" );
        
        if ( var_d2f5e7854e17e59c )
        {
            damage *= var_d425946c0ecce92b;
        }
        
        var_c6591c705a2d6871 = issubstr( params.sweapon.basename, "ar_kiwi" );
        
        if ( var_c6591c705a2d6871 )
        {
            damage *= var_7de7ff1e14998598;
        }
        
        var_bcac5e82fe0848e = issubstr( params.sweapon.basename, "ar_emu" );
        
        if ( var_bcac5e82fe0848e )
        {
            damage *= var_b32d5c9566b620f9;
        }
        
        var_22804e07a2a1c56c = issubstr( params.sweapon.basename, "dm_kara" );
        
        if ( var_22804e07a2a1c56c )
        {
            damage *= var_fa6ae129f40e640d;
            
            if ( weakspotdata )
            {
                damage *= var_3a0dd038443396ba;
            }
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
        var_8a43871038dc6168 = issubstr( params.sweapon.basename, "sn_drake" );
        var_69693f78dd52645d = issubstr( params.sweapon.basename, "sn_aden" );
        var_53b88c53bcb5a948 = issubstr( params.sweapon.basename, "sn_caspian" );
        var_f8ce92563efe07d0 = issubstr( params.sweapon.basename, "sn_coral" );
        
        if ( var_8a43871038dc6168 )
        {
            damage *= var_4b7fa7312581b7d3;
        }
        else if ( var_69693f78dd52645d )
        {
            damage *= var_9a4640a410338ccc;
        }
        else if ( var_53b88c53bcb5a948 )
        {
            damage *= var_db3bf1b6cee753a3;
        }
        else if ( var_f8ce92563efe07d0 )
        {
            damage *= var_77ef519a48ec9faf;
        }
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
        
        var_8ac364248fe9da03 = issubstr( params.sweapon.basename, "sm_orca" );
        var_2c4d0ef07c7b125f = issubstr( params.sweapon.basename, "sm_cobra" );
        var_6be2efa37f2d3915 = issubstr( params.sweapon.basename, "sm_hyena" );
        var_4ed004c75b6bb987 = issubstr( params.sweapon.basename, "sm_stoat" );
        var_6f864e32448705a1 = issubstr( params.sweapon.basename, "sm_komodo" );
        var_a460b22a1a51592f = issubstr( params.sweapon.basename, "sm_mammoth" );
        var_99614ccf137caca2 = issubstr( params.sweapon.basename, "sm_marmot" );
        var_781e96facb01fe60 = issubstr( params.sweapon.basename, "sm_otter" );
        var_892ec3c5e970e683 = issubstr( params.sweapon.basename, "sm_puma" );
        var_39f282945ecff933 = issubstr( params.sweapon.basename, "sm_serval" );
        var_958786a6a63535e0 = issubstr( params.sweapon.basename, "sm_zebraexotic" );
        var_22b6f1891552563e = issubstr( params.sweapon.basename, "sm_zebra" ) && !var_958786a6a63535e0;
        var_ea535479834326a5 = issubstr( params.sweapon.basename, "sm_civet" );
        var_bef4a086c89f2d8d = issubstr( params.sweapon.basename, "sm_bengal" );
        var_85cc380f1fded69d = issubstr( params.sweapon.basename, "sm_gecko" );
        var_28bdf7213142e18c = issubstr( params.sweapon.basename, "sm_bear" );
        
        if ( var_8ac364248fe9da03 )
        {
            damage *= var_64021406c1e284a4;
        }
        else if ( var_2c4d0ef07c7b125f )
        {
            damage *= var_5ad4058fe42539a;
        }
        else if ( var_6be2efa37f2d3915 )
        {
            damage *= var_41d6ed60e93466cc;
        }
        else if ( var_4ed004c75b6bb987 )
        {
            damage *= var_4902ecca444e0a0a;
        }
        else if ( var_6f864e32448705a1 )
        {
            damage *= var_954e3c92eeaffe8a;
        }
        else if ( var_a460b22a1a51592f )
        {
            damage *= var_1db18fb14b819f46;
        }
        else if ( var_99614ccf137caca2 )
        {
            damage *= var_bbeff31a90e06ee5;
        }
        else if ( var_781e96facb01fe60 )
        {
            damage *= var_a3ca9f131d6300f9;
        }
        else if ( var_892ec3c5e970e683 )
        {
            damage *= var_8519d2664696609c;
        }
        else if ( var_39f282945ecff933 )
        {
            damage *= var_b3b83a5ab245b7ec;
        }
        else if ( var_958786a6a63535e0 )
        {
            damage *= var_f5cdb22b4777022d;
        }
        else if ( var_22b6f1891552563e )
        {
            damage *= var_171f46ae7095831b;
        }
        else if ( var_ea535479834326a5 )
        {
            damage *= var_a78294aeffce90c4;
        }
        else if ( var_bef4a086c89f2d8d )
        {
            damage *= var_dcb0e656c9c82522;
        }
        else if ( var_85cc380f1fded69d )
        {
            damage *= var_822e9de3dfba30c0;
        }
        else if ( var_28bdf7213142e18c )
        {
            damage *= var_d60770d185f48ebf;
        }
    }
    else if ( arraycontains( [ "dm" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_31ff27f24504c5c6;
        istasman = issubstr( params.sweapon.basename, "tasman" );
        
        if ( istasman )
        {
            damage *= var_f53f8a2bd0180b20;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        iscrossbow = issubstr( params.sweapon.basename, "sl_crossbow" );
        var_ba45de6833daade9 = issubstr( params.sweapon.basename, "ks_compound" );
        var_7fdedb034882a3ec = issubstr( params.sweapon.basename, "zm_dinj" );
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( iscrossbow )
        {
            damage *= var_d48cf9ae0101f824;
        }
        else if ( var_ba45de6833daade9 )
        {
            damage *= var_2735afaab8d7322e;
            
            if ( weakspotdata )
            {
                damage *= var_30e23d6f68aeab2f;
            }
        }
        else if ( var_7fdedb034882a3ec )
        {
            damage *= var_9e7bf7adf451bc2d;
        }
        else if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        else if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        else
        {
            damage *= var_4a0cd941a5b615d1;
        }
        
        ispolis = issubstr( params.sweapon.basename, "polis" );
        
        if ( ispolis )
        {
            damage *= var_cef89d00885df997;
        }
        
        isfang = issubstr( params.sweapon.basename, "la_fang" );
        
        if ( isfang )
        {
            damage *= var_4c06ef375c13ea1e;
        }
        
        isatria = issubstr( params.sweapon.basename, "sl_atria" );
        
        if ( isatria )
        {
            damage *= var_cbe1b29ad713515f;
        }
        
        iscarina = issubstr( params.sweapon.basename, "sl_carina" );
        
        if ( iscarina )
        {
            damage *= var_59faf3eff2f9ce2c;
        }
        
        issargas = issubstr( params.sweapon.basename, "sl_sargas" );
        
        if ( issargas )
        {
            damage *= var_27290881d032efef;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        var_d9e7bcfde8e48be5 = issubstr( params.sweapon.basename, "ground_drone_unit" );
        
        if ( var_d9e7bcfde8e48be5 )
        {
            damage *= var_7156e77b2b8e5cd4;
        }
        else
        {
            damage *= var_2067935b2ea13ba;
        }
        
        isnembus = issubstr( params.sweapon.basename, "sl_nembus" );
        
        if ( isnembus )
        {
            damage *= var_11ffd83c4978f00a;
        }
        
        if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
        {
            damage *= var_3b1f952caa88011e;
        }
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= var_b82b77be4fcfee13;
        
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= getdvarfloat( @"hash_dae0079006669d3f", 1 );
        }
    }
    else if ( arraycontains( [ "throwingknife" ], params.sweapon.classname ) )
    {
        damage *= 0.1;
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_4fe2648cf3326332", 1 );
    }
    
    if ( arraycontains( params.sweapon.attachments, "sat_ammo_50cal_ar_hawk" ) && weakspotdata )
    {
        damage *= var_77b8b7d739653ade;
    }
    
    if ( arraycontains( params.sweapon.attachments, "sat_underbarrel_shotgun_sn_caspian" ) )
    {
        damage *= var_40dcccd28b9da5b3;
    }
    
    if ( issubstr( params.sweapon.basename, "oman" ) )
    {
        damage *= var_87adbecba0c9b50b;
    }
    
    if ( issubstr( params.sweapon.basename, "sn_baltic" ) )
    {
        damage *= var_16ae1125a6a7d307;
        
        if ( arraycontains( params.sweapon.attachments, "sat_ub_crossbar_sn_baltic" ) )
        {
            damage *= var_bcf3b1b24a202f81;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_atlas" ) )
    {
        damage *= var_e53b66a0bc564ac7;
    }
    
    if ( issubstr( params.sweapon.basename, "pi_alcor" ) )
    {
        damage *= var_1ee624ee6ce0fe17;
        
        if ( weakspotdata )
        {
            damage *= var_9a63c8107d8fe6bc;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_orion" ) )
    {
        damage *= var_f68435a7c71028a9;
        
        if ( weakspotdata )
        {
            damage *= var_db0d136f8ce8451e;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= var_807588323e023bd7;
    }
    
    if ( issubstr( params.sweapon.basename, "deathmachine" ) )
    {
        damage *= var_522a1d4abc62ce0f;
    }
    
    if ( issubstr( params.sweapon.basename, "handcannon" ) )
    {
        damage *= var_eea9c218978c30f4;
    }
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= var_34c2c73f8deec447;
    }
    
    if ( issubstr( params.sweapon.basename, "remote_turret" ) )
    {
        damage *= var_3eb6b6a42968b839;
    }
    
    if ( issubstr( params.sweapon.basename, "dark_flare" ) )
    {
        damage *= var_a431e097af9691a3;
    }
    
    if ( issubstr( params.sweapon.basename, "energy_mine" ) )
    {
        damage *= var_c17444b1160dee5e;
    }
    
    if ( issubstr( params.sweapon.basename, "tesla_storm" ) )
    {
        damage *= var_ca89c2ac79d513bd;
    }
    
    if ( issubstr( params.sweapon.basename, "frost_blast" ) )
    {
        damage *= var_54d187cadce293b3;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= var_b614da05a3be6674;
    }
    
    if ( weakspotdata && params.biscritical )
    {
        damage = min( damage, var_3f2e80330371bcc1 );
    }
    
    if ( !weakspotdata && !armordata && !var_2428aee138922248 && !is_wonder )
    {
        damage = min( damage, var_52eec01ca61dbf15 );
    }
    
    if ( damage >= self.health )
    {
        if ( zombie_leap_attack::is_in_leap_attack() )
        {
            self.health = int( self.maxhealth * 0.005 );
        }
        else
        {
            val::reset_all( "zombie_triton_br" );
            self kill( self.origin, params.eattacker, params.einflictor, params.smeansofdeath, params.objweapon );
        }
    }
    
    return int( damage );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x8ab95d64, Offset: 0xbb8c
// Size: 0x18d4
function private function_3ed3221152f54b0a( params )
{
    var_bbb7a6d50d6904d1 = getdvarfloat( @"hash_d678f415ce745807", 1 );
    var_28ed9c2f9f6aeb71 = getdvarfloat( @"hash_f0e52493b7530ff1", 0.25 );
    var_52eec01ca61dbf15 = getdvarint( @"hash_936e45f69aa55311", 6000 );
    var_3f2e80330371bcc1 = getdvarint( @"hash_635f3cd834cd3fb4", 7500 );
    var_66f4771e76a64f91 = 0.6;
    var_91cfcc98a64c39a2 = getdvarfloat( @"hash_f0dc5239cde524b", 0.09 );
    var_b631402aa8a16af1 = getdvarfloat( @"hash_c01c32d595480574", 1 );
    var_f8365038e8bfe78a = getdvarfloat( @"hash_33f500266e8848c3", 1 );
    var_e6b3918506ea5e30 = getdvarfloat( @"hash_37aa6082214d5c16", 0.6 );
    var_31ff27f24504c5c6 = getdvarfloat( @"hash_e8e6f9566e5251a5", 1 );
    var_aae5e4d2b6570d56 = getdvarfloat( @"hash_464c9a4dd674d5d1", 1 );
    var_3f56cee67435a21e = getdvarfloat( @"hash_8aef143f14a14079", 1 );
    var_1b8b28636737013e = getdvarfloat( @"hash_ae359ffa426963b9", 1 );
    var_4f79672e8ec957ce = getdvarfloat( @"hash_8a93cd09d459534d", 1 );
    var_d48cf9ae0101f824 = getdvarfloat( @"hash_7fef81d8b5bc0ef4", 1 );
    var_2735afaab8d7322e = getdvarfloat( @"hash_a9da4879ca161d6e", 1 );
    var_30e23d6f68aeab2f = getdvarfloat( @"hash_cea47206a27c4f7d", 1 );
    var_cbe1b29ad713515f = getdvarfloat( @"hash_93f2efbde5dbd161", 1 );
    var_11ffd83c4978f00a = getdvarfloat( @"hash_f3a3748492da13b6", 1 );
    var_27290881d032efef = getdvarfloat( @"hash_d60898dfd9a73c4f", 1 );
    var_44534fdcf7bf3e3e = getdvarfloat( @"hash_a143c92acfe83cd6", 1 );
    var_908e47d7962b0ec7 = getdvarfloat( @"hash_a794410d1f1782d5", 1 );
    var_e53b66a0bc564ac7 = getdvarfloat( @"hash_ec670bc497a73341", 1 );
    var_1ee624ee6ce0fe17 = getdvarfloat( @"hash_e2b16313728cf45", 1 );
    var_9a63c8107d8fe6bc = getdvarfloat( @"hash_ab0e78179665d120", 1 );
    var_f68435a7c71028a9 = getdvarfloat( @"hash_68aff0cd190e883f", 1 );
    var_db0d136f8ce8451e = getdvarfloat( @"hash_e5dc5b3021297dfa", 1 );
    var_fa6ae129f40e640d = getdvarfloat( @"hash_6313b557baa90e35", 0.75 );
    var_3a0dd038443396ba = getdvarfloat( @"hash_297d477d289889c0", 0.75 );
    var_83d37edf201b2cfd = getdvarfloat( @"hash_a0a116824193631b", 1 );
    var_95511d95a93958e7 = getdvarfloat( @"hash_622feb871db9e095", 1 );
    var_e5ee15bc1309375a = getdvarfloat( @"hash_47ddb1d9a5eeb6ec", 1 );
    var_77b8b7d739653ade = getdvarfloat( @"hash_6a0c46864f0da8", 0.6 );
    var_66b304267f9502e = getdvarfloat( @"hash_abe10cd71bf64b80", 0.75 );
    var_741aaacb780e3fcb = getdvarfloat( @"hash_ef2b1621dba286a3", 0.65 );
    var_d425946c0ecce92b = getdvarfloat( @"hash_603af0ea30b03955", 1 );
    var_7de7ff1e14998598 = getdvarfloat( @"hash_644b7dee7070abf4", 1 );
    var_e8ac91a5ef2b0fd1 = getdvarfloat( @"hash_ca9ccbb62fa016b3", 1 );
    var_f835858b1b1cbcca = getdvarfloat( @"hash_63335c8683948366", 0.8 );
    var_ca16f864fec9a903 = getdvarfloat( @"hash_37adb8d3e1b96725", 1 );
    var_18e2266ff0e121f5 = getdvarfloat( @"hash_ba5f2aef25c3949", 1 );
    var_64021406c1e284a4 = getdvarfloat( @"hash_e0ab27a543dec35c", 1 );
    var_dcb0e656c9c82522 = getdvarfloat( @"hash_b82c639f395ec28a", 1 );
    var_822e9de3dfba30c0 = getdvarfloat( @"hash_7d8edc104060376a", 1 );
    var_d60770d185f48ebf = getdvarfloat( @"hash_2ee3bd199cafe013", 1 );
    var_5ad4058fe42539a = getdvarfloat( @"hash_57a3608001107288", 1 );
    var_41d6ed60e93466cc = getdvarfloat( @"hash_a08fefda21d5e0a2", 1 );
    var_4902ecca444e0a0a = getdvarfloat( @"hash_ff1090d5059e2f80", 1 );
    var_954e3c92eeaffe8a = getdvarfloat( @"hash_198cba720fa17b6e", 1 );
    var_1db18fb14b819f46 = getdvarfloat( @"hash_85e7a206b1f9c2b8", 1 );
    var_bbeff31a90e06ee5 = getdvarfloat( @"hash_91740631f6032595", 1 );
    var_a3ca9f131d6300f9 = getdvarfloat( @"hash_e0e0d017d15ffeb7", 1 );
    var_8519d2664696609c = getdvarfloat( @"hash_f820994432eb081c", 1 );
    var_b3b83a5ab245b7ec = getdvarfloat( @"hash_5c4bfd725a35170c", 1 );
    var_171f46ae7095831b = getdvarfloat( @"hash_3a7c0679ffe88751", 1 );
    var_f5cdb22b4777022d = getdvarfloat( @"hash_f848c6a45ef64e7", 1 );
    var_4b7fa7312581b7d3 = getdvarfloat( @"hash_b20aa58eede04855", 0.7 );
    var_16ae1125a6a7d307 = getdvarfloat( @"hash_567e34d98a97bc7f", 0.6 );
    var_bcf3b1b24a202f81 = getdvarfloat( @"hash_15261d9ecdd39ebb", 0.55 );
    var_9a4640a410338ccc = getdvarfloat( @"hash_5aba7a7158a3ff80", 1 );
    var_db3bf1b6cee753a3 = getdvarfloat( @"hash_505fccc8f652cc49", 0.8 );
    var_40dcccd28b9da5b3 = getdvarfloat( @"hash_2c26c90258370073", 0.25 );
    var_77ef519a48ec9faf = getdvarfloat( @"hash_d46d59d25621d6a1", 1 );
    var_5224d35948c59281 = getdvarfloat( @"hash_a8a9772cb139d9eb", 1 );
    var_f53f8a2bd0180b20 = getdvarfloat( @"hash_480efff407d5d5dc", 0.8 );
    var_c33aa7ef17cfe845 = getdvarfloat( @"hash_e468ae9ed047b063", 0.8 );
    var_4c06ef375c13ea1e = getdvarfloat( @"hash_53acbd5117631566", 1 );
    var_b32d5c9566b620f9 = getdvarfloat( @"hash_61a26f4bbaddfad3", 1 );
    var_a78294aeffce90c4 = getdvarfloat( @"hash_63e7a3bcaf2a13f2", 1 );
    var_59faf3eff2f9ce2c = getdvarfloat( @"hash_d04318ffbdc5c9b8", 1 );
    var_2557bd56e76450f8 = getdvarfloat( @"hash_157e09739927fc9e", 1 );
    var_68e86b21c8631912 = getdvarfloat( @"hash_d1dfdf564fb9b466", 1 );
    var_29e58edec3b15252 = getdvarfloat( @"hash_6c4bbc72431dc2de", 1 );
    var_566f0c1cb686681a = getdvarfloat( @"hash_ae95d2bb89fcefca", 1 );
    var_7156e77b2b8e5cd4 = getdvarfloat( @"hash_b774e280e348a73c", 1 );
    var_54d187cadce293b3 = getdvarfloat( @"hash_457dca395aa6200b", 1 );
    var_83e7914eb22dcac7 = getdvarfloat( @"hash_776f13fe98d48be1", 1 );
    var_2067935b2ea13ba = getdvarfloat( @"hash_38552617dc8ef652", 1 );
    var_3b1f952caa88011e = getdvarfloat( @"hash_558da599e99e91d4", 1 );
    damage = params.idamage;
    params.var_d3006097a8584457 = 1;
    
    if ( params.shitloc == "head" )
    {
        damage *= var_28ed9c2f9f6aeb71;
    }
    
    armordata = metabone::get_metabone_metadata( params.metabonename, "Types_Armor" );
    weakspotdata = metabone::get_metabone_metadata( params.metabonename, "Types_Weakspot" );
    is_wonder = weapon::iswonderweapon( params.sweapon );
    var_2428aee138922248 = arraycontains( [ "sniper" ], params.sweapon.classname );
    
    if ( weakspotdata )
    {
        damage *= var_bbb7a6d50d6904d1;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= 4 )
        {
            damage *= var_66f4771e76a64f91;
        }
    }
    
    if ( is_wonder )
    {
        is_scarab_ww = issubstr( params.sweapon.basename, "sat_ww_scarab" );
        
        if ( is_scarab_ww )
        {
            damage *= var_91cfcc98a64c39a2;
            
            if ( armordata )
            {
                damage *= var_b631402aa8a16af1;
            }
            else if ( weakspotdata )
            {
                damage *= var_f8365038e8bfe78a;
            }
        }
        
        is_firefly_ww = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "sat_ww_firefly" );
        
        if ( is_firefly_ww )
        {
            damage *= var_e6b3918506ea5e30;
        }
    }
    
    if ( arraycontains( [ "mg" ], params.sweapon.classname ) )
    {
        var_97497870082defe6 = issubstr( params.sweapon.basename, "lm_hades" );
        
        if ( var_97497870082defe6 )
        {
            damage *= var_e8ac91a5ef2b0fd1;
        }
        
        var_a95df4abd89a0a73 = issubstr( params.sweapon.basename, "lm_typhon" );
        
        if ( var_a95df4abd89a0a73 )
        {
            damage *= var_f835858b1b1cbcca;
        }
        
        var_928626a121064218 = issubstr( params.sweapon.basename, "lm_zeus" );
        
        if ( var_928626a121064218 )
        {
            damage *= var_18e2266ff0e121f5;
        }
        
        var_a9a126b53752ab54 = issubstr( params.sweapon.basename, "lm_hildr" );
        
        if ( var_a9a126b53752ab54 )
        {
            damage *= var_ca16f864fec9a903;
        }
    }
    else if ( arraycontains( [ "pistol" ], params.sweapon.classname ) )
    {
        damage *= 1;
    }
    else if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        isvulture = issubstr( params.sweapon.basename, "vulture" );
        iscorso = issubstr( params.sweapon.basename, "sh_corso" );
        isshepherd = issubstr( params.sweapon.basename, "sh_shepherd" );
        isterrier = issubstr( params.sweapon.basename, "sh_terrier" );
        
        if ( isvulture )
        {
            damage *= var_5224d35948c59281;
        }
        else if ( iscorso )
        {
            damage *= var_44534fdcf7bf3e3e;
        }
        else if ( isshepherd )
        {
            damage *= var_908e47d7962b0ec7;
        }
        else if ( isterrier )
        {
            damage *= var_c33aa7ef17cfe845;
        }
        
        var_60aa7bde8e31bcd0 = issubstr( params.sweapon.attachments, "akimbo_pi" );
        
        if ( var_60aa7bde8e31bcd0 )
        {
            damage *= var_4f79672e8ec957ce;
        }
    }
    else if ( arraycontains( [ "rifle" ], params.sweapon.classname ) && !is_wonder )
    {
        isrhino = issubstr( params.sweapon.basename, "remote_robot_arm_gun" );
        
        if ( isrhino )
        {
            damage *= var_29e58edec3b15252;
        }
        
        var_b564b55a357ad0a = issubstr( params.sweapon.basename, "ar_albatross" );
        
        if ( var_b564b55a357ad0a )
        {
            damage *= var_83d37edf201b2cfd;
        }
        
        var_e21b89a1a48eda24 = issubstr( params.sweapon.basename, "ar_egret" );
        
        if ( var_e21b89a1a48eda24 )
        {
            damage *= var_95511d95a93958e7;
        }
        
        var_9b71ed22ad8b7a11 = issubstr( params.sweapon.basename, "ar_finch" );
        
        if ( var_9b71ed22ad8b7a11 )
        {
            damage *= var_e5ee15bc1309375a;
        }
        
        var_2a51c3aa6c24cbdd = issubstr( params.sweapon.basename, "ar_heron" );
        
        if ( var_2a51c3aa6c24cbdd )
        {
            damage *= var_66b304267f9502e;
            
            if ( weakspotdata )
            {
                damage *= var_741aaacb780e3fcb;
            }
        }
        
        var_d2f5e7854e17e59c = issubstr( params.sweapon.basename, "ar_macaw" );
        
        if ( var_d2f5e7854e17e59c )
        {
            damage *= var_d425946c0ecce92b;
        }
        
        var_c6591c705a2d6871 = issubstr( params.sweapon.basename, "ar_kiwi" );
        
        if ( var_c6591c705a2d6871 )
        {
            damage *= var_7de7ff1e14998598;
        }
        
        var_bcac5e82fe0848e = issubstr( params.sweapon.basename, "ar_emu" );
        
        if ( var_bcac5e82fe0848e )
        {
            damage *= var_b32d5c9566b620f9;
        }
        
        var_22804e07a2a1c56c = issubstr( params.sweapon.basename, "dm_kara" );
        
        if ( var_22804e07a2a1c56c )
        {
            damage *= var_fa6ae129f40e640d;
            
            if ( weakspotdata )
            {
                damage *= var_3a0dd038443396ba;
            }
        }
    }
    else if ( arraycontains( [ "sniper" ], params.sweapon.classname ) )
    {
        damage *= var_aae5e4d2b6570d56;
        var_8a43871038dc6168 = issubstr( params.sweapon.basename, "sn_drake" );
        var_69693f78dd52645d = issubstr( params.sweapon.basename, "sn_aden" );
        var_53b88c53bcb5a948 = issubstr( params.sweapon.basename, "sn_caspian" );
        var_f8ce92563efe07d0 = issubstr( params.sweapon.basename, "sn_coral" );
        
        if ( var_8a43871038dc6168 )
        {
            damage *= var_4b7fa7312581b7d3;
        }
        else if ( var_69693f78dd52645d )
        {
            damage *= var_9a4640a410338ccc;
        }
        else if ( var_53b88c53bcb5a948 )
        {
            damage *= var_db3bf1b6cee753a3;
        }
        else if ( var_f8ce92563efe07d0 )
        {
            damage *= var_77ef519a48ec9faf;
        }
    }
    else if ( arraycontains( [ "smg" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_3f56cee67435a21e;
        var_a0793264c690be57 = issubstr( params.sweapon.attachments, "akimbo_sm" );
        
        if ( var_a0793264c690be57 )
        {
            damage *= var_1b8b28636737013e;
        }
        
        var_8ac364248fe9da03 = issubstr( params.sweapon.basename, "sm_orca" );
        var_2c4d0ef07c7b125f = issubstr( params.sweapon.basename, "sm_cobra" );
        var_6be2efa37f2d3915 = issubstr( params.sweapon.basename, "sm_hyena" );
        var_4ed004c75b6bb987 = issubstr( params.sweapon.basename, "sm_stoat" );
        var_6f864e32448705a1 = issubstr( params.sweapon.basename, "sm_komodo" );
        var_a460b22a1a51592f = issubstr( params.sweapon.basename, "sm_mammoth" );
        var_99614ccf137caca2 = issubstr( params.sweapon.basename, "sm_marmot" );
        var_781e96facb01fe60 = issubstr( params.sweapon.basename, "sm_otter" );
        var_892ec3c5e970e683 = issubstr( params.sweapon.basename, "sm_puma" );
        var_39f282945ecff933 = issubstr( params.sweapon.basename, "sm_serval" );
        var_958786a6a63535e0 = issubstr( params.sweapon.basename, "sm_zebraexotic" );
        var_22b6f1891552563e = issubstr( params.sweapon.basename, "sm_zebra" ) && !var_958786a6a63535e0;
        var_ea535479834326a5 = issubstr( params.sweapon.basename, "sm_civet" );
        var_bef4a086c89f2d8d = issubstr( params.sweapon.basename, "sm_bengal" );
        var_85cc380f1fded69d = issubstr( params.sweapon.basename, "sm_gecko" );
        var_28bdf7213142e18c = issubstr( params.sweapon.basename, "sm_bear" );
        
        if ( var_8ac364248fe9da03 )
        {
            damage *= var_64021406c1e284a4;
        }
        else if ( var_2c4d0ef07c7b125f )
        {
            damage *= var_5ad4058fe42539a;
        }
        else if ( var_6be2efa37f2d3915 )
        {
            damage *= var_41d6ed60e93466cc;
        }
        else if ( var_4ed004c75b6bb987 )
        {
            damage *= var_4902ecca444e0a0a;
        }
        else if ( var_6f864e32448705a1 )
        {
            damage *= var_954e3c92eeaffe8a;
        }
        else if ( var_a460b22a1a51592f )
        {
            damage *= var_1db18fb14b819f46;
        }
        else if ( var_99614ccf137caca2 )
        {
            damage *= var_bbeff31a90e06ee5;
        }
        else if ( var_781e96facb01fe60 )
        {
            damage *= var_a3ca9f131d6300f9;
        }
        else if ( var_892ec3c5e970e683 )
        {
            damage *= var_8519d2664696609c;
        }
        else if ( var_39f282945ecff933 )
        {
            damage *= var_b3b83a5ab245b7ec;
        }
        else if ( var_958786a6a63535e0 )
        {
            damage *= var_f5cdb22b4777022d;
        }
        else if ( var_22b6f1891552563e )
        {
            damage *= var_171f46ae7095831b;
        }
        else if ( var_ea535479834326a5 )
        {
            damage *= var_a78294aeffce90c4;
        }
        else if ( var_bef4a086c89f2d8d )
        {
            damage *= var_dcb0e656c9c82522;
        }
        else if ( var_85cc380f1fded69d )
        {
            damage *= var_822e9de3dfba30c0;
        }
        else if ( var_28bdf7213142e18c )
        {
            damage *= var_d60770d185f48ebf;
        }
    }
    else if ( arraycontains( [ "dm" ], params.sweapon.classname ) && !is_wonder )
    {
        damage *= var_31ff27f24504c5c6;
        istasman = issubstr( params.sweapon.basename, "tasman" );
        
        if ( istasman )
        {
            damage *= var_f53f8a2bd0180b20;
        }
    }
    else if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        iscrossbow = issubstr( params.sweapon.basename, "sl_crossbow" );
        var_ba45de6833daade9 = issubstr( params.sweapon.basename, "ks_compound" );
        ismanglercannon = issubstr( params.sweapon.basename, "mangler_cannon" );
        var_7a37c47ccd17a049 = issubstr( params.sweapon.basename, "ks_m202" );
        
        if ( iscrossbow )
        {
            damage *= var_d48cf9ae0101f824;
        }
        else if ( var_ba45de6833daade9 )
        {
            damage *= var_2735afaab8d7322e;
            
            if ( weakspotdata )
            {
                damage *= var_30e23d6f68aeab2f;
            }
        }
        else if ( ismanglercannon )
        {
            damage *= var_2557bd56e76450f8;
        }
        else if ( var_7a37c47ccd17a049 )
        {
            damage *= var_68e86b21c8631912;
        }
        
        isfang = issubstr( params.sweapon.basename, "la_fang" );
        
        if ( isfang )
        {
            damage *= var_4c06ef375c13ea1e;
        }
        
        isatria = issubstr( params.sweapon.basename, "sl_atria" );
        
        if ( isatria )
        {
            damage *= var_cbe1b29ad713515f;
        }
        
        iscarina = issubstr( params.sweapon.basename, "sl_carina" );
        
        if ( iscarina )
        {
            damage *= var_59faf3eff2f9ce2c;
        }
        
        issargas = issubstr( params.sweapon.basename, "sl_sargas" );
        
        if ( issargas )
        {
            damage *= var_27290881d032efef;
        }
    }
    else if ( arraycontains( [ "grenade" ], params.sweapon.classname ) )
    {
        var_d9e7bcfde8e48be5 = issubstr( params.sweapon.basename, "ground_drone_unit" );
        
        if ( var_d9e7bcfde8e48be5 )
        {
            damage *= var_7156e77b2b8e5cd4;
        }
        else
        {
            damage *= var_2067935b2ea13ba;
        }
        
        isnembus = issubstr( params.sweapon.basename, "sl_nembus" );
        
        if ( isnembus )
        {
            damage *= var_11ffd83c4978f00a;
        }
        
        if ( issubstr( params.sweapon.basename, "blackhole_bomb" ) )
        {
            damage *= var_3b1f952caa88011e;
        }
    }
    else if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= getdvarfloat( @"hash_3900cc4eb499f5c8", 1 );
        }
    }
    else if ( arraycontains( [ "throwingknife" ], params.sweapon.classname ) )
    {
        damage *= 0.1;
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_489c401145711d27", 1 );
    }
    
    if ( arraycontains( params.sweapon.attachments, "sat_ammo_50cal_ar_hawk" ) && weakspotdata )
    {
        damage *= var_77b8b7d739653ade;
    }
    
    if ( arraycontains( params.sweapon.attachments, "sat_underbarrel_shotgun_sn_caspian" ) )
    {
        damage *= var_40dcccd28b9da5b3;
    }
    
    if ( issubstr( params.sweapon.basename, "sn_baltic" ) )
    {
        damage *= var_16ae1125a6a7d307;
        
        if ( arraycontains( params.sweapon.attachments, "sat_ub_crossbar_sn_baltic" ) )
        {
            damage *= var_bcf3b1b24a202f81;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_atlas" ) )
    {
        damage *= var_e53b66a0bc564ac7;
    }
    
    if ( issubstr( params.sweapon.basename, "pi_alcor" ) )
    {
        damage *= var_1ee624ee6ce0fe17;
        
        if ( weakspotdata )
        {
            damage *= var_9a63c8107d8fe6bc;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "pi_orion" ) )
    {
        damage *= var_f68435a7c71028a9;
        
        if ( weakspotdata )
        {
            damage *= var_db0d136f8ce8451e;
        }
    }
    
    if ( issubstr( params.sweapon.basename, "ks_smartgun" ) )
    {
        damage *= var_566f0c1cb686681a;
    }
    
    if ( issubstr( params.sweapon.basename, "frost_blast" ) )
    {
        damage *= var_54d187cadce293b3;
    }
    
    if ( issubstr( params.sweapon.basename, "wiley_fox_zm" ) )
    {
        damage *= var_83e7914eb22dcac7;
    }
    
    if ( weakspotdata && params.biscritical )
    {
        damage = min( damage, var_3f2e80330371bcc1 );
    }
    
    if ( !weakspotdata && !armordata && !var_2428aee138922248 && !is_wonder )
    {
        damage = min( damage, var_52eec01ca61dbf15 );
    }
    
    return int( damage );
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xdd39290a, Offset: 0xd469
// Size: 0x120
function private function_83572cfafd70a37a( params )
{
    var_2544d9dd0c043c95 = 2.4;
    wait 7;
    level thread overlord::playconversation( #"weyward_kill" );
    self waittill( #"fade_out_begin" );
    wait var_2544d9dd0c043c95;
    level.var_8eb019fd327a4643 = 1;
    val::reset_all( "weyward_init" );
    self kill( self.origin, params.eattacker, params.einflictor, params.smeansofdeath, params.objweapon );
    level.var_8eb019fd327a4643 = undefined;
    
    foreach ( player in level.players )
    {
        player val::set( "weyward_real_death", "show_hud", 1 );
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x163a11eb, Offset: 0xd591
// Size: 0x188
function private function_3ff25bd7822d5c2e()
{
    level endon( #"game_ended" );
    var_5b7879934db976a3 = 0;
    
    while ( isalive( self ) )
    {
        if ( self.health < self.maxhealth * 0.8 && var_5b7879934db976a3 < 1 )
        {
            iprintlnbold( "TIME OUT!!" );
            logstring( "====OUBLIETTE TIME OUT" );
            level thread overlord::playconversation( #"hash_1d4d820215911817" );
            level thread white_screen_flash( 0.3, 0, 0, 0.6 );
            wait 1.2;
            zm_sat_scarab_boss_fight_oubliette::function_1cd83c2053a3b99c();
            var_5b7879934db976a3 = 1;
        }
        else if ( self.health < self.maxhealth * 0.5 && var_5b7879934db976a3 < 2 )
        {
            iprintlnbold( "TIME OUT!!" );
            logstring( "====OUBLIETTE TIME OUT" );
            level thread overlord::playconversation( #"hash_ce4d5f4378150acf" );
            level thread white_screen_flash( 0.3, 0, 0, 0.6 );
            wait 1.2;
            zm_sat_scarab_boss_fight_oubliette::function_1cd83c2053a3b99c();
            var_5b7879934db976a3 = 2;
        }
        else if ( self.health < self.maxhealth * 0.15 && var_5b7879934db976a3 < 4 )
        {
            iprintlnbold( "TIME OUT!!" );
            logstring( "====OUBLIETTE TIME OUT" );
            level thread overlord::playconversation( #"hash_1d4d820215911817" );
            level thread white_screen_flash( 0.3, 0, 0, 0.6 );
            wait 1.2;
            zm_sat_scarab_boss_fight_oubliette::function_1cd83c2053a3b99c();
            var_5b7879934db976a3++;
            self waittill( #"fake_death_end" );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0x5d889732, Offset: 0xd721
// Size: 0x49
function private on_weyward_killed( params )
{
    level.scarab_br.bosses[ "weyward" ] callback::remove( "on_zombie_ai_killed", &on_weyward_killed );
    function_b9322c9b70c37b0c();
    utility::flag_set( "weyward_killed" );
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xfdf47f9d, Offset: 0xd772
// Size: 0xd4
function private function_7d318be4d3c5922f()
{
    level thread ae_unlock();
    level musicbank_utility::function_4f253fd35ec68cbc( level.players );
    
    foreach ( player in level.players )
    {
        player clearsoundsubmix( "sat_zm_scarab_boss" );
    }
    
    level musicbank_utility::function_e146ca500a84f52f( #"round_start" );
    level musicbank_utility::function_e146ca500a84f52f( #"round_end" );
    wait 5;
    level overlord::playconversation( #"br_outro" );
    function_1f0a503034a2c1f8();
}

// Namespace zm_sat_scarab_br
// Params 0
// Checksum 0x2b55d882, Offset: 0xd84e
// Size: 0x44d
function function_1f0a503034a2c1f8()
{
    videoname = "sat_zm_see_mv";
    var_33f5b5f4851b6009 = 242;
    
    foreach ( player in level.players )
    {
        if ( player::isinlaststand( player ) )
        {
            player laststand::exit( "last_stand_revived", player );
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            player thread playerlogic::spawnclient();
        }
        
        player val::set( "end_igc", "show_hud", 0 );
        player val::set( "end_igc", "allow_movement", 0 );
        player val::set( "end_igc", "freezecontrols", 1 );
        player val::set( "end_igc", "damage", 0 );
        player val::set( "end_igc", "death", 0 );
        player val::set( "end_igc", "ignoreme", 1 );
        player val::set( "end_igc", "ignore_playable_area_check", 1 );
        player val::set( "end_igc", "crouch", 0 );
        player val::set( "end_igc", "prone", 0 );
        player val::set( "end_igc", "melee", 0 );
        player val::set( "end_igc", "offhand_primary_weapons", 0 );
        player val::set( "end_igc", "offhand_secondary_weapons", 0 );
        player val::set( "end_igc", "weapon", 0 );
        player val::set( "end_igc", "killstreaks", 0 );
        player val::set( "end_igc", "ads", 0 );
        player val::set( "end_igc", "weapon_switch", 0 );
        player val::set( "end_igc", "action_slot_weapon", 0 );
        player val::set( "end_igc", "armor", 0 );
        player val::set( "end_igc", "supers", 0 );
        player utility::ent_flag_set( "scene_active" );
        level thread utility::fadetoblackforplayer( player, 1, 3 );
    }
    
    wait 3;
    setdvar( @"bg_cinematicfullscreen", 1 );
    playcinematicforall( videoname, 1 );
    
    foreach ( player in level.players )
    {
        level thread utility::fadetoblackforplayer( player, 0, 2 );
    }
    
    wait var_33f5b5f4851b6009 - 2;
    
    foreach ( player in level.players )
    {
        level thread utility::fadetoblackforplayer( player, 1, 1 );
    }
    
    wait 1.5;
    stopcinematicforall( 0, 1 );
    zm_exfil::function_8f261015e4f861ae( 1 );
    
    foreach ( player in level.players )
    {
        player utility::ent_flag_clear( "scene_active" );
        level thread utility::fadetoblackforplayer( player, 0, 1.5 );
    }
    
    level.b_zm_game_over = 1;
    level thread gamelogic_zm::endgame( getdvar( @"scr_force_team", "allies" ), game[ "end_reason" ][ "objective_completed" ] );
}

// Namespace zm_sat_scarab_br
// Params 0
// Checksum 0xc44c0fe0, Offset: 0xdca3
// Size: 0xb4
function ae_unlock()
{
    foreach ( player in level.scarab_br.var_be82617e5e8087bd )
    {
        if ( player.var_a10da01c9aea8bf2 )
        {
            level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_560db69c562e574c", [ player ] );
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x5279765c, Offset: 0xdd5f
// Size: 0x137
function private spawn_powerups()
{
    powerup_height_offset = ( 0, 0, 50 );
    thread powerups::powerup_drop( "full_armor", utility::getstruct( "center_east" ).origin + powerup_height_offset, 58 );
    thread powerups::powerup_drop( "full_ammo", utility::getstruct( "center_north" ).origin + powerup_height_offset, 58 );
    thread powerups::powerup_drop( "full_power", utility::getstruct( "center_west" ).origin + powerup_height_offset, 58 );
    thread powerups::powerup_drop( "free_perk", utility::getstruct( "center_south" ).origin + powerup_height_offset, 58 );
    waitframe();
    
    foreach ( player in level.players )
    {
        player currency::add_currency_amount( #"essence", 10000 );
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x6a823755, Offset: 0xde9e
// Size: 0x7a
function private revive_player()
{
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        thread playerlogic::spawnplayer();
        
        if ( !isalive( self ) || self.sessionstate == "spectator" )
        {
            utility::waittill_any_timeout( 5, "spawned_player" );
            thread playerlogic::removespawnmessageshortly( 0.1 );
        }
    }
    
    if ( player::isinlaststand( self ) )
    {
        laststand::exit( "last_stand_revived", self );
    }
    
    self function_d88e8eab88c50c13( 1 );
}

// Namespace zm_sat_scarab_br
// Params 4
// Checksum 0x11421988, Offset: 0xdf20
// Size: 0x2d7
function toy_spawn( toy_model, toy_vfx, bob_time, do_flash = 1 )
{
    toy = utility::spawn_model( toy_model, level.scarab_br.boss_spawn.origin + ( 0, 0, 1000 ), level.scarab_br.boss_spawn.angles );
    playfxontag( utility::getfx( "toy_trail" ), toy, "tag_origin" );
    toy playsoundonmovingent( #"hash_e09d7ba217076d26" );
    toy playloopsound( #"hash_2ff0cf9678d66ed7" );
    toy moveto( level.scarab_br.boss_spawn.origin + ( 0, 0, 100 ), 2, 1, 1 );
    toy rotateyaw( 360, 12 );
    wait 2;
    toy bobbing( ( 0, 0, -1 ), 5, 2 );
    wait bob_time;
    toy playsoundonmovingent( #"hash_1a6c6e424b397db0" );
    toy moveto( level.scarab_br.boss_spawn.origin + ( 0, 0, 150 ), 0.5, 0.2, 0.2 );
    wait 0.5;
    toy moveto( level.scarab_br.boss_spawn.origin + ( 0, 0, -100 ), 0.3, 0.1 );
    wait 0.2;
    playworldsound( toy.origin, #"hash_4b52d6ce6d6bd419" );
    playfxontag( toy_vfx, level.scarab_br.vfx_spawn, "tag_origin" );
    wait 0.1;
    thread zm_utility::function_1d82e63812f9640a( level.scarab_br.boss_spawn.origin, 3000 );
    
    if ( do_flash )
    {
        foreach ( player in level.players )
        {
            player thread white_screen_flash( 0.7, 0.3 );
        }
        
        wait 1;
    }
    else
    {
        level.scarab_br.vfx_spawn playloopsound( #"hash_ec57328593b4e8b0" );
    }
    
    toy delete();
}

// Namespace zm_sat_scarab_br
// Params 4, eflags: 0x4
// Checksum 0x1188c784, Offset: 0xe1ff
// Size: 0x85
function private white_screen_flash( var_748d21f0ae3805f1 = 0.3, fade_in_delay = 0, b_play_sound = 1, alpha )
{
    level endon( #"game_ended" );
    
    if ( b_play_sound )
    {
        self playsoundevent( %"sndevent_powerup_nuke" );
    }
    
    hud_util::fade_out( var_748d21f0ae3805f1, "white", alpha );
    wait fade_in_delay;
    hud_util::fade_in( var_748d21f0ae3805f1, "white" );
}

// Namespace zm_sat_scarab_br
// Params 1
// Checksum 0x30439c7, Offset: 0xe28c
// Size: 0x5fe
function set_stations_active( var_711e3c9a288e87ff )
{
    if ( var_711e3c9a288e87ff )
    {
        activateworldevent( "we_sat_zm_pap_clean_fxanim" );
        
        foreach ( player in level.players )
        {
            player.var_73e2de392faa52c6 = 0;
        }
        
        foreach ( s_perk_machine in level.a_s_perk_machines )
        {
            if ( s_perk_machine.content_key == "perk_machine_choice_spawn" && isdefined( s_perk_machine.mdl_perk_machine ) )
            {
                s_perk_machine.mdl_perk_machine thread perk_machines::function_ebf0534612bd6968();
            }
        }
        
        foreach ( s_arsenal_location in level.var_52e94a468e66d601 )
        {
            s_arsenal_location arsenal::enable_arsenal();
        }
        
        foreach ( s_crafting_table in level.a_s_crafting_tables )
        {
            s_crafting_table.var_7fac639c5e7fd54 crafting_table::set_crafting_table_vfx( "static" );
        }
        
        foreach ( player in level.players )
        {
            player.crafting_table_disabled = 0;
        }
        
        return;
    }
    
    level.scarab_br.s_pap.var_370acb837a3a86c3.interact.var_ac57fe7fccb8aaf6 = &"hash_2a4a74442695fbaf";
    
    foreach ( player in level.players )
    {
        player.var_73e2de392faa52c6 = 1;
        player.var_56d43599c6ebfc4e = 1;
    }
    
    deactivateworldevent( "we_sat_zm_pap_clean_fxanim" );
    
    foreach ( s_perk_machine in level.a_s_perk_machines )
    {
        if ( s_perk_machine.content_key == "perk_machine_choice_spawn" && isdefined( s_perk_machine.mdl_perk_machine ) )
        {
            s_perk_machine.mdl_perk_machine perk_machines::function_9ecd411b3667e542();
            s_perk_machine.mdl_perk_machine.interact.var_4256b14b47d5e763 = &"hash_2a4a74442695fbaf";
        }
    }
    
    foreach ( s_arsenal_location in level.var_52e94a468e66d601 )
    {
        s_arsenal_location arsenal::disable_arsenal( 1, 1 );
        s_arsenal_location.mdl_arsenal.interact.var_24bf1c43b9cd2254 = &"hash_2a4a74442695fbaf";
    }
    
    foreach ( s_crafting_table in level.a_s_crafting_tables )
    {
        s_crafting_table.var_7fac639c5e7fd54 crafting_table::set_crafting_table_vfx( "disabled" );
        s_crafting_table.var_7fac639c5e7fd54.interact.var_5523ddf0718b94ed = &"hash_2a4a74442695fbaf";
    }
    
    foreach ( player in level.players )
    {
        player.crafting_table_disabled = 1;
        player.var_fa38187d52ae7d76 = 1;
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0x390e8fe, Offset: 0xe892
// Size: 0xaa
function private function_25ab54d73644285a()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_4650302076d421f0 = 1833.85;
    var_806d66690e224033 = 0.25;
    
    while ( true )
    {
        if ( !zombie_leap_attack::is_in_leap_attack() && ( self.origin[ 2 ] < var_4650302076d421f0 || !ispointonnavmesh( self.origin ) ) )
        {
            closest_navmesh_point = getclosestpointonnavmesh( self.origin, self, 0, 1, 1 );
            
            if ( closest_navmesh_point )
            {
                self forceteleport( closest_navmesh_point, self.angles, 3000 );
            }
        }
        
        wait var_806d66690e224033;
    }
}

// Namespace zm_sat_scarab_br
// Params 0
// Checksum 0xc6e8ae3b, Offset: 0xe944
// Size: 0xe5
function function_787a7f08c8e2c465()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        all_outside = 1;
        
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( distancesquared( player.origin, level.scarab_br.boss_spawn.origin ) < 250000 )
            {
                all_outside = 0;
                break;
            }
        }
        
        if ( all_outside )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_scarab_br
// Params 4, eflags: 0xc
// Checksum 0xfe7791ba, Offset: 0xea31
// Size: 0x41e
function private function_d61a90397b033244( spawn_settings, current_boss, n_phase_override = 0, move_speed = "sprint" )
{
    self notify( #"hash_bde3db6e5801e87a" );
    self endon( #"hash_bde3db6e5801e87a" );
    level endon( #"game_ended" );
    level endon( #"hash_4a5b036b01c86092" );
    level.scarab_br.add_spawning_active = 1;
    zone = zone_manager::function_90e5c3e2272b0130( level.scarab_br.boss_spawn.origin );
    
    while ( level.scarab_br.add_spawning_active )
    {
        phaseindex = int( isalive( current_boss ) ? ( 1 - current_boss.health / current_boss.maxhealth ) * spawn_settings.size : n_phase_override );
        
        if ( getaiarrayinradius( level.scarab_br.boss_spawn.origin, 3000, "team_two_hundred" ).size < spawn_settings[ phaseindex ].var_e9fe33047720af8f[ level.players.size - 1 ].var_8e490e61485c47af )
        {
            do
            {
                spawn = utility::random_weighted_struct( spawn_settings[ phaseindex ].spawnlist );
                zombie_type = function_b3988325430ce242( spawn.aitype );
                spawn_max = spawn.useplayercount ? level.players.size - 1 : spawn.typemax;
            }
            while ( zm_utility::function_205b7482cb035d0e( spawn.aitype ).size >= spawn_max );
            
            zombie = zone_spawner::spawn_agent( zombie_type, { #zones:[ zone ] } );
            
            if ( isdefined( zombie ) )
            {
                zombie.no_powerups = 1;
                zombie.var_a13bed1ac47e1b2c = !isalive( current_boss );
                n_round = zm_utility::get_round_number();
                n_round = max( n_round, 30 );
                zombie zombie_utils::set_zombie_round_difficulty( n_round );
                zombie.var_13518fb33ec73cc = n_round;
                zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( move_speed == "super_sprint" || move_speed == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && move_speed == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && move_speed == "sprint" ? "run" : move_speed, "default", 6 );
                
                if ( level.players.size > 1 && randomint( 100 ) < spawn.supersprintchance )
                {
                    zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "super_sprint" == "super_sprint" || "super_sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "super_sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "super_sprint" == "sprint" ? "run" : "super_sprint", "default", 6 );
                }
            }
        }
        
        wait spawn_settings[ phaseindex ].var_e9fe33047720af8f[ clampint( level.players.size - 1, 0, 3 ) ].var_8f17fcdb8088a8c6;
    }
}

// Namespace zm_sat_scarab_br
// Params 1, eflags: 0x4
// Checksum 0xb4d8a6a2, Offset: 0xee57
// Size: 0x105
function private function_b9322c9b70c37b0c( var_544986a6dd458b8e = 1 )
{
    level.scarab_br.add_spawning_active = 0;
    level notify( #"hash_4a5b036b01c86092" );
    
    if ( var_544986a6dd458b8e )
    {
        foreach ( zombie in getaiarrayinradius( level.scarab_br.boss_spawn.origin, 3000, "team_two_hundred" ) )
        {
            if ( isdefined( level.scarab_br.zombie_kill_throttle ) )
            {
                throttle::throttle_wait_in_queue( level.scarab_br.zombie_kill_throttle, zombie );
            }
            
            zombie kill();
        }
    }
}

// Namespace zm_sat_scarab_br
// Params 0, eflags: 0x4
// Checksum 0xcc5d164d, Offset: 0xef64
// Size: 0xe
function private function_8ffd4d1801274cd3()
{
    zm_quest::function_2850bf8c7015dc92( "zone_boss_arena_ff" );
}

// Namespace zm_sat_scarab_br
// Params 0
// Checksum 0x2bedb3c8, Offset: 0xef7a
// Size: 0x11b
function function_8854f7023073f1db()
{
    level endon( #"game_ended" );
    boss = scene::get_entity( "neptune" );
    settings = level.zombie_neptune.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    model = settings.var_8dd4e61c890f6cf6 ?? "c_sat_zmb_neptune_3";
    boss setmodel( model );
    boss utility::function_32b24db3127bff40( "eye", "on_3" );
    boss utility::function_32b24db3127bff40( "movement", "on_3" );
    zombie_neptune_metabones::function_bc9300a17f3a6e6e( level.zombie_neptune, boss, 3 );
    
    if ( isai( boss ) )
    {
        boss function_786bb6aa1b76c7ee( "disable_think", 1 );
    }
    
    var_ec5239099646d099 = getdvarint( @"hash_e6194c46ef879958", 1 );
    
    if ( var_ec5239099646d099 )
    {
        player = scene::get_entity( "Player 1" );
        
        if ( player )
        {
            wait 5;
            
            if ( player )
            {
                player playerhide();
            }
            
            wait 2.7;
            
            if ( player )
            {
                player playershow();
            }
        }
    }
}

/#

    // Namespace zm_sat_scarab_br
    // Params 0
    // Checksum 0x9beba2f8, Offset: 0xf09d
    // Size: 0x138, Type: dev
    function function_5725ba6fcdad11e9()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x41>", "<dev string:x53>", &function_e5abdd9a2b17158b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6a>", "<dev string:x8d>", &function_e5abdd9a2b17158b );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa3>", "<dev string:xc6>", &function_e5abdd9a2b17158b );
        devgui::function_cd4e263c1f3018ae( "<dev string:xdc>", "<dev string:xfe>", &function_e5abdd9a2b17158b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x113>", "<dev string:x137>", &function_e5abdd9a2b17158b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x14e>", "<dev string:x172>", &function_e5abdd9a2b17158b );
        devgui::function_cd4e263c1f3018ae( "<dev string:x189>", "<dev string:x1a4>", &function_27ff2ba244eaa8e5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1b7>", "<dev string:x1d2>", &function_27ff2ba244eaa8e5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e5>", "<dev string:x200>", &function_27ff2ba244eaa8e5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x213>", "<dev string:x22d>", &function_27ff2ba244eaa8e5 );
        devgui::add_devgui_func( "<dev string:x23f>", "<dev string:x24a>", &function_d130e4ec8dcac5d2 );
        devgui::add_devgui_func( "<dev string:x255>", "<dev string:x261>", &function_2f1b1e3c1361fe8b );
        devgui::add_devgui_func( "<dev string:x26d>", "<dev string:x27c>", &function_b63d224759464884, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_scarab_br
    // Params 1, eflags: 0x4
    // Checksum 0xef1b27e3, Offset: 0xf1dd
    // Size: 0xcc, Type: dev
    function private function_27ff2ba244eaa8e5( params )
    {
        foreach ( boss in level.scarab_br.bosses )
        {
            if ( isalive( boss ) )
            {
                boss.health = int( boss.maxhealth * int( params[ 0 ] ) / 100 );
                boss dodamage( 1, boss.origin );
            }
        }
    }

    // Namespace zm_sat_scarab_br
    // Params 1, eflags: 0x4
    // Checksum 0xe7c29b5e, Offset: 0xf2b1
    // Size: 0x31, Type: dev
    function private function_b63d224759464884( params )
    {
        zm_quest::function_cd1f2fee4749fb0a( 1, #"scarab_br", #"hash_4a3e216215db35fd" );
        finish_derby();
    }

    // Namespace zm_sat_scarab_br
    // Params 0
    // Checksum 0x197d175d, Offset: 0xf2ea
    // Size: 0x27, Type: dev
    function function_d130e4ec8dcac5d2()
    {
        level.scarab_br.fog setscriptablepartstate( "<dev string:x28b>", "<dev string:x28f>" );
    }

    // Namespace zm_sat_scarab_br
    // Params 0
    // Checksum 0xc84e2b66, Offset: 0xf319
    // Size: 0x27, Type: dev
    function function_2f1b1e3c1361fe8b()
    {
        level.scarab_br.fog setscriptablepartstate( "<dev string:x28b>", "<dev string:x297>" );
    }

#/
