// scripts\common\ai\aitypes\zombie_phobos\zombie_phobos.gsc  (hash_178546be025df90c.gscc) (size: 11162 Bytes / 0x2b9a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8b2af59c (2334848412)
// size ...... 11162 (0x2b9a)
// includes .. 27  (offset: 0x2822)
// strings ... 50  (offset: 0x28fa)
// dev strs .. 0   (offset: 0x2b9a)
// exports ... 16  (offset: 0x1706)
// cseg ...... 0x322 + 0x13e4 (0x1706)
// imports ... 127 (offset: 0x1986)
// animtree1 . 0   (offset: 0x2b9a)
// animtree2 . 0   (offset: 0x2b9a)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_audio;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_collision;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_enraged;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_head;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_jumpout;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_leap;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_melee;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_metabones;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_move;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_puke;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_roar;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_spit;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_spithose;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_tail_slam;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\visibility_mode;
#using scripts\mp\agents\nearby_player_scaling;

#namespace zombie_phobos;

// Namespace zombie_phobos
// Params 2
// Checksum 0x25cc5bee, Offset: 0x340
// Size: 0x8a
function precache( classname, aitypescriptbundle )
{
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        zombie_phobos_tail_slam::function_f07df5f77bb2a165( var_4b4d72d84afd1ebd );
        zombie_phobos_leap::function_c7ce84b91493e6bf( var_4b4d72d84afd1ebd );
        zombie_phobos_puke::function_f252f41a4c0efa0a( var_4b4d72d84afd1ebd );
        zombie_phobos_spit::function_e2f06c2d94b763ef( var_4b4d72d84afd1ebd );
        zombie_phobos_collision::function_e0fd57a28c8b99cb( var_4b4d72d84afd1ebd );
        utility::add_fx( "attached_zombie_impact_vfx", var_4b4d72d84afd1ebd.var_4c309f7c55b74272 );
        utility::add_fx( "oob_incoming_impact_vfx", var_4b4d72d84afd1ebd.var_cd1bc3f20ef66a0c );
    }
}

// Namespace zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0xdeeb55ae, Offset: 0x3d2
// Size: 0xc0
function private function_ef1baed3c21a54e0( params )
{
    zombie_boss_healthbar::function_f50a10314e72caa1();
    zombie_phobos_tail_slam::function_9617329bae4ffaf4();
    zombie_phobos_leap::function_7190f4797876d15c();
    zombie_phobos_puke::function_b688e1b873f45f93();
    zombie_phobos_spit::function_54867ff0ab30fc90();
    zombie_phobos_spithose::function_115f39adad17c83b();
    zombie_phobos_melee::function_929bce1856d7c942();
    zombie_phobos_roar::function_854c976a13f0454a();
    zombie_phobos_jumpout::function_6730a542a916ec66();
    zombie_phobos_enraged::function_2487cd4ddfbb9cdc();
    zombie_phobos_collision::function_7eeb3762f93011e();
    zombie_phobos_audio::function_41f16ac1f5cce9f4();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_45e6e16469c10a7f );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &on_phobos_killed );
}

