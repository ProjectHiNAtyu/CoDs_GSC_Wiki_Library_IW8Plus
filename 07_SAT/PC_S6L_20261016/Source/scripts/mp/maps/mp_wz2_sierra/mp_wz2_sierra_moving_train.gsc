// scripts\mp\maps\mp_wz2_sierra\mp_wz2_sierra_moving_train.gsc  (hash_1dbc3a99e873061b.gscc) (size: 3810 Bytes / 0xee2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0ccb243 (2966204995)
// size ...... 3810 (0xee2)
// includes .. 3   (offset: 0xd86)
// strings ... 24  (offset: 0xd9e)
// dev strs .. 0   (offset: 0xec6)
// exports ... 9   (offset: 0x976)
// cseg ...... 0x2b0 + 0x6c6 (0x976)
// imports ... 22  (offset: 0xade)
// animtree1 . 1   (offset: 0xec6)
// animtree2 . 1   (offset: 0xed2)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_movingtrain;
#using scripts\mp\br\gametypes\br_movingtrain_control;

#namespace mp_wz2_sierra_moving_train;

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0xaa4d7218, Offset: 0x2ce
// Size: 0x17
function main()
{
    function_520723dadb740f2c();
    setup_callbacks();
    br_movingtrain_control::init();
}

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0x90c4b57a, Offset: 0x2ee
// Size: 0xfa
function function_520723dadb740f2c()
{
    if ( !isdefined( level.wztrain_info ) )
    {
        level.wztrain_info = spawnstruct();
    }
    
    level.wztrain_info.randomize_cars = getdvarint( @"hash_d48782ad3dc1c748", 0 );
    level.wztrain_info.var_8ffd3d4db9ebbe9 = getdvarint( @"hash_a255a53c2c2c1cb4", 0 );
    level.wztrain_info.var_48de1da01e0424e = getdvarint( @"hash_2ca82f29d6e71757", 0 );
    level.wztrain_info.train_names = [ "cargo_train" ];
    level.wztrain_info.anim_spawnposition_override = ( -9661, -9119, -299.007 );
    level.wztrain_info.assembly_anim_override = "sierra_loop";
    level.wztrain_info.var_56bb104cdb5cae39 = ( 0, 0, 61 );
}

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0xc148284c, Offset: 0x3f0
// Size: 0x96
function setup_callbacks()
{
    level.wztrain_info.get_train_array_callbacks = [];
    level.wztrain_info.get_train_array_callbacks[ 0 ] = &function_8012d4184557ac30;
    level.wztrain_info.var_18e7fab01a0c6314 = &function_18e7fab01a0c6314;
    level.wztrain_info.var_6048c54a82cb67bc = &function_6048c54a82cb67bc;
    level.wztrain_info.var_fe79d9e956816715 = &function_fe79d9e956816715;
    level.wztrain_info.var_3b1e2cf7c964f91d = &function_3b1e2cf7c964f91d;
}

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0x2bb81aa3, Offset: 0x48e
// Size: 0x428
function function_8012d4184557ac30()
{
    model_noteworthy = function_fe79d9e956816715();
    traincar_locomotive = getent( "train_sierra_01", #script_noteworthy );
    var_f9d6ef171a8530cb = getent( "train_sierra_02", #script_noteworthy );
    var_ddc89805f85f6d99 = getent( "train_sierra_03", #script_noteworthy );
    var_514e68ba28a1832b = getent( "train_sierra_04", #script_noteworthy );
    var_b587a6c55511cce2 = getent( "train_sierra_05", #script_noteworthy );
    var_9772a538f5da0021 = getent( "train_sierra_06", #script_noteworthy );
    var_9772a238f5d9f988 = getent( "train_sierra_07", #script_noteworthy );
    var_b587a5c55511caaf = getent( "train_sierra_08", #script_noteworthy );
    
    if ( br_movingtrain_control::function_1fd15c7b0e2117bf() )
    {
        var_b587a5c55511caaf = getent( "train_sierra_10", #script_noteworthy );
    }
    
    var_8621c36d021209f = [ traincar_locomotive, var_f9d6ef171a8530cb, var_ddc89805f85f6d99, var_514e68ba28a1832b, var_b587a6c55511cce2, var_9772a538f5da0021, var_9772a238f5d9f988, var_b587a5c55511caaf ];
    var_4a229bc993ea48db = [ [ traincar_locomotive, var_f9d6ef171a8530cb, var_ddc89805f85f6d99, var_514e68ba28a1832b, var_b587a6c55511cce2, var_9772a538f5da0021, var_9772a238f5d9f988, var_b587a5c55511caaf ], [ traincar_locomotive, var_f9d6ef171a8530cb, var_ddc89805f85f6d99, var_514e68ba28a1832b, var_b587a6c55511cce2 ] ];
    
    if ( level.wztrain_info.var_48de1da01e0424e >= var_4a229bc993ea48db.size || level.wztrain_info.var_48de1da01e0424e < 0 )
    {
        level.wztrain_info.var_48de1da01e0424e = 0;
    }
    
    array = var_4a229bc993ea48db[ level.wztrain_info.var_48de1da01e0424e ];
    
    if ( level.wztrain_info.var_8ffd3d4db9ebbe9 )
    {
        array = utility::array_random( var_4a229bc993ea48db );
    }
    
    if ( level.wztrain_info.randomize_cars )
    {
        array = br_movingtrain::function_680f3bebac867b56( array );
    }
    
    array = function_5713d46873b29625( array );
    var_8621c36d021209f = function_5713d46873b29625( var_8621c36d021209f );
    var_bdd242241b79c98a = arrayremove( var_8621c36d021209f, array );
    
    foreach ( traincar_to_remove in var_bdd242241b79c98a )
    {
        if ( !isdefined( traincar_to_remove ) )
        {
            continue;
        }
        
        if ( isdefined( traincar_to_remove.targetname ) )
        {
            continue;
        }
        
        noteworthy = traincar_to_remove.script_noteworthy;
        var_f0e3d1f55e4c1df9 = strtok( noteworthy, "_" );
        traincarindex = var_f0e3d1f55e4c1df9[ var_f0e3d1f55e4c1df9.size - 1 ];
        script_noteworthy = model_noteworthy + traincarindex;
        model = getent( script_noteworthy, #script_noteworthy );
        
        if ( isdefined( model ) )
        {
            model delete();
        }
        
        traincar_hurts = getentarray( noteworthy + "_train_front_hurt", #script_noteworthy );
        var_4636b0ed5fd0c7e = getentarray( noteworthy + "_train_rear_hurt", #script_noteworthy );
        traincar_hurts = arraycombine( traincar_hurts, var_4636b0ed5fd0c7e );
        
        foreach ( traincar_hurt in traincar_hurts )
        {
            traincar_hurt delete();
        }
        
        traincar_to_remove delete();
    }
    
    return array;
}

#using_animtree( "script_model" );

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0x2a0ff440, Offset: 0x8bf
// Size: 0x43
function function_18e7fab01a0c6314()
{
    level.scr_anim[ "cargo_train" ][ level.wztrain_info.assembly_anim_override ][ 0 ] = %mp_wz2_sierra_train;
    level.scr_animtree[ "cargo_train" ] = #animtree;
}

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0xa9020451, Offset: 0x90a
// Size: 0x7
function function_6048c54a82cb67bc()
{
    return "veh8_mil_lnd_br_train_assembly_skeleton";
}

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0xce36fbd5, Offset: 0x91a
// Size: 0x7
function function_fe79d9e956816715()
{
    return "train_sierra_model_";
}

// Namespace mp_wz2_sierra_moving_train
// Params 0
// Checksum 0xc490f396, Offset: 0x92a
// Size: 0x4b
function function_3b1e2cf7c964f91d()
{
    return [ "veh8_train_locomotive_joint_01", "veh8_train_flatbed_joint_01", "veh8_train_flatbed_joint_02", "veh8_train_cart_joint_01", "veh8_train_flatbed_joint_03", "veh8_train_flatbed_joint_04", "veh8_train_flatbed_joint_05", "veh8_train_flatbed_joint_06" ];
}

