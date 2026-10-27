// script_32a1e7eed6b19549  (hash_32a1e7eed6b19549.gscc) (size: 8476 Bytes / 0x211c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a146f87 (2048159623)
// size ...... 8476 (0x211c)
// includes .. 11  (offset: 0x1e98)
// strings ... 40  (offset: 0x1ef0)
// dev strs .. 0   (offset: 0x211c)
// exports ... 18  (offset: 0x147c)
// cseg ...... 0x428 + 0x1054 (0x147c)
// imports ... 61  (offset: 0x174c)
// animtree1 . 0   (offset: 0x211c)
// animtree2 . 0   (offset: 0x211c)
#using script_16ea1b94f0f381b3;
#using script_35efc59124dbb5db;
#using script_75ca45517b8d4e33;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace namespace_289f383f7afd552c;

// Namespace namespace_289f383f7afd552c
// Params 0
// Checksum 0x5d533688, Offset: 0x446
// Size: 0x10d
function init()
{
    level callback::add( #"player_connect", &on_player_connect );
    past_mannequins = getentitylessscriptablearray( "ww_quest_step_3_spawn_node_mannequin_past", #script_noteworthy );
    future_mannequins = getentitylessscriptablearray( "ww_quest_step_3_spawn_node_mannequin_future", #script_noteworthy );
    
    if ( !isdefined( past_mannequins ) || !isdefined( future_mannequins ) || past_mannequins.size == 0 || future_mannequins.size == 0 )
    {
        return;
    }
    
    level.mantis_ww_quest.var_1e5d963acb8a335e.past_mannequins = setup_mannequins( past_mannequins, 1 );
    level.mantis_ww_quest.var_1e5d963acb8a335e.future_mannequins = setup_mannequins( future_mannequins, 0 );
    level.mantis_ww_quest.var_1e5d963acb8a335e.var_59abac7fc5ba5112 = undefined;
    level.mantis_ww_quest.var_1e5d963acb8a335e.ww_part = undefined;
    utility::flag_set( #"hash_4c9e49f806068ca9" );
}

// Namespace namespace_289f383f7afd552c
// Params 1, eflags: 0x4
// Checksum 0x87b2c333, Offset: 0x55b
// Size: 0x1d
function private on_player_connect( params )
{
    callback::add( "quest_item_used", &function_f9b91f79e464401b );
}

// Namespace namespace_289f383f7afd552c
// Params 2
// Checksum 0x1cb9f342, Offset: 0x580
// Size: 0x40
function execute( skipped, save_restored )
{
    scriptable::scriptable_addusedcallback( &function_5c9900f3adcaeb97 );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    function_9e2cf961b20ecfd0();
    utility::flag_wait( "ww_part_core_picked_up" );
}

// Namespace namespace_289f383f7afd552c
// Params 2
// Checksum 0x9d3bc3c, Offset: 0x5c8
// Size: 0xa8
function cleanup( skipped, save_restored )
{
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    zm_quest::function_b57dfe9625966b0b( #"mantis_ww_quest", 0, #"sat_zm_quest_mantis_wwq_core", 1, 1 );
    
    if ( level.melted_mannequins.size == 12 && isdefined( quest_data.sink ) )
    {
        quest_data.sink delete();
        quest_data.acid_pool setscriptablepartstate( "effects", "none" );
        scriptable::function_ecfda6e42bbe0ddc( &namespace_b57d3f6e99f615fe::function_df74413d53562f6f );
    }
}

// Namespace namespace_289f383f7afd552c
// Params 2, eflags: 0x4
// Checksum 0xe5d6bc5c, Offset: 0x678
// Size: 0x163
function private setup_mannequins( var_1b497e7ce34254ff, can_melt )
{
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        zm_save::function_1f44a48caae2acbf();
        melted_mannequins = utility::callsharedfunc( #"zombie", #"get_melted_mannequins" ) ?? [];
        level.melted_mannequins = melted_mannequins;
    }
    
    if ( !isdefined( level.melted_mannequins ) )
    {
        level.melted_mannequins = [];
    }
    
    foreach ( mannequin in var_1b497e7ce34254ff )
    {
        mannequin.id = int( mannequin.targetname );
        mannequin.can_melt = can_melt;
        mannequin setscriptablepartstate( "model", can_melt ? "pristine" : "burned" );
        
        if ( arraycontains( level.melted_mannequins, mannequin.id ) )
        {
            if ( can_melt )
            {
                mannequin setscriptablepartstate( "effects", "melting" );
                continue;
            }
            
            mannequin setscriptablepartstate( "effects", "melted" );
        }
    }
    
    return var_1b497e7ce34254ff;
}

// Namespace namespace_289f383f7afd552c
// Params 0, eflags: 0x4
// Checksum 0x40283524, Offset: 0x7e4
// Size: 0x11e
function private function_9e2cf961b20ecfd0()
{
    utility::flag_wait( #"hash_4c9e49f806068ca9" );
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    var_1b497e7ce34254ff = quest_data.future_mannequins;
    var_1d889a48d1b26017 = utility::callsharedfunc( #"zombie", #"get_persistent_random_seed" ) ?? randomint( 10 );
    var_1b497e7ce34254ff = utility::function_40662075b6c8798c( var_1b497e7ce34254ff, var_1d889a48d1b26017 );
    
    for ( i = 0; i < var_1b497e7ce34254ff.size ; i++ )
    {
        mannequin_state = var_1b497e7ce34254ff[ i ] getscriptablepartstate( "effects" );
        
        if ( mannequin_state != "melted" && mannequin_state != "melting" )
        {
            var_1b497e7ce34254ff[ i ].var_cdbf86857f90b63b = 1;
            quest_data.var_59abac7fc5ba5112 = var_1b497e7ce34254ff[ i ];
            spawn_hint( var_1b497e7ce34254ff[ i ].origin, var_1b497e7ce34254ff[ i ].angles );
            utility::flag_set( "ww_part_core_setup" );
            return;
        }
    }
    
    function_591a2574e03cc020( var_1b497e7ce34254ff[ 0 ] );
}

// Namespace namespace_289f383f7afd552c
// Params 6, eflags: 0x4
// Checksum 0x41542c90, Offset: 0x90a
// Size: 0x305
function private function_5c9900f3adcaeb97( instance, part, state, player, bautouse, usestring )
{
    if ( !instance.can_melt || !isdefined( player.var_7c67ffa2457cf1ee ) || !arraycontains( [ "sat_zm_mantis_ww_mannequin_01", "sat_zm_mantis_ww_mannequin_02", "sat_zm_mantis_ww_mannequin_03", "sat_zm_mantis_ww_mannequin_04" ], instance.type ) )
    {
        return;
    }
    
    if ( player.var_7c67ffa2457cf1ee > 0 && instance getscriptablepartstate( "effects" ) == "base" )
    {
        player.var_7c67ffa2457cf1ee--;
        zm_quest::function_b57dfe9625966b0b( #"mantis_instruments", 0, #"sat_zm_quest_mantis_wwq_acid", player.var_7c67ffa2457cf1ee + 2, 1, player );
        zm_quest::function_4eefe6de31f5ddab( #"mantis_ww_quest", #"hash_23c57b64f11e763f", player.var_7c67ffa2457cf1ee );
        playsoundatpos( instance.origin, "evt_zm_mantis_wwq_sulfur_pour" );
        instance setscriptablepartstate( "effects", "melting" );
        instance notify( #"ww_quest_step_3_mannequin_melted" );
        level.melted_mannequins = arraycombineunique( level.melted_mannequins, [ instance.id ] );
        
        if ( level.melted_mannequins.size == 1 )
        {
            thread function_60949800ac6c4ab5( instance.origin );
        }
        
        melted_mannequin = undefined;
        
        foreach ( mannequin in level.mantis_ww_quest.var_1e5d963acb8a335e.future_mannequins )
        {
            if ( mannequin.id == instance.id )
            {
                melted_mannequin = mannequin;
                mannequin setscriptablepartstate( "effects", "melted" );
                
                if ( mannequin.var_cdbf86857f90b63b )
                {
                    function_591a2574e03cc020( mannequin );
                    continue;
                }
                
                spawn_item( mannequin );
            }
        }
        
        if ( level.melted_mannequins.size == 12 && isdefined( level.mantis_ww_quest.var_1e5d963acb8a335e.acid_pool ) )
        {
            level.mantis_ww_quest.var_1e5d963acb8a335e.sink delete();
            level.mantis_ww_quest.var_1e5d963acb8a335e.acid_pool setscriptablepartstate( "effects", "none" );
            scriptable::function_ecfda6e42bbe0ddc( &namespace_b57d3f6e99f615fe::function_df74413d53562f6f );
            thread function_f2292d21afc841d1( melted_mannequin );
        }
    }
}

// Namespace namespace_289f383f7afd552c
// Params 1, eflags: 0x4
// Checksum 0xa121a04c, Offset: 0xc17
// Size: 0x5d
function private function_591a2574e03cc020( mannequin )
{
    level.mantis_ww_quest.var_1e5d963acb8a335e.ww_part = zm_quest::spawn_quest_item( mannequin.origin + ( 0, 0, 15 ), mannequin.angles, %"hash_b6f1df2ce25b654" );
}

// Namespace namespace_289f383f7afd552c
// Params 1, eflags: 0x4
// Checksum 0x853a1362, Offset: 0xc7c
// Size: 0xa4
function private spawn_item( mannequin )
{
    item_to_spawn = getscriptbundle( %"itemspawnentry:zm_t10_item_essence_small_200" );
    spawnoptions = common_item::function_bc5ff2958b71a708( mannequin.origin + ( 0, 0, 15 ), mannequin.angles );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    spawned_item = common_item::function_61c2c0251e742ffd( item_to_spawn, 200, spawnoptions );
    spawned_item setscriptablepartstate( spawned_item.type, "visible_no_obst" );
    return spawned_item;
}

// Namespace namespace_289f383f7afd552c
// Params 1, eflags: 0x4
// Checksum 0xa186f92e, Offset: 0xd29
// Size: 0x6f
function private function_f2292d21afc841d1( mannequin )
{
    level waittill( #"timetravel_done" );
    level.mantis_ww_quest.var_1e5d963acb8a335e.special_reward = namespace_9d8e359c3b1041e5::droppowerupsharedfunc( "free_perk", mannequin.origin + ( 0, 0, 30 ), -1 );
    level callback::add( "pre_timetravel_done", &function_fb6323982036c166 );
}

// Namespace namespace_289f383f7afd552c
// Params 1, eflags: 0x4
// Checksum 0xc3e1f4a8, Offset: 0xda0
// Size: 0x63
function private function_fb6323982036c166( params )
{
    if ( isdefined( level.mantis_ww_quest.var_1e5d963acb8a335e.special_reward ) )
    {
        level.mantis_ww_quest.var_1e5d963acb8a335e.special_reward powerups::powerup_delete();
    }
    
    level callback::remove( "pre_timetravel_done", &function_fb6323982036c166 );
}

// Namespace namespace_289f383f7afd552c
// Params 1, eflags: 0x4
// Checksum 0x351b531, Offset: 0xe0b
// Size: 0x84
function private function_f9b91f79e464401b( params )
{
    if ( params.scriptable != level.mantis_ww_quest.var_1e5d963acb8a335e.ww_part )
    {
        return;
    }
    
    zm_quest::show_splash_item_picked_up( #"mantis_ww_quest", #"sat_zm_quest_mantis_wwq_core", 1, self );
    utility::flag_set( "ww_part_core_picked_up" );
    despawn_hint();
    level thread battlechatter_mp::trysaylocalsound( params.player, #"hash_5212ed7ec42f115a" );
}

// Namespace namespace_289f383f7afd552c
// Params 2, eflags: 0x4
// Checksum 0x3f805490, Offset: 0xe97
// Size: 0xa6
function private spawn_hint( location, angles )
{
    if ( !isdefined( level.mantis_ww_quest.var_1e5d963acb8a335e.hint ) )
    {
        var_8bef195d99a98568 = spawnscriptable( "sat_zm_mantis_ww_part_core", location + ( 0, 0, 15 ) );
        var_8bef195d99a98568 setscriptablepartstate( var_8bef195d99a98568.type, "hint" );
        thread namespace_a7211835085600d5::function_d5a2c6e5a0e2040e( var_8bef195d99a98568, "mantis_item_hint_light_hammer", "mantis_item_hint_medium_hammer" );
        level.mantis_ww_quest.var_1e5d963acb8a335e.hint = var_8bef195d99a98568;
    }
}

// Namespace namespace_289f383f7afd552c
// Params 0, eflags: 0x4
// Checksum 0x3a4d8635, Offset: 0xf45
// Size: 0x62
function private despawn_hint()
{
    if ( isdefined( level.mantis_ww_quest.var_1e5d963acb8a335e.hint ) )
    {
        level.mantis_ww_quest.var_1e5d963acb8a335e.hint freescriptable();
        level.mantis_ww_quest.var_1e5d963acb8a335e.hint = undefined;
    }
}

// Namespace namespace_289f383f7afd552c
// Params 1, eflags: 0x4
// Checksum 0x62c7bb3c, Offset: 0xfaf
// Size: 0x9c
function private function_60949800ac6c4ab5( location )
{
    utility::flag_waitopen_all_array( [ "mantis_vo_twins_banter_active", "end_of_round_vo_playing" ] );
    utility::flag_set( "mantis_vo_twins_banter_active" );
    twins_banter = randomint( 2 );
    
    if ( twins_banter == 0 )
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mw3aplaca1ln1" );
        wait 4;
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mw3aplaca1ln2" );
        wait 4.5;
    }
    else
    {
        playsoundatpos( location, "dx_zm_mawn_mntw_detw_mw3aplaca2ln1" );
        wait 6;
        playsoundatpos( location, "dx_zm_mawn_mntw_lvtw_mw3aplaca2ln2" );
        wait 3.5;
    }
    
    utility::flag_clear( "mantis_vo_twins_banter_active" );
}

// Namespace namespace_289f383f7afd552c
// Params 0
// Checksum 0x81d958af, Offset: 0x1053
// Size: 0x330, Type: bool
function function_bcdd8958faa3f63b()
{
    if ( zm_quest::is_quest_step_complete( #"mantis_ww_quest", #"hash_711abfae8818f88a" ) )
    {
        return false;
    }
    
    self endon( #"hash_2c4eefaf7e2b24b6" );
    utility::flag_wait( "ww_part_core_setup" );
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    var_20be87097c28c53b = undefined;
    
    foreach ( mannequin in quest_data.past_mannequins )
    {
        mannequin setscriptablepartstate( "interaction", "interaction_hint" );
        mannequin thread function_54f4b81f6f149bb1();
        
        if ( mannequin.id == quest_data.var_59abac7fc5ba5112.id )
        {
            var_20be87097c28c53b = mannequin;
        }
    }
    
    while ( !utility::flag( "ww_part_core_picked_up" ) )
    {
        if ( isdefined( quest_data.ww_part ) )
        {
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_7616365d9aa4e370", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.ww_part.origin, "wwq_mark_hammer", 30, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_7616365d9aa4e370" } );
            utility::flag_wait( "ww_part_core_picked_up" );
        }
        else if ( namespace_b57d3f6e99f615fe::function_2bad0ababb88dbd9() )
        {
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_7616375d9aa4e523", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", var_20be87097c28c53b.origin, "wwq_mark_mannequin", 100, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_7616375d9aa4e523" } );
            utility::waittill_any_ents_return_params( var_20be87097c28c53b, "ww_quest_step_3_mannequin_melted", level, "players_cannot_melt" );
        }
        else
        {
            thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_76163c5d9aa4eda2", 1 );
            namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.sink.origin, "wwq_mark_sink", 30, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_76163c5d9aa4eda2" } );
            utility::waittill_any_ents_return_params( level, "player_refilled_acid_vial", level, "players_can_melt" );
        }
        
        namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
        waitframe();
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    return true;
}

// Namespace namespace_289f383f7afd552c
// Params 0, eflags: 0xc
// Checksum 0xfe18617e, Offset: 0x138c
// Size: 0xf0
function private function_54f4b81f6f149bb1()
{
    self notify( #"hash_8e837a5bf7ae5046" );
    self endon( #"hash_8e837a5bf7ae5046" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_305ee3b31cb6baf3 = 0;
        
        foreach ( player in level.players )
        {
            if ( !player namespace_b57d3f6e99f615fe::function_f167bbe7c6c0876a() )
            {
                self disablescriptableplayeruse( player );
                continue;
            }
            
            self enablescriptableplayeruse( player );
            var_305ee3b31cb6baf3++;
        }
        
        if ( var_305ee3b31cb6baf3 == 0 )
        {
            level notify( #"players_cannot_melt" );
        }
        else
        {
            level notify( #"players_can_melt" );
        }
        
        wait 1;
    }
}

