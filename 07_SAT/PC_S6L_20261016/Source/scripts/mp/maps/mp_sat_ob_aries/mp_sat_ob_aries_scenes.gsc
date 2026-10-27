// scripts\mp\maps\mp_sat_ob_aries\mp_sat_ob_aries_scenes.gsc  (hash_48ec1199d1f8943d.gscc) (size: 12123 Bytes / 0x2f5b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34faf276 (888861302)
// size ...... 12123 (0x2f5b)
// includes .. 4   (offset: 0x2ad7)
// strings ... 82  (offset: 0x2af7)
// dev strs .. 2   (offset: 0x2f43)
// exports ... 44  (offset: 0x1ca3)
// cseg ...... 0x8cf + 0x13d4 (0x1ca3)
// imports ... 55  (offset: 0x2383)
// animtree1 . 0   (offset: 0x2f5b)
// animtree2 . 0   (offset: 0x2f5b)
#using script_636bd827a012af12;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\mp\coop;

#namespace namespace_d11629872d017c15;

/#

    // Namespace namespace_d11629872d017c15
    // Params 0
    // Checksum 0xd6189b3e, Offset: 0x8ed
    // Size: 0x5, Type: dev
    function function_ee3cc750e96b7b9b()
    {
        
    }

#/

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x7e3ea7f1, Offset: 0x8fa
// Size: 0x28
function function_5ccc5badb7e199aa()
{
    coop::play_cinematic( "aries_level_intro", { #timeout:81, #flag:"flg_aries_intro_bink_completed" } );
}

/#

    // Namespace namespace_d11629872d017c15
    // Params 0
    // Checksum 0xa98674ff, Offset: 0x92a
    // Size: 0x5, Type: dev
    function function_3cc99c32a674f88a()
    {
        
    }

#/

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xdb9d08d9, Offset: 0x937
// Size: 0x51
function function_86e392990dd7c6f4()
{
    animnode = function_cb9480378a489439( ( 0, 0, 0 ), ( 0, 0, 0 ), "sat_cin_ari_river_pow" );
    animnode function_71e5405b970785e7();
    wait 5;
    animnode function_37eaa9b2d7138cd0();
    animnode function_8d882104d577b631();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xb400e7fd, Offset: 0x990
// Size: 0xf
function function_71e5405b970785e7()
{
    thread scene::play( undefined, "idle" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x8936db14, Offset: 0x9a7
// Size: 0xf
function function_37eaa9b2d7138cd0()
{
    scene::play( undefined, "react" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xb400e7f6, Offset: 0x9be
// Size: 0xf
function function_8d882104d577b631()
{
    scene::play( undefined, "exit" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xa474bb1e, Offset: 0x9d5
// Size: 0x3c
function function_6c125aeb31832a00()
{
    animnode = function_cb9480378a489439( ( 7713, -4709, 865.489 ), ( 0, 0, 0 ), "sat_cin_ari_river_guild_intro" );
    animnode scene::play();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x4b832d60, Offset: 0xa19
// Size: 0x3c
function function_2c83848776bc0225()
{
    animnode = function_cb9480378a489439( ( 3728.23, -8779.38, -533.709 ), ( 0, 0, 0 ), "sat_cin_ari_river_drones" );
    animnode scene::play();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xaf88cc9c, Offset: 0xa5d
// Size: 0x3c
function function_a0a2888230fb8637()
{
    animnode = function_cb9480378a489439( ( 0, 0, 0 ), ( 0, 0, 0 ), "sat_cin_ari_river_gate_hack" );
    animnode scene::play();
}

/#

    // Namespace namespace_d11629872d017c15
    // Params 0
    // Checksum 0xbdfed6c, Offset: 0xaa1
    // Size: 0x5, Type: dev
    function function_18965d7d25da11b4()
    {
        
    }

#/

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xb5dccb09, Offset: 0xaae
// Size: 0xc1
function function_e710ff2618150704()
{
    animnode = utility::getstruct( "sat_cin_ari_nightmare_trauma_interact", "targetname" );
    animnode thread scene::play( undefined, "interact" );
    scene_soldier = animnode scene::get_entity( "ally01" );
    var_d6ff40388379152e = animnode scene::get_entity( "chain02" );
    waitframe();
    scene_soldier.team = level.players[ 0 ].team;
    level notify( #"highvis_reload_outline", scene_soldier.team, [ scene_soldier ] );
    utility::flag_wait( "flag_aries_nightmare_maze_intro_combat_complete" );
    utility::flag_wait( "flg_nmr_woods_memory_1_starting" );
    scene_soldier delete();
    var_d6ff40388379152e delete();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xb24f9837, Offset: 0xb77
// Size: 0xde
function function_1479818cb43ea632()
{
    animnode = utility::getstruct( "sat_cin_ari_nightmare_trauma_1", "targetname" );
    animnode thread scene::play( undefined, "memory01" );
    waitframe();
    woods_ent = animnode scene::get_entity( "woods" );
    var_5dd575a65b1b3cf1 = animnode scene::get_entity( "ally01" );
    var_b53b462d90d98ba0 = animnode scene::get_entity( "ally02" );
    var_3d5c3483562aef7 = animnode scene::get_entity( "ally03" );
    player_team = level.players[ 0 ].team;
    level notify( #"highvis_reload_outline", player_team, [ woods_ent, var_5dd575a65b1b3cf1, var_b53b462d90d98ba0, var_3d5c3483562aef7 ] );
    animnode frozen_scene_cleanup( "flag_nm_maze_woods_memory_01_narration_complete" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x7530e3ef, Offset: 0xc5d
// Size: 0xc8
function function_cfa6e8177c92faf7()
{
    animnode = utility::getstruct( "sat_cin_ari_nightmare_trauma_2", "targetname" );
    animnode thread scene::play( undefined, "memory02" );
    waitframe();
    scene_woods = animnode scene::get_entity( "woods" );
    scene_woods_gun = animnode scene::get_entity( "woods_gun" );
    var_5a5eb273531071ea = animnode scene::get_entity( "woods_effect" );
    player_team = level.players[ 0 ].team;
    level notify( #"highvis_reload_outline", player_team, [ scene_woods ] );
    utility::flag_wait( "flg_nmr_woods_memory_2_starting" );
    scene_woods delete();
    scene_woods_gun delete();
    var_5a5eb273531071ea delete();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x5a49db47, Offset: 0xd2d
// Size: 0x239
function function_1479808cb43ea3ff()
{
    e_trauma_woods = getent( "e_trauma_woods", #targetname );
    e_trauma_alex = getent( "e_trauma_alex", #targetname );
    var_c4bfdb51d8fcad94 = getent( "e_trauma_enemy_1", #targetname );
    var_c4bfde51d8fcb42d = getent( "e_trauma_enemy_2", #targetname );
    e_trauma_gun = getent( "e_trauma_gun", #targetname );
    e_barge = getent( "smb_tower_platform_model", #targetname );
    trauma_ents = [ e_trauma_woods, e_trauma_alex, var_c4bfdb51d8fcad94, var_c4bfde51d8fcb42d, e_trauma_gun ];
    e_barge enablelinkto();
    e_barge thread function_4d9b63a592aafe8();
    trauma_ents thread function_96b46e2258fb7c66( e_barge );
    trauma_ents thread function_f5b5f66c1180a1c9( 0, 0 );
    player_team = level.players[ 0 ].team;
    e_trauma_woods.team = player_team;
    e_trauma_alex.team = "team_hundred_ninety";
    var_c4bfdb51d8fcad94.team = "team_hundred_ninety";
    var_c4bfde51d8fcb42d.team = "team_hundred_ninety";
    
    foreach ( ent in trauma_ents )
    {
        ent.visibilitymode_forced = 1;
    }
    
    level notify( #"highvis_reload_outline", undefined, [ e_trauma_woods, e_trauma_alex, var_c4bfdb51d8fcad94, var_c4bfde51d8fcb42d ] );
    level utility::flag_wait( "flg_nmr_woods_memory_2_starting" );
    trauma_ents thread function_f5b5f66c1180a1c9();
    level utility::flag_wait( "flag_nm_tower_woods_memory_02_narration_complete" );
    wait 7;
    trauma_ents thread function_f5b5f66c1180a1c9( 0 );
    trauma_ents thread function_96b46e2258fb7c66( e_barge, 0 );
    trauma_ents thread function_ccac5a62d2e72e49();
}

// Namespace namespace_d11629872d017c15
// Params 2
// Checksum 0x5d0d54dd, Offset: 0xf6e
// Size: 0xb6
function function_96b46e2258fb7c66( e_barge, var_77942e593216ba19 = 1 )
{
    memory_ents = self;
    
    foreach ( memory_ent in memory_ents )
    {
        if ( isdefined( memory_ent ) )
        {
            if ( var_77942e593216ba19 )
            {
                memory_ent enablelinkto();
                memory_ent linkto( e_barge );
                continue;
            }
            
            memory_ent unlink();
        }
    }
}

// Namespace namespace_d11629872d017c15
// Params 2
// Checksum 0xfa7268dd, Offset: 0x102c
// Size: 0xdb
function function_f5b5f66c1180a1c9( b_show = 1, var_a0248e460eb078a7 = 1 )
{
    memory_ents = self;
    
    foreach ( memory_ent in memory_ents )
    {
        if ( isdefined( memory_ent ) )
        {
            if ( memory_ent.targetname != "e_trauma_gun" && var_a0248e460eb078a7 )
            {
                memory_ent thread function_df8a3b7970f4535b( b_show );
            }
            
            if ( b_show )
            {
                memory_ent show();
                continue;
            }
            
            memory_ent hide();
        }
    }
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xa2340962, Offset: 0x110f
// Size: 0xa5
function function_ccac5a62d2e72e49()
{
    memory_ents = self;
    wait 10;
    
    foreach ( memory_ent in memory_ents )
    {
        if ( isdefined( memory_ent ) )
        {
            if ( isdefined( memory_ent.var_9d5448ad67816673 ) )
            {
                memory_ent.var_9d5448ad67816673 delete();
            }
            
            memory_ent delete();
        }
    }
}

// Namespace namespace_d11629872d017c15
// Params 1
// Checksum 0x8f016ae3, Offset: 0x11bc
// Size: 0xf3
function function_df8a3b7970f4535b( b_show )
{
    memory_ent = self;
    
    if ( b_show && !isdefined( memory_ent.var_9d5448ad67816673 ) )
    {
        memory_ent.var_9d5448ad67816673 = memory_ent utility::spawn_tag_origin();
        memory_ent.var_9d5448ad67816673.origin = memory_ent function_f1562e401aa85873();
        memory_ent.var_9d5448ad67816673 show();
        memory_ent.var_9d5448ad67816673 linkto( memory_ent );
        waitframe();
        playfxontag( level._effect[ "memory_transition" ], memory_ent.var_9d5448ad67816673, "tag_origin" );
        return;
    }
    
    var_9d5448ad67816673 = memory_ent.var_9d5448ad67816673 utility::spawn_tag_origin();
    var_9d5448ad67816673 show();
    waitframe();
    playfxontag( level._effect[ "memory_transition" ], var_9d5448ad67816673, "tag_origin" );
    wait 10;
    var_9d5448ad67816673 delete();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x2390a425, Offset: 0x12b7
// Size: 0xd1
function function_d0e831aec4c76e5b()
{
    memory_ent = self;
    var_760f5d6d454d0c78 = "memory_gun_char_spine";
    
    if ( issubstr( memory_ent.targetname, "_ankle" ) )
    {
        var_760f5d6d454d0c78 = "memory_gun_char_ankle_le";
    }
    else if ( issubstr( memory_ent.targetname, "_knee" ) )
    {
        var_760f5d6d454d0c78 = "memory_gun_char_knee_ri";
    }
    else if ( issubstr( memory_ent.targetname, "_wrist" ) )
    {
        var_760f5d6d454d0c78 = "memory_gun_char_wrist_le";
    }
    
    memory_ent show();
    waitframe();
    level utility::flag_wait( "flg_nmr_woods_memory_2_starting" );
    playfxontag( level._effect[ var_760f5d6d454d0c78 ], memory_ent, "tag_origin" );
    level utility::flag_wait( "flag_nm_tower_woods_memory_02_narration_complete" );
    wait 7;
    stopfxontag( level._effect[ var_760f5d6d454d0c78 ], memory_ent, "tag_origin" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x609c85b4, Offset: 0x1390
// Size: 0xb0
function function_f1562e401aa85873()
{
    memory_ent = self;
    s_name = undefined;
    
    switch ( memory_ent.targetname )
    {
        case #"hash_af9334c8c30c5ad0":
            s_name = "s_memory_trauma_02_alex_mason";
            break;
        case #"hash_fc962841f2527828":
            s_name = "s_memory_trauma_02_guild_01";
            break;
        case #"hash_fc962b41f2527ce1":
            s_name = "s_memory_trauma_02_guild_02";
            break;
        case #"hash_c87f3f21612717c2":
            s_name = "s_memory_trauma_02_woods_sniper";
            break;
    }
    
    var_2c2d8c5a3ddf89db = utility::getstruct( s_name, "targetname" );
    
    if ( !isdefined( var_2c2d8c5a3ddf89db ) )
    {
        var_2c2d8c5a3ddf89db = memory_ent;
    }
    
    return var_2c2d8c5a3ddf89db.origin;
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xd4f0cbba, Offset: 0x1449
// Size: 0x1cf
function function_4d9b63a592aafe8()
{
    e_barge = self;
    var_b8ef2bb2e7c667cb = [ "s_memory_trauma_02_alex_mason_vfx_spine", "s_memory_trauma_02_guild_01_vfx_spine", "s_memory_trauma_02_guild_02_vfx_spine", "s_memory_trauma_02_woods_sniper_vfx_spine", "s_memory_trauma_02_alex_mason_vfx_wrist", "s_memory_trauma_02_guild_01_vfx_wrist", "s_memory_trauma_02_guild_02_vfx_wrist", "s_memory_trauma_02_woods_sniper_vfx_wrist", "s_memory_trauma_02_alex_mason_vfx_ankle", "s_memory_trauma_02_guild_01_vfx_ankle", "s_memory_trauma_02_guild_02_vfx_ankle", "s_memory_trauma_02_woods_sniper_vfx_ankle", "s_memory_trauma_02_alex_mason_vfx_knee", "s_memory_trauma_02_guild_01_vfx_knee", "s_memory_trauma_02_guild_02_vfx_knee", "s_memory_trauma_02_woods_sniper_vfx_knee" ];
    memory_structs = [];
    
    foreach ( var_ea02fd5559145c7a in var_b8ef2bb2e7c667cb )
    {
        memory_struct = utility::getstruct( var_ea02fd5559145c7a, "targetname" );
        
        if ( isdefined( memory_struct ) )
        {
            memory_structs[ memory_structs.size ] = memory_struct;
        }
    }
    
    foreach ( memory_struct in memory_structs )
    {
        if ( isdefined( memory_struct ) )
        {
            memory_ent = memory_struct utility::spawn_tag_origin();
            memory_ent enablelinkto();
            memory_ent linkto( e_barge );
            memory_ent thread function_d0e831aec4c76e5b();
        }
    }
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xe9345f1d, Offset: 0x1620
// Size: 0x3c
function function_696967cc2db2a82b()
{
    animnode = function_cb9480378a489439( ( 0, 0, 0 ), ( 0, 0, 0 ), "sat_cin_ari_nightmare_dead_rise" );
    animnode scene::play();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x11ced218, Offset: 0x1664
// Size: 0x78
function play_nightmare_maze()
{
    animnode = function_cb9480378a489439( ( 0, 0, 0 ), ( 0, 0, 0 ), "sat_cin_ari_nightmare_maze" );
    animnode function_9133e9204024681c();
    wait 5;
    animnode function_fd966cdf68a16e69();
    wait 5;
    animnode function_e57afa26abad1ed4();
    wait 5;
    animnode function_49fc36b491c80de1();
    wait 5;
    animnode function_76a1b3059e1e5a5d();
    wait 5;
    animnode function_50ef2f17dc274bea();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x6eddd18, Offset: 0x16e4
// Size: 0xf
function function_9133e9204024681c()
{
    scene::play( undefined, "up" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xc1fedb41, Offset: 0x16fb
// Size: 0xf
function function_fd966cdf68a16e69()
{
    scene::play( undefined, "down" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xc1fedb41, Offset: 0x1712
// Size: 0xf
function function_e57afa26abad1ed4()
{
    scene::play( undefined, "left" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xdc460307, Offset: 0x1729
// Size: 0xf
function function_49fc36b491c80de1()
{
    scene::play( undefined, "right" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x43e45f71, Offset: 0x1740
// Size: 0xf
function function_76a1b3059e1e5a5d()
{
    thread scene::play( undefined, "circle" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x43e45f71, Offset: 0x1757
// Size: 0xf
function function_50ef2f17dc274bea()
{
    thread scene::play( undefined, "square" );
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x4edee365, Offset: 0x176e
// Size: 0x2
function function_c8cb27720e5a0c8d()
{
    
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x127f7336, Offset: 0x1778
// Size: 0x3c
function function_130f0fe17e8c8220()
{
    animnode = function_cb9480378a489439( ( -7538.22, 12276.8, 4418.31 ), ( 0, 0, 0 ), "sat_cin_ari_nightmare_miniboss_enter" );
    animnode scene::play();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xe9345f16, Offset: 0x17bc
// Size: 0x3c
function function_106863efd0b898ae()
{
    animnode = function_cb9480378a489439( ( 0, 0, 0 ), ( 0, 0, 0 ), "sat_cin_ari_nightmare_container" );
    animnode thread scene::play();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0xff35864e, Offset: 0x1800
// Size: 0x3c
function function_d12c615a39fc28da()
{
    animnode = function_cb9480378a489439( ( 0, 0, 0 ), ( 0, 0, 0 ), "sat_cin_ari_nightmare_container_bridge" );
    animnode scene::play();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x34b4a041, Offset: 0x1844
// Size: 0x3c
function function_31ffc710e580d806()
{
    animnode = function_cb9480378a489439( ( 0, 0, 0 ), ( 0, 0, 0 ), "sat_cin_ari_nightmare_container_spawn" );
    animnode scene::play();
}

/#

    // Namespace namespace_d11629872d017c15
    // Params 0
    // Checksum 0x56c6c0d8, Offset: 0x1888
    // Size: 0x5, Type: dev
    function function_3c005368ea9dac07()
    {
        
    }

#/

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x5cfadcd, Offset: 0x1895
// Size: 0x2e
function play_boss_outro()
{
    function_71a8560bbad8f386();
    animnode = utility::getstruct( "sat_cin_ari_boss_outro", "targetname" );
    animnode scene::pre_stream_play();
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x86c998d1, Offset: 0x18cb
// Size: 0x32
function play_exfil()
{
    coop::play_cinematic( "sat_aries_outro", { #countdown:0, #timeout:92, #flag:"aries_boss_outro_complete" } );
}

/#

    // Namespace namespace_d11629872d017c15
    // Params 0
    // Checksum 0x75290841, Offset: 0x1905
    // Size: 0x5, Type: dev
    function function_9ba0d432bb71d9ae()
    {
        
    }

#/

// Namespace namespace_d11629872d017c15
// Params 3
// Checksum 0xbb83d487, Offset: 0x1912
// Size: 0x56
function function_cb9480378a489439( var_1861bb0ab1c8aef6, struct_angles, scene_bundle )
{
    animnode = spawnstruct();
    animnode.origin = var_1861bb0ab1c8aef6;
    animnode.angles = struct_angles;
    animnode scene::set_scriptbundle( scene_bundle );
    return animnode;
}

// Namespace namespace_d11629872d017c15
// Params 1
// Checksum 0xada25079, Offset: 0x1971
// Size: 0x236
function frozen_scene_cleanup( str_flag_wait )
{
    arr_scene_ents = scene::get_entities();
    
    foreach ( ent in arr_scene_ents )
    {
        if ( ent.animname == "woods" || ent.animname == "ally01" || ent.animname == "ally02" || ent.animname == "ally03" || ent.animname == "enemy01" )
        {
            var_afb881460a65a72d = ent gettagorigin( "J_SpineUpper" );
            playfx( level._effect[ "memory_transition" ], var_afb881460a65a72d );
        }
    }
    
    if ( isdefined( str_flag_wait ) )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        level utility::flag_wait( str_flag_wait );
        
        /#
            iprintlnbold( "<dev string:x36>" );
        #/
    }
    
    wait 7;
    
    foreach ( ent in arr_scene_ents )
    {
        if ( ent.animname == "woods" || ent.animname == "ally01" || ent.animname == "ally02" || ent.animname == "ally03" || ent.animname == "enemy01" )
        {
            var_afb881460a65a72d = ent gettagorigin( "J_SpineUpper" );
            playfx( level._effect[ "memory_transition" ], var_afb881460a65a72d );
        }
        
        ent delete();
    }
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x876ea5e4, Offset: 0x1baf
// Size: 0x7b
function function_2f1eb9ab3d122f4e()
{
    foreach ( plr in level.players )
    {
        plr ob_story_mission_utils::function_5a707116af438c92();
    }
}

// Namespace namespace_d11629872d017c15
// Params 0
// Checksum 0x6c9e7d0, Offset: 0x1c32
// Size: 0x71
function function_71a8560bbad8f386()
{
    level coop::combat_cleanup();
    function_2f1eb9ab3d122f4e();
    
    if ( isdefined( level.mars_ai.stalk ) )
    {
        level.mars_ai.stalk hide();
    }
    else
    {
        mars_stalk = getent( "mars_body", #targetname );
        mars_stalk hide();
    }
    
    ob_story_mission_utils::function_f20a9fe6c594f5b3( 1 );
}

