// scripts\common\ai\aitypes\zombie_ghoul\zombie_ghoul_blast_attack.gsc  (hash_7b959fbe197bb9da.gscc) (size: 9747 Bytes / 0x2613 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x24daf983 (618330499)
// size ...... 9747 (0x2613)
// includes .. 6   (offset: 0x2393)
// strings ... 28  (offset: 0x23c3)
// dev strs .. 17  (offset: 0x2547)
// exports ... 30  (offset: 0x14fb)
// cseg ...... 0x232 + 0x12c9 (0x14fb)
// imports ... 85  (offset: 0x19ab)
// animtree1 . 0   (offset: 0x2613)
// animtree2 . 0   (offset: 0x2613)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\gametypes\common;

#namespace zombie_ghoul_blast_attack;

// Namespace zombie_ghoul_blast_attack
// Params 1
// Checksum 0x19088a63, Offset: 0x250
// Size: 0x48
function precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    level.var_bfa8093807c5a2a2 = settings.var_daff6646ee413464;
    level.var_efa83f36ebf38260 = settings.var_2a8d98f00a41bb00;
}

// Namespace zombie_ghoul_blast_attack
// Params 0
// Checksum 0x3a88fc57, Offset: 0x2a0
// Size: 0x38
function function_bb2be6939cc4c949()
{
    level.ghoul_blast_effect_index = [];
    level.ghoul_blast_effect_defs = [];
    register_blast_effect( "hallucination", &function_1270f287c4f22907, &function_1d583010e0b25d7f, 2 );
    
    /#
        function_8ddf2c0d5efe3d00();
    #/
}

// Namespace zombie_ghoul_blast_attack
// Params 0
// Checksum 0x2380b305, Offset: 0x2e0
// Size: 0x1d2
function init_zombie_ghoul_blast_attack()
{
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ) );
    self.var_54e2772e02f32c54 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7386b42053170be9;
    self.var_41445aa8a5b2dd95 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8c3640767d1af401;
    self.var_4b2ed608445245cb = cos( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_281e903fb75728f1 * 0.5 );
    self.blast_attack_damage_player = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5267213b2feeca40 * ( self.var_fe048a2106d8ef00[ #"blast_attack" ] ?? 1 );
    self.death_blast_attack_damage_player = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d3361a399e28e1b6 * ( self.var_fe048a2106d8ef00[ #"death_blast_attack" ] ?? 1 );
    self.blast_attack_cooldown_min = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e943720a0b27b0c9;
    self.blast_attack_cooldown_max = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8d6f4a9ed5a33ba3;
    self function_786bb6aa1b76c7ee( "blast_attack_min_range", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7d9b84d393bc9e38 );
    self function_786bb6aa1b76c7ee( "blast_attack_max_count", self.var_577dec43cf1caedf );
    thread function_4b62cdaed41bca68( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7dbe9ad393e31652 );
    thread function_4d5a3d0fa197b383();
    thread function_4d166e9d5a1634b();
}

// Namespace zombie_ghoul_blast_attack
// Params 1, eflags: 0x4
// Checksum 0x299bfc0e, Offset: 0x4ba
// Size: 0x8c
function private function_4b62cdaed41bca68( max_range )
{
    self endon( #"death" );
    
    while ( true )
    {
        self function_786bb6aa1b76c7ee( "blast_attack_max_range", 0 );
        self waittill( #"damage" );
        self function_786bb6aa1b76c7ee( "blast_attack_max_range", max_range );
        
        while ( true )
        {
            wait 1;
            
            if ( !isdefined( self.last_dmg_struct.timehit ) || gettime() > self.last_dmg_struct.timehit + 10000 )
            {
                break;
            }
        }
    }
}

// Namespace zombie_ghoul_blast_attack
// Params 1, eflags: 0x4
// Checksum 0xa380b001, Offset: 0x54e
// Size: 0x68
function private function_8a0dc9e57c2c5397( player )
{
    player endon( #"disconnect" );
    player function_a58e1bd7ca9f6222( "blast_attack" );
    utility::waittill_any_timeout( 5, "death", "blast_attack_start" );
    
    if ( !isalive( self ) )
    {
        player function_31d0b50675d9d6e( "blast_attack" );
        return;
    }
    
    utility::waittill_any_timeout( 2, "death" );
    player function_31d0b50675d9d6e( "blast_attack" );
}

// Namespace zombie_ghoul_blast_attack
// Params 0, eflags: 0x4
// Checksum 0xd8b7377f, Offset: 0x5be
// Size: 0x43
function private function_4d166e9d5a1634b()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"blast_attack_prepare" );
        
        if ( isplayer( self.enemy ) )
        {
            thread function_8a0dc9e57c2c5397( self.enemy );
        }
    }
}

// Namespace zombie_ghoul_blast_attack
// Params 0, eflags: 0x4
// Checksum 0x13e785dd, Offset: 0x609
// Size: 0x72
function private function_4d5a3d0fa197b383()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"blast_attack_start" );
        blast_attack_loop();
        self setscriptablepartstate( "blast_attack_fx", "off" );
        cooldown_ms = randomfloatrange( self.blast_attack_cooldown_min, self.blast_attack_cooldown_max ) * 1000;
        self function_786bb6aa1b76c7ee( "blast_attack_cooldown", cooldown_ms + gettime() );
    }
}

