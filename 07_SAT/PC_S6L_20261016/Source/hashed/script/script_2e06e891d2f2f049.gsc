// script_2e06e891d2f2f049  (hash_2e06e891d2f2f049.gscc) (size: 12272 Bytes / 0x2ff0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66651fc6 (1717903302)
// size ...... 12272 (0x2ff0)
// includes .. 19  (offset: 0x2bf0)
// strings ... 53  (offset: 0x2c88)
// dev strs .. 14  (offset: 0x2f38)
// exports ... 31  (offset: 0x1b60)
// cseg ...... 0x4ed + 0x1673 (0x1b60)
// imports ... 102 (offset: 0x2038)
// animtree1 . 0   (offset: 0x2ff0)
// animtree2 . 0   (offset: 0x2ff0)
#using script_16ea1b94f0f381b3;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\interactive_notes;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\points;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace quest_collector;

// Namespace quest_collector
// Params 0, eflags: 0x5
// Checksum 0x479bedc7, Offset: 0x50b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"dd_collector", #"br_map_quest", &pre_main, undefined );
}

// Namespace quest_collector
// Params 0
// Checksum 0x1b561df2, Offset: 0x534
// Size: 0x6c
function pre_main()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"collector" };
    br_map_quest::register( quest );
}

// Namespace quest_collector
// Params 0
// Checksum 0x9eb255b1, Offset: 0x5a8
// Size: 0x5af
function on_init()
{
    self.bottle_locs = [ ( 6757, 8060, 96 ) + ( 0, 0, -60 ), ( 7899, 7685, 83 ) + ( 0, 0, -60 ), ( 8447, 7754, 92 ) + ( 0, 0, -60 ), ( 11309, 5816, 84 ) + ( 0, 0, -60 ), ( 13326, 3879, 98 ) + ( 0, 0, -60 ), ( 13612, 3315, 97 ) + ( 0, 0, -60 ), ( 14391, 1391, 85 ) + ( 0, 0, -60 ), ( 14394, 431, 93 ) + ( 0, 0, -60 ), ( 14235, -609, 100 ) + ( 0, 0, -60 ), ( 13645, -4638, 95 ) + ( 0, 0, -60 ), ( 12218, -6000, 104 ) + ( 0, 0, -60 ), ( 10731, -6690, 92 ) + ( 0, 0, -60 ), ( 9997, -6838, 96 ) + ( 0, 0, -60 ), ( 7315, -7083, 100 ) + ( 0, 0, -60 ), ( 6178, -6936, 98 ) + ( 0, 0, -60 ), ( 1080, -5715, 100 ) + ( 0, 0, -60 ), ( 651, -5500, 101 ) + ( 0, 0, -60 ), ( -1158, -4233, 97 ) + ( 0, 0, -60 ), ( -547, -5656, 100 ) + ( 0, 0, -60 ), ( -2362, -5060, 105 ) + ( 0, 0, -60 ), ( -4434, -6265, 97 ) + ( 0, 0, -60 ), ( -8538, -6348, 89 ) + ( 0, 0, -60 ), ( -9664, -5964, 99 ) + ( 0, 0, -60 ), ( -11420, -4680, 98 ) + ( 0, 0, -60 ), ( -12064, -4041, 102 ) + ( 0, 0, -60 ), ( -7955, 4725, 97 ) + ( 0, 0, -60 ), ( -7628, 4881, 99 ) + ( 0, 0, -60 ), ( -6242, 5607, 101 ) + ( 0, 0, -60 ), ( -5677, 5530, 91 ) + ( 0, 0, -60 ), ( -3639, 6745, 97 ) + ( 0, 0, -60 ), ( -688, 8666, 105 ) + ( 0, 0, -60 ), ( 2324, 10261, 101 ) + ( 0, 0, -60 ) ];
    self.relics = [];
    relic_register( "graveyard", "wz_consumable_quest_golden_skull", "brloot_golden_skull", ( -5334, 1594, 1261 ), ( 0, 40, 0 ), 1 );
    relic_register( "keep", "wz_consumable_quest_duck_statue", "brloot_duck_statue", ( 3311, 7601, 936 ), ( 277, 210, 89 ), 0.5 );
    relic_register( "lighthouse", "wz_consumable_quest_painting", "brloot_painting", ( 6548, -5364, 1151 ), ( 3, 246, 0 ), 1 );
    relic_register( "terraces", "wz_consumable_quest_golden_goblet", "brloot_golden_goblet", ( -1879, 3556, 1428 ), ( 0, 0, 0 ), 1 );
    relic_register( "town", "wz_consumable_quest_silver_flask", "brloot_silver_flask", ( -4880, -1321, 1206 ), ( 0, -45, 0 ), 1 );
    relic_register( "winery", "wz_consumable_quest_1981_fortuna", "brloot_1981_fortuna", ( 8649, -157, 573 ), ( 0, 45, 0 ), 1 );
    self.var_2153e39e051f5b91 = utility::array_random( self.relics );
    scriptable::scriptable_addusedcallbackbypart( "interactive_note_bottle", &function_84f9981fa895df12 );
    level.var_432d26a37a8bee66 = &function_432d26a37a8bee66;
    
    if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
    {
        utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
    }
    
    thread deposit_init();
    init_vo();
    
    /#
        level thread debug_init();
    #/
}

