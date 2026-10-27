// script_4e131720d70aa378  (hash_4e131720d70aa378.gscc) (size: 11948 Bytes / 0x2eac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd0a3fe1d (3500408349)
// size ...... 11948 (0x2eac)
// includes .. 8   (offset: 0x2b14)
// strings ... 42  (offset: 0x2b54)
// dev strs .. 22  (offset: 0x2da4)
// exports ... 20  (offset: 0x1bd8)
// cseg ...... 0x30d + 0x18cb (0x1bd8)
// imports ... 101 (offset: 0x1ef8)
// animtree1 . 0   (offset: 0x2eac)
// animtree2 . 0   (offset: 0x2eac)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace namespace_ce58d65bf2615c99;

// Namespace namespace_ce58d65bf2615c99
// Params 1
// Checksum 0x5cd29b4d, Offset: 0x32b
// Size: 0x3d
function function_c3efc774d7b1d266( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "abom_beam_fx", settings.beamfx );
    }
}

// Namespace namespace_ce58d65bf2615c99
// Params 0
// Checksum 0x9592439b, Offset: 0x370
// Size: 0x18f
function init_zombie_abom_beam_attack()
{
    callback::add( #"on_ai_killed", &cleanup_beam_ents );
    thread function_9da93a97dd825327();
    thread function_84a4867977a3607b();
    self.abom_beam_ents = [];
    
    for ( var_e8b483d049d7276b = 0; var_e8b483d049d7276b <= 2 ; var_e8b483d049d7276b++ )
    {
        self.abom_beam_ents[ var_e8b483d049d7276b ] = spawn( "script_model", ( 0, 0, 0 ) );
        self.abom_beam_ents[ var_e8b483d049d7276b ] setmodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5a6e0a21bfa8935d );
        self.abom_beam_ents[ var_e8b483d049d7276b ] utility::function_7c10ea82c1e305b8( "beam_tip", "off" );
        thread utility::delete_on_death( self.abom_beam_ents[ var_e8b483d049d7276b ] );
    }
    
    self.var_7510382f5bd18e6e = [];
    self.var_80a2b3edd3d43109 = [];
    self.var_80a2b3edd3d43109[ 0 ] = "tag_fx_head_le_throat";
    self.var_80a2b3edd3d43109[ 1 ] = "tag_fx_head_center_throat";
    self.var_80a2b3edd3d43109[ 2 ] = "tag_fx_head_ri_throat";
    self.var_ad197ca11c039e90 = [];
    self.aimyawspeed = 10;
    self.var_e834bac54dd3efaa = 10;
    self.var_4bce31da81afb507 = 20;
    var_a532b7321c6f7d24 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_44c46d9db2a65ba8 * 1000;
    self function_786bb6aa1b76c7ee( "beam_attack_cooldown", var_a532b7321c6f7d24 );
    self function_786bb6aa1b76c7ee( "beam_unreachable_cooldown", 5000 );
    
    /#
        function_d0a88666aaee23d4();
    #/
}

// Namespace namespace_ce58d65bf2615c99
// Params 4, eflags: 0x4
// Checksum 0x68b5c2a2, Offset: 0x507
// Size: 0x106
function private function_b893a9e913cea804( entity, var_90ec0886f9ccf215, var_29a127c04ade1da1, var_a0684ccb4c773bce )
{
    var_f170b524015f6863 = 9 + var_29a127c04ade1da1 * 2;
    
    if ( isai( var_90ec0886f9ccf215 ) && isdefined( var_90ec0886f9ccf215.maxhealth ) )
    {
        var_f170b524015f6863 = max( var_90ec0886f9ccf215.maxhealth * 0.1, var_f170b524015f6863 * 2 );
        
        if ( var_a0684ccb4c773bce )
        {
            if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ffb9d09ce59952d3 )
            {
                var_f170b524015f6863 *= 3;
            }
        }
        
        if ( var_90ec0886f9ccf215.aicategory == "boss" )
        {
            return 0;
        }
        
        if ( self.var_e2fce82443c7cf79 && var_90ec0886f9ccf215.aicategory == "hvt" )
        {
            return 0;
        }
    }
    else if ( isplayer( var_90ec0886f9ccf215 ) )
    {
        var_f170b524015f6863 = int( var_f170b524015f6863 * getdvarfloat( @"hash_801a4981ce836d30", 1 ) * self.ranged_damage_multiplier );
    }
    
    return var_f170b524015f6863;
}

