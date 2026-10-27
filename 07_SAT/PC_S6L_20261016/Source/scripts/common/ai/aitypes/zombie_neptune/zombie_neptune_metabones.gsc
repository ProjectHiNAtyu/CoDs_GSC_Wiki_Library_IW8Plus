// scripts\common\ai\aitypes\zombie_neptune\zombie_neptune_metabones.gsc  (hash_6b5b2be0d172bfbd.gscc) (size: 9521 Bytes / 0x2531 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x832de0f6 (2200822006)
// size ...... 9521 (0x2531)
// includes .. 4   (offset: 0x2329)
// strings ... 27  (offset: 0x2349)
// dev strs .. 5   (offset: 0x24f5)
// exports ... 18  (offset: 0x1959)
// cseg ...... 0x270 + 0x16e9 (0x1959)
// imports ... 57  (offset: 0x1c29)
// animtree1 . 0   (offset: 0x2531)
// animtree2 . 0   (offset: 0x2531)
#using scripts\asm\asm;
#using scripts\common\math;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_neptune_metabones;

// Namespace zombie_neptune_metabones
// Params 0, eflags: 0x1
// Checksum 0x57ca1a7d, Offset: 0x28e
// Size: 0x13
function autoexec main()
{
    metabone::function_cd947f1a3391c065( "zombie_neptune", &on_metabone_destroyed );
}

// Namespace zombie_neptune_metabones
// Params 0
// Checksum 0x844bc7d3, Offset: 0x2a9
// Size: 0x9a
function init_zombie_neptune_metabones()
{
    metabone::function_b68bd9932f284448( &function_72d6e080cafd882d );
    self.armors = [];
    self.used_weakpoints = [];
    self.destroyed_armors = 0;
    
    for ( i = 1; i <= 8 ; i++ )
    {
        metabone_name = "body_weakpoint" + i;
        self.armors[ self.armors.size ] = metabone_name;
    }
    
    thread init_armor_ents();
    self.var_f9fea550f453e62 = arraycopy( self.armors );
    function_beba47dca93e09e1( "armored" );
}

// Namespace zombie_neptune_metabones
// Params 3
// Checksum 0x7cd8a98c, Offset: 0x34b
// Size: 0x13a
function function_bc9300a17f3a6e6e( boss, target, phase )
{
    for ( index = 1; index <= 8 ; index++ )
    {
        metabone_name = "body_weakpoint" + index;
        
        if ( boss )
        {
            armorstate = boss getscriptablepartstate( metabone_name );
            array = strtok( armorstate, "_" );
            prefix = "";
            
            for ( i = 0; i < array.size - 1 ; i++ )
            {
                prefix += array[ i ] + "_";
            }
            
            if ( prefix == "" )
            {
                newstate = "off";
            }
            else
            {
                if ( prefix != "armored_" && !issubstr( prefix, "loop" ) )
                {
                    prefix += "loop_";
                }
                
                newstate = prefix + phase;
            }
        }
        else
        {
            newstate = "armored_" + phase;
        }
        
        /#
            if ( getdvarint( @"hash_3bec80bca38c2a91", 0 ) )
            {
                logstring( "<dev string:x24>" + metabone_name + "<dev string:x45>" + newstate );
            }
        #/
        
        target utility::function_7c10ea82c1e305b8( metabone_name, newstate );
    }
}

