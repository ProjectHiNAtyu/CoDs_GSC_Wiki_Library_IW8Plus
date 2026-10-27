// scripts\common\ai\aitypes\zombie_vermin\zombie_vermin.gsc  (hash_3f9a4a4fb59e9be8.gscc) (size: 9222 Bytes / 0x2406 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1acda404 (449684484)
// size ...... 9222 (0x2406)
// includes .. 14  (offset: 0x200a)
// strings ... 63  (offset: 0x207a)
// dev strs .. 0   (offset: 0x2406)
// exports ... 29  (offset: 0x123e)
// cseg ...... 0x453 + 0xdeb (0x123e)
// imports ... 74  (offset: 0x16c6)
// animtree1 . 0   (offset: 0x2406)
// animtree2 . 0   (offset: 0x2406)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_audio;
#using scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_emergence_spawning;
#using scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_leap_attack;
#using scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_medal;
#using scripts\common\ai\aitypes\zombie_vermin\zombie_vermin_ranged_attack;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vortex;
#using scripts\mp\common\weapons\weap_manglercannon;

#namespace zombie_vermin;

// Namespace zombie_vermin
// Params 2
// Checksum 0x39054f85, Offset: 0x471
// Size: 0x1e
function precache( classname, aitypescriptbundle )
{
    zombie_vermin_ranged_attack::function_3a2616b882541ba7( aitypescriptbundle );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xef2c89b6, Offset: 0x497
// Size: 0x2cf
function private function_b6861f92da3ebf0c( params )
{
    namespace_a3f4c098b1921a57::init_zombie_vermin_audio_global();
    zombie_melee::init_zombie_melee_global();
    zombie_vermin_leap_attack::function_e048cfb0a8e71467();
    zombie_vermin_emergence_spawning::function_114652f806fd9dff();
    zombie_vermin_medal::function_5b9d1100ed8bd937();
    callback::get_template( self.animsetname ) callback::add( "zombie_melee", &on_vermin_bite );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_leap_hit", &on_vermin_bite );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_b7dd02b2f0d6a2c1 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_corpse_annihilated", &on_corpse_annihilated );
    callback::get_template( self.animsetname ) callback::add( "on_turned", &function_a4944ca11f0ecb0e );
    callback::get_template( self.animsetname ) callback::add( "poisoned", &function_91e753b101229a2 );
    callback::get_template( self.animsetname ) callback::add( "poisoned_end", &function_8c2a60ae74d8ce34 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned", &function_9a92f215ba32b261 );
    callback::get_template( self.animsetname ) callback::add( "wraith_burned_end", &function_c9afe0de75edf987 );
    callback::get_template( self.animsetname ) callback::add( "burned", &function_2080c9a8a657bc17 );
    callback::get_template( self.animsetname ) callback::add( "burned_end", &function_ef6cb4c9a207699d );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned", &function_2b8879e19ccaeef3 );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_thermite", &function_aa4be0297708a8fa );
    callback::get_template( self.animsetname ) callback::add( "napalm_burned_end", &function_8b959aabb4069e99 );
    callback::get_template( self.animsetname ) callback::add( "shocked", &function_ce4fe5b7b95b73f6 );
    callback::get_template( self.animsetname ) callback::add( "shocked_end", &function_f8cbef2738adcd18 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_d94b1d123774232f );
    callback::get_template( self.animsetname ) callback::add( "on_vortex_pull_changed", &on_vortex_pull_changed );
    callback::get_template( self.animsetname ) callback::add( "on_vortex_pull_updated", &on_vortex_pull_updated );
    callback::get_template( self.animsetname ) callback::add( "on_vortex_pull_ended", &on_vortex_pull_ended );
}