// Namespace zombie_ghoul_blast_attack
// Params 0, eflags: 0x4
// Checksum 0x55d0261, Offset: 0x683
// Size: 0x115
function private blast_attack_loop()
{
    self endon( #"blast_attack_end" );
    attack_pitch = 0;
    
    if ( isdefined( self.enemy ) )
    {
        var_4b2ce735265d99f8 = vectornormalize( self.enemy.origin - self.origin );
        to_enemy_pitch = vectortopitch( var_4b2ce735265d99f8 );
        attack_pitch = angleclamp180( self.angles[ 0 ] - to_enemy_pitch );
        self setaimangles( ( attack_pitch, 0, 0 ) );
    }
    
    self orientmode( "face enemy" );
    fire_needle_blast_timeout = 2;
    var_5b4eff275b24247d = utility::waittill_any_timeout( fire_needle_blast_timeout, "fire_needle_blast" );
    
    if ( var_5b4eff275b24247d == "timeout" )
    {
        return;
    }
    
    self orientmode( "face current" );
    self setscriptablepartstate( "blast_attack_fx", "on" );
    
    /#
        function_903258e78a2b7f9e( attack_pitch );
    #/
    
    while ( true )
    {
        function_6de7b88d25e1e604( self.var_54e2772e02f32c54, self.var_4b2ed608445245cb, self.blast_attack_damage_player, attack_pitch );
        wait 0.5;
    }
}

// Namespace zombie_ghoul_blast_attack
// Params 4
// Checksum 0x1bcf91c6, Offset: 0x7a0
// Size: 0x2ad
function function_6de7b88d25e1e604( max_dist, min_damage_dot, n_damage, attack_pitch )
{
    potential_zombies = getaiarrayinradius( self.origin, max_dist );
    potential_enemies = utility::get_array_of_closest( self.origin, level.players, undefined, 4, max_dist );
    potential_enemies = arraycombine( potential_enemies, potential_zombies );
    damage_angles = self.angles - ( attack_pitch ?? 0, 0, 0 );
    var_42e818468283f77b = anglestoforward( damage_angles );
    damage_origin = self.origin + ( 0, 0, 48 );
    current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    ai_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round ?? 0 );
    n_ai_damage = max( ( ai_max_health ?? 0 ) * 0.3, 600 );
    
    foreach ( enemy in potential_enemies )
    {
        if ( !isalive( enemy ) || enemy.team == self.team )
        {
            continue;
        }
        
        if ( !enemy val::get( "damage" ) )
        {
            continue;
        }
        
        enemy_dir = vectornormalize( enemy.origin - self.origin );
        damage_dot = vectordot( var_42e818468283f77b, enemy_dir );
        
        if ( damage_dot < min_damage_dot )
        {
            continue;
        }
        
        if ( enemy damageconetrace( damage_origin, self ) <= 0 )
        {
            continue;
        }
        
        if ( isplayer( enemy ) )
        {
            enemy dodamage( n_damage, damage_origin, self, self, "MOD_EXPLOSIVE_BULLET", undefined, "none", undefined, 65536 );
            enemy function_8ea31b9698792c75();
            continue;
        }
        
        if ( n_ai_damage >= enemy.health )
        {
            enemy.ragdollimpactvector = ( vectornormalize( enemy.origin - damage_origin ) + ( 0, 0, 0.25 ) ) * 4000;
            enemy.ragdollhitloc = "torso_upper";
            enemy.do_immediate_ragdoll = 1;
        }
        
        enemy dodamage( n_ai_damage, damage_origin, self, self, "MOD_IMPACT", undefined, "none", undefined, 1073807360 );
    }
}

