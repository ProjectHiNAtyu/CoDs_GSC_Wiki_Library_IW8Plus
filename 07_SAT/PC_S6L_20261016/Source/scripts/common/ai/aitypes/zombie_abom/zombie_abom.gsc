// scripts\common\ai\aitypes\zombie_abom\zombie_abom.gsc  (hash_48505f7e75c56920.gscc) (size: 8478 Bytes / 0x211e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x818b819 (135837721)
// size ...... 8478 (0x211e)
// includes .. 13  (offset: 0x1d5e)
// strings ... 60  (offset: 0x1dc6)
// dev strs .. 0   (offset: 0x211e)
// exports ... 27  (offset: 0x1072)
// cseg ...... 0x478 + 0xbfa (0x1072)
// imports ... 71  (offset: 0x14aa)
// animtree1 . 0   (offset: 0x211e)
// animtree2 . 0   (offset: 0x211e)
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_audio;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_crawler_deploy;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_heads;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_medal;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\common\ai\aitypes\zombie_abom\zombie_abom_swallow;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_abom;

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x9033ba70, Offset: 0x496
// Size: 0x1f3
function private function_cfbb84b3d7bc65b8( params )
{
    zombie_abom_audio::init_zombie_abom_audio_global();
    zombie_melee::init_zombie_melee_global();
    zombie_abom_heads::init_zombie_abom_heads_global();
    namespace_2c5c73b3013cc64a::init_zombie_abom_swallow_global();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( #"long_teleport", &function_aa62e405eca3c0f5 );
    namespace_117dd5f91d46b96e::function_69609f334e1c25a7();
}

// Namespace zombie_abom
// Params 1
// Checksum 0xb567ef29, Offset: 0x691
// Size: 0x2aa
function function_9bcfe8897caa468d( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    callback::add( "on_zombie_init_restore_metabones", &restore_metabones );
    self.var_885001fb6c6706f8 = [];
    self.var_885001fb6c6706f8[ 0 ] = "head_le";
    self.var_885001fb6c6706f8[ 1 ] = "head_mid";
    self.var_885001fb6c6706f8[ 2 ] = "head_ri";
    zombie_abom_heads::init_zombie_abom_heads();
    zombie_melee::init_zombie_melee();
    zombie_abom_audio::init_zombie_abom_audio();
    namespace_2550b633082f1bd9::init_zombie_abom_crawler_deploy();
    namespace_2c5c73b3013cc64a::init_zombie_abom_swallow();
    thread initscriptable();
    val::set( "abom_pain", "pain", 0 );
    thread function_aa471cb14aea02d2();
    metabone::set_metabone_state( "head_mid", "open" );
    metabone::set_metabone_state( "head_ri", "open" );
    metabone::set_metabone_state( "head_le", "open" );
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.candeploycrawler )
    {
        self function_786bb6aa1b76c7ee( "can_deploy_crawler", 1 );
    }
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_21f0139390ec205f )
    {
        thread function_f2976906a5c4f8c5();
    }
    
    self pushplayer( 0 );
    self function_ff32ea59b2119107();
    self.var_34257b16d1050bab = 0;
    self.allowfriendlyfire = 1;
    self enabletraversals( 1, "zombie", "climb" );
    var_228efc0bacfb0ff6 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8f09538d57244ed1;
    self function_786bb6aa1b76c7ee( "charge_attack_dist", var_228efc0bacfb0ff6 );
    var_b9957765cd7c65a2 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_bc69ee620a959005;
    self function_786bb6aa1b76c7ee( "charge_attack_min_dist", var_b9957765cd7c65a2 );
    var_5c3dc222c1f188df = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5c3dc222c1f188df;
    self function_786bb6aa1b76c7ee( "beam_attack_dist", var_228efc0bacfb0ff6 );
    self.var_89cc06fcebe201a1 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_89cc06fcebe201a1;
    self.swallowdamagemultiplier = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.swallowdamagemultiplier;
    self.var_81239cbfa6fb7d8b = &function_a943c725a8657266;
    return anim.success;
}

// Namespace zombie_abom
// Params 0
// Checksum 0x233b5809, Offset: 0x944
// Size: 0x56
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    
    if ( self isscriptable() )
    {
        utility::function_32b24db3127bff40( "base", "base_on" );
        prepare_spawn_reveal();
        thread spawn_reveal();
    }
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x4c14c180, Offset: 0x9a2
// Size: 0x25
function private restore_metabones( params )
{
    metabone::restore_metabones( params.saved_metabones );
    namespace_ad681b768a39ef59::update_head_health();
}

