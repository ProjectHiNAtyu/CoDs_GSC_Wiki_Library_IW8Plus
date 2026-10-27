// script_409e412fa44b6c91  (hash_409e412fa44b6c91.gscc) (size: 14591 Bytes / 0x38ff / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc308c78e (3272132494)
// size ...... 14591 (0x38ff)
// includes .. 9   (offset: 0x36c3)
// strings ... 37  (offset: 0x370b)
// dev strs .. 0   (offset: 0x38ff)
// exports ... 40  (offset: 0x261b)
// cseg ...... 0x411 + 0x220a (0x261b)
// imports ... 85  (offset: 0x2c5b)
// animtree1 . 0   (offset: 0x38ff)
// animtree2 . 0   (offset: 0x38ff)
#using scripts\common\damage_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\outline;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\mp_agent;
#using scripts\mp\training_course_utils;

#namespace namespace_512cbd6ffc19387;

// Namespace namespace_512cbd6ffc19387
// Params 2
// Checksum 0x826fec03, Offset: 0x42f
// Size: 0x291, Type: bool
function function_b2c44c2beeec92ac( targets_to_spawn, map_instance_index )
{
    if ( !isdefined( level.world_target_array ) )
    {
        level.world_target_array = [];
    }
    
    if ( !isdefined( level.var_2e61ab2b37d9ba6f ) )
    {
        level.var_2e61ab2b37d9ba6f = [];
    }
    
    foreach ( target_array in targets_to_spawn )
    {
        var_95f80e24c6f710b0 = target_array[ 0 ];
        target_type = target_array[ 1 ];
        origin = target_array[ 2 ];
        angles = target_array[ 3 ];
        var_8ec6c61df26369da = target_array[ 4 ];
        
        if ( target_type == 2 )
        {
            continue;
        }
        
        [ origin, angles ] = training_course_utils::function_52ff81cfdbb3f234( origin, angles, map_instance_index );
        targetdata = spawnstruct();
        targetdata.target_type = target_type;
        targetdata.origin = origin;
        targetdata.angles = angles;
        targetdata.var_8ec6c61df26369da = var_8ec6c61df26369da;
        targetdata.target = undefined;
        
        if ( target_type == 1 )
        {
            targetdata.health = level.var_4c27a30d5434547b;
        }
        else if ( target_type == 2 )
        {
            targetdata.health = level.var_4c27a30d5434547b;
        }
        
        if ( isdefined( targetdata ) )
        {
            foreach ( group_name in var_95f80e24c6f710b0 )
            {
                if ( !isdefined( level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ] ) )
                {
                    level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ] = [];
                }
                
                if ( !isdefined( level.world_target_array[ map_instance_index ] ) )
                {
                    level.world_target_array[ map_instance_index ] = [];
                }
                
                level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ][ level.var_2e61ab2b37d9ba6f[ map_instance_index ][ group_name ].size ] = targetdata;
                level.world_target_array[ map_instance_index ][ level.world_target_array[ map_instance_index ].size ] = targetdata;
            }
        }
    }
    
    return true;
}

