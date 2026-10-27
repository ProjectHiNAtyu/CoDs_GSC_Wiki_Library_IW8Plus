// scripts\mp\ob\systems\ob_activity_instance_common.gsc  (hash_7eca8aa39a084054.gscc) (size: 5903 Bytes / 0x170f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb51d7447 (3038606407)
// size ...... 5903 (0x170f)
// includes .. 14  (offset: 0x159f)
// strings ... 10  (offset: 0x160f)
// dev strs .. 8   (offset: 0x1697)
// exports ... 20  (offset: 0xd03)
// cseg ...... 0xfd + 0xc06 (0xd03)
// imports ... 47  (offset: 0x1023)
// animtree1 . 0   (offset: 0x170f)
// animtree2 . 0   (offset: 0x170f)
#using script_4dbf393b22261d86;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\conditional_container;
#using scripts\common\create_script_utility;
#using scripts\common\spatial_zone_container;
#using scripts\common\utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\contracts\ob_contract_ui_widget;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_instance_common;

// Namespace ob_activity_instance_common
// Params 1
// Checksum 0xf7c1101b, Offset: 0x11b
// Size: 0x12e
function setupinstance( relevantparameters )
{
    activityinstance = relevantparameters[ 0 ];
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance ob_resource_manager::function_2fdf4c6f6ce33a2a();
    activity_instance_common::setupinstance( relevantparameters );
    function_6225b7c3f4b75eab( activityinstance );
    
    if ( function_7a8b3b6f9a260c04( activityinstance ) )
    {
        activitytype = activityinstance.type;
        activityinstance ob_contract_ui_widget::function_724ff866fa7fb742( activitytype );
        return;
    }
    
    if ( function_1da3cca018273183( activityinstance ) )
    {
        if ( isfunction( level.var_bc2eec43725b75d6 ) )
        {
            var_2ce0829b32e1fb9f = ob_activity_definition_utils::function_e92f5b64dd1e72f7( activityinstance );
            
            if ( isdefined( var_2ce0829b32e1fb9f ) )
            {
                var_a64305ba9e4c9692 = getscriptbundlefieldvalue( var_2ce0829b32e1fb9f, #"hash_c1fc108450330ed3" );
                
                if ( isdefined( var_a64305ba9e4c9692 ) )
                {
                    conditional_container::addcondition( activityinstance.participationconditions, level.var_bc2eec43725b75d6, [ var_a64305ba9e4c9692 ] );
                }
            }
        }
        
        return;
    }
    
    conditional_container::addcondition( activityinstance.participationconditions, &namespace_e1c8f2179967550d::function_a185cc42dd8b626c, [] );
    conditional_container::addcondition( activityinstance.participationconditions, &namespace_e1c8f2179967550d::function_cfd7cf741d27af35, [] );
    activityinstance activity_definition_utils::function_13b825099ff661e( activityinstance );
}

// Namespace ob_activity_instance_common
// Params 1
// Checksum 0x19d806c9, Offset: 0x251
// Size: 0x24
function cleanupinstance( relevantparameters )
{
    activityinstance = relevantparameters[ 0 ];
    activityinstance ob_resource_manager::function_4fe4605f81a69697();
}

// Namespace ob_activity_instance_common
// Params 1
// Checksum 0xb6f33fd3, Offset: 0x27d
// Size: 0x287
function function_e4e72aef67109761( relevantparameters )
{
    assert( relevantparameters.size > 0 && activity_instance_common::isactivityinstance( relevantparameters[ 0 ] ), "<dev string:x24>" );
    activityinstance = relevantparameters[ 0 ];
    additionalspawndatastruct = activityinstance.additionalspawndata ?? {};
    
    if ( additionalspawndatastruct.var_3a386fbf6079bfa1 )
    {
        activitytype = activityinstance.type;
        
        if ( activitytype == "REV_OB_BIGBOUNTY" )
        {
            joininteractscriptables = [];
            player = additionalspawndatastruct.var_dc83f634db88cb1d;
            customproperties = activity_definition_utils::function_9129cd8075c85c09( activityinstance );
            
            if ( isdefined( player ) && isdefined( customproperties ) && isdefined( customproperties.var_29c56642dd170cdb ) )
            {
                varianttag = activityinstance.varianttag;
                variantscriptstructs = utility::getstructarray( varianttag, "script_noteworthy" );
                payload = [ #"teamselect", player getentitynumber() ];
                var_de8570e64356d64c = player squad_utility::getsquadmembers();
                
                foreach ( scriptstruct in variantscriptstructs )
                {
                    if ( scriptstruct.targetname == "activity_nexus_instance_joiner" )
                    {
                        joininteractscriptable = spawnscriptable( customproperties.var_29c56642dd170cdb, scriptstruct.origin, scriptstruct.angles, undefined, payload );
                        joininteractscriptables[ joininteractscriptables.size ] = joininteractscriptable;
                        joininteractscriptable function_7653c765b6c7b815();
                        
                        foreach ( squadmember in var_de8570e64356d64c )
                        {
                            joininteractscriptable disablescriptableplayeruse( squadmember );
                        }
                    }
                }
                
                function_4b69edd0f27ad4b2( activityinstance, joininteractscriptables );
                activity_scriptables::function_12e3c036c773688f( activityinstance, joininteractscriptables, 1 );
                return joininteractscriptables;
            }
        }
    }
    
    joininteractscriptables = function_8d8664732f760de8( relevantparameters );
    function_4b69edd0f27ad4b2( activityinstance, joininteractscriptables );
    return joininteractscriptables;
}

// Namespace ob_activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0x4638d61, Offset: 0x50d
// Size: 0xbd
function private function_4b69edd0f27ad4b2( activityinstance, joininteractscriptables )
{
    if ( !joininteractscriptables || joininteractscriptables.size <= 0 )
    {
        return;
    }
    
    difficulty = ob_activity_definition_utils::function_a74c120ee76094a2( activityinstance );
    
    if ( !isdefined( difficulty ) )
    {
        return;
    }
    
    foreach ( interactscriptable in joininteractscriptables )
    {
        interactscriptable setscriptablepartstate( "difficulty", "" + difficulty, 0 );
    }
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x7042814a, Offset: 0x5d2
// Size: 0x4f
function function_9c6b2d04234d7b5e( activityinstance, markerscriptable )
{
    if ( !markerscriptable )
    {
        assertmsg( "<dev string:x8c>" );
        return;
    }
    
    difficulty = ob_activity_definition_utils::function_a74c120ee76094a2( activityinstance );
    
    if ( !isdefined( difficulty ) )
    {
        return;
    }
    
    function_63e771caf6df0970( markerscriptable, difficulty );
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x10a6108c, Offset: 0x629
// Size: 0x3e
function function_63e771caf6df0970( markerscriptable, difficulty )
{
    if ( !markerscriptable )
    {
        assertmsg( "<dev string:x8c>" );
        return;
    }
    
    markerscriptable setscriptablepartstate( "difficulty", "" + difficulty, 0 );
}

// Namespace ob_activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x364e72f8, Offset: 0x66f
// Size: 0x146
function private function_8d8664732f760de8( relevantparameters )
{
    joininteractscriptables = activity_participation::function_3bd36f038dc2b339( relevantparameters );
    activityinstance = relevantparameters[ 0 ];
    
    if ( joininteractscriptables.size == 0 )
    {
        activitydefinition = activityinstance activity_definition_utils::function_837a0c8626c9b419();
        
        if ( activity_definition_utils::function_9ba046b276151c3b( activitydefinition ) )
        {
            varianttag = activityinstance.varianttag;
            variantscriptstructs = utility::getstructarray( varianttag, "script_noteworthy" );
            
            foreach ( scriptstruct in variantscriptstructs )
            {
                if ( scriptstruct.targetname == "activity_nexus_instance_joiner" )
                {
                    scriptableasset = activity_definition_utils::function_8d582a1239b166de( activitydefinition );
                    joininteractscriptable = spawnscriptable( scriptableasset, scriptstruct.origin, scriptstruct.angles );
                    joininteractscriptables[ joininteractscriptables.size ] = joininteractscriptable;
                }
            }
        }
    }
    
    activity_scriptables::function_12e3c036c773688f( activityinstance, joininteractscriptables, 1 );
    return joininteractscriptables;
}

// Namespace ob_activity_instance_common
// Params 1
// Checksum 0xeee6b81a, Offset: 0x7be
// Size: 0x2d
function function_9b785461f2add50d( var_3a386fbf6079bfa1 )
{
    var_178524912bbc25f9 = {};
    var_178524912bbc25f9.var_3a386fbf6079bfa1 = var_3a386fbf6079bfa1 ?? 0;
    return var_178524912bbc25f9;
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x518589e5, Offset: 0x7f4
// Size: 0x40, Type: bool
function function_52f258333f31e249( activityinstance, params )
{
    assert( !isdefined( params ) || params.size != 0, "<dev string:xa9>" );
    return activityinstance.category == "Objective";
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x183d4673, Offset: 0x83d
// Size: 0x40, Type: bool
function function_478b6f79b166cdfb( activityinstance, params )
{
    assert( !isdefined( params ) || params.size != 0, "<dev string:xa9>" );
    return activityinstance.category == "Activity";
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0xef3f490d, Offset: 0x886
// Size: 0x4c, Type: bool
function function_5ff0d79f44b7a152( activityinstance, params )
{
    assert( !isdefined( params ) || params.size != 0, "<dev string:xa9>" );
    activity_type = params[ 0 ];
    return activityinstance.type != activity_type;
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0xe6aff78e, Offset: 0x8db
// Size: 0x39
function function_501c3895c5272777( activityinstance, params )
{
    assert( isarray( params ), "<dev string:xa9>" );
    return arraycontains( params, activityinstance.type );
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x183d4673, Offset: 0x91d
// Size: 0x40, Type: bool
function function_7a8b3b6f9a260c04( activityinstance, params )
{
    assert( !isdefined( params ) || params.size != 0, "<dev string:xa9>" );
    return activityinstance.category == "Contract";
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x4503cb5c, Offset: 0x966
// Size: 0x40, Type: bool
function function_1da3cca018273183( activityinstance, params )
{
    assert( !isdefined( params ) || params.size != 0, "<dev string:xa9>" );
    return activityinstance.category == "Story";
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x6fc7415b, Offset: 0x9af
// Size: 0x74, Type: bool
function function_d7502f905023ca11( activityinstance, params )
{
    assert( params.size == 2 && isdefined( params[ 0 ] ), "<dev string:x14d>" );
    var_366a13b083936e31 = params[ 0 ];
    min_distance = params[ 1 ];
    activityorigin = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    var_cf715aba2c935c26 = distance( var_366a13b083936e31, activityorigin );
    return var_cf715aba2c935c26 >= min_distance;
}

// Namespace ob_activity_instance_common
// Params 2
// Checksum 0x1e0c3b30, Offset: 0xa2c
// Size: 0x8c, Type: bool
function function_9a2953f919367e15( activityinstance, params )
{
    assert( params.size == 1 && isdefined( params[ 0 ] ), "<dev string:x199>" );
    point = params[ 0 ];
    region = region_difficulty_manager::function_f9fbb630598afdc7( point );
    activityorigin = activity_instance_common::function_776ee11e7acc64a5( activityinstance );
    var_e84f1e412814518f = region_difficulty_manager::function_f9fbb630598afdc7( activityorigin );
    return region.index == var_e84f1e412814518f.index;
}

// Namespace ob_activity_instance_common
// Params 1, eflags: 0x4
// Checksum 0x47eb3ffb, Offset: 0xac1
// Size: 0x43
function private function_6225b7c3f4b75eab( activityinstance )
{
    activitydefinition = activity_definition_utils::function_837a0c8626c9b419( activityinstance );
    
    if ( isdefined( activitydefinition.var_49b766acb5226cde ) )
    {
        function_f6d722d261db496b( activityinstance, activitydefinition.var_49b766acb5226cde );
    }
}

// Namespace ob_activity_instance_common
// Params 2, eflags: 0x4
// Checksum 0xa3ee87f6, Offset: 0xb0c
// Size: 0x139
function private function_f6d722d261db496b( activityinstance, var_49b766acb5226cde )
{
    activitytype = activityinstance.type;
    varianttag = activityinstance.varianttag;
    var_6c54aa9d69b5458a = undefined;
    
    if ( isdefined( var_49b766acb5226cde ) )
    {
        var_e72507408e24565 = [[ var_49b766acb5226cde ]]();
        var_6c54aa9d69b5458a = var_e72507408e24565[ varianttag ];
    }
    
    /#
        if ( !( isdefined( var_6c54aa9d69b5458a.scriptstructorigin ) && isdefined( var_6c54aa9d69b5458a.scriptstructoriginoffset ) ) )
        {
            assertmsg( "<dev string:x1c1>" + activitytype + "<dev string:x1ee>" + varianttag + "<dev string:x1f0>" );
        }
    #/
    
    if ( isdefined( var_6c54aa9d69b5458a.locationorigin ) )
    {
        function_87f141fddcfecb4( var_6c54aa9d69b5458a, var_6c54aa9d69b5458a.cf, var_6c54aa9d69b5458a.scriptstructoriginoffset );
        
        for ( sphereindex = 0; sphereindex < var_6c54aa9d69b5458a.locationorigin.size ; sphereindex++ )
        {
            origin = var_6c54aa9d69b5458a.locationorigin[ sphereindex ];
            radius = var_6c54aa9d69b5458a.locationradius[ sphereindex ];
            spatial_zone_container::function_847140d2863dfbf8( activityinstance, "OB_Spacer_Spatial_Zone", origin, radius );
        }
    }
}

// Namespace ob_activity_instance_common
// Params 3, eflags: 0x4
// Checksum 0x1fcc85a4, Offset: 0xc4d
// Size: 0xb6
function private function_87f141fddcfecb4( var_28fd8e4fdc33db4f, createscriptfile, centeroffset )
{
    for ( originindex = 0; originindex < var_28fd8e4fdc33db4f.locationorigin.size ; originindex++ )
    {
        center = spawnstruct();
        center.origin = var_28fd8e4fdc33db4f.locationorigin[ originindex ];
        center.angles = ( 0, 0, 0 );
        create_script_utility::translate_position_with_offset_data( createscriptfile, center, centeroffset, ( 0, 0, 0 ) );
        var_28fd8e4fdc33db4f.locationorigin[ originindex ] = center.origin;
    }
}

