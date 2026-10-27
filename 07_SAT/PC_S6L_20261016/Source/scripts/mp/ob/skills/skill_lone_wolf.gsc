// scripts\mp\ob\skills\skill_lone_wolf.gsc  (hash_596dac6b401ae4ec.gscc) (size: 2481 Bytes / 0x9b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3ab778a4 (985102500)
// size ...... 2481 (0x9b1)
// includes .. 8   (offset: 0x8f9)
// strings ... 2   (offset: 0x939)
// dev strs .. 8   (offset: 0x951)
// exports ... 9   (offset: 0x525)
// cseg ...... 0x87 + 0x49e (0x525)
// imports ... 21  (offset: 0x68d)
// animtree1 . 0   (offset: 0x9b1)
// animtree2 . 0   (offset: 0x9b1)
#using script_2fe74ee229c972c3;
#using script_5bcddb9b3157c08c;
#using script_69b551629233b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;

#namespace skill_lone_wolf;

// Namespace skill_lone_wolf
// Params 0, eflags: 0x1
// Checksum 0xf8fc0d2b, Offset: 0xa5
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"lone_wolf", &init );
}

// Namespace skill_lone_wolf
// Params 0
// Checksum 0x44f5a493, Offset: 0xc4
// Size: 0x6e
function init()
{
    utility::registersharedfunc( #"lone_wolf", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"lone_wolf", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    level zombie_utils::function_dfae6a5bd222c586( &function_943d8dd3946c8611 );
    level agent_utils::register_soldier_damage_callback( &function_943d8dd3946c8611 );
}

// Namespace skill_lone_wolf
// Params 1, eflags: 0x4
// Checksum 0x1a583455, Offset: 0x13a
// Size: 0x10d, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_44b9014bf76c3a34, "<dev string:x24>" );
    assert( skill_bundle.var_c3386215339b6162, "<dev string:x56>" );
    assert( skill_bundle.var_93dc68778f6fa2e, "<dev string:x84>" );
    assert( skill_bundle.var_469601ab47a23e44, "<dev string:xa9>" );
    assert( skill_bundle.var_5fa1fc748e0a02cc, "<dev string:xd7>" );
    self.var_6891f012f9ad4cab = { #skillactive:0, #chaindata:{ #unique_notify:"lone_wolf_kill_chain", #var_b2a793a44db51748:skill_bundle.var_5fa1fc748e0a02cc, #effect_duration:skill_bundle.var_93dc68778f6fa2e, #var_d7e948beccc7bf2a:skill_bundle.var_c3386215339b6162, #streak_required:skill_bundle.var_44b9014bf76c3a34 }, #bundle:skill_bundle };
    return true;
}

// Namespace skill_lone_wolf
// Params 1, eflags: 0x4
// Checksum 0x8e96adba, Offset: 0x250
// Size: 0x32
function private function_c51f1692ecb73bfe( skill_bundle )
{
    namespace_9bde28f6fb0d35d1::function_4d56ceca482a18bb( #"lone_wolf" );
    self notify( #"skill_lone_wolf_end" );
    self.var_6891f012f9ad4cab = undefined;
}

// Namespace skill_lone_wolf
// Params 1, eflags: 0x4
// Checksum 0x16224f9b, Offset: 0x28a
// Size: 0xae
function private function_9238338f068b6568( params )
{
    attacker = params.eattacker;
    
    if ( !attacker.var_6891f012f9ad4cab )
    {
        return;
    }
    
    skill_owner = attacker;
    var_da55798eb12048a0 = skill_owner.var_6891f012f9ad4cab;
    debug_enabled = getdvarint( @"hash_23b4e6ec8f70e96a", 0 );
    result = skill_owner namespace_f38c32a1da95aa5e::function_9f90663225cff18c( var_da55798eb12048a0.chaindata, debug_enabled );
    
    if ( result.streak_complete )
    {
        skill_owner thread apply_damage_boost( var_da55798eb12048a0, result.total_duration );
    }
}

// Namespace skill_lone_wolf
// Params 2, eflags: 0xc
// Checksum 0x4432a258, Offset: 0x340
// Size: 0xe3
function private apply_damage_boost( var_da55798eb12048a0, boost_duration )
{
    self notify( #"hash_a883d4fe5bf8ea79" );
    self endon( #"hash_a883d4fe5bf8ea79" );
    self endon( #"skill_lone_wolf_end" );
    self endon( #"death_or_disconnect" );
    
    /#
        if ( getdvarint( @"hash_23b4e6ec8f70e96a", 0 ) )
        {
            self iprintlnbold( "<dev string:x10a>" + boost_duration + "<dev string:x131>" );
        }
    #/
    
    var_8114f7a539248a1 = var_da55798eb12048a0.bundle.var_5fa1fc748e0a02cc;
    var_da55798eb12048a0.skillactive = 1;
    namespace_9bde28f6fb0d35d1::function_faf7ed88035696ef( #"lone_wolf", boost_duration, var_8114f7a539248a1, "skill_lone_wolf_end" );
    wait boost_duration;
    var_da55798eb12048a0.skillactive = 0;
    
    /#
        if ( getdvarint( @"hash_23b4e6ec8f70e96a", 0 ) )
        {
            self iprintlnbold( "<dev string:x133>" );
        }
    #/
}

// Namespace skill_lone_wolf
// Params 1, eflags: 0x4
// Checksum 0xb6c5b269, Offset: 0x42b
// Size: 0xaa
function private function_943d8dd3946c8611( params )
{
    attacker = get_valid_attacker( params.eattacker, params.objweapon );
    
    if ( !attacker )
    {
        return params.idamage;
    }
    
    var_da55798eb12048a0 = attacker.var_6891f012f9ad4cab;
    
    if ( !var_da55798eb12048a0 || !var_da55798eb12048a0.skillactive )
    {
        return params.idamage;
    }
    
    new_damage = params.idamage * var_da55798eb12048a0.bundle.var_469601ab47a23e44;
    return new_damage;
}

// Namespace skill_lone_wolf
// Params 2, eflags: 0x4
// Checksum 0x7896ab95, Offset: 0x4de
// Size: 0x47
function private get_valid_attacker( original_attacker, weapon )
{
    if ( isplayer( original_attacker ) )
    {
        return original_attacker;
    }
    
    if ( weapon::iskillstreakweapon( weapon ) && original_attacker.owner )
    {
        return original_attacker.owner;
    }
}

