// scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_parts.gsc  (hash_3ef59a6cab975205.gscc) (size: 15887 Bytes / 0x3e0f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb8b38a28 (3098774056)
// size ...... 15887 (0x3e0f)
// includes .. 10  (offset: 0x39b7)
// strings ... 34  (offset: 0x3a07)
// dev strs .. 39  (offset: 0x3c1b)
// exports ... 47  (offset: 0x23c3)
// cseg ...... 0x2d8 + 0x20eb (0x23c3)
// imports ... 111 (offset: 0x2b1b)
// animtree1 . 0   (offset: 0x3e0f)
// animtree2 . 0   (offset: 0x3e0f)
#using script_769dd81873f99e4f;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam;
#using scripts\common\ai\aitypes\zombie_amalgam\zombie_amalgam_regeneration;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_amalgam_parts;

// Namespace zombie_amalgam_parts
// Params 0
// Checksum 0x4fdf138, Offset: 0x2f6
// Size: 0xc9
function init_zombie_amalgam_parts_global()
{
    level.var_66ca2017cfdc58fc = [ "head1_front_le", "head1_front_ri", "head1_top_front_le" ];
    level.var_63c71d60e4c0b26e = [ "head1_back_le", "head1_back_ri" ];
    level.var_f0174f532e043846 = [ "arm_back_le", "arm_back_ri", "arm_top_front", "arm_top_le", "arm_top_back_le", "arm_top_back_ri" ];
    level.var_ec01df80fd50ff00 = [ "leg_le", "leg_ri" ];
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_80fa84c1d72876b6 );
    
    /#
        function_6ddc2621f3963dff();
    #/
}

