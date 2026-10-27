// scripts\mp\ob\skills\skill_armor_regen.gsc  (hash_13d192f804dd9164.gscc) (size: 1388 Bytes / 0x56c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e9c54ff (1050432767)
// size ...... 1388 (0x56c)
// includes .. 4   (offset: 0x528)
// strings ... 2   (offset: 0x548)
// dev strs .. 1   (offset: 0x560)
// exports ... 7   (offset: 0x2b8)
// cseg ...... 0x72 + 0x246 (0x2b8)
// imports ... 12  (offset: 0x3d0)
// animtree1 . 0   (offset: 0x56c)
// animtree2 . 0   (offset: 0x56c)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\utility\player;

#namespace skill_armor_regen;

// Namespace skill_armor_regen
// Params 0, eflags: 0x1
// Checksum 0x290b71d5, Offset: 0x90
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"armor_regen", &init );
}

// Namespace skill_armor_regen
// Params 0
// Checksum 0xaed61d31, Offset: 0xaf
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"armor_regen", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"armor_regen", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_armor_regen
// Params 1, eflags: 0x4
// Checksum 0x56668501, Offset: 0xf5
// Size: 0x74, Type: bool
function private on_give_skill( skill_bundle )
{
    if ( !skill_bundle.var_62973389be558bde || !skill_bundle.var_6b40174437922dc || !skill_bundle.var_7a759e7e8914e782 )
    {
        assertmsg( "<dev string:x24>" );
        return false;
    }
    
    thread function_252e4dba5b10a841( skill_bundle.var_62973389be558bde, skill_bundle.var_6b40174437922dc, skill_bundle.var_7a759e7e8914e782 );
    return true;
}

// Namespace skill_armor_regen
// Params 1, eflags: 0x4
// Checksum 0x52e56c40, Offset: 0x172
// Size: 0x18
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"hash_efb1d116ffa01ee4" );
}

// Namespace skill_armor_regen
// Params 3, eflags: 0x4
// Checksum 0x68f390dc, Offset: 0x192
// Size: 0x5a
function private function_252e4dba5b10a841( repair_timeout, repair_factor, out_of_combat_delay )
{
    self endon( #"disconnect" );
    self endon( #"hash_efb1d116ffa01ee4" );
    
    while ( true )
    {
        childthread function_256a9bbbabae1127( repair_timeout, repair_factor, out_of_combat_delay );
        utility::waittill_any( "damage", "damage_armor" );
    }
}

// Namespace skill_armor_regen
// Params 3, eflags: 0x4
// Checksum 0x836e0510, Offset: 0x1f4
// Size: 0xc4
function private function_256a9bbbabae1127( repair_timeout, repair_factor, out_of_combat_delay )
{
    self endon( #"damage" );
    self endon( #"damage_armor" );
    self endon( #"armor_plate_inserted" );
    wait out_of_combat_delay;
    var_196627b4acfeb73f = level.var_1bfbe247e8d32b1b;
    var_f7432caf015a3a2a = var_196627b4acfeb73f * repair_factor;
    curr_armor_health = armor::getarmorhealth();
    var_4e245f24cb5a750e = self.maxarmorhealth;
    
    while ( curr_armor_health < var_4e245f24cb5a750e )
    {
        if ( !player::isinlaststand( self ) )
        {
            if ( curr_armor_health + var_f7432caf015a3a2a >= var_4e245f24cb5a750e )
            {
                var_f7432caf015a3a2a = var_4e245f24cb5a750e - curr_armor_health;
            }
            
            armor::repair_armor( var_f7432caf015a3a2a );
        }
        
        wait repair_timeout;
        curr_armor_health = armor::getarmorhealth();
    }
}

