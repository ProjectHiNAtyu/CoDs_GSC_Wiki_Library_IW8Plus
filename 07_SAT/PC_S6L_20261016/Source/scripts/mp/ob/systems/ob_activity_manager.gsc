// scripts\mp\ob\systems\ob_activity_manager.gsc  (hash_52000d51c914acf6.gscc) (size: 39200 Bytes / 0x9920 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcbca0dff (3419016703)
// size ...... 39200 (0x9920)
// includes .. 11  (offset: 0x9230)
// strings ... 50  (offset: 0x9288)
// dev strs .. 64  (offset: 0x95e4)
// exports ... 87  (offset: 0x6dfc)
// cseg ...... 0x724 + 0x66d8 (0x6dfc)
// imports ... 157 (offset: 0x7b94)
// animtree1 . 0   (offset: 0x9920)
// animtree2 . 0   (offset: 0x9920)
#using script_3fd8853cb3073639;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\conditional_container;
#using scripts\common\create_script_utility;
#using scripts\common\spatial_zone_container;
#using scripts\common\utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\systems\ob_activity_manager_debug;
#using scripts\mp\ob\systems\ob_resource_manager;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_activity_manager;

// Namespace ob_activity_manager
// Params 0
// Checksum 0xde4f5589, Offset: 0x742
// Size: 0x1f3
function ob_activity_manager_init()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
        
        ob_activity_manager_debug::ob_activity_manager_debug_init();
        function_320715840c9317be();
    #/
    
    if ( !function_81e8b9df4d6b3a72() )
    {
        return;
    }
    
    if ( isdefined( level.var_e607236b193eb0c1 ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    ob_resource_manager::ob_resource_manager_init();
    level.var_e607236b193eb0c1 = spawnstruct();
    level.var_e607236b193eb0c1.activitydefinitions = function_7b19c0b83db8fcdc();
    level.var_e607236b193eb0c1.activityinstances = function_196fd4f42f17dc99();
    level.var_e607236b193eb0c1.var_5992a4946aeeca5a = [];
    level.var_e607236b193eb0c1.var_559750d3b21f479f = function_196fd4f42f17dc99();
    level.var_e607236b193eb0c1.customconstraints = [];
    level.var_e607236b193eb0c1.var_92e658dad9b71fad = function_ab050f76cdf63bea();
    level.var_e607236b193eb0c1.var_c766f06b2812bf7a = function_56eb4b011cefcdc3();
    level.var_e607236b193eb0c1.var_d6a1cfbd96259eca = function_474555bea691dac7();
    level.var_e607236b193eb0c1.var_f1f909264aebf6e3 = function_e3939e15a7769446();
    level.var_e607236b193eb0c1.var_de6931c1cb8076f1 = function_8227b84f0f7a0e24();
    function_4c84a1ffd9854fc4();
    activity_common::function_2dd4f07fa5c3e911( "InstanceEnd", &ob_activity_finished );
    var_d3bb36ae177d0ea8 = function_13745445d5f57d2a();
    
    foreach ( var_1ecf3a2b4c40496c in var_d3bb36ae177d0ea8 )
    {
        level thread function_39b6fb4bbf2b1513( var_1ecf3a2b4c40496c );
    }
    
    namespace_7aeb49bf61a4f83a::function_a03a0535dc1c3af4();
}

// Namespace ob_activity_manager
// Params 0
// Checksum 0x2685993, Offset: 0x93d
// Size: 0x42
function function_13745445d5f57d2a()
{
    return [ "Global", "Activity", "Contract", "Objective", "Startup", "Story", "None" ];
}

// Namespace ob_activity_manager
// Params 0
// Checksum 0xc2fcae8f, Offset: 0x988
// Size: 0x2b, Type: bool
function function_81e8b9df4d6b3a72()
{
    return getdvarint( @"am_enabled", 1 ) != 0 && !level.var_e607236b193eb0c1.runtimedisabled;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x1a4b1b3e, Offset: 0x9bc
// Size: 0x2f4, Type: bool
function function_b5274885d68be63f( point, var_671f4308481ea10 )
{
    if ( !isvector( point ) )
    {
        assertmsg( "<dev string:x53>" );
        return false;
    }
    
    if ( !function_a9e7432e34b70581() )
    {
        return false;
    }
    
    classes = function_13745445d5f57d2a();
    regions = undefined;
    
    if ( var_671f4308481ea10 )
    {
        region = region_difficulty_manager::function_f9fbb630598afdc7( point );
        
        if ( isdefined( region ) )
        {
            regions = [ region ];
        }
    }
    
    if ( !isdefined( regions ) )
    {
        regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    }
    
    foreach ( var_a98d07f7a054ff29 in classes )
    {
        var_eb5f98f6cad9c576 = function_f7d298badd5c5b8f( @"hash_176090f07a9fa6df", var_a98d07f7a054ff29, 1800 );
        
        foreach ( region in regions )
        {
            foreach ( var_559750d3b21f479f in level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ] )
            {
                foreach ( var_c233e7a3293d7096 in var_559750d3b21f479f )
                {
                    var_ee941b4f08b5371a = spatial_zone_container::function_f7fc3e6c249a8256( var_c233e7a3293d7096, "OB_Spacer_Spatial_Zone" );
                    
                    if ( var_ee941b4f08b5371a.size >= 0 )
                    {
                        for ( var_8c27f62abc3ce8a5 = 0; var_8c27f62abc3ce8a5 < var_ee941b4f08b5371a.size ; var_8c27f62abc3ce8a5++ )
                        {
                            var_ddc91703c72d560d = var_ee941b4f08b5371a[ var_8c27f62abc3ce8a5 ];
                            var_4a36d3c804623c5b = var_ddc91703c72d560d.origin;
                            var_d009dd6b03915e97 = var_ddc91703c72d560d.radius;
                            var_58a3187fd79e84ce = squared( max( var_d009dd6b03915e97 + var_eb5f98f6cad9c576, 0 ) );
                            
                            if ( distance2dsquared( point, var_4a36d3c804623c5b ) <= var_58a3187fd79e84ce )
                            {
                                return true;
                            }
                        }
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace ob_activity_manager
// Params 1
// Checksum 0xb4038239, Offset: 0xcb9
// Size: 0x23
function ob_activity_manager_toggle( enabled )
{
    level.var_e607236b193eb0c1.runtimedisabled = !enabled;
}

// Namespace ob_activity_manager
// Params 5, eflags: 0x4
// Checksum 0xd7c7f853, Offset: 0xce4
// Size: 0xee
function private function_5e7bef20a696c67d( var_830a17c6ed3869cd, var_3e327364f1b19ac3, var_29a4e0bcfbb2fa5a, var_5f191ade1cb52caa, var_750a0efc89bfb61 )
{
    if ( !isdefined( level.var_e607236b193eb0c1.customconstraints[ var_830a17c6ed3869cd ] ) )
    {
        level.var_e607236b193eb0c1.customconstraints[ var_830a17c6ed3869cd ] = [];
    }
    
    if ( !isdefined( level.var_e607236b193eb0c1.customconstraints[ var_830a17c6ed3869cd ][ var_3e327364f1b19ac3 ] ) )
    {
        level.var_e607236b193eb0c1.customconstraints[ var_830a17c6ed3869cd ][ var_3e327364f1b19ac3 ] = [];
    }
    
    if ( !isdefined( level.var_e607236b193eb0c1.customconstraints[ var_830a17c6ed3869cd ][ var_3e327364f1b19ac3 ][ var_29a4e0bcfbb2fa5a ] ) )
    {
        level.var_e607236b193eb0c1.customconstraints[ var_830a17c6ed3869cd ][ var_3e327364f1b19ac3 ][ var_29a4e0bcfbb2fa5a ] = [];
    }
    
    level.var_e607236b193eb0c1.customconstraints[ var_830a17c6ed3869cd ][ var_3e327364f1b19ac3 ][ var_29a4e0bcfbb2fa5a ][ var_5f191ade1cb52caa ] = var_750a0efc89bfb61;
}

// Namespace ob_activity_manager
// Params 6
// Checksum 0xd44fc9bd, Offset: 0xdda
// Size: 0xa9
function function_6d643106428f593b( var_830a17c6ed3869cd, var_3e327364f1b19ac3, var_29a4e0bcfbb2fa5a, var_5f191ade1cb52caa, var_750a0efc89bfb61, var_b7d75e45997f2e8c )
{
    assert( isstring( var_830a17c6ed3869cd ) );
    assert( isstring( var_29a4e0bcfbb2fa5a ) );
    assert( isnumber( var_750a0efc89bfb61 ) );
    
    if ( !function_a9e7432e34b70581() )
    {
        return;
    }
    
    if ( !isdefined( level.var_e607236b193eb0c1.customconstraints ) )
    {
        return;
    }
    
    function_5e7bef20a696c67d( var_830a17c6ed3869cd, var_3e327364f1b19ac3, var_29a4e0bcfbb2fa5a, var_5f191ade1cb52caa, var_750a0efc89bfb61 );
    
    if ( !var_b7d75e45997f2e8c )
    {
        function_5e7bef20a696c67d( var_29a4e0bcfbb2fa5a, var_5f191ade1cb52caa, var_830a17c6ed3869cd, var_3e327364f1b19ac3, var_750a0efc89bfb61 );
    }
}

// Namespace ob_activity_manager
// Params 0
// Checksum 0x97f9c752, Offset: 0xe8b
// Size: 0x215
function function_991ecaeca9a0bd67()
{
    if ( !function_a9e7432e34b70581() )
    {
        return;
    }
    
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    classes = function_13745445d5f57d2a();
    
    foreach ( class in classes )
    {
        foreach ( region in regions )
        {
            var_da8ab8eec6dcaddf = level.var_e607236b193eb0c1.activityinstances[ class ];
            
            foreach ( activityinstances in var_da8ab8eec6dcaddf[ region.index ] )
            {
                foreach ( activityinstance in activityinstances )
                {
                    activityinstance.var_7045a7bcdef0ce48 = function_54ee4b43dbe4b005( class, region.index );
                }
            }
        }
    }
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xeaaca80c, Offset: 0x10a8
// Size: 0x3a, Type: bool
function function_a50b0d2185211831( var_a98d07f7a054ff29, activityname )
{
    if ( !function_a9e7432e34b70581() )
    {
        return false;
    }
    
    return isdefined( level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ activityname ] );
}

// Namespace ob_activity_manager
// Params 7
// Checksum 0x4b032a25, Offset: 0x10eb
// Size: 0xf1
function ob_register_class( var_a98d07f7a054ff29, activitytype, var_1dffb7e77de42c03, initfunction, startfunction, var_68f7f0b566dae31a, var_bc1827eb3b5150ce )
{
    if ( !function_a9e7432e34b70581() )
    {
        return;
    }
    
    if ( !_validate_class( var_a98d07f7a054ff29 ) )
    {
        return;
    }
    
    var_af6e1e5aef347723 = function_cec0ddc6aa999bb0( var_1dffb7e77de42c03 );
    function_bece7f05163201e6( var_a98d07f7a054ff29, activitytype, initfunction, startfunction, var_68f7f0b566dae31a, var_bc1827eb3b5150ce );
    var_89cef73a4891f707 = level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ activitytype ];
    var_89cef73a4891f707.var_97e2cbe01984a6bd[ var_89cef73a4891f707.var_97e2cbe01984a6bd.size ] = var_af6e1e5aef347723.mainfunction;
    var_89cef73a4891f707.var_6b0357727a02cb4d[ var_89cef73a4891f707.var_6b0357727a02cb4d.size ] = var_af6e1e5aef347723.metadatafunction;
    function_3d1ad3edee7fe838( var_a98d07f7a054ff29, activitytype );
}

// Namespace ob_activity_manager
// Params 4, eflags: 0x4
// Checksum 0x83690b9b, Offset: 0x11e4
// Size: 0x80
function private function_1d57c740c0bd12c3( dvarbase, var_a98d07f7a054ff29, var_bd362f977ab5328a, defaultvalue )
{
    value = undefined;
    var_df379b6282a2b743 = undefined;
    
    if ( isdefined( var_bd362f977ab5328a ) )
    {
        var_df379b6282a2b743 = hashcat( dvarbase, "__" + var_a98d07f7a054ff29 + "__" + var_bd362f977ab5328a );
    }
    
    if ( isdvardefined( var_df379b6282a2b743 ) )
    {
        value = getdvarfloat( var_df379b6282a2b743 );
    }
    else
    {
        value = function_f7d298badd5c5b8f( dvarbase, var_a98d07f7a054ff29, defaultvalue );
    }
    
    return value;
}

// Namespace ob_activity_manager
// Params 4, eflags: 0x4
// Checksum 0xb4ace79, Offset: 0x126d
// Size: 0x80
function private function_a5342fe550d1fbe8( dvarbase, var_a98d07f7a054ff29, var_bd362f977ab5328a, defaultvalue )
{
    value = undefined;
    var_df379b6282a2b743 = undefined;
    
    if ( isdefined( var_bd362f977ab5328a ) )
    {
        var_df379b6282a2b743 = hashcat( dvarbase, "__" + var_a98d07f7a054ff29 + "__" + var_bd362f977ab5328a );
    }
    
    if ( isdvardefined( var_df379b6282a2b743 ) )
    {
        value = getdvarint( var_df379b6282a2b743 );
    }
    else
    {
        value = function_a6ff0ad505239c54( dvarbase, var_a98d07f7a054ff29, defaultvalue );
    }
    
    return value;
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0xaba35d36, Offset: 0x12f6
// Size: 0x23
function private function_be8f2a69edf6ba02( dvarbase, var_a98d07f7a054ff29 )
{
    return hashcat( dvarbase, "__" + var_a98d07f7a054ff29 );
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0xa14c0ccd, Offset: 0x1322
// Size: 0x2d
function private function_be02ca693c0bbe5e( var_a98d07f7a054ff29 )
{
    var_254d7dbf64adbfa8 = function_a6ff0ad505239c54( @"hash_79d920728fc09a25", var_a98d07f7a054ff29, 6 );
    return var_254d7dbf64adbfa8;
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0xf0ef2d4d, Offset: 0x1358
// Size: 0x37
function private function_96fd49b5dbd6afc9( var_a98d07f7a054ff29, var_bd362f977ab5328a )
{
    var_26df3c9d271cf039 = function_a5342fe550d1fbe8( @"hash_7ee06cb015cf2d8", var_a98d07f7a054ff29, var_bd362f977ab5328a, 3 );
    return var_26df3c9d271cf039;
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0x8d111525, Offset: 0x1398
// Size: 0x158
function private function_d4ab39b8f502e1e2( var_a98d07f7a054ff29, regiondifficulty )
{
    assert( regiondifficulty == "<dev string:x69>" || regiondifficulty == "<dev string:x79>" || regiondifficulty == "<dev string:x8b>" || regiondifficulty == "<dev string:x9b>" || regiondifficulty == "<dev string:xb1>" || regiondifficulty == "<dev string:xbd>" );
    var_52ad9fadcd05baa5 = 2147483646;
    
    switch ( regiondifficulty )
    {
        case #"hash_7bb2cd766703d463":
            var_52ad9fadcd05baa5 = function_a6ff0ad505239c54( @"hash_7205a8d2fa8a13fa", var_a98d07f7a054ff29, 100 );
            break;
        case #"hash_af83e47edfa8900a":
            var_52ad9fadcd05baa5 = function_a6ff0ad505239c54( @"hash_df5f2e2818b47dbf", var_a98d07f7a054ff29, 100 );
            break;
        case #"hash_5343b465e56ec9a4":
            var_52ad9fadcd05baa5 = function_a6ff0ad505239c54( @"hash_d1954cda398ebe31", var_a98d07f7a054ff29, 100 );
            break;
        case #"hash_651f76c0ad6741ec":
            var_52ad9fadcd05baa5 = function_a6ff0ad505239c54( @"hash_1c179ab570055896", var_a98d07f7a054ff29, 100 );
            break;
        case #"hash_c0250ffc2e87f2ff":
        case #"hash_c02510fc2e87f492":
            var_52ad9fadcd05baa5 = function_a6ff0ad505239c54( @"hash_37f5bcaa84e05026", var_a98d07f7a054ff29, 0 );
            break;
        case #"hash_a1e09f51896088fb":
        default:
            break;
    }
    
    return var_52ad9fadcd05baa5;
}

// Namespace ob_activity_manager
// Params 3, eflags: 0x4
// Checksum 0x5ea7d440, Offset: 0x14f9
// Size: 0x5d
function private function_f7d298badd5c5b8f( dvarbase, var_a98d07f7a054ff29, defaultvalue )
{
    value = undefined;
    var_4dc6c68e22d6c32b = function_be8f2a69edf6ba02( dvarbase, var_a98d07f7a054ff29 );
    
    if ( isdvardefined( var_4dc6c68e22d6c32b ) )
    {
        value = getdvarfloat( var_4dc6c68e22d6c32b );
    }
    else
    {
        value = getdvarfloat( dvarbase, defaultvalue );
    }
    
    return value;
}

// Namespace ob_activity_manager
// Params 3, eflags: 0x4
// Checksum 0x3a7fcd16, Offset: 0x155f
// Size: 0x5d
function private function_a6ff0ad505239c54( dvarbase, var_a98d07f7a054ff29, defaultvalue )
{
    value = undefined;
    var_4dc6c68e22d6c32b = function_be8f2a69edf6ba02( dvarbase, var_a98d07f7a054ff29 );
    
    if ( isdvardefined( var_4dc6c68e22d6c32b ) )
    {
        value = getdvarint( var_4dc6c68e22d6c32b );
    }
    else
    {
        value = getdvarint( dvarbase, defaultvalue );
    }
    
    return value;
}

// Namespace ob_activity_manager
// Params 6
// Checksum 0xcf290c01, Offset: 0x15c5
// Size: 0x18d
function function_bece7f05163201e6( var_a98d07f7a054ff29, var_721de5eb5d674267, initfunction, startfunction, var_68f7f0b566dae31a, var_bc1827eb3b5150ce )
{
    if ( !function_a9e7432e34b70581() )
    {
        return;
    }
    
    if ( !_validate_class( var_a98d07f7a054ff29 ) )
    {
        return;
    }
    
    if ( !isdefined( var_721de5eb5d674267 ) )
    {
        return;
    }
    
    if ( isdefined( initfunction ) && !isfunction( initfunction ) )
    {
        assertmsg( "<dev string:xc9>" + var_721de5eb5d674267 + "<dev string:xd9>" );
        return;
    }
    
    if ( isdefined( var_68f7f0b566dae31a ) && !isfunction( var_68f7f0b566dae31a ) )
    {
        assertmsg( "<dev string:xc9>" + var_721de5eb5d674267 + "<dev string:x10a>" );
        return;
    }
    
    if ( isdefined( var_bc1827eb3b5150ce ) && !isfunction( var_bc1827eb3b5150ce ) )
    {
        assertmsg( "<dev string:xc9>" + var_721de5eb5d674267 + "<dev string:x131>" );
        return;
    }
    
    if ( isdefined( level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ var_721de5eb5d674267 ] ) )
    {
        assertmsg( "<dev string:xc9>" + var_721de5eb5d674267 + "<dev string:x15e>" );
        return;
    }
    
    var_89cef73a4891f707 = spawnstruct();
    var_89cef73a4891f707.initfunction = initfunction;
    var_89cef73a4891f707.startfunction = startfunction;
    var_89cef73a4891f707.var_bc1827eb3b5150ce = var_bc1827eb3b5150ce;
    var_89cef73a4891f707.var_32062ed27d894822 = -1;
    var_89cef73a4891f707.var_97e2cbe01984a6bd = [];
    var_89cef73a4891f707.var_6b0357727a02cb4d = [];
    level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ var_721de5eb5d674267 ] = var_89cef73a4891f707;
    
    /#
        ob_activity_manager_debug::add_debug_activity( var_a98d07f7a054ff29, var_721de5eb5d674267 );
    #/
}

// Namespace ob_activity_manager
// Params 3
// Checksum 0xaea0898c, Offset: 0x175a
// Size: 0xe9
function function_56a218667f3f96b7( var_a98d07f7a054ff29, activitytype, var_1dffb7e77de42c03 )
{
    if ( !function_a9e7432e34b70581() )
    {
        return;
    }
    
    if ( !_validate_class( var_a98d07f7a054ff29 ) )
    {
        return;
    }
    
    var_af6e1e5aef347723 = function_cec0ddc6aa999bb0( var_1dffb7e77de42c03 );
    var_89cef73a4891f707 = level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ activitytype ];
    
    if ( !isdefined( var_89cef73a4891f707 ) )
    {
        ob_register_class( var_a98d07f7a054ff29, activitytype, var_1dffb7e77de42c03 );
        return;
    }
    
    var_89cef73a4891f707.var_97e2cbe01984a6bd[ var_89cef73a4891f707.var_97e2cbe01984a6bd.size ] = var_af6e1e5aef347723.mainfunction;
    var_89cef73a4891f707.var_6b0357727a02cb4d[ var_89cef73a4891f707.var_6b0357727a02cb4d.size ] = var_af6e1e5aef347723.metadatafunction;
    
    if ( isfunction( var_af6e1e5aef347723.mainfunction ) )
    {
        [[ var_af6e1e5aef347723.mainfunction ]]();
    }
}

// Namespace ob_activity_manager
// Params 7
// Checksum 0x2a90d6f1, Offset: 0x184b
// Size: 0xa0
function function_15ff27d10c2b08cf( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf, var_2d78e1bb4b4d8fff, var_f6a14e4d4e4e0a26, locationoverride, sizeoverride )
{
    activityinstance = function_f415a8a4f4089662( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf );
    assert( isdefined( activityinstance ), "<dev string:x17d>" + var_5383457952d414cf );
    
    if ( isdefined( locationoverride ) || isdefined( sizeoverride ) )
    {
        function_fb1f0d8e7ddc7e18( activityinstance, locationoverride, sizeoverride, var_2d78e1bb4b4d8fff );
    }
    
    if ( isdefined( var_f6a14e4d4e4e0a26 ) )
    {
        activityinstance.region = function_92981d14a965df50( activityinstance, var_f6a14e4d4e4e0a26 );
    }
}

// Namespace ob_activity_manager
// Params 4
// Checksum 0x9df5fbf0, Offset: 0x18f3
// Size: 0x1ab, Type: bool
function function_e19e3ac156b8b6c( ActivityTypeName, location, var_d79d0fa3753e4e03, additionalspawndatastruct )
{
    assert( isdefined( ActivityTypeName ) );
    assert( isvector( location ) );
    
    if ( !function_a9e7432e34b70581() )
    {
        return false;
    }
    
    classes = function_13745445d5f57d2a();
    var_ddd1a35588e3c041 = region_difficulty_manager::function_4f8f6054ecabf2dc();
    
    if ( isstring( var_d79d0fa3753e4e03 ) )
    {
        regions = var_ddd1a35588e3c041;
        var_ddd1a35588e3c041 = [];
        
        foreach ( region in regions )
        {
            regiondifficulty = region_difficulty_manager::function_d2213de17e7b3faf( region );
            
            if ( regiondifficulty == var_d79d0fa3753e4e03 )
            {
                var_ddd1a35588e3c041[ var_ddd1a35588e3c041.size ] = region;
            }
        }
    }
    
    var_f58bb2a6013c5b32 = undefined;
    
    foreach ( class in classes )
    {
        var_f58bb2a6013c5b32 = function_6c71eefe2176799e( class, ActivityTypeName, location, var_ddd1a35588e3c041 );
        
        if ( isdefined( var_f58bb2a6013c5b32 ) )
        {
            break;
        }
    }
    
    if ( isdefined( var_f58bb2a6013c5b32 ) )
    {
        level thread function_b3429fd8a4e4d2a3( var_f58bb2a6013c5b32, additionalspawndatastruct );
        return true;
    }
    
    return false;
}

/#

    // Namespace ob_activity_manager
    // Params 4
    // Checksum 0x366d85ea, Offset: 0x1aa7
    // Size: 0xe2, Type: dev
    function ob_force_activity_start( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf, region )
    {
        assert( isdefined( var_a98d07f7a054ff29 ) );
        assert( isdefined( ActivityTypeName ) );
        assert( isdefined( var_5383457952d414cf ) );
        
        if ( !isdefined( region ) )
        {
            region = region_difficulty_manager::get_default_region();
        }
        
        if ( !isdefined( level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ] ) )
        {
            return 0;
        }
        
        activityinstances = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ];
        
        if ( !isdefined( activityinstances ) )
        {
            return 0;
        }
        
        var_657a3abce2509b48 = activityinstances[ var_5383457952d414cf ];
        
        if ( !isdefined( var_657a3abce2509b48 ) )
        {
            return 0;
        }
        
        level thread function_b3429fd8a4e4d2a3( var_657a3abce2509b48 );
        return 1;
    }

#/

// Namespace ob_activity_manager
// Params 4
// Checksum 0x52cce57a, Offset: 0x1b91
// Size: 0x292
function function_2c95c6046bda9988( var_2d78e1bb4b4d8fff, var_f6a14e4d4e4e0a26, locationoverride, sizeoverride )
{
    if ( !function_81e8b9df4d6b3a72() )
    {
        return;
    }
    
    var_a98d07f7a054ff29 = var_2d78e1bb4b4d8fff.activitycategory;
    ActivityTypeName = var_2d78e1bb4b4d8fff.activitytype;
    var_5383457952d414cf = var_2d78e1bb4b4d8fff.var_4312b79c960726b6;
    
    if ( !_validate_class( var_a98d07f7a054ff29 ) )
    {
        return;
    }
    
    if ( !isstring( ActivityTypeName ) )
    {
        assertmsg( "<dev string:x1cd>" );
        return;
    }
    
    activityinstance = spawnstruct();
    activityinstance.class = var_a98d07f7a054ff29;
    activityinstance.name = var_5383457952d414cf;
    activityinstance.type = ActivityTypeName;
    activityinstance.var_32062ed27d894822 = -1;
    activityinstance.var_8d722527cb3b355c = -1;
    activityinstance.var_f82d9f71f1fa1ac9 = 0;
    function_fb1f0d8e7ddc7e18( activityinstance, locationoverride, sizeoverride, var_2d78e1bb4b4d8fff );
    region = function_92981d14a965df50( activityinstance, var_f6a14e4d4e4e0a26 );
    activityinstance.region = region;
    activityinstance.var_7045a7bcdef0ce48 = function_54ee4b43dbe4b005( var_a98d07f7a054ff29, region.index );
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ];
    
    if ( !isdefined( activityinstances ) )
    {
        level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ] = [];
        level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ] = [];
        activityinstances = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ];
    }
    
    if ( isdefined( activityinstances[ var_5383457952d414cf ] ) )
    {
        assertmsg( "<dev string:x1ee>" + var_5383457952d414cf + "<dev string:x201>" + ActivityTypeName + "<dev string:x233>" );
        return;
    }
    
    activityinstances[ var_5383457952d414cf ] = activityinstance;
    level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ] = activityinstances;
    level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ var_5383457952d414cf ] = activityinstance;
    
    if ( activityinstance.class == "Startup" || activityinstance.class == "Story" )
    {
        level thread function_b3429fd8a4e4d2a3( activityinstance, undefined );
    }
}

