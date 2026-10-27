// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_rej.gsc  (hash_373c7d5ffe473753.gscc) (size: 31173 Bytes / 0x79c5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9591775d (2509338461)
// size ...... 31173 (0x79c5)
// includes .. 20  (offset: 0x6e51)
// strings ... 179 (offset: 0x6ef1)
// dev strs .. 28  (offset: 0x7835)
// exports ... 60  (offset: 0x4a69)
// cseg ...... 0x1695 + 0x33d4 (0x4a69)
// imports ... 223 (offset: 0x53c9)
// animtree1 . 1   (offset: 0x79a5)
// animtree2 . 1   (offset: 0x79b5)
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\hud_util;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\anim_scene;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\interaction;
#using scripts\mp\overlord;
#using scripts\mp\supers;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_sat_locust_rej;

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x5
// Checksum 0x24b3562b, Offset: 0x16b3
// Size: 0x346
function private autoexec init()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    utility::flag_wait( "create_script_initialized" );
    init_fall_anims();
    init_fx();
    init_ravenov();
    interactions = [];
    locations = utility::getstructarray( "robot_ejection_tube" );
    
    foreach ( location in locations )
    {
        interact = spawnscriptable( %"sat_zm_interact_locust", location.origin, location.angles );
        interact.angles = location.angles;
        interact.script_string = location.script_string;
        interact.script_int = location.script_int;
        interact.is_robot_tube = 1;
        interact.destination = utility::getstruct( location.target );
        interact.destination.origin -= anglestoforward( interact.destination.angles ) * 64;
        interaction::register_scriptable_interact( interact, &function_d0ac5d9f5b3db910, undefined, undefined, &function_6ad4cf5205d34898 );
        interact setscriptablepartstate( "objective", "robot_tube" );
        interactions[ interactions.size ] = interact;
    }
    
    narrative_rooms = utility::array_sort_by_script_index( utility::getstructarray( "narrative_room" ) );
    random_landings = utility::getstructarray( "random_landing" );
    
    foreach ( destination in random_landings )
    {
        destination.origin -= anglestoforward( destination.angles ) * 64;
    }
    
    foreach ( narrative_room in narrative_rooms )
    {
        init_room_dialogue( narrative_room );
    }
    
    level.robot_ejection_tubes = { #players:[], #room_chance:20, #random_landings:random_landings, #narrative_rooms:narrative_rooms, #interactions:interactions };
    
    /#
        debug_init();
    #/
}

