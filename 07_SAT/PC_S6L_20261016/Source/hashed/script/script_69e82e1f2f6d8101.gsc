// script_69e82e1f2f6d8101  (hash_69e82e1f2f6d8101.gscc) (size: 5724 Bytes / 0x165c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5bd3370 (2780640112)
// size ...... 5724 (0x165c)
// includes .. 7   (offset: 0x14ec)
// strings ... 16  (offset: 0x1524)
// dev strs .. 9   (offset: 0x15f0)
// exports ... 16  (offset: 0xc5c)
// cseg ...... 0x1a4 + 0xab8 (0xc5c)
// imports ... 53  (offset: 0xedc)
// animtree1 . 0   (offset: 0x165c)
// animtree2 . 0   (offset: 0x165c)
#using script_359c9cda9983c8fc;
#using script_670486d63d6d8151;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_leap_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_triton_leap_slam;

// Namespace zombie_triton_leap_slam
// Params 1
// Checksum 0x76bec49f, Offset: 0x1c2
// Size: 0x29
function function_5b0ef362924bacb0( var_4b4d72d84afd1ebd )
{
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "triton_leap_slam_ground_impact_fx", var_4b4d72d84afd1ebd.var_eb748021d8b0c1fd );
    }
}

// Namespace zombie_triton_leap_slam
// Params 0
// Checksum 0x798aa33c, Offset: 0x1f3
// Size: 0x13
function function_8c574e3645d9a0d7()
{
    zombie_leap_attack::init_zombie_leap_attack_global();
    
    /#
        function_bab5c9fdb99049d();
    #/
}

// Namespace zombie_triton_leap_slam
// Params 0
// Checksum 0x2bb598bf, Offset: 0x20e
// Size: 0x73
function function_b992691c4ad426f()
{
    self.leap_attack_state = "leap_slam_in";
    var_efcd7b34b543c7e7 = 0;
    zombie_leap_attack::init_zombie_leap_attack( var_efcd7b34b543c7e7 );
    zombie_leap_attack::set_leap_attack_end_pos_offset( ( -168.945, 0, 0 ) );
    self._blackboard.var_4753718265e552e0 = 1;
    self function_786bb6aa1b76c7ee( "minDistToLeapSlam", 400 );
    thread leap_slam_impact_listener();
    thread function_7270adfa4fa3e7f();
    thread function_ae42c691c41a89ea();
}

// Namespace zombie_triton_leap_slam
// Params 1
// Checksum 0xed8cd1f2, Offset: 0x289
// Size: 0x17
function function_3ece4fadd14643a9( var_aff6dbd249be7f2d )
{
    self.var_bbf5c2b42bfe40bc = var_aff6dbd249be7f2d;
}

// Namespace zombie_triton_leap_slam
// Params 1
// Checksum 0x12fa43e4, Offset: 0x2a8
// Size: 0x17
function function_70de57f35247ce32( var_59edd2f4a4cfd940 )
{
    self.var_d6fff8ffca6f2d9c = var_59edd2f4a4cfd940;
}

// Namespace zombie_triton_leap_slam
// Params 1
// Checksum 0xa60b939e, Offset: 0x2c7
// Size: 0x17
function function_f369021c13ba1f5( var_58017e64b922618f )
{
    self.var_ff7608ac9cb1e797 = var_58017e64b922618f;
}

// Namespace zombie_triton_leap_slam
// Params 0, eflags: 0x4
// Checksum 0xa37864b3, Offset: 0x2e6
// Size: 0xe2
function private function_7270adfa4fa3e7f()
{
    self endon( #"death" );
    self.var_ddb5f072baccd78f = asm::function_27be172b46a89235();
    
    while ( true )
    {
        self waittill( #"leap_attack_start" );
        var_e91841b4763100e7 = rotatepointaroundvector( ( 0, 0, 1 ), ( 168.945, 0, 0 ), vectortoyaw( self._blackboard.var_497e751941b50bed - self.origin ) );
        self setscriptablepartstate( "snd_leap_warning", "on", 0 );
        self.var_928147b83c6ff8f0 = spawnscriptable( "scriptable_zombie_triton_leap_slam_marker", self._blackboard.var_497e751941b50bed + var_e91841b4763100e7, self.angles );
        self.var_928147b83c6ff8f0 setscriptablepartstate( "leap", "marker" );
        self.var_fbd2b9707b5bd16f = 1;
    }
}

// Namespace zombie_triton_leap_slam
// Params 0, eflags: 0x4
// Checksum 0xdf0259b9, Offset: 0x3d0
// Size: 0x38
function private function_ae42c691c41a89ea()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"leap_attack_end" );
        self function_a8fe8d86843b9cee( 0 );
        self.var_fbd2b9707b5bd16f = 0;
    }
}