// Namespace quest_collector
// Params 0
// Checksum 0x8232a77b, Offset: 0xb5f
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_collector
// Params 0
// Checksum 0x5344defa, Offset: 0xb69
// Size: 0x2
function on_start()
{
    
}

// Namespace quest_collector
// Params 0
// Checksum 0xbf0f02cb, Offset: 0xb73
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_collector
// Params 0
// Checksum 0x737ef391, Offset: 0xb7d
// Size: 0x2b9
function on_infil()
{
    var_16a92e2804024f72 = self.var_2153e39e051f5b91;
    
    foreach ( loc in self.bottle_locs )
    {
        data = interactive_notes::create_note_data( "sm_island_collector_bottle" + "_" + var_16a92e2804024f72.id, "interactive_note_bottle" );
        note = interactive_notes::spawn_note( data, loc, ( randomint( 30 ), randomint( 360 ), 0 ) );
        note.data = data;
    }
    
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( var_16a92e2804024f72.origin, var_16a92e2804024f72.angles );
    spawnoptions.critical = 1;
    self.var_2153e39e051f5b91 = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( var_16a92e2804024f72.scriptable, 1, spawnoptions );
    self.var_2153e39e051f5b91.criticalitem = 1;
    self.relic_consumable = var_16a92e2804024f72.consumable;
    self.relic_scriptable = var_16a92e2804024f72.scriptable;
    self.deposit_cache setscriptablepartstate( "body", "fully_open_unusable" );
    level thread carryoverrewards();
    
    /#
        if ( getdvarint( @"hash_a4ca39516537c0e6" ) )
        {
            debug::sphere( self.var_2153e39e051f5b91, 100, "<dev string:x24>" );
        }
        
        if ( getdvarint( @"hash_dde0bff3d0255d0e" ) )
        {
            foreach ( s in self.relics )
            {
                if ( s != var_16a92e2804024f72 )
                {
                    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( s.origin, s.angles );
                    spawnoptions.critical = 1;
                    relic_pickup = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( s.scriptable, 1, spawnoptions );
                    relic_pickup.criticalitem = 1;
                    
                    if ( getdvarint( @"hash_a4ca39516537c0e6" ) )
                    {
                        debug::sphere( relic_pickup, 100, "<dev string:x2a>" );
                    }
                }
            }
        }
    #/
}

// Namespace quest_collector
// Params 0, eflags: 0x4
// Checksum 0x202623f6, Offset: 0xe3e
// Size: 0x28
function private init_vo()
{
    game[ "dialog" ][ "collector_item_deposited" ] = "bmco_bmde_coid";
    game[ "dialog" ][ "collector_rewards_airdrop" ] = "bmco_bmde_cora";
}

// Namespace quest_collector
// Params 6
// Checksum 0x63b2529a, Offset: 0xe6e
// Size: 0xb4
function relic_register( id, consumable, scriptable, origin, angles, scale )
{
    s = spawnstruct();
    s.id = id;
    s.consumable = consumable;
    s.scriptable = scriptable;
    s.origin = origin;
    s.angles = angles;
    s.var_22401553f0e5c682 = scale;
    self.relics[ self.relics.size ] = s;
}