// Namespace zombie_neptune_metabones
// Params 1, eflags: 0x4
// Checksum 0x44fedba1, Offset: 0x48d
// Size: 0x474
function private on_metabone_destroyed( params )
{
    self endon( #"death" );
    metabone_name = params.metabone_name;
    
    if ( !self getscriptablehaspart( metabone_name ) )
    {
        assertmsg( "<dev string:x4e>" + metabone_name );
        return;
    }
    
    metabone_state = metabone::get_metabone_state_name( metabone_name );
    self.destroyed_armors += 1;
    
    if ( metabone_state == "exposed" )
    {
        assertmsg( "<dev string:x79>" );
    }
    else if ( self.exposed_weakpoint && self.exposed_weakpoint == metabone_name )
    {
        self setscriptablepartstate( self.exposed_weakpoint, "weakpoint_exposed" + "_" + self.n_fight_phase );
        metabone::set_metabone_state( self.exposed_weakpoint, "exposed" );
        metabone::set_metabone_active( metabone_name, 1 );
        self.used_weakpoints[ self.used_weakpoints.size ] = self.exposed_weakpoint;
    }
    else
    {
        self.armor_ents[ metabone_name ] setscriptablepartstate( "armor", "destroyed" );
        self setscriptablepartstate( metabone_name, "armor_destroyed" + "_" + self.n_fight_phase );
        metabone::set_metabone_state( metabone_name, "destroyed" );
        metabone::set_metabone_active( metabone_name, 0 );
        self.var_f9fea550f453e62 = arrayremove( self.var_f9fea550f453e62, metabone_name );
        
        if ( !self.exposed_weakpoint && function_f1b950ac8141db57() && self.var_f9fea550f453e62.size > 0 )
        {
            var_f945b4c9ad59cbb4 = [];
            
            foreach ( armor in self.var_f9fea550f453e62 )
            {
                self.armor_ents[ armor ] disableaimassist();
                
                if ( !arraycontains( self.used_weakpoints, armor ) )
                {
                    var_f945b4c9ad59cbb4[ var_f945b4c9ad59cbb4.size ] = armor;
                }
            }
            
            self.exposed_weakpoint = utility::array_random( var_f945b4c9ad59cbb4 );
            self.armor_ents[ self.exposed_weakpoint ] enableaimassist();
        }
        else
        {
            self.armor_ents[ metabone_name ] disableaimassist();
            var_e238563c60c9573b = math::lerp_fraction( self.armor_ents.size, 0, self.var_f9fea550f453e62.size );
            var_d9fb50065e63b655 = math::lerp( 0.2, 0.6, var_e238563c60c9573b );
            
            foreach ( var_31d2ba3f834f13d8 in self.var_f9fea550f453e62 )
            {
                if ( var_31d2ba3f834f13d8 != self.exposed_weakpoint )
                {
                    var_cf5c37be5c9c2925 = metabone::get_metabone_health( var_31d2ba3f834f13d8 ) * var_d9fb50065e63b655;
                    metabone::damage_metabone( var_31d2ba3f834f13d8, var_cf5c37be5c9c2925, params.eattacker, params.einflictor, params.vdir );
                }
            }
        }
    }
    
    if ( isalive( self ) && !self.var_69bdeb508231beb4 && ( !isdefined( self.var_32321bd0fe655f49 ) || utility::time_has_passed( self.var_32321bd0fe655f49, 8 ) ) )
    {
        switch ( metabone_name )
        {
            case #"hash_1afba0948a426523":
            case #"hash_1afba1948a4266b6":
            case #"hash_1afba2948a426849":
            case #"hash_1afba3948a4269dc":
                self function_786bb6aa1b76c7ee( "right_armor_break", 0 );
                break;
            case #"hash_1afba4948a426b6f":
            case #"hash_1afba5948a426d02":
            case #"hash_1afba6948a426e95":
            case #"hash_1afba7948a427028":
                self function_786bb6aa1b76c7ee( "right_armor_break", 1 );
                break;
            default:
                self function_786bb6aa1b76c7ee( "right_armor_break", 1 );
                break;
        }
        
        asm::function_7256f5ba459c840b( "armor_break_pain_in" );
        self.var_32321bd0fe655f49 = gettime();
    }
}

// Namespace zombie_neptune_metabones
// Params 0
// Checksum 0x9141cb87, Offset: 0x909
// Size: 0x151
function reset_metabones()
{
    foreach ( metabone_info in self.metabones.info )
    {
        metabone_info.var_9001c14ad8db7425 = undefined;
    }
    
    foreach ( metabone_name in self.armors )
    {
        metabone::function_50a0af5f47ae9a88( metabone_name );
        self setscriptablepartstate( metabone_name, "armored" + "_" + self.n_fight_phase );
    }
    
    function_beba47dca93e09e1( "armored" );
    self.var_f9fea550f453e62 = arraycopy( self.armors );
    self.exposed_weakpoint = undefined;
    self.destroyed_armors = 0;
}

// Namespace zombie_neptune_metabones
// Params 0
// Checksum 0x187e7473, Offset: 0xa62
// Size: 0x7a
function set_weakpoint_destroyed()
{
    if ( self.exposed_weakpoint )
    {
        self setscriptablepartstate( self.exposed_weakpoint, "weakpoint_destroyed" + "_" + self.n_fight_phase );
        metabone::set_metabone_state( self.exposed_weakpoint, "destroyed" );
        metabone::set_metabone_active( self.exposed_weakpoint, 0 );
        self.armor_ents[ self.exposed_weakpoint ] disableaimassist();
        self.exposed_weakpoint = undefined;
    }
}

// Namespace zombie_neptune_metabones
// Params 0
// Checksum 0x385b1fec, Offset: 0xae4
// Size: 0x97
function function_c35ccbc3b1fbcab9()
{
    foreach ( metabone_name in self.armors )
    {
        self setscriptablepartstate( metabone_name, "off" );
        metabone::set_metabone_state( metabone_name, "destroyed" );
        metabone::set_metabone_active( metabone_name, 0 );
    }
}

// Namespace zombie_neptune_metabones
// Params 0, eflags: 0x4
// Checksum 0xaf7fe3c2, Offset: 0xb83
// Size: 0x1eb
function private init_armor_ents()
{
    self endon( #"death" );
    self waittill( #"zombie_asm_init_finished" );
    armor_ents = [];
    metabonesdef = metabone::get_metabones_def( self.metabones.bundle_name );
    
    foreach ( metabone in metabonesdef.metabones )
    {
        if ( isdefined( metabone.tags ) )
        {
            foreach ( tag in metabone.tags )
            {
                tagorigin = self gettagorigin( tag.tagname );
                armor_piece = utility::spawn_model( "sat_neptune_armor_piece_ping", tagorigin, self.angles );
                armor_piece linkto( self, tag.tagname, ( 0, 0, 0 ), ( 0, 0, 0 ) );
                armor_piece.tagname = tag.tagname;
                armor_piece enableaimassist();
                armor_piece setscriptablepartstate( "armor", "armored" );
                armor_ents[ metabone.name ] = armor_piece;
            }
        }
    }
    
    self.armor_ents = armor_ents;
}

// Namespace zombie_neptune_metabones
// Params 0
// Checksum 0x5c2d98bc, Offset: 0xd76
// Size: 0x83
function function_4b681aa0314b80e3()
{
    foreach ( metabone_name in self.armors )
    {
        self.armor_ents[ metabone_name ] delete();
    }
}

// Namespace zombie_neptune_metabones
// Params 0
// Checksum 0x33e6ca26, Offset: 0xe01
// Size: 0x9e
function function_4f4390eb16a079e7()
{
    foreach ( metabone_name in self.armors )
    {
        self.armor_ents[ metabone_name ] setscriptablepartstate( "armor", "off" );
        self.armor_ents[ metabone_name ] disableaimassist();
    }
}

// Namespace zombie_neptune_metabones
// Params 0
// Checksum 0xc8fe84cc, Offset: 0xea7
// Size: 0x9e
function function_df24f103eff2798b()
{
    foreach ( metabone_name in self.armors )
    {
        self.armor_ents[ metabone_name ] setscriptablepartstate( "armor", "armored" );
        self.armor_ents[ metabone_name ] enableaimassist();
    }
}

// Namespace zombie_neptune_metabones
// Params 1, eflags: 0x4
// Checksum 0x72f61a56, Offset: 0xf4d
// Size: 0xa9
function private function_beba47dca93e09e1( state )
{
    foreach ( metabone_name in self.armors )
    {
        metabone::set_metabone_state( metabone_name, state );
        
        if ( state == "destroyed" )
        {
            metabone::set_metabone_active( metabone_name, 0 );
            continue;
        }
        
        metabone::set_metabone_active( metabone_name, 1 );
    }
}

// Namespace zombie_neptune_metabones
// Params 0, eflags: 0x4
// Checksum 0x15799ef1, Offset: 0xffe
// Size: 0x99, Type: bool
function private function_f1b950ac8141db57()
{
    if ( self.n_fight_phase == 1 && self.destroyed_armors / self.armors.size >= 0.2 )
    {
        return true;
    }
    else if ( self.n_fight_phase == 2 && self.destroyed_armors / self.armors.size >= 0.33 )
    {
        return true;
    }
    else if ( self.n_fight_phase == 3 && self.destroyed_armors / self.armors.size >= 0.5 )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_neptune_metabones
// Params 1, eflags: 0x4
// Checksum 0xee18f6bb, Offset: 0x10a0
// Size: 0x646
function private function_72d6e080cafd882d( dmgstruct )
{
    if ( self getaiblackboarddynamic( "immune" ) )
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
    
    if ( !isdefined( self.var_dc2c5d4cc5e1cf2 ) )
    {
        self.var_dc2c5d4cc5e1cf2 = [];
    }
    
    for ( i = 1; i <= 3 ; i++ )
    {
        if ( !isdefined( self.var_dc2c5d4cc5e1cf2[ i ] ) )
        {
            self.var_dc2c5d4cc5e1cf2[ i ] = [];
        }
    }
    
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    if ( self.var_dc2c5d4cc5e1cf2[ self.n_fight_phase ].size <= 0 )
    {
        for ( i = 0; i < 8 ; i++ )
        {
            tag_name = settings.var_2b27e7b88333b576[ self.n_fight_phase - 1 ].hitdata[ i ].tagname;
            radius = settings.var_2b27e7b88333b576[ self.n_fight_phase - 1 ].hitdata[ i ].radius;
            penetration = settings.var_2b27e7b88333b576[ self.n_fight_phase - 1 ].hitdata[ i ].penetrationdist;
            self.var_dc2c5d4cc5e1cf2[ self.n_fight_phase ][ tag_name ] = { #penetration:penetration, #radius:radius };
        }
    }
    
    hit_metabone = undefined;
    var_3a114e8cd22bc712 = undefined;
    metabones = metabone::get_metabones_def( self.metabones.bundle_name );
    var_390a0a50a177ab79 = 0;
    
    foreach ( metabone in metabones.metabones )
    {
        if ( var_390a0a50a177ab79 )
        {
            break;
        }
        
        if ( isdefined( metabone.tags ) )
        {
            foreach ( tag in metabone.tags )
            {
                detection_data = self.var_dc2c5d4cc5e1cf2[ self.n_fight_phase ];
                
                if ( self.exposed_weakpoint == metabone.name )
                {
                    radius = detection_data[ tag.tagname ].radius * 2;
                }
                else
                {
                    radius = detection_data[ tag.tagname ].radius;
                }
                
                penetration = detection_data[ tag.tagname ].penetration;
                tag_origin = self gettagorigin( tag.tagname );
                
                if ( dmgstruct.sweapon.ismelee || dmgstruct.sweapon.classname == "rocketlauncher" || dmgstruct.sweapon.classname == "beam" )
                {
                    var_16023fbab228140e = 5;
                    attacker_eye_pos = dmgstruct.eattacker geteye();
                    attack_dir = vectornormalize( dmgstruct.vpoint - attacker_eye_pos );
                    penetration_displacement = attack_dir * penetration * var_16023fbab228140e;
                    final_pos = dmgstruct.vpoint + penetration_displacement;
                }
                else
                {
                    final_pos = dmgstruct.vpoint + dmgstruct.vdir * penetration;
                }
                
                if ( !math::segmentvssphere( dmgstruct.vpoint, final_pos, tag_origin, radius ) )
                {
                    continue;
                }
                
                if ( !isdefined( hit_metabone ) || distancesquared( dmgstruct.vpoint, tag_origin ) < distancesquared( dmgstruct.vpoint, var_3a114e8cd22bc712 ) )
                {
                    hit_metabone = metabone.name;
                    var_3a114e8cd22bc712 = tag_origin;
                    var_3de89d96d0db610 = self gettagangles( tag.tagname );
                    var_2a08a6acd5b8e750 = self.exposed_weakpoint == hit_metabone && metabone::get_metabone_state_name( hit_metabone ) == "exposed";
                    
                    if ( var_2a08a6acd5b8e750 )
                    {
                        var_390a0a50a177ab79 = 1;
                        break;
                    }
                }
            }
        }
    }
    
    if ( hit_metabone == "body_weakpoint5" || hit_metabone == "body_weakpoint6" )
    {
        var_d4ff70079867cf67 = 0;
        forwardvec = anglestoforward( self.angles );
        
        if ( isdefined( dmgstruct.vdir ) && vectordot( dmgstruct.vdir, forwardvec ) > var_d4ff70079867cf67 )
        {
            return;
        }
    }
    
    is_ruby_ww = issubstr( dmgstruct.sweapon.basename, "ww_ruby" );
    
    if ( is_ruby_ww && !hit_metabone )
    {
        if ( randomfloat( 1 ) < 0.5 )
        {
            metabone_struct = function_2ef55522054544ef( dmgstruct.vpoint, metabones );
            
            if ( metabone_struct )
            {
                hit_metabone = metabone_struct.name;
            }
        }
    }
    
    if ( var_390a0a50a177ab79 && isdefined( var_3a114e8cd22bc712 ) && isdefined( var_3de89d96d0db610 ) )
    {
        thread function_f95b85ccdaa2265e( hit_metabone, var_3a114e8cd22bc712, var_3de89d96d0db610 );
    }
    
    return hit_metabone;
}

// Namespace zombie_neptune_metabones
// Params 2, eflags: 0x4
// Checksum 0xe8d71d50, Offset: 0x16ef
// Size: 0x197
function private function_2ef55522054544ef( point, metabones )
{
    closest = undefined;
    closest_dist = undefined;
    
    foreach ( metabone in metabones.metabones )
    {
        if ( !isdefined( metabone.tags ) )
        {
            continue;
        }
        
        if ( metabone::get_metabone_state_name( metabone.name ) != "armored" )
        {
            continue;
        }
        
        foreach ( tag in metabone.tags )
        {
            tag_name = tag.tagname;
            tag_origin = self gettagorigin( tag_name );
            
            if ( !isdefined( tag_origin ) )
            {
                continue;
            }
            
            dist = distance( point, tag_origin );
            
            if ( !isdefined( closest_dist ) || closest_dist < dist )
            {
                closest_dist = dist;
                closest = metabone;
            }
        }
    }
    
    return closest;
}

// Namespace zombie_neptune_metabones
// Params 3
// Checksum 0x6a0de93c, Offset: 0x188f
// Size: 0x6c
function function_f95b85ccdaa2265e( hit_metabone, var_3a114e8cd22bc712, var_3de89d96d0db610 )
{
    level endon( #"game_ended" );
    weakpoint_scriptable = spawnscriptable( "scriptable_zombie_neptune_weakpoint_impact", var_3a114e8cd22bc712, var_3de89d96d0db610 );
    
    if ( weakpoint_scriptable )
    {
        weakpoint_scriptable setscriptablepartstate( "weakpoint_impact", "on_" + self.n_fight_phase );
    }
    
    wait 1;
    weakpoint_scriptable freescriptable();
}

/#

    // Namespace zombie_neptune_metabones
    // Params 2
    // Checksum 0x920d5f4e, Offset: 0x1903
    // Size: 0x56, Type: dev
    function function_70c027ae72258c9e( metabone_name, state )
    {
        level.zombie_neptune metabone::function_50a0af5f47ae9a88( metabone_name );
        level.zombie_neptune setscriptablepartstate( metabone_name, state + "<dev string:xcd>" + level.zombie_neptune.n_fight_phase );
    }

#/
