// scripts\mp\ob\skills\skill_contagious.gsc  (hash_6473b69ef89580f9.gscc) (size: 4942 Bytes / 0x134e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5011630a (1343316746)
// size ...... 4942 (0x134e)
// includes .. 8   (offset: 0x123e)
// strings ... 10  (offset: 0x127e)
// dev strs .. 6   (offset: 0x1306)
// exports ... 13  (offset: 0xb22)
// cseg ...... 0xf3 + 0xa2f (0xb22)
// imports ... 45  (offset: 0xd2a)
// animtree1 . 0   (offset: 0x134e)
// animtree2 . 0   (offset: 0x134e)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_toxic_gas;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;

#namespace skill_contagious;

// Namespace skill_contagious
// Params 0, eflags: 0x1
// Checksum 0x4442b220, Offset: 0x111
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"contagious", &init );
}

// Namespace skill_contagious
// Params 0
// Checksum 0xc033d7b2, Offset: 0x130
// Size: 0x72
function init()
{
    utility::registersharedfunc( #"contagious", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"contagious", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"contagious", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
}

// Namespace skill_contagious
// Params 1, eflags: 0x4
// Checksum 0x336eade9, Offset: 0x1aa
// Size: 0x148
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_ff90598e7a98987a )
    {
        skill_bundle.var_2c2ad7af91f047d2 = skill_bundle.var_ff90598e7a98987a * 1000;
    }
    
    if ( skill_bundle.contagiouscooldown )
    {
        skill_bundle.var_d5f622d2b0b45eae = skill_bundle.contagiouscooldown * 1000;
    }
    
    if ( skill_bundle.var_4586255f0ce85c39 )
    {
        skill_bundle.var_fa8a6e516ef8baca = int( skill_bundle.var_4586255f0ce85c39 );
    }
    
    skill_bundle.var_201a1202847ebcb7 = throttle::throttle_initialize( "skillContagiousDamage", 1, level.framedurationseconds );
    
    if ( skill_bundle.contagiousaisettings )
    {
        skill_bundle.var_b9ce507508487bcd = getscriptbundle( skill_bundle.contagiousaisettings );
        function_3dc144077bad065a( skill_bundle.var_b9ce507508487bcd );
    }
    
    if ( skill_bundle.var_c6bcde8df2c79eb8 || skill_bundle.var_76cb4691a96818f4 )
    {
        skill_bundle.var_a407d454a8d7ebfb = [];
        skill_bundle.var_a407d454a8d7ebfb[ "human" ] = skill_bundle.var_76cb4691a96818f4;
        skill_bundle.var_a407d454a8d7ebfb[ "zombie" ] = skill_bundle.var_c6bcde8df2c79eb8;
    }
}

// Namespace skill_contagious
// Params 1, eflags: 0x4
// Checksum 0xa6113612, Offset: 0x2fa
// Size: 0x7f, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.contagiousaisettings, "<dev string:x24>" );
    assert( skill_bundle.var_b9ce507508487bcd, "<dev string:x60>" );
    assert( skill_bundle.var_e3a7793ed9ecda, "<dev string:xad>" );
    self.var_bd97684a23244b1b = { #var_6dfacee19e181612:0, #var_431fa3d24605ee9e:0, #bundle:skill_bundle };
    return true;
}

// Namespace skill_contagious
// Params 1, eflags: 0x4
// Checksum 0x62886830, Offset: 0x382
// Size: 0x58
function private function_3dc144077bad065a( ai_settings )
{
    if ( ai_settings.annihilatevfx )
    {
        if ( !utility::fxexists( ai_settings.vfxaliasprefix + "_annihilate" ) )
        {
            utility::add_fx( ai_settings.vfxaliasprefix + "_annihilate", ai_settings.annihilatevfx );
        }
    }
}

// Namespace skill_contagious
// Params 1, eflags: 0x4
// Checksum 0xaccbadd5, Offset: 0x3e2
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_bd97684a23244b1b = undefined;
}

// Namespace skill_contagious
// Params 1, eflags: 0x4
// Checksum 0x5d7d952c, Offset: 0x400
// Size: 0x65
function private function_8c5e06ee1e60aeb7( params )
{
    attacker = params.eattacker;
    var_da55798eb12048a0 = attacker.var_bd97684a23244b1b;
    bundle = var_da55798eb12048a0.bundle;
    
    if ( function_c7b4be9e390784b( params, var_da55798eb12048a0, bundle ) )
    {
        function_46c489384275b54d( params, var_da55798eb12048a0, bundle );
    }
}

