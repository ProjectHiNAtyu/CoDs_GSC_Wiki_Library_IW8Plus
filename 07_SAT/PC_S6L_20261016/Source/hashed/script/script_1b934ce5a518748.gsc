// script_1b934ce5a518748  (hash_01b934ce5a518748.gscc) (size: 5620 Bytes / 0x15f4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa8911b2 (176755122)
// size ...... 5620 (0x15f4)
// includes .. 6   (offset: 0x1428)
// strings ... 12  (offset: 0x1458)
// dev strs .. 19  (offset: 0x14fc)
// exports ... 18  (offset: 0xb00)
// cseg ...... 0xe4 + 0xa1c (0xb00)
// imports ... 55  (offset: 0xdd0)
// animtree1 . 0   (offset: 0x15f4)
// animtree2 . 0   (offset: 0x15f4)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_spit;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace namespace_5d8c8e7c63b470d5;

/#

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 0
    // Checksum 0x19acc60d, Offset: 0x102
    // Size: 0xc, Type: dev
    function function_54867ff0ab30fc90()
    {
        function_df8816bb4ca5a48d();
    }

#/

// Namespace namespace_5d8c8e7c63b470d5
// Params 0
// Checksum 0x21515e69, Offset: 0x116
// Size: 0x55
function function_57593f2c96dd64bc()
{
    if ( self.var_80527e900b54c4ec > gettime() )
    {
        self._blackboard.var_65f32caa86b87a2 = 0;
        return;
    }
    
    self.var_80527e900b54c4ec = gettime() + self.var_d6894f01a36b4ff3.var_7502a7ba1077f41a * 1000;
    thread manage_spit();
}

