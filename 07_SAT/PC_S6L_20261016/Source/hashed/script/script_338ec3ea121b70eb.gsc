// script_338ec3ea121b70eb  (hash_338ec3ea121b70eb.gscc) (size: 3553 Bytes / 0xde1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf4e5f6ca (4108711626)
// size ...... 3553 (0xde1)
// includes .. 13  (offset: 0xca5)
// strings ... 16  (offset: 0xd0d)
// dev strs .. 0   (offset: 0xde1)
// exports ... 7   (offset: 0x709)
// cseg ...... 0x139 + 0x5d0 (0x709)
// imports ... 41  (offset: 0x821)
// animtree1 . 0   (offset: 0xde1)
// animtree2 . 0   (offset: 0xde1)
#using script_159e69834267c720;
#using script_1c638c54a5ece5f7;
#using script_2cd07641bf71242a;
#using script_5fbb037f63a7a8a1;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_viper_asm;

// Namespace zombie_viper_asm
// Params 0, eflags: 0x4
// Checksum 0x11006748, Offset: 0x157
// Size: 0x93
function private function_12f8d2f18225b37d()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    level.scr_anim[ self.animname ][ "spawn_fast" ] = "spawn_fast";
    level.scr_anim[ self.animname ][ "spawn_portal" ] = "spawn_portal";
    level.scr_anim[ self.animname ][ "ejection" ] = "ejection";
    namespace_fa9d8e53d222e3e5::register_move_variant();
    namespace_e60d35adb067df4c::register_melee_variant();
    namespace_e60d35adb067df4c::init_melee_global();
}

// Namespace zombie_viper_asm
// Params 3
// Checksum 0xeb4e7250, Offset: 0x1f2
// Size: 0x103
function function_cdb80ad3ac21b02a( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_12f8d2f18225b37d );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    namespace_fa9d8e53d222e3e5::init_zombie_viper_move();
    namespace_e60d35adb067df4c::function_a887d53ac5484b73();
    zombie_traverse_asm::init_zombie_traverse_asm();
    zombie_leap_attack_asm::function_3d8cd69a5c5394a0( 300 );
    thread zombie_wander::function_c77a8eaa38883b1c();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_viper_asm
// Params 0
// Checksum 0xc3d0ac9c, Offset: 0x2fd
// Size: 0x3a
function cause_special_pain()
{
    if ( !zombie_stun::is_stunned() && !self isintraverse() && isalive( self ) && val::get( "special_pain" ) )
    {
        asm::function_7256f5ba459c840b( "special_pain_in" );
    }
}

// Namespace zombie_viper_asm
// Params 3
// Checksum 0xbd0276e, Offset: 0x33f
// Size: 0x28, Type: bool
function is_fast_death( asmname, statename, params )
{
    return istrue( self.var_197f810fa9e5a5b0 );
}

// Namespace zombie_viper_asm
// Params 1, eflags: 0x4
// Checksum 0x66aa2bf2, Offset: 0x370
// Size: 0x2f
function private on_ai_init( params )
{
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace zombie_viper_asm
// Params 4
// Checksum 0xe3cb952, Offset: 0x3a7
// Size: 0x361, Type: bool
function rocket_punch_update( asmname, statename, tostatename, params )
{
    if ( isdefined( self.enemy ) )
    {
        self function_ba5334b674dfb9d0( distance( self.enemy.origin, self.origin ) );
    }
    
    fist_loc = self gettagorigin( "j_mid_le_1", 1 );
    punch_dir = anglestoforward( self.angles );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    foreach ( ent in getplayersandaiarrayinradius( fist_loc, 200 ) )
    {
        if ( self == ent )
        {
            continue;
        }
        
        is_player = isplayer( ent );
        
        if ( is_player && arraycontains( self.rocket_punch_players, ent ) )
        {
            continue;
        }
        
        half_size = ent getboundshalfsize();
        var_f06c3d8143b76949 = ent.origin + ( 0, 0, half_size[ 2 ] * 2 );
        dist_sqr_to_ent = function_714341c51423832d( ent.origin, var_f06c3d8143b76949, fist_loc );
        
        if ( dist_sqr_to_ent < squared( 20 ) )
        {
            if ( is_player )
            {
                self.rocket_punch_players[ self.rocket_punch_players.size ] = ent;
                
                if ( settings.var_aa768b7cb074de54 > 0 )
                {
                    if ( settings.var_f7aab855a6ca2dbc > 0 )
                    {
                        var_23ddb31f5260dafb = vectorcross( punch_dir, ( 0, 0, 1 ) );
                        knockback_direction = rotatepointaroundvector( var_23ddb31f5260dafb, punch_dir, settings.var_f7aab855a6ca2dbc );
                        allow_aerial = 1;
                    }
                    else
                    {
                        knockback_direction = punch_dir;
                        allow_aerial = 0;
                    }
                    
                    ent knockback( knockback_direction, settings.var_aa768b7cb074de54, allow_aerial );
                }
                
                if ( settings.var_3d70017645d2e857 > 0 && settings.var_d9087f26dc45861f > 0 )
                {
                    ent earthquakeforplayer( settings.var_3d70017645d2e857, settings.var_d9087f26dc45861f, ent.origin, 1000 );
                    ent playrumbleonentity( settings.var_3d70017645d2e857 > 0.5 ? "heavy_1s" : "light_1s" );
                }
                
                if ( settings.rocketpunchdamage > 0 )
                {
                    rocket_punch_damage = settings.rocketpunchdamage;
                    
                    if ( isdefined( self.var_fe048a2106d8ef00[ #"rocket_punch" ] ) )
                    {
                        rocket_punch_damage *= self.var_fe048a2106d8ef00[ #"rocket_punch" ];
                    }
                    
                    ent dodamage( rocket_punch_damage, fist_loc, self, self, "MOD_MELEE", self.weapon );
                }
                
                continue;
            }
            
            if ( ( !isdefined( ent.aicategory ) || ent.aicategory == "normal" ) && !ent zombie_knockdown::function_19d6107cb6bdff5c() )
            {
                ent zombie_knockdown::function_6fc167d4a3590991( fist_loc );
            }
        }
    }
    
    return false;
}

