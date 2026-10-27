// scripts\mp\ob\skills\skill_vampire.gsc  (hash_094cc546430bc67b.gscc) (size: 2735 Bytes / 0xaaf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa675b025 (2792730661)
// size ...... 2735 (0xaaf)
// includes .. 5   (offset: 0xa87)
// strings ... 0   (offset: 0xaaf)
// dev strs .. 0   (offset: 0xaaf)
// exports ... 13  (offset: 0x577)
// cseg ...... 0x58 + 0x51f (0x577)
// imports ... 27  (offset: 0x77f)
// animtree1 . 0   (offset: 0xaaf)
// animtree2 . 0   (offset: 0xaaf)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace skill_vampire;

// Namespace skill_vampire
// Params 0, eflags: 0x1
// Checksum 0x413f1ae3, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"vampire", &init );
}

// Namespace skill_vampire
// Params 0
// Checksum 0xdcbadd20, Offset: 0x95
// Size: 0x6a
function init()
{
    utility::registersharedfunc( #"vampire", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"vampire", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"on_ai_killed", &function_853edee5252c1743 );
    level callback::add( #"on_ai_damaged", &function_853edee5252c1743 );
}

// Namespace skill_vampire
// Params 1, eflags: 0x4
// Checksum 0xecb6b102, Offset: 0x107
// Size: 0x23, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_1b8ed7983626b61b = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_vampire
// Params 1, eflags: 0x4
// Checksum 0x4f46799c, Offset: 0x133
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_1b8ed7983626b61b = undefined;
}

// Namespace skill_vampire
// Params 0, eflags: 0x4
// Checksum 0x3cce9287, Offset: 0x151
// Size: 0x1a
function private function_90d53b0c7ecce76c()
{
    self setscriptablepartstate( #"skill_vampire_fx", #"on" );
}

// Namespace skill_vampire
// Params 1, eflags: 0x4
// Checksum 0x91381572, Offset: 0x173
// Size: 0xd7
function private function_853edee5252c1743( params )
{
    attacker = get_attacker( params );
    
    if ( !attacker )
    {
        return params.idamage;
    }
    
    var_da55798eb12048a0 = attacker.var_1b8ed7983626b61b;
    inflictor = params.einflictor;
    
    if ( !inflictor || !var_da55798eb12048a0 )
    {
        return params.idamage;
    }
    
    if ( self.inlaststand )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !attacker is_valid_attack( params, bundle ) )
    {
        return params.idamage;
    }
    
    is_kill = !isalive( self );
    attacker function_dcb41c62d6326359( is_kill, bundle );
    return params.idamage;
}

// Namespace skill_vampire
// Params 2, eflags: 0x4
// Checksum 0xdb27f2ea, Offset: 0x253
// Size: 0x29
function private function_dcb41c62d6326359( is_kill, bundle )
{
    recover_health( bundle, is_kill );
    function_693f8235dfce3bb1( bundle, is_kill );
}

// Namespace skill_vampire
// Params 2, eflags: 0x4
// Checksum 0x96bdeb99, Offset: 0x284
// Size: 0x6b, Type: bool
function private is_valid_attack( params, bundle )
{
    weapon = params.objweapon ?? params.sweapon;
    
    if ( function_e55161cf863c7b63( weapon, bundle.var_ccfebacb714efb8f ) )
    {
        return true;
    }
    
    if ( params.einflictor zombie_utils::function_bf1464d09f4e4b40() )
    {
        return true;
    }
    
    return false;
}

// Namespace skill_vampire
// Params 2, eflags: 0x4
// Checksum 0xfdaca8c2, Offset: 0x2f8
// Size: 0xa4, Type: bool
function private function_e55161cf863c7b63( weapon, valid_weapons_list )
{
    if ( !valid_weapons_list )
    {
        return false;
    }
    
    foreach ( entry in valid_weapons_list )
    {
        if ( weapon.basename == entry.validweapons )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace skill_vampire
// Params 1, eflags: 0x4
// Checksum 0xce63ebf8, Offset: 0x3a5
// Size: 0x6e
function private get_attacker( params )
{
    if ( !params.eattacker )
    {
        return;
    }
    
    attacker = params.eattacker;
    var_bd22ba6c600a23a3 = attacker.var_bd22ba6c600a23a3;
    
    if ( isplayer( var_bd22ba6c600a23a3 ) && isalive( var_bd22ba6c600a23a3 ) )
    {
        return var_bd22ba6c600a23a3;
    }
    
    return attacker.owner ?? attacker;
}

// Namespace skill_vampire
// Params 2, eflags: 0x4
// Checksum 0x760a5209, Offset: 0x41c
// Size: 0xa3
function private recover_health( bundle, is_kill )
{
    can_recover_health = self.health < self.maxhealth;
    
    if ( !can_recover_health )
    {
        return;
    }
    
    var_16a395bddb0d814b = is_kill ? bundle.var_fc36b2a334426c29 : bundle.var_97d53e300f160504;
    
    if ( !var_16a395bddb0d814b )
    {
        return;
    }
    
    new_health = int( self.health + var_16a395bddb0d814b );
    self.health = minint( new_health, self.maxhealth );
    thread function_90d53b0c7ecce76c();
}

// Namespace skill_vampire
// Params 2, eflags: 0x4
// Checksum 0x1c10195a, Offset: 0x4c7
// Size: 0xb0
function private function_693f8235dfce3bb1( bundle, is_kill )
{
    if ( !is_kill )
    {
        return;
    }
    
    percentage = bundle.var_7d0ef3e22b2ad096;
    
    if ( !percentage )
    {
        return;
    }
    
    current_weapon = self getcurrentweapon();
    
    if ( weapon::iskillstreakweapon( current_weapon.basename ) )
    {
        return;
    }
    
    curr_ammo = self getweaponammostock( current_weapon );
    max_ammo = weaponmaxammo( current_weapon );
    
    if ( curr_ammo >= max_ammo )
    {
        return;
    }
    
    var_661941a7f5882631 = max_ammo * percentage + curr_ammo;
    var_661941a7f5882631 = int( clamp( var_661941a7f5882631, 0, max_ammo ) );
    self setweaponammostock( current_weapon, var_661941a7f5882631 );
}

