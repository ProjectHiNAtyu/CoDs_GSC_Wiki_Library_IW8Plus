// scripts\mp\ammomods\shatterblast.gsc  (hash_425689b6934d1bfd.gscc) (size: 9410 Bytes / 0x24c2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8fd95dcb (2413387211)
// size ...... 9410 (0x24c2)
// includes .. 11  (offset: 0x22ba)
// strings ... 25  (offset: 0x2312)
// dev strs .. 5   (offset: 0x2486)
// exports ... 22  (offset: 0x166a)
// cseg ...... 0x2aa + 0x13c0 (0x166a)
// imports ... 75  (offset: 0x19da)
// animtree1 . 0   (offset: 0x24c2)
// animtree2 . 0   (offset: 0x24c2)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\ammomods\ammo_mod;

#namespace shatterblast;

// Namespace shatterblast
// Params 0, eflags: 0x5
// Checksum 0xddbb5ba7, Offset: 0x2c8
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "shatterblast", undefined, &__init__, undefined );
}

// Namespace shatterblast
// Params 0
// Checksum 0xf368303c, Offset: 0x2e5
// Size: 0xa
function __init__()
{
    level thread function_a46dd36cea1a09cc();
}

// Namespace shatterblast
// Params 0
// Checksum 0x610e883c, Offset: 0x2f7
// Size: 0x213
function function_a46dd36cea1a09cc()
{
    if ( !level.ammo_mods_in_use )
    {
        return;
    }
    
    shatterblastbundle = level.var_b7d9d7926154819d.ammomodbundles[ "shatterblast" ];
    
    if ( !isdefined( shatterblastbundle ) )
    {
        return;
    }
    
    level._effect[ "shatterblast_explosion_effect" ] = loadfxasset( shatterblastbundle.shatterblastvfx );
    level._effect[ "shatterblast_explosion_effect_100" ] = loadfxasset( "vfx_t10_gameplay_zm_weapons_perk_shatterblast_lvl0_explo_100_units" );
    level endon( #"game_ended" );
    utility::flag_wait( "ammo_mods_ready" );
    utility::flag_init( "shatterblast_ready" );
    procpercent = shatterblastbundle.procpercent ?? 0.3;
    var_a3e31d9c9d0c8ca6 = shatterblastbundle.var_9225566c1a61c6ca ?? 0.1;
    cooldownentity = shatterblastbundle.cooldownentity ?? 0;
    cooldownattacker = shatterblastbundle.cooldownattacker ?? 25;
    cooldownglobal = shatterblastbundle.cooldownglobal ?? 3;
    var_92c00cb857963986 = shatterblastbundle.occursondeath ?? 1;
    var_2d38a15555828531 = shatterblastbundle.var_2d38a15555828531 ?? "";
    var_1c73b60ea00808df = shatterblastbundle.var_1c73b60ea00808df ?? "";
    element = shatterblastbundle.element ?? "none";
    level.var_e8fe4c2e8b347bd1 = [];
    level.var_d676ceda69d5163f = [];
    level.var_b02e68faf5959223 = throttle::throttle_initialize( "shatterblast_throttle", 1, level.framedurationseconds );
    ammo_mod::register_ammo_mod( "shatterblast", shatterblastbundle.id ?? 5, procpercent, var_a3e31d9c9d0c8ca6, cooldownentity, cooldownattacker, cooldownglobal, var_92c00cb857963986, &function_d986400abd5a4a2b, var_2d38a15555828531, var_1c73b60ea00808df, &function_6e78681bfb8d88e1, element, &function_e1b004e594ad933a );
    utility::flag_set( "shatterblast_ready" );
    
    /#
        level thread setup_shatterblast_devgui();
    #/
}

// Namespace shatterblast
// Params 1
// Checksum 0x570661be, Offset: 0x512
// Size: 0x23
function register_shatterblast_result_func( func )
{
    level.var_e8fe4c2e8b347bd1[ level.var_e8fe4c2e8b347bd1.size ] = func;
}

// Namespace shatterblast
// Params 1
// Checksum 0x497bb57f, Offset: 0x53d
// Size: 0x23
function register_shatterblast_validation_func( func )
{
    level.var_d676ceda69d5163f[ level.var_d676ceda69d5163f.size ] = func;
}

// Namespace shatterblast
// Params 1
// Checksum 0x1c9781c0, Offset: 0x568
// Size: 0x163
function function_d986400abd5a4a2b( result_params )
{
    death = result_params.death;
    attacker = result_params.attacker;
    mod = result_params.mod;
    sweapon = result_params.sweapon;
    vpoint = result_params.vpoint;
    shitloc = result_params.shitloc;
    modelindex = result_params.modelindex;
    attacker.shatterblast_kills = 0;
    
    if ( level.var_e8fe4c2e8b347bd1.size > 0 )
    {
        foreach ( var_511d306b51d343a2 in level.var_e8fe4c2e8b347bd1 )
        {
            [[ var_511d306b51d343a2 ]]( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
        }
        
        return;
    }
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !is_valid_ai_target( attacker ) )
    {
        return;
    }
    
    function_2160cd1e98996a4f( death, attacker, mod, sweapon, vpoint, shitloc, modelindex );
}

// Namespace shatterblast
// Params 3
// Checksum 0x268163b5, Offset: 0x6d3
// Size: 0x36
function function_e1b004e594ad933a( damage, attacker, sweapon )
{
    if ( utility::ent_flag( "is_shatterblast_target" ) )
    {
        function_d239e21f192c3f19( damage, attacker );
    }
}

// Namespace shatterblast
// Params 8
// Checksum 0x77bd610b, Offset: 0x711
// Size: 0xe5
function function_2160cd1e98996a4f( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_9f3ca9dcada2e0ef = 0 )
{
    var_afb881460a65a72d = vpoint;
    
    if ( isdefined( self.origin ) )
    {
        var_afb881460a65a72d = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 48 );
    }
    
    if ( isplayer( attacker ) && function_88a7be98d80a32bb( attacker ) )
    {
        playfx( utility::getfx( "shatterblast_explosion_effect_100" ), var_afb881460a65a72d );
    }
    else
    {
        playfx( utility::getfx( "shatterblast_explosion_effect" ), var_afb881460a65a72d );
    }
    
    thread shatterblast_explosion( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_9f3ca9dcada2e0ef );
}

