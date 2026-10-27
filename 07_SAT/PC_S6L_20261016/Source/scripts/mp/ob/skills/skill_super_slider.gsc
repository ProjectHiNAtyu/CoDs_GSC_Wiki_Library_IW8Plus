// scripts\mp\ob\skills\skill_super_slider.gsc  (hash_0e48056c2bee5a0c.gscc) (size: 1642 Bytes / 0x66a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3f430e8d (1061359245)
// size ...... 1642 (0x66a)
// includes .. 5   (offset: 0x602)
// strings ... 3   (offset: 0x62a)
// dev strs .. 0   (offset: 0x66a)
// exports ... 7   (offset: 0x2f6)
// cseg ...... 0x91 + 0x265 (0x2f6)
// imports ... 17  (offset: 0x40e)
// animtree1 . 0   (offset: 0x66a)
// animtree2 . 0   (offset: 0x66a)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\augments\phd_flopper_augments;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace skill_super_slider;

// Namespace skill_super_slider
// Params 0, eflags: 0x1
// Checksum 0xb7c65720, Offset: 0xaf
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"super_slider", &init );
}

// Namespace skill_super_slider
// Params 0, eflags: 0x4
// Checksum 0x4f6a7d9d, Offset: 0xce
// Size: 0x3e
function private init()
{
    utility::registersharedfunc( #"super_slider", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"super_slider", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_super_slider
// Params 1, eflags: 0x4
// Checksum 0xb25ba073, Offset: 0x114
// Size: 0x3e, Type: bool
function private on_give_skill( skill_bundle )
{
    thread function_dcc0ad159dd2b87d( skill_bundle );
    sprint_speed_factor = skill_bundle.var_4a43cd5b805b8db4;
    
    if ( sprint_speed_factor > 0 )
    {
        thread monitor_sprint_boost( sprint_speed_factor );
    }
    
    return true;
}

// Namespace skill_super_slider
// Params 1, eflags: 0x4
// Checksum 0x732e386c, Offset: 0x15b
// Size: 0x89
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"hash_89ea9f09b2460457" );
    
    if ( skill_bundle.var_4a43cd5b805b8db4 > 0 )
    {
        self notify( #"hash_de2a28b1060f6329" );
        var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
        
        if ( var_6b3038b8c446034e )
        {
            if ( common::function_8ff835bf23198a0( "skill_super_slider_fast_sprint" ) )
            {
                common::function_d85a92c557ea5a52( "skill_super_slider_fast_sprint" );
            }
        }
        else if ( weapons::function_67041fa03f87323c( "skill_super_slider_fast_sprint" ) )
        {
            weapons::removeextramovespeed( "skill_super_slider_fast_sprint" );
        }
        
        weapons::updatemovespeedscale();
    }
}

// Namespace skill_super_slider
// Params 1, eflags: 0x4
// Checksum 0x37f1f486, Offset: 0x1ec
// Size: 0x38
function private function_dcc0ad159dd2b87d( skill_bundle )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_89ea9f09b2460457" );
    childthread phd_flopper_augments::function_ba18f0bad6c5c091( skill_bundle.var_a72bcf6a9ec52048, 1 );
}

// Namespace skill_super_slider
// Params 1, eflags: 0xc
// Checksum 0xf8b442b9, Offset: 0x22c
// Size: 0xca
function private monitor_sprint_boost( var_8c11ac947531381d )
{
    self notify( #"hash_477a6fc2c12a20b2" );
    self endon( #"hash_477a6fc2c12a20b2" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_de2a28b1060f6329" );
    
    while ( true )
    {
        self waittill( #"sprint_begin" );
        var_6b3038b8c446034e = weapons::function_1a21795a419517d7();
        
        if ( var_6b3038b8c446034e )
        {
            common::function_983eeeeb432f3d8( "skill_super_slider_fast_sprint", undefined, undefined, undefined, var_8c11ac947531381d );
        }
        else
        {
            weapons::addextramovespeed( "skill_super_slider_fast_sprint", var_8c11ac947531381d );
        }
        
        weapons::updatemovespeedscale();
        utility::waittill_any( "death", "sprint_end" );
        
        if ( var_6b3038b8c446034e )
        {
            common::function_d85a92c557ea5a52( "skill_super_slider_fast_sprint" );
        }
        else
        {
            weapons::removeextramovespeed( "skill_super_slider_fast_sprint" );
        }
        
        weapons::updatemovespeedscale();
        waitframe();
    }
}

