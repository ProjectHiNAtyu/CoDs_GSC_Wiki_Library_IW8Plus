// script_4cc8a0ecc1f50901  (hash_4cc8a0ecc1f50901.gscc) (size: 17468 Bytes / 0x443c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x956841e2 (2506637794)
// size ...... 17468 (0x443c)
// includes .. 15  (offset: 0x40ec)
// strings ... 33  (offset: 0x4164)
// dev strs .. 14  (offset: 0x4390)
// exports ... 34  (offset: 0x2a58)
// cseg ...... 0x224 + 0x2834 (0x2a58)
// imports ... 134 (offset: 0x2fa8)
// animtree1 . 0   (offset: 0x443c)
// animtree2 . 0   (offset: 0x443c)
#using script_1243911b5893214a;
#using script_14f857806c1ea0cc;
#using script_16ea1b94f0f381b3;
#using script_22800c62e91a8956;
#using script_6a71daf1a601e6f5;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\status_effects\effect_wound;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;

#namespace zombie_weyward_melee;

/#

    // Namespace zombie_weyward_melee
    // Params 0
    // Checksum 0xa2e81d7c, Offset: 0x242
    // Size: 0xc, Type: dev
    function function_c0467b6eefab8cac()
    {
        function_5846cffc47a3c2b1();
    }

#/

