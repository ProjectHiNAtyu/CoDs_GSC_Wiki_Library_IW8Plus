// script_38a61e43967bfd11  (hash_38a61e43967bfd11.gscc) (size: 20481 Bytes / 0x5001 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d9b5ab3 (1033591475)
// size ...... 20481 (0x5001)
// includes .. 16  (offset: 0x4c21)
// strings ... 32  (offset: 0x4ca1)
// dev strs .. 26  (offset: 0x4ec9)
// exports ... 57  (offset: 0x2e5d)
// cseg ...... 0x295 + 0x2bc8 (0x2e5d)
// imports ... 165 (offset: 0x3745)
// animtree1 . 0   (offset: 0x5001)
// animtree2 . 0   (offset: 0x5001)
#using script_14f857806c1ea0cc;
#using script_16ea1b94f0f381b3;
#using script_190e128009243fcb;
#using script_1fc20b38e0fc8291;
#using script_46e6a605b00ce67c;
#using script_647f89a5ad29de54;
#using script_aa3bac81ad4fc8e;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\playerhealth;

#namespace zombie_weyward_charge;

/#

    // Namespace zombie_weyward_charge
    // Params 0
    // Checksum 0x95207c5e, Offset: 0x2b3
    // Size: 0xc, Type: dev
    function function_721331952e522204()
    {
        function_bcf51ac97a871369();
    }

#/

// Namespace zombie_weyward_charge
// Params 1
// Checksum 0xdb9f3bc0, Offset: 0x2c7
// Size: 0x17
function function_cdcfdfc73ca5701d( chain_limit )
{
    self.var_c2656b40a74679a9 = chain_limit;
}

// Namespace zombie_weyward_charge
// Params 1
// Checksum 0x61c43807, Offset: 0x2e6
// Size: 0x17
function set_charge_cooldown( cooldown_s )
{
    self.charge_cooldown_s = cooldown_s;
}

// Namespace zombie_weyward_charge
// Params 2
// Checksum 0x5bb0c036, Offset: 0x305
// Size: 0x2b
function function_b315953887314114( center, half_extents )
{
    self.var_c7a3c3c3948d55f9 = center;
    self.var_62aa1e12007f1437 = half_extents;
}

// Namespace zombie_weyward_charge
// Params 0
// Checksum 0xbea9b6b1, Offset: 0x338
// Size: 0x53
function function_352aeaca3b19325a()
{
    var_77882d7b603bb1ba = 4;
    var_fe2cdd14e156b484 = getdvarint( @"hash_5c4dabbd1ba0bc73", self.var_c2656b40a74679a9 );
    
    if ( self.var_a2638d3c0a211262 )
    {
        var_fe2cdd14e156b484 = max( var_fe2cdd14e156b484, var_77882d7b603bb1ba );
    }
    
    self.var_1d1af87ed98220e5 = var_fe2cdd14e156b484 + 1;
}

