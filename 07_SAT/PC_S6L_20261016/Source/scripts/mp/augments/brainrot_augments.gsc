// scripts\mp\augments\brainrot_augments.gsc  (hash_1c2bfe43ceaf96ef.gscc) (size: 7031 Bytes / 0x1b77 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe9d5c06b (3923099755)
// size ...... 7031 (0x1b77)
// includes .. 14  (offset: 0x19c7)
// strings ... 22  (offset: 0x1a37)
// dev strs .. 0   (offset: 0x1b77)
// exports ... 11  (offset: 0x10f7)
// cseg ...... 0x21c + 0xedb (0x10f7)
// imports ... 59  (offset: 0x12af)
// animtree1 . 0   (offset: 0x1b77)
// animtree2 . 0   (offset: 0x1b77)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_bloat;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\status_effects\effect_charm;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\ammomods\brainrot;

#namespace brainrot_augments;

// Namespace brainrot_augments
// Params 0, eflags: 0x5
// Checksum 0x1e7fd086, Offset: 0x23a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"brainrot_augments", undefined, &init_brainrot_augments, undefined );
}

// Namespace brainrot_augments
// Params 0
// Checksum 0xb23ce1f4, Offset: 0x25b
// Size: 0x66
function init_brainrot_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level.brainrot_explosive_throttle = throttle::throttle_initialize( "brainrot_explosive_throttle", 2, level.framedurationseconds );
    utility::registersharedfunc( #"zombie", #"brainrot_zombie", &function_db66ee1da3481a55 );
    callback::add( "on_brainrot_end", &on_brainrot_end );
    level thread function_24ef459c2f18f02b();
}