// Namespace ob_activity_manager
// Params 0
// Checksum 0x67770dcf, Offset: 0x1e2b
// Size: 0x8e
function function_7b19c0b83db8fcdc()
{
    classes = function_13745445d5f57d2a();
    var_f345cc1bc00fb71d = [];
    
    foreach ( class in classes )
    {
        var_f345cc1bc00fb71d[ class ] = [];
    }
    
    return var_f345cc1bc00fb71d;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x72933cb, Offset: 0x1ec2
// Size: 0x97
function private function_a57b5fbcca615d88()
{
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    var_1d54397614cd42a5 = [];
    
    foreach ( region in regions )
    {
        var_1d54397614cd42a5[ region.index ] = [];
    }
    
    return var_1d54397614cd42a5;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0xfb861283, Offset: 0x1f62
// Size: 0x11f
function private function_196fd4f42f17dc99()
{
    classes = function_13745445d5f57d2a();
    all_regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    var_67cd21100243628b = [];
    
    foreach ( class in classes )
    {
        regions = [];
        
        foreach ( region in all_regions )
        {
            regions[ region.index ] = [];
        }
        
        var_67cd21100243628b[ class ] = regions;
    }
    
    return var_67cd21100243628b;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x48deb97d, Offset: 0x208a
// Size: 0xc3
function private function_ab050f76cdf63bea()
{
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    var_401a9a35a15918ba = [];
    
    foreach ( region in regions )
    {
        var_401a9a35a15918ba[ region.index ] = [];
        
        for ( tier = 1; tier <= 4 ; tier++ )
        {
            var_401a9a35a15918ba[ region.index ][ tier ] = 0;
        }
    }
    
    return var_401a9a35a15918ba;
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0xdea1e326, Offset: 0x2156
// Size: 0x7f
function private function_92981d14a965df50( activityinstance, var_f6a14e4d4e4e0a26 )
{
    assert( isstruct( activityinstance ) );
    region = var_f6a14e4d4e4e0a26;
    
    if ( !isdefined( activityinstance.region ) && isdefined( activityinstance.centerpoint ) )
    {
        centroid = activityinstance.centerpoint;
        region = region_difficulty_manager::function_f9fbb630598afdc7( centroid );
    }
    
    if ( !isdefined( region ) )
    {
        region = region_difficulty_manager::get_default_region();
    }
    
    return region;
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0xff28371a, Offset: 0x21de
// Size: 0x10a
function private function_f1e40b54be826049( activityinstance )
{
    assert( isstruct( activityinstance ) );
    var_89cef73a4891f707 = level.var_e607236b193eb0c1.activitydefinitions[ activityinstance.class ][ activityinstance.type ];
    
    if ( !isdefined( var_89cef73a4891f707 ) )
    {
        assertmsg( "<dev string:x236>" + activityinstance.type + "<dev string:x246>" );
        return;
    }
    
    foreach ( var_6b0357727a02cb4d in var_89cef73a4891f707.var_6b0357727a02cb4d )
    {
        instancesmetadata = [[ var_6b0357727a02cb4d ]]();
        
        if ( isdefined( instancesmetadata[ activityinstance.name ] ) )
        {
            return var_6b0357727a02cb4d;
        }
    }
}

// Namespace ob_activity_manager
// Params 4, eflags: 0x4
// Checksum 0x7598280, Offset: 0x22f1
// Size: 0x46d
function private function_fb1f0d8e7ddc7e18( activityinstance, locationoverride, sizeoverride, var_2d78e1bb4b4d8fff )
{
    assert( isstruct( activityinstance ) );
    var_89cef73a4891f707 = level.var_e607236b193eb0c1.activitydefinitions[ activityinstance.class ][ activityinstance.type ];
    
    if ( !isdefined( var_89cef73a4891f707 ) )
    {
        assertmsg( "<dev string:x236>" + activityinstance.type + "<dev string:x246>" );
        return;
    }
    
    activityinstance.scriptbundle = undefined;
    activityinstance.centerpoint = undefined;
    spatial_zone_container::function_389ac59074912882( activityinstance );
    spatial_zone_container::addspatialzone( activityinstance, "OB_Spacer_Spatial_Zone" );
    activity_definition_utils::function_46f5af01b35899df( activityinstance.name, activityinstance, "OB_Spacer_Spatial_Zone" );
    
    if ( isdefined( locationoverride ) )
    {
        if ( !isvector( locationoverride ) )
        {
            assertmsg( "<dev string:x262>" );
            return;
        }
        
        if ( isdefined( sizeoverride ) && !isnumber( sizeoverride ) )
        {
            assertmsg( "<dev string:x28e>" );
            return;
        }
        
        var_c5b49b141a6c558c = sizeoverride;
        
        if ( !isdefined( var_c5b49b141a6c558c ) )
        {
            var_c5b49b141a6c558c = function_f7d298badd5c5b8f( @"hash_7e407689865b2b81", activityinstance.class, 1000 );
        }
        
        activityinstance.centerpoint = locationoverride;
        spatial_zone_container::function_847140d2863dfbf8( activityinstance, "OB_Spacer_Spatial_Zone", locationoverride, var_c5b49b141a6c558c );
        return;
    }
    
    foreach ( var_6b0357727a02cb4d in var_89cef73a4891f707.var_6b0357727a02cb4d )
    {
        instancesmetadata = [[ var_6b0357727a02cb4d ]]();
        
        if ( !isdefined( instancesmetadata ) )
        {
            continue;
        }
        
        instancemetadata = instancesmetadata[ activityinstance.name ];
        
        if ( !isdefined( instancemetadata ) )
        {
            continue;
        }
        
        activityinstance.centerpoint = instancemetadata.scriptstructorigin;
        activityinstance.scriptbundle = instancemetadata.scriptbundle;
        activityinstance.var_265c4f33e2a6daa7 = instancemetadata.var_265c4f33e2a6daa7;
        
        if ( instancemetadata.var_7a0840be22b9ebb )
        {
            activityinstance.var_7a0840be22b9ebb = strtok( instancemetadata.var_7a0840be22b9ebb, "," );
        }
        
        activityinstance.var_622af9ed9146813f = var_2d78e1bb4b4d8fff.var_ec6d64d71dc7a62b;
        activityinstance.var_e43d97c215c8145e = var_2d78e1bb4b4d8fff.var_e43d97c215c8145e ?? 0;
        assert( instancemetadata.locationorigin.size == instancemetadata.var_31ce4477e3543d24.size );
        assert( instancemetadata.locationorigin.size == instancemetadata.var_ccd7cc494eeab31b.size );
        assert( instancemetadata.locationorigin.size == instancemetadata.locationradius.size );
        var_a01d78d3ef03547e = spawnstruct();
        
        for ( index = 0; index < instancemetadata.locationorigin.size ; index++ )
        {
            var_a01d78d3ef03547e.origin = instancemetadata.locationorigin[ index ];
            create_script_utility::translate_and_rotate_from_level_overrides( instancemetadata.cf, var_a01d78d3ef03547e );
            var_168e6029c44150ea = instancemetadata.var_31ce4477e3543d24[ index ] + rotatevector( var_a01d78d3ef03547e.origin, instancemetadata.var_ccd7cc494eeab31b[ index ] );
            var_d5b3fcf33eea3d5e = instancemetadata.locationradius[ index ];
            spatial_zone_container::function_847140d2863dfbf8( activityinstance, "OB_Spacer_Spatial_Zone", var_168e6029c44150ea, var_d5b3fcf33eea3d5e );
        }
        
        spatialzonespheres = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "OB_Spacer_Spatial_Zone" );
        
        if ( spatialzonespheres.size <= 0 )
        {
            var_a01d78d3ef03547e.origin = activityinstance.centerpoint;
            var_a01d78d3ef03547e.angles = ( 0, 0, 0 );
            create_script_utility::translate_position_with_offset_data( instancemetadata.cf, var_a01d78d3ef03547e, instancemetadata.scriptstructoriginoffset, ( 0, 0, 0 ) );
            spatial_zone_container::function_847140d2863dfbf8( activityinstance, "OB_Spacer_Spatial_Zone", var_a01d78d3ef03547e.origin, 1 );
        }
    }
}

// Namespace ob_activity_manager
// Params 3, eflags: 0x4
// Checksum 0x9a59406e, Offset: 0x2766
// Size: 0xfd
function private function_77a9c0451569a88d( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf )
{
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    region = undefined;
    
    foreach ( region in regions )
    {
        if ( isdefined( level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ] ) )
        {
            var_c233e7a3293d7096 = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ][ var_5383457952d414cf ];
            
            if ( isdefined( var_c233e7a3293d7096 ) )
            {
                return region;
            }
        }
    }
}

// Namespace ob_activity_manager
// Params 3, eflags: 0x4
// Checksum 0x71885e8e, Offset: 0x286b
// Size: 0xfd
function private function_8680fceb62b1c6a9( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf )
{
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    region = undefined;
    
    foreach ( region in regions )
    {
        if ( isdefined( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ] ) )
        {
            var_c233e7a3293d7096 = level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ][ var_5383457952d414cf ];
            
            if ( isdefined( var_c233e7a3293d7096 ) )
            {
                return region;
            }
        }
    }
}

