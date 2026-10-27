// script_596494e95090cfba  (hash_596494e95090cfba.gscc) (size: 8063 Bytes / 0x1f7f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd261115 (3710259477)
// size ...... 8063 (0x1f7f)
// includes .. 13  (offset: 0x1b2b)
// strings ... 64  (offset: 0x1b93)
// dev strs .. 16  (offset: 0x1ebf)
// exports ... 19  (offset: 0x118f)
// cseg ...... 0x3a3 + 0xdec (0x118f)
// imports ... 56  (offset: 0x1487)
// animtree1 . 0   (offset: 0x1f7f)
// animtree2 . 0   (offset: 0x1f7f)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;

#namespace br_sierra_sidequest_automaton;

// Namespace br_sierra_sidequest_automaton
// Params 0, eflags: 0x5
// Checksum 0x5d4ea395, Offset: 0x3c1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"automaton", #"br_map_quest", &pre_main, undefined );
}

// Namespace br_sierra_sidequest_automaton
// Params 0, eflags: 0x4
// Checksum 0xcd3c15f9, Offset: 0x3ea
// Size: 0x5e
function private pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_start:&on_start, #on_init:&on_init, #name:"automaton" };
    br_map_quest::register( quest );
}

// Namespace br_sierra_sidequest_automaton
// Params 0
// Checksum 0x1604288a, Offset: 0x450
// Size: 0x1a
function on_init()
{
    function_970d564ac5226b2e();
    function_1a00a5a2ba836d4d();
    
    /#
        thread debug_init();
    #/
}

// Namespace br_sierra_sidequest_automaton
// Params 0
// Checksum 0xc940c417, Offset: 0x472
// Size: 0x9
function on_start()
{
    thread garage_setup();
}

// Namespace br_sierra_sidequest_automaton
// Params 0
// Checksum 0xa202d067, Offset: 0x483
// Size: 0x10
function on_infil()
{
    spawn_keypad();
    vehicle_setup();
}

// Namespace br_sierra_sidequest_automaton
// Params 0
// Checksum 0x5c26b3f8, Offset: 0x49b
// Size: 0x2
function on_disabled()
{
    
}

// Namespace br_sierra_sidequest_automaton
// Params 0
// Checksum 0xfb762804, Offset: 0x4a5
// Size: 0x21
function function_970d564ac5226b2e()
{
    br_map_quest::add_setting( "truck_vehicle_name", "veh_sat_medium_truck_mg_wz" );
    br_map_quest::add_setting( "reset_time", 60 );
}

