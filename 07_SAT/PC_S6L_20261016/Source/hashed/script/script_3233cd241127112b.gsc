// script_3233cd241127112b  (hash_3233cd241127112b.gscc) (size: 7940 Bytes / 0x1f04 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe10004a (4262461514)
// size ...... 7940 (0x1f04)
// includes .. 8   (offset: 0x1bdc)
// strings ... 39  (offset: 0x1c1c)
// dev strs .. 10  (offset: 0x1e8c)
// exports ... 12  (offset: 0x13e4)
// cseg ...... 0x345 + 0x109f (0x13e4)
// imports ... 51  (offset: 0x15c4)
// animtree1 . 0   (offset: 0x1f04)
// animtree2 . 0   (offset: 0x1f04)
#using script_3d224bcd5ba96094;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace namespace_af6379f1aba0301c;

// Namespace namespace_af6379f1aba0301c
// Params 0, eflags: 0x1
// Checksum 0xb9515a0, Offset: 0x363
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_triton";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace namespace_af6379f1aba0301c
// Params 0
// Checksum 0xafa45bd0, Offset: 0x38c
// Size: 0x34
function init_metabones()
{
    metabone::function_b68bd9932f284448( &function_878defb2094ca43a );
    self.var_84af6092b98e204d = 0.08;
    thread init_armor_ents();
    callback::add( "on_zombie_ai_killed", &function_f5806ab6e06514f1 );
}

