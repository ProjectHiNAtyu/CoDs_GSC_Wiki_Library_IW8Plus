// scripts\mp\ob\skills\skill_longer_tac_sprint.gsc  (hash_70fda6635e18f4ea.gscc) (size: 1954 Bytes / 0x7a2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x31428edb (826445531)
// size ...... 1954 (0x7a2)
// includes .. 5   (offset: 0x702)
// strings ... 6   (offset: 0x72a)
// dev strs .. 0   (offset: 0x7a2)
// exports ... 7   (offset: 0x37e)
// cseg ...... 0xf7 + 0x287 (0x37e)
// imports ... 21  (offset: 0x496)
// animtree1 . 0   (offset: 0x7a2)
// animtree2 . 0   (offset: 0x7a2)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace skill_longer_tac_sprint;

// Namespace skill_longer_tac_sprint
// Params 0, eflags: 0x1
// Checksum 0x41a0b305, Offset: 0x115
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"longer_tac_sprint", &init );
}

// Namespace skill_longer_tac_sprint
// Params 0, eflags: 0x4
// Checksum 0x5ab98903, Offset: 0x134
// Size: 0x3e
function private init()
{
    utility::registersharedfunc( #"longer_tac_sprint", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"longer_tac_sprint", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_longer_tac_sprint
// Params 1, eflags: 0x4
// Checksum 0x6927142a, Offset: 0x17a
// Size: 0x6f, Type: bool
function private on_give_skill( skill_bundle )
{
    perk::giveperk( "specialty_skill_longer_tac_sprint" );
    self setclientomnvar( "skill_longer_tac_sprint_perk_tier", skill_bundle.skilllevel );
    
    if ( skill_bundle.var_a9a1830d37226982 )
    {
        perk::giveperk( "specialty_supersprintreload" );
    }
    
    var_8c11ac947531381d = skill_bundle.var_673b1af5260099b8;
    
    if ( var_8c11ac947531381d )
    {
        thread monitor_reload( var_8c11ac947531381d );
    }
    
    return true;
}

// Namespace skill_longer_tac_sprint
// Params 1, eflags: 0x4
// Checksum 0xc388f739, Offset: 0x1f2
// Size: 0x6b
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( isdefined( self.perks[ "specialty_skill_longer_tac_sprint" ] ) )
    {
        perk::removeperk( "specialty_skill_longer_tac_sprint" );
    }
    
    self setclientomnvar( "skill_longer_tac_sprint_perk_tier", 0 );
    
    if ( isdefined( self.perks[ "specialty_supersprintreload" ] ) )
    {
        perk::removeperk( "specialty_supersprintreload" );
    }
    
    if ( skill_bundle.var_673b1af5260099b8 )
    {
        function_d0f82a7dd2637b82();
    }
}

// Namespace skill_longer_tac_sprint
// Params 1, eflags: 0x4
// Checksum 0x556a630e, Offset: 0x265
// Size: 0xae
function private monitor_reload( var_8c11ac947531381d )
{
    self endon( #"hash_d3522faf6456d884" );
    
    while ( true )
    {
        self waittill( #"reload_start" );
        
        if ( self issupersprinting() )
        {
            var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
            
            if ( var_6b3038b8c446034e )
            {
                common::function_983eeeeb432f3d8( "skill_longer_tac_sprint", undefined, undefined, undefined, var_8c11ac947531381d );
            }
            else
            {
                weapons::addextramovespeed( "skill_longer_tac_sprint", var_8c11ac947531381d );
            }
            
            weapons::updatemovespeedscale();
            utility::waittill_any( "reload", "weapon_change" );
            
            if ( var_6b3038b8c446034e )
            {
                common::function_d85a92c557ea5a52( "skill_longer_tac_sprint" );
            }
            else
            {
                weapons::removeextramovespeed( "skill_longer_tac_sprint" );
            }
            
            weapons::updatemovespeedscale();
        }
        
        waitframe();
    }
}

// Namespace skill_longer_tac_sprint
// Params 0, eflags: 0x4
// Checksum 0x855f2150, Offset: 0x31b
// Size: 0x63
function private function_d0f82a7dd2637b82()
{
    self notify( #"hash_d3522faf6456d884" );
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( common::function_8ff835bf23198a0( "skill_longer_tac_sprint" ) )
        {
            common::function_d85a92c557ea5a52( "skill_longer_tac_sprint" );
        }
    }
    else if ( weapons::function_67041fa03f87323c( "skill_longer_tac_sprint" ) )
    {
        weapons::removeextramovespeed( "skill_longer_tac_sprint" );
    }
    
    weapons::updatemovespeedscale();
}

