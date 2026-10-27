// scripts\mp\ob\skills\skill_plate_regen.gsc  (hash_142b3afa136bc0a3.gscc) (size: 1610 Bytes / 0x64a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a7140d6 (1248936150)
// size ...... 1610 (0x64a)
// includes .. 6   (offset: 0x602)
// strings ... 2   (offset: 0x632)
// dev strs .. 0   (offset: 0x64a)
// exports ... 8   (offset: 0x32e)
// cseg ...... 0x6b + 0x2c3 (0x32e)
// imports ... 14  (offset: 0x46e)
// animtree1 . 0   (offset: 0x64a)
// animtree2 . 0   (offset: 0x64a)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\utility\player;

#namespace skill_plate_regen;

// Namespace skill_plate_regen
// Params 0, eflags: 0x1
// Checksum 0xb06a2200, Offset: 0x89
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"plate_regen", &init );
}

// Namespace skill_plate_regen
// Params 0
// Checksum 0x7c68ad4a, Offset: 0xa8
// Size: 0x68
function init()
{
    utility::registersharedfunc( #"plate_regen", #"ongiveskill", &function_eb85c4c7ec93169d );
    utility::registersharedfunc( #"plate_regen", #"hash_4aa03f4559ac50a5", &function_f05ab3ed3e21363a );
    callback::add( #"player_death", &function_7d520b89a9a7fddf );
    callback::add( #"on_ai_killed", &function_7d520b89a9a7fddf );
}

// Namespace skill_plate_regen
// Params 1
// Checksum 0x4ba67ce7, Offset: 0x118
// Size: 0x23, Type: bool
function function_eb85c4c7ec93169d( skill_bundle )
{
    self.var_db4eb2a82321a5ee = { #bundle:skill_bundle };
    return true;
}

// Namespace skill_plate_regen
// Params 1
// Checksum 0x158099d, Offset: 0x144
// Size: 0x16
function function_f05ab3ed3e21363a( skill_bundle )
{
    self.var_db4eb2a82321a5ee = undefined;
}

// Namespace skill_plate_regen
// Params 1
// Checksum 0x6490dcfd, Offset: 0x162
// Size: 0x138
function function_7d520b89a9a7fddf( params )
{
    player = params.attacker ?? params.eattacker;
    
    if ( !player.var_db4eb2a82321a5ee )
    {
        return;
    }
    
    if ( player::isinlaststand( player ) )
    {
        return;
    }
    
    bundle = player.var_db4eb2a82321a5ee.bundle;
    armorrecovery = 0;
    
    if ( isplayer( self ) )
    {
        if ( bundle.var_d5dfe79c9dc7ba1f )
        {
            armorrecovery += bundle.var_d5dfe79c9dc7ba1f;
        }
        
        if ( bundle.var_647020bd38d222a6 && function_313e8e33212d5ed4( bundle ) )
        {
            armorrecovery += bundle.var_647020bd38d222a6;
        }
    }
    else
    {
        if ( bundle.var_9cf36903d273a254 )
        {
            armorrecovery += bundle.var_9cf36903d273a254;
        }
        
        if ( bundle.var_3d8befd9818b5ba9 && function_7fafeec5c97662bb( bundle ) )
        {
            armorrecovery += bundle.var_3d8befd9818b5ba9;
        }
    }
    
    if ( armorrecovery > 0 )
    {
        currentarmor = player armor::getarmorhealth();
        player armor::setarmorhealth( currentarmor + armorrecovery );
    }
}

// Namespace skill_plate_regen
// Params 1, eflags: 0x4
// Checksum 0xd00c48b, Offset: 0x2a2
// Size: 0x21, Type: bool
function private function_313e8e33212d5ed4( bundle )
{
    return self.powertier >= bundle.var_a8b15cb9c88208be;
}

// Namespace skill_plate_regen
// Params 1, eflags: 0x4
// Checksum 0x53532a23, Offset: 0x2cc
// Size: 0x61, Type: bool
function private function_7fafeec5c97662bb( bundle )
{
    agent_tier = ai_utility::get_power_tier();
    
    if ( self.type == "zombie" )
    {
        return ( agent_tier >= bundle.var_192fdea0a09659fa );
    }
    
    if ( self.type == "human" )
    {
        return ( agent_tier >= bundle.var_e96244edf7eb6afc );
    }
    
    return false;
}

