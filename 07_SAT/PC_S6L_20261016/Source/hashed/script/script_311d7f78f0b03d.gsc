// script_311d7f78f0b03d  (hash_00311d7f78f0b03d.gscc) (size: 10699 Bytes / 0x29cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6e771c63 (1853299811)
// size ...... 10699 (0x29cb)
// includes .. 8   (offset: 0x257b)
// strings ... 46  (offset: 0x25bb)
// dev strs .. 20  (offset: 0x28cf)
// exports ... 32  (offset: 0x171f)
// cseg ...... 0x34e + 0x13d1 (0x171f)
// imports ... 74  (offset: 0x1c1f)
// animtree1 . 0   (offset: 0x29cb)
// animtree2 . 0   (offset: 0x29cb)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item;

#namespace namespace_2613fdec38a7121d;

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x5
// Checksum 0x7e1d9aae, Offset: 0x36c
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_slots", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0xc45685df, Offset: 0x395
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_slots" };
    br_map_quest::register( quest );
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0x2b9d3037, Offset: 0x417
// Size: 0x28
function on_init()
{
    function_970d564ac5226b2e();
    setup_variables();
    function_1a00a5a2ba836d4d();
    setup_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0xfa3229ea, Offset: 0x447
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0x8f499ef2, Offset: 0x451
// Size: 0x13
function on_start()
{
    self.spawned_slots = [];
    thread slots_on_start();
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0x877487d4, Offset: 0x46c
// Size: 0x15
function on_prematch_end()
{
    if ( self.slots_enabled )
    {
        thread slots_on_prematch_end();
    }
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0x81a52dfa, Offset: 0x489
// Size: 0x2
function on_infil()
{
    
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0x3bafb277, Offset: 0x493
// Size: 0x51
function on_disabled()
{
    level.slot_machine_animated = getentitylessscriptablearray( "scriptable_sat_appliance_video_slots_machine_animated", "classname" )[ 0 ];
    function_99df18ff1d290ae5( randomint( 5 ), "left" );
    function_99df18ff1d290ae5( randomint( 5 ), "middle" );
    function_99df18ff1d290ae5( randomint( 5 ), "right" );
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0x2e6ecf36, Offset: 0x4ec
// Size: 0x1e
function private function_970d564ac5226b2e()
{
    br_map_quest::add_setting( "slots_enabled", 1 );
    br_map_quest::add_setting( "slots_cost", 50 );
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0xc0056712, Offset: 0x512
// Size: 0x1d4
function private setup_variables()
{
    level.slot_machine_animated = getentitylessscriptablearray( "scriptable_sat_appliance_video_slots_machine_animated", "classname" )[ 0 ];
    level.slot_machine_static = getentitylessscriptablearray( "scriptable_sat_appliance_video_slots_machine_static", "classname" )[ 0 ];
    self.slots_enabled = br_map_quest::get_setting( "slots_enabled" );
    self.slots_cost = br_map_quest::get_setting( "slots_cost" );
    level.slots_tiers = [];
    init_tier( [ 4, 4, 4 ], 99, "win_jackpot", int( 2500 ) );
    init_tier( [ 3, 3, 3 ], 98, "win_big", int( 1500 ) );
    init_tier( [ 2, 2, 2 ], 97, "win_big", int( 1000 ) );
    init_tier( [ 1, 1, 1 ], 96, "win_big", int( 700 ) );
    init_tier( [ 0, 0, 0 ], 95, "win_big", int( 500 ) );
    init_tier( [ 4, 4 ], 90, "win_common", int( 150 ) );
    init_tier( [ 3, 3 ], 80, "win_common", int( 100 ) );
    init_tier( [ 2, 2 ], 65, "win_common", int( 75 ) );
    init_tier( [ 1, 1 ], 45, "win_common", int( 50 ) );
    init_tier( [ 0, 0 ], 20, "win_common", int( 25 ) );
}

// Namespace namespace_2613fdec38a7121d
// Params 4, eflags: 0x4
// Checksum 0x9d76c1bc, Offset: 0x6ee
// Size: 0x86
function private init_tier( icons, threshold, state, var_7a5317d449713cec )
{
    s = spawnstruct();
    s.icons = icons;
    s.threshold = threshold;
    s.state = state;
    s.var_7a5317d449713cec = var_7a5317d449713cec;
    level.slots_tiers[ level.slots_tiers.size ] = s;
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0x1210c9b3, Offset: 0x77c
// Size: 0x50
function private function_1a00a5a2ba836d4d()
{
    if ( self.slots_enabled )
    {
        self.var_c0c9654f2dab9fa8 = [];
        self.var_c0c9654f2dab9fa8 = utility::getstructarray( "quest_wz_slots_interact", "targetname" );
        assert( self.var_c0c9654f2dab9fa8.size > 0, "<dev string:x24>" + "<dev string:x50>" );
    }
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0x32f61794, Offset: 0x7d4
// Size: 0x1f
function private setup_callbacks()
{
    if ( self.slots_enabled )
    {
        scriptable::scriptable_addusedcallbackbypart( "quest_wz_slots_interact", &function_a3cef238b29b6128 );
    }
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0x2b915d29, Offset: 0x7fb
// Size: 0xe8
function private slots_on_start()
{
    foreach ( struct in self.var_c0c9654f2dab9fa8 )
    {
        spawned = spawnscriptable( "quest_wz_slots_interact", struct.origin, struct.angles );
        self.spawned_slots[ self.spawned_slots.size ] = spawned;
        function_99df18ff1d290ae5( randomint( 5 ), "left" );
        function_99df18ff1d290ae5( randomint( 5 ), "middle" );
        function_99df18ff1d290ae5( randomint( 5 ), "right" );
    }
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0x8503f701, Offset: 0x8eb
// Size: 0x83
function private slots_on_prematch_end()
{
    foreach ( scriptable in self.spawned_slots )
    {
        scriptable setscriptablepartstate( "quest_wz_slots_interact", "usable" );
    }
}

// Namespace namespace_2613fdec38a7121d
// Params 6, eflags: 0x4
// Checksum 0x168915f6, Offset: 0x976
// Size: 0x179
function private function_a3cef238b29b6128( scriptable, part, state, player, bautouse, usestring )
{
    quest = br_map_quest::get_quest( "mtc_slots" );
    cost = quest.slots_cost;
    currency_type = level.gametypebundle.currencytype;
    
    if ( player currency::can_afford( currency_type, cost ) )
    {
        player currency::function_b5fe1e05c892a7f3( currency_type, cost, #"slot_machine" );
        player.endmatchstats[ "cashSpent" ] = ( player.endmatchstats[ "cashSpent" ] ?? 0 ) + cost;
        perskey = "highestPurchaseCost";
        
        if ( !isdefined( player.pers[ perskey ] ) || player.pers[ perskey ] < cost )
        {
            player.pers[ perskey ] = cost;
        }
        
        player br_plunder::function_d7efc5a9b599e020( 4, cost );
        scriptable setscriptablepartstate( "quest_wz_slots_interact", "disabled" );
        scriptable setscriptablepartstate( "sfx", "slot_use" );
        level.slot_machine_animated setscriptablepartstate( "lever", "anim" );
        scriptable thread play( player );
        return;
    }
    
    scriptable setscriptablepartstate( "sfx", "more_money" );
}

// Namespace namespace_2613fdec38a7121d
// Params 1, eflags: 0x4
// Checksum 0x97b139bf, Offset: 0xaf7
// Size: 0x237
function private play( player )
{
    level endon( #"game_ended" );
    roll = randomint( 100 );
    
    /#
        if ( isdefined( level.var_7043d33008c74969 ) )
        {
            roll = level.var_7043d33008c74969;
            level.var_7043d33008c74969 = undefined;
        }
    #/
    
    thread spin_columns();
    
    foreach ( s in level.slots_tiers )
    {
        if ( roll >= s.threshold )
        {
            var_5be33a172f0b3d3c = s;
            break;
        }
    }
    
    if ( isdefined( var_5be33a172f0b3d3c ) )
    {
        handle_icons( var_5be33a172f0b3d3c );
        self setscriptablepartstate( "sfx", var_5be33a172f0b3d3c.state );
        isJackpot = 0;
        
        if ( var_5be33a172f0b3d3c.state == "win_jackpot" )
        {
            isJackpot = 1;
            level thread function_24fb695bddc98fd0();
        }
        
        player dlog_recordplayerevent( "dlog_event_br_manticore_slot_machine_used", [ "time_from_match_start_ms", gettime(), "cost", 500, "earnings", var_5be33a172f0b3d3c.var_7a5317d449713cec * 10, "isJackpot", isJackpot ] );
        win( var_5be33a172f0b3d3c );
    }
    else
    {
        player dlog_recordplayerevent( "dlog_event_br_manticore_slot_machine_used", [ "time_from_match_start_ms", gettime(), "cost", 500, "earnings", 0, "isJackpot", 0 ] );
        function_94f476bfef267047();
        self setscriptablepartstate( "sfx", "slot_lose" );
    }
    
    wait 0.5;
    self setscriptablepartstate( "quest_wz_slots_interact", "usable" );
    self setscriptablepartstate( "sfx", "off" );
    level.slot_machine_animated setscriptablepartstate( "lever", "idle" );
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0xcafb7902, Offset: 0xd36
// Size: 0x35
function private spin_columns()
{
    thread spin_column( "left", "slot_spin_end_left" );
    thread spin_column( "middle", "slot_spin_end_middle" );
    thread spin_column( "right", "slot_spin_end_right" );
}

// Namespace namespace_2613fdec38a7121d
// Params 2, eflags: 0x4
// Checksum 0xf4638e99, Offset: 0xd73
// Size: 0x95
function private spin_column( str_id, str_endon )
{
    level endon( #"game_ended" );
    self endon( str_endon );
    result = randomint( 5 );
    
    while ( true )
    {
        a = [];
        
        for ( i = 0; i < 5 ; i++ )
        {
            a[ a.size ] = i;
        }
        
        a = arrayremove( a, result );
        result = utility::array_random( a );
        function_99df18ff1d290ae5( result, str_id );
        wait level.framedurationseconds * 2;
    }
}

// Namespace namespace_2613fdec38a7121d
// Params 1, eflags: 0x4
// Checksum 0xb15efa83, Offset: 0xe10
// Size: 0x89
function private handle_icons( var_5be33a172f0b3d3c )
{
    if ( isdefined( var_5be33a172f0b3d3c.icons[ 2 ] ) )
    {
        a = var_5be33a172f0b3d3c.icons;
    }
    else
    {
        a = arraycopy( var_5be33a172f0b3d3c.icons );
        var_afe54aa1872d14e3 = randomint( 4 );
        
        if ( var_afe54aa1872d14e3 >= a[ 0 ] )
        {
            var_afe54aa1872d14e3++;
        }
        
        arrayinsert( a, var_afe54aa1872d14e3, randomint( a.size + 1 ) );
    }
    
    spin_end( a[ 0 ], a[ 1 ], a[ 2 ] );
}

// Namespace namespace_2613fdec38a7121d
// Params 0, eflags: 0x4
// Checksum 0x62836189, Offset: 0xea1
// Size: 0x49
function private function_94f476bfef267047()
{
    a = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        a[ a.size ] = i;
    }
    
    a = arrayrandomize( a );
    spin_end( a[ 0 ], a[ 1 ], a[ 2 ] );
}

// Namespace namespace_2613fdec38a7121d
// Params 3, eflags: 0x4
// Checksum 0xe954150a, Offset: 0xef2
// Size: 0xb7
function private spin_end( icon_left, icon_middle, icon_right )
{
    level endon( #"game_ended" );
    wait 2;
    self notify( #"slot_spin_end_left" );
    self setscriptablepartstate( "sfx", "spin_end" );
    function_99df18ff1d290ae5( icon_left, "left" );
    wait 1;
    self notify( #"slot_spin_end_middle" );
    self setscriptablepartstate( "sfx", "spin_end" );
    function_99df18ff1d290ae5( icon_middle, "middle" );
    wait 1;
    self notify( #"slot_spin_end_right" );
    self setscriptablepartstate( "sfx", "spin_end" );
    function_99df18ff1d290ae5( icon_right, "right" );
    wait 0.5;
}

// Namespace namespace_2613fdec38a7121d
// Params 2, eflags: 0x4
// Checksum 0xa9dd71c1, Offset: 0xfb1
// Size: 0x88
function private function_99df18ff1d290ae5( i_result, column_id )
{
    for ( i = 0; i < 5 ; i++ )
    {
        if ( i == i_result )
        {
            level.slot_machine_animated setscriptablepartstate( "j_screen_" + column_id + "_0" + i + 1, "show" );
            continue;
        }
        
        level.slot_machine_animated setscriptablepartstate( "j_screen_" + column_id + "_0" + i + 1, "hide" );
    }
}

// Namespace namespace_2613fdec38a7121d
// Params 1, eflags: 0x4
// Checksum 0xea50807d, Offset: 0x1041
// Size: 0x1a7
function private win( var_5be33a172f0b3d3c )
{
    startorigin = self.origin + anglestoforward( self.angles ) * 5 + anglestoleft( self.angles ) * 14.6 + ( 0, 0, -14 );
    forwardangles = anglestoforward( self.angles );
    spawndistance = 40;
    endorigin = startorigin + forwardangles * spawndistance;
    endorigin = utility::drop_to_ground( endorigin, 0, -250 );
    payout_fx = spawnscriptable( "quest_wz_slots_payout", startorigin );
    spawn_options = common_item::function_f5dfaa3bbdf99a33( endorigin, startorigin, self.angles );
    spawn_options.var_9161cf0784b6951d = 0;
    spawn_options.var_7a5f61b06b9371b5 = 1;
    spawn_options.var_aec43e9d95b191f9 = 3;
    spawn_options.var_12d76a8b35ac875d = 17;
    spawn_options.var_2321e933cbdf46d8 = 2;
    spawn_options.var_34444f0dda11f0d5 = 2;
    spawn_options.var_8934e0ace9b7d996 = -180;
    spawn_options.var_8958d2ace9e03584 = 180;
    spawn_options.var_d72f168a0f299753 = -0.2;
    spawn_options.var_d7522c8a0f500f6d = 0.2;
    spawn_options.var_8f2dd74e9b3d807d = 1;
    spawn_options.var_fc803688fa7c976c = 0;
    spawn_options.var_10a99b46418cef2 = [];
    spawn_options.ignoreents = [ self ];
    payout_loop( var_5be33a172f0b3d3c, spawn_options, payout_fx );
}

// Namespace namespace_2613fdec38a7121d
// Params 3, eflags: 0x4
// Checksum 0x2b9ff5b0, Offset: 0x11f0
// Size: 0x170
function private payout_loop( var_5be33a172f0b3d3c, spawn_options, payout_fx )
{
    level endon( #"game_ended" );
    
    switch ( var_5be33a172f0b3d3c.state )
    {
        case #"hash_eb095718bb95a0d8":
            increment = int( 100 );
            scriptable = "brloot_plunder_cash_uncommon_2";
            break;
        case #"hash_dff8e9ac3ea737d4":
            increment = int( 100 );
            scriptable = "brloot_plunder_cash_uncommon_2";
            break;
        case #"hash_945d0a8dd052f6ab":
            increment = int( 25 );
            scriptable = "brloot_plunder_cash_uncommon_1";
            break;
    }
    
    var_fb04b936ed4dbe26 = int( max( 1, var_5be33a172f0b3d3c.var_7a5317d449713cec / increment ) );
    var_d2dea1eb5c269d79 = var_5be33a172f0b3d3c.state == "win_jackpot" ? 0.33 : 0.5;
    var_d2dea1eb5c269d79 -= level.framedurationseconds;
    
    while ( var_fb04b936ed4dbe26 > 0 )
    {
        common_item::items_spawnitemfromscriptable( scriptable, increment, spawn_options );
        payout_fx setscriptablepartstate( "quest_wz_slots_payout", "sfx" );
        wait level.framedurationseconds;
        payout_fx setscriptablepartstate( "quest_wz_slots_payout", "off" );
        wait var_d2dea1eb5c269d79;
        var_fb04b936ed4dbe26--;
    }
    
    payout_fx freescriptable();
    level.slot_machine_static setscriptablepartstate( "vfx", "off" );
}

// Namespace namespace_2613fdec38a7121d
// Params 0
// Checksum 0x2bdd2066, Offset: 0x1368
// Size: 0x80
function function_24fb695bddc98fd0()
{
    level endon( #"game_ended" );
    level.slot_machine_static setscriptablepartstate( "vfx", "on" );
    
    while ( level.slot_machine_static getscriptablepartstate( "vfx" ) == "on" )
    {
        level.slot_machine_static setscriptablepartstate( "model", "off" );
        wait 0.25;
        level.slot_machine_static setscriptablepartstate( "model", "base" );
        wait 0.25;
    }
}

/#

    // Namespace namespace_2613fdec38a7121d
    // Params 0, eflags: 0x4
    // Checksum 0xd4480d48, Offset: 0x13f0
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_2613fdec38a7121d
    // Params 0, eflags: 0x4
    // Checksum 0xa295561b, Offset: 0x1404
    // Size: 0x28d, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x74>" + level.mapname + "<dev string:x83>" + "<dev string:x85>" + "<dev string:x83>" );
        devgui::add_devgui_func( "<dev string:x8f>", "<dev string:xa7>", &devgui_teleport_player );
        devgui::add_devgui_func( "<dev string:xc0>", "<dev string:xcd>", &function_7db6be8e3fe79133 );
        level.var_89ed5ee789f2ff4f = 0;
        
        foreach ( var_5be33a172f0b3d3c in level.slots_tiers )
        {
            icons = "<dev string:xe1>";
            
            foreach ( i in var_5be33a172f0b3d3c.icons )
            {
                icons += i;
            }
            
            if ( var_5be33a172f0b3d3c.icons.size == 2 )
            {
                icons += "<dev string:xe2>";
            }
            
            state = "<dev string:xe1>";
            increment = undefined;
            
            switch ( var_5be33a172f0b3d3c.state )
            {
                case #"hash_eb095718bb95a0d8":
                    state = "<dev string:xf0>";
                    increment = int( 100 );
                    break;
                case #"hash_dff8e9ac3ea737d4":
                    state = "<dev string:x102>";
                    increment = int( 100 );
                    break;
                default:
                    state = "<dev string:x10c>";
                    increment = int( 25 );
                    break;
            }
            
            count = int( var_5be33a172f0b3d3c.var_7a5317d449713cec / increment );
            str = "<dev string:x119>" + icons + "<dev string:x12c>" + state + "<dev string:x12e>" + string( count ) + "<dev string:x138>" + string( increment * 10 );
            devgui::function_cd4e263c1f3018ae( str, "<dev string:x13c>" + var_5be33a172f0b3d3c.threshold, &function_ed2fe4d2da29598c );
        }
        
        devgui::function_cd4e263c1f3018ae( "<dev string:x151>", "<dev string:x13c>" + 0, &function_ed2fe4d2da29598c );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_2613fdec38a7121d
    // Params 0, eflags: 0x4
    // Checksum 0x594093e8, Offset: 0x1699
    // Size: 0x3f, Type: dev
    function private devgui_teleport_player()
    {
        level.player setorigin( ( -2199, -4923, 66 ), 1 );
        level.player setplayerangles( ( 0, 9, 0 ), 1 );
    }

    // Namespace namespace_2613fdec38a7121d
    // Params 0, eflags: 0x4
    // Checksum 0x6d0e614, Offset: 0x16e0
    // Size: 0x18, Type: dev
    function private function_7db6be8e3fe79133()
    {
        level.player br_plunder::playerplunderpickup( 10000 );
    }

    // Namespace namespace_2613fdec38a7121d
    // Params 1, eflags: 0x4
    // Checksum 0xd4837a72, Offset: 0x1700
    // Size: 0x1f, Type: dev
    function private function_ed2fe4d2da29598c( params )
    {
        level.var_7043d33008c74969 = int( params[ 0 ] );
    }

#/
