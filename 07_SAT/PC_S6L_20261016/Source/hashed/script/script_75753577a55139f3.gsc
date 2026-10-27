// script_75753577a55139f3  (hash_75753577a55139f3.gscc) (size: 10791 Bytes / 0x2a27 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfee46eb5 (4276383413)
// size ...... 10791 (0x2a27)
// includes .. 10  (offset: 0x285b)
// strings ... 22  (offset: 0x28ab)
// dev strs .. 8   (offset: 0x29c7)
// exports ... 22  (offset: 0x1bb7)
// cseg ...... 0x2d5 + 0x18e2 (0x1bb7)
// imports ... 77  (offset: 0x1f27)
// animtree1 . 0   (offset: 0x2a27)
// animtree2 . 0   (offset: 0x2a27)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;

#namespace namespace_11bfef4f5e98b9a1;

// Namespace namespace_11bfef4f5e98b9a1
// Params 0
// Checksum 0x86d47bcd, Offset: 0x2f3
// Size: 0x42
function function_401e01e15c94ef0()
{
    level callback::add( #"player_laststand_exit", &on_player_last_stand_exit );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_99c318ec735167a1 );
    
    /#
        setup_impact_devgui();
    #/
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 18
// Checksum 0xf10e8393, Offset: 0x33d
// Size: 0x764
function function_55e7322e9409d6cc( hittarget, impactpoint, impactangles, explosionradius, meansofdeath, var_517a63573e636ddc, var_1e4b1025354f2e03, aoeduration, var_aa1bd3e3ba83c8da, explosiontype, var_9a29482565cdec6a, var_eaa02316dd97d1fa, var_2436194f6877f6e7, var_711b6ed01a83e79c, earthquakeradius, earthquakescale, earthquakeduration, var_c4dc08f9e1142ae )
{
    var_86e55fb678d98536 = getdvarfloat( @"hash_b596a28f19b65f39", 35 );
    var_ee282694c7c4ed9b = getdvarfloat( @"hash_792056f7346068af", 420 );
    var_8fb3da75f662707c = getdvarfloat( @"hash_327eec585f3b1ea", 450 );
    var_a85e18f6e2a76eef = 30;
    var_c31dc26c108992f8 = 45;
    var_f0057641911a379a = 300;
    var_d76388e2199bd98f = 500;
    var_e49500098088a667 = 50;
    var_da71431f87bd7a56 = 5;
    var_35556401666852b0 = 15;
    var_6a350cca75460d59 = 175;
    var_88a6a955eda89a58 = 350;
    var_a8d59ae0a2db7d04 = 30;
    var_b562de77c086803 = 5;
    var_8cb4153b0750204 = 150;
    var_628b4763ac0cd5aa = 0.05;
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    
    /#
        self.var_922d3c5790f8469d = spawnstruct();
        self.var_922d3c5790f8469d.var_e5049d59fedd8c2f = impactpoint;
        self.var_922d3c5790f8469d.explosionradius = explosionradius;
    #/
    
    if ( !explosionradius )
    {
        explosionradius = 0;
    }
    
    nearbytargets = getplayersandaiarrayinradius( impactpoint, explosionradius );
    
    if ( nearbytargets.size > 0 )
    {
        /#
            self.var_922d3c5790f8469d.var_fd7d82e053f417e4 = [];
        #/
        
        foreach ( potentialtarget in nearbytargets )
        {
            if ( potentialtarget == self || !isalive( potentialtarget ) )
            {
                continue;
            }
            
            /#
                var_67240c25b30c7645 = spawnstruct();
                var_67240c25b30c7645.entity = potentialtarget;
            #/
            
            var_c46f6b19ec86ff50 = distance( impactpoint, potentialtarget.origin );
            var_a9e6352b74faa839 = math::lerp_fraction( 0, explosionradius, var_c46f6b19ec86ff50 );
            
            if ( isplayer( potentialtarget ) && !potentialtarget.var_f468cf5c9e75db1 )
            {
                if ( !potentialtarget.inlaststand )
                {
                    potentialtarget knockback_player( self, impactpoint, var_a9e6352b74faa839, var_86e55fb678d98536, var_ee282694c7c4ed9b, var_8fb3da75f662707c, var_711b6ed01a83e79c );
                }
                
                if ( !potentialtarget.var_ecbd75d8039c11ed )
                {
                    var_bbf445ae8f4290ea = math::lerp( var_1e4b1025354f2e03, var_517a63573e636ddc, var_a9e6352b74faa839 );
                    
                    if ( isdefined( var_c4dc08f9e1142ae ) )
                    {
                        var_a2c35c2988b870fc = self.var_bd1805e45701eeb1;
                        self.var_bd1805e45701eeb1 = var_c4dc08f9e1142ae;
                    }
                    
                    potentialtarget dodamage( var_bbf445ae8f4290ea, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                    potentialtarget callback::callback( "on_hornet_boss_projectile_vo" );
                    
                    if ( isdefined( var_c4dc08f9e1142ae ) )
                    {
                        self.var_bd1805e45701eeb1 = var_a2c35c2988b870fc;
                    }
                }
                
                potentialtarget function_b831ea031f82655b( var_aa1bd3e3ba83c8da );
                
                /#
                    var_67240c25b30c7645.damagedone = var_bbf445ae8f4290ea;
                #/
            }
            else if ( isai( potentialtarget ) && !isbot( potentialtarget ) )
            {
                if ( var_a9e6352b74faa839 && potentialtarget.aicategory && potentialtarget.maxhealth )
                {
                    var_9e35ed77c5c0c663 = function_f7069e78106a2f3b( var_a9e6352b74faa839, potentialtarget.aicategory, potentialtarget.maxhealth );
                }
                else
                {
                    var_9e35ed77c5c0c663 = 0;
                }
                
                if ( var_9e35ed77c5c0c663 < potentialtarget.health )
                {
                    if ( self.subclass == "zombie_diana_assault_rounds" )
                    {
                        impactmagnitude = math::lerp( var_88a6a955eda89a58, var_6a350cca75460d59, var_a9e6352b74faa839 );
                        var_f186e7fac7ca9a06 = var_35556401666852b0;
                        
                        if ( var_711b6ed01a83e79c )
                        {
                            impactmagnitude += var_a8d59ae0a2db7d04;
                            var_f186e7fac7ca9a06 += var_b562de77c086803;
                        }
                        
                        if ( self.var_4827856486127f11 && distancesquared( self.var_4827856486127f11.tetherpoint, potentialtarget.origin ) > squared( self.var_4827856486127f11.tetherradius - var_8cb4153b0750204 ) )
                        {
                            impactmagnitude *= var_628b4763ac0cd5aa;
                        }
                        
                        if ( impactpoint && impactmagnitude )
                        {
                            potentialtarget zombie_knockdown::function_6fc167d4a3590991( impactpoint, impactmagnitude, var_f186e7fac7ca9a06 );
                        }
                        else
                        {
                            potentialtarget zombie_knockdown::function_6fc167d4a3590991( potentialtarget.origin );
                        }
                    }
                    else
                    {
                        impactmagnitude = math::lerp( var_d76388e2199bd98f, var_f0057641911a379a, var_a9e6352b74faa839 );
                        var_f186e7fac7ca9a06 = var_a85e18f6e2a76eef;
                        
                        if ( var_711b6ed01a83e79c )
                        {
                            impactmagnitude += var_e49500098088a667;
                            var_f186e7fac7ca9a06 += var_da71431f87bd7a56;
                        }
                        
                        if ( impactpoint && impactmagnitude )
                        {
                            potentialtarget zombie_knockdown::function_6fc167d4a3590991( impactpoint, impactmagnitude, var_f186e7fac7ca9a06 );
                        }
                        else
                        {
                            potentialtarget zombie_knockdown::function_6fc167d4a3590991( potentialtarget.origin );
                        }
                    }
                }
                else if ( !potentialtarget.noragdoll && !potentialtarget.script_noragdoll )
                {
                    var_4875c4a245b82147 = vectornormalize2( potentialtarget.origin - impactpoint );
                    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, var_3d21eec29b566ffb );
                    var_62c54acda6801066 = function_c0755281820f7124( var_a9e6352b74faa839, var_c31dc26c108992f8, potentialtarget.subclass, var_711b6ed01a83e79c );
                    
                    if ( isdefined( var_62c54acda6801066 ) )
                    {
                        impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_62c54acda6801066.var_f186e7fac7ca9a06 );
                        impactvector = var_62c54acda6801066.impactmagnitude * impactvector;
                        potentialtarget.ragdollimpactvector = impactvector;
                        potentialtarget.ragdollhitloc = "torso_lower";
                        potentialtarget.forceragdollimmediate = 1;
                    }
                }
                
                potentialtarget dodamage( var_9e35ed77c5c0c663, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                
                /#
                    var_67240c25b30c7645.damagedone = var_9e35ed77c5c0c663;
                #/
            }
            
            /#
                self.var_922d3c5790f8469d.var_fd7d82e053f417e4[ self.var_922d3c5790f8469d.var_fd7d82e053f417e4.size ] = var_67240c25b30c7645;
            #/
        }
    }
    
    level thread function_c0001d9e02173a78( hittarget, impactpoint, impactangles, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.talismanscriptable, explosiontype, var_9a29482565cdec6a, self.var_4549eefb0b9e7f5c );
    function_83c63afddd94519f( impactpoint, earthquakeradius, earthquakescale, earthquakeduration );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    aoepos = impactpoint;
    
    if ( hittarget )
    {
        aoepos = function_ab45d1bf401cb4f2( hittarget );
    }
    
    if ( aoepos && aoeduration > 0 )
    {
        level thread function_3b9d49a506783a2f( self, aoepos, explosionradius, getdvarfloat( @"hash_85eb3f72ec0bd3be", aoeduration ), settings.var_f2f81c951c3ddcf6, self.var_3738d1332f70b824, var_eaa02316dd97d1fa, impactangles, var_2436194f6877f6e7 );
    }
    
    /#
        self notify( #"hash_becec4717328ba85" );
    #/
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 9
// Checksum 0xd72b2e4b, Offset: 0xaa9
// Size: 0x106
function function_3b9d49a506783a2f( diana, impactpoint, impactradius, aoeduration, var_282c03785d72c987, var_4fee331561efd94f, var_eaa02316dd97d1fa, impactangles, var_2436194f6877f6e7 )
{
    self endon( #"death" );
    diana endon( #"hash_989656d7c033290e" );
    var_d10a5443946cf033 = ( 0, 0, 32 );
    
    if ( !utility::ispointinwater( impactpoint - var_d10a5443946cf033 ) )
    {
        thread do_fire_aoe_damage( diana, impactpoint, impactradius, aoeduration, var_282c03785d72c987, var_4fee331561efd94f, var_2436194f6877f6e7 );
        
        if ( var_eaa02316dd97d1fa )
        {
            aoeemitter = spawnscriptable( "scirptable_zombie_diana_necrotic_explosion_aoe", impactpoint, ( 0, impactangles[ 1 ], 0 ) );
            aoeemitter thread function_15095f833ad21fc5( aoeduration );
            
            if ( !isdefined( diana.var_58b19f9c88d4dce1 ) )
            {
                diana.var_58b19f9c88d4dce1 = [];
            }
            
            diana.var_58b19f9c88d4dce1[ diana.var_58b19f9c88d4dce1.size ] = aoeemitter;
        }
    }
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1
// Checksum 0x83b54389, Offset: 0xbb7
// Size: 0x17
function function_2add19745029c412( percentage )
{
    self.var_d0b6b73dcf7b927 = percentage;
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 7, eflags: 0x4
// Checksum 0x9fa489cf, Offset: 0xbd6
// Size: 0x15e
function private knockback_player( diana, impactpoint, var_a9e6352b74faa839, var_2a9889351e7486b5, var_79e488ac9a42aeef, var_5934bd19e6961256, var_711b6ed01a83e79c )
{
    var_4aeeb9d84997af60 = 5;
    var_1afc394f179cf912 = 5;
    var_7303ea7d32dbe7d8 = getdvarfloat( @"hash_14059beed293da67", 10 );
    var_4875c4a245b82147 = vectornormalize2( self.origin - impactpoint );
    
    if ( length( var_4875c4a245b82147 ) <= var_4aeeb9d84997af60 )
    {
        var_4875c4a245b82147 = vectornormalize2( self.origin - diana.origin );
    }
    
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    var_d750b8a81b34edc6 = math::lerp( var_5934bd19e6961256, var_79e488ac9a42aeef, var_a9e6352b74faa839 );
    var_f186e7fac7ca9a06 = var_79e488ac9a42aeef;
    impactmagnitude = var_d750b8a81b34edc6;
    
    if ( var_711b6ed01a83e79c )
    {
        var_f186e7fac7ca9a06 += var_1afc394f179cf912;
        impactmagnitude += var_7303ea7d32dbe7d8;
    }
    
    var_f186e7fac7ca9a06 = getdvarfloat( @"hash_21bfc2f5f654ff20", var_f186e7fac7ca9a06 );
    impactmagnitude = getdvarfloat( @"hash_63a5c8451997935d", impactmagnitude );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_f186e7fac7ca9a06 );
    self knockback( impactvector, impactmagnitude, 1 );
    thread function_fd8e17b0f00a4575( diana );
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1, eflags: 0x4
// Checksum 0x6c757e4c, Offset: 0xd3c
// Size: 0x57
function private function_fd8e17b0f00a4575( diana )
{
    self endon( #"death" );
    var_f07ec2e26d68259f = 0.3;
    wait var_f07ec2e26d68259f;
    
    if ( isalive( self ) )
    {
        while ( !self isonground() )
        {
            waitframe();
        }
    }
    
    if ( isalive( diana ) )
    {
        diana notify( #"stop_current_movement_prediction" );
    }
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1, eflags: 0x4
// Checksum 0x23a45c4b, Offset: 0xd9b
// Size: 0x56
function private function_b831ea031f82655b( var_aa1bd3e3ba83c8da )
{
    if ( var_aa1bd3e3ba83c8da )
    {
        var_62e858c45bbf3f11 = utility::getfx( var_aa1bd3e3ba83c8da );
        
        if ( var_62e858c45bbf3f11 )
        {
            playfxontagforclients( var_62e858c45bbf3f11, self, "j_head", self );
        }
    }
    
    shellshock_utility::_shellshock( %"hash_3e853b61f7d7058a", #"damage", 1.5 );
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 4, eflags: 0x4
// Checksum 0xd8b3f311, Offset: 0xdf9
// Size: 0x70
function private function_83c63afddd94519f( earthquakeorigin, earthquakeradius = 2500, earthquakescale = 0.32, earthquakeduration = 1 )
{
    playrumbleonposition( "zombie_diana_impact_rumble", earthquakeorigin );
    earthquakeadvanced( earthquakescale, earthquakescale / 2, earthquakescale / 4, earthquakeduration, earthquakeorigin, earthquakeradius / 4, earthquakeradius / 2, earthquakeradius );
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1, eflags: 0x4
// Checksum 0x85b5526f, Offset: 0xe71
// Size: 0xe9
function private function_ab45d1bf401cb4f2( hittarget )
{
    var_19f299b8d961af85 = 100;
    talismanscriptable = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.talismanscriptable;
    
    if ( hittarget.type == talismanscriptable )
    {
        return;
    }
    
    groundtrace = trace::ray_trace( hittarget.origin + ( 0, 0, var_19f299b8d961af85 * 2 ), hittarget.origin + ( 0, 0, var_19f299b8d961af85 * -2 ), [ hittarget ], trace::create_solid_ai_contents( 1 ) );
    
    if ( groundtrace[ "hittype" ] != "hittype_none" )
    {
        groundpos = groundtrace[ "position" ];
    }
    
    if ( isdefined( groundpos ) && distancesquared( hittarget.origin, groundpos ) <= squared( var_19f299b8d961af85 ) )
    {
        return groundpos;
    }
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 3, eflags: 0x4
// Checksum 0x56933a1a, Offset: 0xf63
// Size: 0xe3
function private function_f7069e78106a2f3b( var_a9e6352b74faa839, aicategory, aimaxhealth )
{
    var_3d062c4caeee83f5 = 0;
    var_4464483d28d5ab28 = 0;
    var_cd3dffb0a85a0ccb = 0;
    var_f16d1c92848e00d6 = 0;
    var_d360b362e9076b1f = 0;
    var_b8a3a4c15af00b5a = 0;
    
    switch ( aicategory )
    {
        case #"hash_84fcf5e68d7230b2":
            var_3a5935d846b2c9d1 = math::lerp( var_4464483d28d5ab28, var_3d062c4caeee83f5, var_a9e6352b74faa839 );
            break;
        case #"hash_8c089e813083e510":
            var_3a5935d846b2c9d1 = math::lerp( var_f16d1c92848e00d6, var_cd3dffb0a85a0ccb, var_a9e6352b74faa839 );
            break;
        case #"hash_7b0e2f2ed84f34":
        case #"hash_4e47eb6c32f5b165":
            var_3a5935d846b2c9d1 = math::lerp( var_b8a3a4c15af00b5a, var_d360b362e9076b1f, var_a9e6352b74faa839 );
            break;
        default:
            return 0;
    }
    
    return aimaxhealth * var_3a5935d846b2c9d1;
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 5, eflags: 0x4
// Checksum 0x5f9b3769, Offset: 0x104f
// Size: 0x9b
function private function_fadf8488fad97088( aicategory, aimaxhealth, var_5aa28923521af5ac, var_d2fde9b1448a54a2, var_cf516deeb52595c6 )
{
    switch ( aicategory )
    {
        case #"hash_84fcf5e68d7230b2":
            var_3a5935d846b2c9d1 = var_5aa28923521af5ac;
            break;
        case #"hash_8c089e813083e510":
            var_3a5935d846b2c9d1 = var_d2fde9b1448a54a2;
            break;
        case #"hash_7b0e2f2ed84f34":
        case #"hash_4e47eb6c32f5b165":
            var_3a5935d846b2c9d1 = var_cf516deeb52595c6;
            break;
        default:
            return 0;
    }
    
    return aimaxhealth * var_3a5935d846b2c9d1;
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 4, eflags: 0x4
// Checksum 0x3f8f0e90, Offset: 0x10f3
// Size: 0x116
function private function_c0755281820f7124( var_a9e6352b74faa839, var_eefc1cd958515a1, aisubclass, var_711b6ed01a83e79c )
{
    var_c5840a3cd0857b27 = 5500;
    var_d5d9af64d7c392cc = 7000;
    var_1afc394f179cf912 = 5;
    var_2406eace4709b932 = 1.1;
    impactresults = spawnstruct();
    impactresults.var_f186e7fac7ca9a06 = var_eefc1cd958515a1;
    impactresults.impactmagnitude = math::lerp( var_d5d9af64d7c392cc, var_c5840a3cd0857b27, var_a9e6352b74faa839 );
    
    if ( var_711b6ed01a83e79c )
    {
        impactresults.var_f186e7fac7ca9a06 += var_1afc394f179cf912;
        impactresults.impactmagnitude *= var_2406eace4709b932;
    }
    
    impactresults.var_f186e7fac7ca9a06 = getdvarfloat( @"hash_2ff20a2014bfce26", impactresults.var_f186e7fac7ca9a06 );
    impactresults.impactmagnitude = getdvarfloat( @"hash_568e1d9cfb85f06f", impactresults.impactmagnitude );
    return impactresults;
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 7, eflags: 0x4
// Checksum 0xaf01f1e5, Offset: 0x1212
// Size: 0x2bd
function private do_fire_aoe_damage( diana, impactpoint, impactradius, aoeduration, var_282c03785d72c987, var_4fee331561efd94f, var_2436194f6877f6e7 )
{
    self endon( #"death" );
    diana endon( #"hash_989656d7c033290e" );
    var_d524d7d2c0bf4a0e = 3;
    var_601a117a58005cbf = 0;
    var_ca66f99fa07a0092 = [];
    var_602da605170591d4 = diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    var_5aa28923521af5ac = var_602da605170591d4.var_97245944ff32d5de;
    var_d2fde9b1448a54a2 = var_602da605170591d4.var_4e984270e54d0112;
    var_cf516deeb52595c6 = var_602da605170591d4.var_b951c324fc575266;
    var_4fee331561efd94f += diana.var_d0b6b73dcf7b927 ?? 0;
    
    if ( var_2436194f6877f6e7 )
    {
        wait var_2436194f6877f6e7;
    }
    
    while ( var_601a117a58005cbf <= aoeduration )
    {
        wait var_282c03785d72c987;
        var_bf2f73af3187e876 = getplayersandaiarrayinradius( impactpoint, impactradius );
        
        if ( var_bf2f73af3187e876.size > 0 )
        {
            foreach ( var_6cc560bdec891bc1 in var_bf2f73af3187e876 )
            {
                if ( var_6cc560bdec891bc1 == self || var_6cc560bdec891bc1 == diana || !isalive( var_6cc560bdec891bc1 ) || var_6cc560bdec891bc1.var_78e2a20b23c8c44b || var_6cc560bdec891bc1.var_f468cf5c9e75db1 )
                {
                    continue;
                }
                
                if ( isplayer( var_6cc560bdec891bc1 ) && var_6cc560bdec891bc1 function_4d2b71be6a8edbcd( var_d524d7d2c0bf4a0e ) )
                {
                    continue;
                }
                
                if ( isai( var_6cc560bdec891bc1 ) && var_6cc560bdec891bc1.subclass == "zombie_base_armored_agni" )
                {
                    continue;
                }
                
                var_6cc560bdec891bc1.var_78e2a20b23c8c44b = 1;
                var_6cc560bdec891bc1 thread function_e6ac0fa6e210aa66( diana, var_ca66f99fa07a0092, impactpoint, impactradius, var_282c03785d72c987, var_4fee331561efd94f, var_5aa28923521af5ac, var_d2fde9b1448a54a2, var_cf516deeb52595c6 );
                var_ca66f99fa07a0092 = arraycombineunique( var_ca66f99fa07a0092, [ var_6cc560bdec891bc1 ] );
            }
        }
        
        var_601a117a58005cbf += var_282c03785d72c987;
    }
    
    var_ca66f99fa07a0092 = function_5713d46873b29625( var_ca66f99fa07a0092 );
    
    foreach ( var_4a3a98fe3a71633f in var_ca66f99fa07a0092 )
    {
        var_4a3a98fe3a71633f.var_78e2a20b23c8c44b = undefined;
        var_4a3a98fe3a71633f notify( #"aoe_ended" );
    }
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1, eflags: 0x4
// Checksum 0x2f63b0c1, Offset: 0x14d7
// Size: 0x1d
function private on_player_last_stand_exit( params )
{
    if ( self )
    {
        self.var_d038f47bb6f52e3d = gettime();
    }
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1, eflags: 0x4
// Checksum 0x307f1249, Offset: 0x14fc
// Size: 0x3f, Type: bool
function private function_4d2b71be6a8edbcd( seconds )
{
    if ( player::isinlaststand( self ) )
    {
        return true;
    }
    
    if ( !self.var_d038f47bb6f52e3d )
    {
        return false;
    }
    
    return gettime() - self.var_d038f47bb6f52e3d <= utility::function_4b74c15943231980( seconds );
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1, eflags: 0x4
// Checksum 0x574b0a02, Offset: 0x1544
// Size: 0x9d
function private function_99c318ec735167a1( params )
{
    level callback::remove( #"player_laststand_exit", &on_player_last_stand_exit );
    
    foreach ( player in level.players )
    {
        player.var_d038f47bb6f52e3d = undefined;
    }
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 9, eflags: 0xc
// Checksum 0xd862430e, Offset: 0x15e9
// Size: 0x1e1
function private function_e6ac0fa6e210aa66( diana, var_ca66f99fa07a0092, impactpoint, impactradius, var_282c03785d72c987, var_4fee331561efd94f, var_5aa28923521af5ac, var_d2fde9b1448a54a2, var_cf516deeb52595c6 )
{
    self notify( #"hash_acbd4dec84c210ad" );
    self endon( #"hash_acbd4dec84c210ad" );
    self endon( #"death" );
    self endon( #"aoe_ended" );
    diana endon( #"hash_989656d7c033290e" );
    var_51283d41fa0e955f = 1.5;
    targetisplayer = isplayer( self );
    
    while ( isalive( self ) )
    {
        if ( player::isinlaststand( self ) || distance( self.origin, impactpoint ) > impactradius )
        {
            self.var_78e2a20b23c8c44b = 0;
            var_ca66f99fa07a0092 = arrayremove( var_ca66f99fa07a0092, self );
            return;
        }
        
        if ( targetisplayer )
        {
            var_83f09e90ed5be5d0 = utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) && self issprintsliding();
            
            if ( !var_83f09e90ed5be5d0 )
            {
                thread damage_effects::enableburnfxfortime( var_51283d41fa0e955f );
                var_7c58356b77ac7472 = self.maxhealth * var_4fee331561efd94f * 0.01;
            }
            else
            {
                var_7c58356b77ac7472 = 0;
            }
        }
        else if ( isai( self ) && self.type == "zombie" )
        {
            callback::callback( "burned" );
            var_7c58356b77ac7472 = function_fadf8488fad97088( self.aicategory, self.maxhealth, var_5aa28923521af5ac, var_d2fde9b1448a54a2, var_cf516deeb52595c6 );
        }
        
        if ( var_7c58356b77ac7472 )
        {
            diana.ignore_turtle_shell = 1;
            self dodamage( var_7c58356b77ac7472, impactpoint, diana, diana, "MOD_EXPLOSIVE", undefined, "torso_upper" );
            diana.ignore_turtle_shell = 0;
        }
        
        wait var_282c03785d72c987;
    }
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 1, eflags: 0x4
// Checksum 0x889633a8, Offset: 0x17d2
// Size: 0x42
function private function_15095f833ad21fc5( aoeduration )
{
    self endon( #"death" );
    aoeemitter = self;
    aoeemitter utility::function_32b24db3127bff40( "impact", "impact" );
    wait aoeduration;
    aoeemitter freescriptable();
}

// Namespace namespace_11bfef4f5e98b9a1
// Params 7, eflags: 0x4
// Checksum 0xb115a9c0, Offset: 0x181c
// Size: 0x10a
function private function_c0001d9e02173a78( hittarget, impactpos, impactangles, talismanscriptable, explosiontype, var_9a29482565cdec6a, var_4549eefb0b9e7f5c )
{
    if ( hittarget.type != talismanscriptable )
    {
        if ( explosiontype )
        {
            switch ( explosiontype )
            {
                case #"hash_5d0c21623119c1e8":
                    projectileimpact = spawnscriptable( "scriptable_zombie_diana_necrotic_beam_post_explosion_ground_impact", impactpos, ( 0, impactangles[ 1 ], 0 ) );
                    break;
                case #"hash_ef2aa4f3e976b684":
                    projectileimpact = spawnscriptable( "scriptable_zombie_diana_necrotic_projectile_ground_impact", impactpos, ( 0, impactangles[ 1 ], 0 ) );
                    break;
            }
        }
        else if ( var_9a29482565cdec6a )
        {
            projectileimpact = spawnscriptable( "scriptable_zombie_diana_summon_agni_zombies_ground_impact", impactpos, ( 0, impactangles[ 1 ], 0 ) );
            
            if ( var_4549eefb0b9e7f5c )
            {
                projectileimpact setscriptablepartstate( "vfx", "impact_decal", 0 );
            }
            else
            {
                projectileimpact setscriptablepartstate( "vfx", "impact", 0 );
            }
        }
        
        wait 3;
        
        if ( isdefined( projectileimpact ) )
        {
            projectileimpact freescriptable();
        }
    }
}

/#

    // Namespace namespace_11bfef4f5e98b9a1
    // Params 0
    // Checksum 0xb56288be, Offset: 0x192e
    // Size: 0x30, Type: dev
    function setup_impact_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3b>", "<dev string:x61>", &function_dd2974f255303631, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_11bfef4f5e98b9a1
    // Params 0, eflags: 0x4
    // Checksum 0xdeba8657, Offset: 0x1966
    // Size: 0x251, Type: dev
    function private function_dd2974f255303631()
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x87>" );
        
        if ( isdefined( diana ) )
        {
            assert( isdefined( diana.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x94>" );
            
            while ( true )
            {
                if ( !isalive( diana ) )
                {
                    return;
                }
                
                diana waittill( #"hash_becec4717328ba85" );
                
                if ( isdefined( diana.var_922d3c5790f8469d ) )
                {
                    print3d( diana.var_922d3c5790f8469d.var_e5049d59fedd8c2f + ( 0, 0, 1 ) * 60, "<dev string:x108>", ( 0, 0, 1 ), 1, 1, 100, 1 );
                    utility::draw_circle( diana.var_922d3c5790f8469d.var_e5049d59fedd8c2f, diana.var_922d3c5790f8469d.explosionradius, ( 0, 0, 1 ), 5, 0, 100 );
                    
                    if ( isdefined( diana.var_922d3c5790f8469d.var_fd7d82e053f417e4 ) )
                    {
                        foreach ( hitent in diana.var_922d3c5790f8469d.var_fd7d82e053f417e4 )
                        {
                            print3d( hitent.entity.origin + ( 0, 0, 1 ) * 60, "<dev string:x119>" + hitent.damagedone, ( 1, 0, 0 ), 1, 1, 100, 1 );
                            
                            if ( isplayer( hitent ) )
                            {
                                print3d( hitent.entity.origin + ( 0, 0, 1 ) * 30, "<dev string:x136>" + hitent.knockbackdone, ( 1, 1, 0 ), 1, 1, 100, 1 );
                            }
                        }
                    }
                }
            }
        }
    }

#/
