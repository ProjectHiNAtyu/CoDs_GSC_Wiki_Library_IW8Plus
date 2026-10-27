// scripts\mp\ob\skills\skill_health_upgrade.gsc  (hash_7e30522502352e84.gscc) (size: 1255 Bytes / 0x4e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87efc1dc (2280636892)
// size ...... 1255 (0x4e7)
// includes .. 2   (offset: 0x4bf)
// strings ... 2   (offset: 0x4cf)
// dev strs .. 0   (offset: 0x4e7)
// exports ... 8   (offset: 0x23f)
// cseg ...... 0x75 + 0x1ca (0x23f)
// imports ... 11  (offset: 0x37f)
// animtree1 . 0   (offset: 0x4e7)
// animtree2 . 0   (offset: 0x4e7)
#using script_2fe74ee229c972c3;
#using scripts\common\utility;

#namespace skill_health_upgrade;

// Namespace skill_health_upgrade
// Params 0, eflags: 0x1
// Checksum 0xfa51d0bf, Offset: 0x93
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"health_upgrade", &init );
}

// Namespace skill_health_upgrade
// Params 0
// Checksum 0xebfeb54f, Offset: 0xb2
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"health_upgrade", #"ongiveskill", &function_d5a262fce3580c89 );
    utility::registersharedfunc( #"health_upgrade", #"hash_4aa03f4559ac50a5", &function_c23d77c54e7eaa6 );
}

// Namespace skill_health_upgrade
// Params 1
// Checksum 0xafdacd0a, Offset: 0xf8
// Size: 0x39, Type: bool
function function_d5a262fce3580c89( skill_bundle )
{
    if ( skill_bundle )
    {
        maxhealth = int( skill_bundle.var_5f3bda984e1471bc );
        function_e92c91b235b5b3fd( maxhealth );
        return true;
    }
    
    return false;
}

// Namespace skill_health_upgrade
// Params 1
// Checksum 0x8ca0b45a, Offset: 0x13a
// Size: 0x35, Type: bool
function function_c23d77c54e7eaa6( skill_bundle )
{
    maxhealth = int( getmatchrulesdata( "commonOption", "maxHealth" ) );
    function_e92c91b235b5b3fd( maxhealth );
    return true;
}

// Namespace skill_health_upgrade
// Params 1, eflags: 0x4
// Checksum 0xdf384e8e, Offset: 0x178
// Size: 0x2d
function private function_e92c91b235b5b3fd( maxhealth )
{
    if ( self.isjuggernaut )
    {
        thread function_21340b55df9c9c72( maxhealth );
        return;
    }
    
    update_player_max_health( maxhealth );
}

// Namespace skill_health_upgrade
// Params 1, eflags: 0x4
// Checksum 0x62327b52, Offset: 0x1ad
// Size: 0x38
function private update_player_max_health( maxhealth )
{
    self.maxhealth = maxhealth;
    self.health = maxhealth;
    self.var_b541f8c69a34639d = maxhealth;
    self.laststandrevivehealth = maxhealth;
}

// Namespace skill_health_upgrade
// Params 1, eflags: 0xc
// Checksum 0x25a2f8e9, Offset: 0x1ed
// Size: 0x52
function private function_21340b55df9c9c72( maxhealth )
{
    self notify( #"hash_68dbe1016bd9b805" );
    self endon( #"hash_68dbe1016bd9b805" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"juggernaut_removed" );
    update_player_max_health( maxhealth );
}