// Namespace zombie_weyward_charge
// Params 0
// Checksum 0xa3afb461, Offset: 0x393
// Size: 0x25
function cancel_charge()
{
    if ( !utility::ent_flag( "in_charge" ) )
    {
        return;
    }
    
    function_352aeaca3b19325a();
    self notify( #"hash_3355b01f5562b777" );
}

// Namespace zombie_weyward_charge
// Params 0
// Checksum 0xc178a9b1, Offset: 0x3c0
// Size: 0x309
function init_zombie_weyward_charge()
{
    self function_786bb6aa1b76c7ee( "charge_into_dash_combo", 0 );
    self.last_charge_time = 0;
    self.var_3cb89955446d1ea4 = 0;
    self.var_dbf4529899f0bd1c = 0;
    self.charge_attack_target = undefined;
    self.charge_target = undefined;
    self.var_c7a3c3c3948d55f9 = undefined;
    self.var_62aa1e12007f1437 = undefined;
    self.var_a2638d3c0a211262 = 0;
    self.var_ee97cb0dc3d17280 = undefined;
    self.var_fb16c56412d6a406 = 0;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.charge_min_dist = settings.chargemindist ?? 400;
    self.charge_max_yaw = settings.var_2786f67d2a824f6b ?? 45;
    self.charge_cooldown_s = settings.chargecooldown ?? 8;
    self.var_901b019cb1313a3 = settings.var_4345cf1873906643 ?? 0.5;
    self.var_f6e713188e67d70a = settings.var_ede1ac67e6f94f33 ?? 5.5;
    self.charge_impact_radius = settings.var_b2f876a92723bcca ?? 200;
    self.charge_impact_shock = settings.var_e916d382ecba7d2e;
    self.charge_damage = settings.chargedamage ?? 140;
    self.charge_knockback_pitch = settings.var_f8d5b983ac274da5 ?? 30;
    self.charge_knockback = settings.chargeknockback ?? 600;
    self.var_bb4055daf354be69 = settings.var_84a1964b55298ab5 ?? 55;
    self.charge_knockback_ai = settings.var_fdc086706c788b13 ?? 600;
    self.charge_enabled = settings.chargeenabled ?? 1;
    self.var_cbb999639e24fefa = settings.var_323b73d4dbb6112 ?? 200;
    self.var_c2656b40a74679a9 = settings.var_1abc9e021a4e87b2 ?? 2;
    self.var_1a040542fe3e0928 = settings.var_6444860588080a81 ?? 200;
    self.var_19f348f7ac0b1319 = settings.var_c7dc57e2d98d1fd6 ?? 0.2;
    self.var_b6bd8706405788af = settings.var_28e1b0d0a3a53ccf ?? 5;
    self.var_86b1728fe2c128e7 = settings.var_fb2cff2e5b4711c5 ?? 0.75;
    self.var_6c9f65132aac2523 = [ 1.1, settings.var_c6b97a99fb8a16bf ?? 1.11, settings.var_da7d3742a8a163de ?? 1.12, settings.var_94c2ce2945bb51d ?? 1.13 ];
    self.var_8c99b8d704afedc4 = settings.var_82a0364ba8769de2 ?? 0.15;
    thread function_a407b87e904f860a();
    thread function_f2a7226e20a92912();
    thread function_24c16f1151475460();
    
    /#
        thread function_1e32956e9bac8815();
    #/
}

// Namespace zombie_weyward_charge
// Params 2
// Checksum 0x113944fe, Offset: 0x6d1
// Size: 0x3fc
function function_d54b76646dbf52d3( taskid, params )
{
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( zombie_stun::is_stunned() )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "in_charge" ) )
    {
        return anim.running;
    }
    
    if ( function_d0cc4eb0f2c40b91() )
    {
        return anim.failure;
    }
    
    if ( !getdvarint( @"hash_1c9f1c0b896fc076", self.charge_enabled ) )
    {
        if ( namespace_c57c4bda2cd4484a::function_4a278f68fa44b37( "charge" ) )
        {
            namespace_c57c4bda2cd4484a::function_e150aff9299e8439();
        }
        
        return anim.failure;
    }
    
    if ( namespace_c57c4bda2cd4484a::function_4a278f68fa44b37( "charge" ) )
    {
        var_54536d6f9c8a4837 = namespace_c57c4bda2cd4484a::function_3ff492a8c06c648e();
        
        if ( !namespace_c57c4bda2cd4484a::function_3719f5ec7b5bd679() )
        {
            namespace_c57c4bda2cd4484a::function_f24771760c767129();
            return anim.failure;
        }
        
        if ( isplayer( var_54536d6f9c8a4837 ) && var_54536d6f9c8a4837.inlaststand )
        {
            namespace_c57c4bda2cd4484a::function_f24771760c767129();
            return anim.failure;
        }
        
        if ( !namespace_c57c4bda2cd4484a::function_b997dd252e9900bd() )
        {
            return anim.failure;
        }
        
        nav_trace = navtrace( self.origin, var_54536d6f9c8a4837.origin, self, 1 );
        
        if ( nav_trace[ "fraction" ] < 0.9 )
        {
            turret = function_5326e4ebce049f0a( nav_trace, 1 );
            
            if ( turret )
            {
                return anim.failure;
            }
            
            if ( nav_trace[ "fraction" ] < 0.9 )
            {
                function_eca781625d600c9b();
                namespace_c57c4bda2cd4484a::function_e150aff9299e8439();
                return anim.failure;
            }
        }
        
        forward_dir = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
        to_target_dir = vectornormalize2( var_54536d6f9c8a4837.origin - self.origin );
        
        if ( vectordot( forward_dir, to_target_dir ) <= 0.4 )
        {
            function_eca781625d600c9b();
            namespace_c57c4bda2cd4484a::function_e70c18ec4d85221f();
            return anim.failure;
        }
        
        self.charge_attack_target = var_54536d6f9c8a4837;
        function_a5b7553299c99ae2();
        thread start_charge();
        return anim.running;
    }
    
    if ( !function_af087da6391a4616() )
    {
        return anim.failure;
    }
    
    if ( !self.enemy || !isalive( self.enemy ) )
    {
        return anim.failure;
    }
    
    if ( isplayer( self.enemy ) && self.enemy.inlaststand )
    {
        return anim.failure;
    }
    
    dist_to_enemy_sq = distancesquared( self.origin, self.enemy.origin );
    min_dist = getdvarfloat( @"weyward_charge_min_dist", self.charge_min_dist );
    
    if ( dist_to_enemy_sq < squared( min_dist ) && !function_79ff89d81df056e() )
    {
        return anim.failure;
    }
    
    to_yaw = utility::getyawtospot( self.enemy.origin );
    max_yaw = getdvarfloat( @"hash_a2b32a33776f5ebd", self.charge_max_yaw );
    
    if ( abs( to_yaw ) > max_yaw )
    {
        return anim.failure;
    }
    
    nav_trace = navtrace( self.origin, self.enemy.origin, self, 1 );
    
    if ( nav_trace[ "fraction" ] < 0.9 )
    {
        turret = function_5326e4ebce049f0a( nav_trace, 1 );
        
        if ( turret )
        {
            return anim.failure;
        }
        
        if ( nav_trace[ "fraction" ] < 0.9 )
        {
            function_eca781625d600c9b();
            return anim.failure;
        }
    }
    
    function_a5b7553299c99ae2();
    thread start_charge();
    return anim.running;
}

// Namespace zombie_weyward_charge
// Params 2, eflags: 0x4
// Checksum 0x99e8a0a, Offset: 0xad6
// Size: 0x1d5
function private function_5326e4ebce049f0a( nav_trace, var_a69bb37fb7a81dcb = 0 )
{
    var_535b06baa867e27f = 200;
    
    if ( !nav_trace[ "position" ] )
    {
        return 0;
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
            
            if ( turret.navbounds && distance2dsquared( nav_trace[ "position" ], turret.origin ) <= squared( var_535b06baa867e27f ) )
            {
                destroynavobstacle( turret.navbounds );
                turret.navbounds = undefined;
                
                if ( var_a69bb37fb7a81dcb )
                {
                    self.var_48fb7de8013213fd = turret;
                    thread function_a4fafa887b3057a4( turret );
                }
                
                return turret;
            }
        }
    }
}

