// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_head.gsc  (hash_4d010b95de45c8b1.gscc) (size: 3314 Bytes / 0xcf2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa15dab53 (2707270483)
// size ...... 3314 (0xcf2)
// includes .. 3   (offset: 0xc02)
// strings ... 5   (offset: 0xc1a)
// dev strs .. 13  (offset: 0xc56)
// exports ... 9   (offset: 0x66a)
// cseg ...... 0xa8 + 0x5c2 (0x66a)
// imports ... 35  (offset: 0x7d2)
// animtree1 . 0   (offset: 0xcf2)
// animtree2 . 0   (offset: 0xcf2)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_phobos_head;

// Namespace zombie_phobos_head
// Params 0
// Checksum 0xde4977c7, Offset: 0xc6
// Size: 0x2
function function_27524729285812cc()
{
    
}

// Namespace zombie_phobos_head
// Params 0
// Checksum 0x31db9e41, Offset: 0xd0
// Size: 0x1d
function init_zombie_phobos_head()
{
    self.head_yaw = 0;
    thread update_head();
    
    /#
        function_41ce9bc1234ea6d1();
    #/
}

// Namespace zombie_phobos_head
// Params 0, eflags: 0x4
// Checksum 0x9a4c00df, Offset: 0xf5
// Size: 0x490
function private update_head()
{
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 1 );
    
    while ( true )
    {
        enemy = self._blackboard.meleerequestedtarget ?? self.enemy;
        target_pos = self.var_dd39ee1db08a2253 ?? enemy.origin ?? self.origin;
        is_looking_at_enemy = target_pos == enemy.origin;
        
        if ( !isdefined( target_pos ) )
        {
            waitframe();
            continue;
        }
        
        var_20757c1e4bd2a7bc = getdvarfloat( @"hash_1acf49f41d8f76dc", 0 );
        
        if ( getdvarint( @"hash_54fbc3915259db5c", 1 ) <= 0 || abs( var_20757c1e4bd2a7bc ) > 0 )
        {
            self function_536f8624346a747b( var_20757c1e4bd2a7bc );
            waitframe();
            continue;
        }
        
        if ( utility::ent_flag( "head_manual" ) )
        {
            waitframe();
            continue;
        }
        
        var_f06c3d8143b76949 = self gettagorigin( "j_head" );
        source_pos = self.origin;
        
        if ( ( utility::ent_flag( "in_melee" ) || utility::ent_flag( "in_spithose" ) ) && target_pos != source_pos )
        {
            source_pos = var_f06c3d8143b76949;
        }
        
        var_ee6433c31961982d = target_pos - source_pos;
        
        /#
            if ( debug_head() )
            {
                line( var_f06c3d8143b76949, target_pos, ( 0.3, 0.5, 0 ) );
                print3d( averagepoint( [ var_f06c3d8143b76949, target_pos ] ), "<dev string:x24>", ( 0.3, 0.5, 0 ), 1, 0.5 );
            }
        #/
        
        target_dist_right = vectordot( anglestoright( self.angles ), var_ee6433c31961982d );
        target_dist_foward = length2d( var_ee6433c31961982d );
        forward_norm = clamp( math::remap( target_dist_foward, getdvarfloat( @"hash_a86f08c12e937754", 300 ), getdvarfloat( @"hash_8660898e88ee7637", 600 ), 0, 1 ), 0, 1 );
        right_norm = clamp( math::remap( target_dist_right, getdvarfloat( @"hash_2a324c7c04609a7a", 100 ) * -1, getdvarfloat( @"hash_2a324c7c04609a7a", 100 ), -1, 1 ), -1, 1 );
        var_4824bad95495b903 = math::remap( forward_norm, 0, 1, -90, 0 );
        var_de6d614f6368de84 = vectortoyaw( var_ee6433c31961982d ) - self.angles[ 1 ];
        
        if ( lengthsquared( var_ee6433c31961982d ) == 0 )
        {
            var_de6d614f6368de84 = 0;
        }
        
        var_429c64c6f5d32684 = var_de6d614f6368de84;
        var_429c64c6f5d32684 = angleclamp180( var_429c64c6f5d32684 );
        var_429c64c6f5d32684 /= getdvarfloat( @"hash_88df4ad616d85075", 1.1 );
        
        if ( abs( var_429c64c6f5d32684 ) > 110 )
        {
            path = self getpath();
            
            if ( isdefined( path ) )
            {
                var_ee6433c31961982d = path[ int( path.size / 2 ) ] - source_pos;
                var_de6d614f6368de84 = vectortoyaw( var_ee6433c31961982d ) - self.angles[ 1 ];
                
                if ( lengthsquared( var_ee6433c31961982d ) == 0 )
                {
                    var_de6d614f6368de84 = 0;
                }
                
                var_429c64c6f5d32684 = angleclamp180( var_de6d614f6368de84 );
            }
        }
        
        var_3e0ca513fb0e4b82 = clamp( var_429c64c6f5d32684, -90, 90 ) * -1;
        head_yaw_speed = getdvarfloat( @"hash_ec91f444d111a208", 200 ) * level.framedurationseconds;
        difference = var_3e0ca513fb0e4b82 - self.head_yaw;
        
        if ( abs( difference ) <= head_yaw_speed )
        {
            self.head_yaw = var_3e0ca513fb0e4b82;
        }
        else if ( difference > 0 )
        {
            self.head_yaw += head_yaw_speed;
        }
        else
        {
            self.head_yaw -= head_yaw_speed;
        }
        
        self.head_pitch = var_4824bad95495b903;
        self function_536f8624346a747b( self.head_yaw );
        self function_51d4a57cf1dde916( self.head_pitch );
        
        /#
            if ( debug_head() )
            {
                col = ( 1, 0.2, 0 );
                line( self.origin, target_pos, col, 1, 1 );
                print3d( vectorlerp( self.origin, target_pos, 0.5 ), "<dev string:x38>" + forward_norm + "<dev string:x42>" + right_norm + "<dev string:x4f>" + self.head_yaw, col, 1 );
                print3d( vectorlerp( self.origin, target_pos, 0.5 ) + ( 0, 0, 60 ), "<dev string:x5d>" + var_3e0ca513fb0e4b82 + "<dev string:x69>" + var_de6d614f6368de84, col, 1 );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_phobos_head
// Params 0
// Checksum 0x2a29e1ad, Offset: 0x58d
// Size: 0x1b
function reset_head()
{
    self.head_yaw = 0;
    self function_536f8624346a747b( self.head_yaw );
}

/#

    // Namespace zombie_phobos_head
    // Params 0, eflags: 0x4
    // Checksum 0x56fcaa6c, Offset: 0x5b0
    // Size: 0x44, Type: dev
    function private function_41ce9bc1234ea6d1()
    {
        devgui::function_9082edeb5db93280( "<dev string:x77>" );
        devgui::add_devgui_func( "<dev string:x8f>", "<dev string:x9a>", &function_13fddb8f77fc155d );
        devgui::add_devgui_func( "<dev string:xb3>", "<dev string:xc6>", &function_225af29a99d43583 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_phobos_head
    // Params 1, eflags: 0x4
    // Checksum 0xd785d32c, Offset: 0x5fc
    // Size: 0x24, Type: dev
    function private function_13fddb8f77fc155d( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xe0>", @"hash_ef6bb5b759250e90" );
    }

    // Namespace zombie_phobos_head
    // Params 1, eflags: 0x4
    // Checksum 0x62c963ba, Offset: 0x628
    // Size: 0x24, Type: dev
    function private function_225af29a99d43583( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xf2>", @"hash_54fbc3915259db5c" );
    }

    // Namespace zombie_phobos_head
    // Params 0, eflags: 0x4
    // Checksum 0xef0416d1, Offset: 0x654
    // Size: 0x16, Type: dev
    function private debug_head()
    {
        return getdvarint( @"hash_ef6bb5b759250e90", 0 ) > 0;
    }

#/
