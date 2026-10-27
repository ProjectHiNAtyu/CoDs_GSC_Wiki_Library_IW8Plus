// scripts\mp\ammomods\brainrot.gsc  (hash_7b7f99557a837539.gscc) (size: 9658 Bytes / 0x25ba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85ebf338 (2246832952)
// size ...... 9658 (0x25ba)
// includes .. 13  (offset: 0x233e)
// strings ... 26  (offset: 0x23a6)
// dev strs .. 5   (offset: 0x257e)
// exports ... 20  (offset: 0x1792)
// cseg ...... 0x217 + 0x157b (0x1792)
// imports ... 71  (offset: 0x1ab2)
// animtree1 . 0   (offset: 0x25ba)
// animtree2 . 0   (offset: 0x25ba)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_charm;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\ammo_mod;

#namespace brainrot;

// Namespace brainrot
// Params 0, eflags: 0x5
// Checksum 0xb0a0334b, Offset: 0x235
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "brainrot", undefined, &__init__, undefined );
}

// Namespace brainrot
// Params 0
// Checksum 0x952fbed8, Offset: 0x252
// Size: 0xa
function __init__()
{
    level thread function_110ef6aab454db38();
}

// Namespace brainrot
// Params 0
// Checksum 0x6eff9a9b, Offset: 0x264
// Size: 0x341
function function_110ef6aab454db38()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    brainrotbundle = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ];
    
    if ( !isdefined( brainrotbundle ) )
    {
        return;
    }
    
    utility::flag_wait( "ammo_mods_ready" );
    utility::flag_init( "brainrot_ready" );
    procpercent = getdvarfloat( @"scr_brainrot_percent", brainrotbundle.procpercent ?? 0.15 );
    var_a3e31d9c9d0c8ca6 = getdvarfloat( @"hash_7a0b932dc704d890", brainrotbundle.var_9225566c1a61c6ca ?? 0.03 );
    cooldownentity = getdvarfloat( @"hash_48bb866e33cc0a98", brainrotbundle.cooldownentity ?? 0 );
    cooldownattacker = getdvarfloat( @"hash_b274fefae7b30b9c", brainrotbundle.cooldownattacker ?? 40 );
    cooldownglobal = getdvarfloat( @"hash_73abd79b8e6537b4", brainrotbundle.cooldownglobal ?? 5 );
    var_92c00cb857963986 = getdvarint( @"scr_brainrot_occurs_on_death", brainrotbundle.occursondeath ?? 1 );
    var_2d38a15555828531 = brainrotbundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = brainrotbundle.var_1c73b60ea00808df ?? "";
    element = brainrotbundle.element ?? "toxic";
    
    if ( isdefined( brainrotbundle.var_249a3c10e04d102e ) )
    {
        level._effect[ "vfx_t10_gameplay_zm_ai_zai_explo_aoe_brain_rot" ] = loadfxasset( brainrotbundle.var_5b37412bbe77f21e );
    }
    
    if ( isdefined( brainrotbundle.var_569668107b9673ef ) )
    {
        level._effect[ "brainrot_elite_explosion" ] = loadfxasset( brainrotbundle.var_569668107b9673ef );
    }
    
    if ( isdefined( brainrotbundle.var_249a3c10e04d102e ) )
    {
        level._effect[ "brainrot_bloat_explosion" ] = loadfxasset( brainrotbundle.var_249a3c10e04d102e );
    }
    
    if ( isdefined( brainrotbundle.var_3a9f1a8e7ba365ed ) )
    {
        level._effect[ "brainrot_bloat_explosion_special" ] = loadfxasset( brainrotbundle.var_3a9f1a8e7ba365ed );
    }
    
    if ( isdefined( brainrotbundle.var_1570f962fb95286d ) )
    {
        level._effect[ "brainrot_bloat_explosion_elite" ] = loadfxasset( brainrotbundle.var_1570f962fb95286d );
    }
    
    level.var_7c526b990a6af27b = 0;
    
    if ( !isdefined( level.var_16a47224d339782d ) )
    {
        level.var_16a47224d339782d = [];
    }
    
    if ( !isdefined( level.var_4e35a25e6239e87b ) )
    {
        level.var_4e35a25e6239e87b = [];
    }
    
    level callback::add( #"on_ai_killed", &brainrot_on_ai_killed );
    ammo_mod::register_ammo_mod( "brainrot", brainrotbundle.id ?? 1, procpercent, var_a3e31d9c9d0c8ca6, cooldownentity, cooldownattacker, cooldownglobal, var_92c00cb857963986, &function_9528776cfa1c472f, var_2d38a15555828531, var_1c73b60ea00808df, &function_49ffc995621dbc95, element );
    utility::flag_set( "brainrot_ready" );
    utility::registersharedfunc( #"brainrot", #"hash_a8325ae4a081c092", &function_49ffc995621dbc95 );
    
    /#
        level thread setup_brainrot_devgui();
    #/
}

// Namespace brainrot
// Params 1
// Checksum 0xd9fdd494, Offset: 0x5ad
// Size: 0x39
function register_brainrot_result_func( func )
{
    if ( !isdefined( level.var_16a47224d339782d ) )
    {
        level.var_16a47224d339782d = [];
    }
    
    level.var_16a47224d339782d[ level.var_16a47224d339782d.size ] = func;
}

// Namespace brainrot
// Params 1
// Checksum 0xacc82687, Offset: 0x5ee
// Size: 0x39
function register_brainrot_validation_func( func )
{
    if ( !isdefined( level.var_4e35a25e6239e87b ) )
    {
        level.var_4e35a25e6239e87b = [];
    }
    
    level.var_4e35a25e6239e87b[ level.var_4e35a25e6239e87b.size ] = func;
}

// Namespace brainrot
// Params 1
// Checksum 0xa5f334eb, Offset: 0x62f
// Size: 0x9c
function function_8c9337fec8ea11f( func )
{
    foreach ( exist_func in level.var_4e35a25e6239e87b )
    {
        if ( func == exist_func )
        {
            level.var_4e35a25e6239e87b = arrayremove( level.var_4e35a25e6239e87b, func );
            return;
        }
    }
}

// Namespace brainrot
// Params 0
// Checksum 0x68a4732b, Offset: 0x6d3
// Size: 0x38
function get_brainrot_time()
{
    var_5f7ae2b5f87aaea6 = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].ammomodduration ?? 15;
    return var_5f7ae2b5f87aaea6;
}