// Namespace zombie_triton_leap_slam
// Params 0, eflags: 0x4
// Checksum 0x2a2076a8, Offset: 0x410
// Size: 0x254
function private leap_slam_impact_listener()
{
    self endon( #"death" );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    var_cf13477fe2b9fc7d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3accfb5f7b51fdf6;
    var_3f9fe6c6d730bba8 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_66a4a6acfc45e68b;
    self.var_d6fff8ffca6f2d9c = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2e315b592f2bc8ba;
    self.var_ff7608ac9cb1e797 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_49987df7e050e3a5;
    function_3ece4fadd14643a9( 3 );
    var_8b666b505a33e562 = getdvarfloat( @"hash_be163b21db15ac7f", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a4b9402108e1bf0b );
    var_a94e904d0c12c3fc = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c95d2bb263e931f5;
    var_15e5ac1494adad82 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f8f70a51a69e2cf4;
    
    while ( true )
    {
        self waittill( #"leap_slam_impact" );
        self setscriptablepartstate( "snd_leap_warning", "off", 0 );
        
        if ( isdefined( self.var_928147b83c6ff8f0 ) )
        {
            self.var_928147b83c6ff8f0 freescriptable();
        }
        
        var_3e492d4e02dc2d37 = zombie_triton_impact::radius_ground_impact( "tag_hammer_top", var_cf13477fe2b9fc7d, var_3f9fe6c6d730bba8, "MOD_EXPLOSIVE", self.var_ff7608ac9cb1e797, self.var_d6fff8ffca6f2d9c, "triton_leap_slam_ground_impact_fx", undefined, "triton_slam_impact_concussive_wave_fx", 60, undefined, undefined, undefined, 1, 3000, 0.38, 1.4 );
        function_61449dcd2d0aa94e( var_3e492d4e02dc2d37.var_e5049d59fedd8c2f );
        var_ccbd7328bbe4384 = spawnscriptable( "scriptable_zombie_triton_ground_slam_line_impact", var_3e492d4e02dc2d37.var_e5049d59fedd8c2f, self.angles );
        var_ccbd7328bbe4384 thread summon_fire_impact( var_3e492d4e02dc2d37.var_e5049d59fedd8c2f );
        thread zombie_triton_lava_bomb::lava_bomb_aoe( var_3e492d4e02dc2d37.var_e5049d59fedd8c2f, self.angles, var_8b666b505a33e562, var_a94e904d0c12c3fc, var_15e5ac1494adad82 );
    }
}

// Namespace zombie_triton_leap_slam
// Params 1, eflags: 0x4
// Checksum 0x5b2506f3, Offset: 0x66c
// Size: 0x1d0
function private function_61449dcd2d0aa94e( var_8022b3fd4c424617 )
{
    var_39853d35e9d119b8 = 15;
    var_e8db7a4531b48b6c = self.grenadeweapon;
    var_f3b790776b52f8b1 = getdvarfloat( @"hash_2a7ae4df023af021", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b8144f7b59a3349e );
    var_2d878075b68d25ef = getdvarfloat( @"hash_f2f44d343a2af8e7", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_14c32d46969f54dc );
    assert( var_2d878075b68d25ef >= var_f3b790776b52f8b1, "<dev string:x98>" );
    var_e2f2d99e1bebd5d7 = getdvarfloat( @"hash_b57e2233ee22d32e", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_bd3d0adbd4d95212 );
    var_e729b2cc10577af5 = getdvarfloat( @"hash_828613d2d727101c", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f5ac56588edd3c58 );
    assert( var_e729b2cc10577af5 >= var_e2f2d99e1bebd5d7, "<dev string:xdc>" );
    var_6d87808ca6ffabdd = [];
    
    for ( i = 0; i < self.var_bbf5c2b42bfe40bc ; i++ )
    {
        var_8cca82df82cc29dc = function_e51d65bab87effbb( var_8022b3fd4c424617, var_f3b790776b52f8b1, var_2d878075b68d25ef, var_6d87808ca6ffabdd );
        var_640e280f2ed8fb1a = function_1a157086131b7c56( var_8022b3fd4c424617, var_8cca82df82cc29dc, var_e2f2d99e1bebd5d7, var_e729b2cc10577af5 );
        lavabomb = magicgrenademanual( var_e8db7a4531b48b6c, var_8022b3fd4c424617, var_640e280f2ed8fb1a, var_39853d35e9d119b8, self );
        lavabomb thread zombie_triton_lava_bomb::function_f7f5dd74398250bc();
        lavabomb.angles = vectortoangles( var_8cca82df82cc29dc - var_8022b3fd4c424617 );
        lavabomb utility::function_32b24db3127bff40( "projectile", "aerial" );
        lavabomb thread zombie_triton_lava_bomb::function_4205d8c2663ce650();
        thread zombie_triton_lava_bomb::function_966d048b40987b44( lavabomb );
    }
}

// Namespace zombie_triton_leap_slam
// Params 4, eflags: 0x4
// Checksum 0xc0fbcd95, Offset: 0x844
// Size: 0x187
function private function_e51d65bab87effbb( var_8022b3fd4c424617, var_f3b790776b52f8b1, var_2d878075b68d25ef, var_6d87808ca6ffabdd )
{
    var_86bb17d8612b1a5b = -0.5;
    var_394424a6eec737d7 = 8;
    var_b0ff344f6a3ece07 = 30;
    var_7ca8c3e1dc2ec464 = anglestoforward( self.angles );
    randomradius = randomfloatrange( var_f3b790776b52f8b1, var_2d878075b68d25ef );
    
    for ( var_9c69b54ae65e631e = 0; var_9c69b54ae65e631e <= var_b0ff344f6a3ece07 ; var_9c69b54ae65e631e++ )
    {
        var_ace2168417180935 = utility::function_8ae0ea62537eafc5( var_8022b3fd4c424617, randomradius );
        var_4164dddaedd33cf3 = vectornormalize( var_ace2168417180935 - var_8022b3fd4c424617 );
        
        if ( vectordot( var_7ca8c3e1dc2ec464, var_4164dddaedd33cf3 ) >= var_86bb17d8612b1a5b )
        {
            var_bdf9e2e3cc447cec = 0;
            
            foreach ( var_8cca82df82cc29dc in var_6d87808ca6ffabdd )
            {
                var_9c98196d0486a572 = vectornormalize( var_8cca82df82cc29dc - var_8022b3fd4c424617 );
                
                if ( acos( vectordot( var_9c98196d0486a572, var_4164dddaedd33cf3 ) ) < var_394424a6eec737d7 )
                {
                    var_bdf9e2e3cc447cec = 1;
                    break;
                }
            }
            
            if ( !var_bdf9e2e3cc447cec )
            {
                return var_ace2168417180935;
            }
        }
    }
    
    var_a90a480c361409ab = self.origin + randomradius * var_7ca8c3e1dc2ec464;
    return var_a90a480c361409ab;
}

// Namespace zombie_triton_leap_slam
// Params 4, eflags: 0x4
// Checksum 0x47c205cb, Offset: 0x9d4
// Size: 0x13a
function private function_1a157086131b7c56( summonpoint, var_8cca82df82cc29dc, var_e2f2d99e1bebd5d7, var_e729b2cc10577af5 )
{
    heightpeak = randomfloatrange( var_e2f2d99e1bebd5d7, var_e729b2cc10577af5 );
    gravity = getdvarfloat( @"bg_lowgravity", 400 );
    var_ad3962d87d567be = ( var_8cca82df82cc29dc[ 0 ], var_8cca82df82cc29dc[ 1 ], summonpoint[ 2 ] );
    var_9e615ad533573d69 = vectornormalize( var_ad3962d87d567be - summonpoint );
    var_75969cbd73e180ce = distance( summonpoint, var_ad3962d87d567be );
    var_e41d79640730d420 = sqrt( 2 * gravity * heightpeak );
    a = -0.5 * gravity;
    b = var_e41d79640730d420;
    c = abs( var_9e615ad533573d69[ 2 ] );
    var_4a70118a9411a59 = ( -1 * b - sqrt( squared( b ) - 4 * a * c ) ) / 2 * a;
    var_76cfd46cb7c85258 = var_75969cbd73e180ce / var_4a70118a9411a59;
    horizontalvelocity = var_76cfd46cb7c85258 * var_9e615ad533573d69;
    var_640e280f2ed8fb1a = ( horizontalvelocity[ 0 ], horizontalvelocity[ 1 ], var_e41d79640730d420 );
    return var_640e280f2ed8fb1a;
}

// Namespace zombie_triton_leap_slam
// Params 1, eflags: 0x4
// Checksum 0x759edad6, Offset: 0xb17
// Size: 0x59
function private summon_fire_impact( var_337dc12be9bb7a51 )
{
    self endon( #"death" );
    
    if ( !utility::ispointinwater( var_337dc12be9bb7a51 - ( 0, 0, 32 ) ) )
    {
        var_f69727fd3a663df2 = 9;
        self setscriptablepartstate( "impact", "impact" );
        wait var_f69727fd3a663df2;
        self freescriptable();
    }
}

/#

    // Namespace zombie_triton_leap_slam
    // Params 0
    // Checksum 0x7e28f07f, Offset: 0xb78
    // Size: 0x30, Type: dev
    function function_bab5c9fdb99049d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x11c>" );
        devgui::add_devgui_func( "<dev string:x134>", "<dev string:x145>", &toggle_leap_slam, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_triton_leap_slam
    // Params 0, eflags: 0x4
    // Checksum 0xbf1840cb, Offset: 0xbb0
    // Size: 0xac, Type: dev
    function private toggle_leap_slam()
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x156>" );
        
        if ( isdefined( triton ) )
        {
            if ( triton zombie_leap_attack::is_leap_attack_enabled() )
            {
                print3d( triton.origin, "<dev string:x164>", ( 1, 0, 0 ), 1, 1, 1, 1 );
                triton zombie_leap_attack::disable_leap_attack();
                return;
            }
            
            print3d( triton.origin, "<dev string:x177>", ( 1, 0, 0 ), 1, 1, 1, 1 );
            triton zombie_leap_attack::enable_leap_attack();
        }
    }

#/
