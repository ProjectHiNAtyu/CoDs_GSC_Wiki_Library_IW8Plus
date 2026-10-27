// scripts\mp\training_course_utils.gsc  (hash_7a62a760eea61a84.gscc) (size: 30372 Bytes / 0x76a4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd58a96ae (3582629550)
// size ...... 30372 (0x76a4)
// includes .. 23  (offset: 0x7074)
// strings ... 78  (offset: 0x712c)
// dev strs .. 26  (offset: 0x7554)
// exports ... 121 (offset: 0x4350)
// cseg ...... 0x772 + 0x3bde (0x4350)
// imports ... 217 (offset: 0x5638)
// animtree1 . 0   (offset: 0x76a4)
// animtree2 . 0   (offset: 0x76a4)
#using script_16ea1b94f0f381b3;
#using script_18c2f6d91cbc576a;
#using script_4f7cbc7a2a2ba890;
#using scripts\anim\dialogue;
#using scripts\common\devgui;
#using scripts\common\focus;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\utility\benchmark_mp_utils;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\operator;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\teams;
#using scripts\mp\training_course_stations;

#namespace training_course_utils;

// Namespace training_course_utils
// Params 1
// Checksum 0x3e399137, Offset: 0x790
// Size: 0x49
function function_2943c40f56fbdcdb( player )
{
    player.var_68169330f77d572d = 0;
    
    while ( true )
    {
        if ( player function_7239e2e16c61fb97() )
        {
            player.var_68169330f77d572d = 1;
            wait 4;
            player.var_68169330f77d572d = 0;
        }
        
        waitframe();
    }
}

// Namespace training_course_utils
// Params 1
// Checksum 0xa7ad8a62, Offset: 0x7e1
// Size: 0x49
function function_3df391fe6ea56e70( player )
{
    player.var_68169330f77d572d = 0;
    
    while ( true )
    {
        if ( player function_5fbb364a716a6530() )
        {
            player.var_68169330f77d572d = 1;
            wait 4;
            player.var_68169330f77d572d = 0;
        }
        
        waitframe();
    }
}

// Namespace training_course_utils
// Params 1
// Checksum 0xe8242708, Offset: 0x832
// Size: 0x18, Type: bool
function iscrouching( player )
{
    return player getstance() == "crouch";
}

// Namespace training_course_utils
// Params 1
// Checksum 0xba0ea88d, Offset: 0x853
// Size: 0x12
function issprinting( player )
{
    return player issprinting();
}

// Namespace training_course_utils
// Params 1
// Checksum 0xb04b0077, Offset: 0x86e
// Size: 0x1c, Type: bool
function function_ea0c6158d187ce84( player )
{
    return player issprintsliding() || player isdiving();
}

// Namespace training_course_utils
// Params 1
// Checksum 0xa6dbfc7b, Offset: 0x893
// Size: 0x12
function function_a35365e18eb01e84( player )
{
    return player issprintsliding();
}

// Namespace training_course_utils
// Params 1
// Checksum 0x40b9c299, Offset: 0x8ae
// Size: 0x12
function isdiving( player )
{
    return player isdiving();
}

// Namespace training_course_utils
// Params 1
// Checksum 0x2a1509a9, Offset: 0x8c9
// Size: 0x47, Type: bool
function function_cd38eb9937fdb136( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoright( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) >= 0.8;
}

// Namespace training_course_utils
// Params 1
// Checksum 0x51e99791, Offset: 0x919
// Size: 0x47, Type: bool
function function_e7096335df6c927d( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoleft( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) >= 0.8;
}

// Namespace training_course_utils
// Params 1
// Checksum 0x1190a3da, Offset: 0x969
// Size: 0x47, Type: bool
function function_a6e3df72999a3b25( player )
{
    velocity = vectornormalize( player getvelocity() );
    direction_vector = vectornormalize( anglestoforward( player getplayerangles() ) );
    return vectordot( velocity, direction_vector ) <= -0.8;
}