// Namespace skill_contagious
// Params 2, eflags: 0x4
// Checksum 0x46a17dd6, Offset: 0x46d
// Size: 0xc6, Type: bool
function private is_relevant_kill( params, bundle )
{
    if ( bundle.var_10cbece38c70a211 && params.sweapon.basenamehash == bundle.var_10cbece38c70a211 )
    {
        return false;
    }
    
    if ( isai( params.einflictor ) )
    {
        return false;
    }
    
    victim = params.victim;
    
    if ( victim zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( victim.var_d6894f01a36b4ff3.var_fda156cf6c87580d )
    {
        return false;
    }
    
    if ( bundle.var_da918a86f5daf6ee && victim ai_utility::get_power_tier() > bundle.var_da918a86f5daf6ee )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_contagious
// Params 3, eflags: 0x4
// Checksum 0x260dba8c, Offset: 0x53c
// Size: 0x95, Type: bool
function private is_in_cooldown( current_time, var_da55798eb12048a0, bundle )
{
    if ( bundle.var_2c2ad7af91f047d2 )
    {
        var_4c33f33266873761 = current_time - var_da55798eb12048a0.var_431fa3d24605ee9e;
        
        if ( var_4c33f33266873761 < bundle.var_2c2ad7af91f047d2 )
        {
            return true;
        }
    }
    
    if ( bundle.var_d5f622d2b0b45eae )
    {
        var_65748306ff906cfd = current_time - var_da55798eb12048a0.var_6dfacee19e181612;
        
        if ( var_65748306ff906cfd < bundle.var_d5f622d2b0b45eae )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace skill_contagious
// Params 3, eflags: 0x4
// Checksum 0xe9d72698, Offset: 0x5da
// Size: 0x8c, Type: bool
function private function_c7b4be9e390784b( params, var_da55798eb12048a0, bundle )
{
    if ( !params.eattacker )
    {
        return false;
    }
    
    if ( !var_da55798eb12048a0 )
    {
        return false;
    }
    
    if ( !is_relevant_kill( params, bundle ) )
    {
        return false;
    }
    
    current_time = gettime();
    
    if ( is_in_cooldown( current_time, var_da55798eb12048a0, bundle ) )
    {
        return false;
    }
    
    var_da55798eb12048a0.var_431fa3d24605ee9e = current_time;
    
    if ( !utility::percent_chance( bundle.var_e3a7793ed9ecda ) )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_contagious
// Params 3, eflags: 0x4
// Checksum 0x3c318e4b, Offset: 0x66f
// Size: 0x393
function private function_46c489384275b54d( params, var_da55798eb12048a0, bundle )
{
    attacker = params.eattacker;
    aisettings = bundle.var_b9ce507508487bcd;
    victim = params.victim;
    var_46063ece3767f60b = victim.origin;
    
    if ( aisettings.annihilatevfx )
    {
        effect_id = utility::getfx( aisettings.vfxaliasprefix + "_annihilate" );
        
        if ( effect_id )
        {
            if ( utility::hastag( victim.model, "j_spine4" ) )
            {
                effect_pos = victim gettagorigin( "j_spine4" );
                effect_angles = victim gettagangles( "j_spine4" );
            }
            else
            {
                effect_pos = victim.origin;
                effect_angles = victim.angles;
            }
            
            if ( effect_pos && effect_angles )
            {
                playfx( effect_id, effect_pos, anglestoforward( effect_angles ), anglestoup( effect_angles ) );
            }
        }
    }
    
    throttle::throttle_wait_in_queue( bundle.var_201a1202847ebcb7, attacker );
    var_da55798eb12048a0.var_6dfacee19e181612 = gettime();
    
    if ( bundle.var_d6028cb14b5d4ddf )
    {
        assert( bundle.var_fa8a6e516ef8baca, "<dev string:xe0>" );
        assert( bundle.var_1bfb4a04288a2674, "<dev string:xfe>" );
        victim zombie_toxic_gas::spawn_toxic_gas( attacker, var_46063ece3767f60b, ( 0, 0, 0 ), "from_contagious_skill", bundle.var_d6028cb14b5d4ddf, bundle.var_fa8a6e516ef8baca, bundle.var_1bfb4a04288a2674, undefined, undefined, undefined, aisettings, bundle.var_eafaf58060228b5a, bundle.var_a407d454a8d7ebfb );
    }
    
    if ( aisettings.explosionradius )
    {
        enemies = utility::function_f754506ecfae9afb( var_46063ece3767f60b, aisettings.explosionradius, undefined, bundle.var_1bfb4a04288a2674, 0 );
        brainrot_count = 0;
        
        foreach ( enemy in enemies )
        {
            if ( !player_utility::playersareenemies( attacker, enemy ) || enemy zombie_utils::function_33a24849a0dfd13b() || enemy.teamshifted )
            {
                continue;
            }
            
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            var_32ef5c6ab944e354 = bundle.var_c9fe1ac1f9ccdacf && ( !bundle.var_18ae1e95afba0d8c || brainrot_count < bundle.var_18ae1e95afba0d8c );
            var_4047cc52e53bd66f = !bundle.var_86d5f4b275bb46f1 || enemy ai_utility::get_power_tier() <= bundle.var_86d5f4b275bb46f1;
            
            if ( var_32ef5c6ab944e354 && var_4047cc52e53bd66f && utility::percent_chance( bundle.var_c9fe1ac1f9ccdacf ) )
            {
                enemy thread apply_brainrot( attacker, bundle );
                brainrot_count++;
                continue;
            }
            
            if ( bundle.var_8bbf50cd27a291d0 )
            {
                enemy dodamage( bundle.var_8bbf50cd27a291d0, var_46063ece3767f60b, attacker, victim, "MOD_EXPLOSIVE", bundle.var_10cbece38c70a211, "torso_upper" );
            }
        }
    }
}

// Namespace skill_contagious
// Params 2, eflags: 0x4
// Checksum 0xe068af93, Offset: 0xa0a
// Size: 0x118
function private apply_brainrot( attacker, bundle )
{
    self endon( #"death" );
    utility::callsharedfunc( #"zombie_utils", #"turn_ai", attacker, { #state:"brainrot_on", #part:"brainrot" } );
    self disableaimassist();
    self.var_914a5379b8e8fd3 = 1;
    self.owner = attacker;
    self.skillref = #"contagious";
    
    if ( bundle.var_c2ad86040659bdb > 0 )
    {
        self function_fa32376aaa88a7a2( self.origin, bundle.var_c2ad86040659bdb );
    }
    
    if ( bundle.var_9da348e316764460 )
    {
        attacker thread utility::callsharedfunc( #"player", #"doScoreEvent", bundle.var_9da348e316764460 );
    }
    
    assert( bundle.var_913fd8305526dddb, "<dev string:x11c>" );
    wait bundle.var_913fd8305526dddb;
    self kill( self.origin );
}

