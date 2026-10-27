// script_621025918b385ec2  (hash_621025918b385ec2.gscc) (size: 2191 Bytes / 0x88f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc86f1eb (210170347)
// size ...... 2191 (0x88f)
// includes .. 7   (offset: 0x7eb)
// strings ... 9   (offset: 0x823)
// dev strs .. 0   (offset: 0x88f)
// exports ... 7   (offset: 0x4cf)
// cseg ...... 0x13f + 0x390 (0x4cf)
// imports ... 18  (offset: 0x5e7)
// animtree1 . 0   (offset: 0x88f)
// animtree2 . 0   (offset: 0x88f)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;

#namespace ztron_item_firstperson;

// Namespace ztron_item_firstperson
// Params 0, eflags: 0x5
// Checksum 0x487da8eb, Offset: 0x15d
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ztron_item_firstperson", #"ztron_item", undefined, &init );
}

// Namespace ztron_item_firstperson
// Params 0
// Checksum 0x99603a69, Offset: 0x186
// Size: 0xa1
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"firstperson", #"use", &usefirstperson, "item_firstperson" );
    ztron_item::function_5844a9c240f7dc8d( #"firstperson", #"canautouse", &canautouse );
    ztron_item::function_5844a9c240f7dc8d( #"firstperson", #"hash_2dbdd4400cffa8b8", &canitemspawn );
    ztron_item::function_5844a9c240f7dc8d( #"firstperson", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_1p_intro_OS", "evt_ztron_pickup_firstperson_enter_2d" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_1p_outro_OS", "evt_ztron_pickup_firstperson_exit_2d" );
}

// Namespace ztron_item_firstperson
// Params 1, eflags: 0x4
// Checksum 0xc8028992, Offset: 0x22f
// Size: 0xa8, Type: bool
function private canautouse( params )
{
    incutscene = level.ztron.var_9cb1ea9ce77759 || level.ztron.slayer_intro_active || level utility::flag( "ztron_cutscene" );
    screenfaded = self.ztron.var_3adf48c8e0d5c38 || self.ztron.var_826c4ba9ffdf5dda;
    return !self.ztron.var_a4c2f70bbc713f98 && !incutscene && !screenfaded;
}

// Namespace ztron_item_firstperson
// Params 1, eflags: 0x4
// Checksum 0x2b2151ed, Offset: 0x2e0
// Size: 0xfd, Type: bool
function private canitemspawn( params )
{
    if ( level.ztron.var_74a3707334cfe144 )
    {
        return false;
    }
    
    foreach ( item in level.ztron.itemdef.spawneditems )
    {
        var_866ed6539c9bd606 = ztron_item::function_8a02cd53a42c0649( item );
        
        if ( var_866ed6539c9bd606 === #"firstperson" )
        {
            distsq = distancesquared( params.origin, item.origin );
            
            if ( distsq < squared( 80 ) )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace ztron_item_firstperson
// Params 1
// Checksum 0xfa042b70, Offset: 0x3e6
// Size: 0x32
function function_2c983537c15e53e7( params )
{
    if ( level.ztron.var_74a3707334cfe144 )
    {
        params.disablespawn = 1;
    }
    
    return params;
}

// Namespace ztron_item_firstperson
// Params 1, eflags: 0x4
// Checksum 0xc6d4714c, Offset: 0x421
// Size: 0xae
function private usefirstperson( params )
{
    level endon( #"ztron_game_is_over" );
    player = params.player;
    bundlename = common_item::function_e044c3e813daec3a( params.bundle );
    duration = level.ztron.itemdef.itemdata[ bundlename ].duration ?? 10;
    player thread ztron_camera::function_4cb0fb44c3e8f6ed( duration );
    player utility::function_7c10ea82c1e305b8( "ztron_player_heads_up", "firstperson" );
    player ztron_ui::function_787d89891b886acf( "EXIT_FP_HINT" );
}

