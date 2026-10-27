// script_79163430ceabbd6b  (hash_79163430ceabbd6b.gscc) (size: 1705 Bytes / 0x6a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x26a746cd (648496845)
// size ...... 1705 (0x6a9)
// includes .. 4   (offset: 0x689)
// strings ... 0   (offset: 0x6a9)
// dev strs .. 0   (offset: 0x6a9)
// exports ... 9   (offset: 0x355)
// cseg ...... 0x58 + 0x2fd (0x355)
// imports ... 15  (offset: 0x4bd)
// animtree1 . 0   (offset: 0x6a9)
// animtree2 . 0   (offset: 0x6a9)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\armor;

#namespace skill_overcharge_upgrade;

// Namespace skill_overcharge_upgrade
// Params 0, eflags: 0x1
// Checksum 0x88f87490, Offset: 0x76
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"overcharge_upgrade", &init );
}

// Namespace skill_overcharge_upgrade
// Params 0
// Checksum 0xb5caa7e1, Offset: 0x95
// Size: 0x98
function init()
{
    utility::registersharedfunc( #"overcharge_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"overcharge_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"super_overcharge", #"hash_5414cd4daff8eb00", &function_cdb3b96701b9927f );
    utility::registersharedfunc( #"super_overcharge", #"hash_93a2a2cba40b1c22", &function_4ac07585d03c0c8 );
    utility::registersharedfunc( #"super_overcharge", #"hash_429fa6953cdb7c8e", &function_5e5b55c51d94bf37 );
}

// Namespace skill_overcharge_upgrade
// Params 1, eflags: 0x4
// Checksum 0x25e9c5df, Offset: 0x135
// Size: 0x63, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_379c420991640594 = { #bundle:skill_bundle };
    
    if ( skill_bundle.var_373164a1a9ad6e )
    {
        assert( !callback::exists( #"resupply_armor_plates", &function_f122a14fd79c6182 ) );
        callback::add( #"resupply_armor_plates", &function_f122a14fd79c6182 );
    }
    
    return true;
}

// Namespace skill_overcharge_upgrade
// Params 1, eflags: 0x4
// Checksum 0x138363c1, Offset: 0x1a1
// Size: 0x55
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( skill_bundle.var_373164a1a9ad6e )
    {
        assert( callback::exists( #"resupply_armor_plates", &function_f122a14fd79c6182 ) );
        callback::remove( #"resupply_armor_plates", &function_f122a14fd79c6182 );
    }
    
    self.var_379c420991640594 = undefined;
}

// Namespace skill_overcharge_upgrade
// Params 0, eflags: 0x4
// Checksum 0xdf6f04c1, Offset: 0x1fe
// Size: 0x1f
function private function_cdb3b96701b9927f()
{
    return self.var_379c420991640594.bundle.var_6cbe537c293b1ee9;
}

// Namespace skill_overcharge_upgrade
// Params 1, eflags: 0x4
// Checksum 0x4b519615, Offset: 0x226
// Size: 0x71
function private function_f122a14fd79c6182( params )
{
    assert( params.platecount );
    assert( params.buffedplayer );
    
    if ( params.source != #"super_overcharge" )
    {
        return;
    }
    
    params.buffedplayer armor::function_d6afc5a95480993d( params.platecount, o"ui_skill_pick_up_master_feedback" );
}

// Namespace skill_overcharge_upgrade
// Params 1, eflags: 0x4
// Checksum 0xba7cebf5, Offset: 0x29f
// Size: 0x83
function private function_4ac07585d03c0c8( buffed_player )
{
    var_da55798eb12048a0 = self.var_379c420991640594;
    
    if ( !var_da55798eb12048a0 )
    {
        return 0;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    
    if ( self == buffed_player )
    {
        return bundle.var_6c9cbc0629e9865c;
    }
    else if ( self.sessionsquadid == buffed_player.sessionsquadid )
    {
        return bundle.var_17a0949edd2b782d;
    }
    
    return bundle.var_81a1be755e81388;
}

// Namespace skill_overcharge_upgrade
// Params 1, eflags: 0x4
// Checksum 0x777f13b5, Offset: 0x32b
// Size: 0x29
function private function_5e5b55c51d94bf37( params )
{
    return self.var_379c420991640594.bundle.var_81a1be755e81388;
}