// Namespace zombie_ghoul_blast_attack
// Params 4, eflags: 0x4
// Checksum 0xf361eac2, Offset: 0xa55
// Size: 0x91
function private register_blast_effect( effect_name, effect_start_func, var_b11a916a09e1507, default_duration )
{
    effect_struct = {};
    effect_struct.effect_name = effect_name;
    effect_struct.effect_start_func = effect_start_func;
    effect_struct.var_b11a916a09e1507 = var_b11a916a09e1507;
    effect_struct.default_duration = default_duration;
    level.ghoul_blast_effect_defs[ effect_name ] = effect_struct;
    level.ghoul_blast_effect_index[ level.ghoul_blast_effect_index.size ] = effect_name;
}

// Namespace zombie_ghoul_blast_attack
// Params 1
// Checksum 0xe57ab4e7, Offset: 0xaee
// Size: 0x46
function function_8ea31b9698792c75( duration )
{
    var_b2e22d704f73057c = randomint( level.ghoul_blast_effect_index.size );
    effect_name = level.ghoul_blast_effect_index[ var_b2e22d704f73057c ];
    apply_ghoul_blast_effect( effect_name, duration );
}

// Namespace zombie_ghoul_blast_attack
// Params 2
// Checksum 0x522bcb62, Offset: 0xb3c
// Size: 0x29
function apply_ghoul_blast_effect( effect_name, duration )
{
    thread handle_ghoul_blast_effect( level.ghoul_blast_effect_defs[ effect_name ], duration );
}

// Namespace zombie_ghoul_blast_attack
// Params 2, eflags: 0x4
// Checksum 0x22592778, Offset: 0xb6d
// Size: 0xd4
function private handle_ghoul_blast_effect( effect_struct, duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( utility::ent_flag( "ghoul_blast_effect" ) || utility::ent_flag( "prevent_ghoul_blast_effect" ) )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" + effect_struct.effect_name );
    #/
    
    utility::ent_flag_set( "ghoul_blast_effect" );
    utility::function_32b24db3127bff40( "blast_attack_fx", "on" );
    
    if ( !isdefined( duration ) )
    {
        duration = effect_struct.default_duration;
    }
    
    if ( isdefined( effect_struct.effect_start_func ) )
    {
        [[ effect_struct.effect_start_func ]]( self, duration );
    }
    
    wait duration;
    
    if ( isdefined( effect_struct.var_b11a916a09e1507 ) )
    {
        [[ effect_struct.var_b11a916a09e1507 ]]( self );
    }
    
    utility::ent_flag_clear( "ghoul_blast_effect" );
}

// Namespace zombie_ghoul_blast_attack
// Params 2, eflags: 0x4
// Checksum 0x350e9590, Offset: 0xc49
// Size: 0x8e
function private function_f2a851e509dd8f20( player, duration )
{
    base_angles = player getplayerangles();
    kick_yaw = randomfloatrange( 15, 30 );
    kick_pitch = randomfloatrange( 5, 20 );
    kick_yaw *= utility::cointoss() ? 1 : -1;
    kick_pitch *= utility::cointoss() ? 1 : -1;
    player setplayerangles( ( base_angles[ 0 ] + kick_yaw, base_angles[ 1 ] + kick_pitch, base_angles[ 2 ] ) );
}

// Namespace zombie_ghoul_blast_attack
// Params 2, eflags: 0x4
// Checksum 0xdfc266a3, Offset: 0xcdf
// Size: 0x102
function private function_6743c069a59aa013( player, duration )
{
    primary_weapons = player.primaryweapons;
    primary_weapons[ primary_weapons.size ] = player.var_cc1262e66dbb1c79;
    current_weapon = player getcurrentweapon();
    var_f8431926984bb559 = undefined;
    
    foreach ( weapon in primary_weapons )
    {
        if ( weapon === current_weapon )
        {
            continue;
        }
        
        if ( weapon.classname == "fist" )
        {
            continue;
        }
        
        if ( !weapon.ismelee )
        {
            var_f8431926984bb559 = weapon;
            break;
        }
        
        var_f8431926984bb559 = weapon;
    }
    
    player switchtoweapon( var_f8431926984bb559 );
}

