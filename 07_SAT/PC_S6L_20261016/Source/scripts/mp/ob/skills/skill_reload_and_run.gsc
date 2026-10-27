// scripts\mp\ob\skills\skill_reload_and_run.gsc  (hash_442dd7fc35742830.gscc) (size: 1618 Bytes / 0x652 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcfbcd5e3 (3485259235)
// size ...... 1618 (0x652)
// includes .. 5   (offset: 0x5f6)
// strings ... 1   (offset: 0x61e)
// dev strs .. 1   (offset: 0x646)
// exports ... 7   (offset: 0x2ca)
// cseg ...... 0x7b + 0x24f (0x2ca)
// imports ... 18  (offset: 0x3e2)
// animtree1 . 0   (offset: 0x652)
// animtree2 . 0   (offset: 0x652)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace skill_reload_and_run;

// Namespace skill_reload_and_run
// Params 0, eflags: 0x1
// Checksum 0x54751f7b, Offset: 0x99
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"reload_and_run", &init );
}

// Namespace skill_reload_and_run
// Params 0
// Checksum 0xe33e5b8d, Offset: 0xb8
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"reload_and_run", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"reload_and_run", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_reload_and_run
// Params 1, eflags: 0x4
// Checksum 0xc0f74194, Offset: 0xfe
// Size: 0x77, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_28680a4a03ee084f && skill_bundle.var_384f582e7158a75c, "<dev string:x24>" );
    self.var_5e32f21f3e9cd538 = { #bundle:skill_bundle };
    
    if ( !callback::exists( #"reload", &on_reload ) )
    {
        callback::add( #"reload", &on_reload );
    }
    
    return true;
}

// Namespace skill_reload_and_run
// Params 1, eflags: 0x4
// Checksum 0xd7db1973, Offset: 0x17e
// Size: 0x3e
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"skill_reload_and_run_end" );
    remove_speed_scale();
    self.var_5e32f21f3e9cd538 = undefined;
    callback::remove( #"reload", &on_reload );
}

// Namespace skill_reload_and_run
// Params 1, eflags: 0xc
// Checksum 0xdcf4ad9f, Offset: 0x1c4
// Size: 0xc1
function private on_reload( params )
{
    self notify( #"hash_dd1b91c1cef34bca" );
    self endon( #"hash_dd1b91c1cef34bca" );
    self endon( #"death" );
    self endon( #"skill_reload_and_run_end" );
    bundle = self.var_5e32f21f3e9cd538.bundle;
    
    if ( !common::function_8ff835bf23198a0( "skill_reload_and_run_reload_end" ) )
    {
        common::function_ac4bf3256b2545e3( "skill_reload_and_run_reload_end", bundle.var_28680a4a03ee084f );
    }
    
    if ( !weapons::function_67041fa03f87323c( "skill_reload_and_run_reload_end" ) )
    {
        weapons::addextramovespeed( "skill_reload_and_run_reload_end", bundle.var_28680a4a03ee084f );
    }
    
    weapons::updatemovespeedscale();
    wait bundle.var_384f582e7158a75c;
    remove_speed_scale();
}

// Namespace skill_reload_and_run
// Params 0, eflags: 0x4
// Checksum 0x274f9fce, Offset: 0x28d
// Size: 0x3d
function private remove_speed_scale()
{
    if ( common::function_8ff835bf23198a0( "skill_reload_and_run_reload_end" ) )
    {
        common::function_d85a92c557ea5a52( "skill_reload_and_run_reload_end" );
    }
    
    if ( weapons::function_67041fa03f87323c( "skill_reload_and_run_reload_end" ) )
    {
        weapons::removeextramovespeed( "skill_reload_and_run_reload_end" );
    }
    
    weapons::updatemovespeedscale();
}

