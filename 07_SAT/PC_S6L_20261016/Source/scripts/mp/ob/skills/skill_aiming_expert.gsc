// scripts\mp\ob\skills\skill_aiming_expert.gsc  (hash_0f089a812dd741dd.gscc) (size: 1227 Bytes / 0x4cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6e245b87 (1847876487)
// size ...... 1227 (0x4cb)
// includes .. 3   (offset: 0x46b)
// strings ... 4   (offset: 0x483)
// dev strs .. 0   (offset: 0x4cb)
// exports ... 5   (offset: 0x28b)
// cseg ...... 0xe8 + 0x1a3 (0x28b)
// imports ... 9   (offset: 0x353)
// animtree1 . 0   (offset: 0x4cb)
// animtree2 . 0   (offset: 0x4cb)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;

#namespace skill_aiming_expert;

// Namespace skill_aiming_expert
// Params 0, eflags: 0x1
// Checksum 0x31d13060, Offset: 0x106
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"aiming_expert", &init );
}

// Namespace skill_aiming_expert
// Params 0, eflags: 0x4
// Checksum 0x75ee015c, Offset: 0x125
// Size: 0x3e
function private init()
{
    utility::registersharedfunc( #"aiming_expert", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"aiming_expert", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_aiming_expert
// Params 1, eflags: 0x4
// Checksum 0xf45eaf9e, Offset: 0x16b
// Size: 0xaa, Type: bool
function private on_give_skill( skill_bundle )
{
    accuracy_scale = skill_bundle.var_71d5a8bd856c3ee6;
    
    if ( accuracy_scale )
    {
        self setaimspreadmovementscale( accuracy_scale );
    }
    
    var_24c370e467870b8a = skill_bundle.var_a5ccee6ad39a137f;
    
    if ( var_24c370e467870b8a )
    {
        perk::giveperk( "specialty_skill_weapon_control" );
        self setclientomnvar( "skill_weapon_control_perk_tier", skill_bundle.skilllevel );
    }
    
    move_to_fire_speed = skill_bundle.var_65a2c9ebc4183fc5;
    
    if ( move_to_fire_speed )
    {
        perk::giveperk( "specialty_skill_move_to_fire_speed" );
        self setclientomnvar( "skill_move_to_fire_speed_perk_tier", skill_bundle.skilllevel );
    }
    
    return true;
}

// Namespace skill_aiming_expert
// Params 1, eflags: 0x4
// Checksum 0x3ec59d9c, Offset: 0x21e
// Size: 0x6d
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self setaimspreadmovementscale( 1 );
    
    if ( isdefined( self.perks[ "specialty_skill_weapon_control" ] ) )
    {
        perk::removeperk( "specialty_skill_weapon_control" );
    }
    
    self setclientomnvar( "skill_weapon_control_perk_tier", 0 );
    
    if ( isdefined( self.perks[ "specialty_skill_move_to_fire_speed" ] ) )
    {
        perk::removeperk( "specialty_skill_move_to_fire_speed" );
    }
    
    self setclientomnvar( "skill_move_to_fire_speed_perk_tier", 0 );
}