// Namespace zombie_ghoul_blast_attack
// Params 2, eflags: 0x4
// Checksum 0x2d32b56b, Offset: 0xde9
// Size: 0x85
function private function_28161c3b6a6e6611( player, duration )
{
    if ( !isdefined( self.movespeedscaler ) || self.movespeedscaler == 1 )
    {
        self.var_680c514ad2abe8b5 = 1;
        self.var_86539b167cc27115 = self.movespeedscaler;
        self.movespeedscaler = 0.6;
        common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
        self setmovespeedscale( self.movespeedscaler );
    }
}

// Namespace zombie_ghoul_blast_attack
// Params 1, eflags: 0x4
// Checksum 0x91766671, Offset: 0xe76
// Size: 0x9a
function private function_16099addd9539d39( player )
{
    if ( self.var_680c514ad2abe8b5 )
    {
        self.movespeedscaler = self.var_86539b167cc27115;
        
        if ( !isdefined( self.movespeedscaler ) || self.movespeedscaler == 1 )
        {
            common::function_d85a92c557ea5a52( "moveSpeedScaler" );
        }
        else
        {
            common::function_a0f5c85d465c5f0a( "moveSpeedScaler", self.movespeedscaler - 1 );
        }
        
        self setmovespeedscale( self.movespeedscaler ?? 1 );
        self.var_680c514ad2abe8b5 = undefined;
        self.var_86539b167cc27115 = undefined;
    }
}

// Namespace zombie_ghoul_blast_attack
// Params 2, eflags: 0x4
// Checksum 0xbad40201, Offset: 0xf18
// Size: 0x15
function private function_de19958fb75733b3( player, duration )
{
    
}

// Namespace zombie_ghoul_blast_attack
// Params 1, eflags: 0x4
// Checksum 0xd71444a1, Offset: 0xf35
// Size: 0xc
function private function_b9be9bcf0203befb( player )
{
    
}

// Namespace zombie_ghoul_blast_attack
// Params 2, eflags: 0x4
// Checksum 0x303b66dd, Offset: 0xf49
// Size: 0x31
function private function_afedbcb646fff911( player, duration )
{
    player shellshock( level.var_bfa8093807c5a2a2, duration );
    function_28161c3b6a6e6611( player, duration );
}

// Namespace zombie_ghoul_blast_attack
// Params 1, eflags: 0x4
// Checksum 0xea492969, Offset: 0xf82
// Size: 0x15
function private function_443767461fe5ef59( player )
{
    function_16099addd9539d39( player );
}

// Namespace zombie_ghoul_blast_attack
// Params 2, eflags: 0x4
// Checksum 0x66fe738, Offset: 0xf9f
// Size: 0x41
function private function_1270f287c4f22907( player, duration )
{
    pbgpostfxbundlestart( player, level.var_efa83f36ebf38260 );
    player setscriptablepartstate( "snd_zm_hallucinate", "activate", 0 );
    function_28161c3b6a6e6611( player, duration );
}

// Namespace zombie_ghoul_blast_attack
// Params 1, eflags: 0x4
// Checksum 0xaaf2548b, Offset: 0xfe8
// Size: 0x27
function private function_1d583010e0b25d7f( player )
{
    player setscriptablepartstate( "snd_zm_hallucinate", "deactivate", 0 );
    function_16099addd9539d39( player );
}

