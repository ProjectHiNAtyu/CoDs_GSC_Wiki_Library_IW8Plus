// scripts\mp\ob\skills\skill_turtle_shell.gsc  (hash_2b0b8204cc1a4bae.gscc) (size: 2144 Bytes / 0x860 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe562991 (4267059601)
// size ...... 2144 (0x860)
// includes .. 4   (offset: 0x828)
// strings ... 0   (offset: 0x848)
// dev strs .. 2   (offset: 0x848)
// exports ... 9   (offset: 0x478)
// cseg ...... 0x58 + 0x420 (0x478)
// imports ... 20  (offset: 0x5e0)
// animtree1 . 0   (offset: 0x860)
// animtree2 . 0   (offset: 0x860)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;

#namespace skill_turtle_shell;

// Namespace skill_turtle_shell
// Params 0, eflags: 0x1
// Checksum 0xd86f8633, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"turtle_shell", &init );
}

// Namespace skill_turtle_shell
// Params 0
// Checksum 0x226ca99b, Offset: 0x95
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"turtle_shell", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"turtle_shell", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_turtle_shell
// Params 1, eflags: 0x4
// Checksum 0xde6f97c4, Offset: 0xdb
// Size: 0xb9, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_86f47484db95d343, "<dev string:x24>" );
    assert( skill_bundle.var_4b28905ddc354a00, "<dev string:x78>" );
    self.var_e8f4843445567749 = { #var_2bc7dc430061d0ef:undefined, #bundle:skill_bundle };
    self.var_bba1e16138d312c8 = &armor_damage_override;
    self.var_a48163c16d11e1b1 = &function_2a5240e962b4701;
    
    if ( skill_bundle.var_938b511a81cb585a )
    {
        assert( !callback::exists( #"hash_652eb614ba902b3d", &player_damage_callback ) );
        callback::add( #"hash_652eb614ba902b3d", &player_damage_callback );
    }
    
    return true;
}

// Namespace skill_turtle_shell
// Params 1, eflags: 0x4
// Checksum 0x725aca61, Offset: 0x19d
// Size: 0x56
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_bba1e16138d312c8 = undefined;
    self.var_a48163c16d11e1b1 = undefined;
    
    if ( callback::exists( #"hash_652eb614ba902b3d", &player_damage_callback ) )
    {
        callback::remove( #"hash_652eb614ba902b3d", &player_damage_callback );
    }
    
    self.var_e8f4843445567749 = undefined;
}

// Namespace skill_turtle_shell
// Params 4, eflags: 0x4
// Checksum 0x694f4335, Offset: 0x1fb
// Size: 0xc5
function private armor_damage_override( damage, attacker, means_of_death, absorbed_damage )
{
    var_da55798eb12048a0 = self.var_e8f4843445567749;
    bundle = var_da55798eb12048a0.bundle;
    var_c50767e497c48051 = 0;
    
    if ( isdefined( self ) && isdefined( attacker ) )
    {
        var_c50767e497c48051 = damage_utility::function_96098e54715671d3( self.origin - attacker.origin, self.angles, bundle.var_4b28905ddc354a00 );
    }
    
    var_da55798eb12048a0.var_2bc7dc430061d0ef = var_c50767e497c48051;
    
    if ( !var_c50767e497c48051 )
    {
        return absorbed_damage;
    }
    
    self.var_f79429dae9c2e77 = 1;
    play_feedback( bundle );
    return damage;
}

// Namespace skill_turtle_shell
// Params 3, eflags: 0x4
// Checksum 0x641912d8, Offset: 0x2c9
// Size: 0x87
function private function_2a5240e962b4701( damage_absorbed, attacker, means_of_death )
{
    var_da55798eb12048a0 = self.var_e8f4843445567749;
    
    if ( !var_da55798eb12048a0 )
    {
        return damage_absorbed;
    }
    
    var_c50767e497c48051 = var_da55798eb12048a0.var_2bc7dc430061d0ef;
    var_da55798eb12048a0.var_2bc7dc430061d0ef = undefined;
    
    if ( !var_c50767e497c48051 )
    {
        return damage_absorbed;
    }
    
    self.var_f79429dae9c2e77 = undefined;
    return damage_absorbed * var_da55798eb12048a0.bundle.var_86f47484db95d343;
}

// Namespace skill_turtle_shell
// Params 1, eflags: 0x4
// Checksum 0x39f7c8ad, Offset: 0x359
// Size: 0xca
function private player_damage_callback( params )
{
    var_f804d3d8880c383e = int( ceil( self.armorhealth / level.var_1bfbe247e8d32b1b ) );
    
    if ( var_f804d3d8880c383e > 0 || !params.vdamagedir )
    {
        return;
    }
    
    bundle = self.var_e8f4843445567749.bundle;
    var_c50767e497c48051 = damage_utility::function_96098e54715671d3( params.vdamagedir, self.angles, bundle.var_4b28905ddc354a00 );
    
    if ( !var_c50767e497c48051 )
    {
        return;
    }
    
    params.idamage *= bundle.var_938b511a81cb585a;
    play_feedback( bundle );
}

// Namespace skill_turtle_shell
// Params 1, eflags: 0x4
// Checksum 0xd88fbc50, Offset: 0x42b
// Size: 0x4d
function private play_feedback( bundle )
{
    scriptable_part = bundle.var_bc2582843a9bb4b7;
    scriptable_state = bundle.var_57fea9c60cd5ac83;
    
    if ( scriptable_part && scriptable_state )
    {
        utility::function_32b24db3127bff40( scriptable_part, scriptable_state );
    }
}