// Namespace namespace_ce58d65bf2615c99
// Params 4
// Checksum 0xc41732d5, Offset: 0x616
// Size: 0x215, Type: bool
function function_6a45376d254099c2( asmname, statename, tostatename, params )
{
    if ( !isalive( self.enemy ) )
    {
        return true;
    }
    
    if ( !math::is_point_in_front( self.enemy.origin ) )
    {
        function_4f22c055483197a2();
        
        /#
            function_ba3b0c32f8e1d7a1( "<dev string:x24>" );
        #/
        
        return true;
    }
    
    if ( distance2dsquared( self.enemy.origin, self.origin ) < squared( self.melee_range ) )
    {
        /#
            function_ba3b0c32f8e1d7a1( "<dev string:x40>" );
        #/
        
        self.beam_attack_failed = 1;
        return true;
    }
    
    var_d1bc21baf5f18f5d = gettime() - ( self.abom_beam_start_time ?? 0 );
    abom_beam_time = getdvarint( @"abom_beam_time", 6000 );
    
    if ( abom_beam_time > 0 && var_d1bc21baf5f18f5d > abom_beam_time )
    {
        /#
            function_ba3b0c32f8e1d7a1( "<dev string:x65>" );
        #/
        
        return true;
    }
    
    var_6d6c4722e727c7d2 = gettime() - ( self.var_a9983e721f3b21c2 ?? 0 );
    var_21f91b943e9027a5 = getdvarint( @"hash_5a02ebc4afef300d", 3000 );
    
    if ( var_21f91b943e9027a5 > 0 && var_6d6c4722e727c7d2 > var_21f91b943e9027a5 )
    {
        /#
            function_ba3b0c32f8e1d7a1( "<dev string:x82>" );
        #/
        
        if ( !isdefined( self.var_a9983e721f3b21c2 ) || self.var_a9983e721f3b21c2 < self.abom_beam_start_time )
        {
            self.beam_attack_failed = 1;
        }
        
        return true;
    }
    
    aim_at_pos = self function_7d4e091be39f0a40();
    
    /#
        if ( debug_beam_attack() && isdefined( aim_at_pos ) )
        {
            function_ba3b0c32f8e1d7a1( "<dev string:xa3>", aim_at_pos );
            line( self.origin, self function_7d4e091be39f0a40(), ( 1, 1, 0 ) );
        }
    #/
    
    if ( isdefined( aim_at_pos ) && !math::is_point_in_front( aim_at_pos ) )
    {
        /#
            function_ba3b0c32f8e1d7a1( "<dev string:xab>" );
        #/
        
        return true;
    }
    
    return false;
}

// Namespace namespace_ce58d65bf2615c99
// Params 0, eflags: 0x4
// Checksum 0x66e46177, Offset: 0x834
// Size: 0x52
function private function_9da93a97dd825327()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"beam_attack_intro_start" );
        utility::function_32b24db3127bff40( "beam_tell", "beam_tell_on" );
        self waittill( #"beam_attack_intro_end" );
        utility::function_32b24db3127bff40( "beam_tell", "beam_tell_off" );
    }
}

// Namespace namespace_ce58d65bf2615c99
// Params 0, eflags: 0x4
// Checksum 0x6b95e435, Offset: 0x88e
// Size: 0x7f
function private function_84a4867977a3607b()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"beam_attack_loop_start" );
        
        if ( self getaiblackboarddynamic( "in_beam_attack" ) )
        {
            self.abom_beam_start_time = gettime();
            self function_786bb6aa1b76c7ee( "beam_unreachable_cooldown", 5000 );
            self.beam_attack_failed = undefined;
            
            if ( isdefined( self.enemy ) )
            {
                self getenemyinfo( self.enemy );
            }
            
            thread function_6c8610ca81382efd();
            thread beam_attack_on_end();
        }
    }
}

