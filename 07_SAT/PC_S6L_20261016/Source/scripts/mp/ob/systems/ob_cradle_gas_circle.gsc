// scripts\mp\ob\systems\ob_cradle_gas_circle.gsc  (hash_6e06c9de0f7c1b09.gscc) (size: 5791 Bytes / 0x169f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3965d00b (962973707)
// size ...... 5791 (0x169f)
// includes .. 1   (offset: 0x15eb)
// strings ... 12  (offset: 0x15f3)
// dev strs .. 2   (offset: 0x1687)
// exports ... 18  (offset: 0xe9b)
// cseg ...... 0x113 + 0xd88 (0xe9b)
// imports ... 39  (offset: 0x116b)
// animtree1 . 0   (offset: 0x169f)
// animtree2 . 0   (offset: 0x169f)
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_cradle_gas_circle;

// Namespace ob_cradle_gas_circle
// Params 5
// Checksum 0xf9db99e0, Offset: 0x131
// Size: 0x19f
function function_715467b4b7feb05a( gas_circle_struct, var_a492ff9760b2929b = 2, var_58c716ea2bcfef26 = 1, var_ff4a876020a80e38 = 0, enhanced_fade_duration = 2 )
{
    if ( !gas_circle_struct.var_7f5fe591d7b6121f )
    {
        gas_circle_struct.var_7f5fe591d7b6121f = var_58c716ea2bcfef26;
    }
    
    if ( !gas_circle_struct.var_ff4a876020a80e38 )
    {
        gas_circle_struct.var_ff4a876020a80e38 = var_ff4a876020a80e38;
    }
    
    if ( !gas_circle_struct.enhanced_fade_duration )
    {
        gas_circle_struct.enhanced_fade_duration = enhanced_fade_duration;
    }
    
    if ( !gas_circle_struct.difficultyint )
    {
        region = region_difficulty_manager::function_f9fbb630598afdc7( gas_circle_struct.origin );
        gas_circle_struct.difficultyint = region.difficultyint;
    }
    
    gas_property = get_gas_property( var_a492ff9760b2929b );
    
    if ( !gas_circle_struct.scriptable )
    {
        gas_circle_struct.scriptable = spawnscriptable( "ob_cradle_gas_circle_vfx", gas_circle_struct.origin, gas_circle_struct.angles );
        gas_circle_struct.scriptable setscriptablepartstate( "VFX", gas_property.state );
    }
    
    if ( !gas_circle_struct.trigger )
    {
        function_c69eff452d4eda79( gas_circle_struct, gas_property.radius, gas_property.height );
    }
    
    gas_circle_struct.scriptable.parent = gas_circle_struct;
}

// Namespace ob_cradle_gas_circle
// Params 2
// Checksum 0x7c3bc939, Offset: 0x2d8
// Size: 0x28
function function_c870711f2af94762( gas_circle_struct, var_58c716ea2bcfef26 )
{
    if ( gas_circle_struct )
    {
        gas_circle_struct.var_7f5fe591d7b6121f = var_58c716ea2bcfef26;
    }
}

// Namespace ob_cradle_gas_circle
// Params 2
// Checksum 0x7a019fe3, Offset: 0x308
// Size: 0x3f
function function_2d91835db24de3a0( gas_circle_struct, region_difficulty_int )
{
    if ( gas_circle_struct )
    {
        if ( region_difficulty_int == 0 )
        {
            region_difficulty_int = 1;
        }
        
        return int( clamp( region_difficulty_int + gas_circle_struct.var_7f5fe591d7b6121f, 0, 4 ) );
    }
}

// Namespace ob_cradle_gas_circle
// Params 3
// Checksum 0xaa0c0715, Offset: 0x34f
// Size: 0xb1
function function_c69eff452d4eda79( struct, gas_circle_radius, gas_circle_height )
{
    trigger = spawn( "trigger_radius", struct.origin, 0, gas_circle_radius, gas_circle_height );
    
    if ( !isdefined( trigger ) )
    {
        assert( 0, "<dev string:x24>" );
        return;
    }
    
    /#
        thread function_5905f20bc8cf63ce( trigger );
    #/
    
    struct thread function_8b4aaaafadcdec7( trigger, gas_circle_radius, gas_circle_height );
    struct.trigger = trigger;
    struct.trigger.radius = gas_circle_radius;
    struct.var_8ca11f5c1e2869e3 = [];
    struct thread function_10a607c34fc110c( trigger, gas_circle_radius, gas_circle_height );
}

// Namespace ob_cradle_gas_circle
// Params 1
// Checksum 0xb90435e2, Offset: 0x408
// Size: 0x1b, Type: bool
function function_5424e6517829836a( struct )
{
    return struct.var_767393f0c9f5202f ?? [];
}

// Namespace ob_cradle_gas_circle
// Params 1
// Checksum 0xbc40d205, Offset: 0x42c
// Size: 0x21
function get_gas_circle_radius( struct )
{
    return struct.trigger.radius;
}

