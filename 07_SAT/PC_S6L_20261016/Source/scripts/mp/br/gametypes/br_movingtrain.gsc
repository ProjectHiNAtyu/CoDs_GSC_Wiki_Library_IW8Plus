// scripts\mp\br\gametypes\br_movingtrain.gsc  (hash_43bc3fb715f8509e.gscc) (size: 66305 Bytes / 0x10301 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ede097c (1054738812)
// size ...... 66305 (0x10301)
// includes .. 43  (offset: 0xf285)
// strings ... 232 (offset: 0xf3dd)
// dev strs .. 27  (offset: 0x10185)
// exports ... 117 (offset: 0xb26d)
// cseg ...... 0x1392 + 0x9edb (0xb26d)
// imports ... 353 (offset: 0xc4b5)
// animtree1 . 1   (offset: 0x102cd)
// animtree2 . 2   (offset: 0x102dd)
#using script_78fc8c746d423a6d;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\flags;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_ai;
#using scripts\common\vehicle_collision;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_paths;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_dmz_radiation;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_moving_platforms_util;
#using scripts\mp\br\gametypes\br_movingtrain_mtx;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\equipment\at_mine;
#using scripts\mp\common\equipment\claymore;
#using scripts\mp\common\equipment\deployed_decoy;
#using scripts\mp\common\equipment\tac_insert;
#using scripts\mp\common\equipment\trophy_system;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\train_utility;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\dmz\gametypes\dmz_safes;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\poi;
#using scripts\mp\uav_tower;

#namespace br_movingtrain;

