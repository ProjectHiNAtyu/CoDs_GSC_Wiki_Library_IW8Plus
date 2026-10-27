// scripts\mp\ob\skills\skill_rampage.gsc  (hash_43d9439edd2e8c96.gscc) (size: 3514 Bytes / 0xdba / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ffe2379 (2415797113)
// size ...... 3514 (0xdba)
// includes .. 6   (offset: 0xd1e)
// strings ... 1   (offset: 0xd4e)
// dev strs .. 8   (offset: 0xd5a)
// exports ... 14  (offset: 0x72e)
// cseg ...... 0x6d + 0x6c1 (0x72e)
// imports ... 32  (offset: 0x95e)
// animtree1 . 0   (offset: 0xdba)
// animtree2 . 0   (offset: 0xdba)
#using script_2fe74ee229c972c3;
#using script_5bcddb9b3157c08c;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;

#namespace skill_rampage;

// Namespace skill_rampage
// Params 0, eflags: 0x1
// Checksum 0xa513d034, Offset: 0x8b
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"rampage", &init );
}

// Namespace skill_rampage
// Params 0
// Checksum 0x87d43b91, Offset: 0xaa
// Size: 0x86
function init()
{
    utility::registersharedfunc( #"rampage", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"rampage", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"rampage", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    callback::add( #"on_ai_killed", &on_enemy_killed );
    callback::add( #"player_death", &on_enemy_killed );
}

// Namespace skill_rampage
// Params 1, eflags: 0x4
// Checksum 0x7ef17d2a, Offset: 0x138
// Size: 0x37
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_bd25f191f2ff78f )
    {
        skill_bundle.var_38e132d7f76e934f = utility::function_4b74c15943231980( skill_bundle.var_bd25f191f2ff78f );
    }
}

// Namespace skill_rampage
// Params 1, eflags: 0x4
// Checksum 0x2754875a, Offset: 0x177
// Size: 0x97, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_38e132d7f76e934f, "<dev string:x24>" );
    assert( skill_bundle.var_80b0e1fbebcc8ddf, "<dev string:x4c>" );
    assert( skill_bundle.var_92249f919f7b7fc8, "<dev string:x71>" );
    assert( skill_bundle.var_2765e83c97f7b58, "<dev string:x9f>" );
    self.var_41325c50d6a52126 = { #lastweaponused:undefined, #var_38ab74b0227b60d6:undefined, #bundle:skill_bundle };
    return true;
}

// Namespace skill_rampage
// Params 1, eflags: 0x4
// Checksum 0x9d35b35, Offset: 0x217
// Size: 0x39
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"end_skill_rampage" );
    namespace_9bde28f6fb0d35d1::function_4d56ceca482a18bb( #"rampage" );
    self.var_41325c50d6a52126 = undefined;
    function_fb53c860b03a94ea();
}

// Namespace skill_rampage
// Params 1, eflags: 0x4
// Checksum 0xffcf364b, Offset: 0x258
// Size: 0x94
function private on_enemy_killed( params )
{
    attacker = params.attacker ?? params.eattacker;
    var_da55798eb12048a0 = attacker.var_41325c50d6a52126;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    rapid_kills_done = function_e23da3e70ef873dc( attacker, params, var_da55798eb12048a0, bundle );
    
    if ( rapid_kills_done )
    {
        var_da55798eb12048a0.var_38ab74b0227b60d6 = [];
        attacker thread do_damage_buff( bundle );
    }
}

