// scripts\mp\ammomods\deadwire.gsc  (hash_29a753ac909d294b.gscc) (size: 12164 Bytes / 0x2f84 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc12ddb9 (3423788473)
// size ...... 12164 (0x2f84)
// includes .. 10  (offset: 0x2c24)
// strings ... 36  (offset: 0x2c74)
// dev strs .. 5   (offset: 0x2f48)
// exports ... 21  (offset: 0x1dfc)
// cseg ...... 0x2c3 + 0x1b39 (0x1dfc)
// imports ... 89  (offset: 0x2144)
// animtree1 . 0   (offset: 0x2f84)
// animtree2 . 0   (offset: 0x2f84)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\ammo_mod;

#namespace deadwire;

// Namespace deadwire
// Params 0, eflags: 0x5
// Checksum 0xe30ec8dd, Offset: 0x2e1
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "deadwire", undefined, &__init__, undefined );
}

// Namespace deadwire
// Params 0
// Checksum 0xc681454e, Offset: 0x2fe
// Size: 0xa
function __init__()
{
    level thread function_50369e62cdb35942();
}

// Namespace deadwire
// Params 0
// Checksum 0x65ca892e, Offset: 0x310
// Size: 0x242
function function_50369e62cdb35942()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    deadwirebundle = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ];
    
    if ( !isdefined( deadwirebundle ) )
    {
        return;
    }
    
    level._effect[ "vfx_perk_dw_aoe_exp" ] = loadfxasset( deadwirebundle.var_268199b191a84b84 );
    level._effect[ "vfx_perk_dw_aoe_exp_end" ] = loadfxasset( deadwirebundle.var_488573b8e59f8a7 );
    utility::flag_wait( "ammo_mods_ready" );
    utility::flag_init( "deadwire_ready" );
    procpercent = deadwirebundle.procpercent ?? 0.2;
    var_a3e31d9c9d0c8ca6 = deadwirebundle.var_9225566c1a61c6ca ?? 0.04;
    cooldownentity = deadwirebundle.cooldownentity ?? 0;
    cooldownattacker = deadwirebundle.cooldownattacker ?? 15;
    cooldownglobal = deadwirebundle.cooldownglobal ?? 15;
    var_92c00cb857963986 = deadwirebundle.occursondeath ?? 1;
    var_2d38a15555828531 = deadwirebundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = deadwirebundle.var_1c73b60ea00808df ?? "";
    element = deadwirebundle.element ?? "electrical";
    level.var_9a52e467395c0c0e = throttle::throttle_initialize( "deadwire", 2, level.framedurationseconds );
    
    if ( !isdefined( level.var_da7153fd7e70bd03 ) )
    {
        level.var_da7153fd7e70bd03 = [];
    }
    
    if ( !isdefined( level.var_11695d32c6990365 ) )
    {
        level.var_11695d32c6990365 = [];
    }
    
    ammo_mod::register_ammo_mod( "deadwire", deadwirebundle.id ?? 3, procpercent, var_a3e31d9c9d0c8ca6, cooldownentity, cooldownattacker, cooldownglobal, var_92c00cb857963986, &function_da9e946cbc502a41, var_2d38a15555828531, var_1c73b60ea00808df, &function_169a32f44c65057b, element, undefined );
    utility::flag_set( "deadwire_ready" );
    callback::add( #"on_ai_killed", &function_d0fa856e9bcd38c4 );
    
    /#
        level thread setup_deadwire_devgui();
    #/
}

// Namespace deadwire
// Params 1
// Checksum 0xd17f645c, Offset: 0x55a
// Size: 0x39
function register_deadwire_result_func( func )
{
    if ( !isdefined( level.var_da7153fd7e70bd03 ) )
    {
        level.var_da7153fd7e70bd03 = [];
    }
    
    level.var_da7153fd7e70bd03[ level.var_da7153fd7e70bd03.size ] = func;
}

// Namespace deadwire
// Params 1
// Checksum 0x6df32473, Offset: 0x59b
// Size: 0x39
function register_deadwire_validation_func( func )
{
    if ( !isdefined( level.var_11695d32c6990365 ) )
    {
        level.var_11695d32c6990365 = [];
    }
    
    level.var_11695d32c6990365[ level.var_11695d32c6990365.size ] = func;
}