// Namespace namespace_512cbd6ffc19387
// Params 2
// Checksum 0x7fc158c5, Offset: 0x6c9
// Size: 0x15b
function function_bdd8b3c85cece6b4( map_instance_index, targetgroup_name )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        if ( targetdata.target_type == 1 )
        {
            targetdata.target = function_139b993fdeb62430( targetdata.origin, targetdata.angles, targetdata.health, targetdata.var_8ec6c61df26369da );
        }
        else if ( targetdata.target_type == 2 )
        {
            targetdata.target = function_bc605a7bf950fe4( targetdata.origin, targetdata.angles, -40, targetdata.health, targetdata.var_8ec6c61df26369da );
        }
        
        if ( isdefined( targetdata.target ) )
        {
            function_ed7e4e390edfa669( targetdata.target, 0 );
        }
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 1, eflags: 0x4
// Checksum 0xded4b21d, Offset: 0x82c
// Size: 0x7e
function private deletetarget( targetdata )
{
    if ( isdefined( targetdata.target ) )
    {
        if ( isdefined( targetdata.target.pingmarker ) )
        {
            targetdata.target.pingmarker destroy();
            targetdata.target.pingmarker = undefined;
        }
        
        targetdata.target delete();
        targetdata.target = undefined;
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0xec8e0681, Offset: 0x8b2
// Size: 0x9f
function private function_db5dd1759303d766( map_instance_index, targetgroup_name )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        deletetarget( targetdata );
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 1
// Checksum 0x3b2c17d1, Offset: 0x959
// Size: 0x88
function function_a028ec2a35d56827( map_instance_index )
{
    foreach ( targetdata in level.world_target_array[ map_instance_index ] )
    {
        deletetarget( targetdata );
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0x42d717e0, Offset: 0x9e9
// Size: 0xad
function private function_2125c1ceca157ae2( map_instance_index, var_71f08fd2cf853161 )
{
    foreach ( targetdata in level.world_target_array[ map_instance_index ] )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            function_ed7e4e390edfa669( target, var_71f08fd2cf853161 );
        }
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 3, eflags: 0x4
// Checksum 0xd3ba023, Offset: 0xa9e
// Size: 0xc5
function private function_2d02218ae92b9b9a( map_instance_index, var_90f374dcdee2f09e, var_5fba7026c242c338 )
{
    foreach ( targetdata in level.world_target_array[ map_instance_index ] )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            function_374d87d39fc4b28f( target, var_5fba7026c242c338 );
            
            if ( var_90f374dcdee2f09e )
            {
                function_dfda46466478db2a( target, undefined );
            }
        }
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 4, eflags: 0x4
// Checksum 0x75fe60a, Offset: 0xb6b
// Size: 0x59
function private function_6bd2fbc188d8c004( player, var_90f374dcdee2f09e, delay_time, var_5fba7026c242c338 )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    wait delay_time;
    thread function_2d02218ae92b9b9a( player.map_instance_index, var_90f374dcdee2f09e, var_5fba7026c242c338 );
}

// Namespace namespace_512cbd6ffc19387
// Params 4
// Checksum 0xdb071954, Offset: 0xbcc
// Size: 0xfb
function function_1852fc4473135ca4( map_instance_index, targetgroup_name, var_9360681aa67fb3d9 = undefined, var_a60e535b918b61cc = undefined )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            target_goup( target );
            target_enableoutline( target, var_a60e535b918b61cc );
            target setcandamage( 1 );
            function_dfda46466478db2a( target, var_9360681aa67fb3d9 );
        }
    }
    
    return targets;
}

// Namespace namespace_512cbd6ffc19387
// Params 2
// Checksum 0xa7e7e321, Offset: 0xcd0
// Size: 0xd7
function function_70bfc41268e6eb1d( map_instance_index, targetgroup_name )
{
    targets = level.var_2e61ab2b37d9ba6f[ map_instance_index ][ targetgroup_name ];
    
    foreach ( targetdata in targets )
    {
        target = targetdata.target;
        
        if ( isdefined( target ) )
        {
            function_42c5592ce8a29c26( target );
            target_disableoutline( target );
            target setcandamage( 0 );
            function_dfda46466478db2a( target, undefined );
        }
    }
    
    return targets;
}