// Namespace ob_activity_manager
// Params 1
// Checksum 0x7e44fb8b, Offset: 0x2970
// Size: 0x1f1
function ob_activity_finished( relevantinfostruct )
{
    activityinstance = self;
    var_a98d07f7a054ff29 = activityinstance.category;
    ActivityTypeName = activityinstance.type;
    var_5383457952d414cf = activityinstance.varianttag;
    var_e43d97c215c8145e = ob_activity_definition_utils::function_ee700758cb24d61f( var_5383457952d414cf );
    
    if ( !_validate_class( var_a98d07f7a054ff29 ) )
    {
        return;
    }
    
    if ( !isdefined( function_f415a8a4f4089662( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf ) ) )
    {
        return;
    }
    
    region = function_8680fceb62b1c6a9( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf );
    
    if ( !isdefined( region ) )
    {
        /#
            if ( self.additionalspawndata.var_a460646428aef1f6 )
            {
                return;
            }
        #/
        
        assertmsg( "<dev string:x2b6>" + var_5383457952d414cf + "<dev string:x2da>" );
        return;
    }
    
    activityinstances = level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ];
    
    if ( !isdefined( activityinstances ) || activityinstances.size <= 0 )
    {
        return;
    }
    
    level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ][ var_5383457952d414cf ] = undefined;
    
    if ( var_e43d97c215c8145e > 0 )
    {
        level.var_e607236b193eb0c1.var_92e658dad9b71fad[ region.index ][ var_e43d97c215c8145e ] -= 1;
    }
    
    var_657a3abce2509b48 = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ][ var_5383457952d414cf ];
    
    if ( self.resetcooldown )
    {
        self.resetcooldown = undefined;
        var_657a3abce2509b48.var_8d722527cb3b355c = -1;
        return;
    }
    
    var_657a3abce2509b48.var_8d722527cb3b355c = gettime();
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0x261f33c1, Offset: 0x2b69
// Size: 0x94
function private function_54ee4b43dbe4b005( var_a98d07f7a054ff29, var_bd362f977ab5328a )
{
    var_dd9ba9d7ea4d8fc1 = function_a5342fe550d1fbe8( @"hash_f87b20273f0955f0", var_a98d07f7a054ff29, var_bd362f977ab5328a, 10000000 );
    var_e759047d9c5a8a7 = function_a5342fe550d1fbe8( @"hash_d431c6b00b5d6b2a", var_a98d07f7a054ff29, var_bd362f977ab5328a, 10000000 );
    
    if ( var_e759047d9c5a8a7 < 0 )
    {
        assertmsg( "<dev string:x2f8>" );
        var_e759047d9c5a8a7 = 0;
    }
    
    if ( var_dd9ba9d7ea4d8fc1 < 0 )
    {
        var_dd9ba9d7ea4d8fc1 = 2147483646;
    }
    
    if ( var_dd9ba9d7ea4d8fc1 < var_e759047d9c5a8a7 )
    {
        var_dd9ba9d7ea4d8fc1 = var_e759047d9c5a8a7;
    }
    
    return randomintrange( var_e759047d9c5a8a7, var_dd9ba9d7ea4d8fc1 + 1 );
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0xd4827b94, Offset: 0x2c06
// Size: 0xbc, Type: bool
function private _validate_class( var_a98d07f7a054ff29 )
{
    if ( !isdefined( var_a98d07f7a054ff29 ) )
    {
        assertmsg( "<dev string:x326>" );
        return false;
    }
    
    var_d3bb36ae177d0ea8 = function_13745445d5f57d2a();
    
    foreach ( var_1ecf3a2b4c40496c in var_d3bb36ae177d0ea8 )
    {
        if ( var_a98d07f7a054ff29 == var_1ecf3a2b4c40496c )
        {
            return true;
        }
    }
    
    assertmsg( "<dev string:x343>" + var_a98d07f7a054ff29 + "<dev string:x354>" );
    return false;
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x8ad4de44, Offset: 0x2ccb
// Size: 0x4b
function private function_cec0ddc6aa999bb0( var_1dffb7e77de42c03 )
{
    if ( !isfunction( var_1dffb7e77de42c03 ) )
    {
        assertmsg( "<dev string:x380>" );
        return;
    }
    
    var_af6e1e5aef347723 = [[ var_1dffb7e77de42c03 ]]();
    
    if ( !isdefined( var_af6e1e5aef347723 ) )
    {
        assertmsg( "<dev string:x3c8>" );
        return;
    }
    
    return var_af6e1e5aef347723;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x5363d897, Offset: 0x2d1f
// Size: 0x2d, Type: bool
function private function_a9e7432e34b70581()
{
    if ( !function_81e8b9df4d6b3a72() )
    {
        return false;
    }
    
    if ( !isdefined( level.var_e607236b193eb0c1 ) )
    {
        assertmsg( "<dev string:x409>" );
        return false;
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0x5423418, Offset: 0x2d55
// Size: 0xcc
function private function_3d1ad3edee7fe838( var_a98d07f7a054ff29, ActivityTypeName )
{
    var_89cef73a4891f707 = level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ ActivityTypeName ];
    
    if ( !isdefined( var_89cef73a4891f707 ) )
    {
        assertmsg( "<dev string:xc9>" + ActivityTypeName + "<dev string:x432>" );
        return;
    }
    
    foreach ( mainfunction in var_89cef73a4891f707.var_97e2cbe01984a6bd )
    {
        [[ mainfunction ]]();
    }
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xa6586728, Offset: 0x2e29
// Size: 0x1e
function ob_activity_instance_init( var_657a3abce2509b48, additionalspawndatastruct )
{
    return function_b3429fd8a4e4d2a3( var_657a3abce2509b48, additionalspawndatastruct );
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0x23cba8e0, Offset: 0x2e50
// Size: 0x35
function private function_1b1c11f8dfc0317b( var_657a3abce2509b48, additionalspawndatastruct )
{
    waittillframeend();
    
    if ( isdefined( level.var_96bcabbf9556147 ) )
    {
        if ( level.var_96bcabbf9556147 == gettime() )
        {
            waitframe();
        }
    }
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0x80ecb4d8, Offset: 0x2e8d
// Size: 0x44c
function private function_b3429fd8a4e4d2a3( var_657a3abce2509b48, additionalspawndatastruct )
{
    assert( isstruct( var_657a3abce2509b48 ) );
    var_a98d07f7a054ff29 = var_657a3abce2509b48.class;
    activitytype = var_657a3abce2509b48.type;
    activityname = var_657a3abce2509b48.name;
    var_e84f1e412814518f = var_657a3abce2509b48.region;
    var_e43d97c215c8145e = var_657a3abce2509b48.var_e43d97c215c8145e;
    
    if ( isdefined( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ var_e84f1e412814518f.index ][ activitytype ][ activityname ] ) )
    {
        return;
    }
    
    waitframe();
    
    if ( !additionalspawndatastruct.var_e206e40c465fa7bd && !ob_resource_manager::function_343895fa5dadad10( var_a98d07f7a054ff29, activitytype, activityname, var_657a3abce2509b48.var_622af9ed9146813f.activityresources ) )
    {
        return;
    }
    
    function_1b1c11f8dfc0317b( var_657a3abce2509b48, additionalspawndatastruct );
    var_af6e1e5aef347723 = level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ activitytype ];
    level.var_e607236b193eb0c1.activitydefinitions[ var_a98d07f7a054ff29 ][ activitytype ].var_32062ed27d894822 = gettime();
    activityinstance = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ var_e84f1e412814518f.index ][ activitytype ][ activityname ];
    activityinstance.var_32062ed27d894822 = gettime();
    activityinstance.var_f82d9f71f1fa1ac9++;
    level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ var_e84f1e412814518f.index ][ activitytype ][ activityname ] = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ var_e84f1e412814518f.index ][ activitytype ][ activityname ];
    
    if ( isdefined( var_af6e1e5aef347723.startfunction ) )
    {
        var_49b766acb5226cde = function_f1e40b54be826049( activityinstance );
        params = [ var_657a3abce2509b48.type, var_657a3abce2509b48.name, var_657a3abce2509b48.class ];
        
        if ( isdefined( additionalspawndatastruct ) )
        {
            params[ params.size ] = additionalspawndatastruct;
        }
        
        activityinstance = [[ var_af6e1e5aef347723.startfunction ]]( var_49b766acb5226cde, params );
        
        if ( isdefined( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ var_e84f1e412814518f.index ][ activitytype ][ activityname ] ) )
        {
            level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ var_e84f1e412814518f.index ][ activitytype ][ activityname ].lastid = activityinstance.id;
        }
    }
    
    namespace_7aeb49bf61a4f83a::function_aa43680a6e4d0721( "Spawned new activity instance.", @"hash_2d8c42c7641d527", var_657a3abce2509b48 );
    
    if ( var_e43d97c215c8145e > 0 )
    {
        level.var_e607236b193eb0c1.var_92e658dad9b71fad[ var_e84f1e412814518f.index ][ var_e43d97c215c8145e ] += 1;
        
        if ( getdvarint( @"hash_733e510cb68e45a1", 1 ) )
        {
            var_8b0a1553565f4536 = getdvar( hashcat( @"hash_e416f82022e32c4a", var_e84f1e412814518f.index, "_max_instances_activity_difficulty_tier_", var_e43d97c215c8145e ), "" );
            
            if ( var_8b0a1553565f4536 != "" )
            {
                var_8b0a1553565f4536 = "/" + var_8b0a1553565f4536;
            }
            
            var_a937cda110793f16 = getdvar( hashcat( @"hash_cc6d5154c4d9290e", var_e43d97c215c8145e ), "" );
            
            if ( var_a937cda110793f16 != "" )
            {
                var_a937cda110793f16 = "/" + var_a937cda110793f16;
            }
            
            var_eda2dbafe5260f45 = level.var_e607236b193eb0c1.var_92e658dad9b71fad[ var_e84f1e412814518f.index ][ var_e43d97c215c8145e ];
            var_e013207b3b428a9b = function_10ae92df5d46df01( var_e43d97c215c8145e );
            var_cba75da6851bf256 = var_eda2dbafe5260f45 + var_8b0a1553565f4536 + " instances of Activity Difficulty Tier " + var_e43d97c215c8145e + " spawned in region " + var_e84f1e412814518f.index + ". " + var_e013207b3b428a9b + var_a937cda110793f16 + " instances of Activity Difficulty Tier " + var_e43d97c215c8145e + " spawned globally. ";
            namespace_7aeb49bf61a4f83a::function_aa43680a6e4d0721( var_cba75da6851bf256, @"hash_733e510cb68e45a1", var_657a3abce2509b48 );
        }
    }
    
    return activityinstance;
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0xb816077, Offset: 0x32e2
// Size: 0x2d
function private function_3fc14e8386bb137( var_a98d07f7a054ff29 )
{
    isenabled = function_a6ff0ad505239c54( @"hash_f599645d1543dcbe", var_a98d07f7a054ff29, 1 );
    return isenabled;
}

// Namespace ob_activity_manager
// Params 3, eflags: 0x4
// Checksum 0xcd9849c9, Offset: 0x3318
// Size: 0xd0
function private function_f415a8a4f4089662( var_a98d07f7a054ff29, ActivityTypeName, var_5383457952d414cf )
{
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    
    foreach ( region in regions )
    {
        activityinstance = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ ActivityTypeName ][ var_5383457952d414cf ];
        
        if ( activityinstance )
        {
            return activityinstance;
        }
    }
}

