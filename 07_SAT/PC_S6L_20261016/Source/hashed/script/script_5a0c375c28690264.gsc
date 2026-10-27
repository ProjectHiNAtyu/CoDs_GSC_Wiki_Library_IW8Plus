// script_5a0c375c28690264  (hash_5a0c375c28690264.gscc) (size: 17997 Bytes / 0x464d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c53762f (475231791)
// size ...... 17997 (0x464d)
// includes .. 19  (offset: 0x413d)
// strings ... 65  (offset: 0x41d5)
// dev strs .. 11  (offset: 0x45c1)
// exports ... 39  (offset: 0x29ed)
// cseg ...... 0x515 + 0x24d8 (0x29ed)
// imports ... 143 (offset: 0x3005)
// animtree1 . 0   (offset: 0x464d)
// animtree2 . 0   (offset: 0x464d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_bloat;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_923cf551235ca152;

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x8e581536, Offset: 0x533
// Size: 0x70
function main()
{
    level.a_t_lava = [];
    level.lava_flow_scorched_zombie_throttle = throttle::throttle_initialize( "lava_flow_scorched_zombie", 1 );
    level utility::flag_wait( "scriptables_ready" );
    level thread function_6de4d18cab066c88();
    level thread setup_border_lava();
    
    if ( !level callback::exists( "teddtask_hornet_lava_kill", &function_2da8f69cf9c352fb ) )
    {
        level callback::add( "teddtask_hornet_lava_kill", &function_2da8f69cf9c352fb );
    }
    
    /#
        init_lava_flow_debug();
    #/
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x3acccdbf, Offset: 0x5ab
// Size: 0x110
function setup_border_lava()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    var_5836c90831602233 = utility::getstructarray( "border_lv", "targetname" );
    
    foreach ( var_d49bdc4a13e41add in var_5836c90831602233 )
    {
        var_d49bdc4a13e41add.trigger = getent( var_d49bdc4a13e41add.target, #targetname );
        var_d49bdc4a13e41add thread function_5ebea98343759f73();
        level.a_t_lava[ level.a_t_lava.size ] = var_d49bdc4a13e41add.trigger;
        level utility::callsharedfunc( #"equipment", #"hash_72c7c53eb92e361f", var_d49bdc4a13e41add.trigger );
    }
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x66032e54, Offset: 0x6c3
// Size: 0xc9
function function_6de4d18cab066c88()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( idx, var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
    {
        var_b4c1c1d2a952db62 thread setup_lava_flow( idx );
    }
    
    activateworldevent( "we_vfx_hornet_lava_flow_dist_third" );
    activateworldevent( "we_vfx_hornet_cooled_lava_smk_third" );
    level scriptable::scriptable_adddamagedcallback( &function_9832167762d2d817 );
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0x958717bf, Offset: 0x794
// Size: 0x17b
function setup_lava_flow( bit_idx )
{
    self.sbl = utility::function_30dbabe3200518b( "scriptable_zm_sat_hornet_lava_flow" + "_" + self.script_noteworthy, #script_noteworthy );
    
    if ( self.sbl )
    {
        self.sbl.var_c0c940b175bdf3ca = self;
    }
    
    self.collision = getent( "col_" + self.script_noteworthy, #targetname );
    self.var_ac26e8b658d7debe = self.collision.origin;
    self.var_fc93913fa52ef7f1 = self.collision.origin - ( 0, 0, 16 );
    self.trigger = getent( self.target, #targetname );
    thread function_5ebea98343759f73();
    level.a_t_lava[ level.a_t_lava.size ] = self.trigger;
    self.collision setcandamage( 1 );
    self.collision.health = 999999999;
    self.a_plumes = [];
    self.world_event = "we_lgt_lava_" + self.script_noteworthy;
    self.iscooled = undefined;
    self.bit_idx = bit_idx;
    set_flow_cooled( 0 );
    wait 1;
    thread function_12cbd14aca639d83();
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x238275b8, Offset: 0x917
// Size: 0xf2
function function_12cbd14aca639d83()
{
    level endon( #"game_ended" );
    level endon( #"hash_aa3ae7713773ce31" );
    level utility::flag_wait( "map_features_can_be_reloaded" );
    value = level zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_1c67b9218fe90863" ) ?? 0;
    var_63e81e55354f810a = utility::get_bit_flag( value, self.bit_idx ) ?? 0;
    
    if ( var_63e81e55354f810a )
    {
        wait randomfloatrange( 600, 900 );
    }
    
    while ( true )
    {
        if ( level utility::flag( "lava_flow_changes_paused" ) )
        {
            level utility::flag_waitopen( "lava_flow_changes_paused" );
        }
        
        set_flow_molten();
        wait randomfloatrange( 480, 720 );
        
        if ( level utility::flag( "lava_flow_changes_paused" ) )
        {
            level utility::flag_waitopen( "lava_flow_changes_paused" );
        }
        
        set_flow_cooled( 1, 3 );
        utility::waittill_any_timeout( randomfloatrange( 600, 600 ), "melt_override" );
    }
}

// Namespace namespace_923cf551235ca152
// Params 2
// Checksum 0xf9710cde, Offset: 0xa11
// Size: 0x373
function set_flow_cooled( var_2f4f896bfa598df4 = 1, transition_time_sec = 0 )
{
    self notify( #"hash_e8c47b3f61951412" );
    self endon( #"hash_e8c47b3f61951412" );
    level endon( #"game_ended" );
    
    if ( self.iscooled )
    {
        return;
    }
    
    if ( !( isdefined( self.collision ) && isdefined( self.sbl ) ) )
    {
        return;
    }
    
    level notify( "lava_flow_started_cooling_" + self.script_noteworthy );
    self.sbl utility::function_7c10ea82c1e305b8( "lava_state", "cooling" );
    move_time = transition_time_sec > 0 ? transition_time_sec : 0.1;
    self.collision moveto( self.var_ac26e8b658d7debe - ( 0, 0, 5 ), move_time );
    var_b0c3bafd9a00554a = getentitylessscriptablearray( "lava_flow_sound_" + self.script_noteworthy, #script_noteworthy );
    
    foreach ( lava_sound_emitter in var_b0c3bafd9a00554a )
    {
        lava_sound_emitter setscriptablepartstate( "sound", "cooling" );
    }
    
    a_lava_rocks = getentitylessscriptablearray( "lava_rocks_" + self.script_noteworthy, #script_noteworthy );
    
    foreach ( var_c350104a8aeb43c4 in a_lava_rocks )
    {
        var_c350104a8aeb43c4 setscriptablepartstate( "lava_state", "cooling" );
    }
    
    wait transition_time_sec;
    
    if ( self.sbl )
    {
        self.sbl utility::function_7c10ea82c1e305b8( "collision", "on" );
    }
    
    self.iscooled = 1;
    level utility::callsharedfunc( #"equipment", #"hash_b423513c70018ac2", self.trigger );
    
    foreach ( zombie in getaiarray( "team_two_hundred" ) )
    {
        if ( zombie.var_d682d30b84057103 )
        {
            zombie zombie_bloat::function_2cd238f58ce9245b( 5 );
        }
    }
    
    level notify( "lava_flow_cooled_" + self.script_noteworthy, self.iscooled );
    
    if ( var_2f4f896bfa598df4 )
    {
        value = level zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_1c67b9218fe90863" ) ?? 0;
        value = utility::set_bit_flag( value, self.bit_idx );
        level zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", #"hash_1c67b9218fe90863", value );
    }
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0xea6881c4, Offset: 0xd8c
// Size: 0x2be
function set_flow_molten( transition_time_sec = 0 )
{
    self notify( #"hash_71ee8d6ad259c759" );
    self endon( #"hash_71ee8d6ad259c759" );
    
    if ( !self.iscooled )
    {
        return;
    }
    
    if ( !( isdefined( self.collision ) && isdefined( self.sbl ) ) )
    {
        return;
    }
    
    level notify( "lava_flow_started_melting_" + self.script_noteworthy );
    self.sbl utility::function_7c10ea82c1e305b8( "lava_state", "melting" );
    wait 0.5;
    
    if ( self.sbl )
    {
        self.sbl utility::function_7c10ea82c1e305b8( "collision", "off" );
    }
    
    move_time = transition_time_sec > 0 ? transition_time_sec : 1;
    self.collision moveto( self.var_fc93913fa52ef7f1, move_time );
    var_b0c3bafd9a00554a = getentitylessscriptablearray( "lava_flow_sound_" + self.script_noteworthy, #script_noteworthy );
    
    foreach ( lava_sound_emitter in var_b0c3bafd9a00554a )
    {
        lava_sound_emitter setscriptablepartstate( "sound", "melting" );
    }
    
    a_lava_rocks = getentitylessscriptablearray( "lava_rocks_" + self.script_noteworthy, #script_noteworthy );
    
    foreach ( var_c350104a8aeb43c4 in a_lava_rocks )
    {
        var_c350104a8aeb43c4 setscriptablepartstate( "lava_state", "melting" );
    }
    
    wait transition_time_sec;
    self.iscooled = 0;
    level utility::callsharedfunc( #"equipment", #"hash_72c7c53eb92e361f", self.trigger );
    level notify( "lava_flow_cooled_" + self.script_noteworthy, self.iscooled );
    value = level zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_1c67b9218fe90863" ) ?? 0;
    value = utility::function_911d2d3c6d773726( value, self.bit_idx );
    level zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", #"hash_1c67b9218fe90863", value );
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0xed535427, Offset: 0x1052
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

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0x1bae5f0b, Offset: 0x10f5
// Size: 0x197
function function_dbd4e7781bf77c( flow_struct )
{
    self notify( #"hash_4917215eb3de3f39" );
    self endon( #"hash_4917215eb3de3f39" );
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
        thread function_ecd280dbe19d9301();
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
                wait 0.75;
                continue;
            }
        }
        
        var_3ba154bfaf79a2f0 = !self.var_75afeb7d6a870ec0;
        
        if ( !var_3ba154bfaf79a2f0 )
        {
            wait 0.75;
            continue;
        }
        
        if ( dmg > 0 )
        {
            thread effect_burn::burn( 0.75, dmg, 0.75, flow_struct.trigger, "lf_val_string", undefined, undefined, undefined, 1 );
        }
        
        wait 0.75;
    }
    
    if ( !var_ec087502f3f30c3c )
    {
        function_6d0199df77d32abb( 0 );
    }
    
    self.var_d682d30b84057103 = 0;
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0xbc388197, Offset: 0x1294
// Size: 0x103
function function_76024fb2f82f0bfc( flow_struct )
{
    self notify( #"hash_5d1d1a998acd95d6" );
    self endon( #"hash_5d1d1a998acd95d6" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    set_player_slowed( 1 );
    function_e4fdf8fdb769a73e( 1 );
    function_630b92e6c45437f0();
    utility::function_7c10ea82c1e305b8( "burning", "active" );
    dmg = function_bab5c6e5560fe328();
    function_55ce28419f71845b();
    
    while ( self istouching( flow_struct.trigger ) && !flow_struct.iscooled && !player::isinlaststand() && isalive( self ) )
    {
        thread effect_burn::burn( 0.75, dmg, 0.75, self, "lf_val_string" );
        wait 0.75;
    }
    
    set_player_slowed( 0 );
    function_e4fdf8fdb769a73e( 0 );
    utility::function_7c10ea82c1e305b8( "burning", "neutral" );
    self.var_d682d30b84057103 = 0;
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0x88634c5a, Offset: 0x139f
// Size: 0x6a
function set_player_slowed( state )
{
    if ( state )
    {
        weapons::function_4512b7715789e4cf( "lf_val_string", 0.4 );
        common::function_1f09590404e452e4( "lf_val_string", 0.4 );
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

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x59fd543f, Offset: 0x1411
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

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0xacad7d8, Offset: 0x1470
// Size: 0xa4
function function_e4fdf8fdb769a73e( state )
{
    if ( state )
    {
        val::set( "lf_val_string", "allow_jump", 0 );
        val::set( "lf_val_string", "sprint", 0 );
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

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0xf1d053f8, Offset: 0x151c
// Size: 0x2d
function function_6d0199df77d32abb( state )
{
    self.var_a13bed1ac47e1b2c = state;
    self.no_powerups = state;
    self.forceannihilate = state;
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x2fb933bf, Offset: 0x1551
// Size: 0x189
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
                dmg = 50;
            }
        }
        else
        {
            dmg = 50;
        }
    }
    else if ( isai( self ) )
    {
        zom_round = isdefined( self._blackboard.var_e9288b4c21f355a9 ) ? zombie_utils::get_zombie_round_difficulty() : zm_round_logic::get_rb_round_number();
        var_36283cf7fdfe8b61 = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zom_round );
        
        if ( isdefined( self.aicategory ) )
        {
            switch ( self.aicategory )
            {
                case #"hash_84fcf5e68d7230b2":
                default:
                    dmg = var_36283cf7fdfe8b61 * 0.02;
                    break;
                case #"hash_8c089e813083e510":
                    dmg = var_36283cf7fdfe8b61 * 0.14;
                    break;
                case #"hash_7b0e2f2ed84f34":
                case #"hash_4e47eb6c32f5b165":
                    dmg = var_36283cf7fdfe8b61 * 0.14;
                    break;
            }
        }
        else if ( self.classname == "actor_sat_dawg" )
        {
            dmg = self.maxhealth * 0.15;
        }
        else
        {
            dmg = 50;
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
        dmg = 50;
    }
    
    return dmg;
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x45daa230, Offset: 0x16e3
// Size: 0x132
function function_eaa9604ef6ee382()
{
    level endon( #"game_ended" );
    level endon( #"hash_aa3ae7713773ce31" );
    
    while ( true )
    {
        self.collision waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid );
        self.collision.health = 999999999;
        
        if ( !self.iscooled )
        {
            waitframe();
            continue;
        }
        
        if ( function_de45bcf3d2a03ac2( objweapon, eattacker, smeansofdeath, idamage ) && !function_f9aa48ce110f92c2( vpoint, self ) && self.a_plumes.size < 3 )
        {
            level thread function_da0a4d751b519792( vpoint, self );
        }
    }
}

// Namespace namespace_923cf551235ca152
// Params 11
// Checksum 0x4967d70f, Offset: 0x181d
// Size: 0x13d
function function_9832167762d2d817( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !( instance.type == "zm_sat_hornet_lava_flow" + "_secondbailey" || instance.type == "zm_sat_hornet_lava_flow" + "_westbailey" ) )
    {
        return;
    }
    
    if ( !instance.var_c0c940b175bdf3ca.iscooled )
    {
        return;
    }
    
    if ( function_de45bcf3d2a03ac2( objweapon, eattacker, smeansofdeath, idamage ) && !function_f9aa48ce110f92c2( vpoint, instance.var_c0c940b175bdf3ca ) && instance.var_c0c940b175bdf3ca.a_plumes.size < 3 && ispointinvolume( vpoint + ( 0, 0, -2 ), instance.var_c0c940b175bdf3ca.trigger ) )
    {
        level thread function_da0a4d751b519792( vpoint, instance.var_c0c940b175bdf3ca );
    }
}

// Namespace namespace_923cf551235ca152
// Params 4, eflags: 0x4
// Checksum 0x6df6c1b2, Offset: 0x1962
// Size: 0x10b, Type: bool
function private function_de45bcf3d2a03ac2( objweapon, eattacker, smeansofdeath, idamage )
{
    if ( !isplayer( eattacker ) )
    {
        return false;
    }
    
    if ( idamage < 10 )
    {
        return false;
    }
    
    if ( objweapon.inventorytype != "offhand" || issubstr( objweapon.basename, "sat_sl_crossbow_explosive_bolt" ) )
    {
        return false;
    }
    
    foreach ( damage_type in [ "MOD_EXPLOSIVE", "MOD_GRENADE", "MOD_IMPACT", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH" ] )
    {
        if ( damage_type == smeansofdeath )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_923cf551235ca152
// Params 2, eflags: 0x4
// Checksum 0x7fd590f3, Offset: 0x1a76
// Size: 0xa3, Type: bool
function private function_f9aa48ce110f92c2( spawn_loc, parent_struct )
{
    foreach ( plume in parent_struct.a_plumes )
    {
        if ( distance2dsquared( spawn_loc, plume.origin ) < 10000 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_923cf551235ca152
// Params 2, eflags: 0x4
// Checksum 0x373de131, Offset: 0x1b22
// Size: 0x88
function private function_d79ba5fa0ed599a( parent_struct, var_944a2fa2b3f43658 = 5 )
{
    self endon( #"death" );
    wait var_944a2fa2b3f43658;
    
    if ( self && self isscriptableinstance() )
    {
        if ( parent_struct && isarray( parent_struct.a_plumes ) && arraycontains( parent_struct.a_plumes, self ) )
        {
            parent_struct.a_plumes = arrayremove( parent_struct.a_plumes, self );
        }
        
        self freescriptable();
    }
}

// Namespace namespace_923cf551235ca152
// Params 4
// Checksum 0x3a7581b0, Offset: 0x1bb2
// Size: 0x145
function function_da0a4d751b519792( spawn_loc, parent_struct, var_f415f5c14034634 = 3.5, var_944a2fa2b3f43658 = 5 )
{
    level endon( #"game_ended" );
    var_402653d154a75a2 = randomfloatrange( 0, 360 );
    plume = spawnscriptable( %"zm_sat_hornet_lava_plume", spawn_loc, ( 0, var_402653d154a75a2, 0 ) );
    
    if ( isdefined( plume ) )
    {
        parent_struct.a_plumes[ parent_struct.a_plumes.size ] = plume;
    }
    
    level notify( #"hash_5d12c982d0942ee5", spawn_loc );
    trig = spawn( "trigger_radius", spawn_loc, 0, 32, 110 );
    trig thread function_657afe79e13d5649();
    
    /#
        drawtrigger( trig, ( 1, 1, 1 ), 0, 100 );
    #/
    
    waitframe();
    earthquake( 0.61, var_f415f5c14034634, spawn_loc, 100 );
    playrumbleonposition( "heavy_2s", spawn_loc );
    plume thread function_d79ba5fa0ed599a( parent_struct, var_944a2fa2b3f43658 );
    wait var_f415f5c14034634;
    
    if ( parent_struct.a_plumes.size == 3 )
    {
        parent_struct thread set_flow_molten();
        parent_struct notify( #"melt_override" );
    }
    
    if ( isdefined( trig ) )
    {
        trig delete();
    }
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x2e86b0ba, Offset: 0x1cff
// Size: 0x78
function function_657afe79e13d5649()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", ent );
        
        if ( !ent.var_4ea953820e2f3a0 )
        {
            ent.var_4ea953820e2f3a0 = 1;
            
            if ( isplayer( ent ) )
            {
                ent thread function_4eb5569124d402b0( self );
                continue;
            }
            
            ent thread function_e83f2f7334385c14( self );
        }
    }
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0x3705528f, Offset: 0x1d7f
// Size: 0x188
function function_e83f2f7334385c14( trigger )
{
    level endon( #"game_ended" );
    
    if ( self.classname == "actor_sat_dawg" )
    {
        return;
    }
    
    if ( self.subclass == "zombie_base_armored_agni" )
    {
        return;
    }
    
    function_6d0199df77d32abb( 1 );
    
    if ( self.aicategory == "normal" )
    {
        if ( utility::percent_chance( 50 ) )
        {
            namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
        }
        else if ( utility::percent_chance( 50 ) )
        {
            namespace_b76ff2659823e89d::dismember_right_leg();
        }
        else
        {
            namespace_b76ff2659823e89d::dismember_left_leg();
        }
        
        if ( self.magic_bullet_shield )
        {
            ai::stop_magic_bullet_shield();
        }
        
        self kill( self.origin, trigger, trigger, "MOD_UNKNOWN", level.weaponnone );
        corpse = self getcorpseentity();
        
        if ( isdefined( corpse ) )
        {
            var_175e0109a63f0a9b = vectornormalize( self.origin + ( randomfloatrange( -7, 7 ), randomfloatrange( -7, 7 ), 20 ) - self.origin );
            var_175e0109a63f0a9b *= randomfloatrange( 5000, 7500 );
            corpse startragdollfromimpact( "torso_lower", var_175e0109a63f0a9b );
        }
        
        return;
    }
    
    dmg = function_bab5c6e5560fe328();
    
    while ( isdefined( trigger ) && isalive( self ) && self istouching( trigger ) )
    {
        thread effect_burn::burn( 0.75, dmg, 0.75, trigger, "lf_val_string" );
        wait 0.75;
    }
    
    function_6d0199df77d32abb( 0 );
    self.var_4ea953820e2f3a0 = 0;
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0xaeb7b0d2, Offset: 0x1f0f
// Size: 0xc0
function function_4eb5569124d402b0( trigger )
{
    self endon( #"death_or_disconnect" );
    dmg = function_bab5c6e5560fe328();
    thread effect_burn::burn( 0.75, dmg, 0.75, self, "lf_val_string" );
    launch_dest = utility::function_8ae0ea62537eafc5( self.origin, 50 );
    launch_dest += ( 0, 0, 100 );
    v_launch = launch_dest - self.origin;
    self knockback( v_launch, 400, 1 );
    
    while ( isdefined( trigger ) && isalive( self ) && self istouching( trigger ) )
    {
        wait 0.1;
    }
    
    self.var_4ea953820e2f3a0 = 0;
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0x1e74e0ad, Offset: 0x1fd7
// Size: 0x3b
function function_7f25ee6d0d34b270( params )
{
    if ( getdvarint( @"hash_f5108c84be4f65ef", 0 ) )
    {
        return;
    }
    
    if ( self.subclass != "zombie_base_armored_agni" )
    {
        return;
    }
    
    level.var_4aec4c41dc99474c--;
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x1b6e1ebb, Offset: 0x201a
// Size: 0x117
function function_ecd280dbe19d9301()
{
    level endon( #"game_ended" );
    level endon( #"hash_f96017be0610902d" );
    self endon( #"death" );
    
    if ( self.subclass != "zombie_base" || namespace_b76ff2659823e89d::is_crawling() )
    {
        return;
    }
    
    if ( self.var_e4d72e3eca56adc8 || self.var_3ed8e4239fc22029 )
    {
        return;
    }
    
    if ( level.var_4aec4c41dc99474c >= 10 )
    {
        return;
    }
    
    time_elapsed = self.lava_flow_time_elapsed ?? 0;
    turn_scorched = 0;
    
    while ( self.var_d682d30b84057103 && isalive( self ) )
    {
        if ( time_elapsed >= 17 )
        {
            turn_scorched = 1;
            break;
        }
        
        wait 0.1;
        time_elapsed += 0.1;
        self.lava_flow_time_elapsed = time_elapsed;
    }
    
    if ( !turn_scorched )
    {
        return;
    }
    
    throttle::throttle_wait_in_queue( level.lava_flow_scorched_zombie_throttle, self );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_7acbf868c753ff75 = !self.var_75afeb7d6a870ec0;
    
    if ( !var_7acbf868c753ff75 )
    {
        return;
    }
    
    thread function_83ea6c91d2e15321();
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0xe8810f31, Offset: 0x2139
// Size: 0x239
function function_83ea6c91d2e15321()
{
    old_origin = self.origin;
    var_bc17867937da92dc = self.angles;
    old_health_percent = self.health / self.maxhealth;
    scorched_subclass = getdvarint( @"hash_f5108c84be4f65ef", 0 ) ? "zombie_base_armored_light" : "zombie_base_armored_agni";
    scorched = agent_manager::spawn_agent( scorched_subclass, old_origin, var_bc17867937da92dc, "team_two_hundred" );
    
    if ( level.active_relic_challenge && scorched && isalive( scorched ) )
    {
        var_1c3d219b34d9181b = level.active_relic_challenge.bundle.var_618de9e73de3a48d;
        round_number = zm_round_logic::get_rb_round_number();
        round_number = maxint( round_number, var_1c3d219b34d9181b );
        scorched zombie_utils::set_zombie_round_difficulty( round_number, 1 );
    }
    
    if ( !scorched )
    {
        return;
    }
    
    scorched playsound( "evt_lava_zmb_burned" );
    
    if ( !isdefined( level.var_4aec4c41dc99474c ) )
    {
        level.var_4aec4c41dc99474c = 0;
    }
    
    level.var_4aec4c41dc99474c++;
    
    if ( level.var_4aec4c41dc99474c >= 10 )
    {
        level notify( #"hash_f96017be0610902d" );
    }
    
    scorched.var_e4d72e3eca56adc8 = 1;
    scorched callback::add( "on_zombie_ai_killed", &function_7f25ee6d0d34b270 );
    level.var_a009ab14ee0d3223.var_939db9ccafac43a7[ level.var_a009ab14ee0d3223.var_939db9ccafac43a7.size ] = scorched;
    
    if ( self._blackboard.var_ea5eb773cb969ee1 )
    {
        scorched zombie_utils::function_f2e381737e46096( self._blackboard.brainrotowner, 30, 1 );
    }
    
    self.nocorpse = 1;
    
    if ( self.magic_bullet_shield || val::get( "damageshield" ) )
    {
        ai::stop_magic_bullet_shield();
    }
    
    self kill();
    
    /#
        debugstar( old_origin, ( 1, 0, 1 ), 9000 );
    #/
    
    waitframe();
    
    if ( isalive( scorched ) )
    {
        scorched.health = int( ceil( scorched.maxhealth * old_health_percent ) );
    }
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0xe9ef136d, Offset: 0x237a
// Size: 0xe
function function_ae01ddf439656284()
{
    level notify( #"hash_aa3ae7713773ce31" );
}

// Namespace namespace_923cf551235ca152
// Params 0
// Checksum 0x9e89755, Offset: 0x2390
// Size: 0x145
function function_e368f5ca62c8b12c()
{
    var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
    {
        var_b4c1c1d2a952db62 thread function_12cbd14aca639d83();
        var_b4c1c1d2a952db62 thread function_5ebea98343759f73();
    }
    
    var_5836c90831602233 = utility::getstructarray( "border_lv", "targetname" );
    
    foreach ( var_d49bdc4a13e41add in var_5836c90831602233 )
    {
        var_d49bdc4a13e41add.trigger = getent( var_d49bdc4a13e41add.target, #targetname );
        var_d49bdc4a13e41add thread function_5ebea98343759f73();
    }
}

// Namespace namespace_923cf551235ca152
// Params 3
// Checksum 0xeaa67c55, Offset: 0x24dd
// Size: 0x141
function function_697b336296162337( var_2712f83ce875a694, var_566a7ceaabdc0f16, var_fc600ec86ea290c0 = 10 )
{
    dir = vectornormalize( var_566a7ceaabdc0f16 - var_2712f83ce875a694 );
    increment = distance( var_2712f83ce875a694, var_566a7ceaabdc0f16 ) / var_fc600ec86ea290c0;
    z_offset_down = ( 0, 0, -18 );
    
    for ( i = 0; i <= var_fc600ec86ea290c0 ; i++ )
    {
        current_point = var_2712f83ce875a694 + dir * increment * i;
        var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( current_point );
        
        if ( !var_4d7d4fdebb3384d2 )
        {
            continue;
        }
        
        var_5ae3f3c491a78ed8 = 0;
        
        foreach ( t_lava in level.a_t_lava )
        {
            if ( ispointinvolume( var_4d7d4fdebb3384d2 + z_offset_down, t_lava ) )
            {
                var_5ae3f3c491a78ed8 = 1;
                break;
            }
        }
        
        if ( !var_5ae3f3c491a78ed8 )
        {
            return var_4d7d4fdebb3384d2;
        }
    }
    
    return var_566a7ceaabdc0f16;
}

// Namespace namespace_923cf551235ca152
// Params 0, eflags: 0x4
// Checksum 0xe79d28de, Offset: 0x2627
// Size: 0x4a
function private function_55ce28419f71845b()
{
    if ( utility::ent_flag( "hornet_first_lava_damage" ) )
    {
        return;
    }
    
    utility::ent_flag_set( "hornet_first_lava_damage" );
    var_db75d3de862ce072 = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hornet_first_lava_damage" );
    
    if ( !var_db75d3de862ce072 )
    {
        utility::ent_flag_clear( "hornet_first_lava_damage" );
    }
}

// Namespace namespace_923cf551235ca152
// Params 1, eflags: 0x4
// Checksum 0x779d78f6, Offset: 0x2679
// Size: 0xa5
function private function_2da8f69cf9c352fb( params )
{
    var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
    {
        var_b4c1c1d2a952db62 thread set_flow_molten();
        var_b4c1c1d2a952db62 notify( #"melt_override" );
    }
}

// Namespace namespace_923cf551235ca152
// Params 1
// Checksum 0xca9a3988, Offset: 0x2726
// Size: 0xc1
function function_1131b0421d97e24b( time )
{
    level endon( #"game_ended" );
    level utility::flag_set( "lava_flow_changes_paused" );
    var_d9662461fbddd8e6 = utility::getstructarray( "lf_parent", "targetname" );
    
    foreach ( var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
    {
        var_b4c1c1d2a952db62 thread set_flow_molten();
    }
    
    wait time;
    level utility::flag_clear( "lava_flow_changes_paused" );
}

/#

    // Namespace namespace_923cf551235ca152
    // Params 0
    // Checksum 0x1d978, Offset: 0x27ef
    // Size: 0x78, Type: dev
    function init_lava_flow_debug()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3b>", "<dev string:x50>", &function_bafd8769d6d5d65b, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x61>", "<dev string:x76>", &function_31a03153d30b528c, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x87>", "<dev string:x97>", &function_33a1a525910ef508, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9f>", "<dev string:xb0>", &function_574c3e7e31b876e8, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_923cf551235ca152
    // Params 1
    // Checksum 0xe46c1bf7, Offset: 0x286f
    // Size: 0x9f, Type: dev
    function function_bafd8769d6d5d65b( params )
    {
        var_d9662461fbddd8e6 = utility::getstructarray( "<dev string:xb9>", "<dev string:xc3>" );
        
        foreach ( var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
        {
            var_b4c1c1d2a952db62 thread set_flow_cooled( 1, 3 );
        }
    }

    // Namespace namespace_923cf551235ca152
    // Params 1
    // Checksum 0x2622ed3e, Offset: 0x2916
    // Size: 0x9b, Type: dev
    function function_31a03153d30b528c( params )
    {
        var_d9662461fbddd8e6 = utility::getstructarray( "<dev string:xb9>", "<dev string:xc3>" );
        
        foreach ( var_b4c1c1d2a952db62 in var_d9662461fbddd8e6 )
        {
            var_b4c1c1d2a952db62 thread set_flow_molten();
        }
    }

    // Namespace namespace_923cf551235ca152
    // Params 1
    // Checksum 0xdb4d6c1, Offset: 0x29b9
    // Size: 0x16, Type: dev
    function function_33a1a525910ef508( params )
    {
        function_ae01ddf439656284();
    }

    // Namespace namespace_923cf551235ca152
    // Params 1
    // Checksum 0x5445218c, Offset: 0x29d7
    // Size: 0x16, Type: dev
    function function_574c3e7e31b876e8( params )
    {
        function_e368f5ca62c8b12c();
    }

#/
