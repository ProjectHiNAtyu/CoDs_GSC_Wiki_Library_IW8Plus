// scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack.gsc  (hash_175692a62b8813a2.gscc) (size: 18216 Bytes / 0x4728 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90dfe90d (2430593293)
// size ...... 18216 (0x4728)
// includes .. 13  (offset: 0x4408)
// strings ... 42  (offset: 0x4470)
// dev strs .. 5   (offset: 0x46e4)
// exports ... 46  (offset: 0x2be0)
// cseg ...... 0x4e0 + 0x2700 (0x2be0)
// imports ... 129 (offset: 0x3310)
// animtree1 . 0   (offset: 0x4728)
// animtree2 . 0   (offset: 0x4728)
#using script_ca2af83fc465375;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_cannonball;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;

#namespace zombie_vehicle_attack;

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0xcc472438, Offset: 0x4fe
// Size: 0x22
function init_zombie_vehicle_attack( disableoninit )
{
    if ( disableoninit )
    {
        disable_vehicle_attack();
        return;
    }
    
    enable_vehicle_attack();
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0x790a8ef5, Offset: 0x528
// Size: 0x68
function enable_vehicle_attack()
{
    self._blackboard.var_aea083d51b9d1f2b = 1;
    self._blackboard.var_ec7f4619e23f1b09 = gettime();
    thread init_leap_intro_length();
    thread function_df35852ce8ebb9a5();
    thread function_8389f196618288e2();
    thread listen_vehicle_attack_end();
    thread function_1e5d32952da6225d();
    thread function_cc6cf69355d32911();
    thread function_e41f55d0f894bb73();
    thread function_4d6bed6cc23c8e95();
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0x650bbec5, Offset: 0x598
// Size: 0x23
function disable_vehicle_attack()
{
    self._blackboard.var_aea083d51b9d1f2b = 0;
    self notify( #"vehicle_attack_disabled" );
}

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0xae4ee378, Offset: 0x5c3
// Size: 0x17
function set_vehicle_collision_impact_vfx( vfxscriptable )
{
    self.var_29cc84b245eb1ccd = vfxscriptable;
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0x381f4ed6, Offset: 0x5e2
// Size: 0xc
function function_6a23a95d37782843()
{
    level.var_9c7fce064a6bec19 = 0;
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0x598508b, Offset: 0x5f6
// Size: 0xd
function function_370f4f6725424ecc()
{
    level.var_9c7fce064a6bec19 = 1;
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0xa5316d9b, Offset: 0x60b
// Size: 0x16, Type: bool
function is_vehicle_attack_enabled()
{
    return istrue( self._blackboard.var_aea083d51b9d1f2b );
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0x4a21eb7e, Offset: 0x62a
// Size: 0x16, Type: bool
function is_in_vehicle_attack()
{
    return istrue( self._blackboard.var_54483a8d96c24387 );
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0x7bad5d28, Offset: 0x649
// Size: 0x16, Type: bool
function function_2792973502e82679()
{
    return istrue( self._blackboard.var_ad8429be5aa1aa98 );
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0xa2c40d69, Offset: 0x668
// Size: 0x1a, Type: bool
function is_vehicle_attack_in_cooldown()
{
    return gettime() <= self._blackboard.var_ec7f4619e23f1b09;
}

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0x559c8838, Offset: 0x68b
// Size: 0x42
function function_1103fe44822e8b55( var_fd48b9bddc4acff2 )
{
    assert( is_in_vehicle_attack(), "<dev string:x24>" );
    
    if ( !isdefined( self.var_fd48b9bddc4acff2 ) )
    {
        self.var_fd48b9bddc4acff2 = var_fd48b9bddc4acff2;
    }
    
    self notify( #"vehicle_attack_knock_off_while_latched_triggered" );
}

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0x733341c, Offset: 0x6d5
// Size: 0x39
function set_vehicle_attack_cooldown( time )
{
    assert( time >= 0, "<dev string:x5f>" );
    self._blackboard.var_d25fb6ff6554b02b = utility::function_4b74c15943231980( time );
}

// Namespace zombie_vehicle_attack
// Params 0
// Checksum 0x2af8bc, Offset: 0x716
// Size: 0x46
function get_vehicle_attack_max_height()
{
    assert( isdefined( self._blackboard.var_7f754e4991eed5ef ), "<dev string:xa3>" + self.subclass + "<dev string:xec>" );
    return self._blackboard.var_7f754e4991eed5ef;
}

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0xd18c177d, Offset: 0x765
// Size: 0x53
function set_vehicle_attack_max_height( maxheight )
{
    assert( isdefined( self._blackboard.var_7f754e4991eed5ef ), "<dev string:xa3>" + self.subclass + "<dev string:xec>" );
    self._blackboard.var_7f754e4991eed5ef = maxheight;
}

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0x7b207a0, Offset: 0x7c0
// Size: 0x22
function function_cddc67295266ee84( seconds )
{
    self._blackboard.var_504b6217e686d548 = seconds;
}

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0x89c315c8, Offset: 0x7ea
// Size: 0x22
function function_b6b04d95c27e889b( enabled )
{
    self._blackboard.var_b1d8d80e57e7e8a8 = enabled;
}

// Namespace zombie_vehicle_attack
// Params 1
// Checksum 0xfaa909b1, Offset: 0x814
// Size: 0x22
function function_22391ae9d7a28a94( enabled )
{
    self._blackboard.var_ad6bf8160e8d182e = enabled;
}

// Namespace zombie_vehicle_attack
// Params 3
// Checksum 0xae43eb58, Offset: 0x83e
// Size: 0x29
function function_b2f3f65e87ad25af( targetvehicle, var_185c753999262991, overridefailsafe )
{
    thread function_3ee0a7df24113775( targetvehicle, var_185c753999262991, overridefailsafe );
}

// Namespace zombie_vehicle_attack
// Params 2
// Checksum 0x4aefde4e, Offset: 0x86f
// Size: 0xf0
function function_cf284e8470c97328( targetvehicle, var_185c753999262991 )
{
    if ( !isdefined( var_185c753999262991 ) )
    {
        var_185c753999262991 = targetvehicle function_e5f885e9f2606921();
        
        if ( !isdefined( var_185c753999262991 ) )
        {
            return;
        }
    }
    
    result = spawnstruct();
    var_5edf9013579b71a1 = targetvehicle gettagorigin( var_185c753999262991 );
    var_139097223d6bb585 = 0.8;
    deltatime = getdvarfloat( @"hash_4f12c336c369bf0c", var_139097223d6bb585 );
    var_7c302c8342d39a63 = targetvehicle vehicle_getvelocity() * deltatime;
    var_5edf9013579b71a1 += var_7c302c8342d39a63;
    result.origin = function_8690cca06c34faf0( var_5edf9013579b71a1, targetvehicle, var_185c753999262991, var_7c302c8342d39a63 );
    
    if ( !isdefined( result.origin ) )
    {
        return;
    }
    
    result.angles = ( 0, vectortoyaw( var_5edf9013579b71a1 - result.origin ), 0 );
    result.var_309a32167a388a30 = var_185c753999262991;
    return result;
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x2acbfd57, Offset: 0x968
// Size: 0x39
function private init_leap_intro_length()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 1 );
    self function_786bb6aa1b76c7ee( "leap_intro_length", namespace_69de094c38cf2d84::function_4a67513563b1f915() );
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x85d10979, Offset: 0x9a9
// Size: 0x9
function private request_vehicle_attack()
{
    namespace_69de094c38cf2d84::function_609bb007d270ea2b();
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x65df00e7, Offset: 0x9ba
// Size: 0xa7
function private function_df35852ce8ebb9a5()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    
    while ( true )
    {
        self waittill( #"vehicle_attack_start" );
        
        if ( ( self.noragdoll || self.script_noragdoll ) && !self.forceannihilate )
        {
            self.forceannihilate = 1;
            self.var_e58d2e3b6943fdc4 = 1;
        }
        else if ( !self.forceragdollimmediate )
        {
            self.forceragdollimmediate = 1;
            self.ragdoll_damagelocation_none = "torso_upper";
            self.var_8ed71d57a063b6af = 1;
        }
        
        request_vehicle_attack();
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x68cdf58f, Offset: 0xa69
// Size: 0x36
function private function_8389f196618288e2()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    
    while ( true )
    {
        self waittill( #"vehicle_attack_leap_intro_end" );
        self allowvehiclepredictiveragdoll( 0 );
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x9ce7ebca, Offset: 0xaa7
// Size: 0xb9
function private function_c01d302396e323b2()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_unlatch_start" );
    self endon( #"vehicle_attack_end" );
    var_11636c7e0ccac0f8 = 400;
    var_49fcb7ef787120a9 = self getboundshalfsize();
    portaldisplacement = ( 0, 0, var_49fcb7ef787120a9[ 2 ] );
    
    while ( true )
    {
        self waittill( #"vehicle_attack_teleport_to_ground", teleportpos, teleportangles );
        thread function_bb6585e19b35dc64( teleportpos, teleportangles, portaldisplacement );
        asm::asm_fireevent( self.asmname, "vehicle_attack_teleport_to_ground" );
        self unlink();
        self forceteleport( teleportpos, teleportangles, var_11636c7e0ccac0f8, 0 );
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x71199d58, Offset: 0xb68
// Size: 0x4c
function private function_38116ed60574f3a()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_unlatch_start" );
    self endon( #"vehicle_attack_end" );
    
    while ( true )
    {
        self waittill( #"vehicle_attack_failsafe" );
        self.nocorpse = 1;
        self kill();
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x30d8d951, Offset: 0xbbc
// Size: 0x1a8
function private function_b81da9bca3b3db30()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_unlatch_start" );
    self endon( #"vehicle_attack_end" );
    var_8ce89f070cfa56d4 = 4e+06;
    var_329e3f3d0856ec2e = -0.9;
    
    while ( true )
    {
        self waittill( #"hash_7ceb250625402d74", var_8d08d6b5085f5594, collisionnormal );
        
        if ( val::get( "damageshield" ) )
        {
            waitframe();
            continue;
        }
        
        self.ragdollimpactvector = collisionnormal * function_66fc966736e6cfb2();
        self.ragdollhitloc = "torso_upper";
        targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
        var_9b578ef384c3ddda = vectornormalize( targetvehicle vehicle_getvelocity() );
        goingforward = vectordot2( anglestoforward( targetvehicle.angles ), var_9b578ef384c3ddda ) > 0;
        var_1a77d868639951ce = vectordot( collisionnormal, var_9b578ef384c3ddda ) <= var_329e3f3d0856ec2e && ( goingforward && self._blackboard.var_ce36df28fb6b0481 == 0 || !goingforward && self._blackboard.var_ce36df28fb6b0481 == 1 );
        
        if ( lengthsquared( self.ragdollimpactvector ) > var_8ce89f070cfa56d4 && var_1a77d868639951ce )
        {
            callback::callback( "on_zombie_vehicle_attack_crushed_while_latched" );
        }
        
        self playsound( #"hash_b9449df46d2954d4" );
        var_d07b66ae1a81001f = vehicle_occupancy::get_driver( targetvehicle );
        self kill( self.origin, var_d07b66ae1a81001f, targetvehicle, "MOD_CRUSH" );
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x899db6ae, Offset: 0xd6c
// Size: 0x9c
function private listen_vehicle_attack_end()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    
    while ( true )
    {
        self waittill( #"vehicle_attack_end" );
        
        if ( self.var_e58d2e3b6943fdc4 )
        {
            self.forceannihilate = 0;
            self.var_e58d2e3b6943fdc4 = undefined;
        }
        else if ( self.var_8ed71d57a063b6af && !self._blackboard.var_ad8429be5aa1aa98 )
        {
            self.forceragdollimmediate = 0;
            self.ragdoll_damagelocation_none = undefined;
            self.var_8ed71d57a063b6af = undefined;
        }
        
        self allowvehiclepredictiveragdoll( 1 );
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0xcade9960, Offset: 0xe10
// Size: 0x2fb
function private function_1e5d32952da6225d()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    var_b48de2852c397f23 = 5;
    var_dd81fae05f113bf = 0;
    
    while ( true )
    {
        self waittill( #"vehicle_attack_latch_linkto_start" );
        
        if ( self._blackboard.var_16bcf486107e6291 == "" )
        {
            waitframe();
            continue;
        }
        
        ai_velocity = self getvelocity();
        frame_i = 0;
        
        while ( frame_i < getdvarint( @"hash_26283b4343b2a1b4", 2 ) )
        {
            waitframe();
            frame_i += 1;
        }
        
        while ( var_dd81fae05f113bf <= var_b48de2852c397f23 )
        {
            targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
            
            if ( isdefined( targetvehicle ) )
            {
                latch_pos = targetvehicle gettagorigin( self._blackboard.var_16bcf486107e6291, 1 );
                latch_angles = targetvehicle gettagangles( self._blackboard.var_16bcf486107e6291, 1 );
                
                if ( !isdefined( latch_pos ) || !isdefined( latch_angles ) )
                {
                    self notify( #"vehicle_attack_collided_with_vehicle", self.origin, 1 );
                    waitframe();
                    break;
                }
                
                self forceteleport( latch_pos, latch_angles );
                
                if ( self function_84c65dc76bfb762a() )
                {
                    var_7cadbbb28ef5fb82 = targetvehicle function_1dcd1edbad560a45() == targetvehicle function_dd8036d3c66a69c();
                    var_c4f6dde4eae85fd3 = var_7cadbbb28ef5fb82 && getdvarint( @"hash_d3e31a973b64462d", 1 );
                    
                    if ( var_c4f6dde4eae85fd3 )
                    {
                        forcevec = targetvehicle.origin + ai_velocity;
                        forcevec = coordtransformtranspose( forcevec, targetvehicle.origin, targetvehicle.angles );
                        forcevec = vectornormalize( forcevec );
                        forcevec *= getdvarfloat( @"hash_af854ea87e6bf79e", function_fa72a9c22c7ed546( targetvehicle ) );
                        targetvehicle vehphys_force( forcevec, coordtransformtranspose( latch_pos, targetvehicle.origin, targetvehicle.angles ) );
                    }
                    
                    playrumbleonposition( "zombie_vehicle_attack_impact_rumble", latch_pos );
                    self.var_c2244a336e1c23aa = 1;
                    val::set_array( "vehicle_attack", [ "postpone_stun", "postpone_vortex_pull" ], 1 );
                    thread function_2ed47f81063a96c9();
                    thread function_8eab277922e31536();
                    thread function_b81da9bca3b3db30();
                    thread function_c01d302396e323b2();
                    thread function_38116ed60574f3a();
                    thread function_c777a77c7abaf3ed();
                    params = spawnstruct();
                    params.targetvehicle = targetvehicle;
                    params.var_fb8c55c535ed177e = self._blackboard.var_16bcf486107e6291;
                    callback::callback( "on_zombie_vehicle_attack_latch_on_complete", params );
                    var_dd81fae05f113bf = 0;
                    self notify( #"vehicle_attack_latch_onto_complete" );
                    break;
                }
                else
                {
                    var_dd81fae05f113bf++;
                }
            }
            else
            {
                var_dd81fae05f113bf++;
            }
            
            if ( var_dd81fae05f113bf > var_b48de2852c397f23 )
            {
                asm::asm_fireevent( self.asmname, "leap_end" );
                var_dd81fae05f113bf = 0;
                break;
            }
            
            waitframe();
        }
    }
}

// Namespace zombie_vehicle_attack
// Params 2, eflags: 0x4
// Checksum 0x562aa6f4, Offset: 0x1113
// Size: 0xe4
function private function_fa72a9c22c7ed546( targetvehicle, impactside )
{
    var_a453acc1df171481 = 300000;
    var_bb07d1a3be5d5bfe = 100000;
    var_5a119a3aedf88d91 = impactside ?? self._blackboard.var_ce36df28fb6b0481;
    
    if ( targetvehicle.var_bf820b73b8543743 == var_5a119a3aedf88d91 )
    {
        var_23ff97312c8f2301 = 1;
    }
    
    targetvehicle.var_bf820b73b8543743 = var_5a119a3aedf88d91;
    var_189dbd9ae508f53 = math::lerp_fraction( self._blackboard.var_5b5362fa2e2e1495, self._blackboard.var_1a119bcb43738151, self._blackboard.var_5121271c0c237017 );
    
    if ( var_23ff97312c8f2301 )
    {
        var_189dbd9ae508f53 /= 2;
    }
    
    return math::lerp( var_bb07d1a3be5d5bfe, var_a453acc1df171481, var_189dbd9ae508f53 );
}

// Namespace zombie_vehicle_attack
// Params 3, eflags: 0x4
// Checksum 0x31930e3d, Offset: 0x1200
// Size: 0xf7
function private function_86b26daaf518a975( targetvehicle, lowerlimit, upperlimit )
{
    var_20e78682ca8dd695 = anglestoforward( targetvehicle.angles );
    goingforward = vectordot2( var_20e78682ca8dd695, targetvehicle vehicle_getvelocity() ) > 0;
    
    if ( goingforward )
    {
        maxspeed = targetvehicle vehicle_gettopspeedforward( 1 );
    }
    else
    {
        maxspeed = targetvehicle vehicle_gettopspeedreverse( 1 );
    }
    
    var_d8056835ed0a54ba = math::lerp_fraction( 0, maxspeed, targetvehicle vehicle_getspeed() );
    
    if ( var_d8056835ed0a54ba > 0.1 )
    {
        var_ed1baefdaa8f3c8e = math::lerp_fraction( -1, 1, vectordot2( self._blackboard.var_deba31194361569b, targetvehicle vehicle_getvelocity(), 1 ) );
        var_e41c5ae73de09079 = ( var_d8056835ed0a54ba + var_ed1baefdaa8f3c8e ) / 2;
    }
    else
    {
        var_e41c5ae73de09079 = var_d8056835ed0a54ba;
    }
    
    return math::lerp( lowerlimit, upperlimit, var_e41c5ae73de09079 );
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x28994942, Offset: 0x1300
// Size: 0x74
function private function_cc6cf69355d32911()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    var_faef79a022e73922 = 6;
    
    while ( true )
    {
        self waittill( #"vehicle_attack_leap_intro_end" );
        self function_7f8988ce63c1623d( 0 );
        utility::waittill_any_in_array_or_timeout( [ "vehicle_attack_latch_onto_complete", "knockdown_end", "cannonball_end" ], var_faef79a022e73922 );
        self function_7f8988ce63c1623d( 1 );
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x9d5a64a9, Offset: 0x137c
// Size: 0x708
function private function_e41f55d0f894bb73()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    var_c3f0fa7fcfc0ba37 = 10;
    var_57cecc92ddd1f673 = 0.9;
    var_f18ad91ca56edfb = 50;
    var_35b48b22e25d10db = 0.5;
    
    while ( true )
    {
        self waittill( #"vehicle_attack_collided_with_vehicle", var_8d08d6b5085f5594, var_51553cb1c30b5d6c );
        self._blackboard.var_ad8429be5aa1aa98 = 1;
        aivelocity = self getvelocity();
        
        if ( length( aivelocity ) <= 0.1 )
        {
            aivelocity = anglestoforward( self.angles );
        }
        
        var_1fa9bb9e935ad256 = length( aivelocity * getframeduration() * 0.001 ) + var_c3f0fa7fcfc0ba37;
        
        if ( !isvector( var_8d08d6b5085f5594 ) )
        {
            var_8d08d6b5085f5594 = self.origin;
        }
        else
        {
            self forceteleport( var_8d08d6b5085f5594, self.angles, var_1fa9bb9e935ad256 );
        }
        
        targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
        var_cfc9de03ff8f673f = anglestoforward( targetvehicle.angles );
        var_2f5ee5c9dece1c2f = anglestoup( targetvehicle.angles );
        var_bf939c998135576 = anglestoright( targetvehicle.angles );
        var_d0c40b08b5ef4a85 = vectornormalize( self.origin - targetvehicle.origin );
        goingforward = vectordot2( var_cfc9de03ff8f673f, targetvehicle vehicle_getvelocity() ) > 0;
        
        if ( goingforward )
        {
            maxspeed = targetvehicle vehicle_gettopspeedforward( 1 );
        }
        else
        {
            maxspeed = targetvehicle vehicle_gettopspeedreverse( 1 );
        }
        
        var_e0b8604b928d9a30 = math::lerp_fraction( 0, maxspeed, targetvehicle vehicle_getspeed() );
        
        if ( vectordot( var_cfc9de03ff8f673f, var_d0c40b08b5ef4a85 ) <= -1 * var_57cecc92ddd1f673 )
        {
            var_4d4028744ef066ac = 1;
        }
        
        var_e4081743492dcefa = math::lerp( self.var_a070a560568c9817, self.var_5913e2bda603322d, var_e0b8604b928d9a30 );
        
        if ( var_51553cb1c30b5d6c && !var_4d4028744ef066ac && self._blackboard.var_f8ac7534e117c195 != 1 )
        {
            if ( self._blackboard.var_f8ac7534e117c195 == 3 || self._blackboard.var_f8ac7534e117c195 == 2 )
            {
                var_e4081743492dcefa = math::lerp( 450, 480, var_e0b8604b928d9a30 );
                var_8a7b08021e6764f8 = math::lerp( 55, 60, var_e0b8604b928d9a30 );
                var_32f508a166900a50 = math::lerp( 400, 800, var_e0b8604b928d9a30 );
                var_5514fcf75920e7cb = math::lerp( 5, 10, var_e0b8604b928d9a30 );
            }
            else if ( self._blackboard.var_f8ac7534e117c195 == 4 || self._blackboard.var_f8ac7534e117c195 == 0 )
            {
                var_e4081743492dcefa = math::lerp( 450, 500, var_e0b8604b928d9a30 );
                var_8a7b08021e6764f8 = math::lerp( 35, 40, var_e0b8604b928d9a30 );
                var_32f508a166900a50 = math::lerp( 500, 900, var_e0b8604b928d9a30 );
                var_5514fcf75920e7cb = math::lerp( 3, 8, var_e0b8604b928d9a30 );
            }
            
            cannonballdir = vectornormalize( aivelocity - vectordot( aivelocity, var_2f5ee5c9dece1c2f ) * var_2f5ee5c9dece1c2f );
            var_fa9e89c63419ed31 = vectorcross( var_2f5ee5c9dece1c2f, cannonballdir );
            cannonballdir = rotatepointaroundvector( var_fa9e89c63419ed31, cannonballdir, -1 * getdvarfloat( @"hash_ed46b786707d342", var_8a7b08021e6764f8 ) );
            zombie_cannonball::cannonball_ai( cannonballdir, getdvarfloat( @"hash_fd0ac8d0fa455064", var_e4081743492dcefa ), zombie_cannonball::adv_settings( 1, getdvarfloat( @"hash_6d76045fabfe8493", var_5514fcf75920e7cb ), 0, getdvarfloat( @"hash_af3bbb39e5b9bc88", var_32f508a166900a50 ), self function_92794727e5ea36d4() ), "roll_forward" );
        }
        else
        {
            var_e4081743492dcefa *= var_35b48b22e25d10db;
            forwardvec = anglestoforward( self.angles );
            var_bf939c998135576 = anglestoright( targetvehicle.angles );
            
            switch ( self._blackboard.var_f8ac7534e117c195 )
            {
                case 0:
                    var_ad7447da6369bf8a = -1 * var_cfc9de03ff8f673f;
                    break;
                case 1:
                    var_ad7447da6369bf8a = var_cfc9de03ff8f673f;
                    break;
                case 3:
                    var_ad7447da6369bf8a = -1 * var_bf939c998135576;
                    break;
                case 2:
                    var_ad7447da6369bf8a = var_bf939c998135576;
                    break;
                default:
                    var_ad7447da6369bf8a = forwardvec;
                    break;
            }
            
            var_2e6afa7663eee43b = -2 * angleclamp180( vectortoyaw( forwardvec ) - vectortoyaw( var_ad7447da6369bf8a ) );
            var_d5b1a3ba799fd273 = rotatepointaroundvector( anglestoup( self.angles ), anglestoforward( self.angles ), var_2e6afa7663eee43b );
            var_218f4f6de8b46b64 = self.origin + var_d5b1a3ba799fd273 * var_f18ad91ca56edfb;
            var_8c277d638c6aff75 = anglestoforward( self.angles );
            leapdirection = vectornormalize( self getvelocity() );
            leap_dot = vectordot( leapdirection, var_8c277d638c6aff75 );
            impactdegrees = 0;
            
            if ( leap_dot < 1 && leap_dot > -1 )
            {
                impactdegrees = acos( leap_dot );
            }
            
            if ( leapdirection[ 2 ] < 0 )
            {
                impactdegrees *= -1;
            }
            
            zombie_knockdown::function_6fc167d4a3590991( var_218f4f6de8b46b64, getdvarfloat( @"hash_a10e4c947e4dd276", var_e4081743492dcefa ), getdvarfloat( @"hash_855b90f652e19c16", impactdegrees ) );
        }
        
        thread function_37b1228142b084ce();
        
        if ( isdefined( self.var_29cc84b245eb1ccd ) )
        {
            var_f3a64e9b3f9800f8 = spawnscriptable( self.var_29cc84b245eb1ccd, var_8d08d6b5085f5594, self.angles );
            
            if ( isdefined( var_f3a64e9b3f9800f8 ) )
            {
                var_f3a64e9b3f9800f8 thread function_4fb27f5f2382a734( self.var_29cc84b245eb1ccd, var_8d08d6b5085f5594 );
            }
        }
        
        var_7cadbbb28ef5fb82 = targetvehicle function_1dcd1edbad560a45() == targetvehicle function_dd8036d3c66a69c();
        var_c4f6dde4eae85fd3 = var_7cadbbb28ef5fb82 && getdvarint( @"hash_d3e31a973b64462d", 1 );
        
        if ( var_c4f6dde4eae85fd3 )
        {
            forcevec = targetvehicle.origin + aivelocity;
            forcevec = coordtransformtranspose( forcevec, targetvehicle.origin, targetvehicle.angles );
            forcevec = vectornormalize( forcevec );
            forcevec *= getdvarfloat( @"hash_af854ea87e6bf79e", function_fa72a9c22c7ed546( targetvehicle ) );
            targetvehicle vehphys_force( forcevec, coordtransformtranspose( var_8d08d6b5085f5594, targetvehicle.origin, targetvehicle.angles ) );
        }
        
        playrumbleonposition( "zombie_vehicle_attack_impact_rumble", var_8d08d6b5085f5594 );
        utility::waittill_any_timeout( 5, "knockdown_end", "cannonball_end" );
        
        if ( self.var_8ed71d57a063b6af )
        {
            self.forceragdollimmediate = 0;
            self.ragdoll_damagelocation_none = undefined;
            self.var_8ed71d57a063b6af = undefined;
        }
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0xe65221a6, Offset: 0x1a8c
// Size: 0x183
function private function_37b1228142b084ce()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    self endon( #"cannonball_end" );
    self endon( #"knockdown_end" );
    var_dbdb4b2edf8f36e5 = utility::function_4b74c15943231980( 10 );
    
    if ( !isdefined( level.vehicle_attack_cannonball_or_aerial_knockback_double_vehicle_collision_throttle ) )
    {
        level.vehicle_attack_cannonball_or_aerial_knockback_double_vehicle_collision_throttle = throttle::throttle_initialize( "vehicle_attack_cannonball_or_aerial_knockback_double_vehicle_collision_throttle", 1 );
    }
    
    targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
    traceradius = length( self getboundshalfsize() ) * 0.2;
    wait 0.05;
    threadstarttime = gettime();
    
    for ( threadtime = 0; threadtime < var_dbdb4b2edf8f36e5 ; threadtime = gettime() - threadstarttime )
    {
        trace_result = trace::capsule_get_closest_point( self getcentroid(), traceradius, traceradius * 2, undefined, 0, [ self ], trace::create_solid_ai_contents() );
        
        if ( trace_result[ "entity" ] == targetvehicle && !val::get( "damageshield" ) )
        {
            self.ragdollimpactvector = self getvelocity();
            self.ragdollhitloc = "torso_upper";
            
            if ( targetvehicle )
            {
                var_d07b66ae1a81001f = vehicle_occupancy::get_driver( targetvehicle );
                self kill( self.origin, var_d07b66ae1a81001f, targetvehicle, "MOD_CRUSH" );
            }
            else
            {
                self kill();
            }
        }
        
        throttle::throttle_wait_in_queue( level.vehicle_attack_cannonball_or_aerial_knockback_double_vehicle_collision_throttle, self );
    }
}

// Namespace zombie_vehicle_attack
// Params 2, eflags: 0x4
// Checksum 0x9035d16b, Offset: 0x1c17
// Size: 0x4b
function private function_4fb27f5f2382a734( var_29cc84b245eb1ccd, var_8d08d6b5085f5594 )
{
    self endon( #"death" );
    var_f69727fd3a663df2 = 2;
    self setscriptablepartstate( "hit_vehicle", "hit_vehicle" );
    wait var_f69727fd3a663df2;
    self freescriptable();
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x571bb5d2, Offset: 0x1c6a
// Size: 0xec
function private function_4d6bed6cc23c8e95()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_disabled" );
    var_fd7903d1b3d37456 = 0.5;
    
    while ( true )
    {
        self waittill( #"hash_b0179024b9fe4551" );
        targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
        
        if ( isdefined( targetvehicle ) )
        {
            var_d0bfb49ee2a8409b = lengthsquared( targetvehicle getboundshalfsize() * getdvarfloat( @"hash_f2ec34637c05e265", var_fd7903d1b3d37456 ) );
            var_4da0dbac4d2e7dbe = distancesquared( self.origin, targetvehicle getcentroid() );
            
            if ( var_4da0dbac4d2e7dbe <= var_d0bfb49ee2a8409b )
            {
                self.forceannihilate = 1;
            }
            
            var_d07b66ae1a81001f = vehicle_occupancy::get_driver( targetvehicle );
            self kill( self.origin, var_d07b66ae1a81001f, targetvehicle, "MOD_CRUSH" );
            continue;
        }
        
        self kill();
    }
}

// Namespace zombie_vehicle_attack
// Params 3, eflags: 0x4
// Checksum 0x84301ccd, Offset: 0x1d5e
// Size: 0x110
function private function_bb6585e19b35dc64( teleportpos, teleportangles, portaldisplacement )
{
    self endon( #"death" );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.teleportportal ) );
    var_caeeec01a6f2bd0c = spawnscriptable( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.teleportportal, self.origin + portaldisplacement, self.angles );
    var_caeeec01a6f2bd0c setscriptablepartstate( "portal", "portal" );
    self hide();
    wait 0.35;
    groundportal = spawnscriptable( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.teleportportal, teleportpos + portaldisplacement, teleportangles );
    groundportal setscriptablepartstate( "portal", "portal" );
    wait 0.1;
    self show();
    wait 0.5;
    var_caeeec01a6f2bd0c freescriptable();
    groundportal freescriptable();
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x8f1c2ac3, Offset: 0x1e76
// Size: 0x14f
function private function_8eab277922e31536()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_unlatch_start" );
    self endon( #"vehicle_attack_end" );
    
    while ( true )
    {
        self waittill( #"vehicle_attack_hit", var_b7936e6709d11090, half_damage, var_b8a5c192a364d7ba );
        hitvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
        
        if ( hitvehicle vehicle::is_vehicle() )
        {
            if ( self._blackboard.var_ddc98d1d3dc36e37 > 0 )
            {
                if ( half_damage == "half_damage" )
                {
                    var_4ad0525bf291bf21 = self._blackboard.var_ddc98d1d3dc36e37 / 2;
                }
                else
                {
                    var_4ad0525bf291bf21 = self._blackboard.var_ddc98d1d3dc36e37;
                }
                
                hitvehicle dodamage( var_4ad0525bf291bf21, self.origin, self, self, "MOD_MELEE" );
            }
            
            params = spawnstruct();
            params.hitvehicle = hitvehicle;
            
            if ( isdefined( var_b7936e6709d11090 ) )
            {
                params.var_4fe75e13164e5ab7 = var_b7936e6709d11090;
            }
            
            if ( isdefined( var_b8a5c192a364d7ba ) )
            {
                params.var_fe3e86e233a02f92 = 1;
            }
            
            callback::callback( "on_zombie_vehicle_attack_hit", params );
        }
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x9e3e9f53, Offset: 0x1fcd
// Size: 0xba
function private function_2ed47f81063a96c9()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_end" );
    var_4c46281aeec0f54 = 5;
    var_79e5b4d1422c65fa = 0;
    
    while ( true )
    {
        self waittill( #"vehicle_attack_unlatch_start" );
        
        while ( var_79e5b4d1422c65fa <= var_4c46281aeec0f54 )
        {
            targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
            
            if ( isdefined( targetvehicle ) )
            {
                self unlink();
                self.var_c2244a336e1c23aa = 0;
                val::reset_all( "vehicle_attack" );
                var_dd81fae05f113bf = 0;
                break;
            }
            else
            {
                var_dd81fae05f113bf++;
            }
            
            if ( var_dd81fae05f113bf > var_4c46281aeec0f54 )
            {
                self kill();
                break;
            }
            
            waitframe();
        }
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0xa4d0cd75, Offset: 0x208f
// Size: 0x528
function private function_c777a77c7abaf3ed()
{
    self endon( #"death" );
    self endon( #"vehicle_attack_unlatch_start" );
    self endon( #"vehicle_attack_end" );
    self endon( #"vehicle_attack_disabled" );
    var_52329aa9dd173895 = 1.25;
    var_2f64d9815ee346f0 = 0.75;
    var_ecd5026839a30321 = 20;
    var_f18ad91ca56edfb = 50;
    var_1895f82a604e6bff = -60;
    var_1efb9e84685dbe9a = 1000;
    var_5d8bb2291d2855e3 = 5;
    
    while ( true )
    {
        var_f474107e7f2f796f = utility::waittill_any_return( "vehicle_attack_vehicle_boosted_while_latched", "vehicle_attack_vehicle_hard_landing_while_latched", "postpone_stun_attempted_made", "vortex_pull_triggered_while_postponed", "vehicle_attack_knock_off_while_latched_triggered" );
        
        if ( var_f474107e7f2f796f == "vehicle_attack_vehicle_boosted_while_latched" && ( self._blackboard.var_16bcf486107e6291 == "tag_ai_linkto_back_right" || self._blackboard.var_16bcf486107e6291 == "tag_ai_linkto_back_left" ) )
        {
            var_156becde15553d80 = 6;
            var_fbecee60e6514ce1 = 0.1;
            var_844a1a1d37de7caf = 0.25;
            effect_burn::burn( var_156becde15553d80, self.maxhealth * var_fbecee60e6514ce1, var_844a1a1d37de7caf, undefined, "vehicle_attack" );
        }
        
        self._blackboard.var_ad8429be5aa1aa98 = 1;
        var_fa0840395ebde8b2 = var_1895f82a604e6bff;
        targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
        
        if ( isdefined( targetvehicle ) )
        {
            var_20e78682ca8dd695 = anglestoforward( targetvehicle.angles );
            var_d191d946479690ae = targetvehicle vehicle_getvelocity();
            goingforward = vectordot2( var_20e78682ca8dd695, var_d191d946479690ae ) > 0;
            var_56eca11525b622b4 = var_ecd5026839a30321;
            
            if ( self._blackboard.var_ce36df28fb6b0481 == 0 )
            {
                var_660aec4119a5f726 = 1;
            }
            else
            {
                var_660aec4119a5f726 = 0;
            }
            
            var_511cbb08598b621a = self.var_5913e2bda603322d;
            
            if ( goingforward )
            {
                var_cad1dfa207099171 = anglestoforward( targetvehicle.angles ) * -1;
                var_66ee26194fde9950 = anglestoforward( targetvehicle.angles );
                maxspeed = targetvehicle vehicle_gettopspeedforward( 1 );
            }
            else
            {
                var_cad1dfa207099171 = anglestoforward( targetvehicle.angles );
                var_66ee26194fde9950 = -1 * anglestoforward( targetvehicle.angles );
                maxspeed = targetvehicle vehicle_gettopspeedreverse( 1 );
            }
            
            var_e0b8604b928d9a30 = math::lerp_fraction( 0, maxspeed, targetvehicle vehicle_getspeed() );
            var_b9bd708f1e4a80fa = math::lerp( 0, var_56eca11525b622b4, var_e0b8604b928d9a30 );
            
            if ( var_b9bd708f1e4a80fa >= 0.1 )
            {
                self forceteleport( self.origin + var_b9bd708f1e4a80fa * var_66ee26194fde9950, self.angles, var_ecd5026839a30321 + 100, 0 );
            }
            
            var_b0bc9bf3bc14226b = math::lerp( self.var_a070a560568c9817, var_511cbb08598b621a, var_e0b8604b928d9a30 );
            var_b0bc9bf3bc14226b *= randomfloatrange( var_2f64d9815ee346f0, var_52329aa9dd173895 );
            var_218f4f6de8b46b64 = self.origin + var_cad1dfa207099171 * var_f18ad91ca56edfb;
        }
        else
        {
            var_b0bc9bf3bc14226b = self.var_a070a560568c9817;
        }
        
        var_32f508a166900a50 = math::lerp( 400, 800, var_e0b8604b928d9a30 );
        var_5514fcf75920e7cb = math::lerp( 5, 10, var_e0b8604b928d9a30 );
        var_32f508a166900a50 *= randomfloatrange( var_2f64d9815ee346f0, var_52329aa9dd173895 );
        var_5514fcf75920e7cb *= randomfloatrange( var_2f64d9815ee346f0, var_52329aa9dd173895 );
        
        if ( var_f474107e7f2f796f == "vehicle_attack_knock_off_while_latched_triggered" && isdefined( self.var_fd48b9bddc4acff2 ) )
        {
            impactvector = vectornormalize( self.var_fd48b9bddc4acff2 );
            self.var_fd48b9bddc4acff2 = undefined;
        }
        else
        {
            impactvector = vectornormalize( self.origin - var_218f4f6de8b46b64 );
        }
        
        var_95b812f782abbe71 = vectorcross( anglestoup( self.angles ), impactvector );
        impactvector = rotatepointaroundvector( var_95b812f782abbe71, impactvector, getdvarfloat( @"hash_c7faef7ec374607c", var_fa0840395ebde8b2 ) );
        
        /#
            if ( getdvarint( @"hash_707bf29276a1454", 0 ) )
            {
                line( self.origin, self.origin + impactvector * 100, ( 1, 0, 0 ), 1, 0, 10000 );
            }
        #/
        
        if ( self._blackboard.var_ce36df28fb6b0481 != 0 || self._blackboard.var_ce36df28fb6b0481 != 1 )
        {
            self.var_2e90e3ec69c3d892 = self.turnrate;
            self.turnrate = getdvarfloat( @"hash_f1243939cb33d574", var_5d8bb2291d2855e3 );
        }
        
        self unlink();
        zombie_cannonball::cannonball_ai( impactvector, getdvarfloat( @"hash_fd0ac8d0fa455064", var_b0bc9bf3bc14226b ), zombie_cannonball::adv_settings( 1, getdvarfloat( @"hash_6d76045fabfe8493", var_5514fcf75920e7cb ), getdvarint( @"hash_3f48a30af6374630", var_660aec4119a5f726 ), getdvarfloat( @"hash_af3bbb39e5b9bc88", var_32f508a166900a50 ), self function_92794727e5ea36d4() ), "roll_forward" );
        thread function_1273e1b37748a541( var_f474107e7f2f796f );
        thread function_37b1228142b084ce();
    }
}

// Namespace zombie_vehicle_attack
// Params 1, eflags: 0x4
// Checksum 0x32b635ad, Offset: 0x25bf
// Size: 0xa9
function private function_1273e1b37748a541( var_f474107e7f2f796f )
{
    self endon( #"death" );
    var_dbc7bd1946222dea = 8;
    self function_7f8988ce63c1623d( 0 );
    utility::waittill_any_in_array_or_timeout( [ "cannonball_end", "vehicle_attack_end", "vehicle_attack_disabled" ], var_dbc7bd1946222dea );
    
    if ( var_f474107e7f2f796f == "postpone_stun_attempted_made" || var_f474107e7f2f796f == "vortex_pull_triggered_while_postponed" )
    {
        val::reset_all( "vehicle_attack" );
    }
    
    if ( isdefined( self.var_2e90e3ec69c3d892 ) )
    {
        self.turnrate = self.var_2e90e3ec69c3d892;
        self.var_2e90e3ec69c3d892 = undefined;
    }
    
    self function_7f8988ce63c1623d( 1 );
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0xbcbdb26d, Offset: 0x2670
// Size: 0xe3
function private function_66fc966736e6cfb2()
{
    zero_epsilon = 0.1;
    targetvehicle = getentbynum( self._blackboard.var_6d96a0f613c92e11 );
    var_f0c2f9a38dbb31f2 = targetvehicle vehicle_getvelocity();
    
    if ( lengthsquared( var_f0c2f9a38dbb31f2 ) > zero_epsilon )
    {
        var_829a0e3a2dafc28b = 1000;
        var_eaec807aec7340f9 = 2500;
        goingforward = vectordot( anglestoforward( targetvehicle.angles ), var_f0c2f9a38dbb31f2 ) > 0;
        
        if ( goingforward )
        {
            var_f674a71858f539e8 = targetvehicle vehicle_gettopspeedforward();
        }
        else
        {
            var_f674a71858f539e8 = targetvehicle vehicle_gettopspeedreverse();
        }
        
        var_1c583b50d9c6e63b = targetvehicle vehicle_getspeed();
        var_d8056835ed0a54ba = math::lerp_fraction( 0, var_f674a71858f539e8, var_1c583b50d9c6e63b );
        return math::lerp( var_829a0e3a2dafc28b, var_eaec807aec7340f9, var_d8056835ed0a54ba );
    }
    
    return 0;
}

// Namespace zombie_vehicle_attack
// Params 3, eflags: 0x4
// Checksum 0x8a6a7203, Offset: 0x275c
// Size: 0x145
function private function_3ee0a7df24113775( targetvehicle, var_185c753999262991, overridefailsafe )
{
    self endon( #"death" );
    assert( is_vehicle_attack_enabled(), "<dev string:xee>" );
    
    while ( targetvehicle isboosting() || !( targetvehicle function_1dcd1edbad560a45() == targetvehicle function_dd8036d3c66a69c() ) )
    {
        waitframe();
    }
    
    if ( !isdefined( var_185c753999262991 ) )
    {
        var_185c753999262991 = targetvehicle function_e5f885e9f2606921( self );
        
        if ( !isdefined( var_185c753999262991 ) )
        {
            utility::ent_flag_set( "force_vehicle_attack_failed" );
            return;
        }
    }
    
    var_5edf9013579b71a1 = targetvehicle gettagorigin( var_185c753999262991, 1 );
    
    if ( !isdefined( var_5edf9013579b71a1 ) )
    {
        utility::ent_flag_set( "force_vehicle_attack_failed" );
        return;
    }
    
    var_139097223d6bb585 = 0.8;
    deltatime = getdvarfloat( @"hash_905ca9b494f172cf", var_139097223d6bb585 );
    var_7c302c8342d39a63 = targetvehicle vehicle_getvelocity() * deltatime;
    var_5edf9013579b71a1 += var_7c302c8342d39a63;
    
    if ( targetvehicle function_953e26d36d7864d3( self, var_185c753999262991 ) )
    {
        self._blackboard.var_783883e18b402fbd = var_5edf9013579b71a1;
        self._blackboard.var_f920ca5d2ecef3f6 = 1;
        
        if ( !overridefailsafe )
        {
            thread function_16016113ccd3c6a3();
        }
        
        thread function_e936c2edb9521460();
        return;
    }
    
    utility::ent_flag_set( "force_vehicle_attack_failed" );
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0x4c194a9f, Offset: 0x28a9
// Size: 0xf8
function private function_e936c2edb9521460()
{
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 0.5 );
    val::set_array( "force_vehicle_attack", [ "disallow_stun", "disallow_despawn", "disallow_bloat" ], 1 );
    self enabletraversals( 0 );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 0 );
    self function_786bb6aa1b76c7ee( "force_vehicle_attack", 1 );
    self allowvehiclepredictiveragdoll( 0 );
    asm::function_7256f5ba459c840b( "vehicle_attack_leap_loop" );
    
    if ( self._blackboard.var_aa4eac81c28768c4 )
    {
        utility::ent_flag_set( "force_vehicle_attack_succeed" );
        self waittill( #"vehicle_attack_end" );
        utility::ent_flag_clear( "force_vehicle_attack_succeed", 1 );
    }
    else
    {
        utility::ent_flag_set( "force_vehicle_attack_failed" );
    }
    
    if ( isalive( self ) )
    {
        val::reset_all( "force_vehicle_attack" );
        self function_786bb6aa1b76c7ee( "force_vehicle_attack", 0 );
        self enabletraversals( 1 );
        self allowvehiclepredictiveragdoll( 1 );
    }
}

// Namespace zombie_vehicle_attack
// Params 0, eflags: 0x4
// Checksum 0xb6ed1271, Offset: 0x29a9
// Size: 0x5d
function private function_16016113ccd3c6a3()
{
    self endon( #"death" );
    var_cc9aa8604216d417 = 15;
    utility::ent_flag_wait_or_timeout( "force_vehicle_attack_failed", var_cc9aa8604216d417 );
    
    if ( utility::ent_flag( "force_vehicle_attack_failed" ) )
    {
        self.nocorpse = 1;
        self.var_a13bed1ac47e1b2c = 1;
        self hide();
        self kill();
    }
}

// Namespace zombie_vehicle_attack
// Params 4, eflags: 0x4
// Checksum 0x31a3eb96, Offset: 0x2a0e
// Size: 0x1d1
function private function_8690cca06c34faf0( var_5edf9013579b71a1, targetvehicle, var_185c753999262991, var_7c302c8342d39a63 )
{
    var_88f3219c2ffcb7c8 = 300;
    var_63c1b5cdcc63ed48 = 600;
    var_936c34ea780c8be5 = anglestoup( targetvehicle.angles );
    leaporigin = var_5edf9013579b71a1 + var_936c34ea780c8be5 * var_88f3219c2ffcb7c8;
    var_d07b66ae1a81001f = vehicle_occupancy::get_driver( targetvehicle );
    
    if ( isdefined( var_d07b66ae1a81001f ) )
    {
        var_450c3efb1d431e6c = 0.5;
        driverforward = anglestoforward( var_d07b66ae1a81001f getplayerangles() );
        driverup = anglestoup( var_d07b66ae1a81001f getplayerangles() );
        var_59c794421949c23e = vectornormalize( leaporigin - var_d07b66ae1a81001f.origin );
        
        if ( vectordot( driverforward, var_59c794421949c23e ) >= var_450c3efb1d431e6c && vectordot( driverup, var_59c794421949c23e ) >= var_450c3efb1d431e6c )
        {
            var_d4d5bcad62b8af42 = 200;
            leaporigin += var_936c34ea780c8be5 * var_d4d5bcad62b8af42;
        }
    }
    
    var_963c62cde3f52f3c = targetvehicle function_126d7fb137f3a363( var_185c753999262991 );
    
    if ( isdefined( var_963c62cde3f52f3c ) )
    {
        switch ( var_963c62cde3f52f3c )
        {
            case #"hash_4b8799075d3a89b8":
                leaporigin += anglestoforward( targetvehicle.angles ) * var_63c1b5cdcc63ed48;
                break;
            case #"hash_4a4ff8ff23879e3":
                leaporigin += anglestoforward( targetvehicle.angles ) * -1 * var_63c1b5cdcc63ed48;
                break;
            case #"hash_c9b3133a17a3b2d0":
                leaporigin += anglestoleft( targetvehicle.angles ) * var_63c1b5cdcc63ed48;
                break;
            case #"hash_96815ce4f2a3dbc5":
                leaporigin += anglestoright( targetvehicle.angles ) * var_63c1b5cdcc63ed48;
                break;
        }
    }
    
    leaporigin += var_7c302c8342d39a63;
    return leaporigin;
}