// Namespace ob_activity_manager
// Params 1
// Checksum 0xaf9fd49c, Offset: 0x33f0
// Size: 0xeb
function function_ed1dae3a9cce08d2( var_5383457952d414cf )
{
    activityinstance = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ var_5383457952d414cf ];
    
    if ( activityinstance )
    {
        var_4fe2d491bc9efbff = [];
        
        if ( activityinstance.var_7a0840be22b9ebb )
        {
            foreach ( var_fb036157507f5d05 in activityinstance.var_7a0840be22b9ebb )
            {
                var_4b1d5ef29e1e4b76 = level.var_e607236b193eb0c1.var_5992a4946aeeca5a[ var_fb036157507f5d05 ];
                
                if ( var_4b1d5ef29e1e4b76 )
                {
                    var_4fe2d491bc9efbff[ var_4fe2d491bc9efbff.size ] = var_4b1d5ef29e1e4b76;
                }
            }
        }
        
        return var_4fe2d491bc9efbff;
    }
}

// Namespace ob_activity_manager
// Params 3
// Checksum 0xda10873a, Offset: 0x34e3
// Size: 0xe5
function function_8c2371421d37415a( var_657a3abce2509b48, chance, additionalspawndatastruct )
{
    if ( var_657a3abce2509b48 )
    {
        var_f24623451d61a727 = randomint( 100 ) + 1;
        chance = clamp( chance, 0, 100 );
        
        /#
            ignorechance = getdvarint( @"hash_4057cbd604545aa8", 0 );
            chance = ignorechance == 0 ? chance : 100;
        #/
        
        if ( chance < var_f24623451d61a727 )
        {
            namespace_7aeb49bf61a4f83a::function_aa43680a6e4d0721( "Failed spawn linked activity chance not meet", @"hash_2d8c42c7641d527", var_657a3abce2509b48 );
            return;
        }
        
        var_86d07e23a66ab52d = level.var_e607236b193eb0c1.var_de6931c1cb8076f1;
        var_ac3df33fdf29bc45 = conditional_container::function_33051347e9187361( var_86d07e23a66ab52d, var_657a3abce2509b48 );
        
        if ( !var_ac3df33fdf29bc45 )
        {
            namespace_7aeb49bf61a4f83a::function_aa43680a6e4d0721( "Failed spawn linked activity, the activity might already running or resource constrained", @"hash_2d8c42c7641d527", var_657a3abce2509b48 );
            return;
        }
        
        return function_b3429fd8a4e4d2a3( var_657a3abce2509b48, additionalspawndatastruct );
    }
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x88998560, Offset: 0x35d0
// Size: 0xb8
function private function_10ae92df5d46df01( tier )
{
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    var_fd2f2f653c99baf5 = 0;
    
    foreach ( region in region )
    {
        var_fd2f2f653c99baf5 += level.var_e607236b193eb0c1.var_92e658dad9b71fad[ region.index ][ tier ];
    }
    
    return var_fd2f2f653c99baf5;
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0x304517a5, Offset: 0x3691
// Size: 0xc7
function private function_b522153328a36c33( var_a98d07f7a054ff29, var_bd362f977ab5328a )
{
    if ( !isdefined( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ var_bd362f977ab5328a ] ) )
    {
        return 0;
    }
    
    var_fbc3706d929f5c30 = 0;
    
    foreach ( var_57f9634a241d9e5d in level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ var_bd362f977ab5328a ] )
    {
        var_fbc3706d929f5c30 += var_57f9634a241d9e5d.size;
    }
    
    return var_fbc3706d929f5c30;
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0x36aae177, Offset: 0x3761
// Size: 0x212
function private function_69a61f9d7cbfc28f( var_a98d07f7a054ff29, regions )
{
    regionsspread = [];
    var_ff29e9ab3f2a4ac1 = [];
    maxcount = 0;
    
    foreach ( region in regions )
    {
        var_da8ab8eec6dcaddf = level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ];
        var_8076e13d36c9df7e = 0;
        
        foreach ( activityinstances in var_da8ab8eec6dcaddf )
        {
            var_8076e13d36c9df7e += activityinstances.size;
        }
        
        var_48e5971cf23beeb2 = var_ff29e9ab3f2a4ac1[ var_8076e13d36c9df7e ];
        
        if ( !isdefined( var_48e5971cf23beeb2 ) )
        {
            var_48e5971cf23beeb2 = [];
        }
        
        var_48e5971cf23beeb2[ var_48e5971cf23beeb2.size ] = region;
        var_ff29e9ab3f2a4ac1[ var_8076e13d36c9df7e ] = var_48e5971cf23beeb2;
        
        if ( var_8076e13d36c9df7e > maxcount )
        {
            maxcount = var_8076e13d36c9df7e;
        }
    }
    
    for ( index = 0; index <= maxcount ; index++ )
    {
        var_b109362b8df195d1 = var_ff29e9ab3f2a4ac1[ index ];
        
        if ( !isdefined( var_b109362b8df195d1 ) )
        {
            continue;
        }
        
        var_b109362b8df195d1 = arrayrandomize( var_b109362b8df195d1 );
        
        foreach ( region in var_b109362b8df195d1 )
        {
            regionsspread[ regionsspread.size ] = region;
        }
    }
    
    return regionsspread;
}

