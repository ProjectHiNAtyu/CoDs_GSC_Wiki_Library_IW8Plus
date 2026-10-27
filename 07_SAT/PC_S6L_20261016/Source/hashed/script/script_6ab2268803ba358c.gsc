// script_6ab2268803ba358c  (hash_6ab2268803ba358c.gscc) (size: 4084 Bytes / 0xff4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44ae88ce (1152288974)
// size ...... 4084 (0xff4)
// includes .. 8   (offset: 0xea0)
// strings ... 18  (offset: 0xee0)
// dev strs .. 0   (offset: 0xff4)
// exports ... 11  (offset: 0x888)
// cseg ...... 0x19f + 0x6e9 (0x888)
// imports ... 38  (offset: 0xa40)
// animtree1 . 0   (offset: 0xff4)
// animtree2 . 0   (offset: 0xff4)
#using script_16ea1b94f0f381b3;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace namespace_97cff5504410cab3;

// Namespace namespace_97cff5504410cab3
// Params 0
// Checksum 0xaed0c4c8, Offset: 0x1bd
// Size: 0x37
function main()
{
    level.a_t_lava = [];
    level.lava_flow_scorched_zombie_throttle = throttle::throttle_initialize( "lava_flow_scorched_zombie", 1 );
    level utility::flag_wait( "scriptables_ready" );
    level thread setup_border_lava();
}