// Namespace quest_collector
// Params 6
// Checksum 0x40e2bc3, Offset: 0xf2a
// Size: 0x58
function function_84f9981fa895df12( instance, part, state, player, bautouse, usestring )
{
    player interactive_notes::open_note( instance.data, instance.origin );
}

// Namespace quest_collector
// Params 0
// Checksum 0xaf698179, Offset: 0xf8a
// Size: 0xef
function carryoverrewards()
{
    level endon( #"game_ended" );
    wait level.br_level.br_circledelaytimes[ 0 ] / 2;
    
    foreach ( player in level.players )
    {
        if ( player.var_c2bf3273e3a9c25d )
        {
            continue;
        }
        
        if ( player getplayerdata( level.var_6f9b00680ed002d8, "carryoverReward" ) )
        {
            player thread carryoverReward();
            
            if ( player.var_745c505b4aa2ed11 )
            {
                continue;
            }
            
            player setplayerdata( level.var_6f9b00680ed002d8, "carryoverReward", 0 );
        }
    }
}

// Namespace quest_collector
// Params 0
// Checksum 0x541ecea2, Offset: 0x1081
// Size: 0x1de
function carryoverReward()
{
    offset = anglestoforward( ( 0, randomint( 360 ), 0 ) ) * 200;
    drop_point = isnavmeshloaded() ? getclosestpointonnavmesh( self.origin + offset ) : self.origin + offset;
    crate = airdrop::dropcrate( undefined, self.team, "legendary_supply_drop", drop_point + ( 0, 0, 4096 ), ( 0, randomfloat( 360 ), 0 ), drop_point );
    crate.source = "carryover_reward";
    crate.skipminimapicon = 1;
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id > -1 )
    {
        crate setscriptablepartstate( "objective_map", "hidden" );
        fadestart = getdvarint( @"hash_acf74e135c5f10bf", 4921 );
        fadeend = getdvarint( @"hash_fd37bfe2a04152a", 5906 );
        objidpoolmanager::objective_add_objective( id, "current", crate.origin, "saw_hud_icon_airdrop_dragon_quest" );
        objective_addteamtomask( id, self.team );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_onentity( id, crate );
        objective_setzoffset( id, 75 );
        objective_setdescription( id, &"hash_45e94a3a5f12236c" );
        function_ac9886e0e2860e18( id, fadestart, fadeend );
        function_44a344c68a68f28d( id, 1 );
        crate.scriptedobjid = id;
        level thread br_public::brleaderdialogplayer( "collector_rewards_airdrop", self, 1, undefined, 1, undefined, "dx_br_brsa_" );
        thread hud_message::showsplash( "quest_collector_reward", undefined, undefined, undefined, undefined, "splash_list_mp_saw_sm_island" );
        level.brgametype thread function_f23c318032b16fdc( crate );
        
        if ( !level.br_circle_disabled )
        {
            crate thread function_9bd199ff535e1afd( drop_point );
        }
    }
}

