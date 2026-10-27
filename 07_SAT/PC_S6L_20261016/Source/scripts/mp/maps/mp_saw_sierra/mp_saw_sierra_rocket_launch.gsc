// scripts\mp\maps\mp_saw_sierra\mp_saw_sierra_rocket_launch.gsc  (hash_16a0ffb5b31259f8.gscc) (size: 19608 Bytes / 0x4c98 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2741047b (658572411)
// size ...... 19608 (0x4c98)
// includes .. 11  (offset: 0x46c4)
// strings ... 72  (offset: 0x471c)
// dev strs .. 29  (offset: 0x4b0c)
// exports ... 54  (offset: 0x2d70)
// cseg ...... 0x608 + 0x2768 (0x2d70)
// imports ... 139 (offset: 0x35e0)
// animtree1 . 0   (offset: 0x4c70)
// animtree2 . 2   (offset: 0x4c70)
#using scripts\anim\utility;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_bunker_utility;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\flags;
#using scripts\mp\movers;

#namespace mp_saw_sierra_rocket_launch;

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x5
// Checksum 0x2aede13b, Offset: 0x626
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"saw_sierra_rocket_launch", undefined, undefined, &post_main );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x32f1a930, Offset: 0x647
// Size: 0x181
function private post_main()
{
    level thread underground_door_lock();
    level.rocket_launch = {};
    init_blast_doors();
    
    if ( !getdvarint( @"hash_9be4acae4feb9f30", 0 ) )
    {
        level thread keypad_init();
    }
    
    if ( !getdvarint( @"hash_ea8e57c339cf8ab1", 0 ) )
    {
        rocket_clip = getent( "rocket_launch_clip", #targetname );
        
        if ( rocket_clip )
        {
            rocket_clip delete();
        }
        
        clamp_spawns = utility::getstructarray( "rocket_launch_clamp_l", "target" );
        function_755490869c2535d2( clamp_spawns );
        clamp_spawns = utility::getstructarray( "rocket_launch_clamp_r", "target" );
        function_755490869c2535d2( clamp_spawns );
        return;
    }
    
    level.rocket_launch.states = [ "end":&state_end, "launch":&state_launch, "countdown":&state_countdown, "pad":&state_pad, "mover":&state_mover, "hangar":&state_hangar ];
    function_50f9d7b4c3c9d101();
    init_sfx();
    utility::registersharedfunc( #"sierra_rocket_launch", #"hash_93d124e62702ef13", &function_8815146f1b4416ac );
    utility::registersharedfunc( #"sierra_rocket_launch", #"hash_8f63d751a0b02c71", &function_2de07827890fb0b4 );
    
    if ( getdvarint( @"hash_bbe8834cb0397ea8", 1 ) )
    {
        level thread function_9e72f6e1cb201f2e();
    }
    
    run_state( "hangar" );
    
    /#
        init_debug();
    #/
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x5b0a7930, Offset: 0x7d0
// Size: 0x73
function private init_sfx()
{
    level thread init_mover_sfx();
    level.rocket_launch.sfx = [ "gantry":spawnscriptable( "saw_sierra_rocket_launch_gantry_alert_sfx", ( -22508.1, -36642.5, 2680.07 ) ), "control_room":spawnscriptable( "saw_sierra_rocket_launch_control_alert_sfx", ( -16254.1, -34027.6, 1392.07 ) ), "hangar":spawnscriptable( "saw_sierra_rocket_launch_hangar_alert_sfx", ( -19216.4, -38177.4, 2512.07 ) ) ];
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x5575494f, Offset: 0x84b
// Size: 0x2cc
function private function_50f9d7b4c3c9d101()
{
    _ = level.rocket_launch;
    _.mover = getent( "rocket_launch_mover", #targetname );
    _.mover.clip = getent( "rocket_launch_mover_clip", #targetname );
    _.mover.clip linkto( _.mover );
    _.mover.clip forcenetfieldhighlod( 1 );
    _.mover.clip setmoverantilagged( 1 );
    _.mover.clip setmoveroptimized( 1 );
    _.mover.clip.var_87038cec80bd2c66 = 0;
    _.mover.clip.var_5ae0f89cc91f22ec = 0;
    _.mover.clip.override_unresolved_collision = &handle_unresolved_collision;
    _.mover.positions = [];
    _.mover.positions[ 0 ] = _.mover.origin;
    _.mover.positions[ 1 ] = utility::getstruct( "rocket_mover_end" ).origin;
    _.spawn = utility::getstruct( "rocket_launch_spawn" );
    _.rocket = getent( "rocket_launch_clip", #targetname );
    _.rocket.offset = _.rocket.origin - _.spawn.origin;
    _.launchpad_origin = utility::getstruct( "rocket_mover_end" ).origin + _.spawn.origin - _.mover.positions[ 0 ];
    _.clamp_l = init_clamp( "rocket_launch_clamp_l", "rocket_clamp_collision_l" );
    _.clamp_r = init_clamp( "rocket_launch_clamp_r", "rocket_clamp_collision_r" );
    _.rocket_damage_volume = getnoentvolumearray( "rocket_launch_damage_volume", #targetname )[ 0 ];
}

// Namespace mp_saw_sierra_rocket_launch
// Params 2, eflags: 0x4
// Checksum 0xd1a136f4, Offset: 0xb1f
// Size: 0x19f
function private init_clamp( root_targetname, clip_targetname )
{
    clamp_ent = getent( clip_targetname, #targetname );
    clamp_ent.var_c0c940b175bdf3ca = utility::getstruct( root_targetname );
    offset = clamp_ent.origin - clamp_ent.var_c0c940b175bdf3ca.origin;
    clamp_ent.retracted_origin = clamp_ent.var_c0c940b175bdf3ca.origin + offset;
    clamp_ent.var_86bbc8a122280f31 = utility::getstruct( clamp_ent.var_c0c940b175bdf3ca.target ).origin + offset;
    clamp_spawns = utility::getstructarray( root_targetname, "target" );
    side = root_targetname[ root_targetname.size - 1 ] == "l" ? "left" : "right";
    
    if ( clamp_spawns[ 0 ].origin[ 2 ] > clamp_spawns[ 1 ].origin[ 2 ] )
    {
        clamp_spawns[ 0 ].script_noteworthy = "sfx_top_" + side;
        clamp_spawns[ 1 ].script_noteworthy = "sfx_bottom_" + side;
    }
    else
    {
        clamp_spawns[ 1 ].script_noteworthy = "sfx_top_" + side;
        clamp_spawns[ 0 ].script_noteworthy = "sfx_bottom_" + side;
    }
    
    clamp_ent.scriptables = function_755490869c2535d2( clamp_spawns, clamp_ent );
    return clamp_ent;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x19937731, Offset: 0xcc7
// Size: 0x1cb
function private init_blast_doors()
{
    _ = level.rocket_launch;
    _.blast_doors = { #var_6a322deff9284a9a:0, #are_open:0, #clip:getentarray( "blast_doors_clip", #targetname ), #ent:getent( "blast_doors_script_model", #targetname ) };
    
    foreach ( clip in _.blast_doors.clip )
    {
        clip forcenetfieldhighlod( 1 );
        clip setmoverantilagged( 1 );
        clip setmoveroptimized( 1 );
        clip setmovingplatformdef( "movingplatform_rotator" );
        clip.var_87038cec80bd2c66 = 0;
        clip.var_27c250029fc222fc = 1;
        clip.var_5ae0f89cc91f22ec = 0;
        clip.override_unresolved_collision = &handle_unresolved_collision;
        tag = clip.script_noteworthy == "blast_doors_clip_side_1" ? "tag_clip_side_1" : "tag_clip_side_2";
        clip linkto( _.blast_doors.ent, tag );
        clip.var_23e47383147e0df4 = anglestoright( _.blast_doors.ent gettagangles( tag ) );
    }
    
    init_blast_door_anims();
    level thread init_blast_doors_button();
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xb2e98b25, Offset: 0xe9a
// Size: 0xf4
function private init_blast_doors_button()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    _ = level.rocket_launch.blast_doors;
    
    if ( !getdvarint( @"hash_ebb3efd8ca89ab4d", 0 ) )
    {
        _.button = getentitylessscriptablearray( "blast_doors_button", #targetname )[ 0 ];
        _.button setscriptablepartstate( #"saw_sierra_rocket_launch_button", #"usable" );
        _.button setscriptablepartstate( #"light", #"red" );
        _.button setscriptablepartstate( #"health_listener", #"on" );
        scriptable::scriptable_addusedcallbackbypart( "saw_sierra_rocket_launch_button", &blast_doors_button_interact );
        _.button thread function_4ac392a16b54fd31();
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xa34fe80a, Offset: 0xf96
// Size: 0x1d7
function private init_mover_sfx()
{
    level endon( #"game_ended" );
    mover = level.rocket_launch.mover;
    locations = [ [ "front", ( -18867.4, -38342.4, 753.07 ) ], [ "front_left", ( -18799.5, -38537.3, 753.07 ) ], [ "front_right", ( -18674.4, -38269.1, 753.07 ) ], [ "back_left", ( -18493.5, -38666.8, 793.07 ) ], [ "back_right", ( -18378.6, -38420.3, 793.07 ) ], [ "back", ( -18330.9, -38592.5, 793.07 ) ] ];
    utility::flag_wait( "scriptables_ready" );
    mover.sfx = [];
    
    foreach ( location in locations )
    {
        offset = rotatevector( location[ 1 ] - mover.origin, mover.angles * -1 );
        scriptable = spawnscriptable( "saw_sierra_rocket_launch_mover_sfx", offset, undefined, mover );
        scriptable setscriptablepartstate( location[ 0 ], "idle" );
        mover.sfx[ location[ 0 ] ] = scriptable;
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 2, eflags: 0x4
// Checksum 0xa895525f, Offset: 0x1175
// Size: 0x101
function private function_755490869c2535d2( spawns, parent )
{
    scriptables = [];
    offset = parent ? parent.origin : ( 0, 0, 0 );
    
    foreach ( s in spawns )
    {
        scriptable = spawnscriptable( "saw_sierra_rocket_launch_clamp", s.origin - offset, s.angles, parent );
        scriptable.part_name = s.script_noteworthy;
        scriptables[ scriptables.size ] = scriptable;
    }
    
    return scriptables;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xdfd5cdc, Offset: 0x127f
// Size: 0x19
function private function_9e72f6e1cb201f2e()
{
    waitframe();
    flags::gameflagwait( "prematch_fade_done" );
    wait 30;
    function_397d171880f795fd();
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x6b761cb2, Offset: 0x12a0
// Size: 0x4e
function private function_397d171880f795fd()
{
    level endon( #"game_ended" );
    level endon( #"stop_rocket_launch" );
    run_state( "mover" );
    run_state( "pad" );
    
    if ( getdvarint( @"hash_3a4784ba9103fa51", 1 ) )
    {
        wait 5;
        function_bf40020d2b2934dd();
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xad2de6f5, Offset: 0x12f6
// Size: 0x3e
function private function_bf40020d2b2934dd()
{
    level endon( #"game_ended" );
    level endon( #"stop_rocket_launch" );
    run_state( "countdown" );
    run_state( "launch" );
    run_state( "end" );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0xb157b981, Offset: 0x133c
// Size: 0x3b
function private run_state( state )
{
    level.rocket_launch.state = state;
    [[ level.rocket_launch.states[ state ] ]]();
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0xaa929da0, Offset: 0x137f
// Size: 0xca
function private spawn_rocket( origin )
{
    level.rocket_launch.rocket.origin = origin + level.rocket_launch.rocket.offset;
    level.rocket_launch.rocket.scriptable = spawnscriptable( "saw_sierra_rocket_launch_rocket", level.rocket_launch.rocket.offset * -1, level.rocket_launch.spawn.angles, level.rocket_launch.rocket, function_67b78af3c33ac9a8( 0.8 ) );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xc8f59ef2, Offset: 0x1451
// Size: 0x89
function private destroy_rocket()
{
    /#
        if ( getdvarint( @"hash_7b30b5a10d710b9d", 0 ) )
        {
            level.rocket_launch.rocket.scriptable freescriptable();
            return;
        }
    #/
    
    if ( level.rocket_launch.rocket )
    {
        level.rocket_launch.rocket.scriptable freescriptable();
        level.rocket_launch.rocket delete();
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x8797970, Offset: 0x14e2
// Size: 0x59
function private state_hangar()
{
    mover_move( 0 );
    spawn_rocket( level.rocket_launch.spawn.origin );
    level.rocket_launch.rocket linkto( level.rocket_launch.mover );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xc9b0511, Offset: 0x1543
// Size: 0x30
function private state_mover()
{
    level endon( #"game_ended" );
    function_a077472e525b0f75( "hangar" );
    wait 3;
    clamps_set_state( 0 );
    mover_move( 1, 57 );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xe0a4fb13, Offset: 0x157b
// Size: 0x8f
function private state_pad()
{
    level endon( #"game_ended" );
    mover_move( 1 );
    clamps_set_state( 0 );
    level.rocket_launch.rocket unlink();
    level.rocket_launch.rocket moveby( ( 0, 0, 50 ), 5, 1, 1 );
    clamps_close();
    wait 6;
    function_a077472e525b0f75( "gantry" );
    function_a077472e525b0f75( "control_room" );
    level thread mover_move( 0, 60 );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xec06ebee, Offset: 0x1612
// Size: 0x5a
function private state_countdown()
{
    level endon( #"game_ended" );
    countdown_time = getdvarint( @"hash_36f3df9e18a61705", 10 );
    level thread blast_doors_set_state( 1 );
    
    while ( countdown_time > 0 )
    {
        countdown_time--;
        
        /#
            iprintlnbold( countdown_time );
        #/
        
        wait 1;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xbba94216, Offset: 0x1674
// Size: 0x78
function private state_launch()
{
    level endon( #"game_ended" );
    level.rocket_launch.rocket.scriptable setscriptablepartstate( "body", "rocket_launch" );
    level thread function_5c0585ee77f0f8f0();
    wait 1;
    clamps_open();
    level.rocket_launch.rocket moveby( ( 0, 0, 50000 ), 40, 30 );
    wait 40;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x7a26f942, Offset: 0x16f4
// Size: 0x9
function private state_end()
{
    destroy_rocket();
}

// Namespace mp_saw_sierra_rocket_launch
// Params 2, eflags: 0x4
// Checksum 0xb42204ab, Offset: 0x1705
// Size: 0xba
function private mover_move( position_index, time = 0 )
{
    level endon( #"game_ended" );
    origin = level.rocket_launch.mover.positions[ position_index ];
    
    if ( time > 0 )
    {
        level.rocket_launch.mover moveto( origin, time, 5, 5 );
        function_eddd56eba366620a( 1 );
        wait time;
        function_eddd56eba366620a( 0 );
        return;
    }
    
    level.rocket_launch.mover.origin = origin;
    function_eddd56eba366620a( 0 );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0x25bf1a54, Offset: 0x17c7
// Size: 0xaa
function private function_eddd56eba366620a( is_moving )
{
    foreach ( location, scriptable in level.rocket_launch.mover.sfx )
    {
        scriptable setscriptablepartstate( location, is_moving ? "moving" : "idle" );
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x9673e051, Offset: 0x1879
// Size: 0x78
function private clamps_close()
{
    function_cae958ebed416007( 0 );
    level.rocket_launch.clamp_l moveto( level.rocket_launch.clamp_l.var_86bbc8a122280f31, 5 );
    level.rocket_launch.clamp_r moveto( level.rocket_launch.clamp_r.var_86bbc8a122280f31, 5 );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x15b32c18, Offset: 0x18f9
// Size: 0x79
function private clamps_open()
{
    function_cae958ebed416007( 1 );
    level.rocket_launch.clamp_l moveto( level.rocket_launch.clamp_l.retracted_origin, 5 );
    level.rocket_launch.clamp_r moveto( level.rocket_launch.clamp_r.retracted_origin, 5 );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0xc299653f, Offset: 0x197a
// Size: 0x152
function private function_cae958ebed416007( is_opening )
{
    foreach ( scriptable in level.rocket_launch.clamp_l.scriptables )
    {
        scriptable setscriptablepartstate( scriptable.part_name, is_opening ? "opening" : "closing" );
    }
    
    foreach ( scriptable in level.rocket_launch.clamp_r.scriptables )
    {
        scriptable setscriptablepartstate( scriptable.part_name, is_opening ? "opening" : "closing" );
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0xc812e318, Offset: 0x1ad4
// Size: 0xcc
function private clamps_set_state( is_closed )
{
    level.rocket_launch.clamp_l.origin = is_closed ? level.rocket_launch.clamp_l.var_86bbc8a122280f31 : level.rocket_launch.clamp_l.retracted_origin;
    level.rocket_launch.clamp_r.origin = is_closed ? level.rocket_launch.clamp_r.var_86bbc8a122280f31 : level.rocket_launch.clamp_r.retracted_origin;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x7127ce4, Offset: 0x1ba8
// Size: 0x258
function private function_5c0585ee77f0f8f0()
{
    level endon( #"game_ended" );
    damage_time_seconds = 10;
    end_timestamp = gettime() + damage_time_seconds * 1000;
    earthquakeadvanced( 0.3, 0.2, 0.1, damage_time_seconds, level.rocket_launch.rocket.scriptable.origin, 512, 1024, 2048 );
    level.rocket_launch.rocket_damage_volume.ents = [];
    trigger::makeenterexittrigger( level.rocket_launch.rocket_damage_volume, &enter_damage_trigger, &exit_damage_trigger );
    damage_radius = level.rocket_launch.rocket_damage_volume.radius * level.rocket_launch.rocket_damage_volume.radius;
    
    while ( gettime() < end_timestamp )
    {
        foreach ( ent in level.rocket_launch.rocket_damage_volume.ents )
        {
            if ( ent.origin[ 2 ] < level.rocket_launch.rocket.scriptable.origin[ 2 ] )
            {
                damage_mult = 1 - clamp( distancesquared( ent.origin, level.rocket_launch.rocket.scriptable.origin ) / damage_radius, 0, 1 );
                ent dodamage( 300 * damage_mult, ent.origin, level.rocket_launch.rocket, level.rocket_launch.rocket );
            }
        }
        
        wait 1;
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 3, eflags: 0x4
// Checksum 0xa6de1ed7, Offset: 0x1e08
// Size: 0x33
function private enter_damage_trigger( ent, trigger, payload )
{
    trigger.ents[ ent getentitynumber() ] = ent;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 3, eflags: 0x4
// Checksum 0x1a41ac7c, Offset: 0x1e43
// Size: 0x30
function private exit_damage_trigger( ent, trigger, payload )
{
    trigger.ents[ ent getentitynumber() ] = undefined;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x1e0ec147, Offset: 0x1e7b
// Size: 0x3b
function private function_2de07827890fb0b4()
{
    if ( level.rocket_launch.state == "pad" )
    {
        level thread function_bf40020d2b2934dd();
        return 1;
    }
    
    /#
        iprintlnbold( "<dev string:x2d>" );
    #/
    
    return 0;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xbc17a40b, Offset: 0x1ebe
// Size: 0x3b
function private function_8815146f1b4416ac()
{
    if ( level.rocket_launch.state == "hangar" )
    {
        level thread function_397d171880f795fd();
        return 1;
    }
    
    /#
        iprintlnbold( "<dev string:x60>" );
    #/
    
    return 0;
}

#using_animtree( "scriptables" );

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x67b21ad4, Offset: 0x1f01
// Size: 0xa4
function private init_blast_door_anims()
{
    level.rocket_launch.blast_doors.anims = [ { #length:getanimlength( %saw_sierra_crius_machinery_rocket_blast_walls_close ), #ref:%saw_sierra_crius_machinery_rocket_blast_walls_close }, { #length:getanimlength( %saw_sierra_crius_machinery_rocket_blast_walls_open ), #ref:%saw_sierra_crius_machinery_rocket_blast_walls_open } ];
    level.rocket_launch.blast_doors.are_open = 1;
    level thread blast_doors_set_state( 0 );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0x2370805c, Offset: 0x1fad
// Size: 0x235
function private blast_doors_set_state( to_open )
{
    if ( to_open == level.rocket_launch.blast_doors.are_open )
    {
        return;
    }
    
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    animation = level.rocket_launch.blast_doors.anims[ to_open ];
    level.rocket_launch.blast_doors.ent scriptmodelplayanim( animation.ref, "blast_doors_anim", 0, 1 );
    level.rocket_launch.blast_doors.var_6a322deff9284a9a = 1;
    
    if ( level.rocket_launch.blast_doors.button )
    {
        level.rocket_launch.blast_doors.button setscriptablepartstate( #"saw_sierra_rocket_launch_button", #"unusable" );
        level.rocket_launch.blast_doors.button setscriptablepartstate( #"light", to_open ? #"green" : #"red" );
    }
    
    wait animation.length * 0.5;
    
    if ( to_open )
    {
        function_fb10afaf950be9a0( 100 );
    }
    
    wait animation.length * 0.5;
    
    if ( to_open )
    {
        function_fb10afaf950be9a0( 20 );
    }
    
    level.rocket_launch.blast_doors.are_open = to_open;
    level.rocket_launch.blast_doors.var_6a322deff9284a9a = 0;
    
    if ( level.rocket_launch.blast_doors.button )
    {
        level.rocket_launch.blast_doors.button setscriptablepartstate( #"saw_sierra_rocket_launch_button", #"usable" );
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0x32d5ae2d, Offset: 0x21ea
// Size: 0x1af
function private function_fb10afaf950be9a0( push_distance )
{
    mover = spawn( "script_model", ( 0, 0, 0 ) );
    mover setmodel( "tag_origin" );
    
    foreach ( clip in level.rocket_launch.blast_doors.clip )
    {
        if ( !clip.linkedchildren.size )
        {
            continue;
        }
        
        foreach ( scriptable in clip.linkedchildren )
        {
            scriptable utility::scriptable_clearparententity();
            mover.origin = scriptable.origin;
            scriptable scriptablesetparententity( mover );
            mover.origin = getgroundposition( mover.origin + clip.var_23e47383147e0df4 * push_distance, 10 ) + ( 0, 0, level.var_608f2b17211c7ff4 );
            waitframe();
            scriptable scriptableclearparententity();
        }
    }
    
    mover delete();
}

// Namespace mp_saw_sierra_rocket_launch
// Params 2, eflags: 0x4
// Checksum 0x14dff3d2, Offset: 0x23a1
// Size: 0xb8
function private handle_unresolved_collision( player, ballowsuicide )
{
    if ( self.var_87038cec80bd2c66 == 0 )
    {
        if ( self.var_27c250029fc222fc && isdefined( self.owner ) && self.owner.team != player.team )
        {
            player kill( self.origin, self.owner, self, "MOD_CRUSH" );
            return;
        }
        
        if ( !isdefined( ballowsuicide ) )
        {
            ballowsuicide = 1;
        }
        
        if ( ballowsuicide )
        {
            if ( !getdvarint( @"hash_60159c88e0599409", 1 ) && self.var_7814545a8310756d )
            {
                return;
            }
            
            player movers::mover_suicide();
        }
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 6, eflags: 0x4
// Checksum 0x17f9102a, Offset: 0x2461
// Size: 0x69
function private blast_doors_button_interact( instance, part, state, player, bautouse, usestring )
{
    instance setscriptablepartstate( #"hash_1aa9c45c0f9ef371", #"hash_a75fb0417dcf725" );
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    function_68cd10fd85cf1b01();
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xf644ddba, Offset: 0x24d2
// Size: 0x25
function private function_4ac392a16b54fd31()
{
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( #"damaged" );
        function_68cd10fd85cf1b01();
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0x7154af2d, Offset: 0x24ff
// Size: 0x57
function private function_68cd10fd85cf1b01()
{
    if ( level.rocket_launch.blast_doors.var_6a322deff9284a9a )
    {
        return;
    }
    
    new_state = !level.rocket_launch.blast_doors.are_open;
    level thread blast_doors_set_state( new_state );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0, eflags: 0x4
// Checksum 0xd1634497, Offset: 0x255e
// Size: 0xad
function private underground_door_lock()
{
    if ( !getdvarint( @"hash_d25eaddd22426c14", 0 ) )
    {
        return;
    }
    
    utility::flag_wait( "scriptables_ready" );
    var_5c173c6fdf271109 = getentitylessscriptablearray( "crius_tunnel_door", #targetname );
    
    foreach ( door in var_5c173c6fdf271109 )
    {
        door scriptabledoorlock();
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 0
// Checksum 0xb86f2421, Offset: 0x2613
// Size: 0x180
function keypad_init()
{
    flags::function_2f3408423ccc9b2e( "infil_animatic_complete" );
    setdvar( @"ui_bunker_keypad_active", 1 );
    scriptable::scriptable_addusedcallbackbypart( "keypad_interact_nomodel", &keypad_on_use );
    level.rocket_launch.keypads = [];
    keypad = spawnscriptable( "keypad_interact_nomodel", ( -17848, -41579, -233 ) );
    keypad.backwallkeypad = 1;
    keypad.script_codelength = "01011000".size;
    keypad.code[ "string" ] = "01011000";
    keypad.successfunction = &function_561e78789b4d65a6;
    keypad.var_f026366dba547f4c = 1;
    level.rocket_launch.keypads[ level.rocket_launch.keypads.size ] = keypad;
    keypad = spawnscriptable( "keypad_interact_nomodel", ( -17250, -44293, 26 ) );
    keypad.backwallkeypad = 1;
    keypad.script_codelength = "01011000".size;
    keypad.code[ "string" ] = "01011000";
    keypad.successfunction = &function_561e78789b4d65a6;
    keypad.var_f026366dba547f4c = 1;
    level.rocket_launch.keypads[ level.rocket_launch.keypads.size ] = keypad;
}

// Namespace mp_saw_sierra_rocket_launch
// Params 6, eflags: 0x4
// Checksum 0x4c7b8a64, Offset: 0x279b
// Size: 0x48
function private keypad_on_use( instance, part, state, player, bautouse, usestring )
{
    level thread keypad_use( instance, part, state, player, bautouse );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 5, eflags: 0x4
// Checksum 0xbc1c8e27, Offset: 0x27eb
// Size: 0x8e
function private keypad_use( instance, part, state, player, bautouse )
{
    instance setscriptablepartstate( "keypad_interact_nomodel", "unusable" );
    player br_bunker_utility::keypad_playerinteractwithkeypadloop( instance );
    
    if ( isdefined( player ) )
    {
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }
    
    if ( instance.codestatus == 2 )
    {
        instance.completed = 1;
        return;
    }
    
    instance setscriptablepartstate( "keypad_interact_nomodel", "usable" );
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0x323006a5, Offset: 0x2881
// Size: 0x19b
function private function_561e78789b4d65a6( keypad )
{
    level endon( #"game_ended" );
    level notify( #"hash_4deabe136a401e2f" );
    
    foreach ( keypad in level.rocket_launch.keypads )
    {
        keypad setscriptablepartstate( "keypad_interact_nomodel", "unusable" );
    }
    
    self dlog_recordplayerevent( "dlog_event_br_bunker_data", [ "index", 0, "isaltbunker", 1, "success", 1 ] );
    points::function_40522c040a4e7b1( self.team, #"br_bunker_opened" );
    utility::callsharedfunc( #"br_bunkers", #"hash_7df9a859177613d0", 0 );
    bunker_doors = getentitylessscriptablearray( "bunker_door_0", "targetname" );
    
    foreach ( scriptable in bunker_doors )
    {
        level thread br_bunker_utility::openbunkerdoor( scriptable );
    }
}

// Namespace mp_saw_sierra_rocket_launch
// Params 1, eflags: 0x4
// Checksum 0xc5ef28f5, Offset: 0x2a24
// Size: 0x31
function private function_a077472e525b0f75( location )
{
    level.rocket_launch.sfx[ location ] setscriptablepartstate( "sfx", "on" );
}

/#

    // Namespace mp_saw_sierra_rocket_launch
    // Params 0, eflags: 0x4
    // Checksum 0x9371e477, Offset: 0x2a5d
    // Size: 0x107, Type: dev
    function private init_debug()
    {
        if ( !getdvarint( @"hash_7b30b5a10d710b9d", 0 ) )
        {
            return;
        }
        
        devgui::function_9082edeb5db93280( "<dev string:x96>" );
        devgui::add_devgui_func( "<dev string:xac>", "<dev string:xbc>", &function_8815146f1b4416ac );
        devgui::add_devgui_func( "<dev string:xd0>", "<dev string:xe2>", &function_2de07827890fb0b4 );
        devgui::add_devgui_func( "<dev string:xf8>", "<dev string:x112>", &function_e7fa22011ed8f886 );
        devgui::add_devgui_func( "<dev string:x123>", "<dev string:x13d>", &function_f56e442c91614ce6 );
        devgui::add_devgui_func( "<dev string:x153>", "<dev string:x16c>", &function_8416d9b591c58bde );
        devgui::add_devgui_func( "<dev string:x188>", "<dev string:x1a3>", &function_1b45c1b033f6bda5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ba>", "<dev string:x1d1>", &function_f793a50138cc5f31 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ea>", "<dev string:x202>", &function_f793a50138cc5f31 );
        devgui::add_devgui_func( "<dev string:x21b>", "<dev string:x22d>", &clamps_open );
        devgui::add_devgui_func( "<dev string:x23c>", "<dev string:x24f>", &clamps_close );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace mp_saw_sierra_rocket_launch
    // Params 0, eflags: 0x4
    // Checksum 0xace16aaa, Offset: 0x2b6c
    // Size: 0x1f, Type: dev
    function private debug_clear()
    {
        level notify( #"stop_rocket_launch" );
        destroy_rocket();
        function_86917977b45de751();
    }

    // Namespace mp_saw_sierra_rocket_launch
    // Params 0, eflags: 0x4
    // Checksum 0x1ac90e51, Offset: 0x2b93
    // Size: 0x18, Type: dev
    function private function_e7fa22011ed8f886()
    {
        debug_clear();
        run_state( "<dev string:x25f>" );
    }

    // Namespace mp_saw_sierra_rocket_launch
    // Params 0, eflags: 0x4
    // Checksum 0xd3aad351, Offset: 0x2bb3
    // Size: 0x1f, Type: dev
    function private function_f56e442c91614ce6()
    {
        debug_clear();
        run_state( "<dev string:x25f>" );
        function_397d171880f795fd();
    }

    // Namespace mp_saw_sierra_rocket_launch
    // Params 0, eflags: 0x4
    // Checksum 0x186ccba5, Offset: 0x2bda
    // Size: 0x32, Type: dev
    function private function_8416d9b591c58bde()
    {
        debug_clear();
        spawn_rocket( level.rocket_launch.launchpad_origin );
        run_state( "<dev string:x266>" );
    }

    // Namespace mp_saw_sierra_rocket_launch
    // Params 0, eflags: 0x4
    // Checksum 0x59991577, Offset: 0x2c14
    // Size: 0x39, Type: dev
    function private function_1b45c1b033f6bda5()
    {
        debug_clear();
        spawn_rocket( level.rocket_launch.launchpad_origin );
        run_state( "<dev string:x266>" );
        function_bf40020d2b2934dd();
    }

    // Namespace mp_saw_sierra_rocket_launch
    // Params 1, eflags: 0x4
    // Checksum 0xfd35d45f, Offset: 0x2c55
    // Size: 0x73, Type: dev
    function private function_f793a50138cc5f31( args )
    {
        if ( level.rocket_launch.blast_doors.var_6a322deff9284a9a )
        {
            return;
        }
        
        to_open = !level.rocket_launch.blast_doors.are_open;
        
        if ( args.size )
        {
            to_open = int( args[ 0 ] );
        }
        
        level thread blast_doors_set_state( to_open );
    }

    // Namespace mp_saw_sierra_rocket_launch
    // Params 0, eflags: 0x4
    // Checksum 0xe317e540, Offset: 0x2cd0
    // Size: 0xa0, Type: dev
    function private function_86917977b45de751()
    {
        if ( !utility::flag( "<dev string:x26a>" ) )
        {
            return;
        }
        
        foreach ( scriptable in level.rocket_launch.sfx )
        {
            scriptable setscriptablepartstate( "<dev string:x27c>", "<dev string:x280>" );
        }
    }

#/
