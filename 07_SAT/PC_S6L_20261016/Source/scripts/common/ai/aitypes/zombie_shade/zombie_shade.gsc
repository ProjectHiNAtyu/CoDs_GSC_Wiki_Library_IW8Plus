// scripts\common\ai\aitypes\zombie_shade\zombie_shade.gsc  (hash_44e79cce637a597a.gscc) (size: 7998 Bytes / 0x1f3e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5872a6c (2777098860)
// size ...... 7998 (0x1f3e)
// includes .. 17  (offset: 0x1b42)
// strings ... 60  (offset: 0x1bca)
// dev strs .. 0   (offset: 0x1f3e)
// exports ... 21  (offset: 0xf62)
// cseg ...... 0x447 + 0xb1b (0xf62)
// imports ... 70  (offset: 0x12aa)
// animtree1 . 0   (offset: 0x1f3e)
// animtree2 . 0   (offset: 0x1f3e)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_dismemberment;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_audio;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_dismemberment;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_medal;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_swipe;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;

#namespace zombie_shade;

// Namespace zombie_shade
// Params 2
// Checksum 0x94dbcd08, Offset: 0x465
// Size: 0x38
function precache( classname, aitypescriptbundle )
{
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        zombie_shade_vehicle_attack::precache_zombie_shade_vehicle_attack( var_4b4d72d84afd1ebd );
    }
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xad9f90b4, Offset: 0x4a5
// Size: 0x1b6
function private function_b9893aed75d07b8e( params )
{
    zombie_melee::init_zombie_melee_global();
    zombie_shade_vehicle_attack::init_zombie_shade_vehicle_attack_global();
    zombie_shade_loot_consume::init_zombie_shade_loot_consume_global();
    zombie_shade_dismemberment::function_be94e63ff4741f52();
    zombie_shade_audio::function_45dd9f685e16e82a();
    zombie_shade_medal::function_9b70bb641b6d50cb();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "zombie_melee", &function_f4c9b6e046ec6bc0 );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_9aa35441ce7c4080 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "on_vortex_pull_changed", &function_7fdc2971cce4b3f4 );
    callback::get_template( self.animsetname ) callback::add( "zombie_melee_pre", &zombie_shade_swipe::function_7a571d3f337c9f5e );
}

// Namespace zombie_shade
// Params 1
// Checksum 0xf58e464f, Offset: 0x663
// Size: 0xcf
function function_ba9c77c3543843ef( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_b9893aed75d07b8e );
    self.var_878a729dd9083870 = "swipe_in";
    zombie_melee::function_2cc3729a3cdeadbf( "walk", 130 );
    zombie_melee::function_2cc3729a3cdeadbf( "run", 200 );
    zombie_melee::function_2cc3729a3cdeadbf( "sprint", 260 );
    zombie_melee::init_zombie_melee();
    namespace_96f746e657c877bf::init_zombie_ranged_attack();
    zombie_shade_swipe::init_zombie_shade_swipe();
    
    if ( self.var_d6894f01a36b4ff3.var_e1709a8e0b14d29b )
    {
        zombie_shade_vehicle_attack::init_zombie_shade_vehicle_attack();
    }
    
    zombie_shade_loot_consume::init_zombie_shade_loot_consume();
    zombie_shade_dismemberment::init_zombie_shade_dismemberment();
    zombie_shade_audio::init_zombie_shade_audio();
    thread initscriptable();
    return anim.success;
}

// Namespace zombie_shade
// Params 0, eflags: 0x4
// Checksum 0x52231164, Offset: 0x73b
// Size: 0x56
function private initscriptable()
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

