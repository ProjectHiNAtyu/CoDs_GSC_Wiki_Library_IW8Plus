// scripts\mp\ob\skills\skill_lucky_rounds.gsc  (hash_0da687c20952ee7d.gscc) (size: 5217 Bytes / 0x1461 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8ca61b1b (2359696155)
// size ...... 5217 (0x1461)
// includes .. 7   (offset: 0x1335)
// strings ... 12  (offset: 0x136d)
// dev strs .. 8   (offset: 0x1401)
// exports ... 15  (offset: 0xca1)
// cseg ...... 0xfb + 0xba6 (0xca1)
// imports ... 36  (offset: 0xef9)
// animtree1 . 0   (offset: 0x1461)
// animtree2 . 0   (offset: 0x1461)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;

#namespace skill_lucky_rounds;

// Namespace skill_lucky_rounds
// Params 0, eflags: 0x1
// Checksum 0xa95c210d, Offset: 0x119
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"lucky_rounds", &init );
}

// Namespace skill_lucky_rounds
// Params 0
// Checksum 0x319b4ad4, Offset: 0x138
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"lucky_rounds", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"lucky_rounds", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"lucky_rounds", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_lucky_rounds
// Params 1, eflags: 0x4
// Checksum 0xd53e015a, Offset: 0x19c
// Size: 0x1b1
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_5087003321acde9 )
    {
        skill_bundle.var_7ffbefd0a427258d = skill_bundle.var_5087003321acde9 * 1000;
    }
    
    if ( skill_bundle.var_3927def8a6d6cedc )
    {
        skill_bundle.var_c8c79fa583f2e690 = skill_bundle.var_3927def8a6d6cedc * 1000;
    }
    
    if ( skill_bundle.var_9b84f0e5cff78875 )
    {
        skill_bundle.var_83416ee5a297d56d = [];
        skill_bundle.var_83416ee5a297d56d[ "brainrot" ] = skill_bundle.var_9b84f0e5cff78875.brainrot;
        skill_bundle.var_83416ee5a297d56d[ "cryofreeze" ] = skill_bundle.var_9b84f0e5cff78875.cryofreeze;
        skill_bundle.var_83416ee5a297d56d[ "deadwire" ] = skill_bundle.var_9b84f0e5cff78875.deadwire;
        skill_bundle.var_83416ee5a297d56d[ "fw_ammomod" ] = skill_bundle.var_9b84f0e5cff78875.var_1a0c0d03c2971b9b;
        skill_bundle.var_83416ee5a297d56d[ "lightray" ] = skill_bundle.var_9b84f0e5cff78875.lightray;
        skill_bundle.var_83416ee5a297d56d[ "napalmburst" ] = skill_bundle.var_9b84f0e5cff78875.napalmburst;
        skill_bundle.var_83416ee5a297d56d[ "shadowvortex" ] = skill_bundle.var_9b84f0e5cff78875.shadowvortex;
        skill_bundle.var_83416ee5a297d56d[ "shatterblast" ] = skill_bundle.var_9b84f0e5cff78875.shatterblast;
    }
}

// Namespace skill_lucky_rounds
// Params 1, eflags: 0x4
// Checksum 0xdf3006e5, Offset: 0x355
// Size: 0x11a, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_2f0fc7406bf487f5, "<dev string:x24>" );
    
    /#
        if ( skill_bundle.var_47bbfb1826b772a )
        {
            assert( skill_bundle.var_eddf4284089c3a89, "<dev string:x71>" );
            assert( skill_bundle.var_4d19a4295b8d684a, "<dev string:xc1>" );
            assert( skill_bundle.var_2d468112eabed670, "<dev string:x115>" );
            assert( skill_bundle.var_c8c79fa583f2e690, "<dev string:x169>" );
            assert( skill_bundle.var_bec4841fbae7e9b3, "<dev string:x1bf>" );
            assert( skill_bundle.var_442d008d701596c4, "<dev string:x216>" );
            assert( skill_bundle.var_ef223181f020e59e, "<dev string:x26c>" );
        }
    #/
    
    zombie_utils::function_dfae6a5bd222c586( &function_e6d3aa1da950bd63 );
    agent_utils::function_bc89b9076dd93902( &function_e6d3aa1da950bd63 );
    self.var_eac37c0ecf8382ec = { #var_827b6a0825d4e729:0, #bundle:skill_bundle };
    return true;
}