// Namespace namespace_ce58d65bf2615c99
// Params 0, eflags: 0x4
// Checksum 0xfaf02922, Offset: 0x915
// Size: 0xc47
function private function_6c8610ca81382efd()
{
    self endon( #"death" );
    self endon( #"beam_attack_loop_finished" );
    var_4d1ae168acdc2749 = 0;
    attack_target_ent = self.enemy;
    beam_audio_active = 0;
    var_a1abee9062687674 = [ ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ) ];
    var_7a8c168bf4869367 = [ ( 0, 0, 0 ), ( 0, 0, 0 ), ( 0, 0, 0 ) ];
    round_number = zombie_utils::get_zombie_round_difficulty();
    var_255fcf4526cbba4e = 10 + clamp( math::remap( round_number, 20, 30, 0, 25 ), 0, 25 );
    var_84ddbccc7b4142cf = 90;
    var_1eba9c6d8c04574e = [];
    
    while ( true )
    {
        attack_target_ent = self.enemy;
        var_23a7ec979fd4a84c = var_84ddbccc7b4142cf;
        
        if ( isdefined( self.var_72df982c7ce5d440 ) )
        {
            var_23a7ec979fd4a84c = self.var_72df982c7ce5d440;
        }
        
        round_number = zombie_utils::get_zombie_round_difficulty();
        var_24a955ee1b17ef8d = math::remap( round_number, 20, 50, 0, 1 );
        var_2315701dfa5d6fa = gettime() - ( self.var_a9983e721f3b21c2 ?? 0 );
        missing_time_threshold = 5000;
        
        if ( var_2315701dfa5d6fa > missing_time_threshold )
        {
            var_24a955ee1b17ef8d = 1;
        }
        
        self.aimyawspeed = 10 + clamp( var_24a955ee1b17ef8d, 0, 1 ) * 150;
        var_273d51c17a5acf2 = self.var_89cc06fcebe201a1;
        head_mid_tag = self.var_80a2b3edd3d43109[ 1 ];
        var_cbae022e329d2a51 = self gettagangles( head_mid_tag );
        var_cbae022e329d2a51 = ( 0, var_cbae022e329d2a51[ 1 ], 0 );
        var_f06c3d8143b76949 = self gettagorigin( head_mid_tag );
        head_forward_vec = anglestoforward( var_cbae022e329d2a51 );
        var_110dce6d38f582a6 = function_35c19e0bf9b095b8();
        var_16af507c59384dee = [];
        
        for ( var_e5df84b3a2ddf25a = 1; var_e5df84b3a2ddf25a < var_110dce6d38f582a6.size ; var_e5df84b3a2ddf25a++ )
        {
            var_16af507c59384dee[ var_16af507c59384dee.size ] = var_110dce6d38f582a6[ var_e5df84b3a2ddf25a ];
        }
        
        var_255e71c65c58ca89 = [];
        
        if ( var_16af507c59384dee.size > 0 && isdefined( attack_target_ent ) )
        {
            secondary_target_range = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_76982f709c010e9 ?? 250;
            var_1ecb4d67846f3df8 = physics_querypoint( attack_target_ent.origin, secondary_target_range, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self, attack_target_ent ], "physicsquery_all" );
            
            foreach ( potential_target in var_1ecb4d67846f3df8 )
            {
                if ( var_16af507c59384dee.size <= 0 )
                {
                    break;
                }
                
                target_ent = potential_target[ "entity" ];
                
                if ( !isalive( target_ent ) || target_ent.team == self.team )
                {
                    continue;
                }
                
                is_on_right = math::function_84e592007021cc09( target_ent.origin - self.origin, head_forward_vec );
                
                if ( is_on_right )
                {
                    if ( arraycontains( var_16af507c59384dee, 2 ) )
                    {
                        var_16af507c59384dee = arrayremove( var_16af507c59384dee, 2 );
                        var_255e71c65c58ca89[ 2 ] = target_ent;
                    }
                }
                else if ( arraycontains( var_16af507c59384dee, 0 ) )
                {
                    var_16af507c59384dee = arrayremove( var_16af507c59384dee, 0 );
                    var_255e71c65c58ca89[ 0 ] = target_ent;
                }
                
                /#
                    function_ba3b0c32f8e1d7a1( "<dev string:xc9>" + ( is_on_right ? "<dev string:xd3>" : "<dev string:xd9>" ), target_ent.origin + ( 0, 0, 70 ) );
                #/
            }
        }
        
        primary_head_index = var_110dce6d38f582a6[ 0 ];
        
        foreach ( var_e8b483d049d7276b in var_110dce6d38f582a6 )
        {
            var_dc69dd01be7a0cd6 = undefined;
            var_52fb69a88bc5c9b3 = var_e8b483d049d7276b == primary_head_index;
            
            if ( var_52fb69a88bc5c9b3 || isdefined( var_255e71c65c58ca89[ var_e8b483d049d7276b ] ) )
            {
                target_ent = var_52fb69a88bc5c9b3 ? attack_target_ent : var_255e71c65c58ca89[ var_e8b483d049d7276b ];
                var_dc69dd01be7a0cd6 = function_67b74f762e331631( var_a1abee9062687674[ var_e8b483d049d7276b ], target_ent, var_e8b483d049d7276b, var_52fb69a88bc5c9b3, var_cbae022e329d2a51, var_f06c3d8143b76949, var_23a7ec979fd4a84c, var_255fcf4526cbba4e );
            }
            else
            {
                var_dc69dd01be7a0cd6 = var_a1abee9062687674[ primary_head_index ];
            }
            
            var_a1abee9062687674[ var_e8b483d049d7276b ] = function_760bace0ade9b0b0( var_a1abee9062687674[ var_e8b483d049d7276b ], var_dc69dd01be7a0cd6 );
            var_7a8c168bf4869367[ var_e8b483d049d7276b ] = function_fd2c98f631ee19f9( var_a1abee9062687674[ var_e8b483d049d7276b ], var_cbae022e329d2a51, var_f06c3d8143b76949, var_273d51c17a5acf2 );
        }
        
        beam_end_points = [];
        var_3a13dbe5f9e2617a = [];
        var_f643d05a1eb01ec0 = [];
        current_time = gettime();
        assert( isdefined( self.abom_beam_ents ) );
        
        for ( abom_head_index = 0; abom_head_index <= 2 ; abom_head_index++ )
        {
            if ( namespace_ad681b768a39ef59::is_head_alive( self, abom_head_index ) )
            {
                source_pos = self gettagorigin( self.var_80a2b3edd3d43109[ abom_head_index ] );
                end_pos = undefined;
                var_42d66caabe0b20db = trace::ray_trace( self getcentroid(), source_pos );
                var_925c7adfed1216b4 = var_42d66caabe0b20db[ "fraction" ] < 1;
                
                if ( var_925c7adfed1216b4 )
                {
                    end_pos = source_pos;
                }
                else
                {
                    var_42d66caabe0b20db = trace::ray_trace( source_pos, var_7a8c168bf4869367[ abom_head_index ] );
                    end_pos = var_7a8c168bf4869367[ abom_head_index ];
                    var_e87806c43847a66b = physics_getsurfacetypefromflags( var_42d66caabe0b20db[ "surfaceflags" ] );
                    stringsurfacename = var_e87806c43847a66b[ "name" ];
                    
                    if ( isstartstr( stringsurfacename, "surftype_water" ) )
                    {
                        var_42d66caabe0b20db = trace::ray_trace( var_42d66caabe0b20db[ "position" ], var_7a8c168bf4869367[ abom_head_index ] );
                    }
                    
                    var_925c7adfed1216b4 = var_42d66caabe0b20db[ "fraction" ] < 1;
                    
                    if ( var_925c7adfed1216b4 )
                    {
                        end_pos = var_42d66caabe0b20db[ "position" ];
                    }
                }
                
                is_beam_tip_off = self.abom_beam_ents[ abom_head_index ] getscriptablepartstate( "beam_tip" ) == "off";
                
                if ( is_beam_tip_off || var_925c7adfed1216b4 != self.var_ad197ca11c039e90[ abom_head_index ] )
                {
                    if ( var_925c7adfed1216b4 )
                    {
                        self.abom_beam_ents[ abom_head_index ] utility::function_7c10ea82c1e305b8( "beam_tip", "hit" );
                    }
                    else
                    {
                        self.abom_beam_ents[ abom_head_index ] utility::function_7c10ea82c1e305b8( "beam_tip", "hit_nothing" );
                    }
                }
                
                var_90ec0886f9ccf215 = var_42d66caabe0b20db[ "entity" ];
                
                if ( isdefined( var_90ec0886f9ccf215 ) )
                {
                    self.var_a9983e721f3b21c2 = current_time;
                    entnum = var_90ec0886f9ccf215 getentitynumber();
                    
                    if ( !isdefined( var_3a13dbe5f9e2617a[ entnum ] ) )
                    {
                        var_3a13dbe5f9e2617a[ entnum ] = 1;
                    }
                    
                    var_f643d05a1eb01ec0[ entnum ] = var_90ec0886f9ccf215;
                }
                
                self.var_ad197ca11c039e90[ abom_head_index ] = var_925c7adfed1216b4;
                beam_end_points[ abom_head_index ] = end_pos;
                
                if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_986a17b1124ae7b1 )
                {
                    var_ad9d8ca78535f0c6 = 5;
                    var_2a51ba6ec942e424 = end_pos - source_pos;
                    var_273d51c17a5acf2 = length( var_2a51ba6ec942e424 );
                    var_61738d6e36d76ebd = vectornormalize( var_2a51ba6ec942e424 );
                    var_3f82a913d4fd93c3 = var_ad9d8ca78535f0c6;
                    var_53ee1d63dbf83a50 = var_273d51c17a5acf2 - var_ad9d8ca78535f0c6;
                    var_7707abb2b8096f8e = var_ad9d8ca78535f0c6 * 2;
                    var_a4d7ccdceaa16d1e = var_3f82a913d4fd93c3;
                    
                    while ( var_a4d7ccdceaa16d1e <= var_53ee1d63dbf83a50 )
                    {
                        var_526ab22d759a55e5 = source_pos + var_61738d6e36d76ebd * var_a4d7ccdceaa16d1e;
                        radiusdamage( var_526ab22d759a55e5, var_ad9d8ca78535f0c6, 1000, 1000, self, undefined, undefined, 1 );
                        var_a4d7ccdceaa16d1e += var_7707abb2b8096f8e;
                    }
                }
            }
        }
        
        for ( abom_head_index = 0; abom_head_index <= 2 ; abom_head_index++ )
        {
            if ( namespace_ad681b768a39ef59::is_head_alive( self, abom_head_index ) )
            {
                target_ent = self.abom_beam_ents[ abom_head_index ];
                target_ent.origin = beam_end_points[ abom_head_index ];
                
                if ( !var_4d1ae168acdc2749 )
                {
                    target_ent dontinterpolate();
                    self.var_7510382f5bd18e6e[ abom_head_index ] = playfxontagsbetweenclients( utility::getfx( "abom_beam_fx" ), self, self.var_80a2b3edd3d43109[ abom_head_index ], target_ent, "tag_origin" );
                    
                    if ( isdefined( self.var_7510382f5bd18e6e[ abom_head_index ] ) )
                    {
                        self.var_7510382f5bd18e6e[ abom_head_index ] namespace_9d8e359c3b1041e5::forcenetfieldhighlod_sharedfunc( 1 );
                    }
                    
                    utility::function_32b24db3127bff40( self.var_885001fb6c6706f8[ abom_head_index ] + "_weakpoint", "weakpoint_off" );
                    utility::function_32b24db3127bff40( self.var_885001fb6c6706f8[ abom_head_index ] + "_beam", "beam_on" );
                }
            }
        }
        
        var_4d1ae168acdc2749 = 1;
        
        if ( !beam_audio_active )
        {
            var_a00e1026570d5f6a = 0;
            
            for ( abom_head_index = 0; abom_head_index <= 2 ; abom_head_index++ )
            {
                if ( namespace_ad681b768a39ef59::is_head_alive( self, abom_head_index ) )
                {
                    var_a00e1026570d5f6a++;
                }
            }
            
            if ( var_a00e1026570d5f6a > 0 )
            {
                utility::function_32b24db3127bff40( "beam_audio", "beam_audio_on_" + var_a00e1026570d5f6a );
            }
            
            beam_audio_active = 1;
        }
        
        foreach ( entnum, var_29a127c04ade1da1 in var_3a13dbe5f9e2617a )
        {
            var_90ec0886f9ccf215 = var_f643d05a1eb01ec0[ entnum ];
            
            if ( !isdefined( var_90ec0886f9ccf215 ) )
            {
                continue;
            }
            
            assert( var_29a127c04ade1da1 > 0 );
            
            if ( !var_90ec0886f9ccf215 utility::ent_flag( "abom_beam_attack_hit" ) )
            {
                var_a0684ccb4c773bce = isai( var_90ec0886f9ccf215 ) && isdefined( var_90ec0886f9ccf215.subclass ) && issubstr( var_90ec0886f9ccf215.subclass, "zombie_base" );
                
                if ( var_a0684ccb4c773bce && self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ffb9d09ce59952d3 )
                {
                    var_90ec0886f9ccf215 utility::ent_flag_set( "dissolve" );
                    
                    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b290380b8f8d1c67 > 0 )
                    {
                        kill_info = spawnstruct();
                        kill_info.ent = var_90ec0886f9ccf215;
                        kill_info.time = current_time + self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b290380b8f8d1c67;
                        var_1eba9c6d8c04574e[ var_1eba9c6d8c04574e.size ] = kill_info;
                    }
                    else
                    {
                        var_90ec0886f9ccf215 kill( self.origin, self, self, "MOD_PROJECTILE" );
                    }
                }
                else
                {
                    damage = function_b893a9e913cea804( self, var_90ec0886f9ccf215, var_29a127c04ade1da1, var_a0684ccb4c773bce );
                    var_90ec0886f9ccf215 dodamage( damage, self.origin, self, self, "MOD_PROJECTILE" );
                    
                    if ( var_a0684ccb4c773bce && damage > var_90ec0886f9ccf215.health )
                    {
                        var_90ec0886f9ccf215 utility::ent_flag_set( "dissolve" );
                    }
                    
                    /#
                        function_ba3b0c32f8e1d7a1( "<dev string:xde>" + var_90ec0886f9ccf215 getentitynumber() + "<dev string:xec>" + damage, var_90ec0886f9ccf215.origin + ( 0, 0, 72 ) );
                    #/
                    
                    if ( isplayer( var_90ec0886f9ccf215 ) )
                    {
                        var_90ec0886f9ccf215 playsoundevent( %"sndevent_abom_beam_hit_player" );
                    }
                }
                
                if ( isdefined( var_90ec0886f9ccf215 ) )
                {
                    var_90ec0886f9ccf215 utility::ent_flag_set( "abom_beam_attack_hit" );
                    var_90ec0886f9ccf215 thread utility::ent_flag_clear_delayed( "abom_beam_attack_hit", 0.2 );
                }
            }
        }
        
        for ( var_2fc4b03d55e6ccad = var_1eba9c6d8c04574e.size - 1; var_2fc4b03d55e6ccad >= 0 ; var_2fc4b03d55e6ccad-- )
        {
            if ( current_time >= var_1eba9c6d8c04574e[ var_2fc4b03d55e6ccad ].time )
            {
                if ( isalive( var_1eba9c6d8c04574e[ var_2fc4b03d55e6ccad ].ent ) )
                {
                    var_1eba9c6d8c04574e[ var_2fc4b03d55e6ccad ].ent kill( self.origin, self, self, "MOD_PROJECTILE" );
                }
                
                var_1eba9c6d8c04574e[ var_2fc4b03d55e6ccad ] = var_1eba9c6d8c04574e[ var_1eba9c6d8c04574e.size - 1 ];
                var_1eba9c6d8c04574e[ var_1eba9c6d8c04574e.size - 1 ] = undefined;
            }
        }
        
        /#
            if ( debug_beam_attack() )
            {
                for ( abom_head_index = 0; abom_head_index <= 2 ; abom_head_index++ )
                {
                    sphere( var_7a8c168bf4869367[ abom_head_index ], 50, ( 1, 0, 0 ) );
                    
                    if ( isdefined( beam_end_points[ abom_head_index ] ) )
                    {
                        sphere( beam_end_points[ abom_head_index ], 20, ( 1, 0, 0 ) );
                        line( self gettagorigin( self.var_80a2b3edd3d43109[ abom_head_index ] ), beam_end_points[ abom_head_index ], ( 1, 0, 0 ) );
                    }
                }
            }
        #/
        
        waitframe();
    }
}