// Namespace deadwire
// Params 1
// Checksum 0x24627ee2, Offset: 0x5dc
// Size: 0x183
function function_da9e946cbc502a41( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    var_3459569f97557c2f = result_params.var_3459569f97557c2f;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.magic_bullet_shield || self.damageshield )
    {
        return;
    }
    
    if ( level.var_da7153fd7e70bd03.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_da7153fd7e70bd03 )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_3459569f97557c2f );
        }
        
        return;
    }
    
    function_96586ce690694a15( attacker, sweapon, death, mod, vpoint, shitloc, modelindex, var_3459569f97557c2f );
}

// Namespace deadwire
// Params 8
// Checksum 0xf09a7f1d, Offset: 0x767
// Size: 0x52a
function function_96586ce690694a15( attacker, sweapon, death, mod, vpoint, shitloc, modelindex, var_3459569f97557c2f )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.magic_bullet_shield || self.damageshield )
    {
        return;
    }
    
    if ( utility::ent_flag( "deadwire_stunned" ) )
    {
        return;
    }
    
    var_d83f1eb97bb6e1f7 = 0;
    ai_tier = ai_utility::get_ai_tier();
    is_big_game = ai_tier == 3;
    is_valid_big_game = is_big_game && isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_big_game" );
    
    if ( ai_tier )
    {
        if ( ai_tier == 1 || ai_tier == 2 || is_valid_big_game )
        {
            var_d83f1eb97bb6e1f7 = 1;
        }
    }
    else if ( self.aisettings.var_b11b8458c44f3024 )
    {
        var_d83f1eb97bb6e1f7 = 1;
    }
    
    if ( !var_d83f1eb97bb6e1f7 )
    {
        return;
    }
    
    params = spawnstruct();
    params.attacker = attacker;
    params.death = death;
    params.mod = mod;
    params.sweapon = sweapon;
    params.vpoint = vpoint;
    params.shitloc = shitloc;
    params.modelindex = modelindex;
    params.zombie = self;
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_lightning_strike" ) )
    {
        callback::callback( "deadwire_stunned", params );
        return;
    }
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"hash_20438e41b7109065" ) )
    {
        callback::callback( "deadwire_stunned", params );
        return;
    }
    
    var_388892e106f7ddc4 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].deadwirestunduration ?? 5;
    var_bc1a3cbcdfbb2a89 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_37712c9b57ad9050 ?? 3;
    var_668e89caa1119753 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_668e89caa1119753 ?? 32;
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_extension" ) )
    {
        var_388892e106f7ddc4 += var_388892e106f7ddc4 * ( level.zombie_augments[ #"deadwire_extension" ].var_884fee97f4c95bc7 ?? 0.5 );
    }
    
    if ( self tagexists( "j_spine4" ) )
    {
        zombiespine = self gettagorigin( "j_spine4" );
    }
    else
    {
        zombiespine = self getcentroid();
    }
    
    if ( self.subclass == "zombie_parasite" )
    {
        zombiespine = ( zombiespine[ 0 ], zombiespine[ 1 ], zombiespine[ 2 ] - 32 );
    }
    
    var_cc5530a53569e4a1 = spawn( "script_model", zombiespine );
    var_cc5530a53569e4a1 setmodel( "tag_origin" );
    var_cc5530a53569e4a1 playsound( "prj_ammomod_deadwire_orb_spawn" );
    var_cc5530a53569e4a1.targetname = "deadwire_orb";
    var_cc5530a53569e4a1.var_3459569f97557c2f = var_3459569f97557c2f;
    params.deadwireorb = var_cc5530a53569e4a1;
    self.deadwireorb = var_cc5530a53569e4a1;
    var_cc5530a53569e4a1.owner = attacker;
    
    if ( !self.magic_bullet_shield && !self.damageshield && ai_tier == 1 && distance2dsquared( self.origin, attacker.origin ) <= var_668e89caa1119753 * var_668e89caa1119753 )
    {
        self.forceannihilate = 1;
        self.var_e797f68de73ece4e = "_dwire";
        utility::delaycallendon( level.framedurationseconds, "death", &function_ed7b0974710ea82, attacker );
    }
    else
    {
        val::set( "deadwire_stunned", "ignoreme", 1 );
        utility::ent_flag_set( "deadwire_stunned" );
        
        if ( ai_tier == 3 )
        {
            function_e4d79664f6b75e1( attacker, var_bc1a3cbcdfbb2a89 );
        }
        else
        {
            function_e4d79664f6b75e1( attacker, var_388892e106f7ddc4 );
        }
        
        function_b63bfe497fdd29a5( params );
    }
    
    callback::callback( "deadwire_stunned", params );
    var_cc5530a53569e4a1 callback::callback( "deadwire_orb_created", params );
    var_de9cde3bb4420ac5 = 0;
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_ball_lightning" ) )
    {
        var_de9cde3bb4420ac5 = 1;
    }
    
    var_cc5530a53569e4a1 thread function_1f4050a62c3e2aab( attacker, self, is_valid_big_game, var_de9cde3bb4420ac5 );
    
    if ( ai_tier == 1 )
    {
        thread function_5399b0ee43f56148( attacker, sweapon );
    }
    
    if ( !var_de9cde3bb4420ac5 )
    {
        endpos = getgroundposition( var_cc5530a53569e4a1.origin, 1 );
        var_cc5530a53569e4a1 moveto( endpos, 1, 0.5 );
    }
}

// Namespace deadwire
// Params 1
// Checksum 0x4479466a, Offset: 0xc99
// Size: 0x38
function function_ed7b0974710ea82( attacker )
{
    if ( !self.magic_bullet_shield && !self.damageshield )
    {
        self kill( self.origin, attacker );
    }
}

// Namespace deadwire
// Params 8
// Checksum 0xa95141c3, Offset: 0xcd9
// Size: 0x3d7
function function_97d4335963cfad58( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_2712320395f4ae2 = 0 )
{
    if ( !isdefined( attacker ) || !isalive( self ) || utility::ent_flag( "deadwire_stunned" ) )
    {
        return;
    }
    
    var_d83f1eb97bb6e1f7 = 0;
    ai_tier = ai_utility::get_ai_tier();
    
    if ( ai_tier )
    {
        if ( ai_tier == 1 || ai_tier == 2 )
        {
            var_d83f1eb97bb6e1f7 = 1;
        }
    }
    else if ( self.aisettings.var_b11b8458c44f3024 )
    {
        var_d83f1eb97bb6e1f7 = 1;
    }
    
    if ( !var_d83f1eb97bb6e1f7 )
    {
        return;
    }
    
    params = spawnstruct();
    params.attacker = attacker;
    params.death = death;
    params.mod = mod;
    params.sweapon = sweapon;
    params.vpoint = vpoint;
    params.shitloc = shitloc;
    params.modelindex = modelindex;
    params.zombie = self;
    params.var_2712320395f4ae2 = var_2712320395f4ae2;
    params.var_9f3ca9dcada2e0ef = 1;
    var_388892e106f7ddc4 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].deadwirestunduration ?? 5;
    var_bc1a3cbcdfbb2a89 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_37712c9b57ad9050 ?? 3;
    var_668e89caa1119753 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_668e89caa1119753 ?? 32;
    
    if ( self tagexists( "j_spine4" ) )
    {
        zombiespine = self gettagorigin( "j_spine4" );
    }
    else
    {
        zombiespine = self getcentroid();
    }
    
    if ( self.subclass == "zombie_parasite" )
    {
        zombiespine = ( zombiespine[ 0 ], zombiespine[ 1 ], zombiespine[ 2 ] - 32 );
    }
    
    var_cc5530a53569e4a1 = spawn( "script_model", zombiespine );
    var_cc5530a53569e4a1 setmodel( "tag_origin" );
    var_cc5530a53569e4a1 playsound( "prj_ammomod_deadwire_orb_spawn" );
    biggame = 0;
    params.deadwireorb = var_cc5530a53569e4a1;
    self.deadwireorb = var_cc5530a53569e4a1;
    var_cc5530a53569e4a1.owner = attacker;
    
    if ( !self.magic_bullet_shield && !self.damageshield && ai_tier == 1 && distance2dsquared( self.origin, attacker.origin ) <= var_668e89caa1119753 * var_668e89caa1119753 )
    {
        self.forceannihilate = 1;
        self.var_e797f68de73ece4e = "_dwire";
        utility::delaycallendon( level.framedurationseconds, "death", &function_ed7b0974710ea82, attacker );
    }
    else
    {
        val::set( "deadwire_stunned", "ignoreme", 1 );
        utility::ent_flag_set( "deadwire_stunned" );
        
        if ( ai_tier == 3 )
        {
            function_e4d79664f6b75e1( attacker, var_bc1a3cbcdfbb2a89 );
        }
        else
        {
            function_e4d79664f6b75e1( attacker, var_388892e106f7ddc4 );
        }
        
        function_b63bfe497fdd29a5( params );
    }
    
    callback::callback( "deadwire_stunned", params );
    var_cc5530a53569e4a1 callback::callback( "deadwire_orb_created", params );
    var_cc5530a53569e4a1 thread function_1f4050a62c3e2aab( attacker, self, biggame, sweapon );
    
    if ( ai_tier == 1 )
    {
        thread function_5399b0ee43f56148( attacker, sweapon );
    }
    
    endpos = getgroundposition( var_cc5530a53569e4a1.origin, 1 );
    var_cc5530a53569e4a1 moveto( endpos, 1, 0.5 );
}

