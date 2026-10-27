// scripts\mp\zm\systems\zm_mutant_injection_disciple.gsc  (hash_59908cef4417bd92.gscc) (size: 4019 Bytes / 0xfb3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x908dca7c (2425211516)
// size ...... 4019 (0xfb3)
// includes .. 5   (offset: 0xf57)
// strings ... 3   (offset: 0xf7f)
// dev strs .. 0   (offset: 0xfb3)
// exports ... 17  (offset: 0x7f3)
// cseg ...... 0x95 + 0x75e (0x7f3)
// imports ... 41  (offset: 0xa9b)
// animtree1 . 0   (offset: 0xfb3)
// animtree2 . 0   (offset: 0xfb3)
#using script_16ea1b94f0f381b3;
#using script_214060780e647f61;
#using scripts\common\utility;
#using scripts\mp\common\powerups\full_ammo;
#using scripts\mp\damage;

#namespace zm_mutant_injection_disciple;

// Namespace zm_mutant_injection_disciple
// Params 0, eflags: 0x1
// Checksum 0xb9095037, Offset: 0xb3
// Size: 0x20
function autoexec main()
{
    utility::registersharedfunc( #"zm_dinj", #"init", &init );
}

// Namespace zm_mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0xc981c2, Offset: 0xdb
// Size: 0x197
function private init()
{
    utility::registersharedfunc( #"zm_dinj", #"setcontext", &setcontext );
    utility::registersharedfunc( #"zm_dinj", #"starttransformation", &starttransformation );
    utility::registersharedfunc( #"zm_dinj", #"getnearbytargets", &getnearbytargets );
    utility::registersharedfunc( #"zm_dinj", #"hash_63554db87d064a6b", &function_a3f71ecb6eb404cc );
    utility::registersharedfunc( #"zm_dinj", #"hash_737633f5a317c5cf", &function_5da7e225cbfb13ae );
    utility::registersharedfunc( #"zm_dinj", #"removemutantinjection", &removemutantinjection );
    utility::registersharedfunc( #"zm_dinj", #"hash_9b359784e8530f5", &function_ba3d79cb556f9f5a );
    utility::registersharedfunc( #"zm_dinj", #"hash_d2f6004b101d75ea", &function_c059fcb8b93ffa03 );
    utility::registersharedfunc( #"zm_dinj", #"give_ammo", &full_ammo::function_cf46f312587658ee );
    utility::registersharedfunc( #"zm_dinj", #"drainlife", &watchdrainlife );
    utility::registersharedfunc( #"zm_dinj", #"hash_25813f7a5a02ae90", &function_c700123edd4ca05f );
    utility::registersharedfunc( #"zm_dinj", #"scream", &function_ba1287ece709a0eb );
    utility::registersharedfunc( #"zm_dinj", #"hash_73388df4a8875c87", &function_8f9f9a1061809b7a );
    mutant_injection_disciple_zombies::init();
    level thread register_on_kill_medal();
}

// Namespace zm_mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0x1eb66583, Offset: 0x27a
// Size: 0xb9
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        bundle = level.streakglobals.streakbundles[ "zm_dinj" ];
        
        if ( bundle.mutantinjectiondata.var_46baaf51940dbaae != "" )
        {
            weapon_name = utility::get_scripted_weapon_name( bundle.mutantinjectiondata.var_46baaf51940dbaae );
            
            if ( isdefined( weapon_name ) )
            {
                utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weapon_name, &on_killed_medal );
            }
        }
    }
}

// Namespace zm_mutant_injection_disciple
// Params 4, eflags: 0x4
// Checksum 0x554ad67e, Offset: 0x33b
// Size: 0x12c
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "zm_dinj", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "zm_dinj" ] ) && self.rapidkill_data[ "zm_dinj" ].rapidkill_count == 15 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_embracedarkness" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_embracedarkness" );
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "zm_dinj", victim );
    }
}

// Namespace zm_mutant_injection_disciple
// Params 2, eflags: 0x4
// Checksum 0xaa257374, Offset: 0x46f
// Size: 0x58
function private setcontext( config, streakinfo )
{
    mutant_injection_disciple_zombies::setcontext( config, streakinfo );
    
    if ( isdefined( self.micontext ) )
    {
        self.micontext.var_20b536a9378bf072 = 1;
        self.micontext.var_351060baffe07228 = 1;
    }
}

// Namespace zm_mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0xef46a3ab, Offset: 0x4cf
// Size: 0x9
function private starttransformation()
{
    mutant_injection_disciple_zombies::starttransformation();
}

// Namespace zm_mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x5ee1a941, Offset: 0x4e0
// Size: 0x14
function private getnearbytargets( radius )
{
    return mutant_injection_disciple_zombies::getnearbytargets( radius );
}

// Namespace zm_mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0xa77f5cbd, Offset: 0x4fd
// Size: 0x14, Type: bool
function private function_a3f71ecb6eb404cc( target )
{
    return mutant_injection_disciple_zombies::function_a3f71ecb6eb404cc( target );
}

// Namespace zm_mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0xb57a3b78, Offset: 0x51a
// Size: 0x14
function private function_5da7e225cbfb13ae( target )
{
    return mutant_injection_disciple_zombies::function_5da7e225cbfb13ae( target );
}

// Namespace zm_mutant_injection_disciple
// Params 2, eflags: 0x4
// Checksum 0x28166773, Offset: 0x537
// Size: 0x2f
function private removemutantinjection( istimeout = 0, skipanimation = 0 )
{
    mutant_injection_disciple_zombies::removemutantinjection( istimeout, skipanimation );
}

// Namespace zm_mutant_injection_disciple
// Params 4, eflags: 0x4
// Checksum 0xe319fff8, Offset: 0x56e
// Size: 0x34
function private function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale )
{
    mutant_injection_disciple_zombies::function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale );
}

// Namespace zm_mutant_injection_disciple
// Params 2, eflags: 0x4
// Checksum 0x3dbf05bb, Offset: 0x5aa
// Size: 0x1e
function private function_c059fcb8b93ffa03( target, damagescale )
{
    return mutant_injection_disciple_zombies::function_c059fcb8b93ffa03( target, damagescale );
}

// Namespace zm_mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0xe1f6e5, Offset: 0x5d1
// Size: 0x9
function private watchdrainlife()
{
    thread mutant_injection_disciple_zombies::watchdrainlife();
}

// Namespace zm_mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0x1a95962a, Offset: 0x5e2
// Size: 0x9
function private function_c700123edd4ca05f()
{
    thread mutant_injection_disciple_zombies::function_c700123edd4ca05f();
}

// Namespace zm_mutant_injection_disciple
// Params 0, eflags: 0x4
// Checksum 0x2222db78, Offset: 0x5f3
// Size: 0x9
function private function_ba1287ece709a0eb()
{
    thread mutant_injection_disciple_zombies::function_ba1287ece709a0eb();
}

// Namespace zm_mutant_injection_disciple
// Params 1, eflags: 0x4
// Checksum 0x9602f145, Offset: 0x604
// Size: 0x1ef
function private function_8f9f9a1061809b7a( params )
{
    heavy_damage_value = 30;
    
    if ( params.idamage >= heavy_damage_value && self.health > 1 )
    {
        damage = params.idamage >= self.health ? self.health - 1 : params.idamage;
        var_ca02bfdd611a56f4 = self.health;
        damage::preplayerdamaged( params.einflictor, params.eattacker, self, damage, params.idflags, params.smeansofdeath, params.objweapon, params.vpoint, params.vdir, params.shitloc, 0, 0, #"none" );
        damage::finishplayerdamagewrapper( params.einflictor, params.eattacker, damage, params.idflags, params.smeansofdeath, 0, params.objweapon, params.vpoint, params.vdir, params.shitloc, 0, 0, #"none", 1 );
        damage::postplayerdamaged( params.einflictor, params.eattacker, self, damage, params.idflags, params.smeansofdeath, params.objweapon, params.vpoint, params.vdir, params.shitloc, 0, 0, #"none", 0, 0, var_ca02bfdd611a56f4 );
        self.health = max( self.health, 2 );
    }
}

