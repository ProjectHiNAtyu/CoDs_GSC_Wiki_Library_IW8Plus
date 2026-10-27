// script_1d5390b3b99a1f0b  (hash_1d5390b3b99a1f0b.gscc) (size: 2724 Bytes / 0xaa4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e21cc3b (1042402363)
// size ...... 2724 (0xaa4)
// includes .. 7   (offset: 0xa10)
// strings ... 3   (offset: 0xa48)
// dev strs .. 3   (offset: 0xa80)
// exports ... 9   (offset: 0x4f4)
// cseg ...... 0x9e + 0x456 (0x4f4)
// imports ... 33  (offset: 0x65c)
// animtree1 . 0   (offset: 0xaa4)
// animtree2 . 0   (offset: 0xaa4)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace skill_death_machine_upgrade;

// Namespace skill_death_machine_upgrade
// Params 0, eflags: 0x1
// Checksum 0x5582cdde, Offset: 0xbc
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"death_machine_upgrade", &init );
}

// Namespace skill_death_machine_upgrade
// Params 0
// Checksum 0x11d982c7, Offset: 0xdb
// Size: 0x6a
function init()
{
    utility::registersharedfunc( #"death_machine_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"death_machine_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    level callback::add( #"on_ai_killed", &function_7fac2b4d81927b4b );
    level callback::add( #"player_death", &function_7fac2b4d81927b4b );
}

// Namespace skill_death_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0xb990d2bb, Offset: 0x14d
// Size: 0x46, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_e88f7338bd6ea073 = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_8740869960ca9041 )
    {
        callback::add( #"super_death_machine_begin_use", &function_e2db3441f7c4d55e );
    }
    
    return true;
}

// Namespace skill_death_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0x8ffa74f2, Offset: 0x19c
// Size: 0x39
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_8740869960ca9041 )
    {
        callback::remove( #"super_death_machine_begin_use", &function_e2db3441f7c4d55e );
    }
    
    self.var_e88f7338bd6ea073 = undefined;
}

// Namespace skill_death_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0x58f78f98, Offset: 0x1dd
// Size: 0x1df
function private function_7fac2b4d81927b4b( params )
{
    player = params.eattacker ?? params.attacker;
    
    if ( !player )
    {
        return;
    }
    
    var_da55798eb12048a0 = player.var_e88f7338bd6ea073;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( !bundle.var_fd3b9df6f7ef96ab || !bundle.var_c56997827f74988f || !bundle.abilityref )
    {
        return;
    }
    
    weapon = params.sweapon ?? params.objweapon;
    var_e93a67c34276fb3f = supers_mp::getsuperrefforsuperweapon( weapon );
    
    if ( !var_e93a67c34276fb3f || getxhash( var_e93a67c34276fb3f ) != bundle.abilityref )
    {
        return;
    }
    
    is_critical = damage_utility::isheadshot( params.shitloc, params.smeansofdeath, player );
    
    if ( !is_critical && !params.victim.last_dmg_struct.biscritical )
    {
        return;
    }
    
    if ( !utility::percent_chance( bundle.var_fd3b9df6f7ef96ab ) )
    {
        return;
    }
    
    current_ammo = player getweaponammoclip( weapon );
    max_ammo = weaponclipsize( weapon );
    var_bd48e8dd61a3c03c = int( clamp( bundle.var_c56997827f74988f, 0, max_ammo - current_ammo ) );
    
    if ( var_bd48e8dd61a3c03c > 0 )
    {
        /#
            if ( getdvarint( @"hash_e0f89f2a4bd4ff98", 0 ) )
            {
                iprintlnbold( "<dev string:x24>" + current_ammo + "<dev string:x33>" + var_bd48e8dd61a3c03c + "<dev string:x37>" + current_ammo + var_bd48e8dd61a3c03c );
            }
        #/
        
        player setweaponammoclip( weapon, current_ammo + var_bd48e8dd61a3c03c );
    }
}

// Namespace skill_death_machine_upgrade
// Params 1, eflags: 0x4
// Checksum 0xf067ac85, Offset: 0x3c4
// Size: 0x63
function private function_e2db3441f7c4d55e( params )
{
    self endon( #"death", #"disconnect" );
    super_slot = supers_mp::getsuperslot( "super_death_machine" );
    var_c78aab349cd77c0d = supers_mp::function_cc6f5a44b1441e16( super_slot, "super_use_finished" );
    start_speed_boost();
    self waittill( var_c78aab349cd77c0d );
    clear_speed_boost();
}

// Namespace skill_death_machine_upgrade
// Params 0, eflags: 0x4
// Checksum 0x2f91307c, Offset: 0x42f
// Size: 0x66
function private start_speed_boost()
{
    var_8c11ac947531381d = self.var_e88f7338bd6ea073.bundle.var_8740869960ca9041;
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        common::function_ac4bf3256b2545e3( "death_machine_upgrade", var_8c11ac947531381d );
    }
    else
    {
        weapons::addextramovespeed( "death_machine_upgrade", var_8c11ac947531381d );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace skill_death_machine_upgrade
// Params 0, eflags: 0x4
// Checksum 0xa7988fe4, Offset: 0x49d
// Size: 0x57
function private clear_speed_boost()
{
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( common::function_8ff835bf23198a0( "death_machine_upgrade" ) )
        {
            common::function_d85a92c557ea5a52( "death_machine_upgrade" );
        }
    }
    else if ( weapons::function_67041fa03f87323c( "death_machine_upgrade" ) )
    {
        weapons::removeextramovespeed( "death_machine_upgrade" );
    }
    
    weapons::updatemovespeedscale();
}