#using_animtree( "zm_sat_locust_scriptables" );

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x5bbaeea7, Offset: 0x1a01
// Size: 0x56
function private init_fall_anims()
{
    level.scr_animtree[ "player" ] = #animtree;
    level.scr_anim[ "player" ][ "player_sucked_in" ][ 0 ] = %sat_mp_strafe_fast_jump_air_8;
    level.scr_eventanim[ "player" ][ "player_sucked_in" ][ 0 ] = %"sat_mp_strafe_fast_jump_air_8";
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x56702aa2, Offset: 0x1a5f
// Size: 0x24
function private init_fx()
{
    utility::add_fx( "begin_eject_up", "vfx_sat_levels_zm_locust_tube_teleport_in_screen" );
    utility::add_fx( "begin_eject_down", "vfx_sat_levels_zm_locust_tube_teleport_out_screen" );
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x75e22fe, Offset: 0x1a8b
// Size: 0xa
function private init_ravenov()
{
    level thread function_f57e86327592a6f0();
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0xcd8268b6, Offset: 0x1a9d
// Size: 0x16f
function private function_f57e86327592a6f0()
{
    utility::flag_wait( "begin_round_logic" );
    phone = utility::spawn_tag_origin( ( 6940.01, 9684.69, 673.6 ) );
    lines = [ "dx_zm_ltsr_tesr_rvnv_tsrmtrvnvln1", "dx_zm_ltsr_tesr_rvnv_tsrmtrvnvln2", "dx_zm_ltsr_tesr_rvnv_tsrmtrvnvln3" ];
    delays = [ 7, 3, 7 ];
    
    for ( ;; )
    {
        player = level.robot_ejection_tubes.narrative_rooms[ 1 ].player;
        
        if ( !isent( player ) || !isplayer( player ) || !isalive( player ) )
        {
            wait 0.5;
            continue;
        }
        
        foreach ( idx, line in lines )
        {
            phone playsoundtoplayer( line, player, phone );
            wait delays[ idx ];
            
            if ( !isent( player ) || !isplayer( player ) || !isalive( player ) )
            {
                break;
            }
        }
        
        wait 2.5;
    }
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0xa9bb6cc4, Offset: 0x1c14
// Size: 0x74
function private init_room_dialogue( room )
{
    room.in_use = 0;
    
    switch ( room.script_index )
    {
        case 1:
            init_basement_dialogue( room );
            break;
        case 2:
            init_motel_dialogue( room );
            break;
        case 3:
            init_corridor_dialogue( room );
            break;
    }
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0x51e8bacb, Offset: 0x1c90
// Size: 0x5d
function private function_d0ac5d9f5b3db910( player )
{
    if ( !player.var_420915a121e1cc41 )
    {
        return;
    }
    
    if ( self.in_use )
    {
        return;
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return;
    }
    
    function_97b23931f84889b7( self, 0 );
    level thread ejection_sequence( { #player:player, #var_d3823b80b1397854:self } );
}

// Namespace zm_sat_locust_rej
// Params 2, eflags: 0x4
// Checksum 0xf294aa2a, Offset: 0x1cf5
// Size: 0x1b5
function private function_6ad4cf5205d34898( interact, player )
{
    if ( !player.var_420915a121e1cc41 )
    {
        return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( interact.in_use )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_rej_in_use", #type:"HINT_NOBUTTON" };
    }
    
    if ( !zm_quest::function_f98968f17772726c( 1 ) )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_rej_in_use", #type:"HINT_NOBUTTON" };
    }
    
    switch ( interact.script_string )
    {
        case #"hash_2c5efc9850d0cbb5":
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_rej_downtown", #type:"HINT_BUTTON" };
        case #"hash_4bd0decdac3b520a":
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_rej_foundry", #type:"HINT_BUTTON" };
        case #"hash_3d2f4fa412dd2fd1":
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_rej_market", #type:"HINT_BUTTON" };
        case #"hash_6e796d4e120a505f":
            return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/hint_rej_shipyard", #type:"HINT_BUTTON" };
    }
}

// Namespace zm_sat_locust_rej
// Params 1
// Checksum 0xa7531c46, Offset: 0x1eb2
// Size: 0x481
function ejection_sequence( params )
{
    player = params.player;
    player endon( #"death_or_disconnect" );
    level callback::callback( #"hash_a533dd0ef17a6d8f", params );
    increment_usage( player );
    
    if ( !params.skip_narrative_room )
    {
        /#
            narrative_mode = getdvarint( @"hash_e53420f91b4c3c9", 0 );
        #/
        
        if ( !narrative_mode )
        {
            if ( utility::percent_chance( level.robot_ejection_tubes.room_chance ) )
            {
                narrative_mode = !level callback::response( 1, #"hash_462433e659e82d48" );
            }
            else
            {
                level.robot_ejection_tubes.room_chance += 1;
            }
        }
    }
    
    if ( narrative_mode )
    {
        narrative_destination = function_b938ebbbff3b0b39( level.robot_ejection_tubes.narrative_rooms );
        
        if ( narrative_destination )
        {
            destination = narrative_destination;
            destination thread function_c5cf411876d55854( destination );
            level.robot_ejection_tubes.room_chance = 20;
        }
        else
        {
            narrative_mode = 0;
            destination = params.var_d3823b80b1397854.destination;
        }
    }
    else
    {
        destination = params.var_d3823b80b1397854.destination;
    }
    
    if ( !narrative_mode && !isdefined( destination ) )
    {
        destination = function_b938ebbbff3b0b39( level.robot_ejection_tubes.random_landings, 1 );
        
        if ( !isdefined( destination ) )
        {
            destination = utility::array_random( level.robot_ejection_tubes.random_landings );
        }
    }
    
    player thread clear_data_on_disconnect( destination, params.var_d3823b80b1397854 );
    player thread utility::player_prestream_camera( destination.origin, 10 );
    
    if ( !isstruct( params.var_d3823b80b1397854 ) )
    {
        activateworldevent( "we_tube_activate_" + params.var_d3823b80b1397854.script_int );
        player playsoundevent( %"hash_67c1781803a59f8a" );
        player playsoundevent( %"hash_6223b71849482c6f" );
    }
    
    if ( !narrative_mode )
    {
        destination thread function_c5cf411876d55854( destination );
    }
    
    player function_e5d475eae45782c9( params.var_d3823b80b1397854.origin, params.var_d3823b80b1397854.angles, params.var_a8f377bd77c5267e );
    player function_a8a80f1808204b25( params.var_d3823b80b1397854, params.var_a8f377bd77c5267e ? 0 : 2, params.var_a8f377bd77c5267e );
    
    if ( !isstruct( params.var_d3823b80b1397854 ) )
    {
        deactivateworldevent( "we_tube_activate_" + params.var_d3823b80b1397854.script_int );
    }
    
    if ( narrative_mode )
    {
        player playsoundevent( %"sndevent_teleportation_begin_3d", player );
        landing_destination = function_b938ebbbff3b0b39( level.robot_ejection_tubes.random_landings, 1 );
        landing_destination thread function_c5cf411876d55854( destination );
        player function_6b4a863987e3a49( destination.origin, vectortoangles( destination.origin - player.origin ) );
        player function_5e6fbf9ef5db2557( destination.origin, 0, destination.angles, 1 );
        player function_db4902451e1e6733( destination, 10 );
        player function_6b4a863987e3a49( landing_destination.origin + ( 0, 0, landing_destination.script_int ), vectortoangles( landing_destination.origin - player.origin ) );
        player function_5e6fbf9ef5db2557( landing_destination.origin, landing_destination.script_int, landing_destination.angles, 0 );
    }
    else
    {
        player function_6b4a863987e3a49( destination.origin + ( 0, 0, destination.script_int ), vectortoangles( destination.origin - player.origin ) );
        player function_5e6fbf9ef5db2557( destination.origin, destination.script_int, destination.angles, 0 );
    }
    
    if ( player )
    {
        player notify( #"completed_rej" );
    }
    
    decrement_usage( player, destination );
}

// Namespace zm_sat_locust_rej
// Params 2, eflags: 0x4
// Checksum 0x19cf39db, Offset: 0x233b
// Size: 0xcb
function private function_97b23931f84889b7( var_d3823b80b1397854, to_usable )
{
    assert( !isent( var_d3823b80b1397854 ) && var_d3823b80b1397854 isscriptableinstance() && var_d3823b80b1397854 getscriptableisusableonanypart(), "<dev string:x24>" );
    
    if ( to_usable )
    {
        assert( !var_d3823b80b1397854 function_ef43fd0a946e1594(), "<dev string:x41>" );
        var_d3823b80b1397854.in_use = 0;
        var_d3823b80b1397854 setscriptablepartstate( "interact", "enabled_64" );
        var_d3823b80b1397854 setscriptablepartstate( "objective", "robot_tube" );
        return;
    }
    
    assert( var_d3823b80b1397854 function_ef43fd0a946e1594(), "<dev string:x74>" );
    var_d3823b80b1397854.in_use = 1;
    var_d3823b80b1397854 setscriptablepartstate( "interact", "default" );
    var_d3823b80b1397854 setscriptablepartstate( "objective", "default" );
}

// Namespace zm_sat_locust_rej
// Params 3, eflags: 0x4
// Checksum 0x206edcbb, Offset: 0x240e
// Size: 0x5d
function private function_e5d475eae45782c9( origin, angles, var_a3aa82839b55e230 = 0 )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_c14f946ebf4aaea3" );
    self notify( #"close_interactive_note" );
    prepare_player( var_a3aa82839b55e230 );
    function_c52f914088fc2a7f( origin, angles );
}

// Namespace zm_sat_locust_rej
// Params 2
// Checksum 0x45886d0d, Offset: 0x2473
// Size: 0x1f
function function_6b4a863987e3a49( origin, angles )
{
    function_c52f914088fc2a7f( origin, angles );
}

// Namespace zm_sat_locust_rej
// Params 4, eflags: 0x4
// Checksum 0x15179052, Offset: 0x249a
// Size: 0xe0
function private eject_player_up( actor, height = 2000, move_time = 2.5, fade_time = 0.33 )
{
    if ( height > 0 )
    {
        self playrumbleonentity( "heavy_3s" );
        thread hud_util::fade_out( fade_time, "white" );
        self playsoundevent( %"hash_6ee85bf996c56d94" );
        self.rej_link movez( height, move_time, 0.5 );
        self.rej_link waittill( #"movedone" );
    }
    else
    {
        hud_util::fade_out( fade_time, "white" );
    }
    
    self.rej_link delete();
    
    if ( actor.player_rig )
    {
        actor.player_rig delete();
    }
}

// Namespace zm_sat_locust_rej
// Params 2
// Checksum 0x43337b73, Offset: 0x2582
// Size: 0x123
function function_9b26b9212e8a24b( origin, angles )
{
    assert( self.rej_link, "<dev string:xa9>" );
    actor = anim_scene::anim_scene_create_actor( self, "player", 1, 0 );
    actor.angles = angles;
    actor.player_rig = spawn( "script_arms", origin, 0, 0, self );
    actor.player_rig.angles = angles;
    actor.player_rig.animname = actor.animname;
    actor.player_rig.entity = self;
    actor.player_rig useanimtree( #animtree );
    self playerlinktoabsolute( actor.player_rig, "tag_player" );
    actor.player_rig linkto( self.rej_link );
    actor.player_rig hide();
    thread function_aa24807231579b1e( actor );
    thread function_630203ad8b2c6680( actor );
    return actor;
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0x544fcb7c, Offset: 0x26ae
// Size: 0x7e
function private play_falling_anim( actor )
{
    self endon( #"death_or_disconnect" );
    self.rej_link thread anim_scene::anim_scene_loop( [ actor ], "player_sucked_in", 0, 0, undefined );
    self.rej_link waittill( #"movedone" );
    self.rej_link anim_scene::anim_scene_stop();
    self stopanimscriptsceneevent();
    val::reset_all( "anim_scene" );
    actor.player_rig delete();
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0xc
// Checksum 0x3191d6fe, Offset: 0x2734
// Size: 0xea
function private function_630203ad8b2c6680( actor )
{
    self notify( #"hash_d45edc6078d1fa21" );
    self endon( #"hash_d45edc6078d1fa21" );
    self endon( #"death_or_disconnect" );
    actor.player_rig endon( #"death" );
    var_ba2b87d4806b61a7 = 0;
    
    for ( ;; )
    {
        if ( actor.player_rig islinked() )
        {
            rig_children = actor.player_rig getlinkedchildren();
            
            if ( !arraycontains( rig_children, self ) )
            {
                actor.player_rig hide();
                waitframe();
                continue;
            }
        }
        
        if ( self getcamerathirdperson() && var_ba2b87d4806b61a7 )
        {
            actor.player_rig hide();
            var_ba2b87d4806b61a7 = 0;
        }
        else if ( !self getcamerathirdperson() && !var_ba2b87d4806b61a7 )
        {
            var_ba2b87d4806b61a7 = 1;
            actor.player_rig showonlytoplayer( self );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0xfd520f66, Offset: 0x2826
// Size: 0x4d
function private function_aa24807231579b1e( actor )
{
    actor.player_rig endon( #"death" );
    self waittill( #"death_or_disconnect" );
    
    if ( actor.player_rig )
    {
        actor.player_rig delete();
    }
}

// Namespace zm_sat_locust_rej
// Params 2, eflags: 0x4
// Checksum 0x9a6d0219, Offset: 0x287b
// Size: 0x4f
function private function_c52f914088fc2a7f( origin, angles )
{
    self setvelocity( ( 0, 0, 0 ) );
    self dontinterpolate();
    self setorigin( origin );
    self setplayerangles( angles );
    self setstance( "stand", 1, 1, 1 );
}

// Namespace zm_sat_locust_rej
// Params 1
// Checksum 0x18c2b21e, Offset: 0x28d2
// Size: 0x5c
function prepare_player( var_a3aa82839b55e230 = 0 )
{
    self endon( #"death_or_disconnect" );
    function_6ed8e1f2e1ad9b47();
    thread prepare_player_camera();
    function_56db6f6859124c85();
    function_9a39ca3ca367363c();
    prepare_player_values();
    inventory_utility::givegunlessweapon();
    
    if ( var_a3aa82839b55e230 )
    {
        self waittill( #"weapon_change" );
    }
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x11dd6b75, Offset: 0x2936
// Size: 0x4e
function private function_6ed8e1f2e1ad9b47()
{
    if ( self isonascender() )
    {
        self dropoffascender();
        waitframe();
    }
    
    if ( self isemoteactive() )
    {
        self stopemote();
        waitframe();
    }
    
    if ( self isonladder() )
    {
        val::set( #"chute_ejection", "ladder", 0 );
        waitframe();
    }
    
    if ( self ismantling() )
    {
        self cancelmantle();
        waitframe();
    }
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x59e67d79, Offset: 0x298c
// Size: 0x14
function private function_56db6f6859124c85()
{
    if ( !zm_quest::function_9b18c35fba5c3d31() )
    {
        return;
    }
    
    supers_mp::superusefinished();
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0xdc212d53, Offset: 0x29a8
// Size: 0x3b
function private function_9a39ca3ca367363c()
{
    self canceloffhands();
    self releaseoffhand();
    self stopanimscriptsceneevent();
    self stopgestureviewmodel();
    killstreakdeploy::streakdeploy_cancelalldeployments();
    self notify( #"equip_deploy_cancel" );
    
    if ( self isviewmodelanimplaying() )
    {
        self stopviewmodelanim();
    }
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0xc806d401, Offset: 0x29eb
// Size: 0x9f
function private prepare_player_values()
{
    val::set( #"chute_ejection", "weapon", 0 );
    val::set( #"chute_ejection", "freezecontrols", 1 );
    val::set( #"chute_ejection", "ignore_playable_area_check", 1 );
    val::set( #"chute_ejection", "ignoreme", 1 );
    val::set( #"chute_ejection", "show_hud", 0 );
    val::set( #"chute_ejection", "crouch", 0 );
    val::set( #"chute_ejection", "prone", 0 );
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x82af4d3b, Offset: 0x2a92
// Size: 0x3d
function private prepare_player_camera()
{
    player_utility::function_99d180c3f0ca93b8( self, "disabled", 0, 1 );
    
    if ( self getcamerathirdperson() )
    {
        self notify( #"zm_down_toggle" );
        self.was_third_person = 1;
        waitframe();
    }
    
    self.disable_third_person_toggle = 1;
}

// Namespace zm_sat_locust_rej
// Params 3, eflags: 0x4
// Checksum 0xa8817546, Offset: 0x2ad7
// Size: 0x116
function private function_a8a80f1808204b25( var_d3823b80b1397854, countdown_time = 2, skip_exit = 0 )
{
    self endon( #"death_or_disconnect" );
    self.rej_link = utility::spawn_tag_origin( self.origin, self getplayerangles() );
    actor = function_9b26b9212e8a24b( self.rej_link.origin, self.rej_link.angles );
    
    if ( countdown_time >= level.framedurationseconds )
    {
        wait countdown_time;
    }
    
    if ( !skip_exit )
    {
        playfxontagforclients( utility::getfx( "begin_eject_up" ), self, "j_head", self );
        eject_player_up( actor );
        stopfxontagforclients( utility::getfx( "begin_eject_up" ), self, "j_head", self );
    }
    else
    {
        eject_player_up( actor, 0, undefined, 0.25 );
    }
    
    self notify( #"completed_ejection" );
    
    if ( !isstruct( var_d3823b80b1397854 ) )
    {
        function_97b23931f84889b7( var_d3823b80b1397854, 1 );
    }
}

// Namespace zm_sat_locust_rej
// Params 6
// Checksum 0xdd69242e, Offset: 0x2bf5
// Size: 0xf8
function function_5e6fbf9ef5db2557( position, height, to_angles, skip_falling, time, fade_in_time )
{
    self endon( #"death_or_disconnect" );
    look_angles = vectortoangles( position - self.origin );
    look_angles += to_angles;
    self.rej_link = utility::spawn_tag_origin( self.origin, look_angles );
    actor = function_9b26b9212e8a24b( self.rej_link.origin, self.rej_link.angles );
    playfxontagforclients( utility::getfx( "begin_eject_down" ), self, "j_head", self );
    eject_player_down( actor, height * -1, to_angles, skip_falling, time, fade_in_time );
    stopfxontagforclients( utility::getfx( "begin_eject_down" ), self, "j_head", self );
}

// Namespace zm_sat_locust_rej
// Params 6, eflags: 0x4
// Checksum 0x26c2a092, Offset: 0x2cf5
// Size: 0x32e
function private eject_player_down( actor, height = -3000, to_angles, skip_falling = 0, time = 3, fade_in_time = 0.35 )
{
    self endon( #"death_or_disconnect" );
    
    if ( !skip_falling )
    {
        assert( height < 0 );
        self setshowcontrail( 1 );
        thread play_falling_anim( actor );
        self.rej_link movez( height + 32, time, time );
        wait 0.15;
        level callback::callback( #"hash_3e4093a7794b1a98", { #player:self } );
        self playsoundevent( %"hash_393afb55a2f3b889" );
        self playsoundevent( %"hash_6ba91055bf13c4c8" );
        val::reset_all( #"narrative_room" );
        zm_quest::disable_specific_player_bgb( 0 );
        self function_d88e8eab88c50c13( 0 );
        player::showminimap();
        thread hud_util::fade_in( fade_in_time, "white" );
        wait time - 0.15 - 0.2;
        self setshowcontrail( 0 );
        thread hud_util::fade_out( 0, "black" );
        wait 0.35;
    }
    else
    {
        thread hud_util::fade_in( fade_in_time, "white" );
        val::set( #"narrative_room", "ignore_playable_area_check", 1 );
        val::set( #"narrative_room", "sprint", 0 );
        val::set( #"narrative_room", "killstreaks", 0 );
        val::set( #"narrative_room", "supers", 0 );
        val::set( #"narrative_room", "ignore_afk", 1 );
        val::set( #"narrative_room", "round_spawning_ignore_player", 1 );
        val::set( #"narrative_room", "show_compass", 0 );
        val::set( #"narrative_room", "melee", 0 );
        val::set( #"narrative_room", "offhand_weapons", 0 );
        val::set( #"narrative_room", "fire", 0 );
        val::set( #"narrative_room", "allow_battlechatter_vo", 0 );
        zm_quest::disable_specific_player_bgb( 1 );
        self function_d88e8eab88c50c13( 1 );
        player::hideminimap( 1 );
    }
    
    self setplayerangles( to_angles );
    
    if ( !skip_falling )
    {
        shellshock_time = 2.5;
        shellshock_utility::_shellshock( %"falldamage", #"damage", shellshock_time );
        thread blast_nearby_enemies();
        thread knockback_nearby_players();
        self playsoundevent( %"hash_254035c5eb2fb816" );
        self playsoundevent( %"hash_6509dcc65829f6bb" );
        wait 1;
    }
    else
    {
        actor.player_rig delete();
    }
    
    if ( self.rej_link )
    {
        self.rej_link delete();
    }
    
    release_player_early();
    
    if ( !skip_falling )
    {
        hud_util::fade_in( 0.5, "black" );
    }
    
    function_446fceff58281321();
    self notify( #"touchdown_ejection" );
}

// Namespace zm_sat_locust_rej
// Params 2, eflags: 0x4
// Checksum 0xeaca3c01, Offset: 0x302b
// Size: 0xc5
function private function_db4902451e1e6733( room, time )
{
    self endon( #"death_or_disconnect" );
    room.player = self;
    function_241d85333be1a0d8( 1 );
    self playsoundevent( %"hash_4c5c6971eaf5201" );
    fx_time_offset = 2;
    function_b88604d878c3f65f( room, time, fx_time_offset );
    pbgpostfxbundlestart( self, %"cer_zm_topaz_sam_teleport" );
    self playsoundevent( %"hash_6cfdfc1554d0b4a3" );
    wait fx_time_offset;
    hud_util::fade_out( 0.5, "white" );
    pbgpostfxbundleend( self, %"cer_zm_topaz_sam_teleport" );
    prepare_player( 1 );
    wait 1;
    function_241d85333be1a0d8( 0 );
    room.player = undefined;
}

// Namespace zm_sat_locust_rej
// Params 3, eflags: 0x4
// Checksum 0x2a83c9c2, Offset: 0x30f8
// Size: 0xa6
function private function_b88604d878c3f65f( room, time, fx_time_offset )
{
    room endon( #"remove_player" );
    self endon( #"death_or_disconnect" );
    start_time = gettime();
    played = function_62fb0f329a6049d5( room );
    
    if ( played )
    {
        elapsed_time = gettime() - start_time;
        remaining_time = time - int( elapsed_time * 0.001 );
        wait_time = max( remaining_time + fx_time_offset, fx_time_offset );
        wait wait_time;
        return;
    }
    
    wait time - fx_time_offset;
}

// Namespace zm_sat_locust_rej
// Params 3, eflags: 0x4
// Checksum 0x9d3b2b12, Offset: 0x31a6
// Size: 0x6b
function private blast_nearby_enemies( var_8473f30fa3f8a348 = 1, var_79aebce64a2c1ae4 = 1, b_forceannihilate = 0 )
{
    self setscriptablepartstate( #"jump_effects", #"impact_med" );
    zm_quest::function_835556fe63cd2edd( self.origin, 256, 0, 1, var_8473f30fa3f8a348, var_79aebce64a2c1ae4, b_forceannihilate, 0 );
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x5ebfe6b1, Offset: 0x3219
// Size: 0xbf
function private knockback_nearby_players()
{
    players = getplayersinradius( self.origin, 64 );
    
    if ( players.size == 0 )
    {
        return;
    }
    
    if ( players.size == 1 && players[ 0 ] == self )
    {
        return;
    }
    
    players = arrayremove( players, self );
    
    foreach ( player in players )
    {
        player utility::knockback_flat( ( 0, randomfloat( 360 ), 0 ), 1200 );
    }
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x911a3321, Offset: 0x32e0
// Size: 0x79
function private release_player_early()
{
    release_player_camera();
    inventory_utility::takegunlessweapon();
    val::reset( #"chute_ejection", "weapon" );
    val::reset( #"chute_ejection", "freezecontrols" );
    val::reset( #"chute_ejection", "ignore_playable_area_check" );
    val::reset( #"chute_ejection", "crouch" );
    val::reset( #"chute_ejection", "prone" );
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0xc9db7091, Offset: 0x3361
// Size: 0x9
function private function_446fceff58281321()
{
    release_player_values();
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x90e675ca, Offset: 0x3372
// Size: 0x12
function private release_player_values()
{
    val::reset_all( #"chute_ejection" );
}

// Namespace zm_sat_locust_rej
// Params 0, eflags: 0x4
// Checksum 0x77fee458, Offset: 0x338c
// Size: 0x38
function private release_player_camera()
{
    self.disable_third_person_toggle = undefined;
    player_utility::function_c14762bb6e0b4edb( self );
    
    if ( !self.was_third_person )
    {
        return;
    }
    
    self notify( #"zm_down_toggle" );
    self.was_third_person = undefined;
}

// Namespace zm_sat_locust_rej
// Params 2
// Checksum 0x11486a7e, Offset: 0x33cc
// Size: 0xfc
function function_b938ebbbff3b0b39( objects, check_zone = 0 )
{
    objects = arrayrandomize( objects );
    
    foreach ( object in objects )
    {
        if ( object.in_use )
        {
            continue;
        }
        
        if ( check_zone )
        {
            if ( !isdefined( object.zone ) )
            {
                object.zone = zone_manager::function_90e5c3e2272b0130( object.origin );
            }
            
            if ( !object.zone.is_enabled )
            {
                continue;
            }
        }
        
        object.in_use = 1;
        return object;
    }
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0x838946e7, Offset: 0x34d0
// Size: 0x24
function private function_c5cf411876d55854( destination )
{
    destination waittill( #"rej_completed" );
    self.in_use = 0;
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0x7a0b91e0, Offset: 0x34fc
// Size: 0x35
function private function_bfc2a75b61244a9b( time )
{
    self endon( #"death_or_disconnect" );
    hud_util::fade_out( time, "white" );
    pbgpostfxbundleend( self, %"cer_zm_topaz_sam_teleport" );
}

// Namespace zm_sat_locust_rej
// Params 1
// Checksum 0x3ebe92fb, Offset: 0x3539
// Size: 0x50
function function_241d85333be1a0d8( state )
{
    self sethidenameplate( state );
    self function_66dc8b6ae969f66d( state );
    self function_5b3d07ad769e8d62( state );
    
    if ( state == 1 )
    {
        self setsoundsubmix( "sat_zm_locust_mute_tyr_vo" );
    }
    else
    {
        self clearsoundsubmix( "sat_zm_locust_mute_tyr_vo" );
    }
    
    self.var_d125c0ff0fff3d7b = state;
}

// Namespace zm_sat_locust_rej
// Params 2, eflags: 0x4
// Checksum 0x2149073e, Offset: 0x3591
// Size: 0x64
function private clear_data_on_disconnect( destination, var_d3823b80b1397854 )
{
    level endon( #"game_ended" );
    self endon( #"completed_rej" );
    self waittill( #"disconnect" );
    
    if ( !isstruct( var_d3823b80b1397854 ) )
    {
        deactivateworldevent( "we_tube_activate_" + var_d3823b80b1397854.script_int );
    }
    
    decrement_usage( self, destination );
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0x329a5553, Offset: 0x35fd
// Size: 0x109
function private increment_usage( player )
{
    if ( !arraycontains( level.robot_ejection_tubes.players, player ) )
    {
        level.robot_ejection_tubes.players[ level.robot_ejection_tubes.players.size ] = player;
    }
    
    if ( level.robot_ejection_tubes.players.size == 1 && !utility::flag( "rej_is_busy" ) )
    {
        utility::flag_set( "rej_is_busy" );
    }
    
    var_dc4fa75655c6106d = utility::get_alive_players();
    var_dc4fa75655c6106d = arrayremove( var_dc4fa75655c6106d, level.robot_ejection_tubes.players );
    level.robot_ejection_tubes.players = function_5713d46873b29625( level.robot_ejection_tubes.players );
    terminal = zm_sat_locust_util::get_quest_reference( #"pap_terminal" );
    terminal.vo_audience = var_dc4fa75655c6106d;
}

// Namespace zm_sat_locust_rej
// Params 2, eflags: 0x4
// Checksum 0x177cb462, Offset: 0x370e
// Size: 0x10a
function private decrement_usage( player, destination )
{
    if ( player )
    {
        level.robot_ejection_tubes.players = arrayremove( level.robot_ejection_tubes.players, player );
    }
    else
    {
        level.robot_ejection_tubes.players = function_5713d46873b29625( level.robot_ejection_tubes.players );
    }
    
    var_dc4fa75655c6106d = utility::get_alive_players();
    var_dc4fa75655c6106d = arrayremove( var_dc4fa75655c6106d, level.robot_ejection_tubes.players );
    terminal = zm_sat_locust_util::get_quest_reference( #"pap_terminal" );
    terminal.vo_audience = var_dc4fa75655c6106d;
    
    if ( level.robot_ejection_tubes.players.size == 0 && utility::flag( "rej_is_busy" ) )
    {
        utility::flag_clear( "rej_is_busy" );
    }
    
    destination notify( #"rej_completed" );
}

// Namespace zm_sat_locust_rej
// Params 0
// Checksum 0x12e1c34e, Offset: 0x3820
// Size: 0xd
function is_busy()
{
    return utility::flag( "rej_is_busy" );
}

// Namespace zm_sat_locust_rej
// Params 0
// Checksum 0x18e64f, Offset: 0x3836
// Size: 0x15
function function_e27acb77a788e767()
{
    return level.robot_ejection_tubes.players;
}

// Namespace zm_sat_locust_rej
// Params 4, eflags: 0x4
// Checksum 0x65a03676, Offset: 0x3854
// Size: 0x2ea, Type: bool
function private function_62fb0f329a6049d5( room, alt_idx, hero, forced = 0 )
{
    level endon( #"zm_game_over" );
    self endon( #"disconnect" );
    
    if ( overlord::function_dce0a14273dfa0a8() )
    {
        return false;
    }
    
    foreach ( flag in level.var_bbe2ae9963c25f75 )
    {
        if ( utility::flag( flag ) )
        {
            return false;
        }
    }
    
    /#
        if ( !isdefined( alt_idx ) )
        {
            var_1295c7593ecd25a3 = getdvarint( @"hash_8cfef0dcd7cf8ac1", 0 );
            
            if ( var_1295c7593ecd25a3 > 0 )
            {
                alt_idx = var_1295c7593ecd25a3 - 1;
                forced = 1;
            }
        }
        
        if ( !isdefined( hero ) )
        {
            forced_hero = getdvarint( @"hash_e372274a6bcf3212", 0 );
            
            if ( forced_hero > 0 )
            {
                keys = getarraykeys( room.dialogues.data );
                keys = arraysort( keys );
                hero = keys[ forced_hero - 1 ];
                forced = 1;
            }
        }
        
        if ( !forced )
        {
            forced = getdvarint( @"hash_e53420f91b4c3c9", 0 );
        }
    #/
    
    if ( !isdefined( hero ) )
    {
        hero = namespace_c0b4f2882c9d100f::function_470ff6ad4f437db1();
    }
    
    if ( !forced )
    {
        if ( !isdefined( hero ) )
        {
            return false;
        }
        
        if ( !utility::percent_chance( 60 ) )
        {
            return false;
        }
        
        if ( arraycontains( room.dialogues.played, hero ) )
        {
            return false;
        }
    }
    
    if ( !isdefined( hero ) )
    {
        return false;
    }
    
    dialogue_data = room.dialogues.data[ hero ];
    
    if ( !isdefined( alt_idx ) )
    {
        alt_idx = randomint( dialogue_data.size );
    }
    
    if ( !forced )
    {
        room.dialogues.played[ room.dialogues.played.size ] = hero;
    }
    
    lines = dialogue_data[ alt_idx ];
    
    if ( lines.size == 0 )
    {
        return false;
    }
    
    self.vo_audience = self;
    overlord::function_724ca7b94bf1fb66( 1 );
    
    foreach ( dialogue in lines )
    {
        dialogue::say_dialogue( dialogue );
        
        if ( !isalive( self ) )
        {
            break;
        }
    }
    
    overlord::function_724ca7b94bf1fb66( 0 );
    self.vo_audience = undefined;
    return true;
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0x8370d34, Offset: 0x3b47
// Size: 0x276
function private init_basement_dialogue( room )
{
    data = [];
    data[ "carver" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrbmcarva1ln1", "dx_zm_ltsr_tesr_carv_tsrbmcarva1ln2" ], [ "dx_zm_ltsr_tesr_detw_tsrbmcarva2ln1", undefined, "dx_zm_ltsr_tesr_carv_tsrbmcarva2ln3" ], [ "dx_zm_ltsr_tesr_carv_tsrbmcarva3" ] ];
    data[ "grey" ] = [ [ "dx_zm_ltsr_tesr_grey_tsrbmgreya1ln1", "dx_zm_ltsr_tesr_ward_tsrbmgreya1ln2" ], [ "dx_zm_ltsr_tesr_grey_tsrbmgreya2ln1", "dx_zm_ltsr_tesr_ssrh_tsrbmgreya2ln2" ], [ "dx_zm_ltsr_tesr_grey_tsrbmgreya3" ] ];
    data[ "maya" ] = [ [ "dx_zm_ltsr_tesr_maya_tsrbmmayaa1ln1", "dx_zm_ltsr_tesr_ward_tsrbmmayaa1ln2" ], [ "dx_zm_ltsr_tesr_maya_tsrbmmayaa2ln1", "dx_zm_ltsr_tesr_ssfh_tsrbmmayaa2ln2" ], [ "dx_zm_ltsr_tesr_maya_tsrbmmayaa3" ] ];
    data[ "weaver" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrbmweava1ln1", "dx_zm_ltsr_tesr_weav_tsrbmweava1ln2" ], [ "dx_zm_ltsr_tesr_detw_tsrbmweava2ln1", "dx_zm_ltsr_tesr_weav_tsrbmweava2ln2" ], [ "dx_zm_ltsr_tesr_weav_tsrbmweava3" ] ];
    data[ "dempsey" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrbmambra1ln1", "dx_zm_ltsr_tesr_ambr_tsrbmambra1ln2" ], [ "dx_zm_ltsr_tesr_ssfh_tsrbmambra2ln1", "dx_zm_ltsr_tesr_ambr_tsrbmambra2ln2" ], [ "dx_zm_ltsr_tesr_ambr_tsrbmambra3" ] ];
    data[ "nikolai" ] = [ [ "dx_zm_ltsr_tesr_mgnt_tsrbmmgnta1ln1", "dx_zm_ltsr_tesr_ward_tsrbmmgnta1ln2" ], [ "dx_zm_ltsr_tesr_ssrh_tsrbmmgnta2ln1", "dx_zm_ltsr_tesr_mgnt_tsrbmmgnta2ln2" ], [ "dx_zm_ltsr_tesr_mgnt_tsrbmmgnta3" ] ];
    data[ "richtofen" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrbmprpla1ln1", "dx_zm_ltsr_tesr_prpl_tsrbmprpla1ln2" ], [ "dx_zm_ltsr_tesr_prpl_tsrbmprpla2ln1", "dx_zm_ltsr_tesr_detw_tsrbmprpla2ln2", undefined ], [ "dx_zm_ltsr_tesr_prpl_tsrbmprpla3" ] ];
    data[ "takeo" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrbmscara1ln1", "dx_zm_ltsr_tesr_scar_tsrbmscara1ln2" ], [ "dx_zm_ltsr_tesr_scar_tsrbmscara2ln1", "dx_zm_ltsr_tesr_detw_tsrbmscara2ln2", "dx_zm_ltsr_tesr_lvtw_tsrbmscara2ln3" ], [ "dx_zm_ltsr_tesr_scar_tsrbmscara3" ] ];
    room.dialogues = { #data:data, #played:[] };
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0x8ead44b9, Offset: 0x3dc5
// Size: 0x26c
function private init_motel_dialogue( room )
{
    data = [];
    data[ "carver" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrmtcarva1ln1", "dx_zm_ltsr_tesr_carv_tsrmtcarva1ln2" ], [ "dx_zm_ltsr_tesr_carv_tsrmtcarva2ln1", "dx_zm_ltsr_tesr_detw_tsrmtcarva2ln2" ], [ "dx_zm_ltsr_tesr_carv_tsrmtcarva3" ] ];
    data[ "grey" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrmtgreya1ln1", "dx_zm_ltsr_tesr_grey_tsrmtgreya1ln2" ], [ "dx_zm_ltsr_tesr_ssrh_tsrmtgreya2ln1", "dx_zm_ltsr_tesr_grey_tsrmtgreya2ln2" ], [ "dx_zm_ltsr_tesr_grey_tsrmtgreya3" ] ];
    data[ "maya" ] = [ [ "dx_zm_ltsr_tesr_maya_tsrmtmayaa1ln1", "dx_zm_ltsr_tesr_ward_tsrmtmayaa1ln2" ], [ "dx_zm_ltsr_tesr_maya_tsrmtmayaa2ln1", "dx_zm_ltsr_tesr_ssfh_tsrmtmayaa2ln2" ], [ "dx_zm_ltsr_tesr_maya_tsrmtmayaa3" ] ];
    data[ "weaver" ] = [ [ "dx_zm_ltsr_tesr_weav_tsrmtweava1ln1", "dx_zm_ltsr_tesr_ward_tsrmtweava1ln2" ], [ "dx_zm_ltsr_tesr_weav_tsrmtweava2ln1", "dx_zm_ltsr_tesr_lvtw_tsrmtweava2ln2", "dx_zm_ltsr_tesr_detw_tsrmtweava2ln3" ], [ "dx_zm_ltsr_tesr_weav_tsrmtweava3" ] ];
    data[ "dempsey" ] = [ [ "dx_zm_ltsr_tesr_ambr_tsrmtambra1ln1", "dx_zm_ltsr_tesr_ward_tsrmtambra1ln2" ], [ "dx_zm_ltsr_tesr_ssfh_tsrmtambra2ln1", "dx_zm_ltsr_tesr_ambr_tsrmtambra2ln2" ], [ "dx_zm_ltsr_tesr_ambr_tsrmtambra3" ] ];
    data[ "nikolai" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrmtmgnta1ln1", "dx_zm_ltsr_tesr_mgnt_tsrmtmgnta1ln2" ], [ "dx_zm_ltsr_tesr_mgnt_tsrmtmgnta2ln1", "dx_zm_ltsr_tesr_ssrh_tsrmtmgnta2ln2" ], [ "dx_zm_ltsr_tesr_mgnt_tsrmtmgnta3" ] ];
    data[ "richtofen" ] = [ [ "dx_zm_ltsr_tesr_prpl_tsrmtprpla1ln1", "dx_zm_ltsr_tesr_ward_tsrmtprpla1ln2" ], [ "dx_zm_ltsr_tesr_lvtw_tsrmtprpla2ln1", "dx_zm_ltsr_tesr_prpl_tsrmtprpla2ln2" ], [ "dx_zm_ltsr_tesr_prpl_tsrmtprpla3" ] ];
    data[ "takeo" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrmtscara1ln1", "dx_zm_ltsr_tesr_scar_tsrmtscara1ln2" ], [ "dx_zm_ltsr_tesr_psor_tsrmtscara2ln1", "dx_zm_ltsr_tesr_scar_tsrmtscara2ln2" ], [ "dx_zm_ltsr_tesr_scar_tsrmtscara3" ] ];
    room.dialogues = { #data:data, #played:[] };
}

// Namespace zm_sat_locust_rej
// Params 1, eflags: 0x4
// Checksum 0xfb237b51, Offset: 0x4039
// Size: 0x252
function private init_corridor_dialogue( room )
{
    data = [];
    data[ "carver" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrcrcarva1ln1", "dx_zm_ltsr_tesr_carv_tsrcrcarva1ln2" ], [ undefined ], [ "dx_zm_ltsr_tesr_carv_tsrcrcarva3" ] ];
    data[ "grey" ] = [ [ undefined ], [ "dx_zm_ltsr_tesr_grey_tsrcrgreya2" ], [ "dx_zm_ltsr_tesr_grey_tsrcrgreya3" ] ];
    data[ "maya" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrcrmayaa1ln1", "dx_zm_ltsr_tesr_maya_tsrcrmayaa1ln2" ], [ "dx_zm_ltsr_tesr_lvtw_tsrcrmayaa2ln1", "dx_zm_ltsr_tesr_maya_tsrcrmayaa2ln2" ], [ "dx_zm_ltsr_tesr_maya_tsrcrmayaa3" ] ];
    data[ "weaver" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrcrweava1ln1", "dx_zm_ltsr_tesr_weav_tsrcrweava1ln2" ], [ "dx_zm_ltsr_tesr_weav_tsrcrweava2ln1", "dx_zm_ltsr_tesr_detw_tsrcrweava2ln2" ], [ "dx_zm_ltsr_tesr_weav_tsrcrweava3" ] ];
    data[ "dempsey" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrcrambra1ln1", "dx_zm_ltsr_tesr_ambr_tsrcrambra1ln2" ], [ "dx_zm_ltsr_tesr_lvtw_tsrcrambra2ln1", "dx_zm_ltsr_tesr_ambr_tsrcrambra2ln2", "dx_zm_ltsr_tesr_detw_tsrcrambra2ln3" ], [ "dx_zm_ltsr_tesr_ambr_tsrcrambra3" ] ];
    data[ "nikolai" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrcrmgnta1ln1", "dx_zm_ltsr_tesr_mgnt_tsrcrmgnta1ln2" ], [ "dx_zm_ltsr_tesr_mgnt_tsrcrmgnta2" ], [ "dx_zm_ltsr_tesr_mgnt_tsrcrmgnta3" ] ];
    data[ "richtofen" ] = [ [ "dx_zm_ltsr_tesr_ward_tsrcrprpla1ln1", "dx_zm_ltsr_tesr_prpl_tsrcrprpla1ln2", "dx_zm_ltsr_tesr_ward_tsrcrprpla1ln3" ], [ "dx_zm_ltsr_tesr_prpl_tsrcrprpla2ln1", "dx_zm_ltsr_tesr_sslo_tsrcrprpla2ln2" ], [ "dx_zm_ltsr_tesr_prpl_tsrcrprpla3" ] ];
    data[ "takeo" ] = [ [ "dx_zm_ltsr_tesr_scar_tsrcrscara1ln1", "dx_zm_ltsr_tesr_ward_tsrcrscara1ln2" ], [ "dx_zm_ltsr_tesr_scar_tsrcrscara2ln1", "dx_zm_ltsr_tesr_detw_tsrcrscara2ln2", "dx_zm_ltsr_tesr_scar_tsrcrscara2ln3" ], [ "dx_zm_ltsr_tesr_scar_tsrcrscara3" ] ];
    room.dialogues = { #data:data, #played:[] };
}

/#

    // Namespace zm_sat_locust_rej
    // Params 0, eflags: 0x4
    // Checksum 0x56aa0809, Offset: 0x4293
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_sat_locust_rej
    // Params 0, eflags: 0x4
    // Checksum 0xd17773e5, Offset: 0x42a7
    // Size: 0x2d9, Type: dev
    function private devgui_init()
    {
        setdevdvarifuninitialized( @"hash_e53420f91b4c3c9", 0, 0, 1 );
        setdevdvarifuninitialized( @"hash_8cfef0dcd7cf8ac1", 0, 0, 3 );
        setdevdvarifuninitialized( @"hash_e372274a6bcf3212", 0, 0, 8 );
        devgui::function_9082edeb5db93280( "<dev string:xc7>" );
        room_names = [ "<dev string:xec>", "<dev string:xf5>", "<dev string:xfb>" ];
        
        for ( i = 0; i < level.robot_ejection_tubes.narrative_rooms.size ; i++ )
        {
            room = level.robot_ejection_tubes.narrative_rooms[ i ];
            room_name = room_names[ room.script_index - 1 ];
            devgui::function_cd4e263c1f3018ae( "<dev string:x104>" + room_name + "<dev string:x110>", "<dev string:x116>" + i, &function_fd1b9037a9486b8b );
            devgui::function_cd4e263c1f3018ae( "<dev string:x104>" + room_name + "<dev string:x126>", "<dev string:x12f>" + i, &function_19370230a5633071 );
            
            foreach ( key, val in level.robot_ejection_tubes.narrative_rooms[ i ].dialogues.data )
            {
                foreach ( idx, alt in val )
                {
                    devgui::function_cd4e263c1f3018ae( "<dev string:x140>" + room_name + "<dev string:x14f>" + key + "<dev string:x14f>" + idx + 1, "<dev string:x151>" + i + "<dev string:x164>" + key + "<dev string:x164>" + idx, &function_546b029907402628 );
                }
            }
        }
        
        devgui::add_devgui_dvar( "<dev string:x166>", @"hash_8cfef0dcd7cf8ac1" );
        devgui::add_devgui_dvar( "<dev string:x17d>", @"hash_e372274a6bcf3212" );
        devgui::function_eaac4ba4b3caf621( "<dev string:x195>", @"hash_e53420f91b4c3c9" );
        devgui::add_devgui_func( "<dev string:x1b1>", "<dev string:x1c5>", &function_5041e3785da53a07 );
        devgui::add_devgui_func( "<dev string:x1d6>", "<dev string:x1e5>", &function_2744b580ba622c0e );
        devgui::add_devgui_func( "<dev string:x1f4>", "<dev string:x206>", &function_f555955867537180 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_rej
    // Params 1, eflags: 0x4
    // Checksum 0xef02b9f0, Offset: 0x4588
    // Size: 0x26, Type: dev
    function private function_fd1b9037a9486b8b( args )
    {
        level.player thread function_6608371ef472e561( int( args[ 0 ] ) );
    }

    // Namespace zm_sat_locust_rej
    // Params 1, eflags: 0x4
    // Checksum 0x57465e88, Offset: 0x45b6
    // Size: 0x6e, Type: dev
    function private function_19370230a5633071( args )
    {
        contents = trace::create_character_contents();
        trace = zm_sat_locust_util::get_player_trace( level.player, getaiarray(), contents );
        
        if ( trace[ "<dev string:x217>" ] && isplayer( trace[ "<dev string:x217>" ] ) )
        {
            trace[ "<dev string:x217>" ] thread function_6608371ef472e561( int( args[ 0 ] ) );
        }
    }

    // Namespace zm_sat_locust_rej
    // Params 1, eflags: 0x4
    // Checksum 0xc7b57a7c, Offset: 0x462c
    // Size: 0x157, Type: dev
    function private function_6608371ef472e561( index )
    {
        destination = level.robot_ejection_tubes.narrative_rooms[ index ];
        increment_usage( self );
        landing_destination = function_b938ebbbff3b0b39( level.robot_ejection_tubes.random_landings, 1 );
        landing_destination thread function_c5cf411876d55854( destination );
        function_6b4a863987e3a49( destination.origin, vectortoangles( destination.origin - self.origin ) );
        function_5e6fbf9ef5db2557( destination.origin, 0, destination.angles, 1 );
        destination.player = self;
        played = function_62fb0f329a6049d5( destination );
        
        while ( !self meleebuttonpressed() )
        {
            waitframe();
        }
        
        destination.player = undefined;
        function_6b4a863987e3a49( landing_destination.origin + ( 0, 0, landing_destination.script_int ), vectortoangles( landing_destination.origin - self.origin ) );
        function_5e6fbf9ef5db2557( landing_destination.origin, landing_destination.script_int, landing_destination.angles, 0 );
        decrement_usage( self, destination );
    }

    // Namespace zm_sat_locust_rej
    // Params 1, eflags: 0x4
    // Checksum 0x521b88af, Offset: 0x478b
    // Size: 0x17, Type: dev
    function private function_5041e3785da53a07( args )
    {
        level thread function_299be440a465c91e();
    }

    // Namespace zm_sat_locust_rej
    // Params 0, eflags: 0x4
    // Checksum 0x4589f770, Offset: 0x47aa
    // Size: 0x16c, Type: dev
    function private function_299be440a465c91e()
    {
        if ( utility::flag( "<dev string:x1c5>" ) )
        {
            level.player.rej_link notify( #"movedone" );
            level.player function_446fceff58281321();
            level.player.rej_link thread utility::delete_after_delay( level.framedurationseconds );
            utility::flag_clear( "<dev string:x1c5>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x1c5>" );
        }
        
        level.player prepare_player( 1 );
        level.player function_c52f914088fc2a7f( level.player.origin, level.player getplayerangles() );
        level.player.rej_link = level.player utility::spawn_tag_origin( level.player.origin, level.player getplayerangles() );
        actor = level.player function_9b26b9212e8a24b( level.player.rej_link.origin, level.player.rej_link.angles );
        level.player thread play_falling_anim( actor );
    }

    // Namespace zm_sat_locust_rej
    // Params 1, eflags: 0x4
    // Checksum 0xe9e4ad5b, Offset: 0x491e
    // Size: 0x72, Type: dev
    function private function_2744b580ba622c0e( params )
    {
        players = level.players;
        
        if ( players.size > 1 )
        {
            players = arrayremove( players, level.player );
            player = function_47c86977a18df38b( players, level.player.origin );
        }
        else
        {
            player = players[ 0 ];
        }
        
        player thread blast_nearby_enemies();
    }

    // Namespace zm_sat_locust_rej
    // Params 1, eflags: 0x4
    // Checksum 0x4b45752, Offset: 0x4998
    // Size: 0x1f, Type: dev
    function private function_f555955867537180( params )
    {
        level.player thread function_eb0bfcc2efad6dbb();
    }

    // Namespace zm_sat_locust_rej
    // Params 0, eflags: 0x4
    // Checksum 0xaa011848, Offset: 0x49bf
    // Size: 0x2a, Type: dev
    function private function_eb0bfcc2efad6dbb()
    {
        function_db4902451e1e6733( 5 );
        hud_util::fade_in( 1, "<dev string:x21e>" );
        release_player_early();
        function_446fceff58281321();
    }

    // Namespace zm_sat_locust_rej
    // Params 1, eflags: 0x4
    // Checksum 0x883506e5, Offset: 0x49f1
    // Size: 0x78, Type: dev
    function private function_546b029907402628( params )
    {
        room_idx = int( params[ 0 ] );
        key = params[ 1 ];
        alt = int( params[ 2 ] );
        room = level.robot_ejection_tubes.narrative_rooms[ room_idx ];
        level.player function_62fb0f329a6049d5( room, alt, key, 1 );
    }

#/
