// script_3b2f3564df0aea4  (hash_03b2f3564df0aea4.gscc) (size: 10089 Bytes / 0x2769 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6f7080a7 (1869643943)
// size ...... 10089 (0x2769)
// includes .. 21  (offset: 0x248d)
// strings ... 43  (offset: 0x2535)
// dev strs .. 0   (offset: 0x2769)
// exports ... 12  (offset: 0x16ad)
// cseg ...... 0x350 + 0x135d (0x16ad)
// imports ... 103 (offset: 0x188d)
// animtree1 . 0   (offset: 0x2769)
// animtree2 . 0   (offset: 0x2769)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_aetheric_energy;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_audio;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_beam_attack;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_leg;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_metabones;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_missile;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_move;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_summon;
#using scripts\common\ai\aitypes\zombie_hermes\zombie_hermes_vehicle;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;

#namespace zombie_hermes;

// Namespace zombie_hermes
// Params 2
// Checksum 0xde0fc52b, Offset: 0x36e
// Size: 0x66
function precache( classname, aitypescriptbundle )
{
    zombie_hermes_beam_attack::init_beam_attack_precache( aitypescriptbundle );
    var_4b4d72d84afd1ebd = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( var_4b4d72d84afd1ebd ) )
    {
        utility::add_fx( "hermes_immune_impact_vfx", var_4b4d72d84afd1ebd.var_5795287ff8e00e8b );
        utility::add_fx( "hermes_immune_produce_energy_impact_vfx", var_4b4d72d84afd1ebd.var_95df9001529e820d );
    }
}

// Namespace zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0xf7260c49, Offset: 0x3dc
// Size: 0xaf
function private function_358c64f6ac74e0d3( params )
{
    zombie_boss_healthbar::function_f50a10314e72caa1();
    zombie_hermes_aetheric_energy::function_bb4e848c26927853();
    zombie_hermes_move::function_9950dcd423bda79c();
    zombie_hermes_vehicle::function_b963907716ab4fd();
    zombie_hermes_audio::function_7d58d6c5ab44526f();
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &play_death_fx );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_fb927249bfe03afa );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_146454a55fe8ecba );
    callback::get_template( self.animsetname ) callback::add( "pre_killed_body_cloned", &function_4ada7eeb6c33ac49 );
}

// Namespace zombie_hermes
// Params 1
// Checksum 0x658d0c4f, Offset: 0x493
// Size: 0x1b8
function function_b3311d566fd42efc( taskid )
{
    profilestart();
    assert( isdefined( self.zombieaisetting ) );
    namespace_7e98bc5e3517bf83::function_5d23979c4c7c9a52( self.zombieaisetting );
    callback::add( "on_first_ai_init", &function_358c64f6ac74e0d3 );
    self.disable_brain_rot = 1;
    self.nocorpse = 1;
    zombie_hermes_vehicle::init_zombie_hermes_vehicle();
    zombie_hermes_leg::init_zombie_hermes_leg();
    zombie_hermes_missile::init_zombie_hermes_missile();
    zombie_hermes_beam_attack::init_zombie_hermes_beam();
    zombie_hermes_move::init_zombie_hermes_move();
    zombie_hermes_aetheric_energy::init_zombie_hermes_aetheric_energy();
    zombie_hermes_metabones::init_zombie_hermes_metabones();
    zombie_hermes_summon::init_zombie_hermes_summon();
    self.var_13518fb33ec73cc = 30;
    thread zombie_boss_healthbar::init_zombie_boss_healthbar();
    var_2de9031f0bd6faa9 = getdvarfloat( @"hermes_health_scalar", 1 );
    
    if ( var_2de9031f0bd6faa9 < 1 )
    {
        ai::set_ai_max_health( int( self.maxhealth * var_2de9031f0bd6faa9 ) );
        self.var_9dd11279d5e371c7 *= var_2de9031f0bd6faa9;
        self.health = self.maxhealth;
    }
    
    self.hermes_health_scalar = var_2de9031f0bd6faa9;
    
    foreach ( player in level.players )
    {
        player thread zombie_boss_healthbar::zombie_boss_healthbar_show( "zombie_hermes_healthbar", self );
    }
    
    zombie_utils::function_dfae6a5bd222c586( &function_dc6186ac56c4553b );
    self function_43a971093c992365( 1 );
    thread init_difficulty_changes();
    thread initscriptable();
    profilestop();
    return anim.success;
}

