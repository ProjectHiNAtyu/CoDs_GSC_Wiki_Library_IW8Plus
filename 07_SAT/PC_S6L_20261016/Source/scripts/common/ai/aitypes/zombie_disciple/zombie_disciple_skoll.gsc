// scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_skoll.gsc  (hash_5c0f659fa0364524.gscc) (size: 9526 Bytes / 0x2536 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef8f365e (4019140190)
// size ...... 9526 (0x2536)
// includes .. 19  (offset: 0x22ba)
// strings ... 20  (offset: 0x2352)
// dev strs .. 13  (offset: 0x2482)
// exports ... 24  (offset: 0x138e)
// cseg ...... 0x1c9 + 0x11c5 (0x138e)
// imports ... 98  (offset: 0x174e)
// animtree1 . 0   (offset: 0x2536)
// animtree2 . 0   (offset: 0x2536)
#using script_16ea1b94f0f381b3;
#using script_4fa22bc28608e9bd;
#using script_63647a1499c0ba49;
#using script_7729cb692e91498a;
#using script_ac32c5a74321662;
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_injection;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_passive_spawn;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_skoll_medal;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_disciple_skoll;

// Namespace zombie_disciple_skoll
// Params 2
// Checksum 0x444a450a, Offset: 0x1e7
// Size: 0x43
function precache( classname, aitypescriptbundle )
{
    zombie_disciple::precache( classname, aitypescriptbundle );
    zombie_disciple_passive_spawn::function_8beffe11995644ce( aitypescriptbundle );
    namespace_f2cf5f122ca519c4::function_d4599956e62b3c9a( aitypescriptbundle );
    namespace_a081b0c1b6e9c2c7::function_d57a6a86c7458019( aitypescriptbundle );
    zombie_disciple_injection::function_a4223c013b08ac4a( aitypescriptbundle );
}

// Namespace zombie_disciple_skoll
// Params 1, eflags: 0x4
// Checksum 0xe6ff8061, Offset: 0x232
// Size: 0x44
function private function_344167e2ca0b83f7( params )
{
    zombie_disciple_injection::function_3a8c36860e641e85();
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_a5e8e706e38309c9 );
    zombie_disciple_skoll_medal::function_17a7f10d4c86dd8f();
    
    /#
        init_disciple_devgui();
    #/
}

// Namespace zombie_disciple_skoll
// Params 1
// Checksum 0x87e175d4, Offset: 0x27e
// Size: 0x2c9
function function_a33de56159496f44( taskid )
{
    callback::add( "on_first_ai_init", &function_344167e2ca0b83f7 );
    level.var_9ff6d5cbb5b1becd = [];
    
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_88d0d97a1ef0b8d7 )
    {
        self.var_845a0792dc9e9059 = "defensive";
    }
    
    self.var_a96b67a80f895e54 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5802874d310669c3;
    self.var_38f3a2d30cddab2a = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_94259c3c1d6121b8 ) );
    self.var_9e9b24abbbbfac76 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_a185808e9f04d7e2;
    self.var_671d348f225c33c = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_2449ca1c5c7d9393;
    self.var_b5264bb792a5caf5 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_428f63e6a985000f;
    self.var_f088969d069758ac = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e3318d8c530a3346;
    self.var_90f1944e4d0eedc = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_38e262458e926366;
    self.var_f50b5cb59a26a35e = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_bb446834b4950845;
    self.on_death_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.ondeathradius;
    self.var_d9e5a69986ecfae2 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_48e8d6834a772847;
    self.var_32c0abcf360818e8 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_6d882b80226f8fb5;
    self.var_3a993d9a6fae6fd0 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_c8f5a550dae755ab;
    self.var_6fb6199a91f720a2 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8fc37b22b001e50b;
    self.var_62d9295943459390 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e99dff9f1fdbc4c7;
    self.var_a45189ff1e34f63c = 0;
    zombie_disciple_passive_spawn::function_5012296bfc157445();
    zombie_disciple_injection::init_zombie_disciple_injection();
    zombie_disciple::register_movement_state( 6, &function_dfb71d2a74f557eb, &function_af13c97774b88b6e, &function_cb60b2ce0c1e03bf );
    zombie_disciple::register_movement_state( 7, &function_7d7da2fe949ae7da, &function_40b8483993d307d, &function_5eee5324fe5365ec );
    prepare_spawn_reveal();
    thread spawn_reveal();
}