// Namespace ob_activity_manager
// Params 1
// Checksum 0xd4fa4661, Offset: 0x397c
// Size: 0x14
function function_7e9301d7a4c4306b( var_a98d07f7a054ff29 )
{
    return function_2cbbbbd56ae21b8a( var_a98d07f7a054ff29 );
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x541c1e40, Offset: 0x3999
// Size: 0x74b
function private function_2cbbbbd56ae21b8a( var_a98d07f7a054ff29 )
{
    /#
        debugspawn = function_a6ff0ad505239c54( @"am_debug_spawn", var_a98d07f7a054ff29, 0 );
        var_1dcb45307bd9cabd = "<dev string:x444>" + var_a98d07f7a054ff29 + "<dev string:x446>";
    #/
    
    regions = undefined;
    var_7e43cc5c8febf22d = function_a6ff0ad505239c54( @"hash_ae5eaee208c0e4ed", var_a98d07f7a054ff29, 0 );
    
    if ( var_7e43cc5c8febf22d > 0 )
    {
        regions = function_69a61f9d7cbfc28f( var_a98d07f7a054ff29, region_difficulty_manager::function_4f8f6054ecabf2dc() );
    }
    else
    {
        regions = region_difficulty_manager::get_regions_randomized();
    }
    
    waitframe();
    
    /#
        if ( debugspawn )
        {
            println( var_1dcb45307bd9cabd + "<dev string:x44e>" );
            println( var_1dcb45307bd9cabd + "<dev string:x46a>" );
            
            foreach ( region in regions )
            {
                println( var_1dcb45307bd9cabd + "<dev string:x473>" + getxhashsourcename( region.name ) );
            }
        }
    #/
    
    var_e9ae32332b932ccd = level.var_e607236b193eb0c1.var_c766f06b2812bf7a;
    
    foreach ( region in regions )
    {
        regioninformation = { #activitycategory:var_a98d07f7a054ff29, #region:region };
        
        if ( debugspawn )
        {
            conditionresult = conditional_container::function_fc04dbbd557e99c1( var_e9ae32332b932ccd, regioninformation );
            var_c1e588efc17a1e3c = conditionresult.var_2060d7fd72693be3;
            
            /#
                regionname = getxhashsourcename( region.name );
                
                if ( var_c1e588efc17a1e3c )
                {
                    println( var_1dcb45307bd9cabd + "<dev string:x481>" + regionname + "<dev string:x489>" );
                }
                else
                {
                    println( var_1dcb45307bd9cabd + "<dev string:x481>" + regionname + "<dev string:x491>" + conditionresult.var_59e679186bcfdb0f );
                }
            #/
        }
        else
        {
            var_c1e588efc17a1e3c = conditional_container::function_33051347e9187361( var_e9ae32332b932ccd, regioninformation );
        }
        
        waitframe();
        
        if ( !var_c1e588efc17a1e3c )
        {
            continue;
        }
        
        var_f2f90b67b02187a4 = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ];
        
        if ( !isdefined( var_f2f90b67b02187a4 ) )
        {
            continue;
        }
        
        var_93dfdf8e6abcde58 = level.var_e607236b193eb0c1.var_d6a1cfbd96259eca;
        var_356dd50c2d0ca06f = [];
        
        for ( i = 0; i < var_f2f90b67b02187a4.size ; i++ )
        {
            var_356dd50c2d0ca06f[ var_356dd50c2d0ca06f.size ] = getarraykey( var_f2f90b67b02187a4, i );
        }
        
        if ( var_356dd50c2d0ca06f.size > 1 )
        {
            var_356dd50c2d0ca06f = arrayrandomize( var_356dd50c2d0ca06f );
        }
        
        /#
            if ( debugspawn )
            {
                println( var_1dcb45307bd9cabd + "<dev string:x4a4>" );
                
                foreach ( typekey in var_356dd50c2d0ca06f )
                {
                    println( var_1dcb45307bd9cabd + "<dev string:x4b4>" + typekey );
                }
            }
        #/
        
        foreach ( typekey in var_356dd50c2d0ca06f )
        {
            activityinstances = var_f2f90b67b02187a4[ typekey ];
            var_cce758510a6ac8d3 = { #activitycategory:var_a98d07f7a054ff29, #region:region, #activitytype:typekey };
            
            if ( debugspawn )
            {
                conditionresult = conditional_container::function_fc04dbbd557e99c1( var_93dfdf8e6abcde58, var_cce758510a6ac8d3 );
                istypevalid = conditionresult.var_2060d7fd72693be3;
                
                /#
                    if ( istypevalid )
                    {
                        println( var_1dcb45307bd9cabd + "<dev string:x4c8>" + typekey + "<dev string:x4d9>" + regionname + "<dev string:x4e9>" );
                    }
                    else
                    {
                        println( var_1dcb45307bd9cabd + "<dev string:x4c8>" + typekey + "<dev string:x4d9>" + regionname + "<dev string:x4f3>" + conditionresult.var_59e679186bcfdb0f );
                    }
                #/
            }
            else
            {
                istypevalid = conditional_container::function_33051347e9187361( var_93dfdf8e6abcde58, var_cce758510a6ac8d3 );
            }
            
            if ( !istypevalid )
            {
                continue;
            }
            
            waitframe();
            instances = activityinstances;
            var_4125b1e306ae4f9d = arrayrandomize( getarraykeys( instances ) );
            
            if ( var_4125b1e306ae4f9d.size <= 0 )
            {
                continue;
            }
            
            var_5664f3150a594124 = [];
            var_cfeca12531a2f64e = level.var_e607236b193eb0c1.var_f1f909264aebf6e3;
            
            foreach ( instancekey in var_4125b1e306ae4f9d )
            {
                instance = instances[ instancekey ];
                
                if ( debugspawn )
                {
                    conditionresult = conditional_container::function_fc04dbbd557e99c1( var_cfeca12531a2f64e, instance );
                    var_ac3df33fdf29bc45 = conditionresult.var_2060d7fd72693be3;
                    
                    /#
                        if ( var_ac3df33fdf29bc45 )
                        {
                            println( var_1dcb45307bd9cabd + "<dev string:x508>" + instancekey + "<dev string:x4d9>" + regionname + "<dev string:x4e9>" );
                        }
                        else
                        {
                            println( var_1dcb45307bd9cabd + "<dev string:x508>" + instancekey + "<dev string:x4d9>" + regionname + "<dev string:x51d>" + conditionresult.var_59e679186bcfdb0f );
                            
                            if ( isdefined( instance.overlapping_activity_name ) )
                            {
                                println( var_1dcb45307bd9cabd + "<dev string:x508>" + instancekey + "<dev string:x4d9>" + regionname + "<dev string:x533>" + instance.overlapping_activity_name );
                            }
                        }
                    #/
                }
                else
                {
                    var_ac3df33fdf29bc45 = conditional_container::function_33051347e9187361( var_cfeca12531a2f64e, instance );
                }
                
                if ( var_ac3df33fdf29bc45 )
                {
                    var_5664f3150a594124[ instancekey ] = instance;
                }
            }
            
            if ( var_5664f3150a594124.size > 0 )
            {
                var_79108722e5a98250 = randomint( var_5664f3150a594124.size );
                instancekey = getarraykey( var_5664f3150a594124, var_79108722e5a98250 );
                
                if ( isdefined( instancekey ) )
                {
                    /#
                        if ( debugspawn )
                        {
                            println( var_1dcb45307bd9cabd + "<dev string:x54b>" + var_5664f3150a594124.size + "<dev string:x553>" + typekey + "<dev string:x569>" + getxhashsourcename( region.name ) + "<dev string:x575>" + var_79108722e5a98250 + "<dev string:x584>" + instancekey );
                            
                            foreach ( var_8d15e04f58e6b0d in var_5664f3150a594124 )
                            {
                                println( var_1dcb45307bd9cabd + "<dev string:x58b>" + var_8d15e04f58e6b0d.name );
                            }
                        }
                    #/
                    
                    return instances[ instancekey ];
                }
            }
        }
    }
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0xbf7cadb2, Offset: 0x40ec
// Size: 0x1f6, Type: bool
function private function_cb0eb8f245734349( var_a98d07f7a054ff29 )
{
    if ( level.var_bb86f77304f193c4.var_5c5f90897278618 )
    {
        return false;
    }
    
    runningactivities = 0;
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    
    foreach ( region in regions )
    {
        if ( !isdefined( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ] ) )
        {
            continue;
        }
        
        var_f2f90b67b02187a4 = getarraykeys( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ] );
        
        foreach ( activitytype in var_f2f90b67b02187a4 )
        {
            runningactivities += level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ activitytype ].size;
        }
    }
    
    var_d34d254912a9353a = function_a6ff0ad505239c54( @"hash_e8e7ed44b0e01db", var_a98d07f7a054ff29, -1 );
    
    if ( var_d34d254912a9353a < 0 )
    {
        var_d34d254912a9353a = 2147483647;
    }
    
    var_254d7dbf64adbfa8 = function_be02ca693c0bbe5e( var_a98d07f7a054ff29 );
    
    if ( var_254d7dbf64adbfa8 < 0 )
    {
        return true;
    }
    
    if ( var_d34d254912a9353a < var_254d7dbf64adbfa8 )
    {
        assertmsg( "<dev string:x59b>" );
        var_d34d254912a9353a = var_254d7dbf64adbfa8;
    }
    
    return runningactivities < var_254d7dbf64adbfa8;
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x18ede724, Offset: 0x42eb
// Size: 0x24d
function private function_89574e3bea86227e( var_a98d07f7a054ff29 )
{
    var_5cb113736e5dbd70 = function_a6ff0ad505239c54( @"hash_1f77ee2c5138ab84", var_a98d07f7a054ff29, 0 );
    
    if ( var_5cb113736e5dbd70 != 1 )
    {
        return;
    }
    
    if ( !isdefined( level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ] ) )
    {
        return;
    }
    
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    
    foreach ( region in regions )
    {
        var_57f9634a241d9e5d = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ];
        var_f2f90b67b02187a4 = getarraykeys( var_57f9634a241d9e5d );
        
        foreach ( activitytype in var_f2f90b67b02187a4 )
        {
            instances = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ activitytype ];
            var_559750d3b21f479f = level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ activitytype ];
            
            if ( instances.size == var_559750d3b21f479f.size )
            {
                continue;
            }
            
            foreach ( var_4312b79c960726b6, instanceinfo in instances )
            {
                if ( !( isdefined( var_559750d3b21f479f ) && isdefined( var_559750d3b21f479f[ var_4312b79c960726b6 ] ) ) )
                {
                    return instanceinfo;
                }
            }
        }
    }
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0x844f9c49, Offset: 0x4540
// Size: 0x257
function private function_64da32530f0a2808( var_a98d07f7a054ff29 )
{
    var_f3b59315a7a44ac6 = getdvar( @"hash_71a5c2a0d6091580", "" );
    
    if ( var_f3b59315a7a44ac6 == "" )
    {
        return;
    }
    
    var_ca5c607eb98cfd1c = strtoksubstr( var_f3b59315a7a44ac6, "__" );
    
    if ( var_ca5c607eb98cfd1c.size != 3 )
    {
        /#
            if ( var_ca5c607eb98cfd1c.size > 3 )
            {
                iprintlnbold( "<dev string:x5de>" );
            }
            else
            {
                iprintlnbold( "<dev string:x609>" );
            }
        #/
        
        setdvar( @"hash_71a5c2a0d6091580", "" );
        return;
    }
    
    var_44399fe975d0b986 = var_ca5c607eb98cfd1c[ 0 ];
    var_1df6cfd820732cd5 = var_ca5c607eb98cfd1c[ 1 ];
    var_32acbb46af81233a = var_ca5c607eb98cfd1c[ 2 ];
    region = function_77a9c0451569a88d( var_44399fe975d0b986, var_1df6cfd820732cd5, var_32acbb46af81233a );
    
    if ( var_44399fe975d0b986 != var_a98d07f7a054ff29 )
    {
        var_7064303b836db55 = function_13745445d5f57d2a();
        var_1ecf3a2b4c40496c = 0;
        
        foreach ( var_a3652eefcd0082fd in var_7064303b836db55 )
        {
            if ( var_44399fe975d0b986 == var_a3652eefcd0082fd )
            {
                var_1ecf3a2b4c40496c = 1;
                break;
            }
        }
        
        if ( !var_1ecf3a2b4c40496c )
        {
            /#
                iprintlnbold( "<dev string:x634>" + var_44399fe975d0b986 + "<dev string:x658>" );
            #/
            
            setdvar( @"hash_71a5c2a0d6091580", "" );
            return;
        }
    }
    
    setdvar( @"hash_71a5c2a0d6091580", "" );
    
    if ( !isdefined( level.var_e607236b193eb0c1.activityinstances[ var_44399fe975d0b986 ] ) )
    {
        /#
            iprintlnbold( "<dev string:x65a>" );
        #/
        
        return;
    }
    
    if ( !isdefined( level.var_e607236b193eb0c1.activityinstances[ var_44399fe975d0b986 ][ region.index ][ var_1df6cfd820732cd5 ] ) )
    {
        /#
            iprintlnbold( "<dev string:x68f>" );
        #/
        
        return;
    }
    
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ var_44399fe975d0b986 ][ region.index ][ var_1df6cfd820732cd5 ];
    var_657a3abce2509b48 = activityinstances[ var_32acbb46af81233a ];
    
    if ( !isdefined( var_657a3abce2509b48 ) )
    {
        /#
            iprintlnbold( "<dev string:x6bd>" );
        #/
        
        return;
    }
    
    return var_657a3abce2509b48;
}