// Namespace quest_collector
// Params 1
// Checksum 0x8966eff5, Offset: 0x1267
// Size: 0x2f
function function_f23c318032b16fdc( crate )
{
    level endon( #"game_ended" );
    
    while ( isdefined( crate ) )
    {
        waitframe();
    }
    
    crate notify( #"hash_44e484a3e6511c1a" );
}

// Namespace quest_collector
// Params 1
// Checksum 0x518c22dd, Offset: 0x129e
// Size: 0x7e
function function_9bd199ff535e1afd( origin )
{
    level endon( #"game_ended" );
    self endon( #"hash_44e484a3e6511c1a" );
    crate_hit_time = br_circle_util::gettimetilldangerforpoint( origin );
    
    if ( level utility::waittill_notify_or_timeout_return( "br_circle_relocation", crate_hit_time ) == "timeout" )
    {
        if ( isdefined( self.scriptedobjid ) )
        {
            objidpoolmanager::update_objective_state( self.scriptedobjid, "active" );
        }
        
        return;
    }
    
    thread function_9bd199ff535e1afd( origin );
    return;
}

// Namespace quest_collector
// Params 1
// Checksum 0x4c086f9b, Offset: 0x1324
// Size: 0xd6
function function_432d26a37a8bee66( player )
{
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_carryoverReward" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        spawnlist = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        spawnoptions.dropradiusscale = 0.75;
        common_item::function_38cde6a6acb68ea6( spawnlist, spawncount, spawnoptions );
    }
    
    player dlog_recordplayerevent( "dlog_event_br_sm_island_collector_reward_opened", [ "time_from_match_start_ms", gettime() ] );
    player thread points::doscoreevent( #"br_cacheopen_epic" );
    player playsoundtoplayer( "uin_wz2_loot_container_open_epic", player );
}

// Namespace quest_collector
// Params 0
// Checksum 0xcbb8db1c, Offset: 0x1402
// Size: 0x2cb
function deposit_init()
{
    utility::flag_wait( "scriptables_ready" );
    
    while ( !isdefined( level.research_vessel ) )
    {
        waitframe();
    }
    
    var_de871460bc51277b = level.research_vessel.origin;
    var_de871460bc51277b += anglestoforward( level.research_vessel.angles ) * ( -552, 20, 412 )[ 0 ];
    var_de871460bc51277b += anglestoright( level.research_vessel.angles ) * ( -552, 20, 412 )[ 1 ];
    var_de871460bc51277b += ( 0, 0, ( -552, 20, 412 )[ 2 ] );
    self.deposit_cache = spawnscriptable( "br_loot_cache_collector", var_de871460bc51277b, ( 0, 180, 0 ) );
    self.deposit_cache scriptablesetparententity( level.research_vessel, self.deposit_cache.origin - level.research_vessel.origin, self.deposit_cache.angles );
    var_cbf2696af3924e4b = self.deposit_cache.origin;
    var_cbf2696af3924e4b += anglestoforward( self.deposit_cache.angles ) * ( 0, -10, 30 )[ 0 ];
    var_cbf2696af3924e4b += anglestoright( self.deposit_cache.angles ) * ( 0, -10, 30 )[ 1 ];
    var_cbf2696af3924e4b += ( 0, 0, ( 0, -10, 30 )[ 2 ] );
    self.deposit_interact = interaction::register_interact( var_cbf2696af3924e4b, 60, &deposit_used );
    self.deposit_interact linkto( level.research_vessel, "tag_origin", var_cbf2696af3924e4b - level.research_vessel.origin, ( 0, 0, 0 ) );
    self.deposit_interact interaction::set_interact_hint_callback( &function_ad08602facbb4a88 );
    item_prop_origin = self.deposit_cache.origin;
    self.item_prop = spawnscriptable( "quest_saw_collector_item_prop", item_prop_origin, ( 0, -90, 0 ), undefined, function_67b78af3c33ac9a8( self.var_2153e39e051f5b91.var_22401553f0e5c682 ) );
    self.item_prop scriptablesetparententity( level.research_vessel, self.deposit_cache.origin - level.research_vessel.origin + ( 0, 0, 5 ), ( 0, -90, 0 ) );
}

// Namespace quest_collector
// Params 2
// Checksum 0x41e4b9b9, Offset: 0x16d5
// Size: 0x85
function function_ad08602facbb4a88( interact, player )
{
    quest = br_map_quest::get_quest( "collector" );
    
    if ( player br_quest_inventory::has_quest_item( quest.relic_consumable ) )
    {
        return { #string:&"hash_4a76b81a7503aabf", #type:"HINT_NOICON" };
    }
    
    return { #string:&"", #type:"HINT_NOICON" };
}

// Namespace quest_collector
// Params 1
// Checksum 0x55b636ab, Offset: 0x1763
// Size: 0xc1
function deposit_used( player )
{
    if ( self.var_60a18211288345a4 )
    {
        return;
    }
    
    quest = br_map_quest::get_quest( "collector" );
    
    if ( player br_quest_inventory::consume_quest_item( quest.relic_consumable ) )
    {
        player thread function_5aefdcc775d2f6e( quest );
        
        if ( player getplayerdata( level.var_6f9b00680ed002d8, "carryoverReward" ) )
        {
            player.var_745c505b4aa2ed11 = 1;
        }
        else
        {
            player setplayerdata( level.var_6f9b00680ed002d8, "carryoverReward", 1 );
            player.var_c2bf3273e3a9c25d = 1;
        }
        
        quest thread quest_complete( player );
        level thread br_public::brleaderdialogplayer( "collector_item_deposited", player, 1, undefined, 1, undefined, "dx_br_brsa_" );
    }
}

// Namespace quest_collector
// Params 1
// Checksum 0x20c04fdb, Offset: 0x182c
// Size: 0x3d
function quest_complete( player )
{
    params = { #completed_by:[ player ], #is_successful:1 };
    br_map_quest::on_completed( params );
}

// Namespace quest_collector
// Params 1
// Checksum 0x4fa9c180, Offset: 0x1871
// Size: 0x63
function function_5aefdcc775d2f6e( quest )
{
    level endon( #"game_ended" );
    self playgestureviewmodel( "iw8_ges_plyr_cash_handoff" );
    wait 1;
    quest.item_prop setscriptablepartstate( "body", quest.relic_scriptable );
    wait 1;
    quest.deposit_cache setscriptablepartstate( "body", "closing_inactive" );
}

/#

    // Namespace quest_collector
    // Params 0
    // Checksum 0xdc15f3f9, Offset: 0x18dc
    // Size: 0x5, Type: dev
    function function_eea18adbdbb5777c()
    {
        
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0xd811c1f8, Offset: 0x18e9
    // Size: 0x1a, Type: dev
    function debug_init()
    {
        level waittill( #"player_spawned" );
        level thread function_6c025e2cb9e2dd26();
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0xabef8e14, Offset: 0x190b
    // Size: 0x5a, Type: dev
    function function_6c025e2cb9e2dd26()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2e>" );
        devgui::add_devgui_func( "<dev string:x47>", "<dev string:x5b>", &function_33b5e877d20f46e8 );
        devgui::add_devgui_func( "<dev string:x79>", "<dev string:x8b>", &function_f7ef9a2abced2a4a );
        devgui::add_devgui_func( "<dev string:xa7>", "<dev string:xbe>", &debug_spawn_carryover_reward );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0x2d74d6b3, Offset: 0x196d
    // Size: 0x5a, Type: dev
    function function_33b5e877d20f46e8()
    {
        if ( !getdvarint( @"hash_694678c51345479c" ) )
        {
            iprintlnbold( "<dev string:xdf>" );
            setdvar( @"hash_694678c51345479c", 1 );
            function_cac3425536430bc0();
            return;
        }
        
        iprintlnbold( "<dev string:xfc>" );
        setdvar( @"hash_694678c51345479c", 0 );
        function_2e99b76655994f5a();
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0xd38e6a42, Offset: 0x19cf
    // Size: 0x9d, Type: dev
    function function_cac3425536430bc0()
    {
        quest = br_map_quest::get_quest( "<dev string:x11a>" );
        
        foreach ( loc in quest.bottle_locs )
        {
            debug::sphere( loc, undefined, undefined, undefined, "<dev string:xfc>" );
        }
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0x345df419, Offset: 0x1a74
    // Size: 0x11, Type: dev
    function function_2e99b76655994f5a()
    {
        level notify( #"hash_4aa3bbab17dbc623" );
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0x6f125261, Offset: 0x1a8d
    // Size: 0x5a, Type: dev
    function function_f7ef9a2abced2a4a()
    {
        if ( !getdvarint( @"hash_a4ca39516537c0e6" ) )
        {
            iprintlnbold( "<dev string:x124>" );
            setdvar( @"hash_a4ca39516537c0e6", 1 );
            function_339a93e0a4deceaa();
            return;
        }
        
        iprintlnbold( "<dev string:x13f>" );
        setdvar( @"hash_a4ca39516537c0e6", 0 );
        function_5b9f130a95daa61c();
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0x30d1697c, Offset: 0x1aef
    // Size: 0x3b, Type: dev
    function function_339a93e0a4deceaa()
    {
        quest = br_map_quest::get_quest( "<dev string:x11a>" );
        debug::sphere( quest.var_2153e39e051f5b91, 100, "<dev string:x24>", undefined, "<dev string:x13f>" );
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0x6d910d68, Offset: 0x1b32
    // Size: 0x11, Type: dev
    function function_5b9f130a95daa61c()
    {
        level notify( #"hash_18d88a8121f25f05" );
    }

    // Namespace quest_collector
    // Params 0
    // Checksum 0xdb21962d, Offset: 0x1b4b
    // Size: 0x15, Type: dev
    function debug_spawn_carryover_reward()
    {
        level.player thread carryoverReward();
    }

#/
