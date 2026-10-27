// script_4714f11e284c32a4  (hash_4714f11e284c32a4.gscc) (size: 25475 Bytes / 0x6383 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf0442fc3 (4031000515)
// size ...... 25475 (0x6383)
// includes .. 15  (offset: 0x60d3)
// strings ... 23  (offset: 0x614b)
// dev strs .. 18  (offset: 0x62ab)
// exports ... 61  (offset: 0x4557)
// cseg ...... 0x255 + 0x4302 (0x4557)
// imports ... 139 (offset: 0x4edf)
// animtree1 . 0   (offset: 0x6383)
// animtree2 . 0   (offset: 0x6383)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\damage;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\zm_utility;

#namespace namespace_dba99780c141b678;

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x974440f4, Offset: 0x273
// Size: 0x544
function init()
{
    if ( isdefined( level.var_6b629607b76c0354 ) )
    {
        level.var_6b629607b76c0354.virgil_ent = self;
        return;
    }
    
    var_a1cdafdd3e663768 = { #kill_zombie_on_impact:0, #var_cb8b825ba439ab64:undefined, #var_3857c5270d63c9f3:undefined, #update_nav_mesh:1, #var_356de6feacad01a5:0.25, #var_c6243ec0d08c3d06:1, #var_fd259abce3ad9187:1, #var_89a6b9f8f7eb226d:0, #var_46fa04ee5128915c:0, #var_2244b0b58f132d60:undefined, #var_2c636187351a0692:0, #var_3569026c514f16e4:0, #var_42b8877cd18925e2:getdvarint( @"hash_98a42413c244d436", 50 ), #var_c5f3db68d5c004f5:getdvarint( @"hash_93b0bd2683ecc949", 200 ), #ww_damage_multiplier:getdvarfloat( @"hash_20955b1d807aac52", 0.083 ), #fire_damage_multiplier:getdvarfloat( @"hash_4b292171210e51e8", 3 ), #var_786f877946506ca8:getdvarfloat( @"hash_130baf900490578c", 1 ), #var_ce34a824babdb06f:getdvarfloat( @"hash_b526fca5b1a06e73", 6 ), #var_f13930fcf48fafc4:getdvarfloat( @"hash_f6e2e7b54dfe04db", 87.75 ), #var_1607b7a6b428ada:getdvarfloat( @"hash_d6b839c295ee47ce", 2 ), #var_64bf2bd1792ae381:getdvarint( @"hash_bf0df9a10fa6889d", 700 ), #var_b8e14f53324dd439:getdvarint( @"hash_28d81f00132add4d", 1 ), #var_6fa394937ac3d679:getdvarfloat( @"hash_9b4c8afc77c59405", 10 ), #ice_block_player_damage:getdvarint( @"hash_aa03ae886fda891f", 50 ), #var_dea2bef07bc41277:getdvarfloat( @"hash_36450455c0281299", 0.5 ), #var_e944fda6f8663bca:getdvarfloat( @"hash_5f5033fe5084ff4c", 0.55 ), #var_6c0ed12be32db1d2:getdvarint( @"hash_b5f72b4d95e7d6b0", 300 ), #var_39760dce39fe4565:getdvarfloat( @"hash_d3c4c4e55211809", 0.2 ), #var_70bbf852ea79c4ba:getdvarfloat( @"hash_17decbe3b3945c7e", 2 ), #var_dcb9a05d87784b54:getdvarfloat( @"hash_675d85825b35f26b", 12 ), #var_27c6e69ad666a936:getdvarint( @"hash_faa9907245c20da9", 500 ) };
    var_73d54cee936bca53 = structcopy( var_a1cdafdd3e663768 );
    var_73d54cee936bca53.var_70bbf852ea79c4ba = 1;
    var_73d54cee936bca53.var_46fa04ee5128915c = 1;
    var_73d54cee936bca53.var_6fa394937ac3d679 = 0.25;
    var_73d54cee936bca53.ice_block_player_damage = 200;
    var_73d54cee936bca53.var_39760dce39fe4565 = 0.1;
    var_73d54cee936bca53.update_nav_mesh = 0;
    var_323ccf63e606e935 = structcopy( var_73d54cee936bca53 );
    var_323ccf63e606e935.var_70bbf852ea79c4ba = 3;
    var_323ccf63e606e935.var_3569026c514f16e4 = 0.25;
    level.var_6b629607b76c0354 = { #var_d44d63a0f39f895b:1, #var_f5045aacb14d2759:[], #avoidance_zones:[], #var_2d736a4ffcec10a5:0, #var_53dfdf1ad5f2507b:[ 0, 180, 90, 270 ], #model_asset_index:0, #model_assets:[ "sat_zm_virgil_ice_wall_01", "sat_zm_virgil_ice_wall_02", "sat_zm_virgil_ice_wall_03" ], #var_d8eb406e5e729bb0:var_323ccf63e606e935, #var_75b30d1f7fcc45c0:var_73d54cee936bca53, #default_settings:var_a1cdafdd3e663768, #var_26de9e18e02981cc:getdvarfloat( @"hash_9ee7699bab79ba07", 2.5 ), #var_ab36bebeec5276c8:getdvarint( @"hash_61f332f9eedafc2c", 200 ), #var_a38ec8288702c551:getdvarint( @"hash_b314dc4586ec1b39", 150 ), #var_a4bfb3046615ed0d:getdvarint( @"hash_7ff9b84289649525", 50 ), #var_69396a4956869729:getdvarint( @"hash_f3b603873978d8e1", 100 ), #var_b8967d8168f7e319:getdvarint( @"hash_9397760462a524c1", 300 ), #var_b8736f8168d17c97:getdvarint( @"hash_93ba880462cb940f", 100 ), #var_686301a6f7f9254:getdvarint( @"hash_d84553c80013b0fc", 500 ), #var_67de785da681acb3:[], #var_dc454d2a3d827864:[], #var_d35fb13c741c6e08:[], #ice_wall_structs:[], #virgil_ent:self };
    utility::add_fx( "block_shot_impact", "vfx_core_explo_shared_debris_impact_ice" );
    utility::add_fx( "block_fire_impact", "vfx_t10_gameplay_zm_weapons_perk_burnination_lvl1_fire_zmb_torso_burst_ch_1" );
    level callback::add( #"player_death", &function_8bf5f2a33d9c8108 );
    level callback::add( #"player_connect", &function_8bf5f2a33d9c8108 );
    level callback::add( #"player_laststand_revived", &function_8bf5f2a33d9c8108 );
    level callback::add( #"player_spawned", &function_8bf5f2a33d9c8108 );
    
    /#
        level thread attack_debug();
    #/
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x61fca51b, Offset: 0x7bf
// Size: 0x5a
function cleanup()
{
    level callback::remove( #"player_death", &function_8bf5f2a33d9c8108 );
    level callback::remove( #"player_connect", &function_8bf5f2a33d9c8108 );
    level callback::remove( #"player_laststand_revived", &function_8bf5f2a33d9c8108 );
    level callback::remove( #"player_spawned", &function_8bf5f2a33d9c8108 );
}

// Namespace namespace_dba99780c141b678
// Params 3
// Checksum 0xca669a0b, Offset: 0x821
// Size: 0x2a8
function setup_arena_properties( var_f7be40f8876789b7 = [], var_b1599c2ce340f209 = [], arena_vista_dir )
{
    function_29bcee93790bc1e2();
    level.var_6b629607b76c0354.default_settings.var_3857c5270d63c9f3 = arena_vista_dir;
    
    foreach ( var_a2a23d56975c4221 in var_f7be40f8876789b7 )
    {
        if ( var_a2a23d56975c4221.should_include == "0" )
        {
            continue;
        }
        
        var_5a80a1ad6341fffd = function_91fd7afce74113fd( var_a2a23d56975c4221 );
        
        if ( var_5a80a1ad6341fffd.size > 0 )
        {
            register_ice_wall( var_5a80a1ad6341fffd );
        }
    }
    
    var_185621e530107f74 = [];
    
    foreach ( var_edeaa23ba57656a0 in var_b1599c2ce340f209 )
    {
        if ( var_a2a23d56975c4221.should_include == "0" )
        {
            continue;
        }
        
        var_5a80a1ad6341fffd = function_91fd7afce74113fd( var_edeaa23ba57656a0, 1 );
        ice_wall_struct = function_9e6cbb9351c6ff95( var_5a80a1ad6341fffd );
        
        if ( var_edeaa23ba57656a0.id )
        {
            ice_wall_struct.placement_id = int( var_edeaa23ba57656a0.id );
        }
        
        if ( var_edeaa23ba57656a0.row )
        {
            ice_wall_struct.row = int( var_edeaa23ba57656a0.row );
        }
        
        if ( var_185621e530107f74[ var_edeaa23ba57656a0.script_noteworthy ] )
        {
            var_185621e530107f74[ var_edeaa23ba57656a0.script_noteworthy ][ var_185621e530107f74[ var_edeaa23ba57656a0.script_noteworthy ].size ] = ice_wall_struct;
            continue;
        }
        
        var_185621e530107f74[ var_edeaa23ba57656a0.script_noteworthy ] = [ ice_wall_struct ];
    }
    
    foreach ( var_6a445bd75214dff1 in var_185621e530107f74 )
    {
        register_ice_clump( var_6a445bd75214dff1 );
    }
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x3d49268, Offset: 0xad1
// Size: 0x15
function function_f5d5ec8b4b8a5e33()
{
    return level.var_6b629607b76c0354.default_settings;
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x9021d174, Offset: 0xaef
// Size: 0x15
function function_60dcd9cbe1cf2d4a()
{
    return level.var_6b629607b76c0354.var_75b30d1f7fcc45c0;
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x5ce5acb7, Offset: 0xb0d
// Size: 0x15
function function_c3c3e337d84f7dd6()
{
    return level.var_6b629607b76c0354.var_d8eb406e5e729bb0;
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0xd38c9c97, Offset: 0xb2b
// Size: 0x1a8
function function_91fd7afce74113fd( var_a2a23d56975c4221, var_99a3a12bf1777527 = 0 )
{
    var_5a80a1ad6341fffd = [ { #angles:var_a2a23d56975c4221.angles, #origin:var_a2a23d56975c4221.origin } ];
    target = var_a2a23d56975c4221.target;
    previous_position = var_a2a23d56975c4221.origin;
    
    if ( var_a2a23d56975c4221.script_noteworthy == "row" )
    {
        var_1f92bfcadb068b72 = utility::getstruct( target, "targetname" );
        return function_4b6775145d747b2b( var_a2a23d56975c4221.origin, var_1f92bfcadb068b72.origin, var_a2a23d56975c4221.angles );
    }
    
    while ( isdefined( target ) )
    {
        var_1f92bfcadb068b72 = utility::getstruct( target, "targetname" );
        var_34022af2040f6ec3 = var_1f92bfcadb068b72.origin;
        
        if ( var_1f92bfcadb068b72.script_noteworthy != "exact" && !var_99a3a12bf1777527 )
        {
            var_4210be4b325a03a9 = vectornormalize( var_1f92bfcadb068b72.origin - previous_position );
            var_70fd8cefd51d9640 = previous_position + var_4210be4b325a03a9 * 97.5;
            var_34022af2040f6ec3 = var_70fd8cefd51d9640;
        }
        
        block_info_struct = { #half:var_1f92bfcadb068b72.half, #angles:var_1f92bfcadb068b72.angles, #origin:var_34022af2040f6ec3 };
        var_5a80a1ad6341fffd[ var_5a80a1ad6341fffd.size ] = block_info_struct;
        target = var_1f92bfcadb068b72.target;
        previous_position = var_34022af2040f6ec3;
    }
    
    return var_5a80a1ad6341fffd;
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0x45450b40, Offset: 0xcdc
// Size: 0x33, Type: bool
function function_3d5e42923a9d0965( ice_wall_struct_a, ice_wall_struct_b )
{
    if ( ice_wall_struct_a.row <= ice_wall_struct_b.row )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0x7d525ab3, Offset: 0xd18
// Size: 0xd9
function function_26253d69242f4e39( var_c966dfa59ee621ab, ice_wall_settings = undefined )
{
    if ( !isdefined( ice_wall_settings ) )
    {
        ice_wall_settings = level.var_6b629607b76c0354.var_75b30d1f7fcc45c0;
    }
    
    var_28749e2fd4d0feb7 = 1;
    var_22e034095f18f466 = 0;
    
    if ( var_c966dfa59ee621ab )
    {
        var_ac5f632d63fc563d = arraysort( var_c966dfa59ee621ab.ice_wall_structs, undefined, &function_3d5e42923a9d0965 );
        current_row = 1;
        
        for ( i = 0; i < var_ac5f632d63fc563d.size ; i++ )
        {
            var_e5273f3195ab15a4 = var_ac5f632d63fc563d[ i ];
            
            if ( var_e5273f3195ab15a4.row != current_row )
            {
                current_row++;
                var_22e034095f18f466++;
            }
            
            if ( var_22e034095f18f466 == var_28749e2fd4d0feb7 )
            {
                wait 0.5;
                var_22e034095f18f466 = 0;
            }
            
            level thread place_ice_wall( var_e5273f3195ab15a4, ice_wall_settings );
        }
    }
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0xfd229c42, Offset: 0xdf9
// Size: 0x7f
function function_efe887b9ff2ba515( var_c966dfa59ee621ab, ice_wall_settings = undefined )
{
    if ( !isdefined( ice_wall_settings ) )
    {
        ice_wall_settings = level.var_6b629607b76c0354.var_d8eb406e5e729bb0;
    }
    
    for ( i = 0; i < var_c966dfa59ee621ab.ice_wall_structs.size ; i++ )
    {
        var_e5273f3195ab15a4 = var_c966dfa59ee621ab.ice_wall_structs[ i ];
        level thread place_ice_wall( var_e5273f3195ab15a4, ice_wall_settings );
    }
}

// Namespace namespace_dba99780c141b678
// Params 6
// Checksum 0xce09ff98, Offset: 0xe80
// Size: 0x148
function function_69abb74070b91d7d( start_position, end_position, var_a5b44574fcd91d8c = 0, block_delay_sec = 0.1, ice_wall_settings = undefined, var_54413c5c8490fa93 = undefined )
{
    if ( !isdefined( ice_wall_settings ) )
    {
        ice_wall_settings = level.var_6b629607b76c0354.var_75b30d1f7fcc45c0;
    }
    
    var_d722011cf54d3d5b = start_position;
    var_4210be4b325a03a9 = vectornormalize( end_position - start_position );
    remaining_distance = distance2d( start_position, end_position );
    remaining_blocks = int( remaining_distance / 97.5 ) + 1;
    var_d722011cf54d3d5b += var_a5b44574fcd91d8c * var_4210be4b325a03a9;
    
    if ( var_54413c5c8490fa93 )
    {
        remaining_blocks = minint( var_54413c5c8490fa93, remaining_blocks );
    }
    
    while ( remaining_blocks > 0 )
    {
        var_a3ed71111ddc1c45 = function_77d21320ab4c5981( var_d722011cf54d3d5b, 1, 1 );
        
        if ( var_a3ed71111ddc1c45 )
        {
            ice_wall = function_9e6cbb9351c6ff95( [ var_a3ed71111ddc1c45 ] );
            level thread place_ice_wall( ice_wall, ice_wall_settings );
            var_d722011cf54d3d5b = ( var_d722011cf54d3d5b[ 0 ], var_d722011cf54d3d5b[ 1 ], var_a3ed71111ddc1c45.origin[ 2 ] );
        }
        
        wait block_delay_sec;
        remaining_blocks--;
        var_d722011cf54d3d5b += var_4210be4b325a03a9 * 97.5;
    }
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x6e5d6668, Offset: 0xfd0
// Size: 0xab
function function_7d4b00914399a657( placement_id )
{
    var_1fabe749a98b5213 = [];
    
    foreach ( var_c966dfa59ee621ab in level.var_6b629607b76c0354.var_d35fb13c741c6e08 )
    {
        if ( placement_id == var_c966dfa59ee621ab.placement_id )
        {
            var_1fabe749a98b5213[ var_1fabe749a98b5213.size ] = var_c966dfa59ee621ab;
        }
    }
    
    return var_1fabe749a98b5213;
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x7bc8531a, Offset: 0x1084
// Size: 0x3b3
function function_52ec97b5c13f811()
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    level.var_6b629607b76c0354.virgil_ent endon( #"end_ice_wall_attack" );
    
    if ( level.var_6b629607b76c0354.var_67de785da681acb3.size == 0 )
    {
        return;
    }
    
    var_7c1da25fd1368572 = undefined;
    var_1e55648c5615b4f4 = undefined;
    walls_checked = 0;
    
    foreach ( wall_id in level.var_6b629607b76c0354.var_67de785da681acb3 )
    {
        ice_wall_struct = level.var_6b629607b76c0354.ice_wall_structs[ wall_id ];
        
        foreach ( player in utility::get_alive_players( 0 ) )
        {
            if ( isalive( player ) )
            {
                distance = distance2d( player.origin, ice_wall_struct.median_position );
                
                if ( distance < level.var_6b629607b76c0354.var_b8736f8168d17c97 || distance > level.var_6b629607b76c0354.var_b8967d8168f7e319 )
                {
                    distance_points = 0;
                    continue;
                }
                else
                {
                    ideal_difference = abs( distance - level.var_6b629607b76c0354.var_686301a6f7f9254 );
                    max_difference = level.var_6b629607b76c0354.var_b8967d8168f7e319 - level.var_6b629607b76c0354.var_686301a6f7f9254;
                    var_1a1fa79634108ff6 = clamp( math::lerp_fraction( max_difference, 0, ideal_difference ), 0, 1 );
                    distance_points = math::lerp( 0, level.var_6b629607b76c0354.var_69396a4956869729, var_1a1fa79634108ff6 );
                }
                
                var_45b28e1331516967 = 0;
                var_4210be4b325a03a9 = vectornormalize( ice_wall_struct.median_position - player.origin );
                dot_product = vectordot( anglestoforward( player.angles ), var_4210be4b325a03a9 );
                var_610ba7f255dea1ed = level.var_6b629607b76c0354.var_a4bfb3046615ed0d * dot_product;
                var_48029d7d9a7c0d7e = distance_points + var_45b28e1331516967 + var_610ba7f255dea1ed;
                
                if ( ( !isdefined( var_1e55648c5615b4f4 ) || var_1e55648c5615b4f4 < var_48029d7d9a7c0d7e ) && var_48029d7d9a7c0d7e > 0 )
                {
                    var_7c1da25fd1368572 = wall_id;
                    var_1e55648c5615b4f4 = var_48029d7d9a7c0d7e;
                }
                
                /#
                    level.var_6b629607b76c0354.ice_wall_structs[ wall_id ].var_23e6e147b7cc1983 = var_48029d7d9a7c0d7e;
                #/
            }
        }
        
        if ( walls_checked >= 3 )
        {
            waitframe();
            walls_checked = 0;
        }
    }
    
    if ( !isdefined( var_7c1da25fd1368572 ) )
    {
        return;
    }
    
    /#
        sphere( level.var_6b629607b76c0354.ice_wall_structs[ var_7c1da25fd1368572 ].median_position, 25, ( 1, 0, 1 ), 0, 150 );
    #/
    
    return level.var_6b629607b76c0354.ice_wall_structs[ var_7c1da25fd1368572 ];
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x6db48654, Offset: 0x1440
// Size: 0x126
function function_f813e384d8ce67ae( ice_wall_settings = undefined )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    level.var_6b629607b76c0354.virgil_ent endon( #"end_ice_wall_attack" );
    level.var_6b629607b76c0354.avoidance_zones = [];
    
    if ( !isdefined( ice_wall_settings ) )
    {
        ice_wall_settings = level.var_6b629607b76c0354.default_settings;
    }
    
    level thread function_d40bb9e26ebc7723( ice_wall_settings );
    level thread function_20489ced0b98219b();
    
    while ( true )
    {
        alive_players = utility::get_alive_players( 0 );
        
        if ( level.var_6b629607b76c0354.var_dc454d2a3d827864.size < level.var_6b629607b76c0354.var_ab36bebeec5276c8 && alive_players.size > 0 )
        {
            for ( ice_wall_struct = function_52ec97b5c13f811(); !isdefined( ice_wall_struct ) ; ice_wall_struct = function_52ec97b5c13f811() )
            {
                waitframe();
            }
            
            level thread place_ice_wall( ice_wall_struct, ice_wall_settings );
        }
        
        wait ice_wall_settings.var_ce34a824babdb06f;
    }
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0xab1ba4b, Offset: 0x156e
// Size: 0x20
function end_ice_wall_attack_thread()
{
    level.var_6b629607b76c0354.virgil_ent notify( #"end_ice_wall_attack" );
}

// Namespace namespace_dba99780c141b678
// Params 1, eflags: 0x4
// Checksum 0xbacdbdb3, Offset: 0x1596
// Size: 0xc6
function private function_d40bb9e26ebc7723( ice_wall_settings )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent utility::waittill_any( "death", "end_ice_wall_attack", "end_ice_wall_attack" );
    
    foreach ( ice_wall_struct in level.var_6b629607b76c0354.ice_wall_structs )
    {
        level thread cleanup_ice_wall( ice_wall_struct, ice_wall_settings );
    }
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x45101650, Offset: 0x1664
// Size: 0xa2
function register_ice_wall( var_5a80a1ad6341fffd )
{
    ice_wall_id = level.var_6b629607b76c0354.ice_wall_structs.size;
    ice_wall_struct = function_9e6cbb9351c6ff95( var_5a80a1ad6341fffd );
    ice_wall_struct.id = ice_wall_id;
    level.var_6b629607b76c0354.ice_wall_structs[ level.var_6b629607b76c0354.ice_wall_structs.size ] = ice_wall_struct;
    level.var_6b629607b76c0354.var_67de785da681acb3[ level.var_6b629607b76c0354.var_67de785da681acb3.size ] = ice_wall_id;
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x517749a1, Offset: 0x170e
// Size: 0x4b
function register_ice_clump( ice_wall_structs )
{
    var_c966dfa59ee621ab = function_bc3cfe0513b7f516( ice_wall_structs );
    level.var_6b629607b76c0354.var_d35fb13c741c6e08[ level.var_6b629607b76c0354.var_d35fb13c741c6e08.size ] = var_c966dfa59ee621ab;
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x6170bdc8, Offset: 0x1761
// Size: 0x19, Type: bool
function function_4d9e873ca4786672( var_c966dfa59ee621ab )
{
    return var_c966dfa59ee621ab.var_6349d0fc55296fc9 == 0;
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x42abccb7, Offset: 0x1783
// Size: 0x41
function function_29bcee93790bc1e2()
{
    level.var_6b629607b76c0354.ice_wall_structs = [];
    level.var_6b629607b76c0354.var_d35fb13c741c6e08 = [];
    level.var_6b629607b76c0354.var_67de785da681acb3 = [];
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x6241c287, Offset: 0x17cc
// Size: 0x7d
function function_3c8ac0fff17b9042()
{
    var_869b18bc78f41915 = level.var_6b629607b76c0354.var_67de785da681acb3.size;
    
    if ( var_869b18bc78f41915 > 0 )
    {
        var_d9150c7bb5a14ae4 = level.var_6b629607b76c0354.var_67de785da681acb3[ randomint( var_869b18bc78f41915 ) ];
        ice_wall_struct = level.var_6b629607b76c0354.ice_wall_structs[ var_d9150c7bb5a14ae4 ];
        
        if ( isdefined( ice_wall_struct ) )
        {
            level thread place_ice_wall( ice_wall_struct );
        }
    }
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x16002353, Offset: 0x1851
// Size: 0xde
function function_f015caca0d93c44e( point )
{
    closest_ice_wall = undefined;
    var_a702813f3980a07a = undefined;
    
    foreach ( ice_wall in level.var_6b629607b76c0354.ice_wall_structs )
    {
        current_distance_sq = distancesquared( point, ice_wall.median_position );
        
        if ( !isdefined( var_a702813f3980a07a ) || current_distance_sq < var_a702813f3980a07a )
        {
            var_a702813f3980a07a = current_distance_sq;
            closest_ice_wall = ice_wall;
        }
    }
    
    if ( isdefined( closest_ice_wall ) )
    {
        level thread place_ice_wall( closest_ice_wall );
    }
}

// Namespace namespace_dba99780c141b678
// Params 5
// Checksum 0xed1b595e, Offset: 0x1937
// Size: 0xc8
function function_4b6775145d747b2b( start_position, end_position, angles, drop_to_ground = 0, var_dbe7b919477971fb = 0 )
{
    var_5f4bdea4ab120ac2 = [];
    var_d722011cf54d3d5b = start_position;
    var_4210be4b325a03a9 = vectornormalize( end_position - start_position );
    remaining_distance = distance2d( start_position, end_position );
    remaining_blocks = int( remaining_distance / 97.5 );
    
    while ( remaining_blocks > 0 )
    {
        var_a3ed71111ddc1c45 = function_77d21320ab4c5981( var_d722011cf54d3d5b, drop_to_ground, var_dbe7b919477971fb );
        var_5f4bdea4ab120ac2[ var_5f4bdea4ab120ac2.size ] = var_a3ed71111ddc1c45;
        remaining_blocks--;
        var_d722011cf54d3d5b += var_4210be4b325a03a9 * 97.5;
    }
    
    return var_5f4bdea4ab120ac2;
}

// Namespace namespace_dba99780c141b678
// Params 4
// Checksum 0xedb18c77, Offset: 0x1a08
// Size: 0xff
function function_ab1b989d5157960c( position, radius, angle_offset, var_eab2caa90b642339 )
{
    current_angle = 0;
    current_radius = radius;
    block_data = [];
    
    while ( current_angle <= 360 )
    {
        x = current_radius * cos( current_angle );
        y = current_radius * sin( current_angle );
        z = position[ 2 ];
        new_position = position + ( x, y, z );
        block_struct = function_77d21320ab4c5981( new_position, 1, 1 );
        
        if ( block_struct )
        {
            block_data[ block_data.size ] = block_struct;
        }
        
        current_angle += angle_offset;
    }
    
    ice_wall_struct = function_9e6cbb9351c6ff95( block_data );
    ice_wall_struct.avoidance_zone = { #radius:radius * 2, #origin:position };
    return ice_wall_struct;
}

// Namespace namespace_dba99780c141b678
// Params 3
// Checksum 0xe76bb662, Offset: 0x1b10
// Size: 0x12c
function function_77d21320ab4c5981( position, drop_to_ground = 0, var_dbe7b919477971fb = 0 )
{
    if ( drop_to_ground )
    {
        contents = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
        result = trace::ray_trace( position + ( 0, 0, 1500 ), position + ( 0, 0, -12000 ), undefined, contents );
        position = result[ "position" ];
    }
    
    if ( position )
    {
        angles = ( 0, 0, 0 );
        
        if ( result[ "normal" ] && var_dbe7b919477971fb )
        {
            dot = vectordot( ( 0, 0, 1 ), result[ "normal" ] );
            
            if ( dot <= 0.8 )
            {
                return;
            }
            
            angles = generateaxisanglesfromupvector( result[ "normal" ], level.var_6b629607b76c0354.virgil_ent.angles );
        }
        
        return { #angles:angles, #origin:position };
    }
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0x81ad345a, Offset: 0x1c45
// Size: 0x1cf
function place_ice_wall( ice_wall_struct, ice_wall_settings = undefined )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    level.var_6b629607b76c0354.virgil_ent endon( #"end_ice_wall_attack" );
    ice_wall_struct endon( #"ice_wall_removed" );
    
    if ( !isdefined( ice_wall_settings ) )
    {
        ice_wall_settings = level.var_6b629607b76c0354.default_settings;
    }
    
    if ( isdefined( ice_wall_struct.id ) )
    {
        level.var_6b629607b76c0354.var_67de785da681acb3 = arrayremove( level.var_6b629607b76c0354.var_67de785da681acb3, ice_wall_struct.id );
        level.var_6b629607b76c0354.var_dc454d2a3d827864[ level.var_6b629607b76c0354.var_dc454d2a3d827864.size ] = ice_wall_struct.id;
    }
    
    level thread ice_wall_watcher( ice_wall_struct, ice_wall_settings );
    
    foreach ( block_info_struct in ice_wall_struct.var_5a80a1ad6341fffd )
    {
        ice_wall_struct thread function_870bc30ce8ac7758( block_info_struct.origin, block_info_struct.angles, block_info_struct.half, ice_wall_settings );
        
        if ( !ice_wall_settings.var_46fa04ee5128915c )
        {
            wait 97.5 / ice_wall_settings.var_27c6e69ad666a936;
        }
    }
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0x34b72873, Offset: 0x1e1c
// Size: 0x9a
function ice_wall_watcher( ice_wall_struct, ice_wall_settings )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    level.var_6b629607b76c0354.virgil_ent endon( #"end_ice_wall_attack" );
    
    for ( var_59ae2c2a1819d2ae = 0; var_59ae2c2a1819d2ae < ice_wall_struct.var_50eeb492f91fca81 ; var_59ae2c2a1819d2ae++ )
    {
        ice_wall_struct waittill( #"hash_8a9908eca3c37940" );
    }
    
    level thread cleanup_ice_wall( ice_wall_struct, ice_wall_settings );
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0x21daa58a, Offset: 0x1ebe
// Size: 0xd0
function cleanup_ice_wall( ice_wall_struct, ice_wall_settings )
{
    foreach ( block_ent in ice_wall_struct.block_ents )
    {
        if ( isent( block_ent ) )
        {
            ice_wall_struct thread cleanup_ice_wall_block( block_ent );
        }
    }
    
    ice_wall_struct notify( #"ice_wall_removed" );
    
    if ( isdefined( ice_wall_struct.id ) && ice_wall_settings.var_b8e14f53324dd439 )
    {
        level thread function_810fdf8848c06f2c( ice_wall_struct, ice_wall_settings );
    }
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0xf50b8899, Offset: 0x1f96
// Size: 0x86
function function_c03123422fb8e97d()
{
    foreach ( block_ent in level.var_6b629607b76c0354.var_f5045aacb14d2759 )
    {
        level thread cleanup_ice_wall_block( block_ent );
    }
}

// Namespace namespace_dba99780c141b678
// Params 4
// Checksum 0x802d01f3, Offset: 0x2024
// Size: 0x28f
function function_870bc30ce8ac7758( position, angles, is_half_block = 0, ice_wall_settings )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    level.var_6b629607b76c0354.virgil_ent endon( #"end_ice_wall_attack" );
    block_ent = function_2a1c8caa724700e4( position, angles, is_half_block, ice_wall_settings );
    block_ent endon( #"death" );
    function_8759490d070d7dc0( block_ent );
    level.var_6b629607b76c0354.var_f5045aacb14d2759[ level.var_6b629607b76c0354.var_f5045aacb14d2759.size ] = block_ent;
    var_f0e0ccd53f47ccaf = function_fd5bf6d78850776c( block_ent.rise_position );
    
    if ( !var_f0e0ccd53f47ccaf )
    {
        block_ent setscriptablepartstate( #"fx", #"warning" );
        wait ice_wall_settings.var_70bbf852ea79c4ba + randomfloat( ice_wall_settings.var_3569026c514f16e4 );
    }
    
    if ( !isent( block_ent ) || block_ent.var_efcde2142240af7 )
    {
        return;
    }
    
    var_d0d6445589f9a81e = 0;
    
    if ( !var_f0e0ccd53f47ccaf )
    {
        var_d0d6445589f9a81e = function_e977c92da49e5c27( block_ent, ice_wall_settings );
        var_f3df2999f06c70b2 = var_d0d6445589f9a81e == 0 || !ice_wall_settings.var_c6243ec0d08c3d06;
    }
    else
    {
        var_f3df2999f06c70b2 = 0;
    }
    
    if ( var_f3df2999f06c70b2 == 0 && var_d0d6445589f9a81e > 0 )
    {
        block_ent.was_destroyed = 1;
    }
    
    if ( var_f3df2999f06c70b2 || ice_wall_settings.force_block_rise )
    {
        if ( var_d0d6445589f9a81e > 0 )
        {
            wait ice_wall_settings.var_356de6feacad01a5;
        }
        
        block_ent setscriptablepartstate( #"model", #"show" );
        block_ent setcandamage( 1 );
        block_ent solid();
        block_ent setscriptablepartstate( #"fx", #"rise" );
        block_ent thread damage::monitordamage( block_ent.health, "hithealth", &function_994999e5a532a09d, &function_705fbb5f5c982265 );
        block_ent moveto( block_ent.rise_position, ice_wall_settings.var_39760dce39fe4565 );
        wait ice_wall_settings.var_39760dce39fe4565;
        block_ent.var_5b0566b7a73a9d3f = 1;
        block_ent setscriptablepartstate( #"fx", #"stationary" );
        thread function_33d73cc8c9cb8f48( block_ent, ice_wall_settings );
        return;
    }
    
    thread cleanup_ice_wall_block( block_ent );
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x43e3f98a, Offset: 0x22bb
// Size: 0x81
function function_9e6cbb9351c6ff95( var_5a80a1ad6341fffd )
{
    ice_wall_struct = { #median_position:utility::function_54fdde0a73217354( var_5a80a1ad6341fffd, 0, 1 ), #var_50eeb492f91fca81:var_5a80a1ad6341fffd.size, #block_ents:[], #var_5a80a1ad6341fffd:var_5a80a1ad6341fffd };
    
    /#
        var_501a620e5e1a3e42 = ( randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ), randomfloatrange( 0, 1 ) );
        ice_wall_struct.color = var_501a620e5e1a3e42;
    #/
    
    return ice_wall_struct;
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x5c4f461e, Offset: 0x2345
// Size: 0x120
function function_bc3cfe0513b7f516( ice_wall_structs )
{
    if ( !isarray( ice_wall_structs ) || ice_wall_structs.size == 0 )
    {
        return;
    }
    
    var_c966dfa59ee621ab = { #placement_id:ice_wall_structs[ 0 ].placement_id, #is_available:1, #var_6349d0fc55296fc9:0, #median_position:( 0, 0, 0 ), #ice_wall_structs:ice_wall_structs };
    
    foreach ( ice_wall_struct in ice_wall_structs )
    {
        var_c966dfa59ee621ab.median_position += ice_wall_struct.median_position;
    }
    
    var_c966dfa59ee621ab.median_position /= ice_wall_structs.size;
    return var_c966dfa59ee621ab;
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x30975017, Offset: 0x246e
// Size: 0x3e
function function_83106865d7d82433( avoidance_zone )
{
    level.var_6b629607b76c0354.avoidance_zones = arraycombineunique( level.var_6b629607b76c0354.avoidance_zones, [ avoidance_zone ] );
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0xee95be75, Offset: 0x24b4
// Size: 0x39
function function_e4a55a8bbcdb46d2( avoidance_zone )
{
    level.var_6b629607b76c0354.avoidance_zones = arrayremove( level.var_6b629607b76c0354.avoidance_zones, avoidance_zone );
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x39a633c9, Offset: 0x24f5
// Size: 0xc9, Type: bool
function function_fd5bf6d78850776c( position )
{
    foreach ( avoidance_zone in level.var_6b629607b76c0354.avoidance_zones )
    {
        if ( avoidance_zone == self.avoidance_zone )
        {
            continue;
        }
        
        in_circle = utility::ispointinsidecircle( position, avoidance_zone.origin, avoidance_zone.radius );
        
        if ( in_circle )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0xce39eacb, Offset: 0x25c7
// Size: 0x68
function function_7e5f3775a355e945( ice_wall_struct )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    function_83106865d7d82433( ice_wall_struct.avoidance_zone );
    ice_wall_struct waittill( #"ice_wall_removed" );
    function_e4a55a8bbcdb46d2( ice_wall_struct.avoidance_zone );
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0xe99756e9, Offset: 0x2637
// Size: 0x34
function function_3ead6ab23549d00b( avoidance_zone, ice_wall_settings )
{
    function_a049cf755cfbf450( avoidance_zone.origin, avoidance_zone.radius, ice_wall_settings );
}

// Namespace namespace_dba99780c141b678
// Params 3
// Checksum 0xedcfdf44, Offset: 0x2673
// Size: 0x192
function function_a049cf755cfbf450( origin, radius, ice_wall_settings )
{
    foreach ( var_c966dfa59ee621ab in level.var_6b629607b76c0354.var_d35fb13c741c6e08 )
    {
        foreach ( ice_wall_struct in var_c966dfa59ee621ab.ice_wall_structs )
        {
            function_1906353af5d90ebd( ice_wall_struct, origin, radius, ice_wall_settings );
        }
    }
    
    foreach ( ice_wall_struct in level.var_6b629607b76c0354.ice_wall_structs )
    {
        function_1906353af5d90ebd( ice_wall_struct, origin, radius, ice_wall_settings );
    }
}

// Namespace namespace_dba99780c141b678
// Params 4
// Checksum 0x6a990aa3, Offset: 0x280d
// Size: 0xe7
function function_1906353af5d90ebd( ice_wall_struct, origin, radius, ice_wall_settings )
{
    clear_ice_wall = 0;
    
    foreach ( block_ent in ice_wall_struct.block_ents )
    {
        if ( isent( block_ent ) )
        {
            in_circle = utility::ispointinsidecircle( block_ent.rise_position, origin, radius );
            
            if ( in_circle )
            {
                clear_ice_wall = 1;
                break;
            }
        }
    }
    
    if ( clear_ice_wall )
    {
        level thread cleanup_ice_wall( ice_wall_struct, ice_wall_settings );
    }
}

// Namespace namespace_dba99780c141b678
// Params 1
// Checksum 0x6060b560, Offset: 0x28fc
// Size: 0xd9
function function_1cb2768d13bba36c( avoidance_zone )
{
    foreach ( block_ent in level.var_6b629607b76c0354.var_f5045aacb14d2759 )
    {
        if ( isent( block_ent ) )
        {
            in_circle = utility::ispointinsidecircle( block_ent.rise_position, avoidance_zone.origin, avoidance_zone.radius );
            
            if ( in_circle )
            {
                block_ent.var_97dd30f3586c0e31 thread cleanup_ice_wall_block( block_ent );
            }
        }
    }
}

// Namespace namespace_dba99780c141b678
// Params 2
// Checksum 0xbb595548, Offset: 0x29dd
// Size: 0xcf
function function_a1e2c0af0698842b( origin, radius )
{
    foreach ( block_ent in level.var_6b629607b76c0354.var_f5045aacb14d2759 )
    {
        if ( isent( block_ent ) )
        {
            in_circle = utility::ispointinsidecircle( block_ent.rise_position, origin, radius );
            
            if ( in_circle )
            {
                block_ent.var_97dd30f3586c0e31 thread cleanup_ice_wall_block( block_ent );
            }
        }
    }
}

// Namespace namespace_dba99780c141b678
// Params 2, eflags: 0x4
// Checksum 0x90d40181, Offset: 0x2ab4
// Size: 0x3f7
function private function_e977c92da49e5c27( block_ent, ice_wall_settings )
{
    var_4ec03c59fe015016 = function_d63fe6a4c08ba6f5( block_ent.rise_position, ice_wall_settings.var_f13930fcf48fafc4, 250 );
    
    foreach ( player in var_4ec03c59fe015016 )
    {
        if ( ice_wall_settings.var_d44d63a0f39f895b && player::isinlaststand( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.var_a3cdd26776d9bf4a ) && ( gettime() - player.var_a3cdd26776d9bf4a ) * 0.001 <= 3 )
        {
            continue;
        }
        
        var_14ec6a3c9f84985 = player.var_14ec6a3c9f84985;
        current_time_ms = gettime();
        
        if ( !isdefined( var_14ec6a3c9f84985 ) || current_time_ms - var_14ec6a3c9f84985 >= 500 )
        {
            if ( !isdefined( player.var_a5c6cf638905fd ) || player.var_a5c6cf638905fd )
            {
                damage = ice_wall_settings.ice_block_player_damage;
                owner_ent = ice_wall_settings.owner_ent ?? level.var_6b629607b76c0354.virgil_en;
                player dodamage( damage, block_ent.rise_position, owner_ent, undefined, "MOD_IMPACT", undefined, "torso_upper", undefined );
                player thread function_1ff82677e973592c();
            }
            
            if ( isfunction( ice_wall_settings.var_cb8b825ba439ab64 ) )
            {
                knockback_dir = [[ ice_wall_settings.var_cb8b825ba439ab64 ]]( block_ent, ice_wall_settings, player );
            }
            
            if ( !knockback_dir )
            {
                if ( ice_wall_settings.source_origin )
                {
                    knockback_dir = vectornormalize2( player.origin - ice_wall_settings.source_origin );
                }
                else
                {
                    knockback_dir = anglestoforward( player.angles ) * -1;
                    
                    if ( isdefined( ice_wall_settings.var_2244b0b58f132d60 ) )
                    {
                        knockback_dir = vectornormalize2( ice_wall_settings.var_2244b0b58f132d60 - player.origin );
                    }
                }
            }
            
            if ( ice_wall_settings.var_3857c5270d63c9f3 )
            {
                knockback_dir -= ice_wall_settings.var_3857c5270d63c9f3;
            }
            
            knockback_dir += ( 0, 0, ice_wall_settings.var_1607b7a6b428ada );
            player knockback( knockback_dir, ice_wall_settings.var_64bf2bd1792ae381, 1 );
            player.var_14ec6a3c9f84985 = current_time_ms;
            player thread function_77247564e3f19ec4();
        }
    }
    
    var_9c39bfc2688c4ae5 = getaiarrayinradius( block_ent.rise_position, ice_wall_settings.var_f13930fcf48fafc4, "team_two_hundred" );
    var_e20dc77fbd2eab3c = 0;
    
    foreach ( zombie in var_9c39bfc2688c4ae5 )
    {
        if ( zombie.aicategory == "normal" )
        {
            if ( ice_wall_settings.kill_zombie_on_impact )
            {
                namespace_b76ff2659823e89d::function_61b75f09c6601780();
                zombie kill( block_ent.rise_position, undefined, undefined, "MOD_IMPACT", undefined );
            }
            else
            {
                zombie dodamage( zombie.health * 0.25, block_ent.rise_position, undefined, undefined, "MOD_IMPACT", undefined, "torso_upper", undefined, 65536 );
                zombie zombie_knockdown::function_6fc167d4a3590991( block_ent.rise_position, ice_wall_settings.var_64bf2bd1792ae381, 45 );
            }
            
            continue;
        }
        
        var_e20dc77fbd2eab3c++;
    }
    
    return var_4ec03c59fe015016.size + var_e20dc77fbd2eab3c;
}

// Namespace namespace_dba99780c141b678
// Params 0, eflags: 0xc
// Checksum 0xb5fa03a7, Offset: 0x2eb4
// Size: 0xa9
function private function_1ff82677e973592c()
{
    self notify( #"hash_c170b85713aa508c" );
    self endon( #"hash_c170b85713aa508c" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_a5c6cf638905fd = 0;
    self.falldamageprotection = 1;
    timeout = gettime() + int( 10000 );
    wait 1;
    
    while ( gettime() < timeout )
    {
        if ( !isalive( self ) || self isonground() && !self isinfreefall() )
        {
            break;
        }
        
        waitframe();
    }
    
    if ( isdefined( self ) )
    {
        self.var_a5c6cf638905fd = 1;
        self.falldamageprotection = undefined;
    }
}

// Namespace namespace_dba99780c141b678
// Params 2, eflags: 0x4
// Checksum 0x97407b92, Offset: 0x2f65
// Size: 0xce
function private function_33d73cc8c9cb8f48( block_ent, ice_wall_settings )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    level.var_6b629607b76c0354.virgil_ent endon( #"end_ice_wall_attack" );
    block_ent endon( #"death" );
    
    if ( ice_wall_settings.update_nav_mesh )
    {
        block_ent.var_12aadf5d8bbfdafd = createnavobstaclebybounds( block_ent.origin, ( 60, 60, 60 ), block_ent.angles );
    }
    
    if ( ice_wall_settings.var_fd259abce3ad9187 )
    {
        wait ice_wall_settings.var_6fa394937ac3d679;
        thread cleanup_ice_wall_block( block_ent );
    }
}

// Namespace namespace_dba99780c141b678
// Params 2, eflags: 0x4
// Checksum 0xefefe5c6, Offset: 0x303b
// Size: 0xe8
function private function_810fdf8848c06f2c( ice_wall_struct, ice_wall_settings )
{
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    
    if ( level.var_6b629607b76c0354.virgil_ent && !isalive( level.var_6b629607b76c0354.virgil_ent ) )
    {
        return;
    }
    
    wait ice_wall_settings.var_dcb9a05d87784b54;
    level.var_6b629607b76c0354.var_67de785da681acb3[ level.var_6b629607b76c0354.var_67de785da681acb3.size ] = ice_wall_struct.id;
    level.var_6b629607b76c0354.var_dc454d2a3d827864 = arrayremove( level.var_6b629607b76c0354.var_dc454d2a3d827864, ice_wall_struct.id );
}

// Namespace namespace_dba99780c141b678
// Params 1, eflags: 0x4
// Checksum 0x3898ba47, Offset: 0x312b
// Size: 0x1d
function private function_994999e5a532a09d( damage_data )
{
    self.var_97dd30f3586c0e31 thread cleanup_ice_wall_block( self );
}

// Namespace namespace_dba99780c141b678
// Params 1, eflags: 0x4
// Checksum 0xd4775167, Offset: 0x3150
// Size: 0x219
function private function_705fbb5f5c982265( damage_data )
{
    damage_data.damage = zm_damage::function_2020d8f8c3d295a8( damage_data.inflictor, damage_data.attacker, self, damage_data.damage, damage_data.idflags, damage_data.meansofdeath, damage_data.objweapon, damage_data.direction_vec, damage_data.point, undefined, damage_data.partname );
    total_damage = damage_data.damage;
    
    if ( utility::issharedfuncdefined( #"zm_sat_locust", #"hash_927f03d84df4a730" ) )
    {
        fire_damage = utility::callsharedfunc( #"zm_sat_locust", #"hash_927f03d84df4a730", damage_data, { #check_explosive:1 } );
    }
    
    if ( fire_damage > 0 )
    {
        playfx( utility::getfx( "block_fire_impact" ), damage_data.point );
        total_damage = fire_damage * self.ice_wall_settings.fire_damage_multiplier;
    }
    else
    {
        if ( utility::isbulletdamage( damage_data.meansofdeath ) )
        {
            playfx( utility::getfx( "block_shot_impact" ), damage_data.point );
        }
        
        if ( weapon::iswonderweapon( damage_data.objweapon ) )
        {
            total_damage *= self.ice_wall_settings.ww_damage_multiplier;
        }
        else
        {
            total_damage *= self.ice_wall_settings.var_786f877946506ca8;
        }
    }
    
    if ( self.ice_wall_settings.var_89a6b9f8f7eb226d )
    {
        total_damage = 0;
    }
    
    if ( total_damage + self.damagetaken >= self.maxhealth )
    {
        self.was_destroyed = 1;
        level thread function_d132903117e232e0( self.origin, damage_data.attacker, self.ice_wall_settings.var_c5f3db68d5c004f5, self.ice_wall_settings.var_42b8877cd18925e2 );
    }
    
    return total_damage;
}

// Namespace namespace_dba99780c141b678
// Params 4, eflags: 0x4
// Checksum 0x3d83a93b, Offset: 0x3372
// Size: 0xe7
function private function_d132903117e232e0( block_origin, attacker, shatter_damage_radius, shatter_damage )
{
    var_9c39bfc2688c4ae5 = getaiarrayinradius( block_origin, shatter_damage_radius, "team_two_hundred" );
    
    foreach ( zombie in var_9c39bfc2688c4ae5 )
    {
        zombie dodamage( shatter_damage, block_origin, attacker, undefined, "MOD_IMPACT", undefined, "torso_upper", undefined );
        playfx( utility::getfx( "block_shot_impact" ), zombie.origin + ( 0, 0, 50 ) );
    }
}

// Namespace namespace_dba99780c141b678
// Params 4, eflags: 0x4
// Checksum 0x7242b41f, Offset: 0x3461
// Size: 0x336
function private function_2a1c8caa724700e4( position, angles, is_half_block = 0, ice_wall_settings )
{
    ice_wall_block = spawn( "script_model", position - ( 0, 0, 150 ) );
    ice_wall_block.angles = angles;
    ice_wall_block.spawn_position = position;
    ice_wall_block.spawn_angles = angles;
    ice_wall_block setcandamage( 0 );
    ice_wall_block notsolid();
    model_asset = level.var_6b629607b76c0354.model_assets[ level.var_6b629607b76c0354.model_asset_index ];
    ice_wall_block setmodel( model_asset );
    round_number = level.var_6b629607b76c0354.virgil_ent._blackboard.var_e9288b4c21f355a9 ? level.var_6b629607b76c0354.virgil_ent zombie_utils::get_zombie_round_difficulty() : zm_utility::get_round_number();
    scaled_health = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( "health_zombie_boss_virgil_ice_wall", round_number );
    ice_wall_block.health = int( scaled_health );
    ice_wall_block.maxhealth = ice_wall_block.health;
    ice_wall_block.fall_position = position - ( 0, 0, 150 );
    
    if ( is_half_block )
    {
        ice_wall_block.rise_position = position - ( 0, 0, 150 ) / 2;
    }
    else
    {
        ice_wall_block.rise_position = position;
    }
    
    ice_wall_block.var_5b0566b7a73a9d3f = 0;
    ice_wall_block.ice_wall_settings = ice_wall_settings;
    ice_wall_block.angles = ice_wall_block.angles;
    ice_wall_block.is_ice_wall = 1;
    ice_wall_block.var_e37b62be2007064a = [];
    ice_wall_block.var_97dd30f3586c0e31 = self;
    ice_wall_block thread math::function_ad1b3fbc486397da( ice_wall_block.origin, anglestoup( ice_wall_block.angles ), level.var_6b629607b76c0354.var_53dfdf1ad5f2507b[ level.var_6b629607b76c0354.var_2d736a4ffcec10a5 ], level.framedurationseconds );
    level.var_6b629607b76c0354.model_asset_index++;
    
    if ( level.var_6b629607b76c0354.model_asset_index >= level.var_6b629607b76c0354.model_assets.size )
    {
        level.var_6b629607b76c0354.model_asset_index = 0;
        level.var_6b629607b76c0354.var_2d736a4ffcec10a5++;
    }
    
    if ( level.var_6b629607b76c0354.var_2d736a4ffcec10a5 >= level.var_6b629607b76c0354.var_53dfdf1ad5f2507b.size )
    {
        level.var_6b629607b76c0354.var_2d736a4ffcec10a5 = 0;
    }
    
    ice_wall_block setscriptablepartstate( #"fx", #"spawn" );
    ice_wall_block setscriptablepartstate( #"model", #"hide" );
    return ice_wall_block;
}

// Namespace namespace_dba99780c141b678
// Params 1, eflags: 0x4
// Checksum 0xfe7ff98a, Offset: 0x37a0
// Size: 0x25b
function private cleanup_ice_wall_block( block_ent )
{
    level endon( #"game_ended" );
    block_ent endon( #"death" );
    
    if ( block_ent.ice_wall_settings.var_2c636187351a0692 > 0 )
    {
        var_b72df3c1b06913d1 = randomfloat( block_ent.ice_wall_settings.var_2c636187351a0692 );
        wait var_b72df3c1b06913d1;
    }
    
    if ( !isent( block_ent ) )
    {
        return;
    }
    
    if ( isarray( level.var_6b629607b76c0354.var_f5045aacb14d2759 ) )
    {
        level.var_6b629607b76c0354.var_f5045aacb14d2759 = arrayremove( level.var_6b629607b76c0354.var_f5045aacb14d2759, block_ent );
    }
    
    if ( block_ent.was_destroyed )
    {
        block_ent setscriptablepartstate( #"fx", #"destroyed" );
    }
    else
    {
        if ( block_ent.var_5b0566b7a73a9d3f )
        {
            block_ent setscriptablepartstate( #"fx", #"fall" );
            block_ent moveto( block_ent.fall_position, block_ent.ice_wall_settings.var_39760dce39fe4565 );
            wait block_ent.ice_wall_settings.var_39760dce39fe4565;
        }
        
        block_ent setscriptablepartstate( #"fx", #"deleted" );
    }
    
    block_ent notsolid();
    block_ent setcandamage( 0 );
    
    if ( block_ent.var_12aadf5d8bbfdafd )
    {
        destroynavobstacle( block_ent.var_12aadf5d8bbfdafd );
    }
    
    if ( block_ent )
    {
        if ( block_ent.ice_wall_settings.var_5af603e95a98d83e && block_ent.was_destroyed )
        {
            ice_wall = function_9e6cbb9351c6ff95( [ { #angles:block_ent.spawn_angles, #origin:block_ent.spawn_position } ] );
            level thread place_ice_wall( ice_wall, block_ent.ice_wall_settings );
        }
        
        block_ent.var_efcde2142240af7 = 1;
        wait 1.5;
        
        if ( isarray( self.block_ents ) )
        {
            self.block_ents = arrayremove( self.block_ents, block_ent );
            self notify( #"hash_8a9908eca3c37940" );
        }
        
        block_ent delete();
    }
}

// Namespace namespace_dba99780c141b678
// Params 1, eflags: 0x4
// Checksum 0xf3ed303b, Offset: 0x3a03
// Size: 0x3c
function private function_8759490d070d7dc0( block_ent )
{
    block_ent.var_97dd30f3586c0e31 = self;
    self.block_ents[ self.block_ents.size ] = block_ent;
    self notify( #"hash_a6fffc2ea578ac0e" );
}

// Namespace namespace_dba99780c141b678
// Params 0
// Checksum 0x9633b316, Offset: 0x3a47
// Size: 0x27c
function function_20489ced0b98219b()
{
    self notify( #"hash_69478cc6f10375cc" );
    self endon( #"hash_69478cc6f10375cc" );
    level endon( #"game_ended" );
    level.var_6b629607b76c0354.virgil_ent endon( #"death" );
    level.var_6b629607b76c0354.virgil_ent endon( #"end_ice_wall_attack" );
    var_571f2251ee2a3618 = 3;
    check_time_sec = 0.2;
    var_e08f4468011e3c78 = 1;
    cylinder_radius = level.var_6b629607b76c0354.default_settings.var_f13930fcf48fafc4 * 0.68;
    walls_checked = 0;
    
    while ( true )
    {
        block_list = level.var_6b629607b76c0354.var_f5045aacb14d2759;
        
        foreach ( block_ent in block_list )
        {
            if ( isent( block_ent ) )
            {
                var_4ec03c59fe015016 = function_d63fe6a4c08ba6f5( block_ent.rise_position, cylinder_radius, 250 );
                
                foreach ( player in var_4ec03c59fe015016 )
                {
                    guid = player.guid;
                    
                    if ( guid )
                    {
                        current_time_ms = gettime();
                        var_e310263a76963fdb = block_ent.var_e37b62be2007064a[ guid ];
                        
                        if ( isdefined( var_e310263a76963fdb ) )
                        {
                            if ( current_time_ms - var_e310263a76963fdb >= var_e08f4468011e3c78 * 1000 )
                            {
                                block_ent.was_destroyed = 1;
                                block_ent.var_97dd30f3586c0e31 thread cleanup_ice_wall_block( block_ent );
                                break;
                            }
                            
                            continue;
                        }
                        
                        block_ent.var_e37b62be2007064a[ guid ] = current_time_ms;
                    }
                }
            }
            
            walls_checked++;
            
            if ( walls_checked >= var_571f2251ee2a3618 )
            {
                walls_checked = 0;
                wait check_time_sec;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_dba99780c141b678
// Params 0, eflags: 0xc
// Checksum 0x8410001e, Offset: 0x3ccb
// Size: 0x8c
function private function_77247564e3f19ec4()
{
    self notify( #"hash_14cb31339f385c4a" );
    self endon( #"hash_14cb31339f385c4a" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isplayer( self ) && isalive( self ) )
    {
        val::set( "virgil_ice_wall_val", "ignore_playable_area_check", 1 );
    }
    
    wait level.var_6b629607b76c0354.var_26de9e18e02981cc;
    
    if ( isplayer( self ) && isalive( self ) )
    {
        val::reset( "virgil_ice_wall_val", "ignore_playable_area_check" );
    }
}

// Namespace namespace_dba99780c141b678
// Params 1, eflags: 0x4
// Checksum 0x6eb69331, Offset: 0x3d5f
// Size: 0x25
function private function_8bf5f2a33d9c8108( params )
{
    if ( isplayer( self ) )
    {
        val::reset( "virgil_ice_wall_val", "ignore_playable_area_check" );
    }
}

/#

    // Namespace namespace_dba99780c141b678
    // Params 0, eflags: 0x4
    // Checksum 0xfc07244e, Offset: 0x3d8c
    // Size: 0xba, Type: dev
    function private attack_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x5e>", "<dev string:x79>", &function_f813e384d8ce67ae );
        devgui::add_devgui_func( "<dev string:x96>", "<dev string:xaf>", &end_ice_wall_attack_thread );
        devgui::add_devgui_func( "<dev string:xca>", "<dev string:xe6>", &function_89ad38effe3fcec9 );
        devgui::add_devgui_func( "<dev string:x102>", "<dev string:x119>", &function_6e9c0eb963d6edcd );
        devgui::add_devgui_func( "<dev string:x138>", "<dev string:x14e>", &function_3c8ac0fff17b9042 );
        devgui::add_devgui_func( "<dev string:x164>", "<dev string:x17c>", &function_bd20d6cac773f5db );
        devgui::add_devgui_func( "<dev string:x194>", "<dev string:x1ac>", &function_f2f7f2d692ddf9c );
        devgui::function_77df7fe7dd273e10();
        level thread update_dvars_loop();
    }

    // Namespace namespace_dba99780c141b678
    // Params 0, eflags: 0x4
    // Checksum 0xcf1d6db1, Offset: 0x3e4e
    // Size: 0x27, Type: dev
    function private function_89ad38effe3fcec9()
    {
        ice_wall = function_52ec97b5c13f811();
        
        if ( isdefined( ice_wall ) )
        {
            level thread place_ice_wall( ice_wall );
        }
    }

    // Namespace namespace_dba99780c141b678
    // Params 0, eflags: 0x4
    // Checksum 0x65215fa8, Offset: 0x3e7d
    // Size: 0x21, Type: dev
    function private function_6e9c0eb963d6edcd()
    {
        function_f015caca0d93c44e( level.players[ 0 ].origin );
    }

    // Namespace namespace_dba99780c141b678
    // Params 0, eflags: 0xc
    // Checksum 0xae2ef976, Offset: 0x3ea6
    // Size: 0x28d, Type: dev
    function private function_bd20d6cac773f5db()
    {
        self notify( #"hash_f9d73f40f23a38fc" );
        self endon( #"hash_f9d73f40f23a38fc" );
        level endon( #"hash_cb7671d36379e267" );
        player = level.players[ 0 ];
        
        while ( true )
        {
            foreach ( ice_wall in level.var_6b629607b76c0354.ice_wall_structs )
            {
                foreach ( block_info_struct in ice_wall.var_5a80a1ad6341fffd )
                {
                    sphere( block_info_struct.origin + ( 0, 0, 150 ) / 2, 48.75, ice_wall.color );
                }
                
                var_8be38704b5cf82c6 = ice_wall.median_position + ( 0, 0, 150 ) / 2;
                sphere( var_8be38704b5cf82c6, 16.25, ice_wall.color );
                distance_to_player = distance( var_8be38704b5cf82c6, player.origin );
                print3d( var_8be38704b5cf82c6 + ( 0, 0, 75 ), "<dev string:x1c4>" + distance_to_player, ice_wall.color );
                var_4210be4b325a03a9 = vectornormalize( ice_wall.median_position - player.origin );
                var_45b45f7bf216555e = vectordot( anglestoforward( player.angles ), var_4210be4b325a03a9 );
                print3d( var_8be38704b5cf82c6 + ( 0, 0, 50 ), "<dev string:x1d9>" + var_45b45f7bf216555e, ice_wall.color );
                
                if ( ice_wall.var_23e6e147b7cc1983 )
                {
                    print3d( var_8be38704b5cf82c6 + ( 0, 0, 100 ), "<dev string:x1eb>" + ice_wall.var_23e6e147b7cc1983, ice_wall.color );
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_dba99780c141b678
    // Params 0, eflags: 0xc
    // Checksum 0x6b885c44, Offset: 0x413b
    // Size: 0x29, Type: dev
    function private function_f2f7f2d692ddf9c()
    {
        self notify( #"hash_b603fb474405c37e" );
        self endon( #"hash_b603fb474405c37e" );
        level notify( #"hash_cb7671d36379e267" );
    }

    // Namespace namespace_dba99780c141b678
    // Params 0, eflags: 0xc
    // Checksum 0x411ba75, Offset: 0x416c
    // Size: 0x3eb, Type: dev
    function private update_dvars_loop()
    {
        self notify( #"hash_a1bf48b926d492f6" );
        self endon( #"hash_a1bf48b926d492f6" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( level.var_6b629607b76c0354 )
            {
                level.var_6b629607b76c0354.var_b8736f8168d17c97 = getdvarint( @"hash_93ba880462cb940f", 100 );
                level.var_6b629607b76c0354.var_b8967d8168f7e319 = getdvarint( @"hash_9397760462a524c1", 300 );
                level.var_6b629607b76c0354.var_69396a4956869729 = getdvarint( @"hash_f3b603873978d8e1", 100 );
                level.var_6b629607b76c0354.var_a4bfb3046615ed0d = getdvarint( @"hash_7ff9b84289649525", 50 );
                level.var_6b629607b76c0354.var_a38ec8288702c551 = getdvarint( @"hash_b314dc4586ec1b39", 150 );
                level.var_6b629607b76c0354.var_ab36bebeec5276c8 = getdvarint( @"hash_61f332f9eedafc2c", 200 );
                level.var_6b629607b76c0354.var_ce34a824babdb06f = getdvarfloat( @"hash_b526fca5b1a06e73", 6 );
                level.var_6b629607b76c0354.default_settings.var_27c6e69ad666a936 = getdvarint( @"hash_faa9907245c20da9", 500 );
                level.var_6b629607b76c0354.default_settings.var_dcb9a05d87784b54 = getdvarfloat( @"hash_675d85825b35f26b", 12 );
                level.var_6b629607b76c0354.default_settings.var_70bbf852ea79c4ba = getdvarfloat( @"hash_17decbe3b3945c7e", 2 );
                level.var_6b629607b76c0354.default_settings.var_39760dce39fe4565 = getdvarfloat( @"hash_d3c4c4e55211809", 0.2 );
                level.var_6b629607b76c0354.default_settings.var_6c0ed12be32db1d2 = getdvarint( @"hash_b5f72b4d95e7d6b0", 300 );
                level.var_6b629607b76c0354.default_settings.var_e944fda6f8663bca = getdvarfloat( @"hash_5f5033fe5084ff4c", 0.55 );
                level.var_6b629607b76c0354.default_settings.var_dea2bef07bc41277 = getdvarfloat( @"hash_36450455c0281299", 0.5 );
                level.var_6b629607b76c0354.default_settings.ice_block_player_damage = getdvarint( @"hash_aa03ae886fda891f", 50 );
                level.var_6b629607b76c0354.default_settings.var_6fa394937ac3d679 = getdvarfloat( @"hash_9b4c8afc77c59405", 10 );
                level.var_6b629607b76c0354.default_settings.var_64bf2bd1792ae381 = getdvarint( @"hash_bf0df9a10fa6889d", 700 );
                level.var_6b629607b76c0354.default_settings.var_1607b7a6b428ada = getdvarfloat( @"hash_d6b839c295ee47ce", 2 );
                level.var_6b629607b76c0354.default_settings.var_f13930fcf48fafc4 = getdvarfloat( @"hash_f6e2e7b54dfe04db", 87.75 );
                level.var_6b629607b76c0354.default_settings.var_786f877946506ca8 = getdvarfloat( @"hash_130baf900490578c", 1 );
                level.var_6b629607b76c0354.default_settings.var_c5f3db68d5c004f5 = getdvarint( @"hash_93b0bd2683ecc949", 200 );
                level.var_6b629607b76c0354.default_settings.var_42b8877cd18925e2 = getdvarint( @"hash_98a42413c244d436", 50 );
            }
            
            wait 0.5;
        }
    }

#/
