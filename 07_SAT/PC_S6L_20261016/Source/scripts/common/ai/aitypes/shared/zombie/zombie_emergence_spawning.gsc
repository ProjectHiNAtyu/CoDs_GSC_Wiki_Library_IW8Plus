// scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning.gsc  (hash_3774b0533d79d9a0.gscc) (size: 11536 Bytes / 0x2d10 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x98f3550b (2566083851)
// size ...... 11536 (0x2d10)
// includes .. 7   (offset: 0x2a94)
// strings ... 20  (offset: 0x2acc)
// dev strs .. 18  (offset: 0x2c1c)
// exports ... 40  (offset: 0x1b38)
// cseg ...... 0x315 + 0x1823 (0x1b38)
// imports ... 74  (offset: 0x2178)
// animtree1 . 0   (offset: 0x2d10)
// animtree2 . 0   (offset: 0x2d10)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_emergence_spawning;

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x1
// Checksum 0xc59fb0ec, Offset: 0x333
// Size: 0x20
function autoexec init_emergence_spawning()
{
    utility::registersharedfunc( #"zombie", #"disable_emergence_spawning_on_death", &disable_emergence_spawning_on_death );
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0x42717e32, Offset: 0x35b
// Size: 0x102
function function_dd3e4457e6a208f1( var_65031210c3b1299b )
{
    if ( isdefined( var_65031210c3b1299b.var_3da28da78ef10740 ) && !level.var_9bcd22d6c999aec3 )
    {
        self.var_c08bad902c1d1dfd = 1;
        namespace_9d8e359c3b1041e5::function_ba64ecf971fcc9ba( zombie_utils::get_zombie_round_difficulty() );
    }
    
    if ( var_65031210c3b1299b.var_d7922471e61ba16 )
    {
        thread function_cb2c94e45a4dde76( var_65031210c3b1299b );
    }
    
    if ( var_65031210c3b1299b.var_8d07b1181350233d )
    {
        function_6d88bb886591529d( var_65031210c3b1299b );
    }
    
    if ( is_emergence_spawning_enabled() )
    {
        self._blackboard.var_436257e172a228a7 = var_65031210c3b1299b.var_9ccc3e7024e45d60;
        
        if ( !self.var_c08bad902c1d1dfd )
        {
            self._blackboard.var_5d7a0203e35cff2f = utility::function_4b74c15943231980( var_65031210c3b1299b.var_aa99c9f15fe4087c );
        }
        
        self.emergence_spawning_host_data = [];
        function_172f1f946e9646e9( var_65031210c3b1299b.var_a16139bdc289b58b );
        callback::add( "killed_body_cloned", &do_emergence_spawning );
        utility::ent_flag_set( "emergence_spawning_mapping_created" );
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0x627caf24, Offset: 0x465
// Size: 0x168, Type: bool
function function_5b6b730e9f21cb98( roundnumber )
{
    assert( utility::ent_flag_exist( "<dev string:x24>" ), "<dev string:x3d>" );
    
    if ( !self._blackboard.var_a7ac06c0829177ee && !self._blackboard.var_7ee6e625fa8c93d3 )
    {
        return false;
    }
    
    utility::ent_flag_wait_or_timeout( "pre_init_enable_emergence_spawning_through_death_bypass_round_restrictions", 1 );
    var_809e989a604b00e8 = self function_f398d739dc0cd5c3();
    
    if ( isdefined( var_809e989a604b00e8 ) )
    {
        var_36e9f84587feb5fe = getdvarint( @"hash_6b3d400b9525fc5f", 0 ) > 0 || level.var_2ac5b8bd5935b217 || self.var_2ac5b8bd5935b217;
        
        foreach ( aisubclass in var_809e989a604b00e8 )
        {
            if ( level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] <= roundnumber )
            {
                return true;
            }
            
            if ( var_36e9f84587feb5fe )
            {
                if ( isdefined( aisubclass ) )
                {
                    aitype = function_b3988325430ce242( aisubclass );
                    
                    if ( isdefined( aitype ) )
                    {
                        if ( isaitypenamevalid( aitype ) )
                        {
                            return true;
                        }
                    }
                }
            }
        }
    }
    
    return false;
}

// Namespace zombie_emergence_spawning
// Params 0
// Checksum 0x42ffabe7, Offset: 0x5d6
// Size: 0x3e
function function_748dd662235c0bf()
{
    if ( self._blackboard.var_a7ac06c0829177ee )
    {
        self.var_2ac5b8bd5935b217 = 1;
    }
    
    if ( !utility::ent_flag_exist( "register_emergence_spawning_settings_through_death_completed" ) )
    {
        utility::ent_flag_set( "pre_init_enable_emergence_spawning_through_death_bypass_round_restrictions" );
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0xd08ee47e, Offset: 0x61c
// Size: 0x97
function enable_emergence_spawning( var_f6c06c22a8f759eb )
{
    if ( self._blackboard.var_a7ac06c0829177ee && !self._blackboard.var_1499c965638cbfd7 )
    {
        if ( !utility::ent_flag_exist( "post_host_spawn_enable_emergence_spawning_through_death_finished" ) )
        {
            utility::ent_flag_set( "post_host_spawn_enable_emergence_spawning_through_death_finished" );
        }
        
        if ( var_f6c06c22a8f759eb )
        {
            self._blackboard.var_1499c965638cbfd7 = 1;
        }
        else
        {
            thread function_c6734cfadc759cd7();
        }
    }
    
    if ( self._blackboard.var_7ee6e625fa8c93d3 )
    {
        thread function_d353673637b4a0e9();
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0x5864ddbb, Offset: 0x6bb
// Size: 0x80
function function_80623a2279a4d888( params )
{
    if ( self._blackboard.var_a7ac06c0829177ee )
    {
        thread function_6d1cec596dab9468();
    }
    
    if ( self._blackboard.var_7ee6e625fa8c93d3 )
    {
        self notify( #"disable_emergence_spawning_evolution" );
        
        if ( utility::ent_flag_exist( "emergence_spawning_through_evolution_starting" ) )
        {
            utility::ent_flag_clear( "emergence_spawning_through_evolution_starting" );
        }
        
        utility::function_32b24db3127bff40( "transform", "transform_off" );
        self.var_37c2843f53972526 = undefined;
    }
}

// Namespace zombie_emergence_spawning
// Params 3
// Checksum 0xed3cf85e, Offset: 0x743
// Size: 0x183
function force_emergence_spawning( value, var_c2046153af2b2d64, var_9415ad73db383876 = 0 )
{
    if ( !self._blackboard.var_a7ac06c0829177ee && !self._blackboard.var_7ee6e625fa8c93d3 )
    {
        return;
    }
    
    if ( !var_9415ad73db383876 )
    {
        var_809e989a604b00e8 = self function_f398d739dc0cd5c3();
        
        foreach ( aisubclass in var_809e989a604b00e8 )
        {
            if ( !isdefined( level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] ) )
            {
                return;
            }
        }
    }
    
    if ( isdefined( self._blackboard.var_a7ac06c0829177ee ) )
    {
        self._blackboard.var_48a1f339d41c8986 = value;
        
        if ( var_c2046153af2b2d64 )
        {
            if ( self._blackboard.var_397bfb4ed7256a7a )
            {
                thread function_2849c1fb1cefdd14();
            }
            else
            {
                self.var_a13bed1ac47e1b2c = 1;
                self.noragdoll = 1;
                self kill();
            }
        }
    }
    
    if ( self._blackboard.var_7ee6e625fa8c93d3 && value )
    {
        thread force_emergence_spawning_through_evolution( var_c2046153af2b2d64 );
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0xea6234f9, Offset: 0x8ce
// Size: 0x2b
function function_efc0cf237cec322b( dist )
{
    if ( is_emergence_spawning_enabled() )
    {
        self._blackboard.var_436257e172a228a7 = dist;
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0xf67e6a05, Offset: 0x901
// Size: 0x31
function function_cc83d10b65f73ee( seconds )
{
    if ( is_emergence_spawning_enabled() )
    {
        self._blackboard.var_5d7a0203e35cff2f = utility::function_4b74c15943231980( seconds );
    }
}

// Namespace zombie_emergence_spawning
// Params 0
// Checksum 0xaa66c66, Offset: 0x93a
// Size: 0x2c, Type: bool
function is_emergence_spawning_enabled()
{
    return self._blackboard.var_a7ac06c0829177ee || self._blackboard.var_c5cb1817f727c385;
}

// Namespace zombie_emergence_spawning
// Params 2
// Checksum 0x482a7954, Offset: 0x96f
// Size: 0x23
function register_emergence_spawning_host_data( id, var_dc455978ffd98d95 )
{
    self.emergence_spawning_host_data[ id ] = var_dc455978ffd98d95;
}

// Namespace zombie_emergence_spawning
// Params 2
// Checksum 0xfe2941b1, Offset: 0x99a
// Size: 0x28
function function_6ced86fc637eb406( id, var_dc455978ffd98d95 )
{
    if ( isdefined( self.emergence_spawning_host_data[ id ] ) )
    {
        var_dc455978ffd98d95 = undefined;
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0x6099e979, Offset: 0x9ca
// Size: 0x23
function register_emergence_spawning_through_death_func( emergence_spawning_func )
{
    self.emergence_spawning_through_death_functions[ self.emergence_spawning_through_death_functions.size ] = emergence_spawning_func;
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0x4a560b9f, Offset: 0x9f5
// Size: 0x8c
function register_emergence_spawning_through_death_funcs( emergence_spawning_funcs )
{
    foreach ( emergence_spawning_func in emergence_spawning_funcs )
    {
        self.emergence_spawning_through_death_functions[ self.emergence_spawning_through_death_functions.size ] = emergence_spawning_func;
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0x62ecc91a, Offset: 0xa89
// Size: 0x49
function set_emergence_spawning_through_death_percentage( value )
{
    if ( isdefined( self._blackboard.var_a7ac06c0829177ee ) )
    {
        self.var_5383a40cc937dbd1 = value;
    }
    
    if ( !utility::ent_flag_exist( "register_emergence_spawning_settings_through_death_completed" ) )
    {
        utility::ent_flag_set( "pre_init_enable_emergence_spawning_through_death_percentage_changed" );
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0x4f971fa3, Offset: 0xada
// Size: 0x41
function function_6a0536e5611ef9e4( value )
{
    if ( isdefined( self._blackboard.var_a7ac06c0829177ee ) )
    {
        self.var_5383a40cc937dbd1 = value ?? self.var_5383a40cc937dbd1;
        thread function_2f0f2cbcbdc33995();
    }
}

// Namespace zombie_emergence_spawning
// Params 0
// Checksum 0x67d7554b, Offset: 0xb23
// Size: 0x16, Type: bool
function is_emergence_spawning_through_death_enabled()
{
    return istrue( self._blackboard.var_a7ac06c0829177ee );
}

// Namespace zombie_emergence_spawning
// Params 0
// Checksum 0x3eeba9d9, Offset: 0xb42
// Size: 0x2c, Type: bool
function function_7922b2bb1359d329()
{
    return self._blackboard.var_a7ac06c0829177ee && self._blackboard.var_1499c965638cbfd7;
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0xaf577cb4, Offset: 0xb77
// Size: 0x2a
function disable_emergence_spawning_on_death( params )
{
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 3 );
    
    if ( function_7922b2bb1359d329() )
    {
        function_80623a2279a4d888();
    }
}

// Namespace zombie_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0xa3546bcb, Offset: 0xba9
// Size: 0x15e
function private function_cb2c94e45a4dde76( var_65031210c3b1299b )
{
    self endon( #"death" );
    self.emergence_spawning_through_death_functions = [];
    self._blackboard.var_a7ac06c0829177ee = 1;
    self._blackboard.var_48a1f339d41c8986 = 0;
    
    if ( !self.var_c08bad902c1d1dfd )
    {
        self.var_5383a40cc937dbd1 = getdvarfloat( @"hash_dbba9a86b67e3e41", var_65031210c3b1299b.var_5383a40cc937dbd1 );
    }
    
    thread function_6e92378b2375876d();
    callback::add( "on_zombie_ai_killed", &function_c7c1afbb929b8c9e );
    utility::ent_flag_wait_all_array( [ "zombie_asm_init_finished", "emergence_spawning_mapping_created", "post_host_spawn_enable_emergence_spawning_through_death_finished" ] );
    utility::ent_flag_wait_or_timeout( "pre_init_enable_emergence_spawning_through_death_percentage_changed", 2 );
    
    if ( function_5b6b730e9f21cb98( namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin ) ) )
    {
        var_543bd011b15f2b0d = randomfloat( 100 );
        
        if ( var_543bd011b15f2b0d <= self.var_5383a40cc937dbd1 )
        {
            self._blackboard.var_1499c965638cbfd7 = 1;
        }
        else
        {
            self._blackboard.var_1499c965638cbfd7 = 0;
            utility::ent_flag_set( "roll_for_emergence_spawning_through_death_failed" );
        }
    }
    else
    {
        self._blackboard.var_1499c965638cbfd7 = 0;
    }
    
    utility::ent_flag_set( "register_emergence_spawning_settings_through_death_completed" );
}

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0xd207e274, Offset: 0xd0f
// Size: 0x56
function private function_c6734cfadc759cd7()
{
    self endon( #"death" );
    utility::ent_flag_wait( "register_emergence_spawning_settings_through_death_completed" );
    
    if ( utility::ent_flag_exist( "roll_for_emergence_spawning_through_death_failed" ) )
    {
        self._blackboard.var_1499c965638cbfd7 = 0;
        return;
    }
    
    self._blackboard.var_1499c965638cbfd7 = 1;
}

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0xcb5a60b2, Offset: 0xd6d
// Size: 0xce
function private function_2f0f2cbcbdc33995()
{
    self endon( #"death" );
    utility::ent_flag_wait( "register_emergence_spawning_settings_through_death_completed" );
    
    if ( function_5b6b730e9f21cb98( namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin ) ) )
    {
        var_543bd011b15f2b0d = randomfloat( 100 );
        
        if ( var_543bd011b15f2b0d <= self.var_5383a40cc937dbd1 )
        {
            self._blackboard.var_1499c965638cbfd7 = 1;
            
            if ( utility::ent_flag_exist( "roll_for_emergence_spawning_through_death_failed" ) )
            {
                utility::ent_flag_clear( "roll_for_emergence_spawning_through_death_failed" );
            }
        }
        else
        {
            self._blackboard.var_1499c965638cbfd7 = 0;
            
            if ( !utility::ent_flag_exist( "roll_for_emergence_spawning_through_death_failed" ) )
            {
                utility::ent_flag_set( "roll_for_emergence_spawning_through_death_failed" );
            }
        }
        
        return;
    }
    
    self._blackboard.var_1499c965638cbfd7 = 0;
}

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x8da39752, Offset: 0xe43
// Size: 0x26
function private function_6e92378b2375876d()
{
    self endon( #"terminate_death_thread" );
    self waittill( #"zombie_emergence_spawning_through_death" );
    self.var_a13bed1ac47e1b2c = 1;
}

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0xedbc10df, Offset: 0xe71
// Size: 0x64
function private function_6d1cec596dab9468()
{
    self endon( #"death" );
    
    if ( self._blackboard.var_a7ac06c0829177ee && self._blackboard.var_1499c965638cbfd7 )
    {
        if ( isalive( self ) )
        {
            utility::ent_flag_wait( "post_host_spawn_enable_emergence_spawning_through_death_finished" );
        }
        
        self._blackboard.var_1499c965638cbfd7 = 0;
    }
}

// Namespace zombie_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0xe2439d93, Offset: 0xedd
// Size: 0x165
function private function_c7c1afbb929b8c9e( params )
{
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 3 );
    
    if ( function_7922b2bb1359d329() )
    {
        var_eff46547d44da942 = 0;
        
        if ( self.var_65522105f3bdca37 || isdefined( self.var_bd22ba6c600a23a3 ) || self.var_ff03aca8518f1161 || self.forceannihilate || self.var_48960fedb514aedd )
        {
            var_eff46547d44da942 = 1;
        }
        else if ( ai::should_do_immediate_ragdoll() )
        {
            var_eff46547d44da942 = 1;
        }
        else
        {
            var_f63fbab1d2efe396 = params.eattacker.currentprimaryweapon;
            
            if ( isdefined( var_f63fbab1d2efe396 ) && function_ec5e321fe43d2fc( var_f63fbab1d2efe396 ) )
            {
                var_eff46547d44da942 = 1;
            }
        }
        
        var_809e989a604b00e8 = self function_f398d739dc0cd5c3();
        
        foreach ( aisubclass in var_809e989a604b00e8 )
        {
            if ( !isdefined( level.var_a009ab14ee0d3223.var_75817f97ecc62f4[ aisubclass ] ) )
            {
                var_eff46547d44da942 = 1;
                break;
            }
        }
        
        if ( var_eff46547d44da942 )
        {
            function_80623a2279a4d888();
        }
        
        self function_70fe9fc796b94a64();
    }
}

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x795426e3, Offset: 0x104a
// Size: 0x5a
function private function_2849c1fb1cefdd14()
{
    self endon( #"death" );
    self._blackboard.var_89af3e0b1e21175 = 1;
    
    while ( self._blackboard.var_397bfb4ed7256a7a )
    {
        waitframe();
    }
    
    self.var_a13bed1ac47e1b2c = 1;
    self.noragdoll = 1;
    self kill();
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0xd42e8056, Offset: 0x10ac
// Size: 0x24
function set_emergence_spawning_through_evolution_percentage( value )
{
    if ( isdefined( self.var_c5cb1817f727c385 ) )
    {
        self.var_d2bf06613fb462fa = value;
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0xbd70b519, Offset: 0x10d8
// Size: 0x24
function function_dc1347520c095e22( seconds )
{
    if ( isdefined( self.var_a2382de1a0db3a3b ) )
    {
        self.var_a2382de1a0db3a3b = seconds;
    }
}

// Namespace zombie_emergence_spawning
// Params 1
// Checksum 0xd051cd80, Offset: 0x1104
// Size: 0x24
function function_a3caa835e90cae28( seconds )
{
    if ( isdefined( self.var_93ceea3a043c8451 ) )
    {
        self.var_93ceea3a043c8451 = seconds;
    }
}

// Namespace zombie_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x26be8b73, Offset: 0x1130
// Size: 0x84
function private function_6d88bb886591529d( var_65031210c3b1299b )
{
    self._blackboard.var_7ee6e625fa8c93d3 = 1;
    self._blackboard.var_5f2c4e295aea3c41 = 0;
    self.var_d2bf06613fb462fa = var_65031210c3b1299b.var_c7cf68fc0d068e86;
    self.var_a2382de1a0db3a3b = var_65031210c3b1299b.var_a2382de1a0db3a3b;
    self.var_93ceea3a043c8451 = var_65031210c3b1299b.var_93ceea3a043c8451;
    callback::add( "on_turned", &function_80623a2279a4d888 );
}

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x58d59320, Offset: 0x11bc
// Size: 0x40
function private function_d353673637b4a0e9()
{
    self endon( #"death" );
    self endon( #"disable_emergence_spawning_evolution" );
    
    while ( true )
    {
        self.var_37c2843f53972526 = gettime();
        wait self.var_a2382de1a0db3a3b;
        thread function_35980a6fa5206c83();
    }
}

// Namespace zombie_emergence_spawning
// Params 0, eflags: 0x4
// Checksum 0x4ce30e00, Offset: 0x1204
// Size: 0x109
function private function_35980a6fa5206c83()
{
    self endon( #"death" );
    self endon( #"disable_emergence_spawning_evolution" );
    var_8f94892f2f318ecd = randomfloat( 100 );
    self notify( #"hash_5900def43a1a8f58", var_8f94892f2f318ecd );
    var_6910e6ddc7c1c955 = getdvarfloat( @"hash_ca90eab9b5e255f2", self.var_d2bf06613fb462fa );
    
    if ( var_8f94892f2f318ecd <= var_6910e6ddc7c1c955 && !utility::ent_flag_exist( "emergence_spawning_through_evolution_starting" ) )
    {
        utility::ent_flag_set( "emergence_spawning_through_evolution_starting" );
        utility::function_32b24db3127bff40( "transform", "transform_tell" );
        wait self.var_93ceea3a043c8451;
        self._blackboard.var_5f2c4e295aea3c41 = 1;
        
        if ( self._blackboard.var_397bfb4ed7256a7a )
        {
            self._blackboard.var_89af3e0b1e21175 = 1;
        }
        
        self waittill( #"evolution_start" );
        self.var_a13bed1ac47e1b2c = 1;
        self.noragdoll = 1;
        self function_70fe9fc796b94a64();
        self kill();
    }
}

// Namespace zombie_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x1b188268, Offset: 0x1315
// Size: 0xcd
function private force_emergence_spawning_through_evolution( var_ef0910b696aaaa4a )
{
    self endon( #"death" );
    self endon( #"disable_emergence_spawning_evolution" );
    
    if ( isdefined( self._blackboard.var_7ee6e625fa8c93d3 ) )
    {
        if ( !var_ef0910b696aaaa4a )
        {
            utility::function_32b24db3127bff40( "transform", "transform_tell" );
            wait self.var_93ceea3a043c8451;
        }
        
        self._blackboard.var_5f2c4e295aea3c41 = 1;
        
        if ( self._blackboard.var_397bfb4ed7256a7a )
        {
            self._blackboard.var_89af3e0b1e21175 = 1;
        }
        
        self waittill( #"evolution_start" );
        self.var_a13bed1ac47e1b2c = 1;
        self.noragdoll = 1;
        self function_70fe9fc796b94a64();
        self kill();
    }
}

// Namespace zombie_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0xc425ea01, Offset: 0x13ea
// Size: 0x86
function private function_172f1f946e9646e9( ai_subclasses )
{
    foreach ( current_ai_subclass in ai_subclasses )
    {
        self function_9c1822af4beaa820( current_ai_subclass.aisubclass );
    }
}

// Namespace zombie_emergence_spawning
// Params 1, eflags: 0x4
// Checksum 0x6d046ee0, Offset: 0x1478
// Size: 0x2f5
function private do_emergence_spawning( params )
{
    if ( !isdefined( params.body ) )
    {
        return;
    }
    
    if ( self.emergence_spawning_through_death_functions.size > 0 )
    {
        var_6d0184a7adaeee0c = [];
        
        foreach ( emergence_spawn_func in self.emergence_spawning_through_death_functions )
        {
            var_6d0184a7adaeee0c[ var_6d0184a7adaeee0c.size ] = emergence_spawn_func;
        }
    }
    
    if ( isdefined( self.emergence_spawning_host_data ) )
    {
        emergence_spawning_host_data = self.emergence_spawning_host_data;
    }
    
    emergence_spawn_method = "";
    
    if ( self._blackboard.var_a7ac06c0829177ee )
    {
        emergence_spawn_method = "spawned_from_emergence_through_death";
    }
    else if ( self._blackboard.var_7ee6e625fa8c93d3 )
    {
        emergence_spawn_method = "spawned_from_emergence_through_evolution";
    }
    
    params.body waittill( #"emergence_spawn", alias, tag, spawning_ai_subclass );
    
    if ( !isdefined( spawning_ai_subclass ) )
    {
        return;
    }
    
    aitypes = function_b3988325430ce242( spawning_ai_subclass );
    
    if ( !isdefined( aitypes ) )
    {
        return;
    }
    
    if ( isdefined( var_6d0184a7adaeee0c ) )
    {
        foreach ( emergence_spawn_func in var_6d0184a7adaeee0c )
        {
            [[ emergence_spawn_func ]]( params.body, spawning_ai_subclass );
        }
    }
    
    spawnangles = params.body gettagangles( tag );
    zombie = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitypes, params.body.origin, spawnangles, params.body.team );
    
    if ( isdefined( zombie ) )
    {
        zombie.var_b88c60078c599375 = 1;
        zombie notify( emergence_spawn_method );
        zombie thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( alias, alias, params.body.origin, spawnangles, "spawn_animating" );
        zombie linkto( params.body, "tag_origin" );
        zombie utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 3 );
        
        if ( zombie function_5b6b730e9f21cb98( namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( zombie.origin ) ) )
        {
            zombie enable_emergence_spawning();
        }
        
        params = spawnstruct();
        
        if ( isdefined( emergence_spawning_host_data ) )
        {
            params.var_dc455978ffd98d95 = emergence_spawning_host_data;
        }
        
        zombie callback::callback( "spawned_from_emergence", params );
    }
}

/#

    // Namespace zombie_emergence_spawning
    // Params 0
    // Checksum 0x196e90b8, Offset: 0x1775
    // Size: 0x4d, Type: dev
    function setup_emergence_spawning_devgui()
    {
        devgui::add_devgui_func( "<dev string:x98>", "<dev string:xd0>", &toggle_emergence_spawning_through_death, 1 );
        devgui::add_devgui_func( "<dev string:xf8>", "<dev string:x13e>", &toggle_emergence_spawning_through_evolution, 1 );
        devgui::add_devgui_func( "<dev string:x16a>", "<dev string:x1ba>", &function_d4d5afcc5faa230f, 1 );
    }

    // Namespace zombie_emergence_spawning
    // Params 0, eflags: 0x4
    // Checksum 0xab53c2da, Offset: 0x17ca
    // Size: 0x8c, Type: dev
    function private toggle_emergence_spawning_through_death()
    {
        zombies = getaispeciesarray( "<dev string:x1f0>", "<dev string:x1f4>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        
        if ( !isalive( var_88f817d755d2b49c ) )
        {
            return;
        }
        
        if ( !var_88f817d755d2b49c._blackboard.var_a7ac06c0829177ee )
        {
            return;
        }
        
        var_88f817d755d2b49c force_emergence_spawning( !var_88f817d755d2b49c._blackboard.var_48a1f339d41c8986 );
    }

    // Namespace zombie_emergence_spawning
    // Params 0, eflags: 0x4
    // Checksum 0xcc2f6e15, Offset: 0x185e
    // Size: 0x9a, Type: dev
    function private toggle_emergence_spawning_through_evolution()
    {
        zombies = getaispeciesarray( "<dev string:x1f0>", "<dev string:x1f4>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        
        if ( !isalive( var_88f817d755d2b49c ) )
        {
            return;
        }
        
        if ( !var_88f817d755d2b49c._blackboard.var_7ee6e625fa8c93d3 )
        {
            return;
        }
        
        if ( var_88f817d755d2b49c getscriptablepartstate( "<dev string:x1fb>", 1 ) == "<dev string:x205>" )
        {
            var_88f817d755d2b49c function_80623a2279a4d888();
            return;
        }
        
        var_88f817d755d2b49c force_emergence_spawning( 1 );
    }

    // Namespace zombie_emergence_spawning
    // Params 0, eflags: 0x4
    // Checksum 0xa473594d, Offset: 0x1900
    // Size: 0x238, Type: dev
    function private function_d4d5afcc5faa230f()
    {
        info_text_color = ( 1, 0, 0 );
        var_7b93b2cd5eaf0c54 = ( 1, 1, 0 );
        var_43cb95fce7cf58ac = ( 0, 1, 0 );
        zombies = getaispeciesarray( "<dev string:x1f0>", "<dev string:x1f4>" );
        var_88f817d755d2b49c = utility::get_array_of_closest( level.players[ 0 ].origin, zombies )[ 0 ];
        
        while ( true )
        {
            if ( !( isdefined( var_88f817d755d2b49c ) && isdefined( var_88f817d755d2b49c._blackboard.var_7ee6e625fa8c93d3 ) ) )
            {
                return;
            }
            
            if ( var_88f817d755d2b49c getscriptablehaspart( "<dev string:x1fb>" ) && var_88f817d755d2b49c getscriptablepartstate( "<dev string:x1fb>", 1 ) != "<dev string:x205>" )
            {
                level debug::function_298a6c4895b8935d( ( 200, 800, 0 ) );
                
                if ( isdefined( var_88f817d755d2b49c.var_37c2843f53972526 ) )
                {
                    var_18adf5d8db52dd66 = var_88f817d755d2b49c.var_a2382de1a0db3a3b - utility::function_6f5d2e1f1ff70482( gettime() - var_88f817d755d2b49c.var_37c2843f53972526 );
                    
                    if ( var_18adf5d8db52dd66 <= 0 )
                    {
                        var_88f817d755d2b49c waittill( #"hash_5900def43a1a8f58", var_8f94892f2f318ecd );
                        level debug::function_9de8db536c079b2d();
                        var_d906a13273ba0450 = 0;
                        
                        if ( var_8f94892f2f318ecd > var_88f817d755d2b49c.var_d2bf06613fb462fa )
                        {
                            while ( var_d906a13273ba0450 <= 100 )
                            {
                                level debug::function_298a6c4895b8935d( ( 200, 800, 0 ) );
                                level debug::function_ce323c1a383e915( "<dev string:x214>" + var_8f94892f2f318ecd + "<dev string:x226>" + var_88f817d755d2b49c.var_d2bf06613fb462fa + "<dev string:x231>", var_7b93b2cd5eaf0c54 );
                                level debug::function_9de8db536c079b2d();
                                waitframe();
                                var_d906a13273ba0450++;
                            }
                            
                            continue;
                        }
                        else
                        {
                            while ( var_d906a13273ba0450 <= 100 )
                            {
                                level debug::function_298a6c4895b8935d( ( 200, 800, 0 ) );
                                level debug::function_ce323c1a383e915( "<dev string:x245>", var_43cb95fce7cf58ac );
                                level debug::function_9de8db536c079b2d();
                                waitframe();
                                var_d906a13273ba0450++;
                            }
                            
                            continue;
                        }
                    }
                    else
                    {
                        level debug::function_ce323c1a383e915( "<dev string:x268>" + var_18adf5d8db52dd66, info_text_color );
                    }
                }
                else
                {
                    level debug::function_ce323c1a383e915( "<dev string:x292>", info_text_color );
                }
                
                level debug::function_9de8db536c079b2d();
            }
            
            waitframe();
        }
    }

#/
