// script_1fc20b38e0fc8291  (hash_1fc20b38e0fc8291.gscc) (size: 18973 Bytes / 0x4a1d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x38e4a0f1 (954507505)
// size ...... 18973 (0x4a1d)
// includes .. 12  (offset: 0x4725)
// strings ... 22  (offset: 0x4785)
// dev strs .. 24  (offset: 0x48e5)
// exports ... 51  (offset: 0x2e3d)
// cseg ...... 0x186 + 0x2cb7 (0x2e3d)
// imports ... 133 (offset: 0x3635)
// animtree1 . 0   (offset: 0x4a1d)
// animtree2 . 0   (offset: 0x4a1d)
#using script_190e128009243fcb;
#using script_38a61e43967bfd11;
#using script_46e6a605b00ce67c;
#using script_4cc8a0ecc1f50901;
#using script_640b69521097c6a5;
#using script_6a71daf1a601e6f5;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_weyward_dash;

/#

    // Namespace zombie_weyward_dash
    // Params 0
    // Checksum 0x9d2e821d, Offset: 0x1a4
    // Size: 0xc, Type: dev
    function function_4ae528e72a7e4964()
    {
        function_b458a037df882ec9();
    }

#/

// Namespace zombie_weyward_dash
// Params 1
// Checksum 0x15b23640, Offset: 0x1b8
// Size: 0x17
function function_455640e34ccee849( cooldown_s )
{
    self.var_3b0e94cacb0567c0 = cooldown_s;
}

// Namespace zombie_weyward_dash
// Params 1
// Checksum 0xffc7276a, Offset: 0x1d7
// Size: 0x17
function function_243754bbfbe41d62( cooldown_s )
{
    self.var_f9dbb2766aaa877d = cooldown_s;
}