// Namespace br_sierra_sidequest_automaton
// Params 0
// Checksum 0xe0feb53d, Offset: 0x4ce
// Size: 0x3cf
function function_1a00a5a2ba836d4d()
{
    self.code_array = [ [ "134095", "481012", "874871", "492513", "066293", "503989", "745626", "085311" ], [ "483729", "915204", "672891", "340586", "798143", "256970", "864352", "109748" ], [ "582947", "104836", "739215", "461098", "890374", "257661", "013402", "648529" ], [ "374820", "005146", "618493", "247059", "231672", "492308", "156984", "769415" ], [ "684173", "209458", "751904", "336721", "890562", "417086", "963240", "128699" ] ];
    self.row_indices = [];
    
    for ( i = 0; i < self.code_array.size ; i++ )
    {
        self.row_indices[ self.row_indices.size ] = i;
    }
    
    self.passkey_indices = [];
    
    for ( i = 0; i < self.code_array[ 0 ].size ; i++ )
    {
        self.passkey_indices[ self.passkey_indices.size ] = i;
    }
    
    self.keypad_loc = utility::getstruct( "research_garage_keypad", "targetname" );
    self.jltv_loc = utility::getstruct( "research_garage_jltv", "targetname" );
    self.garage_buttons = getentitylessscriptablearray( "research_garage_button", #targetname );
    self.garage_doors = getentitylessscriptablearray( "research_garage_door", #targetname );
    var_b9c61222d2b1d254 = getentitylessscriptablearray( "research_garage_passkey", #script_noteworthy );
    assert( var_b9c61222d2b1d254.size <= 1, "<dev string:x24>" + var_b9c61222d2b1d254.size );
    self.var_9973832a9947d228 = var_b9c61222d2b1d254[ 0 ];
    var_d977d9ef051599de = getentitylessscriptablearray( "research_garage_auth", #script_noteworthy );
    assert( var_d977d9ef051599de.size <= 1, "<dev string:x63>" + var_d977d9ef051599de.size );
    self.var_97758c71a2e59392 = var_d977d9ef051599de[ 0 ];
    var_a24e4293ad7c689e = getentitylessscriptablearray( "research_garage_code", #script_noteworthy );
    assert( var_a24e4293ad7c689e.size <= 1, "<dev string:x9f>" + var_a24e4293ad7c689e.size );
    self.var_b86c38dfbe01fe70 = var_a24e4293ad7c689e[ 0 ];
    garage_keypad_array = getentitylessscriptablearray( "research_garage_keypad", #targetname );
    assert( garage_keypad_array.size <= 1, "<dev string:xdb>" + garage_keypad_array.size );
    self.garage_keypad = garage_keypad_array[ 0 ];
    
    if ( self.garage_buttons.size > 0 )
    {
        doors = getentitylessscriptablearray( self.garage_buttons[ 0 ].target, #targetname );
        assert( doors.size <= 1, "<dev string:x119>" + doors.size );
        self.door = doors[ 0 ];
    }
}

// Namespace br_sierra_sidequest_automaton
// Params 0
// Checksum 0xe5309c54, Offset: 0x8a5
// Size: 0x16f
function garage_setup()
{
    wait 1;
    
    if ( self.garage_buttons )
    {
        foreach ( button in self.garage_buttons )
        {
            button setscriptablepartstate( "arcwire_transmitter", "locked" );
        }
    }
    
    if ( self.garage_doors )
    {
        foreach ( door in self.garage_doors )
        {
            door scriptabledoorfreeze( 1 );
        }
    }
    
    if ( self.door )
    {
        self.navobstacleid = createnavobstaclebybounds( self.door.origin, ( 10, 125, 10 ), self.door.angles + ( 0, -90, 0 ) );
    }
}

// Namespace br_sierra_sidequest_automaton
// Params 0, eflags: 0x4
// Checksum 0xfdd7431, Offset: 0xa1c
// Size: 0xf0
function private spawn_keypad()
{
    if ( !self.garage_keypad && self.keypad_loc )
    {
        self.garage_keypad = spawnscriptable( "sierra_automaton_keypad", self.keypad_loc.origin, self.keypad_loc.angles ?? ( 0, 0, 0 ) );
    }
    
    if ( !isdefined( self.garage_keypad ) )
    {
        return;
    }
    
    self.garage_keypad setscriptablepartstate( self.garage_keypad.type, "on" );
    self.garage_keypad.successfunction = &keypad_success;
    self.garage_keypad.script_codelength = 6;
    self.garage_keypad function_fa6afd60c6bfe12();
    scriptable::scriptable_addusedcallbackbypart( "sierra_automaton_keypad", &keypadscriptableused );
    thread function_3a876824b1527128();
}

// Namespace br_sierra_sidequest_automaton
// Params 0, eflags: 0x4
// Checksum 0x6494c44d, Offset: 0xb14
// Size: 0xb5
function private vehicle_setup()
{
    if ( !isdefined( self.jltv_loc ) )
    {
        return;
    }
    
    vehicle = vehicle::spawn( br_map_quest::get_setting( "truck_vehicle_name" ), self.jltv_loc );
    self.vehicle = vehicle;
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle vehicle::godon();
    vehicle vehicle_occupancy::lock();
    vehicle_interact::allow_use( vehicle, 0 );
    vehicle notsolid();
    self.veh_col = spawnscriptable( "sierra_automaton_veh_col", self.jltv_loc.origin, self.jltv_loc.angles ?? ( 0, 0, 0 ) );
}

// Namespace br_sierra_sidequest_automaton
// Params 0, eflags: 0x4
// Checksum 0x9a3cb668, Offset: 0xbd1
// Size: 0x78
function private function_3a876824b1527128()
{
    level endon( #"game_ended" );
    reset_time = br_map_quest::get_setting( "reset_time" );
    wait_time = reset_time / 8;
    
    while ( true )
    {
        for ( i = 0; i < 8 ; i++ )
        {
            self.var_9973832a9947d228 setscriptablepartstate( "base", string( i ) );
            wait wait_time;
        }
        
        function_fa6afd60c6bfe12();
    }
}

// Namespace br_sierra_sidequest_automaton
// Params 1, eflags: 0x4
// Checksum 0x2050107e, Offset: 0xc51
// Size: 0x24c
function private keypad_success( instance )
{
    quest = br_map_quest::get_quest( "automaton" );
    instance setscriptablepartstate( instance.type, "unlocked" );
    thread points::function_40522c040a4e7b1( self.team, #"hash_43dc95216ea219ec" );
    
    if ( quest.garage_doors )
    {
        foreach ( door in quest.garage_doors )
        {
            door scriptabledoorfreeze( 0 );
        }
    }
    
    if ( quest.garage_buttons )
    {
        foreach ( button in quest.garage_buttons )
        {
            button setscriptablepartstate( "arcwire_transmitter", "standby" );
        }
    }
    
    if ( quest.veh_col )
    {
        quest.veh_col freescriptable();
    }
    
    if ( quest.vehicle )
    {
        quest.vehicle vehicle::godoff();
        quest.vehicle vehicle_occupancy::unlock();
        vehicle_interact::allow_use( quest.vehicle, 1 );
        quest.vehicle solid();
    }
    
    if ( quest.navobstacleid )
    {
        destroynavobstacle( quest.navobstacleid );
    }
    
    if ( self )
    {
        challenges::function_37e945722d6497f3( self, "sierra_jltv_garage", 1, 1 );
    }
    
    params = { #completed_by:teams::getteamdata( self.team, "players" ), #is_successful:1 };
    quest br_map_quest::on_completed( params );
}

// Namespace br_sierra_sidequest_automaton
// Params 6, eflags: 0x4
// Checksum 0x972eb571, Offset: 0xea5
// Size: 0x48
function private keypadscriptableused( instance, part, state, player, bautouse, usestring )
{
    level thread _keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_sierra_sidequest_automaton
// Params 5, eflags: 0x4
// Checksum 0x6641a2e7, Offset: 0xef5
// Size: 0x9c
function private _keypadscriptableused( instance, part, state, player, bautouse )
{
    level endon( #"game_ended" );
    assert( part == "<dev string:x156>", "<dev string:x16e>" + part );
    instance setscriptablepartstate( part, "off" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    wait 1;
    
    if ( instance.codestatus != 2 )
    {
        instance setscriptablepartstate( part, "on" );
    }
}

// Namespace br_sierra_sidequest_automaton
// Params 0, eflags: 0x4
// Checksum 0x5ac15bf, Offset: 0xf99
// Size: 0x10a
function private function_fa6afd60c6bfe12()
{
    quest = br_map_quest::get_quest( "automaton" );
    board_index = utility::function_879489791c3d805( quest.row_indices, [ quest.last_board ] );
    passkey_index = utility::function_879489791c3d805( quest.passkey_indices, [ quest.last_passkey ] );
    quest.last_board = board_index;
    quest.last_passkey = passkey_index;
    
    if ( quest.var_b86c38dfbe01fe70 )
    {
        quest.var_b86c38dfbe01fe70 setscriptablepartstate( "base", string( board_index ) );
    }
    
    if ( quest.var_97758c71a2e59392 )
    {
        quest.var_97758c71a2e59392 setscriptablepartstate( "base", string( passkey_index ) );
    }
    
    quest.garage_keypad.code = [ "string":quest.code_array[ board_index ][ passkey_index ] ];
}

/#

    // Namespace br_sierra_sidequest_automaton
    // Params 0
    // Checksum 0x37bce962, Offset: 0x10ab
    // Size: 0x4a, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1a1>" + "<dev string:x1b0>" );
        devgui::add_devgui_func( "<dev string:x1bb>", "<dev string:x1c9>", &function_fa6afd60c6bfe12 );
        devgui::add_devgui_func( "<dev string:x1eb>", "<dev string:x1f8>", &debug_display_code );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_sierra_sidequest_automaton
    // Params 0, eflags: 0x4
    // Checksum 0x9630c209, Offset: 0x10fd
    // Size: 0x92, Type: dev
    function private debug_display_code()
    {
        level endon( #"game_ended" );
        quest = br_map_quest::get_quest( "<dev string:x219>" );
        
        while ( true )
        {
            if ( quest.garage_keypad )
            {
                print3d( quest.garage_keypad.origin + ( 0, 0, 20 ), "<dev string:x223>" + quest.garage_keypad.code[ "<dev string:x22a>" ], undefined, undefined, 0.08, undefined, 1 );
            }
            
            waitframe();
        }
    }

#/