// Namespace zombie_phobos
// Params 1
// Checksum 0xf17a16ae, Offset: 0x49a
// Size: 0x147
function function_c2c68cdfecacff49( taskid )
{
    assert( isdefined( self.zombieaisetting ) );
    zombie_init::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_ef1baed3c21a54e0 );
    self.script_noragdoll = 1;
    self.allowfriendlyfire = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.var_13518fb33ec73cc = 30;
    self enabletraversals( 0 );
    self pushplayer( 1 );
    self function_66dc8b6ae969f66d( 1 );
    val::set( "zombie_phobos_init", "high_net_lod", 1 );
    self function_43a971093c992365( 1 );
    thread inithealthbar();
    zombie_phobos_tail_slam::init_phobos_tail_slam();
    zombie_phobos_leap::init_zombie_phobos_leap();
    zombie_phobos_puke::init_phobos_puke();
    zombie_phobos_spit::init_zombie_phobos_spit();
    zombie_phobos_spithose::init_zombie_phobos_spithose();
    zombie_phobos_melee::init_zombie_phobos_melee();
    zombie_phobos_metabones::init_zombie_phobos_metabones();
    zombie_phobos_roar::init_zombie_phobos_roar();
    zombie_phobos_move::init_zombie_phobos_move();
    zombie_phobos_head::init_zombie_phobos_head();
    zombie_phobos_jumpout::init_zombie_phobos_jumpout();
    zombie_phobos_enraged::init_zombie_phobos_enraged();
    zombie_phobos_collision::init_zombie_phobos_collision();
    utility::registersharedfunc( #"zombie_phobos", #"hash_9fb97592f200801e", &function_dc169a4b0c87f34d );
    zombie_utils::function_dfae6a5bd222c586( &function_724896e630cbef00 );
    nearby_player_scaling::init_nearby_player_scaling();
    init_difficulty_changes();
    thread initscriptable();
    return anim.success;
}

// Namespace zombie_phobos
// Params 0, eflags: 0x4
// Checksum 0x2d01b021, Offset: 0x5ea
// Size: 0xaf
function private inithealthbar()
{
    level endon( #"game_ended" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 3 );
    zombie_boss_healthbar::init_zombie_boss_healthbar();
    
    if ( !level.var_15ce4166f92c5163 )
    {
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_phobos_healthbar", self );
        }
    }
}

// Namespace zombie_phobos
// Params 0, eflags: 0x4
// Checksum 0x4fb0f545, Offset: 0x6a1
// Size: 0x48
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_32b24db3127bff40( "base", "base_on" );
    zombie_phobos_metabones::function_b6fd756e481363de( self );
}

// Namespace zombie_phobos
// Params 0, eflags: 0x4
// Checksum 0xcb2ff28f, Offset: 0x6f1
// Size: 0xff
function private init_difficulty_changes()
{
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_569f82d63bbcabcd", 0 ) )
    {
        ai::set_ai_max_health( int( self.maxhealth * 0.3 ) );
        self.health = self.maxhealth;
        self.attached_zombie_health_scalar = 0.3;
        self.var_fb527efaf58c60f3 = 1;
        return;
    }
    
    self.attached_zombie_health_scalar = 1;
    round_difficulty = zombie_utils::get_zombie_round_difficulty();
    self.bleedout_damage_multiplier = 0.7;
    
    if ( round_difficulty >= 50 && round_difficulty < 100 )
    {
        self.toxic_gas_damage_multiplier = 1.5;
        self.enraged_health_percent = 0.7;
        self.bleedout_damage_multiplier = 0.5;
        return;
    }
    
    if ( round_difficulty >= 100 )
    {
        self.toxic_gas_damage_multiplier = 2;
        self.enraged_health_percent = 0.7;
        self.bleedout_damage_multiplier = 0.1;
    }
}

// Namespace zombie_phobos
// Params 2, eflags: 0x4
// Checksum 0x9f067534, Offset: 0x7f8
// Size: 0x74
function private function_ab2594117968a5e7( phobos, scene_struct )
{
    bonedeathscene = phobos.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.bonedeathscene;
    scene_struct thread scene::play( undefined, undefined, bonedeathscene, getdvarfloat( @"hash_ee53b68d4b6ad5c6", 0.01 ) );
    bone_skeleton = scene_struct scene::get_entity( 0 );
    return bone_skeleton;
}

// Namespace zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0x12ee4dfe, Offset: 0x875
// Size: 0x20
function private function_484f1af303125d30( scene_struct )
{
    scene_struct thread scene::stop();
    scene_struct scene::cleanup( 1 );
}

