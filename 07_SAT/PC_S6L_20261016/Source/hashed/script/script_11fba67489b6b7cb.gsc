// script_11fba67489b6b7cb  (hash_11fba67489b6b7cb.gscc) (size: 3819 Bytes / 0xeeb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe485ad4d (3833965901)
// size ...... 3819 (0xeeb)
// includes .. 7   (offset: 0xddf)
// strings ... 10  (offset: 0xe17)
// dev strs .. 5   (offset: 0xea7)
// exports ... 15  (offset: 0x6e7)
// cseg ...... 0x103 + 0x5e4 (0x6e7)
// imports ... 41  (offset: 0x93f)
// animtree1 . 0   (offset: 0xeeb)
// animtree2 . 0   (offset: 0xeeb)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\loot\common_item;

#namespace namespace_b8f9cb1f3f6088e9;

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0, eflags: 0x5
// Checksum 0xe9a58743, Offset: 0x121
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_bell", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0
// Checksum 0xb9c958c5, Offset: 0x14a
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_bell" };
    br_map_quest::register( quest );
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0
// Checksum 0x165452f0, Offset: 0x1cc
// Size: 0x5e
function on_init()
{
    /#
        debug_init();
    #/
    
    br_map_quest::add_setting( "rewards_enabled", 1 );
    br_map_quest::add_setting( "reward_count", 5 );
    br_map_quest::add_setting( "interact_limit", 10 );
    self.bell_location = utility::getstruct( "quest_bell_location" );
    self.reward_locations = utility::getstructarray( "quest_bell_reward_location" );
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0
// Checksum 0xfdf5b31e, Offset: 0x232
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0
// Checksum 0x2c83ca9f, Offset: 0x23c
// Size: 0x2
function on_start()
{
    
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0
// Checksum 0xa8a93d03, Offset: 0x246
// Size: 0x9
function on_prematch_end()
{
    spawn_bell();
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0
// Checksum 0x8662b70e, Offset: 0x257
// Size: 0x2
function on_infil()
{
    
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0
// Checksum 0x14d25015, Offset: 0x261
// Size: 0x2
function on_disabled()
{
    
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0, eflags: 0x4
// Checksum 0xadd5a503, Offset: 0x26b
// Size: 0xa2
function private spawn_bell()
{
    scriptable::scriptable_addusedcallbackbypart( "quest_saw_manticore_bell", &function_9078a3c18e64d0c );
    self.var_830f6c6f83634137 = spawnscriptable( "quest_saw_manticore_bell", self.bell_location.origin, self.bell_location.angles );
    self.var_830f6c6f83634137.var_ab52b7f11c323791 = gettime();
    self.var_830f6c6f83634137.quest = self;
    self.interact_limit = br_map_quest::get_setting( "interact_limit" );
    
    if ( self.interact_limit )
    {
        self.interact_count = 0;
    }
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 6, eflags: 0x4
// Checksum 0xb6402101, Offset: 0x315
// Size: 0x21a
function private function_9078a3c18e64d0c( instance, part, state, player, bautouse, usestring )
{
    if ( gettime() - instance.var_ab52b7f11c323791 < 250 )
    {
        return;
    }
    
    instance.var_ab52b7f11c323791 = gettime();
    instance setscriptablepartstate( "sfx", "ding" );
    
    if ( instance.quest.interact_limit )
    {
        instance.quest.interact_count++;
        
        if ( instance.quest.interact_count >= instance.quest.interact_limit )
        {
            if ( instance.quest br_map_quest::get_setting( "rewards_enabled" ) )
            {
                instance.quest thread spawn_rewards();
            }
            
            players = getplayersinradius( instance.origin, 300, 300 );
            
            foreach ( flash_player in players )
            {
                flash_player shellshock_utility_cpmp::_shellshock( %"flash_grenade_mp", #"flash", 4, 1 );
                flash_player.var_c587348832866568 = int( gettime() + utility::function_4b74c15943231980( 5 ) );
            }
            
            instance.quest br_map_quest::on_completed( { #completed_by:[ player ], #is_successful:1 } );
            scriptable::function_369a834929711390( "quest_saw_manticore_bell", &function_9078a3c18e64d0c );
            instance setscriptablepartstate( "quest_saw_manticore_bell", "hidden" );
            instance utility::delaycall( 5, &freescriptable );
        }
    }
}

// Namespace namespace_b8f9cb1f3f6088e9
// Params 0, eflags: 0x4
// Checksum 0x58dc7724, Offset: 0x537
// Size: 0x10e
function private spawn_rewards()
{
    level endon( #"game_ended" );
    wait 1;
    reward_count = br_map_quest::get_setting( "reward_count" );
    items = common_item::items_selectfromlist( %"hash_72932063b8e90279", reward_count );
    reward_locations = self.reward_locations;
    
    foreach ( index, item in items )
    {
        if ( index >= reward_locations.size )
        {
            break;
        }
        
        spawn_options = common_item::function_f5dfaa3bbdf99a33( reward_locations[ index ].origin + ( 0, 0, 10 ), reward_locations[ index ].origin );
        common_item::function_61c2c0251e742ffd( item, undefined, spawn_options );
    }
}

/#

    // Namespace namespace_b8f9cb1f3f6088e9
    // Params 0, eflags: 0x4
    // Checksum 0xd67f37ed, Offset: 0x64d
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_b8f9cb1f3f6088e9
    // Params 0, eflags: 0x4
    // Checksum 0x834ad849, Offset: 0x661
    // Size: 0x4a, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" + level.mapname + "<dev string:x33>" + "<dev string:x35>" + "<dev string:x33>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x49>", &debug_spawn_bell );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_b8f9cb1f3f6088e9
    // Params 0, eflags: 0x4
    // Checksum 0x3ae5ee03, Offset: 0x6b3
    // Size: 0x34, Type: dev
    function private debug_spawn_bell()
    {
        quest = br_map_quest::get_quest( "<dev string:x35>" );
        
        if ( !quest.var_830f6c6f83634137 )
        {
            quest spawn_bell();
        }
    }

#/
