// scripts\mp\ob\skills\skill_last_shots_plus.gsc  (hash_67ad05783b5d9bf6.gscc) (size: 2136 Bytes / 0x858 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xde3b2333 (3728417587)
// size ...... 2136 (0x858)
// includes .. 5   (offset: 0x7dc)
// strings ... 2   (offset: 0x804)
// dev strs .. 5   (offset: 0x81c)
// exports ... 8   (offset: 0x3f0)
// cseg ...... 0x69 + 0x387 (0x3f0)
// imports ... 23  (offset: 0x530)
// animtree1 . 0   (offset: 0x858)
// animtree2 . 0   (offset: 0x858)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;

#namespace skill_last_shots_plus;

// Namespace skill_last_shots_plus
// Params 0, eflags: 0x1
// Checksum 0x245608f3, Offset: 0x87
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"last_shots_plus", &init );
}

// Namespace skill_last_shots_plus
// Params 0
// Checksum 0x7adc131d, Offset: 0xa6
// Size: 0x4a
function init()
{
    utility::registersharedfunc( #"last_shots_plus", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"last_shots_plus", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    agent_utils::register_soldier_damage_callback( &function_cb63e64abb1dbe2d );
}

// Namespace skill_last_shots_plus
// Params 1, eflags: 0x4
// Checksum 0x6a2a308f, Offset: 0xf8
// Size: 0xa4, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_463237b1b1b3de25, "<dev string:x24>" );
    assert( skill_bundle.var_abf9830eee9f41d3, "<dev string:x75>" );
    assert( skill_bundle.var_8eaf5af36811bf1a, "<dev string:xd0>" );
    assert( skill_bundle.var_f553a671bb5ca9cb, "<dev string:x127>" );
    self.var_db89a868f5714434 = { #bundle:skill_bundle };
    zombie_utils::function_dfae6a5bd222c586( &function_cb63e64abb1dbe2d );
    callback::add( #"hash_2346898712859996", &on_player_damaged_callback );
    return true;
}

// Namespace skill_last_shots_plus
// Params 1, eflags: 0x4
// Checksum 0xd1a4c383, Offset: 0x1a5
// Size: 0x4e
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_db89a868f5714434 = undefined;
    zombie_utils::function_10c0c35c21e3ed9d( &function_cb63e64abb1dbe2d );
    
    if ( callback::exists( #"hash_2346898712859996", &on_player_damaged_callback ) )
    {
        callback::remove( #"hash_2346898712859996", &on_player_damaged_callback );
    }
}

// Namespace skill_last_shots_plus
// Params 1, eflags: 0x4
// Checksum 0x1c403b59, Offset: 0x1fb
// Size: 0x28
function private function_cb63e64abb1dbe2d( params )
{
    return function_13ad81fc9fb7eeff( params.eattacker, params.idamage );
}

// Namespace skill_last_shots_plus
// Params 1, eflags: 0x4
// Checksum 0xf878e02f, Offset: 0x22c
// Size: 0x3f
function private on_player_damaged_callback( params )
{
    params.idamage = params.victim function_13ad81fc9fb7eeff( params.eattacker, params.idamage );
}

// Namespace skill_last_shots_plus
// Params 2, eflags: 0x4
// Checksum 0x15c35771, Offset: 0x273
// Size: 0x17c
function private function_13ad81fc9fb7eeff( attacker, damage )
{
    var_da55798eb12048a0 = attacker.var_db89a868f5714434;
    
    if ( !var_da55798eb12048a0 )
    {
        return damage;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    low_ammo_percentage = bundle.var_463237b1b1b3de25;
    bonus_damage_multiplier = isplayer( self ) ? bundle.var_abf9830eee9f41d3 : bundle.var_8eaf5af36811bf1a;
    low_ammo_cap = bundle.var_f553a671bb5ca9cb;
    
    if ( !low_ammo_percentage || !bonus_damage_multiplier || !low_ammo_cap )
    {
        assertmsg( "<dev string:x171>" );
        return damage;
    }
    
    damage = damage ?? 0;
    current_weapon = attacker getcurrentweapon();
    max_clip_size = weaponclipsize( current_weapon );
    
    if ( current_weapon.isdualwield )
    {
        max_clip_size *= 2;
        low_ammo_threshold = int( max_clip_size * low_ammo_percentage );
        current_weapon_clip_left = attacker getweaponammoclip( current_weapon, "left" );
        current_weapon_clip_right = attacker getweaponammoclip( current_weapon, "right" );
        current_weapon_clip = current_weapon_clip_left + current_weapon_clip_right;
    }
    else
    {
        low_ammo_threshold = int( max_clip_size * low_ammo_percentage );
        current_weapon_clip = attacker getweaponammoclip( current_weapon );
    }
    
    if ( low_ammo_threshold > low_ammo_cap )
    {
        low_ammo_threshold = low_ammo_cap;
    }
    
    if ( current_weapon_clip < low_ammo_threshold )
    {
        damage = bonus_damage_multiplier * damage;
    }
    
    return damage;
}

