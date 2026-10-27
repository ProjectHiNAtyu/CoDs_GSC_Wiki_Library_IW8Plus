// scripts\common\create_script_utility.gsc  (hash_75152f52d4583a69.gscc) (size: 24675 Bytes / 0x6063 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x630e2b86 (1661873030)
// size ...... 24675 (0x6063)
// includes .. 1   (offset: 0x5b17)
// strings ... 76  (offset: 0x5b1f)
// dev strs .. 6   (offset: 0x601b)
// exports ... 51  (offset: 0x48a7)
// cseg ...... 0x6f2 + 0x41b5 (0x48a7)
// imports ... 73  (offset: 0x509f)
// animtree1 . 0   (offset: 0x6063)
// animtree2 . 0   (offset: 0x6063)
#using scripts\common\utility;

#namespace create_script_utility;

// Namespace create_script_utility
// Params 0, eflags: 0x1
// Checksum 0xf0489104, Offset: 0x710
// Size: 0x10
function autoexec initialize_create_script()
{
    init_create_script_debug();
    init_create_script_for_level();
}

// Namespace create_script_utility
// Params 0
// Checksum 0x462665ee, Offset: 0x728
// Size: 0x37
function init_create_script_debug()
{
    level.create_script_debug = 0;
    
    if ( getdvarint( @"scr_create_script_debug", 0 ) != 0 )
    {
        level.create_script_debug = 1;
        return;
    }
    
    level.create_script_debug = 0;
}

// Namespace create_script_utility
// Params 1
// Checksum 0xd995a148, Offset: 0x767
// Size: 0xd1
function init_create_script_for_level( bshouldthread )
{
    if ( isdefined( level.scripted_spawner_func ) )
    {
        return;
    }
    
    if ( !function_cdd699ffd1993a2f() )
    {
        return;
    }
    
    utility::flag_set( "create_script" );
    level.create_script = 1;
    level.threadedscriptspawners = istrue( bshouldthread );
    level.create_script_file_ids = [];
    level.cs_scripts = [];
    level.cs_scripted_spawners = [];
    level.scripted_spawners = [];
    level.cs_scripted_spawners_triggers = [];
    level.scripted_spawners_triggers = [];
    level.cs_scripted_spawners_models = [];
    level.scripted_spawners_models = [];
    level.createscriptfilesinitialized = 0;
    level.scripted_spawner_func_strings = [];
    level.scripted_spawner_map_strings = [];
    level.scripted_spawner_func = [];
    level.var_851d5cbe5ebb59b4 = 0;
    function_fdf5e6fc1c4d66d9();
}

// Namespace create_script_utility
// Params 0, eflags: 0x4
// Checksum 0xa6418409, Offset: 0x840
// Size: 0x79
function private function_fdf5e6fc1c4d66d9()
{
    if ( !level.gametypebundle.var_64a927fcee6fe0f3 )
    {
        return;
    }
    
    level.var_6db29ff4582b386c = [];
    level.var_6db29ff4582b386c[ "File" ] = &filter_file;
    level.var_6db29ff4582b386c[ "Substring" ] = &filter_substring;
    level.gametypebundle.var_f4f859c46a772638 = getscriptbundle( level.gametypebundle.var_64a927fcee6fe0f3 );
}

// Namespace create_script_utility
// Params 0
// Checksum 0x2e0f8e02, Offset: 0x8c1
// Size: 0x91
function initialize_registered_create_script_files()
{
    if ( isdefined( level.scripted_spawner_func ) )
    {
        level.cs_creation_counter = 0;
        
        if ( isarray( level.scripted_spawner_func ) )
        {
            for ( i = 0; i < level.scripted_spawner_func.size ; i++ )
            {
                [[ level.scripted_spawner_func[ i ] ]]( 1, "cs" + i );
            }
            
            return;
        }
        
        if ( level.threadedscriptspawners )
        {
            [[ level.scripted_spawner_func ]]( 1 );
            return;
        }
        
        [[ level.scripted_spawner_func ]]();
    }
}

// Namespace create_script_utility
// Params 0
// Checksum 0x714d09b, Offset: 0x95a
// Size: 0xd
function minimize_variables()
{
    level.var_7a33533bd2502a7e = 1;
}

// Namespace create_script_utility
// Params 4
// Checksum 0x22d21e54, Offset: 0x96f
// Size: 0x99
function register_create_script_arrays( script, map, index, func )
{
    if ( isdefined( func ) )
    {
        level.scripted_spawner_func[ level.scripted_spawner_func.size ] = func;
    }
    
    if ( isdefined( script ) )
    {
        level.scripted_spawner_func_strings[ level.scripted_spawner_func_strings.size ] = script;
        
        if ( isdefined( index ) )
        {
            level.create_script_file_ids[ script ] = "cs" + index;
        }
    }
    
    if ( isdefined( map ) )
    {
        level.scripted_spawner_map_strings[ level.scripted_spawner_func_strings.size ] = map;
    }
}