// Namespace namespace_ce58d65bf2615c99
// Params 0, eflags: 0x4
// Checksum 0xd978bf34, Offset: 0x1564
// Size: 0xa7
function private function_35c19e0bf9b095b8()
{
    var_cefde9e1993dd369 = [];
    ideal_head_priority = [ 1, 0, 2 ];
    
    foreach ( var_e8b483d049d7276b in ideal_head_priority )
    {
        if ( namespace_ad681b768a39ef59::is_head_alive( self, var_e8b483d049d7276b ) )
        {
            var_cefde9e1993dd369[ var_cefde9e1993dd369.size ] = var_e8b483d049d7276b;
        }
    }
    
    return var_cefde9e1993dd369;
}

// Namespace namespace_ce58d65bf2615c99
// Params 8, eflags: 0x4
// Checksum 0xe2d70fc1, Offset: 0x1614
// Size: 0x194
function private function_67b74f762e331631( var_340b7107c0229bd, attack_target_ent, var_e8b483d049d7276b, is_primary_target, var_cbae022e329d2a51, var_f06c3d8143b76949, var_23a7ec979fd4a84c, var_dfd81338b20e87b1 )
{
    if ( isdefined( attack_target_ent ) )
    {
        var_44dc9fcddc629a5d = attack_target_ent getcentroid();
        var_8a8157493bb7b59a = ( var_44dc9fcddc629a5d[ 2 ] - attack_target_ent.origin[ 2 ] ) * 2;
        var_2315701dfa5d6fa = gettime() - ( self.var_a9983e721f3b21c2 ?? 0 );
        missing_time_threshold = 1000;
        target_height_percentage = clamp( math::remap( var_2315701dfa5d6fa, 0, missing_time_threshold, 0, 1 ), 0, 0.8 );
        target_z_offset = ( 0, 0, var_8a8157493bb7b59a * target_height_percentage );
        
        /#
            function_ba3b0c32f8e1d7a1( "<dev string:xf3>" + target_height_percentage, attack_target_ent.origin );
        #/
        
        target_pos = attack_target_ent.origin + target_z_offset;
        
        if ( is_primary_target )
        {
            self.var_e62205491dc1bcdb = target_pos;
        }
        
        to_target_angles = vectortoangles( target_pos - var_f06c3d8143b76949 );
        pitch_clamped = int( clamp( angleclamp180( to_target_angles[ 0 ] - var_cbae022e329d2a51[ 0 ] ), -1 * var_23a7ec979fd4a84c, var_23a7ec979fd4a84c ) );
        yaw_clamped = int( clamp( angleclamp180( to_target_angles[ 1 ] - var_cbae022e329d2a51[ 1 ] ), -1 * var_dfd81338b20e87b1, var_dfd81338b20e87b1 ) );
        var_62ed609f2ef3fd46 = ( pitch_clamped, yaw_clamped, 0 );
        return var_62ed609f2ef3fd46;
    }
    
    return var_340b7107c0229bd;
}

