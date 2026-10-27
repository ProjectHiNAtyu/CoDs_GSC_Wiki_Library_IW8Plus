// scripts\common\ai\aitypes\zombie_galileo\zombie_galileo_audio.gsc  (hash_463d4782331167a7.gscc) (size: 1422 Bytes / 0x58e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ef9084c (788072524)
// size ...... 1422 (0x58e)
// includes .. 3   (offset: 0x542)
// strings ... 4   (offset: 0x55a)
// dev strs .. 0   (offset: 0x58e)
// exports ... 6   (offset: 0x2e2)
// cseg ...... 0xf1 + 0x1f1 (0x2e2)
// imports ... 13  (offset: 0x3d2)
// animtree1 . 0   (offset: 0x58e)
// animtree2 . 0   (offset: 0x58e)
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_galileo_audio;

// Namespace zombie_galileo_audio
// Params 0
// Checksum 0xc5a0fee4, Offset: 0x10f
// Size: 0x33
function function_96a6cb0c0b5c98de()
{
    if ( utility::flag( "galileo_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "galileo_audio" );
    level callback::add( #"player_laststand", &on_player_enter_laststand );
}

// Namespace zombie_galileo_audio
// Params 0
// Checksum 0xc8df8629, Offset: 0x14a
// Size: 0x13
function init_zombie_galileo_audio()
{
    self.dialogue_cooldown_time = [];
    thread function_204f4716f9ffa148();
}

// Namespace zombie_galileo_audio
// Params 1
// Checksum 0xaa7185b8, Offset: 0x165
// Size: 0xd1
function play_zombie_dialogue( alias )
{
    cooldown_s = 30;
    play_chance = 50;
    
    switch ( alias )
    {
        case #"hash_e27f5b58f846680d":
            cooldown_s = 60;
            play_chance = 100;
            break;
        case #"hash_f7cd2ef61325c6ba":
            play_chance = 100;
        default:
            break;
    }
    
    /#
        if ( getdvarint( @"hash_7a4309841f91b09e", 0 ) )
        {
            self.dialogue_cooldown_time[ alias ] = 0;
            play_chance = 100;
        }
    #/
    
    if ( !utility::percent_chance( play_chance ) )
    {
        return;
    }
    
    if ( gettime() < self.dialogue_cooldown_time[ alias ] )
    {
        return;
    }
    
    thread dialogue::say( alias );
    self.dialogue_cooldown_time[ alias ] = gettime() + utility::function_4b74c15943231980( cooldown_s );
}

// Namespace zombie_galileo_audio
// Params 0, eflags: 0x4
// Checksum 0xb20b6b52, Offset: 0x23e
// Size: 0x48
function private function_204f4716f9ffa148()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"enemy" );
        
        if ( self.in_combat && self.enemy )
        {
            play_zombie_dialogue( "dx_zm_agal_aiga_gali_agst" );
        }
    }
}

// Namespace zombie_galileo_audio
// Params 1, eflags: 0x4
// Checksum 0xea8cad2, Offset: 0x28e
// Size: 0x54
function private on_player_enter_laststand( params )
{
    if ( isagent( params.attacker ) && params.attacker.subclass == "zombie_galileo" )
    {
        params.attacker play_zombie_dialogue( "dx_zm_agal_aiga_gali_agpd" );
    }
}

