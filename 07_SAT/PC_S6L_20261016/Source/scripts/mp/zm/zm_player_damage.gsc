// scripts\mp\zm\zm_player_damage.gsc  (hash_302462c73c57ab93.gscc) (size: 3655 Bytes / 0xe47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ccb65aa (2093704618)
// size ...... 3655 (0xe47)
// includes .. 5   (offset: 0xd9b)
// strings ... 10  (offset: 0xdc3)
// dev strs .. 0   (offset: 0xe47)
// exports ... 2   (offset: 0x9cf)
// cseg ...... 0x117 + 0x8b8 (0x9cf)
// imports ... 30  (offset: 0xa1f)
// animtree1 . 0   (offset: 0xe47)
// animtree2 . 0   (offset: 0xe47)
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\damage;

#namespace zm_player_damage;

// Namespace zm_player_damage
// Params 1
// Checksum 0x725b1376, Offset: 0x135
// Size: 0x898
function function_8509d988e53f1c55( dmg_struct )
{
    profilestart();
    
    if ( isdefined( dmg_struct.eattacker ) && isplayer( self ) )
    {
        if ( damage::attackerishittingteam( self, dmg_struct.eattacker, dmg_struct.additionalparams.turretindex ) )
        {
            if ( isplayer( dmg_struct.eattacker ) )
            {
                dmg_struct.eattacker utility::callsharedfunc( #"weapon", #"hash_d69e4c0c46754e0e", dmg_struct.objweapon, self );
            }
            
            dmg_struct.idamage = 0;
            profilestop();
            return;
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_staminup", #"staminup_light_footed" ) )
    {
        if ( dmg_struct.smeansofdeath == "MOD_FALLING" )
        {
            dmg_struct.idamage = 0;
            profilestop();
            return dmg_struct;
        }
    }
    
    if ( dmg_struct.eattacker == self )
    {
        if ( dmg_struct.smeansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            dmg_struct.idamage = clamp( dmg_struct.idamage, 0, 75 );
        }
    }
    
    if ( isdefined( dmg_struct.einflictor ) && isdefined( level.rockablecars.cars ) && dmg_struct.einflictor utility::function_de1f80d93273abf5() && arraycontains( level.rockablecars.cars, dmg_struct.einflictor ) )
    {
        if ( !isdefined( self.shockname ) )
        {
            shellshock_utility::_shellshock( %"shock_destructible_vehicle_explo_zm", #"explosion", 2 );
        }
        
        car = dmg_struct.einflictor;
        new_health = self.health - dmg_struct.idamage;
        
        if ( new_health < 5 )
        {
            var_55847172b25eb7fd = 5 - new_health;
            new_damage = dmg_struct.idamage - abs( var_55847172b25eb7fd );
            dmg_struct.idamage = int( new_damage );
        }
        
        aabb = car function_48cbebbf2007bfd1();
        
        if ( isdefined( aabb ) )
        {
            mid_point = vectorlerp( aabb[ "min" ], aabb[ "max" ], 0.5 );
            bounds = ( aabb[ "max" ] - aabb[ "min" ] ) * 0.5;
            var_a4ec8f192ced84e2 = math::function_1243a6cc6a030f2a( self.origin, mid_point, bounds, car.angles );
            var_925763e6196efa9e = distance( var_a4ec8f192ced84e2, self.origin );
            var_81278ef687cffa51 = anglestoup( car.angles );
            var_f811b25ea80bf9e1 = vectordot( var_81278ef687cffa51, self.origin - car.origin );
            
            if ( var_925763e6196efa9e < 150 || var_f811b25ea80bf9e1 < 150 )
            {
                vdir = vectornormalize( self.origin - car.origin + ( 0, 0, -10 ) );
                magnitude_min = 400;
                magnitude_max = 320;
                
                if ( isdefined( self getgroundentity() ) )
                {
                    if ( var_f811b25ea80bf9e1 < 15 )
                    {
                        magnitude_min = 1200;
                        magnitude_max = 960;
                    }
                    else
                    {
                        self setorigin( self.origin + ( 0, 0, 15 ) );
                    }
                }
                
                magnitude = math::remap( var_925763e6196efa9e, 0, 150, magnitude_min, magnitude_max );
                self knockback( vdir, magnitude );
            }
        }
    }
    
    if ( isdefined( level.var_3f27e31a208b760f ) && isai( dmg_struct.eattacker ) && !isplayer( dmg_struct.eattacker ) )
    {
        dmg_struct.idamage *= level.var_3f27e31a208b760f;
    }
    
    attacker = dmg_struct.eattacker.gunner ?? dmg_struct.eattacker;
    
    if ( isdefined( attacker.var_7f8ab9bb9f4957fc ) && isdefined( dmg_struct.eattacker ) && isai( attacker ) )
    {
        dmg_struct.idamage = [[ attacker.var_7f8ab9bb9f4957fc ]]( dmg_struct.idamage, attacker, dmg_struct.objweapon, dmg_struct.smeansofdeath, dmg_struct.vpoint );
    }
    
    dmg_struct.idamage = utility::callsharedfunc( #"zm", #"hash_364bf98dfc68dd24", dmg_struct ) ?? dmg_struct.idamage;
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_ec597a712c9bb135" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie", #"hash_ec597a712c9bb135", dmg_struct );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_sixth_sense" ) && isai( dmg_struct.eattacker ) )
    {
        forward = anglestoforward( self.angles );
        var_ee6433c31961982d = vectornormalize( ( dmg_struct.eattacker.origin[ 0 ], dmg_struct.eattacker.origin[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
        dot = vectordot( forward, var_ee6433c31961982d );
        
        if ( dot < 0 )
        {
            dmg_struct.idamage = int( dmg_struct.idamage - dmg_struct.idamage * ( level.zombie_augments[ #"deathperception_sixth_sense" ].var_350fa7f2156581e9 ?? 0 ) );
            
            if ( dmg_struct.idamage < 0 )
            {
                dmg_struct.idamage = 0;
            }
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_juggernog", #"juggernog_retaliation" ) )
    {
        duration = level.zombie_augments[ #"juggernog_retaliation" ].retaliationduration ?? 5;
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_8bd9ed022653701d" ) )
        {
            self.var_2de028ea974579b5[ #"juggernog_retaliation" ] = 1;
            thread utility::callsharedfunc( #"zombie", #"hash_8bd9ed022653701d", duration, #"juggernog_retaliation", "retaliation" );
        }
    }
    
    var_1eca2bb0ebc46bfc = val::get( "bypass_saving_throws" );
    
    if ( !var_1eca2bb0ebc46bfc )
    {
        if ( val::get( "stone_cold_blizzard" ) )
        {
            var_46f726bb57708fbd = level.zombie_augments[ #"frost_blast_stone_cold_stronghold" ].var_ed90a5ae0340831a ?? 0.5;
            dmg_struct.idamage *= var_46f726bb57708fbd;
        }
    }
    
    if ( !var_1eca2bb0ebc46bfc )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_juggernog", #"juggernog_perfect_counter" ) )
        {
            var_2cca8cdb7e93fd59 = 100 * ( level.zombie_augments[ #"juggernog_perfect_counter" ].var_54b7d92dead9a8c9 ?? 0.05 );
            var_f948bb5c1d52d698 = level.zombie_augments[ #"juggernog_perfect_counter" ].var_b76a05c80f58dfe8 ?? 1;
            
            if ( utility::percent_chance( var_2cca8cdb7e93fd59 ) )
            {
                dmg_struct.idamage = var_f948bb5c1d52d698;
            }
        }
    }
    
    if ( !dmg_struct.eattacker.var_a7339c2c551e2788 )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"hash_555f057b4e2d44f8" ) )
        {
            dmg_struct.idamage = utility::callsharedfunc( #"zombie", #"hash_555f057b4e2d44f8", dmg_struct );
        }
    }
    
    if ( !var_1eca2bb0ebc46bfc )
    {
        if ( self.var_ceb069654e508d3d )
        {
            dmg_struct.idamage = 0;
            profilestop();
            return dmg_struct;
        }
    }
    
    profilestop();
    return dmg_struct;
}

