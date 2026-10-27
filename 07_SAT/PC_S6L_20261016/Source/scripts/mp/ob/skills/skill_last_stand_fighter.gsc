// scripts\mp\ob\skills\skill_last_stand_fighter.gsc  (hash_48fcd7481ff5e6a0.gscc) (size: 2089 Bytes / 0x829 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3aa199e (2745833886)
// size ...... 2089 (0x829)
// includes .. 5   (offset: 0x7a5)
// strings ... 4   (offset: 0x7cd)
// dev strs .. 1   (offset: 0x81d)
// exports ... 8   (offset: 0x3ad)
// cseg ...... 0xb4 + 0x2f9 (0x3ad)
// imports ... 24  (offset: 0x4ed)
// animtree1 . 0   (offset: 0x829)
// animtree2 . 0   (offset: 0x829)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\weapons;

#namespace skill_last_stand_fighter;

// Namespace skill_last_stand_fighter
// Params 0, eflags: 0x1
// Checksum 0xd345ebd1, Offset: 0xd2
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"last_stand_fighter", &init );
}

// Namespace skill_last_stand_fighter
// Params 0
// Checksum 0x9d87fe3d, Offset: 0xf1
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"last_stand_fighter", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"last_stand_fighter", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_last_stand_fighter
// Params 1, eflags: 0x4
// Checksum 0x8b736399, Offset: 0x137
// Size: 0x44, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_e322fc154989637a, "<dev string:x24>" );
    self.var_6548468bdfcab076 = { #bundle:skill_bundle };
    thread monitor_last_stand( skill_bundle );
    return true;
}

// Namespace skill_last_stand_fighter
// Params 1, eflags: 0x4
// Checksum 0x9445d57d, Offset: 0x184
// Size: 0xa3
function private monitor_last_stand( bundle )
{
    self endon( #"last_stand_fighter_end" );
    
    while ( true )
    {
        self waittill( #"last_stand_enter" );
        thread function_cf46f312587658ee( bundle );
        var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
        
        if ( var_6b3038b8c446034e )
        {
            common::function_ac4bf3256b2545e3( "skill_last_stand_fighter", bundle.var_e322fc154989637a );
        }
        else
        {
            weapons::addextramovespeed( "skill_last_stand_fighter", bundle.var_e322fc154989637a );
        }
        
        weapons::updatemovespeedscale();
        utility::waittill_any( "last_stand_revived", "last_stand_exit", "last_stand_finished" );
        function_ea44c2a369e2db11();
        waitframe();
    }
}

// Namespace skill_last_stand_fighter
// Params 1, eflags: 0x4
// Checksum 0x52336c42, Offset: 0x22f
// Size: 0xee
function private function_cf46f312587658ee( bundle )
{
    self endon( #"disconnect" );
    self waittill( #"weapon_change" );
    wait level.var_4815c4eaafd6d12c;
    current_pistol = self getcurrentweapon();
    var_5d0c831b13e279b6 = self getweaponammostock( current_pistol );
    self setweaponammostock( current_pistol, var_5d0c831b13e279b6 + bundle.var_e0b430670a491876 );
    pistol_data = item_weapon::function_92b8514cdacab7f9( current_pistol );
    previous_rarity = pistol_data.rarity;
    rarity = bundle.var_6b0ab01089cb1b83 ?? 0;
    
    if ( previous_rarity < rarity )
    {
        item_weapon::function_40e1cbd0e1f47d1a( current_pistol, rarity );
        utility::waittill_any( "last_stand_exit", "last_stand_finished", "last_stand_revived" );
        
        if ( !isalive( self ) )
        {
            self waittill( #"end_respawn" );
        }
        
        item_weapon::function_40e1cbd0e1f47d1a( current_pistol, previous_rarity );
    }
}

// Namespace skill_last_stand_fighter
// Params 0, eflags: 0x4
// Checksum 0x249a4bbe, Offset: 0x325
// Size: 0x57
function private function_ea44c2a369e2db11()
{
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( common::function_8ff835bf23198a0( "skill_last_stand_fighter" ) )
        {
            common::function_d85a92c557ea5a52( "skill_last_stand_fighter" );
        }
    }
    else if ( weapons::function_67041fa03f87323c( "skill_last_stand_fighter" ) )
    {
        weapons::removeextramovespeed( "skill_last_stand_fighter" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace skill_last_stand_fighter
// Params 1, eflags: 0x4
// Checksum 0x94b4bf93, Offset: 0x384
// Size: 0x29
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"last_stand_fighter_end" );
    function_ea44c2a369e2db11();
    self.var_6548468bdfcab076 = undefined;
}