// Namespace brainrot_augments
// Params 0
// Checksum 0x8714ec03, Offset: 0x2c9
// Size: 0x26
function function_24ef459c2f18f02b()
{
    level endon( #"game_ended" );
    utility::flag_wait( "brainrot_ready" );
    brainrot::register_brainrot_result_func( &function_db66ee1da3481a55 );
}

// Namespace brainrot_augments
// Params 11
// Checksum 0x219b0757, Offset: 0x2f7
// Size: 0x3e9, Type: bool
function function_db66ee1da3481a55( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, wasplague, var_ddd47269e5d6cd98, skip_augments = 0, force = 0 )
{
    var_801b8ba167677ba4 = level.gametypebundle.var_a2b029d0cb1a61cc ?? 15;
    
    if ( level.var_7c526b990a6af27b >= var_801b8ba167677ba4 && var_801b8ba167677ba4 != -1 )
    {
        return false;
    }
    
    if ( self.var_eb92c31552620100 )
    {
        return false;
    }
    
    if ( !isplayer( attacker ) )
    {
        return false;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    is_big_game = ai_tier == 3;
    has_big_game = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_big_game" );
    
    if ( !force && ( !ai_tier || is_big_game && !has_big_game ) )
    {
        return false;
    }
    
    var_5f7ae2b5f87aaea6 = brainrot::get_brainrot_time();
    
    if ( wasplague && !skip_augments )
    {
        var_5f7ae2b5f87aaea6 /= 2;
        
        if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_extension" ) )
        {
            if ( isdefined( level.zombie_augments[ #"brainrot_extension" ].var_86eaddfda83e0cb1 ) )
            {
                var_5f7ae2b5f87aaea6 += var_5f7ae2b5f87aaea6 * level.zombie_augments[ #"brainrot_extension" ].var_86eaddfda83e0cb1;
            }
        }
    }
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_extension" ) && !skip_augments )
    {
        if ( isdefined( level.zombie_augments[ #"brainrot_extension" ].var_86eaddfda83e0cb1 ) )
        {
            var_5f7ae2b5f87aaea6 += var_5f7ae2b5f87aaea6 * level.zombie_augments[ #"brainrot_extension" ].var_86eaddfda83e0cb1;
        }
    }
    
    if ( is_big_game )
    {
        var_5f7ae2b5f87aaea6 = 25;
    }
    
    if ( var_ddd47269e5d6cd98 && var_ddd47269e5d6cd98 != 0 )
    {
        var_5f7ae2b5f87aaea6 = var_ddd47269e5d6cd98;
    }
    
    if ( ai_tier == 2 || is_big_game )
    {
        success = namespace_59c416dec50ffbc3::charm( var_5f7ae2b5f87aaea6, attacker, &brainrot::function_f0be3019567210d, "toxic", 0 );
    }
    else
    {
        success = namespace_59c416dec50ffbc3::charm( var_5f7ae2b5f87aaea6, attacker, &brainrot::function_8259e310173767bd, "toxic" );
    }
    
    if ( !success )
    {
        return false;
    }
    
    self.var_cee2283e80076f90 = skip_augments;
    
    if ( isdefined( sweapon ) && attacker ammo_mod::get_ammo_mod_name( sweapon ) == "brainrot" && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_plague" ) )
    {
        self.var_bc3aafee8dfa99f5 = 1;
    }
    
    brainrot::function_a8dd3ca93248e895( attacker, sweapon, skip_augments );
    
    if ( !skip_augments )
    {
        try_brainrot_bloat( 0, attacker );
    }
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_irradiated" ) && !skip_augments )
    {
        utility::function_7c10ea82c1e305b8( "brainrot_irradiated", "brainrot_irradiated_on" );
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        irradiatedrange = level.zombie_augments[ #"brainrot_irradiated" ].var_b014cc459c5a064f ?? 150;
        irradiateddamage = level.zombie_augments[ #"brainrot_irradiated" ].var_5f5694a06b533464 ?? 0.25;
        irradiateddamage *= base_zombie_maxhealth;
        thread run_irradiated( irradiatedrange, irradiateddamage, attacker );
    }
    
    return true;
}

// Namespace brainrot_augments
// Params 3
// Checksum 0x4599e1cc, Offset: 0x6e9
// Size: 0x1ca
function run_irradiated( radius, damage, attacker )
{
    self endon( #"death" );
    damage = int( damage );
    
    if ( !isdefined( level.brainrot_irradiated_throttle ) )
    {
        level.brainrot_irradiated_throttle = throttle::throttle_initialize( "brainrot_irradiated_throttle", 2, level.framedurationseconds );
    }
    
    while ( isalive( self ) && zombie_utils::function_bf1464d09f4e4b40() )
    {
        zombies = getaiarrayinradius( self.origin, radius );
        
        foreach ( zombie in zombies )
        {
            if ( !isalive( zombie ) )
            {
                continue;
            }
            
            if ( attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( attacker, zombie ) )
                {
                    continue;
                }
            }
            
            if ( damage >= zombie.health )
            {
                if ( isplayer( attacker ) )
                {
                    attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"brain_rotted" );
                }
            }
            
            zombie dodamage( damage, self.origin, attacker, self, "MOD_ELEMENTAL_TOXIC", "<explicitweaponnone>", "none", undefined, 1073807360 );
            throttle::throttle_wait_in_queue( level.brainrot_irradiated_throttle, attacker );
        }
        
        wait 1;
    }
    
    if ( isalive( self ) )
    {
        utility::function_7c10ea82c1e305b8( "brainrot_irradiated", "brainrot_irradiated_off" );
    }
}

// Namespace brainrot_augments
// Params 2
// Checksum 0xf0e7454b, Offset: 0x8bb
// Size: 0x1ce
function try_brainrot_bloat( bforce = 0, attacker )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ( ai_tier == 1 || ai_tier == 2 ) && ( bforce || self.var_bd22ba6c600a23a3 utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_bloat" ) ) )
    {
        bloatduration = level.zombie_augments[ #"brainrot_bloat" ].var_c56743025bcd7463 ?? 5;
        bloatrange = level.zombie_augments[ #"brainrot_bloat" ].var_c9213b9d9b4023ec ?? 100;
        
        if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_extension" ) )
        {
            if ( isdefined( level.zombie_augments[ #"brainrot_extension" ].var_86eaddfda83e0cb1 ) )
            {
                bloatduration += bloatduration * ( level.zombie_augments[ #"brainrot_extension" ].var_86eaddfda83e0cb1 ?? 0.5 );
            }
        }
        
        self.brainrot_attractor = zombie_attractor_manager::add_attractor( self, 1, bloatrange, 0, undefined, &function_a2c55017fd65da9, 0, undefined, 1 );
        self.brainrot_attractor.var_9bc09bc79f28a18e = 1;
        self.var_8a4ce02f2bfc45a9 = 1;
        self playsound( #"hash_fd6f203e25c38c7" );
        
        if ( self getscriptableparthasstate( "brainrot", "brainrot_bloat" ) )
        {
            self setscriptablepartstate( "brainrot", "brainrot_bloat" );
        }
        
        namespace_27d28dc1345f6289::function_2cd238f58ce9245b( bloatduration, attacker );
        thread bloat_time( bloatduration );
    }
}

// Namespace brainrot_augments
// Params 1
// Checksum 0xd653bea9, Offset: 0xa91
// Size: 0x59
function bloat_time( duration )
{
    self endon( #"death" );
    wait duration;
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier == 1 )
    {
        brainrot::function_8259e310173767bd();
    }
    
    if ( isdefined( self.brainrot_attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.brainrot_attractor );
    }
}

// Namespace brainrot_augments
// Params 2
// Checksum 0xe2baa375, Offset: 0xaf2
// Size: 0x70, Type: bool
function function_a2c55017fd65da9( attractor, ai )
{
    if ( ai.var_840153567385cc6b )
    {
        return false;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier == 1 || ai_tier == 2 )
    {
        if ( ai.team != attractor.source.team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace brainrot_augments
// Params 1
// Checksum 0xb8dfabcf, Offset: 0xb6b
// Size: 0xde
function on_brainrot_end( sparams )
{
    if ( isdefined( self.brainrot_attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.brainrot_attractor );
    }
    
    val::reset( "brainrot", "ignoreme" );
    
    if ( !self.var_cee2283e80076f90 && isplayer( self.var_bd22ba6c600a23a3 ) && utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && self.var_bd22ba6c600a23a3 utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_explosive" ) )
    {
        thread function_236a1743295502c3( self.origin, self.var_bd22ba6c600a23a3 );
    }
    
    if ( self.type != "zombie" )
    {
        utility::function_32b24db3127bff40( "brainrot", "brainrot_off" );
    }
}

// Namespace brainrot_augments
// Params 2
// Checksum 0x9dbc70ba, Offset: 0xc51
// Size: 0x4a6
function function_236a1743295502c3( origin, attacker )
{
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier == 1 && isdefined( level._effect[ "brainrot_bloat_explosion" ] ) )
    {
        playfx( utility::getfx( "brainrot_bloat_explosion" ), self.origin );
    }
    else if ( ai_tier == 2 && isdefined( level._effect[ "brainrot_bloat_explosion_special" ] ) )
    {
        playfx( utility::getfx( "brainrot_bloat_explosion_special" ), self.origin );
    }
    else if ( isdefined( level._effect[ "brainrot_bloat_explosion_elite" ] ) )
    {
        playfx( utility::getfx( "brainrot_bloat_explosion_elite" ), self.origin );
    }
    
    var_375c3e35770652f = 0;
    var_d989e66c36010212 = level.zombie_augments[ #"brainrot_explosive" ].var_6c93be7b5aeea11b ?? 256;
    zombies = getaiarrayinradius( origin, var_d989e66c36010212 );
    explosionorigin = self.origin;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    self playsound( #"hash_d39cf00849bc884a" );
    
    foreach ( zombie in zombies )
    {
        if ( zombie == self || !isalive( zombie ) )
        {
            continue;
        }
        
        if ( attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( attacker, zombie ) )
            {
                continue;
            }
        }
        
        distance2d = distance2d( origin, zombie.origin );
        var_8bd444d2097f426c = max( ( var_d989e66c36010212 - distance2d ) / var_d989e66c36010212, 0 );
        damage = int( math::remap( var_8bd444d2097f426c, 0, 1, base_zombie_maxhealth / 2, base_zombie_maxhealth ) );
        
        if ( zombie.health - damage <= 0 )
        {
            zombie.var_bd22ba6c600a23a3 = attacker;
        }
        
        zombie dodamage( damage, origin, attacker, self, "MOD_ELEMENTAL_TOXIC", "<explicitweaponnone>", "none", undefined, 1073807360 );
        throttle::throttle_wait_in_queue( level.brainrot_explosive_throttle, attacker );
    }
    
    nearbyplayers = getplayersinradius( self.origin, 256 );
    
    foreach ( nearbyplayer in nearbyplayers )
    {
        nearbyplayer playrumbleonentity( "damage_light" );
        nearbyplayer earthquakeforplayer( 0.5, 0.75, self.origin, 500 );
    }
    
    waitframe();
    waitframe();
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) && !zombie.var_33df89471a965163 )
        {
            zombie.var_33df89471a965163 = 1;
            var_24ed309d808c077a = zombie getcorpseentity();
            
            if ( isdefined( var_24ed309d808c077a ) && var_375c3e35770652f < 6 )
            {
                v_dir = vectornormalize( var_24ed309d808c077a.origin - explosionorigin );
                launchx = clamp( v_dir[ 0 ] * 5000, -5000, 5000 );
                launchy = clamp( v_dir[ 1 ] * 5000, -5000, 5000 );
                launchz = clamp( ( v_dir[ 2 ] + 150 ) * 5000, 0, 5000 );
                v_launch = ( launchx, launchy, launchz );
                var_24ed309d808c077a startragdollfromimpact( "torso_upper", v_launch );
                var_375c3e35770652f++;
            }
        }
    }
}

