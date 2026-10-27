// scripts\mp\ob\skills\skill_armor_breaker.gsc  (hash_2e3c51fa616438d1.gscc) (size: 4087 Bytes / 0xff7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb12a617 (185771543)
// size ...... 4087 (0xff7)
// includes .. 8   (offset: 0xf53)
// strings ... 8   (offset: 0xf93)
// dev strs .. 0   (offset: 0xff7)
// exports ... 13  (offset: 0x9b3)
// cseg ...... 0x146 + 0x86d (0x9b3)
// imports ... 32  (offset: 0xbbb)
// animtree1 . 0   (offset: 0xff7)
// animtree2 . 0   (offset: 0xff7)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ob\systems\ob_stun;

#namespace skill_armor_breaker;

// Namespace skill_armor_breaker
// Params 0, eflags: 0x1
// Checksum 0x6f4067b1, Offset: 0x164
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"armor_breaker", &init );
}

// Namespace skill_armor_breaker
// Params 0
// Checksum 0x4cfa9f58, Offset: 0x183
// Size: 0x57
function init()
{
    utility::registersharedfunc( #"armor_breaker", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"armor_breaker", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( "on_armor_break", &on_armor_break );
    function_dae30526b3926999();
}

// Namespace skill_armor_breaker
// Params 0, eflags: 0x4
// Checksum 0xd4e53eb2, Offset: 0x1e2
// Size: 0xd3
function private function_dae30526b3926999()
{
    skill_bundle_list = level.skillbundles[ #"armor_breaker" ];
    
    foreach ( rarity, skill_bundle in skill_bundle_list )
    {
        if ( !skill_bundle.var_1aae6125e8bd4129 )
        {
            continue;
        }
        
        fx_asset = loadfxasset( skill_bundle.var_1aae6125e8bd4129 );
        var_994e57629d8f02df = "armor_breaker_stun_vfx_" + rarity;
        level._effect[ var_994e57629d8f02df ] = fx_asset;
    }
}

// Namespace skill_armor_breaker
// Params 1, eflags: 0x4
// Checksum 0x92106160, Offset: 0x2bd
// Size: 0x185, Type: bool
function private on_give_skill( skill_bundle )
{
    var_5b4ceeeef9619979 = skill_bundle.var_3ecdc41878617294;
    
    if ( var_5b4ceeeef9619979 )
    {
        vfx_id_name = "armor_breaker_stun_vfx_" + skill_bundle.skilllevel;
        self.skill_armor_breaker_stun = { #player_duration:skill_bundle.var_194be0d400a7cc86 ?? 0, #player_damage:skill_bundle.var_b13b136151e17097 ?? 0, #sfx:skill_bundle.var_d2569225b3c7f4ae, #vfx:vfx_id_name, #cooldown:skill_bundle.var_d3b990401a4aed3a ?? 0, #damage:skill_bundle.var_22de6a3a10ddfefe ?? 0, #duration:utility::function_b720276ae54a4d70( skill_bundle.var_ea129092db5342eb, "armorBreakerStunDuration is not defined in skill_armor_breaker bundle" ), #radius:utility::function_b720276ae54a4d70( skill_bundle.var_179cc381e3ff868d, "armorBreakerStunRadius is not defined in skill_armor_breaker bundle" ) };
    }
    
    extra_damage_percentage = skill_bundle.var_eca1ef459a38361e;
    
    if ( extra_damage_percentage )
    {
        self.var_8c9b1bf4dd8f9c34 = extra_damage_percentage;
        agent_utils::function_bc89b9076dd93902( &override_soldier_damage );
        zombie_utils::function_dfae6a5bd222c586( &override_zombie_damage );
    }
    
    headshot_damage_armor = skill_bundle.var_9be9b4cc63f27b63;
    
    if ( headshot_damage_armor )
    {
        self.headshot_damage_armor[ #"armor_breaker" ] = 1;
    }
    
    return true;
}

// Namespace skill_armor_breaker
// Params 1, eflags: 0x4
// Checksum 0xa8ffb11a, Offset: 0x44b
// Size: 0x57
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( self.var_8c9b1bf4dd8f9c34 )
    {
        agent_utils::function_def5273cfe3c9109( &override_soldier_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &override_zombie_damage );
    }
    
    self.skill_armor_breaker_stun = undefined;
    self.var_8c9b1bf4dd8f9c34 = undefined;
    self.headshot_damage_armor[ #"armor_breaker" ] = undefined;
}

// Namespace skill_armor_breaker
// Params 1, eflags: 0x4
// Checksum 0x24c9b637, Offset: 0x4aa
// Size: 0xb0
function private on_armor_break( params )
{
    attacker = get_valid_attacker( params );
    
    if ( !attacker )
    {
        return;
    }
    
    attacker.skill_armor_breaker_stun.current_cooldown_end = gettime() + attacker.skill_armor_breaker_stun.cooldown * 1000;
    radius = attacker.skill_armor_breaker_stun.radius;
    enemies_around = getplayersandaiarrayinradius( self.origin, radius );
    play_feedback( attacker );
    function_e926fc4ed57b9d42( attacker, enemies_around );
    function_7dbec1908d95f4ed( attacker, enemies_around );
}

// Namespace skill_armor_breaker
// Params 1, eflags: 0x4
// Checksum 0xef104b73, Offset: 0x562
// Size: 0xb2
function private get_valid_attacker( params )
{
    original_attacker = params.attacker;
    attacker = original_attacker.owner ?? original_attacker;
    
    if ( !attacker.skill_armor_breaker_stun )
    {
        return;
    }
    
    if ( params.smeansofdeath == "MOD_MELEE" )
    {
        return;
    }
    
    if ( original_attacker.isequipment || weapon::isweaponequipment( params.objweapon ) )
    {
        return;
    }
    
    curr_time = gettime();
    
    if ( curr_time < attacker.skill_armor_breaker_stun.current_cooldown_end )
    {
        return;
    }
    
    return attacker;
}

// Namespace skill_armor_breaker
// Params 1, eflags: 0x4
// Checksum 0x3d956c7d, Offset: 0x61d
// Size: 0x82
function private play_feedback( attacker )
{
    vfx = attacker.skill_armor_breaker_stun.vfx;
    sfx = attacker.skill_armor_breaker_stun.sfx;
    
    if ( vfx )
    {
        effect_id = utility::getfx( vfx );
        
        if ( effect_id )
        {
            playfxontag( effect_id, self, "tag_origin" );
        }
    }
    
    if ( sfx )
    {
        self playsound( sfx );
    }
}

// Namespace skill_armor_breaker
// Params 2, eflags: 0x4
// Checksum 0x72c62ec5, Offset: 0x6a7
// Size: 0xb6
function private function_e926fc4ed57b9d42( attacker, enemies_around )
{
    stun_data = { #stunorigin:self.origin, #var_c27a2418f1d8f32d:1, #aistunduration:attacker.skill_armor_breaker_stun.duration, #playersstunduration:attacker.skill_armor_breaker_stun.player_duration, #stunradius:attacker.skill_armor_breaker_stun.radius, #source:#"armor_breaker" };
    attacker thread ob_stun::function_336faa60d5212254( stun_data, enemies_around );
}

// Namespace skill_armor_breaker
// Params 2, eflags: 0x4
// Checksum 0x4a14194f, Offset: 0x765
// Size: 0x11d
function private function_7dbec1908d95f4ed( attacker, enemies_around )
{
    damage = attacker.skill_armor_breaker_stun.damage;
    var_a78eabe217762d01 = attacker.skill_armor_breaker_stun.player_damage;
    
    foreach ( enemy in enemies_around )
    {
        if ( !isalive( enemy ) || attacker.team == enemy.team )
        {
            continue;
        }
        
        var_47d03287c38f1221 = damage;
        
        if ( isplayer( enemy ) )
        {
            var_47d03287c38f1221 = var_a78eabe217762d01;
        }
        
        enemy dodamage( var_47d03287c38f1221, self.origin, attacker, attacker, "MOD_IMPACT", undefined, "none", undefined );
    }
}

// Namespace skill_armor_breaker
// Params 1, eflags: 0x4
// Checksum 0x463335a1, Offset: 0x88a
// Size: 0x89
function private override_soldier_damage( params )
{
    attacker = params.eattacker ?? params.attacker;
    
    if ( !attacker.var_8c9b1bf4dd8f9c34 )
    {
        return params.idamage;
    }
    
    if ( self.armorhealth <= 0 )
    {
        return params.idamage;
    }
    
    var_5454f57201136c19 = params.idamage;
    return var_5454f57201136c19 * attacker.var_8c9b1bf4dd8f9c34;
}

// Namespace skill_armor_breaker
// Params 1, eflags: 0x4
// Checksum 0xaa78b5fe, Offset: 0x91c
// Size: 0x96
function private override_zombie_damage( params )
{
    attacker = params.eattacker;
    
    if ( !attacker.var_8c9b1bf4dd8f9c34 )
    {
        return params.idamage;
    }
    
    var_792d7c603f887540 = metabone::get_metabone_health( params.metabonename );
    
    if ( !var_792d7c603f887540 || var_792d7c603f887540 <= 0 )
    {
        return params.idamage;
    }
    
    var_5454f57201136c19 = params.idamage;
    return var_5454f57201136c19 * attacker.var_8c9b1bf4dd8f9c34;
}

