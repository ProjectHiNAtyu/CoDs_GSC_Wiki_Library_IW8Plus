// scripts\mp\common_training_course.gsc  (hash_2778910d68a42532.gscc) (size: 50542 Bytes / 0xc56e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x674c3b6e (1733049198)
// size ...... 50542 (0xc56e)
// includes .. 26  (offset: 0xbb8e)
// strings ... 136 (offset: 0xbc5e)
// dev strs .. 32  (offset: 0xc3da)
// exports ... 172 (offset: 0x787e)
// cseg ...... 0xdbc + 0x6ac2 (0x787e)
// imports ... 319 (offset: 0x935e)
// animtree1 . 0   (offset: 0xc56e)
// animtree2 . 0   (offset: 0xc56e)
#using script_18c2f6d91cbc576a;
#using script_4f7cbc7a2a2ba890;
#using scripts\common\damage_effects;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\class;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\supers;
#using scripts\mp\teams;

#namespace common_training_course;

// Namespace common_training_course
// Params 0
// Checksum 0x8dfecf7, Offset: 0xdda
// Size: 0x48
function commontrainingcourse_init()
{
    level.registered_triggers = [];
    level.tutorial_dictionary = [];
    level.var_80e907d847fdb68c = [];
    level.var_c03063b5f4fc2dde = [];
    level.var_2e61ab2b37d9ba6f = [];
    level.world_target_array = [];
    level.var_bb4f4ac000751f63 = 0;
}

