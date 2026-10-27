// scripts\mp\ammomods\cryofreeze.gsc  (hash_70f7beddf801a87e.gscc) (size: 8063 Bytes / 0x1f7f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x646933a (105288506)
// size ...... 8063 (0x1f7f)
// includes .. 12  (offset: 0x1d37)
// strings ... 19  (offset: 0x1d97)
// dev strs .. 5   (offset: 0x1f43)
// exports ... 20  (offset: 0x125f)
// cseg ...... 0x18e + 0x10d1 (0x125f)
// imports ... 64  (offset: 0x157f)
// animtree1 . 0   (offset: 0x1f7f)
// animtree2 . 0   (offset: 0x1f7f)
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ammomods\ammo_mod;

#namespace cryofreeze;

// Namespace cryofreeze
// Params 0, eflags: 0x5
// Checksum 0x33ac1344, Offset: 0x1ac
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "cryofreeze", undefined, &__init__, undefined );
}

// Namespace cryofreeze
// Params 0
// Checksum 0x4f9fcb0f, Offset: 0x1c9
// Size: 0xa
function __init__()
{
    level thread function_2dca745acf501d9f();
}

// Namespace cryofreeze
// Params 0
// Checksum 0xe64e30ac, Offset: 0x1db
// Size: 0x214
function function_2dca745acf501d9f()
{
    cryofreezebundle = level.var_b7d9d7926154819d.ammomodbundles[ "cryofreeze" ];
    
    if ( !isdefined( cryofreezebundle ) )
    {
        return;
    }
    
    level._effect[ "cryofreeze_impact" ] = loadfxasset( cryofreezebundle.var_69eb0504a891280a );
    
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    utility::flag_wait( "ammo_mods_ready" );
    utility::flag_init( "cryofreeze_ready" );
    procpercent = cryofreezebundle.procpercent ?? 0.25;
    var_a3e31d9c9d0c8ca6 = cryofreezebundle.var_9225566c1a61c6ca ?? 0.1;
    cooldownentity = cryofreezebundle.cooldownentity ?? 0;
    cooldownattacker = cryofreezebundle.cooldownattacker ?? 0;
    cooldownglobal = cryofreezebundle.cooldownglobal ?? 1;
    var_92c00cb857963986 = cryofreezebundle.occursondeath ?? 1;
    var_2d38a15555828531 = cryofreezebundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = cryofreezebundle.var_1c73b60ea00808df ?? "";
    element = cryofreezebundle.element ?? "cold";
    level.var_ed9894d5528f0838 = [];
    level.var_a97ed0e369675a2a = [];
    ammo_mod::register_ammo_mod( "cryofreeze", cryofreezebundle.id ?? 2, 0.25, 0.1, 0, 0, 1, 1, &function_2b4e21cd892a0ec4, "", "", &function_4d9b73d22509b99a, "cold" );
    zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    agent_utils::register_soldier_damage_callback( &function_17fdfda41f9aa95a );
    callback::add( #"on_ai_killed", &on_cryofreeze_kill );
    utility::flag_set( "cryofreeze_ready" );
    
    /#
        level thread setup_cryofreeze_devgui();
    #/
}

// Namespace cryofreeze
// Params 1
// Checksum 0x763cc4f4, Offset: 0x3f7
// Size: 0x23
function register_cryofreeze_result_func( func )
{
    level.var_ed9894d5528f0838[ level.var_ed9894d5528f0838.size ] = func;
}

// Namespace cryofreeze
// Params 1
// Checksum 0x1dc46d2e, Offset: 0x422
// Size: 0x23
function register_cryofreeze_validation_func( func )
{
    level.var_a97ed0e369675a2a[ level.var_a97ed0e369675a2a.size ] = func;
}

// Namespace cryofreeze
// Params 1
// Checksum 0xf65569f4, Offset: 0x44d
// Size: 0x1dc
function function_2b4e21cd892a0ec4( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    
    if ( utility::ent_flag( "cryofreeze_active" ) || utility::ent_flag( "frost_blast_active" ) )
    {
        return;
    }
    
    if ( level.var_ed9894d5528f0838.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_ed9894d5528f0838 )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
        }
    }
    else
    {
        thread function_2c6acf2c700ce10c( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
    }
    
    sparams = spawnstruct();
    sparams.death = death;
    sparams.attacker = attacker;
    sparams.mod = mod;
    sparams.sweapon = sweapon;
    sparams.vpoint = vpoint;
    sparams.shitloc = shitloc;
    sparams.modelindex = modelindex;
    callback::callback( "on_cryofreeze_proc", sparams );
}

