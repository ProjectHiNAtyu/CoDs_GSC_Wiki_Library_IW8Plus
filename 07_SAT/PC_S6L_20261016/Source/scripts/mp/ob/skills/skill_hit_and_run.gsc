// scripts\mp\ob\skills\skill_hit_and_run.gsc  (hash_7d4e1cd0b067c5b0.gscc) (size: 1901 Bytes / 0x76d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b048e12 (2063896082)
// size ...... 1901 (0x76d)
// includes .. 7   (offset: 0x701)
// strings ... 2   (offset: 0x739)
// dev strs .. 0   (offset: 0x76d)
// exports ... 7   (offset: 0x3b9)
// cseg ...... 0x78 + 0x341 (0x3b9)
// imports ... 19  (offset: 0x4d1)
// animtree1 . 0   (offset: 0x76d)
// animtree2 . 0   (offset: 0x76d)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace skill_hit_and_run;

// Namespace skill_hit_and_run
// Params 0, eflags: 0x1
// Checksum 0x9029b0c6, Offset: 0x96
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"hit_and_run", &init );
}

// Namespace skill_hit_and_run
// Params 0
// Checksum 0x9481a5d1, Offset: 0xb5
// Size: 0x68
function init()
{
    utility::registersharedfunc( #"hit_and_run", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"hit_and_run", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    callback::add( #"on_ai_killed", &function_169d1ccb4f276163 );
    callback::add( #"player_death", &function_169d1ccb4f276163 );
}

// Namespace skill_hit_and_run
// Params 1, eflags: 0x4
// Checksum 0x92d96bbc, Offset: 0x125
// Size: 0x23, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_2ce3ef5dbff170ce = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_hit_and_run
// Params 1, eflags: 0x4
// Checksum 0x91917ef2, Offset: 0x151
// Size: 0x22
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"end_hit_and_run" );
    self.var_2ce3ef5dbff170ce = undefined;
}

// Namespace skill_hit_and_run
// Params 1
// Checksum 0x3bdd4a66, Offset: 0x17b
// Size: 0xf7
function function_e610911f5c08da4a( bundle )
{
    self notify( #"hash_3ae2635655a951fd" );
    self endon( #"hash_3ae2635655a951fd" );
    factor = bundle.var_4837d485bf108ca0;
    duration = bundle.var_15c0bcdcaed76b0b;
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( !common::function_8ff835bf23198a0( "skill_hit_and_run" ) )
        {
            common::function_ac4bf3256b2545e3( "skill_hit_and_run", factor );
        }
    }
    else if ( !weapons::function_67041fa03f87323c( "skill_hit_and_run" ) )
    {
        weapons::addextramovespeed( "skill_hit_and_run", factor );
    }
    
    weapons::updatemovespeedscale();
    wait duration;
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( common::function_8ff835bf23198a0( "skill_hit_and_run" ) )
        {
            common::function_d85a92c557ea5a52( "skill_hit_and_run" );
        }
    }
    else if ( weapons::function_67041fa03f87323c( "skill_hit_and_run" ) )
    {
        weapons::removeextramovespeed( "skill_hit_and_run" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace skill_hit_and_run
// Params 1
// Checksum 0x922b99e6, Offset: 0x27a
// Size: 0x13f
function function_169d1ccb4f276163( sparams )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    player = sparams.eattacker ?? sparams.attacker;
    var_da55798eb12048a0 = player.var_2ce3ef5dbff170ce;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( isplayer( self ) && !bundle.var_a137ad27cbd45923 )
    {
        return;
    }
    
    inflictor = sparams.einflictor ?? sparams.inflictor;
    weapon = sparams.sweapon ?? sparams.objweapon;
    is_weapon_equipment = weapon && weapon != level.weaponnone && equipment_mp::function_65ff545a795c7f55( weapon );
    
    if ( ( inflictor.isequipment || is_weapon_equipment ) && !weapon::issuperweapon( weapon ) )
    {
        self endon( #"death_or_disconnect" );
        self endon( #"end_hit_and_run" );
        player childthread function_e610911f5c08da4a( bundle );
    }
}