// Namespace ob_cradle_gas_circle
// Params 3
// Checksum 0x2106a27f, Offset: 0x456
// Size: 0x124
function function_8b4aaaafadcdec7( trigger, radius, height )
{
    trigger endon( #"death" );
    
    while ( true )
    {
        var_53bda60624812d37 = [];
        
        foreach ( player in self.var_767393f0c9f5202f )
        {
            if ( !isalive( player ) || distance2d( trigger.origin, player.origin ) > radius || abs( trigger.origin[ 2 ] - player.origin[ 2 ] ) > height )
            {
                player notify( #"hash_816f9eda709a23c1" );
                continue;
            }
            
            var_53bda60624812d37[ var_53bda60624812d37.size ] = player;
        }
        
        self.var_767393f0c9f5202f = var_53bda60624812d37;
        waitframe();
    }
}

// Namespace ob_cradle_gas_circle
// Params 2
// Checksum 0x4118f6f6, Offset: 0x582
// Size: 0x52
function function_f7d4939e567b5728( gas_circle_struct, player )
{
    if ( !isdefined( gas_circle_struct.var_767393f0c9f5202f ) )
    {
        gas_circle_struct.var_767393f0c9f5202f = [];
    }
    
    gas_circle_struct.var_767393f0c9f5202f = arraycombineunique( gas_circle_struct.var_767393f0c9f5202f, [ player ] );
}

// Namespace ob_cradle_gas_circle
// Params 1
// Checksum 0x15824b1d, Offset: 0x5dc
// Size: 0x76
function function_ad1c37731b23fb82( gas_circle_struct )
{
    if ( isdefined( gas_circle_struct.trigger ) )
    {
        gas_circle_struct.trigger delete();
        gas_circle_struct.trigger = undefined;
    }
    
    if ( isdefined( gas_circle_struct.scriptable ) )
    {
        gas_circle_struct.scriptable freescriptable();
        gas_circle_struct.scriptable = undefined;
    }
    
    gas_circle_struct.var_8ca11f5c1e2869e3 = undefined;
    gas_circle_struct.var_767393f0c9f5202f = undefined;
}

// Namespace ob_cradle_gas_circle
// Params 3, eflags: 0x4
// Checksum 0x879d59c6, Offset: 0x65a
// Size: 0x9f
function private function_10a607c34fc110c( trigger, radius, height )
{
    trigger endon( #"death" );
    
    while ( isdefined( trigger ) )
    {
        trigger waittill( #"trigger", ent );
        
        if ( !isalive( ent ) || !isplayer( ent ) )
        {
            continue;
        }
        
        if ( isdefined( trigger ) && !arraycontains( function_5424e6517829836a( self ), ent ) )
        {
            function_f7d4939e567b5728( self, ent );
            trigger notify( #"hash_db60e0b3d4bbed8e" );
            ent thread hallucination_watcher( self );
        }
    }
}

// Namespace ob_cradle_gas_circle
// Params 1, eflags: 0xc
// Checksum 0x8f2627ac, Offset: 0x701
// Size: 0x170
function private hallucination_watcher( gas_circle_struct )
{
    self notify( #"hash_c040f63f2e3a8427" );
    self endon( #"hash_c040f63f2e3a8427" );
    self endon( #"disconnect" );
    var_9e6c61f06d68f6d9 = region_difficulty_manager::function_dc53171229eb2097( gas_circle_struct.difficultyint );
    powered_difficulty = region_difficulty_manager::function_dc53171229eb2097( clampint( gas_circle_struct.difficultyint + 1, 1, 4 ) );
    thread region_difficulty_manager::function_aec1065e06c4336e( { #new_difficulty:powered_difficulty, #var_705eae6dbfaf5fad:var_9e6c61f06d68f6d9, #player:self } );
    thread region_difficulty_manager::function_b1af95c2d8f522c7( { #new_difficulty:powered_difficulty, #var_705eae6dbfaf5fad:var_9e6c61f06d68f6d9, #player:self } );
    function_59deb5ae2f9815cd( gas_circle_struct, self );
    
    if ( gas_circle_struct.var_8741184584656cb5 && gas_circle_struct.activity_instance )
    {
        assert( isfunction( gas_circle_struct.var_8741184584656cb5 ), "<dev string:x59>" );
        gas_circle_struct.activity_instance thread [[ gas_circle_struct.var_8741184584656cb5 ]]( self );
    }
    
    thread region_difficulty_manager::function_aec1065e06c4336e( { #new_difficulty:var_9e6c61f06d68f6d9, #var_705eae6dbfaf5fad:powered_difficulty, #player:self } );
    thread region_difficulty_manager::function_b1af95c2d8f522c7( { #new_difficulty:var_9e6c61f06d68f6d9, #var_705eae6dbfaf5fad:powered_difficulty, #player:self } );
}

// Namespace ob_cradle_gas_circle
// Params 1
// Checksum 0x13857703, Offset: 0x879
// Size: 0x39
function function_c34cfda7c0cce200( struct )
{
    struct.trigger endon( #"death" );
    struct.trigger waittill( #"hash_db60e0b3d4bbed8e" );
}

// Namespace ob_cradle_gas_circle
// Params 2
// Checksum 0xdc7880ba, Offset: 0x8ba
// Size: 0x39
function function_59deb5ae2f9815cd( struct, player )
{
    struct.trigger endon( #"death" );
    player waittill( #"hash_816f9eda709a23c1" );
}

// Namespace ob_cradle_gas_circle
// Params 3, eflags: 0x4
// Checksum 0x1b9684d9, Offset: 0x8fb
// Size: 0x38
function private function_552f6f9e993d58f5( var_c82182ce72111d5e, var_546e4eb5269dbafa, var_748d21f0ae3805f1 )
{
    var_c82182ce72111d5e endon( #"death" );
    wait var_748d21f0ae3805f1;
    var_c82182ce72111d5e region_difficulty_manager::function_410b4f83b0a5b98( var_546e4eb5269dbafa );
}

// Namespace ob_cradle_gas_circle
// Params 2
// Checksum 0x2e299c64, Offset: 0x93b
// Size: 0x2d6
function function_5d69cf63ba0fb947( gas_circle_struct, radius )
{
    enhanced_zombie_array = [];
    
    while ( true )
    {
        var_546e4eb5269dbafa = region_difficulty_manager::function_dc53171229eb2097( gas_circle_struct.difficultyint );
        var_9cb3066744bd3cd6 = function_2d91835db24de3a0( gas_circle_struct, gas_circle_struct.difficultyint );
        zombie_difficulty = region_difficulty_manager::function_dc53171229eb2097( var_9cb3066744bd3cd6 );
        
        if ( !isdefined( gas_circle_struct.trigger ) )
        {
            foreach ( zombie in enhanced_zombie_array )
            {
                if ( isdefined( zombie._blackboard ) && isalive( zombie ) )
                {
                    thread function_552f6f9e993d58f5( zombie, var_546e4eb5269dbafa, gas_circle_struct.enhanced_fade_duration );
                }
            }
            
            break;
        }
        
        var_86828de10aeec1cb = [];
        ai_array = getaiarrayinradius( gas_circle_struct.origin, radius );
        
        foreach ( ai in ai_array )
        {
            if ( !isdefined( ai._blackboard ) || !isalive( ai ) || ai.type != "zombie" )
            {
                continue;
            }
            
            if ( !gas_circle_struct.var_ff4a876020a80e38 && !issubstr( ai.subclass, "zombie_base" ) )
            {
                continue;
            }
            
            if ( ai.difficulty == var_546e4eb5269dbafa )
            {
                ai region_difficulty_manager::function_410b4f83b0a5b98( zombie_difficulty );
            }
            
            var_86828de10aeec1cb[ var_86828de10aeec1cb.size ] = ai;
        }
        
        var_2584aec7ac452312 = arrayremove( enhanced_zombie_array, var_86828de10aeec1cb );
        
        foreach ( var_c82182ce72111d5e in var_2584aec7ac452312 )
        {
            if ( isdefined( var_c82182ce72111d5e._blackboard ) && isalive( var_c82182ce72111d5e ) )
            {
                thread function_552f6f9e993d58f5( var_c82182ce72111d5e, var_546e4eb5269dbafa, gas_circle_struct.enhanced_fade_duration );
            }
        }
        
        enhanced_zombie_array = var_86828de10aeec1cb;
        wait 1;
    }
}

// Namespace ob_cradle_gas_circle
// Params 1, eflags: 0x4
// Checksum 0x6627cbd4, Offset: 0xc19
// Size: 0x218
function private get_gas_property( enum )
{
    result = spawnstruct();
    
    switch ( enum )
    {
        case 0:
            result.state = "radius_350";
            result.radius = 350;
            result.height = 400;
            break;
        case 1:
            result.state = "radius_750";
            result.radius = 750;
            result.height = 400;
            break;
        case 2:
            result.state = "radius_1500";
            result.radius = 1500;
            result.height = 400;
            break;
        case 3:
            result.state = "cradle_tank";
            result.radius = 1500;
            result.height = 600;
            break;
        case 4:
            result.state = "prop_hunt_sml";
            result.radius = 350;
            result.height = 400;
            break;
        case 5:
            result.state = "prop_hunt_med";
            result.radius = 750;
            result.height = 400;
            break;
        case 6:
            result.state = "prop_hunt_lrg";
            result.radius = 1500;
            result.height = 400;
            break;
        default:
            result.state = "radius_1500";
            result.radius = 1500;
            result.height = 400;
            break;
    }
    
    return result;
}

/#

    // Namespace ob_cradle_gas_circle
    // Params 1
    // Checksum 0xb737a348, Offset: 0xe3a
    // Size: 0x61, Type: dev
    function function_5905f20bc8cf63ce( trigger )
    {
        trigger endon( #"death" );
        
        while ( true )
        {
            if ( !isdefined( trigger ) )
            {
                return;
            }
            
            is_enabled = getdvarint( @"hash_86d43aafd6c12ec4", 0 );
            
            if ( is_enabled )
            {
                drawtrigger( trigger, ( 1, 0, 0 ), 0 );
            }
            
            waitframe();
        }
    }

#/