// Namespace zombie_disciple_skoll
// Params 0, eflags: 0x4
// Checksum 0x4fc1500d, Offset: 0x54f
// Size: 0x13
function private prepare_spawn_reveal()
{
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_disciple_skoll
// Params 1, eflags: 0x4
// Checksum 0xdd92ffaf, Offset: 0x56a
// Size: 0x89
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
        utility::function_32b24db3127bff40( "spawn_reveal", "spawn_reveal_audio_only" );
    }
    
    wait 2;
    self function_f2df0257c63f229( "in_spawn_reveal" );
    utility::function_32b24db3127bff40( "spawn_reveal", "off" );
}

// Namespace zombie_disciple_skoll
// Params 2
// Checksum 0x7ea68a65, Offset: 0x5fb
// Size: 0x19a
function function_e48e83e6e5abd9bc( taskid, params )
{
    if ( self.b_in_spawn_closet )
    {
        return anim.failure;
    }
    
    if ( !utility::ent_flag( "ai_init_complete" ) )
    {
        return anim.failure;
    }
    
    if ( self.force_scream_attack )
    {
        return anim.failure;
    }
    
    if ( isdefined( self getaiblackboarddynamic( "passive_spawn_cooldown" ) ) && self getaiblackboarddynamic( "passive_spawn_cooldown" ) > gettime() )
    {
        return anim.failure;
    }
    
    callback::callback( "disciple_check_round_spawn_limits_requested" );
    limit_override = getdvarint( @"hash_4b493d00882d3469", -1 );
    
    if ( limit_override > -1 && self.var_7b40098f6851862a.size >= limit_override )
    {
        return anim.failure;
    }
    
    if ( self.var_7b40098f6851862a.size >= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7cf1769bc152b02 )
    {
        return anim.failure;
    }
    
    if ( namespace_9d8e359c3b1041e5::getfreeaicount_sharedfunc() < 1 )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.var_a45189ff1e34f63c ) && !self.var_a45189ff1e34f63c )
    {
        return anim.failure;
    }
    
    self.var_7b40098f6851862a = function_46f9072493651dc9( self.var_7b40098f6851862a );
    
    if ( self.var_7b40098f6851862a.size >= self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5c33d1ac4b18a9f2 )
    {
        return anim.failure;
    }
    
    thread zombie_disciple_passive_spawn::function_e5b935ab2d04526c();
    return anim.success;
}

// Namespace zombie_disciple_skoll
// Params 2
// Checksum 0x728febcb, Offset: 0x79e
// Size: 0x13a
function function_53d2826cde36ebfc( taskid, params )
{
    if ( self.b_in_spawn_closet )
    {
        return anim.failure;
    }
    
    if ( !utility::ent_flag( "ai_init_complete" ) )
    {
        return anim.failure;
    }
    
    if ( self.force_scream_attack )
    {
        return anim.failure;
    }
    
    if ( self._blackboard.var_d4512652c6056e7e != 7 && self._blackboard.var_d4512652c6056e7e != 3 )
    {
        return anim.failure;
    }
    
    if ( gettime() < self.var_782ca4f832080896 )
    {
        return anim.failure;
    }
    
    self.var_91ad9fe5fbf8a649 = namespace_f2cf5f122ca519c4::function_b8c0ff578e3412();
    callback::callback( "disciple_check_round_spawn_limits_requested" );
    
    if ( !namespace_f2cf5f122ca519c4::can_force_evolution() )
    {
        self.var_91ad9fe5fbf8a649 = undefined;
        return anim.failure;
    }
    
    thread function_52c4a7fa8f71e5cc();
    self.var_91ad9fe5fbf8a649.var_a983686954b241f5 = 1;
    namespace_f2cf5f122ca519c4::function_1f91b659661972d5();
    self.var_91ad9fe5fbf8a649.var_287ea4c2debf2264 = gettime() + self.force_evolution_cooldown;
    return anim.success;
}