// Namespace zombie_weyward_charge
// Params 1, eflags: 0x4
// Checksum 0x8d4a524c, Offset: 0xcb4
// Size: 0x24
function private function_a4fafa887b3057a4( turret )
{
    waitframe();
    
    if ( self.var_48fb7de8013213fd != turret )
    {
        return;
    }
    
    function_eca781625d600c9b();
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x127629f9, Offset: 0xce0
// Size: 0x2f
function private function_a5b7553299c99ae2()
{
    turret = self.var_48fb7de8013213fd;
    self.var_48fb7de8013213fd = undefined;
    
    if ( turret )
    {
        thread function_a85c799bd443aa30( turret );
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xa2bb1e90, Offset: 0xd17
// Size: 0x2f
function private function_eca781625d600c9b()
{
    turret = self.var_48fb7de8013213fd;
    self.var_48fb7de8013213fd = undefined;
    
    if ( turret )
    {
        function_eb5a6269cae85c7f( turret );
    }
}

// Namespace zombie_weyward_charge
// Params 1, eflags: 0x4
// Checksum 0x8460d364, Offset: 0xd4e
// Size: 0x116
function private function_a85c799bd443aa30( turret )
{
    var_2230b48fa04dffcc = 120;
    var_535b06baa867e27f = 200;
    turret endon( #"kill_turret", #"death" );
    level endon( #"game_ended" );
    var_aaf38a1a816e2cac = 0;
    
    while ( var_aaf38a1a816e2cac < var_2230b48fa04dffcc )
    {
        if ( !isalive( self ) )
        {
            level function_eb5a6269cae85c7f( turret );
            return;
        }
        
        if ( utility::ent_flag( "in_charge" ) )
        {
            break;
        }
        
        var_aaf38a1a816e2cac++;
        waitframe();
    }
    
    if ( !isalive( self ) || !utility::ent_flag( "in_charge" ) )
    {
        level function_eb5a6269cae85c7f( turret );
        return;
    }
    
    while ( true )
    {
        if ( !isalive( self ) )
        {
            level function_eb5a6269cae85c7f( turret );
            return;
        }
        
        if ( distance2dsquared( self.origin, turret.origin ) <= squared( var_535b06baa867e27f ) )
        {
            turret notify( #"kill_turret", 1, 1, 0 );
            return;
        }
        
        if ( !utility::ent_flag( "in_charge" ) )
        {
            level function_eb5a6269cae85c7f( turret );
            return;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_charge
// Params 1, eflags: 0x4
// Checksum 0xa183867f, Offset: 0xe6c
// Size: 0x102
function private function_1465d33cb636e023( player )
{
    self endon( #"death", #"hash_3355b01f5562b777" );
    var_4bfdece339de74d3 = 2;
    var_c1980663ecee5e57 = 280;
    
    if ( !utility::ent_flag( "in_charge" ) )
    {
        self waittill( #"hash_9e18389f00c01822" );
    }
    
    utility::ent_flag_wait_or_timeout( "in_charge", var_4bfdece339de74d3 );
    
    if ( !utility::ent_flag( "in_charge" ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( !isalive( player ) || !isalive( player.bgb_hellping_hound ) )
        {
            return;
        }
        
        if ( distance2dsquared( self.origin, player.bgb_hellping_hound.origin ) <= squared( var_c1980663ecee5e57 ) )
        {
            var_e97a4f4962bc3f25 = player bgb::get_bgb_slot( "helping_hound" );
            
            if ( var_e97a4f4962bc3f25 )
            {
                player.bgb_hellping_hound function_7f8988ce63c1623d( 0 );
                player bgb::take( var_e97a4f4962bc3f25 );
            }
            
            return;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_charge
// Params 1, eflags: 0x4
// Checksum 0xc0ec91d5, Offset: 0xf76
// Size: 0x82
function private function_eb5a6269cae85c7f( turret )
{
    if ( !turret || !turret utility::ent_flag( "remote_sentry_deployed" ) || !turret.var_d4395803edd6f6c6 || turret.navbounds )
    {
        return;
    }
    
    turret.navbounds = createnavbadplacebyshape( turret.origin, turret.angles, 8, turret.var_d4395803edd6f6c6, turret.var_d4395803edd6f6c6 );
}

// Namespace zombie_weyward_charge
// Params 2
// Checksum 0xf15f42d9, Offset: 0x1000
// Size: 0x1c3
function function_81a73ee60da05b9a( taskid, params )
{
    assert( isalive( self ) && isai( self ) );
    
    if ( !isalive( self ) || !isai( self ) )
    {
        return anim.failure;
    }
    
    if ( zombie_stun::is_stunned() )
    {
        return anim.failure;
    }
    
    if ( utility::ent_flag( "in_charge" ) )
    {
        return anim.running;
    }
    
    if ( function_d0cc4eb0f2c40b91() )
    {
        return anim.failure;
    }
    
    if ( !getdvarint( @"hash_1c9f1c0b896fc076", self.charge_enabled ) )
    {
        return anim.failure;
    }
    
    if ( utility::flag( "playing_game_over_scene" ) )
    {
        return anim.failure;
    }
    
    if ( !self getaiblackboarddynamic( "no_enemies_detected" ) )
    {
        return anim.failure;
    }
    
    if ( self.wipe_attack_active )
    {
        return anim.failure;
    }
    
    var_901b019cb1313a3 = getdvarfloat( @"hash_fa7d4bb4feb54a51", self.var_901b019cb1313a3 );
    
    if ( self.var_3cb89955446d1ea4 && !utility::time_has_passed( self.var_3cb89955446d1ea4, var_901b019cb1313a3 ) )
    {
        return anim.failure;
    }
    
    var_ee97cb0dc3d17280 = namespace_aa44c48b952946c7::function_9c857088d8d07e7c();
    
    if ( !var_ee97cb0dc3d17280 )
    {
        /#
            namespace_aa44c48b952946c7::charge_print( "<dev string:x24>" );
        #/
        
        return anim.failure;
    }
    
    self.var_a2638d3c0a211262 = 1;
    self.var_ee97cb0dc3d17280 = var_ee97cb0dc3d17280;
    self.var_fb16c56412d6a406 = function_ebf68be6a1625b30( var_ee97cb0dc3d17280 );
    self orientmode( "face angle", angleclamp180( vectortoyaw( var_ee97cb0dc3d17280 - self.origin ) ) );
    thread start_charge();
    return anim.running;
}

// Namespace zombie_weyward_charge
// Params 1, eflags: 0x4
// Checksum 0x91303d56, Offset: 0x11cc
// Size: 0x5e, Type: bool
function private function_ebf68be6a1625b30( target_pos )
{
    var_e7c8b22bbe4730bf = -0.1;
    forward_dir = anglestoforward( ( 0, self.angles[ 1 ], 0 ) );
    to_target_dir = vectornormalize2( target_pos - self.origin );
    return vectordot( forward_dir, to_target_dir ) <= var_e7c8b22bbe4730bf;
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x9194cc37, Offset: 0x1233
// Size: 0x64, Type: bool
function private function_5cc81d72313a23cc()
{
    return self.var_a2638d3c0a211262 && isdefined( self.var_ee97cb0dc3d17280 ) || isalive( self.charge_target ) && ( !isplayer( self.charge_target ) || !self.charge_target.inlaststand ) && !utility::flag( "playing_game_over_scene" );
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xc1457d7f, Offset: 0x12a0
// Size: 0x2b
function private get_charge_target_pos()
{
    if ( self.var_a2638d3c0a211262 )
    {
        return self.var_ee97cb0dc3d17280;
    }
    
    return self.charge_target.origin;
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xf907c507, Offset: 0x12d4
// Size: 0x84, Type: bool
function private function_d0cc4eb0f2c40b91()
{
    if ( !self.var_c7a3c3c3948d55f9 )
    {
        return false;
    }
    
    if ( !self.var_62aa1e12007f1437 )
    {
        return false;
    }
    
    delta = self.origin - self.var_c7a3c3c3948d55f9;
    return abs( delta[ 0 ] ) <= self.var_62aa1e12007f1437[ 0 ] && abs( delta[ 1 ] ) <= self.var_62aa1e12007f1437[ 1 ] && abs( delta[ 2 ] ) <= self.var_62aa1e12007f1437[ 2 ];
}

// Namespace zombie_weyward_charge
// Params 0
// Checksum 0xa1bd3ea4, Offset: 0x1361
// Size: 0xf
function function_f720008f12cb85d3()
{
    self.var_dbf4529899f0bd1c = gettime();
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x78b1aef0, Offset: 0x1378
// Size: 0x4f
function private function_79ff89d81df056e()
{
    if ( asm::asm_getcurrentstatename( self.asmname ) != "move" )
    {
        return 0;
    }
    
    delay_s = getdvarfloat( @"hash_cb770409f15e7e14", self.var_f6e713188e67d70a );
    return utility::time_has_passed( self.var_dbf4529899f0bd1c, delay_s );
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xf408b23f, Offset: 0x13d0
// Size: 0x2a
function private function_24c16f1151475460()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bmeleeended" );
        function_f720008f12cb85d3();
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x436cf0cd, Offset: 0x1402
// Size: 0x51, Type: bool
function private function_af087da6391a4616()
{
    cooldown = get_charge_cooldown_ms();
    current_time = gettime();
    
    if ( self.last_charge_time > 0 )
    {
        var_cc8f8e7d2ce57f7 = current_time - self.last_charge_time;
        
        if ( var_cc8f8e7d2ce57f7 < cooldown )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zombie_weyward_charge
// Params 0
// Checksum 0xedcd5e9c, Offset: 0x145c
// Size: 0x2b
function function_b7fcbf9c3db4f16f()
{
    if ( !self.last_charge_time )
    {
        return 0;
    }
    
    return max( 0, get_charge_cooldown_ms() - gettime() - self.last_charge_time );
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x23430954, Offset: 0x1490
// Size: 0x62
function private get_charge_cooldown_ms()
{
    base_cooldown_ms = getdvarfloat( @"hash_c77b49e10195a61a", self.charge_cooldown_s ) * 1000;
    var_1db1d12235dd0f9a = zombie_weyward_summon_stinger::function_1e8ea900b7d3d48f();
    ratio_multiplier = getdvarfloat( @"hash_fad551f9103ddf75", self.var_86b1728fe2c128e7 );
    return base_cooldown_ms * ( 1 + var_1db1d12235dd0f9a * ratio_multiplier );
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xcf464622, Offset: 0x14fb
// Size: 0x74
function private start_charge()
{
    if ( zombie_stun::is_stunned() )
    {
        return;
    }
    
    if ( function_d0cc4eb0f2c40b91() )
    {
        return;
    }
    
    namespace_aa44c48b952946c7::function_3e1fc22f8d6ba1e8();
    
    if ( !function_5cc81d72313a23cc() )
    {
        return;
    }
    
    var_b0a4a37c654dae64 = self.turnrate;
    self.turnrate = getdvarfloat( @"hash_98d4e8dc53c04a8", 1 );
    thread function_5006db6e8111773();
    self waittill( #"hash_730c53e28810a592" );
    self.turnrate = var_b0a4a37c654dae64;
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xe6c915f1, Offset: 0x1577
// Size: 0x5f
function private function_5006db6e8111773()
{
    self endon( #"death" );
    self endon( #"hash_730c53e28810a592" );
    
    while ( true )
    {
        if ( !function_5cc81d72313a23cc() )
        {
            return;
        }
        
        target_pos = get_charge_target_pos();
        self orientmode( "face angle", angleclamp180( vectortoyaw( target_pos - self.origin ) ) );
        waitframe();
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xe8cc06ec, Offset: 0x15de
// Size: 0x15
function private charge_damage_loop()
{
    self endon( #"hash_836efc1107f5d88c" );
    function_6114db90686b0e13();
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x13a58a3f, Offset: 0x15fb
// Size: 0x37
function private function_290f8fe5d9e23d6d()
{
    self endon( #"death" );
    self endon( #"hash_3355b01f5562b777" );
    self endon( #"hash_a91d2d69a2d9dd8d" );
    
    if ( zombie_stun::is_stunned() )
    {
        return;
    }
    
    function_6114db90686b0e13();
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x212d8ba1, Offset: 0x163a
// Size: 0x321
function private function_6114db90686b0e13()
{
    impact_radius = getdvarfloat( @"hash_e7225b45ca5b8a6", self.charge_impact_radius );
    charge_damage = getdvarfloat( @"hash_b1c8037076f1fc18", self.charge_damage );
    var_2a74b6ca797cbcf = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_87c6765822cd6eeb;
    
    if ( var_2a74b6ca797cbcf && level.players.size > 1 )
    {
        charge_damage += charge_damage * ( level.players.size - 1 ) * var_2a74b6ca797cbcf;
    }
    
    while ( true )
    {
        potential_targets = getplayersandaiarrayinradius( self.origin, impact_radius );
        
        foreach ( target in potential_targets )
        {
            if ( target == self )
            {
                continue;
            }
            
            if ( target utility::ent_flag( "weyward_charged" ) )
            {
                continue;
            }
            
            if ( isplayer( target ) )
            {
                if ( target.team == self.team )
                {
                    continue;
                }
                
                target dodamage( charge_damage, self.origin, self, self, "MOD_MELEE" );
                target namespace_9d8e359c3b1041e5::shellshocksharedfunc( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e916d382ecba7d2e, #"damage", 5 );
                knocked_airborne = knockback_player( self, target );
                target utility::ent_flag_set( "weyward_charged" );
                
                if ( knocked_airborne )
                {
                    target thread function_ce7b72da190a0e99();
                }
                else
                {
                    target thread utility::ent_flag_clear_delayed( "weyward_charged", 2 );
                }
                
                continue;
            }
            
            if ( isai( target ) )
            {
                if ( target.team === self.team && target.aicategory === "normal" )
                {
                    cannonball_dir = vectornormalize2( target.origin - self.origin );
                    cannonball_right = vectorcross( cannonball_dir, ( 0, 0, 1 ) );
                    
                    if ( lengthsquared( cannonball_right ) > 0.001 )
                    {
                        cannonball_dir = rotatepointaroundvector( cannonball_right, cannonball_dir, getdvarfloat( @"hash_b7a4613422859e89", 45 ) );
                    }
                    
                    target zombie_cannonball::cannonball_ai( cannonball_dir, getdvarfloat( @"hash_ab9ca6c7abbe9bc3", 700 ), zombie_cannonball::adv_settings( 1, getdvarfloat( @"hash_a3c6788c8e8ffa84", 8 ), 0, getdvarfloat( @"hash_52834e28e775c3a9", 900 ) ), "roll_forward" );
                }
                
                target utility::ent_flag_set( "weyward_charged" );
                target thread utility::ent_flag_clear_delayed( "weyward_charged", 2 );
            }
        }
        
        /#
            if ( debug_charge() )
            {
                sphere( self.origin, impact_radius, ( 0.2, 0.8, 0.2 ) );
            }
        #/
        
        waitframe();
    }
}

// Namespace zombie_weyward_charge
// Params 2, eflags: 0x4
// Checksum 0xd2662d, Offset: 0x1963
// Size: 0x24d, Type: bool
function private knockback_player( weyward, player )
{
    if ( player.inlaststand )
    {
        return false;
    }
    
    var_c51215b779b5fe59 = vectornormalize2( player.origin - weyward.origin );
    right = anglestoright( weyward.angles );
    horizontal_dir = anglestoforward( weyward.angles );
    yaw_angle = getdvarfloat( @"hash_b6a806e4b4978d1f", self.var_bb4055daf354be69 );
    knockback_pitch = getdvarfloat( @"weyward_charge_knockback_pitch", self.charge_knockback_pitch );
    var_c8cf90daee0f67a3 = getdvarfloat( @"weyward_charge_knockback", self.charge_knockback );
    
    if ( vectordot( right, var_c51215b779b5fe59 ) > 0 )
    {
        yaw_angle *= -1;
    }
    
    horizontal_dir = rotatepointaroundvector( ( 0, 0, 1 ), horizontal_dir, yaw_angle );
    horizontal_dir = vectornormalize2( horizontal_dir );
    horizontal_perp = anglestoright( vectortoangles( horizontal_dir ) );
    knockback_dir = rotatepointaroundvector( horizontal_perp, horizontal_dir, knockback_pitch );
    player.var_940d7b16bf043325 = undefined;
    player.charge_knockback_landing_spot = undefined;
    
    if ( knockback_pitch > 0 )
    {
        player.var_940d7b16bf043325 = 1;
        player.charge_knockback_landing_spot = namespace_aa44c48b952946c7::function_633564ba53089520( player, player.origin, knockback_dir * var_c8cf90daee0f67a3 );
    }
    
    player knockback( knockback_dir, var_c8cf90daee0f67a3, 1 );
    player earthquakeforplayer( 0.75, 0.75, weyward.origin, self.charge_impact_radius );
    player playrumbleonentity( "heavy_1s" );
    player playsound( #"hash_75baefd1c5df2e82" );
    player notify( #"zombie_weyward_charge_knockback" );
    player val::set( "zombie_weyward_charge_knockback", "health_regen", 0 );
    player utility::delaythreadendon( 3, [ "disconnect", "zombie_weyward_charge_knockback" ], &function_778b3c931db5e80b );
    
    if ( self.charge_impact_shock )
    {
        player namespace_9d8e359c3b1041e5::shellshocksharedfunc( self.charge_impact_shock, #"damage", 1.5 );
    }
    
    player thread function_fd8e17b0f00a4575( weyward );
    return knockback_pitch > 0;
}

// Namespace zombie_weyward_charge
// Params 0
// Checksum 0x868c7ef8, Offset: 0x1bb9
// Size: 0x35
function function_778b3c931db5e80b()
{
    val::reset( "zombie_weyward_charge_knockback", "health_regen" );
    
    if ( isalive( self ) && self.health == 1 )
    {
        playerhealth::forcehealthregen( self, 1 );
    }
}

// Namespace zombie_weyward_charge
// Params 1, eflags: 0x4
// Checksum 0x3a4dce92, Offset: 0x1bf6
// Size: 0x151
function private function_fd8e17b0f00a4575( weyward )
{
    self endon( #"death" );
    var_f07ec2e26d68259f = 0.3;
    
    foreach ( wither in weyward.var_bfec04d50947b318 )
    {
        if ( isalive( wither ) )
        {
            wither function_7f8988ce63c1623d( 0 );
            wither utility::delaycallendon( 3, "death", &function_7f8988ce63c1623d, 1 );
        }
    }
    
    wait var_f07ec2e26d68259f;
    
    if ( isalive( self ) )
    {
        while ( !self isonground() )
        {
            waitframe();
        }
    }
    
    foreach ( wither in weyward.var_bfec04d50947b318 )
    {
        if ( isalive( wither ) )
        {
            wither function_7f8988ce63c1623d( 1 );
        }
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x3c6121a5, Offset: 0x1d4f
// Size: 0x70
function private function_ce7b72da190a0e99()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    start_time = gettime();
    utility::wait_time_in_ms( 300 );
    
    while ( !self isonground() && !utility::time_has_passed( start_time, 3 ) )
    {
        waitframe();
    }
    
    utility::ent_flag_clear( "weyward_charged" );
    self.var_940d7b16bf043325 = undefined;
    self.charge_knockback_landing_spot = undefined;
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xfedd4a07, Offset: 0x1dc7
// Size: 0x12b
function private function_a407b87e904f860a()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_9e18389f00c01822" );
        utility::ent_flag_set( "in_charge" );
        childthread function_21104ce34c871a3a();
        self.charge_attack_target = undefined;
        self.var_4d4dba5080e52e89 = 1;
        utility::function_7c10ea82c1e305b8( "charge_attack", "charge_intro" );
        
        if ( namespace_aa44c48b952946c7::is_in_charge_state() )
        {
            childthread function_829ac1f8b822b821();
            childthread set_charge_loop_playback_rate();
            childthread handle_charge_loop();
            self waittill( #"hash_3355b01f5562b777" );
            asm::function_d82cb83c9c260d49( 1 );
            utility::function_7c10ea82c1e305b8( "charge_attack", "off" );
            self function_f2df0257c63f229( "charge_result" );
            function_f720008f12cb85d3();
        }
        
        utility::ent_flag_clear( "in_charge" );
        
        if ( self.var_a2638d3c0a211262 )
        {
            self.var_3cb89955446d1ea4 = gettime();
            
            if ( !self getaiblackboarddynamic( "no_enemies_detected" ) )
            {
                self.last_charge_time = gettime();
            }
        }
        else
        {
            self.last_charge_time = gettime();
        }
        
        self.var_a2638d3c0a211262 = 0;
        self.var_ee97cb0dc3d17280 = undefined;
        self.var_fb16c56412d6a406 = 0;
        childthread function_eef8df54bc52760b();
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x1fc78d0f, Offset: 0x1efa
// Size: 0x194
function private function_21104ce34c871a3a()
{
    var_535b06baa867e27f = 200;
    self endon( #"death" );
    self endon( #"hash_3355b01f5562b777" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( !player.placedsentries || !player.placedsentries[ "remote_turret" ] )
            {
                continue;
            }
            
            foreach ( turret in player.placedsentries[ "remote_turret" ] )
            {
                if ( turret && turret utility::ent_flag( "remote_sentry_deployed" ) && distance2dsquared( self.origin, turret.origin ) <= squared( var_535b06baa867e27f ) )
                {
                    turret notify( #"kill_turret", 1, 1, 0 );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x34ff3e36, Offset: 0x2096
// Size: 0x3b
function private function_f2a7226e20a92912()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"charge_outro_end" );
        
        if ( zombie_weyward_dash::function_43a5a5d8f21362b8( 1 ) )
        {
            self function_786bb6aa1b76c7ee( "charge_into_dash_combo", 1 );
        }
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x39f4b077, Offset: 0x20d9
// Size: 0x98
function private set_charge_loop_playback_rate()
{
    self endon( #"death" );
    self endon( #"hash_3355b01f5562b777" );
    
    while ( true )
    {
        utility::waittill_any_in_array( [ "bchargeintroend", "bchargeturnend" ] );
        base_rate = self.var_6c9f65132aac2523[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
        var_d353ba6baac2d084 = zombie_weyward_skull::function_4a4306933ef021b1() >= 1;
        asm::function_d82cb83c9c260d49( base_rate + ( var_d353ba6baac2d084 ? self.var_8c99b8d704afedc4 : 0 ) );
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x68063ac3, Offset: 0x2179
// Size: 0x7e
function private function_eef8df54bc52760b()
{
    self endon( #"death" );
    self endon( #"hash_9e18389f00c01822" );
    slow_amount = getdvarfloat( @"hash_1ed72f61a4327d2b", self.var_19f348f7ac0b1319 );
    duration = getdvarfloat( @"hash_5f29e925d075022d", self.var_b6bd8706405788af );
    self.var_4d4dba5080e52e89 = 1 - slow_amount;
    wait duration;
    self.var_4d4dba5080e52e89 = 1;
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xd7bd9abb, Offset: 0x21ff
// Size: 0xbe
function private handle_charge_loop()
{
    self endon( #"hash_3355b01f5562b777" );
    
    while ( true )
    {
        self waittill( #"hash_5f675b10f3291ff9" );
        thread function_b4b527af32b2cf2();
        var_d353ba6baac2d084 = zombie_weyward_skull::function_4a4306933ef021b1() >= 1;
        
        if ( var_d353ba6baac2d084 )
        {
            zombie_weyward_skull::function_9ca1d6c21ef9f3ac();
        }
        
        utility::function_7c10ea82c1e305b8( "charge_attack", var_d353ba6baac2d084 ? "charge_loop_empowered" : "charge_loop" );
        childthread charge_damage_loop();
        self waittill( #"hash_836efc1107f5d88c" );
        var_44c2d91a03909fa = namespace_aa44c48b952946c7::is_charge_result_stop();
        asm::function_d82cb83c9c260d49( 1 );
        utility::function_7c10ea82c1e305b8( "charge_attack", "off" );
        self function_f2df0257c63f229( "charge_result" );
        
        if ( var_44c2d91a03909fa )
        {
            childthread function_290f8fe5d9e23d6d();
        }
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x11fa51ce, Offset: 0x22c5
// Size: 0x1bb
function private function_b4b527af32b2cf2()
{
    if ( !function_5cc81d72313a23cc() )
    {
        return;
    }
    
    charge_dir = anglestoforward( self.angles );
    trace_dist = getdvarfloat( @"hash_a99c861b3858d66d", 5000 );
    trace_end = self.origin + charge_dir * trace_dist;
    nav_trace = navtrace( self.origin, trace_end, self, 1 );
    
    if ( nav_trace[ "fraction" ] < 1 )
    {
        var_8f62a5b18cb68fc = nav_trace[ "fraction" ];
        turret = function_5326e4ebce049f0a( nav_trace );
        
        if ( turret )
        {
            waitframe();
            nav_trace = navtrace( self.origin, trace_end, self, 1 );
            
            if ( nav_trace[ "fraction" ] == var_8f62a5b18cb68fc )
            {
                level function_eb5a6269cae85c7f( turret );
            }
            else
            {
                thread function_a85c799bd443aa30( turret );
            }
        }
    }
    
    end = nav_trace[ "position" ];
    var_7f34180df115288 = length( self getboundshalfsize() ) * 3;
    zombie_weyward_summon_stinger::function_7522313fe70458eb( self.origin, end, var_7f34180df115288 );
    
    foreach ( player in level.players )
    {
        if ( !player.bgb_hellping_hound || !isalive( player.bgb_hellping_hound ) )
        {
            continue;
        }
        
        thread function_1465d33cb636e023( player );
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0x8e9309bd, Offset: 0x2488
// Size: 0xd8
function private function_829ac1f8b822b821()
{
    self endon( #"death" );
    self endon( #"hash_3355b01f5562b777" );
    
    while ( true )
    {
        self waittill( #"hash_7bcd2232fbd660bc" );
        
        if ( !function_5cc81d72313a23cc() )
        {
            continue;
        }
        
        var_5e54b9b7ec23c037 = self.turnrate;
        self.turnrate = getdvarfloat( @"hash_9cc7ec685141d653", 0.45 );
        
        /#
            if ( debug_charge() )
            {
                childthread function_790f9c14bce37b0f();
            }
        #/
        
        childthread function_270f31fdd11012b4();
        msg = utility::waittill_any_in_array_or_timeout( [ "charge_turn_orient_end", "charge_turn_orient_internal_stop" ], 5 );
        
        if ( msg == "timeout" )
        {
            self notify( #"charge_turn_orient_internal_stop" );
        }
        
        self.var_ebd26f6520cc1e89 = 1;
        self.turnrate = var_5e54b9b7ec23c037;
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xe6804417, Offset: 0x2568
// Size: 0x1dd
function private function_270f31fdd11012b4()
{
    var_7acfef96a6b0d02d = 0.98;
    var_360dae559ba59d5a = 89;
    var_d15178104b99a558 = 91;
    self endon( #"death" );
    self endon( #"hash_3355b01f5562b777" );
    self endon( #"charge_turn_orient_end" );
    self endon( #"charge_turn_orient_internal_stop" );
    
    /#
        if ( debug_charge() )
        {
            iprintlnbold( "<dev string:x4d>" + self.charge_turn_direction + "<dev string:x72>" + self.angles[ 1 ] );
        }
    #/
    
    while ( function_5cc81d72313a23cc() )
    {
        predicted_target_pos = function_2b90aadcd2f606c5();
        to_target_dir = vectornormalize( predicted_target_pos - self.origin );
        forward_dir = anglestoforward( self.angles );
        var_c8fb2d52a91e4cdb = vectordot( forward_dir, to_target_dir );
        world_target_yaw = vectortoyaw( predicted_target_pos - self.origin );
        local_target_yaw = angleclamp180( world_target_yaw - self.angles[ 1 ] );
        
        switch ( self.charge_turn_direction )
        {
            case #"hash_96815ce4f2a3dbc5":
                if ( local_target_yaw > 0 )
                {
                    local_target_yaw = var_360dae559ba59d5a * -1;
                }
                
                break;
            case #"hash_c9b3133a17a3b2d0":
                if ( local_target_yaw < 0 )
                {
                    local_target_yaw = var_d15178104b99a558;
                }
                
                break;
        }
        
        target_yaw = self.angles[ 1 ] + local_target_yaw;
        
        /#
            if ( debug_charge() )
            {
                iprintlnbold( "<dev string:x78>" + target_yaw + "<dev string:x8f>" + local_target_yaw + "<dev string:x97>" + self.angles[ 1 ] + "<dev string:xa1>" + var_c8fb2d52a91e4cdb );
            }
        #/
        
        if ( var_c8fb2d52a91e4cdb < var_7acfef96a6b0d02d )
        {
            self orientmode( "face angle", target_yaw );
        }
        else
        {
            break;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_charge
// Params 0, eflags: 0x4
// Checksum 0xb5e4f03, Offset: 0x274d
// Size: 0x14b
function private function_2b90aadcd2f606c5()
{
    var_fa94fd4f74e60fb2 = squared( 2200 );
    
    if ( self.var_a2638d3c0a211262 )
    {
        return self.var_ee97cb0dc3d17280;
    }
    
    target = self.charge_target;
    
    if ( target.var_940d7b16bf043325 )
    {
        live_landing_spot = namespace_aa44c48b952946c7::function_633564ba53089520( target, target.origin, target getvelocity() );
        
        if ( live_landing_spot )
        {
            target.charge_knockback_landing_spot = live_landing_spot;
            return live_landing_spot;
        }
        
        if ( target.charge_knockback_landing_spot )
        {
            return target.charge_knockback_landing_spot;
        }
    }
    
    distance_to_target_sq = distancesquared( self.origin, target.origin );
    prediction_time_min = getdvarfloat( @"hash_e99bbcb7be808ccd", 0.5 );
    prediction_time_max = getdvarfloat( @"hash_e977a6b7be57e1b3", 1 );
    
    if ( distance_to_target_sq >= squared( 1350 ) )
    {
        prediction_time_min = 0.35;
        prediction_time_max = 0.8;
    }
    
    prediction_time = math::remap( distance_to_target_sq, 0, var_fa94fd4f74e60fb2, prediction_time_min, prediction_time_max );
    var_df9adb69b75ff5f3 = target getvelocity();
    return target.origin + var_df9adb69b75ff5f3 * prediction_time;
}

/#

    // Namespace zombie_weyward_charge
    // Params 0, eflags: 0x4
    // Checksum 0xb12c5a55, Offset: 0x28a1
    // Size: 0x11d, Type: dev
    function private function_790f9c14bce37b0f()
    {
        var_d2e7d0ee37ebe02c = 90;
        self endon( #"death" );
        self endon( #"hash_3355b01f5562b777" );
        self endon( #"charge_turn_orient_end" );
        
        while ( true )
        {
            if ( !function_5cc81d72313a23cc() )
            {
                return;
            }
            
            predicted_target_pos = function_2b90aadcd2f606c5();
            forward_end_pos = self.origin + anglestoforward( self.angles ) * var_d2e7d0ee37ebe02c;
            line( self.origin, forward_end_pos, ( 0.2, 0.8, 1 ) );
            sphere( forward_end_pos, 12, ( 0.2, 0.8, 1 ) );
            namespace_aa44c48b952946c7::charge_print( "<dev string:xa7>", forward_end_pos + ( 0, 0, 18 ) );
            line( self.origin, predicted_target_pos, ( 1, 0.6, 0 ) );
            sphere( predicted_target_pos, 18, ( 1, 0.6, 0 ) );
            namespace_aa44c48b952946c7::charge_print( "<dev string:xbb>", predicted_target_pos + ( 0, 0, 24 ) );
            waitframe();
        }
    }

    // Namespace zombie_weyward_charge
    // Params 0, eflags: 0x4
    // Checksum 0x23b93586, Offset: 0x29c6
    // Size: 0x9c, Type: dev
    function private function_bcf51ac97a871369()
    {
        devgui::function_9082edeb5db93280( "<dev string:xce>" );
        devgui::add_devgui_func( "<dev string:xee>", "<dev string:xfb>", &force_charge );
        devgui::function_cd4e263c1f3018ae( "<dev string:x110>", "<dev string:x125>", &function_5d6ebd8438e2768c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x142>", "<dev string:x157>", &function_5d6ebd8438e2768c );
        devgui::function_cd4e263c1f3018ae( "<dev string:x174>", "<dev string:x189>", &function_5d6ebd8438e2768c );
        devgui::add_devgui_func( "<dev string:x1a6>", "<dev string:x1b3>", &function_4634fbb4d55e30eb );
        devgui::add_devgui_func( "<dev string:x1cf>", "<dev string:x1e4>", &function_1f2849a10968582f );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_charge
    // Params 0, eflags: 0x4
    // Checksum 0xee5b83b0, Offset: 0x2a6a
    // Size: 0x1c2, Type: dev
    function private function_1e32956e9bac8815()
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( function_580b629f2e34a7d2() && self.var_c7a3c3c3948d55f9 && self.var_62aa1e12007f1437 )
            {
                center = self.var_c7a3c3c3948d55f9;
                half_extents = self.var_62aa1e12007f1437;
                min = center - half_extents;
                max = center + half_extents;
                bottom_front_left = ( min[ 0 ], max[ 1 ], min[ 2 ] );
                bottom_front_right = ( max[ 0 ], max[ 1 ], min[ 2 ] );
                bottom_back_right = ( max[ 0 ], min[ 1 ], min[ 2 ] );
                bottom_back_left = ( min[ 0 ], min[ 1 ], min[ 2 ] );
                top_front_left = ( min[ 0 ], max[ 1 ], max[ 2 ] );
                top_front_right = ( max[ 0 ], max[ 1 ], max[ 2 ] );
                top_back_right = ( max[ 0 ], min[ 1 ], max[ 2 ] );
                top_back_left = ( min[ 0 ], min[ 1 ], max[ 2 ] );
                color = ( 1, 0, 0 );
                line( bottom_front_left, bottom_front_right, color );
                line( bottom_front_right, bottom_back_right, color );
                line( bottom_back_right, bottom_back_left, color );
                line( bottom_back_left, bottom_front_left, color );
                line( top_front_left, top_front_right, color );
                line( top_front_right, top_back_right, color );
                line( top_back_right, top_back_left, color );
                line( top_back_left, top_front_left, color );
                line( bottom_front_left, top_front_left, color );
                line( bottom_front_right, top_front_right, color );
                line( bottom_back_right, top_back_right, color );
                line( bottom_back_left, top_back_left, color );
            }
            
            wait 1;
        }
    }

    // Namespace zombie_weyward_charge
    // Params 1, eflags: 0x4
    // Checksum 0xa2931f34, Offset: 0x2c34
    // Size: 0x24, Type: dev
    function private function_1f2849a10968582f( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x208>", @"hash_7f2c5f43798344d4" );
    }

    // Namespace zombie_weyward_charge
    // Params 0, eflags: 0x4
    // Checksum 0x53fcfbf1, Offset: 0x2c60
    // Size: 0x16, Type: dev
    function private function_580b629f2e34a7d2()
    {
        return getdvarint( @"hash_7f2c5f43798344d4", 0 ) > 0;
    }

    // Namespace zombie_weyward_charge
    // Params 1, eflags: 0x4
    // Checksum 0x980300b5, Offset: 0x2c7e
    // Size: 0x16, Type: dev
    function private force_charge( params )
    {
        function_359abaad02228fce();
    }

    // Namespace zombie_weyward_charge
    // Params 1, eflags: 0x4
    // Checksum 0xbe77da95, Offset: 0x2c9c
    // Size: 0x25, Type: dev
    function private function_5d6ebd8438e2768c( params )
    {
        if ( !params[ 0 ] )
        {
            return;
        }
        
        function_359abaad02228fce( int( params[ 0 ] ) );
    }

    // Namespace zombie_weyward_charge
    // Params 1, eflags: 0x4
    // Checksum 0xd35f0f0d, Offset: 0x2cc9
    // Size: 0x111, Type: dev
    function private function_359abaad02228fce( var_fe2cdd14e156b484 )
    {
        player = level.players[ 0 ];
        
        if ( !isalive( player ) )
        {
            return;
        }
        
        weyward = zombie_utils::get_closest_zombie( player.origin, undefined, "<dev string:x225>" );
        
        if ( weyward )
        {
            nav_trace = navtrace( weyward.origin, player.origin, weyward, 1 );
            
            if ( nav_trace[ "<dev string:x234>" ] < 0.95 )
            {
                turret = weyward function_5326e4ebce049f0a( nav_trace, 1 );
                
                if ( turret )
                {
                    return;
                }
            }
            
            if ( var_fe2cdd14e156b484 )
            {
                var_bffc5d5401c9715e = weyward.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1abc9e021a4e87b2 ?? 2;
                weyward function_cdcfdfc73ca5701d( var_fe2cdd14e156b484 );
                weyward thread function_66af2ca29fd11f38( var_bffc5d5401c9715e );
            }
            
            weyward.charge_attack_target = player;
            weyward function_a5b7553299c99ae2();
            weyward start_charge();
        }
    }

    // Namespace zombie_weyward_charge
    // Params 1, eflags: 0x4
    // Checksum 0x8d6cd115, Offset: 0x2de2
    // Size: 0x31, Type: dev
    function private function_66af2ca29fd11f38( var_bffc5d5401c9715e )
    {
        self endon( #"death" );
        self waittill( #"hash_3355b01f5562b777" );
        function_cdcfdfc73ca5701d( var_bffc5d5401c9715e );
    }

    // Namespace zombie_weyward_charge
    // Params 1, eflags: 0x4
    // Checksum 0x4a423126, Offset: 0x2e1b
    // Size: 0x24, Type: dev
    function private function_4634fbb4d55e30eb( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x23d>", @"hash_34bb01539c3a8b10" );
    }

    // Namespace zombie_weyward_charge
    // Params 0, eflags: 0x4
    // Checksum 0xc0174d31, Offset: 0x2e47
    // Size: 0x16, Type: dev
    function private debug_charge()
    {
        return getdvarint( @"hash_34bb01539c3a8b10", 0 ) > 0;
    }

#/
