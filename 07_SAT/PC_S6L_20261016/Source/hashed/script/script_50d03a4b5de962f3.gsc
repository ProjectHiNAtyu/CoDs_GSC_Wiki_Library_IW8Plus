// script_50d03a4b5de962f3  (hash_50d03a4b5de962f3.gscc) (size: 13120 Bytes / 0x3340 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xaf71d3fa (2943472634)
// size ...... 13120 (0x3340)
// includes .. 13  (offset: 0x3014)
// strings ... 31  (offset: 0x307c)
// dev strs .. 16  (offset: 0x327c)
// exports ... 55  (offset: 0x1b08)
// cseg ...... 0x3f5 + 0x1713 (0x1b08)
// imports ... 102 (offset: 0x23a0)
// animtree1 . 0   (offset: 0x3340)
// animtree2 . 0   (offset: 0x3340)
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_heatmap_radar;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\hud_message;
#using scripts\mp\interaction;

#namespace br_sierra_sidequest_activate_surveillance;

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x5
// Checksum 0x2933aad0, Offset: 0x413
// Size: 0x98
function private autoexec init()
{
    quest = { #var_7c04daff2998905a:getdvarint( @"hash_a0a4ffc6fa595604", 1 ), #var_b68b74a75282d22f:getdvarint( @"hash_351f56f1fb38e3de", 0 ), #var_9337c96f5edd863d:getdvarint( @"hash_ba753be660e7a2f7", 1800 ), #on_infil:&on_infil, #on_start:&on_start, #on_init:&on_init, #name:"activate_surveillance" };
    br_map_quest::register( quest );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x6d31ff3e, Offset: 0x4b3
// Size: 0xb6
function private on_init()
{
    /#
        debug_init();
    #/
    
    init_dialog();
    var_2b71e6aa095c958b = getdvarint( @"hash_35836f7cba236cf5", 15 );
    self.var_a4c0428fdf195d73 = throttle::throttle_initialize( "activate_surveillance_player_count", var_2b71e6aa095c958b );
    var_ee96e7449d738bde = getdvarint( @"hash_5c03263b552e45b6", 4 );
    self.var_cce8be4e3fa89372 = throttle::throttle_initialize( "activate_surveillance_send_value", var_ee96e7449d738bde );
    var_7f6fb6199eb4ce7d = level.framedurationseconds * ( 150 / var_2b71e6aa095c958b + 150 / var_ee96e7449d738bde );
    assert( 5 > var_7f6fb6199eb4ce7d, "<dev string:x24>" + 5 + "<dev string:x3f>" + var_7f6fb6199eb4ce7d + "<dev string:x6a>" );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x30fcfbbd, Offset: 0x571
// Size: 0xc
function private on_start()
{
    self.var_c805a321c2137fd4 = 0;
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x913ef48b, Offset: 0x585
// Size: 0x93
function private on_infil()
{
    init_electric_box();
    function_c4ebca8f7435b099();
    init_computer();
    init_screens();
    init_ceiling_fx();
    init_satellite_ring();
    init_triggers();
    
    /#
        if ( getdvarint( @"hash_b1cd01466ef7c894", 0 ) )
        {
            self.computer set_computer_state( #"activate" );
        }
        
        if ( getdvarint( @"hash_80c4629199589ba1", 0 ) )
        {
            self.var_3149c7254ee89e9d thread function_340d440231cd2414( self.var_381395e66ecb44db, self.var_4a4070da33287b6a );
        }
    #/
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x86485328, Offset: 0x620
// Size: 0x3b
function private init_dialog()
{
    game[ "dialog" ][ "acsu_wzan_sust" ] = "acsu_wzan_sust";
    game[ "dialog" ][ "acsu_wzan_suac" ] = "acsu_wzan_suac";
    game[ "dialog" ][ "acsu_wzan_sure" ] = "acsu_wzan_sure";
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x8885edd7, Offset: 0x663
// Size: 0x67
function private init_electric_box()
{
    electricbox = spawnscriptable( "activate_surveillance_electrical_box", ( 4658, 41348, 1293 ), ( 0, 180, 0 ) );
    electricbox.interact = interaction::register_scriptable_interact( electricbox, &function_9ed5cb56c7835c60 );
    electricbox set_electrical_box_state( #"off" );
    self.electricbox = electricbox;
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x648536d2, Offset: 0x6d2
// Size: 0x1d
function private set_electrical_box_state( state )
{
    self setscriptablepartstate( #"electrical_box", state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x2c2eb905, Offset: 0x6f7
// Size: 0x169
function private function_c4ebca8f7435b099()
{
    var_9f65f6688e9737da = utility::array_random( [ { #angles:( 0, 135, 0 ), #origin:( 3436, 37943, 1750 ) }, { #angles:( 0, -45, 0 ), #origin:( 3722, 37656, 1750 ) }, { #angles:( 0, 135, 0 ), #origin:( 4025, 37355, 1750 ) }, { #angles:( 0, -45, 0 ), #origin:( 4169, 37662, 1750 ) }, { #angles:( 0, 135, 0 ), #origin:( 3842, 37988, 1750 ) } ] );
    keypad = spawnscriptable( "activate_surveillance_keypad", var_9f65f6688e9737da.origin, var_9f65f6688e9737da.angles );
    keypad.interact = interaction::register_scriptable_interact( keypad, &on_keypad_used );
    keypad set_keypad_state( #"hash_d8aa90814b67730a" );
    self.keypad = keypad;
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x9b220fac, Offset: 0x868
// Size: 0x1d
function private set_keypad_state( state )
{
    self setscriptablepartstate( getxhash( "activate_surveillance_keypad" ), state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x58f61c1b, Offset: 0x88d
// Size: 0xbf
function private init_computer()
{
    computer = spawnscriptable( "maphint_activate_surveillance_computer", ( 3104.25, 39472, 2003 ), ( 312.621, 180, 0 ) );
    computer.interact = interaction::register_scriptable_interact( computer, &on_computer_used );
    computer set_computer_state( #"hash_d8aa90814b67730a" );
    self.computer = computer;
    self.var_68b8a4712ba0d4ed = spawnscriptable( "activate_surveillance_computer_side_screen", ( 3102, 39498.5, 2002.75 ), ( 312.621, 191.475, 0 ) );
    self.var_4a09796790744168 = spawnscriptable( "activate_surveillance_computer_side_screen", ( 3102.25, 39445.8, 2002.75 ), ( 312.622, 168.922, 0 ) );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0xb3ee6d1d, Offset: 0x954
// Size: 0x1d
function private set_computer_state( state )
{
    self setscriptablepartstate( getxhash( "maphint_activate_surveillance_computer" ), state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0xe7984a09, Offset: 0x979
// Size: 0x1d
function private function_c460039b3f21b1fb( state )
{
    self setscriptablepartstate( getxhash( "activate_surveillance_computer_side_screen" ), state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x21bd0305, Offset: 0x99e
// Size: 0x3a
function private init_screens()
{
    self.centralscreen = getentitylessscriptablearray( "fjord_central_screen", #script_noteworthy )[ 0 ];
    self.sidescreens = getentitylessscriptablearray( "activate_surveillance_side_screen", #script_noteworthy );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0xe9272785, Offset: 0x9e0
// Size: 0x1d
function private function_e7806e3f4db8c1ff( state )
{
    self setscriptablepartstate( getxhash( "screen" ), state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x4d559d15, Offset: 0xa05
// Size: 0x1d
function private function_33c342d488ca5957( state )
{
    self setscriptablepartstate( getxhash( "activate_surveillance_side_screen" ), state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x9188ba89, Offset: 0xa2a
// Size: 0x41
function private init_ceiling_fx()
{
    ceilingfx = spawnscriptable( "activate_surveillance_ceiling_fx", ( 3352, 39474, 2226 ) );
    ceilingfx set_ceiling_fx_state( #"off" );
    self.ceilingfx = ceilingfx;
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x588606a0, Offset: 0xa73
// Size: 0x1d
function private set_ceiling_fx_state( state )
{
    self setscriptablepartstate( getxhash( "activate_surveillance_ceiling_fx" ), state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x416b5c71, Offset: 0xa98
// Size: 0x1d
function private function_dfb450ef7136f311( state )
{
    self setscriptablepartstate( #"vfx", state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0xacafe66, Offset: 0xabd
// Size: 0x2b
function private init_satellite_ring()
{
    satellitering = getent( "fjord_satellite_ring", #script_noteworthy );
    self.satellitering = satellitering;
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x8003b764, Offset: 0xaf0
// Size: 0xb3
function private init_triggers()
{
    self.var_381395e66ecb44db = getdvarint( @"hash_220cc6a5e16310ab", 1200 );
    self.var_4a4070da33287b6a = getdvarint( @"hash_dc63ea699ea78e3a", 800 );
    var_45d1657a776ee504 = ( -500, 0, self.var_4a4070da33287b6a * -1 / 2 );
    self.var_3149c7254ee89e9d = spawn( "noent_volume_trigger_radius", self.centralscreen.origin + var_45d1657a776ee504, 0, self.var_381395e66ecb44db, self.var_4a4070da33287b6a );
    trigger::makeenterexittrigger( self.var_3149c7254ee89e9d, &function_886d91b7e6120e8, &function_76210b4e38524466, undefined, undefined, &trigger_filter );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 3, eflags: 0x4
// Checksum 0x15b421a, Offset: 0xbab
// Size: 0x25, Type: bool
function private trigger_filter( var_11bf9622e9646279, trigger, payload )
{
    return !isplayer( var_11bf9622e9646279 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 2, eflags: 0x4
// Checksum 0x8f9734cd, Offset: 0xbd9
// Size: 0x23
function private function_886d91b7e6120e8( ent, trigger )
{
    ent setclientomnvar( "sierra_activate_surveillance_heatmap_screen_active", 1 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 2, eflags: 0x4
// Checksum 0x326fe257, Offset: 0xc04
// Size: 0x22
function private function_76210b4e38524466( ent, trigger )
{
    ent setclientomnvar( "sierra_activate_surveillance_heatmap_screen_active", 0 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x1a95f496, Offset: 0xc2e
// Size: 0x13
function private function_cec401311871d3de()
{
    omnvar_utility::function_8b206c75cb7ad548( "sierra_activate_surveillance_heatmap_animations", 0, 1, 1 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0xc10672db, Offset: 0xc49
// Size: 0x12
function private function_e532b4859ff117c4()
{
    omnvar_utility::function_8b206c75cb7ad548( "sierra_activate_surveillance_heatmap_animations", 0, 1, 0 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x6db7988f, Offset: 0xc63
// Size: 0x14
function private function_cf15f48700c29234()
{
    omnvar_utility::function_8b206c75cb7ad548( "sierra_activate_surveillance_heatmap_animations", 1, 1, 1 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x10e811c2, Offset: 0xc7f
// Size: 0x13
function private function_5aeb3d913bb8f3ca()
{
    omnvar_utility::function_8b206c75cb7ad548( "sierra_activate_surveillance_heatmap_animations", 1, 1, 0 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0xd71da758, Offset: 0xc9a
// Size: 0x14
function private function_611bde85cb223d6c()
{
    omnvar_utility::function_8b206c75cb7ad548( "sierra_activate_surveillance_heatmap_animations", 2, 1, 1 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0xff523d73, Offset: 0xcb6
// Size: 0x13
function private function_3f38cdcc0fbcd80a()
{
    omnvar_utility::function_8b206c75cb7ad548( "sierra_activate_surveillance_heatmap_animations", 2, 1, 0 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x41233ef3, Offset: 0xcd1
// Size: 0xa1
function private function_869fcb2bcf38d688()
{
    level endon( #"game_ended" );
    self waittill( #"hash_d5b90ee96fa2305e" );
    
    foreach ( player in level.players )
    {
        if ( !player::isreallyalive( player ) )
        {
            continue;
        }
        
        player function_f338d3d650732316();
    }
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x488905e2, Offset: 0xd7a
// Size: 0x79
function private function_27a4d353e90b3480( state )
{
    quest = br_map_quest::get_quest( "activate_surveillance" );
    quest.var_68b8a4712ba0d4ed function_c460039b3f21b1fb( state == "on" ? #"left_on" : state );
    quest.var_4a09796790744168 function_c460039b3f21b1fb( state == "on" ? #"right_on" : state );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x970d7e8c, Offset: 0xdfb
// Size: 0x6d
function private function_5c2896da41ce6cd0( player )
{
    quest = br_map_quest::get_quest( "activate_surveillance" );
    errormessage = %"hash_4170c55a62cbe811";
    
    if ( quest.var_c07b3708003f1d7a )
    {
        errormessage = %"hash_5d37b38b470c7a11";
    }
    
    player [[ level.showerrormessagefunc ]]( errormessage );
    player function_9573d2150100073b( "Upload", 0 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0xb1ccfa15, Offset: 0xe70
// Size: 0x1d7
function private function_e1bf51610a66652e( player )
{
    level notify( #"activate_surveillance_computer_used" );
    player function_9573d2150100073b( "Upload", 1 );
    set_computer_state( #"scan_complete" );
    quest = br_map_quest::get_quest( "activate_surveillance" );
    quest.keypad set_keypad_state( #"disabled" );
    quest thread br_heatmap_radar::function_af96b137d5b71cfa();
    quest thread function_869fcb2bcf38d688();
    wait 0.6;
    function_27a4d353e90b3480( #"loading" );
    quest.centralscreen function_e7806e3f4db8c1ff( #"hash_f78d4368aaa90f5" );
    thread function_d6ef2e6156af2f7d( quest.sidescreens );
    quest.satellitering function_dfb450ef7136f311( #"on" );
    function_611bde85cb223d6c();
    wait 6;
    quest.ceilingfx set_ceiling_fx_state( #"on" );
    wait 2;
    utility::exploder( "activate_surveillance_vfx" );
    earthquake( 0.2, 9, quest.ceilingfx.origin, 1000 );
    quest.satellitering rotateyaw( 1080, 40, 5, 5 );
    wait 10;
    function_bfed21f1444c046a();
    function_cec401311871d3de();
    function_27a4d353e90b3480( "on" );
    set_computer_state( #"download" );
    self.var_795eaf9beebc0a8a = 0;
    
    if ( !quest.var_7c04daff2998905a )
    {
        br_public::brleaderdialogplayer( "acsu_wzan_sust", player, 1, 0, 0, undefined, "dx_br_bras_" );
    }
    
    wait 2.4;
    function_e532b4859ff117c4();
    
    if ( quest.var_7c04daff2998905a )
    {
        childthread function_aac2f402e07d8fe7( player );
    }
    
    wait 30;
    computer_reset();
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0xc3ba306f, Offset: 0x104f
// Size: 0x98
function private computer_reset()
{
    function_bfed21f1444c046a();
    function_3f38cdcc0fbcd80a();
    set_computer_state( #"activate" );
    function_27a4d353e90b3480( #"off" );
    quest = br_map_quest::get_quest( "activate_surveillance" );
    quest.ceilingfx set_ceiling_fx_state( #"off" );
    quest.satellitering function_dfb450ef7136f311( #"off" );
    function_266228c64dddc02d( quest.sidescreens );
    quest function_14c407a32fe3d03a();
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x40f1808d, Offset: 0x10ef
// Size: 0x17a
function private function_aac2f402e07d8fe7( player )
{
    level endon( #"game_ended" );
    
    if ( self.var_795eaf9beebc0a8a )
    {
        return;
    }
    
    self.var_795eaf9beebc0a8a = 1;
    function_cf15f48700c29234();
    wait 0.74;
    player function_9573d2150100073b( "Download", 1 );
    
    foreach ( teammate in teams::getteamdata( player.team, "players" ) )
    {
        if ( player::isreallyalive( teammate ) && !teammate br_public::isplayerinorgoingtogulag() )
        {
            alias = "acsu_wzan_sure";
            
            if ( player == teammate )
            {
                alias = "acsu_wzan_suac";
            }
            
            br_public::brleaderdialogplayer( alias, teammate, 1, 0, 0, undefined, "dx_br_bras_" );
            thread function_43dd729bc974753f( teammate );
        }
    }
    
    wait 0.27;
    function_5aeb3d913bb8f3ca();
    function_ecbfb3d7bd32a386( #"download_complete", #"download_complete", #"download_complete" );
    wait 5;
    function_ecbfb3d7bd32a386( #"download", #"left_on", #"right_on" );
    self.var_795eaf9beebc0a8a = 0;
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 3, eflags: 0x4
// Checksum 0x13f4155f, Offset: 0x1271
// Size: 0x71
function private function_ecbfb3d7bd32a386( computerstate, var_d208ce0992c05398, var_dc5e9f10912fee41 )
{
    quest = br_map_quest::get_quest( "activate_surveillance" );
    quest.computer set_computer_state( computerstate );
    quest.var_68b8a4712ba0d4ed function_c460039b3f21b1fb( var_d208ce0992c05398 );
    quest.var_4a09796790744168 function_c460039b3f21b1fb( var_dc5e9f10912fee41 );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x836309b0, Offset: 0x12ea
// Size: 0x97
function private on_computer_used( player )
{
    level endon( #"game_ended" );
    level endon( #"hash_fcf7c9a697b8a0f7" );
    state = getxhash( self getscriptablepartstate( "maphint_activate_surveillance_computer" ) );
    
    switch ( state )
    {
        case #"hash_d8aa90814b67730a":
            childthread function_5c2896da41ce6cd0( player );
            return;
        case #"activate":
            childthread function_e1bf51610a66652e( player );
            return;
        case #"download":
            childthread function_aac2f402e07d8fe7( player );
            return;
        default:
            return;
    }
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x536482bb, Offset: 0x1389
// Size: 0x72
function private function_9ed5cb56c7835c60( player )
{
    set_electrical_box_state( #"unusable_on" );
    quest = br_map_quest::get_quest( "activate_surveillance" );
    quest.keypad set_keypad_state( #"hash_34fc4f08a712fa58" );
    quest.var_c07b3708003f1d7a = 1;
    player dlog_recordplayerevent( "dlog_event_br_sierra_activate_surveillance_power_used", [] );
    quest thread function_f57f11422f2722b1();
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x1f048c24, Offset: 0x1403
// Size: 0x24
function private function_f57f11422f2722b1()
{
    level endon( #"hash_92851957582cfedb" );
    level endon( #"game_ended" );
    wait 60;
    function_14c407a32fe3d03a();
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0xaf72f942, Offset: 0x142f
// Size: 0x8a
function private on_keypad_used( player )
{
    quest = br_map_quest::get_quest( "activate_surveillance" );
    
    if ( !quest.var_c07b3708003f1d7a )
    {
        player [[ level.showerrormessagefunc ]]( %"hash_4170c55a62cbe811" );
        return;
    }
    
    level notify( #"hash_92851957582cfedb" );
    set_keypad_state( #"hash_e859b8b6d5b176b1" );
    quest.computer set_computer_state( #"activate" );
    quest thread function_c14522e0da603c1d();
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0x750a521f, Offset: 0x14c1
// Size: 0x24
function private function_c14522e0da603c1d()
{
    level endon( #"activate_surveillance_computer_used" );
    level endon( #"game_ended" );
    wait 60;
    function_14c407a32fe3d03a();
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0xbc02c94f, Offset: 0x14ed
// Size: 0x63
function private function_14c407a32fe3d03a()
{
    self.electricbox set_electrical_box_state( #"off" );
    self.keypad set_keypad_state( #"hash_d8aa90814b67730a" );
    self.computer set_computer_state( #"hash_d8aa90814b67730a" );
    self.var_c07b3708003f1d7a = undefined;
    level notify( #"hash_fcf7c9a697b8a0f7" );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0xce577498, Offset: 0x1558
// Size: 0x101
function private function_d6ef2e6156af2f7d( sidescreens )
{
    foreach ( screen in sidescreens )
    {
        wait 2;
        screen function_33c342d488ca5957( #"loading" );
    }
    
    foreach ( i, screen in sidescreens )
    {
        wait 2;
        screen function_33c342d488ca5957( getxhash( "on" + i ) );
    }
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0x43e5f5c6, Offset: 0x1661
// Size: 0x87
function private function_266228c64dddc02d( sidescreens )
{
    foreach ( screen in sidescreens )
    {
        screen function_33c342d488ca5957( #"off" );
    }
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 2, eflags: 0x4
// Checksum 0x67637e02, Offset: 0x16f0
// Size: 0x3f
function private function_9573d2150100073b( var_617291e3d8e10578, success )
{
    self dlog_recordplayerevent( "dlog_event_br_sierra_activate_surveillance_computer_used", [ "used_computer", var_617291e3d8e10578, "recon_contract_completed", success ] );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 1, eflags: 0x4
// Checksum 0xf92a2b5c, Offset: 0x1737
// Size: 0x56
function private function_43dd729bc974753f( player )
{
    quest = br_map_quest::get_quest( "activate_surveillance" );
    player thread hud_message::showsplash( "br_sierra_activate_surveillance_heatmap" );
    player lower_message::setlowermessageomnvar( "br_sierra_activate_surveillance_open_tacmap", undefined, 10 );
    br_heatmap_radar::function_42cfd66ef29d2b0b( player, quest.var_9337c96f5edd863d );
}

// Namespace br_sierra_sidequest_activate_surveillance
// Params 0, eflags: 0x4
// Checksum 0xdbd0747a, Offset: 0x1795
// Size: 0x8e
function private function_bfed21f1444c046a()
{
    quest = level.br_map_quest.quests[ "activate_surveillance" ];
    quest.var_c805a321c2137fd4 = !quest.var_c805a321c2137fd4;
    
    if ( quest.centralscreen )
    {
        var_eba67cf41b560b74 = quest.var_c805a321c2137fd4 ? #"hash_b9af722eefc5c3e0" : #"hash_110fb44835894c53";
        quest.centralscreen function_e7806e3f4db8c1ff( var_eba67cf41b560b74 );
    }
}

/#

    // Namespace br_sierra_sidequest_activate_surveillance
    // Params 0, eflags: 0x4
    // Checksum 0x3c8a11a8, Offset: 0x182b
    // Size: 0x8c, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x6c>" + "<dev string:x7b>" );
        devgui::add_devgui_func( "<dev string:x92>", "<dev string:xa8>", &function_bfed21f1444c046a );
        devgui::add_devgui_func( "<dev string:xd4>", "<dev string:xf9>", &function_861dca2791bed582 );
        devgui::add_devgui_func( "<dev string:x11b>", "<dev string:x136>", &function_93624fe34c59d70c );
        devgui::add_devgui_func( "<dev string:x167>", "<dev string:x17a>", &function_2dfaed8d00f1ad24 );
        devgui::add_devgui_func( "<dev string:x1a3>", "<dev string:x1b8>", &function_be06e413a84aaadd );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_sierra_sidequest_activate_surveillance
    // Params 0, eflags: 0x4
    // Checksum 0xc96cb607, Offset: 0x18bf
    // Size: 0x22, Type: dev
    function private function_be06e413a84aaadd()
    {
        level.players[ 0 ] setorigin( ( 3104.25, 39472, 2003 ) );
    }

    // Namespace br_sierra_sidequest_activate_surveillance
    // Params 0, eflags: 0x4
    // Checksum 0xdd56f0fb, Offset: 0x18e9
    // Size: 0x37, Type: dev
    function private function_93624fe34c59d70c()
    {
        level.players[ 0 ] setorigin( ( 4658, 41348, 1293 ) + anglestoforward( ( 0, 180, 0 ) ) * 50 );
    }

    // Namespace br_sierra_sidequest_activate_surveillance
    // Params 0, eflags: 0x4
    // Checksum 0x92307920, Offset: 0x1928
    // Size: 0x6c, Type: dev
    function private function_2dfaed8d00f1ad24()
    {
        quest = level.br_map_quest.quests[ "<dev string:x1e3>" ];
        level.players[ 0 ] setorigin( quest.keypad.origin + anglestoforward( quest.keypad.angles ) * 50 );
    }

    // Namespace br_sierra_sidequest_activate_surveillance
    // Params 0, eflags: 0x4
    // Checksum 0x8e38f61, Offset: 0x199c
    // Size: 0xb2, Type: dev
    function private function_d9b64c9b5b0a7dd2()
    {
        level endon( #"game_ended" );
        quest = level.br_map_quest.quests[ "<dev string:x1e3>" ];
        
        if ( quest.var_c805a321c2137fd4 )
        {
            quest.var_c805a321c2137fd4 = 0;
            
            if ( quest.centralscreen )
            {
                quest.centralscreen function_e7806e3f4db8c1ff( #"hash_110fb44835894c53" );
            }
        }
        
        waitframe();
        quest.var_c805a321c2137fd4 = 1;
        
        if ( quest.centralscreen )
        {
            quest.centralscreen function_e7806e3f4db8c1ff( #"hash_b9af722eefc5c3e0" );
        }
    }

    // Namespace br_sierra_sidequest_activate_surveillance
    // Params 0, eflags: 0x4
    // Checksum 0x4e088c35, Offset: 0x1a56
    // Size: 0x13, Type: dev
    function private function_861dca2791bed582()
    {
        br_heatmap_radar::function_466097d3e1ca7a3a();
        thread function_d9b64c9b5b0a7dd2();
    }

    // Namespace br_sierra_sidequest_activate_surveillance
    // Params 2, eflags: 0x4
    // Checksum 0xf2187ff0, Offset: 0x1a71
    // Size: 0x97, Type: dev
    function private function_340d440231cd2414( radius, height )
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        origin = self.origin;
        var_86e1f12de7c1b673 = origin + ( 0, 0, height );
        color = ( 1, 0, 0 );
        
        while ( true )
        {
            waitframe();
            line( origin, var_86e1f12de7c1b673, color, 1, 1, 1 );
            cylinder( origin, var_86e1f12de7c1b673, radius, color, 1, 1 );
        }
    }

#/
