// scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos.gsc  (hash_6d883d72480ccb34.gscc) (size: 16752 Bytes / 0x4170 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4e94ce07 (1318374919)
// size ...... 16752 (0x4170)
// includes .. 18  (offset: 0x3a8c)
// strings ... 106 (offset: 0x3b1c)
// dev strs .. 4   (offset: 0x4140)
// exports ... 53  (offset: 0x21d8)
// cseg ...... 0x845 + 0x1993 (0x21d8)
// imports ... 133 (offset: 0x2a20)
// animtree1 . 0   (offset: 0x4170)
// animtree2 . 0   (offset: 0x4170)
#using script_311d9b04cdffeb58;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_melee;
#using scripts\common\ai\aitypes\shared\zombie\zombie_projectile_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_ranged_attack;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_audio;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_claw_hammer;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_enraged;
#using scripts\common\ai\aitypes\zombie_karkinos\zombie_karkinos_medal;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_karkinos;

// Namespace zombie_karkinos
// Params 2
// Checksum 0x7f17a993, Offset: 0x863
// Size: 0x60
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "karkinos_weakpoint_impact_fx", settings.weakpointvfxpath );
    }
    
    utility::add_fx( "karkinos_trident_dissolve_fx", "vfx_sat_gameplay_zm_ai_karkinos_trident_dst" );
    zombie_projectile_attack::precache( aitypescriptbundle );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x743db052, Offset: 0x8cb
// Size: 0x324
function private function_cfbb84b3d7bc65b8( params )
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    zombie_melee::init_zombie_melee_global();
    namespace_1dae79e17ca61fd8::function_74083a13eaa941a1();
    zombie_karkinos_audio::function_f77bfc70f00f34af();
    zombie_karkinos_claw_hammer::init_global();
    callback::get_template( self.animsetname ) callback::add( "on_turned", &on_zombie_turned );
    callback::get_template( self.animsetname ) callback::add( "on_brainrot_end", &function_16751232a9e10970 );
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
    callback::get_template( self.animsetname ) callback::add( "pre_killed_body_cloned", &pre_play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &karkinos_damage_callback );
    callback::get_template( self.animsetname ) callback::add( "spawn_animscripted", &on_spawn_animscripted );
    callback::get_template( self.animsetname ) callback::add( "on_ai_stunned", &function_803592cfbf246266 );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_spawned", &post_init );
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
    callback::get_template( self.animsetname ) callback::add( "on_ai_acquire_attractor", &function_747b5161631cb7a2 );
    callback::get_template( self.animsetname ) callback::add( "on_ai_lose_attractor", &function_a3233947db2aea4d );
    zombie_karkinos_medal::function_837d19342ee3d28a();
    callback::callback( "on_zombie_karkinos_first_init" );
    
    /#
        init_karkinos_devgui();
    #/
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0x46050e08, Offset: 0xbf7
// Size: 0x305
function function_578ab4484fe483c( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    callback::add( "on_first_ai_init", &function_cfbb84b3d7bc65b8 );
    callback::add( "on_zombie_ai_killed", &function_50909962e5019afa );
    zombie_melee::init_zombie_melee();
    namespace_96f746e657c877bf::init_zombie_ranged_attack();
    zombie_projectile_attack::init();
    self.var_cdf48282bb6d1237 = 100;
    self.allowstrafe = 0;
    self.claw_arm_destroyed = 0;
    init_shield_locks();
    self.claw_shield_destroy_damage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fecabaf53d0436d7;
    self.var_82da5c4869c3eed3 = 1 - self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ef4045729725c115 * 0.01;
    self.var_5c0eda7cf6a5561 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_87e741b110049236;
    self.claw_melee_range = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7605e064982f8160;
    self.ranged_attack_dist = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f608fbbbe48e3475;
    self.ranged_attack_cooldown = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_80527e900b54c4ec ) );
    self.var_ddacc0ca93a16eb6 = self.var_d6894f01a36b4ff3.meleeknockbackstrength;
    self.var_d5ae8d9ff7d863e2 = min( self.maxhealth * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ce36f9f2382708c6 * 0.01, self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5e0adde65000849e );
    self.upaimlimit = 0;
    self.downaimlimit = 0;
    self.leftaimlimit = 0;
    self.rightaimlimit = 0;
    self function_68f2f6fd8a4ffcae( 0, 4 );
    zombie_karkinos_enraged::init_karkinos_enrage();
    zombie_karkinos_claw_hammer::init_karkinos_claw_hammer();
    zombie_melee::function_2cc3729a3cdeadbf( "walk", 85 );
    zombie_melee::function_2cc3729a3cdeadbf( "sprint", 175 );
    self.spawn_vfx = undefined;
    self.trident_hidden = 0;
    thread initscriptable();
    thread function_146bb2802691c6f();
    
    if ( getdvarint( @"hash_ae1e6f6ce11fd4d0", 1 ) > 0 )
    {
        thread function_496409cd6892e5f5();
        thread watch_pain_end();
    }
    
    zombie_karkinos_audio::init_zombie_karkinos_audio();
    
    if ( getdvarint( @"hash_ba9ed25b48a30376", 1 ) == 1 )
    {
        thread function_7ae5a79a289eaf16();
        thread ranged_attack_end_listener();
    }
    
    self function_786bb6aa1b76c7ee( "unreachable_roar_cooldown", 10000 );
    self function_786bb6aa1b76c7ee( "ranged_attack_dist", self.ranged_attack_dist );
    return anim.success;
}

