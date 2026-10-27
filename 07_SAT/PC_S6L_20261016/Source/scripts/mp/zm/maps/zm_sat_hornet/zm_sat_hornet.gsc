// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet.gsc  (hash_40a4a37968152111.gscc) (size: 5386 Bytes / 0x150a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee4c3c88 (3997973640)
// size ...... 5386 (0x150a)
// includes .. 26  (offset: 0x124a)
// strings ... 34  (offset: 0x131a)
// dev strs .. 5   (offset: 0x14ce)
// exports ... 12  (offset: 0x94e)
// cseg ...... 0x250 + 0x6fe (0x94e)
// imports ... 63  (offset: 0xb2e)
// animtree1 . 0   (offset: 0x150a)
// animtree2 . 0   (offset: 0x150a)
#using script_16ea1b94f0f381b3;
#using script_499f8a0858894eae;
#using script_5a0c375c28690264;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_audio;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_falling_rocks;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_falling_rocks_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_fx;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_lighting;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_mq_quest_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_pap_quest;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_pap_quest_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_rb;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_script_game_over_scenes_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_sq_quest_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ww_quest_cs;
#using scripts\mp\zm\systems\zm_fasttravel;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_hornet;

// Namespace zm_sat_hornet
// Params 0
// Checksum 0x9fa9d917, Offset: 0x26e
// Size: 0x16c
function main()
{
    zm_sat_hornet_art::main();
    zm_sat_hornet_audio::main();
    zm_sat_hornet_fx::main();
    zm_sat_hornet_lighting::main();
    zm_sat_hornet_pap_quest_cs::main();
    zm_sat_hornet_ww_quest_cs::main();
    zm_sat_hornet_mq_quest_cs::main();
    zm_sat_hornet_falling_rocks_cs::main();
    zm_sat_hornet_sq_quest_cs::main();
    zm_sat_hornet_script_game_over_scenes_cs::main();
    level.var_a681fe81093a1924 = &function_c7d76ffe1455b59;
    load::main();
    zm_sat_hornet_rb::init();
    compass::setupminimap( "compass_map_zm_sat_hornet" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level.ttlos_suppressasserts = 1;
    level.vending_machines_powered_on_at_start = 1;
    level val::set( "power_on", "task_logic_activate", 0 );
    level thread init_fasttravel();
    level namespace_923cf551235ca152::main();
    level zm_sat_hornet_falling_rocks::main();
    
    if ( isusingmatchrulesdata() && getmatchrulesdata( "zmData", "papQuest" ) )
    {
        level thread zm_sat_hornet_pap_quest::init();
    }
    
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"katana", &function_c04de7e7132caec0 );
    setdvarifuninitialized( @"hash_ea917e1597aab9a0", 1 );
    level thread function_c6028f04a34db234();
    level thread function_e6607c54c4fa7aec();
    utility::registersharedfunc( #"arsenal", #"hash_713b8231d6897f0c", &function_28bdc2f0cf5c3f87 );
    level thread function_18d7a0868d0f3dc0();
    
    /#
        level function_e076c3d367c3896b();
    #/
}

// Namespace zm_sat_hornet
// Params 1
// Checksum 0x1f77a691, Offset: 0x3e2
// Size: 0xbf
function function_c7d76ffe1455b59( var_f1fbc291f2430b1e )
{
    var_8c4fe62d01999d1e = zone_manager::get_current_zone( 0, 1 );
    
    if ( !isdefined( var_8c4fe62d01999d1e ) )
    {
        var_694f3a89867d3674 = getclosestpointonnavmesh( self.origin );
        var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( var_694f3a89867d3674 );
    }
    
    if ( var_f1fbc291f2430b1e )
    {
        if ( var_8c4fe62d01999d1e.zone_name == "zone_lava_garden_a" )
        {
            self setscriptablepartstate( "beam_higher", "on" );
        }
        else
        {
            self setscriptablepartstate( "beam", "on" );
        }
        
        return;
    }
    
    if ( var_8c4fe62d01999d1e.zone_name == "zone_lava_garden_a" )
    {
        self setscriptablepartstate( "beam_higher", "off" );
        return;
    }
    
    self setscriptablepartstate( "beam", "off" );
}

// Namespace zm_sat_hornet
// Params 0
// Checksum 0x267d5638, Offset: 0x4a9
// Size: 0x17
function init_fasttravel()
{
    level utility::flag_wait( "power_on" );
    level thread zm_fasttravel::post_init();
}

// Namespace zm_sat_hornet
// Params 1
// Checksum 0xfd5e6ec8, Offset: 0x4c8
// Size: 0x1fd
function function_c04de7e7132caec0( params )
{
    var_dfaf1359054cbf1e = [ "green", "blue", "purple", "orange" ];
    str_color = "orange";
    
    foreach ( param in params )
    {
        if ( issubstr( param, "color" ) )
        {
            str_color = removesubstr( param, "color_" );
            
            if ( !arraycontains( var_dfaf1359054cbf1e, str_color ) )
            {
                str_color = utility::array_random( var_dfaf1359054cbf1e );
            }
            
            continue;
        }
        
        if ( issubstr( param, "pap" ) )
        {
            var_951c89546ec50477 = int( removesubstr( param, "pap_" ) );
        }
    }
    
    var_8a61d4195b4b6e64 = getscriptbundle( "itemspawnentry:zm_sat_item_weapon_me_elnath_" + str_color );
    
    foreach ( player in level.players )
    {
        v_pos = vectornormalize( anglestoforward( player.angles ) ) * 100 + player.origin;
        spawnoptions = common_item::function_bc5ff2958b71a708( v_pos, ( 180, 0, 0 ) );
        spawnoptions.overridepaplvl = var_951c89546ec50477;
        katana_weapon = item_weapon::function_b960bc85ea91de14( var_8a61d4195b4b6e64, spawnoptions );
    }
}

// Namespace zm_sat_hornet
// Params 0
// Checksum 0x5c0c3860, Offset: 0x6cd
// Size: 0x4c
function function_c6028f04a34db234()
{
    self notify( #"hash_f66cfc346fda2e03" );
    self endon( #"hash_f66cfc346fda2e03" );
    level magicbox::function_2e49cd8681e36211( 1 );
    utility::flag_wait( "completed_ww_step_6" );
    level magicbox::function_2e49cd8681e36211( 0 );
    level magicbox::function_6c4ffb8218367c4b( %"itemspawnentry:zm_sat_item_weapon_ww_hornet", 4 );
}

// Namespace zm_sat_hornet
// Params 0
// Checksum 0x734cb89, Offset: 0x721
// Size: 0x57
function function_e6607c54c4fa7aec()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.contentmanager.spawnedinstances && level.contentmanager.spawnedinstances.size >= 10 )
        {
            level utility::flag_set( "content_manager_populated" );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet
// Params 1
// Checksum 0x1e4bd0eb, Offset: 0x780
// Size: 0x4a
function function_28bdc2f0cf5c3f87( arsenal )
{
    s_destination_zone = zone_manager::function_90e5c3e2272b0130( arsenal.mdl_arsenal.origin );
    
    if ( s_destination_zone.script_zone_name == "zone_second_bailey_c" )
    {
        return 1;
    }
}

// Namespace zm_sat_hornet
// Params 0, eflags: 0x4
// Checksum 0xbfa876cf, Offset: 0x7d3
// Size: 0x7b
function private function_18d7a0868d0f3dc0()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "zm_init_done" );
    level utility::flag_wait( "begin_round_logic" );
    level.var_4c33e1cd56ccc717 = getent( "rh_col_coffin", #targetname );
    
    if ( !isdefined( level.var_4c33e1cd56ccc717 ) )
    {
        return;
    }
    
    level.var_4c33e1cd56ccc717 connectpaths();
    level.var_4c33e1cd56ccc717 notsolid();
    level utility::flag_set( "rh_col_set" );
}

/#

    // Namespace zm_sat_hornet
    // Params 0, eflags: 0x4
    // Checksum 0x1bf818a, Offset: 0x856
    // Size: 0x48, Type: dev
    function private function_e076c3d367c3896b()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x41>", "<dev string:x62>", &function_9d257137508aadb, 1 );
        devgui::add_devgui_func( "<dev string:x6c>", "<dev string:x8c>", &function_bf409c9f3fd73e00, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet
    // Params 0, eflags: 0x4
    // Checksum 0x896211a0, Offset: 0x8a6
    // Size: 0x50, Type: dev
    function private function_9d257137508aadb()
    {
        current_zone = level.players[ 0 ] zone_manager::get_current_zone();
        
        if ( !isdefined( current_zone ) )
        {
            return;
        }
        
        zm_utility::function_549e7bc8f78816f2( [ zm_utility::function_fbb7d4c98261e273( current_zone.zone_name ) ], level.var_6f89b56853b0e818 );
    }

    // Namespace zm_sat_hornet
    // Params 0, eflags: 0x4
    // Checksum 0x47033148, Offset: 0x8fe
    // Size: 0x50, Type: dev
    function private function_bf409c9f3fd73e00()
    {
        current_zone = level.players[ 0 ] zone_manager::get_current_zone();
        
        if ( !isdefined( current_zone ) )
        {
            return;
        }
        
        zm_utility::function_81ecff068420355d( [ zm_utility::function_fbb7d4c98261e273( current_zone.zone_name ) ], level.var_6f89b56853b0e818 );
    }

#/
