// script_670486d63d6d8151  (hash_670486d63d6d8151.gscc) (size: 15424 Bytes / 0x3c40 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b8bff53 (999030611)
// size ...... 15424 (0x3c40)
// includes .. 10  (offset: 0x399c)
// strings ... 21  (offset: 0x39ec)
// dev strs .. 17  (offset: 0x3b5c)
// exports ... 22  (offset: 0x2af0)
// cseg ...... 0x19b + 0x2955 (0x2af0)
// imports ... 84  (offset: 0x2e60)
// animtree1 . 0   (offset: 0x3c40)
// animtree2 . 0   (offset: 0x3c40)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;

#namespace zombie_triton_impact;

/#

    // Namespace zombie_triton_impact
    // Params 0
    // Checksum 0xd3932bad, Offset: 0x1b9
    // Size: 0xc, Type: dev
    function init_zombie_triton_impact_global()
    {
        setup_impact_devgui();
    }

#/

// Namespace zombie_triton_impact
// Params 15
// Checksum 0x731cd3c4, Offset: 0x1cd
// Size: 0x1cb
function cone_ground_impact( impacttag, var_97b2e397e7f1348b, var_7192c543c3470e3, var_3f9fe6c6d730bba8, meansofdeath, var_9d79012b222762f2, var_120cfe48deb4e179, var_af9597b6a65b7155, var_aa1bd3e3ba83c8da, var_6d1edf3884cdc1b9, var_d4822cab8dc54371, var_5e4471d7f85ee1a3, earthquakeradius, earthquakescale, earthquakeduration )
{
    self.var_7eb791e627c0827a = spawnstruct();
    var_e5049d59fedd8c2f = self gettagorigin( impacttag );
    var_461c7c1c2e0c60b8 = ( 0, 0, 1 );
    upvec = ( 0, 0, 1 );
    var_fce76671139699d8 = var_e5049d59fedd8c2f + upvec * 150;
    var_435031c0d74dddad = var_e5049d59fedd8c2f + -1 * upvec * 150;
    groundtrace = trace::ray_trace( var_fce76671139699d8, var_435031c0d74dddad, [ self ], trace::create_solid_ai_contents( 1 ) );
    
    if ( groundtrace[ "hittype" ] != "hittype_none" )
    {
        var_e5049d59fedd8c2f = groundtrace[ "position" ];
    }
    
    self.var_7eb791e627c0827a.var_e5049d59fedd8c2f = var_e5049d59fedd8c2f;
    self.var_7eb791e627c0827a.var_c26923e1209fc556 = var_97b2e397e7f1348b;
    self.var_7eb791e627c0827a.var_a446d18d52c29458 = var_7192c543c3470e3;
    self.var_7eb791e627c0827a.var_3f9fe6c6d730bba8 = var_3f9fe6c6d730bba8;
    function_45e975a74f3be330( var_e5049d59fedd8c2f, var_461c7c1c2e0c60b8, var_97b2e397e7f1348b, var_7192c543c3470e3, var_3f9fe6c6d730bba8, meansofdeath, var_120cfe48deb4e179, var_9d79012b222762f2, var_af9597b6a65b7155, var_6d1edf3884cdc1b9, var_aa1bd3e3ba83c8da, var_d4822cab8dc54371 );
    
    if ( var_5e4471d7f85ee1a3 )
    {
        function_83c63afddd94519f( var_e5049d59fedd8c2f, earthquakeradius, earthquakescale, earthquakeduration );
    }
    
    return self.var_7eb791e627c0827a;
}

