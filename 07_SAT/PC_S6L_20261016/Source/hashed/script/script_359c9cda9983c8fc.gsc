// script_359c9cda9983c8fc  (hash_359c9cda9983c8fc.gscc) (size: 3688 Bytes / 0xe68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae832e25 (2927832613)
// size ...... 3688 (0xe68)
// includes .. 4   (offset: 0xd64)
// strings ... 16  (offset: 0xd84)
// dev strs .. 0   (offset: 0xe68)
// exports ... 8   (offset: 0x8c4)
// cseg ...... 0x139 + 0x78b (0x8c4)
// imports ... 29  (offset: 0xa04)
// animtree1 . 0   (offset: 0xe68)
// animtree2 . 0   (offset: 0xe68)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_triton_lava_bomb;

// Namespace zombie_triton_lava_bomb
// Params 1
// Checksum 0x84b36b23, Offset: 0x157
// Size: 0x17
function function_a680f6c9f2a4f64c( percentage )
{
    self.var_4f2a7d74389f9eec = percentage;
}

// Namespace zombie_triton_lava_bomb
// Params 1
// Checksum 0xd372ddd1, Offset: 0x176
// Size: 0x1e2
function function_966d048b40987b44( lavabomb )
{
    if ( self.var_ff2326171cc4c2d )
    {
        [[ self.var_ff2326171cc4c2d ]]( lavabomb );
        return;
    }
    
    lavabomb endon( #"delay_death" );
    lavabomb childthread delay_endon( "death" );
    aoeradius = getdvarfloat( @"hash_be163b21db15ac7f", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a4b9402108e1bf0b );
    var_cc682460b6c05565 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c95d2bb263e931f5;
    var_c3c9f29969d5d817 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f8f70a51a69e2cf4;
    var_4eff8aa729ab67c0 = anglestoright( lavabomb.angles );
    lavabomb waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    var_99f8e049f2adf735 = utility::waittill_any_timeout( 0.1, "hit_player_with_lava_bomb" );
    enthit = var_99f8e049f2adf735 != "timeout";
    normal = ( 0, 0, 1 );
    var_2ca52b9507adc6a5 = undefined;
    impactangles = undefined;
    var_2ca52b9507adc6a5 = vectorcross( normal, var_4eff8aa729ab67c0 );
    impactangles = axistoangles( var_2ca52b9507adc6a5, var_4eff8aa729ab67c0, normal );
    
    if ( !enthit )
    {
        thread lava_bomb_aoe( origin, impactangles, aoeradius, var_cc682460b6c05565, var_c3c9f29969d5d817 );
        return;
    }
    
    if ( enthit && isdefined( self.var_cee5b607fe94f869 ) )
    {
        thread lava_bomb_aoe( self.var_cee5b607fe94f869, impactangles, aoeradius, var_cc682460b6c05565, var_c3c9f29969d5d817 );
        self.var_cee5b607fe94f869 = undefined;
        self.var_2ddadacccfbca872 = undefined;
        return;
    }
    
    playsoundatpos( origin + ( 0, 0, 50 ), #"exp_ai_triton_fireball_main" );
}

// Namespace zombie_triton_lava_bomb
// Params 0
// Checksum 0x6a680df9, Offset: 0x360
// Size: 0x23c
function function_4205d8c2663ce650()
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    triton = getmissileowner( self );
    self waittill( #"explode", origin, var_4cd1a139c1b0c2b7 );
    nearbyenemies = getplayersandaiarrayinradius( origin, 70, triton.enemy.team );
    
    if ( nearbyenemies.size > 0 && isalive( nearbyenemies[ 0 ] ) )
    {
        hitent = nearbyenemies[ 0 ];
        
        if ( isplayer( hitent ) )
        {
            hitent thread damage_effects::enableburnfxfortime( 1.5 );
        }
        
        var_19f299b8d961af85 = 100;
        groundtrace = trace::ray_trace( hitent.origin + ( 0, 0, var_19f299b8d961af85 * 2 ), hitent.origin + ( 0, 0, var_19f299b8d961af85 * -2 ), [ triton ], trace::create_solid_ai_contents( 1 ) );
        
        if ( groundtrace[ "hittype" ] != "hittype_none" )
        {
            groundpos = groundtrace[ "position" ];
            groundnormal = groundtrace[ "normal" ];
        }
        
        if ( hitent isonground() || isdefined( groundpos ) && distancesquared( hitent.origin, groundpos ) <= squared( var_19f299b8d961af85 ) )
        {
            triton.var_cee5b607fe94f869 = groundpos;
            triton.var_2ddadacccfbca872 = groundnormal;
        }
        
        var_33d5d0fc10470612 = 0.6;
        var_35ec7ff62640ead = triton.var_4f2a7d74389f9eec ?? var_33d5d0fc10470612;
        var_fc3e8295da03323c = hitent.maxhealth * getdvarfloat( @"hash_37c06828ee562344", var_35ec7ff62640ead );
        var_55bc4979ee147531 = hitent.origin ?? origin;
        
        if ( isdefined( hitent ) && isdefined( var_fc3e8295da03323c ) && isdefined( var_55bc4979ee147531 ) && isdefined( triton.grenadeweapon ) )
        {
            hitent dodamage( var_fc3e8295da03323c, var_55bc4979ee147531, self, self, "MOD_PROJECTILE", triton.grenadeweapon, "none", undefined, 65536 );
        }
        
        triton notify( #"hit_player_with_lava_bomb" );
    }
}

// Namespace zombie_triton_lava_bomb
// Params 1
// Checksum 0xaf533907, Offset: 0x5a4
// Size: 0x52
function function_f7f5dd74398250bc( var_fde1a84422f2f79f )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    
    if ( !isdefined( var_fde1a84422f2f79f ) )
    {
        var_fde1a84422f2f79f = 0.5;
    }
    
    self setmagicgrenadecollision( 0 );
    wait var_fde1a84422f2f79f;
    
    if ( isdefined( self ) || !isalive( self ) )
    {
        return;
    }
    
    self setmagicgrenadecollision( 1 );
}

// Namespace zombie_triton_lava_bomb
// Params 6
// Checksum 0xfca08ebf, Offset: 0x5fe
// Size: 0xa6
function lava_bomb_aoe( impactorigin, impactangles, aoeradius, var_cc682460b6c05565, var_c3c9f29969d5d817, aoescriptable )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    impactscriptable = spawnscriptable( aoescriptable ?? "scriptable_zombie_triton_lava_bomb_aoe", impactorigin, impactangles );
    impactscriptable setscriptablepartstate( "impact", "impact" );
    thread do_fire_aoe_damage( var_c3c9f29969d5d817, var_cc682460b6c05565, impactorigin, aoeradius );
    wait var_c3c9f29969d5d817;
    impactscriptable setscriptablepartstate( "impact", "off" );
    impactscriptable freescriptable();
}

// Namespace zombie_triton_lava_bomb
// Params 4, eflags: 0x4
// Checksum 0x3fe675b, Offset: 0x6ac
// Size: 0x1ed
function private do_fire_aoe_damage( var_c3c9f29969d5d817, var_cc682460b6c05565, impactorigin, aoeradius )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    var_a4eb0414d8de01db = 0.5;
    var_1a058e9c296b4e09 = var_c3c9f29969d5d817 + var_a4eb0414d8de01db;
    var_601a117a58005cbf = 0;
    var_b2bae9873f67716 = 0.25;
    var_e8db7a4531b48b6c = self.grenadeweapon;
    
    while ( var_601a117a58005cbf < var_1a058e9c296b4e09 )
    {
        var_bf2f73af3187e876 = getplayersandaiarrayinradius( impactorigin, aoeradius );
        
        if ( var_bf2f73af3187e876.size > 0 )
        {
            foreach ( var_6cc560bdec891bc1 in var_bf2f73af3187e876 )
            {
                if ( var_6cc560bdec891bc1 == self || !isalive( var_6cc560bdec891bc1 ) )
                {
                    continue;
                }
                
                targetisplayer = isplayer( var_6cc560bdec891bc1 );
                
                if ( isai( var_6cc560bdec891bc1 ) && var_6cc560bdec891bc1.type == "zombie" )
                {
                    var_6cc560bdec891bc1 callback::callback( "burned" );
                    var_6cc560bdec891bc1 dodamage( var_6cc560bdec891bc1.maxhealth * var_cc682460b6c05565 * 0.35 * 0.01, impactorigin, self, self, "MOD_FIRE", var_e8db7a4531b48b6c, "none", undefined, 65536 );
                    continue;
                }
                
                if ( targetisplayer )
                {
                    var_6cc560bdec891bc1 thread damage_effects::enableburnfxfortime( 1.5 );
                    var_6cc560bdec891bc1 dodamage( var_6cc560bdec891bc1.maxhealth * var_cc682460b6c05565 * 0.01, impactorigin, self, self, "MOD_FIRE", var_e8db7a4531b48b6c, "none", undefined, 65536 );
                }
            }
        }
        
        wait var_b2bae9873f67716;
        var_601a117a58005cbf += var_b2bae9873f67716;
    }
}

// Namespace zombie_triton_lava_bomb
// Params 1, eflags: 0x4
// Checksum 0x114fbc6, Offset: 0x8a1
// Size: 0x23
function private delay_endon( string )
{
    self waittill( string );
    wait 4;
    self notify( "delay_" + string );
}