// Namespace shatterblast
// Params 9
// Checksum 0x4206d9f7, Offset: 0x7fe
// Size: 0x3e9
function shatterblast_explosion( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_9f3ca9dcada2e0ef = 0, var_f4d6a76b9e4be123 )
{
    level endon( #"game_ended" );
    attacker endon( #"disconnect" );
    utility::ent_flag_set( "is_shatterblast_target" );
    var_88a7be98d80a32bb = !isplayer( self ) && isplayer( attacker ) && function_88a7be98d80a32bb( attacker );
    origin = vpoint;
    
    if ( var_88a7be98d80a32bb )
    {
        radius = level.zombie_augments[ "shatterblast_big_game" ].var_9d5c9b00b074a2e2 ?? 150;
    }
    else
    {
        radius = level.var_b7d9d7926154819d.ammomodbundles[ "shatterblast" ].var_d208127147eabcce ?? 128;
    }
    
    if ( !var_9f3ca9dcada2e0ef )
    {
        if ( isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_blast_zone" ) )
        {
            radiuspercent = level.zombie_augments[ #"shatterblast_blast_zone" ].var_5384dca2e5e48914;
            var_1697cce140a58d4a = radius * radiuspercent;
            radius += var_1697cce140a58d4a;
        }
    }
    
    if ( isplayer( self ) && var_f4d6a76b9e4be123 )
    {
        origin = var_f4d6a76b9e4be123;
        callback::callback( "shatterblast_explosion", { #radius:radius, #origin:origin, #target:"none", #attacker:self } );
    }
    else
    {
        if ( isdefined( self.origin ) )
        {
            origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 48 );
        }
        
        if ( isplayer( attacker ) )
        {
            attacker callback::callback( "shatterblast_explosion", { #radius:radius, #origin:origin, #target:self, #attacker:attacker } );
        }
    }
    
    waitframe();
    nearby_ai_group = getaiarrayinradius( origin, radius );
    var_734f3a5dd5c5c56d = 0;
    
    foreach ( ai in nearby_ai_group )
    {
        if ( attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( attacker, ai ) )
            {
                continue;
            }
        }
        
        if ( !zombie_utils::function_bf1464d09f4e4b40() )
        {
            if ( level.var_b7d9d7926154819d.ammomodbundles[ "shatterblast" ].var_f2f6218d5f22d0a7 )
            {
                ai thread function_70ac09dcfe415606( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, origin, level.var_b02e68faf5959223, var_9f3ca9dcada2e0ef );
            }
            else
            {
                ai shatterblast_damage( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, origin, var_9f3ca9dcada2e0ef );
            }
            
            var_734f3a5dd5c5c56d++;
        }
    }
    
    if ( attacker && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_blast_shield" ) )
    {
        var_12941877f8637641 = level.zombie_augments[ #"shatterblast_blast_shield" ].var_5393ae993f25f7a6 ?? 3;
        
        if ( var_734f3a5dd5c5c56d >= var_12941877f8637641 )
        {
            attacker callback::callback( "shatterblast_begin_blast_shield" );
        }
    }
}

// Namespace shatterblast
// Params 10
// Checksum 0x26049c08, Offset: 0xbef
// Size: 0xab
function function_70ac09dcfe415606( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, damageorigin, throttle, var_9f3ca9dcada2e0ef )
{
    ai = self;
    level endon( #"game_ended" );
    attacker endon( #"disconnect" );
    throttle::throttle_wait_in_queue( throttle, ai );
    
    if ( isalive( ai ) )
    {
        ai shatterblast_damage( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, damageorigin, var_9f3ca9dcada2e0ef );
    }
}

// Namespace shatterblast
// Params 9
// Checksum 0xdcf800d6, Offset: 0xca2
// Size: 0x2b2
function shatterblast_damage( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, damageorigin, var_9f3ca9dcada2e0ef = 0 )
{
    var_2b5d1dc7ccc7c88 = 0;
    damageamount = 0;
    var_4bfd32ef07b4266b = 0;
    
    if ( is_valid_ai_target( attacker ) )
    {
        thread function_12a899cb891039c3( attacker, var_9f3ca9dcada2e0ef );
        var_2b5d1dc7ccc7c88 = float( level.var_b7d9d7926154819d.ammomodbundles[ "shatterblast" ].var_a9ad3c62dfcc8a47 ?? 0.5 );
        
        if ( !var_9f3ca9dcada2e0ef )
        {
            if ( isplayer( attacker ) && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_blast_boost" ) )
            {
                var_893274c733117c9 = level.zombie_augments[ #"shatterblast_blast_boost" ].var_79bb112096d3c58e ?? 0.15;
                var_2b5d1dc7ccc7c88 += var_893274c733117c9;
            }
        }
        
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        var_4bfd32ef07b4266b = int( zombie_base_health * var_2b5d1dc7ccc7c88 );
        
        if ( isplayer( attacker ) && function_88a7be98d80a32bb( attacker ) )
        {
            var_60d3ffd7d2fed0ff = level.zombie_augments[ #"shatterblast_big_game" ].var_36a9717af2055687 ?? 0.5;
            var_4bfd32ef07b4266b += var_4bfd32ef07b4266b * var_60d3ffd7d2fed0ff;
        }
        
        if ( var_4bfd32ef07b4266b > 0 )
        {
            utility::ent_flag_set( "shatterblast_damage" );
            
            if ( var_4bfd32ef07b4266b > self.health )
            {
                self.killed_by_shatterblast = 1;
            }
            
            function_d239e21f192c3f19( var_4bfd32ef07b4266b, attacker );
            self dodamage( var_4bfd32ef07b4266b, damageorigin, attacker, attacker, "MOD_UNKNOWN", sweapon, shitloc, undefined, 1610678272 );
            
            if ( isalive( self ) )
            {
                utility::ent_flag_clear( "is_shatterblast_target" );
                utility::ent_flag_clear( "shatterblast_damage" );
                
                if ( !var_9f3ca9dcada2e0ef )
                {
                    ai_tier = ai_utility::get_ai_tier();
                    
                    if ( isplayer( attacker ) && ai_tier == 1 && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_blast_wave" ) )
                    {
                        zombie_knockdown::function_6fc167d4a3590991( vpoint );
                    }
                }
            }
            
            if ( !isalive( self ) && attacker.shatterblast_kills < 5 && !self.var_33df89471a965163 )
            {
                function_9bcb6dd397e2bb95( attacker, damageorigin );
            }
        }
    }
}

// Namespace shatterblast
// Params 2
// Checksum 0xb7fa36a, Offset: 0xf5c
// Size: 0x133
function function_9bcb6dd397e2bb95( attacker, damageorigin )
{
    self.var_33df89471a965163 = 1;
    
    if ( !isdefined( damageorigin ) )
    {
        damageorigin = attacker.origin;
    }
    
    var_24ed309d808c077a = self getcorpseentity();
    centerpoint = self getcentroid();
    v_dir = vectornormalize( centerpoint - damageorigin );
    
    if ( isdefined( var_24ed309d808c077a ) )
    {
        launchx = clamp( v_dir[ 0 ] * 5000, -8000, 8000 );
        launchy = clamp( v_dir[ 1 ] * 5000, -8000, 8000 );
        launchz = clamp( ( v_dir[ 2 ] + 150 ) * 1500, 0, 4000 );
        v_launch = ( launchx, launchy, launchz );
        right = anglestoright( v_launch );
        hitlocs = [ "head", "left_arm_upper", "right_arm_upper", "left_leg_upper", "right_leg_upper" ];
        index = randomintrange( 0, hitlocs.size );
        var_24ed309d808c077a startragdollfromimpact( hitlocs[ index ], v_launch );
    }
}

// Namespace shatterblast
// Params 2
// Checksum 0x56c15a7f, Offset: 0x1097
// Size: 0xd1
function function_d239e21f192c3f19( damage, attacker )
{
    var_de12d23103bcbf80 = utility::ent_flag( "shatterblast_kill_scoreevent_awarded" );
    var_508b8e476f4ac9a9 = self.health - damage < 1;
    
    if ( !var_de12d23103bcbf80 && var_508b8e476f4ac9a9 )
    {
        utility::ent_flag_set( "shatterblast_kill_scoreevent_awarded" );
        
        if ( isplayer( attacker ) )
        {
            if ( !isdefined( attacker.shatterblast_kills ) )
            {
                attacker.shatterblast_kills = 0;
            }
            
            attacker.shatterblast_kills++;
        }
        
        if ( isplayer( attacker ) && attacker.shatterblast_kills === 5 )
        {
            attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_hypergolic" );
            thread function_923254e4da104d02( attacker );
        }
        
        self.var_e797f68de73ece4e = "_sblast";
    }
}

// Namespace shatterblast
// Params 1, eflags: 0x4
// Checksum 0x3159c010, Offset: 0x1170
// Size: 0x32
function private function_923254e4da104d02( attacker )
{
    attacker endon( #"death_or_disconnect" );
    waitframe();
    
    if ( isplayer( attacker ) && isdefined( self ) )
    {
        function_9bcb6dd397e2bb95( attacker );
    }
}

// Namespace shatterblast
// Params 1
// Checksum 0xe0420e07, Offset: 0x11aa
// Size: 0x33, Type: bool
function is_valid_ai_target( attacker )
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self.team == attacker.team )
    {
        return false;
    }
    
    return true;
}

// Namespace shatterblast
// Params 0
// Checksum 0x1e62186d, Offset: 0x11e6
// Size: 0xd0, Type: bool
function function_6e78681bfb8d88e1()
{
    if ( level.ammo_mods[ "shatterblast" ].var_619b827d8f50a2bf[ self.basearchetype ] )
    {
        return false;
    }
    
    if ( isdefined( self.var_1e25d11456e53559 ) )
    {
        fail = [[ self.var_1e25d11456e53559 ]]();
        
        if ( !fail )
        {
            return false;
        }
    }
    
    foreach ( var_511d306b51d343a2 in level.var_d676ceda69d5163f )
    {
        if ( ![[ var_511d306b51d343a2 ]]() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace shatterblast
// Params 2
// Checksum 0x32b8a68f, Offset: 0x12bf
// Size: 0x56
function function_47b7627b81333e5c( shitloc, vpoint )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    metabone_name = metabone::function_ddf2fd7b79c9d5b5( shitloc );
    
    if ( !isdefined( metabone_name ) )
    {
        metabone_name = metabone::function_2d9c443204521c97( vpoint );
    }
    
    if ( metabone::is_metabone_armor( metabone_name ) )
    {
        metabone::destroy_metabone( metabone_name );
    }
}

// Namespace shatterblast
// Params 2
// Checksum 0xc0020df0, Offset: 0x131d
// Size: 0x203
function function_12a899cb891039c3( eattacker, var_9f3ca9dcada2e0ef = 0 )
{
    self endon( #"death" );
    
    if ( !isdefined( self.metabones ) )
    {
        return;
    }
    
    ai_tier = ai_utility::get_ai_tier();
    
    if ( !( ai_tier == 1 || ai_tier == 2 ) )
    {
        return;
    }
    
    attacker_origin = eattacker.origin;
    victim_origin = self.origin;
    center_point = self getcentroid();
    utility::ent_flag_init( "shatterblast_damaged_armor" );
    utility::ent_flag_set( "shatterblast_damaged_armor" );
    var_1ecb7066687d9062 = 0;
    
    foreach ( str_metabone_name, metabone in self.metabones.info )
    {
        if ( !metabone.is_active )
        {
            continue;
        }
        
        if ( metabone::is_metabone_destroyed( str_metabone_name ) )
        {
            continue;
        }
        
        if ( !metabone::is_metabone_armor( str_metabone_name ) )
        {
            continue;
        }
        
        metabone::destroy_metabone( str_metabone_name, eattacker, eattacker );
        var_1ecb7066687d9062++;
    }
    
    if ( var_1ecb7066687d9062 > 0 )
    {
        sparams = spawnstruct();
        sparams.eattacker = eattacker;
        sparams.var_1ecb7066687d9062 = var_1ecb7066687d9062;
        sparams.var_9f3ca9dcada2e0ef = var_9f3ca9dcada2e0ef;
        callback::callback( "shatterblast_destroyed_armor", sparams );
    }
    
    waitframe();
    waitframe();
    utility::ent_flag_clear( "shatterblast_damaged_armor" );
    
    if ( isdefined( attacker_origin ) && isdefined( victim_origin ) && isdefined( center_point ) )
    {
        force_dir = victim_origin - attacker_origin;
        force_dir = vectornormalize( force_dir );
        force_dir *= 100;
        function_df0d7efb44b35968( center_point, 128, 128, force_dir );
    }
}

// Namespace shatterblast
// Params 1, eflags: 0x4
// Checksum 0xb08faf5, Offset: 0x1528
// Size: 0x62
function private function_88a7be98d80a32bb( attacker )
{
    ai_tier = ai_utility::get_ai_tier();
    is_big_game = ai_tier == 3;
    is_valid_big_game = is_big_game && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shatterblast_big_game" );
    return is_valid_big_game;
}

/#

    // Namespace shatterblast
    // Params 0
    // Checksum 0xb7524a4, Offset: 0x1593
    // Size: 0xa0, Type: dev
    function function_a96bb3b4313c2771()
    {
        foreach ( player in level.players )
        {
            currentweapon = player getcurrentweapon();
            player ammo_mod::add_ammo_mod_to_weapon( currentweapon, "<dev string:x24>" );
            player iprintlnbold( "<dev string:x31>" );
        }
    }

    // Namespace shatterblast
    // Params 0
    // Checksum 0xd7a65b34, Offset: 0x163b
    // Size: 0x2f, Type: dev
    function setup_shatterblast_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x4c>" );
        devgui::add_devgui_func( "<dev string:x5d>", "<dev string:x70>", &function_a96bb3b4313c2771, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