// Namespace zombie_amalgam_parts
// Params 0
// Checksum 0x1646838d, Offset: 0x3c7
// Size: 0x71
function init_zombie_amalgam_parts()
{
    self endon( #"death" );
    set_extra_arm_count( 0 );
    set_extra_leg_count( 0 );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    function_c6e7bb9763c8e2b1();
    self function_786bb6aa1b76c7ee( "pain_stagger_cooldown_ms", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_10268c652e7dffa8 * 1000 );
    thread grab_arm_watcher();
    utility::ent_flag_set( "amalgam_parts_inited" );
}

// Namespace zombie_amalgam_parts
// Params 1
// Checksum 0x23102a11, Offset: 0x440
// Size: 0x55
function restore_metabones( params )
{
    self endon( #"death" );
    utility::ent_flag_wait( "amalgam_parts_inited" );
    utility::ent_flag_clear( "amalgam_parts_inited", 1 );
    metabone::restore_metabones( params.saved_metabones );
    function_2ec6981536d6b00d();
    
    /#
        function_8f373160f49620ac();
    #/
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0xed6e0ee5, Offset: 0x49d
// Size: 0x13c
function private function_2ec6981536d6b00d()
{
    var_eacf8197ad364090 = 0;
    
    if ( !is_scriptable_part_off( "grab_arm" ) )
    {
        var_eacf8197ad364090++;
    }
    
    foreach ( index in self.var_87630a961469b28e )
    {
        if ( !is_scriptable_part_off( function_98960fd16f504e5e( index ) ) )
        {
            var_eacf8197ad364090++;
        }
    }
    
    set_extra_arm_count( var_eacf8197ad364090 );
    var_5a63927a9df912b6 = 0;
    
    foreach ( index in self.var_a2cb952f34ef148 )
    {
        if ( !is_scriptable_part_off( function_f574ecef9a97c900( index ) ) )
        {
            var_5a63927a9df912b6++;
        }
    }
    
    set_extra_leg_count( var_5a63927a9df912b6 );
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0xe5d84bc8, Offset: 0x5e1
// Size: 0x11b
function private function_80fa84c1d72876b6( params )
{
    if ( isdefined( params.shitloc ) )
    {
        leg = undefined;
        
        switch ( params.shitloc )
        {
            case #"hash_168c74e879f0ba11":
            case #"hash_7b36142458a6c2d5":
            case #"hash_810a7426c8bac3ac":
                leg = "leg_le";
                break;
            case #"hash_1cbc508a2fe01b79":
            case #"hash_9536712388e65bce":
            case #"hash_a638fec9040cfcf4":
                leg = "leg_ri";
                
                if ( isdefined( params.vpoint ) )
                {
                    forward = anglestoforward( self.angles );
                    
                    if ( utility::isleft2d( self.origin, forward, params.vpoint ) )
                    {
                        leg = "leg_le";
                    }
                }
                
                break;
        }
        
        if ( isdefined( leg ) )
        {
            metabone::damage_metabone( leg, params.idamage, params.eattacker, params.einflictor, params.vdir );
        }
    }
}

// Namespace zombie_amalgam_parts
// Params 0
// Checksum 0x35df7607, Offset: 0x704
// Size: 0xe, Type: bool
function has_grab_arm()
{
    return !is_scriptable_part_off( "grab_arm" );
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0xe5e33935, Offset: 0x71b
// Size: 0x27
function private function_afebdbd31709abc0()
{
    self.var_54abe71e7ddcaee0 = randomintrange( 0, 2 );
    self.var_cbe93a71d1b93656 = 3 - self.var_54abe71e7ddcaee0;
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0xe393421c, Offset: 0x74a
// Size: 0x2fa
function private function_c6e7bb9763c8e2b1()
{
    while ( !isdefined( level.var_ec01df80fd50ff00 ) )
    {
        waitframe();
    }
    
    self.var_522914c02132cc64 = [];
    self.var_24c5169d1d7aa136 = [];
    self.var_87630a961469b28e = [];
    self.var_a2cb952f34ef148 = [];
    function_afebdbd31709abc0();
    self.var_522914c02132cc64 = function_1af45ee94b94f3a7( self.var_522914c02132cc64, self.var_cbe93a71d1b93656, level.var_66ca2017cfdc58fc.size );
    self.var_24c5169d1d7aa136 = function_1af45ee94b94f3a7( self.var_24c5169d1d7aa136, self.var_54abe71e7ddcaee0, level.var_63c71d60e4c0b26e.size );
    self.var_87630a961469b28e = function_1af45ee94b94f3a7( self.var_87630a961469b28e, 6, level.var_f0174f532e043846.size );
    self.var_a2cb952f34ef148 = function_1af45ee94b94f3a7( self.var_a2cb952f34ef148, 2, level.var_ec01df80fd50ff00.size );
    self.var_1e965f25e58fcda6 = 0;
    initialize_all_parts();
    function_cfb2502312f62e3b( "grab_arm", 1, 1 );
    
    foreach ( index in self.var_522914c02132cc64 )
    {
        function_cfb2502312f62e3b( function_9f0edc5183cdd55e( index ), 1, 1 );
    }
    
    foreach ( index in self.var_24c5169d1d7aa136 )
    {
        function_cfb2502312f62e3b( function_c65f9af3c4269498( index ), 1, 1 );
    }
    
    foreach ( index in self.var_87630a961469b28e )
    {
        function_cfb2502312f62e3b( function_98960fd16f504e5e( index ), 1, 1 );
    }
    
    foreach ( index in self.var_a2cb952f34ef148 )
    {
        function_cfb2502312f62e3b( function_f574ecef9a97c900( index ), 1, 1 );
    }
    
    /#
        function_8f373160f49620ac();
    #/
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0x32e5415d, Offset: 0xa4c
// Size: 0x1de
function private initialize_all_parts()
{
    function_9438409e1e98860c( "grab_arm" );
    
    foreach ( part_name in level.var_66ca2017cfdc58fc )
    {
        function_9438409e1e98860c( part_name );
    }
    
    foreach ( part_name in level.var_63c71d60e4c0b26e )
    {
        function_9438409e1e98860c( part_name );
    }
    
    foreach ( part_name in level.var_f0174f532e043846 )
    {
        function_9438409e1e98860c( part_name );
    }
    
    foreach ( part_name in level.var_ec01df80fd50ff00 )
    {
        function_9438409e1e98860c( part_name );
    }
    
    /#
        function_8f373160f49620ac();
    #/
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0x79b5b6c4, Offset: 0xc32
// Size: 0x17
function private set_extra_arm_count( count )
{
    self.extra_arm_count = count;
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0x54df0ac3, Offset: 0xc51
// Size: 0x2d
function private set_extra_leg_count( count )
{
    if ( self.extra_leg_count != count )
    {
        self.extra_leg_count = count;
        namespace_14bc21a938ce7ab8::function_a5316e87722b6ac4();
    }
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0x98de8f66, Offset: 0xc86
// Size: 0x1d
function private function_3222bb54753ccdd4()
{
    assert( isdefined( level.var_66ca2017cfdc58fc ) );
    return level.var_66ca2017cfdc58fc;
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0x44572c08, Offset: 0xcac
// Size: 0x1d
function private function_c21c5dd020c27110()
{
    assert( isdefined( level.var_63c71d60e4c0b26e ) );
    return level.var_63c71d60e4c0b26e;
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0x24eae309, Offset: 0xcd2
// Size: 0x1d
function private function_83f7c3535dc69e8a()
{
    assert( isdefined( level.var_f0174f532e043846 ) );
    return level.var_f0174f532e043846;
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0xb053dbb1, Offset: 0xcf8
// Size: 0x1d
function private function_ed8adf979a8bdeb4()
{
    assert( isdefined( level.var_ec01df80fd50ff00 ) );
    return level.var_ec01df80fd50ff00;
}

// Namespace zombie_amalgam_parts
// Params 1
// Checksum 0x6124cbed, Offset: 0xd1e
// Size: 0x2f
function function_9f0edc5183cdd55e( index )
{
    assert( index >= 0 && index < function_3222bb54753ccdd4().size );
    return function_3222bb54753ccdd4()[ index ];
}

// Namespace zombie_amalgam_parts
// Params 1
// Checksum 0xd193cdef, Offset: 0xd56
// Size: 0x2f
function function_c65f9af3c4269498( index )
{
    assert( index >= 0 && index < function_c21c5dd020c27110().size );
    return function_c21c5dd020c27110()[ index ];
}

// Namespace zombie_amalgam_parts
// Params 1
// Checksum 0x41641005, Offset: 0xd8e
// Size: 0x2f
function function_98960fd16f504e5e( index )
{
    assert( index >= 0 && index < function_83f7c3535dc69e8a().size );
    return function_83f7c3535dc69e8a()[ index ];
}

// Namespace zombie_amalgam_parts
// Params 1
// Checksum 0x9c672c8c, Offset: 0xdc6
// Size: 0x2f
function function_f574ecef9a97c900( index )
{
    assert( index >= 0 && index < function_ed8adf979a8bdeb4().size );
    return function_ed8adf979a8bdeb4()[ index ];
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0x71db7ea4, Offset: 0xdfe
// Size: 0x5a, Type: bool
function private is_scriptable_part_off( part_name )
{
    curr_state = "off";
    
    if ( self isscriptable() && self getscriptablehaspart( part_name ) )
    {
        curr_state = self getscriptablepartstate( part_name, 1 );
        assert( isdefined( curr_state ) );
    }
    
    return curr_state == "off" || curr_state == "destroyed";
}

// Namespace zombie_amalgam_parts
// Params 3
// Checksum 0x5851c073, Offset: 0xe61
// Size: 0x126
function function_cfb2502312f62e3b( part_name, b_reset_health, var_d48d62a7f69c6ec3 )
{
    if ( var_d48d62a7f69c6ec3 && self.b_evolved )
    {
        utility::function_32b24db3127bff40( part_name, "on" );
    }
    else
    {
        utility::function_32b24db3127bff40( part_name, "regen" );
    }
    
    metabone::set_metabone_active( part_name, 1 );
    metabone::set_metabone_state( part_name, "grown" );
    
    if ( b_reset_health )
    {
        max_health = metabone::get_metabone_maxhealth( part_name, "grown" );
        metabone::set_metabone_health( part_name, max_health, "grown" );
    }
    
    if ( isstartstr( part_name, "arm" ) || part_name == "grab_arm" )
    {
        set_extra_arm_count( self.extra_arm_count + 1 );
    }
    else if ( isstartstr( part_name, "leg" ) )
    {
        set_extra_leg_count( self.extra_leg_count + 1 );
    }
    else if ( isstartstr( part_name, "head" ) && zombie_utils::function_bf1464d09f4e4b40() )
    {
        utility::function_32b24db3127bff40( part_name, "brainrot" );
    }
    
    self.var_d2cdd2dee55139b4 = gettime();
    
    /#
        function_8f373160f49620ac();
    #/
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0x37b1530a, Offset: 0xf8f
// Size: 0x33
function private function_8b1cc503631b1e0e( part_name )
{
    metabone::set_metabone_active( part_name, 0 );
    metabone::set_metabone_health( part_name, 0, "grown" );
    metabone::set_metabone_state( part_name, "destroyed" );
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0x675ef017, Offset: 0xfca
// Size: 0x23
function private function_9438409e1e98860c( part_name )
{
    utility::function_32b24db3127bff40( part_name, "off" );
    function_8b1cc503631b1e0e( part_name );
}

// Namespace zombie_amalgam_parts
// Params 1
// Checksum 0x2603aa77, Offset: 0xff5
// Size: 0x349
function function_89631485e1e3ebec( part_name )
{
    utility::function_32b24db3127bff40( part_name, "destroyed" );
    function_8b1cc503631b1e0e( part_name );
    
    /#
        function_311b31d06d9068d7( part_name, metabone::function_30d906ccb9fe2142() );
    #/
    
    namespace_22232c840a00551b::delay_health_regen( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.healthregendelaydestruction );
    var_20bc9f80f5b31a3c = getdvarint( @"hash_8e93baafb7ed1a9b", 1 );
    b_allow_pain = var_20bc9f80f5b31a3c == 1 || self getaiblackboarddynamic( "in_grab_attack" ) <= 0;
    
    if ( part_name == "grab_arm" )
    {
        set_extra_arm_count( self.extra_arm_count - 1 );
    }
    else if ( isstartstr( part_name, "head1_back" ) )
    {
        b_allow_pain = b_allow_pain || var_20bc9f80f5b31a3c == 2;
        ai::set_blackboard_cooldown( "weakpoint_destroyed_pain_timeout", 250 );
        self.var_24c5169d1d7aa136 = function_34a758ff040b8dc( self.var_24c5169d1d7aa136, function_c21c5dd020c27110(), part_name );
        function_afebdbd31709abc0();
        
        if ( self.var_54abe71e7ddcaee0 == 0 )
        {
            self.var_522914c02132cc64 = function_4c973772a79945f7( self.var_522914c02132cc64, function_3222bb54753ccdd4(), self.var_cbe93a71d1b93656 );
        }
        else
        {
            self.var_24c5169d1d7aa136 = function_4c973772a79945f7( self.var_24c5169d1d7aa136, function_c21c5dd020c27110(), self.var_54abe71e7ddcaee0 );
        }
        
        thread regrow_head();
    }
    else if ( isstartstr( part_name, "head1" ) )
    {
        b_allow_pain = b_allow_pain || var_20bc9f80f5b31a3c == 2;
        ai::set_blackboard_cooldown( "weakpoint_destroyed_pain_timeout", 250 );
        self.var_522914c02132cc64 = function_34a758ff040b8dc( self.var_522914c02132cc64, function_3222bb54753ccdd4(), part_name );
        
        if ( self.var_54abe71e7ddcaee0 == 0 )
        {
            function_afebdbd31709abc0();
            var_b4b184e67d3253f = self.var_54abe71e7ddcaee0 > 0;
        }
        
        if ( var_b4b184e67d3253f )
        {
            self.var_24c5169d1d7aa136 = function_4c973772a79945f7( self.var_24c5169d1d7aa136, function_c21c5dd020c27110(), self.var_54abe71e7ddcaee0 );
        }
        else
        {
            self.var_522914c02132cc64 = function_4c973772a79945f7( self.var_522914c02132cc64, function_3222bb54753ccdd4(), self.var_cbe93a71d1b93656 );
        }
        
        thread regrow_head();
    }
    else if ( isstartstr( part_name, "arm" ) )
    {
        self.var_87630a961469b28e = function_34a758ff040b8dc( self.var_87630a961469b28e, function_83f7c3535dc69e8a(), part_name );
        self.var_87630a961469b28e = function_4c973772a79945f7( self.var_87630a961469b28e, function_83f7c3535dc69e8a(), 6 );
        set_extra_arm_count( self.extra_arm_count - 1 );
    }
    else if ( isstartstr( part_name, "leg" ) )
    {
        self.var_a2cb952f34ef148 = function_34a758ff040b8dc( self.var_a2cb952f34ef148, function_ed8adf979a8bdeb4(), part_name );
        self.var_a2cb952f34ef148 = function_4c973772a79945f7( self.var_a2cb952f34ef148, function_ed8adf979a8bdeb4(), 2 );
        set_extra_leg_count( self.extra_leg_count - 1 );
    }
    
    if ( b_allow_pain && self asmhaspainstate( self.asmname ) && !self function_1b4c437a6367712b() )
    {
        self asmevalpaintransition( self.asmname );
    }
    
    self.var_1e965f25e58fcda6++;
    
    /#
        function_8f373160f49620ac();
    #/
}

// Namespace zombie_amalgam_parts
// Params 3, eflags: 0x4
// Checksum 0x4d07544a, Offset: 0x1346
// Size: 0x60
function private function_34a758ff040b8dc( var_c191200e987ad232, parts_array, old_part_name )
{
    for ( i = 0; i < var_c191200e987ad232.size ; i++ )
    {
        if ( parts_array[ var_c191200e987ad232[ i ] ] == old_part_name )
        {
            var_c191200e987ad232[ i ] = var_c191200e987ad232[ var_c191200e987ad232.size - 1 ];
            var_c191200e987ad232[ var_c191200e987ad232.size - 1 ] = undefined;
            break;
        }
    }
    
    return var_c191200e987ad232;
}

// Namespace zombie_amalgam_parts
// Params 3, eflags: 0x4
// Checksum 0x848c356, Offset: 0x13af
// Size: 0x64
function private function_4c973772a79945f7( var_c191200e987ad232, parts_array, desired_num_active )
{
    var_49d78beb3115d1d1 = var_c191200e987ad232.size;
    var_c191200e987ad232 = function_1af45ee94b94f3a7( var_c191200e987ad232, desired_num_active, parts_array.size );
    
    for ( i = var_49d78beb3115d1d1; i < var_c191200e987ad232.size ; i++ )
    {
        function_8b1cc503631b1e0e( parts_array[ var_c191200e987ad232[ i ] ] );
    }
    
    return var_c191200e987ad232;
}

// Namespace zombie_amalgam_parts
// Params 3, eflags: 0x4
// Checksum 0xee46e6b7, Offset: 0x141c
// Size: 0x10b
function private function_1af45ee94b94f3a7( var_c3dd234e7c825f94, var_1dd75569b32d56dc, max_array_size )
{
    max_array_size = max_array_size >= 0 ? max_array_size : 0;
    var_1dd75569b32d56dc = var_1dd75569b32d56dc >= 0 ? var_1dd75569b32d56dc : 0;
    var_1dd75569b32d56dc = var_1dd75569b32d56dc > max_array_size ? max_array_size : var_1dd75569b32d56dc;
    
    if ( var_1dd75569b32d56dc < var_c3dd234e7c825f94.size )
    {
        for ( i = var_c3dd234e7c825f94.size - 1; i > var_1dd75569b32d56dc ; i-- )
        {
            var_c3dd234e7c825f94[ i ] = undefined;
        }
    }
    
    if ( var_1dd75569b32d56dc > var_c3dd234e7c825f94.size )
    {
        var_6aaa246915050ed = [];
        
        for ( i = 0; i < var_c3dd234e7c825f94.size ; i++ )
        {
            var_6aaa246915050ed[ var_c3dd234e7c825f94[ i ] ] = i;
        }
        
        indices = arraycopy( var_c3dd234e7c825f94 );
        
        for ( i = 0; i < max_array_size ; i++ )
        {
            if ( !isdefined( var_6aaa246915050ed[ i ] ) )
            {
                indices[ indices.size ] = i;
            }
        }
        
        for ( i = var_c3dd234e7c825f94.size; i < var_1dd75569b32d56dc ; i++ )
        {
            j = randomintrange( i, max_array_size );
            var_c3dd234e7c825f94[ i ] = indices[ j ];
            indices[ j ] = indices[ i ];
        }
    }
    
    return var_c3dd234e7c825f94;
}

// Namespace zombie_amalgam_parts
// Params 0
// Checksum 0x92bdcc55, Offset: 0x1530
// Size: 0x10b
function function_748f95a1b04f7eb()
{
    if ( function_3846d9e728748d1( "grab_arm" ) )
    {
        return;
    }
    
    foreach ( index in self.var_a2cb952f34ef148 )
    {
        if ( function_3846d9e728748d1( function_f574ecef9a97c900( index ) ) )
        {
            return;
        }
    }
    
    foreach ( index in self.var_87630a961469b28e )
    {
        if ( function_3846d9e728748d1( function_98960fd16f504e5e( index ) ) )
        {
            return;
        }
    }
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0x66a588ae, Offset: 0x1643
// Size: 0x26, Type: bool
function private function_3846d9e728748d1( part_name )
{
    if ( is_scriptable_part_off( part_name ) )
    {
        function_cfb2502312f62e3b( part_name, 1 );
        return true;
    }
    
    return false;
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0x26de9d9f, Offset: 0x1672
// Size: 0xf8
function private function_d32c2d5cd677f212()
{
    for ( i = self.var_87630a961469b28e.size - 1; i >= 0 ; i-- )
    {
        if ( function_ddd3740babe80e20( function_98960fd16f504e5e( self.var_87630a961469b28e[ i ] ) ) )
        {
            return;
        }
    }
    
    for ( i = self.var_24c5169d1d7aa136.size - 1; i >= 0 ; i-- )
    {
        if ( function_ddd3740babe80e20( function_c65f9af3c4269498( self.var_24c5169d1d7aa136[ i ] ) ) )
        {
            return;
        }
    }
    
    for ( i = self.var_522914c02132cc64.size - 1; i >= 0 ; i-- )
    {
        if ( function_ddd3740babe80e20( function_9f0edc5183cdd55e( self.var_522914c02132cc64[ i ] ) ) )
        {
            return;
        }
    }
    
    for ( i = self.var_a2cb952f34ef148.size - 1; i >= 0 ; i-- )
    {
        if ( function_ddd3740babe80e20( function_f574ecef9a97c900( self.var_a2cb952f34ef148[ i ] ) ) )
        {
            return;
        }
    }
    
    function_ddd3740babe80e20( "grab_arm" );
}

// Namespace zombie_amalgam_parts
// Params 1, eflags: 0x4
// Checksum 0x49c948c2, Offset: 0x1772
// Size: 0x80, Type: bool
function private function_ddd3740babe80e20( part_name )
{
    if ( !is_scriptable_part_off( part_name ) )
    {
        if ( isstartstr( part_name, "arm" ) || part_name == "grab_arm" )
        {
            set_extra_arm_count( self.extra_arm_count - 1 );
        }
        else if ( isstartstr( part_name, "leg" ) )
        {
            set_extra_leg_count( self.extra_leg_count - 1 );
        }
        
        function_9438409e1e98860c( part_name );
        
        /#
            function_8f373160f49620ac();
        #/
        
        return true;
    }
    
    return false;
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0x6f0f6160, Offset: 0x17fb
// Size: 0x88
function private grab_arm_watcher()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"amalgam_grab_arm_extend" );
        
        if ( !is_scriptable_part_off( "grab_arm" ) )
        {
            utility::function_32b24db3127bff40( "grab_arm", "arm_extended" );
            utility::waittill_any( "amalgam_grab_arm_retract", "amalgam_grab_end" );
            curr_state = self getscriptablepartstate( "grab_arm", 1 );
            
            if ( curr_state == "arm_extended" )
            {
                utility::function_32b24db3127bff40( "grab_arm", "on" );
            }
        }
    }
}

// Namespace zombie_amalgam_parts
// Params 0, eflags: 0x4
// Checksum 0x6aa123e2, Offset: 0x188b
// Size: 0x10b
function private regrow_head()
{
    self endon( #"death" );
    wait 2;
    
    foreach ( index in self.var_522914c02132cc64 )
    {
        if ( function_3846d9e728748d1( function_9f0edc5183cdd55e( index ) ) )
        {
            return;
        }
    }
    
    foreach ( index in self.var_24c5169d1d7aa136 )
    {
        if ( function_3846d9e728748d1( function_c65f9af3c4269498( index ) ) )
        {
            return;
        }
    }
}

/#

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0x93845cb9, Offset: 0x199e
    // Size: 0x26a, Type: dev
    function private function_8f373160f49620ac()
    {
        active_metabones = metabone::function_30d906ccb9fe2142();
        
        foreach ( index in self.var_522914c02132cc64 )
        {
            function_311b31d06d9068d7( function_9f0edc5183cdd55e( index ), active_metabones );
        }
        
        foreach ( index in self.var_24c5169d1d7aa136 )
        {
            function_311b31d06d9068d7( function_c65f9af3c4269498( index ), active_metabones );
        }
        
        var_eacf8197ad364090 = 0;
        is_scriptable_on = function_311b31d06d9068d7( "<dev string:x24>", active_metabones );
        
        if ( is_scriptable_on )
        {
            var_eacf8197ad364090++;
        }
        
        foreach ( index in self.var_87630a961469b28e )
        {
            is_scriptable_on = function_311b31d06d9068d7( function_98960fd16f504e5e( index ), active_metabones );
            
            if ( is_scriptable_on )
            {
                var_eacf8197ad364090++;
            }
        }
        
        assert( self.extra_arm_count == var_eacf8197ad364090 );
        var_5a63927a9df912b6 = 0;
        
        foreach ( index in self.var_a2cb952f34ef148 )
        {
            is_scriptable_on = function_311b31d06d9068d7( function_f574ecef9a97c900( index ), active_metabones );
            
            if ( is_scriptable_on )
            {
                var_5a63927a9df912b6++;
            }
        }
        
        assert( self.extra_leg_count == var_5a63927a9df912b6 );
    }

    // Namespace zombie_amalgam_parts
    // Params 2, eflags: 0x4
    // Checksum 0x4b4d7577, Offset: 0x1c10
    // Size: 0x199, Type: dev
    function private function_311b31d06d9068d7( part_name, active_metabones )
    {
        is_scriptable_on = !is_scriptable_part_off( part_name );
        is_metabone_active = arraycontains( active_metabones, part_name );
        b_valid_state = is_scriptable_on == is_metabone_active;
        b_grabbing = utility::ent_flag( "<dev string:x2d>" );
        var_b1251641bf5c1e88 = part_name == "<dev string:x24>" && is_scriptable_on && b_grabbing;
        
        if ( !b_valid_state && !var_b1251641bf5c1e88 )
        {
            assertmsg( "<dev string:x3d>" + part_name + "<dev string:x58>" + ( is_scriptable_on ? "<dev string:x67>" : "<dev string:x6a>" ) + "<dev string:x6e>" + ( is_metabone_active ? "<dev string:x67>" : "<dev string:x6a>" ) + "<dev string:x7b>" + ( b_grabbing ? "<dev string:x8b>" : "<dev string:x8f>" ) );
        }
        
        metabone_state = metabone::get_metabone_state_name( part_name );
        
        if ( is_scriptable_on && metabone_state == "<dev string:x92>" || !is_scriptable_on && metabone_state == "<dev string:x9c>" )
        {
            curr_state = self getscriptablepartstate( part_name, 1 );
            is_metabone_destroyed = metabone::is_metabone_destroyed( part_name );
            assertmsg( "<dev string:xa2>" + part_name + "<dev string:xb0>" + curr_state + "<dev string:xdb>" + metabone_state + "<dev string:xee>" + ( is_metabone_destroyed ? "<dev string:x105>" : "<dev string:x10a>" ) + "<dev string:x110>" + ( is_metabone_active ? "<dev string:x105>" : "<dev string:x10a>" ) );
        }
        
        return is_scriptable_on;
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0x89754758, Offset: 0x1db1
    // Size: 0xb2, Type: dev
    function private function_6ddc2621f3963dff()
    {
        devgui::function_9082edeb5db93280( "<dev string:x124>" );
        devgui::add_devgui_func( "<dev string:x13d>", "<dev string:x146>", &function_81e5e40da7870e50 );
        devgui::add_devgui_func( "<dev string:x14f>", "<dev string:x15b>", &devgui_remove_part );
        devgui::add_devgui_func( "<dev string:x167>", "<dev string:x177>", &function_6d02a3dd3d73b5b4 );
        devgui::add_devgui_func( "<dev string:x188>", "<dev string:x19b>", &function_bb6da2aba8971868 );
        devgui::add_devgui_func( "<dev string:x1ae>", "<dev string:x1ba>", &function_ddfb49bb21689a38 );
        devgui::add_devgui_func( "<dev string:x1c6>", "<dev string:x1dc>", &devgui_force_roar );
        devgui::add_devgui_func( "<dev string:x1ef>", "<dev string:x20a>", &function_83691236c631714a );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0x7b6d021b, Offset: 0x1e6b
    // Size: 0x40, Type: dev
    function private function_81e5e40da7870e50()
    {
        amalgam = zombie_amalgam::get_closest_amalgam();
        
        if ( isdefined( amalgam ) )
        {
            amalgam function_748f95a1b04f7eb();
            
            if ( getdvarint( @"amalgam_debug_parts", 0 ) )
            {
                thread function_f2b1a623cfaaece0( amalgam );
            }
        }
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0x7a1e6c74, Offset: 0x1eb3
    // Size: 0x40, Type: dev
    function private devgui_remove_part()
    {
        amalgam = zombie_amalgam::get_closest_amalgam();
        
        if ( isdefined( amalgam ) )
        {
            amalgam function_d32c2d5cd677f212();
            
            if ( getdvarint( @"amalgam_debug_parts", 0 ) )
            {
                thread function_f2b1a623cfaaece0( amalgam );
            }
        }
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0xc3389df1, Offset: 0x1efb
    // Size: 0x40, Type: dev
    function private function_6d02a3dd3d73b5b4()
    {
        amalgam = zombie_amalgam::get_closest_amalgam();
        
        if ( isdefined( amalgam ) )
        {
            amalgam initialize_all_parts();
            
            if ( getdvarint( @"amalgam_debug_parts", 0 ) )
            {
                thread function_f2b1a623cfaaece0( amalgam );
            }
        }
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0x442de8e7, Offset: 0x1f43
    // Size: 0x40, Type: dev
    function private function_bb6da2aba8971868()
    {
        amalgam = zombie_amalgam::get_closest_amalgam();
        
        if ( isdefined( amalgam ) )
        {
            amalgam function_c6e7bb9763c8e2b1();
            
            if ( getdvarint( @"amalgam_debug_parts", 0 ) )
            {
                thread function_f2b1a623cfaaece0( amalgam );
            }
        }
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0x88df711, Offset: 0x1f8b
    // Size: 0x4c, Type: dev
    function private function_ddfb49bb21689a38()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x222>", @"amalgam_debug_parts" );
        
        if ( getdvarint( @"amalgam_debug_parts", 0 ) )
        {
            amalgam = zombie_amalgam::get_closest_amalgam();
            
            if ( isdefined( amalgam ) )
            {
                thread function_f2b1a623cfaaece0( amalgam );
            }
        }
    }

    // Namespace zombie_amalgam_parts
    // Params 1, eflags: 0xc
    // Checksum 0xe7880681, Offset: 0x1fdf
    // Size: 0x275, Type: dev
    function private function_f2b1a623cfaaece0( amalgam )
    {
        self notify( #"hash_2891c68d3c2f8d14" );
        self endon( #"hash_2891c68d3c2f8d14" );
        amalgam endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"amalgam_debug_parts", 0 ) == 0 )
            {
                return;
            }
            
            count = 0;
            amalgam debug_print_part( "<dev string:x24>", count );
            count++;
            
            foreach ( index in amalgam.var_a2cb952f34ef148 )
            {
                amalgam debug_print_part( amalgam function_f574ecef9a97c900( index ), count );
                count++;
            }
            
            foreach ( index in amalgam.var_87630a961469b28e )
            {
                amalgam debug_print_part( amalgam function_98960fd16f504e5e( index ), count );
                count++;
            }
            
            foreach ( index in amalgam.var_522914c02132cc64 )
            {
                amalgam debug_print_part( amalgam function_9f0edc5183cdd55e( index ), count );
                count++;
            }
            
            foreach ( index in amalgam.var_24c5169d1d7aa136 )
            {
                amalgam debug_print_part( amalgam function_c65f9af3c4269498( index ), count );
                count++;
            }
            
            waitframe();
        }
    }

    // Namespace zombie_amalgam_parts
    // Params 2, eflags: 0x4
    // Checksum 0x222c9a13, Offset: 0x225c
    // Size: 0x80, Type: dev
    function private debug_print_part( part_name, count )
    {
        curr_state = self getscriptablepartstate( part_name, 1 );
        health = metabone::get_metabone_health( part_name, "<dev string:x9c>" );
        var_e494c40a50d04e76 = get_debug_colour( part_name, curr_state, health );
        
        /#
            printtoscreen2d( 500, 100 + count * 20, part_name + "<dev string:x236>" + curr_state + "<dev string:x239>" + health, var_e494c40a50d04e76 );
        #/
    }

    // Namespace zombie_amalgam_parts
    // Params 3, eflags: 0x4
    // Checksum 0x7fb8862f, Offset: 0x22e4
    // Size: 0x79, Type: dev
    function private get_debug_colour( part_name, curr_state, health )
    {
        if ( is_scriptable_part_off( part_name ) )
        {
            return ( 1, 0, 0 );
        }
        else
        {
            max_health = metabone::get_metabone_maxhealth( part_name, "<dev string:x9c>" );
            
            if ( health < max_health )
            {
                return ( 1, 1, 0 );
            }
        }
        
        return ( 1, 1, 1 );
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0x9373ab4c, Offset: 0x2365
    // Size: 0x2b, Type: dev
    function private devgui_force_roar()
    {
        amalgam = zombie_amalgam::get_closest_amalgam();
        
        if ( isdefined( amalgam ) )
        {
            amalgam asm::function_7256f5ba459c840b( "<dev string:x244>" );
        }
    }

    // Namespace zombie_amalgam_parts
    // Params 0, eflags: 0x4
    // Checksum 0xa3bd993e, Offset: 0x2398
    // Size: 0x2b, Type: dev
    function private function_83691236c631714a()
    {
        amalgam = zombie_amalgam::get_closest_amalgam();
        
        if ( isdefined( amalgam ) )
        {
            amalgam asm::function_7256f5ba459c840b( "<dev string:x24c>" );
        }
    }

#/