// Namespace zombie_hermes
// Params 0, eflags: 0x4
// Checksum 0x34f11c02, Offset: 0x655
// Size: 0x40
function private initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
    utility::function_7c10ea82c1e305b8( "base", "base_on" );
}

// Namespace zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0x4da1c6f7, Offset: 0x69d
// Size: 0x875
function private function_dc6186ac56c4553b( params )
{
    damage = params.idamage;
    is_ww_vehicle_hit = 0;
    is_imbued = 0;
    
    if ( zombie_hermes_vehicle::is_valid_vehicle_hit( params ) )
    {
        hit_recently = utility::ent_flag( "hit_by_vehicle_recently" );
        utility::ent_flag_set( "hit_by_vehicle_recently" );
        utility::delaythreadendon( 2, "hit_by_vehicle_recently", &utility::ent_flag_clear, "hit_by_vehicle_recently" );
        params.eattacker utility::ent_flag_set( "vehicle_collision_missile_protection" );
        params.eattacker thread utility::ent_flag_clear_delayed( "vehicle_collision_missile_protection", self.var_142f5d7f5981c58d ?? 5 );
        
        if ( hit_recently )
        {
            damage *= 0.001;
            params.var_d20799805edf0194 = 1;
        }
        else if ( params.eattacker.var_b6a3f46ec4332fd8 )
        {
            is_imbued = params.eattacker utility::ent_flag( "aetheric_energy_imbued" );
            damage_multiplier = zombie_hermes_vehicle::function_3b675e9a0c959e1d( self, params.eattacker, params );
            damage *= damage_multiplier;
            is_ww_vehicle_hit = 1;
        }
        else
        {
            zombie_hermes_vehicle::function_3b675e9a0c959e1d( self, params.eattacker, params );
        }
    }
    else if ( params.eattacker.vehicletype )
    {
        params.var_d20799805edf0194 = 1;
    }
    
    if ( issubstr( params.sweapon.basename, "pluto_dg2" ) && params.eattacker.vehicle )
    {
        attacker_seat = vehicle_occupancy::instance_is_registered( params.eattacker.vehicle ) ? vehicle_occupancy::get_occupant_seat( params.eattacker.vehicle, params.eattacker ) : undefined;
        
        if ( attacker_seat == "gunner" )
        {
            damage *= getdvarfloat( @"hash_2167c15972a53505", 4 );
        }
    }
    
    var_fa73e4e06a81b041 = 0.8;
    var_cee395575559ddb9 = 3;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        paplevel = params.eattacker namespace_9d8e359c3b1041e5::function_1d4087075103b248( params.sweapon );
        
        if ( paplevel >= var_cee395575559ddb9 )
        {
            damage *= var_fa73e4e06a81b041;
        }
        
        if ( paplevel >= 4 )
        {
            damage *= 0.6;
        }
    }
    
    is_wonder = weapon::iswonderweapon( params.sweapon );
    
    if ( utility::issharedfuncdefined( #"zombie", #"GetPlayerWeaponRarity" ) && isdefined( params.sweapon ) && isplayer( params.eattacker ) )
    {
        rarity = params.eattacker namespace_9d8e359c3b1041e5::getplayerweaponraritysharedfunc( params.sweapon );
        
        if ( rarity == 5 && !is_wonder )
        {
            damage *= 0.8;
        }
    }
    
    if ( is_wonder )
    {
        damage *= getdvarfloat( @"hash_1344da215a9d3218", 2 );
        
        if ( issubstr( params.sweapon.basename, "ww_firefly" ) )
        {
            damage *= getdvarfloat( @"hash_d2b327d69aa59ee2", 1 );
        }
    }
    
    if ( issubstr( params.sweapon.basename, "liquid" ) )
    {
        damage *= getdvarfloat( @"hash_70eeb3c6282166e1", 0.5 );
    }
    
    if ( arraycontains( [ "rocketlauncher" ], params.sweapon.classname ) )
    {
        damage *= 0.25;
    }
    
    if ( arraycontains( [ "spread" ], params.sweapon.classname ) )
    {
        damage *= 1;
    }
    
    if ( arraycontains( [ "dark_flare" ], params.sweapon.basename ) )
    {
        damage *= 0.5;
    }
    
    if ( arraycontains( [ "turret" ], params.sweapon.classname ) )
    {
        damage *= 0.25;
        
        if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) )
        {
            damage *= getdvarfloat( @"hash_9888037acf1fedd4", 0.4 );
        }
    }
    else if ( params.biscritical && isexplosivedamagemod( params.smeansofdeath ) && params.sweapon.damagemodcategory != #"lethal" )
    {
        damage *= getdvarfloat( @"hash_53ae9969f80d0173", 0.35 );
    }
    
    if ( issubstr( params.sweapon.basename, "warmachine" ) )
    {
        damage *= 0.5;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" || params.sweapon.ismelee )
    {
        damage *= getdvarfloat( @"hash_981c0b183e1549f2", 0.35 );
    }
    
    if ( self.var_b662c3ab73c360ee )
    {
        if ( self.var_b662c3ab73c360ee.head === params.metabonename && !utility::time_has_passed( self.var_b662c3ab73c360ee.time, 4 ) && params.sweapon.classname === "grenade" )
        {
            damage *= getdvarfloat( @"hash_e24f72f035c65572", 5 );
            params.biscritical = 1;
        }
    }
    
    moving_platform_parent = isplayer( params.eattacker ) ? params.eattacker getmovingplatformparent() : undefined;
    var_e88477d7eb370d4a = params.eattacker.vehicle || moving_platform_parent.vehicletype;
    
    if ( !var_e88477d7eb370d4a )
    {
        damage *= getdvarfloat( @"hash_32ea6921f5323f2d", 0.75 );
    }
    
    var_339d6cc1cd302213 = !zombie_hermes_aetheric_energy::is_stunned( self ) || zombie_hermes_aetheric_energy::is_recently_stunned( self );
    is_immune = zombie_hermes_aetheric_energy::function_798e83d6bf762949( self ) && var_339d6cc1cd302213 || utility::ent_flag( "hermes_gamera_spin_immune" );
    
    if ( params.metabonename == "belly" )
    {
        is_immune = 0;
    }
    
    if ( !is_immune && damage >= self.health && self.health <= params.var_ff33243f5be1fe3b * self.maxhealth || getdvarint( @"hash_80207547d0b458f3", 0 ) > 0 )
    {
        damage = 1;
        thread function_405bbb5687625a77( params );
        return damage;
    }
    
    if ( is_immune )
    {
        if ( !zombie_hermes_aetheric_energy::is_recently_stunned( self ) )
        {
            zombie_hermes_aetheric_energy::function_8f74d1df92413c95( self, damage );
        }
        
        if ( is_ww_vehicle_hit )
        {
            if ( is_imbued )
            {
                lower_bound = zombie_hermes_aetheric_energy::function_c11303ef88c3dd( self );
                var_56773ce0b3d97ded = self.health - damage;
                
                if ( var_56773ce0b3d97ded < lower_bound )
                {
                    return int( max( self.health - lower_bound - 2000, 100 ) );
                }
                
                return damage;
            }
            
            return 100;
        }
        
        return 0;
    }
    else if ( !zombie_hermes_aetheric_energy::is_stunned( self ) )
    {
        var_56773ce0b3d97ded = self.health - damage;
        spin_health_threshold = zombie_hermes_aetheric_energy::get_hermes_gamera_spin_health_threshold( self );
        
        if ( var_56773ce0b3d97ded < spin_health_threshold && !utility::ent_flag( "hermes_gamera_spin" ) )
        {
            level callback::callback( "vo_hermes_invulnerable", { #phase:zombie_hermes_aetheric_energy::get_hermes_phase( self ) } );
            thread zombie_hermes_move::function_7115fba9ef789d9( self );
        }
        
        aetheric_health_threshold = zombie_hermes_aetheric_energy::function_84e20c26b0bfba86( self );
        
        if ( self.health - damage < aetheric_health_threshold )
        {
            return int( max( self.health - aetheric_health_threshold, 0 ) );
        }
    }
    
    return damage;
}

// Namespace zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0x99d8a866, Offset: 0xf1b
// Size: 0x1c5
function private function_fb927249bfe03afa( params )
{
    if ( isdefined( params.metabonename ) )
    {
        if ( zombie_hermes_metabones::function_343158931a6545a6( params.metabonename ) || params.metabonename == "belly" )
        {
            utility::function_32b24db3127bff40( params.metabonename + "_impact", "impact" );
            
            if ( isdefined( self.var_3c8a3678a0a31bdb ) )
            {
                self.var_3c8a3678a0a31bdb += params.idamage;
            }
        }
    }
    
    var_f45c069c1f9834ba = arraycontains( [ "MOD_CRUSH" ], params.smeansofdeath ) && params.eattacker.vehicletype;
    
    if ( !var_f45c069c1f9834ba && params.idamage > 1000 && params.smeansofdeath != "MOD_MELEE" )
    {
        if ( !isdefined( self.var_becf6aec57a489d8 ) || gettime() > self.var_becf6aec57a489d8 )
        {
            self.var_becf6aec57a489d8 = gettime() + utility::function_4b74c15943231980( 5 );
            pain_index = 1;
            self function_6ecae54580d8f0aa( 1, pain_index );
            zombie_vox::function_5ac4bed4a907abf5( "pain_vox" );
            utility::delaycallendon( 5, "death", &function_6ecae54580d8f0aa, 0, 0 );
        }
    }
    
    if ( zombie_hermes_aetheric_energy::function_4fd93d1d3fcae3e6( self ) )
    {
        playfx( utility::getfx( "hermes_immune_produce_energy_impact_vfx" ), params.vpoint );
    }
    else if ( utility::ent_flag( "hermes_gamera_spin" ) )
    {
        playfx( utility::getfx( "hermes_immune_impact_vfx" ), params.vpoint );
    }
    
    zombie_hermes_metabones::function_a5583f43b9b86ee( params );
}

// Namespace zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0x60a66237, Offset: 0x10e8
// Size: 0x34
function private function_146454a55fe8ecba( params )
{
    self.var_bf3c9fab13c40a37 = zombie_hermes_metabones::get_alive_heads( self );
    self.var_a1cd695adbaaaa4e = zombie_hermes_metabones::get_attached_heads( self );
    zombie_hermes_metabones::function_3bcda9006a018fdc( self );
}

// Namespace zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0x7e3b1b69, Offset: 0x1124
// Size: 0x17c
function private play_death_fx( params )
{
    var_7c5a818d43af69aa = self.var_bf3c9fab13c40a37;
    var_5e281b6e450433f = self.var_a1cd695adbaaaa4e;
    
    if ( params.body )
    {
        params.body function_dd258a3da9a2b4a1( 10 );
        
        foreach ( head in var_5e281b6e450433f )
        {
            params.body utility::function_32b24db3127bff40( head, "exposed" );
        }
    }
    
    waitframe();
    
    if ( params.body )
    {
        foreach ( head in var_7c5a818d43af69aa )
        {
            params.body utility::function_32b24db3127bff40( head, "destroyed" );
        }
    }
    
    wait 10;
    
    if ( params.body )
    {
        params.body delete();
    }
}

// Namespace zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0xe7a86aea, Offset: 0x12a8
// Size: 0x16
function private function_4ada7eeb6c33ac49( params )
{
    self.iscorpsefalling = 0;
}

// Namespace zombie_hermes
// Params 0, eflags: 0x4
// Checksum 0xb8915642, Offset: 0x12c6
// Size: 0x26e
function private init_difficulty_changes()
{
    self endon( #"death" );
    waitframe();
    
    if ( isdefined( level.directed_mode ) || getdvarint( @"hash_6dc3ee14c4a05c36", 0 ) )
    {
        var_2c360ac214485358 = 0.3;
        ai::set_ai_max_health( int( self.maxhealth * var_2c360ac214485358 ) );
        self.var_9dd11279d5e371c7 *= var_2c360ac214485358;
        self.health = self.maxhealth;
        self.var_15b3c7c5e5bc403a = 0.17;
        self.var_bba8c3d43b9de7d7 = 1;
        
        if ( level.players.size == 1 )
        {
            self.var_1f06e3db65f4de8c = 0.5;
        }
        
        return;
    }
    
    var_6be53acd0b1cd70a = level.var_81dc9de2fda86a3f;
    round_difficulty = zombie_utils::get_zombie_round_difficulty();
    
    if ( round_difficulty < 50 )
    {
        if ( !var_6be53acd0b1cd70a )
        {
            self.var_bba8c3d43b9de7d7 = 1;
            self.var_15b3c7c5e5bc403a = 0.17;
            
            if ( level.players.size == 1 )
            {
                self.var_1f06e3db65f4de8c = 0.8;
            }
            
            self.var_142f5d7f5981c58d = 5;
            self.var_45dd78b65ba72097 = 0.25;
            self.var_f290c89ef95473b8 = 1;
        }
        
        return;
    }
    
    if ( round_difficulty >= 50 && round_difficulty < 100 )
    {
        self.var_3fb70b08726a5da0 = [ 0.85, 0.42, 0.07 ];
        self.var_1a69b6b0a7582d0c = [ 1, 0.78, 0.35 ];
        
        if ( !var_6be53acd0b1cd70a )
        {
            self.var_bba8c3d43b9de7d7 = 1;
            self.var_15b3c7c5e5bc403a = 0.17;
            
            if ( level.players.size == 1 )
            {
                self.var_1f06e3db65f4de8c = 0.8;
            }
            
            self.var_142f5d7f5981c58d = 5;
            self.var_45dd78b65ba72097 = 0.25;
            self.var_f290c89ef95473b8 = 1;
        }
        
        return;
    }
    
    if ( round_difficulty >= 100 )
    {
        self.var_3fb70b08726a5da0 = [ 0.9, 0.5, 0.07 ];
        self.var_1a69b6b0a7582d0c = [ 1, 0.83, 0.43 ];
        self.var_bd523ebcb3040531 = 1;
        self.var_c036c75be54bf29f = 1.5;
    }
}

// Namespace zombie_hermes
// Params 1, eflags: 0x4
// Checksum 0x84518dcf, Offset: 0x153c
// Size: 0x171
function private function_405bbb5687625a77( dmg_struct )
{
    self notify( #"fake_death" );
    self notify( #"hash_ce9a5bbc5b4c6bd" );
    self.var_1480bf6f03b7e0be = dmg_struct;
    utility::ent_flag_set( "marked_for_death" );
    self function_786bb6aa1b76c7ee( "marked_for_death", 1 );
    level thread zombie_hermes_metabones::function_3bcda9006a018fdc( self );
    
    foreach ( player in level.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
    
    val::set( "hermes_death", "damage", 0 );
    val::set( "hermes_death", "ignoreall", 1 );
    asm::asm_setstate( "death" );
    utility::waittill_notify_or_timeout( "end_fake_death", 18 );
    
    if ( isalive( self ) )
    {
        self.death_source = "hermes_fake_death";
        
        if ( dmg_struct.eattacker )
        {
            self kill( self.origin, dmg_struct.eattacker, dmg_struct.einflictor, dmg_struct.smeansofdeath, dmg_struct.sweapon );
            return;
        }
        
        self kill();
    }
}