// Namespace br_movingtrain
// Params 1
// Checksum 0x4259aa6c, Offset: 0x13b0
// Size: 0x3af, Type: bool
function init( forceidle )
{
    level endon( #"game_ended" );
    utility::flag_wait( "public_event_init_attempted" );
    
    if ( utility::flag_exist( "level_train_init_complete" ) )
    {
        utility::flag_wait( "level_train_init_complete" );
    }
    
    if ( !isdefined( level.wztrain_info ) )
    {
        level.wztrain_info = spawnstruct();
    }
    
    utility::flag_init( "wztrain_array_set" );
    utility::flag_init( "wztrain_processed_track" );
    utility::flag_init( "wztrain_spawn_started" );
    utility::flag_init( "wztrain_anim_playing" );
    utility::registersharedfunc( #"br_movingtrain", #"predictcargotrainpositions", &predictcargotrainpositions );
    utility::registersharedfunc( #"br_movingtrain", #"changecargotrainspeed", &changecargotrainspeed );
    level callback::add( #"hash_92f629d70137a6ae", &function_243621d72d1e7532 );
    level.wztrain_info.var_3939e842564a1212 = &function_5768093be7b2afa5;
    level.wztrain_info.var_3901bd9418d5c077 = getmatchrulesdata( "brData", "trainMunitionEnabled" );
    level.wztrain_info.kioskenabled = getmatchrulesdata( "brData", "trainKioskEnabled" );
    level.wztrain_info.uavtowerenabled = getmatchrulesdata( "brData", "trainUAVTowerEnabled" );
    level.wztrain_info.contractenabled = getmatchrulesdata( "brData", "trainContractEnabled" );
    level.wztrain_info.usebespokecrates = getmatchrulesdata( "brData", "trainUseBespokeCrates" );
    level.wztrain_info.spawnedcrates = 0;
    
    if ( isfunction( level.wztrain_info.var_6b3bb1b35ef2be75 ) )
    {
        level.wztrain_info.var_f719108ea4db580c = [[ level.wztrain_info.var_6b3bb1b35ef2be75 ]]();
    }
    else
    {
        level.wztrain_info.var_f719108ea4db580c = [ "wz_item_loot_cache_lege", "wz_item_loot_cache", "wz_item_loot_cache_reusable", "wz_item_loot_cache", "wz_item_loot_cache_lege", "wz_item_loot_cache", "wz_item_loot_cache_reusable" ];
    }
    
    var_cf933129ac00f9d = getdvar( @"hash_8e5abaef90730525", "" );
    
    if ( var_cf933129ac00f9d != "" )
    {
        var_7447ffee62e58c51 = strtok( var_cf933129ac00f9d, " " );
        itemcount = 0;
        
        foreach ( item in var_7447ffee62e58c51 )
        {
            if ( itemcount >= level.wztrain_info.var_f719108ea4db580c.size )
            {
                println( "<dev string:x24>" );
                break;
            }
            
            level.wztrain_info.var_f719108ea4db580c[ itemcount ] = item;
            itemcount++;
        }
        
        /#
            if ( itemcount < level.wztrain_info.var_f719108ea4db580c.size )
            {
                println( "<dev string:x69>" );
            }
        #/
    }
    
    function_a2f21d4050e7f40b();
    
    if ( !level init_train_arrays( forceidle ) )
    {
        println( "<dev string:xac>" );
        return false;
    }
    
    level thread wait_for_sequence_start();
    scriptable::scriptable_addusedcallback( &function_915a6827d0fa3a1d );
    
    /#
        br_dev::registerhandlecommand( &handledevcommand_br );
    #/
    
    return true;
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xae23ff26, Offset: 0x1768
// Size: 0x6f
function wait_for_sequence_start()
{
    /#
        level thread warp_player_debug();
    #/
    
    if ( tolower( getdvar( @"mapname" ) ) != "mp_train_wz" )
    {
        level thread traincar_wait_until_shown();
        utility::flag_wait( "br_prematchEnded" );
        
        if ( level.helltrain )
        {
            ai_mp_controller::function_3d6581dd2c928fbc( agent_utils::function_25b40f5accbca0dd( "merc" ) );
            wait 1;
        }
    }
    
    if ( !br_public::function_9dc52a7da56f6544() )
    {
        return;
    }
    
    level thread play_train_sequence();
}

#using_animtree( "script_model" );

// Namespace br_movingtrain
// Params 0
// Checksum 0x8728152c, Offset: 0x17df
// Size: 0x210
function train_wzcircle_override()
{
    if ( getdvarfloat( @"hash_b1243debdeb65967", 0 ) == 0 )
    {
        return;
    }
    
    var_5ca971d5dcfce82 = getdvarfloat( @"hash_b1243debdeb65967", 0 );
    
    if ( var_5ca971d5dcfce82 != 1 )
    {
        if ( randomint( 100 ) < var_5ca971d5dcfce82 * 100 )
        {
            return;
        }
    }
    
    var_fd87921df4add7a = arraycombine( level.br_level.br_circleclosetimes, level.br_level.br_circledelaytimes );
    totalroundtime = 0;
    
    for ( i = 0; i < var_fd87921df4add7a.size ; i++ )
    {
        totalroundtime += var_fd87921df4add7a[ i ];
    }
    
    if ( totalroundtime <= 0 )
    {
        return;
    }
    
    totalroundtime = train_wzcircle_time_subtractfrom( totalroundtime );
    xanim = %iw9_mp_train_saba_a_cw;
    xanimlength = getanimlength( xanim );
    
    if ( !isdefined( xanimlength ) || xanimlength <= 0 )
    {
        return;
    }
    
    lengthmod = totalroundtime / xanimlength;
    lengthdelta = lengthmod - int( lengthmod );
    circleposattime = getoriginforanimtime( ( 0, 0, 13 ), ( 0, 0, 0 ), xanim, lengthdelta );
    level.wztrain_info.circletimestruct = spawnstruct();
    level.wztrain_info.circletimestruct.xanimlength = xanimlength;
    level.wztrain_info.circletimestruct.lengthmod = lengthmod;
    level.wztrain_info.circletimestruct.lengthdelta = lengthdelta;
    level.wztrain_info.circletimestruct.totalroundtime = totalroundtime;
    level.wztrain_info.circletimestruct.circleposattime = circleposattime;
    setdvar( @"hash_9c956e70471179f5", circleposattime );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xfa4a8506, Offset: 0x19f7
// Size: 0xb6
function train_wzcircle_time_subtractfrom( totalroundtime )
{
    var_8224eb0a2229c48c = 425;
    
    if ( getdvarint( @"hash_b2e704499feadf68", 425 ) != 425 )
    {
        var_8224eb0a2229c48c = getdvarint( @"hash_b2e704499feadf68", 425 );
    }
    
    if ( getdvarint( @"hash_b35edec538a597b0", 75 ) > 0 )
    {
        input = getdvarint( @"hash_b35edec538a597b0", 75 );
        var_8224eb0a2229c48c += randomint( input );
    }
    
    incrementcheck = 10;
    i = 0;
    
    while ( i < var_8224eb0a2229c48c - incrementcheck )
    {
        if ( totalroundtime - incrementcheck > 0 )
        {
            totalroundtime -= incrementcheck;
        }
        
        i += incrementcheck;
    }
    
    return totalroundtime;
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x7f61f6a3, Offset: 0x1ab6
// Size: 0x1ea
function function_a2f21d4050e7f40b()
{
    var_6f1fab09e4a30dcb = getscriptbundle( "itemspawnzonedef:" + level.commonitem.var_f4a0cd0e44af4832 );
    
    if ( isdefined( var_6f1fab09e4a30dcb ) )
    {
        level.wztrain_info.var_128e63a0866ad78b = [];
        level.wztrain_info.var_183d01e68d56a982 = 0;
        count = 0;
        
        foreach ( cachebundle in var_6f1fab09e4a30dcb.var_2f3b9a0f877e32b1 )
        {
            switch ( cachebundle.cacheitemspawnentry ?? "" )
            {
                case #"hash_13118f41253789b6":
                case #"hash_e61c64e7e90ccfb4":
                case #"hash_f09542882a7f72e5":
                    continue;
            }
            
            level.wztrain_info.var_128e63a0866ad78b[ count ] = {};
            level.wztrain_info.var_128e63a0866ad78b[ count ].type = cachebundle.cacheitemspawnentry;
            level.wztrain_info.var_128e63a0866ad78b[ count ].spawnweight = cachebundle.cacheweight;
            level.wztrain_info.var_183d01e68d56a982 += level.wztrain_info.var_128e63a0866ad78b[ count ].spawnweight ?? 0;
            count++;
        }
        
        return;
    }
    
    assertmsg( "<dev string:xcb>" );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x600ec6a1, Offset: 0x1ca8
// Size: 0xab9, Type: bool
function init_train_arrays( forceidle )
{
    level.wztrain_info.train_array = [];
    level.wztrain_info.trains = [];
    level.wztrain_info.var_12d86286c993c84e = [];
    level.wztrain_info.var_9bf8b25f9708aa08 = [];
    level.wztrain_info.var_69a237e15ef60fd8 = [];
    level.wztrain_info.var_3c027e9a6fe33c9f = 0;
    
    if ( isdefined( level.wztrain_info.get_train_array_callbacks ) )
    {
        foreach ( index, train_callback in level.wztrain_info.get_train_array_callbacks )
        {
            train_name = level.wztrain_info.train_names[ index ];
            train_array = [[ train_callback ]]();
            
            foreach ( traincar in train_array )
            {
                traincar.train_name = train_name;
            }
            
            level.wztrain_info.trains[ train_name ] = train_array;
            level.wztrain_info.train_array = arraycombine( level.wztrain_info.train_array, train_array );
        }
        
        level.wztrain_info.var_3c027e9a6fe33c9f = level.wztrain_info.get_train_array_callbacks.size > 1;
    }
    else
    {
        level.wztrain_info.train_names = [ "cargo_train" ];
        
        if ( isdefined( getent( "train_car_0", #script_noteworthy ) ) )
        {
            level.wztrain_info.trains[ level.wztrain_info.train_names[ 0 ] ] = [ getent( "train_car_0", #script_noteworthy ), getent( "train_car_1", #script_noteworthy ), getent( "train_car_2", #script_noteworthy ), getent( "train_car_3", #script_noteworthy ), getent( "train_car_4", #script_noteworthy ), getent( "train_car_5", #script_noteworthy ), getent( "train_car_6", #script_noteworthy ), getent( "train_car_7", #script_noteworthy ) ];
            
            if ( level.helltrain )
            {
                additional_cars = [ getent( "train_car_8", #script_noteworthy ), getent( "train_car_9", #script_noteworthy ), getent( "train_car_10", #script_noteworthy ), getent( "train_car_11", #script_noteworthy ), getent( "train_car_12", #script_noteworthy ) ];
                level.wztrain_info.trains[ level.wztrain_info.train_names[ 0 ] ] = arraycombine( level.wztrain_info.trains[ level.wztrain_info.train_names[ 0 ] ], additional_cars );
            }
        }
        else
        {
            level.wztrain_info.trains[ level.wztrain_info.train_names[ 0 ] ] = [ getent( "train_car_18", #script_noteworthy ), getent( "train_car_17", #script_noteworthy ), getent( "train_car_16", #script_noteworthy ), getent( "train_car_15", #script_noteworthy ), getent( "train_car_14", #script_noteworthy ), getent( "train_car_13", #script_noteworthy ), getent( "train_car_12", #script_noteworthy ), getent( "train_car_11", #script_noteworthy ) ];
        }
        
        level.wztrain_info.var_3c027e9a6fe33c9f = isdefined( getent( "train_car_20", #script_noteworthy ) );
        
        if ( level.wztrain_info.var_3c027e9a6fe33c9f )
        {
            level.wztrain_info.train_names[ level.wztrain_info.train_names.size ] = "br_passenger_train";
            level.wztrain_info.trains[ level.wztrain_info.train_names[ 1 ] ] = [ getent( "train_car_20", #script_noteworthy ), getent( "train_car_21", #script_noteworthy ), getent( "train_car_22", #script_noteworthy ), getent( "train_car_23", #script_noteworthy ), getent( "train_car_24", #script_noteworthy ), getent( "train_car_25", #script_noteworthy ), getent( "train_car_26", #script_noteworthy ), getent( "train_car_27", #script_noteworthy ) ];
            level.wztrain_info.train_array = [];
            
            foreach ( trainname in level.wztrain_info.train_names )
            {
                foreach ( traincar in level.wztrain_info.trains[ trainname ] )
                {
                    level.wztrain_info.train_array[ level.wztrain_info.train_array.size ] = traincar;
                }
            }
        }
        else
        {
            level.wztrain_info.train_array = level.wztrain_info.trains[ level.wztrain_info.train_names[ 0 ] ];
        }
    }
    
    foreach ( traincar in level.wztrain_info.train_array )
    {
        if ( !isent( traincar ) )
        {
            /#
                var_645f45a7b4d05089 = "<dev string:x153>";
                
                foreach ( othertraincar in level.wztrain_info.train_array )
                {
                    if ( isdefined( othertraincar ) && isdefined( othertraincar.script_noteworthy ) )
                    {
                        var_645f45a7b4d05089 += "<dev string:x154>" + othertraincar.script_noteworthy;
                    }
                }
                
                println( "<dev string:x156>" + var_645f45a7b4d05089 );
            #/
            
            return false;
        }
        
        utility::register_moving_platform_ent( traincar );
        utility::register_moving_platform_ent( traincar.linked_model );
    }
    
    if ( isdefined( level.wztrain_info.var_90a1bb7c92889346 ) )
    {
        [[ level.wztrain_info.var_90a1bb7c92889346 ]]();
    }
    
    train_wzcircle_override();
    train_play_anim_init();
    train_attach_player_hurts();
    train_associate_models_with_brushes();
    train_attach_brushes_to_models();
    train_attach_models_to_assembly();
    function_2ed492d3d0e9ef51();
    
    if ( isdefined( level.wztrain_info.var_ca0855a527d76bc8 ) )
    {
        [[ level.wztrain_info.var_ca0855a527d76bc8 ]]();
    }
    
    if ( isdefined( level.wztrain_info.train_vfx_init_callback ) )
    {
        level thread [[ level.wztrain_info.train_vfx_init_callback ]]();
    }
    else
    {
        level thread train_vfx_init();
    }
    
    level thread train_sfx_init();
    level thread function_4c0bdc113657087c();
    level thread train_handle_collide_mines();
    function_e494eec988601845();
    
    if ( isbrgamemode() )
    {
        foreach ( spawntype, spawndata in level.wztrain_info.spawndata.configs )
        {
            if ( getdvarint( hashcat( @"hash_82213c16d0a252f0", spawntype ), 1 ) )
            {
                level thread function_ebd77d9626d56616( level.wztrain_info.train_array, spawntype );
            }
        }
    }
    
    utility::flag_set( "wztrain_array_set" );
    return true;
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x3b9030b8, Offset: 0x276a
// Size: 0x2b5
function train_associate_models_with_brushes()
{
    var_7464da7f20fff306 = "train_car_model_";
    
    if ( isdefined( level.wztrain_info.var_fe79d9e956816715 ) )
    {
        var_7464da7f20fff306 = [[ level.wztrain_info.var_fe79d9e956816715 ]]();
    }
    
    for ( i = 0; i < level.wztrain_info.train_array.size ; i++ )
    {
        traincar_model = undefined;
        traincar_brush = level.wztrain_info.train_array[ i ];
        script_noteworthy = undefined;
        
        if ( isarray( var_7464da7f20fff306 ) )
        {
            script_noteworthy = var_7464da7f20fff306[ i ];
        }
        else
        {
            var_f0e3d1f55e4c1df9 = strtok( traincar_brush.script_noteworthy, "_" );
            traincarindex = var_f0e3d1f55e4c1df9[ var_f0e3d1f55e4c1df9.size - 1 ];
            script_noteworthy = var_7464da7f20fff306 + traincarindex;
        }
        
        traincar_models = getentarray( script_noteworthy, #script_noteworthy );
        
        if ( getdvarint( @"hash_bcfe79955df6639b", 1 ) > 0 && isdefined( traincar_models ) )
        {
            traincar_models = sortbydistance( traincar_models, traincar_brush.origin );
        }
        
        if ( isdefined( traincar_models ) )
        {
            traincar_model = traincar_models[ 0 ];
        }
        
        if ( isdefined( level.wztrain_info.var_9664e78772455612 ) )
        {
            override_model = [[ level.wztrain_info.var_9664e78772455612 ]]( i );
            
            if ( isdefined( override_model ) )
            {
                traincar_model setmodel( override_model );
            }
        }
        
        traincar_mover = traincar_model;
        is_vehicle = isdefined( traincar_brush.mtx_vehicle_ref );
        
        if ( is_vehicle )
        {
            old_model = traincar_model;
            spawndata = spawnstruct();
            spawndata.origin = old_model.origin;
            spawndata.angles = old_model.angles;
            spawndata.var_d80f437cbeba153f = 1;
            
            if ( isdefined( traincar_brush.var_86495b2556c44285 ) )
            {
                spawndata.script_modelname = traincar_brush.var_86495b2556c44285;
            }
            
            traincar_model = br_movingtrain_mtx::function_aeb82fde0985ce6b( traincar_brush.mtx_vehicle_ref, spawndata );
            traincar_model.script_noteworthy = script_noteworthy;
            old_model setmodel( "tag_origin" );
        }
        
        if ( isent( traincar_mover ) )
        {
            if ( !utility::is_moving_platform_ent( traincar_mover ) )
            {
                utility::register_moving_platform_ent( traincar_mover );
            }
            
            traincar_brush.linked_mover = traincar_mover;
            traincar_brush.linked_mover markkeyframedmover();
        }
        
        if ( isent( traincar_model ) )
        {
            traincar_brush.linked_model = traincar_model;
            traincar_model.linked_brush = traincar_brush;
        }
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x770da705, Offset: 0x2a27
// Size: 0x9a
function train_attach_brushes_to_models()
{
    for ( i = 0; i < level.wztrain_info.train_array.size ; i++ )
    {
        traincar_brush = level.wztrain_info.train_array[ i ];
        train_init_as_vehicle( traincar_brush );
        traincar_brush forcenetfieldhighlod( 1 );
        traincar_brush setmoveroptimized( 1 );
        traincar_brush setmoverantilagged( 1 );
        traincar_brush function_2735e38f58370a0f( 1 );
        traincar_brush linkto( traincar_brush.linked_mover );
        traincar_brush setmovingplatformdef( "movingplatform_rotator" );
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x34075627, Offset: 0x2ac9
// Size: 0x208
function train_attach_models_to_assembly()
{
    foreach ( train, array in level.wztrain_info.trains )
    {
        animent = level.wztrain_info.animent[ train ];
        
        for ( i = 0; i < array.size ; i++ )
        {
            traincar = array[ i ];
            thistag = level.wztrain_info.train_tag_array[ i ];
            tagorigin = animent gettagorigin( thistag );
            tagoffset = level.wztrain_info.train_tagoffset_array[ i ];
            traincar.linked_model forcenetfieldhighlod( 1 );
            traincar.linked_model setmoveroptimized( 1 );
            traincar.linked_model setmoverantilagged( 1 );
            traincar.linked_model function_2735e38f58370a0f( 1 );
            traincar.linked_model.origin = tagorigin;
            traincar.linked_mover forcenetfieldhighlod( 1 );
            traincar.linked_mover setmoveroptimized( 1 );
            traincar.linked_mover setmoverantilagged( 1 );
            traincar.linked_mover function_2735e38f58370a0f( 1 );
            traincar.linked_mover.origin = tagorigin;
            
            if ( getdvarint( @"hash_f524d127e4ba82c4", 0 ) > 0 )
            {
                traincar.linked_mover linkto( animent, thistag, tagoffset, ( 0, 0, 0 ) );
            }
        }
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x85cb76d2, Offset: 0x2cd9
// Size: 0x6f
function function_680f3bebac867b56( array )
{
    if ( !isdefined( array ) || array.size <= 3 )
    {
        return array;
    }
    
    lastindex = array.size - 1;
    slice = utility::array_slice( array, 1, lastindex );
    shuffle = arrayrandomize( slice );
    return arraycombine( [ array[ 0 ] ], shuffle, [ array[ lastindex ] ] );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x13966c5, Offset: 0x2d51
// Size: 0xaa
function train_init_as_vehicle( vehicle )
{
    vehiclename = "cargo_train";
    
    if ( isdefined( vehicle.linked_model.vehiclename ) )
    {
        vehiclename = vehicle.linked_model.vehiclename;
    }
    
    vehicle.vehiclename = vehiclename;
    vehicle.linked_model.vehiclename = vehiclename;
    train_initcollision( vehiclename, level.wztrain_info.forceidle );
    vehicle thread br_moving_platforms_util::function_905cbeab47d4a3d9();
    vehicle.linked_model thread br_moving_platforms_util::function_905cbeab47d4a3d9();
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x28df13b7, Offset: 0x2e03
// Size: 0xe
function train_stop()
{
    level notify( #"hash_3ef68844276aed0a" );
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x8e00b448, Offset: 0x2e19
// Size: 0x65
function traincar_wait_until_shown()
{
    level endon( #"game_ended" );
    utility::flag_wait( "wztrain_scriptables_init_done" );
    waitframe();
    train_elements_disable();
    utility::flag_wait( "br_prematchEnded" );
    
    if ( level.wztrain_info.flag_wait_start )
    {
        utility::flag_wait( level.wztrain_info.flag_wait_start );
    }
    
    train_elements_enable();
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xb3d79b38, Offset: 0x2e86
// Size: 0xa6
function function_8d08cb063283557b( enable_hurt )
{
    traincar = self;
    
    if ( isdefined( traincar.traincar_hurts ) )
    {
        foreach ( traincar_hurt in traincar.traincar_hurts )
        {
            traincar_hurt.hurt_enabled = enable_hurt;
        }
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xf3b8c14, Offset: 0x2f34
// Size: 0x8e
function train_elements_enable()
{
    foreach ( train in level.wztrain_info.animent )
    {
        specific_train_elements_enable( train.animname );
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xc9466145, Offset: 0x2fca
// Size: 0x1b3
function specific_train_elements_enable( specific_train )
{
    if ( arraycontains( level.wztrain_info.var_69a237e15ef60fd8, specific_train ) )
    {
        level.wztrain_info.var_69a237e15ef60fd8 = arrayremove( level.wztrain_info.var_69a237e15ef60fd8, specific_train );
        
        foreach ( traincar in level.wztrain_info.train_array )
        {
            if ( isdefined( traincar.linked_model ) )
            {
                traincar.linked_model show();
                traincar.linked_model solid();
                traincar solid();
                traincar function_8d08cb063283557b( 1 );
                
                if ( isdefined( traincar.ammo_restock ) )
                {
                    traincar.ammo_restock thread function_ca8e5388b1fe8df8();
                    var_65b4405706be5fb4 = isdefined( traincar.ammo_restock.entity );
                    
                    if ( var_65b4405706be5fb4 )
                    {
                        traincar.ammo_restock.entity show();
                    }
                }
                
                if ( isdefined( traincar.uav_tower ) )
                {
                    traincar.uav_tower setscriptablepartstate( "uav_tower", "usable" );
                    traincar.uav_tower setscriptablepartstate( "objective", "inactive" );
                }
            }
        }
    }
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x138bb1e7, Offset: 0x3185
// Size: 0x6b
function private function_ca8e5388b1fe8df8()
{
    wait 3;
    part = "military_ammo_restock";
    
    if ( !self getscriptablehaspart( part ) )
    {
        return;
    }
    
    var_932f7e5c45d69770 = "useable_on_no_collision";
    state_fallback = "useable_on";
    
    if ( self getscriptableparthasstate( part, var_932f7e5c45d69770 ) )
    {
        self setscriptablepartstate( part, var_932f7e5c45d69770 );
        return;
    }
    
    if ( self getscriptableparthasstate( part, state_fallback ) )
    {
        self setscriptablepartstate( part, state_fallback );
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xb08acbc1, Offset: 0x31f8
// Size: 0x8e
function train_elements_disable()
{
    foreach ( train in level.wztrain_info.animent )
    {
        specific_train_elements_disable( train.animname );
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xbff4e200, Offset: 0x328e
// Size: 0x1f8
function specific_train_elements_disable( specific_train )
{
    if ( !arraycontains( level.wztrain_info.var_69a237e15ef60fd8, specific_train ) )
    {
        train = level.wztrain_info.trains[ specific_train ];
        level.wztrain_info.var_69a237e15ef60fd8[ level.wztrain_info.var_69a237e15ef60fd8.size ] = specific_train;
        
        foreach ( traincar in train )
        {
            if ( isdefined( traincar.linked_model ) )
            {
                traincar.linked_model hide();
                traincar.linked_model notsolid();
                traincar notsolid();
                traincar function_8d08cb063283557b( 0 );
                
                if ( isdefined( traincar.uav_tower ) )
                {
                    traincar.uav_tower setscriptablepartstate( "uav_tower", "hidden" );
                    traincar.uav_tower setscriptablepartstate( "objective", "none" );
                }
                
                if ( isdefined( traincar.ammo_restock ) )
                {
                    traincar.ammo_restock setscriptablepartstate( "military_ammo_restock", "disabled" );
                    var_65b4405706be5fb4 = isdefined( traincar.ammo_restock.entity );
                    
                    if ( var_65b4405706be5fb4 )
                    {
                        traincar.ammo_restock.entity hide();
                    }
                }
                
                if ( traincar.linked_model isscriptable() )
                {
                    level notify( "forced_kill_callout_" + traincar.linked_model.script_noteworthy );
                }
            }
        }
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xd3ff3580, Offset: 0x348e
// Size: 0x222
function function_af5e3cc8b1c018ff( train_name )
{
    var_bbad8377ede94bec = 2000;
    level endon( #"game_ended" );
    utility::flag_wait( "wztrain_array_set" );
    animent = level.wztrain_info.animent[ train_name ];
    animent notify( #"watch_nearby" );
    animent endon( #"watch_nearby" );
    traincars = level.wztrain_info.trains[ train_name ];
    
    while ( true )
    {
        train_center = vectorlerp( traincars[ 0 ].origin, traincars[ traincars.size - 1 ].origin, 0.5 );
        broad_radius = distance( traincars[ 0 ].origin, train_center ) + var_bbad8377ede94bec;
        nearby = sortbydistancecullbyradius( level.players, train_center, broad_radius );
        
        for ( i = nearby.size - 1; i >= 0 ; i-- )
        {
            player = nearby[ i ];
            is_near = 0;
            
            foreach ( traincar in [ traincars[ 0 ], traincars[ int( ( traincars.size - 1 ) / 2 ) ], traincars[ traincars.size - 1 ] ] )
            {
                if ( isdefined( player.origin ) && distancesquared( traincar.origin, player.origin ) <= var_bbad8377ede94bec * var_bbad8377ede94bec )
                {
                    is_near = 1;
                    break;
                }
            }
            
            if ( !is_near )
            {
                nearby[ i ] = undefined;
            }
        }
        
        level.wztrain_info.var_12d86286c993c84e[ train_name ] = nearby;
        wait 2;
    }
}

// Namespace br_movingtrain
// Params 2
// Checksum 0xe79c05f6, Offset: 0x36b8
// Size: 0x53
function train_initcollision( vehicle_ref, forceidle )
{
    if ( forceidle )
    {
        return;
    }
    
    leveldataforvehicle = vehicle_collision::get_data( vehicle_ref, 1 );
    leveldataforvehicle.handleeventcallback = &handle_train_veh_collision;
    leveldataforvehicle.class = "immovable";
}

// Namespace br_movingtrain
// Params 5
// Checksum 0x67e1dca2, Offset: 0x3713
// Size: 0x4d
function handle_train_veh_collision( vehicle1, vehicle2, position, normal, normalspeed )
{
    collisionresult = br_moving_platforms_util::function_50beefc634f5b6ac( vehicle1, vehicle2, "cargo_train", 1, 0 );
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xe76a4bf, Offset: 0x3768
// Size: 0x359
function train_handle_collide_mines()
{
    level endon( #"game_ended" );
    level endon( #"hash_3ef68844276aed0a" );
    train_engines = [];
    
    foreach ( train_array in level.wztrain_info.trains )
    {
        train_engines[ train_engines.size ] = train_array[ 0 ];
    }
    
    var_7e24887539cf1c3a = 150;
    
    if ( getdvarfloat( @"hash_731567d6c424394d", 150 ) != 150 )
    {
        var_7e24887539cf1c3a = getdvarfloat( @"hash_731567d6c424394d", 150 );
    }
    
    maxdist = var_7e24887539cf1c3a - 25;
    maxdistsq = maxdist * maxdist;
    
    while ( true )
    {
        all_mines = weapon::function_3aafcaf7ff6dea9e();
        
        if ( all_mines.size > 0 )
        {
            foreach ( train_engine in train_engines )
            {
                pointtocheck = train_engine.origin + rotatevector( ( 375, 0, -100 ), train_engine.angles );
                
                foreach ( mine in all_mines )
                {
                    if ( !isdefined( mine ) )
                    {
                        continue;
                    }
                    
                    if ( mine.markedfordelete )
                    {
                        continue;
                    }
                    
                    if ( distance2dsquared( mine.origin, pointtocheck ) > maxdistsq )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( mine.origin, pointtocheck ) > maxdistsq )
                    {
                        continue;
                    }
                    
                    if ( isdefined( mine.weapon_name ) )
                    {
                        if ( mine.weapon_name == "trophy_mp" )
                        {
                            mine trophy_system::sweeptrophy();
                            mine.markedfordelete = 1;
                            continue;
                        }
                        
                        if ( mine.weapon_name == "claymore_mp" )
                        {
                            mine claymore::sweepclaymore();
                            mine.markedfordelete = 1;
                            continue;
                        }
                        
                        if ( mine.weapon_name == "at_mine_mp" )
                        {
                            mine at_mine::at_mine_destroy();
                            mine.markedfordelete = 1;
                            continue;
                        }
                        
                        if ( mine.weapon_name == "tac_insert_trigger" )
                        {
                            mine tac_insert::deletetacinsert();
                            mine.markedfordelete = 1;
                            continue;
                        }
                        
                        if ( mine.weapon_name == "deployed_decoy_mp" )
                        {
                            mine deployed_decoy::function_53115de24fa0db2b();
                            mine.markedfordelete = 1;
                        }
                    }
                }
            }
        }
        
        waitframe();
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xa68f10e8, Offset: 0x3ac9
// Size: 0xf5
function play_train_sequence()
{
    level endon( #"game_ended" );
    
    if ( level.wztrain_info.flag_wait_start )
    {
        utility::flag_wait( level.wztrain_info.flag_wait_start );
    }
    
    utility::flag_set( "wztrain_spawn_started" );
    
    foreach ( train, array in level.wztrain_info.trains )
    {
        level thread train_play_anim( train, array );
    }
    
    level thread function_f9ceac7cc9c25c07();
    
    /#
        if ( getdvarint( @"hash_e7014031cbb7e017", 0 ) )
        {
            announcement( "<dev string:x172>" );
        }
    #/
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xb66ae2c4, Offset: 0x3bc6
// Size: 0xac
function function_f9ceac7cc9c25c07()
{
    utility::flag_wait( "wztrain_anim_playing" );
    wait 2;
    
    for ( i = 0; i < level.wztrain_info.train_array.size ; i++ )
    {
        trainmodel = level.wztrain_info.train_array[ i ].linked_model;
        
        if ( isdefined( trainmodel ) && trainmodel isscriptable() && trainmodel getscriptablehaspart( "icon" ) && trainmodel getscriptableparthasstate( "icon", "visible" ) )
        {
            trainmodel setscriptablepartstate( "icon", "visible" );
        }
    }
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x67cca1b0, Offset: 0x3c7a
// Size: 0x20, Type: bool
function private function_b098a7e6c999b288()
{
    return !utility::flag( "wztrain_scriptables_init_done" ) && getdvarint( @"hash_85b2dc73cdc711df", 0 );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xf6adb053, Offset: 0x3ca3
// Size: 0x1b6
function function_b1a5c6899ee82ff2( type )
{
    if ( !isdefined( type ) )
    {
        return;
    }
    
    if ( issubstr( type, "loot_cache" ) )
    {
        if ( level.wztrain_info.usebespokecrates )
        {
            if ( level.wztrain_info.spawnedcrates >= level.wztrain_info.var_f719108ea4db580c.size )
            {
                println( "<dev string:x187>" );
                return type;
            }
            
            returntype = level.wztrain_info.var_f719108ea4db580c[ level.wztrain_info.spawnedcrates ];
            level.wztrain_info.spawnedcrates++;
            return returntype;
        }
        else if ( isdefined( level.wztrain_info.var_128e63a0866ad78b ) )
        {
            randomchance = randomintrange( 1, level.wztrain_info.var_183d01e68d56a982 );
            currentweight = 0;
            
            foreach ( cachedata in level.wztrain_info.var_128e63a0866ad78b )
            {
                currentweight += cachedata.spawnweight ?? 0;
                
                if ( randomchance <= currentweight )
                {
                    return cachedata.type;
                }
            }
        }
        else
        {
            println( "<dev string:x1f5>" );
        }
    }
    
    return type;
}

// Namespace br_movingtrain
// Params 2
// Checksum 0xe4d8baa1, Offset: 0x3e62
// Size: 0xc3
function function_f54a1fbe7f8ba75d( type, traincar )
{
    scriptable = self;
    currentstate = scriptable getscriptablepartstate( "body", 1 );
    
    if ( isdefined( currentstate ) && currentstate != "hidden" )
    {
        if ( level.wztrain_info.var_8be39b34228d2d )
        {
            if ( !isdefined( traincar.hiddencaches ) )
            {
                traincar.hiddencaches = [];
            }
            
            traincar.hiddencaches[ traincar.hiddencaches.size ] = scriptable;
            br_moving_platforms_util::function_4ad1be68090cbc56( scriptable );
        }
        else
        {
            br_moving_platforms_util::function_2a5d3149998b776a( scriptable );
        }
    }
    
    if ( function_b098a7e6c999b288() )
    {
        br_moving_platforms_util::function_52c1c5b599ce76ac( scriptable, "military_loot_crate_01_br_nogeometry" );
    }
}

// Namespace br_movingtrain
// Params 4, eflags: 0x4
// Checksum 0x59c8f136, Offset: 0x3f2d
// Size: 0xdf
function private uav_spawn_callback( type, origin, angles, traincar )
{
    if ( !uav_tower::function_d54bbc8100ac0b16() )
    {
        assertmsg( "<dev string:x256>" );
        return spawnstruct();
    }
    
    while ( !isdefined( level.uavtowers ) )
    {
        waitframe();
    }
    
    towerstruct = spawnstruct();
    towerstruct.origin = origin;
    towerstruct.angles = angles;
    scriptable = uav_tower::function_e9d70c7951442090( towerstruct, "scriptable_uav_tower_short", "uav_tower", "uav_tower_laptop" );
    towerstruct.script_poi = function_cbf0f80b4d5e0b9e();
    towerstruct.var_237005472a482004 = 1;
    towerstruct.traincar = traincar;
    traincar.var_87038cec80bd2c66 = 0;
    return scriptable;
}

// Namespace br_movingtrain
// Params 2, eflags: 0x4
// Checksum 0x986657e2, Offset: 0x4015
// Size: 0x32
function private function_98a4591dfd6d2db( type, traincar )
{
    traincar.uav_tower = self;
    self setscriptablepartstate( "uav_tower", "reset" );
}

// Namespace br_movingtrain
// Params 4, eflags: 0x4
// Checksum 0x9070c7cd, Offset: 0x404f
// Size: 0xc0
function private kiosk_spawn_callback( type, origin, angles, traincar )
{
    stationstruct = spawnstruct();
    stationstruct.origin = origin;
    stationstruct.angles = angles;
    scriptable = br_moving_platforms_util::function_bcd8bb47c82370fb( stationstruct );
    scriptable.traincar = traincar;
    
    if ( common_item::items_isenabled() )
    {
        level.common_armory_kiosk.instances[ level.common_armory_kiosk.instances.size ] = scriptable;
    }
    
    if ( function_b098a7e6c999b288() )
    {
        br_moving_platforms_util::function_52c1c5b599ce76ac( scriptable, "military_purchase_kiosk_02_nogeometry" );
    }
    
    return scriptable;
}

// Namespace br_movingtrain
// Params 4, eflags: 0x4
// Checksum 0xf42cdac1, Offset: 0x4118
// Size: 0x19d
function private ammo_spawn_callback( type, origin, angles, traincar )
{
    scriptable = undefined;
    
    if ( type == "military_ammo_restock" )
    {
        model_name = "military_ammo_restock_location";
        
        if ( function_b098a7e6c999b288() )
        {
            model_name = "military_ammo_restock_location_solid_mp";
        }
        
        model = spawn( "script_model", traincar.origin );
        model setmodel( model_name );
        model.angles = angles;
        
        if ( isdefined( level.wztrain_info.var_56bb104cdb5cae39 ) )
        {
            model linkto( traincar.linked_model, "tag_origin", origin + level.wztrain_info.var_56bb104cdb5cae39, angles );
        }
        else if ( getdvarint( @"hash_8066b3a35a1021cc", 0 ) )
        {
            model linkto( traincar.linked_model, "tag_origin", origin, angles );
        }
        else
        {
            model linkto( traincar.linked_model, "tag_origin", origin + ( 0, 0, 90 ), angles );
        }
        
        model markkeyframedmover();
        model forcenetfieldhighlod( 1 );
        model setmoveroptimized( 1 );
        model setmoverantilagged( 1 );
        model function_2735e38f58370a0f( 1 );
        scriptable = model getlinkedscriptableinstance();
        
        if ( isdefined( scriptable ) )
        {
            scriptable.linkedparent = traincar.linked_model;
        }
    }
    else
    {
        scriptable = spawnscriptable( type, traincar.origin + origin, angles );
    }
    
    return scriptable;
}

// Namespace br_movingtrain
// Params 2, eflags: 0x4
// Checksum 0x2e2b6be0, Offset: 0x42be
// Size: 0x22
function private function_c2fbb069b2afc5f9( type, traincar )
{
    traincar.ammo_restock = self;
}

// Namespace br_movingtrain
// Params 4, eflags: 0x4
// Checksum 0x4172e856, Offset: 0x42e8
// Size: 0xdc
function private function_febd2c31608696d2( type, origin, angles, traincar )
{
    if ( type == "palfa_fuel_spawn" )
    {
        struct = spawnstruct();
        struct.origin = origin;
        struct.angles = angles;
        struct.traincar = traincar;
        level.var_acb300d2dc16529f = struct;
        return struct;
    }
    
    is_cargo_train = isdefined( level.wztrain_info.trains[ "cargo_train" ] ) && arraycontains( level.wztrain_info.trains[ "cargo_train" ], traincar );
    
    if ( type == "military_ammo_restock_noent" && is_cargo_train )
    {
        return function_d8992b8e8f399aef( origin, traincar );
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x14ff2ca7, Offset: 0x43cc
// Size: 0x17a
function function_a3e42a28bb2cd9bc()
{
    utility::flag_wait( "wztrain_scriptables_spawned" );
    
    foreach ( train in level.wztrain_info.trains )
    {
        foreach ( traincar in train )
        {
            if ( !traincar.hiddencaches )
            {
                continue;
            }
            
            foreach ( cache in traincar.hiddencaches )
            {
                br_moving_platforms_util::function_2a5d3149998b776a( cache );
            }
        }
    }
}

// Namespace br_movingtrain
// Params 4, eflags: 0x4
// Checksum 0x9430e730, Offset: 0x454e
// Size: 0x5f
function private br_loot_crate_spawn_callback( type, origin, angles, traincar )
{
    itembundlename = type;
    scriptable = common_cache::function_cc09d3a70f175d1d( itembundlename, origin, angles, undefined, level.commonitem.var_f4a0cd0e44af4832 );
    return scriptable;
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x73212992, Offset: 0x45b6
// Size: 0x42
function private function_cbf0f80b4d5e0b9e()
{
    configname = game_utility_mp::function_3e2a0e4a5bf03624();
    
    switch ( configname )
    {
        case #"hash_10871b4ceef02902":
            return "jup_bigmap_train site_71";
        case #"":
            return "jup_bigmap_train site_124";
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xde8403af, Offset: 0x4601
// Size: 0x3b3
function function_e494eec988601845()
{
    init_train_spawn_data();
    
    if ( isdefined( level.wztrain_info.trains[ "cargo_train" ] ) && getdvarint( @"hash_8066b3a35a1021cc", 0 ) )
    {
        var_4afcc362cacb859e = level.wztrain_info.trains[ "cargo_train" ] index_clamped( 1 );
        var_4afcc262cacb836b = level.wztrain_info.trains[ "cargo_train" ] index_clamped( -2 );
        kiosk_offset = ( -30, 75, -30 );
        function_f67d10c4b6208a2d( var_4afcc362cacb859e, "kiosk", "br_plunder_box", kiosk_offset, ( 0, -90, 0 ) );
        function_f67d10c4b6208a2d( var_4afcc262cacb836b, "kiosk", "br_plunder_box", rotatevector( kiosk_offset, ( 0, 180, 0 ) ), ( 0, 90, 0 ) );
        cache_offset = ( 32.5, 65, -30 );
        function_f67d10c4b6208a2d( var_4afcc362cacb859e, "loot", "br_reusable_loot_cache", cache_offset, ( 0, 180, 0 ) );
        function_f67d10c4b6208a2d( var_4afcc262cacb836b, "loot", "br_reusable_loot_cache", rotatevector( cache_offset, ( 0, 180, 0 ) ), ( 0, 0, 0 ) );
        ammo_offset = ( -150, -48, 45 );
        function_f67d10c4b6208a2d( var_4afcc362cacb859e, "ammo", "military_ammo_restock", ammo_offset, ( 0, 90, 0 ) );
        function_f67d10c4b6208a2d( var_4afcc262cacb836b, "ammo", "military_ammo_restock", rotatevector( ammo_offset, ( 0, 180, 0 ) ), ( 0, -90, 0 ) );
        objective_traincar = level.wztrain_info.trains[ "cargo_train" ] index_clamped( 3 );
        function_f67d10c4b6208a2d( objective_traincar, "uav", "scriptable_uav_tower", ( 0, -50, -30 ), ( 0, 90, 0 ) );
    }
    
    if ( isdefined( level.wztrain_info.var_de1cd1f04d366cf ) )
    {
        foreach ( callback in level.wztrain_info.var_de1cd1f04d366cf )
        {
            [[ callback ]]();
        }
    }
    
    if ( getdvarint( @"hash_e619c4c384b28bb7", 1 ) <= 0 )
    {
        function_f67d10c4b6208a2d( level.wztrain_info.train_array[ 1 ], "ammo", "military_ammo_restock_train", ( 20, 0, 5 ), ( 0, 90, 0 ) );
    }
    
    foreach ( spawntype, spawndata in level.wztrain_info.spawndata.configs )
    {
        function_111a914476298eba( level.wztrain_info.train_array, spawntype );
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x7568dfde, Offset: 0x49bc
// Size: 0x6f
function function_31ad47ee3276842c( callback )
{
    if ( !isdefined( level.wztrain_info.var_de1cd1f04d366cf ) )
    {
        level.wztrain_info.var_de1cd1f04d366cf = [];
    }
    
    size = level.wztrain_info.var_de1cd1f04d366cf.size;
    level.wztrain_info.var_de1cd1f04d366cf[ size ] = callback;
}

// Namespace br_movingtrain
// Params 5
// Checksum 0x9661d341, Offset: 0x4a33
// Size: 0xba
function function_f67d10c4b6208a2d( traincar, spawn_type, scriptable_name, offset, angles )
{
    noteworthy = traincar.script_noteworthy;
    
    if ( !isdefined( noteworthy ) )
    {
        return;
    }
    
    spawn_names = noteworthy + "_" + spawn_type;
    traincar_spawn = spawnstruct();
    traincar_spawn.script_noteworthy = spawn_names;
    traincar_spawn.origin = traincar localtoworldcoords( offset );
    traincar_spawn.angles = angles;
    traincar_spawn.targetname = scriptable_name;
    utility::addstruct( traincar_spawn );
    return traincar_spawn;
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xb4673dab, Offset: 0x4af6
// Size: 0x157
function init_train_spawn_data()
{
    lootspawndata = get_train_spawn_data( "loot" );
    
    if ( getdvarint( @"hash_f252952942ac1731", 1 ) )
    {
        lootspawndata.var_c45a9fb8969a25b = &function_b1a5c6899ee82ff2;
    }
    
    lootspawndata.var_165643fe763f1ed4 = &function_f54a1fbe7f8ba75d;
    
    if ( game_utility::getgametype() == "dmz" )
    {
        lootspawndata.spawncallback = &function_febd2c31608696d2;
    }
    else
    {
        lootspawndata.spawncallback = &br_loot_crate_spawn_callback;
    }
    
    if ( level.wztrain_info.var_3901bd9418d5c077 )
    {
        ammospawndata = get_train_spawn_data( "ammo" );
        ammospawndata.spawncallback = &ammo_spawn_callback;
        ammospawndata.var_165643fe763f1ed4 = &function_c2fbb069b2afc5f9;
    }
    
    if ( level.wztrain_info.kioskenabled )
    {
        kioskspawndata = get_train_spawn_data( "kiosk" );
        kioskspawndata.spawncallback = &kiosk_spawn_callback;
    }
    
    if ( level.wztrain_info.uavtowerenabled )
    {
        uavspawndata = get_train_spawn_data( "uav" );
        uavspawndata.spawncallback = &uav_spawn_callback;
        uavspawndata.var_165643fe763f1ed4 = &function_98a4591dfd6d2db;
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x1f53247a, Offset: 0x4c55
// Size: 0xdf
function get_train_spawn_data( spawntype )
{
    if ( !isdefined( level.wztrain_info.spawndata ) )
    {
        spawndata = spawnstruct();
        spawndata.configs = [];
        spawndata.scriptables = [];
        level.wztrain_info.spawndata = spawndata;
    }
    
    spawndata = level.wztrain_info.spawndata.configs[ spawntype ];
    
    if ( !isdefined( spawndata ) )
    {
        spawndata = function_d47ae7cc75a1bdc6();
        spawndata.maxcount = getdvarint( hashcat( @"hash_cbf441b8b33ab2bb", spawntype, "_max_count" ), -1 );
        level.wztrain_info.spawndata.configs[ spawntype ] = spawndata;
    }
    
    return spawndata;
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xf696851, Offset: 0x4d3d
// Size: 0x43
function function_d47ae7cc75a1bdc6()
{
    spawndata = spawnstruct();
    spawndata.maxcount = -1;
    spawndata.var_c45a9fb8969a25b = undefined;
    spawndata.spawncallback = undefined;
    spawndata.var_165643fe763f1ed4 = undefined;
    return spawndata;
}

// Namespace br_movingtrain
// Params 2
// Checksum 0x9431f06b, Offset: 0x4d89
// Size: 0x234
function function_111a914476298eba( train_array, spawn_type )
{
    game_utility::function_c4ff84a7288ed707();
    
    foreach ( traincar in train_array )
    {
        noteworthy = traincar.script_noteworthy;
        spawn_names = noteworthy + "_" + spawn_type;
        traincar_spawns = utility::getstructarray( spawn_names, "script_noteworthy" );
        
        if ( noteworthy == "train_jup_13" && spawn_type == "safe" )
        {
            traincar_spawns = utility::getstructarray( "train_jup_model_13_safe", "script_noteworthy" );
        }
        
        if ( noteworthy == "train_car_14" )
        {
            hack_array = utility::getstructarray( "train_car_14", "script_noteworthy" );
            
            if ( hack_array.size > 0 )
            {
                traincar_spawns = hack_array;
            }
        }
        
        if ( traincar_spawns.size > 0 )
        {
            traincar.spawned_objects[ spawn_type ] = [];
            traincar.spawn_info[ spawn_type ] = spawnstruct();
            traincar.spawn_info[ spawn_type ].count = traincar_spawns.size;
        }
        
        for ( i = 0; i < traincar_spawns.size ; i++ )
        {
            var_72db38fac8bc7c23 = traincar_spawns[ i ].origin - traincar.origin;
            offset = rotatevectorinverted( var_72db38fac8bc7c23, traincar.angles );
            traincar.spawn_info[ spawn_type ].offsets[ i ] = offset;
            traincar.spawn_info[ spawn_type ].angles[ i ] = traincar_spawns[ i ].angles;
            traincar.spawn_info[ spawn_type ].type[ i ] = traincar_spawns[ i ].targetname;
        }
    }
    
    game_utility::function_48cf7b776b9642d3();
}

// Namespace br_movingtrain
// Params 2
// Checksum 0xfa5a155e, Offset: 0x4fc5
// Size: 0x30c
function function_ebd77d9626d56616( train_array, spawn_type )
{
    level endon( #"game_ended" );
    utility::flag_wait( "wztrain_array_set" );
    
    if ( level.wztrain_info.kioskenabled )
    {
        utility::flag_wait( "br_kiosk_initialized" );
    }
    
    utility::flag_wait( "items_database_init" );
    
    foreach ( traincar in train_array )
    {
        if ( !isdefined( traincar.spawn_info ) )
        {
            continue;
        }
        
        spawn_info = traincar.spawn_info[ spawn_type ];
        spawn_data = get_train_spawn_data( spawn_type );
        
        if ( !( isdefined( spawn_info ) && isdefined( spawn_info.count ) ) )
        {
            continue;
        }
        
        for ( i = 0; i < spawn_info.count ; i++ )
        {
            type = spawn_info.type[ i ];
            offset = spawn_info.offsets[ i ];
            angles = spawn_info.angles[ i ];
            
            if ( isfunction( spawn_data.var_c45a9fb8969a25b ) )
            {
                type = [[ spawn_data.var_c45a9fb8969a25b ]]( type );
            }
            
            if ( !isdefined( type ) )
            {
                continue;
            }
            else if ( type == "weapon_vm_mg_sentry_turret_train" || type == "equipment_wm_tripwire_train" || type == "lm_offhand_wm_at_mine_train" || type == "offhand_2h_wm_decoy_mine_dummy01_v0_train" )
            {
                continue;
            }
            
            scriptable = undefined;
            
            if ( isdefined( spawn_data.spawncallback ) )
            {
                scriptable = [[ spawn_data.spawncallback ]]( type, offset, angles, traincar );
            }
            
            if ( type == "palfa_fuel_spawn" )
            {
                continue;
            }
            
            if ( !isdefined( scriptable ) )
            {
                scriptable = spawnscriptable( type, traincar.origin + offset, angles );
            }
            
            scriptable.onmovingtrain = 1;
            
            if ( !isdefined( traincar.spawned_objects[ spawn_type ][ type ] ) )
            {
                traincar.spawned_objects[ spawn_type ][ type ] = [];
            }
            
            traincar.spawned_objects[ spawn_type ][ type ][ traincar.spawned_objects[ spawn_type ][ type ].size ] = scriptable;
            
            if ( type == "military_ammo_restock_noent" )
            {
                scriptable setscriptablepartstate( "military_ammo_restock", "useable_on_no_icon" );
                traincar.ammo_restock = scriptable;
            }
            
            if ( scriptable isscriptableinstance() )
            {
                scriptable thread function_750241492c0ff402( type, traincar, offset, angles, spawn_data.var_165643fe763f1ed4 );
            }
            
            /#
                if ( getdvarint( @"hash_6c41679db3595674", 0 ) )
                {
                    scriptable thread function_82f82dfb82198a50();
                }
            #/
        }
    }
    
    utility::flag_set( "wztrain_scriptables_spawned" );
}

// Namespace br_movingtrain
// Params 5
// Checksum 0x778b0807, Offset: 0x52d9
// Size: 0x77
function function_750241492c0ff402( type, traincar, offset, angles, var_165643fe763f1ed4 )
{
    level endon( #"game_ended" );
    wait 1;
    
    if ( !isdefined( self.linkedparent ) )
    {
        utility::scriptable_setparententity( traincar, offset, angles );
    }
    
    if ( isfunction( var_165643fe763f1ed4 ) )
    {
        self [[ var_165643fe763f1ed4 ]]( type, traincar );
    }
    
    waitframe();
    utility::flag_set( "wztrain_scriptables_init_done" );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x93a0e934, Offset: 0x5358
// Size: 0x38
function function_243621d72d1e7532( params )
{
    if ( isbrgamemode() )
    {
        if ( level.wztrain_info.contractenabled )
        {
            function_dd587f855eb4eb6a();
            level thread function_170fb434e50f9a9f();
        }
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xc0a86ce6, Offset: 0x5398
// Size: 0x240
function function_dd587f855eb4eb6a()
{
    if ( !isdefined( level.wztrain_info ) )
    {
        return;
    }
    
    if ( !isdefined( level.wztrain_info.dom_cars ) )
    {
        level.wztrain_info.dom_cars = [];
    }
    
    car_array = level.wztrain_info.trains[ "cargo_train" ];
    
    if ( !isdefined( car_array ) )
    {
        return;
    }
    
    if ( isdefined( car_array[ 1 ] ) )
    {
        domnode = spawnstruct();
        domnode.origin = ( -135, -50, 49 );
        domnode.angles = ( 0, 80, 0 );
        domnode.spawnflags = 2;
        car_array[ 1 ].var_b25418214626adee = domnode;
        level.wztrain_info.dom_cars[ level.wztrain_info.dom_cars.size ] = car_array[ 1 ];
    }
    
    if ( isdefined( car_array[ 5 ] ) )
    {
        domnode = spawnstruct();
        domnode.origin = ( 70, 40, 49 );
        domnode.angles = ( 0, -125, 0 );
        domnode.spawnflags = 2;
        car_array[ 5 ].var_b25418214626adee = domnode;
        level.wztrain_info.dom_cars[ level.wztrain_info.dom_cars.size ] = car_array[ 5 ];
    }
    
    if ( isdefined( car_array[ 7 ] ) )
    {
        domnode = spawnstruct();
        domnode.origin = ( -150, 45, 49 );
        domnode.angles = ( 0, 225, 0 );
        domnode.spawnflags = 2;
        car_array[ 7 ].var_b25418214626adee = domnode;
        level.wztrain_info.dom_cars[ level.wztrain_info.dom_cars.size ] = car_array[ 7 ];
    }
    
    level.wztrain_info.dom_cars = arrayrandomize( level.wztrain_info.dom_cars );
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x283db157, Offset: 0x55e0
// Size: 0x18d
function function_170fb434e50f9a9f()
{
    level endon( #"game_ended" );
    level endon( #"hash_3ef68844276aed0a" );
    
    if ( !level.wztrain_info.dom_cars.size )
    {
        return;
    }
    
    flags::gameflagwait( "prematch_fade_done" );
    car_array = level.wztrain_info.trains[ "cargo_train" ];
    
    if ( !isdefined( car_array ) )
    {
        return;
    }
    
    carriage = car_array[ 3 ];
    
    if ( !isent( carriage ) )
    {
        return;
    }
    
    tabletoffset = ( 85, 0, -24 );
    var_985b33773952e1ae = ( 0, 180, 0 );
    delay_time = getdvarint( @"hash_54c901ec9ce00a38", 60 );
    
    while ( true )
    {
        while ( level.wztrain_info.contract_in_gas )
        {
            wait 5;
        }
        
        tablet = function_1c563f21e2ffa3d0( "brloot_train_recon_tablet", carriage.origin + tabletoffset, carriage.angles + var_985b33773952e1ae );
        
        if ( !isdefined( tablet ) )
        {
            println( "<dev string:x2b1>" );
            return;
        }
        
        tablet scriptablesetparententity( carriage, tabletoffset, var_985b33773952e1ae );
        activity = tablet.var_edc89ff04fe6a343.activityinstance;
        
        if ( !isdefined( activity ) )
        {
            println( "<dev string:x316>" );
            return;
        }
        
        activity waittill( #"activity_ended" );
        
        if ( delay_time > 0 )
        {
            wait delay_time;
        }
    }
}

// Namespace br_movingtrain
// Params 3
// Checksum 0x51cce351, Offset: 0x5775
// Size: 0xb8
function function_1c563f21e2ffa3d0( lootref, origin, angles )
{
    spawnoptions = common_item::function_bc5ff2958b71a708( origin, angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.cleanupdisabled = 1;
    spawnoptions.critical = 1;
    spawnoptions.keepinmap = 1;
    spawnoptions.var_f35b5b18b029c493 = 0;
    spawnoptions.var_8d4f327170228364 = 0;
    spawnoptions.var_cf4938fb18f3fb7d = #"visible";
    newtablet = common_item::function_61c2c0251e742ffd( common_item::function_80af1e9daffacc7d( lootref ), 1, spawnoptions );
    return newtablet;
}

// Namespace br_movingtrain
// Params 2, eflags: 0x4
// Checksum 0xbbe57f00, Offset: 0x5836
// Size: 0x57, Type: bool
function private function_8fb6d56c9b67e411( train, lootstruct )
{
    return lootstruct.targetname == "military_ammo_restock_noent" && train == "cargo_train" && game_utility::getgametype() == "dmz" && lootstruct.script_noteworthy != "train_car_3_loot";
}

/#

    // Namespace br_movingtrain
    // Params 0, eflags: 0x4
    // Checksum 0xb595741, Offset: 0x5896
    // Size: 0xcc, Type: dev
    function private function_82f82dfb82198a50()
    {
        rs = [ 100, 5000 ];
        
        while ( true )
        {
            waitframe();
            
            foreach ( r in rs )
            {
                utility::draw_capsule( self.origin + ( 0, 0, r * -1 ), r, r * 2, ( 0, 0, 0 ), ( 1, 0, 0 ), 0, 1 );
            }
        }
    }

#/

// Namespace br_movingtrain
// Params 0
// Checksum 0x9cd12f48, Offset: 0x596a
// Size: 0x252
function train_attach_player_hurts()
{
    foreach ( train in level.wztrain_info.trains )
    {
        engine = train[ 0 ];
        
        foreach ( traincar in train )
        {
            noteworthy = traincar.script_noteworthy;
            hurt_name = noteworthy + "_train_front_hurt";
            hurt_name_rear = noteworthy + "_train_rear_hurt";
            
            if ( isdefined( level.wztrain_info.var_fb1bb936249e2410 ) )
            {
                hurt_name = noteworthy + level.wztrain_info.var_fb1bb936249e2410;
            }
            
            traincar_hurts = getentarray( hurt_name, #script_noteworthy );
            var_4636b0ed5fd0c7e = getentarray( hurt_name_rear, #script_noteworthy );
            traincar_hurts = arraycombine( traincar_hurts, var_4636b0ed5fd0c7e );
            traincar.traincar_hurts = [];
            traincar.var_4636b0ed5fd0c7e = [];
            
            foreach ( traincar_hurt in traincar_hurts )
            {
                if ( isent( traincar_hurt ) )
                {
                    traincar.traincar_hurts[ traincar.traincar_hurts.size ] = traincar_hurt;
                    traincar_hurt enablelinkto();
                    traincar_hurt linkto( traincar );
                    traincar_hurt thread train_hurt_damage_watcher( traincar, engine );
                }
            }
        }
    }
}

// Namespace br_movingtrain
// Params 2
// Checksum 0x138200e2, Offset: 0x5bc4
// Size: 0x20d
function train_hurt_damage_watcher( traincar, engine )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    damage = 1000;
    
    if ( getdvarfloat( @"hash_a214649db8d870f6", -1 ) != -1 )
    {
        damage = getdvarfloat( @"hash_a214649db8d870f6", -1 );
    }
    
    modifier = 1;
    
    if ( getdvarfloat( @"hash_baeaa14065be0bf2", -1 ) != -1 )
    {
        modifier = getdvarfloat( @"hash_baeaa14065be0bf2", -1 );
    }
    
    self.hurt_enabled = 1;
    self.iswztrain = 1;
    self.var_7c439348ae863f40 = &function_a1a7ab1416a69d1a;
    self.engine = engine;
    
    while ( true )
    {
        self waittill( #"trigger", hitent );
        
        if ( !self.hurt_enabled )
        {
            continue;
        }
        
        if ( ( isplayer( hitent ) || isagent( hitent ) ) && isalive( hitent ) && length( engine.velocity ) > 10 && vectordot( traincar.velocity, hitent.origin - traincar.origin ) > 0 && ( hitent.inlaststand || isagent( hitent ) || hitent istouching( traincar ) || hitent istouching( traincar.linked_model ) || traincar function_aeb68a47d7d76f5e( hitent ) ) )
        {
            damagemodifier = modifier;
            
            if ( isdefined( level.wztrain_info.var_af114a7afa087575 ) )
            {
                callbackmodifier = [[ level.wztrain_info.var_af114a7afa087575 ]]( traincar );
                damagemodifier *= callbackmodifier;
            }
            
            hitent dodamage( ( hitent.health + damage ) * damagemodifier, self.origin, self, self, "MOD_TRIGGER_HURT" );
        }
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xff2acb0f, Offset: 0x5dd9
// Size: 0x4f, Type: bool
function function_aeb68a47d7d76f5e( hitent )
{
    localorigin = coordtransformtranspose( hitent.origin, self.origin, self.angles );
    return localorigin[ 0 ] < 385 && abs( localorigin[ 1 ] ) < 95;
}

// Namespace br_movingtrain
// Params 2
// Checksum 0x99ef460, Offset: 0x5e31
// Size: 0xa9
function function_e2ce3bada3bdf46f( train_name, rate )
{
    animent = level.wztrain_info.animent[ train_name ];
    animtoplay = animent.anim_override;
    animref = level.scr_anim[ train_name ][ animtoplay ];
    
    if ( isarray( animref ) )
    {
        animref = level.scr_anim[ train_name ][ animtoplay ][ 0 ];
    }
    
    animent setanimrate( animref, rate );
    level.wztrain_info.animrate[ train_name ] = rate;
    on_state_changed( train_name );
}

// Namespace br_movingtrain
// Params 3
// Checksum 0xa3a7892d, Offset: 0x5ee2
// Size: 0xfa
function function_d4c2c525ba9de151( train_name, accelerationrate, targetrate )
{
    currentrate = level.wztrain_info.animrate[ train_name ];
    
    if ( !isdefined( currentrate ) )
    {
        return;
    }
    
    acceleration = 1;
    
    if ( targetrate < currentrate )
    {
        acceleration = -1;
    }
    
    animent = level.wztrain_info.animent[ train_name ];
    animtoplay = animent.anim_override;
    animref = level.scr_anim[ train_name ][ animtoplay ];
    
    if ( isarray( animref ) )
    {
        animref = level.scr_anim[ train_name ][ animtoplay ][ 0 ];
    }
    
    currentrate = br_moving_platforms_util::function_9d3219c7962d81ca( animent, animref, acceleration, accelerationrate, currentrate, targetrate );
    level.wztrain_info.animrate[ train_name ] = currentrate;
    on_state_changed( train_name );
    return currentrate;
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x4c0ff4c1, Offset: 0x5fe5
// Size: 0x6f
function function_846cc1006a2b6187( callback )
{
    if ( !isdefined( level.wztrain_info.state_change_callbacks ) )
    {
        level.wztrain_info.state_change_callbacks = [];
    }
    
    size = level.wztrain_info.state_change_callbacks.size;
    level.wztrain_info.state_change_callbacks[ size ] = callback;
}

// Namespace br_movingtrain
// Params 1, eflags: 0x4
// Checksum 0xacffdb4b, Offset: 0x605c
// Size: 0x2f6
function private on_state_changed( train_name )
{
    if ( !isdefined( level.wztrain_info.var_2796947cc924309a ) )
    {
        return;
    }
    
    controls = level.wztrain_info.var_2796947cc924309a[ train_name ];
    
    if ( !isdefined( controls ) )
    {
        return;
    }
    
    car_array = level.wztrain_info.trains[ train_name ];
    currentspeed = abs( level.wztrain_info.animrate[ train_name ] );
    is_moving = currentspeed > 0;
    speed_state = "stopped";
    
    if ( currentspeed > 0 )
    {
        speed_state = "moving";
    }
    
    if ( currentspeed > 0.5 )
    {
        speed_state = "fast";
    }
    
    foreach ( traincar in car_array )
    {
        if ( traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart( "train_speed_vfx" ) )
        {
            traincar.linked_model setscriptablepartstate( "train_speed_vfx", speed_state );
        }
    }
    
    i = 0;
    
    while ( i < car_array.size )
    {
        traincar = car_array[ i ];
        
        if ( traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart( "train_speed_vfx" ) )
        {
            traincar.linked_model setscriptablepartstate( "train_speed_vfx", speed_state );
        }
        
        i += 2;
    }
    
    if ( speed_state == "stopped" )
    {
        function_a7fe262888da18b5( train_name );
    }
    else
    {
        function_5e2f4b1676e23973( train_name );
    }
    
    last_traincar = car_array[ car_array.size - 1 ];
    
    if ( last_traincar.linked_model isscriptable() && last_traincar.linked_model getscriptablehaspart( "train_rear_sfx" ) )
    {
        last_traincar.linked_model setscriptablepartstate( "train_rear_sfx", is_moving ? "moving" : "default", 1 );
    }
    
    if ( isdefined( level.wztrain_info.state_change_callbacks ) )
    {
        foreach ( callback in level.wztrain_info.state_change_callbacks )
        {
            [[ callback ]]( train_name );
        }
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x2aac7b46, Offset: 0x635a
// Size: 0xde
function train_vfx_init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "wztrain_anim_playing" );
    wait 0.1;
    
    foreach ( traincar in level.wztrain_info.train_array )
    {
        if ( traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart( "train_part" ) )
        {
            traincar.linked_model setscriptablepartstate( "train_part", "moving" );
        }
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x7180f449, Offset: 0x6440
// Size: 0xd5
function train_sfx_init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "wztrain_anim_playing" );
    wait 0.1;
    
    foreach ( train_name in level.wztrain_info.train_names )
    {
        if ( !( isdefined( level.wztrain_info.var_2796947cc924309a ) && isdefined( level.wztrain_info.var_2796947cc924309a[ train_name ] ) ) )
        {
            function_5e2f4b1676e23973( train_name );
        }
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xda9d57b, Offset: 0x651d
// Size: 0x1a
function function_5e2f4b1676e23973( train_name )
{
    function_9afc36dd736cf33e( train_name, "train_moving" );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x62c7bd95, Offset: 0x653f
// Size: 0x1a
function function_a7fe262888da18b5( train_name )
{
    function_9afc36dd736cf33e( train_name, "train_stopped" );
}

// Namespace br_movingtrain
// Params 2
// Checksum 0x41998bc9, Offset: 0x6561
// Size: 0x16f
function function_9afc36dd736cf33e( train_name, loop_state )
{
    car_array = level.wztrain_info.trains[ train_name ];
    assert( isarray( car_array ), "<dev string:x39a>" );
    
    if ( !isarray( level.wztrain_info.var_b3b5e55db413dc62 ) )
    {
        level.wztrain_info.var_b3b5e55db413dc62 = [];
    }
    
    train_state = level.wztrain_info.var_b3b5e55db413dc62[ train_name ];
    
    if ( isstring( train_state ) && train_state == loop_state )
    {
        return;
    }
    else
    {
        level.wztrain_info.var_b3b5e55db413dc62[ train_name ] = loop_state;
    }
    
    foreach ( traincar in car_array )
    {
        if ( traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart( "train_control_loop_sfx" ) )
        {
            traincar.linked_model setscriptablepartstate( "train_control_loop_sfx", loop_state );
        }
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xe2760078, Offset: 0x66d8
// Size: 0x20
function function_4c0bdc113657087c()
{
    level endon( #"game_ended" );
    utility::flag_wait( "wztrain_array_set" );
    wait 0.1;
}

// Namespace br_movingtrain
// Params 2
// Checksum 0xe26a4bb4, Offset: 0x6700
// Size: 0xc9
function function_2d6d8d5fec04a0f4( train_ent1, train_ent2 )
{
    var_ea36ab1ee347f7f3 = getent( "br_passenger_train_prob_1", #script_noteworthy );
    var_ea36ac1ee347fa26 = getent( "br_passenger_train_prob_2", #script_noteworthy );
    
    if ( !( isdefined( var_ea36ab1ee347f7f3 ) && isdefined( var_ea36ac1ee347fa26 ) ) )
    {
        return;
    }
    
    var_ea36ab1ee347f7f3.origin = train_ent1.origin;
    var_ea36ab1ee347f7f3.angles = train_ent1.angles;
    var_ea36ab1ee347f7f3 linkto( train_ent1 );
    var_ea36ac1ee347fa26.origin = train_ent2.origin;
    var_ea36ac1ee347fa26.angles = train_ent2.angles;
    var_ea36ac1ee347fa26 linkto( train_ent2 );
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x3befb5c3, Offset: 0x67d1
// Size: 0x24
function train_horn()
{
    if ( vehicle::get_ref() == "br_passenger_train" )
    {
        function_7877589c275d9af9( self );
        return;
    }
    
    function_bf1d85d685c88631( self );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x2ab3443c, Offset: 0x67fd
// Size: 0x1d
function function_bf1d85d685c88631( train )
{
    function_ac8978ea16dce139( "cargo_train", "veh_jup_horn_cargotrain" );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x1cc61e52, Offset: 0x6822
// Size: 0x1d
function function_7877589c275d9af9( train )
{
    function_ac8978ea16dce139( "br_passenger_train", "veh_horn_passtrain" );
}

// Namespace br_movingtrain
// Params 3
// Checksum 0xe4273439, Offset: 0x6847
// Size: 0xed, Type: bool
function function_ac8978ea16dce139( train_name, sfx_name, var_9878a11f1685da97 )
{
    train_array = level.wztrain_info.trains[ train_name ];
    
    if ( !isdefined( train_array ) )
    {
        return false;
    }
    
    train_engine_ent = train_array[ 0 ].linked_model;
    
    if ( !soundexists( sfx_name ) )
    {
        return false;
    }
    
    if ( var_9878a11f1685da97 )
    {
        foreach ( traincar in train_array )
        {
            traincar playsoundonmovingent( sfx_name );
        }
    }
    else
    {
        train_engine_ent playsoundonmovingent( sfx_name );
    }
    
    return true;
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x157965b6, Offset: 0x693d
// Size: 0x10c
function br_pass_train_stop( train )
{
    train_engine_ent = level.wztrain_info.trains[ "br_passenger_train" ][ 0 ].linked_model;
    train_engine_ent playsoundonmovingent( "veh_passtrain_engine_stop" );
    var_a353675351515f4b = level.wztrain_info.trains[ "br_passenger_train" ][ 2 ].linked_model;
    var_a353675351515f4b playsoundonmovingent( "veh_passtrain_car1_stop" );
    var_5bb29ba9a7d7a4f9 = level.wztrain_info.trains[ "br_passenger_train" ][ 4 ].linked_model;
    var_5bb29ba9a7d7a4f9 playsoundonmovingent( "veh_passtrain_car2_stop" );
    var_a626a3750eb97d7f = level.wztrain_info.trains[ "br_passenger_train" ][ 6 ].linked_model;
    var_a626a3750eb97d7f playsoundonmovingent( "veh_passtrain_car1_stop" );
    wait 2;
    train_engine_ent playloopsound( "veh_passtrain_engine_idle_lp" );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x535adbf0, Offset: 0x6a51
// Size: 0x10c
function br_pass_train_start( train )
{
    train_engine_ent = level.wztrain_info.trains[ "br_passenger_train" ][ 0 ].linked_model;
    train_engine_ent playsoundonmovingent( "veh_passtrain_engine_start" );
    var_a353675351515f4b = level.wztrain_info.trains[ "br_passenger_train" ][ 2 ].linked_model;
    var_a353675351515f4b playsoundonmovingent( "veh_passtrain_car1_start" );
    var_5bb29ba9a7d7a4f9 = level.wztrain_info.trains[ "br_passenger_train" ][ 4 ].linked_model;
    var_5bb29ba9a7d7a4f9 playsoundonmovingent( "veh_passtrain_car2_start" );
    var_a626a3750eb97d7f = level.wztrain_info.trains[ "br_passenger_train" ][ 6 ].linked_model;
    var_a626a3750eb97d7f playsoundonmovingent( "veh_passtrain_car1_start" );
    wait 2;
    train_engine_ent stoploopsound( "veh_passtrain_engine_idle_lp" );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x6b4074e9, Offset: 0x6b65
// Size: 0x50
function br_pass_train_tnnl( train )
{
    soundent = spawn( "script_origin", ( -4669, 21728, 78 ) );
    soundent playsound( "veh_train_pass_overhead" );
    utility::exploder( "tunnel_train" );
    wait 31;
    soundent delete();
}

// Namespace br_movingtrain
// Params 2
// Checksum 0x1964b868, Offset: 0x6bbd
// Size: 0xa8f
function train_play_anim( train, array )
{
    level endon( #"game_ended" );
    introdelay = getdvarint( @"hash_6b1f502cc55903cc", 0 );
    
    if ( introdelay > 0 )
    {
        wait introdelay;
    }
    
    level.wztrain_info.minrate[ train ] = 0.25;
    level.wztrain_info.maxrate[ train ] = train == "br_passenger_train" ? 0.35 : 0.9;
    accelerationtime = getdvarfloat( @"hash_940d6b55a5dbcf45", 5 );
    level.wztrain_info.slowingdistance[ train ] = squared( getdvarfloat( @"hash_74b035e736b98642", 4000 ) );
    level.wztrain_info.var_2bf49ff2ba9bea28[ train ] = squared( getdvarfloat( @"hash_b2d8f4192a5928ea", 1800 ) );
    level.wztrain_info.var_11f157a670bf477d[ train ] = getdvarint( @"hash_bc045e3528c0633c", 0 ) == 1;
    level.wztrain_info.var_3342ddad0052859c[ train ] = getdvarint( @"hash_c568eb67d6719627", 400 );
    level.wztrain_info.var_dc7920ac270fae7e[ train ] = getdvarint( @"hash_b62ccc875be02bb7", 60 );
    var_af854b6386df30cc = train != "br_passenger_train";
    var_af854b6386df30cc = getdvarint( @"hash_4ec068e522fadc85", var_af854b6386df30cc );
    level.wztrain_info.minrate[ train ] = getdvarfloat( @"hash_2763c64cc1b357f5", level.wztrain_info.minrate[ train ] );
    level.wztrain_info.maxrate[ train ] = getdvarfloat( @"hash_12140bfeb0a869f3", level.wztrain_info.maxrate[ train ] );
    level.wztrain_info.minrate[ train ] = getdvarfloat( hashcat( @"scr_", train, "_minRate" ), level.wztrain_info.minrate[ train ] );
    level.wztrain_info.maxrate[ train ] = getdvarfloat( hashcat( @"scr_", train, "_maxRate" ), level.wztrain_info.maxrate[ train ] );
    accelerationrate = ( level.wztrain_info.maxrate[ train ] - level.wztrain_info.minrate[ train ] ) / accelerationtime;
    targetrate = level.wztrain_info.maxrate[ train ];
    animent = level.wztrain_info.animent[ train ];
    animstruct = level.wztrain_info.animstruct[ train ];
    
    if ( isdefined( level.wztrain_info.var_e393de966420fb1e ) )
    {
        [[ level.wztrain_info.var_e393de966420fb1e ]]( train );
    }
    
    animent.isplayinganim = 1;
    animent notsolid();
    animent dontinterpolate();
    
    if ( br_circle::function_cd50329a10799649() && train == "cargo_train" )
    {
        animent.backwards = 1;
    }
    
    animtoplay = animent.anim_override;
    
    if ( isdefined( level.wztrain_info.train_play_anim_callback ) )
    {
        level thread [[ level.wztrain_info.train_play_anim_callback ]]( train );
    }
    else
    {
        animstruct thread animation::anim_loop_solo( animent, animtoplay );
    }
    
    if ( isdefined( level.wztrain_info.var_d3425f85b3a640c3 ) )
    {
        [[ level.wztrain_info.var_d3425f85b3a640c3 ]]( train, targetrate );
    }
    
    function_fac91c4df3c88eaf( train, animstruct.initialtime );
    
    /#
        level thread function_6d2f620e7b592737( train );
    #/
    
    if ( br_circle::function_cd50329a10799649() && level.var_4391838d26dd3baf && train == "cargo_train" )
    {
        function_e2ce3bada3bdf46f( train, 0 );
    }
    else
    {
        function_e2ce3bada3bdf46f( train, targetrate );
    }
    
    acceleration = 1;
    dist = undefined;
    closest_stop = undefined;
    level.wztrain_info.train_stops[ train ] = [];
    level.wztrain_info.next_stops[ train ] = [];
    
    if ( isdefined( level.wztrain_info.set_train_stops_callback ) )
    {
        [[ level.wztrain_info.set_train_stops_callback ]]( train );
    }
    else if ( game_utility::function_87c1e942653b7c63() || game_utility::function_1ab42ace647394d7() || level.mapname == "mp_br_mechanics" || level.mapname == "mp_saba_st_dev" )
    {
        level.wztrain_info.train_stops[ train ][ "al_mazrah_city_station" ] = ( 14270, 17197, 560.113 );
        level.wztrain_info.train_stops[ train ][ "ahkdar_station" ] = ( 11421, -30213, 1032 );
        level.wztrain_info.train_stops[ train ][ "hafid_port" ] = ( -40724, -19572.6, 254.025 );
        
        if ( train == "cargo_train" )
        {
            level.wztrain_info.train_stops[ train ][ "oilfield" ] = ( -26700, 25058, -254.101 );
            level.wztrain_info.next_stops[ train ][ "al_mazrah_city_station" ] = "ahkdar_station";
            level.wztrain_info.next_stops[ train ][ "ahkdar_station" ] = "hafid_port";
            level.wztrain_info.next_stops[ train ][ "hafid_port" ] = "oilfield";
            level.wztrain_info.next_stops[ train ][ "oilfield" ] = "al_mazrah_city_station";
        }
        else
        {
            level.wztrain_info.next_stops[ train ][ "al_mazrah_city_station" ] = "hafid_port";
            level.wztrain_info.next_stops[ train ][ "hafid_port" ] = "ahkdar_station";
            level.wztrain_info.next_stops[ train ][ "ahkdar_station" ] = "al_mazrah_city_station";
        }
    }
    
    [ dist, closest_stop ] = function_e576220f7ee24e0c( animent.origin, level.wztrain_info.train_stops[ train ] );
    
    if ( isdefined( closest_stop ) )
    {
        foreach ( traincar in array )
        {
            if ( traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart( "nearby_station" ) )
            {
                traincar.linked_model setscriptablepartstate( "nearby_station", closest_stop );
            }
        }
    }
    
    utility::flag_set( "wztrain_anim_playing" );
    nextrepulsor = gettime();
    navrepulsorradius = 1400;
    repulsornames = [];
    navrepulsortargets = [ array index_clamped( 1 ), array index_clamped( -3 ) ];
    
    if ( isdefined( level.wztrain_info.var_10c7afb60e0bc975 ) )
    {
        [ navrepulsorradius, navrepulsortargets ] = [[ level.wztrain_info.var_10c7afb60e0bc975 ]]( array );
    }
    
    repulsorenabled = getdvarint( @"hash_ae01247934d8648a", 1 );
    
    if ( getdvarint( @"hash_f524d127e4ba82c4", 0 ) == 0 )
    {
        while ( true )
        {
            if ( repulsorenabled && gettime() > nextrepulsor )
            {
                nextrepulsor = gettime() + 2000;
                
                foreach ( repulsorname in repulsornames )
                {
                    destroynavrepulsor( repulsorname );
                }
                
                repulsornames = [];
                
                foreach ( traincar in navrepulsortargets )
                {
                    createnavrepulsor( traincar.unique_id + "train_badplace", -1, traincar.origin, navrepulsorradius, 1 );
                    repulsornames[ repulsornames.size ] = traincar.unique_id + "train_badplace";
                }
            }
            
            if ( level.wztrain_info.force_stop[ train ] )
            {
                targetrate = 0;
                acceleration = 0;
                function_d4c2c525ba9de151( train, accelerationrate, targetrate );
            }
            else if ( isdefined( level.wztrain_info.train_stops[ train ] ) && level.wztrain_info.train_stops[ train ].size > 0 && var_af854b6386df30cc )
            {
                [ dist, targetrate, acceleration ] = function_d54f9f76ba533f0e( dist, targetrate, acceleration, train );
                
                if ( !arraycontains( level.wztrain_info.var_69a237e15ef60fd8, train ) && var_af854b6386df30cc )
                {
                    function_d4c2c525ba9de151( train, accelerationrate, targetrate );
                }
            }
            
            function_93cb14f85c62ea18( train, 0.1 );
            waitframe();
            waittillframeend();
        }
    }
}

// Namespace br_movingtrain
// Params 2
// Checksum 0x298167c, Offset: 0x7654
// Size: 0x1fb
function function_93cb14f85c62ea18( train, lerpfraction )
{
    if ( getdvarint( @"hash_f524d127e4ba82c4", 0 ) )
    {
        return;
    }
    
    animent = level.wztrain_info.animent[ train ];
    trainarray = level.wztrain_info.trains[ train ];
    
    for ( i = 0; i < trainarray.size ; i++ )
    {
        thistag = level.wztrain_info.train_tag_array[ i ];
        targetorigin = animent gettagorigin( thistag );
        targetangles = animent gettagangles( thistag );
        
        if ( trainarray[ i ].invertrotation )
        {
            targetangles = function_8e1393116673ca77( targetangles );
        }
        
        tagoffset = level.wztrain_info.train_tagoffset_array[ i ];
        
        if ( tagoffset != ( 0, 0, 0 ) )
        {
            mtx = anglestoaxis( targetangles );
            targetorigin += mtx[ "forward" ] * tagoffset[ 0 ];
            targetorigin += mtx[ "right" ] * tagoffset[ 1 ];
            targetorigin += mtx[ "up" ] * tagoffset[ 2 ];
        }
        
        targetorigin = vectorlerp( trainarray[ i ].linked_mover.origin, targetorigin, lerpfraction );
        targetangles = anglelerpquatfrac( trainarray[ i ].linked_mover.angles, targetangles, lerpfraction );
        
        if ( isdefined( trainarray[ i ].linked_model.vehicletype ) )
        {
            trainarray[ i ].linked_model vehicle_teleport( targetorigin, targetangles, 1 );
        }
        
        trainarray[ i ].linked_mover.origin = targetorigin;
        trainarray[ i ].linked_mover.angles = targetangles;
    }
}

// Namespace br_movingtrain
// Params 4
// Checksum 0x64f8ba17, Offset: 0x7857
// Size: 0x3c6
function function_d54f9f76ba533f0e( dist, targetrate, acceleration, train )
{
    [ newdist, closest_stop ] = function_e576220f7ee24e0c( level.wztrain_info.animent[ train ].origin, level.wztrain_info.train_stops[ train ] );
    
    if ( isdefined( newdist ) )
    {
        approaching = newdist < dist;
        dist = newdist;
        
        if ( acceleration == 0 && targetrate == 0 )
        {
            var_dc7920ac270fae7e = level.wztrain_info.var_dc7920ac270fae7e[ train ] * 1000;
            shouldcontinue = gettime() >= level.wztrain_info.var_9bf8b25f9708aa08[ train ] + var_dc7920ac270fae7e;
            
            if ( shouldcontinue )
            {
                acceleration = -1;
                targetrate = level.wztrain_info.minrate[ train ];
                
                if ( isdefined( level.wztrain_info.var_4f3064d25f22496f ) )
                {
                    thread [[ level.wztrain_info.var_4f3064d25f22496f ]]( train );
                }
            }
        }
        else if ( approaching )
        {
            shouldbrake = acceleration == 1 && dist < level.wztrain_info.slowingdistance[ train ];
            shouldstop = level.wztrain_info.var_11f157a670bf477d[ train ] && acceleration == -1 && dist < level.wztrain_info.var_3342ddad0052859c[ train ];
            
            if ( shouldbrake )
            {
                acceleration = -1;
                targetrate = level.wztrain_info.minrate[ train ];
                
                if ( isdefined( level.wztrain_info.var_fba5f8798b15b02e ) )
                {
                    thread [[ level.wztrain_info.var_fba5f8798b15b02e ]]( train, closest_stop );
                }
            }
            else if ( shouldstop )
            {
                acceleration = 0;
                targetrate = 0;
                level.wztrain_info.var_9bf8b25f9708aa08[ train ] = gettime();
                
                if ( isdefined( level.wztrain_info.var_8c5c589d349670b9 ) )
                {
                    thread [[ level.wztrain_info.var_8c5c589d349670b9 ]]( train );
                }
            }
        }
        else if ( acceleration == -1 && dist > level.wztrain_info.var_2bf49ff2ba9bea28[ train ] )
        {
            acceleration = 1;
            targetrate = level.wztrain_info.maxrate[ train ];
            
            if ( isdefined( level.wztrain_info.var_9d69e80fc12c5735 ) )
            {
                thread [[ level.wztrain_info.var_9d69e80fc12c5735 ]]( train );
            }
            
            foreach ( traincar in level.wztrain_info.trains[ train ] )
            {
                if ( traincar.linked_model isscriptable() && traincar.linked_model getscriptablehaspart( "nearby_station" ) )
                {
                    traincar.linked_model setscriptablepartstate( "nearby_station", level.wztrain_info.next_stops[ train ][ closest_stop ] );
                }
            }
        }
    }
    
    return [ dist, targetrate, acceleration ];
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xffd60bae, Offset: 0x7c26
// Size: 0x19
function function_8e1393116673ca77( targetangles )
{
    return targetangles + ( -2 * targetangles[ 0 ], 180, 0 );
}

// Namespace br_movingtrain
// Params 2
// Checksum 0xdb5334cc, Offset: 0x7c48
// Size: 0x13d
function function_e576220f7ee24e0c( trainorigin, trainstops )
{
    mindist = undefined;
    closestname = undefined;
    dangercircleorigin = undefined;
    dangercircleradius = undefined;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
    {
        dangercircleorigin = br_circle::getdangercircleorigin();
        dangercircleradius = br_circle::getdangercircleradius();
    }
    
    foreach ( var_4e5896e861bbb797, var_cfd3fc5a06ddece6 in trainstops )
    {
        if ( getdvarint( @"hash_e614a3b36e6d3fca", 0 ) > 0 )
        {
            if ( isdefined( dangercircleorigin ) && br_circle::function_6bf5d4e680297398( var_cfd3fc5a06ddece6, dangercircleorigin, dangercircleradius ) )
            {
                continue;
            }
        }
        
        dist = distance2dsquared( var_cfd3fc5a06ddece6, trainorigin );
        
        if ( !isdefined( mindist ) || dist < mindist )
        {
            mindist = dist;
            closestname = var_4e5896e861bbb797;
        }
    }
    
    return [ mindist, closestname ];
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x354336f2, Offset: 0x7d8e
// Size: 0x85
function private function_2ed492d3d0e9ef51()
{
    foreach ( traincar in level.wztrain_info.train_array )
    {
        traincar flags::assign_unique_id();
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xebbe0071, Offset: 0x7e1b
// Size: 0x6ae
function train_play_anim_init()
{
    level.scr_animtree[ "cargo_train" ] = #animtree;
    level.scr_animtree[ "br_passenger_train" ] = #animtree;
    
    if ( isdefined( level.wztrain_info.var_18e7fab01a0c6314 ) )
    {
        [[ level.wztrain_info.var_18e7fab01a0c6314 ]]();
    }
    else
    {
        level.scr_anim[ "cargo_train" ][ "full_anim_290" ][ 0 ] = %iw9_mp_train_saba_a_cw;
        level.scr_anim[ "br_passenger_train" ][ "full_anim_290" ][ 0 ] = %iw9_mp_train_saba_b_ccw;
        animation::addnotetrack_customfunction( "cargo_train", "br_train_horn", &function_bf1d85d685c88631 );
        animation::addnotetrack_customfunction( "br_passenger_train", "br_pass_train_horn", &function_7877589c275d9af9 );
        animation::addnotetrack_customfunction( "br_passenger_train", "br_pass_train_start", &br_pass_train_start );
        animation::addnotetrack_customfunction( "br_passenger_train", "br_pass_train_stop", &br_pass_train_stop );
        animation::addnotetrack_customfunction( "br_passenger_train", "br_pass_train_tnnl", &br_pass_train_tnnl );
    }
    
    level.wztrain_info.train_tag_array = [];
    
    if ( isdefined( level.wztrain_info.var_3b1e2cf7c964f91d ) )
    {
        level.wztrain_info.train_tag_array = [[ level.wztrain_info.var_3b1e2cf7c964f91d ]]();
    }
    else
    {
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "engine_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train1_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train2_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train3_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train4_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train5_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train6_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train7_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train8_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train9_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train10_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train11_tag_origin_animate";
        level.wztrain_info.train_tag_array[ level.wztrain_info.train_tag_array.size ] = "saba01_train12_tag_origin_animate";
    }
    
    level.wztrain_info.train_tagoffset_array = [];
    
    for ( i = 0; i < level.wztrain_info.train_tag_array.size ; i++ )
    {
        level.wztrain_info.train_tagoffset_array[ i ] = ( 0, 0, 0 );
    }
    
    waitframe();
    spawnposition = ( 0, 0, 13 );
    spawnangles = ( 0, 0, 0 );
    
    if ( isdefined( level.wztrain_info.anim_spawnposition_override ) )
    {
        spawnposition = level.wztrain_info.anim_spawnposition_override;
    }
    
    level.wztrain_info.animstruct = [];
    level.wztrain_info.animent = [];
    level.wztrain_info.animrate = [];
    
    foreach ( train, array in level.wztrain_info.trains )
    {
        animstruct = spawnstruct();
        level.wztrain_info.animstruct[ train ] = animstruct;
        animstruct.origin = spawnposition;
        animstruct.angles = spawnangles;
        animstruct.initialtime = function_3df8f2f0fe17d941( train );
        animent = spawn( "script_model", animstruct.origin );
        level.wztrain_info.animent[ train ] = animent;
        modelname = "veh9_civ_lnd_train_assembly";
        
        if ( isdefined( level.wztrain_info.var_6048c54a82cb67bc ) )
        {
            modelname = [[ level.wztrain_info.var_6048c54a82cb67bc ]]();
        }
        
        animent setmodel( modelname );
        assert( animent.model != "<dev string:x153>", "<dev string:x3ca>" + modelname + "<dev string:x3ed>" );
        animent hide();
        animent.angles = animstruct.angles;
        animent.animname = train;
        animent useanimtree( level.scr_animtree[ train ] );
        animent forcenetfieldhighlod( 1 );
        animent setmoveroptimized( 1 );
        animent setmoverantilagged( 1 );
        animent function_2735e38f58370a0f( 1 );
        animent.anim_override = level.wztrain_info.assembly_anim_override ?? "full_anim_290";
    }
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x351ff769, Offset: 0x84d1
// Size: 0xa6
function function_3df8f2f0fe17d941( train )
{
    presettime = getdvar( hashcat( @"scr_", train, "_initial_anim_time" ), "" );
    pickrandom = getdvarint( hashcat( @"scr_", train, "_randomize_anim_time" ), 1 );
    chosenoffset = 0;
    
    if ( pickrandom )
    {
        chosenoffset = randomfloat( 1 );
    }
    else if ( presettime != "" )
    {
        chosenoffset = clamp( float( presettime ), 0, 1 );
    }
    
    logstring( "[br_movingtrain] Will spawn '" + train + "' with initial anim time = " + chosenoffset );
    return chosenoffset;
}

/#

    // Namespace br_movingtrain
    // Params 1
    // Checksum 0x2ea25f89, Offset: 0x8580
    // Size: 0x69, Type: dev
    function function_6d2f620e7b592737( train )
    {
        while ( true )
        {
            if ( getdvarint( @"hash_6b8bb4531a9ded3a", 0 ) )
            {
                initialtime = function_3df8f2f0fe17d941( train );
                function_fac91c4df3c88eaf( train, initialtime );
                level.wztrain_info.animstruct[ train ].initialtime = initialtime;
            }
            
            waitframe();
        }
    }

#/

// Namespace br_movingtrain
// Params 2
// Checksum 0x73e33bef, Offset: 0x85f1
// Size: 0x99
function function_fac91c4df3c88eaf( train, animtime )
{
    animent = level.wztrain_info.animent[ train ];
    
    if ( isdefined( animent ) )
    {
        animtoplay = animent.anim_override;
        animref = level.scr_anim[ train ][ animtoplay ];
        
        if ( isarray( animref ) )
        {
            animref = level.scr_anim[ train ][ animtoplay ][ 0 ];
        }
        
        animent setanimtime( animref, animtime );
        level thread train_teleport_to_animtime( train, animent );
    }
}

// Namespace br_movingtrain
// Params 2
// Checksum 0xf9be0166, Offset: 0x8692
// Size: 0x100
function train_teleport_to_animtime( train, animent )
{
    level endon( #"game_ended" );
    animent notify( #"train_teleport_to_animtime" );
    animent endon( #"train_teleport_to_animtime" );
    animent dontinterpolate();
    waitframe();
    function_93cb14f85c62ea18( train, 1 );
    
    foreach ( traincar in level.wztrain_info.trains[ train ] )
    {
        traincar dontinterpolate();
        
        if ( isdefined( traincar.linked_mover ) )
        {
            traincar.linked_mover dontinterpolate();
        }
    }
    
    waitframe();
    animent.animtimeset = 1;
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xc9153387, Offset: 0x879a
// Size: 0x91
function function_a1a7ab1416a69d1a( einflictor )
{
    self playsound( "train_veh_impact_body" );
    
    if ( isdefined( einflictor ) && isdefined( einflictor.engine ) )
    {
        if ( isdefined( einflictor.engine.script_noteworthy ) && einflictor.engine.script_noteworthy == "train_car_20" )
        {
            einflictor.engine playsoundonmovingent( "veh_horn_passtrain" );
            return;
        }
        
        einflictor.engine playsoundonmovingent( "veh_jup_horn_cargotrain" );
    }
}

// Namespace br_movingtrain
// Params 4
// Checksum 0xe9137ef0, Offset: 0x8833
// Size: 0x259
function predictcargotrainpositions( delays, animrates, accelerationrate, startrate = 0 )
{
    assert( utility::flag( "<dev string:x402>" ), "<dev string:x414>" );
    assert( accelerationrate > 0, "<dev string:x435>" );
    cargotrain = level.wztrain_info.animent[ "cargo_train" ];
    animtoplay = cargotrain.anim_override;
    animref = level.scr_anim[ "cargo_train" ][ animtoplay ];
    
    if ( isarray( animref ) )
    {
        animref = level.scr_anim[ "cargo_train" ][ animtoplay ][ 0 ];
    }
    
    animlength = getanimlength( animref );
    startref = level.wztrain_info.animstruct[ "cargo_train" ];
    
    if ( utility::flag( "wztrain_anim_playing" ) )
    {
        animoffset = cargotrain getanimtime( animref );
    }
    else
    {
        animoffset = level.wztrain_info.animstruct[ "cargo_train" ].initialtime;
    }
    
    prevanimrate = startrate;
    var_2d21534208b9420d = animoffset;
    trainpositions = [];
    
    for ( index = 0; index < delays.size ; index++ )
    {
        animrate = animrates[ index ];
        
        if ( isdefined( animrate ) )
        {
            accelerationtime = abs( animrate - prevanimrate ) / accelerationrate;
            
            if ( accelerationtime > delays[ index ] )
            {
                animrate = math::lerp( prevanimrate, animrate, delays[ index ] / accelerationtime );
                accelerationtime = delays[ index ];
                
                if ( !isdefined( animrates[ index + 1 ] ) )
                {
                    animrates[ index + 1 ] = animrates[ index ];
                }
            }
            
            transientanimtime = br_moving_platforms_util::function_5016fcb45ade7fe5( prevanimrate, animrate, accelerationtime );
            remainingdelay = delays[ index ] - accelerationtime;
            var_2d21534208b9420d += ( transientanimtime + animrate * remainingdelay ) / animlength;
            prevanimrate = animrate;
        }
        else
        {
            var_2d21534208b9420d += prevanimrate * delays[ index ] / animlength;
        }
        
        var_2d21534208b9420d -= floor( var_2d21534208b9420d );
        trainpositions[ index ] = getoriginforanimtime( startref.origin, startref.angles, animref, var_2d21534208b9420d );
    }
    
    return trainpositions;
}

// Namespace br_movingtrain
// Params 2
// Checksum 0x69acc5a5, Offset: 0x8a95
// Size: 0x89
function changecargotrainspeed( targetrate, accelerationrate )
{
    level endon( #"game_ended" );
    level notify( #"hash_c76048ad08e7de37" );
    level endon( #"hash_c76048ad08e7de37" );
    currentrate = level.wztrain_info.animrate[ "cargo_train" ];
    
    if ( currentrate == targetrate )
    {
        return;
    }
    
    while ( true )
    {
        currentrate = function_d4c2c525ba9de151( "cargo_train", accelerationrate, targetrate );
        
        if ( currentrate == targetrate )
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x3a85c1ba, Offset: 0x8b26
// Size: 0x44
function crate_follow_text()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        /#
            print3d( self.origin, "<dev string:x463>", ( 1, 0, 0 ), 1, 2, 99, 1 );
        #/
        
        wait 1;
    }
}

// Namespace br_movingtrain
// Params 2
// Checksum 0xd827e2be, Offset: 0x8b72
// Size: 0xa0, Type: bool
function any_player_nearby( origin, dist_sqr )
{
    foreach ( player in level.players )
    {
        if ( distancesquared( player.origin, origin ) < dist_sqr )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_movingtrain
// Params 0
// Checksum 0xb6391afa, Offset: 0x8c1b
// Size: 0xbf
function warp_player_debug()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_dd6e65ec80098e72", 0 ) == 0 )
    {
        return;
    }
    
    while ( !isalive( level.player ) )
    {
        wait 0.1;
    }
    
    level.player endon( #"death_or_disconnect" );
    wait 1;
    level thread debug_warpplayer_monitor();
    level.player waittill( #"skydive_deployparachute" );
    wait 0.5;
    start_pos = level.wztrain_info.train_array[ 0 ].origin;
    level.player setorigin( start_pos + ( 0, 0, 4096 ) );
}

// Namespace br_movingtrain
// Params 0
// Checksum 0x4a023b54, Offset: 0x8ce2
// Size: 0x109
function debug_warpplayer_monitor()
{
    level endon( #"game_ended" );
    level.player endon( #"disconnect" );
    level.player notifyonplayercommand( "dpad_left_press", "+actionslot 3" );
    
    while ( true )
    {
        level.player waittill( #"dpad_left_press" );
        start_pos = level.wztrain_info.train_array[ 1 ].origin;
        
        foreach ( player in level.players )
        {
            player setorigin( start_pos + ( 0, 0, 200 ) );
        }
        
        waitframe();
    }
}

/#

    // Namespace br_movingtrain
    // Params 2
    // Checksum 0xc5ecb738, Offset: 0x8df3
    // Size: 0x59, Type: dev
    function debug_display_veh_hit( eventdata, damage )
    {
        if ( vectordot( eventdata.velnormals[ 0 ], eventdata.velnormals[ 1 ] ) > 0 )
        {
            announcement( "<dev string:x465>" + damage );
            return;
        }
        
        announcement( "<dev string:x475>" + damage );
    }

#/

// Namespace br_movingtrain
// Params 0
// Checksum 0x7bc437c6, Offset: 0x8e54
// Size: 0x126
function blink_train_test()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 1;
        
        foreach ( traincar in level.wztrain_info.train_array )
        {
            traincar.linked_model hide();
        }
        
        wait 1;
        
        foreach ( traincar in level.wztrain_info.train_array )
        {
            traincar.linked_model show();
        }
    }
}

// Namespace br_movingtrain
// Params 2, eflags: 0x4
// Checksum 0x5bb5d8a9, Offset: 0x8f82
// Size: 0x170
function private function_d8992b8e8f399aef( offset, traincar )
{
    if ( !level.var_550fa2ad98f3b1f )
    {
        scriptable::scriptable_addusedcallbackbypart( "train_safe", &function_b64bb003b8330715 );
    }
    
    level.var_550fa2ad98f3b1f = 1;
    offset += ( 0, 0, 43 );
    safe = spawn( "script_model", traincar.linked_model.origin + offset );
    safe setmodel( "dmz_train_safe" );
    safe.angles = ( 0, 0, 0 );
    safe linkto( traincar.linked_model );
    safe.linkedparent = traincar.linked_model;
    safe.musicplayers = [];
    scriptable = safe getlinkedscriptableinstance();
    scriptable.linkedparent = traincar.linked_model;
    scriptable.onclosedcallback = &function_9cb5799511a36d6a;
    safe setscriptablepartstate( "train_safe", "usable_not_open" );
    
    if ( dmz_weapon_case::function_e1e53cf44ecd226() == "train" )
    {
        safe game_utility::questcircle_create( "Boss_Focus_SM_Dmz", self.origin, 3000 );
        safe game_utility::questcircle_showtoall();
        safe.mapcircle linkto( safe );
        safe thread function_d9e196a9e998e70();
    }
    
    return safe;
}

// Namespace br_movingtrain
// Params 2, eflags: 0x4
// Checksum 0x22a46f8b, Offset: 0x90fb
// Size: 0x34
function private function_9cb5799511a36d6a( container, player )
{
    if ( !( isdefined( container ) && isdefined( player ) ) )
    {
        return;
    }
    
    container setscriptablepartstate( "train_safe", "open_usable" );
}

// Namespace br_movingtrain
// Params 6, eflags: 0x4
// Checksum 0xa4755c96, Offset: 0x9137
// Size: 0x1e2
function private function_b64bb003b8330715( instance, part, state, player, bautouse, usestring )
{
    if ( state == "usable_not_open" )
    {
        instance setscriptablepartstate( part, "unusable" );
        instance.successfuluse = 0;
        instance thread dmz_safes::function_d369e14e462e6113( player );
        instance.entity dmz_safes::function_f2cbcef06349c1f6( player, part );
        
        if ( instance.entity.successfuluse )
        {
            br_gametype_dmz::showdmzsplash( "dmz_train_safe_defend_started", level.players );
            safe_setmusicstate( instance.entity, "drill", player );
            wait 1;
            instance.entity thread safecapture();
        }
        else
        {
            instance setscriptablepartstate( part, "usable_not_open" );
        }
        
        return;
    }
    
    if ( state == "open_usable" )
    {
        if ( instance getscriptableparthasstate( part, "unusable" ) )
        {
            instance setscriptablepartstate( part, "unusable" );
        }
        
        if ( !isdefined( instance.contents ) )
        {
            var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "train_safe" );
            
            if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
            {
                common_cache::fillcontentsfromlist( instance, var_f67995529827f79.spawnlistname, var_f67995529827f79.spawncount );
            }
            
            instance.containertype = 4;
        }
        
        common_cache::function_60ce579fa7d3b6da( instance, part, state, player, bautouse, usestring );
        return;
    }
    
    if ( state == "usable_drilling" )
    {
        instance.entity.paused = 0;
        safe_setmusicstate( instance.entity, "drill", player );
        instance setscriptablepartstate( "train_safe", "unusable_drilling" );
    }
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x6629f4e8, Offset: 0x9321
// Size: 0x22
function private safecapture()
{
    thread watchnearby();
    thread watchprogress();
    thread callheli();
    
    if ( false )
    {
        thread function_99d1fb3d1de3b483();
    }
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x1bafe367, Offset: 0x934b
// Size: 0x670
function private watchnearby()
{
    self endon( #"captured" );
    self.curorigin = self.origin;
    self.offset3d = ( 0, 0, 70 );
    gameobjects::requestid( 1, 0, undefined, 1 );
    globalobjid = self.objidnum;
    self.globalobjid = globalobjid;
    objective_setpings( globalobjid, 1 );
    objective_setzoffset( globalobjid, 70 );
    objective_icon( globalobjid, "ui_map_icon_safe" );
    objective_setbackground( globalobjid, 1 );
    objective_state( globalobjid, "current" );
    objidpoolmanager::update_objective_onentity( globalobjid, self );
    objective_setownerteam( globalobjid, undefined );
    objective_setprogressteam( globalobjid, undefined );
    objidpoolmanager::update_objective_objectiveid( globalobjid, 16 );
    objidpoolmanager::objective_set_play_intro( globalobjid, 1 );
    objidpoolmanager::objective_playermask_showtoall( globalobjid );
    gameobjects::requestid( 1, 0, undefined, 1 );
    progressobjid = self.objidnum;
    self.progressobjid = progressobjid;
    objidpoolmanager::update_objective_icon( progressobjid, "ui_map_icon_safe" );
    objidpoolmanager::update_objective_setbackground( progressobjid, 1 );
    objidpoolmanager::objective_pin_global( progressobjid, 1 );
    objidpoolmanager::function_586b631e7bbb592a( progressobjid, 1 );
    objidpoolmanager::objective_set_play_intro( progressobjid, 0 );
    objidpoolmanager::objective_playermask_showtoall( progressobjid );
    objidpoolmanager::update_objective_onentity( progressobjid, self );
    objidpoolmanager::update_objective_setzoffset( progressobjid, 70 );
    objidpoolmanager::update_objective_state( progressobjid, "invisible" );
    objective_setshowprogress( progressobjid, 1 );
    self.nearbyplayers = [];
    self.abandoned = 0;
    var_e4e29ab14bb7d603 = gettime();
    lastpaused = 0;
    
    while ( true )
    {
        nearby = [];
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.origin ) && distancesquared( self.origin, player.origin ) < 640000 )
            {
                trainname = player train_utility::function_8f8b1d91271dffd8();
                
                if ( trainname == "cargo_train" )
                {
                    nearby[ nearby.size ] = player;
                }
            }
        }
        
        if ( nearby.size > 0 )
        {
            var_e4e29ab14bb7d603 = gettime();
        }
        
        newabandoned = gettime() - var_e4e29ab14bb7d603 > 20000;
        
        if ( self.abandoned && !newabandoned && self.var_73b6fcef3e9a2cfe && isdefined( self.heli ) )
        {
            self.heli notify( #"newpath" );
        }
        
        self.abandoned = newabandoned;
        newnearby = arrayremove( nearby, self.nearbyplayers );
        newaway = arrayremove( self.nearbyplayers, nearby );
        
        if ( self.paused != lastpaused )
        {
            foreach ( player in self.nearbyplayers )
            {
                if ( isdefined( player ) )
                {
                    objidpoolmanager::function_6ac40386d1cd0d9a( progressobjid, player );
                    objidpoolmanager::objective_playermask_hidefrom( progressobjid, player );
                }
            }
            
            self.nearbyplayers = [];
            lastpaused = istrue( self.paused );
            waitframe();
            continue;
        }
        
        lastpaused = istrue( self.paused );
        progressbar = lastpaused ? &"mp_dmz_missions/safe_paused" : &"mp_dmz_missions/opening_safe";
        
        foreach ( player in newnearby )
        {
            if ( isdefined( player ) )
            {
                objidpoolmanager::objective_playermask_addshowplayer( progressobjid, player );
                objidpoolmanager::function_72efeaceb614613a( progressobjid, player, 2, 2, progressbar );
            }
        }
        
        foreach ( player in newaway )
        {
            if ( isdefined( player ) )
            {
                objidpoolmanager::function_6ac40386d1cd0d9a( progressobjid, player );
                objidpoolmanager::objective_playermask_hidefrom( progressobjid, player );
            }
        }
        
        self.nearbyplayers = nearby;
        teamcounts = [];
        
        foreach ( player in nearby )
        {
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( !isdefined( teamcounts[ player.team ] ) )
            {
                teamcounts[ player.team ] = 0;
            }
            
            teamcounts[ player.team ] += 1;
        }
        
        max = 0;
        captureteam = "team_hundred_ninety_four";
        
        foreach ( team, count in teamcounts )
        {
            if ( count > max )
            {
                captureteam = team;
                max = count;
                continue;
            }
            
            if ( count == max )
            {
                captureteam = "team_hundred_ninety_four";
            }
        }
        
        objective_setownerteam( progressobjid, captureteam );
        objective_setprogressteam( progressobjid, captureteam );
        objective_setownerteam( globalobjid, captureteam );
        objective_setprogressteam( globalobjid, captureteam );
        objective_setpulsate( globalobjid, 1 );
        wait 1;
    }
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0xc15f020d, Offset: 0x99c3
// Size: 0x2f
function private function_d9e196a9e998e70()
{
    level waittill( #"hash_620582a5ac25efa9" );
    self.objidnum = self.globalobjid;
    gameobjects::releaseid();
    game_utility::questcircle_delete();
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x13f605e4, Offset: 0x99fa
// Size: 0x1ae
function private watchprogress()
{
    objid = self.progressobjid;
    self.progress = 0;
    capturetime = getdvarint( @"scr_dmz_train_safe_capture_time", 180 );
    
    while ( self.progress < 1 )
    {
        if ( self.nearbyplayers.size > 0 && !self.paused )
        {
            newprogress = clamp( self.progress + level.framedurationseconds / capturetime, 0, 1 );
            
            if ( newprogress > 0.33 && self.progress < 0.33 || newprogress > 0.67 && self.progress < 0.67 )
            {
                self.paused = 1;
                br_gametype_dmz::showdmzsplash( "dmz_train_safe_paused", self.nearbyplayers );
                self setscriptablepartstate( "train_safe", "usable_drilling" );
            }
            
            self.progress = newprogress;
            objidpoolmanager::objective_set_progress( objid, self.progress );
        }
        else if ( !self.paused )
        {
            min = 0;
            
            if ( self.progress > 0.67 )
            {
                min = 0.671;
            }
            else if ( self.progress > 0.33 )
            {
                min = 0.331;
            }
            
            self.progress = clamp( self.progress - level.framedurationseconds / 3 * 60, min, 1 );
            objidpoolmanager::objective_set_progress( objid, self.progress );
        }
        
        waitframe();
    }
    
    opensafe();
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0xdf088de8, Offset: 0x9bb0
// Size: 0x1da
function private callheli()
{
    self endon( #"captured" );
    spawndata = spawnstruct();
    spawndata.origin = gethelispawn();
    spawndata.initai = 1;
    spawndata.team = "team_hundred_ninety_four";
    heli = vehicle::spawn( "little_bird", spawndata );
    self.heli = heli;
    heli.var_937263baf40c151 = 1;
    vehicle_interact::allow_use( heli, 0 );
    poi = poi::poi_findpoioriginisin( self.origin );
    origin = level.var_cbe4d28d28ae892a ?? spawndata.origin;
    riders = [];
    
    for ( i = 2; i < 8 ; i++ )
    {
        aitype = ai_mp_controller::function_b86341658788836c( undefined, poi, undefined, utility::array_random( [ "sniper", "ar", "lmg" ] ), 3 );
        rider = ai_mp_controller::ai_mp_requestspawnagent( aitype, origin, ( 0, 0, 0 ), "absolute", "reinforcements", "train_safe", undefined, undefined, undefined, "bossArea", 1, undefined, 0 );
        
        if ( !isdefined( rider ) )
        {
            continue;
        }
        
        riders[ i ] = rider;
        rider thread function_1fc8c5f2e7156576( heli );
        br_dmz_radiation::function_8976f4d93db5c4a9( rider );
    }
    
    utility::callsharedfunc( #"heli", #"hash_3f200eefc8f48152", heli );
    heli vehicle_ai::load( riders, 1, 1 );
    thread heliai( heli );
    heli waittill( #"death" );
    wait 10;
    
    while ( self.abandoned )
    {
        wait 3;
    }
    
    callheli();
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x728bae10, Offset: 0x9d92
// Size: 0x10d
function private function_99d1fb3d1de3b483()
{
    while ( true )
    {
        foreach ( offset in [ ( 1500, 600, 600 ), ( 2400, -430, 450 ), ( 2400, 430, 450 ), ( 1200, -600, 500 ), ( 500, 0, 400 ) ] )
        {
            /#
                sphere( self.linkedparent.origin + rotatevector( offset, self.linkedparent.angles ), 200, ( 0, 0, 1 ), 0 );
            #/
        }
        
        waitframe();
    }
}

// Namespace br_movingtrain
// Params 1, eflags: 0x4
// Checksum 0x38132589, Offset: 0x9ea7
// Size: 0x64
function private function_1fc8c5f2e7156576( heli )
{
    heli endon( #"death" );
    self waittill( #"death", killer, meansofdeath );
    heli dodamage( int( heli.maxhealth / 7 ), killer.origin, killer, killer, meansofdeath );
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x7863c32e, Offset: 0x9f13
// Size: 0x3a
function private gethelispawn()
{
    return self.linkedparent.origin + rotatevector( ( -1000, 0, 5000 ), self.linkedparent.angles );
}

// Namespace br_movingtrain
// Params 1, eflags: 0x4
// Checksum 0x8cfc2d4e, Offset: 0x9f56
// Size: 0x146
function private function_4e6b97c627d771ad( heli )
{
    goal = utility::array_random( [ ( 1500, 600, 600 ), ( 2400, -430, 450 ), ( 2400, 430, 450 ), ( 1200, -600, 500 ), ( 500, 0, 400 ) ] );
    goalstruct = spawnstruct();
    goalstruct.origin = self.linkedparent.origin + rotatevector( goal, self.linkedparent.angles );
    goalstruct.speed = 60;
    goalstruct.radius = 150;
    trace = trace::sphere_trace( heli.origin, goalstruct.origin, 200, undefined, trace::create_contents( 0, 1, 1, 1, 0, 0 ) );
    
    if ( trace[ "fraction" ] < 1 )
    {
        goalstruct.origin += ( 0, 0, 1500 );
    }
    
    return goalstruct;
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0xbd33971d, Offset: 0xa0a5
// Size: 0x74
function private function_ea4ad97ad0e88438()
{
    goalstruct = spawnstruct();
    goalstruct.origin = self.linkedparent.origin + rotatevector( ( -1000, 0, 7000 ), self.linkedparent.angles );
    goalstruct.speed = 60;
    goalstruct.radius = 200;
    return goalstruct;
}

// Namespace br_movingtrain
// Params 1, eflags: 0x4
// Checksum 0x9d291ec1, Offset: 0xa122
// Size: 0x96
function private heliai( heli )
{
    heli endon( #"death" );
    
    while ( true )
    {
        self.var_73b6fcef3e9a2cfe = 0;
        
        if ( self.captured || self.abandoned )
        {
            self.var_73b6fcef3e9a2cfe = 1;
            heli vehicle_paths::vehicle_paths_helicopter( function_ea4ad97ad0e88438() );
            
            if ( self.captured || self.abandoned )
            {
                heli thread vehicle::death( heli );
                return;
            }
            
            continue;
        }
        
        heli vehicle_paths::vehicle_paths_helicopter( function_4e6b97c627d771ad( heli ) );
    }
}

// Namespace br_movingtrain
// Params 0, eflags: 0x4
// Checksum 0x3550e2f3, Offset: 0xa1c0
// Size: 0x261
function private opensafe()
{
    self notify( #"captured" );
    self.captured = 1;
    uniqueteams = [];
    
    foreach ( player in self.nearbyplayers )
    {
        objidpoolmanager::objective_unpin_player( self.progressobjid, player );
        objidpoolmanager::function_6ac40386d1cd0d9a( self.progressobjid, player );
        objidpoolmanager::objective_playermask_hidefrom( self.progressobjid, player );
        objidpoolmanager::objective_playermask_addshowplayer( self.globalobjid, player );
        
        if ( !isdefined( player.var_24ec7841475d2d88 ) )
        {
            player.var_24ec7841475d2d88 = 0;
        }
        
        player.var_24ec7841475d2d88++;
        player points::doscoreevent( #"dmz_safe_opened" );
        
        if ( isdefined( player ) && isdefined( player.team ) && !isdefined( uniqueteams[ player.team ] ) )
        {
            uniqueteams[ player.team ] = 1;
        }
    }
    
    foreach ( team, value in uniqueteams )
    {
        callback::callback( "team_engaged_activity", { #iscompletion:1, #activityref:"train_safe", #team:team } );
    }
    
    br_gametype_dmz::showdmzsplash( "dmz_train_safe_defend_unlocked", self.nearbyplayers );
    safe_setmusicstate( self, "open", self.nearbyplayers );
    self.objidnum = self.progressobjid;
    gameobjects::releaseid();
    
    if ( dmz_weapon_case::function_e1e53cf44ecd226() != "train" )
    {
        self.objidnum = self.globalobjid;
        gameobjects::releaseid();
    }
    
    self setscriptablepartstate( "train_safe", "opening" );
}

// Namespace br_movingtrain
// Params 1
// Checksum 0x91f4f48d, Offset: 0xa429
// Size: 0xa4
function function_6d888d3095af7b06( array )
{
    newarray = [];
    
    foreach ( member in array )
    {
        is_really_alive = player::isreallyalive( member );
        
        if ( !is_really_alive )
        {
            continue;
        }
        
        newarray[ newarray.size ] = member;
    }
    
    return newarray;
}

// Namespace br_movingtrain
// Params 1
// Checksum 0xb34999db, Offset: 0xa4d6
// Size: 0x1df
function function_ce896463798ef0f8( radius )
{
    safe = self;
    assert( isent( safe ) && isarray( safe.musicplayers ), "<dev string:x484>" );
    assert( isnumber( radius ), "<dev string:x4ac>" );
    level endon( #"game_ended" );
    safe endon( #"captured" );
    safe notify( #"hash_6b6b7fa959294c12" );
    safe endon( #"hash_6b6b7fa959294c12" );
    
    while ( self.captured == 0 )
    {
        var_df1880678f3fff95 = audio_utility::function_82af6589c060fd56( safe.origin, radius );
        var_9d4ed9f2ed55be77 = arrayremove( safe.musicplayers, var_df1880678f3fff95 );
        var_2f7bbfcaa352de2c = function_6d888d3095af7b06( var_df1880678f3fff95 );
        var_945bf9e97482537d = arrayremove( var_df1880678f3fff95, var_2f7bbfcaa352de2c );
        var_cc3a10790a1935eb = arraycombine( var_9d4ed9f2ed55be77, var_945bf9e97482537d );
        
        if ( isarray( var_cc3a10790a1935eb ) && var_cc3a10790a1935eb.size > 0 )
        {
            dmz_audio::function_1219191cbcd38758( var_cc3a10790a1935eb, "", 0.5 );
            
            foreach ( player in var_cc3a10790a1935eb )
            {
                playerentnum = player getentitynumber();
                safe.musicplayers[ playerentnum ] = undefined;
            }
        }
        
        waitcount = randomintrange( 2, 20 );
        waittime = waitcount * 0.05;
        safe utility::waittill_any_timeout( waittime, "captured" );
    }
}

// Namespace br_movingtrain
// Params 3
// Checksum 0xbd7cfb81, Offset: 0xa6bd
// Size: 0x2f6
function safe_setmusicstate( safe, statename, var_ac2a3fd2b834e3ac )
{
    assert( isent( safe ) && isarray( safe.musicplayers ), "<dev string:x4d6>" );
    assert( isstring( statename ), "<dev string:x4fa>" );
    isaplayer = isplayer( var_ac2a3fd2b834e3ac );
    isplayers = isarray( var_ac2a3fd2b834e3ac );
    musicdist = getdvarint( @"hash_1dcf60c7d07dee2e", 4725 );
    
    switch ( statename )
    {
        default:
            assertmsg( "<dev string:x523>" );
            break;
        case #"hash_ce4d7f20e14acf7e":
            if ( isaplayer )
            {
                player = var_ac2a3fd2b834e3ac;
                teamplayers = audio_utility::function_82af6589c060fd56( player, musicdist, var_ac2a3fd2b834e3ac.team );
                
                if ( isarray( teamplayers ) && teamplayers.size > 0 )
                {
                    dmz_audio::function_1219191cbcd38758( teamplayers, "dmz_train_safe_drill", 0.5 );
                    
                    foreach ( player in teamplayers )
                    {
                        playerentnum = player getentitynumber();
                        safe.musicplayers[ playerentnum ] = player;
                    }
                }
            }
            
            break;
        case #"hash_af80d61e7df698bb":
            if ( isaplayer )
            {
                player = var_ac2a3fd2b834e3ac;
                dmz_audio::function_1219191cbcd38758( [ player ], "", 0.5 );
                playerentnum = player getentitynumber();
                safe.musicplayers[ playerentnum ] = undefined;
            }
            else if ( isplayers && isarray( var_ac2a3fd2b834e3ac ) && var_ac2a3fd2b834e3ac.size > 0 )
            {
                players = var_ac2a3fd2b834e3ac;
                dmz_audio::function_1219191cbcd38758( players, "", 0.5 );
                
                foreach ( player in players )
                {
                    playerentnum = player getentitynumber();
                    safe.musicplayers[ playerentnum ] = undefined;
                }
            }
            
            break;
        case #"hash_d747fa3ff1b78b29":
            if ( isarray( safe.musicplayers ) && safe.musicplayers.size > 0 )
            {
                dmz_audio::function_1219191cbcd38758( safe.musicplayers, "", 1.5 );
                safe.musicplayers = [];
            }
            
            break;
    }
    
    safe thread function_ce896463798ef0f8( musicdist );
}

// Namespace br_movingtrain
// Params 6
// Checksum 0x669546f0, Offset: 0xa9bb
// Size: 0x141
function function_915a6827d0fa3a1d( instance, part, state, player, bautouse, usestring )
{
    if ( instance.onmovingtrain )
    {
        if ( isdefined( instance.type ) )
        {
            switch ( instance.type )
            {
                case #"hash_19ba8d41970911ad":
                case #"hash_417c605750c7baa5":
                case #"hash_4ca1dc2e1b0de0d3":
                    player train_analytics( 0, 0, 0, 0, 1 );
                    break;
                case #"hash_2e2fee3e581b3db3":
                    player train_analytics( 0, 0, 0, 0, 0, 0, 0, 1 );
                    break;
                case #"hash_9f164ed5d992e2e0":
                    player train_analytics( 0, 0, 0, 0, 0, 0, 1 );
                    break;
                case #"hash_26596eb3f3b3a613":
                case #"hash_b81a435643d5475e":
                    player train_analytics( 0, 0, 0, 0, 0, 1 );
                    break;
                default:
                    break;
            }
            
            return;
        }
        
        if ( part == "brloot_gascan_palfa" )
        {
            player train_analytics( 0, 0, 0, 0, 0, 0, 0, 0, 0, "", 1 );
        }
    }
}

// Namespace br_movingtrain
// Params 3
// Checksum 0x416d70f5, Offset: 0xab04
// Size: 0x177
function function_5768093be7b2afa5( player, attacker, smeansofdeath )
{
    groundent = player getgroundentity();
    
    if ( !( isdefined( groundent ) && isdefined( level.wztrain_info.trains ) ) )
    {
        return;
    }
    
    foreach ( train in level.wztrain_info.trains )
    {
        if ( isdefined( train ) )
        {
            foreach ( traincar in train )
            {
                if ( isdefined( traincar ) )
                {
                    if ( groundent == traincar )
                    {
                        death_by_player = isplayer( attacker ) && attacker != player ? 1 : 0;
                        player train_analytics( 0, 0, 0, 0, 0, 0, 0, 0, death_by_player, smeansofdeath );
                        return;
                    }
                }
            }
        }
    }
}

// Namespace br_movingtrain
// Params 12
// Checksum 0xd12eeca7, Offset: 0xac83
// Size: 0x278
function train_analytics( direction_control_used = 0, speed_control_used = 0, horn_control_used = 0, handbrake_control_used = 0, loot_cache_used = 0, uav_tower_used = 0, buy_station_used = 0, ammo_depot_used = 0, death_by_player = 0, death_other = "", palfa_fuel_used = 0, reset_control_timer = 0 )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "direction_control_used";
    eventparams[ eventparams.size ] = direction_control_used;
    eventparams[ eventparams.size ] = "speed_control_used";
    eventparams[ eventparams.size ] = speed_control_used;
    eventparams[ eventparams.size ] = "horn_control_used";
    eventparams[ eventparams.size ] = horn_control_used;
    eventparams[ eventparams.size ] = "handbrake_control_used";
    eventparams[ eventparams.size ] = handbrake_control_used;
    eventparams[ eventparams.size ] = "loot_cache_used";
    eventparams[ eventparams.size ] = loot_cache_used;
    eventparams[ eventparams.size ] = "uav_tower_used";
    eventparams[ eventparams.size ] = uav_tower_used;
    eventparams[ eventparams.size ] = "buy_station_used";
    eventparams[ eventparams.size ] = buy_station_used;
    eventparams[ eventparams.size ] = "ammo_depot_used";
    eventparams[ eventparams.size ] = ammo_depot_used;
    eventparams[ eventparams.size ] = "death_by_player";
    eventparams[ eventparams.size ] = death_by_player;
    eventparams[ eventparams.size ] = "death_other";
    eventparams[ eventparams.size ] = death_other;
    eventparams[ eventparams.size ] = "palfa_fuel_used";
    eventparams[ eventparams.size ] = palfa_fuel_used;
    eventparams[ eventparams.size ] = "team_name";
    team_name = isdefined( self ) && isdefined( self.team ) ? self.team : "";
    eventparams[ eventparams.size ] = team_name;
    eventparams[ eventparams.size ] = "circle_index";
    current_circle_index = isdefined( level.br_circle ) ? level.br_circle.circleindex + 1 : -1;
    eventparams[ eventparams.size ] = current_circle_index;
    playlistid = getplaylistid();
    eventparams[ eventparams.size ] = "playlist_name";
    playlist_name = getplaylistname( playlistid );
    eventparams[ eventparams.size ] = playlist_name;
    eventparams[ eventparams.size ] = "control_timer_reset";
    eventparams[ eventparams.size ] = reset_control_timer;
    self dlog_recordplayerevent( "dlog_event_br_moving_train", eventparams );
}

// Namespace br_movingtrain
// Params 2, eflags: 0x4
// Checksum 0x83124662, Offset: 0xaf03
// Size: 0x318
function private handledevcommand_br( command, args )
{
    firstplayer = level.players[ 0 ];
    
    if ( !isdefined( firstplayer ) )
    {
        return;
    }
    
    switch ( command )
    {
        case #"hash_2899e5a679a1e049":
            if ( !isdefined( args[ 0 ] ) )
            {
                break;
            }
            
            switch ( args[ 0 ] )
            {
                case #"hash_8d85f40f19fbd646":
                    train_entities = level.wztrain_info.trains[ "cargo_train" ];
                    
                    if ( !isdefined( train_entities ) )
                    {
                        announcement( "Train: " + "cargo_train" + " does not exist." );
                        break;
                    }
                    
                    traincar_index = 0;
                    
                    if ( isdefined( args[ 1 ] ) )
                    {
                        traincar_index = int( args[ 1 ] );
                    }
                    
                    firstplayer setorigin( train_entities[ traincar_index ].origin + ( 0, 0, 200 ) );
                    break;
                case #"hash_9ccea7ed14568475":
                    foreach ( traincar in level.wztrain_info.train_array )
                    {
                        hasparts = 0;
                        
                        if ( traincar.linked_model isscriptable() )
                        {
                            hasparts += traincar.linked_model getscriptablehaspart( "train_speed_sfx" );
                            hasparts += traincar.linked_model getscriptablehaspart( "train_speed_vfx" );
                            hasparts += traincar.linked_model getscriptablehaspart( "train_control_sfx" );
                            hasparts += traincar.linked_model getscriptablehaspart( "train_brakes_vfx" );
                        }
                        
                        color = [ ( 1, 0, 0 ), ( 1, 1, 0 ), ( 1, 1, 0 ), ( 1, 1, 0 ), ( 0, 1, 0 ) ][ hasparts ];
                        utility::draw_capsule( traincar.origin, 100, 200, ( 0, 0, 0 ), color, 0, 200 );
                    }
                    
                    break;
                case #"hash_a94f895bbd927e65":
                    if ( !isdefined( args[ 1 ] ) )
                    {
                        break;
                    }
                    
                    collider = spawn( "script_model", firstplayer.origin );
                    collider setmodel( args[ 1 ] );
                    r = 100;
                    utility::draw_capsule( collider.origin + ( 0, 0, r * -1 ), r, r * 2, ( 0, 0, 0 ), ( 1, 0, 0 ), 0, 20000 );
                    break;
            }
            
            break;
    }
}

// Namespace br_movingtrain
// Params 1, eflags: 0x4
// Checksum 0x261537b5, Offset: 0xb223
// Size: 0x4a
function private index_clamped( index )
{
    if ( self.size == 0 )
    {
        return;
    }
    
    if ( index < 0 )
    {
        return self[ int( clamp( self.size + index, 0, self.size - 1 ) ) ];
    }
    
    return self[ int( clamp( index, 0, self.size - 1 ) ) ];
}