// Namespace namespace_ce58d65bf2615c99
// Params 2, eflags: 0x4
// Checksum 0xe594b19a, Offset: 0x17b1
// Size: 0xa5
function private function_760bace0ade9b0b0( var_340b7107c0229bd, var_27e885a684bcea95 )
{
    var_507dd18728f48ddc = getdvarfloat( @"hash_f3c398f445ce88db", self.var_e834bac54dd3efaa ) * level.framedurationseconds;
    var_91dd9f063f60182d = getdvarfloat( @"hash_829b91a5ea9d859a", self.var_4bce31da81afb507 ) * level.framedurationseconds;
    new_yaw = math::function_27800ff2fd4867c6( var_340b7107c0229bd[ 1 ], var_27e885a684bcea95[ 1 ], var_507dd18728f48ddc );
    var_915a422f3224a895 = math::function_27800ff2fd4867c6( var_340b7107c0229bd[ 0 ], var_27e885a684bcea95[ 0 ], var_91dd9f063f60182d );
    return ( var_915a422f3224a895, new_yaw, var_27e885a684bcea95[ 2 ] );
}

// Namespace namespace_ce58d65bf2615c99
// Params 4, eflags: 0x4
// Checksum 0xe4b1e043, Offset: 0x185f
// Size: 0x5d
function private function_fd2c98f631ee19f9( var_340b7107c0229bd, var_cbae022e329d2a51, var_f06c3d8143b76949, var_273d51c17a5acf2 )
{
    var_3683cc2d363befaa = angleclamp( var_cbae022e329d2a51 + var_340b7107c0229bd );
    var_6a684e76001b35ab = anglestoforward( var_3683cc2d363befaa );
    end_point = var_f06c3d8143b76949 + var_6a684e76001b35ab * var_273d51c17a5acf2;
    return end_point;
}