// Namespace zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0xad5d9295, Offset: 0x89d
// Size: 0x352
function private play_death_fx( params )
{
    if ( isdefined( params.body ) )
    {
        zombie_i = 0;
        
        while ( zombie_i < 8 )
        {
            params.body utility::function_7c10ea82c1e305b8( "attached_zombie_" + zombie_i + 1, "destroyed" );
            zombie_i += 1;
        }
        
        if ( self.var_56bbd9da2c5ef389 )
        {
            params.body utility::function_7c10ea82c1e305b8( "enraged", "on" );
            params.body utility::function_7c10ea82c1e305b8( "eye", "enraged" );
        }
        
        skeleton_origin = params.body.origin;
        skeleton_angles = params.body.angles;
        scene_struct = { #angles:skeleton_angles, #origin:skeleton_origin };
        bone_skeleton = function_ab2594117968a5e7( self, scene_struct );
        var_594ca39ac83f2a6d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_66709bf1eb94854d;
        cleanup_corpse_delay = self.cleanup_corpse_delay ?? 60;
        visibility_mode::function_4e6c654251b854e0( bone_skeleton );
        bone_skeleton hide();
        params.body function_dd258a3da9a2b4a1( 20 );
        params.body utility::waittill_notify_or_timeout( "dissolve", 20 );
        bone_skeleton show();
        
        if ( !isdefined( params.body ) )
        {
            return;
        }
        
        params.body utility::function_7c10ea82c1e305b8( "death_reveal", "death_reveal" );
        params.body utility::function_7c10ea82c1e305b8( "eye", "off" );
        params.body utility::function_7c10ea82c1e305b8( "enraged", "off" );
        params.body utility::waittill_notify_or_timeout( "hit_ground", 20 );
        knockback_origin = skeleton_origin + anglestoforward( skeleton_angles ) * 400;
        nearby_players = getplayersinradius( knockback_origin, 500 );
        
        foreach ( player in nearby_players )
        {
            player utility::knockback_flat( player.origin - knockback_origin, 1500 );
        }
        
        wait 1;
        collision_offset = getdvarfloat( @"hash_c768c1194006bd17", 45 ) * anglestoforward( skeleton_angles ) + getdvarfloat( @"hash_c768c0194006bae4", -45 ) * anglestoright( skeleton_angles );
        scriptable = spawnscriptable( var_594ca39ac83f2a6d, skeleton_origin + collision_offset, skeleton_angles );
        wait cleanup_corpse_delay;
        
        if ( isdefined( scriptable ) )
        {
            scriptable freescriptable();
        }
        
        if ( level.var_405b4ed476bec54e )
        {
            function_484f1af303125d30( scene_struct );
            
            if ( isent( params.body ) )
            {
                params.body hide();
            }
        }
    }
}

// Namespace zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0x86d92101, Offset: 0xbf7
// Size: 0x645
function private function_724896e630cbef00( params )
{
    if ( self.var_cffd4250b352cef4 )
    {
        return 0;
    }
    
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    damage = params.idamage;
    
    if ( issubstr( params.sweapon.basename, "rcxd" ) )
    {
        damage *= 0.01;
    }
    
    if ( damage >= self.health && self.health <= params.var_ff33243f5be1fe3b * self.maxhealth )
    {
        damage = self.health - 1;
        
        if ( params.eattacker.var_df04ece37c267e7a )
        {
            return damage;
        }
        
        self.var_1480bf6f03b7e0be = params;
        utility::ent_flag_set( "marked_for_death" );
        self function_786bb6aa1b76c7ee( "marked_for_death", 1 );
        utility::delaycallendon( 45, "death", &kill );
        val::set( "phobos_death", "damage", 0 );
        function_dc169a4b0c87f34d( self );
        thread function_73d0ea342093a003();
        return damage;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= var_cee395575559ddb9 )
        {
            damage *= var_fa73e4e06a81b041;
        }
        
        if ( arraycontains( [ "mg", "smg", "rifle" ], params.sweapon.classname ) )
        {
            damage *= 1;
        }
        
        if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
        {
            damage *= 0.25;
        }
        
        if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
        {
            damage *= 0.25;
            
            if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
            {
                damage *= getdvarfloat( @"hash_da24f5f05d502853", 0.4 );
            }
        }
        else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
        {
            damage *= getdvarfloat( @"hash_4709c1735dcffcf6", 0.35 );
        }
        
        if ( params.smeansofdeath == "MOD_BLEEDOUT" )
        {
            damage *= self.bleedout_damage_multiplier ?? 1;
        }
        
        if ( issubstr( params.sweapon.basename, "warmachine" ) )
        {
            damage *= 0.5;
        }
        
        if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
        {
            damage *= getdvarfloat( @"hash_5c5085becddc573b", 0.35 );
        }
    }
    
    solo_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( self.subclass, zombie_utils::get_zombie_round_difficulty(), 1 );
    is_featured_ww = isdefined( params.sweapon.basename ) && ( issubstr( params.sweapon.basename, "mark2" ) || issubstr( params.sweapon.basename, "dg2" ) );
    var_bafee8347bff2d71 = isdefined( params.sweapon.basename ) && issubstr( params.sweapon.basename, "mark2r" );
    var_3235adf7fdb75fec = is_featured_ww && issubstr( params.sweapon.basename, "dg2" );
    is_raygun = issubstr( params.sweapon.basename, "raygun" );
    var_f27162ef1912d024 = 0.075 * solo_max_health / self.maxhealth;
    is_dvar_weapon = getdvar( @"hash_97f4350b8f96f108", "" ) != "" && issubstr( params.sweapon.basename, getdvar( @"hash_97f4350b8f96f108", "" ) );
    
    if ( isdefined( params.metabonename ) )
    {
        metabone_health = metabone::get_metabone_health( params.metabonename );
        
        if ( ( damage > metabone_health || is_featured_ww ) && issubstr( params.metabonename, "attached" ) )
        {
            var_2f6ed935c7893f08 = 0.01;
            var_f27162ef1912d024 = var_2f6ed935c7893f08 * solo_max_health / self.maxhealth;
            
            if ( damage < self.maxhealth * var_f27162ef1912d024 )
            {
                if ( is_featured_ww )
                {
                    var_2f6ed935c7893f08 *= 2;
                    damage *= 2000;
                }
                
                damage *= 10;
            }
            else
            {
                var_f27162ef1912d024 = params.var_ff33243f5be1fe3b;
            }
            
            params.biscritical = 1;
        }
    }
    else
    {
        if ( var_3235adf7fdb75fec )
        {
            damage *= getdvarfloat( @"hash_a8dcd8613a5d590e", 0.35 );
        }
        else if ( is_featured_ww )
        {
            damage *= getdvarfloat( @"hash_dc66cce76f2df05a", 0.5 );
        }
        else if ( is_dvar_weapon )
        {
            damage *= getdvarfloat( @"hash_e1ffeaf2f9b0e71", 1 );
        }
        
        if ( var_bafee8347bff2d71 )
        {
            damage *= 2.5;
        }
    }
    
    if ( is_raygun && !is_featured_ww )
    {
        damage *= 4;
    }
    
    params.var_ff33243f5be1fe3b = min( params.var_ff33243f5be1fe3b, var_f27162ef1912d024 );
    return damage;
}