// Namespace create_script_utility
// Params 1
// Checksum 0x2b85259, Offset: 0xa10
// Size: 0x4c
function initialize_create_script_file( file_name )
{
    if ( utility::flag_exist( file_name ) )
    {
        utility::flag_set( file_name );
        
        if ( utility::flag_exist( file_name + "_completed" ) )
        {
            level endon( #"game_ended" );
            utility::flag_wait( file_name + "_completed" );
        }
    }
}

// Namespace create_script_utility
// Params 1
// Checksum 0xacf01ec2, Offset: 0xa64
// Size: 0x39
function register_valid_gametypes_for_create_script( allowed_gametype )
{
    if ( !isdefined( level.allowed_gametypes ) )
    {
        level.allowed_gametypes = [];
    }
    
    level.allowed_gametypes[ level.allowed_gametypes.size ] = allowed_gametype;
}

// Namespace create_script_utility
// Params 1
// Checksum 0xd9a3480b, Offset: 0xaa5
// Size: 0x39
function register_valid_objectives_for_create_script( allowed_objective )
{
    if ( !isdefined( level.allowed_objectives ) )
    {
        level.allowed_objectives = [];
    }
    
    level.allowed_objectives[ level.allowed_objectives.size ] = allowed_objective;
}

// Namespace create_script_utility
// Params 2
// Checksum 0x236b8c80, Offset: 0xae6
// Size: 0x1ef
function strike_setup_arrays( index, cs_file )
{
    if ( !isdefined( level.scripted_spawners ) )
    {
        level.scripted_spawners = [];
    }
    
    if ( !isdefined( level.scripted_spawners_triggers ) )
    {
        level.scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.scripted_spawners_models ) )
    {
        level.scripted_spawners_models = [];
    }
    
    if ( !isdefined( level.cs_origin_offset ) )
    {
        level.cs_origin_offset = [];
    }
    
    if ( !isdefined( level.cs_angle_offset ) )
    {
        level.cs_angle_offset = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners ) )
    {
        level.cs_scripted_spawners = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_triggers ) )
    {
        level.cs_scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_models ) )
    {
        level.cs_scripted_spawners_models = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners[ index ] ) )
    {
        level.scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_triggers[ index ] ) )
    {
        level.scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_models[ index ] ) )
    {
        level.scripted_spawners_models[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners[ index ] ) )
    {
        level.cs_scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_triggers[ index ] ) )
    {
        level.cs_scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_models[ index ] ) )
    {
        level.cs_scripted_spawners_models[ index ] = [];
    }
    
    if ( utility::issharedfuncdefined( #"create_script", #"cleanupfuncinit" ) )
    {
        funcname = utility::getsharedfunc( #"create_script", #"cleanupfuncinit" );
        [[ funcname ]]( cs_file, self );
    }
}

// Namespace create_script_utility
// Params 2
// Checksum 0x32a34469, Offset: 0xcdd
// Size: 0x1ef
function cs_setup_arrays( index, cs_file )
{
    if ( !isdefined( level.scripted_spawners ) )
    {
        level.scripted_spawners = [];
    }
    
    if ( !isdefined( level.scripted_spawners_triggers ) )
    {
        level.scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.scripted_spawners_models ) )
    {
        level.scripted_spawners_models = [];
    }
    
    if ( !isdefined( level.cs_origin_offset ) )
    {
        level.cs_origin_offset = [];
    }
    
    if ( !isdefined( level.cs_angle_offset ) )
    {
        level.cs_angle_offset = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners ) )
    {
        level.cs_scripted_spawners = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_triggers ) )
    {
        level.cs_scripted_spawners_triggers = [];
    }
    
    if ( !isdefined( level.cs_scripted_spawners_models ) )
    {
        level.cs_scripted_spawners_models = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners[ index ] ) )
    {
        level.scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_triggers[ index ] ) )
    {
        level.scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.scripted_spawners_models[ index ] ) )
    {
        level.scripted_spawners_models[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners[ index ] ) )
    {
        level.cs_scripted_spawners[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_triggers[ index ] ) )
    {
        level.cs_scripted_spawners_triggers[ index ] = [];
    }
    
    if ( isdefined( index ) && !isdefined( level.cs_scripted_spawners_models[ index ] ) )
    {
        level.cs_scripted_spawners_models[ index ] = [];
    }
    
    if ( utility::issharedfuncdefined( #"create_script", #"cleanupfuncinit" ) )
    {
        funcname = utility::getsharedfunc( #"create_script", #"cleanupfuncinit" );
        [[ funcname ]]( cs_file, self );
    }
}

// Namespace create_script_utility
// Params 16
// Checksum 0xfee571d1, Offset: 0xed4
// Size: 0x7e6
function strike_additem( struct, index, cs_file, origin, angles, targetname, target, script_noteworthy, script_linkto, script_linkname, struct_origin_offset, struct_angle_offset, radius, speed, spawnflags, script_unload )
{
    level endon( #"game_ended" );
    
    if ( level.create_script_debug )
    {
        logstring( "[ CS | Debug ] " + "create_script_utility::strike_additem" + ": " + "Adding item with targetname \"" + targetname + "\"" );
    }
    
    if ( utility::issharedfuncdefined( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580" ) )
    {
        should_skip = 0;
        
        if ( isdefined( struct.arena_instance ) )
        {
            if ( utility::issharedfuncdefined( #"actionpark", "get_arena_instance" ) )
            {
                current_arena = [[ utility::getsharedfunc( #"actionpark", "get_arena_instance" ) ]]();
                
                if ( isdefined( current_arena ) && struct.arena_instance != current_arena )
                {
                    should_skip = 1;
                    
                    if ( level.create_script_debug )
                    {
                        logstring( "[ CS | Debug ] " + "create_script_utility::strike_additem" + ": " + "Early arena filter - skipping " + struct + " (arena_instance " + struct.arena_instance + " != " + current_arena + ")" );
                    }
                }
            }
        }
        
        if ( !should_skip && isdefined( struct.instance_id ) && utility::issharedfuncdefined( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580" ) )
        {
            var_8bd4e6130da271c5 = hashcat( #"multi_arena_map_", struct.instance_id );
            var_aa5ff8b29b1a8b36 = utility::callsharedfunc( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580" );
            
            if ( var_8bd4e6130da271c5 != var_aa5ff8b29b1a8b36 )
            {
                should_skip = 1;
                
                if ( level.create_script_debug )
                {
                    logstring( "[ CS | Debug ] " + "create_script_utility::strike_additem" + ": " + "Early arena filter - skipping " + struct + " (instance_id " + struct.instance_id + " != " + var_aa5ff8b29b1a8b36 + ")" );
                }
            }
        }
        
        if ( should_skip )
        {
            return;
        }
    }
    
    if ( !struct object_is_valid() )
    {
        if ( level.create_script_debug )
        {
            logstring( "[ CS | Debug ] " + "create_script_utility::strike_additem" + ": " + "Object invalid, earlying out" );
        }
        
        return;
    }
    
    if ( isdefined( level.cs_creation_counter ) && ( !cs_is_starttime() || level.var_e6abfcb8a3f54d9f ) )
    {
        level.cs_creation_counter++;
        
        if ( level.cs_creation_counter % 25 == 0 )
        {
            waitframe();
        }
    }
    
    if ( level.var_7a33533bd2502a7e )
    {
        if ( angles && angles != ( 0, 0, 0 ) )
        {
            struct.angles = angles;
        }
    }
    else
    {
        struct.angles = angles ?? ( 0, 0, 0 );
    }
    
    if ( !isdefined( struct.origin ) )
    {
        struct.origin = origin;
    }
    
    if ( !isdefined( struct.targetname ) )
    {
        struct.targetname = targetname;
    }
    
    if ( !isdefined( struct.target ) )
    {
        struct.target = target;
    }
    
    if ( !isdefined( struct.script_noteworthy ) )
    {
        struct.script_noteworthy = script_noteworthy;
    }
    
    if ( !isdefined( struct.script_linkto ) )
    {
        struct.script_linkto = script_linkto;
    }
    
    if ( !isdefined( struct.script_linkname ) )
    {
        struct.script_linkname = script_linkname;
    }
    
    if ( !isdefined( struct.speed ) )
    {
        struct.speed = speed;
    }
    
    if ( !isdefined( struct.radius ) )
    {
        struct.radius = radius;
    }
    
    struct.spawnflags = spawnflags ? int( spawnflags ) : undefined;
    
    if ( !isdefined( struct.script_unload ) )
    {
        struct.script_unload = script_unload;
    }
    
    if ( isdefined( struct.script_scenescriptbundle ) )
    {
        level.var_18c87c2c4c3b0a2d = arraycombineunique( level.var_18c87c2c4c3b0a2d, [ struct.script_scenescriptbundle ] );
        level.a_scene_structs = arraycombineunique( level.a_scene_structs, [ struct ] );
    }
    
    translate_position_with_offset_data( cs_file, struct, struct_origin_offset, struct_angle_offset );
    
    if ( !isdefined( index ) )
    {
        index = "_";
    }
    
    strike_fixautokvps( struct, index );
    typecast_kvps( struct );
    correct_kvps( struct );
    utility::callsharedfunc( #"create_script", #"kvp_filter", struct );
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = struct;
    }
    
    if ( isdefined( struct.model ) )
    {
        if ( struct.is_cs_model )
        {
            struct.is_cs_model = undefined;
        }
        
        strike_modelcreate( struct, index );
        utility::addstruct( struct );
        utility::callsharedfunc( #"create_script", #"ai_interactions", struct );
        utility::callsharedfunc( #"create_script", #"delete_bsp_dupes", struct );
        
        if ( level.create_script_debug )
        {
            logstring( "[ CS | Debug ] " + "create_script_utility::strike_additem" + ": " + "Item with \"" + targetname + "\" added successfully" );
        }
        
        return;
    }
    
    if ( isdefined( struct.is_cs_script_origin ) )
    {
        struct.is_cs_script_origin = struct.is_cs_script_origin == "1" ? 1 : 0;
    }
    
    if ( struct.is_cs_trigger )
    {
        trigger = strike_triggercreate( struct, index, 1, struct.is_cs_noent_volume );
        utility::addstruct( trigger );
        struct.is_cs_trigger = undefined;
        struct.is_cs_noent_volume = undefined;
    }
    else if ( struct.is_cs_model )
    {
        strike_modelcreate( struct, index );
        utility::addstruct( struct );
        struct.is_cs_model = undefined;
    }
    else if ( struct.is_cs_script_origin )
    {
        struct.is_cs_script_origin = undefined;
        strike_scriptorigincreate( struct, index );
    }
    else if ( isdefined( struct.targetname ) )
    {
        switch ( struct.targetname )
        {
            case #"hash_c54a2fb47decfc4b":
                strike_triggercreate( struct, index );
                break;
            case #"hash_39242cd548aa8ad2":
                strike_triggercreate( struct, index );
                break;
            case #"hash_9c00e8ccfe6f652f":
                strike_triggercreate( struct, index, 1 );
                break;
            case #"hash_e0468027719a9048":
                strike_triggercreate( struct, index, 1 );
                break;
            case #"hash_d9876aa54e2a4d2b":
                strike_interactioncreate( struct, index );
                break;
            case #"hash_1ca1f994ed1249f5":
                strike_triggercreate( struct, index, 1 );
                break;
            default:
                utility::addstruct( struct );
                break;
        }
    }
    else
    {
        utility::addstruct( struct );
    }
    
    if ( level.create_script_debug )
    {
        logstring( "[ CS | Debug ] " + "create_script_utility::strike_additem" + ": " + "Item with targetname \"" + targetname + "\" added successfully" );
    }
    
    utility::callsharedfunc( #"create_script", #"ai_interactions", struct );
    utility::callsharedfunc( #"create_script", #"delete_bsp_dupes", struct );
}

// Namespace create_script_utility
// Params 0
// Checksum 0xcd52ec3, Offset: 0x16c2
// Size: 0x279, Type: bool
function object_is_valid()
{
    if ( isdefined( self.gametype ) && self.gametype != level.gametypebundle.namekey )
    {
        if ( level.create_script_debug )
        {
            logstring( "[ CS | Debug ] " + "create_script_utility::object_is_valid" + ": " + "Object invalid, intended for gametype \"" + self.gametype + "\"" );
        }
        
        return false;
    }
    
    gametype_allowed = 0;
    objective_allowed = 0;
    instance_allowed = 1;
    
    if ( isdefined( level.allowed_gametypes ) )
    {
        if ( isdefined( self.script_gameobjectname ) )
        {
            for ( i = 0; i < level.allowed_gametypes.size ; i++ )
            {
                if ( getsubstr( level.allowed_gametypes[ i ], 0, 1 ) == "!" )
                {
                    invertlogic = 1;
                }
                else
                {
                    invertlogic = 0;
                }
                
                if ( is_object_allowed_in_gametype( self.script_gameobjectname, level.allowed_gametypes[ i ] ) != invertlogic )
                {
                    gametype_allowed = 1;
                    break;
                }
            }
        }
        else
        {
            gametype_allowed = 1;
        }
    }
    else
    {
        gametype_allowed = 1;
    }
    
    if ( isdefined( level.allowed_objectives ) )
    {
        if ( isdefined( self.script_gameobjectname ) )
        {
            for ( i = 0; i < level.allowed_objectives.size ; i++ )
            {
                if ( getsubstr( level.allowed_objectives[ i ], 0, 1 ) == "!" )
                {
                    invertlogic = 1;
                }
                else
                {
                    invertlogic = 0;
                }
                
                if ( is_object_allowed_in_gametype( self.script_gameobjectname, level.allowed_objectives[ i ] ) != invertlogic )
                {
                    objective_allowed = 1;
                    break;
                }
            }
        }
        else
        {
            objective_allowed = 1;
        }
    }
    else
    {
        objective_allowed = 1;
    }
    
    if ( isdefined( self.instance_id ) && utility::issharedfuncdefined( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580" ) )
    {
        var_8bd4e6130da271c5 = hashcat( #"multi_arena_map_", self.instance_id );
        instance_allowed = var_8bd4e6130da271c5 == utility::callsharedfunc( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580" );
    }
    
    if ( level.create_script_debug )
    {
        logstring( "[ CS | Debug ] " + "create_script_utility::object_is_valid" + ": " + "\"gametype_allowed\": " + int( gametype_allowed ) + ", \"objective_allowed\": " + int( objective_allowed ) + ", \"instance_allowed\": " + int( instance_allowed ) );
    }
    
    return gametype_allowed && objective_allowed && instance_allowed;
}

// Namespace create_script_utility
// Params 2
// Checksum 0xf9d589e1, Offset: 0x1944
// Size: 0x45
function is_object_allowed_in_gametype( stringlist, gametype )
{
    if ( !isdefined( stringlist ) || stringlist == "" || !isdefined( gametype ) || gametype == "" )
    {
        return 0;
    }
    
    return issubstr( stringlist, gametype );
}

// Namespace create_script_utility
// Params 4
// Checksum 0xb504bc30, Offset: 0x1992
// Size: 0xf9
function translate_position_with_offset_data( cs_file, struct, prefab_origin_offset, prefab_angles_offset )
{
    translate_and_rotate_from_level_overrides( cs_file, struct );
    
    if ( isdefined( prefab_origin_offset ) )
    {
        if ( !isdefined( prefab_angles_offset ) )
        {
            prefab_angles_offset = ( 0, 0, 0 );
        }
        
        obj_angles = ( 0, 0, 0 );
        
        if ( isdefined( struct.angles ) )
        {
            obj_angles = struct.angles;
        }
        
        obj_origin = struct.origin;
        struct.origin = prefab_origin_offset + rotatevector( obj_origin, prefab_angles_offset );
        
        if ( isdefined( struct.script_origin_other ) )
        {
            struct.script_origin_other = prefab_origin_offset + rotatevector( struct.script_origin_other, prefab_angles_offset );
        }
        
        new_obj_angles = combineangles( prefab_angles_offset, obj_angles );
        struct.angles = new_obj_angles;
    }
}

// Namespace create_script_utility
// Params 2
// Checksum 0x9735dae9, Offset: 0x1a93
// Size: 0x112
function translate_and_rotate_from_level_overrides( cs_file, struct )
{
    if ( isdefined( cs_file ) && isdefined( level.cs_origin_offset ) && isdefined( level.cs_angle_offset[ cs_file ] ) )
    {
        prefab_angles_offset = level.cs_angle_offset[ cs_file ];
        prefab_origin_offset = level.cs_origin_offset[ cs_file ];
        obj_angles = ( 0, 0, 0 );
        
        if ( isdefined( struct.angles ) )
        {
            obj_angles = struct.angles;
        }
        
        obj_origin = struct.origin;
        struct.origin = prefab_origin_offset + rotatevector( obj_origin, prefab_angles_offset );
        
        if ( isdefined( struct.script_origin_other ) )
        {
            struct.script_origin_other = prefab_origin_offset + rotatevector( struct.script_origin_other, prefab_angles_offset );
        }
        
        new_obj_angles = combineangles( prefab_angles_offset, obj_angles );
        struct.angles = new_obj_angles;
    }
}

// Namespace create_script_utility
// Params 3
// Checksum 0x7a92b32c, Offset: 0x1bad
// Size: 0x12a
function strike_add_to_cs_arrays( cs_type, struct, index )
{
    if ( !getdvarint( @"scr_enable_create_script", 0 ) )
    {
        return;
    }
    
    if ( cs_type == "struct" )
    {
        level.scripted_spawners[ index ][ level.scripted_spawners[ index ].size ] = struct;
    }
    else if ( cs_type == "trigger" )
    {
        level.scripted_spawners_triggers[ index ][ level.scripted_spawners_triggers[ index ].size ] = struct;
    }
    else if ( cs_type == "model" )
    {
        level.scripted_spawners_models[ index ][ level.scripted_spawners_models[ index ].size ] = struct;
    }
    
    /#
        if ( cs_type == "<dev string:x24>" )
        {
            level.cs_scripted_spawners[ index ][ level.cs_scripted_spawners[ index ].size ] = struct;
            return;
        }
        
        if ( cs_type == "<dev string:x2b>" )
        {
            level.cs_scripted_spawners_triggers[ index ][ level.cs_scripted_spawners_triggers[ index ].size ] = struct;
            return;
        }
        
        if ( cs_type == "<dev string:x33>" )
        {
            level.cs_scripted_spawners_models[ index ][ level.cs_scripted_spawners_models[ index ].size ] = struct;
        }
    #/
}

// Namespace create_script_utility
// Params 2
// Checksum 0x6e0f6a0e, Offset: 0x1cdf
// Size: 0x1e
function strike_interactioncreate( struct, index )
{
    utility::addstruct( struct );
}

// Namespace create_script_utility
// Params 2
// Checksum 0x64783551, Offset: 0x1d05
// Size: 0x19a
function strike_scriptorigincreate( struct, index )
{
    model = spawn( "script_origin", struct.origin );
    model.targetname = "strike_scriptOriginCreate";
    
    if ( !isdefined( struct.angles ) )
    {
        model.angles = ( 0, 0, 0 );
    }
    else
    {
        model.angles = struct.angles;
    }
    
    if ( isdefined( struct.model ) )
    {
        model setmodel( struct.model );
    }
    
    if ( isdefined( struct.targetname ) )
    {
        model.targetname = struct.targetname;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        model.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        model.script_linkto = struct.script_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        model.script_linkname = struct.script_linkname;
    }
    
    if ( isdefined( struct.target ) )
    {
        model.target = struct.target;
    }
    
    model.struct = struct;
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = model;
    }
}

// Namespace create_script_utility
// Params 2
// Checksum 0x7e0dffae, Offset: 0x1ea7
// Size: 0x20a
function strike_modelcreate( struct, index )
{
    strike_add_to_cs_arrays( "model", struct, index );
    
    if ( !isdefined( struct.angles ) )
    {
        struct.angles = ( 0, 0, 0 );
    }
    
    model_string = isdefined( struct.var_a56fc80ec1e8e888 ) ? struct.var_a56fc80ec1e8e888 + "::" + struct.model : struct.model;
    model = spawn( "script_model", struct.origin );
    model.angles = struct.angles;
    model setmodel( model_string );
    
    if ( isdefined( struct.targetname ) )
    {
        model.targetname = struct.targetname;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        model.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        model.script_linkto = struct.script_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        model.script_linkname = struct.script_linkname;
    }
    
    if ( isdefined( struct.target ) )
    {
        model.target = struct.target;
    }
    
    if ( isdefined( struct.name ) )
    {
        model.name = struct.name;
    }
    
    model.struct = struct;
    struct.model = model;
    struct.is_cs_model = undefined;
    struct.is_cs_scriptable = undefined;
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = model;
    }
    
    return model;
}

// Namespace create_script_utility
// Params 4
// Checksum 0xc20da0df, Offset: 0x20ba
// Size: 0x385
function strike_triggercreate( struct, index, skip_angle_offset, noent_volume )
{
    if ( utility::issharedfuncdefined( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580" ) )
    {
        if ( !isdefined( level.var_b3ff9fd5b79563f ) )
        {
            level.var_b3ff9fd5b79563f = 0;
        }
        
        if ( level.var_b3ff9fd5b79563f >= 1500 )
        {
            if ( level.create_script_debug )
            {
                logstring( "[ CS | Debug ] " + "create_script_utility::strike_triggercreate" + ": " + "level.create_script_debug: Trigger budget limit reached (" + level.var_b3ff9fd5b79563f + "), skipping trigger creation for " + struct );
            }
            
            return;
        }
        
        level.var_b3ff9fd5b79563f++;
        arena_str = utility::callsharedfunc( #"hash_4ea6dfc8e7bb2936", #"hash_fdd6563b42678580" );
        
        if ( isdefined( struct.arena_instance ) )
        {
            arena_str = struct.arena_instance;
        }
        
        if ( level.create_script_debug )
        {
            logstring( "[ CS | Debug ] " + "create_script_utility::strike_triggercreate" + ": " + "level.create_script_debug: Creating trigger " + level.var_b3ff9fd5b79563f + " for " + struct + " (arena: " + arena_str + ")" );
        }
    }
    
    strike_add_to_cs_arrays( "trigger", struct, index );
    
    if ( isdefined( struct.spawnflags ) )
    {
        spawnflags = struct.spawnflags;
    }
    else
    {
        spawnflags = 0;
    }
    
    if ( isdefined( struct._size_min ) && isdefined( struct._size_max ) || isdefined( struct.size_min ) && isdefined( struct.size_max ) )
    {
        if ( noent_volume )
        {
            trigger = spawn( "noent_volume_trigger_box", struct.origin, spawnflags, struct._size_min ?? struct.size_min, struct._size_max ?? struct.size_max );
        }
        else
        {
            trigger = spawn( "trigger_box", struct.origin, spawnflags, struct._size_min ?? struct.size_min, struct._size_max ?? struct.size_max );
        }
    }
    else if ( noent_volume )
    {
        trigger = spawn( "noent_volume_trigger_rotatable_radius", struct.origin, spawnflags, int( struct.radius ), int( struct.height ) );
    }
    else
    {
        trigger = spawn( "trigger_rotatable_radius", struct.origin, spawnflags, int( struct.radius ), int( struct.height ) );
    }
    
    if ( isdefined( struct.angles ) && struct.angles != ( 0, 0, 0 ) )
    {
        if ( skip_angle_offset )
        {
            trigger.angles = struct.angles;
        }
        else
        {
            trigger.angles = ( -90, 0, 0 ) + struct.angles;
        }
    }
    
    trigger.struct = struct;
    
    if ( isdefined( self.objects ) )
    {
        self.objects[ self.objects.size ] = trigger;
    }
    
    trigger strike_triggerassignvalues( struct );
    struct.trigger = trigger;
    return trigger;
}

// Namespace create_script_utility
// Params 1
// Checksum 0x68889da3, Offset: 0x2448
// Size: 0x324
function strike_triggerassignvalues( struct )
{
    if ( !isdefined( struct.angles ) )
    {
        struct.angles = ( 0, 0, 0 );
    }
    
    if ( isdefined( struct.script_label ) )
    {
        self.script_label = struct.script_label;
    }
    
    if ( isdefined( struct.script_function ) )
    {
        self.script_function = struct.script_function;
    }
    
    if ( isdefined( struct.script_noteworthy ) )
    {
        self.script_noteworthy = struct.script_noteworthy;
    }
    
    if ( isdefined( struct.script_gesture ) )
    {
        self.script_gesture = struct.script_gesture;
    }
    
    if ( isdefined( struct.target ) )
    {
        self.target = struct.target;
    }
    
    if ( isdefined( struct.script_wtf ) )
    {
        self.script_wtf = struct.script_wtf;
    }
    
    if ( isdefined( struct.script_flag ) )
    {
        self.script_flag = struct.script_flag;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        self.script_linkto = struct.script_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        self.script_linkname = struct.script_linkname;
    }
    
    if ( isdefined( struct.groupname ) )
    {
        self.groupname = struct.groupname;
    }
    
    if ( isdefined( struct.script_count ) )
    {
        self.script_count = struct.script_count;
    }
    
    if ( isdefined( struct.script_count_min ) )
    {
        self.script_count_min = struct.script_count_min;
    }
    
    if ( isdefined( struct.script_count_max ) )
    {
        self.script_count_max = struct.script_count_max;
    }
    
    if ( isdefined( struct.script_maxdist ) )
    {
        self.script_maxdist = struct.script_maxdist;
    }
    
    if ( isdefined( struct.script_parameters ) )
    {
        self.script_parameters = struct.script_parameters;
    }
    
    if ( isdefined( struct._size_min ) || isdefined( struct.size_min ) )
    {
        self.size_min = struct._size_min ?? struct.size_min;
    }
    
    if ( isdefined( struct._size_max ) || isdefined( struct.size_max ) )
    {
        self.size_max = struct._size_max ?? struct.size_max;
    }
    
    if ( isdefined( struct.height ) )
    {
        self.height = float( struct.height );
    }
    
    if ( isdefined( struct.radius ) )
    {
        self.radius = float( struct.radius );
    }
    
    self.targetname = struct.targetname;
}

// Namespace create_script_utility
// Params 2
// Checksum 0xc09f38a2, Offset: 0x2774
// Size: 0x1fc
function strike_fixautokvps( struct, index )
{
    if ( isdefined( struct.target ) && issubstr( struct.target, "auto" ) )
    {
        struct.target = "CS|" + index + struct.target;
    }
    
    if ( isdefined( struct.targetname ) && issubstr( struct.targetname, "auto" ) )
    {
        struct.targetname = "CS|" + index + struct.targetname;
    }
    
    if ( isdefined( struct.script_linkto ) )
    {
        new_linkto = "";
        str_toks = strtok( struct.script_linkto, " " );
        
        foreach ( new_index, tok in str_toks )
        {
            if ( new_index != 0 )
            {
                new_linkto = new_linkto + " " + "CS|" + index + tok;
                continue;
            }
            
            new_linkto = new_linkto + "CS|" + index + tok;
        }
        
        struct.script_linkto = new_linkto;
    }
    
    if ( isdefined( struct.script_linkname ) )
    {
        struct.script_linkname = "CS|" + index + struct.script_linkname;
    }
    
    if ( isdefined( struct.var_4501e0172e168ddf ) && issubstr( struct.var_4501e0172e168ddf, "auto" ) )
    {
        struct.var_4501e0172e168ddf = "CS|" + index + struct.var_4501e0172e168ddf;
    }
}

// Namespace create_script_utility
// Params 1, eflags: 0x4
// Checksum 0x9ef645ea, Offset: 0x2978
// Size: 0x5e1
function private correct_kvps( struct )
{
    if ( !isdefined( struct.script_agent_noteworthy ) )
    {
        struct.script_agent_noteworthy = struct.agent_noteworthy;
    }
    
    struct.agent_noteworthy = undefined;
    
    if ( !isdefined( struct.script_aitype1 ) )
    {
        struct.script_aitype1 = struct.aitype1;
    }
    
    struct.aitype1 = undefined;
    
    if ( !isdefined( struct.var_ac0bdf392493e77c ) )
    {
        struct.var_ac0bdf392493e77c = struct.aitype1_tier;
    }
    
    struct.aitype1_tier = undefined;
    
    if ( !isdefined( struct.script_aitype2 ) )
    {
        struct.script_aitype2 = struct.aitype2;
    }
    
    struct.aitype2 = undefined;
    
    if ( !isdefined( struct.var_87611d2ca2b7713f ) )
    {
        struct.var_87611d2ca2b7713f = struct.aitype2_tier;
    }
    
    struct.aitype2_tier = undefined;
    
    if ( !isdefined( struct.script_aitype3 ) )
    {
        struct.script_aitype3 = struct.aitype3;
    }
    
    struct.aitype3 = undefined;
    
    if ( !isdefined( struct.var_4f90afd899f9fee ) )
    {
        struct.var_4f90afd899f9fee = struct.aitype3_tier;
    }
    
    struct.aitype3_tier = undefined;
    
    if ( !isdefined( struct.script_aitype4 ) )
    {
        struct.script_aitype4 = struct.aitype4;
    }
    
    struct.aitype4 = undefined;
    
    if ( !isdefined( struct.var_3c3f250270ff9e19 ) )
    {
        struct.var_3c3f250270ff9e19 = struct.aitype4_tier;
    }
    
    struct.aitype4_tier = undefined;
    
    if ( !isdefined( struct.script_aitype5 ) )
    {
        struct.script_aitype5 = struct.aitype5;
    }
    
    struct.aitype5 = undefined;
    
    if ( !isdefined( struct.var_a546e3b887216930 ) )
    {
        struct.var_a546e3b887216930 = struct.aitype5_tier;
    }
    
    struct.aitype5_tier = undefined;
    
    if ( !isdefined( struct.script_codelength ) )
    {
        struct.script_codelength = struct.codelength;
    }
    
    struct.codelength = undefined;
    
    if ( !isdefined( struct.var_af6e5d930fa87809 ) )
    {
        struct.var_af6e5d930fa87809 = struct.var_a90df791fe73fa81;
    }
    
    struct.var_a90df791fe73fa81 = undefined;
    
    if ( !isdefined( struct.var_e694cf2ef13fd4e ) )
    {
        struct.var_e694cf2ef13fd4e = struct.var_11d9d23f13150706;
    }
    
    struct.var_11d9d23f13150706 = undefined;
    
    if ( !isdefined( struct.script_cs_flag ) )
    {
        struct.script_cs_flag = struct.cs_flag;
    }
    
    struct.cs_flag = undefined;
    
    if ( !isdefined( struct.script_formation_type ) )
    {
        struct.script_formation_type = struct.formation_type;
    }
    
    struct.formation_type = undefined;
    
    if ( !isdefined( struct.script_maxagents ) )
    {
        struct.script_maxagents = struct.maxagents;
    }
    
    struct.maxagents = undefined;
    
    if ( !isdefined( struct.var_f33efdd5ce648efc ) )
    {
        struct.var_f33efdd5ce648efc = struct.minagents;
    }
    
    struct.minagents = undefined;
    
    if ( !isdefined( struct.script_nationality_override ) )
    {
        struct.script_nationality_override = struct.nationality_override;
    }
    
    struct.nationality_override = undefined;
    
    if ( !isdefined( struct.script_path_behavior ) )
    {
        struct.script_path_behavior = struct.path_behavior;
    }
    
    struct.path_behavior = undefined;
    
    if ( !isdefined( struct.script_patrolspawnset ) )
    {
        struct.script_patrolspawnset = struct.patrolspawnset;
    }
    
    struct.patrolspawnset = undefined;
    
    if ( !isdefined( struct.script_poi ) )
    {
        struct.script_poi = struct.poi;
    }
    
    struct.poi = undefined;
    
    if ( !isdefined( struct.script_required ) )
    {
        struct.script_required = struct.required;
    }
    
    struct.required = undefined;
    
    if ( !isdefined( struct.script_respawn_behavior ) )
    {
        struct.script_respawn_behavior = struct.respawn_behavior;
    }
    
    struct.respawn_behavior = undefined;
    
    if ( !isdefined( struct.script_spawnset ) )
    {
        struct.script_spawnset = struct.spawnset;
    }
    
    struct.spawnset = undefined;
    
    if ( !isdefined( struct.script_tier ) )
    {
        struct.script_tier = struct.tier;
    }
    
    struct.tier = undefined;
    
    if ( !isdefined( struct.script_waittime ) )
    {
        struct.script_waittime = struct.waittime;
    }
    
    struct.waittime = undefined;
    
    if ( !isdefined( struct.script_wander_range ) )
    {
        struct.script_wander_range = struct.wander_range;
    }
    
    struct.wander_range = undefined;
    
    if ( !isdefined( struct.script_keynameoverride ) )
    {
        struct.script_keynameoverride = struct.keynameoverride;
    }
    
    struct.keynameoverride = undefined;
    
    if ( !isdefined( struct.var_58a9237ef2346f68 ) )
    {
        struct.var_58a9237ef2346f68 = struct.patroltier;
    }
    
    if ( !isdefined( struct.var_a1d97aef7430ab74 ) )
    {
        struct.var_a1d97aef7430ab74 = struct.idledemeanor_override;
    }
    
    utility::callsharedfunc( #"create_script", #"correct_kvps", struct );
}

// Namespace create_script_utility
// Params 0
// Checksum 0xdbd11d5b, Offset: 0x2f61
// Size: 0x11
function function_cdd699ffd1993a2f()
{
    return getdvarint( @"scr_enable_create_script", 1 );
}

// Namespace create_script_utility
// Params 2, eflags: 0x4
// Checksum 0xba48b983, Offset: 0x2f7b
// Size: 0x46
function private function_a2835b2acafd9449( value, key )
{
    /#
        if ( isdefined( value ) )
        {
            print( key + "<dev string:x39>" + self.origin + "<dev string:x60>" + key + "<dev string:x8e>" );
        }
    #/
    
    return value;
}

// Namespace create_script_utility
// Params 1
// Checksum 0xb7447841, Offset: 0x2fca
// Size: 0xade
function typecast_kvps( struct )
{
    if ( utility::issharedfuncdefined( #"createscript", #"typecast" ) )
    {
        if ( struct utility::callsharedfunc( #"createscript", #"typecast" ) )
        {
            return;
        }
    }
    
    if ( isdefined( struct.script_wait_min ) )
    {
        struct.script_wait_min = float( struct.script_wait_min );
    }
    
    if ( isdefined( struct.script_wait_max ) )
    {
        struct.script_wait_max = float( struct.script_wait_max );
    }
    
    if ( isdefined( struct.script_wait_add ) )
    {
        struct.script_wait_add = float( struct.script_wait_add );
    }
    
    if ( isdefined( struct.script_brake ) )
    {
        struct.script_brake = float( struct.script_brake );
    }
    
    if ( isdefined( struct.var_ad44e0b56fe43ced ) )
    {
        struct.var_ad44e0b56fe43ced = int( struct.var_ad44e0b56fe43ced );
    }
    
    if ( isdefined( struct.lookahead ) )
    {
        struct.lookahead = int( struct.lookahead );
    }
    
    if ( isdefined( struct.speed ) )
    {
        struct.speed = int( struct.speed );
    }
    
    if ( isdefined( struct.var_48c370d91f3d4ea6 ) )
    {
        if ( struct.var_48c370d91f3d4ea6 == "true" || struct.var_48c370d91f3d4ea6 == "1" )
        {
            struct.var_48c370d91f3d4ea6 = 1;
        }
        else
        {
            struct.var_48c370d91f3d4ea6 = 0;
        }
    }
    
    if ( isdefined( struct.dont_enter_combat ) )
    {
        struct.dont_enter_combat = int( struct.dont_enter_combat );
    }
    
    if ( isdefined( struct.script_goalradius ) )
    {
        struct.script_goalradius = int( struct.script_goalradius );
    }
    
    if ( isdefined( struct.script_accel ) )
    {
        struct.script_accel = int( struct.script_accel );
    }
    
    if ( isdefined( struct.script_decel ) )
    {
        struct.script_decel = int( struct.script_decel );
    }
    
    if ( isdefined( struct.script_speed ) )
    {
        struct.script_speed = int( struct.script_speed );
    }
    
    if ( isdefined( struct.repeat_interaction ) )
    {
        struct.repeat_interaction = int( struct.repeat_interaction );
    }
    
    if ( isdefined( struct.script_goal_threshold ) )
    {
        struct.script_goal_threshold = float( struct.script_goal_threshold );
    }
    
    if ( isdefined( struct.var_780beece5119cec3 ) )
    {
        if ( struct.var_780beece5119cec3 == "true" || struct.var_780beece5119cec3 == "1" )
        {
            struct.var_780beece5119cec3 = 1;
        }
        else
        {
            struct.var_780beece5119cec3 = undefined;
        }
    }
    
    if ( isdefined( struct.script_goalyaw ) )
    {
        if ( struct.script_goalyaw == "true" || struct.script_goalyaw == "1" )
        {
            struct.script_goalyaw = 1;
        }
        else
        {
            struct.script_goalyaw = undefined;
        }
    }
    
    if ( isdefined( struct.script_anglevehicle ) )
    {
        if ( struct.script_anglevehicle == "true" || struct.script_anglevehicle == "1" )
        {
            struct.script_goalyaw = 1;
        }
        else
        {
            struct.script_goalyaw = undefined;
        }
    }
    
    if ( isdefined( struct.script_delay ) )
    {
        struct.script_delay = float( struct.script_delay );
    }
    
    if ( isdefined( struct.script_onlyidle ) )
    {
        struct.script_onlyidle = int( struct.script_onlyidle );
    }
    
    if ( isdefined( struct.script_ignoreme ) )
    {
        struct.script_ignoreme = int( struct.script_ignoreme );
    }
    
    if ( isdefined( struct.script_ignoreall ) )
    {
        struct.script_ignoreall = int( struct.script_ignoreall );
    }
    
    if ( isdefined( struct.script_death ) )
    {
        struct.script_death = int( struct.script_death );
    }
    
    if ( isdefined( struct.script_wait ) )
    {
        struct.script_wait = float( struct.script_wait );
    }
    
    if ( isdefined( struct.script_forcespawn ) )
    {
        struct.script_forcespawn = int( struct.script_forcespawn );
    }
    
    if ( isdefined( struct.script_timer ) )
    {
        struct.script_timer = int( struct.script_timer );
    }
    
    if ( isdefined( struct.script_dist_only ) )
    {
        struct.script_dist_only = int( struct.script_dist_only ) * int( struct.script_dist_only );
    }
    
    if ( isdefined( struct.script_speed ) )
    {
        struct.script_speed = int( struct.script_speed );
    }
    
    if ( isdefined( struct.script_count ) )
    {
        struct.script_count = int( struct.script_count );
    }
    
    if ( isdefined( struct.script_radius ) )
    {
        struct.script_radius = int( struct.script_radius );
    }
    
    if ( isdefined( struct.script_delay_min ) )
    {
        struct.script_delay_min = float( struct.script_delay_min );
    }
    
    if ( isdefined( struct.script_delay_max ) )
    {
        struct.script_delay_max = float( struct.script_delay_max );
    }
    
    if ( isdefined( struct.script_escalation_level ) )
    {
        struct.script_escalation_level = int( struct.script_escalation_level );
    }
    
    if ( isdefined( struct.script_goalheight ) )
    {
        struct.script_goalheight = int( struct.script_goalheight );
    }
    
    if ( isdefined( struct.script_timeout ) )
    {
        struct.script_timeout = float( struct.script_timeout );
    }
    
    if ( isdefined( struct.script_pacifist ) )
    {
        struct.script_pacifist = int( struct.script_pacifist );
    }
    
    if ( isdefined( struct.script_forcespawn ) )
    {
        struct.script_forcespawn = int( struct.script_forcespawn );
    }
    
    if ( isdefined( struct.dontkilloff ) )
    {
        struct.dontkilloff = int( struct.dontkilloff );
    }
    
    if ( isdefined( struct.script_origin_other ) )
    {
        struct.script_origin_other = struct.script_origin_other;
    }
    
    if ( isdefined( struct.script_dot ) )
    {
        struct.script_dot = int( struct.script_dot );
    }
    
    if ( isdefined( struct.script_stopnode ) )
    {
        struct.script_stopnode = int( struct.script_stopnode );
    }
    
    if ( isdefined( struct.script_maxdist ) )
    {
        struct.script_maxdist = int( struct.script_maxdist );
    }
    
    if ( isdefined( struct.script_accuracy ) )
    {
        struct.script_accuracy = float( struct.script_accuracy );
    }
    
    if ( isdefined( struct.script_bcdialog ) )
    {
        struct.script_bcdialog = int( struct.script_bcdialog );
    }
    
    if ( isdefined( struct.script_fixednode ) )
    {
        struct.script_fixednode = int( struct.script_fixednode );
    }
    
    if ( isdefined( struct.script_pacifist ) )
    {
        struct.script_pacifist = int( struct.script_pacifist );
    }
    
    if ( isdefined( struct.script_moveoverride ) )
    {
        struct.script_moveoverride = int( struct.script_moveoverride );
    }
    
    if ( isdefined( struct.script_longdeath ) )
    {
        struct.script_longdeath = int( struct.script_longdeath );
    }
    
    if ( isdefined( struct.script_goalyaw ) )
    {
        struct.script_goalyaw = int( struct.script_goalyaw );
    }
    
    if ( isdefined( struct.script_forcegoal ) )
    {
        struct.script_forcegoal = int( struct.script_forcegoal );
    }
    
    if ( isdefined( struct.script_forcespawn ) )
    {
        struct.script_forcespawn = int( struct.script_forcespawn );
    }
    
    if ( isdefined( struct.script_useangles ) )
    {
        struct.script_useangles = int( struct.script_useangles );
    }
    
    if ( isdefined( struct.script_suspend ) )
    {
        struct.script_suspend = int( struct.script_suspend );
    }
    
    if ( isdefined( struct.count ) )
    {
        struct.count = int( struct.count );
    }
    
    if ( isdefined( struct.script_index ) )
    {
        struct.script_index = int( struct.script_index );
    }
    
    if ( isdefined( struct.script_faceangles ) )
    {
        if ( isstring( struct.script_faceangles ) && ( struct.script_faceangles == "true" || struct.script_faceangles == "1" ) )
        {
            struct.script_faceangles = 1;
        }
        
        if ( int( struct.script_faceangles ) != 0 )
        {
            struct.script_faceangles = 1;
        }
        else
        {
            struct.script_faceangles = undefined;
        }
    }
    
    if ( isdefined( struct.script_cleanexit ) )
    {
        if ( struct.script_cleanexit == "true" || struct.script_cleanexit == "1" )
        {
            struct.script_cleanexit = 1;
            return;
        }
        
        struct.script_cleanexit = undefined;
    }
}

// Namespace create_script_utility
// Params 0
// Checksum 0x76154741, Offset: 0x3ab0
// Size: 0x5c
function cs_is_starttime()
{
    if ( utility::issp() )
    {
        if ( !isdefined( level.starttime ) )
        {
            level.starttime = gettime();
        }
        
        return ( gettime() <= level.starttime + 250 );
    }
    
    if ( !isdefined( level.starttimeutcseconds ) )
    {
        return 1;
    }
    
    return gettime() <= level.starttimeutcseconds + 250;
}

// Namespace create_script_utility
// Params 1
// Checksum 0x863ec688, Offset: 0x3b14
// Size: 0x79
function cs_init_flags( newitem )
{
    if ( !utility::flag_exist( "strike_init_done" ) )
    {
        utility::flag_init( "strike_init_done" );
    }
    
    if ( !utility::flag_exist( "create_script_initialized" ) )
    {
        utility::flag_init( "create_script_initialized" );
    }
    
    newitem.objects = [];
    newitem utility::ent_flag_init( "cs_structs_complete" );
    newitem utility::ent_flag_init( "cs_models_complete" );
    newitem utility::ent_flag_init( "cs_triggers_complete" );
}

// Namespace create_script_utility
// Params 1
// Checksum 0xf3218c6d, Offset: 0x3b95
// Size: 0x5d
function cs_flags_init( newitem )
{
    if ( !utility::flag_exist( "strike_init_done" ) )
    {
        utility::flag_init( "strike_init_done" );
    }
    
    if ( !utility::flag_exist( "create_script_initialized" ) )
    {
        utility::flag_init( "create_script_initialized" );
    }
    
    newitem.objects = [];
    newitem utility::ent_flag_init( "cs_objects_created" );
}

// Namespace create_script_utility
// Params 2
// Checksum 0x4b15a25d, Offset: 0x3bfa
// Size: 0x90
function wait_for_flags( newitem, complete_flag )
{
    if ( newitem utility::ent_flag_exist( "cs_structs_complete" ) )
    {
        newitem utility::ent_flag_wait( "cs_structs_complete" );
    }
    
    if ( newitem utility::ent_flag_exist( "cs_triggers_complete" ) )
    {
        newitem utility::ent_flag_wait( "cs_triggers_complete" );
    }
    
    if ( newitem utility::ent_flag_exist( "cs_objects_created" ) )
    {
        newitem utility::ent_flag_wait( "cs_objects_created" );
    }
    
    utility::flag_set( complete_flag + "_completed" );
    
    if ( cs_is_starttime() )
    {
        endcreatescript( newitem );
    }
}

// Namespace create_script_utility
// Params 1
// Checksum 0xe772f17c, Offset: 0x3c92
// Size: 0xaa
function endcreatescript( newitem )
{
    if ( isdefined( level.createscriptfilesinitialized ) && ( !isdefined( level.cs_scripts ) || level.cs_scripts.size == 0 ) )
    {
        level.createscriptfilesinitialized++;
        
        if ( level.createscriptfilesinitialized >= level.scripted_spawner_func.size )
        {
            utility::flag_set( "strike_init_done" );
            utility::flag_set( "create_script_initialized" );
        }
        
        return;
    }
    
    if ( !isdefined( level.cs_scripts ) || level.cs_scripts.size == 0 )
    {
        utility::flag_set( "strike_init_done" );
        utility::flag_set( "create_script_initialized" );
    }
}

// Namespace create_script_utility
// Params 1
// Checksum 0x17e08f39, Offset: 0x3d44
// Size: 0x43
function wait_for_cs_flag( waittill_flag )
{
    level endon( #"game_ended" );
    utility::flag_init( waittill_flag + "_completed" );
    
    if ( !should_wait_for_cs_flag( waittill_flag ) )
    {
        endcreatescript();
        utility::flag_wait( waittill_flag );
    }
}

// Namespace create_script_utility
// Params 1
// Checksum 0x1fcf01c8, Offset: 0x3d8f
// Size: 0x90, Type: bool
function should_wait_for_cs_flag( waittill_flag )
{
    toks = strtok( getdvar( @"hash_db88b998734440cc", "" ), " " );
    toks = arraycombine( toks, level.active_cs_files );
    
    if ( toks.size < 1 )
    {
        return true;
    }
    
    for ( i = 0; i < toks.size ; i++ )
    {
        tok = toks[ i ];
        
        if ( tok == "all" )
        {
            return true;
        }
        
        if ( waittill_flag == tok )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace create_script_utility
// Params 3
// Checksum 0x11204e83, Offset: 0x3e28
// Size: 0x46
function register_cs_offsets( cs_file, origin_offset, angle_offset )
{
    if ( isdefined( origin_offset ) )
    {
        level.cs_origin_offset[ cs_file ] = origin_offset;
    }
    
    if ( isdefined( angle_offset ) )
    {
        level.cs_angle_offset[ cs_file ] = angle_offset;
    }
}

// Namespace create_script_utility
// Params 1
// Checksum 0x19801afd, Offset: 0x3e76
// Size: 0x23
function set_cs_file_dvar( file_name )
{
    level.active_cs_files[ level.active_cs_files.size ] = file_name;
}

// Namespace create_script_utility
// Params 1
// Checksum 0x6a6abda9, Offset: 0x3ea1
// Size: 0xd1
function cleanup_cs_file_objects( cs_file )
{
    utility::flag_clear( cs_file + "_completed" );
    utility::flag_clear( cs_file );
    
    if ( isdefined( level.cs_object_container[ cs_file ] ) && isdefined( level.cs_object_container[ cs_file ].objects ) )
    {
        temp_array = level.cs_object_container[ cs_file ].objects;
        
        for ( i = 0; i < temp_array.size ; i++ )
        {
            object = temp_array[ i ];
            level.cs_object_container[ cs_file ].objects[ i ] = undefined;
            
            if ( isstruct( object ) )
            {
                utility::deletestruct_ref( object );
            }
            
            if ( isent( object ) )
            {
                object delete();
            }
        }
    }
}

// Namespace create_script_utility
// Params 2, eflags: 0x4
// Checksum 0x764e116f, Offset: 0x3f7a
// Size: 0x177
function private clean_cs_file_structs_array( type, cs_file )
{
    if ( !utility::flag_exist( "clean_cs_file_structs_array" ) )
    {
        level.var_433b039f6c4e780b = 0;
        utility::flag_init( "clean_cs_file_structs_array" );
    }
    else
    {
        while ( level.var_433b039f6c4e780b )
        {
            utility::flag_wait( "clean_cs_file_structs_array" );
        }
        
        utility::flag_clear( "clean_cs_file_structs_array" );
    }
    
    level.var_433b039f6c4e780b = 1;
    typekeys = getarraykeys( level.struct_class_names[ type ] );
    waitframe();
    var_99e931d9154a388c = 50;
    var_65c712be6f0c68aa = 0;
    
    for ( targetnameindex = 0; targetnameindex < typekeys.size ; targetnameindex++ )
    {
        newarray = [];
        
        if ( targetnameindex % var_99e931d9154a388c == 0 )
        {
            waitframe();
        }
        
        typekey = typekeys[ targetnameindex ];
        typekeysize = level.struct_class_names[ type ][ typekey ].size;
        
        for ( index = 0; index < typekeysize ; index++ )
        {
            struct = level.struct_class_names[ type ][ typekey ][ index ];
            
            if ( isdefined( struct ) && struct.script_cs_flag != cs_file )
            {
                newarray[ newarray.size ] = struct;
                continue;
            }
            
            var_65c712be6f0c68aa++;
        }
        
        level.struct_class_names[ type ][ typekey ] = newarray;
    }
    
    utility::flag_set( "clean_cs_file_structs_array" );
    level.var_433b039f6c4e780b = 0;
    return var_65c712be6f0c68aa;
}

// Namespace create_script_utility
// Params 1
// Checksum 0xb7d4e749, Offset: 0x40fa
// Size: 0xd2
function cleanup_cs_file_structs( cs_file )
{
    types = [ "targetname", "target", "script_noteworthy", "script_linkname", "variantname", "script_agent_noteworthy" ];
    var_65c712be6f0c68aa = 0;
    
    foreach ( type in types )
    {
        var_65c712be6f0c68aa += clean_cs_file_structs_array( type, cs_file );
        waitframe();
    }
    
    return var_65c712be6f0c68aa;
}

// Namespace create_script_utility
// Params 0
// Checksum 0x1b41c66d, Offset: 0x41d5
// Size: 0x6
function s()
{
    return spawnstruct();
}

// Namespace create_script_utility
// Params 1
// Checksum 0x349797c0, Offset: 0x41e4
// Size: 0x2cd
function spawn_cover_nodes( struct_targetname )
{
    node_structs = utility::getstructarray( struct_targetname, "targetname" );
    
    foreach ( struct in node_structs )
    {
        if ( !isdefined( struct.angles ) )
        {
            struct.angles = ( 0, 0, 0 );
        }
        
        type = "Cover Stand";
        
        switch ( struct.nodetype )
        {
            case #"hash_4ddb655e251e06c8":
                type = "Cover Left";
                break;
            case #"hash_175771022bc5e75d":
                type = "Cover Right";
                break;
            case #"hash_9d76c99eddd14433":
                type = "Cover Crouch";
                break;
            case #"hash_f1676baca0ae608b":
                type = "Cover Stand";
                break;
            case #"hash_8c335d77517de4f8":
                type = "Cover Crouch Window";
                break;
            case #"hash_42d1769dd06f8045":
                type = "Conceal Crouch";
                break;
            case #"hash_a315be2e1164ff6b":
                type = "Exposed";
            case #"hash_d4850e4dfbc48417":
                type = "Turret";
                break;
        }
        
        targetname = undefined;
        
        if ( isdefined( struct.node_targetname ) )
        {
            targetname = struct.node_targetname;
        }
        
        spawnflags = 0;
        
        if ( isdefined( struct.nostand ) && int( struct.nostand ) != 0 && struct.nostand != "false" )
        {
            spawnflags = 4;
        }
        
        if ( isdefined( struct.nocrouch ) && int( struct.nocrouch ) != 0 && struct.nocrouch != "false" )
        {
            spawnflags += 8;
        }
        
        if ( isdefined( struct.noprone ) && int( struct.noprone ) != 0 && struct.noprone != "false" )
        {
            spawnflags += 16;
        }
        
        struct.covernode = spawncovernode( struct.origin, struct.angles, type, spawnflags, targetname );
        
        if ( isdefined( struct.radius ) )
        {
            struct.covernode.radius = struct.radius;
        }
    }
    
    return node_structs;
}

// Namespace create_script_utility
// Params 1
// Checksum 0xad503d8b, Offset: 0x44ba
// Size: 0xb6
function delete_covernodes( struct_targetname )
{
    node_structs = utility::getstructarray( struct_targetname, "targetname" );
    
    foreach ( struct in node_structs )
    {
        if ( isdefined( struct.covernode ) )
        {
            despawncovernode( struct.covernode );
            struct.covernode = undefined;
        }
    }
}

// Namespace create_script_utility
// Params 0
// Checksum 0xc7caab1b, Offset: 0x4578
// Size: 0x41
function function_4579dd5df27ceeca()
{
    level endon( #"game_ended" );
    utility::flag_wait( "create_script" );
    return_value = level.var_851d5cbe5ebb59b4;
    level.var_851d5cbe5ebb59b4++;
    return "cs" + return_value;
}

// Namespace create_script_utility
// Params 1
// Checksum 0x20452455, Offset: 0x45c2
// Size: 0x3a
function add_create_script_file( create_script_file )
{
    level.cs_scripts[ level.cs_scripts.size ] = create_script_file;
    level.scripted_spawner_func[ level.scripted_spawner_func.size ] = create_script_file;
}

// Namespace create_script_utility
// Params 0
// Checksum 0x5fa97c91, Offset: 0x4604
// Size: 0x85
function init_create_script_files()
{
    foreach ( cs_file_func in level.cs_scripts )
    {
        profilestart();
        [[ cs_file_func ]]();
        profilestop();
    }
    
    utility::flag_set( "create_script_initialized" );
}

// Namespace create_script_utility
// Params 1
// Checksum 0x70a12b4f, Offset: 0x4691
// Size: 0x122, Type: bool
function filter( cs_file )
{
    if ( level.gametypebundle.var_f4f859c46a772638 )
    {
        foreach ( filter in level.gametypebundle.var_f4f859c46a772638.filters )
        {
            filter = filter.variant_object;
            filterfn = level.var_6db29ff4582b386c[ filter.type ];
            
            if ( filterfn )
            {
                result = [[ filterfn ]]( filter, cs_file );
                
                if ( filter.operation == "OnlyInclude" && !result )
                {
                    return false;
                }
                
                if ( filter.operation == "Exclude" && result )
                {
                    return false;
                }
            }
        }
    }
    
    return true;
}

// Namespace create_script_utility
// Params 2, eflags: 0x4
// Checksum 0x4ffd51e8, Offset: 0x47bc
// Size: 0xb1, Type: bool
function private filter_file( filter, cs_file )
{
    var_6e2dce538d4caae7 = cs_file + ".gsc";
    
    foreach ( filestruct in filter.Files )
    {
        if ( isendstr( filestruct.file, var_6e2dce538d4caae7 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace create_script_utility
// Params 2, eflags: 0x4
// Checksum 0x325c2556, Offset: 0x4876
// Size: 0x26
function private filter_substring( filter, cs_file )
{
    return issubstr( cs_file, filter.var_e05d81a6508068ad );
}

// Namespace create_script_utility
// Params 0
// Checksum 0x66b0c36c, Offset: 0x48a5
// Size: 0x2
function function_e7d3f8268c67e8ec()
{
    
}

