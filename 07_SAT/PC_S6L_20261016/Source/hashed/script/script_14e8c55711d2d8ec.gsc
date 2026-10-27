// script_14e8c55711d2d8ec  (hash_14e8c55711d2d8ec.gscc) (size: 1077 Bytes / 0x435 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf7d2601 (3749520897)
// size ...... 1077 (0x435)
// includes .. 3   (offset: 0x3d5)
// strings ... 4   (offset: 0x3ed)
// dev strs .. 0   (offset: 0x435)
// exports ... 5   (offset: 0x215)
// cseg ...... 0xd4 + 0x141 (0x215)
// imports ... 8   (offset: 0x2dd)
// animtree1 . 0   (offset: 0x435)
// animtree2 . 0   (offset: 0x435)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace namespace_367af34657488731;

// Namespace namespace_367af34657488731
// Params 0, eflags: 0x1
// Checksum 0x2cd76eca, Offset: 0xf2
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"gun_handler", &init );
}

// Namespace namespace_367af34657488731
// Params 0
// Checksum 0xee748519, Offset: 0x111
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"gun_handler", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"gun_handler", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace namespace_367af34657488731
// Params 1, eflags: 0x4
// Checksum 0xfd2e57eb, Offset: 0x157
// Size: 0x52, Type: bool
function private on_give_skill( skill_bundle )
{
    perk::giveperk( "specialty_hip_fire_spread_reduce" );
    perk::giveperk( "specialty_reduce_flinch" );
    self setclientomnvar( "skill_gun_handler_perk_tier", skill_bundle.skilllevel );
    self setclientomnvar( "skill_gun_flinch_perk_tier", skill_bundle.skilllevel );
    return true;
}

// Namespace namespace_367af34657488731
// Params 1, eflags: 0x4
// Checksum 0x5032f8f, Offset: 0x1b2
// Size: 0x63
function private function_c51f1692ecb73bfe( skill_bundle )
{
    if ( isdefined( self.perks[ "specialty_hip_fire_spread_reduce" ] ) )
    {
        perk::removeperk( "specialty_hip_fire_spread_reduce" );
    }
    
    if ( isdefined( self.perks[ "specialty_reduce_flinch" ] ) )
    {
        perk::removeperk( "specialty_reduce_flinch" );
    }
    
    self setclientomnvar( "skill_gun_handler_perk_tier", -1 );
    self setclientomnvar( "skill_gun_flinch_perk_tier", 0 );
}