// Namespace namespace_ce58d65bf2615c99
// Params 0, eflags: 0x4
// Checksum 0x2d124870, Offset: 0x18c5
// Size: 0xed
function private beam_attack_on_end()
{
    self endon( #"death" );
    self waittill( #"beam_attack_loop_finished" );
    
    for ( abom_head_index = 0; abom_head_index <= 2 ; abom_head_index++ )
    {
        if ( isdefined( self.var_7510382f5bd18e6e[ abom_head_index ] ) )
        {
            self.var_7510382f5bd18e6e[ abom_head_index ] delete();
        }
        
        if ( isdefined( self.abom_beam_ents[ abom_head_index ] ) )
        {
            self.abom_beam_ents[ abom_head_index ] utility::function_7c10ea82c1e305b8( "beam_tip", "end" );
        }
        
        utility::function_32b24db3127bff40( self.var_885001fb6c6706f8[ abom_head_index ] + "_beam", "beam_off" );
        utility::function_32b24db3127bff40( "beam_audio", "beam_audio_end" );
    }
    
    self clearpath();
    self clearbtgoal( 0 );
    self setbtgoalstationary( 0 );
    
    if ( utility::ent_flag( "no_beam_attack_cooldown" ) )
    {
        self function_786bb6aa1b76c7ee( "beam_attack_next", 0 );
        utility::ent_flag_clear( "no_beam_attack_cooldown" );
    }
}

// Namespace namespace_ce58d65bf2615c99
// Params 1, eflags: 0x4
// Checksum 0x1bcb8f1f, Offset: 0x19ba
// Size: 0x48
function private cleanup_beam_ents( params )
{
    for ( abom_head_index = 0; abom_head_index <= 2 ; abom_head_index++ )
    {
        if ( isdefined( self.var_7510382f5bd18e6e[ abom_head_index ] ) )
        {
            self.var_7510382f5bd18e6e[ abom_head_index ] delete();
        }
    }
}

// Namespace namespace_ce58d65bf2615c99
// Params 0, eflags: 0x4
// Checksum 0x6dfce2e2, Offset: 0x1a0a
// Size: 0x67
function private function_4f22c055483197a2()
{
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ef4c94e8dddcdc5b )
    {
        return;
    }
    
    if ( utility::ent_flag( "on_followup_beam_cooldown" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "on_followup_beam_cooldown" );
    var_4c86d9880653f245 = 20;
    thread utility::ent_flag_clear_delayed( "on_followup_beam_cooldown", var_4c86d9880653f245 );
    utility::ent_flag_set( "no_beam_attack_cooldown" );
}

/#

    // Namespace namespace_ce58d65bf2615c99
    // Params 0
    // Checksum 0xb79af4a7, Offset: 0x1a79
    // Size: 0x44, Type: dev
    function function_d0a88666aaee23d4()
    {
        devgui::function_9082edeb5db93280( "<dev string:x105>" );
        devgui::add_devgui_func( "<dev string:x122>", "<dev string:x134>", &force_beam_attack );
        devgui::add_devgui_func( "<dev string:x14b>", "<dev string:x15d>", &function_1a3b3a6ad2d7ea45 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_ce58d65bf2615c99
    // Params 0, eflags: 0x4
    // Checksum 0xc63f7499, Offset: 0x1ac5
    // Size: 0x70, Type: dev
    function private force_beam_attack()
    {
        Abom = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x174>" );
        
        if ( !isdefined( Abom ) )
        {
            Abom = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x180>" );
        }
        
        if ( !isdefined( Abom ) )
        {
            return;
        }
        
        Abom function_786bb6aa1b76c7ee( "<dev string:x191>", 1 );
    }

    // Namespace namespace_ce58d65bf2615c99
    // Params 0, eflags: 0x4
    // Checksum 0xbd834854, Offset: 0x1b3d
    // Size: 0x16, Type: dev
    function private debug_beam_attack()
    {
        return getdvarint( @"hash_e89dc8c72b8a01da", 0 ) > 0;
    }

    // Namespace namespace_ce58d65bf2615c99
    // Params 0, eflags: 0x4
    // Checksum 0xa3155eec, Offset: 0x1b5b
    // Size: 0x1a, Type: dev
    function private function_1a3b3a6ad2d7ea45()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x1a0>", @"hash_e89dc8c72b8a01da" );
    }

    // Namespace namespace_ce58d65bf2615c99
    // Params 2, eflags: 0x4
    // Checksum 0xee4e2acb, Offset: 0x1b7d
    // Size: 0x5b, Type: dev
    function private function_ba3b0c32f8e1d7a1( text, pos )
    {
        if ( debug_beam_attack() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x1b7>" + text, ( 1, 0, 0 ) );
        }
    }

#/
