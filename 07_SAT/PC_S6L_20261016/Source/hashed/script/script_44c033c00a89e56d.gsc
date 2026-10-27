// script_44c033c00a89e56d  (hash_44c033c00a89e56d.gscc) (size: 29618 Bytes / 0x73b2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1b80f0cb (461435083)
// size ...... 29618 (0x73b2)
// includes .. 7   (offset: 0x6fde)
// strings ... 24  (offset: 0x7016)
// dev strs .. 46  (offset: 0x7176)
// exports ... 70  (offset: 0x51d2)
// cseg ...... 0x398 + 0x4e3a (0x51d2)
// imports ... 141 (offset: 0x5cc2)
// animtree1 . 0   (offset: 0x73b2)
// animtree2 . 0   (offset: 0x73b2)
#using script_53600bb9c82cbdf2;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\zm\zm_player;

#namespace namespace_fd7b16d2452999a9;

// Namespace namespace_fd7b16d2452999a9
// Params 0
// Checksum 0xa6cd9817, Offset: 0x3b6
// Size: 0x230
function init()
{
    level.var_c9376b589ea0723 = { #var_a77dd9179d5947ce:[], #virgil_scene_struct:utility::getstruct( "bossSceneScriptStruct03", "targetname" ), #var_1ad2de468ef57426:getdvarfloat( @"hash_660e6a5688b7c76d", 1 ), #move_wave_amplitude:getdvarfloat( @"hash_3461d93fe778c818", 2000 ), #move_offset_delay_seconds:getdvarfloat( @"hash_35ed5cd5a44f40f2", 1.2 ), #fire_delay_seconds:getdvarfloat( @"hash_573aca5dd156b251", 0.65 ), #var_d550c1576ea0446c:getdvarfloat( @"hash_bb912ba8e2a4a024", 0.025 ), #var_da3a1cbbe694b617:getdvarint( @"hash_c9a783444c6258f1", 6 ), #row_span:getdvarint( @"hash_1b14136b5038f93e", 500 ), #row_offset:getdvarint( @"hash_dd370e452af2d6a1", 100 ), #orientation_structs:[], #virgil_ent:self };
    init_pattern_list();
    level.var_c9376b589ea0723.var_7494bbcfdeaed567 = 7;
    level.var_c9376b589ea0723.var_168bc891d46f24b3 = 3;
    level.var_c9376b589ea0723.var_e61f2ced69f9205b = 22;
    level.var_c9376b589ea0723.var_3c87de4ec640d314 = 5;
    level.var_c9376b589ea0723.var_d11d424a9369b797 = 2.65;
    level.var_c9376b589ea0723.var_e832d321e15e67f = 0;
    level.var_c9376b589ea0723.var_9d5a610c1fd3e652 = undefined;
    level.var_c9376b589ea0723.is_on_cooldown = 0;
    level.var_c9376b589ea0723.var_ae778f64a9db94d7 = [ "sat_zombie_virgil_runic_volley_attack_slowest":200, "sat_zombie_virgil_runic_volley_attack_slow":250, "sat_zombie_virgil_runic_volley_attack_fastest":1200, "sat_zombie_virgil_runic_volley_attack_faster_no_splash":750, "sat_zombie_virgil_runic_volley_attack_faster":750, "sat_zombie_virgil_runic_volley_attack_fast_no_splash":475, "sat_zombie_virgil_runic_volley_attack_fast":475, "sat_zombie_virgil_runic_volley_attack":400 ];
    thread function_f179ba56ce151b02();
    
    /#
        level thread projectile_attack_debug();
    #/
}

// Namespace namespace_fd7b16d2452999a9
// Params 2
// Checksum 0x6492540f, Offset: 0x5ee
// Size: 0x2d
function function_f49c3fd08787f8d3( projectile_type, projectile_asset )
{
    level.var_c9376b589ea0723.var_a77dd9179d5947ce[ projectile_type ] = projectile_asset;
}

// Namespace namespace_fd7b16d2452999a9
// Params 1, eflags: 0x4
// Checksum 0x128b7f56, Offset: 0x623
// Size: 0x154
function private function_2af01f48b0ad3ba1( volley_count = 1 )
{
    level endon( #"game_ended" );
    level.var_c9376b589ea0723.virgil_ent endon( #"hash_7ffd9295d37efbf1", #"death" );
    level.var_c9376b589ea0723.virgil_ent utility::ent_flag_set( "flag_virgil_attack_runic_volley" );
    zombie_boss_virgil::boss_play_dialogue( #"runic_volley_first" );
    level.var_c9376b589ea0723.virgil_scene_struct scene::play( self, "virgil_runic_volley_intro" );
    volley_count = volley_count == 1 ? volley_count : volley_count + 1;
    
    for ( i = 0; i < volley_count ; i++ )
    {
        level.var_c9376b589ea0723.virgil_scene_struct scene::play( self, "virgil_runic_volley_loop" );
        
        if ( function_6154e4722862b5d0() )
        {
            break;
        }
    }
    
    level.var_c9376b589ea0723.virgil_ent zombie_boss_virgil::function_682e7757f916b296( "virgil_runic_volley_outro", level.var_c9376b589ea0723.virgil_scene_struct, undefined, 0 );
    level.var_c9376b589ea0723.virgil_ent utility::ent_flag_clear( "flag_virgil_attack_runic_volley" );
    zombie_boss_virgil::function_9c386609d0280bef( #"runic_volley_first" );
}

// Namespace namespace_fd7b16d2452999a9
// Params 0, eflags: 0x4
// Checksum 0x82dfa4cf, Offset: 0x77f
// Size: 0x2d8
function private function_f179ba56ce151b02()
{
    level endon( #"game_ended" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    
    while ( true )
    {
        level.var_c9376b589ea0723.is_on_cooldown = 0;
        
        if ( level.var_c9376b589ea0723.virgil_ent function_c45daa1b5150d96d() )
        {
            level.var_c9376b589ea0723.virgil_ent thread function_2af01f48b0ad3ba1( level.var_c9376b589ea0723.var_7494bbcfdeaed567 );
            wait 1.5;
            sequence_start_time_ms = gettime();
            sequence_end_time_ms = sequence_start_time_ms + level.var_c9376b589ea0723.var_e61f2ced69f9205b * 1000;
            
            while ( gettime() < sequence_end_time_ms && !level.var_c9376b589ea0723.virgil_ent function_6154e4722862b5d0() )
            {
                orientation_struct = function_111dbd9220a7021c();
                
                if ( isdefined( orientation_struct ) )
                {
                    orientation_struct.var_d8fd544a4ec91e2a = gettime();
                    var_ed3435c6c21427d2 = undefined;
                    
                    if ( orientation_struct.pattern_count % 2 == 0 )
                    {
                        if ( orientation_struct.var_2d8d22dd17acc374.size == 0 )
                        {
                            orientation_struct.var_2d8d22dd17acc374 = level.var_c9376b589ea0723.general_patterns;
                        }
                        
                        var_ed3435c6c21427d2 = utility::array_random( orientation_struct.var_2d8d22dd17acc374 );
                        orientation_struct.var_2d8d22dd17acc374 = arrayremove( orientation_struct.var_2d8d22dd17acc374, var_ed3435c6c21427d2 );
                    }
                    else
                    {
                        if ( orientation_struct.var_2e6015c61b897a9b.size == 0 )
                        {
                            orientation_struct.var_2e6015c61b897a9b = level.var_c9376b589ea0723.var_673b4f2049f5fe07;
                        }
                        
                        var_ed3435c6c21427d2 = utility::array_random( orientation_struct.var_2e6015c61b897a9b );
                        orientation_struct.var_2e6015c61b897a9b = arrayremove( orientation_struct.var_2e6015c61b897a9b, var_ed3435c6c21427d2 );
                    }
                    
                    if ( var_ed3435c6c21427d2 )
                    {
                        if ( var_ed3435c6c21427d2 == &function_de74178a852afcc3 )
                        {
                            orientation_struct.var_d8fd544a4ec91e2a -= 500;
                        }
                        
                        self thread [[ var_ed3435c6c21427d2 ]]( orientation_struct );
                        orientation_struct.pattern_count++;
                    }
                }
                
                if ( gettime() + level.var_c9376b589ea0723.var_d11d424a9369b797 * 1000 >= sequence_end_time_ms )
                {
                    break;
                }
                
                if ( isdefined( orientation_struct ) )
                {
                    wait level.var_c9376b589ea0723.var_d11d424a9369b797;
                    continue;
                }
                
                waitframe();
            }
            
            level.var_c9376b589ea0723.is_on_cooldown = 1;
            
            while ( level.var_c9376b589ea0723.virgil_ent utility::ent_flag( "flag_virgil_attack_runic_volley" ) )
            {
                waitframe();
            }
            
            wait level.var_c9376b589ea0723.var_168bc891d46f24b3;
            continue;
        }
        
        waitframe();
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 0, eflags: 0x4
// Checksum 0x755046af, Offset: 0xa5f
// Size: 0x3e, Type: bool
function private function_c45daa1b5150d96d()
{
    if ( utility::ent_flag( "flag_virgil_totems_state_active" ) || !utility::ent_flag( "flag_virgil_runic_volley_enabled" ) || utility::ent_flag( "flag_virgil_stop_attacking" ) || !zombie_boss_virgil::function_8fc422943bc5c65a() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_fd7b16d2452999a9
// Params 0, eflags: 0x4
// Checksum 0x56577c11, Offset: 0xaa6
// Size: 0x3b, Type: bool
function private function_6154e4722862b5d0()
{
    return utility::ent_flag( "flag_virgil_stop_attacking" ) || !utility::ent_flag( "flag_virgil_runic_volley_enabled" ) || utility::ent_flag( "flag_virgil_in_pain" ) || utility::ent_flag( "flag_virgil_attack_charge_bomb_interrupt_requested" );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0xd53fc455, Offset: 0xaea
// Size: 0x73
function function_d57975e99f570875( params )
{
    if ( getdvarint( @"hash_ec565fb5cfd84b8c", 0 ) == 0 )
    {
        return anim.failure;
    }
    
    if ( !utility::ent_flag( "zombie_asm_init_finished" ) )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "flag_virgil_totems_state_active" ) || !utility::ent_flag( "flag_virgil_runic_volley_enabled" ) )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Namespace namespace_fd7b16d2452999a9
// Params 0
// Checksum 0x9e31f170, Offset: 0xb66
// Size: 0x9b
function init_pattern_list()
{
    level.var_c9376b589ea0723.runic_volley_patterns = [ &function_de74178a852afcc3, &function_7c60c7ea879031a1, &function_a98e512486b39e1b, &function_5788cb35533ee34b, &function_496d5012f8de2596 ];
    level.var_c9376b589ea0723.var_673b4f2049f5fe07 = [ &function_a98e512486b39e1b, &function_496d5012f8de2596, &function_7c60c7ea879031a1 ];
    level.var_c9376b589ea0723.general_patterns = [ &function_5788cb35533ee34b, &function_de74178a852afcc3 ];
}

// Namespace namespace_fd7b16d2452999a9
// Params 0
// Checksum 0xa62b8b47, Offset: 0xc09
// Size: 0x15
function is_on_cooldown()
{
    return level.var_c9376b589ea0723.is_on_cooldown;
}

// Namespace namespace_fd7b16d2452999a9
// Params 0
// Checksum 0xef7b9a6f, Offset: 0xc27
// Size: 0x15
function function_5ac5fa188f92dd3b()
{
    return level.var_c9376b589ea0723.orientation_structs;
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0xaea00f6d, Offset: 0xc45
// Size: 0x22
function function_8dc03d228121adda( orientation_struct )
{
    level.var_c9376b589ea0723.var_9d5a610c1fd3e652 = orientation_struct;
}

// Namespace namespace_fd7b16d2452999a9
// Params 3
// Checksum 0x49a16cc1, Offset: 0xc6f
// Size: 0xa2
function function_9b44b0b758f8469a( var_d9986820232e66db, sequence_time_sec, anim_loop_count )
{
    level.var_c9376b589ea0723.var_168bc891d46f24b3 = var_d9986820232e66db ?? level.var_c9376b589ea0723.var_168bc891d46f24b3;
    level.var_c9376b589ea0723.var_e61f2ced69f9205b = sequence_time_sec ?? level.var_c9376b589ea0723.var_e61f2ced69f9205b;
    level.var_c9376b589ea0723.var_7494bbcfdeaed567 = anim_loop_count ?? level.var_c9376b589ea0723.var_7494bbcfdeaed567;
}

// Namespace namespace_fd7b16d2452999a9
// Params 0
// Checksum 0xc4ccf655, Offset: 0xd19
// Size: 0x173
function function_111dbd9220a7021c()
{
    current_time_ms = gettime();
    var_698da660e02bf7b7 = undefined;
    var_365fc219f917c36e = undefined;
    
    if ( level.var_c9376b589ea0723.var_9d5a610c1fd3e652 )
    {
        var_f433effe16d5d111 = current_time_ms - level.var_c9376b589ea0723.var_9d5a610c1fd3e652.var_d8fd544a4ec91e2a;
        
        if ( var_f433effe16d5d111 >= level.var_c9376b589ea0723.var_3c87de4ec640d314 * 1000 )
        {
            return level.var_c9376b589ea0723.var_9d5a610c1fd3e652;
        }
    }
    
    foreach ( orientation_struct in level.var_c9376b589ea0723.orientation_structs )
    {
        var_f433effe16d5d111 = current_time_ms - orientation_struct.var_d8fd544a4ec91e2a;
        
        if ( orientation_struct.players.size > 0 && var_f433effe16d5d111 >= level.var_c9376b589ea0723.var_3c87de4ec640d314 * 1000 )
        {
            if ( !isdefined( var_365fc219f917c36e ) )
            {
                var_698da660e02bf7b7 = orientation_struct;
                var_365fc219f917c36e = var_f433effe16d5d111;
                continue;
            }
            
            if ( var_365fc219f917c36e < var_f433effe16d5d111 )
            {
                var_698da660e02bf7b7 = orientation_struct;
                var_365fc219f917c36e = var_f433effe16d5d111;
            }
        }
    }
    
    return var_698da660e02bf7b7;
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0xb615064b, Offset: 0xe95
// Size: 0x31c
function setup_arena_properties( projectile_spawn_locs )
{
    foreach ( projectile_spawn_struct in projectile_spawn_locs )
    {
        end_point_structs = utility::getstructarray( projectile_spawn_struct.target, "targetname" );
        
        foreach ( end_point_struct in end_point_structs )
        {
            id = int( end_point_struct.id );
            orientation_struct = register_orientation( projectile_spawn_struct.origin, end_point_struct.origin, id );
            orientation_struct.var_d8fd544a4ec91e2a = gettime();
            [ orientation_struct.volume ] = getnoentvolumearray( end_point_struct.target, #targetname );
            orientation_struct.players = [];
            orientation_struct.pattern_count = randomint( 6 );
            orientation_struct.var_2e6015c61b897a9b = level.var_c9376b589ea0723.var_673b4f2049f5fe07;
            orientation_struct.var_2d8d22dd17acc374 = level.var_c9376b589ea0723.general_patterns;
        }
    }
    
    foreach ( orientation_struct in level.var_c9376b589ea0723.orientation_structs )
    {
        orientation_struct.neighbors = [];
        id = orientation_struct.id;
        var_38f5f86c1748ad7e = id - 1 < 0 ? undefined : id - 1;
        var_675df3ab405c2690 = id + 1 >= level.var_c9376b589ea0723.orientation_structs.size ? undefined : id + 1;
        
        if ( isdefined( var_38f5f86c1748ad7e ) )
        {
            orientation_struct.neighbors[ orientation_struct.neighbors.size ] = level.var_c9376b589ea0723.orientation_structs[ var_38f5f86c1748ad7e ];
        }
        
        if ( isdefined( var_675df3ab405c2690 ) )
        {
            orientation_struct.neighbors[ orientation_struct.neighbors.size ] = level.var_c9376b589ea0723.orientation_structs[ var_675df3ab405c2690 ];
        }
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 0, eflags: 0xc
// Checksum 0x69f9906b, Offset: 0x11b9
// Size: 0x1af
function private function_7580a88adb23a61a()
{
    self notify( #"hash_3762d7b130b4fc1" );
    self endon( #"hash_3762d7b130b4fc1" );
    level endon( #"game_ended", #"hash_9a7f61a69ab68bec" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    
    /#
        level.var_c9376b589ea0723.watcher_active = 1;
    #/
    
    while ( true )
    {
        foreach ( orientation_struct in level.var_c9376b589ea0723.orientation_structs )
        {
            orientation_struct.players = [];
            
            foreach ( player in level.players )
            {
                if ( zm_player::function_f37cfdf04b932a03( player, 0, 0 ) && ispointinvolume( player.origin, orientation_struct.volume ) )
                {
                    orientation_struct.players[ orientation_struct.players.size ] = player;
                }
            }
            
            wait 0.2;
        }
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 0
// Checksum 0x3adcaa50, Offset: 0x1370
// Size: 0x22
function function_11135981b04b76d5()
{
    self notify( #"hash_a7edd284b88d0c8c" );
    self endon( #"hash_a7edd284b88d0c8c" );
    level thread function_7580a88adb23a61a();
}

// Namespace namespace_fd7b16d2452999a9
// Params 0
// Checksum 0xb8d10f65, Offset: 0x139a
// Size: 0xe
function function_fb1b5d4ec6ce76bd()
{
    level notify( #"hash_9a7f61a69ab68bec" );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1, eflags: 0x4
// Checksum 0x3bc7d15f, Offset: 0x13b0
// Size: 0x129
function private function_9e4de9e8aa8444e2( var_50a88292323ed49 )
{
    var_dc4fa75655c6106d = [];
    var_a888609ec6190930 = undefined;
    var_47c6d35e31617783 = undefined;
    target_player = undefined;
    
    foreach ( player in var_50a88292323ed49 )
    {
        if ( zm_player::function_f37cfdf04b932a03( player, 0, 0 ) )
        {
            if ( !isdefined( player.var_a7d0d67e79faafea ) )
            {
                var_47c6d35e31617783 = player;
                break;
            }
            else if ( !isdefined( var_a888609ec6190930 ) || player.var_a7d0d67e79faafea < var_a888609ec6190930 )
            {
                var_a888609ec6190930 = player.var_a7d0d67e79faafea;
                var_47c6d35e31617783 = player;
            }
            
            var_dc4fa75655c6106d[ var_dc4fa75655c6106d.size ] = player;
        }
    }
    
    if ( var_dc4fa75655c6106d.size > 0 || isdefined( var_47c6d35e31617783 ) )
    {
        target_player = var_47c6d35e31617783 ?? utility::array_random( var_dc4fa75655c6106d );
        target_player.var_a7d0d67e79faafea = gettime();
    }
    
    return target_player;
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x161394dd, Offset: 0x14e2
// Size: 0xb2
function function_8c29dda2d755a106( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    var_a16a02f1eb9c874c = 1100;
    spawn_position = orientation_struct.right * var_a16a02f1eb9c874c / 2 + orientation_struct.spawn_point;
    projectile_group = function_2bf88cba25ec6ca0();
    projectile_group.move_function = &function_df5668c67d2a52ca;
    projectile_group.var_57adcd74fec4bfe6 = 1;
    add_row( projectile_group, spawn_position, orientation_struct.left, var_a16a02f1eb9c874c );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0xbd3ad12e, Offset: 0x159c
// Size: 0x22f
function function_de74178a852afcc3( orientation_struct )
{
    level endon( #"game_ended", #"projectile_casting_canceled" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    row_count = 4;
    row_delay_sec = 0.3;
    row_end_offset = 200;
    var_a16a02f1eb9c874c = 1350;
    var_57ade90ef7495ea2 = 12;
    fire_delay_sec = 0.3;
    random_row_offset = 30;
    raised_end_point = orientation_struct.end_point + ( 0, 0, var_57ade90ef7495ea2 );
    var_8077a68fe0fe2877 = function_87f7644632e40fd5( orientation_struct.spawn_point, raised_end_point );
    
    for ( i = 0; i < row_count ; i++ )
    {
        spawn_position = var_8077a68fe0fe2877.right * var_a16a02f1eb9c874c / 2 + var_8077a68fe0fe2877.spawn_point;
        projectile_group = function_2bf88cba25ec6ca0();
        projectile_group.move_function = &function_df5668c67d2a52ca;
        projectile_group.var_57adcd74fec4bfe6 = 1;
        projectile_group.projectile_asset = level.var_c9376b589ea0723.var_a77dd9179d5947ce[ 1 ] ?? "sat_zombie_virgil_runic_volley_attack_fast_no_splash";
        projectile_group.var_2168b89bac4ac31c = fire_delay_sec;
        
        if ( i % 2 == 1 )
        {
            projectile_group.end_point_offset = var_8077a68fe0fe2877.left * row_end_offset;
        }
        else
        {
            projectile_group.end_point_offset = var_8077a68fe0fe2877.right * row_end_offset;
        }
        
        if ( i > 0 )
        {
            projectile_group.warning_disabled = 1;
        }
        else
        {
            level thread function_f24afc365c84479e( %"sat_zombie_virgil_runic_volley_isa", projectile_group, var_8077a68fe0fe2877 );
        }
        
        add_row( projectile_group, spawn_position, var_8077a68fe0fe2877.left, var_a16a02f1eb9c874c, undefined, random_row_offset );
        level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, var_8077a68fe0fe2877 );
        wait row_delay_sec;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0xd27150a8, Offset: 0x17d3
// Size: 0x15f
function function_94936d06ed919c13( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    var_ccc694c606d93d87 = 1100;
    var_3f1dfe9731b45471 = 4;
    clump_span = var_ccc694c606d93d87 / var_3f1dfe9731b45471;
    clump_vertical_offset = 100;
    spawn_position = orientation_struct.right * var_ccc694c606d93d87 / 2 + orientation_struct.spawn_point;
    projectile_group = function_2bf88cba25ec6ca0();
    projectile_group.move_function = &function_df5668c67d2a52ca;
    projectile_group.var_57adcd74fec4bfe6 = 1;
    add_row( projectile_group, spawn_position, orientation_struct.left, clump_span );
    var_3be5ddb097e421dd = 1;
    
    for ( var_ad1965190f7e7385 = var_3f1dfe9731b45471 - 1; var_ad1965190f7e7385 > 0 ; var_ad1965190f7e7385-- )
    {
        spawn_position += orientation_struct.left * clump_span;
        
        if ( var_3be5ddb097e421dd )
        {
            offset_spawn_position = spawn_position + ( 0, 0, clump_vertical_offset );
            add_row( projectile_group, offset_spawn_position, orientation_struct.left, clump_span );
        }
        else
        {
            add_row( projectile_group, spawn_position, orientation_struct.left, clump_span );
        }
        
        var_3be5ddb097e421dd = !var_3be5ddb097e421dd;
    }
    
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0xfc7c2ed9, Offset: 0x193a
// Size: 0x8c
function function_ea35954756fb6cf7( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    var_2ae7b4e3ea6f31dc = 125;
    projectile_group = function_2bf88cba25ec6ca0();
    projectile_group.move_function = &function_df5668c67d2a52ca;
    projectile_group.var_57adcd74fec4bfe6 = 1;
    projectile_group.end_point_height_offset = var_2ae7b4e3ea6f31dc;
    function_a9d38f4674e47628( projectile_group, orientation_struct, var_2ae7b4e3ea6f31dc );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x5589903e, Offset: 0x19ce
// Size: 0x60
function function_9690a2e2cad899c7( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    projectile_group = function_2bf88cba25ec6ca0();
    function_cb10b0a77e7ca2c7( projectile_group, orientation_struct.spawn_point, orientation_struct, 250 );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x792cd0d0, Offset: 0x1a36
// Size: 0x7f
function function_fa5336af0bbae879( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    var_d5aae36f45fd0ea = 1100;
    projectile_group = function_2bf88cba25ec6ca0();
    projectile_group.move_function = &function_df5668c67d2a52ca;
    projectile_group.var_57adcd74fec4bfe6 = 1;
    function_5629af373f20ea72( projectile_group, orientation_struct, var_d5aae36f45fd0ea );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x996d9862, Offset: 0x1abd
// Size: 0x60
function function_2c75577e29c3f76e( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    var_4abe3e2d7721f813 = 350;
    projectile_group = function_2bf88cba25ec6ca0();
    function_4a848b9733fef812( projectile_group, orientation_struct, var_4abe3e2d7721f813 );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x5c8ef4d4, Offset: 0x1b25
// Size: 0x52
function function_623b1439ca23e6da( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    projectile_group = function_2bf88cba25ec6ca0();
    function_aab5434c9d8df856( projectile_group, orientation_struct );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x33fb610a, Offset: 0x1b7f
// Size: 0x55
function function_a3f94321ada8ceb( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    projectile_group = function_2bf88cba25ec6ca0();
    function_73faa9fe56de3ec3( projectile_group, orientation_struct, 320 );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x26686413, Offset: 0x1bdc
// Size: 0x8e
function function_a98e512486b39e1b( orientation_struct )
{
    level endon( #"game_ended", #"projectile_casting_canceled" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    var_1964f431d91f476b = 1.75;
    var_46737650a879100a = 3;
    
    for ( i = 0; i < var_46737650a879100a ; i++ )
    {
        level thread function_ad68a9825d4838ae( orientation_struct );
        wait var_1964f431d91f476b;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x9f83a9e1, Offset: 0x1c72
// Size: 0x2bb
function function_ad68a9825d4838ae( orientation_struct )
{
    level endon( #"game_ended", #"projectile_casting_canceled" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    min_height_offset = -100;
    max_height_offset = 800;
    back_offset = 50;
    span = 300;
    var_d152cf7bb0a3d542 = 3;
    var_2083f44e47dfe64d = 0.2;
    var_2805de8cb95cd19c = 250;
    fire_delay_sec = 0.2;
    target_random_offset = 15;
    random_row_offset = 20;
    var_50a88292323ed49 = orientation_struct.players;
    spawn_point = orientation_struct.spawn_point;
    spawn_point += orientation_struct.backward * back_offset;
    spawn_point += vectorlerp( orientation_struct.left * var_2805de8cb95cd19c, orientation_struct.right * var_2805de8cb95cd19c, randomfloatrange( 0, 1 ) );
    spawn_point += orientation_struct.up * randomintrange( min_height_offset, max_height_offset );
    target_player = function_9e4de9e8aa8444e2( var_50a88292323ed49 );
    
    if ( !isdefined( target_player.origin ) )
    {
        var_8077a68fe0fe2877 = function_87f7644632e40fd5( spawn_point, orientation_struct.end_point );
    }
    else
    {
        target_position = target_player.origin + ( randomintrange( target_random_offset * -1, target_random_offset ), randomintrange( target_random_offset * -1, target_random_offset ), 0 );
        var_8077a68fe0fe2877 = function_87f7644632e40fd5( spawn_point, target_position );
    }
    
    for ( i = 0; i < var_d152cf7bb0a3d542 ; i++ )
    {
        projectile_group = function_2bf88cba25ec6ca0();
        projectile_group.projectile_asset = level.var_c9376b589ea0723.var_a77dd9179d5947ce[ 3 ] ?? "sat_zombie_virgil_runic_volley_attack_fastest";
        projectile_group.var_2168b89bac4ac31c = fire_delay_sec;
        function_93794e26584834d2( projectile_group, var_8077a68fe0fe2877, span, undefined, random_row_offset );
        
        if ( i > 0 )
        {
            projectile_group.var_d550c1576ea0446c = 0;
            projectile_group.fire_delay_seconds = var_2083f44e47dfe64d;
            projectile_group.warning_disabled = 1;
        }
        
        if ( i == 0 )
        {
            level thread function_f24afc365c84479e( %"sat_zombie_virgil_runic_volley_sowilo", projectile_group, var_8077a68fe0fe2877 );
        }
        
        level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, var_8077a68fe0fe2877 );
        
        if ( !projectile_group.fired )
        {
            projectile_group waittill( #"hash_462e7d9c4cc01609" );
        }
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0xdb41e02b, Offset: 0x1f35
// Size: 0x5b0
function function_5788cb35533ee34b( orientation_struct )
{
    level endon( #"game_ended", #"projectile_casting_canceled" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    thorn_span = 175;
    var_dde8b4fbbc72a9a9 = 30;
    var_80e2ad5200db28c1 = 400;
    var_e0b823bd56e8ec7 = 500;
    row_span = 1350;
    var_2c2e74ffbd350419 = row_span / 2;
    var_a827d56139b4e131 = 0.35;
    var_12f0a7b278a240a2 = 0.2;
    thorn_count = 10;
    var_c864c3f7ef18c834 = thorn_count * var_a827d56139b4e131;
    var_e21c5ef49a619079 = [ [ 150, 450, 750, 1050, 150, 450, 750, 1050, 150, 450 ], [ 1050, 300, 600, 225, 675, 975, 375, 900, 375, 750 ], [ 375, 975, 675, 300, 1050, 600, 75, 525, 825, 375 ], [ 825, 450, 150, 750, 75, 675, 300, 1050, 525, 225 ], [ 450, 150, 825, 375, 900, 75, 750, 1050, 500, 150 ], [ 450, 150, 750, 375, 975, 675, 300, 1050, 75, 450 ], [ 225, 750, 1050, 600, 975, 150, 525, 75, 1050, 450 ] ];
    trace_contents = trace::create_solid_ai_contents( 1 );
    projectile_group = function_2bf88cba25ec6ca0();
    projectile_group.warning_only = 1;
    projectile_group.fire_delay_seconds = var_c864c3f7ef18c834;
    row_spawn_position = orientation_struct.right * var_2c2e74ffbd350419 + orientation_struct.spawn_point;
    add_row( projectile_group, row_spawn_position, orientation_struct.left, row_span );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, orientation_struct );
    level thread function_f24afc365c84479e( %"sat_zombie_virgil_runic_volley_thurisaz", projectile_group, orientation_struct );
    projectile_group waittill( #"hash_b64e98d14f43d63e" );
    var_6bb330674487800e = utility::array_random( var_e21c5ef49a619079 );
    
    foreach ( offset in var_6bb330674487800e )
    {
        var_dee1ed08315d0377 = function_2bf88cba25ec6ca0();
        var_dee1ed08315d0377.move_function = &function_df5668c67d2a52ca;
        var_dee1ed08315d0377.var_57adcd74fec4bfe6 = 1;
        var_dee1ed08315d0377.warning_disabled = 0;
        var_dee1ed08315d0377.fire_delay_seconds = var_12f0a7b278a240a2;
        var_dee1ed08315d0377.end_point_height_offset = thorn_span + var_dde8b4fbbc72a9a9;
        var_dee1ed08315d0377.projectile_asset = level.var_c9376b589ea0723.var_a77dd9179d5947ce[ 4 ] ?? "sat_zombie_virgil_runic_volley_attack_faster_no_splash";
        row_spawn_position = orientation_struct.right * var_2c2e74ffbd350419 + orientation_struct.spawn_point;
        row_end_position = orientation_struct.right * var_2c2e74ffbd350419 + orientation_struct.end_point;
        thorn_spawn_position = row_spawn_position + orientation_struct.left * offset;
        thorn_end_position = row_end_position + orientation_struct.left * offset;
        thorn_end_position += orientation_struct.var_bf30640a063c878e * var_80e2ad5200db28c1;
        result = trace::ray_trace( thorn_spawn_position, thorn_end_position + orientation_struct.dir_vector * var_e0b823bd56e8ec7, undefined, trace_contents );
        thorn_end_position = result[ "hittype" ] == "hittype_world" ? result[ "position" ] : thorn_end_position;
        var_8077a68fe0fe2877 = function_87f7644632e40fd5( thorn_spawn_position, thorn_end_position );
        function_d85070bf169d204( var_dee1ed08315d0377, var_8077a68fe0fe2877, thorn_span );
        level thread function_f24afc365c84479e( %"sat_zombie_virgil_runic_volley_thurisaz_thorn", var_dee1ed08315d0377, var_8077a68fe0fe2877 );
        level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( var_dee1ed08315d0377, var_8077a68fe0fe2877 );
        wait var_a827d56139b4e131;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x2d8aca07, Offset: 0x24ed
// Size: 0x248
function function_496d5012f8de2596( orientation_struct )
{
    level endon( #"game_ended", #"projectile_casting_canceled" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    span = 800;
    var_2c04b367f8c987c5 = 3;
    arrow_offset = 200;
    var_287928d7ae660887 = 1.5;
    var_7ed8554a5062542d = 1.25;
    var_4e50d590d925a3d7 = 150;
    current_offset = 0;
    var_558e2d53a62419d7 = 0;
    spawn_point = orientation_struct.spawn_point;
    spawn_point += orientation_struct.up * 300;
    
    for ( i = 0; i < var_2c04b367f8c987c5 ; i++ )
    {
        spawn_point += orientation_struct.down * current_offset;
        end_point = orientation_struct.end_point + orientation_struct.down * current_offset;
        var_8077a68fe0fe2877 = function_87f7644632e40fd5( spawn_point, end_point );
        projectile_group = function_2bf88cba25ec6ca0();
        projectile_group.var_dafadb505a321868 = orientation_struct;
        projectile_group.fire_delay_seconds += var_558e2d53a62419d7;
        projectile_group.move_function = &function_3a0edb61f00c2b59;
        projectile_group.projectile_asset = level.var_c9376b589ea0723.var_a77dd9179d5947ce[ 5 ] ?? "sat_zombie_virgil_runic_volley_attack_faster";
        projectile_group.var_7ed8554a5062542d = var_7ed8554a5062542d;
        projectile_group.var_4e50d590d925a3d7 = var_4e50d590d925a3d7;
        projectile_group.spawn_point = spawn_point;
        projectile_group.end_point = end_point;
        projectile_group.var_2168b89bac4ac31c = randomfloat( 0.5 );
        function_b963ba444a18cbca( projectile_group, var_8077a68fe0fe2877, 0, span );
        level thread function_f24afc365c84479e( %"sat_zombie_virgil_runic_volley_tyr", projectile_group, var_8077a68fe0fe2877 );
        level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, var_8077a68fe0fe2877 );
        current_offset += arrow_offset;
        var_558e2d53a62419d7 += var_287928d7ae660887;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 1
// Checksum 0x8150033d, Offset: 0x273d
// Size: 0x106
function function_7c60c7ea879031a1( orientation_struct )
{
    /#
        orientation_struct = function_c1b92be8c84e8b31( orientation_struct );
    #/
    
    height_offset = 300;
    span = 500;
    end_back_offset = 300;
    spawn_point = orientation_struct.spawn_point;
    spawn_point += orientation_struct.up * height_offset;
    end_point = orientation_struct.end_point + orientation_struct.var_bf30640a063c878e * end_back_offset;
    var_8077a68fe0fe2877 = function_87f7644632e40fd5( spawn_point, end_point );
    projectile_group = function_2bf88cba25ec6ca0();
    projectile_group.warning_only = 1;
    function_ea52ee19847a4e4d( projectile_group, var_8077a68fe0fe2877, span );
    level thread function_f24afc365c84479e( %"sat_zombie_virgil_runic_volley_hagalaz", projectile_group, var_8077a68fe0fe2877 );
    level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, var_8077a68fe0fe2877 );
    level thread function_c9fcb4d7f4c8fd74( projectile_group, var_8077a68fe0fe2877 );
}

// Namespace namespace_fd7b16d2452999a9
// Params 2
// Checksum 0xdb099ce2, Offset: 0x284b
// Size: 0x1aa
function function_c9fcb4d7f4c8fd74( projectile_group, orientation_struct )
{
    level endon( #"game_ended", #"projectile_casting_canceled" );
    level.var_c9376b589ea0723.virgil_ent endon( #"death" );
    var_81cb28a61e76c30d = 90;
    projectile_group waittill( #"hash_462e7d9c4cc01609" );
    var_b3f24ecd8de21cef = [ "sat_zombie_virgil_runic_volley_attack_fast", "sat_zombie_virgil_runic_volley_attack", "sat_zombie_virgil_runic_volley_attack_slow" ];
    var_70a2bd3be3dded9a = int( var_81cb28a61e76c30d / var_b3f24ecd8de21cef.size );
    
    for ( i = 0; i < var_b3f24ecd8de21cef.size ; i++ )
    {
        var_1cd24bbe2bac6f52 = function_2bf88cba25ec6ca0();
        var_448b4251341dd66f = 0;
        
        for ( j = 0; j < var_70a2bd3be3dded9a ; j++ )
        {
            if ( var_448b4251341dd66f < projectile_group.projectile_positions.size )
            {
                add_position( var_1cd24bbe2bac6f52, projectile_group.projectile_positions[ var_448b4251341dd66f ] );
                var_448b4251341dd66f++;
                continue;
            }
            
            add_position( var_1cd24bbe2bac6f52, utility::array_random( projectile_group.projectile_positions ) );
        }
        
        var_1cd24bbe2bac6f52.fire_delay_seconds = 0;
        var_1cd24bbe2bac6f52.var_d550c1576ea0446c = 0;
        var_1cd24bbe2bac6f52.var_2168b89bac4ac31c = 0.2;
        var_1cd24bbe2bac6f52.move_function = &move_random_direction;
        var_1cd24bbe2bac6f52.projectile_asset = var_b3f24ecd8de21cef[ i ];
        var_1cd24bbe2bac6f52.warning_disabled = 1;
        level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( var_1cd24bbe2bac6f52, orientation_struct );
        waitframe();
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 3
// Checksum 0xc2c1ed35, Offset: 0x29fd
// Size: 0x100
function function_a9d38f4674e47628( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span )
{
    var_165934b7a6978379 = 5;
    cross_width = 2 * span;
    var_9393adf3415a5188 = cross_width * var_165934b7a6978379;
    var_c57711104033edbc = int( floor( var_165934b7a6978379 / 2 ) );
    
    if ( var_165934b7a6978379 % 2 == 0 )
    {
        var_c57711104033edbc -= 0.5;
    }
    
    var_c57711104033edbc *= cross_width;
    cross_center_pos = orientation_struct.spawn_point + orientation_struct.right * var_c57711104033edbc;
    function_cb10b0a77e7ca2c7( projectile_group, cross_center_pos, orientation_struct, span );
    
    for ( var_8d59fcbf173648d2 = var_165934b7a6978379 - 1; var_8d59fcbf173648d2 > 0 ; var_8d59fcbf173648d2-- )
    {
        cross_center_pos += cross_width * orientation_struct.left;
        function_cb10b0a77e7ca2c7( projectile_group, cross_center_pos, orientation_struct, span );
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 3
// Checksum 0xf7f2b307, Offset: 0x2b05
// Size: 0xe4
function function_5629af373f20ea72( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span )
{
    var_9787898f4ce6ad19 = 11;
    left_diag = vectornormalize( ( orientation_struct.up - orientation_struct.left ) / var_9787898f4ce6ad19 + orientation_struct.left );
    right_diag = vectornormalize( ( orientation_struct.up - orientation_struct.right ) / var_9787898f4ce6ad19 + orientation_struct.right );
    add_row( projectile_group, orientation_struct.spawn_point, left_diag, span / 2 );
    add_row( projectile_group, orientation_struct.spawn_point, right_diag, span / 2 );
}

// Namespace namespace_fd7b16d2452999a9
// Params 5
// Checksum 0x8a40e2de, Offset: 0x2bf1
// Size: 0x11a
function function_cb10b0a77e7ca2c7( projectile_group, spawn_pos, orientation_struct, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset )
{
    height_offset = span;
    top_pos = spawn_pos + orientation_struct.up * height_offset;
    bot_pos = spawn_pos + orientation_struct.down * height_offset;
    var_c4d1fb3e0ccd2ef0 = span * 1.414;
    add_row( projectile_group, top_pos, orientation_struct.left_down, var_c4d1fb3e0ccd2ef0, offset );
    add_row( projectile_group, top_pos, orientation_struct.right_down, var_c4d1fb3e0ccd2ef0, offset );
    add_row( projectile_group, bot_pos, orientation_struct.right_up, var_c4d1fb3e0ccd2ef0, offset );
    add_row( projectile_group, bot_pos, orientation_struct.left_up, var_c4d1fb3e0ccd2ef0, offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 4
// Checksum 0x1b7f033a, Offset: 0x2d13
// Size: 0x1ba
function function_4a848b9733fef812( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset )
{
    var_19bfbcd20e7979c9 = orientation_struct.left_up * span + orientation_struct.spawn_point;
    var_7e08081498a79ca6 = orientation_struct.right_up * span + orientation_struct.spawn_point;
    left_up_displacement = orientation_struct.left_up * span;
    dot = vectordot( left_up_displacement, orientation_struct.left );
    var_e13e4747c8dcfdcd = sqrt( squared( span ) - squared( dot ) );
    pole_length = var_e13e4747c8dcfdcd * 2;
    add_row( projectile_group, orientation_struct.spawn_point, orientation_struct.left_up, span, offset );
    add_row( projectile_group, orientation_struct.spawn_point, orientation_struct.right_up, span, offset );
    add_row( projectile_group, orientation_struct.spawn_point, orientation_struct.left_down, span, offset );
    add_row( projectile_group, orientation_struct.spawn_point, orientation_struct.right_down, span, offset );
    add_row( projectile_group, var_19bfbcd20e7979c9, orientation_struct.down, pole_length, offset );
    add_row( projectile_group, var_7e08081498a79ca6, orientation_struct.down, pole_length, offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 4
// Checksum 0x4bc2daea, Offset: 0x2ed5
// Size: 0x198
function function_73faa9fe56de3ec3( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset )
{
    left_up_displacement = orientation_struct.left_up * span;
    dot = vectordot( left_up_displacement, orientation_struct.left );
    var_e13e4747c8dcfdcd = sqrt( squared( span ) - squared( dot ) );
    pole_length = var_e13e4747c8dcfdcd * 2;
    start_pos = orientation_struct.spawn_point + orientation_struct.right * pole_length;
    var_2a4694e6a5bb573a = start_pos + orientation_struct.left_up * span;
    var_e2175bb0192cb657 = orientation_struct.spawn_point + orientation_struct.left_up * span;
    add_row( projectile_group, start_pos, orientation_struct.left, pole_length * 2, offset );
    add_row( projectile_group, var_2a4694e6a5bb573a, orientation_struct.left_down, span, offset );
    add_row( projectile_group, var_2a4694e6a5bb573a, orientation_struct.right_down, span, offset );
    add_row( projectile_group, var_e2175bb0192cb657, orientation_struct.left_down, span, offset );
    add_row( projectile_group, var_e2175bb0192cb657, orientation_struct.right_down, span, offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 4
// Checksum 0x3d23aefe, Offset: 0x3075
// Size: 0xdc
function function_d85070bf169d204( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset )
{
    height = span;
    angle = 30;
    var_2e25eba6092fe4fd = height / cos( angle );
    top = orientation_struct.spawn_point + orientation_struct.down * height;
    add_row( projectile_group, top, orientation_struct.right_up, var_2e25eba6092fe4fd, offset );
    add_row( projectile_group, top, orientation_struct.left_up, var_2e25eba6092fe4fd, offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 5
// Checksum 0x67532418, Offset: 0x3159
// Size: 0x136
function function_b963ba444a18cbca( projectile_group, orientation_struct, arrow_height_offset = 0, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset )
{
    height = span;
    half_height = height / 2;
    angle = 30;
    var_2e25eba6092fe4fd = height / 3 / cos( angle );
    bottom = orientation_struct.spawn_point + orientation_struct.down * half_height;
    add_row( projectile_group, bottom, orientation_struct.up, height - arrow_height_offset, offset );
    top = bottom + orientation_struct.up * ( height - arrow_height_offset );
    add_row( projectile_group, top, orientation_struct.right_down, var_2e25eba6092fe4fd, offset );
    add_row( projectile_group, top, orientation_struct.left_down, var_2e25eba6092fe4fd, offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 4
// Checksum 0x30a1084b, Offset: 0x3297
// Size: 0x22b
function function_ea52ee19847a4e4d( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset )
{
    center_length = span;
    var_49de4cc129941702 = center_length / 2;
    pole_length = center_length * 2;
    var_e13e4747c8dcfdcd = pole_length / 2;
    center_offset = pole_length / 3;
    var_33c3c7a72830622d = orientation_struct.spawn_point + orientation_struct.right * var_49de4cc129941702;
    var_5ca99b29e55b60b3 = orientation_struct.spawn_point + orientation_struct.left * var_49de4cc129941702;
    var_d2002d766e269b87 = var_33c3c7a72830622d + orientation_struct.up * var_e13e4747c8dcfdcd;
    var_29fc6ec58b685389 = var_5ca99b29e55b60b3 + orientation_struct.up * var_e13e4747c8dcfdcd;
    center_top = var_d2002d766e269b87 + center_offset * orientation_struct.down;
    center_bottom = var_29fc6ec58b685389 + center_offset * 2 * orientation_struct.down;
    center_dir = vectornormalize( center_bottom - center_top );
    var_e5353850c391afbc = distance( var_33c3c7a72830622d, center_top );
    var_43b7208115dd9c30 = sqrt( squared( var_49de4cc129941702 ) + squared( var_e5353850c391afbc ) ) * 2;
    center_top += center_dir * level.var_c9376b589ea0723.row_offset;
    center_bottom += center_dir * -1 * level.var_c9376b589ea0723.row_offset;
    var_43b7208115dd9c30 -= level.var_c9376b589ea0723.row_offset * 2;
    add_row( projectile_group, var_d2002d766e269b87, orientation_struct.down, pole_length, offset );
    add_row( projectile_group, var_29fc6ec58b685389, orientation_struct.down, pole_length, offset );
    add_row( projectile_group, center_top, center_dir, var_43b7208115dd9c30, offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 5
// Checksum 0xeea99f10, Offset: 0x34ca
// Size: 0x14d
function function_93794e26584834d2( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset, random_additional_offset = 0 )
{
    center_length = span;
    var_49de4cc129941702 = center_length / 2;
    edge_length = int( 0.75 * center_length );
    center_top = orientation_struct.spawn_point + orientation_struct.right_up * var_49de4cc129941702;
    center_bottom = orientation_struct.spawn_point + orientation_struct.right_down * var_49de4cc129941702;
    edge_top = center_top + orientation_struct.left_up * edge_length;
    add_row( projectile_group, edge_top, orientation_struct.left_down, edge_length, offset, random_additional_offset );
    add_row( projectile_group, center_top, orientation_struct.right_down, center_length, offset, random_additional_offset );
    add_row( projectile_group, center_bottom, orientation_struct.left_down, edge_length, offset, random_additional_offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 4
// Checksum 0xdfaf29db, Offset: 0x361f
// Size: 0x11f
function function_aab5434c9d8df856( projectile_group, orientation_struct, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset )
{
    var_19bfbcd20e7979c9 = orientation_struct.left_down * span + orientation_struct.spawn_point;
    var_7e08081498a79ca6 = orientation_struct.right_down * span + orientation_struct.spawn_point;
    add_row( projectile_group, orientation_struct.spawn_point, orientation_struct.right_down, span, offset );
    add_row( projectile_group, var_7e08081498a79ca6, orientation_struct.left_down, span * 2, offset );
    add_row( projectile_group, orientation_struct.spawn_point, orientation_struct.left_down, span, offset );
    add_row( projectile_group, var_19bfbcd20e7979c9, orientation_struct.right_down, span * 2, offset );
}

// Namespace namespace_fd7b16d2452999a9
// Params 6
// Checksum 0x4672e306, Offset: 0x3746
// Size: 0x107
function add_row( projectile_group, start_pos, direction, span = level.var_c9376b589ea0723.row_span, offset = level.var_c9376b589ea0723.row_offset, random_additional_offset = 0 )
{
    var_1a4f3a64a7f979cd = span / offset;
    var_ce16ac20c47bdba6 = ceil( var_1a4f3a64a7f979cd );
    adjusted_offset = span / var_ce16ac20c47bdba6;
    var_81cb28a61e76c30d = int( span / adjusted_offset ) + 1;
    current_offset = 0;
    
    while ( var_81cb28a61e76c30d > 0 )
    {
        var_27bf268ca6071c5 = current_offset + randomfloatrange( random_additional_offset * -1, random_additional_offset );
        pos = start_pos + var_27bf268ca6071c5 * direction;
        add_position( projectile_group, pos );
        current_offset += adjusted_offset;
        var_81cb28a61e76c30d--;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 2
// Checksum 0xd639165d, Offset: 0x3855
// Size: 0x3c
function add_position( projectile_group, pos )
{
    if ( is_valid_position( projectile_group, pos ) )
    {
        projectile_group.projectile_positions[ projectile_group.projectile_positions.size ] = pos;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 3, eflags: 0x4
// Checksum 0x1a4561be, Offset: 0x3899
// Size: 0x8c
function private register_orientation( spawn_point, end_point, id )
{
    orientation_struct = function_87f7644632e40fd5( spawn_point, end_point );
    orientation_struct.id = id;
    
    /#
        var_3225c1b0f9000c60 = ( randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ) );
        orientation_struct.color = var_3225c1b0f9000c60;
    #/
    
    level.var_c9376b589ea0723.orientation_structs[ id ] = orientation_struct;
    return orientation_struct;
}

// Namespace namespace_fd7b16d2452999a9
// Params 2, eflags: 0x4
// Checksum 0x96d70123, Offset: 0x392e
// Size: 0x1fe
function private function_87f7644632e40fd5( spawn_point, end_point )
{
    dir_vector = vectornormalize( end_point - spawn_point );
    var_46d5f5d2fab76dd0 = vectornormalize2( end_point - spawn_point );
    dir_angles = vectortoangles( dir_vector );
    var_e928745efd7f3aa1 = vectortoangles( var_46d5f5d2fab76dd0 );
    right = anglestoright( dir_angles );
    up = anglestoup( dir_angles );
    forward = anglestoforward( dir_angles );
    var_a186a7c6b7b53436 = anglestoforward( var_e928745efd7f3aa1 );
    left = right * -1;
    backward = forward * -1;
    var_bf30640a063c878e = var_a186a7c6b7b53436 * -1;
    down = up * -1;
    left_up = vectornormalize( ( up - left ) / 2 + left );
    right_up = vectornormalize( ( up - right ) / 2 + right );
    left_down = left_up * -1;
    right_down = right_up * -1;
    return { #right_down:right_down, #left_down:left_down, #right_up:right_up, #left_up:left_up, #var_bf30640a063c878e:var_bf30640a063c878e, #var_a186a7c6b7b53436:var_a186a7c6b7b53436, #backward:backward, #forward:forward, #down:down, #up:up, #left:left, #right:right, #dir_angles:dir_angles, #var_46d5f5d2fab76dd0:var_46d5f5d2fab76dd0, #dir_vector:dir_vector, #end_point:end_point, #spawn_point:spawn_point, #id:level.var_c9376b589ea0723.orientation_structs.size };
}

// Namespace namespace_fd7b16d2452999a9
// Params 2, eflags: 0x4
// Checksum 0x77d6951a, Offset: 0x3b35
// Size: 0x59
function private spawn_projectile( projectile_group, position )
{
    projectile = { #is_fired:0, #direction:( 0, 0, 0 ), #ent:undefined, #origin:position };
    return projectile;
}

// Namespace namespace_fd7b16d2452999a9
// Params 2, eflags: 0x4
// Checksum 0x2d1db3ff, Offset: 0x3b97
// Size: 0xcc
function private function_298e7c899a1b398b( projectile_group, projectile )
{
    projectile endon( #"projectile_fired" );
    projectile.ent = magicbullet( projectile_group.projectile_asset, projectile.origin, projectile.origin + ( 0, 0, 1 ), level.var_c9376b589ea0723.virgil_ent );
    projectile.ent endon( #"death" );
    original_origin = projectile.ent.origin;
    
    while ( true )
    {
        projectile.ent.origin = original_origin;
        waitframe();
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 0, eflags: 0x4
// Checksum 0xfdbd775d, Offset: 0x3c6b
// Size: 0xcb
function private function_2bf88cba25ec6ca0()
{
    projectile_group = { #var_2168b89bac4ac31c:0, #projectile_asset:"sat_zombie_virgil_runic_volley_attack", #warning_disabled:0, #warning_only:0, #var_d550c1576ea0446c:level.var_c9376b589ea0723.var_d550c1576ea0446c, #fire_delay_seconds:level.var_c9376b589ea0723.fire_delay_seconds, #var_57adcd74fec4bfe6:0, #move_function:&function_33db937b622c0c69, #end_point_height_offset:0, #end_point_offset:( 0, 0, 0 ), #var_6a1d94b54f83d888:[], #projectile_positions:[], #projectiles:[] };
    return projectile_group;
}

// Namespace namespace_fd7b16d2452999a9
// Params 4, eflags: 0x4
// Checksum 0xee66c971, Offset: 0x3d3f
// Size: 0xe6
function private function_5a48a73ee2c4ab48( projectile_group, projectile, orientation_struct, move_function = undefined )
{
    if ( projectile_group.warning_only )
    {
        return;
    }
    
    if ( !isdefined( move_function ) )
    {
        move_function = projectile_group.move_function;
    }
    
    if ( projectile_group.var_2168b89bac4ac31c && projectile_group.var_2168b89bac4ac31c > 0 )
    {
        wait randomfloat( projectile_group.var_2168b89bac4ac31c );
    }
    
    projectile.ent = magicbullet( projectile_group.projectile_asset, projectile.origin, projectile.origin + orientation_struct.var_46d5f5d2fab76dd0, level.var_c9376b589ea0723.virgil_ent );
    self thread [[ move_function ]]( projectile_group, projectile, orientation_struct );
    projectile notify( #"projectile_fired" );
}

// Namespace namespace_fd7b16d2452999a9
// Params 2, eflags: 0x4
// Checksum 0x41f3b093, Offset: 0x3e2d
// Size: 0x274
function private function_f018a1fcd95aeea( projectile_group, orientation_struct )
{
    self endon( #"death" );
    var_cfe5b9bcce72e125 = 0;
    
    foreach ( position in projectile_group.projectile_positions )
    {
        projectile_group.projectiles[ projectile_group.projectiles.size ] = spawn_projectile( projectile_group, position );
        
        if ( utility::ent_flag( "flag_virgil_in_pain" ) )
        {
            var_cfe5b9bcce72e125 = 1;
            break;
        }
        
        if ( projectile_group.var_d550c1576ea0446c > 0 )
        {
            wait projectile_group.var_d550c1576ea0446c;
        }
    }
    
    if ( var_cfe5b9bcce72e125 )
    {
        level notify( #"projectile_casting_canceled" );
        projectile_group notify( #"projectile_casting_canceled" );
        projectile_group.cancelled = 1;
        
        foreach ( projectile in projectile_group.projectiles )
        {
            if ( isent( projectile.ent ) )
            {
                projectile.ent delete();
            }
        }
        
        return;
    }
    
    projectile_group notify( #"hash_b64e98d14f43d63e" );
    
    if ( projectile_group.fire_delay_seconds > 0 )
    {
        wait projectile_group.fire_delay_seconds;
    }
    
    projectile_group notify( #"hash_8496d38e9dc210dd" );
    
    foreach ( projectile in projectile_group.projectiles )
    {
        thread function_5a48a73ee2c4ab48( projectile_group, projectile, orientation_struct );
    }
    
    projectile_group.fired = 1;
    projectile_group notify( #"hash_462e7d9c4cc01609" );
}

// Namespace namespace_fd7b16d2452999a9
// Params 3, eflags: 0x4
// Checksum 0xc8b85fd8, Offset: 0x40a9
// Size: 0x17a
function private move_random_direction( projectile_group, projectile, orientation_struct )
{
    spread_frac = 0.75;
    var_a4739a9c80dd346f = randomfloatrange( spread_frac, 1 );
    forward_direction = projectile_group.var_57adcd74fec4bfe6 ? vectornormalize2( orientation_struct.var_a186a7c6b7b53436 ) : vectornormalize( orientation_struct.forward );
    var_ad49cf978b575d83 = forward_direction;
    horizontal_direction = randomint( 2 ) ? orientation_struct.left : orientation_struct.right;
    vertical_direction = randomint( 2 ) ? orientation_struct.up : orientation_struct.down;
    var_ad49cf978b575d83 = vectorlerp( horizontal_direction, var_ad49cf978b575d83, var_a4739a9c80dd346f );
    var_ad49cf978b575d83 = vectorlerp( vertical_direction, var_ad49cf978b575d83, var_a4739a9c80dd346f );
    var_da3a1cbbe694b617 = level.var_c9376b589ea0723.var_da3a1cbbe694b617;
    target_position = projectile.ent.origin + level.var_c9376b589ea0723.var_ae778f64a9db94d7[ projectile_group.projectile_asset ] * vectornormalize( var_ad49cf978b575d83 ) * var_da3a1cbbe694b617;
    projectile.ent missile_settargetpos( target_position );
    projectile.ent missile_setflightmodedirect();
}

// Namespace namespace_fd7b16d2452999a9
// Params 3, eflags: 0x4
// Checksum 0xf575ee2e, Offset: 0x422b
// Size: 0x132
function private function_33db937b622c0c69( projectile_group, projectile, orientation_struct )
{
    if ( !isdefined( projectile_group.movement_direction ) )
    {
        adjusted_end_point = orientation_struct.end_point + ( 0, 0, projectile_group.end_point_height_offset );
        adjusted_end_point += projectile_group.end_point_offset;
        direction = adjusted_end_point - orientation_struct.spawn_point;
        projectile_group.movement_direction = projectile_group.var_57adcd74fec4bfe6 ? vectornormalize2( direction ) : vectornormalize( direction );
    }
    
    var_da3a1cbbe694b617 = level.var_c9376b589ea0723.var_da3a1cbbe694b617;
    target_position = projectile.ent.origin + level.var_c9376b589ea0723.var_ae778f64a9db94d7[ projectile_group.projectile_asset ] * projectile_group.movement_direction * var_da3a1cbbe694b617;
    projectile.ent missile_settargetpos( target_position );
    projectile.ent missile_setflightmodedirect();
}

// Namespace namespace_fd7b16d2452999a9
// Params 3, eflags: 0x4
// Checksum 0xbd98950c, Offset: 0x4365
// Size: 0x146
function private function_df5668c67d2a52ca( projectile_group, projectile, orientation_struct )
{
    self endon( #"death" );
    projectile.ent endon( #"death" );
    adjusted_end_point = orientation_struct.end_point + ( 0, 0, projectile_group.end_point_height_offset );
    z_offset = adjusted_end_point[ 2 ] - orientation_struct.spawn_point[ 2 ];
    target_position = projectile.ent.origin + orientation_struct.up * z_offset;
    target_position += level.var_c9376b589ea0723.var_ae778f64a9db94d7[ projectile_group.projectile_asset ] * orientation_struct.var_46d5f5d2fab76dd0 * level.var_c9376b589ea0723.move_offset_delay_seconds;
    projectile.ent missile_settargetpos( target_position );
    projectile.ent missile_setflightmodedirect();
    
    while ( projectile.ent.origin[ 2 ] > target_position[ 2 ] )
    {
        waitframe();
    }
    
    function_33db937b622c0c69( projectile_group, projectile, orientation_struct );
}

// Namespace namespace_fd7b16d2452999a9
// Params 3, eflags: 0x4
// Checksum 0xaa78dd89, Offset: 0x44b3
// Size: 0x136
function private function_832ca5add42d6c39( projectile_group, projectile, direction )
{
    self endon( #"death" );
    projectile.ent endon( #"death" );
    var_61189e050912337f = level.var_c9376b589ea0723.move_wave_amplitude;
    var_90a9fba5073b6a06 = projectile.origin[ 2 ];
    
    while ( isdefined( projectile.ent ) )
    {
        var_da3a1cbbe694b617 = level.var_c9376b589ea0723.var_da3a1cbbe694b617;
        target_position = projectile.ent.origin + level.var_c9376b589ea0723.var_ae778f64a9db94d7[ projectile_group.projectile_asset ] * direction * var_da3a1cbbe694b617;
        target_position = ( target_position[ 0 ], target_position[ 1 ], var_90a9fba5073b6a06 + var_61189e050912337f );
        projectile.ent missile_settargetpos( target_position );
        projectile.ent missile_setflightmodedirect();
        wait level.var_c9376b589ea0723.var_1ad2de468ef57426;
        var_61189e050912337f *= -1;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 3, eflags: 0x4
// Checksum 0x80c2e1d4, Offset: 0x45f1
// Size: 0x239
function private function_3a0edb61f00c2b59( projectile_group, projectile, direction )
{
    self endon( #"death" );
    projectile.ent endon( #"death" );
    var_832af57119044364 = 1000;
    var_d7a2ef4218323458 = 900;
    var_6bfb80503de9fd77 = 1000;
    var_5a436dece605234 = 2;
    target_ent = function_9e4de9e8aa8444e2( projectile_group.var_dafadb505a321868.players );
    target_pos = target_ent.origin ?? projectile_group.end_point;
    direction = vectornormalize( target_pos - projectile.origin );
    mid = projectile.origin + direction * var_832af57119044364;
    control = mid + ( 0, 0, 1 ) * var_d7a2ef4218323458;
    
    if ( vectordot( projectile.origin - projectile_group.spawn_point, ( 0, 1, 0 ) ) > 0 )
    {
        control += ( 0, 1, 0 ) * randomintrange( 0, var_6bfb80503de9fd77 );
    }
    else
    {
        control += ( 0, 1, 0 ) * randomintrange( 0, var_6bfb80503de9fd77 ) * -1;
    }
    
    start = projectile.origin;
    end = target_pos;
    var_5a436dece605234 = var_5a436dece605234;
    time_elapsed_sec = 0;
    starting_time_ms = gettime();
    
    while ( time_elapsed_sec <= var_5a436dece605234 )
    {
        frac = math::lerp_fraction( 0, var_5a436dece605234, time_elapsed_sec );
        a = math::lerp( start, control, frac );
        b = math::lerp( control, end, frac );
        new_pos = math::lerp( a, b, frac );
        projectile.ent missile_settargetpos( new_pos );
        projectile.ent missile_setflightmodedirect();
        waitframe();
        time_elapsed_sec = ( gettime() - starting_time_ms ) * 0.001;
    }
}

// Namespace namespace_fd7b16d2452999a9
// Params 2, eflags: 0x4
// Checksum 0xd7174a47, Offset: 0x4832
// Size: 0x70, Type: bool
function private is_valid_position( projectile_group, pos )
{
    int_pos = ( int( pos[ 0 ] ), int( pos[ 1 ] ), int( pos[ 2 ] ) );
    pos_hash = string( int_pos );
    
    if ( !projectile_group.var_6a1d94b54f83d888[ pos_hash ] )
    {
        projectile_group.var_6a1d94b54f83d888[ pos_hash ] = 1;
        return true;
    }
    
    return false;
}

// Namespace namespace_fd7b16d2452999a9
// Params 3, eflags: 0x4
// Checksum 0xdd06a55, Offset: 0x48ab
// Size: 0xad
function private function_f24afc365c84479e( scriptable_asset, projectile_group, orientation_struct )
{
    level endon( #"game_ended" );
    var_53ec55a8457af8ae = spawnscriptable( scriptable_asset, orientation_struct.spawn_point, vectortoangles( orientation_struct.forward ), undefined );
    var_53ec55a8457af8ae thread function_19fd9ce38ebebcf9( projectile_group );
    var_53ec55a8457af8ae endon( #"hash_7c0994ea068c0896" );
    projectile_group waittill( #"hash_b64e98d14f43d63e" );
    projectile_group waittill( #"hash_8496d38e9dc210dd" );
    var_53ec55a8457af8ae setscriptablepartstate( #"fx", #"release" );
    wait 5;
    var_53ec55a8457af8ae freescriptable();
}

// Namespace namespace_fd7b16d2452999a9
// Params 1, eflags: 0x4
// Checksum 0x32bc5f70, Offset: 0x4960
// Size: 0x6d
function private function_19fd9ce38ebebcf9( projectile_group )
{
    level endon( #"game_ended" );
    level utility::waittill_any_timeout( 10, "projectile_casting_canceled" );
    self notify( #"hash_7c0994ea068c0896" );
    
    if ( projectile_group.cancelled && isdefined( self ) )
    {
        self setscriptablepartstate( #"fx", #"release" );
        wait 5;
    }
    
    if ( isdefined( self ) )
    {
        self freescriptable();
    }
}

/#

    // Namespace namespace_fd7b16d2452999a9
    // Params 1, eflags: 0x4
    // Checksum 0x3ff0ea0d, Offset: 0x49d5
    // Size: 0xc9, Type: dev
    function private function_c1b92be8c84e8b31( orientation_struct )
    {
        if ( !level.var_c9376b589ea0723.watcher_active )
        {
            function_11135981b04b76d5();
        }
        
        spawn_id_override = getdvarint( @"hash_374132d448fd1b28", -1 );
        
        if ( spawn_id_override >= 0 )
        {
            orientation_struct = level.var_c9376b589ea0723.orientation_structs[ spawn_id_override ];
        }
        else if ( !isdefined( orientation_struct ) && level.var_c9376b589ea0723.orientation_structs.size > 0 )
        {
            orientation_struct = function_111dbd9220a7021c();
            
            if ( !isdefined( orientation_struct ) )
            {
                orientation_struct = level.var_c9376b589ea0723.orientation_structs[ randomint( level.var_c9376b589ea0723.orientation_structs.size ) ];
            }
        }
        
        return orientation_struct;
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 0, eflags: 0x4
    // Checksum 0x178ac9e, Offset: 0x4aa6
    // Size: 0x59, Type: dev
    function private function_a1acc9e0c94e4899()
    {
        projectile_group = function_2bf88cba25ec6ca0();
        var_a6d4519c9449550b = function_c1b92be8c84e8b31( undefined );
        add_position( projectile_group, var_a6d4519c9449550b.spawn_point );
        level.var_c9376b589ea0723.virgil_ent thread function_f018a1fcd95aeea( projectile_group, var_a6d4519c9449550b );
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 0, eflags: 0x4
    // Checksum 0x33467a30, Offset: 0x4b07
    // Size: 0x1dd, Type: dev
    function private projectile_attack_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x62>", "<dev string:x75>", &toggle_show_spawns );
        devgui::add_devgui_func( "<dev string:x88>", "<dev string:x9d>", &function_f1a30930eb70c7a3 );
        devgui::add_devgui_func( "<dev string:xb8>", "<dev string:xcf>", &function_bdb48751d06307f4 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:xec>" );
        devgui::add_devgui_func( "<dev string:x12f>", "<dev string:x14f>", &function_a1acc9e0c94e4899 );
        devgui::add_devgui_func( "<dev string:x16e>", "<dev string:x184>", &function_9690a2e2cad899c7 );
        devgui::add_devgui_func( "<dev string:x19c>", "<dev string:x1b9>", &function_8c29dda2d755a106 );
        devgui::add_devgui_func( "<dev string:x1d8>", "<dev string:x1f4>", &function_94936d06ed919c13 );
        devgui::add_devgui_func( "<dev string:x212>", "<dev string:x228>", &function_ea35954756fb6cf7 );
        devgui::add_devgui_func( "<dev string:x240>", "<dev string:x257>", &function_fa5336af0bbae879 );
        devgui::add_devgui_func( "<dev string:x269>", "<dev string:x284>", &function_2c75577e29c3f76e );
        devgui::add_devgui_func( "<dev string:x29a>", "<dev string:x2b6>", &function_623b1439ca23e6da );
        devgui::add_devgui_func( "<dev string:x2cd>", "<dev string:x2ea>", &function_a3f94321ada8ceb );
        devgui::add_devgui_func( "<dev string:x302>", "<dev string:x31e>", &function_ad68a9825d4838ae );
        devgui::function_cd4e263c1f3018ae( "<dev string:x335>", "<dev string:x344>" + "<dev string:x361>", &function_b7ddc6005993a9f4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x36a>", "<dev string:x344>" + "<dev string:x375>", &function_b7ddc6005993a9f4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37a>", "<dev string:x344>" + "<dev string:x389>", &function_b7ddc6005993a9f4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x392>", "<dev string:x344>" + "<dev string:x3a2>", &function_b7ddc6005993a9f4 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3ac>", "<dev string:x344>" + "<dev string:x3b7>", &function_b7ddc6005993a9f4 );
        devgui::function_77df7fe7dd273e10();
        level thread update_dvars_loop();
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 1, eflags: 0x4
    // Checksum 0xc55119c2, Offset: 0x4cec
    // Size: 0x36, Type: dev
    function private function_f1a30930eb70c7a3( params )
    {
        level thread function_11135981b04b76d5();
        level.var_c9376b589ea0723.virgil_ent utility::ent_flag_set( "<dev string:x3bc>" );
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 1, eflags: 0x4
    // Checksum 0x5903f2c2, Offset: 0x4d2a
    // Size: 0x2e, Type: dev
    function private function_bdb48751d06307f4( params )
    {
        level.var_c9376b589ea0723.virgil_ent utility::ent_flag_clear( "<dev string:x3bc>" );
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 1, eflags: 0x4
    // Checksum 0xca4467d7, Offset: 0x4d60
    // Size: 0xff, Type: dev
    function private function_b7ddc6005993a9f4( params )
    {
        if ( isdefined( level.var_c9376b589ea0723.virgil_ent ) )
        {
            level.var_c9376b589ea0723.virgil_ent thread zombie_boss_virgil::function_682e7757f916b296( [ "<dev string:x3dd>", "<dev string:x3f7>", "<dev string:x410>" ], undefined );
        }
        
        if ( !level.var_c9376b589ea0723.watcher_active )
        {
            function_11135981b04b76d5();
        }
        
        wait 1.5;
        
        switch ( params[ 0 ] )
        {
            case #"hash_f4d1cf27213f17b7":
                level thread function_a98e512486b39e1b();
                break;
            case #"hash_4759916c2f74457c":
                level thread function_de74178a852afcc3();
                break;
            case #"hash_84f3c2edbf452d59":
                level thread function_7c60c7ea879031a1();
                break;
            case #"hash_96321d9124476345":
                level thread function_5788cb35533ee34b();
                break;
            case #"hash_6d5c9f6c439f8fb4":
                level thread function_496d5012f8de2596();
                break;
        }
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 0, eflags: 0x4
    // Checksum 0x9a671aa5, Offset: 0x4e67
    // Size: 0x3d, Type: dev
    function private toggle_show_spawns()
    {
        if ( level.var_b4e8a4f08652d6f4 )
        {
            level notify( #"hash_cbb273f381cba0d4" );
            level.var_b4e8a4f08652d6f4 = 0;
            return;
        }
        
        level thread show_all_spawns();
        level.var_b4e8a4f08652d6f4 = 1;
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 0, eflags: 0xc
    // Checksum 0x2d8e1a8c, Offset: 0x4eac
    // Size: 0x1c4, Type: dev
    function private show_all_spawns()
    {
        self notify( #"hash_22b276344614cc94" );
        self endon( #"hash_22b276344614cc94" );
        level endon( #"hash_cbb273f381cba0d4" );
        sphere_radius = 50;
        
        while ( true )
        {
            foreach ( orientation_struct in level.var_c9376b589ea0723.orientation_structs )
            {
                sphere( orientation_struct.spawn_point, sphere_radius, orientation_struct.color );
                sphere( orientation_struct.end_point, sphere_radius, orientation_struct.color );
                print3d( orientation_struct.spawn_point + ( 0, 0, sphere_radius ), "<dev string:x44b>" + orientation_struct.id, orientation_struct.color );
                print3d( orientation_struct.end_point + ( 0, 0, sphere_radius ), "<dev string:x456>" + orientation_struct.end_point + "<dev string:x45f>" + orientation_struct.id, orientation_struct.color );
                line( orientation_struct.spawn_point, orientation_struct.end_point, orientation_struct.color );
                line( orientation_struct.spawn_point, orientation_struct.spawn_point + orientation_struct.var_a186a7c6b7b53436 * 2000, orientation_struct.color );
            }
            
            waitframe();
        }
    }

    // Namespace namespace_fd7b16d2452999a9
    // Params 0, eflags: 0xc
    // Checksum 0x262cad0e, Offset: 0x5078
    // Size: 0x15a, Type: dev
    function private update_dvars_loop()
    {
        self notify( #"hash_c463662e6d66fac6" );
        self endon( #"hash_c463662e6d66fac6" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            level.var_c9376b589ea0723.var_da3a1cbbe694b617 = getdvarint( @"hash_c9a783444c6258f1", 6 );
            level.var_c9376b589ea0723.row_offset = getdvarint( @"hash_dd370e452af2d6a1", 100 );
            level.var_c9376b589ea0723.row_span = getdvarint( @"hash_1b14136b5038f93e", 500 );
            level.var_c9376b589ea0723.var_d550c1576ea0446c = getdvarfloat( @"hash_bb912ba8e2a4a024", 0.025 );
            level.var_c9376b589ea0723.fire_delay_seconds = getdvarfloat( @"hash_573aca5dd156b251", 0.65 );
            level.var_c9376b589ea0723.move_offset_delay_seconds = getdvarfloat( @"hash_35ed5cd5a44f40f2", 1.2 );
            level.var_c9376b589ea0723.move_wave_amplitude = getdvarfloat( @"hash_3461d93fe778c818", 2000 );
            level.var_c9376b589ea0723.var_1ad2de468ef57426 = getdvarfloat( @"hash_660e6a5688b7c76d", 1 );
            wait 0.5;
        }
    }

#/