// Namespace brainrot
// Params 0
// Checksum 0x51f9e383, Offset: 0x714
// Size: 0x38
function get_brainrot_kill_limit()
{
    var_98bf31502b3ca422 = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_98bf31502b3ca422 ?? 6;
    return var_98bf31502b3ca422;
}

// Namespace brainrot
// Params 0
// Checksum 0xb8b57773, Offset: 0x755
// Size: 0x28
function function_529ec219117c3ac2()
{
    var_801b8ba167677ba4 = level.gametypebundle.var_a2b029d0cb1a61cc ?? 15;
    return var_801b8ba167677ba4;
}

// Namespace brainrot
// Params 1
// Checksum 0x32fdc465, Offset: 0x786
// Size: 0x139
function function_9528776cfa1c472f( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    
    if ( level.var_16a47224d339782d.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_16a47224d339782d )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
        }
        
        return;
    }
    
    function_2fa96fd205e9d8f7( attacker, sweapon );
}

// Namespace brainrot
// Params 2
// Checksum 0x325cebd1, Offset: 0x8c7
// Size: 0x11e
function function_2fa96fd205e9d8f7( attacker, sweapon )
{
    var_801b8ba167677ba4 = level.gametypebundle.var_a2b029d0cb1a61cc ?? 15;
    
    if ( level.var_7c526b990a6af27b >= var_801b8ba167677ba4 && var_801b8ba167677ba4 != -1 )
    {
        return;
    }
    
    if ( !isplayer( attacker ) || !isalive( self ) )
    {
        return;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    is_big_game = ai_tier == 3;
    has_big_game = attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_big_game" );
    var_5f7ae2b5f87aaea6 = get_brainrot_time();
    
    if ( ai_tier == 2 || is_big_game )
    {
        success = effect_charm::charm( var_5f7ae2b5f87aaea6, attacker, &function_f0be3019567210d, "toxic", 0 );
    }
    else if ( ai_tier == 1 )
    {
        success = effect_charm::charm( var_5f7ae2b5f87aaea6, attacker, &function_8259e310173767bd, "toxic" );
    }
    
    if ( success )
    {
        function_a8dd3ca93248e895( attacker, sweapon );
    }
}

// Namespace brainrot
// Params 3
// Checksum 0x2ed25a8c, Offset: 0x9ed
// Size: 0x3cc
function function_a8dd3ca93248e895( attacker, sweapon, skip_augments = 0 )
{
    assert( isai( self ) );
    self._blackboard.var_ea5eb773cb969ee1 = 1;
    self._blackboard.brainrotowner = attacker;
    self._blackboard.var_3144a4e051a50472 = 500;
    attacker.brainrottedzombie = self;
    self.ignore_enemy_count = 1;
    level.var_7c526b990a6af27b++;
    self function_fa32376aaa88a7a2( attacker.origin, 2000 );
    val::set( "brainrot", "ignoreme", 1 );
    self disableaimassist();
    params = spawnstruct();
    params.attacker = attacker;
    self.var_bd22ba6c600a23a3 = attacker;
    ai_tier = ai_utility::get_ai_tier();
    utility::function_7c10ea82c1e305b8( "icon", "active_brainrot" );
    
    if ( sweapon )
    {
        self.var_6d31abe6b171ada8 = sweapon;
    }
    else if ( isplayer( attacker ) )
    {
        self.var_6d31abe6b171ada8 = attacker getcurrentweapon();
    }
    
    enemiesarray = [ self ];
    level notify( #"highvis_reload_outline", attacker.team, enemiesarray, 1 );
    self setsafeguardent( attacker );
    self setsafeguardrange( 100 );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zombie_utils::get_zombie_round_difficulty() );
    var_e4b17a51430e8fa5 = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_79ee00753258f705 ?? 0.5;
    var_afe71cbf6df8b2c9 = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_4f81d183aac26f25 ?? 2;
    var_172e08a154e4fddd = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_803c1fd06889eca5 ?? 2;
    var_29f2cb5ee0852502 = 0;
    
    if ( !skip_augments && isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_more_damage" ) )
    {
        var_db8854d93beb49c7 = 1;
        var_29f2cb5ee0852502 = level.zombie_augments[ #"brainrot_more_damage" ].var_2ccdfad329f73c24 ?? 0.5;
        var_29f2cb5ee0852502 *= base_zombie_maxhealth;
    }
    
    if ( ai_tier == 1 )
    {
        self.var_cab75db7e9e5b64c = base_zombie_maxhealth * var_e4b17a51430e8fa5;
        
        if ( var_29f2cb5ee0852502 != 0 )
        {
            self.var_cab75db7e9e5b64c += var_29f2cb5ee0852502;
        }
    }
    else if ( ai_tier == 2 )
    {
        self.var_cab75db7e9e5b64c = base_zombie_maxhealth * var_afe71cbf6df8b2c9;
        
        if ( var_29f2cb5ee0852502 != 0 )
        {
            self.var_cab75db7e9e5b64c += var_29f2cb5ee0852502;
        }
    }
    else if ( ai_tier == 3 )
    {
        self.var_cab75db7e9e5b64c = base_zombie_maxhealth * var_172e08a154e4fddd;
        
        if ( var_29f2cb5ee0852502 != 0 )
        {
            self.var_cab75db7e9e5b64c += var_29f2cb5ee0852502;
        }
    }
    
    if ( isplayer( attacker ) )
    {
        attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"brain_rotted" );
    }
    
    if ( !isdefined( attacker.brainrotted_ai_count ) )
    {
        attacker.brainrotted_ai_count = 0;
    }
    
    attacker.brainrotted_ai_count = int( attacker.brainrotted_ai_count + 1 );
    self.var_7406c56074db89d1 = 0;
    callback::callback( "on_turned", params );
    
    if ( self.type != "zombie" )
    {
        utility::function_32b24db3127bff40( "brainrot", "brainrot_on" );
    }
}

// Namespace brainrot
// Params 0
// Checksum 0x5ca466d2, Offset: 0xdc1
// Size: 0x1d
function function_ffef2a9f046cf585()
{
    waitframe();
    
    if ( isalive( self ) )
    {
        self.health = self.maxhealth;
    }
}

// Namespace brainrot
// Params 0
// Checksum 0xf23c4182, Offset: 0xde6
// Size: 0x119, Type: bool
function function_49ffc995621dbc95()
{
    if ( level.ammo_mods[ "brainrot" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    if ( self.disable_brain_rot )
    {
        return false;
    }
    
    if ( isdefined( self.var_8ec107c571aa0b8d ) )
    {
        var_9025d0b7c1f4fc6f = [[ self.var_8ec107c571aa0b8d ]]();
        
        if ( !var_9025d0b7c1f4fc6f )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_4e35a25e6239e87b )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    if ( !val::get( "allow_brot" ) )
    {
        return false;
    }
    
    var_5d2be2573d1e49a3 = function_529ec219117c3ac2();
    
    if ( level.var_7c526b990a6af27b >= var_5d2be2573d1e49a3 && var_5d2be2573d1e49a3 != -1 )
    {
        return false;
    }
    
    return true;
}

// Namespace brainrot
// Params 0
// Checksum 0xa583b78, Offset: 0xf08
// Size: 0x3fd
function function_f0be3019567210d()
{
    callback::callback( "on_brainrot_end" );
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "icon", "active" );
    utility::function_32b24db3127bff40( "brainrot", "brainrot_off" );
    
    if ( isdefined( self._blackboard ) )
    {
        self._blackboard.var_ea5eb773cb969ee1 = 0;
        self._blackboard.brainrotowner = undefined;
    }
    
    if ( isplayer( self.var_bd22ba6c600a23a3 ) )
    {
        self.var_bd22ba6c600a23a3.var_cca0c8973424675a[ "brainrot" ] = gettime() / 1000;
        self.var_bd22ba6c600a23a3.brainrottedzombie = undefined;
        oldattacker = self.var_bd22ba6c600a23a3;
        oldweapon = self.var_6d31abe6b171ada8;
    }
    
    self.var_bd22ba6c600a23a3 = undefined;
    self.var_6d31abe6b171ada8 = undefined;
    self.ignore_enemy_count = 0;
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier == 3 )
    {
        if ( isdefined( level._effect[ "brainrot_elite_explosion" ] ) )
        {
            playfx( utility::getfx( "brainrot_elite_explosion" ), self.origin );
        }
    }
    else if ( isdefined( level._effect[ "vfx_t10_gameplay_zm_ai_zai_explo_aoe_brain_rot" ] ) )
    {
        playfx( utility::getfx( "vfx_t10_gameplay_zm_ai_zai_explo_aoe_brain_rot" ), self.origin );
    }
    
    self.ignore_enemy_count = 0;
    level.var_7c526b990a6af27b--;
    self.ignoreme = 0;
    self enableaimassist();
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zombie_utils::get_zombie_round_difficulty() );
    
    if ( self.var_b25073734ba2cd70 == "elite" && isplayer( oldattacker ) && oldattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"brainrot_big_game" ) )
    {
        base_zombie_maxhealth *= 4;
    }
    else if ( ai_tier == 2 && isdefined( level._effect[ "brainrot_bloat_explosion_special" ] ) )
    {
        playfx( utility::getfx( "brainrot_bloat_explosion_special" ), self.origin );
    }
    else if ( ai_tier == 3 && isdefined( level._effect[ "brainrot_bloat_explosion_elite" ] ) )
    {
        playfx( utility::getfx( "brainrot_bloat_explosion_elite" ), self.origin );
    }
    else if ( isdefined( level._effect[ "brainrot_bloat_explosion" ] ) )
    {
        playfx( utility::getfx( "brainrot_bloat_explosion" ), self.origin );
    }
    else
    {
        base_zombie_maxhealth *= 4;
    }
    
    if ( self.health - base_zombie_maxhealth <= 0 )
    {
        self.var_bd22ba6c600a23a3 = oldattacker;
        self.var_6d31abe6b171ada8 = oldweapon;
    }
    else
    {
        zombie_vox::function_5ac4bed4a907abf5( "pain" );
    }
    
    if ( self.health - base_zombie_maxhealth < 1 )
    {
        self.var_e797f68de73ece4e = "_brot";
    }
    
    self dodamage( base_zombie_maxhealth, self.origin, self.var_bd22ba6c600a23a3, self.var_bd22ba6c600a23a3, "MOD_ELEMENTAL_TOXIC" );
    
    if ( isalive( self ) )
    {
        enemiesarray = [ self ];
        level notify( #"highvis_reload_outline", undefined, enemiesarray );
        stuntime = level.var_b7d9d7926154819d.ammomodbundles[ "brainrot" ].var_766c909cf279415 ?? 2;
        
        if ( self.type == "zombie" )
        {
            zombie_stun::stun_ai( stuntime );
            return;
        }
        
        if ( self.type == "human" )
        {
            if ( isplayer( oldattacker ) )
            {
                self notify( #"flashbang", self.origin, 1, undefined, oldattacker, oldattacker.team, stuntime );
                return;
            }
            
            self notify( #"flashbang", self.origin, 1, undefined, undefined, undefined, stuntime );
        }
    }
}

// Namespace brainrot
// Params 0
// Checksum 0xfe6ccb4b, Offset: 0x130d
// Size: 0x1c8
function function_8259e310173767bd()
{
    if ( isplayer( self.var_bd22ba6c600a23a3 ) )
    {
        self.var_bd22ba6c600a23a3.brainrottedzombie = undefined;
        self.var_bd22ba6c600a23a3.var_cca0c8973424675a[ "brainrot" ] = gettime() / 1000;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    callback::callback( "on_brainrot_end" );
    
    if ( self.var_923fd785fff9159b )
    {
        return;
    }
    
    if ( self.type != "zombie" )
    {
        utility::function_32b24db3127bff40( "brainrot", "brainrot_off" );
    }
    
    if ( isdefined( level._effect[ "vfx_t10_gameplay_zm_ai_zai_explo_aoe_brain_rot" ] ) )
    {
        playfx( utility::getfx( "vfx_t10_gameplay_zm_ai_zai_explo_aoe_brain_rot" ), self.origin );
    }
    
    var_efb2a1ee83e59eef = !self.magic_bullet_shield && !self.damageshield && ( self.type == "zombie" || self.type == "human" ) && isalive( self ) && self.health > 0 && !self.codecallback_killed;
    
    if ( var_efb2a1ee83e59eef )
    {
        self.forceannihilate = 1;
        self.var_e797f68de73ece4e = "_brot";
        
        if ( isplayer( self.var_bd22ba6c600a23a3 ) && isalive( self.var_bd22ba6c600a23a3 ) )
        {
            if ( isweapon( self.var_6d31abe6b171ada8 ) )
            {
                self kill( self.origin, self.var_bd22ba6c600a23a3, undefined, undefined, self.var_6d31abe6b171ada8 );
            }
            else
            {
                self kill( self.origin, self.var_bd22ba6c600a23a3 );
            }
            
            return;
        }
        
        self kill( self.origin );
    }
}

// Namespace brainrot
// Params 1
// Checksum 0x8a216dad, Offset: 0x14dd
// Size: 0x1d6
function brainrot_on_ai_killed( sparams )
{
    if ( isdefined( self.brainrot_attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.brainrot_attractor );
    }
    
    if ( isdefined( sparams.eattacker ) && isdefined( sparams.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( !isdefined( sparams.eattacker.var_7406c56074db89d1 ) )
        {
            sparams.eattacker.var_7406c56074db89d1 = 0;
        }
        
        sparams.eattacker.var_7406c56074db89d1++;
        
        if ( sparams.eattacker.var_7406c56074db89d1 === 5 && isplayer( sparams.eattacker.var_bd22ba6c600a23a3 ) )
        {
            sparams.eattacker.var_bd22ba6c600a23a3 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_cystemic" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                sparams.eattacker.var_bd22ba6c600a23a3 utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_cystemic" );
            }
        }
    }
    
    if ( isplayer( self.var_bd22ba6c600a23a3 ) )
    {
        level.var_7c526b990a6af27b--;
        level.var_7c526b990a6af27b = int( clamp( level.var_7c526b990a6af27b, 0, 15 ) );
        
        if ( !isdefined( self.var_bd22ba6c600a23a3.brainrotted_ai_count ) )
        {
            self.var_bd22ba6c600a23a3.brainrotted_ai_count = 0;
        }
        
        self.var_bd22ba6c600a23a3.brainrotted_ai_count = max( self.var_bd22ba6c600a23a3.brainrotted_ai_count - 1, 0 );
    }
}

/#

    // Namespace brainrot
    // Params 0
    // Checksum 0xafa0bab9, Offset: 0x16bb
    // Size: 0xa0, Type: dev
    function function_624181cff324eaa5()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x24>" );
            player iprintlnbold( "<dev string:x2d>" );
        }
    }

    // Namespace brainrot
    // Params 0
    // Checksum 0xf1a21675, Offset: 0x1763
    // Size: 0x2f, Type: dev
    function setup_brainrot_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x44>" );
        devgui::add_devgui_func( "<dev string:x55>", "<dev string:x64>", &function_624181cff324eaa5, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
