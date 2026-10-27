// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_neigh.gsc  (hash_22b2e3bf0969d942.gscc) (size: 40217 Bytes / 0x9d19 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3cb0f48 (63639368)
// size ...... 40217 (0x9d19)
// includes .. 27  (offset: 0x95a9)
// strings ... 97  (offset: 0x9681)
// dev strs .. 9   (offset: 0x9cad)
// exports ... 89  (offset: 0x6691)
// cseg ...... 0x734 + 0x5f5d (0x6691)
// imports ... 264 (offset: 0x7479)
// animtree1 . 0   (offset: 0x9d19)
// animtree2 . 0   (offset: 0x9d19)
#using script_16ea1b94f0f381b3;
#using script_5a0c375c28690264;
#using script_60ecf0e6d7ee7771;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\mutant_injection_utility;
#using scripts\mp\common\killstreaks\rcxd_shared;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weaponmetadata;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_neigh_cs;
#using scripts\mp\zm\systems\zm_live_spectate;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\tedd_tasks;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet_ee_neigh;

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x5
// Checksum 0x108fa1a9, Offset: 0x752
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_neigh", undefined, undefined, &postmain_init );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xb281775c, Offset: 0x773
// Size: 0x1d7
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_ee72ddd09944ed3d", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_neigh_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_neigh = zm_quest::get_quest( #"hornet_ee_neigh" );
    level.ee_neigh.var_e4480d20580f89eb = 0;
    level.ee_neigh.var_9cbed8e6013eb6bf = [];
    level.ee_neigh.var_2a34c694da73096f = [];
    level.ee_neigh.var_2d24383a92e9330f = [];
    level.ee_neigh.var_5d2058cee3f9ff9a = [];
    level.ee_neigh.var_2f54b195676ac0da = [];
    level.ee_neigh.a_spawned_models = [];
    level.ee_neigh.ui_start_countdown = namespace_2918ad6c52d71794::register();
    level.ee_neigh.var_8aa3a5f107f9eaab = [];
    level.ee_neigh.var_44cdea0f5b5b33d4 = makeweapon( "sat_buzzkill_sushi_cannon_proj_zm" );
    level._effect[ "vfx_sat_hornet_murder_holes_ghostly_rifle_muzzle_flash" ] = loadfxasset( "vfx_sat_hornet_murder_holes_ghostly_rifle_muzzle_flash" );
    zm_quest::function_3c363613c60958f5( "neigh_ee_active" );
    zm_quest::register_quest_step( #"hornet_ee_neigh", #"unlock_neigh", &setup_collect, &cleanup_collect );
    zm_quest::register_quest_step( #"hornet_ee_neigh", #"play_neigh", &setup_compete, &cleanup_compete );
    level zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hornet_ee_neigh" );
    
    /#
        register_neigh_devgui();
    #/
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"give_horse", &function_312c99954c545177 );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0x416f7e13, Offset: 0x952
// Size: 0x3fe
function private setup_collect( b_skipped, b_save_restored )
{
    s_horse = utility::getstruct( "nei_hr_init", "targetname" );
    level.ee_neigh.e_horse = utility::spawn_model( %"accessory_dmz_origami_horse", s_horse.origin, s_horse.angles );
    level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = level.ee_neigh.e_horse;
    s_bucket = utility::getstruct( "nei_buck", "targetname" );
    level.ee_neigh.e_bucket = utility::spawn_model( %"furniture_wooden_basket_01", s_bucket.origin, s_bucket.angles );
    level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = level.ee_neigh.e_bucket;
    var_1d1af32d30f2bedc = utility::getstructarray( "nei_car_pu", "targetname" );
    var_1d1af32d30f2bedc = sortbydistance( var_1d1af32d30f2bedc, ( 0, 0, 0 ) );
    a_loc_keys = [ #"hash_3296daa64b376ffe", #"hash_3296dba64b3771b1", #"hash_3296d8a64b376c98", #"hash_3296d9a64b376e4b", #"hash_3296dea64b3776ca", #"hash_3296dfa64b37787d", #"hash_3296dca64b377364", #"hash_3296dda64b377517" ];
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        for ( i = 0; i < var_1d1af32d30f2bedc.size ; i++ )
        {
            if ( level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_neigh", a_loc_keys[ i ] ) ?? 0 )
            {
                var_1d1af32d30f2bedc[ i ].b_collected = 1;
                level.ee_neigh.var_e4480d20580f89eb++;
            }
        }
    }
    
    for ( i = 0; i < var_1d1af32d30f2bedc.size ; i++ )
    {
        s_carrot = var_1d1af32d30f2bedc[ i ];
        
        if ( s_carrot.b_collected )
        {
            if ( s_carrot.target )
            {
                s_dest = utility::getstruct( s_carrot.target, "targetname" );
                e_cosmetic = utility::spawn_model( %"hash_7ba38d331ab0e187", s_dest.origin, s_dest.angles );
                level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = e_cosmetic;
            }
            
            continue;
        }
        
        e_carrot = utility::spawn_model( %"hash_7ba38d331ab0e187", s_carrot.origin, s_carrot.angles );
        level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = e_carrot;
        interact = interaction::register_interact( s_carrot.origin + ( 0, 0, 30 ), 48, &function_669bec2bf8c42584, undefined, undefined, undefined, 1, undefined, 1 );
        interact interaction::set_interact_hint_callback( &carrot_hint );
        interact.var_5acd2f6fd6c4c28b = e_carrot;
        interact.var_16af6624858ffa21 = s_carrot;
        interact.var_e32776c1f6278952 = i;
        interact.var_9e8da57c1a0a515f = 0;
    }
    
    if ( level.ee_neigh.var_e4480d20580f89eb >= 4 )
    {
        level utility::flag_set( "unlock_neigh" );
        return;
    }
    
    level utility::flag_wait( "unlock_neigh" );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0x2c783199, Offset: 0xd58
// Size: 0x15
function private cleanup_collect( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0x65c0e44a, Offset: 0xd75
// Size: 0x26c
function private setup_compete( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait_all( "door_west_bailey_to_broken_turrets", "door_broken_turrets_to_main_bailey", "door_second_bailey_to_main_bailey", "door_lava_garden_to_second_bailey" );
    var_906d2fa4b282a644 = utility::getstruct( "nei_hr_int", "targetname" );
    
    if ( level.ee_neigh.e_horse )
    {
        level.ee_neigh.a_spawned_models = arrayremove( level.ee_neigh.a_spawned_models, level.ee_neigh.e_horse );
        level.ee_neigh.e_horse delete();
    }
    
    level.ee_neigh.e_horse = utility::spawn_model( %"accessory_dmz_origami_horse", var_906d2fa4b282a644.origin, var_906d2fa4b282a644.angles );
    level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = level.ee_neigh.e_horse;
    level.ee_neigh.e_horse thread bob_entity( 8, 1.5 );
    level.ee_neigh.race_interact = interaction::register_interact( var_906d2fa4b282a644.origin + ( 0, 0, 30 ), 64, &on_race_start, undefined, undefined, undefined, 1, undefined, 1 );
    level.ee_neigh.race_interact interaction::set_interact_hint_callback( &race_hint );
    level.ee_neigh.race_interact.var_2103e9e2b7d4a14e = 0;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        var_a22b71f86276c8f1 = level zm_quest::function_73720cdf21c3cfd7( #"hornet_ee_neigh", #"hash_376befa68d49635d" ) ?? 0;
        
        if ( var_a22b71f86276c8f1 > 0 )
        {
            var_49f7091014d2c59 = zm_utility::get_round_number();
            n_elapsed = var_49f7091014d2c59 - var_a22b71f86276c8f1;
            
            if ( n_elapsed < 5 )
            {
                level.ee_neigh.race_interact.var_2103e9e2b7d4a14e = 1;
                level thread function_a272d85db94961cc( 5 - n_elapsed );
            }
        }
    }
    
    level utility::flag_wait( "play_neigh" );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0x64e4546a, Offset: 0xfe9
// Size: 0x15
function private cleanup_compete( b_skipped, b_save_restored )
{
    
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x31ddd59e, Offset: 0x1006
// Size: 0x1e5
function private function_669bec2bf8c42584( player )
{
    if ( self.var_9e8da57c1a0a515f )
    {
        return;
    }
    
    self.var_9e8da57c1a0a515f = 1;
    player playsoundtoplayer( "uin_zm_common_pickup_item_food", player );
    
    if ( self.var_5acd2f6fd6c4c28b )
    {
        level.ee_neigh.a_spawned_models = arrayremove( level.ee_neigh.a_spawned_models, self.var_5acd2f6fd6c4c28b );
        self.var_5acd2f6fd6c4c28b delete();
    }
    
    if ( self.var_16af6624858ffa21.target )
    {
        s_dest = utility::getstruct( self.var_16af6624858ffa21.target, "targetname" );
        e_cosmetic = utility::spawn_model( %"hash_7ba38d331ab0e187", s_dest.origin, s_dest.angles );
        level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = e_cosmetic;
    }
    
    level.ee_neigh.var_e4480d20580f89eb++;
    a_loc_keys = [ #"hash_3296daa64b376ffe", #"hash_3296dba64b3771b1", #"hash_3296d8a64b376c98", #"hash_3296d9a64b376e4b", #"hash_3296dea64b3776ca", #"hash_3296dfa64b37787d", #"hash_3296dca64b377364", #"hash_3296dda64b377517" ];
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_neigh", a_loc_keys[ self.var_e32776c1f6278952 ], 1 );
    
    if ( level.ee_neigh.var_e4480d20580f89eb >= 4 )
    {
        level utility::flag_set( "unlock_neigh" );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0xf7124575, Offset: 0x11f3
// Size: 0x40
function private carrot_hint( usable, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0x7091f2c2, Offset: 0x123c
// Size: 0x40
function private race_hint( usable, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x522535bc, Offset: 0x1285
// Size: 0xff
function private on_race_start( player )
{
    if ( self.var_2103e9e2b7d4a14e )
    {
        return;
    }
    
    if ( function_a2c049da0a906c02() )
    {
        return;
    }
    
    if ( !utility::flag( "neigh_voting" ) )
    {
        utility::flag_set( "neigh_voting" );
        
        if ( !player.var_8b65dcd85804b474 )
        {
            player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hesd2_horsing_around_find_origami_horse", #"hash_5212ed7ec42f115a" );
            player.var_8b65dcd85804b474 = 1;
        }
        
        var_3faf858e79cd17bb = { #description:&"hash_7e85ae790bf177fa", #init_message:&"hash_368ffead421750f5" };
        b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
        
        if ( b_passed && !self.var_2103e9e2b7d4a14e && !function_a2c049da0a906c02() )
        {
            self.var_2103e9e2b7d4a14e = 1;
            level thread function_f083af3412ea4d12();
            level notify( #"neigh_voting_passed" );
        }
        
        utility::flag_clear( "neigh_voting" );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xdc7797b9, Offset: 0x138c
// Size: 0xc1, Type: bool
function private function_a2c049da0a906c02()
{
    if ( !zm_quest::function_f98968f17772726c( 1 ) || !function_e33a993c625d2f5d() || level utility::flag( "hornet_mq_blocking_horse_ee" ) || level utility::flag( "ar_active" ) || level utility::flag( "exfil_active" ) || level.ww_neko.has_cage || function_52d564524977be61() || level.ee_battle.var_9c444f4cb49b2a94 || function_594447b3dac28e21( "bossfight_fasttravel_active" ) || level utility::flag( "hornet_mq_mem_playing" ) || level utility::flag( "zm_vote_think" ) || level.sq_player )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x3588fa6a, Offset: 0x1456
// Size: 0x8c, Type: bool
function private function_594447b3dac28e21( flag )
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag_set( flag ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xb06d72a2, Offset: 0x14eb
// Size: 0x9f, Type: bool
function private function_e33a993c625d2f5d()
{
    foreach ( flag in [ "door_west_bailey_to_broken_turrets", "door_broken_turrets_to_main_bailey", "door_second_bailey_to_main_bailey", "door_lava_garden_to_second_bailey" ] )
    {
        if ( !level utility::flag( flag ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xfb598178, Offset: 0x1593
// Size: 0x84, Type: bool
function private function_52d564524977be61()
{
    foreach ( player in level.players )
    {
        if ( player.has_cat )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x52b9e608, Offset: 0x1620
// Size: 0x12f
function private clear_equipment()
{
    if ( isdefined( level.rcxds ) && level.rcxds.size )
    {
        foreach ( rcxd in level.rcxds )
        {
            rcxd rcxd_shared::rcxd_explode();
        }
    }
    
    foreach ( player in level.players )
    {
        player thread mutant_injection_utility::function_6fa2b0b46d2abcf7( 1 );
        
        if ( player.var_a6244b072ab54846 )
        {
            function_9f1de18100c63247( player.var_a6244b072ab54846 );
        }
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xccb8ba2c, Offset: 0x1757
// Size: 0xa1
function private function_7d638dfa0508cd67()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        while ( namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) && player.var_d1c4c78b9fb7d153 )
        {
            wait 0.25;
        }
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x743e88ba, Offset: 0x1800
// Size: 0x9fd
function private function_f083af3412ea4d12()
{
    var_adae4bc24d47644a = utility::getstructarray( "nei_p_sp", "targetname" );
    level utility::flag_set( "neigh_ee_active" );
    level.ee_neigh.var_eb302e9eae9188ff = 1;
    level.ee_neigh.n_players_finished = 0;
    level.ee_neigh.var_d411d90059ee3b1 = undefined;
    level.ee_neigh.var_120b749907b989aa = [];
    
    foreach ( player in level.players )
    {
        if ( player.sessionstate == "spectator" )
        {
            continue;
        }
        
        level.ee_neigh.var_120b749907b989aa[ level.ee_neigh.var_120b749907b989aa.size ] = player;
    }
    
    function_7d638dfa0508cd67();
    clear_equipment();
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        player thread zm_utility::white_screen_flash( 0.5, 0.5 );
        player playlocalsound( #"hash_ed2543ec2f836996" );
    }
    
    wait 0.5;
    level musicbank_utility::function_5aca66c390aa347d( level.ee_neigh.var_120b749907b989aa, #"assault_round_prepare" );
    level thread namespace_923cf551235ca152::function_1131b0421d97e24b( 180 );
    
    for ( i = 0; i < level.ee_neigh.var_120b749907b989aa.size ; i++ )
    {
        player = level.ee_neigh.var_120b749907b989aa[ i ];
        s_sp = var_adae4bc24d47644a[ i % var_adae4bc24d47644a.size ];
        player.var_26b67f70dd8a8e2 = s_sp.origin;
        player.var_b19a196b63273215 = s_sp.angles ?? ( 0, 0, 0 );
        player.var_d3588be4e6b2826b = s_sp.origin;
        player.var_353b74dfc75e8c1c = s_sp.angles ?? ( 0, 0, 0 );
        player.var_cb8b495511d894b = 0;
        player.var_a39e900ed6beb15c = 0;
        player.var_7de9dad92628deb5 = 0;
        player.var_138ae2791843b3a = gettime();
        player.var_9843766b4b99a75f = gettime();
        player setorigin( s_sp.origin );
        player setplayerangles( player.var_b19a196b63273215 );
    }
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        player zm_utility::function_d47920bb0d5fa327( "hornet_eeneigh_startobstaclecourse" );
        player zm_utility::function_92275a9d3969d91d();
        player giveweapon( level.defaultfist );
        player switchtoweaponimmediate( level.defaultfist );
        player val::set( "neigh_course", "ignoreme", 1 );
        player val::set( "neigh_course", "crouch", 0 );
        player val::set( "neigh_course", "prone", 0 );
        player val::set( "neigh_course", "show_hud", 0 );
        player val::set( "neigh_course", "interactions", 0 );
        player val::set( "neigh_course", "killstreaks", 0 );
        player val::set( "neigh_course", "gesture", 0 );
        player val::set( "neigh_course", "sprint", 0 );
        player val::set( "neigh_course", "supersprint", 0 );
        player val::set( "neigh_course", "damage", 0 );
        player setclientomnvar( "ui_show_quest_ui_nohud", 1 );
        n_scale = getdvarfloat( @"hash_70586d4f0bbd58a5", 10 );
        var_b1cefd58db2c3f78 = utility::spawn_model( %"accessory_dmz_origami_horse", player.origin, ( 0, 0, player.angles[ 2 ] ), undefined, n_scale );
        var_b1cefd58db2c3f78 linkto( player, "j_mainroot", ( -33, -10, 0 ), ( 180, 90, 90 ) );
        player.var_91dc53b06fbdc108 = var_b1cefd58db2c3f78;
    }
    
    zm_round_spawning::pause_round_spawning( 1, "neigh_course" );
    level.var_dc81f03d76612023 = 1;
    zm_utility::util_kill_all_zombies();
    level thread spawn_boulders();
    level.ee_neigh.var_f7771bf5ccfb5e46 = 0;
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        player thread function_8407d73bf0b6dffc();
    }
    
    level waittill( #"hash_2140110a768a2b1d" );
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        player val::reset( "neigh_course", "sprint" );
        player val::reset( "neigh_course", "supersprint" );
        player zm_quest::function_fba942a1cfd85f5d( 1, 0, #"hornet_ee_neigh", #"neigh_tracker" );
        player zm_quest::function_fb3af5600f6a9441( 2, 0, #"hornet_ee_neigh", #"neigh_tracker" );
        player zm_quest::function_612a9ad0db22c29c( 180000, 0, #"hornet_ee_neigh", #"neigh_tracker" );
        player.var_2b55cac6ce5fa721 = 180;
        player thread function_fbbcb1d5f3fda41b();
    }
    
    function_8aaca7d78a551137( 0 );
    level thread function_d437250ad8761760();
    level thread function_a8fabe9737a64017();
    level thread function_2e32536203fb6fc();
    level thread function_94e8710dc49e2d33();
    level thread function_80def003a14bf4f2();
    level thread spawn_gates();
    level thread monitor_kill_triggers();
    level thread function_3ced44dad5c7f5b9();
    level thread monitor_checkpoints();
    level thread function_b80cc12eb6574095();
    level thread course_timer();
    level.ee_neigh.a_barrier_scriptables = [];
    a_barrier_structs = utility::getstructarray( "nei_xb_bl", "targetname" );
    
    foreach ( var_dff548c3090b7c3b in a_barrier_structs )
    {
        scriptable = spawnscriptable( %"zm_sat_hornet_shs", var_dff548c3090b7c3b.origin, var_dff548c3090b7c3b.angles );
        scriptable setscriptablepartstate( "model", "barrier" );
        level.ee_neigh.a_barrier_scriptables[ level.ee_neigh.a_barrier_scriptables.size ] = scriptable;
    }
    
    level.ee_neigh.floor_lava = getent( "nei_fl_lava_pt", "targetname" );
    
    if ( level.ee_neigh.floor_lava )
    {
        if ( !isdefined( level.ee_neigh.floor_lava.initial_pos ) )
        {
            level.ee_neigh.floor_lava.initial_pos = level.ee_neigh.floor_lava.origin;
        }
        
        level.ee_neigh.floor_lava.origin += ( 0, 0, 256 );
    }
    
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"assault_round" );
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        level thread function_adaf65c1da5d3917( player );
    }
    
    level thread function_c2e2c885fb582cf();
    level waittill( #"neigh_course_end" );
    function_b973c7a9937e1b97();
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x5cf1ed18, Offset: 0x2205
// Size: 0xae
function private function_c2e2c885fb582cf()
{
    level endon( #"neigh_course_end" );
    level utility::waittill_any( "force_end", "game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player.var_91dc53b06fbdc108 )
        {
            player.var_91dc53b06fbdc108 delete();
        }
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x52a51a18, Offset: 0x22bb
// Size: 0x40
function private course_timer()
{
    level endon( #"neigh_course_end" );
    wait 182;
    musicbank_utility::function_5aca66c390aa347d( level.ee_neigh.var_120b749907b989aa, #"assault_round_fail" );
    level notify( #"neigh_course_end" );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x94ed6ac9, Offset: 0x2303
// Size: 0x81
function private function_fbbcb1d5f3fda41b()
{
    level endon( #"neigh_course_end" );
    self endon( #"death_or_disconnect" );
    n_start_time = gettime();
    
    while ( true )
    {
        n_elapsed_ms = gettime() - n_start_time;
        n_remaining_ms = 180000 - n_elapsed_ms;
        
        if ( n_remaining_ms < 0 )
        {
            n_remaining_ms = 0;
        }
        
        zm_quest::function_612a9ad0db22c29c( n_remaining_ms, 0, #"hornet_ee_neigh", #"neigh_tracker" );
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xddf02e89, Offset: 0x238c
// Size: 0x1e9
function private function_b80cc12eb6574095()
{
    level endon( #"neigh_course_end" );
    [ t_end ] = getnoentvolumearray( "nei_en_tr", "targetname" );
    
    while ( true )
    {
        foreach ( player in level.ee_neigh.var_120b749907b989aa )
        {
            if ( !player.var_cb8b495511d894b && player istouching( t_end ) )
            {
                player.var_cb8b495511d894b = 1;
                level.ee_neigh.n_players_finished++;
                
                if ( !isdefined( level.ee_neigh.var_d411d90059ee3b1 ) )
                {
                    level.ee_neigh.var_d411d90059ee3b1 = player;
                }
                
                player playsoundtoplayer( "evt_neigh_race_player_finish", player );
                function_8aaca7d78a551137( 0 );
                
                if ( level.ee_neigh.n_players_finished < level.ee_neigh.var_120b749907b989aa.size )
                {
                    player val::reset( "neigh_course", "show_hud" );
                    player setclientomnvar( "ui_show_quest_ui_nohud", 0 );
                    player zm_live_spectate::function_5647f60a40d71849();
                }
            }
        }
        
        if ( level.ee_neigh.n_players_finished >= level.ee_neigh.var_120b749907b989aa.size )
        {
            level musicbank_utility::function_5aca66c390aa347d( level.ee_neigh.var_120b749907b989aa, #"assault_round_success" );
            level notify( #"neigh_course_end" );
            return;
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xe4de73ec, Offset: 0x257d
// Size: 0xe1
function private function_adaf65c1da5d3917( player )
{
    level endon( #"game_ended" );
    level endon( #"neigh_course_end" );
    player waittill( #"disconnect" );
    
    if ( player.var_91dc53b06fbdc108 )
    {
        player.var_91dc53b06fbdc108 delete();
        player.var_91dc53b06fbdc108 = undefined;
    }
    
    level.ee_neigh.var_120b749907b989aa = function_5713d46873b29625( level.ee_neigh.var_120b749907b989aa );
    
    if ( level.ee_neigh.n_players_finished >= level.ee_neigh.var_120b749907b989aa.size )
    {
        level musicbank_utility::function_5aca66c390aa347d( level.ee_neigh.var_120b749907b989aa, #"assault_round_success" );
        level notify( #"neigh_course_end" );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xe8065d7a, Offset: 0x2666
// Size: 0x744
function private function_b973c7a9937e1b97()
{
    level utility::flag_clear( "neigh_ee_active" );
    level.ee_neigh.var_eb302e9eae9188ff = undefined;
    
    foreach ( e_boulder in level.ee_neigh.var_9cbed8e6013eb6bf )
    {
        if ( e_boulder )
        {
            e_boulder delete();
        }
    }
    
    level.ee_neigh.var_9cbed8e6013eb6bf = [];
    
    foreach ( var_4e8fbabf1c147e78 in level.ee_neigh.var_2a34c694da73096f )
    {
        if ( var_4e8fbabf1c147e78 )
        {
            var_4e8fbabf1c147e78 delete();
        }
    }
    
    level.ee_neigh.var_2a34c694da73096f = [];
    
    foreach ( scriptable in level.ee_neigh.var_2d24383a92e9330f )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.ee_neigh.var_2d24383a92e9330f = [];
    
    foreach ( scriptable in level.ee_neigh.a_barrier_scriptables )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.ee_neigh.a_barrier_scriptables = [];
    
    foreach ( scriptable in level.ee_neigh.var_5d2058cee3f9ff9a )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.ee_neigh.var_5d2058cee3f9ff9a = [];
    
    foreach ( scriptable in level.ee_neigh.var_2f54b195676ac0da )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.ee_neigh.var_2f54b195676ac0da = [];
    
    if ( level.ee_neigh.e_horse )
    {
        level.ee_neigh.e_horse notify( #"stop_bobbing" );
    }
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        player thread zm_utility::white_screen_flash( 0.5, 0.5 );
    }
    
    if ( level.ee_neigh.floor_lava )
    {
        level.ee_neigh.floor_lava.origin = level.ee_neigh.floor_lava.initial_pos;
    }
    
    foreach ( scriptable in level.ee_neigh.a_barrier_scriptables )
    {
        if ( scriptable )
        {
            scriptable freescriptable();
        }
    }
    
    level.ee_neigh.a_barrier_scriptables = [];
    wait 0.25;
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        level thread function_bb08036222e38e29( player );
    }
    
    zm_round_spawning::pause_round_spawning( 0, "neigh_course" );
    level.var_dc81f03d76612023 = 0;
    var_38f263c662c325c8 = 0;
    var_389e0a5b69c64745 = [];
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        if ( player && player.var_cb8b495511d894b )
        {
            var_389e0a5b69c64745[ var_389e0a5b69c64745.size ] = player;
            var_38f263c662c325c8 = 1;
            break;
        }
    }
    
    function_8aaca7d78a551137( 1, var_389e0a5b69c64745 );
    
    if ( var_38f263c662c325c8 )
    {
        give_rewards();
    }
    else
    {
        foreach ( player in level.ee_neigh.var_120b749907b989aa )
        {
            player playsoundtoplayer( "evt_fail_stinger", player );
        }
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"hornet_ee_neigh", #"hash_376befa68d49635d", zm_utility::get_round_number() );
    level thread function_a272d85db94961cc( 5 );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xc4d5fa68, Offset: 0x2db2
// Size: 0x1be
function private function_bb08036222e38e29( player )
{
    player endon( #"death_or_disconnect" );
    player zm_live_spectate::function_794d0c5793d9aed3();
    wait 0.25;
    
    if ( player.sessionstate != "spectator" && isdefined( player.var_26b67f70dd8a8e2 ) )
    {
        player setorigin( player.var_26b67f70dd8a8e2 );
        player setplayerangles( player.var_b19a196b63273215 );
    }
    
    player enableoffhandweapons();
    player zm_utility::function_663d59490abc834f();
    player val::reset( "neigh_course", "ignoreme" );
    player val::reset( "neigh_course", "crouch" );
    player val::reset( "neigh_course", "prone" );
    player val::reset( "neigh_course", "show_hud" );
    player val::reset( "neigh_course", "interactions" );
    player val::reset( "neigh_course", "killstreaks" );
    player val::reset( "neigh_course", "gesture" );
    player val::reset( "neigh_course", "sprint" );
    player val::reset( "neigh_course", "supersprint" );
    player val::reset( "neigh_course", "damage" );
    player setclientomnvar( "ui_show_quest_ui_nohud", 0 );
    player zm_quest::function_fba942a1cfd85f5d( 0, 0, #"hornet_ee_neigh", #"neigh_tracker" );
    player zm_quest::function_fb3af5600f6a9441( 0, 0, #"hornet_ee_neigh", #"neigh_tracker" );
    
    if ( player.var_91dc53b06fbdc108 )
    {
        player.var_91dc53b06fbdc108 unlink();
        player.var_91dc53b06fbdc108 delete();
        player.var_91dc53b06fbdc108 = undefined;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x50af5c5e, Offset: 0x2f78
// Size: 0x11f
function private function_585a8cfd5c1dd3d4()
{
    if ( !level.ee_neigh.e_horse )
    {
        return;
    }
    
    level.ee_neigh.e_horse notify( #"stop_bobbing" );
    level.ee_neigh.a_spawned_models = arrayremove( level.ee_neigh.a_spawned_models, level.ee_neigh.e_horse );
    level.ee_neigh.e_horse delete();
    s_horse = utility::getstruct( "nei_hr_init", "targetname" );
    level.ee_neigh.e_horse = utility::spawn_model( %"accessory_dmz_origami_horse", s_horse.origin, s_horse.angles );
    level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = level.ee_neigh.e_horse;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x257c9cb2, Offset: 0x309f
// Size: 0x122
function private function_c3d443462355c956()
{
    if ( !level.ee_neigh.e_horse )
    {
        return;
    }
    
    level.ee_neigh.a_spawned_models = arrayremove( level.ee_neigh.a_spawned_models, level.ee_neigh.e_horse );
    level.ee_neigh.e_horse delete();
    var_906d2fa4b282a644 = utility::getstruct( "nei_hr_int", "targetname" );
    level.ee_neigh.e_horse = utility::spawn_model( %"accessory_dmz_origami_horse", var_906d2fa4b282a644.origin, var_906d2fa4b282a644.angles );
    level.ee_neigh.a_spawned_models[ level.ee_neigh.a_spawned_models.size ] = level.ee_neigh.e_horse;
    level.ee_neigh.e_horse thread bob_entity( 8, 1.5 );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x59df9147, Offset: 0x31c9
// Size: 0x8b
function private function_a272d85db94961cc( var_b086e76cb5b8559f = 5 )
{
    level endon( #"game_ended" );
    function_585a8cfd5c1dd3d4();
    
    for ( i = 0; i < var_b086e76cb5b8559f ; i++ )
    {
        level waittill( #"on_round_start" );
    }
    
    function_c3d443462355c956();
    
    if ( level.ee_neigh.race_interact )
    {
        level.ee_neigh.race_interact.var_2103e9e2b7d4a14e = 0;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x14744027, Offset: 0x325c
// Size: 0x26d
function private give_rewards()
{
    level endon( #"game_ended" );
    a_trophies = [ %"sat_zm_arcxd_racing_trophy_1st", %"sat_zm_arcxd_racing_trophy_2nd", %"sat_zm_arcxd_racing_trophy_3rd", %"sat_zm_arcxd_racing_trophy_4th" ];
    var_57d84bdf95c88277 = [ "player_green", "player_yellow", "player_cyan", "player_pink" ];
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        if ( !player || !isalive( player ) )
        {
            continue;
        }
        
        trophy_index = function_1745b0def7c0a5e7( player.var_2b55cac6ce5fa721 );
        
        if ( trophy_index < 0 )
        {
            continue;
        }
        
        v_forward = anglestoforward( player.var_b19a196b63273215 );
        var_f3f5b23a3d26fbee = player.var_26b67f70dd8a8e2 + v_forward * 60 + ( 0, 0, 48 );
        mdl_trophy = spawnscriptable( a_trophies[ trophy_index ], var_f3f5b23a3d26fbee, player.var_b19a196b63273215 );
        waitframe();
        
        if ( !player || !mdl_trophy )
        {
            continue;
        }
        
        mdl_trophy utility::function_32b24db3127bff40( "base", "default" );
        mdl_trophy utility::function_32b24db3127bff40( "owner_fx", var_57d84bdf95c88277[ player.sessionuimemberindex ] );
        player.var_a6f0c8ebf32080d1 = trophy_index;
        mdl_trophy.cache_interact = create_reward_cache( mdl_trophy, player );
        player thread give_grace_period();
        mdl_trophy thread trophy_cleanup_watcher( player );
        mdl_trophy thread trophy_timeout_watcher( player );
        mdl_trophy thread function_fcced499f0d7aa8f();
        function_585a8cfd5c1dd3d4();
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
        
        if ( player == level.ee_neigh.var_d411d90059ee3b1 && trophy_index == 0 )
        {
            player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_hesd2_horsing_around_race_winner", #"bc_flavor_player_positive" );
            player thread function_1c59caff61293917();
        }
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xaab046b9, Offset: 0x34d1
// Size: 0x35
function private give_grace_period()
{
    self endon( #"death_or_disconnect" );
    val::set( "neigh_rewards", "ignoreme", 1 );
    wait 15;
    val::reset( "neigh_rewards", "ignoreme" );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0xd71b9026, Offset: 0x350e
// Size: 0x1f8
function private create_reward_cache( trophy, player )
{
    teddtasks::function_c404e4ff729071ca();
    mastery = get_reward_mastery( player.var_a6f0c8ebf32080d1 );
    var_d9906d678f78a3fa = teddtasks::get_loot_reward_list( mastery, level.roundscale );
    inventory_group = %"hash_30d1f71d3877d096";
    interact = common_cache::function_74364c32a1e82886( inventory_group, trophy.origin, 50, &function_753fde466ee90caa );
    
    if ( !isdefined( interact.cache.contents ) )
    {
        interact.cache.contents = [];
    }
    
    interact sethintonobstruction( "show" );
    var_aaf013937e69a716 = common_item::items_selectfromlist( var_d9906d678f78a3fa, randomintrange( 3, 4 ) );
    common_cache::function_61ef9e0b74e10aaf( interact.cache, var_aaf013937e69a716 );
    
    foreach ( item_name in var_aaf013937e69a716 )
    {
        common_cache::function_990ee9d9acd2d1d5( interact.cache, player, item_name, undefined, 1 );
    }
    
    foreach ( other in level.players )
    {
        if ( other && other != player )
        {
            interact disableplayeruse( other );
        }
    }
    
    return interact;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 4, eflags: 0x4
// Checksum 0x57e4c42a, Offset: 0x370f
// Size: 0x18c
function private spawn_reward_cache( position, var_8b5270de14dff72e, player, item_count )
{
    inventory_group = %"hash_30d1f71d3877d096";
    interact = common_cache::function_74364c32a1e82886( inventory_group, position, 50, &function_753fde466ee90caa );
    common_cache::function_61ef9e0b74e10aaf( interact.cache, var_8b5270de14dff72e );
    interact sethintonobstruction( "show" );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        item_name = var_8b5270de14dff72e[ i ];
        weapondata = undefined;
        
        if ( common_item::function_3cba34a99d02cd9( item_name ) == "weapon" )
        {
            scriptbundlestruct = getscriptbundlefieldvalues( item_name, [ #"baseweapon", #"rarity" ] );
            weaponname = scriptbundlestruct.baseweapon;
            rarity = scriptbundlestruct.rarity;
            favoriteweapon = player weaponmetadata::function_c68204eff69ed046( weaponname );
            
            if ( favoriteweapon )
            {
                item_name = item_weapon::function_3da93a43aae4473d( favoriteweapon.basename, rarity );
                weapondata = item_weapon::function_fdc74b9be99fda2f( favoriteweapon );
                weapondata.rarity = rarity;
                weapondata.weaponobj = favoriteweapon;
            }
        }
        
        skipomnvars = !isdefined( weapondata );
        common_cache::function_990ee9d9acd2d1d5( interact.cache, player, item_name, undefined, skipomnvars, undefined, weapondata );
    }
    
    return interact;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0xdad561b8, Offset: 0x38a4
// Size: 0x40
function private function_753fde466ee90caa( interact, player )
{
    return { #var_26bbd300351fde34:0, #string:&"shared_hintstrings/open_cache", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x70cf98ea, Offset: 0x38ed
// Size: 0x72
function private trophy_cleanup_watcher( owner )
{
    level endon( #"game_ended" );
    owner endon( #"death" );
    level endon( #"hash_612352874af0f5b" );
    
    while ( isdefined( self ) && isdefined( self.cache_interact ) )
    {
        if ( common_cache::iscontainerempty( self.cache_interact.cache ) )
        {
            break;
        }
        
        wait 0.5;
    }
    
    cleanup_trophy();
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x9ada419, Offset: 0x3967
// Size: 0x61
function private trophy_timeout_watcher( owner )
{
    level endon( #"game_ended" );
    owner endon( #"death" );
    self endon( #"death" );
    self endon( #"hash_d7aeb953c169e549" );
    wait 30;
    level notify( #"hash_612352874af0f5b" );
    owner notify( #"close_container" );
    waitframe();
    cleanup_trophy();
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xf593c01f, Offset: 0x39d0
// Size: 0x64
function private cleanup_trophy()
{
    if ( self )
    {
        self setscriptablepartstate( "base", "kill" );
        
        if ( self.root )
        {
            self.root delete();
        }
        
        if ( self.cache_interact )
        {
            self.cache_interact notify( #"death" );
            self.cache_interact delete();
        }
        
        self freescriptable();
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x9e181366, Offset: 0x3a3c
// Size: 0x86
function private function_fcced499f0d7aa8f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait_time = randomfloat( 1 );
    wait wait_time;
    
    if ( self )
    {
        if ( !self.root )
        {
            self.root = utility::spawn_model( "tag_origin", self.origin, self.angles );
            waitframe();
            self scriptablesetparententity( self.root );
        }
        
        self.root thread function_453b547e633da149();
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xd33ef93b, Offset: 0x3aca
// Size: 0x6f
function private function_453b547e633da149()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    self endon( #"death" );
    
    while ( self )
    {
        self movez( 5, 1, 0.5, 0.5 );
        self waittill( #"movedone" );
        self movez( -5, 1, 0.5, 0.5 );
        self waittill( #"movedone" );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xa9b5dcf7, Offset: 0x3b41
// Size: 0x161
function private spawn_boulders()
{
    level endon( #"neigh_course_end" );
    a_starts = utility::getstructarray( "nei_bold_start", "targetname" );
    a_paths = [];
    
    foreach ( s_start in a_starts )
    {
        var_d00b944707343dc9 = function_ddbd55140b8cbebc( s_start );
        a_paths[ a_paths.size ] = var_d00b944707343dc9;
    }
    
    while ( level.ee_neigh.var_eb302e9eae9188ff )
    {
        var_d00b944707343dc9 = a_paths[ randomint( a_paths.size ) ];
        e_boulder = utility::spawn_model( %"hash_1b8b4e4a006dcd3d", var_d00b944707343dc9[ 0 ], undefined, undefined, 3.75 );
        e_boulder solid();
        e_boulder playsoundonmovingent( "evt_orb_spawn" );
        e_boulder playloopsound( #"hash_148036b1e8c0283" );
        level.ee_neigh.var_9cbed8e6013eb6bf[ level.ee_neigh.var_9cbed8e6013eb6bf.size ] = e_boulder;
        e_boulder thread move_boulder( var_d00b944707343dc9 );
        level thread function_90d579f2b985ab7c( e_boulder );
        wait 5;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x5b06cb95, Offset: 0x3caa
// Size: 0x76
function private move_boulder( var_d00b944707343dc9 )
{
    self endon( #"death" );
    level endon( #"neigh_course_end" );
    thread function_e6729bfafe81fd1();
    utility::function_2159dd4196ff4b81( var_d00b944707343dc9, 18, 0, 0 );
    self notify( #"boulder_move_done" );
    level.ee_neigh.var_9cbed8e6013eb6bf = arrayremove( level.ee_neigh.var_9cbed8e6013eb6bf, self );
    self delete();
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x6e09babe, Offset: 0x3d28
// Size: 0xda
function private function_e6729bfafe81fd1()
{
    self endon( #"death" );
    self endon( #"boulder_move_done" );
    level endon( #"neigh_course_end" );
    v_last_origin = self.origin;
    var_1eeff2193b151cfd = 0;
    
    while ( true )
    {
        waitframe();
        var_18989edab1766136 = self.origin;
        v_delta = var_18989edab1766136 - v_last_origin;
        v_last_origin = var_18989edab1766136;
        var_b6081b1b6ba5e8b5 = length( ( v_delta[ 0 ], v_delta[ 1 ], 0 ) );
        
        if ( var_b6081b1b6ba5e8b5 < 0.01 )
        {
            continue;
        }
        
        v_dir = vectornormalize( ( v_delta[ 0 ], v_delta[ 1 ], 0 ) );
        var_5ea0f98dc8a9f1f4 = vectortoangles( v_dir )[ 1 ];
        var_1eeff2193b151cfd += var_b6081b1b6ba5e8b5 * 1;
        self.angles = ( var_1eeff2193b151cfd, var_5ea0f98dc8a9f1f4, 0 );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xb5d4f3a1, Offset: 0x3e0a
// Size: 0xe1
function private function_90d579f2b985ab7c( e_boulder )
{
    level endon( #"neigh_course_end" );
    
    while ( isdefined( e_boulder ) )
    {
        foreach ( player in level.players )
        {
            if ( player.var_cb8b495511d894b || player.var_a39e900ed6beb15c )
            {
                continue;
            }
            
            if ( distance( player.origin, e_boulder.origin ) <= 110 )
            {
                player thread function_f584cadef78f0177( e_boulder );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xb8d6eb4d, Offset: 0x3ef3
// Size: 0x2f
function private function_f584cadef78f0177( e_boulder )
{
    self endon( #"death_or_disconnect" );
    
    if ( self.var_a39e900ed6beb15c )
    {
        return;
    }
    
    function_8ccece58aaed9eea( self, e_boulder );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 4, eflags: 0x4
// Checksum 0x8b7aab7e, Offset: 0x3f2a
// Size: 0x1a4
function private function_8ccece58aaed9eea( player, killer_ent, var_5d2ecef1741b48d8 = 500, b_shellshock = 1 )
{
    player.var_a39e900ed6beb15c = 1;
    
    if ( killer_ent && var_5d2ecef1741b48d8 )
    {
        v_to_killer = vectornormalize( killer_ent.origin - player.origin ) + ( 0, 0, 0.5 );
        player knockback( v_to_killer, var_5d2ecef1741b48d8 );
    }
    
    if ( b_shellshock )
    {
        player shellshock( %"frag_grenade_mp", 2, 0 );
    }
    
    player dodamage( 50, player.origin );
    player thread zm_utility::white_screen_flash( 0.25, 0.25 );
    player playsoundtoplayer( "evt_fail_stinger", player );
    scriptable_mask = spawnscriptable( %"zm_sat_hornet_shs", player.origin, player.angles );
    scriptable_mask setscriptablepartstate( "fx", "mask" );
    playsoundatpos( player.origin, "evt_trail_impact" );
    scriptable_mask utility::delaycall( 1, &freescriptable );
    wait 0.25;
    player val::set( "neigh_course", "freezecontrols", 1 );
    player setorigin( player.var_d3588be4e6b2826b );
    player setplayerangles( player.var_353b74dfc75e8c1c );
    wait 0.25;
    player val::reset( "neigh_course", "freezecontrols" );
    player.var_a39e900ed6beb15c = 0;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x9e863ee2, Offset: 0x40d6
// Size: 0x340
function private function_a8fabe9737a64017()
{
    level endon( #"neigh_course_end" );
    level utility::flag_wait( "scriptables_ready" );
    var_1e0c40719c463771 = utility::getstructarray( "nei_shs_jump", "targetname" );
    a_groups = [];
    var_bbfe98f9bd7c0121 = [];
    
    foreach ( s_sushi in var_1e0c40719c463771 )
    {
        if ( s_sushi.script_noteworthy )
        {
            key = s_sushi.script_noteworthy;
            
            if ( !isdefined( a_groups[ key ] ) )
            {
                a_groups[ key ] = [];
            }
            
            a_groups[ key ][ a_groups[ key ].size ] = s_sushi;
            continue;
        }
        
        var_bbfe98f9bd7c0121[ var_bbfe98f9bd7c0121.size ] = s_sushi;
    }
    
    a_safe_structs = [];
    var_c05225eadb335d26 = getarraykeys( a_groups );
    
    foreach ( key in var_c05225eadb335d26 )
    {
        a_group = a_groups[ key ];
        n_safe = a_group.size >= 5 ? 3 : 2;
        n_safe = int( min( n_safe, a_group.size ) );
        var_cab2133239866a17 = a_group;
        
        if ( a_group.size > n_safe )
        {
            var_cab2133239866a17 = utility::array_random_slice( a_group, n_safe );
        }
        
        foreach ( s in var_cab2133239866a17 )
        {
            a_safe_structs[ a_safe_structs.size ] = s;
        }
    }
    
    foreach ( s_sushi in var_1e0c40719c463771 )
    {
        scriptable = spawnscriptable( %"zm_sat_hornet_shs", s_sushi.origin, s_sushi.angles );
        scriptable setscriptablepartstate( "model", "sbag" );
        level.ee_neigh.var_2d24383a92e9330f[ level.ee_neigh.var_2d24383a92e9330f.size ] = scriptable;
        
        if ( s_sushi.script_noteworthy )
        {
            var_4049f28afc041bd8 = !arraycontains( a_safe_structs, s_sushi );
        }
        else
        {
            var_4049f28afc041bd8 = randomfloat( 1 ) <= 0.7;
        }
        
        scriptable thread function_e39f239f687ab4c1( var_4049f28afc041bd8 );
        waitframe();
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x17142636, Offset: 0x441e
// Size: 0x18f
function private function_e39f239f687ab4c1( var_4049f28afc041bd8 )
{
    self endon( #"death" );
    level endon( #"neigh_course_end" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.var_cb8b495511d894b )
            {
                continue;
            }
            
            var_f1b807e36f506e21 = distance2d( player.origin, self.origin );
            var_b0a681d77fccb76d = player.origin[ 2 ] - self.origin[ 2 ];
            n_speed = length( player getvelocity() );
            
            if ( var_f1b807e36f506e21 <= 32 && var_b0a681d77fccb76d >= 8 && n_speed <= 20 )
            {
                if ( var_4049f28afc041bd8 )
                {
                    player thread function_c980be0ed135bc1a();
                    level.ee_neigh.var_2d24383a92e9330f = arrayremove( level.ee_neigh.var_2d24383a92e9330f, self );
                    playsoundatpos( self.origin, "evt_neigh_race_platform_disappear" );
                    self setscriptablepartstate( "fx", "dest" );
                    wait 1;
                    self freescriptable();
                    return;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x983d12ca, Offset: 0x45b5
// Size: 0x9b
function private function_2e32536203fb6fc()
{
    level endon( #"neigh_course_end" );
    var_a6dc2a4ab9e1f958 = utility::getstructarray( "nei_fgro_sta", "targetname" );
    
    foreach ( s_start in var_a6dc2a4ab9e1f958 )
    {
        level thread fish_spawner( s_start );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xde35a579, Offset: 0x4658
// Size: 0xeb
function private fish_spawner( s_start )
{
    level endon( #"neigh_course_end" );
    var_d00b944707343dc9 = function_ddbd55140b8cbebc( s_start );
    fish_model = s_start.model;
    
    while ( level.ee_neigh.var_eb302e9eae9188ff )
    {
        n_delay = 0 + randomfloat( 0.75 );
        wait n_delay;
        var_4e8fbabf1c147e78 = utility::spawn_model( %"hash_60c5c17e2f787876", var_d00b944707343dc9[ 0 ], s_start.angles );
        var_4e8fbabf1c147e78 solid();
        var_4e8fbabf1c147e78 playsoundonmovingent( "evt_neigh_race_fish_jump" );
        level.ee_neigh.var_2a34c694da73096f[ level.ee_neigh.var_2a34c694da73096f.size ] = var_4e8fbabf1c147e78;
        level thread function_e29ed8de2d927e31( var_4e8fbabf1c147e78 );
        var_4e8fbabf1c147e78 move_fish( var_d00b944707343dc9 );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xaa35231, Offset: 0x474b
// Size: 0x8b
function private move_fish( var_d00b944707343dc9 )
{
    self endon( #"death" );
    level endon( #"neigh_course_end" );
    self rotateby( ( 0, 0, 180 ), 2, 0.5, 0.5 );
    utility::function_8001268940441423( var_d00b944707343dc9[ 0 ], var_d00b944707343dc9[ 4 ], var_d00b944707343dc9[ 2 ], 2, 1 );
    level.ee_neigh.var_2a34c694da73096f = arrayremove( level.ee_neigh.var_2a34c694da73096f, self );
    self delete();
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xf6682ab8, Offset: 0x47de
// Size: 0xa1
function private function_94e8710dc49e2d33()
{
    level endon( #"neigh_course_end" );
    var_70af07b5fca16ce4 = utility::getstructarray( "rvr_sp_prt", "targetname" );
    
    while ( level.ee_neigh.var_eb302e9eae9188ff )
    {
        n_count = int( min( 7, var_70af07b5fca16ce4.size ) );
        a_spawns = utility::array_random_slice( var_70af07b5fca16ce4, n_count );
        
        for ( i = 0; i < a_spawns.size ; i++ )
        {
            s_spawn = a_spawns[ i ];
            level thread spawn_portal_fish( s_spawn );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x311ca1da, Offset: 0x4887
// Size: 0x1cd
function private spawn_portal_fish( s_spawn )
{
    level endon( #"neigh_course_end" );
    portal = spawnscriptable( %"zm_sat_hornet_shs", s_spawn.origin, s_spawn.angles ?? ( 0, 0, 0 ) );
    
    if ( portal )
    {
        portal utility::function_7c10ea82c1e305b8( "model", "invis" );
        portal utility::function_7c10ea82c1e305b8( "fx", "prt" );
        level thread function_4a377d2e6dcaecca( portal );
    }
    
    wait 0.5;
    fish_angles = ( 0, randomint( 360 ), 90 );
    var_4e8fbabf1c147e78 = utility::spawn_model( %"hash_60c5c17e2f787876", s_spawn.origin, fish_angles );
    level.ee_neigh.var_2a34c694da73096f[ level.ee_neigh.var_2a34c694da73096f.size ] = var_4e8fbabf1c147e78;
    var_4e8fbabf1c147e78 playloopsound( #"hash_d23e5b51fb89f414" );
    level thread function_e29ed8de2d927e31( var_4e8fbabf1c147e78 );
    v_ground = physicstrace( s_spawn.origin, s_spawn.origin + ( 0, 0, -5000 ) );
    var_81c2bb4dfe4e0ea7 = 0.625;
    var_4e8fbabf1c147e78 moveto( v_ground, 1.25, var_81c2bb4dfe4e0ea7, 0 );
    var_4e8fbabf1c147e78 waittill( #"movedone" );
    var_c839fc5e04a31a4f = spawnscriptable( %"zm_sat_hornet_shs", var_4e8fbabf1c147e78.origin, ( 0, 0, 0 ) );
    var_c839fc5e04a31a4f utility::function_7c10ea82c1e305b8( "fx", "fsh_explo" );
    var_c839fc5e04a31a4f utility::delaycall( 1, &freescriptable );
    
    if ( var_4e8fbabf1c147e78 )
    {
        var_4e8fbabf1c147e78 delete();
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x8a6a45d2, Offset: 0x4a5c
// Size: 0x55
function private function_4a377d2e6dcaecca( portal )
{
    portal endon( #"deleted" );
    off_state_len = 0.75;
    wait 2.5 - off_state_len;
    
    if ( portal )
    {
        portal utility::function_7c10ea82c1e305b8( "fx", "off" );
        wait off_state_len;
        portal freescriptable();
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xa7158e5f, Offset: 0x4ab9
// Size: 0xe1
function private function_e29ed8de2d927e31( var_4e8fbabf1c147e78 )
{
    level endon( #"neigh_course_end" );
    
    while ( isdefined( var_4e8fbabf1c147e78 ) )
    {
        foreach ( player in level.players )
        {
            if ( player.var_cb8b495511d894b || player.var_a39e900ed6beb15c )
            {
                continue;
            }
            
            if ( distance( player.origin, var_4e8fbabf1c147e78.origin ) <= 100 )
            {
                player thread function_cd4dd7c14c482518( var_4e8fbabf1c147e78 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x5e18342d, Offset: 0x4ba2
// Size: 0x32
function private function_cd4dd7c14c482518( var_4e8fbabf1c147e78 )
{
    self endon( #"death_or_disconnect" );
    
    if ( self.var_a39e900ed6beb15c )
    {
        return;
    }
    
    function_8ccece58aaed9eea( self, var_4e8fbabf1c147e78, 700 );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x8f4eeda7, Offset: 0x4bdc
// Size: 0x1a7
function private monitor_checkpoints()
{
    level endon( #"neigh_course_end" );
    var_281b801ba305c40 = getnoentvolumearray( "nei_ckp", "targetname" );
    
    while ( level.ee_neigh.var_eb302e9eae9188ff )
    {
        foreach ( player in level.players )
        {
            if ( player.var_cb8b495511d894b )
            {
                continue;
            }
            
            foreach ( t_ckp in var_281b801ba305c40 )
            {
                if ( player istouching( t_ckp ) )
                {
                    var_dac75f4116c98678 = t_ckp.origin;
                    
                    if ( player.var_d3588be4e6b2826b != var_dac75f4116c98678 )
                    {
                        player.var_d3588be4e6b2826b = var_dac75f4116c98678;
                        player.var_353b74dfc75e8c1c = player getplayerangles();
                        player.var_7de9dad92628deb5++;
                        player.var_9843766b4b99a75f = gettime();
                        player playsoundtoplayer( "evt_neigh_race_checkpoint", player );
                    }
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xc879a29d, Offset: 0x4d8b
// Size: 0xc3
function private function_d437250ad8761760()
{
    level endon( #"neigh_course_end" );
    
    while ( true )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( player && !player.var_cb8b495511d894b && player.var_2b55cac6ce5fa721 > 0 )
            {
                player.var_2b55cac6ce5fa721--;
            }
        }
        
        function_8aaca7d78a551137( 0 );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x1246ccbb, Offset: 0x4e56
// Size: 0x137
function private function_1e57a5c8be4b5d8f()
{
    a_players = function_947f146055b3f75a();
    
    for ( i = 0; i < a_players.size ; i++ )
    {
        for ( j = i + 1; j < a_players.size ; j++ )
        {
            if ( a_players[ j ].var_2b55cac6ce5fa721 > a_players[ i ].var_2b55cac6ce5fa721 )
            {
                temp = a_players[ i ];
                a_players[ i ] = a_players[ j ];
                a_players[ j ] = temp;
            }
        }
    }
    
    var_c119277103990614 = [];
    
    foreach ( index, player in a_players )
    {
        result_info = { #score:player.var_2b55cac6ce5fa721, #player:player, #rank:index };
        var_c119277103990614[ var_c119277103990614.size ] = result_info;
    }
    
    return var_c119277103990614;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0xf273c3d7, Offset: 0x4f96
// Size: 0x6a
function private function_8aaca7d78a551137( b_final = 0, var_389e0a5b69c64745 )
{
    leaderboard_info = function_1e57a5c8be4b5d8f();
    zm_quest::function_e4996840a6b66669( leaderboard_info );
    a_players = function_947f146055b3f75a();
    
    if ( b_final && var_389e0a5b69c64745 )
    {
        a_players = var_389e0a5b69c64745;
    }
    
    if ( a_players.size > 1 )
    {
        zm_quest::function_b507b93ea423985d( b_final, a_players );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xcdff754c, Offset: 0x5008
// Size: 0x95
function private function_947f146055b3f75a()
{
    a_players = [];
    
    foreach ( player in level.ee_neigh.var_120b749907b989aa )
    {
        if ( player )
        {
            a_players[ a_players.size ] = player;
        }
    }
    
    return a_players;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x6ce5d7a6, Offset: 0x50a6
// Size: 0x2d
function private function_1745b0def7c0a5e7( var_5d20c1ef1a4cec09 )
{
    if ( var_5d20c1ef1a4cec09 > 90 )
    {
        return 0;
    }
    
    if ( var_5d20c1ef1a4cec09 >= 60 )
    {
        return 1;
    }
    
    if ( var_5d20c1ef1a4cec09 > 0 )
    {
        return 2;
    }
    
    return -1;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x70d5d9ea, Offset: 0x50dc
// Size: 0x23
function private get_reward_mastery( trophy_index )
{
    if ( trophy_index == 0 )
    {
        return 3;
    }
    
    if ( trophy_index == 1 )
    {
        return 2;
    }
    
    return 1;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x2f52e4de, Offset: 0x5108
// Size: 0x49
function private function_c980be0ed135bc1a()
{
    self endon( #"death_or_disconnect" );
    
    if ( self.var_a39e900ed6beb15c || !utility::time_has_passed( self.var_138ae2791843b3a, 1 ) )
    {
        return;
    }
    
    self.var_138ae2791843b3a = gettime();
    function_8ccece58aaed9eea( self, undefined, undefined, 0 );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xd1a024, Offset: 0x5159
// Size: 0x156
function private monitor_kill_triggers()
{
    level endon( #"neigh_course_end" );
    var_91bed5636f5f050d = getnoentvolumearray( "nei_kill_tr", "targetname" );
    
    while ( level.ee_neigh.var_eb302e9eae9188ff )
    {
        foreach ( player in level.players )
        {
            if ( player.var_cb8b495511d894b || player.var_a39e900ed6beb15c )
            {
                continue;
            }
            
            foreach ( var_90314262f5c7a343 in var_91bed5636f5f050d )
            {
                if ( player istouching( var_90314262f5c7a343 ) && player function_5ccbbd3ec3872313() )
                {
                    player thread function_c980be0ed135bc1a();
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xa789c94d, Offset: 0x52b7
// Size: 0xf1
function private function_3ced44dad5c7f5b9()
{
    level endon( #"neigh_course_end" );
    
    while ( level.ee_neigh.var_eb302e9eae9188ff )
    {
        foreach ( player in level.players )
        {
            if ( player.var_cb8b495511d894b || player.var_a39e900ed6beb15c )
            {
                continue;
            }
            
            if ( isdefined( player.var_d682d30b84057103 ) && player.var_d682d30b84057103 )
            {
                player.var_d682d30b84057103 = 0;
                player thread function_c980be0ed135bc1a();
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x99fa3ab3, Offset: 0x53b0
// Size: 0x112
function private function_80def003a14bf4f2()
{
    level endon( #"neigh_course_end" );
    var_5ecfa3f9e8495268 = utility::getstructarray( "nei_fl_thr", "targetname" );
    
    foreach ( var_eb19c241b900a36b in var_5ecfa3f9e8495268 )
    {
        scriptable = spawnscriptable( %"zm_sat_hornet_shs", var_eb19c241b900a36b.origin, var_eb19c241b900a36b.angles + ( -90, 0, 0 ) );
        scriptable setscriptablepartstate( "model", "invis" );
        level.ee_neigh.var_5d2058cee3f9ff9a[ level.ee_neigh.var_5d2058cee3f9ff9a.size ] = scriptable;
        scriptable thread flame_cycle();
        waitframe();
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xd0171da5, Offset: 0x54ca
// Size: 0x189
function private flame_cycle()
{
    self endon( #"death" );
    level endon( #"neigh_course_end" );
    
    while ( true )
    {
        n_wait = 3 + randomfloat( 2 );
        wait n_wait;
        self setscriptablepartstate( "fx", "fla" );
        var_3fc8254e9a5f5d33 = 2 + randomfloat( 2 );
        n_elapsed = 0;
        
        while ( n_elapsed < var_3fc8254e9a5f5d33 )
        {
            foreach ( player in level.players )
            {
                if ( player.var_cb8b495511d894b || player.var_a39e900ed6beb15c )
                {
                    continue;
                }
                
                dist_xy = distance2d( player.origin, self.origin );
                height_above = player.origin[ 2 ] - self.origin[ 2 ];
                
                if ( dist_xy <= 75 && height_above >= 0 && height_above <= 150 )
                {
                    player thread function_c980be0ed135bc1a();
                }
            }
            
            wait 0.1;
            n_elapsed += 0.1;
        }
        
        self setscriptablepartstate( "fx", "none" );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xfa2d7f90, Offset: 0x565b
// Size: 0x12b
function private spawn_gates()
{
    var_b84bfd76b92aa0a8 = utility::getstructarray( "nei_gate", "targetname" );
    
    foreach ( var_4ed46be95235b8ff in var_b84bfd76b92aa0a8 )
    {
        gate = spawnscriptable( %"zm_sat_hornet_shs", var_4ed46be95235b8ff.origin, var_4ed46be95235b8ff.angles + ( 0, 180, 0 ) );
        gate utility::function_7c10ea82c1e305b8( "model", "invis" );
        state = var_4ed46be95235b8ff.script_noteworthy ?? "gate";
        gate utility::function_7c10ea82c1e305b8( "fx", state );
        level.ee_neigh.var_2f54b195676ac0da[ level.ee_neigh.var_2f54b195676ac0da.size ] = gate;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xd1fd12b8, Offset: 0x578e
// Size: 0x70
function private function_ddbd55140b8cbebc( s_start )
{
    var_d00b944707343dc9 = [ s_start.origin ];
    var_24c350963fd9a36d = s_start;
    
    while ( var_24c350963fd9a36d.target )
    {
        var_24c350963fd9a36d = utility::getstruct( var_24c350963fd9a36d.target, "targetname" );
        var_d00b944707343dc9[ var_d00b944707343dc9.size ] = var_24c350963fd9a36d.origin;
    }
    
    return var_d00b944707343dc9;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0xf1762fd0, Offset: 0x5807
// Size: 0xb7
function private bob_entity( var_51ef870503967f06 = 8, var_dc58879cfee40e71 = 1.5 )
{
    self endon( #"death" );
    self endon( #"stop_bobbing" );
    
    for ( n_count = 0; true ; n_count = 0 )
    {
        self movez( var_51ef870503967f06, var_dc58879cfee40e71, 0.5, 0.5 );
        self waittill( #"movedone" );
        self movez( var_51ef870503967f06 * -1, var_dc58879cfee40e71, 0.5, 0.5 );
        self waittill( #"movedone" );
        n_count++;
        
        if ( n_count == 4 )
        {
            self playsound( #"hash_7e7f40bc01f625a8" );
        }
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xcecb2abb, Offset: 0x58c6
// Size: 0x39, Type: bool
function private function_5ccbbd3ec3872313()
{
    ground_ent = self getgroundentity();
    
    if ( ground_ent.targetname )
    {
        if ( ground_ent.targetname == "nei_fl_lava_pt" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x7ccf0bb1, Offset: 0x5908
// Size: 0x115
function private function_8407d73bf0b6dffc()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( !self || !isplayer( self ) || !isalive( self ) )
    {
        return;
    }
    
    val::set( "neigh_course", "freezecontrols", 1 );
    level.ee_neigh.ui_start_countdown namespace_2918ad6c52d71794::open( self );
    level.ee_neigh.ui_start_countdown namespace_2918ad6c52d71794::set_remain_time( self, 5 );
    
    if ( !level.ee_neigh.var_f7771bf5ccfb5e46 )
    {
        level.ee_neigh.var_f7771bf5ccfb5e46 = 1;
        level thread function_91a4886d1cbf3449( 5 );
        level thread function_2f0438a77012e97e();
    }
    
    level waittill( #"hash_2140110a768a2b1d" );
    
    if ( self )
    {
        level.ee_neigh.ui_start_countdown namespace_2918ad6c52d71794::close( self );
    }
    
    level.ee_neigh.var_f7771bf5ccfb5e46 = 0;
    
    if ( self )
    {
        val::reset( "neigh_course", "freezecontrols" );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x2b5165, Offset: 0x5a25
// Size: 0x79
function private function_2f0438a77012e97e()
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < 5 ; i++ )
    {
        i_time_left = 5 - i;
        
        if ( i_time_left <= 3 )
        {
            playsoundatpos( ( 0, 0, 0 ), #"hash_a87b966a24b69272" );
        }
        
        wait 1;
    }
    
    playsoundatpos( ( 0, 0, 0 ), #"hash_62ad722ea56f8dbd" );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x8bc6874e, Offset: 0x5aa6
// Size: 0x27
function private function_91a4886d1cbf3449( time )
{
    level endon( #"game_ended" );
    wait time;
    level notify( #"hash_2140110a768a2b1d" );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0
// Checksum 0x1bfba450, Offset: 0x5ad5
// Size: 0xe9
function function_1c59caff61293917()
{
    if ( self.var_a6244b072ab54846 )
    {
        function_9f1de18100c63247( self.var_a6244b072ab54846 );
    }
    
    n_scale = getdvarfloat( @"hash_70586d4f0bbd58a5", 10 );
    e_horse = utility::spawn_model( %"accessory_dmz_origami_horse", self.origin, ( 0, 0, self.angles[ 2 ] ), undefined, n_scale );
    e_horse.var_adbac5ed5088b381 = self;
    e_horse.var_edb071d7ecd45132 = self;
    e_horse.var_f01c4860af850470 = 0;
    e_horse.e_pickup_trigger = undefined;
    level.ee_neigh.var_8aa3a5f107f9eaab[ level.ee_neigh.var_8aa3a5f107f9eaab.size ] = e_horse;
    function_a5a8c73a91ad17ca( e_horse, self );
    e_horse thread function_9340f8dc07ea4fa6();
    e_horse thread function_c2fc4217cfe57460();
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0x3d97e925, Offset: 0x5bc6
// Size: 0xd3
function private function_a5a8c73a91ad17ca( e_horse, player )
{
    e_horse notify( #"stop_bobbing" );
    e_horse linkto( player, "j_mainroot", ( -33, -10, 0 ), ( 180, 90, 90 ) );
    e_horse.var_adbac5ed5088b381 = player;
    e_horse.var_f01c4860af850470 = 0;
    player.var_a6244b072ab54846 = e_horse;
    
    if ( e_horse.e_pickup_trigger )
    {
        e_horse.e_pickup_trigger delete();
        e_horse.e_pickup_trigger = undefined;
    }
    
    player callback::add( #"player_death", &function_a0fee7ea60217c95 );
    player callback::add( #"player_disconnect", &function_abd392d7cd5c6833 );
    e_horse thread function_8114df9add3a0159( player );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 2, eflags: 0x4
// Checksum 0x4707a936, Offset: 0x5ca1
// Size: 0x114
function private horse_companion_drop_from_player( e_horse, player )
{
    e_horse unlink();
    e_horse.var_f01c4860af850470 = 1;
    e_horse.var_adbac5ed5088b381 = undefined;
    player.var_a6244b072ab54846 = undefined;
    player callback::remove( #"player_death", &function_a0fee7ea60217c95 );
    player callback::remove( #"player_disconnect", &function_abd392d7cd5c6833 );
    e_horse notify( #"horse_companion_dropped" );
    v_ground = getgroundposition( player.origin, 1 );
    e_horse.origin = v_ground + ( 0, 0, 24 );
    e_horse.angles = ( 0, player.angles[ 1 ], 0 );
    e_horse thread bob_entity( 8, 2 );
    player.var_a46194207cf2499f = gettime();
    e_horse.e_pickup_trigger = spawn( "noent_volume_trigger_rotatable_radius", v_ground, 0, 64, 64 );
    level thread function_fafa809a1cdcc21c( e_horse );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xdb7f107d, Offset: 0x5dbd
// Size: 0xe2
function private function_9f1de18100c63247( e_horse )
{
    if ( !e_horse )
    {
        return;
    }
    
    if ( e_horse.var_adbac5ed5088b381 )
    {
        player = e_horse.var_adbac5ed5088b381;
        player.var_a6244b072ab54846 = undefined;
        player callback::remove( #"player_death", &function_a0fee7ea60217c95 );
        player callback::remove( #"player_disconnect", &function_abd392d7cd5c6833 );
    }
    
    if ( e_horse.e_pickup_trigger )
    {
        e_horse.e_pickup_trigger delete();
        e_horse.e_pickup_trigger = undefined;
    }
    
    level.ee_neigh.var_8aa3a5f107f9eaab = arrayremove( level.ee_neigh.var_8aa3a5f107f9eaab, e_horse );
    e_horse notify( #"stop_bobbing" );
    e_horse unlink();
    e_horse delete();
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0x39608c93, Offset: 0x5ea7
// Size: 0x32f
function private function_9340f8dc07ea4fa6()
{
    self endon( #"deleted" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 2;
        
        if ( !self )
        {
            return;
        }
        
        v_forward = anglestoforward( self.angles );
        v_fire_origin = self.origin + ( 0, 0, 30 ) + v_forward * 24;
        
        if ( self.var_f01c4860af850470 )
        {
            a_ai = getaiarray( zm_utility::get_zombie_team() );
            
            if ( !a_ai.size )
            {
                continue;
            }
            
            a_sorted = utility::get_array_of_closest( self.origin, a_ai, undefined, undefined, 250 );
            target = a_sorted[ 0 ];
            
            if ( !target || !isalive( target ) )
            {
                continue;
            }
            
            var_da20088ae67ad678 = vectornormalize( target.origin - self.origin );
            v_aim_angles = vectortoangles( var_da20088ae67ad678 );
            self rotateto( ( 0, v_aim_angles[ 1 ], 0 ), 0.2 );
            self waittill( #"rotatedone" );
            v_forward = anglestoforward( self.angles );
            v_fire_origin = self.origin + ( 0, 0, 30 ) + v_forward * 24;
            projectile = weapon_utility::_magicbullet( level.ee_neigh.var_44cdea0f5b5b33d4, v_fire_origin, target.origin, self.var_edb071d7ecd45132 );
        }
        else
        {
            if ( !self.var_adbac5ed5088b381 )
            {
                continue;
            }
            
            a_ai = getaiarray( zm_utility::get_zombie_team() );
            
            if ( !a_ai.size )
            {
                continue;
            }
            
            a_sorted = utility::get_array_of_closest( self.origin, a_ai, undefined, undefined, 250 );
            
            if ( !a_sorted.size )
            {
                continue;
            }
            
            var_2d6b579fc088a2ee = anglestoforward( self.var_adbac5ed5088b381 getplayerangles() );
            target = undefined;
            
            foreach ( ai in a_sorted )
            {
                if ( !ai || !isalive( ai ) )
                {
                    continue;
                }
                
                v_to_ai = vectornormalize( ai.origin - self.origin );
                var_4df7db8d01e4372c = vectordot( var_2d6b579fc088a2ee, v_to_ai );
                
                if ( var_4df7db8d01e4372c >= cos( 45 ) )
                {
                    target = ai;
                    break;
                }
            }
            
            if ( !target )
            {
                continue;
            }
            
            projectile = weapon_utility::_magicbullet( level.ee_neigh.var_44cdea0f5b5b33d4, v_fire_origin, target.origin, self.var_adbac5ed5088b381 );
        }
        
        self notify( #"next_fired" );
        playfx( utility::getfx( "vfx_sat_hornet_murder_holes_ghostly_rifle_muzzle_flash" ), v_fire_origin, anglestoright( self.angles ) * -1 );
        
        if ( projectile )
        {
            projectile thread function_cb511227d555a241( self );
        }
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x2d4ba61b, Offset: 0x61de
// Size: 0xb6
function private function_cb511227d555a241( horse )
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    var_175e0109a63f0a9b = self.origin;
    round_difficulty = zm_utility::get_round_number();
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    
    if ( horse.var_edb071d7ecd45132 )
    {
        horse.var_edb071d7ecd45132 radiusdamage( var_175e0109a63f0a9b, 50, zombie_base_health, zombie_base_health * 0.5 );
    }
    
    level thread zombie_utils::function_607ff821e430d594( var_175e0109a63f0a9b, 50, 0 );
    earthquake( 0.2, 1, var_175e0109a63f0a9b, 50 );
    playrumbleonposition( "damage_heavy", var_175e0109a63f0a9b );
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x2fa15193, Offset: 0x629c
// Size: 0x7d
function private function_8114df9add3a0159( player )
{
    self endon( #"deleted" );
    player endon( #"death_or_disconnect" );
    player notifyonplayercommand( "horse_companion_drop", "+stance" );
    player notifyonplayercommand( "horse_companion_drop", "+movedown" );
    
    while ( true )
    {
        player waittill( #"horse_companion_drop" );
        
        if ( self && player.var_a6244b072ab54846 == self )
        {
            horse_companion_drop_from_player( self, player );
            return;
        }
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0x56f2184e, Offset: 0x6321
// Size: 0xc6
function private function_fafa809a1cdcc21c( e_horse )
{
    e_horse endon( #"deleted" );
    trigger = e_horse.e_pickup_trigger;
    
    if ( !trigger )
    {
        return;
    }
    
    while ( true )
    {
        trigger waittill( #"trigger", ent );
        
        if ( !e_horse || !trigger )
        {
            return;
        }
        
        if ( !namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( ent, 0, 0 ) )
        {
            continue;
        }
        
        if ( ent.var_a6244b072ab54846 )
        {
            continue;
        }
        
        if ( ent.var_a46194207cf2499f && gettime() < ent.var_a46194207cf2499f + 1500 )
        {
            continue;
        }
        
        ent.var_a46194207cf2499f = undefined;
        function_a5a8c73a91ad17ca( e_horse, ent );
        return;
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xb5460acc, Offset: 0x63ef
// Size: 0x29
function private function_a0fee7ea60217c95( params )
{
    if ( self.var_a6244b072ab54846 )
    {
        horse_companion_drop_from_player( self.var_a6244b072ab54846, self );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xdc9f3e61, Offset: 0x6420
// Size: 0x28
function private function_abd392d7cd5c6833( params )
{
    if ( self.var_a6244b072ab54846 )
    {
        function_9f1de18100c63247( self.var_a6244b072ab54846 );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 0, eflags: 0x4
// Checksum 0xa7eec677, Offset: 0x6450
// Size: 0x2b
function private function_c2fc4217cfe57460()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait 600;
    
    if ( isdefined( self ) )
    {
        function_9f1de18100c63247( self );
    }
}

// Namespace zm_sat_hornet_ee_neigh
// Params 1, eflags: 0x4
// Checksum 0xe127c2f2, Offset: 0x6483
// Size: 0x3b
function private function_312c99954c545177( params )
{
    player = level.players[ 0 ];
    
    if ( player && isalive( player ) )
    {
        player function_1c59caff61293917();
    }
}

/#

    // Namespace zm_sat_hornet_ee_neigh
    // Params 0, eflags: 0x4
    // Checksum 0x34618b38, Offset: 0x64c6
    // Size: 0x64, Type: dev
    function private register_neigh_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"hornet_ee_neigh" );
        devgui::add_devgui_func( "<dev string:x24>", "<dev string:x3f>", &function_57ccb108afbc5a9d, 1 );
        devgui::add_devgui_func( "<dev string:x4c>", "<dev string:x68>", &function_f556540bea7c8812, 1 );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x90>", &function_9ec456c0a564276f, 1 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_hornet_ee_neigh
    // Params 0, eflags: 0x4
    // Checksum 0xd67b792f, Offset: 0x6532
    // Size: 0x2a, Type: dev
    function private function_f556540bea7c8812()
    {
        player = level.players[ 0 ];
        
        if ( player )
        {
            player function_1c59caff61293917();
        }
    }

    // Namespace zm_sat_hornet_ee_neigh
    // Params 0, eflags: 0x4
    // Checksum 0x7b359db3, Offset: 0x6564
    // Size: 0x43, Type: dev
    function private function_57ccb108afbc5a9d()
    {
        player = level.players[ 0 ];
        
        if ( player.sessionstate == "<dev string:x9c>" )
        {
            player zm_live_spectate::function_794d0c5793d9aed3();
            return;
        }
        
        player zm_live_spectate::function_5647f60a40d71849();
    }

    // Namespace zm_sat_hornet_ee_neigh
    // Params 0, eflags: 0x4
    // Checksum 0x73383fc4, Offset: 0x65af
    // Size: 0xe2, Type: dev
    function private function_9ec456c0a564276f()
    {
        a_starts = utility::getstructarray( "<dev string:xb3>", "<dev string:xc2>" );
        
        if ( !a_starts.size )
        {
            return;
        }
        
        s_start = a_starts[ randomint( a_starts.size ) ];
        var_d00b944707343dc9 = function_ddbd55140b8cbebc( s_start );
        
        if ( !isdefined( level.ee_neigh.var_9cbed8e6013eb6bf ) )
        {
            level.ee_neigh.var_9cbed8e6013eb6bf = [];
        }
        
        e_boulder = utility::spawn_model( %"hash_1b8b4e4a006dcd3d", var_d00b944707343dc9[ 0 ], undefined, undefined, 3.75 );
        e_boulder solid();
        level.ee_neigh.var_9cbed8e6013eb6bf[ level.ee_neigh.var_9cbed8e6013eb6bf.size ] = e_boulder;
        e_boulder thread move_boulder( var_d00b944707343dc9 );
        level thread function_90d579f2b985ab7c( e_boulder );
    }

#/