// Namespace deadwire
// Params 0
// Checksum 0x5897f021, Offset: 0x10b8
// Size: 0xd0, Type: bool
function function_169a32f44c65057b()
{
    if ( level.ammo_mods[ "deadwire" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    if ( isdefined( self.var_47321d9a5a45ec17 ) )
    {
        var_773c2908802ff5ed = [[ self.var_47321d9a5a45ec17 ]]();
        
        if ( !var_773c2908802ff5ed )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_11695d32c6990365 )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace deadwire
// Params 0
// Checksum 0xd23f06b0, Offset: 0x1191
// Size: 0x25
function function_c2ef4cf2cb057718()
{
    self endon( #"death" );
    wait 1;
    utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_off" );
}

// Namespace deadwire
// Params 2
// Checksum 0xa4afd950, Offset: 0x11be
// Size: 0xcf
function function_5399b0ee43f56148( attacker, sweapon )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    
    while ( isalive( self ) && !self.magic_bullet_shield && !self.damageshield )
    {
        players = getplayersinradius( self.origin, 70 );
        
        if ( players.size > 0 )
        {
            if ( isalive( self ) && !self.magic_bullet_shield && !self.damageshield )
            {
                self.forceannihilate = 1;
                self.var_e797f68de73ece4e = "_dwire";
                self kill( self.origin, attacker, attacker, "MOD_ELEMENTAL_ELEC", sweapon );
            }
        }
        
        waitframe();
    }
}

// Namespace deadwire
// Params 5
// Checksum 0x74ed746c, Offset: 0x1295
// Size: 0x8c8
function function_1f4050a62c3e2aab( attacker, stunnedzombie, biggamedamage = 0, var_de9cde3bb4420ac5 = 0, sweapon )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    var_64a335b17df08758 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].ammomodduration ?? 5;
    
    if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_extension" ) )
    {
        var_64a335b17df08758 += var_64a335b17df08758 * ( level.zombie_augments[ #"deadwire_extension" ].var_884fee97f4c95bc7 ?? 0.5 );
    }
    
    deadwire_end_time = gettime() + utility::function_4b74c15943231980( var_64a335b17df08758 );
    self show();
    self playloopsound( "prj_ammomod_deadwire_orb_lp" );
    loopingfx = playfxontag( utility::getfx( "vfx_perk_dw_aoe_exp" ), self, "tag_origin" );
    self.loopingfx = loopingfx;
    var_65614d559662e52e = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_d208127147eabcce ?? 128;
    var_d67a8371ebe34343 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_51d66b79243599fd ?? 0.01;
    var_64c3057772e890e3 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_1f56a5bf31d3ae89 ?? 0.005;
    var_45b783e266e7e358 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_a9ad3c62dfcc8a47 ?? 0.05;
    var_ea1307f000be7508 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_9372fcf1a8535a8 ?? 0.2;
    var_dbc8e7e019acc253 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_6190324ede7a1773 ?? 0.025;
    var_f8d19b368467ce93 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_cfc87ef2a76a1db3 ?? 0.025;
    var_d880902897571053 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_e1252cdb4cdd7d34 ?? 0;
    var_cf39a49278154e4e = level.zombie_augments[ #"deadwire_big_game" ].var_d94c46a7d846f17a ?? 0.3;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    var_749ae3de5300181e = 1;
    
    while ( gettime() < deadwire_end_time )
    {
        var_e5f8ff6069bd05f1 = getaiarrayinradius( self.origin, var_65614d559662e52e );
        
        foreach ( zombie in var_e5f8ff6069bd05f1 )
        {
            if ( !isalive( zombie ) || zombie.var_eb92c31552620100 || zombie val::get( "ammomod_immune" ) )
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
            
            target_ai_tier = zombie ai_utility::get_ai_tier();
            var_be54cac8928065d0 = 0;
            
            if ( biggamedamage )
            {
                var_be54cac8928065d0 = int( base_zombie_maxhealth * var_cf39a49278154e4e );
            }
            else if ( target_ai_tier == 2 )
            {
                if ( zombie utility::ent_flag( "deadwire_stunned" ) )
                {
                    var_be54cac8928065d0 = int( base_zombie_maxhealth * var_dbc8e7e019acc253 );
                }
                else
                {
                    var_be54cac8928065d0 = int( base_zombie_maxhealth * var_d67a8371ebe34343 );
                }
            }
            else if ( target_ai_tier == 3 )
            {
                if ( zombie utility::ent_flag( "deadwire_stunned" ) )
                {
                    var_be54cac8928065d0 = int( base_zombie_maxhealth * var_f8d19b368467ce93 );
                }
                else
                {
                    var_be54cac8928065d0 = int( base_zombie_maxhealth * var_64c3057772e890e3 );
                }
            }
            else if ( isdefined( zombie.subclass ) && issubstr( zombie.subclass, "warlord" ) )
            {
                var_be54cac8928065d0 = int( base_zombie_maxhealth * var_64c3057772e890e3 );
            }
            else if ( zombie.type == "zombie" )
            {
                if ( zombie utility::ent_flag( "deadwire_stunned" ) )
                {
                    var_be54cac8928065d0 = int( base_zombie_maxhealth * var_ea1307f000be7508 );
                }
                else
                {
                    var_be54cac8928065d0 = int( base_zombie_maxhealth * var_45b783e266e7e358 );
                }
            }
            else
            {
                var_be54cac8928065d0 = var_d880902897571053;
                var_749ae3de5300181e = 0;
            }
            
            if ( var_de9cde3bb4420ac5 )
            {
                var_2e2922756166e8bb = 100 * ( level.zombie_augments[ #"deadwire_ball_lightning" ].var_4c408ad6f3653323 ?? 0.5 );
                
                if ( !zombie val::get( "disallow_stun" ) && utility::percent_chance( var_2e2922756166e8bb ) && !zombie utility::ent_flag( "deadwire_stunned" ) )
                {
                    var_388892e106f7ddc4 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].deadwirestunduration ?? 5;
                    zombie function_e4d79664f6b75e1( attacker, var_388892e106f7ddc4 );
                }
                
                var_be54cac8928065d0 = int( base_zombie_maxhealth * ( level.zombie_augments[ #"deadwire_ball_lightning" ].var_325610669f4be44 ?? 0.2 ) );
            }
            
            if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_damage_boost" ) )
            {
                var_be54cac8928065d0 += int( base_zombie_maxhealth * ( level.zombie_augments[ #"deadwire_damage_boost" ].var_e3d0eb79fd6fe167 ?? 0.1 ) );
            }
            
            if ( isdefined( zombie.var_e137d49f289f0726 ) )
            {
                var_be54cac8928065d0 = int( var_be54cac8928065d0 * zombie.var_e137d49f289f0726 );
            }
            
            if ( zombie.type == "zombie" )
            {
                zombie val::set( "deadwire", "pain", 0 );
            }
            
            idflags = 536936448 | ( var_749ae3de5300181e ? 1073741824 : 0 );
            
            if ( !zombie.magic_bullet_shield && !zombie.damageshield )
            {
                zombie check_scoreevent( var_be54cac8928065d0 );
                zombie dodamage( var_be54cac8928065d0, zombie.origin, attacker, attacker, "MOD_ELEMENTAL_ELEC", sweapon, "none", undefined, idflags );
            }
            
            zombie utility::function_32b24db3127bff40( "shocked_lightning_chain", "shocked_on" );
            zombie thread function_c2ef4cf2cb057718();
            zombie val::reset( "deadwire", "pain" );
            throttle::throttle_wait_in_queue( level.var_9a52e467395c0c0e, self );
        }
        
        wait 1;
        time = gettime();
    }
    
    if ( isdefined( self.loopingfx ) )
    {
        stopfxontag( self.loopingfx, self, "tag_origin" );
    }
    
    self stoploopsound( "prj_ammomod_deadwire_orb_lp" );
    self playsound( "prj_ammomod_deadwire_orb_despawn" );
    playfxontag( utility::getfx( "vfx_perk_dw_aoe_exp_end" ), self, "tag_origin" );
    params = spawnstruct();
    params.attacker = attacker;
    stunnedzombie callback::callback( "deadwire_end", params );
    
    if ( isalive( stunnedzombie ) && stunnedzombie utility::ent_flag( "deadwire_stunned" ) )
    {
        stunnedzombie utility::ent_flag_clear( "deadwire_stunned" );
        stunnedzombie val::reset( "deadwire_stunned", "ignoreme" );
        stunned_ai_tier = stunnedzombie ai_utility::get_ai_tier();
        
        if ( !stunnedzombie.magic_bullet_shield && !stunnedzombie.damageshield && stunned_ai_tier == 1 )
        {
            stunnedzombie.var_e797f68de73ece4e = "_dwire";
            stunnedzombie kill( stunnedzombie.origin, attacker, attacker, "MOD_ELEMENTAL_ELEC", sweapon );
            stunnedzombie utility::ent_flag_set( "deadwire_stun_kill" );
        }
    }
    
    stunnedzombie function_6c9041f038ca75a5( params );
    callback::callback( "deadwire_orb_end", params );
    wait 1;
    self delete();
}

// Namespace deadwire
// Params 2, eflags: 0x4
// Checksum 0x8032009a, Offset: 0x1b65
// Size: 0x2d
function private function_e4d79664f6b75e1( attacker, stun_duration )
{
    effect_stun::stun( "deadwire", stun_duration, attacker, undefined, undefined, "electrical", 1 );
}

// Namespace deadwire
// Params 1
// Checksum 0x4805ac13, Offset: 0x1b9a
// Size: 0x53
function function_b63bfe497fdd29a5( params )
{
    if ( self.type == "zombie" )
    {
        callback::callback( "shocked", params );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( #"shockStickVfx", #"vfx_start" );
    self.ishaywire = 1;
}

// Namespace deadwire
// Params 1
// Checksum 0x9c4dc83d, Offset: 0x1bf5
// Size: 0x52
function function_6c9041f038ca75a5( params )
{
    if ( self.type == "zombie" )
    {
        callback::callback( "shocked_end", params );
        return;
    }
    
    utility::function_7c10ea82c1e305b8( #"shockStickVfx", #"off" );
    self.ishaywire = undefined;
}

// Namespace deadwire
// Params 1
// Checksum 0x30eff340, Offset: 0x1c4f
// Size: 0x3c
function check_scoreevent( damage )
{
    var_508b8e476f4ac9a9 = self.health - damage < 1;
    
    if ( !var_508b8e476f4ac9a9 )
    {
        return;
    }
    
    self.var_e797f68de73ece4e = "_dwire";
}

// Namespace deadwire
// Params 1
// Checksum 0x79819e0b, Offset: 0x1c93
// Size: 0x8a
function function_d0fa856e9bcd38c4( params )
{
    if ( isagent( self ) && isplayer( params.eattacker ) && ( utility::ent_flag( "deadwire_stun_kill" ) || utility::ent_flag( "deadwire_stunned" ) ) )
    {
        if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
        {
            params.eattacker utility::callsharedfunc( #"medal", #"track_rapid_kill", "deadwire" );
        }
    }
}

/#

    // Namespace deadwire
    // Params 0
    // Checksum 0xc8363633, Offset: 0x1d25
    // Size: 0xa0, Type: dev
    function function_1211873e3d490cf()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x24>" );
            player iprintlnbold( "<dev string:x2d>" );
        }
    }

    // Namespace deadwire
    // Params 0
    // Checksum 0xfa4dba91, Offset: 0x1dcd
    // Size: 0x2f, Type: dev
    function setup_deadwire_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x44>" );
        devgui::add_devgui_func( "<dev string:x55>", "<dev string:x64>", &function_1211873e3d490cf, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