// Namespace zombie_weyward_dash
// Params 0
// Checksum 0xde67928, Offset: 0x1f6
// Size: 0xbb
function cancel_dash()
{
    function_4300b63d28ccdcec();
    self.var_7cbde7b93399a096 = 0;
    self.var_59a67f4a2bd3b5f7 = 0;
    self.var_5854d52bc771060 = undefined;
    self.var_149c7ca28b59287b = 0;
    self.var_9c344f8b4d3d4884 = 0;
    self.var_50781d61dc86a4bf = 1;
    self.dash_target_yaw = undefined;
    self.var_3b89efd305efc98d = undefined;
    self notify( #"dash_cancelled" );
    self notify( #"bdashended" );
    utility::ent_flag_clear( "in_dash" );
    utility::function_7c10ea82c1e305b8( "dash", "off" );
    utility::function_7c10ea82c1e305b8( "dash_impact", "off" );
    self.turnrate = getdvarfloat( @"weyward_turn_rate", 0.1 );
}

// Namespace zombie_weyward_dash
// Params 0
// Checksum 0x70807ea, Offset: 0x2b9
// Size: 0x351
function init_zombie_weyward_dash()
{
    self.var_a4028c005af94a05 = 0;
    self.var_df13f8eb676bae22 = 0;
    self.var_76197e1f6e9de341 = 0;
    self.var_66e9628acb91535d = 0;
    self.var_d4984593f407a505 = undefined;
    self.var_a754b82be6b582a3 = undefined;
    self.var_6eb184994f060f2c = undefined;
    self.var_95b6de8f06af3afd = 0;
    self.var_90ed982408bb66a5 = undefined;
    self.var_1cf0ad3b437ffbc3 = undefined;
    self.var_669dfe06cc13b98c = undefined;
    self.staring_player = undefined;
    self.var_50781d61dc86a4bf = 1;
    self.var_9c344f8b4d3d4884 = 0;
    self.var_a51c77ac6a55f857 = 0;
    self.dash_target_yaw = undefined;
    self.var_7cbde7b93399a096 = 0;
    self.var_59a67f4a2bd3b5f7 = 0;
    self.var_5854d52bc771060 = undefined;
    self.var_149c7ca28b59287b = 0;
    self.var_f122084c179b6412 = 0;
    self.var_e463e01d922ca747 = 0;
    self.var_3b89efd305efc98d = undefined;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_3b0e94cacb0567c0 = settings.var_f0503fbc6f311e74 ?? 7;
    self.var_f436015a784fd6d6 = settings.var_407cf46bfc67931c ?? 1;
    self.var_a50620578c87cd34 = settings.var_7618694e08490981 ?? 1000;
    self.var_4f8044d391620065 = settings.var_a804a1d826886f24 ?? 0.5;
    self.var_9cfec2901f9e9ad4 = settings.var_84b7916e776b0a62 ?? 0;
    self.var_61abea2ed9e609b8 = settings.var_7ca65fdd83ceb36f ?? 600;
    self.var_c2d80a92e9dabd4e = settings.var_7ce41792e1cfea56 ?? 0.15;
    self.var_6c3fdc08552c87c9 = settings.var_59ada85f4e9fb2e0 ?? 350;
    self.var_bf19d4231dfe122c = settings.var_36eec205d59f3011 ?? 2;
    self.var_c0c4796bce072f68 = settings.var_d67801fccd06969e ?? 2;
    self.var_f9dbb2766aaa877d = settings.var_5f4dbc7988b3ef75 ?? 7;
    self.var_3076152a3d1090ee = settings.var_c40f0dc384b2361f ?? 100;
    self.var_b6ff6012a9076027 = settings.var_34039b26b2512a81 ?? 500;
    self.var_5ffa91983de9a78a = settings.var_ebc7573822581750 ?? 20;
    self.var_88fc4b511eacdfe2 = settings.var_100ec5491f7e2ae4 ?? 300;
    self.dash_impact_radius = settings.var_506afaf8fd5f3202 ?? 200;
    self.dash_damage = settings.dashdamage ?? 90;
    self.var_4426c19e05baff2b = settings.var_67d0369942a8db5d ?? 30;
    self.dash_knockback = settings.dashknockback ?? 500;
    self.dash_enabled = settings.dashenabled ?? 1;
    self.var_cb16347c9f706fef = settings.var_3cd9a4e6f97560c7 ?? 110;
    self.var_750fa061a984e09e = settings.var_b336e66cdcd90b5f ?? 0.25;
    thread function_381ad2ba9c355c0f();
    thread function_5df580fadaba6f9f();
    thread function_106801f66cbd7c6a();
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0xadc20dbf, Offset: 0x612
// Size: 0x38
function private function_bbc373b97c7dee44()
{
    self endon( #"death" );
    self endon( #"dash_cancelled" );
    wait 6;
    
    if ( !self.var_7cbde7b93399a096 )
    {
        return;
    }
    
    self.var_7cbde7b93399a096 = 0;
}

// Namespace zombie_weyward_dash
// Params 2
// Checksum 0x86cdbad4, Offset: 0x652
// Size: 0x27f
function function_bdcff76d5355e86f( taskid, params )
{
    if ( self getaiblackboarddynamic( "charge_into_dash_combo" ) )
    {
        self function_786bb6aa1b76c7ee( "charge_into_dash_combo", 0 );
    }
    
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( zombie_stun::is_stunned() )
    {
        return anim.failure;
    }
    
    if ( asm::asm_getcurrentstatename( self.asmname ) == "dash" )
    {
        return anim.running;
    }
    
    if ( self.var_7cbde7b93399a096 )
    {
        return anim.running;
    }
    
    if ( namespace_cf4ab51195a21b92::function_9dddd89ce61e2f9e() )
    {
        return anim.running;
    }
    
    if ( !getdvarint( @"hash_ab75c3355dac252e", self.dash_enabled ) )
    {
        return anim.failure;
    }
    
    var_b50121b889671274 = function_1de098af38a28c57( self.staring_player );
    
    if ( utility::time_has_passed( self.var_a4028c005af94a05, var_b50121b889671274 ) )
    {
        var_97f39f09610a5f61 = isalive( self.staring_player ) && self.var_76197e1f6e9de341 >= getdvarfloat( @"hash_16367d320e06778c", self.var_f436015a784fd6d6 );
        var_846ec42fb41b70f9 = self.var_66e9628acb91535d >= getdvarfloat( @"hash_b377957a646d0ed7", self.var_4f8044d391620065 );
        
        if ( var_97f39f09610a5f61 && var_846ec42fb41b70f9 )
        {
            var_ef10226e8d8b874 = vectornormalize( self.staring_player.origin - self.origin );
            
            if ( vectordot( anglestoforward( self.angles ), var_ef10226e8d8b874 ) >= 0.95 )
            {
                direction = function_f6dff83f1a9ba519( self.staring_player );
                
                if ( isdefined( direction ) )
                {
                    var_d721e18aba4cb066 = function_7bd1eaf46ce5d740( self.staring_player );
                    
                    if ( function_a99cfab6565f7a32( direction, var_d721e18aba4cb066 ) )
                    {
                        self.var_3b89efd305efc98d = undefined;
                        return anim.failure;
                    }
                    
                    self.var_f122084c179b6412 = 1;
                    self.var_76197e1f6e9de341 = 0;
                    self.var_66e9628acb91535d = 0;
                    self.staring_player = undefined;
                    start_dash( direction, undefined, 0, var_d721e18aba4cb066 );
                    return anim.success;
                }
            }
        }
    }
    
    if ( function_43a5a5d8f21362b8( 1 ) )
    {
        return anim.running;
    }
    
    return anim.failure;
}

// Namespace zombie_weyward_dash
// Params 1
// Checksum 0x5f21d785, Offset: 0x8da
// Size: 0x21a, Type: bool
function function_43a5a5d8f21362b8( do_dash )
{
    if ( zombie_stun::is_stunned() )
    {
        return false;
    }
    
    if ( !getdvarint( @"hash_ab75c3355dac252e", self.dash_enabled ) )
    {
        return false;
    }
    
    if ( utility::time_has_passed( self.var_df13f8eb676bae22, getdvarfloat( @"hash_22d1dbe6aea7a9b3", self.var_f9dbb2766aaa877d ) ) )
    {
        dash_range = getdvarfloat( @"hash_839b1333a27c128d", self.var_b6ff6012a9076027 );
        remaining_dashes = function_265f522fdbaf8c10();
        stinger_swipe_range = get_stinger_swipe_range();
        var_8972e87ef00c88d = remaining_dashes * dash_range + stinger_swipe_range - 15;
        [ dash_yaw, dash_target, dash_target_dist ] = function_c12459e7a96618f2( var_8972e87ef00c88d );
        
        if ( dash_yaw )
        {
            if ( abs( dash_yaw ) >= getdvarfloat( @"hash_df6a56db008c916d", self.var_cb16347c9f706fef ) )
            {
                dashes_needed = function_e4670c4b0acd6059( dash_target_dist, remaining_dashes, dash_range, stinger_swipe_range );
                
                if ( dashes_needed )
                {
                    var_fc75a01b3953dd4a = dashes_needed <= 1;
                    
                    if ( do_dash )
                    {
                        self.var_7cbde7b93399a096 = 1;
                        self.var_50781d61dc86a4bf = 0.65;
                        self.var_9c344f8b4d3d4884 = var_fc75a01b3953dd4a;
                        self._blackboard.meleerequestedtarget = dash_target;
                        self.var_59a67f4a2bd3b5f7 = 1;
                        self.var_5854d52bc771060 = dash_target;
                        self.var_149c7ca28b59287b = dashes_needed - 1;
                        namespace_c57c4bda2cd4484a::function_5d712bb2b5876699( dash_target );
                    }
                    
                    if ( var_fc75a01b3953dd4a && function_75d58fc6275b7ee9( dash_target ) )
                    {
                        if ( do_dash )
                        {
                            function_681e089555a938d2( 1 );
                            self.var_df13f8eb676bae22 = gettime();
                            self.var_e463e01d922ca747 = 0;
                            function_80a25f5c975e2dd0( dash_target );
                            thread function_bbc373b97c7dee44();
                        }
                        
                        return true;
                    }
                    
                    if ( do_dash )
                    {
                        function_681e089555a938d2( var_fc75a01b3953dd4a );
                        start_dash( "target", dash_target, var_fc75a01b3953dd4a, 0 );
                        thread function_bbc373b97c7dee44();
                    }
                    
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x2a3aad0e, Offset: 0xafd
// Size: 0x26
function private function_265f522fdbaf8c10()
{
    remaining_dashes = 2 - self.var_a51c77ac6a55f857;
    
    if ( remaining_dashes <= 0 )
    {
        return 2;
    }
    
    return remaining_dashes;
}

// Namespace zombie_weyward_dash
// Params 2, eflags: 0x4
// Checksum 0x4e2c8ceb, Offset: 0xb2c
// Size: 0x156, Type: bool
function private function_a99cfab6565f7a32( direction, var_d721e18aba4cb066 )
{
    right_dir = anglestoright( self.angles );
    dash_range = getdvarfloat( @"hash_839b1333a27c128d", self.var_b6ff6012a9076027 );
    
    if ( var_d721e18aba4cb066 )
    {
        dash_range = getdvarfloat( @"hash_4cadfed15b80c92f", self.var_6c3fdc08552c87c9 );
    }
    
    switch ( direction )
    {
        case #"hash_c9b3133a17a3b2d0":
            dash_end_pos = ( ( var_d721e18aba4cb066 ? self.origin + right_dir * dash_range * -1 : self.var_3b89efd305efc98d ) ?? self.origin ) + right_dir * dash_range * -1 * 0.5;
            dash_dir = right_dir * -1;
            break;
        case #"hash_96815ce4f2a3dbc5":
            dash_end_pos = ( ( var_d721e18aba4cb066 ? self.origin + right_dir * dash_range : self.var_3b89efd305efc98d ) ?? self.origin ) + right_dir * dash_range * 0.5;
            dash_dir = right_dir;
            break;
        default:
            return false;
    }
    
    nav_trace = navtrace( dash_end_pos, dash_end_pos + dash_dir * 250, self, 1 );
    return nav_trace[ "fraction" ] < 1;
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x92a5e1c5, Offset: 0xc8b
// Size: 0x1d
function private get_stinger_swipe_range()
{
    return getdvarfloat( @"hash_fe76add00fc1181a", self.var_9e1d198f65ea9898 ?? 120 );
}

// Namespace zombie_weyward_dash
// Params 4, eflags: 0x4
// Checksum 0xf57277dc, Offset: 0xcb1
// Size: 0x75
function private function_e4670c4b0acd6059( var_a0d3f1c68d25c770, remaining_dashes, dash_range, stinger_swipe_range )
{
    var_8b05503d14f73363 = stinger_swipe_range - 15;
    
    if ( var_8b05503d14f73363 <= 0 )
    {
        return;
    }
    
    if ( var_a0d3f1c68d25c770 > remaining_dashes * dash_range + var_8b05503d14f73363 )
    {
        return;
    }
    
    for ( dash_count = 1; dash_count <= remaining_dashes ; dash_count++ )
    {
        if ( var_a0d3f1c68d25c770 <= dash_count * dash_range + var_8b05503d14f73363 )
        {
            return dash_count;
        }
    }
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0xa608d91f, Offset: 0xd2f
// Size: 0x4a
function private function_681e089555a938d2( force_cooldown )
{
    if ( force_cooldown )
    {
        self.var_a51c77ac6a55f857 = 1;
    }
    
    self.var_a51c77ac6a55f857++;
    
    if ( self.var_a51c77ac6a55f857 >= 2 )
    {
        self.var_a51c77ac6a55f857 = 0;
        self.var_e463e01d922ca747 = 1;
    }
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x8a34338d, Offset: 0xd81
// Size: 0x70, Type: bool
function private function_47cb184ab93cdde7( target )
{
    if ( !isalive( target ) )
    {
        return false;
    }
    
    target_pos = function_9b85bf0ef3b9d7bf( target );
    var_ee6433c31961982d = vectornormalize( target_pos - self.origin );
    dash_yaw = angleclamp180( vectortoyaw( var_ee6433c31961982d ) - self.angles[ 1 ] );
    return abs( dash_yaw ) >= 90;
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x109105b, Offset: 0xdfa
// Size: 0x37, Type: bool
function private function_65eff24097f8f057( target )
{
    if ( !isalive( target ) )
    {
        return false;
    }
    
    return distance( self.origin, function_9b85bf0ef3b9d7bf( target ) ) <= get_stinger_swipe_range() - 15;
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0xbb09d066, Offset: 0xe3a
// Size: 0x18
function private function_b0ae41361a82bc4d()
{
    return getdvarfloat( @"hash_a90e14a647440c38", self.var_750fa061a984e09e );
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x9cc5b70a, Offset: 0xe5b
// Size: 0x33
function private function_9b85bf0ef3b9d7bf( target )
{
    var_df9adb69b75ff5f3 = target getvelocity();
    return target.origin + var_df9adb69b75ff5f3 * function_b0ae41361a82bc4d();
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x2f82ebc2, Offset: 0xe97
// Size: 0x12
function private function_20b2ec3875996357()
{
    return getdvarfloat( @"hash_1d666ab2b9f6caf8", 315 );
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x9534c9bf, Offset: 0xeb2
// Size: 0x4b, Type: bool
function private function_75d58fc6275b7ee9( target )
{
    if ( !isalive( target ) )
    {
        return true;
    }
    
    stop_distance = function_20b2ec3875996357();
    return max( distance( self.origin, function_9b85bf0ef3b9d7bf( target ) ) - stop_distance, 0 ) < stop_distance;
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x9d4ff338, Offset: 0xf06
// Size: 0x77
function private function_80a25f5c975e2dd0( target )
{
    self.var_59a67f4a2bd3b5f7 = 0;
    self.var_5854d52bc771060 = undefined;
    self.var_149c7ca28b59287b = 0;
    self.var_9c344f8b4d3d4884 = 0;
    self.var_50781d61dc86a4bf = 1;
    
    if ( zombie_stun::is_stunned() )
    {
        self.var_7cbde7b93399a096 = 0;
        return;
    }
    
    if ( isalive( target ) )
    {
        thread function_1e8e0ba18ad67b4a();
        zombie_weyward_melee::function_6546aa1a41debe5d( target );
        return;
    }
    
    self.var_7cbde7b93399a096 = 0;
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x402bdee3, Offset: 0xf85
// Size: 0x42
function private function_1e8e0ba18ad67b4a()
{
    self endon( #"death" );
    self endon( #"dash_cancelled" );
    utility::waittill_notify_or_timeout( "weyward_stinger_swipe_start", 1 );
    
    while ( namespace_cf4ab51195a21b92::function_9dddd89ce61e2f9e() )
    {
        waitframe();
    }
    
    self.var_7cbde7b93399a096 = 0;
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0xbdfb0e3d, Offset: 0xfcf
// Size: 0x54
function private function_221381bb3b0dff26( target )
{
    self.var_59a67f4a2bd3b5f7 = 0;
    self.var_5854d52bc771060 = undefined;
    self.var_149c7ca28b59287b = 0;
    self.var_9c344f8b4d3d4884 = 1;
    self._blackboard.meleerequestedtarget = target;
    function_681e089555a938d2( 1 );
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x55bcb0f, Offset: 0x102b
// Size: 0x112
function private function_7e5f2c4e0e3c9b5b()
{
    self endon( #"death" );
    self endon( #"hash_e09ad0d77ab9f60e" );
    self endon( #"dash_cancelled" );
    target = self.var_5854d52bc771060;
    
    if ( !isalive( target ) || function_65eff24097f8f057( target ) || !function_47cb184ab93cdde7( target ) )
    {
        function_80a25f5c975e2dd0( target );
        return;
    }
    
    wait 0;
    
    if ( function_65eff24097f8f057( target ) || !function_47cb184ab93cdde7( target ) )
    {
        function_80a25f5c975e2dd0( target );
        return;
    }
    
    self.var_149c7ca28b59287b--;
    var_fc75a01b3953dd4a = self.var_149c7ca28b59287b <= 0;
    self.var_50781d61dc86a4bf = 0.65;
    self.var_9c344f8b4d3d4884 = var_fc75a01b3953dd4a;
    self._blackboard.meleerequestedtarget = target;
    
    if ( var_fc75a01b3953dd4a && function_75d58fc6275b7ee9( target ) )
    {
        function_80a25f5c975e2dd0( target );
        return;
    }
    
    function_681e089555a938d2( var_fc75a01b3953dd4a );
    start_dash( "target", target, var_fc75a01b3953dd4a, 0 );
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0xd9df1f29, Offset: 0x1145
// Size: 0x1b0
function private function_c12459e7a96618f2( dash_range )
{
    players = self function_f017e352a29a57a1( self.origin, dash_range, 1 );
    best_yaw = undefined;
    best_dist = undefined;
    best_target = undefined;
    
    foreach ( player in players )
    {
        if ( !isplayer( player ) || !isalive( player ) )
        {
            continue;
        }
        
        predicted_player_pos = function_9b85bf0ef3b9d7bf( player );
        var_c51215b779b5fe59 = vectornormalize( predicted_player_pos - self.origin );
        to_player_yaw = vectortoyaw( var_c51215b779b5fe59 );
        dash_yaw = angleclamp180( to_player_yaw - self.angles[ 1 ] );
        
        if ( abs( dash_yaw ) < 90 )
        {
            continue;
        }
        
        nav_trace = navtrace( self.origin, predicted_player_pos, self, 1 );
        
        if ( nav_trace[ "fraction" ] < 0.9 )
        {
            continue;
        }
        
        player_dist = distance( self.origin, predicted_player_pos );
        
        if ( !isdefined( best_dist ) || player_dist < best_dist )
        {
            best_yaw = dash_yaw;
            best_dist = player_dist;
            best_target = player;
        }
    }
    
    if ( !isdefined( best_yaw ) )
    {
        return;
    }
    
    return [ best_yaw, best_target, best_dist ];
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0xa75c065, Offset: 0x12fe
// Size: 0x20f
function private function_381ad2ba9c355c0f()
{
    self endon( #"death" );
    var_17f11989c9dc7d25 = cos( getdvarfloat( @"hash_a9eabb2a3ed96e40", self.var_5ffa91983de9a78a ) );
    
    while ( true )
    {
        anyone_staring = 0;
        players = self function_f017e352a29a57a1( self.origin, self.var_a50620578c87cd34 ?? 1000, 1 );
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) || !isalive( player ) )
            {
                continue;
            }
            
            if ( !utility::within_fov( player geteye(), player getplayerangles(), self.origin, var_17f11989c9dc7d25 ) )
            {
                continue;
            }
            
            if ( !sighttracepassed( player geteye(), self getcentroid(), 0, player, self ) )
            {
                continue;
            }
            
            self.var_76197e1f6e9de341 += level.framedurationseconds;
            self.staring_player = player;
            anyone_staring = 1;
            
            /#
                if ( debug_dash() )
                {
                    line( player geteye(), self getcentroid(), ( 1, 1, 0 ) );
                    print3d( self.origin + ( 0, 0, 100 ), "<dev string:x24>" + self.var_76197e1f6e9de341, ( 1, 1, 0 ) );
                    print3d( self.origin + ( 0, 0, 80 ), "<dev string:x2c>" + self.var_66e9628acb91535d, ( 0, 1, 1 ) );
                }
            #/
            
            break;
        }
        
        if ( !anyone_staring )
        {
            self.var_76197e1f6e9de341 = 0;
            self.staring_player = undefined;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0xbce90804, Offset: 0x1515
// Size: 0x1f2
function private function_5df580fadaba6f9f()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( isalive( self.enemy ) )
        {
            if ( self.var_d4984593f407a505 != self.enemy )
            {
                self.var_66e9628acb91535d = 0;
                self.var_d4984593f407a505 = self.enemy;
                self.var_a754b82be6b582a3 = undefined;
                self.var_6eb184994f060f2c = undefined;
            }
            
            current_dist_sq = distancesquared( self.origin, self.enemy.origin );
            
            if ( !isdefined( self.var_a754b82be6b582a3 ) )
            {
                self.var_a754b82be6b582a3 = current_dist_sq;
                self.var_6eb184994f060f2c = self.origin;
            }
            else
            {
                var_4b2ce735265d99f8 = vectornormalize( self.enemy.origin - self.origin );
                is_facing_enemy = vectordot( anglestoforward( self.angles ), var_4b2ce735265d99f8 ) >= 0.1;
                var_cb974e35da72ac3e = distancesquared( self.origin, self.var_6eb184994f060f2c ) > 0 && current_dist_sq < self.var_a754b82be6b582a3;
                self.var_a754b82be6b582a3 = current_dist_sq;
                self.var_6eb184994f060f2c = self.origin;
                
                if ( is_facing_enemy && var_cb974e35da72ac3e )
                {
                    self.var_66e9628acb91535d += level.framedurationseconds;
                }
                else
                {
                    self.var_66e9628acb91535d = 0;
                }
            }
            
            function_61dbcd2a34518c52();
        }
        else
        {
            self.var_66e9628acb91535d = 0;
            self.var_d4984593f407a505 = undefined;
            self.var_a754b82be6b582a3 = undefined;
            self.var_6eb184994f060f2c = undefined;
            self.var_95b6de8f06af3afd = 0;
            self.var_90ed982408bb66a5 = undefined;
            self.var_1cf0ad3b437ffbc3 = undefined;
            self.var_669dfe06cc13b98c = undefined;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0xf4c185a4, Offset: 0x170f
// Size: 0x1ba
function private function_61dbcd2a34518c52()
{
    if ( self.var_90ed982408bb66a5 != self.enemy )
    {
        self.var_95b6de8f06af3afd = 0;
        self.var_90ed982408bb66a5 = self.enemy;
        self.var_1cf0ad3b437ffbc3 = undefined;
        self.var_669dfe06cc13b98c = undefined;
    }
    
    var_1aaabb623f7163 = getdvarfloat( @"hash_fba916eb59535882", self.var_61abea2ed9e609b8 );
    current_dist_sq = distancesquared( self.origin, self.enemy.origin );
    
    if ( current_dist_sq > squared( var_1aaabb623f7163 ) )
    {
        self.var_95b6de8f06af3afd = 0;
        self.var_1cf0ad3b437ffbc3 = undefined;
        self.var_669dfe06cc13b98c = undefined;
        return;
    }
    
    var_4b2ce735265d99f8 = vectornormalize( self.enemy.origin - self.origin );
    is_facing_enemy = vectordot( anglestoforward( self.angles ), var_4b2ce735265d99f8 ) >= 0.1;
    
    if ( !isdefined( self.var_1cf0ad3b437ffbc3 ) )
    {
        self.var_1cf0ad3b437ffbc3 = current_dist_sq;
        self.var_669dfe06cc13b98c = self.origin;
        return;
    }
    
    var_cb974e35da72ac3e = distancesquared( self.origin, self.var_669dfe06cc13b98c ) > 0 && current_dist_sq < self.var_1cf0ad3b437ffbc3;
    self.var_1cf0ad3b437ffbc3 = current_dist_sq;
    self.var_669dfe06cc13b98c = self.origin;
    
    if ( is_facing_enemy && var_cb974e35da72ac3e )
    {
        self.var_95b6de8f06af3afd += level.framedurationseconds;
        return;
    }
    
    self.var_95b6de8f06af3afd = 0;
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x586968e1, Offset: 0x18d1
// Size: 0x53
function private function_1de098af38a28c57( stare_target )
{
    normal_cooldown_s = getdvarfloat( @"hash_b25fb2ff794e1e96", self.var_3b0e94cacb0567c0 );
    
    if ( !function_7bd1eaf46ce5d740( stare_target ) )
    {
        return normal_cooldown_s;
    }
    
    return getdvarfloat( @"hash_c97a7922b518073e", self.var_9cfec2901f9e9ad4 );
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x2a9a8d5e, Offset: 0x192d
// Size: 0x14d
function private function_7bd1eaf46ce5d740( stare_target )
{
    if ( !isalive( stare_target ) || !isplayer( stare_target ) || self.enemy != stare_target )
    {
        return 0;
    }
    
    if ( self.var_95b6de8f06af3afd < getdvarfloat( @"hash_b3a9b422609de048", self.var_c2d80a92e9dabd4e ) )
    {
        return 0;
    }
    
    var_a0d3f1c68d25c770 = distancesquared( self.origin, stare_target.origin );
    
    if ( var_a0d3f1c68d25c770 > squared( getdvarfloat( @"hash_fba916eb59535882", self.var_61abea2ed9e609b8 ) ) )
    {
        return 0;
    }
    
    if ( var_a0d3f1c68d25c770 <= squared( zombie_weyward_melee::function_649a2398227bfc1( stare_target ) ) )
    {
        return 0;
    }
    
    charge_min_dist = getdvarfloat( @"weyward_charge_min_dist", self.charge_min_dist );
    var_5711feb83172d4fe = zombie_weyward_charge::function_b7fcbf9c3db4f16f();
    var_da994ceb6f0cf37e = getdvarfloat( @"hash_dbbdd5b141ac7ff2", self.var_bf19d4231dfe122c ) * 1000;
    
    if ( var_5711feb83172d4fe <= var_da994ceb6f0cf37e && var_a0d3f1c68d25c770 < squared( charge_min_dist ) )
    {
        return 0;
    }
    
    var_a1cb6da989dfbb55 = getdvarfloat( @"hash_8bc16b07b441f31a", self.var_c0c4796bce072f68 );
    return utility::time_has_passed( self.var_a4028c005af94a05, var_a1cb6da989dfbb55 );
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x5fb580c2, Offset: 0x1a83
// Size: 0x257
function private function_f6dff83f1a9ba519( target )
{
    if ( !isdefined( target ) )
    {
        self.var_3b89efd305efc98d = undefined;
        return;
    }
    
    trace_dist = getdvarfloat( @"hash_a9bca4224e440bb0", self.var_88fc4b511eacdfe2 );
    right_dir = anglestoright( self.angles );
    candidate_dirs = [];
    candidate_dirs[ "right" ] = right_dir;
    candidate_dirs[ "left" ] = right_dir * -1;
    best_direction = undefined;
    best_dist = undefined;
    best_end_pos = undefined;
    
    foreach ( dir_name, dir_vec in candidate_dirs )
    {
        trace_end = self.origin + dir_vec * trace_dist;
        nav_trace = navtrace( self.origin, trace_end, self, 1 );
        
        if ( nav_trace[ "fraction" ] < 0.5 )
        {
            /#
                if ( debug_dash() )
                {
                    line( self.origin, nav_trace[ "<dev string:x37>" ], ( 1, 0, 0 ), 1, 1 );
                    print3d( nav_trace[ "<dev string:x37>" ] + ( 0, 0, 20 ), dir_name + "<dev string:x40>", ( 1, 0, 0 ) );
                }
            #/
            
            continue;
        }
        
        end_pos = nav_trace[ "position" ];
        dist_to_target = distance( end_pos, target.origin );
        
        /#
            if ( debug_dash() )
            {
                line( self.origin, end_pos, ( 0, 1, 0 ), 1, 1 );
                print3d( end_pos + ( 0, 0, 20 ), dir_name + "<dev string:x4a>" + dist_to_target, ( 0, 1, 0 ) );
            }
        #/
        
        if ( !isdefined( best_dist ) || dist_to_target < best_dist )
        {
            best_dist = dist_to_target;
            best_direction = dir_name;
            best_end_pos = end_pos;
        }
    }
    
    self.var_3b89efd305efc98d = best_end_pos;
    return best_direction;
}

// Namespace zombie_weyward_dash
// Params 2, eflags: 0x4
// Checksum 0xdb313412, Offset: 0x1ce3
// Size: 0x3e
function private function_8da402cfd7448294( start_pos, end_pos )
{
    nav_trace = navtrace( start_pos, end_pos, self, 1 );
    
    if ( function_5326e4ebce049f0a( nav_trace ) )
    {
        return;
    }
    
    return nav_trace[ "position" ];
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0x8d850443, Offset: 0x1d2a
// Size: 0x1b7, Type: bool
function private function_5326e4ebce049f0a( nav_trace )
{
    var_104801158b0ca3b8 = 200;
    
    if ( !nav_trace[ "position" ] )
    {
        return false;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.placedsentries || !player.placedsentries[ "remote_turret" ] )
        {
            continue;
        }
        
        foreach ( turret in player.placedsentries[ "remote_turret" ] )
        {
            if ( !turret || !turret utility::ent_flag( "remote_sentry_deployed" ) || !turret.var_d4395803edd6f6c6 )
            {
                continue;
            }
            
            if ( turret.navbounds && distance2dsquared( nav_trace[ "position" ], turret.origin ) <= squared( var_104801158b0ca3b8 ) )
            {
                destroynavobstacle( turret.navbounds );
                turret.navbounds = undefined;
                self.var_b8c405f32b753f09 = turret;
                return true;
            }
        }
    }
    
    return false;
}

// Namespace zombie_weyward_dash
// Params 5, eflags: 0x4
// Checksum 0xe1d4b236, Offset: 0x1eea
// Size: 0x7e
function private function_e5430a898de8b5b9( turret, direction, target, var_183f7e6fd734b64b, var_d721e18aba4cb066 )
{
    waitframe();
    
    if ( self.var_b8c405f32b753f09 != turret )
    {
        return;
    }
    
    self.var_b8c405f32b753f09 = undefined;
    
    if ( !isalive( self ) || zombie_stun::is_stunned() )
    {
        function_eb5a6269cae85c7f( turret );
        return;
    }
    
    start_dash( direction, target, var_183f7e6fd734b64b, var_d721e18aba4cb066 );
    thread function_21a9c82b7f2f6038( turret );
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0xe9836438, Offset: 0x1f70
// Size: 0x3b
function private function_21a9c82b7f2f6038( turret )
{
    level endon( #"game_ended" );
    level utility::waittill_any_ents_return( self, "death", self, "bdashended", self, "dash_cancelled" );
    function_eb5a6269cae85c7f( turret );
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x7e63b13d, Offset: 0x1fb3
// Size: 0x2a
function private function_4300b63d28ccdcec()
{
    turret = self.var_b8c405f32b753f09;
    self.var_b8c405f32b753f09 = undefined;
    function_eb5a6269cae85c7f( turret );
}

// Namespace zombie_weyward_dash
// Params 1, eflags: 0x4
// Checksum 0xc8e26f96, Offset: 0x1fe5
// Size: 0x82
function private function_eb5a6269cae85c7f( turret )
{
    if ( !turret || !turret utility::ent_flag( "remote_sentry_deployed" ) || !turret.var_d4395803edd6f6c6 || turret.navbounds )
    {
        return;
    }
    
    turret.navbounds = createnavbadplacebyshape( turret.origin, turret.angles, 8, turret.var_d4395803edd6f6c6, turret.var_d4395803edd6f6c6 );
}

// Namespace zombie_weyward_dash
// Params 4, eflags: 0x4
// Checksum 0xa5d286de, Offset: 0x206f
// Size: 0xc9
function private start_dash( direction, target, var_183f7e6fd734b64b, var_d721e18aba4cb066 )
{
    if ( zombie_stun::is_stunned() )
    {
        return;
    }
    
    direction = function_ce771dc899720bae( direction, target, var_183f7e6fd734b64b, var_d721e18aba4cb066 );
    
    if ( self.var_b8c405f32b753f09 )
    {
        thread function_e5430a898de8b5b9( self.var_b8c405f32b753f09, direction, target, var_183f7e6fd734b64b, var_d721e18aba4cb066 );
        return;
    }
    
    self function_695b8e1b655c2796( "dash", direction );
    thread dash_impact_detection();
    
    if ( var_183f7e6fd734b64b )
    {
        thread function_a3a7a39acf82534e();
    }
    else if ( self.var_59a67f4a2bd3b5f7 )
    {
        thread function_2bff501f6c884c2d();
    }
    
    /#
        if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
        {
            zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x4d>", "<dev string:x6d>" );
        }
    #/
    
    asm::function_7256f5ba459c840b( "dash" );
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x2ef3d8cd, Offset: 0x2140
// Size: 0x3c
function private function_2bff501f6c884c2d()
{
    self endon( #"death" );
    self endon( #"bdashended" );
    self waittill( #"hash_8ba6f9810f098480" );
    asm::asm_fireevent( self.asmname, "finish" );
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x4600fb42, Offset: 0x2184
// Size: 0x3c
function private function_a3a7a39acf82534e()
{
    self endon( #"death" );
    self endon( #"bdashended" );
    self waittill( #"hash_23df8a8f64e1dc03" );
    asm::asm_fireevent( self.asmname, "finish" );
}

// Namespace zombie_weyward_dash
// Params 4, eflags: 0x4
// Checksum 0xb92f44d2, Offset: 0x21c8
// Size: 0x37b
function private function_ce771dc899720bae( direction, target, var_183f7e6fd734b64b, var_d721e18aba4cb066 )
{
    dash_range = getdvarfloat( @"hash_839b1333a27c128d", self.var_b6ff6012a9076027 );
    
    if ( var_d721e18aba4cb066 )
    {
        dash_range = getdvarfloat( @"hash_4cadfed15b80c92f", self.var_6c3fdc08552c87c9 );
    }
    
    start_pos = self.origin;
    end_pos = undefined;
    traversal_angles = self.angles;
    dash_direction = direction;
    
    switch ( direction )
    {
        case #"hash_c9b3133a17a3b2d0":
            end_pos = ( ( var_d721e18aba4cb066 ? start_pos + anglestoright( self.angles ) * dash_range * -1 : self.var_3b89efd305efc98d ) ?? start_pos ) + anglestoright( self.angles ) * dash_range * -1 * 0.5;
            break;
        case #"hash_96815ce4f2a3dbc5":
            end_pos = ( ( var_d721e18aba4cb066 ? start_pos + anglestoright( self.angles ) * dash_range : self.var_3b89efd305efc98d ) ?? start_pos ) + anglestoright( self.angles ) * dash_range * 0.5;
            break;
        case #"hash_5163a22eb8c03302":
            end_pos = start_pos + anglestoforward( self.angles ) * dash_range * -1;
            break;
        case #"hash_343323f1597ffea8":
            if ( isalive( target ) )
            {
                target_pos = function_9b85bf0ef3b9d7bf( target );
                var_ee6433c31961982d = vectornormalize( target_pos - start_pos );
                end_pos = target_pos;
                
                if ( distancesquared( start_pos, end_pos ) > squared( dash_range ) )
                {
                    end_pos = start_pos + var_ee6433c31961982d * dash_range;
                }
                
                if ( var_183f7e6fd734b64b )
                {
                    end_pos = target_pos - var_ee6433c31961982d * function_20b2ec3875996357();
                    
                    if ( distancesquared( start_pos, end_pos ) > squared( dash_range ) )
                    {
                        end_pos = start_pos + var_ee6433c31961982d * dash_range;
                    }
                }
                
                angles_to_target = vectortoangles( var_ee6433c31961982d );
                opposite_target_yaw = angleclamp180( angles_to_target[ 1 ] + 180 );
                traversal_angles = ( angles_to_target[ 0 ], opposite_target_yaw, angles_to_target[ 2 ] );
                self.dash_target_yaw = opposite_target_yaw;
                yaw_diff = angleclamp180( vectortoyaw( var_ee6433c31961982d ) - self.angles[ 1 ] );
                
                if ( yaw_diff >= 90 && yaw_diff < 112.5 )
                {
                    dash_direction = 4;
                }
                else if ( yaw_diff >= 112.5 && yaw_diff < 170 )
                {
                    dash_direction = 1;
                }
                else if ( yaw_diff >= 170 && yaw_diff <= 180 )
                {
                    dash_direction = 2;
                }
                else if ( yaw_diff > -112.5 && yaw_diff <= -90 )
                {
                    dash_direction = 6;
                }
                else if ( yaw_diff > -170 && yaw_diff <= -112.5 )
                {
                    dash_direction = 3;
                }
                else if ( yaw_diff >= -180 && yaw_diff <= -170 )
                {
                    dash_direction = 2;
                }
            }
            
            break;
    }
    
    if ( start_pos && end_pos && traversal_angles )
    {
        end_pos = function_8da402cfd7448294( start_pos, end_pos );
        
        if ( !end_pos )
        {
            return dash_direction;
        }
        
        end_pos = utility::drop_to_ground( end_pos, 350 );
        
        /#
            if ( debug_dash() )
            {
                sphere( end_pos, 24, ( 0, 1, 1 ), 0, 30 );
            }
        #/
        
        self.var_d7a2e688fbb687e5 = start_pos;
        self.var_906a17f3e231e7fc = end_pos;
        self settraversalattributes( start_pos, end_pos, traversal_angles, end_pos );
    }
    
    self.var_3b89efd305efc98d = undefined;
    return dash_direction;
}

// Namespace zombie_weyward_dash
// Params 2, eflags: 0x4
// Checksum 0xd65fc8bb, Offset: 0x254c
// Size: 0x89, Type: bool
function private function_25b900c4acdadc09( hit_targets, target )
{
    foreach ( var_1c23c3b4b3af5469 in hit_targets )
    {
        if ( var_1c23c3b4b3af5469 == target )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0xcb0c93c7, Offset: 0x25de
// Size: 0x247
function private dash_impact_detection()
{
    self endon( #"death" );
    self endon( #"bdashended" );
    var_f65a4041e683646b = getdvarfloat( @"hash_bc602a6662f947e", self.dash_impact_radius );
    dash_damage = getdvarfloat( @"hash_6f5086f914935fb0", self.dash_damage );
    hit_targets = [];
    
    while ( true )
    {
        zombie_weyward_melee::function_6510106c4d7b2934( self.origin, var_f65a4041e683646b );
        potential_targets = getplayersandaiarrayinradius( self.origin, var_f65a4041e683646b );
        
        foreach ( target in potential_targets )
        {
            if ( target == self )
            {
                continue;
            }
            
            if ( function_25b900c4acdadc09( hit_targets, target ) )
            {
                continue;
            }
            
            hit_targets[ hit_targets.size ] = target;
            
            if ( isplayer( target ) )
            {
                if ( target.team == self.team )
                {
                    continue;
                }
                
                target dodamage( dash_damage, self.origin, self, self, "MOD_MELEE" );
                var_62759a566df431e1 = knockback_player( self, target, self.var_50781d61dc86a4bf );
                
                if ( var_62759a566df431e1 && self.var_59a67f4a2bd3b5f7 && target == self.var_5854d52bc771060 )
                {
                    function_221381bb3b0dff26( target );
                }
                
                utility::function_7c10ea82c1e305b8( "dash_impact", "on" );
                continue;
            }
            
            if ( isai( target ) )
            {
                if ( target.team === self.team && target.aicategory === "normal" )
                {
                    target zombie_knockdown::function_6fc167d4a3590991( self.origin );
                }
            }
        }
        
        /#
            if ( debug_dash() )
            {
                sphere( self.origin, 18, ( 1, 0, 1 ) );
                sphere( self.origin, var_f65a4041e683646b, ( 0, 1, 0 ) );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_weyward_dash
// Params 3, eflags: 0x4
// Checksum 0x1e56319d, Offset: 0x282d
// Size: 0xb9, Type: bool
function private knockback_player( weyward, player, knockback_scale )
{
    if ( player.inlaststand )
    {
        return false;
    }
    
    var_c51215b779b5fe59 = vectornormalize2( player.origin - weyward.origin );
    to_player_perp = anglestoright( vectortoangles( var_c51215b779b5fe59 ) );
    knockback_dir = rotatepointaroundvector( to_player_perp, var_c51215b779b5fe59, getdvarfloat( @"hash_1d6d566d0c1fcf61", weyward.var_4426c19e05baff2b ) );
    player knockback( knockback_dir, getdvarfloat( @"hash_285b25197c92e0a8", weyward.dash_knockback ) * knockback_scale, 1 );
    return true;
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x34f6242f, Offset: 0x28ef
// Size: 0x97
function private function_b73ec8535c2a6e40()
{
    if ( !self.var_d7a2e688fbb687e5 || !self.var_906a17f3e231e7fc )
    {
        return;
    }
    
    dir = vectornormalize2( self.var_906a17f3e231e7fc - self.var_d7a2e688fbb687e5 );
    end = self.origin + dir * getdvarfloat( @"hash_839b1333a27c128d", self.var_b6ff6012a9076027 );
    var_7f34180df115288 = length( self getboundshalfsize() ) * 3;
    zombie_weyward_summon_stinger::function_7522313fe70458eb( self.origin, end, var_7f34180df115288 );
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x12997207, Offset: 0x298e
// Size: 0x57
function private function_b200ac05a14a92b8()
{
    self endon( #"death" );
    self endon( #"bdashended" );
    self waittill( #"stay_on_ground" );
    
    while ( true )
    {
        if ( self.var_906a17f3e231e7fc )
        {
            self forceteleport( self.var_906a17f3e231e7fc, self.angles, 3000 );
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_dash
// Params 0, eflags: 0x4
// Checksum 0x4c458604, Offset: 0x29ed
// Size: 0x19a
function private function_106801f66cbd7c6a()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_e09ad0d77ab9f60e" );
        utility::ent_flag_set( "in_dash" );
        utility::function_7c10ea82c1e305b8( "dash", "loop" );
        thread function_b200ac05a14a92b8();
        function_b73ec8535c2a6e40();
        
        if ( self.dash_target_yaw )
        {
            self.turnrate = getdvarfloat( @"hash_4d11203e10526f35", 0.8 );
            self orientmode( "face angle", self.dash_target_yaw );
            self.dash_target_yaw = undefined;
        }
        
        self waittill( #"bdashended" );
        utility::ent_flag_clear( "in_dash" );
        utility::function_7c10ea82c1e305b8( "dash", "off" );
        utility::function_7c10ea82c1e305b8( "dash_impact", "off" );
        self.var_c221c2a6812747cd = gettime();
        
        if ( self.var_f122084c179b6412 )
        {
            self.var_a4028c005af94a05 = self.var_c221c2a6812747cd;
            self.var_f122084c179b6412 = 0;
        }
        
        if ( self.var_e463e01d922ca747 )
        {
            self.var_df13f8eb676bae22 = self.var_c221c2a6812747cd;
            self.var_e463e01d922ca747 = 0;
        }
        
        self.dash_target_yaw = undefined;
        self.turnrate = getdvarfloat( @"weyward_turn_rate", 0.1 );
        
        if ( self.var_9c344f8b4d3d4884 )
        {
            function_80a25f5c975e2dd0( self._blackboard.meleerequestedtarget );
            continue;
        }
        
        if ( self.var_59a67f4a2bd3b5f7 )
        {
            thread function_7e5f2c4e0e3c9b5b();
            continue;
        }
        
        self.var_50781d61dc86a4bf = 1;
    }
}

/#

    // Namespace zombie_weyward_dash
    // Params 0, eflags: 0x4
    // Checksum 0x835c2650, Offset: 0x2b8f
    // Size: 0x9c, Type: dev
    function private function_b458a037df882ec9()
    {
        devgui::function_9082edeb5db93280( "<dev string:x72>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x90>", "<dev string:xa1>", &force_dash );
        devgui::function_cd4e263c1f3018ae( "<dev string:xba>", "<dev string:xca>", &force_dash );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe2>", "<dev string:xf2>", &force_dash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x10a>", "<dev string:x11c>", &force_dash );
        devgui::function_cd4e263c1f3018ae( "<dev string:x136>", "<dev string:x14f>", &force_dash );
        devgui::add_devgui_func( "<dev string:x171>", "<dev string:x17c>", &function_62cc98b7a882fcef );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_dash
    // Params 1, eflags: 0x4
    // Checksum 0x764d3e3e, Offset: 0x2c33
    // Size: 0x1c0, Type: dev
    function private force_dash( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x196>" );
        
        if ( !isdefined( weyward ) || !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        if ( params[ 0 ] == "<dev string:x1a5>" || params[ 0 ] == "<dev string:x1ac>" )
        {
            var_4b2ce735265d99f8 = vectornormalize( level.players[ 0 ].origin - weyward.origin );
            to_enemy_yaw = vectortoyaw( var_4b2ce735265d99f8 );
            yaw_diff = angleclamp180( to_enemy_yaw - weyward.angles[ 1 ] );
            weyward setaimangles( ( 0, yaw_diff, 0 ) );
        }
        
        target = undefined;
        var_183f7e6fd734b64b = 0;
        direction = params[ 0 ];
        
        if ( params[ 0 ] == "<dev string:x1a5>" || params[ 0 ] == "<dev string:x1ac>" )
        {
            target = level.players[ 0 ];
        }
        
        if ( params[ 0 ] == "<dev string:x1ac>" )
        {
            direction = "<dev string:x1a5>";
            var_183f7e6fd734b64b = 0;
            weyward.var_50781d61dc86a4bf = 0.65;
            weyward.var_9c344f8b4d3d4884 = 0;
            weyward.var_7cbde7b93399a096 = 1;
            weyward.var_59a67f4a2bd3b5f7 = 1;
            weyward.var_5854d52bc771060 = target;
            weyward.var_149c7ca28b59287b = 1;
            weyward._blackboard.meleerequestedtarget = target;
        }
        
        weyward start_dash( direction, target, var_183f7e6fd734b64b, 0 );
        
        if ( params[ 0 ] == "<dev string:x1ac>" )
        {
            weyward thread function_bbc373b97c7dee44();
        }
    }

    // Namespace zombie_weyward_dash
    // Params 1, eflags: 0x4
    // Checksum 0x480b1f36, Offset: 0x2dfb
    // Size: 0x24, Type: dev
    function private function_62cc98b7a882fcef( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x1bb>", @"hash_fb555ae012d03ba8" );
    }

    // Namespace zombie_weyward_dash
    // Params 0, eflags: 0x4
    // Checksum 0xa7b9fa2d, Offset: 0x2e27
    // Size: 0x16, Type: dev
    function private debug_dash()
    {
        return getdvarint( @"hash_fb555ae012d03ba8", 0 ) > 0;
    }

#/