// Namespace zombie_shade
// Params 0, eflags: 0x4
// Checksum 0xeee8334d, Offset: 0x799
// Size: 0x13
function private prepare_spawn_reveal()
{
    utility::function_32b24db3127bff40( "portal", "off" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x96b6cc29, Offset: 0x7b4
// Size: 0xdb
function private spawn_reveal( b_teleport_reveal )
{
    self endon( #"death" );
    self clearpath();
    self setbtgoalstationary( 0 );
    self function_786bb6aa1b76c7ee( "in_spawn_reveal", 1 );
    
    if ( !self.disable_spawn_vfx )
    {
        utility::function_32b24db3127bff40( "portal", "portal" );
    }
    else if ( self.disable_spawn_sfx )
    {
        utility::function_32b24db3127bff40( "portal", "portal_audio_only" );
    }
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 0;
    }
    
    utility::waittill_notify_or_timeout( "shade_spawn_portal_end", 0.7 );
    self function_f2df0257c63f229( "in_spawn_reveal" );
    asm_bb::bb_clearanimscripted();
    wait 0.5;
    
    if ( utility::ent_flag( "stealth_enabled" ) )
    {
        self.stealth_enabled = 1;
    }
    
    utility::function_32b24db3127bff40( "portal", "off" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x201694f7, Offset: 0x897
// Size: 0x2a8
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    utility::function_32b24db3127bff40( "base", "base_off" );
    
    if ( isdefined( body ) && zombie_dismemberment::function_29164cae62119e2f( params.eattacker, params.shitloc, params.eattacker.currentprimaryweapon ) )
    {
        body endon( #"corpse_deleted" );
        
        if ( self.var_43c8b099cb9651b2 )
        {
            if ( isdefined( self.asmname ) )
            {
                var_53c72034d2c5ef25 = "start_annihilate";
                statename = self asmgetcurrentstate( self.asmname );
                
                if ( isdefined( statename ) )
                {
                    animid = asm::asm_getanim( self.asmname, statename );
                    
                    if ( isdefined( animid ) )
                    {
                        xanim = asm::asm_getxanim( statename, animid );
                        
                        if ( isanimation( xanim ) )
                        {
                            animlength = getanimlength( xanim );
                            
                            if ( animhasnotetrack( xanim, var_53c72034d2c5ef25 ) )
                            {
                                frac = getnotetracktimes( xanim, var_53c72034d2c5ef25 )[ 0 ];
                                annihilate_time = animlength * frac;
                            }
                            else
                            {
                                annihilate_time = animlength * 0.5;
                            }
                            
                            wait annihilate_time;
                        }
                    }
                }
            }
        }
        
        body callback::callback( "on_annihilated" );
        
        if ( !self.vehicle_attack_crushed )
        {
            body utility::function_32b24db3127bff40( "death", "death_annihilate" );
        }
        
        wait 0.08;
        body delete();
        return;
    }
    else
    {
        body utility::function_32b24db3127bff40( "death", "death" );
    }
    
    if ( isdefined( self ) && isdefined( body ) )
    {
        var_73b7de7f72e04734 = 5;
        upvec = anglestoup( body.angles );
        body.origin += var_73b7de7f72e04734 * upvec;
        
        if ( utility::ent_flag( "burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned", "burned_on" );
            body thread function_fc12a24729ef4e67();
            return;
        }
        
        if ( utility::ent_flag( "napalm_burned" ) )
        {
            body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
            body thread function_a67c6606a684a2dd();
            return;
        }
        
        if ( utility::ent_flag( "dissolve_purple" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_purple", "reveal_death_purple" );
            return;
        }
        
        if ( utility::ent_flag( "locust_ww_burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww", "burned_dead" );
            return;
        }
        
        if ( utility::ent_flag( "locust_ww_burned_pap" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww_pap", "burned_dead" );
        }
    }
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xf742bf71, Offset: 0xb47
// Size: 0x42
function private function_f4c9b6e046ec6bc0( params )
{
    if ( isdefined( params.var_2d2aab21299551f8 ) && params.var_2d2aab21299551f8 vehicle::is_vehicle() )
    {
        thread function_404c02bebf41ade1( params.msg );
    }
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xc2f96ab5, Offset: 0xb91
// Size: 0x63
function private function_9aa35441ce7c4080( attacker )
{
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "turned", 26 );
    utility::function_32b24db3127bff40( "base", "base_off" );
    utility::function_32b24db3127bff40( "loot_consume_stage", "off" );
    utility::function_7c10ea82c1e305b8( "fog", "off" );
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xbfdd2259, Offset: 0xbfc
// Size: 0x7e
function private function_404c02bebf41ade1( hand )
{
    self endon( #"death" );
    
    switch ( hand )
    {
        case #"hash_da51cc36a471058":
            utility::function_32b24db3127bff40( "swipe", "swipe_left" );
            break;
        case #"hash_da2f35145aa58933":
            utility::function_32b24db3127bff40( "swipe", "swipe_right" );
            break;
    }
    
    wait 0.15;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "swipe", "off" );
    }
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x61d6fe40, Offset: 0xc82
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x93d30581, Offset: 0xcc9
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_7c10ea82c1e305b8( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_shade
// Params 0, eflags: 0x4
// Checksum 0xbacf5e3f, Offset: 0xd10
// Size: 0x25
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x98005efb, Offset: 0xd3d
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xfee9f35b, Offset: 0xd62
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xe13e599d, Offset: 0xd87
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0xb072f5e5, Offset: 0xdac
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x27e35255, Offset: 0xdd1
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_shade
// Params 0, eflags: 0x4
// Checksum 0xe168f8e4, Offset: 0xdf6
// Size: 0x5e
function private function_a67c6606a684a2dd()
{
    self endon( #"corpse_deleted" );
    wait 3.7;
    var_80f3576404b5eba0 = utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_dead" );
    
    if ( var_80f3576404b5eba0 )
    {
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_end" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_shade
// Params 1, eflags: 0x4
// Checksum 0x466d53e5, Offset: 0xe5c
// Size: 0x106
function private function_7fdc2971cce4b3f4( params )
{
    var_619ecd6a2a05bd4e = 10;
    var_b886935ed2964a94 = 0.5;
    vortexorigin = self._blackboard.vortexpullorigin + ( 0, 0, params.height );
    self.var_fe7f2e477eb71311 = 1;
    utility::waittill_notify_or_timeout( "vortex_death_start", var_619ecd6a2a05bd4e );
    
    if ( self._blackboard.var_431d45d5a00efc3d )
    {
        self settraversalattributes( self.origin, vortexorigin, self.angles, vortexorigin );
        utility::waittill_notify_or_timeout( "vortex_center_reached", var_b886935ed2964a94 );
        self.forceannihilate = 1;
        
        if ( !self.var_bd3832dce50941ae && !val::get( "damageshield" ) )
        {
            self kill( vortexorigin, params.grenade.owner, params.grenade, "MOD_CRUSH" );
        }
    }
}

