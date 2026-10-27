// scripts\mp\ob\skills\skill_sprint_shot.gsc  (hash_15b3eaa4f332b304.gscc) (size: 1845 Bytes / 0x735 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2a11381b (705771547)
// size ...... 1845 (0x735)
// includes .. 6   (offset: 0x6c9)
// strings ... 2   (offset: 0x6f9)
// dev strs .. 0   (offset: 0x735)
// exports ... 8   (offset: 0x305)
// cseg ...... 0x85 + 0x280 (0x305)
// imports ... 22  (offset: 0x445)
// animtree1 . 0   (offset: 0x735)
// animtree2 . 0   (offset: 0x735)
#using script_2fe74ee229c972c3;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace skill_sprint_shot;

// Namespace skill_sprint_shot
// Params 0, eflags: 0x1
// Checksum 0x99c3c399, Offset: 0xa3
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"sprint_shot", &init );
}

// Namespace skill_sprint_shot
// Params 0
// Checksum 0x91261df1, Offset: 0xc2
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"sprint_shot", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"sprint_shot", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_sprint_shot
// Params 1, eflags: 0x4
// Checksum 0xcc371591, Offset: 0x108
// Size: 0x3a, Type: bool
function private on_give_skill( skill_bundle )
{
    perk::giveperk( "specialty_sprintfire" );
    
    if ( skill_bundle.var_cc7daab17cdfb326 )
    {
        thread function_e31cb4e0f5f8c219( skill_bundle.var_cc7daab17cdfb326 );
    }
    
    return true;
}

// Namespace skill_sprint_shot
// Params 1, eflags: 0x4
// Checksum 0xa217d074, Offset: 0x14b
// Size: 0x2b
function private function_c51f1692ecb73bfe( skill_bundle )
{
    function_6db9e994bb3709af();
    perk::removeperk( "specialty_sprintfire" );
    self notify( #"skill_sprint_shot_end" );
}

// Namespace skill_sprint_shot
// Params 1, eflags: 0xc
// Checksum 0xdd48dfeb, Offset: 0x17e
// Size: 0x99
function private function_e31cb4e0f5f8c219( movement_speed_multiplier )
{
    self notify( #"hash_af9c22f517ca63d8" );
    self endon( #"hash_af9c22f517ca63d8" );
    self endon( #"death_or_disconnect" );
    self endon( #"skill_sprint_shot_end" );
    
    if ( !isdefined( level.skill_sprint_shot_throttle ) )
    {
        level.skill_sprint_shot_throttle = throttle::throttle_initialize( "skill_sprint_shot", 4 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.skill_sprint_shot_throttle, self );
        
        if ( self playerads() >= 1 )
        {
            function_75c320e7ffa8562b( movement_speed_multiplier );
        }
        else
        {
            function_6db9e994bb3709af();
        }
        
        waitframe();
    }
}

// Namespace skill_sprint_shot
// Params 1, eflags: 0x4
// Checksum 0xbfca816, Offset: 0x21f
// Size: 0x80
function private function_75c320e7ffa8562b( movement_speed_multiplier )
{
    scaler = movement_speed_multiplier - 1;
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( !common::function_8ff835bf23198a0( "skill_sprint_shot" ) )
        {
            common::function_ac4bf3256b2545e3( "skill_sprint_shot", scaler );
            weapons::updatemovespeedscale();
        }
        
        return;
    }
    
    if ( !weapons::function_67041fa03f87323c( "skill_sprint_shot" ) )
    {
        weapons::addextramovespeed( "skill_sprint_shot", scaler );
        weapons::updatemovespeedscale();
    }
}

// Namespace skill_sprint_shot
// Params 0, eflags: 0x4
// Checksum 0x7b6b0179, Offset: 0x2a7
// Size: 0x5e
function private function_6db9e994bb3709af()
{
    var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
    
    if ( var_6b3038b8c446034e )
    {
        if ( common::function_8ff835bf23198a0( "skill_sprint_shot" ) )
        {
            common::function_d85a92c557ea5a52( "skill_sprint_shot" );
            weapons::updatemovespeedscale();
        }
        
        return;
    }
    
    if ( weapons::function_67041fa03f87323c( "skill_sprint_shot" ) )
    {
        weapons::removeextramovespeed( "skill_sprint_shot" );
        weapons::updatemovespeedscale();
    }
}