// Namespace training_course_utils
// Params 3
// Checksum 0x9f2db8dc, Offset: 0x9b9
// Size: 0x33, Type: bool
function function_d77cbbfc99789ed( attacker, meansofdeath, weapon )
{
    return !attacker player::isplayerads() && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x9264f541, Offset: 0x9f5
// Size: 0x32, Type: bool
function function_d492e313412afcee( attacker, meansofdeath, weapon )
{
    return attacker player::isplayerads() && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0xc337fc81, Offset: 0xa30
// Size: 0x36, Type: bool
function function_d775cb09650ab0f9( attacker, meansofdeath, weapon )
{
    return attacker focus::function_5f61a257be5ed024( gettime() ) && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x93dc9864, Offset: 0xa6f
// Size: 0x36, Type: bool
function function_68c70ac70582a0ba( attacker, meansofdeath, weapon )
{
    return attacker getstance() == "crouch" && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x55ececce, Offset: 0xaae
// Size: 0x3b, Type: bool
function function_44f847700d0d15e8( attacker, meansofdeath, weapon )
{
    return utility::ismeleedamage( meansofdeath ) && weapon_utility::isknifeonly( weapon.basename );
}

// Namespace training_course_utils
// Params 3
// Checksum 0xd883741c, Offset: 0xaf2
// Size: 0x36, Type: bool
function function_47a8618216dcc012( attacker, meansofdeath, weapon )
{
    return attacker getstance() == "prone" && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x7fa48df3, Offset: 0xb31
// Size: 0x36, Type: bool
function function_2ef22378faf05561( attacker, meansofdeath, weapon )
{
    return attacker playermount() >= 0.5 && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x4f95ddb3, Offset: 0xb70
// Size: 0x30, Type: bool
function function_b3c46dc14c991111( attacker, meansofdeath, weapon )
{
    return attacker issprintsliding() && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0xb428c176, Offset: 0xba9
// Size: 0x30, Type: bool
function function_86648380ea353c7a( attacker, meansofdeath, weapon )
{
    return attacker isdiving() && utility::isbulletdamage( meansofdeath );
}

// Namespace training_course_utils
// Params 3
// Checksum 0xdd5bec59, Offset: 0xbe2
// Size: 0x32, Type: bool
function function_81291bca475e9c3d( attacker, meansofdeath, weapon )
{
    return isdiving( attacker ) && function_cd38eb9937fdb136( attacker );
}

// Namespace training_course_utils
// Params 3
// Checksum 0xd5e39c7d, Offset: 0xc1d
// Size: 0x32, Type: bool
function function_97b0156c068d8d48( attacker, meansofdeath, weapon )
{
    return isdiving( attacker ) && function_e7096335df6c927d( attacker );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x957c84a6, Offset: 0xc58
// Size: 0x32, Type: bool
function function_5683194eb74523fc( attacker, meansofdeath, weapon )
{
    return isdiving( attacker ) && function_a6e3df72999a3b25( attacker );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x10dafe99, Offset: 0xc93
// Size: 0x1f, Type: bool
function function_469c0a99e6ef3c84( attacker, meansofdeath, weapon )
{
    return false;
}

// Namespace training_course_utils
// Params 3
// Checksum 0x75052107, Offset: 0xcbb
// Size: 0x59
function function_a6e8c085165e0898( player, cached_string_ref, objective_type )
{
    if ( player.var_74936259d5c25c68 )
    {
        player = player.spectating_player;
    }
    
    player setclientomnvar( "training_course_current_objective_string_index", getlocstringindex( cached_string_ref ) );
    player setclientomnvar( "training_course_current_objective_type", objective_type );
}

// Namespace training_course_utils
// Params 1
// Checksum 0xa5201c12, Offset: 0xd1c
// Size: 0x43
function function_5e3e773127f754db( player )
{
    if ( player.var_74936259d5c25c68 )
    {
        player = player.spectating_player;
    }
    
    player setclientomnvar( "training_course_current_objective_string_index", -1 );
    player setclientomnvar( "training_course_current_objective_type", -1 );
}

// Namespace training_course_utils
// Params 1
// Checksum 0x92151b36, Offset: 0xd67
// Size: 0x35, Type: bool
function function_1c1639bf73457e80( player )
{
    if ( player.var_74936259d5c25c68 )
    {
        player = player.spectating_player;
    }
    
    return player getclientomnvar( "training_course_current_objective_string_index" ) != -1;
}

// Namespace training_course_utils
// Params 3
// Checksum 0xac63969c, Offset: 0xda5
// Size: 0x75
function showobjectivemarker( player, objective_marker, origin )
{
    objidpoolmanager::update_objective_position( objective_marker.objidnum, origin );
    objidpoolmanager::objective_playermask_addshowplayer( objective_marker.objidnum, player );
    objidpoolmanager::update_objective_size( objective_marker.objidnum, "icon_medium" );
    objective_marker.origin = origin;
    thread function_9099e762beedc948( player, objective_marker );
}

// Namespace training_course_utils
// Params 1
// Checksum 0xf3f3ad92, Offset: 0xe22
// Size: 0x2b
function hideobjectivemarker( objective_marker )
{
    objidpoolmanager::objective_playermask_hidefromallplayers( objective_marker.objidnum );
    objective_marker notify( #"hidden" );
}

// Namespace training_course_utils
// Params 1
// Checksum 0x2ca81fe1, Offset: 0xe55
// Size: 0x17
function function_49422e31150c2fc9( player )
{
    return player.global_objective_marker;
}

// Namespace training_course_utils
// Params 5
// Checksum 0x3551c451, Offset: 0xe75
// Size: 0x96
function function_7107038b2232bbb2( player, objective_marker, waypoint_position, var_2194257a90af9f5c = undefined, objective_sound )
{
    if ( function_124de228f3c03556( player, waypoint_position ) )
    {
        return;
    }
    
    function_a6e8c085165e0898( player, var_2194257a90af9f5c ? var_2194257a90af9f5c : &"t10_training_course/next_objective", 3 );
    showobjectivemarker( player, objective_marker, waypoint_position );
    objective_marker waittill( #"hash_fc0d26dcd2b34574" );
    hideobjectivemarker( objective_marker );
    function_5e3e773127f754db( player );
    player playlocalsound( objective_sound );
}

// Namespace training_course_utils
// Params 7
// Checksum 0x9aad719, Offset: 0xf13
// Size: 0xf2
function function_9a1f8c96d379aa34( player, objective_marker, roll_position, trigger, waypoint_position, var_2194257a90af9f5c = undefined, objective_sound )
{
    if ( function_124de228f3c03556( player, waypoint_position ) )
    {
        return;
    }
    
    trigger.origin = waypoint_position;
    function_a6e8c085165e0898( player, var_2194257a90af9f5c ? var_2194257a90af9f5c : &"sat_training_course/active_roll_objective", 3 );
    showobjectivemarker( player, objective_marker, roll_position );
    showobjectivemarker( player, player.walljump_marker, waypoint_position );
    
    while ( true )
    {
        objective_marker waittill( #"hash_fc0d26dcd2b34574" );
        
        if ( player isactiverolling() )
        {
            break;
        }
    }
    
    hideobjectivemarker( objective_marker );
    hideobjectivemarker( player.walljump_marker );
    function_5e3e773127f754db( player );
    player playlocalsound( objective_sound );
}

// Namespace training_course_utils
// Params 9
// Checksum 0x135b0d79, Offset: 0x100d
// Size: 0x231
function function_5affed654bd85d67( player, objective_marker, waypoint_position, wall_marker_position, trigger, var_2194257a90af9f5c = undefined, objective_sound, is_dive = 0, var_8572982e37f6c36 )
{
    level endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    smoke_vfx = utility::getfx( var_8572982e37f6c36 );
    trigger.origin = wall_marker_position;
    
    if ( is_dive )
    {
        childthread function_3df391fe6ea56e70( player );
    }
    else
    {
        childthread function_2943c40f56fbdcdb( player );
    }
    
    trigger.is_dive = is_dive;
    ground = trace::ray_trace( waypoint_position, waypoint_position + ( 0, 0, -1000 ) );
    player.vfxstruct = utility::spawn_model( "tag_origin", ground[ "position" ] + ( 0, 0, 1 ) );
    waitframe();
    waitframe();
    playfxontagforclients( smoke_vfx, player.vfxstruct, "tag_origin", player );
    function_a6e8c085165e0898( player, var_2194257a90af9f5c ? var_2194257a90af9f5c : is_dive ? &"sat_training_course/walldive_prompt" : &"sat_training_course/walljump_prompt", 3 );
    showobjectivemarker( player, objective_marker, waypoint_position );
    
    while ( !player.var_68169330f77d572d )
    {
        showobjectivemarker( player, player.walljump_marker, wall_marker_position );
        objective_marker waittill( #"hash_fc0d26dcd2b34574" );
        
        if ( !player.var_69c89982de370a0f )
        {
            player.var_68169330f77d572d = 0;
        }
        
        player.var_69c89982de370a0f = 0;
    }
    
    hideobjectivemarker( objective_marker );
    hideobjectivemarker( player.walljump_marker );
    function_5e3e773127f754db( player );
    player notify( #"walljump_complete" );
    player playlocalsound( objective_sound );
    stopfxontagforclients( smoke_vfx, player.vfxstruct, "tag_origin", player );
    wait 0.7;
    player.vfxstruct delete();
}

// Namespace training_course_utils
// Params 2
// Checksum 0x5d3cd20b, Offset: 0x1246
// Size: 0xbe
function function_95a092e082485aa3( player, trigger )
{
    player endon( #"walljump_complete" );
    player endon( #"disconnect" );
    player endon( #"tutorial_changed" );
    
    if ( !trigger.is_dive && player function_7239e2e16c61fb97() || trigger.is_dive && player function_5fbb364a716a6530() )
    {
        player.var_69c89982de370a0f = 1;
        hideobjectivemarker( player.walljump_marker );
    }
    
    wait 4;
    
    if ( player.walljump_marker )
    {
        showobjectivemarker( player, player.walljump_marker, trigger.origin );
    }
}

// Namespace training_course_utils
// Params 3, eflags: 0x4
// Checksum 0xc719207e, Offset: 0x130c
// Size: 0x95
function private function_9099e762beedc948( player, objective_marker, var_e620d5604e2870d = 150 )
{
    level endon( #"game_ended" );
    objective_marker endon( #"hidden" );
    player endon( #"disconnect" );
    objective_marker notify( #"end" );
    objective_marker endon( #"end" );
    
    while ( true )
    {
        if ( function_124de228f3c03556( player, objective_marker.origin, var_e620d5604e2870d ) )
        {
            objective_marker notify( #"hash_fc0d26dcd2b34574" );
        }
        
        waitframe();
    }
}

// Namespace training_course_utils
// Params 3, eflags: 0x4
// Checksum 0x89e932a3, Offset: 0x13a9
// Size: 0x3b, Type: bool
function private function_124de228f3c03556( player, marker_position, var_e620d5604e2870d = 150 )
{
    return distance( player.origin, marker_position ) <= var_e620d5604e2870d;
}

// Namespace training_course_utils
// Params 5
// Checksum 0xd8d5919b, Offset: 0x13ed
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
        player playlocalsound( "uin_t10_training_course_objective_success" );
    }
}

// Namespace training_course_utils
// Params 1
// Checksum 0x673355d3, Offset: 0x14a3
// Size: 0x19
function function_7b785364ecb1775c( map_instance_index )
{
    return function_dc97518781842988( map_instance_index, "training_course_scene_intro" );
}

// Namespace training_course_utils
// Params 1
// Checksum 0xa66c20b8, Offset: 0x14c5
// Size: 0x19
function function_d18dd74017e9db87( map_instance_index )
{
    return function_dc97518781842988( map_instance_index, "training_course_scene_outro" );
}

// Namespace training_course_utils
// Params 1
// Checksum 0x64814c8d, Offset: 0x14e7
// Size: 0x19
function function_acd7b230b1df93c1( map_instance_index )
{
    return function_dc97518781842988( map_instance_index, "training_course_scene_idle" );
}

// Namespace training_course_utils
// Params 2, eflags: 0x4
// Checksum 0x3a502de1, Offset: 0x1509
// Size: 0x38
function private function_dc97518781842988( map_instance_index, struct_targetname )
{
    instance_map = level.var_714c7ea0347def6a[ map_instance_index ];
    
    if ( isdefined( instance_map ) )
    {
        return instance_map[ struct_targetname ];
    }
}

// Namespace training_course_utils
// Params 3
// Checksum 0x603543aa, Offset: 0x154a
// Size: 0x281
function function_61061c166ccecf71( player, npc_agent, cinematic_root_struct )
{
    player endon( #"disconnect" );
    
    if ( !level.npc_enabled )
    {
        return;
    }
    
    player.var_a7207ed3c6b7e0b6 = 1;
    childthread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 1, 0 );
    player.npc_agent.var_5c11ace5ae14ad8 show();
    
    if ( isdefined( player.npc_agent.var_31a461ef76afc85b ) )
    {
        player.npc_agent.var_31a461ef76afc85b scene::stop();
    }
    
    player.npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
    cinematic_root_struct scene::function_b95eab90f9ebc981( [ player ] );
    cinematic_root_struct thread scene::play( [ player, player.npc_agent, player.npc_agent.wheelchair, player.npc_agent.var_5c11ace5ae14ad8 ], undefined, "t10_mp_training_course_intro_scripted_scene" );
    function_3f46a4fd28a17454( player, undefined );
    function_6427cfa4077010bd( cinematic_root_struct, player.map_instance_index );
    player waittill( #"intro_fade" );
    childthread namespace_9d8e359c3b1041e5::fadetoblackforplayersharedfunc( player, 0, 2 );
    player waittill( #"intro_playercontrol" );
    
    foreach ( weap in player.primaryweapons )
    {
        if ( weaponclass( weap ) == "rifle" )
        {
            player switchtoweaponimmediate( weap );
            break;
        }
    }
    
    function_b6d7c2e57831f94d( cinematic_root_struct, player.map_instance_index );
    function_649644d8af5d56f( player, undefined );
    player.npc_agent.var_5c11ace5ae14ad8 hide();
    thread function_991489897b68327f( player, function_acd7b230b1df93c1( player.map_instance_index ), player.npc_agent );
    function_acd7b230b1df93c1( player.map_instance_index ) thread function_904e69c6ea7095f1( player.npc_agent, 0 );
    player.var_a7207ed3c6b7e0b6 = 0;
}

// Namespace training_course_utils
// Params 3, eflags: 0x4
// Checksum 0x3a75d0d1, Offset: 0x17d3
// Size: 0xab
function private function_991489897b68327f( player, cinematic_root_struct, npc_agent )
{
    level endon( #"game_ended" );
    player endon( #"tutorial_changed" );
    player endon( #"death_or_disconnect" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    timer = 0;
    
    while ( true )
    {
        if ( player getvelocity() != 0 )
        {
            timer = 0;
            waitframe();
            continue;
        }
        
        timer += level.framedurationseconds;
        
        if ( timer >= 10 )
        {
            cinematic_root_struct thread function_904e69c6ea7095f1( npc_agent, 1 );
            break;
        }
        
        waitframe();
    }
}

// Namespace training_course_utils
// Params 2
// Checksum 0xe8a0cea9, Offset: 0x1886
// Size: 0xf0
function function_904e69c6ea7095f1( npc_agent, var_c4e052625118bfa0 )
{
    self notify( #"hash_69e8a8b3884e4a9d" );
    self endon( #"hash_69e8a8b3884e4a9d" );
    cinematic_root_struct = self;
    level endon( #"game_ended" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    npc_agent endon( #"hash_12c1fdad821de6c0" );
    npc_agent notify( #"hash_a252f3f036d289b1" );
    npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
    
    if ( var_c4e052625118bfa0 )
    {
        cinematic_root_struct scene::stop();
        cinematic_root_struct scene::play( [ npc_agent, npc_agent.wheelchair ], "shot_020", "t10_mp_training_course_intro_woods_idle_nag" );
    }
    
    while ( true )
    {
        cinematic_root_struct scene::play( [ npc_agent, npc_agent.wheelchair ], "shot_010", "t10_mp_training_course_intro_woods_idle_nag" );
    }
}

// Namespace training_course_utils
// Params 1, eflags: 0xc
// Checksum 0xe6a93298, Offset: 0x197e
// Size: 0xb0
function private function_f16a23237304761a( npc_agent )
{
    self notify( #"hash_7097b3e20b5a4c47" );
    self endon( #"hash_7097b3e20b5a4c47" );
    cinematic_root_struct = self;
    level endon( #"game_ended" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    npc_agent endon( #"hash_a252f3f036d289b1" );
    npc_agent notify( #"hash_12c1fdad821de6c0" );
    
    while ( true )
    {
        npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
        cinematic_root_struct scene::play( [ npc_agent, npc_agent.wheelchair ], "shot_030", "t10_mp_training_course_intro_woods_idle_nag" );
    }
}

// Namespace training_course_utils
// Params 3
// Checksum 0xd79ac26b, Offset: 0x1a36
// Size: 0x114
function function_5b3639edf841fc69( player, npc_agent, cinematic_root_struct )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    npc_agent endon( #"death" );
    npc_agent endon( #"hash_5bd6fd3710aeca33" );
    npc_agent endon( #"hash_a252f3f036d289b1" );
    
    while ( true )
    {
        if ( distancesquared( player.origin, npc_agent.origin ) > 250000 )
        {
            trace = trace::ray_trace( player geteye(), npc_agent.origin + ( 0, 0, 50 ), player, undefined );
            
            if ( !withinfov( player.origin, player.angles, npc_agent.origin, 0.9 ) || !isdefined( trace[ "entity" ] ) || trace[ "entity" ] != npc_agent )
            {
                cinematic_root_struct thread function_f16a23237304761a( npc_agent );
                break;
            }
        }
        
        waitframe();
    }
}

// Namespace training_course_utils
// Params 0
// Checksum 0xf060c2d2, Offset: 0x1b52
// Size: 0x3, Type: bool
function function_1c1d2c09775c2bea()
{
    return false;
}

// Namespace training_course_utils
// Params 1
// Checksum 0xd383c982, Offset: 0x1b5e
// Size: 0x46, Type: bool
function function_d39dfc7ac04716ef( player )
{
    return level.npc_enabled && !player.var_c9f47db434eca171 && ( getdvarint( @"hash_f44d74c5114354c1", 0 ) || player.training_course_completed );
}

// Namespace training_course_utils
// Params 3
// Checksum 0xa108d2f0, Offset: 0x1bad
// Size: 0x27f
function function_816ecee4d7db0c68( player, cinematic_root_struct, var_d3a838736eab42ad = 1 )
{
    if ( !level.npc_enabled )
    {
        return;
    }
    
    player.var_c9f47db434eca171 = 1;
    
    if ( isdefined( player.current_tutorial ) )
    {
        training_course_stations::exittutorial( player, player.current_tutorial, 0, undefined, 0 );
    }
    
    if ( outofbounds::isoob( player ) )
    {
        outofbounds::clearoob( player, 0 );
    }
    
    player.npc_agent notify( #"hash_5bd6fd3710aeca33" );
    function_48b7033aa12c2f72( player, 1 );
    wait 1;
    player.npc_agent dialogue::stop_dialogue();
    player.npc_agent notify( #"hash_6643ac25fca32e44" );
    function_3f46a4fd28a17454( player, undefined );
    player.npc_agent.var_5c11ace5ae14ad8 show();
    
    if ( isdefined( player.npc_agent.var_31a461ef76afc85b ) )
    {
        player.npc_agent.var_31a461ef76afc85b scene::stop();
    }
    
    function_6427cfa4077010bd( cinematic_root_struct, player.map_instance_index );
    function_471eaf1a49ed9cc9( player, 3 );
    player.npc_agent.var_31a461ef76afc85b = cinematic_root_struct;
    cinematic_root_struct scene::function_b95eab90f9ebc981( [ player ] );
    cinematic_root_struct thread scene::play( [ player, player.npc_agent, player.npc_agent.wheelchair, player.npc_agent.var_5c11ace5ae14ad8 ], undefined, "t10_mp_training_course_outro_scripted_scene" );
    player waittill( #"outro_fade" );
    function_48b7033aa12c2f72( player, 1.5 );
    function_b6d7c2e57831f94d( cinematic_root_struct, player.map_instance_index );
    player disableweapons();
    player.npc_agent hidefromplayer( player );
    player.npc_agent.wheelchair hidefromplayer( player );
    wait 3;
    
    if ( var_d3a838736eab42ad )
    {
        if ( game_utility_mp::matchmakinggame() )
        {
            current_value = player getclientomnvar( "training_course_leave_game_request" );
            player setclientomnvar( "training_course_leave_game_request", !current_value );
        }
        else
        {
            level notify( #"exitlevel_called" );
            exitlevel( 0 );
        }
    }
    
    player.var_c9f47db434eca171 = 0;
}

// Namespace training_course_utils
// Params 2
// Checksum 0x30d3569c, Offset: 0x1e34
// Size: 0x71
function function_6427cfa4077010bd( cinematic_root_struct, map_instance_index )
{
    if ( isdefined( cinematic_root_struct.world_event_name ) )
    {
        activateworldevent( cinematic_root_struct.world_event_name, 1 );
    }
    
    if ( isdefined( level.var_714c7ea0347def6a[ map_instance_index ] ) )
    {
        var_ed1cfa23b1cef2c6 = level.var_714c7ea0347def6a[ map_instance_index ][ "cinematic_shadowcaster" ];
        
        if ( isdefined( var_ed1cfa23b1cef2c6 ) )
        {
            var_ed1cfa23b1cef2c6 show();
        }
    }
}

// Namespace training_course_utils
// Params 2
// Checksum 0xec8a2d01, Offset: 0x1ead
// Size: 0x71
function function_b6d7c2e57831f94d( cinematic_root_struct, map_instance_index )
{
    if ( isdefined( cinematic_root_struct.world_event_name ) )
    {
        deactivateworldevent( cinematic_root_struct.world_event_name, 1 );
    }
    
    if ( isdefined( level.var_714c7ea0347def6a[ map_instance_index ] ) )
    {
        var_ed1cfa23b1cef2c6 = level.var_714c7ea0347def6a[ map_instance_index ][ "cinematic_shadowcaster" ];
        
        if ( isdefined( var_ed1cfa23b1cef2c6 ) )
        {
            var_ed1cfa23b1cef2c6 hide();
        }
    }
}

// Namespace training_course_utils
// Params 4
// Checksum 0xd3981a13, Offset: 0x1f26
// Size: 0x8a
function function_ae849778a0fd4b66( player, enemy, tutorial, var_3585171bd7e4c1a )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    enemy waittill( #"death" );
    tutorial.enemy_array = arrayremove( tutorial.enemy_array, enemy );
    
    if ( tutorial.enemy_array.size == 0 )
    {
        player notify( #"targets_dead" );
    }
}

// Namespace training_course_utils
// Params 1
// Checksum 0x5c84ca99, Offset: 0x1fb8
// Size: 0xb9
function giveloadoutonspawn( player )
{
    player endon( #"death_or_disconnect" );
    player waittill( #"giveloadout" );
    waitframe();
    thread function_2cb67c7fc6e3fed5( player, function_f0999c39797a8308() ? level.loadout_array[ "tactical_br" ] : level.loadout_array[ "tactical_mp" ], level.loadout_array[ "lethal" ], level.loadout_array[ "primary" ], [ level.loadout_array[ "primary_attachments" ] ], level.loadout_array[ "secondary" ], [ level.loadout_array[ "secondary_attachments" ] ], level.melee_weapon_name );
}

// Namespace training_course_utils
// Params 1
// Checksum 0x914dbb39, Offset: 0x2079
// Size: 0x4d
function function_740cfce5f00967a5( player )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    player.killstreak waittill( #"death" );
    wait 1;
    player notify( #"killstreak_death" );
}

// Namespace training_course_utils
// Params 3
// Checksum 0xf170460a, Offset: 0x20ce
// Size: 0x76
function function_28b3ec81efa51820( player, slot, wait_time )
{
    player endon( #"tutorial_changed" );
    player endon( #"targets_dead" );
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"grenade_fire", grenade );
        wait wait_time;
        player equipment_mp::setequipmentslotammo( slot, 1 );
    }
}

// Namespace training_course_utils
// Params 1
// Checksum 0x3099492d, Offset: 0x214c
// Size: 0x27
function killstreak_begin( killstreak )
{
    player = self;
    player.killstreak = killstreak;
}

// Namespace training_course_utils
// Params 1
// Checksum 0xc400e533, Offset: 0x217b
// Size: 0x24
function killstreak_end( killstreak )
{
    player = self;
    player.killstreak = undefined;
}

// Namespace training_course_utils
// Params 1
// Checksum 0x92b91b25, Offset: 0x21a7
// Size: 0x1a
function function_5fec3b2add1b94e0( streakinfo )
{
    streakinfo.disablemarker = 1;
}

// Namespace training_course_utils
// Params 3
// Checksum 0xa3a22b01, Offset: 0x21c9
// Size: 0x37
function function_98702f770499bea1( player, current_targets_hit, var_3e798f5e5d58dd8d )
{
    function_baee265bb13dd11e( player, current_targets_hit, var_3e798f5e5d58dd8d );
    player setclientomnvar( "training_course_show_target_counter", 1 );
}

// Namespace training_course_utils
// Params 2
// Checksum 0xe0fa7422, Offset: 0x2208
// Size: 0x34
function function_c58312077098c9c8( player, delay = 0 )
{
    if ( delay > 0 )
    {
        wait delay;
    }
    
    player setclientomnvar( "training_course_show_target_counter", 0 );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x1e74755a, Offset: 0x2244
// Size: 0x40
function function_baee265bb13dd11e( player, current_targets_hit, var_3e798f5e5d58dd8d )
{
    packed_index = current_targets_hit << 8 | var_3e798f5e5d58dd8d;
    player setclientomnvar( "training_course_current_targets_hit", packed_index );
}

// Namespace training_course_utils
// Params 1
// Checksum 0xdb891727, Offset: 0x228c
// Size: 0x17
function function_ce08700870078f55( player )
{
    return player getclientomnvar( "training_course_show_target_counter" );
}

// Namespace training_course_utils
// Params 1
// Checksum 0x52a37a5a, Offset: 0x22ac
// Size: 0x22
function function_3f5c1e59764b640d( var_2c240cccdbc45e6f )
{
    return { #var_49411d93b2ea3681:[], #var_b6b6603ac7a33cd1:var_2c240cccdbc45e6f };
}

// Namespace training_course_utils
// Params 1
// Checksum 0x55abba0a, Offset: 0x22d7
// Size: 0x12e
function function_402d34de715b6a70( var_37fbd8ffcf5239db )
{
    if ( var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size == 0 )
    {
        var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1 = var_37fbd8ffcf5239db.var_49411d93b2ea3681;
        var_37fbd8ffcf5239db.var_49411d93b2ea3681 = [];
    }
    
    var_e0582ca146e9dcc1 = randomintrange( 0, var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1.size );
    random_element = var_37fbd8ffcf5239db.var_b6b6603ac7a33cd1[ var_e0582ca146e9dcc1 ];
    
    if ( var_37fbd8ffcf5239db.var_9987219c72fa8017 )
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

// Namespace training_course_utils
// Params 5
// Checksum 0xc490a301, Offset: 0x240e
// Size: 0xb2
function function_e79357e1bec9adad( entity, var_29691d75e54312f0, should_interrupt = 1, var_6060be762a9e08e6 = undefined, var_81626ca7ebc7e102 = undefined )
{
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    if ( isplayer( entity ) )
    {
        entity endon( #"disconnect" );
    }
    
    entity endon( #"hash_6643ac25fca32e44" );
    
    if ( var_6060be762a9e08e6 )
    {
        wait var_6060be762a9e08e6;
    }
    
    for ( i = 0; i < var_29691d75e54312f0.size ; i++ )
    {
        if ( entity )
        {
            entity dialogue::say( var_29691d75e54312f0[ i ], should_interrupt, 2.5, 0, var_81626ca7ebc7e102 );
        }
    }
}

// Namespace training_course_utils
// Params 1, eflags: 0x4
// Checksum 0x16426c2a, Offset: 0x24c8
// Size: 0xdd
function private function_7adb5b9ebd7540c3( player )
{
    if ( player.black_overlay )
    {
        return player.black_overlay;
    }
    
    black_overlay = newclienthudelem( player );
    black_overlay.x = 0;
    black_overlay.y = 0;
    black_overlay setshader( "black", 640, 480 );
    black_overlay.alignx = "left";
    black_overlay.aligny = "top";
    black_overlay.sort = 1;
    black_overlay.horzalign = "fullscreen";
    black_overlay.vertalign = "fullscreen";
    black_overlay.foreground = 1;
    player.black_overlay = black_overlay;
    return player.black_overlay;
}

// Namespace training_course_utils
// Params 2
// Checksum 0xda969b06, Offset: 0x25ae
// Size: 0x62
function function_48b7033aa12c2f72( player, time_seconds )
{
    black_overlay = function_7adb5b9ebd7540c3( player );
    
    if ( time_seconds <= 0 )
    {
        black_overlay.alpha = 1;
        return;
    }
    
    black_overlay.alpha = 0;
    black_overlay fadeovertime( time_seconds );
    black_overlay.alpha = 1;
}

// Namespace training_course_utils
// Params 2
// Checksum 0xb14ee3ba, Offset: 0x2618
// Size: 0x61
function function_471eaf1a49ed9cc9( player, time_seconds )
{
    black_overlay = function_7adb5b9ebd7540c3( player );
    
    if ( time_seconds <= 0 )
    {
        black_overlay.alpha = 0;
        return;
    }
    
    black_overlay.alpha = 1;
    black_overlay fadeovertime( time_seconds );
    black_overlay.alpha = 0;
}

// Namespace training_course_utils
// Params 3
// Checksum 0x21b988c3, Offset: 0x2681
// Size: 0x39
function function_52ff81cfdbb3f234( original_origin, original_angles, map_instance_index )
{
    return [ function_d58310d0f1d16d43( original_origin, map_instance_index ), function_2e52e3ebd7fff7bd( original_angles, map_instance_index ) ];
}

// Namespace training_course_utils
// Params 2
// Checksum 0x59a8fa72, Offset: 0x26c3
// Size: 0x59
function function_d58310d0f1d16d43( original_origin, map_instance_index )
{
    instance_map = level.var_714c7ea0347def6a[ map_instance_index ];
    
    if ( instance_map )
    {
        offset_struct = instance_map[ "instance_offset" ];
        
        if ( offset_struct )
        {
            return ( original_origin + offset_struct.origin );
        }
    }
    
    return original_origin;
}

// Namespace training_course_utils
// Params 2
// Checksum 0x8759ac45, Offset: 0x2725
// Size: 0x62
function function_2e52e3ebd7fff7bd( original_angles, map_instance_index )
{
    instance_map = level.var_714c7ea0347def6a[ map_instance_index ];
    
    if ( instance_map )
    {
        offset_struct = instance_map[ "instance_offset" ];
        
        if ( offset_struct.angles )
        {
            return ( original_angles + offset_struct.angles );
        }
    }
    
    return original_angles;
}

// Namespace training_course_utils
// Params 0
// Checksum 0x5ad6414e, Offset: 0x2790
// Size: 0x57
function function_21095a8908de4687()
{
    self.station_number = self.current_tutorial.order_number + 1;
    self.last_station_entered = self.current_tutorial.order_number + 1;
    self.start_time = gettime();
    self.failed_attempts = 0;
}

// Namespace training_course_utils
// Params 2
// Checksum 0x1508c96c, Offset: 0x27ef
// Size: 0x12a
function function_ae1b81443a485a25( was_completed = 0, did_disconnect = 0 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    if ( did_disconnect && self.last_station_entered != -1 )
    {
        dlogevent = "dlog_event_mp_player_training_course_last_station_entered";
        self dlog_recordplayerevent( dlogevent, [ "last_station_entered", self.last_station_entered ] );
    }
    
    if ( !isdefined( self.station_number ) || self.station_number == -1 )
    {
        return;
    }
    
    dlogevent = "dlog_event_mp_player_training_course_station_data";
    ending_reason = was_completed ? "completed" : "quit";
    self dlog_recordplayerevent( dlogevent, [ "station_number", self.station_number, "time_spent", gettime() - self.start_time, "failed_attempts", self.failed_attempts, "ending_reason", ending_reason, "disconnected", did_disconnect ] );
    function_4ea1ebb34b0e0d13();
}

// Namespace training_course_utils
// Params 0, eflags: 0x4
// Checksum 0x51aacd67, Offset: 0x2921
// Size: 0x21
function private function_4ea1ebb34b0e0d13()
{
    self.station_number = -1;
    self.time_spent = 0;
    self.failed_attempts = 0;
}

// Namespace training_course_utils
// Params 2
// Checksum 0xe122bbf5, Offset: 0x294a
// Size: 0x1f
function function_ac53a17fd5b74658( player, cached_string_ref )
{
    thread function_b06367ba6447e8f9( player, cached_string_ref );
}

// Namespace training_course_utils
// Params 2, eflags: 0x4
// Checksum 0x2d417128, Offset: 0x2971
// Size: 0x49
function private function_b06367ba6447e8f9( player, cached_string_ref )
{
    player endon( #"disconnect" );
    player endon( #"hash_47e8102cc99b102a" );
    wait 1;
    
    if ( player )
    {
        player setclientomnvar( "training_course_current_hint_string_index", getlocstringindex( cached_string_ref ) );
    }
}

// Namespace training_course_utils
// Params 1
// Checksum 0x44b016ca, Offset: 0x29c2
// Size: 0x27
function function_55099ffa73b4eff1( player )
{
    player notify( #"hash_47e8102cc99b102a" );
    player setclientomnvar( "training_course_current_hint_string_index", -1 );
}

// Namespace training_course_utils
// Params 1
// Checksum 0xb2d614cf, Offset: 0x29f1
// Size: 0x1a, Type: bool
function function_33427acbfd53222( player )
{
    return player getclientomnvar( "training_course_current_hint_string_index" ) != -1;
}

// Namespace training_course_utils
// Params 2
// Checksum 0x6893ce7e, Offset: 0x2a14
// Size: 0x65
function showfailhint( player, tutorial )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !function_32d334aad6bf0ad3( tutorial ) )
    {
        return;
    }
    
    player setclientomnvar( "training_course_fail_hint_string_index", function_d654ebca885f4644( tutorial ) );
    function_6c0ff087784b7b0( tutorial, undefined );
    wait 5;
    function_df581661be9ca5c5( player );
}

// Namespace training_course_utils
// Params 1
// Checksum 0x2880261b, Offset: 0x2a81
// Size: 0x2b
function function_df581661be9ca5c5( player )
{
    if ( player getclientomnvar( "training_course_fail_hint_string_index" ) != -1 )
    {
        player setclientomnvar( "training_course_fail_hint_string_index", -1 );
    }
}

// Namespace training_course_utils
// Params 2
// Checksum 0x1cf1897b, Offset: 0x2ab4
// Size: 0x3a
function function_6c0ff087784b7b0( tutorial, string_reference )
{
    if ( string_reference )
    {
        tutorial.var_a9ecb0261b0cf3cf = getlocstringindex( string_reference );
        return;
    }
    
    tutorial.var_a9ecb0261b0cf3cf = undefined;
}

// Namespace training_course_utils
// Params 1, eflags: 0x4
// Checksum 0x78a46255, Offset: 0x2af6
// Size: 0x17
function private function_d654ebca885f4644( tutorial )
{
    return tutorial.var_a9ecb0261b0cf3cf;
}

// Namespace training_course_utils
// Params 1
// Checksum 0xa1f9fc9b, Offset: 0x2b16
// Size: 0x15, Type: bool
function function_32d334aad6bf0ad3( tutorial )
{
    return isdefined( function_d654ebca885f4644( tutorial ) );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x7ae1c293, Offset: 0x2b34
// Size: 0xb2
function function_bf3e729263fcc10( bot, agent, initial_wait_time )
{
    bot.spectating_player endon( #"tutorial_changed" );
    bot endon( #"death_or_disconnect" );
    agent endon( #"death" );
    wait initial_wait_time;
    
    if ( bot )
    {
        weapon = bot getcurrentweapon();
        
        if ( weapon )
        {
            wait_time = 0.05;
            weap_fire_time = weaponfiretime( weapon );
            
            if ( weap_fire_time )
            {
                wait_time = max( wait_time, weap_fire_time );
            }
            
            while ( isdefined( bot ) )
            {
                bot botpressbutton( "attack" );
                wait wait_time;
            }
        }
    }
}

// Namespace training_course_utils
// Params 2
// Checksum 0x90c8a162, Offset: 0x2bee
// Size: 0x96
function function_fd6bf4c76734b916( bot, entity )
{
    bot endon( #"death_or_disconnect" );
    bot endon( #"stop_looking" );
    entity endon( #"death" );
    cos_fov_angle = cos( 45 );
    
    while ( true )
    {
        bot botlookatpoint( entity geteye() - ( 0, 0, 15 ), 0.1, "script_forced" );
        
        if ( function_7517ebd4fc6719f0( bot, entity, cos_fov_angle ) )
        {
            bot notify( #"entity_in_view" );
        }
        
        waitframe();
    }
}

// Namespace training_course_utils
// Params 3
// Checksum 0x58d34640, Offset: 0x2c8c
// Size: 0x75
function function_7517ebd4fc6719f0( bot, entity, cos_fov_angle )
{
    trace = trace::ray_trace( bot geteye(), entity geteye(), bot, undefined );
    
    if ( trace[ "entity" ] === entity )
    {
        return withinfov( bot.origin, bot.angles, entity.origin, cos_fov_angle );
    }
    
    return 0;
}

// Namespace training_course_utils
// Params 1
// Checksum 0x845f1f41, Offset: 0x2d0a
// Size: 0x9f
function function_729244fb63340d85( player )
{
    bots = function_8658dfb45f6b84c8( player.map_instance_index );
    
    foreach ( bot in bots )
    {
        if ( !function_1acdd48d868bc909( bot ) )
        {
            return bot;
        }
    }
}

// Namespace training_course_utils
// Params 1, eflags: 0x4
// Checksum 0x911643d9, Offset: 0x2db2
// Size: 0xa8
function private function_c8702ddd4540ea28( player )
{
    bots = function_8658dfb45f6b84c8( player.map_instance_index );
    
    foreach ( bot in bots )
    {
        if ( function_1acdd48d868bc909( bot ) && isalive( bot ) )
        {
            return bot;
        }
    }
}

// Namespace training_course_utils
// Params 4
// Checksum 0x8d945d69, Offset: 0x2e63
// Size: 0xc6
function spawnbot( origin, angles, team = "allies", purpose )
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
    
    newai.purpose = purpose;
    function_f84dc38c3e66bb65( newai );
    newai setorigin( origin );
    newai setplayerangles( angles );
    return newai;
}

// Namespace training_course_utils
// Params 1
// Checksum 0x1f1bbda5, Offset: 0x2f32
// Size: 0xde
function function_f84dc38c3e66bb65( bot )
{
    bot sethidenameplate( 1 );
    bot botsetpathingstyle( "scripted" );
    bot botsetawareness( 0 );
    bot botsetstance( "stand" );
    bot botsetflag( "force_sprint", 1 );
    bot.custom_personality_update_function = &utility::empty_init_func;
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

// Namespace training_course_utils
// Params 1, eflags: 0x4
// Checksum 0xd0259487, Offset: 0x3018
// Size: 0x18, Type: bool
function private function_1acdd48d868bc909( bot )
{
    return istrue( bot.is_meatshield_bot );
}

// Namespace training_course_utils
// Params 1
// Checksum 0xfeed9aa5, Offset: 0x3039
// Size: 0x18
function function_8658dfb45f6b84c8( map_instance_index )
{
    return level.bot_pool[ map_instance_index ];
}

// Namespace training_course_utils
// Params 1
// Checksum 0xfddea01a, Offset: 0x305a
// Size: 0x2d
function function_3e92b89fd90af5ab( player )
{
    return player.team == "allies" ? "axis" : "allies";
}

// Namespace training_course_utils
// Params 8
// Checksum 0x362c0296, Offset: 0x3090
// Size: 0x188
function function_2cb67c7fc6e3fed5( player, tactical, lethal, primary_weapon_name, primary_attachments, secondary_weapon_name, secondary_attachments, melee_weapon_name )
{
    player endon( #"death_or_disconnect" );
    player takeallweapons();
    player equipment_mp::giveequipment( lethal, "primary" );
    player equipment_mp::giveequipment( tactical, "secondary" );
    
    if ( player.current_tutorial.var_85a7b95bc3de3767 )
    {
        [[ player.current_tutorial.var_85a7b95bc3de3767 ]]( player, player.current_tutorial );
    }
    else
    {
        player equipment_mp::setequipmentslotammo( "primary", 0 );
        player equipment_mp::setequipmentslotammo( "secondary", 0 );
        player supers_mp::clearsuper();
        player equipment_mp::takeequipment( "super" );
    }
    
    player class::loadout_clearperks();
    waitframe();
    primary_weapon = weapon::buildweapon( primary_weapon_name, primary_attachments );
    player givemaxammo( primary_weapon );
    player setweaponammostock( primary_weapon, weaponmaxammo( primary_weapon ) );
    player giveweapon( primary_weapon, 0, 0, 0, 1 );
    secondary_weapon = weapon::buildweapon( secondary_weapon_name, secondary_attachments );
    player giveweapon( secondary_weapon, 0, 0, 0, 1 );
    
    if ( melee_weapon_name )
    {
        melee_weapon = weapon::buildweapon( melee_weapon_name );
        player giveweapon( melee_weapon, 0, 0, 0, 1 );
        player assignweaponmeleeslot( melee_weapon );
    }
    
    player switchtoweapon( primary_weapon );
}

// Namespace training_course_utils
// Params 3
// Checksum 0x69f6b040, Offset: 0x3220
// Size: 0xa4
function setplayerviewmodel( player, operator, operator_skin )
{
    models = operator::function_fb2ad6ca3c6b708d( operator_skin );
    player clearcustomization( 1 );
    player setoperatorcustomization( operator, operator_skin );
    player teams::setcharactermodels( models[ 0 ], models[ 1 ], models[ 2 ] );
    
    if ( !isdefined( player.operatorcustomization ) )
    {
        player operator::createoperatorcustomization();
    }
    
    player.operatorcustomization.body = models[ 0 ];
    player.operatorcustomization.head = models[ 1 ];
}

// Namespace training_course_utils
// Params 0
// Checksum 0x97f67735, Offset: 0x32cc
// Size: 0x6a
function function_224cad2522f7a2c2()
{
    if ( !isxhashasset( level.player_operator_skin ) )
    {
        return getxhashasset( getdvar( @"hash_37a6f04d4b24d7be", level.player_operator_skin ) );
    }
    
    operator_skin = getdvar( @"hash_37a6f04d4b24d7be" );
    
    if ( !isdefined( operator_skin ) || operator_skin == "" )
    {
        return level.player_operator_skin;
    }
    
    return getxhashasset( operator_skin );
}

// Namespace training_course_utils
// Params 0
// Checksum 0xa423ac43, Offset: 0x333f
// Size: 0x24
function function_b5652b920118c443()
{
    var_a36d62a331c67428 = [ %"hash_42d7cecef9793e32" ];
    return utility::array_random( var_a36d62a331c67428 );
}

// Namespace training_course_utils
// Params 1
// Checksum 0x4a882f00, Offset: 0x336c
// Size: 0x7a
function function_aa4c8736e7957afd( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    weapon = player getcurrentweapon();
    
    while ( player isreloading() )
    {
        waitframe();
    }
    
    player givemaxammo( weapon );
    player setweaponammostock( weapon, weaponmaxammo( weapon ) );
}

// Namespace training_course_utils
// Params 0
// Checksum 0xa515a078, Offset: 0x33ee
// Size: 0x18, Type: bool
function function_f0999c39797a8308()
{
    return isbrgamemode() || getdvarint( @"hash_83b81973446a1575", 0 );
}

// Namespace training_course_utils
// Params 1
// Checksum 0xdff69669, Offset: 0x340f
// Size: 0xfa
function function_95583a45b8caaba9( player )
{
    player endon( #"disconnect" );
    player utility::ent_flag_wait( "loading_over" );
    player utility::ent_flag_wait( "training_course_tutorials_created" );
    var_85ea2813ba4c6456 = [];
    
    if ( level.var_37f10e1572a7803b )
    {
        foreach ( id_string, tutorial in player.tutorial_dictionary )
        {
            if ( id_string != "emote" )
            {
                var_85ea2813ba4c6456[ id_string ] = tutorial;
            }
        }
    }
    else
    {
        var_85ea2813ba4c6456 = player.tutorial_dictionary;
    }
    
    function_e6c0ed093a236b20( player, function_1c1d2c09775c2bea() ? 15 : 1, var_85ea2813ba4c6456 );
}

// Namespace training_course_utils
// Params 2
// Checksum 0x6606e05, Offset: 0x3511
// Size: 0x4c
function function_3f46a4fd28a17454( player, tutorial )
{
    if ( !isdefined( player.ishudhidden ) )
    {
        player.ishudhidden = 0;
    }
    
    player setclientomnvar( "ui_hide_hud", 1 );
    player.ishudhidden = 1;
}

// Namespace training_course_utils
// Params 2
// Checksum 0x4e652ca6, Offset: 0x3565
// Size: 0x58
function function_649644d8af5d56f( player, tutorial )
{
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

// Namespace training_course_utils
// Params 3
// Checksum 0xf9a52190, Offset: 0x35c5
// Size: 0x5b
function function_dc85cd6a6bf80d4b( player, splash_ref, delay )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait delay;
    player hud_message::function_ccbbac80e736b9f9( splash_ref, undefined, undefined, undefined, undefined, level.gametypebundle.var_e662dd7f27d462eb );
}

// Namespace training_course_utils
// Params 4
// Checksum 0x12c7dec6, Offset: 0x3628
// Size: 0x73
function function_dfb331efe033ac6c( player, tutorial, should_show, play_sound )
{
    packed_index = training_course_stations::function_8b878dec24bedc0e( tutorial ) << 8 | tutorial.order_number;
    player setclientomnvar( "show_training_course_triptychs", should_show ? packed_index : -1 );
    
    if ( play_sound )
    {
        player playlocalsound( "uin_t10_training_course_triptych_screen" );
    }
}

// Namespace training_course_utils
// Params 1
// Checksum 0x3a9cabe2, Offset: 0x36a3
// Size: 0x1a, Type: bool
function function_faa438d8de9a4dc9( player )
{
    return player getclientomnvar( "show_training_course_triptychs" ) != -1;
}

// Namespace training_course_utils
// Params 2
// Checksum 0xf5673267, Offset: 0x36c6
// Size: 0x71
function function_3a0aec7f1e9988a3( player, tutorial )
{
    player hud_message::function_c7ef9b0007b5092d();
    player hud_message::clearsplashqueue();
    
    if ( player.var_bb4f4ac000751f63 == tutorial.order_number )
    {
        training_course_stations::function_8becb86703380fc7( player, tutorial, 0, 1 );
    }
    
    player setclientomnvar( "training_course_in_station_range", training_course_stations::function_8b878dec24bedc0e( tutorial ) << 8 | tutorial.order_number );
}

// Namespace training_course_utils
// Params 2
// Checksum 0x42108ffb, Offset: 0x373f
// Size: 0x5c
function function_5c1689103ca32d82( player, tutorial )
{
    if ( player getclientomnvar( "training_course_in_station_range" ) != -1 )
    {
        player setclientomnvar( "training_course_in_station_range", -1 );
        
        if ( player.var_bb4f4ac000751f63 == tutorial.order_number )
        {
            training_course_stations::function_8becb86703380fc7( player, tutorial, 1, 1 );
        }
    }
}

// Namespace training_course_utils
// Params 0
// Checksum 0xc829fd89, Offset: 0x37a3
// Size: 0x11
function function_fb000aeabac687eb()
{
    return function_f0999c39797a8308() ? 9 : 0;
}

// Namespace training_course_utils
// Params 1
// Checksum 0xedb7d924, Offset: 0x37bd
// Size: 0xa3
function function_e2157f3642beec77( tutorial_order_number )
{
    labels = [ &"t10_training_course/station_1_label", &"t10_training_course/station_2_label", &"t10_training_course/station_3_label", &"t10_training_course/station_4_label", &"t10_training_course/station_5_label", &"t10_training_course/station_6_label", &"t10_training_course/station_7_label", &"t10_training_course/station_8_label" ];
    assert( tutorial_order_number < labels.size, "<dev string:x24>" + tutorial_order_number + "<dev string:x70>" );
    return labels[ tutorial_order_number ];
}

// Namespace training_course_utils
// Params 3
// Checksum 0x334cb7d0, Offset: 0x3869
// Size: 0x198
function function_e6c0ed093a236b20( player, initial_wait_time, tutorial_dictionary )
{
    wait initial_wait_time;
    tutorial_array = [];
    
    foreach ( tutorial in tutorial_dictionary )
    {
        tutorial_array[ tutorial_array.size ] = tutorial;
    }
    
    var_889beba20932b29b = arraysort( tutorial_array, undefined, &function_c25960b107824fa7 );
    assert( var_889beba20932b29b.size <= 15, "<dev string:x72>" );
    var_1bee7348e8012def = int( ceil( var_889beba20932b29b.size / 6 ) );
    
    for ( i = 0; i < var_1bee7348e8012def ; i++ )
    {
        right_side = int( min( var_889beba20932b29b.size, 6 * ( i + 1 ) ) );
        left_side = 1 + 6 * i;
        sent_size = right_side - left_side + 1;
        packed_number = training_course_stations::function_8b878dec24bedc0e( var_889beba20932b29b[ left_side - 1 ] );
        
        for ( j = left_side; j < right_side ; j++ )
        {
            packed_number = packed_number << 4 | training_course_stations::function_8b878dec24bedc0e( var_889beba20932b29b[ j ] );
        }
        
        packed_number = packed_number << 4 | sent_size;
        player setclientomnvar( "training_course_update_tutorial_list", packed_number );
        wait 1.5;
    }
}

// Namespace training_course_utils
// Params 2
// Checksum 0xb19f5853, Offset: 0x3a09
// Size: 0x2c, Type: bool
function function_c25960b107824fa7( leftelement, rightelement )
{
    return leftelement.order_number < rightelement.order_number;
}

// Namespace training_course_utils
// Params 1
// Checksum 0x1d5d9fca, Offset: 0x3a3e
// Size: 0x25b
function luinotifylistener( player )
{
    player endon( #"disconnect" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", msg, arg );
        
        if ( msg == "training_course_leave_game" )
        {
            if ( function_d39dfc7ac04716ef( player ) )
            {
                function_816ecee4d7db0c68( player, function_d18dd74017e9db87( player.map_instance_index ), 1 );
            }
            else
            {
                current_value = player getclientomnvar( "training_course_leave_game_request" );
                player setclientomnvar( "training_course_leave_game_request", !current_value );
            }
            
            continue;
        }
        
        tutorial = player.current_tutorial;
        
        if ( !isdefined( tutorial ) )
        {
            continue;
        }
        
        while ( player isinexecutionvictim() || player isinexecutionattack() )
        {
            waitframe();
        }
        
        if ( msg == "exit_current_training_course_station" && ( training_course_stations::function_d1d2cf69e63f6596( tutorial ) || training_course_stations::function_cbcead310c3cf8bd( tutorial ) || function_faa438d8de9a4dc9( player ) ) )
        {
            if ( training_course_stations::function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 1;
            }
            else
            {
                thread training_course_stations::exittutorial( player, tutorial, 1, undefined, undefined, player.isdisconnecting );
            }
            
            continue;
        }
        
        if ( msg == "triptychs_training_course_station_start" )
        {
            tutorial notify( #"triptychs_training_course_station_start" );
            continue;
        }
        
        if ( msg == "tutorial_station_instructions_training_course" && ( training_course_stations::function_d1d2cf69e63f6596( tutorial ) || training_course_stations::function_cbcead310c3cf8bd( tutorial ) ) )
        {
            if ( training_course_stations::function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 2;
            }
            else
            {
                thread training_course_stations::restarttutorial( player, tutorial, 0, 1, 0, undefined );
            }
            
            continue;
        }
        
        if ( msg == "restart_current_tutorial" && training_course_stations::function_d1d2cf69e63f6596( tutorial ) )
        {
            thread training_course_stations::restarttutorial( player, tutorial, 0, 1, 0, undefined );
            continue;
        }
        
        if ( level.var_9b65db225ac25b95 && msg == "training_course_preview_station" )
        {
            if ( function_faa438d8de9a4dc9( player ) )
            {
                function_dfb331efe033ac6c( player, tutorial, 0, 0 );
            }
            
            if ( training_course_stations::function_cbcead310c3cf8bd( tutorial ) )
            {
                tutorial.fail_state = 0;
            }
            else
            {
                thread training_course_stations::starttutorial( player, tutorial, 0, 1, 1, 0, undefined );
            }
            
            continue;
        }
        
        if ( tutorial.order_number == 5 && msg == "use_spray" )
        {
            player notify( #"used_spray" );
        }
    }
}

/#

    // Namespace training_course_utils
    // Params 1
    // Checksum 0xc1da6ac5, Offset: 0x3ca1
    // Size: 0xd9, Type: dev
    function function_347c90461fb33c06( player )
    {
        thread namespace_a4e869218d89862b::function_18eb5a324873d647( player, 0 );
        thread namespace_6826532b84b72321::function_eccd82ae06166efe( player, 1 );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:xbb>", "<dev string:xc7>", &maprestart, [ "<dev string:xdd>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:xe0>", "<dev string:xc7>", &benchmark_mp_utils::function_6f4cc32a47b35564, [ "<dev string:xee>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:xf0>", "<dev string:xc7>", &benchmark_mp_utils::function_6d90b52e7f66709a, [ "<dev string:x10b>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x112>", "<dev string:xc7>", &benchmark_mp_utils::function_6cf247353c5bcf3, [ "<dev string:x132>" ] );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x138>", "<dev string:xc7>", &benchmark_mp_utils::function_a7dd34380de169ca );
        benchmark_mp_utils::function_58455b481846aefc( "<dev string:x14c>", "<dev string:xc7>", &benchmark_mp_utils::function_6d778e3befe26811 );
        benchmark_mp_utils::function_abeeb86ec4c08184( player );
    }

    // Namespace training_course_utils
    // Params 1
    // Checksum 0xa0552ab, Offset: 0x3d82
    // Size: 0x107, Type: dev
    function initdevgui( tutorial_dictionary )
    {
        devgui::function_9082edeb5db93280( "<dev string:x15c>" );
        
        foreach ( tutorial in tutorial_dictionary )
        {
            tutorial_name = training_course_stations::function_399e310dabe4c2cc( tutorial );
            devgui::function_cd4e263c1f3018ae( "<dev string:x175>" + tutorial_name, "<dev string:x182>" + tutorial_name, &function_97c3481032bc4794 );
        }
        
        devgui::add_devgui_func( "<dev string:x18c>", "<dev string:x1a5>", &function_e0bc9800d93004d9 );
        devgui::add_devgui_func( "<dev string:x1be>", "<dev string:x1d4>", &function_ea7141d81b8cd774 );
        
        if ( level.var_37f10e1572a7803b )
        {
            devgui::add_devgui_func( "<dev string:x1ea>", "<dev string:x1ff>", &function_941a5eef5ac77191 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace training_course_utils
    // Params 1, eflags: 0x4
    // Checksum 0xe402cd47, Offset: 0x3e91
    // Size: 0x91, Type: dev
    function private function_97c3481032bc4794( params )
    {
        if ( !isdefined( level.players[ 0 ] ) )
        {
            return;
        }
        
        tutorial_name = string( params[ 0 ] );
        tutorial = level.players[ 0 ].tutorial_dictionary[ tutorial_name ];
        
        if ( isdefined( tutorial ) )
        {
            level.players[ 0 ] setorigin( tutorial.respawn_position );
            level.players[ 0 ] setplayerangles( tutorial.respawn_angles );
        }
    }

    // Namespace training_course_utils
    // Params 0, eflags: 0x4
    // Checksum 0x46b97db3, Offset: 0x3f2a
    // Size: 0x54, Type: dev
    function private function_e0bc9800d93004d9()
    {
        if ( isdefined( level.players[ 0 ] ) && isdefined( level.players[ 0 ].current_tutorial ) )
        {
            thread training_course_stations::completetutorial( level.players[ 0 ], level.players[ 0 ].current_tutorial );
        }
    }

    // Namespace training_course_utils
    // Params 0, eflags: 0x4
    // Checksum 0x6a7ab553, Offset: 0x3f86
    // Size: 0x143, Type: dev
    function private function_941a5eef5ac77191()
    {
        if ( !isdefined( level.players[ 0 ] ) )
        {
            return;
        }
        
        if ( !level.var_37f10e1572a7803b || !training_course_stations::function_3c77ed00cac74efe( level.players[ 0 ].tutorial_dictionary[ "<dev string:x214>" ] ) )
        {
            return;
        }
        
        if ( isdefined( level.players[ 0 ].current_tutorial ) )
        {
            function_e0bc9800d93004d9();
            waitframe();
        }
        
        foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
        {
            if ( !training_course_stations::function_faefa119842f585b( tutorial ) && training_course_stations::function_8b878dec24bedc0e( tutorial ) != 5 )
            {
                thread training_course_stations::starttutorial( level.players[ 0 ], tutorial, 0, 0, 0, 0, undefined );
                waitframe();
                thread training_course_stations::completetutorial( level.players[ 0 ], tutorial, 0 );
                waitframe();
            }
        }
        
        function_97c3481032bc4794( [ "<dev string:x214>" ] );
    }

    // Namespace training_course_utils
    // Params 0, eflags: 0x4
    // Checksum 0x3bfad99e, Offset: 0x40d1
    // Size: 0xde, Type: dev
    function private function_ea7141d81b8cd774()
    {
        if ( isdefined( level.players[ 0 ].current_tutorial ) )
        {
            function_e0bc9800d93004d9();
            waitframe();
        }
        
        foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
        {
            if ( !training_course_stations::function_faefa119842f585b( tutorial ) )
            {
                thread training_course_stations::starttutorial( level.players[ 0 ], tutorial, 0, 0, 0, 0, undefined );
                waitframe();
                thread training_course_stations::completetutorial( level.players[ 0 ], tutorial, 0 );
                waitframe();
            }
        }
    }

    // Namespace training_course_utils
    // Params 0, eflags: 0x4
    // Checksum 0xbf990fb1, Offset: 0x41b7
    // Size: 0xf, Type: dev
    function private maprestart()
    {
        adddebugcommand( "<dev string:x21a>" );
    }

    // Namespace training_course_utils
    // Params 1
    // Checksum 0x62feac44, Offset: 0x41ce
    // Size: 0xd8, Type: dev
    function function_7464143c7de6c610( targets )
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            foreach ( index, targetdata in targets )
            {
                target = targetdata.target;
                
                if ( isdefined( target ) )
                {
                    print3d( target.origin, "<dev string:x227>" + index + 1, ( 0, 1, 0 ), 1, 1, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace training_course_utils
// Params 0
// Checksum 0x1d100c8f, Offset: 0x42ae
// Size: 0xa1
function function_10cc2b82142318c3()
{
    tutorials = [];
    
    foreach ( tutorial in level.players[ 0 ].tutorial_dictionary )
    {
        if ( isdefined( tutorial.var_fe1e173811f47789 ) )
        {
            tutorials[ tutorials.size ] = tutorial;
        }
    }
    
    return tutorials;
}