// Namespace skill_lucky_rounds
// Params 1, eflags: 0x4
// Checksum 0xd07ab926, Offset: 0x478
// Size: 0x2e
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_eac37c0ecf8382ec = undefined;
    zombie_utils::function_10c0c35c21e3ed9d( &function_e6d3aa1da950bd63 );
    agent_utils::function_def5273cfe3c9109( &function_e6d3aa1da950bd63 );
}

// Namespace skill_lucky_rounds
// Params 1, eflags: 0x4
// Checksum 0x5f867c32, Offset: 0x4ae
// Size: 0x250
function private function_e6d3aa1da950bd63( params )
{
    if ( function_53cde647e319559a( params ) )
    {
        attacker = params.eattacker ?? params.attacker;
        bundle = attacker.var_eac37c0ecf8382ec.bundle;
        var_7bf66648a3f62aa9 = { #skill_name:#"lucky_rounds", #cooldown:bundle.var_2188c58ebe2f3d77, #var_3b55b60765b98d29:[ 1, 2, 3 ], #weights_table:arraycopy( bundle.var_c091a68e1712f13c ), #objweapon:params.objweapon, #partname:params.partname, #modelindex:params.modelindex, #timeoffset:params.timeoffset, #shitloc:params.shitloc, #vdir:params.vdir, #vpoint:params.vpoint, #idflags:params.idflags, #idamage:params.idamage, #inflictor:params.einflictor ?? params.inflictor, #probability:bundle.var_af0a4236dff43850, #player:attacker };
        
        if ( utility::issharedfuncdefined( #"skills", #"hash_79530ea7319d30d6" ) )
        {
            triggered_ammo_mod = utility::callsharedfunc( #"skills", #"hash_79530ea7319d30d6", var_7bf66648a3f62aa9 );
            
            if ( triggered_ammo_mod )
            {
                scriptable_state = bundle.var_83416ee5a297d56d[ triggered_ammo_mod ];
                
                if ( scriptable_state )
                {
                    attacker utility::function_7c10ea82c1e305b8( bundle.var_2f0fc7406bf487f5, scriptable_state );
                }
                
                if ( bundle.var_47bbfb1826b772a )
                {
                    function_476d76cc777ad513( var_7bf66648a3f62aa9, triggered_ammo_mod, bundle );
                }
            }
        }
    }
    
    return params.idamage;
}

// Namespace skill_lucky_rounds
// Params 1, eflags: 0x4
// Checksum 0x439ca34f, Offset: 0x707
// Size: 0x193, Type: bool
function private function_53cde647e319559a( params )
{
    attacker = params.eattacker ?? params.attacker;
    var_da55798eb12048a0 = attacker.var_eac37c0ecf8382ec;
    
    if ( !var_da55798eb12048a0 || !isalive( self ) || !isalive( attacker ) || player::isinlaststand( attacker ) )
    {
        return false;
    }
    
    means_of_death = params.smeansofdeath;
    
    if ( !means_of_death || !utility::isbulletdamage( means_of_death ) && means_of_death != "MOD_PROJECTILE" && means_of_death != "MOD_IMPACT" && !utility::ismeleedamage( means_of_death ) )
    {
        return false;
    }
    
    weapon = params.objweapon;
    inflictor = params.einflictor ?? params.inflictor;
    
    if ( !weapon || isnullweapon( weapon ) )
    {
        return false;
    }
    
    if ( weapon::issuperweapon( weapon.basename ) || weapon.classname == "grenade" || inflictor.classname == "grenade" )
    {
        return false;
    }
    
    if ( self.var_698a6ce8c4e37bad )
    {
        return false;
    }
    
    if ( is_in_cooldown( var_da55798eb12048a0.bundle.var_7ffbefd0a427258d, var_da55798eb12048a0.var_827b6a0825d4e729 ) )
    {
        return false;
    }
    
    var_da55798eb12048a0.var_827b6a0825d4e729 = gettime();
    return true;
}

// Namespace skill_lucky_rounds
// Params 2, eflags: 0x4
// Checksum 0xc5a5fd09, Offset: 0x8a3
// Size: 0x27, Type: bool
function private is_in_cooldown( cooldown_ms, last_timestamp )
{
    if ( !cooldown_ms )
    {
        return false;
    }
    
    return gettime() - last_timestamp < cooldown_ms;
}

// Namespace skill_lucky_rounds
// Params 3, eflags: 0x4
// Checksum 0xd5ccfd1c, Offset: 0x8d3
// Size: 0x7c
function private function_476d76cc777ad513( var_7bf66648a3f62aa9, triggered_ammo_mod, bundle )
{
    var_7bf66648a3f62aa9.probabilities[ triggered_ammo_mod ] = undefined;
    var_7bf66648a3f62aa9.skill_name = undefined;
    var_7bf66648a3f62aa9.cooldown = undefined;
    ammo_mod_type = get_ammo_mod_type( triggered_ammo_mod );
    
    if ( ammo_mod_type == 1 )
    {
        thread function_c4cdae55488ad7ba( var_7bf66648a3f62aa9, bundle );
        return;
    }
    
    if ( ammo_mod_type == 0 )
    {
        function_efbdfb7f9acc0e6b( var_7bf66648a3f62aa9, bundle );
    }
}

// Namespace skill_lucky_rounds
// Params 1, eflags: 0x4
// Checksum 0xa0af2fd, Offset: 0x957
// Size: 0x4b
function private get_ammo_mod_type( var_7c632e879fe5e94b )
{
    switch ( var_7c632e879fe5e94b )
    {
        case #"hash_41d942d30dd3f804":
        case #"hash_646d6f8aee3339b1":
        case #"hash_ac0effad69e31045":
            return 0;
        default:
            return 1;
    }
}

// Namespace skill_lucky_rounds
// Params 2, eflags: 0x4
// Checksum 0xaf2c03a3, Offset: 0x9aa
// Size: 0xe9
function private function_c4cdae55488ad7ba( var_7bf66648a3f62aa9, bundle )
{
    level endon( #"game_ended" );
    radius = bundle.var_4d19a4295b8d684a;
    chance = bundle.var_2d468112eabed670;
    var_c04e417f8531bdb5 = bundle.var_eddf4284089c3a89;
    duration = bundle.var_c8c79fa583f2e690;
    proc_delay = bundle.var_bec4841fbae7e9b3;
    cooldown = var_7bf66648a3f62aa9.cooldown;
    var_7bf66648a3f62aa9.probability = chance;
    start_time = gettime();
    
    while ( gettime() - start_time < duration )
    {
        if ( !isalive( self ) )
        {
            break;
        }
        
        function_62fe0258688fe2b1( var_7bf66648a3f62aa9, radius, cooldown, var_c04e417f8531bdb5 );
        wait proc_delay;
    }
}

// Namespace skill_lucky_rounds
// Params 2, eflags: 0x4
// Checksum 0xfa45dd07, Offset: 0xa9b
// Size: 0x86
function private function_efbdfb7f9acc0e6b( var_7bf66648a3f62aa9, bundle )
{
    radius = bundle.var_442d008d701596c4;
    chance = bundle.var_ef223181f020e59e;
    var_c04e417f8531bdb5 = bundle.var_eddf4284089c3a89;
    cooldown = var_7bf66648a3f62aa9.cooldown;
    var_7bf66648a3f62aa9.probability = chance;
    function_62fe0258688fe2b1( var_7bf66648a3f62aa9, radius, cooldown, var_c04e417f8531bdb5 );
}

// Namespace skill_lucky_rounds
// Params 4, eflags: 0x4
// Checksum 0x8a8ac845, Offset: 0xb29
// Size: 0x130
function private function_62fe0258688fe2b1( var_7bf66648a3f62aa9, radius, cooldown, var_c04e417f8531bdb5 )
{
    enemies_in_range = getaiarrayinradius( self.origin, radius );
    
    foreach ( enemy in enemies_in_range )
    {
        if ( enemy == self )
        {
            continue;
        }
        
        if ( enemy.var_698a6ce8c4e37bad )
        {
            continue;
        }
        
        ai_tier = enemy ai_utility::get_power_tier();
        
        if ( ai_tier > var_c04e417f8531bdb5 )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"skills", #"hash_79530ea7319d30d6" ) )
        {
            triggered_ammo_mod = enemy utility::callsharedfunc( #"skills", #"hash_79530ea7319d30d6", var_7bf66648a3f62aa9 );
            
            if ( triggered_ammo_mod )
            {
                enemy thread function_e85384de877db986( cooldown );
            }
        }
    }
}

// Namespace skill_lucky_rounds
// Params 1, eflags: 0x4
// Checksum 0xb7288a00, Offset: 0xc61
// Size: 0x40
function private function_e85384de877db986( cooldown )
{
    level endon( #"game_ended" );
    self.var_698a6ce8c4e37bad = 1;
    utility::waittill_any_in_array_or_timeout( [ "death" ], cooldown );
    self.var_698a6ce8c4e37bad = undefined;
}