// Namespace zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0xd1f512f2, Offset: 0x1245
// Size: 0x15
function private function_dc169a4b0c87f34d( phobos )
{
    zombie_phobos_metabones::function_dc169a4b0c87f34d( phobos );
}

// Namespace zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0x548b8811, Offset: 0x1262
// Size: 0x37
function private on_phobos_killed( params )
{
    if ( !level.var_15ce4166f92c5163 )
    {
        thread function_73d0ea342093a003();
    }
    
    function_dc169a4b0c87f34d( self );
    self.var_56bbd9da2c5ef389 = zombie_phobos_enraged::is_enraged();
}

// Namespace zombie_phobos
// Params 0, eflags: 0x4
// Checksum 0x63d9842a, Offset: 0x12a1
// Size: 0xa1
function private function_73d0ea342093a003()
{
    level endon( #"game_ended" );
    
    if ( self.var_5c986686a4df80fc )
    {
        utility::flag_wait_or_timeout( "space_to_die", 20 );
    }
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace zombie_phobos
// Params 1, eflags: 0x4
// Checksum 0xb9bcf026, Offset: 0x134a
// Size: 0x2d4
function private function_45e6e16469c10a7f( params )
{
    if ( isdefined( params.metabonename ) )
    {
        utility::function_7c10ea82c1e305b8( params.metabonename + "_impact", "weakpoint_impact" );
        
        if ( issubstr( params.metabonename, "attached" ) )
        {
            playfx( utility::getfx( "attached_zombie_impact_vfx" ), params.vpoint );
        }
    }
    
    if ( self.var_cffd4250b352cef4 )
    {
        playfx( utility::getfx( "oob_incoming_impact_vfx" ), params.vpoint );
    }
    
    if ( params.idamage > 500 && params.smeansofdeath != "MOD_MELEE" && params.biscritical )
    {
        if ( !isdefined( self.var_becf6aec57a489d8 ) || gettime() > self.var_becf6aec57a489d8 )
        {
            self.var_becf6aec57a489d8 = gettime() + utility::function_4b74c15943231980( 5 );
            var_48fec4c3728ccce9 = params.shitloc == "head";
            is_torso = params.shitloc == "torso_upper" || params.shitloc == "torso_lower";
            
            if ( var_48fec4c3728ccce9 || is_torso )
            {
                from_right = 0;
                angles = self.angles;
                origin = self.origin;
                
                if ( var_48fec4c3728ccce9 )
                {
                    angles = self gettagangles( "j_head" );
                    origin = self gettagorigin( "j_head" );
                }
                
                /#
                    sphere( params.vpoint, 10 );
                    line( params.vpoint, origin );
                #/
                
                to_point = params.vpoint - origin;
                right = anglestoright( angles );
                dot = vectordot( to_point, right );
                
                if ( dot > 0 )
                {
                    from_right = 1;
                }
                
                pain_index = ( ( var_48fec4c3728ccce9 ? 1 : 0 ) << 1 | ( from_right ? 1 : 0 ) ) + 1;
                self function_6ecae54580d8f0aa( 1, pain_index );
                zombie_vox::function_5ac4bed4a907abf5( "pain_vox" );
                utility::delaycallendon( 5, "death", &function_6ecae54580d8f0aa, 0, 0 );
            }
        }
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || getdvarint( @"hash_affb07c0e2c908be", 1 ) > 0 )
    {
        if ( zombie_phobos_collision::is_player_attached( params.eattacker ) )
        {
            zombie_phobos_collision::function_c1f2696a8edc6e5c( self, params.eattacker );
            var_8decb5683644dc2f = self.var_b331e173161548c3;
            level thread function_3512264834e2b52d( var_8decb5683644dc2f, self );
        }
    }
}

// Namespace zombie_phobos
// Params 2, eflags: 0xc
// Checksum 0x6097b7b0, Offset: 0x1626
// Size: 0xe0
function private function_3512264834e2b52d( var_8decb5683644dc2f, phobos )
{
    self notify( #"hash_f18ad8723a2b604e" );
    self endon( #"hash_f18ad8723a2b604e" );
    utility::waittill_any_timeout( level.framedurationseconds, "marked_for_death" );
    
    if ( phobos utility::ent_flag( "marked_for_death" ) )
    {
        foreach ( player in var_8decb5683644dc2f )
        {
            if ( isplayer( player ) )
            {
                callback::callback( #"hash_f994b5010602c07d", { #player:player } );
            }
        }
    }
}