// Namespace skill_rampage
// Params 1, eflags: 0xc
// Checksum 0xab7f964e, Offset: 0x2f4
// Size: 0xc1
function private do_damage_buff( bundle )
{
    self notify( #"hash_b48557e2c0d6070d" );
    self endon( #"hash_b48557e2c0d6070d" );
    self endon( #"end_skill_rampage" );
    self endon( #"death_or_disconnect" );
    
    /#
        if ( getdvarint( @"scr_skill_rampage_debug", 0 ) )
        {
            self iprintlnbold( "<dev string:xd6>" );
        }
    #/
    
    function_fb53c860b03a94ea();
    apply_damage_buff();
    buff_duration = bundle.var_2765e83c97f7b58;
    namespace_9bde28f6fb0d35d1::function_faf7ed88035696ef( #"rampage", buff_duration, buff_duration, "end_skill_rampage" );
    wait buff_duration;
    function_fb53c860b03a94ea();
    
    /#
        if ( getdvarint( @"scr_skill_rampage_debug", 0 ) )
        {
            self iprintlnbold( "<dev string:xf7>" );
        }
    #/
}

// Namespace skill_rampage
// Params 0, eflags: 0xc
// Checksum 0xc1b7c3b7, Offset: 0x3bd
// Size: 0x32
function private apply_damage_buff()
{
    self notify( #"hash_7e3399d0bc22b0a7" );
    self endon( #"hash_7e3399d0bc22b0a7" );
    agent_utils::function_bc89b9076dd93902( &on_damage_buffed );
    zombie_utils::function_dfae6a5bd222c586( &on_damage_buffed );
}

// Namespace skill_rampage
// Params 0, eflags: 0x4
// Checksum 0x5a2ea869, Offset: 0x3f7
// Size: 0x1a
function private function_fb53c860b03a94ea()
{
    agent_utils::function_def5273cfe3c9109( &on_damage_buffed );
    zombie_utils::function_10c0c35c21e3ed9d( &on_damage_buffed );
}

// Namespace skill_rampage
// Params 1, eflags: 0x4
// Checksum 0x8230d1e6, Offset: 0x419
// Size: 0xd5
function private on_damage_buffed( params )
{
    attacker = params.eattacker ?? params.attacker;
    assert( isplayer( attacker ) );
    var_da55798eb12048a0 = attacker.var_41325c50d6a52126;
    bundle = var_da55798eb12048a0.bundle;
    current_damage = params.idamage;
    
    if ( params.sweapon == var_da55798eb12048a0.lastweaponused )
    {
        current_damage *= bundle.var_92249f919f7b7fc8;
        attacker function_d5bf26cf8c19220b( bundle.var_e131d981b4f49a2e );
    }
    else
    {
        var_da55798eb12048a0.lastweaponused = undefined;
        attacker function_fb53c860b03a94ea();
    }
    
    return current_damage;
}

// Namespace skill_rampage
// Params 1, eflags: 0x4
// Checksum 0x4e3b068, Offset: 0x4f7
// Size: 0x1a
function private function_d5bf26cf8c19220b( sfx )
{
    if ( sfx )
    {
        self playsoundtoplayer( sfx, self );
    }
}

// Namespace skill_rampage
// Params 4, eflags: 0x4
// Checksum 0xd6d723b3, Offset: 0x519
// Size: 0x1d0, Type: bool
function private function_e23da3e70ef873dc( attacker, params, var_da55798eb12048a0, bundle )
{
    if ( !isdefined( var_da55798eb12048a0.var_38ab74b0227b60d6 ) )
    {
        var_da55798eb12048a0.var_38ab74b0227b60d6 = [];
    }
    
    current_time = gettime();
    var_da55798eb12048a0.var_38ab74b0227b60d6[ var_da55798eb12048a0.var_38ab74b0227b60d6.size ] = current_time;
    var_d30e5c3d1ae57c0d = current_time - bundle.var_38e132d7f76e934f;
    var_d6c77036808a7aa = [];
    
    foreach ( timestamp in var_da55798eb12048a0.var_38ab74b0227b60d6 )
    {
        if ( timestamp >= var_d30e5c3d1ae57c0d )
        {
            var_d6c77036808a7aa[ var_d6c77036808a7aa.size ] = timestamp;
        }
    }
    
    if ( !utility::isbulletdamage( params.smeansofdeath ) )
    {
        var_d6c77036808a7aa = [];
        var_da55798eb12048a0.lastweaponused = undefined;
        var_da55798eb12048a0.var_38ab74b0227b60d6 = undefined;
        return false;
    }
    
    if ( function_baaad8889b53c41a( params, var_da55798eb12048a0 ) )
    {
        var_d6c77036808a7aa = [];
        var_d6c77036808a7aa[ var_d6c77036808a7aa.size ] = current_time;
    }
    
    var_da55798eb12048a0.lastweaponused = params.sweapon;
    var_da55798eb12048a0.var_38ab74b0227b60d6 = var_d6c77036808a7aa;
    
    /#
        if ( getdvarint( @"scr_skill_rampage_debug", 0 ) )
        {
            attacker iprintlnbold( "<dev string:x119>" + var_da55798eb12048a0.var_38ab74b0227b60d6.size + "<dev string:x137>" + bundle.var_80b0e1fbebcc8ddf );
        }
    #/
    
    return var_da55798eb12048a0.var_38ab74b0227b60d6.size >= bundle.var_80b0e1fbebcc8ddf;
}

// Namespace skill_rampage
// Params 2, eflags: 0x4
// Checksum 0xe4db584f, Offset: 0x6f2
// Size: 0x3b, Type: bool
function private function_baaad8889b53c41a( params, var_da55798eb12048a0 )
{
    return var_da55798eb12048a0.lastweaponused && var_da55798eb12048a0.lastweaponused != params.sweapon;
}