/#

    // Namespace zombie_ghoul_blast_attack
    // Params 0, eflags: 0x4
    // Checksum 0x26a93209, Offset: 0x1017
    // Size: 0xe6, Type: dev
    function private function_8ddf2c0d5efe3d00()
    {
        devgui::function_9082edeb5db93280( "<dev string:x38>" );
        devgui::add_devgui_func( "<dev string:x56>", "<dev string:x69>", &function_ae16cfecd700cd75 );
        devgui::add_devgui_func( "<dev string:x7c>", "<dev string:x90>", &function_717842a890e40210 );
        devgui::add_devgui_func( "<dev string:xa4>", "<dev string:xb6>", &function_835092fb57415fe1 );
        
        foreach ( effect_name in level.ghoul_blast_effect_index )
        {
            devgui::function_cd4e263c1f3018ae( "<dev string:xc8>" + effect_name, "<dev string:xd6>" + effect_name, &function_6ad49458e2bfa909 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_ghoul_blast_attack
    // Params 0, eflags: 0x4
    // Checksum 0xa3a55308, Offset: 0x1105
    // Size: 0x59, Type: dev
    function private function_ae16cfecd700cd75()
    {
        ghoul = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:xeb>" );
        
        if ( isdefined( ghoul ) )
        {
            ghoul utility::function_7c10ea82c1e305b8( "<dev string:xf8>", "<dev string:xfd>" );
            ghoul function_786bb6aa1b76c7ee( "<dev string:x109>", 1 );
        }
    }

    // Namespace zombie_ghoul_blast_attack
    // Params 0, eflags: 0x4
    // Checksum 0x3d3d50f8, Offset: 0x1166
    // Size: 0x87, Type: dev
    function private function_717842a890e40210()
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player function_8ea31b9698792c75();
            }
        }
    }

    // Namespace zombie_ghoul_blast_attack
    // Params 1, eflags: 0x4
    // Checksum 0x5c7c56a5, Offset: 0x11f5
    // Size: 0x94, Type: dev
    function private function_6ad49458e2bfa909( param )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                player apply_ghoul_blast_effect( param[ 0 ] );
            }
        }
    }

    // Namespace zombie_ghoul_blast_attack
    // Params 0, eflags: 0x4
    // Checksum 0xe3560408, Offset: 0x1291
    // Size: 0x47, Type: dev
    function private function_835092fb57415fe1()
    {
        if ( level.var_61c87e0fffec0a08 )
        {
            level.var_61c87e0fffec0a08 = 0;
        }
        else
        {
            level.var_61c87e0fffec0a08 = 1;
        }
        
        iprintlnbold( level.var_61c87e0fffec0a08 ? "<dev string:x119>" : "<dev string:x13c>" );
    }

    // Namespace zombie_ghoul_blast_attack
    // Params 1, eflags: 0x4
    // Checksum 0xe8e6fdd3, Offset: 0x12e0
    // Size: 0x21b, Type: dev
    function private function_903258e78a2b7f9e( attack_pitch )
    {
        if ( !level.var_61c87e0fffec0a08 )
        {
            return;
        }
        
        attack_origin = self gettagorigin( "<dev string:x160>" );
        attack_angles = self.angles - ( attack_pitch ?? 0, 0, 0 );
        var_ee6815b5739b5d0 = anglestoforward( attack_angles );
        var_689c1280f697b592 = anglestoleft( attack_angles );
        attack_up = anglestoup( attack_angles );
        offset = self.var_54e2772e02f32c54 * sqrt( 1 - squared( self.var_4b2ed608445245cb ) ) / self.var_4b2ed608445245cb;
        var_a4010d4e681c2351 = offset * sqrt( 0.5 );
        duration = 100;
        end_point_center = attack_origin + var_ee6815b5739b5d0 * self.var_54e2772e02f32c54;
        line( attack_origin, end_point_center, ( 0, 1, 0 ), 1, 1, 100 );
        line( attack_origin, end_point_center + attack_up * offset, ( 0, 1, 0 ), 1, 1, duration );
        line( attack_origin, end_point_center - attack_up * offset, ( 0, 1, 0 ), 1, 1, duration );
        line( attack_origin, end_point_center + var_689c1280f697b592 * offset, ( 0, 1, 0 ), 1, 1, duration );
        line( attack_origin, end_point_center - var_689c1280f697b592 * offset, ( 0, 1, 0 ), 1, 1, duration );
        line( attack_origin, end_point_center + attack_up * var_a4010d4e681c2351 + var_689c1280f697b592 * var_a4010d4e681c2351, ( 0, 1, 0 ), 1, 1, duration );
        line( attack_origin, end_point_center + attack_up * var_a4010d4e681c2351 - var_689c1280f697b592 * var_a4010d4e681c2351, ( 0, 1, 0 ), 1, 1, duration );
        line( attack_origin, end_point_center - attack_up * var_a4010d4e681c2351 + var_689c1280f697b592 * var_a4010d4e681c2351, ( 0, 1, 0 ), 1, 1, duration );
        line( attack_origin, end_point_center - attack_up * var_a4010d4e681c2351 - var_689c1280f697b592 * var_a4010d4e681c2351, ( 0, 1, 0 ), 1, 1, duration );
    }

#/
