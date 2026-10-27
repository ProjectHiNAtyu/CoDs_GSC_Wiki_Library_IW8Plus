// script_328fdabe75ddb9bb  (hash_328fdabe75ddb9bb.gscc) (size: 51026 Bytes / 0xc752 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d7d648e (1031627918)
// size ...... 51026 (0xc752)
// includes .. 25  (offset: 0xba6a)
// strings ... 152 (offset: 0xbb32)
// dev strs .. 41  (offset: 0xc512)
// exports ... 97  (offset: 0x863a)
// cseg ...... 0xc4d + 0x79ed (0x863a)
// imports ... 276 (offset: 0x9562)
// animtree1 . 0   (offset: 0xc752)
// animtree2 . 0   (offset: 0xc752)
#using script_16ea1b94f0f381b3;
#using scripts\common\devgui;
#using scripts\common\heartbeat;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\operator;
#using scripts\mp\overlord;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ww_quest;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_9c11cf0d46efe829;

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x5
// Checksum 0x8fc2a4e, Offset: 0xc6b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_twins_ee", undefined, undefined, &init );
}

// Namespace namespace_9c11cf0d46efe829
// Params 0
// Checksum 0xfd935ad4, Offset: 0xc8c
// Size: 0xf3
function init()
{
    level endon( #"game_ended" );
    level utility::flag_wait_all( "zm_sat_scarab_script_quest_twins_ee_cs_completed", "zm_quest_initialized", "scriptables_ready", "doorbuy_init_complete" );
    
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) || getdvarint( @"hash_1165bcdabdc73568", 0 ) )
    {
        return;
    }
    
    level.twins_ee = zm_quest::get_quest( #"scarab_twins_ee" );
    zm_quest::register_quest_step( #"scarab_twins_ee", #"open_music_box", &function_96c5907057a0cea9, &function_8a11e1a81c65e90e );
    zm_quest::register_quest_step( #"scarab_twins_ee", #"hash_102815f927e3e2ba", &function_96c58d7057a0c810, undefined );
    level setup_twins_ee_assets();
    level zm_save::function_1f44a48caae2acbf();
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        level thread function_eef51ee0358f643b();
    }
    
    level utility::flag_wait( "begin_round_logic" );
    level thread zm_quest::start_quest( #"scarab_twins_ee" );
    
    /#
        level init_twins_ee_debug();
    #/
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xfc59dc94, Offset: 0xd87
// Size: 0x5e3
function private setup_twins_ee_assets()
{
    s_music_box = utility::getstruct( "pn_lw_mb", "targetname" );
    level.twins_ee.music_box = spawnscriptable( %"hash_699b180dd75d35e5", s_music_box.origin, s_music_box.angles );
    level.twins_ee.music_box.interaction = interaction::register_scriptable_interact( level.twins_ee.music_box, &function_5e2d1143292c4bf7, undefined, undefined, &music_box_hint );
    level.twins_ee.music_box setscriptablepartstate( "usable", "on" );
    level.twins_ee.jump_rope = getent( "um_vi_ra", #targetname );
    
    if ( !level.twins_ee.jump_rope )
    {
        return;
    }
    
    level.twins_ee.jump_rope notsolid();
    utility::add_fx( "twins_ee_spawn", "vfx_sat_zm_two_sisters_spawn" );
    level.twins_ee.var_7c52de15afa28579 = utility::getstructarray( "pt_na_jsc", "targetname" );
    level.twins_ee.var_66050aaaf7910433 = [];
    level.twins_ee.var_66050aaaf7910433[ "dance" ] = { #var_ee599c4f6e07a019:"dance_idle", #scene:"sat_cin_zm_vig_fly_sisters_dance" };
    level.twins_ee.var_66050aaaf7910433[ "chalk" ] = { #var_ee599c4f6e07a019:"idle", #scene:"sat_cin_zm_vig_fly_sisters_chalk_both" };
    level.twins_ee.var_66050aaaf7910433[ "skipping" ] = { #var_ee599c4f6e07a019:"shot_010", #scene:"sat_cin_zm_vig_fly_sisters_skipping" };
    level.twins_ee.var_bbb93dc08c936fba = [ { #var_ee599c4f6e07a019:"idle_holding_hands", #scene:"sat_cin_zm_vig_fly_sisters_standing" }, { #var_ee599c4f6e07a019:"seperate_idles", #scene:"sat_cin_zm_vig_fly_sisters_standing" }, { #var_ee599c4f6e07a019:"idle", #scene:"sat_cin_zm_vig_fly_sisters_chalk" }, { #var_ee599c4f6e07a019:"idle", #scene:"sat_cin_zm_vig_fly_sisters_chalk_both" }, { #var_ee599c4f6e07a019:"dance_idle", #scene:"sat_cin_zm_vig_fly_sisters_dance" } ];
    level.twins_ee.var_2b02d74ffe63259c = [ { #angles_offset:( 0, 0, 90 ), #visual:"jump_rope", #flag:"completed_jump_rope", #name:"jump_rope" }, { #angles_offset:( 0, 0, 0 ), #visual:"mask", #flag:"completed_hide_and_seek", #name:"mask" }, { #angles_offset:( 0, 0, 0 ), #visual:"toy", #flag:"completed_weeping_angel", #name:"toy" } ];
    level.twins_ee.var_17bba413d2e84a79 = [];
    level.twins_ee.var_17bba413d2e84a79[ "easy" ] = { #var_ff39f41e49b0f153:10, #var_633ab497849a54fb:10, #var_c418c5b7b616da0f:8, #var_15fc1fe51d85b1f3:2, #var_fe4009f93fd69eff:17, #var_a4739263868ec213:[ 5, 2, 2, 1 ], #var_bf359d0847998e28:[ 1.25, 1.75, 2, 2.75 ], #var_e841af071d9873b4:[ 5, 2, 1 ], #var_fbe14894445a8a9b:[ 1.75, 2, 2.75 ], #var_e7cbd7b5d3ea3054:30, #var_bf9dd55db383098d:10, #var_4d1d59ea4011b85a:2, #var_97134f739215d60e:3 };
    level.twins_ee.var_17bba413d2e84a79[ "medium" ] = { #var_ff39f41e49b0f153:15, #var_633ab497849a54fb:15, #var_c418c5b7b616da0f:12, #var_15fc1fe51d85b1f3:3, #var_fe4009f93fd69eff:15, #var_a4739263868ec213:[ 3, 4, 2, 1 ], #var_bf359d0847998e28:[ 0.9, 1.25, 1.75, 2 ], #var_e841af071d9873b4:[ 4, 3, 2, 1 ], #var_fbe14894445a8a9b:[ 1.25, 1.75, 2, 2.75 ], #var_e7cbd7b5d3ea3054:25, #var_bf9dd55db383098d:5, #var_4d1d59ea4011b85a:1.75, #var_97134f739215d60e:2 };
    level utility::flag_set( "twins_ee_asset_init_complete" );
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x46cc8645, Offset: 0x1372
// Size: 0x145
function private function_eef51ee0358f643b()
{
    level utility::flag_wait( "twins_ee_asset_init_complete" );
    level utility::flag_wait( "begin_round_logic" );
    
    if ( level.players.size != 1 )
    {
        return;
    }
    
    player = level.players[ 0 ];
    
    if ( !player )
    {
        return;
    }
    
    var_d62a9469f84faa8c = zm_quest::function_73720cdf21c3cfd7( #"scarab_twins_ee", #"twins_ee_difficulty" );
    
    if ( !var_d62a9469f84faa8c )
    {
        return;
    }
    
    player.var_1bea45eddc5187ac = var_d62a9469f84faa8c == 2 ? "medium" : "easy";
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_twins_ee", #"twins_ee_jump_rope_done" ) == 1 )
    {
        player utility::ent_flag_set( "completed_jump_rope" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_twins_ee", #"hash_24a0cb5736671c82" ) == 1 )
    {
        player utility::ent_flag_set( "completed_hide_and_seek" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_twins_ee", #"hash_715889440c389de" ) == 1 )
    {
        player utility::ent_flag_set( "completed_weeping_angel" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"scarab_twins_ee", #"hash_594cfbf7a845bd1a" ) == 1 )
    {
        player.var_e2dce739ed0f08aa = 1;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xb130aef8, Offset: 0x14bf
// Size: 0xfe
function private function_14465daf8ac9443c( player )
{
    if ( level.players.size != 1 )
    {
        return;
    }
    
    var_d62a9469f84faa8c = player.var_1bea45eddc5187ac == "medium" ? 2 : 1;
    zm_quest::function_4eefe6de31f5ddab( #"scarab_twins_ee", #"twins_ee_difficulty", var_d62a9469f84faa8c );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_twins_ee", #"twins_ee_jump_rope_done", player utility::ent_flag( "completed_jump_rope" ) );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_twins_ee", #"hash_24a0cb5736671c82", player utility::ent_flag( "completed_hide_and_seek" ) );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_twins_ee", #"hash_715889440c389de", player utility::ent_flag( "completed_weeping_angel" ) );
    zm_quest::function_4eefe6de31f5ddab( #"scarab_twins_ee", #"hash_594cfbf7a845bd1a", player.var_e2dce739ed0f08aa ? 1 : 0 );
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xeeebc394, Offset: 0x15c5
// Size: 0x22
function private function_96c5907057a0cea9( b_skipped, b_save_restored )
{
    level waittill( #"twins_ee_available" );
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xad71cc97, Offset: 0x15ef
// Size: 0x24
function private function_8a11e1a81c65e90e( b_skipped, b_save_restored )
{
    if ( b_skipped )
    {
        level open_music_box( b_skipped );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xb73a70ba, Offset: 0x161b
// Size: 0x22
function private function_96c58d7057a0c810( b_skipped, b_save_restored )
{
    level waittill( #"hash_8d39ad31519a0767" );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x1be17385, Offset: 0x1645
// Size: 0x3a
function private function_5e2d1143292c4bf7( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    if ( !level utility::flag( "WW_A_P_IN_USE" ) )
    {
        return;
    }
    
    level open_music_box();
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xd3c02df6, Offset: 0x1687
// Size: 0x36
function private music_box_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xbd817d29, Offset: 0x16c6
// Size: 0xd2
function private open_music_box( b_skipped )
{
    if ( level utility::flag( "twins_ee_available" ) )
    {
        return;
    }
    
    level utility::flag_set( "twins_ee_available" );
    
    if ( !b_skipped )
    {
        level.twins_ee.music_box setscriptablepartstate( "usable", "off" );
        level.twins_ee.music_box setscriptablepartstate( "anim", "open" );
        level thread function_3d0794177d9b81da();
    }
    else
    {
        level.twins_ee.music_box freescriptable();
    }
    
    utility::registersharedfunc( #"astral_plane", #"hash_7471e910ef93eae8", &function_9edfdbfa003caaa4 );
    utility::registersharedfunc( #"astral_plane", #"hash_398ed0d3c1d71a38", &function_cee6cbe081fed99e );
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x27104877, Offset: 0x17a0
// Size: 0x3d
function private function_3d0794177d9b81da()
{
    level utility::flag_waitopen( "WW_A_P_IN_USE" );
    
    if ( level.twins_ee.music_box )
    {
        level.twins_ee.music_box freescriptable();
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x15209443, Offset: 0x17e5
// Size: 0x155
function private function_9edfdbfa003caaa4( player )
{
    if ( !level utility::flag( "twins_ee_available" ) )
    {
        return;
    }
    
    if ( !level.twins_ee.chest )
    {
        var_6747ad76d9037f0d = utility::getstruct( "un_yt_tc", "targetname" );
        level.twins_ee.chest = spawnscriptable( %"hash_69e93f0dd79f997b", var_6747ad76d9037f0d.origin, var_6747ad76d9037f0d.angles );
        level.twins_ee.chest.var_12aadf5d8bbfdafd = createnavobstaclebybounds( level.twins_ee.chest.origin, ( 30, 30, 75 ), level.twins_ee.chest.angles );
        level.twins_ee.chest.interaction = interaction::register_scriptable_interact( level.twins_ee.chest, &function_a7b92886362ec6da, undefined, undefined, &function_b289c63646711f28 );
        level.twins_ee.chest setscriptablepartstate( "usable", "on" );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xd9979dab, Offset: 0x1942
// Size: 0x9a
function private function_cee6cbe081fed99e()
{
    level function_163b07edafb897d1();
    level cleanup_chest_items();
    
    if ( level.twins_ee.chest.var_12aadf5d8bbfdafd )
    {
        destroynavobstacle( level.twins_ee.chest.var_12aadf5d8bbfdafd );
    }
    
    if ( level.twins_ee.chest )
    {
        level.twins_ee.chest freescriptable();
    }
    
    level cleanup_jump_rope_assets();
    level cleanup_hide_and_seek_assets();
    level function_dbb17a26566a17b7();
}

// Namespace namespace_9c11cf0d46efe829
// Params 0
// Checksum 0xb3134924, Offset: 0x19e4
// Size: 0x127
function function_163b07edafb897d1()
{
    level notify( #"hash_4fccf3e6cc27cee5" );
    level notify( #"hash_7ef9706ba3c38d9d" );
    level notify( #"jump_rope_game_ended" );
    level notify( #"hide_and_seek_game_ended" );
    level notify( #"clones_game_ended" );
    level notify( #"clean_up_hide_and_seek" );
    level notify( #"hash_517dcfb3110db307" );
    
    if ( level.twins_ee.jump_rope )
    {
        level.twins_ee.jump_rope notify( #"stop_jump_rope" );
    }
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        player function_3e9ef09fb6371d64();
        player function_37b4accbb1c8c352();
        player utility::ent_flag_clear( "twins_ee_game_active" );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x162216d2, Offset: 0x1b13
// Size: 0x343
function private open_toy_box( player )
{
    player endon( #"death_or_disconnect" );
    
    if ( !isdefined( player.var_1bea45eddc5187ac ) )
    {
        player.var_1bea45eddc5187ac = "easy";
    }
    
    level.twins_ee.chest setscriptablepartstate( "anim", "open" );
    level.twins_ee.chest setscriptablepartstate( "usable", "off" );
    v_right = anglestoright( level.twins_ee.chest.angles );
    var_4b734b4a03a012a9 = level.twins_ee.chest.origin;
    var_c680ae503b2808d = [];
    
    if ( player.var_e2dce739ed0f08aa )
    {
        var_c680ae503b2808d = level.twins_ee.var_2b02d74ffe63259c;
    }
    else
    {
        foreach ( config in level.twins_ee.var_2b02d74ffe63259c )
        {
            if ( !player utility::ent_flag( config.flag ) )
            {
                var_c680ae503b2808d[ var_c680ae503b2808d.size ] = config;
            }
        }
    }
    
    level.twins_ee.var_65ead50e595a05d8 = [];
    n_count = var_c680ae503b2808d.size;
    
    for ( i = 0; i < n_count ; i++ )
    {
        config = var_c680ae503b2808d[ i ];
        n_lateral = i - ( n_count - 1 ) / 2;
        n_spacing = n_count == 1 ? 0 : 15;
        var_3a165e1a7152ec8a = v_right * n_lateral * n_spacing;
        var_7fa1fd5b0acd4da3 = n_count == 1 || n_count == 3 && i == 1;
        n_z_extra = var_7fa1fd5b0acd4da3 ? 10 : 0;
        sbl = spawnscriptable( %"hash_55ba5246c09c4a4", var_4b734b4a03a012a9, level.twins_ee.chest.angles + config.angles_offset );
        sbl setscriptablepartstate( "visual", config.visual );
        var_c5fb7b9c0ca383b7 = { #v_target_offset:var_3a165e1a7152ec8a + ( 0, 0, n_z_extra ), #visual:config.visual, #game_name:config.name, #sbl:sbl };
        level.twins_ee.var_65ead50e595a05d8[ level.twins_ee.var_65ead50e595a05d8.size ] = var_c5fb7b9c0ca383b7;
    }
    
    level.twins_ee.var_f0390c6fad293005 = 1;
    level thread function_dfdb1293fc78ed03();
    level thread function_ff1e1abd4524bf7e( player );
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xa5462805, Offset: 0x1e5e
// Size: 0x2e7
function private function_dfdb1293fc78ed03()
{
    wait 0.5;
    
    if ( !level.twins_ee.var_65ead50e595a05d8 )
    {
        return;
    }
    
    foreach ( item in level.twins_ee.var_65ead50e595a05d8 )
    {
        if ( !item.sbl )
        {
            continue;
        }
        
        e_mover = utility::spawn_model( %"tag_origin", item.sbl.origin, item.sbl.angles );
        item.mover = e_mover;
        item.sbl utility::scriptable_setparententity( e_mover );
    }
    
    waitframe();
    
    foreach ( item in level.twins_ee.var_65ead50e595a05d8 )
    {
        if ( !item.mover )
        {
            continue;
        }
        
        item.mover moveto( item.mover.origin + ( 0, 0, 19 ) + item.v_target_offset, 2 );
    }
    
    wait 2.1;
    level.twins_ee.var_4befcaf22f9eaa1d = 1;
    
    if ( level.twins_ee.chest )
    {
        level.twins_ee.chest setscriptablepartstate( "usable", "on" );
    }
    
    foreach ( item in level.twins_ee.var_65ead50e595a05d8 )
    {
        if ( !item.mover )
        {
            continue;
        }
        
        var_4082cab60ba5f254 = anglestoup( item.mover.angles );
        item.mover function_616378d7e5b22efb( var_4082cab60ba5f254, 1.5, 2 );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xe604ae0b, Offset: 0x214d
// Size: 0x156
function private function_6b221e6b7f258f25( player )
{
    if ( !level.twins_ee.var_65ead50e595a05d8 || !level.twins_ee.var_65ead50e595a05d8.size )
    {
        return;
    }
    
    var_30736d696a032221 = cos( 20 );
    
    if ( isplayer( player ) && player getcamerathirdperson() )
    {
        var_30736d696a032221 = cos( 80 );
    }
    
    playerangles = player getplayerangles();
    playerlookdir = anglestoforward( playerangles );
    player_eye = player geteye();
    n_best_index = undefined;
    n_best_dot = var_30736d696a032221;
    
    for ( i = 0; i < level.twins_ee.var_65ead50e595a05d8.size ; i++ )
    {
        item = level.twins_ee.var_65ead50e595a05d8[ i ];
        
        if ( !item.sbl )
        {
            continue;
        }
        
        v_to_item = vectornormalize( item.sbl.origin - player_eye );
        var_4df7db8d01e4372c = vectordot( playerlookdir, v_to_item );
        
        if ( var_4df7db8d01e4372c > n_best_dot )
        {
            n_best_dot = var_4df7db8d01e4372c;
            n_best_index = i;
        }
    }
    
    return n_best_index;
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x7b23dc46, Offset: 0x22ac
// Size: 0x1cf
function private function_e22ee8b2d1de561a( player )
{
    level endon( #"game_ended" );
    level endon( #"hash_4fccf3e6cc27cee5" );
    level endon( #"hash_7ef9706ba3c38d9d" );
    player endon( #"death_or_disconnect" );
    
    while ( !level.twins_ee.var_4befcaf22f9eaa1d )
    {
        waitframe();
    }
    
    n_prev_index = undefined;
    var_ecc1c7427b59132d = player.var_1bea45eddc5187ac == "medium" ? "_keyline_medium" : "_keyline";
    
    while ( level.twins_ee.var_f0390c6fad293005 )
    {
        n_index = function_6b221e6b7f258f25( player );
        
        if ( isdefined( n_index ) && n_index != n_prev_index )
        {
            if ( isdefined( n_prev_index ) && level.twins_ee.var_65ead50e595a05d8[ n_prev_index ].sbl )
            {
                level.twins_ee.var_65ead50e595a05d8[ n_prev_index ].sbl setscriptablepartstate( "visual", level.twins_ee.var_65ead50e595a05d8[ n_prev_index ].visual );
            }
            
            if ( isdefined( n_index ) && level.twins_ee.var_65ead50e595a05d8[ n_index ].sbl )
            {
                level.twins_ee.var_65ead50e595a05d8[ n_index ].sbl setscriptablepartstate( "visual", level.twins_ee.var_65ead50e595a05d8[ n_index ].visual + var_ecc1c7427b59132d );
            }
            
            n_prev_index = n_index;
        }
        
        level.twins_ee.var_7a5dfb4908ecc729 = n_index;
        waitframe();
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x95f07fcd, Offset: 0x2483
// Size: 0x279
function private function_ff1e1abd4524bf7e( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    level endon( #"ww_a_p_cleanup_in_progress" );
    level thread function_e22ee8b2d1de561a( player );
    var_dd40cf6520d59892 = gettime() + utility::function_4b74c15943231980( 15 );
    
    while ( gettime() < var_dd40cf6520d59892 )
    {
        if ( level.twins_ee.var_52b3ba901533864b )
        {
            str_game = level.twins_ee.var_52b3ba901533864b;
            level.twins_ee.var_52b3ba901533864b = undefined;
            level notify( #"hash_4fccf3e6cc27cee5" );
            level.twins_ee.chest setscriptablepartstate( "usable", "off" );
            level function_63a1f73e7a166128( player, str_game );
            return;
        }
        
        waitframe();
    }
    
    level notify( #"hash_7ef9706ba3c38d9d" );
    level.twins_ee.var_7a5dfb4908ecc729 = undefined;
    level.twins_ee.chest setscriptablepartstate( "usable", "off" );
    
    if ( level.twins_ee.var_65ead50e595a05d8 )
    {
        var_bf972da838d14404 = level.twins_ee.chest.origin - ( 0, 0, 10 );
        
        foreach ( item in level.twins_ee.var_65ead50e595a05d8 )
        {
            if ( item.mover )
            {
                item.mover moveto( var_bf972da838d14404, 1 );
            }
        }
        
        wait 0.4;
        level.twins_ee.chest setscriptablepartstate( "anim", "close" );
        wait 0.7;
    }
    
    level cleanup_chest_items();
    wait 2;
    
    if ( level.twins_ee.chest )
    {
        level.twins_ee.chest setscriptablepartstate( "usable", "on" );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0x6ed9c360, Offset: 0x2704
// Size: 0x100
function private function_63a1f73e7a166128( player, var_59a9ac9a883bafa6 )
{
    player endon( #"death_or_disconnect" );
    level thread game_utility::fadetoblackforplayer( player, 1, 0.5 );
    player playsoundtoplayer( "evt_scarab_minigame_start", player );
    level notify( #"hash_e556220fb37faf9b" );
    wait 0.75;
    level cleanup_chest_items();
    player setclientomnvar( "ui_show_quest_ui_nohud", 0 );
    player utility::function_32b24db3127bff40( "scarab_ap_teleport_fx", "off" );
    
    if ( level.scarab_ww_quest.var_7ba53ebdc38a4c73 )
    {
        level.scarab_ww_quest.var_7ba53ebdc38a4c73 freescriptable();
    }
    
    zm_sat_scarab_ww_quest::function_c7b3cc5d4daf663();
    level function_13879518c3af6815();
    wait 1;
    
    if ( var_59a9ac9a883bafa6 == "jump_rope" )
    {
        level thread function_a6f08d6b8b078964( player );
        return;
    }
    
    if ( var_59a9ac9a883bafa6 == "mask" )
    {
        level thread function_9abcf6fe82ea6cb6( player );
        return;
    }
    
    if ( var_59a9ac9a883bafa6 == "toy" )
    {
        level thread function_f01adfa074b13251( player );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x90e73442, Offset: 0x280c
// Size: 0x118
function private function_13879518c3af6815()
{
    a_zombies = getaiarrayinradius( level.twins_ee.jump_rope.origin, 2500 );
    
    foreach ( zombie in a_zombies )
    {
        zombie_zone = zone_manager::function_90e5c3e2272b0130( zombie.origin );
        
        if ( zombie_zone.str_zone_name && zombie_zone.str_zone_name != "zone_ee_ashwoods" )
        {
            continue;
        }
        
        if ( !zombie.var_65de3f7c461c1611 && !zombie.var_15598d8e493afe88 )
        {
            zombie zm_cleanup_manager::function_dd62e2042418b7e5();
        }
        
        zombie.nocorpse = 1;
        zombie kill();
        waitframe();
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x3590b0d9, Offset: 0x292c
// Size: 0x133
function private cleanup_chest_items()
{
    if ( level.twins_ee.var_65ead50e595a05d8 )
    {
        foreach ( item in level.twins_ee.var_65ead50e595a05d8 )
        {
            if ( item.mover )
            {
                item.mover delete();
            }
            
            if ( item.sbl )
            {
                item.sbl freescriptable();
            }
        }
        
        level.twins_ee.var_65ead50e595a05d8 = [];
    }
    
    level.twins_ee.var_f0390c6fad293005 = 0;
    level.twins_ee.var_4befcaf22f9eaa1d = 0;
    level.twins_ee.var_7a5dfb4908ecc729 = undefined;
    level.twins_ee.var_52b3ba901533864b = undefined;
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x2b7955f4, Offset: 0x2a67
// Size: 0x90
function private function_a7b92886362ec6da( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    if ( level.twins_ee.var_f0390c6fad293005 )
    {
        n_index = function_6b221e6b7f258f25( player );
        
        if ( isdefined( n_index ) )
        {
            level.twins_ee.var_52b3ba901533864b = level.twins_ee.var_65ead50e595a05d8[ n_index ].game_name;
        }
        
        return;
    }
    
    level open_toy_box( player );
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0x28bdd5db, Offset: 0x2aff
// Size: 0x36
function private function_b289c63646711f28( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x54cf8634, Offset: 0x2b3e
// Size: 0xbe
function private function_eba30ff84fc594ad( player )
{
    if ( !player.var_e2dce739ed0f08aa )
    {
        return;
    }
    
    var_4822d49a190df23f = 1;
    
    foreach ( other_player in level.players )
    {
        if ( !other_player.var_e2dce739ed0f08aa )
        {
            var_4822d49a190df23f = 0;
            break;
        }
    }
    
    if ( var_4822d49a190df23f )
    {
        level notify( #"hash_8d39ad31519a0767" );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xffa43096, Offset: 0x2c04
// Size: 0x114
function private function_907d6e80c7e5d7d( player )
{
    var_8de44035c62f2f4f = player.var_1bea45eddc5187ac ?? "easy";
    var_353c9636ad466d06 = player.var_e2dce739ed0f08aa;
    s_rewards_spawn = utility::getstruct( "ka_vr_rw", "targetname" );
    player playsoundtoplayer( "evt_twins_game_success", player );
    
    if ( var_353c9636ad466d06 )
    {
        utility::delaythread( 1, &function_2914138708a59fa0, s_rewards_spawn );
        return;
    }
    
    n_essence = var_8de44035c62f2f4f == "easy" ? 500 : 1000;
    var_c0771eb7a876c131 = player utility::ent_flag( "completed_jump_rope" ) && player utility::ent_flag( "completed_hide_and_seek" ) && player utility::ent_flag( "completed_weeping_angel" );
    
    if ( !var_c0771eb7a876c131 )
    {
        utility::delaythread( 1, &function_39ec4b536cae19a1, n_essence, s_rewards_spawn );
    }
    else
    {
        utility::delaythread( 1, &function_babfe7a0dd995145, var_8de44035c62f2f4f, n_essence, s_rewards_spawn );
        level function_24ee233ddc7e996b( player );
    }
    
    function_14465daf8ac9443c( player );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x968da0fe, Offset: 0x2d20
// Size: 0xb6
function private function_24ee233ddc7e996b( player )
{
    var_8de44035c62f2f4f = player.var_1bea45eddc5187ac ?? "easy";
    
    if ( var_8de44035c62f2f4f == "easy" )
    {
        player utility::ent_flag_clear( "completed_jump_rope" );
        player utility::ent_flag_clear( "completed_hide_and_seek" );
        player utility::ent_flag_clear( "completed_weeping_angel" );
        player.var_1bea45eddc5187ac = "medium";
        return;
    }
    
    player.var_e2dce739ed0f08aa = 1;
    player utility::ent_flag_clear( "completed_jump_rope" );
    player utility::ent_flag_clear( "completed_hide_and_seek" );
    player utility::ent_flag_clear( "completed_weeping_angel" );
    level function_eba30ff84fc594ad( player );
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xfb8ab40, Offset: 0x2dde
// Size: 0xf2
function private function_39ec4b536cae19a1( var_679667f78224332d, s_spawn )
{
    level endon( #"game_ended" );
    var_ed2431ff5fd3b5d8 = s_spawn.origin;
    landing_origin = getclosestpointonnavmesh( var_ed2431ff5fd3b5d8 );
    n_essence_count = int( var_679667f78224332d / 100 );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( landing_origin, var_ed2431ff5fd3b5d8 );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_2321e933cbdf46d8 = 10;
    spawnoptions.var_34444f0dda11f0d5 = 10;
    spawnoptions.var_18608bd8660b3a19 = 2;
    spawnoptions.var_789c456dda9c8572 = var_ed2431ff5fd3b5d8;
    spawnoptions.var_44d5025c8cfbd48e = n_essence_count;
    
    for ( i = 0; i < n_essence_count ; i++ )
    {
        common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_t10_item_essence_small", undefined, spawnoptions );
        wait 0.1;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 3, eflags: 0x4
// Checksum 0x3ca7d8b5, Offset: 0x2ed8
// Size: 0x232
function private function_babfe7a0dd995145( var_8de44035c62f2f4f, n_essence, s_spawn )
{
    level endon( #"game_ended" );
    var_ed2431ff5fd3b5d8 = s_spawn.origin;
    landing_origin = getclosestpointonnavmesh( var_ed2431ff5fd3b5d8 );
    n_essence_count = int( n_essence / 100 );
    str_bundle = var_8de44035c62f2f4f == "easy" ? "zm_round_reward_bundle_scarab_twins_ee_easy_tier" : "zm_round_reward_bundle_scarab_twins_ee_medium_tier";
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( landing_origin, var_ed2431ff5fd3b5d8 );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_2321e933cbdf46d8 = 10;
    spawnoptions.var_34444f0dda11f0d5 = 10;
    spawnoptions.var_18608bd8660b3a19 = 2;
    spawnoptions.var_789c456dda9c8572 = var_ed2431ff5fd3b5d8;
    var_6f8f8562287f75f9 = !zm_quest::function_73720cdf21c3cfd7( #"scarab_twins_ee", #"hash_d62d46082fa13" );
    spawnoptions.var_44d5025c8cfbd48e = n_essence_count + 3 + ( var_6f8f8562287f75f9 ? 1 : 0 );
    common_item::function_61c2c0251e742ffd( %"hash_63a8dbb95fa75efb", undefined, spawnoptions );
    wait 0.1;
    
    if ( var_6f8f8562287f75f9 && var_8de44035c62f2f4f == "medium" )
    {
        zm_quest::function_4eefe6de31f5ddab( #"scarab_twins_ee", #"hash_d62d46082fa13", 1 );
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.critical = 1;
        common_item::function_61c2c0251e742ffd( %"hash_6ddbae43b1c907d8", 1, spawnoptions );
        wait 0.1;
        spawnoptions.var_fd47e835523b473f = undefined;
        spawnoptions.critical = undefined;
    }
    
    a_reward_items = zm_round_reward_bundle::function_8cbad2bff5b7cc1( str_bundle, #"default", s_spawn.origin );
    
    for ( i = 0; i < a_reward_items.size ; i++ )
    {
        if ( a_reward_items[ i ] )
        {
            common_item::function_61c2c0251e742ffd( a_reward_items[ i ], undefined, spawnoptions );
            wait 0.1;
        }
    }
    
    for ( i = 0; i < n_essence_count ; i++ )
    {
        common_item::function_61c2c0251e742ffd( %"itemspawnentry:zm_t10_item_essence_small", undefined, spawnoptions );
        wait 0.1;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xe31d786d, Offset: 0x3112
// Size: 0x18e
function private function_2914138708a59fa0( s_spawn )
{
    level endon( #"game_ended" );
    var_ed2431ff5fd3b5d8 = s_spawn.origin;
    landing_origin = getclosestpointonnavmesh( var_ed2431ff5fd3b5d8 );
    
    if ( utility::cointoss() )
    {
        n_item_count = int( 5 );
        var_b603a7fc89cd1871 = %"itemspawnentry:zm_t10_item_essence_small";
    }
    else
    {
        n_item_count = int( 10 );
        var_b603a7fc89cd1871 = %"itemspawnentry:zm_t10_item_salvage_green";
    }
    
    var_e980a0ffab5d3ce9 = utility::percent_chance( 8 );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( landing_origin, var_ed2431ff5fd3b5d8 );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_2321e933cbdf46d8 = 10;
    spawnoptions.var_34444f0dda11f0d5 = 10;
    spawnoptions.var_18608bd8660b3a19 = 2;
    spawnoptions.var_789c456dda9c8572 = var_ed2431ff5fd3b5d8;
    spawnoptions.var_44d5025c8cfbd48e = n_item_count + ( var_e980a0ffab5d3ce9 ? 2 : 0 );
    
    if ( var_e980a0ffab5d3ce9 )
    {
        a_reward_items = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_twins_ee_post_complete", #"default", s_spawn.origin );
        
        for ( i = 0; i < a_reward_items.size ; i++ )
        {
            if ( a_reward_items[ i ] )
            {
                common_item::function_61c2c0251e742ffd( a_reward_items[ i ], undefined, spawnoptions );
                wait 0.1;
            }
        }
    }
    
    for ( i = 0; i < n_item_count ; i++ )
    {
        common_item::function_61c2c0251e742ffd( var_b603a7fc89cd1871, undefined, spawnoptions );
        wait 0.1;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xc851e31e, Offset: 0x32a8
// Size: 0x2e7
function private function_a6f08d6b8b078964( player )
{
    level thread function_62c8f71341b9a3d7( player );
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    level endon( #"jump_rope_game_ended" );
    level setup_jump_rope_scene( player );
    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
    wait 1;
    s_difficulty = level.twins_ee.var_17bba413d2e84a79[ player.var_1bea45eddc5187ac ?? "easy" ];
    n_max_hits = s_difficulty.var_97134f739215d60e;
    level.twins_ee.var_4d1d59ea4011b85a = s_difficulty.var_4d1d59ea4011b85a;
    level.twins_ee.var_bf9dd55db383098d = s_difficulty.var_bf9dd55db383098d;
    level.twins_ee.var_e7cbd7b5d3ea3054 = s_difficulty.var_e7cbd7b5d3ea3054;
    level.twins_ee.var_fbe14894445a8a9b = s_difficulty.var_fbe14894445a8a9b;
    level.twins_ee.var_e841af071d9873b4 = s_difficulty.var_e841af071d9873b4;
    level.twins_ee.var_bf359d0847998e28 = s_difficulty.var_bf359d0847998e28;
    level.twins_ee.var_a4739263868ec213 = s_difficulty.var_a4739263868ec213;
    level thread function_626063f19c9d0ff4( player );
    n_hits = 0;
    n_start_time = gettime();
    n_duration_ms = utility::function_4b74c15943231980( 50 );
    var_dd40cf6520d59892 = n_start_time + n_duration_ms;
    n_last_hit_time = 0;
    level.twins_ee.jump_rope thread function_9e68d59549bee178( n_start_time );
    level thread function_60e2a5260b854536( player );
    
    while ( gettime() < var_dd40cf6520d59892 )
    {
        if ( n_hits >= n_max_hits )
        {
            break;
        }
        
        if ( player istouching( level.twins_ee.jump_rope ) && !player isonground() == 0 )
        {
            if ( gettime() - n_last_hit_time > utility::function_4b74c15943231980( 1 ) )
            {
                n_hits++;
                n_last_hit_time = gettime();
                player damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
                player earthquakeforplayer( 0.4, 0.5, player.origin, 500 );
                player playrumbleonentity( "damage_heavy" );
                player playsoundtoplayer( "evt_fail_stinger", player );
                player playsoundtoplayer( "evt_scarab_jumprope_hit", player );
                player setscriptablepartstate( "scarab_twins_ee_vfx", "jump_rope_hit" );
                
                /#
                    iprintlnbold( "<dev string:x24>" + n_hits + "<dev string:x34>" + n_max_hits );
                #/
            }
        }
        
        waitframe();
    }
    
    b_success = n_hits < n_max_hits;
    level thread function_bbcf20707ee90c08( player, b_success, n_hits );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xd0bacf28, Offset: 0x3597
// Size: 0x3a
function private function_62c8f71341b9a3d7( player )
{
    level endon( #"game_ended" );
    level endon( #"jump_rope_game_ended" );
    player waittill( #"death_or_disconnect" );
    level cleanup_jump_rope_assets();
}

// Namespace namespace_9c11cf0d46efe829
// Params 3, eflags: 0x4
// Checksum 0x295d3c78, Offset: 0x35d9
// Size: 0xf7
function private function_bbcf20707ee90c08( player, b_success, n_hits )
{
    level notify( #"jump_rope_game_ended" );
    player playsoundtoplayer( "evt_scarab_minigame_warp_1", player );
    level.twins_ee.jump_rope notify( #"stop_jump_rope" );
    level cleanup_jump_rope_assets();
    
    if ( b_success )
    {
        player utility::ent_flag_set( "completed_jump_rope" );
    }
    
    player function_3e9ef09fb6371d64();
    level zm_sat_scarab_ww_quest::function_d5ddbca43097a0ff();
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    level utility::delaythread( 2, &function_4336518816e7ca20, b_success ? #"hash_508ad00a4d52b24f" : #"hash_930cce8ebd08bc58", player );
    
    if ( b_success )
    {
        level function_907d6e80c7e5d7d( player );
        return;
    }
    
    s_failure = utility::getstruct( "xe_nd_gr", "targetname" );
    player utility::delaythread( 1, &function_33a540cd8a8cb8a6, s_failure );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xa4dbcbef, Offset: 0x36d8
// Size: 0x573
function private setup_jump_rope_scene( player )
{
    level endon( #"jump_rope_game_ended" );
    player endon( #"death_or_disconnect" );
    player dontinterpolate();
    s_center = utility::getstruct( "ti_ro_jp", "targetname" );
    player setorigin( s_center.origin );
    player setplayerangles( s_center.angles );
    player setstance( "stand", undefined, 1 );
    waitframe();
    player function_53b30e8f264685c9();
    s_camera = utility::getstruct( "oz_ke_jc", "targetname" );
    var_d402dd79dc735ace = utility::spawn_model( "tag_origin", s_camera.origin, s_camera.angles );
    player.var_4a3be985a02867f4 = var_d402dd79dc735ace;
    player thread utility::delete_on_death( var_d402dd79dc735ace );
    player cameralinkto( var_d402dd79dc735ace, "tag_origin", 1 );
    level.twins_ee.jump_rope_camera = var_d402dd79dc735ace;
    var_bf0ab2c4c1cbef96 = utility::getstruct( "bn_qw_jl", "targetname" );
    var_7466612032586beb = utility::getstruct( "dc_he_jr", "targetname" );
    var_bf0ab2c4c1cbef96 thread scene::play( undefined, "seperate_idles", "sat_cin_zm_vig_fly_sisters_standing" );
    var_bf0ab2c4c1cbef96.var_fe9ebcd9161bbae8 = var_bf0ab2c4c1cbef96 scene::get_entities();
    
    foreach ( mdl in var_bf0ab2c4c1cbef96.var_fe9ebcd9161bbae8 )
    {
        mdl.var_2fc3a5fb762afb6e = 1;
    }
    
    var_7466612032586beb thread scene::play( undefined, "seperate_idles", "sat_cin_zm_vig_fly_sisters_standing" );
    var_7466612032586beb.var_fe9ebcd9161bbae8 = var_7466612032586beb scene::get_entities();
    
    foreach ( mdl in var_7466612032586beb.var_fe9ebcd9161bbae8 )
    {
        mdl.var_2fc3a5fb762afb6e = 1;
    }
    
    var_7466612032586beb.var_fe9ebcd9161bbae8[ 0 ] setmodel( %"xcomposite_sat_zmb_npc_sister_skeletal" );
    level.twins_ee.var_c819ad31580f1570 = var_bf0ab2c4c1cbef96;
    level.twins_ee.var_e4f670cec623d645 = var_7466612032586beb;
    level function_d604065ebceca390();
    s_jump_rope = utility::getstruct( "wy_pa_js", "targetname" );
    level.twins_ee.jump_rope show();
    level.twins_ee.jump_rope.origin = s_jump_rope.origin;
    level.twins_ee.jump_rope.angles = s_jump_rope.angles;
    level.twins_ee.jump_rope.var_97096106560ee4bc = 2;
    var_342759d8d9514084 = utility::getstructarray( "qf_iu_jh", "targetname" );
    level.twins_ee.var_1d73930fbd7e1d6d = [];
    
    foreach ( s_handle in var_342759d8d9514084 )
    {
        handle_fx = spawnscriptable( %"hash_55ba5246c09c4a4", s_handle.origin, s_handle.angles );
        handle_fx setscriptablepartstate( "visual", "rope_handle" );
        var_fbaedc49c7b1a71f = rotatevectorinverted( s_handle.origin - level.twins_ee.jump_rope.origin, level.twins_ee.jump_rope.angles );
        var_5fb2320e8a5178c4 = combineanglesinverted( level.twins_ee.jump_rope.angles, s_handle.angles );
        handle_fx utility::scriptable_setparententity( level.twins_ee.jump_rope, var_fbaedc49c7b1a71f, var_5fb2320e8a5178c4 );
        level.twins_ee.var_1d73930fbd7e1d6d[ level.twins_ee.var_1d73930fbd7e1d6d.size ] = handle_fx;
    }
    
    var_bd37b28f07921c15 = utility::getstruct( "ml_za_jf", "targetname" );
    level.twins_ee.var_f2e06cbcc65a3e6d = spawnscriptable( %"hash_55ba5246c09c4a4", var_bd37b28f07921c15.origin, var_bd37b28f07921c15.angles );
    level function_aa699041d214dabc();
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xd88fa1d8, Offset: 0x3c53
// Size: 0xce
function private function_d604065ebceca390()
{
    var_ee41aa2235b5eaaf = level.twins_ee.var_c819ad31580f1570.var_fe9ebcd9161bbae8[ 0 ];
    var_f33dbf20e14f9c3f = level.twins_ee.var_e4f670cec623d645.var_fe9ebcd9161bbae8[ 0 ];
    
    if ( !( isdefined( var_ee41aa2235b5eaaf ) && isdefined( var_f33dbf20e14f9c3f ) ) )
    {
        return;
    }
    
    level.twins_ee.var_d4a84821d66d30ab = utility::spawn_model( "tag_origin", var_ee41aa2235b5eaaf.origin, var_ee41aa2235b5eaaf.angles );
    level.twins_ee.var_e24f9245fec98c4f = utility::spawn_model( "tag_origin", var_f33dbf20e14f9c3f.origin, var_f33dbf20e14f9c3f.angles );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x6b435099, Offset: 0x3d29
// Size: 0x1c8
function private function_605419479757e496( var_1d88e61b7bc79cbc = 0 )
{
    var_ee41aa2235b5eaaf = level.twins_ee.var_c819ad31580f1570.var_fe9ebcd9161bbae8[ 0 ];
    var_f33dbf20e14f9c3f = level.twins_ee.var_e4f670cec623d645.var_fe9ebcd9161bbae8[ 0 ];
    
    if ( var_1d88e61b7bc79cbc && level.twins_ee.var_bfe7a8fe072c4610 && level.twins_ee.var_bfe7a8fe072c4610.var_fe9ebcd9161bbae8.size >= 2 )
    {
        var_ee41aa2235b5eaaf = level.twins_ee.var_bfe7a8fe072c4610.var_fe9ebcd9161bbae8[ 0 ];
        var_f33dbf20e14f9c3f = level.twins_ee.var_bfe7a8fe072c4610.var_fe9ebcd9161bbae8[ 1 ];
    }
    
    if ( level.twins_ee.var_d4a84821d66d30ab && var_ee41aa2235b5eaaf )
    {
        level.twins_ee.var_d4a84821d66d30ab.origin = var_ee41aa2235b5eaaf.origin;
        level.twins_ee.var_d4a84821d66d30ab.angles = var_ee41aa2235b5eaaf.angles;
    }
    
    if ( level.twins_ee.var_e24f9245fec98c4f && var_f33dbf20e14f9c3f )
    {
        level.twins_ee.var_e24f9245fec98c4f.origin = var_f33dbf20e14f9c3f.origin;
        level.twins_ee.var_e24f9245fec98c4f.angles = var_f33dbf20e14f9c3f.angles;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x328a15f9, Offset: 0x3ef9
// Size: 0x183
function private function_aa699041d214dabc()
{
    foreach ( var_16af6624858ffa21 in level.twins_ee.var_7c52de15afa28579 )
    {
        scene_config = level.twins_ee.var_66050aaaf7910433[ var_16af6624858ffa21.script_noteworthy ];
        
        if ( !scene_config )
        {
            continue;
        }
        
        var_16af6624858ffa21 thread scene::play( undefined, scene_config.var_ee599c4f6e07a019, scene_config.scene );
        var_16af6624858ffa21 scene::pause( 1 );
        var_16af6624858ffa21.var_fe9ebcd9161bbae8 = var_16af6624858ffa21 scene::get_entities();
        
        foreach ( mdl in var_16af6624858ffa21.var_fe9ebcd9161bbae8 )
        {
            mdl.var_2fc3a5fb762afb6e = 1;
            mdl dontcastshadows();
            mdl setscriptablepartstate( "reveal", "invisible" );
        }
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xb0e1e236, Offset: 0x4084
// Size: 0x128
function private function_504bd670493e92c0( n_start_time )
{
    var_77aa2a7c23d641d9 = gettime() - n_start_time;
    
    if ( var_77aa2a7c23d641d9 >= utility::function_4b74c15943231980( level.twins_ee.var_e7cbd7b5d3ea3054 ) )
    {
        level.twins_ee.jump_rope.var_97096106560ee4bc = utility::random_weighted( level.twins_ee.var_bf359d0847998e28, level.twins_ee.var_a4739263868ec213 );
        return;
    }
    
    if ( var_77aa2a7c23d641d9 >= utility::function_4b74c15943231980( level.twins_ee.var_bf9dd55db383098d ) )
    {
        level.twins_ee.jump_rope.var_97096106560ee4bc = utility::random_weighted( level.twins_ee.var_fbe14894445a8a9b, level.twins_ee.var_e841af071d9873b4 );
        return;
    }
    
    level.twins_ee.jump_rope.var_97096106560ee4bc = level.twins_ee.var_4d1d59ea4011b85a;
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x79ad7226, Offset: 0x41b4
// Size: 0x100
function private function_53b30e8f264685c9()
{
    utility::ent_flag_set( "doing_twins_ee_jump_rope" );
    val::set( "twins_ee_jump_rope", "allow_movement", 0 );
    val::set( "twins_ee_jump_rope", "weapon_switch", 0 );
    val::set( "twins_ee_jump_rope", "offhand_weapons", 0 );
    val::set( "twins_ee_jump_rope", "melee", 0 );
    val::set( "twins_ee_jump_rope", "ads", 0 );
    val::set( "twins_ee_jump_rope", "stance_change", 0 );
    val::set( "twins_ee_jump_rope", "allow_jump", 1 );
    val::set( "twins_ee_jump_rope", "ignoreme", 1 );
    val::set( "twins_ee_jump_rope", "ignore_afk", 1 );
    zm_utility::function_814e28ebc00f977d( "twins_ee" );
    
    if ( !isdefined( self.defaultbasefov ) )
    {
        self.defaultbasefov = getdvarfloat( @"cg_targetbasefov", 65 );
    }
    
    self modifybasefov( 90, 0 );
    self lerpfovscalefactor( 0, 0 );
    self setclientomnvar( "ui_zm_is_bear_attack_quest", 0 );
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xec78f0fc, Offset: 0x42bc
// Size: 0x6f
function private function_3e9ef09fb6371d64()
{
    if ( !utility::ent_flag( "doing_twins_ee_jump_rope" ) )
    {
        return;
    }
    
    if ( self.var_4a3be985a02867f4 )
    {
        self cameraunlink();
        self.var_4a3be985a02867f4 delete();
    }
    
    val::reset_all( "twins_ee_jump_rope" );
    self modifybasefov( self.defaultbasefov, 0 );
    self lerpfovscalefactor( 1, 0 );
    zm_utility::take_fist( "twins_ee" );
    utility::ent_flag_clear( "doing_twins_ee_jump_rope" );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xd91a8837, Offset: 0x4333
// Size: 0x106
function private function_9e68d59549bee178( n_start_time )
{
    self endon( #"stop_jump_rope" );
    level endon( #"game_ended" );
    self rotateroll( -180, 1, 0, 0.5 );
    self playsound( "evt_scarab_jumprope_up" );
    self waittill( #"rotatedone" );
    
    while ( true )
    {
        level function_504bd670493e92c0( n_start_time );
        var_4dfec929b4a0bad4 = level.twins_ee.jump_rope.var_97096106560ee4bc;
        self rotateroll( -360, var_4dfec929b4a0bad4, var_4dfec929b4a0bad4 * 0.33, var_4dfec929b4a0bad4 * 0.33 );
        self playsound( "evt_scarab_jumprope_down" );
        wait var_4dfec929b4a0bad4 / 2;
        self playsound( "evt_scarab_jumprope_up" );
        
        if ( level.twins_ee.var_f2e06cbcc65a3e6d )
        {
            level.twins_ee.var_f2e06cbcc65a3e6d setscriptablepartstate( "visual", "jump_rope_hit_floor" );
        }
        
        self waittill( #"rotatedone" );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x5af20a90, Offset: 0x4441
// Size: 0x44b
function private cleanup_jump_rope_assets()
{
    level.twins_ee.jump_rope notify( #"stop_jump_rope" );
    
    if ( level.twins_ee.var_f2e06cbcc65a3e6d )
    {
        level.twins_ee.var_f2e06cbcc65a3e6d freescriptable();
    }
    
    if ( level.twins_ee.var_d4a84821d66d30ab )
    {
        level.twins_ee.var_d4a84821d66d30ab delete();
    }
    
    if ( level.twins_ee.var_e24f9245fec98c4f )
    {
        level.twins_ee.var_e24f9245fec98c4f delete();
    }
    
    level function_866a1836b322a420();
    
    if ( level.twins_ee.jump_rope )
    {
        level.twins_ee.jump_rope hide();
    }
    
    if ( level.twins_ee.var_1d73930fbd7e1d6d )
    {
        foreach ( handle_fx in level.twins_ee.var_1d73930fbd7e1d6d )
        {
            if ( handle_fx )
            {
                handle_fx freescriptable();
            }
        }
        
        level.twins_ee.var_1d73930fbd7e1d6d = [];
    }
    
    if ( level.twins_ee.jump_rope.e_mover )
    {
        level.twins_ee.jump_rope.e_mover delete();
    }
    
    if ( level.twins_ee.var_c819ad31580f1570 )
    {
        level.twins_ee.var_c819ad31580f1570 scene::stop();
        
        foreach ( mdl in level.twins_ee.var_c819ad31580f1570.var_fe9ebcd9161bbae8 )
        {
            mdl delete();
        }
    }
    
    if ( level.twins_ee.var_e4f670cec623d645 )
    {
        level.twins_ee.var_e4f670cec623d645 scene::stop();
        
        foreach ( mdl in level.twins_ee.var_e4f670cec623d645.var_fe9ebcd9161bbae8 )
        {
            mdl delete();
        }
    }
    
    foreach ( var_16af6624858ffa21 in level.twins_ee.var_7c52de15afa28579 )
    {
        if ( var_16af6624858ffa21.var_fe9ebcd9161bbae8 )
        {
            var_16af6624858ffa21 scene::stop();
            
            foreach ( mdl in var_16af6624858ffa21.var_fe9ebcd9161bbae8 )
            {
                if ( mdl )
                {
                    mdl delete();
                }
            }
            
            var_16af6624858ffa21.var_fe9ebcd9161bbae8 = undefined;
        }
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x6db0cf63, Offset: 0x4894
// Size: 0x40f
function private function_60e2a5260b854536( player )
{
    level endon( #"game_ended" );
    level endon( #"jump_rope_game_ended" );
    player endon( #"death_or_disconnect" );
    
    if ( !level.twins_ee.var_7c52de15afa28579 || level.twins_ee.var_7c52de15afa28579.size == 0 )
    {
        return;
    }
    
    var_f679b4a17d59e56c = [];
    
    foreach ( var_16af6624858ffa21 in level.twins_ee.var_7c52de15afa28579 )
    {
        if ( level.twins_ee.var_66050aaaf7910433[ var_16af6624858ffa21.script_noteworthy ] && !arraycontains( var_f679b4a17d59e56c, var_16af6624858ffa21.script_noteworthy ) )
        {
            var_f679b4a17d59e56c[ var_f679b4a17d59e56c.size ] = var_16af6624858ffa21.script_noteworthy;
        }
    }
    
    if ( var_f679b4a17d59e56c.size == 0 )
    {
        return;
    }
    
    var_e68339a467f71f7 = arrayrandomize( var_f679b4a17d59e56c );
    n_type_index = 0;
    wait randomfloatrange( 5, 10 );
    
    while ( true )
    {
        str_type = var_e68339a467f71f7[ n_type_index ];
        n_type_index++;
        
        if ( n_type_index >= var_e68339a467f71f7.size )
        {
            var_e68339a467f71f7 = arrayrandomize( var_f679b4a17d59e56c );
            n_type_index = 0;
        }
        
        a_matching = [];
        
        foreach ( s_candidate in level.twins_ee.var_7c52de15afa28579 )
        {
            if ( s_candidate.script_noteworthy == str_type )
            {
                a_matching[ a_matching.size ] = s_candidate;
            }
        }
        
        var_16af6624858ffa21 = utility::array_random( a_matching );
        level function_7b3652a7d7ec2354();
        wait 1.75;
        level.twins_ee.var_bfe7a8fe072c4610 = var_16af6624858ffa21;
        playfx( utility::getfx( "twins_ee_spawn" ), var_16af6624858ffa21.origin );
        level function_605419479757e496( 1 );
        level.twins_ee.var_bfe7a8fe072c4610 scene::pause( 0 );
        
        foreach ( mdl in var_16af6624858ffa21.var_fe9ebcd9161bbae8 )
        {
            mdl castshadows();
            mdl setscriptablepartstate( "reveal", "reveal_in" );
        }
        
        n_scene_duration = var_16af6624858ffa21.script_noteworthy == "skipping" ? 2.15 : randomfloatrange( 5, 7 );
        wait n_scene_duration;
        
        foreach ( mdl in var_16af6624858ffa21.var_fe9ebcd9161bbae8 )
        {
            mdl dontcastshadows();
            mdl setscriptablepartstate( "reveal", "reveal_out" );
        }
        
        wait 1.75;
        level.twins_ee.var_bfe7a8fe072c4610 scene::pause( 1 );
        level function_866a1836b322a420();
        level function_6468393bac799d31();
        level function_605419479757e496();
        wait randomfloatrange( 5, 10 );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xd831b585, Offset: 0x4cab
// Size: 0x160
function private function_7b3652a7d7ec2354()
{
    if ( level.twins_ee.var_c819ad31580f1570 )
    {
        foreach ( mdl in level.twins_ee.var_c819ad31580f1570.var_fe9ebcd9161bbae8 )
        {
            mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
            mdl dontcastshadows();
        }
    }
    
    if ( level.twins_ee.var_e4f670cec623d645 )
    {
        foreach ( mdl in level.twins_ee.var_e4f670cec623d645.var_fe9ebcd9161bbae8 )
        {
            mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
            mdl dontcastshadows();
        }
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xe3dd7f54, Offset: 0x4e13
// Size: 0x160
function private function_6468393bac799d31()
{
    if ( level.twins_ee.var_c819ad31580f1570 )
    {
        foreach ( mdl in level.twins_ee.var_c819ad31580f1570.var_fe9ebcd9161bbae8 )
        {
            mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
            mdl castshadows();
        }
    }
    
    if ( level.twins_ee.var_e4f670cec623d645 )
    {
        foreach ( mdl in level.twins_ee.var_e4f670cec623d645.var_fe9ebcd9161bbae8 )
        {
            mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
            mdl castshadows();
        }
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xf0438781, Offset: 0x4f7b
// Size: 0xd9
function private function_866a1836b322a420()
{
    if ( !level.twins_ee.var_bfe7a8fe072c4610 )
    {
        return;
    }
    
    s_scene = level.twins_ee.var_bfe7a8fe072c4610;
    
    foreach ( mdl in s_scene.var_fe9ebcd9161bbae8 )
    {
        if ( mdl )
        {
            mdl setscriptablepartstate( "reveal", "reveal_out" );
            mdl dontcastshadows();
        }
    }
    
    level.twins_ee.var_bfe7a8fe072c4610 = undefined;
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xdf2f0cac, Offset: 0x505c
// Size: 0x2d9
function private function_9abcf6fe82ea6cb6( player )
{
    level thread function_e18d2a259b4f3c51( player );
    level thread function_95d1575cfe70d583( player );
    player endon( #"death_or_disconnect" );
    level endon( #"hide_and_seek_game_ended" );
    s_difficulty = level.twins_ee.var_17bba413d2e84a79[ player.var_1bea45eddc5187ac ?? "easy" ];
    var_c55b9bdfbc37dde7 = s_difficulty.var_fe4009f93fd69eff;
    level.twins_ee.var_15fc1fe51d85b1f3 = s_difficulty.var_15fc1fe51d85b1f3;
    var_70af07b5fca16ce4 = utility::getstructarray( "rv_to_hs", "targetname" );
    level.twins_ee.var_bc5272b3ff3ca101 = [];
    var_36f052c0043fe063 = 0;
    b_success = 0;
    var_d9f878a48258a825 = utility::getstruct( "gp_ly_ct", "targetname" );
    player setorigin( var_d9f878a48258a825.origin );
    player setplayerangles( var_d9f878a48258a825.angles );
    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
    wait 1;
    var_333ed03c6ac52ca6 = [];
    s_next_spawn = function_78e68c61a86560fb( player, var_70af07b5fca16ce4, var_333ed03c6ac52ca6 );
    
    for ( i = 0; i < 8 ; i++ )
    {
        for ( s_spawn = s_next_spawn; !s_spawn ; s_spawn = function_78e68c61a86560fb( player, var_70af07b5fca16ce4, var_333ed03c6ac52ca6 ) )
        {
            waitframe();
        }
        
        level.twins_ee.hide_and_seek_struct = s_spawn;
        level function_31f8354212ceddf6( s_spawn, player );
        var_53023ecd811ee54b = i == 0 ? 60 : var_c55b9bdfbc37dde7;
        var_53c548a0419c0d2f = gettime() + utility::function_4b74c15943231980( var_53023ecd811ee54b );
        var_6b1969e2c2e4220f = 0;
        
        if ( i > 0 )
        {
            player thread function_c9f668fa2779b779();
        }
        
        while ( gettime() < var_53c548a0419c0d2f )
        {
            if ( distancesquared( player.origin, s_spawn.origin ) < squared( 175 ) && utility::within_fov( player geteye(), player getplayerangles(), s_spawn.origin, cos( 60 ) ) )
            {
                var_6b1969e2c2e4220f = 1;
                break;
            }
            
            waitframe();
        }
        
        var_333ed03c6ac52ca6[ var_333ed03c6ac52ca6.size ] = s_spawn;
        
        if ( var_333ed03c6ac52ca6.size > 2 )
        {
            var_333ed03c6ac52ca6 = arrayremove( var_333ed03c6ac52ca6, var_333ed03c6ac52ca6[ 0 ] );
        }
        
        b_last_find = var_6b1969e2c2e4220f && var_36f052c0043fe063 + 1 >= 8;
        s_next_spawn = b_last_find ? undefined : function_78e68c61a86560fb( player, var_70af07b5fca16ce4, var_333ed03c6ac52ca6 );
        level function_10231dda16ee1ab6( !var_6b1969e2c2e4220f, s_next_spawn, player );
        
        if ( !var_6b1969e2c2e4220f )
        {
            break;
        }
        
        level thread function_d1a22284cd289730( s_spawn, player );
        var_36f052c0043fe063++;
    }
    
    b_success = var_36f052c0043fe063 >= 8;
    level thread function_78bc7ac82d7aed32( player, b_success );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xd67ce163, Offset: 0x533d
// Size: 0x3a
function private function_e18d2a259b4f3c51( player )
{
    level endon( #"game_ended" );
    level endon( #"hide_and_seek_game_ended" );
    player waittill( #"death_or_disconnect" );
    level cleanup_hide_and_seek_assets();
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x3942e75, Offset: 0x537f
// Size: 0x4a
function private function_95d1575cfe70d583( player )
{
    level endon( #"game_ended" );
    level endon( #"hide_and_seek_game_ended" );
    player endon( #"death_or_disconnect" );
    player waittill( #"last_stand_enter" );
    level thread function_78bc7ac82d7aed32( player, 0 );
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0x19781b1a, Offset: 0x53d1
// Size: 0xb4
function private function_78bc7ac82d7aed32( player, b_success )
{
    level notify( #"hide_and_seek_game_ended" );
    player playsoundtoplayer( "evt_scarab_minigame_warp_1", player );
    
    if ( b_success )
    {
        player utility::ent_flag_set( "completed_hide_and_seek" );
    }
    
    level zm_sat_scarab_ww_quest::function_d5ddbca43097a0ff();
    level utility::delaythread( 2, &function_4336518816e7ca20, b_success ? #"hash_db3c5244b851284b" : #"hash_3b7da7dd46d211bc", player );
    
    if ( b_success )
    {
        level function_907d6e80c7e5d7d( player );
        return;
    }
    
    s_failure = utility::getstruct( "xe_nd_gr", "targetname" );
    player utility::delaythread( 1, &function_33a540cd8a8cb8a6, s_failure );
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x84e9793d, Offset: 0x548d
// Size: 0x28
function private cleanup_hide_and_seek_assets()
{
    level notify( #"clean_up_hide_and_seek" );
    level thread cleanup_hide_and_seek_zombies();
    level cleanup_hide_and_seek_trail();
    level function_10231dda16ee1ab6( 1 );
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xb3858028, Offset: 0x54bd
// Size: 0x27b
function private function_31f8354212ceddf6( s_spawn, player )
{
    scene_config = utility::array_random( level.twins_ee.var_bbb93dc08c936fba );
    s_spawn.var_e858675410dea369 = #"hash_f0c50f3783825154";
    var_c2914619b3afef50 = vectornormalize( player.origin - s_spawn.origin );
    s_spawn.angles = ( 0, vectortoangles( var_c2914619b3afef50 )[ 1 ], 0 );
    s_spawn thread scene::play( undefined, scene_config.var_ee599c4f6e07a019, scene_config.scene );
    s_spawn.var_fe9ebcd9161bbae8 = s_spawn scene::get_entities();
    
    if ( s_spawn.var_fe9ebcd9161bbae8[ 0 ] )
    {
        s_spawn.var_fe9ebcd9161bbae8[ 0 ] thread utility::play_loop_sound_on_entity( "evt_scarab_twins_laughter_lp", ( 0, 0, 25 ) );
    }
    
    if ( scene_config.var_ee599c4f6e07a019 == "seperate_idles" && utility::cointoss() )
    {
        s_spawn.var_fe9ebcd9161bbae8[ 0 ] setmodel( %"xcomposite_sat_zmb_npc_sister_skeletal" );
        s_spawn.var_e858675410dea369 = #"dead";
    }
    else if ( scene_config.var_ee599c4f6e07a019 == "seperate_idles" )
    {
        s_spawn.var_e858675410dea369 = #"live";
    }
    
    if ( scene_config.scene == "sat_cin_zm_vig_fly_sisters_chalk" && utility::cointoss() )
    {
        s_spawn.var_fe9ebcd9161bbae8[ 0 ] setmodel( %"xcomposite_sat_zmb_npc_sister_spectral" );
        s_spawn.var_e858675410dea369 = #"live";
    }
    else if ( scene_config.scene == "sat_cin_zm_vig_fly_sisters_chalk" )
    {
        s_spawn.var_e858675410dea369 = #"dead";
    }
    
    foreach ( mdl in s_spawn.var_fe9ebcd9161bbae8 )
    {
        mdl.var_2fc3a5fb762afb6e = 1;
        mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x1c721abe, Offset: 0x5740
// Size: 0x96
function private function_626063f19c9d0ff4( player )
{
    level endon( #"game_ended" );
    level endon( #"jump_rope_game_ended" );
    wait 3;
    s_difficulty = player.var_1bea45eddc5187ac ?? "easy";
    var_3a2648b507c5d70a = s_difficulty == "easy" ? #"hash_d48f4ee0b32dc327" : #"hash_d48f4fe0b32dc4da";
    
    while ( true )
    {
        zm_quest::function_d5ef98341fd6a057( [ var_3a2648b507c5d70a ], [ player ] );
        wait randomfloatrange( 3, 5 );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xf9325912, Offset: 0x57de
// Size: 0x87
function private function_d1a22284cd289730( s_spawn, player )
{
    level endon( #"game_ended" );
    level endon( #"hide_and_seek_game_ended" );
    
    if ( !isalive( player ) )
    {
        return;
    }
    
    var_b23f009e98c86d3d = function_f464145c6b9c676( s_spawn.var_e858675410dea369 );
    
    if ( !var_b23f009e98c86d3d )
    {
        return;
    }
    
    if ( overlord::function_dce0a14273dfa0a8( [ player ] ) )
    {
        zm_quest::function_8934bb2a9028bdc5();
    }
    
    overlord::playevent( var_b23f009e98c86d3d, [ player ], undefined, undefined, 1 );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xa7e3315e, Offset: 0x586d
// Size: 0x74
function private function_f464145c6b9c676( var_e858675410dea369 )
{
    if ( var_e858675410dea369 == #"live" )
    {
        var_b23f009e98c86d3d = #"hash_84b9169a259fab6b";
    }
    else if ( var_e858675410dea369 == #"dead" )
    {
        var_b23f009e98c86d3d = #"hash_275d1be099d0a2d3";
    }
    else if ( utility::cointoss() )
    {
        var_b23f009e98c86d3d = #"hash_84b9169a259fab6b";
    }
    else
    {
        var_b23f009e98c86d3d = #"hash_275d1be099d0a2d3";
    }
    
    return var_b23f009e98c86d3d;
}

// Namespace namespace_9c11cf0d46efe829
// Params 3, eflags: 0x4
// Checksum 0xfe41e76c, Offset: 0x58ea
// Size: 0x257
function private function_10231dda16ee1ab6( b_skipped = 0, s_next_spawn, player )
{
    if ( !level.twins_ee.hide_and_seek_struct )
    {
        return;
    }
    
    scene_origin = level.twins_ee.hide_and_seek_struct.origin;
    
    if ( !b_skipped )
    {
        level endon( #"clean_up_hide_and_seek" );
        
        foreach ( mdl in level.twins_ee.hide_and_seek_struct.var_fe9ebcd9161bbae8 )
        {
            mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
            mdl dontcastshadows();
        }
        
        if ( player )
        {
            player thread shellshock_utility_cpmp::_shellshock( %"sat_concussion_grenade_mp", #"stun", 2, 1, 100 );
        }
        
        wait 1;
        
        if ( player )
        {
            level thread function_1cfa02e1e062fb05();
        }
        
        wait 1;
    }
    
    if ( level.twins_ee.hide_and_seek_struct.var_fe9ebcd9161bbae8[ 0 ] )
    {
        level.twins_ee.hide_and_seek_struct.var_fe9ebcd9161bbae8[ 0 ] utility::stop_loop_sound_on_entity( "evt_orb_spawn" );
    }
    
    foreach ( mdl in level.twins_ee.hide_and_seek_struct.var_fe9ebcd9161bbae8 )
    {
        mdl delete();
    }
    
    level.twins_ee.hide_and_seek_struct scene::stop();
    
    if ( !b_skipped && s_next_spawn )
    {
        level thread function_fb0d60974847b1a( scene_origin, s_next_spawn.origin );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x18871f26, Offset: 0x5b49
// Size: 0x2d3
function private function_1cfa02e1e062fb05()
{
    level endon( #"game_ended" );
    level endon( #"clean_up_hide_and_seek" );
    level.twins_ee.var_bc5272b3ff3ca101 = utility::function_8391781ea0784541( level.twins_ee.var_bc5272b3ff3ca101 );
    var_a217e49b89aee8ab = level.twins_ee.var_bc5272b3ff3ca101.size;
    
    if ( var_a217e49b89aee8ab >= 8 )
    {
        return;
    }
    
    n_spawn_count = int( min( level.twins_ee.var_15fc1fe51d85b1f3, 8 - var_a217e49b89aee8ab ) );
    round_number = zm_utility::get_round_number() + 2;
    quest_zombie_params = spawnstruct();
    quest_zombie_params.str_move_speed = level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "sprint" == "super_sprint" || "sprint" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "sprint" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "sprint" == "sprint" ? "run" : "sprint";
    quest_zombie_params.n_round_difficulty = round_number;
    
    for ( i = 0; i < n_spawn_count ; i++ )
    {
        zombies_count = zm_utility::get_active_zombies_count();
        
        if ( zombies_count >= level.var_a009ab14ee0d3223.var_63a0ca44b877a390 )
        {
            b_can_spawn = zm_utility::function_922d522db5f1ceda( 1, [ "normal" ] );
            
            if ( !b_can_spawn )
            {
                continue;
            }
        }
        
        zombie_type = utility::random_weighted( [ "zombie_vermin", "sat_spawner_zombie_base_zm_firefly_sunken" ], [ 1, 3 ] );
        spawners = zone_spawner::function_20c574a6ba7cc5c6( [ "zone_ee_ashwoods" ], zombie_type );
        
        if ( !spawners || spawners.size <= 0 )
        {
            continue;
        }
        
        zmb_spawner = utility::array_random( spawners );
        zombie = agent_manager::spawn_agent( zombie_type, zmb_spawner.origin, zmb_spawner.angles, "team_two_hundred" );
        
        if ( zombie )
        {
            level.twins_ee.var_bc5272b3ff3ca101[ level.twins_ee.var_bc5272b3ff3ca101.size ] = zombie;
            zombie zm_utility::setup_quest_ai( quest_zombie_params );
            zombie zm_sat_scarab_ww_quest::function_c0b1d35bc1be7a69();
        }
        
        wait 0.2;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xe0b6d551, Offset: 0x5e24
// Size: 0xda
function private cleanup_hide_and_seek_zombies()
{
    level.twins_ee.var_bc5272b3ff3ca101 = utility::function_8391781ea0784541( level.twins_ee.var_bc5272b3ff3ca101 );
    
    foreach ( zombie in level.twins_ee.var_bc5272b3ff3ca101 )
    {
        if ( isalive( zombie ) && !zombie val::get( "damageshield" ) )
        {
            zombie.nocorpse = 1;
            zombie kill();
        }
        
        waitframe();
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0x2f1735d, Offset: 0x5f06
// Size: 0x253
function private function_fb0d60974847b1a( v_start, v_end )
{
    level endon( #"hash_517dcfb3110db307" );
    level endon( #"clean_up_hide_and_seek" );
    var_502e79f53ad5ea81 = getclosestpointonnavmesh( v_start );
    var_5bf162faba029ce0 = getclosestpointonnavmesh( v_end );
    var_d00b944707343dc9 = findpathcustom( var_502e79f53ad5ea81, var_5bf162faba029ce0 );
    var_45f1c4cf1334f0fc = var_502e79f53ad5ea81 + ( 0, 0, 60 );
    e_mover = utility::spawn_model( %"tag_origin", var_45f1c4cf1334f0fc );
    trail = spawnscriptable( %"hash_55ba5246c09c4a4", var_45f1c4cf1334f0fc, ( 0, 0, 0 ) );
    level.twins_ee.trail_scriptable = trail;
    level.twins_ee.trail_mover = e_mover;
    waitframe();
    trail setscriptablepartstate( "visual", "blue_large" );
    trail utility::scriptable_setparententity( e_mover );
    n_traveled = 0;
    
    if ( var_d00b944707343dc9.size > 0 )
    {
        for ( i = 0; i < var_d00b944707343dc9.size ; i++ )
        {
            v_waypoint = var_d00b944707343dc9[ i ] + ( 0, 0, 60 );
            var_34266dd3983015ef = distance( e_mover.origin, v_waypoint );
            
            if ( var_34266dd3983015ef < 1 )
            {
                continue;
            }
            
            var_b086e76cb5b8559f = 215 - n_traveled;
            
            if ( var_34266dd3983015ef > var_b086e76cb5b8559f )
            {
                v_dir = vectornormalize( v_waypoint - e_mover.origin );
                v_waypoint = e_mover.origin + v_dir * var_b086e76cb5b8559f;
                var_34266dd3983015ef = var_b086e76cb5b8559f;
            }
            
            var_340d524f304b9c7e = var_34266dd3983015ef / 200;
            e_mover moveto( v_waypoint, var_340d524f304b9c7e );
            e_mover waittill( #"movedone" );
            n_traveled += var_34266dd3983015ef;
            
            if ( n_traveled >= 215 )
            {
                break;
            }
        }
    }
    else
    {
        v_dir = vectornormalize( var_5bf162faba029ce0 - var_502e79f53ad5ea81 );
        var_44616205278e62f2 = var_45f1c4cf1334f0fc + v_dir * 215;
        n_time = 1.075;
        e_mover moveto( var_44616205278e62f2, n_time );
        e_mover waittill( #"movedone" );
    }
    
    trail setscriptablepartstate( "impact", "blue_large" );
    wait 0.2;
    level cleanup_hide_and_seek_trail();
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x2689a04f, Offset: 0x6161
// Size: 0x6a
function private cleanup_hide_and_seek_trail()
{
    level notify( #"hash_517dcfb3110db307" );
    
    if ( level.twins_ee.trail_scriptable )
    {
        level.twins_ee.trail_scriptable freescriptable();
    }
    
    if ( level.twins_ee.trail_mover )
    {
        level.twins_ee.trail_mover delete();
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0xc
// Checksum 0x1d4799b5, Offset: 0x61d3
// Size: 0x55
function private function_c9f668fa2779b779()
{
    self notify( #"hash_88f547a878d9186f" );
    self endon( #"hash_88f547a878d9186f" );
    self endon( #"death_or_disconnect" );
    level endon( #"clean_up_hide_and_seek" );
    
    while ( true )
    {
        childthread heartbeat::function_8dc91616e5f2c60( "heartbeatLight" );
        self playsoundtoplayer( "evt_scarab_hideseek_timer", self );
        wait 1;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 3, eflags: 0x4
// Checksum 0xb88870f1, Offset: 0x6230
// Size: 0x133
function private function_78e68c61a86560fb( player, var_70af07b5fca16ce4, var_333ed03c6ac52ca6 )
{
    eye_origin = player geteye();
    view_angles = player getplayerangles();
    n_fov_dot = cos( 60 );
    a_shuffled = arrayrandomize( var_70af07b5fca16ce4 );
    
    foreach ( s_candidate in a_shuffled )
    {
        if ( var_333ed03c6ac52ca6 && var_333ed03c6ac52ca6.size && arraycontains( var_333ed03c6ac52ca6, s_candidate ) && var_70af07b5fca16ce4.size > var_333ed03c6ac52ca6.size )
        {
            continue;
        }
        
        if ( distancesquared( player.origin, s_candidate.origin ) < squared( 600 ) )
        {
            continue;
        }
        
        if ( utility::within_fov( eye_origin, view_angles, s_candidate.origin, n_fov_dot ) )
        {
            continue;
        }
        
        return s_candidate;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x85aa8f78, Offset: 0x636c
// Size: 0x1df
function private function_f01adfa074b13251( player )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    level endon( #"clones_game_ended" );
    level cleanup_chest_items();
    level thread function_90e1685ef1dafdbf( player );
    level thread function_29eda4da75e481e5( player );
    level setup_clone_game( player );
    level thread game_utility::fadetoblackforplayer( player, 0, 0.5 );
    wait 1;
    player val::reset_all( "twins_ee_clones_setup" );
    level.twins_ee.attack_ent = utility::spawn_model( "tag_origin" );
    level.twins_ee.attack_ent.team = "team_hundred_ninety";
    level utility::delaythread( 0.75, &function_4336518816e7ca20, #"hash_d15f0675976ca95d", player );
    level thread function_50442b010cf326fe( player );
    level waittill( #"hash_3f3e3d420e94d414" );
    
    foreach ( clone in level.twins_ee.a_clones )
    {
        clone thread function_1ae76181d2147d52( player );
    }
    
    level thread function_24590c8ec927c29e( player );
    var_dd40cf6520d59892 = gettime() + utility::function_4b74c15943231980( 60 );
    
    while ( gettime() < var_dd40cf6520d59892 && isalive( player ) )
    {
        if ( player.var_5f51a72b3cef4a88 >= level.twins_ee.var_ff39f41e49b0f153 )
        {
            break;
        }
        
        wait 0.5;
    }
    
    level thread function_b450941785865625( player );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x7747d7fb, Offset: 0x6553
// Size: 0x3a
function private function_90e1685ef1dafdbf( player )
{
    level endon( #"game_ended" );
    level endon( #"clones_game_ended" );
    player waittill( #"death_or_disconnect" );
    level function_dbb17a26566a17b7();
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xada07ce6, Offset: 0x6595
// Size: 0x49
function private function_29eda4da75e481e5( player )
{
    level endon( #"game_ended" );
    level endon( #"clones_game_ended" );
    player endon( #"death_or_disconnect" );
    player waittill( #"last_stand_enter" );
    level thread function_b450941785865625( player );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xb3ec9830, Offset: 0x65e6
// Size: 0x38f
function private setup_clone_game( player )
{
    player function_372a2e3943c2adb1();
    
    if ( !isdefined( level.twins_ee.clones_throttle ) )
    {
        level.twins_ee.clones_throttle = throttle::throttle_initialize( "twins_ee_clones_game", 1 );
    }
    
    s_difficulty = level.twins_ee.var_17bba413d2e84a79[ player.var_1bea45eddc5187ac ?? "easy" ];
    level.twins_ee.var_633ab497849a54fb = s_difficulty.var_633ab497849a54fb;
    var_a3552e368e706233 = utility::getstructarray( "hn_er_ts", "targetname" );
    var_a3552e368e706233 = arrayrandomize( var_a3552e368e706233 );
    var_cc28f52b14ac295c = int( min( s_difficulty.var_ff39f41e49b0f153, var_a3552e368e706233.size ) );
    level.twins_ee.var_ff39f41e49b0f153 = var_cc28f52b14ac295c;
    level.twins_ee.a_toys = [];
    
    for ( i = 0; i < var_cc28f52b14ac295c ; i++ )
    {
        toy = spawnscriptable( %"hash_41bd403c0f35557a", var_a3552e368e706233[ i ].origin, ( 0, randomint( 360 ), 0 ) );
        toy setscriptablepartstate( "model", function_7f9db0de3e87eb8b() );
        toy setscriptablepartstate( "usable", "on" );
        toy.interaction = interaction::register_scriptable_interact( toy, &function_8df45bec68a17d8, undefined, undefined, &toy_hint );
        toy.interaction.toy = toy;
        level.twins_ee.a_toys[ level.twins_ee.a_toys.size ] = toy;
    }
    
    player.var_5f51a72b3cef4a88 = 0;
    var_8a2c13dfe1738885 = utility::getstruct( "jb_ko_cs", "targetname" );
    var_8a2c13dfe1738885 thread scene::play( undefined, "dance_idle", "sat_cin_zm_vig_fly_sisters_dance" );
    var_8a2c13dfe1738885.var_fe9ebcd9161bbae8 = var_8a2c13dfe1738885 scene::get_entities();
    playfx( utility::getfx( "twins_ee_spawn" ), var_8a2c13dfe1738885.origin );
    
    foreach ( mdl in var_8a2c13dfe1738885.var_fe9ebcd9161bbae8 )
    {
        mdl.var_2fc3a5fb762afb6e = 1;
        mdl setscriptablepartstate( "reveal", "reveal_in" );
    }
    
    level.twins_ee.var_4a6a816a14b08300 = var_8a2c13dfe1738885;
    level.twins_ee.var_7d58b1f6f50ad5ce = createnavobstaclebybounds( var_8a2c13dfe1738885.origin, ( 35, 35, 75 ), var_8a2c13dfe1738885.angles );
    level.twins_ee.a_clones = [];
    
    for ( i = 0; i < s_difficulty.var_c418c5b7b616da0f ; i++ )
    {
        clone = function_b8ce1442056d20dd( player, player );
        level.twins_ee.a_clones[ level.twins_ee.a_clones.size ] = clone;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x2d05f613, Offset: 0x697d
// Size: 0x17b
function private function_372a2e3943c2adb1()
{
    player = self;
    player utility::ent_flag_set( "in_twins_ee_clones_game" );
    player val::set( "twins_ee_clones_setup", "allow_movement", 0 );
    player val::set( "twins_ee_clones_setup", "freezecontrols_allowlook", 1 );
    player val::set( "twins_ee_clones", "health_regen", 0 );
    player val::set( "twins_ee_clones", "allow_toggle_third_person", 0 );
    player.var_62b898b055222a68 = player getcamerathirdperson();
    
    if ( player.var_62b898b055222a68 )
    {
        player setcamerathirdperson( 0 );
    }
    
    player zm_utility::function_814e28ebc00f977d( "twins_ee_clones" );
    player val::set( "twins_ee_clones", "weapon_switch", 0 );
    level.twins_ee.var_8da8ee3dedcb8c12 = player.operatorcustomization.operatorref;
    level.twins_ee.var_22e6d478d494c8a3 = player.operatorcustomization.skinref;
    
    if ( player.operatorcustomization.gender == "female" )
    {
        player operator::createoperatorcustomization( %"sat_usa_pl_jill_base", %"sat_usa_pl_jill_base_infected_skin" );
    }
    else
    {
        player operator::createoperatorcustomization( %"sat_usa_pl_jack_base", %"sat_usa_pl_jack_base_infected_skin" );
    }
    
    player.var_30706510db841d4f = 0;
    player setclientomnvar( "ui_zm_is_bear_attack_quest", 0 );
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x52227196, Offset: 0x6b00
// Size: 0xc0
function private function_37b4accbb1c8c352()
{
    player = self;
    
    if ( !player utility::ent_flag( "in_twins_ee_clones_game" ) )
    {
        return;
    }
    
    player utility::ent_flag_clear( "in_twins_ee_clones_game" );
    player val::reset_all( "twins_ee_clones_setup" );
    player val::reset_all( "twins_ee_clones" );
    player zm_utility::take_fist( "twins_ee_clones" );
    
    if ( level.twins_ee.var_8da8ee3dedcb8c12 )
    {
        player operator::createoperatorcustomization( level.twins_ee.var_8da8ee3dedcb8c12, level.twins_ee.var_22e6d478d494c8a3 );
    }
    
    if ( player.var_62b898b055222a68 )
    {
        player setcamerathirdperson( 1 );
        player.var_62b898b055222a68 = undefined;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xeefee860, Offset: 0x6bc8
// Size: 0xf4
function private function_b450941785865625( player )
{
    if ( !isalive( player ) )
    {
        return;
    }
    
    level notify( #"clones_game_ended" );
    player playsoundtoplayer( "evt_scarab_minigame_warp_1", player );
    player function_37b4accbb1c8c352();
    var_b6e35db4ba0d7614 = player.var_5f51a72b3cef4a88;
    b_success = var_b6e35db4ba0d7614 >= level.twins_ee.var_ff39f41e49b0f153;
    
    if ( b_success )
    {
        player utility::ent_flag_set( "completed_weeping_angel" );
    }
    
    level zm_sat_scarab_ww_quest::function_d5ddbca43097a0ff();
    level utility::delaythread( 2, &function_4336518816e7ca20, b_success ? #"hash_37ad7a4b3119d2aa" : #"hash_834d91c1fcf0e643", player );
    
    if ( b_success )
    {
        level function_907d6e80c7e5d7d( player );
        return;
    }
    
    s_failure = utility::getstruct( "xe_nd_gr", "targetname" );
    player utility::delaythread( 1, &function_33a540cd8a8cb8a6, s_failure );
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0x94fad9f3, Offset: 0x6cc4
// Size: 0x6d
function private function_4336518816e7ca20( var_63b8c81c9923a003, player )
{
    if ( !var_63b8c81c9923a003 || !isalive( player ) )
    {
        return;
    }
    
    var_b23f009e98c86d3d = function_6bd8d4d1dca5267( var_63b8c81c9923a003 );
    
    if ( !var_b23f009e98c86d3d )
    {
        return;
    }
    
    if ( overlord::function_dce0a14273dfa0a8( [ player ] ) )
    {
        zm_quest::function_8934bb2a9028bdc5();
    }
    
    overlord::playevent( var_b23f009e98c86d3d, [ player ], undefined, undefined, 1 );
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xbfb3a88, Offset: 0x6d39
// Size: 0x158
function private function_6bd8d4d1dca5267( var_63b8c81c9923a003 )
{
    switch ( var_63b8c81c9923a003 )
    {
        case #"hash_508ad00a4d52b24f":
            return utility::array_random( [ #"hash_5d81bf85488383f2", #"hash_1ff3724395d4b1fe" ] );
        case #"hash_930cce8ebd08bc58":
            return utility::array_random( [ #"hash_9d3abe2064ae354f", #"hash_30704adf287dde27" ] );
        case #"hash_db3c5244b851284b":
            return utility::array_random( [ #"hash_faac3c466ed6bdf6", #"hash_abf5e787d1989432" ] );
        case #"hash_3b7da7dd46d211bc":
            return utility::array_random( [ #"hash_84b9169a259fab6b", #"hash_275d1be099d0a2d3" ] );
        case #"hash_d15f0675976ca95d":
            return utility::array_random( [ #"hash_e975608dbad866d4", #"hash_c7f334b1cfabae4" ] );
        case #"hash_37ad7a4b3119d2aa":
            return utility::array_random( [ #"hash_976a702394cc1495", #"hash_7f4cad6a30316719" ] );
        case #"hash_834d91c1fcf0e643":
            return utility::array_random( [ #"hash_6d48f14af2eeed6e", #"hash_c94c09b6fe2cca" ] );
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x4e5bf462, Offset: 0x6e9a
// Size: 0x1d8
function private function_50442b010cf326fe( player )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    level endon( #"clones_game_ended" );
    waitframe();
    n_timeout = gettime() + utility::function_4b74c15943231980( 15 );
    
    while ( true )
    {
        n_fov_dot = cos( getdvarfloat( @"cg_targetbasefov", 65 ) );
        
        if ( gettime() >= n_timeout )
        {
            level notify( #"hash_3f3e3d420e94d414" );
            return;
        }
        
        v_eye = player geteye();
        v_angles = player getplayerangles();
        
        foreach ( clone in level.twins_ee.a_clones )
        {
            if ( !clone )
            {
                continue;
            }
            
            b_in_fov = utility::within_fov( v_eye, v_angles, clone.origin + ( 0, 0, 58 ), n_fov_dot );
            var_c91f26ce3738add1 = b_in_fov && trace::ray_trace_passed( v_eye, clone.origin + ( 0, 0, 58 ), [ player ] );
            
            if ( var_c91f26ce3738add1 )
            {
                level notify( #"hash_3f3e3d420e94d414" );
                return;
            }
            
            level throttle::throttle_wait_in_queue( level.twins_ee.clones_throttle );
            waitframe();
        }
        
        level throttle::throttle_wait_in_queue( level.twins_ee.clones_throttle );
        waitframe();
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0xcacb5d6d, Offset: 0x707a
// Size: 0x26e
function private function_b8ce1442056d20dd( player, s_center )
{
    v_box_angles = level.twins_ee.chest.angles;
    n_back_yaw = v_box_angles[ 1 ];
    n_half_angle = 50;
    v_spawn = undefined;
    
    for ( var_38628366cb59b29a = 0; var_38628366cb59b29a < 15 ; var_38628366cb59b29a++ )
    {
        var_5ea0f98dc8a9f1f4 = n_back_yaw + randomfloatrange( n_half_angle * -1, n_half_angle );
        var_b6081b1b6ba5e8b5 = randomfloatrange( 300, 600 );
        v_dir = anglestoforward( ( 0, var_5ea0f98dc8a9f1f4, 0 ) );
        v_candidate = getclosestpointonnavmesh( s_center.origin + v_dir * var_b6081b1b6ba5e8b5 );
        b_valid = 1;
        
        foreach ( other in level.twins_ee.a_clones )
        {
            if ( other && distance2dsquared( v_candidate, other.origin ) < squared( 50 ) )
            {
                b_valid = 0;
                break;
            }
        }
        
        if ( b_valid )
        {
            v_spawn = v_candidate;
            break;
        }
    }
    
    if ( !isdefined( v_spawn ) )
    {
        v_spawn = getclosestpointonnavmesh( s_center.origin + anglestoforward( ( 0, n_back_yaw, 0 ) ) * 300 );
    }
    
    clone = spawn( "script_model", v_spawn );
    clone function_ce21f4102d5d17f6( level.twins_ee.var_22e6d478d494c8a3, %"super_combat_hologram_aether_shadow_clone" );
    v_to_center = vectornormalize( s_center.origin - v_spawn );
    clone.angles = vectortoangles( v_to_center );
    clone.var_e53c9f53f6f015c6 = function_b86b025a3a738e79();
    clone scriptmodelplayanim( clone.var_e53c9f53f6f015c6 );
    clone setscriptablepartstate( "fx", "on" );
    clone thread utility::play_loop_sound_on_entity( "amb_scarab_ee_clone_lp", ( 0, 0, 20 ) );
    return clone;
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x64fc422e, Offset: 0x72f1
// Size: 0x33a
function private function_1ae76181d2147d52( player )
{
    self endon( #"death" );
    level endon( #"clones_game_ended" );
    player endon( #"death_or_disconnect" );
    b_was_frozen = 0;
    contentoverride = trace::create_contents( 1, 0, 0, 1, 0, 0, 0 );
    
    while ( true )
    {
        n_fov_dot = cos( getdvarfloat( @"cg_targetbasefov", 65 ) );
        v_eye = player geteye();
        v_angles = player getplayerangles();
        b_in_fov = utility::within_fov( v_eye, v_angles, self.origin + ( 0, 0, 58 ), n_fov_dot );
        var_c91f26ce3738add1 = b_in_fov && trace::ray_trace_passed( v_eye, self.origin + ( 0, 0, 58 ), [ player ], contentoverride );
        var_8f9d7f48660f77ab = 140;
        
        if ( !var_c91f26ce3738add1 )
        {
            if ( b_was_frozen )
            {
                self scriptmodelplayanim( self.var_e53c9f53f6f015c6 );
                b_was_frozen = 0;
            }
            
            level throttle::throttle_wait_in_queue( level.twins_ee.clones_throttle );
            var_3a8ac98a8c8a7ba3 = vectornormalize( self.origin - player.origin );
            clone_goal_origin = player.origin + var_3a8ac98a8c8a7ba3 * 30;
            var_d00b944707343dc9 = findpathcustom( self.origin, clone_goal_origin );
            
            if ( !var_d00b944707343dc9 || var_d00b944707343dc9.size == 0 )
            {
                wait 0.2;
                continue;
            }
            
            var_b086e76cb5b8559f = var_8f9d7f48660f77ab;
            v_target = self.origin;
            
            for ( j = 0; j < var_d00b944707343dc9.size && var_b086e76cb5b8559f > 0 ; j++ )
            {
                var_34266dd3983015ef = distance( v_target, var_d00b944707343dc9[ j ] );
                
                if ( var_34266dd3983015ef <= var_b086e76cb5b8559f )
                {
                    v_target = var_d00b944707343dc9[ j ];
                    var_b086e76cb5b8559f -= var_34266dd3983015ef;
                    continue;
                }
                
                var_9363323ac2c3cf36 = vectornormalize( var_d00b944707343dc9[ j ] - v_target );
                v_target += var_9363323ac2c3cf36 * var_b086e76cb5b8559f;
                var_b086e76cb5b8559f = 0;
            }
            
            if ( !function_db9fc7999b78859a( player, v_target ) )
            {
                level throttle::throttle_wait_in_queue( level.twins_ee.clones_throttle );
                wait 0.2;
                continue;
            }
            
            level throttle::throttle_wait_in_queue( level.twins_ee.clones_throttle );
            
            if ( utility::within_fov( v_eye, v_angles, v_target + ( 0, 0, 58 ), n_fov_dot ) && trace::ray_trace_passed( v_eye, v_target + ( 0, 0, 58 ), [ player ], contentoverride ) )
            {
                wait 0.2;
                continue;
            }
            
            self.origin = v_target;
            self.angles = vectortoangles( player.origin - self.origin );
        }
        else if ( !b_was_frozen )
        {
            self scriptmodelpauseanim( 1 );
            b_was_frozen = 1;
        }
        
        level throttle::throttle_wait_in_queue( level.twins_ee.clones_throttle );
        wait 0.2;
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0x2d59e964, Offset: 0x7633
// Size: 0xd5, Type: bool
function private function_db9fc7999b78859a( player, var_46ef66f9ee751863 )
{
    if ( distance2dsquared( var_46ef66f9ee751863, player.origin ) < squared( 30 ) )
    {
        return false;
    }
    
    foreach ( other in level.twins_ee.a_clones )
    {
        if ( other == self )
        {
            continue;
        }
        
        if ( distance2dsquared( var_46ef66f9ee751863, other.origin ) < squared( 50 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0xce85fec4, Offset: 0x7711
// Size: 0x19b
function private function_24590c8ec927c29e( player )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    level endon( #"clones_game_ended" );
    
    while ( true )
    {
        foreach ( clone in level.twins_ee.a_clones )
        {
            if ( !clone )
            {
                continue;
            }
            
            if ( distance2dsquared( clone.origin, player.origin ) < squared( 60 ) )
            {
                if ( gettime() - player.var_30706510db841d4f > utility::function_4b74c15943231980( 1.5 ) )
                {
                    player dodamage( level.twins_ee.var_633ab497849a54fb, clone.origin, level.twins_ee.attack_ent, level.twins_ee.attack_ent, undefined, undefined, "torso_upper" );
                    player.var_30706510db841d4f = gettime();
                    player earthquakeforplayer( 0.15, 0.5, player.origin, 500 );
                    player playrumbleonentity( "damage_light" );
                    player playsoundtoplayer( "evt_scarab_clone_hit", player );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x419fd8fa, Offset: 0x78b4
// Size: 0x129
function private function_dbb17a26566a17b7()
{
    level function_2ac776c68eade453();
    level function_209e93c5d587ca4c();
    
    if ( level.twins_ee.attack_ent )
    {
        level.twins_ee.attack_ent delete();
    }
    
    if ( level.twins_ee.var_7d58b1f6f50ad5ce )
    {
        destroynavobstacle( level.twins_ee.var_7d58b1f6f50ad5ce );
    }
    
    if ( level.twins_ee.var_4a6a816a14b08300 )
    {
        level.twins_ee.var_4a6a816a14b08300 scene::stop();
        
        foreach ( mdl in level.twins_ee.var_4a6a816a14b08300.var_fe9ebcd9161bbae8 )
        {
            mdl delete();
        }
    }
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x8b4693a0, Offset: 0x79e5
// Size: 0xc1
function private function_2ac776c68eade453()
{
    if ( !level.twins_ee.a_clones )
    {
        return;
    }
    
    foreach ( clone in level.twins_ee.a_clones )
    {
        if ( clone )
        {
            clone utility::stop_loop_sound_on_entity( "evt_trail_lp" );
            clone delete();
        }
    }
    
    level.twins_ee.a_clones = undefined;
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x330a4566, Offset: 0x7aae
// Size: 0xb3
function private function_209e93c5d587ca4c()
{
    if ( !level.twins_ee.a_toys )
    {
        return;
    }
    
    foreach ( toy in level.twins_ee.a_toys )
    {
        if ( toy )
        {
            toy freescriptable();
        }
    }
    
    level.twins_ee.a_toys = undefined;
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x127817b2, Offset: 0x7b69
// Size: 0xa7
function private function_8df45bec68a17d8( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    player.var_5f51a72b3cef4a88 = ( player.var_5f51a72b3cef4a88 ?? 0 ) + 1;
    toy = self.toy;
    level.twins_ee.a_toys = arrayremove( level.twins_ee.a_toys, toy );
    toy setscriptablepartstate( "usable", "off" );
    player playsoundtoplayer( "uin_zm_common_pickup_item_important", player );
    toy freescriptable();
}

// Namespace namespace_9c11cf0d46efe829
// Params 2, eflags: 0x4
// Checksum 0x655b9ad9, Offset: 0x7c18
// Size: 0x36
function private toy_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0x6b3e6d51, Offset: 0x7c57
// Size: 0x72
function private function_b86b025a3a738e79()
{
    a_anims = [ "ai_t9_zm_zombie_base_super_sprint_01", "ai_t9_zm_zombie_base_super_sprint_03", "ai_t9_zm_zombie_base_super_sprint_05", "ai_t9_zm_zombie_base_super_sprint_07", "ai_t9_zm_zombie_base_super_sprint_09", "ai_t9_zm_zombie_base_super_sprint_12", "ai_t9_zm_zombie_base_super_sprint_15", "ai_t9_zm_zombie_base_super_sprint_18", "ai_t9_zm_zombie_base_super_sprint_21", "ai_t9_zm_zombie_base_super_sprint_25" ];
    return a_anims[ randomint( a_anims.size ) ];
}

// Namespace namespace_9c11cf0d46efe829
// Params 0, eflags: 0x4
// Checksum 0xb221f910, Offset: 0x7cd2
// Size: 0x69
function private function_7f9db0de3e87eb8b()
{
    a_states = [ "toy_bear", "toy_duck", "toy_elephant", "toy_giraffe", "toy_monkey", "toy_blocks", "toy_dino", "toy_dog", "toy_riding_horse" ];
    return a_states[ randomint( a_states.size ) ];
}

// Namespace namespace_9c11cf0d46efe829
// Params 1, eflags: 0x4
// Checksum 0x4c88c2d, Offset: 0x7d44
// Size: 0x171
function private function_33a540cd8a8cb8a6( s_spawn )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    str_grenade = level.equipment.table[ "equip_frag" ].weaponname;
    var_dac75f4116c98678 = s_spawn.origin + ( 0, 0, 20 );
    v_right = anglestoright( s_spawn.angles );
    v_left_pos = var_dac75f4116c98678 + v_right * -15;
    var_afe75bbb18333ac5 = var_dac75f4116c98678;
    v_right_pos = var_dac75f4116c98678 + v_right * 15;
    self playsoundtoplayer( "evt_twins_game_failure", self );
    wait 0.3;
    frag = namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( str_grenade, v_left_pos, ( randomintrange( -15, 15 ), randomintrange( -15, 15 ), 20 ), undefined, 0 );
    frag playsound( "tactical_spawn" );
    wait 0.3;
    frag = namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( str_grenade, var_afe75bbb18333ac5, ( randomintrange( -15, 15 ), randomintrange( -15, 15 ), 20 ), undefined, 0 );
    frag playsound( "tactical_spawn" );
    wait 0.3;
    frag = namespace_9d8e359c3b1041e5::launchgrenadesharedfunc( str_grenade, v_right_pos, ( randomintrange( -15, 15 ), randomintrange( -15, 15 ), 20 ), undefined, 0 );
    frag playsound( "tactical_spawn" );
}

/#

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0x4
    // Checksum 0x5aa7a289, Offset: 0x7ebd
    // Size: 0xde, Type: dev
    function private init_twins_ee_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x38>" );
        devgui::add_devgui_func( "<dev string:x52>", "<dev string:x6c>", &function_ded04fa92a8e2f2d );
        devgui::add_devgui_func( "<dev string:x80>", "<dev string:x98>", &function_a2aeca74586a3357 );
        devgui::add_devgui_func( "<dev string:xaa>", "<dev string:xde>", &function_f54e7088f49aa831 );
        devgui::add_devgui_func( "<dev string:xfc>", "<dev string:x110>", &function_826ff573a1930620 );
        devgui::add_devgui_func( "<dev string:x11e>", "<dev string:x134>", &function_fa836ee4aa1b1e45 );
        devgui::add_devgui_func( "<dev string:x144>", "<dev string:x163>", &function_93a76096e5fefb0f );
        devgui::add_devgui_func( "<dev string:x17a>", "<dev string:x19b>", &function_f3e080b1728c523a );
        devgui::add_devgui_func( "<dev string:x1b4>", "<dev string:x1cc>", &function_7ac75bdb8127fad1 );
        devgui::add_devgui_func( "<dev string:x1e4>", "<dev string:x203>", &function_7d31374a12b1e92d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0xc
    // Checksum 0xf95dd81b, Offset: 0x7fa3
    // Size: 0xed, Type: dev
    function private function_f54e7088f49aa831()
    {
        self notify( #"hash_7484379e51c3fe25" );
        self endon( #"hash_7484379e51c3fe25" );
        level endon( #"game_ended" );
        var_70af07b5fca16ce4 = utility::getstructarray( "<dev string:x216>", "<dev string:x21f>" );
        
        if ( !var_70af07b5fca16ce4 || !var_70af07b5fca16ce4.size )
        {
            iprintlnbold( "<dev string:x22a>" );
            return;
        }
        
        foreach ( s_spawn in var_70af07b5fca16ce4 )
        {
            s_spawn thread scene::play( undefined, "<dev string:x253>", "<dev string:x258>" );
        }
        
        iprintlnbold( "<dev string:x27e>" + var_70af07b5fca16ce4.size + "<dev string:x2a1>" );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0xc
    // Checksum 0x788197f4, Offset: 0x8098
    // Size: 0x84, Type: dev
    function private function_ded04fa92a8e2f2d()
    {
        self notify( #"hash_986c8489f22f84eb" );
        self endon( #"hash_986c8489f22f84eb" );
        level endon( #"game_ended" );
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        if ( !level utility::flag( "<dev string:x2b8>" ) )
        {
            return;
        }
        
        level open_music_box( 1 );
        level function_9edfdbfa003caaa4( player );
        player utility::ent_flag_set( "<dev string:x2c6>" );
        level open_toy_box( player );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0xc
    // Checksum 0x758b50e0, Offset: 0x8124
    // Size: 0x9c, Type: dev
    function private function_a2aeca74586a3357()
    {
        self notify( #"hash_59b93265aee686d4" );
        self endon( #"hash_59b93265aee686d4" );
        level endon( #"game_ended" );
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        if ( !level utility::flag( "<dev string:x2b8>" ) )
        {
            iprintlnbold( "<dev string:x2da>" );
            return;
        }
        
        level open_music_box( 1 );
        level function_9edfdbfa003caaa4( player );
        player utility::ent_flag_set( "<dev string:x2c6>" );
        player utility::ent_flag_set( "<dev string:x317>" );
        level open_toy_box( player );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0xc
    // Checksum 0xf450a570, Offset: 0x81c8
    // Size: 0x8a, Type: dev
    function private function_826ff573a1930620()
    {
        self notify( #"hash_a37dc174048e7a70" );
        self endon( #"hash_a37dc174048e7a70" );
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        player.var_1bea45eddc5187ac = "<dev string:x32f>";
        player utility::ent_flag_set( "<dev string:x2c6>" );
        player utility::ent_flag_set( "<dev string:x317>" );
        player utility::ent_flag_set( "<dev string:x334>" );
        level function_24ee233ddc7e996b( player );
        iprintlnbold( "<dev string:x34c>" );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0xc
    // Checksum 0x527aef89, Offset: 0x825a
    // Size: 0xd2, Type: dev
    function private function_fa836ee4aa1b1e45()
    {
        self notify( #"hash_c6371cf5cceb3b6" );
        self endon( #"hash_c6371cf5cceb3b6" );
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        if ( player.var_1bea45eddc5187ac != "<dev string:x388>" )
        {
            player.var_1bea45eddc5187ac = "<dev string:x32f>";
            player utility::ent_flag_set( "<dev string:x2c6>" );
            player utility::ent_flag_set( "<dev string:x317>" );
            player utility::ent_flag_set( "<dev string:x334>" );
            level function_24ee233ddc7e996b( player );
        }
        
        player utility::ent_flag_set( "<dev string:x2c6>" );
        player utility::ent_flag_set( "<dev string:x317>" );
        player utility::ent_flag_set( "<dev string:x334>" );
        level function_24ee233ddc7e996b( player );
        iprintlnbold( "<dev string:x38f>" );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0xc
    // Checksum 0x5cd653ae, Offset: 0x8334
    // Size: 0x7d, Type: dev
    function private function_93a76096e5fefb0f()
    {
        self notify( #"hash_5dc96b3bbfccd17c" );
        self endon( #"hash_5dc96b3bbfccd17c" );
        level endon( #"game_ended" );
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        s_rewards_spawn = utility::getstruct( "<dev string:x3cf>", "<dev string:x21f>" );
        iprintlnbold( "<dev string:x3d8>" );
        level thread function_babfe7a0dd995145( "<dev string:x32f>", 500, s_rewards_spawn );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0xc
    // Checksum 0xe07c0322, Offset: 0x83b9
    // Size: 0x7d, Type: dev
    function private function_f3e080b1728c523a()
    {
        self notify( #"hash_de259db3288c2d1d" );
        self endon( #"hash_de259db3288c2d1d" );
        level endon( #"game_ended" );
        player = level.players[ 0 ];
        
        if ( !player )
        {
            return;
        }
        
        s_rewards_spawn = utility::getstruct( "<dev string:x3cf>", "<dev string:x21f>" );
        iprintlnbold( "<dev string:x3f5>" );
        level thread function_babfe7a0dd995145( "<dev string:x388>", 1000, s_rewards_spawn );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0x4
    // Checksum 0x3b769e6c, Offset: 0x843e
    // Size: 0xcd, Type: dev
    function private function_7ac75bdb8127fad1()
    {
        level.players[ 0 ].var_1bea45eddc5187ac = level.players[ 0 ].var_1bea45eddc5187ac ?? "<dev string:x32f>";
        
        if ( level.players[ 0 ].var_1bea45eddc5187ac == "<dev string:x32f>" )
        {
            level.players[ 0 ].var_1bea45eddc5187ac = "<dev string:x388>";
        }
        else if ( level.players[ 0 ].var_1bea45eddc5187ac == "<dev string:x388>" )
        {
            level.players[ 0 ].var_1bea45eddc5187ac = "<dev string:x32f>";
        }
        
        iprintlnbold( "<dev string:x414>" + level.players[ 0 ].var_1bea45eddc5187ac );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0, eflags: 0x4
    // Checksum 0x20c706cd, Offset: 0x8513
    // Size: 0x99, Type: dev
    function private function_7d31374a12b1e92d()
    {
        if ( !isdefined( level.twins_ee.b_drawing_debug_line ) )
        {
            level.twins_ee.b_drawing_debug_line = 0;
        }
        
        level.twins_ee.b_drawing_debug_line = !level.twins_ee.b_drawing_debug_line;
        
        if ( level.twins_ee.b_drawing_debug_line )
        {
            level.players[ 0 ] thread function_e7ee5d8b0b578fb7();
            return;
        }
        
        level.players[ 0 ] notify( #"hash_751879c13af8bc27" );
    }

    // Namespace namespace_9c11cf0d46efe829
    // Params 0
    // Checksum 0x95db45dd, Offset: 0x85b4
    // Size: 0x86, Type: dev
    function function_e7ee5d8b0b578fb7()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"hash_751879c13af8bc27" );
        
        while ( true )
        {
            if ( level.twins_ee.chest.origin )
            {
                utility::draw_line_for_time( level.twins_ee.chest.origin, self.origin, 1, 1, 1, 0.1 );
                continue;
            }
            
            wait 0.1;
        }
    }

#/
