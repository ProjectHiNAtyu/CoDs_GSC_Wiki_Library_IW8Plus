// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_phone.gsc  (hash_6a4be0ffaf614226.gscc) (size: 22084 Bytes / 0x5644 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1ef34a7b (519260795)
// size ...... 22084 (0x5644)
// includes .. 19  (offset: 0x4fc4)
// strings ... 86  (offset: 0x505c)
// dev strs .. 13  (offset: 0x55a4)
// exports ... 38  (offset: 0x34a8)
// cseg ...... 0x7a2 + 0x2d06 (0x34a8)
// imports ... 169 (offset: 0x3a98)
// animtree1 . 0   (offset: 0x5644)
// animtree2 . 0   (offset: 0x5644)
#using script_16ea1b94f0f381b3;
#using scripts\common\active_env\portals;
#using scripts\common\active_env\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\doorbuy;
#using scripts\mp\equipment;
#using scripts\mp\interaction;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_pap_quest;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_rb;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_phone;

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0xfba6150a, Offset: 0x7c0
// Size: 0x304
function init()
{
    s_phone = utility::getstruct( "zm_sat_scarab_phone", "targetname" );
    
    if ( !s_phone )
    {
        return;
    }
    
    level utility::flag_wait( "scriptables_ready" );
    a_door_scriptables = getscriptablearray( "doorbuy_door_18", #targetname );
    a_doors = arraycombineunique( a_doors, a_door_scriptables );
    var_acc3550c7b0f250a = getentitylessscriptablearray( "doorbuy_door_18", #targetname );
    a_doors = arraycombineunique( a_doors, var_acc3550c7b0f250a );
    a_door_ents = getentarray( "doorbuy_door_18", #targetname );
    a_doors = arraycombineunique( a_doors, a_door_ents );
    
    foreach ( door in a_doors )
    {
        door.script_noteworthy = "no_minimap";
        
        if ( door.minimap_scriptable )
        {
            door.minimap_scriptable freescriptable();
        }
    }
    
    level utility::add_fx( "teleport_3p", "vfx_t10_gameplay_zm_bgb_anywhere_but_here_teleport_zmb_3p" );
    s_phone scene::play( [], "init", "sat_scene_scarab_answer_call_zm" );
    [ var_4fbe82bc1129cd0e ] = s_phone scene::get_entities();
    var_4fbe82bc1129cd0e.scene_root = s_phone;
    
    if ( level utility::flag( "only_scarab_phone_visuals" ) )
    {
        return;
    }
    
    var_4fbe82bc1129cd0e.interact = zm_quest::function_91f9590e98d57ff6( var_4fbe82bc1129cd0e.origin + ( 0, 0, 8 ), &function_d879c005a663e484, &function_ab30f2d192df9206, "extrasmall_unusablewhenobstructed" );
    var_4fbe82bc1129cd0e.interact.var_4fbe82bc1129cd0e = var_4fbe82bc1129cd0e;
    level.scarab_phone = var_4fbe82bc1129cd0e;
    level.var_255753bd26bf0bdd = 0;
    level.var_71af9b4e3751cbbf = 0;
    level callback::add( "on_round_end", &on_round_end );
    level.scarab_phone_portal_brush = getent( "portal_brush", #targetname );
    level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362 = getent( "scarab_portal_forward", #targetname );
    
    if ( level.scarab_phone_portal_brush )
    {
        level.scarab_phone_portal_brush hide();
    }
    
    level thread front_door_setup();
    level thread watch_open_sesame();
    level thread function_b72cb5eadc2539c8();
    level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362.var_2758a512189db7aa = 1;
    level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362.var_670c0bc02418cdc3 = &function_4dbccf80de5ac9;
    level namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_ed1be3d917da49ba", &function_4cb5b7295a7621a3 );
    
    /#
        level thread setup_scarab_phone_devgui();
    #/
    
    level thread function_dc160a480e12c05b();
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0xcc2a0db4, Offset: 0xacc
// Size: 0x125
function private front_door_setup()
{
    level utility::flag_wait( "doorbuy_init_complete" );
    front_door = getent( "doorbuy_door_18", "target2" );
    front_door.var_a0d364b16ee53ab6 = "";
    front_door interaction::set_interact_hint_callback();
    front_door makeunusable();
    level.scarab_phone.spirit_path_array = [];
    var_ed92d3edd3eded9 = utility::getstruct( "zm_sat_scarab_phone_spirit_path0", "targetname" );
    
    for ( i = 0;  ; i++ )
    {
        if ( !isdefined( level.scarab_phone.spirit_path_array ) )
        {
            level.scarab_phone.spirit_path_array = [];
        }
        
        level.scarab_phone.spirit_path_array[ level.scarab_phone.spirit_path_array.size ] = var_ed92d3edd3eded9.origin;
        
        if ( !var_ed92d3edd3eded9.target )
        {
            break;
        }
        
        var_ed92d3edd3eded9 = utility::getstruct( var_ed92d3edd3eded9.target, "targetname" );
    }
    
    level utility::add_fx( "phone_spirit", "vfx_sat_levels_zm_scarab_spirit" );
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0xfa1b3bef, Offset: 0xbf9
// Size: 0x1ad
function private function_b72cb5eadc2539c8()
{
    level endon( #"game_ended" );
    level zm_quest::register_quest_step( #"scarab_phone_quest", #"survive" );
    level zm_quest::register_quest_step( #"scarab_phone_quest", #"hash_67cf8608037190df" );
    level zm_quest::register_quest_step( #"scarab_phone_quest", #"escape" );
    level zm_save::function_1f44a48caae2acbf();
    level.scarab_phone.var_b249c3f5faace516 = level zm_quest::function_73720cdf21c3cfd7( #"scarab_phone_quest", #"hash_9c0ac2a3b56a997d" ) ?? 0;
    level utility::flag_wait_all( "initial_player_connected", "zone_setup_finished", "begin_round_logic" );
    
    if ( level.scarab_phone.var_b249c3f5faace516 )
    {
        level notify( #"phone_portal_initialized" );
        level utility::flag_set( "phone_portal_initialized" );
        portals::portals_init();
        var_66565a6231a1994a = zm_sat_scarab_rb::function_41160421ad0382b();
        
        if ( var_66565a6231a1994a.size > 0 )
        {
            function_857b200df7e6b159();
        }
        
        var_64977c0d702cc59d = zm_sat_scarab_rb::function_64977c0d702cc59d();
        
        if ( var_64977c0d702cc59d )
        {
            level thread function_a92efbbd3982daf4( #"survive" );
            level thread function_a92efbbd3982daf4( #"hash_67cf8608037190df", undefined, #"escape", 2, 1 );
            level.scarab_phone.var_12c3e41f78d1cce2 = 1;
        }
        else
        {
            level.scarab_phone.var_aa3febe5f666b58f = 1;
        }
    }
    else
    {
        level thread function_a92efbbd3982daf4( undefined, undefined, #"survive", 1 );
    }
    
    level utility::flag_set( "load_phone_finished" );
    level thread zm_quest::start_quest( #"scarab_phone_quest" );
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0x4f4e655b, Offset: 0xdae
// Size: 0x2d
function private watch_open_sesame()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "open_sesame" );
    level thread function_92c12a64aea31e3( 1 );
    level function_52badc8ddadcbbd6();
}

// Namespace zm_sat_scarab_phone
// Params 1, eflags: 0xc
// Checksum 0x41645a5a, Offset: 0xde3
// Size: 0xab
function private on_round_end( sparams )
{
    self notify( #"hash_73556d88b8a8e44b" );
    self endon( #"hash_73556d88b8a8e44b" );
    n_round_ended = sparams.roundnumber ?? zm_utility::get_round_number();
    var_926826280888e3a7 = n_round_ended + 1;
    
    if ( !function_3e30880ab508e27e( sparams ) )
    {
        return;
    }
    
    wait 3.5;
    
    if ( !function_3e30880ab508e27e( sparams ) )
    {
        return;
    }
    
    if ( !level.var_b68b1e1ce895ade )
    {
        if ( var_926826280888e3a7 < 3 )
        {
            utility::flag_wait( "round_1_vo_done" );
        }
        else
        {
            utility::flag_wait( "round_2_vo_done" );
        }
    }
    
    level thread on_round_end_phone_ring();
}

// Namespace zm_sat_scarab_phone
// Params 1, eflags: 0x4
// Checksum 0xb2d4a2b3, Offset: 0xe96
// Size: 0xe6, Type: bool
function private function_3e30880ab508e27e( sparams )
{
    n_round_ended = sparams.roundnumber ?? zm_utility::get_round_number();
    var_926826280888e3a7 = n_round_ended + 1;
    
    if ( level.scarab_phone.var_44a91d6a5c9357f8 || level.scarab_phone utility::ent_flag( "is_opening_portal_sequence" ) )
    {
        return false;
    }
    
    if ( var_926826280888e3a7 < 3 )
    {
        return false;
    }
    
    if ( var_926826280888e3a7 == 3 && !sparams.var_e7c2c09903c13bf7 )
    {
        return false;
    }
    
    if ( level.var_255753bd26bf0bdd )
    {
        return false;
    }
    
    if ( level.var_71af9b4e3751cbbf )
    {
        return false;
    }
    
    if ( level utility::callsharedfunc( #"zm_quest", #"hash_9b839bc2ba7777ff" ) )
    {
        return false;
    }
    
    var_66565a6231a1994a = zm_sat_scarab_rb::function_41160421ad0382b();
    
    if ( var_66565a6231a1994a.size < 1 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0xd953f04b, Offset: 0xf85
// Size: 0x81
function on_round_end_phone_ring()
{
    level thread function_a92efbbd3982daf4( #"survive", undefined, #"hash_67cf8608037190df", 2 );
    level phone_ring_thread();
    
    if ( !level.scarab_phone.var_b249c3f5faace516 && !level.scarab_phone.var_44a91d6a5c9357f8 && !level.var_71af9b4e3751cbbf )
    {
        level thread function_a92efbbd3982daf4( #"hash_67cf8608037190df", undefined, #"survive", 2 );
    }
}

// Namespace zm_sat_scarab_phone
// Params 1, eflags: 0x4
// Checksum 0x111d3ec9, Offset: 0x100e
// Size: 0x117
function private phone_ring_thread( var_258b9d1887ab385b )
{
    level endon( #"phone_answered", #"phone_portal_initialized", #"phone_ring_end" );
    
    if ( level utility::flag( "phone_ring_end" ) )
    {
        return;
    }
    
    level.var_255753bd26bf0bdd = 1;
    logstring( "Scarab Safehouse Phone: Phone is ringing at " + gettime() );
    
    /#
        iprintlnbold( "<dev string:x24>" + gettime() );
    #/
    
    ringtime = 15;
    
    if ( !level.scarab_phone.var_98ef83a2556a73e7 )
    {
        ringtime = 30;
    }
    
    var_d8aaf42cd12a101 = ringtime / 5;
    level.scarab_phone.var_98ef83a2556a73e7 = 1;
    
    for ( i = 0; i < var_d8aaf42cd12a101 ; i++ )
    {
        playsoundatpos( level.scarab_phone.origin, "evt_zm_phonebooth_ring_far" );
        wait 5;
    }
    
    level.var_255753bd26bf0bdd = 0;
    logstring( "Scarab Safehouse Phone: Phone stopped ringing at " + gettime() );
    
    /#
        iprintlnbold( "<dev string:x51>" + gettime() );
    #/
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0xc1166217, Offset: 0x112d
// Size: 0x33
function function_8d579bd589a6afea()
{
    level endon( #"phone_answered" );
    level.var_b68b1e1ce895ade = 1;
    
    while ( !level.var_255753bd26bf0bdd )
    {
        level phone_ring_thread( 1 );
    }
}

// Namespace zm_sat_scarab_phone
// Params 1, eflags: 0x4
// Checksum 0xd8c63ba0, Offset: 0x1168
// Size: 0x184
function private function_d879c005a663e484( player )
{
    /#
        player iprintlnbold( "<dev string:x83>" );
    #/
    
    if ( level.scarab_phone.var_44a91d6a5c9357f8 )
    {
        logstring( "Scarab Safehouse Phone: Phone is currently being answered" );
        
        /#
            player iprintlnbold( "<dev string:x8e>" );
        #/
        
        return;
    }
    
    if ( !level.var_255753bd26bf0bdd )
    {
        logstring( "Scarab Safehouse Phone: Phone isn't ringing" );
        
        /#
            player iprintlnbold( "<dev string:xc8>" );
        #/
        
        return;
    }
    
    if ( zm_utility::get_round_number() < 3 && !level.var_b68b1e1ce895ade )
    {
        logstring( "Scarab Safehouse Phone: Current round is too early to activate the phone" );
        
        /#
            player iprintlnbold( "<dev string:xf4>" );
        #/
        
        return;
    }
    
    if ( player.mask_ee && player.mask_ee.var_536177437db76a1f && player.mask_ee.var_536177437db76a1f.third_person )
    {
        player.mask_ee.var_536177437db76a1f hide();
        player.mask_ee.var_536177437db76a1f hidefromplayer( player );
        player.var_242c89ca96990d82 = 1;
    }
    
    self.var_4fbe82bc1129cd0e stoploopsound( "evt_phone_ring" );
    level.scarab_phone.var_44a91d6a5c9357f8 = 1;
    player function_28be90b6a188a2e0( self.var_4fbe82bc1129cd0e );
    level.scarab_phone.var_44a91d6a5c9357f8 = 0;
}

// Namespace zm_sat_scarab_phone
// Params 2, eflags: 0x4
// Checksum 0x80f723fc, Offset: 0x12f4
// Size: 0x88
function private function_ab30f2d192df9206( usable, player )
{
    if ( player.interactions_disabled || !level.var_255753bd26bf0bdd )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"hash_2e1c3fa4821028e9", #type:"HINT_BUTTON" };
}

// Namespace zm_sat_scarab_phone
// Params 1
// Checksum 0x72a3768c, Offset: 0x1385
// Size: 0x26b
function function_28be90b6a188a2e0( phone )
{
    level endon( #"game_ended" );
    level notify( #"phone_answered" );
    level.var_255753bd26bf0bdd = 0;
    logstring( "Scarab Safehouse Phone: Phone stopped ringing at " + gettime() );
    
    /#
        iprintlnbold( "<dev string:x51>" + gettime() );
    #/
    
    val::set( "answered_scarab_phone", "ignoreme", 1 );
    val::set_array( "answered_scarab_phone", [ "allow_ping", "show_hud_names", "allow_equipment_wheel" ], 0 );
    val::set( "answered_scarab_phone", "lerp_fov_scale", [ 0, 0.25 ] );
    self setstance( "stand", 1, 1 );
    
    if ( !level utility::flag( "safehouse_exterior_door_bought" ) )
    {
        level musicbank_utility::function_683e33ddcb824d18( #"round_start" );
        level musicbank_utility::function_683e33ddcb824d18( #"round_end" );
        level utility::delaythread( 10, &musicbank_utility::function_e146ca500a84f52f, #"round_start" );
        level utility::delaythread( 10, &musicbank_utility::function_e146ca500a84f52f, #"round_end" );
        musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_2dd6c63a1e1a7bc5" );
    }
    
    level thread function_92c12a64aea31e3();
    level player_banter::function_4682263196c4e001();
    level overlord::function_f2fedd3be0be82ef();
    waitframe();
    scene::add_scene_func( "sat_scene_scarab_answer_call_zm", &function_84a798b6b2458582, "callback_play" );
    phone.scene_root scene::play( self, "enter", "sat_scene_scarab_answer_call_zm" );
    level thread zm_quest::function_d5ef98341fd6a057( [ "scarab_pap_a_p" ], level.players, undefined, 1 );
    
    if ( isdefined( self ) )
    {
        thread utility::delay_notify( 7.63, "phone_done" );
        phone.scene_root thread scene::play( self, "loop", "sat_scene_scarab_answer_call_zm" );
        utility::waittill_any( "phone_done", "death_or_disconnect" );
    }
    
    phone.scene_root scene::play( self, "exit", "sat_scene_scarab_answer_call_zm" );
    
    if ( isdefined( self ) )
    {
        self.var_242c89ca96990d82 = undefined;
        utility::delaythread( 2, &val::reset, "answered_scarab_phone", "ignoreme" );
        val::reset( "answered_scarab_phone", "lerp_fov_scale" );
        val::reset( "answered_scarab_phone", "allow_ping" );
        val::reset( "answered_scarab_phone", "show_hud_names" );
        val::reset( "answered_scarab_phone", "allow_equipment_wheel" );
    }
}

// Namespace zm_sat_scarab_phone
// Params 1
// Checksum 0x92387dda, Offset: 0x15f8
// Size: 0x2d9
function function_92c12a64aea31e3( var_1b1d0287f11f4d15 )
{
    level endon( #"game_ended" );
    var_525d18e32e9e0adb = getentarray( "doorbuy_door_18", "targetname" );
    front_door = getent( "doorbuy_door_18", "target2" );
    
    if ( var_1b1d0287f11f4d15 )
    {
        level utility::array_thread( var_525d18e32e9e0adb, &doorbuy::function_f3160e450543b4f1 );
        earthquake( 0.5, 2, front_door.origin, 3000 );
        playrumbleonposition( "zm_cannon_rumble", front_door.origin );
        function_a73a959c613427b3();
        return;
    }
    
    if ( level.scarab_phone utility::ent_flag( "is_spirit_opening_door" ) )
    {
        return;
    }
    
    level.scarab_phone utility::ent_flag_set( "is_spirit_opening_door" );
    level.scarab_phone utility::ent_flag_set( "is_opening_portal_sequence" );
    level thread function_a92efbbd3982daf4( #"survive" );
    level thread function_a92efbbd3982daf4( #"hash_67cf8608037190df" );
    var_ab099f4e13d362e5 = level.scarab_phone.spirit_path_array[ 0 ];
    level.scarab_phone.var_4c36c3f356f0a64f = utility::spawn_model( "tag_origin", var_ab099f4e13d362e5, ( 0, 0, 0 ) );
    playfxontag( utility::getfx( "phone_spirit" ), level.scarab_phone.var_4c36c3f356f0a64f, "tag_origin" );
    level thread function_4deb1d2ff2005921();
    var_3bd7aced70cf9167 = level.scarab_phone.spirit_path_array[ 7 ];
    
    do
    {
        if ( !level utility::flag( "safehouse_exterior_door_bought" ) && distancesquared( level.scarab_phone.var_4c36c3f356f0a64f.origin, var_3bd7aced70cf9167 ) <= squared( 8 ) )
        {
            level utility::array_thread( var_525d18e32e9e0adb, &doorbuy::function_f3160e450543b4f1 );
            
            if ( front_door )
            {
                earthquake( 0.5, 2, front_door.origin, 3000 );
                playrumbleonposition( "zm_cannon_rumble", front_door.origin );
                playsoundatpos( front_door.origin, #"hash_5f8efcb4d3facfc" );
            }
        }
        
        waitframe();
    }
    while ( !level.scarab_phone.var_4c36c3f356f0a64f utility::ent_flag( "is_spline_finished" ) );
    
    level.scarab_phone.var_4c36c3f356f0a64f bobbing( ( 0, 0, 1 ), 12, 1.25 );
    wait 2.75;
    level.scarab_phone.var_4c36c3f356f0a64f delete();
    level.scarab_phone utility::ent_flag_clear( "is_spirit_opening_door" );
    function_a73a959c613427b3();
    level.var_a4dcfacd7ce9e0f5 = 1;
    level.scarab_phone utility::ent_flag_clear( "is_opening_portal_sequence" );
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0x75a1287a, Offset: 0x18d9
// Size: 0x94
function function_4deb1d2ff2005921()
{
    level endon( #"open_sesame" );
    level.scarab_phone.var_4c36c3f356f0a64f endon( #"death" );
    splinetime = 7;
    level.scarab_phone.var_4c36c3f356f0a64f utility::function_2159dd4196ff4b81( level.scarab_phone.spirit_path_array, splinetime, 1, 1, 0, 1, 0.5 );
    level.scarab_phone.var_4c36c3f356f0a64f utility::ent_flag_set( "is_spline_finished" );
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0x93fe9efe, Offset: 0x1975
// Size: 0xb8
function function_a73a959c613427b3()
{
    if ( !level.scarab_phone.var_b249c3f5faace516 && !level utility::flag( "phone_portal_initialized" ) )
    {
        portals::portals_init();
        level notify( #"phone_portal_initialized" );
        level utility::flag_set( "phone_portal_initialized" );
        level zm_quest::function_4eefe6de31f5ddab( #"scarab_phone_quest", #"hash_9c0ac2a3b56a997d", 1 );
    }
    
    function_857b200df7e6b159();
    
    if ( !level.scarab_phone.var_b249c3f5faace516 )
    {
        wait 2.5;
        level thread function_a92efbbd3982daf4( #"survive" );
        level thread function_a92efbbd3982daf4( #"hash_67cf8608037190df", undefined, #"escape", 2 );
    }
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0x70bd220d, Offset: 0x1a35
// Size: 0x17
function private function_e163da40515b7cda()
{
    wait 3;
    
    if ( isplayer( self ) )
    {
        self.b_ignore_playable_area_check = undefined;
    }
}

// Namespace zm_sat_scarab_phone
// Params 1
// Checksum 0x27c06ab9, Offset: 0x1a54
// Size: 0x45f
function function_4dbccf80de5ac9( var_fd3a9f9e9a2a06c2 )
{
    var_fd3a9f9e9a2a06c2 endon( #"death" );
    
    if ( !isplayer( var_fd3a9f9e9a2a06c2 ) )
    {
        return;
    }
    
    e_player = var_fd3a9f9e9a2a06c2;
    
    if ( !isalive( e_player ) )
    {
        return;
    }
    
    if ( e_player.portal_disabled )
    {
        return;
    }
    
    if ( !level.var_71af9b4e3751cbbf )
    {
        return;
    }
    
    var_fd3a9f9e9a2a06c2.b_ignore_playable_area_check = 1;
    var_fd3a9f9e9a2a06c2 thread function_e163da40515b7cda();
    var_fd3a9f9e9a2a06c2 endon( #"death_or_disconnect" );
    player_position = var_fd3a9f9e9a2a06c2 getorigin();
    player_angle = var_fd3a9f9e9a2a06c2 getplayerangles();
    player_forward = anglestoforward( player_angle );
    var_f969f0d8df1cfda5 = anglestoup( player_angle );
    playfx( level._effect[ "teleport_3p" ], player_position, player_forward, var_f969f0d8df1cfda5 );
    trigger = self;
    var_229de8f72718880b = function_7f3b987936c7714f( e_player getplayerangles(), trigger );
    var_8c04fa0af1c9355c = function_4ef03da65b0ecbfc( e_player getvelocity(), trigger );
    
    if ( trigger.var_3a87370b07a6c406 === ( 1, 1, 1 ) )
    {
        var_363abe40bb74d86 = var_fd3a9f9e9a2a06c2.origin + trigger.var_843c6c39b36a7fa6.var_d989bdd2f7142386 - trigger.var_d989bdd2f7142386;
    }
    else
    {
        var_e30d6120c156005c = var_fd3a9f9e9a2a06c2.origin - trigger.var_d989bdd2f7142386;
        var_e30d6120c156005c = utility::function_6b6c127afa12d17( ( 0, 0, 0 ), var_e30d6120c156005c, trigger.angles * -1 );
        var_e30d6120c156005c = ( clamp( var_e30d6120c156005c[ 0 ], trigger.var_98b525faf6361e54[ 0 ] * -1, trigger.var_98b525faf6361e54[ 0 ] ), clamp( var_e30d6120c156005c[ 1 ], trigger.var_98b525faf6361e54[ 1 ] * -1, trigger.var_98b525faf6361e54[ 1 ] ), clamp( var_e30d6120c156005c[ 2 ], trigger.var_98b525faf6361e54[ 2 ] * -1, trigger.var_98b525faf6361e54[ 2 ] ) );
        var_d0578d07d14a547 = var_e30d6120c156005c * trigger.var_3a87370b07a6c406;
        var_d0578d07d14a547 = utility::function_6b6c127afa12d17( ( 0, 0, 0 ), var_d0578d07d14a547, trigger.angles );
        var_363abe40bb74d86 = trigger.var_843c6c39b36a7fa6.var_d989bdd2f7142386 + var_d0578d07d14a547;
    }
    
    var_363abe40bb74d86 = utility::function_6b6c127afa12d17( trigger.var_843c6c39b36a7fa6.var_d989bdd2f7142386, var_363abe40bb74d86, trigger.var_7568471ee00ffbec );
    e_player dontinterpolate();
    e_player setorigin( var_363abe40bb74d86 );
    e_player setplayerangles( var_229de8f72718880b );
    e_player setvelocity( var_8c04fa0af1c9355c );
    var_a99e9591d3290aa3 = e_player function_45d2d1c66809e8b9();
    e_player function_fe1d70a07d74725( var_a99e9591d3290aa3 + trigger.var_7568471ee00ffbec[ 1 ] );
    e_player utility::function_7c10ea82c1e305b8( "playerTeleport", "scarabOn" );
    e_player function_3f0aea77323b200a();
    
    if ( isdefined( trigger.var_68cbf87d1d84490b ) )
    {
        trigger.var_68cbf87d1d84490b utility::function_7c10ea82c1e305b8( "portal_anim", "trigger_player" );
    }
    
    if ( isdefined( trigger.var_843c6c39b36a7fa6.var_68cbf87d1d84490b ) )
    {
        trigger.var_843c6c39b36a7fa6.var_68cbf87d1d84490b utility::function_7c10ea82c1e305b8( "portal_anim", "trigger_player" );
    }
    
    level thread function_fd6b8fc65fe0a410();
    
    if ( !level.scarab_phone.var_b249c3f5faace516 || level.scarab_phone.var_12c3e41f78d1cce2 )
    {
        var_12c3e41f78d1cce2 = level.scarab_phone.var_12c3e41f78d1cce2;
        
        if ( level.scarab_phone.var_12c3e41f78d1cce2 )
        {
            level.scarab_phone.var_12c3e41f78d1cce2 = 0;
        }
        
        level thread function_52badc8ddadcbbd6( var_12c3e41f78d1cce2 );
    }
    
    if ( e_player.had_grapple )
    {
        e_player.had_grapple = undefined;
        e_player equipment_mp::giveequipment( e_player.grapple_ref, "secondary" );
    }
    
    player_position = var_fd3a9f9e9a2a06c2 getorigin();
    player_angle = var_fd3a9f9e9a2a06c2 getplayerangles();
    player_forward = anglestoforward( player_angle );
    var_f969f0d8df1cfda5 = anglestoup( player_angle );
    playfx( level._effect[ "teleport_3p" ], player_position, player_forward, var_f969f0d8df1cfda5 );
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0x4bd79bf5, Offset: 0x1ebb
// Size: 0x2f
function private function_fd6b8fc65fe0a410()
{
    wait 1;
    var_66565a6231a1994a = zm_sat_scarab_rb::function_41160421ad0382b();
    
    if ( var_66565a6231a1994a.size < 1 )
    {
        function_e31fd04f8a18de90();
        level thread function_75f1473b5491e1db();
    }
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0x2069a084, Offset: 0x1ef2
// Size: 0x6f
function private function_75f1473b5491e1db()
{
    level endon( #"phone_portal_enabled", #"hash_462c836468431b7b" );
    var_98518238e7ad3c9c = gettime();
    
    while ( !utility::time_has_passed( var_98518238e7ad3c9c, 30 ) )
    {
        var_66565a6231a1994a = zm_sat_scarab_rb::function_41160421ad0382b();
        
        if ( var_66565a6231a1994a.size > 0 && !level utility::flag( "rh_trial_active" ) )
        {
            level thread function_857b200df7e6b159();
            break;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0x48f0b9ce, Offset: 0x1f69
// Size: 0x8d
function private function_84a798b6b2458582()
{
    var_79a1b4c592a0d24d = scene::function_5fe163f439457bd0();
    
    foreach ( player in var_79a1b4c592a0d24d )
    {
        if ( isplayer( player ) )
        {
            player thread function_3f0aea77323b200a();
        }
    }
}

// Namespace zm_sat_scarab_phone
// Params 0, eflags: 0x4
// Checksum 0xe904293a, Offset: 0x1ffe
// Size: 0x5f
function private function_3f0aea77323b200a()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( level utility::flag( "its_raining" ) )
    {
        if ( level utility::issharedfuncdefined( #"scarab_rain", #"hash_bd3ce90cea3f86b5" ) )
        {
            utility::callsharedfunc( #"scarab_rain", #"hash_bd3ce90cea3f86b5" );
        }
    }
}

// Namespace zm_sat_scarab_phone
// Params 2, eflags: 0x4
// Checksum 0x8b12260e, Offset: 0x2065
// Size: 0xd7
function private function_7f3b987936c7714f( initialangles, trigger )
{
    if ( trigger.var_843c6c39b36a7fa6.b_match_portal_forward )
    {
        var_61fbd8cc0d14a973 = trigger.var_843c6c39b36a7fa6.angles;
        
        if ( !trigger.var_843c6c39b36a7fa6.b_backwards )
        {
            var_61fbd8cc0d14a973 += ( 0, 180, 0 );
        }
        
        return ( initialangles[ 0 ], var_61fbd8cc0d14a973[ 1 ], initialangles[ 2 ] );
    }
    
    if ( isdefined( trigger.var_843c6c39b36a7fa6.script_rotation_amount ) )
    {
        return trigger.var_843c6c39b36a7fa6.script_rotation_amount;
    }
    
    return ( initialangles[ 0 ], initialangles[ 1 ] + trigger.var_7568471ee00ffbec[ 1 ], initialangles[ 2 ] );
}

// Namespace zm_sat_scarab_phone
// Params 2, eflags: 0x4
// Checksum 0x3df3230c, Offset: 0x2144
// Size: 0xd3
function private function_4ef03da65b0ecbfc( var_1ac5aa9d55bd6513, trigger )
{
    if ( trigger.var_843c6c39b36a7fa6.b_match_portal_forward )
    {
        var_d1f605a42e48e93b = anglestoforward( trigger.var_843c6c39b36a7fa6.angles );
        
        if ( !trigger.var_843c6c39b36a7fa6.b_backwards )
        {
            var_d1f605a42e48e93b *= -1;
        }
        
        var_76d9d358545ef74 = length( var_1ac5aa9d55bd6513 ) * var_d1f605a42e48e93b;
    }
    else
    {
        var_76d9d358545ef74 = function_60a30c7aa21c4587( var_1ac5aa9d55bd6513, trigger.angles, trigger.var_843c6c39b36a7fa6.angles );
    }
    
    var_76d9d358545ef74 *= trigger.var_843c6c39b36a7fa6.var_24fc9c98b7363929 ?? 1;
    return var_76d9d358545ef74;
}

// Namespace zm_sat_scarab_phone
// Params 3, eflags: 0x4
// Checksum 0x52a41083, Offset: 0x2220
// Size: 0x61
function private function_60a30c7aa21c4587( var_4cf6bb3de7021811, var_1e74cadce9bae5ba, var_ec285c40cae2723 )
{
    var_a5fea4b5b174628 = utility::function_136bd9aeb8121a6b( var_4cf6bb3de7021811, var_1e74cadce9bae5ba );
    var_5da0e93623194c38 = anglestoright( var_ec285c40cae2723 ) * var_a5fea4b5b174628[ 0 ] + anglestoup( var_ec285c40cae2723 ) * var_a5fea4b5b174628[ 1 ] + anglestoforward( var_ec285c40cae2723 ) * var_a5fea4b5b174628[ 2 ];
    return var_5da0e93623194c38;
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0xf4986ab5, Offset: 0x228a
// Size: 0x16e
function function_857b200df7e6b159()
{
    if ( level.var_71af9b4e3751cbbf )
    {
        return;
    }
    
    level notify( #"phone_portal_enabled" );
    portal_state = level utility::flag( "power_on" ) ? "on_forge_active" : "on";
    
    if ( level.scarab_phone_portal_brush )
    {
        level.scarab_phone_portal_brush show();
        level.scarab_phone_portal_brush notsolid();
        
        if ( level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362.var_68cbf87d1d84490b )
        {
            level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362.var_68cbf87d1d84490b setscriptablepartstate( "base", portal_state );
        }
    }
    
    level.var_71af9b4e3751cbbf = 1;
    
    foreach ( player in level.players )
    {
        if ( !player )
        {
            return;
        }
        
        player.portal_disabled = undefined;
        
        if ( ispointinvolume( player.origin, level.scarab_phone_portal_brush, 1 ) )
        {
            level.scarab_phone_portal_brush function_4dbccf80de5ac9( player );
        }
    }
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0xf6a84644, Offset: 0x2400
// Size: 0x10a
function function_e31fd04f8a18de90()
{
    if ( !level.var_71af9b4e3751cbbf )
    {
        return;
    }
    
    level notify( #"hash_462c836468431b7b" );
    
    if ( level.scarab_phone_portal_brush )
    {
        level.scarab_phone_portal_brush hide();
        
        if ( level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362.var_68cbf87d1d84490b )
        {
            level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362.var_68cbf87d1d84490b setscriptablepartstate( "base", "off" );
        }
    }
    
    level.var_71af9b4e3751cbbf = 0;
    
    foreach ( player in level.players )
    {
        player.portal_disabled = 1;
    }
}

// Namespace zm_sat_scarab_phone
// Params 1, eflags: 0x4
// Checksum 0x2edf72b2, Offset: 0x2512
// Size: 0xdf
function private function_52badc8ddadcbbd6( var_12c3e41f78d1cce2 = 0 )
{
    if ( level.scarab_phone.is_completing_guidance )
    {
        return;
    }
    
    level thread function_a92efbbd3982daf4( undefined, undefined, undefined, undefined, var_12c3e41f78d1cce2 );
    level.scarab_phone.is_completing_guidance = 1;
    level.scarab_phone.var_b249c3f5faace516 = 1;
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_phone_quest", #"hash_9c0ac2a3b56a997d", 1 );
    
    if ( !level utility::flag( "power_on" ) && !level utility::flag( "open_sesame" ) )
    {
        wait 2;
        level zm_quest::get_quest( #"scarab_pap_quest" ).var_94c5b7d04e0c2501 = 0;
        level thread zm_sat_scarab_pap_quest::function_51f12524c830dd09();
        level.scarab_phone.var_aa3febe5f666b58f = 1;
    }
}

// Namespace zm_sat_scarab_phone
// Params 5, eflags: 0xc
// Checksum 0xb233909f, Offset: 0x25f9
// Size: 0x2ee
function private function_a92efbbd3982daf4( var_ebc34e9ccd213e2f, var_750cf763a0a272 = 0, var_6db23e09279394a1, var_318b62725988b864 = 2, forceupdate = 0 )
{
    self notify( #"hash_320335a326b62d31" );
    self endon( #"hash_320335a326b62d31" );
    
    if ( level.scarab_phone.var_b249c3f5faace516 && !forceupdate )
    {
        return;
    }
    
    if ( var_ebc34e9ccd213e2f )
    {
        level zm_quest::function_fb3af5600f6a9441( var_750cf763a0a272, 1, #"scarab_phone_quest", var_ebc34e9ccd213e2f );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"scarab_phone_quest", var_ebc34e9ccd213e2f );
        
        if ( ( var_ebc34e9ccd213e2f == #"hash_67cf8608037190df" || var_ebc34e9ccd213e2f == #"escape" ) && level.scarab_phone.objectiveid )
        {
            level zm_quest::complete_objective_waypoints( level.scarab_phone.objectiveid );
            level.scarab_phone.objectiveid = undefined;
        }
    }
    
    if ( var_6db23e09279394a1 )
    {
        level zm_quest::function_fba942a1cfd85f5d( 1, 1, #"scarab_phone_quest", var_6db23e09279394a1 );
        level zm_quest::function_fb3af5600f6a9441( var_318b62725988b864, 1, #"scarab_phone_quest", var_6db23e09279394a1 );
        
        if ( var_6db23e09279394a1 == #"hash_67cf8608037190df" )
        {
            level.scarab_phone.objectiveid = zm_quest::function_dc297429579c6e7f( "phone_ringing", 1, "ui_icon_zm_objective", "icon_small_medium", "current", level.scarab_phone, 24, &"hash_2e1c3fa4821028e9", undefined, 0, 1 );
        }
        else if ( var_6db23e09279394a1 == #"escape" )
        {
            portal_pos = level.scarab_phone_portal_brush.var_b7b7f0c65bcf1362.origin;
            level.scarab_phone.objectiveid = zm_quest::function_b98d4144845ffc13( "enter_portal", 1, "ui_icon_zm_objective", "icon_small_medium", "current", portal_pos, 64, &"hash_6a2253c2d173d812", undefined, 0, 1 );
        }
    }
    
    if ( !var_ebc34e9ccd213e2f && !var_6db23e09279394a1 )
    {
        level zm_quest::function_fb3af5600f6a9441( 4, 1, #"scarab_phone_quest", #"escape" );
        
        if ( level.scarab_phone.objectiveid )
        {
            level zm_quest::complete_objective_waypoints( level.scarab_phone.objectiveid );
            level.scarab_phone.objectiveid = undefined;
        }
        
        waitframe();
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"scarab_phone_quest", #"survive" );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"scarab_phone_quest", #"hash_67cf8608037190df" );
        level zm_quest::function_fba942a1cfd85f5d( 0, 1, #"scarab_phone_quest", #"escape" );
        level notify( #"hash_76ba2c056d00a314" );
    }
}

// Namespace zm_sat_scarab_phone
// Params 1
// Checksum 0xb9a81d55, Offset: 0x28ef
// Size: 0x143
function function_4cb5b7295a7621a3( var_fb51301c9d3c7255 = 0 )
{
    var_66565a6231a1994a = zm_sat_scarab_rb::function_41160421ad0382b();
    
    if ( var_66565a6231a1994a.size < 1 )
    {
        function_e31fd04f8a18de90();
        return;
    }
    
    if ( !level.scarab_phone.var_b249c3f5faace516 )
    {
        var_525d18e32e9e0adb = getentarray( "doorbuy_door_18", "targetname" );
        
        foreach ( front_door in var_525d18e32e9e0adb )
        {
            front_door thread doorbuy::function_f3160e450543b4f1();
        }
        
        front_door = getent( "doorbuy_door_18", "target2" );
        
        if ( !level utility::flag( "open_sesame" ) && front_door )
        {
            earthquake( 0.5, 2, front_door.origin, 3000 );
            playrumbleonposition( "zm_cannon_rumble", front_door.origin );
        }
        
        level function_a73a959c613427b3();
        
        if ( !var_fb51301c9d3c7255 )
        {
            level thread function_52badc8ddadcbbd6();
        }
    }
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0xacb78817, Offset: 0x2a3a
// Size: 0x198
function function_dc160a480e12c05b()
{
    level utility::flag_wait( "begin_round_logic" );
    level utility::flag_wait_any( "scarab_boss_fight_complete", "rh_sees_complete", "rh_tb_return" );
    level.var_a85e35e531222e69 = getent( "scarab_safehouse_portal_forward", #targetname );
    
    foreach ( player in level.players )
    {
        var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
        player.sc_portalfx = spawnscriptable( %"zm_sat_scarab_mq_shadowsmith_spawn", level.var_a85e35e531222e69.origin + ( 0, 0, -32 ), level.var_a85e35e531222e69.angles + ( 0, 180, 0 ), undefined, var_7c170ceae0649b57 );
    }
    
    level.var_a85e35e531222e69.var_670c0bc02418cdc3 = &function_a96f8c4ab3162560;
    level.var_a85e35e531222e69.portal_disabled = 1;
    
    while ( true )
    {
        level utility::flag_wait( "exfil_window_active" );
        function_c41dbdae8abb944f();
        level utility::flag_waitopen( "exfil_window_active" );
        level thread function_fd6b8fc65fe0a410();
        function_eab0e6f353b5be68();
    }
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0xcd7bc120, Offset: 0x2bda
// Size: 0x2bf
function function_c41dbdae8abb944f()
{
    level.var_a85e35e531222e69.portal_disabled = 0;
    
    if ( level utility::flag( "rh_tb_return" ) && !level utility::flag( "scarab_boss_fight_complete" ) && !level utility::flag( "rh_sees_complete" ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && isalive( player ) )
            {
                if ( player.var_a10da01c9aea8bf2 )
                {
                    player.var_81b5624950f93a39 = undefined;
                    player.sc_portalfx setscriptablepartstate( "visual", "on_safehouse" );
                    continue;
                }
                
                player.var_81b5624950f93a39 = 1;
            }
        }
        
        return;
    }
    
    if ( level utility::flag( "rh_tb_return" ) && level utility::flag( "rh_sees_complete" ) )
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && isalive( player ) )
            {
                if ( player.var_a10da01c9aea8bf2 )
                {
                    player.var_81b5624950f93a39 = undefined;
                    player.sc_portalfx setscriptablepartstate( "visual", "on_safehouse" );
                    continue;
                }
                
                if ( !player utility::ent_flag( "rh_toy_placed" ) )
                {
                    player.var_81b5624950f93a39 = undefined;
                    player.sc_portalfx setscriptablepartstate( "visual", "on_safehouse" );
                    continue;
                }
                
                player.var_81b5624950f93a39 = 1;
            }
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && isalive( player ) )
        {
            player.var_81b5624950f93a39 = undefined;
            player.sc_portalfx setscriptablepartstate( "visual", "on_safehouse" );
        }
    }
}

// Namespace zm_sat_scarab_phone
// Params 0
// Checksum 0x75a8bc6d, Offset: 0x2ea1
// Size: 0xcd
function function_eab0e6f353b5be68()
{
    if ( isdefined( level.var_a85e35e531222e69 ) )
    {
        level.var_a85e35e531222e69.portal_disabled = 1;
    }
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && isdefined( player ) )
        {
            player.var_81b5624950f93a39 = 1;
            player.sc_portalfx setscriptablepartstate( "visual", "hidden" );
        }
    }
}

// Namespace zm_sat_scarab_phone
// Params 1
// Checksum 0xb66db8a9, Offset: 0x2f76
// Size: 0x3ed
function function_a96f8c4ab3162560( var_fd3a9f9e9a2a06c2 )
{
    var_fd3a9f9e9a2a06c2 endon( #"death" );
    
    if ( !isplayer( var_fd3a9f9e9a2a06c2 ) )
    {
        return;
    }
    
    e_player = var_fd3a9f9e9a2a06c2;
    
    if ( !isalive( e_player ) )
    {
        return;
    }
    
    if ( e_player.var_81b5624950f93a39 )
    {
        return;
    }
    
    if ( isdefined( level.s_zm_exfil.a_players_accepted ) && arraycontains( level.s_zm_exfil.a_players_accepted, e_player ) )
    {
        return;
    }
    
    var_fd3a9f9e9a2a06c2 endon( #"death_or_disconnect" );
    player_position = var_fd3a9f9e9a2a06c2 getorigin();
    player_angle = var_fd3a9f9e9a2a06c2 getplayerangles();
    player_forward = anglestoforward( player_angle );
    var_f969f0d8df1cfda5 = anglestoup( player_angle );
    playfx( level._effect[ "teleport_3p" ], player_position, player_forward, var_f969f0d8df1cfda5 );
    trigger = self;
    var_229de8f72718880b = function_7f3b987936c7714f( e_player getplayerangles(), trigger );
    var_8c04fa0af1c9355c = function_4ef03da65b0ecbfc( e_player getvelocity(), trigger );
    
    if ( trigger.var_3a87370b07a6c406 === ( 1, 1, 1 ) )
    {
        var_363abe40bb74d86 = var_fd3a9f9e9a2a06c2.origin + trigger.var_843c6c39b36a7fa6.var_d989bdd2f7142386 - trigger.var_d989bdd2f7142386;
    }
    else
    {
        var_e30d6120c156005c = var_fd3a9f9e9a2a06c2.origin - trigger.var_d989bdd2f7142386;
        var_e30d6120c156005c = utility::function_6b6c127afa12d17( ( 0, 0, 0 ), var_e30d6120c156005c, trigger.angles * -1 );
        var_e30d6120c156005c = ( clamp( var_e30d6120c156005c[ 0 ], trigger.var_98b525faf6361e54[ 0 ] * -1, trigger.var_98b525faf6361e54[ 0 ] ), clamp( var_e30d6120c156005c[ 1 ], trigger.var_98b525faf6361e54[ 1 ] * -1, trigger.var_98b525faf6361e54[ 1 ] ), clamp( var_e30d6120c156005c[ 2 ], trigger.var_98b525faf6361e54[ 2 ] * -1, trigger.var_98b525faf6361e54[ 2 ] ) );
        var_d0578d07d14a547 = var_e30d6120c156005c * trigger.var_3a87370b07a6c406;
        var_d0578d07d14a547 = utility::function_6b6c127afa12d17( ( 0, 0, 0 ), var_d0578d07d14a547, trigger.angles );
        var_363abe40bb74d86 = trigger.var_843c6c39b36a7fa6.var_d989bdd2f7142386 + var_d0578d07d14a547;
    }
    
    var_363abe40bb74d86 = utility::function_6b6c127afa12d17( trigger.var_843c6c39b36a7fa6.var_d989bdd2f7142386, var_363abe40bb74d86, trigger.var_7568471ee00ffbec );
    e_player setorigin( var_363abe40bb74d86 );
    e_player setplayerangles( var_229de8f72718880b );
    e_player setvelocity( var_8c04fa0af1c9355c );
    var_a99e9591d3290aa3 = e_player function_45d2d1c66809e8b9();
    e_player function_fe1d70a07d74725( var_a99e9591d3290aa3 + trigger.var_7568471ee00ffbec[ 1 ] );
    e_player utility::function_7c10ea82c1e305b8( "playerTeleport", "scarabOn" );
    
    if ( isdefined( trigger.var_68cbf87d1d84490b ) )
    {
        trigger.var_68cbf87d1d84490b utility::function_7c10ea82c1e305b8( "portal_anim", "trigger_player" );
    }
    
    if ( isdefined( trigger.var_843c6c39b36a7fa6.var_68cbf87d1d84490b ) )
    {
        trigger.var_843c6c39b36a7fa6.var_68cbf87d1d84490b utility::function_7c10ea82c1e305b8( "portal_anim", "trigger_player" );
    }
    
    e_player.var_81b5624950f93a39 = 1;
    e_player.sc_portalfx setscriptablepartstate( "visual", "hidden" );
    
    if ( function_598b7d6767c2ec28( e_player ) )
    {
        e_player equipment_mp::takeequipment( "secondary" );
    }
    
    player_position = var_fd3a9f9e9a2a06c2 getorigin();
    player_angle = var_fd3a9f9e9a2a06c2 getplayerangles();
    player_forward = anglestoforward( player_angle );
    var_f969f0d8df1cfda5 = anglestoup( player_angle );
    playfx( level._effect[ "teleport_3p" ], player_position, player_forward, var_f969f0d8df1cfda5 );
    function_857b200df7e6b159();
}

// Namespace zm_sat_scarab_phone
// Params 1, eflags: 0x4
// Checksum 0xec3cb7fe, Offset: 0x336b
// Size: 0x5b
function private function_598b7d6767c2ec28( player )
{
    var_24dc036a2bd9a4e0 = player equipment_mp::getcurrentequipment( "secondary" );
    
    if ( var_24dc036a2bd9a4e0 == "equip_grappling_hook" || var_24dc036a2bd9a4e0 == "equip_grappling_hook_upgraded" )
    {
        player.had_grapple = 1;
        player.grapple_ref = var_24dc036a2bd9a4e0;
        return 1;
    }
}

/#

    // Namespace zm_sat_scarab_phone
    // Params 0
    // Checksum 0x64ef4e18, Offset: 0x33ce
    // Size: 0x60, Type: dev
    function function_717f311c709ea2db()
    {
        level.players[ 0 ] setorigin( ( 184.964, -3716.1, 1746.45 ) );
        level.players[ 0 ] setplayerangles( ( 0, 7.73403, 0 ) );
        wait 1;
        level.players[ 0 ] function_28be90b6a188a2e0( level.scarab_phone );
    }

    // Namespace zm_sat_scarab_phone
    // Params 0
    // Checksum 0xb6c9e7fb, Offset: 0x3436
    // Size: 0xd, Type: dev
    function function_12396212f4e46ba()
    {
        level thread function_8d579bd589a6afea();
    }

    // Namespace zm_sat_scarab_phone
    // Params 0
    // Checksum 0x1173e599, Offset: 0x344b
    // Size: 0x5d, Type: dev
    function setup_scarab_phone_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x13d>" );
        devgui::add_devgui_func( "<dev string:x14e>", "<dev string:x15f>", &function_717f311c709ea2db, 0 );
        devgui::add_devgui_func( "<dev string:x170>", "<dev string:x17d>", &function_12396212f4e46ba, 0 );
        devgui::add_devgui_func( "<dev string:x18a>", "<dev string:x1a8>", &function_4cb5b7295a7621a3, 0 );
        devgui::function_77df7fe7dd273e10();
    }

#/