// Namespace namespace_97cff5504410cab3
// Params 0
// Checksum 0x6c63650a, Offset: 0x1fc
// Size: 0x9c
function setup_border_lava()
{
    level endon( #"game_ended" );
    var_d49bdc4a13e41add = utility::getstruct( "border_lv", "targetname" );
    var_d49bdc4a13e41add.trigger = getent( var_d49bdc4a13e41add.target, #targetname );
    var_d49bdc4a13e41add thread function_5ebea98343759f73();
    level.a_t_lava[ level.a_t_lava.size ] = var_d49bdc4a13e41add.trigger;
    level utility::callsharedfunc( #"equipment", #"hash_72c7c53eb92e361f", var_d49bdc4a13e41add.trigger );
}

// Namespace namespace_97cff5504410cab3
// Params 0
// Checksum 0xe96f05f2, Offset: 0x2a0
// Size: 0x9b
function function_5ebea98343759f73()
{
    level endon( #"game_ended" );
    level endon( #"hash_aa3ae7713773ce31" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", ent );
        
        if ( self.iscooled )
        {
            waitframe();
            continue;
        }
        
        if ( !ent.var_d682d30b84057103 )
        {
            ent.var_d682d30b84057103 = 1;
            
            if ( isplayer( ent ) && !player::isinlaststand() )
            {
                ent thread function_76024fb2f82f0bfc( self );
                continue;
            }
            
            ent thread function_dbd4e7781bf77c( self );
        }
    }
}

// Namespace namespace_97cff5504410cab3
// Params 1
// Checksum 0xd5be1593, Offset: 0x343
// Size: 0x15a
function function_dbd4e7781bf77c( flow_struct )
{
    self notify( #"hash_42ac1146c6495303" );
    self endon( #"hash_42ac1146c6495303" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    else if ( self.b_in_spawn_closet )
    {
        return;
    }
    else if ( !isdefined( self._blackboard ) )
    {
        self.var_d682d30b84057103 = 0;
        return;
    }
    
    var_ec087502f3f30c3c = self.classname == "actor_sat_dawg" ? 1 : 0;
    
    if ( !var_ec087502f3f30c3c )
    {
        function_6d0199df77d32abb( 1 );
    }
    
    dmg = function_bab5c6e5560fe328();
    random_mod = randomfloatrange( 0.5, 1 );
    dmg *= random_mod;
    
    while ( isalive( self ) && self istouching( flow_struct.trigger ) && !flow_struct.iscooled )
    {
        if ( var_ec087502f3f30c3c )
        {
            if ( self.crate.physicsactivated )
            {
                wait 1;
                continue;
            }
        }
        
        thread effect_burn::burn( 1, dmg, 1, flow_struct.trigger, "lf_val_string", undefined, undefined, undefined, 1 );
        wait 1;
    }
    
    if ( !var_ec087502f3f30c3c )
    {
        function_6d0199df77d32abb( 0 );
    }
    
    self.var_d682d30b84057103 = 0;
}

// Namespace namespace_97cff5504410cab3
// Params 1
// Checksum 0xd3b9f816, Offset: 0x4a5
// Size: 0xf3
function function_76024fb2f82f0bfc( flow_struct )
{
    self notify( #"hash_903b143c04d0c631" );
    self endon( #"hash_903b143c04d0c631" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    set_player_slowed( 1 );
    function_e4fdf8fdb769a73e( 1 );
    function_630b92e6c45437f0();
    utility::function_7c10ea82c1e305b8( "burning", "active" );
    dmg = function_bab5c6e5560fe328();
    
    while ( self istouching( flow_struct.trigger ) && !flow_struct.iscooled && !player::isinlaststand() && isalive( self ) )
    {
        thread effect_burn::burn( 1, dmg, 1, self, "lf_val_string" );
        wait 1;
    }
    
    set_player_slowed( 0 );
    function_e4fdf8fdb769a73e( 0 );
    utility::function_7c10ea82c1e305b8( "burning", "neutral" );
    self.var_d682d30b84057103 = 0;
}

// Namespace namespace_97cff5504410cab3
// Params 1
// Checksum 0xef2f27bb, Offset: 0x5a0
// Size: 0x6a
function set_player_slowed( state )
{
    if ( state )
    {
        weapons::function_4512b7715789e4cf( "lf_val_string", 0.65 );
        common::function_1f09590404e452e4( "lf_val_string", 0.65 );
        weapons::updatemovespeedscale();
        return;
    }
    
    weapons::function_986fc44dada307f4( "lf_val_string" );
    
    if ( common::function_8ff835bf23198a0( "lf_val_string" ) )
    {
        common::function_d85a92c557ea5a52( "lf_val_string" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace namespace_97cff5504410cab3
// Params 0
// Checksum 0x3eb13fde, Offset: 0x612
// Size: 0x57
function function_630b92e6c45437f0()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) )
    {
        wait 0.5;
    }
    
    if ( self issprintsliding() )
    {
        self function_64f1800c957cf63c();
    }
}

// Namespace namespace_97cff5504410cab3
// Params 1
// Checksum 0x35d7a997, Offset: 0x671
// Size: 0x80
function function_e4fdf8fdb769a73e( state )
{
    if ( state )
    {
        val::set( "lf_val_string", "supersprint", 0 );
        val::set( "lf_val_string", "killstreaks", 0 );
        
        if ( self isstanceallowed( "stand" ) )
        {
            self setstance( "stand" );
            val::set( "lf_val_string", "prone", 0 );
            val::set( "lf_val_string", "crouch", 0 );
        }
        
        return;
    }
    
    val::reset_all( "lf_val_string" );
}

// Namespace namespace_97cff5504410cab3
// Params 1
// Checksum 0x969c3819, Offset: 0x6f9
// Size: 0x2d
function function_6d0199df77d32abb( state )
{
    self.var_a13bed1ac47e1b2c = state;
    self.no_powerups = state;
    self.forceannihilate = state;
}

// Namespace namespace_97cff5504410cab3
// Params 0
// Checksum 0xf8175be, Offset: 0x72e
// Size: 0x159
function function_bab5c6e5560fe328()
{
    if ( isplayer( self ) )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) )
        {
            if ( self issprintsliding() )
            {
                dmg = 0;
            }
            else
            {
                dmg = 20;
            }
        }
        else
        {
            dmg = 20;
        }
    }
    else if ( isai( self ) )
    {
        var_36283cf7fdfe8b61 = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", 1 );
        
        if ( isdefined( self.aicategory ) )
        {
            switch ( self.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                default:
                    dmg = var_36283cf7fdfe8b61 * 0.05;
                    break;
                case #"hash_8c089e813083e510":
                    dmg = var_36283cf7fdfe8b61 * 0.05;
                    break;
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                    dmg = var_36283cf7fdfe8b61 * 0.05;
                    break;
            }
        }
        else if ( self.classname == "actor_sat_dawg" )
        {
            dmg = self.maxhealth * 0.05;
        }
        else
        {
            dmg = 20;
        }
        
        if ( self.subclass == "zombie_base_armored_agni" )
        {
            dmg = 0;
        }
        
        if ( self.subclass == "zombie_hellhound" )
        {
            dmg = 0;
        }
    }
    else
    {
        dmg = 20;
    }
    
    return dmg;
}

