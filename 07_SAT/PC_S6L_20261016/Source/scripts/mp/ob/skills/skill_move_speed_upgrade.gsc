// scripts\mp\ob\skills\skill_move_speed_upgrade.gsc  (hash_2a52709702eabc67.gscc) (size: 1484 Bytes / 0x5cc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x323290f (52635919)
// size ...... 1484 (0x5cc)
// includes .. 4   (offset: 0x588)
// strings ... 1   (offset: 0x5a8)
// dev strs .. 0   (offset: 0x5cc)
// exports ... 6   (offset: 0x2f8)
// cseg ...... 0x6f + 0x289 (0x2f8)
// imports ... 14  (offset: 0x3e8)
// animtree1 . 0   (offset: 0x5cc)
// animtree2 . 0   (offset: 0x5cc)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace skill_move_speed_upgrade;

// Namespace skill_move_speed_upgrade
// Params 0, eflags: 0x1
// Checksum 0x274bff37, Offset: 0x8d
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"move_speed_upgrade", &init );
}

// Namespace skill_move_speed_upgrade
// Params 0
// Checksum 0xcc553f9a, Offset: 0xac
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"move_speed_upgrade", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"move_speed_upgrade", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_move_speed_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe8f77030, Offset: 0xf2
// Size: 0x7a, Type: bool
function private on_give_skill( skill_bundle )
{
    if ( skill_bundle )
    {
        self.var_bd5baee8b8ebbbf3 = { #bundle:skill_bundle };
        
        if ( !common::function_8ff835bf23198a0( "hasMoveSpeedUpgrade" ) )
        {
            common::function_983eeeeb432f3d8( "hasMoveSpeedUpgrade", skill_bundle.var_6e52e79e24fa0b98, skill_bundle.var_93a88696825346fa, skill_bundle.var_6e52e79e24fa0b98, skill_bundle.var_2d1fd44c5a89d950 );
        }
        
        thread function_4468adc9c9c6b9a7( skill_bundle );
        return true;
    }
    
    return false;
}

// Namespace skill_move_speed_upgrade
// Params 1, eflags: 0x4
// Checksum 0xe2ffbbd0, Offset: 0x175
// Size: 0x43
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"move_speed_upgrade_end" );
    self.var_bd5baee8b8ebbbf3 = undefined;
    
    if ( common::function_8ff835bf23198a0( "hasMoveSpeedUpgrade" ) )
    {
        common::function_d85a92c557ea5a52( "hasMoveSpeedUpgrade" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace skill_move_speed_upgrade
// Params 1, eflags: 0xc
// Checksum 0xf39742ca, Offset: 0x1c0
// Size: 0x138
function private function_4468adc9c9c6b9a7( bundle )
{
    self notify( #"hash_f4f1484a59baf6a7" );
    self endon( #"hash_f4f1484a59baf6a7" );
    self endon( #"move_speed_upgrade_end" );
    self endon( #"death_or_disconnect" );
    
    while ( self && self.var_bd5baee8b8ebbbf3 )
    {
        var_b7f9f22a12246a25 = self.skillspeedmod;
        
        if ( self crouchbuttonpressed() )
        {
            self.skillspeedmod = bundle.var_93a88696825346fa;
        }
        else if ( self issupersprinting() )
        {
            self.skillspeedmod = bundle.var_2d1fd44c5a89d950;
        }
        else if ( self issprinting() )
        {
            self.skillspeedmod = bundle.var_a26e96c22ff139cc;
        }
        else
        {
            self.skillspeedmod = bundle.var_6e52e79e24fa0b98;
        }
        
        if ( var_b7f9f22a12246a25 == self.skillspeedmod )
        {
            waitframe();
            continue;
        }
        
        if ( common::function_8ff835bf23198a0( "hasMoveSpeedUpgrade" ) )
        {
            if ( self issupersprinting() )
            {
                common::function_a0f5c85d465c5f0a( "hasMoveSpeedUpgrade", bundle.var_2d1fd44c5a89d950 );
            }
            else
            {
                common::function_a0f5c85d465c5f0a( "hasMoveSpeedUpgrade", bundle.var_a26e96c22ff139cc );
            }
        }
        
        weapons::updatemovespeedscale();
        waitframe();
    }
}