// Namespace common_training_course
// Params 1
// Checksum 0x9e482d18, Offset: 0xe2a
// Size: 0x6b
function onplayerconnect( player )
{
    player waittill( #"spawned" );
    
    if ( isbot( player ) )
    {
        return;
    }
    
    player.team = "allies";
    player.sessionteam = player.team;
    player.sessionstate = "playing";
    
    /#
        level.player = player;
    #/
}

// Namespace common_training_course
// Params 3
// Checksum 0x6dd83fe, Offset: 0xe9d
// Size: 0xe5
function function_2ead6d7add3d72( winner, endreasontext, nukedetonated )
{
    if ( isdefined( level.tutorial_dictionary ) )
    {
        var_4e0fc2dbd25cba8b = 1;
        
        foreach ( tutorial in level.tutorial_dictionary )
        {
            if ( !function_faefa119842f585b( tutorial ) )
            {
                var_4e0fc2dbd25cba8b = 0;
                break;
            }
        }
        
        if ( var_4e0fc2dbd25cba8b && isdefined( level.players[ 0 ] ) )
        {
            winner = level.players[ 0 ].team;
        }
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0x6a9b3f0, Offset: 0xf8a
// Size: 0x19e
function function_e6c0ed093a236b20( player, initial_wait_time, tutorial_dictionary )
{
    wait initial_wait_time;
    tutorial_array = [];
    
    foreach ( tutorial in tutorial_dictionary )
    {
        tutorial_array[ tutorial_array.size ] = tutorial;
    }
    
    var_889beba20932b29b = arraysort( tutorial_array, undefined, &function_c25960b107824fa7 );
    assert( var_889beba20932b29b.size <= 15, "<dev string:x24>" );
    var_1bee7348e8012def = int( ceil( var_889beba20932b29b.size / 6 ) );
    
    for ( i = 0; i < var_1bee7348e8012def ; i++ )
    {
        right_side = int( min( var_889beba20932b29b.size, 6 * ( i + 1 ) ) );
        left_side = 1 + 6 * i;
        sent_size = right_side - left_side + 1;
        packed_number = function_8b878dec24bedc0e( var_889beba20932b29b[ left_side - 1 ] );
        
        for ( j = left_side; j < right_side ; j++ )
        {
            packed_number = packed_number << 4 | function_8b878dec24bedc0e( var_889beba20932b29b[ j ] );
        }
        
        packed_number = packed_number << 4 | sent_size;
        
        if ( isdefined( player ) )
        {
            player setclientomnvar( "training_course_update_tutorial_list", packed_number );
        }
        
        wait 1.5;
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0x2467dce7, Offset: 0x1130
// Size: 0x2c, Type: bool
function function_c25960b107824fa7( leftelement, rightelement )
{
    return leftelement.order_number < rightelement.order_number;
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0xf44d388d, Offset: 0x1165
// Size: 0x64
function private function_529df1e6154411d0( v_spawn_position )
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) )
    {
        var_18989a0b903e5305 = spawnbot( v_spawn_position, ( 0, 0, 0 ) );
        var_18989a0b903e5305 playerhide();
        setplayerviewmodel( var_18989a0b903e5305 );
        level.var_18989a0b903e5305 = var_18989a0b903e5305;
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0xb1413423, Offset: 0x11d1
// Size: 0x203
function function_2cb67c7fc6e3fed5( player )
{
    player endon( #"death" );
    
    if ( isdefined( player.secondaryweaponobj ) && player.secondaryweaponobj.basename != "none" )
    {
        player takeweapon( player.secondaryweaponobj );
    }
    
    if ( isdefined( player.primaryweaponobj ) && player.primaryweaponobj.basename != "none" )
    {
        player takeweapon( player.primaryweaponobj );
    }
    
    player equipment_mp::giveequipment( "equip_frag", "primary" );
    player equipment_mp::giveequipment( "equip_smoke", "secondary" );
    
    if ( isdefined( level.current_tutorial.var_85a7b95bc3de3767 ) )
    {
        [[ level.current_tutorial.var_85a7b95bc3de3767 ]]( player, level.current_tutorial );
    }
    else
    {
        player equipment_mp::setequipmentslotammo( "primary", 0 );
        player equipment_mp::setequipmentslotammo( "secondary", 0 );
        player perkpackage::perkpackage_giveimmediate( "super_ammo_drop", undefined, undefined, undefined, 0 );
        player supers_mp::clearsuper();
        player equipment_mp::takeequipment( "super" );
    }
    
    player class::loadout_clearperks();
    waitframe();
    attachments = [ "t10_microreflex02_ar", "t10_ammo_556n", "t10_underbarrel_recoil_ar_coslo", "t10_grips_quickdraw_ar_coslo", "t10_selectsemi_coslo723", "t10_mags_extclip_ar_coslo", "t10_stock_ar_p01", "t10_bar_ar_p01", "t10_rec_coslo723" ];
    primary_weapon = weapon::buildweapon( "t10_ar_p01_coslo723_mp", attachments );
    player givemaxammo( primary_weapon );
    player setweaponammostock( primary_weapon, weaponmaxammo( primary_weapon ) );
    player giveweapon( primary_weapon );
    secondary_weapon = weapon::buildweapon( "t10_pi_p14_stiger_mp" );
    player giveweapon( secondary_weapon );
    player switchtoweapon( primary_weapon );
}

// Namespace common_training_course
// Params 3
// Checksum 0x2a5c093b, Offset: 0x13dc
// Size: 0xab
function setplayerviewmodel( player, operator = %"t10_usa_pl_marshall", operator_skin = %"hash_169c5f86858b7caa" )
{
    player clearcustomization( 1 );
    models = operator::function_fb2ad6ca3c6b708d( operator_skin );
    player setoperatorcustomization( operator, operator_skin );
    player teams::setcharactermodels( models[ 0 ], models[ 1 ], models[ 2 ] );
    player.operatorcustomization.body = models[ 0 ];
    player.operatorcustomization.head = models[ 1 ];
}

// Namespace common_training_course
// Params 1
// Checksum 0xa9b89f3b, Offset: 0x148f
// Size: 0x80
function function_aa4c8736e7957afd( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player waittill( #"reload_ammo_added" );
    weapon = player.currentprimaryweapon;
    player givemaxammo( weapon );
    player setweaponammostock( weapon, weaponmaxammo( weapon ) );
}

// Namespace common_training_course
// Params 1
// Checksum 0xf209ef7e, Offset: 0x1517
// Size: 0xa2
function function_26b6c2dd56a45ccf( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player waittill( #"reload_ammo_added" );
    weapon = player.currentprimaryweapon;
    maxammo = weaponmaxammo( weapon );
    
    if ( player getweaponammostock( weapon ) > maxammo / 2 )
    {
        return 0;
    }
    
    player givemaxammo( weapon );
    player setweaponammostock( weapon, weaponmaxammo( weapon ) );
}

// Namespace common_training_course
// Params 25
// Checksum 0x437a8845, Offset: 0x15c1
// Size: 0x4a6
function createtutorial( id_string, var_81173965ad64569, tutorial_type, var_96e5beb113f41311, onsetup, oncleanup, onfail, onexit, startlogic, var_3dcac807aca26fce, var_fe1e173811f47789, var_47f8fc3de4a91658, respawn_position, respawn_angles, var_b8abd6e1783d0f45, var_daae47f54aee1cc3, respawn_delay, init_trigger_position, transition_fade_in_time, transition_fade_out_time, var_11b386f1f1fd262a, var_c7da30c496405c56 = 1, var_5953c9ce8530c19a = 110, start_trigger_radius = 100, var_d67fbb77e4f2e2b5 = 1 )
{
    tutorial_struct = { #fail_state:-1, #is_completed:0, #is_locked:0, #var_11b386f1f1fd262a:var_11b386f1f1fd262a, #transition_fade_out_time:transition_fade_out_time, #transition_fade_in_time:transition_fade_in_time, #respawn_delay:respawn_delay, #respawn_angles:respawn_angles, #respawn_position:respawn_position, #var_daae47f54aee1cc3:var_daae47f54aee1cc3, #var_b8abd6e1783d0f45:var_b8abd6e1783d0f45, #startlogic:startlogic, #var_47f8fc3de4a91658:var_47f8fc3de4a91658, #var_fe1e173811f47789:var_fe1e173811f47789, #var_3dcac807aca26fce:var_3dcac807aca26fce, #onexit:onexit, #onfail:onfail, #oncleanup:oncleanup, #onsetup:onsetup, #oob_chevrons:[], #var_a5fd41050e0ceb34:0, #var_98cec33d0b4e8c5:0, #var_5a63045faffa8fee:0, #state:3, #var_96e5beb113f41311:var_96e5beb113f41311, #tutorial_type:tutorial_type, #var_81173965ad64569:var_81173965ad64569, #id_string:id_string };
    tutorial_struct.order_number = var_81173965ad64569;
    init_trigger = function_4c7f1d74ec378cc9( tutorial_struct, init_trigger_position, start_trigger_radius, &function_3a0aec7f1e9988a3, &function_5c1689103ca32d82 );
    init_trigger.is_init_trigger = 1;
    tutorial_struct.init_trigger = init_trigger;
    registertrigger( init_trigger );
    flag = spawn( "script_model", init_trigger_position );
    
    if ( var_c7da30c496405c56 )
    {
        flag setmodel( function_68d39c6b75e01593( "neutral" ) );
    }
    
    tutorial_struct.init_trigger.flag = flag;
    flag notsolid();
    flag makeusable();
    flag setuserange( start_trigger_radius * var_d67fbb77e4f2e2b5 );
    flag sethintstring( &"t10_training_course/enter_station_hint" );
    flag sethintdisplayfov( 360 );
    flag setcursorhint( "HINT_NOICON" );
    flag sethintonobstruction( "show" );
    flag setuseprioritymax();
    level thread function_78ed747911e430e7( flag, tutorial_struct );
    
    if ( false )
    {
        init_trigger.chevrons = function_a017d1ec37595fa( "cer_gamemode_chevron", init_trigger_position, start_trigger_radius, 0.9, 0 );
    }
    
    marker = gameobjects::createobjidobject( init_trigger_position, "neutral", ( 0, 0, var_5953c9ce8530c19a ), undefined, "any", 1, "icon_regular" );
    objidpoolmanager::update_objective_icon( marker.objidnum, function_de3c47a67959c59e( tutorial_struct.order_number ) );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 9 );
    objidpoolmanager::update_objective_size( marker.objidnum, "icon_small" );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::function_373aaf492aabde6f( marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_9d4895ed38151e46( marker.objidnum, 1 );
    objidpoolmanager::function_586b631e7bbb592a( marker.objidnum, 1 );
    objective_setlabel( marker.objidnum, function_e2157f3642beec77( tutorial_struct.order_number ) );
    objidpoolmanager::objective_playermask_hidefromall( marker.objidnum );
    tutorial_struct.init_trigger.objective_marker = marker;
    utility::callsharedfunc( #"objective", #"hash_10d5e3bb8a551724", marker.objidnum, init_trigger_position );
    level.tutorial_dictionary[ id_string ] = tutorial_struct;
    return tutorial_struct;
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0x1f4fb5ca, Offset: 0x1a70
// Size: 0x56
function private function_de3c47a67959c59e( tutorial_order_number )
{
    icon_name = "ui_icon_waypoint_training_station_";
    
    if ( tutorial_order_number < 0 || tutorial_order_number > 7 )
    {
        iprintlnbold( "Icon { " + icon_name + tutorial_order_number + 1 + " } does not exist. We would need to create one." );
        return ( icon_name + "1" );
    }
    
    return icon_name + tutorial_order_number + 1;
}

// Namespace common_training_course
// Params 1
// Checksum 0x73d15c41, Offset: 0x1acf
// Size: 0xa3
function function_e2157f3642beec77( tutorial_order_number )
{
    labels = [ &"t10_training_course/station_1_label", &"t10_training_course/station_2_label", &"t10_training_course/station_3_label", &"t10_training_course/station_4_label", &"t10_training_course/station_5_label", &"t10_training_course/station_6_label", &"t10_training_course/station_7_label", &"t10_training_course/station_8_label" ];
    assert( tutorial_order_number < labels.size, "<dev string:x6d>" + tutorial_order_number + "<dev string:xb9>" );
    return labels[ tutorial_order_number ];
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0xc06703b3, Offset: 0x1b7b
// Size: 0x5e
function private function_68d39c6b75e01593( flag_type )
{
    switch ( flag_type )
    {
        case #"hash_a571cacc018623b8":
            return "t10_decor_gunfight_flag_01";
        case #"hash_5f54b9bf7583687f":
            return "t10_decor_gunfight_flag_01";
        case #"hash_7c2d091e6337bf54":
            return "t10_decor_gunfight_flag_01";
        default:
            return "t10_decor_gunfight_flag_01";
    }
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x2405ceb0, Offset: 0x1be1
// Size: 0x45
function private function_f1ec08cd8f74da12( player, tutorial )
{
    if ( !function_d1d2cf69e63f6596( tutorial ) )
    {
        function_5c1689103ca32d82( player, tutorial );
        level thread starttutorial( player, tutorial, 1, tutorial.var_b8abd6e1783d0f45, 0, 0 );
    }
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x29f15106, Offset: 0x1c2e
// Size: 0x66
function private function_78ed747911e430e7( interactable, tutorial )
{
    level endon( #"game_ended" );
    interactable endon( #"hash_23f15c705d374165" );
    
    while ( true )
    {
        interactable waittill( #"trigger", player );
        interactable sethintinoperable( 1 );
        function_f1ec08cd8f74da12( player, tutorial );
        break;
    }
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x15e2f267, Offset: 0x1c9c
// Size: 0x5f
function private function_312ad34cc38979e4( interactable, player )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        interactable waittill( #"trigger", player );
        current_value = player getclientomnvar( "training_course_leave_game_request" );
        player setclientomnvar( "training_course_leave_game_request", !current_value );
    }
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0xe9c59c5b, Offset: 0x1d03
// Size: 0x19
function private function_bfd317f43b3fe8e3( interactable )
{
    interactable notify( #"hash_23f15c705d374165" );
}

// Namespace common_training_course
// Params 2
// Checksum 0x19399c09, Offset: 0x1d24
// Size: 0xa6
function function_cc9a85feed9c8e34( player, tutorial )
{
    foreach ( other_tutorial in level.tutorial_dictionary )
    {
        if ( !function_3c77ed00cac74efe( other_tutorial ) )
        {
            function_a49fc858e731dcdb( other_tutorial, 0 );
            function_8becb86703380fc7( other_tutorial, 0, 0 );
        }
    }
}

// Namespace common_training_course
// Params 0
// Checksum 0x8c11e003, Offset: 0x1dd2
// Size: 0xc7
function function_89df6b3aced6d8cd()
{
    var_826a597648a0c05a = undefined;
    
    if ( level.var_bb4f4ac000751f63 != -1 )
    {
        var_826a597648a0c05a = level.var_80e907d847fdb68c[ level.var_bb4f4ac000751f63 ];
    }
    
    foreach ( other_tutorial in level.tutorial_dictionary )
    {
        if ( !function_3c77ed00cac74efe( other_tutorial ) )
        {
            function_a49fc858e731dcdb( other_tutorial, 1 );
            function_8becb86703380fc7( other_tutorial, var_826a597648a0c05a === other_tutorial, 1 );
        }
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0x9c3d3ee, Offset: 0x1ea1
// Size: 0x3e
function function_bfa865dfd7b9bfd6( tutorial, value )
{
    tutorial.is_locked = value;
    function_a49fc858e731dcdb( tutorial, !value );
    function_8becb86703380fc7( tutorial, !value, !value );
}

// Namespace common_training_course
// Params 2
// Checksum 0x18122a13, Offset: 0x1ee7
// Size: 0x5b
function function_3f46a4fd28a17454( player, tutorial )
{
    if ( !isdefined( player.ishudhidden ) )
    {
        player.ishudhidden = 0;
    }
    
    if ( !player.ishudhidden )
    {
        player setclientomnvar( "ui_hide_hud", 1 );
        player.ishudhidden = 1;
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0x481ad3a4, Offset: 0x1f4a
// Size: 0x60
function function_649644d8af5d56f( player, tutorial )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.ishudhidden ) )
    {
        player.ishudhidden = 0;
    }
    
    if ( player.ishudhidden )
    {
        player setclientomnvar( "ui_hide_hud", 0 );
        player.ishudhidden = 0;
    }
}

// Namespace common_training_course
// Params 7
// Checksum 0x3b491eba, Offset: 0x1fb2
// Size: 0x53a
function starttutorial( player, new_tutorial_struct, var_67d56ce428f7a6f9, var_21904a198ae4f24e = 0, var_2b4b07109454f1e4 = 0, was_failed = 0, var_1511c5590534bc27 = undefined )
{
    assert( isdefined( new_tutorial_struct ), "<dev string:xbb>" );
    level notify( #"tutorial_changed" );
    level endon( #"tutorial_changed" );
    level thread function_ee1d3936eb6e1e03( player, new_tutorial_struct );
    
    if ( var_21904a198ae4f24e )
    {
        player allowmovement( 0 );
        function_3f46a4fd28a17454( player, new_tutorial_struct );
        benchmark_mp_utils::function_1575e6db0bcbad11( new_tutorial_struct.transition_fade_in_time );
        wait new_tutorial_struct.transition_fade_in_time;
        player setvelocity( ( 0, 0, 0 ) );
    }
    
    if ( isdefined( level.current_tutorial ) )
    {
        profilestart();
        function_bb59f9b0bdf2d248( level.current_tutorial, 0 );
        [[ level.current_tutorial.oncleanup ]]( function_abaed5b5b01f5e28( level.current_tutorial ) ? function_729244fb63340d85() : player, level.current_tutorial );
        profilestop();
        
        if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && function_abaed5b5b01f5e28( level.current_tutorial ) )
        {
            should_spawn_player = !var_2b4b07109454f1e4;
            function_1df2d986a2f9e167( function_729244fb63340d85(), level.current_tutorial, should_spawn_player );
            
            if ( should_spawn_player )
            {
                waitforplayerspawned( player );
            }
        }
        
        /#
            iprintln( "<dev string:xe3>" + function_399e310dabe4c2cc( new_tutorial_struct ) );
        #/
    }
    
    /#
        iprintln( "<dev string:xed>" + function_399e310dabe4c2cc( new_tutorial_struct ) );
    #/
    
    removeallcorpses();
    player setclientomnvar( "training_course_current_station_unique_id", function_8b878dec24bedc0e( new_tutorial_struct ) );
    player setclientomnvar( "training_course_current_station_type", function_87ff4a0d38e17094( new_tutorial_struct ) );
    player setclientomnvar( "is_in_training_course_tutorial_station", 1 );
    player setclientomnvar( "current_tutorial_has_preview", isdefined( new_tutorial_struct.var_fe1e173811f47789 ) );
    player setclientomnvar( "training_course_station_supports_instructions", function_655349246b97b3a1( new_tutorial_struct ) );
    function_cc9a85feed9c8e34( player, new_tutorial_struct );
    player hud_message::function_c7ef9b0007b5092d();
    player hud_message::clearsplashqueue();
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && var_2b4b07109454f1e4 )
    {
        preview_bot = function_729244fb63340d85();
        function_d7da7bef32a55e59( player, preview_bot, new_tutorial_struct );
        player = preview_bot;
    }
    
    weapons = player getweaponslistprimaries();
    
    foreach ( weapon in weapons )
    {
        if ( weapon.basename != "none" )
        {
            player setweaponammoclip( weapon, weaponclipsize( weapon ) );
        }
    }
    
    player.health = player.maxhealth;
    player freezecontrols( 1 );
    
    if ( isdefined( var_1511c5590534bc27 ) )
    {
        [[ var_1511c5590534bc27 ]]( player, new_tutorial_struct );
    }
    
    if ( isdefined( new_tutorial_struct.var_e7e7977f1d016e4c ) )
    {
        wait new_tutorial_struct.var_e7e7977f1d016e4c;
    }
    
    profilestart();
    [[ new_tutorial_struct.onsetup ]]( player, new_tutorial_struct );
    profilestop();
    
    if ( var_21904a198ae4f24e )
    {
        wait new_tutorial_struct.var_11b386f1f1fd262a;
        player setorigin( new_tutorial_struct.respawn_position );
        player setplayerangles( new_tutorial_struct.respawn_angles );
        
        if ( !new_tutorial_struct.var_98cec33d0b4e8c5 )
        {
            player setstance( "stand", 1, 1 );
        }
    }
    
    function_bb59f9b0bdf2d248( new_tutorial_struct, 1 );
    function_2125c1ceca157ae2();
    
    if ( var_21904a198ae4f24e )
    {
        benchmark_mp_utils::function_157210286b7849ce( new_tutorial_struct.transition_fade_out_time );
        wait new_tutorial_struct.transition_fade_out_time;
    }
    
    level.current_tutorial = new_tutorial_struct;
    
    if ( var_67d56ce428f7a6f9 && function_655349246b97b3a1( new_tutorial_struct ) )
    {
        var_c387f9f8e6ada71d = isbot( player ) ? player.spectating_player : player;
        function_dfb331efe033ac6c( var_c387f9f8e6ada71d, new_tutorial_struct, 1 );
        new_tutorial_struct waittill( #"triptychs_training_course_station_start" );
        function_dfb331efe033ac6c( var_c387f9f8e6ada71d, new_tutorial_struct, 0 );
    }
    
    function_649644d8af5d56f( player, new_tutorial_struct );
    player freezecontrols( 0 );
    
    if ( !new_tutorial_struct.var_5a63045faffa8fee )
    {
        player allowmovement( 1 );
    }
    
    function_696273ac9d3bea25( new_tutorial_struct, 0, player );
    
    if ( isdefined( new_tutorial_struct.startlogic ) )
    {
        level thread [[ new_tutorial_struct.startlogic ]]( player, new_tutorial_struct );
    }
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && var_2b4b07109454f1e4 )
    {
        level thread function_a2935575b5b51ed6( player, new_tutorial_struct );
        level thread function_b26daaaa9debed6e( player.spectating_player, new_tutorial_struct );
    }
    
    if ( was_failed && !isbot( player ) && function_32d334aad6bf0ad3( new_tutorial_struct ) )
    {
        level thread showfailhint( player, new_tutorial_struct );
    }
    
    if ( isbot( player ) )
    {
        level thread function_fb78e7c7ad8e2157( player );
    }
    
    new_tutorial_struct notify( #"tutorial_started" );
    player playsound( "uin_t10_training_course_tutorial_start" );
}

// Namespace common_training_course
// Params 2, eflags: 0xc
// Checksum 0xbe1b2254, Offset: 0x24f4
// Size: 0x8a
function private function_ee1d3936eb6e1e03( player, tutorial )
{
    self notify( #"hash_ea422e8f66b698ab" );
    self endon( #"hash_ea422e8f66b698ab" );
    level endon( #"tutorial_changed" );
    tutorial endon( #"tutorial_started" );
    
    if ( player::isreallyalive( player ) )
    {
        player waittill( #"death" );
    }
    
    while ( !function_d1d2cf69e63f6596( tutorial ) )
    {
        if ( function_faa438d8de9a4dc9( player ) )
        {
            break;
        }
        
        waitframe();
    }
    
    level thread exittutorial( player, tutorial, 1 );
}

// Namespace common_training_course
// Params 1
// Checksum 0xf36be02f, Offset: 0x2586
// Size: 0x145
function onplayerrespawn( reviverespawn )
{
    player = self;
    player thread giveloadoutonspawn( player );
    var_b138c7c63944889f = !isbot( player ) || function_abaed5b5b01f5e28( level.current_tutorial );
    
    if ( var_b138c7c63944889f && function_cbcead310c3cf8bd( level.current_tutorial ) )
    {
        wait level.current_tutorial.respawn_delay;
        
        if ( level.current_tutorial.fail_state == 1 )
        {
            level thread exittutorial( player, level.current_tutorial, 1, &function_bf9f86692b45ce4 );
        }
        else
        {
            is_fail_state_spectate = level.current_tutorial.fail_state == 0;
            level thread restarttutorial( isbot( player ) ? player.spectating_player : player, level.current_tutorial, is_fail_state_spectate, level.current_tutorial.fail_state == 2, 1, !is_fail_state_spectate ? &function_bf9f86692b45ce4 : undefined );
        }
        
        level.current_tutorial.fail_state = -1;
    }
    
    if ( !isbot( player ) )
    {
        level thread function_fb78e7c7ad8e2157( player );
    }
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0x882bc287, Offset: 0x26d3
// Size: 0x32
function private giveloadoutonspawn( player )
{
    player endon( #"death_or_disconnect" );
    player waittill( #"giveloadout" );
    waitframe();
    player thread function_2cb67c7fc6e3fed5( player );
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x2f671892, Offset: 0x270d
// Size: 0x6a
function private function_bf9f86692b45ce4( player, tutorial )
{
    assert( isdefined( tutorial ), "<dev string:xf7>" );
    player playerlogic::spawnplayer( undefined, 0 );
    player freezecontrols( 1 );
    function_3f46a4fd28a17454( player, tutorial );
    player setorigin( tutorial.respawn_position );
    player setplayerangles( tutorial.respawn_angles );
}

// Namespace common_training_course
// Params 6
// Checksum 0x5b669398, Offset: 0x277f
// Size: 0xab
function restarttutorial( player, tutorial, var_2b4b07109454f1e4, var_67d56ce428f7a6f9, was_failed, var_1511c5590534bc27 = undefined )
{
    self notify( #"hash_6d41bbda69f8323" );
    self endon( #"hash_6d41bbda69f8323" );
    
    /#
        iprintln( "<dev string:x120>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    if ( outofbounds::isoob( player ) )
    {
        outofbounds::clearoob( player );
    }
    
    function_696273ac9d3bea25( tutorial, 4, player );
    level thread starttutorial( player, tutorial, var_67d56ce428f7a6f9, tutorial.var_daae47f54aee1cc3, var_2b4b07109454f1e4, was_failed, var_1511c5590534bc27 );
}

// Namespace common_training_course
// Params 2
// Checksum 0x8422121b, Offset: 0x2832
// Size: 0x99
function failtutorial( player, tutorial )
{
    self notify( #"hash_2ece4d618f3f4963" );
    self endon( #"hash_2ece4d618f3f4963" );
    
    /#
        iprintln( "<dev string:x12c>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    tutorial notify( #"tutorial_failed" );
    function_696273ac9d3bea25( tutorial, 1, player );
    
    if ( true )
    {
        function_3f46a4fd28a17454( player, tutorial );
    }
    
    if ( isdefined( tutorial.onfail ) )
    {
        level thread [[ tutorial.onfail ]]( player, tutorial );
    }
    
    player playsound( "uin_t10_training_course_tutorial_fail" );
}

// Namespace common_training_course
// Params 4
// Checksum 0x6891bcfb, Offset: 0x28d3
// Size: 0x22a
function exittutorial( player, tutorial, should_play_transition, var_1511c5590534bc27 = undefined )
{
    level notify( #"tutorial_changed" );
    level endon( #"tutorial_changed" );
    player setclientomnvar( "is_in_training_course_tutorial_station", 0 );
    player setclientomnvar( "current_tutorial_has_preview", 0 );
    player setclientomnvar( "training_course_station_supports_instructions", 0 );
    function_696273ac9d3bea25( tutorial, 3, player );
    
    if ( should_play_transition )
    {
        function_3f46a4fd28a17454( player );
        player freezecontrols( 1 );
        benchmark_mp_utils::function_1575e6db0bcbad11( tutorial.transition_fade_in_time );
        wait tutorial.transition_fade_in_time;
    }
    
    if ( function_faa438d8de9a4dc9( player ) )
    {
        function_dfb331efe033ac6c( player, tutorial, 0 );
    }
    
    /#
        iprintln( "<dev string:x135>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    profilestart();
    [[ tutorial.oncleanup ]]( function_abaed5b5b01f5e28( tutorial ) ? function_729244fb63340d85() : player, tutorial );
    profilestop();
    
    if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && function_abaed5b5b01f5e28( tutorial ) )
    {
        function_1df2d986a2f9e167( function_729244fb63340d85(), tutorial, 1 );
        waitforplayerspawned( player );
    }
    
    if ( isdefined( tutorial.onexit ) )
    {
        [[ tutorial.onexit ]]( function_abaed5b5b01f5e28( tutorial ) ? function_729244fb63340d85() : player, tutorial );
    }
    
    if ( isdefined( var_1511c5590534bc27 ) )
    {
        [[ var_1511c5590534bc27 ]]( player, tutorial );
    }
    
    function_89df6b3aced6d8cd();
    function_bb59f9b0bdf2d248( tutorial, 0 );
    function_6c0ff087784b7b0( tutorial, undefined );
    function_2d02218ae92b9b9a( 1 );
    
    if ( should_play_transition )
    {
        player setorigin( tutorial.respawn_position );
        player setplayerangles( tutorial.respawn_angles );
        player setstance( "stand", 1, 1 );
        benchmark_mp_utils::function_157210286b7849ce( tutorial.transition_fade_out_time );
        wait tutorial.transition_fade_out_time;
    }
    
    function_649644d8af5d56f( player );
    player freezecontrols( 0 );
    player allowmovement( 1 );
    
    if ( level.current_tutorial === tutorial )
    {
        level.current_tutorial = undefined;
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0x3597c381, Offset: 0x2b05
// Size: 0x249
function completetutorial( player, tutorial, var_cb54f480ed623755 = 1 )
{
    self notify( #"hash_acffc92aaecdd228" );
    self endon( #"hash_acffc92aaecdd228" );
    level endon( #"tutorial_changed" );
    
    /#
        iprintln( "<dev string:x13e>" + function_399e310dabe4c2cc( tutorial ) );
    #/
    
    tutorial notify( #"tutorial_completed" );
    function_696273ac9d3bea25( tutorial, 2, player );
    
    if ( function_abaed5b5b01f5e28( tutorial ) )
    {
        wait 1;
        level thread restarttutorial( function_729244fb63340d85().spectating_player, tutorial, 0, 1, 0, undefined );
        return;
    }
    
    tutorial.is_completed = 1;
    player setclientomnvar( "training_course_tutorial_completed", function_8b878dec24bedc0e( tutorial ) );
    
    if ( var_cb54f480ed623755 )
    {
        player hud_message::function_78fedf6f526825f4( "training_tutorial_completed", level.gametypebundle.var_e662dd7f27d462eb );
    }
    
    player playsound( "uin_t10_training_course_tutorial_success" );
    var_3ef8077d0bfd5d0f = 0;
    var_d4ac22c68ea6d8c9 = 0;
    
    foreach ( other_tutorial in level.tutorial_dictionary )
    {
        if ( function_faefa119842f585b( other_tutorial ) )
        {
            var_3ef8077d0bfd5d0f++;
        }
    }
    
    if ( var_3ef8077d0bfd5d0f == level.tutorial_dictionary.size )
    {
        var_d4ac22c68ea6d8c9 = 1;
    }
    
    if ( level.var_bb4f4ac000751f63 == tutorial.order_number && !var_d4ac22c68ea6d8c9 )
    {
        for ( i = level.var_bb4f4ac000751f63 + 1; i < level.var_80e907d847fdb68c.size ; i++ )
        {
            if ( !function_faefa119842f585b( level.var_80e907d847fdb68c[ i ] ) )
            {
                level.var_bb4f4ac000751f63 = level.var_80e907d847fdb68c[ i ].order_number;
                break;
            }
        }
    }
    else if ( var_d4ac22c68ea6d8c9 )
    {
        level.var_bb4f4ac000751f63 = -1;
    }
    
    level thread exittutorial( player, tutorial, 0 );
}

// Namespace common_training_course
// Params 3, eflags: 0x4
// Checksum 0xecb9a203, Offset: 0x2d56
// Size: 0x154
function private function_d7da7bef32a55e59( player, bot, tutorial )
{
    tutorial.var_a5fd41050e0ceb34 = 1;
    bot playershow();
    
    if ( getdvarint( @"hash_27519d16bffbc440", 0 ) == 1 )
    {
        player freezecontrols( 0 );
        player allowmovement( 1 );
        player setclientomnvar( "ui_hide_hud", 1 );
        
        /#
            if ( !player isnoclip() )
            {
                player noclip();
            }
        #/
        
        player notify( #"enter_spectator_mode" );
    }
    else
    {
        spectatetargetentnum = bot getentitynumber();
        player player::updatesessionstate( "spectator" );
        player.forcespectatorclient = spectatetargetentnum;
        player notify( #"enter_spectator_mode" );
    }
    
    bot.spectating_player = player;
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "dont_path_to_enemy", 1 );
    bot botsetflag( "disable_random_goal", 1 );
    bot botsetflag( "no_enemy_search", 1 );
    bot botsetflag( "disable_automatic_sprint", 1 );
    
    if ( isdefined( tutorial.var_3dcac807aca26fce ) )
    {
        profilestart();
        [[ tutorial.var_3dcac807aca26fce ]]( bot, tutorial );
        profilestop();
    }
    
    level thread function_193ffe26151ddf4c( player, tutorial );
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x686e3f66, Offset: 0x2eb2
// Size: 0x36
function private function_a2935575b5b51ed6( bot, tutorial )
{
    if ( isdefined( tutorial.var_fe1e173811f47789 ) )
    {
        level thread [[ tutorial.var_fe1e173811f47789 ]]( bot, tutorial );
    }
}

// Namespace common_training_course
// Params 4, eflags: 0x4
// Checksum 0x7db1103, Offset: 0x2ef0
// Size: 0xf6
function private function_1df2d986a2f9e167( bot, tutorial, should_spawn_player, var_f25cf6a3f4b11fd8 )
{
    bot notify( #"hash_27620d5c2e30b764" );
    tutorial.var_a5fd41050e0ceb34 = 0;
    
    if ( isdefined( tutorial.var_47f8fc3de4a91658 ) )
    {
        profilestart();
        [[ tutorial.var_47f8fc3de4a91658 ]]( bot, tutorial );
        profilestop();
    }
    
    spectating_player = bot.spectating_player;
    bot botsetstance( "stand" );
    
    while ( function_ea0c6158d187ce84( bot ) || bot getstance() != "stand" )
    {
        waitframe();
    }
    
    function_f84dc38c3e66bb65( bot );
    bot setorigin( var_f25cf6a3f4b11fd8 );
    bot.spectating_player = undefined;
    bot playerhide();
    
    if ( should_spawn_player )
    {
        spectating_player playerlogic::removefromalivecount( 0 );
        level thread giveloadoutonspawn( spectating_player );
        level thread function_bf9f86692b45ce4( spectating_player, tutorial );
        level thread function_fb78e7c7ad8e2157( spectating_player );
    }
}

// Namespace common_training_course
// Params 2, eflags: 0xc
// Checksum 0x13d5ef06, Offset: 0x2fee
// Size: 0x46
function private function_193ffe26151ddf4c( player, tutorial )
{
    self notify( #"hash_d39a577abad2e9ec" );
    self endon( #"hash_d39a577abad2e9ec" );
    level endon( #"tutorial_changed" );
    wait 45;
    failtutorial( player, tutorial );
}

// Namespace common_training_course
// Params 3, eflags: 0x4
// Checksum 0xd7ef406, Offset: 0x303c
// Size: 0x5d
function private function_696273ac9d3bea25( tutorial, new_state, player )
{
    function_df581661be9ca5c5( player );
    
    if ( function_1c1639bf73457e80( player ) )
    {
        function_5e3e773127f754db( player );
    }
    
    if ( function_33427acbfd53222( player ) )
    {
        function_55099ffa73b4eff1( player );
    }
    
    tutorial.state = new_state;
}

// Namespace common_training_course
// Params 1
// Checksum 0xa2641c09, Offset: 0x30a1
// Size: 0x19, Type: bool
function function_d1d2cf69e63f6596( tutorial )
{
    return tutorial.state == 0;
}

// Namespace common_training_course
// Params 1
// Checksum 0x22f23032, Offset: 0x30c3
// Size: 0x1a, Type: bool
function function_cbcead310c3cf8bd( tutorial )
{
    return tutorial.state == 1;
}

// Namespace common_training_course
// Params 1
// Checksum 0xbcea7bcd, Offset: 0x30e6
// Size: 0x1a, Type: bool
function function_7bc1290560032d39( tutorial )
{
    return tutorial.state == 3;
}

// Namespace common_training_course
// Params 1
// Checksum 0x98a6ed4b, Offset: 0x3109
// Size: 0x2b, Type: bool
function function_abaed5b5b01f5e28( tutorial )
{
    if ( !getdvarint( @"hash_5bb18d4eb7794e87" ) )
    {
        return false;
    }
    
    return istrue( tutorial.var_a5fd41050e0ceb34 );
}

// Namespace common_training_course
// Params 1
// Checksum 0x4fa3cc52, Offset: 0x313d
// Size: 0x17
function function_3c77ed00cac74efe( tutorial )
{
    return tutorial.is_locked;
}

// Namespace common_training_course
// Params 1
// Checksum 0xb74a73c8, Offset: 0x315d
// Size: 0x17
function function_faefa119842f585b( tutorial )
{
    return tutorial.is_completed;
}

// Namespace common_training_course
// Params 1
// Checksum 0xd095e0ce, Offset: 0x317d
// Size: 0x17
function function_655349246b97b3a1( tutorial )
{
    return tutorial.var_96e5beb113f41311;
}

// Namespace common_training_course
// Params 1
// Checksum 0xc5395f3c, Offset: 0x319d
// Size: 0x17
function function_399e310dabe4c2cc( tutorial )
{
    return tutorial.id_string;
}

// Namespace common_training_course
// Params 1
// Checksum 0x27c70bb2, Offset: 0x31bd
// Size: 0x17
function function_87ff4a0d38e17094( tutorial )
{
    return tutorial.tutorial_type;
}

// Namespace common_training_course
// Params 1
// Checksum 0x1cfac5fe, Offset: 0x31dd
// Size: 0x17
function function_8b878dec24bedc0e( tutorial )
{
    return tutorial.var_81173965ad64569;
}

// Namespace common_training_course
// Params 7
// Checksum 0x9ec0d924, Offset: 0x31fd
// Size: 0x23e
function spawnagent( origin, angles, health, add_outline = 0, body_model = %"c_t10_gbl_opforce_pantheon_body_3", head_model = %"head_sc_m_colvin", hat_model = %"c_t10_gbl_opforce_pantheon_ast_head_2" )
{
    agent = mp_agent::spawnnewagentaitype( "enemy_mp_benchmark_base", origin, angles );
    agent.team = "axis";
    agent.health = health;
    agent.cannotmelee = 1;
    agent.disablebulletwhizbyreaction = 1;
    agent setcanusecover( 0 );
    agent.runngunenabled = 0;
    agent.disabledodge = 1;
    agent.aggressivemode = 0;
    agent.var_63f1ffef1eafa4e4 = 1;
    agent.allowlongdeath = 0;
    agent.agent_damage_callback = &function_2d459ce49ce8b45e;
    agent.var_1bf926518b0cb33 = 1;
    agent.allowpain = 0;
    agent enabletraversals( 0 );
    agent utility::set_movement_speed( 0 );
    agent.scripted_mode = 1;
    agent.ignoreme = 1;
    agent agent_utils::ai_blockexecution( 1 );
    
    if ( add_outline )
    {
        outline::outlineenableforall( agent, "outline_nodepth_red", "level_script" );
    }
    
    if ( isdefined( agent.headmodel ) )
    {
        agent detach( agent.headmodel );
        agent.headmodel = undefined;
    }
    
    if ( isdefined( agent.hatmodel ) )
    {
        agent detach( agent.hatmodel );
        agent.hatmodel = undefined;
    }
    
    agent setmodel( body_model );
    agent attach( head_model, "", 1 );
    agent.headmodel = head_model;
    
    if ( hat_model != "" )
    {
        agent attach( hat_model, "", 1 );
        agent.hatmodel = hat_model;
    }
    
    return agent;
}

// Namespace common_training_course
// Params 4
// Checksum 0xe575c3f2, Offset: 0x3444
// Size: 0x85
function function_162ad9008bc2d7d4( player, v_position, var_3b36db39e36618bb, hint_string )
{
    if ( !isdefined( level.leave_training_course_interactable ) )
    {
        leave_training_course_interactable = spawn( "script_model", v_position );
        leave_training_course_interactable makeusable();
        leave_training_course_interactable setuserange( var_3b36db39e36618bb );
        leave_training_course_interactable sethintstring( hint_string );
        leave_training_course_interactable setcursorhint( "HINT_NOICON" );
        level.leave_training_course_interactable = leave_training_course_interactable;
        level thread function_312ad34cc38979e4( leave_training_course_interactable, player );
    }
}

// Namespace common_training_course
// Params 0, eflags: 0x4
// Checksum 0xbd65a36c, Offset: 0x34d1
// Size: 0xae
function private function_b9d8e5961402360f()
{
    return [ "dx_bc_aqsc_atac_aqs1_firing", "dx_bc_aqsc_atac_aqs2_firing", "dx_bc_aqsc_atac_aqs3_firing", "dx_bc_aqsc_atac_aqs5_firing", "dx_bc_aqsc_atac_aqs1_imshooting", "dx_bc_aqsc_atac_aqs2_imshooting", "dx_bc_aqsc_atac_aqs3_imshooting", "dx_bc_aqsc_atac_aqs5_imshooting", "dx_bc_aqsc_atac_aqs1_openingfire", "dx_bc_aqsc_atac_aqs2_openingfire", "dx_bc_aqsc_atac_aqs3_openingfire", "dx_bc_aqsc_atac_aqs4_openingfire", "dx_bc_aqsc_posn_aqs1_lookforward", "dx_bc_aqsc_posn_aqs2_rightinfrontofus", "dx_bc_aqsc_posn_aqs4_rightinfrontofus", "dx_bc_aqsc_posn_aqs1_upthere", "dx_bc_aqsc_posn_aqs2_upthere", "dx_bc_aqsc_posn_aqs3_upthere", "dx_bc_aqsc_posn_aqs4_upthere" ];
}

// Namespace common_training_course
// Params 4
// Checksum 0xb639c331, Offset: 0x3588
// Size: 0x8c
function function_f7e26bf874373e37( entity, shader, alpha = 1, y_offset = 0 )
{
    pingmarker = newhudelem();
    pingmarker.alpha = alpha;
    pingmarker setshader( shader, 128, 128 );
    pingmarker setwaypoint( 1, 1, 0, 0 );
    pingmarker linkwaypointtotargetwithoffset( entity, ( 0, 0, y_offset ) );
    entity.pingmarker = pingmarker;
    return pingmarker;
}

// Namespace common_training_course
// Params 2
// Checksum 0x2df0dcd, Offset: 0x361d
// Size: 0x23
function function_b3d358f2f43b564c( agent, value )
{
    agent.magicbulletshield = value;
}

// Namespace common_training_course
// Params 3
// Checksum 0x39d4b73, Offset: 0x3648
// Size: 0x8b
function function_d42a29e61dd9e610( agent, player, damage_amount )
{
    level endon( #"tutorial_changed" );
    agent endon( #"death" );
    player endon( #"death" );
    
    if ( !agent tagexists( "tag_flash" ) )
    {
        return;
    }
    
    function_bc2d17578622fd93( agent, player, 0 );
    wait 0.2;
    player dodamage( damage_amount, player.origin, agent, undefined, "MOD_RIFLE_BULLET", agent.primaryweapon );
}

// Namespace common_training_course
// Params 3
// Checksum 0xf96032df, Offset: 0x36db
// Size: 0xb9
function function_bc2d17578622fd93( agent, player, var_c970e33ca7a31862 )
{
    start = agent gettagorigin( "tag_flash" );
    end = player geteye();
    var_47da99db0bfbb09c = agent gettagangles( "tag_flash" );
    playfx( utility::getfx( "vfx_muzzle_flash" ), start, anglestoforward( var_47da99db0bfbb09c ), anglestoup( var_47da99db0bfbb09c ) );
    agent shoot( 0, player, 1, 0, 1 );
    
    if ( var_c970e33ca7a31862 )
    {
        magicbullet( agent.primaryweapon, start, player.origin + ( 0, 0, 15 ), agent );
    }
}

// Namespace common_training_course
// Params 14, eflags: 0x4
// Checksum 0x28f92453, Offset: 0x379c
// Size: 0xb2
function private function_2d459ce49ce8b45e( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( !utility::isbulletdamage( smeansofdeath ) )
    {
        return 0;
    }
    
    if ( self.magicbulletshield )
    {
        return 0;
    }
    
    if ( isdefined( eattacker ) && !isalive( eattacker ) )
    {
        return 0;
    }
    
    return idamage;
}

// Namespace common_training_course
// Params 9, eflags: 0x4
// Checksum 0x9af7cb04, Offset: 0x3857
// Size: 0xe4
function private function_2e48a30dec1b5d77( player, agent, success, success_wait_time, fail_wait_time, success_damage, fail_damage, var_526b354c2ff59e1, var_54aa554c327b5cf )
{
    level endon( #"tutorial_changed" );
    agent endon( #"death" );
    wait success ? success_wait_time : fail_wait_time;
    
    while ( true )
    {
        trace = trace::ray_trace( agent geteye(), player geteye(), agent, undefined );
        
        if ( trace[ "entity" ] === player )
        {
            var_65c55325765f1984 = success ? success_damage : fail_damage;
            level thread function_d42a29e61dd9e610( agent, player, var_65c55325765f1984 );
            
            if ( isalive( player ) )
            {
                wait randomfloatrange( var_526b354c2ff59e1, var_54aa554c327b5cf );
            }
        }
        
        waitframe();
    }
}

// Namespace common_training_course
// Params 5
// Checksum 0xb260dbc, Offset: 0x3943
// Size: 0xae
function function_5310120afb8b29a0( player, var_1eb21c6c806c259c, var_3c25ca2a247a6dee = undefined, amount_time = undefined, var_9525fa9f700d8874 = 1 )
{
    timer = 0;
    
    while ( true )
    {
        if ( [[ var_1eb21c6c806c259c ]]( player ) )
        {
            if ( !isdefined( var_3c25ca2a247a6dee ) || [[ var_3c25ca2a247a6dee ]]( player ) )
            {
                timer += level.framedurationseconds;
                
                if ( !isdefined( amount_time ) || timer > amount_time )
                {
                    break;
                }
            }
        }
        else
        {
            timer = 0;
        }
        
        waitframe();
    }
    
    if ( var_9525fa9f700d8874 )
    {
        player playsound( "uin_t10_training_course_objective_success" );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x24682de8, Offset: 0x39f9
// Size: 0x12
function issprinting( player )
{
    return player issprinting();
}

// Namespace common_training_course
// Params 1
// Checksum 0x25b384c3, Offset: 0x3a14
// Size: 0x1c, Type: bool
function function_ea0c6158d187ce84( player )
{
    return player issprintsliding() || player isdiving();
}

// Namespace common_training_course
// Params 1
// Checksum 0xbfed8d1d, Offset: 0x3a39
// Size: 0x47, Type: bool
function function_cd38eb9937fdb136( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoright( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) >= 0.8;
}

// Namespace common_training_course
// Params 1
// Checksum 0xc4111325, Offset: 0x3a89
// Size: 0x47, Type: bool
function function_e7096335df6c927d( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoleft( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) >= 0.8;
}

// Namespace common_training_course
// Params 1
// Checksum 0x8468276e, Offset: 0x3ad9
// Size: 0x47, Type: bool
function function_a6e3df72999a3b25( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoforward( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) <= -0.8;
}

// Namespace common_training_course
// Params 3
// Checksum 0x4743b2b0, Offset: 0x3b29
// Size: 0x32, Type: bool
function function_a2d8f930d2fa75a3( attacker, meansofdeath, weapon )
{
    return function_ea0c6158d187ce84( attacker ) && function_cd38eb9937fdb136( attacker );
}

// Namespace common_training_course
// Params 3
// Checksum 0x59120b52, Offset: 0x3b64
// Size: 0x32, Type: bool
function function_62aac7cf482ebf2e( attacker, meansofdeath, weapon )
{
    return function_ea0c6158d187ce84( attacker ) && function_e7096335df6c927d( attacker );
}

// Namespace common_training_course
// Params 3
// Checksum 0x54a19409, Offset: 0x3b9f
// Size: 0x32, Type: bool
function function_c61be9781ccb0a1a( attacker, meansofdeath, weapon )
{
    return function_ea0c6158d187ce84( attacker ) && function_a6e3df72999a3b25( attacker );
}

// Namespace common_training_course
// Params 1
// Checksum 0x7642a26d, Offset: 0x3bda
// Size: 0x18, Type: bool
function iscrouching( player )
{
    return player getstance() == "crouch";
}

// Namespace common_training_course
// Params 3
// Checksum 0xc0020c2f, Offset: 0x3bfb
// Size: 0x39, Type: bool
function function_d77cbbfc99789ed( attacker, meansofdeath, weapon )
{
    return !attacker player::isplayerads() && utility::getdamagetype( meansofdeath ) == "bullet";
}

// Namespace common_training_course
// Params 3
// Checksum 0x6d374954, Offset: 0x3c3d
// Size: 0x29, Type: bool
function function_d492e313412afcee( attacker, meansofdeath, weapon )
{
    return !function_d77cbbfc99789ed( attacker, meansofdeath, weapon );
}

// Namespace common_training_course
// Params 3
// Checksum 0x8c32c16b, Offset: 0x3c6f
// Size: 0x3c, Type: bool
function function_47a8618216dcc012( attacker, meansofdeath, weapon )
{
    return attacker getstance() == "prone" && utility::getdamagetype( meansofdeath ) == "bullet";
}

// Namespace common_training_course
// Params 3
// Checksum 0xa57ea11a, Offset: 0x3cb4
// Size: 0x40, Type: bool
function function_128f3ba64ecfc3c8( attacker, meansofdeath, weapon )
{
    return ( attacker isdiving() || attacker issprintsliding() ) && utility::getdamagetype( meansofdeath ) == "bullet";
}

// Namespace common_training_course
// Params 1
// Checksum 0x5d284705, Offset: 0x3cfd
// Size: 0x3f
function function_ed052c528d719ee6( player )
{
    level endon( #"tutorial_changed" );
    player.rcxd_vehicle waittill( #"death" );
    wait 1;
    player notify( #"rcxd_death" );
}

// Namespace common_training_course
// Params 1
// Checksum 0x55828d7, Offset: 0x3d44
// Size: 0x5d
function function_9117e58608e7d98d( player )
{
    level endon( #"tutorial_changed" );
    player endon( #"grenade_targets_dead" );
    
    while ( true )
    {
        player waittill( #"grenade_fire", grenade );
        wait 3.5;
        player equipment_mp::setequipmentslotammo( "primary", 1 );
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0xb16f005f, Offset: 0x3da9
// Size: 0x42, Type: bool
function function_9083a2f8cd56771e( attacker, meansofdeath, weapon )
{
    return isdefined( weapon ) && weapon.type == "grenade" && damage_effects::function_ae27c589e09c3181( meansofdeath );
}

// Namespace common_training_course
// Params 3
// Checksum 0xc57d7431, Offset: 0x3df4
// Size: 0x1f, Type: bool
function function_288b7a417884bf35( attacker, meansofdeath, weapon )
{
    return false;
}

// Namespace common_training_course
// Params 3
// Checksum 0x3bca957f, Offset: 0x3e1c
// Size: 0x42, Type: bool
function function_ea91c864e6fa597b( attacker, meansofdeath, weapon )
{
    return isdefined( weapon ) && weapon.basename == "rcxd" && damage_effects::function_ae27c589e09c3181( meansofdeath );
}

// Namespace common_training_course
// Params 1
// Checksum 0x1508f8f5, Offset: 0x3e67
// Size: 0x27
function rcxd_begin( rcxd )
{
    player = self;
    player.rcxd_vehicle = rcxd;
}

// Namespace common_training_course
// Params 1
// Checksum 0x36da051, Offset: 0x3e96
// Size: 0x24
function rcxd_end( rcxd )
{
    player = self;
    player.rcxd_vehicle = undefined;
}

// Namespace common_training_course
// Params 2
// Checksum 0xae7a5d7, Offset: 0x3ec2
// Size: 0x23
function supportbox_used( player, grenade )
{
    player.support_box = grenade;
}

// Namespace common_training_course
// Params 2
// Checksum 0x50b9992e, Offset: 0x3eed
// Size: 0x20
function supportbox_deleted( player, grenade )
{
    player.support_box = undefined;
}

// Namespace common_training_course
// Params 6
// Checksum 0xc152b746, Offset: 0x3f15
// Size: 0x9c
function createboxtrigger( owning_tutorial, origin, size, angles, var_cad029c2ab7a4f73 = undefined, var_42322f2afdbd8587 = undefined )
{
    trigger = spawn( "trigger_box", origin, 0, size * 0.5, size * 0.5 );
    trigger.trigger_size = size;
    trigger.angles = angles;
    function_2bc6e455359ea3f2( trigger, owning_tutorial, var_cad029c2ab7a4f73, var_42322f2afdbd8587 );
    return trigger;
}

// Namespace common_training_course
// Params 5
// Checksum 0x718ae8af, Offset: 0x3fba
// Size: 0x78
function function_4c7f1d74ec378cc9( owning_tutorial, origin, radius, var_cad029c2ab7a4f73 = undefined, var_42322f2afdbd8587 = undefined )
{
    trigger = spawn( "trigger_radius", origin, 0, radius, radius );
    trigger.radius = radius;
    function_2bc6e455359ea3f2( trigger, owning_tutorial, var_cad029c2ab7a4f73, var_42322f2afdbd8587 );
    return trigger;
}

// Namespace common_training_course
// Params 4
// Checksum 0x8780b69f, Offset: 0x403b
// Size: 0x6c
function function_2bc6e455359ea3f2( trigger, owning_tutorial, var_79d0387098c2d96a, var_42322f2afdbd8587 )
{
    trigger.var_cad029c2ab7a4f73 = var_79d0387098c2d96a;
    trigger.var_42322f2afdbd8587 = var_42322f2afdbd8587;
    trigger.owning_tutorial = owning_tutorial;
    trigger.debug_draw = 1;
    trigger.is_init_trigger = 0;
}

// Namespace common_training_course
// Params 2
// Checksum 0xb26ff000, Offset: 0x40af
// Size: 0xea
function function_a49fc858e731dcdb( tutorial, value )
{
    trigger = tutorial.init_trigger;
    function_44278d13f2543f10( trigger, value );
    
    if ( isdefined( trigger.chevrons ) )
    {
        function_1ba47b7678db87c3( trigger.chevrons, value ? "contested" : "off" );
    }
    
    if ( isdefined( trigger.flag ) )
    {
        if ( value )
        {
            trigger.flag show();
            trigger.flag sethintinoperable( 0 );
            level thread function_78ed747911e430e7( trigger.flag, tutorial );
            return;
        }
        
        function_bfd317f43b3fe8e3( trigger.flag );
        trigger.flag sethintinoperable( 1 );
        trigger.flag hide();
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0x6b2644c4, Offset: 0x41a1
// Size: 0x40
function function_44278d13f2543f10( trigger, value )
{
    /#
        trigger.debug_draw = value;
    #/
    
    if ( value )
    {
        trigger utility::trigger_on_proc();
        return;
    }
    
    trigger utility::trigger_off_proc();
}

// Namespace common_training_course
// Params 1
// Checksum 0xfb751555, Offset: 0x41e9
// Size: 0x39
function registertrigger( trigger )
{
    if ( !isdefined( level.registered_triggers ) )
    {
        level.registered_triggers = [];
    }
    
    level.registered_triggers[ level.registered_triggers.size ] = trigger;
}

// Namespace common_training_course
// Params 1
// Checksum 0x3f945963, Offset: 0x422a
// Size: 0xb3
function deregistertrigger( trigger_to_remove )
{
    foreach ( index, trigger in level.registered_triggers )
    {
        if ( trigger == trigger_to_remove )
        {
            trigger delete();
            trigger = undefined;
            level.registered_triggers[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( level.registered_triggers );
            }
            
            break;
        }
    }
}

// Namespace common_training_course
// Params 5
// Checksum 0x9838f983, Offset: 0x42e5
// Size: 0xc2
function function_5bda2610dad9e6e9( tutorial_name, origin, angles, size_min, size_max )
{
    trigger = spawn( "trigger_box", origin, 0, size_min, size_max );
    trigger.angles = angles;
    trigger.isdisabled = 1;
    
    if ( !isdefined( level.var_c03063b5f4fc2dde[ tutorial_name ] ) )
    {
        level.var_c03063b5f4fc2dde[ tutorial_name ] = [];
    }
    
    oob_array_size = level.var_c03063b5f4fc2dde[ tutorial_name ].size;
    level.var_c03063b5f4fc2dde[ tutorial_name ][ oob_array_size ] = trigger;
    level.outofboundstriggers[ level.outofboundstriggers.size ] = trigger;
}

// Namespace common_training_course
// Params 2
// Checksum 0xddb791b8, Offset: 0x43af
// Size: 0x100
function function_bb59f9b0bdf2d248( tutorial, value )
{
    tutorial_name = function_399e310dabe4c2cc( tutorial );
    
    if ( !isdefined( level.var_c03063b5f4fc2dde[ tutorial_name ] ) )
    {
        return;
    }
    
    foreach ( trigger in level.var_c03063b5f4fc2dde[ tutorial_name ] )
    {
        trigger.isdisabled = !value;
    }
    
    if ( isdefined( tutorial.oob_chevrons ) && tutorial.oob_chevrons.size > 0 )
    {
        function_1ba47b7678db87c3( tutorial.oob_chevrons, value ? "axis" : "off" );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x3b01a048, Offset: 0x44b7
// Size: 0x1da
function function_fb78e7c7ad8e2157( player )
{
    self notify( #"hash_aad33b4d88be1d2c" );
    self endon( #"hash_aad33b4d88be1d2c" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"enter_spectator_mode" );
    
    if ( isbot( player ) )
    {
        player endon( #"hash_27620d5c2e30b764" );
    }
    
    while ( true )
    {
        waitframe();
        
        if ( !player )
        {
            return;
        }
        
        if ( !isdefined( level.registered_triggers ) )
        {
            continue;
        }
        
        foreach ( trigger in level.registered_triggers )
        {
            if ( !isdefined( trigger ) || trigger.trigger_off )
            {
                continue;
            }
            
            tutorial = trigger.owning_tutorial;
            
            if ( player istouching( trigger ) )
            {
                if ( !trigger.player_in_trigger )
                {
                    if ( isdefined( trigger.var_cad029c2ab7a4f73 ) )
                    {
                        if ( trigger.is_init_trigger || function_d1d2cf69e63f6596( tutorial ) )
                        {
                            level thread [[ trigger.var_cad029c2ab7a4f73 ]]( player, tutorial );
                        }
                    }
                }
                
                trigger.player_in_trigger = 1;
                continue;
            }
            
            if ( trigger.player_in_trigger )
            {
                trigger.player_in_trigger = 0;
                
                if ( isdefined( trigger.var_42322f2afdbd8587 ) )
                {
                    if ( trigger.is_init_trigger || function_d1d2cf69e63f6596( tutorial ) )
                    {
                        level thread [[ trigger.var_42322f2afdbd8587 ]]( player, tutorial );
                    }
                }
            }
        }
    }
}

/#

    // Namespace common_training_course
    // Params 0
    // Checksum 0xbec61edd, Offset: 0x4699
    // Size: 0xd1, Type: dev
    function function_833acbbe64353915()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( isdefined( level.registered_triggers ) )
            {
                foreach ( trigger in level.registered_triggers )
                {
                    if ( trigger.debug_draw )
                    {
                        if ( getdvarint( @"hash_c01ca8e4931f5a75", 0 ) == 1 )
                        {
                            drawtrigger( trigger, ( 1, 0, 0 ), 0, 1, 0 );
                        }
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace common_training_course
    // Params 0
    // Checksum 0x6cf07b15, Offset: 0x4772
    // Size: 0x13f, Type: dev
    function function_893ed490f765fc47()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_f9119320cacb3f8c", 0 ) == 0 )
            {
                continue;
            }
            
            if ( !isdefined( level.var_c03063b5f4fc2dde ) )
            {
                continue;
            }
            
            foreach ( trigger_array in level.var_c03063b5f4fc2dde )
            {
                foreach ( trigger in trigger_array )
                {
                    if ( !trigger.disabled )
                    {
                        drawtrigger( trigger, ( 1, 0, 0 ), 0, 1, 0 );
                    }
                }
            }
        }
    }

#/

// Namespace common_training_course
// Params 1
// Checksum 0xabc49d80, Offset: 0x48b9
// Size: 0x1ec, Type: bool
function function_b2c44c2beeec92ac( targets_to_spawn )
{
    if ( !isdefined( level.world_target_array ) )
    {
        level.world_target_array = [];
    }
    
    if ( !isdefined( level.var_2e61ab2b37d9ba6f ) )
    {
        level.var_2e61ab2b37d9ba6f = [];
    }
    else if ( level.var_2e61ab2b37d9ba6f.size != 0 )
    {
        return false;
    }
    
    foreach ( target_array in targets_to_spawn )
    {
        var_95f80e24c6f710b0 = target_array[ 0 ];
        target_type = target_array[ 1 ];
        origin = target_array[ 2 ];
        angles = target_array[ 3 ];
        target = undefined;
        
        if ( target_type == 1 )
        {
            target = function_139b993fdeb62430( origin, angles );
        }
        else if ( target_type == 2 )
        {
            target = function_bc605a7bf950fe4( origin, angles, -40 );
        }
        
        if ( isdefined( target ) )
        {
            function_374d87d39fc4b28f( target );
            
            foreach ( group_name in var_95f80e24c6f710b0 )
            {
                if ( !isdefined( level.var_2e61ab2b37d9ba6f[ group_name ] ) )
                {
                    level.var_2e61ab2b37d9ba6f[ group_name ] = [];
                }
                
                level.var_2e61ab2b37d9ba6f[ group_name ][ level.var_2e61ab2b37d9ba6f[ group_name ].size ] = target;
                level.world_target_array[ level.world_target_array.size ] = target;
            }
        }
    }
    
    return true;
}

// Namespace common_training_course
// Params 0
// Checksum 0x7990c931, Offset: 0x4aae
// Size: 0x7b
function function_2125c1ceca157ae2()
{
    foreach ( target in level.world_target_array )
    {
        function_ed7e4e390edfa669( target );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0xbe98943f, Offset: 0x4b31
// Size: 0x94
function function_2d02218ae92b9b9a( var_90f374dcdee2f09e )
{
    foreach ( target in level.world_target_array )
    {
        function_374d87d39fc4b28f( target );
        
        if ( var_90f374dcdee2f09e )
        {
            function_dfda46466478db2a( target, undefined );
        }
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0x5449c7fc, Offset: 0x4bcd
// Size: 0xc3
function function_1852fc4473135ca4( targetgroup_name, var_9360681aa67fb3d9 = undefined )
{
    targets = level.var_2e61ab2b37d9ba6f[ targetgroup_name ];
    
    foreach ( target in targets )
    {
        target_goup( target );
        target_enableoutline( target );
        target setcandamage( 1 );
        function_dfda46466478db2a( target, var_9360681aa67fb3d9 );
    }
    
    return targets;
}

// Namespace common_training_course
// Params 1
// Checksum 0x211f71ff, Offset: 0x4c99
// Size: 0xb1
function function_70bfc41268e6eb1d( targetgroup_name )
{
    targets = level.var_2e61ab2b37d9ba6f[ targetgroup_name ];
    
    foreach ( target in targets )
    {
        function_42c5592ce8a29c26( target );
        target_disableoutline( target );
        target setcandamage( 0 );
        function_dfda46466478db2a( target, undefined );
    }
    
    return targets;
}

// Namespace common_training_course
// Params 2
// Checksum 0x8e08c66e, Offset: 0x4d53
// Size: 0xfb
function function_dd238173cc767f87( targetgroup_name, amount = undefined )
{
    level endon( #"game_ended" );
    level endon( #"tutorial_changed" );
    targets = level.var_2e61ab2b37d9ba6f[ targetgroup_name ];
    var_d998843bd69bb6ff = [];
    
    for ( i = 0; i < targets.size ; i++ )
    {
        if ( !targets[ i ] getcandamage() )
        {
            var_d998843bd69bb6ff[ i ] = 1;
        }
    }
    
    if ( var_d998843bd69bb6ff.size == targets.size )
    {
        self notify( #"targets_dead" );
        return;
    }
    
    while ( true )
    {
        targets_dead = 0;
        
        for ( i = 0; i < targets.size ; i++ )
        {
            if ( !var_d998843bd69bb6ff[ i ] && !targets[ i ] getcandamage() )
            {
                targets_dead++;
            }
        }
        
        if ( targets_dead == targets.size - var_d998843bd69bb6ff.size || targets_dead >= amount )
        {
            self notify( #"targets_dead" );
            break;
        }
        
        waitframe();
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0x7992784a, Offset: 0x4e56
// Size: 0x1f6
function function_139b993fdeb62430( origin, angles, health = 300 )
{
    var_c9d386cb6d4f8f03 = 32;
    target = spawn( "script_model", origin );
    target function_b398682b38f521f5( 1 );
    target.angles = angles;
    target setmodel( "t10_machinery_shooting_target" );
    target.health = health;
    target.maxhealth = health;
    target.type = 1;
    target.var_7972880ea8fb5b4c = 1;
    target.attached_models = [];
    target.standing_state = -1;
    
    if ( "" != "" )
    {
        arm = spawn( "script_model", origin );
        arm notsolid();
        target function_b398682b38f521f5( 1 );
        arm.angles = angles;
        arm setmodel( "" );
        arm linkto( target );
        target.attached_models[ target.attached_models.size ] = arm;
    }
    
    forward = vectornormalize( anglestoforward( angles + ( 0, 90, 0 ) ) );
    rail_x = origin[ 0 ] + var_c9d386cb6d4f8f03 * forward[ 0 ];
    rail_y = origin[ 1 ] + var_c9d386cb6d4f8f03 * forward[ 1 ];
    rail_z = origin[ 2 ] + 1;
    rail = spawn( "script_model", ( rail_x, rail_y, rail_z ) );
    rail notsolid();
    target function_b398682b38f521f5( 1 );
    rail.angles = angles;
    rail setmodel( "ee_military_shooting_range_rail" );
    target.attached_models[ target.attached_models.size ] = rail;
    target_goup( target );
    return target;
}

// Namespace common_training_course
// Params 4
// Checksum 0x309ec4e8, Offset: 0x5055
// Size: 0xb5
function function_bc605a7bf950fe4( origin, angles, z_offset = 0, health = 300 )
{
    origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + z_offset );
    target = spawn( "script_model", origin );
    target.angles = angles;
    target setmodel( "ee_military_shooting_range_target_clay_circle" );
    target.health = health;
    target.maxhealth = health;
    target.type = 2;
    target.var_7972880ea8fb5b4c = 1;
    return target;
}

// Namespace common_training_course
// Params 1
// Checksum 0xd0f94cf, Offset: 0x5113
// Size: 0x99
function target_delete( target )
{
    foreach ( model in target.attached_models )
    {
        model delete();
    }
    
    target.attached_models = [];
    target delete();
}

// Namespace common_training_course
// Params 2
// Checksum 0x7dda32d7, Offset: 0x51b4
// Size: 0xf4
function function_42c5592ce8a29c26( target, backwards = 1 )
{
    if ( isdefined( target.pingmarker ) )
    {
        target.pingmarker.alpha = 0;
    }
    
    if ( target.type == 2 )
    {
        return 0;
    }
    
    anim_time = 0;
    
    if ( target.standing_state === 1 )
    {
        anim_time = 0.2;
        pitch = backwards ? -90 : 90;
        target rotateto( target.angles + ( pitch, 0, 0 ), anim_time );
        playsoundatpos( target.origin + ( 0, 0, 10 ), "amb_emt_t10_training_course_target_down" );
        target.down_pitch = pitch;
    }
    
    target disableaimassist();
    target.standing_state = 2;
    return anim_time;
}

// Namespace common_training_course
// Params 1
// Checksum 0x31a8160e, Offset: 0x52b1
// Size: 0xcb
function target_goup( target )
{
    if ( isdefined( target.pingmarker ) )
    {
        target.pingmarker.alpha = 1;
    }
    
    if ( target.type == 2 )
    {
        return 0;
    }
    
    anim_time = 0;
    
    if ( target.standing_state === 2 )
    {
        anim_time = 0.3;
        target rotateto( target.angles + ( target.down_pitch * -1, 0, 0 ), anim_time );
        playsoundatpos( target.origin + ( 0, 0, 10 ), "amb_emt_t10_training_course_target_up" );
    }
    
    target enableaimassist();
    target.standing_state = 1;
    return anim_time;
}

// Namespace common_training_course
// Params 1
// Checksum 0xa6501a87, Offset: 0x5385
// Size: 0x38
function target_enableoutline( target )
{
    if ( !isdefined( target.outline_id ) )
    {
        target.outline_id = outline::outlineenableforall( target, "outline_nodepth_red", "level_script" );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x27ad8f08, Offset: 0x53c5
// Size: 0x3a
function target_disableoutline( target )
{
    if ( isdefined( target.outline_id ) )
    {
        outline::outlinedisable( target.outline_id, target );
        target.outline_id = undefined;
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0x2af830b0, Offset: 0x5407
// Size: 0x23
function function_dfda46466478db2a( target, var_78a357bb27545fd4 )
{
    target.ondamagevalidation = var_78a357bb27545fd4;
}

// Namespace common_training_course
// Params 1
// Checksum 0x4dc0de8a, Offset: 0x5432
// Size: 0x55
function function_374d87d39fc4b28f( target )
{
    target notify( #"hash_4f194e6fc0613101" );
    target_goup( target );
    target_disableoutline( target );
    target setcandamage( 1 );
    target.health = target.maxhealth;
    level thread function_71a7c54086f9cd2c( target );
}

// Namespace common_training_course
// Params 2
// Checksum 0x95542a1a, Offset: 0x548f
// Size: 0x6b
function function_ed7e4e390edfa669( target, var_79a79be0f58aae7f = 1 )
{
    target notify( #"enter_tutorial_mode" );
    target setcandamage( 0 );
    function_42c5592ce8a29c26( target, 0 );
    target_disableoutline( target );
    target.var_79a79be0f58aae7f = var_79a79be0f58aae7f;
    target.var_6615e137ca2bc970 = 0;
    level thread function_1980abc5d9a71f67( target );
}

// Namespace common_training_course
// Params 1
// Checksum 0x663cdc8f, Offset: 0x5502
// Size: 0x169
function function_71a7c54086f9cd2c( target )
{
    level endon( #"game_ended" );
    target endon( #"delete" );
    target endon( #"enter_tutorial_mode" );
    
    while ( true )
    {
        target waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath );
        var_cb531b3fd6432802 = function_7cef94a8490b6371( attacker.angles, target.angles );
        
        if ( !target.var_7972880ea8fb5b4c && var_cb531b3fd6432802 && utility::getdamagetype( meansofdeath ) == "bullet" )
        {
            continue;
        }
        
        target.health -= damage;
        is_dead = target.health <= 0;
        showhitmarker( attacker, target, is_dead );
        
        if ( is_dead )
        {
            target notify( #"death" );
            target setcandamage( 0 );
            function_42c5592ce8a29c26( target, !var_cb531b3fd6432802 );
            wait 1.5;
            anim_time = target_goup( target );
            wait anim_time;
            target setcandamage( 1 );
            target.health = target.maxhealth;
        }
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x1daf650e, Offset: 0x5673
// Size: 0x1e8
function function_1980abc5d9a71f67( target )
{
    level endon( #"game_ended" );
    target endon( #"delete" );
    target endon( #"hash_4f194e6fc0613101" );
    
    while ( true )
    {
        target waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, var_7edd83e15d43a9b0 );
        
        if ( damage_effects::function_1e948faff668cf2( meansofdeath ) )
        {
            continue;
        }
        
        if ( isdefined( target.ondamagevalidation ) && ![[ target.ondamagevalidation ]]( attacker, meansofdeath, weapon ) )
        {
            target playsound( "uin_t10_training_course_target_fail" );
            continue;
        }
        
        var_cb531b3fd6432802 = function_7cef94a8490b6371( attacker.angles, target.angles );
        
        if ( !target.var_7972880ea8fb5b4c && var_cb531b3fd6432802 && utility::getdamagetype( meansofdeath ) == "bullet" )
        {
            continue;
        }
        
        target.var_6615e137ca2bc970++;
        is_dead = target.var_6615e137ca2bc970 >= target.var_79a79be0f58aae7f;
        showhitmarker( attacker, target, is_dead );
        
        if ( is_dead )
        {
            target notify( #"death" );
            target setcandamage( 0 );
            function_42c5592ce8a29c26( target, !var_cb531b3fd6432802 );
            target_disableoutline( target );
            target playsound( "uin_t10_training_course_target_success" );
            target.var_6615e137ca2bc970 = 0;
        }
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0xa43f6353, Offset: 0x5863
// Size: 0x60
function function_7cef94a8490b6371( attacker_angles, target_angles )
{
    attacker_forward = vectornormalize( anglestoforward( attacker_angles ) );
    target_forward = vectornormalize( anglestoforward( target_angles ) );
    damage_dot_product = vectordot( attacker_forward, target_forward );
    is_behind_target = damage_dot_product >= 0;
    return is_behind_target;
}

// Namespace common_training_course
// Params 3
// Checksum 0x5c4f36b7, Offset: 0x58cc
// Size: 0x6b
function showhitmarker( attacker, victim, is_dead )
{
    attacker damagefeedback::updatehitmarker( "standard", is_dead, 0, 0, undefined, undefined, undefined, undefined, 1, undefined, 1 );
    attacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", is_dead ? 1 : 0, { #victimentity:victim } );
}

// Namespace common_training_course
// Params 5
// Checksum 0x297cbe13, Offset: 0x593f
// Size: 0x157
function function_c2bdaa68bf39d803( chevron_type, var_fb035a7b0ad53750, perimeter_vertices, var_7e40d40f67122c1b = 1, var_73d12631951e4c7b = 0 )
{
    if ( perimeter_vertices.size < 3 )
    {
        assertmsg( "<dev string:x14a>" );
        return [];
    }
    
    inward_normals = function_bfd4538e73b78d19( perimeter_vertices, 1 );
    chevrons = [];
    
    for ( i = 0; i < perimeter_vertices.size ; i++ )
    {
        if ( !var_7e40d40f67122c1b && i == perimeter_vertices.size - 1 )
        {
            break;
        }
        
        middle_vector = ( inward_normals[ i ] + inward_normals[ ( i + 1 ) % inward_normals.size ] ) * 0.5;
        var_200af70048253636 = ( 0, vectortoangles( middle_vector )[ 1 ], 0 );
        var_9dfd5783fe0e619b = !var_7e40d40f67122c1b && i == 0 ? 0 : 1;
        chevron_line = function_81f25287b76e02b2( chevron_type, var_fb035a7b0ad53750, perimeter_vertices[ i ], perimeter_vertices[ ( i + 1 ) % perimeter_vertices.size ], vectortoangles( inward_normals[ i ] ), var_200af70048253636, var_73d12631951e4c7b, var_9dfd5783fe0e619b );
        chevrons = arraycombine( chevrons, chevron_line );
    }
    
    /#
        if ( getdvarint( @"hash_116be81c99e1c527", 0 ) == 1 )
        {
            level thread function_5510c4ea1694380d( perimeter_vertices, inward_normals );
        }
    #/
    
    return chevrons;
}

// Namespace common_training_course
// Params 5
// Checksum 0xa9794490, Offset: 0x5a9f
// Size: 0xd5
function function_a017d1ec37595fa( chevron_type, circle_origin, radius, step_size, var_ef43d1064d479fdd = 0 )
{
    circle_vertices = plotcircle( circle_origin, radius, step_size );
    chevrons = [];
    
    for ( i = 0; i < circle_vertices.size ; i++ )
    {
        direction = undefined;
        
        if ( var_ef43d1064d479fdd )
        {
            direction = circle_origin - circle_vertices[ i ];
        }
        else
        {
            direction = circle_vertices[ i ] - circle_origin;
        }
        
        angles = vectortoangles( direction );
        chevron = spawnscriptable( chevron_type, circle_vertices[ i ], angles );
        chevron setscriptablepartstate( "chevron_0", "contested" );
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace common_training_course
// Params 8
// Checksum 0x24a81548, Offset: 0x5b7d
// Size: 0x180
function function_81f25287b76e02b2( chevron_type, var_fb035a7b0ad53750, start_origin, end_origin, angles, var_9d537a9ea9d659bf = undefined, heightaboveground = 0, var_9dfd5783fe0e619b = 0 )
{
    if ( !isdefined( var_9d537a9ea9d659bf ) )
    {
        var_9d537a9ea9d659bf = angles;
    }
    
    direction = vectornormalize( end_origin - start_origin );
    point_distance = distance( end_origin, start_origin );
    var_599cbf71370a2947 = int( ceil( point_distance / var_fb035a7b0ad53750 ) );
    var_c413de20b2897373 = point_distance / var_599cbf71370a2947;
    chevrons = [];
    
    for ( i = var_9dfd5783fe0e619b ? 1 : 0; i < var_599cbf71370a2947 + 1 ; i++ )
    {
        x = start_origin[ 0 ] + var_c413de20b2897373 * i * direction[ 0 ];
        y = start_origin[ 1 ] + var_c413de20b2897373 * i * direction[ 1 ];
        z = start_origin[ 2 ];
        origin = getgroundposition( ( x, y, z ), 5 );
        origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + heightaboveground );
        chevron = spawnscriptable( chevron_type, origin, i == var_599cbf71370a2947 ? var_9d537a9ea9d659bf : angles );
        chevron setscriptablepartstate( "chevron_0", "idle" );
        chevrons[ chevrons.size ] = chevron;
    }
    
    return chevrons;
}

// Namespace common_training_course
// Params 5
// Checksum 0x47d1b806, Offset: 0x5d06
// Size: 0xee
function function_871cc06a4aaadaf5( tutorial, var_fb035a7b0ad53750, chevrons_vertices, angles = ( 0, 0, 0 ), var_7e40d40f67122c1b = 0 )
{
    if ( chevrons_vertices.size < 2 )
    {
        assertmsg( "<dev string:x184>" );
        return;
    }
    
    chevrons = undefined;
    
    if ( chevrons_vertices.size == 2 )
    {
        chevrons = function_81f25287b76e02b2( "cer_gamemode_chevron", var_fb035a7b0ad53750, chevrons_vertices[ 0 ], chevrons_vertices[ 1 ], angles );
    }
    else
    {
        chevrons = function_c2bdaa68bf39d803( "cer_gamemode_chevron", var_fb035a7b0ad53750, chevrons_vertices, var_7e40d40f67122c1b );
    }
    
    function_1ba47b7678db87c3( chevrons, "off" );
    
    if ( !isdefined( tutorial.oob_chevrons ) )
    {
        tutorial.oob_chevrons = [];
    }
    
    tutorial.oob_chevrons = arraycombine( tutorial.oob_chevrons, chevrons );
}

// Namespace common_training_course
// Params 1
// Checksum 0x897bd8ca, Offset: 0x5dfc
// Size: 0x81
function deletechevrons( chevron_array )
{
    foreach ( chevron in chevron_array )
    {
        chevron freescriptable();
    }
    
    chevron_array = [];
    return chevron_array;
}

// Namespace common_training_course
// Params 2
// Checksum 0x3c4a5094, Offset: 0x5e86
// Size: 0xb0
function function_1ba47b7678db87c3( chevron_array, state )
{
    if ( !isdefined( chevron_array ) )
    {
        return;
    }
    
    if ( chevron_array.size > 0 && chevron_array[ 0 ] getscriptablepartstate( "chevron_0" ) == state )
    {
        return;
    }
    
    foreach ( chevron in chevron_array )
    {
        chevron setscriptablepartstate( "chevron_0", state );
    }
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x71fffddc, Offset: 0x5f3e
// Size: 0x131
function private function_bfd4538e73b78d19( vertices, var_5dbb6ff207c17611 )
{
    normals = [];
    centroid = ( 0, 0, 0 );
    
    foreach ( vertex in vertices )
    {
        centroid += vertex;
    }
    
    centroid /= vertices.size;
    
    for ( i = 0; i < vertices.size ; i++ )
    {
        edgevector = vertices[ ( i + 1 ) % vertices.size ] - vertices[ i ];
        normal = ( edgevector[ 1 ] * -1, edgevector[ 0 ], 0 );
        toedge = vertices[ i ] - centroid;
        
        if ( var_5dbb6ff207c17611 && vectordot( toedge, normal ) > 0 )
        {
            normal *= -1;
        }
        
        normal = vectornormalize2( normal );
        normals[ normals.size ] = normal;
    }
    
    return normals;
}

// Namespace common_training_course
// Params 3, eflags: 0x4
// Checksum 0x3f18e3a8, Offset: 0x6078
// Size: 0xe4
function private plotcircle( center_origin, radius, step_size )
{
    pi = 3.14159;
    centerx = center_origin[ 0 ];
    centery = center_origin[ 1 ];
    circle_vertices = [];
    theta = 0;
    
    while ( theta <= 2 * pi )
    {
        radians = theta * 180 / pi;
        x = round( centerx + radius * cos( radians ) );
        y = round( centery + radius * sin( radians ) );
        z = center_origin[ 2 ];
        origin = getgroundposition( ( x, y, z ), 5 );
        circle_vertices[ circle_vertices.size ] = origin;
        theta += step_size;
    }
    
    return circle_vertices;
}

/#

    // Namespace common_training_course
    // Params 2, eflags: 0x4
    // Checksum 0x27d6dc2a, Offset: 0x6165
    // Size: 0x114, Type: dev
    function private function_5510c4ea1694380d( perimeter_vertices, normals )
    {
        while ( true )
        {
            for ( i = 0; i < perimeter_vertices.size ; i++ )
            {
                sphere( perimeter_vertices[ i ], 5, ( 0, 1, 0 ), 0, 1 );
                print3d( perimeter_vertices[ i ], string( i ), ( 1, 0, 0 ), 1, 1, 1, 1 );
                
                if ( i < perimeter_vertices.size - 1 )
                {
                    line( perimeter_vertices[ i ], perimeter_vertices[ i + 1 ], ( 1, 0, 0 ), 1, 0, 1 );
                }
            }
            
            if ( perimeter_vertices.size > 1 )
            {
                line( perimeter_vertices[ perimeter_vertices.size - 1 ], perimeter_vertices[ 0 ], ( 1, 0, 0 ), 1, 0, 1 );
            }
            
            for ( i = 0; i < normals.size ; i++ )
            {
                normal = normals[ i ];
                utility::draw_arrow( perimeter_vertices[ i ], perimeter_vertices[ i ] + normal * 50, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace common_training_course
    // Params 1, eflags: 0x4
    // Checksum 0x5fbcefa4, Offset: 0x6281
    // Size: 0xdb, Type: dev
    function private function_347c90461fb33c06( player )
    {
        level thread namespace_a4e869218d89862b::function_18eb5a324873d647( player, 0 );
        level thread namespace_6826532b84b72321::function_eccd82ae06166efe( player, 1 );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x1c4>", "<dev string:x1d0>", &maprestart, [ "<dev string:x1e6>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x1e9>", "<dev string:x1d0>", &benchmark_mp_utils::function_6f4cc32a47b35564, [ "<dev string:x1f7>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x1f9>", "<dev string:x1d0>", &benchmark_mp_utils::function_6d90b52e7f66709a, [ "<dev string:x214>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x21b>", "<dev string:x1d0>", &benchmark_mp_utils::function_6cf247353c5bcf3, [ "<dev string:x23b>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x241>", "<dev string:x1d0>", &benchmark_mp_utils::function_a7dd34380de169ca );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x255>", "<dev string:x1d0>", &benchmark_mp_utils::function_6d778e3befe26811 );
        benchmark_mp_utils::function_abeeb86ec4c08184( player );
    }

    // Namespace common_training_course
    // Params 1, eflags: 0x4
    // Checksum 0x1c68e223, Offset: 0x6364
    // Size: 0xcf, Type: dev
    function private initdevgui( tutorial_dictionary )
    {
        devgui::function_9082edeb5db93280( "<dev string:x265>" );
        
        foreach ( tutorial in tutorial_dictionary )
        {
            tutorial_name = function_399e310dabe4c2cc( tutorial );
            devgui::function_cd4e263c1f3018ae( "<dev string:x27e>" + tutorial_name, "<dev string:x28b>" + tutorial_name, &function_97c3481032bc4794 );
        }
        
        devgui::add_devgui_func( "<dev string:x295>", "<dev string:x2ae>", &function_cb340780657742e0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace common_training_course
    // Params 1, eflags: 0x4
    // Checksum 0xe27d326e, Offset: 0x643b
    // Size: 0x7f, Type: dev
    function private function_97c3481032bc4794( params )
    {
        if ( !isdefined( level.player ) )
        {
            return;
        }
        
        tutorial_name = string( params[ 0 ] );
        tutorial = level.tutorial_dictionary[ tutorial_name ];
        
        if ( isdefined( tutorial ) )
        {
            level.player setorigin( tutorial.respawn_position );
            level.player setplayerangles( tutorial.respawn_angles );
        }
    }

    // Namespace common_training_course
    // Params 0, eflags: 0x4
    // Checksum 0xe0b89c4c, Offset: 0x64c2
    // Size: 0x39, Type: dev
    function private function_cb340780657742e0()
    {
        if ( isdefined( level.current_tutorial ) && isdefined( level.player ) )
        {
            level thread completetutorial( level.player, level.current_tutorial );
        }
    }

    // Namespace common_training_course
    // Params 0, eflags: 0x4
    // Checksum 0x21ff8ad4, Offset: 0x6503
    // Size: 0xf, Type: dev
    function private maprestart()
    {
        adddebugcommand( "<dev string:x2c7>" );
    }

    // Namespace common_training_course
    // Params 1, eflags: 0x4
    // Checksum 0xd88697eb, Offset: 0x651a
    // Size: 0xc2, Type: dev
    function private function_7464143c7de6c610( var_f79acce8d463b5d0 )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( index, target_info in var_f79acce8d463b5d0 )
            {
                origin = target_info[ 2 ];
                print3d( origin, "<dev string:x2d4>" + index + 1, ( 0, 1, 0 ), 1, 1, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace common_training_course
    // Params 3, eflags: 0x4
    // Checksum 0x46c4d9f2, Offset: 0x65e4
    // Size: 0x92, Type: dev
    function private debug_printlines( lines, var_cd7d60ade8b84f2c, var_e1491a27593d8f5a )
    {
        for ( i = 0; i < lines.size ; i++ )
        {
            if ( var_cd7d60ade8b84f2c )
            {
                debug::print3d( var_e1491a27593d8f5a, lines[ i ], ( 0, 1, 0 ), 5, undefined, undefined, 1, 0.6, 75 );
                wait 5;
                continue;
            }
            
            debug::function_16b0d1fbf9c99e98( 500, 200, lines[ i ], 5, ( 0, 0, 0 ), 2.5 );
        }
    }

    // Namespace common_training_course
    // Params 0
    // Checksum 0xaea6cbda, Offset: 0x667e
    // Size: 0x99, Type: dev
    function function_10cc2b82142318c3()
    {
        tutorials = [];
        
        foreach ( tutorial in level.tutorial_dictionary )
        {
            if ( isdefined( tutorial.var_fe1e173811f47789 ) )
            {
                tutorials[ tutorials.size ] = tutorial;
            }
        }
        
        return tutorials;
    }

#/

// Namespace common_training_course
// Params 3
// Checksum 0x2d95f66, Offset: 0x671f
// Size: 0x74
function function_bf3e729263fcc10( bot, agent, initial_wait_time )
{
    level endon( #"tutorial_changed" );
    bot endon( #"death" );
    agent endon( #"death" );
    wait initial_wait_time;
    fire_time = weaponfiretime( bot getcurrentweapon() );
    
    while ( true )
    {
        bot botpressbutton( "attack" );
        wait fire_time;
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0x4953366e, Offset: 0x679b
// Size: 0xae
function function_e746921138a76a2a( bot, agent )
{
    level endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    agent endon( #"death" );
    
    while ( true )
    {
        bot botlookatpoint( agent.origin + ( 0, 0, 50 ), 0.1, "script_forced" );
        trace = trace::ray_trace( bot geteye(), agent geteye(), bot, undefined );
        
        if ( trace[ "entity" ] === agent )
        {
            bot notify( #"agent_in_view" );
        }
        
        wait 0.1;
    }
}

// Namespace common_training_course
// Params 0
// Checksum 0x88626d51, Offset: 0x6851
// Size: 0xb
function function_729244fb63340d85()
{
    return level.var_18989a0b903e5305;
}

// Namespace common_training_course
// Params 0, eflags: 0x4
// Checksum 0x846f1862, Offset: 0x6865
// Size: 0x7e
function private function_c8702ddd4540ea28()
{
    foreach ( bot in level.var_5905435b6e06af6a )
    {
        if ( isalive( bot ) )
        {
            return bot;
        }
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0xa02becb8, Offset: 0x68ec
// Size: 0xa6
function spawnbot( origin, angles, team = "allies" )
{
    fixedspawndata = spawnstruct();
    fixedspawndata.origin = origin;
    fixedspawndata.angles = angles;
    level thread [[ level.bot_funcs[ "bots_spawn" ] ]]( 1, team, undefined, undefined, undefined, undefined, fixedspawndata );
    
    do
    {
        level waittill( #"player_spawned", newai );
    }
    while ( !isbot( newai ) );
    
    newai setorigin( origin );
    newai setplayerangles( angles );
    return newai;
}

// Namespace common_training_course
// Params 1
// Checksum 0x9bcb90b9, Offset: 0x699b
// Size: 0xde
function function_f84dc38c3e66bb65( bot )
{
    bot sethidenameplate( 1 );
    bot botsetpathingstyle( "scripted" );
    bot botsetawareness( 0 );
    bot botsetstance( "stand" );
    bot botsetflag( "force_sprint", 1 );
    bot.personality_update_function = &utility::empty_init_func;
    bot.sessionstate = "playing";
    bot.skipspawncamera = 1;
    bot.ignoreall = 1;
    bot botsetflag( "disable_movement", 1 );
    bot botsetflag( "disable_rotation", 1 );
    bot botsetflag( "dont_path_to_enemy", 1 );
    bot botsetflag( "disable_random_goal", 1 );
    bot botsetflag( "no_enemy_search", 1 );
    bot botsetscriptmove( 0, 0, 1 );
    bot botlookatpoint( undefined );
}

// Namespace common_training_course
// Params 1
// Checksum 0x45dd1037, Offset: 0x6a81
// Size: 0x18, Type: bool
function function_1acdd48d868bc909( bot )
{
    return istrue( bot.is_meatshield_bot );
}

// Namespace common_training_course
// Params 1
// Checksum 0x9b482a0e, Offset: 0x6aa2
// Size: 0xd7
function function_71f1e02bbc6761a2( var_92e92ae4a06e5cd8 )
{
    marker = gameobjects::createobjidobject( ( 0, 0, 0 ), "neutral", ( 0, 0, 0 ), undefined, "any", 1, "icon_medium" );
    objidpoolmanager::update_objective_icon( marker.objidnum, var_92e92ae4a06e5cd8 ?? "icon_waypoint_sp_generic" );
    objidpoolmanager::update_objective_setbackground( marker.objidnum, 0 );
    objidpoolmanager::function_373aaf492aabde6f( marker.objidnum, 0, 0, 0, 1 );
    objidpoolmanager::function_de3fb937d4f45f38( marker.objidnum, 150, 75 );
    objidpoolmanager::objective_set_play_intro( marker.objidnum, 0 );
    objidpoolmanager::objective_set_play_outro( marker.objidnum, 0 );
    hideobjectivemarker( marker );
    return marker;
}

// Namespace common_training_course
// Params 3
// Checksum 0x72c4e177, Offset: 0x6b82
// Size: 0xf4
function function_8becb86703380fc7( tutorial, var_bc057f2eb5601c58, var_3d8b9a40a0d8353b )
{
    trigger = tutorial.init_trigger;
    
    if ( isdefined( trigger.objective_marker ) )
    {
        if ( var_bc057f2eb5601c58 )
        {
            objidpoolmanager::objective_playermask_showtoall( trigger.objective_marker.objidnum );
            objective_state( trigger.objective_marker.objidnum, var_3d8b9a40a0d8353b ? "current" : "invisible" );
            return;
        }
        
        if ( !var_3d8b9a40a0d8353b )
        {
            objidpoolmanager::objective_playermask_hidefromall( trigger.objective_marker.objidnum );
            return;
        }
        
        objidpoolmanager::objective_playermask_showtoall( trigger.objective_marker.objidnum );
        objective_state( trigger.objective_marker.objidnum, "active" );
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0xff29456f, Offset: 0x6c7e
// Size: 0x44
function function_a6e8c085165e0898( player, cached_string_ref, objective_type )
{
    if ( isdefined( player ) )
    {
        player setclientomnvar( "training_course_current_objective_string_index", getlocstringindex( cached_string_ref ) );
        player setclientomnvar( "training_course_current_objective_type", objective_type );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x249279ab, Offset: 0x6cca
// Size: 0x2e
function function_5e3e773127f754db( player )
{
    if ( isdefined( player ) )
    {
        player setclientomnvar( "training_course_current_objective_string_index", -1 );
        player setclientomnvar( "training_course_current_objective_type", -1 );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x8020050d, Offset: 0x6d00
// Size: 0x1a, Type: bool
function function_1c1639bf73457e80( player )
{
    return player getclientomnvar( "training_course_current_objective_string_index" ) != -1;
}

// Namespace common_training_course
// Params 3
// Checksum 0xbf03d2fb, Offset: 0x6d23
// Size: 0x72
function showobjectivemarker( player, objective_marker, origin )
{
    if ( !isdefined( origin ) )
    {
        assertmsg( "<dev string:x2de>" );
        return;
    }
    
    objidpoolmanager::update_objective_position( objective_marker.objidnum, origin );
    objidpoolmanager::objective_playermask_showtoall( objective_marker.objidnum );
    objective_marker.origin = origin;
    level thread function_9099e762beedc948( player, objective_marker );
}

// Namespace common_training_course
// Params 1
// Checksum 0x7cefdc6d, Offset: 0x6d9d
// Size: 0x2b
function hideobjectivemarker( objective_marker )
{
    objidpoolmanager::objective_playermask_hidefromall( objective_marker.objidnum );
    objective_marker notify( #"hidden" );
}

// Namespace common_training_course
// Params 0
// Checksum 0x9297f47f, Offset: 0x6dd0
// Size: 0xb
function function_6cc6415c4c311662()
{
    return level.global_objective_marker;
}

// Namespace common_training_course
// Params 4
// Checksum 0xbe14cbef, Offset: 0x6de4
// Size: 0x8c
function function_7107038b2232bbb2( player, objective_marker, waypoint_position, var_2194257a90af9f5c = undefined )
{
    if ( function_124de228f3c03556( player, waypoint_position ) )
    {
        return;
    }
    
    function_a6e8c085165e0898( player, var_2194257a90af9f5c ?? &"t10_training_course/next_objective", 3 );
    showobjectivemarker( player, objective_marker, waypoint_position );
    objective_marker waittill( #"hash_fc0d26dcd2b34574" );
    hideobjectivemarker( objective_marker );
    function_5e3e773127f754db( player );
    player playsound( "uin_t10_training_course_objective_success" );
}

// Namespace common_training_course
// Params 3
// Checksum 0x49734365, Offset: 0x6e78
// Size: 0x9d
function function_9099e762beedc948( player, objective_marker, var_e620d5604e2870d = 150 )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    objective_marker endon( #"hidden" );
    objective_marker notify( #"end" );
    objective_marker endon( #"end" );
    
    while ( true )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        if ( function_124de228f3c03556( player, objective_marker.origin, var_e620d5604e2870d ) )
        {
            objective_marker notify( #"hash_fc0d26dcd2b34574" );
        }
        
        waitframe();
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0x178fb7c2, Offset: 0x6f1d
// Size: 0x3b, Type: bool
function function_124de228f3c03556( player, marker_position, var_e620d5604e2870d = 150 )
{
    return distance( player.origin, marker_position ) <= var_e620d5604e2870d;
}

// Namespace common_training_course
// Params 1
// Checksum 0x8fef3240, Offset: 0x6f61
// Size: 0x24
function monitormatchstart( player )
{
    level endon( #"game_ended" );
    utility::flag_wait( "match_start" );
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0x30aa0ea5, Offset: 0x6f8d
// Size: 0x38
function private waitforplayerspawned( player )
{
    level endon( #"game_ended" );
    
    do
    {
        level waittill( #"player_spawned", spawned_player );
    }
    while ( player != spawned_player );
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x92a9b0a2, Offset: 0x6fcd
// Size: 0x4f
function private function_b26daaaa9debed6e( player, tutorial )
{
    level endon( #"tutorial_changed" );
    player notifyonplayercommand( "exit_tutorial_preview", "+gostand" );
    player waittill( #"exit_tutorial_preview" );
    level thread restarttutorial( player, tutorial, 0, 0, 0, undefined );
}

// Namespace common_training_course
// Params 1
// Checksum 0x401c9201, Offset: 0x7024
// Size: 0x189
function luinotifylistener( player )
{
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", msg, arg );
        tutorial = level.current_tutorial;
        
        if ( !isdefined( tutorial ) )
        {
            continue;
        }
        
        if ( msg == "exit_current_training_course_station" && ( function_d1d2cf69e63f6596( tutorial ) || function_cbcead310c3cf8bd( tutorial ) || function_faa438d8de9a4dc9( player ) ) )
        {
            if ( function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 1;
            }
            else
            {
                level thread exittutorial( player, tutorial, 1 );
            }
            
            continue;
        }
        
        if ( msg == "triptychs_training_course_station_start" )
        {
            tutorial notify( #"triptychs_training_course_station_start" );
            continue;
        }
        
        if ( msg == "tutorial_station_instructions_training_course" && ( function_d1d2cf69e63f6596( tutorial ) || function_cbcead310c3cf8bd( tutorial ) ) )
        {
            if ( function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 2;
            }
            else
            {
                level thread restarttutorial( player, tutorial, 0, 1, 0, undefined );
            }
            
            continue;
        }
        
        if ( getdvarint( @"hash_5bb18d4eb7794e87" ) && msg == "training_course_preview_station" )
        {
            if ( function_faa438d8de9a4dc9( player ) )
            {
                function_dfb331efe033ac6c( player, tutorial, 0 );
            }
            
            if ( function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 0;
                continue;
            }
            
            level thread starttutorial( player, tutorial, 0, 1, 1, 0, undefined );
        }
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0x98e9ccdf, Offset: 0x71b5
// Size: 0x72
function function_dfb331efe033ac6c( player, tutorial, should_show )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    packed_index = function_8b878dec24bedc0e( tutorial ) << 8 | tutorial.order_number;
    player setclientomnvar( "show_training_course_triptychs", should_show ? packed_index : -1 );
    
    if ( should_show )
    {
        player playsound( "uin_t10_training_course_triptych_screen" );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x3ce354a2, Offset: 0x722f
// Size: 0x22, Type: bool
function function_faa438d8de9a4dc9( player )
{
    if ( isdefined( player ) )
    {
        return ( player getclientomnvar( "show_training_course_triptychs" ) != -1 );
    }
    
    return false;
}

// Namespace common_training_course
// Params 2
// Checksum 0x6b01b70e, Offset: 0x725a
// Size: 0x6e
function function_3a0aec7f1e9988a3( player, tutorial )
{
    player hud_message::function_c7ef9b0007b5092d();
    player hud_message::clearsplashqueue();
    
    if ( level.var_bb4f4ac000751f63 == tutorial.order_number )
    {
        function_8becb86703380fc7( tutorial, 0, 1 );
    }
    
    player setclientomnvar( "training_course_in_station_range", function_8b878dec24bedc0e( tutorial ) << 8 | tutorial.order_number );
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0xc2d5db77, Offset: 0x72d0
// Size: 0x59
function private function_5c1689103ca32d82( player, tutorial )
{
    if ( player getclientomnvar( "training_course_in_station_range" ) != -1 )
    {
        player setclientomnvar( "training_course_in_station_range", -1 );
        
        if ( level.var_bb4f4ac000751f63 == tutorial.order_number )
        {
            function_8becb86703380fc7( tutorial, 1, 1 );
        }
    }
}

// Namespace common_training_course
// Params 2, eflags: 0xc
// Checksum 0x1d607587, Offset: 0x7331
// Size: 0x70
function private showfailhint( player, tutorial )
{
    self notify( #"hash_273cfd2894a59042" );
    self endon( #"hash_273cfd2894a59042" );
    level endon( #"game_ended" );
    
    if ( !function_32d334aad6bf0ad3( tutorial ) )
    {
        return;
    }
    
    player setclientomnvar( "training_course_fail_hint_string_index", function_d654ebca885f4644( tutorial ) );
    function_6c0ff087784b7b0( tutorial, undefined );
    wait 5;
    function_df581661be9ca5c5( player );
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0xbd78a2ab, Offset: 0x73a9
// Size: 0x2b
function private function_df581661be9ca5c5( player )
{
    if ( player getclientomnvar( "training_course_fail_hint_string_index" ) != -1 )
    {
        player setclientomnvar( "training_course_fail_hint_string_index", -1 );
    }
}

// Namespace common_training_course
// Params 2, eflags: 0x4
// Checksum 0x82970c2e, Offset: 0x73dc
// Size: 0x3b
function private function_6c0ff087784b7b0( tutorial, string_reference )
{
    if ( isdefined( string_reference ) )
    {
        tutorial.var_a9ecb0261b0cf3cf = getlocstringindex( string_reference );
        return;
    }
    
    tutorial.var_a9ecb0261b0cf3cf = undefined;
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0xed5ce6e1, Offset: 0x741f
// Size: 0x17
function private function_d654ebca885f4644( tutorial )
{
    return tutorial.var_a9ecb0261b0cf3cf;
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0x3f9f79fa, Offset: 0x743f
// Size: 0x15, Type: bool
function private function_32d334aad6bf0ad3( tutorial )
{
    return isdefined( function_d654ebca885f4644( tutorial ) );
}

// Namespace common_training_course
// Params 2
// Checksum 0x5882a802, Offset: 0x745d
// Size: 0x2d
function function_ac53a17fd5b74658( player, cached_string_ref )
{
    if ( isdefined( player ) )
    {
        player setclientomnvar( "training_course_current_hint_string_index", getlocstringindex( cached_string_ref ) );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x134d8349, Offset: 0x7492
// Size: 0x20
function function_55099ffa73b4eff1( player )
{
    if ( isdefined( player ) )
    {
        player setclientomnvar( "training_course_current_hint_string_index", -1 );
    }
}

// Namespace common_training_course
// Params 1
// Checksum 0x2cb091aa, Offset: 0x74ba
// Size: 0x1a, Type: bool
function function_33427acbfd53222( player )
{
    return player getclientomnvar( "training_course_current_hint_string_index" ) != -1;
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0xc75bfeea, Offset: 0x74dd
// Size: 0x22
function private function_3f5c1e59764b640d( var_2c240cccdbc45e6f )
{
    return { #var_49411d93b2ea3681:[], #var_b6b6603ac7a33cd1:var_2c240cccdbc45e6f };
}

// Namespace common_training_course
// Params 1, eflags: 0x4
// Checksum 0xcbcd3f5f, Offset: 0x7508
// Size: 0x12f
function private function_402d34de715b6a70( var_37fbd8ffcf5239db )
{
    if ( var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size == 0 )
    {
        var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1 = var_37fbd8ffcf5239db.var_49411d93b2ea3681;
        var_37fbd8ffcf5239db.var_49411d93b2ea3681 = [];
    }
    
    var_e0582ca146e9dcc1 = randomintrange( 0, var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size );
    random_element = var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1[ var_e0582ca146e9dcc1 ];
    
    if ( isdefined( var_37fbd8ffcf5239db.var_9987219c72fa8017 ) )
    {
        var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1[ var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size ] = var_37fbd8ffcf5239db.var_9987219c72fa8017;
        var_37fbd8ffcf5239db.var_9987219c72fa8017 = undefined;
    }
    
    if ( var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size - 1 == 0 && var_37fbd8ffcf5239db.var_49411d93b2ea3681.size > 0 )
    {
        var_37fbd8ffcf5239db.var_9987219c72fa8017 = random_element;
    }
    else
    {
        var_37fbd8ffcf5239db.var_49411d93b2ea3681[ var_37fbd8ffcf5239db.var_49411d93b2ea3681.size ] = random_element;
    }
    
    var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1[ var_e0582ca146e9dcc1 ] = undefined;
    
    if ( isint( var_e0582ca146e9dcc1 ) )
    {
        function_cdc669dbc8ea2101( var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1 );
    }
    
    return random_element;
}

// Namespace common_training_course
// Params 3
// Checksum 0xae43d5e6, Offset: 0x7640
// Size: 0x3d
function function_98702f770499bea1( player, current_targets_hit, var_3e798f5e5d58dd8d )
{
    if ( isdefined( player ) )
    {
        function_baee265bb13dd11e( player, current_targets_hit, var_3e798f5e5d58dd8d );
        player setclientomnvar( "training_course_show_target_counter", 1 );
    }
}

// Namespace common_training_course
// Params 2
// Checksum 0xe6858b14, Offset: 0x7685
// Size: 0x3a
function function_c58312077098c9c8( player, delay = 0 )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "training_course_show_target_counter", 0 );
    }
}

// Namespace common_training_course
// Params 3
// Checksum 0x8012f03f, Offset: 0x76c7
// Size: 0x40
function function_baee265bb13dd11e( player, current_targets_hit, var_3e798f5e5d58dd8d )
{
    packed_index = current_targets_hit << 8 | var_3e798f5e5d58dd8d;
    player setclientomnvar( "training_course_current_targets_hit", packed_index );
}

// Namespace common_training_course
// Params 1
// Checksum 0x45ef9242, Offset: 0x770f
// Size: 0x17
function function_ce08700870078f55( player )
{
    return player getclientomnvar( "training_course_show_target_counter" );
}

// Namespace common_training_course
// Params 0
// Checksum 0x1a37bea5, Offset: 0x772f
// Size: 0x38
function function_21095a8908de4687()
{
    self.station_number = self.current_tutorial.order_number + 1;
    self.start_time = gettime();
    self.failed_attempts = 0;
}

// Namespace common_training_course
// Params 2
// Checksum 0x7439afaf, Offset: 0x776f
// Size: 0xe6
function function_ae1b81443a485a25( was_completed = 0, did_disconnect = 0 )
{
    if ( !isdefined( self.station_number ) || self.station_number == -1 )
    {
        return;
    }
    
    dlogevent = "dlog_event_mp_player_training_course_station_data";
    ending_reason = was_completed ? "completed" : "quit";
    self dlog_recordplayerevent( dlogevent, [ "station_number", self.station_number, "time_spent", gettime() - self.start_time, "failed_attempts", self.failed_attempts, "ending_reason", ending_reason, "disconnected", did_disconnect ] );
    function_4ea1ebb34b0e0d13();
}

// Namespace common_training_course
// Params 0, eflags: 0x4
// Checksum 0xc45249d3, Offset: 0x785d
// Size: 0x21
function private function_4ea1ebb34b0e0d13()
{
    self.station_number = -1;
    self.time_spent = 0;
    self.failed_attempts = 0;
}

