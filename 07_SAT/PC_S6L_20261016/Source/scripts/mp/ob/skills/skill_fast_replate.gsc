// scripts\mp\ob\skills\skill_fast_replate.gsc  (hash_3769680bff709367.gscc) (size: 1537 Bytes / 0x601 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8d01c19d (2365702557)
// size ...... 1537 (0x601)
// includes .. 3   (offset: 0x5a1)
// strings ... 2   (offset: 0x5b9)
// dev strs .. 3   (offset: 0x5dd)
// exports ... 7   (offset: 0x31d)
// cseg ...... 0x98 + 0x285 (0x31d)
// imports ... 12  (offset: 0x435)
// animtree1 . 0   (offset: 0x601)
// animtree2 . 0   (offset: 0x601)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace skill_fast_replate;

// Namespace skill_fast_replate
// Params 0, eflags: 0x1
// Checksum 0x684e54d0, Offset: 0xb6
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"fast_replate", &init );
}

// Namespace skill_fast_replate
// Params 0
// Checksum 0xf0893f09, Offset: 0xd5
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"fast_replate", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"fast_replate", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"fast_replate", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_fast_replate
// Params 1, eflags: 0x4
// Checksum 0x6f5d7291, Offset: 0x139
// Size: 0x79
function private function_1321989bae991e4f( skill_bundle )
{
    time_scale = get_armor_plate_time_scale( skill_bundle.skilllevel );
    
    if ( skill_bundle.var_36d92ab90802deef )
    {
        skill_bundle.var_512377cf3cc9871 = time_scale * skill_bundle.var_36d92ab90802deef;
    }
    
    if ( skill_bundle.var_e9d3462354b3f278 )
    {
        skill_bundle.var_be984451d5c647a = time_scale * skill_bundle.var_e9d3462354b3f278;
    }
}

// Namespace skill_fast_replate
// Params 1, eflags: 0x4
// Checksum 0x25e010fd, Offset: 0x1ba
// Size: 0x8d, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_2971918bccb78795, "<dev string:x24>" );
    assert( skill_bundle.var_512377cf3cc9871, "<dev string:x75>" );
    assert( skill_bundle.var_be984451d5c647a, "<dev string:xbe>" );
    self.var_3a179564ddf30dd8 = { #bundle:skill_bundle };
    perk::giveperk( "specialty_skill_fast_replate" );
    self setclientomnvar( "skill_fast_replate_perk_tier", skill_bundle.skilllevel );
    return true;
}

// Namespace skill_fast_replate
// Params 1, eflags: 0x4
// Checksum 0x9e8e5325, Offset: 0x250
// Size: 0x41
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( isdefined( self.perks[ "specialty_skill_fast_replate" ] ) )
    {
        perk::removeperk( "specialty_skill_fast_replate" );
    }
    
    self setclientomnvar( "skill_fast_replate_perk_tier", 0 );
    self.var_3a179564ddf30dd8 = undefined;
}

// Namespace skill_fast_replate
// Params 1, eflags: 0x4
// Checksum 0xd1ef7f21, Offset: 0x299
// Size: 0x83
function private get_armor_plate_time_scale( skill_level )
{
    timescale = 1;
    
    switch ( skill_level )
    {
        case 0:
            timescale = getdvarfloat( @"hash_334ad5571187f4e2" );
            break;
        case 1:
            timescale = getdvarfloat( @"hash_334ad6571187f715" );
            break;
        case 2:
            timescale = getdvarfloat( @"hash_334ad3571187f07c" );
            break;
    }
    
    return timescale;
}