// Namespace zombie_triton_impact
// Params 12, eflags: 0x4
// Checksum 0x4270797d, Offset: 0x3a1
// Size: 0x588
function private function_45e975a74f3be330( var_e5049d59fedd8c2f, var_461c7c1c2e0c60b8, var_97b2e397e7f1348b, var_7192c543c3470e3, var_3f9fe6c6d730bba8, meansofdeath, var_120cfe48deb4e179, var_9d79012b222762f2, var_af9597b6a65b7155, var_6d1edf3884cdc1b9, var_aa1bd3e3ba83c8da, var_d4822cab8dc54371 )
{
    assert( var_120cfe48deb4e179 >= var_9d79012b222762f2, "<dev string:x24>" );
    var_22eac80331ed2eac = 650;
    var_f0057641911a379a = 300;
    var_d76388e2199bd98f = 500;
    var_fc001b893dc5e0db = 450;
    var_9bb6838a78485cf2 = 650;
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    forwardvec = anglestoforward( self.angles );
    var_db5242bb093c758 = var_97b2e397e7f1348b / 2;
    var_bf2f73af3187e876 = getplayersandaiarrayinradius( var_e5049d59fedd8c2f, var_7192c543c3470e3 );
    
    if ( var_bf2f73af3187e876.size > 0 )
    {
        self.var_7eb791e627c0827a.var_fd7d82e053f417e4 = [];
        var_61a4008a62ed656d = [ var_3f9fe6c6d730bba8, var_7192c543c3470e3 ];
        playerdamagerange = [ var_9d79012b222762f2, var_120cfe48deb4e179 ];
        
        foreach ( potentialtarget in var_bf2f73af3187e876 )
        {
            if ( potentialtarget == self || !isalive( potentialtarget ) )
            {
                continue;
            }
            
            hittarget = spawnstruct();
            hittarget.entity = potentialtarget;
            targetisplayer = isplayer( potentialtarget );
            var_98b588afcbfea21e = distance( var_e5049d59fedd8c2f, potentialtarget.origin );
            
            if ( var_98b588afcbfea21e < var_3f9fe6c6d730bba8 )
            {
                hittarget.damagedone = potentialtarget.maxhealth;
                
                if ( isai( potentialtarget ) && potentialtarget.type == "zombie" )
                {
                    potentialtarget.forceannihilate = 1;
                    potentialtarget kill();
                }
                else if ( targetisplayer && !player::isinlaststand( potentialtarget ) )
                {
                    potentialtarget knockback_player( self, var_e5049d59fedd8c2f, 1, var_22eac80331ed2eac, var_22eac80331ed2eac, undefined, undefined, var_d4822cab8dc54371 );
                    potentialtarget dodamage( potentialtarget.maxhealth, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                }
            }
            
            var_4875c4a245b82147 = vectornormalize2( potentialtarget.origin - var_e5049d59fedd8c2f );
            var_ce750d520d5f4faa = vectortoyaw( forwardvec );
            var_205623dae80afe47 = vectortoyaw( var_4875c4a245b82147 );
            
            if ( abs( var_ce750d520d5f4faa - var_205623dae80afe47 ) > var_db5242bb093c758 )
            {
                continue;
            }
            
            if ( var_98b588afcbfea21e > var_3f9fe6c6d730bba8 && var_98b588afcbfea21e <= var_7192c543c3470e3 )
            {
                var_a9e6352b74faa839 = math::lerp_fraction( var_61a4008a62ed656d[ 0 ], var_61a4008a62ed656d[ 1 ], var_98b588afcbfea21e );
                
                if ( !targetisplayer )
                {
                    var_9e35ed77c5c0c663 = function_e7b2933ee390e524( var_a9e6352b74faa839, potentialtarget.aicategory, potentialtarget.maxhealth );
                    
                    if ( var_9e35ed77c5c0c663 < potentialtarget.health )
                    {
                        impactmagnitude = math::lerp( var_d76388e2199bd98f, var_f0057641911a379a, var_a9e6352b74faa839 );
                        var_f186e7fac7ca9a06 = 30;
                        
                        if ( var_d4822cab8dc54371 )
                        {
                            impactmagnitude *= 0.5;
                            var_f186e7fac7ca9a06 -= 15;
                            
                            if ( var_f186e7fac7ca9a06 < 1 )
                            {
                                var_f186e7fac7ca9a06 = 1;
                            }
                        }
                        
                        potentialtarget zombie_knockdown::function_6fc167d4a3590991( var_e5049d59fedd8c2f, impactmagnitude, var_f186e7fac7ca9a06 );
                    }
                    else if ( !potentialtarget.noragdoll && !potentialtarget.script_noragdoll )
                    {
                        var_4875c4a245b82147 = vectornormalize2( potentialtarget.origin - var_e5049d59fedd8c2f );
                        var_49942a609994af62 = vectorcross( var_4875c4a245b82147, var_3d21eec29b566ffb );
                        var_62c54acda6801066 = function_c0755281820f7124( var_a9e6352b74faa839, potentialtarget.subclass, 0, undefined, undefined, var_d4822cab8dc54371 );
                        
                        if ( isdefined( var_62c54acda6801066 ) )
                        {
                            impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_62c54acda6801066.var_f186e7fac7ca9a06 );
                            impactvector = var_62c54acda6801066.impactmagnitude * impactvector;
                            potentialtarget.ragdollimpactvector = impactvector;
                            potentialtarget.ragdollhitloc = "torso_lower";
                            potentialtarget.forceragdollimmediate = 1;
                        }
                    }
                }
                else if ( !player::isinlaststand( potentialtarget ) )
                {
                    potentialtarget knockback_player( self, var_e5049d59fedd8c2f, var_a9e6352b74faa839, var_fc001b893dc5e0db, var_9bb6838a78485cf2, undefined, undefined, var_d4822cab8dc54371 );
                }
                
                if ( !targetisplayer )
                {
                    potentialtarget dodamage( var_9e35ed77c5c0c663, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                    hittarget.damagedone = var_9e35ed77c5c0c663;
                }
                else
                {
                    var_bbf445ae8f4290ea = math::lerp( playerdamagerange[ 1 ], playerdamagerange[ 0 ], var_a9e6352b74faa839 );
                    potentialtarget dodamage( var_bbf445ae8f4290ea, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                    hittarget.damagedone = var_bbf445ae8f4290ea;
                    
                    if ( isdefined( var_aa1bd3e3ba83c8da ) )
                    {
                        potentialtarget function_b831ea031f82655b( var_aa1bd3e3ba83c8da );
                    }
                }
            }
            
            self.var_7eb791e627c0827a.var_fd7d82e053f417e4[ self.var_7eb791e627c0827a.var_fd7d82e053f417e4.size ] = hittarget;
        }
    }
    
    function_16446293c4fe6111( var_e5049d59fedd8c2f, var_461c7c1c2e0c60b8, var_af9597b6a65b7155, var_6d1edf3884cdc1b9 );
    self notify( #"hash_c01b3baee08c531c" );
}

// Namespace zombie_triton_impact
// Params 17
// Checksum 0x1286af77, Offset: 0x931
// Size: 0x1de
function radius_ground_impact( impacttag, var_cf13477fe2b9fc7d, var_3f9fe6c6d730bba8, meansofdeath, var_9d79012b222762f2, var_120cfe48deb4e179, var_af9597b6a65b7155, var_aa1bd3e3ba83c8da, var_6d1edf3884cdc1b9, var_e1446af35adad414, var_7e35dcd68c0f35a5, var_711b6ed01a83e79c, var_d4822cab8dc54371, var_5e4471d7f85ee1a3, earthquakeradius, earthquakescale, earthquakeduration )
{
    self.var_d368de47f50cccdf = spawnstruct();
    
    if ( isdefined( impacttag ) )
    {
        var_e5049d59fedd8c2f = self gettagorigin( impacttag );
    }
    else
    {
        var_e5049d59fedd8c2f = self.origin;
    }
    
    var_461c7c1c2e0c60b8 = ( 0, 0, 1 );
    upvec = ( 0, 0, 1 );
    var_fce76671139699d8 = var_e5049d59fedd8c2f + upvec * 150;
    var_435031c0d74dddad = var_e5049d59fedd8c2f + -1 * upvec * 150;
    groundtrace = trace::ray_trace( var_fce76671139699d8, var_435031c0d74dddad, [ self ], trace::create_solid_ai_contents( 1 ) );
    
    if ( groundtrace[ "hittype" ] != "hittype_none" )
    {
        var_e5049d59fedd8c2f = groundtrace[ "position" ];
    }
    
    self.var_d368de47f50cccdf.var_e5049d59fedd8c2f = var_e5049d59fedd8c2f;
    self.var_d368de47f50cccdf.var_cf13477fe2b9fc7d = var_cf13477fe2b9fc7d;
    self.var_d368de47f50cccdf.var_3f9fe6c6d730bba8 = var_3f9fe6c6d730bba8;
    function_88db0e7321a49fb3( var_e5049d59fedd8c2f, var_461c7c1c2e0c60b8, var_cf13477fe2b9fc7d, var_3f9fe6c6d730bba8, meansofdeath, var_120cfe48deb4e179, var_9d79012b222762f2, var_af9597b6a65b7155, var_6d1edf3884cdc1b9, var_aa1bd3e3ba83c8da, var_e1446af35adad414, var_7e35dcd68c0f35a5, var_711b6ed01a83e79c, var_d4822cab8dc54371 );
    
    if ( var_5e4471d7f85ee1a3 )
    {
        function_83c63afddd94519f( var_e5049d59fedd8c2f, earthquakeradius, earthquakescale, earthquakeduration );
    }
    
    return self.var_d368de47f50cccdf;
}

// Namespace zombie_triton_impact
// Params 14, eflags: 0x4
// Checksum 0x74c78ce2, Offset: 0xb18
// Size: 0x63b
function private function_88db0e7321a49fb3( var_e5049d59fedd8c2f, var_461c7c1c2e0c60b8, var_cf13477fe2b9fc7d, var_3f9fe6c6d730bba8, meansofdeath, var_120cfe48deb4e179, var_9d79012b222762f2, var_af9597b6a65b7155, var_6d1edf3884cdc1b9, var_aa1bd3e3ba83c8da, var_e1446af35adad414, var_7e35dcd68c0f35a5, var_711b6ed01a83e79c, var_d4822cab8dc54371 )
{
    assert( var_120cfe48deb4e179 >= var_9d79012b222762f2, "<dev string:x24>" );
    var_2db69aa19c96651c = 0.6;
    var_22eac80331ed2eac = 650;
    var_f0057641911a379a = 300;
    var_d76388e2199bd98f = 500;
    var_fc001b893dc5e0db = 450;
    var_9bb6838a78485cf2 = 650;
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    var_bf2f73af3187e876 = getplayersandaiarrayinradius( var_e5049d59fedd8c2f, var_cf13477fe2b9fc7d );
    
    if ( var_bf2f73af3187e876.size > 0 )
    {
        self.var_d368de47f50cccdf.var_fd7d82e053f417e4 = [];
        var_61a4008a62ed656d = [ var_3f9fe6c6d730bba8, var_cf13477fe2b9fc7d ];
        playerdamagerange = [ var_9d79012b222762f2, var_120cfe48deb4e179 ];
        
        foreach ( potentialtarget in var_bf2f73af3187e876 )
        {
            if ( potentialtarget == self || !isalive( potentialtarget ) )
            {
                continue;
            }
            
            var_468e8ef6f7d52c3f = 0;
            
            if ( isdefined( var_e1446af35adad414 ) || isdefined( var_7e35dcd68c0f35a5 ) )
            {
                forwardvec = anglestoforward( self.angles );
                var_4875c4a245b82147 = vectornormalize2( potentialtarget.origin - var_e5049d59fedd8c2f );
                var_ce750d520d5f4faa = vectortoyaw( forwardvec );
                var_205623dae80afe47 = vectortoyaw( var_4875c4a245b82147 );
                
                if ( isdefined( var_e1446af35adad414 ) )
                {
                    var_db5242bb093c758 = var_e1446af35adad414 / 2;
                    
                    if ( abs( var_ce750d520d5f4faa - var_205623dae80afe47 ) <= var_db5242bb093c758 )
                    {
                        var_468e8ef6f7d52c3f = 1;
                    }
                }
                
                if ( isdefined( var_7e35dcd68c0f35a5 ) )
                {
                    var_db5242bb093c758 = var_7e35dcd68c0f35a5 / 2;
                    
                    if ( abs( var_ce750d520d5f4faa - var_205623dae80afe47 ) <= var_db5242bb093c758 )
                    {
                        continue;
                    }
                }
            }
            
            hittarget = spawnstruct();
            hittarget.entity = potentialtarget;
            targetisplayer = isplayer( potentialtarget );
            var_98b588afcbfea21e = distance( var_e5049d59fedd8c2f, potentialtarget.origin );
            
            if ( var_98b588afcbfea21e < var_3f9fe6c6d730bba8 )
            {
                hittarget.damagedone = potentialtarget.maxhealth;
                
                if ( isai( potentialtarget ) && potentialtarget.type == "zombie" )
                {
                    potentialtarget.forceannihilate = 1;
                    potentialtarget kill();
                }
                else if ( targetisplayer && !player::isinlaststand( potentialtarget ) )
                {
                    potentialtarget knockback_player( self, var_e5049d59fedd8c2f, 1, var_22eac80331ed2eac, var_22eac80331ed2eac, var_e1446af35adad414, var_711b6ed01a83e79c, var_d4822cab8dc54371 );
                    potentialtarget dodamage( potentialtarget.maxhealth, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                }
            }
            else if ( var_98b588afcbfea21e > var_3f9fe6c6d730bba8 && var_98b588afcbfea21e <= var_cf13477fe2b9fc7d )
            {
                var_a9e6352b74faa839 = math::lerp_fraction( var_61a4008a62ed656d[ 0 ], var_61a4008a62ed656d[ 1 ], var_98b588afcbfea21e );
                
                if ( !targetisplayer )
                {
                    var_9e35ed77c5c0c663 = function_e7b2933ee390e524( var_a9e6352b74faa839, potentialtarget.aicategory, potentialtarget.maxhealth, var_e1446af35adad414 );
                    
                    if ( var_9e35ed77c5c0c663 < potentialtarget.health )
                    {
                        impactmagnitude = math::lerp( var_d76388e2199bd98f, var_f0057641911a379a, var_a9e6352b74faa839 );
                        var_f186e7fac7ca9a06 = 30;
                        
                        if ( var_468e8ef6f7d52c3f )
                        {
                            impactmagnitude += 80;
                            var_f186e7fac7ca9a06 += 5;
                        }
                        
                        if ( var_711b6ed01a83e79c )
                        {
                            impactmagnitude += 80;
                            var_f186e7fac7ca9a06 += 5;
                        }
                        
                        if ( var_d4822cab8dc54371 )
                        {
                            impactmagnitude *= 0.5;
                            var_f186e7fac7ca9a06 -= 15;
                            
                            if ( var_f186e7fac7ca9a06 < 1 )
                            {
                                var_f186e7fac7ca9a06 = 1;
                            }
                        }
                        
                        potentialtarget zombie_knockdown::function_6fc167d4a3590991( var_e5049d59fedd8c2f, impactmagnitude, var_f186e7fac7ca9a06 );
                    }
                    else if ( !potentialtarget.noragdoll && !potentialtarget.script_noragdoll )
                    {
                        var_4875c4a245b82147 = vectornormalize2( potentialtarget.origin - var_e5049d59fedd8c2f );
                        var_49942a609994af62 = vectorcross( var_4875c4a245b82147, var_3d21eec29b566ffb );
                        var_62c54acda6801066 = function_c0755281820f7124( var_a9e6352b74faa839, potentialtarget.subclass, 0, var_468e8ef6f7d52c3f, var_711b6ed01a83e79c, var_d4822cab8dc54371 );
                        
                        if ( isdefined( var_62c54acda6801066 ) )
                        {
                            impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_62c54acda6801066.var_f186e7fac7ca9a06 );
                            impactvector = var_62c54acda6801066.impactmagnitude * impactvector;
                            potentialtarget.ragdollimpactvector = impactvector;
                            potentialtarget.ragdollhitloc = "torso_lower";
                            potentialtarget.forceragdollimmediate = 1;
                        }
                    }
                }
                else if ( !player::isinlaststand( potentialtarget ) )
                {
                    potentialtarget knockback_player( self, var_e5049d59fedd8c2f, var_a9e6352b74faa839, var_fc001b893dc5e0db, var_9bb6838a78485cf2, var_468e8ef6f7d52c3f, var_711b6ed01a83e79c, var_d4822cab8dc54371 );
                }
                
                if ( !targetisplayer )
                {
                    potentialtarget dodamage( var_9e35ed77c5c0c663, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                    hittarget.damagedone = var_9e35ed77c5c0c663;
                }
                else
                {
                    var_bbf445ae8f4290ea = math::lerp( playerdamagerange[ 1 ], playerdamagerange[ 0 ], var_a9e6352b74faa839 );
                    
                    if ( var_468e8ef6f7d52c3f )
                    {
                        var_bbf445ae8f4290ea *= 1.05;
                    }
                    
                    potentialtarget dodamage( var_bbf445ae8f4290ea, self.origin, self, self, meansofdeath, undefined, "torso_upper" );
                    hittarget.damagedone = var_bbf445ae8f4290ea;
                    
                    if ( isdefined( var_aa1bd3e3ba83c8da ) )
                    {
                        potentialtarget function_b831ea031f82655b( var_aa1bd3e3ba83c8da );
                    }
                }
            }
            
            self.var_d368de47f50cccdf.var_fd7d82e053f417e4[ self.var_d368de47f50cccdf.var_fd7d82e053f417e4.size ] = hittarget;
        }
    }
    
    if ( isdefined( var_af9597b6a65b7155 ) && isdefined( var_6d1edf3884cdc1b9 ) )
    {
        function_16446293c4fe6111( var_e5049d59fedd8c2f, var_461c7c1c2e0c60b8, var_af9597b6a65b7155, var_6d1edf3884cdc1b9 );
    }
    
    self notify( #"hash_c01b3baee08c531c" );
}

// Namespace zombie_triton_impact
// Params 1, eflags: 0x4
// Checksum 0xd8f1c97b, Offset: 0x115b
// Size: 0x51
function private function_b831ea031f82655b( var_aa1bd3e3ba83c8da )
{
    var_62e858c45bbf3f11 = utility::getfx( var_aa1bd3e3ba83c8da );
    
    if ( var_62e858c45bbf3f11 )
    {
        playfxontagforclients( var_62e858c45bbf3f11, self, "j_head", self );
    }
    
    shellshock_utility_cpmp::_shellshock( %"shock_zombie_triton_impact", #"damage", 1.5 );
}

// Namespace zombie_triton_impact
// Params 4, eflags: 0x4
// Checksum 0x4e81787f, Offset: 0x11b4
// Size: 0x70
function private function_83c63afddd94519f( earthquakeorigin, earthquakeradius = 2500, earthquakescale = 0.32, earthquakeduration = 1 )
{
    playrumbleonposition( "zombie_triton_impact_rumble", earthquakeorigin );
    earthquakeadvanced( earthquakescale, earthquakescale / 2, earthquakescale / 4, earthquakeduration, earthquakeorigin, earthquakeradius / 4, earthquakeradius / 2, earthquakeradius );
}

// Namespace zombie_triton_impact
// Params 4, eflags: 0x4
// Checksum 0x9ef6b669, Offset: 0x122c
// Size: 0x94
function private function_16446293c4fe6111( impactpos, impactnormal, var_af9597b6a65b7155, var_6d1edf3884cdc1b9 )
{
    var_62e858c45bbf3f11 = utility::getfx( var_af9597b6a65b7155 );
    forwardvec = anglestoforward( self.angles );
    
    if ( var_62e858c45bbf3f11 )
    {
        playfx( var_62e858c45bbf3f11, impactpos, forwardvec, impactnormal );
    }
    
    if ( isdefined( level._effect[ var_6d1edf3884cdc1b9 ] ) )
    {
        var_9b5e47b8f9db8ee8 = utility::getfx( var_6d1edf3884cdc1b9 );
        
        if ( var_9b5e47b8f9db8ee8 )
        {
            playfx( var_9b5e47b8f9db8ee8, impactpos, forwardvec, impactnormal );
        }
    }
}

// Namespace zombie_triton_impact
// Params 5
// Checksum 0xcf06933b, Offset: 0x12c8
// Size: 0x11d
function line_ground_impact( impacttag, var_2c4102e84c8e0a8d, var_778af70bfd34a9a3, var_e066d2877802cb7a, var_f13dc378ca06868b )
{
    var_5c70ef44a77fe13e = 0.45;
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    var_e5049d59fedd8c2f = self gettagorigin( impacttag );
    var_461c7c1c2e0c60b8 = var_3d21eec29b566ffb;
    var_fce76671139699d8 = var_e5049d59fedd8c2f + var_3d21eec29b566ffb * 150;
    var_435031c0d74dddad = var_e5049d59fedd8c2f + -1 * var_3d21eec29b566ffb * 150;
    groundtrace = trace::ray_trace( var_fce76671139699d8, var_435031c0d74dddad, [ self ], trace::create_solid_ai_contents( 1 ) );
    
    if ( groundtrace[ "hittype" ] != "hittype_none" )
    {
        var_e5049d59fedd8c2f = groundtrace[ "position" ];
    }
    
    if ( vectordot( var_461c7c1c2e0c60b8, var_3d21eec29b566ffb ) >= var_5c70ef44a77fe13e )
    {
        var_ccbd7328bbe4384 = spawnscriptable( "scriptable_zombie_triton_ground_slam_line_impact", var_e5049d59fedd8c2f, self.angles );
        var_ccbd7328bbe4384 thread function_5f4db388ae6a3476( self, var_e5049d59fedd8c2f, var_461c7c1c2e0c60b8, var_2c4102e84c8e0a8d, var_778af70bfd34a9a3, var_e066d2877802cb7a, var_f13dc378ca06868b );
    }
    
    return var_e5049d59fedd8c2f;
}

// Namespace zombie_triton_impact
// Params 5
// Checksum 0x13ec7f55, Offset: 0x13ee
// Size: 0x18e
function do_fire_aoe_damage( attacker, var_c3c9f29969d5d817, var_cc682460b6c05565, impactorigin, aoeradius )
{
    self endon( #"death" );
    var_601a117a58005cbf = 0;
    var_b2bae9873f67716 = 0.25;
    
    while ( var_601a117a58005cbf < var_c3c9f29969d5d817 )
    {
        wait var_b2bae9873f67716;
        var_bf2f73af3187e876 = getplayersandaiarrayinradius( impactorigin, aoeradius );
        
        if ( var_bf2f73af3187e876.size > 0 )
        {
            foreach ( var_6cc560bdec891bc1 in var_bf2f73af3187e876 )
            {
                if ( var_6cc560bdec891bc1 == self || var_6cc560bdec891bc1 == attacker || !isalive( var_6cc560bdec891bc1 ) )
                {
                    continue;
                }
                
                targetisplayer = isplayer( var_6cc560bdec891bc1 );
                
                if ( isai( var_6cc560bdec891bc1 ) && var_6cc560bdec891bc1.type == "zombie" )
                {
                    var_6cc560bdec891bc1 callback::callback( "burned" );
                    var_cc682460b6c05565 *= 0.35;
                }
                else if ( targetisplayer )
                {
                    var_6cc560bdec891bc1 thread damage_effects::enableburnfxfortime( 1.5 );
                }
                
                var_6cc560bdec891bc1 dodamage( var_6cc560bdec891bc1.maxhealth * var_cc682460b6c05565 * 0.01, impactorigin, attacker, attacker, "MOD_EXPLOSIVE", undefined, "torso_upper" );
            }
        }
        
        var_601a117a58005cbf += var_b2bae9873f67716;
    }
}

// Namespace zombie_triton_impact
// Params 7, eflags: 0x4
// Checksum 0xf5f1b009, Offset: 0x1584
// Size: 0x616
function private function_5f4db388ae6a3476( triton, var_e5270225594183b1, var_461c7c1c2e0c60b8, var_2c4102e84c8e0a8d, var_778af70bfd34a9a3, var_e066d2877802cb7a, var_f13dc378ca06868b )
{
    var_ca60edf006207ea9 = getdvarfloat( @"hash_ba8d93c5734647a8", 100 );
    var_5c70ef44a77fe13e = getdvarfloat( @"hash_453293fdeaa7bb1", 0.45 );
    var_df67e404e49cde0d = 0.1;
    var_3b544940b3f24aa7 = getdvarfloat( @"hash_6bfb517fdd948899", 110 );
    var_54a41670fec0e27 = 600;
    var_cb5fa52b6683e985 = 300;
    var_c7e5466362f31476 = 30;
    var_7daad47b875bcb3f = 10;
    var_41d1922c232a58c3 = 70;
    var_5ee1c8379c184dd8 = [];
    var_86cd5843a617017 = 1;
    var_202b6463b84c81c3 = getdvarint( @"ground_slam_debug", 0 );
    var_f74e2e1557f90d9d = undefined;
    var_3d21eec29b566ffb = ( 0, 0, 1 );
    var_2963919cdf522733 = anglestoright( self.angles );
    
    if ( isdefined( var_461c7c1c2e0c60b8 ) )
    {
        var_3db13dcab09acb41 = vectorcross( var_461c7c1c2e0c60b8, var_2963919cdf522733 );
        var_f74e2e1557f90d9d = axistoangles( var_3db13dcab09acb41, var_2963919cdf522733, var_461c7c1c2e0c60b8 );
    }
    else
    {
        var_f74e2e1557f90d9d = self.angles;
    }
    
    if ( isalive( triton ) )
    {
        var_cc682460b6c05565 = triton.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_236955cb16e3a9eb;
    }
    else
    {
        var_cc682460b6c05565 = var_7daad47b875bcb3f;
    }
    
    if ( function_4f868b8bf789dad0( var_e5270225594183b1, var_41d1922c232a58c3 ) )
    {
        thread function_fe394d0652caa01b( triton, var_e5270225594183b1, var_f74e2e1557f90d9d, var_cc682460b6c05565, var_3b544940b3f24aa7 );
    }
    
    var_f9674beed4f6db08 = vectornormalize2( anglestoforward( self.angles ) );
    var_5f1a6377d4fc0457 = var_f9674beed4f6db08 * 100;
    var_79edb421a0721d08 = var_e066d2877802cb7a ?? var_df67e404e49cde0d;
    var_49668c11bc72e79f = var_e5270225594183b1;
    var_d32475bd148f5571 = [ var_49668c11bc72e79f ];
    var_3ed25e6b2be8c8d1 = squared( var_2c4102e84c8e0a8d );
    var_23cfd87f1c740cf5 = 0;
    
    while ( var_23cfd87f1c740cf5 <= var_3ed25e6b2be8c8d1 )
    {
        var_bf2f73af3187e876 = getplayersandaiarrayinradius( var_49668c11bc72e79f, var_3b544940b3f24aa7 );
        
        foreach ( potentialtarget in var_bf2f73af3187e876 )
        {
            if ( potentialtarget == triton || !isalive( potentialtarget ) || isdefined( var_f13dc378ca06868b ) && isdefined( function_f02c63b99c9614c9( var_f13dc378ca06868b, potentialtarget ) ) )
            {
                continue;
            }
            
            if ( isdefined( function_f02c63b99c9614c9( var_5ee1c8379c184dd8, potentialtarget ) ) )
            {
                continue;
            }
            
            var_15ed4e0c01d77e74 = get_knockback_impact_point( var_d32475bd148f5571, var_f9674beed4f6db08, potentialtarget );
            
            if ( !isplayer( potentialtarget ) )
            {
                var_faf94f76637b18d4 = function_e7b2933ee390e524( 0.5, potentialtarget.aicategory, potentialtarget.maxhealth );
                
                if ( var_faf94f76637b18d4 >= potentialtarget.health && !potentialtarget.noragdoll && !potentialtarget.script_noragdoll )
                {
                    var_4875c4a245b82147 = vectornormalize2( potentialtarget.origin - var_15ed4e0c01d77e74 );
                    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, var_3d21eec29b566ffb );
                    var_62c54acda6801066 = function_c0755281820f7124( undefined, potentialtarget.subclass, 1 );
                    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_62c54acda6801066.var_f186e7fac7ca9a06 );
                    impactvector = var_62c54acda6801066.impactmagnitude * impactvector;
                    potentialtarget.ragdollimpactvector = impactvector;
                    potentialtarget.ragdollhitloc = "torso_lower";
                    potentialtarget.forceragdollimmediate = 1;
                }
                else if ( var_faf94f76637b18d4 < potentialtarget.health )
                {
                    potentialtarget zombie_knockdown::function_6fc167d4a3590991( var_15ed4e0c01d77e74, var_cb5fa52b6683e985, var_c7e5466362f31476 );
                }
                
                potentialtarget dodamage( var_faf94f76637b18d4, self.origin, triton, triton, "MOD_EXPLOSIVE", undefined, "torso_upper" );
            }
            else
            {
                if ( !player::isinlaststand( potentialtarget ) )
                {
                    potentialtarget knockback_player( triton, var_15ed4e0c01d77e74, 1, var_54a41670fec0e27, var_54a41670fec0e27 );
                    potentialtarget dodamage( var_778af70bfd34a9a3, self.origin, triton, triton, "MOD_EXPLOSIVE", undefined, "torso_upper" );
                }
                
                potentialtarget thread damage_effects::enableburnfxfortime( 1.5 );
            }
            
            var_5ee1c8379c184dd8 = arraycombineunique( var_5ee1c8379c184dd8, [ potentialtarget ] );
        }
        
        var_55b342325f0ad101 = var_49668c11bc72e79f + var_3d21eec29b566ffb * var_ca60edf006207ea9;
        var_3a29767dbdc4560e = var_55b342325f0ad101 + var_5f1a6377d4fc0457;
        var_d389c947ea93a100 = trace::ray_trace( var_55b342325f0ad101, var_3a29767dbdc4560e, [ triton ], trace::create_solid_ai_contents( 1 ) );
        
        if ( var_d389c947ea93a100[ "hittype" ] == "hittype_none" )
        {
            var_49668c11bc72e79f += var_5f1a6377d4fc0457;
            var_fce76671139699d8 = var_49668c11bc72e79f + var_3d21eec29b566ffb * var_ca60edf006207ea9;
            var_435031c0d74dddad = var_49668c11bc72e79f + -1 * var_3d21eec29b566ffb * var_ca60edf006207ea9;
            groundtrace = trace::ray_trace( var_fce76671139699d8, var_435031c0d74dddad, [ triton ], trace::create_solid_ai_contents( 1 ) );
            
            if ( groundtrace[ "hittype" ] != "hittype_none" && isdefined( groundtrace[ "normal" ] ) )
            {
                var_49668c11bc72e79f = groundtrace[ "position" ];
                var_461c7c1c2e0c60b8 = groundtrace[ "normal" ];
                
                if ( vectordot( var_461c7c1c2e0c60b8, var_3d21eec29b566ffb ) >= var_5c70ef44a77fe13e )
                {
                    if ( function_4f868b8bf789dad0( var_49668c11bc72e79f, var_41d1922c232a58c3 ) )
                    {
                        var_a2229c3337daf6cf = vectorcross( var_461c7c1c2e0c60b8, var_2963919cdf522733 );
                        var_93e9667fd10911df = axistoangles( var_a2229c3337daf6cf, var_2963919cdf522733, var_461c7c1c2e0c60b8 );
                        var_ccbd7328bbe4384 = spawnscriptable( "scriptable_zombie_triton_ground_slam_line_impact", var_49668c11bc72e79f, var_93e9667fd10911df );
                        var_ccbd7328bbe4384 thread function_fe394d0652caa01b( triton, var_49668c11bc72e79f, var_93e9667fd10911df, var_cc682460b6c05565, var_3b544940b3f24aa7 );
                    }
                }
                else
                {
                    break;
                }
            }
            else
            {
                break;
            }
            
            var_d32475bd148f5571 = arraycombineunique( var_d32475bd148f5571, [ var_49668c11bc72e79f ] );
            wait var_79edb421a0721d08;
            var_23cfd87f1c740cf5 = distance2dsquared( var_49668c11bc72e79f, var_e5270225594183b1 );
            continue;
        }
        
        break;
    }
}

// Namespace zombie_triton_impact
// Params 3, eflags: 0x4
// Checksum 0x8649ac1a, Offset: 0x1ba2
// Size: 0xe0
function private get_knockback_impact_point( var_d32475bd148f5571, var_f9674beed4f6db08, potentialtarget )
{
    if ( var_d32475bd148f5571.size == 1 )
    {
        return var_d32475bd148f5571[ 0 ];
    }
    
    var_ad980c76a8abdbf0 = 0.2;
    
    foreach ( impactpoint in var_d32475bd148f5571 )
    {
        var_c6731636ce74871a = vectornormalize( potentialtarget.origin - impactpoint );
        
        if ( vectordot( var_f9674beed4f6db08, var_c6731636ce74871a ) >= var_ad980c76a8abdbf0 )
        {
            var_6087ccf9336524d5 = impactpoint;
            continue;
        }
        
        break;
    }
    
    return var_6087ccf9336524d5;
}

// Namespace zombie_triton_impact
// Params 5, eflags: 0x4
// Checksum 0x6d19583d, Offset: 0x1c8b
// Size: 0x9a
function private function_fe394d0652caa01b( triton, var_337dc12be9bb7a51, var_ad4a2579a2a3c1ea, var_cc682460b6c05565, impactradius )
{
    self endon( #"death" );
    
    if ( !utility::ispointinwater( var_337dc12be9bb7a51 - ( 0, 0, 32 ) ) )
    {
        var_f69727fd3a663df2 = 8;
        self setscriptablepartstate( "impact", "impact" );
        thread do_fire_aoe_damage( triton, var_f69727fd3a663df2, var_cc682460b6c05565, var_337dc12be9bb7a51, impactradius );
        self notify( #"hash_6ae611a48bf1e6c4", var_337dc12be9bb7a51, impactradius );
        wait var_f69727fd3a663df2;
        self freescriptable();
    }
}

// Namespace zombie_triton_impact
// Params 4, eflags: 0x4
// Checksum 0xfb618d5a, Offset: 0x1d2d
// Size: 0x156
function private function_e7b2933ee390e524( var_a9e6352b74faa839, aicategory, aimaxhealth, var_e1446af35adad414 )
{
    var_3d062c4caeee83f5 = 0.2;
    var_4464483d28d5ab28 = 0.4;
    var_cd3dffb0a85a0ccb = 0.1;
    var_f16d1c92848e00d6 = 0.3;
    var_d360b362e9076b1f = 0.01;
    var_b8a3a4c15af00b5a = 0.1;
    var_8f788e6251884233 = 0;
    var_55334b8554eb907e = 0;
    var_37498f4d3eb74d2f = 0;
    
    if ( var_e1446af35adad414 )
    {
        var_37498f4d3eb74d2f = 0.1;
    }
    
    if ( aicategory == "normal" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_4464483d28d5ab28, var_3d062c4caeee83f5, var_a9e6352b74faa839 ) + var_37498f4d3eb74d2f;
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    if ( aicategory == "special" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_f16d1c92848e00d6, var_cd3dffb0a85a0ccb, var_a9e6352b74faa839 ) + var_37498f4d3eb74d2f;
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    if ( aicategory == "elite" || aicategory == "hvt" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_b8a3a4c15af00b5a, var_d360b362e9076b1f, var_a9e6352b74faa839 ) + var_37498f4d3eb74d2f;
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    if ( aicategory == "boss" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_55334b8554eb907e, var_8f788e6251884233, var_a9e6352b74faa839 ) + var_37498f4d3eb74d2f;
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    return 0;
}

// Namespace zombie_triton_impact
// Params 6, eflags: 0x4
// Checksum 0x245941, Offset: 0x1e8b
// Size: 0x2b8
function private function_c0755281820f7124( var_a9e6352b74faa839, aisubclass, var_5fa2fe17df9b6926, var_e1446af35adad414, var_711b6ed01a83e79c, var_d4822cab8dc54371 )
{
    impactresults = spawnstruct();
    impactresults.var_f186e7fac7ca9a06 = 45;
    
    if ( aisubclass == "zombie_base" )
    {
        if ( !var_5fa2fe17df9b6926 )
        {
            impactresults.impactmagnitude = math::lerp( 7000, 5500, var_a9e6352b74faa839 );
        }
        else
        {
            impactresults.impactmagnitude = 5000;
        }
    }
    else if ( aisubclass == "zombie_vermin" )
    {
        if ( !var_5fa2fe17df9b6926 )
        {
            impactresults.impactmagnitude = math::lerp( 15000, 10000, var_a9e6352b74faa839 );
        }
        else
        {
            impactresults.impactmagnitude = 10000;
        }
    }
    else if ( aisubclass == "zombie_parasite" )
    {
        if ( !var_5fa2fe17df9b6926 )
        {
            impactresults.impactmagnitude = math::lerp( 20000, 10000, var_a9e6352b74faa839 );
        }
        else
        {
            impactresults.impactmagnitude = 15000;
        }
    }
    else if ( aisubclass == "zombie_mangler" )
    {
        if ( !var_5fa2fe17df9b6926 )
        {
            impactresults.impactmagnitude = math::lerp( 7500, 6250, var_a9e6352b74faa839 );
        }
        else
        {
            impactresults.impactmagnitude = 6000;
        }
    }
    else if ( !var_5fa2fe17df9b6926 )
    {
        impactresults.impactmagnitude = math::lerp( 7000, 5500, var_a9e6352b74faa839 );
    }
    else
    {
        impactresults.impactmagnitude = 5000;
    }
    
    if ( var_e1446af35adad414 )
    {
        impactresults.var_f186e7fac7ca9a06 += 5;
        impactresults.impactmagnitude *= 1.1;
    }
    
    if ( var_711b6ed01a83e79c )
    {
        impactresults.var_f186e7fac7ca9a06 += 5;
        impactresults.impactmagnitude *= 1.1;
    }
    
    if ( var_d4822cab8dc54371 )
    {
        impactresults.var_f186e7fac7ca9a06 -= 15;
        
        if ( impactresults.var_f186e7fac7ca9a06 < 1 )
        {
            impactresults.var_f186e7fac7ca9a06 = 1;
        }
        
        impactresults.impactmagnitude *= 0.5;
    }
    
    impactresults.var_f186e7fac7ca9a06 = getdvarfloat( @"hash_2ff20a2014bfce26", impactresults.var_f186e7fac7ca9a06 );
    impactresults.impactmagnitude = getdvarfloat( @"hash_568e1d9cfb85f06f", impactresults.impactmagnitude );
    return impactresults;
}

// Namespace zombie_triton_impact
// Params 8, eflags: 0x4
// Checksum 0x44a59a5a, Offset: 0x214c
// Size: 0x155
function private knockback_player( inflictor, var_e5049d59fedd8c2f, var_a9e6352b74faa839, var_79e488ac9a42aeef, var_5934bd19e6961256, var_e1446af35adad414, var_711b6ed01a83e79c, var_d4822cab8dc54371 )
{
    var_4875c4a245b82147 = vectornormalize2( self.origin - var_e5049d59fedd8c2f );
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    var_d750b8a81b34edc6 = math::lerp( var_5934bd19e6961256, var_79e488ac9a42aeef, var_a9e6352b74faa839 );
    var_f186e7fac7ca9a06 = 50;
    impactmagnitude = var_d750b8a81b34edc6;
    
    if ( var_e1446af35adad414 )
    {
        var_f186e7fac7ca9a06 += 5;
        impactmagnitude *= 1.1;
    }
    
    if ( var_711b6ed01a83e79c )
    {
        var_f186e7fac7ca9a06 += 5;
        impactmagnitude += 150;
    }
    
    if ( var_d4822cab8dc54371 )
    {
        impactmagnitude *= 0.5;
        var_f186e7fac7ca9a06 -= 15;
        
        if ( var_f186e7fac7ca9a06 < 1 )
        {
            var_f186e7fac7ca9a06 = 1;
        }
    }
    
    var_f186e7fac7ca9a06 = getdvarfloat( @"hash_21bfc2f5f654ff20", var_f186e7fac7ca9a06 );
    impactmagnitude = getdvarfloat( @"hash_63a5c8451997935d", impactmagnitude );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_f186e7fac7ca9a06 );
    self knockback( impactvector, impactmagnitude, 1 );
    thread function_fd8e17b0f00a4575( inflictor );
}

// Namespace zombie_triton_impact
// Params 1, eflags: 0x4
// Checksum 0x7a60ddd1, Offset: 0x22a9
// Size: 0x57
function private function_fd8e17b0f00a4575( inflictor )
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
    
    if ( isalive( inflictor ) )
    {
        inflictor notify( #"stop_current_movement_prediction" );
    }
}

/#

    // Namespace zombie_triton_impact
    // Params 0
    // Checksum 0x6083dda9, Offset: 0x2308
    // Size: 0x60, Type: dev
    function setup_impact_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x68>" );
        devgui::add_devgui_func( "<dev string:x80>", "<dev string:xa4>", &function_128694ab43c8ab24, 1 );
        devgui::add_devgui_func( "<dev string:xc8>", "<dev string:xee>", &function_dd2974f255303631, 1 );
        devgui::add_devgui_func( "<dev string:x114>", "<dev string:x138>", &function_3cd7f30a86b4f1b1, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_triton_impact
    // Params 0, eflags: 0x4
    // Checksum 0x7b5bf1ce, Offset: 0x2370
    // Size: 0x3ec, Type: dev
    function private function_128694ab43c8ab24()
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x15c>" );
        
        if ( isdefined( triton ) )
        {
            assert( isdefined( triton.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x16a>" );
            
            while ( true )
            {
                if ( !isalive( triton ) )
                {
                    return;
                }
                
                triton waittill( #"hash_c01b3baee08c531c" );
                
                if ( isdefined( triton.var_7eb791e627c0827a ) )
                {
                    print3d( triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f + ( 0, 0, 1 ) * 60, "<dev string:x1de>", ( 0, 0, 1 ), 1, 1, 100, 1 );
                    utility::draw_circle( triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f, triton.var_7eb791e627c0827a.var_a446d18d52c29458, ( 0, 0, 1 ), 1, 0, 100 );
                    var_d9b08fdd7c7e55d7 = triton.var_7eb791e627c0827a.var_c26923e1209fc556 / 2;
                    forwardvec = anglestoforward( triton.angles );
                    var_a1fbe5c12503802c = rotatepointaroundvector( ( 0, 0, 1 ), forwardvec, var_d9b08fdd7c7e55d7 );
                    var_1068cb73f63d239a = rotatepointaroundvector( ( 0, 0, 1 ), forwardvec, -1 * var_d9b08fdd7c7e55d7 );
                    var_a1fbe5c12503802c *= triton.var_7eb791e627c0827a.var_a446d18d52c29458;
                    var_1068cb73f63d239a *= triton.var_7eb791e627c0827a.var_a446d18d52c29458;
                    thread utility::draw_line_for_time( triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f, triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f + var_a1fbe5c12503802c, 0, 0, 1, 1 );
                    thread utility::draw_line_for_time( triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f, triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f + var_1068cb73f63d239a, 0, 0, 1, 1 );
                    print3d( triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f + ( 0, 0, 1 ) * 30, "<dev string:x1fc>", ( 1, 0, 0 ), 1, 1, 100, 1 );
                    thread utility::draw_circle( triton.var_7eb791e627c0827a.var_e5049d59fedd8c2f, triton.var_7eb791e627c0827a.var_3f9fe6c6d730bba8, ( 1, 0, 0 ), 1, 0, 1 );
                    
                    foreach ( hitent in triton.var_7eb791e627c0827a.var_fd7d82e053f417e4 )
                    {
                        print3d( hitent.entity.origin + ( 0, 0, 1 ) * 60, "<dev string:x20f>" + hitent.damagedone, ( 1, 0, 0 ), 1, 1, 100, 1 );
                        
                        if ( isplayer( hitent ) )
                        {
                            print3d( hitent.entity.origin + ( 0, 0, 1 ) * 30, "<dev string:x22c>" + hitent.knockbackdone, ( 1, 1, 0 ), 1, 1, 100, 1 );
                        }
                    }
                }
            }
        }
    }

    // Namespace zombie_triton_impact
    // Params 0, eflags: 0x4
    // Checksum 0xb6da2727, Offset: 0x2764
    // Size: 0x2d9, Type: dev
    function private function_dd2974f255303631()
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x15c>" );
        
        if ( isdefined( triton ) )
        {
            assert( isdefined( triton.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x16a>" );
            
            while ( true )
            {
                if ( !isalive( triton ) )
                {
                    return;
                }
                
                triton waittill( #"hash_c01b3baee08c531c" );
                
                if ( isdefined( triton.var_d368de47f50cccdf ) )
                {
                    print3d( triton.var_d368de47f50cccdf.var_e5049d59fedd8c2f + ( 0, 0, 1 ) * 60, "<dev string:x254>", ( 0, 0, 1 ), 1, 1, 100, 1 );
                    utility::draw_circle( triton.var_d368de47f50cccdf.var_e5049d59fedd8c2f, triton.var_d368de47f50cccdf.var_cf13477fe2b9fc7d, ( 0, 0, 1 ), 5, 0, 100 );
                    print3d( triton.var_d368de47f50cccdf.var_e5049d59fedd8c2f + ( 0, 0, 1 ) * 30, "<dev string:x26b>", ( 1, 0, 0 ), 1, 1, 100, 1 );
                    utility::draw_circle( triton.var_d368de47f50cccdf.var_e5049d59fedd8c2f, triton.var_d368de47f50cccdf.var_3f9fe6c6d730bba8, ( 1, 0, 0 ), 1, 0, 100 );
                    
                    if ( isdefined( triton.var_d368de47f50cccdf.var_fd7d82e053f417e4 ) )
                    {
                        foreach ( hitent in triton.var_d368de47f50cccdf.var_fd7d82e053f417e4 )
                        {
                            print3d( hitent.entity.origin + ( 0, 0, 1 ) * 60, "<dev string:x20f>" + hitent.damagedone, ( 1, 0, 0 ), 1, 1, 100, 1 );
                            
                            if ( isplayer( hitent ) )
                            {
                                print3d( hitent.entity.origin + ( 0, 0, 1 ) * 30, "<dev string:x22c>" + hitent.knockbackdone, ( 1, 1, 0 ), 1, 1, 100, 1 );
                            }
                        }
                    }
                }
            }
        }
    }

    // Namespace zombie_triton_impact
    // Params 0, eflags: 0x4
    // Checksum 0xa773bfd4, Offset: 0x2a45
    // Size: 0xab, Type: dev
    function private function_3cd7f30a86b4f1b1()
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x15c>" );
        
        if ( isdefined( triton ) )
        {
            assert( isdefined( triton.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x284>" );
            
            while ( true )
            {
                if ( !isalive( triton ) )
                {
                    return;
                }
                
                triton waittill( #"hash_6ae611a48bf1e6c4", var_337dc12be9bb7a51, var_efa2249f96e6eca4 );
                
                /#
                    sphere( var_337dc12be9bb7a51, var_efa2249f96e6eca4, ( 1, 0, 0 ), 0, 70 );
                #/
            }
        }
    }

#/