// Namespace namespace_512cbd6ffc19387
// Params 3
// Checksum 0x44fda092, Offset: 0xdb0
// Size: 0x18d
function function_dd238173cc767f87( player, targetgroup_name, amount = undefined )
{
    level endon( #"game_ended" );
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    targets = level.var_2e61ab2b37d9ba6f[ player.map_instance_index ][ targetgroup_name ];
    var_d998843bd69bb6ff = [];
    
    for ( i = 0; i < targets.size ; i++ )
    {
        target = targets[ i ].target;
        
        if ( isdefined( target ) && !target getcandamage() )
        {
            var_d998843bd69bb6ff[ i ] = 1;
        }
    }
    
    if ( var_d998843bd69bb6ff.size == targets.size )
    {
        self notify( #"targets_dead" );
        return;
    }
    
    if ( !isdefined( amount ) )
    {
        amount = targets.size - var_d998843bd69bb6ff.size;
    }
    
    if ( amount > 1 )
    {
        training_course_utils::function_98702f770499bea1( player, 0, amount );
    }
    
    targets_dead = 0;
    
    while ( true )
    {
        for ( i = 0; i < targets.size ; i++ )
        {
            target = targets[ i ].target;
            
            if ( isdefined( target ) && !var_d998843bd69bb6ff[ i ] && !target getcandamage() )
            {
                targets_dead++;
                var_d998843bd69bb6ff[ i ] = 1;
                training_course_utils::function_baee265bb13dd11e( player, targets_dead, amount );
            }
        }
        
        if ( targets_dead >= amount )
        {
            self notify( #"targets_dead" );
            
            if ( training_course_utils::function_ce08700870078f55( player ) )
            {
                training_course_utils::function_c58312077098c9c8( player, 1 );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 4, eflags: 0x4
// Checksum 0x8feff126, Offset: 0xf45
// Size: 0x1cd
function private function_139b993fdeb62430( origin, angles, health = level.var_4c27a30d5434547b, var_8ec6c61df26369da = 1 )
{
    var_c9d386cb6d4f8f03 = 32;
    target = spawn( "script_model", origin );
    target function_b398682b38f521f5( 1 );
    target.angles = angles;
    target setmodel( level.standing_target_model );
    target.health = health;
    target.maxhealth = health;
    target.type = 1;
    target.var_7972880ea8fb5b4c = level.var_3db0c01d529ca46;
    target.var_8ec6c61df26369da = var_8ec6c61df26369da;
    target.attached_models = [];
    target.standing_state = 1;
    
    if ( level.target_arm_model != "" )
    {
        arm = spawn( "script_model", origin );
        arm notsolid();
        target function_b398682b38f521f5( 1 );
        arm.angles = angles;
        arm setmodel( level.target_arm_model );
        arm linkto( target );
        target.attached_models[ target.attached_models.size ] = arm;
    }
    
    target.down_backward_angles = target.angles + ( -90, 0, 0 );
    target.down_forward_angles = target.angles + ( 90, 0, 0 );
    target.up_angles = target.angles;
    return target;
}

// Namespace namespace_512cbd6ffc19387
// Params 5, eflags: 0x4
// Checksum 0x67e36e2, Offset: 0x111b
// Size: 0xe6
function private function_bc605a7bf950fe4( origin, angles, z_offset = 0, health = level.var_9a263f6a24a22e91, var_8ec6c61df26369da = 1 )
{
    origin = ( origin[ 0 ], origin[ 1 ], origin[ 2 ] + z_offset );
    target = spawn( "script_model", origin );
    target.angles = angles;
    target setmodel( level.fixed_target_model );
    target.health = health;
    target.maxhealth = health;
    target.type = 2;
    target.var_7972880ea8fb5b4c = level.var_3db0c01d529ca46;
    target.var_8ec6c61df26369da = var_8ec6c61df26369da;
    return target;
}

// Namespace namespace_512cbd6ffc19387
// Params 1, eflags: 0x4
// Checksum 0xddada181, Offset: 0x120a
// Size: 0x99
function private target_delete( target )
{
    foreach ( model in target.attached_models )
    {
        model delete();
    }
    
    target.attached_models = [];
    target delete();
}

// Namespace namespace_512cbd6ffc19387
// Params 4, eflags: 0x4
// Checksum 0x2ed736bd, Offset: 0x12ab
// Size: 0x12d
function private function_42c5592ce8a29c26( target, backwards = 1, var_71f08fd2cf853161 = 1, instant = 0 )
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
        anim_time = level.target_up_anim_time;
        down_angles = backwards ? target.down_backward_angles : target.down_forward_angles;
        
        if ( instant )
        {
            target.angles = down_angles;
        }
        else
        {
            target rotateto( down_angles, anim_time );
            
            if ( var_71f08fd2cf853161 )
            {
                playsoundatpos( target.origin + ( 0, 0, 10 ), level.var_985afc1a619bdf7c );
            }
        }
    }
    
    target disableaimassist();
    target.standing_state = 2;
    return anim_time;
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0x4c8a27e, Offset: 0x13e1
// Size: 0xd8
function private target_goup( target, var_5fba7026c242c338 = 1 )
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
        anim_time = level.target_up_anim_time;
        target rotateto( target.up_angles, anim_time );
        
        if ( var_5fba7026c242c338 )
        {
            playsoundatpos( target.origin + ( 0, 0, 10 ), level.var_b0bce36ee2f13c0b );
        }
    }
    
    target enableaimassist();
    target.standing_state = 1;
    return anim_time;
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0xd7bdd858, Offset: 0x14c2
// Size: 0x4e
function private target_enableoutline( target, var_a60e535b918b61cc = undefined )
{
    if ( !isdefined( target.outline_id ) )
    {
        target.outline_id = outline::outlineenableforall( target, var_a60e535b918b61cc ?? "outline_nodepth_red", "level_script" );
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 1, eflags: 0x4
// Checksum 0x56404dad, Offset: 0x1518
// Size: 0x3a
function private target_disableoutline( target )
{
    if ( isdefined( target.outline_id ) )
    {
        outline::outlinedisable( target.outline_id, target );
        target.outline_id = undefined;
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0x5b15f215, Offset: 0x155a
// Size: 0x23
function private function_dfda46466478db2a( target, var_78a357bb27545fd4 )
{
    target.ondamagevalidation = var_78a357bb27545fd4;
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0x1b37fc41, Offset: 0x1585
// Size: 0x8c
function private function_374d87d39fc4b28f( target, var_5fba7026c242c338 )
{
    target notify( #"hash_4f194e6fc0613101" );
    
    if ( !target.var_8ec6c61df26369da )
    {
        function_42c5592ce8a29c26( target, 1, var_5fba7026c242c338 );
        target_disableoutline( target );
        target setcandamage( 0 );
        return;
    }
    
    target_goup( target, var_5fba7026c242c338 );
    target_disableoutline( target );
    target setcandamage( 1 );
    target.health = target.maxhealth;
    thread function_71a7c54086f9cd2c( target );
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0xe4b9e8e5, Offset: 0x1619
// Size: 0x65
function private function_ed7e4e390edfa669( target, var_71f08fd2cf853161 )
{
    target notify( #"enter_tutorial_mode" );
    target setcandamage( 0 );
    function_42c5592ce8a29c26( target, 0, var_71f08fd2cf853161, 1 );
    target_disableoutline( target );
    target.var_79a79be0f58aae7f = 1;
    target.var_6615e137ca2bc970 = 0;
    thread function_1980abc5d9a71f67( target );
}

// Namespace namespace_512cbd6ffc19387
// Params 1, eflags: 0x4
// Checksum 0x17d11e2a, Offset: 0x1686
// Size: 0x169
function private function_71a7c54086f9cd2c( target )
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

// Namespace namespace_512cbd6ffc19387
// Params 1, eflags: 0x4
// Checksum 0x1aee803d, Offset: 0x17f7
// Size: 0x25a
function private function_1980abc5d9a71f67( target )
{
    level endon( #"game_ended" );
    target endon( #"delete" );
    target endon( #"hash_4f194e6fc0613101" );
    
    while ( true )
    {
        target waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, var_7edd83e15d43a9b0 );
        
        if ( weapon.offhandtype == "secondary" && isdefined( attacker ) )
        {
            equipment_ref = attacker equipment_mp::getcurrentequipment( "secondary" );
            
            if ( equipment_ref === level.mp_tactical_equipment || equipment_ref == level.br_tactical_equipment )
            {
                continue;
            }
        }
        
        if ( damage_effects::function_1e948faff668cf2( meansofdeath ) )
        {
            continue;
        }
        
        if ( isdefined( target.ondamagevalidation ) && ![[ target.ondamagevalidation ]]( attacker, meansofdeath, weapon ) )
        {
            if ( isplayer( attacker ) )
            {
                target playsoundtoplayer( level.var_4304404996b50194, attacker );
            }
            
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
            
            if ( isplayer( attacker ) )
            {
                target playsoundtoplayer( level.var_8487ce72cc048693, attacker );
            }
            
            target.var_6615e137ca2bc970 = 0;
        }
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 2, eflags: 0x4
// Checksum 0x91a335ff, Offset: 0x1a59
// Size: 0x60
function private function_7cef94a8490b6371( attacker_angles, target_angles )
{
    attacker_forward = vectornormalize( anglestoforward( attacker_angles ) );
    target_forward = vectornormalize( anglestoforward( target_angles ) );
    damage_dot_product = vectordot( attacker_forward, target_forward );
    is_behind_target = damage_dot_product >= 0;
    return is_behind_target;
}

// Namespace namespace_512cbd6ffc19387
// Params 3, eflags: 0x4
// Checksum 0x2da2f412, Offset: 0x1ac2
// Size: 0x6b
function private showhitmarker( attacker, victim, is_dead )
{
    attacker damagefeedback::updatehitmarker( "standard", is_dead, 0, 0, undefined, undefined, undefined, undefined, 1, undefined, 1 );
    attacker utility::callsharedfunc( #"hud", #"hash_84d4f784de00c6af", is_dead ? 1 : 0, { #victimentity:victim } );
}

// Namespace namespace_512cbd6ffc19387
// Params 8
// Checksum 0xb5bb74b8, Offset: 0x1b35
// Size: 0x232
function spawnagent( origin, angles, health, team, add_outline = 0, body_model, head_model, hat_model )
{
    agent = mp_agent::spawnnewagentaitype( "enemy_sat_mp_training_course_bot", origin, angles );
    agent.team = team;
    agent.health = health;
    agent.cannotmelee = 1;
    agent.disablebulletwhizbyreaction = 1;
    agent setcanusecover( 0 );
    agent.disablerunngun = 1;
    agent.disabledodge = 1;
    agent.aggressivemode = 0;
    agent.var_63f1ffef1eafa4e4 = 1;
    agent.allowlongdeath = 0;
    agent.agent_damage_callback = &function_2d459ce49ce8b45e;
    agent.var_1bf926518b0cb33 = 1;
    agent.allowpain = 0;
    agent.agentdamagefeedback = 1;
    agent enabletraversals( 0 );
    agent utility::set_movement_speed( 0 );
    agent.scripted_mode = 1;
    agent.ignoreme = 1;
    agent agent_utils::ai_blockexecution( 1 );
    
    if ( add_outline )
    {
        outline::outlineenableforall( agent, "outline_nodepth_red", "level_script" );
    }
    
    if ( agent.headmodel && head_model )
    {
        agent detach( agent.headmodel );
        agent.headmodel = undefined;
        agent attach( head_model, "", 1 );
        agent.headmodel = head_model;
    }
    
    if ( agent.hatmodel )
    {
        agent detach( agent.hatmodel );
        agent.hatmodel = undefined;
    }
    
    if ( body_model )
    {
        agent setmodel( body_model );
    }
    
    if ( hat_model && hat_model != "" )
    {
        agent attach( hat_model, "", 1 );
        agent.hatmodel = hat_model;
    }
    
    return agent;
}

// Namespace namespace_512cbd6ffc19387
// Params 1
// Checksum 0x5fae69ca, Offset: 0x1d70
// Size: 0x1e
function despawnagent( agent )
{
    if ( isalive( agent ) )
    {
        agent agent_utils::despawnagent();
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 3
// Checksum 0xc419605c, Offset: 0x1d96
// Size: 0x14c
function spawnnpc( player, origin, angles )
{
    woods_model = spawn( "script_model", origin );
    woods_model setmodel( "fullbody_mp_hero_wood_training_course" );
    woods_model.targetname = "yanim_Woods";
    woods_model solid();
    woods_model.script_animname = woods_model.targetname;
    woods_model.team = player.team;
    wheelchair = spawn( "script_model", origin );
    wheelchair setmodel( "c_t10_usa_hero_woods_safehouse_wheelchair_01_anim" );
    wheelchair.targetname = "yanim_Wheelchair";
    wheelchair.script_animname = wheelchair.targetname;
    wheelchair solid();
    woods_model.wheelchair = wheelchair;
    var_5c11ace5ae14ad8 = spawn( "script_model", origin );
    var_5c11ace5ae14ad8 setmodel( "wpn_wm_p01_ar_coslo723_training_course" );
    var_5c11ace5ae14ad8.targetname = "yanim_Gun";
    var_5c11ace5ae14ad8.script_animname = var_5c11ace5ae14ad8.targetname;
    var_5c11ace5ae14ad8 solid();
    var_5c11ace5ae14ad8 hide();
    woods_model.var_5c11ace5ae14ad8 = var_5c11ace5ae14ad8;
    return woods_model;
}

// Namespace namespace_512cbd6ffc19387
// Params 0
// Checksum 0x414476c0, Offset: 0x1eeb
// Size: 0x8a
function function_cf5c6d1b5b216a8e()
{
    return [ "dx_bc_panc_tcac_pan1_moving", "dx_bc_panc_tcac_pan2_moving", "dx_bc_panc_tcac_pan3_moving", "dx_bc_panc_tcac_pan1_immoving", "dx_bc_panc_tcac_pan2_immoving", "dx_bc_panc_tcac_pan3_immoving", "dx_bc_panc_tcac_pan1_pushingup", "dx_bc_panc_tcac_pan2_pushingup", "dx_bc_panc_tcac_pan3_pushingup", "dx_bc_panc_tcac_pan1_pushingforward", "dx_bc_panc_tcac_pan2_pushingforward", "dx_bc_panc_tcac_pan3_pushingforward", "dx_bc_panc_tcac_pan1_movingup", "dx_bc_panc_tcac_pan2_movingup", "dx_bc_panc_tcac_pan3_movingup" ];
}

// Namespace namespace_512cbd6ffc19387
// Params 5
// Checksum 0x6effe67f, Offset: 0x1f7e
// Size: 0x97
function function_f7e26bf874373e37( player, entity, shader, alpha = 1, y_offset = 0 )
{
    pingmarker = newclienthudelem( player );
    pingmarker.alpha = alpha;
    pingmarker setshader( shader, 128, 128 );
    pingmarker setwaypoint( 1, 1, 0, 0 );
    pingmarker linkwaypointtotargetwithoffset( entity, ( 0, 0, y_offset ) );
    entity.pingmarker = pingmarker;
    return pingmarker;
}

// Namespace namespace_512cbd6ffc19387
// Params 0
// Checksum 0x9a30dffb, Offset: 0x201e
// Size: 0x4, Type: bool
function function_e8d6f6d526d3e9d2()
{
    return true;
}

// Namespace namespace_512cbd6ffc19387
// Params 2
// Checksum 0x7332cf6c, Offset: 0x202b
// Size: 0x23
function function_b3d358f2f43b564c( agent, value )
{
    agent.magicbulletshield = value;
}

// Namespace namespace_512cbd6ffc19387
// Params 3
// Checksum 0x5c220e75, Offset: 0x2056
// Size: 0x8c
function function_d42a29e61dd9e610( agent, player, damage_amount )
{
    player endon( #"tutorial_changed" );
    agent endon( #"death" );
    player endon( #"death_or_disconnect" );
    
    if ( !agent tagexists( "tag_flash" ) )
    {
        return;
    }
    
    function_bc2d17578622fd93( agent, player, 0 );
    wait 0.2;
    player dodamage( damage_amount, agent.origin, agent, undefined, "MOD_RIFLE_BULLET", agent.primaryweapon );
}

// Namespace namespace_512cbd6ffc19387
// Params 3
// Checksum 0x7d27107e, Offset: 0x20ea
// Size: 0xd0
function function_bc2d17578622fd93( agent, player, var_c970e33ca7a31862 )
{
    agent shoot( 0, player, 1, 0, 1 );
    end = player geteye();
    start = agent.origin + ( 0, 0, 40 );
    
    if ( agent tagexists( "tag_flash" ) == 1 )
    {
        start = agent gettagorigin( "tag_flash" );
        playfx( utility::getfx( "vfx_muzzle_flash" ), start, anglestoforward( start ), anglestoup( start ) );
    }
    
    if ( var_c970e33ca7a31862 )
    {
        magicbullet( agent.primaryweapon, start, player.origin + ( 0, 0, 15 ), agent );
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 14
// Checksum 0x7b34b5b3, Offset: 0x21c2
// Size: 0x147
function function_2d459ce49ce8b45e( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( self.damage_validation_func )
    {
        return ( function_bbcd7f83bcda79a5( eattacker, smeansofdeath, objweapon ) ? 999 : 0 );
    }
    
    if ( self.turret_damage_only && sweapon.classname == "turret" )
    {
        return idamage;
    }
    
    if ( self.var_a6537bd86d98c4c3 && smeansofdeath == "MOD_GRENADE_SPLASH" || self.allow_execution && smeansofdeath == "MOD_EXECUTION" )
    {
        return 999;
    }
    
    if ( smeansofdeath == "MOD_EXPLOSIVE" && self.var_24a1420909f74bf4 )
    {
        return idamage;
    }
    
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

// Namespace namespace_512cbd6ffc19387
// Params 3
// Checksum 0x30a41d5b, Offset: 0x2312
// Size: 0x84
function function_bbcd7f83bcda79a5( eattacker, smeansofdeath, objweapon )
{
    var_5f64f9d265ee7357 = self [[ self.damage_validation_func ]]( eattacker, smeansofdeath, objweapon );
    
    if ( !isplayer( eattacker ) )
    {
        eattacker = eattacker.owner;
    }
    
    if ( eattacker && isplayer( eattacker ) )
    {
        eattacker playsoundtoplayer( var_5f64f9d265ee7357 ? level.var_8487ce72cc048693 : level.var_4304404996b50194, eattacker );
    }
    
    return var_5f64f9d265ee7357;
}

// Namespace namespace_512cbd6ffc19387
// Params 9
// Checksum 0xdce7d92f, Offset: 0x239f
// Size: 0xf1
function function_2e48a30dec1b5d77( player, agent, success, success_wait_time, fail_wait_time, success_damage, fail_damage, var_526b354c2ff59e1, var_54aa554c327b5cf )
{
    player endon( #"tutorial_changed" );
    agent endon( #"death" );
    player endon( #"disconnect" );
    wait success ? success_wait_time : fail_wait_time;
    
    while ( true )
    {
        trace = trace::ray_trace( agent geteye(), player geteye(), agent, undefined );
        
        if ( trace[ "entity" ] === player )
        {
            var_65c55325765f1984 = success ? success_damage : fail_damage;
            thread function_d42a29e61dd9e610( agent, player, var_65c55325765f1984 );
            
            if ( isalive( player ) )
            {
                wait randomfloatrange( var_526b354c2ff59e1, var_54aa554c327b5cf );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 2
// Checksum 0x93c9724b, Offset: 0x2498
// Size: 0x15a
function function_627eacd3e7dbf412( player, var_e3a1280cc76fafc8 )
{
    player endon( #"tutorial_changed" );
    player endon( #"disconnect" );
    corpses = function_955f614470e71cb2( player.origin, 4000, 1 );
    
    if ( corpses.size == 0 )
    {
        return;
    }
    
    while ( true )
    {
        foreach ( index, corpse in corpses )
        {
            if ( !isdefined( corpse ) )
            {
                continue;
            }
            
            var_4a1e4cdbe9485a48 = vectornormalize( corpse.origin - player geteye() );
            dotproduct = vectordot( vectornormalize( anglestoforward( player.angles ) ), var_4a1e4cdbe9485a48 );
            
            if ( dotproduct < 0.5 && distancesquared( player.origin, corpse.origin ) >= var_e3a1280cc76fafc8 )
            {
                corpse delete();
                corpses[ index ] = undefined;
            }
        }
        
        if ( corpses.size == 0 )
        {
            break;
        }
        
        wait 1;
    }
}

// Namespace namespace_512cbd6ffc19387
// Params 1
// Checksum 0xc28b57b8, Offset: 0x25fa
// Size: 0x21
function function_c06c98d7da9ead59( player )
{
    function_a62e9fb7be9ff0a6( player.origin, 4000, 1 );
}

