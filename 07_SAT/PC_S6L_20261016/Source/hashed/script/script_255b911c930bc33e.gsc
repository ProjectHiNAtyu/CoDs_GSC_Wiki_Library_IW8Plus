// script_255b911c930bc33e  (hash_255b911c930bc33e.gscc) (size: 2102 Bytes / 0x836 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa55e295b (2774411611)
// size ...... 2102 (0x836)
// includes .. 6   (offset: 0x7c6)
// strings ... 5   (offset: 0x7f6)
// dev strs .. 0   (offset: 0x836)
// exports ... 8   (offset: 0x406)
// cseg ...... 0xa5 + 0x361 (0x406)
// imports ... 22  (offset: 0x546)
// animtree1 . 0   (offset: 0x836)
// animtree2 . 0   (offset: 0x836)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;

#namespace namespace_c44e23635614e163;

// Namespace namespace_c44e23635614e163
// Params 0, eflags: 0x1
// Checksum 0x52419738, Offset: 0xc3
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"damage_reflection", &init );
}

// Namespace namespace_c44e23635614e163
// Params 0
// Checksum 0xca86fce1, Offset: 0xe2
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"damage_reflection", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"damage_reflection", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"damage_reflection", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace namespace_c44e23635614e163
// Params 1, eflags: 0x4
// Checksum 0x69fd6864, Offset: 0x146
// Size: 0x6d
function private function_1321989bae991e4f( skill_bundle )
{
    default_mult = skill_bundle.var_98521c7c5ba7d431;
    var_214218594812673f = skill_bundle.var_371ed2a24cd1a074;
    multipliers = [];
    multipliers[ 1 ] = default_mult;
    multipliers[ 2 ] = default_mult;
    multipliers[ 3 ] = default_mult;
    multipliers[ 4 ] = var_214218594812673f;
    skill_bundle.var_f14709285cb663ce = multipliers;
}

// Namespace namespace_c44e23635614e163
// Params 1, eflags: 0x4
// Checksum 0x7ea02dd4, Offset: 0x1bb
// Size: 0x45, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( !callback::exists( #"player_damaged", &on_player_damaged, undefined, 1 ) );
    callback::add( #"player_damaged", &on_player_damaged, skill_bundle );
    return true;
}

// Namespace namespace_c44e23635614e163
// Params 1, eflags: 0x4
// Checksum 0x48ca8bd5, Offset: 0x209
// Size: 0x40
function private function_c51f1692ecb73bfe( skill_bundle )
{
    assert( callback::exists( #"player_damaged", &on_player_damaged, undefined, 1 ) );
    callback::remove( #"player_damaged", &on_player_damaged );
}

// Namespace namespace_c44e23635614e163
// Params 2, eflags: 0x4
// Checksum 0x74572011, Offset: 0x251
// Size: 0x10b
function private on_player_damaged( params, bundle )
{
    if ( self.inlaststand )
    {
        return;
    }
    
    attacker = params.eattacker;
    
    if ( !isalive( attacker ) )
    {
        return;
    }
    
    total_damage = params.idamage + ( params.lightarmordamage ?? 0 );
    reflection_multiplier = function_9fecfa6fcba3ea42( attacker, params.objweapon, bundle );
    
    if ( !reflection_multiplier )
    {
        return;
    }
    
    reflected_damage = int( total_damage * reflection_multiplier );
    attacker val::set( #"damage_reflection", "pain", 0 );
    attacker.nodamagenumbers = 1;
    attacker dodamage( reflected_damage, self.origin, self, self, "MOD_RIFLE_BULLET", "<explicitweaponnone>", "torso_upper" );
    attacker.nodamagenumbers = undefined;
    attacker val::reset( #"damage_reflection", "pain" );
}

// Namespace namespace_c44e23635614e163
// Params 3, eflags: 0x4
// Checksum 0x7b26e56c, Offset: 0x364
// Size: 0xa1
function private function_9fecfa6fcba3ea42( attacker, objweapon, bundle )
{
    if ( attacker.isequipment || attacker.turrettype || objweapon.classname == "turret" || weapon::isweaponequipment( objweapon ) || weapon::iskillstreakweapon( objweapon ) )
    {
        return bundle.var_f26ce23b6c2ec69d;
    }
    
    if ( !isagent( attacker ) )
    {
        return;
    }
    
    ai_tier = attacker ai_utility::get_power_tier();
    return bundle.var_f14709285cb663ce[ ai_tier ];
}