// Namespace cryofreeze
// Params 10
// Checksum 0x1d8d3cd8, Offset: 0x631
// Size: 0x378
function function_2c6acf2c700ce10c( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_363e132bd47a1fc2, var_6f00244ca8efd0cc, ignorevfx )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    ai_tier = ai_utility::get_ai_tier();
    is_big_game = ai_tier == 3;
    has_big_game = isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"cryofreeze_big_game" );
    var_59fb39487166f319 = ai_tier == 1 || ai_tier == 2 || is_big_game && has_big_game;
    
    if ( !var_59fb39487166f319 )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        utility::ent_flag_init( "cryofreeze_active" );
        utility::ent_flag_set( "cryofreeze_active" );
        self.var_e957ff879042cc5f = attacker;
        callback::callback( "on_enemy_cryofreeze", { #attacker:attacker } );
    }
    
    waitframe();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    playfx( utility::getfx( "cryofreeze_impact" ), vpoint );
    thread function_9bffdecb8a0a3a1e();
    cryofreezetime = level.var_b7d9d7926154819d.ammomodbundles[ "cryofreeze" ].ammomodduration ?? 5;
    var_1c05f68547f28c32 = level.var_b7d9d7926154819d.ammomodbundles[ "cryofreeze" ].var_b0fbadc22159932a ?? 0.5;
    cryofreezetime = var_363e132bd47a1fc2 ?? cryofreezetime;
    var_1c05f68547f28c32 = var_6f00244ca8efd0cc ?? var_1c05f68547f28c32;
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"cryofreeze_full_frost" ) )
    {
        if ( level.zombie_augments[ #"cryofreeze_full_frost" ].var_214081cd0d3cff45 )
        {
            if ( zombie_vehicle_attack::is_in_vehicle_attack() )
            {
                zombie_vehicle_attack::function_b6b04d95c27e889b( 0 );
                zombie_vehicle_attack::function_22391ae9d7a28a94( 1 );
            }
            else
            {
                val::set( "cryofreeze", "ignoreall", 1 );
            }
            
            var_1c05f68547f28c32 = 0.0001;
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"cryofreeze_extension" ) )
    {
        if ( isdefined( level.zombie_augments[ #"cryofreeze_extension" ].var_4f33ad360c40c03a ) )
        {
            cryofreezetime += cryofreezetime * ( level.zombie_augments[ #"cryofreeze_extension" ].var_4f33ad360c40c03a ?? 0.15 );
        }
    }
    
    utility::ent_flag_init( "cryofreeze_active" );
    utility::ent_flag_set( "cryofreeze_active" );
    
    if ( true )
    {
        self.var_e957ff879042cc5f = attacker;
        self.var_6315a92bfb008cb6 = sweapon;
        self.var_bb4d607514eb37ce = "_cfreeze";
        effect_slow::slow( "cryofreeze", var_1c05f68547f28c32, cryofreezetime, attacker, &function_cb9164f240124e13, undefined, "cold" );
        return;
    }
    
    utility::delaythreadendon( cryofreezetime, "death", &utility::ent_flag_clear, "cryofreeze_active" );
    utility::delaythreadendon( cryofreezetime, "death", &utility::function_7c10ea82c1e305b8, "cryofreeze", "cryofreeze_shatter" );
}

// Namespace cryofreeze
// Params 11
// Checksum 0x30b9bdb, Offset: 0x9b1
// Size: 0x259
function function_78dcfeb8fef113fb( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_363e132bd47a1fc2, var_6f00244ca8efd0cc, ignorevfx, var_5bdd577455ff633e )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    ai_tier = var_5bdd577455ff633e.var_2a910b69b3bb40ff ? self [[ var_5bdd577455ff633e.var_2a910b69b3bb40ff ]]() : ai_utility::get_ai_tier();
    
    if ( !( ai_tier == 1 || ai_tier == 2 || var_5bdd577455ff633e.var_15b287b00f8a004a && ai_tier == 3 ) )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        utility::ent_flag_init( "cryofreeze_active" );
        utility::ent_flag_set( "cryofreeze_active" );
        self.var_e957ff879042cc5f = attacker;
        self.var_6315a92bfb008cb6 = sweapon;
        callback::callback( "on_enemy_cryofreeze", { #attacker:attacker } );
    }
    
    waitframe();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    playfx( utility::getfx( "cryofreeze_impact" ), vpoint );
    thread function_9bffdecb8a0a3a1e();
    cryofreezetime = level.var_b7d9d7926154819d.ammomodbundles[ "cryofreeze" ].ammomodduration ?? 5;
    var_1c05f68547f28c32 = level.var_b7d9d7926154819d.ammomodbundles[ "cryofreeze" ].var_b0fbadc22159932a ?? 0.5;
    cryofreezetime = var_363e132bd47a1fc2 ?? cryofreezetime;
    var_1c05f68547f28c32 = var_6f00244ca8efd0cc ?? var_1c05f68547f28c32;
    utility::ent_flag_init( "cryofreeze_active" );
    utility::ent_flag_set( "cryofreeze_active" );
    
    if ( true )
    {
        self.var_e957ff879042cc5f = attacker;
        self.var_bb4d607514eb37ce = "_cfreeze";
        effect_slow::slow( "cryofreeze", var_1c05f68547f28c32, cryofreezetime, attacker, &function_cb9164f240124e13, undefined, "cold", var_5bdd577455ff633e.var_a918ba3f449dc3e8 );
        return;
    }
    
    utility::delaythreadendon( cryofreezetime, "death", &utility::ent_flag_clear, "cryofreeze_active" );
    utility::delaythreadendon( cryofreezetime, "death", &utility::function_7c10ea82c1e305b8, "cryofreeze", "cryofreeze_shatter" );
}

// Namespace cryofreeze
// Params 0
// Checksum 0x70118baa, Offset: 0xc12
// Size: 0x113, Type: bool
function function_4d9b73d22509b99a()
{
    if ( level.ammo_mods[ "cryofreeze" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    var_59fb39487166f319 = ai_tier == 1 || ai_tier == 2 || ai_tier == 3;
    
    if ( var_59fb39487166f319 && !effect_slow::function_64adf2cc9d3408ad() )
    {
        return false;
    }
    
    if ( isdefined( self.var_57b29d5bfab580c2 ) )
    {
        failcryofreeze = [[ self.var_57b29d5bfab580c2 ]]();
        
        if ( !failcryofreeze )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_a97ed0e369675a2a )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace cryofreeze
// Params 0
// Checksum 0x88db5bbc, Offset: 0xd2e
// Size: 0x12, Type: bool
function get_is_slowed()
{
    return status_effects::function_fa35fc2723e956eb( "slow", "cryofreeze" );
}

// Namespace cryofreeze
// Params 1
// Checksum 0x326090d9, Offset: 0xd49
// Size: 0x10f
function function_cb9164f240124e13( effect_payload )
{
    sparams = spawnstruct();
    sparams.attacker = self.var_e957ff879042cc5f;
    sparams.sweapon = self.var_6315a92bfb008cb6;
    sparams.normaldamage = effect_payload.var_c8e8a716bddec82a;
    sparams.var_b9b58463138b2998 = effect_payload.var_cb3dac5950a83986;
    sparams.elitedamage = effect_payload.var_c4f96328fd4914a2;
    sparams.var_2a910b69b3bb40ff = effect_payload.var_2a910b69b3bb40ff;
    callback::callback( "on_cryofreeze_end", sparams );
    
    if ( zombie_vehicle_attack::is_in_vehicle_attack() )
    {
        zombie_vehicle_attack::function_b6b04d95c27e889b( 1 );
        zombie_vehicle_attack::function_22391ae9d7a28a94( 0 );
    }
    else
    {
        val::reset( "cryofreeze", "ignoreall" );
    }
    
    utility::ent_flag_clear( "cryofreeze_active" );
    self.var_e957ff879042cc5f = undefined;
    self.var_6315a92bfb008cb6 = undefined;
    self.var_bb4d607514eb37ce = undefined;
    function_71e89e659a9c9031();
}

// Namespace cryofreeze
// Params 0
// Checksum 0x842d4bd2, Offset: 0xe60
// Size: 0x4f
function function_9bffdecb8a0a3a1e()
{
    level endon( #"game_ended" );
    
    if ( self isscriptable() && self getscriptablehaspart( "cryofreeze" ) )
    {
        utility::function_7c10ea82c1e305b8( "cryofreeze", "cryofreeze_off" );
        waitframe();
        
        if ( isalive( self ) )
        {
            utility::function_7c10ea82c1e305b8( "cryofreeze", "cryofreeze_on" );
        }
    }
}

// Namespace cryofreeze
// Params 0
// Checksum 0x565065a4, Offset: 0xeb7
// Size: 0x2a
function function_71e89e659a9c9031()
{
    if ( self.var_8190876e151c62c9 )
    {
        self.var_8190876e151c62c9 = 0;
        return;
    }
    
    utility::function_7c10ea82c1e305b8( "cryofreeze", "cryofreeze_shatter" );
}

// Namespace cryofreeze
// Params 2
// Checksum 0xd033377b, Offset: 0xee9
// Size: 0x5b
function function_c239c417df47d199( str_label, str_tag )
{
    level endon( #"game_ended" );
    waitframe();
    fx = utility::getfx( str_label );
    
    if ( isalive( self ) )
    {
        stopfxontag( fx, self, str_tag );
    }
    
    waitframe();
    
    if ( isalive( self ) )
    {
        playfxontag( fx, self, str_tag );
    }
}

// Namespace cryofreeze
// Params 1
// Checksum 0x576a8889, Offset: 0xf4c
// Size: 0x138
function function_17fdfda41f9aa95a( params )
{
    if ( utility::ent_flag( "cryofreeze_active" ) && isplayer( params.eattacker ) )
    {
        damage = get_slow_damage( params.idamage, params.eattacker, params.smeansofdeath, params.shitloc, params.sweapon );
        
        if ( utility::issharedfuncdefined( #"zombie", #"hash_6104e890a5cf3101" ) && utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"cryofreeze_damage_boost" ) )
        {
            damageboost = utility::callsharedfunc( #"zombie", #"hash_6104e890a5cf3101", #"cryofreeze_damage_boost" );
            damage += damage * ( damageboost ?? 0.1 );
        }
        
        if ( damage >= self.health )
        {
            utility::ent_flag_set( "frost_killed" );
        }
        
        return damage;
    }
    
    return -1;
}

// Namespace cryofreeze
// Params 1
// Checksum 0x5a298cdc, Offset: 0x108d
// Size: 0x7b
function on_cryofreeze_kill( params )
{
    if ( isagent( self ) && isplayer( params.eattacker ) && utility::ent_flag( "cryofreeze_active" ) )
    {
        if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
        {
            params.eattacker utility::callsharedfunc( #"medal", #"track_rapid_kill", "cryofreeze" );
        }
    }
}

// Namespace cryofreeze
// Params 5
// Checksum 0xd195e006, Offset: 0x1110
// Size: 0x6f
function get_slow_damage( idamage, eattacker, smeansofdeath, shitloc, sweapon )
{
    cryofreezedamagemultiplier = level.var_b7d9d7926154819d.ammomodbundles[ "cryofreeze" ].cryofreezedamagemultiplier ?? 1.25;
    idamage = cryofreezedamagemultiplier * idamage;
    return idamage;
}

/#

    // Namespace cryofreeze
    // Params 0
    // Checksum 0xde5983b2, Offset: 0x1188
    // Size: 0xa0, Type: dev
    function function_ed0611873d881f36()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x24>" );
            player iprintlnbold( "<dev string:x2f>" );
        }
    }

    // Namespace cryofreeze
    // Params 0
    // Checksum 0x2230cc87, Offset: 0x1230
    // Size: 0x2f, Type: dev
    function setup_cryofreeze_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x48>" );
        devgui::add_devgui_func( "<dev string:x59>", "<dev string:x6a>", &function_ed0611873d881f36, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