// Namespace zombie_disciple_skoll
// Params 0
// Checksum 0xa71a63cf, Offset: 0x8e1
// Size: 0x51
function function_52c4a7fa8f71e5cc()
{
    self notify( #"hash_f609ee7c56f342ac" );
    self endon( #"hash_f609ee7c56f342ac" );
    self endon( #"death" );
    self endon( #"hash_bc5cf67a08651478" );
    self.var_91ad9fe5fbf8a649 waittill( #"death" );
    self.var_91ad9fe5fbf8a649 = undefined;
}

// Namespace zombie_disciple_skoll
// Params 2
// Checksum 0x57559559, Offset: 0x93a
// Size: 0x33
function function_68612592382857bd( taskid, params )
{
    return namespace_a081b0c1b6e9c2c7::can_scream_attack() ? anim.success : anim.failure;
}

// Namespace zombie_disciple_skoll
// Params 1
// Checksum 0x6c012471, Offset: 0x976
// Size: 0x203
function function_a5e8e706e38309c9( params )
{
    level.var_9ff6d5cbb5b1becd[ self getentitynumber() ] = undefined;
    
    if ( !isdefined( level.disciple_on_death_effect_throttle ) )
    {
        level.disciple_on_death_effect_throttle = throttle::throttle_initialize( "disciple_on_death_effect" );
    }
    
    round_number = zombie_utils::get_zombie_round_difficulty();
    base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_number );
    affected_ai = arraycombine( self.var_1629dcb960803248, self.var_7b40098f6851862a, self.injected_zombies, self.var_e5e12423824e90f2 );
    affected_ai = function_5713d46873b29625( affected_ai );
    affected_ai = utility::array_removedead_or_dying( affected_ai );
    self.allowfriendlyfire = 1;
    
    foreach ( ai in affected_ai )
    {
        if ( !isalive( ai ) )
        {
            if ( ai.disciple_parent == self )
            {
                ai.disciple_parent = undefined;
            }
            
            continue;
        }
        
        if ( ai.aicategory == "special" )
        {
            ai thread function_ac39de82062966b0( self.origin, self.var_3a993d9a6fae6fd0, base_zombie_max_health, self.var_d9e5a69986ecfae2 );
            continue;
        }
        
        if ( ai.aicategory == "elite" || ai.aicategory == "hvt" )
        {
            ai thread function_848b4e91298402c( self.origin, self.var_62d9295943459390, base_zombie_max_health, self.var_6fb6199a91f720a2 );
            continue;
        }
        
        ai thread function_1f6bf08130e28192( self.origin, self.var_32c0abcf360818e8, base_zombie_max_health, self.var_4151d052dea500db );
    }
    
    self notify( #"hash_225e213844501190" );
}

// Namespace zombie_disciple_skoll
// Params 4
// Checksum 0xfde0fdf7, Offset: 0xb81
// Size: 0x99
function function_848b4e91298402c( dmg_origin, var_772501ce9a0c24da, base_zombie_max_health, var_8bd444d2097f426c )
{
    self endon( #"death" );
    wait 2.5;
    throttle::throttle_wait_in_queue( level.disciple_on_death_effect_throttle, self );
    zombie_stun::stun_ai( var_772501ce9a0c24da );
    damage = base_zombie_max_health * var_8bd444d2097f426c;
    self dodamage( damage, dmg_origin, undefined, undefined, "MOD_PROJECTILE_SPLASH", undefined );
    utility::function_32b24db3127bff40( "injected", "injected_off" );
    self.disciple_parent = undefined;
    self.emergence_spawning_host_data = undefined;
}

// Namespace zombie_disciple_skoll
// Params 4
// Checksum 0x9da53c58, Offset: 0xc22
// Size: 0x99
function function_ac39de82062966b0( dmg_origin, var_772501ce9a0c24da, base_zombie_max_health, var_8bd444d2097f426c )
{
    self endon( #"death" );
    wait 2.5;
    throttle::throttle_wait_in_queue( level.disciple_on_death_effect_throttle, self );
    zombie_stun::stun_ai( var_772501ce9a0c24da );
    damage = base_zombie_max_health * var_8bd444d2097f426c;
    self dodamage( damage, dmg_origin, undefined, undefined, "MOD_PROJECTILE_SPLASH", undefined );
    utility::function_32b24db3127bff40( "injected", "injected_off" );
    self.disciple_parent = undefined;
    self.emergence_spawning_host_data = undefined;
}

// Namespace zombie_disciple_skoll
// Params 4
// Checksum 0x588d9a9b, Offset: 0xcc3
// Size: 0xeb
function function_1f6bf08130e28192( dmg_origin, var_772501ce9a0c24da, base_zombie_max_health, var_8bd444d2097f426c )
{
    self endon( #"death" );
    wait 2.5;
    throttle::throttle_wait_in_queue( level.disciple_on_death_effect_throttle, self );
    zombie_stun::stun_ai( var_772501ce9a0c24da );
    damage = self.maxhealth * var_8bd444d2097f426c;
    
    if ( issubstr( self.subclass, "zombie_base" ) && self.health <= damage )
    {
        namespace_b76ff2659823e89d::function_6c318bca7bb326e7( 1 );
    }
    
    self dodamage( damage, dmg_origin, undefined, undefined, "MOD_PROJECTILE_SPLASH", undefined );
    zombie_emergence_spawning::function_80623a2279a4d888();
    
    if ( utility::ent_flag( "disciple_injected" ) )
    {
        zombie_disciple_injection::function_f36332de3f55dc5f();
    }
    
    utility::function_32b24db3127bff40( "injected", "injected_off" );
    self.disciple_parent = undefined;
    self.emergence_spawning_host_data = undefined;
}

// Namespace zombie_disciple_skoll
// Params 0
// Checksum 0xf89a021d, Offset: 0xdb6
// Size: 0x86
function function_dfb71d2a74f557eb()
{
    /#
        function_b1a8e724ee4662e0();
    #/
    
    groups = zombie_disciple::function_f4432a6d8e12d35f();
    self.var_b4c7fcee0d3f489a = zombie_disciple::function_be19bf0161341b13( groups );
    level.var_9ff6d5cbb5b1becd[ self getentitynumber() ] = self.var_b4c7fcee0d3f489a;
    
    if ( isdefined( self.var_b4c7fcee0d3f489a.center_ent ) )
    {
        asm_bb::bb_requestmovetype( "run" );
        self function_f2fdf8ef124744e8( 2, self.var_b4c7fcee0d3f489a.center_ent );
    }
}

// Namespace zombie_disciple_skoll
// Params 0
// Checksum 0xcdc5291f, Offset: 0xe44
// Size: 0x1e3
function function_af13c97774b88b6e()
{
    if ( isdefined( self.var_b4c7fcee0d3f489a ) )
    {
        namespace_7143065cf1b062e3::clear_float_move();
        
        if ( zombie_disciple::function_202699de918c3a3b() )
        {
            groups = zombie_disciple::function_f4432a6d8e12d35f();
            self.var_b4c7fcee0d3f489a = zombie_disciple::function_be19bf0161341b13( groups );
            level.var_9ff6d5cbb5b1becd[ self getentitynumber() ] = self.var_b4c7fcee0d3f489a;
            
            if ( isdefined( self.var_b4c7fcee0d3f489a.center_ent ) )
            {
                self function_f2fdf8ef124744e8( 2, self.var_b4c7fcee0d3f489a.center_ent );
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_ea7ea00e56dec3b9", 0 ) )
        {
            utility::draw_circle( self.origin, self.var_a96b67a80f895e54, ( 0, 0, 1 ), 1 );
            utility::draw_circle( self.var_b4c7fcee0d3f489a.origin, self.var_b4c7fcee0d3f489a.radius, ( 0, 1, 0 ), 1 );
            
            if ( isdefined( self.var_e463f576fc860b07 ) )
            {
                utility::draw_circle( self.var_e463f576fc860b07, self.var_6b5c9b282f7ef791, ( 1, 0, 1 ), 1 );
                print3d( self.var_e463f576fc860b07, "<dev string:x24>", ( 1, 0, 0 ), 1, 1, 120, 1 );
            }
        }
    #/
    
    var_59d2648db909ddd2 = namespace_d4e7a14ee55bd048::function_766769d2750f286f();
    
    if ( isdefined( var_59d2648db909ddd2 ) )
    {
        self.var_59d2648db909ddd2 = var_59d2648db909ddd2;
        return 1;
    }
    
    if ( isdefined( self.var_91ad9fe5fbf8a649 ) )
    {
        return 7;
    }
    
    if ( zombie_disciple::function_ae8129851e53d2ef() )
    {
        return 2;
    }
    
    if ( zombie_disciple::function_384296a688cfa34a( self.var_b4c7fcee0d3f489a, self.sweep_start_dist_sq * 0.25 ) )
    {
        return 5;
    }
    
    if ( zombie_disciple::function_55924d325abaf8c5() )
    {
        return 4;
    }
    
    return 0;
}

// Namespace zombie_disciple_skoll
// Params 0
// Checksum 0xa4cb2a50, Offset: 0x102f
// Size: 0x14
function function_cb60b2ce0c1e03bf()
{
    self clearbtgoal( 2 );
    self.var_b4c7fcee0d3f489a = undefined;
}

// Namespace zombie_disciple_skoll
// Params 0
// Checksum 0xda4c8699, Offset: 0x104b
// Size: 0x13
function function_7d7da2fe949ae7da()
{
    self function_f2fdf8ef124744e8( 2, self.var_91ad9fe5fbf8a649 );
}

// Namespace zombie_disciple_skoll
// Params 0
// Checksum 0x119b1d34, Offset: 0x1066
// Size: 0x9f
function function_40b8483993d307d()
{
    namespace_7143065cf1b062e3::clear_float_move();
    
    if ( !isalive( self.var_91ad9fe5fbf8a649 ) || zombie_disciple::function_7e89c2b6e30b1cf3( self.var_91ad9fe5fbf8a649.origin ) )
    {
        return zombie_disciple::get_default_movement_state();
    }
    
    sweep_target_ent = spawnstruct();
    sweep_target_ent.origin = vectornormalize( self.var_91ad9fe5fbf8a649.origin - self.origin ) * 400;
    
    if ( zombie_disciple::function_384296a688cfa34a( sweep_target_ent, self.sweep_start_dist_sq * 0.25 ) )
    {
        return 5;
    }
}

// Namespace zombie_disciple_skoll
// Params 0
// Checksum 0x8da7aa1b, Offset: 0x110d
// Size: 0x14
function function_5eee5324fe5365ec()
{
    self clearbtgoal( 2 );
    self.var_245cab163736d1b8 = undefined;
}

/#

    // Namespace zombie_disciple_skoll
    // Params 0
    // Checksum 0x6e808296, Offset: 0x1129
    // Size: 0x83, Type: dev
    function init_disciple_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x32>" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x4c>", @"hash_91845ec9bcb2582d" );
        devgui::add_devgui_func( "<dev string:x60>", "<dev string:x76>", &function_ea90a13538922afa );
        devgui::add_devgui_func( "<dev string:x7e>", "<dev string:x95>", &function_2e8bd1df33064119 );
        devgui::function_eaac4ba4b3caf621( "<dev string:x9e>", @"hash_69344bf02dda50a4" );
        devgui::function_eaac4ba4b3caf621( "<dev string:xbe>", @"hash_bc392c231114be3e" );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_disciple_skoll
    // Params 0, eflags: 0x4
    // Checksum 0x86693ac2, Offset: 0x11b4
    // Size: 0x3a, Type: dev
    function private function_b1a8e724ee4662e0()
    {
        dvar_val = getdvarint( @"hash_91845ec9bcb2582d", -1 );
        
        if ( dvar_val > 0 )
        {
            namespace_a081b0c1b6e9c2c7::force_scream_attack( dvar_val );
            return;
        }
        
        namespace_a081b0c1b6e9c2c7::function_8eae05addfac334a();
    }

    // Namespace zombie_disciple_skoll
    // Params 0, eflags: 0x4
    // Checksum 0x12623c00, Offset: 0x11f6
    // Size: 0xc8, Type: dev
    function private function_ea90a13538922afa()
    {
        player = level.player;
        eye_pos = player geteye();
        end_pos = player geteye() + anglestoforward( player.angles ) * 1000;
        trace_contents = trace::create_character_contents();
        trace = trace::ray_trace( eye_pos, end_pos, player, trace_contents );
        
        if ( !isdefined( trace[ "<dev string:xdf>" ] ) )
        {
            iprintlnbold( "<dev string:xe6>" );
            return;
        }
        
        hitent = trace[ "<dev string:xdf>" ];
        
        if ( !issubstr( hitent.subclass, "<dev string:xff>" ) )
        {
            iprintlnbold( "<dev string:x10f>" );
            return;
        }
        
        hitent zombie_disciple_injection::function_ea90a13538922afa();
    }

    // Namespace zombie_disciple_skoll
    // Params 0, eflags: 0x4
    // Checksum 0x12623c00, Offset: 0x12c6
    // Size: 0xc8, Type: dev
    function private function_2e8bd1df33064119()
    {
        player = level.player;
        eye_pos = player geteye();
        end_pos = player geteye() + anglestoforward( player.angles ) * 1000;
        trace_contents = trace::create_character_contents();
        trace = trace::ray_trace( eye_pos, end_pos, player, trace_contents );
        
        if ( !isdefined( trace[ "<dev string:xdf>" ] ) )
        {
            iprintlnbold( "<dev string:xe6>" );
            return;
        }
        
        hitent = trace[ "<dev string:xdf>" ];
        
        if ( !issubstr( hitent.subclass, "<dev string:xff>" ) )
        {
            iprintlnbold( "<dev string:x10f>" );
            return;
        }
        
        hitent zombie_disciple_injection::function_2e8bd1df33064119();
    }

#/
