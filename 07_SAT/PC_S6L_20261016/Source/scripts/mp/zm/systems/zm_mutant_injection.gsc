// scripts\mp\zm\systems\zm_mutant_injection.gsc  (hash_1c0e130ef62d5cd2.gscc) (size: 3225 Bytes / 0xc99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x59c97bfd (1506376701)
// size ...... 3225 (0xc99)
// includes .. 5   (offset: 0xc4d)
// strings ... 2   (offset: 0xc75)
// dev strs .. 0   (offset: 0xc99)
// exports ... 15  (offset: 0x5cd)
// cseg ...... 0x91 + 0x53c (0x5cd)
// imports ... 36  (offset: 0x825)
// animtree1 . 0   (offset: 0xc99)
// animtree2 . 0   (offset: 0xc99)
#using script_16ea1b94f0f381b3;
#using script_790c61e9438e5f33;
#using scripts\common\utility;
#using scripts\mp\common\powerups\full_ammo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_mutant_injection;

// Namespace zm_mutant_injection
// Params 0, eflags: 0x1
// Checksum 0xf7594efe, Offset: 0xaf
// Size: 0x3e
function autoexec main()
{
    utility::registersharedfunc( #"mutant_injection", #"init", &init );
    utility::registersharedfunc( #"mutant_injection", #"hash_e6956c3c0cf05895", &function_ad5970e75455ddc4 );
}

// Namespace zm_mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x7f48347b, Offset: 0xf5
// Size: 0x13d
function private init()
{
    utility::registersharedfunc( #"mutant_injection", #"setcontext", &setcontext );
    utility::registersharedfunc( #"mutant_injection", #"starttransformation", &starttransformation );
    utility::registersharedfunc( #"mutant_injection", #"getnearbytargets", &getnearbytargets );
    utility::registersharedfunc( #"mutant_injection", #"hash_63554db87d064a6b", &function_a3f71ecb6eb404cc );
    utility::registersharedfunc( #"mutant_injection", #"hash_737633f5a317c5cf", &function_5da7e225cbfb13ae );
    utility::registersharedfunc( #"mutant_injection", #"removemutantinjection", &removemutantinjection );
    utility::registersharedfunc( #"mutant_injection", #"hash_9b359784e8530f5", &function_ba3d79cb556f9f5a );
    utility::registersharedfunc( #"mutant_injection", #"hash_d2f6004b101d75ea", &function_c059fcb8b93ffa03 );
    utility::registersharedfunc( #"mutant_injection", #"give_ammo", &full_ammo::function_cf46f312587658ee );
    utility::registersharedfunc( #"mutant_injection", #"hash_1fbae8a038b35137", &function_f989ee62e306cb1c );
    mutant_injection_zombies::init();
    level thread register_on_kill_medal();
}

// Namespace zm_mutant_injection
// Params 0, eflags: 0x4
// Checksum 0x9422d2d8, Offset: 0x23a
// Size: 0x6c
function private register_on_kill_medal()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        weapon_name = utility::get_scripted_weapon_name( #"mutant_injection_cannon" );
        
        if ( isdefined( weapon_name ) )
        {
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", weapon_name, &on_killed_medal );
        }
    }
}

// Namespace zm_mutant_injection
// Params 4, eflags: 0x4
// Checksum 0xd5d33ad0, Offset: 0x2ae
// Size: 0x12c
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "zm_minj", sweapon );
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "zm_minj" ] ) && self.rapidkill_data[ "zm_minj" ].rapidkill_count === 15 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_megalomaniac" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_megalomaniac" );
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"track_scorestreak_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_scorestreak_kill", "zm_minj", victim );
    }
}

// Namespace zm_mutant_injection
// Params 2, eflags: 0x4
// Checksum 0xf38243dc, Offset: 0x3e2
// Size: 0x1f
function private setcontext( config, streakinfo )
{
    mutant_injection_zombies::setcontext( config, streakinfo );
}

// Namespace zm_mutant_injection
// Params 0, eflags: 0x4
// Checksum 0xf15b02a5, Offset: 0x409
// Size: 0x9
function private starttransformation()
{
    mutant_injection_zombies::starttransformation();
}

// Namespace zm_mutant_injection
// Params 1, eflags: 0x4
// Checksum 0x40fc084f, Offset: 0x41a
// Size: 0x14
function private getnearbytargets( radius )
{
    return mutant_injection_zombies::getnearbytargets( radius );
}

// Namespace zm_mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xb962fdb3, Offset: 0x437
// Size: 0x14
function private function_a3f71ecb6eb404cc( target )
{
    return mutant_injection_zombies::function_a3f71ecb6eb404cc( target );
}

// Namespace zm_mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xab679a76, Offset: 0x454
// Size: 0x14
function private function_5da7e225cbfb13ae( target )
{
    return mutant_injection_zombies::function_5da7e225cbfb13ae( target );
}

// Namespace zm_mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x360bc67d, Offset: 0x471
// Size: 0x2f
function private removemutantinjection( istimeout = 0, skipanimation = 0 )
{
    mutant_injection_zombies::removemutantinjection( istimeout, skipanimation );
}

// Namespace zm_mutant_injection
// Params 4, eflags: 0x4
// Checksum 0xfd045ef6, Offset: 0x4a8
// Size: 0x34
function private function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale )
{
    mutant_injection_zombies::function_ba3d79cb556f9f5a( target, vectortotarget, dismember, damagescale );
}

// Namespace zm_mutant_injection
// Params 2, eflags: 0x4
// Checksum 0x23a2a4b5, Offset: 0x4e4
// Size: 0x1e
function private function_c059fcb8b93ffa03( target, damagescale )
{
    return mutant_injection_zombies::function_c059fcb8b93ffa03( target, damagescale );
}

// Namespace zm_mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xf8926831, Offset: 0x50b
// Size: 0x5c, Type: bool
function private function_f989ee62e306cb1c( pos )
{
    if ( isdefined( level.var_d37769d867d961ac ) )
    {
        var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( pos );
        
        if ( isdefined( var_8c4fe62d01999d1e.zone_name ) && arraycontains( level.var_d37769d867d961ac, var_8c4fe62d01999d1e.zone_name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_mutant_injection
// Params 1, eflags: 0x4
// Checksum 0xb96d3763, Offset: 0x570
// Size: 0x5d
function private function_ad5970e75455ddc4( zone_names )
{
    if ( !isdefined( level.var_d37769d867d961ac ) )
    {
        level.var_d37769d867d961ac = [];
    }
    
    if ( isarray( zone_names ) )
    {
        level.var_d37769d867d961ac = arraycombine( level.var_d37769d867d961ac, zone_names );
        return;
    }
    
    level.var_d37769d867d961ac[ level.var_d37769d867d961ac.size ] = zone_names;
}