// Namespace ob_activity_manager
// Params 1, eflags: 0x4
// Checksum 0xe0aba521, Offset: 0x47a0
// Size: 0xa4
function private function_39b6fb4bbf2b1513( var_a98d07f7a054ff29 )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait function_f7d298badd5c5b8f( @"am_rate", var_a98d07f7a054ff29, 10 );
        
        if ( !function_81e8b9df4d6b3a72() )
        {
            waitframe();
            continue;
        }
        
        var_657a3abce2509b48 = function_64da32530f0a2808( var_a98d07f7a054ff29 );
        
        if ( !isdefined( var_657a3abce2509b48 ) )
        {
            var_657a3abce2509b48 = function_89574e3bea86227e( var_a98d07f7a054ff29 );
        }
        
        waitframe();
        
        if ( isdefined( var_657a3abce2509b48 ) )
        {
            level thread function_b3429fd8a4e4d2a3( var_657a3abce2509b48 );
            continue;
        }
        
        if ( !function_cb0eb8f245734349( var_a98d07f7a054ff29 ) )
        {
            continue;
        }
        
        waitframe();
        var_657a3abce2509b48 = function_2cbbbbd56ae21b8a( var_a98d07f7a054ff29 );
        waitframe();
        
        if ( isdefined( var_657a3abce2509b48 ) )
        {
            level thread function_b3429fd8a4e4d2a3( var_657a3abce2509b48 );
        }
    }
}

// Namespace ob_activity_manager
// Params 4, eflags: 0x4
// Checksum 0x368462d0, Offset: 0x484c
// Size: 0x32a
function private function_6c71eefe2176799e( var_a98d07f7a054ff29, activitytype, origin, var_b2c9890335a0b8ef )
{
    if ( !isvector( origin ) )
    {
        assert( 0 );
        return;
    }
    
    if ( !function_a9e7432e34b70581() )
    {
        return;
    }
    
    closestdistancesq = undefined;
    var_d37e5b51f53a0b1f = undefined;
    var_f2f90b67b02187a4 = [];
    
    if ( isdefined( activitytype ) )
    {
        var_f2f90b67b02187a4[ var_f2f90b67b02187a4.size ] = activitytype;
    }
    
    regions = var_b2c9890335a0b8ef;
    
    if ( !isdefined( regions ) )
    {
        regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    }
    
    foreach ( region in regions )
    {
        if ( !isdefined( activitytype ) )
        {
            var_f2f90b67b02187a4 = getarraykeys( level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ] );
            
            if ( !isdefined( var_f2f90b67b02187a4 ) )
            {
                continue;
            }
        }
        
        foreach ( var_45ac3000ceffe826 in var_f2f90b67b02187a4 )
        {
            activityinstances = level.var_e607236b193eb0c1.activityinstances[ var_a98d07f7a054ff29 ][ region.index ][ var_45ac3000ceffe826 ];
            
            if ( !isdefined( activityinstances ) )
            {
                continue;
            }
            
            foreach ( var_5383457952d414cf, activityinstance in activityinstances )
            {
                if ( isdefined( level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ var_45ac3000ceffe826 ][ var_5383457952d414cf ] ) )
                {
                    continue;
                }
                
                spatialzonespheres = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "OB_Spacer_Spatial_Zone" );
                
                foreach ( SpatialZoneSphere in spatialzonespheres )
                {
                    var_f84a31ea6323aac = distancesquared( origin, SpatialZoneSphere.origin );
                    
                    if ( !isdefined( closestdistancesq ) || var_f84a31ea6323aac < closestdistancesq )
                    {
                        closestdistancesq = var_f84a31ea6323aac;
                        var_d37e5b51f53a0b1f = activityinstance;
                    }
                }
                
                if ( spatialzonespheres.size == 0 && !isdefined( var_d37e5b51f53a0b1f ) )
                {
                    var_d37e5b51f53a0b1f = activityinstance;
                }
            }
        }
    }
    
    return var_d37e5b51f53a0b1f;
}

// Namespace ob_activity_manager
// Params 4
// Checksum 0xecaca920, Offset: 0x4b7f
// Size: 0x244
function function_e0c270f0210ea2c5( var_a98d07f7a054ff29, activitytype, origin, var_b2c9890335a0b8ef )
{
    if ( !isvector( origin ) )
    {
        assert( 0 );
        return;
    }
    
    if ( !function_a9e7432e34b70581() )
    {
        return;
    }
    
    closestdistancesq = undefined;
    var_d37e5b51f53a0b1f = undefined;
    regions = var_b2c9890335a0b8ef;
    
    if ( !isdefined( regions ) )
    {
        regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    }
    
    foreach ( region in regions )
    {
        var_559750d3b21f479f = level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_a98d07f7a054ff29 ][ region.index ][ activitytype ];
        
        if ( !isdefined( var_559750d3b21f479f ) )
        {
            continue;
        }
        
        foreach ( activityinstance in var_559750d3b21f479f )
        {
            spatialzonespheres = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "OB_Spacer_Spatial_Zone" );
            
            foreach ( SpatialZoneSphere in spatialzonespheres )
            {
                var_f84a31ea6323aac = distancesquared( origin, SpatialZoneSphere.origin );
                
                if ( !isdefined( closestdistancesq ) || var_f84a31ea6323aac < closestdistancesq )
                {
                    closestdistancesq = var_f84a31ea6323aac;
                    var_d37e5b51f53a0b1f = activityinstance;
                }
            }
            
            if ( spatialzonespheres.size == 0 && !isdefined( var_d37e5b51f53a0b1f ) )
            {
                var_d37e5b51f53a0b1f = activityinstance;
            }
        }
    }
    
    return var_d37e5b51f53a0b1f;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x5d81c096, Offset: 0x4dcc