// Namespace namespace_5d8c8e7c63b470d5
// Params 0, eflags: 0x4
// Checksum 0x335873cc, Offset: 0x173
// Size: 0x9c
function private manage_spit()
{
    self endon( #"death" );
    self endon( #"spit_end" );
    assert( !self._blackboard.var_99f794dc99944d15, "<dev string:x24>" );
    assert( isdefined( self.var_d6894f01a36b4ff3.projectileattachtag ), "<dev string:x5a>" );
    thread function_eb0857bc6f481830();
    asm::function_7256f5ba459c840b( "spit_in" );
    thread track_target_angles();
    
    if ( isdefined( self.enemy ) )
    {
        self.rangedattacktarget = self.enemy;
    }
    
    thread fire_spit();
}

// Namespace namespace_5d8c8e7c63b470d5
// Params 0, eflags: 0x4
// Checksum 0x43ba0368, Offset: 0x217
// Size: 0x26d
function private fire_spit()
{
    self endon( #"death" );
    self endon( #"spit_end" );
    spitweapon = self.grenadeweapon;
    thread function_19c8fffa6488eee6();
    utility::waittill_notify_or_timeout( "launch_spit", 10 );
    thread function_b7142a03331eed94();
    anglediff = -1 * self.angles[ 1 ];
    upvec = anglestoup( self.angles );
    var_8b712f5809f82032 = self gettagorigin( self.var_d6894f01a36b4ff3.projectileattachtag ) - self.origin;
    var_8b712f5809f82032 = rotatepointaroundvector( upvec, var_8b712f5809f82032, anglediff );
    targetorigin = undefined;
    
    if ( true )
    {
        forwardvec = anglestoforward( self.angles );
        var_92458e0eddc72285 = forwardvec * 500;
        targetorigin = getclosestpointonnavmesh( self.origin + var_92458e0eddc72285 );
    }
    else
    {
        targetorigin = self.rangedattacktarget.origin;
        navorigin = getclosestpointonnavmesh( targetorigin, self, 0, 1 );
        
        if ( isdefined( navorigin ) )
        {
            tacpoint = function_5a577f4e6e89a130( self.origin, navorigin, 0, 500, 150 );
            
            if ( isdefined( tacpoint ) )
            {
                targetorigin = tacpoint.origin;
            }
        }
    }
    
    self._blackboard.var_6d49dcff94e39d6a = targetorigin;
    var_ee6433c31961982d = targetorigin - self.origin;
    var_eab1a0cb19041ba2 = self function_d5e40e88a4ac1386( spitweapon, undefined, 0, 0, 300, 300, 0, var_8b712f5809f82032 );
    
    if ( !isdefined( var_eab1a0cb19041ba2 ) )
    {
        return;
    }
    
    startpos = self gettagorigin( self.var_d6894f01a36b4ff3.projectileattachtag );
    var_e1643915a4503b40 = magicgrenademanual( spitweapon, startpos, var_eab1a0cb19041ba2, self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    
    if ( isdefined( var_e1643915a4503b40 ) )
    {
        var_e1643915a4503b40.angles = self gettagangles( self.var_d6894f01a36b4ff3.projectileattachtag );
        var_e1643915a4503b40 utility::function_32b24db3127bff40( "projectile", "aerial" );
        
        if ( !isdefined( self.var_86c5033c7c02d454 ) )
        {
            self.var_86c5033c7c02d454 = [];
        }
        
        self.var_86c5033c7c02d454[ self.var_86c5033c7c02d454.size ] = var_e1643915a4503b40;
        thread function_5089804af7b391e3( var_e1643915a4503b40 );
    }
}

// Namespace namespace_5d8c8e7c63b470d5
// Params 1, eflags: 0x4
// Checksum 0xe2545763, Offset: 0x48c
// Size: 0x11e
function private function_5089804af7b391e3( var_e1643915a4503b40 )
{
    self endon( #"death" );
    var_e1643915a4503b40 endon( #"delay_death" );
    var_962bca9b8744cf88 = anglestoright( var_e1643915a4503b40.angles );
    var_e1643915a4503b40 waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    origin = getclosestpointonnavmesh( origin, self );
    normal = isvector( var_4cd1a139c1b0c2b7 ) ? var_4cd1a139c1b0c2b7 : undefined;
    var_261228b72ebe8a1d = undefined;
    impactangles = undefined;
    
    if ( isdefined( normal ) )
    {
        var_261228b72ebe8a1d = vectorcross( normal, var_962bca9b8744cf88 );
        impactangles = axistoangles( var_261228b72ebe8a1d, var_962bca9b8744cf88, normal );
    }
    else
    {
        impactangles = self.angles;
    }
    
    radiusdamage( origin, 128, 50, 50, self );
    post_fx = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.toxic_gas_postfx_bundle;
    thread zombie_toxic_gas::spawn_toxic_gas( self, origin, ( 0, 0, 0 ), "from_spit", 5, 256, 64, "roar_end" );
}

// Namespace namespace_5d8c8e7c63b470d5
// Params 0, eflags: 0x4
// Checksum 0x1fa67b93, Offset: 0x5b2
// Size: 0x1ae
function private track_target_angles()
{
    self endon( #"death" );
    self endon( #"spit_end" );
    initpitch = 0;
    inityaw = 0;
    
    if ( self._blackboard.var_79b2d8d61c6ef8b1 )
    {
        var_4ed4c245d1c63455 = vectortoangles( self._blackboard.var_6d49dcff94e39d6a - self.origin );
        initpitch = var_4ed4c245d1c63455[ 0 ];
        inityaw = var_4ed4c245d1c63455[ 1 ];
    }
    else if ( isdefined( self.enemy ) )
    {
        var_2ccf8c2380f88709 = vectortoangles( self.enemy.origin - self gettagorigin( self.var_d6894f01a36b4ff3.projectileattachtag ) );
        initpitch = var_2ccf8c2380f88709[ 0 ];
        inityaw = var_2ccf8c2380f88709[ 1 ];
    }
    
    while ( true )
    {
        if ( isdefined( self.enemy ) )
        {
            targetpitch = vectortopitch( self.enemy.origin - self gettagorigin( self.var_d6894f01a36b4ff3.projectileattachtag ) ) - initpitch;
            targetpitch = angleclamp180( targetpitch );
            targetpitch = clamp( targetpitch, -45, 45 );
            targetyaw = vectortoyaw( self.enemy.origin - self gettagorigin( self.var_d6894f01a36b4ff3.projectileattachtag ) ) - inityaw;
            targetyaw = angleclamp180( targetyaw );
            targetyaw = clamp( targetyaw, -45, 45 );
            
            /#
                spit_print( "<dev string:xb5>" + targetyaw, self.origin );
            #/
        }
        
        waitframe();
    }
}

// Namespace namespace_5d8c8e7c63b470d5
// Params 0, eflags: 0x4
// Checksum 0xc8a2aba4, Offset: 0x768
// Size: 0x2d
function private function_eb0857bc6f481830()
{
    msg = utility::waittill_any_return( "spit_end", "death", "spit_end" );
    self.rangedattacktarget = undefined;
}

// Namespace namespace_5d8c8e7c63b470d5
// Params 0, eflags: 0x4
// Checksum 0xf47b58a9, Offset: 0x79d
// Size: 0x3b
function private function_19c8fffa6488eee6()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "spit_charge", "mouth" );
    wait 2;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "spit_charge", "off" );
    }
}

// Namespace namespace_5d8c8e7c63b470d5
// Params 0, eflags: 0x4
// Checksum 0xdab51b0d, Offset: 0x7e0
// Size: 0x3b
function private function_b7142a03331eed94()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "spit_spit", "mouth" );
    wait 2;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "spit_spit", "off" );
    }
}

/#

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 0, eflags: 0x4
    // Checksum 0xbb156956, Offset: 0x823
    // Size: 0x86, Type: dev
    function private function_df8816bb4ca5a48d()
    {
        devgui::function_9082edeb5db93280( "<dev string:xc2>" );
        devgui::add_devgui_func( "<dev string:xdf>", "<dev string:xea>", &force_spit );
        devgui::add_devgui_func( "<dev string:xfc>", "<dev string:x107>", &toggle_debug_spit );
        devgui::add_devgui_func( "<dev string:x119>", "<dev string:x129>", &spawn_phobos_toxic_gas );
        devgui::add_devgui_func( "<dev string:x140>", "<dev string:x15a>", &function_bc78c4f067b745a );
        devgui::add_devgui_func( "<dev string:x17b>", "<dev string:x18f>", &clear_all_phobos_toxic_gas );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 1, eflags: 0x4
    // Checksum 0xc41aa0e5, Offset: 0x8b1
    // Size: 0x4b, Type: dev
    function private force_spit( params )
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1aa>" );
        
        if ( isdefined( phobos ) )
        {
            phobos function_57593f2c96dd64bc();
        }
    }

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 0, eflags: 0x4
    // Checksum 0x2bf37d3d, Offset: 0x904
    // Size: 0x70, Type: dev
    function private spawn_phobos_toxic_gas()
    {
        look_at_pos = devgui::function_97024c0a6d1256a6();
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1aa>" );
        
        if ( isdefined( phobos ) )
        {
            thread zombie_toxic_gas::spawn_toxic_gas( phobos, look_at_pos, ( 0, 0, 0 ), "<dev string:x1b8>", 5, 256, 64, "<dev string:x1c2>" );
        }
    }

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 0, eflags: 0x4
    // Checksum 0xcc0812d7, Offset: 0x97c
    // Size: 0x98, Type: dev
    function private function_bc78c4f067b745a()
    {
        look_at_pos = devgui::function_97024c0a6d1256a6();
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1aa>" );
        
        if ( isdefined( phobos ) )
        {
            post_fx = phobos.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.toxic_gas_postfx_bundle;
            thread zombie_toxic_gas::spawn_toxic_gas( phobos, look_at_pos, ( 0, 0, 0 ), "<dev string:x1b8>", undefined, 350, 64, "<dev string:x1c2>" );
        }
    }

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 0, eflags: 0x4
    // Checksum 0x240c9279, Offset: 0xa1c
    // Size: 0x41, Type: dev
    function private clear_all_phobos_toxic_gas()
    {
        phobos = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x1aa>" );
        
        if ( isdefined( phobos ) )
        {
            zombie_phobos_spit::function_13c285f3a5c52573( phobos );
        }
    }

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 0, eflags: 0x4
    // Checksum 0xaf415424, Offset: 0xa65
    // Size: 0x1a, Type: dev
    function private toggle_debug_spit()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x1cb>", @"phobos_spit_debug" );
    }

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 0, eflags: 0x4
    // Checksum 0xfaec2478, Offset: 0xa87
    // Size: 0x16, Type: dev
    function private debug_spit()
    {
        return getdvarint( @"phobos_spit_debug", 0 ) > 0;
    }

    // Namespace namespace_5d8c8e7c63b470d5
    // Params 2, eflags: 0x4
    // Checksum 0x3f6f2841, Offset: 0xaa5
    // Size: 0x5b, Type: dev
    function private spit_print( text, pos )
    {
        if ( debug_spit() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x1dd>" + text, ( 1, 0, 0 ) );
        }
    }

#/