// Namespace zombie_abom
// Params 2
// Checksum 0xea0c618c, Offset: 0x9cf
// Size: 0xde
function function_c6473c0e6e80ba2c( taskid, params )
{
    var_784375078a3590b1 = 40000;
    var_c4355f8f73366b2c = 10000;
    
    if ( isdefined( self.enemy ) )
    {
        dist_sqr_to_enemy = distance2dsquared( self.enemy.origin, self.origin );
        
        if ( dist_sqr_to_enemy < var_784375078a3590b1 && self.beam_attack_failed )
        {
            return anim.success;
        }
        
        var_b0a681d77fccb76d = abs( self.enemy.origin[ 2 ] - self.origin[ 2 ] );
        
        if ( dist_sqr_to_enemy < var_c4355f8f73366b2c && var_b0a681d77fccb76d > sqrt( dist_sqr_to_enemy ) )
        {
            return anim.success;
        }
    }
    
    return anim.failure;
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xf5e23661, Offset: 0xab6
// Size: 0xbf
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        body utility::function_32b24db3127bff40( "death_reveal", "death_reveal" );
        
        if ( utility::ent_flag( "dark_aether_bubble" ) )
        {
            body utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dissolve" );
            body thread dark_aether_bubble_timer();
        }
        
        if ( utility::ent_flag( "burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned", "burned_on" );
        }
        else if ( utility::ent_flag( "napalm_burned" ) )
        {
            body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
        }
        
        body endon( #"corpse_deleted" );
        wait 2;
        body delete();
    }
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x900fd1e8, Offset: 0xb7d
// Size: 0x4b, Type: bool
function private is_explosive_damage( smeansofdeath )
{
    if ( smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x8e434090, Offset: 0xbd1
// Size: 0x46, Type: bool
function private function_a943c725a8657266( var_e31c53eb403a02dd )
{
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_17f5b802bbd0062c && is_explosive_damage( var_e31c53eb403a02dd.smeansofdeath ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_abom
// Params 0, eflags: 0x4
// Checksum 0x27f0eadf, Offset: 0xc20
// Size: 0x64
function private function_aa471cb14aea02d2()
{
    self endon( #"death" );
    
    while ( true )
    {
        in_bull_charge = istrue( self getaiblackboarddynamic( "in_bull_charge" ) );
        
        if ( in_bull_charge )
        {
            if ( self.collide_with_ai )
            {
                self.collide_with_ai = 0;
            }
        }
        else if ( !self.collide_with_ai )
        {
            self.collide_with_ai = 1;
        }
        
        waitframe();
    }
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xbba2fbe5, Offset: 0xc8c
// Size: 0xdf
function private spawn_reveal( b_teleport_reveal )
{
    self endon( #"death" );
    self clearpath();
    self setbtgoalstationary( 0 );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
    
    if ( b_teleport_reveal )
    {
        waitframe();
    }
    
    if ( !self.disable_spawn_vfx )
    {
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal" );
    }
    else
    {
        zombie_abom_heads::attach_heads();
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_audio_only" );
    }
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 0;
    }
    
    wait 1;
    
    if ( !b_teleport_reveal && !self.disable_spawn_vfx )
    {
        zombie_abom_heads::attach_heads();
    }
    
    wait 1;
    self function_f2df0257c63f229( "in_spawn_reveal" );
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 1;
    }
    
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x4f6a5c28, Offset: 0xd73
// Size: 0x2a
function private prepare_spawn_reveal( b_teleport_reveal )
{
    if ( !b_teleport_reveal )
    {
        zombie_abom_heads::dettach_heads();
    }
    
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_abom
// Params 0, eflags: 0x4
// Checksum 0xd0e004c3, Offset: 0xda5
// Size: 0xa6
function private function_f2976906a5c4f8c5()
{
    self endon( #"death" );
    var_ac67e97247949e6d = 45;
    
    while ( true )
    {
        in_bull_charge = istrue( self getaiblackboarddynamic( "in_bull_charge" ) );
        
        if ( !in_bull_charge )
        {
            var_3d59325a317e26b9 = length( self.velocity );
            
            if ( var_3d59325a317e26b9 > 10 )
            {
                var_46e46e7e7783a5e4 = vectornormalize( self.velocity );
                var_a4e0f2ef8a40ae19 = self.origin + var_46e46e7e7783a5e4 * var_ac67e97247949e6d;
                radiusdamage( var_a4e0f2ef8a40ae19, var_ac67e97247949e6d, 1000, 1000, self, undefined, undefined, 1 );
            }
        }
        
        wait 0.25;
    }
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xbfd90736, Offset: 0xe53
// Size: 0x1e
function private function_aa62e405eca3c0f5( params )
{
    prepare_spawn_reveal( 1 );
    thread spawn_reveal( 1 );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xa88413e7, Offset: 0xe79
// Size: 0x1d
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xb2d3e539, Offset: 0xe9e
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x25424289, Offset: 0xec3
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xd56d61a5, Offset: 0xee8
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xe82d03a5, Offset: 0xf0d
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x2e1fb266, Offset: 0xf3e
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x92b0edcd, Offset: 0xf63
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x399826fa, Offset: 0xf94
// Size: 0x1d
function private function_2080c9a8a657bc17( s_burn_effect )
{
    utility::function_32b24db3127bff40( "burned", "burned_on" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xcb9ddd3b, Offset: 0xfb9
// Size: 0x1d
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0x9aa14e27, Offset: 0xfde
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xfc48e387, Offset: 0x1003
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_abom
// Params 1, eflags: 0x4
// Checksum 0xe39f4941, Offset: 0x1028
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_abom
// Params 0, eflags: 0x4
// Checksum 0x99c0e39d, Offset: 0x104d
// Size: 0x25
function private dark_aether_bubble_timer()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dark_aether_field_bubble_off" );
}