// Namespace zombie_vermin
// Params 1
// Checksum 0x80449996, Offset: 0x76e
// Size: 0x10c
function function_c27b70c619647d79( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_b6861f92da3ebf0c );
    self.allowpain = 0;
    self.var_878a729dd9083870 = "bite_attack_in";
    zombie_melee::function_2cc3729a3cdeadbf( "walk", 100 );
    zombie_melee::function_2cc3729a3cdeadbf( "run", 120 );
    self enabletraversals( 1, "zombie", "wall" );
    self function_d797324a8b0d93b4( "script_penalty", 2 );
    self function_d65988550260aaca( 1 );
    self setsafemodel( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.arachnophobiaxmodel );
    namespace_a3f4c098b1921a57::init_zombie_vermin_audio();
    zombie_melee::init_zombie_melee();
    zombie_vermin_leap_attack::init_zombie_vermin_leap_attack();
    zombie_vermin_ranged_attack::init_zombie_vermin_ranged_attack();
    zombie_vermin_emergence_spawning::init_zombie_vermin_emergence_spawning();
    thread initscriptable();
    return anim.success;
}

// Namespace zombie_vermin
// Params 1
// Checksum 0x11b9e0e8, Offset: 0x883
// Size: 0x57, Type: bool
function function_a3dd2b45bc71cd28( weapon )
{
    if ( isdefined( weapon ) && function_ec5e321fe43d2fc( weapon ) )
    {
        return true;
    }
    
    if ( self.var_65522105f3bdca37 || isdefined( self.var_bd22ba6c600a23a3 ) || self.forceannihilate || self.var_48960fedb514aedd )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_vermin
// Params 0, eflags: 0x4
// Checksum 0x9244398, Offset: 0x8e3
// Size: 0x40
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_32b24db3127bff40( "base", "base_on" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x1f13eec9, Offset: 0x92b
// Size: 0x32
function private on_vermin_bite( params )
{
    if ( isdefined( params.var_2d2aab21299551f8 ) || isdefined( params.var_c146e72268eb8492 ) )
    {
        thread function_c97277d9dc4a067d();
    }
}

// Namespace zombie_vermin
// Params 0, eflags: 0x4
// Checksum 0x46826a54, Offset: 0x965
// Size: 0x3b
function private function_c97277d9dc4a067d()
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "bite", "bite" );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "bite", "off" );
    }
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x3a33ca71, Offset: 0x9a8
// Size: 0xe6
function private function_b7dd02b2f0d6a2c1( params )
{
    if ( self._blackboard.var_397bfb4ed7256a7a )
    {
        var_eeb7d8ab4b36922e = 6000;
        var_55820ae44cbac8a0 = 1000;
        var_32a0001d27342f5b = ( 0, 0, 0 );
        
        if ( params.smeansofdeath == "MOD_MELEE" )
        {
            var_32a0001d27342f5b = anglestoup( self.angles ) * var_eeb7d8ab4b36922e;
        }
        else
        {
            var_32a0001d27342f5b = anglestoup( self.angles ) * var_55820ae44cbac8a0;
        }
        
        self.ragdollimpactvector = var_32a0001d27342f5b;
        self.ragdollhitloc = "head";
        return;
    }
    
    if ( self._blackboard.var_397bfb4ed7256a7a )
    {
        self.ragdollimpactvector = ( 0, 0, 0 );
        self.ragdollhitloc = "head";
    }
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x37bb9b00, Offset: 0xa96
// Size: 0x2d1
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    utility::function_32b24db3127bff40( "base", "base_off" );
    
    if ( isdefined( body ) && function_a3dd2b45bc71cd28( params.eattacker.currentprimaryweapon ) )
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
        body utility::function_32b24db3127bff40( "death", "death_annihilate" );
        wait 0.08;
        body delete();
        return;
    }
    else if ( isdefined( body ) && self._blackboard.var_dd9753fd93ed92d )
    {
        body endon( #"corpse_deleted" );
        body waittill( #"transform_start" );
        body utility::function_32b24db3127bff40( "transform", "transform" );
        wait 0.1;
        body delete();
        return;
    }
    else
    {
        body utility::function_32b24db3127bff40( "death", "death" );
    }
    
    if ( isdefined( self ) && isdefined( body ) )
    {
        var_3db5d3a5dd4daa4d = 15;
        var_73b7de7f72e04734 = 12;
        var_37df00f2ca729817 = 0;
        
        if ( self._blackboard.var_397bfb4ed7256a7a )
        {
            var_37df00f2ca729817 = var_3db5d3a5dd4daa4d;
        }
        else
        {
            var_37df00f2ca729817 = var_73b7de7f72e04734;
        }
        
        upvec = anglestoup( body.angles );
        body.origin += var_37df00f2ca729817 * upvec;
        
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
        }
    }
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x26f0b708, Offset: 0xd6f
// Size: 0xa0
function private on_corpse_annihilated( params )
{
    level endon( #"game_ended" );
    corpse = params.corpse;
    
    if ( isdefined( corpse ) )
    {
        if ( isdefined( params.annihilate_time ) )
        {
            wait_time = params.annihilate_time - level.framedurationseconds;
            
            if ( wait_time >= level.framedurationseconds )
            {
                wait wait_time;
            }
            else
            {
                waittillframeend();
            }
        }
        
        if ( isdefined( corpse ) )
        {
            corpse callback::callback( "on_annihilated" );
            corpse utility::function_32b24db3127bff40( "death", "death_annihilate" );
        }
    }
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xf42cf522, Offset: 0xe17
// Size: 0x30
function private function_a4944ca11f0ecb0e( attacker )
{
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "turned", 26 );
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xa7cb0a05, Offset: 0xe4f
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x9a8b6805, Offset: 0xe74
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x5cb9d9c6, Offset: 0xea5
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xe016866d, Offset: 0xeca
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x11d1853c, Offset: 0xefb
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xe3d47efd, Offset: 0xf42
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_7c10ea82c1e305b8( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_vermin
// Params 0, eflags: 0x4
// Checksum 0xcac82543, Offset: 0xf89
// Size: 0x25
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xe8072587, Offset: 0xfb6
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x8eee8827, Offset: 0xfdb
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x913922e1, Offset: 0x1000
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xc0758e99, Offset: 0x1025
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x57e42929, Offset: 0x104a
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_vermin
// Params 0, eflags: 0x4
// Checksum 0x916f8398, Offset: 0x106f
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

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x47bd5b86, Offset: 0x10d5
// Size: 0x81
function private function_d94b1d123774232f( params )
{
    if ( params.idamage >= self.health && isdefined( params.sweapon ) && weap_manglercannon::is_mangler_cannon( params.sweapon ) )
    {
        self.forceannihilate = 1;
        self.var_43c8b099cb9651b2 = 1;
        
        if ( zombie_traverse::is_traversing() )
        {
            self.forceragdollimmediate = 1;
            self.ragdoll_damagelocation_none = "torso_upper";
        }
    }
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x3f0b9118, Offset: 0x115e
// Size: 0x22
function private on_vortex_pull_changed( params )
{
    if ( isdefined( self ) )
    {
        self.vortex_pull_angles = undefined;
        vortex::function_cd569249e4f9ac94();
    }
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0xe8570e41, Offset: 0x1188
// Size: 0x18
function private on_vortex_pull_updated( params )
{
    if ( isdefined( self ) )
    {
        vortex::function_cd569249e4f9ac94();
    }
}

// Namespace zombie_vermin
// Params 1, eflags: 0x4
// Checksum 0x16398b35, Offset: 0x11a8
// Size: 0x96
function private on_vortex_pull_ended( params )
{
    if ( isdefined( self ) )
    {
        self.vortex_pull_angles = undefined;
        
        if ( self.var_507d3f5433b78f74 )
        {
            navmesh_pos = utility::function_5918594658d3ffba( self.origin, 0, -160 );
            
            if ( isdefined( navmesh_pos ) && distance2dsquared( self.origin, navmesh_pos ) <= 1024 )
            {
                self animmode( "gravity_off_nav" );
                self.var_507d3f5433b78f74 = 0;
                return;
            }
            
            self.forceannihilate = 1;
            self.var_a13bed1ac47e1b2c = 1;
            self kill();
        }
    }
}