// Namespace zombie_karkinos
// Params 0
// Checksum 0x9752cb8c, Offset: 0xf05
// Size: 0x83
function init_shield_locks()
{
    self.shield_locks = [];
    self.shield_locks[ "ranged_attack" ] = 0;
    self.shield_locks[ "melee_attack" ] = 0;
    self.shield_locks[ "stunned" ] = 0;
    self.shield_locks[ "brainrot" ] = 0;
    self.shield_locks[ "pain" ] = 0;
    self.shield_locks[ "claw_hammer" ] = 0;
    self.shield_locks[ "claw_hammer_leap" ] = 0;
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0xe8771264, Offset: 0xf90
// Size: 0x44
function post_init( params )
{
    metabone::set_metabone_active( "claw_shield", 1 );
    metabone::set_metabone_active( "claw_shield_weakpoint", 1 );
    zombie_utils::function_a8ce00e0448cb6f0( "run", "default", 1 );
    zombie_karkinos_audio::function_6002bb87417d96f4( params );
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0xa905d8ae, Offset: 0xfdc
// Size: 0x48
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    
    if ( self isscriptable() )
    {
        utility::function_32b24db3127bff40( "base", "base_on" );
    }
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0xf5113adf, Offset: 0x102c
// Size: 0x2a
function function_daa7e6bfcb0997c8( params )
{
    ai::set_blackboard_cooldown( "ranged_attack_cooldown", self.ranged_attack_cooldown );
    return anim.success;
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0xc8e1cab7, Offset: 0x105f
// Size: 0x34
function private function_7ae5a79a289eaf16()
{
    self endon( #"death" );
    
    while ( true )
    {
        utility::waittill_any_return( "ranged_attack_enemy_start", "ranged_attack_point_start" );
        disable_claw_shield( 0, "ranged_attack" );
    }
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0xf2d6e463, Offset: 0x109b
// Size: 0x2f
function private ranged_attack_end_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ranged_attack_end" );
        function_5d9dd6b1a00c39bd( "ranged_attack" );
    }
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0x1441915c, Offset: 0x10d2
// Size: 0x36
function private function_496409cd6892e5f5()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"pain_started" );
        set_shield_lock( "pain" );
        function_235e7e775f199e67();
    }
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0x79356ede, Offset: 0x1110
// Size: 0x2f
function private watch_pain_end()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"pain_ended" );
        function_5d9dd6b1a00c39bd( "pain" );
    }
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0xdbfa581b, Offset: 0x1147
// Size: 0xa0
function karkinos_damage_callback( params )
{
    var_b6db4b0a955e37ba = params.einflictor.weapon_name == "sat_sl_sargas_mp";
    
    if ( isdefined( params.metabonename ) && !metabone::is_metabone_destroyed( params.metabonename ) )
    {
        playfx( utility::getfx( "karkinos_weakpoint_impact_fx" ), params.vpoint );
    }
    
    if ( function_924c01fb14bbb9f5( 1 ) && ( var_b6db4b0a955e37ba || params.smeansofdeath != "MOD_IMPACT" ) )
    {
        enable_claw_shield();
    }
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0xd9692a47, Offset: 0x11ef
// Size: 0x90, Type: bool
function function_924c01fb14bbb9f5( var_84d67f41ea01f014 = 0 )
{
    return isdefined( self.enemy ) && !self.shield_is_on && ( var_84d67f41ea01f014 || self.health < self.maxhealth ) && self.var_d5ae8d9ff7d863e2 > 0 && metabone::get_metabone_state_name( "claw_shield_weakpoint" ) != "broken" && !zombie_stun::is_stunned() && !self._blackboard.var_ea5eb773cb969ee1;
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0x51e7989, Offset: 0x1288
// Size: 0x1b
function set_shield_lock( lock_type )
{
    self.shield_locks[ lock_type ] = 1;
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0xa09ff889, Offset: 0x12ab
// Size: 0x29
function function_5d9dd6b1a00c39bd( lock_type )
{
    self.shield_locks[ lock_type ] = 0;
    
    if ( isalive( self ) )
    {
        thread function_950a9baa2770ec29();
    }
}

// Namespace zombie_karkinos
// Params 0, eflags: 0xc
// Checksum 0xfdf918c1, Offset: 0x12dc
// Size: 0x47
function private function_950a9baa2770ec29()
{
    self notify( #"hash_f8707bfa0146fece" );
    self endon( #"hash_f8707bfa0146fece" );
    self endon( #"death" );
    wait 0.5;
    
    if ( !function_87f73945b55aaaa0() && function_924c01fb14bbb9f5() )
    {
        enable_claw_shield();
    }
}

// Namespace zombie_karkinos
// Params 0
// Checksum 0x10ce072c, Offset: 0x132b
// Size: 0xa7, Type: bool
function function_87f73945b55aaaa0()
{
    if ( !self.shield_locks )
    {
        return false;
    }
    
    var_1f33479b87ee6c78 = getarraykeys( self.shield_locks );
    
    foreach ( var_f272a6c30d226723 in var_1f33479b87ee6c78 )
    {
        if ( self.shield_locks[ var_f272a6c30d226723 ] == 1 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_karkinos
// Params 0
// Checksum 0x47c3aa01, Offset: 0x13db
// Size: 0xd6
function enable_claw_shield()
{
    if ( !function_87f73945b55aaaa0() )
    {
        metabone::set_metabone_state( "claw_shield_weakpoint", "on" );
        utility::function_32b24db3127bff40( "claw_shield", "on" );
        self.upaimlimit = -90;
        self.downaimlimit = 90;
        self.leftaimlimit = 90;
        self.rightaimlimit = -90;
        self.shield_is_on = 1;
        ai::set_blackboard_cooldown( "shield_min_uptime_cooldown", 2000 );
        zombie_utils::function_a8ce00e0448cb6f0( "walk", "karkinos_claw_shield_on", 31 );
        function_264ec315793f2e97();
        val::set( "karkinos_claw_shield_disable_pain", "pain", 0 );
        val::set( "karkinos_claw_shield_disable_pain", "special_pain", 0 );
        self.var_fd553a3e336c17f7 = gettime() + 500;
        callback::callback( #"hash_50f7ad9b02c9f421", {} );
    }
}

// Namespace zombie_karkinos
// Params 2
// Checksum 0xbda1572e, Offset: 0x14b9
// Size: 0x34
function disable_claw_shield( bdying = 0, lock_type )
{
    if ( lock_type )
    {
        set_shield_lock( lock_type );
    }
    
    function_235e7e775f199e67( bdying );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0xbc7a5ce, Offset: 0x14f5
// Size: 0xaf
function private function_235e7e775f199e67( bdying = 0 )
{
    if ( !utility::function_9f2c41c1dcc8c94( "claw_shield", "off" ) )
    {
        utility::function_32b24db3127bff40( "claw_shield", "off_sfx_vfx" );
    }
    
    if ( !bdying )
    {
        self.shield_is_on = 0;
    }
    
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "karkinos_claw_shield_on", 31 );
    self.upaimlimit = 0;
    self.downaimlimit = 0;
    self.leftaimlimit = 0;
    self.rightaimlimit = 0;
    self function_68f2f6fd8a4ffcae( 0, 4 );
    val::set( "karkinos_claw_shield_disable_pain", "pain", 1 );
    val::set( "karkinos_claw_shield_disable_pain", "special_pain", 1 );
}

// Namespace zombie_karkinos
// Params 1
// Checksum 0xe2492706, Offset: 0x15ac
// Size: 0x13
function on_move_speed_changed( params )
{
    function_264ec315793f2e97();
}

// Namespace zombie_karkinos
// Params 0
// Checksum 0xd0828613, Offset: 0x15c7
// Size: 0x7d
function function_264ec315793f2e97()
{
    if ( self.shield_is_on )
    {
        switch ( self._blackboard.movetype )
        {
            case #"hash_bdea5e7441323370":
                self function_68f2f6fd8a4ffcae( 0, 2 );
                break;
            case #"hash_9710f96c58beeaaa":
                self function_68f2f6fd8a4ffcae( 0, 3 );
                break;
            default:
                self function_68f2f6fd8a4ffcae( 0, 1 );
                break;
        }
        
        return;
    }
    
    self function_68f2f6fd8a4ffcae( 0, 4 );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0xf1393dca, Offset: 0x164c
// Size: 0x117
function private pre_play_death_fx( params )
{
    self.var_ee4496185273b139 = [];
    utility::function_32b24db3127bff40( "base", "base_off" );
    
    if ( utility::function_32b24db3127bff40( "armored_head", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_head" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_torso", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_torso" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_shoulder_left", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_shoulder_left" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_shoulder_right", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_shoulder_right" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_leg_right", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_leg_right" ] = "destroyed";
    }
    
    if ( utility::function_32b24db3127bff40( "armored_leg_left", "destroyed" ) )
    {
        self.var_ee4496185273b139[ "armored_leg_left" ] = "destroyed";
    }
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x5fdca2d2, Offset: 0x176b
// Size: 0x1bb
function private play_death_fx( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) )
    {
        if ( !self.var_af3927c5d7ace5c0 )
        {
            foreach ( part, state in self.var_ee4496185273b139 )
            {
                body setscriptablepartstate( part, state, 1 );
            }
            
            body thread function_58af8eb4056b25c3();
        }
        
        if ( utility::ent_flag( "dark_aether_bubble" ) )
        {
            body utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dissolve" );
            body thread dark_aether_bubble_timer();
        }
        
        if ( utility::ent_flag( "dissolve_purple" ) )
        {
            body utility::function_32b24db3127bff40( "reveal_death_purple", "reveal_death_purple" );
            body thread function_190a8f11ccb740ee();
        }
        
        if ( utility::ent_flag( "burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned", "burned_on" );
            body thread function_fc12a24729ef4e67();
        }
        else if ( utility::ent_flag( "napalm_burned" ) )
        {
            body utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
            body thread function_a67c6606a684a2dd();
        }
        else if ( utility::ent_flag( "locust_ww_burned" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww", "burned_dead" );
        }
        else if ( utility::ent_flag( "locust_ww_burned_pap" ) )
        {
            body utility::function_32b24db3127bff40( "burned_locust_ww_pap", "burned_dead" );
        }
        
        body utility::function_32b24db3127bff40( "base", "base_off" );
    }
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0xe0b4e245, Offset: 0x192e
// Size: 0x25
function private function_58af8eb4056b25c3()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "j_weapon_spin", "dead" );
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0x76055f6, Offset: 0x195b
// Size: 0x25
function private function_fc12a24729ef4e67()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0x7b72ba70, Offset: 0x1988
// Size: 0x25
function private function_a67c6606a684a2dd()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0x26cef888, Offset: 0x19b5
// Size: 0x25
function private dark_aether_bubble_timer()
{
    self endon( #"corpse_deleted" );
    wait 3;
    utility::function_32b24db3127bff40( "dark_aether_field_bubble", "dark_aether_field_bubble_off" );
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0x93855935, Offset: 0x19e2
// Size: 0x1a
function private function_190a8f11ccb740ee()
{
    self endon( #"corpse_deleted" );
    wait 3;
    self delete();
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0xdddfe2c, Offset: 0x1a04
// Size: 0x1d
function private function_ce4fe5b7b95b73f6( s_shock_effect )
{
    utility::function_32b24db3127bff40( "shocked", "shocked_on" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x9a4c599c, Offset: 0x1a29
// Size: 0x1d
function private function_f8cbef2738adcd18( s_shock_effect )
{
    utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x6a637ab0, Offset: 0x1a4e
// Size: 0x1d
function private function_91e753b101229a2( s_burn_effect )
{
    utility::function_32b24db3127bff40( "poisoned", "poisoned_on" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x572318b0, Offset: 0x1a73
// Size: 0x29
function private function_8c2a60ae74d8ce34( s_burn_effect )
{
    utility::ent_flag_clear( "poisoned" );
    utility::function_7c10ea82c1e305b8( "poisoned", "poisoned_off" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x9111a973, Offset: 0x1aa4
// Size: 0x1d
function private function_9a92f215ba32b261( s_burn_effect )
{
    utility::function_32b24db3127bff40( "wraith_burned", "wraith_burned_on" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x2dbef6d8, Offset: 0x1ac9
// Size: 0x29
function private function_c9afe0de75edf987( s_burn_effect )
{
    utility::ent_flag_clear( "wraith_burned" );
    utility::function_7c10ea82c1e305b8( "wraith_burned", "wraith_burned_off" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0xdc79f589, Offset: 0x1afa
// Size: 0x3f
function private function_2080c9a8a657bc17( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_on" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0xcf8fde87, Offset: 0x1b41
// Size: 0x3f
function private function_ef6cb4c9a207699d( s_burn_effect )
{
    var_7dddc60e0205506b = s_burn_effect.var_7dddc60e0205506b ?? "";
    utility::function_32b24db3127bff40( "burned" + var_7dddc60e0205506b, "burned_off" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x25af5532, Offset: 0x1b88
// Size: 0x1d
function private function_2b8879e19ccaeef3( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x4346f892, Offset: 0x1bad
// Size: 0x1d
function private function_aa4be0297708a8fa( s_burn_effect )
{
    utility::function_32b24db3127bff40( "napalm_burned", "napalm_burned_on_thermite" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x5c915254, Offset: 0x1bd2
// Size: 0x1d
function private function_8b959aabb4069e99( s_burn_effect )
{
    utility::function_7c10ea82c1e305b8( "napalm_burned", "napalm_burned_off" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x58500591, Offset: 0x1bf7
// Size: 0x59
function private on_zombie_turned( var_75e7c1be4fd022be )
{
    utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_cebcd1de9386a268 )
    {
        thread zombie_karkinos_enraged::karkinos_enrage( 0, 1, "end_brainrot_charge" );
    }
    
    disable_claw_shield( 0, "brainrot" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x37062116, Offset: 0x1c58
// Size: 0x24
function private function_16751232a9e10970( params )
{
    self notify( #"end_brainrot_charge" );
    function_5d9dd6b1a00c39bd( "brainrot" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0xc
// Checksum 0x5cad4b76, Offset: 0x1c84
// Size: 0x6b
function private function_803592cfbf246266( params )
{
    self notify( #"hash_b60085bb5eb1ee01" );
    self endon( #"hash_b60085bb5eb1ee01" );
    self endon( #"death" );
    
    if ( self.shield_is_on )
    {
        disable_claw_shield( 0, "stunned" );
    }
    
    wait params.duration + self.var_5c0eda7cf6a5561;
    function_5d9dd6b1a00c39bd( "stunned" );
}

// Namespace zombie_karkinos
// Params 1, eflags: 0xc
// Checksum 0x4f17f507, Offset: 0x1cf7
// Size: 0x124
function private on_spawn_animscripted( params )
{
    self notify( #"hash_b88966e302162f47" );
    self endon( #"hash_b88966e302162f47" );
    callback::callback( "karkinos_spawned" );
    self endon( #"death" );
    
    if ( isdefined( self.spawn_vfx ) )
    {
        self.spawn_vfx freescriptable();
        self.spawn_vfx = undefined;
    }
    
    var_64d690f37c925a83 = 0.75;
    var_5b4eb9d63ae97db = 0.5;
    var_7a91a06fb8802f47 = 2;
    self hide();
    asm::freeze_ai();
    waitframe();
    self.spawn_vfx = spawnscriptable( "scriptable_zombie_karkinos_spawn", self.origin );
    self.spawn_vfx setscriptablepartstate( "karkinos_spawn_vfx", "spawn_loop" );
    wait var_5b4eb9d63ae97db;
    self show();
    asm::unfreeze_ai();
    wait var_64d690f37c925a83;
    
    if ( isdefined( self.spawn_vfx ) )
    {
        self.spawn_vfx setscriptablepartstate( "karkinos_spawn_vfx", "deactivate" );
    }
    
    wait var_7a91a06fb8802f47;
    
    if ( isdefined( self.spawn_vfx ) )
    {
        self.spawn_vfx freescriptable();
    }
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0xcf07d02c, Offset: 0x1e23
// Size: 0x34
function private function_747b5161631cb7a2( params )
{
    self.upaimlimit = 0;
    self.downaimlimit = 0;
    self.leftaimlimit = 0;
    self.rightaimlimit = 0;
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x6c80077e, Offset: 0x1e5f
// Size: 0x38
function private function_a3233947db2aea4d( params )
{
    self.upaimlimit = -90;
    self.downaimlimit = 90;
    self.leftaimlimit = 90;
    self.rightaimlimit = -90;
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x6dbace58, Offset: 0x1e9f
// Size: 0xce
function private show_trident( showtrident )
{
    tag = self.var_d6894f01a36b4ff3.projectileattachtag;
    
    if ( !isdefined( tag ) )
    {
        return;
    }
    
    var_d75eaefe66066143 = "c_sat_zmb_karkinos_trident_body";
    shouldattach = getdvarint( @"hash_2375ad2d93334e82", 1 ) == 1;
    
    if ( showtrident && self.trident_hidden )
    {
        if ( shouldattach )
        {
            self attach( var_d75eaefe66066143, tag );
        }
        else
        {
            self showpart( tag );
        }
        
        self.trident_hidden = 0;
        return;
    }
    
    if ( !showtrident && !self.trident_hidden )
    {
        if ( shouldattach )
        {
            self detach( var_d75eaefe66066143, tag );
        }
        else
        {
            self hidepart( tag );
        }
        
        self.trident_hidden = 1;
    }
}

// Namespace zombie_karkinos
// Params 0, eflags: 0x4
// Checksum 0x1e80e665, Offset: 0x1f75
// Size: 0x59
function private function_146bb2802691c6f()
{
    self endon( #"death" );
    self.trident_hidden = 1;
    show_trident( 1 );
    
    while ( true )
    {
        self waittill( #"launch_projectile" );
        show_trident( 0 );
        utility::waittill_any( "terminate_ranged_attack", "trident_show" );
        show_trident( 1 );
    }
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0x73edfa39, Offset: 0x1fd6
// Size: 0x11e
function private function_50909962e5019afa( params )
{
    if ( isdefined( self.spawn_vfx ) )
    {
        self.spawn_vfx freescriptable();
    }
    
    disable_claw_shield( 1 );
    
    if ( isdefined( self.var_d6894f01a36b4ff3.projectileattachtag ) )
    {
        tag = self.var_d6894f01a36b4ff3.projectileattachtag;
        
        if ( !self.trident_hidden )
        {
            if ( !getdvarint( @"hash_cc8e90c830764ab8", 0 ) )
            {
                trident = spawn( "script_model", self gettagorigin( tag ) );
                
                if ( isdefined( trident ) )
                {
                    model_name = self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6[ 0 ].modelname;
                    trident.angles = self gettagangles( tag );
                    trident setmodel( model_name );
                    trident physicslaunchserver( trident.origin, anglestoforward( self.angles ) * 50 );
                    trident thread function_582234767f1d2f80( 10 );
                }
            }
            
            show_trident( 0 );
        }
    }
}

// Namespace zombie_karkinos
// Params 1, eflags: 0x4
// Checksum 0xc039b542, Offset: 0x20fc
// Size: 0x84
function private function_582234767f1d2f80( delay )
{
    self endon( #"death" );
    wait delay;
    
    if ( isdefined( self ) )
    {
        fx_origin = self gettagorigin( "tag_fx" );
        var_577a467b53726b45 = self gettagangles( "tag_fx" );
        fx_forward = anglestoforward( var_577a467b53726b45 );
        fx_up = anglestoup( var_577a467b53726b45 );
        playfx( utility::getfx( "karkinos_trident_dissolve_fx" ), fx_origin, fx_forward, fx_up );
        self delete();
    }
}

/#

    // Namespace zombie_karkinos
    // Params 0, eflags: 0x4
    // Checksum 0xfa105711, Offset: 0x2188
    // Size: 0x2e, Type: dev
    function private init_karkinos_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x59>", &function_cacb4830907ed9bc );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_karkinos
    // Params 0, eflags: 0x4
    // Checksum 0x314dfe99, Offset: 0x21be
    // Size: 0x1a, Type: dev
    function private function_cacb4830907ed9bc()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x74>", @"hash_848d7b1aabe8fa00" );
    }

#/