// Namespace zombie_weyward_melee
// Params 0
// Checksum 0xed0ed58, Offset: 0x256
// Size: 0xbe
function cancel_melee()
{
    if ( !self || !isalive( self ) )
    {
        return;
    }
    
    var_5da7245bb3f09cd = self.var_4864b6d03c1561ae || self.var_134f3cd53162e193;
    self.var_134f3cd53162e193 = 0;
    self.var_4864b6d03c1561ae = 0;
    
    if ( var_5da7245bb3f09cd )
    {
        if ( namespace_cf4ab51195a21b92::function_9dddd89ce61e2f9e() )
        {
            thread namespace_cf4ab51195a21b92::function_3d02256c7ca08940();
            return;
        }
        
        thread function_8cc125a75f0018de();
        return;
    }
    
    if ( asm::asm_getcurrentstatename( self.asmname ) == "melee" )
    {
        asm::asm_fireevent( self.asmname, "finish" );
        thread function_8cc125a75f0018de();
        return;
    }
    
    if ( !utility::ent_flag( "in_melee" ) )
    {
        return;
    }
    
    thread namespace_cf4ab51195a21b92::function_3d02256c7ca08940();
    self notify( #"bmeleeended" );
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0xe0f8c496, Offset: 0x31c
// Size: 0x38
function private function_8cc125a75f0018de()
{
    self endon( #"death" );
    self endon( #"hash_9f6d1fd5ff565730" );
    self endon( #"bmeleeended" );
    wait 0.05;
    self notify( #"bmeleeended" );
}

// Namespace zombie_weyward_melee
// Params 1
// Checksum 0x815c76f6, Offset: 0x35c
// Size: 0x44
function function_6546aa1a41debe5d( target )
{
    self._blackboard.meleerequestedtarget = target;
    self.var_134f3cd53162e193 = 1;
    self.var_4864b6d03c1561ae = 1;
    self notify( #"hash_9f6d1fd5ff565730" );
}

// Namespace zombie_weyward_melee
// Params 0
// Checksum 0x87b63e63, Offset: 0x3a8
// Size: 0x402
function init_zombie_weyward_melee()
{
    zombie_melee::init_zombie_melee();
    zombie_melee_asm::function_d5c5dea62200a953( &function_817da043deac86e5, &function_780e0f4dc5685cf1 );
    self.var_134f3cd53162e193 = 0;
    self.var_4864b6d03c1561ae = 0;
    self.var_d4a397a6f6cddafa = &function_d4a397a6f6cddafa;
    thread function_5db0b76b4fe4a1e2();
    thread namespace_cf4ab51195a21b92::function_c3b15f481cd323a2();
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.stinger_swipe_yaw = settings.var_cd16a488c414a101 ?? 135;
    self.melee_yaw = settings.meleeyaw ?? 75;
    self.melee_trigger_dist = settings.var_60043d6e8b16952e ?? 250;
    self.var_475c5b4df366ea5a = settings.var_c05b6a018b82e353 ?? 300;
    self.var_a305521e7e004435 = settings.var_3576040cebf866fa ?? 50;
    self.var_a3283c1e7e265b8b = settings.var_3599ee0cec20b150 ?? 300;
    self.var_3f0810cdb0e34ad0 = settings.var_f467bfe79eb665dd ?? 70;
    self.var_de85947f362f2b53 = settings.var_742d79861442ab7 ?? -50;
    self.var_284aa7d2bb148cc9 = settings.var_fdeab613d8893ae5 ?? -100;
    self.var_c38d944ff7238246 = settings.var_4c628a5b8161049e ?? 30;
    self.var_2fd79266eae38cff = settings.var_43094cab58c0a23b ?? 60;
    self.melee_yaw_limit = settings.var_89fc49451f25576c ?? 60;
    self.var_e327b93e85af24d4 = settings.var_b74c87e61949d496 ?? 80;
    self.var_546839a856fbe33 = settings.var_b2ceac0c54f2356b ?? 75;
    self.var_9e1d198f65ea9898 = settings.var_50d45afa65520ccc ?? 120;
    self.var_cd34501b9b0e03c0 = settings.var_13748cc3997d74f5 ?? 40;
    self.var_c075c17e61e89d11 = settings.var_c29e36510439b129 ?? 900;
    self.melee_knockback_val = getdvarfloat( @"hash_56a6bc97f539fbe8", settings.meleeknockback ?? 700 );
    self.var_eab9066091746d47 = settings.var_885d55d2e6024e69 ?? 30;
    self.melee_enabled = settings.meleeenabled ?? 1;
    self.var_4f2833046281a2d9 = settings.var_e09c7ff9b43e0c43 ?? 1;
    self.var_49e395d9f821d573 = settings.var_39152975e3f19b53 ?? 1.1;
    self.var_ae22e5523001949d = settings.var_dd436ba3b9143d01 ?? 1;
    self.wound_damage = settings.wounddamage ?? 10;
    self.wound_damage_tick = settings.var_9ba66c4bd3c676b1 ?? 1;
    self.wound_duration = settings.woundduration ?? 5;
    self.wound_max_duration = settings.var_5164dd88e96d2b7d ?? 20;
    self.wound_duration_increase = settings.var_665d6700a6efc4c1 ?? 2;
    self.var_19d23b587480f619 = settings.var_35c67171e96fa06d ?? 5;
    self.wound_grace_period = settings.woundgraceperiod ?? 5;
    self.var_e7e36bca52b6602f = settings.var_6be3c5a4cf98c430 ?? undefined;
    self.tail_swipe_aoe_scriptable = settings.var_45f762aebce39b2d;
    self.tail_swipe_aoe_damage = settings.var_e8ef78e96202f178 ?? 75;
    self.var_ee4c1a018b366df1 = settings.var_7b22009bf6322c54 ?? 80;
    self.var_b93b02e9436e7e05 = settings.var_30b281608e07b391 ?? 40;
    self.var_30335b93e26d53ed = 0;
    self.var_210b5649338b900b = [];
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0xaaaa14d3, Offset: 0x7b2
// Size: 0xb, Type: bool
function private is_attack_empowered()
{
    return zombie_weyward_skull::function_4a4306933ef021b1() >= 1;
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0x41be7bc2, Offset: 0x7c6
// Size: 0xb
function private function_817da043deac86e5()
{
    return self.var_134f3cd53162e193;
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0xa19d923e, Offset: 0x7da
// Size: 0x33
function private function_780e0f4dc5685cf1()
{
    self.var_134f3cd53162e193 = 0;
    
    if ( zombie_stun::is_stunned() )
    {
        thread utility::delay_notify( 0.05, "bmeleeended", "death" );
        return;
    }
    
    namespace_cf4ab51195a21b92::function_2ebcc6123b939f5();
}

// Namespace zombie_weyward_melee
// Params 2
// Checksum 0x41434e7b, Offset: 0x815
// Size: 0x170
function function_3961147a8f0eb045( taskid, params )
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
    
    if ( asm::asm_getcurrentstatename( self.asmname ) == "melee" )
    {
        return anim.running;
    }
    
    if ( namespace_cf4ab51195a21b92::function_9dddd89ce61e2f9e() )
    {
        return anim.running;
    }
    
    if ( !getdvarint( @"hash_771be64f7ec51756", self.melee_enabled ) )
    {
        return anim.failure;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        return anim.failure;
    }
    
    targets = self function_f017e352a29a57a1( self.origin, 2000, 1 );
    
    foreach ( target in targets )
    {
        if ( function_57e187248ca7b774( target ) )
        {
            return anim.success;
        }
    }
    
    return anim.failure;
}

// Namespace zombie_weyward_melee
// Params 1
// Checksum 0x689302b9, Offset: 0x98e
// Size: 0x160
function function_649a2398227bfc1( target )
{
    target_pos = target.origin;
    max_trigger_dist = getdvarfloat( @"hash_57c7451780d7edc", self.melee_trigger_dist );
    
    if ( is_attack_empowered() )
    {
        max_trigger_dist *= 1.2;
    }
    
    var_df9adb69b75ff5f3 = target getvelocity();
    var_65d1ff2692ab8da9 = vectordot2( vectornormalize2( self.origin - target_pos ), var_df9adb69b75ff5f3, 0 );
    
    if ( var_65d1ff2692ab8da9 > 0 )
    {
        range_boost = getdvarfloat( @"hash_2d5982e14fc4fca0", self.var_475c5b4df366ea5a );
        max_trigger_dist += clamp( math::remap( var_65d1ff2692ab8da9, getdvarfloat( @"hash_d5e673aa7331c14f", self.var_a305521e7e004435 ), getdvarfloat( @"hash_d5c361aa730b5201", self.var_a3283c1e7e265b8b ), 0, range_boost ), 0, range_boost );
    }
    else if ( var_65d1ff2692ab8da9 < 0 )
    {
        range_penalty = getdvarfloat( @"hash_74283e9ada4b7cd2", self.var_3f0810cdb0e34ad0 );
        max_trigger_dist -= clamp( math::remap( var_65d1ff2692ab8da9, getdvarfloat( @"hash_9b18c96207b0ba45", self.var_de85947f362f2b53 ), getdvarfloat( @"hash_ee245f51f6a08777", self.var_284aa7d2bb148cc9 ), 0, range_penalty ), 0, range_penalty );
    }
    
    return max_trigger_dist;
}

// Namespace zombie_weyward_melee
// Params 1, eflags: 0x4
// Checksum 0xd2dcb40a, Offset: 0xaf7
// Size: 0x217, Type: bool
function private function_57e187248ca7b774( target )
{
    if ( zombie_stun::is_stunned() )
    {
        return false;
    }
    
    if ( self getaiblackboarddynamic( "in_turning" ) == 1 )
    {
        return true;
    }
    
    if ( self getaiblackboarddynamic( "in_exit" ) == 1 )
    {
        return true;
    }
    
    target_pos = target.origin;
    to_yaw = utility::getyawtospot( target_pos );
    
    /#
        if ( debug_melee() )
        {
            print3d( target_pos + ( 0, 0, 130 ), "<dev string:x24>" + to_yaw, ( 1, 0.2, 0 ) );
        }
    #/
    
    stinger_swipe_yaw = getdvarfloat( @"hash_bc18d6b2ea79b91f", self.stinger_swipe_yaw );
    
    if ( abs( to_yaw ) > getdvarfloat( @"hash_469e1b1047edec50", self.melee_yaw ) && to_yaw > stinger_swipe_yaw * -1 && to_yaw < stinger_swipe_yaw )
    {
        return false;
    }
    
    dist = distance( target_pos, self.origin );
    
    /#
        if ( debug_melee() )
        {
            print3d( target_pos + ( 0, 0, 100 ), "<dev string:x38>" + dist, ( 1, 0.2, 0 ) );
        }
    #/
    
    var_df9adb69b75ff5f3 = target getvelocity();
    var_65d1ff2692ab8da9 = vectordot2( vectornormalize2( self.origin - target_pos ), var_df9adb69b75ff5f3, 0 );
    max_trigger_dist = function_649a2398227bfc1( target );
    
    /#
        if ( debug_melee() )
        {
            print3d( target_pos + ( 0, 0, 200 ), "<dev string:x4d>" + var_65d1ff2692ab8da9 + "<dev string:x60>" + max_trigger_dist );
        }
    #/
    
    if ( dist < max_trigger_dist )
    {
        /#
            if ( debug_melee() )
            {
                print3d( target_pos, "<dev string:x79>" + to_yaw );
            }
        #/
        
        self._blackboard.meleerequestedtarget = target;
        namespace_b76e7e4c1d057ec1::function_cede8b4d4a5ae444( self._blackboard.meleerequestedtarget );
        self notify( #"hash_9f6d1fd5ff565730" );
        return true;
    }
    
    return false;
}

// Namespace zombie_weyward_melee
// Params 2
// Checksum 0x5224db92, Offset: 0xd17
// Size: 0x1c
function function_d4a397a6f6cddafa( msg, var_efc8748fdbf5d5f8 )
{
    thread function_a33d2fc313459239();
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0xeca40d18, Offset: 0xd3b
// Size: 0x14a
function private function_a33d2fc313459239()
{
    self endon( #"bmeleeended" );
    self endon( #"death" );
    self endon( #"hit_end" );
    thread utility::thread_on_notify( "hit_end", &on_hit_end, self, self, [ "bmeleeended" ], self );
    var_d353ba6baac2d084 = is_attack_empowered();
    
    if ( var_d353ba6baac2d084 )
    {
        zombie_weyward_skull::function_9ca1d6c21ef9f3ac();
    }
    
    if ( namespace_cf4ab51195a21b92::function_9dddd89ce61e2f9e() )
    {
        utility::function_7c10ea82c1e305b8( "tail_swipe", var_d353ba6baac2d084 ? "empowered" : "base" );
        
        if ( var_d353ba6baac2d084 && !self.var_30335b93e26d53ed )
        {
            self.var_30335b93e26d53ed = 1;
            thread tail_swipe_aoe_wave();
        }
        
        self.var_518db9fe31f5bf3d = undefined;
        
        while ( true )
        {
            function_49ece4a9a77aca11( self );
            waitframe();
        }
    }
    
    thread utility::thread_on_notify( "hit_end", &function_941200dbe1fd1445, self, self, [ "bmeleeended" ], self, 1.7 );
    
    if ( self.is_moving_melee )
    {
        var_ed6147e45fbfa983 = var_d353ba6baac2d084 ? "moving_empowered" : "base_moving";
    }
    else
    {
        var_ed6147e45fbfa983 = var_d353ba6baac2d084 ? "static_empowered" : "base_static";
    }
    
    utility::function_7c10ea82c1e305b8( "claw_attack", var_ed6147e45fbfa983 );
    
    while ( true )
    {
        function_941200dbe1fd1445( self );
        waitframe();
    }
}

// Namespace zombie_weyward_melee
// Params 2, eflags: 0x4
// Checksum 0x7069df14, Offset: 0xe8d
// Size: 0x412
function private function_941200dbe1fd1445( weyward, melee_range_multiplier = 1 )
{
    assert( isdefined( self.melee_range ) && isdefined( self.var_6c41e8e873b7594e ) );
    var_6c41e8e873b7594e = self.var_6c41e8e873b7594e;
    
    if ( self._blackboard.var_606bf8ea1f70975d > 0 )
    {
        var_6c41e8e873b7594e *= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_40372f826703a5e;
    }
    
    var_d353ba6baac2d084 = is_attack_empowered();
    
    if ( var_d353ba6baac2d084 )
    {
        var_6c41e8e873b7594e *= weyward.var_4f2833046281a2d9;
    }
    
    var_c57f35c41a9ab7ee = self.is_moving_melee ? "j_wrist_ri" : "j_wrist_le";
    var_b72e0dcdd6ad7910 = weyward gettagorigin( var_c57f35c41a9ab7ee, 0, 0, 0 );
    
    if ( var_b72e0dcdd6ad7910 )
    {
        weyward function_6510106c4d7b2934( var_b72e0dcdd6ad7910, weyward.melee_range * melee_range_multiplier );
    }
    
    var_840926d75db91652 = function_305f5a4d542ab84b( self, var_b72e0dcdd6ad7910, var_c57f35c41a9ab7ee, melee_range_multiplier );
    
    foreach ( var_90ec0886f9ccf215 in var_840926d75db91652 )
    {
        if ( var_90ec0886f9ccf215 utility::ent_flag( "weyward_meleed" ) )
        {
            continue;
        }
        
        var_90ec0886f9ccf215 utility::ent_flag_set( "weyward_meleed" );
        var_90ec0886f9ccf215 thread utility::ent_flag_clear_delayed( "weyward_meleed", 1.6 );
        self.var_e93cc47a6f947ce5 = gettime();
        
        if ( isplayer( var_90ec0886f9ccf215 ) )
        {
            var_90ec0886f9ccf215 dodamage( var_6c41e8e873b7594e, self.origin, self, self, "MOD_MELEE" );
            var_90ec0886f9ccf215 function_64f1800c957cf63c();
            knockback_player( self, var_90ec0886f9ccf215 );
            weyward utility::ent_flag_set( "weyward_melee_hit_successful" );
            
            if ( weyward.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.melee_shock )
            {
                var_90ec0886f9ccf215 namespace_9d8e359c3b1041e5::shellshocksharedfunc( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.melee_shock, #"damage", 1 );
            }
            
            if ( var_d353ba6baac2d084 && isalive( var_90ec0886f9ccf215 ) )
            {
                has_quick_revive = var_90ec0886f9ccf215 zombie_perks::has_perk( "specialty_quickrevive" );
                wound_duration = has_quick_revive ? weyward.var_19d23b587480f619 : weyward.wound_duration;
                var_8957328ce60a91b = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ae98793dbab43ddd;
                
                if ( var_8957328ce60a91b && level.players.size > 1 )
                {
                    wound_duration += wound_duration * ( level.players.size - 1 ) * var_8957328ce60a91b;
                }
                
                var_90ec0886f9ccf215 effect_wound::wound( wound_duration, weyward.wound_max_duration, weyward.wound_duration_increase, weyward.wound_grace_period, weyward.wound_damage, weyward.wound_damage_tick, weyward, weyward, weyward.var_e7e36bca52b6602f );
            }
            
            continue;
        }
        
        if ( isai( var_90ec0886f9ccf215 ) )
        {
            if ( var_90ec0886f9ccf215.skull_owner != self )
            {
                if ( var_90ec0886f9ccf215.team === self.team && var_90ec0886f9ccf215.aicategory === "normal" )
                {
                    var_90ec0886f9ccf215 zombie_knockdown::function_6fc167d4a3590991( var_b72e0dcdd6ad7910, getdvarfloat( @"hash_3956540bbdb02031", 500 ), getdvarfloat( @"hash_9a0aaa061030244f", 45 ) );
                    weyward utility::ent_flag_set( "weyward_melee_hit_successful" );
                    continue;
                }
                
                var_90ec0886f9ccf215 dodamage( var_6c41e8e873b7594e * self.var_42ddbc8ee376c279, self.origin, self, self, "MOD_MELEE" );
            }
        }
    }
    
    if ( weyward utility::ent_flag( "weyward_melee_hit_successful" ) )
    {
        weyward utility::function_7c10ea82c1e305b8( "bite", "hit" );
    }
}

// Namespace zombie_weyward_melee
// Params 4, eflags: 0x4
// Checksum 0x5d3baf05, Offset: 0x12a7
// Size: 0x422
function private function_305f5a4d542ab84b( weyward, var_b72e0dcdd6ad7910, var_c57f35c41a9ab7ee, melee_range_multiplier = 1 )
{
    targets = [];
    cone_up = ( 0, 0, 1 );
    claw_angles = weyward gettagangles( var_c57f35c41a9ab7ee );
    cone_pitch = claw_angles[ 0 ] + getdvarfloat( @"hash_4f18306d75d23208", weyward.var_c38d944ff7238246 );
    target = weyward._blackboard.meleerequestedtarget;
    
    if ( isdefined( target ) )
    {
        target_cone_pitch = vectortoangles( target.origin - var_b72e0dcdd6ad7910 )[ 0 ];
        cone_pitch = math::function_27800ff2fd4867c6( cone_pitch, target_cone_pitch, getdvarfloat( @"hash_dcf92e1f353d121", weyward.var_2fd79266eae38cff ) );
    }
    
    cone_angles = ( cone_pitch, ( weyward.head_yaw ?? 0 ) * -1 + weyward.angles[ 1 ], claw_angles[ 2 ] );
    cone_forward = anglestoforward( cone_angles );
    var_1d4601ed154a2d08 = 0;
    
    if ( abs( weyward.head_yaw ?? 0 ) > getdvarfloat( @"hash_8c360cb06cb08b8e", weyward.var_e327b93e85af24d4 ) )
    {
        var_1d4601ed154a2d08 = getdvarfloat( @"hash_8c360cb06cb08b8e", weyward.var_e327b93e85af24d4 );
    }
    
    cone_length = weyward.melee_range * ( melee_range_multiplier + var_1d4601ed154a2d08 );
    
    if ( weyward is_attack_empowered() )
    {
        cone_length *= weyward.var_ae22e5523001949d;
    }
    
    var_244e33c25ff537e5 = 45;
    potential_targets = getplayersandaiarrayinradius( var_b72e0dcdd6ad7910, cone_length );
    
    foreach ( target in potential_targets )
    {
        if ( target == weyward )
        {
            continue;
        }
        
        if ( isplayer( target ) && target.team == weyward.team )
        {
            continue;
        }
        
        if ( isplayer( target ) && target issprintsliding() )
        {
            if ( length( target getvelocity() ) > 100 )
            {
                continue;
            }
            
            slim_cone_angle = 10;
            
            if ( !math::pointvscone( target getcentroid(), var_b72e0dcdd6ad7910, cone_forward, cone_up, cone_length, 0, slim_cone_angle ) && !math::pointvscone( target getcentroid() - target getboundshalfsize(), var_b72e0dcdd6ad7910, cone_forward, cone_up, cone_length, 0, slim_cone_angle ) )
            {
                continue;
            }
            
            var_244e33c25ff537e5 = slim_cone_angle;
        }
        else if ( !math::pointvscone( target getcentroid(), var_b72e0dcdd6ad7910, cone_forward, cone_up, cone_length, 0, var_244e33c25ff537e5 ) && !math::pointvscone( target getcentroid() + target getboundshalfsize(), var_b72e0dcdd6ad7910, cone_forward, cone_up, cone_length, 0, var_244e33c25ff537e5 ) && !math::pointvscone( target getcentroid() - target getboundshalfsize(), var_b72e0dcdd6ad7910, cone_forward, cone_up, cone_length, 0, var_244e33c25ff537e5 ) )
        {
            var_c23d3d397bf1b5aa = getdvarfloat( @"hash_95471f8b67dca65f", distance( weyward.origin, var_b72e0dcdd6ad7910 ) );
            to_target_from_origin = target getcentroid() - weyward.origin;
            
            if ( vectordot2( cone_forward, to_target_from_origin ) <= 0.2 || !math::segmentvssphere( weyward.origin, var_b72e0dcdd6ad7910, target getcentroid(), var_c23d3d397bf1b5aa ) )
            {
                continue;
            }
        }
        
        targets[ targets.size ] = target;
        
        /#
            if ( debug_melee() )
            {
                line( target getcentroid(), var_b72e0dcdd6ad7910, ( 1, 0, 0 ) );
            }
        #/
    }
    
    /#
        if ( debug_melee() )
        {
            utility::draw_cone( var_b72e0dcdd6ad7910, cone_forward, cone_length, var_244e33c25ff537e5 );
            line( var_b72e0dcdd6ad7910, var_b72e0dcdd6ad7910 + cone_up * 10 );
            line( var_b72e0dcdd6ad7910, var_b72e0dcdd6ad7910 + cone_forward * 10, ( 0.6, 0.7, 0.7 ) );
        }
    #/
    
    return targets;
}

// Namespace zombie_weyward_melee
// Params 2, eflags: 0x4
// Checksum 0x7b1a057b, Offset: 0x16d2
// Size: 0x372
function private function_49ece4a9a77aca11( weyward, range_multiplier = 1 )
{
    stinger_damage = getdvarfloat( @"hash_cb4705ea1efc11b5", weyward.var_546839a856fbe33 );
    
    if ( self._blackboard.var_606bf8ea1f70975d > 0 )
    {
        stinger_damage *= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_40372f826703a5e;
    }
    
    if ( is_attack_empowered() )
    {
        stinger_damage += 30;
    }
    
    swing_dir = function_b13923f98d48596d( weyward );
    tail_start = weyward gettagorigin( "j_tail_01", 1 );
    tail_end = weyward gettagorigin( "j_tail_11", 1 );
    
    if ( tail_start && tail_end )
    {
        tail_radius = getdvarfloat( @"hash_fe76add00fc1181a", weyward.var_9e1d198f65ea9898 ) * range_multiplier;
        tail_radius_squared = 2 * ( distancesquared( tail_start, tail_end ) + squared( tail_radius ) );
        weyward function_6510106c4d7b2934( tail_start, tail_radius_squared, 1 );
    }
    
    var_840926d75db91652 = function_fb1061a097e74ed5( self, range_multiplier );
    
    foreach ( var_90ec0886f9ccf215 in var_840926d75db91652 )
    {
        if ( var_90ec0886f9ccf215 utility::ent_flag( "weyward_meleed" ) )
        {
            continue;
        }
        
        var_90ec0886f9ccf215 utility::ent_flag_set( "weyward_meleed" );
        self.var_210b5649338b900b[ self.var_210b5649338b900b.size ] = var_90ec0886f9ccf215;
        self.var_e93cc47a6f947ce5 = gettime();
        
        if ( isplayer( var_90ec0886f9ccf215 ) )
        {
            var_90ec0886f9ccf215 dodamage( stinger_damage, self.origin, self, self, "MOD_MELEE" );
            var_90ec0886f9ccf215 function_64f1800c957cf63c();
            function_1747377a5337bf9b( self, var_90ec0886f9ccf215 );
            weyward utility::ent_flag_set( "weyward_melee_hit_successful" );
            
            if ( weyward.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.melee_shock )
            {
                var_90ec0886f9ccf215 namespace_9d8e359c3b1041e5::shellshocksharedfunc( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.melee_shock, #"damage", 1 );
            }
            
            continue;
        }
        
        if ( isai( var_90ec0886f9ccf215 ) )
        {
            if ( var_90ec0886f9ccf215.skull_owner != self )
            {
                if ( var_90ec0886f9ccf215.team === self.team && var_90ec0886f9ccf215.aicategory === "normal" )
                {
                    knockdown_source = weyward.origin;
                    
                    if ( swing_dir )
                    {
                        knockdown_source = var_90ec0886f9ccf215.origin - swing_dir * 100;
                    }
                    
                    var_90ec0886f9ccf215 zombie_knockdown::function_6fc167d4a3590991( knockdown_source, getdvarfloat( @"hash_7c9f91b7849ccad6", 600 ), getdvarfloat( @"hash_841bb975bac8137c", 45 ) );
                    weyward utility::ent_flag_set( "weyward_melee_hit_successful" );
                    continue;
                }
                
                var_90ec0886f9ccf215 dodamage( stinger_damage * self.var_42ddbc8ee376c279, self.origin, self, self, "MOD_MELEE" );
            }
        }
    }
    
    if ( weyward utility::ent_flag( "weyward_melee_hit_successful" ) )
    {
        weyward utility::function_7c10ea82c1e305b8( "bite", "hit" );
    }
}

// Namespace zombie_weyward_melee
// Params 3
// Checksum 0x5ae3e089, Offset: 0x1a4c
// Size: 0x189
function function_6510106c4d7b2934( position, var_2022541f3b37a1, var_9eb4e6b084f63fbe )
{
    if ( !var_9eb4e6b084f63fbe )
    {
        radius_squared = squared( var_2022541f3b37a1 );
    }
    else
    {
        radius_squared = var_2022541f3b37a1;
    }
    
    foreach ( player in level.players )
    {
        if ( !player.placedsentries || !player.placedsentries[ "remote_turret" ] )
        {
            continue;
        }
        
        foreach ( turret in player.placedsentries[ "remote_turret" ] )
        {
            if ( turret && turret utility::ent_flag( "remote_sentry_deployed" ) && distance2dsquared( position, turret.origin ) <= radius_squared )
            {
                turret notify( #"kill_turret", 1, 1, 0 );
            }
        }
    }
}

// Namespace zombie_weyward_melee
// Params 1, eflags: 0x4
// Checksum 0xb13f6a3c, Offset: 0x1bdd
// Size: 0xa3
function private function_b13923f98d48596d( weyward )
{
    tail_tip = weyward gettagorigin( "j_tail_11", 1 );
    
    if ( !tail_tip )
    {
        return;
    }
    
    prev_tip = weyward.var_518db9fe31f5bf3d;
    weyward.var_518db9fe31f5bf3d = tail_tip;
    
    if ( !prev_tip )
    {
        return;
    }
    
    swing = ( tail_tip[ 0 ] - prev_tip[ 0 ], tail_tip[ 1 ] - prev_tip[ 1 ], 0 );
    min_dist = getdvarfloat( @"hash_eb16145454b7d6e7", 1 );
    
    if ( lengthsquared( swing ) < min_dist * min_dist )
    {
        return;
    }
    
    return vectornormalize( swing );
}

// Namespace zombie_weyward_melee
// Params 2, eflags: 0x4
// Checksum 0x77491223, Offset: 0x1c89
// Size: 0x272
function private function_fb1061a097e74ed5( weyward, range_multiplier = 1 )
{
    targets = [];
    tail_start = weyward gettagorigin( "j_tail_01", 1 );
    tail_end = weyward gettagorigin( "j_tail_11", 1 );
    
    if ( !tail_start || !tail_end )
    {
        return;
    }
    
    swipe_radius = getdvarfloat( @"hash_fe76add00fc1181a", weyward.var_9e1d198f65ea9898 ) * range_multiplier;
    var_d7327690c55160e5 = getdvarfloat( @"hash_e5d412f6ebe4a6b7", weyward.var_b93b02e9436e7e05 );
    midpoint = ( tail_start + tail_end ) * 0.5;
    var_e7b13538058488e9 = distance( tail_start, tail_end ) * 0.5 + swipe_radius;
    potential_targets = getplayersandaiarrayinradius( midpoint, var_e7b13538058488e9 );
    
    foreach ( target in potential_targets )
    {
        if ( target == weyward )
        {
            continue;
        }
        
        if ( isplayer( target ) && target.team == weyward.team )
        {
            continue;
        }
        
        target_centroid = target getcentroid();
        
        if ( !math::segmentvssphere( tail_start, tail_end, target_centroid, swipe_radius ) )
        {
            continue;
        }
        
        if ( isplayer( target ) && !target isonground() )
        {
            var_cfeafca73684d28b = math::function_2e0e9b10b9c74d9e( target_centroid, tail_start, tail_end );
            
            if ( target_centroid[ 2 ] - var_cfeafca73684d28b[ 2 ] > var_d7327690c55160e5 )
            {
                continue;
            }
        }
        
        targets[ targets.size ] = target;
        
        /#
            if ( debug_melee() )
            {
                line( target getcentroid(), midpoint, ( 0.8, 0, 1 ) );
            }
        #/
    }
    
    /#
        if ( debug_melee() )
        {
            line( tail_start, tail_end, ( 1, 0, 0 ) );
            sphere( tail_start, swipe_radius, ( 0.8, 0, 1 ) );
            sphere( tail_end, swipe_radius, ( 0.8, 0, 1 ) );
            sphere( midpoint, 10, ( 1, 0, 0 ) );
        }
    #/
    
    return targets;
}

// Namespace zombie_weyward_melee
// Params 3, eflags: 0x4
// Checksum 0xa7990933, Offset: 0x1f04
// Size: 0xd7
function private function_1747377a5337bf9b( weyward, player, isaoe )
{
    if ( player.inlaststand )
    {
        return;
    }
    
    var_c51215b779b5fe59 = vectornormalize2( player.origin - weyward.origin );
    to_player_perp = anglestoright( vectortoangles( var_c51215b779b5fe59 ) );
    knockback_dir = rotatepointaroundvector( to_player_perp, var_c51215b779b5fe59, getdvarfloat( @"hash_72a857f57a8974ba", weyward.var_cd34501b9b0e03c0 ) );
    knockback_str = getdvarfloat( @"hash_e7b71a6b2f684663", weyward.var_c075c17e61e89d11 );
    
    if ( isaoe )
    {
        knockback_str += getdvarfloat( @"hash_e7fbb9bfa493a6e7", 80 );
    }
    
    player knockback( knockback_dir, knockback_str, 1 );
}

// Namespace zombie_weyward_melee
// Params 1, eflags: 0x4
// Checksum 0xfa1928ae, Offset: 0x1fe3
// Size: 0x87
function private on_hit_end( weyward )
{
    weyward endon( #"death" );
    waitframe();
    
    if ( !weyward utility::ent_flag( "weyward_melee_hit_successful" ) )
    {
        weyward utility::function_7c10ea82c1e305b8( "bite", "miss" );
    }
    
    weyward utility::ent_flag_clear( "weyward_melee_hit_successful" );
    weyward utility::function_7c10ea82c1e305b8( "tail_swipe", "off" );
    weyward utility::function_7c10ea82c1e305b8( "claw_attack", "off" );
    weyward._blackboard.meleerequestedtarget = undefined;
}

// Namespace zombie_weyward_melee
// Params 2, eflags: 0x4
// Checksum 0x47263efa, Offset: 0x2072
// Size: 0xd0
function private knockback_player( weyward, player )
{
    if ( player.inlaststand )
    {
        return;
    }
    
    var_c8cf90daee0f67a3 = getdvarfloat( @"hash_e5441eb0731f1b40", weyward.melee_knockback_val );
    
    if ( weyward is_attack_empowered() )
    {
        var_c8cf90daee0f67a3 *= weyward.var_49e395d9f821d573;
    }
    
    var_c51215b779b5fe59 = vectornormalize2( player.origin - weyward.origin );
    to_player_perp = anglestoright( vectortoangles( var_c51215b779b5fe59 ) );
    knockback_dir = rotatepointaroundvector( to_player_perp, var_c51215b779b5fe59, getdvarfloat( @"hash_de6bd7589f2936c9", weyward.var_eab9066091746d47 ) );
    player knockback( knockback_dir, var_c8cf90daee0f67a3, 1 );
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0x8335cf66, Offset: 0x214a
// Size: 0x4b3
function private tail_swipe_aoe_wave()
{
    self endon( #"death" );
    self waittill( #"tail_swipe_aoe" );
    var_2b2ba1400207c27d = -1 * anglestoforward( self.angles );
    
    if ( self.tail_swipe_aoe_scriptable )
    {
        self.tail_swipe_aoe = spawnscriptable( self.tail_swipe_aoe_scriptable, self.origin, vectortoangles( var_2b2ba1400207c27d ) );
        self.tail_swipe_aoe utility::function_7c10ea82c1e305b8( "tail_swipe_aoe", "on" );
    }
    
    duration = getdvarfloat( @"hash_d5339b831f7487ea", 0.95 );
    step = getdvarfloat( @"hash_56a521d65e4b9e38", 0.05 );
    var_9a7b20e173174021 = getdvarfloat( @"hash_145e7fe8201c29d7", 64 );
    var_86491b20c248f26 = getdvarfloat( @"hash_ea88f08a8aef08ac", 780 );
    cone_dot = getdvarfloat( @"hash_b665c919c5da5b1b", 0.9 );
    var_d7327690c55160e5 = getdvarfloat( @"hash_4349181546ca5a23", self.var_ee4c1a018b366df1 );
    damage = self.tail_swipe_aoe_damage ?? 75;
    hit_targets = [];
    
    /#
        thread function_5b331f90ac39aea( var_9a7b20e173174021, var_86491b20c248f26, duration, cone_dot, var_2b2ba1400207c27d );
    #/
    
    start_time = gettime();
    elapsed = 0;
    
    while ( elapsed < duration )
    {
        frac = elapsed / duration;
        radius = var_9a7b20e173174021 + ( var_86491b20c248f26 - var_9a7b20e173174021 ) * frac;
        potential_targets = getplayersandaiarrayinradius( self.origin, radius );
        
        foreach ( target in potential_targets )
        {
            if ( target == self || target.team == self.team || target.inlaststand )
            {
                continue;
            }
            
            if ( isplayer( target ) && target utility::ent_flag( "weyward_meleed" ) )
            {
                continue;
            }
            
            already_hit = 0;
            
            foreach ( var_1c23c3b4b3af5469 in hit_targets )
            {
                if ( var_1c23c3b4b3af5469 == target )
                {
                    already_hit = 1;
                    break;
                }
            }
            
            if ( already_hit )
            {
                continue;
            }
            
            dir_to_target = vectornormalize2( target.origin - self.origin );
            
            if ( vectordot( var_2b2ba1400207c27d, dir_to_target ) < cone_dot )
            {
                continue;
            }
            
            if ( isplayer( target ) && !target isonground() )
            {
                if ( target getcentroid()[ 2 ] - self.origin[ 2 ] > var_d7327690c55160e5 )
                {
                    continue;
                }
            }
            
            if ( isplayer( target ) )
            {
                target dodamage( damage, self.origin, self, self, "MOD_MELEE" );
                function_1747377a5337bf9b( self, target, 1 );
            }
            else if ( isai( target ) )
            {
                if ( target.skull_owner != self )
                {
                    if ( target.team === self.team && target.aicategory === "normal" )
                    {
                        target zombie_knockdown::function_6fc167d4a3590991( self.origin, getdvarfloat( @"hash_7c9f91b7849ccad6", 600 ), getdvarfloat( @"hash_841bb975bac8137c", 45 ) );
                    }
                    else
                    {
                        target dodamage( damage * self.var_42ddbc8ee376c279, self.origin, self, self, "MOD_MELEE" );
                    }
                }
            }
            
            hit_targets[ hit_targets.size ] = target;
        }
        
        elapsed += step;
        next_step_time = start_time + elapsed * 1000;
        
        while ( gettime() < next_step_time )
        {
            waitframe();
        }
    }
    
    if ( self.tail_swipe_aoe )
    {
        self.tail_swipe_aoe utility::function_7c10ea82c1e305b8( "tail_swipe_aoe", "off" );
        self.tail_swipe_aoe freescriptable();
        self.tail_swipe_aoe = undefined;
    }
    
    function_d47b9a3406e94069();
    self.var_30335b93e26d53ed = 0;
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0x9599ae18, Offset: 0x2605
// Size: 0x93
function private function_d47b9a3406e94069()
{
    foreach ( var_90ec0886f9ccf215 in self.var_210b5649338b900b )
    {
        if ( isalive( var_90ec0886f9ccf215 ) )
        {
            var_90ec0886f9ccf215 utility::ent_flag_clear( "weyward_meleed" );
        }
    }
    
    self.var_210b5649338b900b = [];
}

/#

    // Namespace zombie_weyward_melee
    // Params 5, eflags: 0x4
    // Checksum 0xd1f9e341, Offset: 0x26a0
    // Size: 0x17d, Type: dev
    function private function_5b331f90ac39aea( var_9a7b20e173174021, var_86491b20c248f26, duration, cone_dot, var_2b2ba1400207c27d )
    {
        self endon( #"death" );
        var_6943cbc5f590ad94 = anglestoright( vectortoangles( var_2b2ba1400207c27d ) );
        edge_half_width = sqrt( max( 0, 1 - squared( cone_dot ) ) );
        left_edge = vectornormalize2( var_2b2ba1400207c27d * cone_dot + var_6943cbc5f590ad94 * edge_half_width );
        right_edge = vectornormalize2( var_2b2ba1400207c27d * cone_dot - var_6943cbc5f590ad94 * edge_half_width );
        start_time = gettime();
        
        while ( true )
        {
            elapsed = ( gettime() - start_time ) / 1000;
            
            if ( elapsed >= duration )
            {
                return;
            }
            
            if ( debug_melee() )
            {
                frac = elapsed / duration;
                radius = var_9a7b20e173174021 + ( var_86491b20c248f26 - var_9a7b20e173174021 ) * frac;
                utility::draw_circle( self.origin, radius, ( 1, 1, 1 ), 1, 0, 1 );
                line( self.origin, self.origin + left_edge * radius, ( 1, 0, 0 ), 1, 0, 1 );
                line( self.origin, self.origin + right_edge * radius, ( 1, 0, 0 ), 1, 0, 1 );
            }
            
            waitframe();
        }
    }

#/

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0x10ba1d2a, Offset: 0x2825
// Size: 0x3e
function private function_5db0b76b4fe4a1e2()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_9f6d1fd5ff565730" );
        thread on_melee_start();
        self waittill( #"bmeleeended" );
        thread on_melee_end();
    }
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0x6feef160, Offset: 0x286b
// Size: 0x26
function private on_melee_start()
{
    self endon( #"death" );
    self endon( #"bmeleeended" );
    utility::ent_flag_set( "in_melee" );
}

// Namespace zombie_weyward_melee
// Params 0, eflags: 0x4
// Checksum 0x3521986d, Offset: 0x2899
// Size: 0x3d
function private on_melee_end()
{
    utility::function_7c10ea82c1e305b8( "tail_swipe", "off" );
    
    if ( !self.var_30335b93e26d53ed )
    {
        function_d47b9a3406e94069();
    }
    
    utility::ent_flag_clear( "in_melee" );
    self.var_4864b6d03c1561ae = 0;
}

/#

    // Namespace zombie_weyward_melee
    // Params 0, eflags: 0x4
    // Checksum 0xf2bc9884, Offset: 0x28de
    // Size: 0x5a, Type: dev
    function private function_5846cffc47a3c2b1()
    {
        devgui::function_9082edeb5db93280( "<dev string:x91>" );
        devgui::add_devgui_func( "<dev string:xb0>", "<dev string:xbc>", &force_melee );
        devgui::add_devgui_func( "<dev string:xd0>", "<dev string:xe4>", &force_stinger_swipe );
        devgui::add_devgui_func( "<dev string:x100>", "<dev string:x10c>", &toggle_melee_debug );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_melee
    // Params 1, eflags: 0x4
    // Checksum 0xb7683144, Offset: 0x2940
    // Size: 0x70, Type: dev
    function private force_melee( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x127>" );
        
        if ( isdefined( weyward ) )
        {
            weyward._blackboard.meleerequestedtarget = level.players[ 0 ];
            weyward notify( #"hash_9f6d1fd5ff565730" );
        }
    }

    // Namespace zombie_weyward_melee
    // Params 1, eflags: 0x4
    // Checksum 0xa6335ebf, Offset: 0x29b8
    // Size: 0x56, Type: dev
    function private force_stinger_swipe( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x127>" );
        
        if ( isdefined( weyward ) )
        {
            weyward function_6546aa1a41debe5d( level.players[ 0 ] );
        }
    }

    // Namespace zombie_weyward_melee
    // Params 1, eflags: 0x4
    // Checksum 0xaaf47702, Offset: 0x2a16
    // Size: 0x24, Type: dev
    function private toggle_melee_debug( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x136>", @"hash_c826608ec9ff38f0" );
    }

    // Namespace zombie_weyward_melee
    // Params 0, eflags: 0x4
    // Checksum 0xc749ba6c, Offset: 0x2a42
    // Size: 0x16, Type: dev
    function private debug_melee()
    {
        return getdvarint( @"hash_c826608ec9ff38f0", 0 ) > 0;
    }

#/