// Namespace namespace_af6379f1aba0301c
// Params 0, eflags: 0x4
// Checksum 0x2e1fdd01, Offset: 0x3c8
// Size: 0x2eb
function private init_armor_ents()
{
    self endon( #"death" );
    self waittill( #"zombie_asm_init_finished" );
    var_35e27aaa3934f43c = [];
    metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
    
    /#
        var_865421e311a1b382 = getdvarint( @"hash_76ca568d9a385772", 0 );
    #/
    
    foreach ( metabone in metabonesdef.metabones )
    {
        if ( isdefined( metabone.tags ) )
        {
            foreach ( tag in metabone.tags )
            {
                if ( tag.tagname == "j_knee_le" || tag.tagname == "j_knee_ri" )
                {
                    continue;
                }
                
                tagorigin = self gettagorigin( tag.tagname );
                var_a118202a384529bb = utility::spawn_model( "c_t10_triton_armor_piece_ping", tagorigin, self.angles );
                
                if ( tag.tagname == "j_spine4" )
                {
                    var_d802fcb8be42d43a = ( 10, 0, 0 );
                }
                else if ( tag.tagname == "j_ankle_le" || tag.tagname == "j_ankle_ri" )
                {
                    var_d802fcb8be42d43a = ( 0, -20, 0 );
                }
                else if ( tag.tagname == "j_wrist_le" || tag.tagname == "j_wrist_ri" )
                {
                    var_d802fcb8be42d43a = ( -25, 0, 0 );
                }
                else
                {
                    var_d802fcb8be42d43a = ( 0, 0, 0 );
                }
                
                var_a118202a384529bb linkto( self, tag.tagname, var_d802fcb8be42d43a, ( 0, 0, 0 ) );
                var_a118202a384529bb.tagname = tag.tagname;
                var_a118202a384529bb enableaimassist();
                var_a118202a384529bb setscriptablepartstate( "armor", "armored" );
                var_35e27aaa3934f43c[ metabone.name ] = var_a118202a384529bb;
                
                /#
                    if ( var_865421e311a1b382 )
                    {
                        thread function_543e4811689c99e6( var_a118202a384529bb );
                    }
                #/
            }
        }
    }
    
    self.armorents = var_35e27aaa3934f43c;
}

// Namespace namespace_af6379f1aba0301c
// Params 1, eflags: 0x4
// Checksum 0x76da7d61, Offset: 0x6bb
// Size: 0x5d7
function private function_878defb2094ca43a( dmgstruct )
{
    if ( self.var_fa202e3c1b788e39 )
    {
        return;
    }
    
    if ( !( isdefined( dmgstruct.shitloc ) && isdefined( dmgstruct.vpoint ) ) || !( isdefined( self.metabones ) && isdefined( self.metabones.info ) ) )
    {
        return;
    }
    
    if ( dmgstruct.vpoint == self.origin )
    {
        return;
    }
    
    var_4dd08761c0225cab = undefined;
    
    if ( metabone::get_metabone_state_name( "armored_chest" ) == "weakspot" )
    {
        if ( dmgstruct.shitloc == "torso_upper" )
        {
            var_4dd08761c0225cab = "armored_chest";
        }
        else if ( dmgstruct.shitloc == "torso_lower" )
        {
            return;
        }
    }
    else if ( dmgstruct.sweapon.ismelee || dmgstruct.sweapon.classname == "rocketlauncher" || dmgstruct.sweapon.classname == "beam" )
    {
        var_16023fbab228140e = 5;
        metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
        
        if ( !issentient( dmgstruct.eattacker ) )
        {
            return;
        }
        
        eyepos = dmgstruct.eattacker geteye();
        
        foreach ( metabone in metabonesdef.metabones )
        {
            attackdir = vectornormalize( dmgstruct.vpoint - eyepos );
            
            if ( isdefined( metabone.tags ) )
            {
                foreach ( tag in metabone.tags )
                {
                    tagorigin = self gettagorigin( tag.tagname );
                    penetrationdisplacement = attackdir * tag.penetrationdist * var_16023fbab228140e;
                    
                    if ( tag.tagname == "j_wrist_le" || tag.tagname == "j_wrist_ri" || tag.tagname == "j_ankle_le" || tag.tagname == "j_ankle_ri" || tag.tagname == "j_spine4" )
                    {
                        var_6f6d73aa3fe763e3 = 35;
                    }
                    else
                    {
                        var_6f6d73aa3fe763e3 = tag.radius;
                    }
                    
                    if ( !math::segmentvssphere( dmgstruct.vpoint, dmgstruct.vpoint + penetrationdisplacement, tagorigin, var_6f6d73aa3fe763e3 ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( var_4dd08761c0225cab ) )
                    {
                        var_4dd08761c0225cab = metabone.name;
                        var_4cecce0b1dc714da = tagorigin;
                        continue;
                    }
                    
                    if ( isdefined( tagorigin ) && isdefined( var_4cecce0b1dc714da ) && distancesquared( dmgstruct.vpoint, tagorigin ) < distancesquared( dmgstruct.vpoint, var_4cecce0b1dc714da ) )
                    {
                        var_4dd08761c0225cab = metabone.name;
                        var_4cecce0b1dc714da = tagorigin;
                    }
                }
            }
            
            if ( isdefined( metabone.hitlocations ) && !dmgstruct.sweapon.ismelee )
            {
                foreach ( metabonehitloc in metabone.hitlocations )
                {
                    if ( metabonehitloc.hitlocation == dmgstruct.shitloc )
                    {
                        if ( isdefined( metabonehitloc.cosmaxangle ) && isdefined( attackdir ) )
                        {
                            rootforward = anglestoforward( self.angles );
                            hitdot = vectordot( rootforward, vectornormalize( attackdir ) * -1 );
                            
                            if ( hitdot < metabonehitloc.cosmaxangle )
                            {
                                continue;
                            }
                        }
                        
                        var_4dd08761c0225cab = metabone.name;
                        break;
                    }
                }
            }
        }
    }
    else
    {
        var_4dd08761c0225cab = metabone::get_metabone_name( dmgstruct.shitloc, dmgstruct.partname, dmgstruct.vpoint, dmgstruct.vdir );
    }
    
    if ( var_4dd08761c0225cab == "armored_chest" )
    {
        var_d4ff70079867cf67 = 0;
        forwardvec = anglestoforward( self.angles );
        
        if ( isdefined( dmgstruct.vdir ) && vectordot( dmgstruct.vdir, forwardvec ) > var_d4ff70079867cf67 )
        {
            return;
        }
    }
    
    if ( dmgstruct.sweapon.ismelee && !weapon::iswonderweapon( dmgstruct.sweapon ) && isdefined( var_4dd08761c0225cab ) && var_4dd08761c0225cab != "armored_leg_left" && var_4dd08761c0225cab != "armored_leg_right" )
    {
        return;
    }
    
    return var_4dd08761c0225cab;
}

// Namespace namespace_af6379f1aba0301c
// Params 1, eflags: 0x4
// Checksum 0xc92aecda, Offset: 0xc9b
// Size: 0x494
function private on_metabone_destroyed( params )
{
    metabonename = params.metabone_name;
    
    if ( metabone::is_metabone_armor( metabonename ) )
    {
        if ( metabonename == "armored_chest" )
        {
            var_30a92b6d5b19c983 = self.armorents[ "armored_chest" ];
            
            if ( !isdefined( self.var_21c6b300a9a67604 ) || self.var_21c6b300a9a67604 < 6 )
            {
                self.var_16d41b4722b48383 = 1;
                var_30a92b6d5b19c983 delete();
                self.armorents[ "armored_chest" ] = undefined;
                metabone::set_metabone_state( "armored_chest", "destroyed" );
                metabone::set_metabone_active( "armored_chest", 1 );
            }
            else
            {
                self.var_16d41b4722b48383 = 0;
                var_30a92b6d5b19c983 setscriptablepartstate( "armor", "destroyed" );
                metabone::set_metabone_state( "armored_chest", "weakspot" );
                metabone::set_metabone_active( "armored_chest", 1 );
                utility::function_32b24db3127bff40( "armored_chest", "destroyed_to_weakspot" );
            }
        }
        else
        {
            metabone::set_metabone_state( metabonename, "destroyed" );
            metabone::set_metabone_active( metabonename, 1 );
            armorent = self.armorents[ metabonename ];
            armorent setscriptablepartstate( "armor", "destroyed" );
            
            if ( !isdefined( self.var_40cabf7557edfc1e ) )
            {
                self.var_40cabf7557edfc1e = 0;
            }
            
            self.var_40cabf7557edfc1e++;
        }
        
        if ( !isdefined( self.var_21c6b300a9a67604 ) || self.var_21c6b300a9a67604 < 6 )
        {
            utility::function_32b24db3127bff40( metabonename, "destroyed" );
        }
        
        if ( getdvarint( @"hash_1d00233aa37ac01b", 1 ) && self._blackboard.var_606bf8ea1f70975d > 0 && isplayer( params.eattacker ) )
        {
            thread function_a71c5a60857f856f( params.eattacker );
        }
        
        self notify( #"hash_bef3912554e60b6c", metabonename );
    }
    else
    {
        if ( metabonename != "armored_chest" )
        {
            metabone::set_metabone_state( metabonename, "scarred" );
            metabone::set_metabone_active( metabonename, 1 );
            utility::function_32b24db3127bff40( metabonename, "scarred" );
            armorent = self.armorents[ metabonename ];
            armorent delete();
            self.armorents[ metabonename ] = undefined;
        }
        
        if ( !isdefined( self.var_21c6b300a9a67604 ) )
        {
            self.var_21c6b300a9a67604 = 1;
        }
        else
        {
            self.var_21c6b300a9a67604++;
            
            if ( self.var_21c6b300a9a67604 == 6 && metabone::get_metabone_state_name( "armored_chest" ) == "destroyed" )
            {
                self.var_16d41b4722b48383 = 0;
                metabone::set_metabone_state( "armored_chest", "weakspot" );
                metabone::set_metabone_active( "armored_chest", 1 );
                chesttag = "j_spine4";
                tagorigin = self gettagorigin( chesttag );
                var_30a92b6d5b19c983 = utility::spawn_model( "c_t10_triton_armor_piece_ping", tagorigin, self.angles );
                var_30a92b6d5b19c983 linkto( self, chesttag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                var_30a92b6d5b19c983.tagname = chesttag;
                var_30a92b6d5b19c983 enableaimassist();
                var_30a92b6d5b19c983 setscriptablepartstate( "armor", "destroyed" );
                self.armorents[ "armored_chest" ] = var_30a92b6d5b19c983;
                utility::function_32b24db3127bff40( "armored_chest", "weakspot" );
            }
        }
        
        var_1dd6eab2991736a = self.var_84af6092b98e204d ?? 0.08;
        var_5ff17016a8f3f823 = self.maxhealth * var_1dd6eab2991736a;
        
        if ( var_5ff17016a8f3f823 > self.maxhealth * 0.2 )
        {
            var_5ff17016a8f3f823 = self.maxhealth * 0.08;
        }
        
        damagehitloc = function_beea7187adcc3291( metabonename );
        metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
        damageorigin = metabonesdef.var_2972332beaa5b174[ metabonename ].tags[ 0 ].tagname;
        self.var_7037157e68c4992b = var_5ff17016a8f3f823;
        self dodamage( var_5ff17016a8f3f823, self gettagorigin( damageorigin ), undefined, undefined, "MOD_EXPLOSIVE", undefined, damagehitloc, undefined, 65536 );
    }
    
    if ( isalive( self ) && !self.var_fbd2b9707b5bd16f && ( !isdefined( self.var_80521f0adf3a76b9 ) || utility::time_has_passed( self.var_80521f0adf3a76b9, 16 ) ) )
    {
        asm::function_7256f5ba459c840b( "special_pain_in" );
        self.var_80521f0adf3a76b9 = gettime();
    }
}

// Namespace namespace_af6379f1aba0301c
// Params 1, eflags: 0x4
// Checksum 0x91ea8e97, Offset: 0x1137
// Size: 0x47
function private function_a71c5a60857f856f( var_e216086757da7be6 )
{
    self endon( #"death" );
    
    if ( utility::ent_flag( "currently_targeting_burst_target" ) )
    {
        utility::ent_flag_set( "armor_piece_broke_while_already_focused_on_burst_damage_target" );
    }
    
    utility::ent_flag_wait( "look_for_burst_damage_target" );
    zombie_triton_targeting::function_f5c10ded7711e35b( var_e216086757da7be6 );
}

// Namespace namespace_af6379f1aba0301c
// Params 1, eflags: 0x4
// Checksum 0x8f8c1d89, Offset: 0x1186
// Size: 0x9a
function private function_beea7187adcc3291( metabone_name )
{
    damagehitloc = "";
    
    if ( metabone_name == "armored_shoulder_left" )
    {
        damagehitloc = "left_arm_upper";
    }
    else if ( metabone_name == "armored_shoulder_right" )
    {
        damagehitloc = "right_arm_upper";
    }
    else if ( metabone_name == "armored_gauntlet_left" )
    {
        damagehitloc = "left_arm_lower";
    }
    else if ( metabone_name == "armored_gauntlet_right" )
    {
        damagehitloc = "right_arm_lower";
    }
    else if ( metabone_name == "armored_leg_left" )
    {
        damagehitloc = "left_leg_lower";
    }
    else if ( metabone_name == "armored_leg_right" )
    {
        damagehitloc = "right_leg_lower";
    }
    
    return damagehitloc;
}

// Namespace namespace_af6379f1aba0301c
// Params 1, eflags: 0x4
// Checksum 0xfbf7f2ea, Offset: 0x1229
// Size: 0x3e
function private function_f5806ab6e06514f1( params )
{
    var_30a92b6d5b19c983 = self.armorents[ "armored_chest" ];
    
    if ( isdefined( var_30a92b6d5b19c983 ) )
    {
        var_30a92b6d5b19c983 delete();
    }
    
    self.armorscriptables = undefined;
}

/#

    // Namespace namespace_af6379f1aba0301c
    // Params 1
    // Checksum 0x70f378da, Offset: 0x126f
    // Size: 0xb8, Type: dev
    function function_7b1238de9631111a( params )
    {
        triton = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x24>" );
        
        if ( isalive( triton ) )
        {
            var_5c3a7e312d2b5b27 = randomint( 6 );
            metabonename = function_4dd633f794c2f1ff( var_5c3a7e312d2b5b27 );
            
            if ( !isdefined( triton.var_40cabf7557edfc1e ) )
            {
                triton.var_40cabf7557edfc1e = 0;
            }
            
            triton.var_40cabf7557edfc1e++;
            triton asm::function_7256f5ba459c840b( "<dev string:x32>" );
            triton utility::function_32b24db3127bff40( metabonename, "<dev string:x42>" );
            triton notify( #"hash_bef3912554e60b6c" );
        }
    }

    // Namespace namespace_af6379f1aba0301c
    // Params 1, eflags: 0x4
    // Checksum 0xcaed7afe, Offset: 0x132f
    // Size: 0x77, Type: dev
    function private function_4dd633f794c2f1ff( randomint )
    {
        if ( randomint == 0 )
        {
            return "<dev string:x4c>";
        }
        else if ( randomint == 1 )
        {
            return "<dev string:x62>";
        }
        else if ( randomint == 2 )
        {
            return "<dev string:x79>";
        }
        else if ( randomint == 3 )
        {
            return "<dev string:x8f>";
        }
        else if ( randomint == 4 )
        {
            return "<dev string:xa6>";
        }
        else if ( randomint == 5 )
        {
            return "<dev string:xb7>";
        }
        
        return "<dev string:xc9>";
    }

    // Namespace namespace_af6379f1aba0301c
    // Params 1, eflags: 0x4
    // Checksum 0x62f20c7d, Offset: 0x13ae
    // Size: 0x36, Type: dev
    function private function_543e4811689c99e6( armorent )
    {
        self endon( #"death" );
        
        while ( true )
        {
            sphere( armorent.origin, 5 );
            waitframe();
        }
    }

#/