// Size: 0x47
function private function_56eb4b011cefcdc3()
{
    var_c766f06b2812bf7a = spawnstruct();
    var_c766f06b2812bf7a conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( var_c766f06b2812bf7a, &function_290fd9d1571ee2c7, [], undefined, "region not at difficulty group activity limit" );
    conditional_container::addcondition( var_c766f06b2812bf7a, &function_83a4a528124545cd, [], undefined, "region not at activity limit" );
    return var_c766f06b2812bf7a;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x37c2c71a, Offset: 0x4e1c
// Size: 0x99, Type: bool
function function_290fd9d1571ee2c7( regioninformation, params )
{
    region = regioninformation.region;
    activitycategory = regioninformation.activitycategory;
    regiondifficulty = region_difficulty_manager::function_d2213de17e7b3faf( region );
    
    if ( regiondifficulty != "difficulty_undefined" )
    {
        var_c01e20158626cb33 = function_d4ab39b8f502e1e2( activitycategory, regiondifficulty );
        var_5c93774efbec0ec5 = function_b522153328a36c33( activitycategory, region.index );
        
        if ( var_5c93774efbec0ec5 >= var_c01e20158626cb33 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xc2769d91, Offset: 0x4ebe
// Size: 0x8f, Type: bool
function function_83a4a528124545cd( regioninformation, params )
{
    region = regioninformation.region;
    activitycategory = regioninformation.activitycategory;
    var_26df3c9d271cf039 = function_96fd49b5dbd6afc9( activitycategory, region.index );
    
    if ( var_26df3c9d271cf039 <= 0 )
    {
        return false;
    }
    
    var_b211de7d7b2de437 = function_b522153328a36c33( activitycategory, region.index );
    
    if ( var_b211de7d7b2de437 >= var_26df3c9d271cf039 )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x8e39ab27, Offset: 0x4f56
// Size: 0x86
function private function_474555bea691dac7()
{
    var_d6a1cfbd96259eca = spawnstruct();
    var_d6a1cfbd96259eca conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( var_d6a1cfbd96259eca, &function_a0a01e6e0fe042fb, [], undefined, "type has available instance" );
    conditional_container::addcondition( var_d6a1cfbd96259eca, &function_9cf429d98bf86005, [], undefined, "type not on cooldown" );
    conditional_container::addcondition( var_d6a1cfbd96259eca, &function_195fbabb6aca513e, [], undefined, "type max limit not hit" );
    conditional_container::addcondition( var_d6a1cfbd96259eca, &function_3915a433d9dde829, [], undefined, "type max limit in region not hit" );
    conditional_container::addcondition( var_d6a1cfbd96259eca, &function_1d95b7e579d89404, [], undefined, "type can be spawned automatically" );
    return var_d6a1cfbd96259eca;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x4694efc8, Offset: 0x4fe5
// Size: 0xc4, Type: bool
function function_a0a01e6e0fe042fb( typeinformation, params )
{
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ typeinformation.activitycategory ][ typeinformation.region.index ][ typeinformation.activitytype ];
    var_559750d3b21f479f = level.var_e607236b193eb0c1.var_559750d3b21f479f[ typeinformation.activitycategory ][ typeinformation.region.index ][ typeinformation.activitytype ];
    
    if ( activityinstances.size <= 0 || var_559750d3b21f479f.size >= activityinstances.size )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x8bef43a4, Offset: 0x50b2
// Size: 0x110, Type: bool
function function_9cf429d98bf86005( typeinformation, params )
{
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ typeinformation.activitycategory ][ typeinformation.region.index ][ typeinformation.activitytype ];
    instancekey = getarraykey( activityinstances, 0 );
    instanceinfo = activityinstances[ instancekey ];
    
    if ( isdefined( instanceinfo.var_622af9ed9146813f ) )
    {
        var_e257a1f29ed4e457 = instanceinfo.var_622af9ed9146813f.var_e257a1f29ed4e457 ?? 0;
        
        /#
            var_627a42f772b024cb = getdvarint( hashcat( @"hash_7ff56dfec79bc538", typeinformation.activitytype ), -1 );
            
            if ( var_627a42f772b024cb >= 0 )
            {
                var_e257a1f29ed4e457 = var_627a42f772b024cb;
            }
        #/
        
        var_3b985995e04919dc = utility::function_6f5d2e1f1ff70482( gettime() );
        
        if ( var_e257a1f29ed4e457 > 0 && var_e257a1f29ed4e457 > var_3b985995e04919dc )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x10eb9d9e, Offset: 0x51cb
// Size: 0x197, Type: bool
function function_195fbabb6aca513e( typeinformation, params )
{
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ typeinformation.activitycategory ][ typeinformation.region.index ][ typeinformation.activitytype ];
    instancekey = getarraykey( activityinstances, 0 );
    instanceinfo = activityinstances[ instancekey ];
    
    if ( isdefined( instanceinfo.var_622af9ed9146813f ) )
    {
        var_a378375361078de8 = instanceinfo.var_622af9ed9146813f.var_a378375361078de8 ?? 0;
        
        if ( var_a378375361078de8 == 0 )
        {
            return false;
        }
        
        var_29b84184dd19e57d = 0;
        regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
        
        foreach ( var_f001585a8191f372 in regions )
        {
            var_559750d3b21f479f = level.var_e607236b193eb0c1.var_559750d3b21f479f[ typeinformation.activitycategory ][ var_f001585a8191f372.index ][ typeinformation.activitytype ];
            
            if ( isdefined( var_559750d3b21f479f ) )
            {
                var_29b84184dd19e57d += var_559750d3b21f479f.size;
            }
        }
        
        if ( var_29b84184dd19e57d >= var_a378375361078de8 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x96f6a77, Offset: 0x536b
// Size: 0x208, Type: bool
function function_3915a433d9dde829( typeinformation, params )
{
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ typeinformation.activitycategory ][ typeinformation.region.index ][ typeinformation.activitytype ];
    instancekey = getarraykey( activityinstances, 0 );
    instanceinfo = activityinstances[ instancekey ];
    regiondifficulty = region_difficulty_manager::function_d2213de17e7b3faf( typeinformation.region );
    
    if ( isdefined( instanceinfo.var_622af9ed9146813f ) )
    {
        var_818ba7046423598a = 0;
        
        switch ( regiondifficulty )
        {
            case #"hash_7bb2cd766703d463":
                var_818ba7046423598a = instanceinfo.var_622af9ed9146813f.var_82f0a81c6ed90196 ?? 0;
                break;
            case #"hash_af83e47edfa8900a":
                var_818ba7046423598a = instanceinfo.var_622af9ed9146813f.var_a45684d4dd42dab7 ?? 0;
                break;
            case #"hash_5343b465e56ec9a4":
                var_818ba7046423598a = instanceinfo.var_622af9ed9146813f.var_4ea88511f05a95a9 ?? 0;
                break;
            case #"hash_651f76c0ad6741ec":
                var_818ba7046423598a = instanceinfo.var_622af9ed9146813f.var_19e7fc6c8d9b1706 ?? 0;
                break;
            case #"hash_c0250ffc2e87f2ff":
            case #"hash_c02510fc2e87f492":
                var_818ba7046423598a = 0;
                break;
            default:
                var_818ba7046423598a = 2147483647;
                break;
        }
        
        if ( var_818ba7046423598a == 0 )
        {
            return false;
        }
        
        var_559750d3b21f479f = level.var_e607236b193eb0c1.var_559750d3b21f479f[ typeinformation.activitycategory ][ typeinformation.region.index ][ typeinformation.activitytype ];
        var_29b84184dd19e57d = var_559750d3b21f479f.size;
        
        if ( var_29b84184dd19e57d >= var_818ba7046423598a )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x1cec5c42, Offset: 0x557c
// Size: 0xb2
function function_1d95b7e579d89404( typeinformation, params )
{
    activityinstances = level.var_e607236b193eb0c1.activityinstances[ typeinformation.activitycategory ][ typeinformation.region.index ][ typeinformation.activitytype ];
    instancekey = getarraykey( activityinstances, 0 );
    instanceinfo = activityinstances[ instancekey ];
    
    if ( isdefined( instanceinfo.var_622af9ed9146813f.autospawn ) )
    {
        return instanceinfo.var_622af9ed9146813f.autospawn;
    }
    
    return 1;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x65abf81a, Offset: 0x5637
// Size: 0x17f
function private function_e3939e15a7769446()
{
    var_f1f909264aebf6e3 = spawnstruct();
    var_f1f909264aebf6e3 conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_f1d8de22c8cc2109, [], undefined, "instance must be enabled on global or type or instance level according to dvars" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_b5bdbf846da577f, [], undefined, "instance must not already be running" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_d7e25a9ed437f21e, [], undefined, "instance must be under max repeat limit" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_af9d286fb288f196, [], undefined, "difficulty tier within regional range and under max tier instance limit" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_bb066a2ef3c400e6, [], undefined, "instance must not be on cooldown" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_10db83bfddb33fbf, [], undefined, "there must be enough resources available to spawn instance" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_8951fb91e239864c, [], undefined, "activity type of instance must not have hit max duplicate count in region" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_ebbd1c5120a04d0a, [], undefined, "instance must not be too close to aether storm" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_8500471444e81d43, [], undefined, "instance must not be in disabled area" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_7a5d6f5dbb63bffd, [], undefined, "instance must not be overlapping or too close to any other activity" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_f450550b51bd8fb5, [], undefined, "instance can be spawned automatically" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_714537ed7c463c8c, [], undefined, "instance must not be too close to player" );
    
    if ( utility::issharedfuncdefined( #"hash_473f3455c9e039dc", #"hash_48250594acbc3a15" ) )
    {
        conditional_container::addcondition( var_f1f909264aebf6e3, &function_cf8d9d147f5ffeca, [], undefined, "instance must not be too close to global event" );
    }
    
    if ( utility::issharedfuncdefined( #"pvp_contract", #"hash_d337077cc7eeaf3e" ) )
    {
        utility::callsharedfunc( #"pvp_contract", #"hash_d337077cc7eeaf3e", var_f1f909264aebf6e3 );
    }
    
    return var_f1f909264aebf6e3;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0x8491437f, Offset: 0x57bf
// Size: 0x47
function private function_8227b84f0f7a0e24()
{
    var_f1f909264aebf6e3 = spawnstruct();
    var_f1f909264aebf6e3 conditional_container::function_3c3be461141746c0();
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_b5bdbf846da577f, [], undefined, "instance must not already be running" );
    conditional_container::addcondition( var_f1f909264aebf6e3, &function_10db83bfddb33fbf, [], undefined, "there must be enough resources available to spawn instance" );
    return var_f1f909264aebf6e3;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x1a7fb58, Offset: 0x580f
// Size: 0x129, Type: bool
function function_f1d8de22c8cc2109( activityinstance, params )
{
    var_863afd59d2518588 = function_3fc14e8386bb137( activityinstance.class );
    var_152dbfb59eec5a94 = isdvardefined( hashcat( @"hash_862d7d5538370d45", activityinstance.type ) );
    var_cfdd2d31c75c3373 = int( getdvar( hashcat( @"hash_862d7d5538370d45", activityinstance.type ) ) );
    var_d7fe3a59cb2fc6be = isdvardefined( hashcat( @"hash_b17313d000a837eb", activityinstance.name ) );
    var_43a70cf0e83b1199 = int( getdvar( hashcat( @"hash_b17313d000a837eb", activityinstance.name ) ) );
    var_15a633ed29d7b70e = var_d7fe3a59cb2fc6be && var_43a70cf0e83b1199 != 0;
    var_78510dcf801a3d50 = !var_d7fe3a59cb2fc6be && var_152dbfb59eec5a94 && var_cfdd2d31c75c3373 != 0;
    var_536a8ac4eebe8976 = !var_d7fe3a59cb2fc6be && !var_152dbfb59eec5a94 && var_863afd59d2518588;
    return var_15a633ed29d7b70e || var_78510dcf801a3d50 || var_536a8ac4eebe8976;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xc15c6125, Offset: 0x5941
// Size: 0xb3, Type: bool
function function_b5bdbf846da577f( activityinstance, params )
{
    assert( params.size == 0 );
    activitycategory = activityinstance.class;
    region = activityinstance.region;
    activitytype = activityinstance.type;
    instancekey = activityinstance.name;
    var_559750d3b21f479f = level.var_e607236b193eb0c1.var_559750d3b21f479f[ activitycategory ][ region.index ][ activitytype ];
    return !( isdefined( var_559750d3b21f479f ) && isdefined( var_559750d3b21f479f[ instancekey ] ) );
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xc489e44e, Offset: 0x59fd
// Size: 0xf0, Type: bool
function function_bb066a2ef3c400e6( activityinstance, params )
{
    assert( params.size == 0 );
    activitycategory = activityinstance.class;
    var_732dadcb10b47203 = function_a6ff0ad505239c54( @"hash_66a45e1fc2707d68", activitycategory, 120 );
    var_1279817eb31c171a = activityinstance.var_622af9ed9146813f.instancecooldown;
    
    if ( activityinstance.var_8d722527cb3b355c > 0 && activityinstance.var_622af9ed9146813f.canrespawn == 0 )
    {
        return false;
    }
    
    if ( var_1279817eb31c171a >= 0 )
    {
        var_732dadcb10b47203 = var_1279817eb31c171a;
    }
    
    var_84fe6e4579da4caa = utility::function_4b74c15943231980( var_732dadcb10b47203 );
    time = gettime();
    return !( activityinstance.var_8d722527cb3b355c > 0 && activityinstance.var_8d722527cb3b355c + var_84fe6e4579da4caa >= time );
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xdb4f1ea, Offset: 0x5af6
// Size: 0x3a, Type: bool
function function_d7e25a9ed437f21e( activityinstance, params )
{
    assert( params.size == 0 );
    return !( activityinstance.var_f82d9f71f1fa1ac9 >= activityinstance.var_7045a7bcdef0ce48 );
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x66c2bbfe, Offset: 0x5b39
// Size: 0x1cb, Type: bool
function function_af9d286fb288f196( activityinstance, params )
{
    assert( params.size == 0 );
    var_61c773bc2d1577e5 = getdvarint( @"hash_6a0e07eedeb242f8", 1 );
    currenttier = activityinstance.var_e43d97c215c8145e ?? 0;
    region = activityinstance.region;
    regiondifficulty = region_difficulty_manager::function_d2213de17e7b3faf( region );
    
    if ( var_61c773bc2d1577e5 && currenttier != 0 )
    {
        var_e234e0c8a357450d = undefined;
        var_8b0a1553565f4536 = int( getdvar( hashcat( @"hash_e416f82022e32c4a", region.index, "_max_instances_activity_difficulty_tier_", currenttier ), -1 ) );
        var_eda2dbafe5260f45 = level.var_e607236b193eb0c1.var_92e658dad9b71fad[ region.index ][ currenttier ];
        var_e234e0c8a357450d = var_eda2dbafe5260f45 >= var_8b0a1553565f4536 && var_8b0a1553565f4536 != -1;
        var_bdb9e6e958846be3 = undefined;
        var_a937cda110793f16 = int( getdvar( hashcat( @"hash_cc6d5154c4d9290e", currenttier ), -1 ) );
        var_e013207b3b428a9b = function_10ae92df5d46df01( currenttier );
        var_bdb9e6e958846be3 = var_e013207b3b428a9b >= var_a937cda110793f16 && var_a937cda110793f16 != -1;
        
        if ( var_e234e0c8a357450d || var_bdb9e6e958846be3 )
        {
            return false;
        }
        
        var_20834ebe694c7595 = int( getdvar( hashcat( @"hash_1c91fb4bb0a43542", regiondifficulty ), 0 ) );
        var_20a738be6974bfeb = int( getdvar( hashcat( @"hash_a913b34b5c30ce28", regiondifficulty ), 4 ) );
        
        if ( activityinstance.var_e43d97c215c8145e < var_20834ebe694c7595 || activityinstance.var_e43d97c215c8145e > var_20a738be6974bfeb )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x8e0c3c47, Offset: 0x5d0d
// Size: 0x82
function function_10db83bfddb33fbf( activityinstance, params )
{
    assert( params.size == 0 );
    activitycategory = activityinstance.class;
    activitytype = activityinstance.type;
    instancekey = activityinstance.name;
    return ob_resource_manager::function_343895fa5dadad10( activitycategory, activitytype, instancekey, activityinstance.var_622af9ed9146813f.activityresources );
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x1fd32d3e, Offset: 0x5d98
// Size: 0xfa, Type: bool
function function_8951fb91e239864c( activityinstance, params )
{
    assert( params.size == 0 );
    activitycategory = activityinstance.class;
    region = activityinstance.region;
    activitytype = activityinstance.type;
    var_559750d3b21f479f = level.var_e607236b193eb0c1.var_559750d3b21f479f[ activitycategory ][ region.index ][ activitytype ];
    var_800877d9a550547d = function_a6ff0ad505239c54( @"hash_9a1268e639489626", activitycategory, 1 );
    
    if ( isdefined( var_559750d3b21f479f ) && var_559750d3b21f479f.size > 0 && var_800877d9a550547d > 0 )
    {
        default_region = region_difficulty_manager::get_default_region();
        return ( region.index == default_region.index || var_559750d3b21f479f.size < var_800877d9a550547d );
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x4d8d6c28, Offset: 0x5e9b
// Size: 0x1bb, Type: bool
function function_714537ed7c463c8c( activityinstance, params )
{
    assert( params.size == 0 );
    activitycategory = activityinstance.class;
    var_c3a3d82788c37c93 = function_f7d298badd5c5b8f( @"hash_af678d6174008e62", activityinstance.class, 0 );
    
    if ( var_c3a3d82788c37c93 <= 0 )
    {
        return true;
    }
    
    spatialzonespheres = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "OB_Spacer_Spatial_Zone" );
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.origin ) && isdefined( player.team ) && isalive( player ) )
        {
            for ( spatialindex = 0; spatialindex < spatialzonespheres.size ; spatialindex++ )
            {
                SpatialZoneSphere = spatialzonespheres[ spatialindex ];
                testorigin = SpatialZoneSphere.origin;
                var_60df32f77855add4 = activityinstance.var_622af9ed9146813f.mindistplayers ?? SpatialZoneSphere.radius;
                distancesquared = distance2dsquared( player.origin, testorigin );
                var_58a3187fd79e84ce = squared( max( var_60df32f77855add4 + var_c3a3d82788c37c93, 0 ) );
                
                if ( distancesquared <= var_58a3187fd79e84ce )
                {
                    return false;
                }
            }
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xe96b3eeb, Offset: 0x605f
// Size: 0x122, Type: bool
function function_ebbd1c5120a04d0a( activityinstance, params )
{
    assert( params.size == 0 );
    
    if ( isdefined( level.aether_storm ) && isdefined( level.aether_storm.var_ddadcc992aaf985 ) && isvector( level.aether_storm.starting_origin ) )
    {
        spatialzonespheres = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "OB_Spacer_Spatial_Zone" );
        
        for ( spatialindex = 0; spatialindex < spatialzonespheres.size ; spatialindex++ )
        {
            SpatialZoneSphere = spatialzonespheres[ spatialindex ];
            testorigin = SpatialZoneSphere.origin;
            var_60df32f77855add4 = SpatialZoneSphere.radius;
            distancesquared = distance2dsquared( level.aether_storm.starting_origin, testorigin );
            var_58a3187fd79e84ce = squared( max( var_60df32f77855add4 + level.aether_storm.var_ddadcc992aaf985, 0 ) );
            
            if ( distancesquared <= var_58a3187fd79e84ce )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x85cd2d76, Offset: 0x618a
// Size: 0x556
function function_7a5d6f5dbb63bffd( activityinstance, params )
{
    assert( params.size == 0 );
    var_2cd019aa12e85e9f = 0;
    var_5e8baeebbe2ff695 = 40;
    regions = region_difficulty_manager::function_4f8f6054ecabf2dc();
    activitycategories = function_13745445d5f57d2a();
    activitycategory = activityinstance.class;
    activitytype = activityinstance.type;
    var_ba3bf30bc3eae6e1 = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "OB_Spacer_Spatial_Zone" );
    
    if ( var_ba3bf30bc3eae6e1.size <= 0 )
    {
        return 1;
    }
    
    var_ae3907698ee6e6f1 = 1;
    
    if ( activityinstance.var_622af9ed9146813f.preventoverlaps == 1 )
    {
        var_67e8e4379ceb308f = 1;
    }
    
    /#
        activityinstance.overlapping_activity_name = undefined;
    #/
    
    foreach ( var_f1a2947b0bd92b2f in activitycategories )
    {
        var_eb5f98f6cad9c576 = function_f7d298badd5c5b8f( @"hash_176090f07a9fa6df", var_f1a2947b0bd92b2f, 1800 );
        
        foreach ( var_f001585a8191f372 in regions )
        {
            foreach ( var_ee9f0c1da0c1a082, var_545c9b137e61ce93 in level.var_e607236b193eb0c1.var_559750d3b21f479f[ var_f1a2947b0bd92b2f ][ var_f001585a8191f372.index ] )
            {
                if ( !var_545c9b137e61ce93.size )
                {
                    continue;
                }
                
                if ( !var_67e8e4379ceb308f && var_f1a2947b0bd92b2f != activitycategory )
                {
                    instancekey = getarraykey( var_545c9b137e61ce93, 0 );
                    instanceinfo = var_545c9b137e61ce93[ instancekey ];
                    var_e6e9fd425e9d4470 = 1;
                    
                    if ( !isdefined( instanceinfo.var_622af9ed9146813f.preventoverlaps ) || instanceinfo.var_622af9ed9146813f.preventoverlaps == 0 )
                    {
                        var_e6e9fd425e9d4470 = 0;
                    }
                    
                    if ( isdefined( level.var_e607236b193eb0c1.customconstraints[ activitycategory ][ activitytype ][ var_f1a2947b0bd92b2f ][ var_ee9f0c1da0c1a082 ] ) )
                    {
                        var_e6e9fd425e9d4470 = 1;
                    }
                    
                    if ( !var_e6e9fd425e9d4470 )
                    {
                        continue;
                    }
                }
                
                foreach ( var_d6dd1435bf8cc2b5, var_c233e7a3293d7096 in var_545c9b137e61ce93 )
                {
                    var_2cd019aa12e85e9f++;
                    var_2cd019aa12e85e9f %= var_5e8baeebbe2ff695;
                    
                    if ( var_2cd019aa12e85e9f == 0 )
                    {
                        waitframe();
                    }
                    
                    var_ee941b4f08b5371a = spatial_zone_container::function_f7fc3e6c249a8256( var_c233e7a3293d7096, "OB_Spacer_Spatial_Zone" );
                    mindistancesquared = 2147483647;
                    
                    for ( var_8c27f62abc3ce8a5 = 0; var_8c27f62abc3ce8a5 < var_ee941b4f08b5371a.size && var_ae3907698ee6e6f1 ; var_8c27f62abc3ce8a5++ )
                    {
                        var_ddc91703c72d560d = var_ee941b4f08b5371a[ var_8c27f62abc3ce8a5 ];
                        var_4a36d3c804623c5b = var_ddc91703c72d560d.origin;
                        var_d009dd6b03915e97 = var_ddc91703c72d560d.radius;
                        
                        for ( spatialindex = 0; spatialindex < var_ba3bf30bc3eae6e1.size && var_ae3907698ee6e6f1 ; spatialindex++ )
                        {
                            var_f5d71d41f41226e8 = var_ba3bf30bc3eae6e1[ spatialindex ];
                            testorigin = var_f5d71d41f41226e8.origin;
                            var_60df32f77855add4 = var_f5d71d41f41226e8.radius;
                            distancesquared = distance2dsquared( var_4a36d3c804623c5b, testorigin );
                            var_58a3187fd79e84ce = squared( max( var_d009dd6b03915e97 + var_60df32f77855add4 + var_eb5f98f6cad9c576, 0 ) );
                            var_ae3907698ee6e6f1 = distancesquared > var_58a3187fd79e84ce;
                            
                            if ( distancesquared < mindistancesquared )
                            {
                                mindistancesquared = distancesquared;
                            }
                        }
                    }
                    
                    if ( var_ae3907698ee6e6f1 && isdefined( activityinstance.var_622af9ed9146813f.mindistinstances ) && activityinstance.var_622af9ed9146813f.mindistinstances > 0 && activitytype == var_ee9f0c1da0c1a082 )
                    {
                        var_ae3907698ee6e6f1 = squared( activityinstance.var_622af9ed9146813f.mindistinstances ) < mindistancesquared;
                    }
                    
                    if ( var_ae3907698ee6e6f1 && isdefined( level.var_e607236b193eb0c1.customconstraints[ activitycategory ][ activitytype ][ var_f1a2947b0bd92b2f ][ var_ee9f0c1da0c1a082 ] ) )
                    {
                        var_ae3907698ee6e6f1 = squared( level.var_e607236b193eb0c1.customconstraints[ activitycategory ][ activitytype ][ var_f1a2947b0bd92b2f ][ var_ee9f0c1da0c1a082 ] ) < mindistancesquared;
                    }
                    
                    if ( !var_ae3907698ee6e6f1 )
                    {
                        /#
                            activityinstance.overlapping_activity_name = var_d6dd1435bf8cc2b5;
                        #/
                        
                        waitframe();
                        return 0;
                    }
                }
            }
        }
    }
    
    waitframe();
    return var_ae3907698ee6e6f1;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0x73ad2d1a, Offset: 0x66e9
// Size: 0x3f
function function_f450550b51bd8fb5( activityinstance, params )
{
    assert( params.size == 0 );
    
    if ( isdefined( activityinstance.var_265c4f33e2a6daa7 ) )
    {
        return activityinstance.var_265c4f33e2a6daa7;
    }
    
    return 1;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xb72633c1, Offset: 0x6731
// Size: 0xb5
function function_cf8d9d147f5ffeca( activityinstance, params )
{
    assert( params.size == 0 );
    
    if ( utility::issharedfuncdefined( #"hash_473f3455c9e039dc", #"hash_48250594acbc3a15" ) )
    {
        activitycategory = activityinstance.class;
        activitytype = activityinstance.type;
        instancekey = activityinstance.name;
        return !( activitycategory == "Activity" && utility::callsharedfunc( #"hash_473f3455c9e039dc", #"hash_48250594acbc3a15", activityinstance.centerpoint ) );
    }
    
    return 1;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xab124bed, Offset: 0x67ee
// Size: 0x275, Type: bool
function function_8500471444e81d43( activityinstance, params )
{
    assert( params.size == 0 );
    
    if ( !level.var_e607236b193eb0c1.var_1ea76f3cb810315b.size )
    {
        return true;
    }
    
    spatialzonespheres = spatial_zone_container::function_f7fc3e6c249a8256( activityinstance, "OB_Spacer_Spatial_Zone" );
    
    for ( spatialindex = 0; spatialindex < spatialzonespheres.size ; spatialindex++ )
    {
        SpatialZoneSphere = spatialzonespheres[ spatialindex ];
        testorigin = SpatialZoneSphere.origin;
        var_60df32f77855add4 = SpatialZoneSphere.radius;
        
        if ( function_5343c483cf9cc273( testorigin, var_60df32f77855add4 ) )
        {
            return false;
        }
    }
    
    var_4fe2d491bc9efbff = function_ed1dae3a9cce08d2( activityinstance.name );
    
    foreach ( var_99c2b0d0a40bdfae in var_4fe2d491bc9efbff )
    {
        var_6f9f67561720fbfd = spatial_zone_container::function_f7fc3e6c249a8256( var_99c2b0d0a40bdfae, "OB_Spacer_Spatial_Zone" );
        
        for ( spatialindex = 0; spatialindex < var_6f9f67561720fbfd.size ; spatialindex++ )
        {
            SpatialZoneSphere = var_6f9f67561720fbfd[ spatialindex ];
            testorigin = SpatialZoneSphere.origin;
            var_60df32f77855add4 = SpatialZoneSphere.radius;
            
            if ( function_5343c483cf9cc273( testorigin, var_60df32f77855add4 ) )
            {
                return false;
            }
        }
    }
    
    if ( activityinstance.class == "Contract" )
    {
        variantscriptstructinfo = activity_common::function_d54f02a6971bb9ab( activityinstance.name );
        
        if ( variantscriptstructinfo )
        {
            linkedstructs = variantscriptstructinfo.linkedstructs;
            
            foreach ( linkedstruct in linkedstructs )
            {
                var_a3fce574d6e49fdc = linkedstruct.targetname === "activity_nexus_instance_joiner";
                
                if ( var_a3fce574d6e49fdc )
                {
                    if ( function_5343c483cf9cc273( linkedstruct.origin ) )
                    {
                        return false;
                    }
                }
            }
        }
    }
    
    return true;
}

// Namespace ob_activity_manager
// Params 2
// Checksum 0xf09c7886, Offset: 0x6a6c
// Size: 0x90
function function_2359b9c5c7e92432( origin, radius )
{
    if ( !isdefined( level.var_e607236b193eb0c1.var_1ea76f3cb810315b ) )
    {
        level.var_e607236b193eb0c1.var_1ea76f3cb810315b = [];
    }
    
    area = { #radius:radius, #origin:origin };
    level.var_e607236b193eb0c1.var_1ea76f3cb810315b[ level.var_e607236b193eb0c1.var_1ea76f3cb810315b.size ] = area;
    return area;
}

// Namespace ob_activity_manager
// Params 1
// Checksum 0xa7000be6, Offset: 0x6b05
// Size: 0x39
function function_2db7d17b1053ea5b( area )
{
    level.var_e607236b193eb0c1.var_1ea76f3cb810315b = arrayremove( level.var_e607236b193eb0c1.var_1ea76f3cb810315b, area );
}

// Namespace ob_activity_manager
// Params 2, eflags: 0x4
// Checksum 0xe882081d, Offset: 0x6b46
// Size: 0xde, Type: bool
function private function_5343c483cf9cc273( origin, radius = 0 )
{
    foreach ( area in level.var_e607236b193eb0c1.var_1ea76f3cb810315b )
    {
        distancesquared = distance2dsquared( origin, area.origin );
        var_58a3187fd79e84ce = squared( max( radius + area.radius, 0 ) );
        
        if ( distancesquared <= var_58a3187fd79e84ce )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ob_activity_manager
// Params 0, eflags: 0x4
// Checksum 0xb3f1b165, Offset: 0x6c2d
// Size: 0x110
function private function_4c84a1ffd9854fc4()
{
    function_6d643106428f593b( "Activity", "REV_OB_ARMORED_CONVOY", "Contract", "REV_OB_CONTRACT_PRECIOUS_CARGO", 1000 );
    function_6d643106428f593b( "Activity", "REV_OB_ARMORED_CONVOY", "Startup", "REV_OB_POSSESSED_CONVOY", 1000 );
    function_6d643106428f593b( "Activity", "REV_OB_CRASH_SITES", "Startup", "REV_OB_POSSESSED_CONVOY", 1000 );
    function_6d643106428f593b( "Contract", "REV_OB_SUPPLY_CHAIN", "Startup", "REV_OB_POSSESSED_CONVOY", 1000 );
    function_6d643106428f593b( "Contract", "REV_OB_CONTRACT_PRECIOUS_CARGO", "Startup", "REV_OB_POSSESSED_CONVOY", 1000 );
    function_6d643106428f593b( "Contract", "REV_OB_SUPPLY_CHAIN", "Activity", "REV_OB_HELI_TAKEDOWN", 1000 );
    function_6d643106428f593b( "Activity", "REV_OB_HELI_TAKEDOWN", "Contract", "REV_OB_SUPPLY_CHAIN", 1000 );
    function_6d643106428f593b( "Contract", "REV_OB_HEIST", "Activity", "REV_OB_CRASH_SITES", 1000 );
    function_6d643106428f593b( "Activity", "REV_OB_CRASH_SITES", "Contract", "REV_OB_HEIST", 1000 );
}

/#

    // Namespace ob_activity_manager
    // Params 0, eflags: 0x4
    // Checksum 0xac59608e, Offset: 0x6d45
    // Size: 0xb7, Type: dev
    function private function_320715840c9317be()
    {
        if ( !isdefined( level.var_690cc31a674a33ec ) )
        {
            assertmsg( "<dev string:x6ef>" );
            return;
        }
        
        level.var_690cc31a674a33ec.var_2ca79148edf22998 = &function_6c71eefe2176799e;
        level.var_690cc31a674a33ec.var_6af90d5c7779f340 = &function_b3429fd8a4e4d2a3;
        level.var_690cc31a674a33ec.var_82fb757e69918800 = &function_96fd49b5dbd6afc9;
        level.var_690cc31a674a33ec.var_7616efc8d41fe063 = &function_be02ca693c0bbe5e;
        level.var_690cc31a674a33ec.var_951b233930b84b8b = &function_d4ab39b8f502e1e2;
        level.var_690cc31a674a33ec.var_4ba482657d6e1cd3 = &function_f7d298badd5c5b8f;
    }

#/
